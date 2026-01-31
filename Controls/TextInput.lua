local Layouts = GET("UI/Layouts.lua")

local TextInput = {}
TextInput.__index = TextInput

function TextInput.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, TextInput)
    self.Groupbox = groupbox
    self.Value = opts.Default or ""
    self.Callback = opts.Callback or function() end

    local frame = Instance.new("Frame")
    frame.Name = label .. "TextInput"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local labelText = Instance.new("TextLabel")
    labelText.BackgroundTransparency = 1
    labelText.Size = UDim2.new(0.4, 0, 1, 0)
    labelText.Font = Enum.Font.Gotham
    labelText.Text = label
    labelText.TextColor3 = Layouts.Theme.Text
    labelText.TextSize = 14
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = frame

    local box = Instance.new("TextBox")
    box.Name = "InputBox"
    box.AnchorPoint = Vector2.new(1, 0.5)
    box.Position = UDim2.new(1, 0, 0.5, 0)
    box.Size = UDim2.new(0.6, -6, 1, -4)
    box.BackgroundColor3 = Layouts.Theme.Background
    box.TextColor3 = Layouts.Theme.Text
    box.PlaceholderText = opts.Placeholder or ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.ClearTextOnFocus = false
    box.Text = tostring(self.Value)
    box.BorderSizePixel = 0
    box.Parent = frame
    self.Box = box

    local stroke = Instance.new("UIStroke")
    stroke.Color = Layouts.Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = box

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = box

    box.FocusLost:Connect(function(enterPressed)
        self.Value = box.Text
        self.Callback(self.Value, enterPressed)
    end)

    return self
end

function TextInput:Set(v)
    self.Value = tostring(v)
    if self.Box then
        self.Box.Text = self.Value
    end
end

function TextInput:Get()
    return self.Value
end

function TextInput:Destroy()
    if self.Root then
        self.Root:Destroy()
    end
end

return TextInput
