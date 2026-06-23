-- ════════════════════════════════════════════════════════════════════════════════
--  SPACEHUB PREMIUM - LOADING SCREEN
-- ════════════════════════════════════════════════════════════════════════════════
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Show loading screen
local loadGui = Instance.new("ScreenGui")
loadGui.Name = "Spacehubpremium_Loading"
loadGui.DisplayOrder = 10000
loadGui.Parent = playerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.3
bg.BorderSizePixel = 0
bg.Parent = loadGui

local card = Instance.new("Frame")
card.Size = UDim2.fromOffset(400, 240)
card.Position = UDim2.fromScale(0.5, 0.5)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
card.BorderSizePixel = 0
card.Parent = loadGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = card

-- Title
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.fromScale(1, 0.3)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Text = "SPACEHUB PREMIUM"
title.Parent = card

-- Subtitle
local sub = Instance.new("TextLabel")
sub.BackgroundTransparency = 1
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0.28, 0)
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(100, 180, 255)
sub.Text = "Initializing script..."
sub.Parent = card

-- Progress bar background
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -60, 0, 8)
barBg.Position = UDim2.fromOffset(30, 140)
barBg.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
barBg.BorderSizePixel = 0
barBg.Parent = card

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 4)
barCorner.Parent = barBg

-- Progress bar fill
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 4)
fillCorner.Parent = barFill

-- Percentage text
local pct = Instance.new("TextLabel")
pct.BackgroundTransparency = 1
pct.Size = UDim2.new(1, -60, 0, 20)
pct.Position = UDim2.fromOffset(30, 158)
pct.Font = Enum.Font.GothamBold
pct.TextSize = 14
pct.TextColor3 = Color3.fromRGB(0, 200, 255)
pct.Text = "0%"
pct.TextXAlignment = Enum.TextXAlignment.Center
pct.Parent = card

-- Animate progress bar over 5 seconds
local TweenService = game:GetService("TweenService")
TweenService:Create(barFill, TweenInfo.new(5, Enum.EasingStyle.Linear),
    {Size = UDim2.new(1, 0, 1, 0)}):Play()

-- Animate percentage
for i = 0, 100 do
    task.wait(0.05)
    pct.Text = i .. "%"
end

-- Fade out
task.wait(0.5)
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
task.wait(0.6)
loadGui:Destroy()

--[[
███████╗██████╗  █████╗ ██╗███████╗██████╗  █████╗  ██████╗███████╗
██╔════╝██╔══██╗██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
███████╗██████╔╝███████║██║███████╗██████╔╝███████║██║     █████╗
╚════██║██╔═══╝ ██╔══██║██║╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝
███████║██║     ██║  ██║██║███████║██║     ██║  ██║╚██████╗███████╗
╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝

██████╗ ██╗   ██╗██████╗ ███████╗███████╗███████╗███████╗███████╗
╚════██╗██║   ██║╚════██╗╚══███╔╝╚══███╔╝╚══███╔╝╚══███╔╝╚══███╔╝
 █████╔╝██║   ██║ █████╔╝  ███╔╝   ███╔╝   ███╔╝   ███╔╝   ███╔╝
██╔═══╝ ██║   ██║██╔═══╝  ███╔╝   ███╔╝   ███╔╝   ███╔╝   ███╔╝
███████╗╚██████╔╝███████╗███████╗███████╗███████╗███████╗███████╗
╚══════╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝

SPAISPACEHUBZZZ fake gift v2
--]]

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService   = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui   = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  CONFIG
-- ============================================================
local Config = {
    FakeBalance   = 5000000,
}

-- ════════════════════════════════════════════════════════════════════════════════
--  LANGUAGE SYSTEM
-- ════════════════════════════════════════════════════════════════════════════════
local Lang = {}
Lang.current = "English"  -- or "Vietnamese", "Spanish"

Lang.en = {
    BuyItem = "Buy item",
    PurchaseCompleted = "Purchase completed",
    YouBought = "You have successfully bought",
    Buy = "Buy",
    OK = "OK",
}

Lang.vi = {
    BuyItem = "Mua vật phẩm",
    PurchaseCompleted = "Mua thành công",
    YouBought = "Bạn đã mua thành công",
    Buy = "Mua",
    OK = "OK",
}

Lang.es = {
    BuyItem = "Comprar artículo",
    PurchaseCompleted = "Compra completada",
    YouBought = "Has comprado exitosamente",
    Buy = "Comprar",
    OK = "OK",
}

local function T(key)
    local dict = Lang[Lang.current:lower()] or Lang.en
    return dict[key] or key
end

    BuyAccent     = Color3.fromRGB(0,   110, 255),
    BuyAccentDark = Color3.fromRGB(0,   60,  160),
    BgDark        = Color3.fromRGB(18,  18,  24),
    BgMid         = Color3.fromRGB(28,  28,  38),
    BgLight       = Color3.fromRGB(48,  48,  62),
    TextMain      = Color3.fromRGB(240, 240, 255),
    TextSub       = Color3.fromRGB(160, 160, 190),
    PanelRed      = Color3.fromRGB(180, 20,  20),
    PanelRedDark  = Color3.fromRGB(30,  8,   8),
}

-- ============================================================
--  FRUIT DATABASE
-- ============================================================
local BLOX_LOGO = "rbxassetid://2804185542"

