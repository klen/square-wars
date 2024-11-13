function editor()
  local arena = 1

  SCENE = {
    art(cls),
    Menu:new({}, {
      {
        n = function()
          return "arena: " .. arena .. " - " .. ARENAS[arena][1]
        end,
        cb = function(self, dir, btn)
          if btn == 0 or btn == 1 then
            arena = (arena - 1 + dir) % #ARENAS + 1
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
