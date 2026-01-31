local Layouts = GET("UI/Layouts.lua")

local Toggle    = GET("Controls/Toggle.lua")
local Checkbox  = GET("Controls/Checkbox.lua")
local Slider    = GET("Controls/Slider.lua")
local Dropdown  = GET("Controls/Dropdown.lua")
local TextInput = GET("Controls/TextInput.lua")
local Keypicker = GET("Controls/Keypicker.lua")
local Button    = GET("Controls/Button.lua")

local Groupbox = {}
Groupbox.__index = Groupbox

function Groupbox.new(column, title)
	local self = setmetatable({}, Groupbox)
	self.Column = column

	-- Root card
	local root = Instance.new("Frame")
	root.Name = (title or "Group") .. "Box"
	root.BackgroundColor3 = Layouts.Theme.Surface -- IMPORTANT: not Background
	root.BorderSizePixel = 0
	root.AutomaticSize = Enum.AutomaticSize.Y
	root.Size = UDim2.new(1, 0, 0, 0)
	root.Parent = column.Frame
	self.Root = root
	self.Frame = root -- keep compatibility with existing controls

	local corner = Instance.new("UICorner")
	corner.CornerRadius = Layouts.CornerRadius
	corner.Parent = root

	local stroke = Instance.new("UIStroke")
	stroke.Color = Layouts.Theme.Stroke
	stroke.Thickness = 1
	stroke.Transparency = 0.35
	stroke.Parent = root

	-- Inner padding for the whole card
	if Layouts.UIPadding then
		Layouts.UIPadding(root, Layouts.GroupPad or Layouts.Padding or 12)
	else
		local p = Instance.new("UIPadding")
		local pad = Layouts.GroupPad or Layouts.Padding or 12
		p.PaddingTop = UDim.new(0, pad)
		p.PaddingBottom = UDim.new(0, pad)
		p.PaddingLeft = UDim.new(0, pad)
		p.PaddingRight = UDim.new(0, pad)
		p.Parent = root
	end

	-- Vertical stack: header then content
	local stack = Instance.new("UIListLayout")
	stack.FillDirection = Enum.FillDirection.Vertical
	stack.SortOrder = Enum.SortOrder.LayoutOrder
	stack.Padding = UDim.new(0, Layouts.GapSmall or 8)
	stack.Parent = root

	-- Header row
	local headerRow = Instance.new("Frame")
	headerRow.Name = "Header"
	headerRow.BackgroundTransparency = 1
	headerRow.Size = UDim2.new(1, 0, 0, Layouts.GroupHeaderH or 24)
	headerRow.LayoutOrder = 1
	headerRow.Parent = root

	local header = Instance.new("TextLabel")
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 1, 0)
	header.Font = Enum.Font.GothamBold
	header.Text = title or "Group"
	header.TextColor3 = Layouts.Theme.Text
	header.TextSize = 15
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.TextYAlignment = Enum.TextYAlignment.Center
	header.Parent = headerRow
	self.TitleLabel = header

	-- Content container (controls mount here)
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.BackgroundTransparency = 1
	content.AutomaticSize = Enum.AutomaticSize.Y
	content.Size = UDim2.new(1, 0, 0, 0)
	content.LayoutOrder = 2
	content.Parent = root
	self.Content = content

	-- controls stack inside content
	local list = Instance.new("UIListLayout")
	list.FillDirection = Enum.FillDirection.Vertical
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, Layouts.GapSmall or 8)
	list.Parent = content

	-- Slight inset for controls so they align nicely inside the card
	local inset = Layouts.ControlInset or 0
	if inset > 0 then
		local cp = Instance.new("UIPadding")
		cp.PaddingLeft = UDim.new(0, inset)
		cp.PaddingRight = UDim.new(0, inset)
		cp.Parent = content
	end

	return self
end

function Groupbox:AddToggle(label, opts)    return Toggle.new(self, label, opts) end
function Groupbox:AddCheckbox(label, opts)  return Checkbox.new(self, label, opts) end
function Groupbox:AddSlider(label, opts)    return Slider.new(self, label, opts) end
function Groupbox:AddDropdown(label, opts)  return Dropdown.new(self, label, opts) end
function Groupbox:AddTextInput(label, opts) return TextInput.new(self, label, opts) end
function Groupbox:AddKeypicker(label, opts) return Keypicker.new(self, label, opts) end
function Groupbox:AddButton(label, opts)    return Button.new(self, label, opts) end

return Groupbox
