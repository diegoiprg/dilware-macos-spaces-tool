-- Copyright (C) 2025 - Diego Iparraguirre
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

local spaces = require("hs.spaces")
local menu = hs.menubar.new()

-- Configuración de perfiles
local profiles = {
    personal = {
        name = "Personal",
        apps = { "Safari" },
        space_id = nil,
    },
    work = {
        name = "Work",
        apps = { "Microsoft Outlook", "Microsoft Teams", "Google Chrome" },
        space_id = nil,
    }
}

-- Retrasos configurables
local delay = {
    short = 0.5,
    medium = 1.0
}

-- Log y helper
local logFilePath = os.getenv("HOME") .. "/.hammerspoon/debug.log"
function log(msg)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local f = io.open(logFilePath, "a")
    if f then f:write(string.format("[%s] %s\n", timestamp, msg)); f:close() end
end

function clearLog() io.open(logFilePath, "w"):close() end

function notify(title, msg)
    hs.notify.new({ title = title, informativeText = msg }):send()
    log(string.format("%s - %s", title, msg))
end

function table_contains(tbl, item)
    for _, v in ipairs(tbl) do if v == item then return true end end
    return false
end

-- Crear espacio y lanzar apps del perfil
function activate_profile(profile_key)
    local profile = profiles[profile_key]
    if not profile then return end
    clearLog()

    local currentSpace = spaces.focusedSpace()
    local ok, err = pcall(function() spaces.addSpaceToScreen() end)
    if not ok then
        notify("Error", "No se pudo crear espacio para " .. profile.name)
        return
    end

    hs.timer.doAfter(delay.short, function()
        local uuid = hs.screen.mainScreen():getUUID()
        local allSpaces = spaces.allSpaces()[uuid]
        local newSpace = allSpaces[#allSpaces]

        profile.space_id = newSpace
        spaces.gotoSpace(newSpace)

        hs.timer.doAfter(delay.medium, function()
            for _, appName in ipairs(profile.apps) do
                hs.application.launchOrFocus(appName)
                hs.timer.doAfter(1, function()
                    local app = hs.application.get(appName)
                    if app then
                        local win = app:mainWindow()
                        if win then
                            spaces.moveWindowToSpace(win, newSpace)
                            log(string.format("[INFO] Ventana '%s' movida a espacio %s", appName, newSpace))
                        end
                    end
                end)
            end
            notify("Espacio activo", "Perfil " .. profile.name .. " creado")
        end)
    end)
end

-- Cerrar apps del perfil y eliminar espacio
function deactivate_profile(profile_key)
    local profile = profiles[profile_key]
    if not profile or not profile.space_id then
        notify("Error", "No hay espacio activo para " .. (profile and profile.name or profile_key))
        return
    end

    notify("Cerrando perfil", "Liberando espacio de " .. profile.name)

    -- Cerrar apps propias
    for _, appName in ipairs(profile.apps) do
        local app = hs.application.get(appName)
        if app then app:kill9() end
    end

    hs.timer.doAfter(delay.medium, function()
        -- Mover otras ventanas al primer espacio si están en este
        local uuid = hs.screen.mainScreen():getUUID()
        local fallbackSpace = spaces.allSpaces()[uuid][1]
        local win_list = hs.window.allWindows()

        for _, win in ipairs(win_list) do
            local ws = spaces.windowSpaces(win:id())
            if ws and table_contains(ws, profile.space_id) then
                local appName = win:application():name()
                if not table_contains(profile.apps, appName) then
                    spaces.moveWindowToSpace(win, fallbackSpace)
                    log("[INFO] Ventana de " .. appName .. " movida a espacio personal")
                end
            end
        end

        spaces.gotoSpace(fallbackSpace)

        hs.timer.doAfter(delay.medium, function()
            local ok, err = pcall(function() return spaces.removeSpace(profile.space_id) end)
            if ok then
                notify("Espacio cerrado", "Perfil " .. profile.name .. " eliminado")
                profile.space_id = nil
            else
                notify("Error", "No se pudo eliminar espacio: " .. tostring(err))
            end
        end)
    end)
end

-- Menú
function build_menu()
    menu:setTitle("Spaces 🧭")
    menu:setMenu({
        { title = "🟢 Activar Perfil Personal", fn = function() activate_profile("personal") end },
        { title = "🟢 Activar Perfil Work", fn = function() activate_profile("work") end },
        { title = "-" },
        { title = "🔴 Cerrar Perfil Personal", fn = function() deactivate_profile("personal") end },
        { title = "🔴 Cerrar Perfil Work", fn = function() deactivate_profile("work") end },
        { title = "-" },
        { title = "📝 Ver Log", fn = function() hs.execute("open -a TextEdit " .. logFilePath) end },
        { title = "🔄 Recargar", fn = hs.reload },
        { title = "❌ Salir", fn = function() hs.alert.show("Saliendo..."); os.exit() end },
    })
end

-- Inicialización
clearLog()
notify("Sistema iniciado", "Gestor de espacios personalizado listo.")
build_menu()