local Fruits = {
    {name="Bomb",    id=44669609, price=220,  icon="rbxthumb://type=Asset&id=72369528696047&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spike",   id=44669616, price=380,  icon="rbxthumb://type=Asset&id=131167693319825&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="blade",    id=44669618, price=100,  icon="rbxthumb://type=Asset&id=116884668999743&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spring",  id=44669621, price=180,   icon="rbxthumb://type=Asset&id=131259631046573&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="rocket",    id=44669613, price=50,   icon="rbxthumb://type=Asset&id=138286042637253&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Smoke",   id=44669624, price=250,  icon="rbxthumb://type=Asset&id=82043762754488&w=150&h=150", outline=Color3.fromRGB(180,180,180) },
    {name="Spin",    id=44669628, price=75,  icon="rbxthumb://type=Asset&id=132896972664540&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Flame",   id=44669633, price=550,  icon="rbxthumb://type=Asset&id=108831553026356&w=150&h=150", outline=Color3.fromRGB(220,80,20)   },
    {name="Ice",     id=44669637, price=750,  icon="rbxthumb://type=Asset&id=74875972194260&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Sand",    id=44669641, price=850,  icon="rbxthumb://type=Asset&id=106977568354230&w=150&h=150", outline=Color3.fromRGB(200,170,80)  },
    {name="Dark",    id=44669644, price=950,  icon="rbxthumb://type=Asset&id=102350616725604&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Diamond", id=44669648, price=1000,  icon="rbxthumb://type=Asset&id=73956493227615&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Light",   id=44669651, price=1100,  icon="rbxthumb://type=Asset&id=82087340639683&w=150&h=150", outline=Color3.fromRGB(240,220,100) },
    {name="Rubber",  id=44669655, price=1200,  icon="rbxthumb://type=Asset&id=130679323833459&w=150&h=150", outline=Color3.fromRGB(220,60,60)   },
    {name="Creation", id=44669659, price=1750,  icon="rbxthumb://type=Asset&id=95414926547178&w=150&h=150", outline=Color3.fromRGB(180,180,220) },
    {name="Magma",   id=44669663, price=1300, icon="rbxthumb://type=Asset&id=127157664640262&w=150&h=150", outline=Color3.fromRGB(200,60,20)},
    {name="Quake",   id=44669668, price=1500, icon="rbxthumb://type=Asset&id=122826264224872&w=150&h=150", outline=Color3.fromRGB(160,140,100) },
    {name="Buddha",  id=44669672, price=1650,
        icon    = "rbxthumb://type=Asset&id=109883576360269&w=150&h=150",
        outline = Color3.fromRGB(220,180,20)
    },
    {name="Love",    id=44669676, price=1700, icon="rbxthumb://type=Asset&id=113290491848534&w=150&h=150", outline=Color3.fromRGB(255,100,160) },
    {name="Spider",  id=44669679, price=1800, icon="rbxthumb://type=Asset&id=76759665031963&w=150&h=150", outline=Color3.fromRGB(60,60,60)    },
    {name="Sound",   id=44669683, price=1900, icon="rbxthumb://type=Asset&id=83607585966959&w=150&h=150", outline=Color3.fromRGB(180,100,220) },
    {name="Phoenix", id=44669687, price=2100, icon="rbxthumb://type=Asset&id=74573221561916&w=150&h=150", outline=Color3.fromRGB(220,120,20)  },
    {name="Portal",  id=44669691, price=2000,
        icon    = "rbxthumb://type=Asset&id=12181754234&w=150&h=150",
        outline = Color3.fromRGB(100,180,255)
    },
    {name="Pain",     id=44669694, price=2200, icon="rbxthumb://type=Asset&id=73742359616995&w=150&h=150", outline=Color3.fromRGB(220,100,140) },
    {name="Gravity", id=44669697, price=2300, icon="rbxthumb://type=Asset&id=99762032764913&w=150&h=150", outline=Color3.fromRGB(140,60,200)  },
    {name="Dough",   id=44669701, price=2400,  icon="rbxthumb://type=Asset&id=125845430464185&w=150&h=150", outline=Color3.fromRGB(220,180,100)},
    {name="Shadow",  id=44669704, price=2425, icon="rbxthumb://type=Asset&id=90578079260600&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Venom",   id=44669708, price=2450, icon="rbxthumb://type=Asset&id=98654395812215&w=150&h=150", outline=Color3.fromRGB(60,180,40)   },
    {name="Control", id=44669712, price=4000,
        icon    = "rbxthumb://type=Asset&id=114700721050665&w=150&h=150",
        outline = Color3.fromRGB(40,180,255)
    },
    {name="Spirit",  id=44669716, price=2550, icon="rbxthumb://type=Asset&id=90235152191021&w=150&h=150", outline=Color3.fromRGB(255,220,80)  },
    {name="Dragon",  id=44669720, price=5000,
        icon    = "rbxthumb://type=Asset&id=133280182324260&w=150&h=150",
        outline = Color3.fromRGB(180,60,20)
    },
    {name="tiger", id=44669724, price=3000, icon        = "rbxthumb://type=Asset&id=93678460963694&w=150&h=150", outline=Color3.fromRGB(200,160,20)  },
    {name="Kitsune", id=44669728, price=4000,
        icon    = "rbxthumb://type=Asset&id=124061211172749&w=150&h=150",
        outline = Color3.fromRGB(20,100,220)
    },
    {name="Yeti",    id=44669730, price=3000, icon="rbxthumb://type=Asset&id=94927024877593&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Gas",        id=44669749, price=2500,  icon="rbxthumb://type=Asset&id=87151676586578&w=150&h=150",   outline=Color3.fromRGB(180,220,100) },
    {name="Blizzard",   id=44669752, price=2250,  icon="rbxthumb://type=Asset&id=118220388105168&w=150&h=150",  outline=Color3.fromRGB(160,220,255) },
    {name="Lightning",  id=44669756, price=2100,  icon="rbxthumb://type=Asset&id=79128664894278&w=150&h=150",  outline=Color3.fromRGB(255,240,60)  },
    {name="T-Rex",      id=44669760, price=2350,  icon="rbxthumb://type=Asset&id=84299545307713&w=150&h=150",  outline=Color3.fromRGB(80,160,40)   },
    {name="Mammoth",    id=44669764, price=2350,  icon="rbxthumb://type=Asset&id=92683980743128&w=150&h=150",   outline=Color3.fromRGB(200,160,80)  },
    {name="Eagle",      id=44669768, price=975,   icon="rbxthumb://type=Asset&id=134522141739172&w=150&h=150",  outline=Color3.fromRGB(220,180,40)  },
    -- ── GAMEPASSES ──────────────────────────────────────────────
    {name="2x Mastery", isGamepass=true,     id=44669525, price=450,
        icon="rbxthumb://type=GamePass&id=44669525&w=150&h=150",
        outline=Color3.fromRGB(255,160,20)
    },
    {name="2x Money", isGamepass=true,       id=44669528, price=450,
        icon="rbxthumb://type=GamePass&id=44669528&w=150&h=150",
        outline=Color3.fromRGB(80,200,60)
    },
    {name="Dark Blade", isGamepass=true,     id=44669531, price=1200,
        icon="rbxthumb://type=GamePass&id=44669531&w=150&h=150",
        outline=Color3.fromRGB(60,200,80)
    },
    {name="Fast Boats", isGamepass=true,     id=44669522, price=350,
        icon="rbxthumb://type=GamePass&id=44669522&w=150&h=150",
        outline=Color3.fromRGB(255,80,40)
    },
    {name="2x Drop Chance", isGamepass=true, id=44669519, price=350,
        icon="rbxthumb://type=GamePass&id=44669519&w=150&h=150",
        outline=Color3.fromRGB(100,160,255)
    },
    {name="Fruit Notifier", isGamepass=true, id=44669534, price=2700,
        icon="rbxthumb://type=GamePass&id=44669534&w=150&h=150",
        outline=Color3.fromRGB(60,200,80)
    },
}

-- ============================================================
--  UTILITIES
-- ============================================================
local function fmtComma(n)
    local s = tostring(math.floor(n))
    local k
    repeat s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2") until k == 0
    return s
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function stroke(p, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color        = col   or Color3.new(1,1,1)
    s.Thickness    = thick or 1.5
    s.Transparency = trans or 0.5
    s.Parent = p
    return s
end

local function lbl(parent, props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font           = props.Font  or Enum.Font.GothamBold
    l.TextSize       = props.Size  or 14
    l.TextColor3     = props.Color or Config.TextMain
    l.Text           = props.Text  or ""
    l.TextXAlignment = props.Align or Enum.TextXAlignment.Left
    l.Position       = props.Pos   or UDim2.new(0,0,0,0)
    l.Size           = props.FS    or UDim2.new(1,0,1,0)
    l.TextWrapped    = props.Wrap  or false
    l.ZIndex         = props.Z     or 3
    l.Parent         = parent
    return l
end

local function robuxIcon(parent, size, pos, z)
    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.Image    = "rbxasset://textures/ui/common/robux@3x.png"
    img.Size     = UDim2.fromOffset(size, size)
    img.Position = pos or UDim2.new(0,0,0,0)
    img.ZIndex   = z or 3
    img.Parent   = parent
    return img
end

-- ============================================================
--  PURCHASE COMPLETED MODAL
-- ============================================================
-- ============================================================
--  SENDING GIFT NOTIFICATION  (top screen slide)
-- ============================================================
local function showGiftNotification(fruitName, recipient)
    local cleanName = fruitName:match("^Permanent (.+)$") or fruitName

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
    line1.Font                   = Enum.Font.GothamBold
    line1.TextSize               = 30
    line1.TextColor3             = Color3.fromRGB(255, 255, 255)
    line1.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    line1.TextStrokeTransparency = 0.4
    line1.TextXAlignment         = Enum.TextXAlignment.Center
    line1.RichText               = true
    line1.Text                   = 'Sending gift <font color="rgb(255,200,50)">&lt;Permanent ' .. cleanName .. '&gt;</font> to ' .. recipient .. '...'
    line1.Parent                 = container

    local line2 = Instance.new("TextLabel")
    line2.Size                   = UDim2.new(1, 0, 0, 28)
    line2.Position               = UDim2.fromOffset(0, -30)
    line2.BackgroundTransparency = 1
    line2.Font                   = Enum.Font.GothamBold
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

local function showPurchaseDone(productInfo, recipient)
    recipient = recipient or "Unknown"

    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder   = 1001
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    -- Dim overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    -- Modal: wide, taller, darker
    local MW, MH = 480, 230 + 40
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 20)

    -- Title (top-left)
    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(MW - 50, 44)
    titleLbl.Position = UDim2.fromOffset(20, 14)
    titleLbl.Font     = Enum.Font.GothamBold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLbl.Text = "Purchase completed"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    -- X close (top-right)
    local xBtn = Instance.new("ImageButton")
    xBtn.Position  = UDim2.new(1, -14, 0, 14)
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.Size      = UDim2.fromOffset(26, 26)
    xBtn.BackgroundTransparency = 1
    xBtn.Image     = "rbxassetid://92232500754851"
    xBtn.ImageColor3 = Color3.fromRGB(170, 170, 195)
    xBtn.ZIndex    = 20
    xBtn.Parent    = modal

    -- Checkmark circle + tick
    local CH_SIZE = 72
    local ch = Instance.new("Frame")
    ch.Size        = UDim2.fromOffset(CH_SIZE, CH_SIZE)
    ch.Position    = UDim2.new(0.5, 0, 0, 52)
    ch.AnchorPoint = Vector2.new(0.5, 0)
    ch.BackgroundTransparency = 1
    ch.ZIndex = 3
    ch.Parent = modal

    local circ = Instance.new("Frame")
    circ.Size = UDim2.fromScale(1, 1)
    circ.BackgroundTransparency = 1
    circ.ZIndex = 3
    circ.Parent = ch
    corner(circ, 100)
    stroke(circ, Color3.fromRGB(210, 210, 228), 2.5, 0)

    local chk = Instance.new("ImageLabel")
    chk.Size        = UDim2.fromOffset(40, 40)
    chk.AnchorPoint = Vector2.new(0.5, 0.5)
    chk.Position    = UDim2.fromScale(0.5, 0.5)
    chk.BackgroundTransparency = 1
    chk.Image       = "rbxassetid://3944680095"
    chk.ImageColor3 = Color3.fromRGB(220, 220, 235)
    chk.ZIndex = 4
    chk.Parent = ch

    -- Pop-in animation
    ch.Size = UDim2.fromOffset(0, 0)
    task.delay(0.25, function()
        if not ch.Parent then return end
        TweenService:Create(ch,
            TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.fromOffset(CH_SIZE, CH_SIZE)}):Play()
    end)

    -- Sub text
    local subLbl = Instance.new("TextLabel")
    subLbl.BackgroundTransparency = 1
    subLbl.Size     = UDim2.fromOffset(MW - 60, 36)
    subLbl.Position = UDim2.fromOffset(30, 140)
    subLbl.Font     = Enum.Font.GothamMedium
    subLbl.TextSize = 15
    subLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    subLbl.Text = "You have successfully bought " .. productInfo.Name .. "."
    subLbl.TextXAlignment = Enum.TextXAlignment.Center
    subLbl.TextWrapped = true
    subLbl.ZIndex = 3
    subLbl.Parent = modal

    -- OK button — full width, bottom
    local BTN_H = 52
    local okBtnBg = Instance.new("Frame")
    okBtnBg.Size     = UDim2.fromOffset(MW - 28, BTN_H)
    okBtnBg.Position = UDim2.fromOffset(14, MH - BTN_H - 16)
    okBtnBg.BackgroundColor3 = Config.BuyAccent
    okBtnBg.BorderSizePixel  = 0
    okBtnBg.ZIndex = 3
    okBtnBg.Parent = modal
    corner(okBtnBg, 10)

    local ok = Instance.new("TextButton")
    ok.Size   = UDim2.fromScale(1, 1)
    ok.BackgroundTransparency = 1
    ok.Text   = T("OK")
    ok.Font   = Enum.Font.GothamBold
    ok.TextSize = 18
    ok.TextColor3 = Color3.new(1, 1, 1)
    ok.AutoButtonColor = false
    ok.ZIndex = 4
    ok.Parent = okBtnBg

    -- Slide in from below
    modal.Position = UDim2.fromScale(0.5, 0.5) -- instant



    local function finish()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() gui:Destroy() end)
    end
    ok.MouseButton1Click:Connect(finish)
    xBtn.MouseButton1Click:Connect(finish)
