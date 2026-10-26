local module = require("Lotus.Interface.CardUtilitiesRedux")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.UIUtilities")
local module6 = require("Lotus.Interface.UIStyleUtilities")
local module7 = require("EE.Interface.AnchorMgr")
local gameData = nil
local v = nil
local v2 = nil
local v3 = { Loader = nil, IsLoading = false, Res = nil }
local targetDay = 50
local v4 = nil
local v5 = nil
local targetDay2 = 0
local v6 = nil
local v7 = nil
local v8 = nil
local flag = true
local v9 = nil
local v10 = nil
local v11 = { MILESTONE = 1, PICK_A_DOOR = 2, RANDOM = 3 }
local milestone = nil
local mReward = nil
local v12 = {}
local v13 = nil
local v14 = false
local v15 = nil
local v16 = {}
local v17 = nil
local v18 = nil
local v19 = { x = 0, y = 0 }
local v20 = { Y = 0, X = 0, Width = 0, Height = 0 }
local v21 = false
local v22 = 0
local v23 = nil
local v24 = true
local v25 = nil
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = nil
local v30 = nil
local v31 = nil
local v32 = false
local flag2 = true
local flag3 = false
local v36 = true
local v37 = false
local v38 = false
local v39 = nil
local v40 = {}
local inventory = nil
local v41 = nil
local v42 = {}
local v43 = false

function IsInputBlocked()
	return flag
end

local function fn()
	_T.LoginRewardsOpen = false

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	if v38 and not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	mMovie:Close()
end

function Close()
	fn()
end

local function fn2(p)
	local v44 = {}

	if Engine.IsPlayingWithController() and p then
		table.insert(v44, {
			Label = "/Lotus/Language/Menu/Select",
			CallBack = nil,
			CallOut = "MENU_SELECT"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v44, getfenv(1))
	end
end

local function fn3(p, p2, p3)
	__wf_atom_ec43d06e(mMovie, p, 0, { 12 }, { p2 }, 0.5, 0, function()
		__wf_atom_ec43d06e(mMovie, p, 0, { 12 }, { p3 }, 0.5, 0, function()
			fn3(p, p2, p3)
		end)
	end)
end

local function fn4(object)
	local mRewardType = object.mRewardType

	if mRewardType == 1 then
		return mMovie:__wf_atom_8e9ac384("<CREDITS>", true) .. module2.FormatNumber(object.mAmount, 0)
	end

	local v44

	if object.mStoreItemType then
		local v45 = Resource(object.mStoreItemType:__wf_atom_5b41f63b())
		local __wf_atom_014a76a2 = v45:__wf_atom_014a76a2()
		v44 = mMovie:__wf_atom_8e9ac384(tostring(__wf_atom_014a76a2), true)

		if not __wf_atom_7e8ad928(v45:GetItem()) and v45:GetItem():IsA(__wf_atom_3cecff09) then
			v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/BlueprintAndItem", true, {
				ITEM = v44
			})
		end

		if object.mStoreItemType:__wf_atom_efa6f447() == 35 then
			v44 = -object.mStoreItemType:__wf_atom_ee4fa4fd() * object.mAmount .. " " .. v44
		elseif object.mAmount > 1 then
			v44 = object.mAmount .. " x " .. v44
		end

		if object.mDuration > 0 then
			v44 ..= "\r" .. string.upper(module3.SecondsToFormattedTime(mMovie, object.mDuration * 3600, true))
		end
	elseif object.mItemType then
		local __wf_atom_232fd31d = v:__wf_atom_232fd31d(object.mItemType)
		v44 = mMovie:__wf_atom_8e9ac384(tostring(__wf_atom_232fd31d:__wf_atom_014a76a2()), true)

		if
			not __wf_atom_7e8ad928(__wf_atom_232fd31d:GetItem())
			and __wf_atom_232fd31d:GetItem():IsA(__wf_atom_3cecff09)
		then
			v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/BlueprintAndItem", true, {
				ITEM = v44
			})
		end
	elseif mRewardType == 4 then
		local __wf_atom_338cc432 = object:__wf_atom_338cc432()
		local v45

		if __wf_atom_338cc432 == 0 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardPrefix_Secondary", true)
		elseif __wf_atom_338cc432 == 1 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardPrefix_Primary", true)
		elseif __wf_atom_338cc432 == 3 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardPrefix_Suit", true)
		elseif __wf_atom_338cc432 == 5 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardPrefix_Melee", true)
		elseif __wf_atom_338cc432 == 15 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Codex_Sentinels", true)
		elseif __wf_atom_338cc432 == 16 then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Codex_SentinelWeapons", true)
		else
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardError_InvalidCategory", true)
		end

		v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardCountedItem", true, {
			count = object.mAmount,
			item = v45
		})
	elseif mRewardType == 6 then
		v44 = mMovie:__wf_atom_8e9ac384(object.mDisplayName, true)
	else
		v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardError_NotSpecified", true)
	end

	if mRewardType == 4 then
		return (mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SigninRewardSuffix_ItemXP", true, {
			ITEM = v44
		}))
	end

	return v44
end

local function fn5(p, p2, p3)
	local convertColorNumberToProceduralRGB = module2.ConvertColorNumberToProceduralRGB(v28)
	local convertColorNumberToProceduralRGB2 = module2.ConvertColorNumberToProceduralRGB(v27)
	mMovie:__wf_atom_1ca72041(
		p .. ".Background",
		"RectInnerColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		module2.Ternary(p2, 0.5, 0.2)
	)
	mMovie:__wf_atom_1ca72041(
		p .. ".Background",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		module2.Ternary(p2, 0.2, 0.05)
	)
	local ternary = module2.Ternary(p2, v25, v26)
	mMovie:__wf_atom_4c1c1986(p, "Name", 44, ternary)
	mMovie:__wf_atom_4c1c1986(p, "NameCenter", 44, ternary)
	mMovie:__wf_atom_4c1c1986(p, "NameBg", 11, v28)
	mMovie:__wf_atom_4c1c1986(p, "Highlight", 12, module2.Ternary(p2, 15, 0))

	if p2 then
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 11, v25)
	end

	local ternary2 = module2.Ternary(p3, 0, 0.2)
	local ternary3 = module2.Ternary(p3, 0, 0.01)
	local ternary4 = module2.Ternary(p2, 115, 100)
	__wf_atom_ec43d06e(
		mMovie,
		p .. ".Image",
		2,
		{ "adjustcolor_saturation", "_alpha", "_xscale", "_yscale" },
		{ module2.Ternary(p2, 0, -70), module2.Ternary(p2, 100, 85), ternary4, ternary4 },
		ternary2,
		ternary3
	)
	__wf_atom_ec43d06e(
		mMovie,
		p .. ".NameBg",
		0,
		{ 12 },
		{ module2.Ternary(p2, 100, 65) },
		ternary2,
		module2.Ternary(p3, 0, 0.1)
	)
end

