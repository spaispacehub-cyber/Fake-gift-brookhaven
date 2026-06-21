-- [[ BLACKNODE-IX: BROOKHAVEN CONTROL HUB V18.5 (HOTFIX) ]] --
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lplr = Players.LocalPlayer

-- [Bảo vệ chống lỗi CoreGui trên một số Executor]
local TargetGui = (pcall(function() return CoreGui.Name end) and CoreGui) or Lplr:WaitForChild("PlayerGui")

local ASSETS = {
    RobuxIcon = "rbxassetid://76631276896698",
    CloseIcon = "rbxassetid://119991987426838",
    CheckIcon = "rbxassetid://70875129327445",
    GiftIcon = "rbxassetid://126641461281688", 
    DonateSound = "rbxassetid://125014487420556",
    RPlusIcon = "rbxassetid://134073372134212", 
    DummyAvatar = "rbxassetid://10604313439",
    HubIcon = "rbxassetid://10882439086"
}

-- [DANH SÁCH GAMEPASS BROOKHAVEN]
local BH_PASSES = {
    {Name = "Brookhaven Premium 🏡", Id = 13481262, Price = 275},
    {Name = "Estates 🏰", Id = 15307373, Price = 799},
    {Name = "Unlocked Vehicles 🚘", Id = 14352134, Price = 799},
    {Name = "Vehicle Pack 🏎️", Id = 14811090, Price = 799},
    {Name = "Face Unlock 😊", Id = 13481265, Price = 199},
    {Name = "Music Unlocked 🎵", Id = 13481267, Price = 150}
}

local CurrentPassIndex = 1
local FakeBalance = 2096352
local ShowBuyPrompt -- Khai báo trước để Hub có thể gọi

local function formatNum(v)
    return tostring(v):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local function ForceUpdateTopRightBalance()
    local PlayerGui = Lplr:WaitForChild("PlayerGui")
    for _, node in ipairs(PlayerGui:GetDescendants()) do
        if node:IsA("TextLabel") and string.find(node.Text, "%$") then
            node.Text = "$ " .. formatNum(FakeBalance) 
        end
    end
end

-- ==========================================
-- [HỆ THỐNG GIAO DIỆN MUA HÀNG (CORE)]
-- ==========================================
local function CreateHeader(parent, titleText)
    local HeaderTitle = Instance.new("TextLabel", parent)
    HeaderTitle.Size, HeaderTitle.Position, HeaderTitle.Text = UDim2.new(0, 250, 0, 35), UDim2.new(0, 15, 0, 5), titleText
    HeaderTitle.TextColor3, HeaderTitle.Font, HeaderTitle.TextSize, HeaderTitle.TextXAlignment, HeaderTitle.BackgroundTransparency = Color3.new(1, 1, 1), Enum.Font.GothamBold, 16, Enum.TextXAlignment.Left, 1

    local HeaderRight = Instance.new("Frame", parent)
    HeaderRight.Size, HeaderRight.Position, HeaderRight.AnchorPoint, HeaderRight.BackgroundTransparency = UDim2.new(0, 180, 0, 35), UDim2.new(1, -15, 0, 5), Vector2.new(1, 0), 1

    local CloseBtn = Instance.new("ImageButton", HeaderRight)
    CloseBtn.Size, CloseBtn.Position, CloseBtn.AnchorPoint = UDim2.new(0, 16, 0, 16), UDim2.new(1, 0, 0.5, 0), Vector2.new(1, 0.5)
    CloseBtn.Image, CloseBtn.BackgroundTransparency, CloseBtn.ImageColor3 = ASSETS.CloseIcon, 1, Color3.fromRGB(180, 180, 180) 
    return CloseBtn
end

local function ApplyFloatUp(frame, targetYOffset)
    frame.Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 0.5, 20)
    frame.BackgroundTransparency = 1
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.OutQuad), {
        Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 0.5, targetYOffset),
        BackgroundTransparency = 0
    }):Play()
end