end

-- ============================================================
--  BUY ITEM MODAL
-- ============================================================

local function showBuyModal(productInfo, recipient)
    recipient = recipient or "Unknown"
    local price      = productInfo.PriceInRobux or 0
    local newBalance = math.max(Config.FakeBalance - price, 0)

    local old = playerGui:FindFirstChild("HazeHub_BuyModal")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name           = "Spacehub_BuyModal"
    gui.DisplayOrder   = 999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    -- Dim overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui


    -- Modal size (compact, like original)
    local MW, MH = 480, 230
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 16)

    -- ── Row 1: Title (left) │ Balance + X (right) ──
    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(220, 40)
    titleLbl.Position = UDim2.fromOffset(20, 14)
    titleLbl.Font     = Enum.Font.GothamBold
    titleLbl.TextSize = 20
    titleLbl.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLbl.Text = T("BuyItem")
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    -- Balance top-right
    local balRow = Instance.new("Frame")
    balRow.Position    = UDim2.new(1, -50, 0, 18)
    balRow.AnchorPoint = Vector2.new(1, 0)
    balRow.Size        = UDim2.fromOffset(0, 22)
    balRow.AutomaticSize = Enum.AutomaticSize.X
    balRow.BackgroundTransparency = 1
    balRow.ZIndex = 5
    balRow.Parent = modal
    robuxIcon(balRow, 17, UDim2.fromOffset(0, 2), 5)
    local balTxt = Instance.new("TextLabel")
    balTxt.BackgroundTransparency = 1
    balTxt.Position = UDim2.fromOffset(21, 0)
    balTxt.Size     = UDim2.new(0, 0, 1, 0)
    balTxt.AutomaticSize = Enum.AutomaticSize.X
    balTxt.Text     = fmtComma(Config.FakeBalance)
    balTxt.Font     = Enum.Font.GothamBold
    balTxt.TextSize = 14
    balTxt.TextColor3 = Config.TextMain
    balTxt.ZIndex = 5
    balTxt.Parent = balRow

    -- X close (top-right)
    local xBtn = Instance.new("ImageButton")
    xBtn.Position  = UDim2.new(1, -14, 0, 14)
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.Size      = UDim2.fromOffset(26, 26)
    xBtn.BackgroundTransparency = 1
    xBtn.Image     = "rbxassetid://92232500754851"
    xBtn.ImageColor3 = Color3.fromRGB(170, 170, 195)
    xBtn.ZIndex    = 20
    xBtn.Parent    = modal
    xBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    -- ── Row 2: Icon + Name + Price ──
    local ICON_Y = 58
    -- Icon box
    local iconFrame = Instance.new("Frame")
    iconFrame.Size     = UDim2.fromOffset(80, 80)
    iconFrame.Position = UDim2.fromOffset(20, ICON_Y)
    iconFrame.BackgroundTransparency = 1
    iconFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    iconFrame.BorderSizePixel  = 0
    iconFrame.ZIndex = 3
    iconFrame.Parent = modal
    corner(iconFrame, 10)

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size        = UDim2.fromScale(1, 1)
    iconImg.AnchorPoint = Vector2.new(0, 0)
    iconImg.Position    = UDim2.fromOffset(0, 0)
    iconImg.BackgroundTransparency = 1
    iconImg.Image    = productInfo.Icon or BLOX_LOGO
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.ZIndex   = 4
    iconImg.Parent   = iconFrame

    -- Name
    local nameLbl = Instance.new("TextLabel")
    nameLbl.BackgroundTransparency = 1
    nameLbl.Size     = UDim2.fromOffset(240, 28)
    nameLbl.Position = UDim2.fromOffset(104, ICON_Y + 4)
    nameLbl.Font     = Enum.Font.GothamBold
    nameLbl.TextSize = 17
    nameLbl.TextColor3 = Color3.fromRGB(240, 240, 255)
    nameLbl.Text = productInfo.Name
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 4
    nameLbl.Parent = modal

    -- Price row
    local priceRow = Instance.new("Frame")
    priceRow.Position = UDim2.fromOffset(104, ICON_Y + 38)
    priceRow.Size     = UDim2.fromOffset(200, 26)
    priceRow.BackgroundTransparency = 1
    priceRow.ZIndex   = 4
    priceRow.Parent   = modal
    robuxIcon(priceRow, 19, UDim2.fromOffset(0, 3), 4)
    local priceLbl = Instance.new("TextLabel")
    priceLbl.BackgroundTransparency = 1
    priceLbl.Size     = UDim2.new(1, -25, 1, 0)
    priceLbl.Position = UDim2.fromOffset(25, 0)
    priceLbl.Font     = Enum.Font.GothamBold
    priceLbl.TextSize = 16
    priceLbl.TextColor3 = Color3.fromRGB(240, 240, 255)
    priceLbl.Text = fmtComma(price)
    priceLbl.TextXAlignment = Enum.TextXAlignment.Left
    priceLbl.ZIndex = 4
    priceLbl.Parent = priceRow

    -- ── Row 3: Buy button — full width, bottom ──
    local BTN_H = 52
    local BTN_Y = MH - BTN_H - 14

    local buyBtnBg = Instance.new("Frame")
    buyBtnBg.Size     = UDim2.fromOffset(MW - 28, BTN_H)
    buyBtnBg.Position = UDim2.fromOffset(14, BTN_Y)
    buyBtnBg.BackgroundColor3 = Config.BuyAccentDark
    buyBtnBg.BorderSizePixel = 0
    buyBtnBg.ZIndex = 2
    buyBtnBg.Parent = modal
    corner(buyBtnBg, 10)

    -- Fill animation bar
    local fillBar = Instance.new("Frame")
    fillBar.Size  = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Config.BuyAccent
    fillBar.BorderSizePixel  = 0
    fillBar.ZIndex = 3
    fillBar.Parent = buyBtnBg
    corner(fillBar, 10)

    local buyBtn = Instance.new("TextButton")
    buyBtn.Size   = UDim2.fromScale(1, 1)
    buyBtn.BackgroundTransparency = 1
    buyBtn.Text   = "Buy"
    buyBtn.Font   = Enum.Font.GothamBold
    buyBtn.TextSize = 18
    buyBtn.TextColor3 = Color3.new(1, 1, 1)
    buyBtn.AutoButtonColor = false
    buyBtn.Active = false
    buyBtn.ZIndex = 5
    buyBtn.Parent = buyBtnBg

    -- Slide modal in from below
    modal.Position = UDim2.fromScale(0.5, 0.5) -- instant

    -- Fill bar animation
    task.spawn(function()
        task.wait(0.45)
        if not fillBar or not fillBar.Parent then return end
        TweenService:Create(fillBar,
            TweenInfo.new(2.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    task.delay(0.45, function()
        if buyBtn and buyBtn.Parent then buyBtn.Active = true end
    end)

    buyBtn.MouseButton1Click:Connect(function()
        if not buyBtn.Active then return end
        buyBtn.Active = false
        -- Darken button to dark blue, keep "Buy" text
        TweenService:Create(buyBtnBg, TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(0, 40, 110)}):Play()
        TweenService:Create(fillBar, TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(0, 55, 140)}):Play()
        Config.FakeBalance = newBalance
        -- After 3s: close buy, show purchase completed, THEN gift notification
        local delaySeconds = Config.BuyDelay or 3
        task.delay(delaySeconds, function()
            if gui and gui.Parent then gui:Destroy() end
            showPurchaseDone(productInfo, recipient)
            task.delay(0.5, function()
                showGiftNotification(productInfo.Name, recipient)
            end)
        end)
    end)
end

-- ============================================================
--  HELPERS
-- ============================================================
local function findFruitByName(text)
    if not text then return nil end

    -- First try to extract the fruit name from the exact BF label format:
    -- "Gifting [username] <Permanent FruitName>" or "Permanent FruitName"
    -- This avoids matching fruit names that appear inside usernames

    -- Extract from <Permanent FruitName> pattern
    local fromTag = text:match("<Permanent%s+(.-)>") or text:match("Permanent%s+(%a+)")
    if fromTag then
        local clean = fromTag:match("^%s*(.-)%s*$") -- trim
        for _, f in ipairs(Fruits) do
            if f.name:lower() == clean:lower() then return f end
        end
    end

    -- Also try exact full-name match (for gamepasses like "2x Mastery")
    local lower = text:lower()
    for _, f in ipairs(Fruits) do
        if f.name:lower() == lower:match("^%s*(.-)%s*$") then return f end
    end

    -- Fallback: word boundary match
    for _, f in ipairs(Fruits) do
        local fname = f.name:lower()
        if lower:match("[^%a%d]" .. fname .. "[^%a%d]")
            or lower:match("^" .. fname .. "[^%a%d]")
            or lower:match("[^%a%d]" .. fname .. "$")
            or lower:match("^" .. fname .. "$") then
            return f
        end
    end
    return nil
end

local function findFruitById(id)
    for _, f in ipairs(Fruits) do
        if f.id == id then return f end
    end
    return nil
end

local function fruitToProductInfo(fruit)
    -- Items with isGamepass=true don't need "Permanent" prefix
    local displayName = fruit.isGamepass and fruit.name or ("Permanent " .. fruit.name)
    return {
        Name         = displayName,
        AssetId      = fruit.id,
        PriceInRobux = fruit.price,
        Icon         = fruit.icon,
        Outline      = fruit.outline,
        IsGamepass   = fruit.isGamepass or false,
    }
end

-- ============================================================
--  SETTINGS GUI  (Cyberpunk / Space-Neon)
-- ============================================================

-- Neon palette
local NEO_CYAN   = Color3.fromRGB(0,   220, 255)
local NEO_PURPLE = Color3.fromRGB(160,  40, 255)
local NEO_PINK   = Color3.fromRGB(255,  40, 180)
local NEO_BG     = Color3.fromRGB(8,    8,  16)
local NEO_PANEL  = Color3.fromRGB(12,  12,  22)
local NEO_CARD   = Color3.fromRGB(18,  18,  32)
local NEO_LINE   = Color3.fromRGB(0,   180, 220)

-- Config for delay (seconds)
Config.BuyDelay = 3

local PANEL_W, PANEL_H = 300, 380
local ISLAND_X_OFF = 16
local ISLAND_Y_OFF = -28

local settingsGui = Instance.new("ScreenGui")
settingsGui.Name           = "Spacehub_setting"
settingsGui.DisplayOrder   = 998
settingsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
settingsGui.ResetOnSpawn   = false
settingsGui.Parent         = playerGui

-- ── Floating island button ──────────────────────────────────
local island = Instance.new("TextButton")
island.Size             = UDim2.fromOffset(52, 52)
island.Position         = UDim2.new(0, ISLAND_X_OFF, 0.5, ISLAND_Y_OFF)
island.BackgroundColor3 = NEO_BG
island.Text             = ""
island.AutoButtonColor  = false
island.ZIndex           = 30
island.Parent           = settingsGui
corner(island, 100)

-- Glow behind island
local islandGlow = Instance.new("ImageLabel")
islandGlow.Size               = UDim2.fromOffset(76, 76)
islandGlow.AnchorPoint        = Vector2.new(0.5, 0.5)
islandGlow.Position           = UDim2.fromScale(0.5, 0.5)
islandGlow.BackgroundTransparency = 1
islandGlow.Image              = "rbxassetid://5028857084"
islandGlow.ImageColor3        = NEO_CYAN
islandGlow.ImageTransparency  = 0.35
islandGlow.ZIndex              = 29
islandGlow.Parent              = island

-- Icon inside island
local islandIcon = Instance.new("ImageLabel")
islandIcon.Size               = UDim2.fromOffset(30, 30)
islandIcon.AnchorPoint        = Vector2.new(0.5, 0.5)
islandIcon.Position           = UDim2.fromScale(0.5, 0.5)
islandIcon.BackgroundTransparency = 1
islandIcon.Image              = "rbxassetid://7072706620"  -- gear/settings icon
islandIcon.ImageColor3        = NEO_CYAN
islandIcon.ZIndex              = 31
islandIcon.Parent              = island

-- Pulsing neon ring
local ring = Instance.new("UIStroke")
ring.Color        = NEO_CYAN
ring.Thickness    = 2
ring.Transparency = 0.2
ring.Parent       = island

task.spawn(function()
    while island and island.Parent do
        TweenService:Create(ring, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.85, Color = NEO_PURPLE}):Play()
        task.wait(0.9)
        TweenService:Create(ring, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.1, Color = NEO_CYAN}):Play()
        task.wait(0.9)
    end
