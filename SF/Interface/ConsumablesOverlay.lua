local module = require("SF.Interface.SFUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local flag = true
local v3 = false
local v4 = nil
local v5 = nil
local v6 = true
local v7 = nil
local v8 = nil
local mRightStick = { X = 0, Y = 0 }
local mLeftStick = { X = 0, Y = 0 }
local v9 = true
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = {}
local v14 = 1
local v15 = false
local v16 = { "GearSpiral" }
local v17 = false
local v18 = false
local v19 = WeakResource("/Lotus/Types/Game/CrewShip/Ships/RailJack")
local v20 = WeakResource("/Lotus/Types/Restoratives/ScenarioBeacon")
local v21 = WeakResource("/Lotus/Types/Enemies/Orokin/Entrati/EntratiTech/EntratiTechAvatar")
local mConsumablesPage = 0
local flag2 = false

local function fn()
	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_f6d5276b(0)

		if not __wf_atom_7e8ad928(v12) then
			v12:__wf_atom_48e2de4b()
		end
	end

	SelectFocusedElement(nil, true)
	v11 = nil
	mMovie:Close()
end

function Close()
	if flag2 then
		return
	end

	if Engine.__wf_atom_dd1285f1 and not __wf_atom_7e8ad928(_T.Touch_ShowAllIcons) then
		_T.Touch_ShowAllIcons(true)
	end

	flag2 = true
	flag = true
	module2.PlaySound(_G.UISound_DialogClose)

	for _, v22 in v16 do
		__wf_atom_ec43d06e(mMovie, v22, 0, { 4, 12 }, { 5000, 0 }, 0.35, 0)
	end

	__wf_atom_ec43d06e(mMovie, "DescriptionPanel", 8, { 12 }, { 0 }, 0.35, 0)
	__wf_atom_ec43d06e(mMovie, "EmoteArrow", 0, { 12 }, { 0 }, 0.35, 0)
	__wf_atom_ec43d06e(mMovie, "TradePanel", 0, { 12 }, { 0 }, 0.35, 0, fn)
	local playerAvatar = gRegion:GetPlayerAvatar()

	if not __wf_atom_7e8ad928(playerAvatar) then
		playerAvatar:__wf_atom_2596a9fb(Symbol("<CONSUMABLES_HOLD>"), true, false)
	end
end

function VisitWebsiteCallback(p)
	if tonumber(p) == 4 then
		module2.DoOpenWebBrowser("https://soulframe.com/user")
		_T.Enabling2FA = true
	end

	if not __wf_atom_7e8ad928(mMovie) then
		Close()
	end
end

local function fn2()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	return not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsA(v21))
end

local function fn3()
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

