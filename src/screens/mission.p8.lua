-- set mission to 0 for practice mode
function show_mission(mission, players, arena, size)
  sfx(0)
  cls()
  freeze_update(31, fade:new { reverse = true })

  if mission ~= 0 then
    local mdata = missions[mission]
    if not mdata then
      return show_start()
    end
    size, players, arena = mdata.s, mdata.p, mdata.a
  end

  local f = field:new { size = size, arena = arena }
  local j = judge:new { num_players = players, field = f, mission = mission, arena = arena }

  scene = {
    art(cls),
    -- field
    f,
    -- judge
    j,
    -- stats
    stats:new { players = j.players },
    -- controls
    controls:new { field = f, judge = j },
  }
end