local function fn6(p, data, instance, p2)
	local v44 = not __wf_atom_7e8ad928(data) and data.mRewardType == 6
	local ternary = module2.Ternary(v44, p .. ".Coupon", p .. ".Item")

	if v44 then
		mMovie:__wf_atom_7f57ab2f(ternary, "_parent.Item", 13, false)
	else
		mMovie:__wf_atom_7f57ab2f(ternary, "_parent.Coupon", 13, false)
		mMovie:OverrideMaterial(ternary .. ".Background", _G.UIMaterial_RectangleNoDepth)
		fn5(ternary, v41 == ternary, true)
	end

	local flag4 = true
	local item = nil
	local v45 = nil

	if data == nil or __wf_atom_7e8ad928(data.mItemType) or not data.mItemType:IsA(__wf_atom_58a409f1) then
		if
			data == nil
			or __wf_atom_7e8ad928(data.mStoreItemType)
			or __wf_atom_7e8ad928(data.mStoreItemType:GetItem())
			or not data.mStoreItemType:GetItem():IsA(__wf_atom_58a409f1)
		then
			if instance == nil or not (instance:GetItem() and instance:GetItem():IsA(__wf_atom_58a409f1)) then
				flag4 = false
			else
				item = instance:GetItem()
			end
		else
			item = data.mStoreItemType:GetItem()
		end
	else
		item = data.mItemType
	end

	mMovie:__wf_atom_7f57ab2f(ternary, "Image", 13, not flag4)
	mMovie:__wf_atom_7f57ab2f(ternary, "Name", 13, not (flag4 or v44))
	mMovie:__wf_atom_7f57ab2f(ternary, "NameCenter", 13, false)
	mMovie:__wf_atom_7f57ab2f(ternary, "NameBg", 13, not (flag4 or v44))
	mMovie:__wf_atom_7f57ab2f(ternary, "Mod", 13, flag4)
	mMovie:__wf_atom_7f57ab2f(ternary, "CouponTitle", 13, v44)
	mMovie:__wf_atom_7f57ab2f(ternary, "CouponDesc", 13, v44)
	mMovie:__wf_atom_7f57ab2f(ternary, "CouponAmount", 13, v44)
	mMovie:__wf_atom_7f57ab2f(ternary, "ImageBg", 13, false)

	if flag4 then
		local upgradeInfo = SF.UpgradeInfo()
		upgradeInfo.mItemType = item
		upgradeInfo.mItemCount = 1

		if not __wf_atom_7e8ad928(data) then
			upgradeInfo.mItemCount = data.mAmount
		end

		local cardFromArtifact = module.CardFromArtifact(upgradeInfo, 1)
		local v46 = {
			mClipName = ternary .. ".Mod",
			Card = cardFromArtifact,
			mPolarity = 0
		}
		module.DrawCard(v46)
		module.ZoomCard(v46, v46.mClipName .. ".Card", false, 0, nil, nil, nil, 2)
		return v46
	elseif v44 then
		local v46 = data.mCouponType == 0
		mMovie:OverrideMaterial(ternary .. ".Background", _G.UIMaterial_RectangleNoDepth)
		local convertColorNumberToProceduralRGB = module2.ConvertColorNumberToProceduralRGB(v28)
		local convertColorNumberToProceduralRGB2 = module2.ConvertColorNumberToProceduralRGB(v27)
		mMovie:__wf_atom_1ca72041(
			ternary .. ".Background",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			ternary .. ".Background",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.05
		)
		local time = string.upper(module3.SecondsToFormattedTime(mMovie, data.mDuration * 3600, true))
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/DailyTributeCouponTime", true, {
			TIME = time
		})
		mMovie:__wf_atom_4c1c1986(ternary, "Time", 44, v26)
		mMovie:__wf_atom_4c1c1986(ternary, "TimerIcon", 11, v25)
		mMovie:__wf_atom_48bd5a59(ternary, "Time", 36, __wf_atom_8e9ac384)
		mMovie:__wf_atom_4c1c1986(ternary, "CouponDesc", 44, v26)
		mMovie:__wf_atom_7d7314f1(ternary .. ".CouponDesc.text", data.mDisplayName)
		mMovie:__wf_atom_4c1c1986(ternary, "CouponBacker", 11, v30)
		mMovie:__wf_atom_48bd5a59(ternary, "CouponAmount", 36, data.mAmount .. "%")
		mMovie:__wf_atom_4c1c1986(ternary, "CouponAmount", 44, v30)

		if v46 then
			mMovie:__wf_atom_c90af43a(ternary .. ".Image", data.mIcon)
			return v45
		end

		mMovie:__wf_atom_7f57ab2f(ternary, "Image", 13, false)
		return v45
	else
		local v46 = nil
		local name = ""
		local flag5 = true
		mMovie:__wf_atom_7f57ab2f(ternary, "NameCenter", 13, true)
		mMovie:__wf_atom_7f57ab2f(ternary, "Name", 13, false)

		if instance == nil then
			if data ~= nil then
				if data.mStoreItemType then
					v46 = module4.GetStoreItemInfo(mMovie, data.mStoreItemType, {
						GameData = gameData
					})

					if v46.StoreItem and v46.StoreItem:__wf_atom_efa6f447() == 35 then
						v46.Name = mMovie:__wf_atom_8e9ac384(tostring(v46.StoreItem:__wf_atom_014a76a2()), true)
						v46.MetaData = { NameOverride = v46.Name }
					end
				elseif data.mItemType then
					v46 = module4.GetItemTypeWithStoreInfo(mMovie, data.mItemType, v, {
						GameData = gameData
					})
				end

				name = fn4(data)
			end
		else
			for i = 1, #centerNameStoreItems do
				if not instance:IsA(centerNameStoreItems[i]) then
					continue
				end

				mMovie:__wf_atom_7f57ab2f(ternary, "NameCenter", 13, not (flag4 or v44))
				flag5 = true
				break
			end

			v46 = module4.GetStoreItemInfo(mMovie, instance, { GameData = gameData })

			if v46 then
				name = v46.Name
			else
				name = mMovie:__wf_atom_8e9ac384(instance:__wf_atom_014a76a2():c_str(), false)
			end
		end

		if v46 then
			module5.SetItemInfoPopupRect(
				mMovie,
				v46,
				mMovie:__wf_atom_5e6e15c8(ternary .. ".Background", 2),
				mMovie:__wf_atom_5e6e15c8(ternary .. ".Background", 3),
				tonumber(mMovie:__wf_atom_5e6e15c8(ternary, 14) - 80),
				mMovie:__wf_atom_5e6e15c8(ternary .. ".Background", 15)
			)

			if v46.Category == 35 then
				v46.ShowInfoPopupOwned = true
				v46.Count = inventory.mFusionPoints

				if p2 and v46.ShowInfoPopupOwned and data ~= nil then
					local v47 = -data.mStoreItemType:__wf_atom_ee4fa4fd() * data.mAmount
					v46.Count -= v47

					if v46.Count <= 0 then
						v46.ShowInfoPopupOwned = nil
					end
				end
			elseif v46.Category ~= 8 then
				v46.ShowInfoPopupOwned = true
				v46.Count = inventory:__wf_atom_52fcdd65(v46.Type)

				if p2 and v46.ShowInfoPopupOwned and data ~= nil then
					v46.Count -= data.mAmount

					if v46.Count <= 0 then
						v46.ShowInfoPopupOwned = nil
					end
				end
			end

			if v46.MetaData == nil then
				v46.MetaData = {}
			end

			v46.MetaData.HidePrice = true
			v40[p] = v46
			module4.DrawItem(mMovie, ternary, v46, { Name = TitleCase(name), CenterName = flag5 })
		else
			mMovie:__wf_atom_48bd5a59(ternary, "NameCenter", 46, "bottom")
			mMovie:__wf_atom_50d60589(ternary .. ".NameCenter", 36, TitleCase(name))

			if data ~= nil and __wf_atom_7e8ad928(data.mStoreItemType) and __wf_atom_7e8ad928(data.mItemType) then
				mMovie:__wf_atom_c90af43a(ternary .. ".Image", data.mIcon)
			end

			v40[ternary] = nil
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(ternary .. ".Name", 41)
		local v47 = mMovie:__wf_atom_5e6e15c8(ternary .. ".Name", 6) / 100

		if flag5 then
			__wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(ternary .. ".NameCenter", 41)
			v47 = mMovie:__wf_atom_5e6e15c8(ternary .. ".NameCenter", 6) / 100
		end

		local v48 = __wf_atom_5e6e15c8 * v47 + 15
		mMovie:__wf_atom_4c1c1986(ternary, "NameBg", 15, v48)
		return v45
	end
end

local function fn7(p)
	local v44 = p == nil and 0.25 or p
	v9:SetActive(true)
	__wf_atom_ec43d06e(mMovie, "Claim", 2, { 12 }, { 100 }, v44)
	__wf_atom_ec43d06e(mMovie, "ClaimItemHighlight", 2, { 12 }, { 45 }, v44)
	__wf_atom_86cbd68d(mMovie, "ClaimItemHighlight.Sparkles.gotoAndPlay", 1)
end

local function fn8(p)
	local v44 = p == nil and 0.25 or p
	v9:SetActive(false)
	__wf_atom_ec43d06e(mMovie, "Claim", 2, { 12 }, { 0 }, v44)
	__wf_atom_ec43d06e(mMovie, "ClaimItemHighlight", 2, { 12 }, { 0 }, v44)
	__wf_atom_86cbd68d(mMovie, "ClaimItemHighlight.Sparkles.gotoAndStop", 1)
end

