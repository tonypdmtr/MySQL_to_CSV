--==============================================================================
-- Convert MySQL 'framed' table into CSV                         
--==============================================================================

--[[ Example input
+-------------+------------------+-------------------------------+-------------+
| pet_id      | pet_identity_id  | identity_value                | pet_species |
+-------------+------------------+-------------------------------+-------------+
|       77626 |          3140819 | dominic_dog@example.com       | dog         |
|       77625 |          3140818 | missy_miauw@example.com       | cat         |
|       77622 |          3140815 | shelly@example.com            | aardvark    |
|       77583 |          3140776 | monster_moo@example.com       | cow         |
+-------------+------------------+-------------------------------+-------------+
--]]

local filename,option
local DELIMITER = '|'                   --delimiter to use in output file
for _,arg in ipairs(arg) do
  option = arg:lower():sub(1,-2):match '^%-%-?(.+)[=:]'
  if option == 'delimiter' or option == 'd' then
    DELIMITER = arg:sub(-1)             --override delimiter with user choice
  elseif arg:sub(1,1) ~= '-' then
    filename = arg                      --filename to use
  end
end

local tabs,counter                      --to keep track of column markers
for line in io.lines(filename) do
  if line:match '^%+[+-]+%+$' then      --frame line
    tabs = {}
    counter = 0
    for ch in line:gmatch '.' do
      counter = counter + 1
      if ch == '+' then tabs[#tabs+1] = counter end
    end
  elseif line:sub(1,1) == '|' then      --data line
    for _,tab in ipairs(tabs) do
      line = line:sub(1,tab-1) .. '\0' .. line:sub(tab+1)
    end
    line = line:gsub('%Z+',
      function(s)
        s = s:gsub('^%s*(.-)%s*$','%1')       --remove leading & trailing spaces (optional)
        if s ~= '' and not s:match '^-?%d-%.?%d+$' then
          s = '"' .. s:gsub('"','""') .. '"'  --add quotes while escaping internal ones
        end
        return s
      end)
    line = line:gsub('%z',DELIMITER)    --put delimiter symbols back in
    print(line:sub(2,-2))
  end
end
