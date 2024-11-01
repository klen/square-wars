function show_scores()
  cls(1)

  local scene1, scene2, scene3, scene4 =
    mission_scores(slice(MISSIONS, 2, 11), 1),
    mission_scores(slice(MISSIONS, 12, #MISSIONS), 11),
    practice_scores(slice(ARENAS, 1, 10), 0),
    practice_scores(slice(ARENAS, 11, #ARENAS), 10)

  SCENE = scene1

  add(
    SCENE,
    Confirmation:new {
      txt = "next",
      callback = function(self)
        if SCENE == scene1 then
          SCENE = scene2
        elseif SCENE == scene2 then
          SCENE = scene3
        elseif SCENE == scene3 then
          SCENE = scene4
          self.txt = "main menu"
        elseif SCENE == scene4 then
          return show_start()
        end
        add(SCENE, self)
        cls(1)
      end,
    }
  )
end
