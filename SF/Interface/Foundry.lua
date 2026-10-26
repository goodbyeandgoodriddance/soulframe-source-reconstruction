local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.Libs.ListItemUtil")
local module5 = require("SF.Interface.StoreItemUtilities")
local module6 = require("SF.Interface.Libs.ItemUtil")
local module7 = require("Lotus.Interface.LotusUtilities")
local module8 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module9 = require("EE.Interface.AnchorMgr")
local module10 = require("SF.Scripts.Libs.TransmissionSet")
local module11 = require("SF.Interface.Libs.StatsUtil")
local module12 = require("SF.Interface.Components.Scrollbar")
local v = WeakResource("/SF/Types/Recipes/Armor/BaseArmorBlueprint")
local v2 = WeakResource("/SF/Types/Recipes/ColorPalettes/ColorPaletteBlueprint")
local v3 = WeakResource("/SF/Types/Recipes/Elixers/ElixerRecipeItem")
local v4 = WeakResource("/SF/Types/Recipes/Weapons/BaseWeaponBlueprint")
local v5 = WeakResource("/SF/Types/Recipes/WeaponQuality/ImproveQualityBaseBlueprint")
local v6 = {
	FEY = WeakResource("/SF/Types/Recipes/WeaponQuality/Dendrit/ImproveQualityBaseDendritBlueprint"),
	DENDRIT = WeakResource("/SF/Types/Recipes/WeaponQuality/Dendrit/ImproveQualityBaseDendritBlueprint"),
	CASSID = WeakResource("/SF/Types/Recipes/WeaponQuality/Dendrit/ImproveQualityBaseDendritBlueprint"),
	ODE = WeakResource("/SF/Types/Recipes/WeaponQuality/Ode/ImproveQualityBaseOdeBlueprint"),
	MENDICANT = WeakResource("/SF/Types/Recipes/WeaponQuality/Ode/ImproveQualityBaseOdeBlueprint")
}
local v7 = Resource("/SF/Types/Items/Aspects/Tempers/BaseAspectTemper")
local v8 = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/RetuneBaseBlueprint")
local v9 = {
	FEY = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/FeyRetuneBlueprint"),
	DENDRIT = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/DendritRetuneBlueprint"),
	CASSID = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/CassidRetuneBlueprint"),
	ODE = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/OdeRetuneBlueprint"),
	MENDICANT = WeakResource("/SF/Types/Recipes/WeaponAspectManipulation/MendicantRetuneBlueprint")
}
local v10 = WeakResource("/SF/Types/Recipes/WeaponQuality/ChaosRerollBlueprint")
local v11 = {
	TEXT_DISABLED = _G.UIColor_Brown,
	TEXT_FOCUSED = _G.UIColor_Yellow,
	TEXT_UNFOCUSED = _G.UIColor_Tan,
	ICON_BG = _G.UIColor_Beige,
	BG = _G.UIColor_DarkerBrown
}
local v12 = {
	COMPLETE = 1,
	SPECIAL = 2,
	LOCKED = 3,
	REFINING = 4,
	INCOMPLETE = 5
}
local v13 = { JOINERY = 1, FRAGMENTS = 2, ASPECT = 3 }
local v14 = {
	Verminia = { v2, v3 },
	Foundry = {}
}
local v15 = {
	{ IconIndex = 21 },
	{ IconIndex = 24 },
	{ IconIndex = 23 },
	{ IconIndex = 5 },
	{ IconIndex = 25 },
	{ IconIndex = 22 }
}
local v16 = { 0, 1, 3, 4, 5, 6, 8 }
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = nil
local v28 = nil
local inventory = nil
local v29 = nil
local v30 = nil
local v31 = nil
local v32 = nil
local v33 = nil
local v34 = nil
local v35 = nil
local icon = nil
local flag = nil
local v36 = nil
local v37 = nil
local v38 = nil
local v39 = nil
local v40 = nil
local v41 = nil
local v42 = ""
local v43 = ""
local v44 = ""
local v45 = {}
local v46 = false
local v47 = nil
local v48 = nil
local foundry_NPC = "Foundry"
local v49 = nil
local v50 = nil
local fn
local asyncLoader = module2.CreateAsyncLoader()
local v51 = nil
local v52 = nil
local v53 = nil
local v54 = nil
local v55 = nil
local v56 = nil
local v57 = nil
local v58 = nil
local v59 = nil
local v60 = nil
local v61 = nil
local v62 = Type("/SF/Objects/PlayerTent/TuvalkaneStations/TuvalkaneDressformPowerSuit")
local flag2 = false
local v63 = WeakResource("/SF/Upgrades/Skins/Body/BaseBody")
local v64 = WeakResource("/SF/Upgrades/Skins/Legs/BaseLegs")
local v65 = WeakResource("/SF/Upgrades/Skins/Helmets/BaseHelmet")
local v66 = WeakResource("/SF/Upgrades/Skins/Sparrow/GuideBaseItem")
local vendorDialougCamera = nil
local v67 = nil
local v68 = nil
local flag3 = false
local statWeapon = nil
local v70 = nil
local v71 = nil
local v72 = nil
local v73 = false
local v74 = nil
local v75 = nil
local v76 = nil
local flag4 = false
local v77 = nil
local weapon = nil
local flag5 = false
local total = 0
local v78 = nil
local vendorTransmissionSet = nil
local flag6 = false
local flag7 = false

local function fn2()
	UpdateButtons()

	if v22 ~= nil then
		v22.mScrollBar:ResizeVisRangeMaterials()
	end

	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.5)
end

local function fn3()
	module3.CloseInventory()
	fn2()
end

local function fn4(p)
	p.OnClosed = fn2
	module3.OpenInventory(mMovie, p)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5)
end

function ConfirmChaosReroll()
	v44 = Resource(v10):__wf_atom_5b41f63b()
	v42 = v31.WeaponInfo.Id .. ","
	v43 = v31.ResultItemType:__wf_atom_5b41f63b() .. ","
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/SF/Language/Materials/ChaosChordstoneDesc"
	dialogSettings.titleString = "/SF/Language/Materials/ChaosChordstoneName"
	dialogSettings.firstString = "/SF/Language/Crafting/Foundry_CraftAction"
	local __wf_atom_a4299765 = gGameData:__wf_atom_a4299765()

	for i = 0, 6 - 1 do
		local __wf_atom_d21f18f2 = __wf_atom_a4299765:__wf_atom_d21f18f2(0, i)

		if v31.WeaponInfo.Id ~= __wf_atom_d21f18f2.mItem.mItemId.mId then
			continue
		end

		v49 = i
		v50 = __wf_atom_d21f18f2
	end

	dialogSettings:SetCallback(OnCraftConfirm)
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

local function fn5()
	fn4({
		BackgroundAlpha = 0.7,
		ShouldShowInfoTip = false,
		Categories = {
			{
				ItemType = 11,
				SubType = WeakResource("/SF/Types/PickUps/Resources/ResourceItem"),
				Name = "/SF/Language/Crafting/Foundry_Materials"
			}
		},
		ShowAllItemsCategory = false,
		ShowCurrency = false,
		ShowPauseMenu = false
	})
end

local function fn6()
	if flag6 then
		return
	end

	if _T.InventoryOpen then
		fn3()
		return
	end

	flag6 = true
	module3.DissolveOutAndClose(mMovie)

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end
end

local v79 = true

local function fn7()
	if __wf_atom_7e8ad928(inventory) then
		return 0
	end

	return inventory:__wf_atom_c9e583ca(v10)
end

function OnChaosConfirm(p)
	if tonumber(p) == 4 then
	end
end

local function fn8()
	flag4 = false
	UpdateButtons()
	ToggleLegendaryTitleSelectionMode(false)
end

function UpdateButtons()
	local v80 = {}

	if v21.mState == v21.mStates.CRAFT then
		local ternary = module.Ternary(v79, "<FULL_CHECK>", "<EMPTY_CHECK>")
		table.insert(v80, {
			Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_ShowCraftedToggle", false) .. " " .. ternary,
			CallBack = function()
				v79 = not v79
				UpdateButtons()
				PopulateRecipeList()
			end,
			CallOut = "MENU_GENERIC1"
		})
	end

	if v21.mState == v21.mStates.IMPROVE then
		local v81 = fn7()

		if v81 > 0 and not __wf_atom_7e8ad928(v33) and v33.Weapon.RawItem.mQuality ~= 6 then
			table.insert(v80, {
				Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Materials/ChaosChordstoneName", true) .. " " .. mMovie:__wf_atom_8e9ac384("<CHAOS_CHORDSTONE>", true) .. v81,
				CallBack = ConfirmChaosReroll,
				CallOut = "MENU_GENERIC1"
			})
		end
	end

	if not flag4 and (__wf_atom_7e8ad928(v77) or not v77:__wf_atom_7d4910e4()) then
		table.insert(v80, {
			Label = "/SF/Language/Crafting/Foundry_Materials",
			CallBack = fn5,
			CallOut = "MENU_GENERIC2"
		})
		table.insert(v80, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = fn6,
			CallOut = "MENU_CANCEL"
		})
	end

	if flag4 and (__wf_atom_7e8ad928(v77) or not v77:__wf_atom_7d4910e4()) then
		table.insert(v80, {
			Label = "/SF/Language/Menu/Menu_Back",
			CallBack = fn8,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v80, getfenv(1))
	end
end

function GetStoreItem(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(v20) then
		return nil
	end

	return v20:__wf_atom_232fd31d(p)
end

local function fn9(p)
	local craftingPostErrorMessage = module2.GetCraftingPostErrorMessage(p)
	module.ShowMessage(craftingPostErrorMessage)
end

local function fn10()
	v37 = { mClipName = "DetailsPanel.UpgradeElement", Icon = nil, Curr = 0, Req = 1 }
	v24.mElementDrawCallback(v37)
end

local function fn11(storeItem)
	if
		__wf_atom_7e8ad928(vendorTransmissionSet)
		or __wf_atom_7e8ad928(storeItem:__wf_atom_e622b3f6())
		or (total < 20 or v78 == storeItem)
	then
		return
	end

	local _EMPTY_SYMBOL = EMPTY_SYMBOL
	local v80 = Symbol(storeItem:GetName() .. "Focused")

	if not vendorTransmissionSet:__wf_atom_b4a422ed(v80) then
		if storeItem:__wf_atom_e622b3f6():IsA(__wf_atom_39c4c96b) then
			v80 = Symbol("WeaponFocused")
		else
			v80 = Symbol("OtherItemFocused")
		end
	end

	if v80:__wf_atom_8598f3a9() then
		module10.PlayLocalTransmission(vendorTransmissionSet, v80, gRegion:__wf_atom_c4f78a8f())
		total = 0
		v78 = storeItem
	end
end

local function fn12()
	if __wf_atom_7e8ad928(vendorTransmissionSet) then
		return
	end

	module10.PlayLocalTransmission(vendorTransmissionSet, Symbol("CraftingConfirmed"), gRegion:__wf_atom_c4f78a8f())
	total = 0
end

local function fn13()
	if __wf_atom_7e8ad928(vendorTransmissionSet) then
		return
	end

	module10.PlayLocalTransmission(vendorTransmissionSet, Symbol("CraftingComplete"), gRegion:__wf_atom_c4f78a8f())
	total = 0
end

local function fn14(object, p, p2)
	local __wf_atom_c0d09e05 = object:__wf_atom_c0d09e05()
	object:__wf_atom_b6b760b5()

	for i = 0, __wf_atom_c0d09e05 do
		local __wf_atom_3de89c8e = object:__wf_atom_3de89c8e(i)

		if p and not __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
			local __wf_atom_b90af225 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("SkinToneColor"), 1)

			if not __wf_atom_7e8ad928(__wf_atom_b90af225) and __wf_atom_b90af225 ~= 3.4028234663852886e38 then
				object:__wf_atom_a887a262(i, Resource("/EE/Materials/HiddenNonShadowing"))
			end
		end

		if p2 then
			object:__wf_atom_a887a262(i, Resource("/EE/Materials/HiddenNonShadowing"))
		end
	end
end

function FadeOutFoundryOnRankUp()
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 3)

	if not (__wf_atom_7e8ad928(vendorDialougCamera) or __wf_atom_7e8ad928(v52) or v52:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = v52:__wf_atom_1b3db7e0()
		v52:__wf_atom_fd14c463(0)
		v52:SetCameraSpot(vendorDialougCamera, 0.5)
		v52:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end
end

function FadeInMovieOnRankUpFinished()
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 3)
end

local function fn15(instance, p)
	if __wf_atom_7e8ad928(v67) then
		return
	end

	local v80 = nil

	if __wf_atom_7e8ad928(instance) then
		v80 = vendorDialougCamera
		v67:SetVisibility(false)
		v68:SetVisibility(false)
	elseif instance:IsA(__wf_atom_d98e64fe) or instance:IsA(__wf_atom_2fc5c2e8) then
		if instance:IsA(__wf_atom_d98e64fe) then
			v68:__wf_atom_45cf0e1a(instance:__wf_atom_9337b8d5(), true, true)
			v68:SetVisibility(true)
			v67:SetVisibility(false)
		else
			v68:SetVisibility(false)
			v67:__wf_atom_45cf0e1a(instance:__wf_atom_9337b8d5(), true, true)
			v67:SetVisibility(true)
		end

		v80 = v53
	elseif instance:IsA(__wf_atom_abf506db) and not instance:IsA(v66) then
		local v81 = nil

		if instance:__wf_atom_e84d016c(0) then
			v80 = v55
			v81 = 0
		elseif instance:__wf_atom_e84d016c(2) then
			v80 = v54
			v81 = 2
		elseif instance:__wf_atom_e84d016c(3) then
			v80 = v56
			v81 = 3
		elseif instance:__wf_atom_e84d016c(5) then
			v80 = v57
			v81 = 5
		end

		if not __wf_atom_7e8ad928(v61) then
			if flag2 then
				v59:__wf_atom_632ac5b2()
			end

			v59:SetSkin(instance, v81)
			v61:SetCustomization(v59)
			v61:__wf_atom_315f6d55(v59)
			v61:__wf_atom_4325314c()
			local __wf_atom_6e6983c7 = v61:__wf_atom_6e6983c7(v81)

			if not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
				fn14(__wf_atom_6e6983c7, true)
			end

			flag2 = true
		end
	else
		v80 = vendorDialougCamera
		v67:SetVisibility(false)
		v68:SetVisibility(false)
	end

	if not (__wf_atom_7e8ad928(v80) or __wf_atom_7e8ad928(v52) or v52:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = v52:__wf_atom_1b3db7e0()
		v52:__wf_atom_fd14c463(0)
		v52:SetCameraSpot(v80, p)
		v52:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end
end

local function fn16()
	if not module8.GetLocalPlayerAncestorOfType(ancestorType) then
		return EMPTY_SYMBOL
	end

	local v80 = Resource(ancestorType)
	local ancestorRank = module8.GetAncestorRank(ancestorType)
	local __wf_atom_d5b255f8 = v80:__wf_atom_d5b255f8()

	if
		ancestorRank < __wf_atom_d5b255f8 - 1
		or ancestorRank == __wf_atom_d5b255f8 - 1 and not module8.CheckForPendingRankUp(v80)
	then
		return Symbol(ancestorType:__wf_atom_5b41f63b())
	end

	return EMPTY_SYMBOL
end

function ShowSlotPurchaseDialog(p, p2)
	if v36 ~= nil then
		local v80 = WeakResource("/SF/Types/StoreItems/SlotItems/UniversalSlotItem")
		local __wf_atom_232fd31d = v20:__wf_atom_232fd31d(v80)
		local storeItemPriceObject = module7.GetStoreItemPriceObject(__wf_atom_232fd31d)
		local storeItemInfo = module5.GetStoreItemInfo(mMovie, __wf_atom_232fd31d, nil, nil, nil, true)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			"<PREMIUM_CURRENCY>" .. storeItemPriceObject.UsePrice,
			true
		)
		local name = storeItemInfo.Name
		local colorHTMLMessage = module3.ColorHTMLMessage("/SF/Language/Vendor/PurchaseMoreSlots", {
			COST = __wf_atom_8e9ac384,
			ITEM = name
		})
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.locString = module2.GetCraftingPostErrorMessage(p) .. "\n" .. colorHTMLMessage
		dialogSettings.titleString = "/SF/Language/Vendor/ArsenalFull"
		dialogSettings.firstString = "/Menu/Confirm_Item_Yes"
		dialogSettings.secondString = "/Menu/Confirm_Item_No"
		dialogSettings:SetCallback(function(p3)
			if p3 == 4 then
				OnConfirmPurchaseSlot(__wf_atom_232fd31d, p2)
			end
		end)
		dialogSettings.icon = __wf_atom_232fd31d:__wf_atom_5b41f63b() .. ",100,100,nil,nil,/Lotus/Fx/Interface/IdentifyResourceFanfare"
		module.ShowCustomMessage(dialogSettings)
	end
end

function OnConfirmPurchaseSlot(mStoreItem, callback)
	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 0
	purchaseParams.mSourceId = v20:__wf_atom_5b41f63b()
	purchaseParams.mStoreItem = mStoreItem
	purchaseParams.mQuantity = 1
	purchaseParams.mSkipConfirm = true
	_T.DoPurchase(purchaseParams, function(p)
		if p ~= nil then
			if __wf_atom_7e8ad928(mMovie) then
				return
			end

			if p and callback ~= nil then
				callback()
			end
		end
	end)
end