local function fn4()
	if __wf_atom_7e8ad928(v5) or not v5.mEditMode then
		return
	end

	local v22 = {}
	table.insert(v22, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = Close,
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
		_T.ConsumablesOverlayClosedCallback(v17, v18)
		_T.ConsumablesOverlayClosedCallback = nil
		_T.ConsumablesOverlayElementSelectedCallback = nil
	end

	if not (__wf_atom_7e8ad928(gGameRules) or v9) then
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

local function fn5(p, p2)
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(p, p2)
	__wf_atom_8e4fda44:__wf_atom_b005c93e(p, p2)
end

function VendorModePressed()
	if fn3() then
		mMovie:SetVisible(false)
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()

	if not playerAvatar:__wf_atom_7b686578() then
		if __wf_atom_7e8ad928(playerAvatar:__wf_atom_39bdffdf()) then
			if playerAvatar:__wf_atom_7bcdbf55(Symbol("Kneel")) then
				module2.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileKneeling")
				Close()
				return
			else
				playerAvatar:__wf_atom_b0f26b7e()
			end
		else
			module2.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileDueling")
			Close()
			return
		end
	end

	if not gGameRules:__wf_atom_af3bd666() then
		Close()
		return
	end

	local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

	if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
		__wf_atom_7be88783:Execute("ToggleVendor", "")
	end

	Close()
end

function OnTrade(object, object2)
	if
		fn3()
		or __wf_atom_7e8ad928(object2)
		or not object2:__wf_atom_8efce136()
		or not gGameRules:__wf_atom_af3bd666()
	then
		return
	end

	local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

	if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd ~= object2 then
			__wf_atom_7be88783:Execute("OnTrade", (__wf_atom_3d96ddcd:GetName()))
		end
	end
end

local function fn6(data, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	function _T.GetAllItems()
		local result = { not data.mInsertElementButton and {
				Categories = { 0 },
				EmptySlot = true
			} or nil }
		local v22 = v
		local v23

		if p then
			v23 = __wf_atom_72bebce2
		else
			v23 = __wf_atom_9ae7d6a1
		end

		local __wf_atom_caa82b8d = v22:__wf_atom_caa82b8d(v23)
		local inventory = gGameData:GetInventory()
		local v24

		if p then
			v24 = inventory:__wf_atom_6b29f1ed()
		else
			v24 = inventory:__wf_atom_da43e3f3()
		end

		if __wf_atom_7e8ad928(__wf_atom_caa82b8d) then
			return result
		end

		for _, mStoreItem in ipairs(__wf_atom_caa82b8d) do
			local alwaysAvailable = mStoreItem:AlwaysAvailable()
			local mItemCount = module2.Ternary(alwaysAvailable, 1, 0)
			local item = mStoreItem:GetItem()

			if not alwaysAvailable then
				for _, v25 in ipairs(v24) do
					if v25.mItemType ~= item then
						continue
					end

					alwaysAvailable = true

					if p then
						mItemCount = v25.mItemCount
					end

					break
				end
			end

			if not alwaysAvailable or module.ShouldHideConsumable(item) then
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
		local function fn7(p2, p3)
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
					local v22 = fn7(p2, p3)

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
					local v22 = fn7(p2, p3)

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
				local v23

				if p then
					v23 = v5
				else
					v23 = v7
				end

				v17 = v17 or p
				v18 = v18 or not p
				local v24, v25

				if __wf_atom_7e8ad928(v22.Type) or v22.Count == 0 then
					v24 = { EmptySlot = true }
				else
					local count

					if p then
						count = v22.Count
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

local function fn7(p)
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
end

local function fn8(p)
	local activeSoundSet = module3.GetActiveSoundSet()

	if activeSoundSet == module3.SOUND_SET_EIDOLON then
		return module2.Ternary(p, poeAnimalLures, poeAnimalRarityBoosts)
	end

	if activeSoundSet == module3.SOUND_SET_ORB_VALLIS then
		return module2.Ternary(p, ovAnimalLures, ovAnimalRarityBoosts)
	end

	if activeSoundSet == module3.SOUND_SET_OROKIN_TOWER then
		return module2.Ternary(p, cdAnimalLures, cdAnimalRarityBoosts)
	end

	return nil
end

local function fn9(mInHub, mIsOperator, mIsVehicle)
	local module6 = require("SF.Interface.Components.GearSpiral")
	mConsumablesPage = 0

	if _T.FishingMode then
		mConsumablesPage = 1
	end

	v5 = module6.CreateGearList(mMovie, "GearSpiral", v4)
	v5.mAddItemTexture = addItemTexture
	v5.mTypeLoc = "/Lotus/Language/Menu/Loadout_Consumables"
	v5.mUpdateDescriptionCallback = fn7
	v5.mGear = true
	v5.mInHub = mInHub
	v5.mIsOperator = mIsOperator
	v5.mIsVehicle = mIsVehicle
	v5.mLooping = true
	v5.mConsumablesPage = mConsumablesPage

	function v5.mOnFocusedCallback(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(v4) then
			return
		end

		module2.PlaySound(_G.UISound_Focus)
	end

	function v5.mOnSelectedCallback(data)
		if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(v4) then
			return
		end

		if v5.mEditMode then
			fn6(data.Data, true)
			return
		end

		local v22 = false
		local gearIndex = data.GearIndex or data.Data.GearIndex

		if gearIndex ~= nil and data.Enabled then
			local __wf_atom_ba1c3957 = v4:__wf_atom_ba1c3957(gearIndex, mConsumablesPage)

			if
				not __wf_atom_7e8ad928(__wf_atom_ba1c3957)
				and v4:__wf_atom_b62f2024(gearIndex, mConsumablesPage) > 0
				and __wf_atom_ba1c3957:GetCooldown() <= 0
				and not __wf_atom_ba1c3957:__wf_atom_2cbbab92()
			then
				if fn2() then
					v4:__wf_atom_9d2ae6cc(gearIndex, mConsumablesPage)

					if not (__wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v12)) then
						v12:__wf_atom_5eb92393(__wf_atom_ba1c3957:__wf_atom_1bb5b1ff())
					end

					v22 = true

					if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
						__wf_atom_21342f4a:__wf_atom_3c9aa248(
							Symbol("GEAR_USED"),
							__wf_atom_ba1c3957:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
						)

						if
							__wf_atom_ba1c3957:IsA(v5.GlyphNoConsumeType)
							or __wf_atom_ba1c3957:IsA(v5.GlyphConsumableNoCharges)
						then
							local __wf_atom_a6382ae5 = gRegion:__wf_atom_eab484a7():__wf_atom_a4299765():__wf_atom_a6382ae5()

							if not __wf_atom_7e8ad928(__wf_atom_a6382ae5.mItemType) then
								__wf_atom_21342f4a:__wf_atom_3c9aa248(
									Symbol("GLYPH_PLACED"),
									__wf_atom_a6382ae5.mItemType:__wf_atom_5b41f63b()
								)
							end
						end
					end
				end

				__wf_atom_ec43d06e(mMovie, data.mClipName, 2, { 4 }, { -15000 }, 0.25, 0)
				Close()
			end
		end

		if gearIndex ~= nil and data.DisableFocusVisual then
			if data.IsPetItemNoPetSummon then
				_T.ShowImpactMessage("/SF/Language/Consumables/SummonWolfCub_Impact", 5)
			else
				_T.ShowImpactMessage("/SF/Language/Crafting/BrewMoreImpactMessage", 5)
			end
		end

		if not v22 then
			module2.PlaySound(_G.UISound_Error)
		end
	end

	v5._ConsumablesList_mElementDrawCallback = v5.mElementDrawCallback

	function v5.mElementDrawCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		v5._ConsumablesList_mElementDrawCallback(p)
		mMovie:__wf_atom_7d7314f1(p.mClipName .. ".Bg.Callout.Tf.text", "<MENU_GENERIC1>")
	end

	local v22 = nil
	local v23 = 0

	if v11 == nil or v11 ~= WeakResource("/Lotus/Types/Restoratives/Conservation/AnimalLureGearItem") then
		if
			v11 ~= nil
			and v11 == WeakResource("/Lotus/Types/Restoratives/Conservation/BaseHuntingAccessoryGearItem")
		then
			v22 = fn8(false)
		end
	else
		v22 = fn8(true)
	end

	if v22 ~= nil then
		v23 = #v22 + 1
	end

	local count = 0
	local v24 = {}
	local v25

	if __wf_atom_7e8ad928(v4) then
		v25 = 0
	else
		v25 = v4:__wf_atom_62abd325(mConsumablesPage)

		for i = 0, v25 - 1 do
			local __wf_atom_ba1c3957 = v4:__wf_atom_ba1c3957(i, mConsumablesPage)

			if module.ShouldHideConsumable(__wf_atom_ba1c3957) then
				count += 1
			else
				local v26 = not __wf_atom_7e8ad928(__wf_atom_ba1c3957)
				local v27 = -1
				local v28

				if v26 then
					if v22 == nil then
						v27 = i + 1 - count
						v28 = i
					else
						v28 = i

						for j = 1, #v22 do
							if not __wf_atom_ba1c3957:IsA(v22[j]) then
								continue
							end

							v27 = j
							break
						end

						if v28 == -1 then
							v27 = v23
							v23 += 1
						end
					end
				else
					v28 = -1
				end

				if v11 == nil or v26 and __wf_atom_ba1c3957:IsA(v11) then
					v24[v27] = v28
				end
			end
		end
	end

	for i = 1, math.max(v25, v5.MAX_RING_ITEMS) do
		local gearIndex = v24[i]

		if gearIndex == -1 then
			gearIndex = nil
		end

		if not (gearIndex ~= nil or i <= v5.MAX_RING_ITEMS) then
			continue
		end

		local v26 = { GearIndex = gearIndex }
		local v27

		if gearIndex == nil then
			v27 = false
		else
			local __wf_atom_ba1c3957 = v4:__wf_atom_ba1c3957(gearIndex, mConsumablesPage)
			v27 = module.ShouldHideConsumable(__wf_atom_ba1c3957)

			if not __wf_atom_7e8ad928(__wf_atom_ba1c3957) and __wf_atom_ba1c3957:IsA(v20) then
				local v28 = false

				if gMatchingService:__wf_atom_a676a953() then
					v28 = true
				elseif
					__wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
					and gGameRules:IsA(__wf_atom_dd9a0bb8)
					and not __wf_atom_7e8ad928(gGameRules:__wf_atom_72fc675e().levelKeyName)
				then
					local v29 = Symbol(gGameRules:__wf_atom_72fc675e().levelKeyName:__wf_atom_5b41f63b())
					v28 = v29 == module3.SCENARIO_EVENT_SPACE_TAG or v29 == module3.SCENARIO_EVENT_GROUND_TAG
				end

				v26.mLocked = (v28 and not _T.OpLinkDeployDisabled) == false
			end
		end

		if not v27 then
			v5:AddElement(v26)
		end
	end

	v5.Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/GearWheel_Consumables", false)
	v5.LabelAnchor = "right"
	v5:Initialize()
	table.insert(v13, v5)
end

local function fn10(p)
	if __wf_atom_7e8ad928(p) then
		return 0
	end

	if p.Id <= 5 then
		return (module2.ToRad((-p.Id - 2) * 36))
	end

	return (module2.ToRad((p.Id + 2) * 36))
end

local function fn11()
	local module6 = require("SF.Interface.Components.GearSpiral")
	v7 = module6.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn7
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

		module2.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
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
		Close()
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
	elseif __wf_atom_5d9ae734:IsA(v19) then
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

	v7.Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/GearWheel_Emotes", false)
	v7.LabelAnchor = "left"
	v7:Initialize()
	table.insert(v13, v7)
	v14 = 2
end

local function fn12()
	local module6 = require("SF.Interface.Components.GearSpiral")
	v7 = module6.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn7
	v7.mVisible = false
	v7.mLockedIcon = mMovie:__wf_atom_8e9ac384("<LOCKED>", true)
	v7.mDanceIcon = mMovie:__wf_atom_8e9ac384("<MELODY>", true)
	v7.mLooping = true
	v7.mCommandScriptRes = nil

	function v7.CalculateAngle(_, p)
		return (fn10(p))
	end

	function v7.mOnFocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		module2.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
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
		module2.PlaySound(crewCommandSound)
		_T.TacticsOverlayTargetCrew:__wf_atom_51009507(v7.mCommandScriptRes, Symbol("SetBehavior"), false)
		Close()
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

	v7.Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/GearWheel_Emotes", false)
	v7.LabelAnchor = "left"
	v7:Initialize()
	table.insert(v13, v7)
	v14 = 3
end

local function fn13(p)
	if mMovie:__wf_atom_253d7085(p) then
		DebugBreak(p .. " is already in use, please use a different clipname")
		return
	end

	table.insert(v16, p)
	__wf_atom_86cbd68d(mMovie, "GearSpiral.duplicateMovieClip", p, #v16 + 1000)
end

local function fn14()
	fn13("EmoteSpiral")

	if not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer) then
		fn11()
		return
	end

	if not __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew) then
		fn12()
		return
	end

	local module6 = require("SF.Interface.Components.GearSpiral")
	v7 = module6.CreateGearList(mMovie, "EmoteSpiral")
	v7.mAddItemTexture = addItemTexture
	v7.mTypeLoc = "/Lotus/Language/Menu/Loadout_Emotes"
	v7:SetCallbacks("EmotePressed", "EmoteFocused", "EmoteUnfocused")
	v7.mUpdateDescriptionCallback = fn7
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

		module2.PlaySound(_G.UISound_Focus)
	end

	function v7.mOnUnfocusedCallback(p)
		if __wf_atom_7e8ad928(p) or p.mClipName == nil then
			return
		end

		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", "Unfocused")
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Callout", 13, false)
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
		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Bg.gotoAndStop", module2.Ternary(v22, "Focused", "Unfocused"))
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
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 12, module2.Ternary(data.mLocked, 80, 100))
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 12, module2.Ternary(data.mLocked, 70, 100))
		mMovie:__wf_atom_48bd5a59(p.mClipName, "Name", 36, v24)
	end

	function v7.mOnSelectedCallback(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gRegion) then
			return
		end

		if v7.mEditMode then
			fn6(p.Data)
			return
		end

		local data = p.Data or p

		if data.mLocked or not p.Enabled then
			module2.PlaySound(_G.UISound_Error)
			return
		end

		local mItem = data.mItem
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not (__wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_7e8ad928(mItem)) then
			local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

			if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_bedb4e3f() or __wf_atom_50a7d83e:__wf_atom_47fbd15c()) then
				if __wf_atom_50a7d83e:__wf_atom_1cfa7bd2() == mItem then
					mItem = nil
				end

				if
					__wf_atom_50a7d83e:IsA(__wf_atom_c0fefb76)
					and not __wf_atom_7e8ad928(mItem)
					and mItem:__wf_atom_c23aaa0d()
				then
					return
				end

				if not (__wf_atom_50a7d83e:__wf_atom_cf18e36d(mItem) or mItem:IsA(tradeEmote) and __wf_atom_50a7d83e:__wf_atom_7b686578()) then
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

				if fn2() then
					__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_eab484a7, Symbol("EMOTE_PLAYED"))
					__wf_atom_50a7d83e:__wf_atom_7ab15c94(mItem)

					if mItem ~= nil and not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
						__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("EMOTE_PLAYED"), mItem:__wf_atom_5b41f63b())
					end
				end
			end

			Close()
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

	if v15 then
		table.insert(emotesList, tradeEmote)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v23 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f:IsA(WeakResource("/SF/Types/Player/EnvoyChildAvatar"))
	local mLocked = not fn2()
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

	v7.Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/GearWheel_Emotes", false)
	v7.LabelAnchor = "left"
	v7:Initialize()
	table.insert(v13, v7)
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