function OnMilestoneLoginRewards(p, p2)
	if not p then
		print(p2)
	end
end

function OnChosenLoginRewards(p, p2)
	if not p then
		print(p2)
	end
end

local function fn9()
	flag = true

	if not __wf_atom_7e8ad928(v17) then
		v17:Stop(false)
	end

	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 0.25)
	module2.FadeBackground(mMovie, 1, 0.25, 0, function()
		module2.FadeBackground(mMovie, 0, 0.15, 0, fn)
	end)
end

local function fn10()
	flag = true

	if mReward and v14 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("OnPurchasePlatinum", "")
	end

	if not __wf_atom_7e8ad928(mReward) then
		if mReward.mRewardType == 6 then
			__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("CouponAwarded", "")
		elseif milestone == v11.MILESTONE then
			gameData:__wf_atom_0cc42e30("OnMilestoneLoginRewards", mReward.mStoreItemType)
		elseif milestone == v11.PICK_A_DOOR then
			gameData:__wf_atom_b5421a68("OnChosenLoginRewards", mReward.mStoreItemType)
		end
	end

	gameData:__wf_atom_33d160c3()
	fn9()
end

local function fn11(p)
	v41 = p
	module2.PlaySound(claimSound)
	mMovie:__wf_atom_4c1c1986(p, "_parent.Item", 12, 100)
	__wf_atom_ec43d06e(mMovie, "SelectLabel", 2, { 12 }, { 0 }, 0.35)
	v7:AddTimer(1, function()
		mMovie:__wf_atom_7f57ab2f(p, "_parent.Item", 67, true)
	end)

	if milestone ~= v11.PICK_A_DOOR then
		mMovie:__wf_atom_2dedec1a(p, 67, false)
	end

	if not __wf_atom_7e8ad928(v17) then
		v17:Stop(false)
	end

	if milestone == v11.PICK_A_DOOR then
		for i = 1, 3 do
			local v44 = v16[i].mClipName .. ".Item"

			if v44 == p then
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v16[i].mClipName, 0)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("PickDoor", 1)
				mMovie:__wf_atom_e57658c2("ClaimItemHighlight", 0, __wf_atom_5e6e15c8 + 1175)
				mMovie:__wf_atom_e57658c2("ClaimItemHighlight", 1, __wf_atom_5e6e15c8_2)
				mReward = v16[i].mReward
				local mClipName = v16[i].mClipName
				fn6(mClipName, mReward, nil)
				__wf_atom_ec43d06e(mMovie, mClipName, 8, { 5, 6 }, { 120, 120 }, 0.2)
			else
				__wf_atom_ec43d06e(mMovie, v44, 8, { 5, 6, 12 }, { 80, 80, 0 }, 0.2)
			end

			mMovie:__wf_atom_2dedec1a(v16[i].mClipName, 67, false)
		end

		v32 = false
	end

	fn2()
	flag = true
	mMovie:__wf_atom_e57658c2("ClaimItemHighlight", 12, 100)
	__wf_atom_86cbd68d(mMovie, "ClaimItemHighlight.Sparkles.gotoAndPlay", 1)
	v7:AddTimer(1.5, fn10)
end

function UnlockMidPoint(p)
	module2.CreateParticles(mMovie, p, unlockParticles, 0, 0, __wf_atom_392793db)
end

local function fn12()
	local module8 = require("EE.Interface.Components.List")
	v6 = module8.CreateList(mMovie, "Milestone.Arrows.Arrow")
	v6.mForcedVerticalSeparation = 0
	v6.mForcedHorizontalSeparation = 15
	v6.mDayOffset = 0

	function v6.mElementDrawCallback(data)
		local v44 = "Empty"
		local v45 = v26
		local v46 = nil
		local v47 = nil
		mMovie:__wf_atom_4c1c1986(data.mClipName, "LineLeft", 11, v45)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "LineRight", 11, v45)
		local howManyElements = v6:GetHowManyElements()

		if data.Id == 1 or data.Id == howManyElements then
			v44 = "Edge"
		else
			if data.Day > 0 and data.Day < targetDay then
				v45 = v26
				v44 = "Filled"
			end

			if data.Milestone then
				v46 = v25
				v47 = v26
				v44 = "Milestone"
				v45 = nil
			end
		end

		__wf_atom_86cbd68d(mMovie, data.mClipName .. ".gotoAndStop", v44)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Flare", 12, 0)

		if data.Day < 1 then
			if data.Id == 1 then
				mMovie:__wf_atom_4c1c1986(
					data.mClipName,
					"LineRight",
					14,
					(v6.mForcedHorizontalSeparation + 2.75) * math.abs(data.Day) + 4
				)
			else
				mMovie:__wf_atom_e57658c2(data.mClipName, 12, 0)
			end
		end

		if v45 then
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow", 11, v45)
		else
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow.Inner", 11, v46)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow.Outer", 11, v47)
		end

		if v44 == "Empty" or v44 == "Edge" then
			mMovie:OverrideMaterial(data.mClipName .. ".Arrow", rightVisibleRangeMat)
			mMovie:__wf_atom_1ca72041(data.mClipName .. ".Arrow", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)
		else
			mMovie:OverrideMaterial(data.mClipName .. ".Arrow.Inner", rightVisibleRangeMat)
			mMovie:OverrideMaterial(data.mClipName .. ".Arrow.Outer", rightVisibleRangeMat)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Arrow.Inner",
				"RipplesColor",
				v31.red,
				v31.green,
				v31.blue,
				0.4
			)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Arrow.Outer",
				"RipplesColor",
				v31.red,
				v31.green,
				v31.blue,
				0.4
			)
		end

		mMovie:OverrideMaterial(data.mClipName .. ".LineLeft", rightVisibleRangeMat)
		mMovie:OverrideMaterial(data.mClipName .. ".LineRight", rightVisibleRangeMat)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "LineRight", 12, 50)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "LineLeft", 12, 50)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".LineLeft", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".LineRight", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)

		if data.Id == 1 then
			mMovie:__wf_atom_4c1c1986(
				data.mClipName,
				"LineLeft",
				14,
				40 - v6.mForcedHorizontalSeparation * (v6.mDayOffset - math.floor(v6.mDayOffset))
			)
		elseif data.Id == howManyElements then
			mMovie:__wf_atom_4c1c1986(
				data.mClipName,
				"LineRight",
				14,
				40 - v6.mForcedHorizontalSeparation * -(v6.mDayOffset - math.floor(v6.mDayOffset))
			)
		end
	end
end

local function fn13(p)
	v6:RemoveElements(true, true)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TransmissionFrame", 14)
	v5 = nil
	local v44 = math.floor((math.ceil(__wf_atom_5e6e15c8 / v6.mForcedHorizontalSeparation) + 1) / 2.5) + 2
	local v45 = math.floor(targetDay + v6.mDayOffset)
	local v46 = v6.mDayOffset - math.floor(v6.mDayOffset)
	local count = 0
	local v47 = nil
	local v48 = nil

	for i = v45 - v44, v45 + v44 do
		local milestone2 = nil
		count += 1

		if i > 0 then
			if i == targetDay and v2.mIsMilestoneDay then
				milestone2 = true
			elseif i % 50 == 0 then
				milestone2 = true
			elseif i == targetDay2 then
				milestone2 = true
			elseif targetDay < i and v2.mNextMilestoneReward ~= nil then
				milestone2 = true
			elseif i < targetDay and v2.mPreviousMilestoneReward ~= nil then
				milestone2 = true
			else
				milestone2 = milestone2
			end

			if v47 == nil and i == targetDay2 then
				v47 = count
			end
		end

		local v50 = v6:AddElement({ Day = i, Milestone = milestone2 }, true)

		if i == targetDay then
			v5 = v50
		end

		if i == v45 then
			v48 = -v6:CalculateX(v50) + 3 - v46 * v6.mForcedHorizontalSeparation
		end
	end

	v6:Redraw(nil, nil, p)

	if not __wf_atom_7e8ad928(v5) then
		local howManyElements = v6:GetHowManyElements()

		if v5.Id ~= 1 and v5.Id ~= howManyElements then
			v4 = -v6:CalculateX(v5) + 3
			__wf_atom_86cbd68d(mMovie, v5.mClipName .. ".gotoAndStop", "Filled")
			mMovie:__wf_atom_4c1c1986(v5.mClipName, "Arrow", 11, v25)
			mMovie:__wf_atom_4c1c1986(v5.mClipName, "Flare", 12, 100)
			mMovie:OverrideMaterial(v5.mClipName .. ".Flare", currentDayMaterial)
			mMovie:__wf_atom_4c1c1986(v5.mClipName, "Flare", 11, v25)
			mMovie:OverrideMaterial(v5.mClipName .. ".Arrow", rightVisibleRangeMat)
		end
	end

	if flag2 then
		flag2 = false
		mMovie:__wf_atom_e57658c2("Milestone.Arrows", 0, v48 + v6.mForcedHorizontalSeparation)
		mMovie:__wf_atom_e57658c2("Milestone.NewDayCelebration", 11, v25)
	else
		mMovie:__wf_atom_e57658c2("Milestone.Arrows", 0, v48)
	end

	if v47 == nil then
		if v6:GetElementInIndex(1).Day <= targetDay2 then
			v23 = v22
		end
	else
		local elementInIndex = v6:GetElementInIndex(v47)
		v23 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0) + mMovie:__wf_atom_5e6e15c8("Milestone.Arrows", 0)

		if v22 < v23 then
			v23 = v22
		end
	end
