-- // MARK PRIVATE SCRIPT🔥 PREMIUM VERSION // --

-----------------------------------------
-- SERVICES & VARIABLES
-----------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "MARK PRIVATE SCRIPT🔥",
    LoadingTitle = "Loading Premium...",
    LoadingSubtitle = "Muscle Legends Edition",
    ConfigurationSaving = { Enabled = false }
})

-----------------------------------------
-- TABS
-----------------------------------------
local TabFarm = Window:CreateTab("Farming", 4483362458)
local TabTeleport = Window:CreateTab("Teleports", 4483362458)
local TabMods = Window:CreateTab("Player Mods", 4483362458)
local TabCombat = Window:CreateTab("Combat", 4483362458)
local TabMisc = Window:CreateTab("Misc", 4483362458)
local TabCredits = Window:CreateTab("Credits", 4483362458)

-----------------------------------------
-- FARMING SECTION
-----------------------------------------
-- Labels
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

-- Auto Farm Strength
local autoRepToggle, repSpeed = false, 0.2
TabFarm:CreateToggle({
    Name="Auto Farm Strength",
    CurrentValue=false,
    Callback=function(state)
        autoRepToggle = state
        task.spawn(function()
            while autoRepToggle do
                local char = LocalPlayer.Character
                if char then
                    for _, toolName in ipairs({"Weight","Situps","Pushups","Handstand"}) do
                        local tool = char:FindFirstChild(toolName) or LocalPlayer.Backpack:FindFirstChild(toolName)
                        if tool then tool:Activate() end
                    end
                end
                task.wait(repSpeed)
            end
        end)
    end
})
TabFarm:CreateSlider({
    Name="Fast Rep",
    Range={0.05,1},
    Increment=0.05,
    Suffix="s",
    CurrentValue=0.2,
    Callback=function(val) repSpeed = val end
})

-- Auto Punch
local autoPunchToggle, punchSpeed = false, 0.3
TabFarm:CreateToggle({
    Name="Auto Punch",
    CurrentValue=false,
    Callback=function(state)
        autoPunchToggle = state
        task.spawn(function()
            while autoPunchToggle do
                local char = LocalPlayer.Character
                if char then
                    local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
                    if punch then punch.Parent = char; punch:Activate() end
                end
                task.wait(punchSpeed)
            end
        end)
    end
})
TabFarm:CreateSlider({
    Name="Fast Punch",
    Range={0.05,1},
    Increment=0.05,
    Suffix="s",
    CurrentValue=0.3,
    Callback=function(val) punchSpeed = val end
})

-- Fast Grinding
local fastGrindToggle = false
TabFarm:CreateToggle({
    Name = "Fast Grinding",
    CurrentValue = false,
    Callback = function(state)
        fastGrindToggle = state
        if fastGrindToggle then
            for i = 1, 12 do
                task.spawn(function()
                    while fastGrindToggle do
                        local muscleEvent = ReplicatedStorage:FindFirstChild("muscleEvent")
                        if muscleEvent then
                            muscleEvent:FireServer("rep")
                        end
                        task.wait(0.083)
                    end
                end)
            end
        end
    end
})

-- Auto Rebirth (Normal)
local autoRebToggle = false
TabFarm:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(state)
        autoRebToggle = state
        task.spawn(function()
            while autoRebToggle do
                local rebEvent = ReplicatedStorage:FindFirstChild("rebirthRequest")
                if rebEvent then
                    rebEvent:FireServer()
                end
                task.wait(2)
            end
        end)
    end
})

-- Fast Rebirth (Swift Samurai + Tribal Overlord)
local fastRebirthToggle = false
TabFarm:CreateToggle({
    Name = "Fast Rebirth",
    CurrentValue = false,
    Callback = function(state)
        fastRebirthToggle = state
        task.spawn(function()
            while fastRebirthToggle do
                local stats = LocalPlayer:FindFirstChild("leaderstats")
                local strength = stats and stats:FindFirstChild("Strength") and stats.Strength.Value
                local rebEvent = ReplicatedStorage:FindFirstChild("rebirthRequest")
                local confirmEvent = ReplicatedStorage:FindFirstChild("confirmRebirthEvent")
                local rebReq = ReplicatedStorage:FindFirstChild("RebirthRequirement")
                local required = rebReq and rebReq.Value or 1000
                local equipPackEvent = ReplicatedStorage:FindFirstChild("equipPackEvent")
                local maxEquip = (LocalPlayer:FindFirstChild("Premium") and LocalPlayer.Premium.Value) and 8 or 7

                local function getPets(name)
                    local pets = {}
                    for _, item in ipairs(Character:GetChildren()) do
                        if item.Name:find(name) then
                            table.insert(pets, item.Name)
                            if #pets >= maxEquip then break end
                        end
                    end
                    return pets
                end

                local samuraiPets = getPets("Swift Samurai Pack")
                local overlordPets = getPets("Tribal Overlord Pack")

                if strength and rebEvent and equipPackEvent then
                    if strength < required then
                        for _, pet in ipairs(samuraiPets) do
                            equipPackEvent:FireServer(pet)
                        end
                    else
                        for _, pet in ipairs(overlordPets) do
                            equipPackEvent:FireServer(pet)
                        end
                        rebEvent:FireServer()
                        if confirmEvent then
                            confirmEvent:FireServer(true)
                        end
                    end
                end

                task.wait(fastRebirthToggle and 0.1 or 2)
            end
        end)
    end
})

