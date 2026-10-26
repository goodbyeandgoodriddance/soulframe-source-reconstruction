_T.MATCHMAKING_QUICKMATCH_GAMEMODE = 9
_T.MATCHMAKING_PRIVATE_GAMEMODE = 3
_T.MATCHMAKING_INVITE_ONLY_GAMEMODE = 4
_T.MATCHMAKING_OFFLINE_GAMEMODE = 0
_T.MATCHMAKING_PVP_GAMEMODE = 6
_T.REGION_ID_DOJO = 14
_T.REGION_ID_VOID = 15
_T.REGION_ID_DERELICT = 17
_T.REGION_ID_MOON = 18
_T.REGION_ID_FORTRESS = 19
_T.REGION_ID_DARK_SECTOR = 20
_T.REGION_ID_DEEP_SPACE = 21
_T.REGION_ID_ZARIMAN = 22
_T.MENU_SUIT_AVATAR_PROGRESS = 0
_T.SHOW_LOCKED_ALERTS = false
_T.gSelectedRegionId = -1
_T.gSelectedNodeName = ""
_T.gShowingLoginScreen = true
_T.CachedAlerts = {}
_T.CachedInvasionInfo = {}
_T.CachedConstructionProjects = nil
_T.CachedSkullNodes = {}
_T.CachedRegionStatus = {}
_T.CachedFlashSales = nil
_T.CachedVoidTraders = {}
_T.CachedTennoAvatar = nil
_T.CachedSyndicateMissions = {}
_T.CachedNodesPendingDestruction = {}
_T.CachedSortieMissions = {}
_T.CachedActiveMissions = {}
_T.CachedGhostTowerMissions = {}
_T.CachedNemesisMissions = {}
_T.CachedEliteAlertMissions = {}
_T.CachedHardModeDailyMissions = {}
_T.CachedVoidStormMissions = {}
local _ = {
	easy = Resource("/Lotus/Types/Game/MissionDecks/KuvaMissionRewards/KuvaSiphonRewards"),
	hard = Resource("/Lotus/Types/Game/MissionDecks/KuvaMissionRewards/KuvaSiphonFloodRewards")
}
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
require("Lotus.Interface.FortressUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Interface.CardUtilitiesRedux")
local module5 = require("Lotus.Interface.TransmissionUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("Lotus.Interface.UIStyleUtilities")
local module8 = require("Lotus.Scripts.RelayReconstructionUtilities")
local module9 = require("Lotus.Interface.Libs.JukeBoxMgr")
local module10 = require("Lotus.Interface.MissionRequirementUtilities")
require("Lotus.Interface.WorldStateUtilities")
local module11 = require("Lotus.Interface.Libs.DioramaLoader")
local module12 = require("SF.Scripts.FirstLoginUtils")
local module13 = require("SF.Interface.SFUtilities")
local module14 = require("Lotus.Interface.Libs.ActionFigureLoadoutLoader")
local module15 = require("Lotus.Interface.Libs.DojoMgr")
mTimerMgr = nil
mQuestsNeedChecking = true
mControl = { Initialized = false, Shutdown = false, StyleInit = false }
mNotificationsMovie = nil
mChildMovie = nil
screenStack = {}
queuedMovie = nil
queuedMovieCallback = nil
movies = {}
mFadeInStarted = false
mPreviousScreen = nil
mToolTip = nil
mBacker = nil
mInfoPopup = nil
mIMEOverlay = nil
mBlockingTaskPopup = nil
mUnblockWhenAsyncDone = false
mStyleBackgroundMovie = nil
mPurchaseParams = nil
mQuantityToReceive = 1
local v = nil
mPurchaseTotalPrice = nil
mPurchaseUnitPrice = nil
mPurchaseQuantityMultiplier = 1
mQueuedGoToScreen = nil
mQueuedGoToPreviousScreen = nil
mQueuedLogoff = false
mAbortingQuickMatch = false
mNeedsToRespawnMenuAvatars = false
mMenuSuitAvatar = nil
mMenuSuitAvatarVisible = true
connectionFailurePopup = nil
mPurchasePopupMovie = nil
mCurrentMode = nil
mUIInputEnableTimer = nil
mFoundryNotification = { Refresh = false, Timer = nil, LastRefreshTime = 0 }
mPurchaseOrigin = nil
mBinType = ""
mBaseSourceType = ""
mWebCmd = nil
PLATINUM_CHECK_COOLDOWN = 15
mUpdatingPlatinum = false
mPlatinumCooldown = PLATINUM_CHECK_COOLDOWN
local v2 = {
	"PURCHASE_MARKET",
	"PURCHASE_VOID_TRADER",
	"PURCHASE_SYNDICATE_FAVOR",
	"PURCHASE_DAILY_DEAL",
	"PURCHASE_ARSENAL",
	"PURCHASE_PROFILE",
	"PURCHASE_HUB",
	"PURCHASE_VENDOR",
	"PURCHASE_APPEARANCE_PREVIEW",
	"PURCHASE_MUSEUM",
	"PURCHASE_OPERATOR",
	"PURCHASE_PLAYER_SHIP",
	"PURCHASE_CREWSHIP",
	"PURCHASE_MENU_STYLE",
	"PURCHASE_MENU_HUD",
	"PURCHASE_CHAT",
	"PURCHASE_INVENTORY",
	"PURCHASE_STAR_CHART"
}
local v3 = {
	Timer = -1,
	InTime = 0,
	OutTime = 0,
	FinalVal = 0,
	FullCallback = nil
}
local v4 = nil
local v5 = {
	WORLD_STATE_CALLBACK_IDENTIFIER = Symbol("BackgroundMovie"),
	mWorldStateLastNightmareSeed = nil,
	mWorldStateLastGhostTowerSeed = nil,
	mWorldStateLastEliteAlertSeed = nil,
	mWorldStateCallbackRegistered = false,
	mForceRefreshWorldStatePostLogin = false
}
local v6 = 3
local flag = false
local v7 = nil
local v8 = {}
local v9 = 1
mProcessingOmegaWithPendingFingerprint = nil
mNewIdentifiedOmegaMods = nil
mOmegaWithPendingFingerprints = nil
mCheckingForIdentifiedOmegaMods = nil
mShowingIdentifiedOmegaModsDiorama = nil
mShouldShowDiorama = nil
local v10 = false
local v11 = nil
local v12 = {
	Loader = nil,
	IsLoading = false,
	QueuedTransmission = nil,
	SoundInst = nil,
	WaitingTransmissions = {},
	DelayTime = 0,
	Callbacks = {},
	Playing = false
}
local v13 = { Avatar = nil, TargetPos = Vector() }
mAdditionalScreenCreated = false
mNewFriendRequests = false
mFriendRequests = {}
mFriendRequestActiveNotification = nil
local v14 = {
	mBoosterPackResults = {},
	mCurrentPack = 0,
	mNumberOfCardsInPack = 0,
	mBoosterPackItemString = "",
	mNumberOfPacksToProcess = 0,
	mTotalPacksToProcess = 0
}
local v15 = {
	Loader = nil,
	IsLoading = false,
	LoaderProgress = {
		RoomLoaderIndex = 1,
		DecoLoaderIndex = 1,
		RoomCreationIndex = 1,
		DecoCreationIndex = 1,
		DecosLoaded = {},
		LastLoad = false
	}
}
local v16 = { Loader = nil, IsLoading = false, IsFishTank = false }
local v17 = {
	Figures = {},
	PresetInfos = {},
	PresetIds = {},
	EnemyFigures = {},
	EnemyTypes = {}
}
local v18 = { Loader = nil, IsLoading = false }
local v19 = { Loader = nil, IsLoading = false, Upgrades = {} }
local v20 = {
	movie = nil,
	timerId = nil,
	timeToCheckDelay = 0.2,
	timeOpen = 0,
	minimumDisplayTime = 2
}
local v21 = nil
local fn
local v22 = {
	REGULAR_CREDITS = "Credits",
	PREMIUM_CREDITS = "Platinum",
	PRIME_BUCKS = "PrimeBucks",
	PRIME_TOKENS = "PrimeTokens",
	STANDING = "Standing",
	AMBULAS_DATA = "AmbulasData",
	ITEMS = "Items"
}
local v23 = { DEFAULT = 0, OVERRIDE = 1, QUEUE = 2, FORCE_QUEUE = 3 }
mRefreshHighPriorityMessages = 1
mHighPriorityMessageDelay = 1
mBoughtShipFeatureItem = false
local fn2
local fn3
local fn4
local v24 = false
local v25 = nil
local v26 = nil
local v27 = Symbol("TennoConRelay")
local v28 = Symbol("TennoConRelayB")
local v29 = nil
local v30 = false
local count = 0
_T.Notifications = nil
_T.remoteSuitEntities = {}
_T.ActiveQuestLoaded = false
local fn5
_T.NeedsGoalCheck = nil
local v31 = Symbol("PersonalQuartersRoom")
local v32 = WeakResource("/Lotus/Types/Game/ActionFigurePlaceableAreaTrigger")
local v33 = WeakResource("/Lotus/Types/Items/ShipDecos/Vignettes/Warframes/WarframeAFItem")

function Shutdown()
	mControl.Shutdown = true

	if not __wf_atom_7e8ad928(mToolTip) then
		mToolTip:Close()
	end

	if not __wf_atom_7e8ad928(mInfoPopup) then
		mInfoPopup:Close()
	end

	if not __wf_atom_7e8ad928(mBlockingTaskPopup) then
		mBlockingTaskPopup:Close()
	end

	if not __wf_atom_7e8ad928(mStyleBackgroundMovie) then
		mStyleBackgroundMovie:Close()
	end

	if not __wf_atom_7e8ad928(mNotificationsMovie) then
		mNotificationsMovie:Close()
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	if
		mUIInputEnableTimer ~= nil
		and not __wf_atom_7e8ad928(mTimerMgr)
		and mTimerMgr.mTimers[mUIInputEnableTimer] ~= nil
	then
		mTimerMgr.mTimers[mUIInputEnableTimer].Callback()
	end
end

local function fn6(credits, premiumCredits, purchasedPremiumCredits, primeTokens, playerXP)
	if _T.Credits ~= credits then
		_T.Credits = credits
	end

	if _T.PremiumCredits ~= premiumCredits then
		_T.PremiumCredits = premiumCredits
	end

	if _T.PurchasedPremiumCredits ~= purchasedPremiumCredits then
		_T.PurchasedPremiumCredits = purchasedPremiumCredits
	end

	if _T.PrimeTokens ~= primeTokens then
		_T.PrimeTokens = primeTokens
	end

	if _T.PlayerXP ~= playerXP then
		_T.PlayerXP = playerXP
	end
end

function PurchasePlatinumFailed() end

local function fn7()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v34

	if module2.IsDevServer() or module2.IsLocalServer() then
		v34 = "https://dev.soulframe.com/gameplatinum?"
	elseif module2.IsTestServer() then
		v34 = "https://test.soulframe.com/gameplatinum?"
	elseif Engine.__wf_atom_578fc9dd() then
		v34 = "https://store.wf.qq.com/?module=recharge"
	else
		v34 = "https://soulframe.com/gameplatinum?"
	end

	local v35 = __wf_atom_18a5d83b:__wf_atom_c80df685() .. __wf_atom_18a5d83b:__wf_atom_93547e3b()
	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	local v36 = __wf_atom_7e8ad928(__wf_atom_9be88b01) and ""
		or "&couponSku=" .. tostring(__wf_atom_9be88b01:__wf_atom_ff62ea3d().mCouponSku)
	local v37 = Engine.__wf_atom_eecb6143() and "&epic=1" or ""
	local v38, v39

	if Engine.__wf_atom_84bb79c2() then
		v38, v39 = module.DoShowPlatformStore("")
	elseif Engine.__wf_atom_e43a530e() then
		v38, v39 = module.DoShowPlatformStore("PLATINUM")
	elseif Engine.__wf_atom_b290ec01() then
		v38, v39 = module.DoShowPlatformStore("PLATINUM")
	elseif Engine.__wf_atom_578fc9dd() then
		v38, v39 = module.DoShowPlatformStore(v34)
	else
		v38, v39 = module.DoShowPlatformStore(v34 .. v35 .. v36 .. v37)
	end

	if not v38 then
		module.ShowMessage(v39, "PurchasePlatinumFailed")
	end
end

function OnPurchasePlatinum()
	fn7()
end

function PurchasePlatinumOk(p)
	if tonumber(p) == 4 then
		fn7()

		if __wf_atom_21342f4a ~= nil and mPurchaseOrigin ~= nil then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("INSUFFICIENT_PLAT_POPUP"), mPurchaseOrigin .. "_STORE_OK")
		end
	elseif __wf_atom_21342f4a ~= nil and mPurchaseOrigin ~= nil then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("INSUFFICIENT_PLAT_POPUP"), mPurchaseOrigin .. "_STORE_CANCEL")
	end

	mPurchaseOrigin = nil
end

local function fn8(p)
	local v34 = Engine.__wf_atom_b290ec01() and "/Lotus/Language/Menu/Store_LaunchingBrowser_Switch"
		or "/Lotus/Language/Menu/Store_LaunchingBrowser_Windows"
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			local __wf_atom_ff62ea3d = __wf_atom_9be88b01:__wf_atom_ff62ea3d()
			local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(__wf_atom_ff62ea3d.mExpiry)

			if __wf_atom_db2b0cee > 0 then
				v34 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_LaunchingBrowserDiscount_Windows", false, {
					TIMELEFT = module2.SecondsToFormattedTime(mMovie, __wf_atom_db2b0cee, "HoursOrMinutes")
				})
			end
		end
	end

	mPurchaseOrigin = p
	module.ShowConfirmMessage(v34, "PurchasePlatinumOk")
end

function PurchasePlatinumWithDialog(p)
	fn8(p)
end

function PurchasePrimeAccessPS4()
	if Engine.__wf_atom_e43a530e() then
		local v34, v35

		if Engine.__wf_atom_e43a530e() then
			v34, v35 = module.DoShowPlatformStore("PRIME_ACCESS")
		else
			v34 = false
			v35 = ""
		end

		if not v34 then
			module.ShowMessage(v35, "PurchasePlatinumFailed")
		end
	end
end

local function fn9(p, p2, genericVendor_NameOverride, p3, p4)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	local v34

	if p == v22.PRIME_BUCKS then
		v34 = "/Lotus/Language/Menu/Global_InsufficientPrimeBucks"
	elseif p == v22.PREMIUM_CREDITS then
		mPurchaseOrigin = p4
		dialogSettings.dialogType = 0
		v34 = p2 and "/Lotus/Language/Menu/Global_InsufficientPurchasedPlatinum"
			or not p3 and "/SF/Language/SystemMessages/InsufficientPremiumCurrency"
			or genericVendor_NameOverride
	elseif p == v22.REGULAR_CREDITS then
		v34 = "/Lotus/Language/Menu/Global_InsufficientCredits"
	elseif p == v22.STANDING then
		v34 = "/Lotus/Language/Menu/Global_InsufficientStanding"
	elseif p == v22.PRIME_TOKENS then
		v34 = "/Lotus/Language/Store/Global_InsufficientPrimeTokens"
	else
		v34 = "/Lotus/Language/Menu/Global_InsufficientFunds"
	end

	if genericVendor_NameOverride == nil then
		if _T.GenericVendor_NameOverride then
			genericVendor_NameOverride = _T.GenericVendor_NameOverride
			_T.GenericVendor_NameOverride = nil
		else
			local module16 = require("Lotus.Interface.StoreItemUtilities")
			genericVendor_NameOverride = module16.GetLocalizedItemName(mMovie, mPurchaseParams.mStoreItem)
		end
	end

	dialogSettings.titleString = "/Lotus/Language/Menu/PurchaseFailure_InsufficientFunds"
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384(v34, false, {
		ITEM = "<font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">" .. genericVendor_NameOverride .. "</font>"
	})
	dialogSettings:SetCallback("ConfirmPopup")
	module.ShowCustomMessage(dialogSettings)
	_T.PurchaseSuccessLocOverride = nil
end

function ShowInsufficientFundsPopup(p, p2, p3, p4, p5)
	v = nil
	fn9(p, module.Ternary(tonumber(p2) == 1, true, false), p3, p4, p5)
end

local function fn10()
	local _, v34 = module2.IsXPLocked(mPurchaseParams.mStoreItem)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		tostring(mPurchaseParams.mStoreItem:__wf_atom_014a76a2()),
		false
	)
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/BuyItem_XPNeeded", false, {
		ITEM_NAME = __wf_atom_8e9ac384,
		XP_REQUIRED = v34,
		XP_CURRENT = __wf_atom_9be88b01:__wf_atom_a04e4a53()
	})
	module.ShowMessage(__wf_atom_8e9ac384_2, "ConfirmPopup")
end

local function fn11(mSourceId)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v34

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v34 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	if __wf_atom_7e8ad928(v34) then
		return nil
	end

	local __wf_atom_92662866 = v34:__wf_atom_92662866()

	if __wf_atom_7e8ad928(__wf_atom_92662866) then
		return nil
	end

	for _, mVoidTrader in ipairs(__wf_atom_92662866.mVoidTraders) do
		if tostring(mSourceId) == mVoidTrader.mId.mId then
			return mVoidTrader
		end
	end

	return nil
end

local function fn12(mSourceId)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v34

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v34 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	if __wf_atom_7e8ad928(v34) then
		return nil
	end

	local __wf_atom_92662866 = v34:__wf_atom_92662866()

	if __wf_atom_7e8ad928(__wf_atom_92662866) then
		return nil
	end

	local v35 = tostring(mSourceId)

	for _, mPrimeVaultTrader in ipairs(__wf_atom_92662866.mPrimeVaultTraders) do
		if v35 ~= mPrimeVaultTrader.mId.mId then
			continue
		end

		local v36

		if Engine.__wf_atom_db2b0cee(mPrimeVaultTrader.mExpiry) > 0 then
			v36 = mPrimeVaultTrader.mManifest
		else
			v36 = mPrimeVaultTrader.mNextManifest
		end

		return mPrimeVaultTrader, v36
	end

	return nil
end

local function fn13(p)
	return p.mSource == 0
		or p.mSource == 4
		or p.mSource == 5
		or p.mSource == 6
		or p.mSource == 8
		or p.mSource == 10
		or p.mSource == 11
		or p.mSource == 12
		or p.mSource == 13
		or p.mSource == 14
		or p.mSource == 15
		or p.mSource == 16
		or p.mSource == 17
		or p.mSource == 19
		or p.mSource == 20
		or p.mSource == 21
		or p.mSource == 22
		or p.mSource == 23
end

local function fn14(data)
	local result = {}
	local result2 = {}
	local mQuantityMultiplier = 1
	mBaseSourceType = data.mSource

	if fn13(data) then
		local v34

		if data.mStoreItem:__wf_atom_327344dd() then
			v34 = mPurchaseParams.mDurability
		end

		local storeItemPriceObject = module2.GetStoreItemPriceObject(data.mStoreItem, v34, _T.purchasedItems)

		if storeItemPriceObject.FinalPrice.Premium > 0 and data.mUsePremium then
			result[v22.PREMIUM_CREDITS] = storeItemPriceObject.FinalPrice.Premium * data.mQuantity
			result2[v22.PREMIUM_CREDITS] = storeItemPriceObject.FinalPrice.Premium
			return result, result2, mQuantityMultiplier
		elseif storeItemPriceObject.FinalPrice.Credits > 0 and not data.mUsePremium then
			result[v22.REGULAR_CREDITS] = storeItemPriceObject.FinalPrice.Credits * data.mQuantity
			result2[v22.REGULAR_CREDITS] = storeItemPriceObject.FinalPrice.Credits
			return result, result2, mQuantityMultiplier
		else
			return nil
		end
	else
		if data.mSource == 1 then
			local v34 = fn11(data.mSourceId)

			if not v34 then
				return nil
			end

			local forcePrimeBucksPrice = nil
			local forceRegularPrice = nil

			if data.mExtraPurchaseInfoJson ~= "" then
				local decoded = cjson.decode(data.mExtraPurchaseInfoJson)

				if decoded.ForcePrimeBucksPrice ~= nil then
					forcePrimeBucksPrice = decoded.ForcePrimeBucksPrice
				end

				if decoded.ForceRegularPrice ~= nil then
					forceRegularPrice = decoded.ForceRegularPrice
				end
			end

			if forcePrimeBucksPrice == nil then
				for _, v36 in ipairs(v34.mManifest) do
					if v36.mItemType ~= data.mStoreItem then
						continue
					end

					if v36.mPrimePrice > 0 then
						result[v22.PRIME_BUCKS] = v36.mPrimePrice * data.mQuantity
						result2[v22.PRIME_BUCKS] = v36.mPrimePrice
					end

					if v36.mRegularPrice > 0 then
						result[v22.REGULAR_CREDITS] = v36.mRegularPrice * data.mQuantity
						result2[v22.REGULAR_CREDITS] = v36.mRegularPrice
					end

					if v36.mItemPrices == nil then
						break
					end

					result[v22.ITEMS] = v36.mItemPrices

					for i = 1, #result[v22.ITEMS] do
						result[v22.ITEMS][i].mItemCount = result[v22.ITEMS][i].mItemCount * data.mQuantity
					end

					result2[v22.ITEMS] = v36.mItemPrices
					break
				end
			else
				result[v22.PRIME_BUCKS] = forcePrimeBucksPrice * data.mQuantity
				result2[v22.PRIME_BUCKS] = forcePrimeBucksPrice

				if forceRegularPrice ~= nil then
					result[v22.REGULAR_CREDITS] = forceRegularPrice * data.mQuantity
					result2[v22.REGULAR_CREDITS] = forceRegularPrice
				end
			end

			if not (result[v22.PRIME_BUCKS] or result[v22.REGULAR_CREDITS] or result[v22.ITEMS]) then
				return nil
			end
		elseif data.mSource == 18 then
			local v34, mEvergreenManifest = fn12(data.mSourceId)

			if not v34 then
				return nil
			end

			local v35 = 1
			local v36 = false

			while true do
				for _, v38 in ipairs(mEvergreenManifest) do
					if v38.mItemType ~= data.mStoreItem then
						continue
					end

					if v38.mPrimePrice > 0 then
						result[v22.PRIME_TOKENS] = v38.mPrimePrice * data.mQuantity
						result2[v22.PRIME_TOKENS] = v38.mPrimePrice
					end

					if v38.mRegularPrice > 0 then
						local mItemType = WeakResource("/Lotus/Types/Items/MiscItems/SchismKey")
						result[v22.ITEMS] = {
							{
								mItemType = mItemType,
								mItemCount = v38.mRegularPrice * data.mQuantity
							}
						}
						result2[v22.ITEMS] = {
							{ mItemType = mItemType, mItemCount = v38.mRegularPrice }
						}
					end

					v36 = true
					break
				end

				if v36 or v35 >= 2 then
					break
				end

				mEvergreenManifest = v34.mEvergreenManifest
				v35 = 2
			end

			if not (result[v22.PRIME_TOKENS] or result[v22.ITEMS]) then
				return nil
			end
		elseif data.mSource == 2 then
			if not data.mSyndicateTag:__wf_atom_8598f3a9() then
				return nil
			end

			local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(data.mSyndicateTag)

			if __wf_atom_7e8ad928(__wf_atom_13d5b7e9) then
				return nil
			end

			if data.mUseFreeFavor then
				if data.mQuantity > 1 then
					return nil
				end

				return {}, {}
			else
				local v34 = Resource(__wf_atom_13d5b7e9:__wf_atom_07c7a1cc())
				local v35

				if data.mIsSupplyDrop then
					v35 = v34:__wf_atom_649a832c()
				else
					v35 = v34:__wf_atom_b756630a()
				end

				for _, v36 in ipairs(v35) do
					if v36.storeItem ~= data.mStoreItem then
						continue
					end

					if v36.standingCost > 0 then
						result[v22.STANDING] = v36.standingCost * data.mQuantity
						result2[v22.STANDING] = v36.standingCost
					end

					if v36.creditsCost > 0 then
						result[v22.REGULAR_CREDITS] = v36.creditsCost * data.mQuantity
						result2[v22.REGULAR_CREDITS] = v36.creditsCost
					end

					break
				end

				if not (result[v22.STANDING] or result[v22.REGULAR_CREDITS]) then
					return nil
				end
			end
		elseif data.mSource == 3 then
			local dailyDeal = module2.GetDailyDeal()

			if
				__wf_atom_7e8ad928(dailyDeal)
				or dailyDeal.mStoreItem ~= data.mStoreItem
				or dailyDeal.mSalePrice <= 0
			then
				return nil
			end

			result[v22.PREMIUM_CREDITS] = dailyDeal.mSalePrice * data.mQuantity
			result2[v22.PREMIUM_CREDITS] = dailyDeal.mSalePrice
			return result, result2, mQuantityMultiplier
		elseif data.mSource == 7 then
			local v34 = WeakResource("/Lotus/Types/Items/Events/AmbulasDataFragment")
			local mItemManifest = nil
			local v35 = Resource(data.mSourceId)

			if __wf_atom_7e8ad928(v35) then
				local __wf_atom_5b817062 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_5b817062(
					nil,
					data.mSourceId
				)

				if tostring(__wf_atom_5b817062.mId) == data.mSourceId then
					mItemManifest = __wf_atom_5b817062.mItemManifest
				end
			else
				mItemManifest = v35:__wf_atom_9af0765f()
			end

			if __wf_atom_7e8ad928(mItemManifest) then
				return nil
			end

			local mStoreItem = data.mStoreItem
			local itemId = nil

			if data.mExtraPurchaseInfoJson ~= "" then
				local decoded = cjson.decode(data.mExtraPurchaseInfoJson)

				if decoded.ItemId ~= nil then
					itemId = decoded.ItemId
				end
			end

			local v36 = false

			for i = 1, #mItemManifest do
				local v37 = mItemManifest[i]

				if not (not __wf_atom_7e8ad928(itemId) and itemId == tostring(v37.mId) or __wf_atom_7e8ad928(itemId) and v37.mStoreItem == mStoreItem) then
					continue
				end

				if v37.mRegularPrice.minValue == v37.mRegularPrice.maxValue and v37.mRegularPrice.maxValue > 0 then
					result[v22.REGULAR_CREDITS] = v37.mRegularPrice.maxValue * data.mQuantity
					result2[v22.REGULAR_CREDITS] = v37.mRegularPrice.maxValue
					v36 = true
				end

				if v37.mPremiumPrice.minValue == v37.mPremiumPrice.maxValue and v37.mPremiumPrice.maxValue > 0 then
					result[v22.PREMIUM_CREDITS] = v37.mPremiumPrice.maxValue * data.mQuantity
					result2[v22.PREMIUM_CREDITS] = v37.mPremiumPrice.maxValue
					v36 = true
				end

				if v37.mItemPrices ~= nil then
					result[v22.ITEMS] = v37.mItemPrices
					result2[v22.ITEMS] = v37.mItemPrices
					v36 = true

					for j = 1, #result[v22.ITEMS] do
						if result[v22.ITEMS][j].mItemType == v34 then
							result[v22.AMBULAS_DATA] = v37.mExtraCurrencyPrice * data.mQuantity
							result2[v22.AMBULAS_DATA] = v37.mExtraCurrencyPrice
						else
							result[v22.ITEMS][j].mItemCount = result[v22.ITEMS][j].mItemCount * data.mQuantity

							if result[v22.ITEMS][j].mItemCount <= 0 then
								v36 = false
							end
						end
					end
				end

				if v37.mFocusXpCost.mCost > 0 then
					result[v22.FOCUS_XP] = v37.mFocusXpCost.mCost * data.mQuantity
					result2[v22.FOCUS_XP] = v37.mFocusXpCost.mCost
					v36 = true
				end

				if v37.mStandingCost ~= nil and v37.mStandingCost > 0 then
					result[v22.STANDING] = v37.mStandingCost * data.mQuantity
					result2[v22.STANDING] = v37.mStandingCost
					v36 = true
				end

				mQuantityMultiplier = v37.mQuantityMultiplier
				break
			end

			if not v36 then
				return nil
			end
		end

		return result, result2, mQuantityMultiplier
	end
end

function _GetPurchasePrice(p)
	local v34, v35, v36 = fn14(p)
	return v34, v35, v36 == nil and 1 or v36
end

function OnSaveLoadOutComplete(_, _)
	module2.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	local menuSuitAvatar = _T.MenuSuitAvatar

	if __wf_atom_7e8ad928(menuSuitAvatar) then
		menuSuitAvatar = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(menuSuitAvatar) then
		menuSuitAvatar:__wf_atom_d2b2176d():__wf_atom_cac3dd53(false)
		menuSuitAvatar:__wf_atom_d2b2176d():BuildLoadOut(gGameData:__wf_atom_a4299765(), 0)

		if module2.IsInHub() then
			local v34 = "{\"loadout\":" .. gGameRules:__wf_atom_67d15da1() .. "}"
			gGameRules:SendControlMessage(v34)
			gGameRules:__wf_atom_59e54957(menuSuitAvatar)
		end
	end
end

function AddToGear(p)
	if p == 4 and not __wf_atom_7e8ad928(gGameData) then
		local item = mPurchaseParams.mStoreItem:GetItem()

		if table.find(gGameData:GetInventory():__wf_atom_9609a8a9(), item) == nil then
			gGameData:__wf_atom_a6b3ae2b(item)
			gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
		end
	end

	mPurchaseParams = nil
end

local function fn15(p)
	mPurchasePopupMovie = nil

	if not __wf_atom_7e8ad928(v) then
		v(p, mPurchaseParams)
	end

	if p and mPurchaseParams.mStoreItem:__wf_atom_3469befe() then
		AddToGear(4)
	else
		mPurchaseParams = nil
	end

	mQuantityToReceive = 1
	_T.purchasedItems = nil
	_T.PurchaseSuccessLocOverride = nil
end

