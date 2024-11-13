function show_debug()
  cls()
  music(-1)

  local mode, mission = 1, dget(CART.mission)
  local toggle, sep =
    {
      n = function()
        return "toggle mode: " .. mode
      end,
      cb = function(self, dir)
        mode = (mode - 1 + dir) % 5 + 1
      end,
    }, { n = "----------------", c = 1, off = true }

  local ms = Menu:new({ y = 0 }, {
    toggle,
    sep,
    { n = "screen - start", cb = start },
    {
      n = function()
        return "screen - brief " .. mission + 1
      end,
      cb = function()
        local mission = dget(CART.mission)
        brief(mission + 1)
      end,
    },
    {
      n = function()
        return "screen - mission " .. mission
      end,
      cb = function()
        local mission = dget(CART.mission)
        if mission == 0 then
          mission(0, 2, 6, 20)
        end
        mission(mission)
      end,
    },
    {
      n = function()
        return "screen - results " .. mission
      end,
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
    { n = "screen - gameover", cb = gameover },
    { n = "screen - practice", cb = practice },
    { n = "screen - scores", cb = scores },
    {
      n = "screen - infinite",
      cb = function()
        infinite(1)
      end,
    },
  })

  local mc = Menu:new({ y = 0 }, {
    toggle,
    sep,
    {
      n = function()
        return "campaign - mission done: " .. mission
      end,
      cb = function(self, dir)
        dset(CART.mission, (dget(CART.mission) - 1 + dir) % #MISSIONS + 1)
        mission = dget(CART.mission)
      end,
    },
    {
      n = function()
        return "campaign - score: " .. dget(CART.score)
      end,
      cb = function(self, dir)
        dset(CART.score, dget(CART.score) + dir)
      end,
    },
    {
      n = function()
        return "campaign - time: " .. dget(CART.time)
      end,
      cb = function(self, dir)
        dset(CART.time, dget(CART.time) + dir)
      end,
    },
    {
      n = function()
        return "campaign - done: " .. dget(CART.done)
      end,
      cb = function(self, dir)
        dset(CART.done, (dget(CART.done) + dir) % 2)
      end,
    },
    sep,
    {
      n = function()
        return "run - run: " .. dget(CART.run)
      end,
      cb = function(self, dir)
        dset(CART.run, dget(CART.run) + dir)
      end,
    },
    {
      n = function()
        return "run - runmax: " .. dget(CART.runmax)
      end,
      cb = function(self, dir)
        dset(CART.runmax, dget(CART.runmax) + dir)
      end,
    },
    {
      n = function()
        return "run - rscore: " .. dget(CART.rscore)
      end,
      cb = function(self, dir)
        dset(CART.rscore, dget(CART.rscore) + dir)
      end,
    },
    sep,
    {
      n = function()
        return "option - palette: " .. dget(CART.palette)
      end,
      cb = function(self, dir)
        dset(CART.palette, (dget(CART.palette) + dir) % 2)
      end,
    },
    sep,
    {
      n = function()
        return "unlock - arena: " .. dget(CART.arena)
      end,
      cb = function(self, dir)
        dset(CART.arena, (dget(CART.arena) - 1 + dir) % #ARENAS + 1)
      end,
    },
  })

  local mmopts = { toggle, sep }
  for idx = 1, #MISSIONS do
    add(mmopts, {
      n = function()
        return "score - m" .. idx .. ": " .. dget(CART.mscores + idx - 1)
      end,
      cb = function(self, dir)
        dset(CART.mscores + idx - 1, dget(CART.mscores + idx - 1) + dir)
      end,
    })
  end
  local mm = Menu:new({ y = 0 }, mmopts)

  local maopts = { toggle, sep }
  for idx = 1, #ARENAS do
    add(maopts, {
      n = function()
        return "score - a" .. idx .. ": " .. dget(CART.ascores + idx - 1)
      end,
      cb = function(self, dir)
        dset(CART.ascores + idx - 1, dget(CART.ascores + idx - 1) + dir)
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
      n = function()
        return "power all: " .. (power == 63 and "on" or "off")
      end,
      cb = function(self, dir)
        power = dir == 1 and 63 or 0
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - snow: " .. (power & 1)
      end,
      cb = function(self, dir)
        power = invert(power, 1)
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - fire: " .. (power & 2)
      end,
      cb = function(self, dir)
        power = invert(power, 2)
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - desert: " .. (power & 4)
      end,
      cb = function(self, dir)
        power = invert(power, 4)
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - sun: " .. (power & 8)
      end,
      cb = function(self, dir)
        power = invert(power, 8)
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - woods: " .. (power & 16)
      end,
      cb = function(self, dir)
        power = invert(power, 16)
        dset(CART.power, power)
      end,
    },
    {
      n = function()
        return "power - storm: " .. (power & 32)
      end,
      cb = function(self, dir)
        power = invert(power, 32)
        dset(CART.power, power)
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

menuitem(5, "debug", show_debug)

function invert(var, b)
  return var & b == 0 and var | b or var & ~b
end
