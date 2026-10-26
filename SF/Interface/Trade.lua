local v = WeakResource()
local v2 = WeakResource()
local v3 = WeakResource()
local v4 = WeakResource()
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.CardUtilitiesRedux")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.SequencerUtilities")
local module7 = require("Lotus.Interface.UIStyleUtilities")
local module8 = require("SF.Interface.SFUtilities")
local module9 = require("SF.Interface.Libs.ItemUtil")
local module10 = require("SF.Interface.Libs.StatsUtil")
local module11 = require("SF.Interface.Libs.MoteUtil")
local v5 = nil
local v6 = true
local v7 = false
local appendInfo = nil
local v8 = nil
local v9 = nil
local v10 = 0
local v11 = 0
local v12 = nil
local v13 = nil
local v14 = {
	MOD = 1,
	SCHEMATIC = 2,
	PARTS = 3,
	KEYS = 4,
	PLATINUM = 5,
	CONSUMABLES = 6,
	WEAPON_SKINS = 7,
	WEAPONS = 10,
	ENHANCEMENTS = 11,
	FOCUS = 12,
	PROJECTIONS = 13,
	FUSION_TREASURES = 14,
	STEP_SEQUENCERS = 15,
	CAPTURA_SCENES = 16,
	EMOTE = 18,
	NONE = 19
}
local v15 = { CAN_GIVE = 1, ALREADY_GIVING = 2, BUDDY_GIVING = 3, WALLET_MISMATCH = 4 }
local v16 = nil
local v17 = nil
local mDisplayName = nil
local mAccountId = nil
local mPlayerLevel = 0
local v18 = nil
local mRegularCredits = 0
local v19 = { nil, nil, nil }
local v20 = false
local flag = false
local CAN_GIVE = v15.CAN_GIVE
local v21 = 0
local flag2 = false
local v22 = 0
local v23 = 0
local v24 = 0
local v25 = {}
local mRevision = 0
local mSelfReady = false
local flag3 = false
local v26 = 0
local v27 = nil
local v28 = nil
local v29 = nil
local v30 = {
	mItemType = nil,
	Card = nil,
	Trading = nil,
	TradeType = nil,
	Count = nil
}
local v31 = nil
local v32 = false
local v34 = nil
local v35 = 0.5
local v36 = -1
local fn
local forDisplay = false
local v38 = {}
local v39 = {}
local v40 = nil
local v41 = nil
local asyncLoader = module2.CreateAsyncLoader()
local v42 = ""
local v43 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")

local function fn2(grid)
	local mHeight = grid.mHeight or 600
	local v44 = mMovie:__wf_atom_5e6e15c8(grid.mClipName, 3) + mHeight / 2 - 100
	local v45 = { _G.UIMaterial_VerticalVisibilityRange, _G.UIMaterial_VerticalVisibilityRangeText }
	module.ScaleVisRangeMaterials(mMovie, v44, mHeight, grid.mHorizontal, v45, grid.mVisRangeFadeSize)
	module.ScaleSlicedMaterials(mMovie, v45)
end

