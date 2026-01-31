local Layouts = {}

-- ===== Theme (your palette) =====
Layouts.Theme = {
	Background = Color3.fromHex("#1c1c1c"),      -- surface-a0
	Surface    = Color3.fromHex("#313131"),      -- surface-a10
	Surface2   = Color3.fromHex("#474747"),      -- surface-a20
	Tonal      = Color3.fromHex("#2d252a"),      -- tonal surface-a0 (slight pink warmth)
	Stroke     = Color3.fromHex("#474747"),      -- surface-a20 as stroke
	Text       = Color3.fromRGB(235,235,235),
	SubText    = Color3.fromRGB(185,185,185),
	Accent     = Color3.fromHex("#de7ac5"),
}

-- ===== Layout scale =====
Layouts.CornerRadius = UDim.new(0, 10)
Layouts.WindowPadding = 14
Layouts.Gap = 12
Layouts.GapSmall = 8

Layouts.TopbarHeight = 44
Layouts.SidebarWidth = 190

Layouts.RowHeight = 36
Layouts.ControlPadX = 12
Layouts.ControlPadY = 10

Layouts.GroupPad = 12
Layouts.GroupHeaderH = 30

-- helper for control containers
function Layouts.ApplyControlContainer(frame)
	frame.BackgroundColor3 = Layouts.Theme.Surface
	frame.BorderSizePixel = 0

	local c = Instance.new("UICorner")
	c.CornerRadius = Layouts.CornerRadius
	c.Parent = frame

	local s = Instance.new("UIStroke")
	s.Color = Layouts.Theme.Stroke
	s.Thickness = 1
	s.Transparency = 0.35
	s.Parent = frame

	local p = Instance.new("UIPadding")
	p.PaddingLeft  = UDim.new(0, Layouts.ControlPadX)
	p.PaddingRight = UDim.new(0, Layouts.ControlPadX)
	p.PaddingTop   = UDim.new(0, Layouts.ControlPadY)
	p.PaddingBottom= UDim.new(0, Layouts.ControlPadY)
	p.Parent = frame

	return frame
end

return Layouts