end

function Shutdown()
	_T.PauseNotifications = false
	_T.BlockAmbientTransmissions = false
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.HasDailyTribute = nil
	_T.DailyTributeOpen = nil
	_T.BlockTransmissionFadeOut = nil
	module3.RegisterHideNotifications(false)
	module5.ClearGridModMaterials()
	module5.SetupLoginLighting(false, _T.PlayerLight, _T.PriorLightMapTint)
	_T.PlayerLight = nil
	_T.PriorLightMapTint = nil
	local movie = __wf_atom_8e4fda44:FindMovie(transmissionMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("PreviewClose", "")
	end

	print("DailyTribute: Wrapping up")

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		print("DailyTribute: Hiding BG")
		_T.HideBackground(nil, 0)
	end

	module3.PlayLoginAnim(standFromKneelAnim, false)

	if not __wf_atom_7e8ad928(v17) then
		v17:Stop(false)
	end

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		print("DailyTribute: Restore Camera")
		_T.BackgroundMovie:Execute("ClearCurrentCameraSpot", "0.5")
	end
end

local function fn14(_)
	local mFitToText = mReward.mCouponType == 0
	v10:SetVisible(mFitToText and not Engine.__wf_atom_eecb6143())
	v10:SetActive(mFitToText)
	v10:Redraw()
	v9.mFitToText = mFitToText
	v9:Redraw()

	if mFitToText and not Engine.__wf_atom_eecb6143() then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v10.mClipName .. ".Btn", 14)
		local v45 = -((__wf_atom_5e6e15c8 + mMovie:__wf_atom_5e6e15c8(v9.mClipName .. ".Btn", 14) + 15) / 2)
		mMovie:__wf_atom_e57658c2(v10.mClipName, 0, v45)
		mMovie:__wf_atom_e57658c2(v9.mClipName, 0, v45 + __wf_atom_5e6e15c8 + 15)
	else
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v9.mClipName .. ".Btn", 14)
		mMovie:__wf_atom_e57658c2(v9.mClipName, 0, -__wf_atom_5e6e15c8 / 2)
	end

	if __wf_atom_7e8ad928(mReward) or mReward.mRewardType ~= 6 then
		v7:AddTimer(1.5, fn10)
	else
		fn7()
	end
end

local function fn15()
	module2.PlaySound(hiddenDoorPresentSound)
	local v44 = not __wf_atom_7e8ad928(mReward) and mReward.mRewardType == 6
	local v45 = mMovie:__wf_atom_5e6e15c8("RandomReward", 1) + 100
	mMovie:__wf_atom_e57658c2("SelectLabel", 1, v45)
	mMovie:__wf_atom_7d7314f1("SelectLabel.text", "/Lotus/Language/Menu/DailyTributeClaimReward")
	mMovie:__wf_atom_e57658c2("RandomReward.Item", 12, 0)
	__wf_atom_ec43d06e(mMovie, "RandomReward.Item", 2, { 12, 4 }, { 100, 0 }, 0.35, 0.15)
	mMovie:__wf_atom_e57658c2("RandomReward", 12, 100)
	mMovie:__wf_atom_4c1c1986("RandomReward.Item", "Item.Btn", 100, 0)

	if v44 then
		fn14("RandomReward.Item")
	else
		mMovie:SetCallbacks(
			"RandomReward.Item.Item.Btn",
			"ChosenRewardRollOver",
			"ChosenRewardRollOut",
			"ChosenRewardSelected",
			nil
		)
		v39 = "/Lotus/Language/Menu/DailyTributeClaimReward"
	end

	v15 = fn6("RandomReward.Item", mReward, nil, true)
	mMovie:__wf_atom_2dedec1a("RandomReward.Item", 67, true)
end

local function fn16()
	module2.PlaySound(hiddenDoorShuffleSound)
	v16 = {}

	for i = 1, 3 do
		v16[i] = {}
		v16[i].mClipName = "PickDoor.Item" .. i
		v16[i].mInitialX = mMovie:__wf_atom_5e6e15c8(v16[i].mClipName, 0)
	end

	mMovie:__wf_atom_e57658c2(v9.mClipName, 1, mMovie:__wf_atom_5e6e15c8(v16[1].mClipName, 1) + 110)

	for i = 1, 3 do
		local v44 = i
		v7:AddTimer(i * 0.12, function()
			module2.CreateParticles(mMovie, v16[v44].mClipName, randomRewardSetParticles, 0, 0, __wf_atom_392793db)

			if v44 == 3 then
				v32 = true
			end
		end)
	end

	mMovie:__wf_atom_2dedec1a("PickDoor", 67, true)
	fn2(true)

	for i = 1, 3 do
		mMovie:__wf_atom_4c1c1986(v16[i].mClipName, "Item.Btn", 100, i)
		mMovie:SetCallbacks(
			v16[i].mClipName .. ".Item.Btn",
			"ChosenRewardRollOver",
			"ChosenRewardRollOut",
			"ChosenRewardSelected",
			nil
		)
		v16[i].mReward = v12[i]
		fn6(v16[i].mClipName, v12[i], nil)
	end
end

local function fn17(p)
	if p == 0 then
		return "RandomReward.Item"
	end

	return v16[p].mClipName
end

function ChosenRewardRollOver(p)
	local v44 = fn17(p)

	if v24 and v44 ~= nil and v40[v44] ~= nil then
		_T.InfoPopup_Data = v40[v44]
	end

	fn5(v44 .. ".Item", true)
	v17 = module2.PlaySound(lockBoxHoverSound)
end

function ChosenRewardRollOut(p)
	local v44 = fn17(p) .. ".Item"
	_T.InfoPopup_Data = nil
	fn5(v44, v41 == v44)

	if not __wf_atom_7e8ad928(v17) then
		v17:Stop(false)
	end
end

function ChosenRewardSelected(p)
	if flag then
		return
	end

	local v44 = fn17(p)
	v24 = false
	_T.InfoPopup_Data = nil
	fn11(v44 .. ".Item")
end

local function fn18()
	module2.PlaySound(hiddenDoorPresentSound)
	local v44 = mMovie:__wf_atom_5e6e15c8("PickDoor", 1) + 100
	mMovie:__wf_atom_e57658c2("SelectLabel", 1, v44)
	v39 = "/Lotus/Language/Menu/DailyTributeChooseReward"
	mMovie:__wf_atom_7d7314f1("SelectLabel.text", v39)

	for i = 1, 3 do
		local v45 = "PickDoor.Item" .. i
		mMovie:__wf_atom_e57658c2(v45, 12, 0)
		fn6(v45, v12[i], nil)
		__wf_atom_ec43d06e(mMovie, v45, 2, { 12, 4 }, { 100, 0 }, 0.35, (i + 1) * 0.15)
	end

	mMovie:__wf_atom_e57658c2("PickDoor", 12, 100)
	fn16()
end

