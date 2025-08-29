-- Elerium v2 UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library/main/Library"))()

-- Create Main Window
local window = library:AddWindow("MARKPRIVATESCRIPT", {
    main_color = Color3.fromRGB(0, 0, 255),
    min_size = Vector2.new(557, 680),
    can_resize = true,
})

-- Tabs
local mainTab = window:AddTab("Main")
local farmTab = window:AddTab("Farm")
local settingsTab = window:AddTab("Settings")
mainTab:Show() -- Show this tab by default

-- References
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()

-- Helper Functions
local function unequipAllPets()
    local petFolder = player:FindFirstChild("petsFolder")
    if petFolder then
        for _, h in pairs(petFolder:GetChildren()) do
            if h:IsA("Folder") then
                for _, j in pairs(h:GetChildren()) do
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", j)
                end
            end
        end
    end
    task.wait(0.1)
end

local function equipPet(name)
    for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
        if pet.Name == name then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

-- Farm Tab: Fast Rebirth (Swift → Tribal)
farmTab:AddSwitch("⚡ Rebirth with Pack", function(state)
    local autoRebirth = state
    task.spawn(function()
        while autoRebirth do
            local rebirths = player.leaderstats.Rebirths.Value
            local requiredStrength = 10000 + (5000 * rebirths)

            local goldenRebirth = player.ultimatesFolder:FindFirstChild("Golden Rebirth")
            if goldenRebirth then
                requiredStrength = math.floor(requiredStrength * (1 - goldenRebirth.Value * 0.1))
            end

            -- Equip Swift Samurai and farm strength
            unequipAllPets()
            equipPet("Swift Samurai")
            repeat
                for _ = 1, 10 do
                    player.muscleEvent:FireServer("rep")
                end
                task.wait(0.1)
            until player.leaderstats.Strength.Value >= requiredStrength

            -- Equip Tribal Overlord
            unequipAllPets()
            equipPet("Tribal Overlord")
            task.wait(0.1) -- ensure equip registers

            -- Perform Rebirth
            local beforeRebirth = player.leaderstats.Rebirths.Value
            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            until player.leaderstats.Rebirths.Value > beforeRebirth

            task.wait()
        end
    end)
end)
-- Section for Auto Eat Egg
Tabs.Main:AddSection("Auto Eat Egg")

local autoEatEggToggle = Tabs.Main:CreateToggle("AutoEatEgg", {
    Title = "Auto Eat Protein Egg",
    Default = false
})

autoEatEggToggle:OnChanged(function(state)
    local player = game.Players.LocalPlayer
    local proteinEggName = "Protein Egg" -- keep or change as needed

    while state and autoEatEggToggle.Value do
        local tool = player.Backpack:FindFirstChild(proteinEggName)
        if tool then
            tool.Parent = player.Character
            task.wait(0.1)
            tool:Activate()
            task.wait(1800) -- 30 minutes
        else
            task.wait(10) -- retry after 10 sec
        end
    end
end)
Tabs.Main:AddSection("Auto Fast Farm")

local autoPunchToggle = Tabs.Main:AddToggle("AutoPunchWithAnim", {
    Title = "Auto Fast Punch",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            while state and autoPunchToggle.Value do
                local player = game.Players.LocalPlayer
                local char = game.Workspace:FindFirstChild(player.Name)
                local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

                if punchTool then
                    if punchTool.Parent ~= char then
                        punchTool.Parent = char -- Equip
                        task.wait(0.1) -- small delay to ensure it's equipped
                    end

                    local attackTime = punchTool:FindFirstChild("attackTime")
                    if attackTime then
                        attackTime.Value = 0
                    end

                    punchTool:Activate()
                else
                    warn("Punch tool not found")
                    autoPunchToggle:SetValue(false)
                end

                task.wait()
            end
        end)
    end
})

local fastWeightToggle = Tabs.Main:AddToggle("FastWeight", {
    Title = "Auto Fast Weight",
    Default = false,
    Callback = function(state)
        task.spawn(function()
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
    end
})

local fastPushupToggle = Tabs.Main:AddToggle("FastPushups", {
    Title = "Auto Fast Pushups",
    Default = false,
    Callback = function(state)
        task.spawn(function()
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
    end
})

local fastSitupToggle = Tabs.Main:AddToggle("FastSitups", {
    Title = "Auto Fast Situps",
    Default = false,
    Callback = function(state)
        task.spawn(function()
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
    end
})

local fastHandstandToggle = Tabs.Main:AddToggle("FastHandstands", {
    Title = "Auto Fast Handstands",
    Default = false,
    Callback = function(state)
        task.spawn(function()
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
    end
})
