local v = {}
local v2 = {}
local v3 = {}
local v4 = { PurchaseConfirmY = 0 }
local v5 = nil
local v6 = nil
local v7 = { BASE = 0, MULTI = 1, CONFIRM = 2 }
local v8 = {}
local v9 = nil
local v10 = {}
local isDailyDeal = false
local base = v7.BASE
local v11 = nil
local flag = true
local v12 = false
local flag2 = false
local class = {}
local v13 = nil
local gameData = nil
local loader = nil
local v14 = nil
local v15 = nil
local module = require("Lotus.Interface.CodexUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.CardUtilitiesRedux")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("Lotus.Interface.UIStyleUtilities")
local module8 = require("Lotus.Interface.SyndicateUtilities")
local module9 = require("Lotus.Interface.WorldStateUtilities")
local module10 = require("Lotus.Interface.Components.StatCompare")
local module11 = require("Lotus.Scripts.Libs.CrewMemberSkillsLib")
local module12 = require("Lotus.Scripts.Libs.CrewMemberUtilities")
local module13 = require("Lotus.Interface.Components.ThemedCustomizationButton")
local module14 = require("Lotus.Interface.Libs.TimerMgr")
local v16 = nil
local module15 = require("EE.Interface.AnchorMgr")
local module16 = require("Lotus.Interface.SequencerUtilities")
local v17 = WeakResource("/Lotus/Types/Lore/PrimaryCodexManifest")
local v18 = WeakResource("/Lotus/Types/StoreItems/Packages/StarterBundle2020StoreItem")
local v19 = WeakResource("/Lotus/Upgrades/Mods/TransmuteCores/BaseTransmuteCore")
local v20 = WeakResource("/Lotus/Types/BoosterPacks/SingleSentinelRandomArtifact")
local v21 = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseMod")
local v22 = WeakResource("/Lotus/Upgrades/Mods/Immortal/ImmortalBaseMod")
local v23 = {
	WeakResource("/Lotus/Types/Keys/InfestedMicroplanetQuest/InfestedMicroplanetQuestKeyChain"),
	WeakResource("/Lotus/Types/Keys/WarWithinQuest/WarWithinQuestKeyChain")
}
local v24 = Type("/Lotus/Types/Game/HealthShieldDisplay")
local v25 = {}
local v26 = nil
local v27 = false
local v28 = {}
local v29 = 0
local v30 = 1
local v31 = false
local v32 = false
local callback = nil
local v34 = nil
local v35 = false
local v36 = false
local inventory = nil
local v37 = nil
local v38 = nil
local v39 = 0
local fn
local v40 = { Applied = false, OrigTheme = nil, OrigBg = nil, OrigSounds = nil }
local canPurchaseCheck = nil
local canGiftCheck = nil
local v41 = true
local v42 = true
local v43 = nil
local v44 = false
local v45 = false
local v46 = false
local v47 = nil
local v48 = {}
local v49 = { Visible = 0, HighlightOffset = 0, HighlightOn = 0, VisRangeInfo = 0 }
v49.Visible = false
v49.HighlightOffset = nil
v49.HighlightOn = false
v49.VisRangeInfo = {}
local v50 = nil
local v51 = nil
local total = 0
local v52 = 0
local wishlistItems = {}
local v53 = nil
local v54 = nil
local flag3 = false
local v55 = 0
local v56 = nil
local v57 = nil
local v58 = nil
local v59 = nil
local v60 = nil
local v61 = nil
local v62 = nil
local v63 = nil
local v64 = { GiftBtn = nil, MuseumBtn = nil }
local v65 = { Regular = nil, Bp = nil }
local v66 = {
	CanToggleCurrencyBar = false,
	ClearedGridModMaterials = false,
	PanelLoading = false,
	IsDailyDeal = false
}
local v67 = {}
local v68 = {
	INNER_RECT_COLOR = 790804,
	LINK_COLOR_HEX = module2.ConvertColorNumberToHex(_G.UIColor_Hyperlink),
	LINK_COLOR_HOVER_HEX = module2.ConvertColorNumberToHex(_G.UIColor_Yellow),
	PRICE_BG_COLOR = 11749898
}
local fn2
local fn3
local fn4
local fn5
local fn6
local fn7
local fn8
local fn9
local fn10
local v69 = true
local v70 = false

local function fn11()
	v67 = {
		FloatingContent = module7.GetColor(9, true),
		FloatingContentHighlight = module7.GetColor(10, true),
		Content = module7.GetColor(6, true),
		Background1 = module7.GetColor(2, true),
		Negative = module7.GetColor(12, true),
		Background1Object = module7.GetColor(2, false),
		Background2Object = module7.GetColor(3, false)
	}
	v67.FloatingContentHex = module2.ConvertColorNumberToHex(v67.FloatingContent)
	v67.FloatingContentHighlightHex = module2.ConvertColorNumberToHex(v67.FloatingContentHighlight)
	v67.ContentHex = module2.ConvertColorNumberToHex(v67.Content)
	v67.NegativeHex = module2.ConvertColorNumberToHex(v67.Negative)
	mMovie:__wf_atom_e57658c2("CornerBg", 11, v67.Background1)
	mMovie:__wf_atom_e57658c2("LinesTop", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("Watermark", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("LinesBottom", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("ItemGrid.Title", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("ItemGrid.TitleBg", 11, v67.Background1)
	mMovie:__wf_atom_e57658c2("DetailedView.ItemName", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Wishlist", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Owned.Icon", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Owned.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Mastered.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Tradeable.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Tradeable.Icon", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.RankLock.Rank", 44, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.RankLock.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.RankLock.Backer", 11, v67.Background1)
	mMovie:__wf_atom_e57658c2("DetailedView.RecipesOwned.Icon", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.RecipesOwned.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.Wishlist", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.ParentBundles.Title", 44, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.Compatible.Title", 44, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.CrewMemberSkills.Faction", 11, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.CrewMemberSkills.TraitInfo.Icon", 11, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.GiftBonusLabel", 44, v67.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm.Label", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm.Confirm.Discount", 44, v67.Content)
	mMovie:__wf_atom_e57658c2(
		"DetailedView.BelowDescription.PurchaseConfirm.Confirm.Separator",
		11,
		v67.FloatingContent
	)
	mMovie:__wf_atom_e57658c2(
		"DetailedView.BelowDescription.PurchaseConfirm.Confirm.StrikeThrough",
		11,
		v67.FloatingContentHighlight
	)
	local background1Object = v67.Background1Object
	local background2Object = v67.Background2Object
	mMovie:OverrideMaterial("DetailedView.BelowDescription.PurchaseConfirm.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"DetailedView.BelowDescription.PurchaseConfirm.Bg",
		"RectEdgeColor",
		background2Object.red / 255,
		background2Object.green / 255,
		background2Object.blue / 255,
		0.45
	)
	mMovie:__wf_atom_1ca72041(
		"DetailedView.BelowDescription.PurchaseConfirm.Bg",
		"RectInnerColor",
		background1Object.red / 255,
		background1Object.green / 255,
		background1Object.blue / 255,
		0.45
	)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.CouponValue", 44, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.BonusValue", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.CouponDescription", 44, v67.Content)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.TimeLeft", 44, v67.FloatingContent)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.CouponIcon", 11, v67.FloatingContentHighlight)
	mMovie:OverrideMaterial("DetailedView.BelowDescription.BonusCoupon.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"DetailedView.BelowDescription.BonusCoupon.Bg",
		"RectEdgeColor",
		background2Object.red / 255,
		background2Object.green / 255,
		background2Object.blue / 255,
		0.45
	)
	mMovie:__wf_atom_1ca72041(
		"DetailedView.BelowDescription.BonusCoupon.Bg",
		"RectInnerColor",
		background1Object.red / 255,
		background1Object.green / 255,
		background1Object.blue / 255,
		0.45
	)
	mMovie:__wf_atom_c90af43a("DetailedView.BelowDescription.BonusCoupon.CouponIcon", bonusCouponIcon)
	mMovie:__wf_atom_c90af43a("DetailedView.BelowDescription.BonusCoupon.BackerIcon", bonusCouponBacker)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.BackerIcon", 12, 10)
	mMovie:OverrideMaterial("DetailedView.BelowDescription.BonusCoupon.CouponIcon", bonusCouponIconMaterial)
	mMovie:__wf_atom_7df746cd(v67.Background1)

	if not __wf_atom_7e8ad928(v28.mInputField) then
		v28.UpdateColors()
	end

	if not __wf_atom_7e8ad928(v64.MuseumBtn) then
		v64.MuseumBtn:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v64.GiftBtn) then
		v64.GiftBtn:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v53) then
		v53:OnStyleChanged()
	end

	if not __wf_atom_7e8ad928(v60) then
		v60:RunForAllElements(function(p)
			if not __wf_atom_7e8ad928(p.Button) then
				p.Button:UpdateColors()
			end
		end)
	end

	if not __wf_atom_7e8ad928(v61) then
		v61:RunForAllElements(function(p)
			if not __wf_atom_7e8ad928(p.Button) then
				p.Button:UpdateColors()
			end
		end)
	end

	if not __wf_atom_7e8ad928(v58) then
		v58:RunForAllElements(function(p)
			v58.UpdateColors(p.mClipName)
			p.mPipList:RunForAllElements(function(p2)
				p.mPipList.UpdateColors(p2.mClipName)
			end)
		end)
	end
end

local function fn12(storeItem)
	if __wf_atom_7e8ad928(storeItem) then
		return false
	end

	for _, className in pairs(v2) do
		if not __wf_atom_7e8ad928(className) and storeItem:IsA(className) then
			return true
		end
	end

	if storeItem:__wf_atom_efa6f447() ~= 6 and storeItem:__wf_atom_efa6f447() ~= 10 then
		return false
	end

	for _, className in pairs(v) do
		if not __wf_atom_7e8ad928(className) and storeItem:IsA(className) then
			return false
		end
	end

	return true
end

local function fn13(item)
	return not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_87580f1c)
end

function SetExitCallback(p)
	v34 = p
end

function SetExitCallbackIsTemp(p)
	v35 = p == "true"
end

local function fn14()
	if not v66.ClearedGridModMaterials then
		module6.ClearGridModMaterials()
		v66.ClearedGridModMaterials = true
	end

	if v34 == nil or v36 then
		return
	end

	v36 = true

	if v35 or __wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		if v35 and not __wf_atom_7e8ad928(_T[v34]) then
			_T[v34]()
		end
	else
		mMovie:__wf_atom_2ad5cd23():Execute(v34, "")
	end
end

function Shutdown()
	if v66.CanToggleCurrencyBar and _T.UIInputEnabled and not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	if not __wf_atom_7e8ad928(class) and class.mInDioramaMode then
		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end

	if v41 and not __wf_atom_7e8ad928(mMovie) then
		local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

		if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
			__wf_atom_2ad5cd23:SetVisible(true)
		end
	end

	module3.RegisterHideEOM(false)
	module3.RegisterHideHud(false)

	if v40.Applied then
		module7.ForceDefaultStyle(v40.OrigTheme, v40.OrigBg, v40.OrigSounds)
	end

	if v49.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		if not _T.BoosterPackShowingBackground then
			_T.ShowBackground(0, v49.HighlightOffset, v49.HighlightOn, v49.VisRangeInfo)
		end
	elseif not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	_T.ExternalProductPostPurchaseSyncHandled = false
	_T.InfoPopup_Data = nil

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if v14 ~= nil then
		if not __wf_atom_7e8ad928(v14.StepSequencer) then
			v14.StepSequencer:Destroy()

			if not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ItemBrowsingMovie) then
				local entity = module2.GetEntityFromTag("LisetSoundsFadeIn")

				if not __wf_atom_7e8ad928(entity) then
					entity:FirePort("Execute")
				end
			end
		end

		v14 = nil
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Close()
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):OnClose()
	end

	module3.RegisterHideStarChart(false)
	_T.maximumSyndicateScarfIntensity = false
	module6.ToggleScreensToHide(true, v48)

	if not (_T.AppearancePreviewOpen or _T.PlatGridDisplayed) then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("HideScreenForPlatPurchase", "false")
	end

	fn14()
end

local function fn15()
	local v71 = {}

	if not class.mInMuseum and v54 ~= nil and v54.HasRelated and not (v9.HIDE_RELATED or v9.HIDE_ITEM_GRID) then
		local label = v54.mFilterBy ~= v54.Mode.RELATED and "/Lotus/Language/Menu/DetailedPurchase_ViewRelated"
			or flag3 and "/Lotus/Language/Store/DetailedPurchase_ViewMoreRelated"
			or module2.Ternary(
				v54.HasPackage,
				"/Lotus/Language/Menu/DetailedPurchase_ViewBundle",
				"/Lotus/Language/Menu/DetailedPurchase_HideRelated"
			)

		if label ~= "DetailedPurchase_ViewRelated" then
			table.insert(v71, {
				Label = label,
				CallBack = function()
					mMovie:Execute("ToggleItemGrid", "")
				end,
				CallOut = "MENU_GENERIC1"
			})
		end
	end

	if Engine.IsPlayingWithController() then
		local currInfo = class:GetCurrInfo()

		if not __wf_atom_7e8ad928(currInfo) then
			local _, v72, _ = class:UpdatePurchaseButton(currInfo)

			if v72 or currInfo.CurrInWishlist then
				table.insert(v71, {
					Label = TitleCase(mMovie:__wf_atom_8e9ac384(
						module2.Ternary(
							currInfo.CurrInWishlist,
							"/Lotus/Language/Menu/DetailedPurchase_RemoveFromWishlist",
							"/Lotus/Language/Menu/DetailedPurchase_AddToWishlist"
						),
						false
					)),
					CallBack = function()
						mMovie:Execute("ToggleWishlist", "")
					end,
					CallOut = "MENU_GENERIC2"
				})
			end
		end
	end

	table.insert(v71, {
		Label = module2.Ternary(
			#v8 > 0 or base ~= v7.BASE or class.mInMuseum,
			"/Lotus/Language/Menu/Global_Back",
			"/Lotus/Language/Menu/Exit"
		),
		CallBack = function()
			mMovie:Execute("GoBack", "")
		end,
		CallOut = "MENU_CANCEL",
		ForceHandled = true
	})

	if #v8 > 0 then
		table.insert(v71, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = function()
				mMovie:Execute("TransitionOut", "")
			end
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v71, getfenv(1))
	end
end

function ToggleItemGrid()
	if __wf_atom_7e8ad928(v54) then
		return
	end

	if v54.mFilterBy ~= v54.Mode.RELATED or flag3 then
		local currInfo = class:GetCurrInfo()
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("ITEM_SHOW_RELATED"), currInfo.StoreItem:__wf_atom_5b41f63b())
	end

	local v71 = flag3
	flag3 = false
	v54:SetCategory(module2.Ternary(v54.mFilterBy == v54.Mode.PACKAGE or v71, v54.Mode.RELATED, v54.Mode.PACKAGE))
	fn15()
end

local function fn16()
	if #wishlistItems == 0 or __wf_atom_7e8ad928(gameData) then
		return false
	end

	gameData:__wf_atom_42c631e3(wishlistItems, "OnWishlistChangesSaved")
	_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
		"2",
		"/Lotus/Language/Menu/DetailedPurchase_UpdatingWishlist"
	})
	return true
end

local function fn17(object)
	if __wf_atom_7e8ad928(v16) then
		if __wf_atom_7e8ad928(v43) or __wf_atom_7e8ad928(_T[v43]) then
			if not __wf_atom_7e8ad928(gGameRules) then
				v16 = gGameRules:__wf_atom_964056fd()
			end
		else
			v16 = _T[v43]
		end
	end

	if not __wf_atom_7e8ad928(v16) then
		return v16:GetStoreItem(object)
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	local v71

	if
		string.sub(__wf_atom_5b41f63b, 1, (string.len("/Lotus/"))) == "/Lotus/"
		and string.sub(__wf_atom_5b41f63b, 1, (string.len("/Lotus/StoreItems/"))) ~= "/Lotus/StoreItems/"
	then
		local v72 = "/Lotus/StoreItems/" .. string.sub(__wf_atom_5b41f63b, string.len("/Lotus/") + 1)
		v71 = Resource(v72)
	end

	if not __wf_atom_7e8ad928(v71) then
		return v71
	end

	print("DetailedPurchaseDialog: Couldn't find storeItem for: " .. object:__wf_atom_5b41f63b())
	return nil
end

local function fn18(mItemType)
	local v71 = fn17(mItemType)

	if __wf_atom_7e8ad928(v71) then
		return (Resource(mItemType))
	end

	return v71
end

local function fn19(storeItem, ternary)
	local saleInfo = module3.GetSaleInfo(storeItem)
	local v71 = not (saleInfo and saleInfo.mBogoBuy > 0 and saleInfo.mBogoGet > 0) and 0
		or math.floor(ternary / saleInfo.mBogoBuy) * saleInfo.mBogoGet
	return v71, ternary + v71
end

function OnPostExtPurchaseSync()
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	v47 = mMovie:PushChildMovie(purchaseCelebrationMovie)

	if
		_T.LockedGoalList
		and _T.LockedGoalList.TennoConHUB2
		and not __wf_atom_7e8ad928(class.SelectedElement.StoreItem)
		and class.SelectedElement.StoreItem:GetItem() == WeakResource("/Lotus/Types/Items/DiscordItems/DiscordTennoConPack")
	then
		_T.BackgroundMovie:Execute("NotifyWorldStateChanged", "TennoConHUB2")
	end

	if not __wf_atom_7e8ad928(callback) then
		callback(true)
	end

	flag2 = true
end

function OnPostSteamPurchaseSync()
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	v47 = mMovie:PushChildMovie(purchaseCelebrationMovie)

	if not __wf_atom_7e8ad928(callback) then
		callback(true)
	end

	flag2 = true
end

function OnIOSPurchaseCallback(p, value)
	if __wf_atom_7e8ad928(value) then
		return
	end

	if not __wf_atom_7e8ad928(v50) then
		v50:Close()
		v50 = nil
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	if p then
		if p and not __wf_atom_7e8ad928(gameData) then
			gameData:SyncInventoryFromDB("OnPostExtPurchaseSync")
			return
		end

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		if not __wf_atom_7e8ad928(callback) then
			callback(p)
		end
	else
		if string.find(value, "Cancelled") == nil or __wf_atom_7e8ad928(_T.BackgroundMovie) then
			module2.ShowMessage("/Lotus/Language/Menu/Steam_PurchaseError")
			return
		end

		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		module2.ShowMessage("/Lotus/Language/Menu/PurchaseCanceled", "ClosePurchaseDialog")
	end
end

function OnSteamPurchaseCallback(flag4, p)
	if flag4 then
		local v71 = __wf_atom_0a63ecce(p) == "" and {} or cjson.decode(p)

		if v71.Cancelled then
			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
			end

			return
		elseif v71.redirectURL then
			module2.ShowMessage("/Lotus/Language/Menu/Steam_CompletePurchaseInBrowser")
			_T.ExternalProductPurchaseInitiated = true
			flag4 = false
		end
	else
		module2.ShowMessage("/Lotus/Language/Menu/Steam_PurchaseError")
	end

	if flag4 and not __wf_atom_7e8ad928(gameData) then
		gameData:SyncInventoryFromDB("OnPostSteamPurchaseSync")
		local _storeItem = class.SelectedElement.StoreItem
	else
		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		if not __wf_atom_7e8ad928(callback) then
			callback(flag4)
		end
	end
end

function OnActivateEpicCouponCallback(p, p2)
	if p and p2 ~= nil then
		local v71 = __wf_atom_0a63ecce(p2) == "" and {} or cjson.decode(p2)

		if v71.Cancelled then
			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
				module2.ShowMessage("/Lotus/Language/Menu/PurchaseCanceled", "ClosePurchaseDialog")
			end
		elseif v71.SkuId then
			gameData:__wf_atom_e97291d8(v71.SkuId, v71.DiscountPercentage, "OnEpicPurchaseCallback")
		end
	else
		module2.ShowMessage("/Lotus/Language/Menu/PurchaseCanceled", "ClosePurchaseDialog")

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end
	end
end

function ClosePurchaseDialog()
	flag2 = true
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_2ad5cd23 then
		__wf_atom_2ad5cd23:__wf_atom_e57658c2("_root", 12, 100)
	end
end

function OnEpicPurchaseCallback(p, p2)
	if not __wf_atom_7e8ad928(v50) then
		v50:Close()
		v50 = nil
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	if Engine.__wf_atom_0654e862() > 0 then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Steam_PurchaseError", false)
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/ERROR", false)
		local __wf_atom_0654e862 = Engine.__wf_atom_0654e862()

		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("EPIC_PURCHASE_ERR"), "E" .. __wf_atom_0654e862)
		end

		module2.ShowMessage(__wf_atom_8e9ac384 .. "\r\n\r\n" .. __wf_atom_8e9ac384_2 .. " E" .. __wf_atom_0654e862)
		Engine.__wf_atom_0afa5ef3()
	elseif tonumber(p) == 4 and p2 == nil then
		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		return
	elseif p and p2 ~= nil then
		if (__wf_atom_0a63ecce(p2) == "" and {} or cjson.decode(p2)).Cancelled then
			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
				module2.ShowMessage("/Lotus/Language/Menu/PurchaseCanceled", "ClosePurchaseDialog")
			end

			return
		end
	else
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		module2.ShowMessage("/Lotus/Language/Menu/Steam_PurchaseError")
	end

	if p and not __wf_atom_7e8ad928(gameData) then
		gameData:SyncInventoryFromDB("OnPostExtPurchaseSync")
	else
		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		if not __wf_atom_7e8ad928(callback) then
			callback(p)
		end
	end

	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_2ad5cd23 then
		__wf_atom_2ad5cd23:__wf_atom_e57658c2("_root", 12, 100)
	end
end

local function fn20(p)
	if __wf_atom_7e8ad928(class.SelectedElement) or __wf_atom_7e8ad928(class.SelectedElement.StoreItem) then
		return
	end

	if flag or not class.SelectedElement.mCanPurchase or __wf_atom_7e8ad928(gameData) then
		return
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		module2.ShowErrorMessage("/Lotus/Language/Menu/DetailedPurchase_NewBuild")
		return
	end

	module5.CheckExternalProductState(class.SelectedElement, gameData, nil)
	_T.ExternalProductPostPurchaseSyncHandled = false
	_T.purchasedItems = v13
	module2.PlaySound(_G.UISound_Select)
	local v71 = class.SelectedElement.ShowCoupon
		and (__wf_atom_7e8ad928(class.SelectedElement.Coupon.mCouponType) or class.SelectedElement.Coupon.mCouponType == 0)
	local __wf_atom_efa6f447 = class.SelectedElement.StoreItem:__wf_atom_efa6f447()
	local flag4 = true
	local flag5 = false

	if p and __wf_atom_efa6f447 == 48 then
		for i = 1, #v23 do
			if module3.HasCompletedQuest(v23[i]) then
				continue
			end

			flag5 = true
			break
		end
	end

	local worldStateOverride = module9.GetWorldStateOverride("PurchasePlatformLockEnabled", false)

	if not __wf_atom_7e8ad928(gGameData) then
		worldStateOverride = worldStateOverride
			and not gGameData:__wf_atom_7f86fc42(Symbol("PurchasePlatformLockedNotificationSeen"))
	end

	if class.SelectedElement.OverrideBuyFunction and not __wf_atom_7e8ad928(callback) then
		callback(v30)
		flag4 = false
	elseif
		class.SelectedElement.StoreItem:__wf_atom_955f7fe0()
		and fn12(class.SelectedElement.StoreItem)
		and worldStateOverride
		and not v32
	then
		if Engine.__wf_atom_fc67ba71() then
			module2.ShowConfirmMessage(
				"/Lotus/Language/Store/PurchaseConsoleLocked",
				"OnPurchasePlatformLockedConfirmed"
			)
		else
			module2.ShowConfirmMessage("/Lotus/Language/Store/PurchasePCLocked", "OnPurchasePlatformLockedConfirmed")
		end
	elseif v31 or not (v30 >= 1000) then
		if class.SelectedElement.PurchaseCompatWarning == nil or not p then
			if
				p
				and (__wf_atom_efa6f447 == 27 or __wf_atom_efa6f447 == 28 or __wf_atom_efa6f447 == 29 or __wf_atom_efa6f447 == 42)
				and not gameData:__wf_atom_4f5d3848()
				and (not Engine.__wf_atom_eecb6143() or Engine.__wf_atom_eecb6143() and class.SelectedElement.StoreItem:__wf_atom_56c51289() == 0)
			then
				module2.ShowMessage("/Lotus/Language/Menu/ArchwingFailurePurchase")
			elseif flag5 then
				module2.ShowMessage("/Lotus/Language/Store/MechPurchaseFailure")
			elseif not (class.SelectedElement.IsExternalProduct and class.SelectedElement.PrimeAccessComingSoon) then
				if class.SelectedElement.IsExternalProduct and class.SelectedElement.ExternalProductPurchased then
					module2.ShowMessage("/Lotus/Language/Menu/Item_CannotPurchaseAlreadyOwned")
				elseif
					class.SelectedElement.IsExternalProduct
					and not class.SelectedElement.ExternalProductAvailable
				then
					module2.ShowMessage("/Lotus/Language/Menu/Item_CannotPurchaseUnavailable")
				elseif
					(Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_e43a530e() or Engine.__wf_atom_b290ec01())
					and class.SelectedElement.IsExternalProduct
				then
					_T.ExternalProductPostPurchaseSyncHandled = true
					module2.DoShowPlatformStore(module3.GetProductId(class.SelectedElement.StoreItem))
				elseif Engine.__wf_atom_2a979d69() and class.SelectedElement.IsExternalProduct then
					local v72 = not v71 and 0 or class.SelectedElement.Coupon.mAmount * 100
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.dialogType = 2
					dialogSettings.locString = "/Lotus/Language/Store/IOS_InitiatingPurchase"
					dialogSettings.firstString = "/Menu/Confirm_Item_Cancel"
					dialogSettings.secondString = ""
					dialogSettings:SetCallback("OnIOSPurchaseCallback")
					v50 = module2.ShowCustomMessage(dialogSettings)
					_T.ExternalProductPostPurchaseSyncHandled = true
					gameData:__wf_atom_aa63152b(
						module3.GetProductId(class.SelectedElement.StoreItem),
						v72,
						"OnIOSPurchaseCallback"
					)
				elseif
					Engine.__wf_atom_6f25c160()
					and class.SelectedElement.IsExternalProduct
					and not Engine.__wf_atom_eecb6143()
					and class.SelectedElement.StoreItem:__wf_atom_836b9069()
				then
					_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
						"2",
						"/Lotus/Language/Menu/Steam_InitiatingPurchase"
					})
					local mAmount = 0

					if v71 then
						if class.SelectedElement.IsExternalPlat then
							mAmount = class.SelectedElement.Coupon.mAmount * 100
						else
							mAmount = class.SelectedElement.Coupon.mAmount
						end
					elseif not (__wf_atom_7e8ad928(class.SelectedElement.SalePriceInfo.Discount) or class.SelectedElement.ShowCoupon) then
						mAmount = class.SelectedElement.SalePriceInfo.Discount * 100
					end

					_T.ExternalProductPostPurchaseSyncHandled = true
					gameData:__wf_atom_71b1717e(
						module3.GetProductId(class.SelectedElement.StoreItem),
						"OnSteamPurchaseCallback",
						mAmount
					)
				elseif
					Engine.__wf_atom_8dbe8185()
					and class.SelectedElement.IsExternalProduct
					and class.SelectedElement.StoreItem:__wf_atom_56c51289() > 0
				then
					_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
						"2",
						"/Lotus/Language/Store/Epic_InitiatingPurchase"
					})
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.dialogType = 2
					dialogSettings.locString = "/Lotus/Language/Store/Epic_InitiatingPurchase"
					dialogSettings.firstString = "/Menu/Confirm_Item_Cancel"
					dialogSettings.secondString = ""
					_T.ExternalProductPostPurchaseSyncHandled = true

					if v71 then
						dialogSettings:SetCallback("OnEpicPurchaseCallback")
						v50 = module2.ShowCustomMessage(dialogSettings)
						gameData:__wf_atom_e97291d8(
							module3.GetProductId(class.SelectedElement.StoreItem),
							class.SelectedElement.Coupon.mAmount * 100,
							"OnEpicPurchaseCallback"
						)
					else
						dialogSettings:SetCallback("OnEpicPurchaseCallback")
						v50 = module2.ShowCustomMessage(dialogSettings)
						gameData:__wf_atom_e97291d8(
							module3.GetProductId(class.SelectedElement.StoreItem),
							0,
							"OnEpicPurchaseCallback"
						)
					end
				elseif class.SelectedElement.IsExternalProduct then
					local mUrlOverride

					if
						__wf_atom_7e8ad928(class.SelectedElement.Sale)
						or __wf_atom_7e8ad928(class.SelectedElement.Sale.mUrlOverride)
						or class.SelectedElement.Sale.mUrlOverride == ""
					then
						mUrlOverride = not class.SelectedElement.StoreItem:__wf_atom_d242670f():__wf_atom_8598f3a9()
							and "https://www.warframe.com/gameplatinum"
							or class.SelectedElement.StoreItem:__wf_atom_d242670f():c_str()
					else
						mUrlOverride = class.SelectedElement.Sale.mUrlOverride
					end

					if not __wf_atom_7e8ad928(mUrlOverride) then
						_T.ExternalProductPurchaseInitiated = true
						_T.ExternalProductPostPurchaseSyncHandled = false
						module5.OpenBrowserToStoreLink(mUrlOverride, class.SelectedElement.StoreItem)
					end
				else
					if v66.IsDailyDeal then
						local purchaseParams = SF.PurchaseParams()
						purchaseParams.mSource = 3
						purchaseParams.mStoreItem = class.SelectedElement.StoreItem
						purchaseParams.mSkipConfirm = true
						_T.DoPurchase(purchaseParams, callback)
					elseif v71 then
						local purchaseParams = SF.PurchaseParams()

						if v9.SOURCE_OVERRIDE then
							purchaseParams.mSource = v9.SOURCE_OVERRIDE.Type
							purchaseParams.mSourceId = v9.SOURCE_OVERRIDE.Id
						else
							purchaseParams.mSource = module3.GetCurrentPurchaseSource()
						end

						purchaseParams.mCouponId.mId = class.SelectedElement.Coupon.mId
						purchaseParams.mStoreItem = class.SelectedElement.StoreItem
						purchaseParams.mSkipConfirm = true
						_T.DoPurchase(purchaseParams, callback)
					else
						_T.BuyItem(class.SelectedElement.StoreItem, callback, v30, true, nil, v9.SOURCE_OVERRIDE)
					end

					flag4 = false
				end
			end
		else
			module2.ShowConfirmMessage(class.SelectedElement.PurchaseCompatWarning, "OnNonCompatibleConfirm")
		end
	else
		local v72 = Localize(tostring(module5.GetStoreItemTag(class.SelectedElement.StoreItem)), {})
		local v73 = "<font color=\"" .. v67.FloatingContentHex .. "\">" .. v72 .. "</font>"
		local formatNumber = module2.FormatNumber(v30)
		local quantity = "<font color=\"" .. v67.FloatingContentHighlightHex .. "\">" .. formatNumber .. "</font>"
		local currencyText = class.SelectedElement.RegularPriceInfo.CurrencyText
		local formatNumber2 = module2.FormatNumber(class.SelectedElement.RegularPriceInfo.Price * v30)

		if not (__wf_atom_7e8ad928(class.SelectedElement.SalePriceInfo) or __wf_atom_7e8ad928(class.SelectedElement.SalePriceInfo.Price)) then
			formatNumber2 = module2.FormatNumber(class.SelectedElement.SalePriceInfo.Price * v30)
		end

		local cost = "<font color=\"" .. v67.FloatingContentHighlightHex .. "\">" .. formatNumber2 .. "</font>"
		local v76 = "<p><font color=\"" .. module2.ConvertColorNumberToHex(module7.GetColor(6, true)) .. "\">" .. Localize("/Lotus/Language/Store/ConfirmQuantity", {
			QUANTITY = quantity,
			ITEM = v73,
			CURRENCY = currencyText,
			COST = cost
		}) .. "</font></p>"
		module2.ShowConfirmMessage(v76, "OnQuantityConfirm")
	end

	if flag4 then
		_T.purchasedItems = nil
	end
