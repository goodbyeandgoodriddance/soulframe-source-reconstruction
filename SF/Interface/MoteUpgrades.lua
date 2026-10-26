local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.StoreItemUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("SF.Interface.Libs.StatsUtil")
local module6 = require("Lotus.Interface.UIStyleUtilities")
local module7 = require("SF.Interface.Libs.MoteUtil")
require("Lotus.Scripts.Libs.AbilitiesLib")
local v = nil
local asyncLoader = module4.CreateAsyncLoader()
local v2 = nil
local v3 = nil
local flag = false
local flag2 = false
local inventory = nil
local v4 = nil
local v5 = {}
local v6 = false
local v7 = nil
local v8 = nil
local v9 = nil
local arsenalAvatar = nil
local v10 = nil
local v11 = nil
local v12 = nil
local flag3 = false
local flag4 = false
local v13 = nil
local v14 = 1
local v15 = 0
local v16 = { 2, 1 / 12, 1 / 12 }
local v17 = false
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
local flag5 = nil
local v29 = nil
local mFusionPoints = 0
local v30 = nil
local v31 = nil
local v32 = { 1100, 700, 1100 }
local v33 = { 1200, 700, 1200 }
local v34 = { 1200, 780, 1200 }
local v35 = { [1] = "Attack", [2] = "Defense", [3] = "Tactic", [8] = "Mote" }
local v36 = { [3] = "Large", [2] = "Medium", [1] = "Small" }
local v37 = { [9] = 1, [11] = 3, [10] = 2 }
local v38 = {}
local v39 = {}
local v40 = { DESCRIPTION = 1, STATS = 2 }
local description = v40.DESCRIPTION
local v41 = false
local v42 = 0
local mMultiSelect = false
local flag6 = false
local total = 0
local v44 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v45 = nil
local v46 = nil
local v47 = {}
local fn

local function fn2(p)
	return not __wf_atom_7e8ad928(p) and p.mPolarity == 8
end

local function fn3(p)
	for _, v48 in pairs(v3) do
		if v48.mId == p then
			return v48
		end
	end

	return nil
end

local function fn4()
	if not __wf_atom_7e8ad928(v8) then
		return (fn3(v8))
	end

	for _, v49 in ipairs(v3) do
		if v49.mPolarity == 8 then
			return v49
		end
	end

	return nil
end

local function fn5(p)
	if __wf_atom_7e8ad928(v2) then
		return
	end

	local v48 = p or v5
	local __wf_atom_6ec6b781 = v2:__wf_atom_6ec6b781()
	local __wf_atom_a1e82f2d = v2:__wf_atom_a1e82f2d()

	for _, v49 in ipairs(v48) do
		if __wf_atom_7e8ad928(v49.mInstance) then
			continue
		end

		local __wf_atom_74981ccd = v49.mInstance:__wf_atom_74981ccd()
		local __wf_atom_02e75252 = v49.mInstance:__wf_atom_02e75252()

		if #__wf_atom_74981ccd > 0 then
			table.move(__wf_atom_74981ccd, 1, #__wf_atom_74981ccd, #__wf_atom_6ec6b781 + 1, __wf_atom_6ec6b781)
		end

		if #__wf_atom_02e75252 > 0 then
			table.move(__wf_atom_02e75252, 1, #__wf_atom_02e75252, #__wf_atom_a1e82f2d + 1, __wf_atom_a1e82f2d)
		end

		if #__wf_atom_74981ccd < #__wf_atom_02e75252 then
			local v50 = table.create(#__wf_atom_02e75252 - #__wf_atom_74981ccd, 0)
			table.move(v50, 1, #v50, #__wf_atom_6ec6b781 + 1, __wf_atom_6ec6b781)
		elseif #__wf_atom_74981ccd > #__wf_atom_02e75252 then
			local v50 = table.create(#__wf_atom_74981ccd - #__wf_atom_02e75252, 0)
			table.move(v50, 1, #v50, #__wf_atom_a1e82f2d + 1, __wf_atom_a1e82f2d)
		end
	end

	return __wf_atom_6ec6b781, __wf_atom_a1e82f2d
end

local function fn6(p, p2, p3)
	local v48 = 1
	asyncLoader:AbortLoad("LayeredIconFrame")

	if __wf_atom_7e8ad928(p2) or not p2.OwnsItem or __wf_atom_7e8ad928(p2.StoreItemInfo) then
		while mMovie:__wf_atom_253d7085(p .. v48) do
			mMovie:__wf_atom_290807ee(p .. v48)
			mMovie:__wf_atom_e57658c2(p .. v48, 12, 0)
			v48 += 1
		end
	else
		local storeItemInfo = p2.StoreItemInfo

		if __wf_atom_7e8ad928(storeItemInfo) then
			return
		end

		local v49

		if __wf_atom_7e8ad928(storeItemInfo.RawItem.mItemType) then
			v49 = Resource(storeItemInfo.RawItem)
		else
			v49 = Resource(storeItemInfo.RawItem.mItemType)
		end

		local __wf_atom_0f53c1b9 = v49:__wf_atom_0f53c1b9()
		local __wf_atom_919e7078 = v49:__wf_atom_919e7078()
		local v50 = v49:__wf_atom_1c14f269() == 3

		if __wf_atom_7e8ad928(__wf_atom_0f53c1b9) or not p2.OwnsItem then
			mMovie:__wf_atom_c90af43a(p, storeItemInfo.Icon)
			mMovie:__wf_atom_e57658c2(p, 12, 100)
		else
			mMovie:__wf_atom_e57658c2(p, 12, 0)

			for i = 1, math.min(3, #__wf_atom_0f53c1b9) do
				if not mMovie:__wf_atom_253d7085(p .. i) then
					__wf_atom_86cbd68d(mMovie, p .. ".duplicateMovieClip", "Icon" .. i, i + 1)
				end

				local v51 = p3 or module.Ternary(v50, v32, v33)

				if v51[i] ~= nil then
					mMovie:__wf_atom_e57658c2(p .. i, 5, v51[i])
					mMovie:__wf_atom_e57658c2(p .. i, 6, v51[i])
				end

				local ternary = module.Ternary(v50, _G.UIMaterial_RuneMaterial, _G.UIMaterial_AnimalMoteMaterial)

				if i == 2 then
					mMovie:__wf_atom_c90af43a(p .. 2, __wf_atom_0f53c1b9[2])
					mMovie:OverrideMaterial(p .. 2, ternary)
					mMovie:__wf_atom_e57658c2(p .. 2, 12, 100)
					__wf_atom_ec43d06e(mMovie, p .. 2, 8, { 12 }, { 100 }, 0.5)
				elseif i == 3 then
					local mUpgradeFingerprint = storeItemInfo.RawItem.mUpgradeFingerprint
					local v52 = __wf_atom_7e8ad928(mUpgradeFingerprint) and "" or mUpgradeFingerprint
					local __wf_atom_a8dac107 = v49:__wf_atom_a8dac107(v52)
					local __wf_atom_c6a5f697 = v49:__wf_atom_c6a5f697(v52)
					local v53 = 1 + __wf_atom_a8dac107 * 4 + __wf_atom_c6a5f697
					mMovie:__wf_atom_e57658c2(p .. 1, 12, 0)
					local ternary2 = module.Ternary(
						v50,
						_G.UITexture_MoteFrameTexturesActive,
						_G.UITexture_MoteFrameTexturesPassive
					)
					mMovie:__wf_atom_c90af43a(p .. 3, ternary2[v53])
					mMovie:__wf_atom_e57658c2(p .. 3, 12, 100)
					__wf_atom_ec43d06e(mMovie, p .. 3, 8, { 12 }, { 100 }, 0.5)
				else
					mMovie:__wf_atom_e57658c2(p .. i, 12, 0)
					mMovie:__wf_atom_c90af43a(p .. i, __wf_atom_0f53c1b9[i])

					if __wf_atom_7e8ad928(__wf_atom_919e7078) or #__wf_atom_919e7078 < i then
						mMovie:OverrideMaterial(p .. i, nil)
					else
						mMovie:OverrideMaterial(p .. i, __wf_atom_919e7078[i])
					end
				end
			end

			v48 = #__wf_atom_0f53c1b9 + 1
		end

		while mMovie:__wf_atom_253d7085(p .. v48) do
			mMovie:__wf_atom_290807ee(p .. v48)
			mMovie:__wf_atom_e57658c2(p .. v48, 12, 0)
			v48 += 1
		end
	end
end

local function fn7(p)
	if p == 9 then
		return 12081779
	elseif p == 10 then
		return 7314022
	elseif p == 11 then
		return 5932728
	end

	return 16777215
end

local function fn8(p)
	if __wf_atom_7e8ad928(v22) then
		return
	end

	if __wf_atom_7e8ad928(p) then
		v22:SetVisible(false)
		return
	end

	if __wf_atom_7e8ad928(p.mItemType) then
		v22:SetVisible(false)
		return
	end

	local v48 = Resource(p.mItemType)
	local __wf_atom_5d16ab7c = v48:__wf_atom_5d16ab7c(p.mUpgradeFingerprint)
	mMovie:__wf_atom_50d60589("Details.UpgradeCost.Amount", 36, (tostring(__wf_atom_5d16ab7c)))

	if v48:__wf_atom_c6a5f697(p.mUpgradeFingerprint) < v48:__wf_atom_49f7d220(p.mUpgradeFingerprint) then
		mMovie:__wf_atom_2dedec1a("Details.UpgradeCost", 13, false)
		v22:SetVisible(true)
	else
		mMovie:__wf_atom_2dedec1a("Details.UpgradeCost", 13, false)
		v22:SetVisible(false)
	end

	if not __wf_atom_7e8ad928(v22) then
		local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)

		if __wf_atom_5d16ab7c <= mFusionPoints then
			v22:SetActive(true)
		else
			convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_BrightOrange)
			v22:SetActive(false)
		end

		local cost = "<font color=\"" .. convertColorNumberToHex .. "\">" .. __wf_atom_5d16ab7c .. "</font>"
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
			true
		)
		v22:SetText("<p><font >" .. __wf_atom_8e9ac384 .. mMovie:__wf_atom_8e9ac384(
			"/SF/Language/Motes/MotesScreen_MoteUpgradeButton",
			true,
			{ COST = cost }
		) .. "</font></p>")
	end
end

local function fn9(p)
	if __wf_atom_7e8ad928(v5) then
		return true
	end

	return v5[p] == nil or v5[p].mItemType == nil
end

local function fn10()
	if __wf_atom_7e8ad928(v5) or v5 == {} then
		return true
	end

	for _, v48 in v5 do
		if v48.mItemType ~= nil then
			return false
		end
	end

	return true
end

local function fn11(polarity, p, instance, mUpgradeFingerprint, upgrade)
	if flag5 then
		return
	end

	v29 = {
		Type = p,
		Instance = instance,
		Upgrade = upgrade,
		Polarity = polarity,
		Weapon = v2
	}
	local moteDescription = module7.GetMoteDescription(v29, nil, nil, v28 ~= nil)
	local uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[4]
	local polarityMatch

	if polarity == 8 then
		polarityMatch = false
	else
		local __wf_atom_c05c3cf5 = instance:__wf_atom_c05c3cf5(mUpgradeFingerprint)
		polarityMatch = module7.IsMatchingPolarity(__wf_atom_c05c3cf5, polarity)
		uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[1]

		if __wf_atom_c05c3cf5 == 10 then
			uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[2]
		elseif __wf_atom_c05c3cf5 == 11 then
			uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[3]
		end
	end

	local text

	if v28 then
		text = v28
	else
		text = moteDescription
	end

	v12:RemoveElements(true, true)
	v12:AddElement(
		{
			Text = text,
			Icon = uiTexture_MoteStatsIcon,
			IsHighlighted = true,
			PolarityMatch = polarityMatch
		},
		true
	)

	if v28 then
		flag5 = true
		v12.AnimateTextChange(v12:GetElementInIndex(1), moteDescription)
	end
end

local function fn12(p)
	local v48 = fn4()
	local v49, mPolarity

	if not __wf_atom_7e8ad928(v48) then
		v49 = v5[v48.mIndex]
		mPolarity = v48.mPolarity
	end

	__wf_atom_ec43d06e(mMovie, "Details.MoteName", 8, { 12 }, { 100 }, 0.2)
	local v50 = nil
	local mUpgradeFingerprint = nil

	if flag3 and not __wf_atom_7e8ad928(v20) then
		__wf_atom_ec43d06e(mMovie, "EmptyState", 8, { 12 }, { 0 }, 0.2)

		if __wf_atom_7e8ad928(v20.StoreItemInfo) or not v20.OwnsItem then
			__wf_atom_ec43d06e(mMovie, "Details.MoteName", 8, { 12 }, { 0 }, 0.2)
			mMovie:__wf_atom_2dedec1a("Details.Icon1", 13, false)
			mMovie:__wf_atom_2dedec1a("Details.Icon2", 13, false)
			mMovie:__wf_atom_2dedec1a("Details.Icon3", 13, false)
			__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 0 }, 0.2)

			if fn10() then
				__wf_atom_ec43d06e(mMovie, "EmptyState", 8, { 12 }, { 100 }, 0.2)
			end
		else
			v50 = Resource(v20.StoreItemInfo.Type)
			v50:__wf_atom_c6a5f697(v20.StoreItemInfo.RawItem.mUpgradeFingerprint)
			mUpgradeFingerprint = v20.StoreItemInfo.RawItem.mUpgradeFingerprint
			local upgradeInfo = SF.UpgradeInfo()
			upgradeInfo.mItemId = v20.StoreItemInfo.RawItem.mItemId
			upgradeInfo.mUpgradeFingerprint = v20.StoreItemInfo.RawItem.mUpgradeFingerprint
			upgradeInfo.mItemType = v20.StoreItemInfo.RawItem.mItemType
			fn11(mPolarity, v20.StoreItemInfo.Type, v50, mUpgradeFingerprint, upgradeInfo)
			mMovie:__wf_atom_2dedec1a("Details.MoteName", 13, true)
			mMovie:__wf_atom_50d60589(
				"Details.MoteName",
				36,
				mMovie:__wf_atom_8e9ac384(v50:__wf_atom_014a76a2():c_str(), false)
			)
			__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 90 }, 0.2)
			local _ = {
				OwnsItem = true,
				StoreItemInfo = { RawItem = v20.StoreItemInfo.Type }
			}
			fn6("Details.Icon", v20, v34)
			mMovie:__wf_atom_2dedec1a("Details.Icon1", 13, true)
			mMovie:__wf_atom_2dedec1a("Details.Icon2", 13, true)
			mMovie:__wf_atom_2dedec1a("Details.Icon3", 13, true)
		end
	elseif __wf_atom_7e8ad928(v49) or __wf_atom_7e8ad928(v49.mItemType) then
		if fn9(v48) then
			__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 0 }, 0.2)
			__wf_atom_ec43d06e(mMovie, "EmptyState", 8, { 12 }, { 100 }, 0.2)

			if mPolarity == 8 then
				mMovie:__wf_atom_50d60589(
					"EmptyState.Title",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_RuneNamePlaceholder", false)
				)
				mMovie:__wf_atom_50d60589(
					"EmptyState.Subtitle",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_RuneDescriptionPlaceholder", false)
				)
			else
				mMovie:__wf_atom_50d60589(
					"EmptyState.Title",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteNamePlaceholder", false)
				)
				mMovie:__wf_atom_50d60589(
					"EmptyState.Subtitle",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteDescriptionPlaceholder", false)
				)
			end

			mMovie:__wf_atom_2dedec1a("Details.UpgradeCost", 13, false)
			v22:SetVisible(false)
		else
			__wf_atom_ec43d06e(mMovie, "EmptyState", 8, { 12 }, { 0 }, 0.2)
		end
	else
		__wf_atom_ec43d06e(mMovie, "EmptyState", 8, { 12 }, { 0 }, 0.2)
		v50 = Resource(v49.mItemType)
		v50:__wf_atom_c6a5f697(v49.mUpgradeFingerprint)
		mUpgradeFingerprint = v49.mUpgradeFingerprint
		fn8(v49)
		fn11(mPolarity, v49.mItemType, v50, mUpgradeFingerprint, v49)
		mMovie:__wf_atom_2dedec1a("Details.MoteName", 13, true)
		mMovie:__wf_atom_50d60589(
			"Details.MoteName",
			36,
			mMovie:__wf_atom_8e9ac384(v50:__wf_atom_014a76a2():c_str(), false)
		)
		__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 90 }, 0.2)
		fn6("Details.Icon", {
			OwnsItem = true,
			StoreItemInfo = { RawItem = v49.mItemType }
		}, v34)
		mMovie:__wf_atom_2dedec1a("Details.Icon1", 13, true)
		mMovie:__wf_atom_2dedec1a("Details.Icon2", 13, true)
		mMovie:__wf_atom_2dedec1a("Details.Icon3", 13, true)
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Details.MoteName", 40)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Details.MoteName", 41)
	mMovie:__wf_atom_e57658c2("Details.NameBacker", 14, __wf_atom_5e6e15c8 + 64)
	mMovie:__wf_atom_e57658c2("Details.NameBacker", 15, __wf_atom_5e6e15c8_2 + 16)

	if not __wf_atom_7e8ad928(v50) then
		local __wf_atom_1c14f269 = v50:__wf_atom_1c14f269()
		local v51 = mUpgradeFingerprint or v49.mUpgradeFingerprint
		local v52 = Resource(v50:__wf_atom_7ec2d06a(v51 or ""))

		if not v52:IsA(__wf_atom_cdd2dd31) then
			print("Wrong item compatibility set on " .. v50:__wf_atom_5b41f63b())
			return
		end

		local __wf_atom_ab9ebfce = v52:__wf_atom_ab9ebfce()
		local ternary = module.Ternary(
			__wf_atom_ab9ebfce ~= EMPTY_SYMBOL,
			__wf_atom_ab9ebfce:c_str(),
			"<WEAPON_CATEGORY_ICON_UNIVERSAL>"
		)
		mMovie:__wf_atom_50d60589("Details.GripIcon", 36, mMovie:__wf_atom_8e9ac384(ternary, true))
		local v53 = Localize(v50:__wf_atom_3a3d2e39():c_str(), false)
		mMovie:__wf_atom_50d60589("Details.MoteFlavour", 36, v53)
		local __wf_atom_c05c3cf5 = v50:__wf_atom_c05c3cf5(v51)
		module7.UpdateMoteInstructions(
			mMovie,
			"Details.MoteInstructions",
			__wf_atom_1c14f269,
			__wf_atom_c05c3cf5,
			mPolarity,
			not (__wf_atom_7e8ad928(v20) or p)
		)
		local __wf_atom_a8dac107 = v50:__wf_atom_a8dac107(v51 or "")
		local __wf_atom_c6a5f697 = v50:__wf_atom_c6a5f697(v51 or "")
		local v54 = 1 + __wf_atom_a8dac107 * 4 + __wf_atom_c6a5f697
		local ternary2 = module.Ternary(
			__wf_atom_1c14f269 == 3,
			_G.UITexture_MoteFrameTexturesActive,
			_G.UITexture_MoteFrameTexturesPassive
		)
		mMovie:__wf_atom_e57658c2("Details.Icon1", 12, 0)
		mMovie:__wf_atom_c90af43a("Details.Icon3", ternary2[v54])
		mMovie:__wf_atom_e57658c2("Details.Icon3", 12, 100)
		__wf_atom_ec43d06e(mMovie, "Details.Icon3", 8, { 12 }, { 100 }, 0.5)

		if __wf_atom_1c14f269 == 3 then
			mMovie:__wf_atom_e57658c2("Details.Icon2", 11, 16777215)
			mMovie:__wf_atom_c90af43a("Details.Card", _G.UITexture_MoteCardBgTextures[1])
		else
			mMovie:__wf_atom_c90af43a("Details.Card", module7.GetTotemBg(__wf_atom_c05c3cf5))
			mMovie:__wf_atom_e57658c2("Details.Icon2", 11, module7.CalcTotemColor(__wf_atom_c05c3cf5))
		end

		v12.mInitialY = 16
	end

	mMovie:__wf_atom_e57658c2(
		"Details.UpgradeCost.Backer",
		14,
		80 + mMovie:__wf_atom_5e6e15c8("Details.UpgradeCost.Amount", 40)
	)
	__wf_atom_ec43d06e(mMovie, "Details.StatsContainer", 8, { 12 }, { 0 }, 0.2)
	v30:FocusElement(description)
	v30:SelectCurrentElement()
	v30:Redraw(nil, true, true)
	v12:Redraw(nil, true, true)
