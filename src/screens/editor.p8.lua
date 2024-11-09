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
            local f = Fd:new { a = arena }
            local e = Editor:new { field = f }

            menuitem(1, "copy arena", function()
              local res = {}

              for t in all(f.t) do
                if t.p == 5 then
                  add(res, hex(t.n))
                end
              end

              printh(join(",", res), "@clip")
            end)

            SCENE = { art(cls), f, e }
          end
        end,
      },
    }),
  }
end
