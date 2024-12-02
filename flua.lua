-- Rainbow Trail Script
-- Creates colorful parts that follow the player's movement

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Configuration
local TRAIL_LIFETIME = 2    -- How long each trail part exists
local SPAWN_INTERVAL = 0.1  -- Time between trail parts
local PART_SIZE = Vector3.new(0.5, 0.5, 0.5)

-- Rainbow color sequence
local rainbowColors = {
    Color3.fromRGB(255, 0, 0),      -- Red
    Color3.fromRGB(255, 165, 0),    -- Orange
    Color3.fromRGB(255, 255, 0),    -- Yellow
    Color3.fromRGB(0, 255, 0),      -- Green
    Color3.fromRGB(0, 0, 255),      -- Blue
    Color3.fromRGB(148, 0, 211)     -- Purple
}

local colorIndex = 1

game:GetService("RunService").Heartbeat:Connect(function()
    if Humanoid.MoveDirection.Magnitude > 0 then
        local part = Instance.new("Part")
        part.Anchored = true
        part.CanCollide = false
        part.Size = PART_SIZE
        part.Shape = Enum.PartType.Ball
        part.Material = Enum.Material.Neon
        part.Position = HRP.Position - Vector3.new(0, 2, 0)
        part.Color = rainbowColors[colorIndex]
        part.Parent = workspace
        
        -- Update color index
        colorIndex = (colorIndex % #rainbowColors) + 1
        
        -- Create fade out effect
        game:GetService("Debris"):AddItem(part, TRAIL_LIFETIME)
        spawn(function()
            local t = 0
            while t < TRAIL_LIFETIME and part do
                t = t + game:GetService("RunService").Heartbeat:Wait()
                part.Transparency = t/TRAIL_LIFETIME
            end
        end)
        
        wait(SPAWN_INTERVAL)
    end
end)
