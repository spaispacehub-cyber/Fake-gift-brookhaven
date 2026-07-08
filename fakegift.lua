--[[
SPAISPACEHUBZZZ fake gift v9 (Restored BUY Button, Absolute Real UI Blocker)
--]]

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService   = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui   = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  HỆ THỐNG KHÓA UI MUA THẬT CỦA ROBLOX (BẢO VỆ ROBUX)
-- ============================================================
pcall(function()
    if hookfunction then
        hookfunction(MarketplaceService.PromptGamePassPurchase, function() return end)
        hookfunction(MarketplaceService.PromptPurchase, function() return end)
        hookfunction(MarketplaceService.PromptProductPurchase, function() return end)
    end
end)

-- ============================================================
--  CONFIG & NEW IDs
-- ============================================================
local Config = {
    FakeBalance   = 5000000,
    BuyAccent     = Color3.fromRGB(38, 98, 245),
    BuyAccentDark = Color3.fromRGB(26, 51, 127),
    BgDark        = Color3.fromRGB(21, 23, 26),
    BgMid         = Color3.fromRGB(16, 17, 20),
    BgLight       = Color3.fromRGB(42, 45, 51),
    TextMain      = Color3.fromRGB(255, 255, 255),
    TextSub       = Color3.fromRGB(170, 173, 180),
    BuyDelay      = 3,
}

local CHECKMARK_ID   = "rbxthumb://type=Asset&id=17829956139&w=150&h=150"
local ROBUX_ID       = "rbxthumb://type=Asset&id=11560341145&w=150&h=150"
local CLOSE_X_ID     = "rbxthumb://type=Asset&id=4988112413&w=150&h=150"
local ROBLOX_PLUS_ID = "rbxthumb://type=Asset&id=138882818765521&w=150&h=150"

local FONTS = {
    Main = Enum.Font.BuilderSans,
    Bold = Enum.Font.BuilderSansBold,
    Num  = Enum.Font.GothamBold,
}

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
}

local function stroke(p, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color        = col   or Color3.new(1,1,1)
    s.Thickness    = thick or 1.5
    s.Transparency = trans or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

-- ============================================================
--  MÀN HÌNH LOADING SPACE NEON
-- ============================================================
local function playInitLoading()
    local loadGui = Instance.new("ScreenGui")
    loadGui.Name = "SpacehubCyberLoad"
    loadGui.DisplayOrder = 10000
    loadGui.IgnoreGuiInset = true
    loadGui.Parent = playerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(6, 6, 12)
    bg.BorderSizePixel = 0
    bg.Parent = loadGui

    local grid = Instance.new("ImageLabel")
    grid.Size = UDim2.fromScale(1, 1)
    grid.BackgroundTransparency = 1
    grid.Image = "rbxassetid://103440133252868"
    grid.ImageTransparency = 0.94
    grid.ImageColor3 = Color3.fromRGB(0, 240, 255)
    grid.Parent = bg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0.43, -50)
    title.AnchorPoint = Vector2.new(0, 0.5)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 56
    title.TextColor3 = Color3.fromRGB(0, 240, 255)
    title.Text = "SPACE HUB"
    title.Parent = bg
    
    local tGlow = Instance.new("UIStroke")
    tGlow.Color = Color3.fromRGB(255, 0, 160)
    tGlow.Thickness = 2.5
    tGlow.Parent = title

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 24)
    sub.Position = UDim2.new(0, 0, 0.43, 15)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Code
    sub.TextSize = 13
    sub.TextColor3 = Color3.fromRGB(140, 150, 190)
    sub.Text = "SYSTEM INITIALIZING..."
    sub.Parent = bg

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.fromOffset(420, 6)
    barBg.Position = UDim2.new(0.5, 0, 0.43, 55)
    barBg.AnchorPoint = Vector2.new(0.5, 0.5)
    barBg.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
    barBg.BorderSizePixel = 0
    barBg.Parent = bg
    corner(barBg, 3)
    stroke(barBg, Color3.fromRGB(0, 240, 255), 1, 0.6)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.fromScale(0, 1)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    corner(barFill, 3)
    
    local barGlow = Instance.new("UIStroke")
    barGlow.Color = Color3.fromRGB(255, 0, 160)
    barGlow.Thickness = 1.5
    barGlow.Parent = barFill

    local pct = Instance.new("TextLabel")
    pct.Size = UDim2.fromOffset(100, 30)
    pct.Position = UDim2.new(0.5, 0, 0.43, 85)
    pct.AnchorPoint = Vector2.new(0.5, 0.5)
    pct.BackgroundTransparency = 1
    pct.Font = Enum.Font.GothamBlack
    pct.TextSize = 20
    pct.TextColor3 = Color3.fromRGB(255, 255, 255)
    pct.Text = "0%"
    pct.Parent = bg

    local skipBtn = Instance.new("TextButton")
    skipBtn.Size = UDim2.fromOffset(110, 34)
    skipBtn.Position = UDim2.new(0.5, 0, 0.43, 140)
    skipBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    skipBtn.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
    skipBtn.Font = Enum.Font.GothamBold
    skipBtn.TextSize = 13
    skipBtn.TextColor3 = Color3.fromRGB(255, 0, 160)
    skipBtn.Text = "SKIP PROTOCOL"
    skipBtn.AutoButtonColor = false
    skipBtn.Parent = bg
    corner(skipBtn, 6)
    local sStrk = stroke(skipBtn, Color3.fromRGB(255, 0, 160), 1.5, 0.2)

    skipBtn.MouseEnter:Connect(function()
        TweenService:Create(skipBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 160), TextColor3 = Color3.new(1,1,1)}):Play()
    end)
    skipBtn.MouseLeave:Connect(function()
        TweenService:Create(skipBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(14, 12, 24), TextColor3 = Color3.fromRGB(255, 0, 160)}):Play()
    end)

    local isSkipped = false
    skipBtn.MouseButton1Click:Connect(function()
        isSkipped = true
    end)

    task.spawn(function()
        while loadGui.Parent and not isSkipped do
            TweenService:Create(tGlow, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0, 240, 255)}):Play()
            task.wait(1)
            TweenService:Create(tGlow, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(255, 0, 160)}):Play()
            task.wait(1)
        end
    end)

    local duration = 2
    local elapsed = 0
    while elapsed < duration and not isSkipped do
        task.wait(0.1)
        elapsed = elapsed + 0.1
        local ratio = math.min(elapsed / duration, 1)
        
        TweenService:Create(barFill, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(ratio, 1)}):Play()
        pct.Text = tostring(math.floor(ratio * 100)) .. "%"
    end

    TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    for _, child in ipairs(bg:GetChildren()) do
        pcall(function()
            if child:IsA("TextLabel") or child:IsA("Frame") or child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            end
        end)
    end
    task.wait(0.4)
    loadGui:Destroy()
end

task.spawn(playInitLoading)

-- ============================================================
--  FRUIT & GAMEPASS DATABASE
-- ============================================================
local BLOX_LOGO = "rbxassetid://2804185542"

