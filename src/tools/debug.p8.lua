function debug(t, ind)
  if type(t) ~= "table" then
    return tostr(t)
  end

  ind = ind or ""
  local res = ind
  for k, v in pairs(t) do
    res ..= k .. ": " .. (type(v) == "table" and ("\n" .. debug(v, ind .. " ")) or (tostr(v) .. "\n"))
    -- if type(v) == "table" then
    --   res = res .. "\n" .. debug(v, ind .. " ")
    -- else
    --   res = res .. tostr(v) .. "\n"
    -- end
  end
  return res
end

function log(m)
  if type(m) ~= "string" then
    m = debug(m)
  end
  printh(m, "log")
end
