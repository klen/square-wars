function practice()
  local arenas = slice(ARENAS, 1, 1 + dget(CART.arena))

  local arena, human, cpu, powers, mnum, done =
    0, 1, 3, dget(CART.power), dget(CART.mission), dget(CART.done)
  local eff, mode, modes = done > 0 or mnum >= 19, 0, split "--,dark,erosion"

  SCENE = {
    art(function()
      cls(1)
      print("practice mode", 16, 16, 7)
      print("choose preferences\n\nstart to begin.", 16, 40, 6)
    end),

    Menu:new(nil, {
      {
        n = "start",
        cb = function()
          music(-1)
          local tcpu = {}
          for idx = 1, cpu do
            add(tcpu, idx % 2 + 1)
          end
          local a = arena == 0 and rint(#arenas, 1) or arena
          game(
            { a = a, eff = eff },
            { a = a, human = human, cpu = join(",", tcpu) },
            dget(CART.power)
          )
        end,
      },
      #arenas > 1 and {
        n = "arena: random",
        cb = function(self, dir)
          arena = (arena + dir) % #arenas
          local data = arenas[arena] or { "random" }
          self.n = "arena: " .. data[1]
        end,
      } or nil,
      eff and {
        n = "mode: --",
        cb = function(self, dir)
          mode = (mode + dir) % #modes
          eff = mode > 0 and modes[mode + 1]
          self.n = "mode: " .. modes[mode + 1]
        end,
      } or nil,
      {
        n = "human: 1",
        update = function(_ENV)
          n = "human: " .. human
        end,
        cb = function(self, dir)
          human = (human - 1 + dir) % 4 + 1
          cpu = min(cpu, 4 - human)
        end,
      },
      {
        n = "cpu: 3",
        update = function(_ENV)
          n = "cpu: " .. cpu
        end,
        cb = function(self, dir)
          cpu = (cpu - 1 + dir) % 4 + 1
          human = min(human, 4 - cpu)
        end,
      },
      { n = "back", c = 6, cb = start },
    }),
  }
end