end

function AdvanceAndShutdown()
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(arsenalAvatar) then
		arsenalAvatar:__wf_atom_e424c72a(true)
	end

	if not __wf_atom_7e8ad928(v46) then
		v46:__wf_atom_7e990320(2)
		v46:__wf_atom_8c3d9704(2)
	end

	for i = 1, #v47 do
		v47[i]:TurnOn()
	end

	flag = true
	flag2 = true
	_T.InfoPopup_Data = nil

	for _, v48 in v3 do
		local v49 = v5[v48.mIndex]

		if __wf_atom_7e8ad928(v49) or __wf_atom_7e8ad928(v49.mItemType) then
			mMovie:__wf_atom_e57658c2(v48.mClip, 12, 0)
		end
	end

	module2.DissolveOutAndClose(mMovie)

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	if not __wf_atom_7e8ad928(_T.OnReturnToArsenal) then
		_T.OnReturnToArsenal(v6)
	end
end

local function fn13(p)
	if not (flag3 and v27 == nil) then
		return
	end

	mMovie:__wf_atom_2dedec1a("MultiSelectContainer", 13, false)
	v23:MultiSellClear()
	mMultiSelect = false
	mMovie:__wf_atom_2dedec1a("Details", 13, true)
	v11.mMultiSelect = false
	_T.InfoPopup_Data = nil
	_T.gToolTip = nil
	__wf_atom_ec43d06e(mMovie, "Container.InventoryGrid", 8, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:__wf_atom_2dedec1a("Container.InventoryGrid", 13, false)
	end)
	flag4 = true
	__wf_atom_ec43d06e(mMovie, "Container.MotePreview", 8, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:__wf_atom_2dedec1a("Container.MotePreview", 13, false)
		flag3 = false
		_T.MoteSelectOpen = false
		flag4 = false
		flag = false
		v19 = nil

		if v20 == nil or not p then
			fn12()
		end

		v20 = nil
	end)
	__wf_atom_ec43d06e(mMovie, "Container.SoftShadowInventory", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Container.Blurer", 8, { 12 }, { 0 }, 0.25)
end

local function fn14(_, _)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v48 = mMovie:__wf_atom_d5a50cb5() / mMovie:__wf_atom_c4f6543f()
	local v49 = mMovie:__wf_atom_97cd8326() / mMovie:__wf_atom_54eeda24()
	local v50 = mMovie:__wf_atom_5e6e15c8("Backer", 14) / (mMovie:__wf_atom_5e6e15c8("Backer", 5) / 100)
	local v51 = mMovie:__wf_atom_5e6e15c8("Backer", 15) / (mMovie:__wf_atom_5e6e15c8("Backer", 6) / 100)
	local v52 = v50 / v51
	local v53, v54

	if v49 < v48 then
		v53 = v51 * v48 * v52 / v49
		v54 = v53 / v52
	else
		v54 = v50 * (v49 / v52) / v48
		v53 = v54 * v52
	end

	mMovie:__wf_atom_e57658c2("Backer", 14, v53)
	mMovie:__wf_atom_e57658c2("Backer", 15, v54)
end

function onViewportSizeChanged(p, p2)
	fn14(p, p2)
end

local function fn15(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(storeManifest) then
		return nil
	end

	return storeManifest:__wf_atom_232fd31d(p)
end

local v48 = 0
local v49 = 0.5
local v50 = 0

local function fn16(p, p2)
	if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5[1]) or __wf_atom_7e8ad928(v5[1].mItemType) then
		return
	end

	if v13 and #v13 then
		v15 += p2

		if v15 >= v16[v14] then
			v15 -= v16[v14]
			v14 += 1

			if v14 > #v13 then
				v14 = 1
				v16[1] = __wf_atom_104bfe98(1, 4, math.random())
			end

			mMovie:__wf_atom_c90af43a(p .. ".Icon2", v13[v14])
		end
	end

	v50 -= p2

	if v50 > 0 then
		return
	end

	v50 = 1 / 24
	v48 -= 1 / 24

	if v48 <= 0 then
		v48 = __wf_atom_104bfe98(3, 9, math.random())
		v49 = __wf_atom_104bfe98(0.3, 0.7, math.random())
		v17 = false
	end

	local v51 = 0
	local v52 = Noise(Time()) * v51 * 25
	local v53 = Noise(3.333 + Time()) * v51 * 25
	mMovie:__wf_atom_e57658c2(p .. ".Icon2", 0, v52)
	mMovie:__wf_atom_e57658c2(p .. ".Icon2", 1, v53)
	mMovie:__wf_atom_e57658c2(p, 0, v52 * 0.25)
	mMovie:__wf_atom_e57658c2(p, 1, v53 * 0.25)
end

local function fn17(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2)
	return {
		r = math.sqrt(__wf_atom_5e6e15c8 * __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 * __wf_atom_5e6e15c8_2),
		phi = math.atan2(__wf_atom_5e6e15c8_2, __wf_atom_5e6e15c8)
	}
end

local function fn18(r, phi, list)
	local v51 = r * math.cos(phi)
	local v52 = r * math.sin(phi)

	if list then
		v51 += list[1]
		v52 += list[2]
	end

	return { x = v51, y = v52 }
end

local v51 = {}
local v52 = {
	{ 0 },
	{ 25, -15 },
	{ 0, -30, 30 }
}
local v53 = { [3] = -15, [1] = -15, [2] = -30 }
local v54 = {
	[3] = { 20, 35 },
	[1] = { 20, -4 },
	[2] = { -2, 4 }
}

local function fn19()
	local v55, v56 = fn5()
	local v57 = {}

	local function fn20(p, p2)
		local v58 = v35[p] .. v36[p2]

		if v57[v58] == nil then
			v57[v58] = 0
		end

		v57[v58] += 1
		return v58 .. v57[v58]
	end

	local v58 = {}
	local v59 = {}

	for _, v60 in ipairs(v3) do
		local mPolarity = v60.mPolarity

		if v58[mPolarity] == nil then
			v58[mPolarity] = 0
		end

		v58[mPolarity] += 1
	end

	local v60 = {}

	for i, mPolarity in ipairs(v55) do
		local mSize = v56[i]
		local mId = 100 + i
		local v64 = "Slot" .. fn20(mPolarity, mSize)
		local mRootClip = "Container.Center" .. "." .. v64

		if v60[mPolarity] == nil then
			v60[mPolarity] = 0
		end

		v60[mPolarity] += 1
		local v66 = false

		for _, v68 in ipairs(v3) do
			if v68.mRootClip ~= mRootClip then
				continue
			end

			v66 = true
			break
		end

		if v66 then
			continue
		end

		local v68 = "Container.Center" .. ".Slot" .. (v35[mPolarity] .. v36[mSize]) .. "1"
		__wf_atom_86cbd68d(mMovie, v68 .. ".duplicateMovieClip", v64, mId + 1)
		mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Backer", 12, 0)
		mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.Icon", 12, 0)
		mMovie:__wf_atom_e57658c2(mRootClip, 12, 0)
		mMovie:__wf_atom_4c1c1986(mRootClip, "Rune.Icon", 12, 0)
		mMovie:__wf_atom_7f57ab2f(mRootClip, "Rune.Icon", 13, false)
		mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.Glow", 12, 0)
		mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.EquippedGlow", 12, 0)
		mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.Btn", 12, 0)
		mMovie:__wf_atom_933bbce0(mRootClip .. ".SmallSlot.Rune.Glow", hoverGlowTexture, raysMaterial)
		mMovie:__wf_atom_933bbce0(
			mRootClip .. ".SmallSlot.Rune.EquippedGlow",
			equippedGlowTexture,
			equippedGlowMaterial
		)
		local mClip = mRootClip .. ".Rune"
		mMovie:SetCallbacks(mClip .. ".Btn", "OnSlotFocus", "OnSlotUnfocus", "OnSlotReleased", "OnSlotPressed")
		mMovie:__wf_atom_e57658c2(mClip .. ".Btn", 100, mId)
		mMovie:__wf_atom_4c1c1986(mClip, "Glow", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClip, "EquippedGlow", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClip, "Btn", 12, 0)
		mMovie:__wf_atom_933bbce0(mClip .. ".Glow", hoverGlowTexture, raysMaterial)
		mMovie:__wf_atom_933bbce0(mClip .. ".EquippedGlow", equippedGlowTexture, equippedGlowMaterial)
		local v70 = {
			mClip = mClip,
			mRootClip = mRootClip,
			mId = mId,
			mIndex = i,
			mPolarity = mPolarity,
			mSize = mSize
		}
		table.insert(v3, v70)
		table.insert(v59, v70)
	end

	local v61 = {}
	local v62 = {}

	for i, v63 in ipairs(v3) do
		local mPolarity = v63.mPolarity

		if v61[mPolarity] == nil then
			v61[mPolarity] = 0
		end

		v61[mPolarity] += 1
		local v64 = { r = v51[mPolarity].r, phi = v51[mPolarity].phi }
		local v65 = v52[v60[mPolarity]][v61[mPolarity]]

		if v60[mPolarity] == 2 and v61[mPolarity] == 2 then
			v65 = v53[mPolarity]
		end

		local v66 = nil

		if v65 ~= nil then
			local rad = module.ToRad(v65)
			v64.phi += rad

			if v65 ~= 0 then
				v66 = v54[mPolarity]
			end
		end

		local v67 = fn18(v64.r, v64.phi, v66)

		if v61[mPolarity] > v60[mPolarity] then
			mMovie:__wf_atom_2dedec1a(v63.mRootClip, 67, false)
			local v68 = v63
			__wf_atom_ec43d06e(mMovie, v63.mRootClip, 7, { 0, 1, 12 }, { v67.x, v67.y, 0 }, 0.75, 0, function()
				__wf_atom_86cbd68d(mMovie, v68.mRootClip .. ".removeMovieClip")
			end)
			table.insert(v62, i)
		elseif flag6 then
			__wf_atom_ec43d06e(mMovie, v63.mRootClip, 7, { 0, 1, 12 }, { v67.x, v67.y, 100 }, 0.75)
		else
			mMovie:__wf_atom_e57658c2(v63.mRootClip, 0, v67.x)
			mMovie:__wf_atom_e57658c2(v63.mRootClip, 1, v67.y)
			mMovie:__wf_atom_e57658c2(v63.mRootClip, 12, 100)
		end
	end

	if #v62 > 0 then
		for i = #v62, 1, -1 do
			table.remove(v3, v62[i])
		end
	end
end

local function fn20(p)
	if __wf_atom_7e8ad928(_T.WeaponToUpgrade) then
		return
	end

	local rawItem = _T.WeaponToUpgrade.RawItem
	v5 = inventory:__wf_atom_43563387(rawItem.mItemId.mId, 0, false) or {}

	if __wf_atom_7e8ad928(v5) then
		v5 = {}
	end

	local v55, _ = fn5()

	for i = 1, #v55 do
		if i <= #v5 then
			continue
		end

		local v56 = v5[i] or {}
		table.insert(v5, v56)
	end

	local v56, v57 = fn5()
	local v58

	if p == nil then
		v58 = nil
	else
		v58 = v56[p]
	end

	local v59 = {}
	local v60 = false

	for i, polarity in ipairs(v56) do
		local v62 = v5[i]

		if __wf_atom_7e8ad928(v62) or __wf_atom_7e8ad928(v62.mItemType) then
			continue
		end

		v60 = polarity == 8 or v60
		table.insert(v59, {
			Polarity = polarity,
			Size = v62.mInstance:__wf_atom_1c14f269()
		})
	end

	local v61 = {}

	local function fn21(p2, p3)
		local v62 = v35[p2] .. v36[p3]

		if v61[v62] == nil then
			v61[v62] = 0
		end

		v61[v62] += 1
		return v62 .. v61[v62]
	end

	local v62 = not v60 and {} or v59

	for i, v63 in ipairs(v56) do
		local v64 = v57[i]
		local upgrade = v5[i]
		local v66 = "Container.Center" .. ".Slot" .. fn21(v63, v64)
		local v67 = v66
		local v68 = true

		if v63 == 8 then
			v68 = true
		elseif v64 <= 2 then
			for _, v70 in v62 do
				if not (v64 == 2 and v70.Polarity == 8) then
					continue
				end

				v68 = true
				break
			end
		end

		mMovie:__wf_atom_2dedec1a(v66, 67, v68)

		if __wf_atom_7e8ad928(upgrade) or __wf_atom_7e8ad928(upgrade.mItemType) then
			if i == p then
				module2.DissolveClipOut(mMovie, v66 .. ".Rune.Icon", 0.5, 0, 1, function()
					mMovie:__wf_atom_4c1c1986(v66, "Rune.Icon", 12, 0)
				end)
				module2.DissolveClipOut(mMovie, v66 .. ".SmallSlot.Rune.Icon", 0.5, 0, 1, function()
					mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.Icon", 12, 0)
				end)
				local v69 = 1

				while mMovie:__wf_atom_253d7085(v66 .. ".Rune.Icon" .. v69) do
					module2.DissolveClipOut(mMovie, v66 .. ".Rune.Icon" .. v69, 0.5)
					v69 += 1
				end
			else
				mMovie:__wf_atom_4c1c1986(v66, "Rune.Icon", 12, 0)
				mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.Icon", 12, 0)
				local v69 = 1

				while mMovie:__wf_atom_253d7085(v66 .. ".Rune.Icon" .. v69) do
					mMovie:__wf_atom_e57658c2(v66 .. ".Rune.Icon" .. v69, 12, 0)
					v69 += 1
				end
			end

			mMovie:__wf_atom_4c1c1986(v66, "Rune.EquippedGlow", 12, 0)
			mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.EquippedGlow", 12, 0)

			if v63 == 8 then
				v18 = nil
				mMovie:OverrideMaterial("Container.Center.CenterBacker", centerSlotMaterial)
				fn12()
			end
		else
			local v69 = math.max(upgrade.mInstance:__wf_atom_1c14f269(), v64)

			if v69 >= 2 or v64 < 2 then
				mMovie:__wf_atom_4c1c1986(v66, "Rune.EquippedGlow", 12, 20)
				mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.EquippedGlow", 12, 0)
			else
				mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.EquippedGlow", 12, 20)
				mMovie:__wf_atom_4c1c1986(v66, "Rune.EquippedGlow", 12, 0)
			end

			local v70

			if v69 < v64 then
				mMovie:__wf_atom_4c1c1986(v66, "Rune.Icon", 12, 0)
				v70 = v66 .. ".SmallSlot.Rune.Icon"
			else
				mMovie:__wf_atom_4c1c1986(v66, "SmallSlot.Rune.Icon", 12, 0)
				v70 = v66 .. ".Rune.Icon"
			end

			local storeItemInfo = module3.GetStoreItemInfo(mMovie, fn15(upgrade.mItemType), nil, nil, nil, true)

			if __wf_atom_7e8ad928(storeItemInfo) then
				__wf_atom_ec43d06e(mMovie, v70, 8, { 12 }, { 0 }, 0.5)
			else
				local v71 = 1
				mMovie:__wf_atom_e57658c2("Container.Center.MoteEquippedGlow", 12, module.Ternary(v60, 60, 0))

				if v63 == 8 then
					mMovie:__wf_atom_e57658c2(v70, 12, 0)
					v18 = nil

					if __wf_atom_7e8ad928(upgrade.mItemType) then
						mMovie:OverrideMaterial("Container.Center.CenterBacker", centerSlotMaterial)
					else
						mMovie:OverrideMaterial("Container.Center.CenterBacker", nil)
					end

					mMovie:__wf_atom_e57658c2(v70, 5, 1200)
					mMovie:__wf_atom_e57658c2(v70, 6, 1200)
				elseif i == p then
					mMovie:__wf_atom_e57658c2(v70, 12, 0)
					mMovie:__wf_atom_2dedec1a(v70, 13, false)
				end

				local polarity = v63
				local v73 = i
				asyncLoader:LoadResource("MoteIcon" .. i, upgrade.mItemType, function(p2)
					local instance = Resource(p2)

					if polarity == 8 then
						v18 = instance
					end

					local __wf_atom_0f53c1b9 = instance:__wf_atom_0f53c1b9()
					local __wf_atom_919e7078 = instance:__wf_atom_919e7078()
					v13 = instance:__wf_atom_68d47410()

					if v73 == p then
						fn11(polarity, upgrade.mItemType, instance, upgrade.mUpgradeFingerprint, upgrade)
						local __wf_atom_c05c3cf5 = instance:__wf_atom_c05c3cf5(upgrade.mUpgradeFingerprint)
						local isMatchingPolarity = module7.IsMatchingPolarity(__wf_atom_c05c3cf5, polarity)

						if v64 == 3 or isMatchingPolarity then
							v:AddTimer(0.4, function()
								if not __wf_atom_7e8ad928(v31) then
									v31:Destroy()
								end

								v31 = module.CreateUIParticles(mMovie, v70, slotRuneParticles, 0, 0)
							end)
						end

						v12:Redraw(nil, true, true)
						instance:__wf_atom_c6a5f697(upgrade.mUpgradeFingerprint)
						mMovie:__wf_atom_2dedec1a("Details.MoteName", 13, true)
						mMovie:__wf_atom_50d60589(
							"Details.MoteName",
							36,
							mMovie:__wf_atom_8e9ac384(instance:__wf_atom_014a76a2():c_str(), false)
						)
						local __wf_atom_3c90416d = instance:__wf_atom_3c90416d()

						if not __wf_atom_7e8ad928(__wf_atom_3c90416d) then
							module.PlaySound(__wf_atom_3c90416d)
						end

						if v58 == 8 then
							module.PlaySound(uiApplyMoteSound)
						end
					end

					if __wf_atom_7e8ad928(__wf_atom_0f53c1b9) then
						mMovie:__wf_atom_c90af43a(v70, storeItemInfo.Icon)
						mMovie:__wf_atom_e57658c2(v70, 12, 100)
					else
						for j = 1, math.min(3, #__wf_atom_0f53c1b9) do
							if not mMovie:__wf_atom_253d7085(v70 .. j) then
								__wf_atom_86cbd68d(mMovie, v70 .. ".duplicateMovieClip", "Icon" .. j, j + 1)
								mMovie:__wf_atom_2dedec1a(v70 .. j, 13, true)
							end

							mMovie:__wf_atom_e57658c2(v70 .. j, 12, 100)
							local ternary = module.Ternary(v64 == 3, v32, v33)

							if ternary[j] ~= nil then
								mMovie:__wf_atom_e57658c2(v70 .. j, 5, ternary[j])
								mMovie:__wf_atom_e57658c2(v70 .. j, 6, ternary[j])
							end

							if v73 == p then
								module2.DissolveClipIn(mMovie, v70 .. j, 0.5)
							end

							local ternary2 = module.Ternary(
								v64 == 3,
								_G.UIMaterial_RuneMaterial,
								_G.UIMaterial_AnimalMoteMaterial
							)

							if j == 2 then
								mMovie:__wf_atom_c90af43a(v70 .. 2, __wf_atom_0f53c1b9[2])
								mMovie:OverrideMaterial(v70 .. 2, ternary2)

								if v64 ~= 3 then
									local v75 = not (upgrade and upgrade.mUpgradeFingerprint) and -1
										or instance:__wf_atom_c05c3cf5(upgrade.mUpgradeFingerprint)
									mMovie:__wf_atom_e57658c2(v70 .. 2, 11, module7.CalcTotemColor(v75))
									local isMatchingPolarity = module7.IsMatchingPolarity(v75, polarity)
									mMovie:__wf_atom_e57658c2(
										v67 .. ".Backer",
										11,
										fn7(module.Ternary(isMatchingPolarity, v75, -1))
									)
								end

								if #__wf_atom_0f53c1b9 == 4 then
									mMovie:__wf_atom_f321ac85(v70 .. 2, Symbol("NormalMap"), __wf_atom_0f53c1b9[4])
								end
							elseif j == 3 then
								local __wf_atom_a8dac107 = instance:__wf_atom_a8dac107(upgrade.mUpgradeFingerprint)
								local __wf_atom_c6a5f697 = instance:__wf_atom_c6a5f697(upgrade.mUpgradeFingerprint)
								local v75 = 1 + __wf_atom_a8dac107 * 4 + __wf_atom_c6a5f697
								mMovie:__wf_atom_e57658c2(v70 .. 3, 12, 0)
								local __wf_atom_1c14f269 = instance:__wf_atom_1c14f269()
								local ternary3 = module.Ternary(
									__wf_atom_1c14f269 == 3,
									_G.UITexture_MoteFrameTexturesActive,
									_G.UITexture_MoteFrameTexturesPassive
								)
								mMovie:__wf_atom_c90af43a(v70 .. 3, ternary3[v75])
								mMovie:__wf_atom_e57658c2(v70 .. 3, 12, 100)
							else
								mMovie:__wf_atom_e57658c2(v70 .. j, 12, 0)
								mMovie:__wf_atom_c90af43a(v70 .. j, __wf_atom_0f53c1b9[j])

								if __wf_atom_7e8ad928(__wf_atom_919e7078) or #__wf_atom_919e7078 < j then
									mMovie:OverrideMaterial(v70 .. j, nil)
								else
									mMovie:OverrideMaterial(v70 .. j, __wf_atom_919e7078[j])
								end
							end
						end

						v71 = #__wf_atom_0f53c1b9 + 1

						while mMovie:__wf_atom_253d7085(v70 .. v71) do
							mMovie:__wf_atom_e57658c2(v70 .. v71, 12, 0)
							v71 += 1
						end
					end

					if v58 == 8 and p == v73 then
						v:AddTimer(0.4, function()
							if not __wf_atom_7e8ad928(v31) then
								v31:Destroy()
							end

							v31 = module.CreateUIParticles(mMovie, v70, slotMoteParticles, 0, 0)
						end)
						fn12()
					end
				end)
			end
		end
	end

	fn19()
	local v63 = { 1 }

	for _, v64 in ipairs({ 1, 2, 3 }) do
		for _, v65 in ipairs(v63) do
			local v66 = "Container.Center" .. ".Slot" .. fn21(v64, v65)

			while mMovie:__wf_atom_253d7085(v66) do
				mMovie:__wf_atom_2dedec1a(v66, 13, false)
				v66 = "Container.Center" .. ".Slot" .. fn21(v64, v65)
			end
		end
	end
end

local function fn21(p)
	if __wf_atom_7e8ad928(_T.WeaponToUpgrade) then
		return
	end

	local rawItem = _T.WeaponToUpgrade.RawItem
	module5.CreateProxyWeaponOneShot(arsenalAvatar, v2, rawItem.mXP, v5, function(p2)
		if not p then
			v9:SetType(p2, arsenalAvatar, true)
		end

		v9:Compare(p2)
		mMovie:__wf_atom_5e6e15c8("Details.StatsContainer", 1)
	end)
end

local function fn22(mIndex)
	if flag and not flag3 or __wf_atom_7e8ad928(_T.WeaponToUpgrade) then
		return
	end

	local rawItem = _T.WeaponToUpgrade.RawItem
	local upgradeIds = {}

	for i = 1, #v5 do
		local upgradeId = SF.UpgradeId()

		if not __wf_atom_7e8ad928(v5[i].mItemType) then
			upgradeId.mType = v5[i].mItemType
			upgradeId.mId = v5[i].mItemId
		end

		table.insert(upgradeIds, upgradeId)
	end

	inventory:__wf_atom_494e9b0e(rawItem.mItemId.mId, 0, false, upgradeIds)
	rawItem:__wf_atom_494e9b0e(upgradeIds)
	v5 = inventory:__wf_atom_43563387(rawItem.mItemId.mId, 0, false) or {}
	v6 = true
	local v55, _ = fn5()

	for i = 1, #v55 do
		if i <= #v5 then
			continue
		end

		local v56 = v5[i] or {}
		table.insert(v5, v56)
	end

	fn20(mIndex)
	fn12(true)
	fn21()
end

local function fn23(p)
	local v55 = v5
	v5 = {}
	local mIndex = v21.mIndex
	local v56 = inventory:__wf_atom_af539005(1, v2:__wf_atom_efa6f447(), v2, true) or {}
	local v57 = inventory:__wf_atom_05b32923(1, v2:__wf_atom_efa6f447(), v2, true) or {}
	table.move(v57, 1, #v57, #v56 + 1, v56)
	local v58 = {}
	local count = 0

	for _, v59 in v3 do
		if v21.mPolarity == v59.mPolarity and v55[v59.mIndex].mItemType == p.mItemType then
			table.insert(v58, v59.mIndex)
		end
	end

	local flag7 = false

	for _, v60 in ipairs(v56) do
		if not (p.mItemType == v60.mItemType and p.mItemId == v60.mItemId) then
			continue
		end

		for i = 1, #v55 do
			if not (i ~= v21.mIndex and v55[i].mItemType == p.mItemType and v55[i].mItemId == p.mItemId) then
				continue
			end

			count += 1

			if not (v60.mItemCount <= count) then
				continue
			end

			table.insert(v58, i)
			flag7 = true
			break
		end

		if flag7 then
			break
		end
	end

	local v60, _ = fn5(v55)

	for i = 1, #v60 do
		local v61 = {}

		if i == mIndex then
			v61 = p
		elseif i <= #v55 and not (__wf_atom_7e8ad928(v55[i]) or __wf_atom_7e8ad928(v55[i].mItemType)) then
			local v62 = false

			for _, v64 in ipairs(v58) do
				if i ~= v64 then
					continue
				end

				v62 = true
				v61 = {}
				break
			end

			if not v62 then
				v61 = v55[i]
			end
		end

		table.insert(v5, v61)
	end

	_T.SlottedWeaponModIndex = mIndex - 1
	_T.MoteSelectOpen = false
	fn22(mIndex)
	fn13(true)
	fn8(v5[mIndex])
end

local function fn24()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v55 = {}

	if flag3 and not flag4 then
		local ternary = module.Ternary(mMultiSelect, "<FULL_CHECK>", "<EMPTY_CHECK>")
		table.insert(v55, {
			Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MultiMoteReleaseToggle", true) .. " " .. ternary,
			CallBack = function()
				mMultiSelect = not mMultiSelect

				if mMultiSelect then
					mMovie:__wf_atom_e57658c2("EmptyState", 12, 0)
				else
					v23:MultiSellClear()
				end

				mMovie:__wf_atom_2dedec1a("MultiSelectContainer", 13, mMultiSelect)
				mMovie:__wf_atom_2dedec1a("Details", 13, not mMultiSelect)
				v11.UpdateSelectedCount = nil
				v11.mMultiSelect = mMultiSelect
				local v56 = fn4()
				fn(v56, false)
				fn24()
			end
		})
	end

	if flag3 and not flag4 and not __wf_atom_7e8ad928(v19) and v19.OwnsItem then
		table.insert(v55, {
			Label = "/SF/Language/Motes/MotesScreen_SlotMote",
			CallBack = function()
				if __wf_atom_7e8ad928(v19) then
					return
				end

				fn23(v19.StoreItemInfo.RawItem)
				fn24()
			end
		})
	end

	table.insert(v55, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = function()
			if flag3 then
				fn13()
				fn24()
			else
				if flag then
					return
				end

				AdvanceAndShutdown()
			end
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v55, getfenv(1))
	end
end

function RefreshCurrencyBar()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	mFusionPoints = module2.GetEnvoyInventoryControl():__wf_atom_259e7653(true).mFusionPoints
	storeManifest:__wf_atom_232fd31d(WeakResource("/SF/Types/Items/TransmogTokens/TransmogTokenTierA"))
	local v55 = {
		mCustomCurrencies = {
			{
				Icon = mMovie:__wf_atom_8e9ac384("<CURRENCY_MOTE_DUST>", true),
				Amount = mFusionPoints,
				Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/CurrencyMoteDustName", true),
				Description = mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/CurrencyMoteDustDesc", true)
			}
		},
		mOverwriteCurrencies = true,
		mMovie = mMovie
	}

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		v55.mLabel = __wf_atom_eab484a7:__wf_atom_6be84646()
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		v55.mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
		local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
		local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
		v55.mRankProgress = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a) * 100
	end

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v55)
	end
end

local function fn25(data)
	if not flag3 or __wf_atom_7e8ad928(data) or not data.OwnsItem then
		return false
	end

	local count = 0

	for i = 1, #v5 do
		if v5[i].mItemType == data.ItemInfo.mItemType and v5[i].mItemId == data.ItemInfo.mItemId then
			count += 1
		end
	end

	return not (data.StoreItemInfo.Count <= count)
end

function Initialize()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_c90af43a("MultiSelectContainer.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("MultiSelectContainer.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("MultiSelectContainer.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgFill", 11, 2825751)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgFill", 12, 65)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgEnd", 11, 2825751)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgEnd", 12, 65)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgStart", 11, 2825751)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.BgStart", 12, 65)
	mMovie:__wf_atom_dac78d3d(true)
	module2.DissolveIn(mMovie)
	module.PlaySound(uiMoteMenuOpen)
	v39.moteIndex = module6.GetColor(6, true, v38)
	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v = module8.CreateTimerMgr()
	arsenalAvatar = _T.ArsenalAvatar or gRegion:__wf_atom_c4f78a8f()
	v46 = gRegion:__wf_atom_0a6a5887(Symbol("ArsenalCameraPrimary"))
	v46:__wf_atom_e424c72a(true)
	v47 = gRegion:__wf_atom_2226b35c(Symbol("ArsenalLights"))
	inventory = gGameData:GetInventory()
	v4 = module2.GetEnvoyInventoryControl()
	fn24()
	local module9 = require("SF.Interface.Components.Button")
	v22 = module9.Create(
		mMovie,
		"Details.UpgradeButton",
		mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteUpgradeButton", false),
		"OpenMoteUpgradeModal"
	)
	v22:SetVariant(module9.VARIANTS.SPECIAL_BUTTON)
	v22:SetAnchor(module.CENTER_ALIGNED)
	local module10 = require("SF.Interface.Components.MultiDismantlePanel")
	v23 = module10.Create(
		mMovie,
		"MultiSelectContainer.MultiDismantlePanel",
		getfenv(1),
		multiSelectVerticalVisRangeMaterial,
		multiSelectVerticalVisRangeTextMaterial,
		{}
	)
	v23.OnMultiSellCompleted = OnMultiSellCompleted
	mMovie:__wf_atom_2dedec1a("MultiSelectContainer", 13, false)
	mMovie:__wf_atom_e57658c2("MultiSelectContainer.MultiDismantlePanel", 0, 70)
	mMovie:__wf_atom_2dedec1a("EmptyState.BgFill", 13, false)
	mMovie:__wf_atom_2dedec1a("EmptyState.BgEnd", 13, false)
	mMovie:__wf_atom_2dedec1a("EmptyState.BgStart", 13, false)
	mMovie:__wf_atom_2dedec1a("Details.BgFill", 13, false)
	mMovie:__wf_atom_2dedec1a("Details.BgEnd", 13, false)
	mMovie:__wf_atom_2dedec1a("Details.BgStart", 13, false)
	mMovie:__wf_atom_e57658c2("EmptyState.Title", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("EmptyState.Subtitle", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_50d60589("EmptyState.Title", 36, "[HC] No Enchantments")
	mMovie:__wf_atom_50d60589("EmptyState.Subtitle", 36, "[HC] No Enchantments")
	mMovie:__wf_atom_c90af43a("Details.Glow", hoverGlowTexture)
	mMovie:__wf_atom_c90af43a("Details.IconBacker", iconBackerTexture)
	mMovie:__wf_atom_c90af43a("Details.NameBacker", moteNameBacker)
	mMovie:__wf_atom_e57658c2("Details.NameBacker", 11, _G.UIColor_Black)
	mMovie:__wf_atom_e57658c2("Container", 12, 80)
	mMovie:__wf_atom_e57658c2("Details", 12, 80)
	mMovie:__wf_atom_e57658c2("Container.Center.CenterBacker", 12, 95)
	mMovie:__wf_atom_e57658c2("Container.Center.SlotMoteLarge1.Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.Center.SlotMoteLarge1.SmallSlot.Backer", 12, 0)
	mMovie:__wf_atom_933bbce0("Container.Center.MoteEquippedGlow.Glow", hoverGlowTexture, raysMaterial)
	mMovie:__wf_atom_e57658c2("Container.Center.MoteEquippedGlow", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.Center", 12, 0)
	mMovie:__wf_atom_e57658c2("Backer", 12, 0)

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	mMovie:__wf_atom_e57658c2("Details.Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.MoteName", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.MoteDescription", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("Container.InventoryAmount", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.MoteSelectTitle", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.Blurer", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.Blurer", 11, _G.UIColor_Black)
	mMovie:__wf_atom_c90af43a("Container.Blurer", centerShadowTexture)
	mMovie:__wf_atom_e57658c2("Container.SoftShadow", 12, 0)
	mMovie:__wf_atom_c90af43a("Container.SoftShadow", softShadowTexture)
	mMovie:__wf_atom_e57658c2("Container.SoftShadowInventory", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.SoftShadowInventory", 11, _G.UIColor_Black)
	local weaponToUpgrade = _T.WeaponToUpgrade
	local storeItemInfo = module3.GetStoreItemInfo(mMovie, fn15(weaponToUpgrade.Type), nil, nil, nil, true)
	mMovie:__wf_atom_50d60589("Details.Name", 36, storeItemInfo.Name)
	mMovie:__wf_atom_50d60589("Details.MoteName", 36, "")
	mMovie:__wf_atom_50d60589("Details.MoteDescription", 36, "")
	mMovie:__wf_atom_e57658c2("Details.MoteDescription", 12, 0)
	mMovie:__wf_atom_50d60589(
		"Details.UpgradeCost.Text",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteCostLabel", false)
	)
	mMovie:__wf_atom_e57658c2("Details.UpgradeCost.Text", 44, _G.UIColor_Gold)
	mMovie:__wf_atom_50d60589("Details.UpgradeCost.Amount", 36, mMovie:__wf_atom_8e9ac384("[HC] 123462781", true))
	mMovie:__wf_atom_e57658c2("Details.UpgradeCost.Amount", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_c90af43a("Details.UpgradeCost.Backer", upgradeCostBackerTexture)
	mMovie:__wf_atom_c90af43a("Details.UpgradeCost.Icon", moteDustTexture)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Details.Name", 40)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Details.Name", 14)

	if __wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8 then
		local v55 = __wf_atom_5e6e15c8_2 / __wf_atom_5e6e15c8
		mMovie:__wf_atom_e57658c2("Details.Name", 5, 100 * v55)
		mMovie:__wf_atom_e57658c2("Details.Name", 6, 100 * v55)
	end

	local module11 = require("SF.Interface.Components.Scrollbar")
	v10 = module11.CreateScrollBar(getfenv(1), "Details.Scrollbar", {
		mClipToScroll = "Details.MoteDescription",
		mVisRangeMaterials = { visRangeDetailsTextMat },
		mVisRangeFadeSize = 10
	})
	local v55 = {}

	local function fn26(p, p2)
		local v56 = v35[p] .. v36[p2]

		if v55[v56] == nil then
			v55[v56] = 0
		end

		v55[v56] += 1
		return v56 .. v55[v56]
	end

	asyncLoader:LoadResource("MoteInit", _T.WeaponToUpgrade.Type, function(p)
		v2 = Resource(p)

		if v3 == nil then
			v3 = {}
			local v56, v57 = fn5()

			for i, mPolarity in ipairs(v56) do
				local mSize = v57[i]
				local mId = 100 + i
				local mRootClip = "Container.Center" .. ".Slot" .. fn26(mPolarity, mSize)

				if v51[mPolarity] == nil then
					v51[mPolarity] = fn17(
						mMovie:__wf_atom_5e6e15c8(mRootClip, 0),
						mMovie:__wf_atom_5e6e15c8(mRootClip, 1)
					)
				end

				mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Backer", 12, 0)
				mMovie:__wf_atom_e57658c2(mRootClip, 12, 0)
				mMovie:__wf_atom_4c1c1986(mRootClip, "Rune.Icon", 12, 0)
				mMovie:__wf_atom_7f57ab2f(mRootClip, "Rune.Icon", 13, false)
				mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.Glow", 12, 0)
				mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.EquippedGlow", 12, 0)
				mMovie:__wf_atom_4c1c1986(mRootClip, "SmallSlot.Rune.Btn", 12, 0)
				mMovie:__wf_atom_933bbce0(mRootClip .. ".SmallSlot.Rune.Glow", hoverGlowTexture, raysMaterial)
				mMovie:__wf_atom_933bbce0(
					mRootClip .. ".SmallSlot.Rune.EquippedGlow",
					equippedGlowTexture,
					equippedGlowMaterial
				)
				local mClip = mRootClip .. ".Rune"
				mMovie:SetCallbacks(mClip .. ".Btn", "OnSlotFocus", "OnSlotUnfocus", "OnSlotReleased", "OnSlotPressed")
				mMovie:__wf_atom_e57658c2(mClip .. ".Btn", 100, mId)
				mMovie:__wf_atom_4c1c1986(mClip, "Glow", 12, 0)

				if mPolarity == 8 then
					v8 = mId
				end

				mMovie:__wf_atom_4c1c1986(mClip, "EquippedGlow", 12, 0)
				mMovie:__wf_atom_4c1c1986(mClip, "Btn", 12, 0)
				mMovie:__wf_atom_933bbce0(mClip .. ".Glow", hoverGlowTexture, raysMaterial)
				mMovie:__wf_atom_933bbce0(mClip .. ".EquippedGlow", equippedGlowTexture, equippedGlowMaterial)
				table.insert(v3, {
					mClip = mClip,
					mRootClip = mRootClip,
					mId = mId,
					mIndex = i,
					mPolarity = mPolarity,
					mSize = mSize
				})
			end
		end

		fn19()
		mMovie:__wf_atom_e57658c2("Container.Center", 12, 100)
		fn20()
		fn12()
		fn21()
		local mType = v2:__wf_atom_f090d983(1, 0).mType
		local mType2 = v2:__wf_atom_f090d983(1, 1).mType

		if not __wf_atom_7e8ad928(mType2) then
			mType = mType2
		end

		if not __wf_atom_7e8ad928(mType) then
			local __wf_atom_f090d983 = v2:__wf_atom_f090d983(0, 0)
			v45 = v46:Attach(
				mType,
				EMPTY_SYMBOL,
				__wf_atom_f090d983:__wf_atom_1118f075() + Vector(0, 0, 1),
				__wf_atom_f090d983:__wf_atom_01934aa5()
			)
			v46:__wf_atom_7e990320(3)
			v46:__wf_atom_8c3d9704(1)
			v46:__wf_atom_74d17eae(0, 0)
			v45:__wf_atom_1b57cb83(false)
			v45:__wf_atom_25c58c94(false)
			v45:SetVisibility(true, true)
			v45:__wf_atom_b811702e(Symbol("MoteWeapon"))
			v45:__wf_atom_e424c72a(true)
			v45:__wf_atom_68f2c268(1)
			v45:SetMeshScale(__wf_atom_f090d983:GetScale(), true)

			for i = 1, #v47 do
				v47[i]:TurnOff()
			end

			arsenalAvatar:__wf_atom_e424c72a(false)
		end

		flag6 = true
	end)
	local module12 = require("SF.Interface.Components.ThemedStats")
	v9 = module12.Create(mMovie, "Details.StatsContainer.Stats")
	v9.mLockHeightToMax = true
	v9.mGrowDownward = true
	v9.mCanFocusStats = true
	v9:SetWidth(450)
	v9.mStatsToOnlyShow = {
		"Level",
		"MeleeSkill",
		"AttuneType",
		"DamageType",
		"Total",
		"StabilityDamage",
		"HeavyAttack",
		"CriticalChance"
	}

	for i = 0, 2 do
		local attributeTypeTag = module2.GetAttributeTypeTag(i)
		table.insert(v9.mStatsToOnlyShow, "Requirement_" .. attributeTypeTag)
	end

	local module13 = require("EE.Interface.Components.ItemGrid")
	v11 = module13.Create(getfenv(1), "Container.InventoryGrid", {
		mRows = 3,
		mCanSelectItem = true,
		mVisRangeMaterials = { animalGridMaterial, runeGridMaterial }
	})
	v11.Old_OnDraw = v11.OnDraw

	function v11.OnDraw(object, data, p)
		object:Old_OnDraw(data, p)
		local v56 = data.mClipName .. ".Amount"
		local v57 = data.mClipName .. ".RankIconMini"

		if mMovie:__wf_atom_253d7085(v57) then
			mMovie:OverrideMaterial(v57 .. ".Icon", _G.UIMaterial_VerticalVisibilityRange)
			mMovie:OverrideMaterial(v57 .. ".Shadow", _G.UIMaterial_VerticalVisibilityRange)
		end

		mMovie:__wf_atom_2dedec1a(v56, 13, false)
		mMovie:__wf_atom_2dedec1a(v57, 13, data.OwnsItem or false)
		__wf_atom_86cbd68d(mMovie, v57 .. ".swapDepths", 120)

		if data.IsEmpty then
			mMovie:OverrideMaterial(data.mClipName .. ".Icon", _G.UIMaterial_VerticalVisibilityRange)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, _G.UIColor_Black)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 12, 50)
		elseif data.OwnsItem then
			local mUpgradeFingerprint = data.ItemInfo.mUpgradeFingerprint or ""
			local v58 = Resource(data.ItemInfo.mItemType)
			local __wf_atom_c6a5f697 = v58:__wf_atom_c6a5f697(mUpgradeFingerprint)

			if data.ItemInfo.mItemType:IsA(v44) then
				mMovie:OverrideMaterial(data.mClipName .. ".Icon", animalGridMaterial)
				local __wf_atom_c05c3cf5 = v58:__wf_atom_c05c3cf5(mUpgradeFingerprint)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, module7.CalcTotemColor(__wf_atom_c05c3cf5))
			else
				mMovie:OverrideMaterial(data.mClipName .. ".Icon", runeGridMaterial)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, _G.UIColor_White)
			end

			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 12, 100)

			if not mMovie:__wf_atom_253d7085(v56) then
				__wf_atom_86cbd68d(mMovie, data.mClipName .. ".Count.duplicateMovieClip", "Amount", 100)
				__wf_atom_86cbd68d(mMovie, data.mClipName .. ".IconOutline.swapDepths", 110)
				__wf_atom_86cbd68d(mMovie, data.mClipName .. ".StatusIconMini.swapDepths", 140)
				mMovie:OverrideMaterial(v56 .. ".Background", object.mVisRangeMaterials.Icon)
				mMovie:OverrideMaterial(v56 .. ".Text", object.mVisRangeMaterials.Text)
			end

			local mItemCount = data.ItemInfo.mItemCount or 1

			if mItemCount == 1 then
				mMovie:__wf_atom_2dedec1a(v56, 13, false)
			end

			mMovie:__wf_atom_48bd5a59(v56, "Text", 36, (tostring(mItemCount)))
			mMovie:__wf_atom_4c1c1986(v56, "Text", 44, _G.UIColor_Beige)
			mMovie:__wf_atom_4c1c1986(v56, "Background", 11, _G.UIColor_DarkBrown)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v56 .. ".Text", 40)
			mMovie:__wf_atom_4c1c1986(v56, "Background", 14, __wf_atom_5e6e15c8_3 + 8)

			for i = 1, __wf_atom_c6a5f697 do
				local v59 = v57 .. ".Icon" .. i
				local v60 = v57 .. ".Shadow" .. i

				if not mMovie:__wf_atom_253d7085(v57 .. ".Icon" .. i) then
					__wf_atom_86cbd68d(mMovie, v57 .. ".Shadow.duplicateMovieClip", "Shadow" .. i, 120 + i)
					__wf_atom_86cbd68d(mMovie, v57 .. ".Icon.duplicateMovieClip", "Icon" .. i, 130 + i)
					mMovie:__wf_atom_933bbce0(v59, rankStarIcon, object.mVisRangeMaterials.Icon)
					mMovie:__wf_atom_933bbce0(v60, rankStarShadow, object.mVisRangeMaterials.Icon)
				end

				mMovie:__wf_atom_e57658c2(v59, 12, 100)
				local v61 = 40 - (i - 1) * 16 + __wf_atom_c6a5f697 / 2 * 16
				mMovie:__wf_atom_e57658c2(v60, 12, 50)
				mMovie:__wf_atom_e57658c2(v59, 0, v61)
				mMovie:__wf_atom_e57658c2(v60, 0, v61)
				mMovie:__wf_atom_e57658c2(v59, 1, 108)
				mMovie:__wf_atom_e57658c2(v60, 1, 108)
				mMovie:__wf_atom_e57658c2(v59, 11, _G.UIColor_White)
				mMovie:__wf_atom_e57658c2(v60, 11, _G.UIColor_White)
				mMovie:__wf_atom_2dedec1a(v59, 13, true)
				local v62 = __wf_atom_c6a5f697 == 3 and i == 2 and 24 or 20
				mMovie:__wf_atom_e57658c2(v59, 14, v62)
				mMovie:__wf_atom_e57658c2(v59, 15, v62)
			end

			mMovie:__wf_atom_4c1c1986(v57, "Shadow", 0, 48)
			mMovie:__wf_atom_4c1c1986(v57, "Shadow", 1, 108)
			mMovie:__wf_atom_4c1c1986(v57, "Shadow", 14, 64)
			mMovie:__wf_atom_4c1c1986(v57, "Shadow", 15, 32)
			mMovie:__wf_atom_4c1c1986(v57, "Shadow", 11, _G.UIColor_DarkerBrown)
			mMovie:__wf_atom_4c1c1986(v57, "Icon", 0, 48)
			mMovie:__wf_atom_4c1c1986(v57, "Icon", 1, 108)
			mMovie:__wf_atom_4c1c1986(v57, "Icon", 14, 64)
			mMovie:__wf_atom_4c1c1986(v57, "Icon", 15, 32)
			mMovie:__wf_atom_4c1c1986(v57, "Icon", 11, _G.UIColor_Gold)
			mMovie:__wf_atom_4c1c1986(v57, "IconBg", 12, 70)

			if __wf_atom_c6a5f697 > 0 then
				mMovie:__wf_atom_7f57ab2f(v57, "Shadow", 13, true)
				mMovie:__wf_atom_7f57ab2f(v57, "Icon", 13, true)
			else
				mMovie:__wf_atom_7f57ab2f(v57, "Shadow", 13, false)
				mMovie:__wf_atom_7f57ab2f(v57, "Icon", 13, false)

				for i = 1, 3 do
					local v59 = v57 .. ".Icon" .. i
					local v60 = v57 .. ".Shadow" .. i
					mMovie:__wf_atom_2dedec1a(v59, 13, false)
					mMovie:__wf_atom_2dedec1a(v60, 13, false)
				end
			end

			mMovie:__wf_atom_c90af43a(v57 .. ".Shadow", rankStarBacker[1])
			mMovie:__wf_atom_c90af43a(v57 .. ".Icon", rankStarBacker[2])
		else
			mMovie:OverrideMaterial(data.mClipName .. ".Icon", nil)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, _G.UIColor_Black)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 12, 50)
			mMovie:OverrideMaterial(data.mClipName .. ".Icon", _G.UIMaterial_VerticalVisibilityRange)
		end
	end

	function v11:mOnFocusedCallback()
		if self.mClipName == nil then
			return
		end

		if self.OwnsItem then
			local _ = v19 == self
			module4.SetItemInfoPopupRect(
				mMovie,
				self.StoreItemInfo,
				mMovie:__wf_atom_5e6e15c8("Container.InventoryGrid", 2) + 112,
				mMovie:__wf_atom_5e6e15c8("Container.InventoryGrid", 3) + 128,
				-mMovie:__wf_atom_5e6e15c8("Container.InventoryGrid", 14),
				mMovie:__wf_atom_5e6e15c8(self.mClipName, 15)
			)
			local count = 0

			for i = 1, #v5 do
				if v5[i].mItemType == self.ItemInfo.mItemType and v5[i].mItemId == self.ItemInfo.mItemId then
					count += 1
				end
			end

			if count < self.StoreItemInfo.Count and not mMultiSelect then
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
					module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
					true
				)
				local statusIconTooltip = __wf_atom_8e9ac384 .. " " .. mMovie:__wf_atom_8e9ac384(
					"/SF/Language/Motes/MotesScreen_MoteSell",
					true
				)

				if not __wf_atom_7e8ad928(v21) and v21.mPolarity == 8 then
					statusIconTooltip = __wf_atom_8e9ac384 .. " " .. mMovie:__wf_atom_8e9ac384(
						"/SF/Language/Motes/MotesScreen_RuneSell",
						true
					)
				end

				self.StatusIconTooltip = statusIconTooltip
			else
				self.StoreItemInfo.SubtitleOverride = nil
				self.StatusIconTooltip = nil
			end

			local storeItemInfo2 = self.StoreItemInfo

			if not __wf_atom_7e8ad928(v21) then
				storeItemInfo2.Polarity = v21.mPolarity
			end

			local v56 = self.mClipName .. ".RankIconMini"
			mMovie:__wf_atom_4c1c1986(v56, "Icon", 11, _G.UIColor_Yellow)
		else
			__wf_atom_7e8ad928(v19)
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Count.Text", 44, _G.UIColor_Yellow)

		if fn25(self) then
			v26 = self
		else
			v26 = nil
		end

		v20 = self
		fn12()
	end

	function v11.mOnUnfocusedCallback(p)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Count.Text", 44, v39.moteIndex)

		if v19 == nil or v19 ~= p and p.OwnsItem then
			__wf_atom_7e8ad928(v19)
		end

		v26 = nil
		v20 = nil

		if p.mClipName ~= nil then
			local v56 = p.mClipName .. ".RankIconMini"
			mMovie:__wf_atom_4c1c1986(v56, "Icon", 11, _G.UIColor_Gold)
		end
	end

	function v11.mOnSelectedCallback(data)
		if flag4 or not data.IsSelectable then
			return
		end

		if not mMultiSelect then
			if data.IsEmpty then
				fn23({})
			else
				fn23(data.StoreItemInfo.RawItem)
			end
		end

		fn24()
	end

	function v11.mIncrementSelectedCallback(originalElement)
		if fn25(originalElement) then
			local __wf_atom_e8638878 = v26.ItemInfo.mInstance:__wf_atom_e8638878(originalElement.ItemInfo.mUpgradeFingerprint)
			local v56 = {
				CacheId = originalElement.Id,
				Count = originalElement.SelectedCount,
				Name = originalElement.Name,
				Value = __wf_atom_e8638878,
				OriginalElement = originalElement,
				IDList = originalElement.ListOfIds
			}
			v23:UpdateDismantleState(v56)
		end
	end

	function v11.mDecrementSelectedCallback(originalElement)
		if fn25(originalElement) then
			local __wf_atom_e8638878 = v26.ItemInfo.mInstance:__wf_atom_e8638878(originalElement.ItemInfo.mUpgradeFingerprint)
			local v56 = {
				CacheId = originalElement.Id,
				Count = originalElement.SelectedCount,
				Name = originalElement.Name,
				Value = __wf_atom_e8638878,
				OriginalElement = originalElement,
				IDList = originalElement.ListOfIds
			}
			v23:UpdateDismantleState(v56)
		end
	end

	mMovie:__wf_atom_e57658c2("Container.InventoryGrid.Bg", 12, 500)
	mMovie:__wf_atom_e57658c2("Container.InventoryGrid.TitleBar.Backer", 12, 500)
	mMovie:__wf_atom_2dedec1a("Container.InventoryGrid", 13, false)
	mMovie:__wf_atom_2dedec1a("Container.MotePreview", 13, false)
	local module14 = require("EE.Interface.Components.List")
	v30 = module14.CreateList(mMovie, "Details.InfoToggle.List.Dot")
	v30.mForcedHorizontalSeparation = 14
	v30.mForcedVerticalSeparation = 0

	function v30.mElementDrawCallback(p)
		if p.mClipName == nil then
			return
		end

		local v56 = v30.mSelectedElement ~= nil and v30.mSelectedElement.Id == p.Id
		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".gotoAndStop", module.Ternary(v56, "Selected", "Unfocused"))
	end

	v30:AddElement({ State = v40.DESCRIPTION }, true)
	v30:Redraw(nil, nil, true)
	v12 = module14.CreateList(mMovie, "Details.StatsList.Element1")
	v12.mForcedVerticalSeparation = 96

	function v12.mElementDrawCallback(data)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Text", 36, data.Text)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", data.Icon)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Glow", statsHighlightGlowIcon)
		mMovie:__wf_atom_933bbce0(data.mClipName .. ".IconGlow", matchingPolarityGlowIcon, raysMaterial)
		local v56 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Text", 41) - 23
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 1, 16 - v56 / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 15, 80 + v56)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 12, 50)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Glow", 13, data.IsHighlighted)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "IconGlow", 13, data.PolarityMatch or false)
		local ternary = module.Ternary(data.IsHighlighted, 100, 30)
		mMovie:__wf_atom_e57658c2(data.mClipName, 12, ternary)
	end

	function v12:AnimateTextChange(text)
		__wf_atom_ec43d06e(mMovie, "Details.StatsList.Element1.Text", 8, { 12 }, { 0 }, 0.5, 0, function()
			self.Text = text
			mMovie:__wf_atom_50d60589("Details.StatsList.Element1.Text", 36, text)
			__wf_atom_ec43d06e(mMovie, "Details.StatsList.Element1.Text", 8, { 12 }, { 100 }, 0.5, 0, function()
				v28 = nil
				flag5 = nil
			end)
		end)
	end

	local ternary = module.Ternary(Engine.__wf_atom_5df63302(), "<MENU_RTRIGGER1>", "<NEXT_MENU>")
	mMovie:__wf_atom_7d7314f1("Details.InfoToggle.Callout.text", ternary)
	mMovie:__wf_atom_e57658c2("Details.InfoToggle", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a("Details.InfoToggle", 13, false)
	local v56 = v30:GetHowManyElements() * v30.mForcedHorizontalSeparation + 5
	mMovie:__wf_atom_e57658c2("Details.InfoToggle.List", 0, 0)
	mMovie:__wf_atom_e57658c2("Details.InfoToggle.Callout", 0, v56)
	fn12()
	RefreshCurrencyBar()
end

local function fn26(p)
	total += p * 1
	local v55 = -(math.cos((math.sin(total) * 0.5 + 0.5) * 3.1415927410125732) - 1) / 2
	local mIndex = -1

	if not __wf_atom_7e8ad928(v8) then
		local v56 = fn3(v8)

		if v56 ~= nil then
			mIndex = v56.mIndex
		end
	end

	local v56 = {}

	local function fn27(p2, p3)
		local v57 = v35[p2] .. v36[p3]

		if v56[v57] == nil then
			v56[v57] = 0
		end

		v56[v57] += 1
		return v57 .. v56[v57]
	end

	local v57 = fn10()
	local v58, v59 = fn5()

	for i, v60 in ipairs(v58) do
		local v61 = "Container.Center.Slot" .. fn27(v60, v59[i])

		if i == mIndex then
			local v62 = math.min(mMovie:__wf_atom_5e6e15c8(v61 .. ".Rune.Glow", 12) + p * 2 * 100, 100)
			mMovie:__wf_atom_4c1c1986(v61, "Rune.Glow", 12, v62)
		elseif v57 then
			mMovie:__wf_atom_4c1c1986(v61, "Rune.Glow", 12, v55 * 75)
		else
			local v62 = math.max(mMovie:__wf_atom_5e6e15c8(v61 .. ".Rune.Glow", 12) - p * 2 * 100, 0)
			mMovie:__wf_atom_4c1c1986(v61, "Rune.Glow", 12, v62)
		end
	end
end

function Update()
	local v55 = __wf_atom_084b3e93()
	local v56 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v56)
	asyncLoader:Update()

	if not __wf_atom_7e8ad928(v) then
		v:Update(v55)
	end

	if not __wf_atom_7e8ad928(v45) then
		local v57 = v55 * -3

		if flag2 then
			v57 = v55 * 3
		end

		local v58 = __wf_atom_421b01aa(v45:__wf_atom_f43b1463() + v57, 0, 1)
		v45:__wf_atom_68f2c268(v58)
		local __wf_atom_f090d983 = v2:__wf_atom_f090d983(0, 0)
		v45:__wf_atom_e310f01f(
			__wf_atom_f090d983:__wf_atom_1118f075() + Vector(0, 0, 1),
			__wf_atom_f090d983:__wf_atom_01934aa5()
		)
		v45:SetMeshScale(__wf_atom_f090d983:GetScale(), true)

		if _T.UITools then
			_T.UITools.mWeapon = v2
		end
	end

	fn16("Container.Center.SlotMoteLarge1.Rune", v56)

	if v42 > 0 then
		v42 = math.max(0, v42 - v56)
	end

	fn26(v55)