local function ShowGiftSent()
    local ScreenGui = Instance.new("ScreenGui", TargetGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size, Frame.Position, Frame.BackgroundColor3 = UDim2.new(0, 160, 0, 42), UDim2.new(0.5, -80, 1, 50), Color3.fromRGB(255, 45, 130)
    Frame.BorderSizePixel = 0
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0)

    local GiftImg = Instance.new("ImageLabel", Frame)
    GiftImg.Size, GiftImg.Position, GiftImg.Image, GiftImg.BackgroundTransparency = UDim2.new(0, 28, 0, 28), UDim2.new(0, 12, 0.5, 0), ASSETS.GiftIcon, 1
    GiftImg.AnchorPoint, GiftImg.ZIndex = Vector2.new(0, 0.5), 5

    local Text = Instance.new("TextLabel", Frame)
    Text.Size, Text.Position, Text.Text = UDim2.new(0, 0, 0, 20), UDim2.new(0, 48, 0.5, 0), "Premium sent!"
    Text.AnchorPoint, Text.AutomaticSize = Vector2.new(0, 0.5), Enum.AutomaticSize.X
    Text.TextColor3, Text.Font, Text.TextSize, Text.BackgroundTransparency = Color3.new(1, 1, 1), Enum.Font.GothamBold, 17, 1
    
    Text:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        Frame.Size = UDim2.new(0, Text.AbsoluteSize.X + 65, 0, 42)
        Frame.Position = UDim2.new(0.5, -Frame.AbsoluteSize.X/2, Frame.Position.Y.Scale, Frame.Position.Y.Offset)
    end)

    local Sound = Instance.new("Sound", TargetGui)
    Sound.SoundId, Sound.Volume = ASSETS.DonateSound, 2
    Sound:Play()

    TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.OutBack), {Position = UDim2.new(0.5, -Frame.AbsoluteSize.X/2, 0.45, 0)}):Play()
    task.delay(2.2, function()
        local t = TweenService:Create(Frame, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -Frame.AbsoluteSize.X/2, 1, 50), BackgroundTransparency = 1})
        t:Play()
        t.Completed:Connect(function() ScreenGui:Destroy() end)
    end)
end

local function ShowRPInvitePrompt()
    local ScreenGui = Instance.new("ScreenGui", TargetGui)
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size, Main.BackgroundColor3 = UDim2.new(0, 440, 0, 220), Color3.fromRGB(35, 35, 40)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    ApplyFloatUp(Main, -110)

    local Close = CreateHeader(Main, "Message Recipient")
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Subtitle = Instance.new("TextLabel", Main)
    Subtitle.Text, Subtitle.Size, Subtitle.Position = "Tell them to spawn a house and check it!", UDim2.new(1, -40, 0, 30), UDim2.new(0, 20, 0, 50)
    Subtitle.TextColor3, Subtitle.Font, Subtitle.TextSize, Subtitle.TextXAlignment, Subtitle.BackgroundTransparency = Color3.fromRGB(200, 200, 200), Enum.Font.Gotham, 14, Enum.TextXAlignment.Left, 1

    local Avatar = Instance.new("ImageLabel", Main)
    Avatar.Size, Avatar.Position, Avatar.Image, Avatar.BackgroundTransparency = UDim2.new(0, 60, 0, 60), UDim2.new(0, 20, 0, 90), ASSETS.DummyAvatar, 1

    local TextBox = Instance.new("TextBox", Main)
    TextBox.Size, TextBox.Position, TextBox.BackgroundColor3 = UDim2.new(1, -110, 0, 50), UDim2.new(0, 95, 0, 95), Color3.fromRGB(25, 25, 28)
    TextBox.Text, TextBox.PlaceholderText, TextBox.TextColor3, TextBox.Font, TextBox.TextSize = "", "Nhắn tin: Ra check nhà coi...", Color3.new(1, 1, 1), Enum.Font.Gotham, 14
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

    local SendBtn = Instance.new("TextButton", Main)
    SendBtn.Size, SendBtn.Position, SendBtn.BackgroundColor3 = UDim2.new(0, 120, 0, 40), UDim2.new(1, -140, 1, -55), Color3.fromRGB(60, 120, 255)
    SendBtn.Text, SendBtn.Font, SendBtn.TextColor3, SendBtn.TextSize = "Gửi", Enum.Font.GothamBold, Color3.new(1, 1, 1), 15
    Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 6)

    SendBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