local function fn15(p)
	if #v13 == 1 then
		mMovie:__wf_atom_2dedec1a("EmoteArrow", 13, false)
		return
	end

	v10:SetVisible(false)
	mMovie:__wf_atom_2dedec1a("TradePanel", 13, false)
	fn7("")
	local v22 = v13[v14]

	if v22 ~= nil and v22.mEditMode then
		mMovie:__wf_atom_2dedec1a("EmoteArrow", 13, false)
		return
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		module2.Ternary(Engine.IsPlayingWithController(), "<MENU_RTRIGGER2>", "<MENU_RIGHT_CLICK>"),
		true
	)

	if __wf_atom_8e9ac384 == mMovie:__wf_atom_8e9ac384("<CONSUMABLES_HOLD>", true) then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<NEXT_MENU>", true)
	end

	mMovie:__wf_atom_50d60589("EmoteArrow.Title.Prompt", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Title.Prompt", 12, 80)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Backer", 11, _G.UIColor_Beige)
	local v23 = v13[2].LabelAnchor == nil
	mMovie:__wf_atom_2dedec1a("EmoteArrow.Title.Prompt", 13, not v23)

	if v23 then
		v13[1].LabelAnchor = "center"
	end

	local count = 0
	local total = 0

	for k, v24 in v13 do
		local convertHEX2RGB255 = module2.ConvertHEX2RGB255(module2.Ternary(
			v14 ~= k,
			_G.UIColor_Yellow,
			_G.UIColor_Beige
		))
		local convertHEX2RGB255_2 = module2.ConvertHEX2RGB255(module2.Ternary(
			v14 == k,
			_G.UIColor_Yellow,
			_G.UIColor_Beige
		))
		local ternary = module2.Ternary(v14 == k, 100, 30)
		local ternary2 = module2.Ternary(v14 == k, 100, 85)
		local ternary3 = module2.Ternary(p, 0, 0.25)
		local v25 = "EmoteArrow.Title.Label" .. k

		if v24.LabelAnchor == nil then
			count += 1
		end

		if not mMovie:__wf_atom_253d7085(v25) then
			__wf_atom_86cbd68d(mMovie, "EmoteArrow.Title.Label1.duplicateMovieClip", "Label" .. k, 1000 + k)
		end

		__wf_atom_ec43d06e(mMovie, v25, 7, {
			12,
			function(p2)
				local __wf_atom_104bfe98 = convertHEX2RGB255:__wf_atom_104bfe98(convertHEX2RGB255_2, p2)
				mMovie:__wf_atom_4c1c1986(v25, "Text", 44, __wf_atom_104bfe98:__wf_atom_dcecedb0())
			end,
			5,
			6
		}, { ternary, 1, ternary2, ternary2 }, ternary3)
		mMovie:__wf_atom_48bd5a59(v25, "Text", 36, v24.Label)
		local v26 = math.ceil((mMovie:__wf_atom_cfc41e35(v25, "Text", 40)))
		local labelAnchor = v24.LabelAnchor or "center"

		if count == 0 and labelAnchor ~= "center" then
			if k > 1 then
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("EmoteArrow.Title.Prompt", 14)
				local v27 = (__wf_atom_5e6e15c8 - mMovie:__wf_atom_5e6e15c8("EmoteArrow.Title.Prompt", 40)) / 2
				mMovie:__wf_atom_e57658c2("EmoteArrow.Title.Prompt", 0, total + v27)
				total += __wf_atom_5e6e15c8
			end

			if labelAnchor == "left" then
				mMovie:__wf_atom_4c1c1986(v25, "Text", 0, 0)
				mMovie:__wf_atom_e57658c2(v25, 0, total)
			elseif labelAnchor == "right" then
				mMovie:__wf_atom_4c1c1986(v25, "Text", 0, -v26)
				mMovie:__wf_atom_e57658c2(v25, 0, total + v26)
			end

			total += v26
		else
			mMovie:__wf_atom_4c1c1986(v25, "Text", 0, -v26 / 2)
			mMovie:__wf_atom_e57658c2(v25, 0, total / 2)

			if count == 0 then
				mMovie:__wf_atom_e57658c2(v25, 0, total + v26 / 2)
				total += v26
			else
				mMovie:__wf_atom_e57658c2(v25, 0, total / 2)
			end
		end

		mMovie:__wf_atom_e57658c2(v25, 1, count * -42)
	end

	mMovie:__wf_atom_e57658c2("EmoteArrow.Title", 0, -total / 2)
	mMovie:__wf_atom_e57658c2("EmoteArrow.Backer", 14, total + 80)
