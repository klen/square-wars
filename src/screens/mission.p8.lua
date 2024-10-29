function show_mission(mission, arena, size, human, bots)
  sfx(0)
  cls()
  freeze_update(31, fade:new { reverse = true })

  if mission ~= 0 then
    local mdata = missions[mission]
    if not mdata then
      return show_start()
    end
    size, arena, bots = mdata.s, mdata.a, split(mdata.cpu, "/")
  end

  local f = field:new { size = size, arena = arena }
  local j = judge:new { bots = bots, human = human, field = f, mission = mission, arena = arena }

  scene = {
    art(cls),
    -- field
    f,
    -- judge
    j,
    -- stats
    -- stats:new { players = j.players },
    -- controls
    controls:new { judge = j },
  }
end
