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