function OnStartRecipeResults(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	local flag8 = false

	if __wf_atom_7e8ad928(v31) or v31.StoreItem:__wf_atom_ed1be18b() ~= 0 then
		SetState(v21.mStates.CLAIM)
	else
		flag8 = true
	end

	fn10()

	if p then
		if not flag8 then
			fn12()
		end

		fn(false)

		if flag8 then
			local decoded = cjson.decode(p2)
			local v80 = { MongoId(decoded.RecipeId["$oid"]) }
			SendClaimRequest(v80, false)
		else
			flag3 = true
			module7.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
			UpdateClaimableState()
		end

		_T.BackgroundMovie:Execute("ForceRefreshFoundryNotification", "")
	else
		print(p2)

		if tonumber(p2) == 5 then
			ShowSlotPurchaseDialog(p2, function()
				v51:AddTimer(__wf_atom_fa1258d0(), function()
					if v36 ~= nil then
						v31 = v36
						ClaimIndividualItem(v31.RecipeId, true)
					end
				end)
			end)
		else
			fn9(p2)
		end
	end
end

local function fn17()
	v31 = nil
	v36 = nil
	v33 = nil
	flag = true
	v35 = false
	fn10()
	PopulateRecipeList()
	__wf_atom_ec43d06e(mMovie, "DetailsPanel", 8, { 12 }, { 0 }, 0.2, 0, function()
		mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, false)
	end)
	mMovie:__wf_atom_2dedec1a("ListContainer.Claim", 13, v21.mState == v21.mStates.CLAIM)
	v22:ShowClaim(v21.mState == v21.mStates.CLAIM, "")
	UpdateButtons()
end

function SetState(mState)
	if mState == v21.mState then
		return
	end

	mMovie:__wf_atom_2dedec1a("ListNotification", 13, false)
	module.PlaySound(_G.UISound_ButtonSelect)
	v21.mState = mState
	v22:SetActiveCategoryId(mState)

	if mState == v21.mStates.CLAIM then
		v46 = true
	end

	if not __wf_atom_7e8ad928(v15[mState]) then
		v22:SetTitle(mMovie:__wf_atom_8e9ac384(v15[mState].Name, false))
	end

	fn17()
	v24:SetCallbacks("MaterialSelected", "MaterialFocused", "MaterialUnfocused")
end

function OnCraftConfirm(p)
	if tonumber(p) ~= 4 then
		return
	end

	local ternary = module.Ternary(__wf_atom_7e8ad928(v45.mOptionalSelection), "", v45.mOptionalSelection)
	gGameData:__wf_atom_8da8dbc6(v44, v42, v43, 0, OnStartRecipeResults, ternary)
end

function ThankYouPopupEnd()
	if flag4 or not weapon then
		flag4 = false
		weapon = nil
		UpdateButtons()
	else
		UpgradedToLegendary(weapon)
		weapon = nil
	end
end

function ShowThankYouPopup()
	local tuvalPortraitIcon = tuvalPortraitIcon
	local thankYouPopupCraftedIcon = thankYouPopupCraftedIcon

	if IsVerminia() then
		tuvalPortraitIcon = verminiaPortraitIcon
		thankYouPopupCraftedIcon = thankYouPopupBrewedIcon
	end

	local v80 = "/SF/Language/Vendor/ThankYouPopupCraftedTitle"
	local v81 = 0
	local v82

	if
		v36 == nil
		or __wf_atom_7e8ad928(v36.ResultStoreItem) and (not weapon or __wf_atom_7e8ad928(weapon.ResultStoreItem))
	then
		if v73 then
			v82 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ThankYouPopupAllItemsClaimedTitle", false)
			tuvalPortraitIcon = nil
			v81 = -80
		else
			v82 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ThankYouPopupItemsClaimedTitle", false)
		end
	else
		local v83

		if weapon and not __wf_atom_7e8ad928(weapon.ResultStoreItem) then
			v83 = weapon
		else
			v83 = v36
		end

		tuvalPortraitIcon = v83.ResultStoreItem:GetIconTexture()
		local name = v83.Name
		local v84 = IsVerminia() and "/SF/Language/Vendor/ThankYouPopupBrewedTitle" or v80
		v82 = mMovie:__wf_atom_8e9ac384(v84, false, { NAME = name })
	end

	if v21.mState == v21.mStates.RETUNE then
		v82 = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/AspectCrafted", false)
		tuvalPortraitIcon = icon
	end

	module2.ShowThankYouPopup(mMovie, thankYouPopupCraftedIcon, tuvalPortraitIcon, v82, mBurstFx, ThankYouPopupEnd, v81)
end

function RushCompleteConfirmCallback(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(v31) then
		if __wf_atom_7e8ad928(v31.RecipeId) then
			print("ERROR: Invalid RecipeID, ItemName: " .. v31.Type:__wf_atom_5b41f63b())
			LogBug("Invalid RecipeID for during foundry transaction")
		else
			assert(MongoId():Parse(v31.RecipeId))
			ClaimIndividualItem(v31.RecipeId, true)
		end
	end
end

function ClaimOrRush()
	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v31.CompletionDate)
	local v80 = __wf_atom_db2b0cee <= 0
	v44 = v31.Type:__wf_atom_5b41f63b()

	if v80 then
		ClaimIndividualItem(v31.RecipeId, false)
		return
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v31.ResultStoreItem:__wf_atom_014a76a2():c_str(), false)
	local price = "<PREMIUM_CURRENCY>" .. module3.CalculateRushCost(
		v31.StoreItem:__wf_atom_f046a222(),
		v31.StoreItem:__wf_atom_ed1be18b(),
		__wf_atom_db2b0cee
	)
	local colorHTMLMessage = module3.ColorHTMLMessage("/SF/Language/Crafting/Foundry_RushCraftingConfirm", {
		NAME = __wf_atom_8e9ac384,
		PRICE = price
	})
	module.ShowConfirmMessage(
		colorHTMLMessage,
		"RushCompleteConfirmCallback",
		nil,
		"/SF/Language/Crafting/Foundry_RushCraftingConfirmHeading"
	)
end

function OnStartTitleRecipeResults(p, p2)
	if p then
		local decoded = cjson.decode(p2)
		local v80 = { MongoId(decoded.RecipeId["$oid"]) }
		SendClaimRequest(v80, false)
		ToggleLegendaryTitleSelectionMode(false)
	end
end

function TitleWeaponConfirm()
	if v23.mSelectedElement.BlankItem then
		local __wf_atom_5b41f63b = Resource("/SF/Types/Recipes/WeaponTitles/TitleRemoveBlueprint"):__wf_atom_5b41f63b()
		local kind = (v31.Weapon or v31).Type
		local v80 = v31.Weapon.RawItem.mItemId.mId .. ","
		local v81 = kind:__wf_atom_5b41f63b() .. ","
		gGameData:__wf_atom_8da8dbc6(__wf_atom_5b41f63b, v80, v81, 0, OnStartTitleRecipeResults, "")
	else
		local __wf_atom_5b41f63b = Resource("/SF/Types/Recipes/WeaponTitles/TitleChangeBlueprint"):__wf_atom_5b41f63b()
		local kind = v23.mSelectedElement.Type
		local kind2 = (v31.Weapon or v31).Type
		local v80 = not kind and "" or kind:__wf_atom_5b41f63b()
		local v81 = v31.Weapon.RawItem.mItemId.mId .. ",,"
		local v82 = kind2:__wf_atom_5b41f63b() .. "," .. v80 .. ","
		gGameData:__wf_atom_8da8dbc6(__wf_atom_5b41f63b, v81, v82, 0, OnStartTitleRecipeResults, "")
	end
end

function Craft()
	DoCraft()
end

function DoCraft(object, object2, p)
	if not (v31 ~= nil and (v29.mActive or p)) then
		return
	end

	if v21.mState == v21.mStates.CLAIM then
		ClaimOrRush()
	elseif
		v21.mState == v21.mStates.IMPROVE
		and v31.Weapon
		and v31.Weapon.RawItem
		and v31.Weapon.RawItem.mQuality == 6
	then
		flag4 = true
		weapon = v31
		UpgradedToLegendary(v31)
	else
		local __wf_atom_a4299765 = gGameData:__wf_atom_a4299765()

		if object then
			object:__wf_atom_5b41f63b()
		else
			v44 = v31.Type:__wf_atom_5b41f63b()
		end

		v42 = ""
		v43 = ""
		local v80

		if object2 then
			v80 = object2:__wf_atom_524145ba()
		else
			v80 = v31.StoreItem:__wf_atom_524145ba()
		end

		local locString = ""
		local v82 = 0
		local v83 = false

		for k, v84 in v80 do
			local name = ""
			local v85 = false

			if __wf_atom_7e8ad928(v84) or __wf_atom_7e8ad928(v84.mItemType) then
				continue
			end

			if v84.mItemType:IsA(__wf_atom_58a409f1) then
				if __wf_atom_7e8ad928(v37.UpgradeId) then
					if not __wf_atom_7e8ad928(v37.UpgradeType) then
						v43 ..= v37.UpgradeType
					end
				else
					v42 ..= v37.UpgradeId
				end

				if v37.UpgradeType ~= nil then
					local v86 = Resource(v37.UpgradeType)
					v83 = not __wf_atom_7e8ad928(v86)
						and v86:IsA(__wf_atom_16cdad3a)
						and v86:__wf_atom_f41df548()
						and true
						or v83
				end

				if #v37.Name > 0 then
					name = v37.Name
				end

				if v21.mState == v21.mStates.RETUNE then
					v85 = true
				end
			elseif v84.mItemType:IsA(__wf_atom_abf506db) and not v84.mItemType:IsA(v31.ResultItemType) then
				if v24 ~= nil then
					local mElement = v24.mElements[k]

					if mElement == nil or mElement.ItemId == nil then
						if v84.mItemType == v63 or v84.mItemType == v64 or v84.mItemType == v65 then
							v42 = v42
							v42 ..= v31.WeaponInfo.Id
							v43 ..= v37.UpgradeSkinSourceType
						end
					else
						v42 ..= mElement.ItemId
						name = mElement.Name
					end
				end
			elseif
				(v21.mState == v21.mStates.IMPROVE or v21.mState == v21.mStates.RETUNE)
				and v31.ResultItemType:IsA(v84.mItemType)
			then
				v85 = true
				v42 ..= v31.WeaponInfo.Id
				v43 ..= v31.ResultItemType:__wf_atom_5b41f63b()

				for i = 0, 6 - 1 do
					local __wf_atom_d21f18f2 = __wf_atom_a4299765:__wf_atom_d21f18f2(0, i)

					if v31.WeaponInfo.Id ~= __wf_atom_d21f18f2.mItem.mItemId.mId then
						continue
					end

					v49 = i
					v50 = __wf_atom_d21f18f2
				end
			elseif not v84.mItemType:IsA(__wf_atom_d5a2d4b7) then
				if v31.WeaponInfo == nil then
					v43 ..= v84.mItemType:__wf_atom_5b41f63b()
				else
					v42 ..= v31.WeaponInfo.Id

					for i = 0, 6 - 1 do
						local __wf_atom_d21f18f2 = __wf_atom_a4299765:__wf_atom_d21f18f2(0, i)

						if v31.WeaponInfo.Id ~= __wf_atom_d21f18f2.mItem.mItemId.mId then
							continue
						end

						v49 = i
						v50 = __wf_atom_d21f18f2
					end
				end
			end

			v42 ..= ","
			v43 ..= ","

			if #name == 0 then
				name = mMovie:__wf_atom_8e9ac384(Resource(v84.mItemType):__wf_atom_014a76a2():c_str(), false)
			end

			if v85 then
				continue
			end

			if #locString > 0 then
				locString ..= "\r\n"
			end

			locString ..= name .. " x" .. v84.mItemCount
		end

		if v21.mState == v21.mStates.RETUNE then
			v45.mOptionalSelection = v26.mSelectedElement.mTag
		end

		if v37 ~= nil then
			for _, v84 in v37.mFragmentsList do
				local mItem = v84.mItem

				if __wf_atom_7e8ad928(mItem) or __wf_atom_7e8ad928((mItem.mItemType:__wf_atom_5b41f63b())) then
					continue
				end

				if #locString > 0 then
					locString ..= "\r\n"
				end

				locString ..= v84.Name .. " x" .. v84.SelectedCount
				v82 -= v84.SelectedCount
			end
		end

		if v82 ~= 0 then
			print("selected fragment count doesnt match required fragment count")
			return
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v31.ResultStoreItem:__wf_atom_014a76a2():c_str(), false)
		local v84

		if v21.mState == v21.mStates.CRAFT or v21.mState == v21.mStates.REPEATABLE_CRAFT then
			v84 = "Foundry_BuildConfirm"
		elseif v21.mState == v21.mStates.SWAP then
			v84 = "Foundry_SwapConfirm"
		elseif v21.mState == v21.mStates.IMPROVE then
			v84 = "Foundry_ImproveConfirm"
		elseif v21.mState == v21.mStates.RETUNE then
			v84 = "Foundry_RetuneConfirm"
		else
			v84 = ""
		end

		local colorHTMLMessage = module3.ColorHTMLMessage("/SF/Language/Crafting/" .. v84, {
			NAME = __wf_atom_8e9ac384
		})
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_ReforgeWarning", false)

		if v83 and v21.mState == v21.mStates.SWAP then
			locString = __wf_atom_8e9ac384_2 .. "\r\n\r\n" .. locString
		end

		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.locString = locString
		dialogSettings.titleString = colorHTMLMessage

		if __wf_atom_7e8ad928(v29.mLabel) then
			dialogSettings.firstString = "/SF/Language/Crafting/Foundry_CraftAction"
		else
			dialogSettings.firstString = v29.mLabel
		end

		dialogSettings:SetCallback(OnCraftConfirm)
		gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
	end
end

function CanReforge()
	if __wf_atom_7e8ad928(_T.Foundry_AllowReforge) then
		return module8.GetAncestorRank(ancestorType) >= 1
	end

	return _T.Foundry_AllowReforge
end

function CanRetune()
	return module8.GetAncestorRank(ancestorType) >= 2
end

local function fn18()
	v40 = module8.GetAncestorRank(ancestorType)
end

fn = function(_)
	fn18()
	local v80 = {}
	local mRankProgress

	if
		__wf_atom_7e8ad928(ancestorType)
		or __wf_atom_7e8ad928(_T.Foundry_GetRankXP)
		or not _T.Foundry_GetRankXP[ancestorType:__wf_atom_5b41f63b()]
	then
		mRankProgress = 0
	else
		local v82 = Resource(ancestorType)
		local v83 = _T.Foundry_GetRankXP[ancestorType:__wf_atom_5b41f63b()]()
		v80.mLevel = module8.GetAncestorRank(ancestorType) + 1
		local v84 = not (v80.mLevel > 1) and 0 or v82:__wf_atom_071f014c(v80.mLevel - 1)
		local v85 = v82:__wf_atom_071f014c(v80.mLevel) - v84
		local v86 = v83 - v84
		mRankProgress = __wf_atom_421b01aa(v86 / v85, 0, 1) * 100
	end

	v80.mMovie = mMovie
	v80.mLabel = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/FoundryTitle", false)

	if _T.Foundry_Ancestor then
		v80.mLabel = mMovie:__wf_atom_8e9ac384(_T.Foundry_Ancestor:__wf_atom_014a76a2():c_str(), false)
	end

	v80.mLevel = v40 + 1
	v80.mRankProgress = mRankProgress
	v80.mMinWidth = 600

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v80)
	end

	if not __wf_atom_7e8ad928(v15[v21.mStates.SWAP]) and not v15[v21.mStates.SWAP].Enabled and CanReforge() then
		v15[v21.mStates.SWAP].Enabled = true
		v22:SetCategories(v15, nil, true)
	end

	if not __wf_atom_7e8ad928(v15[v21.mStates.RETUNE]) and not v15[v21.mStates.RETUNE].Enabled and CanRetune() then
		v15[v21.mStates.RETUNE].Enabled = true
		v22:SetCategories(v15, nil, true)
	end
end

local function fn19(data, data2)
	if data.mUpgrade.mAmpLevel ~= data2.mUpgrade.mAmpLevel then
		return data.mUpgrade.mAmpLevel > 1
	end

	if data.mUpgrade.mAmpLevel == 2 and data.Title == data2.Title then
		return data.CopyNumber < data2.CopyNumber
	end

	return data.Title < data2.Title
end

function GetAspectsFor(object)
	local result = {}

	for i = 1, object:__wf_atom_06f3cb74() do
		local __wf_atom_b9a1f18c = object:__wf_atom_b9a1f18c(i - 1)

		if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(__wf_atom_16cdad3a) then
			continue
		end

		local __wf_atom_2ed09791 = __wf_atom_b9a1f18c:__wf_atom_2ed09791(__wf_atom_b9a1f18c:__wf_atom_f298d802())

		if not (#__wf_atom_2ed09791 > 0) then
			continue
		end

		for _, mUpgrade in __wf_atom_2ed09791 do
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mUpgrade.mTitle, true)
			local mAmpLevel

			if __wf_atom_7e8ad928(mUpgrade.mAmpLevel) or not (mUpgrade.mAmpLevel > 1) then
				mAmpLevel = 1
			else
				__wf_atom_8e9ac384 ..= " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Stat_AspectMultiplier", true)
				mAmpLevel = mUpgrade.mAmpLevel
			end

			for j = 1, mAmpLevel do
				local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(mUpgrade.mDesc, true)
				local c_str = mUpgrade.mFaction:c_str()
				local icon2 = Resource(mUpgrade.mIconName)
				local factionBorderAndRippleColor, rippleColor = module3.GetFactionBorderAndRippleColorFromFactionName(c_str)
				local v83 = {
					Title = __wf_atom_8e9ac384,
					Name = __wf_atom_8e9ac384,
					Description = __wf_atom_8e9ac384_2,
					IconName = mUpgrade.mIconName,
					Faction = c_str,
					CustomEntry = true,
					mUpgrade = mUpgrade,
					mTag = mUpgrade.mTag,
					Icon = icon2,
					SkipDefaultMaterials = true,
					mVisRangeMaterials = {
						UnfocusedItem = factionBorderAndRippleColor,
						FocusedItem = factionBorderAndRippleColor
					},
					CopyNumber = j
				}

				if not __wf_atom_7e8ad928(mUpgrade.mAmpLevel) and mUpgrade.mAmpLevel > 1 then
					v83.RippleOutline = true
					v83.RippleColor = rippleColor
				end

				table.insert(result, v83)
			end
		end
	end

	table.sort(result, fn19)
	return result