end

function OnPurchase()
	v31 = false

	if __wf_atom_7e8ad928(class) or not class.IsGifting then
		fn20(true)
	else
		fn5()
	end
end

local function fn21(selectedElement, isGifting)
	if __wf_atom_7e8ad928(selectedElement) or __wf_atom_7e8ad928(class) then
		return
	end

	class.SelectedElement = selectedElement
	class.IsGifting = isGifting

	if v42 and class:CanMultiPurchaseItem(selectedElement) then
		fn6(v7.MULTI)
	elseif isGifting then
		fn5()
	else
		fn6(v7.CONFIRM)
	end
end

local function fn22()
	fn21(v10.ITEM)
end

local function fn23()
	fn21(v10.BLUEPRINT)
end

local function fn24()
	if v65.Regular ~= nil then
		module2.ShowMessage(v65.Regular)
	end
end

local function fn25()
	if v65.Bp ~= nil then
		module2.ShowMessage(v65.Bp)
	end
end

function OnGiftPressed()
	fn21(v10.ITEM, true)
end

function OnNonCompatibleConfirm(p)
	if tonumber(p) == 4 then
		fn20(false)
	end
end

function OnPurchasePlatformLockedConfirmed(p)
	if tonumber(p) == 4 then
		v32 = true

		if not (__wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_7f86fc42(Symbol("PurchasePlatformLockedNotificationSeen"))) then
			gGameData:__wf_atom_c9bb8504(Symbol("PurchasePlatformLockedNotificationSeen"))
		end

		fn20(true)
	end
end

function OnPurchasePlatformLockedGiftConfirmed(p)
	if tonumber(p) == 4 then
		v32 = true
		fn5()
	end
end

function OnQuantityConfirm(p)
	if tonumber(p) == 4 then
		v31 = true
		fn20(true)
	end
end

local function fn26(p)
	local v71 = nil
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return v71
	end

	local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
	local v72 = __wf_atom_18a5d83b:__wf_atom_e75653c3() ~= __wf_atom_18a5d83b:__wf_atom_8becc743() and 0
		or __wf_atom_63bb2bc6
	local __wf_atom_940f8971 = Engine.__wf_atom_940f8971(p.mDisplayName)
	local v73 = #p.mPlatformNames > 0 and 0 or __wf_atom_940f8971

	if v72 == v73 then
		return v71
	end

	if (__wf_atom_63bb2bc6 == 0 or v72 == 0) and v73 ~= 0 then
		if __wf_atom_63bb2bc6 == 0 or v73 ~= __wf_atom_63bb2bc6 then
			return "GiftFail_OtherPlatformNeedsCrossSave"
		end

		return "GiftFail_OtherUserNeedsCrossSave"
	else
		if v73 == 0 then
			return "GiftFail_OtherUserIsCrossSave"
		end

		return "GiftFail_BothNeedCrossSave"
	end
end

function ShowPlayerSelectionOptions(list, callback2)
	if not __wf_atom_7e8ad928(v5) then
		v5:Close()
	end

	v5 = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(v5) then
		flag = true
		v5:Execute("SetTitle", "/Lotus/Language/Chat/PlayerSelection")
		v5:__wf_atom_f62a8704("SetTitleCaseText", { "false", "true" })

		function _T.PlayerSelectionDone(list2)
			_T.PlayerSelectionDone = nil
			_T.GetPlayerList = nil
			flag = false

			if __wf_atom_7e8ad928(list2) or list2[1] == nil then
				callback2(nil)
			else
				callback2(list2[1])
			end
		end

		v5:Execute("SetCallBack", "PlayerSelectionDone")

		function _T.GetPlayerList()
			local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
			local result = {}

			for i = 1, #list do
				local mFriendInfo = list[i]
				local mDisplayName = mFriendInfo.mDisplayName
				local v72 = Engine.__wf_atom_746f9d1b(string.lower(mDisplayName)) == _T.GiftParams.Recipient
				local v73 = v72 and Engine.__wf_atom_940f8971(mDisplayName) == __wf_atom_63bb2bc6

				if not v73 then
					for _, mPlatformName in ipairs(mFriendInfo.mPlatformNames) do
						if Engine.__wf_atom_746f9d1b(string.lower(mPlatformName)) ~= _T.GiftParams.Recipient then
							continue
						end

						if Engine.__wf_atom_940f8971(mPlatformName) == __wf_atom_63bb2bc6 then
							mDisplayName = mPlatformName
							v72 = true
							v73 = true
						elseif not v72 then
							mDisplayName = mPlatformName
							v72 = true
						end
					end
				end

				local __wf_atom_1b118af6 = Engine.__wf_atom_1b118af6(mDisplayName)
				local _ = fn26(mFriendInfo) == nil
				local v74 = {
					mName = __wf_atom_1b118af6,
					mFriendInfo = mFriendInfo,
					mFriendInfoExcluded = mDisplayName
				}

				if v73 then
					table.insert(result, 1, v74)
				else
					table.insert(result, v74)
				end
			end

			return result
		end

		v5:Execute("SetElementsFunction", "GetPlayerList")
	end
end

local function fn27(p)
	if p ~= nil then
		print("Picked " .. p.mFriendInfo.mId)
		local v71 = fn26(p.mFriendInfo)

		if v71 == nil then
			_T.GiftParams.RecipientId = p.mFriendInfo.mId
			mMovie:Execute("OnGiftConfirmed", (tostring(4)))
		else
			module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/" .. v71, true, {
				PLAYER_NAME = p.mFriendInfo.mDisplayName
			}))
			mMovie:Execute("OnGiftConfirmed", (tostring(5)))
		end
	end
end

local v71 = nil

function OtherPlatformRecipientConfirmed(p)
	if tonumber(p) ~= 4 or __wf_atom_7e8ad928(gameData) then
		v71 = nil
		return
	end

	_T.GiftParams.RecipientId = gameData:__wf_atom_4ca9dd3e()[1].mId
	mMovie:Execute("OnGiftConfirmed", (tostring(4)))
end

function OnGiftSent(p, value)
	_T.GiftParams.RecipientId = nil

	if p then
		if string.find(value, "%{\"Results") == 1 then
			local __wf_atom_4ca9dd3e = gameData:__wf_atom_4ca9dd3e()

			if #__wf_atom_4ca9dd3e == 1 then
				local v72 = __wf_atom_4ca9dd3e[1]
				local __wf_atom_1b118af6 = Engine.__wf_atom_1b118af6(v72.mDisplayName)

				if v72.mPlatformNames ~= nil then
					local count = #v72.mPlatformNames
					local v73 = __wf_atom_1b118af6 .. " ("

					for i = 1, count do
						v73 ..= Engine.__wf_atom_1b118af6(v72.mPlatformNames[i])

						if i < count then
							v73 ..= ", "
						end
					end

					__wf_atom_1b118af6 = v73 .. ")"
				end

				local v73 = fn26(v72)

				if v73 == nil then
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.dialogType = 1
					dialogSettings.locString = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Store/GiftConfirm_OtherPlatform",
						true,
						{ PLAYER_NAME = __wf_atom_1b118af6 }
					)
					dialogSettings.firstString = "/Lotus/Language/Store/GiftSendConfirm"
					dialogSettings:SetCallback("OtherPlatformRecipientConfirmed")
					gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
				else
					module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/" .. v73, true, {
						PLAYER_NAME = __wf_atom_1b118af6
					}))
					mMovie:Execute("OnGiftConfirmed", (tostring(5)))
					return
				end
			else
				ShowPlayerSelectionOptions(__wf_atom_4ca9dd3e, fn27)
			end
		else
			v71 = nil
			module2.PlaySound(_G.UISound_Purchase)
			local v72 = "/Lotus/Language/Menu/GiftSuccess"
			local v73

			if not __wf_atom_7e8ad928(v16) then
				v73 = v16:__wf_atom_51fc44cc(v10.ITEM.StoreItem)
			end

			if not __wf_atom_7e8ad928(v73) then
				local localizedItemName = module5.GetLocalizedItemName(mMovie, v73)
				v72 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftSuccessWithBonus", false, {
					BONUS = localizedItemName
				})
			end

			module2.ShowMessage(v72)

			if not (__wf_atom_7e8ad928(v73) or __wf_atom_7e8ad928((__wf_atom_8e4fda44:__wf_atom_8b74c30b(rewardsMovie)))) then
				_T.DisplayReward(v73)
			end
		end
	else
		v71 = nil
		local v72 = tonumber(value)

		if v72 == nil then
			if string.find(value, "/Lotus/Language") == 1 then
				module2.ShowMessage(value)
			else
				module2.ShowMessage("/Lotus/Language/Store/GiftFail")
			end
		elseif v72 == 24 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_SendToSelf", {}))
		elseif v72 == 23 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_PlatformLocked", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 19 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_DecoLimit", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 17 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_RecipientDisabledGifts", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 16 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_ExceedBinCapacity", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 15 then
			module2.ShowMessage("/Lotus/Language/Menu/PurchaseFailure_NewBuild")
		elseif v72 == 14 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_RecipientUntutored", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 22 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_RecipientUnDuviried", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 12 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_RecipientBanned", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 11 then
			module2.ShowMessage("/Lotus/Language/Store/GiftFail_GifterBanned")
		elseif v72 == 10 then
			local __wf_atom_4438d3ad = gameData:__wf_atom_4438d3ad()
			module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftFail_NoGiftsRemaining", true, {
				NUM_GIFTS = __wf_atom_4438d3ad
			}))
		elseif v72 == 9 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_PlayerDoesNotExist", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 8 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_AlreadyOwned", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 7 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_ArchwingNotEnabled", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 20 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_MechNotEnabled", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 2 then
			module2.ShowMessage(Localize("/Lotus/Language/Store/GiftFail_InsufficientXP", {
				PLAYER_NAME = _T.GiftParams.Recipient
			}))
		elseif v72 == 1 then
			module2.ShowMessage("/Lotus/Language/Store/GiftFail_InsufficientFunds")
		else
			module2.ShowMessage("/Lotus/Language/Store/GiftFail")
		end
	end

	if not __wf_atom_7e8ad928(callback) then
		callback(p, nil, true)
	end
end

function OnGiftConfirmed(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(gameData) then
		local v72 = _T.GiftParams.RecipientId == nil and "" or _T.GiftParams.RecipientId
		module3.AddMatchmakingLabelToPurchaseParams(v71)
		gameData:SendGift(v71, _T.GiftParams.Recipient, v72, _T.GiftParams.Message, "OnGiftSent")
	else
		v71 = nil
		_T.GiftParams.RecipientId = nil
	end
end

local function fn28()
	local currInfo = class:GetCurrInfo()
	local v72 = Localize(tostring(module5.GetStoreItemTag(currInfo.StoreItem)), {})
	v71 = SF.PurchaseParams()
	v71.mStoreItem = currInfo.StoreItem
	local price = _T.GiftParams.Price

	if _T.GiftParams.CouponId ~= nil then
		price = _T.GiftParams.CouponPrice
	end

	if _T.GiftParams.Durability == 0 then
		if _T.GiftParams.BoosterIsTimed then
			v72 = Localize("/Lotus/Language/Menu/Global_3Days", {}) .. " " .. v72
		else
			local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(0)
			v72 ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
				NUM_USES = __wf_atom_5df94bc3
			}) .. ")"
		end
	elseif _T.GiftParams.Durability == 1 then
		if _T.GiftParams.BoosterIsTimed then
			v72 = Localize("/Lotus/Language/Menu/Global_7Days", {}) .. " " .. v72
		else
			local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(1)
			v72 ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
				NUM_USES = __wf_atom_5df94bc3
			}) .. ")"
		end
	end

	if _T.GiftParams.Durability == nil then
		v71.mDurability = 3 + 1
	else
		v71.mDurability = _T.GiftParams.Durability
	end

	local ternary = module2.Ternary(_T.GiftParams.CouponId ~= nil, 1, v30)
	local v73, quantity = fn19(currInfo.StoreItem, ternary)
	local v75, v76

	if quantity > 1 then
		v75 = {
			GIFT_TYPE = v72,
			QUANTITY = quantity,
			PRICE = price,
			RECIPIENT = _T.GiftParams.Recipient,
			TOTAL = ternary * price
		}

		if v73 > 0 then
			v75.QUANTITY_BOUGHT = ternary
			v75.QUANTITY_FREE = v73
			v76 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftConfirmBogoPurchase", true, v75)
		else
			v76 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftConfirmMultiPurchase", true, v75)
		end

		if _T.GiftParams.Message ~= "" then
			v76 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftConfirmMultiPurchaseMessage", true, {
				MESSAGE = _T.GiftParams.Message
			})
		end
	elseif _T.GiftParams.Message == "" then
		v75 = { GIFT_TYPE = v72, RECIPIENT = _T.GiftParams.Recipient, PRICE = price }
		v76 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftConfirmNoMessage", true, v75)
	else
		v75 = {
			GIFT_TYPE = v72,
			RECIPIENT = _T.GiftParams.Recipient,
			PRICE = price,
			MESSAGE = _T.GiftParams.Message
		}
		v76 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftConfirmWithMessage", true, v75)
	end

	v71.mSource = _T.GiftParams.Source
	v71.mExpectedPrice = v75.PRICE * ternary
	v71.mQuantity = ternary

	if _T.GiftParams.CouponId ~= nil then
		v71.mCouponId.mId = _T.GiftParams.CouponId
	end

	v71.mUsePremium = true
	module2.ShowConfirmMessage(v76, "OnGiftConfirmed")
end

local function fn29(p)
	local message = __wf_atom_f8f86fc5(p, 0)
	_T.GiftParams.Message = message
	_T.GiftParams.Source = module2.Ternary(v66.IsDailyDeal, 3, 0)
	_T.GiftParams.Durability = nil
	fn28()
end

function OSKOnGiftMessage(p, p2)
	if not p then
		fn29(p2)
	end
end

function OnGiftMessage(p, _, p2)
	if not __wf_atom_7e8ad928(p2) and tonumber(p2) == 4 then
		fn29(p)
	end
end

local function fn30()
	local v72, _ = module3.ShowInputDialog(
		mMovie,
		"/Lotus/Language/Menu/GiftEnterMessage",
		"",
		256,
		"OnGiftMessage",
		"OSKOnGiftMessage"
	)
	return v72
end

function OnCanSendMessageToCallback(p, _)
	if p then
		v27 = true
	else
		fn29("")
	end
end

function OnConfirmGiftRecipientName(p)
	if tonumber(p) == 4 then
		v27 = true
	end
end

local function fn31(recipient)
	if recipient == nil and recipient == "" then
		module2.ShowMessage("/Lotus/Language/Menu/GiftNeedName")
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if
		not (__wf_atom_18a5d83b:__wf_atom_7f395d54() and __wf_atom_18a5d83b:__wf_atom_68c57190())
		and Engine.__wf_atom_746f9d1b(string.lower(recipient)) == string.lower(__wf_atom_18a5d83b:__wf_atom_6be84646(true))
	then
		module2.ShowMessage("/Lotus/Language/Store/GiftFail_SendToSelf")
		return
	end

	_T.GiftParams.Recipient = recipient

	if Engine.__wf_atom_84bb79c2() then
		__wf_atom_18a5d83b:__wf_atom_743c4c3b(recipient, "OnCanSendMessageToCallback")
	elseif Engine.__wf_atom_5f0554d9() then
		module2.ShowConfirmMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ConfirmRecipientName", true, {
				RECIPIENT = _T.GiftParams.Recipient
			}),
			"OnConfirmGiftRecipientName"
		)
	else
		v27 = true
	end
end

function OnGiftRecipient(recipient)
	fn31(recipient)
end

fn5 = function()
	if _T.GiftParams.Price == nil or __wf_atom_7e8ad928(gameData) then
		return
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		module2.ShowErrorMessage("/Lotus/Language/Menu/DetailedPurchase_NewBuild")
		return
	end

	local currInfo = class:GetCurrInfo()
	local showCoupon = currInfo.ShowCoupon
	local price = _T.GiftParams.Price

	if showCoupon then
		price = math.floor(price * (1 - currInfo.Coupon.mAmount))
	end

	local __wf_atom_f9580127 = gameData:__wf_atom_f9580127()

	if __wf_atom_f9580127 < price then
		local v72 = price - __wf_atom_f9580127
		local itemName = currInfo.ItemName
		local v73 = {
			"Platinum",
			tostring(__wf_atom_f9580127 < gameData:__wf_atom_330e9cb9()),
			itemName,
			"GIFTING",
			v72
		}
		_T.BackgroundMovie:__wf_atom_f62a8704("ShowInsufficientFundsPopup", v73)
	elseif gameData:__wf_atom_c94fda56() <= 0 then
		local __wf_atom_4438d3ad = gameData:__wf_atom_4438d3ad()
		module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftFail_NoGiftsRemaining", true, {
			NUM_GIFTS = __wf_atom_4438d3ad
		}))
	elseif
		module9.GetWorldStateOverride("PurchasePlatformLockEnabled", false)
		and not v32
		and currInfo.StoreItem:__wf_atom_955f7fe0()
		and fn12(currInfo.StoreItem)
	then
		if Engine.__wf_atom_fc67ba71() then
			module2.ShowConfirmMessage(
				"/Lotus/Language/Store/PurchaseConsoleLocked",
				"OnPurchasePlatformLockedGiftConfirmed"
			)
		else
			module2.ShowConfirmMessage(
				"/Lotus/Language/Store/PurchasePCLocked",
				"OnPurchasePlatformLockedGiftConfirmed"
			)
		end
	else
		if showCoupon then
			_T.GiftParams.CouponId = currInfo.Coupon.mId
		else
			_T.GiftParams.CouponId = nil
		end

		if __wf_atom_7e8ad928(v5) and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.SetShowOfflinePlayers = true
			v5 = _T.OpenScreen("InvitePanel")

			if not __wf_atom_7e8ad928(v5) then
				v5:Execute("SetButtonDesc", "/Lotus/Language/Menu/Item_GiftToPlayerShort")
				v5:Execute("SetDefaultName", _T.GiftParams.Recipient)

				function _T.OnNameEnteredCallback(p)
					mMovie:Execute("OnGiftRecipient", p)
				end

				v5:Execute("SetCallback", "OnNameEnteredCallback")
			end
		end
	end
end

function OnGiftItem()
	fn5()
end

function GiftConsoleCheck()
	local currInfo = class:GetCurrInfo()

	if
		__wf_atom_7e8ad928(class)
		or __wf_atom_7e8ad928(currInfo)
		or not class.CanGiftItem(currInfo, currInfo.StoreItem)
	then
		return
	end

	fn5()
end

local function fn32(storeItem)
	if not __wf_atom_7e8ad928(storeItem:GetItem()) and storeItem:GetItem():IsA(__wf_atom_3cecff09) then
		storeItem = storeItem:__wf_atom_e622b3f6()

		if __wf_atom_7e8ad928(storeItem) then
			return nil, nil
		end
	end

	local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()
	local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(__wf_atom_efa6f447)

	if __wf_atom_7e8ad928(gameData) or not (__wf_atom_8c8df26f < 6) then
		return nil, nil
	end

	local free = math.max(0, inventory:__wf_atom_9ed9a33c(__wf_atom_8c8df26f))
	local v73

	if free == 1 then
		v73 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlot", true)
	else
		v73 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlots", true, {
			free = free
		})
	end

	return v73, free
end

local function fn33(p)
	if #v8 == 50 then
		table.remove(v8, 1)
	end

	table.insert(v8, v9)
	class:Hide()
	_T.marketDetailedViewParms = { ITEM = p, CALLBACK = callback }
	_T.marketDetailedViewParms.HIDE_PARENT = v9.HIDE_PARENT
	_T.marketDetailedViewParms.HIDE_ITEM_GRID = v9.HIDE_ITEM_GRID
	_T.marketDetailedViewParms.HIDE_RELATED = v9.HIDE_RELATED
	_T.marketDetailedViewParms.FORCE_GENERIC_DIO = v9.FORCE_GENERIC_DIO
	_T.marketDetailedViewParms.ITEM.AllowMuseum = v9.ITEM.AllowMuseum
	fn15()
end

local function fn34()
	local module17 = require("Lotus.Interface.Components.AbilityList")
	v57 = module17.Create(mMovie, "DetailedView.AbilityList")
	v57.mForcedHorizontalSeparation = 84
	v57.mIconDim = 70
	v57.mInitIconYPos = -25
	v57.mIconFocusOffset = 10
	v57.mGlowWidth = 300
	v57.mShowPassive = true
	v57.mShowRank = false
	v57.mSparkleMaterial = panelAbilitySparkleVisRangeMaterial
end

local function fn35()
	local module17 = require("EE.Interface.Components.List")
	v58 = module17.CreateList(mMovie, "DetailedView.BelowDescription.CrewMemberSkills.Skill", 10)
	v58:SetCallbacks(nil, "CrewSkillFocused", "CrewSkillUnfocused")
	v58.mForcedHorizontalSeparation = 0
	v58.mForcedVerticalSeparation = 60

	function v58.UpdateColors(p)
		mMovie:__wf_atom_4c1c1986(p, "Label", 44, v67.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p, "Icon", 11, v67.FloatingContent)
	end

	function v58.mClipCreatedCallback(p, _)
		v58.UpdateColors(p)
	end

	function v58.mOnFocusedCallback(p)
		local v72 = Localize("/Lotus/Language/Railjack/CrewSkill" .. tostring(p.Skill) .. "Desc", {
			VALUE = p.mSkillValues
		})
		_T.gToolTip = string.gsub(v72, "%s*$", "")
	end

	function v58.mOnUnfocusedCallback(_)
		_T.gToolTip = nil
	end

	function v58:mElementDrawCallback()
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)
		mMovie:__wf_atom_7d7314f1(
			self.mClipName .. ".Label.text",
			"/Lotus/Language/Railjack/CrewSkill" .. tostring(self.Skill)
		)

		if self.mPipList == nil then
			self.mPipList = module17.CreateList(mMovie, self.mClipName .. ".RankPip", 5)
			self.mPipList.mForcedHorizontalSeparation = 28
			self.mPipList.mForcedVerticalSeparation = 0

			function self.mPipList.UpdateColors(p)
				mMovie:__wf_atom_4c1c1986(p, "Bg", 11, v67.FloatingContent)
				mMovie:__wf_atom_4c1c1986(p, "Fill", 11, v67.FloatingContentHighlight)
			end

			function self.mPipList.mClipCreatedCallback(p, _)
				self.mPipList.UpdateColors(p)
			end

			function self.mPipList.mElementDrawCallback(p)
				mMovie:__wf_atom_7f57ab2f(p.mClipName, "Fill", 13, p.Id <= self.Rank)
			end

			for _ = 1, 5 do
				self.mPipList:AddElement({}, true)
			end
		end

		self.mPipList:Redraw(nil, true, true)
	end

	for i = 0, 5 - 1 do
		v58:AddElement({
			Skill = i,
			Icon = crewSkillIcons[i + 1],
			Rank = 0
		}, true)
	end

	v58:Redraw(nil, true, true)
	local v72 = gRegion:IsMaster() and 3 or 4
	v59 = gRegion:CreateObject(v24, nil, v72)

	if not __wf_atom_7e8ad928(v59) then
		v59:Setup(
			mMovie,
			nil,
			250,
			"DetailedView.BelowDescription.CrewMemberSkills.HealthInfo",
			"DetailedView.BelowDescription.CrewMemberSkills.HealthLabel"
		)
		v59:__wf_atom_fe491b37(150)
		v59:__wf_atom_754076b1(150)
		v59:__wf_atom_d6c7a102(100)
		v59:__wf_atom_9abf42e7(100)
		v59:Initialize()
		v59:Update(__wf_atom_084b3e93())
	end

	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.CrewMemberSkills.TraitInfo", 13, false)
	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.CrewMemberSkills.HealthInfo", 13, false)
	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.CrewMemberSkills.HealthLabel", 13, false)
