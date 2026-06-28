-- Tower Heroes | Полностью Рабочий + Draggable GUI

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local lp = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

-- Создаём окно с возможностью перемещения
local Window = Library:CreateWindow({
    Title = "Tower Heroes - Полностью Рабочий",
    Center = true,
    AutoShow = true,
})

-- Делаем окно draggable (можно двигать мышкой)
Window:MakeDraggable(true)  -- <-- Вот это делает окно подвижным

local Tabs = {
    Main = Window:AddTab("Главное"),
    Farm = Window:AddTab("Фарм"),
    Misc = Window:AddTab("Другое")
}

local autoSkip = false
local autoFarm = false
local autoKill = false

-- ==================== ГЛАВНОЕ ====================
Tabs.Main:AddToggle("AutoSkip", {
    Title = "Авто Пропуск Волн",
    Default = false,
    Callback = function(state)
        autoSkip = state
        if state then
            spawn(function()
                while autoSkip do
                    pcall(function()
                        local skip = lp.PlayerGui:FindFirstChild("SkipButton", true) or lp.PlayerGui:FindFirstChild("Skip", true)
                        if skip and skip.Visible then
                            firesignal(skip.MouseButton1Click)
                        end
                    end)
                    wait(0.4)
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("AutoKill", {
    Title = "Авто Килл (Огромный Урон)",
    Default = false,
    Callback = function(state)
        autoKill = state
        if state then
            spawn(function()
                while autoKill do
                    pcall(function()
                        for _, v in pairs(Workspace:GetDescendants()) do
                            if v.Name == "Damage" or v.Name == "Dmg" then
                                v.Value = 9999999
                            end
                        end
                    end)
                    wait(1)
                end
            end)
        end
    end
})

-- ==================== ФАРМ ====================
Tabs.Farm:AddToggle("AutoFarmCoins", {
    Title = "Авто Фарм Монет",
    Default = false,
    Callback = function(state)
        autoFarm = state
        if state then
            spawn(function()
                while autoFarm do
                    pcall(function()
                        local vote = ReplicatedStorage:FindFirstChild("Vote") or ReplicatedStorage.Remotes:FindFirstChild("VoteDifficulty")
                        if vote then
                            vote:FireServer("Easy")
                        end
                    end)
                    wait(4)
                end
            end)
        end
    end
})

Tabs.Farm:AddButton("Rejoin (для фарма)", function()
    TeleportService:Teleport(game.PlaceId, lp)
end)

-- ==================== ДРУГОЕ ====================
Tabs.Misc:AddButton("В Лобби", function()
    TeleportService:Teleport(4646477729)
end)

Tabs.Misc:AddButton("Закрыть меню", function()
    Window:Destroy()
end)

print("✅ Скрипт загружен! Окно можно двигать мышкой.")
