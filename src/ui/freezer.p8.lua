freezer = Entity:new {
  frames = 0,
  entities = {},
  callback = noop,

  update = function(_ENV)
    frames -= 1
    for e in all(entities) do
      e:update()
    end
    if frames == 0 then
      entities = {}
      callback()
    end
  end,

  draw = function(_ENV)
    for e in all(entities) do
      e:draw()
    end
  end,

  freeze = function(_ENV, fr, e, cb)
    frames += fr
    add(entities, e)
    callback = cb or noop
  end,
}