local function fn19()
	local __wf_atom_7fab15e3 = gGameRules:__wf_atom_7fab15e3(milestone == v11.MILESTONE)

	for i = 1, #__wf_atom_7fab15e3 do
		if v18:GetHowManyElements() >= 3 then
			break
		end

		local mAcquired = __wf_atom_7fab15e3[i].mAcquired

		if mAcquired then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(mMovie, __wf_atom_7fab15e3[i].mStoreItemType, {
			AppendInfo = { Acquired = mAcquired, Reward = __wf_atom_7fab15e3[i] }
		}, nil, nil, true)
		v18:AddElement(storeItemInfo, true)
	end

	local howManyElements = v18:GetHowManyElements()

	if howManyElements < v18.mColumns then
		v18.ElementXOffset = module2.Round((v18.mColumns * v18.mColumnSeparation - howManyElements * v18.mColumnSeparation) / 2)
	end

	v18:Redraw()
end

local function fn20(p)
	module3.ForceCloseTransmission(true)
	mMovie:__wf_atom_2dedec1a("TransmissionFrame", 13, true)
	_T.TransmissionOverrideMovie = mMovie
	_T.TransmissionOverrideMainClipName = "TransmissionFrame"
	_T.TransmissionOverrideSubtitles = true
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TransmissionFrame", 14)
	mMovie:__wf_atom_e57658c2("TransmissionFrame", 15, __wf_atom_5e6e15c8 / 1.6)
	local v44 = mMovie:__wf_atom_5e6e15c8("TransmissionFrame", 6) / 100
	mMovie:__wf_atom_e57658c2("TransmissionFrame.Message", 6, 100 / v44)
	mMovie:__wf_atom_e57658c2("TransmissionFrame.Message", 1, __wf_atom_5e6e15c8 / 1.6 - 50)
	module3.CreateHudlessTransmission(p)
end

local function fn21(object)
	local activeQuest = gameData:GetInventory():GetActiveQuest()

	if not __wf_atom_7e8ad928(activeQuest) and activeQuest:IsA(newWarKeyChain) then
		local v44 = Resource(activeQuest)

		if module3.GetQuestInfo(gameData, v44) >= 5 then
			return newWarTransmission
		end
	end

	local v44 = tonumber(object.mTransmissionSource) + 1
	local transmissionKeychain = transmissionKeychains[v44]

	if __wf_atom_7e8ad928(transmissionKeychain) or module3.HasCompletedQuest(transmissionKeychain) then
		return (object:__wf_atom_b4a422ed())
	end

	return defaultTransmission
end

local function fn22()
	milestone = nil
	v6:RunForAllElements(function(p)
		if p.Milestone and p.Day == targetDay then
			milestone = v11.MILESTONE
		end
	end)

	if milestone == nil then
		if v2.mIsChooseRewardSet then
			milestone = v11.PICK_A_DOOR
		else
			milestone = v11.RANDOM
		end
	end

	mMovie:__wf_atom_e57658c2("SelectLabel", 12, 0)
	fn19()
	local reward

	if v18 and v18:GetHowManyElements() > 0 then
		reward = v18:GetElementInIndex(1).Reward
		local ternary = module2.Ternary(
			reward.mMilestoneType + 1 > #milestonePreviewIcons,
			#milestonePreviewIcons,
			reward.mMilestoneType + 1
		)
		local milestonePreviewIcon = milestonePreviewIcons[ternary]
		mMovie:__wf_atom_c90af43a("Milestone.MilestonePreview.Icon", milestonePreviewIcon)
		v37 = v18:GetHowManyElements() < 3
	end

	local res = nil

	if milestone == v11.MILESTONE then
		if not __wf_atom_7e8ad928(reward) then
			res = fn21(reward)
		end

		mMovie:__wf_atom_e57658c2("BottomLines", 12, module2.Ternary(v37, 50, 0))
	elseif __wf_atom_7e8ad928(mReward) then
		if milestone == v11.PICK_A_DOOR and #v12 > 0 then
			res = fn21(v12[1])
			v36 = false
		end
	else
		res = fn21(mReward)
	end

	if milestone ~= v11.MILESTONE then
		mMovie:__wf_atom_e57658c2("BottomLines", 12, module2.Ternary(v36, 50, 0))
	end

	if not __wf_atom_7e8ad928(res) then
		v3.Res = res
		local v45 = { res:__wf_atom_5b41f63b() }
		v3.IsLoading = true
		v3.Loader = UISys.__wf_atom_c0dbe47c(v45, true)
	end

	if milestone == v11.PICK_A_DOOR then
		fn18()
		v7:AddTimer(1, function()
			__wf_atom_ec43d06e(mMovie, "SelectLabel", 0, { 12 }, { module2.Ternary(v39 ~= nil, 100, 0) }, 0.15)
		end)
	elseif milestone == v11.RANDOM then
		fn15()

		if not __wf_atom_7e8ad928(mReward) and mReward.mRewardType ~= 6 then
			v7:AddTimer(0.75, function()
				__wf_atom_ec43d06e(mMovie, "SelectLabel", 0, { 12 }, { module2.Ternary(v39 ~= nil, 100, 0) }, 0.15)
			end)
		end
	elseif milestone == v11.MILESTONE then
		if math.ceil(v18:GetHowManyElements() / v18.mColumns) > 1 then
			local v45 = v18.mRows * v18.mRowSeparation
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("MilestoneGrid", 1)
			mMovie:__wf_atom_e57658c2("Claim", 1, __wf_atom_5e6e15c8 + v45)
		end

		v18.Visible = true
		mMovie:__wf_atom_2dedec1a("MilestoneGrid", 13, true)
		__wf_atom_ec43d06e(mMovie, "MilestoneGrid", 0, { 12 }, { 100 }, 0.15)
		local v45 = mMovie:__wf_atom_5e6e15c8("RandomReward", 1) + 100
		mMovie:__wf_atom_e57658c2("SelectLabel", 1, v45)
		v39 = "/Lotus/Language/Menu/DailyTributeChooseReward"
		__wf_atom_ec43d06e(mMovie, "SelectLabel", 0, { 12 }, { 100 }, 0.15)
		mMovie:__wf_atom_7d7314f1("SelectLabel.text", v39)
		local flag4 = true

		for i = 1, #v18.mElements do
			if not v18.mElements[i].Acquired then
				flag4 = false
			end
		end

		if flag4 then
			fn7()
		end
	end
end

function Continue()
	fn22()
end

function OnClaimReward(p)
	v13 = p
end

function Claim()
	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("LOGIN_COUPON_POPUP"), "Claim")
	end

	if flag then
		return
	end

	module2.PlaySound(claimSound)
	fn10()
end

function ClaimAndUseCoupon()
	v14 = true

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("LOGIN_COUPON_POPUP"), "ClaimAndUseCoupon")
	end

	module2.PlaySound(claimSound)
	fn10()
end

local function fn23()
	flag = false
	module2.FadeBackground(mMovie, 0.55, 0.5)
	__wf_atom_ec43d06e(mMovie, "Header", 1, { 12 }, { 100 }, 0.5)
	__wf_atom_ec43d06e(mMovie, "Milestone", 1, { 12 }, { 100 }, 0.5)
	local transmission = nil

	for i = 1, #v42 do
		if targetDay ~= v42[i].Day then
			continue
		end

		transmission = v42[i].Transmission
		break
	end

	if __wf_atom_7e8ad928(transmission) and math.random() <= 0.1 and #randomDayTransmissions > 0 then
		transmission = randomDayTransmissions[math.random(1, #randomDayTransmissions)]
	end

	if not __wf_atom_7e8ad928(transmission) then
		module3.CreateHudlessTransmission(transmission)
	end

	__wf_atom_ec43d06e(mMovie, "Milestone.Arrows", 1, { 0 }, { v4 }, 0.5, 0.3, function()
		if v5.Milestone == nil then
			__wf_atom_86cbd68d(mMovie, v5.mClipName .. ".gotoAndStop", "Filled")
		end

		mMovie:__wf_atom_50d60589("Header.CurrentDay", 36, targetDay)
		mMovie:__wf_atom_e57658c2("Header.CurrentDayPulse", 12, 100)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Header.CurrentDayPulse", 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Header.CurrentDayPulse", 1)
		__wf_atom_ec43d06e(mMovie, "Header.CurrentDayPulse", 2, { 5, 6, 12, 0, 1 }, {
			140,
			140,
			0,
			__wf_atom_5e6e15c8 * 1.4,
			__wf_atom_5e6e15c8_2 * 1.4
		}, 1)
		__wf_atom_86cbd68d(mMovie, "Milestone.NewDayCelebration.gotoAndPlay", 2)
		fn13(true)
		flag3 = true
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview", 0, v23)

		if v23 == v22 then
			mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 12, 100)
		else
			mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 12, 0)
		end
	end)
	__wf_atom_ec43d06e(mMovie, "LeftFade", 8, { 12 }, { 40 }, 1, 0.3)
	__wf_atom_ec43d06e(mMovie, "RightFade", 8, { 12 }, { 40 }, 1, 0.3)
	fn22()