end

local function fn16()
	mMovie:OverrideMaterial("EmoteArrow.ArrowLines", _G.UIMaterial_VitruvianLines)

	for _, v22 in v16 do
		mMovie:__wf_atom_48bd5a59(
			v22,
			"GearInfo.Slot",
			36,
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Emotes", false)
		)
	end

	fn15(true)
	__wf_atom_ec43d06e(mMovie, "EmoteArrow", 2, { 12 }, { 100 }, 0.25)
end

local function fn17()
	fn16()

	if not fn2() then
		return
	end

	flag = false
	flag2 = false
	__wf_atom_ec43d06e(mMovie, "TradePanel", 2, { 12 }, { 100 }, 0.25, 0)

	for i = 1, #v13 do
		local v22 = v13[i]
		local mClipName = v22.mClipName
		local v23 = i == v14 and 100 or 0
		v22.mInitialX = 0
		__wf_atom_ec43d06e(mMovie, mClipName, 2, { 4, 12 }, { 0, v23 }, 0.25, 0)
	end
end

local function fn18(p, p2)
	local v22 = v13[v14]
	v14 = tonumber(p)
	local v23 = v13[v14]

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
	v15 = false
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
	fn4()
end

function Initialize()
	gGameRules:__wf_atom_411c9025(true)

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(1)
	end

	_T.SetActiveSpiral = fn18
	local __wf_atom_eff0517e = gRegion:__wf_atom_eab484a7():__wf_atom_eff0517e()
	flag2 = false

	if _G.StalkerMode or __wf_atom_7e8ad928(__wf_atom_eff0517e) or not fn2() then
		mMovie:Close()
		return
	end

	__wf_atom_eff0517e:__wf_atom_2596a9fb(Symbol("<CONSUMABLES_HOLD>"), true, true)
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

	if module4.UsingBrightBackground() then
	end

	__wf_atom_ec43d06e(mMovie, "DescriptionPanel.Bg", 8, { 12 }, { 60 }, 0.25)
	__wf_atom_ec43d06e(mMovie, "DescriptionPanel.Lines", 8, { 12 }, { 80 }, 0.25)
	module2.PlaySound(_G.UISound_DialogOpen)
	v4 = __wf_atom_eff0517e:__wf_atom_d2b2176d()
	v12 = v4:__wf_atom_3999e0fb()

	if not __wf_atom_7e8ad928(v12) then
		v11 = v12:__wf_atom_06c9c5e6()
	end

	local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()
	local active = _T.gHunting and _T.gHunting.active
	local v22 = _T.gFishing
		and _T.gFishing.gearData
		and _T.gFishing.gearData.fishingState
		and _T.gFishing.gearData.fishingState[__wf_atom_eff0517e:__wf_atom_18aa6e58()] == _T.gFishing.gearData.FS_ACTIVE
	local classicControls = _T.classicControls

	if not __wf_atom_7e8ad928(v11) or (active or v22) and classicControls then
		v4:__wf_atom_f6d5276b(v12:__wf_atom_68fc1021())

		if not (__wf_atom_7e8ad928(__wf_atom_b56d2aa8) or classicControls) then
			__wf_atom_b56d2aa8:Execute("OnPowerModifierHeld", "false")
		end
	end

	if not isPlayingWithController then
		mMovie:__wf_atom_fbca497c(true)
	end

	local uiMode = module3.GetUIMode()
	local v23 = gGameRules:IsA(__wf_atom_88d33e05) or gGameRules:IsA(__wf_atom_3066d015)
	local mInHub = uiMode == module3.UI_MODE_IN_SPACE_HUB or gGameRules:__wf_atom_09e81034()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local mIsOperator = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsA(__wf_atom_c0fefb76)
	local mIsVehicle = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsA(__wf_atom_47cae841)
	v6 = uiMode ~= module3.UI_MODE_IN_DOJO and not (v23 or _T.WareframeChallenge)
	v15 = not __wf_atom_7e8ad928(__wf_atom_b56d2aa8)
		and gGameRules:__wf_atom_af3bd666()
		and module3.ShowTradeUI()
		and not module3.IsPlayerInCrewship()

	if not gGameRules:__wf_atom_95862cc1() then
		fn9(mInHub, mIsOperator, mIsVehicle)
	end

	if not _T.FishingMode then
		fn14()
	end

	v2 = module5.Create(mMovie)

	for k, v24 in v16 do
		mMovie:__wf_atom_e57658c2(v24, 12, 0)
		mMovie:__wf_atom_e57658c2(v24, 4, 5000)
		mMovie:__wf_atom_7d7314f1(v24 .. ".Callout.tf.text", module2.Ternary(k < 3, "<GAMEPAD_LX>", "<GAMEPAD_RX>"))
		mMovie:__wf_atom_7f57ab2f(v24, "Callout", 13, isPlayingWithController)
		mMovie:__wf_atom_7f57ab2f(v24, "DirArrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v24, "WheelIcon", 13, not isPlayingWithController)
		mMovie:__wf_atom_4c1c1986(v24, "GearInfo.Bg", 11, _G.UIColor_Black)
		mMovie:__wf_atom_7f57ab2f(v24, "GearInfo.Bg", 13, true)
		mMovie:__wf_atom_4c1c1986(v24, "GearInfo.Bg", 12, 65)
		mMovie:__wf_atom_933bbce0(v24 .. ".GearInfo.Bg", gearInfoBackerTexture, gearInfoBackerMaterial)
		mMovie:__wf_atom_1ca72041(v24 .. ".GearInfo.Bg", "AAEdgeExtend", 70, 0, 0, 0)
		__wf_atom_86cbd68d(mMovie, v24 .. ".WheelIcon.gotoAndStop", k)
		v2:Register(mMovie, v24, { v2.ANCHOR_H_CENTRE, v2.ANCHOR_V_CENTRE })
	end

	v2:Register(mMovie, "EmoteArrow", { v2.ANCHOR_H_CENTRE, v2.ANCHOR_V_CENTRE })
	v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_e57658c2("TradePanel", 0, 800)
	mMovie:__wf_atom_e57658c2("TradePanel", 1, 450)
	local module6 = require("SF.Interface.Components.Button")
	v10 = module6.Create(
		mMovie,
		"TradePanel.Btn",
		string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/Trade", false)),
		"VendorModePressed",
		"<MENU_GENERIC2>",
		nil,
		nil,
		true
	)
	v10.mSkipLocalization = true
	v10:SetVisible(false)
	mMovie:__wf_atom_2dedec1a("TradePanel", 13, false)
	mMovie:__wf_atom_e57658c2("TradePanel", 12, 0)
	mMovie:__wf_atom_e57658c2("EmoteArrow", 12, 0)
	fn17()

	if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
		print("ScopeDebug: Hide from ConsumablesOverlay")
		v9 = _T.reticleState == false
		__wf_atom_b56d2aa8:Execute("HideReticle", "false")
		__wf_atom_b56d2aa8:Execute("HideAbilityDots", "")
	end

	v3 = true
	flag = false
end

local function fn19(p)
	if flag or v10:IsActive() then
		return
	end

	local v22 = v13[v14]

	if v22 == nil then
		return
	end

	v22.mLeftStick = mLeftStick
	v22.mRightStick = mRightStick
	v22:Update(p)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v3 then
		return
	end

	local v22

	if _T.DisableConsumables == nil then
		v22 = false
	else
		v22 = _T.DisableConsumables > 0
	end

	if v22 or _T.pauseMenuOpen or __wf_atom_7e8ad928(v4) then
		fn()
		return
	end

	local v23 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v23)
	fn19(v23)
