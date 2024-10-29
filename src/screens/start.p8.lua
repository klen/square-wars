function show_start()
  if stat(24) <= 0 and dget(cdata.mute) == 0 then
    music(0, 1000)
  end
  cls(1)
  menuitem(1)

  local mission, place, practice, scores =
    dget(cdata.mission), dget(cdata.place), dget(cdata.practice), dget(cdata.done)

  scene = {
    -- clear the scene (we don't use cls because of the fade)
    art(function()
      rectfill(0, 0, 127, 127, 1)
    end),
    -- field
    field:new { size = 12, offset = 16 },
    -- the title
    art(function()
      rectfill(0, 48, 127, 127, 1)
      printb("square wars", 16, 56, 7)
      print("a game by horneds 2024\nmusic by gruber", 16, 114, 6)
    end),
    -- main menu
    menu:new(nil, {
      mission > 1
          and mission < #missions
          and {
            name = (place == 1 and "continue" or "try again") .. " (m" .. mission + 1 .. ")",
            callback = function()
              start(mission + 1)
            end,
          }
        or nil,
      {
        name = "new campaign",
        callback = function()
          start(1)
        end,
      },
      practice > 0 and { name = "practice", callback = show_practice } or nil,
      scores > 0 and { name = "scores", callback = show_scores } or nil,
    }),
  }
end

function start(mission)
  freeze_update(
    31,
    fade:new {
      callback = function()
        show_brief(mission)
      end,
    }
  )
end
