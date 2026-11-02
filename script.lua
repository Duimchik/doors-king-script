-- King Script v12 | Ultimate Hub for Delta Executor
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

if CoreGui:FindFirstChild("KingScriptUI") then
    CoreGui.KingScriptUI:Destroy()
end

local AutoWalkEnabled = false
local AutoLootEnabled = false
local SelectedFloor = "Отель"
local FlyEnabled = false
local FlySpeed = 30
local FlyBodyGyro, FlyBodyVelocity

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingScriptUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 215, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "👑 King Script | Ultimate Hub v12"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -65, 0, 5)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = MainFrame

local CrownIcon = Instance.new("TextButton")
CrownIcon.Name = "CrownIcon"
CrownIcon.Size = UDim2.new(0, 60, 0, 60)
CrownIcon.Position = UDim2.new(0.05, 0, 0.4, 0)
CrownIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CrownIcon.Text = "👑"
CrownIcon.TextSize = 32
CrownIcon.Visible = false
CrownIcon.Active = true
CrownIcon.Draggable = true
CrownIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = CrownIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 215, 0)
IconStroke.Thickness = 3
IconStroke.Parent = CrownIcon

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -20, 1, -60)
ContentScroll.Position = UDim2.new(0, 10, 0, 50)
ContentScroll.BackgroundTransparency = 1
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 450)
ContentScroll.ScrollBarThickness = 4
ContentScroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 10)
UIList.Parent = ContentScroll

local function createToggle(name, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = ContentScroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 16
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 40, 0, 24)
    Btn.Position = UDim2.new(1, -50, 0.5, -12)
    Btn.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(70, 70, 70)
    Btn.Text = ""
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)

    local enabled = default
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(70, 70, 70)
        callback(enabled)
    end)
end

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    CrownIcon.Visible = true
    CrownIcon.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(CrownIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 60, 0, 60)}):Play()
end)

CrownIcon.MouseButton1Click:Connect(function()
    CrownIcon.Visible = false
    MainFrame.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    AutoWalkEnabled = false
    AutoLootEnabled = false
    FlyEnabled = false
end)

local FloorFrame = Instance.new("Frame")
FloorFrame.Size = UDim2.new(1, -10, 0, 40)
FloorFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FloorFrame.Parent = ContentScroll
Instance.new("UICorner", FloorFrame).CornerRadius = UDim.new(0, 6)

local FloorLabel = Instance.new("TextLabel")
FloorLabel.Size = UDim2.new(0, 150, 1, 0)
FloorLabel.Position = UDim2.new(0, 10, 0, 0)
FloorLabel.Text = "👑 Select Floor:"
FloorLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
FloorLabel.TextSize = 16
FloorLabel.Font = Enum.Font.SourceSansBold
FloorLabel.TextXAlignment = Enum.TextXAlignment.Left
FloorLabel.BackgroundTransparency = 1
FloorLabel.Parent = FloorFrame

local FloorBtn = Instance.new("TextButton")
FloorBtn.Size = UDim2.new(0, 120, 0, 30)
FloorBtn.Position = UDim2.new(1, -130, 0.5, -15)
FloorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FloorBtn.Text = "Отель"
FloorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloorBtn.Font = Enum.Font.SourceSansBold
FloorBtn.TextSize = 14
FloorBtn.Parent = FloorFrame
Instance.new("UICorner", FloorBtn).CornerRadius = UDim.new(0, 6)

FloorBtn.MouseButton1Click:Connect(function()
    if SelectedFloor == "Отель" then
        SelectedFloor = "Шахты"
        FloorBtn.Text = "Шахты"
    else
        SelectedFloor = "Отель"
        FloorBtn.Text = "Отель"
    end
end)

createToggle("👑 Start Auto Farm (Doors)", false, function(v) AutoWalkEnabled = v end)
createToggle("👑 Auto Loot (Gold, Bolts, Knobs)", false, function(v) AutoLootEnabled = v end)
createToggle("✈️ Enable Fly (Noclip)", false, function(v) 
    FlyEnabled = v 
    if FlyEnabled then startFlying() end
end)

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -10, 0, 50)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedFrame.Parent = ContentScroll
Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 6)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 5)
SpeedLabel.Text = "⚡ WalkSpeed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = SpeedFrame

-- Базовые функции передвижения и сбора (полностью перенесены из v11)
function teleportTo(targetCFrame, speed)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local duration = distance / speed
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

local function grabKey()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "Key" or obj.Name == "KeyNB" or string.find(obj.Name:lower(), "key") then
            local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                prompt.MaxActivationDistance = 9999
                prompt.RequiresLineOfSight = false
                prompt.HoldDuration = 0
                fireproximityprompt(prompt)
                task.wait(0.1)
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.4)
        if AutoWalkEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and not FlyEnabled then
                local currentRoomNum = LocalPlayer:GetAttribute("CurrentRoom") or 0
                local targetRoomNum = currentRoomNum + 1
                local nextRoom = Workspace.CurrentRooms:FindFirstChild(tostring(targetRoomNum))
                
                if Workspace:FindFirstChild("Halt") or Workspace:FindFirstChild("HaltMoving") or Workspace:FindFirstChild("HaltRoom") or Workspace:FindFirstChild("HaltHallway") then continue end
                if Workspace:FindFirstChild("SeekMoving") or Workspace:FindFirstChild("SeekCharacter") or Workspace:FindFirstChild("SeekChase") then continue end

                if SelectedFloor == "Отель" then
                    if nextRoom and nextRoom:FindFirstChild("LockedDoor") then
                        grabKey()
                        local lock = nextRoom.LockedDoor:FindFirstChild("Lock") or nextRoom.LockedDoor:FindFirstChild("Door")
                        if lock then
                            local t = teleportTo(lock.CFrame * CFrame.new(0, 0, 2), 20)
                            if t then t.Completed:Wait() end
