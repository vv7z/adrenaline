local Layouts = GET("UI/Layouts.lua")
local Groupbox = GET("UI/Groupbox.lua")

local Columns = {}
Columns.__index = Columns

function Columns.new(tab, parent)
    local self = setmetatable({}, Columns)
    self.Tab = tab

    self.Left = Columns.createColumn(tab, parent, "Left")
    self.Middle = Columns.createColumn(tab, parent, "Middle")
    self.Right = Columns.createColumn(tab, parent, "Right")

    return self
end

function Columns.createColumn(tab, parent, name)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Column"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1/3, -Layouts.Padding, 1, 0)
    frame.LayoutOrder = name == "Left" and 1 or (name == "Middle" and 2 or 3)
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.Parent = parent

    Layouts.UIList(frame, Layouts.Padding)

    local column = {
        Frame = frame,
        Tab = tab,
    }

    function column:AddGroupbox(title)
        return Groupbox.new(self, title)
    end

    return column
end

return Columns
