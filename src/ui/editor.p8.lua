Editor = Entity:create {

  tile = 1,
  field = nil,

  init = function(_ENV)
    dir = { -1, 1, -field.size, field.size }
  end,

  update = function(_ENV)
    local btn = getbtn(0)
    local d = dir[btn + 1]

    -- move cursor
    if d then
      tile = (tile + d - 1) % field.size ^ 2 + 1

    -- set tile color
    elseif btn == 4 then
      local t = field.tiles[tile]
      if t.p == 0 then
        t.p = 5
        t.c = 0
      else
        t.p = 0
        t.c = rndcolor()
      end

    -- copy tile data
    elseif btn == 5 then
      local res = {}

      for t in all(field.tiles) do
        if t.p == 5 then
          add(res, t.n)
        end
      end

      printh(join(",", unpack(res)), "@clip")
    end
  end,

  draw = function(_ENV)
    draw_tile({ n = tile, c = 0 }, 20, 0)
  end,
}

function join(d, s, ...)
  return not s and "" or not ... and s or s .. d .. join(d, ...)
end
