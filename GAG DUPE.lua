-- LocalScript (place in StarterPlayerScripts or run via executor)

local Players       = game:GetService("Players")
local UserInputSvc  = game:GetService("UserInputService")
local playerGui     = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name           = "GAG_Menu_GUI"
screenGui.ResetOnSpawn   = false
screenGui.Parent         = playerGui

-- Main Frame (the “window”)
local menuFrame = Instance.new("Frame")
menuFrame.Name           = "MenuFrame"
menuFrame.Size           = UDim2.new(0, 300, 0, 150)
menuFrame.Position       = UDim2.new(0, 100, 0, 100)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuFrame.Parent         = screenGui
menuFrame.Active         = true

-- Top Bar (title + drag area + controls)
local topBar = Instance.new("Frame")
topBar.Name               = "TopBar"
topBar.Size               = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3   = Color3.fromRGB(20, 20, 20)
topBar.Parent             = menuFrame

-- Title Label (“GAG”)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name             = "Title"
titleLabel.Size             = UDim2.new(0.6, 0, 1, 0)
titleLabel.Position         = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text             = "GAG"
titleLabel.TextColor3       = Color3.new(1, 1, 1)
titleLabel.Font             = Enum.Font.SourceSansBold
titleLabel.TextSize         = 20
titleLabel.TextXAlignment   = Enum.TextXAlignment.Left
titleLabel.Parent           = topBar

-- Minimize Button (“_”)
local minButton = Instance.new("TextButton")
minButton.Name               = "Minimize"
minButton.Size               = UDim2.new(0, 30, 1, 0)
minButton.Position           = UDim2.new(1, -60, 0, 0)
minButton.BackgroundColor3   = Color3.fromRGB(50, 50, 50)
minButton.Text               = "_"
minButton.TextColor3         = Color3.new(1, 1, 1)
minButton.Font               = Enum.Font.SourceSansBold
minButton.TextSize           = 24
minButton.Parent             = topBar

-- Close Button (“X”)
local closeButton = Instance.new("TextButton")
closeButton.Name             = "Close"
closeButton.Size             = UDim2.new(0, 30, 1, 0)
closeButton.Position         = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Text             = "X"
closeButton.TextColor3       = Color3.new(1, 1, 1)
closeButton.Font             = Enum.Font.SourceSansBold
closeButton.TextSize         = 24
closeButton.Parent           = topBar

-- Content Area (holds the option toggles)
local content = Instance.new("Frame")
content.Name               = "Content"
content.Size               = UDim2.new(1, 0, 1, -30)
content.Position           = UDim2.new(0, 0, 0, 30)
content.BackgroundTransparency = 1
content.Parent             = menuFrame

-- State variables
local dupePetEnabled    = false
local dupeFruitEnabled  = false
local isMinimized       = false

-- Utility to create an option row
local function createOption(nameText, yOffset, onToggle)
    local row = Instance.new("Frame")
    row.Size               = UDim2.new(1, -20, 0, 40)
    row.Position           = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundColor3   = Color3.fromRGB(50, 50, 50)
    row.Parent             = content

    local label = Instance.new("TextLabel", row)
    label.Size             = UDim2.new(0.6, 0, 1, 0)
    label.Position         = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text             = nameText
    label.TextColor3       = Color3.new(1, 1, 1)
    label.Font             = Enum.Font.SourceSansBold
    label.TextSize         = 18
    label.TextXAlignment   = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", row)
    toggle.Size              = UDim2.new(0, 60, 0, 30)
    toggle.Position          = UDim2.new(1, -70, 0, 5)
    toggle.BackgroundColor3  = Color3.fromRGB(255, 0, 0)
    toggle.Text              = "OFF"
    toggle.TextColor3        = Color3.new(1, 1, 1)
    toggle.Font              = Enum.Font.SourceSansBold
    toggle.TextSize          = 18

    toggle.MouseButton1Click:Connect(function()
        local newState = not toggle.newState
        toggle.newState = newState
        if newState then
            toggle.Text             = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggle.Text             = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        onToggle(newState)
    end)

    return row
end

-- Create “Dupe Pet” option
createOption("Dupe Pet", 10, function(state)
    dupePetEnabled = state
    print("Dupe Pet:", state)
end)

-- Create “Dupe Fruits” option
createOption("Dupe Fruits", 60, function(state)
    dupeFruitEnabled = state
    print("Dupe Fruits:", state)
end)

-- Dragging logic for the window
do
    local dragging, dragStart, startPos

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
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

    UserInputSvc.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            menuFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Minimize / Restore
minButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    content.Visible   = not isMinimized
    menuFrame.Size    = isMinimized
        and UDim2.new(0, 300, 0, 30)
        or UDim2.new(0, 300, 0, 150)
end)

-- Close
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
