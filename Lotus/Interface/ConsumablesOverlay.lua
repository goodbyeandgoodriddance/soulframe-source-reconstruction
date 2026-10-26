local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local module4 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local flag = true
local v3 = false
local v4 = nil
local v5 = nil
local v6 = true
local v7 = nil
local v8 = nil
local v9 = { X = 0, Y = 0 }
local mLeftStick = { X = 0, Y = 0 }
local v10 = true
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = {}
local v15 = 1
local v16 = false
local v17 = { "GearSpiral", "EmoteSpiral" }
local v18 = false
local v19 = false
local v20 = WeakResource("/Lotus/Types/Game/CrewShip/Ships/RailJack")
WeakResource("/Lotus/Types/Restoratives/ScenarioBeacon")
local v21 = WeakResource("/Lotus/Types/Enemies/Orokin/Entrati/EntratiTech/EntratiTechAvatar")

local function fn()
	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_f6d5276b(0)

		if not __wf_atom_7e8ad928(v13) then
			v13:__wf_atom_48e2de4b()
		end
	end

	v12 = nil
	mMovie:Close()
end

local function fn2()
	if Engine.__wf_atom_dd1285f1 and not __wf_atom_7e8ad928(_T.Touch_ShowAllIcons) then
		_T.Touch_ShowAllIcons(true)
	end

	flag = true
	module.PlaySound(_G.UISound_DialogClose)
	__wf_atom_ec43d06e(mMovie, "DescriptionPanel", 8, { 12 }, { 0 }, 0.25, 0)
	__wf_atom_ec43d06e(mMovie, "GearSpiral", 0, { 4, 12 }, { 5000, 0 }, 0.25, 0)
	__wf_atom_ec43d06e(mMovie, "EmoteSpiral", 0, { 4, 12 }, { 5000, 0 }, 0.25, 0)
	__wf_atom_ec43d06e(mMovie, "EmoteArrow", 0, { 12 }, { 0 }, 0.25, 0)
	__wf_atom_ec43d06e(mMovie, "TradePanel", 0, { 12 }, { 0 }, 0.25, 0, fn)
end

function Close()
	fn2()
end

function VisitWebsiteCallback(p)
	if tonumber(p) == 4 then
		module.DoOpenWebBrowser("https://soulframe.com/user")
		_T.Enabling2FA = true
	end

	if not __wf_atom_7e8ad928(mMovie) then
		fn2()
	end
end

local function fn3()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	return not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsA(v21))
end

local function fn4()
	if Engine.__wf_atom_fc67ba71() or __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_bc4c8046() then
		return nil
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/Lotus/Language/Dojo/TradeStartRequires2FA"
	dialogSettings.firstString = "/Lotus/Language/Dojo/EnableNow"
	dialogSettings.secondString = "/Lotus/Language/Dojo/EnableLater"
	dialogSettings:SetCallback("VisitWebsiteCallback")
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

local function fn5()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DescriptionPanel.Label", 3)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("DescriptionPanel.Label", 41)
	local visibilityCenter = module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 / 2, false)
	local visibilitySize = module.GetVisibilitySize(mMovie, __wf_atom_5e6e15c8_2, false)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 50)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

local function fn6()
	if __wf_atom_7e8ad928(v5) or not v5.mEditMode then
		return
	end

	local v22 = {}
	table.insert(v22, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = fn2,
		CallOut = "MENU_CANCEL"
	})

	if _T.SetButtons then
		_T.SetButtons(mMovie, v22, getfenv(1))
	end
end

function Shutdown()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(-1)
	end

	if not __wf_atom_7e8ad928(_T.ConsumablesOverlayClosedCallback) then
		_T.ConsumablesOverlayClosedCallback(v18, v19)
		_T.ConsumablesOverlayClosedCallback = nil
		_T.ConsumablesOverlayElementSelectedCallback = nil
	end

	if not (__wf_atom_7e8ad928(gGameRules) or v10) then
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
			print("ScopeDebug: Show from ConsumablesOverlay")
			__wf_atom_b56d2aa8:Execute("ShowReticle", "")
			__wf_atom_b56d2aa8:Execute("ShowAbilityDots", "")
		end
	end

	_T.TacticsOverlayTargetPlayer = nil
	_T.TacticsOverlayTargetCrew = nil
end

local function fn7(p, p2)
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(p, p2)
	__wf_atom_8e4fda44:__wf_atom_b005c93e(p, p2)
end

function VendorModePressed()
	if fn4() then
		mMovie:SetVisible(false)
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()

	if not playerAvatar:__wf_atom_7b686578() then
		if __wf_atom_7e8ad928(playerAvatar:__wf_atom_39bdffdf()) then
			if playerAvatar:__wf_atom_7bcdbf55(Symbol("Kneel")) then
				module.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileKneeling")
				fn2()
				return
			else
				playerAvatar:__wf_atom_b0f26b7e()
			end
		else
			module.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileDueling")
			fn2()
			return
		end
	end

	if not gGameRules:IsA(__wf_atom_e714d8ac) then
		fn2()
		return
	end

	local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

	if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
		__wf_atom_7be88783:Execute("ToggleVendor", "")
	end

	fn2()
end

function OnTrade(object)
	if fn4() or not gGameRules:IsA(__wf_atom_e714d8ac) then
		return
	end

	local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

	if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_7be88783:Execute("OnTrade", (__wf_atom_3d96ddcd:GetName()))
		end
	end
end

