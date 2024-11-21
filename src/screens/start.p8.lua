function start()
  pal(0)
  if stat(24) <= 0 then
    music(0, 1000)
  end
  cls()
  menuitem(1)

  frz:freeze(40, Fade:new { rev = true })

  local CART = DATA.CART
  local num, done = dget(CART.mission), dget(CART.done) > 0

  SCENE = {
    art(cls),
    Stars:new { cols = COLORS },
    art(function()
      printb(ctrl .. "x5square", 38, 26, 1)
      printb(ctrl .. "x5square", 37, 25, 9)
      printb(ctrl .. "x8wars", 39, 42, 1)
      printb(ctrl .. "x8wars", 38, 41, 9)
      print("a game by horneds 2024\nmusic by gruber", 16, 114, 9)
    end),
    -- main menu
    Menu:new(nil, {
      {
        n = "infinite mode",
        cb = part(infinite),
        hide = not done,
      },
      {
        n = "continue (m" .. num + 1 .. ")",
        cb = part(_start, num + 1),
        hide = num < 2 or num >= #MISSIONS,
      },
      {
        n = "new story",
        cb = part(_start, 1),
      },
      { n = "scores", cb = scores, hide = not done },
      { n = "practice", cb = practice, hide = not done and num < 4 },
    }),
  }
end

function _start(num)
  frz:freeze(40, Fade:new {}, part(brief, num))
end
