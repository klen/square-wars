function _draw()
  foreach(SCENE, function(e)
    e:draw()
  end)
  frz:draw()
end