function GetPriceStrings(p, items, p2)
	local v34 = {
		[v22.REGULAR_CREDITS] = "<DRACS>",
		[v22.PREMIUM_CREDITS] = "<PREMIUM_CURRENCY>",
		[v22.PRIME_BUCKS] = "<PRIME_BUCKS>",
		[v22.PRIME_TOKENS] = "<PRIME_TOKENS>",
		[v22.STANDING] = "<REPUTATION>",
		[v22.AMBULAS_DATA] = "<AMBULAS_DATA>"
	}
	local v35 = { [v22.REGULAR_CREDITS] = _G.UIColor_Yellow, [v22.PREMIUM_CREDITS] = 8157165 }
	local v36 = {
		v22.AMBULAS_DATA,
		v22.STANDING,
		v22.PRIME_BUCKS,
		v22.PREMIUM_CREDITS,
		v22.REGULAR_CREDITS,
		v22.ITEMS
	}
	local uiColor_Yellow = _G.UIColor_Yellow
	local v37 = {}
	local v38 = ""
	local v39 = ""
	local v40 = true

	for k, item in pairs(items) do
		if type(item) == "table" then
			continue
		end

		v37[k] = item / p2

		if math.floor(v37[k]) * p2 == item then
			continue
		end

		v37 = items
		v40 = false
		break
	end

	local v42 = true

	for _, v43 in ipairs(v36) do
		if v43 == v22.ITEMS then
			if p[v43] then
				v42 = false

				for i = 1, #p[v43] do
					local v44 = p[v43][i]
					local v45 = Resource(v44.mItemType)

					if v38 ~= "" then
						v38 ..= "\r"
					end

					v38 ..= mMovie:__wf_atom_8e9ac384(tostring(v45:__wf_atom_014a76a2()), false)

					if v44.mItemCount > 1 then
						v38 ..= " x " .. v44.mItemCount
					end
				end
			end
		else
			if v37[v43] and v37[v43] > 0 then
				v42 = false

				if v39 ~= "" then
					v39 ..= " + "
				end

				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v34[v43], true)

				if v35[v43] then
					uiColor_Yellow = v35[v43]
				end

				v39 ..= __wf_atom_8e9ac384 .. module.FormatNumber(v37[v43])
			end

			if p[v43] and p[v43] > 0 then
				v42 = false

				if v38 ~= "" then
					v38 ..= " + "
				end

				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v34[v43], true)

				if v35[v43] then
					uiColor_Yellow = v35[v43]
				end

				v38 ..= __wf_atom_8e9ac384 .. module.FormatNumber(p[v43])
			end
		end
	end

	return v39, v38, uiColor_Yellow, v42, v40
end

local function fn16(p) -- 1 equivalent call inferred from this helper
	return "<font >" .. p .. "</font>"
end

local function fn17(p, p2) -- 3 equivalent calls inferred from this helper
	return "<font face=\"Spectral SC\" color=\"" .. p2 .. "\">" .. p .. "</font>"
end

local function fn18()
	if mPurchaseParams.mSkipConfirm then
		mMovie:Execute("ConfirmPurchase", (tostring(4)))
		return
	end

	local _uiColor_Yellow = _G.UIColor_Yellow
	local v34 = mPurchaseQuantityMultiplier * mPurchaseParams.mStoreItem:__wf_atom_17d97bf6()

	if mPurchaseParams.mProratePercent then
		v34 = math.round(v34 * (1 - mPurchaseParams.mProratePercent))
	end

	local v35, v36, v37, v38, v39 = GetPriceStrings(mPurchaseTotalPrice, mPurchaseUnitPrice, v34)
	local module16 = require("Lotus.Interface.StoreItemUtilities")
	local localizedItemName = module16.GetLocalizedItemName(mMovie, mPurchaseParams.mStoreItem)

	if mPurchaseParams.mStoreItem:__wf_atom_327344dd() then
		if
			not mPurchaseParams.mStoreItem:GetItem():IsA(__wf_atom_f9559e3c)
			or Resource(mPurchaseParams.mStoreItem:GetItem()):__wf_atom_4eb36b35()
		then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Global_DurabilityPermanent",
				false
			)
			local __wf_atom_805f7d55 = __wf_atom_c67f9605:__wf_atom_805f7d55(mPurchaseParams.mDurability)
			local v40

			if __wf_atom_805f7d55 == 259200 then
				v40 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_3Days", false)
			elseif __wf_atom_805f7d55 == 604800 then
				v40 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_7Days", false)
			else
				v40 = module.Ternary(
					__wf_atom_805f7d55 > 0,
					module2.SecondsToFormattedTime(mMovie, __wf_atom_805f7d55, true),
					__wf_atom_8e9ac384
				)
			end

			localizedItemName = v40 .. " " .. localizedItemName
		else
			local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(mPurchaseParams.mDurability)
			localizedItemName ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
				NUM_USES = __wf_atom_5df94bc3
			}) .. ")"
		end
	end

	local v40 = fn17(localizedItemName, module.ConvertColorNumberToHex(_G.UIColor_Yellow)) -- inferred equivalent call
	local v41 = fn17(v35, module.ConvertColorNumberToHex(v37)) -- inferred equivalent call
	local price = fn17(v36, module.ConvertColorNumberToHex(v37)) -- inferred equivalent call
	local v43 = {
		ITEM = v40,
		QUANTITY = mQuantityToReceive * v34,
		UNIT_PRICE = v41,
		PRICE = price
	}
	local v44

	if mPurchaseParams.mSource == 2 and v38 then
		v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreePurchaseConfirmation", false, v43)
	elseif mQuantityToReceive > 1 then
		if mQuantityToReceive == mPurchaseParams.mQuantity then
			if v39 then
				v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_MultiPurchaseConfirmation", false, v43)
			else
				v44 = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/Global_MultiBundlePurchaseConfirmation",
					false,
					v43
				)
			end
		else
			v43.QUANTITY_BOUGHT = mPurchaseParams.mQuantity
			v43.QUANTITY_FREE = mQuantityToReceive - mPurchaseParams.mQuantity
			v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_BogoPurchaseConfirmation", false, v43)
		end
	else
		if v43.QUANTITY > 1 then
			v43.ITEM = v40 .. " x " .. v43.QUANTITY
		end

		v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_PurchaseConfirmation", false, v43)
	end

	if mPurchaseParams.mConfirmMsgOverride ~= "" then
		v44 = mMovie:__wf_atom_8e9ac384(mPurchaseParams.mConfirmMsgOverride, false, v43)
	end

	local _ = fn16(v44) -- inferred equivalent call
	module.ShowYesOrNoMessage(v44, "ConfirmPurchase", nil, "/Lotus/Language/Menu/DetailedPurchase_PurchaseConfirmTitle")
end

function OnPurchaseSlotResult(p, _)
	fn3(0)

	if p then
		module.PlaySound(_G.UISound_Purchase)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				fn6(
					__wf_atom_9be88b01:__wf_atom_7050e489(),
					__wf_atom_9be88b01:__wf_atom_330e9cb9(),
					__wf_atom_9be88b01:__wf_atom_f9580127(),
					__wf_atom_9be88b01:__wf_atom_edca9dbf(),
					__wf_atom_9be88b01:__wf_atom_d5bed0b3()
				)

				if mPurchaseParams ~= nil then
					mMovie:Execute("CheckPurchaseRequirements", "")
				end
			end
		end
	else
		_T.PurchaseSuccessLocOverride = nil
		module.ShowMessage("/Lotus/Language/Menu/PurchaseFailure")
	end

	mWebCmd = nil
end

function ConfirmSlotPurchase(p)
	if p == 4 and mPurchaseParams ~= nil then
		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("SLOT_PROMPT_POPUP"), "Baro_" .. mBinType .. "_Purchase")
		end

		local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(mPurchaseParams.mStoreItem:__wf_atom_efa6f447())

		if __wf_atom_8c8df26f >= 6 then
			_T.PurchaseSuccessLocOverride = nil
			return
		end

		if __wf_atom_c67f9605:__wf_atom_aef0223f(__wf_atom_8c8df26f) > _T.PremiumCredits then
			fn9(
				v22.PREMIUM_CREDITS,
				false,
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ItemInventory_SlotsMisc", true)
			)
			return
		end

		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01()))) then
			fn3(1)
			assert(mWebCmd == nil)
			mWebCmd = SF.InventoryExpansionCommand(__wf_atom_8c8df26f, "OnPurchaseSlotResult")
			mWebCmd:Execute()
		end
	else
		_T.PurchaseSuccessLocOverride = nil

		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("SLOT_PROMPT_POPUP"), "Baro_" .. mBinType .. "_Cancel")
		end
	end
end

local function fn19()
	local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(mPurchaseParams.mStoreItem:__wf_atom_efa6f447())

	if __wf_atom_8c8df26f >= 6 then
		return
	end

	local __wf_atom_aef0223f = __wf_atom_c67f9605:__wf_atom_aef0223f(__wf_atom_8c8df26f)
	local __wf_atom_d615c478 = __wf_atom_c67f9605:__wf_atom_d615c478(__wf_atom_8c8df26f)
	mBinType = module2.GetSlotType(__wf_atom_8c8df26f)
	module.ShowYesOrNoMessage(
		mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_InsufficientSlotPurchase", true, {
			COUNT = __wf_atom_d615c478,
			COST = __wf_atom_aef0223f
		}),
		"ConfirmSlotPurchase"
	)
end

function OnInvalidBinError(p)
	module2.HandleInvalidBinErrorResponse(p)
end

local function fn20(inventory, p, p2, p3)
	if __wf_atom_7e8ad928(inventory) then
		_T.PurchaseSuccessLocOverride = nil
		return false
	end

	local __wf_atom_dae75ebc = __wf_atom_c67f9605:__wf_atom_dae75ebc(p)
	local __wf_atom_a04e4a53 = gGameData:__wf_atom_a04e4a53()

	if not (__wf_atom_dae75ebc > 0 and __wf_atom_dae75ebc < p2 + inventory:__wf_atom_21e5b95f(p)) then
		return true
	end

	if p == 4 and __wf_atom_a04e4a53 >= 30 then
		__wf_atom_dae75ebc += 30
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p3, false, {
		MAX = module.FormatNumber(__wf_atom_dae75ebc + __wf_atom_c67f9605:__wf_atom_121506d6(p))
	})
	module.ShowMessage(__wf_atom_8e9ac384)
	_T.PurchaseSuccessLocOverride = nil
	return false
end

local function fn21()
	if mPurchaseTotalPrice == nil then
		return
	end

	local v34 = false

	if module2.IsXPLocked(mPurchaseParams.mStoreItem) and mPurchaseParams.mSource ~= 18 then
		fn10()
		return
	end

	local inventory

	if not __wf_atom_7e8ad928(gGameData) then
		inventory = gGameData:GetInventory()
		fn6(
			gGameData:__wf_atom_7050e489(),
			gGameData:__wf_atom_330e9cb9(),
			gGameData:__wf_atom_f9580127(),
			gGameData:__wf_atom_edca9dbf(),
			gGameData:__wf_atom_d5bed0b3()
		)
	end

	if mPurchaseParams.mStoreItem:__wf_atom_efa6f447() == 19 then
		local v35 = math.round(mPurchaseParams.mStoreItem:__wf_atom_17d97bf6() * (1 - mPurchaseParams.mProratePercent))

		if not fn20(
			inventory,
			mPurchaseParams.mStoreItem:__wf_atom_987be644(),
			v35,
			"/Lotus/Language/Menu/BuyItem_ExceedBinMaxCapacity"
		) then
			return
		end
	elseif mPurchaseParams.mStoreItem:__wf_atom_efa6f447() == 30 and mPurchaseParams.mStoreItem:GetItem():IsA(v33) then
		if __wf_atom_7e8ad928(inventory) then
			_T.PurchaseSuccessLocOverride = nil
			return
		end

		if module2.GetNumOwned(gGameData, inventory, mPurchaseParams.mStoreItem, _T.purchasedItems) + mPurchaseParams.mQuantity * mPurchaseParams.mStoreItem:__wf_atom_17d97bf6() > 34 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/BuyItem_ExceedShipDecoCapacity",
				false
			)
			module.ShowMessage(__wf_atom_8e9ac384)
			_T.PurchaseSuccessLocOverride = nil
			return
		end
	end

	if
		mPurchaseTotalPrice[v22.REGULAR_CREDITS]
		and _T.Credits ~= nil
		and mPurchaseTotalPrice[v22.REGULAR_CREDITS] > _T.Credits
	then
		fn9(v22.REGULAR_CREDITS)
		return
	end

	if mPurchaseTotalPrice[v22.PREMIUM_CREDITS] then
		if mPurchaseTotalPrice[v22.PREMIUM_CREDITS] > module.Ternary(
			mPurchaseParams.mStoreItem:__wf_atom_a50336df(),
			_T.PremiumCredits,
			_T.PurchasedPremiumCredits
		) then
			fn9(v22.PREMIUM_CREDITS, not mPurchaseParams.mStoreItem:__wf_atom_a50336df())
			return
		else
			v34 = true
		end
	end

	if
		mPurchaseTotalPrice[v22.PRIME_BUCKS]
		and not __wf_atom_7e8ad928(gGameData)
		and mPurchaseTotalPrice[v22.PRIME_BUCKS] > gGameData:__wf_atom_5727c53b()
	then
		fn9(v22.PRIME_BUCKS)
		return
	end

	if mPurchaseTotalPrice[v22.PRIME_TOKENS] then
		if
			__wf_atom_7e8ad928(gGameData)
			or not (mPurchaseTotalPrice[v22.PRIME_TOKENS] > gGameData:__wf_atom_edca9dbf())
		then
			v34 = true
		else
			fn9(v22.PRIME_TOKENS)
			return
		end
	end

	if mPurchaseTotalPrice[v22.STANDING] then
		if not mPurchaseParams.mSyndicateTag:__wf_atom_8598f3a9() then
			fn15(nil)
			return
		end

		local _, v35 = module2.GetReputationInfoForSyndicate(__wf_atom_c67f9605:__wf_atom_13d5b7e9(mPurchaseParams.mSyndicateTag))

		if v35 < mPurchaseTotalPrice[v22.STANDING] then
			fn9(v22.STANDING)
			return
		end
	end

	if mPurchaseTotalPrice[v22.AMBULAS_DATA] then
		local v35 = WeakResource("/Lotus/Types/Items/Events/AmbulasDataFragment")
		local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()
		local mItemCount = 0

		for i = 1, #__wf_atom_c84817dd do
			if __wf_atom_c84817dd[i].mItemType ~= v35 then
				continue
			end

			mItemCount = __wf_atom_c84817dd[i].mItemCount
			break
		end

		if mItemCount < mPurchaseTotalPrice[v22.AMBULAS_DATA] then
			fn9(v22.AMBULAS_DATA)
			return
		end
	end

	if mPurchaseTotalPrice[v22.ITEMS] then
		for i = 1, #mPurchaseTotalPrice[v22.ITEMS] do
			local v35 = mPurchaseTotalPrice[v22.ITEMS][i]

			if __wf_atom_7e8ad928(v35.mItemType) then
				continue
			end

			local binarySearch = module2.BinarySearch(_T.purchasedItems, v35.mItemType:__wf_atom_5b41f63b(), function(p)
				if p then
					return p.type
				end

				return nil
			end)
			local v36 = 0

			if binarySearch then
				for j = binarySearch[1], binarySearch[2] do
					if _T.purchasedItems[j].count then
						v36 += _T.purchasedItems[j].count
					else
						v36 = math.min(v36 + 1, 1)
					end
				end
			end

			if not (v36 < v35.mItemCount) then
				continue
			end

			fn9(v22.ITEMS)
			return
		end
	end

	if v34 or module2.HaveEnoughSlots(mPurchaseParams.mStoreItem:__wf_atom_efa6f447(), mQuantityToReceive) then
		fn18()
		return
	end

	local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(mPurchaseParams.mStoreItem:__wf_atom_efa6f447())

	if module2.VerifyInventorySlots(inventory, __wf_atom_8c8df26f) then
		if fn20(inventory, __wf_atom_8c8df26f, 1, "/Lotus/Language/Labels/BuyItem_BinCapacityReached") then
			fn19()
		end
	else
		_T.PurchaseSuccessLocOverride = nil
		module2.ShowInvalidBinError("OnInvalidBinError")
	end
end

function CheckPurchaseRequirements()
	fn21()
end

local function fn22()
	local mDurability = -1
	local count2 = 0
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 5
	dialogSettings.locString = "/Lotus/Language/Menu/Global_DurabilityConfirmation"
	mPurchaseParams.mUsePremium = true
	local boosterIsTimed

	if mPurchaseParams.mStoreItem:GetItem():IsA(__wf_atom_f9559e3c) then
		boosterIsTimed = Resource(mPurchaseParams.mStoreItem:GetItem()):__wf_atom_4eb36b35()

		if _T.GiftParams.Item ~= nil then
			_T.GiftParams.BoosterIsTimed = boosterIsTimed
		end
	else
		boosterIsTimed = true
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_DurabilityPermanent", false)

	for i = 0, 2 do
		mPurchaseParams.mDurability = i
		local v36, v37 = _GetPurchasePrice(mPurchaseParams)

		if not (v37 ~= nil and v36 ~= nil) then
			continue
		end

		local v38

		if v36[v22.PREMIUM_CREDITS] == nil then
			v38 = false
		else
			v38 = v36[v22.PREMIUM_CREDITS] > 0
		end

		local ternary = module.Ternary(v38, v36[v22.PREMIUM_CREDITS], v36[v22.REGULAR_CREDITS])
		count2 += 1
		local v39

		if boosterIsTimed then
			local __wf_atom_805f7d55 = __wf_atom_c67f9605:__wf_atom_805f7d55(i)
			local v40

			if __wf_atom_805f7d55 == 259200 then
				v40 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_3Days", false)
			elseif __wf_atom_805f7d55 == 604800 then
				v40 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_7Days", false)
			else
				v40 = module.Ternary(
					__wf_atom_805f7d55 > 0,
					module2.SecondsToFormattedTime(mMovie, __wf_atom_805f7d55, true),
					__wf_atom_8e9ac384
				)
			end

			v39 = v40 .. " " .. mMovie:__wf_atom_8e9ac384(
				module.Ternary(v38, "<PLATINUM_CREDITS>", "<CREDITS>") .. ternary,
				true
			)
		else
			local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(i)
			v39 = Localize("/Lotus/Language/Menu/Global_BoosterUses", {
				NUM_USES = __wf_atom_5df94bc3
			}) .. " " .. mMovie:__wf_atom_8e9ac384(
				module.Ternary(v38, "<PLATINUM_CREDITS>", "<CREDITS>") .. ternary,
				true
			)
		end

		mPurchaseParams.mExpectedPrice = ternary

		if count2 == 1 then
			dialogSettings.firstString = v39
		else
			dialogSettings.secondString = v39
		end

		mDurability = i
	end

	if count2 > 1 then
		dialogSettings.thirdString = "/Lotus/Language/Menu/ItemSelection_Cancel"
		dialogSettings:SetCallback("ConfirmDurability")
		module.ShowCustomMessage(dialogSettings)
	else
		mPurchaseParams.mDurability = mDurability
		local v36, v37, v38 = _GetPurchasePrice(mPurchaseParams)
		mPurchaseTotalPrice = v36
		mPurchaseUnitPrice = v37
		mPurchaseQuantityMultiplier = v38

		if mPurchaseTotalPrice == nil then
			fn15(nil)
		else
			fn21()
		end
	end
end

function ShowUpgradeDurabilityPopupForGifting()
	mPurchaseParams = SF.PurchaseParams()
	mPurchaseParams.mStoreItem = _T.GiftParams.Item
	mPurchaseParams.mSource = _T.GiftParams.Source

	if _T.GiftParams.CouponId ~= nil then
		mPurchaseParams.mCouponId.mId = _T.GiftParams.CouponId
	end

	fn22()
end

function ConfirmCurrency(p)
	if tonumber(p) == 5 then
		fn15(nil)
		return
	end

	if tonumber(p) == 4 then
		mPurchaseParams.mUsePremium = false
	else
		mPurchaseParams.mUsePremium = true
	end

	mMovie:Execute("BuyItem", "true")
end

function GetScreenStackSize()
	return #screenStack
end

local function fn23()
	local v34

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		v34 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)
	end

	local v35

	if not __wf_atom_7e8ad928(v34) then
		v35 = v34:__wf_atom_9be88b01()
	end

	if not __wf_atom_7e8ad928(v35) then
		v35:__wf_atom_cee160bc()
	end
end

function IsMenuSuitAvatarShowing()
	return mMenuSuitAvatarVisible
end

function SetupMenuSuit()
	fn23()
end

function OnInitialInventorySync(_, _)
	mFoundryNotification.Refresh = true
	_T.syncingInventory = false
	mCheckingForIdentifiedOmegaMods = true
	mOmegaWithPendingFingerprints = {}
	mNewIdentifiedOmegaMods = {}
	v9 = 1
	mMenuSuitAvatarVisible = false

	if _G.NightwaveSeason5IntermissionExpectedStanding ~= nil then
		local v34 = Symbol("RadioLegionIntermission5Syndicate")
		local __wf_atom_e173a80e = gGameData:__wf_atom_e173a80e()

		for i = 1, #__wf_atom_e173a80e do
			local v35 = __wf_atom_e173a80e[i]

			if v35.mTag ~= v34 then
				continue
			end

			if v35.mStanding == _G.NightwaveSeason5IntermissionExpectedStanding then
				break
			end

			print("Unexpected standing value for Nightwave, resyncing to correct")
			gGameData:SyncInventoryFromDB("", true)
			break
		end

		_G.NightwaveSeason5IntermissionExpectedStanding = nil
	end
end

function OnInboxSync(_, _)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:__wf_atom_6c7eca06() then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) and __wf_atom_9be88b01:__wf_atom_cb02838c() then
			_T.gQueueMailbox = true
		end
	end
end

function OnSyncTwitchDrops(p, value)
	if p and value ~= "" and string.find(value, "/Lotus/Language/") ~= nil then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384(value, false), nil, 0)
	end
end

function OnLoginRewardSync(_, _) end

local function fn24(p, p2, p3)
	if __wf_atom_7e8ad928(itemInfoPopupMovie) then
		return false
	end

	local infoPopup_Data = _T.InfoPopup_Data

	if not (infoPopup_Data ~= nil and (p.UID == nil or infoPopup_Data.RawItem == nil or infoPopup_Data.RawItem.UID ~= p.UID)) then
		return false
	end

	local v34 = mMovie:PushChildMovie(itemInfoPopupMovie)

	if not __wf_atom_7e8ad928(v34) then
		_T["InfoPopup_Data" .. p2] = p
		v34:Execute("OverrideItemInfoData", p2 .. "," .. p3)
		return true
	end

	return false
end

local function fn25(p) -- 4 equivalent calls inferred from this helper
	table.insert(screenStack, p)
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ScreenStackUpdated", (tostring(#screenStack)))
end

local function fn26()
	_T.TopMenuOpen = false
	local buttonBarMovie = buttonBarMovie

	if not (__wf_atom_7e8ad928(buttonBarMovie) or __wf_atom_8e4fda44:__wf_atom_6b69b901(buttonBarMovie)) then
		mMovie:PushChildMovie(buttonBarMovie)
	end

	mToolTip = __wf_atom_8e4fda44:FindMovie(toolTipMovie)

	if __wf_atom_7e8ad928(mToolTip) and not __wf_atom_7e8ad928(toolTipMovie) then
		mToolTip = mMovie:PushChildMovie(toolTipMovie)
	end

	mBacker = __wf_atom_8e4fda44:FindMovie(backerMovie)

	if __wf_atom_7e8ad928(mBacker) and not __wf_atom_7e8ad928(backerMovie) then
		mBacker = mMovie:PushChildMovie(backerMovie)
	end

	mInfoPopup = __wf_atom_8e4fda44:FindMovie(itemInfoPopupMovie)

	if __wf_atom_7e8ad928(mInfoPopup) and not __wf_atom_7e8ad928(itemInfoPopupMovie) then
		mInfoPopup = mMovie:PushChildMovie(itemInfoPopupMovie)
	end

	if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP then
		if not (__wf_atom_7e8ad928(contextActionMovie) or __wf_atom_8e4fda44:__wf_atom_6b69b901(contextActionMovie)) then
			mMovie:PushChildMovie(contextActionMovie)
		end

		queuedMovie = "Default"
		fn25(queuedMovie) -- inferred equivalent call
		fn23()
	end

	if not Engine.__wf_atom_fc67ba71() then
		mIMEOverlay = __wf_atom_8e4fda44:FindMovie(IMEOverlayMovie)

		if __wf_atom_7e8ad928(mIMEOverlay) and not __wf_atom_7e8ad928(IMEOverlayMovie) then
			mIMEOverlay = mMovie:PushChildMovie(IMEOverlayMovie)
		end
	end

	mAdditionalScreenCreated = false
end

local function fn27()
	if not (__wf_atom_7e8ad928(acceptInviteMovie) or __wf_atom_8e4fda44:__wf_atom_6b69b901(acceptInviteMovie) or _G.StalkerMode or _G.LoadingTutorial) then
		_T.AcceptInvitePanel = mMovie:PushChildMovie(acceptInviteMovie)
	end

	if not (__wf_atom_7e8ad928(genericNotificationMovie) or __wf_atom_8e4fda44:__wf_atom_6b69b901(genericNotificationMovie)) then
		mMovie:PushChildMovie(genericNotificationMovie)
	end

	local squadOverlayMovie = squadOverlayMovie

	if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(squadOverlayMovie))) then
		_T.SquadOverlay = __wf_atom_8e4fda44:__wf_atom_8b74c30b(squadOverlayMovie)
	end

	fn4()

	if
		Engine.__wf_atom_2a979d69()
		and not __wf_atom_7e8ad928(touchControlMovie)
		and __wf_atom_72884638("Flash.ShowTouchControls", true)
		and __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(touchControlMovie)))
		and not __wf_atom_7e8ad928(touchControlMovie)
	then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(touchControlMovie)
	end

	mAdditionalScreenCreated = true
end

local function fn28(gActiveCameraSpot, p)
	local entity = module.GetEntityFromTag(
		gActiveCameraSpot,
		module.Ternary(module2.IsInHub(), __wf_atom_392793db, nil)
	)

	if not __wf_atom_7e8ad928(entity) then
		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

		if __wf_atom_7e8ad928(__wf_atom_e23b2855) or #__wf_atom_e23b2855 == 0 then
			return
		end

		local v34 = p == nil and 1 or tonumber(p)
		local v35 = __wf_atom_e23b2855[1]

		if not (__wf_atom_7e8ad928(v35) or __wf_atom_7e8ad928(v35:CameraControl()) or v35:CameraControl():__wf_atom_c8c5ba0a()) then
			v35:CameraControl():__wf_atom_fd14c463(v34)
		end

		entity:FirePort("Activate")
		_T.gActiveCameraSpot = gActiveCameraSpot
	end
end

function PlayCameraTransition(gActiveCameraSpot, p)
	fn28(gActiveCameraSpot, p)
end

local function fn29(p)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

	if __wf_atom_7e8ad928(__wf_atom_e23b2855) or #__wf_atom_e23b2855 == 0 then
		print("_ClearCurrentCameraSpot - no local player")
		return
	end

	local v34 = p == nil and 0.01 or p
	local v35 = __wf_atom_e23b2855[1]

	if not (__wf_atom_7e8ad928(v35) or __wf_atom_7e8ad928(v35:CameraControl()) or v35:CameraControl():__wf_atom_c8c5ba0a()) then
		v35:CameraControl():__wf_atom_fd14c463(1)
		v35:CameraControl():SetCameraSpot(nil, (tonumber(v34)))
	end

	if
		_T.gActiveCameraSpot == "LoginNoSuit"
		or _T.gActiveCameraSpot == "Login"
		or _T.gActiveCameraSpot == "OldLogin"
		or _T.gActiveCameraSpot == "Syndicate"
		or _T.gActiveCameraSpot == "LoginCamp"
		or _T.gActiveCameraSpot == "LoginCampPreview"
	then
		gGameRules:__wf_atom_411c9025(false)
	end

	_T.gActiveCameraSpot = nil
end

function ClearCurrentCameraSpot(p)
	fn29(p)
end

function FadeInOut(p, p2, p3)
	v3.Timer = 0
	v3.InTime = tonumber(p)
	v3.OutTime = tonumber(p2)
	v3.FinalVal = tonumber(p3)
	v3.FullCallback = nil
end