end

local function fn20()
	if
		not __wf_atom_7e8ad928(_T.TacticsOverlayTargetPlayer)
		or not __wf_atom_7e8ad928(_T.TacticsOverlayTargetCrew)
		or #v13 == 1
		or flag
	then
		return
	end

	module2.PlaySound(menuScreenTransitionSound)
	local v22 = v13[v14]

	if v22 ~= nil and v22.mClipName ~= nil then
		v22.mDragElement = nil
		__wf_atom_ec43d06e(mMovie, v22.mClipName, 1, {
			12,
			5,
			6,
			function(mInitialX)
				v22.mInitialX = mInitialX
			end
		}, { 0, 90, 90, -0 }, 0.1, 0, function()
			v14 = v14 % #v13 + 1
			v22 = v13[v14]
			fn15()

			if v22 ~= nil and v22.mClipName ~= nil then
				v22.mPrevFocusedElement = nil
				v22:FocusElement(v22.mFocusedIndex or 1)
				__wf_atom_ec43d06e(mMovie, v22.mClipName, 2, {
					12,
					5,
					6,
					function(p)
						v22.mInitialX = 0 + p
					end
				}, { 100, 100, 100, -0 }, 0.15, 0, function()
					v22.mForceUpdate = true
				end)
			end
		end)
	end
