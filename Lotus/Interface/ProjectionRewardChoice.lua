local module = require("Lotus.Interface.StoreItemUtilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("Lotus.Interface.UIUtilities")
local module4 = require("EE.Interface.Utilities")
local currencyBar_ExtraCurrency = Resource("/Lotus/Types/Items/MiscItems/VoidTearDrop")
local v = Resource("/Lotus/Types/Game/Store/RelicStoreManifest")
local total = 0
local v2 = false
local flag = false
local v3 = {}
local v4 = nil
local v5 = {}
local flag2 = true
local flag3 = false
local v6 = false
local v7 = nil
local flag4 = false
local v8 = true
local v9 = false
local v10 = false
local infoPopup_Grid = nil
local v11 = nil
local flag5 = false
local flag6 = false
local v12 = false
local flag7 = false
local flag8 = false
local v13 = nil
local v14 = { x = 0, y = 0 }
local v15 = { "/Lotus/Language/Labels/COMMON", "/Lotus/Language/Labels/UNCOMMON", "/Lotus/Language/Labels/RARE" }

function onViewportSizeChanged(_, _) end

function HideBackgroundMovie()
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 1.5)
	local movie = __wf_atom_8e4fda44:FindMovie(countdownMovieRes)

	if not __wf_atom_7e8ad928(movie) then
		__wf_atom_ec43d06e(movie, "_root", 8, { 12 }, { 0 }, 0.5, 1.5)
	end

	local movie2 = __wf_atom_8e4fda44:FindMovie(backgroundMovie)

	if not __wf_atom_7e8ad928(movie2) then
		movie2:Execute("TransitionOut", "")
	end
end

local function fn()
	if flag4 then
		if not v10 then
			local movie = __wf_atom_8e4fda44:FindMovie(backgroundMovie)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("TransitionOut", "")
			end
		end
	elseif not flag7 and __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(backgroundMovie))) then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(backgroundMovie)
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Execute("SetCountdown", "0")
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	if total > 0 and not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_d2b2176d():GiveBonusNonReplicatedMiscItem(currencyBar_ExtraCurrency, total)
		end
	end

	mMovie:Close()
end

function Close()
	print("Reward choice force closed")
	fn()
end

local function fn2()
	total = 0
	local v16 = {}
	local _ = false
	v4:RunForAllElements(function(p)
		if v16[p.mPlayerInfo.RewardIndex] == nil then
			v16[p.mPlayerInfo.RewardIndex] = {}
		end

		if p.mPlayerInfo.IsLocal then
			_ = p.mPlayerInfo.Index == p.mPlayerInfo.RewardIndex
		end

		table.insert(v16[p.mPlayerInfo.RewardIndex], {
			Name = p.mPlayerInfo.Name,
			IsLocal = p.mPlayerInfo.IsLocal
		})
	end)
	v4:RunForAllElements(function(p)
		if p.mClipName == nil then
			return
		end

		local v17 = p.mClipName .. "Info.PlayerNames"
		local v18 = ""
		local v19 = v16[p.mPlayerInfo.Index]

		if v19 ~= nil then
			for i = 1, #v19 do
				local name = v19[i].Name

				if v19[i].IsLocal then
					v18 = " <font color=\"" .. module4.ConvertColorNumberToHex(module2.GetColor(10, true)) .. "\">" .. name .. "</font>\r" .. v18
				else
					if p.mPlayerInfo.IsLocal then
						name ..= " <font face=\"Roboto\"><b>+" .. voidTracePerPlayer .. "</font></b>" .. mMovie:__wf_atom_8e9ac384("<LUMINOUS>", true)
						total += voidTracePerPlayer
					end

					v18 ..= name .. "\r"
				end
			end
		end

		local convertColorNumberToHex = module4.ConvertColorNumberToHex(module2.GetColor(9, true))
		mMovie:__wf_atom_50d60589(
			v17,
			36,
			"<p><font color=\"" .. convertColorNumberToHex .. "\">" .. v18 .. "</font></p>"
		)
	end)
end

local function fn3()
	local color = module2.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("EndlessBonus.Title", 11, color)
	mMovie:__wf_atom_e57658c2("EndlessBonus.Dividers", 11, color)

	if not flag7 then
		fn2()
		return
	end

	for i = 1, #v4.mElements do
		local mClipName = v4.mElements[i].mClipName

		if mClipName ~= nil then
			mMovie:__wf_atom_e57658c2(mClipName .. "Info.PlayerNames", 11, color)
		end
	end
end