local Fruits = {
    {name="Bomb",    id=44669609, price=220,  icon="rbxthumb://type=Asset&id=72369528696047&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spike",   id=44669616, price=380,  icon="rbxthumb://type=Asset&id=131167693319825&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="blade",   id=44669618, price=100,  icon="rbxthumb://type=Asset&id=116884668999743&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spring",  id=44669621, price=180,  icon="rbxthumb://type=Asset&id=131259631046573&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="rocket",  id=44669613, price=50,   icon="rbxthumb://type=Asset&id=138286042637253&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Smoke",   id=44669624, price=250,  icon="rbxthumb://type=Asset&id=82043762754488&w=150&h=150", outline=Color3.fromRGB(180,180,180) },
    {name="Spin",    id=44669628, price=75,   icon="rbxthumb://type=Asset&id=132896972664540&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Flame",   id=44669633, price=550,  icon="rbxthumb://type=Asset&id=108831553026356&w=150&h=150", outline=Color3.fromRGB(220,80,20)   },
    {name="Ice",     id=44669637, price=750,  icon="rbxthumb://type=Asset&id=74875972194260&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Sand",    id=44669641, price=850,  icon="rbxthumb://type=Asset&id=106977568354230&w=150&h=150", outline=Color3.fromRGB(200,170,80)  },
    {name="Dark",    id=44669644, price=950,  icon="rbxthumb://type=Asset&id=102350616725604&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Diamond", id=44669648, price=1000, icon="rbxthumb://type=Asset&id=73956493227615&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Light",   id=44669651, price=1100, icon="rbxthumb://type=Asset&id=82087340639683&w=150&h=150", outline=Color3.fromRGB(240,220,100) },
    {name="Rubber",  id=44669655, price=1200, icon="rbxthumb://type=Asset&id=130679323833459&w=150&h=150", outline=Color3.fromRGB(220,60,60)   },
    {name="Creation",id=44669659, price=1750, icon="rbxthumb://type=Asset&id=95414926547178&w=150&h=150", outline=Color3.fromRGB(180,180,220) },
    {name="Magma",   id=44669663, price=1300, icon="rbxthumb://type=Asset&id=127157664640262&w=150&h=150", outline=Color3.fromRGB(200,60,20)},
    {name="Quake",   id=44669668, price=1500, icon="rbxthumb://type=Asset&id=122826264224872&w=150&h=150", outline=Color3.fromRGB(160,140,100) },
    {name="Buddha",  id=44669672, price=1650, icon="rbxthumb://type=Asset&id=109883576360269&w=150&h=150", outline=Color3.fromRGB(220,180,20) },
    {name="Love",    id=44669676, price=1700, icon="rbxthumb://type=Asset&id=113290491848534&w=150&h=150", outline=Color3.fromRGB(255,100,160) },
    {name="Spider",  id=44669679, price=1800, icon="rbxthumb://type=Asset&id=76759665031963&w=150&h=150", outline=Color3.fromRGB(60,60,60)    },
    {name="Sound",   id=44669683, price=1900, icon="rbxthumb://type=Asset&id=83607585966959&w=150&h=150", outline=Color3.fromRGB(180,100,220) },
    {name="Phoenix", id=44669687, price=2100, icon="rbxthumb://type=Asset&id=74573221561916&w=150&h=150", outline=Color3.fromRGB(220,120,20)  },
    {name="Portal",  id=44669691, price=2000, icon="rbxthumb://type=Asset&id=94551022243633&w=150&h=150", outline=Color3.fromRGB(100,180,255) },
    {name="Pain",    id=44669694, price=2200, icon="rbxthumb://type=Asset&id=73742359616995&w=150&h=150", outline=Color3.fromRGB(220,100,140) },
    {name="Gravity", id=44669697, price=2300, icon="rbxthumb://type=Asset&id=99762032764913&w=150&h=150", outline=Color3.fromRGB(140,60,200)  },
    {name="Dough",   id=44669701, price=2400, icon="rbxthumb://type=Asset&id=122612389729719&w=150&h=150", outline=Color3.fromRGB(220,180,100)},
    {name="Shadow",  id=44669704, price=2425, icon="rbxthumb://type=Asset&id=90578079260600&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Venom",   id=44669708, price=2450, icon="rbxthumb://type=Asset&id=98654395812215&w=150&h=150", outline=Color3.fromRGB(60,180,40)   },
    {name="Control", id=44669712, price=4000, icon="rbxthumb://type=Asset&id=114700721050665&w=150&h=150", outline=Color3.fromRGB(40,180,255) },
    {name="Spirit",  id=44669716, price=2550, icon="rbxthumb://type=Asset&id=90235152191021&w=150&h=150", outline=Color3.fromRGB(255,220,80)  },
    {name="Dragon",  id=44669720, price=5000, icon="rbxthumb://type=Asset&id=133280182324260&w=150&h=150", outline=Color3.fromRGB(180,60,20) },
    {name="tiger",   id=44669724, price=3000, icon="rbxthumb://type=Asset&id=93678460963694&w=150&h=150", outline=Color3.fromRGB(200,160,20)  },
    {name="Kitsune", id=44669728, price=4000, icon="rbxthumb://type=Asset&id=124061211172749&w=150&h=150", outline=Color3.fromRGB(20,100,220) },
    {name="Yeti",    id=44669730, price=3000, icon="rbxthumb://type=Asset&id=94927024877593&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Gas",     id=44669749, price=2500, icon="rbxthumb://type=Asset&id=122180016987387&w=150&h=150", outline=Color3.fromRGB(180,220,100) },
    {name="Blizzard",id=44669752, price=2250, icon="rbxthumb://type=Asset&id=118220388105168&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Lightning",id=44669756, price=2100, icon="rbxthumb://type=Asset&id=79128664894278&w=150&h=150", outline=Color3.fromRGB(255,240,60)  },
    {name="T-Rex",   id=44669760, price=2350, icon="rbxthumb://type=Asset&id=84299545307713&w=150&h=150", outline=Color3.fromRGB(80,160,40)   },
    {name="Mammoth", id=44669764, price=2350, icon="rbxthumb://type=Asset&id=92683980743128&w=150&h=150", outline=Color3.fromRGB(200,160,80)  },
    {name="Eagle",   id=44669768, price=975,  icon="rbxthumb://type=Asset&id=134522141739172&w=150&h=150", outline=Color3.fromRGB(220,180,40)  },
    
    {name="The Fastest!", isGamepass=true,   id=44669522, price=350,  icon="rbxthumb://type=GamePass&id=44669522&w=150&h=150", outline=Color3.fromRGB(255,80,40) }, -- Fast boats
    {name="2x Mastery", isGamepass=true,     id=44669525, price=450,  icon="rbxthumb://type=GamePass&id=44669525&w=150&h=150", outline=Color3.fromRGB(255,160,20) },
    {name="2x Money", isGamepass=true,       id=44669528, price=450,  icon="rbxthumb://type=GamePass&id=44669528&w=150&h=150", outline=Color3.fromRGB(80,200,60) },
    {name="Dark Blade", isGamepass=true,     id=44669531, price=1200, icon="rbxthumb://type=GamePass&id=44669531&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
    {name="2x Drop Chance", isGamepass=true, id=44669519, price=350,  icon="rbxthumb://type=GamePass&id=44669519&w=150&h=150", outline=Color3.fromRGB(100,160,255) },
    {name="Fruit Notifier", isGamepass=true, id=44669534, price=2700, icon="rbxthumb://type=GamePass&id=44669534&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
}

local function fmtComma(n)
    local s = tostring(math.floor(n))
    local k
    repeat s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2") until k == 0
    return s
end

local function cleanFruitName(nameStr)
    return nameStr:gsub("^Permanent%s+", ""):gsub("^permanent%s+", "")
end

local function fruitToProductInfo(fruit)
    return {
        Name         = cleanFruitName(fruit.name),
        AssetId      = fruit.id,
        PriceInRobux = fruit.price,
        Icon         = fruit.icon,
        Outline      = fruit.outline,
        IsGamepass   = fruit.isGamepass or false,
    }
end

local showProcessingModal

-- ============================================================
--  HỆ THỐNG GIAO DIỆN KHUNG ĐÚNG 100% BLOX FRUITS (CÓ NÚT BUY)
-- ============================================================
local function showBloxFruitsConfirm(gamepassData)
    local confirmGui = Instance.new("ScreenGui")
    confirmGui.Name = "BloxFruits_ConfirmFake"
    confirmGui.DisplayOrder = 5000
    confirmGui.Parent = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 0.4
    overlay.Parent = confirmGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(450, 200)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(24, 21, 19)
    frame.Parent = confirmGui
    stroke(frame, Color3.fromRGB(254, 204, 34), 2.5, 0)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Text = "CONFIRM"
    title.TextColor3 = Color3.fromRGB(254, 204, 34)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.BackgroundTransparency = 1
    title.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -40, 0, 60)
    msg.Position = UDim2.fromOffset(20, 50)
    msg.Text = "Do you want to buy " .. cleanFruitName(gamepassData.name) .. " or send it as a gift?"
    msg.TextColor3 = Color3.new(1, 1, 1)
    msg.Font = Enum.Font.GothamMedium
    msg.TextSize = 18
    msg.TextWrapped = true
    msg.BackgroundTransparency = 1
    msg.Parent = frame

    -- NÚT BUY (Xanh lá cây chuẩn Game)
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.fromOffset(110, 42)
    buyBtn.Position = UDim2.fromOffset(30, 135)
    buyBtn.BackgroundColor3 = Color3.fromRGB(43, 175, 74) 
    buyBtn.Text = "BUY"
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.TextSize = 18
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    buyBtn.Parent = frame
    corner(buyBtn, 4)

    -- NÚT GIFT (Vàng Blox Fruits)
    local giftBtn = Instance.new("TextButton")
    giftBtn.Size = UDim2.fromOffset(110, 42)
    giftBtn.Position = UDim2.fromOffset(170, 135)
    giftBtn.BackgroundColor3 = Color3.fromRGB(254, 204, 34)
    giftBtn.Text = "GIFT"
    giftBtn.Font = Enum.Font.GothamBold
    giftBtn.TextSize = 18
    giftBtn.TextColor3 = Color3.new(0, 0, 0)
    giftBtn.Parent = frame
    corner(giftBtn, 4)

    -- NÚT CANCEL (Đỏ sẫm Blox Fruits)
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.fromOffset(110, 42)
    cancelBtn.Position = UDim2.fromOffset(310, 135)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(219, 74, 74)
    cancelBtn.Text = "CANCEL"
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 18
    cancelBtn.TextColor3 = Color3.new(1, 1, 1)
    cancelBtn.Parent = frame
    corner(cancelBtn, 4)

    -- Sự kiện các nút
    cancelBtn.MouseButton1Click:Connect(function() confirmGui:Destroy() end)
    
    buyBtn.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
        -- Kích hoạt quá trình mua cho bản thân (thủ công)
        showProcessingModal(fruitToProductInfo(gamepassData), localPlayer.Name)
    end)
    
    giftBtn.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
        -- Tiến hành mở khung danh sách người chơi gửi quà
        showBloxFruitsGiftMenu(gamepassData)
    end)
