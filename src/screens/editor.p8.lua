function init()
  local arena = 1

  local m = Menu:new({}, {
    {
      name = "arena: empty",
      callback = function(self, dir)
        arena = (arena - 1 + dir) % #ARENAS + 1
        local data = ARENAS[arena]
        self.name = "arena: " .. data[1]
      end,
    },
    {
      name = "load editor",
      callback = function()
        local f = Field:new { size = 20, arena = arena }
        local e = Editor:new { field = f }

        scene = { art(cls), f, e }
      end,
    },
  })

  scene = { art(cls), m }
end
