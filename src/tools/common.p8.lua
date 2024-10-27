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

function find(t, v)
  for i = 1, #t do
    if t[i] == v then
      return i
    end
  end
  return nil
end