end

function showBloxFruitsGiftMenu(gamepassData)
    local giftGui = Instance.new("ScreenGui")
    giftGui.Name = "BloxFruits_GiftMenuFake"
    giftGui.DisplayOrder = 5001
    giftGui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.fromOffset(360, 470)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(24, 22, 20)
    main.Parent = giftGui
    stroke(main, Color3.fromRGB(254, 204, 34), 3, 0)

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.Text = "Send a Gift"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 25
    header.BackgroundTransparency = 1
    header.Parent = main

    local tabServer = Instance.new("Frame")
    tabServer.Size = UDim2.fromOffset(100, 32)
    tabServer.Position = UDim2.fromOffset(20, 50)
    tabServer.BackgroundColor3 = Color3.fromRGB(254, 204, 34)
    tabServer.Parent = main
    corner(tabServer, 3)
    local tsLbl = Instance.new("TextLabel")
    tsLbl.Size = UDim2.fromScale(1, 1)
    tsLbl.Text = "Server"
    tsLbl.Font = Enum.Font.GothamBold
    tsLbl.TextColor3 = Color3.new(0, 0, 0)
    tsLbl.BackgroundTransparency = 1
    tsLbl.Parent = tabServer

    local tabGlobal = Instance.new("Frame")
    tabGlobal.Size = UDim2.fromOffset(100, 32)
    tabGlobal.Position = UDim2.fromOffset(125, 50)
    tabGlobal.BackgroundColor3 = Color3.fromRGB(40, 35, 35)
    tabGlobal.Parent = main
    corner(tabGlobal, 3)
    stroke(tabGlobal, Color3.fromRGB(254, 204, 34), 1.5, 0)
    local tgLbl = Instance.new("TextLabel")
    tgLbl.Size = UDim2.fromScale(1, 1)
    tgLbl.Text = "Global"
    tgLbl.Font = Enum.Font.GothamBold
    tgLbl.TextColor3 = Color3.fromRGB(254, 204, 34)
    tgLbl.BackgroundTransparency = 1
    tgLbl.Parent = tabGlobal

    local search = Instance.new("TextBox")
    search.Size = UDim2.new(1, -40, 0, 34)
    search.Position = UDim2.fromOffset(20, 92)
    search.BackgroundColor3 = Color3.fromRGB(15, 12, 10)
    search.Text = ""
    search.PlaceholderText = "Search User..."
    search.TextColor3 = Color3.new(1, 1, 1)
    search.PlaceholderColor3 = Color3.fromRGB(130, 125, 120)
    search.Font = Enum.Font.Gotham
    search.TextSize = 14
    search.Parent = main
    stroke(search, Color3.fromRGB(90, 85, 80), 1, 0)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -40, 0, 240)
    scroll.Position = UDim2.fromOffset(20, 140)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 5
    scroll.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.Parent = scroll

    local function populatePlayers(filter)
        for _, c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        local itemsCount = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= localPlayer then
                if filter == "" or p.Name:lower():find(filter:lower()) or p.DisplayName:lower():find(filter:lower()) then
                    itemsCount = itemsCount + 1
                    
                    local row = Instance.new("Frame")
                    row.Size = UDim2.new(1, -6, 0, 46)
                    row.BackgroundColor3 = Color3.fromRGB(40, 36, 32)
                    row.Parent = scroll
                    corner(row, 4)

                    local avatar = Instance.new("ImageLabel")
                    avatar.Size = UDim2.fromOffset(36, 36)
                    avatar.Position = UDim2.fromOffset(6, 5)
                    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=150&h=150"
                    avatar.BackgroundTransparency = 1
                    avatar.Parent = row
                    corner(avatar, 18)

                    local dName = Instance.new("TextLabel")
                    dName.Size = UDim2.new(1, -110, 0, 20)
                    dName.Position = UDim2.fromOffset(52, 4)
                    dName.Text = p.DisplayName
                    dName.TextColor3 = Color3.new(1, 1, 1)
                    dName.Font = Enum.Font.GothamBold
                    dName.TextSize = 14
                    dName.TextXAlignment = Enum.TextXAlignment.Left
                    dName.BackgroundTransparency = 1
                    dName.Parent = row

                    local uName = Instance.new("TextLabel")
                    uName.Size = UDim2.new(1, -110, 0, 16)
                    uName.Position = UDim2.fromOffset(52, 22)
                    uName.Text = "@" .. p.Name
                    uName.TextColor3 = Color3.fromRGB(160, 155, 150)
                    uName.Font = Enum.Font.Gotham
                    uName.TextSize = 12
                    uName.TextXAlignment = Enum.TextXAlignment.Left
                    uName.BackgroundTransparency = 1
                    uName.Parent = row

                    local clickBtn = Instance.new("TextButton")
                    clickBtn.Size = UDim2.fromScale(1, 1)
                    clickBtn.BackgroundTransparency = 1
                    clickBtn.Text = ""
                    clickBtn.Parent = row

                    clickBtn.MouseButton1Click:Connect(function()
                        giftGui:Destroy()
                        showProcessingModal(fruitToProductInfo(gamepassData), p.Name)
                    end)
                end
            end
        end
        scroll.CanvasSize = UDim2.new(0, 0, 0, itemsCount * 50)
    end

    search.Changed:Connect(function() populatePlayers(search.Text) end)
    populatePlayers("")

    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.fromOffset(100, 34)
    cancelBtn.Position = UDim2.fromOffset(20, 395)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(254, 204, 34)
    cancelBtn.Text = "Cancel"
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 14
    cancelBtn.TextColor3 = Color3.new(0, 0, 0)
    cancelBtn.Parent = main
    corner(cancelBtn, 4)
    cancelBtn.MouseButton1Click:Connect(function() giftGui:Destroy() end)

    local pRow = Instance.new("Frame")
    pRow.Size = UDim2.fromOffset(130, 34)
    pRow.Position = UDim2.new(1, -150, 0, 395)
    pRow.BackgroundTransparency = 1
    pRow.Parent = main

    local robuxIcon = Instance.new("ImageLabel")
    robuxIcon.Size = UDim2.fromOffset(22, 22)
    robuxIcon.Position = UDim2.fromOffset(10, 6)
    robuxIcon.Image = ROBUX_ID
    robuxIcon.BackgroundTransparency = 1
    robuxIcon.Parent = pRow

    local priceTxt = Instance.new("TextLabel")
    priceTxt.Size = UDim2.new(1, -38, 1, 0)
    priceTxt.Position = UDim2.fromOffset(38, 0)
    priceTxt.Text = fmtComma(gamepassData.price)
    priceTxt.TextColor3 = Color3.new(1, 1, 1)
    priceTxt.Font = Enum.Font.GothamBold
    priceTxt.TextSize = 16
    priceTxt.TextXAlignment = Enum.TextXAlignment.Left
    priceTxt.BackgroundTransparency = 1
    priceTxt.Parent = pRow

    local giftingLbl = Instance.new("TextLabel")
    giftingLbl.Size = UDim2.new(1, -40, 0, 20)
    giftingLbl.Position = UDim2.fromOffset(20, 440)
    giftingLbl.Text = "Gifting <" .. cleanFruitName(gamepassData.name) .. ">"
    giftingLbl.TextColor3 = Color3.fromRGB(210, 205, 200)
    giftingLbl.Font = Enum.Font.GothamBold
    giftingLbl.TextSize = 14
    giftingLbl.TextXAlignment = Enum.TextXAlignment.Center
    giftingLbl.BackgroundTransparency = 1
    giftingLbl.Parent = main
