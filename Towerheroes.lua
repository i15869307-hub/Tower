-- Tower Heroes | Super Small Window

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local lp = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "TH Auto",
    Size = UDim2.new(0, 320, 0, 380),   -- Очень маленькое окно
    Center = true,
    AutoShow = true,
})

Window:MakeDraggable(true)

local Tabs = {
    Main = Window:AddTab("Main"),
    Farm = Window:AddTab("Farm"),
    Misc = Window:AddTab("Misc")
}

local autoSkip = false
local autoFarm = false
local autoKill = false

Tabs.Main:AddToggle("AutoSkip", {Title = "Auto Skip", Default = false, Callback = function(s) 
    autoSkip = s 
    if s then spawn(function()
        while autoSkip do pcall(function()
            local skip = lp.PlayerGui:FindFirstChild("SkipButton", true) or lp.PlayerGui:FindFirstChild("Skip", true)
            if skip and skip.Visible then firesignal(skip.MouseButton1Click) end
        end) wait(0.3) end)
    end
end})

Tabs.Main:AddToggle("AutoKill", {Title = "Auto Kill", Default = false, Callback = function(s) 
    autoKill = s 
    if s then spawn(function()
        while autoKill do pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name:find("Damage") or v.Name == "Dmg" then v.Value = 9999999 end
            end
        end) wait(1) end)
    end
end})

Tabs.Farm:AddToggle("AutoFarm", {Title = "Auto Farm Coins", Default = false, Callback = function(s) 
    autoFarm = s 
    if s then spawn(function()
        while autoFarm do pcall(function()
            local vote = ReplicatedStorage:FindFirstChild("Vote") or ReplicatedStorage.Remotes:FindFirstChild("VoteDifficulty")
            if vote then vote:FireServer("Easy") end
        end) wait(3) end)
    end
end})

Tabs.Farm:AddButton("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, lp)
end})

Tabs.Misc:AddButton("Lobby", function()
    TeleportService:Teleport(4646477729)
end)

Tabs.Misc:AddButton("Close", function()
    Window:Destroy()
end)

print("✅ Super small window loaded!")
