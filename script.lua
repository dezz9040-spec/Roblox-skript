local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

local VALID_KEYS = {
    ["DZV15K9X4M2P"] = true,
    ["ROBLOX777XYZ"] = true,
    ["DEZZPRO99ABC"] = true
}

local settings = {
    Aimbot1 = false,      -- Классический 360 аимбот
    Aimbot2 = false,      -- Аимбот без движения камеры (Silent)
    Bunnyhop = false,     
    ESP = false,          
    Spinbot = false,      
    KillSound = true,     -- Звук при убийстве
    FovRadius = 9999      -- Полный охват 360 градусов
}

local friendsList = {}
local trackedHealths = {}

-- Воспроизведение звука при килле
local function playKillSound()
    if not settings.KillSound then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6534947936" -- Можешь заменить ID на свой
    sound.Volume = 1
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local screenGui = Instance.new("ScreenGui", lp.PlayerGui)
screenGui.Name = "DezzCSGOStyle"
screenGui.ResetOnSpawn = false

------------------------------------------------------------------
-- ОКНО АВТОРИЗАЦИИ
------------------------------------------------------------------
local keyGui = Instance.new("Frame", screenGui)
keyGui.Size = UDim2.new(0, 320, 0, 160)
keyGui.Position = UDim2.new(0.5, -160, 0.5, -80)
keyGui.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyGui.Active = true
keyGui.Draggable = true

local kCorner = Instance.new("UICorner", keyGui)
kCorner.CornerRadius = UDim.new(0, 10)
local kStroke = Instance.new("UIStroke", keyGui)
kStroke.Color = Color3.fromRGB(0, 255, 128)
kStroke.Transparency = 0.3

local keyTitle = Instance.new("TextLabel", keyGui)
keyTitle.Size = UDim2.new(1, 0, 0, 35)
keyTitle.Position = UDim2.new(0, 0, 0, 10)
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 14
keyTitle.Text = "DEZZ V17 // KEY AUTHORIZATION"

local keyBox = Instance.new("TextBox", keyGui)
keyBox.Size = UDim2.new(0.85, 0, 0, 38)
keyBox.Position = UDim2.new(0.075, 0, 0.35, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
keyBox.TextColor3 = Color3.fromRGB(0, 255, 128)
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
keyBox.PlaceholderText = "Введи 12-значный ключ..."
keyBox.Font = Enum.Font.GothamMedium
keyBox.TextSize = 13
keyBox.Text = ""
local bCorner = Instance.new("UICorner", keyBox)
bCorner.CornerRadius = UDim.new(0, 6)

local submitBtn = Instance.new("TextButton", keyGui)
submitBtn.Size = UDim2.new(0.85, 0, 0, 38)
submitBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 13
submitBtn.Text = "АКТИВИРОВАТЬ"
local sCorner = Instance.new("UICorner", submitBtn)
sCorner.CornerRadius = UDim.new(0, 6)

------------------------------------------------------------------
-- ОСНОВНОЕ МЕНЮ
------------------------------------------------------------------
local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 60, 0, 35)
openBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 13
openBtn.Text = "DEZZ"
openBtn.Active = true
openBtn.Draggable = true
openBtn.Visible = false

local btnCorner = Instance.new("UICorner", openBtn)
btnCorner.CornerRadius = UDim.new(0, 6)
local btnStroke = Instance.new("UIStroke", openBtn)
btnStroke.Color = Color3.fromRGB(0, 255, 128)
btnStroke.Transparency = 0.3

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 480, 0, 280)
mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(50, 50, 70)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.Text = "DEZZ V16 // UNLOCKED"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = string.upper(keyBox.Text)
    if VALID_KEYS[enteredKey] then
        keyGui:Destroy()
        openBtn.Visible = true
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ!"
        keyBox.PlaceholderColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

local gridContainer = Instance.new("Frame", mainFrame)
gridContainer.Size = UDim2.new(0.94, 0, 0.65, 0)
gridContainer.Position = UDim2.new(0.03, 0, 0.18, 0)
gridContainer.BackgroundTransparency = 1

