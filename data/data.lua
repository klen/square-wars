local ARENAS = require "data.arenas"
local MISSIONS = require "data.missions"

function update_cr(txt)
  return txt:gsub("\n", "/")
end

DATA = {
  -- white (1), red (2), orange (4), yellow (8), green (16), blue (32)
  COLORS = { 7, 8, 9, 10, 11, 12, 5 },
  CART = {
    done = 0,
    palette = 1,
    mission = 2,
    run = 3,
    rscore = 4,
    arena = 5,
    score = 6,
    time = 7,
    runmax = 8,
    power = 9,
    runseed = 10,
    mscores = 11,
    ascores = 41,
  },

  ARENAS = ARENAS,
  BRIEFS = BRIEFS,
  MISSIONS = MISSIONS,
  FINAL = update_cr [[victory is yours!

through every challenge,
you have triumphed.
with every power mastered,
you now stand as
the true square master
and champion of square wars.

yet remember, the journey
does not end here.
legends say new rivals await
across the galaxy,
preparing for their chance
to claim the title.]],
}

for i, m in ipairs(DATA.MISSIONS) do
  m.b = update_cr(m.b)
  if m.o then
    m.o = update_cr(m.o)
  end
end

return DATA
