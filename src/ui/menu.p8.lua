Menu = Ent:create {
  y = 68,
  sel = 1,
  dir = { -1, 1, -1, 1, 1, 1 },

  init = function(_ENV, items)
    opts = {}
    foreach(items, function(t)
      if not t.hide then
        t.idx = #opts
        t.y = y
        add(opts, Opt:new(t))
      end
    end)
    if #opts > 0 then
      sel = #opts
      _ENV:move(1)
    end
  end,

  update = function(_ENV)
    if sel == 0 then
      return
    end

    local opt, btn = opts[sel], getbtn()
    local d = dir[btn + 1]

    if btn == -1 then
      return
    end

    beep()

    if btn == 2 or btn == 3 then
      _ENV:move(d)
    else
      opt:cb(d, btn)
    end
  end,

  move = function(_ENV, d)
    repeat
      sel = (sel - 1 + d) % #opts + 1
    until opts[sel].off ~= true
  end,

  draw = function(_ENV)
    for idx, opt in ipairs(opts) do
      opt:draw(idx == sel)
    end
  end,
}

Opt = Ent:create {
  c = 12,
  y = 76,
  n = "",
  idx = 0,
  cb = noop,
  draw = function(_ENV, sel)
    local _n = type(n) == "function" and n() or n
    if sel then
      print("❎", 4, y + 8 * idx, band(FRMS, 8) == 0 and 1 or c)
    end
    print(_n, 17, y + 1 + 8 * idx, 0)
    print(_n, 16, y + 8 * idx, off and 1 or c)
  end,
}
