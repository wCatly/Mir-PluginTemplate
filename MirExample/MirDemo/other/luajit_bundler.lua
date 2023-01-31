
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local col_text = demo_h.col_text
local col_red = demo_h.col_red
local col_green = demo_h.col_green

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: LuaJIT Bundler", p_open, 0) then
        ig.TextColored(col_text, "Bundle Status:")
        ig.SameLine()
        if BUNDLE then
            ig.TextColored(col_green, "Bundled")
        else
            ig.TextColored(col_red, "Unbundled")
        end
        ig.NewLine()
        ig.TextWrapped("The bundler packs a script folder into a folder that is ready for distribution to users. The bundled folder does not contain any raw source code as the Lua files are converted to LuaJIT bytecode")
        ig.NewLine()
        ig.TextColored(col_text, "Usage: (For a demonstration run \"bundle.bat\")\n\tbundler.exe InputDirectory [optional]OutputDirectory [optional]OutputDisplayName")
        ig.NewLine()
        ig.TextWrapped("A bundled script has the BUNDLE table in its environment. Binary data of a bundled file can be accessed with BUNDLE[filename].Unpack()")
        ig.NewLine()
        ig.PushStyleColor_Vec4(ig.lib.ImGuiCol_Text, col_text)
        ig.Text([[
if BUNDLE then
    local data, size = BUNDLE["resources/smile.png"].Unpack()
    tex = graphics:LoadImageFromMemory(data, size)
else
    tex = graphics:LoadImageFromFile("resources/smile.png")
end
        ]])
        ig.PopStyleColor()
        ig.TextWrapped("Please be aware that the bundler, as a matter of convenience, already wraps around LoadImageFromFile internally")
    end
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}