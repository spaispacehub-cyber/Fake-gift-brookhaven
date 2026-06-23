--=============================================================--
--  ROBLOX FLAT ECONOMY UI — BUY MODAL + SUCCESS MODAL
--  Phong cach: Flat / Dark / Ngang — bam sat ngon ngu Roblox
--=============================================================--

local Players     = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lplr        = Players.LocalPlayer
local PlayerGui   = Lplr:WaitForChild("PlayerGui")

-- ============================================================
--  THEME
-- ============================================================
local T = {
    -- Nen chinh cua modal (xam den dam)
    ModalBg    = Color3.fromRGB(32, 32, 36),
    -- Nen item frame (sang hon modal chinh mot chut)
    CardBg     = Color3.fromRGB(43, 43, 49),
    -- Nen Roblox Plus bar
    PlusBarBg  = Color3.fromRGB(38, 38, 43),

    -- Accent xanh Roblox
    AccentBlue = Color3.fromRGB(0, 162, 255),
    -- Progress bar (sang hon accent 1 chut)
    ProgressHi = Color3.fromRGB(56, 190, 255),

    TextPrimary = Color3.new(1, 1, 1),
    TextSub     = Color3.fromRGB(185, 185, 195),
    TextLink    = Color3.fromRGB(0, 162, 255),

    CloseIdle   = Color3.fromRGB(130, 130, 140),
    CloseHover  = Color3.fromRGB(230, 230, 235),

    -- Mau gia (icon tien te placeholder)
    CoinYellow  = Color3.fromRGB(255, 196, 0),
    SuccessGreen= Color3.fromRGB(0, 176, 111),

    OverlayBg   = Color3.new(0, 0, 0),
}

-- ============================================================
--  DU LIEU MAU
-- ============================================================
local MOCK_ITEM = {
    Title    = "Starter Pack",
    Price    = 100,
    AssetId  = 0,  -- placeholder
}
local WALLET_BALANCE = 3098112

local function fmtNum(n)
    return tostring(n):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

-- ============================================================
--  TWEEN HELPERS
-- ============================================================
local TI_OVERLAY = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_MODAL   = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_CLOSE   = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

--=============================================================
--  ROOT SCREENGUI
--=============================================================
local StoreGui = Instance.new("ScreenGui")
StoreGui.Name            = "RobloxEconomyUI"
StoreGui.DisplayOrder    = 100000
StoreGui.IgnoreGuiInset  = true
StoreGui.ResetOnSpawn    = false
StoreGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
StoreGui.Parent          = PlayerGui

-- ============================================================
--  SHARED: ham tao nut dong (X)
-- ============================================================
local function makeCloseBtn(parent, onClose)
    local btn = Instance.new("TextButton", parent)
    btn.Size               = UDim2.new(0, 30, 0, 30)
    btn.AnchorPoint        = Vector2.new(1, 0.5)
    btn.BackgroundTransparency = 1
    btn.Text               = "\u{2715}"
    btn.TextColor3         = T.CloseIdle
    btn.Font               = Enum.Font.GothamSemibold
    btn.TextSize           = 17
    btn.ZIndex             = 10

    local function hover(on)
        TweenService:Create(btn, TweenInfo.new(0.12), {
            TextColor3 = on and T.CloseHover or T.CloseIdle
        }):Play()
    end
    btn.MouseEnter:Connect(function() hover(true) end)
    btn.MouseLeave:Connect(function() hover(false) end)
    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then hover(true) end
    end)
    btn.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then hover(false) end
    end)
    if onClose then btn.MouseButton1Click:Connect(onClose) end
    return btn
end