local function fn30(p)
	print("Background.lua - _DoLogoff()")

	if __wf_atom_7e8ad928(_T.BackgroundMovie) then
		print("Queued")
		mQueuedLogoff = true
	else
		_T.PreviousLoggedInAccountId = nil
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			_T.PreviousLoggedInAccountId = __wf_atom_18a5d83b:__wf_atom_e75653c3()
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
			local settings = __wf_atom_18a5d83b:Settings()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				_G.PreviousLoggedInStreamerMode = settings:__wf_atom_a35494b3()

				if not p then
					if __wf_atom_9be88b01:__wf_atom_4f043a5d() ~= nil then
						__wf_atom_9be88b01:__wf_atom_c79686c2()
					end

					__wf_atom_c67f9605:__wf_atom_d4f03428(WeakResource("/Lotus/Levels/Proc/PlayerShip"))
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				if v5.mWorldStateCallbackRegistered then
					__wf_atom_9be88b01:__wf_atom_35b2fc84("OnSyncWorldState", v5.WORLD_STATE_CALLBACK_IDENTIFIER)
				end

				__wf_atom_9be88b01:__wf_atom_418fa6a6()
			end
		end

		v5.mWorldStateCallbackRegistered = false

		if _T.IsScreenOpen("MainMenu") then
			for i = #screenStack, 1, -1 do
				local movie = __wf_atom_8e4fda44:FindMovie(movies[screenStack[i]])

				if movie == nil then
					continue
				end

				if screenStack[i] == "Default" or screenStack[i] == "MainMenu" then
					__wf_atom_a0f6588f:LogOut()

					if p then
						__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
					end

					movie:Execute("LogOut", "")
				elseif Engine.__wf_atom_5f0554d9() and screenStack[i] == "Menu" then
					movie:Execute("HideForBigPic", "")
				elseif movie ~= mMovie then
					movie:Execute("TransitionOut", "")
				end
			end
		else
			print("Main menu not open")

			for i = #screenStack, 1, -1 do
				if __wf_atom_7e8ad928(movies[screenStack[i]]) then
					continue
				end

				local movie = __wf_atom_8e4fda44:FindMovie(movies[screenStack[i]])

				if not __wf_atom_7e8ad928(movie) then
					movie:Execute("TransitionOut", "")
				end
			end

			__wf_atom_a0f6588f:LogOut()

			if p then
				__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
			end
		end

		local movie = __wf_atom_8e4fda44:FindMovie(confirmMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end

		if not __wf_atom_7e8ad928(_T.SquadOverlay) then
			_T.SquadOverlay:Close()
		end

		if not __wf_atom_7e8ad928(mChildMovie) then
			mChildMovie:Close()
		end

		mChildMovie = nil
		mQueuedLogoff = false
		queuedMovie = "Default"
		screenStack = { "Default" }

		for _, v34 in ipairs({ "loadoutInProgress" }) do
			_T[v34] = nil
		end

		if Engine.__wf_atom_84bb79c2() then
			local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

			if not __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
				__wf_atom_3cb140dc:__wf_atom_cd4c064d()
			end
		end

		if not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:__wf_atom_94b3a9e1(true)
		end

		Engine.Disconnect(true)
	end
end

fn3 = function(p, locString)
	local v34 = tonumber(p)

	if v34 == 1 or v34 == 2 then
		if __wf_atom_7e8ad928(mBlockingTaskPopup) then
			local dialogSettings = Engine.DialogSettings()

			if locString == nil then
				dialogSettings.locString = "/Lotus/Language/Menu/NavBar_QuickMatchPleaseWait"
			else
				dialogSettings.locString = locString
			end

			_T.LiteModeBlocking = v34 == 2
			mBlockingTaskPopup = module.ShowCustomMessage(dialogSettings)
			_T.LiteModeBlocking = nil
		end
	elseif __wf_atom_7e8ad928(mBlockingTaskPopup) then
		print("Tried to close non-existent blocking message")
	else
		mBlockingTaskPopup:Close()
		mBlockingTaskPopup = nil
	end
end

function ShowBlockingMessage(p, p2)
	fn3(p, p2)
end

function NotifyWorldStateChanged(p)
	fn2(p)
end

local function fn31(p) -- 1 equivalent call inferred from this helper
	local v34

	if screenStack[#screenStack] == "Lobby" then
		v34 = false
	else
		v34 = p ~= nil
	end

	mMovie:__wf_atom_2dedec1a("GlobalMessage", 13, v34)

	if v34 then
		mMovie:__wf_atom_50d60589("GlobalMessage.Message", 36, p)
	end
end

function SetGlobalLobbyMessage(p)
	fn31(p) -- inferred equivalent call
end

local function fn32(p) -- 2 equivalent calls inferred from this helper
	if not __wf_atom_7e8ad928(movies[p]) then
		return not __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(movies[p])))
	end

	print("ERROR: Checking unrecognized screen [" .. tostring(p) .. "] Check your spelling.")
	return false
end

local function fn33(object)
	local v34 = nil
	local mExpiry = nil

	if __wf_atom_7e8ad928(object) then
		return v34, mExpiry
	end

	local __wf_atom_ff62ea3d = object:__wf_atom_ff62ea3d()

	if not __wf_atom_7e8ad928(__wf_atom_ff62ea3d) and Engine.__wf_atom_db2b0cee(__wf_atom_ff62ea3d.mExpiry) > 0 then
		mExpiry = __wf_atom_ff62ea3d.mExpiry
		v34 = 1
	end

	if v34 == nil and _T.CachedFlashSales then
		for _, cachedFlashSale in pairs(_T.CachedFlashSales) do
			if
				cachedFlashSale.mDiscount ~= 0
				and Engine.__wf_atom_db2b0cee(cachedFlashSale.mStartDate) < 0
				and Engine.__wf_atom_db2b0cee(cachedFlashSale.mEndDate) > 0
				and cachedFlashSale.mShowInMarket
			then
				return 2, cachedFlashSale.mEndDate
			end
		end
	end

	return v34, mExpiry
end

local function fn34()
	if
		not __wf_atom_7e8ad928(queuedMovie)
		or _T.missionStatsPending
		or not _T.ActiveQuestLoaded
		or not _T.MainMenuStateReady and mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP
		or _T.gQueueMailbox
		or _T.OpeningMailbox
	then
		return false
	end

	for i = 1, #v8 do
		if __wf_atom_8e4fda44:FindMovie(v8[i]) ~= nil then
			return false
		end
	end

	return true
end

local function fn35(p)
	if
		__wf_atom_7e8ad928(__wf_atom_8e4fda44)
		or __wf_atom_8e4fda44:FindMovie(_G.UIMovie_EndOfQuestMovie) ~= nil
		or p and __wf_atom_8e4fda44:FindMovie(boosterPackMovie) ~= nil
	then
		return false
	end

	if
		__wf_atom_8e4fda44:FindMovie(_G.UIMovie_SolarMap) ~= nil
		or (not __wf_atom_7e8ad928(queuedMovie) or _T.missionStatsPending or mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP and not _T.MainMenuStateReady)
	then
		return false
	end

	if _T.gQueueMailbox or _T.OpeningMailbox or _T.QuestPickerOpen then
		return false
	end

	for i = 1, #v8 do
		if __wf_atom_8e4fda44:FindMovie(v8[i]) ~= nil then
			return false
		end
	end

	return true
end

function QuestCompleted(p)
	v7 = p
end

function CheckQuests(p)
	local v34 = p == "true"
	module2.UpdateQuests(v34)
end

local function fn36(_, gGameData, p)
	if not __wf_atom_7e8ad928(gGameData) and _T.Notifications ~= nil then
		local v34 = nil
		local mExpiryDate = nil
		local v35 = nil
		local mExpiryDate2 = nil
		local v36 = nil
		local mExpiryDate3 = nil

		if _T.CachedGlobalUpgrades ~= nil then
			for _, cachedGlobalUpgrade in pairs(_T.CachedGlobalUpgrades) do
				if
					not (Engine.__wf_atom_db2b0cee(cachedGlobalUpgrade.mActivation) <= 0)
					or __wf_atom_7e8ad928(cachedGlobalUpgrade.mUpgrade)
					or #cachedGlobalUpgrade.mNodes ~= 0
				then
					continue
				end

				if cachedGlobalUpgrade.mUpgrade:__wf_atom_b810064e() == 219 then
					v36 = cachedGlobalUpgrade.mUpgrade:__wf_atom_505b3c0e()
					mExpiryDate3 = cachedGlobalUpgrade.mExpiryDate
				elseif cachedGlobalUpgrade.mUpgrade:__wf_atom_b810064e() == 216 then
					v34 = cachedGlobalUpgrade.mUpgrade:__wf_atom_505b3c0e()
					mExpiryDate = cachedGlobalUpgrade.mExpiryDate
				elseif cachedGlobalUpgrade.mUpgrade:__wf_atom_b810064e() == 209 then
					v35 = cachedGlobalUpgrade.mUpgrade:__wf_atom_505b3c0e()
					mExpiryDate2 = cachedGlobalUpgrade.mExpiryDate
				end

				if v34 ~= nil and v35 ~= nil and v36 ~= nil then
					break
				end
			end
		end

		local mUpgradesExpiry = nil
		local v37 = 0
		local __wf_atom_ed5c034d = gGameData:__wf_atom_a4299765():__wf_atom_ed5c034d(0, 0)
		local v38, v39

		if __wf_atom_ed5c034d.mUmbraDate:__wf_atom_8598f3a9() then
			v38 = __wf_atom_ed5c034d:__wf_atom_1d7ed3c2()
			v39 = 1
		else
			v39 = 0
		end

		if __wf_atom_ed5c034d.mUpgradesExpiry:__wf_atom_8598f3a9() then
			v37 = 1
			mUpgradesExpiry = __wf_atom_ed5c034d.mUpgradesExpiry

			if _T.CurrentInvigoration == nil then
				_T.CurrentInvigoration = ""
			end

			if
				__wf_atom_7e8ad928(v19.Upgrades[1])
				or v19.Upgrades[1] ~= __wf_atom_ed5c034d.mOffensiveUpgrade
				or __wf_atom_7e8ad928(v19.Upgrades[2])
				or v19.Upgrades[2] ~= __wf_atom_ed5c034d.mDefensiveUpgrade
			then
				_T.CurrentInvigoration = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/LoadoutSelection_Loading",
					false
				)
				v19.Upgrades = {}
				table.insert(v19.Upgrades, __wf_atom_ed5c034d.mOffensiveUpgrade)
				table.insert(v19.Upgrades, __wf_atom_ed5c034d.mDefensiveUpgrade)
				local v40 = {}

				for i = 1, #v19.Upgrades do
					table.insert(v40, v19.Upgrades[i]:__wf_atom_5b41f63b())
				end

				v19.Loader = UISys.__wf_atom_c0dbe47c(v40)
				v19.IsLoading = true
			end
		end

		for i = 1, #_T.Notifications.mElements do
			local mElement = _T.Notifications.mElements[i]

			if mElement == nil then
				continue
			end

			local mCount = 0
			local v40 = nil

			if not p then
				if mElement.Id == _T.Notifications.MAIL then
					mCount = gGameData:__wf_atom_6a8f669c()
				elseif mElement.Id == _T.Notifications.FOUNDRY then
					if not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData)) then
						if mFoundryNotification.Refresh then
							local v41 = mFoundryNotification.LastRefreshTime == 0 and 999999999999
								or Time() - mFoundryNotification.LastRefreshTime
							local __wf_atom_1f84b697 = gGameData:__wf_atom_1f84b697(
								gGameRules:__wf_atom_964056fd(),
								v41
							)
							mFoundryNotification.LastRefreshTime = Time()
							mCount = __wf_atom_1f84b697.mCount

							if _T.ShowNotification ~= nil then
								for j = 1, #__wf_atom_1f84b697.mReadySinceLastCheck do
									local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
										"/SF/Language/Menu/Crafting_ReadyToClaim_Notification",
										false,
										{ RECIPE = __wf_atom_1f84b697.mReadySinceLastCheck[j] }
									)

									if __wf_atom_7e8ad928(__wf_atom_1f84b697.mReadyRecipes[j]) then
										_T.ShowNotification(__wf_atom_8e9ac384, "BuildComplete")
									elseif module13.GetCraftingAncestorForItem(__wf_atom_1f84b697.mReadyRecipes[j]) == WeakResource("/SF/Types/Game/Ancestors/Tuvalkane/TuvalkaneAncestor") then
										_T.ShowNotification(__wf_atom_8e9ac384, "BuildCompleteTuvalkane")
									elseif module13.GetCraftingAncestorForItem(__wf_atom_1f84b697.mReadyRecipes[j]) == WeakResource("/SF/Types/Game/Ancestors/Verminia/VerminiaAncestor") then
										_T.ShowNotification(__wf_atom_8e9ac384, "BuildCompleteVerminia")
									else
										_T.ShowNotification(__wf_atom_8e9ac384, "BuildComplete")
									end
								end
							end

							mFoundryNotification.Refresh = false

							if mFoundryNotification.Timer ~= nil then
								mTimerMgr:RemoveTimer(mFoundryNotification.Timer)
								mFoundryNotification.Timer = nil
							end

							if __wf_atom_1f84b697.mTimeToNextClaimable >= 0 then
								mFoundryNotification.Timer = mTimerMgr:AddTimer(
									__wf_atom_1f84b697.mTimeToNextClaimable,
									function()
										mFoundryNotification.Refresh = true
									end
								)
							end
						else
							mCount = mElement.Value
						end
					end
				elseif mElement.Id == _T.Notifications.MARKET then
					if gGameData:__wf_atom_e9d1e802(module2.SF_SOCIAL_MENU) then
						mCount, v40 = fn33(gGameData)
					end
				elseif mElement.Id == _T.Notifications.INC_FRIENDS then
					mCount = gGameData:__wf_atom_96c1b2f5()
				end
			end

			if mElement.Id == _T.Notifications.UMBRA_ECHO then
				v40 = v38
				mCount = v39
			elseif mElement.Id == _T.Notifications.INVIGORATION then
				v40 = mUpgradesExpiry
				mCount = v37
			elseif mElement.Id == _T.Notifications.DOUBLE_CREDIT then
				v40 = mExpiryDate
				mCount = v34
			elseif mElement.Id == _T.Notifications.DOUBLE_AFFINITY then
				v40 = mExpiryDate2
				mCount = v35
			elseif mElement.Id == _T.Notifications.DOUBLE_PICKUP then
				v40 = mExpiryDate3
				mCount = v36
			end

			if not (mCount ~= mElement.Value or v40 ~= nil and (mElement.Expiry == nil or v40:__wf_atom_8f70d89f(mElement.Expiry)) ~= 0) then
				continue
			end

			mElement.Value = mCount

			if v40 == nil then
				mElement.Expiry = nil
			else
				mElement.Expiry = v40:Copy()
			end
		end
	end
end

function OnClaimRelayTasksComplete(p, _)
	if p then
		v29.progress = 1
		v29 = nil
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				__wf_atom_9be88b01:__wf_atom_6646ca4d("OnInboxSync")
			end
		end
	end
end

local function fn37()
	if
		v26
		and not __wf_atom_7e8ad928(gGameRules)
		and (not gGameRules:IsA(__wf_atom_2564b701) or gGameRules:IsA(__wf_atom_469b1d97))
		and (not gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:__wf_atom_72fc675e().missionType ~= 11)
		and __wf_atom_539492fe:IsA(__wf_atom_60862239)
	then
		__wf_atom_539492fe:__wf_atom_8f8dc6da()
	end
end

local function fn38()
	if __wf_atom_7e8ad928(gGameRules) then
		print("No game rules, early out")
		return
	end

	_T.CachedAlerts = {}
	_T.CachedInvasionInfo = {}
	_G.CachedGoalInfo = {}
	_G.MergedGoalNodes = {}
	_T.CachedConstructionProjects = {}
	_T.CachedRegionStatus = {}
	_T.CachedFlashSales = {}
	_T.CachedVoidTraders = {}
	_T.CachedGlobalUpgrades = {}
	_T.CachedGoalLongDesc = {}
	_T.LockedGoalList = {}
	_T.CachedNodesPendingDestruction = {}
	_T.CachedVoidStormMissions = {}

	if not _G.LoginDone then
		return nil
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v34

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v34 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	if __wf_atom_7e8ad928(v34) then
		return nil
	end

	local __wf_atom_92662866 = v34:__wf_atom_92662866()

	if __wf_atom_7e8ad928(__wf_atom_92662866) then
		return nil
	end

	if v26 == nil then
		v26 = module2.HasCompletedVorsPrize()
	end

	local v35 = __wf_atom_7e8ad928(gClient)
	local mAlerts = __wf_atom_92662866.mAlerts

	for i = 1, #mAlerts do
		__wf_atom_83c14687(0)
		local _ = mAlerts[i]
	end

	local mGoals = __wf_atom_92662866.mGoals
	local v36 = __wf_atom_7e8ad928(gClient)
	local hasTennoConRelayAccess = module10.HasTennoConRelayAccess(v34)
	local v37 = {}

	for i = 1, #mGoals do
		__wf_atom_83c14687(0)
		local mGoal = mGoals[i]
		local mNode = mGoal.mNode
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(mGoal.mActivation)
		local longDesc = ""

		if v36 then
			print("Goal: " .. tostring(mNode))
		end

		if __wf_atom_db2b0cee > 0 then
			if v36 then
				print("Seconds until start: " .. tostring(__wf_atom_db2b0cee))
			end

			local timerWithArg = mTimerMgr:GetTimerWithArg(mNode)

			if timerWithArg then
				if __wf_atom_db2b0cee < timerWithArg.Duration then
					timerWithArg.Duration = __wf_atom_db2b0cee
				end
			else
				mTimerMgr:AddTimer(__wf_atom_db2b0cee, fn2, false, mNode)
			end
		elseif
			mGoal.mInvasion
			or v26
			and v34:__wf_atom_044a8d12(i - 1)
			and not (Engine.__wf_atom_db2b0cee(mGoal.mExpiry) <= 0)
			and (mGoal.mTag ~= v27 or hasTennoConRelayAccess or v35)
			and (mGoal.mTag ~= v28 or not hasTennoConRelayAccess or v35)
		then
			if mGoal.mSuccess == 0 or #mGoal.mTypes > 0 then
				local v39 = nil

				if __wf_atom_7e8ad928(mGoal.mMissionKeyName) then
					if
						__wf_atom_7e8ad928(mGoal.mMissionInfo.levelOverride)
						and mGoal.mNode ~= ""
						and not mGoal.mOptionalInMission
					then
						local __wf_atom_d5226f21 = module2.GetStarChart():__wf_atom_d5226f21(Symbol(mGoal.mNode))
						local icon = mGoal.mMissionInfo.icon
						mGoal.mMissionInfo = __wf_atom_d5226f21.mission:Copy()

						if not __wf_atom_7e8ad928(icon) then
							mGoal.mMissionInfo.icon = icon
						end
					end
				else
					if not _T.CachedGoalKeys then
						_T.CachedGoalKeys = {}
						_T.CachedGoalKeyTypes = {}
					end

					if v36 then
						print("Adding " .. tostring(mNode))
					end

					if not _T.CachedGoalKeys[mNode] then
						_T.CachedGoalKeyTypes[mNode] = Type(mGoal.mMissionKeyName)
						_T.CachedGoalKeys[mNode] = Resource(_T.CachedGoalKeyTypes[mNode])
					end

					if not __wf_atom_7e8ad928(_T.CachedGoalKeys[mNode]) then
						v39 = _T.CachedGoalKeys[mNode]:__wf_atom_72fc675e()
						longDesc = tostring(_T.CachedGoalKeys[mNode]:__wf_atom_a6334b47())
					end

					if v39 then
						if mGoal.mMissionInfo.minEnemyLevel > 1 then
							v39.minEnemyLevel = mGoal.mMissionInfo.minEnemyLevel
						end

						if mGoal.mMissionInfo.maxEnemyLevel > 1 then
							v39.maxEnemyLevel = mGoal.mMissionInfo.maxEnemyLevel
						end

						if not __wf_atom_7e8ad928(mGoal.mMissionInfo.enemySpec) then
							v39.enemySpec = mGoal.mMissionInfo.enemySpec
						end

						mGoal.mMissionInfo = v39
					end
				end

				mGoal.mMissionInfo.goalId = mGoal.mId.mId
				local v40 = {}
				local count2 = 0

				if mGoal.mNode == "" then
					if mGoal.mInvasionNode == EMPTY_SYMBOL then
						table.insert(v40, {
							nodeName = module2.ANY_NODE_PREFIX .. i,
							missionKeyName = mGoal.mMissionKeyName,
							missionKeyInfo = v39,
							longDesc = longDesc
						})
					else
						table.insert(v40, {
							nodeName = tostring(mGoal.mInvasionNode),
							missionKeyName = mGoal.mMissionKeyName,
							missionKeyInfo = v39,
							longDesc = longDesc
						})
					end
				elseif mGoal.mOptionalInMission then
					table.insert(v40, {
						nodeName = module2.OPTIONAL_GOAL_PREFIX .. mGoal.mNode,
						missionKeyName = mGoal.mMissionKeyName,
						missionKeyInfo = v39,
						longDesc = longDesc
					})
				else
					table.insert(v40, {
						nodeName = mGoal.mNode,
						missionKeyName = mGoal.mMissionKeyName,
						missionKeyInfo = v39,
						longDesc = longDesc
					})
				end

				local personalGoalProgress, v41, v42 = module2.GetPersonalGoalProgress(mGoal)

				for j = 1, #mGoal.mConcurrentNodes do
					local mConcurrentNode = mGoal.mConcurrentNodes[j]

					if not (mConcurrentNode ~= mGoal.mNode and mConcurrentNode ~= "") then
						continue
					end

					local v43 = v26

					if j <= #mGoal.mConcurrentNodeReqs and mGoal.mConcurrentNodeReqs[j] > 0 then
						v43 = module.Ternary(mGoal.mBest, v41, personalGoalProgress) >= mGoal.mConcurrentNodeReqs[j]
					end

					if v43 then
						local mMissionKeyName = mGoal.mMissionKeyName
						local challenge = false
						local missionKeyInfo

						if
							j <= #mGoal.mConcurrentMissionKeyNames
							and mGoal.mConcurrentMissionKeyNames[j]
							and mGoal.mConcurrentMissionKeyNames[j] ~= ""
						then
							mMissionKeyName = mGoal.mConcurrentMissionKeyNames[j]
							local v46 = Resource(mMissionKeyName)

							if __wf_atom_7e8ad928(v46) then
								missionKeyInfo = v39
							else
								missionKeyInfo = v46:__wf_atom_72fc675e()
								longDesc = tostring(v46:__wf_atom_a6334b47())
							end

							challenge = mGoal.mClampNodeScores
								and mGoal.mConcurrentNodeReqs[j] >= mGoal.mGoal
								and true
								or false

							if not _T.CachedGoalKeys[mConcurrentNode] then
								_T.CachedGoalKeyTypes[mConcurrentNode] = Type(mGoal.mConcurrentMissionKeyNames[j])
								_T.CachedGoalKeys[mConcurrentNode] = Resource(_T.CachedGoalKeyTypes[mConcurrentNode])
							end
						elseif j <= #mGoal.mConcurrentMissionInfo and mGoal.mConcurrentMissionInfo[j] then
							missionKeyInfo = mGoal.mConcurrentMissionInfo[j]:Copy()

							if mGoal.mClampNodeScores and mGoal.mConcurrentNodeReqs[j] >= mGoal.mGoal then
								challenge = true
							end
						elseif #mGoal.mConcurrentMissionKeyNames == 0 and #mGoal.mConcurrentMissionInfo == 0 then
							missionKeyInfo = module2.GetStarChart():__wf_atom_d5226f21(Symbol(mConcurrentNode)).mission:Copy()
						else
							missionKeyInfo = v39
						end

						count2 += 1
						table.insert(v40, {
							nodeName = mConcurrentNode,
							missionKeyName = mMissionKeyName,
							missionKeyInfo = missionKeyInfo,
							concurrent = true,
							challenge = challenge,
							concurrentNumeral = count2 + 1,
							nodeScoreReq = mGoal.mConcurrentNodeReqs[j],
							longDesc = longDesc
						})
					else
						_T.LockedGoalList[mConcurrentNode] = { mDesc = mGoal.mDesc }

						if
							mGoal.mConcurrentMissionKeyNames
							and j <= #mGoal.mConcurrentMissionKeyNames
							and mGoal.mConcurrentMissionKeyNames[j]
						then
							if not _T.LockedGoalMissionInfo then
								_T.LockedGoalMissionInfo = {}
							end

							if not _T.LockedGoalMissionInfo[mConcurrentNode] then
								if not _T.CachedGoalKeys then
									_T.CachedGoalKeys = {}
									_T.CachedGoalKeyTypes = {}
								end

								if not _T.CachedGoalKeys[mConcurrentNode] then
									_T.CachedGoalKeyTypes[mConcurrentNode] = Type(mGoal.mConcurrentMissionKeyNames[j])
									_T.CachedGoalKeys[mConcurrentNode] = Resource(_T.CachedGoalKeyTypes[mConcurrentNode])
								end

								if not __wf_atom_7e8ad928(_T.CachedGoalKeys[mConcurrentNode]) then
									_T.CachedGoalLongDesc[mConcurrentNode] = tostring(_T.CachedGoalKeys[mConcurrentNode]:__wf_atom_a6334b47())
									_T.LockedGoalMissionInfo[mConcurrentNode] = {}
									_T.LockedGoalMissionInfo[mConcurrentNode].mMissionInfo = _T.CachedGoalKeys[mConcurrentNode]:__wf_atom_72fc675e()
									_T.LockedGoalMissionInfo[mConcurrentNode].mDesc = Localize(mGoal.mDesc, false) .. " - " .. Localize("/Lotus/Language/Menu/Lobby_Mission", nil) .. " " .. tostring(j + 1)
									_T.LockedGoalMissionInfo[mConcurrentNode].mId = MongoId(mGoal.mId.mId)
									_T.LockedGoalMissionInfo[mConcurrentNode].mTag = Symbol(mGoal.mTag)
									_T.LockedGoalList[mConcurrentNode].mDesc = _T.LockedGoalMissionInfo[mConcurrentNode].mDesc
								end
							end
						end
					end
				end

				for j = 1, #v40 do
					local v43 = v40[j]
					local nodeName = v43.nodeName
					_G.CachedGoalInfo[nodeName] = mGoal:Copy()
					_G.CachedGoalInfo[nodeName].mNode = nodeName
					_T.CachedGoalLongDesc[nodeName] = v43.longDesc
					local mVictimNode = tostring(mGoal.mVictimNode)

					if mVictimNode ~= "" then
						_T.CachedNodesPendingDestruction[mVictimNode] = {
							shouldLock = mGoal.mHealthPct > 0,
							lockTime = mGoal.mExpiry:Copy()
						}
					end

					if v43.missionKeyInfo then
						_G.CachedGoalInfo[nodeName].mMissionKeyName = v43.missionKeyName
						_G.CachedGoalInfo[nodeName].mMissionInfo = v43.missionKeyInfo
						_G.CachedGoalInfo[nodeName].mMissionInfo.location = Symbol(nodeName)
						_G.CachedGoalInfo[nodeName].mMissionInfo.goalId = mGoal.mId.mId
					end

					if v43.concurrent == true then
						_G.MergedGoalNodes[nodeName] = v43.nodeScoreReq
						_G.CachedGoalInfo[nodeName].mDesc = Localize(_G.CachedGoalInfo[nodeName].mDesc, false) .. " - " .. Localize("/Lotus/Language/Menu/Lobby_Mission", nil) .. " " .. tostring(v43.concurrentNumeral)
					end

					if v43.challenge and mGoal.mTag ~= Symbol("WaterFight") then
						_G.CachedGoalInfo[nodeName].mDesc = Localize(_G.CachedGoalInfo[nodeName].mDesc, false) .. " " .. Localize(
							"/Lotus/Language/Menu/WorldStateChallengeMode",
							false
						)
					end

					if mGoal.mRelayReconstruction then
						table.insert(v37, mGoal)
					end
				end

				if mGoal.mRewardNode ~= "" then
					if personalGoalProgress < v42 then
						_G.StarChartHiddenEventNode = mGoal.mRewardNode
						_T.LockedGoalList[mGoal.mRewardNode] = { mDesc = mGoal.mDesc }
					elseif _G.StarChartHiddenEventNode ~= nil then
						_G.StarChartHiddenEventNode = nil
					end
				end

				local __wf_atom_db2b0cee2 = Engine.__wf_atom_db2b0cee(mGoal.mExpiry)

				if __wf_atom_db2b0cee2 > 0 then
					local timerWithArg = mTimerMgr:GetTimerWithArg(mNode)

					if timerWithArg then
						if __wf_atom_db2b0cee2 < timerWithArg.Duration then
							timerWithArg.Duration = __wf_atom_db2b0cee2
						end
					else
						mTimerMgr:AddTimer(__wf_atom_db2b0cee2, fn2, false, mNode)
					end
				end
			end
		else
			if v36 then
				print("Goal locked")
			end

			if
				mGoal.mNode ~= ""
				and not string.find(mGoal.mNode, "Pvp")
				and not mGoal.mOptionalInMission
				and not mGoal.mRelayReconstruction
				and module2.GetStarChart():__wf_atom_d5226f21(Symbol(mGoal.mNode)).nodeType == 1
			then
				_T.LockedGoalList[mGoal.mNode] = {
					mDesc = mGoal.mDesc,
					mMissionKeyName = mGoal.mMissionKeyName
				}
			end

			if mGoal.mFomorian then
				local mVictimNode = tostring(mGoal.mVictimNode)

				if mVictimNode ~= "" then
					_T.CachedNodesPendingDestruction[mVictimNode] = {
						shouldLock = mGoal.mHealthPct > 0,
						lockTime = mGoal.mExpiry:Copy()
					}
				end
			end
		end
	end

	_T.CachedConstructionProjects = module8.GetConstructionProjects()
	_T.CachedFlashSales = {}

	for _, mFlashSale in ipairs(__wf_atom_92662866.mFlashSales) do
		if not (__wf_atom_7e8ad928(mFlashSale) or __wf_atom_7e8ad928(mFlashSale.mTypeName)) then
			_T.CachedFlashSales[mFlashSale.mTypeName:__wf_atom_5b41f63b()] = mFlashSale
		end
	end

	if __wf_atom_92662866.mVoidTraders ~= nil then
		_T.CachedVoidTraders = __wf_atom_92662866.mVoidTraders
	end

	if __wf_atom_7e8ad928(_T.NeedsGoalCheck) then
		_T.NeedsGoalCheck = true
	end

	fn37()

	if not __wf_atom_7e8ad928(gClient) then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnWorldStateChanged", "")
	end
end

function ShowRequireExitMessage(p)
	module.ShowMessage(p)
end

function OnInventorySyncCallback(p, _)
	if p then
		mFoundryNotification.Refresh = true
		module2.UpdateUIConsoleTriggers(false)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) and #__wf_atom_9be88b01:__wf_atom_7e1cc3d4() > 0 then
				__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("CouponAwarded", "")
			end
		end
	end
end

function OnSyncWorldState(p, p2)
	print("Background: world state refreshed from db")

	if p2 ~= "" then
		if mCurrentMode ~= module2.UI_MODE_IN_GAME then
			local v34 = false

			if __wf_atom_c67f9605:__wf_atom_6d03a710() then
				if not (v6 > 0) then
					flag = true
					return
				end

				local minutes = v6 * 5

				if not __wf_atom_7e8ad928(mMovie) then
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/MainMenu_NewBuildAvailableCountdown",
						false,
						{ MINUTES = minutes }
					)
					local v36 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_NewBuildAvailable", false) .. "\r\n\r\n" .. __wf_atom_8e9ac384
					module.ShowMessage(v36)
				end

				v6 -= 1
				v34 = true
			elseif __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
				if not __wf_atom_7e8ad928(mMovie) then
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/MainMenu_BugReportPending",
						false
					)
					module.ShowMessage(__wf_atom_8e9ac384)
				end

				v34 = true
			end

			if v34 and not __wf_atom_7e8ad928(_T.SquadOverlay) then
				_T.SquadOverlay:Execute("LeaveSquadUI", "")
			end
		end

		if p then
			fn38()
		end
	end
