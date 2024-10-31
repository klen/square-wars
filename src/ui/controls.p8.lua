-- globals: colors
--
Controls = Entity:create {
  scolor = 0,
  judge = nil,
  power = nil,

  init = function(_ENV)
    scolor = judge:move_color(scolor, function(c)
      return (c % #COLORS) + 1
    end)
  end,

  update = function(self)
    local judge = self.judge
    local dir, p = { -1, 1, 1, -1 }, judge:get_active()

    if p.cpu then
      local targets = get_targets(p, judge)
      if #targets == 0 then
        return self:move(judge:move_color(rndcolor(), rndcolor))
      end
      local bot = ai[p.cpu]
      self:move(bot(targets))
    else
      local btn = getbtn(judge.active - 1)
      if btn < 0 then
        return
      end
      if btn < 4 then
        local d = dir[btn + 1]
        self.scolor = judge:move_color(self.scolor, function(c)
          return (c + d - 1) % #COLORS + 1
        end, p.w)
        beep()
      else
        sfx(63)
        self:move(self.scolor)
      end
    end
  end,

  draw = function(_ENV)
    local p = judge:get_active()

    for idx = 1, #COLORS do
      local c, s = COLORS[idx], idx * 8 - 8

      if idx == scolor then
        rectfill(s, 120, s + 6, 126, c)
      elseif judge:color_available(idx, p.w) then
        rectfill(s + 1, 121, s + 5, 125, c)
      else
        rect(s + 1, 121, s + 5, 125, c)
      end
    end
    local w, active = 51, judge.active
    for p in all(judge.players) do
      local n, c, t = p.n, COLORS[p.c], tostr(#p.t)
      w = print((n == active and inv or "") .. pspace(t, 3) .. t, w + 5, 121, c)
    end
  end,

  move = function(_ENV, c)
    judge:move(c)
    if power then
      power:move(c)
    end

    local p = judge:get_active()
    scolor = judge:move_color(p.c, function(c)
      return (c % #COLORS) + 1
    end, p.w)

    freeze_update(5 + rnd(10))

    judge:finish()
  end,
}

function get_targets(p, judge)
  local targets, seen = {}, {}
  for tn in all(p.t) do
    local t = judge.field.tiles[tn]
    for f in all(t.hvrel) do
      if f.p == 0 then
        if not seen[f.n] then
          seen[f.n] = true
          if judge:color_available(f.c) then
            add(targets, f)
          end
        end
      end
    end
  end
  return targets
end

function get_clusters(targets)
  local seen, clusters, res = {}, { [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {} }, {}
  for t in all(targets) do
    local c = cluster(t)
    local cnum = c[1].n
    if not seen[cnum] then
      seen[cnum] = true
      for f in all(c) do
        add(clusters[t.c], f)
      end
    end
  end
  clusters = sort(clusters, function(a, b)
    return #a > #b
  end)
  return filter(clusters, function(c)
    return #c > 0
  end)
end

-- random bot
function bot1(targets)
  return rnd(targets).c
end

-- greedy bot (selects the target with biggest cluster)
function bot2(targets)
  return get_clusters(targets)[1][1].c
end

ai = { bot1, bot2 }
