local Mount = GET("Core/Mount.lua")
local Maid = GET("Core/Maid.lua")
local Input = GET("Core/Input.lua")
local Layouts = GET("UI/Layouts.lua")
local Tabs = GET("UI/Tabs.lua")

local Window = {}
Window.__index = Window

function Window.new(config)
    config = config or {}
    local self = setmetatable({}, Window)
    self.Maid = Maid.new()
    self.Tabs = {}

    local size = config.Size or UDim2.fromOffset(1100, 650)
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdrenalineUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.RootGui = gui

    if not Mount.Parent(gui) then
        return nil
    end

    local main = Instance.new("Frame")
    main.Name = "Window"
    main.Size = size
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.BackgroundColor3 = Layouts.Theme.Background
    main.BorderSizePixel = 0
    main.Parent = gui
    self.Root = main

    local stroke = Instance.new("UIStroke")
    stroke.Color = Layouts.Theme.Stroke
    stroke.Thickness = 1
    stroke.Parent = main

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Layouts.CornerRadius
    corner.Parent = main

    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 42)
    topbar.BackgroundColor3 = Layouts.Theme.Surface
    topbar.BorderSizePixel = 0
    topbar.Parent = main

    local topStroke = Instance.new("UIStroke")
    topStroke.Color = Layouts.Theme.Stroke
    topStroke.Thickness = 1
    topStroke.Parent = topbar

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 12, 0, 0)
    title.Size = UDim2.new(1, -24, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = config.Title or "Adrenaline"
    title.TextColor3 = Layouts.Theme.Text
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topbar

    local body = Instance.new("Frame")
    body.Name = "Body"
    body.BackgroundTransparency = 1
    body.Position = UDim2.new(0, 0, 0, topbar.Size.Y.Offset)
    body.Size = UDim2.new(1, 0, 1, -topbar.Size.Y.Offset)
    body.Parent = main

    local tabsHolder = Instance.new("Frame")
    tabsHolder.Name = "TabsHolder"
    tabsHolder.BackgroundColor3 = Layouts.Theme.Surface
    tabsHolder.BorderSizePixel = 0
    tabsHolder.Position = UDim2.new(0, Layouts.Padding, 0, Layouts.Padding)
    tabsHolder.Size = UDim2.new(0, 180, 1, -Layouts.Padding * 2)
    tabsHolder.Parent = body

    local tabsCorner = Instance.new("UICorner")
    tabsCorner.CornerRadius = Layouts.CornerRadius
    tabsCorner.Parent = tabsHolder

    local tabsList = Instance.new("UIListLayout")
    tabsList.FillDirection = Enum.FillDirection.Vertical
    tabsList.SortOrder = Enum.SortOrder.LayoutOrder
    tabsList.Padding = UDim.new(0, 6)
    tabsList.Parent = tabsHolder

    local tabsPadding = Instance.new("UIPadding")
    tabsPadding.PaddingTop = UDim.new(0, 10)
    tabsPadding.PaddingBottom = UDim.new(0, 10)
    tabsPadding.PaddingLeft = UDim.new(0, 10)
    tabsPadding.PaddingRight = UDim.new(0, 10)
    tabsPadding.Parent = tabsHolder

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundColor3 = Layouts.Theme.Surface
    content.BorderSizePixel = 0
    content.Position = UDim2.new(0, 180 + Layouts.Padding * 2, 0, Layouts.Padding)
    content.Size = UDim2.new(1, -180 - Layouts.Padding * 3, 1, -Layouts.Padding * 2)
    content.Parent = body

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = Layouts.CornerRadius
    contentCorner.Parent = content

    self.TabContainer = tabsHolder
    self.TabListLayout = tabsList
    self.Content = content
    self.Body = body

    Input.MakeDraggable(main, topbar)

    return self
end

function Window:AddTab(name)
    local tab = Tabs.new(self, name)
    table.insert(self.Tabs, tab)
    if not self.ActiveTab then
        tab:Show()
        self.ActiveTab = tab
    else
        tab:Hide()
    end
    return tab
end

function Window:Show()
    self.Root.Visible = true
end

function Window:Hide()
    self.Root.Visible = false
end

function Window:Destroy()
    if self.Maid then
        self.Maid:Destroy()
    end
    if self.RootGui then
        self.RootGui:Destroy()
    end
end

return Window