end)

-- ── Main Panel ───────────────────────────────────────────────
local panel = Instance.new("Frame")
panel.Size             = UDim2.fromOffset(PANEL_W, PANEL_H)
panel.BackgroundColor3 = NEO_PANEL
panel.BorderSizePixel  = 0
panel.Visible          = false
panel.ZIndex           = 20
panel.Parent           = settingsGui
corner(panel, 14)

-- Neon border (gradient-like: cyan stroke)
local panelStroke = Instance.new("UIStroke")
panelStroke.Color        = NEO_CYAN
panelStroke.Thickness    = 1.5
panelStroke.Transparency = 0.1
panelStroke.Parent       = panel

-- Scanline texture overlay
local scanline = Instance.new("ImageLabel")
scanline.Size               = UDim2.fromScale(1, 1)
scanline.BackgroundTransparency = 1
scanline.Image              = "rbxassetid://6630607298"
scanline.ImageTransparency  = 0.92
scanline.ZIndex              = 21
scanline.Parent              = panel

local function updatePanelPos()
    local ix = island.Position.X.Offset
    local iy = island.Position.Y.Offset
    panel.Position = UDim2.new(0, ix + 62, 0.5, iy - PANEL_H/2 + 26)
end
updatePanelPos()

-- ── Panel Header ─────────────────────────────────────────────
local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = NEO_BG
header.BorderSizePixel  = 0
header.ZIndex           = 22
header.Parent           = panel
corner(header, 14)
-- fix bottom corners square
local headerFix = Instance.new("Frame")
headerFix.Size             = UDim2.new(1, 0, 0.5, 0)
headerFix.Position         = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = NEO_BG
headerFix.BorderSizePixel  = 0
headerFix.ZIndex           = 22
headerFix.Parent           = header

