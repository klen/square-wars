Editor = Ent:create {

  tile = 1,
  inv = {[7]=12, [12]=7},

  field = nil,

  init = function(_ENV)
    dir = { -1, 1, -field.s, field.s }

    for t in all(field.t) do
      if t.p == 0 do
        t.c = _ENV:color(t)
      end
    end

  end,

  update = function(_ENV)
    local btn = getbtn(0)
    local d = dir[btn + 1]

    -- move cursor
    if d then
      tile = (tile + d - 1) % field.s ^ 2 + 1

    -- set tile color
    elseif btn == 4 then
      local t = field.t[tile]
      if t.p == 0 then
        t.p = 5
        t.c = 1
      else
        t.p = 0
        t.c = _ENV:color(t)
      end

    -- copy tile data
    elseif btn == 5 then
      local res = {}

      for t in all(field.t) do
        if t.p == 5 then
          add(res, t.n)
        end
      end

      printh(join(",", unpack(res)), "@clip")
    end
  end,

  color = function(_ENV, t)
    local c = t.c
    c = (t.n - 1) % 4 < 2 and 7 or 12
    return t.n \ field.s % 4 < 2 and inv[c] or c
  end,

  draw = function(_ENV)
    field:draw_tile(tile, band(FRMS, 8) == 0 and 1 or 5)
    print(ARENAS[field.a][1], 0, 120, 5)
    print("tile: " .. tile, 84, 120, 5)
  end,
}

function join(d, s, ...)
  return not s and "" or not ... and s or s .. d .. join(d, ...)
end