local function fn8(data, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	function _T.GetAllItems()
		local result = { not data.mInsertElementButton and {
				Categories = { 0 },
				EmptySlot = true
			} or nil }
		local __wf_atom_caa82b8d = v:__wf_atom_caa82b8d(p and __wf_atom_72bebce2 or __wf_atom_9ae7d6a1)
		local inventory = gGameData:GetInventory()
		local v22 = p and inventory:__wf_atom_6b29f1ed() or inventory:__wf_atom_da43e3f3()

		if __wf_atom_7e8ad928(__wf_atom_caa82b8d) then
			return result
		end

		for _, mStoreItem in ipairs(__wf_atom_caa82b8d) do
			local alwaysAvailable = mStoreItem:AlwaysAvailable()
			local mItemCount = module.Ternary(alwaysAvailable, 1, 0)
			local item = mStoreItem:GetItem()

			if not alwaysAvailable then
				for _, v23 in ipairs(v22) do
					if v23.mItemType ~= item then
						continue
					end

					alwaysAvailable = true

					if p then
						mItemCount = v23.mItemCount
					end

					break
				end
			end

			if not alwaysAvailable or module2.ShouldHideConsumable(item) then
				continue
			end

			table.insert(result, {
				Categories = { 0 },
				Type = item,
				mStoreItem = mStoreItem,
				Name = mMovie:__wf_atom_8e9ac384(tostring(mStoreItem:__wf_atom_014a76a2()), false),
				Count = mItemCount,
				ItemCount = mItemCount
			})
		end

		return result
	end

	function _T.GetItemSorting()
		local function fn9(p2, p3)
			if p2.EmptySlot == nil and p3.EmptySlot == nil then
				if p2.mPurchased ~= false and p3.mPurchased ~= false then
					return
				end

				return p2.mPurchased ~= false and p3.mPurchased == false
			else
				return p2.EmptySlot == true and p3.EmptySlot ~= true
			end
		end

		return {
			{
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortName", false),
				SortId = "NAME",
				Attribute = function(p2, p3)
					local v22 = fn9(p2, p3)

					if v22 == nil then
						return p2.Name < p3.Name
					end

					return v22
				end
			},
			{
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortType", false),
				SortId = "TYPE",
				Attribute = function(p2, p3)
					local v22 = fn9(p2, p3)

					if v22 ~= nil then
						return v22
					end

					if p2.Categories == nil or p2.Categories[1] == nil then
						return false
					end

					if p3.Categories == nil or p3.Categories[1] == nil then
						return true
					end

					if p2.Categories[1] == p3.Categories[1] then
						return p2.Name < p3.Name
					end

					return p2.Categories[1] < p3.Categories[1]
				end
			}
		}, "NAME"
	end

	function _T.GetItemCategories()
		return {
			{
				Category = 0,
				Name = Localize("/Lotus/Language/Menu/CategoryAll", {}),
				Icon = _G.UICategoryIcon_AllOn
			}
		}
	end

	function _T.BrowseItemsDone(list, _)
		mMovie:SetVisible(true)
		_T.GetAllItems = nil
		_T.GetItemSorting = nil
		_T.BrowseItemsDone = nil
		_T.GetItemCategories = nil
		v8 = nil

		if list ~= nil then
			local v22 = list[1]

			if v22 ~= nil then
				local v23 = p and v5 or v7
				v18 = v18 or p
				v19 = v19 or not p
				local v24, v25

				if __wf_atom_7e8ad928(v22.Type) or v22.Count == 0 then
					v24 = { EmptySlot = true }
				else
					local count

					if p then
						count = v22.Count or nil
					end

					local mItemType = Type(v22.Type)
					local mItem = Resource(v22.Type)

					if not __wf_atom_7e8ad928(v22.mStoreItem) then
						v25 = v22.mStoreItem:__wf_atom_6a6ada7b() or nil
					end

					v24 = {
						mItem = mItem,
						mItemType = mItemType,
						mStoreItem = v22.mStoreItem,
						Count = count
					}
				end

				v23:SetElement(v24, data.Id, v25)
			end
		end
	end

	mMovie:SetVisible(false)
	local v22 = {
		OwnedItems = _T.GetAllItems(),
		Type = data.mItem,
		["StoreItemId"] = p and 2 or nil
	}
	_T.ConsumablesOverlayElementSelectedCallback(v22, p)
end

local function fn9(p)
	if p == nil then
		__wf_atom_ec43d06e(mMovie, "DescriptionPanel", 8, { 12 }, { 0 }, 0.25, 0)
		return
	end

	__wf_atom_ec43d06e(mMovie, "DescriptionPanel", 8, { 12 }, { 100 }, 0.25, 0)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Label", 92, 6)
	mMovie:__wf_atom_50d60589("DescriptionPanel.Label", 97, "...")

	if p == "" then
		mMovie:__wf_atom_50d60589("DescriptionPanel.Label", 36, "")
	else
		mMovie:__wf_atom_50d60589("DescriptionPanel.Label", 36, Localize(p, {}))
	end

	fn5()
end

local function fn10(p)
	if __wf_atom_7e8ad928(p) then
		return 0
	end

	if p.Id <= 5 then
		return (module.ToRad((-p.Id - 2) * 36))
	end

	return (module.ToRad((p.Id + 2) * 36))
end

local function fn11()
	local module5 = require("Lotus.Interface.Components.GearSpiral")
	v7 = module5.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn9
	v7.mVisible = false
	v7.mLockedIcon = mMovie:__wf_atom_8e9ac384("<LOCKED>", true)
	v7.mDanceIcon = mMovie:__wf_atom_8e9ac384("<MELODY>", true)
	v7.mLooping = true

	function v7.CalculateAngle(_, p)
		return (fn10(p))
	end

	function v7.mOnFocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		module.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, _G.UIColor_MediumGrey)
	end

	function v7.mElementDrawCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
		end
	end

	function v7.mOnSelectedCallback(p)
		if
			__wf_atom_7e8ad928(p)
			or __wf_atom_7e8ad928(gRegion)
			or __wf_atom_7e8ad928(p.Data)
			or __wf_atom_7e8ad928(p.Data.mItem)
		then
			return
		end

		local tacticsOverlayTargetPlayer

		if not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer) then
			tacticsOverlayTargetPlayer = _T.TacticsOverlayTargetPlayer
		end

		if __wf_atom_7e8ad928(tacticsOverlayTargetPlayer) then
			tacticsOverlayTargetPlayer = gRegion:__wf_atom_eab484a7()
		end

		local transmission = tostring(p.Data.mItem:__wf_atom_5b41f63b())
		gMatchingService:SendSquadJsonMessage(cjson.encode({
			player = tacticsOverlayTargetPlayer:__wf_atom_6be84646(),
			transmission = transmission
		}))
		gRegion:__wf_atom_c4f78a8f():__wf_atom_1a73b1c2(tacticTransmissionsConfirm[__wf_atom_5784a397(1, #tacticTransmissionsConfirm)])
		fn2()
	end

	function v7.CalculateX(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
	end

	function v7.CalculateY(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 1)
	end

	function v7.SetupPreInterpolationValues(_, _) end

	v7.GetInterpolationProperties = v7.DefaultAlphaInterpolation
	v7.mIconMaterialOverride = smoothEdgeMaterial
	v7.mIconWidthOverride = 90
	v7.mIconHeightOverride = 60
	local __wf_atom_5d9ae734 = _T.TacticsOverlayTargetPlayer:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_5d9ae734()
	local tacticTransmissionsArchwing2

	if __wf_atom_7e8ad928(__wf_atom_5d9ae734) then
		tacticTransmissionsArchwing2 = tacticTransmissionsArchwing
	elseif __wf_atom_5d9ae734:IsA(v20) then
		tacticTransmissionsArchwing2 = tacticTransmissionsRailjack
	else
		tacticTransmissionsArchwing2 = tacticTransmissionsCrewShip
	end

	for i = 1, math.max(#tacticTransmissionsArchwing2, v7.MAX_RING_ITEMS) do
		local mItem

		if i <= #tacticTransmissionsArchwing2 then
			mItem = Resource(tacticTransmissionsArchwing2[i])
		end

		v7:AddElement({ mItem = mItem, mLocked = false })
	end

	v7:Initialize()
	table.insert(v14, v7)
	v15 = 2
end

local function fn12()
	local module5 = require("Lotus.Interface.Components.GearSpiral")
	v7 = module5.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn9
	v7.mVisible = false
	v7.mLockedIcon = mMovie:__wf_atom_8e9ac384("<LOCKED>", true)
	v7.mDanceIcon = mMovie:__wf_atom_8e9ac384("<MELODY>", true)
	v7.mLooping = true

	function v7.CalculateAngle(_, p)
		return (fn10(p))
	end

	function v7.mOnFocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		module.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, _G.UIColor_MediumGrey)
	end

	function v7.mElementDrawCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
		end
	end

	function v7.mOnSelectedCallback(p)
		if
			__wf_atom_7e8ad928(p)
			or __wf_atom_7e8ad928(gRegion)
			or __wf_atom_7e8ad928(p.Data)
			or __wf_atom_7e8ad928(p.Data.mCommandSymbol)
			or __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew)
		then
			return
		end

		if __wf_atom_7e8ad928((_T.TacticsOverlayTargetCrew:__wf_atom_30e3d82b())) then
			return
		end

		_T.TacticsOverlayCommand = p.Data.mCommandSymbol
		module.PlaySound(crewCommandSound)
		_T.TacticsOverlayTargetCrew:__wf_atom_51009507(v7.mCommandScriptRes, Symbol("SetBehavior"), false)
		fn2()
	end

	function v7.CalculateX(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
	end

	function v7.CalculateY(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 1)
	end

	function v7.SetupPreInterpolationValues(_, _) end

	v7.GetInterpolationProperties = v7.DefaultAlphaInterpolation
	v7.mIconMaterialOverride = smoothEdgeMaterial
	v7.mIconWidthOverride = 50
	v7.mIconHeightOverride = 50

	for i = 1, math.max(math.min(#crewCommandSymbols, #crewCommandIcons), v7.MAX_RING_ITEMS) do
		local v22 = { mIconOverride = crewCommandIcons[i], mLocked = false }
		v22.mCommandSymbol = crewCommandSymbols[i]
		v22.mNameOverride = crewCommandNames[i]
		v7:AddElement(v22)
	end

	v7:Initialize()
	table.insert(v14, v7)
	v15 = 2
end

local function fn13()
	if not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer) then
		fn11()
		return
	end

	if not __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew) then
		fn12()
		return
	end

	local module5 = require("Lotus.Interface.Components.GearSpiral")
	v7 = module5.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn9
	v7.mVisible = false
	v7.mLockedIcon = mMovie:__wf_atom_8e9ac384("<LOCKED>", true)
	v7.mDanceIcon = mMovie:__wf_atom_8e9ac384("<MELODY>", true)
	v7.mLooping = true

	function v7.CalculateAngle(_, p)
		return (fn10(p))
	end

	function v7.mOnFocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		module.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, _G.UIColor_MediumGrey)
	end

	function v7.mElementDrawCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		local data = p.Data or p
		local focusedElement = v7:GetFocusedElement()
		local v22 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id
		local mItem = data.mItem
		local v23 = not __wf_atom_7e8ad928(mItem)
		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", module.Ternary(v22, "Focused", "Unfocused"))
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, v22 and v23 and not Engine.IsPlayingWithController())
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Arrow", 11, _G.UIColor_Black)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, v22 and v23 and Engine.IsPlayingWithController())
		mMovie:__wf_atom_7d7314f1(p.mClipName .. ".Callout.Tf.text", "<MENU_SELECT>")
		local v24 = not v23 and "" or mMovie:__wf_atom_8e9ac384(mItem:__wf_atom_014a76a2():c_str(), true)

		if data.mLocked then
			v24 = v7.mLockedIcon .. " " .. v24
		end

		mMovie:__wf_atom_48bd5a59(p.mClipName, "Name", 46, "center")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Name", 89, true)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, module.Ternary(v22, _G.UIColor_Black, _G.UIColor_MediumGrey))
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 12, module.Ternary(data.mLocked, 80, 100))
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 12, module.Ternary(data.mLocked, 70, 100))
		mMovie:__wf_atom_48bd5a59(p.mClipName, "Name", 36, v24)
	end

	function v7.mOnSelectedCallback(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gRegion) then
			return
		end

		if v7.mEditMode then
			fn8(p.Data)
			return
		end

		local data = p.Data or p

		if data.mLocked or not p.Enabled then
			module.PlaySound(_G.UISound_Error)
			return
		end

		local mItem = data.mItem
		local v22 = gRegion:__wf_atom_e23b2855()[1]

		if not (__wf_atom_7e8ad928(v22) or __wf_atom_7e8ad928(mItem)) then
			local __wf_atom_50a7d83e = v22:__wf_atom_50a7d83e()

			if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_bedb4e3f() or __wf_atom_50a7d83e:__wf_atom_47fbd15c()) then
				if __wf_atom_50a7d83e:__wf_atom_1cfa7bd2() == mItem then
					mItem = nil
				end

				if
					__wf_atom_50a7d83e:IsA(__wf_atom_c0fefb76)
					and not __wf_atom_7e8ad928(mItem)
					and mItem:__wf_atom_c23aaa0d()
					or not __wf_atom_50a7d83e:__wf_atom_cf18e36d(mItem)
				then
					return
				end

				if _T.Kneeling then
					local nearestTagged = gRegion:FindNearestTagged(
						Symbol("KneelAction"),
						__wf_atom_50a7d83e:GetPosition()
					)

					if not __wf_atom_7e8ad928(nearestTagged) then
						__wf_atom_50a7d83e:__wf_atom_3e5bf6ab(nearestTagged)
					end
				end

				if fn3() then
					__wf_atom_539492fe:__wf_atom_c2038c7a(v22, Symbol("EMOTE_PLAYED"))
					__wf_atom_50a7d83e:__wf_atom_7ab15c94(mItem)

					if mItem ~= nil and not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
						__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("EMOTE_PLAYED"), mItem:__wf_atom_5b41f63b())
					end
				end
			end

			fn2()
		end
	end

	function v7.CalculateX(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
	end

	function v7.CalculateY(_, p)
		if __wf_atom_7e8ad928(p) then
			return 0
		end

		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 1)
	end

	function v7.SetupPreInterpolationValues(_, _) end

	function v7.GetInterpolationProperties(_, _)
		return { 12 }, { 100 }
	end

	local emotesList = emotesList
	local v22 = nil
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_eab484a7:__wf_atom_d25abf5f() then
		v22 = __wf_atom_eab484a7:__wf_atom_a4299765()
	elseif not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			v22 = __wf_atom_9be88b01:__wf_atom_a4299765()
		end
	end

	if not __wf_atom_7e8ad928(v22) then
		local __wf_atom_bbce4037 = v22:__wf_atom_bbce4037()

		if not __wf_atom_7e8ad928(__wf_atom_bbce4037) and #__wf_atom_bbce4037 > 0 then
			emotesList = __wf_atom_bbce4037
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v23 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsA(__wf_atom_c0fefb76)
	local mLocked = not fn3()
		or __wf_atom_c4f78a8f:IsA(__wf_atom_72d5e8c0)
		or __wf_atom_c4f78a8f:IsA(__wf_atom_47cae841)
	v7.mIconMaterialOverride = smoothEdgeMaterial
	v7.mIconWidthOverride = 90
	v7.mIconHeightOverride = 60

	for i = 1, math.max(#emotesList, v7.MAX_RING_ITEMS) do
		local mItem = Resource(emotesList[i])
		local v24 = { mItem = mItem, mLocked = mLocked }

		if v23 and not __wf_atom_7e8ad928(mItem) and mItem:__wf_atom_c23aaa0d() then
			v24.mLocked = true
		end

		v7:AddElement(v24)
	end

	v7:Initialize()
	table.insert(v14, v7)
end

function onHudMarginsChanged()
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end
end

local function fn14()
	local color = module3.GetColor(2, true)
	local color2 = module3.GetColor(6, true)
	local color3 = module3.GetColor(10, true)
	local color4 = module3.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Backer", 12, 80)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Backer", 11, color)
	mMovie:__wf_atom_e57658c2("EmoteArrow.ArrowLines", 11, color4)
	local v22 = {
		"Label",
		"LeftDot",
		"CenterDot",
		"RightDot",
		"LeftLine",
		"RightLine",
		"ArrowHead"
	}

	for i = 1, #v22 do
		local v23 = v22[i]
		mMovie:__wf_atom_4c1c1986("EmoteArrow", v23, 11, color3)
	end

	mMovie:__wf_atom_e57658c2("DescriptionPanel.Lines", 11, color3)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Label", 11, color2)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Bg", 11, color)