end

local function fn36()
	local module17 = require("Lotus.Interface.Components.ThemedStats")
	v63 = module17.Create(mMovie, "DetailedView.Scrollable.Stats")
	v63:ShowStatTips()
	v63.RectangleMaterial = panelBgVisRangeMaterial
	v63.TextMaterial = panelTextVisRangeMaterial
	v63.mGrowDownward = true
	v63:SetWidth(435)
	v63.mTDPD_Redraw = v63.Redraw

	function v63:Redraw()
		self:mTDPD_Redraw()
		class:AdjustStatsMask()
	end
end

local function fn37(p, p2, p3)
	local v72 = p3 == nil and "" or p3 .. " "
	local module17 = require("EE.Interface.Components.List")
	local list = module17.CreateList(mMovie, p .. ".Element", 3)
	list.mForcedHorizontalSeparation = 0
	list.mForcedVerticalSeparation = 38
	list.mButtonWidth = 444
	list:AttachScrollBar(p .. ".ScrollBar", -6)

	function list:UpdateInitialY()
		self.mInitialY = mMovie:__wf_atom_5e6e15c8(p .. ".Title", 41) + 30
	end

	function list:mElementDrawCallback()
		local module18 = require("Lotus.Interface.Components.ThemedButton")
		local ternary = module2.Ternary(
			self.LocTag == nil,
			module5.GetStoreItemTag(self.StoreItem):c_str(),
			self.LocTag
		)
		local v73 = v72 .. mMovie:__wf_atom_8e9ac384(ternary, false)
		self.Button = module18.Create(mMovie, self.mClipName .. ".Button", v73, nil, nil, false)
		self.Button.mPostText = "..."

		function self.Button.mOnPressedCallback(_)
			fn7(self.StoreItem)
		end

		function self.Button.mOnFocusedCallback(p4)
			module6.SetItemInfoPopupRect(
				mMovie,
				self.Info,
				mMovie:__wf_atom_5e6e15c8(p4.mClipName, 2) + p4.mMaxSize / 2,
				mMovie:__wf_atom_5e6e15c8(p4.mClipName, 3) + 17,
				p4.mMaxSize,
				34
			)
			_T.InfoPopup_Data = self.Info
			_T.InfoPopup_Grid = nil
		end

		function self.Button.mOnUnfocusedCallback(_)
			_T.InfoPopup_Data = nil
		end

		self.Button:SetTextAlignment("left")
		self.Button.mTextBuffer = 7
		self.Button:SetWidth(list.mButtonWidth)
	end

	mMovie:__wf_atom_7d7314f1(p .. ".Title.text", p2)
	list:UpdateInitialY()
	return list
end

local function fn38(instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_311a7128) then
		return nil
	end

	if instance:IsA(__wf_atom_8cea5ccc) then
		return instance:__wf_atom_ce45c548()
	end

	if not instance:IsPackage() then
		return nil
	end

	local __wf_atom_72915748 = instance:__wf_atom_72915748()

	for _, v72 in ipairs(__wf_atom_72915748) do
		local v73 = fn38(v72.mTypeName)

		if not __wf_atom_7e8ad928(v73) then
			return v73
		end
	end

	return nil
end

local function fn39()
	local module17 = require("Lotus.Interface.Components.CategorizedGrid")
	v54 = module17.CreateCategorizedGrid(mMovie, "ItemGrid.Item", 2, 4)
	v54:SetCallbacks("ItemPressed", "ItemFocused", "ItemUnfocused")
	v54.Mode = { PACKAGE = 1, RELATED = 2 }
	v54.mSelectElementsOnFocus = false
	v54.mSelectedScale = 100
	v54.ElementWidth = 200
	v54.ElementHeight = 200
	v54.ElementDimBuffer = 10
	v54.Width = 410
	v54.HeightPadding = 250
	v54.mLowerBoundBuffer = 2
	v54.mUpperBoundBuffer = 2
	local _, v72 = module2.GetScreenDimensions(mMovie)
	v54.Height = v72 - v54.HeightPadding
	v54.mInnerAlphaOffset = 20
	v54.mIgnoreInnerOffsetForFiller = true
	module6.InitializeGridItem(mMovie, v54)
	v54:AttachScrollBar("ItemGrid.ScrollBar", -25)
	mMovie:__wf_atom_e57658c2("ItemGrid.ScrollBar", 15, v54.Height)
	v54:EnableSmoothScroll()
	v54.mScrollBarHorizontalOffset = 110
	v54.mScrollAlwaysVisible = true
	v54.VisibleRangeMaterial = relatedItemVisRangeMaterial
	v54.TextVisibleRangeMaterial = relatedItemTextVisRangeMaterial
	v54.RectangleVisibleRangeMaterial = relatedItemBgMaterial
	v54.PurchasedItems = v13

	function v54.mClipCreatedCallback(p, _)
		module6.OnGridItemCreated(mMovie, v54, p)
	end

	v55 = mMovie:__wf_atom_5e6e15c8("ItemGrid", 1)

	function v54:SetCategory(p)
		local _, v73 = module2.GetScreenDimensions(mMovie)
		local allowMuseum = not (class.mInMuseum or __wf_atom_7e8ad928(fn38(v54.BaseStoreItem)))
			and (v9.ITEM.AllowMuseum or v9.ITEM.CodexMode)
		local bundleTag, hasPackage

		if p == self.Mode.PACKAGE then
			v26:ChangeAnchorPoints("ItemGrid", v26.ANCHOR_V_TOP, nil)
			v26:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
			bundleTag = class:GetCurrInfo().BundleTag or "/Lotus/Language/Menu/DetailedPurchase_BundleIncludes"
			hasPackage = self.HasPackage
			v54.HeightPadding = 250

			if allowMuseum then
				v54.HeightPadding = 320
			end

			v54.Height = v73 - v54.HeightPadding
			mMovie:__wf_atom_e57658c2("ItemGrid", 1, v55)
			self:SetCategory_Internal(self.Mode.PACKAGE)
		else
			v26:ChangeAnchorPoints("ItemGrid", module2.Ternary(flag3, v26.ANCHOR_V_BOTTOM, v26.ANCHOR_V_TOP), nil)
			v26:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
			bundleTag = "/Lotus/Language/Store/DetailedPurchase_RelatedItems"
			hasPackage = true
			self:SetCategory_Internal(self.Mode.RELATED)

			if flag3 then
				v54.Height = v54.ElementHeight
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("MuseumBtn", 15)
				mMovie:__wf_atom_e57658c2(
					"ItemGrid",
					1,
					mMovie:__wf_atom_5e6e15c8("MuseumBtn", 1) - v54.ElementHeight - 20 + (allowMuseum and 0 or __wf_atom_5e6e15c8)
				)
				mMovie:__wf_atom_2dedec1a("ItemGrid.ScrollBar", 13, false)
				mMovie:__wf_atom_e57658c2("ItemGrid.ScrollBar", 12, 0)
			else
				v54.HeightPadding = 250

				if allowMuseum then
					v54.HeightPadding = 320
				end

				v54.Height = v73 - v54.HeightPadding
				mMovie:__wf_atom_e57658c2("ItemGrid", 1, v55)
				mMovie:__wf_atom_e57658c2("ItemGrid.ScrollBar", 15, v54.Height)
				mMovie:__wf_atom_2dedec1a("ItemGrid.ScrollBar", 13, true)
				mMovie:__wf_atom_e57658c2("ItemGrid.ScrollBar", 12, 100)
			end
		end

		v54:UpdateVisRanges()
		v54.mVisible = hasPackage
		mMovie:__wf_atom_2dedec1a("ItemGrid", 13, hasPackage)
		mMovie:__wf_atom_50d60589("ItemGrid.Title", 36, string.upper(mMovie:__wf_atom_8e9ac384(bundleTag, true)))
		local v74 = bundleTag ~= ""
		mMovie:__wf_atom_2dedec1a("ItemGrid.TitleBg", 13, v74)

		if v74 then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ItemGrid.Title", 40)
			mMovie:__wf_atom_e57658c2("ItemGrid.TitleBg", 14, __wf_atom_5e6e15c8 + 5)
		end
	end

	function v54.mOnSelectedCallback(p)
		if v54.mFilterBy == v54.Mode.RELATED then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(
				Symbol("ITEM_VIEWED_MARKET_RELATED"),
				p.StoreItem:__wf_atom_5b41f63b()
			)
		end

		fn33(p)
	end

	function v54.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		local isSelected = v54.mSelectedElement ~= nil and p.Id == v54.mSelectedElement.Id
		module6.OnGridItemFocusChanged(mMovie, v54, p, {
			IsSelected = isSelected,
			IsFocused = true,
			ShowInfoPopup = true
		})
	end

	function v54.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		local isSelected = v54.mSelectedElement ~= nil and p.Id == v54.mSelectedElement.Id
		module6.OnGridItemFocusChanged(mMovie, v54, p, {
			IsSelected = isSelected,
			IsFocused = false
		})
	end

	v54.mHasShownItem = {}

	function v54.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		if flag3 and data.Id > 2 then
			mMovie:__wf_atom_2dedec1a(data.mClipName, 13, false)
		else
			mMovie:__wf_atom_2dedec1a(data.mClipName, 13, true)
		end

		local v73 = {
			HideOwned = v9.VENDOR_MODE or not data.RelatedItem,
			ShowCheckmark = data.Count ~= nil and data.Count > 0,
			HideCountThreshold = 0,
			IgnoreCount = data.Filler,
			ShowPurchaseQuantity = true,
			ShowDiscountOnGrid = v3.ShowDiscountOnGrid
		}

		if
			not __wf_atom_7e8ad928(data.StoreItem)
			and not __wf_atom_7e8ad928(__wf_atom_21342f4a)
			and v54.mFilterBy == v54.Mode.RELATED
		then
			local __wf_atom_5b41f63b = data.StoreItem:__wf_atom_5b41f63b()

			if v54.mHasShownItem[__wf_atom_5b41f63b] == nil then
				__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("ITEM_SHOWN_IN_MARKET_RELATED"), __wf_atom_5b41f63b)
				v54.mHasShownItem[__wf_atom_5b41f63b] = true
			end
		end

		module6.DrawGridItem(mMovie, v54, data, v73)
	end

	function v54:UpdateVisRanges(_)
		local v73 = { relatedItemBgMaterial, relatedItemVisRangeMaterial, relatedItemTextVisRangeMaterial }

		for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
			for _, v74 in pairs(uiMaterial_Mod) do
				table.insert(v73, v74)
			end
		end

		for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
			for _, v74 in pairs(uiMaterial_ModsSyndicateIcon) do
				table.insert(v73, v74)
			end
		end

		for _, v74 in pairs(_G.UIMaterial_RailjackModStore) do
			table.insert(v73, v74)
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ItemGrid", 1)
		local height = v54.Height
		local visibilityCenter = module2.GetVisibilityCenter(
			mMovie,
			__wf_atom_5e6e15c8 + (v54.mInitialY - v54.ElementHeight / 2) + height / 2
		)
		local visibilitySize = module2.GetVisibilitySize(mMovie, height)
		local visibilityFadeSize = module2.GetVisibilityFadeSize(mMovie, 10)

		for _, v74 in ipairs(v73) do
			v74:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			v74:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			v74:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
		end
	end

	v54:AddCategory({ Name = "", Category = v54.Mode.PACKAGE })
	v54:AddCategory({ Name = "", Category = v54.Mode.RELATED })
	mMovie:OverrideMaterial("ItemGrid.TitleBg", textBackerMaterial)
end

local function fn40(object, p)
	if __wf_atom_7e8ad928(object) or p[object:__wf_atom_5b41f63b()] then
		return false
	end

	local storeItemInfo = module5.GetStoreItemInfo(
		mMovie,
		object,
		{ GameData = gameData, GetVisibilityMaterial = true },
		nil,
		nil,
		true
	)

	if
		__wf_atom_7e8ad928(storeItemInfo)
		or __wf_atom_7e8ad928((module5.__wf_atom_997c5995(mMovie, object, v16, inventory, v13, gameData, 0)))
	then
		return false
	end

	local saleInfo = module3.GetSaleInfo(storeItemInfo.StoreItem)
	local v72 = not __wf_atom_7e8ad928(saleInfo) and saleInfo.mShowInMarket and not saleInfo.mHideFromMarket

	if not (__wf_atom_7e8ad928(saleInfo) and storeItemInfo.StoreItem:ShowInMarket() or v72) then
		return false
	end

	storeItemInfo.Count = module3.GetNumOwned(gameData, inventory, object, v13)
	storeItemInfo.IsExternalProduct = module3.IsExternalProduct(object)
	storeItemInfo.Sale = saleInfo
	storeItemInfo.Categories = { v54.Mode.RELATED }
	storeItemInfo.ShowInfoPopupOwned = true
	storeItemInfo.RelatedItem = true
	p[object:__wf_atom_5b41f63b()] = true
	v54:AddElement(storeItemInfo, true)
	v54.HasRelated = true
	return true
end

local function fn41(storeItem)
	local package = v54.Mode.PACKAGE
	local item = storeItem:GetItem()
	v54.BaseStoreItem = storeItem
	v54:RemoveElements(true, true)
	v54.HasPackage = false

	if storeItem:IsPackage() then
		local __wf_atom_72915748 = storeItem:__wf_atom_72915748()

		if #__wf_atom_72915748 > 1 then
			for i = 1, #__wf_atom_72915748 do
				local v72 = __wf_atom_72915748[i]

				if __wf_atom_7e8ad928(v72.mTypeName) then
					continue
				end

				local storeItemInfo = module5.GetStoreItemInfo(
					mMovie,
					v72.mTypeName,
					{ GetVisibilityMaterial = true, ItemGrid = true },
					nil,
					nil,
					true
				)
				storeItemInfo.Count = module3.GetNumOwned(gameData, inventory, v72.mTypeName, v13)
				storeItemInfo.Categories = { v54.Mode.PACKAGE }
				storeItemInfo.ShowInfoPopupOwned = true

				if
					not __wf_atom_7e8ad928(v72.mPurchaseQuantity)
					and v72.mPurchaseQuantity ~= storeItemInfo.StoreItem:__wf_atom_17d97bf6()
				then
					storeItemInfo.BundleQuantity = v72.mPurchaseQuantity
				end

				if v72.mTypeName:__wf_atom_efa6f447() == 8 and not v72.mTypeName:IsPackage() then
					local v73

					if v72.mDurability == 0 then
						v73 = "/Lotus/Language/Menu/Global_3Days"
					elseif v72.mDurability == 1 then
						v73 = "/Lotus/Language/Menu/Global_7Days"
					elseif v72.mDurability == 2 then
						v73 = "/Lotus/Language/Menu/Global_30Days"
					else
						v73 = nil
					end

					if v73 ~= nil then
						storeItemInfo.Name ..= " (" .. mMovie:__wf_atom_8e9ac384(v73, false) .. ")"
					end
				end

				v54:AddElement(storeItemInfo, true)
				v54.HasPackage = true
			end
		end
	end

	v54.HasRelated = false
	local v72 = WeakResource("/Lotus/Types/BoosterPacks/RivenModPack")
	local v73 = not __wf_atom_7e8ad928(item) and item:IsA(v72)

	if isDailyDeal or not (storeItem:ShowInMarket() or v73) then
		return package
	end

	local v74 = {}
	local v75

	if __wf_atom_7e8ad928(v6) then
		v75 = {}
	else
		v75 = v6:__wf_atom_75e845e9(storeItem)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if
			not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
			and __wf_atom_18a5d83b:__wf_atom_01fbbcf8("related_items_priority")
		then
			local v76 = module5.PRODUCT_CATEGORY_NAMES[storeItem:__wf_atom_efa6f447()]

			if not __wf_atom_7e8ad928(v76) and __wf_atom_7e8ad928(v25[v76]) then
				v25[v76] = Resource("/Lotus/Types/Game/RelatedItems/" .. v76)
			end

			if not (__wf_atom_7e8ad928(v76) or __wf_atom_7e8ad928(v25[v76])) then
				local __wf_atom_7e97ff70 = v25[v76]:__wf_atom_7e97ff70(storeItem)

				for i = 1, #__wf_atom_7e97ff70 do
					table.insert(v74, __wf_atom_7e97ff70[i])
				end
			end

			v74 = module2.ShuffleTable(v74)
		end
	end

	local v76 = 4
	local v77 = #v74 < v76 and #v74 or v76
	local count = 0
	local v78 = {}

	for i = 1, v77 do
		if count >= 8 then
			break
		end

		if fn40(v74[i], v78) then
			count += 1
		end
	end

	for i = 1, #v75 do
		if count >= 8 then
			break
		end

		if fn40(v75[i], v78) then
			count += 1
		end
	end

	flag3 = false

	if v54.HasRelated and v73 then
		return v54.Mode.RELATED
	end

	if v54.HasPackage then
		return package
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if
		not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
		and v77 > 0
		and __wf_atom_18a5d83b:__wf_atom_01fbbcf8("related_items_preview")
	then
		flag3 = true
		package = v54.Mode.RELATED
	end

	return package
end

local function fn42()
	local module17 = require("Lotus.Interface.Components.ThemedCustomizationList")
	v53 = module17.Create(mMovie, "DetailedView.BelowDescription.Options")
	v53.DiscountIcons = discountIcons
	v53.CustomizationList.mElementHeight = 55
	v53.CustomizationList.mForcedVerticalSeparation = 60
	v53.CustomizationList.mShowInfoPopup = true
	v53.CustomizationList.PurchasedItems = v13

	function v53.CustomizationList.OnShowPopup(_, data, p)
		if p.CustomEntry then
			return
		end

		if data.HelpText == nil then
			if data.IngredientOverride == nil then
				p.LocalizedDesc = nil
			else
				p.LocalizedDesc = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_Include", false)
				p.IngredientOverride = data.IngredientOverride
			end
		else
			p.LocalizedDesc = data.HelpText
		end

		if data.IsBlueprint then
			p.HideAbilities = true
			p.HideStats = true
		else
			p.Name = v10.ITEM.ItemName
			p.ItemPrices = v10.ITEM.ItemPrices
		end

		if data.FreeSlots ~= nil then
			p.EmptyCount = data.FreeSlots
			p.BuySlot = true
		end

		p.Description = nil
	end

	local module18 = require("Lotus.Interface.Components.ThemedButton")
	v64.GiftBtn = module18.Create(mMovie, "DetailedView.BelowDescription.GiftBtn", "<GIFT_BUTTON>", "OnGiftPressed")
	v64.GiftBtn.mShowUnderline2 = false
	v64.GiftBtn.mUnfocusedEdgeColor = 1
	v64.GiftBtn.mFocusedEdgeAlpha = 30
	v64.GiftBtn.mLabelYOffset = -2
	v64.GiftBtn.mHeight = 55

	function v64.GiftBtn.mOnFocusedCallback(data)
		if not v10.ITEM or __wf_atom_7e8ad928(v10.ITEM.StoreItem) then
			return
		end

		local storeItem = v10.ITEM.StoreItem
		local v72

		if not __wf_atom_7e8ad928(v16) then
			v72 = v16:__wf_atom_51fc44cc(storeItem)
		end

		if not __wf_atom_7e8ad928(v72) then
			local infoPopup_Data = {
				CustomEntry = true,
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftBonusTitle", false),
				LocalizedDesc = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftBonusInclude", false)
			}
			local infoForLabels = {}
			local infoForLabel = module6.GetInfoForLabel(
				module6.LABEL_TYPE_UNIQUE_TEXT,
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/GiftBonusDesc", false)
			)
			infoForLabel.SkipTitleCase = true
			infoForLabel.MultiLine = true
			table.insert(infoForLabels, infoForLabel)
			infoPopup_Data.MetaData = { CustomTags = infoForLabels }
			infoPopup_Data.IngredientOverride = {}
			table.insert(infoPopup_Data.IngredientOverride, fn8(v72))
			module6.SetItemInfoPopupRect(
				mMovie,
				infoPopup_Data,
				mMovie:__wf_atom_5e6e15c8(data.mClipName, 2) + data.mMaxSize / 2,
				mMovie:__wf_atom_5e6e15c8(data.mClipName, 3) + data.mHeight / 2,
				data.mMaxSize,
				data.mHeight
			)
			_T.InfoPopup_Data = infoPopup_Data
			_T.InfoPopup_Grid = nil
		end
	end

	function v64.GiftBtn.mOnUnfocusedCallback(_)
		_T.InfoPopup_Data = nil
	end

	v64.GiftBtn:SetWidth(65)
	v64.GiftBtn:Redraw()
	mMovie:__wf_atom_7d7314f1("DetailedView.BelowDescription.GiftBonusLabel.text", "/Lotus/Language/Menu/BonusBounty")
end

