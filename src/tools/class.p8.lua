global = _ENV

noop = function() end

class = setmetatable({
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

entity = class:create { update = noop, draw = noop }

function art(draw)
  return entity:new { draw = draw }
end
