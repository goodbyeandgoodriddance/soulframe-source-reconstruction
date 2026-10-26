local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CardUtilitiesRedux")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.UIUtilities")
local module6 = require("Lotus.Interface.StoreItemUtilities")
local v = nil
local v2 = nil
local movies = {}
local v3 = { IsLoading = false }
local v4 = nil
local v5 = nil
local v6 = "No"
local v7 = nil
local v8 = nil
local flag = true
local queuedBoosterPacks = 0
local v9 = nil
local v10 = nil
local count = 0
local v11 = nil
local v12 = 0
local v13 = 0
local flag2 = false
local v14 = nil
local v15 = false
local v16 = false
local v17 = false
local v18 = true
local fn
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = 0.01
local v23 = {}
local result = {}

function GetCards()
	return result
end

function GetSelectedCards()
	return nil
end

local function fn2()
	local v24 = {}

	if v17 then
		table.insert(v24, {
			Label = module.Ternary(
				v18,
				"/Lotus/Language/SystemMessages/ShowRankedOn",
				"/Lotus/Language/SystemMessages/ShowRankedOff"
			),
			CallBack = fn,
			CallOut = "MENU_GENERIC1",
			OverrideTintIcons = not v18
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v24, getfenv(1))
	end
end

fn = function()
	v18 = not v18

	for k, v24 in pairs(result) do
		local mInstance = v24.mUpgrade.mInstance
		local mUpgradeFingerprint = v24.mUpgrade.mUpgradeFingerprint
		local mName = v24.mName

		if v18 and not __wf_atom_7e8ad928(mInstance) then
			local __wf_atom_49f7d220 = mInstance:__wf_atom_49f7d220(mUpgradeFingerprint)
			v24.mUpgrade.mUpgradeFingerprint = mInstance:__wf_atom_b36d8955(__wf_atom_49f7d220, mUpgradeFingerprint)
			result[k] = module2.CardFromArtifact(v24.mUpgrade, v24.mId)
		else
			v24.mUpgrade.mUpgradeFingerprint = mInstance:__wf_atom_b36d8955(0, mUpgradeFingerprint)
			result[k] = module2.CardFromArtifact(v24.mUpgrade, v24.mId)
		end

		result[k].mName = mName
		module2.DrawCard(v23[k])
	end

	fn2()
end

local function fn3(p, upgradeFX, p2, p3)
	local gRegion = gRegion

	if not __wf_atom_7e8ad928(__wf_atom_392793db) then
		gRegion = __wf_atom_392793db
	end

	return module.CreateParticles(mMovie, p, upgradeFX, p2, p3, gRegion)
end

local function fn4(object)
	local tieredItems = {}

	if __wf_atom_7e8ad928(object) then
		return tieredItems
	end

	local __wf_atom_ff7834ae = object:__wf_atom_ff7834ae()

	if __wf_atom_7e8ad928(__wf_atom_ff7834ae) then
		return tieredItems
	end

	for i = 0, __wf_atom_ff7834ae:__wf_atom_8cfee589() do
		for j = 0, __wf_atom_ff7834ae:__wf_atom_d1247c6c(i) - 1 do
			local tieredItem = __wf_atom_ff7834ae:GetTieredItem(i, j)

			if not __wf_atom_7e8ad928(tieredItem) then
				table.insert(tieredItems, tieredItem)
			end
		end
	end

	return tieredItems
end

local function fn5(mClipName, state, mCardIndex)
	if v17 and v18 and not __wf_atom_7e8ad928(state.mInstance) then
		local __wf_atom_49f7d220 = state.mInstance:__wf_atom_49f7d220(state.mUpgradeFingerprint)
		state.mUpgradeFingerprint = state.mInstance:__wf_atom_b36d8955(__wf_atom_49f7d220, state.mUpgradeFingerprint)
	end

	result[mCardIndex] = module2.CardFromArtifact(state, -1)
	result[mCardIndex].mInstalled.fake = 1
	v23[mCardIndex] = {}
	v23[mCardIndex].mCardIndex = mCardIndex
	v23[mCardIndex].mClipName = mClipName
	v23[mCardIndex].mInstalled = 1
	v23[mCardIndex].mPolarity = 0
	module2.DrawCard(v23[mCardIndex])
	module2.ZoomCard(v23[mCardIndex], v23[mCardIndex].mClipName .. ".Card", false, 0)
	module2.ZoomCard(v23[mCardIndex], v23[mCardIndex].mClipName .. ".Card", true)
	v23[mCardIndex].Zoomed = false
	mMovie:__wf_atom_4c1c1986(v23[mCardIndex].mClipName, "Card.BottomFrame.Equipped", 12, 0)

	if module2.IsCardOmega(result[mCardIndex]) and #_T.boosterPackCards == 1 then
		mMovie:__wf_atom_c90af43a("OmegaDecorations.Logo", omegaLogo)
		mMovie:__wf_atom_c90af43a("OmegaDecorations.WaterMark", _G.UICategoryIcon_OmegaOn)
		mMovie:__wf_atom_e57658c2(v23[mCardIndex].mClipName, 12, 0)
		mMovie:__wf_atom_e57658c2(v23[mCardIndex].mClipName, 5, 300)
		mMovie:__wf_atom_e57658c2(v23[mCardIndex].mClipName, 6, 300)
		mMovie:__wf_atom_e57658c2("FitDisplay", 12, 0)
		__wf_atom_ec43d06e(mMovie, "OmegaDecorations", 2, { 12 }, { 100 }, 0.25, 0, function()
			__wf_atom_ec43d06e(mMovie, "Buttons", 2, { 12 }, { 100 }, 0.35, 1.2)
			__wf_atom_ec43d06e(mMovie, "OmegaDecorations", 2, { 12 }, { 0 }, 0.35, 1.2)
			__wf_atom_ec43d06e(mMovie, "FitDisplay", 2, { 12 }, { 100 }, 0.35, 1.2)
			__wf_atom_ec43d06e(mMovie, v23[mCardIndex].mClipName, 2, { 12, 5, 6 }, { 100, 81.5, 81.5 }, 0.35, 1)
		end)
		local function fn6()
			if v3.IsLoading then
				v11:AddTimer(0.05, fn6)
			elseif not __wf_atom_7e8ad928(v2) then
				v2:SetupOmega(Resource(state.mItemType), state.mUpgradeFingerprint)
			end
		end

		fn6()
	else
		mMovie:__wf_atom_e57658c2("Buttons", 12, 100)
	end

	if Engine.IsPlayingWithController() then
		if __wf_atom_7e8ad928(v10) then
			v10 = mMovie:__wf_atom_5e6e15c8("Buttons", 1)
		end

		if v10 ~= nil then
			mMovie:__wf_atom_e57658c2("Buttons", 1, v10 + 50)
		end
	end

	mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
end

local function fn6()
	count += 1
	local boosterPackCard = _T.boosterPackCards[count]

	if __wf_atom_7e8ad928(boosterPackCard) then
		flag2 = true
		return
	end

	local v24 = boosterPackCard[1]
	local mUpgradeFingerprint = boosterPackCard[2]

	if __wf_atom_7e8ad928(v24) then
		return
	end

	local mCardIndex = count + v12
	local mClipName = "Card" .. mCardIndex
	local v25

	if v16 then
		fn5(mClipName, v24, mCardIndex)
		v25 = mClipName
	elseif v24:GetItem():IsA(modType) then
		local upgradeInfo = SF.UpgradeInfo()
		upgradeInfo.mItemType = v24:GetItem()

		if v15 then
			upgradeInfo.mUpgradeFingerprint = module.Ternary(
				mUpgradeFingerprint ~= "",
				mUpgradeFingerprint,
				upgradeInfo.mInstance:__wf_atom_254ac1f5(upgradeInfo.mInstance:__wf_atom_49f7d220(""))
			)
		else
			upgradeInfo.mUpgradeFingerprint = mUpgradeFingerprint
		end

		fn5(mClipName, upgradeInfo, mCardIndex)
		v25 = mClipName
	else
		if v24:GetItem():IsA(projectionType) then
			mClipName = "Projection" .. mCardIndex
			v25 = mClipName .. ".Item.Icon"
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module4.GetColor(2, true))
			local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module4.GetColor(1, true))
			mMovie:OverrideMaterial(mClipName .. ".Item.Bg", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".Item.Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				0.85
			)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".Item.Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				0.2
			)
			mMovie:OverrideMaterial(mClipName .. ".ContentBg", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".ContentBg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				0.85
			)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".ContentBg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				0.2
			)
			mMovie:__wf_atom_c90af43a(mClipName .. ".Item.Icon", v24:GetIconTexture())
			mMovie:__wf_atom_4c1c1986(mClipName, "Item.Name", 44, v20)
			mMovie:__wf_atom_7d7314f1(mClipName .. ".Item.Name.text", (tostring(v24:__wf_atom_014a76a2())))
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".ContentBg", 15)
			mMovie:__wf_atom_4c1c1986(mClipName, "ContentBg", 15, v22)
			mMovie:__wf_atom_976dcedd(mClipName, "Id", mCardIndex)
			local v26 = (v22 - __wf_atom_5e6e15c8) / 2
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Item", 1)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".DividerCommon", 1)
			local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".DividerUncommon", 1)
			local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".DividerRare", 1)
			local __wf_atom_5e6e15c8_6 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".ContentBg", 1)
			local __wf_atom_5e6e15c8_7 = mMovie:__wf_atom_5e6e15c8(mClipName, 1)

			for _, v27 in ipairs({ ".ContentCommon", ".ContentUncommon", ".ContentRare" }) do
				local v28 = 1

				while true do
					local v29 = mClipName .. v27

					if v28 > 1 then
						v29 ..= v28
					end

					if not mMovie:__wf_atom_253d7085(v29) then
						break
					end

					local __wf_atom_5e6e15c8_8 = mMovie:__wf_atom_5e6e15c8(v29, 1)
					mMovie:__wf_atom_e57658c2(v29, 1, __wf_atom_5e6e15c8_8 - v26)
					mMovie:__wf_atom_4c1c1986(v29, "Content", 44, v19)
					v28 += 1
				end
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "DividerCommon", 100, 1)
			mMovie:__wf_atom_4c1c1986(mClipName, "DividerUncommon", 100, 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "DividerRare", 100, 3)
			mMovie:SetCallbacks(mClipName .. ".DividerCommon", "DividerRollOver", "DividerRollOut", nil, nil)
			mMovie:SetCallbacks(mClipName .. ".DividerUncommon", "DividerRollOver", "DividerRollOut", nil, nil)
			mMovie:SetCallbacks(mClipName .. ".DividerRare", "DividerRollOver", "DividerRollOut", nil, nil)
			mMovie:__wf_atom_4c1c1986(mClipName, "Item", 1, __wf_atom_5e6e15c8_2 - v26)
			mMovie:__wf_atom_4c1c1986(mClipName, "DividerCommon", 1, __wf_atom_5e6e15c8_3 - v26)
			mMovie:__wf_atom_4c1c1986(mClipName, "DividerUncommon", 1, __wf_atom_5e6e15c8_4 - v26)
			mMovie:__wf_atom_4c1c1986(mClipName, "DividerRare", 1, __wf_atom_5e6e15c8_5 - v26)
			mMovie:__wf_atom_4c1c1986(mClipName, "ContentBg", 1, __wf_atom_5e6e15c8_6 - v26)
			mMovie:__wf_atom_e57658c2("caption", 1, __wf_atom_5e6e15c8_7 + (__wf_atom_5e6e15c8_2 - v26) - 32)
			mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		else
			local elementById = v4:GetElementById(mCardIndex)

			if not __wf_atom_7e8ad928(elementById) then
				elementById.StoreInfo = module6.GetStoreItemInfo(mMovie, v24, {}, nil, nil, true)
				v4.mElementDrawCallback(elementById)
			end

			v25 = mClipName
		end

		mMovie:__wf_atom_e57658c2("Buttons", 12, 100)
		v23[mCardIndex] = {}
		v23[mCardIndex].mCardIndex = count
		v23[mCardIndex].mClipName = mClipName
	end

	fn3(v25, upgradeFX)
	v11:AddTimer(0.3, function()
		fn6()
	end)
