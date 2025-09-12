local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- số kim cương mặc định
local diamonds = 0

-- Hàm áp dụng số vào UI
local function applyToLabel(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        local text = obj.Text
        if string.find(text, "%d") then
            obj.Text = tostring(diamonds)
        end
    end
end

-- áp dụng ban đầu
for _, obj in ipairs(PlayerGui:GetDescendants()) do
    applyToLabel(obj)
end

-- auto áp dụng cho UI mới
PlayerGui.DescendantAdded:Connect(function(obj)
    applyToLabel(obj)
end)

-- UI chỉnh kim cương
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiamondSpooferUI"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Visible = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Diamonds"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.Parent = frame

-- Viền lấp lánh
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Parent = title

-- Hiệu ứng đổi màu viền
task.spawn(function()
    while task.wait(0.1) do
        local r = math.random(150, 255)
        local g = math.random(150, 255)
        local b = math.random(150, 255)
        stroke.Color = Color3.fromRGB(r, g, b)
    end
end)

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 30)
textBox.Position = UDim2.new(0.1, 0, 0, 40)
textBox.PlaceholderText = "Nhập số..."
textBox.Text = ""
textBox.Font = Enum.Font.GothamBold
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 30)
button.Position = UDim2.new(0.1, 0, 0, 80)
button.Text = "Apply"
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Parent = frame
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

-- Nút bật/tắt UI
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 25)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "UI"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

-- Xử lý Apply
button.MouseButton1Click:Connect(function()
    local num = tonumber(textBox.Text)
    if num then
        diamonds = num
        for _, obj in ipairs(PlayerGui:GetDescendants()) do
            applyToLabel(obj)
        end
        StarterGui:SetCore("SendNotification", {
            Title = "Diamonds Updated!",
            Text = "Số mới: " .. tostring(diamonds),
            Duration = 4
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Lỗi",
            Text = "Vui lòng nhập số hợp lệ!",
            Duration = 4
        })
    end
end)

-- Toggle UI
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Thông báo khi bật script
StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded!",
    Text = "Made by Khánh An ✨\nDiamonds giờ lấp lánh luôn.",
    Duration = 6
})