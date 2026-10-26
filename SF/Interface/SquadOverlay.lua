local module = require("EE.Interface.Utilities")
local module2 = require("EE.Interface.AnchorMgr")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
Resource("/Lotus/Fx/Interface/ProfileIconChanged")
local module6 = require("SF.Interface.Components.CurrencyBar")
local module7 = require("SF.Interface.Components.SquadPanel")
local v = getfenv(1)
local v2 = { "PlayerDropdown", "InviteToSquad", "LeaveSquad" }
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = {}
local mVisible = nil
local v7 = nil
local v8 = 0
local v9 = 0
local v10 = false
local v11 = false
local v12 = 0
local topMenuBackerHeight2 = 0
local v13 = 0
local v14 = false

local function fn()
	mMovie:__wf_atom_2dedec1a("SquadInfo.Players", 13, v11)

	if not __wf_atom_7e8ad928(_T.TopMenuMovie) then
		_T.TopMenuMovie:Execute("UpdateMaskArea", "")
	end
end

local function fn2(p)
	v13 = v12 + p
	local visibilitySize = module.GetVisibilitySize(mMovie, v13)
	mMovie:__wf_atom_1ca72041("SquadInfo.Players.Backer", "VisibilitySize", visibilitySize, 0, 0, 0)
end

local function fn3(p)
	local v15 = math.floor(p)
	local mPlayerInfo = v5.mPlayerInfo

	for i = v15, 1, -1 do
		local v16 = mPlayerInfo[i]

		if not v16 or mMovie:__wf_atom_1b848254(v16.mClipName) then
			break
		end

		__wf_atom_ec43d06e(mMovie, v16.mClipName, 2, { 12 }, { 100 }, 0.2)
		local v17 = v16.mNew and 6 or 2
		__wf_atom_ec43d06e(mMovie, v16.mClipName .. ".Profile", v17, { 5, 6 }, { 100, 100 }, 0.1)
		v16.mNew = false
	end
end

local function fn4(p)
	local mPlayerInfo = v5.mPlayerInfo

	for i = #mPlayerInfo - math.floor(p), #mPlayerInfo do
		local v15 = mPlayerInfo[i]

		if v15 and not mMovie:__wf_atom_1b848254(v15.mClipName) then
			__wf_atom_ec43d06e(mMovie, v15.mClipName, 0, { 12 }, { 0 }, 0)
			__wf_atom_ec43d06e(mMovie, v15.mClipName .. ".Profile", 0, { 5, 6 }, { 1, 1 }, 0)
		else
			break
		end
	end
end

local function fn5()
	local v15 = mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.List", 1) - v9 / 2
	v8 = v9 * #v5.mPlayerInfo
	v8 += v15 * 2
	v12 = v13
	local count = #v5.mPlayerInfo

	if v10 then
		v11 = true
		local v16 = v8 + mMovie:__wf_atom_5e6e15c8("SquadInfo.Players", 3)
		mMovie:__wf_atom_e57658c2(
			"SquadInfo.Players.Backer",
			15,
			v16 + 20 - mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 3)
		)
		topMenuBackerHeight2 = v16 * 2
		__wf_atom_ec43d06e(mMovie, "FadePlayers", 0, { fn3 }, { count }, fadeInTime)
		__wf_atom_ec43d06e(mMovie, "FadePlayerDropdownBacker", 22, { fn2 }, { topMenuBackerHeight2 - v12 }, fadeInTime)
	else
		topMenuBackerHeight2 = topMenuBackerHeight
		__wf_atom_ec43d06e(mMovie, "FadePlayers", 22, { fn4 }, { count }, fadeOutTime)
		__wf_atom_ec43d06e(
			mMovie,
			"FadePlayerDropdownBacker",
			22,
			{ fn2 },
			{ topMenuBackerHeight2 - v12 },
			fadeOutTime,
			0,
			function()
				v11 = false
				fn()
			end
		)
	end

	fn()
end

function PlayerDropdownCallback(p)
	v10 = not v10

	if p ~= nil then
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 6, -100)
	end

	if v10 then
		for k, v15 in v5.mPlayerInfo do
			v5:UpdateSquadPlayer(v15.mPlayer, k, true)
		end
	end

	fn5()