local function fn3(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_e62f797d()
	end

	if gGameRules:__wf_atom_af3bd666() then
		gGameRules:OnClosedTradeScreen()

		if forDisplay and p then
			if not gGameRules:__wf_atom_af3bd666() then
				return
			end

			local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

			if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
				__wf_atom_7be88783:Execute("OnPickedDisplayItems", "true")
			end
		end
	end

	if v29 ~= nil then
		if not __wf_atom_7e8ad928(v29.StepSequencer) then
			v29.StepSequencer:Destroy()
		end

		v29 = nil
	end

	mMovie:Close()
end

local function fn4(mItemType)
	if __wf_atom_7e8ad928(mItemType) then
		return nil
	end

	local storeItems = gGameRules:__wf_atom_964056fd():GetStoreItems()

	for i = 1, #storeItems do
		if
			not __wf_atom_7e8ad928(storeItems[i])
			and storeItems[i]:__wf_atom_efa6f447() == 13
			and storeItems[i]:__wf_atom_c5566ef8() == mItemType
		then
			return storeItems[i]
		end
	end

	return nil
end

function TradingRulesConfirm(p)
	if not v34.mTradingRulesConfirmed then
		if tonumber(p) == 4 then
			v34.mTradingRulesConfirmed = true
			gGameData:__wf_atom_b1a739bd(v34)
		else
			fn3()
		end
	end
end

local function fn5(firstDelay)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "/SF/Language/Menu/TradingRulesDesc"
	dialogSettings.firstString = "/Lotus/Language/Menu/Global_Accept"
	dialogSettings.secondString = "/Lotus/Language/Menu/NavBar_Cancel"

	if firstDelay then
		dialogSettings.dialogType = 1
		dialogSettings.firstDelay = firstDelay
	end

	dialogSettings:SetCallback("TradingRulesConfirm")
	module.ShowCustomMessage(dialogSettings)
end

function ShowTradingRules(p)
	fn5(tonumber(p))
end

local function fn6()
	local v44 = {}
	local tips = module2.GetTips(mMovie, "/Lotus/Language/TradingHints/Trading_")

	if #tips > 0 then
		table.insert(v44, {
			Label = mMovie:__wf_atom_8e9ac384("<WARNING>", true),
			Tips = tips,
			Padding = -10
		})
	end

	table.insert(v44, {
		Label = "/SF/Language/Social/TradingRules",
		CallBack = function()
			mMovie:Execute("ShowTradingRules", "")
		end,
		CallOut = "MENU_GENERIC1"
	})
	table.insert(v44, {
		Label = "/Lotus/Language/Menu/Exit",
		CallBack = function()
			mMovie:Execute("onKeyDown_MENU_CANCEL", "")
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v44, getfenv(1))
	end
end

local function fn7(clipname, _)
	local rootBasedPosition, v44 = module3.GetRootBasedPosition(mMovie, clipname)
end

function IsInputBlocked()
	return v6
end

local function fn8()
	return v20 and not __wf_atom_7e8ad928(v17) and v17.mSelfReady and v17.mBuddyReady
end

local function fn9()
	v17 = nil

	if not __wf_atom_7e8ad928(gGameData) then
		v17 = gGameData:__wf_atom_f77aeb88(mAccountId)
	end

	if __wf_atom_7e8ad928(v17) or not v17:__wf_atom_8598f3a9() then
		v17 = SF.PendingTrade()
		v17.mClanTax = gGameRules:__wf_atom_4cde2729()
	else
		mRevision = v17.mRevision
		mSelfReady = v17.mSelfReady
	end
end

local function fn10(p)
	v8:RunForAllElements(function(p2)
		mMovie:__wf_atom_2dedec1a(p2.mClipName, 67, p)
	end)
end

local function fn11()
	if forDisplay then
		return
	end

	fn10(v17.mState ~= 3)
	local v44

	if v19[1] ~= nil then
		v44 = true
	elseif v19[2] ~= nil then
		v44 = true
	elseif v19[3] ~= nil then
		v44 = true
	elseif v19[4] ~= nil then
		v44 = true
	elseif v19[5] ~= nil then
		v44 = true
	elseif v19[6] ~= nil then
		v44 = true
	else
		v44 = false
	end

	v12:SetVisible(v44)
	mMovie:__wf_atom_2dedec1a("FillSlotPrompt", 13, not v44)

	if v44 then
		local ternary = module.Ternary(
			v17.mSelfReady,
			"/SF/Language/Social/Trade_Ready",
			"/SF/Language/Social/Trade_NotReady"
		)
		v12.mActiveColor = module.Ternary(v17.mSelfReady, module7.GetColor(11, true), nil)
		v12:SetText(ternary)
		v12:SetActive(v17.mState ~= 3)
		v12:Redraw()
	end

	local mBuddyReady = v17.mSelfReady and v17.mBuddyReady
	local v45 = mBuddyReady and v17.mState ~= 3
	local ternary = module.Ternary(v45, "/Lotus/Language/Dojo/AcceptTrade", "/Lotus/Language/Dojo/AcceptedAndWaiting")
	v13:SetVisible(mBuddyReady)

	if mBuddyReady then
		v12:SetVisible(false)
	end

	v13:SetActive(v45)
	v13:SetText(ternary)
	v13:Redraw()
	mMovie:__wf_atom_2dedec1a("Separator.Alert", 13, flag3)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Separator.LeftArrow", 14)
	local v46 = -0 - __wf_atom_5e6e15c8
	local v47 = 0 + __wf_atom_5e6e15c8
	mMovie:__wf_atom_e57658c2("Separator.LeftArrow", 0, v46)
	mMovie:__wf_atom_e57658c2("Separator.RightArrow", 0, v47)
	mMovie:__wf_atom_e57658c2("Separator.LeftLine", 0, v46 + 32)
	mMovie:__wf_atom_e57658c2("Separator.RightLine", 0, v47 - 32)
	local v48 = 500 - (v47 + 10)
	module2.DrawSeparator(mMovie, "Separator.LeftLine", v48)
	module2.DrawSeparator(mMovie, "Separator.RightLine", v48)
	local v49 = "/Lotus/Language/Dojo/Trade_BuddyNotReady"
	local v50 = "<IN_TRADE_ICON>"
	local ternary2 = module.Ternary(v17.mState == 4 or v17.mBuddyReady, _G.UIColor_Yellow, _G.UIColor_Beige)

	if v17.mState == 4 then
		v49 = "/Lotus/Language/Dojo/Trade_BuddyAccepted"
		v50 = "<FULL_CHECK>"
	elseif v17.mBuddyReady then
		v49 = "/SF/Language/Social/Trade_Ready"
		v50 = "<TRADE_REQUEST_SENT_ICON>"
	end

	mMovie:__wf_atom_7d7314f1("PartnerTradeStatus.text", v49)
	mMovie:__wf_atom_e57658c2("PartnerTradeStatus", 44, ternary2)
	mMovie:__wf_atom_48bd5a59("PartnerProfile.TraderTag", "Name", 36, mMovie:__wf_atom_8e9ac384(v50, true) .. v42)
end

local function fn12(data)
	v30.mItemType = data.mItemType
	v30.Trading = data.Trading
	v30.TradeType = data.TradeType
	v30.Count = data.Count
end

local function fn13(state)
	local v44 = true

	if state.TradeType == v14.PLATINUM then
		if v30.TradeType == state.TradeType then
			if v30.Count == state.Count then
				return false
			else
				state.PrevCount = v30.Count
			end
		end
	elseif v30.mItemType == state.mItemType and v30.TradeType == state.TradeType then
		return false
	end

	return v44
end

local function fn14(p, p2)
	if v31 == nil then
		v31 = {}
	end

	local elementInIndex = v9:GetElementInIndex(p)
	table.insert(v31, {
		CLIPNAME = elementInIndex.mClipName,
		EFFECT_TYPE = module.Ternary(p2, incomingTradeFX, disappearTradeFX)
	})
	module.PlaySound(incomingTradeSound)
end

local function fn15()
	if not v31 or v32 == true then
		return
	end

	if #v31 == 0 then
		v31 = nil
		return
	end

	fn7(v31[1].CLIPNAME, v31[1].EFFECT_TYPE)
	table.remove(v31, 1)
end

local function fn16(list, p)
	for i = 1, #list do
		if list[i] ~= p then
			continue
		end

		list[i] = "USED:" .. p
		return i
	end

	if p ~= "" then
		for i = 1, #list do
			if list[i] ~= "" then
				continue
			end

			list[i] = "USED:" .. p
			return i
		end
	end

	if #list < 6 then
		list[#list + 1] = "USED:" .. p
		return #list
	else
		return 0
	end
end

local function fn17(p, object, trading, tradeType, p2, count, category)
	local v44 = ""
	local mItemType

	if tradeType == v14.EMOTE then
		mItemType = trading.mItemType
	else
		mItemType = trading
		trading = nil
	end

	local mItemType2

	if tradeType == v14.WEAPONS or tradeType == v14.WEAPON_SKINS then
		mItemType2 = mItemType.mItemType
	else
		mItemType2 = mItemType
		mItemType = nil
	end

	local v45, mItemType3

	if tradeType == v14.FUSION_TREASURES then
		v45 = mItemType2:__wf_atom_4b2b635c()
		mItemType3 = mItemType2.mItemType
	else
		mItemType3 = mItemType2
		mItemType2 = nil
	end

	local mItemType4

	if tradeType == v14.ENHANCEMENTS then
		mItemType4 = mItemType3.mItemType
	else
		mItemType4 = mItemType3
		mItemType3 = nil
	end

	local v46

	if tradeType == v14.MOD then
		v46 = module4.CardFromArtifact(mItemType4, count)

		if v25[v46.mUpgrade.mItemId.mId] ~= nil then
			v46.mInstalled = v25[v46.mUpgrade.mItemId.mId]
		end

		v46.ForceCount = 1

		if not v46.mUpgrade.mItemId:__wf_atom_b70c3343() then
			v44 = ":" .. v46.mLevel
		end

		mItemType4 = v46.mUpgrade.mItemType
	end

	local storeItem = gGameRules:__wf_atom_964056fd():GetStoreItem(mItemType4)

	if __wf_atom_7e8ad928(storeItem) then
		return
	end

	if v45 == nil then
		v45 = mItemType4:__wf_atom_5b41f63b()
	end

	local v47 = fn16(p, v45 .. v44)

	if v47 == 0 then
		return
	end

	local elementInIndex = object:GetElementInIndex(v47)
	fn12(elementInIndex)
	elementInIndex.Trading = mItemType4

	if tradeType == v14.WEAPONS or tradeType == v14.WEAPON_SKINS then
		elementInIndex.Trading = mItemType
		elementInIndex.Category = category
	elseif tradeType == v14.FUSION_TREASURES then
		elementInIndex.Trading = mItemType2
		elementInIndex.Count = 1
	elseif tradeType == v14.ENHANCEMENTS then
		elementInIndex.Trading = mItemType3
		local arcaneRank, arcaneMaxRank = module4.GetArcaneRank(mItemType3)
		elementInIndex.ArcaneRank = arcaneRank
		elementInIndex.ArcaneMaxRank = arcaneMaxRank
	elseif tradeType == v14.MOD then
		elementInIndex.Card = v46
		elementInIndex.Trading = v46
	elseif tradeType == v14.EMOTE then
		elementInIndex.Trading = trading
		elementInIndex.Count = 1
	elseif tradeType == v14.PARTS then
		elementInIndex.Count = count
	end

	elementInIndex.Material = nil
	elementInIndex.Background = nil
	elementInIndex.RawItem = nil
	elementInIndex.Name = nil
	local storeItemInfo = module5.GetStoreItemInfo(
		mMovie,
		storeItem,
		{ GameData = gGameData, AppendInfo = elementInIndex, ItemInfo = elementInIndex.Trading },
		nil,
		nil,
		true
	)
	storeItemInfo.mItemType = mItemType4
	storeItemInfo.TradeType = tradeType
	object:UpdateElementInIndex(v47, storeItemInfo, false)

	if p2 then
		v19[v47] = storeItemInfo
		return v47
	end

	if object ~= v9 or not fn13(storeItemInfo) then
		return v47
	end

	fn14(v47, true)
	storeItemInfo.mShowChangedIcon = v30.mItemType ~= storeItemInfo.mItemType and flag3
	return v47
end

local function fn18(p, p2, mClanTax)
	local function fn19(p3, p4, p5, p6, p7)
		local v44 = p3 .. ".TaxInfo"
		local v45 = gGameRules:IsA(__wf_atom_1316e0c2) and "/Lotus/Language/Dojo/ClanTradeTaxCredits"
			or "/SF/Language/Social/HubTradeTaxCredits"
		mMovie:__wf_atom_7d7314f1(v44 .. ".TradeTaxAmnt.text", "<DRACS>" .. module.FormatNumber(p6 + p4))
		mMovie:__wf_atom_7d7314f1(v44 .. ".ClanTradeTaxLabel.text", v45, { TAX_RATE = p5 })
		mMovie:__wf_atom_7d7314f1(v44 .. ".ClanTradeTaxAmnt.text", "<DRACS>" .. module.FormatNumber(p4))
		mMovie:__wf_atom_7d7314f1(v44 .. ".Bank.text", "<DRACS>" .. module.FormatNumber(p7))
		local uiColor_BrightOrange = module7.GetColor(9, true)

		if p7 < p4 + p6 then
			uiColor_BrightOrange = _G.UIColor_BrightOrange
		end

		mMovie:__wf_atom_4c1c1986(v44, "TradeTaxAmnt", 44, uiColor_BrightOrange)
		mMovie:__wf_atom_4c1c1986(v44, "ClanTradeTaxAmnt", 44, uiColor_BrightOrange)
	end

	v23 = p
	local v44 = math.floor(v23 * mClanTax / 100)
	local v45 = __wf_atom_7e8ad928(gGameData) and 0 or gGameData:__wf_atom_7050e489()
	fn19("PlayerProfile", v44, mClanTax, v23, v45)
	v22 = p2
	v24 = math.floor(v22 * mClanTax / 100)
	fn19("PartnerProfile", v24, mClanTax, v22, mRegularCredits)
end

local function fn19(p, object, count)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if __wf_atom_7e8ad928(p[__wf_atom_5b41f63b]) then
		p[__wf_atom_5b41f63b] = { Type = object, Count = count }
	else
		p[__wf_atom_5b41f63b].Count = p[__wf_atom_5b41f63b].Count + count
	end
end

local function fn20(items)
	local result = {}

	for _, item in pairs(items) do
		table.insert(result, SF.CountedItem(item.Type, item.Count))
	end

	return result
end

local function fn21(items)
	local result = {}

	for _, item in pairs(items) do
		local consumableItem = SF.ConsumableItem()
		consumableItem.mItemType = item.Type
		consumableItem.mItemCount = item.Count
		table.insert(result, consumableItem)
	end

	return result
end

local function fn22(data)
	if not data then
		return ""
	end

	if data.TradeType == v14.MOD then
		local mUpgrade

		if data.TradeType == v14.MOD then
			mUpgrade = data.Card.mUpgrade
		else
			mUpgrade = data.Trading
		end

		if mUpgrade.mItemId:__wf_atom_b70c3343() then
			return mUpgrade.mItemType:__wf_atom_5b41f63b()
		end

		local v44

		if data.TradeType == v14.MOD then
			v44 = data.Card.mLevel
		else
			v44 = mUpgrade.mInstance:__wf_atom_c6a5f697(mUpgrade.mUpgradeFingerprint)
		end

		return mUpgrade.mItemType:__wf_atom_5b41f63b() .. ":" .. v44
	else
		if data.TradeType == v14.PLATINUM then
			return "P"
		end

		if data.TradeType == v14.FUSION_TREASURES then
			return data.Trading:__wf_atom_4b2b635c()
		end

		if not __wf_atom_7e8ad928(data.Trading) and data.Trading.mItemType then
			return data.Trading.mItemType:__wf_atom_5b41f63b()
		end

		if data.mItemType then
			return data.mItemType:__wf_atom_5b41f63b()
		end

		if data.TradeType == v14.STEP_SEQUENCERS then
			return data.Trading.mId
		end

		if __wf_atom_7e8ad928(data.Trading) then
			return
		else
			return data.Trading:__wf_atom_5b41f63b()
		end
	end
end

local function fn23()
	local tradeInfo = SF.TradeInfo()
	local mSlotOrderInfo = {}
	local v45 = {}
	local mUpgrades = {}
	local mUpgrades2 = {}
	local v47 = {}
	local v48 = {}
	local v49 = {}
	local v50 = {}
	local tradings = {}
	local tradings2 = {}
	local tradings3 = {}
	local tradings4 = {}
	local tradings5 = {}
	local tradings6 = {}
	local tradings7 = {}
	local tradings8 = {}
	local v51 = {}
	local tradings9 = {}
	local tradings10 = {}
	local count = 0

	for i = 1, 6 do
		local v52 = v19[i]
		mSlotOrderInfo[i] = fn22(v52)

		if v52 == nil then
			continue
		end

		if v52.TradeType == v14.MOD then
			local mUpgrade = v52.Card.mUpgrade

			if mUpgrade.mItemId:__wf_atom_b70c3343() then
				fn19(v45, v52.Card.mUpgrade.mItemType, 1)
			elseif module4.IsCardOmega(v52.Card) then
				table.insert(mUpgrades, mUpgrade)
			else
				table.insert(mUpgrades2, mUpgrade)
			end
		elseif v52.TradeType == v14.SCHEMATIC then
			fn19(v47, v52.Trading, 1)
		elseif
			v52.TradeType == v14.PARTS
			or v52.TradeType == v14.PROJECTIONS
			or v52.TradeType == v14.CAPTURA_SCENES
		then
			fn19(v48, v52.Trading, v52.Count or 1)
		elseif v52.TradeType == v14.KEYS then
			fn19(v49, v52.Trading, 1)
		elseif v52.TradeType == v14.CONSUMABLES then
			fn19(v50, v52.Trading, 1)
		elseif v52.TradeType == v14.PLATINUM then
			count = v52.Count
		elseif v52.TradeType == v14.WEAPON_SKINS then
			table.insert(tradings, v52.Trading)
		elseif v52.TradeType == v14.ENHANCEMENTS then
			if v52.Trading.mItemId:__wf_atom_b70c3343() then
				fn19(v45, v52.Trading.mItemType, 1)
			else
				table.insert(mUpgrades2, v52.Trading)
			end
		elseif v52.TradeType == v14.FOCUS then
			fn19(v48, v52.Trading, 1)
		elseif v52.TradeType == v14.WEAPONS then
			if v52.Category == 0 then
				table.insert(tradings2, v52.Trading)
			elseif v52.Category == 1 then
				table.insert(tradings3, v52.Trading)
			elseif v52.Category == 5 then
				table.insert(tradings4, v52.Trading)
			elseif v52.Category == 28 then
				table.insert(tradings5, v52.Trading)
			elseif v52.Category == 29 then
				table.insert(tradings6, v52.Trading)
			elseif v52.Category == 15 then
				table.insert(tradings7, v52.Trading)
			elseif v52.Category == 16 then
				table.insert(tradings8, v52.Trading)
			end
		elseif v52.TradeType == v14.FUSION_TREASURES then
			local __wf_atom_4b2b635c = v52.Trading:__wf_atom_4b2b635c()
			v51[__wf_atom_4b2b635c] = (v51[__wf_atom_4b2b635c] or 0) + 1
		elseif v52.TradeType == v14.STEP_SEQUENCERS then
			table.insert(tradings9, v52.Trading)
		elseif v52.TradeType == v14.EMOTE then
			table.insert(tradings10, v52.Trading)
		end
	end

	tradeInfo.mRandomUpgrades = mUpgrades
	tradeInfo.mUpgrades = mUpgrades2
	tradeInfo.mRawUpgrades = fn20(v45)
	tradeInfo.mRecipes = fn20(v47)
	tradeInfo.mMiscItems = fn20(v48)
	tradeInfo.mLevelKeys = fn20(v49)
	tradeInfo.mConsumables = fn21(v50)
	tradeInfo.mWeaponSkins = tradings
	tradeInfo.mPistols = tradings2
	tradeInfo.mLongGuns = tradings3
	tradeInfo.mMelee = tradings4
	tradeInfo.mSpaceGuns = tradings5
	tradeInfo.mSpaceMelee = tradings6
	tradeInfo.mSentinels = tradings7
	tradeInfo.mSentinelWeapons = tradings8
	local fusionTreasureInfos = {}

	for k, mItemCount in pairs(v51) do
		local fusionTreasureInfo = SF.FusionTreasureInfo(k)
		fusionTreasureInfo.mItemCount = mItemCount
		table.insert(fusionTreasureInfos, fusionTreasureInfo)
	end

	tradeInfo.mFusionTreasures = fusionTreasureInfos
	tradeInfo.mStepSequencers = tradings9
	tradeInfo.mPremiumCredits = count
	tradeInfo.mSlotOrderInfo = mSlotOrderInfo
	tradeInfo.mEmotes = tradings10
	tradeInfo:__wf_atom_54ef048c()
	return tradeInfo
end

local function fn24()
	local v44 = fn23()

	if __wf_atom_7e8ad928(v5) or v17:__wf_atom_8598f3a9() and v17.mState == 3 then
		print("___Can't trade in this state!")
		return
	end

	local v45 = v17:__wf_atom_8598f3a9() and 1 or 0
	v5:__wf_atom_4fa45f25(v44, v45)
	v27 = v44
	v13:SetActive(false)
end

local function fn25(object, data)
	local v44 = {
		SlotIndex = data.SlotIndex,
		mClipName = data.mClipName,
		Id = data.Id,
		mIndex = data.mIndex,
		mForceRedraw = data.mForceRedraw,
		mInitialized = data.mInitialized,
		mClipEnabled = data.mClipEnabled
	}
	object:UpdateElementInIndex(v44.mIndex, v44, true)
	return v44
end

local function fn26()
	if not forDisplay then
		local v44 = fn23()
		fn18(v17.mGetting.mCreditTax, v44.mCreditTax, v17.mClanTax)

		if v44 ~= module.Ternary(v27, v27, v17.mGiving) then
			fn24()
		end
	end
end

local function fn27(p)
	if appendInfo.TradeType == v14.NONE then
		v19[appendInfo.SlotIndex] = nil
	else
		v19[appendInfo.SlotIndex] = appendInfo
	end

	if CAN_GIVE ~= v15.BUDDY_GIVING and CAN_GIVE ~= v15.WALLET_MISMATCH then
		CAN_GIVE = v15.CAN_GIVE
		v21 = 0
	end

	local count = 0

	for i = 1, 6 do
		if not (v19[i] ~= nil and v19[i].Trading ~= nil and v19[i].TradeType ~= v14.NONE) then
			continue
		end

		count += 1

		if v19[i].TradeType ~= v14.PLATINUM then
			continue
		end

		CAN_GIVE = v15.ALREADY_GIVING
		v21 = i
	end

	if appendInfo.Count ~= nil and v30.Count ~= nil and appendInfo.TradeType == v30.TradeType then
		appendInfo.PrevCount = v30.Count
	end

	SetContextMenuVisible(false, true)
	v8.mElementDrawCallback(appendInfo)
	appendInfo = nil

	if not p then
		fn26()
	end
end

local function fn28(data, object, p)
	local v44 = {}
	local v45 = 1

	for i = 1, 6 do
		if i <= #data.mSlotOrderInfo then
			v44[i] = data.mSlotOrderInfo[i]
		else
			v44[i] = ""
		end

		if v44[i] == "" then
			v39[i] = nil
		end
	end

	local v46 = CAN_GIVE
	local v47 = v21
	local v48 = { data.mRandomUpgrades, data.mUpgrades }

	for i = 1, #v48 do
		for j = 1, #v48[i] do
			if v48[i][j].mItemType:IsA(v) or v48[i][j].mItemType:IsA(v2) then
				fn17(v44, object, v48[i][j], v14.ENHANCEMENTS, p)
			else
				fn17(v44, object, v48[i][j], v14.MOD, p, v45)
			end

			v45 += 1
		end
	end

	for i = 1, #data.mRawUpgrades do
		local upgradeInfo = SF.UpgradeInfo()
		local mItemCount = data.mRawUpgrades[i].mItemCount
		upgradeInfo.mItemType = data.mRawUpgrades[i].mItemType

		for _ = 1, mItemCount do
			if upgradeInfo.mItemType:IsA(v) or upgradeInfo.mItemType:IsA(v2) then
				fn17(v44, object, upgradeInfo, v14.ENHANCEMENTS, p)
			else
				fn17(v44, object, upgradeInfo, v14.MOD, p, v45)
			end

			v45 += 1
		end
	end

	for i = 1, #data.mMiscItems do
		local parts = v14.PARTS

		if data.mMiscItems[i].mItemType:IsA(__wf_atom_6317e6dc) then
			parts = v14.PROJECTION
		elseif data.mMiscItems[i].mItemType:IsA(__wf_atom_00d8ec3a) then
			parts = v14.CAPTURA_SCENES
		end

		fn17(v44, object, data.mMiscItems[i].mItemType, parts, p, data.mMiscItems[i].mItemCount)
	end

	for i = 1, #data.mRecipes do
		for _ = 1, data.mRecipes[i].mItemCount do
			fn17(v44, object, data.mRecipes[i].mItemType, v14.SCHEMATIC, p)
		end
	end

	for i = 1, #data.mLevelKeys do
		for _ = 1, data.mLevelKeys[i].mItemCount do
			fn17(v44, object, data.mLevelKeys[i].mItemType, v14.KEYS, p)
		end
	end

	for i = 1, #data.mConsumables do
		for _ = 1, data.mConsumables[i].mItemCount do
			fn17(v44, object, data.mConsumables[i].mItemType, v14.CONSUMABLES, p)
		end
	end

	for i = 1, #data.mWeaponSkins do
		fn17(v44, object, data.mWeaponSkins[i], v14.WEAPON_SKINS, p)
	end

	for i = 1, #data.mPistols do
		fn17(v44, object, data.mPistols[i], v14.WEAPONS, p, 1, 0)
	end

	for i = 1, #data.mLongGuns do
		fn17(v44, object, data.mLongGuns[i], v14.WEAPONS, p, 1, 1)
	end

	for i = 1, #data.mMelee do
		fn17(v44, object, data.mMelee[i], v14.WEAPONS, p, 1, 5)
	end

	for i = 1, #data.mSpaceGuns do
		fn17(v44, object, data.mSpaceGuns[i], v14.WEAPONS, p, 1, 28)
	end

	for i = 1, #data.mSpaceMelee do
		fn17(v44, object, data.mSpaceMelee[i], v14.WEAPONS, p, 1, 29)
	end

	for i = 1, #data.mSentinels do
		fn17(v44, object, data.mSentinels[i], v14.WEAPONS, p, 1, 15)
	end

	for i = 1, #data.mSentinelWeapons do
		fn17(v44, object, data.mSentinelWeapons[i], v14.WEAPONS, p, 1, 16)
	end

	for i = 1, #data.mFusionTreasures do
		for _ = 1, data.mFusionTreasures[i].mItemCount do
			fn17(v44, object, data.mFusionTreasures[i], v14.FUSION_TREASURES, p, 1, 34)
		end
	end

	for i = 1, #data.mStepSequencers do
		local v49 = fn16(v44, tostring(data.mStepSequencers[i].mId))
		local elementInIndex = object:GetElementInIndex(v49)
		fn12(elementInIndex)
		local mName = data.mStepSequencers[i].mStepSequencerInfo.mName

		if mName == nil or mName == "" then
			mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSong", false, {
				INDEX = data.mStepSequencers[i].mId
			})
		end

		elementInIndex.mItemType = nil
		elementInIndex.Name = mName
		elementInIndex.Icon = sequencerPreviewStoreItem:GetIconTexture()
		elementInIndex.Trading = data.mStepSequencers[i]
		elementInIndex.TradeType = v14.STEP_SEQUENCERS
		elementInIndex.Background = nil
		object:UpdateElementInIndex(v49, elementInIndex, true)

		if p then
			v19[v49] = elementInIndex
		elseif data == v17.mGetting and fn13(elementInIndex) then
			fn14(v49, true)
		end
	end

	for i = 1, #data.mEmotes do
		fn17(v44, object, data.mEmotes[i], v14.EMOTE, p)
	end

	if data.mPremiumCredits > 0 then
		local v49 = fn16(v44, "P")
		local elementInIndex = object:GetElementInIndex(v49)
		fn12(elementInIndex)
		local v50 = fn25(object, elementInIndex)
		v50.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeTypePlatinum", true)
		v50.Trading = v14.PLATINUM
		v50.Icon = _G.UITexture_PlatinumIcon
		v50.TradeType = v14.PLATINUM
		v50.Count = data.mPremiumCredits
		object:UpdateElementInIndex(v49, v50, true)

		if p then
			v19[v49] = v50
		elseif data == v17.mGetting and fn13(v50) then
			fn14(v49, true)
			v50.mShowChangedIcon = v30.Count ~= v50.Count and flag3
		end

		if p then
			CAN_GIVE = v15.ALREADY_GIVING
			v21 = v49
		else
			CAN_GIVE = v15.BUDDY_GIVING
		end
	elseif not p and CAN_GIVE == v15.BUDDY_GIVING then
		CAN_GIVE = v15.CAN_GIVE

		for i = 1, 6 do
			if not (v19[i] ~= nil and v19[i].Trading ~= nil and v19[i].TradeType ~= v14.NONE and v19[i].TradeType == v14.PLATINUM) then
				continue
			end

			CAN_GIVE = v15.ALREADY_GIVING
			v21 = i
		end
	end

	if not p and CAN_GIVE == v15.BUDDY_GIVING and v46 == v15.ALREADY_GIVING then
		local v49 = appendInfo
		appendInfo = v19[v47]
		appendInfo = fn25(object, appendInfo)
		appendInfo.TradeType = v14.NONE
		fn27()

		if v49 ~= nil and v49.TradeType ~= v14.PLATINUM then
			appendInfo = v49
		end
	end

	for i = 1, 6 do
		local elementInIndex = object:GetElementInIndex(i)
		fn12(elementInIndex)

		if not ((#v44 < i or v44[i] == "") and elementInIndex.Trading ~= nil) then
			continue
		end

		local v49 = fn25(object, elementInIndex)
		v49.TradeType = v14.NONE

		if p then
			v19[i] = nil
		elseif data == v17.mGetting and fn13(v49) then
			fn14(i, false)
		end
	end

	object:Redraw(nil, true, true)
end

local function fn29(p, _)
	mMovie:__wf_atom_2dedec1a("BpTracker", 13, p)
	local v44 = not p and 0 or mMovie:__wf_atom_5e6e15c8("BpTracker.ComponentList", 41) + 30
	mMovie:__wf_atom_e57658c2("PartnerTradeMenu", 1, v10 + v44)
	mMovie:__wf_atom_e57658c2("PartnerTradeStatus", 1, v11 + v44)
end

local function fn30()
	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	local count = 0
	local total = 0
	local v44 = {}

	for i = 1, v9:GetHowManyElements() do
		local mElement = v9.mElements[i]

		if mElement.TradeType ~= v14.SCHEMATIC then
			continue
		end

		count += 1
		local storeItem = __wf_atom_964056fd:GetStoreItem(mElement.Trading)

		if __wf_atom_7e8ad928(storeItem) then
			continue
		end

		local isA = storeItem:__wf_atom_c5566ef8():IsA(v3)
		total += module.Ternary(isA, 1, 0)

		if not __wf_atom_7e8ad928(v44.Recipe) and isA and v44.IsWarframeRecipe then
			break
		end

		if
			not (__wf_atom_7e8ad928(v44.Recipe) or isA and not v44.IsWarframeRecipe)
			or __wf_atom_7e8ad928(storeItem)
		then
			continue
		end

		v44.Recipe = storeItem:GetItem()
		v44.Name = mElement.Name
		v44.IsWarframeRecipe = isA
	end

	if count ~= 1 and total ~= 1 then
		fn29(false)
		return
	end

	v44.Recipe = Resource(v44.Recipe)
	local __wf_atom_524145ba = v44.Recipe:__wf_atom_524145ba()
	local v45 = {}

	for i = 1, #__wf_atom_524145ba do
		local storeItem

		if v44.IsWarframeRecipe then
			storeItem = fn4(__wf_atom_524145ba[i].mItemType)
		else
			storeItem = __wf_atom_964056fd:GetStoreItem(__wf_atom_524145ba[i].mItemType)
		end

		if __wf_atom_7e8ad928(storeItem) or not storeItem:__wf_atom_a7f0cb73() then
			continue
		end

		table.insert(v45, {
			Type = __wf_atom_524145ba[i].mItemType,
			LocTag = tostring(storeItem:__wf_atom_014a76a2()),
			RequiredCount = __wf_atom_524145ba[i].mItemCount,
			ProvidedCount = 0
		})
	end

	local count2 = 0
	v9:RunForAllElements(function(p)
		if p.TradeType == v14.PARTS or p.TradeType == v14.SCHEMATIC and v44.IsWarframeRecipe then
			local trading = p.Trading
			local storeItem = __wf_atom_964056fd:GetStoreItem(p.Trading)

			if p.TradeType == v14.SCHEMATIC and not __wf_atom_7e8ad928(storeItem) then
				trading = storeItem:__wf_atom_c5566ef8()
			end

			for i = 1, #v45 do
				if v45[i].Type ~= trading then
					continue
				end

				v45[i].ProvidedCount = v45[i].ProvidedCount + 1
				count2 += 1
				return
			end
		end
	end)

	if count2 == 0 then
		fn29(false)
		return
	end

	mMovie:__wf_atom_50d60589("BpTracker.Title", 36, v44.Name)
	local v46 = mMovie:__wf_atom_5e6e15c8("BpTracker.Title", 40) + 25
	mMovie:__wf_atom_e57658c2("BpTracker.ComponentList", 0, v46)
	mMovie:__wf_atom_e57658c2("BpTracker.ComponentList", 14, 1250 - (v46 + 60))
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("BpTracker.ComponentList", 14)
	local v47 = { "" }
	local v48 = 1

	for i = 1, #v45 do
		mMovie:__wf_atom_50d60589("BpTracker.ComponentList", 36, v47[v48])
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("BpTracker.ComponentList", 40)
		local v49 = ""

		if v45[i].RequiredCount > 1 then
			v49 ..= tostring(v45[i].RequiredCount) .. "x"
		end

		local ternary = module.Ternary(v45[i].ProvidedCount >= v45[i].RequiredCount, "<FULL_CHECK>", "<EMPTY_CHECK>")
		local v50 = v49 .. TitleCase(mMovie:__wf_atom_8e9ac384(v45[i].LocTag, false)) .. " " .. mMovie:__wf_atom_8e9ac384(ternary, true)

		if i ~= #v45 then
			v50 ..= "    "
		end

		mMovie:__wf_atom_50d60589("BpTracker.ComponentList", 36, v50)

		if __wf_atom_5e6e15c8 < __wf_atom_5e6e15c8_2 + mMovie:__wf_atom_5e6e15c8("BpTracker.ComponentList", 40) then
			v47[v48] ..= "\r\n"
			v48 += 1
			table.insert(v47, "")
		end

		v47[v48] ..= v50
	end

	local v49 = ""

	for i = 1, #v47 do
		v49 ..= v47[i]
	end

	mMovie:__wf_atom_50d60589("BpTracker.ComponentList", 36, v49)
	fn29(true, #v47)
end

local function fn31(p, p2)
	if p2 then
		fn28(v17.mGetting, v9, false)
		fn30()
	end

	if p then
		fn28(v17.mGiving, v8, true)
	end

	fn18(v17.mGetting.mCreditTax, v17.mGiving.mCreditTax, v17.mClanTax)
	fn6()
end

function GetCards()
	return nil
end

function GetSelectedCards()
	return {}
end

function GetSelectedElement()
	return nil
end

function IsFusionMode()
	return false
end

function Shutdown()
	_T.CheckModInstalled = nil
	_T.TradeItemsSelected = nil
	_T.InfoPopup_Data = nil
	_T.ChatInTrade = nil
	module3.RegisterHideHud(false)

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(-1)
	end

	module3.UnregisterProfileIcon(mMovie, "PlayerProfile.Icon")

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if not __wf_atom_7e8ad928(v16) then
		v16:Close()
	end

	if module8.IsInventoryOpen() then
		module8.CloseInventory()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if __wf_atom_7e8ad928(_T.IsScreenOpen) or not _T.IsScreenOpen("Profile") then
		if not __wf_atom_7e8ad928(_T.HideBackground) then
			_T.HideBackground()
		end
	else
		local movie = __wf_atom_8e4fda44:FindMovie(_T.GetScreenRes("Profile"))

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("SetBackgroundWasVisible", "false")
		end

		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle("", nil, true)
		end
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	if v41 ~= nil then
		v41()
	end
end

function ConfirmOffer(p)
	if tonumber(p) == 4 then
		fn24()
	end
end

local function fn32()
	v5:AcceptTrade(v26)
	v13:SetActive(false)
	fn10(false)
end

function ConfirmTrade(p)
	if tonumber(p) == 4 then
		fn32()
	end
end

function AcceptDisplayItems()
	local values = {}
	local flag4 = false

	for i = 1, 6 do
		if v19[i] == nil then
			continue
		end

		flag4 = true
		local v44 = v19[i]
		local v45 = {}

		if v44.TradeType == v14.STEP_SEQUENCERS then
			v45.name = v44.Name
			v45.storeItem = sequencerPreviewStoreItem:__wf_atom_5b41f63b()
		else
			if not __wf_atom_7e8ad928(v44.mItemType) then
				v45.itemType = v44.mItemType:__wf_atom_5b41f63b()

				if v44.mItemType:IsA(__wf_atom_77e05d3b) and not __wf_atom_7e8ad928(v44.RawItem) then
					if not __wf_atom_7e8ad928(v44.RawItem.mItemId) then
						v45.mItemId = tostring(v44.RawItem.mItemId)
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mAspectType) then
						v45.mAspectType = v44.RawItem.mAspectType:__wf_atom_5b41f63b()
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mAspectFingerprint) then
						v45.mAspectFingerprint = tostring(v44.RawItem.mAspectFingerprint)
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mUpgradeType) then
						v45.mUpgradeType = v44.RawItem.mUpgradeType:__wf_atom_5b41f63b()
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mUpgradeFingerprint) then
						v45.mUpgradeFingerprint = tostring(v44.RawItem.mUpgradeFingerprint)
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mQuality) then
						v45.mQuality = tostring(v44.RawItem.mQuality)
					end

					if not __wf_atom_7e8ad928(v44.RawItem.mShiny) then
						v45.mShiny = v44.RawItem.mShiny
					end
				end
			end

			if v44.TradeType == v14.MOD then
				v45.upgradeFingerprint = v44.Card.mUpgrade.mUpgradeFingerprint
			elseif v44.TradeType == v14.ENHANCEMENTS then
				v45.name = v44.Name
				v45.rank = v44.ArcaneRank
			end
		end

		table.insert(values, (cjson.encode(v45)))
	end

	if flag4 then
		v5:__wf_atom_6a4c77fd(values)
		module.PlaySound(acceptItemsSound)
	end

	fn3(true)