-- Cyan accent line under header
local headerLine = Instance.new("Frame")
headerLine.Size             = UDim2.new(1, 0, 0, 2)
headerLine.Position         = UDim2.new(0, 0, 1, -2)
headerLine.BackgroundColor3 = NEO_CYAN
headerLine.BorderSizePixel  = 0
headerLine.ZIndex           = 23
headerLine.Parent           = header

-- Title text
local titleLbl = Instance.new("TextLabel")
titleLbl.BackgroundTransparency = 1
titleLbl.Size     = UDim2.new(1, -52, 1, 0)
titleLbl.Position = UDim2.fromOffset(12, 0)
titleLbl.Font     = Enum.Font.GothamBlack
titleLbl.TextSize = 13
titleLbl.TextColor3 = NEO_CYAN
titleLbl.Text     = "⚡  SPACEHUB  •  BLOX FRUITS"
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex   = 23
titleLbl.Parent   = header

-- Minimise panel button (−) top-right of panel
local panelClose = Instance.new("ImageButton")
panelClose.Size               = UDim2.fromOffset(28, 28)
panelClose.Position           = UDim2.new(1, -36, 0, 8)
panelClose.BackgroundColor3   = Color3.fromRGB(20, 20, 36)
panelClose.Image              = "rbxassetid://92232500754851"
panelClose.ImageColor3        = NEO_CYAN
panelClose.AutoButtonColor    = false
panelClose.ZIndex             = 28
panelClose.Parent             = panel
corner(panelClose, 6)
stroke(panelClose, NEO_CYAN, 1, 0.4)