end

local function fn15()
	if #v14 == 1 then
		mMovie:__wf_atom_2dedec1a("EmoteArrow", 13, false)
		return
	end

	local v22

	if v15 == 1 then
		v22 = v16
	else
		v22 = false
	end

	v11:SetVisible(v22)
	mMovie:__wf_atom_2dedec1a("TradePanel", 13, v22)
	fn9(not v22 and "" or nil)
	local v23 = v14[v15]

	if
		not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer)
		or not __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew)
		or v23 ~= nil and v23.mEditMode
	then
		mMovie:__wf_atom_2dedec1a("EmoteArrow", 13, false)
		return
	end

	local v24 = v15 == 1 and "/Lotus/Language/Menu/Loadout_Emotes"
		or v16 and "/Lotus/Language/Dojo/Trade"
		or "/Lotus/Language/Menu/Loadout_Consumables"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		module.Ternary(Engine.IsPlayingWithController(), "<MENU_RTRIGGER2>", "<MENU_RIGHT_CLICK>"),
		true
	)

	if __wf_atom_8e9ac384 == mMovie:__wf_atom_8e9ac384("<MINI_INVENTORY_HOLD>", true) then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<NEXT_MENU>", true)
	end

	local v25 = __wf_atom_8e9ac384 .. " " .. mMovie:__wf_atom_8e9ac384(v24, true)
	mMovie:__wf_atom_50d60589("EmoteArrow.Label", 36, v25)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Label", 0, -155)
