noop = function() end

Cls = setmetatable({
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

Ent = Cls:create { update = noop, draw = noop }

function art(fn)
  return Ent:new { draw = part(fn) }
end