end

local function fn33(p, data)
	if data == nil or data.Trading == nil or data.TradeType == v14.NONE then
		return p
	end

	if data.TradeType == v14.MOD then
		local rarityLoc = module4.GetRarityLoc(data.Card.mRarity)
		mMovie:__wf_atom_8e9ac384(rarityLoc, false)
		local v44 = data.Card.mName .. " " .. module8.GetRankFlowerIcons(data.Card.mLevel)

		if data.Card.mDamaged then
			v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/DAMAGEDUpper", false) .. " " .. v44
		end

		p ..= "\n\r" .. v44
		return p
	else
		local name = data.Name

		if data.TradeType == v14.PLATINUM then
			name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/LargeBatchItem", false, {
				ITEM = name,
				NUM = data.Count
			})
		elseif data.TradeType == v14.ENHANCEMENTS then
			name = module2.GetArcaneRankString(name, data.ArcaneRank, data.ArcaneMaxRank, mMovie)
		end

		return p .. "\n\r" .. name
	end
end

local function fn34()
	v6 = true
	mMovie:__wf_atom_50d60589(
		"PartnerProfile.TaxInfo.Bank",
		36,
		mMovie:__wf_atom_8e9ac384("<DRACS> ", true) .. module.FormatNumber(mRegularCredits - (v22 + v24))
	)
	module.PlaySound(_G.UISound_SweetenerOne)
	module.PlaySound(tradeCompleteSound)
	v17 = nil
	flag = true
	module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeSuccess", false), "OpResultReviewed")
