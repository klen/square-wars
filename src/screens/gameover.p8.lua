function show_gameover()
  frame()
  local start, ctime = time(), dget(cdata.time)
  local minutes, seconds = ctime \ 60, flr(ctime % 60)

  scene = {
    typewriter:new {
      txt = "you have mastered the field",
    },
    typewriter:new {
      txt = "the secrets of the board\n\nare now yours to command.",
      y = 32,
      c = 6,
    },
    typewriter:new {
      txt = "but remember,\n\nnew challengers prepare, and",
      y = 56,
      c = 6,
    },
    typewriter:new {
      txt = "the field awaits.",
      y = 84,
      c = 12,
    },
    entity:new {
      update = function(self)
        if time() - start > 0.1 then
          music(6, 1000)
          self.update = noop
        end
      end,
    },
    confirmation:new {
      txt = "view scores",
      callback = function()
        scene = scores
      end,
    },
  }

  scores = {
    typewriter:new {
      txt = "you have done " .. #missions .. " missions",
    },
    typewriter:new {
      txt = "total score: " .. dget(cdata.score),
      y = 32,
      c = 6,
    },
    typewriter:new {
      txt = "total time: " .. minutes .. ":" .. leading_zero(seconds),
      y = 46,
      c = 6,
    },
    confirmation:new {
      txt = "view stats",
      callback = function()
        scene = stats
      end,
    },
  }

  stats = {
    typewriter:new {
      txt = "mission scores",
    },
    confirmation:new {
      txt = "view credits",
      callback = function()
        scene = credits
      end,
    },
  }

  add(stats, typewriter:new {
      txt = "mission scores",
  })
  for i, m in ipairs(missions) do
    if i > 1 then
      add(stats, typewriter:new {
        txt = m.n .. ": " .. dget(cdata.mscores + i - 1),
        y = i * 8, c = 6,
      }, #stats - 1)
    end
  end

  credits = {
    typewriter:new {
      txt = "square wars",
    },
    typewriter:new {
      txt = "a game by horneds 2024",
      y = 32,
    },
    typewriter:new {
      txt = "music composed by gruber",
      y = 48,
    },
    typewriter:new {
      txt = "thanks for playing!",
      y = 86,
      c = 12,
    },
    confirmation:new {
      txt = "main menu",
      callback = function()
        music(-1)
        show_start()
      end,
    },
  }
end
