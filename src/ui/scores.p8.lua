function mission_scores(missions, offset)
  local entities = {
    Typewriter:new {
      txt = "mission scores",
    },
  }
  for i, m in ipairs(missions) do
    local num = i + offset
    local score, name = dget(CDATA.mscores + num - 1), m.n .. ":"
    add(
      entities,
      Typewriter:new {
        c = 6,
        speed = 1,
        y = i * 8 + 16,
        txt = name .. pspace(name, 25) .. pspace(tostr(score), 3) .. score,
      }
    )
  end
  return entities
end

function practice_scores(arenas, offset)
  local entities = {
    Typewriter:new {
      txt = "practice scores",
    },
  }
  for i, a in ipairs(arenas) do
    local num = i + offset
    local score, name = dget(CDATA.ascores + num - 1), "a" .. num .. " - " .. a[1] .. ": "
    add(
      entities,
      Typewriter:new {
        c = 6,
        speed = 1,
        y = i * 8 + 16,
        txt = name .. pspace(name, 25) .. pspace(tostr(score), 3) .. score,
      }
    )
  end
  return entities
end
