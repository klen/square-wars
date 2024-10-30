pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- square wars
-- by horneds

#include src/tools/class.p8.lua
#include src/tools/common.p8.lua

#include src/data.p8.lua

#include src/effects/fade.p8.lua
#include src/effects/typewriter.p8.lua

#include src/ui/tools.p8.lua
#include src/ui/palette.p8.lua
#include src/ui/menu.p8.lua
#include src/ui/tile.p8.lua
#include src/ui/field.p8.lua
#include src/ui/controls.p8.lua
#include src/ui/judge.p8.lua
#include src/ui/report.p8.lua
#include src/ui/scores.p8.lua
#include src/ui/power.p8.lua

#include src/screens/start.p8.lua
#include src/screens/brief.p8.lua
#include src/screens/mission.p8.lua
#include src/screens/results.p8.lua
#include src/screens/gameover.p8.lua
#include src/screens/practice.p8.lua
#include src/screens/scores.p8.lua

#include src/init.p8.lua
#include src/update.p8.lua
#include src/draw.p8.lua

#include src/screens/debug.p8.lua
#include src/tools/debug.p8.lua

inv = "\^i"

function _init()
	init()
end

function _update60()
	update()
end

function _draw()
	draw()
end



-->8
-- draw

function draw_tile(t, size, offset)
  local idx = t.n - 1
  local s = size > 15 and 6 or 8
  local x, y = idx % size * s + offset, idx \ size * s + offset
  if (t.p == 0) then
    rectfill(x, y, x + s - 2, y + s - 2, colors[t.c])
  else
    rect(x, y, x + s - 2, y + s - 2, colors[t.c] or 1)
  end
end
-->8
-- tools

function printb(t, x, y, c)
	print("\^w\^t\^=" .. t, x, y, c)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
1111111111111111aaaaaaa188888881aaaaaaa1aaaaaaa18888888199999991ccccccc18888888199999991bbbbbbb199999991ccccccc11111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
1111111111111111bbbbbbb1777777718888888177777771ccccccc1aaaaaaa177777771ccccccc1bbbbbbb19999999188888881888888811111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
111111111111111188888881aaaaaaa188888881bbbbbbb1ccccccc1888888817777777177777771ccccccc1bbbbbbb1bbbbbbb1999999911111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
1111111111111111bbbbbbb199999991aaaaaaa17777777199999991ccccccc199999991ccccccc1aaaaaaa1aaaaaaa177777771777777711111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111171711111711111711171117171711171717111717171111111111171117111717171117171711111717111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111117111111171117111711171117111711171117111711111111111111171117111711171117111711171111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111117171711171117111711171117171711171711111717111111111111171117111717171117171111171717111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111711171711111711171117111711171117111711111111111111171717111711171117111711111117111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111117171111111717111117171117111711171117111717171111111111171717111711171117111711171711111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111777771111117711777171711111177177717771777177717771177177111111111111111111111111111111111111111111111111111111111111111111
11117717177111117171711171711111711171717771717171711711711171711111111111111111111111111111111111111111111111111111111111111111
11117771777111117171771171711111711177717171777177711711711171711111111111111111111111111111111111111111111111111111111111111111
11117717177111117171711177711111711171717171711171711711717171711111111111111111111111111111111111111111111111111111111111111111
11111777771111117171777177711111177171717171711171717771777171711111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111116661111116616661666166611111666161611111616116616661661166616611166111116661666166616161111111111111111111111111
11111111111111116161111161116161666161111111616161611111616161616161616161116161611111111161616111616161111111111111111111111111
11111111111111116661111161116661616166111111661166611111666161616611616166116161666111116661616166616661111111111111111111111111
11111111111111116161111161616161616161111111616111611111616161616161616161116161116111116111616161111161111111111111111111111111
11111111111111116161111166616161616166611111666166611111616166116161616166616661661111116661666166611161111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111116661616116616661166111116661616111111661666161616661666166611111111111111111111111111111111111111111111111111111
11111111111111116661616161111611611111116161616111116111616161616161611161611111111111111111111111111111111111111111111111111111
11111111111111116161616166611611611111116611666111116111661161616611661166111111111111111111111111111111111111111111111111111111
11111111111111116161616111611611611111116161116111116161616161616161611161611111111111111111111111111111111111111111111111111111
11111111111111116161166166116661166111116661666111116661616116616661666161611111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

__sfx__
000a000007550075500a5500c5500c5500c5500c5500f5500f550115501155013550135501355013550115500f5500f5500f55000500005000050000500005000050000500005000050000500005000050000500
000400000a75013750187501f7501d7501b7501875018750167501375013750297000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
011400000c0330253502525020450e6150252502045025250c0330253502525020450e6150252502045025250c0330252502045025350e6150204502535025250c0330253502525020450e615025250204502525
011400001051512515150151a5151051512515150151a5151051512515150151a5151051512515150151a5151051512515170151c5151051512515170151c5151051512515160151c5151051512515160151c515
011400002c7252c0152c7152a0252a7152a0152a7152f0152c7252c0152c7152801525725250152a7252a0152072520715207151e7251e7151e7151e715217152072520715207151e7251e7151e7151e7151e715
011400000c0330653506525060450e6150652506045065250c0330653506525060450e6150652506045065250c0330952509045095350e6150904509535095250c0330953509525090450e615095250904509525
0114000020725200152071520015217252101521715210152c7252c0152c7152c0152a7252a0152a7152a015257252501525715250152672526015267153401532725310152d715280152672525015217151c015
0114000020734200351c7341c0351973419535157343952520734200351c7341c0351953219035147341503121734210351c7341c0261973419035237341703521734395251c7341c03519734195351773717035
011400000c053021651e7240206524615197450e7650c05302165020651e7341e7350256524615020650e56501165010651e7240c05324615167230b0450d0650c05301165197440b56520724246150106515555
0114000020724200251c7241c02525742287421572439525207242a7422c7412c7322c72219025147242a74228742287451c7341e7421e7421e735237241702521724395251c7341c03519734195351773617035
011400000c043090552072409055246151972315555090550c053090651972309565207242461509065155650c053060652072406065246151672306065125650c05306065167230656520724246150606515555
0014000020724200251c7241c02525742287421572439525207242a7422c7412c7322c72219025147242f7422d7422d7452d734217422174221735237241702521724395251c7341c03519734195351773617035
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102000023041280312b00128051280512805128051100510f0010f0010f0010c001240010c0010c0010c0010c0012f0010000100001000010000100001000010000100001000010000100001000010000000000
1102000013051130511300116051160611606116071190512000120001200012000120001200011f0012400124001240012400124001240012400100001000010000100001000010000100001000010000100000
0014000024750007001d7500070016750167501675016750167500070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
0010000016050000001d0500000024050240502405024050240500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000023040280302b000180001800013000130001200012000120000f0000f0000f0000f0000c000240000c0000c0000c0000c0002f0000000000000000000000000000000000000000000000000000000000
0008000018750187501a7501a7501a7001a7002870000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
__music__
00 02424344
01 02034344
00 02034344
00 02044344
00 05044344
02 05064344
01 07084344
00 090a4344
00 0b084344
00 090a4344
02 0b084344