local function fn4(p, p2)
	local mPlayerInfo = nil
	local mPlayerInfo2 = nil

	for i = 1, #v4.mElements do
		if v4.mElements[i].mPlayerInfo.Id == p then
			mPlayerInfo = v4.mElements[i].mPlayerInfo
		end

		if v4.mElements[i].mPlayerInfo.Id == p2 then
			mPlayerInfo2 = v4.mElements[i].mPlayerInfo
		end
	end

	if mPlayerInfo == nil or mPlayerInfo2 == nil then
		return
	end

	mPlayerInfo.RewardIndex = mPlayerInfo2.Index
	mPlayerInfo.RewardVoidProjection = mPlayerInfo2.LoadOutVoidProjection
	fn2()
end

function OnRewardSelected(p, p2)
	fn4(p, p2)
end

local function fn5(p)
	if not flag2 then
		return
	end

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		print("gGameRules was nil in ProjectionRewardChoice.lua local function SelectRewardFromPlayer(), SetVoidProjectionForReward() failed!")
	else
		gGameRules:SetVoidProjectionForReward(v5.Id, p.mPlayerInfo.Id)
	end

	fn4(v5.Id, p.mPlayerInfo.Id)
end

local function fn6()
	v4:RemoveElements(true, true)

	for i = 1, #_T.SquadRelics do
		local squadRelic = _T.SquadRelics[i]
		squadRelic.IconHeight = nil

		if squadRelic.IsLocal then
			v4:InsertElement(1, squadRelic, true)
		else
			v4:AddElement(squadRelic, true)
		end
	end

	v4:Redraw(nil, nil, true)
	fn3()
	local v16 = v4.mColumnSeparation * (v4:GetHowManyElements() - 1)
	mMovie:__wf_atom_e57658c2("RewardList", 0, v4.mInitListXPos - v16 / 2)
	mMovie:__wf_atom_2dedec1a("NoReward", 13, false)
	flag8 = true

	if _T.HideHud == nil then
		_T.HideHud = 1
	else
		_T.HideHud = _T.HideHud + 1
	end
end