end

local function fn16()
	mMovie:OverrideMaterial("EmoteArrow.ArrowLines", _G.UIMaterial_VitruvianLines)
	fn15()
	__wf_atom_ec43d06e(mMovie, "EmoteArrow", 2, { 12 }, { 100 }, 0.25)
	fn14()
end

local function fn17()
	if not fn3() then
		return
	end

	flag = false
	__wf_atom_ec43d06e(mMovie, "TradePanel", 2, { 12 }, { 100 }, 0.25, 0)

	for i = 1, #v14 do
		local v22 = v14[i]
		local mClipName = v22.mClipName
		local v23 = i == v15 and 100 or 0
		v22.mInitialX = 0
		__wf_atom_ec43d06e(mMovie, mClipName, 2, { 4, 12 }, { 0, v23 }, 0.25, 0)
	end

	fn16()
end

local function fn18(p, p2)
	local v22 = v14[v15]
	v15 = tonumber(p)
	local v23 = v14[v15]

	if v23 == nil then
		return
	end

	v = p2

	if v22 ~= nil then
		v22.mDragElement = nil
		local mClipName = v22.mClipName
		mMovie:__wf_atom_290807ee(mClipName)
		mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
		mMovie:__wf_atom_e57658c2(mClipName, 4, 5000)
	end

	local mClipName = v23.mClipName
	__wf_atom_ec43d06e(mMovie, mClipName, 2, { 4, 12 }, { 0, 100 }, 0.25, 0)
	v16 = false
	v5.mLooping = false
	v5.mEditMode = true
	v5.mUseSpiral = nil

	if _T.ConsumablesElements == nil then
		_T.ConsumablesElements = v5.mElements
	else
		v5.mElements = _T.ConsumablesElements
	end

	v5:CheckSpiralEnabled()

	for i = 1, #v5.mElements do
		local mElement = v5.mElements[i]

		if not __wf_atom_7e8ad928(mElement) then
			mElement.mStoreItem = v:GetStoreItem(mElement.mItem)
		end
	end

	v7.mLooping = false
	v7.mEditMode = true
	v7.mUseSpiral = nil

	if _T.EmotesElements == nil then
		_T.EmotesElements = v7.mElements
	else
		v7.mElements = _T.EmotesElements
	end

	v7:CheckSpiralEnabled()
	fn15()
	fn6()