end

function InviteToSquadCallback(_)
	v5:OnInvite()
end

function InviteToSquadVisible()
	return #v5.mPlayerInfo < module3.MAX_SQUAD_SIZE
end

function LeaveSquadCallback(_)
	v5:LeaveSquadPressed()
	mVisible = nil
end

function LeaveSquadVisible()
	return #v5.mPlayerInfo > 1 or _G.matchmakingTimeoutActive
end

function SquadPanelFocused()
	mMovie:__wf_atom_290807ee("SquadPanelFocus")
end

function SquadPanelUnfocused(value)
	if not v14 then
		__wf_atom_ec43d06e(mMovie, "SquadPanelFocus", 0, {}, {}, 0, value or 0.5, function()
			if v10 then
				PlayerDropdownCallback(v6[1])
			end
		end)
	end
end

local function fn6(p)
	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_a4299765():__wf_atom_1860f6b3(p)
	end

	gMatchingService:__wf_atom_27e16961()

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local __wf_atom_a4299765 = __wf_atom_eab484a7:__wf_atom_a4299765()

			if not __wf_atom_7e8ad928(__wf_atom_a4299765) then
				__wf_atom_a4299765:__wf_atom_1860f6b3(p)
			end
		end
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) and __wf_atom_15811761:__wf_atom_e6770097() then
		print("SetProfileIcon - SendLobbyLoadout")
		gGameRules:SendLobbyLoadout()
	end

	if _T.RefreshPlayerIcon then
		_T.RefreshPlayerIcon()
	end
end

local function fn7(item)
	local __wf_atom_da43e3f3 = gGameData:GetInventory():__wf_atom_da43e3f3()

	for _, v15 in ipairs(__wf_atom_da43e3f3) do
		if v15.mItemType ~= item then
			continue
		end

		fn6(v15)
		break
	end
end

function OnSaveLoadOutComplete() end

local function fn8()
	local v15 = {
		Title = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Profile_ChangeAvatarImage", false),
		PopulateElements = function()
			local __wf_atom_a6382ae5 = gGameData:__wf_atom_a4299765():__wf_atom_a6382ae5()
			local __wf_atom_da43e3f3 = gGameData:GetInventory():__wf_atom_da43e3f3()
			local v15 = {}

			for _, v16 in ipairs(__wf_atom_da43e3f3) do
				local mItemType = v16.mItemType

				if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(__wf_atom_746ce1f6) then
					continue
				end

				v15[mItemType:__wf_atom_5b41f63b()] = v16
			end

			local storeItems = gGameRules:__wf_atom_964056fd():GetStoreItems()
			local storeItemInfos = {}

			for _, storeItem in ipairs(storeItems) do
				if __wf_atom_7e8ad928(storeItem) then
					continue
				end

				local item = storeItem:GetItem()

				if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_746ce1f6) then
					continue
				end

				local itemInfo = v15[item:__wf_atom_5b41f63b()]
				local storeItemPriceObject = module4.GetStoreItemPriceObject(storeItem)

				if storeItem:AlwaysAvailable() then
					itemInfo = SF.FlavourItem()
					itemInfo.mItemType = storeItem:GetItem()
				end

				if itemInfo == nil then
					if storeItemPriceObject.ShowInMarket then
						local storeItemInfo = module5.GetStoreItemInfo(mMovie, storeItem, {}, nil, nil, true)
						storeItemInfo.StatusIconTooltip = storeItemInfo.Name
						storeItemInfo.MetaData = { SmallPriceMode = true }
						storeItemInfo.Prices = storeItemPriceObject
						table.insert(storeItemInfos, storeItemInfo)
					end
				else
					local storeItemInfo = module5.GetStoreItemInfo(
						mMovie,
						storeItem,
						{ ItemInfo = itemInfo },
						nil,
						nil,
						true
					)
					storeItemInfo.StatusIconTooltip = storeItemInfo.Name

					if __wf_atom_a6382ae5.mItemType == item then
						storeItemInfo.Equipped = true
					end

					table.insert(storeItemInfos, storeItemInfo)
				end
			end

			return storeItemInfos
		end,
		OnElementSelected = function(p)
			if __wf_atom_7e8ad928(p.RawItem) then
				local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
				local purchaseParams = SF.PurchaseParams()
				purchaseParams.mSource = 0
				purchaseParams.mSourceId = __wf_atom_964056fd:__wf_atom_5b41f63b()
				purchaseParams.mStoreItem = p.StoreItem
				purchaseParams.mQuantity = 1
				purchaseParams.mSkipConfirm = false
				_T.DoPurchase(purchaseParams, function(p2)
					if p2 then
						fn7(p.StoreItem:GetItem())
						module3.MarkFullscreenItemPickerDirty()
					end
				end)
			else
				module.PlaySound(_G.UISound_Select)
				fn6(p.RawItem)
				return "Refresh"
			end
		end,
		OnClosed = function()
			gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
		end
	}
	module3.OpenFullscreenItemPicker(mMovie, v15)
