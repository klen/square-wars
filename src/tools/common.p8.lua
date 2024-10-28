function load_table_str(s)
  local t = {}
  for p in all(split(s)) do
    local k, v = unpack(split(p, "="))
    t[k] = v
  end
  return t
end

function sort(t, cmp)
  for i = 1, #t do
    local j = i
    while j > 1 and cmp(t[j], t[j - 1]) do
      t[j], t[j - 1] = t[j - 1], t[j]
      j = j - 1
    end
  end
end

function find(t, fn)
  for idx, o in ipairs(t) do
    if fn(o) then
      return idx
    end
  end
  return -1
end