-- ── DESTROY / KILL button — own ScreenGui so it's always on top ──
local killGui = Instance.new("ScreenGui")
killGui.Name           = "HuyVuong_KillBtn"
killGui.DisplayOrder   = 9999
killGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
killGui.ResetOnSpawn   = false
killGui.Parent         = playerGui

local killBtn = Instance.new("ImageButton")
killBtn.Size             = UDim2.fromOffset(36, 36)
killBtn.Position         = UDim2.new(1, -12, 0, 12)
killBtn.AnchorPoint      = Vector2.new(1, 0)
killBtn.BackgroundColor3 = Color3.fromRGB(160, 10, 35)
killBtn.Image            = "rbxassetid://92232500754851"
killBtn.ImageColor3      = Color3.new(1, 1, 1)
killBtn.AutoButtonColor  = false
killBtn.ZIndex           = 1
killBtn.Parent           = killGui
corner(killBtn, 8)
stroke(killBtn, Color3.fromRGB(255, 60, 80), 2, 0)

-- Pulse glow on kill button
task.spawn(function()
    while killBtn and killBtn.Parent do
        TweenService:Create(killBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {BackgroundColor3 = Color3.fromRGB(220, 20, 55)}):Play()
        task.wait(1)
        TweenService:Create(killBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {BackgroundColor3 = Color3.fromRGB(140, 5, 25)}):Play()
        task.wait(1)
    end
end)

killBtn.MouseButton1Click:Connect(function()
    killGui:Destroy()
    settingsGui:Destroy()
end)

-- ── Section helper ────────────────────────────────────────────
local function neonCard(yOff, h)
    local card = Instance.new("Frame")
    card.Size             = UDim2.new(1, -24, 0, h)
    card.Position         = UDim2.fromOffset(12, yOff)
    card.BackgroundColor3 = NEO_CARD
    card.BorderSizePixel  = 0
    card.ZIndex           = 22
    card.Parent           = panel
    corner(card, 8)
    local cs = Instance.new("UIStroke")
    cs.Color        = NEO_PURPLE
    cs.Thickness    = 1
    cs.Transparency = 0.5
    cs.Parent       = card
    return card
end

local function neonLabel(parent, txt, yOff, size, col)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size     = UDim2.new(1, -12, 0, 18)
    l.Position = UDim2.fromOffset(8, yOff)
    l.Font     = Enum.Font.GothamBold
    l.TextSize = size or 10
    l.TextColor3 = col or Color3.fromRGB(140, 200, 255)
    l.Text     = txt
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex   = 23
    l.Parent   = parent
    return l
end

-- ── CARD 1: Fake Balance ──────────────────────────────────────
local card1 = neonCard(54, 90)
neonLabel(card1, "◈  FAKE ROBUX BALANCE", 6, 10, NEO_CYAN)

local balBox = Instance.new("TextBox")
balBox.Size               = UDim2.new(1, -16, 0, 30)
balBox.Position           = UDim2.fromOffset(8, 26)
balBox.BackgroundColor3   = Color3.fromRGB(6, 6, 14)
balBox.BorderSizePixel    = 0
balBox.Text               = tostring(Config.FakeBalance)
balBox.PlaceholderText    = "e.g. 5000000"
balBox.Font               = Enum.Font.GothamMedium
balBox.TextSize           = 13
balBox.TextColor3         = NEO_CYAN
balBox.PlaceholderColor3  = Color3.fromRGB(60, 80, 100)
balBox.ClearTextOnFocus   = false
balBox.ZIndex             = 23
balBox.Parent             = card1
corner(balBox, 6)
stroke(balBox, NEO_CYAN, 1, 0.4)

local applyBtn = Instance.new("TextButton")
applyBtn.Size             = UDim2.new(1, -16, 0, 22)
applyBtn.Position         = UDim2.fromOffset(8, 60)
applyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
applyBtn.Text             = "▶  APPLY BALANCE"
applyBtn.Font             = Enum.Font.GothamBlack
applyBtn.TextSize         = 10
applyBtn.TextColor3       = NEO_CYAN
applyBtn.AutoButtonColor  = false
applyBtn.ZIndex           = 23
applyBtn.Parent           = card1
corner(applyBtn, 5)
stroke(applyBtn, NEO_CYAN, 1, 0.3)