end

function AcceptTrade()
	if fn8() then
		if (__wf_atom_7e8ad928(gGameData) and 0 or gGameData:__wf_atom_7050e489()) < v17.mGetting.mCreditTax then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TooRichForYourBlood", false))
			return
		end

		local mCreditTax = v17.mGiving.mCreditTax

		if mRegularCredits < mCreditTax then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TooRichForHisBlood", false, v18))
			return
		end

		local giving = ""
		local getting = ""

		for i = 1, 6 do
			giving = fn33(giving, v19[i])
			getting = fn33(getting, v9:GetElementInIndex(i))
		end

		local v46 = { GIVING = giving, GETTING = getting, PLAYER_NAME = mDisplayName }
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeConfirm", false, v46)
		v26 = mRevision
		module.ShowConfirmMessage(__wf_atom_8e9ac384, "ConfirmTrade", 3)
	end
end

local function fn35()
	if __wf_atom_7e8ad928(v17) then
		return
	end

	local v44 = not v17.mSelfReady

	if v44 then
		v9:RunForAllElements(function(p)
			p.mShowChangedIcon = false
			v9.mElementDrawCallback(p)
		end)
	end

	v5:__wf_atom_5616d9ac(v44, mRevision)
end

function ToggleReady()
	fn35()
end

function Trade()
	if not fn8() then
		local mCreditTax = fn23().mCreditTax

		if mRegularCredits < mCreditTax then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TooRichForHisBlood", false, v18))
			return
		end

		local v49 = fn33(
			fn33(
				fn33(
					fn33(
						fn33(
							fn33(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeOfferConfirm", false), v19[1]),
							v19[2]
						),
						v19[3]
					),
					v19[4]
				),
				v19[5]
			),
			v19[6]
		)

		if v17:__wf_atom_8598f3a9() then
			local getting = ""

			for i = 1, 6 do
				getting = fn33(getting, v9:GetElementInIndex(i))
			end

			local v51 = { GETTING = getting, PLAYER_NAME = mDisplayName }
			v49 ..= "\n\r\n\r" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeOfferConfirmGetting", false, v51)
		end

		module.ShowConfirmMessage(v49, "ConfirmOffer")
	end
end

local function fn36(object)
	function _T.OnSongFocused(data)
		if v29 == nil then
			v29 = module6.CreateStepSequencerLoader()
		end

		local v44 = {}

		for i = 0, 3 - 1 do
			table.insert(v44, {
				NoteType = i,
				NotePack = data.Song.mStepSequencerInfo:__wf_atom_b07e7819(i)
			})
		end

		module6.ResLoadNotePacks(v29, v44, data.Song.mStepSequencerInfo.mFingerPrint)
		object:__wf_atom_48bd5a59(
			data.mClipName,
			"Label",
			36,
			data.mName .. "  " .. mMovie:__wf_atom_8e9ac384("<SPEAKER>", true)
		)
	end

	object:Execute("SetOnFocusedCallback", "OnSongFocused")

	function _T.OnSongUnfocused(p)
		if p.mClipName ~= nil then
			object:__wf_atom_48bd5a59(p.mClipName, "Label", 36, p.mName)
		end

		if v29 ~= nil then
			if __wf_atom_7e8ad928(v29.StepSequencer) then
				v29 = nil
			else
				v29.Loader = nil
				v29.IsLoading = false
				v29.StepSequencer:SetPaused(true)
			end
		end
	end

	object:Execute("SetOnUnfocusedCallback", "OnSongUnfocused")
end

local v44 = { songs = nil, extraSongs = nil, index = 0 }

function EnforceSequencerLimit()
	if v44.index > #v44.extraSongs then
		local v45 = false
		local mItemIds = {}

		for _, song in ipairs(v44.songs) do
			v45 = v45 or song.Replaced == true
			table.insert(mItemIds, song.Song.mStepSequencerInfo.mItemId)
		end

		if not __wf_atom_7e8ad928(gGameData) then
			gGameData:__wf_atom_94d9a488(mItemIds)
		end

		flag2 = true
		v32 = false
	else
		v32 = true
		local extraSong = v44.extraSongs[v44.index]
		local mName = extraSong.mName

		if mName == nil or mName == "" then
			mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSong", false, {
				INDEX = v44.index + #v44.songs
			})
		end

		v16 = mMovie:PushChildMovie(genericMenuMovie)
		v16:Execute(
			"SetTitle",
			v16:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSongOver", false, {
				NAME = mName
			})
		)

		function _T.SongSelectionDone(list)
			_T.SongSelectionDone = nil
			_T.GetSongList = nil
			_T.OnSongFocused = nil
			_T.OnSongUnfocused = nil

			if v29 ~= nil then
				if not __wf_atom_7e8ad928(v29.StepSequencer) then
					v29.StepSequencer:Destroy()
				end

				v29 = nil
			end

			if list[1] ~= nil then
				local mId = list[1].Song.mId
				v44.songs[mId].mName = mName
				v44.songs[mId].Song.mStepSequencerInfo = extraSong
				v44.songs[mId].Replaced = true
			end

			v44.index += 1
			mMovie:Execute("EnforceSequencerLimit", "")
		end

		v16:Execute("SetCallBack", "SongSelectionDone")

		function _T.GetSongList()
			return v44.songs
		end

		v16:Execute("SetElementsFunction", "GetSongList")
		fn36(v16)
	end
end

function OpenModSelection()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	function _T.CheckModInstalled(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.Card) then
			return
		end

		local mId = p.Card.mUpgrade.mItemId.mId

		if v25[mId] ~= nil then
			p.Card.mInstalled = v25[mId]
		end
	end

	function _T.TradeItemsSelected(list)
		v32 = false

		if not __wf_atom_7e8ad928(list) then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
			local v45 = 1

			for i = 1, 6 do
				local v46 = list[i]

				if v46.Plat or v46.IsOther then
					continue
				end

				local elementInIndex = v8:GetElementInIndex(v45)

				while
					elementInIndex.TradeType ~= nil
					and elementInIndex.TradeType ~= v14.MOD
					and elementInIndex.TradeType ~= v14.NONE
				do
					v45 += 1
					elementInIndex = v8:GetElementInIndex(v45)
				end

				appendInfo = elementInIndex

				if v46.Filler then
					fn(true)
				elseif appendInfo ~= nil then
					local v47 = 0

					for j = 1, i do
						if
							__wf_atom_7e8ad928(list[j].Card)
							or list[j].Card.mUpgrade.mItemType ~= v46.Card.mUpgrade.mItemType
						then
							continue
						end

						v47 += 1
					end

					if not v46.Card.mUpgrade.mItemId:__wf_atom_b70c3343() then
						v47 -= 1
					end

					local flag4 = true

					if forDisplay then
						if gGameData:GetInventory():__wf_atom_77f5f840(v46.Card.mUpgrade, v47) then
							flag4 = false
						else
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/ErrorCantTradeUniqueAbilityMods",
								true,
								{ MOD = v46.Card.mName }
							))
						end
					else
						local __wf_atom_d1a2145d = v46.StoreItem:__wf_atom_d1a2145d()

						if mPlayerLevel < __wf_atom_d1a2145d then
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/TRADE_OFFER_ERR_ITEM_XP_LOCKED",
								false,
								v18
							))
						elseif gGameData:GetInventory():__wf_atom_77f5f840(v46.Card.mUpgrade, v47) then
							flag4 = false
						else
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/ErrorCantTradeUniqueAbilityMods",
								true,
								{ MOD = v46.Card.mName }
							))
						end
					end

					if flag4 then
						fn(true)
					else
						appendInfo = fn25(v8, appendInfo)
						appendInfo = module5.GetStoreItemInfo(
							mMovie,
							v46.StoreItem,
							{ GetVisibilityMaterial = false, AppendInfo = appendInfo },
							__wf_atom_964056fd,
							nil,
							true
						)
						appendInfo.Count = 1
						appendInfo.mItemType = v46.Card.mUpgrade.mItemType
						appendInfo.Trading = v46.Card
						appendInfo.Card = v46.Card
						appendInfo.TradeType = v14.MOD
						appendInfo.Card.ForceCount = 1
						appendInfo.IsMod = v46.IsMod
						appendInfo.Polarity = v46.Polarity
						fn27(true)
					end
				end

				v45 += 1
			end

			fn26()
		end
	end

	local state = {}
	local others = {}
	local count = nil

	for i = 1, v8:GetHowManyElements() do
		local elementInIndex = v8:GetElementInIndex(i)

		if elementInIndex.TradeType == v14.PLATINUM then
			count = elementInIndex.Count
		elseif elementInIndex.TradeType == v14.MOD then
			local __wf_atom_5b41f63b = elementInIndex.mItemType:__wf_atom_5b41f63b()

			if state[__wf_atom_5b41f63b] == nil then
				state[__wf_atom_5b41f63b] = { Count = 0, Ids = {} }
			end

			if elementInIndex.Trading == nil or elementInIndex.Trading.mUpgrade.mItemId:__wf_atom_b70c3343() then
				state[__wf_atom_5b41f63b].Count = state[__wf_atom_5b41f63b].Count + 1
			else
				table.insert(state[__wf_atom_5b41f63b].Ids, elementInIndex.Trading.mUpgrade.mItemId.mId)
			end
		elseif elementInIndex.TradeType ~= nil and elementInIndex.TradeType ~= v14.NONE then
			table.insert(
				others,
				(module5.GetStoreItemInfo(
					mMovie,
					elementInIndex.StoreItem,
					{ GameData = gGameData, ItemInfo = elementInIndex.Trading },
					nil,
					nil,
					true
				))
			)
		end
	end

	_T.InvTradingInfo = {
		Items = false,
		ForDisplay = forDisplay,
		Slots = 6,
		State = state,
		Plat = count,
		Others = others,
		PartnerMR = mPlayerLevel
	}
	local screenRes = _T.GetScreenRes("Inventory")
	v16 = mMovie:PushChildMovie(screenRes)
	v32 = true
end

function InventoryClosed()
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.5)
end

local function fn37(p)
	p.OnClosed = InventoryClosed
	module8.OpenInventory(mMovie, p)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5)
end

function TradeItemSelected(p, p2)
	local tradingCount = tonumber(p)

	if tradingCount == 0 or p2 == nil or tonumber(p2) ~= 1 then
		return
	end

	local mIndex = appendInfo.mIndex
	v39[mIndex] = v40
	v40.TradingCount = tradingCount

	if v40.Type:IsA(__wf_atom_58a409f1) then
		local upgradeInfo = SF.UpgradeInfo()
		upgradeInfo.mItemId = v40.RawItem.mItemId
		upgradeInfo.mUpgradeFingerprint = v40.RawItem.mUpgradeFingerprint
		upgradeInfo.mItemType = v40.RawItem.mItemType
		v40.Card = module4.CardFromArtifact(upgradeInfo, 1)
		v40.IsMod = v40.Type:IsA(v43)
		local v46 = Resource(v40.RawItem.mItemType)

		if v46 then
			v40.Polarity = v46:__wf_atom_c05c3cf5(v40.RawItem.mUpgradeFingerprint)
		end

		_T.TradeItemsSelectedMod(v39)
	else
		_T.TradeItemsSelected(v39)
	end

	v40 = nil
end

