local ffi = require "ffi"

local format = string.format
local tostring = tostring

local col_text = ig.ColorConvertU32ToFloat4(0xff999999)
local col_menu = ig.ColorConvertU32ToFloat4(0xff0099ff)
local col_no_val = ig.ColorConvertU32ToFloat4(0xffff00ff)
local col_red = ig.ColorConvertU32ToFloat4(0xff000099)
local col_green = ig.ColorConvertU32ToFloat4(0xff009900)

local F32 = ffi.new("float[1]")
local U32 = ffi.cast("uint32_t*", F32)
local FLT_MAX = 0x7F7FFFFF

local is_flt_max = function(val)
    if type(val) ~= "number" then return false end
    F32[0] = val
    return U32[0] == FLT_MAX
end

local has_value = function(val)
    local type_t = type(val)
    if type_t == "number" then
        return not is_flt_max(val)
    end
    if type_t == "string" then
        return val ~= ""
    end
end

local function format_opt_value(str, val)
    ig.TextColored(col_text, str)
    ig.SameLine()
    ig.Text("[optional]")
    ig.SameLine()
    if not has_value(val) then
        ig.TextColored(col_no_val, "NO VALUE")
    else
        ig.Text(tostring(val))
    end
end

--print(type(float3()))

local function format_opt_float3(str, val)
    ig.TextColored(col_text, str)
    ig.SameLine()
    ig.Text("[optional]")
    ig.SameLine()
    if is_flt_max(val.x) then
        ig.TextColored(col_no_val, "NO VALUE")
    else
        ig.Text(tostring(val))
    end
end

local function format_value(str, val, fmt)
    ig.TextColored(col_text, str)
    ig.SameLine()
    ig.Text(fmt and format(fmt, val) or tostring(val))
    if is_flt_max(val) then
        ig.SameLine()
        ig.TextColored(col_no_val, "FLOAT_MAX")
    end
    if val == "" then
        ig.SameLine()
        ig.TextColored(col_no_val, "EMPTY_STRING")
    end
end

return {
    col_text = col_text,
    col_menu = col_menu,
    col_no_val = col_no_val,
    col_red = col_red,
    col_green = col_green,
    
    format_value = format_value,
    format_opt_value = format_opt_value,
    format_opt_float3 = format_opt_float3,
}