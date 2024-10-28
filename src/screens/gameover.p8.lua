function show_gameover()
  frame()
  dset(cdata.done, 1)

  local start, ctime = time(), dget(cdata.time)
  local minutes, seconds = ctime \ 60, flr(ctime % 60)
  local scores, stats, credits

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
        if dget(cdata.mute) == 0 and time() - start > 0.1 then
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

  -- scores
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
      txt = "total time: " .. minutes .. ":" .. lzero(seconds, 10),
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

  -- stats
  stats = mission_scores()
  add(stats, confirmation:new {
      txt = "view credits",
      callback = function()
        scene = credits
      end,
  })

  -- credits
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