-- ============================================================
--  SHARED: ham tao coin icon placeholder (UIGradient vang)
-- ============================================================
local function makeCoinIcon(parent, size)
    local frame = Instance.new("Frame", parent)
    frame.Size              = UDim2.new(0, size, 0, size)
    frame.BackgroundColor3  = T.CoinYellow
    frame.BorderSizePixel   = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)

    local grad = Instance.new("UIGradient", frame)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 150, 0)),
    })
    grad.Rotation = 135

    -- chu "R" nho trong icon
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size                = UDim2.fromScale(1, 1)
    lbl.BackgroundTransparency = 1
    lbl.Text                = "R"
    lbl.TextColor3          = Color3.fromRGB(140, 90, 0)
    lbl.Font                = Enum.Font.GothamBold
    lbl.TextSize            = math.max(9, math.floor(size * 0.55))
    lbl.TextXAlignment      = Enum.TextXAlignment.Center
    lbl.TextYAlignment      = Enum.TextYAlignment.Center
    return frame
end

-- ============================================================
--  MODAL ENGINE — overlay + slide/scale/fade
-- ============================================================
local function createModalEngine()
    -- Overlay (toan man hinh, den mo)
    local overlay = Instance.new("TextButton", StoreGui)
    overlay.Name                = "Overlay"
    overlay.Size                = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3    = T.OverlayBg
    overlay.BackgroundTransparency = 1
    overlay.AutoButtonColor     = false
    overlay.Text                = ""
    overlay.Visible             = false
    overlay.ZIndex              = 5

    -- Container chinh (de chung Stack vao)
    local container = Instance.new("Frame", overlay)
    container.Name              = "ModalContainer"
    container.AnchorPoint       = Vector2.new(0.5, 0.5)
    container.Position          = UDim2.new(0.5, 0, 0.5, 0)
    container.Size              = UDim2.fromScale(1, 1)
    container.BackgroundTransparency = 1
    container.ZIndex            = 6

    local function show(modalFrame, scaleInst)
        overlay.Visible = true
        overlay.BackgroundTransparency = 1
        scaleInst.Scale = 0.97
        modalFrame.Position = UDim2.new(0.5, 0, 0.5, 22)
        modalFrame.ImageTransparency = nil -- reset nếu là ImageLabel

        TweenService:Create(overlay, TI_OVERLAY,
            {BackgroundTransparency = 0.40}):Play()
        TweenService:Create(scaleInst, TI_MODAL,
            {Scale = 1.0}):Play()
        TweenService:Create(modalFrame, TI_MODAL,
            {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    end

    local function hide(scaleInst, onDone)
        TweenService:Create(overlay, TI_CLOSE,
            {BackgroundTransparency = 1}):Play()
        local t = TweenService:Create(scaleInst, TI_CLOSE,
            {Scale = 0.97})
        t:Play()
        t.Completed:Connect(function()
            overlay.Visible = false
            if onDone then onDone() end
        end)
    end

    return overlay, container, show, hide
end

-- ============================================================
--  SUCCESS MODAL (khai bao truoc de BuyModal co the goi)
-- ============================================================
local successOverlay, successContainer, showSuccess, hideSuccess =
    createModalEngine()

local SuccessPanel = Instance.new("Frame", successContainer)
SuccessPanel.Name            = "SuccessPanel"
SuccessPanel.Size            = UDim2.new(0, 520, 0, 280)
SuccessPanel.AnchorPoint     = Vector2.new(0.5, 0.5)
SuccessPanel.Position        = UDim2.new(0.5, 0, 0.5, 22)
SuccessPanel.BackgroundColor3 = T.ModalBg
SuccessPanel.BorderSizePixel = 0
SuccessPanel.ZIndex          = 7
Instance.new("UICorner", SuccessPanel).CornerRadius = UDim.new(0, 16)

local SScale = Instance.new("UIScale", SuccessPanel)
SScale.Scale = 0.97

-- [S] HEADER ROW ─────────────────────────────────────────
local SHeader = Instance.new("Frame", SuccessPanel)
SHeader.Size             = UDim2.new(1, -36, 0, 48)
SHeader.Position         = UDim2.new(0, 18, 0, 0)
SHeader.BackgroundTransparency = 1

local STitle = Instance.new("TextLabel", SHeader)
STitle.Size              = UDim2.new(1, -40, 1, 0)
STitle.BackgroundTransparency = 1
STitle.Text              = "Purchase completed"
STitle.TextColor3        = T.TextPrimary
STitle.Font              = Enum.Font.GothamBold
STitle.TextSize          = 16
STitle.TextXAlignment    = Enum.TextXAlignment.Left
STitle.TextYAlignment    = Enum.TextYAlignment.Center

local SCloseBtn = makeCloseBtn(SHeader, nil)
SCloseBtn.AnchorPoint = Vector2.new(1, 0.5)
SCloseBtn.Position    = UDim2.new(1, 0, 0.5, 0)

-- [S] CHECK CIRCLE ────────────────────────────────────────
local SCircle = Instance.new("Frame", SuccessPanel)
SCircle.Size            = UDim2.new(0, 62, 0, 62)
SCircle.AnchorPoint     = Vector2.new(0.5, 0)
SCircle.Position        = UDim2.new(0.5, 0, 0, 56)
SCircle.BackgroundColor3 = T.SuccessGreen
SCircle.BorderSizePixel = 0
Instance.new("UICorner", SCircle).CornerRadius = UDim.new(1, 0)

local SGrad = Instance.new("UIGradient", SCircle)
SGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 140, 85)),
})
SGrad.Rotation = 135

