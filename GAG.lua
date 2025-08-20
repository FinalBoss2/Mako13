-- LocalScript (put in StarterPlayerScripts)

local Players            = game:GetService("Players")
local UserInputService   = game:GetService("UserInputService")
local playerGui          = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Root ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name   = "GAGMenu"
screenGui.Parent = playerGui

-- Main Window Frame
local menuFrame = Instance.new("Frame")
menuFrame.Name               = "Window"
menuFrame.Size               = UDim2.new(0, 300, 0, 150)
menuFrame.Position           = UDim2.new(0, 100, 0, 100)
menuFrame.BackgroundColor3   = Color3.fromRGB(30, 30, 30)
menuFrame.Active             = true
menuFrame.Parent             = screenGui

-- Top Bar (drag handle + title)
local topBar = Instance.new("Frame")
topBar.Name               = "TopBar"
topBar.Size               = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3   = Color3.fromRGB(20, 20, 20)
topBar.Parent             = menuFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size                 = UDim2.new(1, -60, 1, 0)
titleLabel.Position             = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text                 = "GAG"
titleLabel.TextColor3           = Color3.new(1, 1, 1)
titleLabel.Font                 = Enum.Font.SourceSansBold
titleLabel.TextSize             = 20
titleLabel.TextXAlignment       = Enum.TextXAlignment.Left
titleLabel.Parent               = topBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name             = "Close"
closeButton.Size             = UDim2.new(0, 30, 1, 0)
closeButton.Position         = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Text             = "X"
closeButton.TextColor3       = Color3.new(1, 1, 1)
closeButton.Font             = Enum.Font.SourceSansBold
closeButton.TextSize         = 20
closeButton.Parent           = topBar

-- Content Container
local content = Instance.new("Frame")
content.Name                 = "Content"
content.Size                 = UDim2.new(1, 0, 1, -30)
content.Position             = UDim2.new(0, 0, 0, 30)
content.BackgroundTransparency = 1
content.Parent               = menuFrame

-- Utility: create a toggle row
local function createToggle(nameText, yOffset)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1, -20, 0, 40)
    row.Position         = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    row.Parent           = content

    local label = Instance.new("TextLabel")
    label.Size                 = UDim2.new(0.6, 0, 1, 0)
    label.Position             = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text                 = nameText
    label.TextColor3           = Color3.new(1, 1, 1)
    label.Font                 = Enum.Font.SourceSansBold
    label.TextSize             = 18
    label.TextXAlignment       = Enum.TextXAlignment.Left
    label.Parent               = row

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size              = UDim2.new(0, 80, 0, 30)
    toggleBtn.Position          = UDim2.new(1, -90, 0, 5)
    toggleBtn.Font              = Enum.Font.SourceSansBold
    toggleBtn.TextSize          = 18
    toggleBtn.TextColor3        = Color3.new(1, 1, 1)
    toggleBtn.AutoButtonColor   = false
    toggleBtn.Parent            = row

    -- initial state = OFF
    toggleBtn.ActiveState = false
    toggleBtn.Text        = "OFF"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    -- flip on click
    toggleBtn.MouseButton1Click:Connect(function()
        toggleBtn.ActiveState = not toggleBtn.ActiveState
        if toggleBtn.ActiveState then
            toggleBtn.Text             = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleBtn.Text             = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        print(nameText, "toggled to", toggleBtn.ActiveState and "ON" or "OFF")
    end)
end

-- Create the two rows
createToggle("DUPE PETS",    10)
createToggle("dupe fruits",  60)

-- Close logic
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Draggable window logic
do
    local dragging, dragStart, startPos

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = menuFrame.Position
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
            menuFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end
