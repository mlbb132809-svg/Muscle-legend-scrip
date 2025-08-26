
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window
local Window = Rayfield:CreateWindow({
	Name = "MARK PRIVATE SCRIPT",
	LoadingTitle = "PRIVATE SCRIPT",
	LoadingSubtitle = "MARK PRIBATE SCRIPT",
	ConfigurationSaving = {
		Enabled = false,
	}
})

-- Create UI Tab
local Tab = Window:CreateTab("Main", 4483362458)

Tabs.Main:AddSection("Auto Farm")

local Toggle = Tabs.Main:CreateToggle("AutoRep", {Title = "Auto Lift", Default = false})
Toggle:OnChanged(function(State)
    if State then
        task.spawn(function()
            while Toggle.Value do
                game:GetService("Players").LocalPlayer:WaitForChild("muscleEvent"):FireServer("rep")
                task.wait(0.1)
            end
        end)
    end
end)

local Toggle = Tabs.Main:CreateToggle("AutoNormalPunch", {
    Title = "Auto Normal Punch",
    Default = false
})

Toggle:OnChanged(function(state)
    while state and Toggle.Value do
        local player = game.Players.LocalPlayer
        local char = game.Workspace:FindFirstChild(player.Name)
        local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

        if punchTool then
            if punchTool.Parent ~= char then
                punchTool.Parent = char -- Equip
                task.wait(0.1)
            end

            -- Set normal attack delay
            local attackTime = punchTool:FindFirstChild("attackTime")
            if attackTime then
                attackTime.Value = 0.35
            end

            -- Simulate tool activation (plays animation)
            punchTool:Activate()
        else
            warn("Punch tool not found")
            Toggle:SetValue(false)
        end

        task.wait()
    end
end)

local autoWeightToggle = Tabs.Main:CreateToggle("AutoWeight", {Title = "Auto Weight", Default = false})
autoWeightToggle:OnChanged(function(state)
    if state then
        task.spawn(function()
            while autoWeightToggle.Value do
                local tool = game.Players.LocalPlayer.Character:FindFirstChild("Weight")
                if tool and tool:IsA("Tool") then
                    tool:Activate()
                end
                task.wait(0.2)
            end
        end)
    end
end)

local autoPushupToggle = Tabs.Main:CreateToggle("AutoPushups", {Title = "Auto Pushups", Default = false})
autoPushupToggle:OnChanged(function(state)
    if state then
        task.spawn(function()
            while autoPushupToggle.Value do
                local tool = game.Players.LocalPlayer.Character:FindFirstChild("Pushups")
                if tool and tool:IsA("Tool") then
                    tool:Activate()
                end
                task.wait(0.2)
            end
        end)
    end
end)

local autoSitupToggle = Tabs.Main:CreateToggle("AutoSitups", {Title = "Auto Situps", Default = false})
autoSitupToggle:OnChanged(function(state)
    if state then
        task.spawn(function()
            while autoSitupToggle.Value do
                local tool = game.Players.LocalPlayer.Character:FindFirstChild("Situps")
                if tool and tool:IsA("Tool") then
                    tool:Activate()
                end
                task.wait(0.2)
            end
        end)
    end
end)

local autoHandstandToggle = Tabs.Main:CreateToggle("AutoHandstands", {Title = "Auto Handstands", Default = false})
autoHandstandToggle:OnChanged(function(state)
    if state then
        task.spawn(function()
            while autoHandstandToggle.Value do
                local tool = game.Players.LocalPlayer.Character:FindFirstChild("Handstand")
                if tool and tool:IsA("Tool") then
                    tool:Activate()
                end
                task.wait(0.2)
            end
        end)
    end
end)

Tabs.Main:AddSection("Auto Fast Farm")

local Toggle = Tabs.Main:CreateToggle("AutoPunchWithAnim", {
    Title = "Auto Fast Punch",
    Default = false
})

Toggle:OnChanged(function(state)
    while state and Toggle.Value do
        local player = game.Players.LocalPlayer
        local char = game.Workspace:FindFirstChild(player.Name)
        local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

        if punchTool then
            if punchTool.Parent ~= char then
                punchTool.Parent = char -- Equip
                task.wait(0.1) -- small delay to ensure it's equipped
            end

            -- Fast punch tweak
            local attackTime = punchTool:FindFirstChild("attackTime")
            if attackTime then
                attackTime.Value = 0
            end

            -- Simulate tool activation (triggers animation + event)
            punchTool:Activate()
        else
            warn("Punch tool not found")
            Toggle:SetValue(false)
        end

        task.wait()
    end
end)

local fastWeightToggle = Tabs.Main:CreateToggle("FastWeight", {Title = "Auto Fast Weight", Default = false})

fastWeightToggle:OnChanged(function(state)
    while state and fastWeightToggle.Value do
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = player.Backpack:FindFirstChild("Weight") or (char and char:FindFirstChild("Weight"))

        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
                task.wait(0.1)
            end

            local workoutTime = tool:FindFirstChild("workoutTime")
            if workoutTime then
                workoutTime.Value = 0
            end

            tool:Activate()
        end

        task.wait()
    end
end)

local fastPushupToggle = Tabs.Main:CreateToggle("FastPushups", {Title = "Auto Fast Pushups", Default = false})

fastPushupToggle:OnChanged(function(state)
    while state and fastPushupToggle.Value do
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = player.Backpack:FindFirstChild("Pushups") or (char and char:FindFirstChild("Pushups"))

        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
                task.wait(0.1)
            end

            local pushupTime = tool:FindFirstChild("pushupTime")
            if pushupTime then
                pushupTime.Value = 0
            end

            tool:Activate()
        end

        task.wait()
    end
end)

local fastSitupToggle = Tabs.Main:CreateToggle("FastSitups", {Title = "Auto Fast Situps", Default = false})

fastSitupToggle:OnChanged(function(state)
    while state and fastSitupToggle.Value do
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = player.Backpack:FindFirstChild("Situps") or (char and char:FindFirstChild("Situps"))

        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
                task.wait(0.1)
            end

            local situpTime = tool:FindFirstChild("situpTime")
            if situpTime then
                situpTime.Value = 0
            end

            tool:Activate()
        end

        task.wait()
    end
end)

local fastHandstandToggle = Tabs.Main:CreateToggle("FastHandstands", {Title = "Auto Fast Handstands", Default = false})

fastHandstandToggle:OnChanged(function(state)
    while state and fastHandstandToggle.Value do
        local player = game.Players.LocalPlayer
        local char = player.Character
        local tool = player.Backpack:FindFirstChild("Handstand") or (char and char:FindFirstChild("Handstand"))

        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
                task.wait(0.1)
            end

            local handstandTime = tool:FindFirstChild("handstandTime")
            if handstandTime then
                handstandTime.Value = 0
            end

            tool:Activate()
        end

        task.wait()
    end
end)
