-- [[ BLACKNODE-IX: BROOKHAVEN CONTROL HUB V19 (MOBILE FIX) ]] --
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lplr = Players.LocalPlayer
local PlayerGui = Lplr:WaitForChild("PlayerGui")

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

local function formatNum(v)
    return tostring(v):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local function ForceUpdateTopRightBalance()
    for _, node in ipairs(PlayerGui:GetDescendants()) do
        if node:IsA("TextLabel") and string.find(node.Text, "%$") then
            node.Text = "$ " .. formatNum(FakeBalance) 
        end
    end
end

-- Hàm tạo Master ScreenGui để chống lỗi Mobile
local function CreateMasterScreenGui(name)
    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999999 -- Ép đè lên trên tất cả mọi thứ
    sg.Parent = PlayerGui
    return sg
end

-- ==========================================
-- [UI: FAKE ROBLOX PURCHASE PROMPT]
-- ==========================================
local ShowRPInvitePrompt, ShowGiftSent, ShowCompletePrompt, ShowBuyPrompt

ShowGiftSent = function()
    local sg = CreateMasterScreenGui("FakeGiftSent")
    local Frame = Instance.new("Frame", sg)
    Frame.Size, Frame.BackgroundColor3 = UDim2.new(0, 160, 0, 42), Color3.fromRGB(255, 45, 130)
    Frame.AnchorPoint = Vector2.new(0.5, 1)
    Frame.Position = UDim2.new(0.5, 0, 1.2, 0) -- Ẩn ở dưới màn hình
    Frame.BorderSizePixel = 0
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0)

    local GiftImg = Instance.new("ImageLabel", Frame)
    GiftImg.Size, GiftImg.Position, GiftImg.Image, GiftImg.BackgroundTransparency = UDim2.new(0, 28, 0, 28), UDim2.new(0, 12, 0.5, 0), ASSETS.GiftIcon, 1
    GiftImg.AnchorPoint = Vector2.new(0, 0.5)

    local Text = Instance.new("TextLabel", Frame)
    Text.Size, Text.Position, Text.Text = UDim2.new(0, 0, 0, 20), UDim2.new(0, 48, 0.5, 0), "Premium sent!"
    Text.AnchorPoint, Text.AutomaticSize = Vector2.new(0, 0.5), Enum.AutomaticSize.X
    Text.TextColor3, Text.Font, Text.TextSize, Text.BackgroundTransparency = Color3.new(1, 1, 1), Enum.Font.GothamBold, 17, 1
    
    Text:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        Frame.Size = UDim2.new(0, Text.AbsoluteSize.X + 65, 0, 42)
    end)

    -- Sound effect
    pcall(function()
        local Sound = Instance.new("Sound", sg)
        Sound.SoundId = ASSETS.DonateSound
        Sound.Volume = 2
        Sound:Play()
    end)

    -- Hiện lên
    TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.OutBack), {Position = UDim2.new(0.5, 0, 0.9, -10)}):Play()
    
    -- Tự động mất đi
    task.delay(2.5, function()
        local t = TweenService:Create(Frame, TweenInfo.new(0.4), {Position = UDim2.new(0.5, 0, 1.2, 0)})
        t:Play()
        t.Completed:Connect(function() sg:Destroy() end)
    end)
end

ShowCompletePrompt = function(itemName, itemPrice)
    local sg = CreateMasterScreenGui("FakeComplete")
    local Main = Instance.new("Frame", sg)
    Main.Size, Main.BackgroundColor3 = UDim2.new(0, 320, 0, 200), Color3.fromRGB(35, 35, 40)
    Main.AnchorPoint, Main.Position = Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 50)
    Main.BackgroundTransparency = 1
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.OutQuad), {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0}):Play()

    local Check = Instance.new("ImageLabel", Main)
    Check.Size, Check.Position, Check.Image, Check.BackgroundTransparency = UDim2.new(0, 60, 0, 60), UDim2.new(0.5, 0, 0, 50), ASSETS.CheckIcon, 1
    Check.AnchorPoint = Vector2.new(0.5, 0)
    
    local Desc = Instance.new("TextLabel", Main)
    Desc.Text = "You have successfully bought\n" .. itemName
    Desc.Size, Desc.Position = UDim2.new(1, -20, 0, 40), UDim2.new(0.5, 0, 0, 125)
    Desc.AnchorPoint = Vector2.new(0.5, 0)
    Desc.TextColor3, Desc.Font, Desc.TextSize, Desc.BackgroundTransparency, Desc.TextWrapped = Color3.fromRGB(200, 200, 200), Enum.Font.Gotham, 14, 1, true

    local OkBtn = Instance.new("TextButton", Main)
    OkBtn.Size, OkBtn.Position, OkBtn.BackgroundColor3 = UDim2.new(1, -40, 0, 42), UDim2.new(0.5, 0, 1, -25)
    OkBtn.AnchorPoint = Vector2.new(0.5, 1)
    OkBtn.Text, OkBtn.Font, OkBtn.TextColor3, OkBtn.TextSize = "OK", Enum.Font.GothamBold, Color3.new(1, 1, 1), 16
    Instance.new("UICorner", OkBtn).CornerRadius = UDim.new(0, 8)

    OkBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
        FakeBalance = FakeBalance - itemPrice
        ForceUpdateTopRightBalance()
        ShowGiftSent()
    end)
