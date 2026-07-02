-- LocalScript (StarterPlayerScripts ішіне қойыңыз)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local walkspeed = 1000  -- Бастауыш жылдамдық

humanoid.WalkSpeed = walkspeed

print("WalkSpeed басқару: + (ұлғайту) | - (кішірейту) | Қазір: " .. walkspeed)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.Plus or input.KeyCode == Enum.KeyCode.KeypadPlus then
        walkspeed = walkspeed + 100  -- 100-ге ұлғайту
        humanoid.WalkSpeed = walkspeed
        print("🚀 WalkSpeed: " .. walkspeed)
        
    elseif input.KeyCode == Enum.KeyCode.Minus or input.KeyCode == Enum.KeyCode.KeypadMinus then
        walkspeed = walkspeed - 100  -- 100-ге азайту
        if walkspeed < 16 then walkspeed = 16 end  -- Қалыпты жылдамдықтан төмен түспесін
        humanoid.WalkSpeed = walkspeed
        print("🐢 WalkSpeed: " .. walkspeed)
    end
end)