local applyDebounce = false
applyBtn.MouseButton1Click:Connect(function()
    if applyDebounce then return end
    applyDebounce = true
    local raw = balBox.Text:gsub("[,%s]","")
    local v = tonumber(raw)
    if v and v > 0 then Config.FakeBalance = v end
    applyBtn.Text             = "✔  APPLIED!"
    applyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
    stroke(applyBtn, Color3.fromRGB(0, 255, 120), 1, 0.1)
    task.delay(1.5, function()
        if not applyBtn or not applyBtn.Parent then return end
        applyBtn.Text             = "▶  APPLY BALANCE"
        applyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
        stroke(applyBtn, NEO_CYAN, 1, 0.3)
        applyDebounce = false
    end)
end)

-- ── CARD 2: Buy Delay ─────────────────────────────────────────
local card2 = neonCard(154, 116)
neonLabel(card2, "⏱  BUY DELAY (seconds)", 6, 10, NEO_PINK)

-- Current delay display
local delayDisplay = Instance.new("TextLabel")
delayDisplay.BackgroundTransparency = 1
delayDisplay.Size     = UDim2.fromOffset(48, 32)
delayDisplay.Position = UDim2.new(0.5, -24, 0, 22)
delayDisplay.Font     = Enum.Font.GothamBlack
delayDisplay.TextSize = 26
delayDisplay.TextColor3 = NEO_PINK
delayDisplay.Text     = tostring(Config.BuyDelay) .. "s"
delayDisplay.TextXAlignment = Enum.TextXAlignment.Center
delayDisplay.ZIndex   = 23
delayDisplay.Parent   = card2

-- Minus button
local minusBtn = Instance.new("TextButton")
minusBtn.Size             = UDim2.fromOffset(34, 34)
minusBtn.Position         = UDim2.fromOffset(10, 20)
minusBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 28)
minusBtn.Text             = "−"
minusBtn.Font             = Enum.Font.GothamBold
minusBtn.TextSize         = 22
minusBtn.TextColor3       = NEO_PINK
minusBtn.AutoButtonColor  = false
minusBtn.ZIndex           = 23
minusBtn.Parent           = card2
corner(minusBtn, 6)
stroke(minusBtn, NEO_PINK, 1, 0.3)

-- Plus button
local plusBtn = Instance.new("TextButton")
plusBtn.Size             = UDim2.fromOffset(34, 34)
plusBtn.Position         = UDim2.new(1, -44, 0, 20)
plusBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 28)
plusBtn.Text             = "+"
plusBtn.Font             = Enum.Font.GothamBold
plusBtn.TextSize         = 22
plusBtn.TextColor3       = NEO_PINK
plusBtn.AutoButtonColor  = false
plusBtn.ZIndex           = 23
plusBtn.Parent           = card2
corner(plusBtn, 6)
stroke(plusBtn, NEO_PINK, 1, 0.3)

minusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay > 1 then
        Config.BuyDelay = Config.BuyDelay - 1
        delayDisplay.Text = tostring(Config.BuyDelay) .. "s"
    end
end)
plusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay < 30 then
        Config.BuyDelay = Config.BuyDelay + 1
        delayDisplay.Text = tostring(Config.BuyDelay) .. "s"
    end
end)

-- Delay presets
local presets = {1, 3, 5, 10}
local presetRow = Instance.new("Frame")
presetRow.Size             = UDim2.new(1, -16, 0, 24)
presetRow.Position         = UDim2.fromOffset(8, 82)
presetRow.BackgroundTransparency = 1
presetRow.ZIndex           = 23
presetRow.Parent           = card2

for i, sec in ipairs(presets) do
    local pb = Instance.new("TextButton")
    pb.Size             = UDim2.new(0.23, -3, 1, 0)
    pb.Position         = UDim2.new((i-1)*0.25, 2, 0, 0)
    pb.BackgroundColor3 = Color3.fromRGB(10, 10, 24)
    pb.Text             = sec .. "s"
    pb.Font             = Enum.Font.GothamBold
    pb.TextSize         = 11
    pb.TextColor3       = NEO_PINK
    pb.AutoButtonColor  = false
    pb.ZIndex           = 24
    pb.Parent           = presetRow
    corner(pb, 5)
    stroke(pb, NEO_PINK, 1, 0.55)
    pb.MouseButton1Click:Connect(function()
        Config.BuyDelay = sec
        delayDisplay.Text = sec .. "s"
    end)
end

-- ── CARD 3: Language Selection ───────────────────────────────────
local card3 = neonCard(280, 70)
neonLabel(card3, "🌐  LANGUAGE", 8, 10, NEO_CYAN)

local langs = {"English", "Vietnamese", "Spanish"}
local langRow = Instance.new("Frame")
langRow.Size             = UDim2.new(1, -16, 0, 32)
langRow.Position         = UDim2.fromOffset(8, 28)
langRow.BackgroundTransparency = 1
langRow.ZIndex           = 23
langRow.Parent           = card3

for i, langName in ipairs(langs) do
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(0.31, -3, 1, 0)
    btn.Position         = UDim2.new((i-1)*0.33, 2, 0, 0)
    btn.BackgroundColor3 = (Lang.current == langName) and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(10, 10, 24)
    btn.Text             = langName:sub(1,3):upper()
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 11
    btn.TextColor3       = NEO_CYAN
    btn.AutoButtonColor  = false
    btn.ZIndex           = 24
    btn.Parent           = langRow
    corner(btn, 5)
    stroke(btn, NEO_CYAN, 1, 0.4)
    
    btn.MouseButton1Click:Connect(function()
        Lang.current = langName
        -- Update button colors
        for j, b in ipairs(langRow:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = (Lang.current == langs[j]) and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(10, 10, 24)
            end
        end
    end)
end

-- ── Panel open/close logic ───────────────────────────────────
local panelOpen = false
local dragMoved = false

do
    local dragging  = false
    local dragStart = nil
    local startPos  = nil

    island.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragMoved = false
            dragStart = i.Position
            startPos  = island.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType == Enum.UserInputType.MouseMovement or
           i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - dragStart
            if math.abs(d.X) > 6 or math.abs(d.Y) > 6 then
                dragMoved = true
                island.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y)
                updatePanelPos()
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