end

local function fn39(p)
	if v5.mWorldStateCallbackRegistered and not p then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			__wf_atom_9be88b01:__wf_atom_0d091b56("OnSyncWorldState", v5.WORLD_STATE_CALLBACK_IDENTIFIER, p)
			v5.mWorldStateCallbackRegistered = true
		end
	end
end

function RegisterWorldStateCallback(p)
	fn39(module.Ternary(p == "true", true, false))
end

local function fn40(p, object, default, p2)
	if __wf_atom_7e8ad928(object) then
		print("Error: Transmissions set is borked")
		return false
	end

	if default == nil then
		default = v23.DEFAULT
	end

	local v34 = p2 == nil and 0 or p2
	table.insert(v12.Callbacks, v34)

	if
		(default == v23.OVERRIDE or default == v23.DEFAULT)
		and (default ~= v23.DEFAULT or __wf_atom_7e8ad928(v12.SoundInst))
	then
		v12.QueuedTransmission = object:__wf_atom_b4a422ed(Symbol(p))

		if not __wf_atom_7e8ad928(v12.QueuedTransmission) then
			v12.Loader = UISys.__wf_atom_c0dbe47c({ v12.QueuedTransmission:__wf_atom_5b41f63b() })
			v12.IsLoading = true
		end

		return true
	else
		if default == v23.FORCE_QUEUE then
			for i = 1, #v12.WaitingTransmissions do
				v12.WaitingTransmissions[i] = nil
			end
		end

		if default == v23.QUEUE or default == v23.FORCE_QUEUE then
			table.insert(v12.WaitingTransmissions, object:__wf_atom_b4a422ed(Symbol(p)))
		end

		return false
	end
end

fn2 = function(_)
	fn38()
end

local function fn41(avatar, targetPos)
	v13.Avatar = avatar
	v13.TargetPos = targetPos
end

local function fn42(level, p)
	if not __wf_atom_7e8ad928(v11) then
		v11:Execute("CloseDiorama", "")
		v11 = nil
	end

	if not __wf_atom_7e8ad928(level) then
		v11 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(dioramaViewer)

		if not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T[p])) then
			v11:Execute("SetLoadedCallback", p)
		end

		v11:Execute("LoadDiorama", (tostring(level:__wf_atom_5b41f63b())))
	end
end

function ToggleOmegaDiorama(p, p2)
	if p == true or p == "true" then
		fn42(omegaDiorama:GetInfo().level, p2)
	elseif not __wf_atom_7e8ad928(v11) then
		v11:Execute("CloseDiorama", "")
		v11 = nil
	end
end

local function fn43()
	if
		not gMatchingService:IsBlockingTaskPending()
		and not __wf_atom_7e8ad928(_G.UIMovie_EndOfQuestMovie)
		and v7 ~= nil
		and fn34()
	then
		local v34 = mMovie:PushChildMovie(_G.UIMovie_EndOfQuestMovie)

		if not __wf_atom_7e8ad928(v34) then
			v34:Execute("SetQuestType", v7)
		end

		v7 = nil
	end
end

local function fn44()
	if __wf_atom_7e8ad928(_T.NeedsGoalCheck) or not _T.NeedsGoalCheck then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return
	end

	local __wf_atom_5ee570c9 = __wf_atom_9be88b01:__wf_atom_5ee570c9()
	local __wf_atom_92662866 = __wf_atom_9be88b01:__wf_atom_92662866()

	if __wf_atom_7e8ad928(__wf_atom_92662866) then
		return nil
	end

	for i = 1, #__wf_atom_92662866.mGoals do
		local mGoal = __wf_atom_92662866.mGoals[i]

		if mGoal.mTag ~= Symbol("OldWorldSalvage") then
			continue
		end

		local personalGoalProgress, _, _ = module2.GetPersonalGoalProgress(mGoal)

		if __wf_atom_5ee570c9 == "SolNode333" and personalGoalProgress == 1 then
			break
		end
	end

	if __wf_atom_5ee570c9 == "SolNode332" then
		local __wf_atom_a212d5ad = __wf_atom_9be88b01:__wf_atom_a212d5ad()

		for i = 1, #__wf_atom_a212d5ad do
			if __wf_atom_a212d5ad[i].mTag == Symbol("SolNode332") and __wf_atom_a212d5ad[i].mCompletes == 1 then
				break
			end
		end
	end

	_T.NeedsGoalCheck = false
	print("Goal check is now false")
end

function OnRerollsCompleted(p, p2)
	if not p then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return
	end

	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("UpdateOmegaSuggestTree", "")
	end

	local upgrades = __wf_atom_9be88b01:GetInventory():GetUpgrades()
	local upgrades2 = {}
	local decoded = cjson.decode(p2)

	if decoded.changes ~= nil then
		for _, change in ipairs(decoded.changes) do
			local oid = change.ItemId["$oid"]

			for _, upgrade in ipairs(upgrades) do
				if oid ~= upgrade.mItemId.mId then
					continue
				end

				table.insert(upgrades2, upgrade)
				break
			end
		end
	end

	_T.boosterUpgradeInfoMode = true
	_T.boosterPackCards = {}
	_T.boosterOmegaMode = true

	for _, v34 in ipairs(upgrades2) do
		table.insert(_T.boosterPackCards, { v34, "" })
	end

	mShowingIdentifiedOmegaModsDiorama = false
	mShouldShowDiorama = true
	mCheckingForIdentifiedOmegaMods = nil
end

function OnFinishedShowingIdentifiedOmegas(_)
	if not __wf_atom_7e8ad928(v11) then
		v11:Execute("CloseDiorama", "")
		v11 = nil
		mShowingIdentifiedOmegaModsDiorama = nil
	end
end

local function fn45()
	if
		not gMatchingService:IsBlockingTaskPending()
		and not __wf_atom_7e8ad928(_G.UIMovie_EndOfQuestMovie)
		and v7 == nil
		and fn35()
	then
		if
			mCheckingForIdentifiedOmegaMods == nil
			and mShowingIdentifiedOmegaModsDiorama == nil
			and mOmegaWithPendingFingerprints ~= nil
			and mProcessingOmegaWithPendingFingerprint == nil
		then
			if not (#mOmegaWithPendingFingerprints > 0) then
				mOmegaWithPendingFingerprints = nil
				return
			end

			mProcessingOmegaWithPendingFingerprint = table.remove(mOmegaWithPendingFingerprints)
			_T.OmegaRerollChoice = mProcessingOmegaWithPendingFingerprint

			function _T.OmegaRerollDone(_, _) end

			function _T.OmegaRerollCanceled()
				_T.OmegaRerollDone = nil
				_T.OmegaRerollCanceled = nil
				mProcessingOmegaWithPendingFingerprint = nil
			end

			local v34 = mMovie:PushChildMovie(WeakResource("/Lotus/Interface/OmegaRerollSelection.swf"))

			if not __wf_atom_7e8ad928(v34) then
				v34:Execute("SetCallBack", "OmegaRerollDone")
				v34:Execute("SetCancelCallBack", "OmegaRerollCanceled")
			end
		elseif mCheckingForIdentifiedOmegaMods then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				return
			end

			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				return
			end

			local upgrades = __wf_atom_9be88b01:GetInventory():GetUpgrades()
			local upgrades2 = {}

			for _, upgrade in ipairs(upgrades) do
				if upgrade.mItemType:IsA(__wf_atom_16cdad3a) then
					table.insert(upgrades2, upgrade)
				end
			end

			if v9 <= #upgrades2 then
				local v34 = upgrades2[v9]
				local mItemType = v34.mItemType
				local mInstance = v34.mInstance
				local mUpgradeFingerprint = v34.mUpgradeFingerprint
				local mPendingRerollFingerprint = v34.mPendingRerollFingerprint

				if
					__wf_atom_7e8ad928(mInstance:__wf_atom_7b93739b(mUpgradeFingerprint))
					or not (mInstance:__wf_atom_1dce7a3d(mUpgradeFingerprint) >= mInstance:__wf_atom_ab325d85(mUpgradeFingerprint))
				then
					if mPendingRerollFingerprint ~= "" then
						table.insert(mOmegaWithPendingFingerprints, {
							Id = v34.mItemId.mId,
							Type = mItemType,
							Fingerprint = mUpgradeFingerprint,
							RerollFingerprint = mPendingRerollFingerprint
						})
					end
				else
					table.insert(mNewIdentifiedOmegaMods, v34.mItemId.mId)
				end

				if v9 < #upgrades2 then
					v9 += 1
					return
				end
			end

			mCheckingForIdentifiedOmegaMods = false

			if #mNewIdentifiedOmegaMods == 0 then
				mCheckingForIdentifiedOmegaMods = nil
			else
				__wf_atom_9be88b01:__wf_atom_a74dbad0(mNewIdentifiedOmegaMods, "OnRerollsCompleted")
			end
		elseif mShouldShowDiorama then
			mShouldShowDiorama = nil

			function _T.OnDioramaLoaded()
				mShowingIdentifiedOmegaModsDiorama = true
			end

			fn42(omegaDiorama:GetInfo().level, "OnDioramaLoaded")
		elseif mShowingIdentifiedOmegaModsDiorama then
			mShowingIdentifiedOmegaModsDiorama = false
			_T.OnDioramaLoaded = nil

			if next(_T.boosterPackCards) then
				local v34 = mMovie:PushChildMovie(boosterPackMovie)
				v34:__wf_atom_f62a8704("SetText", { "" })
				v34:Execute("SetNumOptions", 1)
				v34:Execute("SetCallback", "OnFinishedShowingIdentifiedOmegas")
			end
		end
	end
end

local function fn46()
	if not __wf_atom_7e8ad928(gClient) then
		local v34

		if not __wf_atom_7e8ad928(gRegion) then
			v34 = gRegion:__wf_atom_2202ffb6()
		end

		local v35 = not __wf_atom_7e8ad928(v34) and v34:ReadyToCreateAgents()

		if
			not gClient:__wf_atom_449cc668()
			and not mFadeInStarted
			and (not __wf_atom_7e8ad928(module.GetEntityFromTag("StarChartRoot")) or mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP)
			and v35
		then
			fn26()
			local entity = module.GetEntityFromTag(
				"SuitAvatarSpawner",
				module.Ternary(module2.IsInHub(), __wf_atom_392793db, nil)
			)

			if not __wf_atom_7e8ad928(entity) then
				entity:FirePort("Start")
			end

			mFadeInStarted = true
		end

		if
			(__wf_atom_7e8ad928(mMenuSuitAvatar) or not mMenuSuitAvatarVisible)
			and not __wf_atom_7e8ad928(gGameRules)
			and gGameRules:__wf_atom_09e81034()
		then
			fn23()
		end
	end

	if
		not __wf_atom_7e8ad928(queuedMovie)
		and (__wf_atom_7e8ad928(mChildMovie) or queuedMovie == "LoadOut")
		and (queuedMovie ~= "ItemBrowsing" or _T.starChartDone)
	then
		if __wf_atom_7e8ad928(movies[queuedMovie]) then
			print("ERROR: Queued unrecognized screen [" .. tostring(queuedMovie) .. "] Check your spelling.")
			assert(false)
		else
			print("Background::" .. "PushChildMovie(" .. queuedMovie .. ")")
			mChildMovie = __wf_atom_8e4fda44:FindMovie(movies[queuedMovie])

			if __wf_atom_7e8ad928(mChildMovie) then
				mChildMovie = mMovie:PushChildMovie(movies[queuedMovie])
			else
				mChildMovie:SetVisible(true)
				mChildMovie:Execute("OnChildScreenClosed", mPreviousScreen)
				mPreviousScreen = nil

				if not __wf_atom_7e8ad928(mChildMovie) then
					__wf_atom_ec43d06e(mChildMovie, "_root", 0, { 12 }, { 100 }, 0.2, 0.3)
				end
			end

			if queuedMovie == "MainMenu" or queuedMovie == "Default" then
				mChildMovie = nil
			end

			if queuedMovieCallback ~= nil then
				queuedMovieCallback(mChildMovie)
				queuedMovieCallback = nil
			end

			queuedMovie = nil
		end
	end

	if not gMatchingService:IsBlockingTaskPending() then
		if mQueuedGoToScreen ~= nil then
			local screen = mQueuedGoToScreen.screen
			local callback = mQueuedGoToScreen.callback
			mQueuedGoToScreen = nil
			_T.GoToScreen(screen, callback)
		end

		if mQueuedGoToPreviousScreen ~= nil then
			local skip = mQueuedGoToPreviousScreen.skip
			mQueuedGoToPreviousScreen = nil
			_T.GoToPreviousScreen(skip)
		end

		if mQueuedLogoff then
			fn30()
		end

		if mUnblockWhenAsyncDone then
			fn3(0)
			mUnblockWhenAsyncDone = false
		end
	end
end

local function fn47()
	if not gRegion:IsMaster() then
		return
	end

	local gGameRules = gGameRules

	if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameRules:__wf_atom_964056fd()) then
		return
	end

	if _G.CapacityCost == nil then
		_G.CapacityCost = {}
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_caa82b8d = gGameRules:__wf_atom_964056fd():__wf_atom_caa82b8d(__wf_atom_01e60b5b)
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		local mRooms = __wf_atom_9be88b01:__wf_atom_247a5d2e(true).mRooms

		for i = 1, #mRooms do
			local mPlacedDecos = mRooms[i].mPlacedDecos
			local total = 0

			for _, mPlacedDeco in ipairs(mPlacedDecos) do
				local decoType = mPlacedDeco.decoType

				if __wf_atom_7e8ad928(decoType) then
					continue
				end

				local __wf_atom_5b41f63b = decoType:__wf_atom_5b41f63b()

				if _G.CapacityCost[__wf_atom_5b41f63b] == nil then
					for _, v35 in ipairs(__wf_atom_caa82b8d) do
						if not (v35:IsA(__wf_atom_87288ae7) and v35:__wf_atom_47a670f8() == decoType) then
							continue
						end

						_G.CapacityCost[__wf_atom_5b41f63b] = v35:__wf_atom_e23658d9(false)
						break
					end
				end

				if _G.CapacityCost[__wf_atom_5b41f63b] ~= nil then
					total += _G.CapacityCost[__wf_atom_5b41f63b]
				end

				__wf_atom_83c14687(0)
			end

			__wf_atom_9be88b01:__wf_atom_ba21586a(mRooms[i].mName, total)
		end
	end
end

local function fn48() -- 2 equivalent calls inferred from this helper
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(fragmentsScreenMovie)
end

function ShowFragmentScreen()
	fn48() -- inferred equivalent call
end

local function fn49() -- 2 equivalent calls inferred from this helper
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(actionFigureMovie)
end

function ShowActionFigureScreen()
	fn49() -- inferred equivalent call
end

local function fn50() -- 2 equivalent calls inferred from this helper
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(lightCustMovie)
end

function ShowLightCustScreen()
	fn50() -- inferred equivalent call
end

local function fn51()
	if
		__wf_atom_7e8ad928(gRegion)
		or __wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97))
	then
		return
	end

	local v34 = Symbol("DynamicDojoDeco")

	if not __wf_atom_7e8ad928(gGameData) then
		local v35 = Vector()
		local v36 = Vector()
		local v37 = Rotation()
		local mRooms = gGameData:__wf_atom_247a5d2e(gRegion:IsMaster()).mRooms
		local count2 = 0

		for i = v15.LoaderProgress.RoomCreationIndex, v15.LoaderProgress.RoomLoaderIndex do
			v15.LoaderProgress.RoomCreationIndex = i
			local mPlacedDecos = mRooms[i].mPlacedDecos
			local mName = mRooms[i].mName
			local count3 = #mPlacedDecos
			local v38 = {}

			for j = v15.LoaderProgress.DecoCreationIndex, count3 do
				local mPlacedDeco = mPlacedDecos[j]
				local __wf_atom_854e0028 = mPlacedDeco:__wf_atom_854e0028()

				if _T.ShipDecos == nil then
					_T.ShipDecos = {}
				end

				local v39 = false

				if __wf_atom_7e8ad928(mPlacedDeco.decoType) then
					v15.LoaderProgress.DecoCreationIndex = j + 1
				elseif v15.LoaderProgress.DecosLoaded[mPlacedDeco.decoType:__wf_atom_5b41f63b()] == nil then
					v15.LoaderProgress.DecoCreationIndex = j
					break
				else
					v15.LoaderProgress.DecoCreationIndex = j + 1
					v39 = true
				end

				if not (v39 and __wf_atom_7e8ad928(_T.ShipDecos[__wf_atom_854e0028])) then
					continue
				end

				local v40 = nil
				local __wf_atom_7d9f7223 = mPlacedDeco:__wf_atom_7d9f7223()
				local shipDecoAnchor = module2.GetShipDecoAnchor(mName, mPlacedDeco)

				if __wf_atom_7e8ad928(shipDecoAnchor) then
					print("Could not find attachment anchor for ship decos!")
				elseif __wf_atom_7d9f7223 == "" then
					v40 = shipDecoAnchor:Attach(
						Type(mPlacedDeco.decoType),
						EMPTY_SYMBOL,
						mPlacedDeco.pos,
						mPlacedDeco.rot
					)
				elseif __wf_atom_7e8ad928(_T.ShipDecos[__wf_atom_7d9f7223]) then
					v40 = shipDecoAnchor:Attach(Type(mPlacedDeco.decoType), EMPTY_SYMBOL)
					v40:__wf_atom_e6ed03c8()
					table.insert(v38, { mPlacedDeco, v40 })
				else
					v40 = _T.ShipDecos[__wf_atom_7d9f7223]:Attach(
						Type(mPlacedDeco.decoType),
						EMPTY_SYMBOL,
						mPlacedDeco.pos,
						mPlacedDeco.rot
					)
				end

				if __wf_atom_7e8ad928(v40) then
					continue
				end

				if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_469b1d97) then
					local __wf_atom_be0bea4a = v40:__wf_atom_be0bea4a()

					if not __wf_atom_7e8ad928(__wf_atom_be0bea4a) then
						for k = 1, #__wf_atom_be0bea4a do
							if __wf_atom_be0bea4a[k]:IsA(__wf_atom_0f45538d) then
								__wf_atom_be0bea4a[k]:Disable()
							end
						end
					end
				end

				if __wf_atom_7d9f7223 == "" then
					v40:__wf_atom_e6ed03c8()
				else
					local shipDeco = _T.ShipDecos[__wf_atom_7d9f7223]

					if __wf_atom_7e8ad928(shipDeco) then
						v40:__wf_atom_e310f01f(mPlacedDeco.pos, mPlacedDeco.rot)
					else
						v40:__wf_atom_6172d87a(shipDeco, false)
					end
				end

				v40:__wf_atom_b76c96ce(mPlacedDeco.socketInfo)
				v40:SetId(__wf_atom_854e0028)
				v40:__wf_atom_7b0745e3(mRooms[i].mName)
				v40:__wf_atom_c529459a(4, 1, true, nil)

				if mPlacedDeco.scale > 0 then
					v40:SetMeshScale(mPlacedDeco.scale)
				end

				module15.ApplyPlacedDecoPictureFrameInfo(mPlacedDeco, v40)

				if v40:IsA(customizableDecoType) then
					v40:__wf_atom_ae2be356(mPlacedDeco.customizationInfo, true)
					local mLoadOutPreset = mPlacedDeco.customizationInfo.mLoadOutPreset
					local mVehiclePreset = mPlacedDeco.customizationInfo.mVehiclePreset
					local mId = mLoadOutPreset.mItemId.mId
					local mId2 = mVehiclePreset.mItemId.mId
					local mLoadOutType = mPlacedDeco.customizationInfo.mLoadOutType
					local v41

					if mId2 == SF.__wf_atom_b8679e91 or mId2 == "" then
						mId2 = ""
						v41 = false
					else
						table.insert(v17.Figures, v40)
						v41 = true
					end

					if mId == SF.__wf_atom_b8679e91 or mId == "" then
						if not __wf_atom_7e8ad928(mPlacedDeco.customizationInfo.mAvatarType) then
							local v42 = false

							for k = 1, #v17.EnemyTypes do
								if v17.EnemyTypes[k] == mPlacedDeco.customizationInfo.mAvatarType then
									v42 = true
								end
							end

							if not v42 then
								table.insert(v17.EnemyTypes, mPlacedDeco.customizationInfo.mAvatarType)
							end

							table.insert(v17.EnemyFigures, v40)
						end
					else
						local v42 = mId .. mId2 .. mLoadOutType

						if __wf_atom_7e8ad928(v17.PresetIds[v42]) then
							table.insert(v17.PresetInfos, {
								Preset = mLoadOutPreset:Copy(),
								VehiclePreset = mVehiclePreset:Copy(),
								LoadOutType = mLoadOutType
							})
							v17.PresetIds[v42] = 1
						end

						if not v41 then
							table.insert(v17.Figures, v40)
						end
					end
				end

				_T.ShipDecos[__wf_atom_854e0028] = v40

				if v40:__wf_atom_db682341() == v34 then
					if _T.DynamicDecos == nil then
						_T.DynamicDecos = {}
					end

					_T.DynamicDecos[__wf_atom_854e0028] = {
						pos = v40:__wf_atom_a2a18137(),
						rot = v40:__wf_atom_2f2bada0()
					}
				end

				if _T.PlacingCustomizableDeco and j == #mPlacedDecos then
					if v40:IsA(WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ShipPlaceablePictureFrame")) then
						_T.FragmentViewerDeco = v40
						fn48() -- inferred equivalent call
					elseif v40:IsA(WeakResource("/Lotus/Objects/Tenno/ActionFigures/Figures/BaseAF")) then
						_T.ActionFigureDeco = v40
						fn49() -- inferred equivalent call
					elseif v40:IsA(lightDecoType) then
						_T.LightDeco = v40

						if v40:IsA(textDecoType) then
							_T.TextLightMovie = v40:__wf_atom_4f911ec1()
						else
							_T.TextLightMovie = nil
						end

						fn50() -- inferred equivalent call
					end

					_T.PlacingCustomizableDeco = false
				end

				if mName == v31 then
					v40:__wf_atom_210b921a(v35, v36, v37)

					if not __wf_atom_7e8ad928((gRegion:__wf_atom_c30367c9(v36, v35, v37, v32, false, true, false))) then
						if _T.ShipDecosInVignette == nil then
							_T.ShipDecosInVignette = {}
						end

						_T.ShipDecosInVignette[__wf_atom_854e0028] = v40
					end
				end

				count2 += 1

				if count2 >= 8 then
					break
				end
			end

			for j = 1, #v38 do
				local v39 = v38[j]
				local __wf_atom_7d9f7223 = v39[1]:__wf_atom_7d9f7223()

				if __wf_atom_7e8ad928(v39[2]) then
					continue
				end

				local shipDeco = _T.ShipDecos[__wf_atom_7d9f7223]

				if __wf_atom_7e8ad928(shipDeco) then
					continue
				end

				v39[2]:__wf_atom_e310f01f(v39[1].pos, v39[1].rot)
				v39[2]:__wf_atom_6172d87a(shipDeco, true)
			end

			if count3 < v15.LoaderProgress.DecoCreationIndex then
				v15.LoaderProgress.DecoCreationIndex = 1

				if v15.LoaderProgress.RoomCreationIndex < #mRooms then
					v15.LoaderProgress.RoomCreationIndex = v15.LoaderProgress.RoomCreationIndex + 1
				end
			end

			if count2 >= 8 then
				break
			end
		end

		if count2 == 0 then
			if v15.LoaderProgress.LastLoad then
				module14.CreateActionFigureLoader(nil)

				if not __wf_atom_7e8ad928(_T.ActionFigureLoadOutLoader) then
					_T.ActionFigureLoadOutLoader:LoadDecosWithLoadOutsThenFinish(
						v17.Figures,
						v17.PresetInfos,
						v17.EnemyFigures,
						v17.EnemyTypes
					)
				end

				v15.IsLoading = false
				v17.Figures = {}
				v17.PresetInfos = {}
				v17.PresetIds = {}
			else
				fn5()
			end
		end
	end
end

local function fn52()
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_247a5d2e = gGameData:__wf_atom_247a5d2e(gRegion:IsMaster())
	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	local mVignetteFish = __wf_atom_247a5d2e.mVignetteFish

	if __wf_atom_7e8ad928(mVignetteFish) then
		return
	end

	for i = module.Ternary(_T.QueueFishTankPopulation == nil, 0, 1), 1 do
		if i == 1 and not v16.IsFishTank then
			break
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FishPaths" .. tostring(i)))

		if i == 1 and __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			_T.QueueFishTankPopulation = true
			break
		end

		_T.QueueFishTankPopulation = false

		if __wf_atom_7e8ad928(__wf_atom_964056fd) or __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			continue
		end

		for j = 1, 10 do
			local v34 = mVignetteFish[j + i * 10]

			if __wf_atom_7e8ad928(v34) then
				continue
			end

			local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(v34)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				continue
			end

			local fishDeco = module6.GetFishDeco(__wf_atom_232fd31d, fishInfoManifest)

			if __wf_atom_7e8ad928(fishDeco) then
				continue
			end

			local v35 = Symbol("GAME_C1_FISH" .. tostring(j))
			local v36 = __wf_atom_0a6a5887:Attach(Resource(fishDeco), v35)
			v36:MakeInvulnerable()
			module6.SetFishScale(v36, __wf_atom_232fd31d)
		end
	end
end

function OnVignetteStreamed(_, _)
	fn52()
	v16.Loader = nil
end

function OnVignetteRemoved(_, _) end

local function fn53()
	if not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_247a5d2e = gGameData:__wf_atom_247a5d2e(gRegion:IsMaster())
		local mVignette = __wf_atom_247a5d2e.mVignette

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(mVignette) then
			local __wf_atom_c1a9a26e = Resource(mVignette):__wf_atom_c1a9a26e()
			module6.StreamVignette(mMovie, __wf_atom_c1a9a26e)
		else
			fn52()
		end

		local mWallpaper = __wf_atom_247a5d2e.mWallpaper

		if not __wf_atom_7e8ad928(mWallpaper) then
			local v34 = Resource(mWallpaper)
			module6.SetQuartersWallpaper(Resource(v34:__wf_atom_52cfac4b()))
		end
	end
end

local function fn54()
	if _T.FortressLocation ~= nil and _T.FortressLocation.Initialized == true then
		local v34 = _T.FortressLocation.Progress + __wf_atom_fa1258d0() * _T.FortressLocation.Velocity

		if v34 >= 1 then
			_T.FortressLocation.SplineIndex = 1 + _T.FortressLocation.SplineIndex % _T.FortressLocation.MaxSplines
		end

		_T.FortressLocation.Progress = v34 % 1
	end
end

local function fn55()
	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97))
	then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local inventory = __wf_atom_9be88b01:GetInventory()
		local loadOut = SF.LoadOut()
		local mFavouriteLoadoutId = __wf_atom_9be88b01:__wf_atom_247a5d2e(true).mFavouriteLoadoutId

		if mFavouriteLoadoutId ~= nil then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FavouriteWarframeEntity"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_7e8ad928(_T.FavWarframeAvatar) then
				_T.FavWarframeAvatar = gRegion:CreateEntity(
					favouriteWarframeAvatarType,
					__wf_atom_0a6a5887:GetPosition(),
					__wf_atom_0a6a5887:__wf_atom_dc309f8a()
				)
				_T.FavWarframeAvatar:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
				_T.FavWarframeAvatar:__wf_atom_51075230(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
				__wf_atom_0a6a5887:SetVisibility(false, true)
			end

			if __wf_atom_7e8ad928(_T.FavWarframeAvatar) then
				return
			end

			_T.FavWarframeAvatar:__wf_atom_e5d015a7(Symbol())
			__wf_atom_9be88b01:__wf_atom_9ef963fa(
				loadOut,
				0,
				inventory:__wf_atom_c132f79b(0, mFavouriteLoadoutId),
				not gRegion:IsMaster()
			)
			_T.FavouriteLoadoutLoader = {
				Loadout = loadOut,
				Loader = __wf_atom_9be88b01:__wf_atom_ce80b536()
			}
		end
	end
end

function UpdateShipFavouriteWarframe(p)
	if p and not gRegion:IsMaster() and gGameRules:__wf_atom_09e81034() then
		return
	end

	fn55()
end

function OnFavouriteLoadoutSet() end

local function fn56()
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local __wf_atom_23e1a032 = __wf_atom_9be88b01:GetInventory():__wf_atom_23e1a032(0)

		for i = 1, #__wf_atom_23e1a032 do
			if __wf_atom_7e8ad928(__wf_atom_23e1a032[i]) or __wf_atom_23e1a032[i].mRemove then
				continue
			end

			__wf_atom_9be88b01:__wf_atom_a929e2f8(__wf_atom_23e1a032[i].mItemId, "OnFavouriteLoadoutSet")
			return
		end

		__wf_atom_9be88b01:__wf_atom_a929e2f8(MongoId(), "OnFavouriteLoadoutSet")
	end
end

function DeleteShipFavouriteWarframe()
	fn56()
end

local function fn57()
	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97))
	then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local v34

		if gRegion:IsMaster() then
			v34 = __wf_atom_9be88b01:GetInventory():__wf_atom_dc9247fc()
		else
			v34 = __wf_atom_9be88b01:__wf_atom_f0cdeba2():__wf_atom_dc9247fc()
		end

		_T.HelminthSuitLoader = nil

		if
			not __wf_atom_7e8ad928(v34.mLastConsumedSuit.mItemType)
			and Engine.__wf_atom_db2b0cee(v34.mAbilityOverrideUnlockCooldown) > 0
		then
			_T.HelminthSuitLoader = { LoadOut = SF.LoadOut() }
			__wf_atom_9be88b01:__wf_atom_cbc52d55(_T.HelminthSuitLoader.LoadOut, not gRegion:IsMaster())
			_T.HelminthSuitLoader.Loader = __wf_atom_9be88b01:__wf_atom_78bae7ce()
		end

		if __wf_atom_7e8ad928(_T.HelminthSuitLoader) then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HelminthConsumedSuit"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:SetVisibility(false, true)
			end
		end
	end