local function fn43()
	if __wf_atom_7e8ad928(class) or __wf_atom_7e8ad928(class.SelectedElement) then
		return
	end

	local priceTagLong = class:GetPriceTagLong(class.SelectedElement, v30)
	local v72 = class.SelectedElement.SalePriceInfo.Price ~= nil
		and class.SelectedElement.HasRegularPrice
		and (__wf_atom_7e8ad928(class.SelectedElement.Coupon) or __wf_atom_7e8ad928(class.SelectedElement.Coupon.mCouponType) or class.SelectedElement.Coupon.mCouponType == 0)
	local v73 = not class.SelectedElement.ConsoleSale and v72
	mMovie:__wf_atom_7f57ab2f("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "StrikeThrough", 13, v73)
	mMovie:__wf_atom_7f57ab2f("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Separator", 13, v73)
	mMovie:__wf_atom_7f57ab2f("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Discount", 13, v73)

	if v73 then
		local v74 = class.SelectedElement.RegularPriceInfo.CurrencyText .. module2.FormatNumber(class.SelectedElement.RegularPriceInfo.Price * v30)

		if
			class.SelectedElement.IsExternalProduct
			and not __wf_atom_7e8ad928(class.SelectedElement.RegularPriceInfo)
		then
			v74 = class.SelectedElement.RegularPriceInfo.CurrencyText .. class.SelectedElement.RegularPriceInfo.PriceText
		end

		mMovie:__wf_atom_48bd5a59("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Label", 36, v74)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm.Label",
			40
		)
		mMovie:__wf_atom_48bd5a59("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Label", 36, priceTagLong)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"Label",
			1
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"StrikeThrough",
			14,
			__wf_atom_5e6e15c8 + 6
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"StrikeThrough",
			1,
			__wf_atom_cfc41e35 + 33
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"Separator",
			1,
			__wf_atom_cfc41e35 + 21
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"Discount",
			1,
			__wf_atom_cfc41e35 + 23
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"Separator",
			0,
			__wf_atom_5e6e15c8 + 7
		)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView.BelowDescription.PurchaseConfirm.Confirm",
			"Discount",
			0,
			__wf_atom_5e6e15c8 + 22
		)
		local v75 = class.SelectedElement.RegularPriceInfo.CurrencyText .. module2.FormatNumber(class.SelectedElement.SalePriceInfo.Price * v30)

		if class.SelectedElement.IsExternalProduct and not __wf_atom_7e8ad928(class.SelectedElement.SalePriceInfo) then
			v75 = class.SelectedElement.RegularPriceInfo.CurrencyText .. class.SelectedElement.SalePriceInfo.PriceText
		end

		mMovie:__wf_atom_48bd5a59("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Discount", 36, v75)
	else
		mMovie:__wf_atom_48bd5a59("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "Label", 36, priceTagLong)
	end

	local v74 = mMovie:__wf_atom_5e6e15c8("DetailedView.BelowDescription.PurchaseConfirm.Confirm.Label", 41) + 10
	mMovie:__wf_atom_4c1c1986("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "PurchaseBtn", 1, v74)
	mMovie:__wf_atom_4c1c1986("DetailedView.BelowDescription.PurchaseConfirm.Confirm", "CancelBtn", 1, v74)
end

local function fn44(currInfo)
	local v72

	if currInfo.ParentBundles == nil then
		v72 = false
	else
		v72 = #currInfo.ParentBundles > 0
	end

	if v72 then
		for i = 1, #currInfo.ParentBundles do
			if currInfo.ParentBundles[i]:__wf_atom_12c87335() then
				return true
			end
		end
	end

	return false
end

local function fn45(currInfo)
	return currInfo.Compatibles ~= nil and #currInfo.Compatibles > 0
end

fn6 = function(p, p2)
	base = p
	local v72 = base == v7.BASE
	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.Options", 67, v72)
	__wf_atom_ec43d06e(
		mMovie,
		"DetailedView.BelowDescription.Options",
		2,
		{ 12 },
		{ module2.Ternary(v72, 100, 0) },
		module2.Ternary(v72, 0.2, 0.1),
		module2.Ternary(v72, 0.05, 0)
	)

	if v64.GiftBtn ~= nil then
		v64.GiftBtn:SetActive(v72)
		__wf_atom_ec43d06e(
			mMovie,
			v64.GiftBtn.mClipName,
			2,
			{ 12 },
			{ module2.Ternary(v72, 100, 0) },
			module2.Ternary(v72, 0.2, 0.1),
			module2.Ternary(v72, 0.05, 0)
		)
		__wf_atom_ec43d06e(
			mMovie,
			"DetailedView.BelowDescription.GiftBonusLabel",
			2,
			{ 12 },
			{ module2.Ternary(v72, 100, 0) },
			module2.Ternary(v72, 0.2, 0.1),
			module2.Ternary(v72, 0.05, 0)
		)
	end

	local currInfo

	if not __wf_atom_7e8ad928(class.GetCurrInfo) then
		currInfo = class:GetCurrInfo()
		local v73 = v72 and fn44(currInfo)
		local v74 = v72 and fn45(currInfo)
		mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.ParentBundles", 67, v73)
		__wf_atom_ec43d06e(
			mMovie,
			"DetailedView.BelowDescription.ParentBundles",
			2,
			{ 12 },
			{ module2.Ternary(v73, 100, 0) },
			module2.Ternary(v73, 0.2, 0.1),
			module2.Ternary(v73, 0.05, 0)
		)
		mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.Compatible", 67, v74)
		__wf_atom_ec43d06e(
			mMovie,
			"DetailedView.BelowDescription.Compatible",
			2,
			{ 12 },
			{ module2.Ternary(v74, 100, 0) },
			module2.Ternary(v74, 0.2, 0.1),
			module2.Ternary(v74, 0.05, 0)
		)
	end

	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.PurchaseConfirm", 67, not v72)
	__wf_atom_ec43d06e(
		mMovie,
		"DetailedView.BelowDescription.PurchaseConfirm",
		2,
		{ 12 },
		{ module2.Ternary(v72, 0, 100) },
		module2.Ternary(v72, 0.1, 0.2),
		module2.Ternary(v72, 0, 0.05)
	)
	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.PurchaseConfirm.Multiselect", 13, base == v7.MULTI)

	if v72 then
		if class.PrevContentHeight ~= nil then
			class.ContentHeight = class.PrevContentHeight
			class.PrevContentHeight = nil
			class:AdjustToViewport()
		end
	else
		local purchaseConfirmOverride = "/Lotus/Language/Menu/SelectQuantityConfirm"
		local initMultiYPos = v28.InitMultiYPos
		local v73

		if base == v7.MULTI then
			v73 = initMultiYPos + 33
			class:ConfigureMultiPurchase()
		else
			v73 = initMultiYPos - 5
			v30 = 1
			fn43()
			purchaseConfirmOverride = "/Lotus/Language/Menu/DetailedPurchase_PurchaseConfirmTitle"
		end

		if currInfo ~= nil and currInfo.PurchaseConfirmOverride ~= nil then
			purchaseConfirmOverride = currInfo.PurchaseConfirmOverride
		end

		mMovie:__wf_atom_7d7314f1("DetailedView.BelowDescription.PurchaseConfirm.Label.text", purchaseConfirmOverride)

		if purchaseConfirmOverride == "" then
			v73 -= 30
		end

		mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm.Confirm", 1, v73)
		local v74 = v73 + mMovie:__wf_atom_5e6e15c8("DetailedView.BelowDescription.PurchaseConfirm.Confirm.Label", 41) + 51
		mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm.Bg", 15, v74)
		local purchaseBtnTag = "/Lotus/Language/Menu/Global_BuyItem"

		if class.IsGifting then
			purchaseBtnTag = "/Lotus/Language/Menu/Item_GiftToPlayerShort"
		elseif class.SelectedElement.PurchaseBtnTag ~= nil then
			purchaseBtnTag = class.SelectedElement.PurchaseBtnTag
		end

		v28.mPurchaseBtn:SetText(purchaseBtnTag)

		if not Engine.IsPlayingWithController() then
			local _ = base == v7.MULTI
		end

		class.PrevContentHeight = class.ContentHeight
		class.ContentHeight = v4.PurchaseConfirmY + v74
		class:AdjustToViewport()
	end

	if not p2 then
		fn15()
	end
end

function OSKSelectQuantity(p, p2)
	if p then
		return
	end

	v28.mInputField:InputFieldTextChanged(p2)
	fn3()

	if v30 == 1 then
		v28.mInputField:SetText("1")
	end
end

local function fn46()
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm", 12, 0)
	mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.PurchaseConfirm", 67, false)
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.PurchaseConfirm.Confirm.StrikeThrough", 0, 1)
	local module17 = require("Lotus.Interface.Components.ThemedInputField")
	v28.mInputField = module17.Create(
		mMovie,
		"DetailedView.BelowDescription.PurchaseConfirm.Multiselect.Count",
		nil,
		nil
	)
	v28.mInputField:SetType(v28.mInputField.TYPE.PLAIN, nil, nil, "OSKSelectQuantity")
	v28.mInputField:SetWidth(286)
	v28.mInputField:SetNumbersOnly()
	v28.mInputField:SetText("1")
	v28.mInputField.BaseInputFieldFocused = v28.mInputField.InputFieldFocused

	function v28.mInputField.InputFieldFocused(object, p)
		object:BaseInputFieldFocused(p)
		fn3()

		if v30 == 1 then
			if p then
				object:SetText("")
			else
				object:SetText("1")
			end
		end
	end

	v28.mInputField:SetTextAlignment("center")
	local module18 = require("Lotus.Interface.Components.ThemedButton")
	v28.mPurchaseBtn = module18.Create(
		mMovie,
		"DetailedView.BelowDescription.PurchaseConfirm.Confirm.PurchaseBtn",
		"/Lotus/Language/Menu/Global_BuyItem",
		"OnPurchase",
		nil,
		false
	)
	v28.mPurchaseBtn.mOnReleasedCallback = v28.mPurchaseBtn.mOnPressedCallback

	function v28.mPurchaseBtn.mOnPressedCallback(_)
		return false
	end

	v28.mPurchaseBtn:SetWidth(212)
	v28.mCancelBtn = module18.Create(
		mMovie,
		"DetailedView.BelowDescription.PurchaseConfirm.Confirm.CancelBtn",
		"/Lotus/Language/Menu/NavBar_Cancel",
		"GoBack",
		nil,
		false
	)
	v28.mCancelBtn:SetWidth(212)

	local function fn47(p, p2, p3)
		local v72 = module18.Create(mMovie, p, p2, p3, nil, false)
		v72.mOnReleasedCallback = fn10
		v72.mOnUnfocusedCallback = fn10
		v72:SetWidth(32)
		return v72
	end

	v28.mMinBtn = fn47("DetailedView.BelowDescription.PurchaseConfirm.Multiselect.MinBtn", "<MIN_BUTTON>", "MinCount")
	v28.mDecBtn = fn47(
		"DetailedView.BelowDescription.PurchaseConfirm.Multiselect.DecBtn",
		"<DECR_BUTTON>",
		"DecreaseCount"
	)
	v28.mIncBtn = fn47(
		"DetailedView.BelowDescription.PurchaseConfirm.Multiselect.IncBtn",
		"<INCR_BUTTON>",
		"IncreaseCount"
	)
	v28.mMaxBtn = fn47("DetailedView.BelowDescription.PurchaseConfirm.Multiselect.MaxBtn", "<MAX_BUTTON>", "MaxCount")
	v28.InitMultiYPos = mMovie:__wf_atom_5e6e15c8("DetailedView.BelowDescription.PurchaseConfirm.Multiselect", 1)

	function v28.UpdateColors()
		v28.mInputField:UpdateColors()
		v28.mPurchaseBtn:UpdateColors()
		v28.mCancelBtn:UpdateColors()
		v28.mMinBtn:UpdateColors()
		v28.mDecBtn:UpdateColors()
		v28.mIncBtn:UpdateColors()
		v28.mMaxBtn:UpdateColors()
	end
end

fn8 = function(storeItem)
	local v72 = {
		Name = "",
		HideCount = true,
		HideCheck = true,
		Count = 1,
		Req = 1
	}

	if not storeItem:IsA(__wf_atom_cb425ff5) then
		storeItem = v16:GetStoreItem(storeItem)
	end

	if __wf_atom_7e8ad928(storeItem) then
		return v72
	end

	local iconTexture, themed = module5.GetIconTexture(storeItem, true)
	v72.Icon = iconTexture
	v72.Themed = themed
	v72.Name = module5.GetLocalizedItemName(mMovie, storeItem)
	return v72
end

local function fn47(state)
	local storeItem = state.StoreItem

	if __wf_atom_7e8ad928(storeItem) then
		state.ItemName = ""
		state.TypeText = ""
		state.PurchaseQuantity = 1
		state.NumOwned = 0
		state.HasSpecialPrice = false
		state.HasRegularPrice = false
		state.ItemDesc = ""
		state.IsSigil = false
		state.IsMod = false
		state.IsArcane = false
		state.IsRailjackMod = false
	else
		print("PopulateInfo->" .. tostring(storeItem:__wf_atom_5b41f63b()))
		state.IsExternalProduct = module3.GetProductId(storeItem) ~= ""
			and module3.CheckSteamPurchaseAvailability(storeItem) ~= "MARKET"
		state.IsRecipe = storeItem:__wf_atom_efa6f447() == 13
		state.StoreItemInfo = module5.GetStoreItemInfo(mMovie, storeItem, { GameData = gameData }, nil, nil, true)
		state.IsFish = not __wf_atom_7e8ad928(state.StoreItemInfo.Type)
			and state.StoreItemInfo.Type:IsA(__wf_atom_0a75d7b6)

		if not __wf_atom_7e8ad928(inventory) then
			local mXPInfo = inventory.mXPInfo

			for i = 1, #mXPInfo do
				local mItemType = mXPInfo[i].mItemType

				if
					__wf_atom_7e8ad928(mItemType)
					or not (mItemType == state.StoreItemInfo.Type or mItemType == state.StoreItemInfo.CatItemType)
				then
					continue
				end

				state.Rank = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mXPInfo[i].mXP, mItemType)
				break
			end
		end

		if __wf_atom_7e8ad928(state.WishlistItem) then
			state.WishlistItem = module5.GetWishlistItem(storeItem)

			if not __wf_atom_7e8ad928(gameData) then
				state.PrevInWishlist = gameData:__wf_atom_fd7fe850(state.WishlistItem)
			end

			class:SetInWishlist(
				state,
				module2.Ternary(
					module2.FindInTable(wishlistItems, state.WishlistItem) == -1,
					state.PrevInWishlist,
					not state.PrevInWishlist
				)
			)
		end

		local name

		if state.NameOverride == nil then
			if state.ModularInfo == nil or state.ModularInfo.Name == nil then
				if
					__wf_atom_7e8ad928(state.StoreItemInfo.Type)
					or not state.StoreItemInfo.Type:IsA(__wf_atom_0a75d7b6)
				then
					name = module5.GetLocalizedItemName(mMovie, storeItem)
				else
					name = mMovie:__wf_atom_8e9ac384(storeItem:__wf_atom_9a82db92():c_str(), false)
				end
			else
				name = state.ModularInfo.Name
			end
		else
			name = state.NameOverride
		end

		local item = storeItem:GetItem()
		state.IsSigil = fn13(item)

		if name ~= "" and state.IsEliteCrewMember then
			name ..= mMovie:__wf_atom_8e9ac384(" <ELITE_CREW_MEMBER>", true)
		end

		state.UseSquareIcon = false

		if state.IsSigil or state.StoreItemInfo.Themed then
			state.UseSquareIcon = true
		end

		state.PurchaseQuantity = storeItem:__wf_atom_17d97bf6()

		if state.QuantityMultiplier ~= nil and state.QuantityMultiplier > 1 then
			state.PurchaseQuantity *= state.QuantityMultiplier
		end

		local isMod, isArcane2, isRailjackMod2 = class:IsMod(storeItem)
		state.IsMod = isMod
		state.IsArcane = isArcane2
		state.IsRailjackMod = isRailjackMod2
		state.ItemName = name

		if string.find(state.ItemName, "Tennogen") ~= nil then
			state.ItemName = string.gsub(state.ItemName, "Tennogen", "TennoGen")
		end

		local mCategoryString = v10.mCategoryString or "?"
		local v75, freeSlots = fn32(storeItem)

		if v75 then
			mCategoryString ..= " [" .. v75 .. "]"
		end

		state.TypeText = mCategoryString
		state.FreeSlots = freeSlots
		local numOwned = module3.GetNumOwned(gameData, inventory, storeItem, v13)
		local numOwned2 = v10.mExternalProductPurchased and 1 or numOwned
		local __wf_atom_ecd05e96 = storeItem:__wf_atom_ecd05e96()

		if not __wf_atom_7e8ad928(__wf_atom_ecd05e96) then
			state.RecipesOwned = module3.GetRecipesOwned(__wf_atom_ecd05e96, v13)
		end

		state.NumOwned = numOwned2
		state.CanPurchaseIfAlreadyOwned = module3.CanPurchaseIfAlreadyOwned(storeItem)

		if
			(not state.CanPurchaseIfAlreadyOwned or v10.mExternalProductPurchased)
			and state.NumOwned > 0
			and not state.PrevInWishlist
			and state.CurrInWishlist
		then
			local v78 = module2.FindInTable(wishlistItems, state.WishlistItem)

			if v78 ~= -1 then
				table.remove(wishlistItems, v78)
				class:SetInWishlist(state, false)
			end
		end

		if not state.Sale then
			state.Sale = module3.GetSaleInfo(storeItem)
		end

		local regularPriceOverride, premiumPriceOverride = module3.__wf_atom_a94b426a(storeItem, nil, false, v13)
		local __wf_atom_a94b426a, mForcePlatSale = module3.__wf_atom_a94b426a(state.StoreItem, nil, true, v13)
		local flag4 = false
		local showBogo = false
		local shouldShowCoupon = class:ShouldShowCoupon(state)
		local bogoExtra = 0

		if state.Sale and not __wf_atom_7e8ad928(gameData) then
			if state.Sale.mDiscount > 0 then
				regularPriceOverride, premiumPriceOverride = module3.__wf_atom_a94b426a(
					storeItem,
					nil,
					false,
					v13,
					nil,
					true
				)

				if not shouldShowCoupon or state.Coupon.mAmount <= state.Sale.mDiscount / 100 then
					if state.Sale.mForcePlatSale ~= nil then
						mForcePlatSale = state.Sale.mForcePlatSale
					end

					flag4 = true
					shouldShowCoupon = false

					if not __wf_atom_7e8ad928(state.Sale.mPremiumOverride) and state.Sale.mPremiumOverride > 0 then
						state.PremiumCost = state.Sale.mPremiumOverride
						state.DiscountCalculated = true
					end

					if not __wf_atom_7e8ad928(state.Sale.mRegularOverride) and state.Sale.mRegularOverride > 0 then
						state.CreditCost = state.Sale.mRegularOverride
						state.DiscountCalculated = true
					end
				end
			elseif
				state.Sale == nil
				or state.Sale.mBogoBuy == nil
				or not (state.Sale.mBogoBuy > 0)
				or state.Sale.mBogoGet == nil
				or not (state.Sale.mBogoGet > 0)
			then
				if regularPriceOverride ~= __wf_atom_a94b426a then
					regularPriceOverride = __wf_atom_a94b426a
					shouldShowCoupon = false
				end

				if premiumPriceOverride ~= mForcePlatSale then
					premiumPriceOverride = mForcePlatSale
					shouldShowCoupon = false
				end
			else
				bogoExtra = state.Sale.mBogoGet / state.Sale.mBogoBuy
				showBogo = true
			end
		end

		state.BogoExtra = bogoExtra
		state.ShowSale = flag4 and (not state.IsExternalProduct or v70)
		state.ConsoleSale = Engine.__wf_atom_fc67ba71()
			and state.IsExternalProduct
			and not __wf_atom_7e8ad928(state.Sale)
			and state.Sale.mDiscount > 0
		state.ShowBogo = showBogo
		state.ShowCoupon = shouldShowCoupon

		if state.PremiumPriceOverride ~= nil then
			premiumPriceOverride = state.PremiumPriceOverride
		end

		if state.RegularPriceOverride ~= nil then
			regularPriceOverride = state.RegularPriceOverride
		end

		if state.CanPurchaseOverride == nil or state.CanPurchaseOverride ~= false then
			state.HasSpecialPrice = (state.SpecialPrice ~= nil and state.SpecialPrice > 0 or state.ItemPrices ~= nil)
				and not (state.IsExternalProduct or state.IsReward)
			local __wf_atom_347d3c3b = gameData:__wf_atom_347d3c3b(module3.GetProductId(storeItem))
			local v81

			if gameData:__wf_atom_43750928(module3.GetProductId(storeItem)) > 0 then
				v81 = true
			elseif __wf_atom_347d3c3b == "0.00" then
				v81 = false
			else
				v81 = __wf_atom_347d3c3b ~= ""
			end

			state.HasRegularPrice = state.IsExternalProduct and v81
				or premiumPriceOverride > 0
				or regularPriceOverride > 0
		else
			state.HasSpecialPrice = false
			state.HasRegularPrice = false
		end

		local isMod2 = state.IsMod
		local isArcane = state.IsArcane
		local isRailjackMod = state.IsRailjackMod
		local v80 = { item }
		local isPackage = storeItem:IsPackage()

		if isPackage then
			local __wf_atom_72915748 = storeItem:__wf_atom_72915748()

			for i = 1, #__wf_atom_72915748 do
				if __wf_atom_7e8ad928(__wf_atom_72915748[i].mTypeName) then
					continue
				end

				table.insert(v80, (__wf_atom_72915748[i].mTypeName:GetItem()))
				local isMod3, v81, v82 = class:IsMod(__wf_atom_72915748[i].mTypeName)
				isMod2 = isMod2 or isMod3
				isArcane = isArcane or v81
				isRailjackMod = isRailjackMod or v82
			end
		end

		local v81 = nil
		local v82 = nil
		local v83 = nil

		for _, v84 in ipairs(v80) do
			if v84:IsA(__wf_atom_45781192) then
				v81 = Resource(v84)
			elseif v84:IsA(__wf_atom_5a036296) then
				v82 = Resource(v84)
			elseif v84:IsA(__wf_atom_3bda1628) then
				v83 = Resource(v84)
			end
		end

		local applied

		if v81 == nil and v82 == nil and v83 == nil then
			applied = false
		else
			applied = not _T.UIStyleScreenOpen
		end

		if applied or v40.Applied then
			v40.Applied = applied
			module7.ForceDefaultStyle(v81, v82, v83)
		end

		local v85 = "<p><font color=\"" .. module2.ConvertColorNumberToHex(module7.GetColor(6, true)) .. "\">"

		if v66.IsDailyDeal then
			local dailyDeal = module3.GetDailyDeal()
			local formatNumber = module2.FormatNumber(dailyDeal.mAmountTotal - dailyDeal.mAmountSold, 0)
			v85 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_DailyDealInventory", true, {
				INV = formatNumber
			}) .. "<br><br>"
		end

		local descOverride = ""

		if state.DescOverride == nil then
			if state.UseLongDesc and storeItem:__wf_atom_a6334b47():__wf_atom_8598f3a9() then
				descOverride = storeItem:__wf_atom_a6334b47()
			elseif not __wf_atom_7e8ad928(item) then
				if item:IsA(__wf_atom_6317e6dc) then
					descOverride = module5.GetRelicInfo(mMovie, storeItem, true)
				elseif item:IsA(class.ItemTypes.enhancementType) then
					local upgradeInfo = SF.UpgradeInfo()
					upgradeInfo.mItemType = item
					local mInstance = upgradeInfo.mInstance

					if not __wf_atom_7e8ad928(mInstance) and mInstance:IsA(__wf_atom_58a409f1) then
						local __wf_atom_49f7d220 = mInstance:__wf_atom_49f7d220("")
						local v86 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false) .. "  "
						local v87 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
							RANK = __wf_atom_49f7d220
						}) .. "  "
						local __wf_atom_254ac1f5 = mInstance:__wf_atom_254ac1f5(__wf_atom_49f7d220)
						local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mInstance:__wf_atom_f324d993(""), true)
						local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
							mInstance:__wf_atom_f324d993(__wf_atom_254ac1f5),
							true
						)
						descOverride = "<font color=\"" .. v67.FloatingContentHighlightHex .. "\">" .. string.upper(v86) .. "<font color=\"" .. v67.FloatingContentHex .. "\">" .. __wf_atom_8e9ac384 .. "</font><br><br>" .. string.upper(v87) .. "<font color=\"" .. v67.FloatingContentHex .. "\">" .. __wf_atom_8e9ac384_2 .. "</font></font>"
					end
				end
			end
		else
			descOverride = state.DescOverride
		end

		if descOverride == "" then
			descOverride = tostring(storeItem:__wf_atom_5e0d90e8())

			if __wf_atom_7e8ad928(descOverride) or descOverride == "" then
				descOverride = module2.Ternary(
					tostring(storeItem:__wf_atom_127f1d58()) ~= "",
					storeItem:__wf_atom_127f1d58(),
					storeItem:__wf_atom_3a3d2e39()
				)
			end
		end

		local additionalDesc = tostring(descOverride)
		local v86 = v85 .. mMovie:__wf_atom_8e9ac384(additionalDesc, true)

		if not __wf_atom_7e8ad928(item) and (state.IsArcane or item:IsA(__wf_atom_6317e6dc)) then
			local codexManifest = nil

			if __wf_atom_7e8ad928(state.CodexManifest) then
				if module3.GetUIMode() == module3.UI_MODE_IN_SPACE_SHIP then
					codexManifest = Resource(v17)
				end
			else
				codexManifest = state.CodexManifest
			end

			if not __wf_atom_7e8ad928(codexManifest) then
				local v87

				if state.IsArcane then
					v87 = codexManifest:__wf_atom_bd16feb6(item)
				else
					v87 = codexManifest:__wf_atom_37a8a86f(item)
				end

				if not __wf_atom_7e8ad928(v87.type) then
					local __wf_atom_af5caba7 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7()
					local starChartNodes = module3.GetStarChartNodes()
					local v88 = module.OnStats(__wf_atom_af5caba7, starChartNodes)
					additionalDesc = module.GetDropSourcesString(
						mMovie,
						codexManifest,
						v87,
						1,
						starChartNodes,
						v88,
						v67.FloatingContentHex,
						v67.ContentHex
					)

					if additionalDesc ~= "" then
						v86 ..= "<br><br>" .. additionalDesc
					end
				end
			end
		end

		if state.AdditionalDesc ~= nil and string.len(state.AdditionalDesc) > 0 then
			additionalDesc = state.AdditionalDesc
			v86 ..= additionalDesc
		end

		if not isPackage and storeItem:IsA(__wf_atom_87288ae7) then
			local v87 = not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_1316e0c2)
			additionalDesc = module2.Ternary(additionalDesc == "", "", "<br><br>") .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/UiElements/ShipDecoCapacityCost",
				false,
				{
					COST = storeItem:__wf_atom_e23658d9(v87)
				}
			)
			v86 ..= additionalDesc
		end

		if isMod2 or isArcane then
			if state.HasRegularPrice or state.HasSpecialPrice then
				v86 ..= module2.Ternary(additionalDesc == "", "", "<br><br>") .. mMovie:__wf_atom_8e9ac384("<WARNING> ", true) .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/" .. (isArcane and "PurchasedArcanesUnranked" or isRailjackMod and "PurchasedAvionicsUnranked" or "PurchasedModsUnranked"),
					false
				)
			end
		elseif string.len(additionalDesc) == 0 then
			v86 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_NoDescriptionAvailable", false)
		end

		if state.IsExternalProduct and not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local __wf_atom_ffeca9d8 = __wf_atom_18a5d83b:__wf_atom_ffeca9d8()

				if
					not __wf_atom_7e8ad928(__wf_atom_ffeca9d8)
					and __wf_atom_ffeca9d8 ~= ""
					and __wf_atom_ffeca9d8 ~= "null"
				then
					v86 ..= module2.Ternary(v86 == "", "", "<br><br>") .. __wf_atom_ffeca9d8
				end
			end
		end

		if
			state.IsExternalPlat
			and class:ShouldShowCoupon(state)
			and state.Coupon.mCouponType == 2
			and module5.__wf_atom_a5af4628(state.StoreItem, state.Coupon)
		then
			local __wf_atom_c3344f99 = module5.__wf_atom_c3344f99(state.StoreItem, state.Coupon.mAmount)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/BonusPlatinumPercent", false, {
				PERCENT = module2.FormatNumber(state.Coupon.mAmount - 100, 0, false)
			})

			if not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if
					not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
					and __wf_atom_18a5d83b:__wf_atom_01fbbcf8("coupon_bonus_platinum_multiplier")
				then
					__wf_atom_8e9ac384 = string.upper(mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Store/BonusPlatinum",
						true,
						{
							MULTIPLIER = module2.FormatNumber(state.Coupon.mAmount / 100, 2, false)
						}
					))
				end
			end

			local v87 = string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/BonusPlatinumTag", true, {
				PLATINUM = __wf_atom_c3344f99
			}))
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("<TIMER>", true)
			local secondsToFormattedTime = module3.SecondsToFormattedTime(
				mMovie,
				Engine.__wf_atom_e9b9db5f(state.Coupon.mExpiry),
				"CompactTwoMax"
			)
			local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Store/BonusPlatinumDescriptionNoTime",
				false,
				{ TIME = secondsToFormattedTime }
			)
			mMovie:__wf_atom_50d60589("DetailedView.BelowDescription.BonusCoupon.CouponValue", 36, __wf_atom_8e9ac384)
			mMovie:__wf_atom_50d60589("DetailedView.BelowDescription.BonusCoupon.BonusValue", 36, v87)
			mMovie:__wf_atom_50d60589(
				"DetailedView.BelowDescription.BonusCoupon.CouponDescription",
				36,
				__wf_atom_8e9ac384_3
			)
			mMovie:__wf_atom_50d60589("DetailedView.BelowDescription.BonusCoupon.CouponDescription", 14, 432)
			mMovie:__wf_atom_50d60589(
				"DetailedView.BelowDescription.BonusCoupon.TimeLeft",
				36,
				__wf_atom_8e9ac384_2 .. " " .. secondsToFormattedTime
			)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(
				"DetailedView.BelowDescription.BonusCoupon.CouponDescription",
				41
			)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(
				"DetailedView.BelowDescription.BonusCoupon.TimeLeft",
				40
			)
			mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.Bg", 15, __wf_atom_5e6e15c8 + 78)
			mMovie:__wf_atom_e57658c2(
				"DetailedView.BelowDescription.BonusCoupon.TimeLeft",
				0,
				441 - __wf_atom_5e6e15c8_2
			)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(
				"DetailedView.BelowDescription.BonusCoupon.BackerIcon",
				14
			)
			local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(
				"DetailedView.BelowDescription.BonusCoupon.BackerIcon",
				15
			)
			mMovie:__wf_atom_e57658c2(
				"DetailedView.BelowDescription.BonusCoupon.BackerIcon",
				0,
				450 - __wf_atom_5e6e15c8_3 * 0.8
			)
			mMovie:__wf_atom_e57658c2(
				"DetailedView.BelowDescription.BonusCoupon.BackerIcon",
				1,
				__wf_atom_5e6e15c8 + 78 - __wf_atom_5e6e15c8_4 * 0.8
			)
			mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.Mask", 0, 2)
			mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.Mask", 1, 2)
			mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.Mask", 14, 446)
			mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription.BonusCoupon.Mask", 15, __wf_atom_5e6e15c8 + 74)
		end

		if
			module9.GetWorldStateOverride("PurchasePlatformLockEnabled", false)
			and state.StoreItem:__wf_atom_955f7fe0()
			and fn12(state.StoreItem)
		then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/PurchasePCLocked", false)

			if Engine.__wf_atom_fc67ba71() then
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/PurchaseConsoleLocked", false)
			end

			v86 ..= "<br><br>" .. "<font color=\"" .. v67.FloatingContentHex .. "\">" .. mMovie:__wf_atom_8e9ac384("<WARNING> ", true) .. __wf_atom_8e9ac384 .. "</font>"
		end

		state.ItemDesc = v86 .. "</font></p>"
		state.SpecialPriceInfo = {}

		if state.HasSpecialPrice then
			local currencyText = ""
			local priceText = ""
			local specialPrice = nil
			local PRICE_BG_COLOR = nil

			if state.IsExternalProduct then
				if not __wf_atom_7e8ad928(gameData) then
					priceText = gameData:__wf_atom_347d3c3b(module3.GetProductId(state.StoreItem))
				end
			else
				if state.ItemPrices == nil then
					priceText = module2.FormatNumber(state.SpecialPrice)
				else
					local v89 = "<p><font color=\"#FFFFFF\">"

					for i = 1, #state.ItemPrices do
						local itemPrice = state.ItemPrices[i]
						local v90 = fn18(itemPrice.mItemType)

						if __wf_atom_7e8ad928(v90) then
							continue
						end

						local binarySearch = module3.BinarySearch(
							v13,
							itemPrice.mItemType:__wf_atom_5b41f63b(),
							function(p)
								if p then
									return p.type
								end

								return nil
							end
						)
						local v91 = 0

						if binarySearch then
							for j = binarySearch[1], binarySearch[2] do
								if v13[j].count then
									v91 += v13[j].count
								else
									v91 = math.min(v91 + 1, 1)
								end
							end
						end

						local v92 = v89 .. "<font color=\"" .. module2.Ternary(
							itemPrice.mItemCount <= v91,
							"#FFFFFF",
							"#BBBBBB"
						) .. "\">" .. module2.FormatNumber((math.min(v91, itemPrice.mItemCount))) .. "/" .. module2.FormatNumber(itemPrice.mItemCount) .. " " .. TitleCase(module5.GetLocalizedItemName(mMovie, v90))

						if i ~= #state.ItemPrices then
							v92 ..= "<br>"
						end

						v89 = v92 .. "</font>"
					end

					priceText = v89 .. "</font></p>"
				end

				specialPrice = state.SpecialPrice
			end

			if state.SpecialPriceIconTag == nil then
				if flag4 then
					currencyText = mMovie:__wf_atom_8e9ac384(
						module2.Ternary(__wf_atom_a94b426a > 0, "<CREDITS>", "<PLATINUM_CREDITS>"),
						true
					)
				end
			else
				currencyText = mMovie:__wf_atom_8e9ac384(state.SpecialPriceIconTag, true)

				if state.SpecialPriceIconTag == "<REPUTATION>" then
					state.SpecialPriceInfo.CurrencyXOverride = 13
					state.SpecialPriceInfo.CurrencyYOverride = 0
				elseif state.SpecialPriceIconTag == "<PRIME_BUCKS>" then
					state.SpecialPriceInfo.CurrencyYOverride = -2
				end
			end

			if state.IsExternalProduct or flag4 then
				PRICE_BG_COLOR = v68.PRICE_BG_COLOR
			elseif state.SpecialPriceBgColor ~= nil then
				PRICE_BG_COLOR = state.SpecialPriceBgColor
			end

			if specialPrice == nil then
				module2.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed", "TransitionOut")
			end

			state.SpecialPriceInfo.CurrencyText = currencyText
			state.SpecialPriceInfo.PriceText = priceText
			state.SpecialPriceInfo.Price = specialPrice
			state.SpecialPriceInfo.BgColor = PRICE_BG_COLOR
		end

		state.SalePriceInfo = {}
		state.EpicSale = false

		if
			storeItem:__wf_atom_56c51289()
			and Engine.__wf_atom_8dbe8185()
			and Engine.__wf_atom_eecb6143()
			and Engine.__wf_atom_4f071aa9(module3.GetProductId(storeItem))
			and storeItem:__wf_atom_efa6f447() ~= 11
		then
			state.ShowSale = true
			state.EpicSale = true
		end

		if state.ShowCoupon or state.ShowSale or state.ConsoleSale then
			local creditCost = module2.Ternary(regularPriceOverride > 0, regularPriceOverride, premiumPriceOverride)
			local mAmount = 1

			if __wf_atom_7e8ad928(state.PremiumCost) then
				if not __wf_atom_7e8ad928(state.CreditCost) then
					creditCost = state.CreditCost
				end
			else
				creditCost = state.PremiumCost
			end

			if state.IsExternalPlat then
				if
					state.ShowSale
					or not __wf_atom_7e8ad928(state.Coupon)
					and (__wf_atom_7e8ad928(state.Coupon.mCouponType) or state.Coupon.mCouponType == 0)
				then
					local __wf_atom_43750928 = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
					creditCost = __wf_atom_43750928 - __wf_atom_43750928 * state.Coupon.mAmount
				end
			else
				if state.ShowCoupon then
					mAmount = state.Coupon.mAmount
				elseif state.EpicSale then
					mAmount = Engine.__wf_atom_95fc6fbe(module3.GetProductId(storeItem))
				else
					mAmount = state.Sale.mDiscount / 100
				end

				if state.EpicSale then
					creditCost = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
				elseif state.IsExternalProduct and state.ShowSale and v70 and state.HasRegularPrice then
					local __wf_atom_43750928 = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
					creditCost = __wf_atom_43750928 - __wf_atom_43750928 * mAmount
				elseif __wf_atom_7e8ad928(state.DiscountCalculated) then
					creditCost = module3.GetPriceWithCoupon(creditCost, mAmount)
				end
			end

			state.SalePriceInfo.Discount = mAmount

			if Engine.__wf_atom_6f25c160() and state.StoreItemInfo.StoreItem:__wf_atom_836b9069() then
				state.SalePriceInfo.CurrencyText = mMovie:__wf_atom_8e9ac384("<STEAM>", true)
				local formatNumber = module2.FormatNumber(creditCost, 2, true, true)
				state.SalePriceInfo.PriceText = gameData:__wf_atom_9e2402a0(
					module3.GetProductId(storeItem),
					formatNumber
				)
			elseif storeItem:__wf_atom_56c51289() > 0 and Engine.__wf_atom_eecb6143() then
				state.SalePriceInfo.CurrencyText = mMovie:__wf_atom_8e9ac384("<EPIC>", true)
				local formatNumber = module2.FormatNumber(creditCost, 2, true, true)
				state.SalePriceInfo.PriceText = gameData:__wf_atom_9e2402a0(
					module3.GetProductId(storeItem),
					formatNumber
				)
			elseif state.IsExternalProduct and not state.StoreItemInfo.StoreItem:__wf_atom_955f7fe0() then
				state.SalePriceInfo.CurrencyText = ""
				local formatNumber = module2.FormatNumber(creditCost, 2, true, true)
				state.SalePriceInfo.PriceText = gameData:__wf_atom_9e2402a0(
					module3.GetProductId(storeItem),
					formatNumber
				)
			else
				state.SalePriceInfo.CurrencyText = mMovie:__wf_atom_8e9ac384(
					module2.Ternary(regularPriceOverride > 0, "<CREDITS>", "<PLATINUM_CREDITS>"),
					true
				)
				state.SalePriceInfo.PriceText = module2.FormatNumber(creditCost)
			end

			state.SalePriceInfo.Price = creditCost
		end

		state.RegularPriceInfo = {}

		if state.HasRegularPrice then
			local v87 = ""
			local priceText = ""

			if state.IsExternalProduct then
				if not __wf_atom_7e8ad928(gameData) then
					priceText = gameData:__wf_atom_347d3c3b(module3.GetProductId(storeItem))
				end

				if Engine.__wf_atom_84bb79c2() and priceText == "0.00" then
					priceText = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_PleaseWait", false)
					v69 = true
				elseif Engine.__wf_atom_6f25c160() and storeItem:__wf_atom_836b9069() then
					v87 = "<STEAM>"

					if module3.CheckSteamPurchaseAvailability(storeItem) == "UNAVAILABLE" then
						priceText = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_SteamWorkshopItem",
							false
						)
					end
				elseif storeItem:__wf_atom_56c51289() > 0 and Engine.__wf_atom_eecb6143() then
					v87 = "<EPIC>"
				end
			else
				priceText = module2.FormatNumber(module2.Ternary(
					regularPriceOverride > 0,
					regularPriceOverride,
					premiumPriceOverride
				))
				v87 = module2.Ternary(regularPriceOverride > 0, "<CREDITS>", "<PLATINUM_CREDITS>")
			end

			state.RegularPriceInfo.Hide = not Engine.__wf_atom_84bb79c2() and WeakResource(storeItem) == v18
			state.RegularPriceInfo.CurrencyText = mMovie:__wf_atom_8e9ac384(v87, true)
			state.RegularPriceInfo.IsPremium = regularPriceOverride <= 0

			if storeItem:__wf_atom_56c51289() > 0 and Engine.__wf_atom_eecb6143() then
				state.RegularPriceInfo.PriceText = gGameData:__wf_atom_347d3c3b(module3.GetProductId(storeItem))
				state.RegularPriceInfo.Price = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
			elseif Engine.__wf_atom_2a979d69() and gGameData:__wf_atom_23adb874(module3.GetProductId(storeItem)) then
				state.RegularPriceInfo.PriceText = gameData:__wf_atom_347d3c3b(module3.GetProductId(storeItem))
				state.RegularPriceInfo.Price = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
			elseif
				state.IsExternalProduct
				and Engine.__wf_atom_6f25c160()
				and state.ShowSale
				and state.HasRegularPrice
			then
				state.RegularPriceInfo.PriceText = gameData:__wf_atom_347d3c3b(module3.GetProductId(storeItem))
				state.RegularPriceInfo.Price = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
			elseif state.IsExternalProduct then
				state.RegularPriceInfo.PriceText = priceText
				state.RegularPriceInfo.Price = gameData:__wf_atom_43750928(module3.GetProductId(storeItem))
			else
				state.RegularPriceInfo.PriceText = priceText
				state.RegularPriceInfo.Price = module2.Ternary(
					regularPriceOverride > 0,
					regularPriceOverride,
					premiumPriceOverride
				)
			end

			if state.RegularPriceInfo.Price == nil then
				module2.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed", "TransitionOut")
			end
		end

		local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()

		if
			premiumPriceOverride > 0
			and regularPriceOverride <= 0
			and not state.IsExternalProduct
			and not state.CodexMode
			and not __wf_atom_7e8ad928(v16)
			and (__wf_atom_efa6f447 == 0 or __wf_atom_efa6f447 == 1 or __wf_atom_efa6f447 == 5 or __wf_atom_efa6f447 == 3)
		then
			state.IngredientOverride = {}

			if __wf_atom_efa6f447 == 3 then
				table.insert(
					state.IngredientOverride,
					fn8(WeakResource("/Lotus/Types/StoreItems/SlotItems/SuitSlotItem"))
				)
				table.insert(state.IngredientOverride, fn8(WeakResource("/Lotus/Types/Items/MiscItems/OrokinReactor")))
			else
				table.insert(
					state.IngredientOverride,
					fn8(WeakResource("/Lotus/Types/StoreItems/SlotItems/WeaponSlotItem"))
				)
				table.insert(state.IngredientOverride, fn8(WeakResource("/Lotus/Types/Items/MiscItems/OrokinCatalyst")))
			end

			state.IngredientOverride[2].Name = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/DetailedPurchase_InstalledInclude",
				false,
				{ ITEM = state.IngredientOverride[2].Name }
			)
		end

		state.ParentBundles = {}

		if not (__wf_atom_7e8ad928(v6) or state.CodexMode) then
			state.ParentBundles = v6:__wf_atom_b30d5ab2(storeItem)
		end

		state.PurchaseCompatWarning = nil
		state.Compatibles = {}
		local compatWarning, _, purchaseCompatWarning = module5.GetCompatWarning(mMovie, storeItem, v16, inventory, {
			Items = v13
		})
		state.Compatibles = compatWarning
		state.PurchaseCompatWarning = purchaseCompatWarning

		if state.SyndicateTag ~= nil then
			state.Syndicate = {}
			module8.InitializeSyndicateData(__wf_atom_c67f9605:__wf_atom_13d5b7e9(state.SyndicateTag), state.Syndicate)
			local syndicate = state.Syndicate
			local syndicate2 = state.Syndicate
			local syndicate3 = state.Syndicate
			local syndicate4 = state.Syndicate
			local reputationInfoForSyndicate, reputation, reputationRequired, hasEnoughReputationForSacrifice = module3.GetReputationInfoForSyndicate(state.Syndicate.Syndicate)
			syndicate.Level = reputationInfoForSyndicate
			syndicate2.Reputation = reputation
			syndicate3.ReputationRequired = reputationRequired
			syndicate4.HasEnoughReputationForSacrifice = hasEnoughReputationForSacrifice
		end

		if state.IsRecipe then
			state.BuildTime = module3.GetTwitterStyleTime(storeItem:__wf_atom_ed1be18b())
		end

		state.GiftingPrice = mForcePlatSale
	end