end

-- ============================================================
--  SENDING GIFT NOTIFICATION
-- ============================================================
local function showGiftNotification(fruitName, recipient)
    local cleanName = cleanFruitName(fruitName)

    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder   = 1002
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local container = Instance.new("Frame")
    container.Size                   = UDim2.fromOffset(620, 60)
    container.AnchorPoint            = Vector2.new(0.5, 0)
    container.Position               = UDim2.new(0.5, 0, 0, -80)
    container.BackgroundTransparency = 1
    container.BorderSizePixel        = 0
    container.Parent                 = gui

    local line1 = Instance.new("TextLabel")
    line1.Size                   = UDim2.new(1, 0, 0, 28)
    line1.Position               = UDim2.fromOffset(0, 0)
    line1.BackgroundTransparency = 1
    line1.Font                   = FONTS.Bold
    line1.TextSize               = 30
    line1.TextColor3             = Color3.fromRGB(255, 255, 255)
    line1.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    line1.TextStrokeTransparency = 0.4
    line1.TextXAlignment         = Enum.TextXAlignment.Center
    line1.RichText               = true
    line1.Text                   = 'Sending gift <font color="rgb(255,200,50)">&lt;' .. cleanName .. '&gt;</font> to ' .. recipient .. '...'
    line1.Parent                 = container

    local line2 = Instance.new("TextLabel")
    line2.Size                   = UDim2.new(1, 0, 0, 28)
    line2.Position               = UDim2.fromOffset(0, -30)
    line2.BackgroundTransparency = 1
    line2.Font                   = FONTS.Bold
    line2.TextSize               = 30
    line2.TextColor3             = Color3.fromRGB(80, 220, 120)
    line2.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    line2.TextStrokeTransparency = 0.4
    line2.TextXAlignment         = Enum.TextXAlignment.Center
    line2.TextTransparency       = 1
    line2.Text                   = 'Gift sent successfully!'
    line2.Parent                 = container

    local slideIn  = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local slideOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenService:Create(container, slideIn, { Position = UDim2.new(0.5, 0, 0, 4) }):Play()

    task.delay(2.0, function()
        if not line2.Parent then return end
        line2.TextTransparency = 0
        TweenService:Create(line2, slideIn, { Position = UDim2.fromOffset(0, 30) }):Play()
    end)

    task.delay(6.0, function()
        if not container.Parent then return end
        TweenService:Create(container, slideOut, { Position = UDim2.new(0.5, 0, 0, -80) }):Play()
        task.delay(0.6, function() gui:Destroy() end)
    end)
end