end

function EndShowingAspects()
	mMovie:__wf_atom_e57658c2("AspectsOverlay", 12, 0)
end

local function fn20()
	__wf_atom_ec43d06e(mMovie, "AspectsOverlay", 8, { 12 }, { 100 }, 2, 0, function()
		v17 += 1

		if v17 > #v18 then
			ShowAspectDetails(v71)
			__wf_atom_ec43d06e(mMovie, "AspectsOverlay", 8, { 12 }, { 0 }, 0.1, 1, function()
				EndShowingAspects()
			end)
		else
			ShowAspect(v18[v17])
		end
	end)
end

function ShowAspect(p)
	mMovie:__wf_atom_48bd5a59("AspectsOverlay", "AspectName", 36, p.Title)
	mMovie:__wf_atom_c90af43a("AspectsOverlay.Icon", p.Icon)
	__wf_atom_ec43d06e(mMovie, "AspectsOverlay", 8, { 12 }, { 100 }, 0.1, 0, function()
		fn20()
	end)
end

function ShowGainedAspects()
	local id = v31.WeaponInfo.Id
	local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(id)
	local v80 = Resource(__wf_atom_0ff4b555.mItemType)
	local v81 = GetStoreItem(v80)
	local storeItemInfo = module5.GetStoreItemInfo(mMovie, v81, { ItemInfo = __wf_atom_0ff4b555 }, nil, nil, true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local weaponElementUpgradesAndFingerprints, v82 = module11.GetWeaponElementUpgradesAndFingerprints(storeItemInfo)

	if not __wf_atom_7e8ad928(v72) then
		v72()
		v72 = nil
	end

	v71, v72 = module11.CreateProxyWeapon(
		__wf_atom_c4f78a8f,
		__wf_atom_0ff4b555.mItemType,
		0,
		weaponElementUpgradesAndFingerprints,
		v82,
		nil,
		id,
		nil,
		nil
	)
	local v83 = GetAspectsFor(statWeapon)
	local v84 = GetAspectsFor(v71)
	local v85 = {}
	v18 = {}

	for _, v86 in ipairs(v84) do
		local flag8 = true

		for _, v88 in ipairs(v83) do
			if v88.Title ~= v86.Title then
				continue
			end

			flag8 = false
			break
		end

		if not flag8 then
			continue
		end

		table.insert(v18, v86)
		table.insert(v85, WeakResource(v86.IconName))
	end

	if #v18 == 0 then
		return
	end

	_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	asyncLoader:LoadMultipleResources("AspectIcons", v85, function()
		for i, v86 in ipairs(v18) do
			v86.Icon = Resource(v85[i])
		end

		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		v17 = 1
		ShowAspect(v18[v17])
	end)
end

function OnSaveLoadOutRebuild()
	module7.OnSaveLoadOutCompleteCommon("")
	flag7 = false
	flag3 = true
	module7.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
end

function OnSaveLoadOutShutdown()
	module7.OnSaveLoadOutCompleteCommon("")
	flag7 = false
end

function OnSuccessfulClaim(p)
	if not __wf_atom_7e8ad928(v49) then
		gGameData:__wf_atom_a4299765():__wf_atom_9a1772a3(0, v49, v50)
	end

	if flag4 then
		module.PlaySound(nameLegendaryConfirmSound)
	elseif __wf_atom_7e8ad928(foundry_NPC) or foundry_NPC ~= "Verminia" then
		module.PlaySound(craftClaimSound)
	else
		module.PlaySound(brewClaimSound)
	end

	fn(false)
	v49 = nil
	v50 = nil
	gGameData:__wf_atom_993aebc4(OnSaveLoadOutRebuild)
	v73 = false

	if flag5 and not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.InventoryChanges)) then
		local quality = ""

		if __wf_atom_7e8ad928(p.InventoryChanges.Melee) then
			if not __wf_atom_7e8ad928(p.InventoryChanges.LongGuns) then
				quality = p.InventoryChanges.LongGuns[1].Quality
			end
		else
			quality = p.InventoryChanges.Melee[1].Quality
		end

		if quality ~= "IQ_LEGENDARY" then
			flag5 = false
		end
	end

	if flag5 then
		flag5 = false
		v35 = true
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		v77 = gRegion:__wf_atom_0a6a5887(Symbol("Tuvalkane-CraftingLegendaryCin"))

		if not __wf_atom_7e8ad928(v77) then
			v77:PrefetchStreaming()
		end

		if not __wf_atom_7e8ad928(v77) then
			weapon = v31.Weapon
			v77:FirePort("StartPlaying")
			UpdateButtons()
		end
	elseif v21.mState == v21.mStates.IMPROVE or v21.mState == v21.mStates.RETUNE then
		if not flag4 then
			fn13()
		end

		ShowThankYouPopup()
		v35 = true
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	else
		fn13()
		ShowThankYouPopup()
		fn17()
	end
end

function OnClaimRecipesResult(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		local decoded = cjson.decode(p2)
		UpdateClaimableState()
		v22:SetActiveCategoryId(v22:GetActiveCategoryId())
		OnSuccessfulClaim(decoded)
	else
		flag5 = false
		print(p2)

		if tonumber(p2) == 5 and not v73 then
			ShowSlotPurchaseDialog(p2, function()
				v51:AddTimer(__wf_atom_fa1258d0(), function()
					if v36 ~= nil then
						v31 = v36
						local v80 = (__wf_atom_7e8ad928(v31.CompletionDate) and 0 or Engine.__wf_atom_db2b0cee(v31.CompletionDate)) <= 0

						if v31.RecipeId == nil then
							print("ERROR: nil id for item: " .. v31.FullName)
							LogBug("Nil recipe id passed to ClaimIndividualItem")
						end

						if v80 then
							ClaimIndividualItem(v31.RecipeId, false)
						else
							ClaimIndividualItem(v31.RecipeId, true)
						end
					end
				end)
			end)
		else
			v76 += 1

			if v76 < 2 then
				gGameData:__wf_atom_2a79b81d(v75, OnClaimRecipesResult, v74, fn16())
			else
				fn9(p2)
			end
		end

		v73 = false
	end
end

function SendClaimRequest(list, p)
	if #list > 0 then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		v76 = 0
		v74 = p
		v75 = list
		local v80 = v31

		if
			v21.mState == v21.mStates.IMPROVE
			and v80.Weapon
			and v80.Weapon.RawItem
			and v80.Weapon.RawItem.mQuality == 5
			and not flag4
		then
			flag5 = true
		end

		gGameData:__wf_atom_2a79b81d(v75, OnClaimRecipesResult, v74, fn16())
	end
end

function ClaimIndividualItem(p, p2)
	local v80 = {}
	table.insert(v80, MongoId(p))
	SendClaimRequest(v80, p2)
end

function ItemListClaim()
	local v80 = {}
	local v81 = nil
	v22:RunForAllElements(function(p)
		if p.Ready then
			table.insert(v80, MongoId(p.RecipeId))
			v81 = p
		end
	end)
	v73 = #v80 > 1

	if #v80 == 1 then
		SetPreviewRecipe(v81)
	end

	SendClaimRequest(v80, false)
end

local function fn21(state)
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.StoreItem) then
		return 0
	end

	local __wf_atom_ed1be18b = state.StoreItem:__wf_atom_ed1be18b()

	if __wf_atom_ed1be18b == 0 then
		return 1
	end

	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(state.CompletionDate)

	if __wf_atom_db2b0cee < 0 then
		return 1
	end

	return (__wf_atom_ed1be18b - __wf_atom_db2b0cee) / __wf_atom_ed1be18b
end

local function fn22()
	if __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v31.StoreItem) then
		return
	end

	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v31.CompletionDate)
	local v80 = __wf_atom_db2b0cee <= 0
	local price = "<PREMIUM_CURRENCY>" .. module3.CalculateRushCost(
		v31.StoreItem:__wf_atom_f046a222(),
		v31.StoreItem:__wf_atom_ed1be18b(),
		__wf_atom_db2b0cee
	)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_RushCraftingButton", true, {
		PRICE = price
	})
	UpdateClaimableState()
	v29:SetText(module.Ternary(v80, "/SF/Language/Crafting/Foundry_ClaimBtn", __wf_atom_8e9ac384))
	v29:SetVisible(true)
	v29:SetActive(true)
end

function ClearUpgradeSelection()
	v37 = {}
	v37.Curr = 0
	v37.Req = 1

	if not __wf_atom_7e8ad928(v24) then
		v24:Redraw(nil, true, true)
	end
end

local function fn23()
	if __wf_atom_7e8ad928(v31) then
		return
	end

	if v21.mState == v21.mStates.CLAIM then
		fn22()
		return
	end

	local v80 = __wf_atom_7e8ad928(v37) or v37.Curr >= v37.Req
	local v81

	if v80 and not __wf_atom_7e8ad928(v31.WeaponInfo) then
		local v82 = GetStoreItem(v31.WeaponInfo.JoineryItem)
		local storeItemInfo = module5.GetStoreItemInfo(mMovie, v82, nil, nil, nil, true)
		v81 = __wf_atom_7e8ad928(storeItemInfo) or storeItemInfo.Type ~= v37.Type
	else
		v81 = true
	end

	local v82 = true
	local craftWarning = ""
	local v84 = {}

	if not v31.IsWeapon then
		if v31.InProgress then
			craftWarning = "/SF/Language/Crafting/Foundry_CraftInProgress"
			v82 = false
		elseif v31.LockedTier then
			v84.RANK = v31.LockedTier
			craftWarning = "/SF/Language/Crafting/Foundry_CraftLockedTier"
			v82 = false
		elseif v31.Curr < v31.Req then
			v84.COUNT = v31.Curr
			v84.REQUIRED = v31.Req
			craftWarning = "/SF/Language/Crafting/Foundry_CraftInsufFragments"
			v82 = false
		elseif v31.CanAfford then
			if v31.HasRequiredMaterials then
				if v31.NoDuplicatesAllowed then
					craftWarning = "/SF/Language/Crafting/Foundry_DuplicateNotAllowed"
					v82 = false
				elseif v31.StackSizeCapped then
					craftWarning = "/SF/Language/Crafting/Foundry_CraftStackMaximum"
					v82 = false
				elseif v21.mState == v21.mStates.RETUNE then
					if __wf_atom_7e8ad928(v26.mSelectedElement) or __wf_atom_7e8ad928(v37.Type) then
						v82 = false
					elseif not __wf_atom_7e8ad928(v37.Type) and v37.Type:GetName() == v26.mSelectedElement.mTag then
						craftWarning = "/SF/Language/Crafting/Foundry_InvalidCraft"
						v82 = false
					end
				elseif (v31.IsRefining or v80) and v81 then
					if not v31.CanCraft then
						v82 = false
					end
				else
					v82 = false

					if v21.mState == v21.mStates.RETUNE then
						craftWarning = "/SF/Language/Crafting/Foundry_CraftSelectAspect"
					elseif v31.ResultStoreItem:IsA(__wf_atom_83c57a80) then
						craftWarning = "/SF/Language/Crafting/Foundry_CraftSelectArmorJoinery"
					else
						craftWarning = "/SF/Language/Crafting/Foundry_CraftSelectJoinery"
					end
				end
			else
				craftWarning = "/SF/Language/Crafting/Foundry_CraftInsufMats"
				v82 = false
			end
		else
			craftWarning = "/SF/Language/Crafting/Foundry_CraftInsufDracs"
			v82 = false
		end
	end

	mMovie:__wf_atom_7d7314f1("DetailsPanel.CraftWarning.text", craftWarning, v84)
	v29.CraftWarning = craftWarning
	v29:SetActive(v82)

	if craftWarning == "" then
		v29:SetVisible(true)
		local v85 = "/SF/Language/Crafting/" .. foundry_NPC

		if v21.mState == v21.mStates.CRAFT or v21.mState == v21.mStates.REPEATABLE_CRAFT then
			v85 ..= "_CraftBtn"
		elseif v21.mState == v21.mStates.SWAP then
			v85 ..= "_SwapBtn"
		elseif v21.mState == v21.mStates.IMPROVE then
			if v31.IsWeapon then
				v85 ..= "_ImproveLegendaryBtn"
			else
				v85 ..= "_ImproveBtn"
			end
		elseif v21.mState == v21.mStates.RETUNE then
			v85 ..= "_RetuneBtn"
		end

		v29:SetText(v85)
	else
		v29:SetVisible(false)
		v29:SetText("/SF/Language/Crafting/Foundry_CantCraft")
	end

	v24:Redraw(nil, true, true)
end

local function fn24(p)
	if p then
		mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 15, 420)
	else
		local mHeight = v28.mHeight
		mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 15, 483 - mHeight)
		mMovie:__wf_atom_e57658c2("DetailsPanel.StatsHolder", 1, v48 + 190 - mHeight)
	end

	if v21.mState == v21.mStates.IMPROVE or v21.mState == v21.mStates.SWAP then
		mMovie:__wf_atom_e57658c2("DetailsPanel.StatsHolder", 1, -420)
	end

	if v41 ~= nil then
		v41:SetScrollValue(0, false, true)
	end

	v41 = module12.CreateScrollBar(getfenv(1), "DetailsPanel.Scrollbar", {
		mClipToScroll = "DetailsPanel.Description",
		mVisRangeMaterials = { visRangeDetailsTextMat },
		mVisRangeFadeSize = 10
	})
end

local function fn25(p)
	if p then
		if v47 == nil then
			return
		end
	else
		v47 = {}
	end

	for i, v80 in ipairs({
		"Title",
		"ItemType",
		"Description",
		"Scrollbar",
		"CuringTime",
		"ProgressBar"
	}) do
		if p then
			local v81 = v47[i]
			mMovie:__wf_atom_7f57ab2f("DetailsPanel", v80, 13, v81)
		else
			v47[i] = mMovie:__wf_atom_bd8fa442("DetailsPanel", v80, 13)
			mMovie:__wf_atom_7f57ab2f("DetailsPanel", v80, 13, false)
		end
	end
end

local function fn26(_)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Materials", 1, 131)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Materials", 0, -221)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Materials", 6, 100)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Materials", 5, 100)
	v48 = -127
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "CuringTime", 1, 87)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 12, 100)
end

local function fn27(_)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.CuringTimeComponents.Timer", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.CuringTimeComponents.Time", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.BgAmount", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.BgAmount2", 13, true)
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.CostIcon", 0, -10)
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Cost", 0, 6)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.CuringTimeComponents.CostIcon.Coin", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime.CuringTimeComponents.Cost", 13, true)
	mMovie:__wf_atom_c90af43a("DetailsPanel.CuringTime.CuringTimeComponents.CostIcon.Coin", dracsIconTexture)
end

local function fn28()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.CuringTime.CuringTimeComponents.Timer", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.CuringTime.CuringTimeComponents.CostIcon", 14)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.CuringTime.CuringTimeComponents.Time", 40)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.CuringTime.CuringTimeComponents.Cost", 40)
	local half__wf_atom_5e6e15c8 = __wf_atom_5e6e15c8 / 2
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Timer", 0, half__wf_atom_5e6e15c8)
	local v81 = half__wf_atom_5e6e15c8 + __wf_atom_5e6e15c8 - 8
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Time", 0, v81)
	local v82 = v81 + __wf_atom_5e6e15c8_3 + 30
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.CostIcon", 0, v82)
	local v83 = v82 + __wf_atom_5e6e15c8_2 / 2
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Cost", 0, v83)
	local v84 = v83 + __wf_atom_5e6e15c8_4
	mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents", 0, -v84 / 2)
end