local function fn38()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local function fn39(p)
		if p.Type:IsA(__wf_atom_3cecff09) then
			return v14.SCHEMATIC
		end

		if p.SortCategory == 17 then
			return v14.KEYS
		end

		if p.SortCategory == 2 then
			return v14.CONSUMABLES
		end

		if p.SortCategory == 6 then
			return v14.WEAPON_SKINS
		end

		if
			p.SortCategory == 0
			or p.SortCategory == 1
			or p.SortCategory == 5
			or p.SortCategory == 28
			or p.SortCategory == 29
			or p.SortCategory == 15
			or p.SortCategory == 16
		then
			return v14.WEAPONS
		end

		if p.Type:IsA(v) or p.Type:IsA(v2) then
			return v14.ENHANCEMENTS
		end

		if p.Type:IsA(__wf_atom_f6dea198) then
			return v14.FOCUS
		end

		if p.Type:IsA(__wf_atom_6317e6dc) then
			return v14.PROJECTIONS
		end

		if p.Type:IsA(__wf_atom_3aaccc49) and not p.Type:IsA(v4) then
			return v14.FUSION_TREASURES
		end

		if p.Type:IsA(__wf_atom_00d8ec3a) then
			return v14.CAPTURA_SCENES
		end

		if p.Type:IsA(__wf_atom_9ae7d6a1) then
			return v14.EMOTE
		end

		if p.Type:IsA(__wf_atom_58a409f1) then
			return v14.MOD
		end

		return v14.PARTS
	end

	function _T.CheckModInstalled(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.Card) then
			return
		end

		local mId = p.Card.mUpgrade.mItemId.mId

		if v25[mId] ~= nil then
			p.Card.mInstalled = v25[mId]
		end
	end

	function _T.TradeItemsSelectedMod(list)
		v32 = false

		if not __wf_atom_7e8ad928(list) then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

			for i = 1, 6 do
				if not (appendInfo == nil or appendInfo.mIndex == nil or appendInfo.mIndex == i) then
					continue
				end

				local v45 = list[i]

				if v45 == nil or (__wf_atom_7e8ad928(v45.Card) or v45.Plat or v45.IsOther) then
					continue
				end

				local elementInIndex = v8:GetElementInIndex(i)

				if elementInIndex == nil then
					continue
				end

				appendInfo = elementInIndex

				if v45.Filler then
					fn(true)
				elseif appendInfo ~= nil then
					local v46 = 0

					for j = 1, i do
						if
							__wf_atom_7e8ad928(list[j])
							or __wf_atom_7e8ad928(list[j].Card)
							or __wf_atom_7e8ad928(v45.Card)
						then
							continue
						end

						if list[j].Card.mUpgrade.mItemType ~= v45.Card.mUpgrade.mItemType then
							continue
						end

						v46 += 1
					end

					if not __wf_atom_7e8ad928(v45.Card) and v45.Card.mUpgrade.mItemId:__wf_atom_b70c3343() then
						v46 -= 1
					end

					local flag4 = true

					if forDisplay then
						if gGameData:GetInventory():__wf_atom_77f5f840(v45.Card.mUpgrade, v46) then
							flag4 = false
						else
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/ErrorCantTradeUniqueAbilityMods",
								true,
								{ MOD = v45.Card.mName }
							))
						end
					else
						local __wf_atom_d1a2145d = v45.StoreItem:__wf_atom_d1a2145d()

						if mPlayerLevel < __wf_atom_d1a2145d then
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/TRADE_OFFER_ERR_ITEM_XP_LOCKED",
								false,
								v18
							))
						elseif gGameData:GetInventory():__wf_atom_77f5f840(v45.Card.mUpgrade, v46) then
							flag4 = false
						else
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/ErrorCantTradeUniqueAbilityMods",
								true,
								{ MOD = v45.Card.mName }
							))
						end
					end

					if flag4 then
						fn(true)
					else
						appendInfo = fn25(v8, appendInfo)
						appendInfo = module5.GetStoreItemInfo(
							mMovie,
							v45.StoreItem,
							{ GetVisibilityMaterial = false, AppendInfo = appendInfo },
							__wf_atom_964056fd,
							nil,
							true
						)
						appendInfo.Count = v45.TradingCount or 1
						appendInfo.mItemType = v45.Card.mUpgrade.mItemType
						appendInfo.Trading = v45.Card
						appendInfo.Card = v45.Card
						appendInfo.TradeType = v14.MOD
						appendInfo.Card.ForceCount = 1
						appendInfo.IsMod = v45.IsMod
						appendInfo.Polarity = v45.Polarity
						fn27(true)
					end
				end
			end

			fn26()
		end
	end

	function _T.TradeItemsSelected(list)
		v32 = false

		if not __wf_atom_7e8ad928(list) then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

			for i = 1, 6 do
				if not (appendInfo == nil or appendInfo.mIndex == nil or appendInfo.mIndex == i) then
					continue
				end

				local v45 = list[i]

				if v45 == nil or v45.Plat or v45.Card ~= nil then
					continue
				end

				local elementInIndex = v8:GetElementInIndex(i)

				if elementInIndex == nil then
					continue
				end

				appendInfo = elementInIndex

				if v45.Filler then
					fn(true)
				elseif appendInfo ~= nil then
					local tradeType = fn39(v45)

					if not forDisplay then
						local __wf_atom_d1a2145d = v45.StoreItem:__wf_atom_d1a2145d()

						if mPlayerLevel < __wf_atom_d1a2145d then
							local ternary = module.Ternary(
								tradeType == v14.WEAPONS,
								"/Lotus/Language/Dojo/TRADE_OFFER_ERR_WEAPON_XP_LOCKED",
								"/Lotus/Language/Dojo/TRADE_OFFER_ERR_ITEM_XP_LOCKED"
							)
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(ternary, false, v18))
							return
						end
					end

					if tradeType == v14.WEAPONS then
						if not v45.RawItem:__wf_atom_3ae8d6f2() then
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/TRADE_ERR_WEAPON_NOT_UNRANKED",
								false
							))
							return
						end

						if v45.RawItem:__wf_atom_ae27679c() then
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/TRADE_ERR_WEAPON_WILL_EXPIRE",
								false
							))
							return
						end
					end

					if tradeType == v14.WEAPON_SKINS and v45.RawItem:__wf_atom_ae27679c() then
						module.ShowMessage(mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Dojo/TRADE_ERR_WEAPON_SKIN_WILL_EXPIRE",
							false
						))
						return
					end

					appendInfo = fn25(v8, appendInfo)
					appendInfo = module5.GetStoreItemInfo(
						mMovie,
						v45.StoreItem,
						{
							GetVisibilityMaterial = false,
							AppendInfo = appendInfo,
							ItemInfo = v45.RawItem
						},
						__wf_atom_964056fd,
						nil,
						true
					)
					appendInfo.Count = v45.TradingCount or 1
					appendInfo.mItemType = v45.Type
					appendInfo.Trading = v45.Type
					appendInfo.TradeType = tradeType
					appendInfo.ArcaneRank = v45.ArcaneRank
					appendInfo.ArcaneMaxRank = v45.ArcaneMaxRank

					if appendInfo.TradeType == v14.FUSION_TREASURES then
						appendInfo.Trading = v45.RawItem
					elseif appendInfo.TradeType == v14.EMOTE then
						appendInfo.Trading = v45.RawItem
					elseif appendInfo.TradeType == v14.WEAPONS or appendInfo.TradeType == v14.WEAPON_SKINS then
						appendInfo.Trading = v45.RawItem
						appendInfo.Category = v45.StoreItem:__wf_atom_efa6f447()
					elseif appendInfo.TradeType == v14.ENHANCEMENTS then
						appendInfo.Name = v45.Name
						appendInfo.Trading = v45.RawItem
					end

					fn27(true)
				end
			end

			fn26()
		end
	end

	local cards = {}
	local state = {}
	local count = nil

	for i = 1, v8:GetHowManyElements() do
		local elementInIndex = v8:GetElementInIndex(i)

		if elementInIndex.TradeType == v14.PLATINUM then
			count = elementInIndex.Count
		elseif elementInIndex.TradeType == v14.MOD then
			table.insert(cards, elementInIndex.Card)
		elseif elementInIndex.TradeType ~= nil and elementInIndex.TradeType ~= v14.NONE then
			local __wf_atom_5b41f63b = elementInIndex.Type:__wf_atom_5b41f63b()

			if elementInIndex.TradeType == v14.FUSION_TREASURES then
				__wf_atom_5b41f63b = elementInIndex.RawItem:__wf_atom_4b2b635c()
			end

			if state[__wf_atom_5b41f63b] == nil then
				state[__wf_atom_5b41f63b] = { Count = 0, Ids = {} }
			end

			if
				elementInIndex.Trading == nil
				or elementInIndex.Trading.mItemId == nil
				or elementInIndex.Trading.mItemId:__wf_atom_b70c3343()
			then
				state[__wf_atom_5b41f63b].Count = state[__wf_atom_5b41f63b].Count + 1
			else
				table.insert(state[__wf_atom_5b41f63b].Ids, elementInIndex.Trading.mItemId.mId)
			end
		end
	end

	_T.InvTradingInfo = {
		Items = true,
		ForDisplay = forDisplay,
		Slots = 6,
		State = state,
		Plat = count,
		Mods = cards,
		PartnerMR = mPlayerLevel
	}
	local __wf_atom_259e7653 = module8.GetInventoryControl():__wf_atom_259e7653(true)
	local __wf_atom_c132f79b = __wf_atom_259e7653:__wf_atom_c132f79b(0, __wf_atom_259e7653:__wf_atom_d25917b6(0))
	local mItemIds = {}

	for i = 0, 6 - 1 do
		table.insert(mItemIds, __wf_atom_c132f79b:__wf_atom_b369d77f(i).mItemId)
	end

	local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
	local __wf_atom_eb82ab1f = __wf_atom_259e7653:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
	local __wf_atom_035fdfa8s = {}

	for i = 0, 8 - 1 do
		local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(i)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			table.insert(__wf_atom_035fdfa8s, __wf_atom_035fdfa8)
		end
	end

	local v46 = MongoId()
	fn37({
		BackgroundAlpha = 0.7,
		ShouldShowInfoTip = false,
		Categories = module8.INVENTORY_CATEGORIES,
		ShowAllItemsCategory = true,
		ShowPauseMenu = false,
		ShowCurrency = true,
		FunctionFilter = function(object)
			local storeItem = gGameRules:__wf_atom_964056fd():GetStoreItem(object.mItemType)

			if
				__wf_atom_7e8ad928(storeItem)
				or not storeItem:__wf_atom_a7f0cb73()
				or object.mItemType:IsA(__wf_atom_9df43583) and not object:__wf_atom_3ae8d6f2()
			then
				return false
			end

			for _, v48 in v39 do
				if
					v48.RawItem.mItemId ~= nil
					and v48.RawItem.mItemId ~= v46
					and v48.RawItem.mItemId == object.mItemId
				then
					return false
				end
			end

			if object.mItemId ~= nil then
				for _, v48 in ipairs(mItemIds) do
					if object.mItemId == v48 then
						return false
					end
				end
			end

			if object.mItemType:IsA(__wf_atom_abf506db) then
				for _, v48 in ipairs(__wf_atom_035fdfa8s) do
					if v48 == object.mItemType then
						return false
					end
				end
			end

			return true
		end,
		IsSelectionBlocked = function(_)
			return false
		end,
		OnItemSelected = function(p)
			v40 = p

			if v40.Count == 1 or not v40.Type:IsA(__wf_atom_d5a2d4b7) then
				TradeItemSelected(1, 1)
			else
				_T.InfoPopup_Data = {
					Name = Localize("/Lotus/Language/Dojo/Trade_FillSlotPrompt", {}),
					Description = Localize(p.Name, {}),
					Count = p.Count,
					DefaultValue = module.Ternary(appendInfo.Count ~= nil, appendInfo.Count, 1),
					Callback = "TradeItemSelected"
				}
				v16 = mMovie:PushChildMovie(_G.UIMovie_InputCountMovie)
			end

			return true
		end
	})
	v32 = true
end

function OpenItemSelection()
	fn38()
end

function ConfirmOfferAllPlatinum(p)
	local pendingCount = appendInfo.PendingCount
	appendInfo.PendingCount = nil

	if tonumber(p) == 4 then
		fn12(appendInfo)
		appendInfo = fn25(v8, appendInfo)
		appendInfo.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeTypePlatinum", true)
		appendInfo.Trading = v14.PLATINUM
		appendInfo.Icon = _G.UITexture_PlatinumIcon
		appendInfo.TradeType = v14.PLATINUM
		appendInfo.Count = pendingCount
		fn27()
	end
end

function PlatinumSelected(count, p)
	if appendInfo ~= nil and CAN_GIVE ~= v15.BUDDY_GIVING and p ~= nil and tonumber(p) == 1 and tonumber(count) > 0 then
		local v45 = __wf_atom_7e8ad928(gGameData) and 0 or gGameData:__wf_atom_f9580127()

		if tonumber(count) == v45 then
			appendInfo.PendingCount = tonumber(count)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Dojo/TradeConfirmOfferAllPlatinum",
				true,
				{ COUNT = count }
			)
			module.ShowConfirmMessage(__wf_atom_8e9ac384, "ConfirmOfferAllPlatinum")
		else
			fn12(appendInfo)
			appendInfo = fn25(v8, appendInfo)
			appendInfo.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeTypePlatinum", true)
			appendInfo.Trading = v14.PLATINUM
			appendInfo.Icon = _G.UITexture_PlatinumIcon
			appendInfo.TradeType = v14.PLATINUM
			appendInfo.Count = tonumber(count)
			fn27()
		end
	end
end

local function fn39()
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(appendInfo) then
		return
	end

	local __wf_atom_f9580127 = gGameData:__wf_atom_f9580127()
	local _t = _T
	local infoPopup_Data = {
		Name = Localize("/Lotus/Language/Dojo/TradePlatinum", {}),
		Description = Localize("/Lotus/Language/Menu/TradeFreePlatinumHint", {}),
		Count = __wf_atom_f9580127,
		TagType = module2.LABEL_TYPE_PLATINUM,
		DefaultValue = 0,
		Callback = 0
	}
	local ternary = module.Ternary
	local v46

	if appendInfo.Count == nil then
		v46 = false
	else
		v46 = appendInfo.TradeType == v14.PLATINUM
	end

	infoPopup_Data.DefaultValue = ternary(v46, appendInfo.Count, 0)
	infoPopup_Data.Callback = "PlatinumSelected"
	_t.InfoPopup_Data = infoPopup_Data
	v16 = mMovie:PushChildMovie(_G.UIMovie_InputCountMovie)
end