island.MouseButton1Click:Connect(function()
    if dragMoved then return end
    if not panelOpen then
        panelOpen = true
        updatePanelPos()
        -- Start from island position, scale out + fade in
        panel.Size             = UDim2.fromOffset(0, 0)
        panel.BackgroundTransparency = 1
        panel.Visible          = true
        TweenService:Create(panel,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.fromOffset(PANEL_W, PANEL_H)}):Play()
        TweenService:Create(panel,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}):Play()
        -- Animate stroke glow in
        panelStroke.Transparency = 1
        TweenService:Create(panelStroke,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Transparency = 0.1}):Play()
    end
end)

panelClose.MouseButton1Click:Connect(function()
    panelOpen = false
    TweenService:Create(panel,
        TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(panelStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Transparency = 1}):Play()
    task.delay(0.23, function()
        if panel and panel.Parent then panel.Visible = false end
    end)
end)

-- ============================================================
--  HOOK
-- ============================================================
local hookedBtns    = {}
local lastFruit     = nil
local lastRecipient = ""

local function scanGiftingLabel()
    for _, desc in ipairs(playerGui:GetDescendants()) do
        if (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
            local t = desc.Text or ""
            -- Match both "Gifting [user] <Permanent X>" and "Gifting [user] <X>"
            if t:find("Gifting") and t:find("%[") then
                local u = t:match("%[(.-)%]")
                if u and u ~= "" then lastRecipient = u end
                -- Extract name from <...> tag
                local tagged = t:match("<(.-)>")
                if tagged then
                    -- Try with "Permanent " stripped
                    local clean = tagged:match("^Permanent%s+(.+)$") or tagged
                    clean = clean:match("^%s*(.-)%s*$")
                    -- Search all fruits/gamepasses
                    for _, f in ipairs(Fruits) do
                        if f.name:lower() == clean:lower() then
                            lastFruit = f
                            break
                        end
                    end
                    -- Fallback: findFruitByName on full afterBracket text
                    if not lastFruit then
                        local afterBracket = t:match("%]%s*(.+)$") or t
                        local f = findFruitByName(afterBracket)
                        if f then lastFruit = f end
                    end
                else
                    local afterBracket = t:match("%]%s*(.+)$") or t
                    local f = findFruitByName(afterBracket)
                    if f then lastFruit = f end
                end
            end
        end
    end
end

-- LAYER 1: hookmetamethod — block the real purchase prompt entirely
pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if self == MarketplaceService and
           (method == "PromptGamePassPurchase" or
            method == "PromptProductPurchase"  or
            method == "PromptPurchase") then
            scanGiftingLabel()
            local id    = tonumber(select(2, ...))
            local fruit = (id and findFruitById(id)) or lastFruit
            if fruit then
                local r = lastRecipient ~= "" and lastRecipient or "Unknown"
                task.defer(function() showBuyModal(fruitToProductInfo(fruit), r) end)
                return  -- block real prompt
            end
        end
        return old(self, ...)
    end))
end)

-- LAYER 2: nuke Roblox purchase prompt GUIs
local ROBLOX_PURCHASE_GUIS = {
    ["RobloxPromptGui"] = true,
    ["PurchasePrompt"]  = true,
    ["RobuxPurchase"]   = true,
}
task.spawn(function()
    while true do
        task.wait(0.05)
        for _, sg in ipairs(playerGui:GetChildren()) do
            if sg:IsA("ScreenGui") and ROBLOX_PURCHASE_GUIS[sg.Name] then
                scanGiftingLabel()
                local fruit = lastFruit
                local r     = lastRecipient ~= "" and lastRecipient or "Unknown"
                sg:Destroy()
                if fruit then
                    task.defer(function() showBuyModal(fruitToProductInfo(fruit), r) end)
                end
            end
        end
    end
end)

-- LAYER 3: overlay on gift confirm buttons (invisible button on top, disables original click)
local function hookConfirmButton(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if hookedBtns[btn] then return end
    if btn:IsDescendantOf(settingsGui) then return end
    local sg = btn:FindFirstAncestorWhichIsA("ScreenGui")
    if sg and (sg.Name:find("HazeHub") or sg.Name:find("HuyVuong")) then return end
    if btn:FindFirstChild("_HazeOverlay") then return end

    local text = (btn.Text or ""):lower()
    local name = (btn.Name or ""):lower()

    local isInsideGiftModal = false
    local p = btn.Parent
    for _ = 1, 8 do
        if not p then break end
        if p:IsA("TextLabel") or p:IsA("TextButton") then
            local t = (p.Text or ""):lower()
            if t:find("send a gift") or t:find("gifting") then
                isInsideGiftModal = true; break
            end
        end
        for _, ch in ipairs(p:GetChildren()) do
            if (ch:IsA("TextLabel") or ch:IsA("TextButton")) then
                local t = (ch.Text or ""):lower()
                if t:find("send a gift") or t:find("gifting") then
                    isInsideGiftModal = true; break
                end
            end
        end
        if isInsideGiftModal then break end
        p = p.Parent
    end

    local isConfirm      = (text:find("🎁") or text:match("^%d+$") or text:match("^%d+,%d+$")) and true or false
    local isNamedConfirm = name:find("buy") or name:find("confirm") or name:find("purchase") or name:find("gift") or name:find("price") or name:find("robux")

    if not (isInsideGiftModal or isConfirm or isNamedConfirm) then return end

    hookedBtns[btn] = true
    btn.MouseEnter:Connect(function() scanGiftingLabel() end)

    -- Invisible overlay that intercepts click BEFORE game handles it
    local overlay = Instance.new("TextButton")
    overlay.Name = "_HazeOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = (btn.ZIndex or 1) + 50
    overlay.Parent = btn

    pcall(function()
        if getconnections then
            for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do pcall(function() conn:Disable() end) end
            for _, conn in ipairs(getconnections(btn.Activated))         do pcall(function() conn:Disable() end) end
        end
    end)

    overlay.MouseButton1Click:Connect(function()
        scanGiftingLabel()
        local fruit = lastFruit
        local r     = lastRecipient ~= "" and lastRecipient or "Unknown"
        if fruit then showBuyModal(fruitToProductInfo(fruit), r) end
    end)
end

for _, v in ipairs(playerGui:GetDescendants()) do
    task.defer(function() if v and v.Parent then hookConfirmButton(v) end end)
end

playerGui.DescendantAdded:Connect(function(d)
    task.delay(0.05, function()
        if d and d.Parent then hookConfirmButton(d) end
        if (d:IsA("TextLabel") or d:IsA("TextButton")) then
            local t = d.Text or ""
            if t:find("Gifting") and t:find("Permanent") then scanGiftingLabel() end
        end
    end)
end)

task.spawn(function()
    while true do task.wait(0.3); scanGiftingLabel() end
end)

print("[SPACEHUB] Loaded! Dough now has its own icon. Go to Permanent Fruit Shop → Gift → pick user → click price button.")
