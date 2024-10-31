function draw()
  foreach(frozenentities, function(e)
    e:draw()
  end)
  foreach(SCENE, function(e)
    e:draw()
  end)
end
