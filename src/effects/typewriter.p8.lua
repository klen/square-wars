Tw = Ent:create {
  x = 6,
  y = 6,
  c = 7,
  sd = 1,
  txt = "",

  draw = function(_ENV)
    local _txt, _ch = ctrl .. "ya", ""
    for ch in all(txt) do
      if ch == " " or ch == "\n" then
        _txt ..= ch
        if _ch ~= ch then
          _txt ..= ctrl .. "3"
        end
      else
        local r = rnd { "a", "e", "b", "c", "d" }
        _txt ..= "\as1i1v2" .. r .. "1 " .. ctrl .. sd .. ch
      end
      _ch = ch
    end
    print(_txt, x, y, c)

    draw = function()
      print(ctrl .. "ya" .. txt, x, y, c)
    end
  end,
}
