function show_scores()
  cls(1)

  local mdata, pdata, confirm = mission_scores(), practice_scores()

  scene = mdata
  add(
    scene,
    confirmation:new {
      txt = "practice scores",
      callback = function()
        scene = pdata
        add(
          scene,
          confirmation:new {
            txt = "main menu",
            callback = show_start,
          }
        )
        cls(1)
      end,
    }
  )
end