local function fn7()
	v4:RemoveElements(true, true)
	v4.mPrevSelectedId = nil
	flag2 = false
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local v16 = {}

	for i = 1, #v3 do
		local v17 = {
			Name = v3[i].mName,
			Id = v3[i].mAccountId,
			VoidProjection = v3[i].mVoidProjection,
			GetsReward = v3[i].mQualifiesForReward,
			Reward = v3[i].mReward,
			BonusRelic = v3[i].mRewardProjection
		}
		local rarity = 0
		local v18 = Resource(v3[i].mVoidProjection)

		if not __wf_atom_7e8ad928(v18) then
			local __wf_atom_ff7834ae = v18:__wf_atom_ff7834ae()

			if not __wf_atom_7e8ad928(__wf_atom_ff7834ae) then
				for j = 0, __wf_atom_ff7834ae:__wf_atom_8cfee589() do
					for k = 0, __wf_atom_ff7834ae:__wf_atom_d1247c6c(j) - 1 do
						local tieredItem = __wf_atom_ff7834ae:GetTieredItem(j, k)

						if
							__wf_atom_7e8ad928(tieredItem)
							or __wf_atom_7e8ad928(tieredItem.mStoreItem)
							or tieredItem.mStoreItem ~= v3[i].mReward
						then
							continue
						end

						rarity = tieredItem:__wf_atom_a8dac107()
						v17.QuantityMultiplier = tieredItem.mItemCount
					end
				end
			end
		end

		v17.Rarity = rarity
		table.insert(v16, v17)
	end

	table.sort(v16, function(a, b)
		return a.Id < b.Id
	end)
	local v17 = {}

	for i = 1, #v16 do
		local mPlayerInfo = v16[i]
		mPlayerInfo.Index = i
		mPlayerInfo.RewardIndex = i

		if __wf_atom_7e8ad928(mPlayerInfo.VoidProjection) then
			continue
		end

		mPlayerInfo.LoadOutVoidProjection = mPlayerInfo.VoidProjection
		mPlayerInfo.RewardVoidProjection = mPlayerInfo.VoidProjection

		if not __wf_atom_7e8ad928(mPlayerInfo.Reward) then
			table.insert(v17, mPlayerInfo.Reward:__wf_atom_5b41f63b())
		end

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) and mPlayerInfo.Id == __wf_atom_eab484a7:__wf_atom_e3587084() then
			mPlayerInfo.IsLocal = true
			v5 = mPlayerInfo
			flag3 = true

			if not __wf_atom_7e8ad928(mPlayerInfo.BonusRelic) then
				table.insert(v17, mPlayerInfo.BonusRelic:__wf_atom_5b41f63b())
			end
		end

		if not mPlayerInfo.GetsReward then
			continue
		end

		if mPlayerInfo.IsLocal then
			flag2 = true

			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
				print("gGameRules was nil in ProjectionRewardChoice.lua local function PopulatePlayerInfos(), SetVoidProjectionForReward() failed!")
			else
				gGameRules:SetVoidProjectionForReward(v5.Id, v5.Id)
			end

			v4:InsertElement(
				1,
				{
					mPlayerInfo = mPlayerInfo,
					Name = Localize("/Lotus/Language/Menu/LoadoutSelection_Loading", {})
				},
				true
			)
		else
			v4:AddElement(
				{
					mPlayerInfo = mPlayerInfo,
					Name = Localize("/Lotus/Language/Menu/LoadoutSelection_Loading", {})
				},
				true
			)
		end
	end

	if #v17 > 0 then
		v6 = true
		v7 = UISys.__wf_atom_c0dbe47c(v17)
	end

	v4:Redraw(nil, nil, true)
	fn2()
	local v18 = v4.mColumnSeparation * (v4:GetHowManyElements() - 1)
	mMovie:__wf_atom_e57658c2("RewardList", 0, v4.mInitListXPos - v18 / 2)
	local ternary = module4.Ternary(v4:GetHowManyElements() == 1, 8, 15)

	if not __wf_atom_7e8ad928(v11) then
		v11:Execute("SetCountdown", tostring(ternary) .. ",SelectionCountdownDone")
	end

	mMovie:SetVisible(true)
	flag8 = true

	if _T.HideHud == nil then
		_T.HideHud = 1
	else
		_T.HideHud = _T.HideHud + 1
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Objectives/VoidFissureTitle", false),
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionStats_Rewards", false)
		)
	end

	mMovie:__wf_atom_2dedec1a("NoReward", 13, not flag2)

	if not flag2 then
		if flag3 then
			mMovie:__wf_atom_7d7314f1("NoReward.Title.text", "/Lotus/Language/Menu/VoidRewardSelect_NoQualifyTitle")
			mMovie:__wf_atom_7d7314f1("NoReward.Desc.text", "/Lotus/Language/Menu/VoidRewardSelect_NoQualifyDesc")
		else
			mMovie:__wf_atom_7d7314f1("NoReward.Title.text", "/Lotus/Language/Menu/VoidRewardSelect_NoRewardTitle")
			mMovie:__wf_atom_7d7314f1("NoReward.Desc.text", "/Lotus/Language/Menu/VoidRewardSelect_NoRewardDesc")
		end
	end
end

local function fn8(data, isFocused)
	local filler = data.Filler or data.EmptySlot
	return {
		HideCountThreshold = 0,
		OwnedInfo = { TagOverride = "/Lotus/Language/Menu/Crafting_Owned_Icon_Label" },
		HideOwned = flag7,
		IsFiller = filler,
		IsFocused = isFocused,
		IsSelected = not filler and v4.mPrevSelectedId == data.Id,
		Locked = data.Equipped,
		LockedMsg = "/Lotus/Language/Menu/ItemSelection_Equipped",
		ShowInfoPopup = isFocused and not (data.Locked or data.Hidden),
		ZoomYShift = -78
	}
end

local function fn9(p, p2)
	module3.OnGridItemCreated(mMovie, v4, p)
	local v16 = p .. "Info"
	local mIndex

	if mMovie:__wf_atom_253d7085(v16) then
		mIndex = 1
	else
		local v17 = StringSplit(".", v16)
		__wf_atom_86cbd68d(mMovie, v4.mElements[1].mClipName .. "Info.duplicateMovieClip", v17[#v17], p2.Id + 1000)
		mIndex = p2.mIndex
	end

	mMovie:__wf_atom_4c1c1986(v16, "RarityBar.Backer", 100, mIndex)
	mMovie:SetCallbacks(
		v16 .. ".RarityBar.Backer",
		"RarityBarFocused",
		"RarityBarUnfocused",
		"RarityBarReleased",
		"RarityBarPressed"
	)
end

local function fn10(p)
	local mClipName = p.mClipName

	if mClipName == nil then
		return
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 14)
	local v16 = mMovie:__wf_atom_5e6e15c8(mClipName, 2) - __wf_atom_5e6e15c8 - 85
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 15)
	local v17 = mMovie:__wf_atom_5e6e15c8(mClipName, 3) + __wf_atom_5e6e15c8_2 + 10
	module3.OnGridItemFocusChanged(mMovie, v4, p, (fn8(p, true)))
	module3.SetItemInfoPopupRect(mMovie, p, v16, v17, __wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2)
