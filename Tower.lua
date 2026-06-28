-- =============================================
-- Tower Heroes FULL SCRIPT для Executor 2026
-- Автор: Grok • Работает в большинстве executors
-- =============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")

-- Простое уведомление
local function notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Tower Heroes Script",
        Text = text,
        Duration = 5,
    })
end

notify("Tower Heroes Script загружен!")

-- Основные настройки
_G.Enabled = true
_G.AutoFarm = true
_G.AutoSkip = true
_G.AutoVote = true
_G.AutoPlace = false
_G.TowerName = "Basic"  -- Basic, Fire, Ice, Archer, Mage, Knight и т.д.

-- Auto Vote + Auto Skip
spawn(function()
    while _G.Enabled do
        wait(1)
        if _G.AutoVote then
            -- Авто-голосование за начало
            local voteRemote = ReplicatedStorage:FindFirstChild("VoteStart", true) or ReplicatedStorage:FindFirstChild("StartVote")
            if voteRemote then voteRemote:FireServer() end
        end
        
        if _G.AutoSkip then
            local skipRemote = ReplicatedStorage:FindFirstChild("SkipWave", true) or ReplicatedStorage:FindFirstChild("Skip")
            if skipRemote then skipRemote:FireServer() end
        end
    end
end)

-- Auto Farm (Реджоин + фарм)
spawn(function()
    while _G.AutoFarm do
        wait(8)
        -- Если матч закончился — реджоин
        if Workspace:FindFirstChild("Victory") or Workspace:FindFirstChild("Defeat") or game:GetService("Lighting"):FindFirstChild("Intermission") then
            notify("Матч окончен → Реджоин для фарма...")
            wait(2)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end
end)

-- Auto Place Towers
spawn(function()
    while _G.AutoPlace do
        wait(1.5)
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local placeRemote = ReplicatedStorage:FindFirstChild("PlaceTower", true) 
                               or ReplicatedStorage:FindFirstChild("PlaceUnit", true)
            if placeRemote then
                local pos = character.HumanoidRootPart.Position + Vector3.new(math.random(-12,12), 0, math.random(-12,12))
                placeRemote:FireServer(_G.TowerName, pos)
            end
        end
    end
end)

-- Простое меню команд (пиши в чат)
LocalPlayer.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg == "/farm on" then 
        _G.AutoFarm = true 
        notify("Auto Farm ВКЛ")
    elseif msg == "/farm off" then 
        _G.AutoFarm = false 
        notify("Auto Farm ВЫКЛ")
    elseif msg == "/place on" then 
        _G.AutoPlace = true 
        notify("Auto Place ВКЛ")
    elseif msg == "/place off" then 
        _G.AutoPlace = false 
        notify("Auto Place ВЫКЛ")
    elseif msg:find("/tower ") then
        _G.TowerName = msg:gsub("/tower ", "")
        notify("Башня выбрана: " .. _G.TowerName)
    elseif msg == "/help" then
        notify("Команды: /farm on|off | /place on|off | /tower [имя]")
    end
end)

notify("Команды: /farm on | /place on | /tower Basic")
notify("Удачного фарма в Tower Heroes!")
