local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Window Setup
local Window = Rayfield:CreateWindow({
    Name = "By Mark",
    LoadingTitle = "Mark Script",
    LoadingSubtitle = "Muscle Legends",
    ConfigurationSaving = { Enabled = false }
})

-- Tabs
local TabFarm = Window:CreateTab("Farming", 4483362458)
local TabPacks = Window:CreateTab("Packs Farm", 4483362458)
local TabMisc = Window:CreateTab("Misc", 4483362458)

-- Stats Display
local strengthLabel = TabFarm:CreateLabel("Strength: Loading...")
local rebirthLabel = TabFarm:CreateLabel("Rebirths: Loading...")
task.spawn(function()
    while task.wait(1) do
        local stats = LocalPlayer:FindFirstChild("leaderstats")
        if stats then
            local strength = stats:FindFirstChild("Strength") and stats.Strength.Value or "?"
            local rebirths = stats:FindFirstChild("Rebirths") and stats.Rebirths.Value or "?"
            strengthLabel:Set("Strength: "..tostring(strength))
            rebirthLabel:Set("Rebirths: "..tostring(rebirths))
        end
    end
end)

-- Auto Rep
local repSpeed = 0.2
local autoRepToggle = false
TabFarm:CreateSlider({
    Name = "Rep Speed", Range = {0.05, 1}, Increment = 0.05, Suffix = "s", CurrentValue = 0.2,
    Flag = "RepSpeed", Callback = function(val) repSpeed = val end
})
TabFarm:CreateToggle({
    Name = "Auto Rep (Fast)", CurrentValue = false, Flag = "AutoRep",
    Callback = function(state)
        autoRepToggle = state
        task.spawn(function()
            while autoRepToggle do
                if LocalPlayer:FindFirstChild("muscleEvent") then
                    LocalPlayer.muscleEvent:FireServer("rep")
                end
                task.wait(repSpeed)
            end
        end)
    end,
})

-- Auto Punch
local autoPunchToggle = false
TabFarm:CreateToggle({
    Name = "Auto Punch", CurrentValue = false, Flag = "AutoPunch",
    Callback = function(state)
        autoPunchToggle = state
        task.spawn(function()
            while autoPunchToggle do
                local char = LocalPlayer.Character
                if char then
                    local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
                    if punch then
                        punch.Parent = char
                        punch:Activate()
                    end
                end
                task.wait(0.3)
            end
        end)
    end,
})

-- Auto Training Tools
local tools = {"Weight", "Situps", "Pushups", "Handstand"}
for _, toolName in ipairs(tools) do
    local toggleVar = false
    TabFarm:CreateToggle({
        Name = "Auto "..toolName, CurrentValue = false, Flag = "Auto"..toolName,
        Callback = function(state)
            toggleVar = state
            task.spawn(function()
                while toggleVar do
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(toolName)
                    if tool then tool:Activate() end
                    task.wait(0.2)
                end
            end)
        end,
    })
end

-- Auto Rebirth
local autoRebToggle = false
TabPacks:CreateToggle({
    Name = "Auto Fast Rebirth", CurrentValue = false, Flag = "AutoReb",
    Callback = function(state)
        autoRebToggle = state
        task.spawn(function()
            while autoRebToggle do
                local stats = LocalPlayer:FindFirstChild("leaderstats")
                if stats and stats:FindFirstChild("Strength") then
                    local rebEvent = ReplicatedStorage:FindFirstChild("rebirthEvent")
                    if rebEvent then rebEvent:FireServer() end
                    local equip = ReplicatedStorage:FindFirstChild("equipPetEvent")
                    if equip then
                        for i = 1,7 do equip:FireServer("Tribal Overlord") end
                    end
                end
                task.wait(2)
            end
        end)
    end,
})

-- Auto Protein Eggs
local autoEgg30, autoEgg60 = false, false
local function autoEatEgg(interval, toggleVar)
    task.spawn(function()
        while toggleVar do
            local tool = LocalPlayer.Backpack:FindFirstChild("Protein Egg")
            if tool then
                tool.Parent = LocalPlayer.Character
                task.wait(0.1)
                tool:Activate()
            end
            task.wait(interval)
        end
    end)
end

TabMisc:CreateToggle({
    Name = "Auto Eat Egg (30m)", CurrentValue = false,
    Callback = function(state)
        autoEgg30 = state
        if state then autoEatEgg(1800, autoEgg30) end
    end,
})
TabMisc:CreateToggle({
    Name = "Auto Eat Egg (1h)", CurrentValue = false,
    Callback = function(state)
        autoEgg60 = state
        if state then autoEatEgg(3600, autoEgg60) end
    end,
})
