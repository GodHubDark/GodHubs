local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
if not Fluent then return end  -- Garante que Fluent foi carregado

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not game:IsLoaded() then
    game.Loaded:Wait()  -- Aguarda o jogo carregar
end

local PlaceId = game.PlaceId
local ProductInfo = MarketplaceService:GetProductInfo(PlaceId)
local GameName = ProductInfo.Name

Fluent:Notify({ Title = "Script executado com sucesso", Content = "Você está usando GodHub" })

local Window = Fluent:CreateWindow({
    Title = "GodHub",
    SubTitle = "-- " .. GameName,
    TabWidth = 102,
    Size = UDim2.fromOffset(450, 320),
    Acrylic = false,
    Theme = "dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "sword" }),
    AutoRaid = Window:AddTab({ Title = "Auto Raid", Icon = "skull" }),
    Creditos = Window:AddTab({ Title = "Créditos", Icon = "heart" })
}

local autoEnergy = false
local autoRank = false
local autoRaid = false
local autoMap = false
local autoStartRaid = false
local selectedDifficulty = false
local selectedMap = "Coastline"  -- Apenas "Coastline" disponível
local autoTrickUpgrade = false

-- Função segura para enviar eventos ao servidor
local function fireEvent(args)
    local success, err = pcall(function()
        ReplicatedStorage.RemoteEvent:FireServer(unpack(args))
    end)
    if not success then warn("Erro ao enviar evento:", err) end
end

-- Função para criar loops seguros (sem delay)
local function createFastLoop(conditionVar, func, delay)
    task.spawn(function()
        while _G[conditionVar] do
            func()
            task.wait(delay)  -- Executa com o delay especificado
        end
    end)
end

-- Auto Energy
Tabs.AutoFarm:AddToggle("Auto Energy", {
    Title = "Auto Energy",
    Default = false
}):OnChanged(function(Value)
    _G.autoEnergy = Value
    if Value then
        createFastLoop("autoEnergy", function()
            fireEvent({
                { { "\3", "Click", "Execute" } }
            })
        end, 0.01)  -- Delay de 0.01 segundo
    end
end)

-- Auto Rank
Tabs.AutoFarm:AddToggle("Auto Rank", {
    Title = "Auto Rank",
    Default = false
}):OnChanged(function(Value)
    _G.autoRank = Value
    if Value then
        createFastLoop("autoRank", function()
            fireEvent({
                { { "\3", "Rank", "Upgrade" } }
            })
        end)
    end
end)

-- Auto Trick Upgrade (Sem delay)
Tabs.AutoFarm:AddToggle("Auto Trick Upgrade", {
    Title = "Auto Trick Upgrade",
    Default = false
}):OnChanged(function(Value)
    _G.autoTrickUpgrade = Value
    if Value then
        createFastLoop("autoTrickUpgrade", function()
            fireEvent({
                { { "\3", "Trick", "Upgrade" } }
            })
        end)
    end
end)

-- Auto Raid
Tabs.AutoRaid:AddToggle("Auto Raid", {
    Title = "Auto Raid",
    Default = false
}):OnChanged(function(Value)
    _G.autoRaid = Value
    if Value then
        createFastLoop("autoRaid", function()
            fireEvent({
                { { "\3", "Raid", "Create" } }
            })
        end)
    end
end)

-- Auto Start Raid
Tabs.AutoRaid:AddToggle("Auto Start Raid", {
    Title = "Auto Start Raid",
    Default = false
}):OnChanged(function(Value)
    _G.autoStartRaid = Value
    if Value then
        createFastLoop("autoStartRaid", function()
            fireEvent({
                { { "\3", "Raid", "Start" } }
            })
        end)
    end
end)

-- Auto Map (Fixado em "Coastline")
Tabs.AutoRaid:AddToggle("Auto Map", {
    Title = "Selecionar Mapa",
    Default = false
}):OnChanged(function(Value)
    _G.autoMap = Value
    if Value then
        createFastLoop("autoMap", function()
            fireEvent({
                { { "\3", "Raid", "SelectMap", "Coastline" } }
            })
        end)
    end
end)

-- Seleção de Dificuldade
Tabs.AutoRaid:AddDropdown({
    Title = "Selecionar Dificuldade",
    Default = selectedDifficulty,
    Options = { "Easy", "Medium", "Hard", "Insane", "Extreme", "Impossible" },
    MultiSelect = false
}):OnChanged(function(Value)
    selectedDifficulty = Value
    Fluent:Notify({ Title = "Dificuldade Atualizada", Content = "Dificuldade definida para " .. selectedDifficulty })
end)

-- Créditos
Tabs.Creditos:AddParagraph({
    Title = "Criado por GodHub",
    Content = "Aproveite o script! Desenvolvido por GodHub para facilitar seu jogo."
})
Tabs.Creditos:AddParagraph({
    Title = "Apoio",
    Content = "Agradecimentos a Fluent por fornecer a interface visual incrível!"
})
Tabs.Creditos:AddParagraph({
    Title = "Agradecimento Especial",
    Content = "Agradeço ao Mender Hub pelo apoio contínuo e colaboração!"
})
