local BASE = "https://raw.githubusercontent.com/vv7z/adrenaline/main/"
local loaderSource = game:HttpGet(BASE .. "loader.lua")
local Adrenaline = loadstring(loaderSource)()

if not Adrenaline then
    warn("[Adrenaline Demo] Failed to load library")
    return
end

local win = Adrenaline:CreateWindow({ Title = "Adrenaline Demo", Size = UDim2.fromOffset(1100, 650) })
if not win then
    warn("[Adrenaline Demo] Failed to create window")
    return
end

local tabMain = win:AddTab("Main")
local tabSettings = win:AddTab("Settings")

-- Main tab groupboxes
local mainLeft = tabMain.Columns.Left:AddGroupbox("Movement")
local mainMid = tabMain.Columns.Middle:AddGroupbox("Combat")

mainLeft:AddToggle("Speed", { Default = false, Callback = function(v) print("Speed", v) end })
mainLeft:AddSlider("Speed Value", { Min = 0, Max = 200, Default = 50, Callback = function(v) print("Speed Value", v) end })
mainLeft:AddDropdown("Mode", { Options = { "Walk", "Run", "Fly" }, Default = "Walk", Callback = function(v) print("Mode", v) end })

mainMid:AddToggle("Godmode", { Default = false, Callback = function(v) print("Godmode", v) end })
mainMid:AddCheckbox("Silent Aim", { Default = false, Callback = function(v) print("Silent Aim", v) end })
mainMid:AddSlider("FOV", { Min = 10, Max = 120, Default = 60, Callback = function(v) print("FOV", v) end })
mainMid:AddDropdown("Weapon", { Options = { "Sword", "Bow", "Magic" }, Default = "Sword", Callback = function(v) print("Weapon", v) end })

-- Settings tab groupboxes
local settingsLeft = tabSettings.Columns.Left:AddGroupbox("Input")
local settingsRight = tabSettings.Columns.Right:AddGroupbox("Misc")

settingsLeft:AddTextInput("Player Name", { Default = "Player", Callback = function(v) print("Name", v) end })
settingsLeft:AddKeypicker("Activation Key", { Default = Enum.KeyCode.RightShift, Callback = function(k) print("Key", k.Name) end })

settingsRight:AddButton("Destroy UI", { Callback = function()
    if win then
        win:Destroy()
    end
end })

return true
