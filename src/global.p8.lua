function mem_str()
  local i, res = 0, ""
  while i < 0x3000 do
    res ..= chr(peek(i))
    i += 1
  end
  return res
end

DATA = str_tbl(mem_str())
CART = DATA.CART
COLORS = DATA.COLORS
CCR = COLORS[1] - 1
MISSIONS = DATA.MISSIONS
ARENAS = DATA.ARENAS

function mem_txt(txt)
  return join("\n", split(txt, "/"))
end

for m in all(MISSIONS) do
  m.b = mem_txt(m.b)
  if m.o then
    m.o = mem_txt(m.o)
  end
end