end

function SquadPlayerSelected(p)
	local v15 = v5.mPlayerInfo[p]

	if not v15 then
		return
	end

	if v15.mPlayer.isLocal then
		if module3.IsFullscreenItemPickerOpen() then
			module3.CloseFullscreenItemPicker()
		else
			function _T.RefreshPlayerIcon()
				v5:RefreshSquadPlayers()
				PlayersChanged()
			end

			fn8()
			PlayerDropdownCallback(v6[1])
		end
	end
end

function SquadPlayerFocused(p)
	local v15 = v5.mPlayerInfo[p]

	if not (v15 and IsVisible()) then
		return
	end

	v15.mFocused = true
	SquadPanelFocused()

	if v15.mPlayer.isLocal then
		_T.gToolTip = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/ChangeAvatarImageTitleToolTip", false)
	end

	mMovie:__wf_atom_4c1c1986(v15.mClipName, "Label.Text", 44, _G.UIColor_Yellow)
	__wf_atom_ec43d06e(mMovie, v15.mClipName .. ".Profile.Leaves", 22, { 16 }, { 45 }, 1)
	__wf_atom_ec43d06e(mMovie, v15.mClipName .. ".Highlight", 8, { 12 }, { 50 }, 0.2)
	mMovie:__wf_atom_290807ee("JoinDropdownTimer")
end

function SquadPlayerUnfocused(p)
	local v15 = v5.mPlayerInfo[p]

	if not v15 then
		return
	end

	local mFocused = v15.mFocused
	v15.mFocused = false
	_T.gToolTip = nil

	if mFocused then
		SquadPanelUnfocused()
	end

	mMovie:__wf_atom_4c1c1986(v15.mClipName, "Label.Text", 44, _G.UIColor_Tan)
	__wf_atom_ec43d06e(mMovie, v15.mClipName .. ".Profile.Leaves", 22, { 16 }, { 0 }, 0.5)
	__wf_atom_ec43d06e(mMovie, v15.mClipName .. ".Highlight", 8, { 12 }, { 0 }, 0.2)
end

function MutePlayerSelected(p)
	local v15 = v5.mPlayerInfo[p]

	if __wf_atom_7e8ad928(v15) then
		return
	end

	local __wf_atom_29cd1ff1 = __wf_atom_597fcbc7:__wf_atom_29cd1ff1(v15.mMatchmakingString)
	__wf_atom_597fcbc7:__wf_atom_a8ca86c0(v15.mMatchmakingString, not __wf_atom_29cd1ff1)
	mMovie:__wf_atom_7f57ab2f(v15.mClipName, "MuteButton.Muted", 13, not __wf_atom_29cd1ff1)
end

function MutePlayerFocused(_)
	mMovie:__wf_atom_290807ee("SquadPanelFocus")
	v14 = true
end

function MutePlayerUnfocused(_)
	v14 = false
	__wf_atom_ec43d06e(mMovie, "SquadPanelFocus", 0, {}, {}, 0, 0.5, function()
		if v10 then
			PlayerDropdownCallback(v6[1])
		end
	end)
end

