global = _ENV

noop = function() end

Class = setmetatable({
  create = function(self, tbl, ...)
    return setmetatable(tbl or {}, { __index = self })
  end,
  new = function(self, tbl, ...)
    tbl = self:create(tbl, ...)
    tbl:init(...)
    return tbl
  end,
  init = noop,
}, { __index = _ENV })

Entity = Class:create { update = noop, draw = noop }

function art(draw)
  return Entity:new { draw = draw }
end
