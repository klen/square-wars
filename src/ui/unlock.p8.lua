function unlock(md)
  local u = md.u
  if u then
    local n, s = u.n or md.n, u.s
    if s == "arena" then
      dset(CART.arena, dget(CART.arena) + 1)
      n = s .. " " .. md.f.a
    elseif s == "power" then
      dset(CART.power, dget(CART.power) | u.v)
    elseif s then
      dset(CART[s], 1)
    end
    return Tw:new { txt = "unlocked: " .. n, c = 6, y = 85 }
  end
end
