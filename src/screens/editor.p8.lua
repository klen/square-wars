function editor()
  local arena = 1

  SCENE = {
    art(cls),
    Menu:new({}, {
      {
        n = "arena: 1 - empty",
        cb = function(self, dir, btn)
          if btn == 0 or btn == 1 then
            arena = (arena - 1 + dir) % #ARENAS + 1
            local data = ARENAS[arena]
            self.n = "arena: " .. arena .. " - " .. data[1]
          else
            local f = Fld:new { a = arena }
            local e = Editor:new { field = f }

            SCENE = { art(cls), f, e }
          end
        end,
      },
    }),
  }
end
