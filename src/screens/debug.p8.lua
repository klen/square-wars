function show_debug()
  cls()
  music(-1)

  local mode, mission = 1, dget(CART.mission)
  local toggle, sep =
    {
      n = "toggle mode: 1",
      cb = function(self, dir)
        mode = (mode - 1 + dir) % 5 + 1
        self.n = "toggle mode: " .. mode
      end,
    }, {
      n = "----------------",
      off = true,
      c = 1,
    }

  local ms = Menu:new({ y = 0 }, {
    toggle,
    sep,
    {
      n = "screen - start",
      cb = start,
    },
    {
      n = "screen - brief " .. mission + 1,
      cb = function()
        local mission = dget(CART.mission)
        brief(mission + 1)
      end,
    },
    {
      n = "screen - mission " .. mission,
      cb = function()
        local mission = dget(CART.mission)
        if mission == 0 then
          mission(0, 2, 6, 20)
        end
        mission(mission)
      end,
    },
    {
      n = "screen - results " .. mission,
      cb = function()
        local mission, players = dget(CART.mission), {}
        for idx = 1, 2 + flr(rnd(3)) do
          add(players, {
            n = idx,
            score = flr(rnd(100)),
            cpu = flr(rnd(2)) == 1,
          })
          sort(players, function(a, b)
            return a.score > b.score
          end)
        end
        results(
          players,
          flr(rnd(100)),
          flr(rnd(100)),
          mission ~= 0 and mission or 1,
          mission ~= 0 and "m" or "a"
        )
      end,
    },
    {
      n = "screen - gameover",
      cb = gameover,
    },
    {
      n = "screen - practice",
      cb = practice,
    },
    {
      n = "screen - scores",
      cb = scores,
    },
  })

  local mc = Menu:new({ y = 0 }, {
    toggle,
    sep,
    {
      n = "campaign - mission done: " .. dget(CART.mission),
      cb = function(self, dir)
        dset(CART.mission, (dget(CART.mission) - 1 + dir) % #MISSIONS + 1)
        self.n = "campaign - mission done: " .. dget(CART.mission)
        ms.opts[4].n = "screen - brief " .. dget(CART.mission) + 1
        ms.opts[5].n = "screen - mission " .. dget(CART.mission)
        ms.opts[6].n = "screen - results " .. dget(CART.mission)
      end,
    },
    {
      n = "campaign - score: " .. dget(CART.score),
      cb = function(self, dir)
        dset(CART.score, dget(CART.score) + dir)
        self.n = "campaign - score: " .. dget(CART.score)
      end,
    },
    {
      n = "campaign - time: " .. dget(CART.time),
      cb = function(self, dir)
        dset(CART.time, dget(CART.time) + dir)
        self.n = "campaign - time: " .. dget(CART.time)
      end,
    },
    {
      n = "campaign - done: " .. dget(CART.done),
      cb = function(self, dir)
        dset(CART.done, (dget(CART.done) + dir) % 2)
        self.n = "campaign - done: " .. dget(CART.done)
      end,
    },
    sep,
    {
      n = "option - palette: " .. dget(CART.palette),
      cb = function(self, dir)
        dset(CART.palette, (dget(CART.palette) + dir) % 2)
        self.n = "option - palette: " .. dget(CART.palette)
      end,
    },
    sep,
    {
      n = "unlock - arena: " .. dget(CART.arena),
      cb = function(self, dir)
        dset(CART.arena, (dget(CART.arena) - 1 + dir) % #ARENAS + 1)
        self.n = "unlock - arena: " .. dget(CART.arena)
      end,
    },
    {
      n = "unlock - practice: " .. dget(CART.practice),
      cb = function(self, dir)
        dset(CART.practice, (dget(CART.practice) + dir) % 2)
        self.n = "unlock - practice: " .. dget(CART.practice)
      end,
    },
  })

  local mmopts = { toggle, sep }
  for idx = 1, #MISSIONS do
    add(mmopts, {
      n = "score - m" .. idx .. ": " .. dget(CART.mscores + idx - 1),
      cb = function(self, dir)
        dset(CART.mscores + idx - 1, dget(CART.mscores + idx - 1) + dir)
        self.n = "score - m" .. idx .. ": " .. dget(CART.mscores + idx - 1)
      end,
    })
  end
  local mm = Menu:new({ y = 0 }, mmopts)

  local maopts = { toggle, sep }
  for idx = 1, #ARENAS do
    add(maopts, {
      n = "score - a" .. idx .. ": " .. dget(CART.ascores + idx - 1),
      cb = function(self, dir)
        dset(CART.ascores + idx - 1, dget(CART.ascores + idx - 1) + dir)
        self.n = "score - a" .. idx .. ": " .. dget(CART.ascores + idx - 1)
      end,
    })
  end
  local ma = Menu:new({ y = 0 }, maopts)

  local power = dget(CART.power)
  local mp
  mp = Menu:new({ y = 0 }, {
    toggle,
    sep,
    {
      n = "power all: " .. (power == 63 and "on" or "off"),
      cb = function(self, dir)
        power = dir == 1 and 63 or 0
        dset(CART.power, power)
        self.n = "power all: " .. (power == 63 and "on" or "off")
        mp.opts[4].n = "power - snow: " .. (power & 1)
        mp.opts[5].n = "power - fire: " .. (power & 2)
        mp.opts[6].n = "power - desert: " .. (power & 4)
        mp.opts[7].n = "power - sun: " .. (power & 8)
        mp.opts[8].n = "power - woods: " .. (power & 16)
        mp.opts[9].n = "power - storm: " .. (power & 32)
      end,
    },
    {
      n = "power - snow: " .. (power & 1),
      cb = function(self, dir)
        power = invert(power, 1)
        dset(CART.power, power)
        self.n = "power - snow: " .. (power & 1)
      end,
    },
    {
      n = "power - fire: " .. (power & 2),
      cb = function(self, dir)
        power = invert(power, 2)
        dset(CART.power, power)
        self.n = "power - fire: " .. (power & 2)
      end,
    },
    {
      n = "power - desert: " .. (power & 4),
      cb = function(self, dir)
        power = invert(power, 4)
        dset(CART.power, power)
        self.n = "power - desert: " .. (power & 4)
      end,
    },
    {
      n = "power - sun: " .. (power & 8),
      cb = function(self, dir)
        power = invert(power, 8)
        dset(CART.power, power)
        self.n = "power - sun: " .. (power & 8)
      end,
    },
    {
      n = "power - woods: " .. (power & 16),
      cb = function(self, dir)
        power = invert(power, 16)
        dset(CART.power, power)
        self.n = "power - woods: " .. (power & 16)
      end,
    },
    {
      n = "power - storm: " .. (power & 32),
      cb = function(self, dir)
        power = invert(power, 32)
        dset(CART.power, power)
        self.n = "power - storm: " .. (power & 32)
      end,
    },
  })

  local menus = { mc, mp, mm, ma, ms }

  SCENE = {
    art(cls),
    Ent:new {
      update = function()
        local m = menus[mode]
        m:update()
      end,
      draw = function()
        local m = menus[mode]
        m:draw()
      end,
    },
  }
end

menuitem(3, "debug", show_debug)

function invert(var, b)
  if var & b == 0 then
    return var | b
  else
    return var & ~b
  end
end
