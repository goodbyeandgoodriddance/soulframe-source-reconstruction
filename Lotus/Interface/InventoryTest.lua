local arsenal_ForceUmbraUnlock = false
local arsenal_ForceUmbraSwordUnlock = false
local v = WeakResource()
local v2 = WeakResource()
local v3 = nil
local primeSellManifestType2 = nil
local v4 = nil
local v5 = nil
local selectingEnemiesManifest = nil
local v6 = nil
local scans = {}
local flag = false
local v7 = false
local v8 = false
local v9 = nil
local selectedEnemyLevel = 0
local v10 = 20
local v11 = 5000
local v12 = Symbol("AvatarPause")
local v13 = { PauseState = nil, ScreenVis = {}, AvatarDrawOnTop = false, BgInfo = {} }
local module = require("EE.Interface.AnchorMgr")
local module2 = require("Lotus.Interface.StoreItemUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("EE.Interface.Utilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("Lotus.Interface.CardUtilitiesRedux")
local module8 = require("Lotus.Interface.SyndicateUtilities")
local module9 = require("Lotus.Interface.CodexUtilities")
local module10 = require("Lotus.Interface.Components.ThemedButton")
local module11 = require("Lotus.Interface.Components.ThemedProgressInfo")
local module12 = require("Lotus.Scripts.Libs.StoryLib")
local v14 = nil
local v15 = nil
local v16 = false
local flag2 = true
local flag3 = false
local flag4 = false
local v17 = nil
local v18 = nil
local infoPopup_Grid = nil
local gameData = nil
local v19 = {}
local v20 = nil
local v21 = nil
local v22 = nil
local flag5 = false
local v23 = nil
local v24 = nil
local v25 = nil
local id = nil
local v26 = nil
local total = 0
local v27 = ""
local v28 = ""
local v29 = ""
local v30 = false
local v31 = nil
local v32 = false
local v35 = 0
local total2 = 0
local flag6 = false
local v36 = {}
local v37 = false
local v38 = nil
local inventory = nil
local v39 = {}
local v40 = {}
local v41 = { Category = nil, Elements = {} }
local v42 = {}
local v43 = {}
local v44 = { Elements = 0 }
v44.Elements = {}
local v45 = nil
local v46 = 1
local v47 = true
local v48 = nil
local v49 = nil
local v50 = nil
local v51 = {
	SyndicateInfo = nil,
	DailyStandingInfo = nil,
	mSyndicateStandingBonusOperation = nil,
	MadeTrade = false
}
local id2 = nil
local v52 = {
	INVENTORY = 1,
	ENEMIES = 2,
	FISH = 3,
	TREASURE = 4,
	PRIMEPARTS = 5,
	SHIP_RAW = 6,
	SHIP_SCRAP = 7,
	SHIP_PARTS = 8,
	SHARDS = 9,
	DECODONATE = 10,
	RESDONATE = 11,
	TRADE_ITEMS = 12,
	TRADE_MODS = 13,
	SYNDDONATE = 14
}
local inventory2 = v52.INVENTORY
local flag7 = false
local flag8 = false
local v53 = { INVENTORY = 1, SELL = 2 }
local sell = nil
local v54 = { Materials = {}, Size = 0, YPos = 0 }
local v55 = 142
local v56 = WeakResource()
lichItems = {}
local v57 = WeakResource("/Lotus/Interface/StandingGainPopup.swf")
local v58 = {
	ALL = 0,
	WARFRAME = 1,
	WEAPONS = 2,
	SENTINEL = 3,
	APPEARANCE = 4,
	ENHANCEMENTS = 5,
	FOCUS = 6,
	DRONES = 7,
	GEAR = 8,
	KEYS = 9,
	RESOURCES = 10,
	PRIME = 11,
	ARCHWING = 12,
	ARCHWINGWEAPONS = 13,
	MISC = 14,
	OPERATORAMPS = 15,
	GRINEER = 16,
	CORPUS = 17,
	INFESTED = 18,
	WILD = 19,
	OROKIN = 20,
	SENTIENT = 21,
	RELICS = 22,
	RECIPES = 23,
	PETPRINTS = 24,
	LICH = 25,
	AVIONICS = 26,
	MKI = 27,
	MKII = 28,
	MKIII = 29,
	LAVAN = 30,
	VIDAR = 31,
	ZEKTI = 32,
	SIGMA = 33,
	MECHS = 34,
	EMOTE = 35,
	NARMER = 36
}
local v59 = { FISH_SMALL = 16, FISH_MEDIUM = 17, FISH_LARGE = 18 }
local v60 = {}
local v61 = { EXIT = 1, FISH_CATEGORY = 3, SELECT_ALL = 5, TUTORIAL = 6 }
local fn
local fn2
local fn3
local fn4
local fn5
local fn6
local fn7
local fn8

local function fn9(p)
	v32 = p
	__wf_atom_86cbd68d(mMovie, "Sellable.Toggle.gotoAndStop", p and "On" or "Off")
	fn6()
	v17.mMuteGridOpenSound = true
	v17:Redraw(nil, true, true)
	v17.mMuteGridOpenSound = false
end

local function fn10()
	fn9(not v32)
end

local function fn11()
	return inventory2 == v52.TRADE_ITEMS or inventory2 == v52.TRADE_MODS
end

fn6 = function()
	local v62 = {}

	if inventory2 == v52.INVENTORY then
		table.insert(v62, {
			Label = mMovie:__wf_atom_8e9ac384("<WARNING>", true),
			Tips = module6.GetTips(mMovie, "/Lotus/Language/WarframeHints/Inventory_"),
			Padding = -10
		})
		table.insert(v62, {
			Label = module4.Ternary(v32, "/Lotus/Language/Menu/OnlySellableOn", "/Lotus/Language/Menu/OnlySellableOff"),
			CallBack = fn10
		})
	end

	for i = #v19, 1, -1 do
		local v63 = v19[i]

		if v63.mVisible then
			table.insert(v62, {
				Label = v63.mLabel,
				CallBack = v63.mCallback,
				CallOut = v63.mCallout
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v62, getfenv(1))
	end
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
	_T.SellingPrimeParts = nil
	_T.SellingTreasure = nil
	_T.SelectingFishManifest = nil
	_T.SelectingEnemies = nil
	_T.SelectingEnemiesManifest = nil
	_T.ShowPrimeBucks = nil
	_T.ShowPrimeTokens = nil
	_T.ShowFusionPoints = nil
	_T.InvTradingInfo = nil
	_T.OnNemesisClosed = nil
	_T.InventoryScreenOpen = false

	if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(__wf_atom_a0f6588f)) then
		if not __wf_atom_7e8ad928(_T.SelectedEnemyLevel) then
			v6:__wf_atom_b31a0fbe((tostring(_T.SelectedEnemyLevel)))
		end

		if not __wf_atom_7e8ad928(_T.PauseAI) then
			v6:__wf_atom_22899f5b(_T.PauseAI)
		end

		if __wf_atom_7e8ad928(_T.warframesInvincible) then
			v6:__wf_atom_fb71d97a(false)
		else
			v6:__wf_atom_fb71d97a(_T.warframesInvincible)
		end

		if __wf_atom_7e8ad928(_T.companionsInvincible) then
			v6:__wf_atom_437fd4dc(false)
		else
			v6:__wf_atom_437fd4dc(_T.companionsInvincible)
		end

		if not __wf_atom_7e8ad928(_T.FriendlyFire) then
			v6:__wf_atom_ab3293e2(_T.FriendlyFire)
		end

		__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
	end

	if not (v13.PauseState or __wf_atom_7e8ad928(gGameRules)) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if inventory2 == v52.SHIP_SCRAP then
		module6.ToggleScreensToHide(true, v13.ScreenVis)
	end

	if inventory2 == v52.TREASURE and not __wf_atom_7e8ad928(_T.PlayBackgroundTransmission) then
		_T.LypSyncDeco = _T.MarooDeco
		_T.PlayBackgroundTransmission("TransactionComplete", transmissionSet, 3)
	end

	_T.MarooDeco = nil
	module3.RegisterHideHud(false)

	if inventory2 == v52.TRADE_MODS then
		module6.ClearGridModMaterials()
	end

	if not __wf_atom_7e8ad928(v17) then
		local sortById = v17:GetSortById()

		if not (__wf_atom_7e8ad928(sortById) or __wf_atom_7e8ad928(gameData)) then
			local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
			gameData:__wf_atom_00283c1e(__wf_atom_6d61d595, sortById)
		end
	end

	local mainMenuSuitAvatar = module3.GetMainMenuSuitAvatar()

	if not __wf_atom_7e8ad928(mainMenuSuitAvatar) then
		if __wf_atom_8e4fda44:FindMovie(tennoWayMovie) == nil then
			mainMenuSuitAvatar:SetVisibility(true)
		end

		if v13.AvatarDrawOnTop then
			mainMenuSuitAvatar:__wf_atom_e424c72a(true)
		end
	end

	fn8()

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if not __wf_atom_7e8ad928(v25) then
		v25:Close()
	end

	if
		not __wf_atom_7e8ad928(gGameRules)
		and not __wf_atom_7e8ad928(gRegion)
		and gGameRules:IsA(__wf_atom_469b1d97)
		and gRegion:IsMaster()
		and gGameRules:Paused()
	then
		gGameRules:__wf_atom_9141808b()
		gGameRules:__wf_atom_fb52d63c()
	end
end

local function fn12()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()

		if not __wf_atom_7e8ad928(settings) then
			settings:__wf_atom_82557c37(v32)
		end
	end
end

fn8 = function()
	if flag4 then
		return
	end

	if flag3 then
		_T.DisableUIInput()
	end

	if v13.BgInfo.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0, v13.BgInfo.HighlightOffset, v13.BgInfo.HighlightOn, v13.BgInfo.VisRangeInfo)
	elseif not (__wf_atom_7e8ad928(_T.HideBackground) or fn11()) then
		_T.HideBackground(0.2)
	end

	flag4 = true
end

local function fn13()
	fn8()

	if inventory2 == v52.PRIMEPARTS and not __wf_atom_7e8ad928(_T.InterruptVoidTraderTransmission) then
		_T.InterruptVoidTraderTransmission()
	end

	if not (__wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())) then
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_d17657dc()
	end

	flag2 = true
	local v62 = __wf_atom_8e4fda44:FindMovie(tennoWayMovie) == nil and 0.2 or 0
	module4.FadeBackground(mMovie, 0, v62)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, v62, 0, function()
		if not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(_T[v21])) then
			_T[v21]()
		end

		mMovie:Close()
		fn12()
	end)
end

function OnUpdateSessionSettings() end

function OnSaveLoadOutComplete(_, _)
	module3.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")

	if v23 ~= nil then
		_T[v23](true)
		v23 = nil
	end

	fn13()
end

local function fn14()
	flag2 = true

	if
		inventory2 == v52.SYNDDONATE
		and not (v51.MadeTrade or __wf_atom_7e8ad928(_T.SyndicateInvInfo) or __wf_atom_7e8ad928(_T.SyndicateInvInfo.Syndicate))
	then
		local vendorTag = _T.SyndicateInvInfo.VendorTag

		if vendorTag ~= nil then
			local v62 = "DogTagExitNoSale"

			if vendorTag ~= EMPTY_SYMBOL then
				v62 ..= vendorTag:c_str()
			end

			module8.PlaySyndicateTransmission(_T.SyndicateInvInfo.Syndicate, v62)
		end
	end

	if flag5 then
		flag5 = false
	else
		fn13()
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("DisplayInWorldText", "true")
end

function TransitionOut()
	fn14()
end

local function fn15(p)
	if not p and _T.InventoryInfo ~= nil and _T.InventoryInfo.CancelConfirm ~= nil then
		module4.ShowYesOrNoMessage(_T.InventoryInfo.CancelConfirm, "OnExitScreenConfirm")
		return
	end

	module4.PlaySound(_G.UISound_GridOpenTwo)
	module4.PlaySound(_G.UISound_WindowClose)
	fn14()

	if __wf_atom_21342f4a ~= nil and gGameRules:IsA(__wf_atom_311a7128) and inventory2 == v52.INVENTORY then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "EQUIPMENT_INVENTORY")
	end
end

function OnExitScreenConfirm(p)
	if tonumber(p) == 4 then
		fn15(true)
	end
end

function OnTeleportedToConsole()
	fn14()
end

local function fn16()
	local v62 = #infoPopup_Grid.mElements > 0
	mMovie:__wf_atom_2dedec1a("SellList.Tip", 13, not v62)

	if v62 and _T.InventoryInfo ~= nil and _T.InventoryInfo.MinSellAmount ~= nil then
		local total3 = 0

		for i = 1, #infoPopup_Grid.mElements do
			local mElement = infoPopup_Grid.mElements[i]
			total3 += module4.Ternary(mElement.Count ~= nil, mElement.Count, 1)
		end

		v62 = _T.InventoryInfo.MinSellAmount <= total3
	end

	if not __wf_atom_7e8ad928(v18) then
		v18:SetActive(v62)
	end
end

local function fn17(data)
	if __wf_atom_7e8ad928(gameData) or data.UID ~= nil and gameData:__wf_atom_adfd856e(data.UID) then
		module4.ShowMessage("/Lotus/Language/Menu/WeaponLockedUnsellable")
		return false
	end

	local category = data.Category
	local v62 = false
	local count = 0
	v17:RunForAllElements(function(data2)
		if data2.Category == category and not data2.Selected then
			count += 1

			if data2.UID ~= nil and gameData:__wf_atom_adfd856e(data2.UID) then
				v62 = true
			end
		end
	end)

	if not (count < 3) or not v62 or data.Selected ~= false then
		return true
	end

	module4.ShowMessage("/Lotus/Language/Menu/LastItemOtherLockedUnsellable")
	return false
end

local function fn18(p)
	if not __wf_atom_7e8ad928(p.mClipName) then
		v17.mElementDrawCallback(p)
	end
end

local function fn19(state, count)
	local result = {}

	for k, v62 in pairs(state) do
		result[k] = v62
	end

	result.LookupId = state.Id
	result.Id = nil
	result.SellGrid = true
	result.mIndex = nil
	result.mClipName = nil
	result.mForceRedraw = nil
	result.mInitialized = nil
	result.InitDepth = nil
	result.Count = count

	if result.Card ~= nil then
		result.OverrideCardCount = true
	end

	return result
end

local function fn20(state)
	state.MarkedToSell = true
	fn18(state)
end

local function fn21(p)
	total += p
	local v62 = ""
	local v63

	if
		inventory2 == v52.FISH and not _T.FishInvInfo.ShowRep
		or inventory2 == v52.DECODONATE
		or inventory2 == v52.RESDONATE
	then
		v63 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ItemInventory_SelectPile", false)
	else
		v63 = Localize(v29, {})
		local color = module5.GetColor(9, true)
		local color2 = module5.GetColor(9, true)
		local convertColorNumberToHex = module4.ConvertColorNumberToHex(color)
		local convertColorNumberToHex2 = module4.ConvertColorNumberToHex(color2)
		local v64 = ""

		if inventory2 == v52.ENEMIES then
			v64 = module4.FormatNumber(total) .. "/" .. module4.FormatNumber(v10)
		elseif fn11() then
			local v65 = __wf_atom_7e8ad928(infoPopup_Grid) and 0 or #infoPopup_Grid.mUnfilteredElements
			v64 = module4.FormatNumber(v65) .. "/" .. module4.FormatNumber(_T.InvTradingInfo.Slots)
		elseif #v27 > 0 then
			v64 = mMovie:__wf_atom_8e9ac384(v27, true, { PRICE = module4.FormatNumber(total) })
		else
			v63 = ""
			flag8 = true
		end

		local total3 = "</font><font color=\"" .. convertColorNumberToHex2 .. "\">" .. v64 .. "</font>"
		local v66

		if inventory2 == v52.FISH then
			v66 = "</font><font color=\"" .. convertColorNumberToHex2 .. "\">" .. v64 .. "</font>"
		else
			v66 = mMovie:__wf_atom_8e9ac384(v28, false, { TOTAL = total3 })
		end

		v62 = "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. v66 .. "</p>"
	end

	mMovie:__wf_atom_50d60589("SellList.Total", 36, v63)
	mMovie:__wf_atom_50d60589("SellList.Amount", 36, v62)
end

local function fn22(data, p)
	if not __wf_atom_7e8ad928(p) then
		for i = 1, #p.LookupIds do
			if p.LookupIds[i] ~= data.Id then
				continue
			end

			table.remove(p.LookupIds, i)
			break
		end

		if #p.LookupIds == 0 then
			p.MarkedToSell = nil
		end

		fn18(p)
	end

	infoPopup_Grid:UnfocusElement(data.mIndex)

	if fn11() then
		infoPopup_Grid:RemoveUnfilteredElementById(data.Id, false, true)
	else
		infoPopup_Grid:RemoveElement(data.mIndex, false, false)
	end

	if not __wf_atom_7e8ad928(infoPopup_Grid.mScrollBar) then
		infoPopup_Grid.mScrollBar:SetScrollValue(infoPopup_Grid.mScrollBar.mCurrentScroll, false, true)
	end

	fn21(data.SellingPrice == nil and 0 or -(module4.Ternary(__wf_atom_7e8ad928(data.Count), 1, data.Count) * data.SellingPrice))
end

local function fn23(state, p, p2)
	if sell == v53.INVENTORY and not state.MarkedToSell then
		if
			(__wf_atom_7e8ad928(state.Card) or state.Card.mInstalled == nil)
			and (inventory2 ~= v52.TRADE_ITEMS or state.mModInstalledTable == nil)
		then
			if state.ArchonShards ~= nil then
				module4.ShowMessage(mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Alchemy/ArchonShardsInstalledWarning",
					false,
					{
						COUNT = module4.FormatNumber(state.ArchonShards)
					}
				))
			end
		elseif __wf_atom_7e8ad928(state.Type) or not state.Type:IsA(v) then
			module4.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ModInstalledWarning", false))
		else
			module4.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ArcaneInstalledWarning", false))
		end
	end

	if inventory2 == v52.ENEMIES then
		if _T.InfoPopup_Data ~= nil then
			_T.InfoPopup_Data.TagType = nil
			_T.InfoPopup_Data.CountOverride = v10 - total
		end
	elseif
		sell == v53.INVENTORY
		and not state.MarkedToSell
		and (inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE or fn11())
	then
		if fn11() then
			if #infoPopup_Grid.mUnfilteredElements >= _T.InvTradingInfo.Slots then
				module4.ShowErrorMessage("/Lotus/Language/Dojo/Trade_MaxSlotsReached")
				return
			end

			if state.RawItem ~= nil and not __wf_atom_7e8ad928(state.RawItem.Nemesis) then
				local flag9 = false
				infoPopup_Grid:RunForAllElements(function(p3)
					if p3.RawItem ~= nil and not __wf_atom_7e8ad928(p3.RawItem.Nemesis) then
						flag9 = true
					end
				end)

				if flag9 then
					module4.ShowErrorMessage("/Lotus/Language/Dojo/Trade_LichLimit")
					return
				end
			end
		elseif infoPopup_Grid:GetHowManyElements() >= 10 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Dojo/VaultContributionDecoTooMany",
				false,
				{ NUM = tostring(10) }
			)
			module4.ShowErrorMessage(__wf_atom_8e9ac384)
			return
		end
	elseif
		not fn11()
		and inventory2 ~= v52.FISH
		and inventory2 ~= v52.DECODONATE
		and inventory2 ~= v52.RESDONATE
		and inventory2 ~= v52.SHIP_PARTS
	then
		if
			state == nil
			or state.SellingPrice == nil
			or state.SellingPrice == 0
			or not fn17(state)
			or state.PreventSelling == true
		then
			module4.PlaySound(_G.UISound_Error)
			return
		end

		if state.Category == 18 and (__wf_atom_7e8ad928(gameData) or gameData:__wf_atom_a734151e(state.UID)) then
			module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_ResourceDroneDeployed")
			return
		end
	end

	if sell == v53.INVENTORY then
		if
			state.MarkedToSell
			or p
			or p2
			or inventory2 ~= v52.ENEMIES and (state.Count == nil or not (state.Count > 1))
		then
			if not (__wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(_T[v24])) then
				_T[v24](state)
			end

			if state.LookupIds == nil or #state.LookupIds == 0 then
				if __wf_atom_7e8ad928(p2) or p then
					if _T.SyndicateInvInfo == nil or not (state.SellingPrice > 0) then
						p2 = module4.Ternary(inventory2 == v52.ENEMIES, 5, state.Count)
					else
						local v62 = math.ceil((_T.SyndicateInvInfo.MaxRepInc - total) / state.SellingPrice)
						p2 = math.min(state.Count, v62)
					end
				end

				if inventory2 == v52.ENEMIES then
					p2 = math.min(p2, v10 - total)
				end

				if p2 > 0 then
					local total3 = 0
					local v62

					if fn11() then
						v62 = p2
						p2 = 1
					else
						v62 = 1
					end

					state.LookupIds = {}

					for _ = 1, v62 do
						local v63 = fn19(state, p2)
						infoPopup_Grid:AddElement(v63, false)
						table.insert(state.LookupIds, v63.Id)

						if state.SellingPrice ~= nil then
							total3 += p2 * state.SellingPrice
						end
					end

					if fn11() then
						infoPopup_Grid.mSortingChanged = true
						infoPopup_Grid:Redraw(nil, false, true)
					end

					fn21(total3)
					module4.PlaySound(_G.UISound_ButtonSelect)
					fn20(state)
				elseif inventory2 ~= v52.ENEMIES then
					module4.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/SystemMessages/SyndicateStandingCapped",
						false
					))
					module4.BlinkClip(mMovie, "SellList.Total")
				end
			elseif state.MarkedToSell then
				while #state.LookupIds > 0 do
					fn22(infoPopup_Grid:GetElementById(state.LookupIds[1]), state)
				end

				module4.PlaySound(_G.UISound_WindowClose)
			end
		else
			id = state.Id

			if _T.InfoPopup_Data ~= nil then
				_T.InfoPopup_Data.Callback = "OKSaveSelectedCount"

				if fn11() then
					_T.InfoPopup_Data.CountOverride = math.min(
						_T.InfoPopup_Data.Count,
						_T.InvTradingInfo.Slots - #infoPopup_Grid.mUnfilteredElements
					)
				elseif _T.SyndicateInvInfo ~= nil and state.SellingPrice > 0 then
					local v62 = _T.SyndicateInvInfo.MaxRepInc - total
					local v63 = "/Lotus/Language/SystemMessages/SyndicateStandingCapped"
					local v64 = {}

					if _T.SyndicateInvInfo.Syndicate:__wf_atom_73f36e1b() then
						local __wf_atom_bca3f82a = _T.SyndicateInvInfo.Syndicate:__wf_atom_bca3f82a()

						if __wf_atom_bca3f82a > 0 and __wf_atom_bca3f82a < 3 then
							local __wf_atom_dc1594a9 = gGameData:__wf_atom_dc1594a9(__wf_atom_bca3f82a)

							if _T.SyndicateInvInfo.MaxRepInc == __wf_atom_dc1594a9 then
								local c_str = _T.SyndicateInvInfo.Syndicate:__wf_atom_818ea3a7():c_str()
								local v65 = c_str == "/Lotus/Language/Syndicates/CetusName"
									and "/Lotus/Language/Syndicates/CetusNameInline"
									or c_str
								v64 = { SYNDICATE = Localize(v65, nil) }
								v63 = "/Lotus/Language/SystemMessages/SyndicateDailyStandingCapped"
							end
						end
					end

					local v65 = Localize(v63, v64)
					local v66 = math.ceil(v62 / state.SellingPrice)

					if v66 <= 0 then
						module4.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(v65, false))
						module4.BlinkClip(mMovie, "SellList.Total")
						return
					else
						_T.InfoPopup_Data.MaxSelectionCount = math.min(state.Count, v66)
					end
				end
			end

			mMovie:PushChildMovie(inputCountDialog)
			return
		end
	else
		fn22(state, v17:GetUnfilteredElementById(state.LookupId))
		module4.PlaySound(_G.UISound_Select)
		module4.PlaySound(_G.UISound_WindowClose)
	end

	fn16()
