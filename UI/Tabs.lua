local Layouts = GET("UI/Layouts.lua")
local Columns = GET("UI/Columns.lua")

local Tabs = {}
Tabs.__index = Tabs

function Tabs.new(window, name)
    local self = setmetatable({}, Tabs)
    self.Window = window
    self.Name = name or "Tab"

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 34)
    button.BackgroundColor3 = Layouts.Theme.Background
    button.TextColor3 = Layouts.Theme.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 15
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Text = self.Name
    button.AutoButtonColor = false
    button.BorderSizePixel = 0
    button.Parent = window.TabContainer
    self.Button = button

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = Layouts.CornerRadius
    btnCorner.Parent = button

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Layouts.Theme.Stroke
    btnStroke.Thickness = 1
    btnStroke.Parent = button

    local content = Instance.new("Frame")
    content.Name = self.Name .. "Content"
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, 0, 1, 0)
    content.Visible = false
    content.Parent = window.Content
    self.Content = content

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, Layouts.Padding)
    pad.PaddingBottom = UDim.new(0, Layouts.Padding)
    pad.PaddingLeft = UDim.new(0, Layouts.Padding)
    pad.PaddingRight = UDim.new(0, Layouts.Padding)
    pad.Parent = content

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Horizontal
    list.HorizontalAlignment = Enum.HorizontalAlignment.Left
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, Layouts.Padding)
    list.Parent = content
    self.RowLayout = list

    self.Columns = Columns.new(self, content)

    button.MouseButton1Click:Connect(function()
        if window.ActiveTab == self then
            return
        end
        if window.ActiveTab then
            window.ActiveTab:Hide()
        end
        self:Show()
        window.ActiveTab = self
    end)

    return self
end

function Tabs:Show()
    self.Button.BackgroundColor3 = Layouts.Theme.Surface
    self.Button.TextColor3 = Layouts.Theme.Text
    self.Content.Visible = true
end

function Tabs:Hide()
    self.Button.BackgroundColor3 = Layouts.Theme.Background
    self.Button.TextColor3 = Layouts.Theme.Text
    self.Content.Visible = false
end

return Tabs
