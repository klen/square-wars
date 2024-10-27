function debug(t, indent)
  if type(t) ~= "table" then
    return printh(tostr(t))
  end
  indent = indent or " "
  for k, v in pairs(t) do
    if type(v) == "table" then
      printh(indent .. k .. ":")
      debug(v, indent .. " ")
    else
      printh(indent .. k .. ": " .. tostr(v))
    end
  end
end