end

function CollectionFocused(p)
	if flag then
		return
	end

	v23[tonumber(p)].Zoomed = true
	module.PlaySound(_G.UISound_Focus)
	__wf_atom_86cbd68d(mMovie, "Card" .. p .. ".swapDepths", 1200)
end

function CollectionUnfocused(p)
	if flag then
		return
	end

	v23[tonumber(p)].Zoomed = false
end

local function fn7(p, i)
	mMovie:__wf_atom_976dcedd(p, "Id", i)
	mMovie:__wf_atom_976dcedd(p, "RollOverCallback", "CollectionFocused")
	mMovie:__wf_atom_976dcedd(p, "RollOutCallback", "CollectionUnfocused")
end

local function fn8()
	v19 = module4.GetColor(6, true)
	v20 = module4.GetColor(9, true)
	v21 = module4.GetColor(10, true)
	mMovie:__wf_atom_e57658c2("caption", 44, v21)
	mMovie:__wf_atom_e57658c2("LinesTop", 11, v20)
	mMovie:__wf_atom_e57658c2("LinesBottom", 11, v20)
end

local function fn9(p)
	local card = result[3]
	module2.UpdateOmegaCard(card, p)
	module2.DrawCard({ mClipName = v23[3].mClipName, Card = card })
end

local function fn10(p)
	if not __wf_atom_7e8ad928(_T.ChatOnSubScreenChanged) then
		_T.ChatOnSubScreenChanged(not p)
	end
