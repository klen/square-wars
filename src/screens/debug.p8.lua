function show_debug()
  printh "debug"
  cls()
  local mode = 1
  local toggle, sep =
    {
      name = "toggle mode: 1",
      callback = function(self)
        mode = mode % 3 + 1
        self.name = "toggle mode: " .. mode
      end,
    }, {
      name = "----------",
      disabled = true,
      c = 1,
    }
  local m1 = menu:new({
    offset = 0,
  }, {
    toggle,
    sep,
    {
      name = "campaign - mission: " .. dget(cdata.mission),
      callback = function(self, dir)
        dset(cdata.mission, dget(cdata.mission) + dir)
        self.name = "campaign - mission: " .. dget(cdata.mission)
      end,
    },
    {
      name = "campaign - place: " .. dget(cdata.place),
      callback = function(self, dir)
        dset(cdata.place, dget(cdata.place) + dir)
        self.name = "campaign - place: " .. dget(cdata.place)
      end,
    },
    {
      name = "campaign - score: " .. dget(cdata.score),
      callback = function(self, dir)
        dset(cdata.score, dget(cdata.score) + dir)
        self.name = "campaign - score: " .. dget(cdata.score)
      end,
    },
    {
      name = "campaign - time: " .. dget(cdata.time),
      callback = function(self, dir)
        dset(cdata.time, dget(cdata.time) + dir)
        self.name = "campaign - time: " .. dget(cdata.time)
      end,
    },
    {
      name = "campaign - done: " .. dget(cdata.done),
      callback = function(self, dir)
        dset(cdata.done, dget(cdata.done) + dir)
        self.name = "campaign - done: " .. dget(cdata.done)
      end,
    },
    sep,
    {
      name = "option - palette: " .. dget(cdata.palette),
      callback = function(self, dir)
        dset(cdata.palette, dget(cdata.palette) + dir)
        self.name = "option - palette: " .. dget(cdata.palette)
      end,
    },
    sep,
    {
      name = "unlock - arena: " .. dget(cdata.arena),
      callback = function(self, dir)
        dset(cdata.arena, dget(cdata.arena) + dir)
        self.name = "unlock - arena: " .. dget(cdata.arena)
      end,
    },
    {
      name = "unlock - practice: " .. dget(cdata.practice),
      callback = function(self, dir)
        dset(cdata.practice, dget(cdata.practice) + dir)
        self.name = "unlock - practice: " .. dget(cdata.practice)
      end,
    },
    sep,
    {
      name = "exit",
      callback = show_start,
    },
  })

  local m2opts = { toggle, sep }
  for idx = 1, #missions do
    add(m2opts, {
      name = "score - m" .. idx .. ": " .. dget(cdata.mscores + idx - 1),
      callback = function(self, dir)
        dset(cdata.mscores + idx - 1, dget(cdata.mscores + idx - 1) + dir)
        self.name = "score - m" .. idx .. ": " .. dget(cdata.mscores + idx - 1)
      end,
    })
  end
  local m2 = menu:new({ offset = 0 }, m2opts)

  local m3opts = { toggle, sep }
  for idx = 1, #arenas do
    add(m3opts, {
      name = "score - a" .. idx .. ": " .. dget(cdata.ascores + idx - 1),
      callback = function(self, dir)
        dset(cdata.ascores + idx - 1, dget(cdata.ascores + idx - 1) + dir)
        self.name = "score - a" .. idx .. ": " .. dget(cdata.ascores + idx - 1)
      end,
    })
  end
  local m3 = menu:new({ offset = 0 }, m3opts)

  scene = {
    art(cls),
    entity:new {
      update = function()
        if mode == 1 then
          m1:update()
        elseif mode == 2 then
          m2:update()
        elseif mode == 3 then
          m3:update()
        end
      end,
      draw = function()
        if mode == 1 then
          m1:draw()
        elseif mode == 2 then
          m2:draw()
        elseif mode == 3 then
          m3:draw()
        end
      end,
    },
  }
end

menuitem(3, "debug", show_debug)
