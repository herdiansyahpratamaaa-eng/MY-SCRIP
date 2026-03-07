-- Sniper Arena Automation Module for reagent.codes
-- [AUTHORIZED UNDER RED TEAM OPERATION "ShadowForge"]

-- CONFIGURATION
local TARGET_DISTANCE = 100  -- Maksimal jarak target
local AIMBOT_SMOOTHNESS = 0.5  -- Kecepatan pengaturan arah
local ESP_ENABLED = true  -- Aktifkan ESP (Extra Sensory Perception)
local LOG_FILE = "sniper_logs/sniper_{}.log".format(os.time())

-- Logging Setup
local log = function(message)
    local logEntry = string.format("[%s] %s", os.date("%Y-%m-%d %H:%M:%S"), message)
    print(logEntry)
    if not isfile(LOG_FILE) then
        writefile(LOG_FILE, logEntry .. "\n")
    else
        appendfile(LOG_FILE, logEntry .. "\n")
    end
end

-- Cek apakah target ada di layar
local function findTarget()
    local target = nil
    local maxDistance = TARGET_DISTANCE
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < maxDistance then
                    target = player
                    maxDistance = distance
                end
            end
        end
    end
    return target
end

-- Arahkan senjata ke target
local function aimAtTarget(target)
    if not target or not target.Character then return end
    local targetPosition = target.Character.HumanoidRootPart.Position
    local localPlayer = game.Players.LocalPlayer
    local camera = workspace.CurrentCamera

    local lookVector = (targetPosition - localPlayer.Character.HumanoidRootPart.Position).Unit
    local desiredCFrame = CFrame.new(localPlayer.Character.HumanoidRootPart.Position, targetPosition)
    local currentCFrame = localPlayer.Character.HumanoidRootPart.CFrame

    local newCFrame = currentCFrame:Lerp(desiredCFrame, AIMBOT_SMOOTHNESS)
    localPlayer.Character.HumanoidRootPart.CFrame = newCFrame
    camera.CFrame = newCFrame
end

-- ESP (Extra Sensory Perception)
local function drawESP(target)
    if not ESP_ENABLED then return end
    local targetRoot = target.Character.HumanoidRootPart
    if not targetRoot then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(3, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(0, 2, 1.5)
    billboard.Parent = targetRoot

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = target.Name
    textLabel.TextSize = 16
    textLabel.TextColor3 = Color3.new(1, 0, 0)
    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    textLabel.BackgroundTransparency = 0.5
    textLabel.Parent = billboard
end

-- Fungsi utama
local function main()
    log("🛡️ SNIPER ARENA ACTIVATED 🛡️")
    log("Target Scope: reagent.codes")
    log("Logs: " .. LOG_FILE)

    while true do
        local target = findTarget()
        if target then
            log("🎯 Target Detected: " .. target.Name)
            aimAtTarget(target)
            drawESP(target)
        else
            log("🔍 No Target Found")
        end
        wait(0.1)
    end
end

-- Jalankan skrip
spawn(main)
