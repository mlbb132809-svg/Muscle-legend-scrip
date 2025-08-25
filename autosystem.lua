--// GUI Loader
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- Buttons
local AutoRep = Instance.new("TextButton")
local AutoReb = Instance.new("TextButton")
local AutoPunch = Instance.new("TextButton")
local AutoKill = Instance.new("TextButton")

-- Parent GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame design
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Size = UDim2.new(0, 200, 0, 240)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)

-- Title
Title.Parent = Frame
Title.Text = "⚡ AutoSystem Hub"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- Button template function
local function makeButton(button, text, posY)
    button.Parent = Frame
    button.Text = text
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
end

-- Create Buttons
makeButton(AutoRep, "Auto Rep (OFF)", 40)
makeButton(AutoReb, "Auto Rebirth (OFF)", 80)
makeButton(AutoPunch, "Auto Punch (OFF)", 120)
makeButton(AutoKill, "Auto Kill (OFF)", 160)

--// Features (toggle logic)
local autoRep = false
local autoReb = false
local autoPunch = false
local autoKill = false

-- Auto Rep Loop
task.spawn(function()
    while true do
        task.wait(0.2)
        if autoRep then
            game:GetService("ReplicatedStorage").Events.Train:FireServer("Rep")
        end
    end
end)

-- Auto Rebirth Loop
task.spawn(function()
    while true do
        task.wait(1)
        if autoReb then
            game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
        end
    end
end)

-- Auto Punch Loop
task.spawn(function()
    while true do
        task.wait(0.15)
        if autoPunch then
            game:GetService("ReplicatedStorage").Events.Punch:FireServer()
        end
    end
end)

-- Auto Kill Loop
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoKill then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    -- Example attack (replace with your own remote)
                    game:GetService("ReplicatedStorage").Events.Attack:FireServer(player)
                end
            end
        end
    end
end)

-- Button Clicks
AutoRep.MouseButton1Click:Connect(function()
    autoRep = not autoRep
    AutoRep.Text = "Auto Rep (".. (autoRep and "ON" or "OFF") ..")"
end)

AutoReb.MouseButton1Click:Connect(function()
    autoReb = not autoReb
    AutoReb.Text = "Auto Rebirth (".. (autoReb and "ON" or "OFF") ..")"
end)

AutoPunch.MouseButton1Click:Connect(function()
    autoPunch = not autoPunch
    AutoPunch.Text = "Auto Punch (".. (autoPunch and "ON" or "OFF") ..")"
end)

AutoKill.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    AutoKill.Text = "Auto Kill (".. (autoKill and "ON" or "OFF") ..")"
end)

print("✅ AutoSystem Hub Loaded!")
--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

--// Remote references (change names to match your game!)
local PunchRemote = ReplicatedStorage:WaitForChild("PunchEvent")
local RepRemote   = ReplicatedStorage:WaitForChild("RepEvent")
local RebirthRemote = ReplicatedStorage:WaitForChild("RebirthEvent")

--// Toggles
local toggles = {
    AutoPunch = false,
    AutoRep = false,
    AutoRebirth = false,
    AutoKill = false
}

--// GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoSystemUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local function makeButton(name, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.Position = pos
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = screenGui
    btn.MouseButton1Click:Connect(function()
        toggles[name] = not toggles[name]
        btn.Text = name .. ": " .. (toggles[name] and "ON" or "OFF")
        callback(toggles[name])
    end)
end

--// Toggle Buttons
makeButton("AutoPunch", UDim2.new(0,20,0,20), function() end)
makeButton("AutoRep", UDim2.new(0,20,0,70), function() end)
makeButton("AutoRebirth", UDim2.new(0,20,0,120), function() end)
makeButton("AutoKill", UDim2.new(0,20,0,170), function() end)

--// Loops
task.spawn(function()
    while true do
        task.wait(0.2)
        if toggles.AutoPunch then
            PunchRemote:FireServer()
        end
        if toggles.AutoRep then
            RepRemote:FireServer()
        end
        if toggles.AutoRebirth then
            RebirthRemote:FireServer()
        end
        if toggles.AutoKill then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player then
                        local tChar = target.Character
                        if tChar and tChar:FindFirstChild("HumanoidRootPart") and tChar:FindFirstChild("Humanoid") then
                            local dist = (tChar.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist <= 15 then -- within 15 studs
                                tChar.Humanoid:TakeDamage(5)
                            end
                        end
                    end
                end
            end
        end
    end
end)
