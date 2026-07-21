local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

lp.CharacterAdded:Connect(function(char)
    character = char
    rootPart = char:WaitForChild("HumanoidRootPart")
end)

local playerGui = lp:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LevelTeleportGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 260, 0, 320)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Text = "ВЫБОР УРОВНЯ"

local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Size = UDim2.new(0.9, 0, 0.78, 0)
scrollFrame.Position = UDim2.new(0.05, 0, 0.16, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local uiList = Instance.new("UIListLayout", scrollFrame)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 6)

-- Список твоих уровней (телепортация без копирования)
local levels = {
    CFrame.new(12.0527391, 4.26973724, 163.570389, -0.0433352664, 0, -0.999060571, 0, 1, 0, 0.999060571, 0, -0.0433352664),
    CFrame.new(207.796875, 4.26973724, 164.644745, -0.0823348612, 0, -0.996604741, 0, 1, 0, 0.996604741, 0, -0.0823348612),
    CFrame.new(449.5, 4.26974106, 162.560898, -0.0109354444, -1.25121211e-08, -0.999940217, 8.34207814e-09, 1, -1.26040991e-08, 0.999940217, -8.47941095e-09, -0.0109354444),
    CFrame.new(845.917603, 74.269722, 160.790375, 0.012609655, -5.83931659e-08, -0.999920487, 1.05224489e-10, 1, -5.83964805e-08, 0.999920487, 6.3114336e-10, 0.012609655),
    CFrame.new(1206.07617, 74.269722, 161.122803, 0.0126154264, -5.843685e-08, -0.999920428, 1.05582612e-10, 1, -5.84401683e-08, 0.999920428, 6.31673436e-10, 0.0126154264),
    CFrame.new(1323, 403.269745, 161.622803, -0.00256618601, -4.14385575e-08, -0.999996722, -5.54247148e-10, 1, -4.14372714e-08, 0.999996722, 4.47909571e-10, -0.00256618601),
    CFrame.new(1952, 403.269745, 158.622803, -0.00257165427, -3.77561769e-08, -0.999996722, -5.05175013e-10, 1, -3.77550045e-08, 0.999996722, 4.08080542e-10, -0.00257165427),
    CFrame.new(2995, 432.269745, 156.882324, -0.00257690181, -2.66887756e-08, -0.999996662, -3.57194774e-10, 1, -2.66879425e-08, 0.999996662, 2.8842137e-10, -0.00257690181),
    CFrame.new(3418.03052, 435.10321, 263.085999, -0.997675955, -1.13572429e-09, 0.0681369528, -1.46235768e-09, 1, -4.74389994e-09, -0.0681369528, -4.83251528e-09, -0.997675955)
}

for i, targetCFrame in ipairs(levels) do
    local pointBtn = Instance.new("TextButton", scrollFrame)
    pointBtn.Size = UDim2.new(1, -6, 0, 35)
    pointBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    pointBtn.TextColor3 = Color3.fromRGB(200, 255, 200)
    pointBtn.Font = Enum.Font.GothamMedium
    pointBtn.TextSize = 12
    pointBtn.Text = "Level " .. i
    
    local btnCorner = Instance.new("UICorner", pointBtn)
    btnCorner.CornerRadius = UDim.new(0, 5)
    
    pointBtn.MouseButton1Click:Connect(function()
        if rootPart then
            rootPart.CFrame = targetCFrame
        end
    end)
end
