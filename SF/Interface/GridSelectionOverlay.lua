local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.StoreItemUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("SF.Interface.Libs.ItemUtil")
local module6 = require("SF.Interface.Libs.StatsUtil")
local asyncLoader = module4.CreateAsyncLoader()
local inventory = nil
local v = nil
local v2 = nil
local v3 = false
local v4 = nil

local function fn()
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "PactText", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Rank", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Subtitle", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Description", 44, _G.UIColor_Beige)
end

local function fn2()
	mMovie:__wf_atom_c90af43a("Details.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("Details.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("Details.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("Details.BgFill", 11, 1774608)
	mMovie:__wf_atom_e57658c2("Details.BgFill", 12, 70)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 11, 1774608)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 12, 70)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 11, 1774608)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 12, 70)
	mMovie:__wf_atom_e57658c2("Details.Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.PactText", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.MoteName", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.MoteDescription", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("Details.UnknownText", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Details.UnknownText", 12, 0)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Details", 14)
	mMovie:__wf_atom_e57658c2("Details.PactInfo.GroupDivider1", 14, __wf_atom_5e6e15c8 - 20)
	mMovie:__wf_atom_e57658c2("Details.PactInfo.GroupDivider1", 0, 210)
	mMovie:__wf_atom_e57658c2("Details.PactInfo.GroupDivider2", 14, __wf_atom_5e6e15c8 - 20)
	mMovie:__wf_atom_e57658c2("Details.PactInfo.GroupDivider2", 0, 210)
	local module7 = require("SF.Interface.Components.Scrollbar")
	v2 = module7.CreateScrollBar(getfenv(1), "Details.Scrollbar", {
		mClipToScroll = "Details.PactInfo",
		mVisRangeMaterials = { visRangeDetailsTextMat },
		mVisRangeFadeSize = 10
	})
	mMovie:__wf_atom_e57658c2("Details", 12, 0)
	fn()
end

local function fn3(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.StoreItemInfo) then
		if mMovie:__wf_atom_5e6e15c8("MainIcon", 12) > 1 then
			__wf_atom_ec43d06e(mMovie, "MainIcon", 1, { 12 }, { 0 }, 0.2)
		end
	else
		local iconTexture = p.StoreItemInfo.StoreItem:GetIconTexture()
		asyncLoader:LoadResource(
			"MainIcon",
			WeakResource("/SF/Interface/Graphics/Equipment/Pact/CenterIcons/" .. iconTexture:GetName()),
			function(p2)
				mMovie:__wf_atom_c90af43a("MainIcon", p2)
			end
		)

		if mMovie:__wf_atom_5e6e15c8("MainIcon", 12) < 1 then
			__wf_atom_ec43d06e(mMovie, "MainIcon", 1, { 12 }, { 100 }, 0.2)
		end
	end
end

local function fn4(object, p)
	if object == nil then
		return
	end

	mMovie:__wf_atom_4c1c1986(p, "Name", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(p, "PactText", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(p, "Rank", 11, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986(p, "Desc", 11, _G.UIColor_Beige)
	local v5 = object:__wf_atom_014a76a2() == nil and "" or Localize(object:__wf_atom_014a76a2():c_str(), false)
	local v6 = object:__wf_atom_3a3d2e39() == nil and "" or Localize(object:__wf_atom_3a3d2e39():c_str(), false)
	local iconTexture = object:GetIconTexture()
	mMovie:__wf_atom_50d60589(p .. ".Name", 36, v5)
	mMovie:__wf_atom_50d60589(p .. ".Desc", 36, v6)
	mMovie:__wf_atom_c90af43a(p .. ".Icon", iconTexture)
	mMovie:__wf_atom_2dedec1a(p .. ".Backer", 13, false)
	local v7 = mMovie:__wf_atom_5e6e15c8(p .. ".Icon", 14) + 12
	mMovie:OverrideMaterial(p .. ".Border", _G.UIMaterial_BackerBorderSingle)
	mMovie:__wf_atom_1ca72041(p .. ".Border", "VisibilitySize", 1, 1, 1, 1)
	mMovie:__wf_atom_e57658c2(p .. ".Border", 14, v7)
	mMovie:__wf_atom_e57658c2(p .. ".Border", 15, v7)
	mMovie:__wf_atom_e57658c2(p .. ".Border", 11, _G.UIColor_Yellow)
end

local function fn5(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.StoreItemInfo) then
		return
	end

	local rank = p.StoreItemInfo.Rank
	local xp = p.StoreItemInfo.Xp
	local __wf_atom_a1680b24 = __wf_atom_c67f9605:__wf_atom_a1680b24(p.StoreItemInfo.Type)
	local v5 = math.min(rank + 1, __wf_atom_a1680b24)
	local __wf_atom_89d4ac2a = __wf_atom_c67f9605:__wf_atom_89d4ac2a(v5, p.StoreItemInfo.Type)
	local __wf_atom_89d4ac2a2 = __wf_atom_c67f9605:__wf_atom_89d4ac2a(rank, p.StoreItemInfo.Type)
	module6.SetLevelExplicit(
		mMovie,
		"Details.PactInfo.LevelIndicator",
		_G.UIColor_Beige,
		rank,
		__wf_atom_89d4ac2a2,
		__wf_atom_89d4ac2a,
		xp
	)
	module6.SetRarity(mMovie, "Details.PactInfo.LevelIndicator", true, p.StoreItemInfo.StoreItem:__wf_atom_a8dac107())
	mMovie:__wf_atom_2dedec1a("Details.PactInfo", 13, true)
	mMovie:__wf_atom_48bd5a59("Details.PactInfo", "Name", 36, p.StoreItemInfo.Name)
	local v6 = mMovie:__wf_atom_cfc41e35("Details.PactInfo", "Name", 1) + mMovie:__wf_atom_cfc41e35("Details.PactInfo", "Name", 41)
	mMovie:__wf_atom_48bd5a59(
		"Details.PactInfo",
		"PactText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/SystemMessages/PactSlot", true) .. " " .. mMovie:__wf_atom_8e9ac384("<PACT_ICON>", true)
	)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "PactText", 1, v6 + 5)
	local v7 = mMovie:__wf_atom_cfc41e35("Details.PactInfo", "PactText", 1) + mMovie:__wf_atom_cfc41e35(
		"Details.PactInfo",
		"PactText",
		41
	)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "GroupDivider1", 1, v7 + 20)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("Details.PactInfo", "GroupDivider1", 1)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Description", 1, __wf_atom_cfc41e35 + 10)
	mMovie:__wf_atom_48bd5a59("Details.PactInfo", "Description", 36, p.StoreItemInfo.LocalizedDesc)
	local v8 = mMovie:__wf_atom_cfc41e35("Details.PactInfo", "Description", 1) + mMovie:__wf_atom_cfc41e35(
		"Details.PactInfo",
		"Description",
		41
	)
	mMovie:__wf_atom_4c1c1986("Details.PactInfo", "GroupDivider2", 1, v8 + 20)
	mMovie:__wf_atom_7f57ab2f("Details.PactInfo", "Ability1", 13, false)
	mMovie:__wf_atom_7f57ab2f("Details.PactInfo", "Ability2", 13, false)
	mMovie:__wf_atom_7f57ab2f("Details.PactInfo", "Ability3", 13, false)
	asyncLoader:LoadResource("PactDetails", p.StoreItemInfo.Type, function(p2)
		local v9 = Resource(p2)
		local iconTextures = {}

		for i = 1, 3 do
			table.insert(iconTextures, (v9:__wf_atom_e68785c4(i):GetIconTexture()))
		end

		asyncLoader:LoadMultipleResources("PactDetails", iconTextures, function()
			local v10 = mMovie:__wf_atom_cfc41e35("Details.PactInfo", "GroupDivider2", 1) + 20 + 10
			mMovie:__wf_atom_4c1c1986("Details.PactInfo", "Ability1", 1, v10)

			for i = 1, #iconTextures do
				local __wf_atom_e68785c4 = v9:__wf_atom_e68785c4(i)
				local v11 = "Details.PactInfo" .. ".Ability" .. i
				mMovie:__wf_atom_7f57ab2f("Details.PactInfo", "Ability" .. i, 13, true)
				fn4(__wf_atom_e68785c4, v11)

				if not (i > 1) then
					continue
				end

				local v12 = "Details.PactInfo" .. ".Ability" .. i - 1
				local v13 = math.max(
					100,
					mMovie:__wf_atom_5e6e15c8(v12 .. ".Name", 41) + mMovie:__wf_atom_5e6e15c8(v12 .. ".Desc", 41)
				)
				local v14 = mMovie:__wf_atom_5e6e15c8(v12, 1) + v13 + 20 + 10
				mMovie:__wf_atom_e57658c2(v11, 1, v14)
			end
		end)
	end)
end

function ShowDetailsFor(p)
	if __wf_atom_7e8ad928(p) and v3 then
		mMovie:__wf_atom_e57658c2("Details.UnknownText", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Details.PactInfo", 1, { 12 }, { 0 }, 0.2, 0, function()
			__wf_atom_ec43d06e(mMovie, "Details.UnknownText", 1, { 12 }, { 100 }, 0.2)
		end)
		v3 = false
	elseif not __wf_atom_7e8ad928(p) then
		fn5(p)
		__wf_atom_ec43d06e(mMovie, "Details.UnknownText", 1, { 12 }, { 0 }, 0.1)

		if not v3 then
			__wf_atom_ec43d06e(mMovie, "Details", 1, { 12 }, { 100 }, 0.4)
			__wf_atom_ec43d06e(mMovie, "Details.PactInfo", 1, { 12 }, { 100 }, 0.4)
		end

		v3 = true
	end

	fn3(p)
end

local function fn6()
	local module7 = require("EE.Interface.Components.ItemGrid")
	v = module7.Create(getfenv(1), "InventoryGrid", {
		mGrid = true,
		mRows = 3,
		mCanSelectItem = true
	})
	local ternary = module.Ternary(__wf_atom_7e8ad928(_T.GridSelectionTitle), "", _T.GridSelectionTitle)
	v:SetTitle(ternary)
	v.Old_OnDraw = v.OnDraw

	function v.OnDraw(object, p, p2)
		object:Old_OnDraw(p, p2)

		if p.OwnsItem then
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 11, _G.UIColor_White)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 12, 100)
		else
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 11, _G.UIColor_Black)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 12, 50)
		end
	end

	function v.mOnFocusedCallback(p)
		if p.OwnsItem then
			ShowDetailsFor(p)
		else
			ShowDetailsFor(nil)
		end
	end

	function v.mOnUnfocusedCallback(_)
		if v4 then
			return
		end

		ShowDetailsFor(nil)
	end

	function v.mOnSelectedCallback(p)
		if not p.OwnsItem then
			ShowDetailsFor(nil)
			return
		end

		if not __wf_atom_7e8ad928(v4) then
			v4.Equipped = false
			module5.Update(mMovie, v4.mClipName, v4, v)
		end

		v4 = p
		v4.Equipped = true
		module5.Update(mMovie, p.mClipName, p, v)
		ShowDetailsFor(p)
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("InventoryGrid.Bg", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("MainIcon", 0)
	mMovie:__wf_atom_e57658c2("InventoryGrid", 0, __wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8 / 2)
end

local function fn7()
	v:RemoveElements(true, true)
	local __wf_atom_caa82b8d = storeManifest:__wf_atom_caa82b8d(WeakResource("/SF/Types/Player/PlayerPowerSuit"))
	local v5 = {}
	local count = 0
	local count2 = 0

	for i = 1, #__wf_atom_caa82b8d do
		table.insert(v5, __wf_atom_caa82b8d[i]:GetItem())
	end

	local __wf_atom_ebdc4e6e = inventory:__wf_atom_ebdc4e6e()

	local function fn8(object, list, ownsItem, itemInfo)
		if itemInfo == nil then
			itemInfo = Resource(object:GetItem())
		end

		local storeItemInfo = module3.GetStoreItemInfo(mMovie, object, { ItemInfo = itemInfo }, nil, nil, true)
		count += 1

		if ownsItem then
			count2 += 1
		end

		local __wf_atom_2941433a = object:__wf_atom_2941433a()
		table.insert(list, {
			Name = storeItemInfo.Name,
			Icon = storeItemInfo.Icon,
			OwnsItem = ownsItem,
			IsDummy = not ownsItem,
			StoreItemInfo = storeItemInfo,
			SortingPriority = __wf_atom_2941433a
		})
	end

	asyncLoader:LoadMultipleResources("ItemList", v5, function()
		local v6 = {}
		local id = nil

		for i = 1, #__wf_atom_caa82b8d do
			local v7 = __wf_atom_caa82b8d[i]
			local v8 = false
			local v9 = nil

			for _, v10 in ipairs(__wf_atom_ebdc4e6e) do
				if v7:GetItem() ~= v10.mItemType then
					continue
				end

				v8 = true
				fn8(v7, v6, true, v10)
				v9 = v10
			end

			if not v8 then
				fn8(v7, v6, v8, v9)
			end
		end

		table.sort(v6, function(a, b)
			return a.SortingPriority < b.SortingPriority
		end)
		local currentSelectedPactId = _T.CurrentSelectedPactId

		for _, v7 in ipairs(v6) do
			local v8 = v:AddElement(v7, true)

			if not (v8.StoreItemInfo.RawItem ~= nil and v8.StoreItemInfo.RawItem.mItemId ~= nil) then
				continue
			end

			local mId = v8.StoreItemInfo.RawItem.mItemId.mId

			if __wf_atom_7e8ad928(currentSelectedPactId) or mId ~= currentSelectedPactId then
				continue
			end

			id = v8.Id
			v8.Equipped = true
		end

		v:Redraw(nil, true, true)
		v:SetCount(count2, count)

		if not __wf_atom_7e8ad928(id) then
			v:SelectElementById(id, true)
		end

		mMovie:__wf_atom_e57658c2("_root", 12, 100)
		module2.DissolveIn(mMovie)
		__wf_atom_ec43d06e(mMovie, "backAlpha", 2, { function(p)
				mMovie:__wf_atom_0cf0fdbe(p)
			end }, { 0.9 }, 0.8)

		if not __wf_atom_7e8ad928(_T.GridLoadedCallback) then
			_T.GridLoadedCallback()
		end
	end)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_7df746cd(2825751)
	mMovie:__wf_atom_0cf0fdbe(0)
	inventory = gGameData:GetInventory()
	fn2()
	fn6()
	fn7()
	mMovie:__wf_atom_e57658c2("MainIcon", 12, 0)
	mMovie:__wf_atom_c90af43a("GirlsFront", pactIconTextures[1])
	mMovie:__wf_atom_c90af43a("GirlsBack", pactIconTextures[2])
	mMovie:__wf_atom_c90af43a("HeaderBacker", pactIconTextures[3])
	local v5 = {}
	table.insert(v5, {
		Label = "/SF/Language/Menu/Menu_Back",
		CallBack = GoBack,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v5, getfenv(1))
	end
end

function Update()
	local v5 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v5)
	asyncLoader:Update()
end

function Shutdown()
	ShowDetailsFor(nil)
	_T.GridSelectionTitle = nil
	_T.GridSelectionCallback = nil
	_T.CurrentSelectedPactId = nil
	_T.GridLoadedCallback = nil
end

local function fn8()
	__wf_atom_ec43d06e(mMovie, "backAlpha", 2, { function(p)
			mMovie:__wf_atom_0cf0fdbe(0.9 - p)
		end }, { 0.9 }, 0.4)
	module2.DissolveOutAndClose(mMovie)
end

function Confirm()
	if not __wf_atom_7e8ad928(_T.GridSelectionCallback) then
		local mSelectedElement = v.mSelectedElement

		if
			mSelectedElement == nil
			or __wf_atom_7e8ad928(mSelectedElement.StoreItemInfo)
			or __wf_atom_7e8ad928(mSelectedElement.StoreItemInfo.RawItem)
			or __wf_atom_7e8ad928(mSelectedElement.StoreItemInfo.RawItem.mItemId)
		then
			return
		end

		local mId = mSelectedElement.StoreItemInfo.RawItem.mItemId.mId
		_T.GridSelectionCallback(mId)
	end
end

function GoBack()
	Confirm()
	fn8()
end