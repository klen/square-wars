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
MISSIONS = DATA.MISSIONS
ARENAS = DATA.ARENAS
BRIEFS = DATA.BRIEFS

OPENS = {
  [[episode i: the square academy

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
  [[episode ii: the powers awaken

now, the hero must challenge
the masters of power.

six legendary square masters
stand ready to test you.

each victory grants new power,
but the path is fraught
with peril.

will the hero's powers
be enough to confront
the looming shadow?
]],
  [[episode iii:
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
}
