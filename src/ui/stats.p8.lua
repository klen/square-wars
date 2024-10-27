stats = entity:create {
  players = {},
  draw = function(_ENV)
    local icons, w = { "p", "2", "3", "4" }, 49
    for p in all(players) do
      w = print(icons[p.n] .. ":" .. #p.t, w + 3, 121, colors[p.c])
    end
  end,
}
