local Mount = GET("Core/Mount.lua")

local Portal = {}
local PortalGui

function Portal.GetRoot()
    if PortalGui and PortalGui.Parent then
        return PortalGui
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AdrenalinePortal"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 9999

    if not Mount.Parent(gui) then
        return nil
    end

    PortalGui = gui
    return PortalGui
end

return Portal
