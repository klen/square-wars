local stringify = require "data.stringify"
local data = require "data.data"

local source = stringify.tbl_str(data)
local f = io.open("memdata.rom", "w")
io.output(f)
io.write "__gfx__\n"

local l, size, idx, map = "", 128, 0, false
for ch in source:gmatch "." do
  local h = string.format("%x", string.byte(ch))
  if map then
    l = l .. h
  else
    l = l .. string.sub(h, 2, 2) .. string.sub(h, 1, 1)
  end
  if #l == size then
    io.write(l .. "\n")
    l = ""
    idx = idx + 1
    if idx == 128 then
      io.write "__map__\n"
      idx, size, map = 0, 256, true
    end
  end
end
io.write(l .. "\n")
