function mission_scores(missions, off)
  local entities = {
    Tw:new { txt = "mission scores" },
  }
  for i, m in ipairs(missions) do
    local num = i + off
    local score, name = dget(CART.mscores + num - 1), m.n .. ":"
    add(
      entities,
      Tw:new {
        txt = name .. pspace("", 25 - #name) .. pspace(tostr(score), 3),
        y = i * 8 + 16,
        c = 6,
      }
    )
  end
  return entities
end

function practice_scores(arenas, off)
  local entities = {
    Tw:new { txt = "practice scores" },
  }
  for i, a in ipairs(arenas) do
    local num = i + off
    local score, name = dget(CART.ascores + num - 1), "a" .. num .. " - " .. a[1] .. ": "
    add(
      entities,
      Tw:new {
        txt = name .. pspace("", 25 - #name) .. pspace(tostr(score), 3),
        y = i * 8 + 16,
        c = 6,
      }
    )
  end
  return entities
end
