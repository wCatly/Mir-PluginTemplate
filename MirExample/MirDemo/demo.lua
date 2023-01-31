local ffi = require "ffi"

local demo = {}

local modules = {
    path = "modules",
    "botm",
    "script_tor",
    "game",
    "hud",
    "navmesh",
    "chat",
    "camera",
    "options",
    "graphics",
    "object_manager",
    "minimap",
    "shop",
}

local gameobjects = {
    path = "gameobjects",
    "particle",
    "neutral_camp",
    "missile",
    "inhib",
    "nexus",
    "turret",
    "minion",
    "hero",
    "player",
}

local callbacks = {
    path = "callbacks",
    "load",
    "tick",
    "draw",
    "keyboard",
    "create_object",
    "process_spell",
    "spell_execute",
    "spell_cancel",
    "waypoints_change",
    "game_event",
    "game_end",
    "request_save_settings",
    "gain_buff",
    "play_animation",
    "cast_spell",
    "issue_order",
}

local hud_and_textures = {
    path = "hud_and_textures",
    "texture_viewer",
}

local other = {
    path = "other",
    "manifest",
    "callbacks",
    "vector_math",
    "sample_menu",
    "object_lifetime",
    "cast_game_object",
    "c_development",
    "lua_development",
    "luajit_bundler",
}

local require_demo = function(name, path)
    local M = require(path)
    table.insert(demo, M)
    demo[name] = M
    M.p_open = ffi.new("bool[1]")
end

local load_demo = function(t)
    for i, name in ipairs(t) do
        require_demo(name, t.path.."/"..name)
    end
end

load_demo(modules)
load_demo(gameobjects)
load_demo(callbacks)
load_demo(hud_and_textures)
load_demo(other)

botm.draw_menu = function()
    if ig.Begin("Mir Demo") then
        if ig.TreeNode("Modules") then
            ig.Checkbox("BotM *bot", demo.botm.p_open)
            ig.Checkbox("Game *game", demo.game.p_open)
            ig.Checkbox("Hud *hud", demo.hud.p_open)
            ig.Checkbox("Graphics *graphics", demo.graphics.p_open)
            ig.Checkbox("ObjectManager *object_manager", demo.object_manager.p_open)
            ig.Checkbox("Navmesh *navmesh", demo.navmesh.p_open)
            ig.Checkbox("Chat *chat", demo.chat.p_open)
            ig.Checkbox("Camera *camera", demo.camera.p_open)
            ig.Checkbox("Options *options", demo.options.p_open)
            ig.Checkbox("Minimap *minimap", demo.minimap.p_open)
            ig.Checkbox("Shop *shop", demo.shop.p_open)
            --ig.Checkbox("ScriptTor *script_tor", demo.script_tor.p_open)
            ig.TreePop()
        end
        if ig.TreeNode("GameObjects") then
            ig.Checkbox("Particle*", demo.particle.p_open)
            ig.Checkbox("NeutralCamp*", demo.neutral_camp.p_open)
            ig.Checkbox("Missile*", demo.missile.p_open)
            ig.Checkbox("Inhib*", demo.inhib.p_open)
            ig.Checkbox("Nexus*", demo.nexus.p_open)
            ig.Checkbox("Turret*", demo.turret.p_open)
            ig.Checkbox("Minion*", demo.minion.p_open)
            ig.Checkbox("Hero*", demo.hero.p_open)
            ig.Checkbox("Player*", demo.player.p_open)
            ig.TreePop()
        end
        if ig.TreeNode("Callbacks") then
            ig.Checkbox("Save Settings", demo.request_save_settings.p_open)
            ig.Checkbox("Load", demo.load.p_open)
            ig.Checkbox("Tick", demo.tick.p_open)
            ig.Checkbox("Draw", demo.draw.p_open)
            ig.Checkbox("Keyboard", demo.keyboard.p_open)
            ig.Checkbox("Create/Delete Object", demo.create_object.p_open)
            ig.Checkbox("Process Spell", demo.process_spell.p_open)
            ig.Checkbox("Spell Execute", demo.spell_execute.p_open)
            ig.Checkbox("Spell Cancel", demo.spell_cancel.p_open)
            ig.Checkbox("Gain/Lose/Update Buff", demo.gain_buff.p_open)
            ig.Checkbox("Play Animation", demo.play_animation.p_open)
            ig.Checkbox("Waypoints Change", demo.waypoints_change.p_open)
            ig.Checkbox("Game Event", demo.game_event.p_open)
            ig.Checkbox("Game End", demo.game_end.p_open)
            ig.Checkbox("Cast Spell", demo.cast_spell.p_open)
            ig.Checkbox("Issue Order", demo.issue_order.p_open)
            ig.TreePop()
        end
        if ig.TreeNode("Hud & Textures") then
            ig.Checkbox("Texture Viewer", demo.texture_viewer.p_open)
            ig.TreePop()
        end
        if ig.TreeNode("Other Demos") then
            ig.Checkbox("LuaJIT Development", demo.lua_development.p_open)
            ig.Checkbox("C/C++ Development", demo.c_development.p_open)
            ig.Checkbox("Manifest", demo.manifest.p_open)
            ig.Checkbox("Sample Menu", demo.sample_menu.p_open)
            ig.Checkbox("Callbacks", demo.callbacks.p_open)
            ig.Checkbox("Vector Math", demo.vector_math.p_open)
            ig.Checkbox("Lifetime of Objects", demo.object_lifetime.p_open)
            --ig.Checkbox("Cast GameObjects", demo.cast_game_object.p_open)
            ig.Checkbox("LuaJIT Bundler", demo.luajit_bundler.p_open)
            ig.TreePop()
        end
    end

    ig.End()

    for i, m in ipairs(demo) do
        if m.botm_draw_menu then
            if m.p_open[0] then
                m.botm_draw_menu(m.p_open)
            end
        end
    end