function OpenPlatinumSelection()
	if CAN_GIVE == v15.CAN_GIVE or CAN_GIVE == v15.ALREADY_GIVING and v21 == appendInfo.SlotIndex then
		fn39()
	elseif CAN_GIVE == v15.ALREADY_GIVING then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/PlatOneSlotOnly", false))
	elseif CAN_GIVE == v15.BUDDY_GIVING then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/PlatOneSideOnly", false, v18))
	elseif CAN_GIVE == v15.WALLET_MISMATCH then
		if Engine.__wf_atom_63bb2bc6() == 3 then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/PlatWalletMismatchSwitchMe", false, v18))
		else
			module.ShowMessage(mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Dojo/PlatWalletMismatchSwitchBuddy",
				false,
				v18
			))
		end
	end
end

fn = function(p)
	if appendInfo == nil then
		return
	end

	v39[appendInfo.mIndex] = nil
	appendInfo = fn25(v8, appendInfo)
	appendInfo.TradeType = v14.NONE
	fn27(p)
end

function ClearTradeSlot()
	fn()
end

local function fn40(_)
	module.PlaySound(_G.UISound_Select)
	OpenItemSelection()
end

local function fn41(p, mUseCornerForSelected)
	local module12 = require("EE.Interface.Components.Grid")
	local ternary = module.Ternary(forDisplay, 1, 2)
	local v45 = 6 / ternary
	local grid = module12.CreateGrid(mMovie, p, nil, v45, ternary)
	grid.mShowLabels = true
	grid.mInnerAlphaOffset = 25
	grid.mUseCornerForSelected = mUseCornerForSelected
	grid.mPadding = 8
	grid.mColumnSeparation = 146
	grid.mRowSeparation = 146
	grid.PurchasedItems = module5.GetPurchasedItems(gGameRules:__wf_atom_964056fd(), gGameData:GetInventory())
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	grid.mInitIconYPos = mMovie:__wf_atom_5e6e15c8(p .. ".Icon", 1)

	if mUseCornerForSelected then
		grid:SetCallbacks("MenuItemPressed", "MenuItemFocused", "MenuItemUnfocused")

		function grid.mOnSelectedCallback(p2)
			module.PlaySound(_G.UISound_Select)
			local id

			if appendInfo ~= nil then
				id = appendInfo.Id
			end

			appendInfo = p2
			fn40(p2)

			if id ~= nil then
				grid.mElementDrawCallback(grid:GetElementById(id))
			end

			_T.InfoPopup_Data = nil
			grid.mElementDrawCallback(p2)
			mMovie:__wf_atom_e57658c2("ItemTypeMenu", 0, mMovie:__wf_atom_5e6e15c8(p2.mClipName, 0))
			mMovie:__wf_atom_e57658c2("ItemTypeMenu", 1, mMovie:__wf_atom_5e6e15c8(p2.mClipName, 1))
		end
	else
		grid:SetCallbacks("PartnerMenuItemPressed", "PartnerMenuItemFocused", "PartnerMenuItemUnfocused")

		function grid.PreviewCallback(object)
			if __wf_atom_7e8ad928((object:GetFocusedElement())) or __wf_atom_7e8ad928(mMovie) then
			end
		end

		function grid.mOnSelectedCallback(_) end
	end

	function grid.mClipCreatedCallback(p2, p3)
		module9.Initialize(mMovie, p2, p3, grid)
	end

	function grid.RefreshPlatTag(data)
		if data.TradeType == v14.PLATINUM and data.PrevCount ~= nil then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				module.Ternary(data.Count > data.PrevCount, "<UPARROW>", "<DOWNARROW>"),
				true
			)
			local color = module7.GetColor(module.Ternary(data.Count > data.PrevCount, 11, 12), true)
			local v46 = "<p><font color=\"" .. module.ConvertColorNumberToHex(color) .. "\">" .. __wf_atom_8e9ac384 .. "</font></p>"
			local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(data.mClipName .. ".TagContainer.Tag1.Label", 36)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "TagContainer.Tag1.Label", 89, true)
			mMovie:__wf_atom_48bd5a59(data.mClipName, "TagContainer.Tag1.Label", 36, __wf_atom_387f260e .. v46)
		end
	end

	function grid.IsSelected(p2)
		if not mUseCornerForSelected then
			return false
		end

		local mIsVisible = v28.mIsVisible

		if mIsVisible then
			if appendInfo == nil then
				mIsVisible = false
			else
				mIsVisible = appendInfo.Id == p2.Id
			end
		end

		return mIsVisible
	end

	function grid:mOnFocusedCallback()
		if self.mClipName == nil then
			return
		end

		grid.IsSelected(self)
		self.Focused = true
		module9.UpdateFocus(mMovie, self.mClipName, self, grid)

		if v41 ~= nil then
			v41()
		end

		if
			__wf_atom_7e8ad928(self.Type)
			or not (self.Type:IsA(__wf_atom_9df43583) or self.Type:IsA(__wf_atom_abf506db))
		then
			if not __wf_atom_7e8ad928(self.Type) then
				asyncLoader:LoadResource("Tooltip", self.Type, function(p2)
					Resource(p2)
					self.StatOwner = __wf_atom_c4f78a8f

					if
						self.RawItem ~= nil
						and (__wf_atom_7e8ad928(self.RawItem.mItemId) or __wf_atom_7e8ad928(self.RawItem.mUpgradeFingerprint) or __wf_atom_7e8ad928(self.RawItem.mItemType))
					then
						self.RawItem = nil
					end

					if self.Card ~= nil and not __wf_atom_7e8ad928(self.Card.mUpgrade) then
						self.RawItem = {}
						self.RawItem.mItemId = self.Card.mUpgrade.mItemId
						self.RawItem.mUpgradeFingerprint = self.Card.mUpgrade.mUpgradeFingerprint
						self.RawItem.mItemType = self.Card.mUpgrade.mItemType
					end

					module2.SetItemInfoPopupRect(
						mMovie,
						self,
						mMovie:__wf_atom_5e6e15c8(self.mClipName, 2),
						mMovie:__wf_atom_5e6e15c8(self.mClipName, 3),
						128,
						128
					)
					_T.InfoPopup_Data = self
				end)
			end
		else
			local weaponElementUpgradesAndFingerprints, v46 = module10.GetWeaponElementUpgradesAndFingerprints(self)
			asyncLoader:LoadResource("Tooltip", self.Type, function()
				local v47 = __wf_atom_7e8ad928(self.RawItem) and 0 or self.RawItem.mQuality
				local v48

				if not __wf_atom_7e8ad928(self.RawItem) then
					v48 = self.RawItem.mCreator
				end

				local proxyWeapon, v49 = module10.CreateProxyWeapon(
					__wf_atom_c4f78a8f,
					self.Type,
					self.Xp,
					weaponElementUpgradesAndFingerprints,
					v46,
					v47,
					self.RawItem.mItemId,
					self.mShiny,
					v48
				)
				v41 = v49
				self.StatWeapon = proxyWeapon
				self.StatOwner = __wf_atom_c4f78a8f
				module2.SetItemInfoPopupRect(
					mMovie,
					self,
					mMovie:__wf_atom_5e6e15c8(self.mClipName, 2),
					mMovie:__wf_atom_5e6e15c8(self.mClipName, 3),
					128,
					128
				)
				_T.InfoPopup_Data = self
			end)
		end

		grid.RefreshPlatTag(self)
	end

	function grid:mOnUnfocusedCallback()
		if self.mClipName == nil then
			return
		end

		if v41 ~= nil then
			v41()
		end

		self.Focused = self.Selected
		module9.UpdateFocus(mMovie, self.mClipName, self, grid)
		_T.InfoPopup_Data = nil
		grid.RefreshPlatTag(self)
	end

	function grid:mElementDrawCallback()
		if self.mClipName == nil then
			return
		end

		if self.TradeType == v14.NONE then
			self.Name = nil
			self.Icon = nil
			self.Material = nil
			self.Background = nil
			self.Count = nil
		end

		local iconHeight, iconWidth

		if self.TradeType == v14.PLATINUM then
			iconHeight = 80
			iconWidth = 80
		else
			iconHeight = 192
			iconWidth = 192
		end

		self.IconHeight = iconHeight
		self.IconWidth = iconWidth
		local focusedElement = grid:GetFocusedElement()
		local v49 = {
			HidePrice = true,
			IsFocused = focusedElement ~= nil and focusedElement.Id == self.Id,
			IsSelected = grid.IsSelected(self),
			IgnoreCount = true
		}
		v49.OwnedInfo = {
			TagOverride = "/Lotus/Language/Menu/Crafting_Owned_Brief",
			mShowOne = true
		}

		if self.TradeType == v14.PLATINUM then
			v49.HideCountThreshold = 0
		end

		local infoForLabels = {}

		if self.mShowChangedIcon then
			local infoForLabel = module2.GetInfoForLabel(module2.LABEL_TYPE_RESEARCHED, "")
			infoForLabel.Icon = alertIcon
			infoForLabel.ClipOffset = 150
			infoForLabel.IconPos.Y = 3
			infoForLabel.LabelColor = 12
			infoForLabel.HideInPopup = true
			table.insert(infoForLabels, infoForLabel)
		end

		v49.CustomTags = infoForLabels

		if __wf_atom_7e8ad928(self.Type) then
			self.ShowCount = false
		else
			self.ShowCount = true
		end

		module9.Update(mMovie, self.mClipName, self, grid)

		if self.Card ~= nil then
			local ternary2 = module.Ternary(self.IsMod, _G.UIMaterial_AnimalMoteMaterial, _G.UIMaterial_RuneMaterial)
			mMovie:OverrideMaterial(self.mClipName .. ".Icon", ternary2)

			if self.IsMod and self.Polarity then
				mMovie:__wf_atom_e57658c2(self.mClipName .. ".Icon", 11, module11.CalcTotemColor(self.Polarity))
			end
		end

		grid.RefreshPlatTag(self)
	end

	function grid.SetupPreInterpolationValues(object, p2)
		local y = object:CalculateY(p2)
		object.mMovie:__wf_atom_e57658c2(p2.mClipName, 1, y + 40)
	end

	function grid.GetInterpolationProperties(object, p2)
		return { 12, 1 }, { 100, (object:CalculateY(p2)) }
	end

	for i = 1, 6 do
		grid:AddElement({ Trading = nil, SlotIndex = i }, true)
	end

	grid:Redraw(function()
		if mUseCornerForSelected then
			v6 = false
		end
	end, true, true)
	fn2(grid)
	return grid
end

local function fn42()
	v6 = true
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0, fn3)
end

local function fn43(p, p2, trades, p3)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module7.GetColor(1, true))
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module7.GetColor(2, true))
	local v45 = p .. ".TraderTag"
	mMovie:OverrideMaterial(v45 .. ".Bg", nameBackerMaterial)
	mMovie:__wf_atom_4c1c1986(v45, "Bg", 11, 854536)

	if forDisplay then
		mMovie:__wf_atom_4c1c1986(v45, "Bg", 12, 0)
	else
		mMovie:__wf_atom_4c1c1986(v45, "Bg", 12, 60)
	end

	mMovie:OverrideMaterial(v45 .. ".IconBacker", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		v45 .. ".IconBacker",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.15
	)
	mMovie:__wf_atom_1ca72041(
		v45 .. ".IconBacker",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.25
	)
	mMovie:__wf_atom_4c1c1986(v45, "IconBacker", 12, 0)
	mMovie:__wf_atom_4c1c1986(v45, "Icon", 12, 0)
	mMovie:__wf_atom_4c1c1986(v45, "Underline", 12, 0)
	local color = module7.GetColor(6, true)
	local color2 = module7.GetColor(10, true)
	mMovie:__wf_atom_4c1c1986(v45, "TradesLeft", 12, 40)
	mMovie:__wf_atom_4c1c1986(v45, "TradesLeft", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986(v45, "Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(v45, "Underline", 11, color2)

	if p3 then
		v42 = p2
	end

	mMovie:__wf_atom_48bd5a59(v45, "Name", 36, p2)

	if trades == 0 then
		mMovie:__wf_atom_7d7314f1(v45 .. ".TradesLeft.text", "")
	else
		mMovie:__wf_atom_7d7314f1(v45 .. ".TradesLeft.text", "/Lotus/Language/Dojo/RemainingTrades", {
			TRADES = trades
		})
	end

	local v46 = p .. ".TaxInfo"
	mMovie:__wf_atom_933bbce0(v46 .. ".Bg", taxBackerTexture, taxBackerMaterial)
	local color3 = module7.GetColor(9, true)
	mMovie:__wf_atom_4c1c1986(v46, "Icon", 11, color3)
	mMovie:__wf_atom_4c1c1986(v46, "Icon", 12, 0)
	mMovie:__wf_atom_c90af43a(v46 .. ".Icon", tradeTaxIcon)
	mMovie:__wf_atom_7d7314f1(v46 .. ".TradeTaxLabel.text", "/SF/Language/Social/TradeTax")
	mMovie:__wf_atom_7d7314f1(v46 .. ".BankLabel.text", "/SF/Language/Social/CreditsAmount")
	mMovie:__wf_atom_4c1c1986(v46, "TradeTaxLabel", 44, color)
	mMovie:__wf_atom_4c1c1986(v46, "BankLabel", 44, color)
	mMovie:__wf_atom_4c1c1986(v46, "ClanTradeTaxLabel", 44, color)
	mMovie:__wf_atom_4c1c1986(v46, "TradeTaxLabel", 12, 40)
	mMovie:__wf_atom_4c1c1986(v46, "BankLabel", 12, 40)
	mMovie:__wf_atom_4c1c1986(v46, "ClanTradeTaxLabel", 12, 0)
	mMovie:__wf_atom_4c1c1986(v46, "ClanTradeTaxAmnt", 12, 0)
	mMovie:__wf_atom_4c1c1986(v46, "Bg", 12, 0)
	mMovie:__wf_atom_4c1c1986(v46, "Bank", 44, color3)
	mMovie:__wf_atom_4c1c1986(v46, "Separator1", 11, color3)
	mMovie:__wf_atom_4c1c1986(v46, "Separator2", 11, color3)
	mMovie:__wf_atom_4c1c1986(v46, "Separator1", 12, 0)
	mMovie:__wf_atom_4c1c1986(v46, "Separator2", 12, 50)

	if p3 then
		mMovie:OverrideMaterial("BpTracker.Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			"BpTracker.Bg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.15
		)
		mMovie:__wf_atom_1ca72041(
			"BpTracker.Bg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.25
		)
		mMovie:__wf_atom_e57658c2("BpTracker.Title", 44, color)
		mMovie:__wf_atom_e57658c2("BpTracker.Title", 12, 70)
		mMovie:__wf_atom_e57658c2("BpTracker.ComponentList", 44, color3)
	end
end

function SetContextMenuVisible(mIsVisible, p)
	v28.mIsVisible = mIsVisible
	mMovie:__wf_atom_2dedec1a("ContextMenu", 13, mIsVisible)

	if not mIsVisible and not p and appendInfo ~= nil then
		v8.mElementDrawCallback(appendInfo)
	end
end

local function fn44()
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module7.GetColor(1, true))
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module7.GetColor(2, true))
	mMovie:OverrideMaterial("ContextMenu.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"ContextMenu.Bg",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.15
	)
	mMovie:__wf_atom_1ca72041(
		"ContextMenu.Bg",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.95
	)
	local module12 = require("Lotus.Interface.Components.ThemedButton")
	local module13 = require("EE.Interface.Components.List")
	v28 = module13.CreateList(mMovie, "ContextMenu.Element")
	v28.mVisibleElements = 4
	v28.mForcedHorizontalSeparation = 0
	v28.mForcedVerticalSeparation = module.Ternary(Engine.__wf_atom_b6edc589(), 80, 33)

	function v28:mElementDrawCallback()
		self.Button = module12.Create(mMovie, self.mClipName .. ".Button", self.Name, self.Callback, "", false)
		self.Button.mUnderlineAlpha = 0
		self.Button.mTextBuffer = 45
		self.Button.mHeight = module.Ternary(Engine.__wf_atom_b6edc589(), 80, 37)

		if Engine.__wf_atom_b6edc589() then
			self.Button.mMinSize = 250
		end

		self.Button:SetTextAlignment("left")
		self.Button:Redraw()
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)

		if self.TintIcon then
			local color = module7.GetColor(9, true)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color)

			if Engine.__wf_atom_b6edc589() then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 1, 25)
			end
		end
	end

	SetContextMenuVisible(false)
