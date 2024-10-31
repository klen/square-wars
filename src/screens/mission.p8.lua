function show_mission(mission, arena, size, human, bots, powers)
  sfx(0)
  cls()
  freeze_update(31, Fade:new { reverse = true })

  if mission ~= 0 then
    local mdata = MISSIONS[mission]
    if not mdata then
      return show_start()
    end
    size, arena, bots, powers, plc =
      mdata.s or 20, mdata.a, split(mdata.cpu, "/"), mdata.w, mdata.plc or 1
  end

  local f = Field:new { size = size, arena = arena }
  local w = powers and Power:new { powers = powers } or nil
  local j = Judge:new {
    bots = bots,
    human = human,
    arena = arena,
    mission = mission,
    field = f,
    power = w,
    plc = plc,
    powers = dget(CDATA.power),
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
