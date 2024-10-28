typewriter = entity:create {
  txt = "",
  speed = 2,
  x = 8,
  y = 8,
  c = 7,

  draw = function(_ENV)
    local _txt = ""
    for ch in all(txt) do
      if ch == " " then
        _txt ..= " "
      else
        local r = rnd { "a", "e", "b" }
        _txt ..= "\a63" .. r .. " \^" .. speed .. ch
      end
    end
    print(_txt, x, y, c)

    draw = function() print(txt, x, y, c) end
  end,
}
