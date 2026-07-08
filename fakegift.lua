--[[
SPAISPACEHUBZZZ fake gift v9 (Fixed Manual Buy, 100% Block Real Robux UI, Gift Gamepass)
--]]

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService   = game:GetService("UserInputService")
local CoreGui            = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
local playerGui   = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- CHẶN HOÀN TOÀN UI MUA ROBUX THẬT TỪ HỆ THỐNG ROBLOX (100% AN TOÀN)
-- ============================================================
pcall(function()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if self == MarketplaceService and not checkcaller() then
            if method == "PromptPurchase" or method == "PromptGamePassPurchase" or method == "PromptProductPurchase" or method == "PromptBundlePurchase" then
                -- Chặn 100% không cho hiện bảng mua Robux thật của game
                return
            end
        end
        return oldNamecall(self, ...)
    end)
end)

-- ============================================================
--  CONFIG & DATABASE
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
local BLOX_LOGO      = "rbxassetid://2804185542"

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

local function fmtComma(n)
    local s = tostring(math.floor(n))
    local k
    repeat s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2") until k == 0
    return s
end

local function cleanFruitName(nameStr)
    return nameStr:gsub("^Permanent%s+", ""):gsub("^permanent%s+", "")
end

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
    
    {name="The Fastest!", isGamepass=true,   id=44669522, price=350,  icon="rbxthumb://type=GamePass&id=44669522&w=150&h=150", outline=Color3.fromRGB(255,80,40) }, 
    {name="2x Mastery", isGamepass=true,     id=44669525, price=450,  icon="rbxthumb://type=GamePass&id=44669525&w=150&h=150", outline=Color3.fromRGB(255,160,20) },
    {name="2x Money", isGamepass=true,       id=44669528, price=450,  icon="rbxthumb://type=GamePass&id=44669528&w=150&h=150", outline=Color3.fromRGB(80,200,60) },
    {name="Dark Blade", isGamepass=true,     id=44669531, price=1200, icon="rbxthumb://type=GamePass&id=44669531&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
    {name="2x Drop Chance", isGamepass=true, id=44669519, price=350,  icon="rbxthumb://type=GamePass&id=44669519&w=150&h=150", outline=Color3.fromRGB(100,160,255) },
    {name="Fruit Notifier", isGamepass=true, id=44669534, price=2700, icon="rbxthumb://type=GamePass&id=44669534&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
}

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
--  GIAO DIỆN BLOX FRUITS CONFIRM (THÊM LẠI NÚT BUY THỦ CÔNG)
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
    frame.Size = UDim2.fromOffset(450, 210)
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
    msg.Text = "Purchase this product for yourself or for a friend?"
    msg.TextColor3 = Color3.new(1, 1, 1)
    msg.Font = Enum.Font.GothamMedium
    msg.TextSize = 18
    msg.TextWrapped = true
    msg.BackgroundTransparency = 1
    msg.Parent = frame

    -- Nút BUY (Màu xanh lá nguyên bản Blox Fruits)
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.fromOffset(120, 42)
    buyBtn.Position = UDim2.new(0, 30, 1, -60)
    buyBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
    buyBtn.Text = "BUY"
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.TextSize = 18
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    buyBtn.Parent = frame
    corner(buyBtn, 4)

    -- Nút GIFT (Màu vàng)
    local giftBtn = Instance.new("TextButton")
    giftBtn.Size = UDim2.fromOffset(120, 42)
    giftBtn.Position = UDim2.new(0, 165, 1, -60)
    giftBtn.BackgroundColor3 = Color3.fromRGB(254, 204, 34)
    giftBtn.Text = "GIFT"
    giftBtn.Font = Enum.Font.GothamBold
    giftBtn.TextSize = 18
    giftBtn.TextColor3 = Color3.new(0, 0, 0)
    giftBtn.Parent = frame
    corner(giftBtn, 4)

    -- Nút CANCEL (Màu đỏ sẫm)
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.fromOffset(120, 42)
    cancelBtn.Position = UDim2.new(0, 300, 1, -60)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(219, 74, 74)
    cancelBtn.Text = "CANCEL"
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 18
    cancelBtn.TextColor3 = Color3.new(1, 1, 1)
    cancelBtn.Parent = frame
    corner(cancelBtn, 4)

    cancelBtn.MouseButton1Click:Connect(function() confirmGui:Destroy() end)
    
    -- Mua cho bản thân (isGift = false)
    buyBtn.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
        showProcessingModal(fruitToProductInfo(gamepassData), localPlayer.Name, false)
    end)

    -- Gift cho bạn bè (Mở bảng chọn)
    giftBtn.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
        showBloxFruitsGiftMenu(gamepassData)
    end)