end

local function fn24(data)
	if data.mClipName == nil then
		return
	end

	local v62

	if data.SellGrid then
		v62 = infoPopup_Grid
		sell = v53.SELL
	else
		v62 = v17
		sell = v53.INVENTORY
	end

	local isSelected = not data.SellGrid

	if isSelected then
		if data.LookupIds == nil then
			isSelected = false
		else
			isSelected = #data.LookupIds > 0
		end
	end

	module6.OnGridItemFocusChanged(mMovie, v62, data, {
		IsFocused = true,
		IsSelected = isSelected,
		ShowInfoPopup = (not data.Locked or inventory2 ~= v52.ENEMIES) and not data.Hidden
	})
end

local function fn25(data)
	if data.mClipName ~= nil then
		local isSelected = not data.SellGrid

		if isSelected then
			if data.LookupIds == nil then
				isSelected = false
			else
				isSelected = #data.LookupIds > 0
			end
		end

		local ternary = module4.Ternary(data.SellGrid, infoPopup_Grid, v17)
		module6.OnGridItemFocusChanged(mMovie, ternary, data, {
			IsFocused = false,
			IsSelected = isSelected
		})
	end
end

local function fn26(p)
	if not __wf_atom_7e8ad928(v25) then
		v25:Execute("TransitionOut", "")
	end

	if p == nil then
		return
	end

	if not p then
		module4.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
		return
	end

	infoPopup_Grid:RemoveElements()
	fn21(-total)
	fn2()
end

local function fn27(p, p2)
	if not __wf_atom_7e8ad928(v25) then
		v25:Execute("TransitionOut", "")
	end

	if p ~= nil then
		if p then
			local elementById = v17:GetElementById(id2)

			if not __wf_atom_7e8ad928(elementById) then
				elementById.Count = p2.mQuantity
				v17:Redraw(nil, true, true)
				fn23(elementById, true)
			end
		else
			module4.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
		end
	end

	id2 = nil
end

local function fn28(data, _, p)
	sell = module4.Ternary(data.SellGrid, v53.SELL, v53.INVENTORY)

	if data.BuySlot then
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = data.StoreItem },
			CALLBACK = fn26
		}
	else
		if
			data.EmptySlot
			or data.Filler
			or data.Locked
			or data.Hidden
			or data.Plat
			or inventory2 == v52.TRADE_ITEMS and data.Card ~= nil
			or inventory2 == v52.TRADE_MODS and data.Card == nil
			or inventory2 == v52.SYNDDONATE and data.ShadowIcon
		then
			return
		end

		if inventory2 ~= v52.DECODONATE and inventory2 ~= v52.RESDONATE or data.Count ~= 0 then
			fn23(data, p)
			return
		end

		id2 = data.Id
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = data.StoreItem },
			CALLBACK = fn27
		}
	end

	v25 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
end

local function fn29(p, p2)
	module6.OnGridItemCreated(mMovie, v17, p)

	if p2 ~= nil and _T.CheckModInstalled ~= nil then
		_T.CheckModInstalled(p2)
	end
end

local function fn30(p, _)
	module6.OnGridItemCreated(mMovie, infoPopup_Grid, p)
end

local function fn31(state)
	if state.mClipName == nil or not mMovie:__wf_atom_253d7085(state.mClipName) then
		return
	end

	local isFocused = state == infoPopup_Grid:GetFocusedElement() or state == v17:GetFocusedElement()
	local isSelected = not state.SellGrid

	if isSelected then
		if state.LookupIds == nil then
			isSelected = false
		else
			isSelected = #state.LookupIds > 0
		end
	end

	local v64 = {
		HideCountThreshold = 1,
		IsFiller = state.Filler or state.EmptySlot,
		IsFocused = isFocused,
		IsSelected = isSelected
	}
	v64.OwnedInfo = {}

	if
		not state.BuySlot
		and inventory2 ~= v52.ENEMIES
		and inventory2 ~= v52.SHARDS
		and inventory2 ~= v52.DECODONATE
		and inventory2 ~= v52.RESDONATE
		and inventory2 ~= v52.SHIP_PARTS
	then
		v64.SellInfo = {}
	end

	if inventory2 == v52.PRIMEPARTS then
		v64.SellInfo.LabelType = module6.LABEL_TYPE_DUCATS
	elseif inventory2 == v52.TREASURE or inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
		v64.SellInfo.LabelType = module6.LABEL_TYPE_ENDO
	end

	if inventory2 == v52.SYNDDONATE and not state.Filler then
		v64.SellInfo.LabelType = module6.LABEL_TYPE_REPUTATION
		state.SellingPrice = state.RawItem.mStanding
		v64.HideCountThreshold = 0
		v64.OwnedInfo.mShowOne = true

		if state.Count == 0 then
			state.ShadowIcon = true
		end
	end

	if inventory2 == v52.FISH and not state.Filler then
		if _T.FishInvInfo.ShowRep then
			v64.SellInfo.LabelType = module6.LABEL_TYPE_REPUTATION
			state.SellingPrice = state.StoreItem:__wf_atom_29c757e9()
		else
			v64.SellInfo = nil
		end
	end

	if inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE then
		v64.HidePrice = state.Count ~= nil and state.Count > 0
		v64.HideCountThreshold = 0
		v64.OwnedInfo.mShowOne = true
	else
		v64.OwnedInfo.TagOverride = "/Lotus/Language/Menu/Crafting_Owned_Brief"
	end

	if state.EmptySlot then
		v64.NameOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/OpenChamber", false)
	end

	if state.BuySlot then
		v64.HideCountThreshold = 0
		v64.OwnedInfo.mShowOne = true
	end

	if state.SpecialPrice ~= nil then
		v64.SpecialPriceInfo = { LabelType = state.PriceLabelType, Price = state.SpecialPrice }
	end

	v64.Locked = state.Locked
	v64.HideLockIcon = state.HideLockIcon
	v64.LockedMsg = state.LockedMsg
	v64.HideOwned = inventory2 == v52.TRADE_MODS and not module7.IsLegendaryFusion(state.Card)
	state.NameAlpha = module4.Ternary(state.EmptySlot, 50, 100)
	local ternary = module4.Ternary(state.SellGrid, infoPopup_Grid, v17)
	module6.DrawGridItem(mMovie, ternary, state, v64)
end

local function fn32(p)
	module6.FitGridToWidth(p)
end

local function fn33(p)
	local width = mMovie:__wf_atom_5e6e15c8("SellList", 0) - mMovie:__wf_atom_5e6e15c8("InventoryGrid", 0) - 45

	if width ~= v17.Width then
		mMovie:__wf_atom_e57658c2("InventoryGrid.Bounds", 14, width)
		mMovie:__wf_atom_e57658c2("InventoryGrid.Bounds", 15, 640)
		mMovie:__wf_atom_2dedec1a("InventoryGrid.Bounds", 13, false)
		v17.Width = width
		fn32(v17)

		if not p then
			v17:Redraw(nil, true, true)
		end
	end

	v54.Materials = {
		visibleRangeMat,
		rectangleVisibleRangeMat,
		textVisibleRangeMat,
		flareVisibleRangeMat,
		_G.UIMaterial_PigmentVisibilityRange,
		_G.UIMaterial_SalvageMaterials[2]
	}

	for _, v63 in pairs(_G.UIMaterial_CosmeticEnhancersStore) do
		table.insert(v54.Materials, v63)
	end

	for _, v63 in pairs(_G.UIMaterial_FocusLensStore) do
		table.insert(v54.Materials, v63)
	end

	for _, v63 in pairs(_G.UIMaterial_ArchonShardsStore) do
		table.insert(v54.Materials, v63)
	end

	if inventory2 == v52.TRADE_MODS then
		for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
			for _, v63 in pairs(uiMaterial_Mod) do
				table.insert(v54.Materials, v63)
			end
		end

		for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
			for _, v63 in pairs(uiMaterial_ModsSyndicateIcon) do
				table.insert(v54.Materials, v63)
			end
		end
	end

	for _, v63 in ipairs(_G.UIMaterial_RailjackModStore) do
		table.insert(v54.Materials, v63)
	end

	local __wf_atom_d0fcaf32 = mMovie:__wf_atom_d0fcaf32()
	v54.Height = v17.Height
	v54.YPos = mMovie:__wf_atom_5e6e15c8("InventoryGrid", 1) + v54.Height / 2
	local visibilityCenter = module4.GetVisibilityCenter(mMovie, v54.YPos - __wf_atom_d0fcaf32 / 2)
	local visibilitySize = module4.GetVisibilitySize(mMovie, v54.Height)
	local visibilityFadeSize = module4.GetVisibilityFadeSize(mMovie, 5)

	for _, material in pairs(v54.Materials) do
		material:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
		material:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
		material:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end

	local visibilityCenter2 = module4.GetVisibilityCenter(
		mMovie,
		mMovie:__wf_atom_5e6e15c8("SellList.List", 3) + v35 / 2
	)
	local visibilitySize2 = module4.GetVisibilitySize(mMovie, v35)

	for _, v63 in pairs({
		sellListVisibleRangeMaterial,
		sellListTextVisibleRangeMaterial,
		sellListRectangleVisibleRangeMaterial
	}) do
		v63:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter2)
		v63:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize2)
		v63:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end
end

local function fn34()
	if fn11() then
		local module13 = require("Lotus.Interface.Components.CategorizedGrid")
		infoPopup_Grid = module13.CreateCategorizedGrid(mMovie, "SellList.GridItem", 2, 3)
		infoPopup_Grid:SetCallbacks("SellListItemPressed", "SellListItemFocused", "SellListItemUnfocused")
		infoPopup_Grid.mSelectedScale = 100
		infoPopup_Grid.ElementWidth = 142
		infoPopup_Grid.ElementHeight = 142
		infoPopup_Grid.Width = 350
		infoPopup_Grid.Height = 600
		infoPopup_Grid.ElementDimBuffer = 25
		infoPopup_Grid.mHighlightAlphaFocusedOverride = 24
		infoPopup_Grid.SkipReinitializePos = true
		infoPopup_Grid.mAddFillerElements = true
		module6.InitializeGridItem(mMovie, infoPopup_Grid)
		infoPopup_Grid.mOnFocusedCallback = fn24
		infoPopup_Grid.mOnUnfocusedCallback = fn25
		infoPopup_Grid.mElementDrawCallback = fn31
		infoPopup_Grid.mClipCreatedCallback = fn30

		if _T.InvTradingInfo.Plat ~= nil then
			infoPopup_Grid:AddElement({
				SellGrid = true,
				IconHeight = 80,
				IconWidth = 80,
				Plat = true,
				Count = _T.InvTradingInfo.Plat,
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeTypePlatinum", true),
				Icon = _G.UITexture_PlatinumIcon
			}, true)
		end

		for _, mod in pairs(_T.InvTradingInfo.Mods) do
			infoPopup_Grid:AddElement({ SellGrid = true, Card = mod }, true)
		end

		for _, other in pairs(_T.InvTradingInfo.Others) do
			other.SellGrid = true
			other.IsOther = true
			infoPopup_Grid:AddElement(other, true)
		end

		infoPopup_Grid:Redraw(nil, true, true)
		fn16()
		mMovie:__wf_atom_2dedec1a("SellList.ScrollBar", 13, false)
	else
		local module13 = require("EE.Interface.Components.List")
		infoPopup_Grid = module13.CreateList(mMovie, "SellList.List.Item")
		infoPopup_Grid.mForcedVerticalSeparation = 32
		infoPopup_Grid.mVisibleElements = math.floor((v35 + 10) / infoPopup_Grid.mForcedVerticalSeparation)
		infoPopup_Grid:AttachScrollBar("SellList.ScrollBar", 0)
		infoPopup_Grid.mScroll = 1
		infoPopup_Grid:EnableSmoothScroll()
		infoPopup_Grid.mInitBgWidth = mMovie:__wf_atom_5e6e15c8(infoPopup_Grid.mClipName .. ".Bg", 14)
		infoPopup_Grid.mInitBgHeight = mMovie:__wf_atom_5e6e15c8(infoPopup_Grid.mClipName .. ".Bg", 15)

		function infoPopup_Grid:UpdateColors(p, p2)
			local color = module5.GetColor(6, true)
			local color2 = module5.GetColor(7, true)
			local color3 = module5.GetColor(9, true)
			local color4 = module5.GetColor(10, true)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Cross", 44, module4.Ternary(p2, color2, color))
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, module4.Ternary(p2, color4, color))
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Price", 44, module4.Ternary(p2, color4, color3))
			mMovie:__wf_atom_4c1c1986(p.mClipName, "CrossBg", 11, color3)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 11, color3)
			p.mButton.mUnfocusedColor = color
			p.mButton:UpdateColors()
		end

		function infoPopup_Grid.mOnFocusedCallback(infoPopup_Data)
			if infoPopup_Data.mClipName == nil then
				return
			end

			sell = v53.SELL
			mMovie:__wf_atom_7f57ab2f(infoPopup_Data.mClipName, "Cross", 13, true)
			mMovie:__wf_atom_7f57ab2f(infoPopup_Data.mClipName, "CrossBg", 13, true)
			mMovie:__wf_atom_7f57ab2f(infoPopup_Data.mClipName, "Bg", 13, true)
			infoPopup_Grid:UpdateColors(infoPopup_Data, true)
			module6.SetItemInfoPopupRect(
				mMovie,
				infoPopup_Data,
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 2) + infoPopup_Data.mButton.mWidth / 2,
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 3) + infoPopup_Data.mButton.mHeight / 2,
				infoPopup_Data.mButton.mWidth,
				infoPopup_Data.mButton.mHeight
			)
			_T.InfoPopup_Data = infoPopup_Data
			_T.InfoPopup_Grid = infoPopup_Grid
		end

		function infoPopup_Grid.mOnUnfocusedCallback(p)
			if p.mClipName == nil then
				return
			end

			sell = v53.INVENTORY
			mMovie:__wf_atom_7f57ab2f(p.mClipName, "Cross", 13, false)
			mMovie:__wf_atom_7f57ab2f(p.mClipName, "CrossBg", 13, false)
			mMovie:__wf_atom_7f57ab2f(p.mClipName, "Bg", 13, false)
			infoPopup_Grid:UpdateColors(p, false)
			_T.InfoPopup_Data = nil
		end

		function infoPopup_Grid:mElementDrawCallback()
			if self.mClipName == nil then
				return
			end

			local focusedElement = infoPopup_Grid:GetFocusedElement()
			local v62

			if focusedElement == nil then
				v62 = false
			else
				v62 = focusedElement.Id == self.Id
			end

			mMovie:__wf_atom_48bd5a59(self.mClipName, "Cross", 36, "X")
			local v63 = (self.SellingPrice == nil or inventory2 == v52.ENEMIES or inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE or inventory2 == v52.SHIP_PARTS or fn11())
				and ""
				or module4.FormatNumber(self.SellingPrice * math.max(1, self.Count))
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Price", 36, v63)
			mMovie:OverrideMaterial(self.mClipName .. ".Price", sellListTextVisibleRangeMaterial)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Price", 40)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Name", 14, 345 - (__wf_atom_5e6e15c8 + 10))
			local name = self.Name

			if self.Count > 1 then
				name = module4.FormatNumber(self.Count) .. " x " .. name
			end

			local arcaneRankString = module6.GetArcaneRankString(name, self.ArcaneRank, self.ArcaneMaxRank, mMovie)
			local mButton = module10.Create(
				mMovie,
				self.mClipName .. ".ListBtn",
				arcaneRankString,
				"SellListItemPressed"
			)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "ListBtn.Label", 54, true)
			mButton:SetVisibleRangeMaterials(
				sellListVisibleRangeMaterial,
				sellListTextVisibleRangeMaterial,
				sellListRectangleVisibleRangeMaterial
			)
			mButton:SetTextAlignment("left")
			mButton:SetWidth(308)
			mButton.mToUpper = false
			mButton.mTitleCase = true
			mButton.mMinSize = 350
			mButton.mMaxSize = 350
			mButton.mInnerAlpha = 0
			mButton.mTextBuffer = 4
			mButton.mUnderlineAlpha = 0
			mButton.mFormatPrefix = "<p><font face=\"Roboto Condensed\">"
			mButton.mFormatSuffix = "</font></p>"

			function mButton.mOnFocusedCallback()
				infoPopup_Grid:FocusElementById(self.Id)
			end

			function mButton.mOnUnfocusedCallback()
				infoPopup_Grid:UnfocusElementById(self.Id)
			end

			function mButton.mOnPressedCallback()
				infoPopup_Grid:SelectElementById(self.Id)
			end

			mButton:Redraw()
			self.mButton = mButton
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Cross", 13, v62)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "CrossBg", 13, v62)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bg", 13, v62)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "CrossBg", 12, 80)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Bg", 12, 80)
			infoPopup_Grid:UpdateColors(self, v62)
		end

		mMovie:__wf_atom_e57658c2(
			"SellList.ListMask",
			15,
			infoPopup_Grid.mVisibleElements * infoPopup_Grid.mForcedVerticalSeparation
		)
	end

	infoPopup_Grid.mOnSelectedCallback = fn28
	local v62 = "SellWithManifest"
	local sellBtnLabel = "/Lotus/Language/Menu/ItemInventory_SellItems"

	if inventory2 == v52.FISH then
		sellBtnLabel = _T.FishInvInfo.SellBtnLabel
		v62 = "FishFunction"
	elseif inventory2 == v52.ENEMIES then
		sellBtnLabel = "/Lotus/Language/Menu/EnemySelector_SpawnEnemies"
		v62 = "LoadEnemies"
	elseif inventory2 == v52.TREASURE then
		sellBtnLabel = "/Lotus/Language/Menu/ItemInventory_ExtractEndo"
	elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
		sellBtnLabel = "/Lotus/Language/Menu/ItemSelection_SellSalvage"
	elseif inventory2 == v52.SHARDS then
		sellBtnLabel = "/Lotus/Language/TennoWay/ConvertShardsSellBtn"
		v62 = "ConvertShards"
	elseif inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE then
		sellBtnLabel = "/Lotus/Language/OstronCrafting/Crafting_Donate"
		v62 = "DonateDecorations"
	elseif inventory2 == v52.SYNDDONATE then
		sellBtnLabel = "/Lotus/Language/Syndicates/Favors_RedeemReward"
		v62 = "DonateDogTags"
	elseif fn11() then
		sellBtnLabel = "/Lotus/Language/Dojo/Trade_Offer"
		v62 = "TradeItems"
	end

	v18 = module10.Create(mMovie, "SellList.SellBtn", sellBtnLabel, v62)
	v18:SetSpecialMode()
	v18:SetWidth(280)
	v18:SetActive(false)
	v18:Redraw()
end

local function fn35(p)
	v49[p.mItemId.mId] = true
end