end

local function fn24(p, p2, p3, p4)
	local module8 = require("Lotus.Interface.Components.ThemedButton")
	return (module8.Create(mMovie, p, p2, p3, p4, nil, true))
end

local function fn25()
	local v44 = mMovie:__wf_atom_5e6e15c8("TransmissionFrame", 14) - 60
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Header", 0)
	rightVisibleRangeMat:__wf_atom_a042ff6c(
		SF.__wf_atom_5ddc828f,
		module2.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8, true)
	)
	rightVisibleRangeMat:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, module2.GetVisibilitySize(mMovie, v44, true))
	rightVisibleRangeMat:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, module2.GetVisibilityFadeSize(mMovie, 25))
end

local function fn26()
	local module8 = require("EE.Interface.Components.Grid")
	v18 = module8.CreateGrid(mMovie, "MilestoneGrid.GridItem", nil, 3, 4)
	v18:SetCallbacks("MilestoneItemPressed", "MilestoneItemFocused", "MilestoneItemUnfocused")
	v18.ElementDimBuffer = 16
	v18.ElementWidth = 178
	v18.ElementHeight = 178
	v18.Width = 700
	v18.Height = 211
	v18.ElementXOffset = 0
	v18.mVisible = false
	v18.mWrapAroundNavigation = false
	v18.mSelectElementsOnFocus = false
	v18.mSkipRefocusOnScrollRedraw = true
	v18.mUseCornerForSelected = false
	module5.InitializeGridItem(mMovie, v18)

	function v18:CalculateX(p)
		return (self.UTIL.Round(self.mInitialX + (self:GetElementColumn(p) - 1) * self.mColumnSeparation + self.ElementXOffset))
	end

	function v18.mClipCreatedCallback(p, _)
		module5.OnGridItemCreated(mMovie, v18, p)
	end

	function v18.mOnFocusedCallback(data)
		if data == nil or data.mClipName == nil or not v24 then
			return
		end

		local onGridItemFocusChanged = module5.OnGridItemFocusChanged
		local mMovie = mMovie
		onGridItemFocusChanged(mMovie, v18, data, {
			HideLockedOnFocus = true,
			IsFocused = true,
			IsSelected = v18.SelectedElement ~= nil and v18.SelectedElement.Id == data.Id,
			ShowInfoPopup = v24 and data.mMod == nil,
			ZoomYShift = 0
		})
	end

	function v18.mOnUnfocusedCallback(p)
		if p == nil or p.mClipName == nil or not v24 then
			return
		end

		local onGridItemFocusChanged = module5.OnGridItemFocusChanged
		local mMovie = mMovie
		onGridItemFocusChanged(mMovie, v18, p, {
			HideLockedOnFocus = true,
			IsFocused = false,
			IsSelected = v18.SelectedElement ~= nil and v18.SelectedElement.Id == p.Id,
			ZoomYShift = 0
		})
	end

	function v18.mOnSelectedCallback(selectedElement)
		if selectedElement == nil or selectedElement.Acquired or milestone ~= v11.MILESTONE then
			module2.PlaySound(_G.UISound_Error)
			return
		end

		if not v24 then
			return
		end

		v24 = false
		_T.InfoPopup_Data = nil

		if v18.SelectedElement ~= nil then
			module5.DrawGridItem(mMovie, v18, v18.SelectedElement, {
				IsFocused = false,
				IsSelected = false
			})
		end

		v18.SelectedElement = selectedElement
		mReward = selectedElement.Reward
		module5.DrawGridItem(mMovie, v18, selectedElement, {
			IsFocused = true,
			IsSelected = true,
			ZoomYShift = 0
		})
		mMovie:__wf_atom_e57658c2(
			"ClaimItemHighlight",
			0,
			mMovie:__wf_atom_5e6e15c8("MilestoneGrid", 0) + mMovie:__wf_atom_5e6e15c8(selectedElement.mClipName, 0)
		)
		__wf_atom_ec43d06e(mMovie, "ClaimItemHighlight", 2, { 12 }, { 100 }, 0.25)
		__wf_atom_86cbd68d(mMovie, "ClaimItemHighlight.Sparkles.gotoAndPlay", 1)
		module2.PlaySound(claimSound)
		v18:RunForAllElements(function(p)
			if p.MetaData.IsSelected then
				__wf_atom_ec43d06e(mMovie, p.mClipName, 8, { 5, 6 }, { 120, 120 }, 0.2)
			else
				__wf_atom_ec43d06e(mMovie, p.mClipName, 8, { 5, 6, 12 }, { 80, 80, 0 }, 0.2)
			end
		end)
		__wf_atom_ec43d06e(mMovie, "SelectLabel", 8, { 12 }, { 0 }, 0.2)
		v7:AddTimer(1.5, fn10)
	end

	function v18:mElementDrawCallback()
		if self == nil or self.mClipName == nil then
			return
		end

		local focusedElement = v18:GetFocusedElement()
		local isFocused

		if focusedElement == nil then
			isFocused = false
		else
			isFocused = focusedElement.Id == self.Id
		end

		self.CanPreview = not v2.mIsMilestoneDay
		local v45 = {
			IsFocused = isFocused,
			Locked = self.Acquired,
			ShowCheckmark = self.Acquired,
			HideOwned = true,
			HidePrice = true,
			HideMastery = true,
			ZoomYShift = 0
		}
		module5.DrawGridItem(mMovie, v18, self, v45)

		if v45.Locked then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Locked.LabelBg", 13, false)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Locked.Label", 13, false)
		end
	end

	v18:AttachScrollBar("MilestoneGrid.ScrollBar", -23)
	v18.mScrollBarHorizontalOffset = 95
	v18:EnableSmoothScroll()
end

function Initialize()
	mMovie:SetVisible(false)
end

