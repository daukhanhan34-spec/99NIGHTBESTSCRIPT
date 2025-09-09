-- SKY BASE MAKER v11 (UI ngang + draggable + slider mượt max 1000)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ
pcall(function() LocalPlayer.PlayerGui:FindFirstChild("SkyBaseUI"):Destroy() end)

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SkyBaseUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main UI bar
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 420, 0, 140)
bar.Position = UDim2.new(0.5, -210, 0.2, 0)
bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
bar.Parent = gui
bar.Active = true

-- Header (kéo UI)
local header = Instance.new("TextLabel", bar)
header.Size = UDim2.new(1, 0, 0, 25)
header.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
header.Text = "SKY BASE MAKER"
header.Font = Enum.Font.SourceSansBold
header.TextSize = 20
header.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Slider container
local sliderFrame = Instance.new("Frame", bar)
sliderFrame.Size = UDim2.new(0, 280, 0, 10)
sliderFrame.Position = UDim2.new(0, 20, 0, 50)
sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

-- Slider fill
local sliderFill = Instance.new("Frame", sliderFrame)
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 100)

-- Slider button (tròn)
local sliderButton = Instance.new("TextButton", sliderFrame)
sliderButton.Size = UDim2.new(0, 16, 0, 16)
sliderButton.Position = UDim2.new(0, -8, 0.5, -8)
sliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
sliderButton.Text = ""
sliderButton.AutoButtonColor = false
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

-- Slider value label
local sliderValueLabel = Instance.new("TextLabel", bar)
sliderValueLabel.Size = UDim2.new(0, 100, 0, 20)
sliderValueLabel.Position = UDim2.new(0, 320, 0, 45)
sliderValueLabel.BackgroundTransparency = 1
sliderValueLabel.Text = "0"
sliderValueLabel.Font = Enum.Font.SourceSans
sliderValueLabel.TextSize = 16
sliderValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Buttons dưới slider
local addButton = Instance.new("TextButton", bar)
addButton.Size = UDim2.new(0, 120, 0, 25)
addButton.Position = UDim2.new(0, 70, 0, 95)
addButton.Text = "⚓ Add"
addButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
addButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local removeButton = Instance.new("TextButton", bar)
removeButton.Size = UDim2.new(0, 120, 0, 25)
removeButton.Position = UDim2.new(0, 210, 0, 95)
removeButton.Text = "✂ Remove"
removeButton.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
removeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle button
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 30, 0, 30)
toggle.Position = UDim2.new(1, -40, 1, -40)
toggle.Text = "≡"
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)

toggle.MouseButton1Click:Connect(function()
    bar.Visible = not bar.Visible
end)

-- Drag UI bằng header
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = bar.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        bar.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Block logic
local targets, sliderValue = {}, 0
local function getFootPart()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local ray = Ray.new(root.Position, Vector3.new(0, -5, 0))
    local part = workspace:FindPartOnRay(ray, char)
    return part
end
local function ensureHighlight(part)
    if not part:FindFirstChild("PersistentHighlight") then
        local h = Instance.new("Highlight")
        h.Name = "PersistentHighlight"
        h.FillColor = Color3.fromRGB(0, 255, 0)
        h.FillTransparency = 0.3
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.Adornee = part
        h.Parent = part
    end
end
local function removeHighlight(part)
    local h = part:FindFirstChild("PersistentHighlight")
    if h then h:Destroy() end
end

addButton.MouseButton1Click:Connect(function()
    local part = getFootPart()
    if part and not targets[part] then
        targets[part] = true
        ensureHighlight(part)
    end
end)
removeButton.MouseButton1Click:Connect(function()
    local part = getFootPart()
    if part and targets[part] then
        targets[part] = nil
        removeHighlight(part)
    end
end)

-- Slider logic (mượt + max 1000)
local draggingSlider = false
local function updateSliderAt(x)
    local barPos = sliderFrame.AbsolutePosition.X
    local barSize = sliderFrame.AbsoluteSize.X
    local rel = math.clamp(x - barPos, 0, barSize)
    sliderButton.Position = UDim2.new(0, rel - sliderButton.Size.X.Offset/2, 0.5, -8)
    sliderFill.Size = UDim2.new(rel/barSize, 0, 1, 0)
    sliderValue = math.floor((rel/barSize) * 1000)
    sliderValueLabel.Text = tostring(sliderValue)
    for part in pairs(targets) do
        if part and part:IsA("BasePart") then
            part.Size = Vector3.new(part.Size.X, sliderValue, part.Size.Z)
        end
    end
end
sliderButton.MouseButton1Down:Connect(function()
    draggingSlider = true
end)
sliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = UserInputService:GetMouseLocation()
        updateSliderAt(mouse.X)
        draggingSlider = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouse = UserInputService:GetMouseLocation()
        updateSliderAt(mouse.X)
    end
end)