end

local function fn11(p)
	if p.mClipName == nil then
		return
	end

	module3.OnGridItemFocusChanged(mMovie, v4, p, (fn8(p, false)))
end

local function fn12(data)
	if data.mClipName == nil then
		return
	end

	module3.DrawGridItem(mMovie, v4, data, (fn8(data, data == v4:GetFocusedElement())))
	local mClipName = data.mClipName
	mMovie:__wf_atom_2dedec1a(mClipName .. "Info", 13, true)
	mMovie:__wf_atom_e57658c2(mClipName .. "Info", 0, mMovie:__wf_atom_5e6e15c8(mClipName, 0))
	mMovie:__wf_atom_e57658c2(mClipName .. "Info", 1, mMovie:__wf_atom_5e6e15c8(mClipName, 1))

	if flag7 then
		mMovie:__wf_atom_e57658c2("RewardList", 1, 160)
		mMovie:__wf_atom_2dedec1a(mClipName .. "Info.RarityBar", 13, false)
		mMovie:__wf_atom_e57658c2(mClipName .. "Info.PlayerNames", 1, -127)
		mMovie:__wf_atom_50d60589(mClipName .. "Info.PlayerNames", 36, data.PlayerName)
	else
		local drawRarityBar = module3.DrawRarityBar
		local mMovie2 = mMovie
		drawRarityBar(mMovie2, mClipName .. "Info.RarityBar", {
			[data.mPlayerInfo.Rarity + 1] = 1
		}, v4.ElementWidth, barMaterial, 0, 0, -v4.ElementWidth / 2)
		mMovie:__wf_atom_e57658c2(mClipName .. "Info.RarityBar.CenterIcon", 5, 125)
		mMovie:__wf_atom_e57658c2(mClipName .. "Info.RarityBar.CenterIcon", 6, 125)
	end
end

local function fn13()
	local module5 = require("EE.Interface.Components.Grid")
	v4 = module5.CreateGrid(mMovie, "RewardList.Item", nil, 4, 1)
	v4:SetCallbacks("RewardSelected", "RewardFocused", "RewardUnfocused")
	v4.mInitListXPos = mMovie:__wf_atom_5e6e15c8("RewardList", 0)
	v4.mShowLabels = true
	v4.ElementWidth = 200
	v4.ElementHeight = 200
	v4.mColumnSeparation = 202
	v4.mSelectedScale = 100
	v4.mUseCornerForSelected = true
	v4.mSelectElementsOnFocus = false
	v4.mWrapAroundNavigation = false
	v4.mPrevSelectedId = nil
	v4.mClipCreatedCallback = fn9
	v4.mOnFocusedCallback = fn10
	v4.mOnUnfocusedCallback = fn11
	v4.mElementDrawCallback = fn12

	function v4.mOnSelectedCallback(p)
		if p.mClipName == nil then
			return
		end

		local mPrevSelectedId = v4.mPrevSelectedId

		if mPrevSelectedId ~= nil and mPrevSelectedId == p.Id then
			return
		end

		v4.mPrevSelectedId = p.Id
		module4.PlaySound(_G.UISound_Select)
		module4.PlaySound(_G.UISound_ItemTipSection)

		if mPrevSelectedId ~= nil then
			local elementById = v4:GetElementById(mPrevSelectedId)

			if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
				fn12(elementById)
			end
		end

		fn12(p)
		fn5(p)
	end
end

function OnVoidRewards()
	v9 = true
	mMovie:__wf_atom_e57658c2("Hint", 12, 0)

	if not __wf_atom_7e8ad928(v11) then
		v11:Close()
	end

	print("Got rewards")
	v11 = mMovie:PushChildMovie(countdownMovieRes)
	v3 = 0

	if not __wf_atom_7e8ad928(gGameRules) then
		v3 = gGameRules:__wf_atom_113c0ef7()
	end

	if #v3 > 0 then
		fn7()
		return
	end

	print("No Void Participants; something has gone horribly wrong!")
	fn()
end