local function fn36()
	v49 = {}

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local inventory3 = gGameData:GetInventory()
	local mId = inventory3:__wf_atom_bab6e265().mId
	local __wf_atom_bae92715 = inventory3:__wf_atom_bae92715()
	local v62 = nil

	for _, v64 in ipairs(__wf_atom_bae92715) do
		if v64.mItemId.mId ~= mId then
			continue
		end

		v62 = v64
		break
	end

	if v62 == nil and #__wf_atom_bae92715 > 0 then
		v62 = __wf_atom_bae92715[1]
	end

	if not __wf_atom_7e8ad928(v62) then
		fn35(v62:__wf_atom_21ed1a39(0, 0))
		fn35(v62:__wf_atom_21ed1a39(0, 2))
		fn35(v62:__wf_atom_21ed1a39(1, 0))
		local __wf_atom_eb82ab1f = v62:__wf_atom_eb82ab1f()
		fn35(__wf_atom_eb82ab1f:__wf_atom_d78fd481(7))
		fn35(__wf_atom_eb82ab1f:__wf_atom_d78fd481(8))
		fn35(__wf_atom_eb82ab1f:__wf_atom_d78fd481(10))
		fn35(__wf_atom_eb82ab1f:__wf_atom_d78fd481(9))
	end
end

local function fn37()
	fn36()
	mMovie:__wf_atom_e57658c2(
		"InventoryGrid",
		0,
		mMovie:__wf_atom_5e6e15c8("Categories", 0) + mMovie:__wf_atom_5e6e15c8("Categories.Menu", 0)
	)
	local module13 = require("Lotus.Interface.Components.CategorizedGrid")
	v17 = module13.CreateCategorizedGrid(
		mMovie,
		"InventoryGrid.InventoryItem",
		6,
		4,
		"Categories.Menu",
		"SearchAndSort.SortMenu"
	)
	v17:SetCallbacks(nil, "GridItemFocused", "GridItemUnfocused", "GridItemPressed")
	v17.mSelectedScale = 100
	v17.mColumnSeparation = 160
	v17.mRowSeparation = 160
	v17.mSmoothScrollExtraSpace = 0
	v17.mScrollAlwaysVisible = true
	v17:AttachScrollBar("InventoryGridScrollBar", 1)
	v17.mScrollBarHorizontalOffset = nil
	v17.mSortMenuHorizontalOffset = nil
	v17.mSortMenuVerticalOffset = nil
	v17:EnableSmoothScroll()
	v17.mSelectElementsOnFocus = false
	v17.mScroll = 1
	v17.mSkipRefocusOnScrollRedraw = true
	v17.mOnFocusedCallback = fn24
	v17.mOnUnfocusedCallback = fn25
	v17.mOnSelectedCallback = fn28
	v17.mElementDrawCallback = fn31
	v17.mClipCreatedCallback = fn29
	v17.RectangleVisibleRangeMaterial = rectangleVisibleRangeMat
	v17.VisibleRangeMaterial = visibleRangeMat
	v17.TextVisibleRangeMaterial = textVisibleRangeMat
	v17.FlareVisibleRangeMaterial = flareVisibleRangeMat
	v17.mSortMenu:SetWidth(200)
	v17.ElementWidth = v55
	v17.ElementHeight = v55
	v17.Width = 1000
	v17.Height = 650
	v17.ElementDimBuffer = 10
	v17.ElementHeightBuffer = 25
	v17.mHighlightAlphaFocusedOverride = 24
	v17.mUseCornerForSelected = true
	v17.CanPreviewElements = inventory2 ~= v52.ENEMIES
		and inventory2 ~= v52.SHIP_SCRAP
		and inventory2 ~= v52.SHIP_PARTS
		and inventory2 ~= v52.SHIP_RAW

	if inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
		v17.mShowLabels = true
	end

	module6.InitializeGridItem(mMovie, v17)

	if v17.mCategoryMenu ~= nil then
		v17.mCategoryMenu.mAlign = module4.LEFT_ALIGNED
		v17.mCategoryMenu.mHideEmptyCategories = true
		v17.mCategoryMenu.mTryFitToGridWidth = true
		v17.mCategoryMenu.mFitGridWidthPadding = 21
		v17.mCategoryMenu.mFitGridWidthReduction = 420
	end

	v17.mInitCategoriesYPos = mMovie:__wf_atom_5e6e15c8("Categories", 1)
	v17.mInitSearchSortYPos = mMovie:__wf_atom_5e6e15c8("SearchAndSort", 1)
	v17._InventoryGrid_Redraw = v17.Redraw

	function v17:Redraw(p, p2, p3, p4, p5)
		self:_InventoryGrid_Redraw(p, p2, p3, p4, p5)
		local v64 = self.mInitCategoriesYPos + module4.Ternary(self.mCategoryMenu.mIsFitToGridWidth, 5, 0)
		local v65 = self.mInitSearchSortYPos + module4.Ternary(self.mCategoryMenu.mIsFitToGridWidth, -30, 0)

		if __wf_atom_7e8ad928(v15) then
			mMovie:__wf_atom_e57658c2("Categories", 1, v64)
			mMovie:__wf_atom_e57658c2("SearchAndSort", 1, v65)
		else
			v15:ChangeOriginalCoords("Categories", nil, v64)
			v15:ChangeOriginalCoords("SearchAndSort", nil, v65)
			v15:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
		end
	end

	function v17.PreviewCallback(object)
		local focusedElement = object:GetFocusedElement()

		if __wf_atom_7e8ad928(focusedElement) or __wf_atom_7e8ad928(mMovie) then
			return
		end

		if focusedElement.SortCategory == 26 then
			if __wf_atom_7e8ad928(focusedElement.RawItem) then
				return
			end

			v25 = mMovie:PushChildMovie(kubrowPreviewMovie)
			v25:Execute("SetTitle", "")

			function _T.OnPreviewClose()
				_T.OnPreviewClose = nil
				_T.GetAllPrints = nil
				v47 = true

				if not __wf_atom_7e8ad928(_T.ShowBackground) then
					_T.ShowBackground(0, nil, false)
				end
			end

			v25:Execute("SetOnTransitionOutFunction", "OnPreviewClose")

			function _T.GetAllPrints()
				local v64 = {}
				table.insert(v64, { Print = focusedElement.RawItem })
				return v64
			end

			v25:Execute("SetElementsFunction", "GetAllPrints")

			if not __wf_atom_7e8ad928(_T.HideBackground) then
				_T.HideBackground()
			end
		elseif focusedElement.SortCategory == 100 then
			if __wf_atom_7e8ad928(focusedElement.RawItem) then
				return
			end

			if focusedElement.RawItem ~= nil and not __wf_atom_7e8ad928(focusedElement.RawItem.Nemesis) then
				_T.Nemesis_HistoryEntry = focusedElement.RawItem.Nemesis
			end

			function _T.OnNemesisClosed()
				_T.OnNemesisClosed = nil
				v47 = true

				if not __wf_atom_7e8ad928(_T.ShowBackground) then
					_T.ShowBackground(0, nil, false)
				end
			end

			v25 = mMovie:PushChildMovie(nemesisMovie)
			v25:Execute("SetCallback", "OnNemesisClosed")
		else
			if __wf_atom_7e8ad928(focusedElement.StoreItem) then
				return
			end

			local modularInfo = not __wf_atom_7e8ad928(focusedElement.Type)
				and focusedElement.Type:IsA(__wf_atom_1bef9e62)
				and not __wf_atom_7e8ad928(focusedElement.RawItem)
				and focusedElement.RawItem.mModularParts ~= nil
				and {
					Gild = focusedElement.RawItem:__wf_atom_717d3c58(4),
					Parts = focusedElement.RawItem.mModularParts
				}
				or nil
			_T.marketDetailedViewParms = {
				ITEM = {
					ModularInfo = modularInfo,
					StoreItem = focusedElement.StoreItem,
					CanPurchaseOverride = false
				}
			}
			v25 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
		end

		v47 = false
	end

	function v17.AdditionalFilterFunction(data)
		if
			v32 and not (data.SellingPrice or data.BuySlot or data.EmptySlot)
			or v17.mFilterBy == v58.ALL and data.BuySlot
		then
			return true
		end

		if v31.mLabel == nil or v31.mLabel == "" then
			return false
		end

		return string.find(data.SearchCache, __wf_atom_d99ae0ec(v31.mLabel), 1, true) == nil
	end

	local hasCompletedQuest = module3.HasCompletedQuest(secondDreamQuest)
	local v64 = false

	if not __wf_atom_7e8ad928(gameData) then
		local inventory3 = gameData:GetInventory()

		if not (hasCompletedQuest or __wf_atom_7e8ad928(inventory3)) then
			local __wf_atom_c84817dd = inventory3:__wf_atom_c84817dd()

			for i = 1, #__wf_atom_c84817dd do
				if not (__wf_atom_c84817dd[i].mItemType:IsA(__wf_atom_f6dea198) and __wf_atom_c84817dd[i].mItemCount > 0) then
					continue
				end

				v64 = true
				break
			end
		end
	end

	local v65 = {}

	if inventory2 == v52.TRADE_MODS then
		v65 = module7.GetCollectionCategories(false, true, true)
	elseif inventory2 == v52.PRIMEPARTS then
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/PRIME",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.PRIME
		})
	elseif inventory2 == v52.TREASURE or inventory2 == v52.SHARDS then
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/MISC",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.MISC
		})
	elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/CategoryAll",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.ALL
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/CREWSHIP_WEAPONS_MKI",
			Icon = categoryIcons[27],
			Category = v58.MKI
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/CREWSHIP_WEAPONS_MKII",
			Icon = categoryIcons[28],
			Category = v58.MKII
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/CREWSHIP_WEAPONS_MKIII",
			Icon = categoryIcons[29],
			Category = v58.MKIII
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/AP_TACTIC_RAILJACK",
			Icon = categoryIcons[30],
			Category = v58.LAVAN
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/AP_ATTACK_RAILJACK",
			Icon = categoryIcons[31],
			Category = v58.VIDAR
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/AP_DEFENSE_RAILJACK",
			Icon = categoryIcons[32],
			Category = v58.ZEKTI
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/AP_UNIVERSAL_RAILJACK",
			Icon = categoryIcons[33],
			Category = v58.SIGMA
		})
	elseif inventory2 == v52.FISH then
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/CategoryAll",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.ALL
		})
		table.insert(v65, {
			Name = "/Lotus/Language/UiElements/SelectAllFishCategorySmall",
			Icon = categoryIcons[17],
			Category = v59.FISH_SMALL
		})
		table.insert(v65, {
			Name = "/Lotus/Language/UiElements/SelectAllFishCategoryMedium",
			Icon = categoryIcons[18],
			Category = v59.FISH_MEDIUM
		})
		table.insert(v65, {
			Name = "/Lotus/Language/UiElements/SelectAllFishCategoryLarge",
			Icon = categoryIcons[19],
			Category = v59.FISH_LARGE
		})
	elseif inventory2 == v52.ENEMIES then
		table.insert(v65, {
			Category = v58.ALL,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAll", false),
			Icon = _G.UICategoryIcon_AllOn
		})
		table.insert(v65, {
			Category = v58.GRINEER,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_GrineerUC", false),
			Icon = _G.UICategoryIcon_GrineerOn
		})
		table.insert(v65, {
			Category = v58.CORPUS,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_CorpusUC", false),
			Icon = _G.UICategoryIcon_CorpusOn
		})
		table.insert(v65, {
			Category = v58.INFESTED,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_InfestationUC", false),
			Icon = _G.UICategoryIcon_InfestedOn
		})
		table.insert(v65, {
			Category = v58.WILD,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_WildUC", false),
			Icon = _G.UICategoryIcon_WildOn
		})
		table.insert(v65, {
			Category = v58.OROKIN,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_OrokinUC", false),
			Icon = _G.UICategoryIcon_OrokinOn
		})
		table.insert(v65, {
			Category = v58.SENTIENT,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_SentientUC", false),
			Icon = _G.UICategoryIcon_SentientOn
		})
		table.insert(v65, {
			Category = v58.NARMER,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Factions/Faction_NewWarNarmerUC", false),
			Icon = _G.UICategoryIcon_NarmerOn
		})
	elseif inventory2 == v52.DECODONATE then
		table.insert(v65, {
			Category = v60.ALL,
			Name = Localize("/Lotus/Language/Menu/CategoryAll", {}),
			Icon = _G.UICategoryIcon_AllOn
		})
		table.insert(v65, {
			Category = v60.AYATAN,
			Name = Localize("/Lotus/Language/FusionTreasure/FusionTreasureMgr_Title", {}),
			Icon = _G.UICategoryIcon_FusionTreasuresOn
		})
		table.insert(v65, {
			Category = v60.NOGGLES,
			Name = Localize("/Lotus/Language/Categories/Noggles", {}),
			Icon = _G.UICategoryIcon_NogglesOn
		})
		table.insert(v65, {
			Category = v60.FRAMES,
			Name = Localize("/Lotus/Language/Categories/PictureFrames", {}),
			Icon = _G.UICategoryIcon_DisplaysOn
		})
		table.insert(v65, {
			Category = v60.RESOURCES,
			Name = Localize("/Lotus/Language/Categories/RESOURCES", {}),
			Icon = _G.UICategoryIcon_MaterialsOn
		})
		table.insert(v65, {
			Category = v60.COMPANIONS,
			Name = Localize("/Lotus/Language/Menu/Store_Companions", {}),
			Icon = _G.UICategoryIcon_CompanionsOn
		})
		table.insert(v65, {
			Category = v60.MISC,
			Name = Localize("/Lotus/Language/Categories/MISC", {}),
			Icon = _G.UICategoryIcon_MiscOn
		})
	elseif inventory2 == v52.SYNDDONATE then
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/CategoryAll",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.ALL
		})
	else
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/CategoryAll",
			Icon = _G.UICategoryIcon_AllOn,
			Category = v58.ALL
		})

		if not fn11() then
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Store_Warframes",
				Icon = categoryIcons[2],
				Category = v58.WARFRAME
			})
		end

		table.insert(v65, {
			Name = "/Lotus/Language/Menu/ItemInventory_Weapons",
			Icon = categoryIcons[3],
			Category = v58.WEAPONS
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Menu/Global_ProductCategory_Robotics",
			Icon = categoryIcons[4],
			Category = v58.SENTINEL
		})

		if fn11() then
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Archwing_Weapons",
				Icon = categoryIcons[14],
				Category = v58.ARCHWINGWEAPONS
			})
		end

		table.insert(v65, {
			Name = "/Lotus/Language/Categories/APPEARANCE",
			Icon = categoryIcons[5],
			Category = v58.APPEARANCE
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/ENHANCEMENTS",
			Icon = categoryIcons[6],
			Category = v58.ENHANCEMENTS
		})

		if hasCompletedQuest or v64 then
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Focus",
				Icon = categoryIcons[7],
				Category = v58.FOCUS
			})
		end

		table.insert(v65, {
			Name = "/Lotus/Language/Categories/GEAR",
			Icon = categoryIcons[9],
			Category = v58.GEAR
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/KEYS",
			Icon = categoryIcons[10],
			Category = v58.KEYS
		})

		if inventory2 ~= v52.RESDONATE then
			table.insert(v65, {
				Name = "/Lotus/Language/Categories/RESOURCES",
				Icon = categoryIcons[11],
				Category = v58.RESOURCES
			})
		end

		table.insert(v65, {
			Name = "/Lotus/Language/Categories/PRIME",
			Icon = categoryIcons[12],
			Category = v58.PRIME
		})

		if inventory2 == v52.INVENTORY or inventory2 == v52.TRADE_ITEMS then
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/ImprintCreator",
				Icon = _G.UICategoryIcon_ImprintsOn,
				Category = v58.PETPRINTS
			})
		end

		if fn11() then
			table.insert(v65, {
				Name = "/Lotus/Language/FusionTreasure/FusionTreasureMgr_Title",
				Icon = _G.UICategoryIcon_FusionTreasuresOn,
				Category = v60.AYATAN
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Crafting_Blueprints",
				Icon = _G.UICategoryIcon_RecipesOn,
				Category = v58.RECIPES
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Dojo/Trade_LichCategory",
				Icon = categoryIcons[21],
				Category = v58.LICH
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Railjack/Avionics",
				Icon = categoryIcons[25],
				Category = v58.AVIONICS
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Loadout_Emotes",
				Icon = categoryIcons[35],
				Category = v58.EMOTE
			})
		else
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Loadout_Vehicles",
				Icon = categoryIcons[13],
				Category = v58.ARCHWING
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Menu/Archwing_Weapons",
				Icon = categoryIcons[14],
				Category = v58.ARCHWINGWEAPONS
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Necromech/MechPluralCategoryName",
				Icon = categoryIcons[34],
				Category = v58.MECHS
			})
			table.insert(v65, {
				Name = "/Lotus/Language/Categories/AMPS",
				Icon = categoryIcons[16],
				Category = v58.OPERATORAMPS
			})
		end

		table.insert(v65, {
			Name = "/Lotus/Language/Categories/RELICS",
			Icon = categoryIcons[20],
			Category = v58.RELICS
		})
		table.insert(v65, {
			Name = "/Lotus/Language/Categories/MISC",
			Icon = categoryIcons[15],
			Category = v58.MISC
		})
	end

	for _, v66 in ipairs(v65) do
		v66.Name = string.upper(mMovie:__wf_atom_8e9ac384(v66.Name, false))
		v17:AddCategory(v66)
	end

	local function fn38(data, data2)
		if data.EmptySlot or data2.EmptySlot then
			return data.EmptySlot ~= true
		end

		if data2.BuySlot or data.BuySlot then
			return data2.BuySlot ~= true
		end

		if #data.Name == 0 or #data2.Name == 0 then
			return #data.Name ~= 0
		end

		if data.SearchRank == nil or data2.SearchRank == nil or data.SearchRank == data2.SearchRank then
			return nil
		end

		return data.SearchRank > data2.SearchRank
	end

	if inventory2 == v52.TRADE_MODS then
		local collectionSortBy = module7.GetCollectionSortBy()

		for i = 1, #collectionSortBy do
			local attribute = collectionSortBy[i].Attribute

			collectionSortBy[i].Attribute = function(p, p2)
				local v66 = fn38(p, p2)

				if v66 == nil then
					return (attribute(p, p2))
				end

				return v66
			end

			v17:AddSortBy(collectionSortBy[i])
		end
	else
		v17:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false),
			SortId = "NAME",
			Attribute = function(p, p2)
				local v66 = fn38(p, p2)

				if v66 == nil then
					return p.Name < p2.Name
				end

				return v66
			end
		})
	end

	if inventory2 == v52.ENEMIES then
		v17:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Scanned", false),
			SortId = "SCAN",
			Attribute = function(p, p2)
				local v66 = fn38(p, p2)

				if v66 ~= nil then
					return v66
				end

				if p.Locked == p2.Locked then
					return p.Name < p2.Name
				end

				return p2.Locked
			end
		})
		return
	end

	if inventory2 ~= v52.FISH and inventory2 ~= v52.DECODONATE and inventory2 ~= v52.RESDONATE then
		if inventory2 == v52.SYNDDONATE then
			v17:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/TradeValue", false),
				SortId = "SELL_PRICE",
				Attribute = function(p, p2)
					local v66 = fn38(p, p2)

					if v66 ~= nil then
						return v66
					end

					if p.SellingPrice == p2.SellingPrice then
						return p.Name < p2.Name
					end

					if p.SellingPrice == nil or p2.SellingPrice == nil then
						return p2.SellingPrice == nil
					end

					return p.SellingPrice > p2.SellingPrice
				end
			})
		else
			v17:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/SellingPrice", false),
				SortId = "SELL_PRICE",
				Attribute = function(p, p2)
					local v66 = fn38(p, p2)

					if v66 ~= nil then
						return v66
					end

					if p.SellingPrice == p2.SellingPrice then
						return p.Name < p2.Name
					end

					if p.SellingPrice == nil or p2.SellingPrice == nil then
						return p2.SellingPrice == nil
					end

					return p.SellingPrice > p2.SellingPrice
				end
			})
		end
	end

	if inventory2 ~= v52.SHIP_SCRAP and inventory2 ~= v52.SHIP_PARTS then
		v17:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Owned", false),
			SortId = "COUNT",
			Attribute = function(p, p2)
				local v66 = fn38(p, p2)

				if v66 ~= nil then
					return v66
				end

				if p.Count == p2.Count then
					return p.Name < p2.Name
				end

				if p.Count == nil or p2.Count == nil then
					return p2.Count == nil
				end

				return p.Count > p2.Count
			end
		})
		return
	end

	v17:AddSortBy({
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Level", false),
		SortId = "MK_TIER",
		Attribute = function(p, p2)
			local v66 = fn38(p, p2)

			if v66 ~= nil then
				return v66
			end

			if p.Tier == p2.Tier then
				return p.Name < p2.Name
			end

			if p.Tier ~= nil and p2.Tier ~= nil then
				return p.Tier > p2.Tier
			end

			return p.Tier ~= nil and p2.Tier == nil
		end
	})
	v17:AddSortBy({
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Type", false),
		SortId = "BRAND",
		Attribute = function(p, p2)
			local v66 = fn38(p, p2)

			if v66 ~= nil then
				return v66
			end

			if p.Brand == p2.Brand then
				return p.Name < p2.Name
			end

			if p.Brand ~= nil and p2.Brand ~= nil then
				return p.Brand < p2.Brand
			end

			return p.Brand ~= nil and p2.Brand == nil
		end
	})
end

