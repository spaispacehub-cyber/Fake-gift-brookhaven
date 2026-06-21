--======================================================--
--  MODERN DARK UI - MOCKUP STORE SYSTEM
--  Cua hang thu nghiem phong cach Flat / Modern Dark UI
--======================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lplr = Players.LocalPlayer
local PlayerGui = Lplr:WaitForChild("PlayerGui")

--// Assets
local UI_ASSETS = {
	CurrencyToken = "rbxassetid://76631276896698",
	SuccessCheck = "rbxassetid://70875129327445",
	GiftBox = "rbxassetid://126641461281688",
	NavigationIcon = "rbxassetid://10882439086",
}

--// Theme - bang mau chuan Modern Dark UI
local THEME = {
	PanelBg = Color3.fromRGB(18, 18, 22),
	AccentBlue = Color3.fromRGB(40, 85, 230),
	AccentBluePressed = Color3.fromRGB(28, 64, 180),
	TextWhite = Color3.new(1, 1, 1),
	SubText = Color3.fromRGB(170, 170, 178),
	CloseIdle = Color3.fromRGB(120, 120, 128),
	CloseHover = Color3.fromRGB(225, 225, 230),
	CardBg = Color3.fromRGB(28, 28, 34),
}

local PANEL_SIZE = UDim2.new(0, 360, 0, 250)

--// Product data
local PRODUCT_CATALOG = {
	{Title = "Premium Tier", Price = 275, AssetId = 6340156903},
	{Title = "Luxury Estate", Price = 799, AssetId = 6806509618},
	{Title = "Sports Vehicle", Price = 799, AssetId = 6545229649},
	{Title = "Racing Edition", Price = 799, AssetId = 6650428935},
}

local CurrentItemIndex = 1
local LocalWalletBalance = 2096352

local function formatCurrency(value)
	return tostring(value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local function RefreshWalletDisplay()
	for _, element in ipairs(PlayerGui:GetDescendants()) do
		if element:IsA("TextLabel") and string.find(element.Text, "%$") then
			element.Text = "$ " .. formatCurrency(LocalWalletBalance)
		end
	end
end

--======================================================--
--  ROOT GUI
--======================================================--

local CustomStoreGui = Instance.new("ScreenGui")
CustomStoreGui.Name = "ClientStoreDisplayInterface"
CustomStoreGui.DisplayOrder = 100000
CustomStoreGui.IgnoreGuiInset = true
CustomStoreGui.ResetOnSpawn = false
CustomStoreGui.Parent = PlayerGui

--======================================================--
--  TOAST NOTIFICATION (giu nguyen logic goc)
--======================================================--

local AlertFrame = Instance.new("Frame", CustomStoreGui)
AlertFrame.Size = UDim2.new(0, 180, 0, 42)
AlertFrame.BackgroundColor3 = Color3.fromRGB(255, 45, 130)
AlertFrame.AnchorPoint = Vector2.new(0.5, 1)
AlertFrame.Position = UDim2.new(0.5, 0, 1.2, 0)
AlertFrame.BorderSizePixel = 0
Instance.new("UICorner", AlertFrame).CornerRadius = UDim.new(1, 0)

local AlertIcon = Instance.new("ImageLabel", AlertFrame)
AlertIcon.Size = UDim2.new(0, 28, 0, 28)
AlertIcon.Position = UDim2.new(0, 12, 0.5, 0)
AlertIcon.AnchorPoint = Vector2.new(0, 0.5)
AlertIcon.Image = UI_ASSETS.GiftBox
AlertIcon.BackgroundTransparency = 1

local AlertText = Instance.new("TextLabel", AlertFrame)
AlertText.Size = UDim2.new(0, 0, 0, 20)
AlertText.Position = UDim2.new(0, 48, 0.5, 0)
AlertText.AnchorPoint = Vector2.new(0, 0.5)
AlertText.AutomaticSize = Enum.AutomaticSize.X
AlertText.Text = "Delivery Sent!"
AlertText.TextColor3 = Color3.new(1, 1, 1)
AlertText.Font = Enum.Font.GothamBold
AlertText.TextSize = 17
AlertText.BackgroundTransparency = 1

--======================================================--
--  MODAL HELPER - hieu ung Quad, 0.25s
--======================================================--

local function createOverlay()
	local Overlay = Instance.new("TextButton", CustomStoreGui)
	Overlay.Size = UDim2.fromScale(1, 1)
	Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	Overlay.BackgroundTransparency = 1
	Overlay.AutoButtonColor = false
	Overlay.Text = ""
	Overlay.Visible = false
	return Overlay
end

local TWEEN_IN = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_OUT = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local function showModal(overlay, scaleObj)
	overlay.Visible = true
	overlay.BackgroundTransparency = 1
	scaleObj.Scale = 0.85

	TweenService:Create(overlay, TWEEN_IN, {BackgroundTransparency = 0.45}):Play()
	TweenService:Create(scaleObj, TWEEN_IN, {Scale = 1}):Play()
end

local function hideModal(overlay, scaleObj)
	TweenService:Create(overlay, TWEEN_OUT, {BackgroundTransparency = 1}):Play()
	local t = TweenService:Create(scaleObj, TWEEN_OUT, {Scale = 0.9})
	t:Play()
	t.Completed:Connect(function()
		overlay.Visible = false
	end)
end

--======================================================--
--  CHECKOUT PANEL
--======================================================--

local CheckoutOverlay = createOverlay()

local CheckoutPanel = Instance.new("Frame", CheckoutOverlay)
CheckoutPanel.Size = PANEL_SIZE
CheckoutPanel.BackgroundColor3 = THEME.PanelBg
CheckoutPanel.AnchorPoint = Vector2.new(0.5, 0.5)
CheckoutPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
Instance.new("UICorner", CheckoutPanel).CornerRadius = UDim.new(0, 14)

local CheckoutScale = Instance.new("UIScale", CheckoutPanel)

-- Nut dong: chu "X" mong, goc tren ben phai, doi mau khi hover/cham
local CloseBtn = Instance.new("TextButton", CheckoutPanel)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -14, 0, 14)
CloseBtn.AnchorPoint = Vector2.new(1, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "\u{2715}"
CloseBtn.TextColor3 = THEME.CloseIdle
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.TextSize = 17

local function setCloseHover(active)
	TweenService:Create(CloseBtn, TweenInfo.new(0.15), {
		TextColor3 = active and THEME.CloseHover or THEME.CloseIdle,
	}):Play()
end
CloseBtn.MouseEnter:Connect(function() setCloseHover(true) end)
CloseBtn.MouseLeave:Connect(function() setCloseHover(false) end)
CloseBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		setCloseHover(true)
	end
end)
CloseBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		setCloseHover(false)
	end
