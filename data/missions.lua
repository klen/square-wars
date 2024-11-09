return {

  --------------
  -- Episode I
  --------------

  -- 1 (1) awakening
  { f = { s = 5 }, j = {}, o = 1 },
  -- 2 (1) first test
  { f = { s = 8 }, j = { cpu = "1" }, u = { n = "continue" } },
  -- 3 (1) dual challenge
  { f = { s = 12 }, j = { cpu = "1,1" } },
  -- 4 (1) the proving
  {
    f = { s = 15 },
    j = { cpu = "1,1,1" },
    u = { n = "practice mode", s = "practice" },
  },
  -- 5 (1) final duel
  { f = { a = 2 }, j = { cpu = "2" }, u = { s = "arena" } },

  --------------
  -- Episode II
  --------------

  -- 6 (2) crossroad
  { f = { a = 3 }, j = { cpu = "1,1,1" }, u = { s = "arena" }, o = 2 },

  -- 7 (2) episode menu
  { c = 1 },

  -- 8 (2) master of white
  {
    r = 6,
    pwr = 1,
    f = { a = 12 },
    j = { cpu = "2" },
    u = { v = 1, s = "power", n = "power of white" },
  },

  -- 9 (2) master of red
  {
    r = 6,
    pwr = 2,
    f = { a = 13 },
    j = { cpu = "2", plc = { "1,20,381,400", "190,191,210,211" } },
    u = { v = 2, s = "power", n = "power of red" },
  },

  -- 10 (2) master of orange
  {
    r = 6,
    pwr = 4,
    f = { a = 14 },
    j = { cpu = "2", plc = { "64", "337" } },
    u = { v = 4, s = "power", n = "power of orange" },
  },

  -- 11 (2) master of yellow
  {
    r = 6,
    pwr = 8,
    f = { a = 15 },
    j = { cpu = "2", plc = { "127,274", "267,134" } },
    u = { v = 8, s = "power", n = "power of yellow" },
  },

  -- 12 (2) master of green
  {
    r = 6,
    pwr = 16,
    f = { a = 16 },
    j = { cpu = "2", plc = { "1,381", "20,400" } },
    u = { v = 16, s = "power", n = "power of green" },
  },

  -- 13 (2) master of blue
  {
    r = 6,
    pwr = 32,
    f = { a = 17 },
    j = { cpu = "2", plc = { "190", "211" } },
    u = { v = 32, s = "power", n = "power of blue" },
  },

  --------------
  -- Episode III
  --------------

  -- 14 (3) brothers
  { f = { a = 4 }, j = { cpu = "1,1,1" }, u = { s = "arena" }, o = 3 },

  -- 15 (3) obscura
  { f = { a = 5, eff = "dark" }, j = { cpu = "2,2" }, u = { s = "arena" } },

  -- 16 (3) mirror
  { f = { a = 6 }, j = { cpu = "2", plc = { "161,180", "221,240" } }, u = { s = "arena" } },

  -- 17 (3) collapse
  { f = { a = 1, eff = "erosion" }, j = { cpu = "2,2" } },

  -- 18 (3) labyrinth
  { f = { a = 7 }, j = { cpu = "2,2,2" }, u = { s = "arena" } },

  -- 19 (3) cage
  { f = { a = 8, eff = "portals" }, j = { cpu = "2,2,2" }, u = { s = "arena" } },

  -- 20 (3) lines
  { f = { a = 9 }, j = { cpu = "2,2,2" }, u = { s = "arena" } },

  -- 21 (3) spikes
  { f = { a = 10, eff = "bombs" }, j = { cpu = "2,2,2" }, u = { s = "arena" } },

  -- 22 (3) apex
  {
    f = { a = 11 },
    u = { s = "square master" },
    j = { cpu = "2,2,2", plc = { "85", "316", "96", "305" } },
  },
}