function OnRewardsFailed(_)
	if not __wf_atom_7e8ad928(v11) then
		v11:Close()
	end

	print("Failed to get rewards")
	v11 = mMovie:PushChildMovie(countdownMovieRes)
	v12 = false

	if not __wf_atom_7e8ad928(v11) then
		v11:Execute("SetCountdown", "10,SelectionCountdownDone")
		v11:Execute("SetHint", "/Lotus/Language/Menu/VoidRewardSelect_RetrievingRewardsConnectionFailed")
	end

	flag = true
	v2 = false
end

function SetCloseAfterCountdown()
	flag6 = true
end

local function fn14()
	local module5 = require("EE.Interface.Components.List")
	infoPopup_Grid = module5.CreateList(mMovie, "EndlessBonus.BoosterList.Booster")
	infoPopup_Grid:SetCallbacks(nil, "BonusFocused", "BonusUnfocused")
	infoPopup_Grid.mVisibleElements = 5
	infoPopup_Grid.mForcedHorizontalSeparation = 64
	infoPopup_Grid.mForcedVerticalSeparation = 0

	function infoPopup_Grid.mOnFocusedCallback(infoPopup_Data)
		_T.InfoPopup_Data = infoPopup_Data
		_T.InfoPopup_Grid = infoPopup_Grid
	end

	function infoPopup_Grid.mOnUnfocusedCallback(_)
		_T.InfoPopup_Data = nil
		_T.InfoPopup_Grid = nil
	end

	function infoPopup_Grid.mElementDrawCallback(data)
		local active = data.IsRelic and data.Active

		if not active then
			if data.CurrPercent == nil then
				active = false
			else
				active = data.CurrPercent > 0
			end
		end

		local v16 = (data.Active and 1.25 or 1) * infoPopup_Grid.mForcedHorizontalSeparation * 0.6
		local mClipName = data.mClipName
		local color = module2.GetColor(data.Active and 10 or 9, true)
		local convertColorNumberToProceduralRGB = module4.ConvertColorNumberToProceduralRGB(module2.GetColor(2, true))
		local convertColorNumberToProceduralRGB2 = module4.ConvertColorNumberToProceduralRGB(module2.GetColor(1, true))
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, v16)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, data.Themed and v16 or v16 * 1.6)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 12, module4.Ternary(active, 100, 30))
		mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", data.Texture)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Amount", 13, active)
		mMovie:__wf_atom_4c1c1986(mClipName, "Amount", 11, color)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, data.Active == true)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 11, color)
		mMovie:__wf_atom_933bbce0(mClipName .. ".Glow", glowIcon, glowMaterial)
		mMovie:OverrideMaterial(mClipName .. ".Diamond", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			mClipName .. ".Diamond",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.5
		)
		mMovie:__wf_atom_1ca72041(
			mClipName .. ".Diamond",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.5
		)

		if data.IsRelic then
			mMovie:__wf_atom_48bd5a59(
				mClipName,
				"Amount",
				36,
				"+" .. TitleCase(Localize("/Lotus/Language/Dojo/TradeTypeProjections", {}))
			)
		elseif active then
			mMovie:__wf_atom_7d7314f1(mClipName .. ".Amount.text", "/Lotus/Language/Menu/ProgressPercentage", {
				CURRENT = "+" .. data.CurrPercent
			})
		end

		module3.SetItemInfoPopupRect(
			mMovie,
			data,
			mMovie:__wf_atom_5e6e15c8(mClipName .. ".Btn", 2),
			mMovie:__wf_atom_5e6e15c8(mClipName .. ".Btn", 3),
			64,
			100
		)
	end

	local iconTexture, themed = module.GetIconTexture(xpBooster, true)
	infoPopup_Grid:AddElement({
		Texture = iconTexture,
		Themed = themed,
		CustomEntry = true,
		CurrPercent = 0,
		Booster = xpBooster,
		Name = Localize(xpBooster:__wf_atom_014a76a2():c_str(), {})
	}, true)
	local iconTexture2, themed2 = module.GetIconTexture(creditBooster, true)
	infoPopup_Grid:AddElement({
		Texture = iconTexture2,
		Themed = themed2,
		CustomEntry = true,
		CurrPercent = 0,
		Booster = creditBooster,
		Name = Localize(creditBooster:__wf_atom_014a76a2():c_str(), {})
	}, true)
	local iconTexture3, themed3 = module.GetIconTexture(resourceAmountBooster, true)
	infoPopup_Grid:AddElement({
		Texture = iconTexture3,
		Themed = themed3,
		CustomEntry = true,
		CurrPercent = 0,
		Booster = resourceAmountBooster,
		Name = Localize(resourceAmountBooster:__wf_atom_014a76a2():c_str(), {})
	}, true)
	local iconTexture4, themed4 = module.GetIconTexture(resourceRateBooster, true)
	infoPopup_Grid:AddElement({
		Texture = iconTexture4,
		Themed = themed4,
		CustomEntry = true,
		CurrPercent = 0,
		Booster = resourceRateBooster,
		Name = Localize(resourceRateBooster:__wf_atom_014a76a2():c_str(), {})
	}, true)
	infoPopup_Grid:AddElement({
		Texture = relicTexture,
		Themed = true,
		CustomEntry = true,
		IsRelic = true,
		Name = Localize("/Lotus/Language/Dojo/TradeTypeProjections", {}),
		LocalizedDesc = TitleCase(Localize("/Lotus/Language/Menu/BonusReward", {}))
	}, true)
	infoPopup_Grid:Redraw()
	local v16 = infoPopup_Grid.mForcedHorizontalSeparation * (infoPopup_Grid:GetHowManyElements() - 1)
	mMovie:__wf_atom_e57658c2("EndlessBonus.BoosterList", 0, -(v16 / 2))