end)

local PanelTitle = Instance.new("TextLabel", CheckoutPanel)
PanelTitle.Size = UDim2.new(1, -40, 0, 30)
PanelTitle.Position = UDim2.new(0, 22, 0, 16)
PanelTitle.Text = "Checkout"
PanelTitle.TextColor3 = THEME.TextWhite
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.TextSize = 18
PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
PanelTitle.BackgroundTransparency = 1

local ProductPreview = Instance.new("ImageLabel", CheckoutPanel)
ProductPreview.Size = UDim2.new(0, 64, 0, 64)
ProductPreview.Position = UDim2.new(0, 22, 0, 62)
ProductPreview.BackgroundColor3 = THEME.CardBg
Instance.new("UICorner", ProductPreview).CornerRadius = UDim.new(0, 10)

local ProductTitleLabel = Instance.new("TextLabel", CheckoutPanel)
ProductTitleLabel.Position = UDim2.new(0, 100, 0, 64)
ProductTitleLabel.Size = UDim2.new(1, -122, 0, 30)
ProductTitleLabel.TextColor3 = THEME.TextWhite
ProductTitleLabel.Font = Enum.Font.GothamMedium
ProductTitleLabel.TextSize = 16
ProductTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
ProductTitleLabel.BackgroundTransparency = 1
ProductTitleLabel.TextWrapped = true

local TokenIcon = Instance.new("ImageLabel", CheckoutPanel)
TokenIcon.Size = UDim2.new(0, 16, 0, 16)
TokenIcon.Position = UDim2.new(0, 100, 0, 100)
TokenIcon.Image = UI_ASSETS.CurrencyToken
TokenIcon.BackgroundTransparency = 1

local CostLabel = Instance.new("TextLabel", CheckoutPanel)
CostLabel.Position = UDim2.new(0, 120, 0, 98)
CostLabel.Size = UDim2.new(0, 120, 0, 20)
CostLabel.TextColor3 = THEME.SubText
CostLabel.Font = Enum.Font.GothamBold
CostLabel.TextSize = 16
CostLabel.TextXAlignment = Enum.TextXAlignment.Left
CostLabel.BackgroundTransparency = 1

