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
