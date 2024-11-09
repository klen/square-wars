pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include src/tools/str_tbl.p8.lua
#include src/data.p8.lua

function str_mem(txt)
  printh("__gfx__", "memdata", true)

  local l, size, idx, map = "", 128, 0, false
  for ch in all(txt) do
    local h = tostr(ord(ch), 0x1)
    if map then
      l = l .. sub(h, 5, 5) .. sub(h, 6, 6)
    else
      l = l .. sub(h, 6, 6) .. sub(h, 5, 5)
    end
    if #l == size then
      printh(l, "memdata")
      l = ""
      idx += 1
      if idx == 128 then
        printh("__map__", "memdata")
        idx, size, map = 0, 256, true
      end
    end
  end
  printh(l, "memdata")
end

str_mem(DATA_RAW)
