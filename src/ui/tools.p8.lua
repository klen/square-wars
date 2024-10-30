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

function pspace(txt, w)
  local res = ""
  for i = #txt, w - 1 do
    res = " " .. res
  end
  return res
end

function frame()
  cls()
  rect(2, 2, 126, 104, 7)
end

Confirmation = Entity:create {
  y = 112,
  txt = "confirm",
  callback = noop,
  init = function(_ENV)
    txt = "❎ " .. txt
  end,
  update = function(_ENV)
    local btn = getbtn()
    if btn == 4 or btn == 5 then
      freeze_update(31, Fade:new { callback = callback })
    end
  end,
  draw = function(_ENV)
    print(txt, 8, y, band(frames, 8) == 0 and 6 or 7)
  end,
}
