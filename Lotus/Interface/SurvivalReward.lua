local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CardUtilitiesRedux")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.RewardUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.UIStyleUtilities")
local v = {}
local v2 = nil
local _ = false
local v3 = {}
local v4 = {}
local displayTime2 = 0
local gameData = nil
local v5 = false
local v6 = false

function GetCards()
	return v3
end

function Shutdown()
	_T.DisplayReward = nil
	_T.DisplayMysteryPrize = nil
	_T.DisplayCard = nil
	_T.ResetDisplayTime = nil
end

function GetSelectedCards()
	return nil
end

function GetSelectedElement()
	return nil
end

local function fn()
	_ = true
	mMovie:__wf_atom_e57658c2("Reward", 0, 0)
	mMovie:__wf_atom_e57658c2("Reward.Stand", 0, -400)
	mMovie:__wf_atom_e57658c2("Reward.Item", 12, 0)
	mMovie:__wf_atom_e57658c2("Reward.Item", 0, -110)
	mMovie:__wf_atom_e57658c2("Reward.Card", 12, 0)
	mMovie:__wf_atom_e57658c2("Reward.Card", 1, 40)
	mMovie:__wf_atom_e57658c2("Reward.Highlight", 12, 0)
	mMovie:__wf_atom_e57658c2("Reward.Flare", 12, 0)
	mMovie:__wf_atom_e57658c2("Reward.Title", 12, 0)

	if not __wf_atom_7e8ad928(_T.RailjackHud_Movie) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Reward", 1)
		mMovie:__wf_atom_e57658c2("Reward", 1, __wf_atom_5e6e15c8 - 100)
	end

	module.PlaySound(slideOutSound)
	__wf_atom_ec43d06e(mMovie, "Reward.Stand", 2, { 0 }, { 0 }, 0.4, 0.1)
	v2:AddTimer(0.45, function()
		local rootBasedPosition, v7 = module3.GetRootBasedPosition(mMovie, "Reward.Highlight")
		local screenParticles = module3.CreateScreenParticles(mMovie, celebrationFx, rootBasedPosition, v7)
		module3.ApplyParticleThemeColors(screenParticles)
		__wf_atom_ec43d06e(mMovie, "Reward.Title", 0, { 12 }, { 100 }, 0.35)
		__wf_atom_ec43d06e(mMovie, "Reward.Highlight", 0, { 12 }, { 100 }, 0.35)
		__wf_atom_ec43d06e(mMovie, "Reward.Flare", 0, { 12 }, { 100 }, 0.35, 0, function()
			__wf_atom_ec43d06e(mMovie, "Reward.Flare", 0, { 12 }, { 0 }, 0.95, 0.45)
		end)

		if not v5 then
			__wf_atom_ec43d06e(mMovie, "Reward.Item", 2, { 12, 0 }, { 100, 148 }, 0.35)
			return
		end

		v2:AddTimer(0.2, function()
			module2.ZoomCard(v4[1], v4[1].mClipName .. ".Card", true)
		end)
		__wf_atom_ec43d06e(mMovie, "Reward.Card", 0, { 12, 1 }, { 100, -55 }, 0.35)
	end)
end

local function fn2()
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:Close()
	end)
end

function TransitionOut()
	fn2()
end

local function fn3(upgradeInfo)
	if _G.StalkerMode then
		if not __wf_atom_7e8ad928(mMovie) then
			mMovie:Close()
		end
	else
		displayTime2 = displayTime
		v3[1] = module2.CardFromArtifact(upgradeInfo, 1)
		v3[1].mInstalled = { Fake = 1 }
		v4[1] = {}
		v4[1].mCardIndex = 1
		v4[1].mClipName = "Reward.Card"
		v4[1].mInstalled = 1
		v4[1].mPolarity = 0
		module2.DrawCard(v4[1], nil, nil, true)
		module2.EnableCardVisibleRange(v4[1], v4[1].mClipName .. ".Card", false)
		module2.ZoomCard(v4[1], v4[1].mClipName .. ".Card", false)
		mMovie:__wf_atom_4c1c1986(v4[1].mClipName, "Card.BottomFrame.Equipped", 12, 0)
		mMovie:__wf_atom_2dedec1a("Reward.Item", 13, false)
	end
end