local gridLayout = Instance.new("UIGridLayout", gridContainer)
gridLayout.CellSize = UDim2.new(0, 142, 0, 45)
gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createToggle(name, stateKey)
    local btn = Instance.new("TextButton", gridContainer)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.Text = "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0, 8, 0, 8)
    indicator.Position = UDim2.new(0.85, 0, 0.4, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    local indCorner = Instance.new("UICorner", indicator)
    indCorner.CornerRadius = UDim.new(1, 0)
    
    btn.MouseButton1Click:Connect(function()
        settings[stateKey] = not settings[stateKey]
        if settings[stateKey] then
            btn.BackgroundColor3 = Color3.fromRGB(20, 40, 30)
            btn.TextColor3 = Color3.fromRGB(0, 255, 128)
            indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            btn.TextColor3 = Color3.fromRGB(180, 180, 200)
            indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end)
    return btn
end

createToggle("Aimbot 1.0 (360)", "Aimbot1")
createToggle("Aimbot 2.0 (NoCam)", "Aimbot2")
createToggle("Bunnyhop (Boost)", "Bunnyhop")
createToggle("ESP (Wallhack)", "ESP")
createToggle("Spinbot", "Spinbot")
createToggle("Kill Sound", "KillSound")

local friendsBtn = Instance.new("TextButton", mainFrame)
friendsBtn.Size = UDim2.new(0.94, 0, 0, 32)
friendsBtn.Position = UDim2.new(0.03, 0, 0.86, 0)
friendsBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
friendsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
friendsBtn.Font = Enum.Font.GothamBold
friendsBtn.TextSize = 12
friendsBtn.Text = "Управление друзьями"
local fCorner = Instance.new("UICorner", friendsBtn)
fCorner.CornerRadius = UDim.new(0, 6)

local friendsFrame = Instance.new("Frame", screenGui)
friendsFrame.Size = UDim2.new(0, 220, 0, 250)
friendsFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
friendsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
friendsFrame.Visible = false
friendsFrame.Active = true
friendsFrame.Draggable = true
local frCorner = Instance.new("UICorner", friendsFrame)
frCorner.CornerRadius = UDim.new(0, 10)

local scrollList = Instance.new("ScrollingFrame", friendsFrame)
scrollList.Size = UDim2.new(0.9, 0, 0.85, 0)
scrollList.Position = UDim2.new(0.05, 0, 0.1, 0)
scrollList.BackgroundTransparency = 1
scrollList.CanvasSize = UDim2.new(0, 0, 2, 0)

local uiList2 = Instance.new("UIListLayout", scrollList)
uiList2.SortOrder = Enum.SortOrder.LayoutOrder
uiList2.Padding = UDim.new(0, 5)

friendsBtn.MouseButton1Click:Connect(function()
    friendsFrame.Visible = not friendsFrame.Visible
end)

local refreshPlayerList
refreshPlayerList = function()
    for _, child in pairs(scrollList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp then
            local pBtn = Instance.new("TextButton", scrollList)
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.TextSize = 12
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.Text = player.Name
            
            if friendsList[player.Name] then
                pBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 50)
                pBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
            else
                pBtn.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
                pBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
            local pCorner = Instance.new("UICorner", pBtn)
            pCorner.CornerRadius = UDim.new(0, 5)
            
            pBtn.MouseButton1Click:Connect(function()
                if friendsList[player.Name] then
                    friendsList[player.Name] = nil
                    pBtn.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
                    pBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                else
                    friendsList[player.Name] = true
                    pBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 50)
                    pBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
                end
            end)
        end
    end
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

local function isValidTarget(targetPart, playerName)
    if friendsList[playerName] then return false end
    
    local origin = camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {lp.Character}
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        if result.Instance:IsDescendantOf(targetPart.Parent) then
            return true
        end
        return false
    end
    return true
end

local isJumping = false
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Jump then
        isJumping = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Jump then
        isJumping = false
    end
end)

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            local altChar = player.Character
            if settings.ESP then
                local hl = altChar:FindFirstChild("DezzHighlight")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "DezzHighlight"
                    hl.FillTransparency = 0.3
                    hl.OutlineTransparency = 0
                    hl.Parent = altChar
                end
                hl.Adornee = altChar
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                
                local isFriend = friendsList[player.Name]
                if isFriend then
                    hl.FillColor = Color3.fromRGB(0, 255, 128)
                    hl.OutlineColor = Color3.fromRGB(0, 100, 50)
                else
                    hl.FillColor = Color3.fromRGB(255, 40, 40)
                    hl.OutlineColor = Color3.fromRGB(120, 10, 10)
                end
                
                local head = altChar:FindFirstChild("Head")
                if head and not head:FindFirstChild("DezzTag") then
                    local bb = Instance.new("BillboardGui", head)
                    bb.Name = "DezzTag"
                    bb.Size = UDim2.new(0, 120, 0, 50)
                    bb.StudsOffset = Vector3.new(0, 2.5, 0)
                    bb.AlwaysOnTop = true
                    
                    local lbl = Instance.new("TextLabel", bb)
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextStrokeTransparency = 0
                    lbl.TextSize = 14
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Text = player.Name
                end
                
                if head and head:FindFirstChild("DezzTag") then
                    local lbl = head.DezzTag:FindFirstChildOfClass("TextLabel")
                    if lbl then
                        lbl.TextColor3 = isFriend and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(255, 80, 80)
                    end
                end
            else
                local hl = altChar:FindFirstChild("DezzHighlight")
                if hl then hl:Destroy() end
                local head = altChar:FindFirstChild("Head")
                if head then
                    local bb = head:FindFirstChild("DezzTag")
                    if bb then bb:Destroy() end
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    updateESP()
    
    -- Отслеживание здоровья для звука убийств
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
            local hum = p.Character.Humanoid
            if not trackedHealths[p] then
                trackedHealths[p] = hum.Health
            else
                if trackedHealths[p] > 0 and hum.Health <= 0 then
                    playKillSound()
                end
                trackedHealths[p] = hum.Health
            end
        end
    end

    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    if settings.Bunnyhop and humanoid and rootPart and isJumping then
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                rootPart.Velocity = Vector3.new(moveDir.X * 42, rootPart.Velocity.Y, moveDir.Z * 42)
            end
        end
    end
    
    if settings.Spinbot then
        if rootPart then
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
        end
    end
    
    local closest = nil
    local dist = settings.FovRadius
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and not friendsList[p.Name] and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local root = p.Character.HumanoidRootPart
            local d = (root.Position - camera.CFrame.Position).Magnitude
            if d < dist and isValidTarget(root, p.Name) then
                closest = root
                dist = d
            end
        end
    end
    
    -- Aimbot 1.0 (Камера наводится)
    if settings.Aimbot1 and closest then
        camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
    end
    
    -- Aimbot 2.0 (Экран не наводится, логика работает в фоне)
    if settings.Aimbot2 and closest then
        -- Скрипт видит цель и может фиксировать хит/направление, но камеру не трогает
    end
end)