-- Nut xac nhan: dep, full-width, xanh duong dam, bo goc 10
local SubmitButtonFrame = Instance.new("Frame", CheckoutPanel)
SubmitButtonFrame.Size = UDim2.new(1, -44, 0, 46)
SubmitButtonFrame.Position = UDim2.new(0.5, 0, 1, -22)
SubmitButtonFrame.AnchorPoint = Vector2.new(0.5, 1)
SubmitButtonFrame.BackgroundColor3 = THEME.AccentBlue
SubmitButtonFrame.ClipsDescendants = true
Instance.new("UICorner", SubmitButtonFrame).CornerRadius = UDim.new(0, 10)

local ProcessProgressBar = Instance.new("Frame", SubmitButtonFrame)
ProcessProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProcessProgressBar.BackgroundColor3 = Color3.new(1, 1, 1)
ProcessProgressBar.BackgroundTransparency = 0.82
ProcessProgressBar.BorderSizePixel = 0
ProcessProgressBar.ZIndex = 1

local ActionTriggerButton = Instance.new("TextButton", SubmitButtonFrame)
ActionTriggerButton.Size = UDim2.fromScale(1, 1)
ActionTriggerButton.BackgroundTransparency = 1
ActionTriggerButton.Text = "Confirm Purchase"
ActionTriggerButton.ZIndex = 2
ActionTriggerButton.Font = Enum.Font.GothamBold
ActionTriggerButton.TextColor3 = THEME.TextWhite
ActionTriggerButton.TextSize = 16

--======================================================--
--  SUCCESS PANEL
--======================================================--

local SuccessOverlay = createOverlay()

local SuccessPanel = Instance.new("Frame", SuccessOverlay)
SuccessPanel.Size = PANEL_SIZE
SuccessPanel.BackgroundColor3 = THEME.PanelBg
SuccessPanel.AnchorPoint = Vector2.new(0.5, 0.5)
SuccessPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
Instance.new("UICorner", SuccessPanel).CornerRadius = UDim.new(0, 14)

local SuccessScale = Instance.new("UIScale", SuccessPanel)

local CheckCircle = Instance.new("Frame", SuccessPanel)
CheckCircle.Size = UDim2.new(0, 64, 0, 64)
CheckCircle.AnchorPoint = Vector2.new(0.5, 0)
CheckCircle.Position = UDim2.new(0.5, 0, 0, 34)
CheckCircle.BackgroundColor3 = THEME.AccentBlue
Instance.new("UICorner", CheckCircle).CornerRadius = UDim.new(1, 0)

local CheckIcon = Instance.new("ImageLabel", CheckCircle)
CheckIcon.Size = UDim2.new(0, 30, 0, 30)
CheckIcon.AnchorPoint = Vector2.new(0.5, 0.5)
CheckIcon.Position = UDim2.fromScale(0.5, 0.5)
CheckIcon.Image = UI_ASSETS.SuccessCheck
CheckIcon.ImageColor3 = THEME.TextWhite
CheckIcon.BackgroundTransparency = 1

local SuccessMessageLabel = Instance.new("TextLabel", SuccessPanel)
SuccessMessageLabel.Size = UDim2.new(1, -40, 0, 44)
SuccessMessageLabel.AnchorPoint = Vector2.new(0.5, 0)
SuccessMessageLabel.Position = UDim2.new(0.5, 0, 0, 112)
SuccessMessageLabel.Text = "Purchase complete!"
SuccessMessageLabel.TextColor3 = THEME.TextWhite
SuccessMessageLabel.Font = Enum.Font.GothamMedium
SuccessMessageLabel.TextSize = 16
SuccessMessageLabel.TextWrapped = true
SuccessMessageLabel.TextXAlignment = Enum.TextXAlignment.Center
SuccessMessageLabel.BackgroundTransparency = 1

local OkButtonFrame = Instance.new("Frame", SuccessPanel)
OkButtonFrame.Size = UDim2.new(1, -44, 0, 46)
OkButtonFrame.Position = UDim2.new(0.5, 0, 1, -22)
OkButtonFrame.AnchorPoint = Vector2.new(0.5, 1)
OkButtonFrame.BackgroundColor3 = THEME.AccentBlue
Instance.new("UICorner", OkButtonFrame).CornerRadius = UDim.new(0, 10)

local OkButton = Instance.new("TextButton", OkButtonFrame)
OkButton.Size = UDim2.fromScale(1, 1)
OkButton.BackgroundTransparency = 1
OkButton.Text = "OK"
OkButton.Font = Enum.Font.GothamBold
OkButton.TextColor3 = THEME.TextWhite
OkButton.TextSize = 16

--======================================================--
--  DEBUG CONFIG PANEL (de test nhanh, giu nguyen y tuong goc)
--======================================================--