function SquadButtonSelected(p)
	if not IsVisible() then
		return
	end

	local v15 = v6[p]

	if not v15 then
		return
	end

	if v15.mSelectedCallback then
		v15:mSelectedCallback()
	end
end

function IsVisible()
	return mMovie:__wf_atom_a91463a8("_root", 13) and mMovie:__wf_atom_5e6e15c8("SquadInfo", 12) > 0 and mVisible
end

function SquadButtonFocused(p)
	local v15 = v6[p]

	if not (v15 and IsVisible()) then
		return
	end

	v15.mFocused = true
	SquadPanelFocused()

	if v15.mFocusedCallback then
		v15:mFocusedCallback()
	end

	local mClipName = v15.mClipName
	mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName, "Border", 11, _G.UIColor_Yellow)
	local v16 = v2[v15.mId]

	if #v16 > 0 then
		local v17 = "/SF/Language/ToolTips/" .. v16
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v17, true)

		if #__wf_atom_8e9ac384 > 0 and __wf_atom_8e9ac384 ~= v17 then
			_T.gToolTip = __wf_atom_8e9ac384
		end
	end
end

function SquadButtonUnfocused(p)
	local v15 = v6[p]

	if not v15 then
		return
	end

	local mFocused = v15.mFocused
	v15.mFocused = false

	if mFocused then
		SquadPanelUnfocused()

		if v15.mUnfocusedCallback then
			v15:mUnfocusedCallback()
		end
	end

	local mClipName = v15.mClipName
	mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_4c1c1986(mClipName, "Border", 11, _G.UIColor_Brown)
	_T.gToolTip = nil
end

local function fn9(k, p)
	local v15 = v[p .. "Visible"]

	if v15 and not v15() then
		return
	end

	local optionIcon = optionIcons[k]
	local mIndex = #v6 + 1
	local mClipName = "SquadInfo.Options.Option" .. mIndex
	local v16 = {
		mId = k,
		mIndex = mIndex,
		mIcon = optionIcon,
		mClipName = mClipName,
		mSelectedCallback = v[p .. "Callback"]
	}
	v6[mIndex] = v16

	if not mMovie:__wf_atom_253d7085(mClipName) then
		__wf_atom_86cbd68d(mMovie, "SquadInfo.Options.Option1.duplicateMovieClip", "Option" .. mIndex, mIndex)
	end

	mMovie:SetCallbacks(mClipName .. ".Btn", "SquadButtonFocused", "SquadButtonUnfocused", "SquadButtonSelected", nil)
	mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 100, mIndex)
	mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", optionIcon)
	mMovie:OverrideMaterial(mClipName .. ".Backer", _G.UIMaterial_BackerBorderFill)
	mMovie:OverrideMaterial(mClipName .. ".Border", _G.UIMaterial_BackerBorderDouble)
	mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 11, _G.UIColor_DarkBrown)
	SquadButtonUnfocused(mIndex)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Border", 14)
	mMovie:__wf_atom_e57658c2(mClipName, 0, 25 + (mIndex - 1) * __wf_atom_cfc41e35)
end

