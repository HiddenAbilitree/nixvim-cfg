-- does not work
s({trig="env", snippetType="snippet", dscr="Begin and end an arbitrary environment"},
    fmta(
        [[
        \begin{<>}
            <>
        \end{<>}
        ]],
        {i(1),i(2),rep(1),}
    )
),
