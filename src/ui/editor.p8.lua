Editor = Ent:create {

  tile = 1,
  inv = {[1]=6, [6]=1},

  field = nil,

  init = function(_ENV)
    dir = { -1, 1, -field.s, field.s }

    for t in all(field.t) do
      if t:free() then
        t.c = _ENV:color(t)
      end
    end

    menuitem(1, "copy arena walls", function()
      local res = {}

      for t in all(field.t) do
        if t.tp == 1 then
          add(res, hex(t.n))
        end
      end

      printh(join(",", res), "@clip")
    end)

  end,

  update = function(_ENV)
    local btn = getbtn(0)
    local d = dir[btn + 1]

    -- move cursor
    if d then
      tile = (tile + d - 1) % field.s ^ 2 + 1

    -- update tile
    elseif btn == 4 then
      local t = field.t[tile]
      local tp = t.tp or 0
      t.tp = (tp + 1) % 5
      if t.tp == 1 then
        t.c = nil
        t.av = false
      else
        t.p = nil
        t.c = _ENV:color(t)
      end

    -- delete tile
    elseif btn == 5 then
      local t = field.t[tile]
      t.p = nil
      t.tp = nil
      t.c = _ENV:color(t)
    end
  end,

  color = function(_ENV, t)
    local c = t.c
    c = (t.n - 1) % 4 < 2 and 1 or 6
    return t.n \ field.s % 4 < 2 and inv[c] or c
  end,

  draw = function(_ENV)
    local t = field.t[tile]
    local c = t.c
    t.c = band(FRMS, 8) == 0 and 0 or c
    t:draw(field.s, field.off, field.ts)
    t.c = c
    print(ARENAS[field.a][1], 0, 120, 5)
    print("tile: " .. tile .. ":" .. hex(tile), 56, 120, 5)
  end,
}

function hex(v) 
  local s,l,r=tostr(v,true),3,11
  while(ord(s,l)==48) l+=1
  while(ord(s,r)==48) r-=1
  return sub(s,min(l,6),r>7 and r or 6)
end
