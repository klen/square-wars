function splash()
  cls()
  SCENE = {
    art(function()
      print("a long, long time ago", 8, 42, 12)
      print("in a square, square galaxy...", 8, 52, 12)
    end),
    Ent:new {
      update = function()
        if getbtn() ~= -1 then
          frz:freeze(40, Fade:new {}, start)
        end
      end,
    },
  }

  frz:freeze(80, Fade:new { rev = true, fr = 60 })
end