end

function CreateHelminthSuitLoader()
	fn57()
end

local function fn58()
	if _T.HelminthSuitLoader.LoadOutCopyPending == nil then
		local v34 = gRegion:IsMaster() and 3 or 4
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			print("Couldn't get player avatar, not creating a loader")
			return
		end

		local position = __wf_atom_c4f78a8f:GetPosition() + Vector(0, -2, 0)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ActionFigureAvatarSpawn"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			position = __wf_atom_0a6a5887:GetPosition()
		end

		_T.HelminthSuitLoader.Avatar = gRegion:CreateEntity(
			helminthSuitConsumeAvatarType,
			position,
			__wf_atom_80368bb1,
			__wf_atom_c4f78a8f,
			__wf_atom_c4f78a8f,
			v34
		)

		if not __wf_atom_7e8ad928(_T.HelminthSuitLoader.Avatar) then
			_T.HelminthSuitLoader.Avatar:__wf_atom_4aa8ac56(true, false)
			_T.HelminthSuitLoader.Avatar:__wf_atom_e5d015a7(Symbol())
			_T.HelminthSuitLoader.Avatar:SetVisibility(false)
			_T.HelminthSuitLoader.Avatar:__wf_atom_9373d0eb(7, true)
			_T.HelminthSuitLoader.Avatar:__wf_atom_986f733d(Symbol(), 5)
			_T.HelminthSuitLoader.Avatar:__wf_atom_d2b2176d():BuildLoadOut(_T.HelminthSuitLoader.LoadOut)
			_T.HelminthSuitLoader.LoadOutCopyPending = 4
		end
	else
		_T.HelminthSuitLoader.LoadOutCopyPending = _T.HelminthSuitLoader.LoadOutCopyPending - 1

		if _T.HelminthSuitLoader.LoadOutCopyPending == 0 then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HelminthConsumedSuit"))
			__wf_atom_0a6a5887:SetVisibility(true, true)
			module11.SetupDecoAsAvatar(__wf_atom_0a6a5887, _T.HelminthSuitLoader.Avatar, false)
			local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(helminthAttachmentType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:FirePort("Burst")
			end

			_T.HelminthSuitLoader = nil
		end
	end
end

local function fn59(p, mFriendRequestActiveNotification2) -- 1 equivalent call inferred from this helper
	if p then
		mFriendRequestActiveNotification = mFriendRequestActiveNotification2
		return
	end

	if mFriendRequestActiveNotification == mFriendRequestActiveNotification2 then
		mFriendRequestActiveNotification = nil
	end

	if not __wf_atom_7e8ad928(gGameData) and mFriendRequests[mFriendRequestActiveNotification2] then
		mFriendRequests[mFriendRequestActiveNotification2] = nil
		gGameData:__wf_atom_26634b98(mFriendRequestActiveNotification2)
	end
end

local function fn60() end

function FriendRequestReceived()
	mNewFriendRequests = true
end

function FriendNotificationSelected()
	if not __wf_atom_7e8ad928(mFriendRequestActiveNotification) then
		_T.HideNotification()
		local mFriendRequest = mFriendRequests[mFriendRequestActiveNotification]
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 5
		dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Lobby_FriendInviteDetails", false, {
			USER = mFriendRequestActiveNotification
		}) .. "\r\r" .. mFriendRequest.mNote
		dialogSettings.firstString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_Accept", false)
		dialogSettings.secondString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_Decline", false)
		dialogSettings.thirdString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NavBar_Cancel", false)
		dialogSettings:SetCallback("FriendRequestOptionChosen")
		module.ShowCustomMessage(dialogSettings)
	end
end

function FriendRequestOptionChosen(p)
	if not __wf_atom_7e8ad928(gGameData) then
		local mFriendRequest = mFriendRequests[mFriendRequestActiveNotification]

		if not __wf_atom_7e8ad928(mFriendRequest) then
			if tonumber(p) == 4 then
				gGameData:__wf_atom_2e6558d0(mFriendRequest.mId, "OnConfirmFriendResult")
			elseif tonumber(p) == 6 then
				gGameData:__wf_atom_49d863d3(mFriendRequest, "OnRemoveFriendResult")
			end
		end

		fn59(false, mFriendRequestActiveNotification) -- inferred equivalent call
	end
end

function OnGetFriendsResult(p, p2)
	if p then
		return
	end

	module.ShowMessage(module.ParseConnectionErrorMsg(p2))
end

function OnConfirmFriendResult(p, p2)
	if not p then
		module.ShowMessage(module.ParseConnectionErrorMsg(p2))
		return
	end

	module.ShowMessage("/Lotus/Language/Menu/SocialOverlay_FriendConfirmed")

	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_e1c832d0("OnGetFriendsResult")
	end
end

function OnRemoveFriendResult(p, p2)
	if not p then
		module.ShowMessage(module.ParseConnectionErrorMsg(p2))
		return
	end

	module.ShowMessage("/Lotus/Language/Menu/SocialOverlay_FriendRemoveConfirm")

	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_e1c832d0("OnGetFriendsResult")
	end
end

function OnLeaveDojoSquadDone()
	module.ShowMessage("/Lotus/Language/Menu/HostDojoFailureDownload")
end

local function fn61(value, p)
	if __wf_atom_7e8ad928(gGameRules) then
		v25 = value
		return
	end

	local v34 = string.find(value, module2.TAG_SEPERATOR)
	local v35

	if v34 then
		v35 = string.sub(value, 1, v34 - 1)
	else
		v35 = value
	end

	local v36 = Symbol(v35)
	local starChart = module2.GetStarChart()

	if __wf_atom_7e8ad928(starChart) then
		return
	end

	local missionForLocation = starChart:BuildMissionForLocation(v36)

	if string.find(value, module2.KEY_TAG) then
		missionForLocation = Resource(v35):__wf_atom_72fc675e():Copy()
	else
		local _ = not missionForLocation.levelOverride
	end

	local uiMode = module2.GetUIMode()

	if uiMode == module2.UI_MODE_IN_SPACE_HUB and gGameRules:__wf_atom_72fc675e().location == v36 then
		if p then
			gMatchingService:SetSquadHostHubLevelName(value, true)
		else
			print("Received message to join a hub-squad while already in a hub. Staying put and hoping everyone's in the same location/instance.")
			return
		end
	end

	if v35 == "DojoHUB" then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_18a5d83b:__wf_atom_563ea37f() then
			print("UGC restrictions in joining Dojo")
			return
		end

		local v37 = ""
		local v38 = string.find(value, module2.TAG_SEPERATOR, v34 + 1)

		if v38 then
			_T.gDojoData = { Invite = true }
			local v39 = string.find(value, module2.TAG_SEPERATOR, v38 + 1)

			if v39 then
				v37 = string.sub(value, v39 + 1)
				value = string.sub(value, 1, v39 - 1)
			end

			_T.gDojoData.GuildId = string.sub(value, v38 + 1)
		end

		local v39 = MongoId()

		if _T.gDojoData == nil or _T.gDojoData.GuildId == nil or not v39:Parse(_T.gDojoData.GuildId) then
			print("Couldn't find GuildId in the hubName, bailing!")
			gMatchingService:SetSquadHostHubLevelName("")
			gMatchingService:LeaveSquad("OnLeaveDojoSquadDone")
		else
			if uiMode == module2.UI_MODE_IN_DOJO and _T.gDojoData.GuildId == gGameRules:__wf_atom_5ff594a3() then
				print("Received message to join a Dojo-squad while already in the same Dojo. Staying put and hoping everyone's in the same location/instance.")
				return
			end

			if v37 ~= "" then
				Engine.WebGet(v37, "OnDojoData")
				return
			end

			local __wf_atom_c80df685 = __wf_atom_18a5d83b:__wf_atom_c80df685()
			Engine.WebGet(
				__wf_atom_c67f9605:__wf_atom_2863bfee() .. "getGuildDojo.php?" .. __wf_atom_c80df685 .. "&guildId=" .. _T.gDojoData.GuildId,
				"OnDojoData"
			)
		end
	else
		local missionOpenLevelArgs = module3.GetMissionOpenLevelArgs(Symbol(value), missionForLocation)

		if __wf_atom_7e8ad928(missionOpenLevelArgs) then
			print("LevelArgs are null, cannot open level")
			return
		end

		missionOpenLevelArgs.loadFromLobby = false

		if gRegion:IsMaster() or not gGameRules:__wf_atom_09e81034() then
			Engine.OpenLevel(missionOpenLevelArgs)
			return
		end

		missionOpenLevelArgs.loadToLobby = true
		missionOpenLevelArgs.isLobby = true
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a1dd9b66(
			missionOpenLevelArgs,
			value .. module2.HUB_TAG
		)
		gMatchingService:SetSquadHostHubLevelName(value)
		Engine.Disconnect(true)
	end
end

local function fn62()
	local result = {
		{
			Collection = "weekly.accounts.ZephyrScore",
			Title = Localize("/Lotus/Language/Menu/Profile_ZephyrLeaderboard", nil),
			Weekly = true
		},
		{
			Collection = "weekly.accounts.SentinelGameScore",
			Title = Localize("/Lotus/Language/Menu/Profile_SentinelGameLeaderboard", nil),
			Weekly = true
		},
		{
			Collection = "weekly.accounts.DojoObstacleScore",
			Title = Localize("/Lotus/Language/Menu/Profile_ObstacleScoreLeaderboard", nil),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_WINS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballWins", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_POINTS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballPoints", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_GOALS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballGoals", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_ASSISTS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballAssists", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_REBOUNDS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballRebounds", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_SAVES",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballSaves", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_PASSES",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballPasses", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_CATCHES",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballCatches", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_INTERCEPTIONS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballInterceptions", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_CHECKS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballChecks", nil)
			}),
			Weekly = true
		},
		{
			Collection = "weekly.speedball.accounts.SB_STEALS",
			Title = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SpeedBallLeaderboard", true, {
				TYPE = Localize("/Lotus/Language/Menu/Profile_SpeedballSteals", nil)
			}),
			Weekly = true
		}
	}
	local starChart = module2.GetStarChart()
	local __wf_atom_2cdd5bc9 = starChart:__wf_atom_2cdd5bc9()
	local __wf_atom_161b95d4 = starChart:__wf_atom_161b95d4()

	for i = 1, #__wf_atom_161b95d4 do
		__wf_atom_83c14687(0)
		local v34 = __wf_atom_161b95d4[i]

		for j = 1, #__wf_atom_2cdd5bc9 do
			local v35 = __wf_atom_2cdd5bc9[j]

			if not (v35.region + 1 == i and v35.name:__wf_atom_8598f3a9() and (v35.nodeType == 0 or v35.nodeType == 4)) then
				continue
			end

			local missionForLocation = starChart:BuildMissionForLocation(v35.name)
			local missionType = missionForLocation.missionType

			if not (missionType == 8 and missionForLocation.maxWaveNum == 0 or missionType == 2 or missionType == 13 or missionType == 17 or missionType == 27 or missionType == 30 or missionType == 33 or missionType == 34) then
				continue
			end

			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v34.name, true)
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v35.locTag:c_str(), true)
			local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/RegionNode", true, {
				REGION = __wf_atom_8e9ac384,
				NODE = __wf_atom_8e9ac384_2
			})
			table.insert(result, {
				Collection = "weekly.accounts." .. v35.name:c_str(),
				Title = __wf_atom_8e9ac384_3,
				Weekly = true
			})
		end
	end

	return result
end

local function fn63()
	if
		not __wf_atom_7e8ad928(__wf_atom_21342f4a)
		and _T.ShowNotification ~= nil
		and __wf_atom_21342f4a:__wf_atom_350edd56()
	then
		local v34 = fn62()
		local __wf_atom_555f017a = __wf_atom_21342f4a:__wf_atom_555f017a()

		for i = 1, #__wf_atom_555f017a do
			local leaderboard = __wf_atom_555f017a[i].leaderboard
			local rank = __wf_atom_555f017a[i].rank

			for j = 1, #v34 do
				if v34[j].Collection ~= leaderboard then
					continue
				end

				local v35 = v34[j].Weekly and "/Lotus/Language/Menu/LeaderboardPlacementWeekly"
					or "/Lotus/Language/Menu/LeaderboardPlacement"
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v35, true, {
					RANK = rank,
					LEADERBOARD = v34[j].Title
				})
				_T.ShowNotification(__wf_atom_8e9ac384, "Leaderboard")
				print("LB Placement: \"" .. __wf_atom_8e9ac384 .. "\"")
				break
			end
		end

		__wf_atom_21342f4a:__wf_atom_25e9a5fc()
	end
end

local function fn64()
	local v34 = true

	if not __wf_atom_7e8ad928(mStyleBackgroundMovie) then
		if __wf_atom_7e8ad928(nil) or mStyleBackgroundMovie:__wf_atom_6d61d595() ~= WeakResource(nil) then
			mStyleBackgroundMovie:Close()
		else
			v34 = false
		end
	end

	if v34 and not __wf_atom_7e8ad928(nil) then
		_T.BackgroundVisible = nil
		mStyleBackgroundMovie = mMovie:PushChildMovie(nil)
	end
end

local function fn65()
	local sounds = module7.GetSounds()

	if not __wf_atom_7e8ad928(sounds) then
		local _g = _G
		local v34 = 0
		local uiSound_Open

		if v34 ~= nil then
			uiSound_Open = sounds[v34 + 1]
		end

		_g.UISound_Open = uiSound_Open
		local _g2 = _G
		local v36 = 1
		local uiSound_Close

		if v36 ~= nil then
			uiSound_Close = sounds[v36 + 1]
		end

		_g2.UISound_Close = uiSound_Close
		local _g3 = _G
		local v38 = 2
		local uiSound_HudAchievement

		if v38 ~= nil then
			uiSound_HudAchievement = sounds[v38 + 1]
		end

		_g3.UISound_HudAchievement = uiSound_HudAchievement
		local _g4 = _G
		local v40 = 3
		local uiSound_Focus

		if v40 ~= nil then
			uiSound_Focus = sounds[v40 + 1]
		end

		_g4.UISound_Focus = uiSound_Focus
		local _g5 = _G
		local v42 = 4
		local uiSound_Unfocus

		if v42 ~= nil then
			uiSound_Unfocus = sounds[v42 + 1]
		end

		_g5.UISound_Unfocus = uiSound_Unfocus
		local _g6 = _G
		local v44 = 5
		local uiSound_Select

		if v44 ~= nil then
			uiSound_Select = sounds[v44 + 1]
		end

		_g6.UISound_Select = uiSound_Select
		local _g7 = _G
		local v46 = 6
		local uiSound_Scroll

		if v46 ~= nil then
			uiSound_Scroll = sounds[v46 + 1]
		end

		_g7.UISound_Scroll = uiSound_Scroll
		local _g8 = _G
		local v48 = 7
		local uiSound_Purchase

		if v48 ~= nil then
			uiSound_Purchase = sounds[v48 + 1]
		end

		_g8.UISound_Purchase = uiSound_Purchase
		local _g9 = _G
		local v50 = 8
		local uiSound_Error

		if v50 ~= nil then
			uiSound_Error = sounds[v50 + 1]
		end

		_g9.UISound_Error = uiSound_Error
		local _g10 = _G
		local v52 = 9
		local uiSound_Type

		if v52 ~= nil then
			uiSound_Type = sounds[v52 + 1]
		end

		_g10.UISound_Type = uiSound_Type
		local _g11 = _G
		local v54 = 10
		local uiSound_SearchType

		if v54 ~= nil then
			uiSound_SearchType = sounds[v54 + 1]
		end

		_g11.UISound_SearchType = uiSound_SearchType
		local _g12 = _G
		local v56 = 11
		local uiSound_GridOpen

		if v56 ~= nil then
			uiSound_GridOpen = sounds[v56 + 1]
		end

		_g12.UISound_GridOpen = uiSound_GridOpen
		local _g13 = _G
		local v58 = 12
		local uiSound_GridOpenTwo

		if v58 ~= nil then
			uiSound_GridOpenTwo = sounds[v58 + 1]
		end

		_g13.UISound_GridOpenTwo = uiSound_GridOpenTwo
		local _g14 = _G
		local v60 = 13
		local uiSound_GridRow

		if v60 ~= nil then
			uiSound_GridRow = sounds[v60 + 1]
		end

		_g14.UISound_GridRow = uiSound_GridRow
		local _g15 = _G
		local v62 = 14
		local uiSound_DialogOpen

		if v62 ~= nil then
			uiSound_DialogOpen = sounds[v62 + 1]
		end

		_g15.UISound_DialogOpen = uiSound_DialogOpen
		local _g16 = _G
		local v64 = 15
		local uiSound_DialogClose

		if v64 ~= nil then
			uiSound_DialogClose = sounds[v64 + 1]
		end

		_g16.UISound_DialogClose = uiSound_DialogClose
		local _g17 = _G
		local v66 = 16
		local uiSound_Countdown

		if v66 ~= nil then
			uiSound_Countdown = sounds[v66 + 1]
		end

		_g17.UISound_Countdown = uiSound_Countdown
		local _g18 = _G
		local v68 = 17
		local uiSound_ItemTip

		if v68 ~= nil then
			uiSound_ItemTip = sounds[v68 + 1]
		end

		_g18.UISound_ItemTip = uiSound_ItemTip
		local _g19 = _G
		local v70 = 18
		local uiSound_ItemTipSection

		if v70 ~= nil then
			uiSound_ItemTipSection = sounds[v70 + 1]
		end

		_g19.UISound_ItemTipSection = uiSound_ItemTipSection
		local _g20 = _G
		local v72 = 19
		local uiSound_ButtonSelect

		if v72 ~= nil then
			uiSound_ButtonSelect = sounds[v72 + 1]
		end

		_g20.UISound_ButtonSelect = uiSound_ButtonSelect
		local _g21 = _G
		local v74 = 20
		local uiSound_CursorBlink

		if v74 ~= nil then
			uiSound_CursorBlink = sounds[v74 + 1]
		end

		_g21.UISound_CursorBlink = uiSound_CursorBlink
		local _g22 = _G
		local v76 = 21
		local uiSound_SweetenerOne

		if v76 ~= nil then
			uiSound_SweetenerOne = sounds[v76 + 1]
		end

		_g22.UISound_SweetenerOne = uiSound_SweetenerOne
		local _g23 = _G
		local v78 = 22
		local uiSound_SweetenerTwo

		if v78 ~= nil then
			uiSound_SweetenerTwo = sounds[v78 + 1]
		end

		_g23.UISound_SweetenerTwo = uiSound_SweetenerTwo
		local _g24 = _G
		local v80 = 23
		local uiSound_WindowOpen

		if v80 ~= nil then
			uiSound_WindowOpen = sounds[v80 + 1]
		end

		_g24.UISound_WindowOpen = uiSound_WindowOpen
		local _g25 = _G
		local v82 = 24
		local uiSound_WindowClose

		if v82 ~= nil then
			uiSound_WindowClose = sounds[v82 + 1]
		end

		_g25.UISound_WindowClose = uiSound_WindowClose
		local _g26 = _G
		local v84 = 25
		local uiSound_LoginSuccess

		if v84 ~= nil then
			uiSound_LoginSuccess = sounds[v84 + 1]
		end

		_g26.UISound_LoginSuccess = uiSound_LoginSuccess
		local _g27 = _G
		local v86 = 26
		local uiSound_MissionStart

		if v86 ~= nil then
			uiSound_MissionStart = sounds[v86 + 1]
		end

		_g27.UISound_MissionStart = uiSound_MissionStart
		local _g28 = _G
		local v88 = 27
		local uiSound_VotingStarted

		if v88 ~= nil then
			uiSound_VotingStarted = sounds[v88 + 1]
		end

		_g28.UISound_VotingStarted = uiSound_VotingStarted
		local _g29 = _G
		local v90 = 28
		local uiSound_LogoTransition

		if v90 ~= nil then
			uiSound_LogoTransition = sounds[v90 + 1]
		end

		_g29.UISound_LogoTransition = uiSound_LogoTransition
		local _g30 = _G
		local v92 = 29
		local uiSound_ChatPM

		if v92 ~= nil then
			uiSound_ChatPM = sounds[v92 + 1]
		end

		_g30.UISound_ChatPM = uiSound_ChatPM
		local _g31 = _G
		local v94 = 30
		local uiSound_ChatDM

		if v94 ~= nil then
			uiSound_ChatDM = sounds[v94 + 1]
		end

		_g31.UISound_ChatDM = uiSound_ChatDM
		local _g32 = _G
		local v96 = 31
		local uiSound_ChatSquad

		if v96 ~= nil then
			uiSound_ChatSquad = sounds[v96 + 1]
		end

		_g32.UISound_ChatSquad = uiSound_ChatSquad
		local _g33 = _G
		local v98 = 32
		local uiSound_StartDrag

		if v98 ~= nil then
			uiSound_StartDrag = sounds[v98 + 1]
		end

		_g33.UISound_StartDrag = uiSound_StartDrag
		local _g34 = _G
		local v100 = 33
		local uiSound_EndDrag

		if v100 ~= nil then
			uiSound_EndDrag = sounds[v100 + 1]
		end

		_g34.UISound_EndDrag = uiSound_EndDrag
		local _g35 = _G
		local v102 = 34
		local uiSound_GearWheelTransition

		if v102 ~= nil then
			uiSound_GearWheelTransition = sounds[v102 + 1]
		end

		_g35.UISound_GearWheelTransition = uiSound_GearWheelTransition
	end
end

function StyleChangedCallback()
	if __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
		return
	end

	print("UISTYLE: Style changed callback called")
	module7.RefreshStyle()
	fn64()
	fn65()
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnStyleChangedCallback", "")
end

function Update()
	if not mControl.Initialized then
		return
	end

	if __wf_atom_7e8ad928(_T.BackgroundMovie) and not __wf_atom_7e8ad928(mMovie) then
		_T.BackgroundMovie = mMovie
	end

	if not mControl.StyleInit then
		if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
			print("UISTYLE: Style changed callback called")
			module7.RefreshStyle()
			fn64()
			fn65()
			__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnStyleChangedCallback", "")
		end

		mControl.StyleInit = true
	end

	if v15.IsLoading and not __wf_atom_7e8ad928(v15.Loader) and v15.Loader:__wf_atom_86399a47() then
		fn51()
	end

	if v19.IsLoading and not __wf_atom_7e8ad928(v19.Loader) and v19.Loader:__wf_atom_86399a47() then
		v19.IsLoading = false
		local currentInvigoration = ""

		for i = 1, #v19.Upgrades do
			local v35 = Resource(v19.Upgrades[i])
			local __wf_atom_70b880cb = v35:__wf_atom_70b880cb("")

			if __wf_atom_70b880cb.affixes == nil then
				currentInvigoration ..= "\r\n" .. mMovie:__wf_atom_8e9ac384(tostring(v35:__wf_atom_3a3d2e39()), false)
			else
				for j = 1, #__wf_atom_70b880cb.affixes do
					currentInvigoration ..= module.Ternary(currentInvigoration == "", "", "\r\n") .. __wf_atom_70b880cb.affixes[j]
				end
			end
		end

		_T.CurrentInvigoration = currentInvigoration
	end

	if v16.IsLoading and not __wf_atom_7e8ad928(v16.Loader) and v16.Loader:__wf_atom_86399a47() then
		v16.IsLoading = false
		fn53()
	end

	if
		not __wf_atom_7e8ad928(_T.HelminthSuitLoader)
		and not __wf_atom_7e8ad928(_T.HelminthSuitLoader.Loader)
		and _T.HelminthSuitLoader.Loader:__wf_atom_86399a47()
	then
		fn58()
	end

	if
		v18.IsLoading
		and not __wf_atom_7e8ad928(gRegion)
		and not __wf_atom_7e8ad928(v18.Loader)
		and v18.Loader:__wf_atom_86399a47()
	then
		v18.IsLoading = false
		gRegion:CreateEntity(
			Type(radioLegionVendorScreenLauncher:__wf_atom_5b41f63b()),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	if _T.QueueFishTankPopulation then
		fn52()
	end

	local v34 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v34)

	if not __wf_atom_7e8ad928(mTimerMgr) then
		mTimerMgr:Update(v34)
	end

	if mQuestsNeedChecking and _T.ActiveQuestLoaded then
		local _, v35 = module2.UpdateQuests(nil)
		mQuestsNeedChecking = not v35
	end

	if not __wf_atom_7e8ad928(_T.DojoMgr) then
		_T.DojoMgr:Update()
	end

	if v30 and not (__wf_atom_7e8ad928(__wf_atom_a0f6588f) or __wf_atom_7e8ad928(gGameData)) then
		gGameData:__wf_atom_17f60980(0, "OnTrainingResultUploaded")
		v30 = false
	end

	if mCurrentMode == nil then
		if __wf_atom_7e8ad928(gGameRules) then
			return
		end

		if not __wf_atom_7e8ad928((gRegion:__wf_atom_eab484a7())) then
			mCurrentMode = module2.GetUIMode()

			if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP or mCurrentMode == module2.UI_MODE_IN_SPACE_HUB then
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if
					__wf_atom_a0f6588f:__wf_atom_f89aa44a()
					and not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
					and __wf_atom_18a5d83b:__wf_atom_6c7eca06()
				then
					print("return to ship: initial sync")
					_T.syncingInventory = true
					local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
					__wf_atom_9be88b01:SyncInventoryFromDB("OnInitialInventorySync", true)
					__wf_atom_9be88b01:__wf_atom_6646ca4d("OnInboxSync")
					v5.mForceRefreshWorldStatePostLogin = true
				end
			end

			if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP then
				fn23()
			end

			mFadeInStarted = true
			mMovie:__wf_atom_0cf0fdbe(0)
			fn26()

			if module2.IsInGamePlay() then
				fn27()
			end
		end
	end

	if mAdditionalScreenCreated == false and not module2.IsInGamePlay() and _T.gShowingLoginScreen == false then
		fn27()
	end

	local v35 = mCurrentMode == module2.UI_MODE_IN_GAME
	local gGameData2 = nil

	if v35 then
		gGameData2 = gGameData
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:__wf_atom_6c7eca06() then
			gGameData2 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		end
	end

	fn36(v34, gGameData2, v35)

	if v35 then
		if _T.InSimulacrum then
			fn46()

			if not __wf_atom_7e8ad928(gGameData2) then
				fn6(
					gGameData2:__wf_atom_7050e489(),
					gGameData2:__wf_atom_330e9cb9(),
					gGameData2:__wf_atom_f9580127(),
					gGameData2:__wf_atom_edca9dbf(),
					gGameData2:__wf_atom_d5bed0b3()
				)
			end
		end
	else
		if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP or module2.IsInHub() then
			fn46()
			fn54()
			fn45()

			if
				not gMatchingService:IsBlockingTaskPending()
				and v10
				and not __wf_atom_7e8ad928(_G.UIMovie_EndOfQuestMovie)
				and v7 == nil
				and fn35(true)
			then
				module4.OmegaLimitCheck()
				v10 = false
			end

			fn63()
		end

		if
			mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP
			and _T.uiConsoleTriggersInitialized
			and not (__wf_atom_7e8ad928(_G.JunctionComplete) or _G.JunctionComplete.transitioning or __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) or _T.IsInScreenStack("MissionStats") or _T.missionStatsPending or __wf_atom_8e4fda44:__wf_atom_6b69b901(loadingScreenMovie))
		then
			_T.triggeredConsoleTag = "SolarMapOrigin"
			local entity = module.GetEntityFromTag("ConsoleTeleportAndActivate")

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_f0368285()
			end

			_G.JunctionComplete.transitioning = true
		end

		fn43()
		fn44()

		if not __wf_atom_7e8ad928(gGameData2) then
			fn6(
				gGameData2:__wf_atom_7050e489(),
				gGameData2:__wf_atom_330e9cb9(),
				gGameData2:__wf_atom_f9580127(),
				gGameData2:__wf_atom_edca9dbf(),
				gGameData2:__wf_atom_d5bed0b3()
			)
		end

		if flag then
			flag = false
			local v36 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_NewBuildAvailable", false) .. "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/MainMenu_NewBuildAvailableKicked",
				false
			)
			fn30()
			module.ShowMessage(v36)

			if not Engine.__wf_atom_fc67ba71() then
				__wf_atom_8e4fda44:__wf_atom_bcb70491(Resource("/EE/Editor/ToolMenus/Commands/CmdRelaunch"))
			end
		end

		if __wf_atom_7e8ad928(gGameData2) or not (mRefreshHighPriorityMessages <= 0) then
			mRefreshHighPriorityMessages -= __wf_atom_084b3e93()
		else
			local __wf_atom_153e689d = gGameData2:__wf_atom_153e689d()

			if __wf_atom_153e689d > 0 and _T.gLastHighPriorityMessageCount ~= __wf_atom_153e689d then
				_T.gQueueMailbox = true
				_T.gLastHighPriorityMessageCount = __wf_atom_153e689d
			end

			mRefreshHighPriorityMessages = mHighPriorityMessageDelay
		end
	end

	if _T.PendingMissionReqErrorDialog then
		_T.PendingMissionReqErrorDialog()
		_T.PendingMissionReqErrorDialog = nil
	end

	if _T.Jukebox ~= nil then
		module9.UpdateJukeBox()
	end

	if v12.DelayTime > 0 then
		v12.DelayTime -= __wf_atom_fa1258d0()
	end

	if
		not __wf_atom_7e8ad928(v12.Loader)
		and v12.Loader:__wf_atom_86399a47()
		and not __wf_atom_7e8ad928(v12.QueuedTransmission)
	then
		if v12.IsLoading then
			v12.IsLoading = false
			v12.QueuedTransmission = Resource(v12.QueuedTransmission)
			v12.DelayTime = v12.QueuedTransmission:__wf_atom_90737e8c()
		end

		if v12.DelayTime <= 0 then
			v12.QueuedTransmission = Resource(v12.QueuedTransmission)
			local text, v36 = module5:GetText(v12.QueuedTransmission)

			if __wf_atom_7e8ad928(_T.LypSyncDeco) then
				v12.SoundInst = module.PlaySound(v12.QueuedTransmission:__wf_atom_00e6ce32(v36))
			else
				v12.SoundInst = _T.LypSyncDeco:PlaySound(v12.QueuedTransmission:__wf_atom_00e6ce32(v36), false)
			end

			if not __wf_atom_7e8ad928(v12.SoundInst) then
				gRegion:__wf_atom_1e97b9b5(v12.SoundInst, text, true)
			end

			v12.Loader = nil
			v12.QueuedTransmission = nil
		end
	end

	if v12.Playing and __wf_atom_7e8ad928(v12.SoundInst) then
		v12.Playing = false

		if next(v12.Callbacks) ~= nil and v12.Callbacks[1] ~= 0 then
			v12.Callbacks[1]()
		end

		table.remove(v12.Callbacks, 1)
	end

	if __wf_atom_7e8ad928(v12.SoundInst) then
		if not v12.IsLoading and v12.DelayTime <= 0 and next(v12.WaitingTransmissions) ~= nil then
			v12.QueuedTransmission = table.remove(v12.WaitingTransmissions, 1)
			v12.Loader = UISys.__wf_atom_c0dbe47c({ v12.QueuedTransmission:__wf_atom_5b41f63b() })
			v12.IsLoading = true
		end
	else
		v12.Playing = true

		if not __wf_atom_7e8ad928(v12.SoundInst) then
			module5:UpdateRegion(v12.SoundInst, gRegion, true, _T.LypSyncDeco, false)
		end
	end

	if not v12.IsLoading and v12.DelayTime <= 0 and __wf_atom_7e8ad928(v12.SoundInst) then
		_T.LypSyncDeco = nil
	end

	if v13.Avatar ~= nil then
		v13.Avatar:__wf_atom_6868003b(v13.TargetPos)
	end

	if not __wf_atom_7e8ad928(gGameRules) and v25 ~= nil then
		local v36 = v25
		v25 = nil
		fn61(v36)
	end

	if not __wf_atom_7e8ad928(gRegion) and v3.Timer >= 0 then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			v3.Timer += __wf_atom_084b3e93()

			if v3.Timer <= v3.InTime then
				__wf_atom_8ad59546:__wf_atom_47f0b80b(v3.Timer / v3.InTime * v3.FinalVal)
			elseif v3.Timer <= v3.InTime + v3.OutTime then
				if v3.FullCallback ~= nil then
					v3.FullCallback()
					v3.FullCallback = nil
				end

				__wf_atom_8ad59546:__wf_atom_47f0b80b((1 - (v3.Timer - v3.InTime) / v3.OutTime) * v3.FinalVal)
			else
				v3.Timer = -1
				__wf_atom_8ad59546:__wf_atom_47f0b80b(0)
			end
		end
	end

	if not (__wf_atom_7e8ad928(gRegion) or _T.QuestStartCinPlaying) then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			local __wf_atom_89894bd1 = __wf_atom_8ad59546:__wf_atom_89894bd1()

			if v4 == nil or v4 ~= __wf_atom_89894bd1 then
				v4 = __wf_atom_89894bd1
				__wf_atom_8e4fda44:__wf_atom_06b56505(1 - __wf_atom_89894bd1 * __wf_atom_89894bd1)
			end
		end
	end

	if _T.DelayedCall ~= nil then
		_T.DelayedCall()
		_T.DelayedCall = nil
	end

	if not __wf_atom_7e8ad928(_T.ActionFigureLoadOutLoader) then
		_T.ActionFigureLoadOutLoader:Update()
	end

	if
		_T.FavouriteLoadoutLoader
		and not __wf_atom_7e8ad928(_T.FavouriteLoadoutLoader.Loader)
		and _T.FavouriteLoadoutLoader.Loader:__wf_atom_86399a47()
		and not __wf_atom_7e8ad928(_T.FavWarframeAvatar)
	then
		_T.FavWarframeAvatar:__wf_atom_986f733d(Symbol(), 100)
		_T.FavWarframeAvatar:__wf_atom_e06358f3(Symbol("Statue"))
		local __wf_atom_d2b2176d = _T.FavWarframeAvatar:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:BuildLoadOut(_T.FavouriteLoadoutLoader.Loadout)
		__wf_atom_d2b2176d:__wf_atom_1870de39(true)
		_T.FavouriteLoadoutLoader = nil
	end

	if v21 and _T.SquadOverlay then
		fn(v21)
		v21 = nil
	end

	fn60()

	if _T.PendingScenarioHubName then
		if not _T.ScenarioHubStarted then
			print("Connecting to scenario hub " .. _T.PendingScenarioHubName)
			_T.ScenarioHubStarted = true
			gGameRules:__wf_atom_efb96bf3(Symbol(_T.PendingScenarioHubName))
		end

		_T.PendingScenarioHubName = nil
	elseif _T.PendingScenarioHubShutdown then
		_T.PendingScenarioHubShutdown = nil
		gGameRules:__wf_atom_94b3a9e1(true)
	end

	if not __wf_atom_7e8ad928(gClient) then
		gMatchingService:__wf_atom_8dfa8dd5(gClient:__wf_atom_328bcb8f() and not __wf_atom_7e8ad928(gGameRules) and (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_e714d8ac)))
	end

	if mPlatinumCooldown > 0 then
		mPlatinumCooldown -= v34

		if mPlatinumCooldown <= 0 then
			mPlatinumCooldown = 0
		end
	end

	if _T.PendingChallengeUpload and not __wf_atom_7e8ad928(gGameData2) then
		gGameData2:UploadChallengeProgress()
		_T.PendingChallengeUpload = false
	end
