-- Script Name: SAKZZ_HUB_REELABRAINROTS
local tool = script.Parent
local pullSpeed = 50 -- Increased pull force

tool.Activated:Connect(function()
    local character = tool.Parent
    -- Ensure the character exists
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end

    -- Loop through Workspace to find objects named "Brainrot"
    for _, target in pairs(workspace:GetChildren()) do
        -- Check if the object is a BasePart and named correctly
        if target.Name == "Brainrot" and target:IsA("BasePart") then
            local distance = (target.Position - head.Position).Magnitude

            -- Check if the target is within 25 studs
            if distance < 25 then
                -- Calculate direction towards the character's head
                local direction = (head.Position - target.Position).Unit
                
                -- Apply velocity
                target.Velocity = direction * pullSpeed
                
                print("SAKZZ_HUB: Successfully pulled " .. target.Name)
            end
        end
    end
end)
