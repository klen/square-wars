function draw()
  freezer:draw()
  foreach(SCENE, function(e)
    e:draw()
  end)
end
