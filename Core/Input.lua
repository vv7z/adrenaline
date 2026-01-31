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
    local startPos
    local startInput

    local function update(input)
        if not dragging then
            return
        end
        local delta = input.Position - startInput.Position
        frame.Position = UDim2.new(frame.Position.X.Scale, frame.Position.X.Offset + delta.X, frame.Position.Y.Scale, frame.Position.Y.Offset + delta.Y)
    end

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input
            startPos = frame.Position
        end
    end)

    dragBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    dragBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            startInput = startInput or input
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == startInput and dragging then
            update(input)
        end
    end)
end

return Input