local function fn10()
	for k, v15 in v6 do
		if k ~= 1 then
			__wf_atom_86cbd68d(mMovie, v15.mClipName .. ".removeMovieClip")
		end
	end

	v6 = {}

	if mVisible then
		for k, v15 in v2 do
			fn9(k, v15)
		end
	end

	mMovie:__wf_atom_2dedec1a("SquadInfo.Options", 13, #v6 > 0)

	if _T.TopMenuOpen then
		mMovie:__wf_atom_e57658c2("SquadInfo", 12, 100)
	end

	SquadButtonSelected(1)
	SquadPanelUnfocused(2)
end

local function fn11()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 0)

	for i = 1, #v5:GetSquadPlayers() do
		local v15 = "SquadInfo.Players.List.Player" .. i
		local v16 = math.max(
			286,
			__wf_atom_5e6e15c8 - (mMovie:__wf_atom_cfc41e35(v15, "Backer", 0) - __wf_atom_5e6e15c8_2)
		)
		mMovie:__wf_atom_4c1c1986(v15, "Backer", 14, v16)
		mMovie:__wf_atom_4c1c1986(v15, "Btn", 14, v16)
		mMovie:__wf_atom_4c1c1986(v15, "SeparatorTop", 14, v16)
		mMovie:__wf_atom_4c1c1986(v15, "SeparatorBot", 14, v16)
		local v17 = __wf_atom_5e6e15c8_2 + (__wf_atom_5e6e15c8 - mMovie:__wf_atom_cfc41e35(v15, "Highlight", 14)) / 2
		mMovie:__wf_atom_4c1c1986(v15, "Highlight", 0, v17)

		if i > 1 then
			mMovie:__wf_atom_7f57ab2f(v15, "SeparatorTop", 13, false)
		else
			mMovie:OverrideMaterial(v15 .. ".SeparatorTop", _G.UIMaterial_TiledDivider)
		end

		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v15, "SeparatorTop", 14)
		mMovie:OverrideMaterial(v15 .. ".SeparatorBot", _G.UIMaterial_TiledDivider)
		mMovie:__wf_atom_1ca72041(v15 .. ".SeparatorTop", "TileRepeats", __wf_atom_cfc41e35 / 32, 1, 0, 0)
		mMovie:__wf_atom_1ca72041(v15 .. ".SeparatorBot", "TileRepeats", __wf_atom_cfc41e35 / 32, 1, 0, 0)
	end
end