local SCheck = Instance.new("TextLabel", SCircle)
SCheck.Size             = UDim2.fromScale(1, 1)
SCheck.BackgroundTransparency = 1
SCheck.Text             = "\u{2713}"
SCheck.TextColor3       = T.TextPrimary
SCheck.Font             = Enum.Font.GothamBold
SCheck.TextSize         = 28

-- [S] SUB TEXT ────────────────────────────────────────────
local SSubText = Instance.new("TextLabel", SuccessPanel)
SSubText.Size           = UDim2.new(1, -36, 0, 28)
SSubText.AnchorPoint    = Vector2.new(0.5, 0)
SSubText.Position       = UDim2.new(0.5, 0, 0, 130)
SSubText.BackgroundTransparency = 1
SSubText.Text           = "You have successfully bought"
SSubText.TextColor3     = T.TextSub
SSubText.Font           = Enum.Font.GothamMedium
SSubText.TextSize       = 14
SSubText.TextXAlignment = Enum.TextXAlignment.Center

-- [S] OK BUTTON ───────────────────────────────────────────
local SOkWrap = Instance.new("Frame", SuccessPanel)
SOkWrap.Size            = UDim2.new(1, -36, 0, 42)
SOkWrap.AnchorPoint     = Vector2.new(0.5, 1)
SOkWrap.Position        = UDim2.new(0.5, 0, 1, -16)
SOkWrap.BackgroundColor3 = T.AccentBlue
SOkWrap.BorderSizePixel = 0
Instance.new("UICorner", SOkWrap).CornerRadius = UDim.new(0, 8)

local SOkBtn = Instance.new("TextButton", SOkWrap)
SOkBtn.Size             = UDim2.fromScale(1, 1)
SOkBtn.BackgroundTransparency = 1
SOkBtn.Text             = "OK"
SOkBtn.TextColor3       = T.TextPrimary
SOkBtn.Font             = Enum.Font.GothamBold
SOkBtn.TextSize         = 15

-- ============================================================
--  BUY MODAL
-- ============================================================
local buyOverlay, buyContainer, showBuy, hideBuy =
    createModalEngine()

local BuyPanel = Instance.new("Frame", buyContainer)
BuyPanel.Name            = "BuyPanel"
BuyPanel.Size            = UDim2.new(0, 520, 0, 310)
BuyPanel.AnchorPoint     = Vector2.new(0.5, 0.5)
BuyPanel.Position        = UDim2.new(0.5, 0, 0.5, 22)
BuyPanel.BackgroundColor3 = T.ModalBg
BuyPanel.BorderSizePixel = 0
BuyPanel.ZIndex          = 7
Instance.new("UICorner", BuyPanel).CornerRadius = UDim.new(0, 16)