local function fn4(p) -- 3 equivalent calls inferred from this helper
	mMovie:__wf_atom_50d60589("Reward.Item.Name", 36, p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Reward.Item.Name", 40)
	mMovie:__wf_atom_e57658c2("Reward.Item.NameBg", 14, __wf_atom_5e6e15c8 + 50)
end

local function fn5(instance, p, levelOverride, icon, titleText, p2, p3)
	if _G.StalkerMode then
		if not __wf_atom_7e8ad928(mMovie) then
			mMovie:Close()
		end
	else
		if displayTime2 > 0 and p2 then
			table.insert(v, {
				StoreItem = instance,
				ItemInfo = p,
				LevelOverride = levelOverride,
				IconOverride = icon,
				TitleText = titleText
			})
			return
		end

		local itemInfo = type(p) ~= "table" and { itemCount = p } or p
		displayTime2 = module.Ternary(itemInfo.OverrideDisplayTime ~= nil, itemInfo.OverrideDisplayTime, displayTime)
		local v7

		if titleText == "" then
			v7 = false
		else
			v7 = titleText ~= nil
		end

		mMovie:__wf_atom_2dedec1a("Reward.Title", 13, v7)
		mMovie:__wf_atom_2dedec1a("Reward.Item.NameBg", 13, v7)
		mMovie:__wf_atom_e57658c2("Reward.Item", 1, module.Ternary(v7, 20, 47))
		local color = module6.GetColor(9, true)
		local color2 = module6.GetColor(6, true)
		mMovie:__wf_atom_e57658c2("Reward.Item.Name", 44, module.Ternary(v7, color, color2))

		if v7 then
			mMovie:__wf_atom_7d7314f1("Reward.Title.text", titleText)
		end

		local function fn6(p4)
			local ternary = module.Ternary(p4.Themed, 135, 216)
			mMovie:__wf_atom_e57658c2("Reward.Item.Image", 14, ternary)
			mMovie:__wf_atom_e57658c2("Reward.Item.Shadow", 14, ternary)
			mMovie:__wf_atom_e57658c2("Reward.Item.BackingTexture", 14, ternary)
		end

		if __wf_atom_7e8ad928(instance) then
			print("Null storeItem in DisplayReward SurvivalReward.lua")
		elseif instance:IsA(__wf_atom_d5a2d4b7) or instance:IsA(__wf_atom_80168c59) then
			local itemCount

			if itemInfo ~= nil then
				itemCount = itemInfo.itemCount
			end

			local v8 = {
				Name = TitleCase(mMovie:__wf_atom_8e9ac384(instance:__wf_atom_014a76a2():c_str(), false)),
				itemCount = itemCount
			}
			local iconTexture, themed = module5.GetIconTexture(instance, true)
			v8.Icon = iconTexture
			v8.Themed = themed
			module5.DrawItem(mMovie, "Reward.Item", v8)
			fn6(v8)
			local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Reward.Item.Name", 36)

			if v8.itemCount ~= nil and v8.itemCount > 1 then
				__wf_atom_387f260e = module.FormatNumber(v8.itemCount, 0) .. " " .. __wf_atom_387f260e
			end

			mMovie:__wf_atom_2dedec1a("Reward.Item", 13, true)
			mMovie:__wf_atom_2dedec1a("Reward.Card", 13, false)
			mMovie:__wf_atom_50d60589("Reward.Item.Name", 46, "top")
			fn4(__wf_atom_387f260e) -- inferred equivalent call
		else
			local overrideCatergory = itemInfo.OverrideCatergory
			local overrideCount = itemInfo.OverrideCount
			local storeItemInfo = module5.GetStoreItemInfo(
				mMovie,
				instance,
				{ GameData = gameData, ItemInfo = itemInfo, OverrideExisting = false },
				nil,
				nil,
				true
			)
			storeItemInfo.Name = TitleCase(storeItemInfo.Name)
			fn6(storeItemInfo)
			v6 = storeItemInfo.Type ~= nil and storeItemInfo.Type:IsA(railjackItemType)

			if v6 then
				module.PlaySound(railjackItemAppearsSoundSmall)
			else
				module.PlaySound(itemAppearsSound)
			end

			if instance:IsPackage() then
				storeItemInfo.Background = nil
				module5.DrawItem(mMovie, "Reward.Item", storeItemInfo)
				mMovie:__wf_atom_2dedec1a("Reward.Item", 13, true)
				mMovie:__wf_atom_2dedec1a("Reward.Card", 13, false)
			elseif
				storeItemInfo.Type:IsA(__wf_atom_58a409f1)
				and not storeItemInfo.Type:IsA(WeakResource("/SF/Types/Game/BaseCosmeticEnhancer"))
			then
				v5 = true
				local upgradeInfo = SF.UpgradeInfo()
				upgradeInfo.mItemType = storeItemInfo.Type
				upgradeInfo.mItemCount = storeItemInfo.Count

				if levelOverride ~= nil then
					upgradeInfo.mUpgradeFingerprint = upgradeInfo.mInstance:__wf_atom_254ac1f5(levelOverride)
				end

				fn3(upgradeInfo)
			else
				local ternary = module.Ternary(
					overrideCatergory ~= nil,
					overrideCatergory,
					instance:__wf_atom_efa6f447()
				)
				local ternary2 = module.Ternary(overrideCount ~= nil, overrideCount, storeItemInfo.Count)

				if ternary2 > 1 and ternary ~= 35 and ternary ~= 8 then
					storeItemInfo.Name = module.FormatNumber(ternary2, 0) .. " x " .. storeItemInfo.Name
				end

				if icon then
					storeItemInfo.Icon = icon
					storeItemInfo.Themed = false
				end

				if __wf_atom_7e8ad928(storeItemInfo.Icon) then
					storeItemInfo.Icon = blueprintTexture
					storeItemInfo.Background = nil
				end

				module5.DrawItem(mMovie, "Reward.Item", storeItemInfo)
				mMovie:__wf_atom_2dedec1a("Reward.Item", 13, true)
				mMovie:__wf_atom_2dedec1a("Reward.Card", 13, false)
			end

			local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Reward.Item.Name", 36)

			if not (__wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p3.storeItem)) then
				__wf_atom_387f260e ..= " + " .. TitleCase(mMovie:__wf_atom_8e9ac384(
					p3.storeItem:__wf_atom_014a76a2():c_str(),
					false
				))

				if p3.itemCount > 1 then
					__wf_atom_387f260e ..= " x " .. p3.itemCount
				end
			end

			local uiColor_White = _G.UIColor_White

			if storeItemInfo.IconColor ~= nil then
				uiColor_White = module6.GetColor(storeItemInfo.IconColor, true)
			end

			mMovie:__wf_atom_e57658c2("Reward.Item.Image", 11, uiColor_White)
			mMovie:__wf_atom_e57658c2("Reward.Item.Shadow", 11, module6.GetColor(2, true))
			mMovie:__wf_atom_50d60589("Reward.Item.Name", 46, "top")
			fn4(__wf_atom_387f260e) -- inferred equivalent call
		end
	end
