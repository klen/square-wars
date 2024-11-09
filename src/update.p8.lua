function _update60()
  if frz.fr > 0 then
    frz:update()
  else
    foreach(SCENE, function(e)
      e:update()
    end)
  end

  FRMS += 1
end

SCENE = {}
FRMS = 0