end

function CountdownDone()
	flag5 = false

	if flag6 then
		print("Closed after countdown")
		fn()
	elseif not __wf_atom_7e8ad928(_T.EnableUIInput) then
		_T.EnableUIInput(true)
	end
end

function SelectionCountdownDone()
	flag5 = false

	if flag6 then
		print("Closed after countdown")
		fn()
	elseif not __wf_atom_7e8ad928(_T.EnableUIInput) then
		_T.EnableUIInput(true)
	end

	v12 = true

	if flag then
		flag = false
		return
	end

	print("Selection countdown done")
	fn()
end

function PauseCountdownDone()
	print("Pause countdown done")
	flag5 = false

	if flag6 then
		print("Closed after countdown")
		fn()
	elseif not __wf_atom_7e8ad928(_T.EnableUIInput) then
		_T.EnableUIInput(true)
	end

	if not flag6 then
		_T.SmoothProjectionTransitions = true
		mMovie:SetVisible(false)
		v11 = nil

		if not (__wf_atom_7e8ad928(gRegion) or gRegion:IsMaster() or v9) then
			v11 = mMovie:PushChildMovie(countdownMovieRes)

			if not __wf_atom_7e8ad928(v11) then
				v11:Execute("EnableAutoCountdown", "false")
				v11:Execute("SetHint", "/Lotus/Language/Menu/VoidRewardSelect_RetrievingRewards,false")
			end
		end
	end
end

function Shutdown()
	_T.InfoPopup_Data = nil
	_T.SquadRelics = nil
	_T.gToolTip = nil
	_T.CurrencyBar_ExtraCurrency = nil
	_T.CurrencyBar_ExtraCurrencyMax = nil

	if flag8 then
		if _T.HideHud ~= nil then
			_T.HideHud = _T.HideHud - 1
		end

		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle()
		end
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	print("Relic reward screen shut down")
end

local function fn15()
	v13 = {}

	if not __wf_atom_7e8ad928(gGameData) then
		local v16 = WeakResource("/Lotus/Upgrades/Mods/Immortal/ImmortalBaseMod")

		local function fn16(list, p)
			for i = 1, #list do
				local v17 = false

				if p and list[i].mItemType:IsA(v16) then
					local decoded = cjson.decode(list[i].mUpgradeFingerprint)
					v17 = decoded ~= nil and decoded.lvl == 3 or false
				end

				if v17 then
					continue
				end

				local __wf_atom_5b41f63b = list[i].mItemType:__wf_atom_5b41f63b()
				local v18 = v13[__wf_atom_5b41f63b]

				if v18 == nil then
					v13[__wf_atom_5b41f63b] = list[i].mItemCount
				else
					v13[__wf_atom_5b41f63b] = v18 + list[i].mItemCount
				end
			end
		end

		local inventory = gGameData:GetInventory()
		fn16(inventory:__wf_atom_c84817dd())
		fn16(inventory:__wf_atom_49479502())
		fn16(inventory:__wf_atom_8844017b())
		fn16(inventory:GetUpgrades(), true)
		fn16(inventory:__wf_atom_063f1444())
	end
end

local function fn16()
	local v16 = tostring(gGameRules:__wf_atom_72fc675e():Copy().levelOverride:__wf_atom_5b41f63b())
	return string.find(v16, "Defense") or string.find(v16, "Orphix") or string.find(v16, "Survival")
end