end

fn = function(p, p2, p3)
	local count = 0
	local count2 = 0
	asyncLoader:AbortLoad("MotesList")
	v11:Redraw(nil, true, true)
	v11:RemoveElements(true, true)
	v11:Redraw(nil, true, true)
	local __wf_atom_caa82b8d = storeManifest:__wf_atom_caa82b8d(WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade"))
	local __wf_atom_caa82b8d2 = storeManifest:__wf_atom_caa82b8d(WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade"))
	table.move(__wf_atom_caa82b8d, 1, #__wf_atom_caa82b8d, #__wf_atom_caa82b8d2 + 1, __wf_atom_caa82b8d2)

	local function fn27(storeItemInfo)
		local v55

		if __wf_atom_7e8ad928(storeItemInfo.RawItem.mItemType) then
			v55 = Resource(storeItemInfo.RawItem)
		else
			v55 = Resource(storeItemInfo.RawItem.mItemType)
		end

		local __wf_atom_1c14f269 = v55:__wf_atom_1c14f269()

		if v21.mSize ~= __wf_atom_1c14f269 then
			return false, false
		end

		local canUseWithItem = v55:CanUseWithItem("", v2)

		if canUseWithItem then
			return true, canUseWithItem
		end

		return false, canUseWithItem
	end

	local v55 = inventory:__wf_atom_af539005(1, v2:__wf_atom_efa6f447(), v2, true) or {}
	local v56 = inventory:__wf_atom_05b32923(1, v2:__wf_atom_efa6f447(), v2, true) or {}
	table.move(v56, 1, #v56, #v55 + 1, v55)
	local v57 = {}

	for i = 1, #__wf_atom_caa82b8d2 do
		table.insert(v57, __wf_atom_caa82b8d2[i]:GetItem())
	end

	local v58 = -1

	local function fn28(storeItem, list, ownsItem, p4)
		local itemInfo

		if p4 == nil then
			itemInfo = Resource(storeItem:GetItem())
		else
			itemInfo = p4
		end

		local storeItemInfo = module3.GetStoreItemInfo(mMovie, storeItem, { ItemInfo = itemInfo }, nil, nil, true)
		local v60, v61 = fn27(storeItemInfo)

		if not v60 then
			return
		end

		count2 += 1

		if ownsItem then
			count += 1
		end

		local __wf_atom_2941433a = storeItem:__wf_atom_2941433a()
		local v62 = Resource(itemInfo.mItemType)
		local polarity = __wf_atom_7e8ad928(v62) and 0 or v62:__wf_atom_c05c3cf5(itemInfo.mUpgradeFingerprint)
		local v64 = {
			Name = storeItemInfo.Name,
			Icon = storeItemInfo.Icon,
			OwnsItem = ownsItem,
			Count = storeItemInfo.Count,
			ShowCount = true,
			StoreItemInfo = storeItemInfo,
			SortingPriority = __wf_atom_2941433a,
			ItemInfo = itemInfo,
			Category = storeItem:__wf_atom_efa6f447(),
			IsSelectable = v61 and ownsItem,
			Polarity = polarity,
			StoreItem = storeItem,
			HideGrip = true
		}

		if ownsItem then
			for _, v66 in ipairs(v5) do
				if not (p4.mItemType == v66.mItemType and p4.mItemId == v66.mItemId) then
					continue
				end

				v64.Equipped = true
				v64.IsSelectable = not mMultiSelect
				break
			end
		end

		table.insert(list, v64)
	end

	asyncLoader:LoadMultipleResources("MotesList", v57, function()
		local v59 = {}

		for i = 1, #__wf_atom_caa82b8d2 do
			local storeItem = __wf_atom_caa82b8d2[i]

			for _, v62 in ipairs(v55) do
				if storeItem:GetItem() == v62.mItemType then
					fn28(storeItem, v59, true, v62)
				end
			end
		end

		table.sort(v59, function(a, b)
			if v37[a.Polarity] == p.mPolarity and v37[b.Polarity] ~= p.mPolarity then
				return true
			end

			if v37[b.Polarity] == p.mPolarity and v37[a.Polarity] ~= p.mPolarity then
				return false
			end

			if a.Polarity == b.Polarity then
				return a.SortingPriority < b.SortingPriority
			end

			return a.Polarity < b.Polarity
		end)
		local v60 = {
			Name = "[HC] Unequip",
			Icon = emptyStateIcon,
			IsEmpty = true,
			IsSelectable = not mMultiSelect
		}
		v11:AddElement(v60, true)
		local v61 = {}
		local v62 = {}

		for _, v63 in v59 do
			if v63.ItemInfo.mItemType == nil then
				continue
			end

			local mUpgradeFingerprint = v63.ItemInfo.mUpgradeFingerprint or ""
			local v64 = Resource(v63.ItemInfo.mItemType)
			local __wf_atom_a8dac107 = v64:__wf_atom_a8dac107(mUpgradeFingerprint or "")
			local __wf_atom_c6a5f697 = v64:__wf_atom_c6a5f697(mUpgradeFingerprint or "")
			local __wf_atom_1c14f269 = v64:__wf_atom_1c14f269()
			local v65 = 1 + __wf_atom_a8dac107 * 4 + __wf_atom_c6a5f697
			local ternary = module.Ternary(
				__wf_atom_1c14f269 == 3,
				_G.UITexture_MoteFrameTexturesActive,
				_G.UITexture_MoteFrameTexturesPassive
			)
			v63.ExtraOverlayPadding = 10
			v63.IconWidthOverride = 80
			v63.IconHeightOverride = 80
			v63.IconOverlay = ternary[v65]
			v63.ItemInfo.mItemType:IsA(v44)
			local _ = v63.Polarity == nil
			v64:__wf_atom_c6a5f697(mUpgradeFingerprint)
			local v66 = mUpgradeFingerprint .. v63.ItemInfo.mItemType:GetName() .. tostring((fn25(v63)))

			if v61[v66] == nil then
				v63.ListOfIds = { v63.ItemInfo.mItemId }
				v61[v66] = v63
				table.insert(v62, v63)
			else
				v61[v66].Count = v61[v66].Count + 1
				table.insert(v61[v66].ListOfIds, v63.ItemInfo.mItemId)
			end
		end

		if #v62 > 0 then
			v59 = v62
		end

		for i, v63 in ipairs(v59) do
			v11:AddElement(v63, true)

			if not (p3 ~= nil and tostring(p3) == tostring(v63.StoreItemInfo.RawItem.mItemId)) then
				continue
			end

			v58 = i
		end

		if v59 == nil or #v59 == 0 then
			if p.mPolarity == 8 then
				mMovie:__wf_atom_50d60589(
					"EmptyState.Title",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_NoRunesInGrid", false)
				)
				mMovie:__wf_atom_50d60589(
					"EmptyState.Subtitle",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_RuneDescriptionPlaceholder", false)
				)
			else
				mMovie:__wf_atom_50d60589(
					"EmptyState.Title",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_NoMotesInGrid", false)
				)
				mMovie:__wf_atom_50d60589(
					"EmptyState.Subtitle",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteDescriptionPlaceholder", false)
				)
			end
		end

		v11:Redraw(nil, true, true)
		v11:SetCount(count, count2)

		if v58 > 0 then
			v11:SelectElement(v58)
			fn6("Container.MotePreview.Icon", v11.mElements[v58])
		end

		local v63 = mMovie:__wf_atom_5e6e15c8("Container", 0) - mMovie:__wf_atom_5e6e15c8(
			"Container.InventoryGrid.TitleBar",
			2
		)
		mMovie:__wf_atom_e57658c2(
			"Container.InventoryGrid",
			0,
			mMovie:__wf_atom_5e6e15c8("Container.InventoryGrid", 0) + v63
		)

		if p2 then
			mMovie:__wf_atom_2dedec1a("Container.InventoryGrid", 13, true)
			mMovie:__wf_atom_e57658c2("Container.InventoryGrid", 12, 0)
			mMovie:__wf_atom_e57658c2("Container.MotePreview", 12, 0)
			__wf_atom_ec43d06e(mMovie, "Container.InventoryGrid", 8, { 12 }, { 100 }, 0.5)
			__wf_atom_ec43d06e(mMovie, "Container.MotePreview", 8, { 12 }, { 100 }, 0.5)
			__wf_atom_ec43d06e(mMovie, "Container.Blurer", 8, { 12 }, { 100 }, 0.5)
		end

		if v58 <= 0 then
			fn6("Container.MotePreview.Icon", nil)
		end
	end)
end

local function fn27(p)
	module.PlaySound(uiSelectSound)
	v21 = p

	if p.mPolarity == 8 then
		v11:SetTitle("/SF/Language/Motes/MotesScreen_ChooseActiveText")
	else
		v11:SetTitle("/SF/Language/Motes/MotesScreen_ChoosePassiveText")
	end

	flag = true
	flag3 = true
	_T.MoteSelectOpen = true
	local confirmDialogTitle = p.mPolarity == 8 and "/SF/Language/Motes/MotesScreen_RuneSell"
		or "/SF/Language/Motes/MotesScreen_MoteSell"
	local confirmDialogDesc = p.mPolarity == 8 and "/SF/Language/Motes/MotesScreen_MultiRuneSellConfirmation"
		or "/SF/Language/Motes/MotesScreen_MultiMoteSellConfirmation"
	v23:UpdateCustomizationData({
		confirmDialogTitle = confirmDialogTitle,
		confirmDialogDesc = confirmDialogDesc,
		currencyType = "<CURRENCY_MOTE_DUST>",
		panelTitle = "/SF/Language/Motes/MotesScreen_MultiMoteReleaseTitle"
	})
	fn24()
	mMovie:__wf_atom_2dedec1a("Details.UpgradeCost", 13, false)
	v22:SetVisible(false)
	__wf_atom_ec43d06e(mMovie, "Details.MoteName", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details.MoteDescription", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details.Icon", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details.Icon1", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details.Icon2", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details.Icon3", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Container.SoftShadowInventory", 8, { 12 }, { 60 }, 0.2)
	fn(p, true)
end

function OpenMoteUpgradeModal()
	local polarity = fn4()
	local mItemType, mUpgradeFingerprint

	if flag3 then
		if __wf_atom_7e8ad928(v19) then
			return
		end

		mItemType = v19.StoreItemInfo.RawItem.mItemType
		mUpgradeFingerprint = v19.StoreItemInfo.RawItem.mUpgradeFingerprint
	else
		if __wf_atom_7e8ad928(polarity) then
			return
		end

		local v56 = v5[polarity.mIndex]
		mItemType = v56.mItemType
		mUpgradeFingerprint = v56.mUpgradeFingerprint
	end

	local v56 = mUpgradeFingerprint or ""
	local instance = Resource(mItemType)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_5d16ab7c = instance:__wf_atom_5d16ab7c(v56)
	local v58 = instance:__wf_atom_c6a5f697(v56) + 1
	local rankFlowerIcons = module2.GetRankFlowerIcons(v58)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(instance:__wf_atom_014a76a2():c_str(), false)
	local stringWithFont = module2.WrapStringWithFont(__wf_atom_8e9ac384, _G.UIColor_Yellow, "Spectral SC")
	local stringWithFont2 = module2.WrapStringWithFont(tostring(__wf_atom_5d16ab7c), _G.UIColor_Yellow)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "<p>" .. mMovie:__wf_atom_8e9ac384(
		"/SF/Language/Motes/MotesScreen_MoteUpgradeConfirmation",
		false,
		{ NAME = stringWithFont, RANK = rankFlowerIcons, CURRENCY = stringWithFont2 }
	) .. "</p>"

	if polarity ~= nil then
		local upgrade = v5[polarity.mIndex]
		local moteDescription = module7.GetMoteDescription({
			Type = upgrade.mItemType,
			Instance = instance,
			Upgrade = upgrade,
			Polarity = polarity,
			Weapon = v2
		}, true, mMovie)
		_T.AdditionalDesc = moteDescription
	end

	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
		"/SF/Language/Motes/MotesScreen_MoteUpgradeConfirmationTitle",
		false
	)

	if fn2(v21) then
		__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
			"/SF/Language/Motes/MotesScreen_RuneUpgradeConfirmationTitle",
			false
		)
	end

	dialogSettings.titleString = __wf_atom_8e9ac384_2
	dialogSettings.firstString = mMovie:__wf_atom_8e9ac384("/SF/Language/SystemMessages/UpgradePact", false)
	dialogSettings:SetCallback("OnMoteUpgradeConfirm")
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function OnMoteUpgradeConfirm(p)
	if tonumber(p) ~= 4 then
		return
	end

	module.PlaySound(upgradeTotemSound)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local mItemType, mItemId, mUpgradeFingerprint

	if flag3 then
		if __wf_atom_7e8ad928(v19) then
			return
		end

		mItemType = v19.StoreItemInfo.RawItem.mItemType
		mItemId = v19.StoreItemInfo.RawItem.mItemId
		mUpgradeFingerprint = v19.StoreItemInfo.RawItem.mUpgradeFingerprint
	else
		local v55 = fn4()

		if __wf_atom_7e8ad928(v55) then
			return
		end

		local v56 = v5[v55.mIndex]
		mItemType = v56.mItemType
		mItemId = v56.mItemId
		mUpgradeFingerprint = v56.mUpgradeFingerprint
	end

	local mUpgradeFingerprint2 = mUpgradeFingerprint or ""
	local v56 = Resource(mItemType)
	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemId = mItemId
	upgradeInfo.mUpgradeFingerprint = mUpgradeFingerprint2
	upgradeInfo.mItemType = mItemType
	local __wf_atom_5d16ab7c = v56:__wf_atom_5d16ab7c(mUpgradeFingerprint2)
	local __wf_atom_d1afe4c7 = v56:__wf_atom_d1afe4c7(mUpgradeFingerprint2)
	v27 = SF.FusionOperation()
	v27.mUpgrade = upgradeInfo
	v27.mLevelDiff = 1
	v27.mFusionPointCost = __wf_atom_5d16ab7c
	v27.mCost = __wf_atom_d1afe4c7

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
	end

	__wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_a1c18c92(v27, "OnMoteUpgradeApplied")
	_T.AdditionalDesc = nil
end

function OnMoteUpgradeApplied(p, mItemId)
	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	v27 = nil

	if v29 then
		v28 = module7.GetMoteDescription(v29, nil, nil, true)
	end

	if not p then
		return
	end

	local v55 = fn4()

	if flag3 then
		RefreshCurrencyBar()
		fn(v55, false, mItemId)
	else
		if __wf_atom_7e8ad928(v55) then
			return
		end

		local v56 = v5[v55.mIndex]
		local upgradeInfo = SF.UpgradeInfo()
		upgradeInfo.mItemId = mItemId
		upgradeInfo.mUpgradeFingerprint = v56.mUpgradeFingerprint
		upgradeInfo.mItemType = v56.mItemType
		v5[v55.mIndex] = upgradeInfo
		fn22(v55.mIndex)
		RefreshCurrencyBar()
	end
end

function OnSlotFocus(p)
	if flag3 then
		return
	end

	if not __wf_atom_7e8ad928(v8) then
		if v8 == p then
			return
		end

		local v55 = fn3(v8)

		if v55 ~= nil and not fn10() then
			__wf_atom_ec43d06e(mMovie, v55.mClip .. ".Glow", 8, { 12 }, { 0 }, 0.2)
		end
	end

	if flag then
		v7 = nil
		return
	end

	local v55 = fn3(p)

	if v55 == nil then
		v7 = nil
		return
	end

	module.PlaySound(uiHoverSound)
	__wf_atom_ec43d06e(mMovie, v55.mClip .. ".Glow", 8, { 12 }, { 100 }, 0.2)
	v7 = p
	local v56 = v5[v55.mIndex]
	v8 = p
	fn12()

	if not (__wf_atom_7e8ad928(v56) or __wf_atom_7e8ad928(v56.mItemType)) then
		v8 = p
		_T.SlottedWeaponModIndex = v55.mIndex - 1
		fn12()
	end
end

function OnSlotUnfocus(_)
	if flag3 then
		return
	end

	_T.InfoPopup_Data = nil
	local v55 = fn3(v7)
	v7 = nil

	if v55 == nil then
	end
end

function OnSlotPressed(p)
	if flag then
		return
	end

	local v55 = fn3(p)

	if v55 == nil then
		return
	end

	fn27(v55)
end

function OnSlotReleased(_)
	if flag then
	end
end

local function fn28()
	if not fn25(v26) then
		return false
	end

	v24 = SF.SellOperation()
	v24:__wf_atom_afdfc7fe()
	v24.mSellCurrency = 2
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v26.ItemInfo.mInstance:__wf_atom_014a76a2():c_str(), false)
	local __wf_atom_e8638878 = v26.ItemInfo.mInstance:__wf_atom_e8638878(v26.ItemInfo.mUpgradeFingerprint)
	v24.mSellPrice = __wf_atom_e8638878 * 1

	if v26.ItemInfo.mItemId:__wf_atom_b70c3343() then
		v24:SellItem(v26.Category, tostring(v26.StoreItemInfo.FullName), 1)
	else
		v24:SellItem(v26.Category, tostring(v26.ItemInfo.mItemId), 0)
	end

	local __wf_atom_c6a5f697 = v26.ItemInfo.mInstance:__wf_atom_c6a5f697(v26.ItemInfo.mUpgradeFingerprint)
	local rankFlowerIcons = module2.GetRankFlowerIcons(__wf_atom_c6a5f697)
	local stringWithFont = module2.WrapStringWithFont(__wf_atom_8e9ac384, _G.UIColor_Yellow, "Spectral SC")
	local stringWithFont2 = module2.WrapStringWithFont(tostring(__wf_atom_e8638878 * math.max(1, 1)), _G.UIColor_Yellow)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteSell", false)

	if fn2(v21) then
		__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_RuneSell", false)
		dialogSettings.firstDelay = 1.5
	end

	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MoteSellConfirmation", false, {
		NAME = stringWithFont,
		RANK = rankFlowerIcons,
		CURRENCY = stringWithFont2
	})
	dialogSettings.titleString = __wf_atom_8e9ac384_2
	dialogSettings:SetCallback("OnMoteSellConfirmed")
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
	return true
