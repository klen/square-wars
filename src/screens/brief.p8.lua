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
  menuitem(1, "restart mission ", function()
    brief(n)
  end)

  -- reset campaign data
  if n == 1 then
    pw, mw = 0, 0
    dset(CART.time, 0)
    dset(CART.score, 0)
    dset(CART.power, 0)
    dset(CART.mission, 0)
  end

  SCENE = {
    art(function()
      frame()
    end),
    Tw:new { txt = "mission " .. n .. ' "' .. md.n .. '"' },
    Tw:new { y = 28, txt = md.b },
    Conf:new {
      txt = "confirm",
      cb = function()
        md.j.num = n
        game(md.f, md.j, mw)
      end,
    },
  }

  if pw > 0 then
    add(
      SCENE,
      Ent:new {
        draw = function()
          for c = 1, #COLORS do
            if pw & (1 << (c - 1)) > 0 then
              print("◆", 121 - (c * 6), 101, COLORS[c])
            end
          end
        end,
      }
    )
  end

  if md.o then
    credits(md.o, SCENE)
  end
end

function custom_brief(n, md)
  local pwr, CNAMES = dget(CART.power), { "snow", "fire", "desert", "sun", "woods", "storm" }
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
      cb = function()
        brief(c + 1)
      end,
    })
  end

  SCENE = {
    art(function()
      cls()
      frame(73)
    end),

    Tw:new { txt = md.n },
    Tw:new { y = 28, txt = md.b },

    Menu:new({ y = 82 }, opts),
  }
end

function credits(txt, bg)
  local cr = Crawl:new { txt = txt }
  local lns = split(cr.txt, "\n")
  SCENE = {
    art(cls),
    cr,
    Ent:new {
      update = function()
        if cr.y < -#lns * 8 then
          SCENE = bg
          cls()
        end
        if cr.y < 120 and getbtn() ~= -1 then
          cr.s = 2
        end
      end,
    },
  }
end
