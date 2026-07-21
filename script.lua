local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

local VALID_KEYS = {
    ["1"] = true,
    ["ROBLOX777XYZ"] = true,
    ["DEZZPRO99ABC"] = true
}

local settings = {
    Aimbot = false,
    AimbotTrigger = false,
    Aimbot1 = false,
    Aimbot1Trigger = false,
    Aimbot2 = false,
    Bunnyhop = false,
    ESP = false,
    Spinbot = false,
    ThirdPerson = false,
    FovRadius = 250
}

local friendsList = {}

-- Гарантированный триггер выстрела для мобилок и ПК
local function triggerShoot()
    pcall(function()
        -- Эмулируем нажатие на экран (работает для мобильных эксплойтов и ПК)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.01)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end

local playerGui = lp:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DezzCSGOStyle"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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
keyTitle.Text = "DEZZ V16 // FLICK EDITION"

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
mainFrame.Size = UDim2.new(0, 480, 0, 350)
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
titleLabel.Text = "DEZZ V16 // FLICK EDITION"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = string.upper(keyBox.Text)
    if VALID_KEYS[enteredKey] then
        keyGui:Destroy()
        openBtn.Visible = true
        mainFrame.Visible = true
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ!"
        keyBox.PlaceholderColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

local scrollContainer = Instance.new("ScrollingFrame", mainFrame)
scrollContainer.Size = UDim2.new(0.94, 0, 0.72, 0)
scrollContainer.Position = UDim2.new(0.03, 0, 0.13, 0)
scrollContainer.BackgroundTransparency = 1
scrollContainer.CanvasSize = UDim2.new(0, 0, 1.5, 0)
scrollContainer.ScrollBarThickness = 4