end

local function fn11()
	local module7 = require("EE.Interface.Components.Grid")
	v4 = module7.CreateGrid(mMovie, "Item1", nil, 5, 1)
	v4:SetCallbacks(nil, "ItemFocused", "ItemUnfocused")
	v4.mColumnSeparation = 289
	v4.ElementWidth = 250
	v4.ElementHeight = 250

	function v4.mClipCreatedCallback(p, _)
		module5.OnGridItemCreated(mMovie, v4, p .. ".Item")
	end

	function v4:mOnFocusedCallback()
		if self.mClipName == nil or __wf_atom_7e8ad928(self.StoreInfo) then
			return
		end

		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		module5.OnGridItemFocusChanged(mMovie, v4, self.StoreInfo, {
			IgnoreCount = true,
			IsFocused = true,
			ShowInfoPopup = true
		})
		self.mClipName = mClipName
	end

	function v4:mOnUnfocusedCallback()
		if self.mClipName == nil or __wf_atom_7e8ad928(self.StoreInfo) then
			return
		end

		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		module5.OnGridItemFocusChanged(mMovie, v4, self.StoreInfo, {
			IgnoreCount = true,
			IsFocused = false,
			ShowInfoPopup = true
		})
		self.mClipName = mClipName
	end

	function v4:mElementDrawCallback()
		local v24 = not __wf_atom_7e8ad928(self.StoreInfo)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Item", 13, v24)

		if not v24 then
			return
		end

		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		mMovie:__wf_atom_e57658c2(self.mClipName, 100, self.Id)
		mMovie:SetCallbacks(self.mClipName, v4.mRollOverElementCallback, v4.mRollOutElementCallback, nil, nil)
		self.StoreInfo.mClipName = self.mClipName
		module5.DrawGridItem(mMovie, v4, self.StoreInfo, {})
		self.mClipName = mClipName
	end
