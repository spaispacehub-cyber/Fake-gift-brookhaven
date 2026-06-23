--=============================================================--
--  ROBLOX FLAT ECONOMY UI  —  Buy Modal + Success Modal
--  Giong chinh xac phong cach Roblox Native (theo anh tham khao)
--  Tu dong mo Buy Modal ngay khi chay LocalScript
--=============================================================--

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lplr         = Players.LocalPlayer
local PlayerGui    = Lplr:WaitForChild("PlayerGui")

-----------------------------------------------------------------
--  THEME — bam sat mau Roblox goc
-----------------------------------------------------------------
local T = {
    ModalBg      = Color3.fromRGB(27, 27, 31),   -- nen modal den xam dam
    PlusBarBg    = Color3.fromRGB(36, 36, 41),   -- nen thanh Plus
    PlusBarBorder= Color3.fromRGB(60, 60, 68),

    AccentBlue   = Color3.fromRGB(66, 99, 235),  -- xanh Roblox goc
    ProgressHi   = Color3.fromRGB(100, 135, 255),-- progress sang hon

    TextPrimary  = Color3.new(1, 1, 1),
    TextSub      = Color3.fromRGB(178, 178, 190),
    TextLink     = Color3.fromRGB(220, 220, 220),

    CloseIdle    = Color3.fromRGB(140, 140, 150),
    CloseHover   = Color3.new(1, 1, 1),
    OverlayBg    = Color3.new(0, 0, 0),

    CircleStroke = Color3.fromRGB(200, 200, 210), -- vong tron tick
}

-----------------------------------------------------------------
--  DU LIEU MAU
-----------------------------------------------------------------
local ITEM_NAME     = "Donation"
local ITEM_PRICE    = 10000
local WALLET        = 3098112

local function fmt(n)
    return tostring(math.floor(n)):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,","")
end

-----------------------------------------------------------------
--  TWEEN INFO
-----------------------------------------------------------------
local TI_OVL   = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_IN    = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_OUT   = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

-----------------------------------------------------------------
--  ROOT GUI
-----------------------------------------------------------------
local SG = Instance.new("ScreenGui")
SG.Name            = "RobloxEconomyUI"
SG.DisplayOrder    = 100000
SG.IgnoreGuiInset  = true
SG.ResetOnSpawn    = false
SG.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
SG.Parent          = PlayerGui

-----------------------------------------------------------------
--  HELPER — nut dong X
-----------------------------------------------------------------
local function makeX(parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size               = UDim2.new(0, 32, 0, 32)
    btn.BackgroundTransparency = 1
    btn.Text               = "✕"
    btn.TextColor3         = T.CloseIdle
    btn.Font               = Enum.Font.GothamSemibold
    btn.TextSize           = 18
    btn.ZIndex             = 10

    local function hover(on)
        TweenService:Create(btn, TweenInfo.new(0.12),
            {TextColor3 = on and T.CloseHover or T.CloseIdle}):Play()
    end
    btn.MouseEnter:Connect(function() hover(true) end)
    btn.MouseLeave:Connect(function() hover(false) end)
    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then hover(true) end
    end)
    btn.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then hover(false) end
    end)
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

-----------------------------------------------------------------
--  HELPER — Robux icon placeholder (hexagon style)
-----------------------------------------------------------------
local function makeRobuxIcon(parent, size)
    local f = Instance.new("Frame", parent)
    f.Size              = UDim2.new(0, size, 0, size)
    f.BackgroundColor3  = Color3.fromRGB(220, 220, 220)
    f.BorderSizePixel   = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, math.floor(size * 0.28))

    local lbl = Instance.new("TextLabel", f)
    lbl.Size               = UDim2.fromScale(1, 1)
    lbl.BackgroundTransparency = 1
    lbl.Text               = "R$"
    lbl.TextColor3         = Color3.fromRGB(40, 40, 40)
    lbl.Font               = Enum.Font.GothamBold
    lbl.TextSize           = math.max(7, math.floor(size * 0.50))
    return f
