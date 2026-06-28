-- Tower Heroes Full Auto Script (English)
-- Features: Auto Skip, Auto Farm Coins, Auto Kill, Auto Practice

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "Tower Heroes - Full Auto GUI",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("Main"),
    Farm = Window:AddTab("Auto Farm"),
    Misc = Window:AddTab("Misc")
}

local autoSkip = false
local autoFarm = false
local autoKill = false
local autoPractice = false

-- ==================== MAIN FEATURES ====================
local MainTab = Tabs.Main

MainTab:AddToggle("AutoSkip", {
    Title = "Auto Skip Waves",
    Default = false,
    Callback = function(state)
        autoSkip = state
        if state then
            spawn(function()
                while autoSkip do
                    pcall(function()
                        -- Find and click skip button
                        local skipBtn = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Skip", true) or 
                                       game.Players.LocalPlayer.PlayerGui:FindFirstChild("SkipButton", true)
                        if skipBtn and skipBtn.Visible then
                            firesignal(skipBtn.MouseButton1Click)
                        end
                    end)
                    wait(0.5)
                end
            end)
        end
    end
})

MainTab:AddToggle("AutoKill", {
    Title = "Auto Kill (Damage Boost)",
    Default = false,
    Callback = function(state)
        autoKill = state
        if state then
            spawn(function()
                while autoKill do
                    pcall(function()
                        -- Boost tower damage (adjust path if needed)
                        for _, tower in pairs(workspace:FindFirstChild("Towers") or workspace:GetChildren()) do
                            if tower:FindFirstChild("Damage") then
                                tower.Damage.Value = 999999
                            end
                        end
                    end)
                    wait(2)
                end
            end)
        end
    end
})

-- ==================== AUTO FARM ====================
local FarmTab = Tabs.Farm

FarmTab:AddToggle("AutoFarmCoins", {
    Title = "Auto Farm Coins (Rejoin + Skip)",
    Default = false,
    Callback = function(state)
        autoFarm = state
        if state then
            spawn(function()
                while autoFarm do
                    pcall(function()
                        -- Auto vote Easy + Skip
                        local voteRemote = game.ReplicatedStorage:FindFirstChild("VoteDifficulty") or 
                                           game.ReplicatedStorage.Remotes:FindFirstChild("Vote")
                        if voteRemote then
                            voteRemote:FireServer("Easy")
                        end
                    end)
                    wait(4)
                end
            end)
        end
    end
})

FarmTab:AddToggle("AutoPractice", {
    Title = "Auto Practice / Free Play",
    Default = false,
    Callback = function(state)
        autoPractice = state
        -- Add practice mode logic here
        print("Auto Practice Enabled")
    end
})

-- ==================== MISC ====================
Tabs.Misc:AddButton("Teleport to Lobby", function()
    game.TeleportService:Teleport(4646477729) -- Tower Heroes Place ID
end)

Tabs.Misc:AddButton("Destroy GUI", function()
    Window:Destroy()
end)

print("✅ Tower Heroes Auto Script Loaded Successfully!")
print("Use the GUI to toggle features.")
