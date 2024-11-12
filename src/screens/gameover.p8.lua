function gameover()
  pal(0)
  frame()
  music(6, 1000)
  dset(CART.done, 1)

  local ts, tc = time(), dget(CART.time)
  local min, sec = tc \ 60, flr(tc % 60)
  local missions = filter(MISSIONS, function(m) return m.j and m.j.cpu end)

  local sc5 = {
    art(function()
      cls()
      printb(ctrl .. "x5square wars", 7, 17, 1)
      w = printb(ctrl .. "x5square wars", 6, 18, 9)
    end),
    -- Tw:new { txt = "square wars", c=9 },
    Tw:new { txt = "a game by horneds 2024", y = 58 },
    Tw:new { txt = "music composed by gruber", y = 68 },
    Tw:new { txt = "thanks for playing!", y = 88, c = 12 },
    Conf:new {
      txt = "main menu",
      cb = function()
        pal(0)
        music(-1)
        start()
      end,
    },
  }
  local sc4 = mission_scores(slice(missions, 11), 11)
  add(sc4, Conf:new {
      txt = "view credits",
      cb = function()
        pal(0)
        cls()
        SCENE = sc5
      end,
  })
  local sc3 = mission_scores(slice(missions, 1, 10), 1)
  add(sc3, Conf:new {
      txt = "view scores",
      cb = function()
        pal(0)
        cls()
        SCENE = sc4
      end,
  })

  local sc2 = {
    Tw:new { txt = "you have done " .. #MISSIONS .. " missions" },
    Tw:new {
      txt = "total score: " .. dget(CART.score),
      y = 32, c = 6,
    },
    Tw:new {
      txt = "total time: " .. min .. ":" .. lzero(sec, 10),
      y = 46, c = 6,
    },
    Conf:new {
      txt = "view stats",
      cb = function()
        pal(0)
        cls()
        SCENE = sc3
      end,
    }
  }

  credits(mem_txt(DATA.FINAL), function()
    cls()
    SCENE = sc2
  end)
end