-- ============================================================
--  PURCHASE COMPLETED MODAL
-- ============================================================
local function showPurchaseDone(productInfo, recipient)
    local isGift = (recipient ~= localPlayer.Name and recipient ~= "Unknown")

    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder   = 1001
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    local MW, MH = 450, 260
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(250, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font     = FONTS.Bold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Purchase completed"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    local xBtn = Instance.new("ImageButton")
    xBtn.Position  = UDim2.new(1, -24, 0, 24)
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.Size      = UDim2.fromOffset(24, 24)
    xBtn.BackgroundTransparency = 1
    xBtn.Image     = CLOSE_X_ID
    xBtn.ImageColor3 = Config.TextMain
    xBtn.ZIndex    = 20
    xBtn.Parent    = modal

    local CH_SIZE = 54 
    local ch = Instance.new("Frame")
    ch.Size        = UDim2.fromOffset(CH_SIZE, CH_SIZE)
    ch.Position    = UDim2.new(0.5, 0, 0, 95)
    ch.AnchorPoint = Vector2.new(0.5, 0.5)
    ch.BackgroundTransparency = 1
    ch.ZIndex = 3
    ch.Parent = modal

    local chk = Instance.new("ImageLabel")
    chk.Size        = UDim2.fromScale(1, 1)
    chk.AnchorPoint = Vector2.new(0.5, 0.5)
    chk.Position    = UDim2.fromScale(0.5, 0.5)
    chk.BackgroundTransparency = 1
    chk.Image       = CHECKMARK_ID 
    chk.ImageColor3 = Config.TextMain
    chk.ZIndex = 4
    chk.Parent = ch

    local subLbl = Instance.new("TextLabel")
    subLbl.BackgroundTransparency = 1
    subLbl.Size     = UDim2.new(1, -48, 0, 20)
    subLbl.Position = UDim2.new(0.5, 0, 0, 140)
    subLbl.AnchorPoint = Vector2.new(0.5, 0)
    subLbl.Font     = FONTS.Main
    subLbl.TextSize = 16
    subLbl.TextColor3 = Config.TextSub
    subLbl.Text = "You have successfully bought " .. productInfo.Name .. "."
    subLbl.TextXAlignment = Enum.TextXAlignment.Center
    subLbl.ZIndex = 3
    subLbl.Parent = modal

    local okBtnBg = Instance.new("Frame")
    okBtnBg.Size     = UDim2.new(1, -48, 0, 44)
    okBtnBg.Position = UDim2.new(0.5, 0, 1, -24)
    okBtnBg.AnchorPoint = Vector2.new(0.5, 1)
    okBtnBg.BackgroundColor3 = Config.BuyAccent
    okBtnBg.BorderSizePixel  = 0
    okBtnBg.ZIndex = 3
    okBtnBg.Parent = modal
    corner(okBtnBg, 8)

    local ok = Instance.new("TextButton")
    ok.Size   = UDim2.fromScale(1, 1)
    ok.BackgroundTransparency = 1
    ok.Text   = "OK"
    ok.Font   = FONTS.Bold
    ok.TextSize = 16
    ok.TextColor3 = Config.TextMain
    ok.AutoButtonColor = false
    ok.ZIndex = 4
    ok.Parent = okBtnBg

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    local function finish()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() gui:Destroy() end)
    end
    ok.MouseButton1Click:Connect(finish)
    xBtn.MouseButton1Click:Connect(finish)
    
    if isGift then
        task.delay(0.5, function()
            showGiftNotification(productInfo.Name, recipient)
        end)
    end
end