end

function SetName(p, p2)
	local v7 = TitleCase(p)

	if p2 ~= nil then
		v7 = p2 .. " x " .. v7
	end

	fn4(v7) -- inferred equivalent call
end

function DisplayPickUpReward(p, p2, name)
	fn5(Resource(p), { itemCount = tonumber(p2), Name = name })
end

local function fn6()
	if _G.StalkerMode then
		if not __wf_atom_7e8ad928(mMovie) then
			mMovie:Close()
		end
	else
		displayTime2 = displayTime
		mMovie:__wf_atom_c90af43a("Reward.Item.Image", questionMarkTexture)
		mMovie:__wf_atom_c90af43a("Reward.Item.Shadow", questionMarkTexture)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Reward.Item.Image", 15)
		mMovie:__wf_atom_e57658c2("Reward.Item.Image", 14, __wf_atom_5e6e15c8)
		mMovie:__wf_atom_e57658c2("Reward.Item.Shadow", 14, __wf_atom_5e6e15c8)
		mMovie:__wf_atom_2dedec1a("Reward.Item", 13, true)
		mMovie:__wf_atom_50d60589(
			"Reward.Item.Name",
			36,
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/UnidentifiedItem", false)
		)
		mMovie:__wf_atom_2dedec1a("Reward.Item.ImageBg", 13, false)
		mMovie:__wf_atom_2dedec1a("Reward.Card", 13, false)
		mMovie:__wf_atom_e57658c2("Reward", 12, 100)
	end
end

function DisplayMysteryPrize()
	fn6()
end