end

local function fn48(currInfo)
	local result = {}
	local shiftX

	if currInfo.NumOwned > 0 then
		shiftX = not (currInfo.IsExternalProduct and currInfo.CanPurchaseIfAlreadyOwned)
	else
		shiftX = false
	end

	local recipesOwned = currInfo.RecipesOwned
	local v73

	if recipesOwned == nil then
		v73 = false
	else
		v73 = recipesOwned > 0
	end

	local _, v74 = module3.IsXPLocked(currInfo.StoreItem)
	local v75

	if v74 == nil or not (v74 > 0) then
		v75 = false
	else
		v75 = currInfo.IgnoreXpRequirement ~= true
	end

	local shiftX2

	if currInfo.Rank == nil then
		shiftX2 = false
	else
		shiftX2 = currInfo.Rank >= __wf_atom_c67f9605:__wf_atom_a1680b24(currInfo.StoreItemInfo.Type)
	end

	local __wf_atom_a7f0cb73 = currInfo.StoreItem:__wf_atom_a7f0cb73()
	local isArcane = currInfo.IsArcane

	if shiftX then
		if currInfo.IsFish then
			local __wf_atom_9b2b3625 = module6.__wf_atom_9b2b3625(currInfo.StoreItem, fishInfoManifest)

			for i = 1, #__wf_atom_9b2b3625 do
				local __wf_atom_52fcdd65 = inventory:__wf_atom_52fcdd65(__wf_atom_9b2b3625[i]:GetItem())
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_Owned", true, {
					HOW_MANY = module2.FormatNumber(__wf_atom_52fcdd65, 0) .. " (" .. mMovie:__wf_atom_8e9ac384(
						__wf_atom_9b2b3625[i]:__wf_atom_0bd1161f(true):c_str(),
						false
					) .. ")"
				})
				table.insert(result, module6.GetInfoForLabel(module6.LABEL_TYPE_CHECKMARK, __wf_atom_8e9ac384))
			end
		else
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_Owned", true, {
				HOW_MANY = module2.FormatNumber(currInfo.NumOwned, 0)
			})
			table.insert(result, module6.GetInfoForLabel(module6.LABEL_TYPE_CHECKMARK, __wf_atom_8e9ac384))
		end
	end

	if v75 then
		local infoForLabel = module6.GetInfoForLabel(
			module6.LABEL_TYPE_REQUIRED_MASTERY,
			"/Lotus/Language/Menu/DetailedPurchase_MasteryLocked"
		)
		infoForLabel.IconText = module2.FormatNumber(v74)
		infoForLabel.ShiftX = shiftX
		table.insert(result, infoForLabel)
	end

	if isArcane then
		local arcaneTagInfo = module6.GetArcaneTagInfo(currInfo.StoreItemInfo.Type)

		if arcaneTagInfo ~= nil then
			arcaneTagInfo.ShiftX = shiftX and not v75
			table.insert(result, arcaneTagInfo)
		end
	end

	if shiftX2 then
		table.insert(
			result,
			module6.GetInfoForLabel(
				module6.LABEL_TYPE_MASTERY,
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_Mastered", false)
			)
		)
	end

	if __wf_atom_a7f0cb73 then
		local infoForLabel = module6.GetInfoForLabel(
			module6.LABEL_TYPE_TRADEABLE,
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/Trade_Tradeable", false)
		)
		infoForLabel.ShiftX = shiftX2
		table.insert(result, infoForLabel)
	end

	if not v73 then
		return result
	end

	local v77

	if recipesOwned == 1 then
		v77 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/RecipeOwnedSingular", false)
	else
		v77 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/RecipeOwnedPlural", false, {
			COUNT = module2.FormatNumber(recipesOwned)
		})
	end

	table.insert(result, module6.GetInfoForLabel(module6.LABEL_TYPE_RECIPES, v77))
	return result
end