end

local function fn66(p) -- 1 equivalent call inferred from this helper
	for i = 1, #screenStack do
		if p == screenStack[i] then
			return true
		end
	end

	return false
end

local function fn67(p)
	print("Background::ForceIntoStack()")
	fn25(p) -- inferred equivalent call
end

local function fn68(p) -- 4 equivalent calls inferred from this helper
	table.remove(screenStack, p)
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ScreenStackUpdated", (tostring(#screenStack)))
end

local function fn69(p)
	print("Background::ForceOutOfStack()")

	for i = #screenStack, 1, -1 do
		if screenStack[i] ~= p then
			continue
		end

		fn68(i) -- inferred equivalent call
		break
	end
end

function ForceClearChildMovie()
	print("Background::ForceClearChildMovie()")
	mChildMovie = nil
end

local function fn70() -- 2 equivalent calls inferred from this helper
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ScreenStackUpdated", (tostring(#screenStack)))
end

local function fn71(p, object, p2)
	print("Background::" .. "OpenScreen(screenName=" .. tostring(p) .. ", openFromMovie=" .. tostring(object) .. "ignoreIfOpen=" .. tostring(p2) .. ")")

	if movies[p] == nil then
		print("ERROR: Tried to open unrecognized screen [" .. tostring(p) .. "] Check your spelling.")
		assert(false)
	else
		if fn32(p) then -- inferred equivalent call
			if p2 then
				return
			end

			local movie = __wf_atom_8e4fda44:FindMovie(movies[p])

			if not __wf_atom_7e8ad928(movie) then
				movie:Close()
			end
		end

		local v34 = nil

		if __wf_atom_7e8ad928(object) then
			if __wf_atom_7e8ad928(mChildMovie) then
				if not __wf_atom_7e8ad928(mMovie) then
					v34 = mMovie:PushChildMovie(movies[p])
				end
			else
				v34 = mChildMovie:PushChildMovie(movies[p])
			end
		else
			v34 = object:PushChildMovie(movies[p])
		end

		fn70() -- inferred equivalent call
		return v34
	end
end

function TerminateQuickMatch()
	if not mAbortingQuickMatch and gClient:__wf_atom_328bcb8f() then
		mAbortingQuickMatch = true
		fn3(1)
	end
end

local function fn72(p)
	if fn66(p) then -- inferred equivalent call
		fn68(module.FindInTable(screenStack, p)) -- inferred equivalent call
	end

	local movie = __wf_atom_8e4fda44:FindMovie(movies[p])

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("TransitionOut", "")
	end
end

local function fn73(p) -- 2 equivalent calls inferred from this helper
	return p == "Lobby"
end

local function fn74(screen, callback)
	if module2.IsInGamePlay() and not (module2.IsInHub() or _T.InSimulacrum) then
		if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(movies[screen]))) then
			__wf_atom_8e4fda44:__wf_atom_8b74c30b(movies[screen])
		end
	else
		if gMatchingService:IsBlockingTaskPending() then
			for i = 1, #screenStack do
				if not fn73(screenStack[i]) then -- inferred equivalent call
					continue
				end

				if mQueuedGoToScreen ~= nil then
					return
				end

				mQueuedGoToScreen = { screen = screen, callback = callback }

				if not mAbortingQuickMatch then
					mUnblockWhenAsyncDone = true
					fn3(1)
				end

				return
			end
		end

		if screenStack[#screenStack] == screen then
			return
		end

		print("Background::" .. "GoToScreen(screenName=" .. tostring(screen) .. ")")
		local _mMovie = mMovie

		if not __wf_atom_7e8ad928(mChildMovie) then
			local _mChildMovie = mChildMovie
		end

		if __wf_atom_7e8ad928(movies[screen]) then
			print("ERROR: Tried to open unrecognized screen [" .. tostring(screen) .. "] Check your spelling.")
			assert(false)
		else
			if fn32(screen) then -- inferred equivalent call
				local movie = __wf_atom_8e4fda44:FindMovie(movies[screen])

				if not __wf_atom_7e8ad928(movie) then
					movie:Close()
				end

				fn68(module.FindInTable(screenStack, screen)) -- inferred equivalent call
			end

			if not __wf_atom_7e8ad928(mChildMovie) then
				if screen == "Menu" then
					mChildMovie = nil
				else
					mChildMovie:Execute("TransitionOut", "")
				end
			end

			fn25(screen) -- inferred equivalent call
			queuedMovie = screen
			queuedMovieCallback = callback
		end
	end
end

local function fn75(p)
	if screenStack[#screenStack] == p then
		return
	end

	print("Background::" .. "ScreenOpened(screenName=" .. tostring(p) .. ")")

	if __wf_atom_7e8ad928(movies[p]) then
		print("ERROR: Tried to open unrecognized screen [" .. tostring(p) .. "] Check your spelling.")
		assert(false)
	else
		local movie = __wf_atom_8e4fda44:FindMovie(movies[p])

		if __wf_atom_7e8ad928(movie) then
			print("ERROR: Screen opened called on [" .. tostring(p) .. "], said screen doesn't exist.")
			assert(false)
		else
			if not __wf_atom_7e8ad928(mChildMovie) then
				if p == "Menu" then
					mChildMovie = nil
				else
					mChildMovie:Execute("TransitionOut", "")
				end
			end

			mChildMovie = movie
			fn25(p) -- inferred equivalent call
		end
	end
end

local function fn76(p)
	return movies[p]
end

local function fn77()
	screenStack = { "Default" }
	fn70() -- inferred equivalent call
end

local function fn78() -- 1 equivalent call inferred from this helper
	local v34 = screenStack[#screenStack]
	local v35 = movies[v34]
	local v36

	if not __wf_atom_7e8ad928(v35) then
		v36 = __wf_atom_8e4fda44:FindMovie(v35)
	end

	return v36, v34
end

local function fn79(p, value)
	local v34 = value or ""

	if not p then
		for i = #screenStack, 1, -1 do
			local movie = __wf_atom_8e4fda44:FindMovie(movies[screenStack[i]])

			if movie ~= nil and screenStack[i] ~= "Default" and screenStack[i] ~= "MainMenu" then
				movie:Execute("TransitionOut", v34)
			end
		end
	end

	queuedMovie = "Default"
	screenStack = { "Default" }
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ScreenStackUpdated", 1)
end

function ClearToMainMenu(p, p2)
	fn79(p, p2)
end

local function fn80(p) -- 1 equivalent call inferred from this helper
	local v34, _ = fn78() -- inferred equivalent call

	if not __wf_atom_7e8ad928(v34) and v34:Execute("HandleCanBeClosed", p) == true then
		return
	end

	_T[p](true)
end

local function fn81(screen, callback)
	function _T.CanScreenBeClosedCallback(p)
		if p then
			fn79(true)
			fn74(screen, callback)
		end

		_T.CanScreenBeClosedCallback = nil
	end

	fn80("CanScreenBeClosedCallback") -- inferred equivalent call
end

local function fn82(skip, p)
	if gMatchingService:IsBlockingTaskPending() and fn73(screenStack[#screenStack]) then -- inferred equivalent call
		if mQueuedGoToPreviousScreen == nil then
			mQueuedGoToPreviousScreen = { skip = skip }

			if not mAbortingQuickMatch then
				mUnblockWhenAsyncDone = true
				fn3(1)
			end
		end
	else
		print("Background::" .. "GoToPreviousScreen(skipScreens=" .. tostring(skip) .. ")")
		local v34 = tonumber(__wf_atom_7e8ad928(skip) and 1 or skip)
		local v35 = v34 < 1 and 1 or v34

		if __wf_atom_7e8ad928(p) then
			p = false
		end

		if not p and #screenStack <= v35 then
			print("ERROR: There's not " .. tostring(v35) .. " screens to back up over!")
			return
		end

		for _ = 1, v35 do
			if not (#screenStack > 0) then
				continue
			end

			mPreviousScreen = screenStack[#screenStack]
			fn68(#screenStack) -- inferred equivalent call
		end

		queuedMovie = screenStack[#screenStack]

		if not __wf_atom_7e8ad928(mChildMovie) then
			mChildMovie:Execute("TransitionOut", "")
		end
	end
end

local function fn83()
	local notifications = {
		TASK = 1,
		MAIL = 2,
		FOUNDRY = 3,
		MARKET = 4,
		INC_FRIENDS = 5,
		UMBRA_ECHO = 6,
		INVIGORATION = 7,
		DOUBLE_CREDIT = 8,
		DOUBLE_AFFINITY = 9,
		DOUBLE_PICKUP = 10,
		mElements = {},
		GetStatus = function(p, p2)
			if p2 ~= nil then
				for i = 1, #p.mElements do
					if p.mElements[i].Id == p2 then
						return p.mElements[i].Value
					end
				end
			end

			return 0
		end,
		GetCurrentNotifications = function(p)
			return p.mElements
		end
	}
	notifications.mElements[1] = { Id = notifications.TASK, Value = nil }
	notifications.mElements[2] = { Id = notifications.MAIL, Value = 0 }
	notifications.mElements[3] = { Id = notifications.FOUNDRY, Value = 0 }
	notifications.mElements[4] = { Id = notifications.MARKET, Value = nil }
	notifications.mElements[5] = { Id = notifications.INC_FRIENDS, Value = 0 }
	notifications.mElements[6] = { Id = notifications.UMBRA_ECHO, Value = nil }
	notifications.mElements[7] = { Id = notifications.INVIGORATION, Value = nil }
	notifications.mElements[8] = { Id = notifications.DOUBLE_CREDIT, Value = nil }
	notifications.mElements[9] = { Id = notifications.DOUBLE_AFFINITY, Value = nil }
	notifications.mElements[10] = { Id = notifications.DOUBLE_PICKUP, Value = nil }
	_T.Notifications = notifications
end

local function fn84(p)
	if __wf_atom_72884638("Lotus.EnableTraceLogging") then
		print("EnableUIInput(" .. tostring(p) .. "), last state = " .. tostring(_T.UIInputEnabled))
		__wf_atom_6bd2126c()
	end

	if mUIInputEnableTimer ~= nil then
		mTimerMgr:RemoveTimer(mUIInputEnableTimer)
		mUIInputEnableTimer = nil
	end

	_T.UIInputEnabled = true
	_T.HideMoneyOverlay = module.Ternary(p ~= nil, p, false)

	if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP then
		_T.HideMarkers = true
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("EnableInput", "")
end

local function fn85(p)
	if __wf_atom_72884638("Lotus.EnableTraceLogging") then
		print("DisableUIInput(), last state = " .. tostring(_T.UIInputEnabled))
		__wf_atom_6bd2126c()
	end

	_T.UIInputEnabled = false

	if p or mControl.Shutdown then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("DisableInput", "")
	else
		mUIInputEnableTimer = mTimerMgr:AddTimer(0.2, function()
			mUIInputEnableTimer = nil
			__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("DisableInput", "")
		end)
	end

	_T.HideMoneyOverlay = false

	if mCurrentMode == module2.UI_MODE_IN_SPACE_SHIP then
		_T.HideMarkers = false
	end

	if not __wf_atom_7e8ad928(mNotificationsMovie) and mCurrentMode ~= module2.UI_MODE_IN_SPACE_SHIP then
		mNotificationsMovie:Close()
	end
end

function OnFcmKickOut()
	__wf_atom_8e4fda44:__wf_atom_bcb70491(cmdQuit)
end

function OnWeGamePopUp(p)
	local v34 = tonumber(p)

	if v34 == nil then
		if p ~= "" then
			local decoded = cjson.decode(p)
			local locString = decoded.title .. "\r\n\r\n" .. decoded.desc
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 0
			dialogSettings.locString = locString
			dialogSettings.firstString = decoded.confirm_button
			gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
		end
	else
		print("Showing WeGame popup due to status " .. v34)

		if v34 == 40 then
			module.ShowMessage("/Lotus/Language/Changyou/WeGameAntiAddictionKick", "OnFcmKickOut")
		else
			module.ShowMessage("/Lotus/Language/Changyou/WeGamePlatformOffline", "OnFcmKickOut")
		end
	end
end

local function fn86()
	if v20.movie then
		v20.timeOpen += v20.timeToCheckDelay
	end

	if Engine.__wf_atom_4792e425() then
		if not v20.movie then
			v20.movie = __wf_atom_8e4fda44:__wf_atom_8b74c30b(connectionErrorMovie)
			v20.timeOpen = 0
			gMatchingService:__wf_atom_61e78546()
		end
	elseif v20.movie and v20.timeOpen >= v20.minimumDisplayTime then
		v20.movie:Close()
		v20.movie = nil
	end

	if not __wf_atom_7e8ad928(v20.timerId) then
		mTimerMgr:RemoveTimer(v20.timerId)
	end

	v20.timerId = mTimerMgr:AddTimer(v20.timeToCheckDelay, fn86)
end

function ToggleForcedColorCorrection()
	module7.ToggleForcedColorCorrection()
end

function Initialize()
	gRegion:CreateEntity(closestShrineMarker, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:SetVisible(false)
		mMovie:__wf_atom_50d60589("RobotoRegular17", 36, "Filler text")
		mMovie:__wf_atom_50d60589("RobotoBold17", 36, "Filler text")
		fn65()
		module2.LocalizePolarities()
	end

	if _G.CachedGoalInfo == nil then
		_G.CachedGoalInfo = {}
		_G.MergedGoalNodes = {}
	end

	function _T.gOpenWeaponRecoveryMission()
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_5012f0c8()
		local levelArgs = Engine.OpenLevelArgs()
		local recoveryMissionInfo = module2.GetRecoveryMissionInfo()
		levelArgs:__wf_atom_98718663((recoveryMissionInfo:__wf_atom_cf762a4f()))
		module3.AddMissionContextObjects(levelArgs, recoveryMissionInfo)
		levelArgs.level = weaponRecoveryProcLevel
		Engine.OpenLevel(levelArgs)
	end

	if Engine.__wf_atom_578fc9dd() then
		Engine.__wf_atom_035f8a07("OnWeGamePopUp")
	end

	local module16 = require("Lotus.Interface.Libs.TimerMgr")
	mTimerMgr = module16.CreateTimerMgr()

	function _T.AddToBackgroundTimer(p, p2)
		mTimerMgr:AddTimer(p, p2)
	end

	if not __wf_atom_7e8ad928(commonResourcesMovie) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(commonResourcesMovie)
	end

	v8 = {
		missionStatsMovie,
		dialogMovie,
		inputMovie,
		inputCountMovie,
		inboxMovie,
		dailyTributeMovie
	}
	movies.Default = mainMenuMovie
	movies.MainMenu = mainMenuMovie
	movies.LoadOut = loadoutMovieNew
	movies.LoadOutCrewShip = loadoutCrewShipMovie
	movies.Inventory = inventoryMovie
	movies.StyleManager = styleManagerMovie
	movies.Profile = profileMovie
	movies.Leaderboards = leaderBoardsMovie
	movies.MissionStats = missionStatsMovie
	movies.Settings = settingsMovie
	movies.Bindings = bindingsMovie
	movies.Store = storeMovie
	movies.Lobby = lobbyMovie
	movies.LobbyPVP = lobbyPVPMovie
	movies.ColorPicker = colorPickerMovie
	movies.Intel = intelMovie
	movies.UpgradeCards = diegeticUpgradeCardsMovie
	movies.MemberRole = memberRoleMovie
	movies.Menu = topMenuMovie
	movies.Inbox = inboxMovie
	movies.ItemBrowsing = _G.UIMovie_ItemBrowsingMovie
	movies.AllianceView = allianceViewMovie
	movies.Clan = clanMovie
	movies.ClanSearch = clanSearchMovie
	movies.Friends = friendsMovie
	movies.SquadOverlay = squadOverlayMovie
	movies.InvitePanel = invitePanelMovie
	movies.Spectres = spectresMovie
	movies.DiegeticArtifactCards = diegeticArtifactCardsMovie
	movies.AbilityProgression = abilityProgressionMovie
	movies.GiftUnwrap = giftUnwrapMovie
	movies.InvasionSelection = invasionSelectionMovie
	movies.CustomizeTenno = customizeTennoMovie
	movies.DetailedPurchaseDialog = _G.UIMovie_DetailedPurchaseDialog
	movies.DarvoDeal = darvoDealMovie
	movies.GenericSettings = genericSettingsMovie
	movies.GenericMenu = genericMenuMovie
	movies.BeaconAccept = beaconAcceptMovie
	movies.Intrinsics = intrinsicsMovie
	movies.KeyboardRendereriOS = keyboardRendereriOSMovie
	movies.ClanAdvertisement = clanAdvertisementMovie
	movies.LotusLoadOut = lotusLoadOutMovie
	movies.Challenges = challengesMovie

	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:__wf_atom_7df746cd(0)
		mMovie:__wf_atom_0cf0fdbe(0)
		__wf_atom_8e4fda44:__wf_atom_857e423c(true)
	end

	mFadeInStarted = false

	if not __wf_atom_7e8ad928(mChildMovie) then
		mChildMovie:Close()
	end

	_T.BackgroundMovie = mMovie
	_T.InSimulacrum = not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_2564b701)
	_T.InDojo = not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_1316e0c2)

	function _T.DoPurchase(p, p2)
		mPurchaseParams = p
		v = p2
		mMovie:Execute("BuyItem", "")
	end

	function _T.BuyItem(p, p2, p3, p4)
		local purchaseParams = SF.PurchaseParams()
		purchaseParams.mSource = module2.GetCurrentPurchaseSource()
		purchaseParams.mStoreItem = Resource(p)
		purchaseParams.mQuantity = module.Ternary(p3, p3, 1)
		purchaseParams.mSkipConfirm = p4 == true

		if purchaseParams.mSource == 0 and not __wf_atom_7e8ad928(_T.CurrentStorePage) then
			purchaseParams.mStorePage = _T.CurrentStorePage
		end

		if not __wf_atom_7e8ad928(_T.CurrentSearchTerm) then
			purchaseParams.mSearchTerm = _T.CurrentSearchTerm
		end

		_T.DoPurchase(purchaseParams, p2)
	end

	_T.GetPurchasePrice = _GetPurchasePrice
	_T.GetPriceStrings = GetPriceStrings
	fn83()
	mCurrentMode = nil
	mControl.Initialized = true
	Engine.__wf_atom_31027aa7("HttpRequestFailureCallback")
	Engine.__wf_atom_bc1eece9("HttpRequestAuthFailureCallback")
	fn86()
	_T.OpenScreen = fn71
	_T.GoToScreen = fn74
	_T.ChangeScreen = fn81
	_T.GoToPreviousScreen = fn82
	_T.CloseScreen = fn72
	_T.IsInScreenStack = fn66
	_T.IsScreenOpen = fn32
	_T.GetTopScreen = fn78
	_T.ScreenOpened = fn75
	_T.GetScreenRes = fn76
	_T.ForceIntoStack = fn67
	_T.ForceOutOfStack = fn69
	_T.ForceClearScreenStack = fn77
	_T.EnableUIInput = fn84
	_T.DisableUIInput = fn85
	_T.CachedTennoAvatar = TennoAvatar
	_T.CompareInfoPopup = fn24

	function _T.PlayBackgroundTransmission(p, p2, p3, p4)
		return (fn40(p, p2, p3, p4))
	end

	function _T.SetAvatarLookAt(avatar, targetPos)
		return fn41(avatar, targetPos)
	end

	__wf_atom_a0f6588f:__wf_atom_6705ecf6("OnUserChangedCallback")
	gMatchingService:__wf_atom_fbf1f6e3("OnLoadHubMessage")
	gMatchingService:__wf_atom_7c793ea2("OnLoadOrbiterMessage")

	if not __wf_atom_7e8ad928(gClient) then
		local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

		if not __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
			print("UISTYLE: Style changed callback registered")
			__wf_atom_3cb140dc:__wf_atom_117b0e8b("StyleChangedCallback")
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			local activeQuest = __wf_atom_9be88b01:GetInventory():GetActiveQuest()

			if __wf_atom_7e8ad928(activeQuest) then
				_T.ActiveQuestLoaded = true
			else
				while __wf_atom_7e8ad928(gGameRules) do
					Sleep(0)
				end

				gGameRules:RequestResource(activeQuest:__wf_atom_5b41f63b(), "ActiveQuestLoaded")
			end

			local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

			if not __wf_atom_c67f9605:__wf_atom_172c2f5c(__wf_atom_22941262) then
				fn38()

				if __wf_atom_7e8ad928(gClient) then
					fn39(false)
					v5.mForceRefreshWorldStatePostLogin = false
				end
			end
		end
	end

	module9.Reset()
	_T.ShowDioramaLevel = fn42
	_T.BackgroundInitialized = true
	print("Background.lua: Initialize")
end

function Logoff()
	module.ShowConfirmMessage("/Lotus/Language/Menu/MainMenu_LogoffConfirm", "ConfirmLogoff")
end

function DebugSwitchProfile()
	gRegion:__wf_atom_031728c7()
	_T.BackgroundMovie:__wf_atom_f62a8704("ConfirmLogoff", { 4 })
end

function ConfirmLogoff(p)
	if tonumber(p) == 4 then
		if gMatchingService:IsBlockingTaskPending() then
			print("ConfirmLogoff - IsBlockingTaskPending, waiting")

			if not mAbortingQuickMatch then
				mUnblockWhenAsyncDone = true
				fn3(1)
			end

			mQueuedLogoff = true
		else
			print("Background.lua - ConfirmLogoff -> _FadeInOut -> _DoLogoff")
			v3.Timer = 0
			v3.InTime = tonumber(0.0001)
			v3.OutTime = tonumber(20)
			v3.FinalVal = tonumber(1)
			v3.FullCallback = fn30
		end
	end
end

local function fn87(p, p2, ...)
	local v34 = movies[p]

	if __wf_atom_7e8ad928(v34) then
		return false
	end

	local movie = __wf_atom_8e4fda44:FindMovie(v34)

	if __wf_atom_7e8ad928(movie) then
		return false
	end

	local v35 = ""

	for _, v36 in ipairs({ ... }) do
		v35 ..= "," .. v36
	end

	return (movie:Execute(p2, v35))
end

function CallMethodOnScreen(p, p2, ...)
	return (fn87(p, p2, ...))
end

function CallMethodOnScreenString(p, p2, p3)
	local v34 = movies[p]

	if not __wf_atom_7e8ad928(v34) then
		local movie = __wf_atom_8e4fda44:FindMovie(v34)

		if not __wf_atom_7e8ad928(movie) then
			return (movie:Execute(p2, p3))
		end
	end

	return false
end

function CallMethodOnTopScreen(p, ...)
	return (fn87(screenStack[#screenStack], p, ...))
end

function RefreshLoadout()
	local movie = __wf_atom_8e4fda44:FindMovie(loadoutMovieNew)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("UpdatePurchases", "")
	end

	local movie2 = __wf_atom_8e4fda44:FindMovie(notificationsMovie)

	if not __wf_atom_7e8ad928(movie2) then
		movie2:Execute("RefreshBoosters", "")
	end
end

function CloseLoadout()
	local movie = __wf_atom_8e4fda44:FindMovie(loadoutMovieNew)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end
end

local function fn88()
	_T.boosterPackCards = {}

	for _ = 1, v14.mNumberOfCardsInPack do
		table.insert(_T.boosterPackCards, v14.mBoosterPackResults[1])
		table.remove(v14.mBoosterPackResults, 1)
	end

	v14.mNumberOfPacksToProcess -= 1
	_T.queuedBoosterPacks = module.Ternary(v14.mNumberOfPacksToProcess == 0, nil, v14.mNumberOfPacksToProcess)
	local v34 = mMovie:PushChildMovie(boosterPackMovie)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_GetRandomItem", false, {
		randomItem = v14.mBoosterPackItemString
	})
	module.PlaySound(_G.UISound_Purchase)
	v34:__wf_atom_f62a8704("SetText", { __wf_atom_8e9ac384 })

	if v14.mNumberOfPacksToProcess < 1 then
		v34:Execute("SetCallback", "ConfirmPopup")
	else
		v34:Execute("SetCallback", "ProcessBoosterPacks")
	end

	if v14.mTotalPacksToProcess > 1 then
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Pack_Display_Count", false)
		v34:Execute("SetCaption", (string.format(__wf_atom_8e9ac384_2, v14.mCurrentPack, v14.mTotalPacksToProcess)))
	end

	v34:Execute("SetNumOptions", 1)
	v14.mCurrentPack += 1
end

function ProcessBoosterPacks()
	fn88()
end

local function fn89(inventoryChanges, list, p)
	v14.mBoosterPackResults = {}
	v14.mBoosterPackItemString = ""
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local upgradeInfos = {}

	if #list == 0 then
		if inventoryChanges.MiscItems ~= nil then
			for i = 1, #inventoryChanges.MiscItems do
				if not WeakResource(inventoryChanges.MiscItems[i].ItemType):IsA(shipFeatureItemBaseType) then
					continue
				end

				mBoughtShipFeatureItem = true
			end
		end
	else
		for i = 1, #list do
			local v34 = StringSplit(",", list[i])

			if #v34 == 1 then
				print("Parse failure: " .. p)
				fn15(false)
				fn3(0)
				return
			elseif #v34 >= 2 then
				local v35 = v34[1]
				local v36 = v34[2]
				local v37 = Resource(v35)

				if not __wf_atom_7e8ad928(v37) then
					if v37:GetItem():IsA(__wf_atom_58a409f1) then
						local upgradeInfo = SF.UpgradeInfo()
						upgradeInfo.mItemType = v37:GetItem()
						upgradeInfo.mItemCount = 1
						local v38 = false

						for j = 1, #upgradeInfos do
							if upgradeInfos[j].mItemType ~= upgradeInfo.mItemType then
								continue
							end

							upgradeInfos[j].mItemCount = upgradeInfos[j].mItemCount + 1
							v38 = true
							break
						end

						if not v38 then
							table.insert(upgradeInfos, upgradeInfo)
						end
					end

					table.insert(v14.mBoosterPackResults, { v37, v36 })
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(tostring(v37:__wf_atom_014a76a2()), false)

					if #v14.mBoosterPackResults > 1 then
						v14.mBoosterPackItemString ..= "\\,"
					end

					v14.mBoosterPackItemString ..= __wf_atom_8e9ac384
				end
			end
		end

		for i = 1, #upgradeInfos do
			__wf_atom_9be88b01:__wf_atom_2f4535b3(upgradeInfos[i], true)
		end
	end

	if #v14.mBoosterPackResults > 0 then
		v14.mTotalPacksToProcess = mQuantityToReceive
		v14.mNumberOfCardsInPack = #v14.mBoosterPackResults / v14.mTotalPacksToProcess
		v14.mCurrentPack = 1
		v14.mNumberOfPacksToProcess = v14.mTotalPacksToProcess
		fn88()
	else
		mPurchasePopupMovie = mMovie:PushChildMovie(purchaseCelebrationMovie)
	end

	fn3(0)

	if mBoughtShipFeatureItem then
		module2.UpdateUIConsoleTriggers(false)
		mBoughtShipFeatureItem = false
	end

	fn15(true)

	if inventoryChanges.QuestKeys ~= nil then
		module2.UpdateQuests(true)
	end
end

function OnPurchaseResults(p, p2)
	if p then
		local decoded = cjson.decode(p2)
		local v34 = decoded.BoosterPackItems == nil and {} or StringSplit(";", decoded.BoosterPackItems)
		fn89(decoded.InventoryChanges, v34, p2)
	else
		print("FAILURE: " .. p2)
		fn3(0)
		local v34 = "/Lotus/Language/Menu/PurchaseFailure_UnknownError"
		local v35 = tonumber(p2)

		if v35 == nil then
			v34 = module.IsConnectionErrorMsg(p2) and "/Lotus/Language/Menu/PurchaseFailure_ConnectionError" or v34
		elseif v35 == 6 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_InvalidItem"
		elseif v35 == 5 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_InsufficientSlots"
		elseif v35 == 4 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_InvalidAccount"
		elseif v35 == 3 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_AuthenticationFailed"
		elseif v35 == 2 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_InsufficientXP"
		elseif v35 == 1 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_InsufficientFunds"
		elseif v35 == 13 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_OutOfStock"
		elseif v35 == 15 then
			v34 = "/Lotus/Language/Menu/PurchaseFailure_NewBuild"
		elseif v35 == 21 then
			v34 = "/Lotus/Language/Menu/Store_AlreadyOwned_Switch"
		elseif v35 == 25 then
			v34 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/PurchaseFailSlotLimit", true, {
				MAX = module.FormatNumber(module2.MAX_BIN_SLOTS)
			})
		elseif v35 == 26 then
			local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(mPurchaseParams.mStoreItem:__wf_atom_efa6f447())
			local __wf_atom_dae75ebc = __wf_atom_c67f9605:__wf_atom_dae75ebc(__wf_atom_8c8df26f)
			v34 = not (__wf_atom_dae75ebc > 0) and "/SF/Language/Vendor/PurchaseFailSlotLimitGeneric"
				or mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/PurchaseFailSlotLimit", true, {
					MAX = module.FormatNumber(__wf_atom_dae75ebc)
				})
		end

		local v36 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/PurchaseFailure", true) .. " (" .. mMovie:__wf_atom_8e9ac384(v34, true) .. ")"
		module.ShowMessage(v36, "ConfirmPopup")
		fn15(false)
	end
end

function ConfirmPopup(_)
	fn15(nil)
end

function ConfirmPopupNotEnoughPlatinum(p)
	fn15(nil)
	local mPurchaseOrigin2

	if __wf_atom_21342f4a == nil or mBaseSourceType == nil or mBaseSourceType == "" then
		mPurchaseOrigin2 = mPurchaseOrigin
	else
		mPurchaseOrigin2 = v2[mBaseSourceType + 1]
	end

	local v34 = mPurchaseOrigin2 == nil and "" or mPurchaseOrigin2

	if tonumber(p) == 4 then
		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("INSUFFICIENT_PLAT_POPUP"), v34 .. "_YES")
		end

		if
			Engine.__wf_atom_8dbe8185() and Engine.__wf_atom_eecb6143()
			or Engine.__wf_atom_6f25c160()
			and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_01fbbcf8("steam_market")
		then
			local module16 = require("Lotus.Interface.StoreItemUtilities")
			module16.OpenPremiumCurrencySelection(mMovie)
		elseif __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_01fbbcf8("direct_platinum") then
			fn7()
		else
			fn8(v34)
		end
	elseif not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("INSUFFICIENT_PLAT_POPUP"), v34 .. "_NO")
	end

	mBaseSourceType = ""
end

function ConfirmDurability(p)
	print(p)

	if not (__wf_atom_7e8ad928(_T.UpgradeDurabilityCallback) or __wf_atom_7e8ad928(_T.UpgradeDurabilityCallbackMovie)) then
		_T.UpgradeDurabilityCallbackMovie:Execute(_T.UpgradeDurabilityCallback, (tostring(p)))
		return
	end

	if tonumber(p) == 5 then
		fn15(nil)
		return
	end

	if tonumber(p) == 4 then
		mPurchaseParams.mDurability = 0
	elseif tonumber(p) == 6 then
		mPurchaseParams.mDurability = 1
	else
		mPurchaseParams.mDurability = 2
	end

	local v34, v35, v36 = _GetPurchasePrice(mPurchaseParams)
	mPurchaseTotalPrice = v34
	mPurchaseUnitPrice = v35
	mPurchaseQuantityMultiplier = v36

	if mPurchaseTotalPrice == nil then
		fn15(false)
	else
		fn21()
	end
end

function ConfirmErrorPopup() end

function OpenPrimeTokenPage()
	local module16 = require("Lotus.Interface.StoreItemUtilities")
	module16.OpenPremiumCurrencySelection(mMovie, true)
end

local function fn90(p)
	return p == 27 or p == 28 or p == 29 or p == 42
end

local function fn91(mStoreItem, fn92)
	if mStoreItem:IsPackage() then
		local __wf_atom_72915748 = mStoreItem:__wf_atom_72915748()

		for i = 1, #__wf_atom_72915748 do
			if
				not __wf_atom_7e8ad928(__wf_atom_72915748[i].mTypeName)
				and fn92(__wf_atom_72915748[i].mTypeName:__wf_atom_efa6f447())
			then
				return true
			end
		end

		return false
	elseif mStoreItem:GetItem():IsA(__wf_atom_3cecff09) then
		return (fn92(mStoreItem:__wf_atom_d4d67b38()))
	else
		return (fn92(mStoreItem:__wf_atom_efa6f447()))
	end
end

function ConfirmPurchase(p)
	if tonumber(p) ~= 4 or mPurchaseParams.mStoreItem == nil then
		fn15(nil)
		return
	end

	local __wf_atom_327344dd = mPurchaseParams.mStoreItem:__wf_atom_327344dd()
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

	if mPurchaseParams.mStoreItem:IsPackage() then
		mPurchaseParams.mStoreItem:__wf_atom_5b41f63b()
	else
		mPurchaseParams.mStoreItem:__wf_atom_eca5585c()
	end

	if mPurchaseParams.mSource == 18 or not fn91(mPurchaseParams.mStoreItem, fn90) then
		local movie = __wf_atom_8e4fda44:FindMovie(movies.LoadOut)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("NotifyPurchase", "")
		end

		fn3(2, "/Lotus/Language/Menu/PurchaseInProgress")

		if not __wf_atom_327344dd then
			mPurchaseParams.mDurability = 3 + 1
		end

		__wf_atom_9be88b01:Purchase(mPurchaseParams, "OnPurchaseResults")
	else
		module.ShowMessage("/Lotus/Language/Menu/ArchwingFailurePurchase", "ConfirmErrorPopup")
		fn15(nil)
	end
end

function BuyItem(p)
	local v34 = p == "true"
	mQuantityToReceive = mPurchaseParams.mQuantity

	if mPurchaseParams.mStoreItem:__wf_atom_327344dd() then
		fn22()
		return
	end

	local v35 = fn13(mPurchaseParams)

	if v35 and not v34 then
		local storeItemPriceObject = module2.GetStoreItemPriceObject(mPurchaseParams.mStoreItem, nil, _T.purchasedItems)

		if
			storeItemPriceObject.DiscountTags.Sale
			and storeItemPriceObject.Sale.mBogoBuy > 0
			and storeItemPriceObject.Sale.mBogoGet > 0
		then
			mQuantityToReceive = mPurchaseParams.mQuantity + math.floor(mPurchaseParams.mQuantity / storeItemPriceObject.Sale.mBogoBuy) * storeItemPriceObject.Sale.mBogoGet
		end

		if not __wf_atom_7e8ad928(storeItemPriceObject.Coupon) then
			mPurchaseParams.mCouponId.mId = storeItemPriceObject.Coupon.mId
		end

		mPurchaseParams.mProratePercent = storeItemPriceObject.ProratedPercent / 100

		if storeItemPriceObject.FinalPrice.Premium > 0 and storeItemPriceObject.FinalPrice.Credits > 0 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				tostring(mPurchaseParams.mStoreItem:__wf_atom_014a76a2()),
				false
			)
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Popup_BuyItem", true)
			local locString = string.format(__wf_atom_8e9ac384_2, __wf_atom_8e9ac384)
			local secondString = "<PLATINUM_CREDITS>" .. storeItemPriceObject.FinalPrice.Premium
			local firstString = "<CREDITS>" .. storeItemPriceObject.FinalPrice.Credits
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 5
			dialogSettings.locString = locString
			dialogSettings.firstString = firstString
			dialogSettings.secondString = secondString
			dialogSettings.thirdString = "/Lotus/Language/Menu/ItemSelection_Cancel"
			dialogSettings:SetCallback("ConfirmCurrency")
			module.ShowCustomMessage(dialogSettings)
			_T.PurchaseSuccessLocOverride = nil
			return
		else
			mPurchaseParams.mUsePremium = storeItemPriceObject.UsePremium
		end
	end

	local v36, v37, v38 = _GetPurchasePrice(mPurchaseParams)
	mPurchaseTotalPrice = v36
	mPurchaseUnitPrice = v37
	mPurchaseQuantityMultiplier = v38

	if mPurchaseTotalPrice == nil then
		fn15(nil)
		return
	end

	if v35 then
		local ternary = module.Ternary(mPurchaseParams.mUsePremium, v22.PREMIUM_CREDITS, v22.REGULAR_CREDITS)
		mPurchaseParams.mExpectedPrice = mPurchaseTotalPrice[ternary]
	end

	fn21()
end

function OpenPod()
	if not __wf_atom_7e8ad928(_T.PodState) and (_T.PodState.Status == 0 or __wf_atom_7e8ad928(_T.PodState.Status)) then
		print("open pod")
		_T.PodState.PendingAnimation = podOpenAnimation
		_T.PodState.Status = 2
	end
end

function ClosePod()
	if not __wf_atom_7e8ad928(_T.PodState) and (__wf_atom_7e8ad928(_T.PodState.Status) or _T.PodState.Status > 0) then
		print("close pod")
		_T.PodState.PendingAnimation = podCloseAnimation
		_T.PodState.Status = 0
	end
end

function OnProfileFocused()
	module.PlaySound(beepSound)
end

function ConfirmLobby(p)
	if tonumber(p) == 4 then
		fn79(false, "invite")
		local movie = __wf_atom_8e4fda44:FindMovie(movies.MainMenu)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end

		fn71("MainMenu")
	end
end

function ExitLobby()
	mNeedsToRespawnMenuAvatars = true
end

function RollOver()
	module.PlaySound(_G.UISound_Focus)
end

function onViewportSizeChanged(_, _)
	module.ScaleSlicedMaterials(mMovie, _G.UISliceMaterials)
end

function ActiveQuestLoaded(p, p2)
	if p then
		_T.ActiveQuestLoaded = true

		if _T.Jukebox ~= nil and Resource(p2):__wf_atom_63acbc8d() then
			module9.SetSuppressed(true)
		end
	else
		_T.ActiveQuestLoaded = false
		print("Couldn't load quest: " .. p2)
	end

	print("ActiveQuestLoaded=" .. tostring(_T.ActiveQuestLoaded))
end

function OnAccountNameChangedCallback()
	if connectionFailurePopup == nil and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		connectionFailurePopup = module.ShowMessage("/Lotus/Language/Menu/BackgroundError_UserNameChanged", "DoLogoff")
	end
end

fn4 = function() end

local function fn92()
	local __wf_atom_dcd09d10 = gGameData:__wf_atom_dcd09d10()
	local v34 = nil

	for i = 1, #__wf_atom_dcd09d10 do
		local v35 = __wf_atom_dcd09d10[i]
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v35.date)

		if __wf_atom_db2b0cee <= 0 then
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("SHIPEVENT_" .. v35.tag:c_str()))

			if __wf_atom_2226b35c then
				for _, v36 in ipairs(__wf_atom_2226b35c) do
					if __wf_atom_7e8ad928(v36) or not v36:IsA(__wf_atom_589cefdb) then
						continue
					end

					v36:FirePort("Execute")
				end
			else
				module.ShowMessage((tostring(v35.tag)))
			end

			gGameData:__wf_atom_6764f55b(v35.tag)
		elseif v34 == nil or __wf_atom_db2b0cee < v34 then
			v34 = __wf_atom_db2b0cee
		end
	end

	if v34 ~= nil and v34 > 0 then
		mTimerMgr:AddTimer(v34, fn92, false)
	end