end

function Initialize()
	gGameRules:__wf_atom_411c9025(true)

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(1)
	end

	_T.SetActiveSpiral = fn18
	local __wf_atom_eff0517e = gRegion:__wf_atom_eab484a7():__wf_atom_eff0517e()

	if _G.StalkerMode or __wf_atom_7e8ad928(__wf_atom_eff0517e) or not fn3() then
		mMovie:Close()
		return
	end

	local isPlayingWithController = Engine.IsPlayingWithController()

	if _T.ConsumableSpiralFocus == nil then
		_T.ConsumableSpiralFocus = {
			Index = 1,
			UsingController = isPlayingWithController,
			X = 0,
			Y = 200
		}
	end

	mMovie:__wf_atom_e57658c2("DescriptionPanel", 12, 0)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Lines", 12, 0)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Bg", 15, 600)
	mMovie:__wf_atom_e57658c2("DescriptionPanel.Bg", 12, 0)
	mMovie:OverrideMaterial("DescriptionPanel.Bg", bgVisRange)
	mMovie:OverrideMaterial("DescriptionPanel.Lines", bgVisRange)

	if module3.UsingBrightBackground() then
	end

	__wf_atom_ec43d06e(mMovie, "DescriptionPanel.Bg", 8, { 12 }, { 60 }, 0.25)
	__wf_atom_ec43d06e(mMovie, "DescriptionPanel.Lines", 8, { 12 }, { 80 }, 0.25)
	fn5()
	module.PlaySound(_G.UISound_DialogOpen)
	v2 = module4.Create(mMovie)
	v2:Register(mMovie, "GearSpiral", { v2.ANCHOR_H_CENTRE, v2.ANCHOR_V_CENTRE })
	v2:Register(mMovie, "EmoteSpiral", { v2.ANCHOR_H_CENTRE, v2.ANCHOR_V_CENTRE })
	v2:Register(mMovie, "EmoteArrow", { v2.ANCHOR_H_RIGHT, v2.ANCHOR_V_CENTRE })
	v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v4 = __wf_atom_eff0517e:__wf_atom_d2b2176d()
	v13 = v4:__wf_atom_3999e0fb()

	if not __wf_atom_7e8ad928(v13) then
		v12 = v13:__wf_atom_06c9c5e6()
	end

	local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()
	local active = _T.gHunting and _T.gHunting.active
	local v22 = _T.gFishing
		and _T.gFishing.gearData
		and _T.gFishing.gearData.fishingState
		and _T.gFishing.gearData.fishingState[__wf_atom_eff0517e:__wf_atom_18aa6e58()] == _T.gFishing.gearData.FS_ACTIVE
	local classicControls = _T.classicControls

	if not __wf_atom_7e8ad928(v12) or (active or v22) and classicControls then
		v4:__wf_atom_f6d5276b(v13:__wf_atom_68fc1021())

		if not (__wf_atom_7e8ad928(__wf_atom_b56d2aa8) or classicControls) then
			__wf_atom_b56d2aa8:Execute("OnPowerModifierHeld", "false")
		end
	end

	if not isPlayingWithController then
		mMovie:__wf_atom_fbca497c(true)
	end

	for i = 1, #v17 do
		local v23 = v17[i]
		mMovie:__wf_atom_e57658c2(v23, 12, 0)
		mMovie:__wf_atom_e57658c2(v23, 4, 5000)
		mMovie:__wf_atom_7d7314f1(v23 .. ".Callout.tf.text", module.Ternary(i < 3, "<GAMEPAD_LX>", "<GAMEPAD_RX>"))
		mMovie:__wf_atom_7f57ab2f(v23, "Callout", 13, isPlayingWithController)
		mMovie:__wf_atom_7f57ab2f(v23, "DirArrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v23, "WheelIcon", 13, not isPlayingWithController)
		mMovie:__wf_atom_4c1c1986(v23, "GearInfo.Bg", 11, _G.UIColor_Black)
		mMovie:__wf_atom_4c1c1986(v23, "GearInfo.Bg", 12, 75)
		mMovie:__wf_atom_7f57ab2f(v23, "GearInfo.Bg", 13, false)
		__wf_atom_86cbd68d(mMovie, v23 .. ".WheelIcon.gotoAndStop", i)
	end

	local uiMode = module2.GetUIMode()
	local v23 = gGameRules:IsA(__wf_atom_88d33e05) or gGameRules:IsA(__wf_atom_3066d015)

	if uiMode ~= module2.UI_MODE_IN_SPACE_HUB then
		gGameRules:__wf_atom_09e81034()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:IsA(__wf_atom_c0fefb76)
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:IsA(__wf_atom_47cae841)
	end

	v6 = uiMode ~= module2.UI_MODE_IN_DOJO and not (v23 or _T.WareframeChallenge)
	v16 = not __wf_atom_7e8ad928(__wf_atom_b56d2aa8)
		and gGameRules:__wf_atom_af3bd666()
		and module2.ShowTradeUI()
		and not module2.IsPlayerInCrewship()
	fn13(true)
	mMovie:__wf_atom_e57658c2("GearSpiral.GearInfo.Bg", 12, 65)
	mMovie:__wf_atom_933bbce0("GearSpiral.GearInfo.Bg", gearInfoBackerTexture, gearInfoBackerMaterial)
	mMovie:__wf_atom_1ca72041("GearSpiral.GearInfo.Bg", "AAEdgeExtend", 70, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("EmoteSpiral.GearInfo.Bg", 12, 65)
	mMovie:__wf_atom_933bbce0("EmoteSpiral.GearInfo.Bg", gearInfoBackerTexture, gearInfoBackerMaterial)
	mMovie:__wf_atom_1ca72041("EmoteSpiral.GearInfo.Bg", "AAEdgeExtend", 70, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("TradePanel", 0, 800)
	mMovie:__wf_atom_e57658c2("TradePanel", 1, 450)
	local module5 = require("Lotus.Interface.Components.Button")
	v11 = module5.CreateButton(
		mMovie,
		"TradePanel.Btn",
		string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/Trade", false)),
		"VendorModePressed",
		"<MENU_GENERIC2>",
		nil,
		nil,
		true
	)
	v11.mSkipLocalization = true
	v11:SetVisible(v16)

	if v16 then
		v11.mAlignment = "center"
		v11.mWidth = 320
		local v24, v25

		if gRegion:GetPlayerAvatar():__wf_atom_7b686578() then
			v24 = "/Lotus/Language/Dojo/DisableVendorMode"
			v25 = "/Lotus/Language/Menu/RelayEndTradeInstruction"
		else
			v24 = "/Lotus/Language/Dojo/EnableVendorMode"
			v25 = "/Lotus/Language/Menu/RelayTradeInstruction"
		end

		v11.mLabel = string.upper(mMovie:__wf_atom_8e9ac384(v24, false))
		v11:Redraw()
		mMovie:OverrideMaterial("TradePanel.Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			"TradePanel.Bg",
			"RectInnerColor",
			_G.UIColorObject_Black.r,
			_G.UIColorObject_Black.g,
			_G.UIColorObject_Black.b,
			0.65
		)
		mMovie:__wf_atom_1ca72041(
			"TradePanel.Bg",
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.1
		)
		local v26

		if gGameRules:IsA(__wf_atom_1316e0c2) then
			v26 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_TradeTitle", true)
		else
			v26 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Locations/RelayStationTrade", true)
		end

		mMovie:__wf_atom_50d60589("TradePanel.Title", 36, string.upper(v26))
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TradePanel.Instruction", 1)
		mMovie:__wf_atom_50d60589("TradePanel.Instruction", 46, "bottom")
		mMovie:__wf_atom_7d7314f1("TradePanel.Instruction.text", v25)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("TradePanel.Instruction", 41)
		local v27 = __wf_atom_5e6e15c8 - __wf_atom_5e6e15c8_2 + 7
		mMovie:__wf_atom_e57658c2("TradePanel.Separator", 1, v27)
		local v28 = v27 - 24
		mMovie:__wf_atom_e57658c2("TradePanel.Title", 1, v28)
		mMovie:__wf_atom_e57658c2("TradePanel.Bg", 15, 96 + __wf_atom_5e6e15c8_2)
	end

	mMovie:__wf_atom_2dedec1a("TradePanel", 13, v16)
	mMovie:__wf_atom_e57658c2("TradePanel", 12, 0)
	mMovie:__wf_atom_e57658c2("EmoteArrow", 12, 0)
	fn17()

	if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
		print("ScopeDebug: Hide from ConsumablesOverlay")
		v10 = _T.reticleState == false
		__wf_atom_b56d2aa8:Execute("HideReticle", "false")
		__wf_atom_b56d2aa8:Execute("HideAbilityDots", "")
	end

	v3 = true
	flag = false
end

local function fn19(p)
	if flag or v11:IsActive() then
		return
	end

	local v22 = v14[v15]

	if v22 == nil then
		return
	end

	v22.mLeftStick = mLeftStick
	v22:Update(p)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v3 then
		return
	end

	if _T.pauseMenuOpen or __wf_atom_7e8ad928(v4) then
		fn()
		return
	end

	local v22 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v22)
	fn19(v22)
end

local function fn20()
	if
		not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer)
		or not __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew)
		or #v14 == 1
	then
		return
	end

	if not flag then
		module.PlaySound(_G.UISound_GearWheelTransition)
		local v22 = v14[v15]

		if v22 ~= nil and v22.mClipName ~= nil then
			v22.mDragElement = nil
			__wf_atom_ec43d06e(mMovie, v22.mClipName, 1, {
				"_alpha",
				function(mInitialX)
					v22.mInitialX = mInitialX
				end
			}, { 0, -1000 }, 0.15, 0, function()
				v15 = v15 % #v14 + 1
				v22 = v14[v15]

				if v22 ~= nil and v22.mClipName ~= nil then
					v22.mPrevFocusedElement = nil
					v22:FocusElement(v22.mFocusedElement or 1)
					__wf_atom_ec43d06e(mMovie, v22.mClipName, 2, {
						"_alpha",
						function(p)
							v22.mInitialX = 1000 + p
						end
					}, { 100, -1000 }, 0.15, 0, function()
						v22.mForceUpdate = true
					end)
				end

				fn15()
			end)
		end
	end
