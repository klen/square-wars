local stringify = require "data.stringify"
local data = require "data.data"

print("DATA_RAW='" .. stringify.tbl_str(data) .. "'")
print "DATA=str_tbl(DATA_RAW)"