local function fn38(storeItemInfos, p, p2)
	if
		(p == v58.WARFRAME or p == v58.WEAPONS or p == v58.SENTINEL or p == v58.ARCHWING or p == v58.ARCHWINGWEAPONS or p == v58.OPERATORAMPS or p == v58.MECHS)
		and not fn11()
	then
		local v62 = ""

		if p == v58.WARFRAME then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/SuitSlotItem")
		elseif p == v58.WEAPONS then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/TwoWeaponSlotItem")
		elseif p == v58.SENTINEL then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/TwoSentinelSlotItem")
		elseif p == v58.ARCHWING then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/SpaceSuitSlotItem")
		elseif p == v58.ARCHWINGWEAPONS then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/TwoSpaceWeaponSlotItem")
		elseif p == v58.OPERATORAMPS then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/TwoOperatorWeaponSlotItem")
		elseif p == v58.MECHS then
			v62 = WeakResource("/Lotus/Types/StoreItems/SlotItems/MechSlotItem")
		end

		if not __wf_atom_7e8ad928(v3) and p2 ~= nil then
			local __wf_atom_232fd31d = v3:__wf_atom_232fd31d(v62)

			if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				local storeItemInfo = module2.GetStoreItemInfo(mMovie, __wf_atom_232fd31d)
				storeItemInfo.Icon = slotPurchaseTexture
				storeItemInfo.IconColor = 9
				storeItemInfo.IconWidth = 100
				storeItemInfo.IconHeight = 100
				storeItemInfo.BuySlot = true
				storeItemInfo.EmptyCount = p2
				storeItemInfo.Count = p2
				table.insert(storeItemInfos, storeItemInfo)
				p2 = 0
			end
		end
	end

	local function fn39(p3)
		if p3.mUpgrade.mItemId.mId ~= nil and p3.mUpgrade.mItemId.mId ~= "" then
			p3.mInstalled = v36[p3.mUpgrade.mItemId.mId]
			return
		end

		p3.mInstalled = v36[tostring(p3.mUpgrade.mItemType:__wf_atom_5b41f63b())]
	end

	local v62 = {}

	if inventory2 == v52.SHIP_SCRAP then
		local __wf_atom_9128fbc5 = gGameData:__wf_atom_9128fbc5()

		for i = 1, #__wf_atom_9128fbc5 do
			if module3.GetResearchProgress(__wf_atom_9128fbc5[i]) > 0 then
				v62[__wf_atom_9128fbc5[i].mCategoryItemId.mId] = true
			end
		end
	end

	for i = 1, #storeItemInfos + module4.Ternary(p2 == nil, 0, p2) do
		__wf_atom_83c14687(0)
		local v63 = storeItemInfos[i]
		local v64 = v63 == nil and { EmptySlot = true } or v63

		if inventory2 == v52.TRADE_MODS then
			v64.Card = module7.CardFromArtifact(v64.RawItem)
			fn39(v64.Card)
		elseif inventory2 == v52.TRADE_ITEMS and not __wf_atom_7e8ad928(v64.Type) and v64.Type:IsA(v) then
			local cardFromArtifact = module7.CardFromArtifact(v64.RawItem)
			fn39(cardFromArtifact)
			v64.mModInstalledTable = cardFromArtifact.mInstalled
		elseif __wf_atom_7e8ad928(v64.Type) or not v64.Type:IsA(v2) then
			if
				inventory2 == v52.SHIP_SCRAP
				and not __wf_atom_7e8ad928(v64.RawItem)
				and v62[v64.RawItem.mItemId.mId]
			then
				v64.Locked = true
				v64.LockedMsg = "/Lotus/Language/Railjack/WreckageLimit_Repairing"
			end
		else
			local cardFromArtifact = module7.CardFromArtifact(v64.RawItem)
			fn39(cardFromArtifact)
			v64.mModDescOverride = cardFromArtifact.mDesc
			v64.mModInstalledTable = cardFromArtifact.mInstalled

			if _T.CheckShipModInstalled ~= nil then
				_T.CheckShipModInstalled(v64)
			end

			if v64.Installed then
				v64.Locked = true
				v64.HideLockIcon = true

				if v64.Count > 1 then
					v64.LockedMsg = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Railjack/Inventory_EquippedWithCount",
						false,
						{ COUNT = module4.FormatNumber(1) }
					)
				else
					v64.LockedMsg = "/Lotus/Language/Menu/ItemSelection_Equipped"
				end
			end
		end

		if __wf_atom_7e8ad928(v64.StoreItem) then
			v64.SearchCache = ""
		else
			local name = v64.Name

			if v64.Card ~= nil then
				name = v64.Card.mName
			end

			v64.SearchCache = module2.GetSearchString(mMovie, v64.StoreItem, name, v64.SearchTags)

			if inventory2 == v52.TRADE_MODS then
				v64.SearchCache ..= " " .. __wf_atom_d99ae0ec(v64.Card.mDesc)
			end
		end

		if inventory2 == v52.TRADE_MODS then
			v64.CanPreviewOverride = false
			module7.AddToCollectionGrid(v17, nil, v64)
		else
			if inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
				v64.Categories = { v58.ALL }

				if v64.StoreItem ~= nil then
					local categoriesForShipPartStoreItem, brand = module2.GetCategoriesForShipPartStoreItem(
						v64.StoreItem,
						v58
					)
					v64.Tier = categoriesForShipPartStoreItem
					v64.Brand = brand

					if v64.Tier ~= nil then
						table.insert(v64.Categories, v64.Tier)
					end

					if v64.Brand ~= nil then
						table.insert(v64.Categories, v64.Brand)
					end
				end
			else
				v64.Categories = { p }
			end

			if v64.AdditionalCategories ~= nil then
				for _, additionalCategory in ipairs(v64.AdditionalCategories) do
					table.insert(v64.Categories, additionalCategory)
				end
			end

			v64.CanPreviewOverride = v64.SortCategory == 26
				or v64.SortCategory == 100
				or not __wf_atom_7e8ad928(v64.StoreItem)
			v17:AddElement(v64, true)
		end

		if not fn11() or v64.EmptySlot then
			continue
		end

		local __wf_atom_5b41f63b = v64.Type:__wf_atom_5b41f63b()

		if v64.SortCategory == 34 then
			__wf_atom_5b41f63b = v64.RawItem:__wf_atom_4b2b635c()
		end

		if _T.InvTradingInfo.State[__wf_atom_5b41f63b] == nil then
			continue
		end

		local v65 = _T.InvTradingInfo.State[__wf_atom_5b41f63b]
		local v66 = false

		if #v65.Ids > 0 then
			local mId = nil

			if not __wf_atom_7e8ad928(v64.RawItem) then
				if __wf_atom_7e8ad928(v64.RawItem.Nemesis) then
					if v64.RawItem.mItemId ~= nil then
						mId = v64.RawItem.mItemId.mId
					end
				else
					mId = __wf_atom_3b93b4a7(v64.RawItem.Nemesis:__wf_atom_91d9f0e3())
				end
			end

			if mId ~= nil then
				for j = 1, #v65.Ids do
					if v65.Ids[j] ~= mId then
						continue
					end

					fn23(v64, nil, 1)
					v66 = true
					break
				end
			end
		end

		if
			v66
			or not (v65.Count > 0)
			or not (__wf_atom_7e8ad928(v64.RawItem) or v64.RawItem.mItemId == nil or v64.RawItem.mItemId.mId == "")
		then
			continue
		end

		fn23(v64, nil, v65.Count)
	end
end

local function fn39(category)
	local result = nil

	if inventory2 == v52.SHARDS then
		return (_T.GetShards())
	end

	if inventory2 == v52.SYNDDONATE then
		local __wf_atom_eccf784f = _T.SyndicateInvInfo.Syndicate:__wf_atom_eccf784f()
		local vendorTag = _T.SyndicateInvInfo.VendorTag
		local result2 = {}

		for _, v62 in ipairs(__wf_atom_eccf784f) do
			if v62.mTag == EMPTY_SYMBOL or v62.mTag == vendorTag then
				table.insert(result2, v62)
			end
		end

		return result2
	else
		if inventory2 == v52.SHIP_RAW then
			return (inventory:__wf_atom_edc4bb45())
		end

		if category == 43 then
			return (module4.Ternary(
				inventory2 == v52.SHIP_SCRAP,
				inventory:__wf_atom_3c62d484(),
				inventory:__wf_atom_6ca9b7b7()
			))
		elseif category == 46 then
			return (module4.Ternary(
				inventory2 == v52.SHIP_SCRAP,
				inventory:__wf_atom_f0557cc8(),
				inventory:__wf_atom_f976c704()
			))
		elseif category == 0 then
			return (inventory:__wf_atom_20b04548())
		elseif category == 1 then
			return (inventory:__wf_atom_4f67b86c())
		elseif category == 2 then
			return (inventory:__wf_atom_6b29f1ed())
		end

		if category == 3 then
			result = inventory:__wf_atom_ebdc4e6e()

			if not arsenal_ForceUmbraUnlock then
				for i = #result, 1, -1 do
					if result[i].mItemType == excaliburUmbraType then
						table.remove(result, i)
					end
				end

				return result
			end
		elseif category == 5 then
			result = inventory:__wf_atom_4259c789()

			if not arsenal_ForceUmbraSwordUnlock then
				for i = #result, 1, -1 do
					if result[i].mItemType == excaliburUmbraMeleeType then
						table.remove(result, i)
					end
				end

				return result
			end
		else
			if category == 6 then
				return (inventory:__wf_atom_71d5cc00())
			end

			if category == 11 then
				if inventory2 ~= v52.RESDONATE or __wf_atom_7e8ad928(v3) then
					return (inventory:__wf_atom_c84817dd())
				end

				local storeItems = v3:GetStoreItems()
				local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()
				local v62 = {}
				local result2 = {}

				for i = 1, #__wf_atom_c84817dd do
					local v63 = __wf_atom_c84817dd[i]
					v62[v63.mItemType:__wf_atom_5b41f63b()] = true
					table.insert(result2, v63)
				end

				for i = 1, #storeItems do
					local storeItem = storeItems[i]

					if not (storeItem:ShowInMarket() and v62[storeItem:GetItem():__wf_atom_5b41f63b()] == nil) then
						continue
					end

					table.insert(result2, SF.CountedItem(storeItem:GetItem(), 0))
				end

				return result2
			elseif category == 4 then
				local v62 = { inventory:__wf_atom_063f1444(), (inventory:GetUpgrades()) }
				local result2 = {}

				for i = 1, #v62 do
					for _, v63 in pairs(v62[i]) do
						local isA = v63.mItemType:IsA(v)

						if inventory2 == v52.TRADE_MODS and not isA or inventory2 ~= v52.TRADE_MODS and isA then
							table.insert(result2, v63)
						end
					end
				end

				return result2
			elseif category == 13 then
				local __wf_atom_49479502 = inventory:__wf_atom_49479502()
				local v62 = WeakResource("/Lotus/Types/Recipes/AbilityOverrides/BaseAbilityOverrideBlueprint")
				local result2 = {}

				for i = 1, #__wf_atom_49479502 do
					if not __wf_atom_49479502[i].mItemType:IsA(v62) then
						table.insert(result2, __wf_atom_49479502[i])
					end
				end

				return result2
			else
				if category == 15 then
					return (inventory:__wf_atom_db1ae7f4())
				end

				if category == 24 then
					local __wf_atom_9ddc0f59 = inventory:__wf_atom_9ddc0f59()
					local result2 = {}

					for i = 1, #__wf_atom_9ddc0f59 do
						if
							__wf_atom_9ddc0f59[i].mDetails.mStatus ~= 0
							and __wf_atom_9ddc0f59[i].mDetails.mStatus ~= 1
						then
							table.insert(result2, __wf_atom_9ddc0f59[i])
						end
					end

					return result2
				else
					if category == 16 then
						return (inventory:__wf_atom_1273f04d())
					elseif category == 17 then
						return (inventory:__wf_atom_8844017b())
					elseif category == 18 then
						return (inventory:__wf_atom_2ca27e15())
					elseif category == 27 then
						return (inventory:__wf_atom_ff7d29fb())
					elseif category == 28 then
						return (inventory:__wf_atom_546ac461())
					elseif category == 29 then
						return (inventory:__wf_atom_50f906c7())
					elseif category == 48 then
						return (inventory:__wf_atom_a76bb6ec())
					end

					if category == 34 then
						local treasureTable = module2.BuildTreasureTable(
							inventory:__wf_atom_7734c6aa(),
							mMovie,
							v3,
							v60,
							true,
							inventory2 == v52.TREASURE
						)
						local result2 = {}

						for _, v62 in pairs(treasureTable) do
							v62.mItemType = v62.Type
							table.insert(result2, v62)
						end

						return result2
					else
						if category == 39 then
							return (inventory:__wf_atom_260a9632())
						elseif category == 25 then
							return result
						elseif category == 26 then
							return (inventory:__wf_atom_90d72e37())
						elseif category == 37 then
							return (inventory:__wf_atom_9683bef6())
						elseif category == 30 then
							return (module2.GetShipDecoItems(mMovie, gGameData, false, true))
						elseif category == 41 then
							return (inventory:__wf_atom_072f6737())
						elseif category == 50 then
							return (inventory:__wf_atom_95117674())
						end

						if category == 10 then
							local __wf_atom_da43e3f3 = inventory:__wf_atom_da43e3f3()
							result = {}

							for i = 1, #__wf_atom_da43e3f3 do
								if __wf_atom_da43e3f3[i].mItemType:IsA(__wf_atom_9ae7d6a1) then
									table.insert(result, __wf_atom_da43e3f3[i])
								end
							end
						end
					end
				end
			end
		end

		return result
	end
end

local function fn40(p, category, p2)
	if v40[p] == nil then
		v40[p] = { Category = category, Elements = {} }
	end

	table.insert(v40[p].Elements, p2)
end