end

function SpiralItemPressed(p)
	local v22 = v13[v14]

	if v22 == nil or flag then
		return
	end

	v22:SelectElementById((tonumber(p)))
	module2.PlaySound(_G.UISound_ButtonSelect)
end

function SpiralItemFocused(p)
	local v22 = v13[v14]

	if v22 == nil or flag then
		return
	end

	v22:FocusElementById((tonumber(p)))
end

function SpiralItemUnfocused(p)
	local v22 = v13[v14]

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
	module2.PlaySound(_G.UISound_ButtonSelect)
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
	module2.PlaySound(_G.UISound_ButtonSelect)
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

function onKeyUp_CONSUMABLES_HOLD()
	Close()
	return true
end

function onKeyUp_MINI_INVENTORY_HOLD()
	if Engine.IsPlayingWithController() then
		SelectFocusedElement()
	end

	Close()
	return true
end

function onKeyDown_CONSUMABLES_HOLD()
	fn17()
	return true
end

function onKeyDown_NEXT_MENU()
	local v22 = v13[v14]

	if v22 == nil or not v22.mEditMode or flag then
		fn20()
		return true
	end

	local mElement = v22.mElements[v22.mFocusedIndex]

	if mElement ~= nil and mElement.mItem ~= nil then
		v22:RemoveElement(v22.mFocusedIndex)
		v17 = v14 == 1
		v18 = v14 == 2
	end