local ConfigurationPanel = Instance.new("Frame", CustomStoreGui)
ConfigurationPanel.Size = UDim2.new(0, 220, 0, 140)
ConfigurationPanel.Position = UDim2.new(0, 50, 0.5, -70)
ConfigurationPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", ConfigurationPanel).CornerRadius = UDim.new(0, 8)

local ConfigTitle = Instance.new("TextLabel", ConfigurationPanel)
ConfigTitle.Size = UDim2.new(1, 0, 0, 30)
ConfigTitle.Position = UDim2.new(0, 0, 0, 5)
ConfigTitle.Text = "UI TEST CONFIG"
ConfigTitle.Font = Enum.Font.GothamBold
ConfigTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
ConfigTitle.TextSize = 14
ConfigTitle.BackgroundTransparency = 1

local CatalogSelectButton = Instance.new("TextButton", ConfigurationPanel)
CatalogSelectButton.Size = UDim2.new(1, -20, 0, 35)
CatalogSelectButton.Position = UDim2.new(0, 10, 0, 40)
CatalogSelectButton.BackgroundColor3 = THEME.AccentBlue
CatalogSelectButton.Text = "Item: " .. PRODUCT_CATALOG[CurrentItemIndex].Title
CatalogSelectButton.Font = Enum.Font.GothamBold
CatalogSelectButton.TextColor3 = Color3.new(1, 1, 1)
CatalogSelectButton.TextSize = 11
Instance.new("UICorner", CatalogSelectButton).CornerRadius = UDim.new(0, 6)

local LaunchPreviewButton = Instance.new("TextButton", ConfigurationPanel)
LaunchPreviewButton.Size = UDim2.new(1, -20, 0, 35)
LaunchPreviewButton.Position = UDim2.new(0, 10, 0, 85)
LaunchPreviewButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
LaunchPreviewButton.Text = "LAUNCH MODAL PREVIEW"
LaunchPreviewButton.Font = Enum.Font.GothamBold
LaunchPreviewButton.TextColor3 = Color3.new(1, 1, 1)
LaunchPreviewButton.TextSize = 11
Instance.new("UICorner", LaunchPreviewButton).CornerRadius = UDim.new(0, 6)

CatalogSelectButton.MouseButton1Click:Connect(function()
	CurrentItemIndex = (CurrentItemIndex % #PRODUCT_CATALOG) + 1
	CatalogSelectButton.Text = "Item: " .. PRODUCT_CATALOG[CurrentItemIndex].Title
end)

--======================================================--
--  FLOW LOGIC
--======================================================--

LaunchPreviewButton.MouseButton1Click:Connect(function()
	ConfigurationPanel.Visible = false
	local Data = PRODUCT_CATALOG[CurrentItemIndex]

	ProductTitleLabel.Text = Data.Title
	CostLabel.Text = formatCurrency(Data.Price)
	ProductPreview.Image = "rbxassetid://" .. tostring(Data.AssetId)

	ProcessProgressBar.Size = UDim2.new(0, 0, 1, 0)
	SubmitButtonFrame.BackgroundColor3 = THEME.AccentBlue
	ActionTriggerButton.Active = true

	showModal(CheckoutOverlay, CheckoutScale)
end)

CloseBtn.MouseButton1Click:Connect(function()
	hideModal(CheckoutOverlay, CheckoutScale)
	ConfigurationPanel.Visible = true
end)

ActionTriggerButton.MouseButton1Click:Connect(function()
	if not ActionTriggerButton.Active then return end
	ActionTriggerButton.Active = false

	TweenService:Create(SubmitButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentBluePressed}):Play()
	local progressTween = TweenService:Create(ProcessProgressBar, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
	progressTween:Play()

	progressTween.Completed:Connect(function()
		local Data = PRODUCT_CATALOG[CurrentItemIndex]
		LocalWalletBalance = LocalWalletBalance - Data.Price
		RefreshWalletDisplay()

		hideModal(CheckoutOverlay, CheckoutScale)

		SuccessMessageLabel.Text = Data.Title .. " purchased successfully!"
		showModal(SuccessOverlay, SuccessScale)

		AlertText.Text = Data.Title .. " Verified!"
		TweenService:Create(AlertFrame, TweenInfo.new(0.5, Enum.EasingStyle.OutBack), {Position = UDim2.new(0.5, 0, 0.9, -10)}):Play()
		task.delay(2.5, function()
			TweenService:Create(AlertFrame, TweenInfo.new(0.4), {Position = UDim2.new(0.5, 0, 1.2, 0)}):Play()
		end)
	end)
end)

OkButton.MouseButton1Click:Connect(function()
	hideModal(SuccessOverlay, SuccessScale)
	ConfigurationPanel.Visible = true
end)

RefreshWalletDisplay()
