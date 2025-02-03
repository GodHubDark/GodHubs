local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))() local MarketplaceService = game:GetService("MarketplaceService") local PlaceId = game.PlaceId local ProductInfo = MarketplaceService:GetProductInfo(PlaceId) local GameName = ProductInfo.Name

Fluent:Notify({ Title = "Script executado com sucesso", Content = "VocÃª estÃ¡ usando GodHub" })

local Window = Fluent:CreateWindow({ Title = "GodHub",  -- Alterado para GodHub SubTitle = "-- " .. GameName, TabWidth = 102, Size = UDim2.fromOffset(450, 320), Acrylic = false, Theme = "dark", MinimizeKey = Enum.KeyCode.LeftControl })

local Tabs = { AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "sword" }), Creditos = Window:AddTab({ Title = "CrÃ©ditos", Icon = "heart" }) }

local autoEnergy = false local autoRank = false local autoTrickUpgrade = false  -- VariÃ¡vel para controlar o "Trick Upgrade"

-- Toggle Auto Energy Tabs.AutoFarm:AddToggle("Auto Energy", { Title = "Auto Energy", Default = false }):OnChanged(function(Value) autoEnergy = Value if autoEnergy then task.spawn(function() while autoEnergy do local args = { [1] = { [1] = { [1] = "\3", [2] = "Click", [3] = "Execute" } } } game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args)) wait(0.01)  -- Atraso de 0.01 para clique mais rápido end end) end end)

-- Toggle Auto Rank Tabs.AutoFarm:AddToggle("Auto Rank", { Title = "Auto Rank", Default = false }):OnChanged(function(Value) autoRank = Value if autoRank then task.spawn(function() while autoRank do local args = { [1] = { [1] = { [1] = "\3", [2] = "Rank", [3] = "Upgrade" } } } game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args)) wait(1) end end) end end)

-- Toggle Auto Trick Upgrade Tabs.AutoFarm:AddToggle("Auto Trick Upgrade", { Title = "Auto Trick Upgrade", Default = false }):OnChanged(function(Value) autoTrickUpgrade = Value if autoTrickUpgrade then task.spawn(function() while autoTrickUpgrade do local args = { [1] = { [1] = { [1] = "\3", [2] = "Trick", [3] = "Upgrade" } } } game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args)) wait(1)  -- Ajuste o tempo conforme necessário end end) end end)

-- CrÃ©ditos Tabs.Creditos:AddParagraph({ Title = "Criado por GodHub",  -- Alterado para GodHub Content = "Aproveite o script! Desenvolvido por GodHub para facilitar seu jogo." }) Tabs.Creditos:AddParagraph({ Title = "Apoio", Content = "Agradecimentos a Fluent por fornecer a interface visual incrÃ­vel!" })

