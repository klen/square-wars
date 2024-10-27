menu = entity:create {
  offset = 76,
  selected = 1,
  dir = { -1, 1, -1, 1, 1, 1 },

  init = function(_ENV, opts)
    options = {}
    foreach(opts, function(props)
      props.idx = #options
      props.offset = offset
      add(options, option:new(props))
    end)
    if #options > 0 then
      options[selected].selected = true
    end
  end,
  update = function(_ENV)
    local opt, btn = options[selected], getbtn()
    local d = dir[btn + 1]

    if btn == -1 then
      return
    elseif btn == 2 or btn == 3 then
      opt.selected = false
      repeat
        selected = (selected - 1 + d) % #options + 1
      until options[selected].disabled ~= true
      options[selected].selected = true
    else
      opt:callback(d)
    end
  end,
  draw = function(_ENV)
    foreach(options, function(opt)
      opt:draw()
    end)
  end,
}

option = entity:create {
  c = 7,
  idx = 0,
  name = "",
  offset = 76,
  selected = false,
  callback = function() end,
  draw = function(_ENV)
    print(
      (selected and "❎ " or "") .. name,
      selected and 4 or 16,
      offset + 8 * idx,
      selected and band(frames, 8) == 0 and (c - 1) or c
    )
  end,
}