end

local function fn93() -- 1 equivalent call inferred from this helper
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			__wf_atom_9be88b01:__wf_atom_a4f5c41a("OnInventorySyncCallback")
		end
	end
end

function OnLoginDone()
	print("Background::OnLoginDone()")
	_G.LoginDone = true
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		print("Background::OnLoginDone() playerProfile == nil")
		return
	end

	local __wf_atom_e75653c3 = __wf_atom_18a5d83b:__wf_atom_e75653c3()

	if _T.PreviousLoggedInAccountId == nil or _T.PreviousLoggedInAccountId == __wf_atom_e75653c3 then
		v26 = module2.HasCompletedVorsPrize()
		local queueNewWarRecap = _T.QueueNewWarRecap

		if _T.gActiveCameraSpot == "LoginNoSuit" then
			print("Login: No Suit")
			v3.Timer = 0
			v3.InTime = tonumber(0.75)
			v3.OutTime = tonumber(0.75)
			v3.FinalVal = tonumber(1)
			v3.FullCallback = fn29
		elseif _T.HasDailyTribute then
			print("Login: Daily")
			_T.DailyTributeLoginState = 2
			_T.DailyTributeLoginTimerId = mTimerMgr:AddTimer(2, function()
				if not _T.HasDailyTribute and _T.DailyTributeLoginState == 2 then
					_T.DailyTributeLoginState = 1
				elseif _T.DailyTributeLoginState == 1 then
					if __wf_atom_7e8ad928(mMenuSuitAvatar) then
						print("Login: Setup missing avatar")
					else
						_T.DailyTributeLoginState = nil
						mMenuSuitAvatar:__wf_atom_e424c72a(false)
						mTimerMgr:RemoveTimer(_T.DailyTributeLoginTimerId)
						_T.DailyTributeLoginTimerId = nil
						print("Login: Daily Done")
					end

					if _T.QueueNewWarRecap then
						_T.QueueNewWarRecap = nil

						if not __wf_atom_7e8ad928(newWarQuestMovie) then
							__wf_atom_8e4fda44:__wf_atom_8b74c30b(newWarQuestMovie)
						end
					end
				end
			end, true)
			queueNewWarRecap = false
		else
			print("Login: No Daily")
			fn29(0.5)
			mTimerMgr:AddTimer(2, function()
				if not __wf_atom_7e8ad928(mMenuSuitAvatar) then
					mMenuSuitAvatar:__wf_atom_e424c72a(false)
					print("Login: Setup 1 Done")
				end

				print("Login: Setup 2 Done")
			end)
		end

		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnLoginComplete", "")
		mNeedsToRespawnMenuAvatars = false
		fn23()
		__wf_atom_a0f6588f:__wf_atom_cae746bf("OnAccountNameChangedCallback")

		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		gGameData:__wf_atom_35022587("FriendRequestReceived")
		mNewFriendRequests = true
		local activeQuest = gGameData:GetInventory():GetActiveQuest()

		if __wf_atom_7e8ad928(activeQuest) or _T.ActiveQuestLoaded then
			_T.ActiveQuestLoaded = true
			local _, v34 = module2.UpdateQuests(nil)
			mQuestsNeedChecking = not v34
		elseif not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:RequestResource(activeQuest:__wf_atom_5b41f63b(), "ActiveQuestLoaded")
		end

		if v5.mForceRefreshWorldStatePostLogin then
			fn38()
		end

		fn39(v5.mForceRefreshWorldStatePostLogin)
		v5.mForceRefreshWorldStatePostLogin = false
		gGameData:__wf_atom_8ca8ddd7("OnSyncTwitchDrops")
		fn92()
		fn93() -- inferred equivalent call
		mFoundryNotification.Refresh = true
		_T.syncingInventory = false

		if _G.checkAutoLaunchMission ~= false then
			local v34 = __wf_atom_9a2b0be4("LotusGameRules.AutoLaunchMission")

			if v34 ~= "" then
				v21 = v34
				_G.checkAutoLaunchMission = false
				queueNewWarRecap = false
			end
		end

		if queueNewWarRecap then
			_T.QueueNewWarRecap = nil

			if not __wf_atom_7e8ad928(newWarQuestMovie) then
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(newWarQuestMovie)
			end
		end

		if
			module2.HasCompletedNewWar()
			and not (__wf_atom_7e8ad928(__wf_atom_c67f9605) or __wf_atom_7e8ad928(gGameData))
		then
			if gGameData:__wf_atom_247a5d2e(true).mBootLocation == 1 then
				__wf_atom_c67f9605:__wf_atom_d4f03428(WeakResource("/Lotus/Levels/Proc/TheNewWar/PartTwo/TNWDrifterCampMain"))
			else
				__wf_atom_c67f9605:__wf_atom_d4f03428(WeakResource("/Lotus/Levels/Proc/PlayerShip"))
			end
		end
	else
		print("Logging in with a new user, disconnecting")
		Engine.Disconnect(true)
	end
end

function DoLogoff(p)
	print("DoLogoff")
	connectionFailurePopup = nil
	fn30(p == "true")
end

function HttpRequestFailureCallback()
	if
		connectionFailurePopup == nil
		and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
		and not (module2.IsInGamePlay() and __wf_atom_8e4fda44:__wf_atom_6b69b901(missionStatsMovie))
	then
		if Engine.__wf_atom_fc67ba71() then
			__wf_atom_a0f6588f:__wf_atom_02a3b4aa()
		end

		connectionFailurePopup = module.ShowMessage("/Lotus/Language/Menu/BackgroundError_FailedToConnect", "DoLogoff")
	end
end

function HttpRequestAuthFailureCallback(value)
	if
		not Engine.__wf_atom_fc67ba71()
		and connectionFailurePopup == nil
		and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
	then
		local v34 = Engine.__wf_atom_578fc9dd() and string.find(value, "|")

		if v34 then
			local v35 = string.sub(value, v34 + 1)
			local decoded = cjson.decode(v35)

			if decoded ~= nil then
				if decoded.SuspendDate == nil then
					if decoded.ChatBanDate == nil then
						if decoded.KickReason == nil then
							if decoded.WarningReason ~= nil then
								local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(decoded.WarningReason, false)
								module.ShowMessage(__wf_atom_8e9ac384)
								return
							end
						else
							local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Changyou/WeGameKick",
								false,
								{ KICK_REASON = decoded.KickReason }
							)
							connectionFailurePopup = module.ShowMessage(__wf_atom_8e9ac384, "OnFcmKickOut")
							return
						end
					else
						local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Changyou/WeGameChatBan",
							false,
							{
								BAN_TIME = decoded.ChatBanDate,
								BAN_REASON = decoded.ChatBannedReason
							}
						)
						connectionFailurePopup = module.ShowMessage(__wf_atom_8e9ac384, "DoLogoff")
						return
					end
				else
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Launcher/LoginFailedSuspended",
						true
					)
					local v36 = "/Lotus/Language/Launcher/SuspendReason_" .. decoded.SuspendReason
					local suspendReason = mMovie:__wf_atom_8e9ac384(v36, true)

					if suspendReason == v36 then
						suspendReason = decoded.SuspendReason
					end

					local v37 = string.format(__wf_atom_8e9ac384, decoded.SuspendDate, suspendReason)
					connectionFailurePopup = module.ShowMessage(v37, "OnFcmKickOut")
					return
				end
			end
		end

		connectionFailurePopup = module.ShowMessage("/Lotus/Language/Menu/BackgroundError_FailedToConnect", "DoLogoff")
	end
end

function OnUserChangedCallback()
	print("Background.lua: OnUserChangedCallback")
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnUserChangedFunction", "")
	local v34 = not __wf_atom_7e8ad928(gGameRules) and (module2.IsInGamePlay() or gGameRules:IsA(__wf_atom_e714d8ac))
	print("OnUserChangedCallback")
	_G.JunctionComplete = nil

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		if v34 then
			Engine.Disconnect(true)
		else
			connectionFailurePopup = nil
			fn30()
		end
	end
end

function OnConfirmation()
	v24 = false
	local gDialogDeviceID = _T.gDialogDeviceID
	local v34 = __wf_atom_7e8ad928(_T.gDialogDeviceID) and "" or gDialogDeviceID

	if gRegion:__wf_atom_9f7eb1c3() then
		gRegion:__wf_atom_f35eb741(v34, false)
	else
		gRegion:__wf_atom_d3cccaa6(v34)
	end
end

function OnUserGamepadRemoved()
	if not v24 then
		v24 = true
		module.ShowMessage("/Lotus/Language/Menu/ConnectController_XBone", "OnConfirmation")
	end
end

function OnUserGamepadRemovedSwitch()
	if not v24 then
		v24 = true
		module.ShowMessage("/Lotus/Language/Menu/ConnectController_Switch", "OnConfirmation")
	end
end

function OnLoginExpired(_, _)
	if connectionFailurePopup == nil then
		module.ShowMessage("/Lotus/Language/Menu/ConnectionError_LoginExpired", "DoLogoff")
	end
end

function GameInviteReceivedCallback(_) end

function OnOnlinePlayTypeChanged()
	local movie = __wf_atom_8e4fda44:FindMovie(lobbyMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("OnOnlinePlayTypeChanged", "")
	end
end

function SelectMissionDeckRegion(p)
	local movie = __wf_atom_8e4fda44:FindMovie(movies.MissionDeck)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("GlobalSelectRegion", p)
	end
end

function IconCacheFlushed()
	module2.LocalizePolarities()

	if _T.Jukebox ~= nil then
		module9.OnIconCacheFlushed(mMovie)
	end

	_T.IntelIconCacheFlushed = true
end

function UpdateShipDecoCapacity()
	fn47()
end

function OnShipDecosReset(p, p2)
	fn3(0)

	if not p then
		module.ShowMessage("/Lotus/Language/UiElements/ResetShipDecosFail")
		return
	end

	module.ShowMessage("/Lotus/Language/UiElements/ResetShipDecosSuccess")
	fn5(p2)
end

function ResetShipDecos()
	if not __wf_atom_7e8ad928(gGameRules) then
		local shipDecoRoom = module2.GetShipDecoRoom()
		fn3(2)
		gGameRules:__wf_atom_5bce68d8(shipDecoRoom, "OnShipDecosReset")
	end
end

fn5 = function(p)
	if not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97)) then
		return
	end

	if _T.ShipDecos == nil then
		_T.ShipDecos = {}
	end

	if p == nil or p == "" then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local mRooms = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_247a5d2e(gRegion:IsMaster()).mRooms
			local v34 = not (v15.LoaderProgress.RoomLoaderIndex <= #mRooms) and {}
				or mRooms[v15.LoaderProgress.RoomLoaderIndex].mPlacedDecos
			local count2 = #v34
			local __wf_atom_5b41f63bs = {}
			local v35 = {}
			local v36 = {}
			local v37 = {}
			local count3 = 0

			for i = v15.LoaderProgress.DecoLoaderIndex, count2 do
				v15.LoaderProgress.DecoLoaderIndex = i + 1
				local v38 = v34[i]

				if __wf_atom_7e8ad928(v38.decoType) then
					continue
				end

				local __wf_atom_5b41f63b = v38.decoType:__wf_atom_5b41f63b()

				if v15.LoaderProgress.DecosLoaded[__wf_atom_5b41f63b] ~= nil then
					continue
				end

				v15.LoaderProgress.DecosLoaded[__wf_atom_5b41f63b] = true

				if not __wf_atom_7e8ad928(v38.pictureFrameInfo.mImage) then
					local __wf_atom_5b41f63b2 = v38.pictureFrameInfo.mImage:__wf_atom_5b41f63b()

					if v35[__wf_atom_5b41f63b2] == nil then
						v35[__wf_atom_5b41f63b2] = true
						table.insert(__wf_atom_5b41f63bs, __wf_atom_5b41f63b2)
					end
				end

				if not __wf_atom_7e8ad928(v38.pictureFrameInfo.mFilter) then
					local __wf_atom_5b41f63b2 = v38.pictureFrameInfo.mFilter:__wf_atom_5b41f63b()

					if v36[__wf_atom_5b41f63b2] == nil then
						v36[__wf_atom_5b41f63b2] = true
						table.insert(__wf_atom_5b41f63bs, __wf_atom_5b41f63b2)
					end
				end

				if not __wf_atom_7e8ad928(v38.customizationInfo.mAnim) then
					local __wf_atom_5b41f63b2 = v38.customizationInfo.mAnim:__wf_atom_5b41f63b()

					if v37[__wf_atom_5b41f63b2] == nil then
						v37[__wf_atom_5b41f63b2] = true
						table.insert(__wf_atom_5b41f63bs, __wf_atom_5b41f63b2)
					end
				end

				table.insert(__wf_atom_5b41f63bs, __wf_atom_5b41f63b)
				count3 += 1

				if count3 == count2 or i == count2 then
					break
				end
			end

			if count2 < v15.LoaderProgress.DecoLoaderIndex then
				v15.LoaderProgress.DecoLoaderIndex = 1

				if v15.LoaderProgress.RoomLoaderIndex == #mRooms then
					v15.LoaderProgress.LastLoad = true
				else
					v15.LoaderProgress.RoomLoaderIndex = v15.LoaderProgress.RoomLoaderIndex + 1
				end
			end

			if #__wf_atom_5b41f63bs > 0 then
				v15.Loader = UISys.__wf_atom_c0dbe47c(__wf_atom_5b41f63bs)
				v15.IsLoading = true
			elseif count2 > 0 then
				fn51()
			elseif v15.LoaderProgress.RoomLoaderIndex <= #mRooms and not v15.LoaderProgress.LastLoad then
				fn5()
			end

			fn47()
		end
	else
		local decoded = cjson.decode(p)
		local removedDecos = {}

		if decoded.RemovedDecos == nil then
			if decoded.DecoId == nil then
				if decoded.ResetRoom ~= nil then
					local mRooms = gGameData:__wf_atom_247a5d2e(true).mRooms

					for i = 1, #mRooms do
						if mRooms[i].mName:c_str() ~= decoded.ResetRoom then
							continue
						end

						local mPlacedDecos = mRooms[i].mPlacedDecos

						for j = 1, #mPlacedDecos do
							table.insert(removedDecos, mPlacedDecos[j]:__wf_atom_854e0028())
						end

						break
					end
				end
			else
				removedDecos = { decoded.DecoId }
			end
		else
			removedDecos = decoded.RemovedDecos
		end

		for i = 1, #removedDecos do
			if not __wf_atom_7e8ad928(_T.ShipDecos[removedDecos[i]]) then
				_T.ShipDecos[removedDecos[i]]:Destroy()
				_T.ShipDecos[removedDecos[i]] = nil
			end

			if _T.ShipDecosInVignette == nil or __wf_atom_7e8ad928(_T.ShipDecosInVignette[removedDecos[i]]) then
				continue
			end

			_T.ShipDecosInVignette[removedDecos[i]] = nil
		end

		if decoded.ResetRoom == nil then
			fn47()
		end
	end
end

function RefreshShipDecos(p)
	v15.LoaderProgress.RoomLoaderIndex = 1
	v15.LoaderProgress.DecoLoaderIndex = 1
	v15.LoaderProgress.RoomCreationIndex = 1
	v15.LoaderProgress.DecoCreationIndex = 1
	v15.LoaderProgress.LastLoad = false
	fn5(p)
end

local function fn94()
	if not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97)) then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local v34 = {}
		local __wf_atom_247a5d2e = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_247a5d2e(gRegion:IsMaster())
		local mVignette = __wf_atom_247a5d2e.mVignette
		local mWallpaper = __wf_atom_247a5d2e.mWallpaper
		local mVignetteFish = __wf_atom_247a5d2e.mVignetteFish
		local isFishTank

		if __wf_atom_7e8ad928(mVignette) then
			isFishTank = false
		else
			table.insert(v34, mVignette:__wf_atom_5b41f63b())
			isFishTank = mVignette == WeakResource("/Lotus/Types/Game/ActionFigureDioramas/OceanADiorama")
		end

		if not __wf_atom_7e8ad928(mVignetteFish) then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

			for _, v36 in pairs(mVignetteFish) do
				local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(v36)

				if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
					continue
				end

				local fishDeco = module6.GetFishDeco(__wf_atom_232fd31d, fishInfoManifest)

				if not __wf_atom_7e8ad928(fishDeco) then
					table.insert(v34, fishDeco:__wf_atom_5b41f63b())
				end
			end
		end

		if not __wf_atom_7e8ad928(mWallpaper) then
			local __wf_atom_52cfac4b = Resource(mWallpaper):__wf_atom_52cfac4b()

			if not __wf_atom_7e8ad928(__wf_atom_52cfac4b) then
				table.insert(v34, __wf_atom_52cfac4b:__wf_atom_5b41f63b())
			end
		end

		if #v34 > 0 then
			v16.Loader = UISys.__wf_atom_c0dbe47c(v34)
			v16.IsLoading = true
			v16.IsFishTank = isFishTank
		end
	end