function Initialize()
	local v16

	if gGameRules:IsA(__wf_atom_dd9a0bb8) then
		v16 = gGameRules:__wf_atom_e22d6f15()
	end

	local v17

	if v16 == 32 then
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("VoidProjectionFlow"))

		if __wf_atom_d163c8e5 == 3 then
			print("close projection reward screen for being open during " .. 3)
			mMovie:Close()
			return
		else
			v17 = fn16()
		end
	else
		v17 = false
	end

	_T.CurrencyBar_ExtraCurrency = currencyBar_ExtraCurrency
	_T.CurrencyBar_ExtraCurrencyMax = module.GetMaxVoidTrace()
	fn13()
	mMovie:__wf_atom_2dedec1a("RewardList.ItemInfo", 13, false)
	mMovie:__wf_atom_2dedec1a("NoReward", 13, false)
	mMovie:__wf_atom_e57658c2("NoReward", 12, 75)
	mMovie:__wf_atom_e57658c2("Hint", 12, 0)
	mMovie:__wf_atom_7d7314f1("Hint.text", "/Lotus/Language/Menu/VoidRewardSelect_RetrievingRewards")
	mMovie:__wf_atom_2dedec1a("EndlessBonus", 13, false)

	if not __wf_atom_7e8ad928(consumablesOverlayMovie) then
		local movie = __wf_atom_8e4fda44:FindMovie(consumablesOverlayMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("Close", "")
		end
	end

	v11 = mMovie:PushChildMovie(countdownMovieRes)

	if _T.SquadRelics == nil then
		fn15()
		fn14()

		if v17 or v16 == 8 or v16 == 13 or v16 == 2 or v16 == 17 or v16 == 27 or v16 == 33 then
			v10 = true
			flag5 = true

			if not __wf_atom_7e8ad928(v11) then
				v11:Execute("SetPauseCountdown", 5 .. ",PauseCountdownDone")
				mMovie:SetVisible(false)
			end
		elseif not __wf_atom_7e8ad928(_T.EnableUIInput) then
			_T.EnableUIInput(true)
		end
	else
		_T.SmoothProjectionTransitions = nil
		flag7 = true
		v2 = true
		mMovie:__wf_atom_2dedec1a("EndlessBonus", 13, false)

		if not __wf_atom_7e8ad928(_T.EnableUIInput) then
			_T.EnableUIInput(true)
		end

		if not __wf_atom_7e8ad928(v11) then
			v11:Execute("AddCallback", "2,HideBackgroundMovie")
			v11:Execute("SetUnpauseCountdown", 5 .. ",Close")
			v11:Execute("SetPosition", 800 .. "," .. 125)
		end

		mMovie:__wf_atom_e57658c2("RewardList", 12, 0)
		__wf_atom_ec43d06e(mMovie, "RewardList", 8, { 12 }, { 100 }, 0.5, 0.25)
		fn6()
	end

	fn3()
	mMovie:__wf_atom_d5a50cb5()
	mMovie:__wf_atom_c4f6543f()
end

local function fn17() -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(backgroundMovie))) then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(backgroundMovie)
	end
end

