local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({ _tasks = {} }, Maid)
end

function Maid:GiveTask(task)
    if not task then
        return task
    end
    local id = #self._tasks + 1
    self._tasks[id] = task
    return task
end

function Maid:DoCleaning()
    for key, task in pairs(self._tasks) do
        local t = task
        local taskType = typeof(t)
        if taskType == "function" then
            pcall(t)
        elseif taskType == "RBXScriptConnection" then
            if t.Connected then
                pcall(function()
                    t:Disconnect()
                end)
            end
        elseif taskType == "Instance" then
            if t.Destroy then
                pcall(function()
                    t:Destroy()
                end)
            end
        end
        self._tasks[key] = nil
    end
end

function Maid:Destroy()
    self:DoCleaning()
end

return Maid
