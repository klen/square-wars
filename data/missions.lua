return {

  --------------
  -- Episode I
  --------------

  -- 1 (1) awakening
  ------------------
  {
    n = "awakening",
    f = { s = 5 },
    j = {},

    b = [[begins your journey does.
know the field, you must;
choose your color wisely,
and claim it, you will.]],

    o = [[episode i: the square academy

in the distant corners
of the square galaxy,
a young hero begins
their journey.

drawn to the hallowed halls
of the square academy,
they are determined to master
the arts of square warfare.
under the watchful eyes of
mysterious mentors,
their training begins.

the path to greatness is set, and
the first battle awaits...]],
  },

  -- 2 (1) first test
  -------------------
  {
    n = "first test",
    f = { s = 8 },
    j = { cpu = "1" },
    u = { n = "continue" },
    b = [[an adversary appears.
slow, they are observe
their path,
learn well
the ways of the square.]],
  },

  -- 3 (1) dual challenge
  -----------------------
  {
    n = "dual challenge",
    f = { s = 12 },
    j = { cpu = "1,1" },
    b = [[two foes stand before you.
a trial of focus and skill
ready to advance,
you must be.]],
  },

  -- 4 (1) the proving
  --------------------
  {
    n = "the proving",
    f = { s = 15 },
    j = { cpu = "1,1,1" },
    u = { n = "practice mode", s = "practice" },
    b = [[in the academy,
not easy it is.
students clash, to find
the one worthy
to advance.]],
  },

  -- 5 (1) final duel
  -------------------
  {
    n = "final duel",
    f = { a = 2 },
    j = { cpu = "2" },
    u = { s = "arena" },
    b = [[awaits the academy's
finest student, on
the true arena. only
through victory here,
a graduate you become.]],
  },

  --------------
  -- Episode II
  --------------

  -- 6 (2) crossroad
  ------------------
  {
    n = "crossroad",
    f = { a = 3 },
    j = { cpu = "1,1,1" },
    u = { s = "arena" },
    b = [[contenders clash here,
each seeking the path
to the masters of power.
prove your worth, you must.]],
    o = [[episode ii: the powers awaken

now, the hero must challenge
the masters of power.

six legendary square masters
stand ready to test you.

each victory grants new power,
but the path is fraught
with peril.

will the hero powers
be enough to confront
the looming shadow?]],
  },

  -- 7 (2) episode menu
  ---------------------
  {
    n = "path of masters",
    c = 1,
    b = [[no sense entering
the championship without
powers. visit the masters,
learn their skill. gray
holds no power choose wisely.]],
  },

  -- 8 (2) master of snow
  -----------------------
  {
    n = "master of snow",
    r = 6,
    pwr = 1,
    f = { a = 12 },
    j = { cpu = "2" },
    u = { v = 1, s = "power", n = "power of snow" },
    b = [[guardian of clarity,
i am. the field lies
blanketed in snow; patience
and precision you need.
show me calm resolve,
and my power is yours.]],
  },

  -- 9 (2) master of fire
  -----------------------
  {
    n = "master of fire",
    r = 6,
    pwr = 2,
    f = { a = 13 },
    j = { cpu = "2", plc = { "1,20,381,400", "190,191,210,211" } },
    u = { v = 2, s = "power", n = "power of fire" },
    b = [[fury and speed,
my strength lies in. from
the center, i blaze outward
halt my advance, prove
yourself bold, and
claim my fire.]],
  },

  -- 10 (2) master of desert
  --------------------------
  {
    n = "master of desert",
    r = 6,
    pwr = 4,
    f = { a = 14 },
    j = { cpu = "2", plc = { "64", "337" } },
    u = { v = 4, s = "power", n = "power of desert" },
    b = [[endless sands, my domain
in the desert, endurance
and cunning will prevail.
prove your strength,
and take my power.]],
  },

  -- 11 (2) master of sun
  -----------------------
  {
    n = "master of sun",
    r = 6,
    pwr = 8,
    f = { a = 15 },
    j = { cpu = "2", plc = { "127,274", "267,134" } },
    u = { v = 8, s = "power", n = "power of sun" },
    b = [[rays of light, i command
from the core, all
paths radiate. withstand
the blazing field, and
my power you will gain.]],
  },

  -- 12 (2) master of woods
  -------------------------
  {
    n = "master of woods",
    r = 6,
    pwr = 16,
    f = { a = 16 },
    j = { cpu = "2", plc = { "1,381", "20,400" } },
    u = { v = 16, s = "power", n = "power of woods" },
    b = [[life and resilience,
the source of my strength.
the forest twists around
only the grounded endure.
root yourself,
and my power is yours.]],
  },

  -- 13 (2) master of storm
  -------------------------
  {
    n = "master of storm",
    r = 6,
    pwr = 32,
    f = { a = 17 },
    j = { cpu = "2", plc = { "190", "211" } },
    u = { v = 32, s = "power", n = "power of storm" },
    b = [[depth and mystery,
my domain. the whirlpool
of battle awaits-sink, or
swim, you must. mastery
will bring you my power.]],
  },

  --------------
  -- Episode III
  --------------

  -- 14 (3) brothers
  -------------------------
  {
    n = "brothers",
    f = { a = 4 },
    j = { cpu = "2,1,1" },
    u = { s = "arena" },
    b = [[the championship begins.
rookies from all around
join the field show
your skill to advance
to the next round.]],
    o = [[episode iii:
return of the champion

far across the square galaxy,
the annual square championship
begins on the legendary
square planet.

armed with the powers
our hero arrives
to face the ultimate opponents.

this is the final challenge
the championship to prove
who truly deserves

the title of square master]],
  },

  -- 15 (3) cage
  -------------------------
  {
    n = "warp field",
    f = { a = 5, o = { [3] = "40,fd,151,94,4d,f8,144,99" } },
    j = { cpu = "2,1,2" },
    u = { s = "arena" },
    b = [[new paths open, as
portals appear on the field.
use them wisely to pass
your opponents,
and claim victory.]],
  },

  -- 16 (3) mirror
  -------------------------
  {
    n = "mirror",
    f = { a = 6 },
    j = { cpu = "2", plc = { "161,180", "221,240" } },
    u = { s = "arena" },
    b = [[a lone opponent from
the mirror planet awaits.
they reflect your every move
determined to knock you
out of the games.]],
  },

  -- 17 (3) obscura
  -------------------------
  {
    n = "obscura",
    f = { a = 7, eff = "dark" },
    j = { cpu = "2" },
    u = { s = "arena" },
    b = [[your progress, they
have noticed. the master
of darkness arrives, seeking
to halt you here.]],
  },

  -- 18 (3) labyrinth
  -------------------------
  {
    n = "labyrinth",
    f = { a = 8 },
    j = { cpu = "2,2,2" },
    u = { s = "arena" },
    b = [[the last qualifier
before the final rounds.
navigate this maze,
and earn your place
among the elite.]],
  },

  -- 19 (3) collapse
  -------------------------
  {
    n = "collapse",
    f = { a = 1, eff = "erosion" },
    j = { cpu = "2,2" },
    u = { n = "practice modes" },
    b = [[the field begins to
crumble beneath you.
someone seeks to halt
the contenders progress.]],
  },

  -- 20 (3) lines
  -------------------------
  {
    n = "lines",
    f = { a = 9 },
    j = { cpu = "2,2,2" },
    u = { s = "arena" },
    b = [[a race against time.
move swiftly between
sections, or be left
behind in the dust.]],
  },

  -- 21 (3) spikes (bombs)
  -------------------------
  {
    n = "spikes",
    f = { a = 10, o = { [4] = "55,13c,60,131" } },
    j = { cpu = "2,2,2" },
    u = { s = "arena" },
    b = [[victory is within reach,
yet bombs now cover
the field. every step
must be careful if
you are to succeed.]],
  },

  -- 22 (3) apex
  -------------------------
  {
    n = "apex",
    f = { a = 11 },
    u = { n = "square master" },
    j = { cpu = "2,2,2", plc = { "85", "316", "96", "305" } },
    b = [[the final battle awaits.
to earn the champion title,
you must wield every power
at your command.
prove your mastery
once and for all.]],
  },
}