end

function onKeyDown_MINI_INVENTORY_TOGGLE()
	Close()
	return true
end

function onKeyDown_CONSUMABLES_TOGGLE()
	if Engine.IsPlayingWithController() then
		SelectFocusedElement()
	end

	Close()
	return true
end

function onKeyUp_SELECT_SUB_GEAR_0()
	Close()
	return false
end

function onKeyUp_SELECT_SUB_GEAR_1()
	Close()
	return false
end

function onKeyUp_SELECT_SUB_GEAR_2()
	Close()
	return false
end

function onKeyDown_MENU_RIGHT_X(_, p)
	mRightStick.X = tonumber(p)
	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	mRightStick.X = tonumber(p)
	return true
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	mRightStick.Y = tonumber(p)
	return true
end

function onKeyUp_MENU_RIGHT_Y(_, p)
	mRightStick.Y = tonumber(p)
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
	local v23 = v13[v14]
	local mEditMode = not (__wf_atom_7e8ad928(v23) or flag) and not v10:IsActive() and v23.mEditMode

	if mEditMode then
		v23.mDragElement = v23:GetFocusedElementIndex()
	end

	return mEditMode
end

function SelectFocusedElement(p, p2)
	v22 = false
	local v23 = p or v13[v14]
	local v24 = not (__wf_atom_7e8ad928(v23) or flag or v10:IsActive())

	if v24 or p2 then
		local focusedElementIndex = v23:GetFocusedElementIndex()

		if not __wf_atom_7e8ad928(focusedElementIndex) then
			if v23.mDragging then
				v17 = v14 == 1
				v18 = v14 == 2
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

	local v23 = v13[v14]

	if v23 == nil then
		return
	end

	local mFocusedIndex = v23.mFocusedIndex
	local v24 = mFocusedIndex == nil and 1 or mFocusedIndex + p

	if not (v23.mLooping and v23.mUseSpiral) then
		v24 = (v24 - 1) % #v23.mElements + 1
	end

	local mDrawElement = v23.mDrawElements[v24]

	if mDrawElement ~= nil and mDrawElement.mClipName ~= nil then
		mMovie:__wf_atom_e57658c2("GearSpiral.DirArrow", 16, mDrawElement.Rotation)
		local v25 = mMovie:__wf_atom_5e6e15c8(mDrawElement.mClipName, 2) / mMovie:__wf_atom_97cd8326()
		local v26 = mMovie:__wf_atom_5e6e15c8(mDrawElement.mClipName, 3) / mMovie:__wf_atom_54eeda24()
		fn5(v25 * mMovie:__wf_atom_d5a50cb5(), v26 * mMovie:__wf_atom_c4f6543f())
	end