-----------------------------------------
-- TELEPORT SECTION
-----------------------------------------
local Teleports = {
    ["Tiny Island"]=CFrame.new(-450,15,320),
    ["Main Island"]=CFrame.new(20,15,30),
    ["Legend Beach"]=CFrame.new(180,15,-600),
    ["Frost Gym"]=CFrame.new(-1100,15,250),
    ["Mythical Gym"]=CFrame.new(500,15,1300),
    ["Eternal Gym"]=CFrame.new(1250,15,-450),
    ["Legends Gym"]=CFrame.new(800,15,-900),
    ["Muscle King Gym"]=CFrame.new(1500,15,500),
    ["Jungle Gym"]=CFrame.new(-1300,15,-850)
}
for name,cf in pairs(Teleports) do
    TabTeleport:CreateButton({Name=name, Callback=function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = cf
        end
    end})
end

-----------------------------------------
-- PLAYER MODS SECTION
-----------------------------------------
TabMods:CreateToggle({Name="NAN Size", CurrentValue=false})
TabMods:CreateToggle({Name="Disable Animations", CurrentValue=false})
TabMods:CreateButton({Name="Lock Position"})
TabMods:CreateButton({Name="Reset Character", Callback=function() Character:BreakJoints() end})
TabMods:CreateToggle({Name="Hide Pets", CurrentValue=false})
TabMods:CreateToggle({Name="Hide Frames", CurrentValue=false})

-----------------------------------------
-- COMBAT SECTION
-----------------------------------------
TabCombat:CreateToggle({Name="Auto Good Karma", CurrentValue=false})
TabCombat:CreateToggle({Name="Auto Bad Karma", CurrentValue=false})

local currentSpectate=nil
local dropdown = TabCombat:CreateDropdown({
    Name="Spectate Player",
    Options={},
    MultiSelect=false,
    CurrentOption={},
    Callback=function(option)
        currentSpectate=option
        local player = Players:FindFirstChild(option)
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        end
    end
})
TabCombat:CreateButton({Name="Stop Spectating", Callback=function()
    if Character and Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = Character.Humanoid
        currentSpectate=nil
    end
end})

-- Update player list every 5 seconds
task.spawn(function()
    while task.wait(5) do
        local names={}
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=LocalPlayer then table.insert(names,plr.Name) end
        end
        Rayfield:ReloadDropdown(dropdown,names)
    end
end)

-----------------------------------------
-- MISC SECTION
-----------------------------------------
local function autoEatEgg(interval)
    task.spawn(function()
        while true do
            local tool = LocalPlayer.Backpack:FindFirstChild("Protein Egg")
            if tool then
                tool.Parent=Character
                task.wait(0.1)
                tool:Activate()
            end
            task.wait(interval)
        end
    end)
end
TabMisc:CreateToggle({Name="Auto Eat Egg (30m)", CurrentValue=false, Callback=function(state)
    if state then autoEatEgg(1800) end
end})
TabMisc:CreateToggle({Name="Auto Eat Egg (1h)", CurrentValue=false, Callback=function(state)
    if state then autoEatEgg(3600) end
end})

TabMisc:CreateButton({Name="Equip Best Packs", Callback=function()
    local equipPackEvent = ReplicatedStorage:FindFirstChild("equipPackEvent")
    if equipPackEvent then
        for _, pack in pairs({"Pack1","Pack2","Pack3"}) do
            equipPackEvent:FireServer(pack)
        end
    end
end})

-----------------------------------------
-- CREDITS SECTION
-----------------------------------------
TabCredits:CreateLabel("SCRIPT BY MARK🔥")
TabCredits:CreateLabel("Special Thanks: You 😉")
TabCredits:CreateLabel("Styled with centered text & gradient")