end

function SpiralItemPressed(p)
	local v22 = v14[v15]

	if v22 == nil or flag then
		return
	end

	v22:SelectElementById((tonumber(p)))
	module.PlaySound(_G.UISound_ButtonSelect)
end

function SpiralItemFocused(p)
	local v22 = v14[v15]

	if v22 == nil or flag then
		return
	end

	v22:FocusElementById((tonumber(p)))
end

function SpiralItemUnfocused(p)
	local v22 = v14[v15]

	if v22 == nil or flag then
		return
	end

	v22:UnfocusElementById((tonumber(p)))
end

function ConsumablePressed(p)
	if __wf_atom_7e8ad928(v5) or flag then
		return
	end

	v5:SelectElementById((tonumber(p)))
	module.PlaySound(_G.UISound_ButtonSelect)
end

function ConsumableFocused(p)
	if __wf_atom_7e8ad928(v5) or flag then
		return
	end

	v5:FocusElementById((tonumber(p)))
end

function ConsumableUnfocused(p)
	if __wf_atom_7e8ad928(v5) or flag then
		return
	end

	v5:UnfocusElementById((tonumber(p)))
end

function EmotePressed(p)
	if __wf_atom_7e8ad928(v7) or flag then
		return
	end

	v7:SelectElementById((tonumber(p)))
	module.PlaySound(_G.UISound_ButtonSelect)
