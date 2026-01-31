local Layouts = {}

Layouts.Theme = {
    Background = Color3.fromRGB(28, 28, 28),
    Surface = Color3.fromRGB(49, 49, 49),
    Stroke = Color3.fromRGB(71, 71, 71),
    Text = Color3.fromRGB(235, 235, 235),
    Accent = Color3.fromHex("#de7ac5"),
}

Layouts.RowHeight = 34
Layouts.Padding = 8
Layouts.CornerRadius = UDim.new(0, 6)

function Layouts.Label(parent, text, size, bold)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, size or 16)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = size or 16
    label.Text = text or ""
    label.TextColor3 = Layouts.Theme.Text
    if bold then
        label.Font = Enum.Font.GothamBold
    end
    label.Parent = parent
    return label
end

function Layouts.UIPadding(target, padding)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, padding)
    pad.PaddingBottom = UDim.new(0, padding)
    pad.PaddingLeft = UDim.new(0, padding)
    pad.PaddingRight = UDim.new(0, padding)
    pad.Parent = target
    return pad
end

function Layouts.UIList(target, padding)
    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Left
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, padding or 6)
    list.Parent = target
    return list
end

return Layouts