end

local function ShowCompletePrompt(itemName, itemPrice)
    local ScreenGui = Instance.new("ScreenGui", TargetGui)
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size, Main.BackgroundColor3 = UDim2.new(0, 440, 0, 220), Color3.fromRGB(35, 35, 40)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    ApplyFloatUp(Main, -110)

    local Close = CreateHeader(Main, "Gift completed")
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    local Check = Instance.new("ImageLabel", Main)
    Check.Size, Check.Position, Check.Image, Check.BackgroundTransparency = UDim2.new(0, 70, 0, 70), UDim2.new(0.5, -35, 0, 50), ASSETS.CheckIcon, 1
    
    local Desc = Instance.new("TextLabel", Main)
    Desc.Text, Desc.Size, Desc.Position = 'You have successfully gifted "'..itemName..'".', UDim2.new(1, -60, 0, 40), UDim2.new(0, 30, 0, 125)
    Desc.TextColor3, Desc.Font, Desc.TextSize, Desc.BackgroundTransparency, Desc.TextWrapped = Color3.fromRGB(200, 200, 200), Enum.Font.Gotham, 15, 1, true

    local OkBtn = Instance.new("TextButton", Main)
    OkBtn.Size, OkBtn.Position, OkBtn.BackgroundColor3 = UDim2.new(1, -40, 0, 42), UDim2.new(0, 20, 1, -55), Color3.fromRGB(60, 120, 255)
    OkBtn.Text, OkBtn.Font, OkBtn.TextColor3, OkBtn.TextSize = "Tuyệt vời", Enum.Font.GothamBold, Color3.new(1, 1, 1), 17
    Instance.new("UICorner", OkBtn).CornerRadius = UDim.new(0, 8)

    OkBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        FakeBalance = FakeBalance - itemPrice
        ForceUpdateTopRightBalance()
        ShowGiftSent()
        task.wait(1)
        ShowRPInvitePrompt()
    end)
end

