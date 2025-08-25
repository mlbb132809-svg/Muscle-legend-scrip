-- autosystem.lua
-- Safe system for your OWN game (not an exploit!)
-- GUI + Toggles for Auto Punch, Auto Rep, Auto Rebirth, Auto Kill

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
