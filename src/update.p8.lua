function update()
  if frozenframes > 0 then
    frozenframes -= 1
    foreach(frozenentities, function(e)
      e:update()
    end)
    if frozenframes == 0 then
      frozenentities = {}
    end
    return
  end

  foreach(SCENE, function(e)
    e:update()
  end)

  FRAMES += 1
end

SCENE = {}
FRAMES = 0
frozenframes = 0
frozenentities = {}

function freeze_update(frames, e)
  frozenframes += frames
  add(frozenentities, e)
end
