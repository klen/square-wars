function sort(t, fn)
  local r = pack(unpack(t))
  for i = 1, #r do
    local j = i
    while j > 1 and fn(r[j], r[j - 1]) do
      r[j], r[j - 1] = r[j - 1], r[j]
      j = j - 1
    end
  end
  return r
end

function find(t, fn)
  for i, o in ipairs(t) do
    if fn(o) then
      return i
    end
  end
  return 0
end

function filter(t, fn)
  local r = {}
  for o in all(t) do
    if fn(o) then
      add(r, o)
    end
  end
  return r
end

function slice(t, i, j)
  local r, j = {}, j or #t
  for k = i, j do
    add(r, t[k])
  end
  return r
end

function join(d, t)
  if #t < 2 then
    return t[1]
  end
  return t[1] .. d .. join(d, slice(t, 2))
end

function rint(n, t)
  return flr(rnd(n)) + t
end

function part(fn, ...)
  local arg = { ... }
  return function()
    return fn(unpack(arg))
  end
end

log = noop