-- ============================================================
--  BUY ITEM MODAL (Chuẩn Roblox)
-- ============================================================
local function showBuyModal(productInfo, recipient)
    recipient = recipient or localPlayer.Name
    local price      = productInfo.PriceInRobux or 0
    local newBalance = math.max(Config.FakeBalance - price, 0)

    local old = playerGui:FindFirstChild("Spacehub_BuyModal")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name           = "Spacehub_BuyModal"
    gui.DisplayOrder   = 999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    local MW, MH = 450, 260
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(150, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font     = FONTS.Bold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Buy item"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    local xBtn = Instance.new("ImageButton")
    xBtn.Size = UDim2.fromOffset(24, 24)
    xBtn.Position = UDim2.new(1, -24, 0, 24) 
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.BackgroundTransparency = 1
    xBtn.Image = CLOSE_X_ID
    xBtn.ImageColor3 = Config.TextMain
    xBtn.ZIndex = 4
    xBtn.Parent = modal
    xBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    local balGroup = Instance.new("Frame")
    balGroup.AnchorPoint = Vector2.new(1, 0)
    balGroup.Position = UDim2.new(1, -64, 0, 24) 
    balGroup.Size = UDim2.fromOffset(0, 24)
    balGroup.AutomaticSize = Enum.AutomaticSize.X
    balGroup.BackgroundTransparency = 1
    balGroup.Parent = modal

    local balLayout = Instance.new("UIListLayout")
    balLayout.FillDirection = Enum.FillDirection.Horizontal
    balLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    balLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    balLayout.Padding = UDim.new(0, 6) 
    balLayout.SortOrder = Enum.SortOrder.LayoutOrder
    balLayout.Parent = balGroup

    local topRobuxIcon = Instance.new("ImageLabel")
    topRobuxIcon.BackgroundTransparency = 1
    topRobuxIcon.Image = ROBUX_ID
    topRobuxIcon.Size = UDim2.fromOffset(20, 20)
    topRobuxIcon.LayoutOrder = 1
    topRobuxIcon.Parent = balGroup

    local balTxt = Instance.new("TextLabel")
    balTxt.BackgroundTransparency = 1
    balTxt.Font = FONTS.Num
    balTxt.TextSize = 16
    balTxt.TextColor3 = Config.TextMain
    balTxt.Text = fmtComma(Config.FakeBalance)
    balTxt.AutomaticSize = Enum.AutomaticSize.X 
    balTxt.Size = UDim2.fromOffset(0, 24)
    balTxt.LayoutOrder = 2
    balTxt.Parent = balGroup

    local infoGroup = Instance.new("Frame")
    infoGroup.Size = UDim2.fromOffset(300, 50)
    infoGroup.Position = UDim2.fromOffset(112, 70)
    infoGroup.BackgroundTransparency = 1
    infoGroup.Parent = modal

    local nameLbl = Instance.new("TextLabel")
    nameLbl.BackgroundTransparency = 1
    nameLbl.Size     = UDim2.new(1, 0, 0, 22)
    nameLbl.Font     = FONTS.Bold
    nameLbl.TextSize = 17
    nameLbl.TextColor3 = Config.TextMain
    nameLbl.Text = productInfo.Name
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = infoGroup

    local priceRow = Instance.new("Frame")
    priceRow.Position = UDim2.fromOffset(0, 26) 
    priceRow.Size     = UDim2.new(1, 0, 0, 22)
    priceRow.BackgroundTransparency = 1
    priceRow.Parent   = infoGroup

    local layoutPrice = Instance.new("UIListLayout")
    layoutPrice.FillDirection = Enum.FillDirection.Horizontal
    layoutPrice.VerticalAlignment = Enum.VerticalAlignment.Center 
    layoutPrice.Padding = UDim.new(0, 6) 
    layoutPrice.SortOrder = Enum.SortOrder.LayoutOrder
    layoutPrice.Parent = priceRow

    local itemRobuxIcon = Instance.new("ImageLabel")
    itemRobuxIcon.BackgroundTransparency = 1
    itemRobuxIcon.Size = UDim2.fromOffset(20, 20) 
    itemRobuxIcon.Image = ROBUX_ID 
    itemRobuxIcon.LayoutOrder = 1
    itemRobuxIcon.Parent = priceRow

    local priceLbl = Instance.new("TextLabel")
    priceLbl.BackgroundTransparency = 1
    priceLbl.AutomaticSize = Enum.AutomaticSize.X
    priceLbl.Size = UDim2.fromOffset(0, 22)
    priceLbl.Font = FONTS.Num
    priceLbl.TextSize = 16
    priceLbl.TextColor3 = Config.TextMain
    priceLbl.Text = fmtComma(price)
    priceLbl.LayoutOrder = 2
    priceLbl.Parent = priceRow

    local iconFrame = Instance.new("Frame")
    iconFrame.Size     = UDim2.fromOffset(72, 72)
    iconFrame.Position = UDim2.fromOffset(24, 60)
    iconFrame.BackgroundTransparency = 1
    iconFrame.ZIndex = 3
    iconFrame.Parent = modal

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size        = UDim2.fromScale(1, 1)
    iconImg.BackgroundTransparency = 1
    iconImg.Image    = productInfo.Icon or BLOX_LOGO
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.ZIndex   = 4
    iconImg.Parent   = iconFrame

    local buyBtnBg = Instance.new("Frame")
    buyBtnBg.Size     = UDim2.new(1, -48, 0, 44)
    buyBtnBg.Position = UDim2.fromOffset(24, 145)
    buyBtnBg.BackgroundColor3 = Config.BuyAccentDark
    buyBtnBg.BorderSizePixel = 0
    buyBtnBg.ZIndex = 2
    buyBtnBg.Parent = modal
    corner(buyBtnBg, 8)

    local fillBar = Instance.new("Frame")
    fillBar.Size  = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Config.BuyAccent
    fillBar.BorderSizePixel  = 0
    fillBar.ZIndex = 3
    fillBar.Parent = buyBtnBg
    corner(fillBar, 8)

    local buyBtn = Instance.new("TextButton")
    buyBtn.Size   = UDim2.fromScale(1, 1)
    buyBtn.BackgroundTransparency = 1
    buyBtn.Text   = "Buy" 
    buyBtn.Font   = FONTS.Bold
    buyBtn.TextSize = 16
    buyBtn.TextColor3 = Config.TextMain
    buyBtn.AutoButtonColor = false
    buyBtn.Active = false
    buyBtn.ZIndex = 5
    buyBtn.Parent = buyBtnBg

    local footer = Instance.new("Frame")
    footer.Size             = UDim2.new(1, -48, 0, 46)
    footer.Position         = UDim2.new(0.5, 0, 1, -20)
    footer.AnchorPoint      = Vector2.new(0.5, 1)
    footer.BackgroundColor3 = Config.BgMid
    footer.BorderSizePixel  = 0
    footer.ZIndex           = 3
    footer.Parent           = modal
    corner(footer, 8)
    stroke(footer, Config.BgLight, 1, 0)

    local plusIcon = Instance.new("ImageLabel")
    plusIcon.Size               = UDim2.fromOffset(20, 20)
    plusIcon.Position           = UDim2.fromOffset(16, 13)
    plusIcon.BackgroundTransparency = 1
    plusIcon.Image              = ROBLOX_PLUS_ID
    plusIcon.ZIndex             = 4
    plusIcon.Parent             = footer

    local footerTxt = Instance.new("TextLabel")
    footerTxt.BackgroundTransparency = 1
    footerTxt.Size             = UDim2.fromOffset(168, 46)
    footerTxt.Position         = UDim2.fromOffset(46, 0)
    footerTxt.Font             = FONTS.Main
    footerTxt.TextSize         = 14
    footerTxt.TextColor3       = Config.TextSub
    footerTxt.Text             = "Get 10% off with Roblox Plus"
    footerTxt.TextXAlignment   = Enum.TextXAlignment.Left
    footerTxt.ZIndex           = 4
    footerTxt.Parent           = footer

    local newBadge = Instance.new("Frame")
    newBadge.Size             = UDim2.fromOffset(48, 22)
    newBadge.Position         = UDim2.new(1, -14, 0.5, 0)
    newBadge.AnchorPoint      = Vector2.new(1, 0.5)
    newBadge.BackgroundColor3 = Color3.new(1, 1, 1)
    newBadge.BorderSizePixel  = 0
    newBadge.ZIndex           = 4
    newBadge.Parent           = footer
    corner(newBadge, 11)

    local newLbl = Instance.new("TextLabel")
    newLbl.Size               = UDim2.fromScale(1, 1)
    newLbl.BackgroundTransparency = 1
    newLbl.Text               = "New"
    newLbl.Font               = FONTS.Bold
    newLbl.TextSize           = 13
    newLbl.TextColor3         = Color3.new(0, 0, 0)
    newLbl.ZIndex             = 5
    newLbl.Parent             = newBadge

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    task.spawn(function()
        task.wait(0.45)
        if not fillBar or not fillBar.Parent then return end
        TweenService:Create(fillBar, TweenInfo.new(Config.BuyDelay, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    task.delay(0.45, function()
        if buyBtn and buyBtn.Parent then buyBtn.Active = true end
    end)

    buyBtn.MouseButton1Click:Connect(function()
        if not buyBtn.Active then return end
        buyBtn.Active = false
        
        TweenService:Create(buyBtnBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 30, 80)}):Play()
        TweenService:Create(fillBar, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 55, 140)}):Play()
            
        Config.FakeBalance = newBalance
        
        task.delay(0.6, function()
            if gui and gui.Parent then gui:Destroy() end
            showPurchaseDone(productInfo, recipient)
        end)
    end)
end

function showProcessingModal(productInfo, recipient)
    local gui = Instance.new("ScreenGui")
    gui.Name           = "Spacehub_Processing"
    gui.DisplayOrder   = 1005
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.65 
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    local box = Instance.new("Frame")
    box.Size = UDim2.fromOffset(120, 120) 
    box.Position = UDim2.fromScale(0.5, 0.5)
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.BackgroundTransparency = 1 
    box.BorderSizePixel = 0
    box.ZIndex = 2
    box.Parent = gui

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.fromOffset(60, 60) 
    iconImg.Position = UDim2.new(0.5, 0, 0, 15) 
    iconImg.AnchorPoint = Vector2.new(0.5, 0)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = productInfo.Icon or BLOX_LOGO
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.ZIndex = 3
    iconImg.Parent = box

    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, 0, 0, 30)
    textLbl.Position = UDim2.new(0.5, 0, 1, -40)
    textLbl.AnchorPoint = Vector2.new(0.5, 0)
    textLbl.BackgroundTransparency = 1
    textLbl.Font = FONTS.Main
    textLbl.TextSize = 16
    textLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLbl.TextStrokeTransparency = 0.5 
    textLbl.Text = "Processing Purchase"
    textLbl.ZIndex = 3
    textLbl.Parent = box

    task.spawn(function()
        local dots = {"", ".", "..", "..."}
        for i = 0, 8 do
            if not textLbl.Parent then break end
            textLbl.Text = "Processing Purchase" .. dots[(i % 4) + 1]
            task.wait(0.3)
        end
        if gui.Parent then gui:Destroy() end
        showBuyModal(productInfo, recipient)
    end)
end

