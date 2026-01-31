local UserInputService = game:GetService("UserInputService")

local Input = {}

function Input.OnInputBegan(maid, handler)
    local conn = UserInputService.InputBegan:Connect(function(input, processed)
        handler(input, processed)
    end)
    if maid and maid.GiveTask then
        maid:GiveTask(conn)
    end
    return conn
end

function Input.CaptureNextKey(callback)
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            if connection then
                connection:Disconnect()
            end
            callback(input.KeyCode)
        end
    end)
    return connection
end

function Input.MakeDraggable(frame, dragBar)
	local dragging = false
	local startMouse
	local startPos

	local moveConn, endConn

	local function stop()
		dragging = false
		if moveConn then moveConn:Disconnect(); moveConn = nil end
		if endConn then endConn:Disconnect(); endConn = nil end
	end

	dragBar.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		dragging = true
		startMouse = input.Position
		startPos = frame.Position

		-- track globally so drag continues even off the bar
		moveConn = UserInputService.InputChanged:Connect(function(i)
			if not dragging then return end
			if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local delta = i.Position - startMouse
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end)

		endConn = UserInputService.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				stop()
			end
		end)
	end)

	-- safety: if destroyed while dragging
	frame.AncestryChanged:Connect(function(_, parent)
		if not parent then
			stop()
		end
	end)
end


return Input