local function fn49()
	local mDescY = 0
	local currInfo = class:GetCurrInfo()

	if __wf_atom_7e8ad928(currInfo) then
		return
	end

	mMovie:__wf_atom_2dedec1a("Preview", 13, class.mGenericDiorama)
	mMovie:__wf_atom_2dedec1a("LinesTop", 13, class.mGenericDiorama)
	mMovie:__wf_atom_2dedec1a("LinesBottom", 13, class.mGenericDiorama)

	if class.mGenericDiorama then
		currInfo.StoreItemInfo.mClipName = "Preview"
		currInfo.StoreItemInfo.IconHeight = module2.Ternary(currInfo.StoreItemInfo.Themed, 450, 300)
		currInfo.StoreItemInfo.UpgradeFingerprint = currInfo.UpgradeFingerprint
		local flag4 = false

		if currInfo.IsMod then
			local mItemCount = 0

			if module4.IsCardOmega({ mArtifactUpgrade = currInfo.StoreItemInfo.Type }) then
				if not __wf_atom_7e8ad928(class.mStatItem) then
					flag4 = true
				end
			else
				local __wf_atom_063f1444 = inventory:__wf_atom_063f1444()

				for i = 1, #__wf_atom_063f1444 do
					if not (__wf_atom_063f1444[i].mItemCount > 0 and __wf_atom_063f1444[i].mItemType == currInfo.StoreItemInfo.Type) then
						continue
					end

					mItemCount = __wf_atom_063f1444[i].mItemCount
					break
				end

				local upgrades = inventory:GetUpgrades()

				for i = 1, #upgrades do
					if upgrades[i].mItemType ~= currInfo.StoreItemInfo.Type then
						continue
					end

					if upgrades[i].mItemType:IsA(v22) then
						if cjson.decode(upgrades[i].mUpgradeFingerprint).lvl ~= 3 then
							mItemCount += 1
						end
					else
						mItemCount += 1
					end
				end
			end

			currInfo.NumOwned = mItemCount
		end

		module6.DrawGridItem(mMovie, {}, currInfo.StoreItemInfo, {
			ZoomYShift = 0,
			IsFocused = true,
			DisableSaturation = true,
			DisableBundleCycle = true
		})

		if flag4 then
			v56:SetupOmega(class.mStatItem, currInfo.UpgradeFingerprint)
		end
	end

	local v73 = not __wf_atom_7e8ad928(currInfo.CrewMemberInfo)
	local v74 = not (__wf_atom_7e8ad928(currInfo.Syndicate) or v73)
	mMovie:__wf_atom_7f57ab2f("DetailedView", "SyndicateInfo", 13, v74)

	if v74 then
		module8.PopulateSyndicateInfo(mMovie, v62, currInfo.Syndicate)
		mMovie:__wf_atom_4c1c1986("DetailedView", "SyndicateInfo", 1, mDescY + 5)
		mDescY = mDescY + v62.mHeight + 25
	end

	class.mSkipBase = class:UpdatePurchasePanel() and currInfo.mCanPurchase
	local itemName = currInfo.ItemName

	if not __wf_atom_7e8ad928(module5.GetPlatinumBundlePair(currInfo.StoreItem)) and module5.__wf_atom_7f3468fc() then
		if __wf_atom_7e8ad928(currInfo.NameOverride) then
			itemName = module5.GetLocalizedItemName(mMovie, currInfo.StoreItem)
		else
			itemName = currInfo.NameOverride
		end
	end

	if (v53.CustomizationList:GetHowManyElements() > 0 or v64.GiftBtn.mIsVisible) and currInfo.PurchaseQuantity > 1 then
		itemName = currInfo.PurchaseQuantity .. " x " .. itemName
	end

	mMovie:__wf_atom_4c1c1986("DetailedView", "ItemName", 1, mDescY)
	mMovie:__wf_atom_7d7314f1("DetailedView.ItemName.text", itemName)
	mMovie:__wf_atom_4c1c1986("DetailedView", "ItemName", 85, 1000)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailedView.ItemName", 82)
	mMovie:__wf_atom_4c1c1986("DetailedView", "Wishlist", 0, __wf_atom_5e6e15c8)

	if currInfo.ItemName ~= "" then
		mDescY = mDescY + mMovie:__wf_atom_5e6e15c8("DetailedView.ItemName", 41) + 5
	end

	mMovie:__wf_atom_4c1c1986("DetailedView", "Wishlist", 1, mDescY - 27)
	mMovie:__wf_atom_4c1c1986("DetailedView", "Owned", 1, mDescY + 10)
	mMovie:__wf_atom_4c1c1986("DetailedView", "RankLock", 1, mDescY + 10)
	local v75

	if currInfo.NumOwned > 0 then
		v75 = not (currInfo.IsExternalProduct and currInfo.CanPurchaseIfAlreadyOwned)
	else
		v75 = false
	end

	mMovie:__wf_atom_7f57ab2f("DetailedView", "Owned", 13, v75)

	if v75 then
		mMovie:__wf_atom_7d7314f1("DetailedView.Owned.Label.text", "/Lotus/Language/Menu/Crafting_Owned", {
			HOW_MANY = module2.FormatNumber(currInfo.NumOwned)
		})
	end

	if currInfo.RecipesOwned ~= nil then
		local _ = currInfo.RecipesOwned > 0
	end

	local _, v76 = module3.IsXPLocked(currInfo.StoreItem)

	if v76 ~= nil and v76 > 0 then
		local _ignoreXpRequirement = currInfo.IgnoreXpRequirement == true
	end

	if currInfo.Rank ~= nil then
		local _ = currInfo.Rank >= __wf_atom_c67f9605:__wf_atom_a1680b24(currInfo.StoreItemInfo.Type)
	end

	currInfo.StoreItem:__wf_atom_a7f0cb73()
	local v77 = fn48(currInfo)
	local v78 = #v77 > 0
	mMovie:__wf_atom_2dedec1a("DetailedView.TagContainer", 13, v78)

	if v78 then
		local v79 = mDescY - 32 + 10
		local v80 = 0

		for i, v81 in ipairs(v77) do
			v81.SkipTitleCase = true
			v81.Name = string.upper(Localize(v81.Name, {}))
			local priceLabelClip, _ = module6.GetPriceLabelClip(mMovie, "DetailedView", i)
			module6.DrawPriceLabel(mMovie, priceLabelClip, v81)
			mMovie:__wf_atom_2dedec1a(priceLabelClip, 13, true)

			if v81.ShiftX then
				mMovie:__wf_atom_e57658c2(priceLabelClip, 0, v80)
			else
				v79 += 32
			end

			mMovie:__wf_atom_e57658c2(priceLabelClip, 1, v79)
			v80 = math.max(
				mMovie:__wf_atom_5e6e15c8(priceLabelClip, 14),
				mMovie:__wf_atom_cfc41e35(priceLabelClip, "Label", 0) + mMovie:__wf_atom_cfc41e35(priceLabelClip, "Label", 40)
			) + 40
		end

		local v81 = #v77 + 1
		local v82 = "DetailedView.TagContainer.Tag" .. tostring(v81)

		while mMovie:__wf_atom_253d7085(v82) do
			mMovie:__wf_atom_2dedec1a(v82, 13, false)
			v81 += 1
			v82 = "DetailedView.TagContainer.Tag" .. tostring(v81)
		end

		mDescY = v79 + 32 + 16
	end

	local itemDesc = currInfo.ItemDesc
	class.mDescY = mDescY
	class.mDescHeight = 0
	mMovie:__wf_atom_4c1c1986("DetailedView", "OptionsScrollBar", 1, mDescY + 8)
	mMovie:__wf_atom_4c1c1986("DetailedView", "Scrollable", 1, mDescY)
	mMovie:__wf_atom_50d60589("DetailedView.Scrollable.Description", 36, itemDesc)

	if itemDesc ~= "" then
		class.mDescHeight = mMovie:__wf_atom_5e6e15c8("DetailedView.Scrollable.Description", 41)
	end

	local v79 = 0
	mMovie:__wf_atom_7f57ab2f("DetailedView", "AbilityList", 13, v10.mIsSuitCat == true)

	if v10.mIsSuitCat then
		local v80

		if currInfo.StoreItem:IsA(__wf_atom_bf37f5ca) then
			v80 = currInfo.StoreItem:__wf_atom_e622b3f6():GetItem()
		else
			v80 = currInfo.StoreItem:GetItem()
		end

		v57:Populate(v80, false, false, false, true)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("DetailedView", "BelowDescription", 1)
		local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35("DetailedView", "BelowDescription", 0)
		mMovie:__wf_atom_4c1c1986("DetailedView", "AbilityList", 1, __wf_atom_cfc41e35 + v79 + 50)
		mMovie:__wf_atom_4c1c1986(
			"DetailedView",
			"AbilityList",
			0,
			__wf_atom_cfc41e35_2 + v57.mForcedHorizontalSeparation
		)
		v79 += 55
	end

	local mIsSuitCat = v10.mIsSuitCat or v10.mIsWeaponCat or v10.mIsSentinelSuitCat
	v63:SetVisible(mIsSuitCat)

	if mIsSuitCat then
		local avatar = nil
		local v80

		if __wf_atom_7e8ad928(nil) or (nil).StatInfo == nil then
			v80 = Resource(class.mStatItem)
		else
			v80 = module2.Ternary((nil).StatInfo.Weapon == nil, (nil).StatInfo.PowerSuit, (nil).StatInfo.Weapon)
			avatar = (nil).StatInfo.Avatar
		end

		v63:SetType(v80, avatar, true)
		v63.mYOffset = class.mDescHeight + 10
		class.mDescHeight = class.mDescHeight + v63.mHeight + 10
	else
		class.mDescHeight += 5
	end

	mMovie:__wf_atom_7f57ab2f("DetailedView", "BelowDescription.CrewMemberSkills", 13, v73)

	if v73 then
		local __wf_atom_3a3b6501 = crewIconMap:__wf_atom_3a3b6501(
			string.lower(currInfo.CrewMemberInfo.mFaction:c_str()),
			0
		)
		mMovie:__wf_atom_c90af43a("DetailedView.BelowDescription.CrewMemberSkills.Faction", __wf_atom_3a3b6501)
		v58:RunForAllElements(function(p)
			p.Rank = currInfo.CrewMemberInfo:__wf_atom_ba6893d3(p.Skill)
			p.mSkillValues = module11.GetSkillValues(currInfo.CrewMemberInfo, p.Skill)
			v58.mElementDrawCallback(p)
		end)
		mMovie:__wf_atom_7f57ab2f(
			"DetailedView",
			"BelowDescription.CrewMemberSkills.TraitInfo",
			13,
			currInfo.IsEliteCrewMember == true
		)

		if currInfo.IsEliteCrewMember then
			mMovie:__wf_atom_48bd5a59("DetailedView", "BelowDescription.CrewMemberSkills.TraitInfo.Desc", 46, "center")
			local crewMemberTrait = module12.GetCrewMemberTrait(currInfo.CrewMemberInfo.mCrewMemberGeneratedDetails.mSkillUpgrade)
			local v80 = "<font color=\"#Content\"><font size=\"22\" color=\"#FloatingContent\"><b>" .. Localize("/Lotus/Language/Railjack/CrewMgr_Trait", nil) .. "</b></font><br>" .. crewMemberTrait .. "</font>"
			local v81 = module3.ReplaceTextColors(v80, v67)
			mMovie:__wf_atom_48bd5a59(
				"DetailedView",
				"BelowDescription.CrewMemberSkills.TraitInfo.Desc",
				36,
				"<p>" .. v81 .. "</p>"
			)
			v79 += math.max(
				60,
				(mMovie:__wf_atom_cfc41e35("DetailedView", "BelowDescription.CrewMemberSkills.TraitInfo.Desc", 41))
			)
		end

		mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.CrewMemberSkills", 1, v79)
		v79 = v79 + v58:GetHowManyElements() * v58.mForcedVerticalSeparation + 70
	end

	if
		currInfo.IsExternalPlat
		and class:ShouldShowCoupon(currInfo)
		and currInfo.Coupon.mCouponType == 2
		and module5.__wf_atom_a5af4628(currInfo.StoreItem, currInfo.Coupon)
	then
		mMovie:__wf_atom_7f57ab2f("DetailedView", "BelowDescription.BonusCoupon", 13, true)
		mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.BonusCoupon", 1, v79)
		v79 = v79 + mMovie:__wf_atom_cfc41e35("DetailedView", "BelowDescription.BonusCoupon.Bg", 15) + 10
	else
		mMovie:__wf_atom_7f57ab2f("DetailedView", "BelowDescription.BonusCoupon", 13, false)
	end

	v4.PurchaseConfirmY = mDescY + v79 + 10
	mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.PurchaseConfirm", 1, v79)
	mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.Options", 1, v79)
	v64.GiftBtn:SetPosition(nil, v79)
	mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.GiftBonusLabel", 1, v79 + 55)
	local v80 = v79 + v53.CustomizationList:GetHowManyElements() * v53.CustomizationList.mForcedVerticalSeparation
	local v81 = fn44(currInfo)

	if v81 then
		v60:RemoveElements(true, true)

		for i = 1, #currInfo.ParentBundles do
			if currInfo.ParentBundles[i]:__wf_atom_12c87335() then
				v60:AddElement(
					{
						StoreItem = currInfo.ParentBundles[i],
						Info = module5.GetStoreItemInfo(mMovie, currInfo.ParentBundles[i], nil, nil, nil, true)
					},
					true
				)
			end
		end

		if v60:GetHowManyElements() > 0 then
			v60.mButtonWidth = module2.Ternary(v60:GetHowManyElements() > v60.mVisibleElements, 430, 444)
			v60:Redraw()
			mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.ParentBundles", 1, v80)
			local v82 = math.min(#v60.mElements, v60:GetHowManyVisibleElements())
			v80 = v80 + v60.mInitialY + v82 * v60.mForcedVerticalSeparation - 20
		end
	end

	mMovie:__wf_atom_7f57ab2f("DetailedView", "BelowDescription.ParentBundles", 13, v81 and base == v7.BASE)
	local isPackage = currInfo.StoreItem:IsPackage()
	local v82 = fn45(currInfo)
	mMovie:__wf_atom_7f57ab2f("DetailedView", "BelowDescription.Compatible", 13, v82 and base == v7.BASE)

	if v82 then
		mMovie:__wf_atom_7d7314f1(
			"DetailedView.BelowDescription.Compatible.Title.text",
			"/Lotus/Language/Menu/" .. module2.Ternary(
				isPackage,
				"DetailedPurchase_PackageCompatibleGeneric",
				"DetailedPurchase_CompatibleGeneric"
			)
		)
		v61:UpdateInitialY()
		v61:RemoveElements(true, true)

		for i = 1, #currInfo.Compatibles do
			v61:AddElement(
				{
					StoreItem = currInfo.Compatibles[i].StoreItem,
					LocTag = currInfo.Compatibles[i].LocTag,
					Info = module5.GetStoreItemInfo(mMovie, currInfo.Compatibles[i].StoreItem, nil, nil, nil, true)
				},
				true
			)
		end

		v61:Redraw()
		mMovie:__wf_atom_4c1c1986("DetailedView", "BelowDescription.Compatible", 1, v80)
		local v83 = math.min(#v61.mElements, v61:GetHowManyVisibleElements())
		v80 = v80 + v61.mInitialY + v83 * v61.mForcedVerticalSeparation - 20
	end

	if currInfo.ShowCoupon then
		_T.GiftParams.CouponPrice = currInfo.SalePriceInfo.Price
	end

	_T.GiftParams.Price = currInfo.GiftingPrice
	class.PrevContentHeight = nil
	class.ContentHeight = mDescY + v80 + 10

	if v9.HIDE_ITEM_GRID then
		mMovie:__wf_atom_2dedec1a("ItemGrid", 13, false)
		v54.mVisible = false
		v54:RemoveElements(true, true)
	else
		v54.mVisible = isPackage
		local v83 = fn41(currInfo.StoreItem)
		v54:SetCategory(v83)
	end

	v54:Redraw()
	fn15()

	if class.mSkipBase then
		v53.CustomizationList:PressedElement(1)
	else
		class:AdjustToViewport()
	end
end

local function fn50()
	fn42()
	fn39()
	fn34()
	fn36()
	v60 = fn37(
		"DetailedView.BelowDescription.ParentBundles",
		"/Lotus/Language/Menu/DetailedPurchase_ParentBundle",
		"<BUNDLE>"
	)
	v61 = fn37("DetailedView.BelowDescription.Compatible", "/Lotus/Language/Menu/DetailedPurchase_CompatibleGeneric")
	v62 = module8.InitializeSyndicateInfo(mMovie, "DetailedView.SyndicateInfo")
	v62.mWidth = 438
	v62.mIconSize = 64
	v62.mIconBorderSize = 80
end

local function fn51()
	class = {}
	class.mSkipBase = false
	class.ItemTypes = {
		enhancementType = WeakResource("/Lotus/Types/Game/BaseCosmeticEnhancer"),
		arcanePackType = WeakResource("/Lotus/Types/BoosterPacks/EntratiLabsArcanePackBase")
	}
	class.mCategories = { ABOUT = 1, BLUEPRINT = 2, RELATED = 3 }
	fn6(v7.BASE, true)
	mMovie:__wf_atom_2dedec1a("DetailedView", 13, false)
	mMovie:__wf_atom_2dedec1a("Preview", 13, false)
	mMovie:__wf_atom_2dedec1a("LinesTop", 13, false)
	mMovie:__wf_atom_2dedec1a("LinesBottom", 13, false)
	fn50()
	mMovie:__wf_atom_2dedec1a("ItemGrid", 13, false)
	mMovie:__wf_atom_e57658c2("CornerBg", 12, 0)
	mMovie:OverrideMaterial("LinesTop", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("LinesBottom", _G.UIMaterial_VitruvianLines)
	mMovie:SetCallbacks("DetailedView.Wishlist", "WishlistBtnFocused", "WishlistBtnUnfocused", "ToggleWishlist", nil)
	mMovie:__wf_atom_c90af43a("DetailedView.Owned.Icon", _G.UITexture_LabelIcons[module6.LABEL_TYPE_CHECKMARK])
	mMovie:__wf_atom_c90af43a("DetailedView.Mastered.Icon", _G.UITexture_LabelIcons[module6.LABEL_TYPE_MASTERY])
	mMovie:__wf_atom_7d7314f1("DetailedView.Mastered.Label.text", "/Lotus/Language/Menu/DetailedPurchase_Mastered")
	mMovie:__wf_atom_e57658c2("DetailedView.Mastered.Icon", 14, 60)
	mMovie:__wf_atom_e57658c2("DetailedView.Mastered.Icon", 15, 60)
	local v72 = string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/Trade_Tradeable", false))
	mMovie:__wf_atom_50d60589("DetailedView.Tradeable.Label", 36, v72)
	mMovie:__wf_atom_c90af43a("DetailedView.Tradeable.Icon", _G.UITexture_LabelIcons[module6.LABEL_TYPE_TRADEABLE])
	mMovie:__wf_atom_e57658c2("DetailedView.Tradeable.Icon", 14, 20)
	mMovie:__wf_atom_e57658c2("DetailedView.Tradeable.Icon", 15, 20)
	mMovie:__wf_atom_c90af43a(
		"DetailedView.RankLock.Icon",
		_G.UITexture_LabelIcons[module6.LABEL_TYPE_REQUIRED_MASTERY]
	)
	mMovie:__wf_atom_e57658c2("DetailedView.RankLock.Backer", 14, 45)
	mMovie:__wf_atom_e57658c2("DetailedView.RankLock.Backer", 15, 60)
	mMovie:__wf_atom_c90af43a("DetailedView.RecipesOwned.Icon", _G.UITexture_LabelIcons[module6.LABEL_TYPE_RECIPES]);
	(function(items, p)
		for _, item in pairs(items) do
			mMovie:OverrideMaterial("DetailedView." .. item, p)
		end
	end)({ "Scrollable.Description" }, panelTextVisRangeMaterial)
	class.isDisplaying = false
	class.mGenericDiorama = false
	class.mInDioramaMode = false

	function class:GetCurrInfo()
		if __wf_atom_7e8ad928(v10.ITEM) then
			return v10.BLUEPRINT
		end

		return v10.ITEM
	end

	fn35()

	function class:UpdateVisRanges(p)
		local v73 = {
			panelBgVisRangeMaterial,
			panelVisRangeMaterial,
			panelTextVisRangeMaterial,
			panelButtonBgVisRangeMaterial,
			panelAbilitySparkleVisRangeMaterial
		}
		local visibilityCenter = module2.GetVisibilityCenter(mMovie, self.mInitialContentY + p / 2)
		local visibilitySize = module2.GetVisibilitySize(mMovie, p)
		local visibilityFadeSize = module2.GetVisibilityFadeSize(mMovie, 0.01)

		for _, v74 in ipairs(v73) do
			v74:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			v74:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			v74:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
		end

		if not __wf_atom_7e8ad928(v54) then
			v54:UpdateVisRanges()
		end

		if not __wf_atom_7e8ad928(v57) then
			v57:UpdateVisRanges()
		end
	end

	function class.IsShowing(p)
		return p.isDisplaying
	end

	function class:SetDiorama(genericDiorama2, p)
		mMovie:__wf_atom_290807ee("Tip")
		mMovie:__wf_atom_e57658c2("Tip", 12, 0)

		if __wf_atom_7e8ad928(nil) or not self.mInDioramaMode and genericDiorama2 == nil then
			return
		end

		local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()
		local v73

		if genericDiorama2 == nil then
			if _T.InSyndicateScreen and v49.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
				_T.ShowBackground(0, nil, false)
			end

			__wf_atom_8e4fda44:__wf_atom_62a19abc()
			v73 = v38
			v38 = nil
		else
			(nil):__wf_atom_2f528a47()

			if
				genericDiorama2:IsA(__wf_atom_cb425ff5)
				and not (nil):__wf_atom_8709643b(gameData, genericDiorama2, v16, p)
			then
				genericDiorama2 = genericDiorama
			end

			if not genericDiorama2:IsA(__wf_atom_cb425ff5) then
				(nil).mDioramaLoader:LoadDioramaEx({ genericDiorama2:__wf_atom_5b41f63b() }, false)
			end

			fn = function()
				local __wf_atom_e1466993, weapon, powerSuit = (nil):__wf_atom_e1466993()

				if not __wf_atom_7e8ad928(__wf_atom_e1466993) then
					(nil).StatInfo = {
						Avatar = __wf_atom_e1466993,
						Weapon = weapon,
						PowerSuit = powerSuit
					}
				end
			end

			v73 = 0

			if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
				v38 = __wf_atom_2ad5cd23:__wf_atom_9b8947bc()
			end
		end

		self.mGenericDiorama = genericDiorama2 ~= nil and genericDiorama2:IsA(genericDiorama)
		self.mInDioramaMode = genericDiorama2 ~= nil

		if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
			__wf_atom_2ad5cd23:__wf_atom_e57658c2("_root", 12, module2.Ternary(self.mInDioramaMode, 0, 100))

			if v73 ~= nil then
				__wf_atom_2ad5cd23:__wf_atom_0cf0fdbe(v73)
			end
		end
	end

	function class.CanGiftItem(data, object)
		if __wf_atom_c67f9605:__wf_atom_6d03a710() or object and not object:__wf_atom_12c87335() then
			return false
		end

		local hasRegularPrice = module2.Ternary(
				data.CanGiftOverride ~= nil,
				data.CanGiftOverride,
				object:__wf_atom_770d56ae()
			)
			and data.HasRegularPrice

		if hasRegularPrice then
			if data.RegularPriceInfo == nil then
				hasRegularPrice = false
			else
				hasRegularPrice = data.RegularPriceInfo.IsPremium
			end
		end

		local v73 = module3.CheckSteamPurchaseAvailability(object)

		if v73 == "MARKET" then
			hasRegularPrice = true
		elseif v73 == "EXTERNAL" then
			hasRegularPrice = false
		end

		if canGiftCheck ~= nil then
			hasRegularPrice = hasRegularPrice and canGiftCheck()
		end

		if not hasRegularPrice then
			return hasRegularPrice
		end

		local ternary = module2.Ternary(Engine.__wf_atom_578fc9dd(), 5, 2)

		if not __wf_atom_7e8ad928(gameData) then
			return ternary <= gameData:__wf_atom_a04e4a53()
		end

		hasRegularPrice = false
		return false
	end

	function class:CanMultiPurchaseItem(data)
		if data.AllowMultiPurchase == false then
			return false
		end

		local storeItem = data.StoreItem

		if __wf_atom_7e8ad928(storeItem) or data.ShowCoupon or storeItem:__wf_atom_bc269564() then
			return false
		end

		if storeItem:IsPackage() then
			local __wf_atom_72915748 = storeItem:__wf_atom_72915748()

			if #__wf_atom_72915748 == 0 then
				return false
			end

			for i = 1, #__wf_atom_72915748 do
				if not self:CanMultiPurchaseItem({ StoreItem = __wf_atom_72915748[i].mTypeName }) then
					return false
				end
			end

			return true
		else
			local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()
			local item = storeItem:GetItem()
			local v73

			if
				__wf_atom_efa6f447 == 2
				or __wf_atom_efa6f447 == 11
				or __wf_atom_efa6f447 == 17
				or __wf_atom_efa6f447 == 35
				or __wf_atom_efa6f447 == 30
				or __wf_atom_efa6f447 == 13
				or __wf_atom_efa6f447 == 19
				or __wf_atom_efa6f447 == 4
				and not __wf_atom_7e8ad928(item)
				and (item:IsA(v19) or item:IsA(class.ItemTypes.enhancementType) or item:IsA(class.ItemTypes.arcanePackType))
			then
				v73 = module3.CanPurchaseIfAlreadyOwned(storeItem)
			elseif __wf_atom_efa6f447 == 12 then
				v73 = not (__wf_atom_7e8ad928(item) or item:IsA(v20))

				if v73 then
					v73 = module3.CanPurchaseIfAlreadyOwned(storeItem)
				end
			else
				v73 = false
			end

			if not __wf_atom_7e8ad928(item) then
				v73 = v73 and not item:IsA(shipDecorationLayerItem)
			end

			if storeItem:__wf_atom_56c51289() > 0 or Engine.__wf_atom_6f25c160() and storeItem:__wf_atom_836b9069() then
				return false
			end

			return v73
		end
	end

	function class:ConfigureMultiPurchase()
		if v42 and self:CanMultiPurchaseItem(self.SelectedElement) and not __wf_atom_7e8ad928(gGameData) then
			local flag4 = false

			local function fn52(p)
				if flag4 then
					v29 = math.min(v29, p)
					return
				end

				v29 = p
				flag4 = true
			end

			if self.SelectedElement.HasRegularPrice then
				fn52(math.floor(module2.Ternary(
					self.SelectedElement.RegularPriceInfo.IsPremium,
					gGameData:__wf_atom_330e9cb9(),
					gGameData:__wf_atom_7050e489()
				) / self.SelectedElement.RegularPriceInfo.Price))
			end

			if self.SelectedElement.HasSpecialPrice then
				if self.SelectedElement.ItemPrices == nil then
					if self.SelectedElement.SpecialPriceInfo.Price ~= 0 then
						local syndicateTag = self.SelectedElement.SyndicateTag

						if not __wf_atom_7e8ad928(syndicateTag) and syndicateTag:__wf_atom_8598f3a9() then
							local _, v73 = module3.GetReputationInfoForSyndicate(__wf_atom_c67f9605:__wf_atom_13d5b7e9(syndicateTag))
							fn52(math.floor(v73 / self.SelectedElement.SpecialPriceInfo.Price))
						elseif self.SelectedElement.SpecialPriceIconTag == "<PRIME_BUCKS>" then
							fn52(math.floor(gGameData:__wf_atom_5727c53b() / self.SelectedElement.SpecialPriceInfo.Price))
						elseif self.SelectedElement.SpecialPriceIconTag == "<PRIME_TOKEN>" then
							fn52(math.floor(gGameData:__wf_atom_edca9dbf() / self.SelectedElement.SpecialPriceInfo.Price))
						end
					end
				else
					for _, itemPrice in ipairs(self.SelectedElement.ItemPrices) do
						local v73 = math.floor(itemPrice.NumOwned / itemPrice.mItemCount)

						if
							__wf_atom_7e8ad928(self.SelectedElement.PurchaseCapCount)
							or not (self.SelectedElement.PurchaseCapCount < v73)
						then
							fn52(v73)
						else
							fn52(self.SelectedElement.PurchaseCapCount)
						end
					end
				end
			end

			v29 = __wf_atom_421b01aa(v29, 1, 9999999)
			v30 = math.min(v29, 1)
			v28.mInputField:SetText((tostring(v30)))
			fn3(true)
		end
	end

	function class:GetPriceTagLong(data, p)
		local v73 = (p == nil or p <= 0) and 1 or p
		local v74 = true
		local PRICE

		if data.HasRegularPrice then
			PRICE = data.RegularPriceInfo.CurrencyText .. " " .. module2.FormatNumber(data.RegularPriceInfo.Price * v73)
		end

		local v76

		if data.HasSpecialPrice then
			v76 = data.SpecialPriceInfo.CurrencyText .. " " .. module2.FormatNumber(data.SpecialPriceInfo.Price * v73)
		end

		local v77

		if data.ItemPrices ~= nil then
			v77 = ""

			for i = 1, #data.ItemPrices do
				local itemPrice = data.ItemPrices[i]
				local v78 = fn18(itemPrice.mItemType)

				if __wf_atom_7e8ad928(v78) then
					continue
				end

				local binarySearch = module3.BinarySearch(v13, itemPrice.mItemType:__wf_atom_5b41f63b(), function(p2)
					if p2 then
						return p2.type
					end

					return nil
				end)
				local v79 = 0

				if binarySearch then
					for j = binarySearch[1], binarySearch[2] do
						if v13[j].count then
							v79 += v13[j].count
						else
							v79 = math.min(v79 + 1, 1)
						end
					end
				end

				if not __wf_atom_7e8ad928(_T.MidMissionVendorPurchaseAction) then
					v79 += _T.MidMissionVendorPurchaseAction:__wf_atom_20354a72(itemPrice.mItemType)
				end

				local c_str = module5.GetStoreItemTag(v78):c_str()
				local v80 = StringSplit("/", c_str)
				local v81 = v80[#v80]

				if string.len(v81) > 0 then
					local v82 = "<" .. string.upper(v81) .. ">"
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v82, true)

					if __wf_atom_8e9ac384 ~= v82 then
						v77 ..= __wf_atom_8e9ac384
					end
				end

				local v82 = itemPrice.mItemCount * v73
				local v83 = itemPrice.mItemType:IsA(__wf_atom_58a409f1) or v82 <= v79
				v74 = v74 and v83

				if not v83 then
					v77 ..= "<font color=\"" .. v67.FloatingContentHighlightHex .. "\">" .. mMovie:__wf_atom_8e9ac384("<PROBLEM>", true) .. " </font>"
				end

				local v84 = v77 .. "<b>"

				if not itemPrice.mItemType:IsA(__wf_atom_58a409f1) then
					v84 ..= module2.FormatNumber(v79) .. "/"
				end

				v77 = v84 .. module2.FormatNumber(v82) .. "</b> " .. TitleCase(mMovie:__wf_atom_8e9ac384(c_str, false))

				if i ~= #data.ItemPrices then
					v77 ..= "<br>"
				end
			end
		end

		local price

		if data.IsReward then
			price = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_RankUpRedeemConfirm", false)
		elseif v77 == nil then
			local price2

			if PRICE == nil or v76 == nil then
				price2 = module2.Ternary(PRICE ~= nil, PRICE, v76)
			else
				price2 = PRICE .. " + " .. v76
			end

			if data.IsExternalProduct then
				if data.SalePriceInfo.Price == nil or data.SalePriceInfo.Price == 0 and not data.ConsoleSale then
					if
						Engine.__wf_atom_84bb79c2()
						or Engine.__wf_atom_2a979d69()
						or data.RegularPriceInfo.Price ~= 0 and data.HasRegularPrice
					then
						local v80 = data.RegularPriceInfo.CurrencyText .. " " .. data.RegularPriceInfo.PriceText
						price = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_PurchaseConfirm",
							false,
							{ PRICE = __wf_atom_0a63ecce(v80) }
						)
					else
						price = ""
					end
				else
					price = data.RegularPriceInfo.CurrencyText .. " " .. data.RegularPriceInfo.PriceText

					if data.EpicSale then
						price = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_PurchaseDiscountConfirm",
							false,
							{
								DISCOUNT = module2.FormatNumber(data.SalePriceInfo.Discount),
								PRICE = price
							}
						)
					elseif data.ShowSale and v70 and data.HasRegularPrice then
						price = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_PurchaseDiscountConfirm",
							false,
							{
								DISCOUNT = module2.FormatNumber(data.SalePriceInfo.Discount * 100),
								PRICE = price
							}
						)
					elseif data.ConsoleSale and data.SalePriceInfo.Discount > 0 then
						price = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_PurchaseDiscountConfirm",
							false,
							{
								DISCOUNT = module2.FormatNumber(data.SalePriceInfo.Discount * 100),
								PRICE = price
							}
						)
					elseif
						not __wf_atom_7e8ad928(data.Coupon)
						and (__wf_atom_7e8ad928(data.Coupon.mCouponType) or data.Coupon.mCouponType == 0)
					then
						price = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_PurchaseDiscountConfirm",
							false,
							{
								DISCOUNT = module2.FormatNumber(data.Coupon.mAmount * 100),
								PRICE = price
							}
						)
					end
				end
			elseif data.SalePriceInfo.Price == nil then
				local priceTagOverride = data.PriceTagOverride or class.SelectedElement.PurchaseConfirmTag

				if priceTagOverride == nil then
					priceTagOverride = "/Lotus/Language/Menu/" .. module2.Ternary(
						self.IsGifting,
						"DetailedPurchase_GiftConfirm",
						"DetailedPurchase_PurchaseConfirm"
					)
				end

				price = mMovie:__wf_atom_8e9ac384(priceTagOverride, false, { PRICE = price2 })
			else
				local ternary = module2.Ternary(
					self.IsGifting,
					"DetailedPurchase_GiftDiscountConfirm",
					"DetailedPurchase_PurchaseDiscountConfirm"
				)
				price = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/" .. ternary, false, {
					DISCOUNT = module2.FormatNumber(data.SalePriceInfo.Discount * 100),
					PRICE = price2
				})
			end
		elseif PRICE == nil then
			price = mMovie:__wf_atom_8e9ac384(
				data.PriceTagOverride or "/Lotus/Language/Menu/DetailedPurchase_PurchaseItemPricesConfirm",
				false,
				{ PRICE = v77 }
			)
		else
			price = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_PurchaseMixedConfirm", false, {
				PRICE1 = PRICE,
				PRICE2 = v77
			})
		end

		v28.mPurchaseBtn.mActiveAlpha = module2.Ternary(v74, 100, 30)
		mMovie:__wf_atom_e57658c2(v28.mPurchaseBtn.mClipName, 12, v28.mPurchaseBtn.mActiveAlpha)
		return "<p><font color=\"" .. v67.ContentHex .. "\">" .. price .. "</font></p>"
	end

	function class:GetPriceTagShort(data)
		local v73 = not data.HasRegularPrice and ""
			or data.RegularPriceInfo.CurrencyText .. " " .. data.RegularPriceInfo.PriceText

		if data.ItemPrices == nil and not data.HasSpecialPrice then
			return __wf_atom_0a63ecce(v73)
		end

		if v73 ~= "" then
			v73 ..= " + "
		end

		if data.ItemPrices == nil then
			v73 ..= data.SpecialPriceInfo.CurrencyText .. " " .. data.SpecialPriceInfo.PriceText
		else
			local count = #data.ItemPrices

			if count > 1 then
				local v74 = "/Lotus/Language/Menu/" .. module2.Ternary(
					count == 1,
					"DetailedPurchase_ItemPrice",
					"DetailedPurchase_ItemPrices"
				)
				v73 ..= mMovie:__wf_atom_8e9ac384(v74, false, { NUM = count })
			else
				local itemPrice = data.ItemPrices[1]
				local v74 = fn18(itemPrice.mItemType)
				local v75 = __wf_atom_7e8ad928(v74) and "" or module5.GetLocalizedItemName(mMovie, v74)
				v73 ..= module2.FormatNumber(itemPrice.mItemCount) .. " " .. TitleCase(v75)
			end
		end

		return __wf_atom_0a63ecce(v73)
	end

	function class:UpdatePurchasePanel()
		v53.CustomizationList:RemoveElements(true, true)
		local v73

		if v10.ITEM == nil then
			v73 = false
		elseif v10.BLUEPRINT == nil then
			v73 = true
		elseif v10.BLUEPRINT.ItemPrices == nil then
			v73 = not v10.BLUEPRINT.HasSpecialPrice
		else
			v73 = false
		end

		local mCanPurchase = false
		local showInfoPopup = true
		local v75 = nil
		local v76 = false
		local v77 = false

		if v10.ITEM ~= nil and v10.ITEM.StoreItem ~= nil then
			local saleInfo = module3.GetSaleInfo(v10.ITEM.StoreItem)

			if not __wf_atom_7e8ad928(saleInfo) and saleInfo.mHideFromMarket then
				v73 = false
			end
		end

		if v73 then
			local priceTagShort = self:GetPriceTagShort(v10.ITEM)
			local v78 = false
			local item = v10.ITEM
			local mCanPurchase2
			mCanPurchase2, v76, v75 = self:UpdatePurchaseButton(v10.ITEM)
			item.mCanPurchase = mCanPurchase2
			v77 = self.CanGiftItem(v10.ITEM, v10.ITEM.StoreItem)

			if v75 ~= nil then
				if v10.ITEM.mCanPurchase then
					priceTagShort ..= " " .. v75
				else
					v78 = v75 == "/Lotus/Language/Menu/Store_Owned"
					v75 = mMovie:__wf_atom_8e9ac384("<LOCKED>", true) .. mMovie:__wf_atom_8e9ac384(v75, true)
				end
			end

			if v10.ITEM.StoreItem ~= nil then
				local __wf_atom_efa6f447 = v10.ITEM.StoreItem:__wf_atom_efa6f447()
				showInfoPopup = __wf_atom_efa6f447 == 3
					or __wf_atom_efa6f447 == 1
					or __wf_atom_efa6f447 == 0
					or __wf_atom_efa6f447 == 5
					or __wf_atom_efa6f447 == 15
					or __wf_atom_efa6f447 == 16
					or __wf_atom_efa6f447 == 27
					or __wf_atom_efa6f447 == 28
					or __wf_atom_efa6f447 == 29
					or __wf_atom_efa6f447 == 39
					or __wf_atom_efa6f447 == 37
			end

			mCanPurchase = v10.ITEM.mCanPurchase or priceTagShort ~= ""

			if mCanPurchase then
				v65.Regular = v75
				local ternary = module2.Ternary(v10.ITEM.mCanPurchase, fn22, fn24)
				local title = "/Lotus/Language/Menu/" .. module2.Ternary(
					priceTagShort == "",
					"DetailedPurchase_AboutTab",
					"Global_BuyItem"
				)
				local v81 = {
					Type = module13.Types.BUTTON,
					BigButton = true,
					IsPurchase = true,
					SelectedSoundOverride = module2.Ternary(v10.ITEM.mCanPurchase, nil, _G.UISound_Error),
					DefaultIcon = module2.Ternary(priceTagShort == "", optionListTextures[4], optionListTextures[1]),
					DefaultIconWidth = 0.95,
					DefaultIconHeight = 0.95,
					DefaultIconAlpha = 100,
					NameTag = priceTagShort,
					StoreItem = v10.ITEM.StoreItem,
					IngredientOverride = v10.ITEM.IngredientOverride,
					Title = title,
					mOnPressedCallback = ternary,
					mOverrideWidth = module2.Ternary(v77, 380, nil)
				}
				local infoPopupInfo = {
					Rank = v10.ITEM.Rank,
					HideAbilities = true,
					HideStats = true
				}

				if v78 then
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Store/ItemAlreadyOwnedDesc",
						false
					)

					if showInfoPopup then
						infoPopupInfo.MergeDesc = __wf_atom_8e9ac384
					else
						showInfoPopup = true
						infoPopupInfo = { CustomEntry = true, LocalizedDesc = __wf_atom_8e9ac384 }
					end

					if v10.ITEM.ShowCoupon or v10.ITEM.ShowSale then
						v81.Title = v75
					else
						v81.NameTagRight = v75
						v81.NameTagRightMatchesDescY = true
					end

					v81.NameAlpha = 50
					v81.DescAlpha = 50
				end

				v81.ShowInfoPopup = showInfoPopup
				v81.InfoPopupInfo = infoPopupInfo
				v53.CustomizationList:AddElement(v81, true)
			end
		end

		mMovie:__wf_atom_2dedec1a("DetailedView.Wishlist", 13, v76 or v73 and v10.ITEM.CurrInWishlist)
		local v78

		if v10.BLUEPRINT == nil then
			v78 = false
		else
			v78 = not __wf_atom_7e8ad928(v10.BLUEPRINT.StoreItem)
		end

		if v78 then
			local priceTagShort = self:GetPriceTagShort(v10.BLUEPRINT)
			local v79 = false
			local mOnPressedCallback

			if
				v10.BLUEPRINT.StoreItem:ShowInMarket()
				or v10.BLUEPRINT.HasRegularPrice
				or v10.BLUEPRINT.HasSpecialPrice
				or v10.BLUEPRINT.IsReward
			then
				local blueprint = v10.BLUEPRINT
				local mCanPurchase2, _
				mCanPurchase2, _, v75 = self:UpdatePurchaseButton(v10.BLUEPRINT)
				blueprint.mCanPurchase = mCanPurchase2

				if v75 ~= nil then
					if v10.BLUEPRINT.mCanPurchase then
						priceTagShort ..= " " .. v75
					else
						v79 = v75 == "/Lotus/Language/Menu/Store_Owned"
						v75 = mMovie:__wf_atom_8e9ac384("<LOCKED>", true) .. mMovie:__wf_atom_8e9ac384(v75, true)
					end
				end

				v65.Bp = v75
				mOnPressedCallback = module2.Ternary(v10.BLUEPRINT.mCanPurchase, fn23, fn25)
			else
				priceTagShort = "/Lotus/Language/Menu/DetailedPurchase_BpAbout"
			end

			local v81 = {
				Type = module13.Types.BUTTON,
				BigButton = true,
				IsBlueprint = true,
				DefaultIcon = optionListTextures[2],
				DefaultIconWidth = 0.95,
				DefaultIconHeight = 0.95,
				DefaultIconAlpha = 100,
				NameTag = priceTagShort,
				StoreItem = v10.BLUEPRINT.StoreItem,
				HelpText = v10.BLUEPRINT.HelpText,
				FreeSlots = v10.BLUEPRINT.FreeSlots,
				InfoPopupInfo = { Rank = v10.BLUEPRINT.Rank },
				Title = "/Lotus/Language/Menu/DetailedPurchase_RecipeShortcut",
				mOnPressedCallback = mOnPressedCallback
			}

			if v79 then
				v81.InfoPopupInfo.MergeDesc = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Store/ItemAlreadyOwnedDesc",
					false
				)
				v81.NameTagRight = v75
				v81.NameTagRightMatchesDescY = true
				v81.NameAlpha = 50
				v81.DescAlpha = 50
			end

			v53.CustomizationList:AddElement(v81, true)
		end

		local color = module7.GetColor(10, true)
		local mHighlightAlwaysVis

		if v77 and not __wf_atom_7e8ad928(v16) then
			mHighlightAlwaysVis = not __wf_atom_7e8ad928(v16:__wf_atom_51fc44cc(v10.ITEM.StoreItem))
		else
			mHighlightAlwaysVis = false
		end

		v64.GiftBtn:SetVisible(v77)
		v64.GiftBtn.mHighlightAlwaysVis = mHighlightAlwaysVis
		v64.GiftBtn.mUnfocusedColor = module2.Ternary(mHighlightAlwaysVis, color, nil)
		v64.GiftBtn:Redraw()
		mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.GiftBonusLabel", 13, v77 and mHighlightAlwaysVis)

		if v66.CanToggleCurrencyBar then
			if v77 or v10.ITEM and v10.ITEM.mCanPurchase or v10.BLUEPRINT and v10.BLUEPRINT.mCanPurchase then
				if not (_T.UIInputEnabled or __wf_atom_7e8ad928(_T.EnableUIInput)) then
					_T.EnableUIInput()
				end
			elseif _T.UIInputEnabled and not __wf_atom_7e8ad928(_T.DisableUIInput) then
				_T.DisableUIInput()
			end
		end

		v53.CustomizationList:Redraw()
		local currInfo = self:GetCurrInfo()
		local v80 = fn44(currInfo)
		local v81 = fn45(currInfo)

		if
			mCanPurchase
			and not showInfoPopup
			and v53.CustomizationList:GetHowManyElements() == 1
			and not (v64.GiftBtn.mIsVisible or v80 or v81)
		then
			return true
		end

		return false
	end

	function class:UpdatePurchaseButton(data)
		if data == nil or data.StoreItem == nil then
			return
		end

		if not data.StoreItem:__wf_atom_12c87335() then
			return false, false, "/Lotus/Language/Store/UnavailableOnPlatform"
		end

		if data.StoreItem:IsPackage() then
			local __wf_atom_72915748 = data.StoreItem:__wf_atom_72915748()

			for i = 1, #__wf_atom_72915748 do
				if not (__wf_atom_7e8ad928(__wf_atom_72915748[i].mTypeName) or __wf_atom_72915748[i].mTypeName:__wf_atom_12c87335()) then
					return false, false, "/Lotus/Language/Store/UnavailableOnPlatform"
				end
			end
		end

		local v73 = nil
		local v74 = not __wf_atom_7e8ad928(data.StoreItem) and data.StoreItem:ShowInMarket()
		local hasRegularPrice, hasSpecialPrice, v75

		if data.CanPurchaseOverride == nil or data.CanPurchaseOverride ~= false then
			hasRegularPrice = not data.IsExternalProduct and data.HasRegularPrice
			hasSpecialPrice = not data.IsExternalProduct and data.HasSpecialPrice
			local v76 = module3.CheckSteamPurchaseAvailability(data.StoreItem)
			local __wf_atom_a8366d8a = module3.__wf_atom_a8366d8a(data.StoreItem)

			if module3.GetProductId(data.StoreItem) == "" then
				v75 = false
			else
				v75 = Engine.__wf_atom_84bb79c2()
					or Engine.__wf_atom_2a979d69()
					or v76 == "EXTERNAL"
					or __wf_atom_a8366d8a == "EXTERNAL"
					or data.IsExternalProduct and not data.StoreItem:__wf_atom_955f7fe0()
			end
		else
			hasRegularPrice = false
			hasSpecialPrice = false
			v75 = false
		end

		local isReward = data.IsReward or hasRegularPrice or hasSpecialPrice or v75

		if v74 then
			if hasRegularPrice or v75 then
				v75 = data.ItemPrices == nil
			end
		else
			v75 = v74
		end

		if not isReward then
			return isReward, v75, v73
		end

		local isXPLocked, _ = module3.IsXPLocked(data.StoreItem)
		local ignoreXpRequirement

		if __wf_atom_7e8ad928(data.IgnoreXpRequirement) then
			ignoreXpRequirement = false
		else
			ignoreXpRequirement = data.IgnoreXpRequirement
		end

		local v76 = not data.IsLocked

		if isXPLocked and not ignoreXpRequirement then
			v76 = false
			v73 = "/Lotus/Language/Menu/Item_CannotPurchaseXPLocked"
		end

		local v77 = data.StoreItem:__wf_atom_efa6f447() == 26
		local total2

		if v77 or not data.StoreItem:IsPackage() then
			total2 = 1
		else
			local __wf_atom_72915748 = data.StoreItem:__wf_atom_72915748()
			total2 = 0

			for i = 1, #__wf_atom_72915748 do
				if
					__wf_atom_7e8ad928(__wf_atom_72915748[i].mTypeName)
					or __wf_atom_72915748[i].mTypeName:__wf_atom_efa6f447() ~= 26
				then
					continue
				end

				total2 += __wf_atom_72915748[i].mPurchaseQuantity
				v77 = true
			end
		end

		if v77 and #gGameData:GetInventory():__wf_atom_90d72e37() + total2 > 200 then
			v73 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/GeneticLab/ImprintCreatorMaxImprints", false, {
				COUNT = module2.FormatNumber(200)
			})
			v76 = false
		end

		if
			v76
			and (not data.CanPurchaseIfAlreadyOwned or v10.mExternalProductPurchased or not __wf_atom_7e8ad928(data.StoreItem:GetItem()) and data.StoreItem:GetItem():IsA(shipDecorationLayerItem))
			and (data.NumOwned >= 1 or gGameData:__wf_atom_472bcc03(module3.GetProductId(data.StoreItem)))
		then
			v76 = false
			v75 = false
			v73 = "/Lotus/Language/Menu/Store_Owned"
		end

		if canPurchaseCheck ~= nil and v76 then
			local v78, v79 = canPurchaseCheck()

			if not v78 then
				v73 = v79
				v76 = false
			end
		end

		if __wf_atom_c67f9605:__wf_atom_6d03a710() then
			v76 = false
			v73 = "/Lotus/Language/Menu/DetailedPurchase_NewBuild_Short"
		end

		if (v76 or data.IsLocked) and data.PurchaseBtnTag ~= nil then
			v73 = mMovie:__wf_atom_8e9ac384(data.PurchaseBtnTag, false)
		end

		return
			v76,
			v75,
			not v76 and not data.StoreItem:ShowInMarket() and #data.ParentBundles > 0 and not data.Sale and "/Lotus/Language/Menu/Arsenal_BundleOnly" or v73
	end

	function class:RefreshExpiryTime(p, p2)
		if p2 <= 0 then
			module2.ShowMessage("/Lotus/Language/Menu/Store_Expired", "TransitionOut")
			v46 = true
		elseif p ~= nil then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Expires", false)
			mMovie:__wf_atom_7d7314f1(
				p .. ".ExpiryTag.text",
				__wf_atom_8e9ac384 .. ": <BUILD_TIME>" .. module3.GetTwitterStyleTime(p2)
			)
		end
	end

	function class:Show(_)
		flag = true
		self.isDisplaying = true
		local item = nil
		local storeItem = nil
		local v73 = {}

		if v10.ITEM == nil or v10.ITEM.StoreItem == nil then
			if v10.BLUEPRINT ~= nil and v10.BLUEPRINT.StoreItem ~= nil then
				item = v10.BLUEPRINT.StoreItem:GetItem()
				storeItem = v10.BLUEPRINT.StoreItem
			end
		else
			item = v10.ITEM.StoreItem:GetItem()
			storeItem = v10.ITEM.StoreItem
			v73 = {
				ModularInfo = v10.ITEM.ModularInfo,
				CrewMemberInfo = v10.ITEM.CrewMemberInfo,
				IsEliteCrewMember = v10.ITEM.IsEliteCrewMember
			}
		end

		if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_3cecff09) then
			item = storeItem:__wf_atom_c5566ef8()
		end

		local v74 = module5.CanShowDiorama(storeItem) and not v9.FORCE_GENERIC_DIO
		local ternary = module2.Ternary(v74, storeItem, genericDiorama)
		local __wf_atom_c70d9c6f = gameData:__wf_atom_c70d9c6f()

		if self.mInMuseum then
			ternary = fn38(storeItem)
		elseif v9.VENDOR_MODE then
			ternary = nil
		elseif not __wf_atom_7e8ad928(__wf_atom_c70d9c6f) then
			for _, v75 in ipairs(__wf_atom_c70d9c6f) do
				if storeItem:__wf_atom_5b41f63b() == v75.mStoreItem then
					ternary = module2.Ternary(false, storeItem, genericDiorama)
				end
			end
		end

		self:SetDiorama(ternary, v73)
		local v75 = not __wf_atom_7e8ad928(storeItem:GetItem()) and storeItem:GetItem():IsA(__wf_atom_5a036296)

		if storeItem:IsPackage() and not v75 then
			local __wf_atom_72915748 = storeItem:__wf_atom_72915748()

			for i = 1, #__wf_atom_72915748 do
				if __wf_atom_7e8ad928(__wf_atom_72915748[i].mTypeName) then
					continue
				end

				local item2 = __wf_atom_72915748[i].mTypeName:GetItem()

				if __wf_atom_7e8ad928(item2) or not item2:IsA(__wf_atom_5a036296) then
					continue
				end

				v75 = true
				break
			end
		end

		local v76 = storeItem:__wf_atom_955f7fe0() and not __wf_atom_7e8ad928(tennoGenWatermark)
		mMovie:__wf_atom_2dedec1a("Watermark", 13, v76)

		if v76 then
			mMovie:__wf_atom_933bbce0("Watermark", tennoGenWatermark, tennoGenWatermarkMaterial)
		end

		local function fn52()
			local v77 = 0

			if __wf_atom_7e8ad928(_T.ShowBackground) or not self.mGenericDiorama and self.mInDioramaMode then
				if self.mInDioramaMode then
					mMovie:__wf_atom_0cf0fdbe(0.99)
				end

				if not _T.InSyndicateScreen then
					_T.HideBackground()
				end

				v77 = 100
			else
				local v78 = v9.VENDOR_MODE and { Center = 0, Size = 1.075, FadeSize = 0.2 } or nil
				_T.ShowBackground(0.25, nil, nil, v78)
			end

			__wf_atom_ec43d06e(mMovie, "CornerBg", 8, { 12 }, { v77 }, 0.2, nil)
		end

		if not v75 then
			fn52()
		end

		local allowMuseum = not (self.mInMuseum or __wf_atom_7e8ad928(fn38(storeItem)))
			and (v9.ITEM.AllowMuseum or v9.ITEM.CodexMode)
		v54.HeightPadding = 250

		if allowMuseum then
			local _, v77 = module2.GetScreenDimensions(mMovie)
			v54.HeightPadding = 320
			v54.Height = v77 - v54.HeightPadding
			module6.InitializeGridItem(mMovie, v54)

			if __wf_atom_7e8ad928(v54.mScrollBar) then
				v54:AttachScrollBar("ItemGrid.ScrollBar", -25)
				v54:EnableSmoothScroll()
			else
				v54.mScrollBar.mHeight = v54:CalculateScrollBarHeight(-25)
			end

			v54:Redraw()
		end

		v64.MuseumBtn:SetVisible(allowMuseum)
		mMovie:__wf_atom_2dedec1a("CornerBg", 13, not self.mInMuseum)
		mMovie:__wf_atom_2dedec1a("DetailedView", 13, false)
		mMovie:__wf_atom_e57658c2("DetailedView", 12, 0)
		local v77 = v14
		loader = nil
		v14 = nil

		if not storeItem:IsPackage() then
			if __wf_atom_7e8ad928(item) then
				if v10.ITEM ~= nil and v10.ITEM.Song ~= nil then
					if v77 == nil then
						v14 = module16.CreateStepSequencerLoader()
					else
						v14 = v77
					end

					module16.ResLoadNotePacks(v14, v10.ITEM.Song.NotePackInfo, v10.ITEM.Song.FingerPrint)
					loader = v14.Loader
				end
			elseif item:IsA(__wf_atom_9eddfa99) then
				if v77 == nil then
					v14 = module16.CreateStepSequencerLoader()
				else
					v14 = v77
				end

				module16.ResLoadNotePacks(v14, {
					{ NoteType = 3, NotePack = item }
				}, item)
				loader = v14.Loader
			else
				loader = UISys.__wf_atom_c0dbe47c({ item:__wf_atom_5b41f63b() }, true)
			end
		end

		if v77 ~= nil and v14 == nil and not __wf_atom_7e8ad928(v77.StepSequencer) then
			v77.StepSequencer:SetPaused(true)

			if not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ItemBrowsingMovie) then
				local entity = module2.GetEntityFromTag("LisetSoundsFadeIn")

				if not __wf_atom_7e8ad928(entity) then
					entity:FirePort("Execute")
				end
			end
		end

		local v78 = false
		local function fn53()
			if
				(loader == nil or loader:__wf_atom_86399a47())
				and (v14 == nil or module16.UpdateStepSequencer(v14) ~= false)
				and (__wf_atom_7e8ad928(nil) or not (nil).mDioramaLoader:IsLoading())
			then
				item = Resource(item)
				self.mStatItem = item

				if
					v78
					or __wf_atom_7e8ad928(item)
					or not item:IsA(__wf_atom_16cdad3a)
					or __wf_atom_7e8ad928(v56)
					or __wf_atom_7e8ad928(v10.ITEM.UpgradeFingerprint)
					or not module4.IsCardOmega({ mArtifactUpgrade = item })
				then
					v66.PanelLoading = false

					if v14 ~= nil and not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ItemBrowsingMovie) then
						local entity = module2.GetEntityFromTag("LisetSoundsFadeOut")

						if not __wf_atom_7e8ad928(entity) then
							entity:FirePort("Execute")
						end
					end

					module2.PlaySound(transitionInSound)
					local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()

					if __wf_atom_efa6f447 == 13 then
						__wf_atom_efa6f447 = storeItem:__wf_atom_d4d67b38()
					end

					v10.mIsWeaponCat = __wf_atom_efa6f447 == 0
						or __wf_atom_efa6f447 == 1
						or __wf_atom_efa6f447 == 5
						or __wf_atom_efa6f447 == 28
						or __wf_atom_efa6f447 == 28
						or __wf_atom_efa6f447 == 29
						or __wf_atom_efa6f447 == 37
						or __wf_atom_efa6f447 == 16
					v10.mIsSuitCat = __wf_atom_efa6f447 == 3 or __wf_atom_efa6f447 == 27 or __wf_atom_efa6f447 == 48
					v10.mIsSentinelSuitCat = __wf_atom_efa6f447 == 15 or __wf_atom_efa6f447 == 39
					local v79

					if __wf_atom_efa6f447 == 4 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Upgrade"
					elseif __wf_atom_efa6f447 == 0 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Pistol"
					elseif __wf_atom_efa6f447 == 1 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Longun"
					elseif __wf_atom_efa6f447 == 2 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Consumable"
					elseif __wf_atom_efa6f447 == 3 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Suit"
					elseif __wf_atom_efa6f447 == 5 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Melee"
					elseif __wf_atom_efa6f447 == 7 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Robotics"
					elseif __wf_atom_efa6f447 == 9 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Packages"
					elseif __wf_atom_efa6f447 == 32 then
						v79 = "/Lotus/Language/Menu/Global_ProductCategory_Ships"
					else
						v79 = ""
					end

					v10.mCategoryString = mMovie:__wf_atom_8e9ac384(v79, true)
					fn2(storeItem)

					if v10.ITEM ~= nil then
						fn47(v10.ITEM)
					end

					if v10.BLUEPRINT ~= nil then
						fn47(v10.BLUEPRINT)
					end

					fn49()
					mMovie:__wf_atom_2dedec1a("DetailedView", 13, not self.mInMuseum)
					__wf_atom_ec43d06e(mMovie, "DetailedView", 8, { 12 }, { 100 }, 0.2, nil)
					flag = false

					if v75 then
						fn52()
					end
				else
					v56:BuildCompatibleList(item, v10.ITEM.UpgradeFingerprint)
					local mCompatibleItems = v56.mCompatibleItems
					local v79 = {}

					for i = 1, #mCompatibleItems do
						table.insert(v79, mCompatibleItems[i].Type:__wf_atom_5b41f63b())
					end

					loader = UISys.__wf_atom_c0dbe47c(v79, true)
					v78 = true
					v11:AddTimer(0.05, fn53)
					v66.PanelLoading = true
				end
			else
				v11:AddTimer(0.05, fn53)
				v66.PanelLoading = true
			end
		end

		fn53()
	end

	function class:Hide()
		if not class.isDisplaying then
			return
		end

		self:SetDiorama(nil)
		class.isDisplaying = false
	end

	function class:SetInWishlist(p, currInWishlist)
		p.CurrInWishlist = currInWishlist
		local currInfo = self:GetCurrInfo()
		local ternary = module2.Ternary(currInfo.CurrInWishlist, 2, 1)
		mMovie:__wf_atom_c90af43a("DetailedView.Wishlist", wishlistBtnTextures[ternary])
	end

	function class:IsMod(object)
		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:GetItem()) then
			return false, false, false
		end

		local item = object:GetItem()
		local v73 = item:IsA(__wf_atom_58a409f1)
			and not item:IsA(self.ItemTypes.enhancementType)
			and object:__wf_atom_efa6f447() ~= 8
		return v73, item:IsA(self.ItemTypes.enhancementType), v73 and item:IsA(v21)
	end

	function class:ShouldShowCoupon(p)
		local v73 = not v66.IsDailyDeal

		if v73 then
			if p.Coupon == nil or p.Coupon.mAmount == 0 then
				return false
			else
				return Engine.__wf_atom_e9b9db5f(p.Coupon.mExpiry) > 0
			end
		end

		return v73
	end

	function class:AdjustToViewport()
		fn9(self)
	end

	function class:AdjustStatsMask()
		if __wf_atom_7e8ad928(self.mDescHeight) or __wf_atom_7e8ad928(self.ContentHeight) then
			return
		end

		local _, v73 = module2.GetScreenDimensions(mMovie)
		local v74 = v73 * module2.Ternary(Engine.__wf_atom_fc67ba71(), 0.77, 0.8)
		local mYOffset = v63.mYOffset
		local v75 = math.max(math.min(v74 - self.ContentHeight, self.mDescHeight), 30)
		local v76 = __wf_atom_7e8ad928(self.mDescriptionScrollBar) and 0
			or (self.mDescHeight - v75) * self.mDescriptionScrollBar:GetScrollValue()
		mMovie:__wf_atom_e57658c2(v63.mClipName .. ".Backer", 15, v75 - mYOffset + v76)
		mMovie:__wf_atom_e57658c2(v63.mClipName .. ".Mask", 15, v75 - mYOffset - 4 + v76)

		if not (__wf_atom_7e8ad928(v63.mStats) or __wf_atom_7e8ad928(v63.mStats.Labels)) then
			local labels = v63.mStats.Labels
			local v77 = self.ContentHeight - mYOffset + v76

			for i = 1, #labels do
				local v78 = v63.mClipName .. ".List.Item" .. i

				if not mMovie:__wf_atom_253d7085(v78) then
					continue
				end

				local v79 = mMovie:__wf_atom_5e6e15c8(v78, 1) + mYOffset
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v78, "Backer", 15)
				local v80 = v79 + __wf_atom_cfc41e35 / 2 < v77 and v76 < v79 + __wf_atom_cfc41e35 / 2
				mMovie:__wf_atom_2dedec1a(v78, 67, v80)
			end
		end
	end