end

function Initialize()
	if not gGameRules:__wf_atom_af3bd666() then
		mMovie:Close()
		return
	end

	v34 = module3.ServerSideSettings()

	if not v34.mTradingRulesConfirmed then
		fn5(2)
	end

	module3.RegisterHideHud(true)

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(1)
	end

	gGameRules:__wf_atom_411c9025(true)
	_T.ChatInTrade = true

	if not _T.UIInputEnabled then
		_T.EnableUIInput()
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.3)

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0.3, nil, false)
	end

	v5 = gGameRules:__wf_atom_c88ae023()
	forDisplay = v5:__wf_atom_03399a72()
	fn44()
	mMovie:__wf_atom_2dedec1a("PartnerTradeStatus", 13, false)

	if forDisplay then
		mMovie:__wf_atom_2dedec1a("PartnerProfile", 13, false)
		mMovie:__wf_atom_2dedec1a("Separator.LeftLine", 13, false)
		mMovie:__wf_atom_2dedec1a("Separator.RightLine", 13, false)
		mMovie:__wf_atom_2dedec1a("Separator.LeftArrow", 13, false)
		mMovie:__wf_atom_2dedec1a("Separator.RightArrow", 13, false)
		mMovie:__wf_atom_2dedec1a("Separator.Alert", 13, false)
		mMovie:__wf_atom_2dedec1a("PartnerTradeMenu.MenuEntry", 13, false)
		mMovie:__wf_atom_2dedec1a("PlayerProfile.TaxInfo", 13, false)
		mMovie:__wf_atom_2dedec1a("PlayerProfile.TraderTag.Name", 13, false)
		mMovie:__wf_atom_e57658c2("PlayerProfile.TraderTag", 0, -584)
		mMovie:__wf_atom_e57658c2("PlayerProfile.TraderTag", 1, 96)
		mMovie:__wf_atom_e57658c2("Title", 1, 580)
		mMovie:__wf_atom_e57658c2("PlayerTradeMenu", 0, 600)
		mMovie:__wf_atom_e57658c2("PlayerTradeMenu", 1, 770)
		mMovie:__wf_atom_e57658c2("Bg", 1, 572)
		mMovie:__wf_atom_e57658c2("Bg", 15, 340)
		mMovie:__wf_atom_e57658c2("Bg", 14, 968)
	else
		v5:__wf_atom_51cba3c4("OnTradeOpSuccess", "OnTradeOpFail", "TradeBuddyDestroyed")
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local inventory = gGameData:GetInventory()
		module4.BuildInstalled(v25, inventory)
	end

	mMovie:__wf_atom_50d60589("PlayerProfile.TaxInfo.Bank", 36, "")
	module3.InitializeProfileIconList()
	module3.RegisterProfileIcon(mMovie, "PlayerProfile.TraderTag.Icon")
	fn43(
		"PlayerProfile",
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(),
		__wf_atom_7e8ad928(gGameData) and 0 or gGameData:__wf_atom_e573620a()
	)
	v8 = fn41("PlayerTradeMenu.MenuEntry", true)

	if not forDisplay then
		v9 = fn41("PartnerTradeMenu.MenuEntry", false)
		v10 = mMovie:__wf_atom_5e6e15c8("PartnerTradeMenu", 1)
		v11 = mMovie:__wf_atom_5e6e15c8("PartnerTradeStatus", 1)
	end

	local module12 = require("SF.Interface.Components.Button")
	v12 = module12.Create(mMovie, "ReadyBtn", "", "ToggleReady", "")
	v12.mPrefixCallout = false
	v12:SetVariant(module12.VARIANTS.SPECIAL_BUTTON)
	v12:SetAnchor(module.CENTER_ALIGNED)
	v12:SetVisible(false)
	mMovie:__wf_atom_7d7314f1(
		"FillSlotPrompt.text",
		module.Ternary(
			forDisplay,
			"/Lotus/Language/Dojo/PickItems_FillSlotPrimpt",
			"/Lotus/Language/Dojo/Trade_FillSlotPrompt"
		)
	)
	local color = module7.GetColor(6, true)
	mMovie:__wf_atom_e57658c2("FillSlotPrompt", 44, color)
	mMovie:__wf_atom_e57658c2("FillSlotPrompt", 12, 70)
	mMovie:__wf_atom_e57658c2("PartnerTradeStatus", 12, 70)

	if not forDisplay then
		mMovie:__wf_atom_e57658c2("FillSlotPrompt", 12, 0)
	end

	local ternary = module.Ternary(
		forDisplay,
		"/Lotus/Language/Dojo/PickTradeItemsAccept",
		"/Lotus/Language/Dojo/AcceptTrade"
	)
	local ternary2 = module.Ternary(forDisplay, "AcceptDisplayItems", "AcceptTrade")
	v13 = module12.Create(mMovie, "Separator.AcceptTradeBtn", ternary, ternary2, "<MENU_GENERIC2>")
	module.PlaySound(tradeMenuOpenSound)
	v13:SetVariant(module12.VARIANTS.SPECIAL_BUTTON)
	v13:SetAnchor(module.CENTER_ALIGNED)
	v13:SetVisible(forDisplay)
	v13:Redraw()
	local color2 = module7.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("Separator.LeftLine", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_e57658c2("Separator.RightLine", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_e57658c2("Separator.LeftArrow", 11, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("Separator.RightArrow", 11, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("Separator.LeftArrow", 12, 0)
	mMovie:__wf_atom_e57658c2("Separator.RightArrow", 12, 0)
	mMovie:__wf_atom_e57658c2("LinesLeft", 11, color2)
	mMovie:__wf_atom_e57658c2("LinesRight", 11, color2)
	mMovie:OverrideMaterial("LinesLeft", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("LinesRight", _G.UIMaterial_VitruvianLines)
	mMovie:__wf_atom_e57658c2("LinesLeft", 12, 0)
	mMovie:__wf_atom_e57658c2("LinesRight", 12, 0)
	fn6()
	module7.GetColor(12, true)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Label", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_7d7314f1("Separator.Alert.Label.text", "/Lotus/Language/Dojo/Trade_OfferChangedAlert")
	fn29(false)

	if not forDisplay then
		local __wf_atom_f28a905d = v5:__wf_atom_f28a905d()

		if __wf_atom_f28a905d:__wf_atom_8598f3a9() then
			mDisplayName = __wf_atom_f28a905d.mDisplayName
			mPlayerLevel = __wf_atom_f28a905d.mPlayerLevel
			mAccountId = __wf_atom_f28a905d.mAccountId
			v18 = { PLAYER_NAME = mDisplayName }
			local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
			local mPlatformFamily = __wf_atom_f28a905d.mPlatformFamily

			if __wf_atom_63bb2bc6 ~= mPlatformFamily and (__wf_atom_63bb2bc6 == 3 or mPlatformFamily == 3) then
				CAN_GIVE = v15.WALLET_MISMATCH
			end

			fn9()
			mRegularCredits = __wf_atom_f28a905d.mRegularCredits
			local mAvatarImage = __wf_atom_f28a905d.mAvatarImage
			local profilePlaceholder = profilePlaceholder

			if not __wf_atom_7e8ad928(mAvatarImage) then
				profilePlaceholder = Resource(mAvatarImage):GetIconTexture()
			end

			mMovie:__wf_atom_c90af43a("PartnerProfile.TraderTag.Icon", profilePlaceholder)
			local mTradesRemaining = __wf_atom_f28a905d.mTradesRemaining
			fn43("PartnerProfile", mDisplayName, mTradesRemaining, true)
			mMovie:__wf_atom_50d60589(
				"PartnerProfile.TaxInfo.Bank",
				36,
				mMovie:__wf_atom_8e9ac384("<DRACS> ", true) .. module.FormatNumber(mRegularCredits)
			)

			if v17.mState == 2 or v17.mState == 4 then
				v20 = true
			end

			fn11()

			if v17:__wf_atom_8598f3a9() then
				fn31(true, true)
				module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeSessionResume", false, v18))
				fn11()
			else
				fn18(0, 0, v17.mClanTax)
			end
		end
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Dojo/" .. module.Ternary(forDisplay, "PickTradeItemsTitle", "TradingPostScreenTitle"),
			false
		))
	end

	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute(
			"EnteringTrade",
			(mDisplayName == nil or mAccountId == nil) and "" or mAccountId .. "!" .. mDisplayName
		)
	end

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_af3bd666() and not forDisplay then
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
			__wf_atom_b56d2aa8:Execute("OnTradeSession", "true")
		end
	end

	mMovie:OverrideMaterial("Title.Bg", _G.UIMaterial_FocusedBackerBorder)
	mMovie:OverrideMaterial("Bg", _G.UIMaterial_UnfocusedBackerBorder)
	mMovie:__wf_atom_e57658c2("Title.Text", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_50d60589("Title.Text", 36, mMovie:__wf_atom_8e9ac384("/SF/Language/Social/TradeTitle", true))
	local v46 = math.max(
		mMovie:__wf_atom_5e6e15c8("Separator.Alert.Line", 14) - 80,
		mMovie:__wf_atom_5e6e15c8("Separator.Alert.Label", 40)
	)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Backer", 14, v46 + 200)
	local v47 = mMovie:__wf_atom_5e6e15c8("Separator.Alert.Label", 41) + 32
	mMovie:__wf_atom_e57658c2("Separator.Alert.Backer", 15, v47)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Backer", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Backer", 12, 70)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Countdown", 12, 0)
	local visibilitySize = module.GetVisibilitySize(mMovie, v46, true)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 40, true)
	mMovie:OverrideMaterial("Separator.Alert.Backer", impactBackerMaterial)
	mMovie:__wf_atom_1ca72041("Separator.Alert.Backer", "VisibilitySize", visibilitySize, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Separator.Alert.Backer", "VisibilityFadeSize", visibilityFadeSize, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("Separator.Alert.Topper", 11, _G.UIColor_DarkerBrown)
	v7 = true
end

function OpResultReviewed()
	fn3()
end

function OpFailedUnknownErrorReviewed()
	v5:CancelTrade(false)
	fn3()
end

function OnOfferFailedReviewed()
	fn9()
	v27 = nil
	fn31(true)
	fn11()
end

function OnAcceptFailedReviewed()
	v13:SetActive(true)
end

function RefreshFailReviewed()
	v5:CancelTrade(false)
	fn3()
end

function OnTradeOpFail(op, errString)
	table.insert(v38, { success = false, errString = errString, op = op })
end

local function fn45(op, errString)
	local v45 = tonumber(errString)

	if op == 3 then
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeCancelFail", false),
			"OpFailedUnknownErrorReviewed"
		)
	elseif op == 0 or op == 1 or op == 2 then
		local v46 = (op == 0 or op == 1) and "OnOfferFailedReviewed"
			or op == 2 and "OnAcceptFailedReviewed"
			or "OpResultReviewed"
		local v47 = op == 0 and "OnOfferFailedReviewed" or "OpResultReviewed"

		if v45 == SF.__wf_atom_4562b6cb or v45 == SF.__wf_atom_996f913d then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_OFFER_CHANGED", false), v46)
		elseif v45 == SF.__wf_atom_5c731e00 then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_BUDDY_OFFERING_PLAT", false))

			if v21 >= 1 and v21 <= 6 and v19[v21] ~= nil then
				appendInfo = v19[v21]
				appendInfo = fn25(v8, appendInfo)
				appendInfo.TradeType = v14.NONE
				CAN_GIVE = v15.BUDDY_GIVING
				fn27()
			end
		elseif v45 == SF.__wf_atom_2e0cc107 then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_WALLET_MISMATCH", false))

			if v21 >= 1 and v21 <= 6 and v19[v21] ~= nil then
				appendInfo = v19[v21]
				appendInfo = fn25(v8, appendInfo)
				appendInfo.TradeType = v14.NONE
				CAN_GIVE = v15.WALLET_MISMATCH
				fn27()
			end
		else
			if v45 == SF.__wf_atom_a8468f34 then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Dojo/TRADE_ERR_WEAPON_NOT_UNRANKED",
					false
				))
				return
			end

			if v45 == SF.__wf_atom_e113839c then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_TO_BUDDY_HAS_ITEM", false),
					v46
				)
				return
			end

			if v45 == SF.__wf_atom_dde57d74 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_WEAPON_XP_LOCKED", false),
					v46
				)
				return
			end

			if v45 == SF.__wf_atom_79ba2908 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_PREREQUISITE", false),
					v46
				)
				return
			end

			if v45 == SF.__wf_atom_c4a28000 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_ACCEPT_STATE_RETRY", false),
					v46
				)
				return
			end

			if v45 == SF.__wf_atom_f87a2aca then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_PLAT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_a86734a6 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_PLAT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_27c5e7d3 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_ITEMS_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_911c8b98 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_ITEMS_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_722e5dc5 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_MOD_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_a6fb8473 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_MOD_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_3f19fb28 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_CREDITS_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_95e08844 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_INSUFFICIENT_CREDITS_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_72cddd6b then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_PRINT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_a865f7d4 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_PRINT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_932333c9 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SLOT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_b48e1dcb then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SLOT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_9917f5e8 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_PLACED_TREASURE_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_90c2e1bf then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_PLACED_TREASURE_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_879471db then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_ITEM_CHANGED_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_0acd5fb5 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_ITEM_CHANGED_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_68febbb5 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_ARCHWING_SLOT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_af2a2f0e then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_ARCHWING_SLOT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_f648ffd6 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SENTINEL_SLOT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_3df159a4 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SENTINEL_SLOT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_481c28fc then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SONG_SLOT_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_0c55a8a0 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SONG_SLOT_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_ea9ecd4b then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_ME", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_820a96c4 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_BUDDY", false),
					v47
				)
				return
			end

			if v45 == SF.__wf_atom_e6782757 then
				return
			end

			if v45 == SF.__wf_atom_25476399 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_WEAPON_WILL_EXPIRE", false),
					v47
				)
			elseif v45 == SF.__wf_atom_8c4eec80 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_BUDDY_OMEGA_CAPACITY", false),
					"OnOfferFailedReviewed"
				)
			elseif v45 == SF.__wf_atom_0decce3b then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_SONG_CAPACITY", false),
					v46
				)
			elseif v45 == SF.__wf_atom_87a23806 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_HAS_EMOTE_BUDDY", false),
					v47
				)
			elseif v45 == SF.__wf_atom_4436d29a then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_HAS_EMOTE_ME", false), v47)
			elseif v45 == SF.__wf_atom_53eaefe3 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_EMOTE_BUDDY", false),
					v47
				)
			elseif v45 == SF.__wf_atom_9f3ea7f7 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_EMOTE_ME", false),
					v47
				)
			elseif v45 == SF.__wf_atom_27adb534 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_HAS_SKIN_BUDDY", false),
					v47
				)
			elseif v45 == SF.__wf_atom_1cb4b2ed then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_HAS_SKIN_ME", false), v47)
			elseif v45 == SF.__wf_atom_fde50dab then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SKIN_BUDDY", false),
					v47
				)
			elseif v45 == SF.__wf_atom_9c4d1b14 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_MISSING_SKIN_ME", false),
					v47
				)
			elseif v45 == SF.__wf_atom_9eb7b085 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/COSMETIC_ENHANCER_RANK_ME", false),
					v47
				)
			elseif v45 == SF.__wf_atom_3c23370a then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/COSMETIC_ENHANCER_RANK_BUDDY", false),
					v47
				)
			elseif op == 0 or op == 1 then
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_OFFER_UNKNOWN_ERROR", false),
					"OnOfferFailedReviewed"
				)
			else
				module.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ACCEPT_UNKNOWN_ERROR", false),
					"OpFailedUnknownErrorReviewed"
				)
			end
		end
	elseif op == 4 then
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_REFRESH_FAIL", false, v18),
			"RefreshFailReviewed"
		)
	elseif op == 6 or op == 7 then
		if v45 == SF.__wf_atom_4562b6cb then
			flag3 = true
			fn11()
		elseif v45 == SF.__wf_atom_8c4eec80 then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_OMEGA_CAPACITY", false), nil)
		elseif v45 == SF.__wf_atom_0decce3b then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TRADE_ERR_SONG_CAPACITY", false), nil)
		end
	end
