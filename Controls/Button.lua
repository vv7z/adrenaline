local Layouts = GET("UI/Layouts.lua")

local Button = {}
Button.__index = Button

function Button.new(groupbox, label, opts)
    opts = opts or {}
    local self = setmetatable({}, Button)
    self.Groupbox = groupbox
    self.Callback = opts.Callback or function() end

    local frame = Instance.new("Frame")
    frame.Name = label .. "Button"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, Layouts.RowHeight)
    frame.Parent = groupbox.Frame
    self.Root = frame

    local button = Instance.new("TextButton")
    button.Name = "ActionButton"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Layouts.Theme.Accent
    button.TextColor3 = Layouts.Theme.Text
    button.Text = label
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = frame
    self.Button = button

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        self.Callback()
    end)

    return self
end

function Button:Set()
end

function Button:Get()
    return nil
end

function Button:Destroy()
    if self.Root then
        self.Root:Destroy()
    end
end

return Button
