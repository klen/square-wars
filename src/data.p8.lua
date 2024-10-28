version = 1

colors = split "7,8,9,10,11,12"

arenas = {
  -- debug
  -- { 223, 208, 194, 195 },
  split "empty",
  split "infiltration,44,45,46,47,48,49,52,53,54,55,56,57,63,78,83,98,103,118,123,138,143,158,163,178,223,238,243,258,263,278,283,298,303,318,323,338,344,345,346,347,348,349,352,353,354,355,356,357",
  split "brothers,61,62,63,64,65,66,67,74,75,76,77,78,79,80,88,93,108,113,128,133,148,153,168,173,228,233,248,253,268,273,288,293,308,313,321,322,323,324,325,326,327,334,335,336,337,338,339,340",
  split "mirror,43,44,45,48,53,56,57,58,63,78,83,88,93,98,108,113,123,138,143,158,163,178,183,198,203,218,223,238,243,258,263,278,288,293,303,308,313,318,323,338,343,344,345,348,353,356,357,358",
  split "crystal,24,37,44,57,62,63,78,79,30,31,49,52,68,73,106,115,144,157,163,178,182,199,370,371,349,352,328,333,286,295,244,257,223,238,202,219,322,323,344,364,338,339,357,377",
  split "labyrinth,44,45,46,47,48,49,50,51,52,53,54,55,56,57,107,108,109,112,113,114,63,78,83,98,103,118,123,138,143,158,163,178,126,135,146,155,166,175,186,195,206,215,226,235,246,255,266,275,223,238,243,258,263,278,283,298,303,318,323,338,287,288,289,292,293,294,344,345,346,347,348,349,350,351,352,353,354,355,356,357",
  split "cage,24,28,33,37,44,48,53,57,62,63,66,67,70,71,74,75,78,79,104,108,113,117,124,128,133,137,142,143,146,147,150,151,154,155,158,159,183,198,203,218,242,243,246,247,250,251,254,255,258,259,264,268,273,277,284,288,293,297,322,323,326,327,330,331,334,335,338,339,344,348,353,357,364,368,373,377",
  split "lines,41,42,44,45,46,47,48,49,50,51,52,53,54,55,56,57,59,60,101,102,103,104,105,107,108,109,110,111,112,113,114,116,117,118,119,120,161,162,163,164,165,166,167,168,170,171,173,174,175,176,177,178,179,180,221,222,223,224,225,226,227,228,230,231,233,234,235,236,237,238,239,240,281,282,283,284,285,287,288,289,290,291,292,293,294,296,297,298,299,300,341,342,344,345,346,347,348,349,350,351,352,353,354,355,356,357,359,360",
}

missions = {
  -- load_table_str "n=debug,s=15,p=1,a=6",
  load_table_str "n=intro,s=5,cpu=0", -- 1
  load_table_str "n=tutor,s=8,cpu=1,un=continue", -- 2
  load_table_str "n=qualification,s=12,cpu=2", -- 3
  load_table_str "n=exam,s=15,cpu=3,u=practice,un=practice mode", -- 4
  load_table_str "n=infiltration,s=20,a=2,cpu=1,u=arena,un=arena 1", -- 5
  load_table_str "n=brothers,s=20,a=3,cpu=1,u=arena,un=arena 2", -- 6
  load_table_str "n=the mirror,s=20,a=4,cpu=1,u=arena,un=arena 3", -- 7
  load_table_str "n=the crystal,s=20,a=5,cpu=2,u=arena,un=arena 4", -- 8
  load_table_str "n=labyrinth,s=20,a=6,cpu=2,u=arena,un=arena 5", -- 9
  load_table_str "n=cage,s=20,a=7,cpu=3,u=arena,un=arena 6", -- 10
  load_table_str "n=lines,s=20,a=8,cpu=3,u=arena,un=arena 7", -- 11
}

briefs = {
  "welcome, initiate.\n\n\nprove your readiness\n\n\nfill the board with\n\na single color.",
  "the field awakens.\n\n\na simple adversary\n\nstands in your way.\n\n\ngrab the board.",
  "two observers enter.\n\n\nare you ready\n\nto demonstrate your worth?",
  "three shadows converge.\n\n\nshow your resolve\n\nor be forgotten.",
  "a lone sentinel\n\n\nguards this vast domain.\n\n\ndisrupt the silence.",
  "two strongholds oppose you.\n\n\ndivide and conquer.",
  "a reflection of your skill.\n\n\nbalance is the key.",
  "two adversaries\n\n\nguard the heart.\n\n\napproach with caution.",
  "the paths twist and narrow.\n\n\nmove swiftly, or be lost.",
  "three join.\n\n\nnavigate the chaos\n\nto claim victory.",
  "the final gauntlet.\n\n\nfour foes align to test you.",
}

-- Final Trial: "The end draws near, but secrets linger. Only the chosen will unlock the truth."
