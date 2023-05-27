-- Library

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Anime Tales | Private Script 🔒", "Midnight")
local Tab = Window:NewTab("Farm Section")
local Tab2 = Window:NewTab("Boss Section")

local Section = Tab:NewSection("Farm Section")
local Section2 = Tab2:NewSection("Boss Section")

-- Variables

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local choosed_zone
local island_zone
local choosed_weapon
local sword_priority = false

local restart_loop

local boss_started
local choosed_boss

local QueueButton = game:GetService("Players").LocalPlayer.PlayerGui.UI.Bosses.Panel.Buttons:FindFirstChild("QueueButton")
local LeaveButton = game:GetService("Players").LocalPlayer.PlayerGui.UI.Bosses.Panel.Buttons:FindFirstChild("LeaveQueueButton")

-- Tables

local Islands = {

    ["MarineHQ"] =  {
        CFrame.new(1936.42102, 573.109619, 3186.48706, 0.909923017, 0, 0.41477716, 0, 1, 0, -0.41477716, 0, 0.909923017),
        CFrame.new(2459.24609, 43.6221733, 2609.94678, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(1508.02612, 43.6380196, 2615.28979, 0.990270376, 0, 0.13915664, 0, 1, 0, -0.13915664, 0, 0.990270376),
        CFrame.new(1965.17358, 147.508926, 3600.01123, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    },

    ["CakeIsland"] = {
        CFrame.new(6227.14648, 37.3825264, -3689.07764, -0.999848366, 0, 0.017436387, 0, 1, 0, -0.017436387, 0, -0.999848366),
        CFrame.new(5613.23438, 46.6879959, -3164.61597, -1, 0, 0, 0, 1, 0, 0, 0, -1),
        CFrame.new(6363.45117, 47.3237953, -2883.91089, -1, 0, 0, 0, 1, 0, 0, 0, -1),
        CFrame.new(5638.49219, 44.7926407, -2508.17163, -0.957837582, 0, -0.287310094, 0, 1, 0, 0.287310094, 0, -0.957837582),
    },

    ["SamuraiIsland"] = {
        CFrame.new(-1417.4231, 88.5365677, -3078.03491, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(-2403.34277, 43.5614204, -3185.95898, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(-2326.12891, 377.432251, -4417.16846, 0.901107192, 0, 0.433596432, 0, 1, 0, -0.433596432, 0, 0.901107192),
        CFrame.new(-3470.31079, 44.9839668, -3492.8418, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(-1872.8916, 33.5365677, -1825.3103, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    },
}

local Zones = {}
for i,v in pairs(game:GetService("Workspace").WorldObjects.TrainingZones:GetChildren()) do
	if v:IsA("Model") then
		table.insert(Zones, v.Name)
	end
end
table.sort(Zones)

local Boss = {"Ta maman", "Ton père"}

-- Functions

local function FindIsland(zone)
    if tostring(zone):match("Island 1") then
        return "MarineHQ"
    elseif tostring(zone):match("Island 2") then
        return "CakeIsland"
    elseif tostring(zone):match("Island 3") then
        return "SamuraiIsland"
    end
end

local function ClickMouse()
    local args = {[1] = "mouse1Pressed"}
     game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CombatCommunication"):FireServer(unpack(args))    
end

local function click(a)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,true,a,1)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,false,a,1)
end

local function ChangeWeapon(weapon)
    local args = {[1] = "setSelectedTrainingStat",[2] = weapon}
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayerCommunication"):FireServer(unpack(args))
end

local function JoinQueue()
    if QueueButton.Visible then
        return true
    end
    return false
end


-- Main

Section:NewDropdown("Choisi la zone à farmer", "t'as besoin de savoir quoi?", {unpack(Zones)}, function(currentOption)
    choosed_zone = currentOption
    island_zone = FindIsland(currentOption)
    if tostring(currentOption):match("Energy") then
        choosed_weapon = "energy"
    elseif tostring(currentOption):match("Strength") then
        choosed_weapon = "strength"
    elseif tostring(currentOption):match("Defense") then
        choosed_weapon = "defense"
    end
    warn(choosed_weapon)
    warn(island_zone)
    warn(choosed_zone)
end)

Section:NewToggle("Start Farming 🌌", "jsp", function(state)
    if state then
        getgenv().AutoFarmZone = state

        task.spawn(function()
            while task.wait() do
                if AutoFarmZone and not boss_started then
                    if restart_loop then
                        task.wait(10)
                        restart_loop = false
                    end
                    
                    local char = lp.Character or lp.CharacterAdded:Wait()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")

                    if hrp and hum.Health > 0 then
                        
                        if choosed_weapon and choosed_zone and island_zone ~= nil then
                            
                            for island, v in pairs(Islands) do
                                if island == island_zone then
                                    repeat
                                        for k, cframes in pairs(Islands[tostring(island_zone)]) do
                                            hrp.CFrame = cframes
                                            task.wait(.1)
                                        end
                                    until game:GetService("Workspace").WorldObjects.TrainingZones[choosed_zone]:FindFirstChild("BoundingBox")
                                end
                            end

                            if game:GetService("Workspace").WorldObjects.TrainingZones[choosed_zone]:FindFirstChild("BoundingBox") then
                                hrp.CFrame = game:GetService("Workspace").WorldObjects.TrainingZones[choosed_zone]:FindFirstChild("BoundingBox").CFrame + Vector3.new(-10, 10, 0)
                            end

                            repeat
                                task.wait()
                                if not sword_priority then
                                    ChangeWeapon(choosed_weapon)
                                end

                                if choosed_weapon == "strength" then
                                    task.spawn(function()
                                        ClickMouse()
                                        task.wait(.75)
                                    end)
                                end
                            until boss_started or not AutoFarmZone
                        end
                    end
                end
            end
        end)
    else
        getgenv().AutoFarmZone = state
        choosed_weapon = nil
        ChangeWeapon("strength")
    end
end)

Section:NewToggle("Farm Sword ⚔️", "ToggleInfo", function(state)
    if state then
        getgenv().FarmSword = state
        task.spawn(function()
            while task.wait() do
                if FarmSword then
                    sword_priority = true
                    ChangeWeapon("weapon")
                    ClickMouse()
                end
            end
        end)
    else
        getgenv().FarmSword = state
        sword_priority = false
    end
end)

Section2:NewDropdown("Choisi tes parents 👪", "oui", {unpack(Boss)}, function(currentOption)
    choosed_boss = currentOption
end)


Section2:NewToggle("Auto Boss 💼", "ToggleInfo", function(state)
    if state then
        getgenv().AutoBoss = true

        task.spawn(function()
            while task.wait() do
                if AutoBoss then
                    if JoinQueue() and not LeaveButton.Visible then
                        if game:GetService("Players").LocalPlayer.PlayerGui.UI.Bosses.Visible then
                            click(QueueButton)
                            task.wait(1)
                            boss_started = true
                            if not sword_priority then
                                ChangeWeapon("strength")
                            end
                            game:GetService("Players").LocalPlayer.PlayerGui.UI.Bosses.Visible = false
                        else
                            game:GetService("Players").LocalPlayer.PlayerGui.UI.Bosses.Visible = true
                        end
                    end
                    
                    if game:GetService("Workspace").WorldObjects.Bosses:FindFirstChild("yourMama") then
                        local Boss = game:GetService("Workspace").WorldObjects.Bosses:FindFirstChild("yourMama")
                        if Boss and Boss:WaitForChild("Health") and Boss:WaitForChild("RootPart") then
                            if Boss.Health.Value > 0 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10616.5556640625, 73.52395629882812, -41907.953125)
                                if not sword_priority then
                                    ClickMouse()
                                end
                            else
                                boss_started = false
                                restart_loop = true
                            end
                        end
                    end
                end
            end
        end)
    else
        getgenv().AutoBoss = false
        boss_started = false
    end
end)