end

function OnMoteSellConfirmed(p)
	if tonumber(p) ~= 4 or v25 ~= nil then
		return
	end

	v25 = SF.SellCommand(v24, "OnMoteSellCompleted")
	v25:Execute()

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
	end
end

function OnMoteSellCompleted(_, _)
	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	fn27(v21)
	RefreshCurrencyBar()
	v25 = nil
	v24 = nil
end

function OnMultiSellCompleted()
	fn27(v21)
	RefreshCurrencyBar()
end

function onKeyDown_MENU_RIGHT_CLICK()
	if v11.mMultiSelect then
		return false
	end

	if flag3 then
		fn28()
	else
		local v55 = fn4()

		if not __wf_atom_7e8ad928(v55) then
			local v56 = v5[v55.mIndex]

			if not __wf_atom_7e8ad928(v56) and not __wf_atom_7e8ad928(v56.mItemType) and v22:IsActive() then
				OpenMoteUpgradeModal()
			end
		end
	end

	return true
end

function onKeyDown_MENU_GENERIC2()
	onKeyDown_MENU_RIGHT_CLICK()
	return true
end

local function fn29(p)
	local mScrollBar

	if mMultiSelect then
		mScrollBar = v23.mScrollBar
	else
		mScrollBar = v10
	end

	if flag3 and v11 ~= nil then
		local mScrollBar2 = v11.mScrollBar

		if
			mScrollBar2 ~= nil
			and mScrollBar2.mVisible
			and mScrollBar2.mEnabled
			and mMovie:__wf_atom_79258be8() > mMovie:__wf_atom_5e6e15c8(mScrollBar.mClipName, 2) + 100
		then
			mScrollBar = mScrollBar2
		end
	end

	if mScrollBar == nil then
		return
	end

	mScrollBar:ScrollByStep((tonumber(p)))
end

local function fn30(_) end

function onKeyDown_MENU_RTRIGGER1()
	return fn30(module.INCREMENT)
end

function onKeyDown_NEXT_MENU()
	return true
end

function onRawInputEvent(_, p, p2)
	local v55 = p2 == "1"

	if p == "EN_LSHIFT" or p == "EN_RSHIFT" then
		v41 = v55
	elseif v55 and p == "EN_TAB" then
		fn30(module.Ternary(v41, module.DECREMENT, module.INCREMENT))
	end
end

function OnGamepadTransition(_)
	local ternary = module.Ternary(Engine.__wf_atom_5df63302(), "<MENU_RTRIGGER1>", "<NEXT_MENU>")
	mMovie:__wf_atom_7d7314f1("Details.InfoToggle.Callout.text", ternary)
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	fn29(p)
end

function Shutdown()
	_T.InfoPopup_Data = nil
	_T.AdditionalDesc = nil

	if not __wf_atom_7e8ad928(v45) then
		v45:Destroy()
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(v31) then
		v31:Destroy()
	end
end