-- [ĐỊNH NGHĨA HÀM SHOW MUA HÀNG]
ShowBuyPrompt = function()
    local ScreenGui = Instance.new("ScreenGui", TargetGui)
    local Dark = Instance.new("Frame", ScreenGui)
    Dark.Size, Dark.BackgroundColor3, Dark.BackgroundTransparency, Dark.Position = UDim2.fromScale(2, 2), Color3.new(0,0,0), 0.4, UDim2.fromScale(-0.5, -0.5)

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size, Main.BackgroundColor3 = UDim2.new(0, 440, 0, 240), Color3.fromRGB(35, 35, 40)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    ApplyFloatUp(Main, -120)

    local Close = CreateHeader(Main, "Gift item")
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local ItemImg = Instance.new("ImageLabel", Main)
    ItemImg.Size, ItemImg.Position, ItemImg.BackgroundColor3 = UDim2.new(0, 75, 0, 75), UDim2.new(0, 25, 0, 50), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", ItemImg).CornerRadius = UDim.new(0, 8)

    local NameLabel = Instance.new("TextLabel", Main)
    NameLabel.Position, NameLabel.Size = UDim2.new(0, 115, 0, 50), UDim2.new(0, 310, 0, 30)
    NameLabel.TextColor3, NameLabel.Font, NameLabel.TextSize, NameLabel.TextXAlignment, NameLabel.BackgroundTransparency, NameLabel.TextWrapped = Color3.new(1,1,1), Enum.Font.GothamBold, 17, Enum.TextXAlignment.Left, 1, true

    local PriceLabel = Instance.new("TextLabel", Main)
    PriceLabel.Position, PriceLabel.Size = UDim2.new(0, 140, 0, 80), UDim2.new(0, 100, 0, 20)
    PriceLabel.TextColor3, PriceLabel.Font, PriceLabel.TextSize, PriceLabel.TextXAlignment, PriceLabel.BackgroundTransparency = Color3.new(1,1,1), Enum.Font.GothamMedium, 15, Enum.TextXAlignment.Left, 1
    
    local PriceIcon = Instance.new("ImageLabel", Main)
    PriceIcon.Size, PriceIcon.Position, PriceIcon.Image, PriceIcon.BackgroundTransparency = UDim2.new(0, 16, 0, 16), UDim2.new(0, 115, 0, 82), ASSETS.RobuxIcon, 1

    local TargetData = BH_PASSES[CurrentPassIndex]
    task.spawn(function()
        pcall(function()
            local info = MarketplaceService:GetProductInfo(TargetData.Id, Enum.InfoType.GamePass)
            NameLabel.Text = info.Name or TargetData.Name
            PriceLabel.Text = formatNum(info.PriceInRobux or TargetData.Price)
            ItemImg.Image = "rbxassetid://"..(info.IconImageAssetId or 0)
        end)
    end)

    local RPlusBanner = Instance.new("Frame", Main)
    RPlusBanner.Size, RPlusBanner.Position = UDim2.new(1, -40, 0, 42), UDim2.new(0, 20, 1, -105)
    RPlusBanner.BackgroundColor3, RPlusBanner.BorderColor3, RPlusBanner.BorderSizePixel = Color3.fromRGB(30, 30, 35), Color3.fromRGB(55, 55, 60), 1
    Instance.new("UICorner", RPlusBanner).CornerRadius = UDim.new(0, 8)

    local RPlusIcon = Instance.new("ImageLabel", RPlusBanner)
    RPlusIcon.Size, RPlusIcon.Position, RPlusIcon.AnchorPoint, RPlusIcon.Image, RPlusIcon.BackgroundTransparency = UDim2.new(0, 20, 0, 20), UDim2.new(0, 10, 0.5, 0), Vector2.new(0, 0.5), ASSETS.RPlusIcon, 1

    local RPlusText = Instance.new("TextLabel", RPlusBanner)
    RPlusText.Text, RPlusText.Size, RPlusText.Position = "Get 10% off with Roblox Plus", UDim2.new(0, 200, 1, 0), UDim2.new(0, 38, 0, 0)
    RPlusText.TextColor3, RPlusText.Font, RPlusText.TextSize, RPlusText.TextXAlignment, RPlusText.BackgroundTransparency = Color3.fromRGB(200, 200, 200), Enum.Font.Gotham, 13, Enum.TextXAlignment.Left, 1

    local BuyBtnHolder = Instance.new("Frame", Main)
    BuyBtnHolder.Size, BuyBtnHolder.Position, BuyBtnHolder.BackgroundColor3, BuyBtnHolder.ClipsDescendants = UDim2.new(1, -40, 0, 42), UDim2.new(0, 20, 1, -55), Color3.fromRGB(45, 90, 200), true
    Instance.new("UICorner", BuyBtnHolder).CornerRadius = UDim.new(0, 8)

    local LoadingBar = Instance.new("Frame", BuyBtnHolder)
    LoadingBar.Size, LoadingBar.BackgroundColor3, LoadingBar.BorderSizePixel, LoadingBar.ZIndex = UDim2.new(0, 0, 1, 0), Color3.fromRGB(0, 255, 255), 0, 1
    Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(0, 8)

    local BuyBtn = Instance.new("TextButton", BuyBtnHolder)
    BuyBtn.Size, BuyBtn.BackgroundTransparency, BuyBtn.Text, BuyBtn.ZIndex = UDim2.fromScale(1, 1), 1, "Gift Pass", 2
    BuyBtn.Font, BuyBtn.TextColor3, BuyBtn.TextSize = Enum.Font.GothamBold, Color3.new(1, 1, 1), 17

    BuyBtn.MouseButton1Click:Connect(function()
        if not BuyBtn.Active then return end
        BuyBtn.Active = false
        TweenService:Create(BuyBtnHolder, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
        local loadAnim = TweenService:Create(LoadingBar, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
        loadAnim:Play()
        loadAnim.Completed:Connect(function()
            ScreenGui:Destroy()
            ShowCompletePrompt(NameLabel.Text, TargetData.Price)
        end)
    end)
end

-- ==========================================
-- [UI: BẢNG ĐIỀU KHIỂN (CONTROL HUB)]
-- ==========================================
local function SetupControlHub()
    local ScreenGui = Instance.new("ScreenGui", TargetGui)
    ScreenGui.Name = "BlackNodeHub"

    local ToggleBtn = Instance.new("ImageButton", ScreenGui)
    ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 30, 0, 30), UDim2.new(0, 10, 0.5, 0)
    ToggleBtn.Image, ToggleBtn.BackgroundTransparency = ASSETS.HubIcon, 1
    ToggleBtn.ImageColor3 = Color3.fromRGB(0, 255, 255)

    local Hub = Instance.new("Frame", ScreenGui)
    Hub.Size, Hub.Position, Hub.BackgroundColor3 = UDim2.new(0, 220, 0, 225), UDim2.new(0, 50, 0.5, -112), Color3.fromRGB(25, 25, 30)
    Hub.Visible = false
    Instance.new("UICorner", Hub).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", Hub)
    Title.Size, Title.Position, Title.Text = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), "⚡ DIRECTOR PANEL"
    Title.Font, Title.TextColor3, Title.TextSize, Title.BackgroundTransparency = Enum.Font.GothamBold, Color3.fromRGB(0, 255, 255), 14, 1

    local BalInput = Instance.new("TextBox", Hub)
    BalInput.Size, BalInput.Position, BalInput.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 40), Color3.fromRGB(15, 15, 20)
    BalInput.Text, BalInput.PlaceholderText, BalInput.TextColor3 = tostring(FakeBalance), "Nhập số Robux...", Color3.new(1,1,1)
    BalInput.Font, BalInput.TextSize = Enum.Font.Gotham, 14
    Instance.new("UICorner", BalInput).CornerRadius = UDim.new(0, 6)

    BalInput.FocusLost:Connect(function()
        local num = tonumber(BalInput.Text)
        if num then 
            FakeBalance = num 
            ForceUpdateTopRightBalance()
        else
            BalInput.Text = tostring(FakeBalance)
        end
    end)

    local PassBtn = Instance.new("TextButton", Hub)
    PassBtn.Size, PassBtn.Position, PassBtn.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 85), Color3.fromRGB(45, 90, 200)
    PassBtn.Text = "Target: " .. BH_PASSES[CurrentPassIndex].Name
    PassBtn.Font, PassBtn.TextColor3, PassBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 12
    Instance.new("UICorner", PassBtn).CornerRadius = UDim.new(0, 6)

    PassBtn.MouseButton1Click:Connect(function()
        CurrentPassIndex = CurrentPassIndex + 1
        if CurrentPassIndex > #BH_PASSES then CurrentPassIndex = 1 end
        PassBtn.Text = "Target: " .. BH_PASSES[CurrentPassIndex].Name
    end)

    -- [NÚT FIX LỖI: HIỂN THỊ TRỰC TIẾP UI MUA HÀNG]
    local OpenUIBtn = Instance.new("TextButton", Hub)
    OpenUIBtn.Size, OpenUIBtn.Position, OpenUIBtn.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 130), Color3.fromRGB(0, 200, 100)
    OpenUIBtn.Text = "MỞ UI MUA HÀNG"
    OpenUIBtn.Font, OpenUIBtn.TextColor3, OpenUIBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 13
    Instance.new("UICorner", OpenUIBtn).CornerRadius = UDim.new(0, 6)

    OpenUIBtn.MouseButton1Click:Connect(function()
        Hub.Visible = false -- Tự động ẩn Hub để bắt đầu diễn
        ShowBuyPrompt() -- Gọi thẳng UI không cần thông qua game
    end)

    local HideBtn = Instance.new("TextButton", Hub)
    HideBtn.Size, HideBtn.Position, HideBtn.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 175), Color3.fromRGB(200, 50, 50)
    HideBtn.Text = "ẨN MENU NÀY"
    HideBtn.Font, HideBtn.TextColor3, HideBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 12
    Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0, 6)

    ToggleBtn.MouseButton1Click:Connect(function() Hub.Visible = not Hub.Visible end)
    HideBtn.MouseButton1Click:Connect(function() Hub.Visible = false end)
end

-- [KHỞI ĐỘNG HỆ THỐNG]
SetupControlHub()
ForceUpdateTopRightBalance()