-- ============================================================
--  CUTE SETTINGS UI GIAO DIỆN HỒNG DỄ THƯƠNG
-- ============================================================
local CUTE_ACCENT    = Color3.fromRGB(255, 133, 162)
local CUTE_BG        = Color3.fromRGB(255, 192, 217)
local CUTE_PANEL     = Color3.fromRGB(255, 228, 242)
local CUTE_CARD      = Color3.fromRGB(255, 255, 255)
local CUTE_BORDER    = Color3.fromRGB(255, 182, 209)
local CUTE_TEXT_MAIN = Color3.fromRGB(120, 80, 100)
local CUTE_TEXT_SUB  = Color3.fromRGB(160, 120, 140)

local PANEL_W, PANEL_H = 400, 460

for _, n in ipairs({"Spacehub_setting", "HuyVuong_setting", "HuyVuong_KillBtn"}) do
    local old = playerGui:FindFirstChild(n)
    if old then old:Destroy() end
end

local settingsGui = Instance.new("ScreenGui")
settingsGui.Name           = "Spacehub_setting"
settingsGui.DisplayOrder   = 998
settingsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
settingsGui.ResetOnSpawn   = false
settingsGui.Parent         = playerGui

local panel = Instance.new("Frame")
panel.Size             = UDim2.fromOffset(PANEL_W, PANEL_H)
panel.Position         = UDim2.fromScale(0.5, 0.5)
panel.AnchorPoint      = Vector2.new(0.5, 0.5)
panel.BackgroundColor3 = CUTE_PANEL
panel.BorderSizePixel  = 0
panel.Visible          = true
panel.ZIndex           = 20
panel.Parent           = settingsGui
corner(panel, 12)
stroke(panel, CUTE_BORDER, 2, 0)

local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = CUTE_BG
header.BorderSizePixel  = 0
header.ZIndex           = 22
header.Parent           = panel
corner(header, 12)

local headerFix = Instance.new("Frame")
headerFix.Size             = UDim2.new(1, 0, 0.5, 0)
headerFix.Position         = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = CUTE_BG
headerFix.BorderSizePixel  = 0
headerFix.ZIndex           = 22
headerFix.Parent           = header

local titleLbl2 = Instance.new("TextLabel")
titleLbl2.BackgroundTransparency = 1
titleLbl2.Size     = UDim2.new(1, -52, 1, 0)
titleLbl2.Position = UDim2.fromOffset(16, 0)
titleLbl2.Font     = Enum.Font.GothamBold
titleLbl2.TextSize = 15
titleLbl2.TextColor3 = CUTE_TEXT_MAIN
titleLbl2.Text     = "🌸 Space Hub Settings 🌸"
titleLbl2.TextXAlignment = Enum.TextXAlignment.Left
titleLbl2.ZIndex   = 23
titleLbl2.Parent   = header

local panelClose = Instance.new("ImageButton")
panelClose.Size               = UDim2.fromOffset(28, 28)
panelClose.Position           = UDim2.new(1, -38, 0, 8)
panelClose.BackgroundColor3   = Color3.fromRGB(255, 230, 240)
panelClose.Image              = CLOSE_X_ID
panelClose.ImageColor3        = CUTE_TEXT_MAIN
panelClose.AutoButtonColor    = false
panelClose.ZIndex             = 28
panelClose.Parent             = panel
corner(panelClose, 6)
stroke(panelClose, CUTE_BORDER, 1.5, 0)

panelClose.MouseButton1Click:Connect(function() settingsGui.Enabled = false end)

local function cuteCard(yOff, h)
    local card = Instance.new("Frame")
    card.Size             = UDim2.new(1, -30, 0, h)
    card.Position         = UDim2.fromOffset(15, yOff)
    card.BackgroundColor3 = CUTE_CARD
    card.BorderSizePixel  = 0
    card.ZIndex           = 22
    card.Parent           = panel
    corner(card, 10)
    stroke(card, CUTE_BORDER, 1.5, 0)
    return card
end

local function cuteLabel(parent, txt, yOff, size, col, isBold)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size     = UDim2.new(1, -20, 0, 20)
    l.Position = UDim2.fromOffset(15, yOff)
    l.Font     = isBold and Enum.Font.GothamBold or Enum.Font.GothamMedium
    l.TextSize = size or 13
    l.TextColor3 = col or CUTE_TEXT_MAIN
    l.Text     = txt
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex   = 23
    l.Parent   = parent
    return l
end

local userCard = cuteCard(60, 80)
local userAvatar = Instance.new("ImageLabel")
userAvatar.Size = UDim2.fromOffset(56, 56)
userAvatar.Position = UDim2.fromOffset(12, 12)
userAvatar.BackgroundColor3 = CUTE_PANEL
userAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. localPlayer.UserId .. "&w=150&h=150"
userAvatar.ZIndex = 23
userAvatar.Parent = userCard
corner(userAvatar, 100)
stroke(userAvatar, CUTE_BORDER, 2, 0)

local userNameLbl = cuteLabel(userCard, localPlayer.Name, 20, 15, CUTE_TEXT_MAIN, true)
userNameLbl.Position = UDim2.fromOffset(80, 15)
local userIdLbl = cuteLabel(userCard, "ID: " .. tostring(localPlayer.UserId), 42, 12, CUTE_TEXT_SUB, false)
userIdLbl.Position = UDim2.fromOffset(80, 42)

local card1 = cuteCard(155, 130)
cuteLabel(card1, "Fake Robux Balance", 12, 14, CUTE_TEXT_MAIN, true)

local balBox = Instance.new("TextBox")
balBox.Size               = UDim2.new(1, -30, 0, 36)
balBox.Position           = UDim2.fromOffset(15, 38)
balBox.BackgroundColor3   = Color3.fromRGB(255, 240, 248)
balBox.BorderSizePixel    = 0
balBox.Text               = tostring(Config.FakeBalance)
balBox.Font               = Enum.Font.GothamMedium
balBox.TextSize           = 14
balBox.TextColor3         = CUTE_TEXT_MAIN
balBox.ZIndex             = 23
balBox.Parent             = card1
corner(balBox, 6)
stroke(balBox, CUTE_BORDER, 1.5, 0)

local applyBtn = Instance.new("TextButton")
applyBtn.Size             = UDim2.new(1, -30, 0, 36)
applyBtn.Position         = UDim2.fromOffset(15, 82)
applyBtn.BackgroundColor3 = CUTE_ACCENT
applyBtn.Text             = "Apply Balance ✨"
applyBtn.Font             = Enum.Font.GothamBold
applyBtn.TextSize         = 14
applyBtn.TextColor3       = Color3.new(1,1,1)
applyBtn.ZIndex           = 23
applyBtn.Parent           = card1
corner(applyBtn, 6)

local applyDebounce = false
applyBtn.MouseButton1Click:Connect(function()
    if applyDebounce then return end
    applyDebounce = true
    local v = tonumber((balBox.Text:gsub("[,%s]","")))
    if v and v > 0 then Config.FakeBalance = v end
    applyBtn.Text = "Successfully Applied 💖"
    applyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 140)
    task.delay(1.5, function()
        applyBtn.Text = "Apply Balance ✨"
        applyBtn.BackgroundColor3 = CUTE_ACCENT
        applyDebounce = false
    end)
end)

local card2 = cuteCard(300, 145)
cuteLabel(card2, "Interceptor Delay (Seconds)", 12, 14, CUTE_TEXT_MAIN, true)