local function fn41()
	local total3 = 0

	if v38 == 1 then
		while total3 < 75 and (#v41.Elements > 0 or #v39 > 0) do
			if #v41.Elements == 0 then
				v41.Category = table.remove(v39, 1)
				v41.Elements = fn39(v41.Category)
			end

			local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(v41.Category)

			if __wf_atom_7e8ad928(v41.Elements) then
				continue
			end

			while total3 < 75 do
				__wf_atom_83c14687()
				local itemInfo = table.remove(v41.Elements)

				if __wf_atom_7e8ad928(itemInfo) then
					break
				end

				total3 += 1

				if __wf_atom_7e8ad928(itemInfo.mItemType) then
					continue
				end

				local storeItem

				if not __wf_atom_7e8ad928(v3) then
					storeItem = v3:__wf_atom_232fd31d(itemInfo.mItemType)

					if not (__wf_atom_7e8ad928(storeItem) or storeItem:__wf_atom_1f093091()) then
						storeItem = nil
					end
				end

				if __wf_atom_7e8ad928(storeItem) or not (not fn11() or storeItem:__wf_atom_a7f0cb73()) then
					continue
				end

				local v64

				if itemInfo.SortCategory == 34 then
					v64 = itemInfo
				else
					v64 = module2.GetStoreItemInfo(mMovie, storeItem, {
						SalvageRepaired = inventory2 == v52.SHIP_PARTS,
						GetVisibilityMaterial = true,
						ItemInfo = itemInfo,
						Category = v41.Category,
						GameData = gameData,
						HideRecipesInUse = true,
						CheckTimeLimited = true,
						CheckKeyChain = true,
						UsePrimeBucks = inventory2 == v52.PRIMEPARTS,
						UseFusionPoints = inventory2 == v52.TREASURE,
						UseFocusPoints = inventory2 == v52.SHARDS
					}, v3, inventory, true)
				end

				if not (__wf_atom_7e8ad928(v22) or __wf_atom_7e8ad928(_T[v22])) then
					_T[v22](v64)
				end

				if v49[v64.UID] then
					v64.Locked = true
					v64.LockedMsg = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ItemSelection_Equipped", false)
				end

				v64.StoreItem = storeItem
				v64.SpecialPrice = itemInfo.SpecialPrice
				v64.PriceLabelType = itemInfo.PriceLabelType

				if __wf_atom_7e8ad928(v64.Rank) and not __wf_atom_7e8ad928(v64.ResultItemType) then
					local mXPInfo = inventory.mXPInfo

					for i = 1, #mXPInfo do
						local mItemType = mXPInfo[i].mItemType

						if __wf_atom_7e8ad928(mItemType) or mItemType ~= v64.ResultItemType then
							continue
						end

						v64.Rank = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mXPInfo[i].mXP, mItemType)
					end
				end

				if
					__wf_atom_7e8ad928(v64.ArcaneRank)
					and not __wf_atom_7e8ad928(v64.RawItem)
					and v64.RawItem.mItemType:IsA(v)
				then
					local rawItem = v64.RawItem
					local arcaneRank, arcaneMaxRank = module7.GetArcaneRank(rawItem)
					v64.ArcaneRank = arcaneRank
					v64.ArcaneMaxRank = arcaneMaxRank
					v64.Arcane = rawItem
				end

				if not (v64.Count ~= nil and v64.Count > 0 or inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE) then
					continue
				end

				if fn11() then
					if
						_T.InvTradingInfo.ForDisplay
						or not (storeItem:__wf_atom_d1a2145d() > _T.InvTradingInfo.PartnerMR)
					then
						if
							__wf_atom_8c8df26f == 2
							and not (__wf_atom_7e8ad928(v64.RawItem) or v64.RawItem:__wf_atom_3ae8d6f2())
						then
							v64.Locked = true
							v64.LockedMsg = "/Lotus/Language/Dojo/Trade_Untradeable"
						elseif
							(__wf_atom_8c8df26f == 2 or v64.Type:IsA(__wf_atom_abf506db))
							and not __wf_atom_7e8ad928(v64.RawItem)
							and v64.RawItem:__wf_atom_ae27679c()
						then
							v64.Locked = true
							v64.LockedMsg = "/Lotus/Language/Dojo/Trade_Untradeable"
						end
					else
						v64.Locked = true
						v64.LockedMsg = "/Lotus/Language/Dojo/Trade_PartnerMRLocked"
					end
				end

				if inventory2 == v52.TRADE_MODS then
					fn40("modList", v58.MISC, v64)
				elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
					fn40("miscList", v58.MISC, v64)
				elseif fn11() and v64.Type ~= nil and v64.Type:IsA(__wf_atom_3cecff09) then
					if v64.IsPrimePart then
						v64.AdditionalCategories = { v58.PRIME }
					end

					fn40("recipeList", v58.RECIPES, v64)
				elseif fn11() and v64.Type ~= nil and v64.Type:IsA(baseLichItem) then
					fn40("lichList", v58.LICH, v64)
				elseif fn11() and v64.Type ~= nil and v64.Type:IsA(__wf_atom_9ae7d6a1) then
					fn40("emoteList", v58.EMOTE, v64)
				elseif v64.IsPrimePart then
					fn40("primeList", v58.PRIME, v64)
				elseif __wf_atom_8c8df26f == 1 then
					fn40("warframeList", v58.WARFRAME, v64)
				elseif __wf_atom_8c8df26f == 2 then
					fn40("weaponList", v58.WEAPONS, v64)
				elseif v64.SortCategory == 6 then
					fn40("skinList", v58.APPEARANCE, v64)
				elseif v64.SortCategory == 18 then
					fn40("droneList", v58.MISC, v64)
				elseif v64.SortCategory == 2 then
					fn40("gearList", v58.GEAR, v64)
				elseif v64.SortCategory == 17 then
					fn40("keyList", v58.KEYS, v64)
				elseif v64.SortCategory == 28 then
					fn40("archwingWeaponList", v58.ARCHWINGWEAPONS, v64)
				elseif v64.SortCategory == 29 then
					fn40("archwingWeaponList", v58.ARCHWINGWEAPONS, v64)
				elseif
					v64.CatItemType:IsA(plantItem)
					or v64.CatItemType:IsA(resourceItem)
					or v64.CatItemType:IsA(zarimanResourceItem)
				then
					fn40("materialList", v58.RESOURCES, v64)
				elseif v64.Type == nil or not v64.Type:IsA(v) then
					if v64.Type == nil or not v64.Type:IsA(v2) then
						if v64.Type == nil or not v64.Type:IsA(__wf_atom_f6dea198) then
							if v64.SortCategory == 34 then
								if inventory2 ~= v52.DECODONATE or v64.StoreItem:__wf_atom_54893980() then
									if inventory2 == v52.DECODONATE or fn11() then
										v64.Category = v60.AYATAN
									end

									fn40("miscList", v58.MISC, v64)
								end
							elseif v64.SortCategory == 37 then
								fn40("operatorAmpList", v58.OPERATORAMPS, v64)
							elseif v64.Type == nil or not v64.Type:IsA(__wf_atom_6317e6dc) then
								if v64.SortCategory == 26 then
									fn40("imprintList", v58.PETPRINTS, v64)
								elseif
									v64.Type ~= ducatType
									and (inventory2 ~= v52.TREASURE or v64.Type:IsA(__wf_atom_3aaccc49))
								then
									if
										inventory2 == v52.DECODONATE
										and not __wf_atom_7e8ad928(v64.StoreItem)
										and v64.StoreItem:IsA(__wf_atom_87288ae7)
									then
										v64.Category = module2.GetCategoryForShipDeco(v64.StoreItem:__wf_atom_47a670f8())
									end

									if inventory2 ~= v52.DECODONATE or v64.StoreItem:__wf_atom_54893980() then
										fn40("miscList", v58.MISC, v64)
									end
								end
							else
								fn40("relicsList", v58.RELICS, v64)
							end
						else
							fn40("focusLensList", v58.FOCUS, v64)
						end
					else
						fn40("avionicsList", v58.AVIONICS, v64)
					end
				else
					fn40("enhancementList", v58.ENHANCEMENTS, v64)
				end
			end
		end

		if #v39 == 0 and #v41.Elements == 0 then
			v38 = 2
		end
	elseif v38 == 2 then
		while total3 < 75 and (#v42 > 0 or v46 <= #v44.Elements) do
			if v46 > #v44.Elements and #v42 > 0 then
				v45 = table.remove(v42)
				v44 = v40[v45.Name]
				v46 = 1
			end

			local v62 = 0

			if v44 == nil then
				v44 = { Elements = {} }
			else
				v62 = math.min(#v44.Elements, v46 + 75 - total3 - 1)
				total3 += v62 - v46 + 1
			end

			if (inventory2 == v52.DECODONATE or fn11()) and v45.Name == "miscList" then
				local v63 = {}

				for i = v46, v62 do
					local element = v44.Elements[i]
					local category = element.Category

					if fn11() and category ~= v60.AYATAN then
						category = v45.Category
					end

					if v63[category] == nil then
						v63[category] = {}
					end

					table.insert(v63[category], element)
				end

				local ternary = module4.Ternary(v46 == 1, 0, nil)

				for k, v64 in pairs(v63) do
					fn38(v64, k, ternary)
				end

				v46 = v62 + 1
			elseif inventory2 == v52.FISH and v45.Name == "miscList" then
				local v63 = {}
				local v64 = {}
				local v65 = {}

				for i = v46, v62 do
					if __wf_atom_7e8ad928(v44.Elements[i].StoreItem) then
						continue
					end

					local __wf_atom_fd49129d = v44.Elements[i].StoreItem:__wf_atom_fd49129d()

					if __wf_atom_fd49129d == 0 then
						table.insert(v63, v44.Elements[i])
					elseif __wf_atom_fd49129d == 1 then
						table.insert(v64, v44.Elements[i])
					elseif __wf_atom_fd49129d == 2 then
						table.insert(v65, v44.Elements[i])
					end
				end

				local ternary = module4.Ternary(v46 == 1, 0, nil)
				fn38(v63, v59.FISH_SMALL, ternary)
				fn38(v64, v59.FISH_MEDIUM, ternary)
				fn38(v65, v59.FISH_LARGE, ternary)
				v46 = v62 + 1
			elseif inventory2 == v52.SYNDDONATE then
				local elements = {}

				for i = v46, v62 do
					local element = v44.Elements[i]
					element.Count = module3.GetNumOwned(gameData, inventory, element.StoreItem, v17.PurchasedItems)

					if __wf_atom_7e8ad928(element.Type) or element.Type ~= v56 or element.Count > 0 then
						table.insert(elements, element)
					end
				end

				fn38(elements, 16, 0)
				v46 = v62 + 1
			else
				local v63 = {}

				for i = v46, v62 do
					table.insert(v63, v44.Elements[i])
				end

				local v64 = v45.Bin == nil and 0 or v45.Bin
				fn38(v63, v45.Category, module4.Ternary(v46 == 1, v64, nil))
				v46 = v62 + 1
			end
		end

		if #v42 == 0 and v46 > #v44.Elements then
			v38 = 3
		end
	else
		if v17.mSortBy == nil and not __wf_atom_7e8ad928(gameData) then
			local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
			local __wf_atom_6340bbd5 = gameData:__wf_atom_6340bbd5(__wf_atom_6d61d595)

			if inventory2 == v52.DECODONATE or inventory2 == v52.RESDONATE then
				v17:SetSortBy("COUNT")
			elseif inventory2 ~= v52.SYNDDONATE then
				local v62 = false

				for i = 1, v17.mSortMenu:GetHowManyElements() do
					local elementInIndex = v17.mSortMenu:GetElementInIndex(i)

					if __wf_atom_7e8ad928(elementInIndex) or elementInIndex.SortId ~= __wf_atom_6340bbd5 then
						continue
					end

					v62 = true
					break
				end

				v17:SetSortBy(not v62 and "NAME" or __wf_atom_6340bbd5)
			end
		end

		local all = v58.ALL

		if _T.InvTest_CatToSelect ~= nil then
			if _T.InvTest_CatToSelect == "LICH" then
				all = v58.LICH
			end

			_T.InvTest_CatToSelect = nil
		end

		v17.mFilterBy = all
		v17:Redraw(function()
			flag2 = false
			v19[v61.TUTORIAL].mVisible = inventory2 == v52.PRIMEPARTS
			local flag9

			if inventory2 == v52.FISH then
				v19[v61.FISH_CATEGORY].mVisible = true
				flag9 = true
			else
				flag9 = false
			end

			if not v19[v61.EXIT].mVisible then
				v19[v61.EXIT].mVisible = true
				flag9 = true
			end

			if flag9 then
				fn6()
			end

			if inventory2 == v52.SYNDDONATE then
				v17:SetSortBy("SELL_PRICE")
			end
		end, true)
		mMovie:__wf_atom_2dedec1a("SearchAndSort.SearchBox", 13, true)
		mMovie:__wf_atom_2dedec1a(v17.mCategoryClipName, 13, true)
		mMovie:__wf_atom_e57658c2(v17.mSortClipName, 12, 100)

		if inventory2 == v52.FISH and _T.InventorySelection ~= nil then
			local count = #_T.InventorySelection

			if count > 0 then
				for _, mElement in ipairs(v17.mElements) do
					for i = 1, count do
						if mElement.Type == _T.InventorySelection[i].CountedItem.mItemType then
							fn23(mElement, false, _T.InventorySelection[i].NumSelected)
						end
					end
				end
			end
		end

		v26:SetActive(false)
		v38 = nil
		v40 = {}
		print("PopulateGrid complete")
	end
end

fn2 = function()
	print("PopulateGrid()")
	v17:RemoveElements(true, true)

	if inventory2 == v52.ENEMIES then
		fn()
	else
		flag2 = true
		v26:SetActive(true)

		if __wf_atom_7e8ad928(gameData) then
			return
		end

		inventory = gameData:GetInventory()

		if __wf_atom_7e8ad928(inventory) then
			print("ERROR: No inventory!")
			assert(false)
		end

		v17.PurchasedItems = module2.GetPurchasedItems(v3, inventory)
		v39 = {}

		if inventory2 == v52.PRIMEPARTS then
			v39 = { 11, 13 }
		elseif inventory2 == v52.TREASURE then
			v39 = { 11, 34 }
		elseif inventory2 == v52.FISH or inventory2 == v52.SHARDS then
			v39 = { 11 }
		elseif inventory2 == v52.SYNDDONATE then
			v39 = { 11 }
		elseif inventory2 == v52.DECODONATE then
			v39 = { 30, 34 }
		elseif inventory2 == v52.RESDONATE then
			v39 = { 11 }
		elseif inventory2 == v52.TRADE_MODS then
			v39 = { 4 }
		elseif inventory2 == v52.SHIP_RAW then
			v39 = { 43 }
		elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS then
			v39 = { 43, 46 }
		else
			v39 = {
				0,
				1,
				3,
				5,
				6,
				13,
				2,
				11,
				4,
				15,
				16,
				17,
				18,
				27,
				28,
				29,
				34,
				24,
				37,
				39,
				41,
				48,
				26,
				50
			}
		end

		if inventory2 == v52.TRADE_ITEMS then
			if flag7 then
				table.insert(v39, 100)
			end

			table.insert(v39, 10)
		end

		if inventory2 == v52.INVENTORY then
			local function fn42(p)
				return (math.max(0, inventory:__wf_atom_9ed9a33c(p)))
			end

			table.insert(v42, { Name = "warframeList", Category = v58.WARFRAME, Bin = fn42(1) })
			table.insert(v42, { Name = "weaponList", Category = v58.WEAPONS, Bin = fn42(2) })
			table.insert(v42, { Name = "skinList", Category = v58.APPEARANCE })
			table.insert(v42, { Name = "enhancementList", Category = v58.ENHANCEMENTS })
			table.insert(v42, { Name = "focusLensList", Category = v58.FOCUS })
			table.insert(v42, { Name = "droneList", Category = v58.MISC })
			table.insert(v42, { Name = "gearList", Category = v58.GEAR })
			table.insert(v42, { Name = "keyList", Category = v58.KEYS })
			table.insert(v42, { Name = "miscList", Category = v58.MISC })
			table.insert(v42, { Name = "relicsList", Category = v58.RELICS })
			table.insert(v42, { Name = "materialList", Category = v58.RESOURCES })
			table.insert(v42, { Name = "imprintList", Category = v58.PETPRINTS })
			table.insert(v42, { Name = "avionicsList", Category = v58.AVIONICS })
		elseif inventory2 == v52.TRADE_MODS then
			table.insert(v42, { Name = "modList", Category = v58.MISC })
		elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
			table.insert(v42, { Name = "miscList", Category = v58.MISC })
		elseif inventory2 == v52.TRADE_ITEMS then
			table.insert(v42, { Name = "weaponList", Category = v58.WEAPONS })
			table.insert(v42, { Name = "archwingWeaponList", Category = v58.ARCHWINGWEAPONS })
			table.insert(v42, { Name = "sentinelList", Category = v58.SENTINEL })
			table.insert(v42, { Name = "skinList", Category = v58.APPEARANCE })
			table.insert(v42, { Name = "enhancementList", Category = v58.ENHANCEMENTS })
			table.insert(v42, { Name = "focusLensList", Category = v58.FOCUS })
			table.insert(v42, { Name = "gearList", Category = v58.GEAR })
			table.insert(v42, { Name = "keyList", Category = v58.KEYS })
			table.insert(v42, { Name = "miscList", Category = v58.MISC })
			table.insert(v42, { Name = "relicsList", Category = v58.RELICS })
			table.insert(v42, { Name = "materialList", Category = v58.RESOURCES })
			table.insert(v42, { Name = "recipeList", Category = v58.RECIPES })
			table.insert(v42, { Name = "imprintList", Category = v58.PETPRINTS })
			table.insert(v42, { Name = "lichList", Category = v58.LICH })
			table.insert(v42, { Name = "avionicsList", Category = v58.AVIONICS })
			table.insert(v42, { Name = "emoteList", Category = v58.EMOTE })
		elseif inventory2 == v52.RESDONATE then
			table.insert(v42, { Name = "materialList", Category = v58.RESOURCES })
			table.insert(v42, { Name = "miscList", Category = v58.RESOURCES })
		end

		if inventory2 ~= v52.TREASURE then
			table.insert(v42, { Name = "primeList", Category = v58.PRIME })
		end

		if
			inventory2 ~= v52.PRIMEPARTS
			and (inventory2 == v52.TREASURE or inventory2 == v52.FISH or inventory2 == v52.SHARDS or inventory2 == v52.DECODONATE or inventory2 == v52.SYNDDONATE)
		then
			table.insert(v42, { Name = "miscList", Category = v58.MISC })
		end

		if inventory2 == v52.SYNDDONATE then
			table.insert(v42, { Name = "materialList", Category = v58.RESOURCES })
		end

		v17:Redraw(function()
			v19[v61.TUTORIAL].mVisible = inventory2 == v52.PRIMEPARTS
			local flag9

			if inventory2 == v52.FISH then
				v19[v61.FISH_CATEGORY].mVisible = true
				flag9 = true
			else
				flag9 = false
			end

			if not v19[v61.EXIT].mVisible then
				v19[v61.EXIT].mVisible = true
				flag9 = true
			end

			if flag9 then
				fn6()
			end
		end, true, true)
	end

	mMovie:__wf_atom_2dedec1a("SearchAndSort.SearchBox", 13, false)
	mMovie:__wf_atom_e57658c2(v17.mSortClipName, 12, 0)
	mMovie:__wf_atom_2dedec1a(v17.mCategoryClipName, 13, false)
	v38 = module4.Ternary(inventory2 == v52.ENEMIES, 3, 1)
end

local function fn42(p)
	local v62 = __wf_atom_421b01aa(p, 0, 1) * 100
	__wf_atom_ec43d06e(mMovie, "SellList.Slider.Fill", 2, { 5 }, { __wf_atom_421b01aa(v62, 0.01, 100) }, 0.1)
	mMovie:__wf_atom_50d60589("SellList.SliderValue.Value", 36, string.format("%.0f", v62))
	local v63 = 142 + v62

	if v63 ~= v17.ElementWidth then
		v17.ElementWidth = v63
		v17.ElementHeight = v63
		fn32(v17)

		if v17.mElements ~= nil and v17.mElements[1] ~= nil and v17.mElements[1].mClipName ~= nil then
			module6.OnGridItemCreated(mMovie, v17, v17.mElements[1].mClipName)
		end

		v17:Redraw(nil, true, true)
	end
end

function SliderPress()
	if not flag2 then
		flag6 = true
		module4.PlaySound(_G.UISound_Select)
	end
end

function SliderRelease(_)
	flag6 = false
end

function Update()
	if not v16 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	if flag6 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SellList.Slider", 30)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("SellList.Slider.Back", 14)

		if __wf_atom_5e6e15c8 ~= nil and __wf_atom_5e6e15c8_2 ~= nil then
			fn42(__wf_atom_5e6e15c8 / (__wf_atom_5e6e15c8_2 - 2))
		end
	end

	local v62 = v47

	if v62 then
		if __wf_atom_8e4fda44:FindMovie(_G.UIMovie_DetailedPurchaseDialog) == nil then
			v62 = not v37 and (_T.TopMenuOpen ~= true or inventory2 ~= v52.PRIMEPARTS or inventory2 ~= v52.TREASURE)
		else
			v62 = false
		end
	end

	mMovie:SetVisible(v62)
	local v63 = __wf_atom_fa1258d0()

	if not __wf_atom_7e8ad928(v14) then
		v14:Update(v63)
	end

	mMovie:__wf_atom_88d9cd84(v63)

	if not __wf_atom_7e8ad928(v26) then
		v26:Update()
	end

	if v38 ~= nil then
		fn41()
	end

	if not __wf_atom_7e8ad928(v17) then
		v17:Update()
	end

	if __wf_atom_7e8ad928(v3) and not __wf_atom_7e8ad928(v4) and v4:__wf_atom_86399a47() then
		v3 = Resource(primeSellManifestType2)
		fn2()
	end

	if v8 and not __wf_atom_7e8ad928(v9) and v9:__wf_atom_86399a47() then
		v8 = false
		flag2 = false
		v26:SetActive(false)

		if not __wf_atom_7e8ad928(_T.SpawnEnemies) then
			_T.SpawnEnemies(infoPopup_Grid.mElements, selectedEnemyLevel)
			fn14()
		end
	end
end

local function fn43()
	v17:RunForAllElements(function(p)
		if p.LookupIds ~= nil and #p.LookupIds > 0 then
			p.MarkedToSell = nil
			p.LookupIds = nil
			fn18(p)
		end
	end)
	infoPopup_Grid:RemoveElements()
	fn21(-total)
end

local function fn44()
	if flag then
		v10 = 40
	elseif gGameRules:IsA(__wf_atom_469b1d97) then
		v10 = 3
	else
		v10 = 20
	end

	if gRegion:IsMaster() then
		local v62 = Symbol("TENNO_TEAM")
		local v63 = Symbol("TENNO")
		local v64 = Symbol("Clem")
		local all = gRegion:FindAll(__wf_atom_67c46eba)
		local count = 0

		for _, v65 in ipairs(all) do
			local __wf_atom_30e3d82b = v65:__wf_atom_30e3d82b()

			if
				__wf_atom_7e8ad928(__wf_atom_30e3d82b)
				or not (__wf_atom_30e3d82b:__wf_atom_8537d7d4() ~= v62 and v65:__wf_atom_a97361bb() ~= v63 or v65:__wf_atom_db682341() == v64)
			then
				continue
			end

			count += 1
		end

		v10 = math.max(0, v10 - count)
	end
end

function KillEnemies()
	local module13 = require("SF.Interface.SFUtilities")
	module13.KillEnemies()
	fn44()
	fn21(0)
end

local function fn45()
	for i = 1, #v43 do
		local v62 = v43[i]

		if v62 ~= nil and v62.mButton ~= nil then
			v62.mButton:SetText(v62.GetName())
		end
	end
end

function EnemyLevelSelected()
	_T.InfoPopup_Data = {
		Name = Localize("/Lotus/Language/Menu/EnemySelector_LevelCount", {}),
		Description = Localize("/Lotus/Language/Menu/EnemySelector_MaxLevel", { MAXLEVEL = v11 }),
		Count = v11,
		DefaultValue = selectedEnemyLevel,
		Callback = "OnEnemyLevelChanged"
	}
	mMovie:PushChildMovie(inputCountDialog)
end

function OnEnemyLevelChanged(p, p2)
	if not __wf_atom_7e8ad928(p2) and tonumber(p2) == 1 and tonumber(p) > 0 then
		selectedEnemyLevel = tonumber(p)
		_T.SelectedEnemyLevel = selectedEnemyLevel

		if not __wf_atom_7e8ad928(v25) then
			v25:Execute("RefreshMenu", "")
		end
	end

	fn45()
end

function ToggleFriendlyFire()
	if _T.FriendlyFire == nil then
		_T.FriendlyFire = true
	else
		_T.FriendlyFire = not _T.FriendlyFire
	end

	fn5()
	fn45()
end

function TogglePauseAI()
	if _T.PauseAI == nil then
		_T.PauseAI = true
	else
		_T.PauseAI = not _T.PauseAI
	end

	fn4()
	fn45()
end

function ToggleInvincibility()
	if _T.warframesInvincible then
		_T.warframesInvincible = false
	else
		_T.warframesInvincible = true
	end

	fn45()
end

function ToggleCompanionInvincibility()
	if _T.companionsInvincible then
		_T.companionsInvincible = false
	else
		_T.companionsInvincible = true
	end

	fn45()
end

function SyndicateMovieClosed()
	v37 = false
	v25 = nil
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 8, {
		12,
		function(p)
			if not __wf_atom_7e8ad928(_T.ShowBackground) then
				local size = 0.66 + 1.3399999999999999 * p
				_T.ShowBackground(0.25, nil, nil, { Size = size, Center = 0, FadeSize = 0.4 })
			end
		end
	}, { 100, 1 }, 0.5)
end

function OpenSyndicateMovie()
	if _T.TaggedDialog == nil or _T.TaggedDialog.Recruiter_Syndicate == nil then
		return
	end

	v25 = _T.TaggedDialog.Recruiter_Syndicate.mCallback(_T.CurrentConversation, mMovie)
	v37 = true
end

local function fn46()
	local mLabel = (_T.InventoryInfo == nil or _T.InventoryInfo.ExitLabel == nil) and "/Lotus/Language/Menu/Exit"
		or _T.InventoryInfo.ExitLabel
	table.insert(v19, {
		mLabel = mLabel,
		mVisible = false,
		mCallback = function()
			mMovie:Execute("ExitScreen", "")
		end,
		mCallout = "MENU_CANCEL"
	})
	table.insert(v19, {
		mLabel = "/Lotus/Language/Menu/ItemInventory_SelectAll",
		mVisible = inventory2 == v52.FISH,
		mCallback = function()
			mMovie:Execute("SelectAllCategoryItems", "")
		end,
		mCallout = "MENU_GENERIC1"
	})
	table.insert(v19, {
		mLabel = "/Lotus/Language/Menu/Clear",
		mVisible = inventory2 == v52.ENEMIES,
		mCallback = fn43,
		mCallout = "MENU_RTRIGGER1"
	})
	local v64 = {
		mLabel = "/Lotus/Language/Menu/Simulacrum_KillEnemies",
		mVisible = inventory2 == v52.ENEMIES and _T.InSimulacrum and gRegion:IsMaster(),
		mCallback = function()
			mMovie:Execute("KillEnemies", "")
		end,
		mCallout = "MENU_RTHUMB"
	}
	table.insert(v19, v64)
	local v67 = {
		mLabel = "/Lotus/Language/Menu/ItemInventory_SelectAll",
		mVisible = inventory2 ~= v52.FISH and inventory2 ~= v52.ENEMIES and inventory2 ~= v52.SHIP_SCRAP and inventory2 ~= v52.SHIP_PARTS and inventory2 ~= v52.SHIP_RAW and Engine.IsPlayingWithController(),
		mCallback = fn3,
		mCallout = "MENU_GENERIC1"
	}
	table.insert(v19, v67)
	table.insert(v19, {
		mLabel = "/Lotus/Language/Menu/General_Tutorial",
		mVisible = inventory2 == v52.PRIMEPARTS,
		mCallback = function()
			_T.KioskIntroTransmission()
		end,
		mCallout = "MENU_RTHUMB"
	})
	local v70 = {
		mLabel = "/Lotus/Language/Menu/SyndicateMissionName",
		mVisible = inventory2 == v52.SYNDDONATE and _T.TaggedDialog ~= nil and _T.TaggedDialog.Recruiter_Syndicate ~= nil,
		mCallback = function()
			mMovie:Execute("OpenSyndicateMovie", "")
		end
	}
	table.insert(v19, v70)
end

function OnInvalidBinError(p)
	module3.HandleInvalidBinErrorResponse(p)
end

local function fn47()
	local color = module5.GetColor(6, true)
	local color2 = module5.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("SellList.Tip", 11, color2)
	mMovie:__wf_atom_e57658c2("SellList.Total", 11, color)
	mMovie:__wf_atom_e57658c2("SellList.TopLine", 11, color2)
	mMovie:__wf_atom_e57658c2("SellList.BottomLine", 11, color2)
	mMovie:__wf_atom_e57658c2("SellList.BottomLine2", 11, color2)
	mMovie:__wf_atom_e57658c2("SellList.SimulacrumSeparator", 11, color2)
	fn21(0)

	if not __wf_atom_7e8ad928(v18) then
		v18:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v31) then
		v31:UpdateColors()
	end

	if not __wf_atom_7e8ad928(infoPopup_Grid) then
		if not __wf_atom_7e8ad928(infoPopup_Grid.mScrollBar) then
			infoPopup_Grid.mScrollBar:RedrawScrollBar()
		end

		infoPopup_Grid:RunForAllVisibleElements(function(p)
			infoPopup_Grid:UpdateColors(p, p == infoPopup_Grid:GetFocusedElement())
		end)
	end

	if not __wf_atom_7e8ad928(v17) then
		v17:RunForAllVisibleElements(function(p)
			v17:UpdateColors(p, p == v17:GetFocusedElement())
		end)

		if not __wf_atom_7e8ad928(v17.mScrollBar) then
			v17.mScrollBar:RedrawScrollBar()
		end

		if not __wf_atom_7e8ad928(v17.mSortMenu) then
			v17.mSortMenu:UpdateColors()
		end

		if not __wf_atom_7e8ad928(v17.mCategoryMenu) then
			v17.mCategoryMenu:RunForAllElements(function(p)
				v17.mCategoryMenu:UpdateColors(p)
			end)
		end
	end
