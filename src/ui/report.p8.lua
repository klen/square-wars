function report(players, moves, seconds, num, mode)
  local res = "report " .. mode .. num .. "/" .. stat(90) .. "-" .. stat(91) .. "-" .. stat(92) .. "\n\n"
  local ckey = mode == "m" and CART.mscores or CART.ascores
  local stored, humans = dget(ckey - 1 + num), #filter(players, function(p) return not p.cpu end)

  for place, p in ipairs(players) do
    local prefix, score, smode =  p.cpu and "c" or "p", tostr(p.score), ""
    if humans == 1 and not p.cpu and p.score > stored then
      dset(ckey - 1 + num, p.score)
      if mode == "a" or stored ~= 0 then
        smode = " (" .. mode .. num .. " top)"
      end
    end
    res ..= place .. "st " .. prefix .. p.n .. " score: " .. pspace(score, 4) .. score .. smode .. "\n"
  end

  moves = tostr(moves)
  local tm = seconds \ 60 .. ":" .. lzero(flr(seconds % 60))
  res ..= (
    "moves: " .. pspace(moves, 11) .. moves .. "\n" ..
    "time:  " .. pspace(tm, 11) .. tm
  )
  return function() return Tw:new { txt = res } end
end

