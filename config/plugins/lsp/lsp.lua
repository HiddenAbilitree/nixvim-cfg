local border = {
  { '┌', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '┐', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '┘', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '└', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function path_join(...)
  return table.concat({ ... }, package.config:sub(1, 1))
end

local function is_absolute(path)
  return path:sub(1, 1) == '/' or path:match('^%a:[/\\]') ~= nil
end

local function executable(path)
  local stat = vim.uv.fs_stat(path)
  if not stat or stat.type ~= 'file' then
    return false
  end

  return vim.fn.executable(path) == 1
end

local function venv_python(venv)
  local candidates = {
    path_join(venv, 'bin', 'python'),
    path_join(venv, 'Scripts', 'python.exe'),
  }

  for _, python in ipairs(candidates) do
    if executable(python) then
      return python
    end
  end
end

local function project_venv_candidates(root_dir)
  local candidates = {}
  local uv_project_environment = vim.env.UV_PROJECT_ENVIRONMENT

  if uv_project_environment and uv_project_environment ~= '' then
    if is_absolute(uv_project_environment) then
      table.insert(candidates, uv_project_environment)
    else
      table.insert(candidates, path_join(root_dir, uv_project_environment))
    end
  end

  table.insert(candidates, path_join(root_dir, '.venv'))
  table.insert(candidates, path_join(root_dir, 'venv'))

  return candidates
end

local function find_project_python(root_dir)
  if not root_dir or root_dir == '' then
    return
  end

  for _, venv in ipairs(project_venv_candidates(root_dir)) do
    local python = venv_python(venv)
    if python then
      return python
    end
  end
end

function _G.__nixvim_python_lsp_before_init(_, config)
  local python = find_project_python(config.root_dir)
  if not python then
    return
  end

  if config.name == 'pyright' then
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    config.settings.python.pythonPath = python
  elseif config.name == 'pylsp' then
    config.settings = config.settings or {}
    config.settings.pylsp = config.settings.pylsp or {}
    config.settings.pylsp.plugins = config.settings.pylsp.plugins or {}
    config.settings.pylsp.plugins.jedi = config.settings.pylsp.plugins.jedi or {}
    config.settings.pylsp.plugins.jedi.environment = python
  end
end

local tailwind_canonical_diagnostic_code = 'suggestCanonicalClasses'

local function lsp_clients(opts)
  if vim.lsp.get_clients then
    return vim.lsp.get_clients(opts)
  end

  return vim.lsp.get_active_clients(opts)
end

local function supports_code_action(client, bufnr)
  if client.supports_method then
    return client:supports_method('textDocument/codeAction', bufnr)
  end

  return client.server_capabilities and client.server_capabilities.codeActionProvider
end

local function tailwind_clients(bufnr)
  return vim.tbl_filter(function(client)
    return supports_code_action(client, bufnr)
  end, lsp_clients({ bufnr = bufnr, name = 'tailwindcss' }))
end

local function tailwind_canonical_diagnostics(bufnr)
  local diagnostics = {}

  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    local lsp_diagnostic = diagnostic.user_data and diagnostic.user_data.lsp
    local code = lsp_diagnostic and lsp_diagnostic.code or diagnostic.code

    if code == tailwind_canonical_diagnostic_code and lsp_diagnostic then
      table.insert(diagnostics, lsp_diagnostic)
    end
  end

  return diagnostics
end

local function full_buffer_code_action_params(bufnr, diagnostics)
  local last_line = math.max(vim.api.nvim_buf_line_count(bufnr) - 1, 0)
  local last_line_text = vim.api.nvim_buf_get_lines(bufnr, last_line, last_line + 1, true)[1] or ''

  return {
    textDocument = {
      uri = vim.uri_from_bufnr(bufnr),
    },
    range = {
      start = {
        line = 0,
        character = 0,
      },
      ['end'] = {
        line = last_line,
        character = #last_line_text,
      },
    },
    context = {
      diagnostics = diagnostics,
      only = { 'quickfix' },
    },
  }
end

local function is_tailwind_canonical_action(action)
  if not action or not action.edit then
    return false
  end

  for _, diagnostic in ipairs(action.diagnostics or {}) do
    if diagnostic.code == tailwind_canonical_diagnostic_code then
      return true
    end
  end

  return false
end

local function edit_key(edit)
  local range = edit.range
  return table.concat({
    range.start.line,
    range.start.character,
    range['end'].line,
    range['end'].character,
    edit.newText,
  }, ':')
end

local function add_text_edits(edits, seen, text_edits)
  for _, edit in ipairs(text_edits or {}) do
    local key = edit_key(edit)
    if not seen[key] then
      seen[key] = true
      table.insert(edits, edit)
    end
  end
end

local function collect_current_buffer_edits(actions, uri)
  local edits = {}
  local seen = {}

  for _, action in ipairs(actions or {}) do
    if is_tailwind_canonical_action(action) then
      if action.edit.changes then
        add_text_edits(edits, seen, action.edit.changes[uri])
      end

      for _, document_change in ipairs(action.edit.documentChanges or {}) do
        if document_change.textDocument and document_change.textDocument.uri == uri then
          add_text_edits(edits, seen, document_change.edits)
        end
      end
    end
  end

  return edits
end

local function apply_tailwind_canonical_classes(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return false
  end

  local clients = tailwind_clients(bufnr)
  if vim.tbl_isempty(clients) then
    return false
  end

  local diagnostics = tailwind_canonical_diagnostics(bufnr)
  if vim.tbl_isempty(diagnostics) then
    return false
  end

  local uri = vim.uri_from_bufnr(bufnr)
  local params = full_buffer_code_action_params(bufnr, diagnostics)

  for _, client in ipairs(clients) do
    local response = client:request_sync('textDocument/codeAction', params, 1000, bufnr)
    if response and not response.err then
      local edits = collect_current_buffer_edits(response.result, uri)

      if not vim.tbl_isempty(edits) then
        vim.lsp.util.apply_workspace_edit({
          changes = {
            [uri] = edits,
          },
        }, client.offset_encoding or client.encoding or 'utf-16')

        return true
      end
    end
  end

  return false
end

_G.__nixvim_apply_tailwind_canonical_classes = apply_tailwind_canonical_classes

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('nixvim_tailwind_canonical_classes', { clear = true }),
  desc = 'Apply Tailwind canonical-class quickfixes before saving',
  callback = function(args)
    apply_tailwind_canonical_classes(args.buf)
  end,
})

vim.api.nvim_create_user_command('TailwindFixCanonicalClasses', function()
  apply_tailwind_canonical_classes(vim.api.nvim_get_current_buf())
end, {
  desc = 'Apply Tailwind canonical-class quickfixes in the current buffer',
})