end

botm.draw_world = function()
    for i, m in ipairs(demo) do
        if m.botm_draw_world then
            if m.p_open[0] then
                m.botm_draw_world()
            end
        end
    end
end

botm.draw = function()
    for i, m in ipairs(demo) do
        if m.botm_draw then
            if m.p_open[0] then
                m.botm_draw()
            end
        end
    end
end

botm.process_spell = function(spell)
    for i, m in ipairs(demo) do
        if m.botm_process_spell then
            if m.p_open[0] then
                m.botm_process_spell(spell)
            end
        end
    end
end

botm.spell_execute = function(spell)
    for i, m in ipairs(demo) do
        if m.botm_spell_execute then
            if m.p_open[0] then
                m.botm_spell_execute(spell)
            end
        end
    end
end

botm.spell_cancel = function(spell)
    for i, m in ipairs(demo) do
        if m.botm_spell_cancel then
            if m.p_open[0] then
                m.botm_spell_cancel(spell)
            end
        end
    end
end

botm.waypoints_change = function(obj)
    for i, m in ipairs(demo) do
        if m.botm_waypoints_change then
            if m.p_open[0] then
                m.botm_waypoints_change(obj)
            end
        end
    end
end

botm.create_object = function(obj)
    for i, m in ipairs(demo) do
        if m.botm_create_object then
            if m.p_open[0] then
                m.botm_create_object(obj)
            end
        end
    end
end

botm.delete_object = function(type, id)
    for i, m in ipairs(demo) do
        if m.botm_delete_object then
            m.botm_delete_object(type, id)
        end
    end
end

botm.key_down = function(vk)
    for i, m in ipairs(demo) do
        if m.botm_key_down then
            if m.p_open[0] then
                m.botm_key_down(vk)
            end
        end
    end
end

botm.unload = function()
    for i, m in ipairs(demo) do
        if m.botm_unload then
            m.botm_unload()
        end
    end
end

botm.tick = function()
    for i, m in ipairs(demo) do
        if m.botm_tick then
            if m.p_open[0] then
                m.botm_tick()
            end
        end
    end
end

botm.game_event = function(evt)
    for i, m in ipairs(demo) do
        if m.botm_game_event then
            if m.p_open[0] then
                m.botm_game_event(evt)
            end
        end
    end
end

botm.game_end = function()
    for i, m in ipairs(demo) do
        if m.game_end then
            if m.p_open[0] then
                m.game_end()
            end
        end
    end
end

botm.gain_buff = function(buff)
    for i, m in ipairs(demo) do
        if m.botm_gain_buff then
            if m.p_open[0] then
                m.botm_gain_buff(buff)
            end
        end
    end
end

botm.lose_buff = function(buff)
    for i, m in ipairs(demo) do
        if m.botm_lose_buff then
            if m.p_open[0] then
                m.botm_lose_buff(buff)
            end
        end
    end
end

botm.update_buff = function(buff)
    for i, m in ipairs(demo) do
        if m.botm_update_buff then
            if m.p_open[0] then
                m.botm_update_buff(buff)
            end
        end
    end
end

botm.play_animation = function(obj, name)
    for i, m in ipairs(demo) do
        if m.botm_play_animation then
            if m.p_open[0] then
                m.botm_play_animation(obj, name)
            end
        end
    end
end

botm.cast_spell = function(info)
    for i, m in ipairs(demo) do
        if m.botm_cast_spell then
            if m.p_open[0] then
                m.botm_cast_spell(info)
            end
        end
    end
end

botm.issue_order = function(info)
    for i, m in ipairs(demo) do
        if m.botm_issue_order then
            if m.p_open[0] then
                m.botm_issue_order(info)
            end
        end
    end
end

botm.request_save_settings = function(evt)
    for i, m in ipairs(demo) do
        if m.botm_request_save_settings then
            if m.p_open[0] then
                m.botm_request_save_settings(evt)
            end
        end
    end
end

botm.load = function(env)
    for i, m in ipairs(demo) do
        if m.botm_load then
            m.botm_load()
        end
    end
    return true
end