function ShowAspectDetails(object)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.AspectHolder", 13, v21.mState ~= v21.mStates.RETUNE)
	v25:RemoveElements(true, true)
	v26:RemoveElements(true, true)
	local v80 = GetAspectsFor(object)

	for _, v81 in ipairs(v80) do
		v25:AddElement(v81)
	end

	v34 = GetAspectsFor(object)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.RetuneDetails.AspectListHolder.AmpConnector" .. 1, 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.RetuneDetails.AspectListHolder.AmpConnector" .. 2, 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.RetuneDetails.AspectListHolder.AmpConnector" .. 3, 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.RetuneDetails.AspectListHolder.AmpConnector" .. 4, 13, false)
	local count = 0

	for i, v81 in ipairs(v34) do
		v26:AddElement(v81)
		count += 1

		if not (i % 2 == 0 and v81.mUpgrade.mAmpLevel > 1) then
			continue
		end

		local v82 = "DetailsPanel.RetuneDetails.AspectListHolder.AmpConnector" .. i / 2
		mMovie:__wf_atom_2dedec1a(v82, 13, true)
		mMovie:OverrideMaterial(v82, rippleMaterial)
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(v81.RippleColor or _G.UIColor_Yellow)
		mMovie:__wf_atom_1ca72041(
			v82,
			"RipplesColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(v82, "RippleSettings", 50, 2, 0.1, 0.5)
		mMovie:__wf_atom_1ca72041(v82, "RippleCenter", 2, -2, 0, 0)
		mMovie:__wf_atom_1ca72041(v82, "RippleAnimationSettings", 3, 3, 1, 0)
	end

	local v81 = v16[object:__wf_atom_966277ef() + 1]

	for _ = count + 1, v81 do
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/AddAspect", false)
		local v82 = {
			Title = __wf_atom_8e9ac384,
			Name = __wf_atom_8e9ac384,
			Description = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/AddAspectDescription", false),
			CustomEntry = true,
			Icon = nil
		}
		v26:AddElement(v82)
	end

	v25:Redraw(nil, true, true)
	v26:ResetElements()
	v26:Redraw(nil, true, true)
end

local function fn29(mQuality)
	local materialColor = module11.GetMaterialColorFromCraftwork(module3.GetQualityTag(mQuality))
	local textColor = module11.GetTextColorFromCraftwork(module3.GetQualityTag(mQuality))
	local qualityTexture = module3.GetQualityTexture(mQuality)
	local v80 = mQuality == "WORN" and 4664607 or textColor

	if materialColor then
		mMovie:__wf_atom_e57658c2("DetailsPanel.BgColorHeader", 11, materialColor)
	else
		mMovie:__wf_atom_e57658c2("DetailsPanel.BgColorHeader", 11, v11.BG)
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel.QualityDeco", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.BgColorHeader", 13, true)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgColorHeader", 12, 90)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QualityDeco", 11, v80)
	mMovie:__wf_atom_c90af43a("DetailsPanel.QualityDeco", qualityTexture)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailsPanel", 2)
	local visibilityCenter = module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8 - 100, true)
	local visibilitySize = module.GetVisibilitySize(mMovie, 50, true)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 80)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

local function fn30(state)
	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(state.CompletionDate)
	state.Progress = fn21(state)
	local v80

	if __wf_atom_db2b0cee > 0 then
		v80 = not __wf_atom_7e8ad928(state.Progress)
	else
		v80 = false
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel.ProgressBar", 13, v80)

	if v80 then
		mMovie:__wf_atom_e57658c2("DetailsPanel.ProgressBar.Bar.Cap", 0, 483 * state.Progress)
		mMovie:__wf_atom_e57658c2("DetailsPanel.ProgressBar.Bar.Fill", 14, 483 * state.Progress)
		mMovie:__wf_atom_50d60589(
			"DetailsPanel.ProgressBar.Time",
			36,
			module3.GetColloquialTime(mMovie, __wf_atom_db2b0cee, true, true)
		)
	end
end

local function fn31(state)
	if state == nil then
		__wf_atom_ec43d06e(mMovie, "DetailsPanel", 8, { 12 }, { 0 }, 0.2, 0, function()
			mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, false)
		end)
		return
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.AspectHolder", 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.RetuneDetails", 13, v21.mState == v21.mStates.RETUNE)
	local hasRequiredFragments = state.HasRequiredFragments or state.IsWeapon

	if __wf_atom_7e8ad928(hasRequiredFragments) then
		hasRequiredFragments = false
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel.StatsHolder", 13, hasRequiredFragments)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.Materials", 13, state.HasRequiredFragments and not state.IsWeapon)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime", 13, v21.mState ~= v21.mStates.CLAIM)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.ProgressBar", 13, false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local mItemType

	if state.IsWeapon then
		mItemType = state.RawItem.mItemType
	else
		mItemType = WeakResource(state.ResultItemType)
	end

	if v21.mState == v21.mStates.CLAIM then
		fn30(state)
	end

	if __wf_atom_7e8ad928(mItemType) then
		return
	end

	fn25(false)
	fn26(state)

	if v21.mState == v21.mStates.RETUNE then
		mMovie:__wf_atom_2dedec1a("DetailsPanel.StatsHolder", 13, false)
	end

	asyncLoader:LoadResource("UpdateDetails", mItemType, function(p)
		local v80 = Resource(p)

		if v80 ~= mItemType then
			return
		end

		__wf_atom_ec43d06e(mMovie, "DetailsPanel", 8, { 12 }, { 100 }, 0.2, 0, function()
			mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, true)
		end)

		if not __wf_atom_7e8ad928(v70) then
			v70()
			v70 = nil
		end

		fn25(true)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.QualityDeco", 13, false)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.BgColorHeader", 13, false)
		mMovie:__wf_atom_7f57ab2f("DetailsPanel", "LevelIndicator", 13, false)
		local v81

		if hasRequiredFragments then
			if __wf_atom_7e8ad928(v80) or not v80:IsA(__wf_atom_9df43583) then
				v28.mStatsToOnlyShow = nil
			else
				v28.mStatsToOnlyShow = {
					"MeleeSkill",
					"DamageType",
					"Total",
					"HeavyAttack",
					"CriticalChance",
					"Stat1",
					"Stat2",
					"Stat3",
					"Stat4",
					"Stat5",
					"AttuneType",
					"Origin"
				}
			end

			if
				v21.mState == v21.mStates.SWAP
				or v21.mState == v21.mStates.IMPROVE
				or v21.mState == v21.mStates.RETUNE
			then
				table.insert(v28.mStatsToOnlyShow, "Era")
				table.insert(v28.mStatsToOnlyShow, "Quality")

				if v21.mState == v21.mStates.IMPROVE then
					v28.mStatsToOnlyShow = {
						"MeleeSkill",
						"DamageType",
						"Total",
						"HeavyAttack",
						"CriticalChance",
						"Quality"
					}
				end

				local weaponElementUpgradesAndFingerprints, v82 = module11.GetWeaponElementUpgradesAndFingerprints(state)

				if not (__wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.WeaponInfo)) then
					if not __wf_atom_7e8ad928(state.WeaponInfo.JoineryItem) then
						table.insert(weaponElementUpgradesAndFingerprints, {
							mItemType = state.WeaponInfo.JoineryItem
						})
					end

					local mQuality, mCreator

					if __wf_atom_7e8ad928(state.Weapon) or __wf_atom_7e8ad928(state.Weapon.RawItem) then
						mQuality = 0
					else
						mQuality = state.Weapon.RawItem.mQuality
						mCreator = state.Weapon.RawItem.mCreator
						local _mUpgradeFingerprint = state.Weapon.RawItem.mUpgradeFingerprint
					end

					statWeapon, v70 = module11.CreateProxyWeapon(
						__wf_atom_c4f78a8f,
						v80,
						state.Weapon.Xp,
						weaponElementUpgradesAndFingerprints,
						v82,
						mQuality,
						state.WeaponInfo.Id,
						state.mShiny,
						mCreator
					)
					state.StatWeapon = statWeapon
					state.StatOwner = __wf_atom_c4f78a8f
					ShowAspectDetails(statWeapon)
					fn29(mQuality)
					mMovie:__wf_atom_7f57ab2f("DetailsPanel", "LevelIndicator", 13, true)
					module11.SetLevel(mMovie, "DetailsPanel.LevelIndicator", true, statWeapon, _G.UIColor_Beige)
					v28:SetType(statWeapon)

					if v21.mState == v21.mStates.IMPROVE and not state.IsWeapon then
						local v83 = mQuality + 1

						if not __wf_atom_7e8ad928(v72) then
							v72()
							v72 = nil
						end

						v71, v72 = module11.CreateProxyWeapon(
							__wf_atom_c4f78a8f,
							v80,
							state.Weapon.Xp,
							weaponElementUpgradesAndFingerprints,
							v82,
							v83,
							state.WeaponInfo.Id,
							state.mShiny,
							mCreator
						)
						v28:Compare(v71)
					end
				end
			else
				v28:SetType(v80, __wf_atom_c4f78a8f)
			end

			v81 = __wf_atom_7e8ad928(v28) or v28.mNumStats == 0
		else
			v81 = true
		end

		mMovie:__wf_atom_e57658c2("DetailsPanel.Stats", 12, 0)
		mMovie:__wf_atom_e57658c2("DetailsPanel.Kintsugi", 12, 0)
		__wf_atom_ec43d06e(mMovie, "DetailsPanel", 8, { 12 }, { 100 }, 0.2, 0)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v80:__wf_atom_014a76a2():c_str(), false)

		if not (__wf_atom_7e8ad928(state.Weapon) or __wf_atom_7e8ad928(state.Weapon.RawItem) or __wf_atom_7e8ad928(state.Weapon.RawItem.mTitleType)) then
			local mTitleType = state.Weapon.RawItem.mTitleType
			local __wf_atom_232fd31d = gGameRules:__wf_atom_964056fd():__wf_atom_232fd31d(mTitleType)
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), true) .. " (" .. __wf_atom_8e9ac384 .. ")"
		end

		mMovie:__wf_atom_50d60589("DetailsPanel.Title", 36, __wf_atom_8e9ac384)
		fn15(v80, 0.5)
		local localizedProductType = module3.GetLocalizedProductType(v80)
		mMovie:__wf_atom_50d60589("DetailsPanel.ItemType", 36, localizedProductType)
		mMovie:__wf_atom_e57658c2("DetailsPanel.ItemType", 44, v11.TEXT_FOCUSED)
		mMovie:__wf_atom_2dedec1a(
			"DetailsPanel.CuringTime.CuringTimeComponents.CostIcon.Slash",
			13,
			not state.CanAfford
		)
		fn27(state)

		if state.IsWeapon then
			mMovie:__wf_atom_50d60589("DetailsPanel.Description", 36, "")
			mMovie:__wf_atom_2dedec1a("DetailsPanel.ExclaimationMark", 13, false)
			mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime", 13, false)
		elseif state.HasRequiredFragments or v21.mState == v21.mStates.CLAIM then
			local storeItem = state.StoreItem
			local v82 = storeItem:__wf_atom_ed1be18b() or 0
			local __wf_atom_6276eba2 = storeItem:__wf_atom_6276eba2()
			local v83 = v82 > 0 and module3.GetColloquialTime(mMovie, v82, true, true)
				or Localize("/SF/Language/Crafting/Foundry_CuringTimeInstant", {})
			local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()

			if v21.mState == v21.mStates.SWAP or v21.mState == v21.mStates.IMPROVE then
				mMovie:__wf_atom_50d60589("DetailsPanel.Description", 36, "")
			else
				mMovie:__wf_atom_50d60589("DetailsPanel.Description", 36, state.LocalizedDesc)
			end

			mMovie:__wf_atom_50d60589(
				"DetailsPanel.CuringTime.Title",
				36,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CuringTimeTitle", false)
			)
			mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Time", 44, v11.TEXT_UNFOCUSED)
			mMovie:__wf_atom_50d60589("DetailsPanel.CuringTime.CuringTimeComponents.Time", 36, v83)
			mMovie:__wf_atom_50d60589(
				"DetailsPanel.CuringTime.CuringTimeComponents.Cost",
				36,
				module.FormatNumber(__wf_atom_6276eba2, 0)
			)
			mMovie:__wf_atom_e57658c2(
				"DetailsPanel.CuringTime.CuringTimeComponents.Cost",
				44,
				module.Ternary(__wf_atom_6276eba2 <= __wf_atom_7050e489, v11.TEXT_UNFOCUSED, v11.TEXT_FOCUSED)
			)
			mMovie:__wf_atom_2dedec1a("DetailsPanel.ExclaimationMark", 13, false)
		else
			mMovie:__wf_atom_50d60589(
				"DetailsPanel.Description",
				36,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_NotEnoughFragments", false)
			)
			mMovie:__wf_atom_e57658c2("DetailsPanel.CuringTime.CuringTimeComponents.Time", 44, v11.TEXT_UNFOCUSED)
			mMovie:__wf_atom_50d60589("DetailsPanel.CuringTime.CuringTimeComponents.Time", 36, "???")
			mMovie:__wf_atom_50d60589(
				"DetailsPanel.CuringTime.CuringTimeComponents.Cost",
				36,
				"<p><font color=\"#BCA783\">???</font></p>"
			)
			mMovie:__wf_atom_2dedec1a("DetailsPanel.ExclaimationMark", 13, false)
			mMovie:__wf_atom_2dedec1a("DetailsPanel.CuringTime", 13, false)
		end

		if v41 ~= nil then
			v41:SetScrollValue(0, false, true)
		end

		fn24(v81)
		fn28()
	end)
end

local function fn32(items, mItemType)
	for _, item in items do
		if item.mItemType == mItemType then
			return item
		end
	end

	return nil
end

local function fn33(data)
	v24:RemoveElements(true, true)
	v37 = { mClipName = "DetailsPanel.UpgradeElement", Icon = nil, Curr = 0, Req = 0 }
	local __wf_atom_524145ba = data.StoreItem:__wf_atom_524145ba()

	for _, v80 in __wf_atom_524145ba do
		local mItemType = v80.mItemType

		if __wf_atom_7e8ad928(mItemType) then
			__wf_atom_f2daf912("ERROR - Recipie has a null ingredient: " .. tostring(data.StoreItem:__wf_atom_5b41f63b()))
		elseif not mItemType:IsA(__wf_atom_58a409f1) then
			local v81 = GetStoreItem(v80.mItemType)

			if __wf_atom_7e8ad928(v81) then
				__wf_atom_f2daf912("ERROR - Ingredient missing store item: " .. tostring(v80.mItemType:__wf_atom_5b41f63b()))
			else
				local v82

				if mItemType:IsA(__wf_atom_abf506db) and not mItemType:IsA(data.ResultItemType) then
					v82 = module5.GetStoreItemInfo(mMovie, v81, nil, nil, nil, true)
					v82.Curr = inventory:__wf_atom_c9e583ca(v80.mItemType)
					v82.Req = v80.mItemCount
					local v83 = fn32(inventory:__wf_atom_71d5cc00(), v80.mItemType)

					if not __wf_atom_7e8ad928(v83) then
						v82.ItemId = tostring(v83.mItemId)
						v82.Name = v83.mItemName
					end
				else
					if mItemType:IsA(__wf_atom_d5a2d4b7) then
						v82 = module5.GetStoreItemInfo(mMovie, v81, nil, nil, nil, true)
						v82.Curr = inventory:__wf_atom_52fcdd65(v80.mItemType)
					else
						v82 = module5.GetStoreItemInfo(mMovie, v81, nil, nil, nil, true)
						v82.Curr = inventory:__wf_atom_c9e583ca(v80.mItemType)
					end

					v82.Req = v80.mItemCount
				end

				v82.MetaData = not v82.MetaData and {} or v82.MetaData
				v82.MetaData.HidePrice = true
				local flag8 = true

				if __wf_atom_7e8ad928(v82) then
					flag8 = false
				elseif
					data.ResultItemType:IsA(mItemType)
					and (v21.mState == v21.mStates.SWAP or v21.mState == v21.mStates.IMPROVE or v21.mState == v21.mStates.RETUNE)
				then
					flag8 = false
				end

				if flag8 then
					v24:AddElement(v82, true)
				end
			end
		end
	end

	if v21.mState == v21.mStates.SWAP or v21.mState == v21.mStates.RETUNE then
		v37 = {}
		v37.Curr = 0
		v37.Req = 1
	end

	if not data.IsRefining and v37.Req > 0 and v21.mState == v21.mStates.SWAP then
		local v80 = {
			SelectableElement = true,
			SelectableType = v13.JOINERY,
			Label = "/SF/Language/Crafting/Foundry_Joinery",
			NumberRequired = v37.Req
		}
		v24:AddElement(v80, true)
	end

	v24:Redraw(nil, true, true)
end

local function fn34(data, object)
	local __wf_atom_9b053089 = object:__wf_atom_9b053089()
	local v80

	if v6[__wf_atom_9b053089] then
		v80 = v20:__wf_atom_92ba339b(v6[__wf_atom_9b053089])
	else
		v80 = v20:__wf_atom_92ba339b(v5)
	end

	local mQuality = data.RawItem.mQuality
	local v81 = nil

	for _, v82 in ipairs(v80) do
		local __wf_atom_524145ba = v82:__wf_atom_524145ba()

		for _, v84 in ipairs(__wf_atom_524145ba) do
			if not (v84.mItemType:IsA(__wf_atom_9df43583) and mQuality == v84.mExactQualityRequired) then
				continue
			end

			v81 = v82
			break
		end
	end

	if __wf_atom_7e8ad928(v81) then
		return nil
	end

	local v82 = { mItemType = v81:GetItem(), mItemCount = 1 }
	local v83, _ = CreateRecipeElement(v82, {})
	v83.ResultItemType = data.Type
	v83.ResultStoreItem = GetStoreItem(data.Type)
	v83.WeaponInfo = { Id = data.RawItem.mItemId.mId }
	v83.Weapon = module5.GetStoreItemInfo(mMovie, v83.ResultStoreItem, { ItemInfo = data.RawItem }, nil, nil, true)
	v83.RawItem = data.RawItem
	v83.Icon = data.Icon
	v83.Equipped = data.Equipped
	return v83
end

function CreateRetuneRecipe(data, object)
	local __wf_atom_9b053089 = object:__wf_atom_9b053089()
	local v80

	if v9[__wf_atom_9b053089] then
		v80 = v20:__wf_atom_92ba339b(v9[__wf_atom_9b053089])
	else
		v80 = v20:__wf_atom_92ba339b(v8)
	end

	local v81 = { mItemType = v80[1]:GetItem(), mItemCount = 1 }
	local v82, _ = CreateRecipeElement(v81, {})
	v82.ResultItemType = data.Type
	v82.ResultStoreItem = GetStoreItem(data.Type)
	v82.WeaponInfo = { Id = data.RawItem.mItemId.mId }
	v82.Weapon = module5.GetStoreItemInfo(mMovie, v82.ResultStoreItem, { ItemInfo = data.RawItem }, nil, nil, true)
	v82.RawItem = data.RawItem
	v82.Icon = data.Icon
	v82.Equipped = data.Equipped
	return v82
