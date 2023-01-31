local orb = loadscript("free-orbwalker")

local config = require "config"
local targeting = require "targeting"
local action_lock = require "action_lock"
local menu_style = require "menu_style"

local champion_script = nil

local init_champion_script = function()
    local char_name = player:CharName()
    if config.SupportedChampion[char_name] then
        return require(char_name:lower().."/main")
    end
end

botm.load = function(env)
    if not init_champion_script() then
        print("Open AIO does not support " .. player:CharName())
        return false
    end
    champion_script = init_champion_script()
    if champion_script then
        champion_script.load(env)
    end
    return true
end

botm.tick = function()
    targeting.set_next_orb_targeting_mode()
    if champion_script then
        champion_script.tick()
    end
end

botm.draw = function()
    if champion_script then
        champion_script.draw()
    end
end

botm.draw_menu = function()
    menu_style.push_style()
    if champion_script then
        champion_script.draw_menu()
    end
    menu_style.pop_style()
end

botm.request_save_settings = function()
    if champion_script then
        champion_script.request_save_settings()
    end
end

botm.process_spell = function(spell)
    action_lock.process_spell(spell)
    if champion_script then
        champion_script.process_spell(spell)
    end
end