end

ShowBuyPrompt = function()
    local sg = CreateMasterScreenGui("FakeBuyPrompt")
    
    -- Màn hình tối
    local Dark = Instance.new("TextButton", sg)
    Dark.Size, Dark.BackgroundColor3, Dark.BackgroundTransparency = UDim2.new(1, 0, 1, 0), Color3.new(0,0,0), 0.5
    Dark.Text = ""
    Dark.AutoButtonColor = false

    local Main = Instance.new("Frame", sg)
    Main.Size, Main.BackgroundColor3 = UDim2.new(0, 360, 0, 240), Color3.fromRGB(35, 35, 40)
    Main.AnchorPoint, Main.Position = Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 50)
    Main.BackgroundTransparency = 1
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    -- Click ngoài lề để đóng
    Dark.MouseButton1Click:Connect(function() sg:Destroy() end)

    -- Hiệu ứng bay lên
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.OutQuad), {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0}):Play()

    -- Nút X tắt
    local CloseBtn = Instance.new("TextButton", Main)
    CloseBtn.Size, CloseBtn.Position, CloseBtn.BackgroundTransparency = UDim2.new(0, 30, 0, 30), UDim2.new(1, -10, 0, 10), 1
    CloseBtn.AnchorPoint = Vector2.new(1, 0)
    CloseBtn.Text, CloseBtn.TextColor3, CloseBtn.Font, CloseBtn.TextSize = "X", Color3.fromRGB(150, 150, 150), Enum.Font.GothamBold, 18
    CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

    local Title = Instance.new("TextLabel", Main)
    Title.Size, Title.Position, Title.Text = UDim2.new(1, -40, 0, 30), UDim2.new(0, 20, 0, 10), "Buy item"
    Title.TextColor3, Title.Font, Title.TextSize, Title.TextXAlignment, Title.BackgroundTransparency = Color3.new(1, 1, 1), Enum.Font.GothamBold, 18, Enum.TextXAlignment.Left, 1

    local ItemImg = Instance.new("ImageLabel", Main)
    ItemImg.Size, ItemImg.Position, ItemImg.BackgroundColor3 = UDim2.new(0, 60, 0, 60), UDim2.new(0, 20, 0, 55), Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", ItemImg).CornerRadius = UDim.new(0, 8)

    local NameLabel = Instance.new("TextLabel", Main)
    NameLabel.Position, NameLabel.Size = UDim2.new(0, 95, 0, 60), UDim2.new(1, -115, 0, 30)
    NameLabel.TextColor3, NameLabel.Font, NameLabel.TextSize, NameLabel.TextXAlignment, NameLabel.BackgroundTransparency, NameLabel.TextWrapped = Color3.new(1,1,1), Enum.Font.GothamMedium, 16, Enum.TextXAlignment.Left, 1, true

    local PriceIcon = Instance.new("ImageLabel", Main)
    PriceIcon.Size, PriceIcon.Position, PriceIcon.Image, PriceIcon.BackgroundTransparency = UDim2.new(0, 16, 0, 16), UDim2.new(0, 95, 0, 95), ASSETS.RobuxIcon, 1

    local PriceLabel = Instance.new("TextLabel", Main)
    PriceLabel.Position, PriceLabel.Size = UDim2.new(0, 115, 0, 93), UDim2.new(0, 100, 0, 20)
    PriceLabel.TextColor3, PriceLabel.Font, PriceLabel.TextSize, PriceLabel.TextXAlignment, PriceLabel.BackgroundTransparency = Color3.new(1,1,1), Enum.Font.GothamBold, 16, Enum.TextXAlignment.Left, 1
    
    local TargetData = BH_PASSES[CurrentPassIndex]
    
    -- Load Data (Tải thông tin thật từ Roblox)
    NameLabel.Text = TargetData.Name
    PriceLabel.Text = formatNum(TargetData.Price)
    task.spawn(function()
        pcall(function()
            local info = MarketplaceService:GetProductInfo(TargetData.Id, Enum.InfoType.GamePass)
            NameLabel.Text = info.Name or TargetData.Name
            PriceLabel.Text = formatNum(info.PriceInRobux or TargetData.Price)
            ItemImg.Image = "rbxassetid://"..(info.IconImageAssetId or 0)
        end)
    end)

    local BuyBtnHolder = Instance.new("Frame", Main)
    BuyBtnHolder.Size, BuyBtnHolder.Position, BuyBtnHolder.BackgroundColor3, BuyBtnHolder.ClipsDescendants = UDim2.new(1, -40, 0, 42), UDim2.new(0.5, 0, 1, -25), Color3.fromRGB(45, 90, 200), true
    BuyBtnHolder.AnchorPoint = Vector2.new(0.5, 1)
    Instance.new("UICorner", BuyBtnHolder).CornerRadius = UDim.new(0, 8)

    local LoadingBar = Instance.new("Frame", BuyBtnHolder)
    LoadingBar.Size, LoadingBar.BackgroundColor3, LoadingBar.BorderSizePixel, LoadingBar.ZIndex = UDim2.new(0, 0, 1, 0), Color3.fromRGB(0, 200, 255), 0, 1
    Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(0, 8)

    local BuyBtn = Instance.new("TextButton", BuyBtnHolder)
    BuyBtn.Size, BuyBtn.BackgroundTransparency, BuyBtn.Text, BuyBtn.ZIndex = UDim2.fromScale(1, 1), 1, "Buy", 2
    BuyBtn.Font, BuyBtn.TextColor3, BuyBtn.TextSize = Enum.Font.GothamBold, Color3.new(1, 1, 1), 16

    BuyBtn.MouseButton1Click:Connect(function()
        if not BuyBtn.Active then return end
        BuyBtn.Active = false
        Dark.Active = false -- Khóa tắt background
        CloseBtn.Visible = false
        TweenService:Create(BuyBtnHolder, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
        local loadAnim = TweenService:Create(LoadingBar, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
        loadAnim:Play()
        loadAnim.Completed:Connect(function()
            sg:Destroy()
            ShowCompletePrompt(NameLabel.Text, TargetData.Price)
        end)
    end)
end

-- ==========================================
-- [UI: BẢNG ĐIỀU KHIỂN (CONTROL HUB)]
-- ==========================================
local function SetupControlHub()
    local sg = CreateMasterScreenGui("BlackNodeHub_Mobile")

    local ToggleBtn = Instance.new("ImageButton", sg)
    ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 30, 0, 30), UDim2.new(0, 10, 0.5, 0)
    ToggleBtn.Image, ToggleBtn.BackgroundTransparency = ASSETS.HubIcon, 1
    ToggleBtn.ImageColor3 = Color3.fromRGB(0, 255, 255)

    local Hub = Instance.new("Frame", sg)
    Hub.Size, Hub.Position, Hub.BackgroundColor3 = UDim2.new(0, 220, 0, 225), UDim2.new(0, 50, 0.5, -112), Color3.fromRGB(25, 25, 30)
    Hub.Visible = true -- Tự động bật lên khi chạy script
    Instance.new("UICorner", Hub).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", Hub)
    Title.Size, Title.Position, Title.Text = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), "⚡ FAKE HUB (MOBILE)"
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
    PassBtn.Text = "Chọn Gói: " .. BH_PASSES[CurrentPassIndex].Name
    PassBtn.Font, PassBtn.TextColor3, PassBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 11
    Instance.new("UICorner", PassBtn).CornerRadius = UDim.new(0, 6)

    PassBtn.MouseButton1Click:Connect(function()
        CurrentPassIndex = CurrentPassIndex + 1
        if CurrentPassIndex > #BH_PASSES then CurrentPassIndex = 1 end
        PassBtn.Text = "Chọn Gói: " .. BH_PASSES[CurrentPassIndex].Name
    end)

    -- [NÚT KÍCH HOẠT CHÍNH]
    local OpenUIBtn = Instance.new("TextButton", Hub)
    OpenUIBtn.Size, OpenUIBtn.Position, OpenUIBtn.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 130), Color3.fromRGB(0, 200, 100)
    OpenUIBtn.Text = "MỞ BẢNG MUA (QUAY VIDEO)"
    OpenUIBtn.Font, OpenUIBtn.TextColor3, OpenUIBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 11
    Instance.new("UICorner", OpenUIBtn).CornerRadius = UDim.new(0, 6)

    OpenUIBtn.MouseButton1Click:Connect(function()
        Hub.Visible = false 
        ShowBuyPrompt() 
    end)

    local HideBtn = Instance.new("TextButton", Hub)
    HideBtn.Size, HideBtn.Position, HideBtn.BackgroundColor3 = UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 175), Color3.fromRGB(200, 50, 50)
    HideBtn.Text = "ẨN MENU NÀY"
    HideBtn.Font, HideBtn.TextColor3, HideBtn.TextSize = Enum.Font.GothamBold, Color3.new(1,1,1), 12
    Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0, 6)

    ToggleBtn.MouseButton1Click:Connect(function() Hub.Visible = not Hub.Visible end)
    HideBtn.MouseButton1Click:Connect(function() Hub.Visible = false end)
end

-- [BẮT ĐẦU]
SetupControlHub()
ForceUpdateTopRightBalance()
