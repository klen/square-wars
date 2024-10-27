controls = entity:create {
  field = nil,
  judge = nil,
  scolor = 0,

  init = function(_ENV)
    scolor = judge:move_color(scolor, function(c)
      return (c % #colors) + 1
    end)
  end,

  update = function(self)
    local judge = self.judge
    local dir, p = { -1, 1, 1, -1 }, judge:get_active()

    if judge.finished then
      return
    end

    if p.cpu then
      self:move(bot1(self.field, judge))
    else
      local btn = getbtn()
      if btn < 0 then
        return
      end
      if btn < 4 then
        local d = dir[btn + 1]
        self.scolor = judge:move_color(self.scolor, function(c)
          return (c + d - 1) % #colors + 1
        end)
        beep()
      else
        self:move(self.scolor)
      end
    end
  end,

  draw = function(self)
    for idx = 1, #colors do
      local c, s = colors[idx], idx * 8 - 8
      if idx == self.scolor then
        rectfill(s, 120, s + 6, 126, c)
      elseif self.judge:color_available(idx) then
        rectfill(s + 1, 121, s + 5, 125, c)
      else
        rect(s + 1, 121, s + 5, 125, c)
      end
    end
  end,

  move = function(_ENV, c)
    judge:move(c)
    scolor = judge:move_color(judge:get_active().c, function(c)
      return (c % #colors) + 1
    end)
  end,
}

function bot1(field, judge)
  local neighbours, cache, p = {}, {}, judge:get_active()
  for t in all(p.t) do
    for n in all(field:get_neighbours(t)) do
      if judge:color_available(n.c) then
        cache[n.n] = n -- keep unique
      end
    end
  end

  for _, t in pairs(cache) do
    add(neighbours, t)
  end
  return #neighbours > 0 and rnd(neighbours).c or judge:move_color(rndcolor(), rndcolor)
end