end

function SetPreviewRecipe(state)
	if v36 == state then
		return
	end

	v31 = state
	v36 = state
	fn10()
	local v80 = state ~= nil

	if v80 and not state.IsWeapon then
		local __wf_atom_1dd35883 = state.StoreItem:__wf_atom_1dd35883()
		state.Curr = 1
		state.Req = 1

		if __wf_atom_1dd35883 > 1 then
			state.Curr = state.Count
			state.Req = __wf_atom_1dd35883
		end
	end

	fn31(state)

	if not v80 then
		return
	end

	if module2.MarkItemIsNew(state, false) then
		v22:Redraw(nil, true, true)
		flag7 = true
	end

	if v21.mState == v21.mStates.CLAIM then
		mMovie:__wf_atom_7d7314f1("DetailsPanel.CraftWarning.text", "")
	elseif state.IsWeapon then
		v24:RemoveElements(true, true)
		v24:Redraw(nil, true, true)
	else
		fn33(state)
		fn11(state.StoreItem)
	end

	fn23()
end

local function fn35(data, data2)
	if data.StateOrder ~= data2.StateOrder then
		return data.StateOrder < data2.StateOrder
	end

	if data.LockedTier ~= data2.LockedTier then
		return (data.LockedTier or 0) < (data2.LockedTier or 0)
	end

	if data.Header ~= data2.Header then
		return data.Header ~= nil
	end

	if data.Header and data2.Header then
		return false
	end

	if data.HasRequiredFragments ~= data2.HasRequiredFragments then
		return data.HasRequiredFragments
	end

	if not (data.HasRequiredFragments or data2.HasRequiredFragments) then
		local v80 = data.Count / data.FragmentsRequired
		local v81 = data2.Count / data2.FragmentsRequired

		if v80 ~= v81 then
			return v81 < v80
		end
	end

	if data.HasRequiredMaterials == data2.HasRequiredMaterials then
		return data.Name < data2.Name
	end

	return data.HasRequiredMaterials
end

local function fn36(data, data2)
	if data.LockedTier ~= data2.LockedTier then
		return (data.LockedTier or 0) < (data2.LockedTier or 0)
	end

	if data.Header == data2.Header then
		if data.Header and data2.Header then
			return data.TopHeader
		end

		if data.CanCraft ~= data2.CanCraft then
			return data.CanCraft
		end

		if data.HasRequiredMaterials == data2.HasRequiredMaterials then
			return data.Name < data2.Name
		end

		return data.HasRequiredMaterials
	else
		local ternary = module.Ternary(data.Header, data, data2)
		local ternary2 = module.Ternary(data.Header, data2, data)

		if ternary.TopHeader then
			return ternary == data
		end

		if ternary2.CanCraft then
			return ternary2 == data
		end

		return ternary2 == data2
	end
end

local function fn37(data, data2)
	if data.Header and data2.Header then
		return data.TopHeader
	end

	if data.Header == data2.Header then
		local v80 = Engine.__wf_atom_db2b0cee(data.CompletionDate) > 0
		local selected = Engine.__wf_atom_db2b0cee(data2.CompletionDate) > 0

		if v80 == selected then
			return data.Name < data2.Name
		end

		return selected
	else
		local ternary = module.Ternary(data.Header, data, data2)
		local ternary2 = module.Ternary(data.Header, data2, data)

		if ternary.TopHeader then
			return data.TopHeader == true
		end

		if Engine.__wf_atom_db2b0cee(ternary2.CompletionDate) > 0 then
			return data.Header
		end

		return data2.Header
	end
end

local function fn38(p, p2)
	if p.RawItem.mQuality > p2.RawItem.mQuality then
		return true
	end

	return not (p.RawItem.mQuality < p2.RawItem.mQuality) and p.Name < p2.Name
end

function UpdateClaimableState()
	local __wf_atom_8258ab89 = gGameData:__wf_atom_8258ab89()
	local v80, v81 = FilterClaimableRecipes(__wf_atom_8258ab89)

	if #v80 == 0 and #v81 == 0 then
		v15[v21.mStates.CLAIM].Enabled = false
	else
		v15[v21.mStates.CLAIM].Enabled = true
	end

	if #v80 == 0 then
		v15[v21.mStates.CLAIM].SpecialIcon = nil
	else
		v15[v21.mStates.CLAIM].SpecialIcon = newIcon
	end

	if not __wf_atom_7e8ad928(v22) then
		v22:SetCategories(v15, nil, true)
	end
end

local function fn39()
	v21 = {}
	v21.mStates = {
		CRAFT = 1,
		REPEATABLE_CRAFT = 2,
		IMPROVE = 3,
		SWAP = 4,
		RETUNE = 5,
		CLAIM = 6
	}
	v21.mState = nil
	v15[v21.mStates.CRAFT].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_Recipe"
	v15[v21.mStates.REPEATABLE_CRAFT].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_RepeatableRecipe"
	v15[v21.mStates.SWAP].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_Swap"
	v15[v21.mStates.IMPROVE].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_Improve"
	v15[v21.mStates.RETUNE].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_Retune"
	v15[v21.mStates.CLAIM].Name = "/SF/Language/Categories/" .. foundry_NPC .. "_Claim"

	if not CanReforge() then
		v15[v21.mStates.SWAP].Enabled = false
	end

	if not CanRetune() then
		v15[v21.mStates.RETUNE].Enabled = false
	end

	if not IsTuvalkane() then
		v15[v21.mStates.IMPROVE] = nil
		v15[v21.mStates.SWAP] = nil
		v15[v21.mStates.RETUNE] = nil
	end

	if IsVerminia() then
		v15[v21.mStates.REPEATABLE_CRAFT].IconIndex = 1
		v15[v21.mStates.CRAFT].IconIndex = 1
	end

	local module13 = require("EE.Interface.Components.ItemList")
	v22 = module13.Create(getfenv(1), "ListContainer", {})

	function v22:UpdateText(_)
		if self.mClipName == nil or self.Header then
			return
		end

		local subheading = ""

		if v21.mState == v21.mStates.CLAIM then
			local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(self.CompletionDate)
			local ready = __wf_atom_db2b0cee <= 0

			if ready then
				subheading ..= mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CraftingReady", false)
			else
				self.Progress = fn21(self)
				local v82 = math.ceil(__wf_atom_db2b0cee)
				subheading ..= module3.GetColloquialTime(mMovie, v82, true, true)
			end

			if ready ~= self.Ready then
				self.Ready = ready
				v22.ReadyChanged = true
			end
		end

		if self.Subheading ~= subheading then
			self.Subheading = subheading
			module4.Update(mMovie, self.mClipName, self)
		end
	end

	function v22.mOnSelectedCallback(p)
		if p.Header then
			return
		end

		v33 = p

		if v21.mState == v21.mStates.IMPROVE then
			if p.RawItem.mQuality == 6 then
				SetPreviewRecipe(p)
				UpdateButtons()
			else
				v32 = p
				asyncLoader:LoadResource("RecipeElement", p.RawItem.mItemType, function(p2)
					local v81 = fn34(p, Resource(p2))
					SetPreviewRecipe(v81)
					UpdateButtons()
				end)
			end
		elseif v21.mState == v21.mStates.RETUNE then
			v32 = p
			asyncLoader:LoadResource("RecipeElement", p.RawItem.mItemType, function(p2)
				local v80 = Resource(p2)
				local v81 = CreateRetuneRecipe(p, v80)
				SetPreviewRecipe(v81)
				UpdateButtons()
			end)
		else
			SetPreviewRecipe(p)
			UpdateButtons()
		end
	end

	function v22:mElementDrawCallback()
		if self.Header then
			self.Name = mMovie:__wf_atom_8e9ac384(self.Text, false, self.Args)
			return
		end

		if v21.mState == v21.mStates.CLAIM then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "CheckmarkIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "StatusText", 13, false)
		end

		if v21.mState ~= v21.mStates.IMPROVE and v21.mState ~= v21.mStates.RETUNE then
			return
		end

		mMovie:__wf_atom_7f57ab2f(self.mClipName, "CheckmarkIcon", 13, false)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "StatusText", 13, false)
	end

	function v22.RefreshCategory(object)
		local activeCategoryId = object:GetActiveCategoryId()
		SetState(activeCategoryId)
	end

	UpdateClaimableState()
	v22:SetCategories(v15, nil, true)
end

function IsVerminia()
	return foundry_NPC == "Verminia"
end

function IsTuvalkane()
	return foundry_NPC == "Foundry"
end

local function fn40(list)
	local v80 = false
	local v81 = false
	local v82 = false

	for i = 1, #list do
		local v83 = list[i]
		v80 = v80 or v83.CanCraft
		v81 = v81 or not v83.CanCraft and v83.HasRequiredFragments
		v82 = v82 or not v83.HasRequiredFragments
	end

	if v80 then
		local v83 = { Header = true, TopHeader = true, StateOrder = v12.COMPLETE }

		if IsVerminia() then
			v83.Text = "/SF/Language/Crafting/Foundry_BreweryRecipes"
		else
			v83.Text = "/SF/Language/Crafting/Foundry_CompletedRecipes"
		end

		table.insert(list, v83)
	end

	if v81 then
		table.insert(list, {
			Header = true,
			StateOrder = v12.LOCKED,
			Text = "/SF/Language/Crafting/Foundry_NotReady"
		})
	end

	if v82 then
		table.insert(list, {
			Header = true,
			StateOrder = v12.INCOMPLETE,
			Text = "/SF/Language/Crafting/Foundry_RecipeFragments"
		})
	end
end

local function fn41(list)
	local v80 = false
	local v81 = false

	for i = 1, #list do
		v80 = v80 or list[i].CanCraft
		v81 = v81 or not list[i].CanCraft
	end

	if v80 then
		table.insert(list, {
			Header = true,
			TopHeader = true,
			Text = "/SF/Language/Crafting/Foundry_CanAfford"
		})
	end

	if v81 then
		table.insert(list, { Header = true, Text = "/SF/Language/Crafting/Foundry_CantAfford" })
	end
end

local function fn42(list)
	local v80 = false
	local v81 = false

	for i = 1, #list do
		local v82 = list[i]

		if __wf_atom_7e8ad928(v82) or __wf_atom_7e8ad928(v82.CompletionDate) then
			continue
		end

		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v82.CompletionDate)
		v80 = v80 or __wf_atom_db2b0cee <= 0
		v81 = v81 or __wf_atom_db2b0cee > 0
	end

	if v80 then
		table.insert(list, {
			Header = true,
			TopHeader = true,
			Text = "/SF/Language/Crafting/Foundry_ReadyToClaimHeader"
		})
	end

	if v81 then
		table.insert(list, {
			Header = true,
			Text = "/SF/Language/Crafting/Foundry_InProgressHeader"
		})
	end
end

local function fn43(object)
	if not object then
		return 0
	end

	local __wf_atom_e622b3f6 = object:__wf_atom_e622b3f6()

	if __wf_atom_7e8ad928(__wf_atom_e622b3f6) then
		return 0
	end

	return __wf_atom_e622b3f6:__wf_atom_a8dac107() + 1
end

local function fn44(storeItemInfo)
	local resultStoreItem = storeItemInfo.ResultStoreItem

	if __wf_atom_7e8ad928(resultStoreItem) or __wf_atom_7e8ad928(storeItemInfo.Type) then
		return false
	end

	local item = resultStoreItem:GetItem()

	if item:IsA(__wf_atom_abf506db) or item:IsA(__wf_atom_d98e64fe) or storeItemInfo.Type:IsA(v2) then
		return false
	end

	return module7.CanPurchaseIfAlreadyOwned(resultStoreItem)
end

local function fn45(list, p)
	local __wf_atom_92ba339b = v20:__wf_atom_92ba339b(p)

	for _, v80 in __wf_atom_92ba339b do
		if v80:IsRefining() then
			continue
		end

		local __wf_atom_e622b3f6 = v80:__wf_atom_e622b3f6()

		if __wf_atom_7e8ad928(__wf_atom_e622b3f6) then
			continue
		end

		local item = v80:GetItem()
		local item2 = __wf_atom_e622b3f6:GetItem()

		if not (__wf_atom_7e8ad928(item) or __wf_atom_7e8ad928(item2)) then
			table.insert(list, { mItemType = item, mItemCount = 1 })
		end
	end
end

local function fn46(items, instance)
	for _, className in items do
		if not __wf_atom_7e8ad928(instance) and instance:IsA(className) then
			return true
		end
	end

	return false
end

local function fn47(mItemType)
	local v80 = foundry_NPC

	if not IsTuvalkane() then
		return fn46(v14[v80], mItemType)
	end

	for k, v81 in pairs(v14) do
		if k ~= v80 and fn46(v81, mItemType) then
			return false
		end
	end

	return true
end

local function fn48(p)
	local v80 = foundry_NPC
	local result = {}

	if p then
		for _, v81 in v14[v80] do
			fn45(result, v81)
		end
	end

	if __wf_atom_7e8ad928(inventory) then
		return result
	end

	local __wf_atom_49479502 = inventory:__wf_atom_49479502()

	for _, v81 in __wf_atom_49479502 do
		local v82 = GetStoreItem(v81.mItemType)

		if __wf_atom_7e8ad928(v82) or not fn47(v81.mItemType) or v82:__wf_atom_7a2dbfd5() ~= not p then
			continue
		end

		table.insert(result, v81)
	end

	return result
end

local function fn49()
	local __wf_atom_92ba339b = v20:__wf_atom_92ba339b(__wf_atom_3cecff09)
	local result = {}

	for _, v80 in __wf_atom_92ba339b do
		if v80:IsRefining() then
			continue
		end

		local v81 = false

		for k, list in pairs(v14) do
			if k == foundry_NPC then
				continue
			end

			for _, className in ipairs(list) do
				if not v80:GetItem():IsA(className) then
					continue
				end

				v81 = true
				break
			end
		end

		if v81 then
			continue
		end

		local __wf_atom_e622b3f6 = v80:__wf_atom_e622b3f6()

		if __wf_atom_7e8ad928(__wf_atom_e622b3f6) then
			continue
		end

		local item = v80:GetItem()
		local item2 = __wf_atom_e622b3f6:GetItem()

		if not (__wf_atom_7e8ad928(item) or __wf_atom_7e8ad928(item2)) then
			table.insert(result, { mItemType = item, mItemCount = 1 })
		end
	end

	return result
end

function FilterClaimableRecipes(list)
	local result = {}
	local result2 = {}

	if #list == 0 then
		return result, result2
	end

	for _, v80 in list do
		if not fn47(v80.mItemType) then
			continue
		end

		local copy = v80.mCompletionDate:Copy()

		if __wf_atom_7e8ad928(copy) then
			continue
		end

		if Engine.__wf_atom_db2b0cee(copy) <= 0 then
			table.insert(result, v80)
		else
			table.insert(result2, v80)
		end
	end

	return result, result2
end

