local function createOption(content, nameText, yOffset, onToggle)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 40)
    row.Position = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    row.Parent = content

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = nameText
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", row)
    toggle.Size = UDim2.new(0, 60, 0, 30)
    toggle.Position = UDim2.new(1, -70, 0, 5)
    toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 18

    toggle.State = false

    toggle.MouseButton1Click:Connect(function()
        toggle.State = not toggle.State
        if toggle.State then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        if onToggle then onToggle(toggle.State) end
    end)

    return row
end
