-- Library ( Kavo Library )

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Rarity Factory Tycoon", "GrapeTheme")
local Tab = Window:NewTab("Main")
local Tab2 = Window:NewTab("Information")
local Section = Tab:NewSection("Auto Farm")
local Section1 = Tab:NewSection("Auto Obby")
local Section2 = Tab2:NewSection("v")
-- Variables

local Players = game:GetService("Players")

local lp = Players.LocalPlayer
local char = lp.Character
local hrp = char.HumanoidRootPart

local montycoon

-- Functions

function MonTycoon()
   for i,v in pairs(game:GetService("Workspace").Tycoons:GetDescendants()) do
	   if v:IsA("StringValue") and v.Value == lp.Name then
		    montycoon = v.Parent.Name
	    end
    end
end
MonTycoon()

function CollectDrops()
   for i,v in pairs(game:GetService("Workspace").Tycoons[montycoon].Drops:GetChildren()) do
	   if v:IsA("Part") then
		   v.Transparency = 1
		   v.CanCollide = false
		   v.CFrame = hrp.CFrame
	    end
    end
end

function SellDrops()
    firetouchinterest(game:GetService("Workspace").Tycoons[montycoon]["Orb Processor"].Model.Deposit.Button, hrp, 0)
	firetouchinterest(game:GetService("Workspace").Tycoons[montycoon]["Orb Processor"].Model.Deposit.Button, hrp, 1)
end

function BuyButtons()
   for i,v in pairs(game:GetService("Workspace").Tycoons[montycoon].Buttons:GetDescendants()) do
	   if v:IsA("UnionOperation") then
		    firetouchinterest(v.Parent.Button, hrp, 0)
			firetouchinterest(v.Parent.Button, hrp, 1)
	    end
    end
end

function AutoFinishObby()
	firetouchinterest(game:GetService("Workspace").obby["2x Cash for 1 Minute"].Button, hrp, 0)
	firetouchinterest(game:GetService("Workspace").obby["2x Cash for 1 Minute"].Button, hrp, 1)
end

function AutoRebirth()
	firetouchinterest(game:GetService("Workspace").Tycoons[montycoon].Rebirth.Button, hrp, 0)
	firetouchinterest(game:GetService("Workspace").Tycoons[montycoon].Rebirth.Button, hrp, 1)
end

-- Main

Section:NewToggle("Auto Collect ON/OFF", "Auto Collect Drops", function(state)
    if state then
		getgenv().AutoCollect = true

        while AutoCollect and task.wait() do
			CollectDrops()
		end
    else
        getgenv().AutoCollect = false
    end
end)

Section:NewToggle("Auto Sell ON/OFF", "Auto Sell Drops", function(state)
    if state then
		getgenv().AutoSell = true

        while AutoSell and task.wait() do
			SellDrops()
		end
    else
        getgenv().AutoSell = false
    end
end)

Section:NewToggle("Auto Buy Buttons ON/OFF", "Auto Buy Buttons", function(state)
    if state then
		getgenv().AutoBuyButtons = true

        while AutoBuyButtons and task.wait(.5) do
			BuyButtons()
		end
    else
        getgenv().AutoBuyButtons = false
    end
end)

Section:NewToggle("Auto Rebirth ON/OFF", "Auto Rebirth", function(state)
    if state then
		getgenv().AutoRebirth = true

        while AutoRebirth and task.wait(2) do
			AutoRebirth()
		end
    else
        getgenv().AutoRebirth = false
    end
end)

Section1:NewToggle("Auto Obby Finisher ON/OFF", "Auto Obby Finisher ( x2 Cash for 1min )", function(state)
    if state then
		getgenv().AutoObby = true

        while AutoObby and task.wait(1) do
			AutoFinishObby()
		end
    else
        getgenv().AutoObby = false
    end
end)

Section2:NewLabel("The Script is Open Source")
Section2:NewLabel("If you've seen any errors or bad things")
Section2:NewLabel("Then please, contact me : SQK#9773")