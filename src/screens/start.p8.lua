function start()
  if stat(24) <= 0 then
    music(0, 1000)
  end
  cls()
  menuitem(1)

  frz:freeze(40, Fade:new { rev = true })

  local CART = DATA.CART
  local num, train, done = dget(CART.mission), dget(CART.practice), dget(CART.done)

  SCENE = {
    -- clear the scene (we don't use cls because of the fade)
    -- art(function()
    --   rectfill(0, 0, 127, 127, 1)
    -- end),
    -- field
    -- Fd:new { s = 12, off = 16 },
    -- the title
    art(cls),
    Stars:new { cols = COLORS },
    art(function()
      -- rectfill(0, 48, 127, 127, 1)
      printb(ctrl .. "x5square", 38, 26, 1)
      printb(ctrl .. "x5square", 37, 25, 9)
      printb(ctrl .. "x8wars", 39, 42, 1)
      printb(ctrl .. "x8wars", 38, 41, 9)
      print("a game by horneds 2024\nmusic by gruber", 16, 114, 9)
    end),
    -- main menu
    Menu:new(nil, {
      num > 1 and num < #MISSIONS and {
        n = "continue (m" .. num + 1 .. ")",
        cb = function()
          _start(num + 1)
        end,
      } or nil,
      {
        n = "new story",
        cb = function()
          _start(1)
        end,
      },
      done > 0 and { n = "scores", cb = scores } or nil,
      train > 0 and { n = "practice", cb = practice } or nil,
    }),
  }
end

function _start(num)
  frz:freeze(40, Fade:new {}, function()
    brief(num)
  end)
end
