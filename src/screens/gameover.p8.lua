function gameover()
  frame()
  music(6, 1000)
  dset(CART.done, 1)

  local ts, tc = time(), dget(CART.time)
  local min, sec = tc \ 60, flr(tc % 60)

  credits(mem_txt(DATA.FINAL), {
      Tw:new {
        txt = "you have done " .. #MISSIONS .. " missions",
      },
      Tw:new {
        txt = "total score: " .. dget(CART.score),
        y = 32, c = 6,
      },
      Tw:new {
        txt = "total time: " .. min .. ":" .. lzero(sec, 10),
        y = 46, c = 6,
      },
      Conf:new {
        txt = "view stats",
        cb = function()
          pal(0)
          SCENE = mission_scores(slice(MISSIONS, 2, 11), 1)
          add(SCENE, Conf:new {
              txt = "next",
              cb = function()
                pal(0)
                SCENE = mission_scores(slice(MISSIONS, 12), 11)
                add(SCENE, Conf:new {
                    txt = "view credits",
                    cb = function()
                      pal(0)
                      SCENE = {
                        Tw:new {
                          txt = "square wars",
                        },
                        Tw:new {
                          txt = "a game by horneds 2024",
                          y = 32,
                        },
                        Tw:new {
                          txt = "music composed by gruber",
                          y = 48,
                        },
                        Tw:new {
                          txt = "thanks for playing!",
                          y = 86,
                          c = 12,
                        },
                        Conf:new {
                          txt = "main menu",
                          cb = function()
                            pal(0)
                            music(-1)
                            start()
                          end,
                        },
                      }
                    end,
                })
              end,
          })
        end,
      },
  })
end
