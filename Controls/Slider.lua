local Layouts = GET("UI/Layouts.lua")

local Slider = {}
Slider.__index = Slider

function Slider.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Slider)
    self.Groupbox = groupbox
    self.Min = opts.Min or 0
    self.Max = opts.Max or 100
    self.Default = opts.Default or self.Min
    self.Value = self.Default
    self.Callback = opts.Callback or function() end

    local frame = Instance.new("Frame")
    frame.Name = label .. "Slider"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight * 1.6)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, Layouts.RowHeight / 2)
    title.Font = Enum.Font.Gotham
    title.Text = label
    title.TextColor3 = Layouts.Theme.Text
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(1, 0, 0, Layouts.RowHeight / 2)
    valueLabel.Position = UDim2.new(0, 0, 0, Layouts.RowHeight / 2)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.Text = tostring(self.Value)
    valueLabel.TextColor3 = Layouts.Theme.Text
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.Parent = frame
    self.ValueLabel = valueLabel

    local bar = Instance.new("Frame")
    bar.Name = "Bar"
    bar.Size = UDim2.new(1, 0, 0, 8)
    bar.Position = UDim2.new(0, 0, 0, Layouts.RowHeight + 4)
    bar.BackgroundColor3 = Layouts.Theme.Stroke
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Layouts.Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    self.Fill = fill

    local dragging = false

    local function setFromInput(x)
        local absPos = bar.AbsolutePosition.X
        local absSize = bar.AbsoluteSize.X
        local alpha = math.clamp((x - absPos) / absSize, 0, 1)
        local val = self.Min + (self.Max - self.Min) * alpha
        self:Set(val)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            setFromInput(input.Position.X)
        end
    end)

    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    bar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            setFromInput(input.Position.X)
        end
    end)

    self:Set(self.Value)

    return self
end

function Slider:Set(v)
    local clamped = math.clamp(v, self.Min, self.Max)
    self.Value = clamped
    local alpha = (clamped - self.Min) / (self.Max - self.Min)
    if self.Fill then
        self.Fill.Size = UDim2.new(alpha, 0, 1, 0)
    end
    if self.ValueLabel then
        self.ValueLabel.Text = string.format("%s", tostring(math.floor(clamped + 0.5)))
    end
    self.Callback(self.Value)
end

function Slider:Get()
    return self.Value
end

function Slider:Destroy()
    if self.Root then
        self.Root:Destroy()
    end
end

return Slider
