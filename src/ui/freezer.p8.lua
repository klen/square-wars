frz = Ent:new {
  fr = 0,
  es = {},
  cb = noop,

  update = function(_ENV)
    fr -= 1
    for e in all(es) do
      e:update()
    end
    if fr == 0 then
      es = {}
      cb()
    end
  end,

  draw = function(_ENV)
    for e in all(es) do
      e:draw()
    end
  end,

  freeze = function(_ENV, _fr, e, _cb)
    fr += _fr
    add(es, e)
    cb = _cb or noop
  end,
}

function pause(cb)
  local st = false
  frz.fr += 1
  add(frz.es, {
    update = function()
      if getbtn() ~= -1 then
        st = true
        frz.fr = 1
        if cb then
          cb()
        end
      elseif not st then
        frz.fr += 1
      end
    end,

    draw = function()
      if not st then
        rectfill(30, 106, 88, 114, 0)
        print("press any key", 34, 108, band(FRMS, 16) == 0 and 7 or 6)
      end
    end,
  })
end