end

function OnTradeOpSuccess(triggeredByLocalPlayer, op)
	table.insert(v38, { success = true, triggeredByLocalPlayer = triggeredByLocalPlayer, op = op })
end

local function fn46(triggeredByLocalPlayer, op)
	if op == SF.__wf_atom_4562b6cb then
		local v45 = mRevision
		local v46 = mSelfReady
		fn9()
		v27 = nil

		if v17.mState == 2 then
			v20 = true
		end

		if flag3 then
			if mSelfReady then
				flag3 = false
			end
		elseif v46 and not mSelfReady and v45 < mRevision and not triggeredByLocalPlayer then
			flag3 = true
		end

		fn11()

		if triggeredByLocalPlayer then
			local v47 = mRevision

			if not (v45 + 1 < v47) then
				return
			end
		end

		fn31(false, true)
	elseif op == SF.__wf_atom_acc181b8 then
		fn9()
		fn11()
	elseif op == SF.__wf_atom_c4469886 then
		if gGameRules:IsA(__wf_atom_1316e0c2) then
			local v45 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
			gGameRules:SendControlMessage(v45)
		end

		local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("UpdateOmegaSuggestTree", "")
		end

		flag2 = true
	elseif op == SF.__wf_atom_8a4ca178 or op == SF.__wf_atom_312e1702 then
		local v45

		if triggeredByLocalPlayer then
			v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeCancelLocalPlayer", false)
		elseif op == SF.__wf_atom_8a4ca178 then
			local ternary = module.Ternary(
				gGameRules:__wf_atom_af3bd666(),
				"/Lotus/Language/Dojo/TradeCancelRemotePlayerHub",
				"/Lotus/Language/Dojo/TradeCancelRemotePlayer"
			)
			v45 = mMovie:__wf_atom_8e9ac384(ternary, false, v18)
		else
			local ternary = module.Ternary(
				gGameRules:__wf_atom_af3bd666(),
				"/Lotus/Language/Dojo/TradePlayerLeftSessionHub",
				"/Lotus/Language/Dojo/TradePlayerLeftSession"
			)
			v45 = mMovie:__wf_atom_8e9ac384(ternary, false, v18)
		end

		module.ShowMessage(v45, "OpResultReviewed")
	end
end

function TradeBuddyDestroyedReviewed()
	fn3()
end

function TradeBuddyDestroyedCancelResume(p)
	if tonumber(p) == 4 then
		fn3()
	else
		v5:CancelTrade(true)
	end
end

function TradeBuddyDestroyed()
	local ternary = module.Ternary(
		gGameRules:__wf_atom_af3bd666(),
		"/Lotus/Language/Dojo/TradeBuddyDestroyedHub",
		"/Lotus/Language/Dojo/TradeBuddyDestroyed"
	)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(ternary, false, v18)

	if v17 == nil or not v17:__wf_atom_8598f3a9() then
		if flag then
			return
		end

		module.ShowMessage(__wf_atom_8e9ac384, "TradeBuddyDestroyedReviewed")
	else
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.locString = __wf_atom_8e9ac384 .. " " .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Dojo/ResumeOrCancel",
			false
		)
		dialogSettings.firstString = "/Lotus/Language/Dojo/RESUME"
		dialogSettings.secondString = "/Lotus/Language/Dojo/CANCEL_TRADE"
		dialogSettings:SetCallback("TradeBuddyDestroyedCancelResume")
		module.ShowCustomMessage(dialogSettings)
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v7 then
		return
	end

	asyncLoader:Update()

	if #v38 > 0 then
		for i = 1, #v38 do
			local v45 = v38[i]

			if v45.success then
				fn46(v45.triggeredByLocalPlayer, v45.op)
			else
				fn45(v45.op, v45.errString)
			end
		end

		v38 = {}
	end

	if v32 and __wf_atom_7e8ad928(v16) then
		v32 = false
	end

	mMovie:SetVisible(not v32 and __wf_atom_7e8ad928(__wf_atom_392793db))
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if flag2 then
		flag2 = false
		fn34()
	end

	fn15()
	v35 += v36 * __wf_atom_fa1258d0()

	if v35 < 0 or v35 > 0.5 then
		v35 = __wf_atom_421b01aa(v35, 0, 0.5)
		v36 *= -1
	end

	local v45 = v35 / 0.5
	local v46 = __wf_atom_104bfe98(10, 125, v45)
	local v47 = { v8, v9 }

	for i = 1, #v47 do
		local v48 = v47[i]

		if v48 ~= nil then
			v48:RunForAllElements(function(data)
				if data.mShowChangedIcon then
					for j = 1, #data.Labels do
						if data.Labels[j].Type ~= module2.LABEL_TYPE_RESEARCHED then
							continue
						end

						mMovie:__wf_atom_e57658c2(data.mClipName .. ".TagContainer.Tag" .. tostring(j), 12, v46)
						break
					end
				end

				if data.TradeType == v14.MOD and data.mMod ~= nil then
					module4.Update(data.mMod, __wf_atom_084b3e93())
				end
			end)
		end
	end

	module6.UpdateStepSequencer(v29)
end

function CancelConfirm(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(v5) then
		v5:CancelTrade(true)
	end
end

function LeaveSessionConfirm(p)
	if tonumber(p) == 4 then
		if not __wf_atom_7e8ad928(v5) then
			v5:CancelTrade(false)
		end

		fn42()
	end
end

local function fn47()
	if
		__wf_atom_7e8ad928(v28)
		or __wf_atom_7e8ad928(v8)
		or not v28.mIsVisible
		or not __wf_atom_7e8ad928((v8:GetFocusedElement()))
	then
		return
	end

	local rootBasedPosition, v45 = module.GetRootBasedPosition(mMovie, "ContextMenu")
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if
		rootBasedPosition <= __wf_atom_5e6e15c8_3
		and __wf_atom_5e6e15c8_3 <= rootBasedPosition + __wf_atom_5e6e15c8
		and v45 <= __wf_atom_5e6e15c8_4
		and __wf_atom_5e6e15c8_4 <= v45 + __wf_atom_5e6e15c8_2
	then
		return
	end

	SetContextMenuVisible(false)
end

function onKeyUp_MENU_CLICK()
	if Engine.__wf_atom_dd1285f1() then
		fn47()
	end
end

function onKeyDown_MENU_CLICK()
	if not Engine.__wf_atom_dd1285f1() then
		fn47()
	end
end

function onKeyDown_MENU_SELECT()
	if Engine.IsPlayingWithController() then
		fn47()
	end
end

function onKeyDown_MENU_CANCEL()
	if not v6 then
		if not __wf_atom_7e8ad928(v28) and v28.mIsVisible then
			SetContextMenuVisible(false)
			return
		end

		module.PlaySound(_G.UISound_Close)

		if forDisplay then
			fn3()
		elseif v17 == nil or not v17:__wf_atom_8598f3a9() then
			local ternary = module.Ternary(
				gGameRules:__wf_atom_af3bd666(),
				"/Lotus/Language/Dojo/TradeLeaveSessionConfirmHub",
				"/Lotus/Language/Dojo/TradeLeaveSessionConfirm"
			)
			module.ShowConfirmMessage(mMovie:__wf_atom_8e9ac384(ternary, false, v18), "LeaveSessionConfirm")
		else
			local ternary = module.Ternary(
				gGameRules:__wf_atom_af3bd666(),
				"/Lotus/Language/Dojo/TradeCancelConfirmHub",
				"/Lotus/Language/Dojo/TradeCancelConfirm"
			)
			module.ShowConfirmMessage(mMovie:__wf_atom_8e9ac384(ternary, false, v18), "CancelConfirm")
		end
	end
end

function onKeyDown_MENU_RIGHT_CLICK()
	if __wf_atom_7e8ad928(v8) then
		return
	end

	local focusedElement = v8:GetFocusedElement()

	if not __wf_atom_7e8ad928(focusedElement) and focusedElement.TradeType ~= v14.NONE then
		appendInfo = focusedElement
		fn()
		module.PlaySound(clearSlotSound)
		_T.InfoPopup_Data = nil
	end
end

function onViewportSizeChanged(_, _, _, _) end

function MenuItemFocused(p)
	if not __wf_atom_7e8ad928(v8) then
		v8:FocusElementById((tonumber(p)))
		module.PlaySound(tradeMenuRolloverSound)
	end
end

function MenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v8) then
		v8:UnfocusElementById((tonumber(p)))
	end
end

function MenuItemPressed(p)
	if not (v6 or __wf_atom_7e8ad928(v8)) then
		v8:SelectElementById((tonumber(p)))
	end
end

function PartnerMenuItemFocused(p)
	if not __wf_atom_7e8ad928(v9) then
		v9:FocusElementById((tonumber(p)))
		module.PlaySound(tradeMenuRolloverSound)
	end
end

function PartnerMenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v9) then
		v9:UnfocusElementById((tonumber(p)))
	end
end

function PartnerMenuItemPressed(p)
	if not (v6 or __wf_atom_7e8ad928(v9)) then
		v9:SelectElementById((tonumber(p)))
	end
end

function OnGamepadTransition(_) end

function SupportsThemes()
	return true
end

function OpenFlashMovieFile()
	if gGameRules:__wf_atom_af3bd666() then
		local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

		if not __wf_atom_7e8ad928(__wf_atom_c88ae023) then
			__wf_atom_c88ae023:__wf_atom_51581565()
		end
	else
		module.ShowMessage("/Lotus/Language/Dojo/NotInTradeHub")
	end

	mMovie:Close()
end