local function fn12(k, squadPlayer)
	local mClipName = "SquadInfo.Players.List.Player" .. k
	local v15 = {
		mId = k,
		mIndex = k,
		mClipName = mClipName,
		mMatchmakingString = squadPlayer.matchMakingString
	}
	v5:InitializeSquadPlayerInfo(v15, squadPlayer, k)

	if mMovie:__wf_atom_253d7085(mClipName) then
		mMovie:__wf_atom_e57658c2(v15.mClipName, 0, 0)
	else
		__wf_atom_86cbd68d(mMovie, "SquadInfo.Players.List.Player1.duplicateMovieClip", "Player" .. k, k)
		mMovie:__wf_atom_e57658c2(v15.mClipName, 0, -400)
		__wf_atom_ec43d06e(mMovie, "_root." .. v15.mClipName, 1, { 0 }, { 0 }, fadeInTime, 0.5)
	end

	mMovie:SetCallbacks(mClipName .. ".Btn", "SquadPlayerFocused", "SquadPlayerUnfocused", "SquadPlayerSelected", nil)
	mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 100, k)
	mMovie:__wf_atom_e57658c2(mClipName, 1, (k - 1) * v9)
	mMovie:__wf_atom_4c1c1986(mClipName, "VoteStatus", 12, 0)
	mMovie:__wf_atom_4c1c1986(mClipName, "VoipState", 12, 0)
	mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 12, 0)
	mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label.Text", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_48bd5a59(mClipName, "Label.Text", 46, "center")
	mMovie:__wf_atom_c90af43a(mClipName .. ".Profile.Icon", v15.mIcon)
	local v16 = "<font face=\"Spectral SC\" color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">" .. squadPlayer.name .. "</font>"
	mMovie:__wf_atom_48bd5a59(mClipName, "Label.Text", 36, "<p><font >" .. v16 .. "</font></p>")
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Label.Text", 40)
	local v17 = mMovie:__wf_atom_cfc41e35(mClipName, "Label.Text", 0) + __wf_atom_cfc41e35 + 60
	mMovie:__wf_atom_4c1c1986(mClipName, "MuteButton", 0, v17)
	local v18 = ""

	if #v15.mItems > 0 then
		v18 ..= mMovie:__wf_atom_8e9ac384(v15.mItems[1].Type.LocTag, false)
	end

	if v15.mPlayerLevel ~= nil then
		v18 ..= mMovie:__wf_atom_8e9ac384(" <LEAF_YELLOW>", true) .. v15.mPlayerLevel
	end

	if #v18 > 0 then
		v18 = "<br>" .. v18
	end

	mMovie:__wf_atom_48bd5a59(mClipName, "Label.Text", 36, "<p><font >" .. v16 .. v18 .. "</font></p>")
	local v19 = mMovie:__wf_atom_cfc41e35(mClipName, "Label.Text", 40) + mMovie:__wf_atom_cfc41e35(mClipName, "Profile.Icon", 14) + 40
	local v20 = math.max(mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 14), v19)
	mMovie:__wf_atom_e57658c2("SquadInfo.Players.Backer", 14, v20)
	mMovie:__wf_atom_c90af43a(mClipName .. ".MuteButton.Speaker", voiceIconTexture)
	mMovie:__wf_atom_c90af43a(mClipName .. ".MuteButton.Muted", muteIconTexture)
	mMovie:__wf_atom_4c1c1986(mClipName, "MuteButton.Speaker", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_7f57ab2f(
		mClipName,
		"MuteButton.Muted",
		13,
		__wf_atom_597fcbc7:__wf_atom_29cd1ff1(v15.mMatchmakingString)
	)
	mMovie:SetCallbacks(
		mClipName .. ".MuteButton",
		"MutePlayerFocused",
		"MutePlayerUnfocused",
		"MutePlayerSelected",
		nil
	)
	mMovie:__wf_atom_4c1c1986(mClipName, "MuteButton", 100, k)
	mMovie:__wf_atom_7f57ab2f(mClipName, "MuteButton", 13, v5.mVoipEnabled and not squadPlayer.isLocal)
	SquadPlayerUnfocused(k)
end

local function fn13()
	v9 = mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.List.Player1.Btn", 15)
	local mPlayerInfo = v5.mPlayerInfo
	local v15 = #mPlayerInfo
	local squadPlayers = v5:GetSquadPlayers()
	local count = #squadPlayers

	for i = count + 1, v15 do
		if i ~= 1 then
			__wf_atom_86cbd68d(mMovie, mPlayerInfo[i].mClipName .. ".removeMovieClip")
		end
	end

	v5.mPlayerInfo = {}

	for k, squadPlayer in squadPlayers do
		fn12(k, squadPlayer)
	end

	fn11()
	mMovie:__wf_atom_50d60589("SquadInfo.Details.SquadSize", 36, count)
end

local function fn14()
	v5 = module7.Create(v, "SquadInfo")

	function v5.UpdateIcon(_, p)
		mMovie:__wf_atom_c90af43a(p.mClipName .. ".Profile.Icon", p.mIcon)
	end

	mMovie:SetCallbacks("SquadInfo.Players.Backer", "SquadPanelFocused", "SquadPanelUnfocused", nil, nil)
	mMovie:OverrideMaterial("SquadInfo.Players.Backer", backerFadeMaterial)
	mMovie:__wf_atom_e57658c2("SquadInfo.Players.Backer", 14, 333)
	mMovie:__wf_atom_e57658c2("SquadInfo.Players.Backer", 12, 80)
	mMovie:__wf_atom_e57658c2("SquadInfo.Players.Backer", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("SquadInfo.Details.SquadSize", 11, _G.UIColor_Tan)
	fn13()
	fn5()
end

local function fn15()
	if __wf_atom_7e8ad928(mMovie) then
		return 0, 0, topMenuBackerHeight
	end

	local v15 = not v11 and 0 or mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 14)
	return mMovie:__wf_atom_5e6e15c8("SquadInfo.Players.Backer", 2), v15, topMenuBackerHeight
end

function Initialize()
	v3 = module2.Create(mMovie)
	v3:Register(mMovie, "SquadInfo", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_LEFT })
	_T.GetSquadOverlayMaskArea = fn15
	mMovie:__wf_atom_c884ca43(true)
	fn14()
	fn10()
	v4 = module6.CreateCurrencyBar(getfenv(1), "Title", {
		mFadeInTime = fadeInTime,
		mFadeOutTime = fadeOutTime,
		mRankUpRaysMaterial = rankUpRaysMaterial
	})
	mMovie:__wf_atom_e57658c2("SquadInfo.Details.Backer", 11, _G.UIColor_Brown)
	mMovie:__wf_atom_e57658c2("SquadInfo", 12, 0)
	mMovie:__wf_atom_e57658c2("Title", 12, 0)
	onViewportSizeChanged(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

local function fn16()
	v5.mRequiresInput = false
	v4:UpdatePosition()
end

local function fn17()
	v5:Update()

	if module3.GetIsBlockingPartyInvites() then
		mMovie:__wf_atom_2dedec1a("SquadInfo", 13, false)
	elseif mVisible ~= v5.mVisible then
		mVisible = v5.mVisible

		if mVisible then
			mMovie:__wf_atom_2dedec1a("SquadInfo", 13, true)
			v5.mRequiresInput = true
			mMovie:__wf_atom_2dedec1a("SquadInfo.Backer", 13, true)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Details", 13, true)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Options", 13, true)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Players.Backer", 13, true)
			mMovie:__wf_atom_e57658c2("SquadInfo.Players", 1, 44)
			fn5()
			fn10()
			v4:UpdatePosition(101)
			__wf_atom_ec43d06e(mMovie, "SquadInfo", 2, { 12 }, { 100 }, fadeInTime)
		else
			if v10 then
				PlayerDropdownCallback(v6[1])
			end

			__wf_atom_ec43d06e(mMovie, "SquadInfo", 2, { 12 }, { 0 }, fadeOutTime, 0, function()
				fn16()
			end)
		end
	end

	v4:Update()
	local mRequiresInput = v5.mRequiresInput or v4.mRequiresInput

	if v7 ~= mRequiresInput then
		v7 = mRequiresInput
		mMovie:__wf_atom_c884ca43(not mRequiresInput)
	end
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)

	if not __wf_atom_7e8ad928(v5) then
		v5:FlushPendingDisconnects()
	end

	fn17()
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v3) then
		v3:Update(p, p2)
	end
