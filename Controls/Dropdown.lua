local Layouts = GET("UI/Layouts.lua")
local Portal = GET("UI/Portal.lua")

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Dropdown)
    self.Groupbox = groupbox
    self.Options = opts.Options or {}
    self.Value = opts.Default or (self.Options[1] or "")
    self.Callback = opts.Callback or function() end
    self.Open = false

    local frame = Instance.new("Frame")
    frame.Name = label .. "Dropdown"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local labelText = Instance.new("TextLabel")
    labelText.BackgroundTransparency = 1
    labelText.Size = UDim2.new(1, 0, 1, 0)
    labelText.Font = Enum.Font.Gotham
    labelText.Text = label
    labelText.TextColor3 = Layouts.Theme.Text
    labelText.TextSize = 14
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = frame

    local button = Instance.new("TextButton")
    button.Name = "DropdownButton"
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.Position = UDim2.new(1, 0, 0.5, 0)
    button.Size = UDim2.new(0, 160, 0, 28)
    button.BackgroundColor3 = Layouts.Theme.Background
    button.TextColor3 = Layouts.Theme.Text
    button.Text = tostring(self.Value)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = frame
    self.Button = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Layouts.Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = button

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        if self.Open then
            self:CloseList()
        else
            self:OpenList()
        end
    end)

    return self
end

function Dropdown:OpenList()
    if self.Open then
        return
    end
    self.Open = true
    local options = self.Options
    local button = self.Button
    if not button then
        return
    end

    local portalRoot = Portal.GetRoot()
    if not portalRoot then
        warn("[Adrenaline] Portal root unavailable for dropdown")
        return
    end

    local listFrame = Instance.new("Frame")
    listFrame.Name = "DropdownList"
    listFrame.Size = UDim2.new(0, button.AbsoluteSize.X, 0, #options * Layouts.RowHeight)
    listFrame.BackgroundColor3 = Layouts.Theme.Surface
    listFrame.BorderSizePixel = 0
    listFrame.Position = UDim2.new(0, button.AbsolutePosition.X, 0, button.AbsolutePosition.Y + button.AbsoluteSize.Y + 2)
    listFrame.Parent = portalRoot
    self.ListFrame = listFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Layouts.Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = listFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = listFrame

    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, -4, 0, Layouts.RowHeight)
        optBtn.BackgroundColor3 = Layouts.Theme.Background
        optBtn.TextColor3 = Layouts.Theme.Text
        optBtn.Text = tostring(opt)
        optBtn.BorderSizePixel = 0
        optBtn.AutoButtonColor = false
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 14
        optBtn.Parent = listFrame

        local optCorner = Instance.new("UICorner")
        optCorner.CornerRadius = Layouts.CornerRadius
        optCorner.Parent = optBtn

        optBtn.MouseButton1Click:Connect(function()
            self:Set(opt)
            self:CloseList()
        end)
    end
end

function Dropdown:CloseList()
    self.Open = false
    if self.ListFrame then
        self.ListFrame:Destroy()
        self.ListFrame = nil
    end
end

function Dropdown:Set(v)
    self.Value = v
    if self.Button then
        self.Button.Text = tostring(v)
    end
    self.Callback(self.Value)
end

function Dropdown:Get()
    return self.Value
end

function Dropdown:Destroy()
    self:CloseList()
    if self.Root then
        self.Root:Destroy()
    end
end

return Dropdown
