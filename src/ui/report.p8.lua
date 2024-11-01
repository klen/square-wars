function report(players, moves, seconds, num, mode)
  local year, month, day, time = stat(90), stat(91), stat(92), seconds \ 60 .. ":" .. lzero(flr(seconds % 60))
  local report = "report " .. mode .. num .. "/" .. year .. "-" .. month .. "-" .. day .. "\n\n\n"
  local ckey = mode == "m" and CDATA.mscores or CDATA.ascores
  local stored, humans = dget(ckey - 1 + num), #filter(players, function(p) return not p.cpu end)


  for place, p in ipairs(players) do
    local prefix, score, smode =  p.cpu and "c" or "p", tostr(p.score), ""
    if humans == 1 and not p.cpu and p.score > stored then
      dset(ckey - 1 + num, p.score)
      if mode == "a" or stored ~= 0 then
        smode = " (" .. mode .. num .. " top)"
      end
    end
    report ..= place .. "st " .. prefix .. p.n .. " score: " .. pspace(score, 5) .. score .. smode .. "\n"
  end

  moves = tostr(moves)
  report ..= "\n" .. (
    "moves: " .. pspace(moves, 12) .. moves .. "\n\n" ..
    "time:  " .. pspace(time, 12) .. time
  )
  return function() return Typewriter:new { txt = report } end
end

