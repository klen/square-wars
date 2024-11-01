function show_practice()
  local arena, human, cpu, arena_available, powers =
    1, 1, 3, min(dget(CDATA.arena), #ARENAS), dget(CDATA.power)

  SCENE = {
    art(function()
      cls(1)
      print("practice mode", 16, 16, 7)
      print("choose preferences\n\nstart to begin.", 16, 40, 6)
    end),
    Menu:new(nil, {
      {
        name = "start",
        callback = function()
          music(-1)
          arena = arena == 1 and flr(rnd(#ARENAS)) + 1 or arena - 1
          local tcpu = {}
          for idx = 1, cpu do
            add(tcpu, idx % 2 + 1)
          end
          show_mission(0, arena, 20, human, tcpu, powers)
        end,
      },
      arena_available > 0 and {
        name = "arena: random",
        callback = function(self, dir)
          arena = (arena - 1 + dir) % (arena_available + 2) + 1
          local data = ARENAS[arena - 1] or { "random" }
          self.name = "arena: " .. data[1]
        end,
      } or nil,
      {
        name = "human: 1",
        update = function(_ENV)
          name = "human: " .. human
        end,
        callback = function(self, dir)
          human = (human - 1 + dir) % 4 + 1
          cpu = min(cpu, 4 - human)
        end,
      },
      {
        name = "cpu: 3",
        update = function(_ENV)
          name = "cpu: " .. cpu
        end,
        callback = function(self, dir)
          cpu = (cpu - 1 + dir) % 4 + 1
          human = min(human, 4 - cpu)
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
