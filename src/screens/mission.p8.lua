function show_mission(mission, arena, size, human, bots, powers)
  sfx(0)
  cls()
  freeze_update(31, Fade:new { reverse = true })

  if mission ~= 0 then
    local mdata = missions[mission]
    if not mdata then
      return show_start()
    end
    size, arena, bots, powers = mdata.s, mdata.a, split(mdata.cpu, "/"), mdata.w
  end

  local f = Field:new { size = size, arena = arena }
  local w = powers
      and Power:new {
        powers = { powers & 1, powers & 2, powers & 4, powers & 8, powers & 16, powers & 32 },
      }
    or nil
  local j = Judge:new {
    bots = bots,
    human = human,
    arena = arena,
    mission = mission,
    field = f,
    power = w,
    powers = dget(cdata.power),
  }

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
