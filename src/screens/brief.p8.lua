function brief(n)
  if stat(24) <= 0 then
    music(0, 1000)
  end
  pal(0)
  cls()

  local pw, md = dget(CART.power), MISSIONS[n]
  local mw = pw | (md.pwr or pw)

  if md.c then
    return custom_brief(n, md)
  end

  -- setup menu
  menuitem(1, "restart mission ", part(brief, n))

  -- reset campaign data
  if n == 1 then
    pw, mw = 0, 0
    dset(CART.time, 0)
    dset(CART.score, 0)
    dset(CART.power, 0)
    dset(CART.mission, 0)
  end

  SCENE = {
    art(frame),
    Tw:new { txt = "mission " .. n .. ' "' .. md.n .. '"' },
    Tw:new { txt = md.b, y = 28 },
    Conf:new {
      txt = "confirm",
      cb = function()
        md.j.num = n
        game(md.f, md.j, mw)
      end,
    },
    pw > 0 and art(function()
      for c = 1, #COLORS do
        if pw & (1 << (c - 1)) > 0 then
          print("◆", 121 - (c * 6), 101, COLORS[c])
        end
      end
    end) or nil,
  }

  if md.o then
    local bscn = SCENE
    credits(md.o, function()
      cls()
      SCENE = bscn
    end)
  end
end

function custom_brief(n, md)
  local pwr, CNAMES = dget(CART.power), split "snow,fire,desert,sun,woods,storm"
  if pwr & 63 == 63 then
    return brief(14)
  end

  local opts = {}
  for i = 1, 6 do
    local c = 6 + i
    local off = pwr & (1 << (i - 1)) > 0
    add(opts, {
      c = c,
      n = CNAMES[i] .. (off and " (done)" or ""),
      off = off,
      cb = part(brief, c + 1),
    })
  end

  SCENE = {
    art(function()
      cls()
      frame(73)
    end),

    Tw:new { txt = md.n },
    Tw:new { txt = md.b, y = 24 },

    Menu:new({ y = 82 }, opts),
  }
end

function credits(txt, cb)
  local cr = Crawl:new { txt = txt }
  local lns = split(cr.txt, "\n")
  SCENE = {
    art(cls),
    cr,
    Ent:new {
      update = function()
        if cr.y < -#lns * 8 then
          cb()
        end
        if cr.y < 120 and getbtn() ~= -1 then
          cr.s = 2
        end
      end,
    },
  }
end