local BScale = Instance.new("UIScale", BuyPanel)
BScale.Scale = 0.97

-- ── ROW 1: HEADER ─────────────────────────────────────────
--  [Buy item]          [CoinIcon] [3,098,112]   [X]
local BHeader = Instance.new("Frame", BuyPanel)
BHeader.Size             = UDim2.new(1, -36, 0, 48)
BHeader.Position         = UDim2.new(0, 18, 0, 0)
BHeader.BackgroundTransparency = 1

local BTitle = Instance.new("TextLabel", BHeader)
BTitle.Size              = UDim2.new(0.45, 0, 1, 0)
BTitle.BackgroundTransparency = 1
BTitle.Text              = "Buy item"
BTitle.TextColor3        = T.TextPrimary
BTitle.Font              = Enum.Font.GothamBold
BTitle.TextSize          = 16
BTitle.TextXAlignment    = Enum.TextXAlignment.Left
BTitle.TextYAlignment    = Enum.TextYAlignment.Center

-- Cum phai: [CoinIcon] [Balance] [X]
local BRight = Instance.new("Frame", BHeader)
BRight.Size              = UDim2.new(0.55, 0, 1, 0)
BRight.Position          = UDim2.new(0.45, 0, 0, 0)
BRight.BackgroundTransparency = 1

local BRLayout = Instance.new("UIListLayout", BRight)
BRLayout.FillDirection   = Enum.FillDirection.Horizontal
BRLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BRLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
BRLayout.SortOrder       = Enum.SortOrder.LayoutOrder
BRLayout.Padding         = UDim.new(0, 8)

local BCoinIcon = makeCoinIcon(BRight, 18)
BCoinIcon.LayoutOrder    = 1

local BBalanceLabel = Instance.new("TextLabel", BRight)
BBalanceLabel.Size       = UDim2.new(0, 0, 0, 20)
BBalanceLabel.AutomaticSize = Enum.AutomaticSize.X
BBalanceLabel.BackgroundTransparency = 1
BBalanceLabel.Text       = fmtNum(WALLET_BALANCE)
BBalanceLabel.TextColor3 = T.TextPrimary
BBalanceLabel.Font       = Enum.Font.GothamSemibold
BBalanceLabel.TextSize   = 14
BBalanceLabel.LayoutOrder = 2

local BCloseBtn = makeCloseBtn(BRight, nil)
BCloseBtn.AnchorPoint    = Vector2.new(0, 0.5)
BCloseBtn.Position       = UDim2.new(0, 0, 0.5, 0) -- overridden by UIListLayout
BCloseBtn.LayoutOrder    = 3
-- reset position cho UIListLayout quan ly
BCloseBtn.Size           = UDim2.new(0, 30, 0, 30)

-- ── ROW 2: ITEM CARD ──────────────────────────────────────
--  ╭───────────────────────────────────╮
--  │ [IMG]  Item Name         ⬡ 100   │
--  ╰───────────────────────────────────╯
local ItemCard = Instance.new("Frame", BuyPanel)
ItemCard.Size            = UDim2.new(1, -36, 0, 88)
ItemCard.Position        = UDim2.new(0, 18, 0, 50)
ItemCard.BackgroundColor3 = T.CardBg
ItemCard.BorderSizePixel = 0
Instance.new("UICorner", ItemCard).CornerRadius = UDim.new(0, 10)

-- Anh item (bo goc nhe, placeholder gradient)
local ItemImg = Instance.new("Frame", ItemCard)
ItemImg.Size             = UDim2.new(0, 66, 0, 66)
ItemImg.Position         = UDim2.new(0, 12, 0.5, 0)
ItemImg.AnchorPoint      = Vector2.new(0, 0.5)
ItemImg.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
ItemImg.BorderSizePixel  = 0
Instance.new("UICorner", ItemImg).CornerRadius = UDim.new(0, 8)