function ShowReward(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(gRegion) or (__wf_atom_7e8ad928((gRegion:__wf_atom_eab484a7())) or _G.StalkerMode) then
		return
	end

	if p2 == "true" then
		fn6()
		return
	end

	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
	local v7 = tonumber(p)
	local v8 = nil

	if p3 == nil then
		if __wf_atom_72fc675e.missionType == 33 then
			v8 = module4.GenerateDisruptionRewards(v7, nil)
		else
			v8 = module4.GenerateSurvivalRewards(v7, nil)
		end
	else
		local randomizedItems

		if p4 == nil then
			randomizedItems = __wf_atom_72fc675e.missionReward.randomizedItems
		else
			randomizedItems = Resource(p4)
		end

		if not __wf_atom_7e8ad928(randomizedItems) then
			v8 = {
				{
					rewardItem = randomizedItems:GetTieredItem(tonumber(p3), 0)
				}
			}
			local v9 = v8[1]

			if not __wf_atom_7e8ad928(v9.rewardItem) then
				v9.storeItem = v9.rewardItem:GetStoreItem()
				v9.itemCount = v9.rewardItem.mItemCount
				local item = v9.rewardItem:GetStoreItem():GetItem()

				if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_58a409f1) then
					v9.item = item
					v9.levelOverride = SF.__wf_atom_79a0f336(item, v9.rewardItem:__wf_atom_a4e01155())
				end
			end
		end
	end

	local v9 = nil

	if #v8 > 0 then
		local v10 = v8[#v8]

		if v10.isBonus and #v8 > 1 then
			v9 = v8[#v8]
			v10 = v8[#v8 - 1]
		end

		local storeItem = v10.storeItem

		if __wf_atom_7e8ad928(storeItem) then
			print("NULL StoreItem passed to SurvivalReward.lua! No reward shown!")
			mMovie:Close()
		else
			_T.lastSurvivalRewardStoreItem = storeItem
			local levelOverride = v10.levelOverride
			local itemCount = v10.itemCount

			if p5 and p5 == "true" then
				__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_912071eb(
					storeItem,
					0,
					true,
					itemCount,
					false
				)

				if not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9.storeItem)) then
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_912071eb(
						v9.storeItem,
						0,
						true,
						v9.itemCount,
						false
					)
				end
			end

			fn5(storeItem, itemCount, levelOverride, nil, nil, nil, v9)
		end
	else
		print("No rewards for SurvivalReward.lua!")
		mMovie:Close()
	end
end

local function fn7() -- 1 equivalent call inferred from this helper
	displayTime2 = displayTime
end

function ResetDisplayTime()
	fn7() -- inferred equivalent call
end

function Initialize()
	if _G.StalkerMode then
		mMovie:Close()
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		gameData = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	local module7 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module7.CreateTimerMgr()
	mMovie:OverrideMaterial("Reward.Item.Shadow", shadowMaterial)
	mMovie:OverrideMaterial("Reward.Flare", flareMaterial)
	local color = module6.GetColor(2, true)
	local color2 = module6.GetColor(9, true)
	local color3 = module6.GetColor(10, true)
	local color4 = module6.GetColor(1, true)
	local color5 = module6.GetColor(6, true)
	mMovie:__wf_atom_e57658c2("Reward.Stand.Bg", 11, color)
	mMovie:__wf_atom_e57658c2("Reward.Stand.Lines", 11, color2)
	mMovie:OverrideMaterial("Reward.Stand.Lines", _G.UIMaterial_VitruvianLines)
	mMovie:__wf_atom_e57658c2("Reward.Highlight.StarburstOne", 11, color4)
	mMovie:__wf_atom_e57658c2("Reward.Highlight.StarburstTwo", 11, color)
	mMovie:__wf_atom_e57658c2("Reward.Highlight.Sparkles", 11, color3)
	mMovie:__wf_atom_e57658c2("Reward.Flare", 11, color3)
	mMovie:__wf_atom_2dedec1a("Reward.Title", 13, false)
	mMovie:__wf_atom_e57658c2("Reward.Title", 44, color5)
	mMovie:__wf_atom_e57658c2("Reward.Title", 90, color)
	mMovie:__wf_atom_e57658c2("Reward.Item.Name", 90, color)
	mMovie:__wf_atom_e57658c2("Reward.Item.NameBg", 11, color)
	fn()
	_T.DisplayReward = fn5
	_T.DisplayMysteryPrize = fn6
	_T.DisplayCard = fn3
	_T.ResetDisplayTime = fn7
end

function Update()
	local v7 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v7)

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v7)
	end

	if displayTime2 > 0 then
		displayTime2 -= v7

		if displayTime2 <= 0 then
			if #v > 0 then
				local v8 = table.remove(v, 1)
				fn5(v8.StoreItem, v8.ItemInfo, v8.LevelOverride, v8.IconOverride, v8.TitleText)
			else
				fn2()
			end
		end
	end
end

function SupportsThemes()
	return true
end