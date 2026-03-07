--[[
    ZEKOTTOCI HUB - LOADSTRING VERSION
    Features: ESP, Tracers, Highlights
    Original by YT: Zekottoci
]]

local CREDIT = "By YT: Zekottoci"
if CREDIT ~= "By YT: Zekottoci" then return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Global Settings
getgenv().HubSettings = {
    ESP = true,
    Tracers = true,
    TeamCheck = true
}

local Objects = {ESPs = {}, Tracers = {}, Highlights = {}}

--// UI GENERATOR
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "Zek_Hub"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 180, 0, 160)
Main.Position = UDim2.new(0.1, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "ZEKOTTOCI HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

--// TOGGLE BUTTON FUNCTION
local function CreateToggle(text, pos, settingKey)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = pos
    btn.Text = text .. ": ON"
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        getgenv().HubSettings[settingKey] = not getgenv().HubSettings[settingKey]
        btn.Text = text .. (getgenv().HubSettings[settingKey] and ": ON" or ": OFF")
        btn.BackgroundColor3 = getgenv().HubSettings[settingKey] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end)
end

CreateToggle("ESP", UDim2.new(0.05, 0, 0.25, 0), "ESP")
CreateToggle("Tracers", UDim2.new(0.05, 0, 0.5, 0), "Tracers")

--// ESP LOGIC
local function addESP(p)
    if p == LocalPlayer then return end
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 100, 0, 20)
    bill.AlwaysOnTop = true
    local lab = Instance.new("TextLabel", bill)
    lab.Size = UDim2.new(1, 0, 1, 0)
    lab.BackgroundTransparency = 1
    lab.TextSize = 12
    
    local line = Drawing.new("Line")
    line.Thickness = 1
    
    Objects.ESPs[p] = bill
    Objects.Tracers[p] = line
end

RunService.RenderStepped:Connect(function()
    for p, v in pairs(Objects.ESPs) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and getgenv().HubSettings.ESP then
            v.Parent = p.Character:FindFirstChild("Head")
            local color = (p.Team == LocalPlayer.Team) and Color3.new(0,1,0) or Color3.new(1,0,0)
            v.TextLabel.Text = p.Name
            v.TextLabel.TextColor3 = color
            
            local pos, vis = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if vis and getgenv().HubSettings.Tracers then
                Objects.Tracers[p].Visible = true
                Objects.Tracers[p].From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                Objects.Tracers[p].To = Vector2.new(pos.X, pos.Y)
                Objects.Tracers[p].Color = color
            else
                Objects.Tracers[p].Visible = false
            end
        else
            v.Parent = nil
            Objects.Tracers[p].Visible = false
        end
    end
end)

for _, p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)