local function fn27()
	local movie = __wf_atom_8e4fda44:FindMovie(pauseMenuMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end

	mMovie:SetVisible(true)
	_T.LoginRewardsOpen = true
	_T.PauseNotifications = true
	_T.BlockAmbientTransmissions = true

	if __wf_atom_7e8ad928(_T.PriorLightMapTint) then
		_T.PriorLightMapTint = Color(255, 255, 255)
	end

	module3.RegisterHideNotifications(true)
	_T.DailyTributeOpen = true
	mMovie:__wf_atom_40912f8e(true)
	v38 = not _T.UIInputEnabled

	if v38 and not __wf_atom_7e8ad928(_T.EnableUIInput) then
		_T.EnableUIInput()
	end

	v42 = {
		{ Day = 1, Transmission = day1Transmission },
		{ Day = 3, Transmission = day3Transmission }
	}
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		gameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	assert(not __wf_atom_7e8ad928(gameData))
	v2 = gameData:__wf_atom_16fddaaa()
	targetDay = math.max(v2.mLoginDays, 1)
	targetDay2 = module2.Ternary(v2.mIsMilestoneDay, targetDay, v2.mNextMilestoneDay)
	inventory = gameData:GetInventory()
	v = gGameRules:__wf_atom_964056fd()
	local mLoginRewardList = v2.mLoginRewardList

	if v2.mIsChooseRewardSet then
		v12 = {}

		for i = #mLoginRewardList, 1, -1 do
			table.insert(v12, mLoginRewardList[i])
		end
	elseif not v2.mIsMilestoneDay and #mLoginRewardList >= 1 then
		mReward = mLoginRewardList[1]
	end

	if __wf_atom_7e8ad928(_T.PlayerLight) then
		local _t = _T
		local _t2 = _T
		local playerLight, priorLightMapTint = module5.SetupLoginLighting(true, nil, nil, themeLight)
		_t.PlayerLight = playerLight
		_t2.PriorLightMapTint = priorLightMapTint
	end

	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v7 = module8.CreateTimerMgr()
	v8 = module7.Create(mMovie)
	v8:Register(mMovie, "BottomLines", { v8.ANCHOR_V_BOTTOM })
	v8:Register(mMovie, "LeftFade", { v8.ANCHOR_H_LEFT, v8.ANCHOR_V_CENTRE })
	v8:Register(mMovie, "RightFade", { v8.ANCHOR_H_RIGHT, v8.ANCHOR_V_CENTRE })
	v8:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v25 = module6.GetColor(10, true)
	v26 = module6.GetColor(9, true)
	v27 = module6.GetColor(1, true)
	v28 = module6.GetColor(2, true)
	v29 = module6.GetColor(5, true)
	v30 = module6.GetColor(6, true)
	local color = module6.GetColor(6)
	v31 = {
		red = color.red / 255,
		green = color.green / 255,
		blue = color.blue / 255
	}

	if v2.mIsMilestoneDay then
		mMovie:__wf_atom_7d7314f1("Header.Title.text", "/Lotus/Language/Menu/DailyTributeMilestoneTitle", false)
	else
		mMovie:__wf_atom_7d7314f1("Header.Title.text", "/Lotus/Language/Menu/DailyTributeTitle", false)
	end

	mMovie:__wf_atom_e57658c2("Header", 12, 0)
	mMovie:OverrideMaterial("Header.Flare", flareMaterial)
	mMovie:__wf_atom_e57658c2("Header.Title", 44, v26)
	mMovie:__wf_atom_50d60589("Header.CurrentDay", 36, targetDay - 1)
	mMovie:__wf_atom_e57658c2("Header.CurrentDay", 44, v26)
	mMovie:__wf_atom_e57658c2("Header.CurrentDay", 12, 25)
	mMovie:__wf_atom_e57658c2("Header.CurrentDayPulse", 44, v26)
	mMovie:__wf_atom_50d60589("Header.CurrentDayPulse", 36, targetDay)
	mMovie:__wf_atom_e57658c2("Header.CurrentDayPulse", 12, 0)
	mMovie:OverrideMaterial("Header.Title", textShineMaterial)
	mMovie:__wf_atom_1ca72041("Header.Title", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)
	mMovie:OverrideMaterial("Header.CurrentDay", textShineMaterial)
	mMovie:__wf_atom_1ca72041("Header.CurrentDay", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)
	mMovie:__wf_atom_e57658c2("BottomLines", 11, v26)
	mMovie:OverrideMaterial("BottomLines", rightVisibleRangeMat)
	mMovie:__wf_atom_1ca72041("BottomLines", "RipplesColor", v31.red, v31.green, v31.blue, 0.4)
	mMovie:__wf_atom_e57658c2("SelectLabel", 44, v26)
	mMovie:__wf_atom_e57658c2("ClaimItemHighlight.StarburstOne", 11, v27)
	mMovie:__wf_atom_e57658c2("ClaimItemHighlight.StarburstTwo", 11, v28)
	mMovie:__wf_atom_e57658c2("ClaimItemHighlight.Sparkles", 11, v25)
	mMovie:SetCallbacks(
		"Milestone.MilestonePreview.Btn",
		"MilestonePreviewFocused",
		"MilestonePreviewUnfocused",
		"MilestonePreviewPressed",
		nil
	)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview", 12, 0)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.Icon", 11, module2.Ternary(v2.mIsMilestoneDay, v30, v26))
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.Backer", 11, v28)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 11, v26)
	v22 = mMovie:__wf_atom_5e6e15c8("Milestone.MilestonePreview", 0)
	mMovie:__wf_atom_2dedec1a("TransmissionFrame", 13, false)
	mMovie:OverrideMaterial("TransmissionFrame.ImageOuter.Image", _G.UIMaterial_SmoothEdgeNoDepthTest)
	mMovie:__wf_atom_e57658c2("Logo", 12, 0)
	mMovie:__wf_atom_e57658c2("Milestone", 12, 0)
	mMovie:__wf_atom_e57658c2("Claim", 12, 0)
	mMovie:__wf_atom_e57658c2("ClaimItemHighlight", 12, 0)
	mMovie:OverrideMaterial("ClaimItemHighlight", lightRaysMaterial)
	mMovie:__wf_atom_e57658c2("RandomReward", 12, 0)
	mMovie:__wf_atom_e57658c2("MilestoneGrid", 12, 0)
	mMovie:__wf_atom_2dedec1a("MilestoneGrid", 13, false)
	mMovie:__wf_atom_2dedec1a("RandomReward.Item", 67, false)
	mMovie:__wf_atom_e57658c2("PickDoor", 12, 0)
	mMovie:__wf_atom_2dedec1a("PickDoor", 67, false)
	__wf_atom_86cbd68d(mMovie, "ClaimItemHighlight.Sparkles.gotoAndStop", 1)
	local screenDimensions, v44 = module2.GetScreenDimensions(mMovie)
	local v45 = screenDimensions / 1.5625
	mMovie:__wf_atom_e57658c2("LeftFade", 15, v44)
	mMovie:__wf_atom_e57658c2("RightFade", 15, v44)
	mMovie:__wf_atom_e57658c2("LeftFade", 14, v45)
	mMovie:__wf_atom_e57658c2("RightFade", 14, v45)
	mMovie:__wf_atom_e57658c2("LeftFade", 12, 0)
	mMovie:__wf_atom_e57658c2("RightFade", 12, 0)
	mMovie:__wf_atom_0cf0fdbe(0)

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			if not module3.IsCampLevel(false) then
				if module3.IsCampLevel() then
					__wf_atom_c4f78a8f:Teleport(__wf_atom_c4f78a8f:GetPosition(), Rotation(0, 0, 0))
				else
					__wf_atom_c4f78a8f:Teleport(__wf_atom_c4f78a8f:GetPosition(), Rotation(180, 0, 0))
				end

				__wf_atom_c4f78a8f:__wf_atom_e06358f3(Symbol("InstantKneel"))
			end

			__wf_atom_c4f78a8f:__wf_atom_e424c72a(true)

			if not _T.gActiveCameraSpot then
				module3.SetLoginCameraSpot()
			end
		end

		if not module3.IsCampLevel(false) then
			_T.ShowBackground(0.25, { TrackAvatar = true, x = 0, y = 0 }, true)
		end
	end

	v9 = fn24("Claim.ClaimButton", "/Lotus/Language/Menu/Crafting_Claim", "Claim", "<MENU_SELECT>")
	v9:SetActive(false)
	v9:Redraw()
	v10 = fn24(
		"Claim.UseCouponBtn",
		"/Lotus/Language/Menu/DailyTributeClaimAndUseCoupon",
		"ClaimAndUseCoupon",
		"<MENU_GENERIC1>"
	)
	v10.mFitToText = true
	v10:SetActive(false)
	v10:SetVisible(false)
	v10:Redraw()
	fn26()
	fn25()
	fn12()
	fn13(true)
	local v46 = v20
	local v47 = v20
	local rootBasedPosition, v48 = module2.GetRootBasedPosition(mMovie, "Milestone.HoverArea")
	v46.X = rootBasedPosition
	v47.Y = v48
	v20.XW = v20.X + mMovie:__wf_atom_5e6e15c8("Milestone.HoverArea", 14)
	v20.YH = v20.Y + mMovie:__wf_atom_5e6e15c8("Milestone.HoverArea", 15)
	fn2()
	fn23()
	v43 = true
end

