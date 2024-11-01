G = _ENV

VERSION = 1

COLORS = split "7,8,9,10,11,12"
COLORS_IDX = load_table_str "7=1,8=2,9=3,10=4,11=5,12=6"

ARENAS = {
  split "empty",
  split "crossroad,48,53,68,73,88,93,108,113,128,133,143,144,145,146,147,154,155,156,157,158,243,244,245,246,247,254,255,256,257,258,268,273,288,293,308,313,328,333,348,353",
  split "infiltration,44,45,46,47,48,49,52,53,54,55,56,57,63,78,83,98,103,118,123,138,143,158,163,178,223,238,243,258,263,278,283,298,303,318,323,338,344,345,346,347,348,349,352,353,354,355,356,357",
  split "brothers,61,62,63,64,65,66,67,74,75,76,77,78,79,80,88,93,108,113,128,133,148,153,168,173,228,233,248,253,268,273,288,293,308,313,321,322,323,324,325,326,327,334,335,336,337,338,339,340",
  split "mirror,43,44,45,48,53,56,57,58,63,78,83,88,93,98,108,113,123,138,143,158,163,178,183,198,203,218,223,238,243,258,263,278,288,293,303,308,313,318,323,338,343,344,345,348,353,356,357,358",
  split "crystal,24,37,44,57,62,63,78,79,30,31,49,52,68,73,106,115,144,157,163,178,182,199,370,371,349,352,328,333,286,295,244,257,223,238,202,219,322,323,344,364,338,339,357,377",
  split "labyrinth,44,45,46,47,48,49,50,51,52,53,54,55,56,57,107,108,109,112,113,114,63,78,83,98,103,118,123,138,143,158,163,178,126,135,146,155,166,175,186,195,206,215,226,235,246,255,266,275,223,238,243,258,263,278,283,298,303,318,323,338,287,288,289,292,293,294,344,345,346,347,348,349,350,351,352,353,354,355,356,357",
  split "cage,24,28,33,37,44,48,53,57,62,63,66,67,70,71,74,75,78,79,104,108,113,117,124,128,133,137,142,143,146,147,150,151,154,155,158,159,183,198,203,218,242,243,246,247,250,251,254,255,258,259,264,268,273,277,284,288,293,297,322,323,326,327,330,331,334,335,338,339,344,348,353,357,364,368,373,377",
  split "lines,41,42,44,45,46,47,48,49,50,51,52,53,54,55,56,57,59,60,101,102,103,104,105,107,108,109,110,111,112,113,114,116,117,118,119,120,161,162,163,164,165,166,167,168,170,171,173,174,175,176,177,178,179,180,221,222,223,224,225,226,227,228,230,231,233,234,235,236,237,238,239,240,281,282,283,284,285,287,288,289,290,291,292,293,294,296,297,298,299,300,341,342,344,345,346,347,348,349,350,351,352,353,354,355,356,357,359,360",
  split "apex,5,16,25,36,44,46,55,57,63,67,74,78,81,82,88,89,90,91,92,93,99,100,103,107,114,118,124,126,135,137,145,156,165,176,185,196,205,216,225,236,245,256,264,266,275,277,283,287,294,298,301,302,308,309,310,311,312,313,319,320,323,327,334,338,344,346,355,357,365,376,385,396",
  split "snow,10,11,24,27,34,37,44,47,54,57,62,63,66,69,72,75,78,79,86,89,92,95,104,105,108,113,116,117,122,123,128,133,138,139,146,147,151,154,155,164,165,169,172,176,177,181,188,200,201,213,220,224,225,229,232,236,237,246,247,250,254,255,262,263,268,273,278,279,284,285,288,293,296,297,306,309,312,315,322,323,326,329,332,335,338,339,344,347,354,357,364,367,374,377,390,391",
  split "fire,8,13,22,29,32,39,43,45,56,58,64,77,83,85,89,92,96,98,106,108,113,115,127,134,141,146,148,153,155,160,162,165,169,172,176,179,190,191,210,211,222,225,229,232,236,239,241,246,248,253,255,260,267,274,286,288,293,295,303,305,309,312,316,318,324,337,343,345,356,358,362,369,372,379,388,393",
  split "desert,22,23,25,26,28,29,32,33,35,36,38,39,42,46,48,53,55,59,64,77,82,86,95,99,102,103,105,106,108,113,115,116,118,119,128,129,132,133,142,143,146,147,154,155,158,159,162,167,174,179,222,227,234,239,242,243,246,247,254,255,258,259,268,269,272,273,282,283,285,286,288,293,295,296,298,299,302,306,315,319,324,337,342,346,348,353,355,359,362,363,365,366,368,369,372,373,375,376,378,379",
  split "sun,25,29,32,36,45,49,52,56,66,75,82,83,87,94,98,99,104,108,113,117,125,128,129,132,133,136,146,147,154,155,162,163,167,174,178,179,222,223,227,234,238,239,246,247,254,255,265,268,269,272,273,276,284,288,293,297,302,303,307,314,318,319,326,335,345,349,352,356,365,369,372,376",
  split "woods,10,22,24,26,28,33,35,37,39,50,62,64,66,68,73,75,77,79,90,102,104,106,108,113,115,117,119,130,142,144,146,148,153,155,157,159,170,192,194,196,198,200,201,203,205,207,209,231,242,244,246,248,253,255,257,259,271,282,284,286,288,293,295,297,299,311,322,324,326,328,333,335,337,339,351,362,364,366,368,373,375,377,379,391",
  split "storm,3,23,43,47,48,49,50,51,52,53,54,55,56,57,58,59,60,63,66,83,86,103,106,110,111,112,113,114,115,116,117,123,126,129,138,143,146,158,163,166,174,178,183,186,195,198,203,206,215,218,223,227,235,238,243,255,258,263,272,275,278,284,285,286,287,288,289,290,291,295,298,315,318,335,338,341,342,343,344,345,346,347,348,349,350,351,352,353,354,358,378,398",
}