local delayDisplay = Instance.new("TextLabel")
delayDisplay.BackgroundTransparency = 1
delayDisplay.Size     = UDim2.fromOffset(80, 36)
delayDisplay.Position = UDim2.new(0.5, -40, 0, 42)
delayDisplay.Font     = Enum.Font.GothamBold
delayDisplay.TextSize = 24
delayDisplay.TextColor3 = CUTE_ACCENT
delayDisplay.Text     = tostring(Config.BuyDelay) .. "s"
delayDisplay.ZIndex   = 23
delayDisplay.Parent   = card2

local minusBtn = Instance.new("TextButton")
minusBtn.Size             = UDim2.fromOffset(36, 36)
minusBtn.Position         = UDim2.fromOffset(25, 42)
minusBtn.BackgroundColor3 = Color3.fromRGB(255, 240, 248)
minusBtn.Text             = "−"
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 20
minusBtn.TextColor3 = CUTE_TEXT_MAIN
minusBtn.ZIndex = 23
minusBtn.Parent = card2
corner(minusBtn, 6)
stroke(minusBtn, CUTE_BORDER, 1.5, 0)

local plusBtn = Instance.new("TextButton")
plusBtn.Size             = UDim2.fromOffset(36, 36)
plusBtn.Position         = UDim2.new(1, -61, 0, 42)
plusBtn.BackgroundColor3 = Color3.fromRGB(255, 240, 248)
plusBtn.Text             = "+"
plusBtn.Font             = Enum.Font.GothamBold
plusBtn.TextSize         = 20
plusBtn.TextColor3       = CUTE_TEXT_MAIN
plusBtn.ZIndex           = 23
plusBtn.Parent           = card2
corner(plusBtn, 6)
stroke(plusBtn, CUTE_BORDER, 1.5, 0)

minusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay > 1 then Config.BuyDelay = Config.BuyDelay - 1; delayDisplay.Text = Config.BuyDelay .. "s" end
end)
plusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay < 30 then Config.BuyDelay = Config.BuyDelay + 1; delayDisplay.Text = Config.BuyDelay .. "s" end
end)

local presets = {1, 3, 5, 10}
local presetRow = Instance.new("Frame")
presetRow.Size             = UDim2.new(1, -30, 0, 32)
presetRow.Position         = UDim2.fromOffset(15, 95)
presetRow.BackgroundTransparency = 1
presetRow.ZIndex           = 23
presetRow.Parent           = card2

for i, sec in ipairs(presets) do
    local pb = Instance.new("TextButton")
    pb.Size             = UDim2.new(0.25, -6, 1, 0)
    pb.Position         = UDim2.new((i-1)*0.25, 3, 0, 0)
    pb.BackgroundColor3 = Color3.fromRGB(255, 240, 248)
    pb.Text             = sec .. "s"
    pb.Font             = Enum.Font.GothamMedium
    pb.TextSize         = 13
    pb.TextColor3       = CUTE_TEXT_MAIN
    pb.ZIndex           = 24
    pb.Parent           = presetRow
    corner(pb, 6)
    stroke(pb, CUTE_BORDER, 1.5, 0)
    pb.MouseButton1Click:Connect(function() Config.BuyDelay = sec; delayDisplay.Text = sec .. "s" end)
end

-- ============================================================
--  HỆ THỐNG PHÁT HIỆN CLICK VÀ KHÓA KHIÊN CHẶN (BLOCKER)
-- ============================================================
local hookedBtns = {}

-- Cài đặt Khiên Tuyệt Đối cho một nút bất kỳ
local function applyAbsoluteBlocker(btn, actionFunc)
    if hookedBtns[btn] or btn:FindFirstChild("_FakeOverlayBlocker") then return end
    hookedBtns[btn] = true
    
    -- Tạo một lớp khiên đè lên ăn hoàn toàn tất cả click/touch
    local overlay = Instance.new("TextButton")
    overlay.Name = "_FakeOverlayBlocker"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = 999999 -- Luôn nằm trên cùng
    overlay.Active = true -- BẮT BUỘC: Hút Input không cho chìm xuống nút thật
    overlay.Interactable = true
    overlay.Parent = btn

    -- Vô hiệu hóa event của script gốc nếu executor hỗ trợ
    pcall(function()
        if getconnections then
            for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do pcall(function() conn:Disable() end) end
            for _, conn in ipairs(getconnections(btn.Activated))         do pcall(function() conn:Disable() end) end
            for _, conn in ipairs(getconnections(btn.InputBegan))        do pcall(function() conn:Disable() end) end
        end
    end)

    overlay.MouseButton1Click:Connect(actionFunc)
    
    -- Hút luôn mọi cú va chạm, chặn game tự kích hoạt ngầm
    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Chặn đứng tại đây
        end
    end)
end

local function hookGamepassShopButtons(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if btn:IsDescendantOf(settingsGui) then return end

    local text = (btn.Text or ""):lower()
    local name = (btn.Name or ""):lower()

    local targetGamepass = nil
    for _, f in ipairs(Fruits) do
        if f.isGamepass then
            local gpName = f.name:lower()
            if text:find(gpName) or name:find(gpName:gsub("%s+", "")) or name:find(gpName:gsub("!", "")) then
                targetGamepass = f
                break
            end
        end
    end

    if not targetGamepass and btn.Parent then
        local p = btn.Parent
        for _, f in ipairs(Fruits) do
            if f.isGamepass then
                local gpName = f.name:lower()
                if p.Name:lower():find(gpName:gsub("%s+", "")) then targetGamepass = f; break end
                for _, child in ipairs(p:GetChildren()) do
                    if child:IsA("TextLabel") and child.Text:lower():find(gpName) then
                        targetGamepass = f; break
                    end
                end
            end
        end
    end

    if targetGamepass then
        applyAbsoluteBlocker(btn, function()
            showBloxFruitsConfirm(targetGamepass)
        end)
    end
end

local function hookConfirmButton(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if btn:IsDescendantOf(settingsGui) then return end

    local text = (btn.Text or ""):lower()
    if text == "gift" or text == "tặng quà" or text == "tặng" then return end

    local name = (btn.Name or ""):lower()
    local isInsideGiftModal = false
    local p = btn.Parent
    for _ = 1, 8 do
        if not p then break end
        if p:IsA("TextLabel") or p:IsA("TextButton") then
            local t = (p.Text or ""):lower()
            if t:find("send a gift") or t:find("gifting") then isInsideGiftModal = true; break end
        end
        p = p.Parent
    end

    local isConfirm = (text:find("🎁") or text:match("^%d+$") or text:match("^%d+,%d+$")) and true or false
    local isNamedConfirm = name:find("buy") or name:find("confirm") or name:find("purchase") or name:find("gift")

    if not (isInsideGiftModal or isConfirm or isNamedConfirm) then return end

    applyAbsoluteBlocker(btn, function()
        local targetFruit = Fruits[1]
        showProcessingModal(fruitToProductInfo(targetFruit), "Unknown")
    end)
end

for _, v in ipairs(playerGui:GetDescendants()) do
    task.defer(function() 
        if v and v.Parent then hookGamepassShopButtons(v); hookConfirmButton(v) end 
    end)
end

playerGui.DescendantAdded:Connect(function(d)
    task.delay(0.05, function()
        if d and d.Parent then hookGamepassShopButtons(d); hookConfirmButton(d) end
    end)
end)
