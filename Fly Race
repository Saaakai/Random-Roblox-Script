-- Library

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("Fly Race Script")

local b = w:CreateFolder("Main")
local c = w:CreateFolder("Info")

-- Variables

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local launchPart = game:GetService("Workspace"):WaitForChild("Launch")

-- Functions

local function GetBestPart()
	local land = {} do
		for i,v in pairs(game.Workspace.LandSpots:GetChildren()) do
			if v:IsA("Part") and v.Name ~= "End" then
				table.insert(land, v)
				v.Name = #land
			end
		end
	end
	return table.maxn(land)
end
local bestpart = game:GetService("Workspace").LandSpots[GetBestPart()]

local function AutoCraft()
    for i,v in pairs(lp.Pets:GetDescendants()) do
        if v:IsA("NumberValue") and v.Name == "PetID" then
            local args = {[1] = "CraftAll",[2] = {["PetID"] = v.Value}}
            game:GetService("ReplicatedStorage").RemoteEvents.PetActionRequest:InvokeServer(unpack(args))
        end  
    end
end

local function click(a)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,true,a,1)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,false,a,1)
end

-- Tables

local Eggs = {} do
    for i,v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
        table.insert(Eggs, v.Name)
    end
end

-- Toggles
warn("Ty for using my script bro <3 !")

local delay = nil
b:Slider("Delay Auto Race",{
    min = 1.10; -- min value of the slider
    max = 5; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    delay = value
end)

b:Toggle("Auto Race",function(bool)
    getgenv().FinishRace = bool
    
    task.spawn(function()
        while task.wait() do
            if FinishRace then
                game:GetService("ReplicatedStorage").Sounds.Launch.Volume = 0
                pcall(function()
                    local char = lp.Character
                    local hum = char.Humanoid
                    local hrp = char.HumanoidRootPart
    
                    firetouchinterest(launchPart, hrp, 0)
                    firetouchinterest(launchPart, hrp, 1)
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 1000, 0)
                    
                    task.wait(tonumber(delay))
                    
                    hrp.CFrame = bestpart.CFrame + Vector3.new(0, 100, 0)
                    hum.Health = 0
                end)
            end
        end
    end)
end)

b:Toggle("Auto Rebirth",function(bool)
    getgenv().AutoRebirth = bool
    
    task.spawn(function()
        while AutoRebirth and task.wait() do
            if lp.PlayerGui.Main.SideTabs.Big.Rebirths.Main.Unchecked.Visible then
                click(lp.PlayerGui.Main.SideTabs.Big.Rebirths)
			    task.wait(.5)
			    click(lp.PlayerGui.Rebirths.Main.Bottom.Confirm)
		    end
        end
    end)
end)

b:Toggle("Auto Orb",function(bool)
    getgenv().CollectOrb = bool
    
    task.spawn(function()
        while CollectOrb and task.wait() do
            pcall(function()
                for i,v in pairs(game.Workspace.Camera:GetChildren()) do
                    if v:IsA("Part") and v.Orb.Item.Image ~= "rbxassetid://11411247929" then
                        local hrp = lp.Character.HumanoidRootPart
                        v.Transparency = 1
                        v.CanCollide = false
                        hrp.CFrame = v.CFrame + Vector3.new(0, 5, 0)
                        task.wait(.1)
                    end
                end
            end)
        end
    end)
end)

b:Label("===========",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
}) 

local choosed_egg
b:Dropdown("Choose Egg",{unpack(Eggs)},true,function(egg) --true/false, replaces the current title "Dropdown" with the option that t
    choosed_egg = egg
end)

b:Toggle("Auto Hatch",function(bool)
    getgenv().AutoHatch = bool
    
    task.spawn(function()
        while AutoHatch and task.wait() do
            pcall(function()
                if choosed_egg ~= nil then
                    if FinishRace then
                        lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Eggs[choosed_egg].UIanchor.CFrame + Vector3.new(0, 0, 5)
                        local args = {[1] = tostring(choosed_egg),[2] = "Single"}
                        game:GetService("ReplicatedStorage").RemoteEvents.EggOpened:InvokeServer(unpack(args))
                    else
                        lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Eggs[choosed_egg].UIanchor.CFrame + Vector3.new(0, 0, 5)
                        local args = {[1] = tostring(choosed_egg),[2] = "Single"}
                        game:GetService("ReplicatedStorage").RemoteEvents.EggOpened:InvokeServer(unpack(args))
                        task.wait(3)
                    end
                else
                    warn("Please, choose your egg ):")
                end
            end)
        end
    end)
end)

b:Toggle("Auto Craft",function(bool)
    getgenv().AutoCraft = bool
    
    task.spawn(function()
        while AutoCraft and task.wait() do
           AutoCraft()
           task.wait(5)  
        end
    end)
end)

c:Label("UI : Wally UI V3",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
})

c:Label("Any Problems? SQK#9773",{
    TextSize = 15; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
})