end

local function fn22()
	local v23 = _T.Touch_GetTouchedAction == nil and "" or _T.Touch_GetTouchedAction()
	return v23 == "EscGroup" or v23 == "Gear"
end

local function fn23()
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
	if Engine.__wf_atom_dd1285f1() and (fn22() or fn23()) then
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
		if fn22() then
			Close()
			return
		end

		if fn23() then
			fn20()
			return
		end
	end

	if
		not Engine.IsPlayingWithController()
		and mMovie:__wf_atom_5e6e15c8("_root", 30) == -1000
		and mMovie:__wf_atom_5e6e15c8("_root", 31) == -1000
	then
		return false
	end

	Close()
	return true
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
		return (SelectFocusedElement())
	end

	return false
end

function onKeyDown_MENU_CANCEL()
	Close()
	return true
end

function IsInputBlocked()
	return flag
end

function OnGamepadTransition(p)
	local v23 = p == "true"
	mMovie:__wf_atom_fbca497c(v23)
	fn15()

	for k, v24 in v16 do
		mMovie:__wf_atom_7d7314f1(v24 .. ".Callout.tf.text", module2.Ternary(k < 3, "<GAMEPAD_LX>", "<GAMEPAD_RX>"))
		mMovie:__wf_atom_7f57ab2f(v24, "Callout", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_7f57ab2f(v24, "DirArrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v24, "WheelIcon", 13, not Engine.IsPlayingWithController())
		mMovie:__wf_atom_7f57ab2f(v24, "GearInfo.Bg", 13, true)
		__wf_atom_86cbd68d(mMovie, v24 .. ".WheelIcon.gotoAndStop", k)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElement(v5.mCurrentElementIndex)
		v5:Redraw()
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:UnfocusElement(v7.mCurrentElementIndex)
		v7:Redraw()
	end

	if not __wf_atom_7e8ad928(v10) then
		v10:Redraw()
	end

	fn4()
end

function HideScreenForPlatPurchase(p)
	if not v5.mEditMode then
		mMovie:SetVisible(p ~= "true")
	end
end