end

local function fn18()
	fn13()
	fn5()
	__wf_atom_ec43d06e(mMovie, "JoinDropdownTimer", 0, {}, {}, 0, 2, function()
		if v10 then
			if mVisible then
				PlayerDropdownCallback(v6[1])
			else
				mVisible = nil
			end
		end
	end)
end

local function fn19()
	local fadeInTime = fadeInTime
	local squadPlayers = v5:GetSquadPlayers()
	local count = 0

	for k, v15 in v5.mPlayerInfo do
		if k == 1 then
			continue
		end

		local flag = false

		for _, squadPlayer in squadPlayers do
			if v15.mName ~= squadPlayer.name then
				continue
			end

			flag = true
			break
		end

		if flag then
			local v16 = { (k - count - 1) * v9 }
			__wf_atom_ec43d06e(mMovie, "_root." .. v15.mClipName, 1, { 1 }, v16, fadeInTime, 1)
		else
			count += 1
			v15.mRemoved = true
			__wf_atom_ec43d06e(mMovie, "_root." .. v15.mClipName, 1, { 0 }, { -400 }, fadeInTime, 1)
		end
	end

	if count > 0 then
		__wf_atom_ec43d06e(mMovie, "RemovingPlayers", 0, {}, {}, 0, fadeInTime + 1, fn18)
		mMovie:__wf_atom_290807ee("JoinDropdownTimer")
	elseif not mMovie:__wf_atom_1b848254("RemovingPlayers") then
		fn18()
	end
end

function PlayersChanged()
	local mNumCachedPlayers = v5.mNumCachedPlayers or 0

	if mNumCachedPlayers == (v5.mNumSquadMembers or 0) or not (mNumCachedPlayers > 0) then
		fn13()
		fn5()
	else
		if not mVisible then
			mMovie:SetVisible(true)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Backer", 13, false)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Details", 13, false)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Options", 13, false)
			mMovie:__wf_atom_e57658c2("SquadInfo.Players", 1, -36)
			mMovie:__wf_atom_2dedec1a("SquadInfo.Players.Backer", 13, false)
		end

		PlayerDropdownCallback(v6[1])
		__wf_atom_ec43d06e(mMovie, "SquadInfo", 2, { 12 }, { 100 }, fadeInTime, 0, function()
			if not mVisible then
				fn16()
			end

			fn19()
		end)
	end

	fn10()
end