local Layouts = GET("UI/Layouts.lua")
local Input = GET("Core/Input.lua")

local Keypicker = {}
Keypicker.__index = Keypicker

function Keypicker.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Keypicker)
    self.Groupbox = groupbox
    self.Value = opts.Default or Enum.KeyCode.Unknown
    self.Callback = opts.Callback or function() end
    self.Listening = false

    local frame = Instance.new("Frame")
    frame.Name = label .. "Keypicker"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local labelText = Instance.new("TextLabel")
    labelText.BackgroundTransparency = 1
    labelText.Size = UDim2.new(0.5, 0, 1, 0)
    labelText.Font = Enum.Font.Gotham
    labelText.Text = label
    labelText.TextColor3 = Layouts.Theme.Text
    labelText.TextSize = 14
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = frame

    local button = Instance.new("TextButton")
    button.Name = "KeyButton"
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.Position = UDim2.new(1, 0, 0.5, 0)
    button.Size = UDim2.new(0, 140, 0, 26)
    button.BackgroundColor3 = Layouts.Theme.Background
    button.TextColor3 = Layouts.Theme.Text
    button.Text = self:KeyToText(self.Value)
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
        if self.Listening then
            return
        end
        self:Arm()
    end)

    return self
end

function Keypicker:KeyToText(key)
    if key == Enum.KeyCode.Unknown then
        return "None"
    end
    return key.Name
end

function Keypicker:Arm()
    self.Listening = true
    if self.Button then
        self.Button.Text = "Press a key (ESC to cancel)"
        self.Button.BackgroundColor3 = Layouts.Theme.Accent
    end
    self.CaptureConn = Input.CaptureNextKey(function(key)
        if key == Enum.KeyCode.Escape then
            self:Cancel()
            return
        end
        self:Set(key)
    end)
end

function Keypicker:Cancel()
    self.Listening = false
    if self.CaptureConn then
        self.CaptureConn:Disconnect()
        self.CaptureConn = nil
    end
    if self.Button then
        self.Button.BackgroundColor3 = Layouts.Theme.Background
        self.Button.Text = self:KeyToText(self.Value)
    end
end

function Keypicker:Set(key)
    self.Value = key
    self:Cancel()
    if self.Button then
        self.Button.Text = self:KeyToText(key)
    end
    self.Callback(self.Value)
end

function Keypicker:Get()
    return self.Value
end

function Keypicker:Destroy()
    if self.CaptureConn then
        self.CaptureConn:Disconnect()
    end
    if self.Root then
        self.Root:Destroy()
    end
end

return Keypicker
