-- [[ SAKZZ HUB - INFINITE MONEY SCRIPT ]] --
-- This script automatically checks for leaderstats and runs a money loop.

local moneyPerSecond = 100
local interval = 1
local player = game.Players.LocalPlayer

-- Ensure the script is running on the Client side (LocalPlayer only exists on Client)
if not player then 
    warn("Error: This script must be executed via an Executor or LocalScript.")
    return 
end

-- Setup Function: Checks for leaderstats folder and Money value
local function getMoneyValue()
    local ls = player:FindFirstChild("leaderstats")
    if not ls then
        -- If the map doesn't have leaderstats, this creates it (Client-side visual)
        ls = Instance.new("Folder")
        ls.Name = "leaderstats"
        ls.Parent = player
    end

    local money = ls:FindFirstChild("Money")
    if not money then
        money = Instance.new("IntValue")
        money.Name = "Money"
        money.Value = 0
        money.Parent = ls
    end
    return money
end

local moneyValue = getMoneyValue()

-- Main Loop
task.spawn(function()
    print("SAKZZ HUB: Money Script Active! Adding " .. moneyPerSecond .. " every " .. interval .. " seconds.")
    while task.wait(interval) do
        if player and player.Parent then
            moneyValue.Value += moneyPerSecond
        else
            -- Stops the loop if the player leaves the game
            break
        end
    end
end)