local gridLayout = Instance.new("UIGridLayout", scrollContainer)
gridLayout.CellSize = UDim2.new(0, 142, 0, 45)
gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createToggleWithDropdown(name, stateKey, triggerKey)
    local wrapper = Instance.new("Frame", scrollContainer)
    wrapper.BackgroundTransparency = 1
    wrapper.Size = UDim2.new(0, 142, 0, 45)

    local btn = Instance.new("TextButton", wrapper)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.Text = "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0, 8, 0, 8)
    indicator.Position = UDim2.new(0.65, 0, 0.2, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    local indCorner = Instance.new("UICorner", indicator)
    indCorner.CornerRadius = UDim.new(1, 0)

    local arrowBtn = Instance.new("TextButton", btn)
    arrowBtn.Size = UDim2.new(1, 0, 0, 14)
    arrowBtn.Position = UDim2.new(0, 0, 0.68, 0)
    arrowBtn.BackgroundTransparency = 1
    arrowBtn.Text = "▼"
    arrowBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    arrowBtn.TextSize = 9

    local subPanel = Instance.new("Frame", wrapper)
    subPanel.Size = UDim2.new(1, 0, 0, 32)
    subPanel.Position = UDim2.new(0, 0, 1, 4)
    subPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    subPanel.Visible = false
    subPanel.ZIndex = 5
    local spCorner = Instance.new("UICorner", subPanel)
    spCorner.CornerRadius = UDim.new(0, 4)

    local trigBtn = Instance.new("TextButton", subPanel)
    trigBtn.Size = UDim2.new(1, 0, 1, 0)
    trigBtn.BackgroundTransparency = 1
    trigBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    trigBtn.Font = Enum.Font.GothamMedium
    trigBtn.TextSize = 10
    trigBtn.Text = "[ ] Triggerbot"
    trigBtn.ZIndex = 6

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

    arrowBtn.MouseButton1Click:Connect(function()
        subPanel.Visible = not subPanel.Visible
    end)

    trigBtn.MouseButton1Click:Connect(function()
        settings[triggerKey] = not settings[triggerKey]
        if settings[triggerKey] then
            trigBtn.Text = "[✓] Triggerbot"
            trigBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
        else
            trigBtn.Text = "[ ] Triggerbot"
            trigBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end)
end

local function createToggle(name, stateKey)
    local btn = Instance.new("TextButton", scrollContainer)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
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

createToggleWithDropdown("Aimbot (Normal)", "Aimbot", "AimbotTrigger")
createToggleWithDropdown("Aimbot 1.0 (360)", "Aimbot1", "Aimbot1Trigger")
createToggle("Aimbot 2.0 (Silent)", "Aimbot2")
createToggle("Third Person", "ThirdPerson")
createToggle("Bunnyhop (1.5x)", "Bunnyhop")
createToggle("ESP (Wallhack)", "ESP")
createToggle("Spinbot", "Spinbot")

local friendsBtn = Instance.new("TextButton", mainFrame)
friendsBtn.Size = UDim2.new(0.94, 0, 0, 30)
friendsBtn.Position = UDim2.new(0.03, 0, 0.88, 0)
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

local refreshPlayerList = function()
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

-- ESP
local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            local altChar = player.Character
            if settings.ESP then
                local hl = altChar:FindFirstChild("DezzHighlight")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "DezzHighlight"
                    hl.FillTransparency = 0.15
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
                    hl.FillColor = Color3.fromRGB(255, 30, 30)
                    hl.OutlineColor = Color3.fromRGB(150, 0, 0)
                end
                
                local head = altChar:FindFirstChild("Head")
                if head and not head:FindFirstChild("DezzTag") then
                    local bb = Instance.new("BillboardGui", head)
                    bb.Name = "DezzTag"
                    bb.Size = UDim2.new(0, 100, 0, 30)
                    bb.StudsOffset = Vector3.new(0, 2.2, 0)
                    bb.AlwaysOnTop = true
                    
                    local lbl = Instance.new("TextLabel", bb)
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextStrokeTransparency = 0
                    lbl.TextSize = 11
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

    if settings.ThirdPerson then
        lp.CameraMode = Enum.CameraMode.Classic
        lp.CameraMinZoomDistance = 10
        lp.CameraMaxZoomDistance = 15
    end

    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    if settings.Bunnyhop and humanoid and rootPart then
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            rootPart.Velocity = Vector3.new(moveDir.X * (16 * 1.5), rootPart.Velocity.Y, moveDir.Z * (16 * 1.5))
        end
    end
    
    if settings.Spinbot and rootPart then
        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
    end
    
    -- Обычный Аимбот + Триггербот
    if settings.Aimbot then
        local closest = nil
        local dist = settings.FovRadius
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= lp and not friendsList[p.Name] and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local head = p.Character.Head
                local pos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local d = (Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2) - Vector2.new(pos.X, pos.Y)).Magnitude
                    if d < dist and isValidTarget(head, p.Name) then
                        closest = head
                        dist = d
                    end
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
            if settings.AimbotTrigger then
                triggerShoot()
            end
        end
    end

    -- Aimbot 1.0 (360) + Триггербот
    if settings.Aimbot1 then
        local closest = nil
        local dist = 99999
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= lp and not friendsList[p.Name] and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local head = p.Character.Head
                local d = (head.Position - camera.CFrame.Position).Magnitude
                if d < dist and isValidTarget(head, p.Name) then
                    closest = head
                    dist = d
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
            if settings.Aimbot1Trigger then
                triggerShoot()
            end
        end
    end
    
    -- Aimbot 2.0 (Silent / Моментальный выстрел без наведения камеры)
    if settings.Aimbot2 then
        local closest = nil
        local dist = 99999
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= lp and not friendsList[p.Name] and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local head = p.Character.Head
                local d = (head.Position - camera.CFrame.Position).Magnitude
                if d < dist and isValidTarget(head, p.Name) then
                    closest = head
                    dist = d
                end
            end
        end
        if closest then
            triggerShoot()
        end
    end
end)
