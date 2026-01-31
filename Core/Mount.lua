local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Mount = {}

function Mount.Parent(gui)
    local parent

    local ok = pcall(function()
        parent = game:GetService("CoreGui")
        gui.Parent = parent
    end)

    if not ok or not parent or (RunService:IsStudio() and not gui.Parent) then
        local lp = Players.LocalPlayer
        if lp then
            local pg = lp:FindFirstChildOfClass("PlayerGui")
            if pg then
                gui.Parent = pg
                parent = pg
            end
        end
    end

    if not parent then
        warn("[Adrenaline] No suitable parent for ScreenGui")
        return nil
    end

    return parent
end

return Mount
