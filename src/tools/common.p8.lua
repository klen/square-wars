function load_table_str(s)
  local t = {}
  for p in all(split(s)) do
    local k, v = unpack(split(p, "="))
    t[k] = v
  end
  return t
end

function sort(t, cmp)
  res = pack(unpack(t))
  for i = 1, #res do
    local j = i
    while j > 1 and cmp(res[j], res[j - 1]) do
      res[j], res[j - 1] = res[j - 1], res[j]
      j = j - 1
    end
  end
  return res
end

function find(t, fn)
  for idx, o in ipairs(t) do
    if fn(o) then
      return idx
    end
  end
  return -1
end

function filter(t, fn)
  local res = {}
  for o in all(t) do
    if fn(o) then
      add(res, o)
    end
  end
  return res
end

function counter(t)
  local c = {}
  for o in all(t) do
    c[o] = (c[o] or 0) + 1
  end
  return c
end

function unique(t)
  local c = counter(t)
  local res = {}
  for o in all(t) do
    if c[o] == 1 then
      add(res, o)
    end
  end
  return res
end