end

function EmoteFocused(p)
	if __wf_atom_7e8ad928(v7) or flag then
		return
	end

	v7:FocusElementById((tonumber(p)))
end

function EmoteUnfocused(p)
	if __wf_atom_7e8ad928(v7) or flag then
		return
	end

	v7:UnfocusElementById((tonumber(p)))
end

function onKeyUp_MINI_INVENTORY_HOLD()
	fn2()
	return true
end

function onKeyDown_MINI_INVENTORY_HOLD()
	fn17()
	return true
end

function onKeyDown_NEXT_MENU()
	local v22 = v14[v15]

	if v22 == nil or not v22.mEditMode or flag then
		fn20()
		return true
	end

	local mElement = v22.mElements[v22.mFocusedElement]

	if mElement ~= nil and mElement.mItem ~= nil then
		v22:RemoveElement(v22.mFocusedElement)
		v18 = v15 == 1
		v19 = v15 == 2
	end
end

function onKeyDown_MINI_INVENTORY_TOGGLE()
	fn2()
	return true
end

function onKeyUp_SELECT_SUB_GEAR_0()
	fn2()
	return false
end

function onKeyUp_SELECT_SUB_GEAR_1()
	fn2()
	return false
end

function onKeyUp_SELECT_SUB_GEAR_2()
	fn2()
	return false
end

function onKeyDown_MENU_RIGHT_X(_, p)
	v9.X = tonumber(p)
	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	v9.X = tonumber(p)
	return true
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	v9.Y = tonumber(p)
	return true
end

function onKeyUp_MENU_RIGHT_Y(_, p)
	v9.Y = tonumber(p)
	return true
end

function onKeyDown_MENU_X(_, p)
	mLeftStick.X = tonumber(p)
	return true
end

function onKeyUp_MENU_X(_, p)
	mLeftStick.X = tonumber(p)
	return true
end

function onKeyDown_MENU_Y(_, p)
	mLeftStick.Y = tonumber(p)
	return true
end

function onKeyUp_MENU_Y(_, p)
	mLeftStick.Y = tonumber(p)
	return true
end

local v22 = false

local function fn21()
	v22 = true
	local v23 = v14[v15]
	local mEditMode = not (__wf_atom_7e8ad928(v23) or flag) and not v11:IsActive() and v23.mEditMode

	if mEditMode then
		v23.mDragElement = v23:GetFocusedElementIndex()
	end

	return mEditMode