end

fn9 = function(object)
	if object.ContentHeight == nil then
		return
	end

	local _, v72 = module2.GetScreenDimensions(mMovie)
	object.mInitialContentY = mMovie:__wf_atom_5e6e15c8("DetailedView", 1) + object.mDescY
	local v73 = v72 * module2.Ternary(Engine.__wf_atom_fc67ba71(), 0.77, 0.8)
	local v74 = math.max(math.min(v73 - object.ContentHeight, object.mDescHeight), 30)
	local v75 = object.ContentHeight + object.mDescHeight
	local v76 = v73 / v75

	if v76 > 1 then
		mMovie:__wf_atom_2dedec1a("DetailedView.OptionsScrollBar", 13, false)
	else
		local v77 = not __wf_atom_7e8ad928(object.mDescriptionScrollBar)

		if __wf_atom_7e8ad928(object.mDescriptionScrollBar) then
			local module17 = require("EE.Interface.Components.ScrollBar")
			object.mDescriptionScrollBar = module17.CreateScrollBar(
				mMovie,
				"DetailedView.OptionsScrollBar",
				v74 + 2,
				v76
			)
			object.mDescriptionScrollBar:HookUpCallbacks()
		end

		function object.mDescriptionScrollBar.mScrollValueChangedCallback(p, _)
			mMovie:__wf_atom_e57658c2("DetailedView.Scrollable", 1, object.mDescY - (object.mDescHeight - v74) * p)
			object:AdjustStatsMask()
		end

		if v77 then
			object.mDescriptionScrollBar:SetHeight(v74 + 2, true)
			object.mDescriptionScrollBar:SetVisibleProp(v76)
		end

		object.mDescriptionScrollBar.mScrollStep = 150 / v75
		object.mDescriptionScrollBar:Initialize()
		object.mLeftStickScrollValue = 0
		mMovie:__wf_atom_2dedec1a("DetailedView.OptionsScrollBar", 13, true)
	end

	if not __wf_atom_7e8ad928(object.mDescriptionScrollBar) then
		object.mDescriptionScrollBar:SetEnabled(v76 <= 1)
	end

	v63:SetWidth(module2.Ternary(v76 > 1, 447, 435))
	local v77 = object.mDescY + v74 + 10
	mMovie:__wf_atom_e57658c2("DetailedView.BelowDescription", 1, v77)
	mMovie:__wf_atom_e57658c2("DetailedView.AbilityList", 1, v77 + 50)
	local v78 = v75 + 180
	mMovie:__wf_atom_e57658c2("CornerBg.Bg", 15, (math.min(v73 + 200, (math.max(720, v78)))))
	print(v75, v78)
	local v79 = math.max(0, 720 - v78)
	mMovie:__wf_atom_e57658c2("CornerBg.Bg", 1, -v79)

	if v9.VENDOR_MODE then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailedView.BelowDescription.PurchaseConfirm.Bg", 15)
		local originalCoords = v26:GetOriginalCoords("DetailedView")
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("DetailedView.BelowDescription.PurchaseConfirm", 1)
		v26:ChangeOriginalCoords(
			"ItemGrid",
			nil,
			originalCoords.y + v77 + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8 + 40
		)
		v26:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	object:UpdateVisRanges(v74)
end

function OnMuseumStreamed()
	module6.OnMuseumStreamed()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:Execute("TransitionOut", "")
	end

	flag = false
	flag2 = true
end

local function fn52(p)
	if flag then
		return
	end

	module6.StreamMuseum(p)
	flag = true
end

local function fn53()
	class.mInMuseum = true
	local storeItem = v10.ITEM.StoreItem
	_T.QueueStoreItemAfterMuseum = v10.ITEM.StoreItem
	fn52(fn38(storeItem))
end

function ViewMuseum()
	if __wf_atom_7e8ad928(class) or __wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v10.ITEM) then
		return
	end

	fn53()
end

local function fn54()
	local module17 = require("Lotus.Interface.Components.ThemedButton")
	v64.MuseumBtn = module17.Create(mMovie, "MuseumBtn", "/Lotus/Language/Menu/Leverian", "ViewMuseum")
	v64.MuseumBtn:SetSpecialMode()
	v64.MuseumBtn:SetWidth(160)
	v64.MuseumBtn:SetAnchor(module2.RIGHT_ALIGNED)
	v64.MuseumBtn:SetPosition(1520, 760)
	v64.MuseumBtn:SetVisible(false)
	v64.MuseumBtn:Redraw()
end

local function fn55(p, p2)
	local currInfo = class:GetCurrInfo()

	if not (__wf_atom_7e8ad928(currInfo) or __wf_atom_7e8ad928(currInfo.StoreItemInfo) or __wf_atom_7e8ad928(currInfo.StoreItemInfo.mMod) or __wf_atom_7e8ad928(currInfo.StoreItemInfo.mMod.Card)) then
		local card = currInfo.StoreItemInfo.mMod.Card
		module4.UpdateOmegaCard(card, p, p2)
		module4.DrawCard({ mClipName = "Preview.Mod", Card = card })
	end
end

function Initialize()
	_T.maximumSyndicateScarfIntensity = true
	_T.GiftParams = {}
	v70 = not (Engine.__wf_atom_eecb6143() or Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69())

	if not __wf_atom_7e8ad928(gGameRules) then
		v16 = gGameRules:__wf_atom_964056fd()
		__wf_atom_7e8ad928(v16)
	end

	module3.RegisterHideEOM(true)
	module3.RegisterHideHud(true)
	v66.CanToggleCurrencyBar = not _T.UIInputEnabled
	v49 = module7.GetCurrentBackgroundInfo()
	local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

	if not __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
		v40.OrigTheme = __wf_atom_3cb140dc:__wf_atom_a4bdf2b8()
		v40.OrigBg = __wf_atom_3cb140dc:__wf_atom_cb0fd61c()
		v40.OrigSounds = __wf_atom_3cb140dc:__wf_atom_f57f9624()
	end

	fn11()

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_Title", false))
	end

	v68.INNER_RECT_COLOR_OBJECT = module2.ConvertColorNumberToProceduralRGB(v68.INNER_RECT_COLOR)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_7d7314f1("Tip.text", "/Lotus/Language/Menu/RotateDetailedPurchaseDialogTip")
	module3.RegisterHideStarChart(true)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_2dedec1a("Watermark", 13, false)
	mMovie:__wf_atom_e57658c2("Watermark", 12, 20)
	fn54()
	v26 = module15.Create(mMovie)
	v26:Register(mMovie, "Tip", { v26.ANCHOR_V_BOTTOM, v26.ANCHOR_H_CENTRE })
	v26:Register(mMovie, "MuseumBtn", { v26.ANCHOR_V_BOTTOM, v26.ANCHOR_H_RIGHT })
	v26:Register(mMovie, "CornerBg", { v26.ANCHOR_V_TOP, v26.ANCHOR_H_LEFT })
	v26:Register(mMovie, "DetailedView", { v26.ANCHOR_V_TOP, v26.ANCHOR_H_LEFT })
	v26:Register(mMovie, "Preview", { v26.ANCHOR_V_CENTRE, v26.ANCHOR_H_CENTRE })
	v26:Register(mMovie, "Watermark", { v26.ANCHOR_V_BOTTOM, v26.ANCHOR_H_LEFT })
	v26:Register(mMovie, "LinesTop", { v26.ANCHOR_V_TOP, v26.ANCHOR_H_CENTRE })
	v26:Register(mMovie, "LinesBottom", { v26.ANCHOR_V_BOTTOM, v26.ANCHOR_H_CENTRE })
	v26:Register(mMovie, "ItemGrid", { v26.ANCHOR_V_TOP, v26.ANCHOR_H_RIGHT })
	v26:Register(mMovie, "FitDisplay", { v26.ANCHOR_V_BOTTOM, v26.ANCHOR_H_RIGHT })
	v26:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local module17 = require("Lotus.Interface.Components.RotationControl")
	v37 = module17.Create(mMovie)
	v37.mUseControllerDeltaIfSet = true
	v11 = module14.CreateTimerMgr()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		gameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		v3.ShowDiscountOnGrid = __wf_atom_18a5d83b:__wf_atom_01fbbcf8("igm_discount_indicator_show")
	end

	if not __wf_atom_7e8ad928(gameData) then
		inventory = gameData:GetInventory()
	end

	if not (__wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(inventory)) then
		v6 = SF.ProductUpsellHelper(v16, inventory)
	end

	fn2()
	fn46()
	fn51()
	mMovie:__wf_atom_7d7314f1(
		"DetailedView.Panel.Content.ResourceList.Title.text",
		"/Lotus/Language/Menu/Store_RecipeComponents"
	)
	local module18 = require("Lotus.Interface.Components.OmegaCompatibilityPanel")
	v56 = module18.Create(mMovie, "FitDisplay", fn55)
	local module19 = require("Lotus.Interface.Components.ThemedSpinner")
	v15 = module19.Create(mMovie, "Spinner")
	gClient:__wf_atom_7ea73984("OnAppReturnedFromConstrainedState")
	module2.PlaySound(_G.UISound_WindowOpen)
	module6.ToggleScreensToHide(false, v48)

	if not _T.AppearancePreviewOpen then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("HideScreenForPlatPurchase", "true")
	end

	v12 = true