function Update()
	if flag5 and __wf_atom_7e8ad928(v11) then
		print("Waiting for countdown but timer died")
		flag5 = false

		if flag6 then
			print("Closed after countdown")
			fn()
		elseif not __wf_atom_7e8ad928(_T.EnableUIInput) then
			_T.EnableUIInput(true)
		end
	end

	if flag5 then
		return
	end

	if not flag4 then
		print("Relic rewards initialized")
		flag4 = true
		fn17() -- inferred equivalent call
	end

	local v16 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v16)

	if not (v2 or flag) then
		v2 = true

		if
			gRegion:IsMaster()
			and (__wf_atom_7e8ad928(gGameRules) or not (gGameRules:IsA(__wf_atom_dd9a0bb8) and gGameRules:GetVoidProjectionRewards()))
		then
			print("Not getting void projection rewards...closing reward choice!")
			fn()
		end
	end

	if v12 and not v2 then
		if flag then
			flag = false
		else
			print("Update selection countdown done")
			fn()
			return
		end
	end

	v14.x = (v16 / 2 + v14.x) % 1
	v14.y = (-v16 / 40 + v14.y) % 1
	v4:RunForAllElements(function(p)
		local mClipName = p.mClipName

		if mClipName ~= nil then
			module3.UpdateRarityBar(mMovie, mClipName .. "Info.RarityBar", v14)
		end
	end)

	if v6 and not __wf_atom_7e8ad928(v7) and v7:__wf_atom_86399a47() then
		v6 = false
		v8 = not flag2
		v4:RunForAllElements(function(state)
			if not __wf_atom_7e8ad928(state.mPlayerInfo.Reward) then
				module.GetStoreItemInfo(
					mMovie,
					Resource(state.mPlayerInfo.Reward),
					{ AppendInfo = state },
					nil,
					nil,
					true
				)
				state.ShowInfoPopupOwned = true
				state.QuantityMultiplier = state.mPlayerInfo.QuantityMultiplier
				state.Count = v13[state.FullName]
			end

			v4.mElementDrawCallback(state)
		end)

		if flag2 then
			if Engine.IsPlayingWithController() then
				v4:FocusElement(1)
			end

			v4:SelectElement(1)
		end

		local count = __wf_atom_7e8ad928(gGameRules) and 0
			or gGameRules:__wf_atom_913b2a23(gRegion:__wf_atom_eab484a7())

		if count > 0 and v10 then
			local texture = nil
			local name = ""
			local v17 = (count - 1) % 5 + 1

			if not __wf_atom_7e8ad928(infoPopup_Grid) then
				infoPopup_Grid:RunForAllElements(function(state)
					state.Active = v17 == state.Id

					if state.IsRelic then
						if not __wf_atom_7e8ad928(v5.BonusRelic) then
							local v18 = Resource(v5.BonusRelic)
							local iconTexture, themed = module.GetIconTexture(v18, true)
							texture = iconTexture
							state.Themed = themed
							name = mMovie:__wf_atom_8e9ac384(v18:__wf_atom_014a76a2():c_str(), true)
							state.Texture = texture
							state.Name = name
							module.GetItemTypeWithStoreInfo(mMovie, v18, v, { AppendInfo = state }, true)
						end
					else
						local v18 = count - module4.Ternary(v17 < state.Id, 5, 0)
						state.CurrPercent = module4.Ternary(
							v18 < 0,
							0,
							math.min(1, math.floor(v18 / 5) * 0.25 + 0.25) * 100
						)

						if state.Active then
							texture = state.Texture
							name = state.Name
						end

						module.GetStoreItemInfo(mMovie, state.Booster, { AppendInfo = state }, nil, nil, true)
					end

					infoPopup_Grid.mElementDrawCallback(state)
				end)
			end

			local v18 = count == 1
				and Localize("/Lotus/Language/Menu/VoidRewardSelect_EndlessBonusCountSingular", {})
				or Localize("/Lotus/Language/Menu/VoidRewardSelect_EndlessBonusCount", {
					COUNT = count
				})
			local v19 = "<p><font ><b>" .. TitleCase(Localize("/Lotus/Language/Menu/VoidRewardSelect_EndlessBonus", {})) .. "</b> " .. TitleCase(name .. " | " .. v18) .. "</font></p>"
			mMovie:__wf_atom_2dedec1a("EndlessBonus", 13, true)
			mMovie:__wf_atom_50d60589("EndlessBonus.Title", 36, v19)
			local v20 = mMovie:__wf_atom_5e6e15c8("EndlessBonus.Title", 40) / 2
			mMovie:__wf_atom_e57658c2("EndlessBonus.Dividers.Left", 0, -v20 - 110)
			mMovie:__wf_atom_e57658c2("EndlessBonus.Dividers.Right", 0, v20 + 110)
		end
	end
end

function RewardSelected(p)
	if flag2 and not (flag7 or v8 or __wf_atom_7e8ad928(v4)) then
		v4:SelectElementById(tonumber(p), true)
	end
end

function RewardFocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:FocusElementById((tonumber(p)))
	end
end

function RewardUnfocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:UnfocusElementById(tonumber(p), true)
	end
end

function BonusFocused(p)
	infoPopup_Grid:FocusElementById((tonumber(p)))
end

function BonusUnfocused(p)
	infoPopup_Grid:UnfocusElementById((tonumber(p)))
end

function RarityBarFocused(p)
	local mElement = v4.mElements[tonumber(p)]

	if not __wf_atom_7e8ad928(mElement) then
		_T.gToolTip = TitleCase(mMovie:__wf_atom_8e9ac384(v15[mElement.mPlayerInfo.Rarity + 1], false))
	end
end

function RarityBarUnfocused(_)
	_T.gToolTip = nil
end

function onKeyDown_MENU_SELECT()
	if flag2 and not (flag7 or v8 or __wf_atom_7e8ad928(v4)) then
		v4:SelectCurrentElement()
	end
end

function onKeyDown_MENU_CANCEL() end

function OnStyleChangedCallback()
	fn3()
end