local ImgGrad = Instance.new("UIGradient", ItemImg)
ImgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 90)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 52)),
})
ImgGrad.Rotation = 135

-- Phan giua: Item Name
local ItemNameLabel = Instance.new("TextLabel", ItemCard)
ItemNameLabel.Position   = UDim2.new(0, 92, 0, 16)
ItemNameLabel.Size       = UDim2.new(1, -200, 0, 26)
ItemNameLabel.BackgroundTransparency = 1
ItemNameLabel.Text       = MOCK_ITEM.Title
ItemNameLabel.TextColor3 = T.TextPrimary
ItemNameLabel.Font       = Enum.Font.GothamBold
ItemNameLabel.TextSize   = 15
ItemNameLabel.TextXAlignment = Enum.TextXAlignment.Left
ItemNameLabel.TextWrapped = true

-- Phan phai: [CoinIcon] + [Price] nam cung hang voi anh
local PriceGroup = Instance.new("Frame", ItemCard)
PriceGroup.Size          = UDim2.new(0, 90, 0, 24)
PriceGroup.AnchorPoint   = Vector2.new(1, 0.5)
PriceGroup.Position      = UDim2.new(1, -14, 0.5, 0)
PriceGroup.BackgroundTransparency = 1

local PGLayout = Instance.new("UIListLayout", PriceGroup)
PGLayout.FillDirection   = Enum.FillDirection.Horizontal
PGLayout.VerticalAlignment = Enum.VerticalAlignment.Center
PGLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
PGLayout.SortOrder       = Enum.SortOrder.LayoutOrder
PGLayout.Padding         = UDim.new(0, 6)

local PCoinIcon = makeCoinIcon(PriceGroup, 18)
PCoinIcon.LayoutOrder    = 1

local PriceLabel = Instance.new("TextLabel", PriceGroup)
PriceLabel.Size          = UDim2.new(0, 0, 0, 20)
PriceLabel.AutomaticSize = Enum.AutomaticSize.X
PriceLabel.BackgroundTransparency = 1
PriceLabel.Text          = fmtNum(MOCK_ITEM.Price)
PriceLabel.TextColor3    = T.TextPrimary
PriceLabel.Font          = Enum.Font.GothamBold
PriceLabel.TextSize      = 15
PriceLabel.LayoutOrder   = 2

-- ── ROW 3: BUY BUTTON ─────────────────────────────────────
local BuyBtnWrap = Instance.new("Frame", BuyPanel)
BuyBtnWrap.Name          = "BuyBtnWrap"
BuyBtnWrap.Size          = UDim2.new(1, -36, 0, 44)
BuyBtnWrap.Position      = UDim2.new(0, 18, 0, 152)
BuyBtnWrap.BackgroundColor3 = T.AccentBlue
BuyBtnWrap.BorderSizePixel  = 0
BuyBtnWrap.ClipsDescendants = true
Instance.new("UICorner", BuyBtnWrap).CornerRadius = UDim.new(0, 8)

-- Progress bar chay ngam ben trong (ZIndex thap hon chu Buy)
local BuyProgress = Instance.new("Frame", BuyBtnWrap)
BuyProgress.Name         = "Progress"
BuyProgress.Size         = UDim2.new(0, 0, 1, 0)
BuyProgress.BackgroundColor3 = T.ProgressHi
BuyProgress.BorderSizePixel  = 0
BuyProgress.ZIndex       = 1

local BuyBtn = Instance.new("TextButton", BuyBtnWrap)
BuyBtn.Size              = UDim2.fromScale(1, 1)
BuyBtn.BackgroundTransparency = 1
BuyBtn.Text              = "Buy"
BuyBtn.TextColor3        = T.TextPrimary
BuyBtn.Font              = Enum.Font.GothamBold
BuyBtn.TextSize          = 15
BuyBtn.ZIndex            = 2

