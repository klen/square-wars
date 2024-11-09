local ARENAS = require "data.arenas"
local MISSIONS = require "data.missions"

DATA = {
  -- white (1), red (2), orange (4), yellow (8), green (16), blue (32)
  COLORS = { 6, 7, 8, 9, 10, 11, 12 },
  -- stylua: ignore start
  -- TODO: slot 3 is empty
  CART = {
    done=0, palette=1, mission=2, practice=4, arena=5, score=6, time=7, power=9, mscores=11, ascores=41
  },

  ARENAS = ARENAS,
  BRIEFS = BRIEFS,
  MISSIONS = MISSIONS,
}

for i, m in ipairs(DATA.MISSIONS) do
  m.b = m.b:gsub("\n", "/")
  if m.o then
    m.o = m.o:gsub("\n", "/")
  end
end

return DATA
