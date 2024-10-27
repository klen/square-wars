function storage(name, keys)
  cartdata(name)

  local self, index = {}, {}
  for idx, key in ipairs(keys) do
    index[key] = idx
  end

  function self:get(k)
    return dget(index[k])
  end

  function self:set(k, v)
    dset(index[k], v)
  end

  return self
end
