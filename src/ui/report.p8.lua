function report(place, score, moves, seconds, num, top_score)
  local year, month, day = stat(90), stat(91), stat(92)
  local report = (
    "report " .. num .. "/" .. year .. "-" .. month .. "-" .. day .. "\n\n\n" ..
    "place: " .. place .. "\n\n" ..
    "score: " .. (score == 0 and "-" or score) .. (top_score and " (top)" or "") .. "\n\n" ..
    "moves: " .. moves .. "\n\n" ..
    "time: " .. seconds \ 60 .. ":" .. leading_zero(flr(seconds % 60))
  )
  return function() return typewriter:new { txt = report } end
end

