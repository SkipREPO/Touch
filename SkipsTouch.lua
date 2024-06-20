-- Define variable to track if G key is currently being held down
local isGKeyDown = false

-- Define variable to track action toggle for hotkey G
local actionToggledG = false

-- Function to play an emote using HumanoidDescription:AddEmote and Humanoid:PlayEmote
local function PlayEmote(emoteId, emoteName)
    -- Get the local player and their character
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local description = humanoid:FindFirstChildOfClass("HumanoidDescription")

        -- Check if the humanoid description exists
        if description then
            -- Add the emote to the humanoid description
            description:AddEmote(emoteName, emoteId)

            -- Play the emote
            humanoid:PlayEmote(emoteName)
        else
            warn("HumanoidDescription not found.")
        end
    else
        warn("Character or Humanoid not found.")
    end
end

-- Function to handle input for hotkey G
local function handleInputG(input)
    -- Check if the user is typing in the chat
    if not game:GetService("UserInputService"):GetFocusedTextBox() then
        if input.KeyCode == Enum.KeyCode.G then
            actionToggledG = not actionToggledF
            local emoteIdG = 5230615437
            local emoteNameG = "CustomEmoteG"
            PlayEmote(emoteIdG, emoteNameG)
        end
    end
end

-- Bind the input handler function to the InputBegan and InputEnded events for hotkey G
game:GetService("UserInputService").InputBegan:Connect(handleInputG)

-- Define a variable to keep track of the time since the last emote playback for G
local lastEmoteTimeG = 0

-- Continuously play emotes while G key is held down
game:GetService("RunService").RenderStepped:Connect(function()
    local currentTime = tick()
    
    if isGKeyDown then
        -- Check if enough time has passed since the last emote playback
        if currentTime - lastEmoteTimeG >= 0.125 then
            lastEmoteTimeG = currentTime
            -- Example emote ID and name for hotkey G (replace this with your desired emote ID and name)
            local emoteIdG = 4689362868
            local emoteNameG = "CustomEmoteG"
            PlayEmote(emoteIdG, emoteNameG)
        end
    end
end)

local NotifyModule = {}

if not NotifyGui then
    getgenv().NotifyGui = Instance.new("ScreenGui")
    getgenv().Template = Instance.new("TextLabel")
    
    if syn then
        if gethui then
            gethui(NotifyGui)
        else
            syn.protect_gui(NotifyGui)
        end
    end
    
    NotifyGui.Name = "Notification"
    NotifyGui.Parent = CoreGui
    
    Template.Name = "Template"
    Template.Parent = NotifyGui
    Template.AnchorPoint = Vector2.new(.5, .5)
    Template.BackgroundTransparency = 1
    Template.BorderSizePixel = 0
    Template.Position = UDim2.new(.5, 0, 1.5, 0)
    Template.Size = UDim2.new(.8, 0, .1, 0)
    Template.Font = Enum.Font.Code
    Template.Text = ""
    Template.TextSize = 30
    Template.TextWrapped = true
end

local Tween = function(Object, Time, Style, Direction, Property)
    return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction]), Property)
end

function NotifyModule:Notify(Text, Duration)
    task.spawn(function()
        local Clone = Template:Clone()
        Clone.Name = "ClonedNotification"
        Clone.Parent = NotifyGui
        Clone.Text = Text
        Clone.TextColor3 = Color3.fromRGB(75, 121, 233)

        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = Clone
        UIStroke.Thickness = 1
        UIStroke.Transparency = 0.5
        
        if not Duration or Duration == nil then
    	    Duration = 5
        end
    	
        local FinalPosition = 0
        
        for _, x in next, NotifyGui:GetChildren() do
            if x.Name ~= "Template" then
                FinalPosition += .125
            end
        end
        
        local TweenPos = Tween(Clone, 1, "Quart", "InOut", {Position = UDim2.new(.5, 0, .95 - FinalPosition, 0)})
        TweenPos:Play()
        TweenPos.Completed:wait()
        
        wait(Duration)
        
        TweenPos = Tween(Clone, 1, "Quart", "InOut", {Position = UDim2.new(.5, 0, 1.5, 0)})
        TweenPos:Play()
        TweenPos.Completed:wait()
        
        Clone:Destroy()
    end)
end

NotifyModule:Notify("Skip's Touch has been executed. ► press G to touch", 5)