end

function Initialize()
	v15 = _T.boosterPreviewMode == true
	_T.boosterPreviewMode = nil
	v16 = _T.boosterUpgradeInfoMode == true
	_T.boosterUpgradeInfoMode = nil
	v17 = _T.boosterOmegaMode == true
	_T.boosterOmegaMode = nil
	queuedBoosterPacks = _T.queuedBoosterPacks or 0
	v9 = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(v9) or _T.BoosterPackAvatarOnTop) then
		_T.BoosterPackAvatarOnTop = v9:__wf_atom_f63d17c0()
		v9:__wf_atom_e424c72a(false)
	end

	if v15 then
		mMovie:__wf_atom_7df746cd(0)
		mMovie:__wf_atom_0cf0fdbe(1)
		mMovie:__wf_atom_7f5b0d60(2)
	end

	mMovie:SetFrameCallback("_root", "OnFrameEnter")

	if not (v15 or v17 or _T.BackgroundVisible or __wf_atom_7e8ad928(_T.ShowBackground)) then
		_T.BoosterPackShowingBackground = true
		_T.ShowBackground(0.25, nil, false)
	end

	module3.RegisterHideSquadOverlay(true)

	for i = 1, #hideMovies do
		local movie = __wf_atom_8e4fda44:FindMovie(hideMovies[i])

		if __wf_atom_7e8ad928(movie) then
			continue
		end

		__wf_atom_ec43d06e(movie, "_root", 0, { 12 }, { 0 }, 0.15)
		table.insert(movies, movie)
	end

	fn10(false)
	mMovie:__wf_atom_6fdcbb52(false)
	mMovie:__wf_atom_dac78d3d(true)
	fn8()
	mMovie:OverrideMaterial("LinesTop", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("LinesBottom", _G.UIMaterial_VitruvianLines)
	fn11()
	local module7 = require("Lotus.Interface.Components.ThemedSpinner")
	v14 = module7.Create(mMovie, "Spinner")

	if v17 or v15 then
		mMovie:__wf_atom_2dedec1a("LinesTop", 13, false)
		mMovie:__wf_atom_2dedec1a("LinesBottom", 13, false)
	end

	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v11 = module8.CreateTimerMgr()

	for i = 1, 5 do
		mMovie:__wf_atom_2dedec1a("Card" .. i, 13, false)
		mMovie:__wf_atom_2dedec1a("Projection" .. i, 13, false)
		fn7("Card" .. i, i)
		v4:AddElement({}, true)
	end

	v4:Redraw()

	if v17 then
		local module9 = require("Lotus.Interface.Components.OmegaCompatibilityPanel")
		v2 = module9.Create(mMovie, "FitDisplay", fn9)

		if not __wf_atom_7e8ad928(_T.boosterPackCards) and #_T.boosterPackCards == 1 then
			local v24 = _T.boosterPackCards[1][1]
			local v25 = Resource(v24.mItemType)
			local mUpgradeFingerprint = v24.mUpgradeFingerprint
			v2:BuildCompatibleList(v25, mUpgradeFingerprint)
			local mCompatibleItems = v2.mCompatibleItems
			local v26 = {}

			for i = 1, #mCompatibleItems do
				table.insert(v26, mCompatibleItems[i].Type:__wf_atom_5b41f63b())
			end

			v3.Loader = UISys.__wf_atom_c0dbe47c(v26)
			v3.IsLoading = true
		end
	else
		mMovie:__wf_atom_2dedec1a("FitDisplay", 13, false)
	end

	mMovie:__wf_atom_e57658c2("OmegaDecorations", 12, 0)
	mMovie:__wf_atom_e57658c2("Buttons", 12, 0)
	mMovie:__wf_atom_2dedec1a("caption", 13, false)

	if not __wf_atom_7e8ad928(_T.boosterPackCards) then
		v13 = #_T.boosterPackCards

		if v13 == 3 then
			v12 = 1
		elseif v13 == 1 then
			v12 = 2
		elseif v13 % 2 == 0 then
			for i = 1, 5 do
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Card" .. i, 0)
				mMovie:__wf_atom_e57658c2("Card" .. i, 0, __wf_atom_5e6e15c8 + 106)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Projection" .. i, 0)
				mMovie:__wf_atom_e57658c2("Projection" .. i, 0, __wf_atom_5e6e15c8_2 + 140)
			end

			if v13 == 2 then
				v12 = 1
			end
		end
	end

	fn2()
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	module3.RegisterHideSquadOverlay(false)

	if queuedBoosterPacks == 0 then
		if _T.BoosterPackShowingBackground and not __wf_atom_7e8ad928(_T.HideBackground) then
			_T.HideBackground()
		end

		if _T.BoosterPackAvatarOnTop and not __wf_atom_7e8ad928(v9) then
			v9:__wf_atom_e424c72a(true)
		end

		_T.BoosterPackShowingBackground = nil
		_T.BoosterPackAvatarOnTop = nil

		for i = 1, #movies do
			if not __wf_atom_7e8ad928(movies[i]) then
				movies[i]:__wf_atom_e57658c2("_root", 12, 100)
			end
		end

		fn10(true)
	end
end

local function fn12(p)
	local v24 = tonumber(p)
	v7 = (__wf_atom_7e8ad928(v24) or v24 > 1) and 1 or v24
end

function SetNumOptions(p)
	fn12(p)
end

local function fn13(p)
	v8 = p
end

function SetCaption(p)
	fn13(p)
end

local function fn14(p)
	v5 = p
end

function SetCallback(p)
	fn14(p)
end

local function fn15()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_2ad5cd23 ~= nil and v5 ~= nil then
		__wf_atom_2ad5cd23:Execute(v5, v6)
	end

	if v7 > 0 then
		mMovie:Close()
	end
end

function TransitionOutDone()
	fn15()
end

local function fn16(p)
	if not flag and v7 > 0 then
		print("Dialog::SendResult(" .. tostring(p) .. ")")
		flag = true
		v6 = p
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 0.2, 0, function()
			fn15()
		end)
		module.PlaySound(_G.UISound_Select)
	end
