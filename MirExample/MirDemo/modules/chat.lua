local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Chat", p_open) then

        format_value("Chat:", chat)
        format_value("\tis_open()", chat:IsOpen())
        format_value("\tstart()", chat:Start())
        format_value("\tindex()", chat:Index())
        format_value("\tsize()", chat:Size())

        ig.NewLine()

        if ig.MenuItem("Chat_send(\"Hello Send\")", "1") then
            chat:Send("Hello Send")
        end
        if ig.MenuItem("Chat_print(\"<font color='#FFFFFFFF'>Hello Print</font>\")", "2") then
            chat:Print("<font color='#FFFFFFFF'>Hello Print</font>")
        end
        if ig.MenuItem("print(Chat_message(Chat_index() - 1))", "3") then
            print(chat:Message(chat:Index() - 1))
        end
        if ig.MenuItem("Chat_replace(Chat_index() - 1, \"Hello Replace\")", "4") then
            chat:Replace(chat:Index() - 1, "Hello Replace")
        end

    end
    ig.End()
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        chat:Send("Hello Send")
    elseif vk_code == 50 then --[2]
        chat:Print("<font color='#FFFFFFFF'>Hello Print</font>")
    elseif vk_code == 51 then --[3]
        print(chat:Message(chat:Index() - 1))
    elseif vk_code == 52 then --[4]
        chat:Replace(chat:Index() - 1, "Hello Replace")
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}