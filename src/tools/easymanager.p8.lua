-- t: current frame
-- b: starting value
-- c: change in value (final-start)
-- d: total frames
--  https://www.youtube.com/watch?v=pydKWTSGMEM
function easeInOutQuad(t,b,c,d)
  t /= d/2
  if (t < 1) return c/2*t*t + b
  t -= 1
  return -c/2 * (t*(t-2) - 1) + b
end

function initEaseManager()
  local easeManager = {list={}}
  easeManager.ease = function(obj, field, start, final, duration, callback)
    local c = cocreate(function()
      for i = 1, duration do
        obj[field] = easeInOutQuad(i, start, final - start, duration)
        yield()
      end
      obj[field] = final
      if callback ~= nil then
        callback()
      end
    end)

    add(easeManager.list, c)
  end

  easeManager.update = function(self)
     for c in all(self.list) do
      if costatus(c) then
        coresume(c)
      else
        del(self.list, c)
      end
    end
  end

  return easeManager
end

-- easeManager.ease(logo, "y", 0, -40, 30)