end

local function fn56()
	if __wf_atom_7e8ad928(nil) then
		return
	end

	if (nil).mDioramaLoader:IsLoading() then
		if (nil).mDioramaLoader:LoadingComplete() then
			(nil).mDioramaLoader:FinishLoad()

			if _T.InSyndicateScreen and not (class.mGenericDiorama or __wf_atom_7e8ad928(_T.HideBackground)) then
				_T.HideBackground()
			end

			if _T.DetailedPurchaseDialogDisableMusic then
				local __wf_atom_0a6a5887 = __wf_atom_392793db:__wf_atom_0a6a5887(Symbol("dioramaMusic"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_0a6a5887:Disable()
				end
			end

			if not __wf_atom_7e8ad928(fn) then
				fn()
			end

			module2.FadeBackground(mMovie, 0, 0.3)

			if Engine.IsPlayingWithController() then
				mMovie:__wf_atom_40912f8e((nil):__wf_atom_a8b78f7c())
			end

			if not Engine.IsPlayingWithController() and (nil):__wf_atom_a8b78f7c() then
				__wf_atom_ec43d06e(mMovie, "Tip", 0, { 12 }, { 100 }, 0.35, 2)
				v39 = 50
			end
		end
	else
		(nil):__wf_atom_089e2b1c(v37);
		(nil):Update()

		if v39 > 0 and (nil):__wf_atom_a8b78f7c() and v37:IsMouseDown() then
			local delta, _ = v37:GetDelta()
			v39 -= math.abs(delta)

			if v39 <= 0 then
				__wf_atom_ec43d06e(mMovie, "Tip", 0, { 12 }, { 0 }, 0.5)
			end
		end

		if not __wf_atom_7e8ad928((nil).CrewMemberAvatar) then
			local __wf_atom_e55d02aa = (nil).CrewMemberAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			local powerSuitStats = module10.GetPowerSuitStats(mMovie, (nil).CrewMemberAvatar, __wf_atom_e55d02aa)

			if powerSuitStats ~= nil then
				local health = powerSuitStats.mStats.Health
				local shield = powerSuitStats.mStats.Shield

				if health ~= nil then
					v59:__wf_atom_fe491b37(health.StatValue)
					v59:__wf_atom_754076b1(health.StatValue)
				end

				if shield ~= nil then
					v59:__wf_atom_d6c7a102(shield.StatValue)
					v59:__wf_atom_9abf42e7(shield.StatValue)
				end

				v59:Update(__wf_atom_084b3e93())
				mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.CrewMemberSkills.HealthInfo", 13, true)
				mMovie:__wf_atom_2dedec1a("DetailedView.BelowDescription.CrewMemberSkills.HealthLabel", 13, true);
				(nil).CrewMemberAvatar = nil
			end
		end
	end
end

local function fn57(p)
	local storeItem = p.ITEM.StoreItem

	if __wf_atom_7e8ad928(storeItem) then
		return
	end

	v10 = {}
	local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()
	local item = p.ITEM
	local blueprint = nil
	local storeItem4 = nil
	local __wf_atom_42794027 = storeItem:__wf_atom_42794027()

	if not v66.IsDailyDeal and item.SpecialPrice == nil and not item.PreventCoupons then
		module3.PopulateCouponInfo(item)
	end

	if not isDailyDeal then
		if __wf_atom_efa6f447 == 13 then
			storeItem4 = storeItem:__wf_atom_e622b3f6()
		else
			local __wf_atom_ecd05e96 = storeItem:__wf_atom_ecd05e96()

			if not __wf_atom_7e8ad928(__wf_atom_ecd05e96) and __wf_atom_ecd05e96:IsA(__wf_atom_3cecff09) then
				storeItem4 = fn17(__wf_atom_ecd05e96)
			end
		end

		local v74 = not __wf_atom_7e8ad928(storeItem4) and storeItem4:ShowInMarket() and p.SHOWSISTER ~= false

		if v74 or __wf_atom_efa6f447 ~= 13 and __wf_atom_42794027:c_str() ~= "" then
			blueprint = { StoreItem = storeItem4, CanPurchaseOverride = item.CanPurchaseOverride }

			if v74 then
				blueprint.StoreItem = storeItem4
				blueprint.Sale = module3.GetSaleInfo(blueprint.StoreItem)
				module3.PopulateCouponInfo(blueprint)
			end

			if not __wf_atom_7e8ad928(storeItem4) and __wf_atom_42794027:c_str() == "" then
				__wf_atom_42794027 = storeItem4:__wf_atom_42794027()
			end

			if __wf_atom_42794027:c_str() ~= "" then
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(__wf_atom_42794027:c_str(), true)

				if
					not __wf_atom_7e8ad928(storeItem4)
					and storeItem4:IsA(__wf_atom_bf37f5ca)
					and storeItem4:__wf_atom_0e829efd()
				then
					local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
						storeItem:__wf_atom_014a76a2():c_str(),
						false
					)
					__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/DetailedPurchase_ResearchRecipeHelp",
						false,
						{
							ITEM = TitleCase(__wf_atom_8e9ac384_2),
							ROOM = __wf_atom_8e9ac384
						}
					)
				end

				if __wf_atom_efa6f447 == 13 then
					item.HelpText = __wf_atom_8e9ac384
				else
					blueprint.HelpText = __wf_atom_8e9ac384
				end
			end
		end
	end

	item.WishlistItem = nil

	if __wf_atom_efa6f447 == 13 then
		v10.BLUEPRINT = item
		v10.ITEM = blueprint
	else
		v10.BLUEPRINT = blueprint
		v10.ITEM = item
	end

	if v10.ITEM ~= nil and v10.ITEM.StoreItem ~= nil and v10.BLUEPRINT ~= nil and v10.BLUEPRINT.StoreItem ~= nil then
		local storeItem2 = v10.ITEM.StoreItem
		local storeItem3 = v10.BLUEPRINT.StoreItem

		if
			not __wf_atom_7e8ad928(storeItem2)
			and not __wf_atom_7e8ad928(storeItem3)
			and storeItem2 ~= storeItem3:__wf_atom_e622b3f6()
		then
			v10.BLUEPRINT.ForceShowDesc = true
		end
	end

	return module2.Ternary(__wf_atom_efa6f447 == 13, class.mCategories.BLUEPRINT, class.mCategories.ABOUT)
end

local function fn58(p)
	return (string.len((tostring(p))))
end

local function fn59(p)
	if flag then
		return
	end

	local v72 = __wf_atom_421b01aa(v30 + p, 1, v29)

	if v72 == v30 then
		module2.PlaySound(_G.UISound_Error)
		return
	end

	v28.mInputField:SetText((tostring(v72)))
	fn3()
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v12 then
		return
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Update(__wf_atom_fa1258d0())
	end

	if flag2 then
		mMovie:Close()
		fn14()
	else
		local v72 = not v45 and (v44 or not _T.TopMenuOpen)
		mMovie:SetVisible(v72)

		if not v72 then
			return
		end

		if not __wf_atom_7e8ad928(v51) then
			v52 -= __wf_atom_084b3e93()

			if v52 <= 0 then
				if total < fn58(v29) - 1 then
					total += 0.2
				end

				v52 = 0.25
				fn59(v51 * math.pow(10, (math.floor(total))))
			end
		end

		mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

		if not __wf_atom_7e8ad928(v15) then
			v15:Update()
		end

		if not __wf_atom_7e8ad928(v57) then
			v57:Update()
		end

		if _T.marketDetailedViewParms then
			local marketDetailedViewParms = _T.marketDetailedViewParms
			_T.marketDetailedViewParms = nil
			mMovie:__wf_atom_aaffc42a(false)
			callback = marketDetailedViewParms.CALLBACK

			if base == v7.BASE then
				if class ~= nil and class.mDescriptionScrollBar ~= nil then
					class.mDescriptionScrollBar:SetScrollValue(0)
				end
			else
				if class ~= nil then
					class.mSkipBase = false
				end

				fn4()
			end

			if marketDetailedViewParms.ITEM == nil and not __wf_atom_7e8ad928(class) then
				fn2()

				if v10.ITEM ~= nil then
					if not v66.IsDailyDeal and v10.ITEM.SpecialPrice == nil and not v10.ITEM.PreventCoupons then
						module3.PopulateCouponInfo(v10.ITEM)
					end

					v10.ITEM.WishlistItem = nil
					fn47(v10.ITEM)
				end

				if v10.BLUEPRINT ~= nil then
					if
						not v66.IsDailyDeal
						and v10.BLUEPRINT.SpecialPrice == nil
						and not v10.BLUEPRINT.PreventCoupons
					then
						module3.PopulateCouponInfo(v10.BLUEPRINT)
					end

					fn47(v10.BLUEPRINT)
				end

				fn49()

				if base == v7.MULTI then
					class:ConfigureMultiPurchase()
					return
				end

				if base == v7.CONFIRM then
					fn43()
				end

				return
			else
				v9 = marketDetailedViewParms
				v54.mScrollAlwaysVisible = not v9.VENDOR_MODE
				v54.mAddFillerElements = not v9.VENDOR_MODE
				v26:ChangeAnchorPoints(
					"ItemGrid",
					nil,
					module2.Ternary(v9.VENDOR_MODE, v26.ANCHOR_H_LEFT, v26.ANCHOR_H_RIGHT)
				)
				v26:ChangeOriginalCoords("ItemGrid", module2.Ternary(v9.VENDOR_MODE, 77, 1110), 150)
				v26:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
				v66.IsDailyDeal = module2.Ternary(v9.IS_DAILY_DEAL ~= nil, v9.IS_DAILY_DEAL, false)
				v41 = module2.Ternary(v9.HIDE_PARENT ~= nil, v9.HIDE_PARENT, true)
				canPurchaseCheck = v9.ITEM.CanPurchaseCheck
				canGiftCheck = v9.ITEM.CanGiftCheck

				if v9.ITEM.SquadOverlayTitle ~= nil and not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
					_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384(v9.ITEM.SquadOverlayTitle, false), nil, true)
				end

				isDailyDeal = v66.IsDailyDeal or v9.ITEM.CodexMode
				local v73 = fn57(v9)
				class.mCurrCategory = nil
				class:Show(v73)
				mMovie:__wf_atom_e57658c2("_root", 12, 100)

				if v41 then
					local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

					if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
						__wf_atom_2ad5cd23:SetVisible(false)
					end
				end
			end
		end

		if class.isDisplaying then
			local currInfo = class:GetCurrInfo()

			if
				(Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_2a979d69())
				and v69
				and currInfo ~= nil
				and currInfo.IsExternalProduct
			then
				local v73 = __wf_atom_7e8ad928(gameData) and ""
					or gameData:__wf_atom_347d3c3b(module3.GetProductId(currInfo.StoreItem))

				if v73 == "0.00" then
					v69 = true
				else
					v69 = false
					mMovie:__wf_atom_50d60589("DetailedView.Panel.Content.RegularCurrency.Price", 36, v73)
				end
			end

			if
				Engine.IsPlayingWithController()
				and not __wf_atom_7e8ad928(class.mDescriptionScrollBar)
				and class.mLeftStickScrollValue ~= 0
			then
				class.mDescriptionScrollBar:ScrollBy(-class.mLeftStickScrollValue * class.mDescriptionScrollBar.mScrollStep * 30 * __wf_atom_fa1258d0())
			end

			if not __wf_atom_7e8ad928(class.mDescriptionScrollBar) then
				class.mDescriptionScrollBar:Update(__wf_atom_fa1258d0())
			end

			if not __wf_atom_7e8ad928(v15) then
				local v73 = flag

				if class.mInDioramaMode then
					v73 = v73 or (nil).mDioramaLoader:IsLoading() or v66.PanelLoading
				end

				v15:SetActive(v73)
			end

			if class.mInDioramaMode then
				fn56()
			end

			if not (__wf_atom_7e8ad928(v10.ITEM) or __wf_atom_7e8ad928(v10.ITEM.StoreItemInfo) or __wf_atom_7e8ad928(v10.ITEM.StoreItemInfo.mMod)) then
				module4.Update(v10.ITEM.StoreItemInfo.mMod, 0)
			end

			local v73 = { v10.ITEM, v10.BLUEPRINT }

			for i = 1, #v73 do
				local v74 = v73[i]

				if __wf_atom_7e8ad928(v74) or v66.PanelLoading then
					continue
				end

				local v75 = false
				local sale = nil

				if (v74.ShowSale or v74.ConsoleSale) and v74.Sale ~= nil and v74.Sale.mDiscount > 0 then
					if Engine.__wf_atom_db2b0cee(v74.Sale.mEndDate) <= 0 then
						_T.marketDetailedViewParms = { ITEM = nil, CALLBACK = callback }
						return
					else
						sale = v74.Sale
						v75 = true
					end
				elseif
					v74.ShowCoupon
					and v74.Coupon ~= nil
					and v74.Coupon.mAmount ~= 0
					and (__wf_atom_7e8ad928(v74.Coupon.mCouponType) or v74.Coupon.mCouponType == 0)
				then
					if Engine.__wf_atom_e9b9db5f(v74.Coupon.mExpiry) <= 0 then
						_T.marketDetailedViewParms = { ITEM = nil, CALLBACK = callback }
						return
					else
						sale = v74.Coupon
						v75 = true
					end
				end

				if v75 and v53 ~= nil and v53.CustomizationList ~= nil then
					local v76 = i
					v53.CustomizationList:RunForAllElements(function(p)
						if v76 == 1 and p.IsPurchase or v76 == 2 and p.IsBlueprint then
							v53.CustomizationList:UpdateSaleInfo(p, v74, sale)
						end
					end)
				end

				if
					__wf_atom_7e8ad928(v74.StoreItem)
					or v74.CanGiftOverride == false
					or v74.CanPurchaseOverride == false
					or v74.StoreItem:__wf_atom_befa6dbf() == 0
				then
					continue
				end

				if v46 then
					continue
				end

				class:RefreshExpiryTime(
					module2.Ternary(class.mCurrCategory == i, "DetailedView.Panel.Content", nil),
					module3.GetProductTimeLeft(v74)
				)
			end
		end

		if v27 and fn30() == true then
			v27 = false
		end

		if v28.mInputField ~= nil and v28.mInputField.mSelected then
			fn3()
		end

		if Engine.IsPlayingWithController() then
			if not flag and not __wf_atom_7e8ad928(nil) and (nil):__wf_atom_a8b78f7c() then
				v37.mForceUseControllerDelta = true
				v37:SetMouseDown(true)
				v37:Update()
			end
		else
			v37.mForceUseControllerDelta = false
			v37:Update()
		end
	end
end

local function fn60()
	flag = true

	if not __wf_atom_7e8ad928(class) then
		class:Hide()
	end

	if not __wf_atom_7e8ad928(v47) then
		v47 = nil
	end

	_T.gToolTip = nil
	__wf_atom_ec43d06e(mMovie, "GlobalMenu", 8, { 1 }, { 757 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0, 0, function()
		flag2 = true
	end)
end

function Close()
	mMovie:Close()
	fn14()
end

fn4 = function(p, p2)
	if mMovie then
		v54.mVisible = false
		mMovie:__wf_atom_2dedec1a("ItemGrid", 13, false)
		mMovie:__wf_atom_50d60589("ItemGrid.Title", 36, "")
	end

	if class.mInMuseum and not p2 then
		fn53()
	elseif base ~= v7.BASE and not (p2 or class.mSkipBase) then
		fn6(v7.BASE)
	elseif #v8 > 0 and not p2 then
		class:Hide()
		_T.marketDetailedViewParms = table.remove(v8)
		fn15()
	elseif p or not fn16() then
		fn60()
		module2.PlaySound(_G.UISound_WindowClose)
	end
end

function GoBack()
	fn4()
end

function TransitionOut()
	fn4(nil, true)
end

fn10 = function()
	v51 = nil
end

function ConcludeCount()
	fn10()
end

local function fn61(p)
	if flag then
		v37:SetRightStickTensionX(0)
		v37:SetMouseDown(false)
	else
		v37:SetRightStickTensionX(p)
		v37:SetMouseDown(true)
	end
end

function onKeyDown_MENU_RIGHT_X(_, p)
	fn61(p)
	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	fn61(p)
	return true
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	if class.isDisplaying then
		class.mLeftStickScrollValue = tonumber(p)
	end

	return true
end

function onKeyUp_MENU_RIGHT_Y(_, p)
	if class.isDisplaying then
		class.mLeftStickScrollValue = tonumber(p)
	end

	return true
end

local function fn62()
	if not flag then
		fn59(1)
		v51 = 1
		total = 0
		v52 = 0.6
	end
end

local function fn63()
	if not flag then
		fn59(-1)
		v51 = -1
		total = 0
		v52 = 0.6
	end
end

function MinCount()
	fn59(-(v30 - 1))
end

function MaxCount()
	fn59(v29 - v30)
end

function IncreaseCount()
	fn62()
end

function DecreaseCount()
	fn63()
end

function onKeyDown_MENU_LTRIGGER2()
	fn63()
	return true
end

function onKeyDown_MENU_RTRIGGER2()
	fn62()
	return true
end

function onKeyUp_MENU_LTRIGGER2()
	if not flag and Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(class) then
		fn10()
	end

	return true
end

function onKeyUp_MENU_RTRIGGER2()
	if not flag and Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(class) then
		fn10()
	end

	return true
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not flag then
		local mScrollBar = nil
		local v72 = mMovie:__wf_atom_5e6e15c8("ItemGrid", 0) - 10

		if
			__wf_atom_7e8ad928(v54)
			or not v54.mVisible
			or not (v72 <= mMovie:__wf_atom_5e6e15c8("_root", 30))
			or flag3
		then
			if __wf_atom_7e8ad928(class.mDescriptionScrollBar) or not class.mDescriptionScrollBar.mEnabled then
				if __wf_atom_7e8ad928(v60) or not v60.mScrollBar.mEnabled then
					if not __wf_atom_7e8ad928(v61) and v61.mScrollBar.mEnabled then
						mScrollBar = v61.mScrollBar
					end
				else
					mScrollBar = v60.mScrollBar
				end
			else
				mScrollBar = class.mDescriptionScrollBar
			end
		else
			mScrollBar = v54.mScrollBar
		end

		if not __wf_atom_7e8ad928(mScrollBar) then
			mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
		end
	end
end

function IsInputBlocked()
	return flag
end

fn3 = function(flag4)
	local v72 = tonumber(mMovie:__wf_atom_387f260e(v28.mInputField.mClipName .. ".Label", 36))
	local v73 = v72 == nil and 0 or v72

	if v73 ~= v30 and (v73 ~= 0 or v30 ~= 1) then
		v30 = math.floor((__wf_atom_421b01aa(v73, 1, v29)))

		if v73 ~= 0 then
			v28.mInputField:SetText(v30)
		end

		flag4 = true
	end

	if flag4 then
		fn43()
	end
end

fn2 = function(p)
	v13 = module5.GetPurchasedItems(v16, inventory, p, false, mMovie)

	if v53 ~= nil then
		v53.CustomizationList.PurchasedItems = v13
	end
end

function OnExternalProductPurchaseComplete()
	OnPendingPurchasesCommitted()
end

function OnAppReturnedFromConstrainedState()
	local currInfo = class:GetCurrInfo()

	if
		not __wf_atom_7e8ad928(gameData)
		and class.isDisplaying
		and currInfo.IsExternalProduct
		and gameData:__wf_atom_a1deff4d(module3.GetProductId(currInfo.StoreItem))
		and not currInfo.CanPurchaseIfAlreadyOwned
	then
		v10.mExternalProductPurchased = 1
		fn49()
		fn4(true, true)

		if not __wf_atom_7e8ad928(callback) then
			callback(true)
		end
	end
end

function OnPendingPurchasesCommitted()
	local currInfo = class:GetCurrInfo()

	if
		not __wf_atom_7e8ad928(gameData)
		and class.isDisplaying
		and currInfo.IsExternalProduct
		and gameData:__wf_atom_a1deff4d(module3.GetProductId(currInfo.StoreItem))
	then
		print("App Returned from constrained state so checking with update purchase buttons")
		v47 = mMovie:PushChildMovie(purchaseCelebrationMovie)
		v10.mExternalProductPurchased = 1
		fn49()
		fn4(true, true)

		if not __wf_atom_7e8ad928(callback) then
			callback(true)
		end
	end
end

local function fn64()
	if not __wf_atom_7e8ad928(v37) then
		v37:SetMouseDown(true)
	end
end

local function fn65()
	if not __wf_atom_7e8ad928(v37) then
		v37:SetMouseDown(false)
	end
end

function onRawInputEvent(_, p, p2)
	if p == "EN_MOUSE_B0" then
		if p2 == "1" then
			fn64()
		else
			fn65()
		end
	end
end

function AllowMultiPurchase(p)
	v42 = p == "true"
end

function SetIgnoreTopMenu(p)
	v44 = p == "true"
end

function HideScreen(p)
	v45 = p == "true"

	if not (v45 or __wf_atom_7e8ad928(class.AdjustToViewport)) then
		class:AdjustToViewport()
	end
end

function ForcePrevBGVis(p)
	v49.Visible = p == "true"
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v26) then
		v26:Update(p, p2)
	end

	if not __wf_atom_7e8ad928(v54) then
		local _, v72 = module2.GetScreenDimensions(mMovie)
		v54.Height = v72 - v54.HeightPadding
		module6.InitializeGridItem(mMovie, v54)
	end

	if not __wf_atom_7e8ad928(class.AdjustToViewport) then
		class:AdjustToViewport()
	end
end

function SetStoreManifest(p)
	v43 = p
end

function ItemPressed(p)
	if not (flag or __wf_atom_7e8ad928(v54)) then
		if mMovie then
			v54.mVisible = false
			mMovie:__wf_atom_2dedec1a("ItemGrid", 13, false)
			mMovie:__wf_atom_50d60589("ItemGrid.Title", 36, "")
		end

		v54:SelectElementById(tonumber(p), true)
	end
end

function ItemFocused(p)
	if not __wf_atom_7e8ad928(v54) then
		v54:FocusElementById(tonumber(p), true)
	end
end

function ItemUnfocused(p)
	if not __wf_atom_7e8ad928(v54) then
		v54:UnfocusElementById(tonumber(p), true)
	end
end

function AbilityPressed(p)
	if not (flag or __wf_atom_7e8ad928(v57)) then
		v57:SelectElementById(tonumber(p), true)
	end
end

function AbilityFocused(p)
	if not __wf_atom_7e8ad928(v57) then
		v57:FocusElementById(tonumber(p), true)
	end
end

function AbilityUnfocused(p)
	if not __wf_atom_7e8ad928(v57) then
		v57:UnfocusElementById(tonumber(p), true)
	end
end

function CrewSkillFocused(p)
	if not __wf_atom_7e8ad928(v58) then
		v58:FocusElementById(tonumber(p), true)
	end
end

function CrewSkillUnfocused(p)
	if not __wf_atom_7e8ad928(v58) then
		v58:UnfocusElementById(tonumber(p), true)
	end
end

fn7 = function(p)
	if not __wf_atom_7e8ad928(v16) then
		local storeItem = Resource(p)

		if not __wf_atom_7e8ad928(storeItem) then
			fn33({ StoreItem = storeItem, Anchor = Type(p) })
		end
	end
end

function ShowHyperlinkItem(p)
	fn7(p)
	module6.OnHyperlinkPressed(mMovie)
end

local function fn66()
	local currInfo = class:GetCurrInfo()

	if __wf_atom_7e8ad928(currInfo) then
		return
	end

	_T.gToolTip = TitleCase(mMovie:__wf_atom_8e9ac384(
		module2.Ternary(
			currInfo.CurrInWishlist,
			"/Lotus/Language/Menu/DetailedPurchase_RemoveFromWishlist",
			"/Lotus/Language/Menu/DetailedPurchase_AddToWishlist"
		),
		false
	))
end

function ToggleWishlist()
	if __wf_atom_7e8ad928(class) then
		return
	end

	local currInfo = class:GetCurrInfo()

	if __wf_atom_7e8ad928(currInfo) then
		return
	end

	class:SetInWishlist(currInfo, not currInfo.CurrInWishlist)
	local v72 = module2.FindInTable(wishlistItems, currInfo.WishlistItem)
	local v73 = currInfo.PrevInWishlist ~= currInfo.CurrInWishlist

	if v73 and v72 == -1 then
		table.insert(wishlistItems, currInfo.WishlistItem)
	elseif not v73 and v72 ~= -1 then
		table.remove(wishlistItems, v72)
	end

	if _T.gToolTip ~= nil then
		fn66()
	end

	local _, v74, _ = class:UpdatePurchaseButton(currInfo)

	if not v74 then
		mMovie:__wf_atom_2dedec1a("DetailedView.Wishlist", 13, false)
	end

	if Engine.IsPlayingWithController() then
		fn15()
	end
end

function OnWishlistChangesSaved(p, _)
	if not p then
		module2.ShowMessage("/Lotus/Language/Menu/DetailedPurchase_UpdateWishlistFail")
	end

	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	fn4(true)
end

function WishlistBtnFocused()
	local color = module7.GetColor(10, true)
	mMovie:__wf_atom_e57658c2("DetailedView.Wishlist", 11, color)
	fn66()
end

function WishlistBtnUnfocused()
	local color = module7.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("DetailedView.Wishlist", 11, color)
	_T.gToolTip = nil
end

function OnGamepadTransition(p)
	if not v12 then
		return
	end

	local v72 = p == "false"
	mMovie:__wf_atom_7f57ab2f("DetailedView.Panel.PurchasePanel.MultiSelect", "SpinCount.Left", 13, v72)
	mMovie:__wf_atom_7f57ab2f("DetailedView.Panel.PurchasePanel.MultiSelect", "SpinCount.Right", 13, v72)

	if v72 then
		mMovie:__wf_atom_2004c47f()
	end

	mMovie:__wf_atom_50d60589(
		"DetailedView.Panel.PurchasePanel.MultiSelect.SpinCount.Count",
		57,
		module2.Ternary(v72, "dynamic", "input")
	)

	if v72 then
		mMovie:__wf_atom_7d7314f1(
			"DetailedView.Panel.PurchasePanel.MultiSelect.SpinCount.Right.Tf.text",
			"<MENU_RTRIGGER1>"
		)
		mMovie:__wf_atom_7d7314f1(
			"DetailedView.Panel.PurchasePanel.MultiSelect.SpinCount.Left.Tf.text",
			"<MENU_LTRIGGER1>"
		)
	end
end

function SupportsThemes()
	return true
end

function OnStyleChangedCallback()
	fn11()
end

function onKeyUp_MENU_CANCEL()
	fn4()
end