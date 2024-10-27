function show_practice()
  local arena, enemies, arena_available = 1, 3, min(dget(cdata.arena), #arenas)

  scene = {
    art(function()
      cls(1)
      print("practice mode", 16, 16, 7)
      print("choose preferences\nstart to begin.", 16, 40, 6)
    end),
    menu:new(nil, {
      arena_available > 0 and {
        name = "arena: random",
        callback = function(self, dir)
          arena = (arena - 1 + dir) % (arena_available + 2) + 1
          local data = arenas[arena - 1] or { "random" }
          self.name = "arena: " .. data[1]
        end,
      } or nil,
      {
        name = "enemies: 3",
        callback = function(self, dir)
          enemies = (enemies - 1 + dir) % 3 + 1
          self.name = "enemies: " .. enemies
        end,
      },
      {
        name = "start",
        callback = function()
          music(-1)
          arena = arena == 1 and flr(rnd(#arenas)) + 1 or arena - 1
          show_mission(0, enemies + 1, arena, 20)
        end,
      },
      {
        name = "back",
        c = 6,
        callback = show_start,
      },
    }),
  }
end