MISSIONS = {
  -- load_table_str "n=debug,s=15,p=1,a=6",
  load_table_str "n=intro,s=5", -- 1
  load_table_str "n=tutor,s=8,cpu=1,un=continue", -- 2
  load_table_str "n=qualification,s=12,cpu=1/1", -- 3
  load_table_str "n=exam,s=15,cpu=1/1/1,u=practice,un=practice mode", -- 4

  load_table_str "n=crossroad,a=2,cpu=1,u=arena,un=arena 1", -- 5
  load_table_str "n=infiltration,a=3,cpu=1,u=arena,un=arena 2", -- 6

  load_table_str "n=snow's trial,a=11,w=1,cpu=1,u=power,un=power of snow,uv=1", -- 7 (snow)
  load_table_str "n=brothers,a=4,w=1,cpu=2,u=arena,un=arena 3", -- 8

  load_table_str "n=fire's challenge,a=12,w=2,cpu=2,u=power,un=power of fire,uv=3", -- 9 fire
  load_table_str "n=the mirror,a=5,w=3,cpu=2/1,u=arena,un=arena 4", -- 10

  load_table_str "n=desert's test,a=13,w=4,cpu=2/1,u=power,un=power of desert,uv=7", -- 11 desert
  load_table_str "n=the crystal,a=6,w=7,cpu=2/2,u=arena,un=arena 5", -- 12

  load_table_str "n=sun's wrath,a=14,w=8,cpu=2/2,u=power,un=power of sun,uv=15", -- 13 sun
  load_table_str "n=labyrinth,a=7,w=15,cpu=2/2/1,u=arena,un=arena 6", -- 14

  load_table_str "n=wood's guardian,a=15,w=16,cpu=2,plc=2,u=power,un=power of woods,uv=31", -- 15 woods
  load_table_str "n=cage,a=8,w=31,cpu=2/2/2,u=arena,un=arena 7", -- 16

  load_table_str "n=storm's dominion,a=16,w=63,cpu=2/2/2,plc=3,u=power,un=power of storm,uv=63", -- 17 storm
  load_table_str "n=lines,a=9,w=63,cpu=2/2/2,u=arena,un=arena 8", -- 18

  load_table_str "n=apex,a=10,w=63,cpu=2/2/2,plc=4,un=mastery of all powers", -- 19
}

POSITIONS = {}

BRIEFS = {
  "welcome, initiate.\n\n\nprove your readiness\n\n\nfill the board with\n\na single color.",

  "the field awakens.\n\n\nnew presence appears\n\nthis adversary moves slowly.\n\nobserve, learn, and\n\n\ntake control on the board.",

  "the field expands.\n\n\ntwo observers join\n\nprove yourself ready\n\nto face what's comming.", --3

  "the final exam awaits.\n\n\nthree shadows converge\n\nto test your resolve.\n\nprove yourself here\n\nor be forgotten\n\nthe real battles ahead.",

  "your training is complete.\n\n\nstep onto the field\n\nconfront your foe\n\nand claim control.",

  "with paths set before you\n\n\na lone sentinel\n\nguards this vast domain.\n\nslip past their watch\n\nand disrupt the silence.",

  "the master of snow awaits.\n\n\nyou are ready.\n\nthe field grows cold.\n\nconquer the frost\n\nand claim his power.",
  "two strongholds oppose you.\n\n\nthese forces demand strategy\n\ndivide them, conquer them\n\nand prove your strength.",

  "master of fire stands ready.\n\n\nthe heat intensifies\n\nendure the blaze\n\nand claim the power of flame.",
  "a reflection of your skill.\n\n\nonly those who\n\nunderstand their moves\n\ncan conquer the field.",

  "masters of desert emerge.\n\n\nthe sands shift beneath you\n\nonly those who adapt\n\nwill survive.",
  "three adversaries\n\n\nguard the heart\n\nof this field.\n\napproach with caution\n\nand take control.",

  "masters of sun stand tall.\n\n\nthe blinding light\n\ntests your resolve\n\nprove your worth\n\nin the glare.",
  "the paths twist and narrow.\n\n\nmove swiftly, or be lost\n\nin the maze.",

  "master of woods appears.\n\n\nthe forest thickens\n\nwith obstacles\n\nand a double joins you\n\nside by side\n\npress through the depths.",
  "three foes join.\n\n\nnavigate this dense\n\ngrid of walls and\n\nclaim your victory.",

  "masters of storm approach.\n\n\nthe winds howl\n\nonly the steadfast\n\ncan withstand the onslaught.",
  "barriers divide the field.\n\n\nfind your path\n\namidst the obstruction,\n\nnd carve out your claim.",

  "the final test awaits.\n\n\nlocked in and surrounded\n\nuse all powers\n\nto break through\n\nand prove yourself as master.",
}

CDATA =
  load_table_str "done=0,palette=1,mission=2,place=3,practice=4,arena=5,score=6,time=7,mute=8,power=9,mscores=10,ascores=50"
