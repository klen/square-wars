function _draw()
  frz:draw()
  foreach(SCENE, function(e)
    e:draw()
  end)
end
