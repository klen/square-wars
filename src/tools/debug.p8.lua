function debug(t, indent)
  if type(t) ~= "table" then
    return tostr(t)
  end

  res = ""
  indent = indent or " "
  for k, v in pairs(t) do
    if type(v) == "table" then
      res = res .. indent .. k .. ":\n"
      debug(v, indent .. " ")
    else
      res = res .. indent .. k .. ": " .. tostr(v) .. "\n"
    end
  end
  return res
end