end

-----------------------------------------------------------------
--  MODAL ENGINE — overlay + slide + scale
-----------------------------------------------------------------
local function newEngine()
    local overlay = Instance.new("TextButton", SG)
    overlay.Size               = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3   = T.OverlayBg
    overlay.BackgroundTransparency = 1
    overlay.AutoButtonColor    = false
    overlay.Text               = ""
    overlay.Visible            = false
    overlay.ZIndex             = 5

    local function show(panel, sc)
        overlay.Visible = true
        overlay.BackgroundTransparency = 1
        sc.Scale        = 0.97
        panel.Position  = UDim2.new(0.5, 0, 0.5, 18)

        TweenService:Create(overlay, TI_OVL,  {BackgroundTransparency = 0.42}):Play()
        TweenService:Create(sc,      TI_IN,   {Scale    = 1.0}):Play()
        TweenService:Create(panel,   TI_IN,   {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    end

    local function hide(sc, done)
        TweenService:Create(overlay, TI_OUT, {BackgroundTransparency = 1}):Play()
        local t = TweenService:Create(sc, TI_OUT, {Scale = 0.97})
        t:Play()
        t.Completed:Connect(function()
            overlay.Visible = false
            if done then done() end
        end)
    end

    return overlay, show, hide
end

-----------------------------------------------------------------
--  SUCCESS MODAL
-----------------------------------------------------------------
local succOvl, showSucc, hideSucc = newEngine()

local SuccPanel = Instance.new("Frame", succOvl)
SuccPanel.Name            = "SuccessPanel"
SuccPanel.Size            = UDim2.new(0, 500, 0, 320)
SuccPanel.AnchorPoint     = Vector2.new(0.5, 0.5)
SuccPanel.Position        = UDim2.new(0.5, 0, 0.5, 18)
SuccPanel.BackgroundColor3 = T.ModalBg
SuccPanel.BorderSizePixel = 0
SuccPanel.ZIndex          = 6
Instance.new("UICorner", SuccPanel).CornerRadius = UDim.new(0, 18)

local SSc = Instance.new("UIScale", SuccPanel)

-- Header: "Purchase completed" + X
local SHdr = Instance.new("Frame", SuccPanel)
SHdr.Size             = UDim2.new(1, -32, 0, 60)
SHdr.Position         = UDim2.new(0, 16, 0, 0)
SHdr.BackgroundTransparency = 1

local STitleLbl = Instance.new("TextLabel", SHdr)
STitleLbl.Size            = UDim2.new(1, -40, 1, 0)
STitleLbl.BackgroundTransparency = 1
STitleLbl.Text            = "Purchase completed"
STitleLbl.TextColor3      = T.TextPrimary
STitleLbl.Font            = Enum.Font.GothamBold
STitleLbl.TextSize        = 20
STitleLbl.TextXAlignment  = Enum.TextXAlignment.Left
STitleLbl.TextYAlignment  = Enum.TextYAlignment.Center

local SCloseX = makeX(SHdr, nil)
SCloseX.AnchorPoint = Vector2.new(1, 0.5)
SCloseX.Position    = UDim2.new(1, 0, 0.5, 0)

-- Vong tron outline + tick (giong anh 2: khong fill, chi vien)
local CircleWrap = Instance.new("Frame", SuccPanel)
CircleWrap.Size            = UDim2.new(0, 80, 0, 80)
CircleWrap.AnchorPoint     = Vector2.new(0.5, 0)
CircleWrap.Position        = UDim2.new(0.5, 0, 0, 64)
CircleWrap.BackgroundTransparency = 1

-- Vong tron (dung UIStroke de tao vien)
local CircleFill = Instance.new("Frame", CircleWrap)
CircleFill.Size            = UDim2.fromScale(1, 1)
CircleFill.BackgroundColor3 = T.ModalBg   -- cung mau nen => trong suot
CircleFill.BorderSizePixel = 0
Instance.new("UICorner", CircleFill).CornerRadius = UDim.new(1, 0)

local CircleStroke = Instance.new("UIStroke", CircleFill)
CircleStroke.Color     = T.CircleStroke
CircleStroke.Thickness = 2.5
CircleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Dau tick ben trong
local TickLbl = Instance.new("TextLabel", CircleFill)
TickLbl.Size              = UDim2.fromScale(1, 1)
TickLbl.BackgroundTransparency = 1
TickLbl.Text              = "✓"
TickLbl.TextColor3        = T.TextPrimary
TickLbl.Font              = Enum.Font.GothamBold
TickLbl.TextSize          = 36

-- Sub text
local SSubLbl = Instance.new("TextLabel", SuccPanel)
SSubLbl.Size              = UDim2.new(1, -40, 0, 28)
SSubLbl.AnchorPoint       = Vector2.new(0.5, 0)
SSubLbl.Position          = UDim2.new(0.5, 0, 0, 158)
SSubLbl.BackgroundTransparency = 1
SSubLbl.Text              = "You have successfully bought"
SSubLbl.TextColor3        = T.TextSub
SSubLbl.Font              = Enum.Font.Gotham
SSubLbl.TextSize          = 15
SSubLbl.TextXAlignment    = Enum.TextXAlignment.Center

-- Nut OK
local OKFrame = Instance.new("Frame", SuccPanel)
OKFrame.Size              = UDim2.new(1, -32, 0, 48)
OKFrame.AnchorPoint       = Vector2.new(0.5, 1)
OKFrame.Position          = UDim2.new(0.5, 0, 1, -16)
OKFrame.BackgroundColor3  = T.AccentBlue
OKFrame.BorderSizePixel   = 0
Instance.new("UICorner", OKFrame).CornerRadius = UDim.new(0, 10)

local OKBtn = Instance.new("TextButton", OKFrame)
OKBtn.Size                = UDim2.fromScale(1, 1)
OKBtn.BackgroundTransparency = 1
OKBtn.Text                = "OK"
OKBtn.TextColor3          = T.TextPrimary
OKBtn.Font                = Enum.Font.GothamBold
OKBtn.TextSize            = 16

-----------------------------------------------------------------
--  BUY MODAL
-----------------------------------------------------------------
local buyOvl, showBuy, hideBuy = newEngine()

-- Panel: rong, dep (bam sat ty le anh 1)
local BuyPanel = Instance.new("Frame", buyOvl)
BuyPanel.Name             = "BuyPanel"
BuyPanel.Size             = UDim2.new(0, 500, 0, 270)
BuyPanel.AnchorPoint      = Vector2.new(0.5, 0.5)
BuyPanel.Position         = UDim2.new(0.5, 0, 0.5, 18)
BuyPanel.BackgroundColor3 = T.ModalBg
BuyPanel.BorderSizePixel  = 0
BuyPanel.ZIndex           = 6
Instance.new("UICorner", BuyPanel).CornerRadius = UDim.new(0, 18)

local BSc = Instance.new("UIScale", BuyPanel)

-- ── HEADER: "Buy item"  |  [R$] [3,098,112]  [X] ────────────
local BHdr = Instance.new("Frame", BuyPanel)
BHdr.Size             = UDim2.new(1, -32, 0, 56)
BHdr.Position         = UDim2.new(0, 16, 0, 0)
BHdr.BackgroundTransparency = 1

local BTitleLbl = Instance.new("TextLabel", BHdr)
BTitleLbl.Size            = UDim2.new(0.5, 0, 1, 0)
BTitleLbl.BackgroundTransparency = 1
BTitleLbl.Text            = "Buy item"
BTitleLbl.TextColor3      = T.TextPrimary
BTitleLbl.Font            = Enum.Font.GothamBold
BTitleLbl.TextSize        = 20
BTitleLbl.TextXAlignment  = Enum.TextXAlignment.Left
BTitleLbl.TextYAlignment  = Enum.TextYAlignment.Center

-- Cum phai: [Icon] [Balance] [X]
local BRightRow = Instance.new("Frame", BHdr)
BRightRow.Size            = UDim2.new(0.5, 0, 1, 0)
BRightRow.Position        = UDim2.new(0.5, 0, 0, 0)
BRightRow.BackgroundTransparency = 1

local BRLayout = Instance.new("UIListLayout", BRightRow)
BRLayout.FillDirection    = Enum.FillDirection.Horizontal
BRLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BRLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
BRLayout.SortOrder        = Enum.SortOrder.LayoutOrder
BRLayout.Padding          = UDim.new(0, 7)

local BRobuxIcon = makeRobuxIcon(BRightRow, 20)
BRobuxIcon.LayoutOrder    = 1

local BBalanceLbl = Instance.new("TextLabel", BRightRow)
BBalanceLbl.Size          = UDim2.new(0, 0, 0, 22)
BBalanceLbl.AutomaticSize = Enum.AutomaticSize.X
BBalanceLbl.BackgroundTransparency = 1
BBalanceLbl.Text          = fmt(WALLET)
BBalanceLbl.TextColor3    = T.TextPrimary
BBalanceLbl.Font          = Enum.Font.GothamSemibold
BBalanceLbl.TextSize      = 15
BBalanceLbl.LayoutOrder   = 2

local BXBtn = makeX(BRightRow, nil)
BXBtn.AnchorPoint   = Vector2.new(0, 0.5)
BXBtn.Position      = UDim2.new(0, 0, 0.5, 0)
BXBtn.LayoutOrder   = 3
BXBtn.Size          = UDim2.new(0, 30, 0, 30)

-- ── ITEM SECTION: Ten + Gia (khong co anh, khong co card) ────
-- Khop voi anh 1: chi text "Donation" va "R$ 10,000"

local ItemNameLbl = Instance.new("TextLabel", BuyPanel)
ItemNameLbl.Size          = UDim2.new(1, -32, 0, 28)
ItemNameLbl.Position      = UDim2.new(0, 16, 0, 60)
ItemNameLbl.BackgroundTransparency = 1
ItemNameLbl.Text          = ITEM_NAME
ItemNameLbl.TextColor3    = T.TextPrimary
ItemNameLbl.Font          = Enum.Font.GothamBold
ItemNameLbl.TextSize      = 16
ItemNameLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Hang gia: [icon] [so]
local PriceRow = Instance.new("Frame", BuyPanel)
PriceRow.Size             = UDim2.new(0, 0, 0, 22)
PriceRow.AutomaticSize    = Enum.AutomaticSize.X
PriceRow.Position         = UDim2.new(0, 16, 0, 91)
PriceRow.BackgroundTransparency = 1

local PRLayout = Instance.new("UIListLayout", PriceRow)
PRLayout.FillDirection    = Enum.FillDirection.Horizontal
PRLayout.VerticalAlignment = Enum.VerticalAlignment.Center
PRLayout.SortOrder        = Enum.SortOrder.LayoutOrder
PRLayout.Padding          = UDim.new(0, 6)

local PRIcon = makeRobuxIcon(PriceRow, 18)
PRIcon.LayoutOrder        = 1

local PriceLbl = Instance.new("TextLabel", PriceRow)
PriceLbl.Size             = UDim2.new(0, 0, 0, 22)
PriceLbl.AutomaticSize    = Enum.AutomaticSize.X
PriceLbl.BackgroundTransparency = 1
PriceLbl.Text             = fmt(ITEM_PRICE)
PriceLbl.TextColor3       = T.TextPrimary
PriceLbl.Font             = Enum.Font.GothamBold
PriceLbl.TextSize         = 15
PriceLbl.LayoutOrder      = 2

-- ── NUT BUY voi PROGRESS BAR ben trong ───────────────────────
local BuyBtnFrame = Instance.new("Frame", BuyPanel)
BuyBtnFrame.Name          = "BuyBtnFrame"
BuyBtnFrame.Size          = UDim2.new(1, -32, 0, 48)
BuyBtnFrame.Position      = UDim2.new(0, 16, 0, 138)
BuyBtnFrame.BackgroundColor3 = T.AccentBlue
BuyBtnFrame.BorderSizePixel = 0
BuyBtnFrame.ClipsDescendants = true
Instance.new("UICorner", BuyBtnFrame).CornerRadius = UDim.new(0, 10)

-- Progress bar (chay ngam, sang hon nut)
local ProgBar = Instance.new("Frame", BuyBtnFrame)
ProgBar.Name              = "ProgressBar"
ProgBar.Size              = UDim2.new(0, 0, 1, 0)
ProgBar.BackgroundColor3  = T.ProgressHi
ProgBar.BorderSizePixel   = 0
ProgBar.ZIndex            = 1

-- Chu "Buy" luon tren cung (ZIndex 2)
local BuyBtn = Instance.new("TextButton", BuyBtnFrame)
BuyBtn.Size               = UDim2.fromScale(1, 1)
BuyBtn.BackgroundTransparency = 1
BuyBtn.Text               = "Buy"
BuyBtn.TextColor3         = T.TextPrimary
BuyBtn.Font               = Enum.Font.GothamBold
BuyBtn.TextSize           = 16
BuyBtn.ZIndex             = 2

-- ── ROBLOX PLUS BAR ──────────────────────────────────────────
-- Bam sat anh 1: vien nhe, nen toi hon modal, vien border
local PlusFrame = Instance.new("Frame", BuyPanel)
PlusFrame.Size            = UDim2.new(1, -32, 0, 42)
PlusFrame.AnchorPoint     = Vector2.new(0, 1)
PlusFrame.Position        = UDim2.new(0, 16, 1, -14)
PlusFrame.BackgroundColor3 = T.PlusBarBg
PlusFrame.BorderSizePixel = 0
Instance.new("UICorner", PlusFrame).CornerRadius = UDim.new(0, 10)

local PlusStroke = Instance.new("UIStroke", PlusFrame)
PlusStroke.Color          = T.PlusBarBorder
PlusStroke.Thickness      = 1
PlusStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local PadPlus = Instance.new("UIPadding", PlusFrame)
PadPlus.PaddingLeft  = UDim.new(0, 12)
PadPlus.PaddingRight = UDim.new(0, 12)

local PlusRowLayout = Instance.new("UIListLayout", PlusFrame)
PlusRowLayout.FillDirection  = Enum.FillDirection.Horizontal
PlusRowLayout.VerticalAlignment = Enum.VerticalAlignment.Center
PlusRowLayout.SortOrder      = Enum.SortOrder.LayoutOrder
PlusRowLayout.Padding        = UDim.new(0, 8)

-- Icon Roblox Plus (P tron, vien trang)
local PlusIcon = Instance.new("Frame", PlusFrame)
PlusIcon.Size             = UDim2.new(0, 22, 0, 22)
PlusIcon.BackgroundColor3 = T.ModalBg
PlusIcon.BorderSizePixel  = 0
PlusIcon.LayoutOrder      = 1
Instance.new("UICorner", PlusIcon).CornerRadius = UDim.new(1, 0)

local PIStroke = Instance.new("UIStroke", PlusIcon)
PIStroke.Color     = T.TextSub
PIStroke.Thickness = 1.5

local PILbl = Instance.new("TextLabel", PlusIcon)
PILbl.Size               = UDim2.fromScale(1, 1)
PILbl.BackgroundTransparency = 1
PILbl.Text               = "P"
PILbl.TextColor3         = T.TextSub
PILbl.Font               = Enum.Font.GothamBold
PILbl.TextSize           = 12

-- Text chinh
local PlusMainLbl = Instance.new("TextLabel", PlusFrame)
PlusMainLbl.Size          = UDim2.new(0, 0, 1, 0)
PlusMainLbl.AutomaticSize = Enum.AutomaticSize.X
PlusMainLbl.BackgroundTransparency = 1
PlusMainLbl.Text          = "Get 10% off with Roblox Plus"
PlusMainLbl.TextColor3    = T.TextSub
PlusMainLbl.Font          = Enum.Font.Gotham
PlusMainLbl.TextSize      = 13
PlusMainLbl.LayoutOrder   = 2

-- Spacer flex
local Spacer = Instance.new("Frame", PlusFrame)
Spacer.BackgroundTransparency = 1
Spacer.Size               = UDim2.new(1, 0, 1, 0)
Spacer.LayoutOrder        = 3
local FlexItem = Instance.new("UIFlexItem", Spacer)
FlexItem.FlexMode         = Enum.UIFlexMode.Fill

-- Link "Get free trial" (co gach chan)
local TrialLbl = Instance.new("TextLabel", PlusFrame)
TrialLbl.Size             = UDim2.new(0, 0, 1, 0)
TrialLbl.AutomaticSize    = Enum.AutomaticSize.X
TrialLbl.BackgroundTransparency = 1
TrialLbl.Text             = "Get free trial"
TrialLbl.TextColor3       = T.TextLink
TrialLbl.Font             = Enum.Font.GothamSemibold
TrialLbl.TextSize         = 13
TrialLbl.TextDecoration   = Enum.TextDecoration.Underline
TrialLbl.LayoutOrder      = 4

-----------------------------------------------------------------
--  LOGIC
-----------------------------------------------------------------

local buying = false

local function doOpenBuy()
    buying  = false
    BuyBtn.Active = true
    BuyBtn.Text   = "Buy"
    ProgBar.Size  = UDim2.new(0, 0, 1, 0)
    BuyBtnFrame.BackgroundColor3 = T.AccentBlue
    showBuy(BuyPanel, BSc)
end

local function doCloseBuy(onDone)
    hideBuy(BSc, onDone)
end

local function doOpenSuccess()
    showSucc(SuccPanel, SSc)
end

local function doCloseSuccess()
    hideSucc(SSc, nil)
end

-- Nut X Buy
BXBtn.MouseButton1Click:Connect(function()
    doCloseBuy(nil)
end)

-- Nut X Success
SCloseX.MouseButton1Click:Connect(doCloseSuccess)

-- Nut OK
OKBtn.MouseButton1Click:Connect(doCloseSuccess)

-- Nut BUY: progress 2.6 giay -> thanh cong
BuyBtn.MouseButton1Click:Connect(function()
    if buying then return end
    buying = true
    BuyBtn.Active = false
    BuyBtn.Text   = "Processing..."

    TweenService:Create(BuyBtnFrame, TweenInfo.new(0.15),
        {BackgroundColor3 = Color3.fromRGB(50, 80, 210)}):Play()

    local prog = TweenService:Create(ProgBar,
        TweenInfo.new(2.6, Enum.EasingStyle.Linear),
        {Size = UDim2.new(1, 0, 1, 0)})
    prog:Play()

    prog.Completed:Connect(function()
        WALLET = WALLET - ITEM_PRICE
        BBalanceLbl.Text = fmt(WALLET)

        doCloseBuy(function()
            task.delay(0.20, doOpenSuccess)
        end)
    end)
end)

-----------------------------------------------------------------
--  TU DONG MO KHI CHAY (khong can test panel)
-----------------------------------------------------------------
task.delay(0.1, doOpenBuy)
