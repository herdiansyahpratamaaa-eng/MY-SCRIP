-- ============================================================
-- SAKZZ DUELS - PREMIUM EDITION (ALL BLACK UI)
-- Ultra-Modern UI with Glassmorphism & Animations
-- ============================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ===== SAKZZ VARIABLES =====
local NORMAL_SPEED = 60
local CARRY_SPEED = 30
local speedToggled = false
local autoBatToggled = false
local autoBatKey = Enum.KeyCode.E
local speedToggleKey = Enum.KeyCode.Q

-- Auto-Play Sakzz
local AutoLeftEnabled = false
local AutoRightEnabled = false
local autoLeftKey = Enum.KeyCode.Z
local autoRightKey = Enum.KeyCode.C

-- Sakzz Configuration Table
local SakzzSettings = {
    STEAL_RADIUS = 20,
    STEAL_DURATION = 1.3,
    DEFAULT_GRAVITY = 196.2,
    GalaxyGravityPercent = 70,
    HOP_POWER = 35,
    HOP_COOLDOWN = 0.08
}

local Enabled = {
    AntiRagdoll = false,
    AutoSteal = false,
    Galaxy = false,
    ShinyGraphics = false,
    Optimizer = false,
    Unwalk = false,
}

-- Discord Sakzz Progress
local DISCORD_TEXT = "https://discord.gg/sakzz-exclusive"

local function getSakzzProgress(percent)
    local totalChars = #DISCORD_TEXT
    local adjustedPercent = math.min(percent * 1.5, 100)
    local charsToShow = math.floor((adjustedPercent / 100) * totalChars)
    return string.sub(DISCORD_TEXT, 1, charsToShow)
end

-- ===== CORE FUNCTIONS =====

local function GetSakzzHRP()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Anti Ragdoll Sakzz Style
local function startAntiRagdoll()
    RunService.Heartbeat:Connect(function()
        if not Enabled.AntiRagdoll then return end
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hum and (hum:GetState() == Enum.HumanoidStateType.Ragdoll or hum:GetState() == Enum.HumanoidStateType.Physics) then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

-- [[ TAMPILAN CONSOLE ]] --
print([[ 
  ____        _                 
 / ___|  __ _| | __  _ ________ 
 \___ \ / _` | |/ / |_|_  /_  / 
  ___) | (_| |   <  | |/ / / /  
 |____/ \__,_|_|\_\ |_/___/___| 
    PREMIUM EDITION LOADED
]])

print("Sakzz Duels: System is active.")