end

local function fn48(statScans)
	for i = 1, #statScans do
		scans[statScans[i].type:__wf_atom_5b41f63b()] = statScans[i].scans
	end
end

local function fn49(p)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v62 = {}

	for i = 1, #__wf_atom_3c8e1a7a do
		table.insert(v62, __wf_atom_3c8e1a7a[i]:__wf_atom_eff0517e())
	end

	for i = 1, #v62 do
		local __wf_atom_d2b2176d = v62[i]:__wf_atom_d2b2176d()
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27:__wf_atom_b066b01e(p)
		end

		local __wf_atom_28224c27_2 = __wf_atom_d2b2176d:__wf_atom_28224c27(7)

		if __wf_atom_7e8ad928(__wf_atom_28224c27_2) or not __wf_atom_28224c27_2:IsA(__wf_atom_77e05d3b) then
			continue
		end

		__wf_atom_28224c27_2:__wf_atom_b066b01e(p)
	end
end

fn4 = function()
	local v62 = Symbol("TENNO_TEAM")
	local v63 = Symbol("TENNO")
	local all = gRegion:FindAll(__wf_atom_67c46eba)

	for _, v64 in ipairs(all) do
		local __wf_atom_30e3d82b = v64:__wf_atom_30e3d82b()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or __wf_atom_30e3d82b:__wf_atom_8537d7d4() == v62
			or v64:__wf_atom_e93896ba() == v63
		then
			continue
		end

		__wf_atom_30e3d82b:SetPaused(_T.PauseAI, v12)
	end

	if _T.PauseAI then
		v5:Enable(false)
		fn49(false)
	else
		v5:Enable(true)
		v5:__wf_atom_64e90c19(gRegion:__wf_atom_c4f78a8f())
		fn49(true)
	end
end

fn5 = function()
	local all = gRegion:FindAll(__wf_atom_7e6ed5fa)
	local count = 0

	for i = 1, #all do
		if __wf_atom_7e8ad928(all[i]:__wf_atom_0d9c1a58()) then
			continue
		end

		if _T.FriendlyFire then
			all[i]:SetFaction(Symbol("Enemy" .. tostring(count)))
			count += 1
		else
			all[i]:SetFaction(Symbol("TENNO"))
		end
	end
end

local function fn50()
	if __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		return
	end

	if not __wf_atom_7e8ad928(v6) then
		v11 = 50

		if flag then
			v11 = 5000
		else
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				local __wf_atom_a96eb2aa = __wf_atom_c4f78a8f:__wf_atom_a96eb2aa()

				if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
					v11 = 30 + 5 * __wf_atom_a96eb2aa:__wf_atom_35733fbc()
				end
			end
		end

		v11 = math.max(10, v11)
		local __wf_atom_3f229960 = v6:__wf_atom_3f229960()
		_T.SelectedEnemyLevel = module4.Ternary(
			__wf_atom_7e8ad928(__wf_atom_3f229960) or __wf_atom_3f229960 == "",
			math.min(20, v11),
			__wf_atom_3f229960
		)
		selectedEnemyLevel = _T.SelectedEnemyLevel
		local __wf_atom_11f1e0cb = v6:__wf_atom_11f1e0cb()
		_T.PauseAI = module4.Ternary(__wf_atom_7e8ad928(__wf_atom_11f1e0cb), false, __wf_atom_11f1e0cb)
		fn4()
		local __wf_atom_8738e58c = v6:__wf_atom_8738e58c()
		_T.warframesInvincible = module4.Ternary(__wf_atom_7e8ad928(__wf_atom_8738e58c), false, __wf_atom_8738e58c)
		local __wf_atom_14a7f2b5 = v6:__wf_atom_14a7f2b5()
		_T.companionsInvincible = module4.Ternary(__wf_atom_7e8ad928(__wf_atom_14a7f2b5), false, __wf_atom_14a7f2b5)
		local __wf_atom_275ae72b = v6:__wf_atom_275ae72b()
		_T.FriendlyFire = module4.Ternary(__wf_atom_7e8ad928(__wf_atom_275ae72b), false, __wf_atom_275ae72b)
		fn5()
		local __wf_atom_db800a4d = v6:__wf_atom_db800a4d()

		if not __wf_atom_7e8ad928(__wf_atom_db800a4d) then
			_T.SpawnedEnemies = {}

			for i = 1, #__wf_atom_db800a4d do
				_T.SpawnedEnemies[i] = {
					Type = __wf_atom_db800a4d[i].enemyType,
					SourceType = __wf_atom_db800a4d[i].resourceType,
					Count = __wf_atom_db800a4d[i].enemyAmount
				}
			end
		end
	end

	table.insert(v43, {
		PressedCallback = "EnemyLevelSelected",
		GetName = function()
			return mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/EnemySelector_EnemyLevel", false) .. " " .. selectedEnemyLevel
		end
	})

	if _T.InSimulacrum and gRegion:IsMaster() then
		table.insert(v43, {
			PressedCallback = "TogglePauseAI",
			GetName = function()
				return module4.Ternary(
					_T.PauseAI,
					"/Lotus/Language/Menu/Simulacrum_PauseAI",
					"/Lotus/Language/Menu/Simulacrum_NoPauseAI"
				)
			end
		})

		if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_469b1d97) then
			table.insert(v43, {
				PressedCallback = "ToggleInvincibility",
				GetName = function()
					return module4.Ternary(
						_T.warframesInvincible,
						"/Lotus/Language/Menu/Loadout_Simulacrum_Invincibility",
						"/Lotus/Language/Menu/Loadout_Simulacrum_NoInvincibility"
					)
				end
			})
			table.insert(v43, {
				PressedCallback = "ToggleCompanionInvincibility",
				GetName = function()
					return module4.Ternary(
						_T.companionsInvincible,
						"/Lotus/Language/Menu/Loadout_Simulacrum_Companion_Invincibility",
						"/Lotus/Language/Menu/Loadout_Simulacrum_Companion_NoInvincibility"
					)
				end
			})
			table.insert(v43, {
				PressedCallback = "ToggleFriendlyFire",
				GetName = function()
					return module4.Ternary(
						_T.FriendlyFire,
						"/Lotus/Language/Menu/Simulacrum_FriendlyFire",
						"/Lotus/Language/Menu/Simulacrum_NoFriendlyFire"
					)
				end
			})
		end
	end

	local v62 = 475

	for i = 1, #v43 do
		local v63 = v43[i]
		local v64 = "SellList.OptionalButton" .. i

		if not mMovie:__wf_atom_253d7085(v64) then
			__wf_atom_86cbd68d(mMovie, "SellList.OptionalButton1.duplicateMovieClip", "OptionalButton" .. i, 6000 + i)
		end

		mMovie:__wf_atom_e57658c2(v64, 1, v62)
		v63.mButton = module10.Create(mMovie, v64, v63.GetName(), v63.PressedCallback)
		v63.mButton:SetTextAlignment("left")
		v63.mButton:SetMinWidth(350)
		v62 -= 32
	end

	__wf_atom_86cbd68d(mMovie, "SellList.BottomLine.duplicateMovieClip", "SimulacrumSeparator", 6000)
	mMovie:__wf_atom_e57658c2("SellList.SimulacrumSeparator", 1, v62 + 17)
	module6.DrawSeparator(mMovie, "SellList.SimulacrumSeparator", 380)
	v35 = mMovie:__wf_atom_5e6e15c8("SellList.SimulacrumSeparator", 1) - mMovie:__wf_atom_5e6e15c8("SellList.TopLine", 1) - 26
end

local function fn51()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
	local module13 = require("Lotus.Interface.Components.ThemedInputField")
	v31 = module13.Create(mMovie, "SearchAndSort.SearchBox", nil, nil, "<MENU_LTHUMB>")
	v31:SetType(v31.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
	v31.mMinSize = 200
	v31.mMaxSize = 200
	v31.mTextBuffer = 4
	v31.mAltButtonIcon = _G.UITexture_Search
	v31.mAltButtonVisible = true
	v31.mUnfocusedUnderlineColorOverride = nil
	v31.BaseInputFieldTextChanged = v31.InputFieldTextChanged

	function v31:InputFieldTextChanged(p)
		local mLabel = self.mLabel
		self:BaseInputFieldTextChanged(p)
		local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

		if self.mAltButtonicon ~= uiTexture_Search then
			self.mAltButtonicon = uiTexture_Search
			self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
		end

		local v62

		if self.mLabel == nil then
			v62 = false
		else
			v62 = self.mLabel ~= ""
		end

		if v17 ~= nil then
			if v62 then
				v17:SetSearchRankOnAllElements(self.mLabel)
			else
				v17:ClearSearchRankOnAllElements()
			end
		end

		if not flag2 and mLabel ~= self.mLabel and v17 ~= nil then
			v17.mMuteGridOpenSound = true
			v17:Redraw(nil, true, true)
			v17.mMuteGridOpenSound = false
		end
	end

	v31.BaseOnGamepadTransition = v31.OnGamepadTransition

	function v31:OnGamepadTransition()
		self:BaseOnGamepadTransition()
		local mAltButtonVisible = not Engine.IsPlayingWithController()
		self.mAltButtonVisible = mAltButtonVisible
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
	end

	v31:SetHint("/Lotus/Language/Menu/SearchPrompt")
	v31:Redraw()
end

local function fn52()
	local module13 = require("Lotus.Interface.Libs.TimerMgr")
	v14 = module13.CreateTimerMgr()
	v15 = module.Create(mMovie)
	v15:Register(mMovie, "Categories", { v15.ANCHOR_V_CENTRE, v15.ANCHOR_H_LEFT })
	v15:Register(mMovie, "InventoryGrid", { v15.ANCHOR_V_CENTRE, v15.ANCHOR_H_LEFT })
	v15:Register(mMovie, "SellList", { v15.ANCHOR_V_CENTRE, v15.ANCHOR_H_RIGHT })
	v15:Register(mMovie, "InventoryGridScrollBar", { v15.ANCHOR_V_CENTRE, v15.ANCHOR_H_RIGHT })
	v15:Register(mMovie, "SearchAndSort", { v15.ANCHOR_V_CENTRE, v15.ANCHOR_H_RIGHT })
	v15:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function Initialize()
	local v62 = "Inventory"

	if _T.SelectingEnemies then
		inventory2 = v52.ENEMIES
		v62 = "Selecting Enemies"
	elseif __wf_atom_7e8ad928(_T.SelectingFishManifest) then
		if _T.SellingTreasure then
			inventory2 = v52.TREASURE
			v62 = "Selling Ayatan Treasures"
		elseif _T.SellingShipUnidentified then
			inventory2 = v52.SHIP_RAW
			_T.SellingShipUnidentified = nil
			v62 = "Selling Railjack Raw"
		elseif _T.SellingShipWreckage then
			inventory2 = v52.SHIP_SCRAP
			_T.SellingShipWreckage = nil
			v62 = "Selling Railjack Wreckage"
		elseif _T.SellingShipComponents then
			inventory2 = v52.SHIP_PARTS
			_T.SellingShipComponents = nil
			v62 = "Selling Railjack Parts"
		elseif _T.SellingPrimeParts then
			inventory2 = v52.PRIMEPARTS
			v62 = "Selling Prime Parts"
		elseif _T.InvShardConvertMode == nil then
			if _T.InvDecoDonateMode == nil then
				if _T.InvResDonateMode == nil then
					if _T.InvTradingInfo == nil then
						if not __wf_atom_7e8ad928(_T.SyndicateInvInfo) then
							inventory2 = v52.SYNDDONATE
							v62 = "Donating for Standing"
						end
					else
						inventory2 = module4.Ternary(_T.InvTradingInfo.Items, v52.TRADE_ITEMS, v52.TRADE_MODS)

						if
							not __wf_atom_7e8ad928(gGameRules:__wf_atom_c88ae023())
							and gGameRules:__wf_atom_c88ae023():__wf_atom_eba4f572()
						then
							flag7 = true
						end

						v62 = "Selecting items to trade"
					end
				else
					_T.InvResDonateMode = nil
					inventory2 = v52.RESDONATE
					v62 = "Donating Resources"
				end
			else
				_T.InvDecoDonateMode = nil
				inventory2 = v52.DECODONATE
				v62 = "Donating Decorations"
			end
		else
			_T.InvShardConvertMode = nil
			inventory2 = v52.SHARDS
			v62 = "Converting Shards"
		end
	else
		inventory2 = v52.FISH
		v62 = "Selecting Fish (Fishmonger)"
	end

	print("InventoryTest - CurrMode: " .. v62)
	v13.BgInfo = module5.GetCurrentBackgroundInfo()
	v13.PauseState = gGameRules:__wf_atom_b450ace7()

	if not v13.PauseState then
		gGameRules:__wf_atom_411c9025(true)
	end

	if inventory2 == v52.TRADE_MODS or inventory2 == v52.TRADE_ITEMS then
		local inventory3 = gGameData:GetInventory()
		module7.BuildInstalled(v36, inventory3, 3)
	end

	module4.PlaySound(_G.UISound_Select)
	module4.PlaySound(_G.UISound_DialogOpen)
	module4.PlaySound(_G.UISound_GridOpen)
	v27 = "/Lotus/Language/Menu/CreditsWithIcon"
	v28 = "/Lotus/Language/Menu/ItemInventory_SellTotal"
	v29 = "/Lotus/Language/Menu/Store_Total"

	if inventory2 == v52.FISH then
		v27 = "/Lotus/Language/Menu/ReputationWithIcon"

		if _T.FishInvInfo.ShowRep then
			v28 = "/Lotus/Language/OstronCrafting/Fishmonger_StandingTotal"
		end
	elseif inventory2 == v52.PRIMEPARTS then
		v27 = "/Lotus/Language/Menu/PrimeBucksWithIcon"
	elseif inventory2 == v52.TREASURE or inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
		v27 = "/Lotus/Language/Menu/FusionPointsWithIcon"
	elseif inventory2 == v52.SHIP_PARTS then
		v27 = ""
	elseif inventory2 == v52.SHARDS then
		v27 = "/Lotus/Language/Menu/FocusPointsWithIcon"
	elseif inventory2 == v52.ENEMIES then
		v29 = "/Lotus/Language/Menu/ItemInventory_EnemyTitle"
	elseif inventory2 == v52.SYNDDONATE then
		v27 = "/Lotus/Language/Menu/ReputationWithIcon"
	elseif fn11() then
		v29 = "/Lotus/Language/Dojo/Trade_OfferedLabel"
	end

	if inventory2 == v52.SHIP_SCRAP then
		module6.ToggleScreensToHide(false, v13.ScreenVis)
	end

	local mainMenuSuitAvatar = module3.GetMainMenuSuitAvatar()

	if not __wf_atom_7e8ad928(mainMenuSuitAvatar) and mainMenuSuitAvatar:__wf_atom_f63d17c0() then
		mainMenuSuitAvatar:__wf_atom_e424c72a(false)
		v13.AvatarDrawOnTop = true
	end

	fn21(0)

	if flag8 then
		mMovie:__wf_atom_e57658c2("SellList.BottomLine", 1, 564.5)
	end

	if inventory2 == v52.DECODONATE or fn11() then
		v60 = module2.GetShipDecoCategories()
	end

	mMovie:__wf_atom_2dedec1a("SellList.OptionalButton1", 13, inventory2 == v52.ENEMIES)
	mMovie:__wf_atom_50d60589("SellList.Total", 46, "center")
	mMovie:__wf_atom_50d60589("SellList.Amount", 46, "center")
	mMovie:__wf_atom_2dedec1a("SellList.List.Item", 13, not fn11())
	mMovie:__wf_atom_2dedec1a("SellList.GridItem", 13, fn11())
	local v63 = module12.CheckQuestCompletion(sacrificeKeyChain, false)
	arsenal_ForceUmbraUnlock = _T.Arsenal_ForceUmbraUnlock or v63
	arsenal_ForceUmbraSwordUnlock = _T.Arsenal_ForceUmbraSwordUnlock or v63
	flag = false
	v7 = __wf_atom_72884638("LotusGameRules.UnlockCodex")
	mMovie:__wf_atom_0cf0fdbe(0)
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("DisplayInWorldText", "false")

	if inventory2 == v52.SYNDDONATE or inventory2 == v52.FISH and _T.FishInvInfo.ShowRep then
		if _T.SyndicateInvInfo ~= nil then
			local syndicate = _T.SyndicateInvInfo.Syndicate
			local syndicateBackgroundAlignments = module3.GetSyndicateBackgroundAlignments()
			v51.SyndicateInfo = module11.Create(
				mMovie,
				"SellList.SyndicateInfo",
				"",
				nil,
				dailyStandingIcon,
				nil,
				nil,
				nil
			)
			v51.SyndicateInfo.mSkipResize = true
			v51.SyndicateInfo.mVerticalTextOffset = 0.15
			v51.SyndicateInfo.mBackerEdgeAlpha = 0.3
			v51.SyndicateInfo.mToUpper = true
			v51.SyndicateInfo.mIconSize = 64
			v51.SyndicateInfo.mIconBorderSize = 80
			v51.SyndicateInfo.mIconPaddingX = -4
			v51.SyndicateInfo.mIconPaddingY = -4
			v51.SyndicateInfo.mIconToTextPadding = 106
			v51.SyndicateInfo.mBackerIconAlpha = 0.3
			v51.SyndicateInfo.mBackerAlpha = 0.9
			v51.SyndicateInfo.mUnfocusedShadeAlpha = 80
			v51.SyndicateInfo.mShowIconHighlight = true
			v51.SyndicateInfo:SetWidth(370)
			v51.SyndicateInfo.mExtendedProgressBar = true
			v51.SyndicateInfo.mSeamlessProgressBar = true
			local iconTexture = syndicate:GetIconTexture()
			v51.SyndicateInfo.mIconColor = syndicate:__wf_atom_48b50dc0()
			local __wf_atom_21ae2ec8 = syndicate:__wf_atom_21ae2ec8()
			v51.SyndicateInfo.mIconBgColor = Color(
				__wf_atom_21ae2ec8.red / 1.5,
				__wf_atom_21ae2ec8.green / 1.5,
				__wf_atom_21ae2ec8.blue / 1.5
			)
			v51.SyndicateInfo.mIconBgExtra = iconTexture
			local syndicateBackgroundAlignment = syndicateBackgroundAlignments[iconTexture:__wf_atom_5b41f63b()]

			if syndicateBackgroundAlignment then
				v51.SyndicateInfo.mIconBgExtraWidth = syndicateBackgroundAlignment.Scale / 6
				v51.SyndicateInfo.mIconBgExtraHeight = syndicateBackgroundAlignment.Scale / 6
				v51.SyndicateInfo.mIconBgExtraOffsetX = syndicateBackgroundAlignment.X / 2
				v51.SyndicateInfo.mIconBgExtraOffsetY = syndicateBackgroundAlignment.Y / 2
				v51.SyndicateInfo.mIconBgExtraAlpha = module4.Ternary(
					syndicateBackgroundAlignment.Alpha ~= nil,
					syndicateBackgroundAlignment.Alpha,
					5
				)
			else
				v51.SyndicateInfo.mIconBgExtraAlpha = 5
			end

			v51.SyndicateInfo:SetIcons(iconTexture)
			local v64 = nil

			for _, v66 in ipairs(syndicate:__wf_atom_c14d1e89()) do
				if v66.level ~= _T.SyndicateInvInfo.Level then
					continue
				end

				v64 = string.upper(mMovie:__wf_atom_8e9ac384(v66.titleLoc:c_str(), false))
				break
			end

			if v64 == nil then
				v64 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/NeutralTitle", false)
			end

			v51.SyndicateInfo:SetText(v64, false)
			local color = module5.GetColor(2, true)
			module8.DrawRankIndicator(mMovie, "SellList.SyndicateRank", {
				Level = _T.SyndicateInvInfo.Level
			})
			v51.SyndicateInfo:Redraw()
			v51.SyndicateInfo:SetProgress(
				_T.SyndicateInvInfo.Reputation,
				_T.SyndicateInvInfo.RepReq,
				"/Lotus/Language/Syndicates/SyndicateReputation"
			)
			v51.DailyStandingInfo = module11.Create(
				mMovie,
				"SellList.DailyStandingInfo",
				TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/DailyStandingCap", false)),
				nil,
				dailyStandingIcon,
				nil,
				nil,
				nil
			)
			v51.DailyStandingInfo.mSkipResize = true
			v51.DailyStandingInfo.mHideProgressTarget = true
			v51.DailyStandingInfo.mVerticalTextOffset = 0.18
			v51.DailyStandingInfo.mBackerEdgeAlpha = 0.3
			v51.DailyStandingInfo.mIconSize = 64
			v51.DailyStandingInfo.mIconBorderSize = 80
			v51.DailyStandingInfo.mIconPaddingX = -4
			v51.DailyStandingInfo.mIconPaddingY = -4
			v51.DailyStandingInfo.mIconToTextPadding = 12
			v51.DailyStandingInfo.mBackerIconAlpha = 0.3
			v51.DailyStandingInfo.mBackerAlpha = 0.9
			v51.DailyStandingInfo.mUnfocusedShadeAlpha = 80
			v51.DailyStandingInfo.mIconColor = Color(0, 0, 0)
			v51.DailyStandingInfo.mIconBgColor = Color(200, 200, 200)
			v51.DailyStandingInfo.mShowIconHighlight = true
			v51.DailyStandingInfo.mIconBgExtra = dailyStandingIconBacker
			v51.DailyStandingInfo.mIconBgExtraWidth = 176
			v51.DailyStandingInfo.mIconBgExtraHeight = 176
			v51.DailyStandingInfo.mIconBgExtraColor = color
			v51.DailyStandingInfo.mIconBgExtraAlpha = 30
			v51.DailyStandingInfo:SetWidth(370)
			v51.DailyStandingInfo.mExtendedProgressBar = true
			v51.DailyStandingInfo.mSeamlessProgressBar = true
			v51.DailyStandingInfo:Redraw()
			local __wf_atom_bca3f82a = syndicate:__wf_atom_bca3f82a()

			if __wf_atom_bca3f82a > 0 and __wf_atom_bca3f82a < 3 then
				local __wf_atom_dc1594a9 = gGameData:__wf_atom_dc1594a9(__wf_atom_bca3f82a)
				local __wf_atom_2c7ac218 = __wf_atom_c67f9605:__wf_atom_2c7ac218(gGameData:__wf_atom_a04e4a53())
				local v66 = gGameRules:__wf_atom_93691ff2() % 86400
				local secondsToFormattedTime = module3.SecondsToFormattedTime(mMovie, 86400 - v66, "CompactOne")
				v51.DailyStandingInfo:SetProgress(
					__wf_atom_dc1594a9,
					__wf_atom_2c7ac218,
					"/Lotus/Language/Syndicates/DailyStandingRemainingTime",
					secondsToFormattedTime
				)
			else
				mMovie:__wf_atom_2dedec1a(v51.DailyStandingInfo.mClipName, 13, false)
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SellList.SyndicateInfo", 1)
			mMovie:__wf_atom_e57658c2("SellList.BottomLine", 1, __wf_atom_5e6e15c8 - 60)
			mMovie:__wf_atom_e57658c2("SellList.Amount", 1, __wf_atom_5e6e15c8 - 46)
			mMovie:__wf_atom_e57658c2("SellList.Total", 1, __wf_atom_5e6e15c8 - 46)
			v55 = 236
		end
	else
		mMovie:__wf_atom_2dedec1a("SellList.SyndicateRank", 13, false)
		mMovie:__wf_atom_2dedec1a("SellList.SyndicateInfo", 13, false)
		mMovie:__wf_atom_2dedec1a("SellList.DailyStandingInfo", 13, false)
	end

	v35 = mMovie:__wf_atom_5e6e15c8("SellList.BottomLine", 1) - mMovie:__wf_atom_5e6e15c8("SellList.TopLine", 1) - 26
	module3.RegisterHideHud(true)

	if inventory2 == v52.INVENTORY then
		v3 = gGameRules:__wf_atom_964056fd()
	end

	if not _T.UIInputEnabled then
		flag3 = true
		_T.EnableUIInput()
	end

	mMovie:__wf_atom_7df746cd(0)
	local v64

	if __wf_atom_8e4fda44:FindMovie(tennoWayMovie) == nil then
		v64 = 0.25
		mMovie:__wf_atom_e57658c2("_root", 12, 0)
		mMovie:__wf_atom_e57658c2("_root", 4, -5000)
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 4, 12 }, { 0, 100 }, v64)
	else
		v64 = 0
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(v64, nil, false)
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		gameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		v6 = __wf_atom_18a5d83b:Settings()
	end

	if inventory2 == v52.ENEMIES then
		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

		if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
			v5 = __wf_atom_2202ffb6:__wf_atom_7d789620()
		end

		fn50()
		fn44()
	end

	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)

	if not __wf_atom_7e8ad928(gameData) then
		local inventory3 = gameData:GetInventory()

		if not (__wf_atom_7e8ad928(inventory3) or module3.VerifyInventorySlots(inventory3, 1) and module3.VerifyInventorySlots(inventory3, 2)) then
			module3.ShowInvalidBinError("OnInvalidBinError")
		end
	end

	module6.DrawSeparator(mMovie, "SellList.TopLine", 380)
	module6.DrawSeparator(mMovie, "SellList.BottomLine", 380)
	module6.DrawSeparator(mMovie, "SellList.BottomLine2", 380)
	mMovie:__wf_atom_e57658c2("SellList.Tip", 14, mMovie:__wf_atom_5e6e15c8("SellList.List", 14))
	mMovie:__wf_atom_e57658c2("SellList.Tip", 0, mMovie:__wf_atom_5e6e15c8("SellList.List", 0))
	mMovie:__wf_atom_2dedec1a("ScrollBar", 13, false)
	local mSpeakerName = "/Lotus/Language/Menu/Loadout_Inventory"
	local sellBtnLabel = "/Lotus/Language/Menu/ItemSelection_Sell"
	local v65 = "/Lotus/Language/Menu/ItemInventory_Tip"

	if inventory2 == v52.PRIMEPARTS then
		sellBtnLabel = "/Lotus/Language/Menu/ItemInventory_SellingPrimeTitle"
	elseif inventory2 == v52.TREASURE then
		sellBtnLabel = "/Lotus/Language/Menu/ItemInventory_SellingTreasureTitle"
	elseif inventory2 == v52.SHIP_SCRAP then
		sellBtnLabel = (_T.InventoryInfo == nil or _T.InventoryInfo.MinSellAmount == nil)
			and "/Lotus/Language/Railjack/ItemInventory_SellingShipWreckageTitle"
			or mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/WreckageLimit_TitleWithCount", false, {
				COUNT = module4.FormatNumber(_T.InventoryInfo.MinSellAmount)
			})
		v65 = "/Lotus/Language/Railjack/ItemInventory_SellingShipWreckageTip"
	elseif inventory2 == v52.SHIP_PARTS then
		sellBtnLabel = "/Lotus/Language/Railjack/ItemInventory_SellingShipComponentsShortTitle"
		v65 = "/Lotus/Language/Railjack/ItemInventory_SellingShipComponentsTip"
	elseif inventory2 == v52.SHIP_RAW then
		sellBtnLabel = "/Lotus/Language/Railjack/ItemInventory_SellingShipWreckageTitle"
		v65 = "/Lotus/Language/Railjack/ItemInventory_SellingShipUnidentifiedTip"
	elseif inventory2 == v52.FISH then
		if not __wf_atom_7e8ad928(_T.CurrentConversation) then
			mSpeakerName = _T.CurrentConversation.mSpeakerName
		end

		sellBtnLabel = _T.FishInvInfo.SellBtnLabel
	elseif inventory2 == v52.ENEMIES then
		mSpeakerName = "/Lotus/Language/Menu/EnemySelector_Title"
		sellBtnLabel = "/Lotus/Language/Menu/EnemySelector_SubTitle"
		v65 = "/Lotus/Language/Menu/EnemySelector_Tip"
	elseif inventory2 == v52.DECODONATE then
		sellBtnLabel = "/Lotus/Language/Dojo/VaultContributionDeco"
	elseif inventory2 == v52.RESDONATE then
		sellBtnLabel = "/Lotus/Language/Categories/RESOURCES"
	elseif inventory2 == v52.SYNDDONATE then
		if not __wf_atom_7e8ad928(_T.CurrentConversation) then
			mSpeakerName = _T.CurrentConversation.mSpeakerName
			sellBtnLabel = "/Lotus/Language/Syndicates/Favors_RedeemReward"
		end
	elseif fn11() then
		sellBtnLabel = "/Lotus/Language/Dojo/Trade"
	else
		v65 = "/Lotus/Language/Labels/ItemInventory_SellTip"
	end

	fn7(mMovie:__wf_atom_8e9ac384(mSpeakerName, false), mMovie:__wf_atom_8e9ac384(sellBtnLabel, false))
	mMovie:__wf_atom_50d60589("SellList.Tip", 36, string.upper(mMovie:__wf_atom_8e9ac384(v65, true)))
	_T.ShowPrimeBucks = true

	if inventory2 == v52.TREASURE or inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
		_T.ShowFusionPoints = true
		_T.ShowPrimeBucks = nil
	end

	fn37()
	fn34()
	fn51()
	fn52()
	fn33(true)
	mMovie:__wf_atom_e57658c2("Mask", 15, v17.mRows * v17.mRowSeparation)
	fn46()
	local module13 = require("Lotus.Interface.Components.ThemedSpinner")
	v26 = module13.Create(mMovie, "Loading.Spinner")
	mMovie:__wf_atom_2dedec1a("SellList.Tip", 89, true)
	sell = v53.INVENTORY
	local flag9 = false

	if inventory2 == v52.ENEMIES then
		selectingEnemiesManifest = _T.SelectingEnemiesManifest

		if _T.StatScans == nil and not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_af5caba7 = __wf_atom_18a5d83b:__wf_atom_af5caba7()
			_T.StatScans = __wf_atom_af5caba7.mScans
		end

		fn48(_T.StatScans)
	elseif __wf_atom_7e8ad928(v3) then
		flag9 = true

		if inventory2 == v52.PRIMEPARTS then
			primeSellManifestType2 = primeSellManifestType
		elseif inventory2 == v52.TREASURE then
			primeSellManifestType2 = treasureSellManifestType
		elseif inventory2 == v52.FISH then
			primeSellManifestType2 = _T.SelectingFishManifest
		elseif inventory2 == v52.RESDONATE then
			primeSellManifestType2 = resDonateManifestType
		else
			primeSellManifestType2 = __wf_atom_c67f9605:__wf_atom_964056fd()
		end

		if not __wf_atom_7e8ad928(primeSellManifestType2) then
			primeSellManifestType2 = primeSellManifestType2:__wf_atom_5b41f63b()
			v4 = UISys.__wf_atom_c0dbe47c({ primeSellManifestType2 }, true)
		end
	end

	if flag9 then
		v19[v61.EXIT].mVisible = true
		fn6()
		v26:SetActive(flag9)
	else
		fn2()
	end

	v16 = true
	mMovie:__wf_atom_dac78d3d(true)
	_T.InventoryScreenOpen = true

	if __wf_atom_21342f4a ~= nil and gGameRules:IsA(__wf_atom_311a7128) and inventory2 == v52.INVENTORY then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "EQUIPMENT_INVENTORY")
	end

	if inventory2 == v52.INVENTORY then
		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local settings = __wf_atom_18a5d83b:Settings()

			if not __wf_atom_7e8ad928(settings) then
				v32 = settings:__wf_atom_76ec9be8()
			end
		end

		fn9(v32)
	end

	mMovie:__wf_atom_2dedec1a("SellList.Slider", 13, false)
	mMovie:__wf_atom_2dedec1a("SellList.SliderValue", 13, false)
	fn47()
