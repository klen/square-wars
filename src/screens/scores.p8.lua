function scores()
  cls(1)

  local s1, s2, s3 =
    mission_scores(slice(MISSIONS, 2, 11), 1),
    mission_scores(slice(MISSIONS, 12), 11),
    practice_scores(slice(ARENAS, 1, 10), 0)

  SCENE = s3
  local conf = Conf:new { txt = "next" }
  conf.cb = function()
    if SCENE == s3 then
      SCENE = s1
    elseif SCENE == s1 then
      SCENE = s2
      conf.txt = "main menu"
    elseif SCENE == s2 then
      return start()
    end
    add(SCENE, conf)
    pal(0)
    cls(1)
  end

  add(SCENE, conf)
end