-- ── ROW 4: ROBLOX PLUS BAR ────────────────────────────────
--  ╭────────────────────────────────────────────────────╮
--  │ Ⓟ Get 10% off with Roblox Plus    Get free trial  │
--  ╰────────────────────────────────────────────────────╯
local PlusBar = Instance.new("Frame", BuyPanel)
PlusBar.Size             = UDim2.new(1, -36, 0, 38)
PlusBar.AnchorPoint      = Vector2.new(0, 1)
PlusBar.Position         = UDim2.new(0, 18, 1, -12)
PlusBar.BackgroundColor3 = T.PlusBarBg
PlusBar.BorderSizePixel  = 0
Instance.new("UICorner", PlusBar).CornerRadius = UDim.new(0, 8)

local PlusLayout = Instance.new("UIListLayout", PlusBar)
PlusLayout.FillDirection = Enum.FillDirection.Horizontal
PlusLayout.VerticalAlignment = Enum.VerticalAlignment.Center
PlusLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
PlusLayout.SortOrder    = Enum.SortOrder.LayoutOrder
PlusLayout.Padding      = UDim.new(0, 8)

local PlusPad = Instance.new("UIPadding", PlusBar)
PlusPad.PaddingLeft   = UDim.new(0, 12)
PlusPad.PaddingRight  = UDim.new(0, 12)

-- Icon "P" Roblox Plus (gradient tim)
local PlusIcon = Instance.new("Frame", PlusBar)
PlusIcon.Size            = UDim2.new(0, 20, 0, 20)
PlusIcon.BackgroundColor3 = Color3.fromRGB(160, 80, 255)
PlusIcon.BorderSizePixel = 0
PlusIcon.LayoutOrder     = 1
Instance.new("UICorner", PlusIcon).CornerRadius = UDim.new(1, 0)

local PIGrad = Instance.new("UIGradient", PlusIcon)
PIGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 50, 220)),
})
PIGrad.Rotation = 135

local PILabel = Instance.new("TextLabel", PlusIcon)
PILabel.Size             = UDim2.fromScale(1, 1)
PILabel.BackgroundTransparency = 1
PILabel.Text             = "P"
PILabel.TextColor3       = T.TextPrimary
PILabel.Font             = Enum.Font.GothamBold
PILabel.TextSize         = 11

-- Text "Get 10% off..."
local PlusMainText = Instance.new("TextLabel", PlusBar)
PlusMainText.Size        = UDim2.new(0, 0, 1, 0)
PlusMainText.AutomaticSize = Enum.AutomaticSize.X
PlusMainText.BackgroundTransparency = 1
PlusMainText.Text        = "Get 10% off with Roblox Plus"
PlusMainText.TextColor3  = T.TextSub
PlusMainText.Font        = Enum.Font.GothamMedium
PlusMainText.TextSize    = 12
PlusMainText.LayoutOrder = 2

-- Spacer de day "Get free trial" sang phai
local PlusSpacer = Instance.new("Frame", PlusBar)
PlusSpacer.Size          = UDim2.new(1, 0, 1, 0) -- UIListLayout fill
PlusSpacer.BackgroundTransparency = 1
PlusSpacer.AutomaticSize = Enum.AutomaticSize.None
PlusSpacer.LayoutOrder   = 3
-- de UIListLayout fill phan giua, dung FlexItem
local Flex = Instance.new("UIFlexItem", PlusSpacer)
Flex.FlexMode            = Enum.UIFlexMode.Fill

-- Link "Get free trial"
local TrialLink = Instance.new("TextLabel", PlusBar)
TrialLink.Size           = UDim2.new(0, 0, 1, 0)
TrialLink.AutomaticSize  = Enum.AutomaticSize.X
TrialLink.BackgroundTransparency = 1
TrialLink.Text           = "Get free trial"
TrialLink.TextColor3     = T.TextLink
TrialLink.Font           = Enum.Font.GothamMedium
TrialLink.TextSize       = 12
TrialLink.TextDecoration = Enum.TextDecoration.Underline
TrialLink.LayoutOrder    = 4

