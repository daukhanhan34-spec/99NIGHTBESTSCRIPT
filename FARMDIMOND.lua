--// Rezexis Loader with FPS Slider + FPS Counter
--// by khanhaim™

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local SetFPSCap = setfpscap or set_fps_cap or function() end

if CoreGui:FindFirstChild("RezexisLoaderUI") then
    CoreGui.RezexisLoaderUI:Destroy()
end

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "RezexisLoaderUI"
gui.IgnoreGuiInset = true

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 430, 0, 400)
frame.Position = UDim2.new(0.5, -215, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0, 255, 200)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "⚡ Rezexis Hub Loader"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1

-- Sub
local sub = Instance.new("TextLabel", frame)
sub.Size = UDim2.new(1, 0, 0, 25)
sub.Position = UDim2.new(0,0,0,40)
sub.Text = "Chọn chức năng bên dưới"
sub.Font = Enum.Font.Gotham
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(200,200,200)
sub.BackgroundTransparency = 1

-- Hàm tạo nút
local function makeButton(txt, posY)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0, 280, 0, 45)
    b.Position = UDim2.new(0.5, -140, posY, -22)
    b.BackgroundColor3 = Color3.fromRGB(40,40,55)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    return b
end

-- Nút Start Hub
local startBtn = makeButton("🚀 Start Rezexis Hub", 0.23)
startBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rezexis/RezexisOnTop/refs/heads/main/Official%20Source.lua"))()
end)

-- Nút Copy Liên hệ
local copyBtn = makeButton("📋 Copy Liên hệ cày KC", 0.37)
copyBtn.MouseButton1Click:Connect(function()
    local link = "https://www.facebook.com/share/19Nik36K9r/?mibextid=wwXIfr"
    if setclipboard then
        setclipboard("Thuê cày kim cương giá rẻ: "..link)
    end
    copyBtn.Text = "✅ Đã copy!"
    task.wait(2)
    copyBtn.Text = "📋 Copy Liên hệ cày KC"
end)

-- Nút Boost FPS Hardcore
local boostBtn = makeButton("💀 Hardcore FPS Boost (Xoá sạch)", 0.51)
boostBtn.MouseButton1Click:Connect(function()
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            for _,obj in ipairs(plr.Character:GetChildren()) do
                if obj:IsA("Accessory") or obj:IsA("Clothing") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("Hat") then
                    obj:Destroy()
                elseif obj:IsA("BasePart") then
                    obj.Color = Color3.fromRGB(255,255,255)
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
        or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles")
        or v:IsA("Decal") or v:IsA("Texture") then
            pcall(function() v:Destroy() end)
        end
    end
    for _,obj in ipairs(Lighting:GetChildren()) do obj:Destroy() end
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.FogEnd = 1e10
    Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
    Lighting.Ambient = Color3.fromRGB(255,255,255)

    boostBtn.Text = "✅ FPS Boost Applied!"
    task.wait(3)
    boostBtn.Text = "💀 Hardcore FPS Boost (Xoá sạch)"
end)

-- FPS Slider
local fpsLabel = Instance.new("TextLabel", frame)
fpsLabel.Size = UDim2.new(1, -40, 0, 25)
fpsLabel.Position = UDim2.new(0,20,0.70,0)
fpsLabel.Text = "🔧 Unlock FPS: 60"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.TextColor3 = Color3.fromRGB(255,255,255)
fpsLabel.BackgroundTransparency = 1

local sliderBack = Instance.new("Frame", frame)
sliderBack.Size = UDim2.new(0,280,0,6)
sliderBack.Position = UDim2.new(0.5,-140,0.80,0)
sliderBack.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0,3)

local sliderFill = Instance.new("Frame", sliderBack)
sliderFill.Size = UDim2.new(0,0,1,0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0,200,255)
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0,3)

local sliderBtn = Instance.new("Frame", sliderBack)
sliderBtn.Size = UDim2.new(0,14,0,14)
sliderBtn.Position = UDim2.new(0, -7, 0.5, -7)
sliderBtn.BackgroundColor3 = Color3.fromRGB(0,255,200)
Instance.new("UICorner", sliderBtn).CornerRadius = UDim.new(1,0)

local dragging = false
local fpsOptions = {60,90,120,144,240}

local function updateSlider(x)
    local percent = math.clamp((x-sliderBack.AbsolutePosition.X)/sliderBack.AbsoluteSize.X,0,1)
    sliderBtn.Position = UDim2.new(percent, -7, 0.5, -7)
    sliderFill.Size = UDim2.new(percent,0,1,0)

    local idx = math.clamp(math.floor(percent*#fpsOptions)+1,1,#fpsOptions)
    local fps = fpsOptions[idx]
    fpsLabel.Text = "🔧 Unlock FPS: " .. fps
    SetFPSCap(fps)
end

sliderBack.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; updateSlider(i.Position.X) end
end)
sliderBack.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
RunService.RenderStepped:Connect(function()
    if dragging then
        updateSlider(UIS:GetMouseLocation().X)
    end
end)

-- default
updateSlider(sliderBack.AbsolutePosition.X)

-- FPS Counter ở góc trái
local fpsCounter = Instance.new("TextLabel", gui)
fpsCounter.Size = UDim2.new(0,200,0,30)
fpsCounter.Position = UDim2.new(0,10,0,10)
fpsCounter.BackgroundTransparency = 1
fpsCounter.Font = Enum.Font.GothamBold
fpsCounter.TextSize = 16
fpsCounter.TextColor3 = Color3.fromRGB(0,255,0)
fpsCounter.Text = "FPS: ..."

local frames, lastUpdate = 0, tick()
RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - lastUpdate >= 1 then
        fpsCounter.Text = "FPS: " .. frames
        frames = 0
        lastUpdate = tick()
    end
end)