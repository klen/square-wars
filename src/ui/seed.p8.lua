Seed = Ent:create {
  pos = 1,
  on = false,
  -- seed = nil,
  -- menu = nil,
  init = function(self)
    seed = seed or self:gen()
  end,
  update = function(_ENV)
    if on then
      local btn = getbtn()
      if btn == -1 then
        return
      end

      local d = Menu.dir[btn + 1]
      if btn == 0 or btn == 1 then
        pos = (pos - 1 + d) % 4 + 1
      elseif btn == 2 or btn == 3 then
        seed = mid(0, d * -10 ^ (4 - pos) + seed, 9999)
      else
        frz:freeze(5, nil, function()
          on = false
          menu.sel = 1
        end)
      end
    end
  end,
  draw = function(_ENV)
    local s, lp = pseed(seed), (pos - 1) * 15 + 35
    printb(sub(s, 1, 1), 35, 32, 7)
    printb(sub(s, 2, 2), 50, 32, 7)
    printb(sub(s, 3, 3), 65, 32, 7)
    printb(sub(s, 4, 4), 80, 32, 7)
    if on then
      line(lp, 46, lp + 6, 46, band(FRMS, 8) == 0 and 1 or 7)
    end
  end,
  gen = part(rint, 9999, 0),
}

function pseed(seed)
  return pspace(tostr(seed), 4, "0")
end
