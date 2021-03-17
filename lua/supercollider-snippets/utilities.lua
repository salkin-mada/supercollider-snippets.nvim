-- local sniputils = require'snippets.utils'
-- local sn = require'snippets.utils'
local S = require'snippets'
U = {}
local format = string.format
-- local insert = table.insert
-- local concat = table.concat

-- snippet system base and sys utilities
U.snippet_sys = require'snippets'
U.snippet_sys_utils = require'snippets.utils'

-- A global setting controls wether it should be followed by a newline
local newline = vim.g.supercollider_snippet_comma_newline or 0

function U.getreg(register)
    local t = {}
    register = tostring(register) or "\""
    t = vim.fn.getreg(register)
    return t
end

-- Count the number of times a value occurs in a table
function table_count(table, item)
    local count
    count = 0
    for i,x in pairs(table) do
        if item == x then count = count + 1 end
    end
    return count
end

-- Check if string ends with something
local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

-- Insert values from one table into another table
function tinsertvalues(t, ...)
    local pos, values
    if select('#', ...) == 1 then
        pos,values = #t+1, ...
    else
        pos,values = ...
    end
    if #values > 0 then
        for i=#t,pos,-1 do
            t[i+#values] = t[i]
        end
        local offset = 1 - pos
        for i=pos,pos+#values-1 do
            t[i] = values[i + offset]
        end
    end
end
--[[ usage:
local t = {5,6,7}
tinsertvalues(t, {8,9})
tinsertvalues(t, {})
tinsertvalues(t, 1, {1,4})
tinsertvalues(t, 2, {2,3})
assert(table.concat(t, '') == '123456789')
--]]

-- Generate iterative combinations from list (recursive)
function combo(t,n)
    local n,max,tn,output=n,#t,{},{}
    for x=1,n do tn[x],output[x]=x,t[x] end -- Generate 1st combo
    tn[n]=tn[n]-1 -- Needed to output 1st combo
    return function() -- Iterator fn
        local t,tn,output,x,n,max=t,tn,output,n,n,max
        while tn[x]==max+x-n do x=x-1 end -- Locate update point
        if x==0 then return nil end -- Return if no update point
        tn[x]=tn[x]+1 -- Add 1 to update point (UP)
        output[x]=t[tn[x]] -- Update output at UP
        for i=x+1,n do
            tn[i]=tn[i-1]+1 -- Update points to right of UP
            output[i]=t[tn[i]] -- Update output to refect change in points
        end
        return output
    end
end


function U.rando(index)
    local t = {}
    -- local input = S.v
    local arg_num = 0

    index = index or 1
    local is_input = true
    local num_decimals = 2
    local val = math.random()
    local default = string.format("%." .. num_decimals .. "f", val)

    local transform = function(sn)

        local input = sn.v

        if ends_with(sn.v, "=") then
            local var = sn.v:sub(1,-3)
            return "the " .. var .. " end"
        end

        for entry in input:gmatch('([^,]+)') do
            arg_num = arg_num + 1;
            return input
        end
    end

    local item = U.var(
        index,
        default,
        is_input,
        string.format("magic %i", index),
        transform
    )

    table.insert(t, item)


    return t
    -- table.insert(t, input)
    -- return tostring(t)
end




-- the mother of random funcs
-- function U.rand(input, type)
function U.rand(type)
    local input = S.v
    local list = ""
    local mode, size, r_min, r_max, deci,  f_min, f_max
    local r_switch = false
    local arg_num = 0

    input = input or "lol"

    for entry in input:gmatch('([^,]+)') do
        arg_num = arg_num + 1;
        if arg_num == 1 then
            print("modes:{f,i,d}")
            if entry == "f" then mode = entry
            elseif entry == "i" then mode = entry
            elseif entry == "d" then mode = entry
            else mode = "i" end -- integer mode is default
            if tonumber(entry) ~= nil then
                print("choose a mode..")
            end
        elseif arg_num == 2 then
            -- same for all modes
            print("size")
            if tonumber(entry) ~= nil then
                size = tonumber(entry)
            end
        elseif arg_num == 3 then
            if mode == "f" then
                print("decimal count or 'r' for random count")
                if tonumber(entry) ~= nil then
                    deci = tonumber(entry)
                elseif entry == "r" then
                    r_switch = true
                end
            elseif mode == "i" then
                print("min")
                if tonumber(entry) ~= nil then
                    r_min = tonumber(entry)
                end
            elseif mode == "d" then
                print("dividend max")
                if tonumber(entry) ~= nil then
                    r_min = tonumber(entry)
                end
            end
        elseif arg_num == 4 then
            if mode == "f" then
                if r_switch then
                    print("max decimal count")
                    if tonumber(entry) ~= nil then
                        r_max = tonumber(entry)
                    end
                else
                    print("min whole/trunc value")
                    if tonumber(entry) ~= nil then
                        f_min = tonumber(entry)
                    end
                end
            elseif mode == "i" then
                print("max")
                if tonumber(entry) ~= nil then
                    r_max = tonumber(entry)
                end
            elseif mode == "d" then
                print("divisor max")
                if tonumber(entry) ~= nil then
                    r_max = tonumber(entry)
                end
            end
        elseif arg_num == 5 then
            if mode == "f" then
                if r_switch == false then
                    print("max whole/trunc value")
                    if tonumber(entry) ~= nil then
                        f_max = tonumber(entry)
                    end
                else
                    print("min whole/trunc value")
                    if tonumber(entry) ~= nil then
                        f_min = tonumber(entry)
                    end
                end
            end
        elseif arg_num == 6 then
            if mode == "f" then
                if r_switch then
                    print("max whole/trunc value")
                    if tonumber(entry) ~= nil then
                        f_max = tonumber(entry)
                    end
                end
            end
        end
    end

    size = size or 0
    if size == 0 then
        return ""
    end
    deci = deci or 2
    f_min = f_min or 0
    f_max = f_max or f_min or 0
    if mode == "d" then
        r_min = r_min or 8
        r_max = r_max or 16
    else
        r_min = r_min or 0
        r_max = r_max or 100
    end

    if mode == "f" then
        for i=1,size,1 do
            if r_switch then
                r_max = r_max or 10
                deci = math.random(r_max)
            end
            if deci > 50 then deci = 50 end -- max .f
            list = list..format("%."..deci.."f", tostring(math.random()+math.random(f_min,f_max)))
            if i < size then list = list..", " end
        end
    elseif mode == "i" then
        for i=1,size,1 do
            list = list..tostring(math.random(r_min, r_max))
            if i < size then list = list..", " end
        end
    elseif mode == "d" then
        for i=1,size,1 do
            list = list..tostring(math.random(r_min)).."/"..tostring(math.random(r_max))
            if i < size then list = list..", " end
        end
    end

    -- type = type or "default"
    if type == "array" then
        return format("[%s]", list)
    else
        return format("%s", list)
    end
end


-- append table to table
function U.append_table(table1, table2)
    for _,v in pairs(table2) do
        table.insert(table1, v)
    end
end

-- Insert comma into table
function U.insert_comma(table1)
    local comma
    if newline == 1 then
        comma = "," .. "\n"
    else
        comma = ","
    end

    table.insert(table1, comma)
end

function indented(str)
    local line = vim.api.nvim_get_current_line()
    local indent = line:match("^%s+") or ""
    -- local cursor = vim.api.nvim_win_get_cursor(0)
    -- local pos_on_line = cursor[2]

    -- if ends_with(line, "%S") then
    -- if newline then
    return indent .. str
    -- else
    -- return str
    -- end
end

function U.print_snippets()
    print("available supercollider snippets")
    print(":->")
    for k,_ in pairs(require'supercollider-snippets') do
        print(k)
    end
end
-- basename of file (without suffix)
function U.get_basename()
    return vim.fn.expand("%:t:r")
end

-- get filename
function U.get_filename()
    return vim.fn.expand("%:t")
end

-- first letter capitalized in string
function U.capitalize(str)
    return str:gsub("^%l", string.upper)
end

-- basename capitalized
function U.capitalized_base()
    return U.capitalize(U.get_basename())
end

-- create a snippets.nvim variable
function U.var(order, default, is_input, id, transform)
    local var = {
        order = order,
        id = id or order,
        default = default or "",
        is_input = is_input or false,
        transform = transform or function(context) return context.v end,
    }
    return var
end

-- wrap a table in (), {} or []
function U.wrap_table_in(t, wrapperChar)
    -- prefix
    if wrapperChar == "{" then
        table.insert(t, 1, "{")
        table.insert(t, "}")
    elseif wrapperChar == "[" then
        table.insert(t, 1, "[")
        table.insert(t, "]")
    elseif wrapperChar == "(" then
        table.insert(t, 1, "(")
        table.insert(t, ")")
    end

    return t
end


-- create list of random variables
-- offset is used to offset the variable numbers
function U.rand_var_list(maxLen, wrapListIn, offset, type)
    local t = {}

    for i=1, maxLen do
        local is_input = true
        local num_decimals = 2
        local default = ""

        -- Random float
        if type == "f" then
            local val = math.random()
            default = string.format("%." .. num_decimals .. "f", val)

            -- Random integer
        elseif type == "i" then
            local val = math.random(10)
            default = string.format("%i", val)

            -- Random fraction
        elseif type == "fr" then
            local val = math.random(1,10)
            local div = math.random(1,10)

            -- Make sure val and div are not the same
            while val == div do
                div = math.random(1,10)
            end

            default = string.format("%i/%i", val, div)

            -- Random reciprocal ( eg 1/5, 1/7 etc )
        elseif type =="r" then
            local val = math.random(2,10)
            default = string.format("%i/%i", 1, val)

        else
            -- Default to floats
            local val = math.random()
            default = string.format("%." .. num_decimals .. "f", val)
        end

        offset = offset or 0
        local transform = function(sn)
            local spacer = " "

            if newline == 1 then
                if i == 1 then
                    spacer = "\n\t"
                end
            else
                if i == 1 then
                    spacer = "" -- no space before first item
                end
            end

            if ends_with(sn.v, "r") then
                local var = sn.v:sub(1,-3)
                return spacer .. indented("Rest(" .. var .. ")")
            else
                return spacer .. indented(sn.v)
            end
        end

        local index = i + offset
        local item = U.var(
            index,
            default,
            is_input,
            string.format("item %i", index),
            transform
        )

        table.insert(t, item)

        -- No comma at end of list
        if i ~= maxLen then
            U.insert_comma(t)
        end
    end

    if wrapListIn ~= nil then
        U.wrap_table_in(t, wrapListIn)
    end

    return t
end

-- wrap a table in a pattern (that is with a class prefixed and a repeats argument)
function U.wrap_in_pat(t, patternClass)
    table.insert(t, 1, string.format("%s(", patternClass))

    local repeats = U.var(1, "inf", true, "repeats",
        function(sn)
            if sn.v ~= nil then
                return ", " .. sn.v
            else
                return sn.v
            end
        end
    )

    table.insert(t, repeats)
    table.insert(t, ")")
end

return U
