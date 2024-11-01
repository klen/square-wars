function update()
  if freezer.frames > 0 then
    freezer:update()
  else
    foreach(SCENE, function(e)
      e:update()
    end)
  end

  FRAMES += 1
end

SCENE = {}
FRAMES = 0
