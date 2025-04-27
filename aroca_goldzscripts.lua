local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "GoldzScripts",
    SubTitle = "Sistema de Votação A ROÇA",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Principal", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Configurações", Icon = "settings" }),
    Votacao = Window:AddTab({ Title = "A ROÇA VOTAÇÃO", Icon = "vote" })
}

local selectedPlayer = "Player1"
local votingActive = false

Tabs.Votacao:AddParagraph({
    Title = "Escolha o jogador para votação",
    Content = "Selecione um jogador para votar e ative o script."
})

local Dropdown = Tabs.Votacao:AddDropdown("PlayerSelection", {
    Title = "Escolher Jogador",
    Values = {"Player1", "Player2", "Player3", "Player4"},
    Default = 1,
    Multi = false,
})

Dropdown:OnChanged(function(Value)
    selectedPlayer = Value
    print("Jogador selecionado:", selectedPlayer)
end)

local function startVoting()
    votingActive = true
    print("Votação iniciada. Jogador escolhido:", selectedPlayer)

    Fluent:Notify({
        Title = "GoldzScripts - Votação Ativada",
        Content = "A votação foi iniciada para o jogador " .. selectedPlayer,
        Duration = 5
    })

    while votingActive do
        local args = {
            [1] = game:GetService("ReplicatedStorage").Game.Roca[selectedPlayer]
        }
        game:GetService("ReplicatedStorage").Events.EliminatePlayer:FireServer(unpack(args))
        
        wait(0.5)
    end
end

local function stopVoting()
    votingActive = false
    print("Votação desativada.")

    Fluent:Notify({
        Title = "GoldzScripts - Votação Desativada",
        Content = "A votação foi desativada.",
        Duration = 5
    })
end

Tabs.Votacao:AddButton({
    Title = "Ativar Votação",
    Description = "Inicia o processo de votação.",
    Callback = function()
        if not votingActive then
            startVoting()
        else
            print("A votação já está ativa.")
        end
    end
})

Tabs.Votacao:AddButton({
    Title = "Desativar Votação",
    Description = "Finaliza a votação.",
    Callback = function()
        if votingActive then
            stopVoting()
        else
            print("A votação já está desativada.")
        end
    end
})

Fluent:Notify({
    Title = "GoldzScripts",
    Content = "O painel foi carregado com sucesso.",
    Duration = 5
})

Fluent:Notify({
    Title = "GoldzScripts",
    Content = "Se inscreva no canal! YT: GoldzScripts",
    Duration = 5
})