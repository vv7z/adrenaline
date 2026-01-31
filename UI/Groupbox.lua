local Layouts = GET("UI/Layouts.lua")

local Toggle = GET("Controls/Toggle.lua")
local Checkbox = GET("Controls/Checkbox.lua")
local Slider = GET("Controls/Slider.lua")
local Dropdown = GET("Controls/Dropdown.lua")
local TextInput = GET("Controls/TextInput.lua")
local Keypicker = GET("Controls/Keypicker.lua")
local Button = GET("Controls/Button.lua")

local Groupbox = {}
Groupbox.__index = Groupbox

function Groupbox.new(column, title)
    local self = setmetatable({}, Groupbox)
    self.Column = column

    local frame = Instance.new("Frame")
    frame.Name = (title or "Group") .. "Box"
    frame.BackgroundColor3 = Layouts.Theme.Background
    frame.BorderSizePixel = 0
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.Parent = column.Frame
    self.Frame = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Layouts.Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = frame

    Layouts.UIPadding(frame, Layouts.Padding)
    local list = Layouts.UIList(frame, 6)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Left

    local header = Instance.new("TextLabel")
    header.BackgroundTransparency = 1
    header.Size = UDim2.new(1, 0, 0, 18)
    header.Font = Enum.Font.GothamBold
    header.Text = title or "Group"
    header.TextColor3 = Layouts.Theme.Text
    header.TextSize = 16
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = frame
    self.TitleLabel = header

    return self
end

function Groupbox:AddToggle(label, opts)
    return Toggle.new(self, label, opts)
end

function Groupbox:AddCheckbox(label, opts)
    return Checkbox.new(self, label, opts)
end

function Groupbox:AddSlider(label, opts)
    return Slider.new(self, label, opts)
end

function Groupbox:AddDropdown(label, opts)
    return Dropdown.new(self, label, opts)
end

function Groupbox:AddTextInput(label, opts)
    return TextInput.new(self, label, opts)
end

function Groupbox:AddKeypicker(label, opts)
    return Keypicker.new(self, label, opts)
end

function Groupbox:AddButton(label, opts)
    return Button.new(self, label, opts)
end

return Groupbox
