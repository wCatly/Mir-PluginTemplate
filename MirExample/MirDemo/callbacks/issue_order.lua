
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Issue Order", p_open) then
        if ig.TreeNode("Enum IssueOrder") then
            format_value("\tIssueOrder_Move", IssueOrder_Move)
            format_value("\tIssueOrder_HoldPosition", IssueOrder_HoldPosition)
            format_value("\tIssueOrder_Stop", IssueOrder_Stop)
            format_value("\tIssueOrder_AttackMove", IssueOrder_AttackMove)
            format_value("\tIssueOrder_Attack", IssueOrder_Attack)
            format_value("\tIssueOrder_PetMove", IssueOrder_PetMove)
            format_value("\tIssueOrder_PetAttack", IssueOrder_PetAttack)
            ig.TreePop()
        end
        ig.NewLine()
        format_value("void __cdecl botm_issue_order(IssueOrderInfo *info);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered when a script calls one of the move/attack functions.")
        ig.TextWrapped("Refer to the botm_game_event callback to intercept input by the user.")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.issue_order = function(info)")
        ig.Text("\t--pos, target fields may be altered to change the issued order")
        ig.Text("\t--block field may be set to true to block the issued order")
        ig.Text("\tprint(\"botm.issue_order\", info.order, info.pos, info.target)")
        ig.Text("end")
        ig.PopStyleColor(1)
        
    end
    ig.End()
end

local botm_issue_order = function(info)
    print("botm_issue_order", info.order, info.pos, info.target)
    --info.block = true
    --info.pos.z = info.pos.z + 300
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_issue_order = botm_issue_order,
}