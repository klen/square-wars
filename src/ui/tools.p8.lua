function getbtn(p)
  for i = 0, 5 do
    if (btnp(i, p)) return i
  end
  return -1
end

function beep()
	?"\ai5e0"
end

function lzero(n)
  return n < 10 and "0" .. n or n
end

function pspace(txt, w, sp)
  local res, s = txt, sp or " "
  for _ = #txt, w - 1 do
    res = s .. res
  end
  return res
end

function frame(h)
  h = h or 104
  rect(0, 1, 127, h + 4, 10)
  for t in all({{0, 1}, {123, 1}, {0, h}, {123, h}}) do
    local x, y = t[1], t[2]
    clip(x, y, x + 4, y + 4)
    rectfill(0, 0, 127, 127, 0)
    circ(x == 0 and 4 or 123, y == 1 and 5 or h, 4, 10)
  end

  clip()
  line(2, 5, 2, h, 8)
  line(125, 5, 125, h, 8)
end

Conf = Ent:create {
  y = 112,
  cb = nil,
  txt = "confirm",
  update = function(_ENV)
    local btn = getbtn()
    if btn == 4 or btn == 5 then
      frz:freeze(40, Fade:new {}, cb )
    end
  end,
  draw = function(_ENV)
    print("❎", 4, y, band(FRMS, 8) == 0 and 1 or 12)
    print(txt, 16, y, 12)
  end,
}
