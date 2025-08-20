-- LocalScript for loadstring executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Root GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GAGMenu"
screenGui.Parent = playerGui

-- Main menu frame
local menu = Instance.new("Frame")
menu.Name = "Window"
menu.Size = UDim2.new(0, 300, 0, 150)
menu.Position = UDim2.new(0, 100, 0, 100)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.Active = true
menu.Parent = screenGui

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Parent = menu

local title = Instance.new("TextLabel")
title.Text = "GAG"
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = topBar
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Minimize button
local minBtn = Instance.new("TextButton")
minBtn.Text = "_"
minBtn.Size = UDim2.new(0, 30, 1, 0)
minBtn.Position = UDim2.new(1, -60, 0, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 20
minBtn.Parent = topBar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -30)
content.Position = UDim2.new(0, 0, 0, 30)
content.BackgroundTransparency = 1
content.Parent = menu

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    if minimized then
        menu.Size = UDim2.new(0, 300, 0, 30)
    else
        menu.Size = UDim2.new(0, 300, 0, 150)
    end
end)

-- Toggle function
local function createToggle(nameText, yOffset)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 40)
    row.Position = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    row.Parent = content

    local label = Instance.new("TextLabel")
    label.Text = nameText
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 80, 0, 30)
    toggleBtn.Position = UDim2.new(1, -90, 0, 5)
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextSize = 18
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggleBtn.Text = "OFF"
    toggleBtn.Parent = row
    toggleBtn.ActiveState = false

    toggleBtn.MouseButton1Click:Connect(function()
        toggleBtn.ActiveState = not toggleBtn.ActiveState
        if toggleBtn.ActiveState then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Create both toggles
createToggle("DUPE PETS", 10)
createToggle("DUPE FRUITS", 60)

-- Dragging logic
do
    local dragging, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = menu.Position
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
            menu.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end
