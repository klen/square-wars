pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- square wars editor
-- by horneds

#include src/tools/class.p8.lua
#include src/tools/common.p8.lua

#include src/global.p8.lua

#include src/ui/tools.p8.lua
#include src/ui/tile.p8.lua
#include src/ui/field.p8.lua
#include src/ui/menu.p8.lua
#include src/ui/editor.p8.lua

#include src/screens/editor.p8.lua
#include src/update.p8.lua
#include src/draw.p8.lua

function _init()
  init()
end

function _update()
  update()
end

function _draw()
  draw()
end