function CreateRecipeElement(itemInfo, p)
	local v80 = GetStoreItem(itemInfo.mItemType)

	if __wf_atom_7e8ad928(v80) then
		return nil, nil
	end

	local storeItemInfo = module5.GetStoreItemInfo(mMovie, v80, { ItemInfo = itemInfo }, nil, nil, true)
	local v81 = nil
	storeItemInfo.HasRequiredFragments = false
	storeItemInfo.CanCraft = true
	storeItemInfo.AlreadyCrafted = false
	storeItemInfo.StackSizeCapped = false

	if storeItemInfo.ResultStoreItem then
		if storeItemInfo.NameUndecorated then
			storeItemInfo.Name = storeItemInfo.NameUndecorated
		end

		storeItemInfo.Icon = storeItemInfo.ResultStoreItem:GetIconTexture()

		if itemInfo.mItemType:IsA(v5) then
			storeItemInfo.Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/ImprovedWeapon", false)
			storeItemInfo.Icon = alreadyCraftedTexture
		end

		local __wf_atom_c9e583ca = inventory:__wf_atom_c9e583ca(storeItemInfo.ResultStoreItem:GetItem())
		storeItemInfo.AlreadyCrafted = __wf_atom_c9e583ca > 0
		storeItemInfo.AlreadyCrafted = storeItemInfo.AlreadyCrafted and v21.mState == v21.mStates.CRAFT

		if storeItemInfo.ResultStoreItem:__wf_atom_efa6f447() == 2 then
			local __wf_atom_de8272d7 = storeItemInfo.ResultStoreItem:__wf_atom_de8272d7()
			storeItemInfo.StackSizeCapped = __wf_atom_de8272d7 > 0 and __wf_atom_de8272d7 <= __wf_atom_c9e583ca
		end

		if IsVerminia() then
			storeItemInfo.ShowStatusIcon = false

			if storeItemInfo.AlreadyCrafted then
				storeItemInfo.Subheading = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedAmount", false, {
					COUNT = module.FormatNumber(__wf_atom_c9e583ca)
				})
			end
		else
			storeItemInfo.ShowStatusIcon = storeItemInfo.AlreadyCrafted
		end

		storeItemInfo.StatusIconScale = 100

		if storeItemInfo.AlreadyCrafted then
			if not v79 then
				return nil, nil
			end

			storeItemInfo.StatusIconRight = alreadyCraftedTexture
			storeItemInfo.StatusIconTooltip = mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Crafting/Foundry_AlreadyCrafted",
				false
			)

			if
				(v21.mState == v21.mStates.CRAFT or v21.mState == v21.mStates.REPEATABLE_CRAFT)
				and not fn44(storeItemInfo)
			then
				storeItemInfo.CanCraft = false
				storeItemInfo.NoDuplicatesAllowed = true
			end
		end
	end

	if v21.mState == v21.mStates.CLAIM then
		storeItemInfo.RecipeId = itemInfo.mId.mId
		storeItemInfo.CompletionDate = itemInfo.mCompletionDate:Copy()
		storeItemInfo.mBgRatio = 1
	else
		storeItemInfo.Count = itemInfo.mItemCount
		storeItemInfo.Ready = true
		storeItemInfo.HasRequiredMaterials = true
		storeItemInfo.InProgress = p[itemInfo.mItemType:__wf_atom_5b41f63b()] or false
		storeItemInfo.CanAfford = v80:__wf_atom_6276eba2() <= gGameData:__wf_atom_7050e489()
		storeItemInfo.FragmentsRequired = v80:__wf_atom_1dd35883()
		storeItemInfo.HasRequiredFragments = storeItemInfo.Count >= storeItemInfo.FragmentsRequired
		local lockedTier = fn43(v80)

		if v40 + 2 < lockedTier and (not _T.Foundry_IgnoreReforgeBlueprintRank or v21.mState ~= v21.mStates.SWAP) then
			storeItemInfo.LockedTier = lockedTier
		end

		if v80:__wf_atom_1dd35883() > storeItemInfo.Count then
			storeItemInfo.Ready = nil
		end

		local __wf_atom_524145ba = v80:__wf_atom_524145ba()

		for _, v83 in ipairs(__wf_atom_524145ba) do
			local mItemType = v83.mItemType

			if __wf_atom_7e8ad928(mItemType) then
				continue
			end

			local __wf_atom_c5566ef8 = v80:__wf_atom_c5566ef8()

			if __wf_atom_7e8ad928(__wf_atom_c5566ef8) then
				continue
			end

			if mItemType:IsA(__wf_atom_c5566ef8) or __wf_atom_c5566ef8:IsA(mItemType) then
				v81 = mItemType
			elseif mItemType:IsA(__wf_atom_58a409f1) then
				local v84 = { inventory:GetUpgrades(), inventory:__wf_atom_063f1444() }
				local flag8 = false

				for _, list in pairs(v84) do
					for _, v87 in ipairs(list) do
						if
							__wf_atom_7e8ad928(v87.mItemType)
							or not (v87.mItemCount > 0)
							or not v87.mItemType:IsA(mItemType)
						then
							continue
						end

						flag8 = true
						break
					end

					if flag8 then
						break
					end
				end

				if not flag8 then
					storeItemInfo.Ready = nil
				end
			elseif mItemType:IsA(__wf_atom_d5a2d4b7) then
				if inventory:__wf_atom_52fcdd65(mItemType) < v83.mItemCount then
					storeItemInfo.Ready = nil
					storeItemInfo.HasRequiredMaterials = false
				end
			elseif mItemType:IsA(__wf_atom_abf506db) then
				if fn32(inventory:__wf_atom_71d5cc00(), mItemType) == nil then
					storeItemInfo.Ready = nil
					storeItemInfo.HasRequiredMaterials = false
				end
			elseif inventory:__wf_atom_c9e583ca(mItemType) < v83.mItemCount then
				storeItemInfo.Ready = nil
				storeItemInfo.HasRequiredMaterials = false
			end
		end

		storeItemInfo.CanCraft = storeItemInfo.CanCraft
			and storeItemInfo.CanAfford
			and storeItemInfo.HasRequiredMaterials
			and storeItemInfo.HasRequiredFragments
			and not storeItemInfo.LockedTier
			and not storeItemInfo.StackSizeCapped
			and storeItemInfo.Ready

		if itemInfo.mIsRefining then
			storeItemInfo.StateOrder = v12.REFINING
			storeItemInfo.IsRefining = true
		elseif storeItemInfo.CanCraft then
			storeItemInfo.StateOrder = v12.COMPLETE
		elseif storeItemInfo.HasRequiredFragments then
			storeItemInfo.StateOrder = v12.LOCKED
		else
			storeItemInfo.StateOrder = v12.INCOMPLETE
		end

		if not storeItemInfo.CanAfford then
			storeItemInfo.Ready = nil
			return storeItemInfo, v81
		end
	end

	return storeItemInfo, v81
end

local function fn50(storeItemInfos, list, p, p2, p3)
	for _, itemInfo in ipairs(list) do
		local v81 = GetStoreItem(itemInfo.mItemType)

		if __wf_atom_7e8ad928(v81) then
			__wf_atom_f2daf912("ERROR - Missing store item for: " .. tostring(itemInfo.mItemType:__wf_atom_5b41f63b()))
		else
			local storeItemInfo = module5.GetStoreItemInfo(mMovie, v81, { ItemInfo = itemInfo }, nil, nil, true)
			storeItemInfo.IsWeapon = true
			storeItemInfo.HasRequiredFragments = true
			storeItemInfo.WeaponInfo = { Id = storeItemInfo.RawItem.mItemId.mId }
			storeItemInfo.Weapon = module5.GetStoreItemInfo(mMovie, v81, { ItemInfo = itemInfo }, nil, nil, true)

			if p2 then
				if storeItemInfo.Weapon.RawItem.mQuality ~= 6 then
					continue
				end
			else
				local _ = storeItemInfo.Weapon.RawItem.mQuality == 6
			end

			if not (p3 and __wf_atom_c67f9605:__wf_atom_7da755e9(itemInfo.mItemType, 0) > storeItemInfo.Rank) then
				if not __wf_atom_7e8ad928(p) and storeItemInfo.RawItem.mItemId == p.mItemId then
					storeItemInfo.Equipped = true
				end

				table.insert(storeItemInfos, storeItemInfo)
			end
		end
	end
end

local function fn51(p, p2, p3)
	local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
	fn50(p, inventory:__wf_atom_4259c789(), __wf_atom_c132f79b:__wf_atom_b369d77f(3), p2, p3)
	fn50(p, inventory:__wf_atom_4f67b86c(), __wf_atom_c132f79b:__wf_atom_b369d77f(2), p2, p3)
end

local function fn52(p)
	mMovie:__wf_atom_2dedec1a("ListNotification", 13, true)
	mMovie:__wf_atom_48bd5a59("ListNotification", "Label", 36, p)
end

function PopulateRecipeList()
	v22.ReadyChanged = true
	v22:RemoveElements(true, true)
	local __wf_atom_8258ab89 = gGameData:__wf_atom_8258ab89()
	local v80 = {}
	local v81 = false

	for i = 1, #__wf_atom_8258ab89 do
		if __wf_atom_7e8ad928(__wf_atom_8258ab89[i].mItemType) then
			local v82 = "ERROR - Bad item in pending recipes " .. __wf_atom_8258ab89[i].mId.mId
			__wf_atom_f2daf912(v82)
			LogBug(v82)
		else
			v80[__wf_atom_8258ab89[i].mItemType:__wf_atom_5b41f63b()] = true
		end
	end

	local v82 = {}
	local v83 = {}

	if v21.mState == v21.mStates.CRAFT then
		v82 = fn48(false)
	elseif v21.mState == v21.mStates.REPEATABLE_CRAFT then
		v82 = fn48(true)
	elseif v21.mState == v21.mStates.SWAP then
		if CanReforge() then
			v82 = fn49()
		else
			fn52(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CraftLockedTier", false, {
				RANK = 2
			}))
			v81 = true
		end
	elseif v21.mState == v21.mStates.CLAIM then
		local v84
		v82, v84 = FilterClaimableRecipes(__wf_atom_8258ab89)
		table.move(v84, 1, #v84, #v82 + 1, v82)

		if #v82 == 0 then
			fn52(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/NothingToClaim", false))
			v81 = true
		end
	elseif v21.mState == v21.mStates.IMPROVE then
		fn51(v83)
	elseif v21.mState == v21.mStates.RETUNE then
		if CanRetune() then
			fn51(v83, false, true)

			if __wf_atom_7e8ad928(v83) or #v83 == 0 then
				fn52(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/NoWeaponsToRetune", false))
				v81 = true
			end
		else
			fn52(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CraftLockedTier", false, {
				RANK = 3
			}))
			v81 = true
		end
	end

	local flag8 = false

	for _, v84 in ipairs(v82) do
		if __wf_atom_7e8ad928(v84.mItemType) or not (v21.mState == v21.mStates.CLAIM or v84.mItemCount ~= 0) then
			continue
		end

		local v85, resultItemType = CreateRecipeElement(v84, v80)

		if __wf_atom_7e8ad928(v85) or __wf_atom_7e8ad928(v85.ResultStoreItem) then
			print("Attempted to add invalid recipe: " .. v84.mItemType:__wf_atom_5b41f63b())
			flag8 = true
		elseif not v85.NoDuplicatesAllowed then
			if v21.mState == v21.mStates.SWAP and not resultItemType then
				print("ERROR: reforge recipe " .. v84.mItemType:__wf_atom_5b41f63b() .. " missing swap ingredient")
				flag8 = true
			elseif resultItemType == nil then
				if IsVerminia() and v85.StoreItem ~= nil then
					if v83[v85.StoreItem:__wf_atom_5b41f63b()] == true then
						print("Foundry - PopulateRecipeList - Skipping over duplicated potions")
					else
						v83[v85.StoreItem:__wf_atom_5b41f63b()] = true
						table.insert(v83, v85)
					end
				else
					table.insert(v83, v85)
				end
			else
				local __wf_atom_232fd31d = v20:__wf_atom_232fd31d(resultItemType)

				if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
					if v85.ResultItemType:IsA(resultItemType) then
						__wf_atom_232fd31d = v20:__wf_atom_232fd31d(v85.ResultItemType)
						resultItemType = v85.ResultItemType
					else
						print("ERROR: reforge recipe missing store item for ingredient " .. resultItemType:__wf_atom_5b41f63b())
						LogBug("No store item for reforge ingredient")
						continue
					end
				end

				v85.Name = mMovie:__wf_atom_8e9ac384(v85.StoreItem:__wf_atom_014a76a2():c_str(), false)
				local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
				local v86 = nil
				local __wf_atom_efa6f447 = __wf_atom_232fd31d:__wf_atom_efa6f447()
				local v87 = {}

				if __wf_atom_efa6f447 == 5 then
					v87 = inventory:__wf_atom_4259c789()
					v86 = __wf_atom_c132f79b:__wf_atom_b369d77f(3)
				elseif __wf_atom_efa6f447 == 6 then
					v87 = inventory:__wf_atom_71d5cc00()
				elseif __wf_atom_efa6f447 == 1 then
					v87 = inventory:__wf_atom_4f67b86c()
					v86 = __wf_atom_c132f79b:__wf_atom_b369d77f(2)
				end

				for i = 1, #v87 do
					if v87[i].mItemType ~= resultItemType then
						continue
					end

					local copyTable = module.CopyTable(v85)
					local itemInfo = v87[i]
					local mUpgradeType = itemInfo.mUpgradeType
					local v89 = Resource(mUpgradeType)
					local joinery = __wf_atom_7e8ad928(v89) and ""
						or mMovie:__wf_atom_8e9ac384(v89:__wf_atom_014a76a2():c_str(), false)
					copyTable.WeaponInfo = {
						Id = v87[i].mItemId.mId,
						UpgradeType = resultItemType,
						Joinery = joinery,
						JoineryItem = mUpgradeType
					}

					if itemInfo.mItemType:IsA(__wf_atom_9df43583) then
						local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(
							itemInfo.mXP,
							itemInfo.mItemType
						)
						copyTable.WeaponInfo.Level = __wf_atom_b4a75eaa
						local v91 = GetStoreItem(itemInfo.mItemType)
						copyTable.Weapon = module5.GetStoreItemInfo(
							mMovie,
							v91,
							{ ItemInfo = itemInfo },
							nil,
							nil,
							true
						)

						if not __wf_atom_7e8ad928(v86) and copyTable.Weapon.RawItem.mItemId == v86.mItemId then
							copyTable.Equipped = true
						end
					end

					table.insert(v83, copyTable)
				end
			end
		end
	end

	if flag8 then
		print("PopulateRecipeList encountered problems, see log for details")
	end

	if v21.mState == v21.mStates.CRAFT then
		fn40(v83)
		table.sort(v83, fn35)
	elseif v21.mState == v21.mStates.REPEATABLE_CRAFT then
		fn40(v83)
		table.sort(v83, fn35)
	elseif v21.mState == v21.mStates.SWAP then
		fn41(v83)
		table.sort(v83, fn36)
	elseif v21.mState == v21.mStates.CLAIM then
		fn42(v83)
		table.sort(v83, fn37)
	elseif v21.mState == v21.mStates.IMPROVE then
		table.sort(v83, fn38)
	elseif v21.mState == v21.mStates.RETUNE then
		table.sort(v83, fn38)
	end

	if #v83 == 0 and not v81 then
		fn52(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/NoneDiscovered", false))
	end

	for i, v84 in ipairs(v83) do
		if v84.Header then
			v84.listExtraY = -18
			v84.mHeight = 34
		else
			v84.mHeight = 90

			if v21.mState == v21.mStates.IMPROVE or v21.mState == v21.mStates.RETUNE then
				v84.mHeight = 96
			end
		end

		if not (__wf_atom_7e8ad928(v84.RawItem) or __wf_atom_7e8ad928(v84.RawItem.mTitleType)) then
			local mTitleType = v84.RawItem.mTitleType
			local __wf_atom_232fd31d = gGameRules:__wf_atom_964056fd():__wf_atom_232fd31d(mTitleType)
			v84.Name = mMovie:__wf_atom_8e9ac384(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), true) .. " (" .. v84.Name .. ")"
		end

		v22:AddElement(v83[i], true)
	end

	v22:Redraw(nil, true, true)
end

local function fn53(p, mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(p) then
		return false
	end

	if mItemType:IsA(p.mItemType) then
		return true
	end

	for _, className in pairs(p.mAlternativeItemTypes) do
		if mItemType:IsA(className) then
			return true
		end
	end

	return false
end

function SelectAspect(p, p2)
	local __wf_atom_de8272d7 = v7:__wf_atom_de8272d7()
	asyncLoader:LoadResource("AspectManifest", p, function(p3)
		local v80 = Resource(p3)
		fn4({
			BackgroundAlpha = 0.7,
			ShouldShowInfoTip = false,
			InfoTipHeading = "/SF/Language/Crafting/Foundry_NoJoinery_Title",
			InfoTipSubtext = "/SF/Language/Crafting/Foundry_NoJoinery_Description",
			Title = "/SF/Language/Crafting/Foundry_CraftSelectAspectTitle",
			Categories = {
				{
					ItemType = 4,
					SubType = WeakResource(v7),
					Name = "/SF/Language/Crafting/Foundry_ReqBtnSelect"
				}
			},
			ShowAllItemsCategory = false,
			ShowPauseMenu = false,
			ShowCurrency = false,
			ShowUnowned = true,
			OverrideShowInInventory = true,
			HideCount = true,
			FunctionFilter = function(p4)
				if __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v31.StoreItem) then
					return false
				end

				local v82 = Symbol(p4.mItemType:GetName())

				if not v80:__wf_atom_df4d2960(v82) or not __wf_atom_7e8ad928(p2) and v82 == Symbol(p2) then
					return false
				end

				for _, v83 in ipairs(v34) do
					if p4.mItemType:__wf_atom_5b41f63b() ~= "/SF/Types/Items/Aspects/Tempers/" .. v83.mTag then
						continue
					end

					if v83.mUpgrade.mAmpLevel >= 2 or not v80:__wf_atom_fc974e9f(v82) then
						return false
					end
				end

				return true
			end,
			IsSelectionBlocked = function(p4)
				if __wf_atom_7e8ad928(p4.mItemCount) or p4.mItemCount < __wf_atom_de8272d7 then
					local mItemCount = p4.mItemCount or 0
					return
						true,
						mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/AspectNotLearned", false, {
							COUNT = tostring(mItemCount),
							REQUIREMENT = __wf_atom_de8272d7
						}),
						{}
				else
					return false
				end
			end,
			OnItemSelected = function(data)
				local mItem = data.mItem
				v37 = module5.GetStoreItemInfo(mMovie, data.StoreItem, nil, nil, nil, true)
				v37.mClipName = "DetailsPanel.UpgradeElement"
				v37.Name = data.Name
				v37.LocalizedDesc = data.LocalizedDesc
				v37.Icon = data.Icon
				icon = data.Icon

				if
					__wf_atom_7e8ad928(mItem.mItemId)
					or mItem.mItemId:__wf_atom_b70c3343()
					or not mItem.mItemId:__wf_atom_8598f3a9()
				then
					v37.UpgradeType = mItem.mItemType:__wf_atom_5b41f63b()
				else
					v37.UpgradeId = mItem.mItemId.mId
				end

				v37.Req = 1
				v37.Curr = 1
				v24.mElementDrawCallback(v37)
				fn23()

				if not __wf_atom_7e8ad928(v72) then
					v72()
					v72 = nil
				end

				if not __wf_atom_7e8ad928(v26.mSelectedElement) then
					v26:RunForAllElements(function(state)
						if state.PreviousIcon then
							state.Icon = state.PreviousIcon
							state.Name = state.PreviousName
							state.LocalizedDesc = state.PreviousLocalizedDesc
							state.PreviousIcon = nil
							state.PreviousName = nil
							state.PreviousLocalizedDesc = nil
						end
					end)
					v26.mSelectedElement.PreviousIcon = v26.mSelectedElement.Icon
					v26.mSelectedElement.PreviousName = v26.mSelectedElement.Name
					v26.mSelectedElement.PreviousLocalizedDesc = v26.mSelectedElement.LocalizedDesc
					v26.mSelectedElement.Icon = data.Icon
					v26.mSelectedElement.Name = data.Name
					v26.mSelectedElement.LocalizedDesc = data.LocalizedDesc
					v26:Redraw(nil, true, true)
				end

				if v21.mState ~= v21.mStates.RETUNE or __wf_atom_7e8ad928(v28) then
					return true
				end

				local v82 = Resource(v33.ResultItemType)
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
				local v83 = {}
				table.insert(v83, { mItemType = data.Type })
				local mAspectFingerprint, mQuality, mCreator

				if __wf_atom_7e8ad928(v33.Weapon) or __wf_atom_7e8ad928(v33.Weapon.RawItem) then
					mQuality = 0
				else
					mQuality = v33.Weapon.RawItem.mQuality
					mCreator = v33.Weapon.RawItem.mCreator
					mAspectFingerprint = v33.Weapon.RawItem.mAspectFingerprint
				end

				local proxyWeapon, v84 = module11.CreateProxyWeapon(
					__wf_atom_c4f78a8f,
					v82,
					v33.Weapon.Xp,
					v83,
					mAspectFingerprint,
					mQuality,
					v33.WeaponInfo.Id,
					v33.mShiny,
					mCreator
				)
				v72 = v84
				v28:Compare(proxyWeapon)
				fn24(false)
				return true
			end
		})
	end)
