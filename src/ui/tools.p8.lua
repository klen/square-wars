function getbtn()
  for i = 0, 5 do
    if (btnp(i)) return i
  end
  return -1
end

function beep()
	?"\ai5e0"
end

function leading_zero(n)
  return n < 10 and "0" .. n or n
end

function frame()
  cls()
  rect(2, 2, 126, 96, 7)
end

confirmation = entity:create {
  txt = "",
  callback = noop,
  init = function(_ENV)
    txt = "❎ " .. txt
  end,
  update = function(_ENV)
    local btn = getbtn()
    if btn == 4 or btn == 5 then
      freeze_update(31, fade:new { callback = callback })
    end
  end,
  draw = function(_ENV)
    print(txt, 8, 104, band(frames, 8) == 0 and 6 or 7)
  end,
}
