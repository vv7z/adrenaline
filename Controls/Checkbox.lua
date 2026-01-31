local Layouts = GET("UI/Layouts.lua")

local Checkbox = {}
Checkbox.__index = Checkbox

function Checkbox.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Checkbox)
    self.Groupbox = groupbox
    self.Value = opts.Default or false
    self.Callback = opts.Callback or function() end

    local frame = Instance.new("TextButton")
    frame.Name = label .. "Checkbox"
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.BackgroundTransparency = 1
    frame.AutoButtonColor = false
    frame.Text = ""
    frame.Parent = groupbox.Frame
    self.Root = frame

    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Size = UDim2.new(0, 18, 0, 18)
    box.Position = UDim2.new(0, 0, 0.5, -9)
    box.BackgroundColor3 = Layouts.Theme.Background
    box.BorderSizePixel = 0
    box.Parent = frame

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Layouts.Theme.Stroke
    boxStroke.Thickness = 1
    boxStroke.Parent = box

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = box

    local check = Instance.new("Frame")
    check.Name = "Check"
    check.Size = UDim2.new(1, -4, 1, -4)
    check.Position = UDim2.new(0, 2, 0, 2)
    check.BackgroundColor3 = Layouts.Theme.Accent
    check.BorderSizePixel = 0
    check.Visible = self.Value
    check.Parent = box

    local labelText = Instance.new("TextLabel")
    labelText.BackgroundTransparency = 1
    labelText.Position = UDim2.new(0, 26, 0, 0)
    labelText.Size = UDim2.new(1, -26, 1, 0)
    labelText.Font = Enum.Font.Gotham
    labelText.Text = label
    labelText.TextColor3 = Layouts.Theme.Text
    labelText.TextSize = 14
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = frame

    frame.MouseButton1Click:Connect(function()
        self:Set(not self.Value)
    end)

    return self
end

function Checkbox:Set(v)
    self.Value = v and true or false
    local box = self.Root:FindFirstChild("Box")
    if box then
        local check = box:FindFirstChild("Check")
        if check then
            check.Visible = self.Value
        end
    end
    self.Callback(self.Value)
end

function Checkbox:Get()
    return self.Value
end

function Checkbox:Destroy()
    if self.Root then
        self.Root:Destroy()
    end
end

return Checkbox