end

function SelectFragmentsForDust()
	fn4({
		BackgroundAlpha = 0.7,
		ShouldShowInfoTip = false,
		Title = Localize("/SF/Language/Crafting/Foundry_SelectFragments", nil),
		Dust = true,
		Categories = {
			{ ItemType = 13 }
		},
		ShowAllItemsCategory = false,
		ShowPauseMenu = false,
		ShowCurrency = false,
		FunctionFilter = function(p)
			return p.mItemType:IsA(v) or p.mItemType:IsA(v4)
		end,
		OnItemSelected = function(_)
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 0
			dialogSettings.titleString = "WIP"
			dialogSettings.locString = "claim doesnt do anything yet"
			module.ShowCustomMessage(dialogSettings)
			return true
		end
	})
end

function SelectFragments(req)
	fn4({
		BackgroundAlpha = 0.7,
		ShouldShowInfoTip = false,
		Title = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_ReqBtnSelectFragments", false, {
			NUM = req
		}),
		NumberRequired = req,
		Categories = {
			{ ItemType = 13 }
		},
		ShowAllItemsCategory = false,
		ShowPauseMenu = false,
		ShowCurrency = false,
		FunctionFilter = function(p)
			if __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v31.StoreItem) then
				return false
			end

			local __wf_atom_524145ba = v31.StoreItem:__wf_atom_524145ba()

			for i = 1, #__wf_atom_524145ba do
				local v81 = __wf_atom_524145ba[i]

				if v81.mItemType:IsA(__wf_atom_3cecff09) and not p.mItemType:IsA(v81.mItemType) then
					return false
				end
			end

			return true
		end,
		OnItemSelected = function(mFragmentsList)
			local total2 = 0
			local localizedDesc = ""

			for _, v82 in mFragmentsList do
				total2 += v82.SelectedCount

				if #localizedDesc > 0 then
					localizedDesc ..= "\r"
				end

				localizedDesc ..= v82.SelectedCount .. "x " .. v82.Name
			end

			v37 = {}
			v37.mClipName = "DetailsPanel.UpgradeElement"
			v37.mFragmentsList = mFragmentsList
			v37.Req = req
			v37.Curr = total2
			v37.Icon = fragmentsTexture
			v37.Name = Localize("/SF/Language/Crafting/Foundry_SelectedFragments", nil)
			v37.LocalizedDesc = localizedDesc
			v37.CustomEntry = true
			v24.mElementDrawCallback(v37)
			fn23()
			return true
		end
	})
end

function SelectUpgrade()
	fn4({
		BackgroundAlpha = 0.7,
		ShouldShowInfoTip = false,
		InfoTipHeading = "/SF/Language/Crafting/Foundry_NoJoinery_Title",
		InfoTipSubtext = "/SF/Language/Crafting/Foundry_NoJoinery_Description",
		Title = "/SF/Language/Crafting/Foundry_ReqBtnSelect",
		Categories = {
			{
				ItemType = 4,
				Joinery = true,
				SubType = __wf_atom_16cdad3a,
				Name = "/SF/Language/Crafting/Foundry_ReqBtnSelect"
			}
		},
		ShowAllItemsCategory = false,
		ShowPauseMenu = false,
		ShowCurrency = false,
		FunctionFilter = function(p)
			if __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v31.StoreItem) then
				return false
			end

			local __wf_atom_524145ba = v31.StoreItem:__wf_atom_524145ba()

			for i = 1, #__wf_atom_524145ba do
				if
					fn53(__wf_atom_524145ba[i], p.mItemType)
					and (v21.mState ~= v21.mStates.SWAP or p.mItemType ~= v31.WeaponInfo.UpgradeType)
				then
					return true
				end
			end

			return false
		end,
		IsSelectionBlocked = function(p)
			local v81 = Resource(p.mItemType)

			if __wf_atom_7e8ad928(v81) then
				return false
			end

			if v81:IsA(__wf_atom_58a409f1) and v81:__wf_atom_f41df548() and v31.WeaponInfo.Level < 30 then
				return true, Localize("/SF/Language/Crafting/Foundry_BlessedJoineryLocked", nil)
			end

			return false
		end,
		OnItemSelected = function(data)
			local mItem = data.mItem
			v37 = module5.GetStoreItemInfo(mMovie, data.StoreItem, nil, nil, nil, true)
			v37.mClipName = "DetailsPanel.UpgradeElement"

			if
				__wf_atom_7e8ad928(mItem.mItemId)
				or mItem.mItemId:__wf_atom_b70c3343()
				or not mItem.mItemId:__wf_atom_8598f3a9()
			then
				v37.UpgradeType = mItem.mItemType:__wf_atom_5b41f63b()
			else
				v37.UpgradeId = mItem.mItemId.mId
			end

			v37.Req = 1
			v37.Curr = 1
			v24.mElementDrawCallback(v37)
			fn23()

			if not __wf_atom_7e8ad928(v72) then
				v72()
				v72 = nil
			end

			if v21.mState ~= v21.mStates.SWAP or __wf_atom_7e8ad928(v28) then
				return true
			end

			local v81 = Resource(v33.ResultItemType)
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local v82 = {}
			table.insert(v82, { mItemType = data.Type })
			local mAspectFingerprint, mQuality, mCreator

			if __wf_atom_7e8ad928(v33.Weapon) or __wf_atom_7e8ad928(v33.Weapon.RawItem) then
				mQuality = 0
			else
				mQuality = v33.Weapon.RawItem.mQuality
				mCreator = v33.Weapon.RawItem.mCreator
				mAspectFingerprint = v33.Weapon.RawItem.mAspectFingerprint
			end

			local proxyWeapon, v83 = module11.CreateProxyWeapon(
				__wf_atom_c4f78a8f,
				v81,
				v33.Weapon.Xp,
				v82,
				mAspectFingerprint,
				mQuality,
				v33.WeaponInfo.Id,
				v33.mShiny,
				mCreator
			)
			v72 = v83
			v28:Compare(proxyWeapon)
			fn24(false)
			return true
		end
	})
end

local function fn54()
	local module13 = require("EE.Interface.Components.List")
	v24 = module13.CreateList(mMovie, "DetailsPanel.Materials.Element")
	v24:SetCallbacks("MaterialSelected", "MaterialFocused", "MaterialUnfocused")
	v24.mForcedHorizontalSeparation = 124
	v24.mForcedVerticalSeparation = 0

	function v24.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "Bg", 12, 70)
		mMovie:__wf_atom_4c1c1986(p, "Bg", 11, _G.UIColor_Black)
		mMovie:__wf_atom_7f57ab2f(p, "Amount", 54, true)
		mMovie:__wf_atom_4c1c1986(p, "Amount", 44, _G.UIColor_Yellow)
		mMovie:__wf_atom_c90af43a(p .. ".Bg2", gridItemTextures[3])
	end

	v24._CalculateX = v24.CalculateX

	function v24.CalculateX(object, p)
		return object:_CalculateX(p) + math.max(
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.Description", 14) - (object:_CalculateX({
				mIndex = #object.mElements + 1
			}) - object:_CalculateX({ mIndex = 1 })),
			0
		) / 2
	end

	function v24.mOnFocusedCallback(data)
		module.PlaySound(_G.UISound_Focus)
		local infoPopup_Data

		if data.SelectableElement then
			if flag then
				local ternary = module.Ternary(data.SelectableType == v13.JOINERY, 5, 8)
				mMovie:__wf_atom_c90af43a(data.mClipName .. ".Border", gridItemTextures[ternary])

				if v37 == nil then
					infoPopup_Data = data
				else
					infoPopup_Data = v37
				end
			else
				infoPopup_Data = data
			end
		else
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg2", 13, true)
			infoPopup_Data = data
		end

		module2.SetItemInfoPopupRect(
			mMovie,
			infoPopup_Data,
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 2),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 3),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 14),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 15)
		)
		_T.InfoPopup_Data = infoPopup_Data
	end

	function v24.mOnUnfocusedCallback(data)
		if data.SelectableElement then
			local ternary = module.Ternary(data.SelectableType == v13.JOINERY, 4, 7)
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Border", gridItemTextures[ternary])
		else
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg2", 13, false)
		end

		_T.InfoPopup_Data = nil
	end

	function v24.mElementDrawCallback(data)
		if data.SelectableElement then
			if __wf_atom_7e8ad928(v37) or __wf_atom_7e8ad928(v37.Name) then
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 50)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, _G.UIColor_Black)
			else
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 70)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, v11.ICON_BG)
			end

			mMovie:__wf_atom_48bd5a59(data.mClipName, "Amount", 36, mMovie:__wf_atom_8e9ac384(data.Label, false))
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Amount", 44, v11.TEXT_FOCUSED)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon", 13, not __wf_atom_7e8ad928(v37.Icon))
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", v37.Icon)
			local ternary = module.Ternary(data.SelectableType == v13.JOINERY, 4, 7)
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Border", gridItemTextures[ternary])
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".BorderB", gridItemTextures[ternary])
		else
			local v80 = data.Curr >= data.Req
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Status", 13, v80)
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Border", gridItemTextures[module.Ternary(v80, 6, 1)])
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".BorderB", gridItemTextures[module.Ternary(v80, 6, 1)])
			local overrideLabel = module3.GetHTMLAmountText(data.Curr, data.Req)

			if not __wf_atom_7e8ad928(data.OverrideLabel) then
				overrideLabel = data.OverrideLabel
			end

			mMovie:__wf_atom_48bd5a59(data.mClipName, "Amount", 36, overrideLabel)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon", 13, not __wf_atom_7e8ad928(data.Icon))
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", data.Icon)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg2", 13, false)

			if v80 then
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 70)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, 16777215)
			else
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 20)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, 8355711)
			end

			mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, v11.ICON_BG)
		end
	end

	function v24.mOnSelectedCallback(data)
		if data.SelectableElement and flag then
			if data.SelectableType == v13.JOINERY then
				SelectUpgrade()
			elseif data.SelectableType == v13.FRAGMENTS then
				SelectFragments(data.NumberRequired)
			elseif data.SelectableType == v13.ASPECT then
				local v80

				if not __wf_atom_7e8ad928(v26.mSelectedElement) then
					v80 = v26.mSelectedElement.mTag
				end

				SelectAspect(v33.RawItem.mAspectType, v80)
			end

			module.PlaySound(_G.UISound_ButtonSelect)
		end
	end

	v24.mClipCreatedCallback("DetailsPanel.UpgradeElement")
	fn10()
end

function ShownKnownTempers()
	if __wf_atom_7e8ad928(v27) or __wf_atom_7e8ad928(v20) then
		return
	end

	v27:RemoveElements(true, true)
	v27:Redraw(nil, true, true)
end

local function fn55()
	local module13 = require("EE.Interface.Components.ItemGrid")
	v27 = module13.Create(getfenv(1), "InventoryGrid", {
		mColumns = 4,
		mCanSelectItem = true,
		mScrollAlwaysVisible = false
	})
end

local function fn56()
	fn54()
	mMovie:__wf_atom_e57658c2("DetailsPanel.CraftWarning", 44, v11.TEXT_FOCUSED)
	mMovie:__wf_atom_2dedec1a("ListNotification", 13, false)
	mMovie:__wf_atom_e57658c2("ListNotification.Label", 44, v11.TEXT_UNFOCUSED)
	local module13 = require("SF.Interface.Components.Button")
	v29 = module13.Create(mMovie, "DetailsPanel.CraftBtn", "", "Craft")
	v29:SetVariant(module13.VARIANTS.SPECIAL_BUTTON)
	v29:SetAnchor(module.CENTER_ALIGNED)
	v30 = module13.Create(mMovie, "RankUpChoiceContainer.ConfirmBtn", "", "TitleWeaponConfirm")
	v30:SetVariant(module13.VARIANTS.SPECIAL_BUTTON)
	v30:SetAnchor(module.CENTER_ALIGNED)
	v30:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Menu_Confirm", true))
	UpdateConfirmTitleBtn()
	mMovie:OverrideMaterial("DetailsPanel.Description", visRangeDetailsTextMat)
	mMovie:__wf_atom_c90af43a("DetailsPanel.ExclaimationMark", exclaimationTexture)
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgFill", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgFill", 12, 95)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgEnd", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgEnd", 12, 95)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgStart", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgStart", 12, 95)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QualityDeco", 12, 50)
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgColorHeader", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("RankUpChoiceContainer.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("RankUpChoiceContainer.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("RankUpChoiceContainer.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgFill", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgFill", 12, 85)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgEnd", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgEnd", 12, 85)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgStart", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.BgStart", 12, 85)
	mMovie:__wf_atom_e57658c2("RankUpChoiceContainer.Title", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a("RankUpChoiceContainer.Title", 52, true)
	mMovie:__wf_atom_e57658c2("DetailsPanel.ProgressBar.Bar.Fill", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("DetailsPanel.ProgressBar.Bar.Bg", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("DetailsPanel.ProgressBar.Time", 44, v11.TEXT_UNFOCUSED)
	local module14 = require("SF.Interface.Components.ThemedStats")
	v28 = module14.Create(mMovie, "DetailsPanel.StatsHolder.ItemStats")
	v28.mLockHeightToMax = true
	v28.mGrowDownward = true
	v28.mCanFocusStats = true
	v28:SetBorderPadding(3)
	v28:SetWidth(507)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Title", 44, v11.TEXT_FOCUSED)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.Title", 54, true)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 44, v11.TEXT_UNFOCUSED)
	mMovie:__wf_atom_c90af43a("AspectsOverlay.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("AspectsOverlay.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("AspectsOverlay.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgFill", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgFill", 12, 90)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgEnd", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgEnd", 12, 90)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgStart", 11, v11.BG)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.BgStart", 12, 90)
	mMovie:__wf_atom_e57658c2("AspectsOverlay.AspectName", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a("AspectsOverlay.AspectName", 54, true)
	mMovie:__wf_atom_e57658c2("AspectsOverlay", 12, 0)
	mMovie:__wf_atom_4c1c1986("DetailsPanel.RetuneDetails", "WeaponStatsShort", 44, _G.UIColor_Gold)
	mMovie:__wf_atom_48bd5a59(
		"DetailsPanel.RetuneDetails",
		"WeaponStatsShort",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/WeaponStatsSubtitle", true)
	)
	mMovie:__wf_atom_4c1c1986(
		"DetailsPanel.RetuneDetails",
		"WeaponStatsBtn",
		14,
		mMovie:__wf_atom_cfc41e35("DetailsPanel.RetuneDetails", "WeaponStatsShort", 40) + 10
	)
	mMovie:SetCallbacks(
		"DetailsPanel.RetuneDetails.WeaponStatsBtn",
		"WeaponStatsRollOver",
		"WeaponStatsRollOut",
		nil,
		nil
	)
	mMovie:__wf_atom_4c1c1986("DetailsPanel.RetuneDetails", "SelectTempersInstruction", 44, _G.UIColor_Gold)
	mMovie:__wf_atom_48bd5a59(
		"DetailsPanel.RetuneDetails",
		"SelectTempersInstruction",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/SelectTempersToRetune", true)
	)
	local module15 = require("SF.Interface.Libs.AspectList")
	v26 = module15.Create(getfenv(1), "DetailsPanel.RetuneDetails.AspectListHolder.AspectElementHolder.Element")
	v26.mVisibleElements = 8
	v26.mItemInfoPopupRect = {
		X = mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgStart", 2) + 60,
		Y = mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgStart", 3) + 200,
		W = mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgStart", 14),
		H = mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgStart", 15)
	}

	function v26.mOnSelectedCallback(_)
		fn23()
		local v80

		if not __wf_atom_7e8ad928(v26.mSelectedElement) then
			v80 = v26.mSelectedElement.mTag
		end

		SelectAspect(v33.RawItem.mAspectType, v80)
	end

	local module16 = require("EE.Interface.Components.Grid")
	v25 = module16.CreateNewGrid(getfenv(1), "DetailsPanel.AspectHolder.IconComponent")
	v25.mColumns = 4
	v25.mRows = 2
	v25.mColumnSeparation = 130
	v25.mRowSeparation = 130

	function v25.mElementDrawCallback(p)
		module6.Initialize(mMovie, p.mClipName, p)
	end

	function v25.mOnFocusedCallback(infoPopup_Data)
		module2.SetItemInfoPopupRect(
			mMovie,
			infoPopup_Data,
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 2),
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 3),
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 14),
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 15)
		)
		_T.InfoPopup_Data = infoPopup_Data
	end

	function v25.mOnUnfocusedCallback(_)
		_T.InfoPopup_Data = nil
	end
end