function Update()
	if not v43 then
		if _T.missionStatsPending or __wf_atom_8e4fda44:FindMovie(endOfMatchMovie) then
			return
		else
			fn27()
		end
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_084b3e93())

	if not __wf_atom_7e8ad928(v7) then
		v7:Update(__wf_atom_084b3e93())
	end

	if v15 ~= nil then
		module.Update(v15, __wf_atom_084b3e93())
	end

	if
		v3.IsLoading
		and not __wf_atom_7e8ad928(v3.Loader)
		and v3.Loader:__wf_atom_86399a47()
		and (not module3.InQuestCommitment(gameData) or _T.ActiveQuestLoaded)
	then
		v3.IsLoading = false
		_T.BlockTransmissionFadeOut = true
		fn20(Resource(v3.Res))
	end

	if flag3 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
		local v44 = v21
		v21 = v20.X <= __wf_atom_5e6e15c8
			and __wf_atom_5e6e15c8 <= v20.XW
			and v20.Y <= __wf_atom_5e6e15c8_2
			and __wf_atom_5e6e15c8_2 <= v20.YH

		if v44 ~= v21 and (not v18.Visible or v2.mIsMilestoneDay) then
			__wf_atom_ec43d06e(mMovie, "Milestone.MilestonePreview", 0, { 12 }, { module2.Ternary(v21, 100, 0) }, 0.15)
		end

		if v19.y ~= 0 and v18 and v18.Visible and not __wf_atom_7e8ad928(v18.mScrollBar) then
			v18.mScrollBar:ScrollBy(v19.y / 20)
		end
	end
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v8) then
		v8:Update(p, p2)
	end

	fn25()

	if not __wf_atom_7e8ad928(v6) then
		fn13(true)
	end

	local screenDimensions, v44 = module2.GetScreenDimensions(mMovie)
	local v45 = screenDimensions / 1.5625
	mMovie:__wf_atom_e57658c2("LeftFade", 15, v44)
	mMovie:__wf_atom_e57658c2("RightFade", 15, v44)
	mMovie:__wf_atom_e57658c2("LeftFade", 14, v45)
	mMovie:__wf_atom_e57658c2("RightFade", 14, v45)
	local v46 = v20
	local v47 = v20
	local rootBasedPosition, v48 = module2.GetRootBasedPosition(mMovie, "Milestone.HoverArea")
	v46.X = rootBasedPosition
	v47.Y = v48
	v20.XW = v20.X + mMovie:__wf_atom_5e6e15c8("Milestone.HoverArea", 14)
	v20.YH = v20.Y + mMovie:__wf_atom_5e6e15c8("Milestone.HoverArea", 15)
end

function MilestoneItemPressed(p)
	if flag or v18 == nil then
		return
	end

	v18:SelectElementById((tonumber(p)))
end

function MilestoneItemFocused(p)
	if v18 == nil then
		return
	end

	v17 = module2.PlaySound(lockBoxHoverSound)
	v18:FocusElementById((tonumber(p)))
end

function MilestoneItemUnfocused(p)
	if v18 == nil then
		return
	end

	if not __wf_atom_7e8ad928(v17) then
		v17:Stop(false)
	end

	v18:UnfocusElementById((tonumber(p)))
end

function MilestonePreviewFocused()
	module2.PlaySound(_G.UISound_Focus)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.Icon", 11, v25)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 11, v25)
end

function MilestonePreviewUnfocused()
	if v18.Visible then
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.Icon", 11, v30)
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 11, v30)
	else
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.Icon", 11, v26)
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 11, v26)
	end
end

local function fn28(p)
	v6.mDayOffset = __wf_atom_104bfe98(v6.StartDay - targetDay, v6.TargetDay - targetDay, p)
	fn13(true)
	mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview", 0, v23)

	if v23 == v22 then
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 12, 100)
	else
		mMovie:__wf_atom_e57658c2("Milestone.MilestonePreview.ForwardArrow", 12, 0)
	end

	mMovie:__wf_atom_50d60589("Header.CurrentDay", 36, module2.Round(targetDay + v6.mDayOffset))
end

local function fn29()
	if milestone ~= v11.MILESTONE and not __wf_atom_7e8ad928(v18) then
		local v44 = nil
		local v45 = false

		if milestone == v11.RANDOM then
			v45 = not __wf_atom_7e8ad928(mReward) and mReward.mRewardType == 6
			v44 = "RandomReward"
		elseif milestone == v11.PICK_A_DOOR then
			v44 = "PickDoor"
		end

		if v18.Visible then
			v18.Visible = false
			v6.TargetDay = targetDay
			v6.StartDay = targetDay + v6.mDayOffset
			mMovie:__wf_atom_7d7314f1("Header.Title.text", "/Lotus/Language/Menu/DailyTributeTitle", false)
			__wf_atom_ec43d06e(mMovie, "Milestone.Arrows", 2, { fn28 }, { 1 }, 0.5, 0, function()
				__wf_atom_ec43d06e(mMovie, "MilestoneGrid", 0, { 12 }, { 0 }, 0.1, 0, function()
					mMovie:__wf_atom_2dedec1a("MilestoneGrid", 13, false)
					mMovie:__wf_atom_2dedec1a(v44, 13, true)

					if v45 then
						fn7()
					end

					__wf_atom_ec43d06e(mMovie, "BottomLines", 2, { 12 }, { module2.Ternary(v36, 50, 0) }, 0.1)
					__wf_atom_ec43d06e(mMovie, v44, 2, { 12 }, { 100 }, 0.1)

					if v39 ~= nil then
						mMovie:__wf_atom_7d7314f1("SelectLabel.text", v39)
					end

					__wf_atom_ec43d06e(mMovie, "SelectLabel", 2, { 12 }, { module2.Ternary(v39 ~= nil, 100, 0) }, 0.1)
				end)
			end)
		else
			v18.Visible = true
			v6.TargetDay = targetDay2
			v6.StartDay = targetDay + v6.mDayOffset
			__wf_atom_ec43d06e(mMovie, "Milestone.Arrows", 2, { fn28 }, { 1 }, 0.5, 0, function()
				mMovie:__wf_atom_7d7314f1(
					"Header.Title.text",
					"/Lotus/Language/Menu/DailyTributeMilestonePreview",
					false
				)
				mMovie:__wf_atom_7d7314f1("SelectLabel.text", "/Lotus/Language/Menu/DailyTributePreviewRewards")

				if v45 then
					fn8()
				end

				__wf_atom_ec43d06e(mMovie, v44, 2, { 12 }, { 0 }, 0.1, 0, function()
					mMovie:__wf_atom_2dedec1a(v44, 13, false)
					mMovie:__wf_atom_2dedec1a("MilestoneGrid", 13, true)
					__wf_atom_ec43d06e(mMovie, "BottomLines", 2, { 12 }, { module2.Ternary(v37, 50, 0) }, 0.1)
					__wf_atom_ec43d06e(mMovie, "MilestoneGrid", 0, { 12 }, { 100 }, 0.1)
				end)
				__wf_atom_ec43d06e(mMovie, "SelectLabel", 2, { 12 }, { 100 }, 0.1)
			end)
		end
	end
end

function MilestonePreviewPressed()
	fn29()
end

function RandomRewardItemFocused(p)
	if v24 and p ~= nil and v40[p] ~= nil then
		_T.InfoPopup_Data = v40[p]
	end

	fn5(p .. ".Item", true)
end

function RandomRewardItemUnfocused(p)
	_T.InfoPopup_Data = nil
	local v44 = p .. ".Item"
	fn5(v44, v41 == v44)
end

function OnTransmissionDone()
	_T.TransmissionOverrideSubtitles = nil
end

function onKeyUp_MENU_SELECT()
	if
		not flag
		and v9 ~= nil
		and v9:IsActive()
		and (__wf_atom_7e8ad928(v9.mOnPressedCallback) or v9:mOnPressedCallback(true) ~= false)
	then
		v9:Pressed(true)
	end
end

function onKeyUp_MENU_GENERIC1()
	if
		v10 ~= nil
		and v10:IsActive()
		and (__wf_atom_7e8ad928(v10.mOnPressedCallback) or v10:mOnPressedCallback(true) ~= false)
	then
		v10:Pressed(true)
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if v18 and v18.Visible and not __wf_atom_7e8ad928(v18.mScrollBar) then
		v18.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyUp_HIDE_PAUSE_MENU()
	return true
end

function onKeyDown_MENU_RIGHT_X(_, p)
	v19.x = -tonumber(p)
end

function onKeyUp_MENU_RIGHT_X(_, p)
	v19.x = -tonumber(p)
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	v19.y = -tonumber(p)
end

function onKeyUp_MENU_RIGHT_Y(_, p)
	v19.y = -tonumber(p)
end

function onKeyUp_MENU_CANCEL()
	if not flag and not __wf_atom_7e8ad928(v18) and v18.Visible then
		fn29()
	end
end

function SupportsThemes()
	return true
end