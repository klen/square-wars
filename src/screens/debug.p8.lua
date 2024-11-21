function show_debug()
  cls()
  music(-1)

  local menus, mode = {}, 1
  local toggle, sep =
    {
      n = function()
        return "toggle mode: " .. mode
      end,
      cb = function(self, dir)
        mode = (mode - 1 + dir) % #menus + 1
        SCENE = { art(part(cls, 1)), menus[mode] }
      end,
    }, { n = "", c = 1, off = true }

  -- campaign
  add(
    menus,
    Menu:new({ y = 1 }, {
      toggle,
      sep,
      debugitem("campaign - mission", CART.mission),
      debugitem("campaign - score", CART.score),
      debugitem("campaign - time", CART.time),
      debugitem("campaign - done", CART.done),
      sep,
      debugitem("run - run", CART.run),
      debugitem("run - runmax", CART.runmax),
      debugitem("run - rscore", CART.rscore),
      sep,
      debugitem("option - palette", CART.palette),
      sep,
      debugitem("unlock - arena", CART.arena),
    })
  )

  -- power
  local power = CART.power
  add(
    menus,
    Menu:new({ y = 1 }, {
      toggle,
      sep,
      debugitem("power - all", power, function(dir, v)
        return dir == 1 and 63 or 0
      end),
      debugitem_mask("power - snow", power, 1),
      debugitem_mask("power - fire", power, 2),
      debugitem_mask("power - desert", power, 4),
      debugitem_mask("power - sun", power, 8),
      debugitem_mask("power - woods", power, 16),
      debugitem_mask("power - storm", power, 32),
    })
  )

  -- slots
  items = { toggle, sep }
  for k, v in pairs(CART) do
    add(items, { n = k .. ": " .. dget(v) })
  end
  add(menus, Menu:new({ y = 1 }, items))

  -- mission scores
  local items = { toggle, sep }
  for idx = 1, #MISSIONS do
    add(items, debugitem("mission - m" .. idx, CART.mscores + idx - 1))
  end
  add(menus, Menu:new({ y = 1 }, items))

  -- arena scores
  items = { toggle, sep }
  for idx = 1, #ARENAS do
    add(items, debugitem("arena - a" .. idx, CART.ascores + idx - 1))
  end
  add(menus, Menu:new({ y = 1 }, items))

  -- screens
  add(
    menus,
    Menu:new({ y = 1 }, {
      toggle,
      sep,
      debugitem("screen - start", nil, start),
      debugitem("screen - brief", CART.mission, function(dir, v)
        brief(v)
      end),
      debugitem("screen - results", CART.mission, function(dir, mission)
        local players = {}
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
      end),
      debugitem("screen - gameover", nil, gameover),
      debugitem("screen - practice", nil, practice),
      debugitem("screen - scores", nil, scores),
      debugitem("screen - infinite", nil, part(infinite, 1)),
    })
  )

  toggle:cb(0)
end

menuitem(5, "debug", show_debug)

function invert(var, b)
  return var & b == 0 and var | b or var & ~b
end

function debugitem_mask(title, slot, mask)
  return {
    n = function()
      return title .. ": " .. (dget(slot) & mask)
    end,
    cb = function(self, dir)
      dset(slot, invert(dget(slot), mask))
    end,
  }
end

function debugitem(title, slot, cb)
  cb = cb or function(dir, v)
    return v + dir
  end
  return {
    n = function()
      if not slot then
        return title
      end
      return title .. ": " .. dget(slot)
    end,
    cb = function(self, dir)
      local v = cb(dir, slot and dget(slot) or nil)
      if v then
        dset(slot, v)
      end
    end,
  }
end