end

local v62 = 0

local function fn53(_, _, _, _) end

function OnSellCompleted(p, p2)
	print("OnSellCompleted(result=" .. tostring(p) .. ", body=" .. tostring(p2) .. ")")
	v26:SetActive(false)
	v50 = nil

	if p then
		v62 = 0

		if not __wf_atom_7e8ad928(_T.Manifest) and inventory2 == v52.SHIP_PARTS then
			local mITEMS = _T.Manifest.mITEMS

			for i = 1, #mITEMS do
				fn53(mITEMS[i].StoreItem, mITEMS[i].Name, mITEMS[i].Count, 2)
			end
		end

		local _ = v20.mSellPrice > 0

		if inventory2 == v52.TREASURE and not __wf_atom_7e8ad928(_T.PlayBackgroundTransmission) then
			local count = 0
			local v63 = 0
			local v64 = 0

			for i = 1, #infoPopup_Grid.mElements do
				if infoPopup_Grid.mElements[i].IsCostElement then
					count += 1
				else
					v64 = i
				end
			end

			local v65

			if #infoPopup_Grid.mElements - count == 1 and infoPopup_Grid.mElements[v64].Count == 1 then
				v65 = module4.Ternary(__wf_atom_8d119bab(0, 1) <= 0.3, "SellGeneric", "")

				if v65 == "" then
					local mElement = infoPopup_Grid.mElements[v64]
					local v67

					if __wf_atom_7e8ad928(mElement.MatchedSockets) then
						v67 = math.max(v63, 1)
					elseif mElement.MatchedSockets == #mElement.Sockets then
						v67 = math.max(v63, 3)
					else
						v67 = math.max(v63, 2)
					end

					v65 = ({ "StarsOnly", "SculptureOnly", "CompleteTreasure" })[v67]
				end
			else
				for i = 1, #infoPopup_Grid.mElements do
					local mElement = infoPopup_Grid.mElements[i]

					if mElement.IsCostElement then
						continue
					end

					if __wf_atom_7e8ad928(mElement.MatchedSockets) then
						v63 = math.min(math.max(v63, 1), 2)
					elseif mElement.MatchedSockets == 0 then
						v63 = math.min(math.max(v63, 1), 2)
					elseif mElement.MatchedSockets == #mElement.Sockets then
						if v63 == 0 or v63 == 3 then
							v63 = 3
						else
							v63 = 2
						end
					else
						v63 = 2
					end
				end

				v65 = ({ "SellGroupEmpty", "SellGroupPartialFull", "SellGroupAllFull" })[v63]
			end

			_T.LypSyncDeco = _T.MarooDeco

			if _T.PlayBackgroundTransmission(v65, transmissionSet) then
				_T.PlayBackgroundTransmission("AnythingElsePrompt", transmissionSet, 2)
			end
		elseif inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_PARTS or inventory2 == v52.SHIP_RAW then
			_T.ShipParts_Sold = true
		end

		if _T.InventoryInfo ~= nil and _T.InventoryInfo.MinSellAmount ~= nil then
			fn15(true)
		end

		infoPopup_Grid:RemoveElements()
		fn21(-total)
		fn2()
		fn16()
		module3.RefreshPetsAfterSell()
	else
		print("Inventory Sale Fail: " .. p2)
		module4.ShowMessage("/Lotus/Language/Menu/Item_SaleFailed")
		flag2 = false
	end
end

function OnSellConfirmed(p)
	v30 = false

	if __wf_atom_7e8ad928(gGameData) or tonumber(p) ~= 4 then
		flag2 = false
		return
	end

	v26:SetActive(true)
	assert(v50 == nil)
	v50 = SF.SellCommand(v20, "OnSellCompleted")
	v50:Execute()
	module4.PlaySound(_G.UISound_SweetenerTwo)
end

local function fn54(category)
	local inventory3 = gGameData:GetInventory()
	local v63 = nil
	local flag9 = false

	if category == 0 then
		v63 = inventory3:__wf_atom_20b04548()
		flag9 = true
	elseif category == 1 then
		v63 = inventory3:__wf_atom_4f67b86c()
		flag9 = true
	elseif category == 3 then
		v63 = inventory3:__wf_atom_ebdc4e6e()
		flag9 = true
	elseif category == 5 then
		v63 = inventory3:__wf_atom_4259c789()
		flag9 = true
	elseif category == 16 then
		if #inventory3:__wf_atom_db1ae7f4() > 0 then
			v63 = inventory3:__wf_atom_1273f04d()
			flag9 = true
		end
	elseif category == 6 then
		flag9 = true
	elseif category == 15 then
		v63 = inventory3:__wf_atom_db1ae7f4()
		flag9 = true
	elseif category == 24 then
		v63 = inventory3:__wf_atom_9ddc0f59()
		flag9 = true
	elseif category == 27 then
		v63 = inventory3:__wf_atom_ff7d29fb()
		flag9 = true
	elseif category == 28 then
		v63 = inventory3:__wf_atom_546ac461()
		flag9 = true
	elseif category == 29 then
		v63 = inventory3:__wf_atom_50f906c7()
		flag9 = true
	elseif category == 39 then
		v63 = inventory3:__wf_atom_260a9632()
		flag9 = true
	elseif category == 41 then
		v63 = inventory3:__wf_atom_072f6737()
		flag9 = true
	elseif category == 50 then
		v63 = inventory3:__wf_atom_95117674()
		flag9 = true
	elseif category == 48 then
		v63 = inventory3:__wf_atom_a76bb6ec()
	end

	local count

	if v63 == nil then
		count = -1
	else
		count = #v63

		if flag9 then
			for i = 1, #v63 do
				if v63[i]:__wf_atom_ae27679c() then
					count -= 1
				end
			end
		end
	end

	return { Count = count, CanHaveExpirables = flag9 }
end

local function fn55()
	if __wf_atom_7e8ad928(v3) then
		return
	end

	v20.mSellCurrency = 5
	local v63 = {}

	for _, mElement in ipairs(infoPopup_Grid.mElements) do
		v20:SellItem(mElement.Category, mElement.UID, 1)

		for _, itemPrice in ipairs(mElement.ItemPrices) do
			local __wf_atom_5b41f63b = itemPrice.mItemType:__wf_atom_5b41f63b()
			v63[__wf_atom_5b41f63b] = (v63[__wf_atom_5b41f63b] or 0) + itemPrice.mItemCount
		end
	end

	local mITEMS = {}

	for k, count in pairs(v63) do
		local __wf_atom_232fd31d = v3:__wf_atom_232fd31d(WeakResource(k))
		local iconTexture, themed = module2.GetIconTexture(__wf_atom_232fd31d, true)
		table.insert(mITEMS, {
			Name = Localize(tostring(__wf_atom_232fd31d:__wf_atom_014a76a2()), {}),
			StoreItem = __wf_atom_232fd31d,
			Count = count,
			Icon = iconTexture,
			Themed = themed,
			LocalizedDesc = Localize(tostring(__wf_atom_232fd31d:__wf_atom_3a3d2e39()), {})
		})
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/SellRepairedSalvage", false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_CancelBuildSubtitle", false)
	_T.Manifest = {
		TITLE = __wf_atom_8e9ac384,
		TIP = __wf_atom_8e9ac384_2,
		mITEMS = mITEMS,
		CONFIRM_LABEL = "/Lotus/Language/Menu/ItemSelection_OK"
	}
	v48 = mMovie:PushChildMovie(graphicManifestMovie)

	if not __wf_atom_7e8ad928(v48) then
		v48:Execute("SetCallback", "OnSellConfirmed")
	end
end

function SellWithManifest()
	if flag2 or (v30 or __wf_atom_7e8ad928(gGameData)) then
		return
	end

	v20 = SF.SellOperation()

	if inventory2 == v52.SHIP_PARTS then
		fn55()
		return
	end

	if inventory2 == v52.PRIMEPARTS then
		v20.mSellCurrency = 1
	elseif inventory2 == v52.TREASURE or inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
		v20.mSellCurrency = 2
	end

	local v63 = {}
	local v64 = {}
	total2 = 0
	local total3 = 0

	for i = 1, #infoPopup_Grid.mElements do
		__wf_atom_83c14687(0)
		local mElement = infoPopup_Grid.mElements[i]

		if mElement.SellingPrice == nil then
			continue
		end

		local category = mElement.Category

		if category == 18 and gGameData:__wf_atom_a734151e(mElement.UID) then
			module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_CantSellResourceDrone")
			return
		end

		local ternary = module4.Ternary(mElement.Count ~= nil, mElement.Count, 1)
		local sellingPrice, v65

		if mElement.UID == nil or mElement.UID == "" or category ~= 4 then
			sellingPrice = mElement.SellingPrice * ternary
			v65 = ternary
		else
			sellingPrice = mElement.SellingPrice
			v65 = 0
		end

		local ternary2 = module4.Ternary(mElement.UID ~= nil, mElement.UID, mElement.Type:__wf_atom_5b41f63b())

		if category == 34 then
			ternary2 = mElement.RawItem:__wf_atom_4b2b635c()
		end

		v20:SellItem(category, ternary2, v65)

		if v63[category] == nil then
			v63[category] = 1
			v64[category] = fn54(category)
		else
			v63[category] += 1
		end

		if
			(v64[category] == nil or not v64[category].CanHaveExpirables) and category ~= 24
			or not mElement.RawItem:__wf_atom_ae27679c()
		then
			total2 += sellingPrice
			total3 += ternary
		else
			module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_CantSellTimeLimited")
			return
		end
	end

	v20.mSellPrice = total2

	for k, v65 in pairs(v63) do
		if not (v64[k] ~= nil and v64[k].Count >= 0 and v64[k].Count <= v65) then
			continue
		end

		if k == 15 then
			module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_CantSellLastSentinel")
		else
			module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_CantSellLastWeapon")
		end

		return
	end

	if v20.mSellPrice == 0 then
		module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_NothingCanBeSold")
		return
	end

	flag2 = true
	v30 = true
	local v65 = "/Lotus/Language/Menu/ConfirmSellFormattedPrice"
	local v66 = "/Lotus/Language/Menu/" .. module4.Ternary(
		total3 > 1,
		"ItemInventory_MiscItemPlural",
		"ItemInventory_MiscItemSingular"
	)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v66, false, {
		NUMBER = module4.FormatNumber(total3)
	})
	local formatNumber = module4.FormatNumber(total2)
	local v67

	if inventory2 == v52.PRIMEPARTS then
		v67 = "<PRIME_BUCKS>" .. formatNumber
	elseif inventory2 == v52.TREASURE or inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
		v67 = "<FUSION_POINTS>" .. formatNumber

		if inventory2 == v52.SHIP_SCRAP or inventory2 == v52.SHIP_RAW then
			v65 = "/Lotus/Language/Railjack/ConfirmScrap"
		end
	else
		v67 = "<CREDITS>" .. formatNumber
	end

	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v65, true, {
		ITEMS = __wf_atom_8e9ac384,
		FORMATTED_PRICE = v67
	})
	module4.ShowYesOrNoMessage(__wf_atom_8e9ac384_2, "OnSellConfirmed")
