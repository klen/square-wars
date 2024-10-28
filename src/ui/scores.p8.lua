function mission_scores()
  local entities = {
    typewriter:new {
      txt = "mission scores",
    },
  }
  for i, m in ipairs(missions) do
    if i > 1 then
      local score, name = dget(cdata.mscores + i - 1), m.n .. ":"
      add(
        entities,
        typewriter:new {
          c = 6,
          y = i * 8 + 8,
          txt = name .. pspace(name, 25) .. pspace(tostr(score), 3) .. score,
        }
      )
    end
  end
  return entities
end

function practice_scores()
  local entities = {
    typewriter:new {
      txt = "practice scores",
    },
  }
  for i, a in ipairs(arenas) do
    local score, name = dget(cdata.ascores + i - 1), "a" .. i .. " - " .. a[1] .. ": "
    add(
      entities,
      typewriter:new {
        c = 6,
        y = i * 8 + 16,
        txt = name .. pspace(name, 25) .. pspace(tostr(score), 3) .. score,
      }
    )
  end
  return entities
end
