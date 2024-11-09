local stringify = require "stringify"
local parse = require "parse"
local data = require "data"

print("DATA_RAW=" .. stringify.tbl_str(data))
print "DATA=str_tbl(DATA_RAW)"
