function show_mission(mission, arena, size, human, bots)
  sfx(0)
  cls()
  freeze_update(31, Fade:new { reverse = true })

  if mission ~= 0 then
    local mdata = missions[mission]
    if not mdata then
      return show_start()
    end
    size, arena, bots = mdata.s, mdata.a, split(mdata.cpu, "/")
  end

  local f = Field:new { size = size, arena = arena }
  local w = size == 20 and Power:new {} or nil
  local j =
    Judge:new { bots = bots, human = human, field = f, mission = mission, arena = arena, power = w }

  scene = {
    art(cls),
    -- field
    f,
    -- judge
    j,
    -- power
    w,
    -- controls
    Controls:new { judge = j, power = w },
  }
end
