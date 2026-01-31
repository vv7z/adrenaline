local BASE = "https://raw.githubusercontent.com/vv7z/adrenaline/main/"
local CACHE = {}

local function http_get(url)
    local ok, result = pcall(function()
        if game and game.HttpGet then
            return game:HttpGet(url)
        end
        if syn and syn.request then
            local res = syn.request({ Url = url, Method = "GET" })
            if res and res.Success then
                return res.Body
            end
        end
        local requestImpl = (http and http.request) or request
        if requestImpl then
            local res = requestImpl({ Url = url, Method = "GET" })
            if res and (res.Success or res.StatusCode == 200) then
                return res.Body
            end
        end
        error("HttpGet unavailable")
    end)

    if ok then
        return result
    else
        warn("[Adrenaline] HttpGet failed for " .. tostring(url))
        return nil
    end
end

local function FETCH(path)
    local url = BASE .. path
    return http_get(url)
end

local function GET(path)
    if CACHE[path] ~= nil then
        return CACHE[path]
    end

    local source = FETCH(path)
    if not source then
        warn("[Adrenaline] Unable to fetch module: " .. tostring(path))
        return nil
    end

    local chunk, err = loadstring(source, "@" .. path)
    if not chunk then
        warn("[Adrenaline] Compile error in " .. path .. ": " .. tostring(err))
        return nil
    end

    local env = setmetatable({ GET = GET, FETCH = FETCH, BASE = BASE, CACHE = CACHE }, { __index = getfenv() })
    setfenv(chunk, env)

    local success, result = pcall(chunk)
    if not success then
        warn("[Adrenaline] Runtime error in " .. path .. ": " .. tostring(result))
        return nil
    end

    CACHE[path] = result
    return result
end

local Window = GET("UI/Window.lua")
local Adrenaline = {}

function Adrenaline:CreateWindow(config)
    return Window.new(config)
end

return Adrenaline
