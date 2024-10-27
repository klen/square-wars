function draw()
  foreach(scene, function(e)
    e:draw()
  end)
end
