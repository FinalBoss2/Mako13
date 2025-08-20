-- GAG Menu LocalScript for Loadstring Executors

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GAGMenu"
screenGui.Parent = playerGui

-- Create main menu frame
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 300, 0, 50)
menuFrame.Position = UDim2.new(0.5, -150, 0.5, -25)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = screenGui

-- Title bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.Parent = menuFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "GAG"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 1, 0)
closeButton.Position = UDim2.new(1, -25, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.TextColor3 = Color3.fromRGB(255,255,255)
closeButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeButton.Parent = topBar

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 25, 1, 0)
minimizeButton.Position = UDim2.new(1, -50, 0, 0)
minimizeButton.Text = "_"
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 20
minimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
minimizeButton.Parent = topBar

-- Content frame (hidden when minimized)
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 0, 100)
content.Position = UDim2.new(0, 0, 1, 0)
content.BackgroundTransparency = 1
content.Parent = menuFrame

-- Utility function for toggle rows
local function createToggle(nameText, yOffset)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 40)
    row.Position = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundColor3 = Color3.fromRGB(50,50,50)
    row.Parent = content

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = nameText
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -70, 0, 5)
    toggleBtn.Text = "OFF"
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextSize = 18
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
    toggleBtn.Parent = row

    toggleBtn.ActiveState = false

    toggleBtn.MouseButton1Click:Connect(function()
        toggleBtn.ActiveState = not toggleBtn.ActiveState
        if toggleBtn.ActiveState then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
        end
    end)
end

-- Create the two toggle options
createToggle("dupe pet", 10)
createToggle("dupe fruits", 60)

-- Close button logic
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Minimize button logic
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    if minimized then
        menuFrame.Size = UDim2.new(0, 300, 0, 30)
    else
        menuFrame.Size = UDim2.new(0, 300, 0, 150)
    end
end)

-- Make the menu draggable
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menuFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        menuFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