end

function onSelectConfirm()
	fn16("Yes")
	return true
end

local function fn17()
	fn8()
	local module7 = require("Lotus.Interface.Components.ThemedButton")
	v = module7.Create(mMovie, "Buttons.ConfirmBtn", "/Menu/Confirm_Item_Ok", "onSelectConfirm", "<MENU_SELECT>")
	v:SetSpecialMode()
	v:SetWidth(168)
	v:SetVisible(v7 > 0)
	v:Redraw()
	local v24 = v8 == nil and "" or mMovie:__wf_atom_8e9ac384(v8, true)
	mMovie:__wf_atom_50d60589("caption", 36, "")
	module.AnimateTyping(mMovie, nil, "caption", v24)
	v14:SetActive(v7 == 0)
	flag = false

	if not v16 then
		for i, boosterPackCard in ipairs(_T.boosterPackCards) do
			local v25 = boosterPackCard[1]

			if __wf_atom_7e8ad928(v25) then
				continue
			end

			local item = v25:GetItem()

			if not item:IsA(projectionType) then
				continue
			end

			local v26 = "Projection" .. i + v12
			local v27 = fn4(Resource(item))
			table.sort(v27, function(a, b)
				return a:__wf_atom_a8dac107() < b:__wf_atom_a8dac107()
			end)
			local v28 = { {}, {}, {} }
			local v29 = { "ContentCommon", "ContentUncommon", "ContentRare" }

			for j = 1, #v27 do
				local v30 = TitleCase(module6.GetLocalizedItemName(mMovie, v27[j].mStoreItem))
				local v31 = v27[j]:__wf_atom_a8dac107() + 1

				if v31 >= 1 and v31 <= 3 then
					table.insert(v28[v31], v30)
				else
					print("DialogWithCards: Rarity " .. v31 .. " " .. v30 .. " skipped")
				end
			end

			local v30 = 34

			for j, list in ipairs(v28) do
				for k, v31 in ipairs(list) do
					local v32 = v26 .. "." .. v29[j]

					if k > 1 and not mMovie:__wf_atom_253d7085(v32 .. k) then
						__wf_atom_86cbd68d(mMovie, v32 .. ".duplicateMovieClip", v29[j] .. k, 1200 + j * 20 + k)
						v32 ..= k
					end

					mMovie:__wf_atom_e57658c2(v32, 1, v30 + 97)
					mMovie:__wf_atom_48bd5a59(v32, "Content", 36, v31)
					v30 = v30 + mMovie:__wf_atom_5e6e15c8(v32 .. ".Content", 41) + 6
				end

				if j == 1 then
					mMovie:__wf_atom_4c1c1986(v26, "DividerUncommon", 1, v30 + 97)
				elseif j == 2 then
					mMovie:__wf_atom_4c1c1986(v26, "DividerRare", 1, v30 + 97)
				end

				v30 += 34
			end

			v22 = math.max(v22, v30)
		end
	end

	if v22 > 0.01 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Buttons", 1)
		mMovie:__wf_atom_e57658c2("Buttons", 1, (math.max(__wf_atom_5e6e15c8 + 50, __wf_atom_5e6e15c8 + v22 / 2 - 60)))
	end

	fn6()