-- ============================================================
--  DEBUG TEST PANEL
-- ============================================================
local TestPanel = Instance.new("Frame", StoreGui)
TestPanel.Name           = "TestPanel"
TestPanel.Size           = UDim2.new(0, 200, 0, 80)
TestPanel.Position       = UDim2.new(0, 24, 0.5, -40)
TestPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TestPanel.BorderSizePixel = 0
Instance.new("UICorner", TestPanel).CornerRadius = UDim.new(0, 8)

local TLbl = Instance.new("TextLabel", TestPanel)
TLbl.Size                = UDim2.new(1, 0, 0, 26)
TLbl.BackgroundTransparency = 1
TLbl.Text                = "ECONOMY UI TEST"
TLbl.TextColor3          = Color3.fromRGB(0, 220, 220)
TLbl.Font                = Enum.Font.GothamBold
TLbl.TextSize            = 12

local OpenBuyBtn = Instance.new("TextButton", TestPanel)
OpenBuyBtn.Size          = UDim2.new(1, -16, 0, 30)
OpenBuyBtn.Position      = UDim2.new(0, 8, 0, 28)
OpenBuyBtn.BackgroundColor3 = T.AccentBlue
OpenBuyBtn.Text          = "Open Buy Modal"
OpenBuyBtn.Font          = Enum.Font.GothamBold
OpenBuyBtn.TextColor3    = Color3.new(1, 1, 1)
OpenBuyBtn.TextSize      = 12
Instance.new("UICorner", OpenBuyBtn).CornerRadius = UDim.new(0, 6)

-- ============================================================
--  LOGIC — BUY FLOW
-- ============================================================

local buyActive = true -- trang thai nut Buy

local function openBuyModal()
    buyActive = true
    BuyBtn.Active = true
    BuyProgress.Size = UDim2.new(0, 0, 1, 0)
    BuyBtnWrap.BackgroundColor3 = T.AccentBlue
    showBuy(BuyPanel, BScale)
    TestPanel.Visible = false
end

local function closeBuyModal()
    hideBuy(BScale, function()
        TestPanel.Visible = true
    end)
end

local function openSuccessModal()
    showSuccess(SuccessPanel, SScale)
end

local function closeSuccessModal()
    hideSuccess(SScale, function()
        TestPanel.Visible = true
    end)
end

-- Gan nut Close Buy
BCloseBtn.MouseButton1Click:Connect(closeBuyModal)
buyOverlay.MouseButton1Click:Connect(closeBuyModal) -- bam ra ngoai dong

-- Gan nut Close Success
SCloseBtn.MouseButton1Click:Connect(closeSuccessModal)
successOverlay.MouseButton1Click:Connect(closeSuccessModal)

-- Gan nut OK
SOkBtn.MouseButton1Click:Connect(closeSuccessModal)

-- Nut Buy: progress chay 2.5s -> thanh cong
BuyBtn.MouseButton1Click:Connect(function()
    if not buyActive then return end
    buyActive = false
    BuyBtn.Active = false
    BuyBtn.Text = "Processing..."

    -- lam toi nut khi dang xu ly
    TweenService:Create(BuyBtnWrap, TweenInfo.new(0.15),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 200)}):Play()

    local prog = TweenService:Create(BuyProgress,
        TweenInfo.new(2.6, Enum.EasingStyle.Linear),
        {Size = UDim2.new(1, 0, 1, 0)})
    prog:Play()

    prog.Completed:Connect(function()
        BuyBtn.Text = "Buy"
        WALLET_BALANCE = WALLET_BALANCE - MOCK_ITEM.Price
        BBalanceLabel.Text = fmtNum(WALLET_BALANCE)

        closeBuyModal()
        task.delay(0.22, function()
            openSuccessModal()
        end)
    end)
end)

-- Test panel mo Buy modal
OpenBuyBtn.MouseButton1Click:Connect(openBuyModal)

-- ============================================================
--  INIT
-- ============================================================
BBalanceLabel.Text = fmtNum(WALLET_BALANCE)