local function fn57()
	_T.Foundry_NPC = nil
	_T.Foundry_Ancestor = nil
	_T.Foundry_NoCamera = nil
	_T.Foundry_AllowReforge = nil
	_T.Foundry_IgnoreReforgeBlueprintRank = nil
	_T.VendorTransmissionSet = nil
end

local function fn58()
	if _T.Foundry_Ancestor then
		ancestorType = _T.Foundry_Ancestor
	end
end

local function fn59(__wf_atom_c4f78a8f)
	v53 = gRegion:__wf_atom_0a6a5887(Symbol("WeaponPreviewCam"))
	v56 = gRegion:__wf_atom_0a6a5887(Symbol("LegsArmorPreviewCam"))
	v54 = gRegion:__wf_atom_0a6a5887(Symbol("ChestArmorPreviewCam"))
	v55 = gRegion:__wf_atom_0a6a5887(Symbol("HelmArmorPreviewCam"))
	v57 = gRegion:__wf_atom_0a6a5887(Symbol("TotemItemPreviewCam"))
	v67 = gRegion:__wf_atom_0a6a5887(Symbol("CraftingWeaponPreviewDeco"))
	v67:SetVisibility(false)
	v68 = gRegion:__wf_atom_0a6a5887(Symbol("CraftingPactPreviewDeco"))
	v68:SetVisibility(false)
	v60 = gRegion:__wf_atom_0a6a5887(Symbol("DressFormNPC"))

	if not __wf_atom_7e8ad928(v60) then
		v61 = v60:__wf_atom_ee8ec43b()

		if __wf_atom_7e8ad928(v61) then
			local __wf_atom_a5040fdf = v60:__wf_atom_a5040fdf()
			local __wf_atom_f582136d = v60:__wf_atom_f582136d(__wf_atom_7e616794)

			for i = 1, #__wf_atom_f582136d do
				if __wf_atom_f582136d[i]:IsA(__wf_atom_b39fdada) or __wf_atom_f582136d[i] == v60 then
					continue
				end

				print("Destroying: " .. __wf_atom_f582136d[i]:__wf_atom_5b41f63b())
				__wf_atom_a5040fdf:__wf_atom_dd1e4d10(__wf_atom_f582136d[i])
			end

			v61 = __wf_atom_a5040fdf:CreateObject(v62, v60)
			v60:__wf_atom_46a652a2(v61)
		end

		v59 = v61:__wf_atom_eb82ab1f()
		v59.mAllowUglyMode = true
		v61:__wf_atom_3a5c844c(v60)
		v61:__wf_atom_34a8a27a(__wf_atom_c4f78a8f)
	end
end

local function fn60(_, p)
	v58 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaCauldrenCamera"))

	if not (__wf_atom_7e8ad928(v58) or __wf_atom_7e8ad928(v52) or v52:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = v52:__wf_atom_1b3db7e0()
		v52:__wf_atom_fd14c463(0)
		v52:SetCameraSpot(v58, p)
		v52:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end
end

local function fn61()
	mMovie:__wf_atom_e57658c2("ThankYouPopup", 12, 0)
	mMovie:__wf_atom_50d60589(
		"ThankYouPopup.Text",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ThankYouPopupTitle", false)
	)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Text", 44, 14524216)
	mMovie:OverrideMaterial("ThankYouPopup.Glow.Shadow", mRankUpBgMaterial)
	mMovie:OverrideMaterial("ThankYouPopup.Glow.Mist", mRankUpBgMaterial)
end

function ToggleLegendaryTitleSelectionMode(p)
	mMovie:__wf_atom_2dedec1a("RankUpChoiceContainer", 13, p)
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, not p)
	v41:SetEnabled(not p)
	v22.mScrollBar:SetEnabled(not p)
	mMovie:__wf_atom_2dedec1a("ListContainer", 13, not p)
end

local function fn62(object)
	if object == nil then
		return nil
	end

	local __wf_atom_14f475b6 = __wf_atom_539492fe:__wf_atom_14f475b6()
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	local v80 = "SF/Types/Challenges/Titles/" .. string.match(__wf_atom_5b41f63b, "([^/]+)$") .. "Challenge"
	local v81 = string.gsub(v80, "^/", "")

	for _, v82 in pairs(__wf_atom_14f475b6) do
		local __wf_atom_5b41f63b2 = v82:__wf_atom_5b41f63b()
		local v83 = string.gsub(__wf_atom_5b41f63b2, "^/", "")

		if string.gsub(v83, "TitleChallenge.*$", "TitleChallenge") == v81 then
			return v82
		end
	end

	return nil
end

function UpgradedToLegendary(p)
	v23.mSelectedElement = nil
	v23:RemoveElements(true, true)
	flag4 = true
	UpdateButtons()
	ToggleLegendaryTitleSelectionMode(true)
	mMovie:__wf_atom_50d60589(
		"RankUpChoiceContainer.Title",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Titles/NameWeapon", true, {
			WEAPON = mMovie:__wf_atom_8e9ac384(p.Name, true)
		})
	)
	mMovie:__wf_atom_e57658c2(
		"RankUpChoiceContainer.Title",
		1,
		mMovie:__wf_atom_5e6e15c8("RankUpChoiceContainer.Divider", 1) - mMovie:__wf_atom_5e6e15c8("RankUpChoiceContainer.Title", 41) * 0.8 - 25
	)
	local __wf_atom_da43e3f3 = gGameData:GetInventory():__wf_atom_da43e3f3()
	local v80 = WeakResource("/SF/Types/Items/TitleItem")
	local __wf_atom_caa82b8d = v20:__wf_atom_caa82b8d(v80)

	for i = #__wf_atom_da43e3f3, 1, -1 do
		if not (__wf_atom_7e8ad928(__wf_atom_da43e3f3[i].mItemType) or not __wf_atom_da43e3f3[i].mItemType:IsA(v80)) then
			continue
		end

		table.remove(__wf_atom_da43e3f3, i)
	end

	local v81 = {}
	local v82 = {}

	for _, v83 in ipairs(__wf_atom_caa82b8d) do
		local flag8 = true

		for _, v84 in ipairs(__wf_atom_da43e3f3) do
			if v20:__wf_atom_232fd31d(v84.mItemType) == v83 then
				flag8 = false
			end
		end

		local storeItemInfo = module5.GetStoreItemInfo(mMovie, v83, nil, nil, nil, true)
		storeItemInfo.DisableSelection = flag8
		local v84 = fn62(v83)
		local v85 = v84 and v84:__wf_atom_a8ef27d6():c_str()

		if v85 then
			local v86 = math.max(
				__wf_atom_539492fe:__wf_atom_c74ddda3(v84:GetName()),
				v84:__wf_atom_91fb9157(gRegion:__wf_atom_eab484a7())
			)
			local __wf_atom_6570772a = v84:__wf_atom_6570772a()
			local v87 = math.min(v86, __wf_atom_6570772a)
			storeItemInfo.Subheading = mMovie:__wf_atom_8e9ac384(v85, true, {
				PROGRESS = module.FormatNumber(v87),
				REQUIRED = module.FormatNumber(__wf_atom_6570772a)
			})
		end

		local v86

		if flag8 then
			v86 = v81
		else
			v86 = v82
		end

		table.insert(v86, storeItemInfo)
	end

	v23:AddElement({ Name = "/SF/Language/Titles/EmptyTitle", BlankItem = true }, true)

	for _, v83 in ipairs(v82) do
		v23:AddElement(v83, true)
	end

	for _, v83 in ipairs(v81) do
		v23:AddElement(v83, true)
	end

	v23:Redraw(nil, true, true)
	UpdateConfirmTitleBtn()
end

function UpdateConfirmTitleBtn()
	local mSelectedElement = v23 and (v23.mSelectedElement or false)
	v30:SetActive(mSelectedElement)
end

function OnStats(p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:__wf_atom_9be88b01():SyncChallengeStats(p.mReviveCount, p.mCiphersSolved)
	end
end

function ForceChallengeUpdate()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	__wf_atom_18a5d83b:GetStatsFromServer(__wf_atom_18a5d83b:__wf_atom_e75653c3(), false, "OnStats")
end

function Initialize()
	if __wf_atom_7e8ad928(gGameData) then
		mMovie:Close()
		return
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(true)
	end

	local module13 = require("SF.Interface.Components.FloatingContentList")
	v23 = module13.Create(getfenv(1), "RankUpChoiceContainer.RankUpChoiceList", {
		mVisibleElements = 6
	})

	function v23.mOnSelectedCallback(p)
		if p == nil then
			return
		end

		UpdateConfirmTitleBtn()
	end

	function v23.mElementDrawCallback(p)
		if p == nil then
		end
	end

	mMovie:__wf_atom_2dedec1a("RankUpChoiceContainer", 13, false)
	local module14 = require("Lotus.Interface.Libs.TimerMgr")
	v51 = module14.CreateTimerMgr()
	v19 = module9.Create(mMovie)
	v19:Register(mMovie, "ThankYouPopup", { v19.ANCHOR_V_CENTRE, v19.ANCHOR_H_CENTRE })
	fn58()
	module3.ShowBackground({ mFade = module.LEFT_ALIGNED })
	module2.SetChatVisible(false)
	module3.CloseConsumablesOverlay()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not _T.Foundry_NoCamera then
		v52 = __wf_atom_c4f78a8f:CameraControl()
	end

	foundry_NPC = _T.Foundry_NPC or "Foundry"
	vendorDialougCamera = _T.VendorDialougCamera

	if IsVerminia() then
		fn60(__wf_atom_c4f78a8f, 0.5)
	else
		fn59(__wf_atom_c4f78a8f)
		v39 = module.PlaySound(loopingMusic)
	end

	v20 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	inventory = gGameData:GetInventory()
	module.PlaySound(enterSound)

	if _T.VendorTransmissionSet ~= nil then
		vendorTransmissionSet = _T.VendorTransmissionSet
	end

	module3.RegisterHideHudSelective(true)
	v11.TEXT_FOCUSED_HEX = module.ConvertColorNumberToHex(v11.TEXT_FOCUSED)
	v11.TEXT_UNFOCUSED_HEX = module.ConvertColorNumberToHex(v11.TEXT_UNFOCUSED)
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, false)
	fn18()
	fn55()
	fn56()
	fn39()
	fn61()
	ShownKnownTempers()
	fn(true)
	UpdateButtons()

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NIGHTFOLD_MENU_OPEN"), "FOUNDRY")
		__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_MENU_TIME"), "FOUNDRY_TOTAL")
	end

	if IsVerminia() then
		v22:SetActiveCategoryId(v21.mStates.REPEATABLE_CRAFT)
	end

	onViewportSizeChanged()
	ForceChallengeUpdate()
end

local function fn63()
	if v21 ~= nil and v21.mState == v21.mStates.CLAIM then
		local focusedElementIndex = v22:GetFocusedElementIndex()
		local count = 0
		v22:RunForAllElements(function(p)
			if not p.Ready then
				local v80 = focusedElementIndex ~= nil and focusedElementIndex == p.mIndex
				v22.UpdateText(p, v80)
			end

			if p.Ready then
				count += 1
			end
		end)

		if v22.ReadyChanged then
			v22.ReadyChanged = false
			mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_ClaimAmnt", true, {
				NUM = module.FormatNumber(count)
			})
			v22:ShowClaim(nil, "", count > 0)
		end
	end
end

local function fn64()
	v24:RunForAllElements(function(p)
		if not __wf_atom_7e8ad928(p) and not __wf_atom_7e8ad928(p.mClipName) and p.SelectableElement then
			local v80 = 1 - math.abs((math.sin(__wf_atom_4658d645(Time()) * 1 * 3.1415927410125732)))
			local v81 = not ((__wf_atom_7e8ad928(v37) or __wf_atom_7e8ad928(v37.FullName)) and flag) and 0 or v80
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Border", 5, __wf_atom_104bfe98(376.683, 395.51715, v81))
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Border", 6, __wf_atom_104bfe98(376.683, 395.51715, v81))
		end
	end)
end

function Update()
	local v80 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v80)
	asyncLoader:Update()

	if not __wf_atom_7e8ad928(v51) then
		v51:Update(v80)
	end

	fn63()

	if not __wf_atom_7e8ad928(v77) and not v77:__wf_atom_7d4910e4() and weapon then
		ShowThankYouPopup()
		v77 = nil
	end

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() and v40 ~= module8.GetAncestorRank(ancestorType) then
		fn(false)
	end

	if flag3 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e65461b9()) then
			flag3 = false
			PopulateRecipeList()
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

			if v35 and not __wf_atom_7e8ad928(v32) then
				v35 = false

				for _, mElement in v22.mElements do
					if mElement.UID ~= v32.UID then
						continue
					end

					v22.mOnSelectedCallback(mElement)
					break
				end
			end
		end
	end

	fn64()

	if v21.mState == v21.mStates.CLAIM and not __wf_atom_7e8ad928(v33) then
		fn30(v33)
	end

	total += __wf_atom_03df4e1d()
end

function Shutdown()
	module3.HideBackground()
	module2.SetChatVisible(true)
	_T.InfoPopup_Data = nil
	_T.gToolTip = nil

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("InteractTuvalkane"))

		if IsVerminia() then
			if not (__wf_atom_7e8ad928(v52) or v52:__wf_atom_c8c5ba0a()) then
				local __wf_atom_1b3db7e0 = v52:__wf_atom_1b3db7e0()
				v52:__wf_atom_fd14c463(0)
				v52:SetCameraSpot(vendorDialougCamera, 0.5)
				v52:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			if not (__wf_atom_7e8ad928(v52) or v52:__wf_atom_c8c5ba0a()) then
				local __wf_atom_1b3db7e0 = v52:__wf_atom_1b3db7e0()
				v52:__wf_atom_fd14c463(0)
				v52:SetCameraSpot(nil, 0.5)
				v52:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
			end

			__wf_atom_0a6a5887:Enable()

			if _T.FirstVendorInteraction == true then
				_T.FirstVendorInteraction = false
				local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BlacksmithVendor"))
				local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("ForgeStart"))

				if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_3)) then
					__wf_atom_0a6a5887_2:Teleport(
						__wf_atom_0a6a5887_3:GetPosition(),
						__wf_atom_0a6a5887_3:__wf_atom_dc309f8a()
					)
					__wf_atom_0a6a5887_2:PlayTriggeredAnim(Symbol("ToPokeIdle"))
					__wf_atom_0a6a5887_2:__wf_atom_d927a2a4(nil)
				end
			end
		end
	end

	if not __wf_atom_7e8ad928(v67) then
		v67:SetVisibility(false)
	end

	if flag2 and not (__wf_atom_7e8ad928(v59) or __wf_atom_7e8ad928(v61)) then
		v59:__wf_atom_632ac5b2()
		v61:SetCustomization(v59)
		v61:__wf_atom_315f6d55(v59)
		v61:__wf_atom_4325314c()
	end

	if not __wf_atom_7e8ad928(v38) then
		v38:Close()
		v38 = nil
	end

	if not __wf_atom_7e8ad928(v39) then
		v39:Stop(false)
		v39 = nil
	end

	if not __wf_atom_7e8ad928(v70) then
		v70()
		v70 = nil
	end

	if not __wf_atom_7e8ad928(v72) then
		v72()
		v72 = nil
	end

	fn57()
	module3.RegisterHideHudSelective(false)
	module.PlaySound(exitSound)
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:Execute("FoundryClosed", "")
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), "FOUNDRY_TOTAL")
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if flag7 then
		gGameData:__wf_atom_993aebc4(OnSaveLoadOutShutdown)
	end
end

function MaterialSelected(p)
	if not __wf_atom_7e8ad928(v24) then
		v24:SelectElementById(p)
	end
end

function MaterialFocused(p)
	if not __wf_atom_7e8ad928(v24) then
		v24:FocusElementById(p)
	end
end

function MaterialUnfocused(p)
	if not __wf_atom_7e8ad928(v24) then
		v24:UnfocusElementById(p)
	end
end

function AspectFocused(p)
	if not __wf_atom_7e8ad928(v25) then
		v25:FocusElementById(p)
	end
end

function AspectUnfocused(p)
	if not __wf_atom_7e8ad928(v25) then
		v25:UnfocusElementById(p)
	end
end

function WeaponStatsRollOver()
	if mMovie:__wf_atom_a91463a8("DetailsPanel.RetuneDetails", 13) then
		local infoPopup_Data = v32
		infoPopup_Data.StatWeapon = statWeapon
		module2.SetItemInfoPopupRect(
			mMovie,
			infoPopup_Data,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgFill", 2) + 50,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgFill", 3) + 360,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgFill", 14),
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.BgFill", 15)
		)
		_T.InfoPopup_Data = infoPopup_Data
	end

	mMovie:__wf_atom_4c1c1986("DetailsPanel.RetuneDetails", "WeaponStatsShort", 44, _G.UIColor_Yellow)
end

function WeaponStatsRollOut()
	_T.InfoPopup_Data = nil
	mMovie:__wf_atom_4c1c1986("DetailsPanel.RetuneDetails", "WeaponStatsShort", 44, _G.UIColor_Gold)
end

function ScaleMaterials()
	local v80 = {
		_G.UIMaterial_BorderMaterialDefault,
		_G.UIMaterial_BorderMaterialCassid,
		_G.UIMaterial_BorderMaterialDendrit,
		_G.UIMaterial_BorderMaterialFey,
		_G.UIMaterial_BorderMaterialMendicant,
		_G.UIMaterial_BorderMaterialOde
	}

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		module.ScaleSlicedMaterials(_T.BackgroundMovie, v80)
	end
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v19) then
		v19:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	ScaleMaterials()
	local screenDimensions, v80 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 15, v80)
end