end

-- ============================================================
-- GIAO DIỆN CHỌN NGƯỜI CHƠI ĐỂ GIFT 
-- ============================================================
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

    local search = Instance.new("TextBox")
    search.Size = UDim2.new(1, -40, 0, 34)
    search.Position = UDim2.fromOffset(20, 92)
    search.BackgroundColor3 = Color3.fromRGB(15, 12, 10)
    search.Text = ""
    search.PlaceholderText = "Search User..."
    search.TextColor3 = Color3.new(1, 1, 1)
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

                    local clickBtn = Instance.new("TextButton")
                    clickBtn.Size = UDim2.fromScale(1, 1)
                    clickBtn.BackgroundTransparency = 1
                    clickBtn.Text = ""
                    clickBtn.Parent = row

                    -- Gift cho người chơi (isGift = true)
                    clickBtn.MouseButton1Click:Connect(function()
                        giftGui:Destroy()
                        showProcessingModal(fruitToProductInfo(gamepassData), p.Name, true)
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
end

-- ============================================================
-- SENDING GIFT NOTIFICATION (CHỈ HIỆN KHI LÀ GIFT)
-- ============================================================
local function showGiftNotification(fruitName, recipient)
    local cleanName = cleanFruitName(fruitName)
    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder = 1002
    gui.Parent = playerGui

    local container = Instance.new("Frame")
    container.Size = UDim2.fromOffset(620, 60)
    container.Position = UDim2.new(0.5, 0, 0, -80)
    container.AnchorPoint = Vector2.new(0.5, 0)
    container.BackgroundTransparency = 1
    container.Parent = gui

    local line1 = Instance.new("TextLabel")
    line1.Size = UDim2.new(1, 0, 0, 28)
    line1.BackgroundTransparency = 1
    line1.Font = FONTS.Bold
    line1.TextSize = 30
    line1.TextColor3 = Color3.fromRGB(255, 255, 255)
    line1.TextStrokeTransparency = 0.4
    line1.RichText = true
    line1.Text = 'Sending gift <font color="rgb(255,200,50)">&lt;' .. cleanName .. '&gt;</font> to ' .. recipient .. '...'
    line1.Parent = container

    local line2 = Instance.new("TextLabel")
    line2.Size = UDim2.new(1, 0, 0, 28)
    line2.Position = UDim2.fromOffset(0, -30)
    line2.BackgroundTransparency = 1
    line2.Font = FONTS.Bold
    line2.TextSize = 30
    line2.TextColor3 = Color3.fromRGB(80, 220, 120)
    line2.TextStrokeTransparency = 0.4
    line2.TextTransparency = 1
    line2.Text = 'Gift sent successfully!'
    line2.Parent = container

    local slideIn = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(container, slideIn, { Position = UDim2.new(0.5, 0, 0, 4) }):Play()

    task.delay(2.0, function()
        line2.TextTransparency = 0
        TweenService:Create(line2, slideIn, { Position = UDim2.fromOffset(0, 30) }):Play()
    end)

    task.delay(6.0, function()
        TweenService:Create(container, slideIn, { Position = UDim2.new(0.5, 0, 0, -80) }):Play()
        task.delay(0.6, function() gui:Destroy() end)
    end)
end

-- ============================================================
-- PURCHASE COMPLETED MODAL
-- ============================================================
local function showPurchaseDone(productInfo, recipient)
    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder = 1001
    gui.Parent = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.Parent = gui

    local modal = Instance.new("Frame")
    modal.Size = UDim2.fromOffset(450, 260)
    modal.Position = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size = UDim2.fromOffset(250, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font = FONTS.Bold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Purchase completed"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = modal

    local ch = Instance.new("Frame")
    ch.Size = UDim2.fromOffset(54, 54)
    ch.Position = UDim2.new(0.5, 0, 0, 95)
    ch.AnchorPoint = Vector2.new(0.5, 0.5)
    ch.BackgroundTransparency = 1
    ch.Parent = modal

    local chk = Instance.new("ImageLabel")
    chk.Size = UDim2.fromScale(1, 1)
    chk.BackgroundTransparency = 1
    chk.Image = CHECKMARK_ID 
    chk.ImageColor3 = Config.TextMain
    chk.Parent = ch

    local subLbl = Instance.new("TextLabel")
    subLbl.BackgroundTransparency = 1
    subLbl.Size = UDim2.new(1, -48, 0, 20)
    subLbl.Position = UDim2.new(0.5, 0, 0, 140)
    subLbl.AnchorPoint = Vector2.new(0.5, 0)
    subLbl.Font = FONTS.Main
    subLbl.TextSize = 16
    subLbl.TextColor3 = Config.TextSub
    subLbl.Text = "You have successfully bought " .. productInfo.Name .. "."
    subLbl.Parent = modal

    local okBtnBg = Instance.new("Frame")
    okBtnBg.Size = UDim2.new(1, -48, 0, 44)
    okBtnBg.Position = UDim2.new(0.5, 0, 1, -24)
    okBtnBg.AnchorPoint = Vector2.new(0.5, 1)
    okBtnBg.BackgroundColor3 = Config.BuyAccent
    okBtnBg.Parent = modal
    corner(okBtnBg, 8)

    local ok = Instance.new("TextButton")
    ok.Size = UDim2.fromScale(1, 1)
    ok.BackgroundTransparency = 1
    ok.Text = "OK"
    ok.Font = FONTS.Bold
    ok.TextSize = 16
    ok.TextColor3 = Config.TextMain
    ok.Parent = okBtnBg

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    ok.MouseButton1Click:Connect(function()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() gui:Destroy() end)
    end)
end

-- ============================================================
-- BẢNG ROBUX MUA ẢO VÀ PHÂN LOẠI XỬ LÝ (BUY vs GIFT)
-- ============================================================
local function showBuyModal(productInfo, recipient, isGift)
    local price = productInfo.PriceInRobux or 0
    local newBalance = math.max(Config.FakeBalance - price, 0)

    local gui = Instance.new("ScreenGui")
    gui.Name = "Spacehub_BuyModal"
    gui.DisplayOrder = 999
    gui.Parent = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.Parent = gui

    local modal = Instance.new("Frame")
    modal.Size = UDim2.fromOffset(450, 260)
    modal.Position = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size = UDim2.fromOffset(150, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font = FONTS.Bold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Buy item"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = modal

    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.fromOffset(72, 72)
    iconFrame.Position = UDim2.fromOffset(24, 60)
    iconFrame.BackgroundTransparency = 1
    iconFrame.Parent = modal

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.fromScale(1, 1)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = productInfo.Icon or BLOX_LOGO
    iconImg.Parent = iconFrame

    local buyBtnBg = Instance.new("Frame")
    buyBtnBg.Size = UDim2.new(1, -48, 0, 44)
    buyBtnBg.Position = UDim2.fromOffset(24, 145)
    buyBtnBg.BackgroundColor3 = Config.BuyAccentDark
    buyBtnBg.Parent = modal
    corner(buyBtnBg, 8)

    local fillBar = Instance.new("Frame")
    fillBar.Size = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Config.BuyAccent
    fillBar.Parent = buyBtnBg
    corner(fillBar, 8)

    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.fromScale(1, 1)
    buyBtn.BackgroundTransparency = 1
    buyBtn.Text = "Buy" 
    buyBtn.Font = FONTS.Bold
    buyBtn.TextSize = 16
    buyBtn.TextColor3 = Config.TextMain
    buyBtn.Active = false
    buyBtn.Parent = buyBtnBg

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    task.spawn(function()
        task.wait(0.45)
        TweenService:Create(fillBar, TweenInfo.new(Config.BuyDelay, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(Config.BuyDelay)
        buyBtn.Active = true
    end)

    buyBtn.MouseButton1Click:Connect(function()
        if not buyBtn.Active then return end
        buyBtn.Active = false
        Config.FakeBalance = newBalance
        
        TweenService:Create(buyBtnBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 30, 80)}):Play()
        
        task.delay(0.6, function()
            gui:Destroy()
            showPurchaseDone(productInfo, recipient)
            
            -- Chỉ hiện thông báo "Đang gửi quà" nếu cờ isGift = true
            if isGift then
                task.delay(0.5, function()
                    showGiftNotification(productInfo.Name, recipient)
                end)
            end
        end)
    end)
end

function showProcessingModal(productInfo, recipient, isGift)
    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder = 1005
    gui.Parent = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.65 
    overlay.Parent = gui

    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, 0, 0, 30)
    textLbl.Position = UDim2.new(0.5, 0, 0.5, 50)
    textLbl.AnchorPoint = Vector2.new(0.5, 0.5)
    textLbl.BackgroundTransparency = 1
    textLbl.Font = FONTS.Main
    textLbl.TextSize = 16
    textLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLbl.Text = "Processing Purchase"
    textLbl.Parent = gui

    task.spawn(function()
        local dots = {"", ".", "..", "..."}
        for i = 0, 8 do
            if not textLbl.Parent then break end
            textLbl.Text = "Processing Purchase" .. dots[(i % 4) + 1]
            task.wait(0.3)
        end
        if gui.Parent then gui:Destroy() end
        showBuyModal(productInfo, recipient, isGift)
    end)
end

-- ============================================================
-- CÀI ĐẶT HOOK VÀ LẮNG NGHE CHUYỂN ĐỔI (OVERLAY ẢO)
-- ============================================================
local hookedBtns = {}

local function hookGamepassShopButtons(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if hookedBtns[btn] then return end
    if btn:FindFirstChild("_GPOverlay") then return end

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

    if targetGamepass then
        hookedBtns[btn] = true
        
        local overlay = Instance.new("TextButton")
        overlay.Name = "_GPOverlay"
        overlay.Size = UDim2.fromScale(1, 1)
        overlay.BackgroundTransparency = 1
        overlay.Text = ""
        overlay.ZIndex = (btn.ZIndex or 1) + 100
        overlay.Parent = btn

        overlay.MouseButton1Click:Connect(function()
            showBloxFruitsConfirm(targetGamepass)
        end)
    end
end

local function hookConfirmButton(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if hookedBtns[btn] then return end
    if btn:FindFirstChild("_HazeOverlay") or btn:FindFirstChild("_GPOverlay") then return end

    local text = (btn.Text or ""):lower()
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

    hookedBtns[btn] = true
    
    local overlay = Instance.new("TextButton")
    overlay.Name = "_HazeOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = (btn.ZIndex or 1) + 50
    overlay.Parent = btn

    overlay.MouseButton1Click:Connect(function()
        local targetFruit = Fruits[1]
        showProcessingModal(fruitToProductInfo(targetFruit), "Unknown", false)
    end)
end

for _, v in ipairs(playerGui:GetDescendants()) do
    task.defer(function() 
        if v and v.Parent then 
            hookGamepassShopButtons(v)
            hookConfirmButton(v) 
        end 
    end)
end

playerGui.DescendantAdded:Connect(function(d)
    task.delay(0.05, function()
        if d and d.Parent then 
            hookGamepassShopButtons(d)
            hookConfirmButton(d) 
        end
    end)
end)
