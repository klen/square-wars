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
