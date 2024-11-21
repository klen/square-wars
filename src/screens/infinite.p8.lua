function infinite(seed)
  pal(0)
  local sd

  if not seed then
    dset(CART.run, 0)
    dset(CART.rscore, 0)
  end

  menu = Menu:new({ y = 88 }, {
    {
      n = seed and "continue" or "start",
      cb = function()
        start_seed(sd.seed)
      end,
    },
    not seed and {
      n = "edit seed",
      cb = function(self)
        frz:freeze(5, nil, function()
          menu.sel = 0
          sd.on = true
        end)
      end,
    } or nil,
    {
      c = 6,
      n = seed and "stop" or "back",
      cb = start,
    },
  })

  sd = Seed:new { menu = menu, seed = seed or Seed.gen() }
  local run, runmax, top = dget(CART.run), dget(CART.runmax), ""
  if not seed then
    dset(CART.runseed, sd.seed)
  end

  SCENE = {
    art(function()
      cls(1)
      print("infinite mode", 34, 16, 7)
      if seed then
        print("run seed:  " .. pspace(tostr(dget(CART.runseed)), 10), 16, 58, 6)
        print(
          "run done:  " .. pspace(tostr(run), 10) .. (run == runmax and " top!" or ""),
          16,
          66,
          6
        )
        print("run score: " .. pspace(tostr(dget(CART.rscore)), 10), 16, 74, 6)
      end
    end),
    menu,
    sd,
  }
end

function start_seed(seed)
  SCENE = {
    art(part(cls, 1)),
  }
  srand(seed)
  local a, eff, cpu = rint(#ARENAS, 1), rnd(split "dark,erosion,,,,,,"), {}
  for idx = 1, rint(3, 1) do
    add(cpu, rint(3, 1))
  end
  local ot, o = rint(6, 1), {}
  if ot == 3 then
    o[3] = map(split "1,4,2,3", qrnd)
  elseif ot == 4 then
    o[4] = map(split "1,2,3,4", qrnd)
  end
  game(
    { a = a, eff = eff, o = o },
    { a = a, human = 1, cpu = join(",", cpu), seed = rint(9999, 0), num = seed },
    63,
    63
  )
end

QD = split "0,10,200,210"
function qrnd(q)
  return QD[q] + rint(7, 1) * 20 + rint(7, 2)
end
