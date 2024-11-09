Stars = Ent:create {
  warp = 3,
  cols = { 1, 2, 5, 6, 7, 12 },

  init = function(_ENV)
    stars = {}
    for l = 1, 3 do
      for j = 1, (6 - l) ^ 2 do
        add(stars, {
          x = rnd(128),
          y = rnd(128),
          c = rnd(cols),
          l = l,
        })
      end
    end
  end,

  update = function(_ENV)
    foreach(stars, function(s)
      s.y += s.l * warp / 10
      if s.y > 128 then
        s.y = 0
        s.x = rnd(128)
        s.c = rnd(cols)
      end
    end)
  end,

  draw = function(_ENV)
    foreach(stars, function(s)
      local l = s.l - 1
      rectfill(s.x, flr(s.y), s.x + l, flr(s.y) + l, s.c)
    end)
  end,
}

Crawl = Ent:create {
  txt = "",
  y = 142,
  s = 0.3,
  init = function(_ENV)
    stars = {}
    for i = 1, 42 do
      add(stars, {
        x = rnd(128),
        y = rnd(128),
        b = rnd(4) + 4,
      })
    end
  end,
  update = function(_ENV)
    y -= s
  end,
  draw = function(_ENV)
    foreach(stars, function(s)
      pset(s.x, s.y, band(FRMS, s.b) == 0 and 5 or 1)
    end)
    print(ctrl .. "y8" .. txt, 9, flr(y) + 1, 0)
    print(ctrl .. "y8" .. txt, 8, flr(y), 12)
  end,
}
