function report(players, moves, seconds, num, mode)
  local year, month, day, time = stat(90), stat(91), stat(92), seconds \ 60 .. ":" .. lzero(flr(seconds % 60))
  local report = "report " .. mode .. num .. "/" .. year .. "-" .. month .. "-" .. day .. "\n\n\n"
  local ckey = mode == "m" and cdata.mscores or cdata.ascores
  local stored = dget(ckey - 1 + num)

  for place, p in ipairs(players) do
    local prefix, score, smode =  p.cpu and "c" or "p", tostr(p.s), ""
    if place == 1 and not p.cpu and p.s > stored then
      dset(ckey - 1 + num, p.s)
      if mode == "a" or stored ~= 0 then
        smode = " (" .. mode .. num .. " top)"
      end
    end
    report ..= place .. "st " .. prefix .. p.n .. " score: " .. pspace(score, 6) .. score .. smode .. "\n"
  end

  moves = tostr(moves)
  report ..= "\n" .. (
    "moves: " .. pspace(moves, 13) .. moves .. "\n\n" ..
    "time:  " .. pspace(time, 13) .. time
  )
  return function() return typewriter:new { txt = report } end
end