end

function OnFrameEnter(_, p)
	if p == "Stop1" then
		mMovie:__wf_atom_e57658c2("caption", 1, 220)
		fn17()
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v14) then
		v14:Update()
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Update(__wf_atom_fa1258d0())
	end

	if v3.IsLoading and not __wf_atom_7e8ad928(v3.Loader) and v3.Loader:__wf_atom_86399a47() then
		v3.IsLoading = false
	end

	if flag2 then
		for i = 1, v13 do
			local v24 = i + v12
			module2.Update(v23[v24], __wf_atom_084b3e93())
		end
	end
end

function DividerRollOver(p)
	_T.gToolTip = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/" .. ({ "COMMON", "UNCOMMON", "RARE" })[p], true)
end

function ItemFocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:FocusElementById(p)
	end
end

function ItemUnfocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:UnfocusElementById(p)
	end
end

function DividerRollOut(_)
	_T.gToolTip = nil
end

function onKeyDown_MENU_UP()
	return true
end

function onKeyDown_MENU_DOWN()
	return true
end

function onKeyDown_MENU_UP_FROM_ANALOG()
	return true
end

function onKeyDown_MENU_DOWN_FROM_ANALOG()
	return true
end

function onKeyDown_MENU_RIGHT_FROM_ANALOG() end

function onKeyDown_MENU_RIGHT() end

function onKeyDown_MENU_LEFT_FROM_ANALOG() end

function onKeyDown_MENU_LEFT() end

function onKeyDown_MENU_CANCEL()
	if v7 == 1 and not (__wf_atom_7e8ad928(v) or flag) then
		v:TryPressed(true)
	end
end

function SupportsThemes()
	return true
end

function IsInputBlocked()
	return flag
end