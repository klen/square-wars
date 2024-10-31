function show_gameover()
  frame()
  dset(CDATA.done, 1)

  local start, ctime = time(), dget(CDATA.time)
  local minutes, seconds = ctime \ 60, flr(ctime % 60)
  local scores, stats, credits

  scene = {
    Typewriter:new {
      txt = "you have mastered the field",
    },
    Typewriter:new {
      txt = "the secrets of the board\n\nare now yours to command.",
      y = 32,
      c = 6,
    },
    Typewriter:new {
      txt = "but remember,\n\nnew challengers prepare, and",
      y = 56,
      c = 6,
    },
    Typewriter:new {
      txt = "the field awaits.",
      y = 84,
      c = 12,
    },
    Entity:new {
      update = function(self)
        if dget(CDATA.mute) == 0 and time() - start > 0.1 then
          music(6, 1000)
          self.update = noop
        end
      end,
    },
    Confirmation:new {
      txt = "view scores",
      callback = function()
        scene = scores
      end,
    },
  }

  -- scores
  scores = {
    Typewriter:new {
      txt = "you have done " .. #MISSIONS .. " missions",
    },
    Typewriter:new {
      txt = "total score: " .. dget(CDATA.score),
      y = 32,
      c = 6,
    },
    Typewriter:new {
      txt = "total time: " .. minutes .. ":" .. lzero(seconds, 10),
      y = 46,
      c = 6,
    },
    Confirmation:new {
      txt = "view stats",
      callback = function()
        scene = stats
      end,
    },
  }

  -- stats
  stats = mission_scores()
  add(stats, Confirmation:new {
      txt = "view credits",
      callback = function()
        scene = credits
      end,
  })

  -- credits
  credits = {
    Typewriter:new {
      txt = "square wars",
    },
    Typewriter:new {
      txt = "a game by horneds 2024",
      y = 32,
    },
    Typewriter:new {
      txt = "music composed by gruber",
      y = 48,
    },
    Typewriter:new {
      txt = "thanks for playing!",
      y = 86,
      c = 12,
    },
    Confirmation:new {
      txt = "main menu",
      callback = function()
        music(-1)
        show_start()
      end,
    },
  }
end