end

local function fn95()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("LotusHelmetAction"))
	local activeQuest = module2.GetActiveQuest(gGameData)

	if
		not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		and module2.HasCompletedNewWar()
		and (__wf_atom_7e8ad928(activeQuest) or not module2.QuestRequiresLotusHelmet(activeQuest))
	then
		__wf_atom_0a6a5887:Enable()
		__wf_atom_0a6a5887:__wf_atom_5e178b4e(Localize("/Lotus/Language/Actions/LotusCustomization", {}))
	end
end

function RefreshLotusHelmetTrigger()
	fn95()
end

function SetupPlayerShip()
	fn5()
	fn94()
	fn57()
	fn95()

	if gRegion:IsMaster() then
		fn55()
		return
	end

	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97))
	then
		return
	end

	local all = gRegion:FindAll(favouriteWarframeAvatarType)

	for _, v34 in ipairs(all) do
		v34:__wf_atom_986f733d(Symbol(), 100)
		v34:__wf_atom_e06358f3(Symbol("Statue"))
	end
end

function OnDojoData(p, body)
	if __wf_atom_7e8ad928(_T.gDojoData) then
		return
	end

	_T.gDojoData.Result = p
	_T.gDojoData.Body = body

	if not __wf_atom_7e8ad928(_T.SquadOverlay) then
		if p then
			_T.SquadOverlay:Execute("OpenDojoLevel", "")
			return
		end

		local dojoRequestStatus = nil

		if body ~= "" and string.sub(body, 1, 1) == "{" then
			local decoded = cjson.decode(body)

			if decoded ~= nil and decoded.DojoRequestStatus ~= nil then
				dojoRequestStatus = tonumber(decoded.DojoRequestStatus)
			end
		end

		if dojoRequestStatus == -8 then
			print("CDN Dojo retrieval failed; retrying with API")
			_T.BackgroundMovie:Execute("OnLoadHubMessage", "DojoHUB_HUB_" .. _T.gDojoData.GuildId)
		else
			_T.SquadOverlay:__wf_atom_f62a8704("OnDojoData", { false, "" })
		end
	end
end

local flag2 = false
local count2 = 0
local v34 = 0

function ConfirmLoadOrbiterMessage(p)
	flag2 = false
	local __wf_atom_6be84646 = gRegion:__wf_atom_eab484a7():__wf_atom_6be84646()

	if tonumber(p) == 4 then
		gMatchingService:__wf_atom_d7f57a7a(3, __wf_atom_6be84646)
		count2 = 0
		v34 = 0
	else
		gMatchingService:__wf_atom_d7f57a7a(4, __wf_atom_6be84646)
		count2 += 1
		v34 = Time() + count2 * 15
	end
end

local function fn96(p)
	if flag2 then
		print("Ignoring Orbiter Invitation while pending")
		return
	end

	if v34 > Time() then
		print("Ignoring Orbiter Invitation after rejection")
		return
	end

	if
		__wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(gRegion)
		or gGameRules:__wf_atom_09e81034() and not gRegion:IsMaster()
	then
		return
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if __wf_atom_7e8ad928(__wf_atom_15811761) or __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
		return
	end

	local __wf_atom_6be84646 = gRegion:__wf_atom_eab484a7():__wf_atom_6be84646()

	if __wf_atom_6be84646 ~= p then
		return
	end

	local __wf_atom_6c164199 = __wf_atom_15811761:__wf_atom_6c164199()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if
		__wf_atom_7e8ad928(__wf_atom_9be88b01)
		or __wf_atom_9be88b01:__wf_atom_56f280e3(__wf_atom_6c164199)
		or not __wf_atom_18a5d83b:__wf_atom_563ea37f()
	then
		return
	end

	gMatchingService:__wf_atom_d7f57a7a(2, __wf_atom_6be84646)
	flag2 = true
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/InvitedToOrbiter", false, {
		NAME = __wf_atom_6c164199
	})
	module.ShowYesOrNoMessage(__wf_atom_8e9ac384, "ConfirmLoadOrbiterMessage")
end

function OnLoadHubMessage(p, p2)
	fn61(p, p2)
end

function OnAccountRenameRelogConfirm(p, _)
	_T.BackgroundMovie:__wf_atom_f62a8704("ConfirmLogoff", { p })
end

local function fn97(name) -- 1 equivalent call inferred from this helper
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/InviteToOrbiterReceived", false, {
		NAME = name
	})
	_T.ShowNotification(__wf_atom_8e9ac384, "SquadMemberJoined")
end

local function fn98(name) -- 1 equivalent call inferred from this helper
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/InviteToOrbiterRejected", false, {
		NAME = name
	})
	_T.ShowNotification(__wf_atom_8e9ac384, "SquadMemberLeft")
end

local function fn99(name) -- 1 equivalent call inferred from this helper
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/InviteToOrbiterAccepted", false, {
		NAME = name
	})
	_T.ShowNotification(__wf_atom_8e9ac384, "SquadMemberJoined")
end

function OnLoadOrbiterMessage(p, name)
	if p == 1 then
		fn96(name)
	elseif p == 2 then
		fn97(name) -- inferred equivalent call
	elseif p == 4 then
		fn98(name) -- inferred equivalent call
	elseif p == 3 then
		fn99(name) -- inferred equivalent call
	end
end

function OnAccountRename(p, p2)
	if p then
		if p2 == "WEGAME_ACCOUNT_ACTIVATED" then
			_T.gWeGameAccount = nil
			local movie = __wf_atom_8e4fda44:FindMovie(movies.MainMenu)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("OnWeGameAccountNamed", "")
			end
		else
			module.ShowConfirmMessage(
				"/Lotus/Language/Menu/Profile_AccountRenameSuccess",
				"OnAccountRenameRelogConfirm"
			)
		end
	else
		local v35

		if p2 == "RESTRICTED_NAME" then
			v35 = "/Lotus/Language/Menu/Profile_AccountRenameFail_RESTRICTED_NAME"
		elseif p2 == "INSUFFICIENT_FUNDS" then
			v35 = "/Lotus/Language/Menu/Profile_AccountRenameFail_INSUFFICIENT_FUNDS"
		elseif p2 == "NAME_USED" then
			v35 = "/Lotus/Language/Menu/Profile_AccountRenameFail_NAME_USED"
		else
			v35 = "/Lotus/Language/Menu/Profile_AccountRenameFail"
		end

		local v36 = Localize(v35, { NEW_NAME = _T.gPendingAccountRename })
		module.ShowMessage(v36, "OnBadNewNameAcknowledged")
	end

	_T.gPendingAccountRename = ""
end

function OnAccountRenameConfirm(p)
	if tonumber(p) == 4 then
		if _T.gWeGameAccount ~= nil then
			Engine.__wf_atom_9b9112c4(_T.gPendingAccountRename, _T.gWeGameAccount, "OnAccountRename")
			return
		end

		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				__wf_atom_9be88b01:__wf_atom_262e16ee(_T.gPendingAccountRename, "OnAccountRename")
			end
		end
	elseif _T.gWeGameAccount ~= nil then
		_T.gPendingAccountRename = ""
		module13.ShowInputDialog(
			mMovie,
			"/Lotus/Language/Menu/Profile_AccountRenameTitle",
			"",
			24,
			"AccountRename",
			"OSKAccountRename",
			{ isMultiline = false, cancelDisabled = true }
		)
	end
end

function OnBadNewNameAcknowledged()
	if _T.gWeGameAccount ~= nil then
		module13.ShowInputDialog(
			mMovie,
			"/Lotus/Language/Menu/Profile_AccountRenameTitle",
			"",
			24,
			"AccountRename",
			"OSKAccountRename",
			{ isMultiline = false, cancelDisabled = true }
		)
	end
end

local function fn100(value)
	if value == nil then
		local movie = __wf_atom_8e4fda44:FindMovie(movies.MainMenu)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnWeGameAccountNameCancelled", "")
		end
	elseif value == "" then
		if _T.gWeGameAccount ~= nil then
			module13.ShowInputDialog(
				mMovie,
				"/Lotus/Language/Menu/Profile_AccountRenameTitle",
				"",
				24,
				"AccountRename",
				"OSKAccountRename",
				{ isMultiline = false, cancelDisabled = true }
			)
		end
	else
		local invalidNewAccountNameCharacters = module.GetInvalidNewAccountNameCharacters(value)

		if invalidNewAccountNameCharacters > 0 then
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
					value,
					invalidNewAccountNameCharacters,
					invalidNewAccountNameCharacters
				),
				"OnBadNewNameAcknowledged"
			)
			return
		end

		if string.len(value) > 24 then
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_AccountRenameFail_TOO_LONG", false),
				"OnBadNewNameAcknowledged"
			)
			return
		end

		if string.len(value) < 4 then
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_AccountNameFail_TOO_SHORT", false),
				"OnBadNewNameAcknowledged"
			)
			return
		end

		local gPendingAccountRename = __wf_atom_bb4529ac(value)

		if __wf_atom_f8f86fc5(gPendingAccountRename, 1) ~= gPendingAccountRename then
			module.ShowMessage("/Lotus/Language/Menu/Profile_AccountRenameFail_CENSORED", "OnBadNewNameAcknowledged")
			return
		end

		_T.gPendingAccountRename = gPendingAccountRename

		if _T.gWeGameAccount == nil then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				if __wf_atom_18a5d83b:__wf_atom_6be84646() == gPendingAccountRename then
					module.ShowMessage(Localize("/Lotus/Language/Menu/Profile_AccountRenameFail_NO_CHANGE", {
						NEW_NAME = gPendingAccountRename
					}))
				else
					local v36 = {
						NEW_NAME = gPendingAccountRename,
						RENAME_COST = module.Ternary(Engine.__wf_atom_578fc9dd(), 50, 200)
					}
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/Profile_AccountRenameConfirm",
						true,
						v36
					)
					module.ShowConfirmMessage(__wf_atom_8e9ac384, "OnAccountRenameConfirm")
				end
			end
		else
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Changyou/AliasNameConfirm", true, {
				NEW_NAME = gPendingAccountRename
			})
			module.ShowConfirmMessage(__wf_atom_8e9ac384, "OnAccountRenameConfirm")
		end
	end
end

function AccountRename(p, p2)
	if __wf_atom_7e8ad928(p) or tonumber(p) ~= 4 then
		fn100(nil)
	else
		fn100(p2)
	end
end

function OSKAccountRename(p, p2)
	if p then
		fn100(nil)
	else
		fn100(p2)
	end
end

function InitiateAccountRename(p)
	local cancelDisabled = p == "true"
	module13.ShowInputDialog(
		mMovie,
		"/Lotus/Language/Menu/Profile_AccountRenameTitle",
		"",
		24,
		"AccountRename",
		"OSKAccountRename",
		{ isMultiline = false, cancelDisabled = cancelDisabled }
	)
end

function InitializeRegionChallenges()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local count3 = 0

	while __wf_atom_7e8ad928(__wf_atom_18a5d83b) and count3 < 30 do
		print("failed to initialize region challenges: no player profile")
		count3 += 1
		Sleep(0.1)
		__wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	end

	if count3 >= 30 then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	local count4 = 0

	while __wf_atom_7e8ad928(__wf_atom_9be88b01) and count4 < 30 do
		print("failed to initialize region challenges: no game data")
		count4 += 1
		Sleep(0.1)
		__wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	if count4 >= 30 then
		print("bailing from region challenges.")
		return
	end

	print("initializing region challenges")
	local starChart = module2.GetStarChart()
	local __wf_atom_161b95d4 = starChart:__wf_atom_161b95d4()
	local isInGamePlay = module2.IsInGamePlay()
	local v35 = 0

	if isInGamePlay then
		local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

		if __wf_atom_c67f9605:__wf_atom_172c2f5c(__wf_atom_22941262) then
			v35 = 3
		else
			local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
			local levelKeyName = __wf_atom_72fc675e.levelKeyName

			if __wf_atom_7e8ad928(levelKeyName) then
				local location = __wf_atom_72fc675e.location

				if location:__wf_atom_8598f3a9() then
					v35 = starChart:__wf_atom_d5226f21(location).region + 1
				end
			else
				local v36 = Resource(levelKeyName)

				if not __wf_atom_7e8ad928(v36) then
					v35 = v36:__wf_atom_1c4ed35a()
				end
			end
		end
	end

	local v36 = Symbol("QUEST_COMPLETE")
	local v37 = WeakResource("/Lotus/Types/Keys/InfestedIntroQuest/InfestedIntroQuestKeyChain")
	local v38 = WeakResource("/Lotus/Types/Keys/VorsPrize/VorsPrizeQuestKeyChain")
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	print("regions: " .. #__wf_atom_161b95d4)
	local v39 = nil
	local flag3 = false

	for i = 1, #__wf_atom_161b95d4 do
		local v40 = __wf_atom_161b95d4[i]

		if __wf_atom_7e8ad928(v40) then
			continue
		end

		for _, challenge in pairs(v40.challenges) do
			if
				__wf_atom_539492fe:__wf_atom_c74ddda3(challenge:GetName()) >= challenge:__wf_atom_18516282()
				or not (not isInGamePlay or i == v35 or challenge:__wf_atom_57a14ab9())
			then
				continue
			end

			__wf_atom_539492fe:__wf_atom_660699a4(gRegion:CreateObject(Type(challenge)))

			if __wf_atom_7e8ad928(__wf_atom_eab484a7) or challenge:__wf_atom_ac556b6c() ~= v36 then
				continue
			end

			if v39 == nil then
				v39 = __wf_atom_9be88b01:GetInventory():__wf_atom_fe84572e()
			end

			local __wf_atom_fe224621 = challenge:__wf_atom_fe224621()

			for _, v41 in ipairs(v39) do
				if __wf_atom_fe224621 == v41.mItemType and v41.mCompleted then
					__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_eab484a7, v36, nil, v41.mItemType)
					flag3 = true
				elseif __wf_atom_fe224621 == v38 and v41.mItemType == v37 then
					__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_eab484a7, v36, nil, v38)
					flag3 = true
				end
			end
		end
	end

	if v26 == nil then
		v26 = module2.HasCompletedVorsPrize()
	end

	fn37()

	if _G.PlayedFightingGame then
		__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_eab484a7, Symbol("PLAY_MINIGAME"))
		gGameData:UploadChallengeProgress()
		_G.PlayedFightingGame = nil
	end

	local v40 = Symbol("LORE_FRAGMENT_SCAN")
	local __wf_atom_c74ddda3 = __wf_atom_539492fe:__wf_atom_c74ddda3("MPCephFragments")
	local __wf_atom_0dec86a1 = __wf_atom_9be88b01:GetInventory():__wf_atom_0dec86a1()

	for _, v42 in pairs(__wf_atom_0dec86a1) do
		if v42.mRegion ~= "/Lotus/Language/Locations/Mars" then
			continue
		end

		local v43 = v42.mItemCount - __wf_atom_c74ddda3

		if not (v43 > 0) then
			continue
		end

		__wf_atom_539492fe:__wf_atom_9aca19e0(__wf_atom_eab484a7, v40, v43)
		flag3 = true
		break
	end

	if flag3 then
		__wf_atom_9be88b01:UploadChallengeProgress()
	end

	if not _T.CachedConstructionProjects then
		_T.CachedConstructionProjects = module8.GetConstructionProjects()
	end

	local cachedConstructionProjects = _T.CachedConstructionProjects

	for i = 1, #cachedConstructionProjects do
		local cachedConstructionProject = cachedConstructionProjects[i]
		local goalId = cachedConstructionProject.goalId

		if cachedConstructionProject.progress ~= 0 then
			continue
		end

		local mTasks = cachedConstructionProject.info.mTasks
		local flag4 = true

		for _, mTask in pairs(mTasks) do
			if __wf_atom_7e8ad928(mTask) then
				continue
			end

			if not (__wf_atom_539492fe:__wf_atom_c74ddda3(mTask:GetName()) < Resource(mTask):__wf_atom_18516282()) then
				continue
			end

			local object = gRegion:CreateObject(Type(mTask))

			if not __wf_atom_539492fe:__wf_atom_660699a4(object) then
				gRegion:__wf_atom_dd1e4d10(object)
			end

			flag4 = false
		end

		if not flag4 then
			continue
		end

		v29 = cachedConstructionProject
		__wf_atom_9be88b01:__wf_atom_e1ee283d(goalId, "OnClaimRelayTasksComplete")
	end
end

function CheckNewOmega()
	mCheckingForIdentifiedOmegaMods = true
	mOmegaWithPendingFingerprints = {}
	mNewIdentifiedOmegaMods = {}
	v9 = 1
end

function ShowPurchaseCelebration()
	if not __wf_atom_7e8ad928(purchaseCelebrationMovie) then
		mPurchasePopupMovie = mMovie:PushChildMovie(purchaseCelebrationMovie)
	end
end

function ApplyLoadOutChanges()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(_T.ShipDecos) then
		return
	end

	local mRooms = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_247a5d2e(true).mRooms
	local v35 = {}
	local shipDecos = {}
	local v36 = {}

	for i = 1, #mRooms do
		local mPlacedDecos = mRooms[i].mPlacedDecos

		for j = 1, #mPlacedDecos do
			local mPlacedDeco = mPlacedDecos[j]
			local __wf_atom_854e0028 = mPlacedDeco:__wf_atom_854e0028()
			local shipDeco = _T.ShipDecos[__wf_atom_854e0028]
			local v37 = false

			if not __wf_atom_7e8ad928(shipDeco) and shipDeco:IsA(customizableDecoType) then
				local customizationInfo = mPlacedDeco.customizationInfo
				local mLoadOutType = customizationInfo.mLoadOutType

				if
					customizationInfo.mLoadOutPreset:__wf_atom_48e5303e()
					and customizationInfo.mLoadOutPreset.mItemId.mId ~= SF.__wf_atom_b8679e91
					or customizationInfo.mVehiclePreset:__wf_atom_48e5303e()
					and customizationInfo.mVehiclePreset.mItemId.mId ~= SF.__wf_atom_b8679e91
				then
					local v38 = customizationInfo.mLoadOutPreset.mItemId.mId .. customizationInfo.mVehiclePreset.mItemId.mId .. mLoadOutType

					if v35[v38] == nil then
						table.insert(v36, {
							Preset = customizationInfo.mLoadOutPreset:Copy(),
							VehiclePreset = customizationInfo.mVehiclePreset:Copy(),
							LoadOutType = mLoadOutType
						})
						v35[v38] = 1
					end

					mPlacedDecos[j].customizationInfo.mLoadOutPreset:__wf_atom_9ae1efa7(false)
					mPlacedDecos[j].customizationInfo.mVehiclePreset:__wf_atom_9ae1efa7(false)
					local __wf_atom_4942f5a9 = shipDeco:__wf_atom_4942f5a9()
					__wf_atom_4942f5a9.mLoadOutPreset = mPlacedDecos[j].customizationInfo.mLoadOutPreset
					local __wf_atom_4942f5a9_2 = shipDeco:__wf_atom_4942f5a9()
					__wf_atom_4942f5a9_2.mVehiclePreset = mPlacedDecos[j].customizationInfo.mVehiclePreset
					v37 = true
				end
			end

			if __wf_atom_7e8ad928(shipDeco) or not shipDeco:IsA(customizableDecoType) or not v37 then
				continue
			end

			shipDecos[#shipDecos + 1] = shipDeco
		end
	end

	if #shipDecos ~= 0 then
		module14.CreateActionFigureLoader(nil)
		_T.ActionFigureLoadOutLoader:LoadDecosWithLoadOutsThenFinish(shipDecos, v36)
	end
end

function OnLobbyReady(_) end

function OnUpdateSessionSettings() end

fn = function(name, p)
	local KEY_TAG = module2.KEY_TAG
	local v35 = Resource(name)
	local starChart = module2.GetStarChart()

	if string.lower(name) == "dojo" or string.lower(name) == "drydock" then
		if string.lower(name) == "drydock" then
			_G.ForceTeleportToDrydock = true
		end

		_T.SquadOverlay:Execute("InitiateDojoVisit", "")
		return true
	else
		local mission, v36

		if __wf_atom_7e8ad928(v35) or not v35:IsA(__wf_atom_c8d7c4cd) then
			mission = starChart:__wf_atom_d5226f21(Symbol(name)).mission
			KEY_TAG = ""
		else
			mission = v35:__wf_atom_72fc675e()
			v36 = name
		end

		if __wf_atom_7e8ad928(mission.levelOverride) and name and string.find(name, ".level") then
			mission = SF.SFMissionInfo()
			mission.levelOverride = WeakResource(name)
		end

		if __wf_atom_7e8ad928(mission.levelOverride) then
			return false
		end

		if not __wf_atom_7e8ad928(p) then
			mission.keyChainName = WeakResource(p)
		end

		if v36 == nil and mission.missionType == 32 then
			_T.RailjackAutoLaunchPending = { teleportNeeded = true, name = name }
			_T.SquadOverlay:Execute("AutoLaunchRailjackMission", "")
			return true
		else
			if
				not mission.soloMode
				and __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
				and _T.SquadOverlay
				and _T.gActiveMatchMakingMode ~= _T.MATCHMAKING_OFFLINE_GAMEMODE
			then
				_T.SquadOverlay:Execute("HostLobby", "")

				while __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) do
					Sleep(0)
				end
			end

			if string.find(name, "Wareframe") and _T.SquadOverlay then
				_T.SquadOverlay:Execute("LoadAutonomousMultiplayerMission", name .. KEY_TAG)
				return true
			end

			local missionOpenLevelArgs = module3.GetMissionOpenLevelArgs(
				Symbol(name .. KEY_TAG),
				mission,
				WeakResource(v36)
			)

			if missionOpenLevelArgs then
				if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
					local gameModeIdForNode = module2.BuildGameModeIdForNode(name .. KEY_TAG, starChart)
					local settings = gMatchingService:__wf_atom_15811761():GetSettings()
					settings.gameModeId = gameModeIdForNode
					gMatchingService:__wf_atom_c8d901d4(settings, "OnUpdateSessionSettings")
				end

				Engine.OpenLevel(missionOpenLevelArgs)
				return true
			end
		end

		return false
	end
end

function DebugLoadMission(p, p2)
	return fn(p, p2)
end

function ConfirmWeaponRetrieve(p)
	if tonumber(p) == 4 then
		_T.gOpenWeaponRecoveryMission()
	end
end

function OnTrainingResultUploaded(p, value)
	if p then
		local __wf_atom_a04e4a53 = gGameData:__wf_atom_a04e4a53()
		module2.OpenTrainingMission(__wf_atom_a04e4a53 + 1, false)
	elseif string.find(value, "No daily retries remaining") then
		local __wf_atom_e0c949ff = gGameData:__wf_atom_e0c949ff()
		local secondsToFormattedTime = module2.SecondsToFormattedTime(mMovie, __wf_atom_e0c949ff)
		local v35 = Localize("/Lotus/Language/Menu/Foreground_LevelUpSuspended", false)
		local v36 = string.format(v35, secondsToFormattedTime)
		fn3(0)
		module.ShowMessage(v36)
	elseif value == "1" then
		fn3(0)
		fn9("Platinum", "0", Localize("/Lotus/Language/Menu/RankupRetry", {}))
	elseif count < 2 then
		v30 = true
		count += 1
	else
		print("Failed to submit training result too many times. Aborting.")
		fn3(0)
	end
end

local function fn101()
	if gGameData:GetInventory().mPremiumCredits < module2.GetTrainingRetryPlatinumCost() then
		fn9("Platinum", "0", Localize("/Lotus/Language/Menu/RankupRetry", {}))
		return
	end

	fn3(1)
	v30 = true
	count = 0
end

function LevelUpRetry()
	fn101()
end

function LevelUpRetryConfirm(p)
	if tonumber(p) == 4 then
		fn101()
	end
end

function LevelUp()
	local canRankUp, v35, v36 = module2.CanRankUp(gGameData, false)

	if canRankUp then
		if gGameData:__wf_atom_60be7258() then
			module.ShowConfirmMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/RetrieveLockedWeapons", false),
				"ConfirmWeaponRetrieve"
			)
			return
		end

		fn3(1)
		v30 = true
		count = 0
	elseif v36 then
		module.ShowConfirmMessage(v35, "LevelUpRetryConfirm")
	else
		module.ShowMessage(v35)
	end
end

function QueueMailboxNotification()
	_T.gQueueMailbox = true
end

function ForceVersionLogoff()
	fn30()
end

function QuitGameConfirm(p)
	_T.ShowingQuitGameDialog = nil

	if tonumber(p) == 4 then
		__wf_atom_8e4fda44:__wf_atom_bcb70491(cmdQuit)
	end
end

function QuitGame()
	if not _T.ShowingQuitGameDialog then
		_T.ShowingQuitGameDialog = true
		module.ShowTwoOptionMessage(
			"/Lotus/Language/Menu/QuitGameConfirm",
			"QuitGameConfirm",
			nil,
			"/Lotus/Language/Menu/Confirm",
			"/Lotus/Language/Menu/QuitGame",
			"/Menu/Confirm_Item_Cancel"
		)
	end

	return true
end

function ForceRefreshFoundryNotification()
	mFoundryNotification.Refresh = true
end

function OnFirstLogin()
	print("Executing OnFirstLogin on background movie")
	module12.StartFirstLoginSequenece()
end

function OnSyncInventoryForExternalPurchase(p, _)
	if p then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnExternalProductPurchaseComplete", "")
	end

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		local v35 = { 1, 2, 0, 3 }

		for i, v36 in ipairs({ 0, 1, 3, 5 }) do
			local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(v36)
			local inventory = gGameData:GetInventory()

			if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_7e8ad928(inventory) then
				continue
			end

			local __wf_atom_bb8450ca = __wf_atom_28224c27:__wf_atom_bb8450ca()

			if not __wf_atom_bb8450ca:__wf_atom_8598f3a9() or __wf_atom_bb8450ca:__wf_atom_b70c3343() then
				continue
			end

			if not __wf_atom_7e8ad928(inventory:__wf_atom_0ff4b555(0, v35[i], (tostring(__wf_atom_bb8450ca))).mItemType) then
				continue
			end

			Engine.Disconnect(true)
			return
		end
	end
end

function OnCheckExternalProductAvailability(p)
	if p then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnExternalProductPurchaseComplete", "")
	end
end

function OnEntitlementsComplete(_, _) end

local function fn102()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local mPlatinumCooldown = mPlatinumCooldown
	local v35

	if _T.ExternalProductPurchaseInitiated then
		v35 = mPlatinumCooldown - (PLATINUM_CHECK_COOLDOWN - 4)
	else
		v35 = _T.Enabling2FA and 0 or mPlatinumCooldown
	end

	if v35 > 0 then
		return
	end

	mUpdatingPlatinum = true
	gGameData:__wf_atom_4c1702bf("OnCreditsResult")
	__wf_atom_a0f6588f:CheckEntitlements("OnEntitlementsComplete")

	if not gGameData:__wf_atom_cb02838c() then
		gGameData:__wf_atom_6646ca4d("OnInboxSync")
		return
	end

	print("Skipping inbox sync on focus (already has unread messages)")
	_T.gQueueMailbox = true
end

function OnCreditsResult(p, _)
	mUpdatingPlatinum = false
	mPlatinumCooldown = PLATINUM_CHECK_COOLDOWN

	if not p or __wf_atom_7e8ad928(gGameData) then
		return
	end

	if gGameData:__wf_atom_4b3bf785() then
		_T.ExternalProductPurchaseInitiated = false

		if
			__wf_atom_7e8ad928(_T.ExternalProductPostPurchaseSyncHandled)
			or not _T.ExternalProductPostPurchaseSyncHandled
		then
			gGameData:SyncInventoryFromDB("OnSyncInventoryForExternalPurchase")
		end

		_T.ExternalProductPostPurchaseSyncHandled = false
		gGameData:__wf_atom_f1ca6d40("OnCheckExternalProductAvailability")
	end
end

function NotifyFocus(p)
	if not mUpdatingPlatinum and p == "true" then
		fn102()
	end
end