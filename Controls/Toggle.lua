local Layouts = GET("UI/Layouts.lua")

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Toggle)
    self.Groupbox = groupbox
    self.Value = opts.Default or false
    self.Callback = opts.Callback or function() end

    local frame = Instance.new("Frame")
    frame.Name = label .. "Toggle"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local labelText = Instance.new("TextLabel")
    labelText.BackgroundTransparency = 1
    labelText.Size = UDim2.new(1, -60, 1, 0)
    labelText.Font = Enum.Font.Gotham
    labelText.Text = label
    labelText.TextColor3 = Layouts.Theme.Text
    labelText.TextSize = 14
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = frame

    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.Position = UDim2.new(1, 0, 0.5, 0)
    button.Size = UDim2.new(0, 48, 0, 22)
    button.BackgroundColor3 = Layouts.Theme.Stroke
    button.Text = ""
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = button

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 1, 0, 1)
    knob.BackgroundColor3 = Layouts.Theme.Background
    knob.BorderSizePixel = 0
    knob.Parent = button

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local function render()
        if self.Value then
            button.BackgroundColor3 = Layouts.Theme.Accent
            knob.Position = UDim2.new(1, -21, 0, 1)
        else
            button.BackgroundColor3 = Layouts.Theme.Stroke
            knob.Position = UDim2.new(0, 1, 0, 1)
        end
    end

    button.MouseButton1Click:Connect(function()
        self:Set(not self.Value)
    end)

    render()

    return self
end

function Toggle:Set(v)
    self.Value = v and true or false
    local button = self.Root:FindFirstChild("ToggleButton")
    if button then
        local knob = button:FindFirstChild("Knob")
        if self.Value then
            button.BackgroundColor3 = Layouts.Theme.Accent
            if knob then
                knob.Position = UDim2.new(1, -21, 0, 1)
            end
        else
            button.BackgroundColor3 = Layouts.Theme.Stroke
            if knob then
                knob.Position = UDim2.new(0, 1, 0, 1)
            end
        end
    end
    self.Callback(self.Value)
end

function Toggle:Get()
    return self.Value
end

function Toggle:Destroy()
    if self.Root then
        self.Root:Destroy()
    end
end

return Toggle
