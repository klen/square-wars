-- these are globals in PICO-8
-- (don't need these lines there)
local sub = sub or string.sub
local tonum = tonum or tonumber

-- ASCII US "unit separator"
-- used to delimit both keys and values
local token_sep = "\31"

-- ASCII GS "group separator"
-- used to delimit the begining of a
-- subtable following a key
local subtable_start = "\29"

-- ASCII RS "record separator"
-- used to delimit the end of a subtable
local subtable_end = "\30"

-- ASCII for boolean values
local token_true = "\6" -- ASCII ACK "acknowledge"
local token_false = "\21" -- ASCII NAK "negative acknowledge"

function stringify_table(table)
  local str = ""
  for key, val in pairs(table) do
    str = str .. key
    local t = type(val)
    if t == "table" then
      str = str .. subtable_start .. stringify_table(val) .. subtable_end
    elseif t == "boolean" then
      str = str .. token_sep .. (val and token_true or token_false) .. token_sep
    else
      str = str .. token_sep .. val .. token_sep
    end
  end
  return str
end

function tbl_str(table)
  local function escape(str)
    if type(str) ~= "string" then
      return str
    end
    local new_str = ""
    for i = 1, #str do
      local char = sub(str, i, i)
      if char == "'" then
        new_str = new_str .. "\\'"
      else
        new_str = new_str .. char
      end
    end
    return new_str
  end
  return escape(stringify_table(table))
end

-- module export - don't
-- include this in PICO-8
return {
  stringify_table = stringify_table,
  tbl_str = tbl_str,
}
