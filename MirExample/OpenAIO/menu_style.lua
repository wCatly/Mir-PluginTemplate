local push_style = function()
    --ig:PushStyleColor(ImGuiCol_Border, 0xff00ffee)
end

local pop_style = function()
    --ig:PopStyleColor(1)
end

return {
    push_style = push_style,
    pop_style = pop_style,
}