end

function LoadEnemies()
	if flag2 then
		return
	end

	if v10 < total then
		module4.ShowErrorMessage("/Lotus/Language/Menu/EnemySelector_MaxCountReached")
		return
	end

	v26:SetActive(true)
	local v63 = {}
	_T.SpawnedEnemies = {}
	infoPopup_Grid:RunForAllElements(function(data)
		if not __wf_atom_7e8ad928(data.Type) then
			table.insert(v63, data.Type:__wf_atom_5b41f63b())
			table.insert(v63, data.SourceType:__wf_atom_5b41f63b())
			table.insert(_T.SpawnedEnemies, {
				Type = data.Type,
				SourceType = data.SourceType,
				Count = data.Count
			})
		end
	end)

	if
		not __wf_atom_7e8ad928(_T.SpawnedEnemies)
		and #_T.SpawnedEnemies ~= 0
		and not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(__wf_atom_a0f6588f))
	then
		local simulacrumSpawnedEnemies = {}

		for i = 1, #_T.SpawnedEnemies do
			local simulacrumSpawnedEnemy = Engine.SimulacrumSpawnedEnemy()
			simulacrumSpawnedEnemy.enemyType = _T.SpawnedEnemies[i].Type:__wf_atom_5b41f63b()
			simulacrumSpawnedEnemy.resourceType = _T.SpawnedEnemies[i].SourceType:__wf_atom_5b41f63b()
			simulacrumSpawnedEnemy.enemyAmount = _T.SpawnedEnemies[i].Count
			simulacrumSpawnedEnemies[i] = simulacrumSpawnedEnemy
		end

		v6:__wf_atom_b3580b5d(simulacrumSpawnedEnemies)
		__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
	end

	flag2 = true
	v8 = true
	v9 = UISys.__wf_atom_c0dbe47c(v63)
end

function Close()
	fn13()
end

function ExitScreen()
	fn15()
end

function onKeyUp_MENU_CANCEL()
	if flag2 then
		return
	end

	if v17.mSortMenu:IsExpanded() then
		mMovie:__wf_atom_f944f6fa(0.15)
	end

	if sell == v53.INVENTORY and v17:onKeyUp_MENU_CANCEL() then
		return
	end

	v19[v61.EXIT].mCallback()
end

function GridItemFocused(p)
	if not __wf_atom_7e8ad928(v17) then
		v17:FocusElementById((tonumber(p)))
	end
end

function GridItemUnfocused(p)
	if not __wf_atom_7e8ad928(v17) then
		v17:UnfocusElementById((tonumber(p)))
	end
end

function GridItemPressed(p)
	if not (flag2 or __wf_atom_7e8ad928(v17)) then
		v17:SelectElementById(tonumber(p), true)
	end
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v17.mCategoryMenu) then
		v17.mCategoryMenu:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v17.mCategoryMenu) then
		v17.mCategoryMenu:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag2 or __wf_atom_7e8ad928(v17.mCategoryMenu)) then
		v17.mCategoryMenu:SelectElementById(tonumber(p), true)

		if inventory2 == v52.FISH then
			if p == "1" then
				v19[v61.FISH_CATEGORY].mLabel = "/Lotus/Language/Menu/ItemInventory_SelectAll"
			elseif p == "2" then
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategorySmall",
					true
				)
				v19[v61.FISH_CATEGORY].mLabel = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategory",
					false,
					{ CATEGORY = __wf_atom_8e9ac384 }
				)
			elseif p == "3" then
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategoryMedium",
					true
				)
				v19[v61.FISH_CATEGORY].mLabel = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategory",
					false,
					{ CATEGORY = __wf_atom_8e9ac384 }
				)
			elseif p == "4" then
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategoryLarge",
					true
				)
				v19[v61.FISH_CATEGORY].mLabel = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/UiElements/SelectAllFishCategory",
					false,
					{ CATEGORY = __wf_atom_8e9ac384 }
				)
			end

			fn6()
		end
	end
end

function SortByFocused(_) end

function SortByUnfocused(_) end

function SortByPressed(_) end

function onKeyUp_MENU_LTRIGGER2()
	if not (flag2 or __wf_atom_7e8ad928(v17)) then
		v17:OnCategoryPress(module4.DECREMENT, false)
	end

	return true
end

function onKeyUp_MENU_RTRIGGER2()
	if not (flag2 or __wf_atom_7e8ad928(v17)) then
		v17:OnCategoryPress(module4.INCREMENT, false)
	end

	return true
end

function onKeyDown_MENU_LTRIGGER2()
	if not (flag2 or __wf_atom_7e8ad928(v17)) then
		v17:OnCategoryPress(module4.DECREMENT, true)
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (flag2 or __wf_atom_7e8ad928(v17)) then
		v17:OnCategoryPress(module4.INCREMENT, true)
	end

	return true
end

function DropDownArrowPressed()
	if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v17.mSortMenu)) then
		v17.mSortMenu:ArrowPressed()
	end
end

function DropDownArrowFocused()
	if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v17.mSortMenu)) then
		v17.mSortMenu:ArrowFocused()
	end
end

function DropDownArrowUnfocused()
	if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v17.mSortMenu)) then
		v17.mSortMenu:ArrowUnfocused()
	end
end

function IsInputBlocked()
	return flag2
end

function SelectAllCategoryItems()
	sell = v53.INVENTORY
	v17:RunForAllVisibleElements(function(p)
		if not p.Filler then
			fn3(p)
		end
	end)
	local focusedElement = infoPopup_Grid:GetFocusedElement()

	if not __wf_atom_7e8ad928(focusedElement) then
		mMovie:Execute("SellListItemUnfocused", focusedElement.Id)
	end
end

fn3 = function(p)
	if not __wf_atom_7e8ad928(p) then
		fn28(p, false, true)
		return
	end

	if not __wf_atom_7e8ad928(v17) then
		local focusedElement = v17:GetFocusedElement()

		if not __wf_atom_7e8ad928(focusedElement) then
			module4.PlaySound(_G.UISound_Select)
			fn28(focusedElement, false, true)
			return
		end
	end

	if not __wf_atom_7e8ad928(infoPopup_Grid) then
		local focusedElement = infoPopup_Grid:GetFocusedElement()

		if not __wf_atom_7e8ad928(focusedElement) then
			fn28(focusedElement)
		end
	end
end

function RollOver()
	module4.PlaySound(_G.UISound_Focus)
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	local ternary = module4.Ternary(sell == v53.SELL, infoPopup_Grid.mScrollBar, v17.mScrollBar)

	if not (flag2 or __wf_atom_7e8ad928(ternary)) then
		ternary:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function OKSaveSelectedCount(p, p2)
	local unfilteredElementById = v17:GetUnfilteredElementById(id)

	if p2 ~= nil and tonumber(p2) == 1 and tonumber(p) > 0 and not __wf_atom_7e8ad928(unfilteredElementById) then
		fn23(unfilteredElementById, nil, tonumber(p))
	end
end

function HandleCanBeClosed(p)
	if not module3.IsInHub() then
		module3.MakeMainMenuAvatarKneel()
	end

	if not _T.LoadoutSaveRequired or _T.loadoutInProgress == nil or __wf_atom_7e8ad928(gameData) then
		return
	end

	v23 = p
	flag5 = true

	for i = 0, 3 - 1 do
		gameData:GetInventory():__wf_atom_337fac69(i, _T.loadoutInProgress[i])
	end

	gameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
	_T.loadoutInProgress = nil
	_T.LoadoutSaveRequired = nil
	return true
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v26) then
		v26:OnViewportSizeChanged()
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:Update(p, p2)
	end

	if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(infoPopup_Grid)) then
		fn33()
	end
end

function onRawInputEvent(_, value, p)
	if string.find(value, "MOUSE_B2") ~= nil and p == "0" then
		fn3()
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	if not flag2 then
		fn15()
	end

	return true
end

function SetOnMarkedToSellFunction(p)
	v24 = p
end

function OnStyleChangedCallback()
	fn47()

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end
end

function OnGamepadTransition(_)
	if v19[v61.SELECT_ALL] ~= nil then
		local v63 = v19[v61.SELECT_ALL]
		v63.mVisible = inventory2 ~= v52.FISH
			and inventory2 ~= v52.ENEMIES
			and inventory2 ~= v52.SHIP_SCRAP
			and inventory2 ~= v52.SHIP_PARTS
			and inventory2 ~= v52.SHIP_RAW
			and Engine.IsPlayingWithController()
	end

	fn6()
end

function SupportsThemes()
	return true
end

fn = function()
	if __wf_atom_7e8ad928(selectingEnemiesManifest) then
		return
	end

	local __wf_atom_19f75a1e = selectingEnemiesManifest:__wf_atom_19f75a1e()
	local v63 = nil

	for i = 1, #__wf_atom_19f75a1e do
		if __wf_atom_19f75a1e[i].tag:c_str() ~= "Enemy" then
			continue
		end

		v63 = __wf_atom_19f75a1e[i]
		break
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/EnemySelector_Locked", false)
	local __wf_atom_8b42d704 = __wf_atom_8b42d704

	local function fn56(faction)
		local v64 = {}

		if faction == nil then
			return v64
		end

		local v65 = string.upper(faction:c_str())

		if v65 == "GRINEER" then
			table.insert(v64, v58.GRINEER)
			return v64
		elseif v65 == "CORPUS" then
			table.insert(v64, v58.CORPUS)
			return v64
		elseif v65 == "INFESTATION" then
			table.insert(v64, v58.INFESTED)
			return v64
		elseif v65 == "NEUTRAL" then
			table.insert(v64, v58.WILD)
			return v64
		elseif v65 == "OROKIN" then
			table.insert(v64, v58.OROKIN)
			return v64
		elseif v65 == "SENTIENT" then
			table.insert(v64, v58.SENTIENT)
			return v64
		end

		if v65 == "NARMER" then
			table.insert(v64, v58.NARMER)
		end

		return v64
	end

	local __wf_atom_e118295b = selectingEnemiesManifest:__wf_atom_e118295b(v63)

	for i = 1, #__wf_atom_e118295b do
		local codexEntry = __wf_atom_e118295b[i]
		local kind = codexEntry.type
		local v65 = scans[kind:__wf_atom_5b41f63b()] or 0
		local v66 = true
		local v67 = true
		local v68 = false
		local scannedId = 3

		if __wf_atom_421b01aa(v65 / codexEntry.reqScans, 0, 1) == 1 then
			v67 = false
			v66 = false
			scannedId = 1
		elseif v65 > 0 then
			v67 = false
			scannedId = 2
		end

		if
			codexEntry.excludedFromSimulacrum
			or not __wf_atom_7e8ad928(kind) and string.find(kind:__wf_atom_5b41f63b(), "SpaceBattle") ~= nil
		then
			v68 = true
		elseif kind:IsA(__wf_atom_8b42d704) then
			v68 = true

			for j = 1, #simulacrumSpawnableBossTypes do
				if kind ~= simulacrumSpawnableBossTypes[j] then
					continue
				end

				v68 = false
				break
			end
		end

		if flag then
			v68 = false
		end

		if v68 then
			continue
		end

		local sourceType = codexEntry.sourceType

		if __wf_atom_7e8ad928(sourceType) and not __wf_atom_7e8ad928(kind) then
			if #missingCodexEnemyAvatarTypes == #missingCodexEnemyAgentTypes then
				for j = 1, #missingCodexEnemyAvatarTypes do
					if missingCodexEnemyAvatarTypes[j] ~= kind then
						continue
					end

					sourceType = missingCodexEnemyAgentTypes[j]
					break
				end
			else
				print("Mismatch between codex enemy lists: missingCodexEnemyAvatarTypes and missingCodexEnemyAgentTypes")
			end
		end

		if __wf_atom_7e8ad928(sourceType) then
			continue
		end

		local categories = fn56(codexEntry.faction)
		local localizedName = module9.GetLocalizedName(mMovie, codexEntry)
		local iconColor, shadowIcon

		if v67 and not v7 then
			iconColor = 8
			shadowIcon = true
		else
			shadowIcon = false
		end

		local v73 = {
			Name = localizedName,
			Categories = categories,
			Themed = true,
			CodexEntry = codexEntry,
			Icon = codexEntry.icon,
			Type = kind,
			SourceType = sourceType,
			IsLeader = codexEntry.isLeader,
			Hidden = v67 and not v7,
			Locked = v66 and not v7,
			LockedMsg = __wf_atom_8e9ac384,
			IconColor = iconColor,
			ShadowIcon = shadowIcon,
			ScannedId = scannedId,
			SellingPrice = 1
		}
		v73.SearchCache = __wf_atom_d99ae0ec(v73.Name .. " " .. codexEntry.faction:c_str())
		v17:AddElement(v73, true)

		if _T.SpawnedEnemies == nil then
			continue
		end

		for _, spawnedEnemy in ipairs(_T.SpawnedEnemies) do
			if spawnedEnemy.Type ~= kind:__wf_atom_5b41f63b() or (v73.Hidden or v73.Locked) then
				continue
			end

			fn23(v73, nil, spawnedEnemy.Count)
		end
	end

	if flag then
		local sourceType = WeakResource("/Lotus/Types/Enemies/Grineer/AIWeek/LoboGrineerLancer")
		local v65 = {
			Name = "PUNCHING BAG",
			Categories = { v58.GRINEER },
			Themed = true,
			CodexEntry = nil,
			Icon = categoryIcons[1],
			Type = sourceType,
			SourceType = sourceType,
			IsLeader = false,
			Hidden = false,
			Locked = false,
			LockedMsg = "",
			IconColor = nil,
			ShadowIcon = true,
			ScannedId = 1,
			SellingPrice = 1
		}
		v65.SearchCache = __wf_atom_d99ae0ec(v65.Name)
		v17:AddElement(v65, true)
	end
end

function FishFunctionCancelled()
	mMovie:__wf_atom_e57658c2("InventoryGrid", 12, 100)
	fn33(true)
	flag2 = false
end

function FishFunction()
	mMovie:__wf_atom_e57658c2("InventoryGrid", 12, 0)
	_T[_T.FishInvInfo.FunctName](infoPopup_Grid.mElements)
	flag2 = true
end

local function fn56(p)
	local syndicate = _T.SyndicateInvInfo.Syndicate
	v51.SyndicateStandingBonusOperation = SF.SyndicateStandingBonusOperation()
	v51.SyndicateStandingBonusOperation.mAffiliationTag = syndicate:__wf_atom_e0f044e1()
	local total3 = 0
	infoPopup_Grid:RunForAllElements(function(data)
		total3 += data.Count * data.RawItem.mStanding
		v51.SyndicateStandingBonusOperation:AddItem(data.Type, data.Count)
	end)
	assert(total3 == total)
	local _, v63, v64, _, v65 = module3.GetReputationInfoForSyndicate(syndicate)

	if not syndicate:__wf_atom_73f36e1b() then
		if v64 < 0 then
			v65 = math.abs(v63)
		else
			v65 = v64 - v63
		end
	end

	if not p then
		if v65 == 0 then
			local __wf_atom_bca3f82a = syndicate:__wf_atom_bca3f82a()
			local v66 = __wf_atom_bca3f82a > 0
				and __wf_atom_bca3f82a < 3
				and gameData:__wf_atom_dc1594a9(__wf_atom_bca3f82a) == 0
				and "/Lotus/Language/Menu/Syndicates_DogTag_DailyLimit_Reached"
				or "/Lotus/Language/Menu/Syndicates_ReputationOverflow"
			module4.ShowErrorMessage(v66)
		elseif v65 < total then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Syndicates_DogTag_StandingWasteWarning",
				true,
				{
					STANDING = module4.FormatNumber(total - v65)
				}
			)
			module4.ShowYesOrNoMessage(__wf_atom_8e9ac384, "ConfirmDogTagPartial")
			return
		end
	end

	local v66 = total
	local rep = math.min(total, v65)
	local v68 = {}
	table.insert(v68, { Name = syndicate:__wf_atom_818ea3a7(), Rep = rep })

	for _, v69 in ipairs(syndicate:__wf_atom_27217f21()) do
		if not __wf_atom_7e8ad928(v69.other) then
			table.insert(v68, {
				Name = Resource(v69.other:__wf_atom_5b41f63b()):__wf_atom_818ea3a7(),
				Rep = v66 * v69.multiplier
			})
		end
	end

	table.sort(v68, function(a, b)
		return a.Rep > b.Rep
	end)
	local changes = ""

	for _, v70 in ipairs(v68) do
		changes ..= module4.FormatNumber(v70.Rep, 0) .. " " .. string.upper(mMovie:__wf_atom_8e9ac384(v70.Name:c_str(), false)) .. "\r"
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/StandingChangeConfirm", false, {
		CHANGES = changes
	})
	module4.ShowYesOrNoMessage(__wf_atom_8e9ac384, "ConfirmDogTagAll")
end

function DonateDogTags()
	fn56()
end

function ConfirmDogTagPartial(p)
	if tonumber(p) == 4 then
		fn56(true)
	end
end

function ConfirmDogTagAll(p)
	if tonumber(p) == 4 then
		gameData:__wf_atom_4180443b(v51.SyndicateStandingBonusOperation, "OnDonateDogTagsComplete")
		local activeSoundSet = module3.GetActiveSoundSet()
		local redeemStandingSound = redeemStandingSounds[activeSoundSet]

		if not __wf_atom_7e8ad928(redeemStandingSound) then
			module4.PlaySound(redeemStandingSound)
		end
	end
end

function OnDonateDogTagsComplete(p, p2)
	if not p or __wf_atom_7e8ad928(_T.SyndicateInvInfo.Syndicate) then
		return
	end

	local syndicate = _T.SyndicateInvInfo.Syndicate
	local vendorTag = _T.SyndicateInvInfo.VendorTag
	v51.MadeTrade = true
	local decoded = cjson.decode(p2)

	if decoded.AffiliationMods ~= nil then
		local v63 = tostring(syndicate:__wf_atom_e0f044e1())

		for _, affiliationMod in ipairs(decoded.AffiliationMods) do
			if not (affiliationMod.Tag ~= nil and affiliationMod.Tag == v63) then
				continue
			end

			if affiliationMod.Standing ~= nil and affiliationMod.Standing > 0 then
				_T.StandingSyndicateRewarded = syndicate
				_T.StandingRewarded = affiliationMod.Standing
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(v57)
			end

			break
		end
	end

	if vendorTag ~= nil then
		local v63 = "DogTagRedeemed"

		if vendorTag ~= EMPTY_SYMBOL then
			v63 ..= vendorTag:c_str()
		end

		module8.PlaySyndicateTransmission(syndicate, v63)
	end

	fn15()
end

function ConvertShards()
	_T.ShardSelected(infoPopup_Grid.mElements)
	fn15()
end

function DonateDecorations()
	_T.DecosSelected(infoPopup_Grid.mElements)
	fn15()
end

function TradeItems()
	if __wf_atom_7e8ad928(gameData) then
		return
	end

	local v63 = {}
	local v64 = {}

	for i = 1, #infoPopup_Grid.mElements do
		__wf_atom_83c14687(0)
		local mElement = infoPopup_Grid.mElements[i]

		if mElement.Category == nil then
			continue
		end

		local category = mElement.Category

		if v63[category] == nil then
			v63[category] = 1
			v64[category] = fn54(category)
		else
			v63[category] += 1
		end
	end

	for k, v65 in pairs(v63) do
		if not (v64[k] ~= nil and v64[k].Count >= 0 and v64[k].Count <= v65) then
			continue
		end

		module4.ShowMessage("/Lotus/Language/Menu/ItemInventory_CantSellLastWeapon")
		return
	end

	_T.TradeItemsSelected(infoPopup_Grid.mElements)
	fn15()
end

fn7 = function(p, p2, p3)
	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(p, p2, p3)
	end
end

function SetTitle(p)
	fn7(p, nil, true)
end

function HideScreenForPlatPurchase(p)
	if p == "true" then
		v47 = false
		return
	end

	v47 = true
	fn33(true)
end

function SetCallback(p)
	v21 = p
end

function SetExtraInfoCallback(p)
	v22 = p
end