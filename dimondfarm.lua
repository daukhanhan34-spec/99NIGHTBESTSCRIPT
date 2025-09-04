--// Black Screen Farm UI with Solid Border
--// Made by KienRoBlox ✦

-- Auto chạy script gốc
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rx1m/CpsHub/refs/heads/main/Cpsnerf"))()
end)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Xóa UI cũ nếu có
if PlayerGui:FindFirstChild("FarmUIBlack") then
    PlayerGui.FarmUIBlack:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FarmUIBlack"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Nền đen
local BlackScreen = Instance.new("Frame")
BlackScreen.Size = UDim2.new(1,0,1,0)
BlackScreen.BackgroundColor3 = Color3.fromRGB(0,0,0)
BlackScreen.BorderSizePixel = 0
BlackScreen.Parent = ScreenGui

-- Hàm tạo viền (4 cạnh)
local borderColor = Color3.fromRGB(0,255,200)
local thickness = 6

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,thickness)
Top.Position = UDim2.new(0,0,0,0)
Top.BackgroundColor3 = borderColor
Top.Parent = BlackScreen

local Bottom = Instance.new("Frame")
Bottom.Size = UDim2.new(1,0,0,thickness)
Bottom.Position = UDim2.new(0,0,1,-thickness)
Bottom.BackgroundColor3 = borderColor
Bottom.Parent = BlackScreen

local Left = Instance.new("Frame")
Left.Size = UDim2.new(0,thickness,1,0)
Left.Position = UDim2.new(0,0,0,0)
Left.BackgroundColor3 = borderColor
Left.Parent = BlackScreen

local Right = Instance.new("Frame")
Right.Size = UDim2.new(0,thickness,1,0)
Right.Position = UDim2.new(1,-thickness,0,0)
Right.BackgroundColor3 = borderColor
Right.Parent = BlackScreen

-- Animation đổi màu viền
task.spawn(function()
    while BlackScreen.Parent do
        local newColor = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
        for _,frame in pairs({Top,Bottom,Left,Right}) do
            TweenService:Create(frame, TweenInfo.new(2), {BackgroundColor3 = newColor}):Play()
        end
        task.wait(2)
    end
end)

-- Text chính
local Label = Instance.new("TextLabel")
Label.AnchorPoint = Vector2.new(0.5,0.5)
Label.Position = UDim2.new(0.5,0,0.45,0)
Label.Size = UDim2.new(0.9,0,0.15,0)
Label.BackgroundTransparency = 1
Label.Text = "✦ ĐANG FARM KIM CƯƠNG ✦"
Label.TextColor3 = Color3.fromRGB(0,255,200)
Label.Font = Enum.Font.GothamBlack
Label.TextScaled = true
Label.Parent = BlackScreen

-- Hiệu ứng nhấp nháy chữ
task.spawn(function()
    while Label.Parent do
        TweenService:Create(Label, TweenInfo.new(1), {TextTransparency = 0.3}):Play()
        task.wait(1)
        TweenService:Create(Label, TweenInfo.new(1), {TextTransparency = 0}):Play()
        task.wait(1)
    end
end)

-- Credit
local Credit = Instance.new("TextLabel")
Credit.AnchorPoint = Vector2.new(0.5,0.5)
Credit.Position = UDim2.new(0.5,0,0.55,0)
Credit.Size = UDim2.new(0.6,0,0.08,0)
Credit.BackgroundTransparency = 1
Credit.Text = "Made by KienRoBlox"
Credit.TextColor3 = Color3.fromRGB(200,200,200)
Credit.Font = Enum.Font.Gotham
Credit.TextScaled = true
Credit.Parent = BlackScreen