end

local function fn22(p)
	if not v22 then
		return false
	end

	v22 = false
	local v23 = p or v14[v15]
	local v24 = not (__wf_atom_7e8ad928(v23) or flag or v11:IsActive())

	if v24 then
		local focusedElementIndex = v23:GetFocusedElementIndex()

		if not __wf_atom_7e8ad928(focusedElementIndex) then
			if v23.mDragging then
				v18 = v15 == 1
				v19 = v15 == 2
				v23:MoveElement(v23.mDragElement, focusedElementIndex)
			else
				v23:SelectElement(focusedElementIndex)
			end
		end
	end

	v23.mDragging = false
	v23.mDragElement = nil
	return v24
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if flag then
		return
	end

	local v23 = v14[v15]

	if v23 == nil then
		return
	end

	local v24 = v23.mFocusedElement + p

	if not (v23.mLooping and v23.mUseSpiral) then
		v24 = (v24 - 1) % #v23.mElements + 1
	end

	local mDrawElement = v23.mDrawElements[v24]

	if mDrawElement ~= nil and mDrawElement.mClipName ~= nil then
		mMovie:__wf_atom_e57658c2("GearSpiral.DirArrow", 16, mDrawElement.Rotation)
		local v25 = mMovie:__wf_atom_5e6e15c8(mDrawElement.mClipName, 2) / mMovie:__wf_atom_97cd8326()
		local v26 = mMovie:__wf_atom_5e6e15c8(mDrawElement.mClipName, 3) / mMovie:__wf_atom_54eeda24()
		fn7(v25 * mMovie:__wf_atom_d5a50cb5(), v26 * mMovie:__wf_atom_c4f6543f())
	end
end

local function fn23()
	local v23 = _T.Touch_GetTouchedAction == nil and "" or _T.Touch_GetTouchedAction()
	return v23 == "EscGroup" or v23 == "Gear"
end

local function fn24()
	local v23 = mMovie:__wf_atom_5e6e15c8("EmoteArrow", 0) - mMovie:__wf_atom_5e6e15c8("EmoteArrow", 14) / 2 - 100
	local v24 = mMovie:__wf_atom_5e6e15c8("EmoteArrow", 1) - mMovie:__wf_atom_5e6e15c8("EmoteArrow", 15) / 2 - 100
	local v25 = mMovie:__wf_atom_5e6e15c8("EmoteArrow", 14) + 200
	local v26 = mMovie:__wf_atom_5e6e15c8("EmoteArrow", 15) + 200
	return v23 < mMovie:__wf_atom_5e6e15c8("_root", 30)
		and v24 < mMovie:__wf_atom_5e6e15c8("_root", 31)
		and mMovie:__wf_atom_5e6e15c8("_root", 30) < v23 + v25
		and mMovie:__wf_atom_5e6e15c8("_root", 31) < v24 + v26
end

function onKeyDown_MENU_CLICK()
	if Engine.__wf_atom_dd1285f1() and (fn23() or fn24()) then
		return
	end

	if
		Engine.IsPlayingWithController()
		or mMovie:__wf_atom_5e6e15c8("_root", 30) ~= -1000
		or mMovie:__wf_atom_5e6e15c8("_root", 31) ~= -1000
	then
		return (fn21())
	end

	return false
end

function onKeyUp_MENU_CLICK()
	if Engine.__wf_atom_dd1285f1() then
		if fn23() then
			fn2()
			return
		end

		if fn24() then
			fn20()
			return
		end
	end

	if
		Engine.IsPlayingWithController()
		or mMovie:__wf_atom_5e6e15c8("_root", 30) ~= -1000
		or mMovie:__wf_atom_5e6e15c8("_root", 31) ~= -1000
	then
		return (fn22())
	end

	return false
end

function onKeyDown_MENU_SELECT()
	if
		Engine.IsPlayingWithController()
		or mMovie:__wf_atom_5e6e15c8("_root", 30) ~= -1000
		or mMovie:__wf_atom_5e6e15c8("_root", 31) ~= -1000
	then
		return (fn21())
	end

	return false
end

function onKeyUp_MENU_SELECT()
	if
		Engine.IsPlayingWithController()
		or mMovie:__wf_atom_5e6e15c8("_root", 30) ~= -1000
		or mMovie:__wf_atom_5e6e15c8("_root", 31) ~= -1000
	then
		return (fn22())
	end

	return false
end

function onKeyDown_MENU_CANCEL()
	fn2()
	return true
end

function IsInputBlocked()
	return flag
end

function OnGamepadTransition(p)
	local v23 = p == "true"
	mMovie:__wf_atom_fbca497c(v23)
	fn15()

	for i = 1, #v17 do
		local v24 = v17[i]
		mMovie:__wf_atom_7d7314f1(v24 .. ".Callout.tf.text", module.Ternary(i < 3, "<GAMEPAD_LX>", "<GAMEPAD_RX>"))
		mMovie:__wf_atom_7f57ab2f(v24, "Callout", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_7f57ab2f(v24, "DirArrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v24, "WheelIcon", 13, not Engine.IsPlayingWithController())
		mMovie:__wf_atom_7f57ab2f(v24, "GearInfo.Bg", 13, false)
		__wf_atom_86cbd68d(mMovie, v24 .. ".WheelIcon.gotoAndStop", i)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElement(v5.mCurrentElementIndex)
		v5:Redraw()
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:UnfocusElement(v7.mCurrentElementIndex)
		v7:Redraw()
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Redraw()
	end

	fn6()
end

function OnStyleChangedCallback()
	fn14()
end

function HideScreenForPlatPurchase(p)
	if not v5.mEditMode then
		mMovie:SetVisible(p ~= "true")
	end
end