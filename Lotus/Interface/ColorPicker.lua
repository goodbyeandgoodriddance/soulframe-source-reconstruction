local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIUtilities")
require("Lotus.Interface.StoreItemUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = WeakResource("/Lotus/Types/Game/Store/ProductsManifest")
local v3 = nil
local v4 = nil
local flag = true
local v5 = false
local flag2 = false
local v6 = nil
local v7 = nil
local v8 = nil
local storeItem = nil
local mColumns = 0
local v9 = nil
local colorPickerCallback = nil
local colorPickerOnCloseCallback = nil
local v10 = {}
local mOwned = false
local color = nil
local v11 = false
local v12 = false
local v13 = {}
local v14 = nil
local colors = nil
local _ = { Center = 0, Size = 0.5, FadeSize = 0.1 }
local v15 = false
local v16 = false
local v17 = false
local v18 = { PALETTE = 0, FAVORITE = 1, CUSTOM = 2 }
local v19 = nil
local v20 = nil
local v21 = false
local v22 = {}
local v23 = nil
local v24 = false
local v25 = false
local v26 = nil
local fn
local fn2
local fn3

function Shutdown()
	_T.gToolTip = nil
	_T.gToolTipCallout = nil

	if v9 == nil and not __wf_atom_7e8ad928(colorPickerCallback) then
		colorPickerCallback(_T.ColorPickerCurrentColor)
	end

	_T.InfoPopup_Data = nil

	if v21 and not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if not (v25 or __wf_atom_7e8ad928(_T.HideBackground)) then
		_T.HideBackground(0.25)
	end

	if not __wf_atom_7e8ad928(v26) then
		v26:Close()
	end
end

local function fn4()
	local v27 = {}

	for i = #v10, 1, -1 do
		local v28 = v10[i]

		if v28.mVisible then
			table.insert(v27, {
				Label = v28.mLabel,
				CallBack = v28.mCallback,
				CallOut = v28.mCallout
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v27, getfenv(1))
	end
end

local function fn5()
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.2, 0, function()
		flag2 = true
	end)
end

local function fn6(p)
	if v9 == nil and not __wf_atom_7e8ad928(colorPickerCallback) then
		colorPickerCallback(_T.ColorPickerCurrentColor)
		colorPickerCallback = nil
	end

	if not __wf_atom_7e8ad928(colorPickerOnCloseCallback) then
		colorPickerOnCloseCallback(not __wf_atom_7e8ad928(v9))
		colorPickerOnCloseCallback = nil
	end

	if not __wf_atom_7e8ad928(_T.OnSelectedColor) then
		_T.OnSelectedColor(not __wf_atom_7e8ad928(v9))
	end

	flag = true

	if p then
		mMovie:Close()
	else
		v17 = true
		fn5()
	end

	module.PlaySound(_G.UISound_WindowClose)
end

function Close(p)
	fn6(p == "true")
end

local function fn7()
	v12 = true
end

local function fn8()
	v12 = false
end

local function fn9() end

local function fn10()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			__wf_atom_9be88b01:__wf_atom_cab4e860(colors)
		end
	end
end

local function fn11()
	if __wf_atom_7e8ad928(v6) then
		return
	end

	local focusedElement = v6:GetFocusedElement()

	if __wf_atom_7e8ad928(focusedElement) or focusedElement.IsPadding or __wf_atom_7e8ad928(v19) then
		return
	end

	local v27 = nil

	for i = 1, #colors do
		if colors[i] ~= focusedElement.Color then
			continue
		end

		v27 = i
		break
	end

	module.PlaySound(_G.UISound_Select)

	if v27 == nil then
		if #colors == 25 then
			module.ShowMessage("/Lotus/Language/Menu/ColorPickerMaxFavorites")
		elseif focusedElement.mIsLocked then
			module.ShowMessage("/Lotus/Language/Menu/ColorPickerCantFavLocked")
		elseif v19.mCurrCategory ~= v18.CUSTOM then
			if v11 then
				module.ShowMessage("/Lotus/Language/Menu/ColorPickerCantFavLegacy")
				return
			end

			table.insert(colors, focusedElement.Color)
			fn10()
			v6.mElementDrawCallback(focusedElement, false)
		end
	else
		table.remove(colors, v27)
		fn10()

		if v19.mCurrCategory == v18.FAVORITE then
			fn()
		else
			v6.mElementDrawCallback(focusedElement, false)
		end
	end
end

local function fn12(p, _, p2)
	if p and not p2 then
		local item

		if not __wf_atom_7e8ad928(storeItem) then
			item = storeItem:GetItem()
		end

		v13 = module2.GetAvailableColourPickers(v, false)
		table.sort(v13, fn2)
		fn3(item)

		if not __wf_atom_7e8ad928(v26) then
			v26:Execute("TransitionOut", "")
		end
	end

	flag = false
end

function OnDetailedViewComplete(_)
	v26 = nil
	flag = false
end

local function fn13()
	if __wf_atom_7e8ad928(storeItem) then
		return
	end

	if
		module2.GetUIMode() ~= module2.UI_MODE_IN_GAME
		or not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_fa19955e)
	then
		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = storeItem },
			CALLBACK = fn12
		}
		v26 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)

		if not __wf_atom_7e8ad928(v26) then
			flag = true
			v26:Execute("SetIgnoreTopMenu", module.Ternary(v16, "true", "false"))
			v26:Execute("SetExitCallback", "OnDetailedViewComplete")
		end
	end
end

function PurcasePalette()
	fn8()
	fn13()
end

local function fn14()
	local module6 = require("EE.Interface.Components.Grid")
	v6 = module6.CreateGrid(mMovie, "Picker.ColorPanel.Color", nil, 20, 18)

	if Engine.__wf_atom_dd1285f1() then
		v6:SetCallbacks("ColorSelected", nil, nil, "ColorPressed", nil, nil, "ColorSelected")
		v6:EnableDrag()
	else
		v6:SetCallbacks("ColorSelected", "ColorFocused", "ColorUnfocused", "ColorPressed", nil, nil, "ColorSelected")
	end

	v6.mElementDelayTime = 0.003
	v6.mColumnSeparation = 29
	v6.mRowSeparation = 29
	v6.mFoundCurrColor = false
	v6.mDepthDirection = 1
	v6.mSize = { 38, 60 }

	function v6.mGetElementCenter(p)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p.mClipName, 1)
		local v27 = v6.mSize[2]
		return __wf_atom_5e6e15c8 + v27 / 2, __wf_atom_5e6e15c8_2 + v27 / 2
	end

	function v6.mOnDraggedCallback()
		local dragIndex = v6.mClickDrag.DragIndex
		local focusedIndex = v6.mClickDrag.FocusedIndex

		if
			v6:GetElementInIndex(focusedIndex).IsPadding
			or __wf_atom_7e8ad928(colors[dragIndex])
			or __wf_atom_7e8ad928(colors[focusedIndex])
		then
			return
		end

		local v27 = colors
		local v28 = colors
		local v29 = colors[focusedIndex]
		local v30 = colors[dragIndex]
		v27[dragIndex] = v29
		v28[focusedIndex] = v30
		fn10()
		fn()
	end

	function v6:mOnFocusedCallback()
		if self.mClipName == nil then
			return
		end

		module.PlaySound(_G.UISound_Focus)
		v15 = not self.IsPadding

		if (not flag or mOwned) and not (__wf_atom_7e8ad928(colorPickerCallback) or self.IsPadding) then
			color = self.Color
			colorPickerCallback(self.Color, storeItem)
		end

		if self.mOrigDepth == nil then
			self.mOrigDepth = tonumber(__wf_atom_86cbd68d(mMovie, self.mClipName .. ".getDepth"))
			__wf_atom_86cbd68d(
				mMovie,
				self.mClipName .. ".swapDepths",
				v6.mInitialDepth + (v6.mTopClipIndexUsed + 2) * v6.mDepthDirection
			)
		end

		if not __wf_atom_7e8ad928(self.Dim) then
			__wf_atom_ec43d06e(
				mMovie,
				self.mClipName .. ".Color",
				2,
				{ 14, 15 },
				{ self.Dim * 1.15, self.Dim * 1.15 },
				0.2
			)
		end
	end

	function v6:mOnUnfocusedCallback()
		if self.mClipName == nil then
			return
		end

		v15 = false

		if self.mOrigDepth ~= nil then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".swapDepths", self.mOrigDepth)
			self.mOrigDepth = nil
		end

		if not __wf_atom_7e8ad928(self.Dim) then
			__wf_atom_ec43d06e(mMovie, self.mClipName .. ".Color", 2, { 14, 15 }, { self.Dim * 1, self.Dim * 1 }, 0.1)
		end
	end

	function v6.mOnSelectedCallback(data)
		if data.mClipName == nil or (flag or data.IsPadding) then
			return
		end

		if data.mIsLocked then
			if _T.HidePurchaseInfo then
				module.PlaySound(_G.UISound_Error)
			else
				fn13()
			end
		else
			module.PlaySound(_G.UISound_ButtonSelect)
			module.PlaySound(_G.UISound_ItemTipSection)

			if not __wf_atom_7e8ad928(v9) then
				mMovie:__wf_atom_7f57ab2f(v9.mClipName, "Selected", 13, false)
			end

			v9 = data
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Selected", 13, true)
			colorPickerCallback = nil
			fn6()
		end
	end

	if Engine.__wf_atom_2a979d69() then
		function v6.mOnDragFocusedCallback(p)
			if not __wf_atom_7e8ad928(v6) then
				v6:FocusElementById((tonumber(p.Id)))
			end
		end

		function v6.mOnDragUnfocusedCallback(p)
			if not __wf_atom_7e8ad928(v6) then
				v6:UnfocusElementById((tonumber(p.Id)))
			end
		end
	end

	function v6:mElementDrawCallback(p)
		if self.mClipName == nil then
			return
		end

		local v27 = not __wf_atom_7e8ad928(v19) and v19.mCurrCategory == v18.FAVORITE
		local v28 = not __wf_atom_7e8ad928(v19) and v19.mCurrCategory == v18.CUSTOM
		local v29 = false

		if not (v27 or v28) then
			for i = 1, #colors do
				if colors[i] ~= self.Color then
					continue
				end

				v29 = true
				break
			end
		end

		self.mIsFavorite = v29 or v27
		local v30 = storeItem.mItem == defaultColourPalette
		local mIsLocked = not mOwned and (self.Id % mColumns ~= 3 or not v30)

		if v27 or v28 then
			mIsLocked = false
		end

		self.mIsLocked = mIsLocked
		mMovie:__wf_atom_2dedec1a(self.mClipName, 67, not self.IsPadding)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Favorite", 11, v22.FloatingContent)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Favorite", 13, self.mIsFavorite and not (self.mIsLocked or v27))
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Selected", 11, v22.FloatingContentHighlight)

		if p == nil or p then
			local v31 = self.Color == _T.ColorPickerCurrentColor
			mMovie:__wf_atom_7f57ab2f(
				self.mClipName,
				"Selected",
				13,
				v31 and not self.mIsLocked and (v27 or v28 or not v6.mFoundCurrColor)
			)

			if v31 then
				v6.mFoundCurrColor = true
			end
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Lock", 11, v22.FloatingContent)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Lock", 13, self.mIsLocked)

		if self.Alpha ~= nil and self.mInitialized then
			mMovie:__wf_atom_e57658c2(self.mClipName, 12, self.Alpha)
		end

		local dim = v6.mSize[module.Ternary(v6.mIsLargeGrid, 2, 1)]
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, dim)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 15, dim)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Selected", 0, module.Ternary(v6.mIsLargeGrid, 55, 30))
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Color", 0, dim * 0.5)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Color", 1, dim * 0.5)
		mMovie:__wf_atom_290807ee(self.mClipName .. ".Color")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Color", 14, dim)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Color", 15, dim)
		self.Dim = dim
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Color", module.Ternary(self.IsPadding, checkerBoardTexture, nil))
		mMovie:OverrideMaterial(self.mClipName .. ".Color", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Color",
			"RectEdgeColor",
			v22.Background1Object.r,
			v22.Background1Object.g,
			v22.Background1Object.b,
			1
		)

		if self.IsPadding then
			mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Color",
				"RectInnerColor",
				v22.ContentObject.r,
				v22.ContentObject.g,
				v22.ContentObject.b,
				0.25
			)
			return
		end

		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(self.Color)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Color",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)
	end
end

fn = function()
	local v27 = {}
	local v28 = false

	if
		__wf_atom_7e8ad928(v19)
		or v19.mCurrCategory ~= v18.FAVORITE and v19.mCurrCategory ~= v18.CUSTOM
		or colors == nil and __wf_atom_7e8ad928(_T.ColorPickerSpecificColorsInfo)
	then
		if __wf_atom_7e8ad928(storeItem) then
			v6.mColumns = 5
			v27 = module2.GetPhotoshopDefaultSwatches()
		else
			local v29 = Resource(storeItem.mItem)
			mColumns = v29:__wf_atom_55d04147()
			v27 = v29:__wf_atom_8f6061c7()
			v11 = v29:__wf_atom_ba5532de()
			v6.mIsLargeGrid = false
			v6.mRows = 18
			v6.mColumns = mColumns

			if __wf_atom_7e8ad928(v27) then
				v6.mColumns = 5
				v27 = module2.GetPhotoshopDefaultSwatches()
				print(storeItem:__wf_atom_5b41f63b())
			end

			mOwned = v8.Picker.mOwned
		end
	else
		v28 = true
		v6.mIsLargeGrid = true
		v6.mColumns = 5
		v6.mRows = 5
		local colors2 = colors
		local v29

		if __wf_atom_7e8ad928(_T.ColorPickerSpecificColorsInfo) then
			v29 = 25
		else
			colors2 = _T.ColorPickerSpecificColorsInfo.Colors
			v29 = #colors2
		end

		for i = 1, v29 do
			if i <= #colors2 then
				table.insert(v27, colors2[i])
			else
				table.insert(v27, "PADDING")
			end
		end

		mOwned = true
	end

	v6:RemoveElements(true, true)
	local v29 = storeItem.mItem == defaultColourPalette

	for i = 1, #v27 do
		local alpha = (mOwned or v29 and i % mColumns == 3) and 100 or 50
		v6:AddElement({
			Id = i,
			Color = v27[i],
			Alpha = alpha,
			IsPadding = v27[i] == "PADDING"
		}, true)
		local _ = v27[i] == _T.ColorPickerCurrentColor
	end

	local v30 = v6.mSize[module.Ternary(v6.mIsLargeGrid, 2, 1)] + module.Ternary(v6.mIsLargeGrid, 2, 1)
	v6.mColumnSeparation = v30 - 4
	v6.mRowSeparation = v30 - 4
	local v31 = v6.mColumns * v6.mColumnSeparation + 15
	local v32 = v6.mRows * v6.mRowSeparation + 15
	mMovie:__wf_atom_e57658c2("Picker.ColorListBg", 14, v31)
	mMovie:__wf_atom_e57658c2("Picker.ColorListBg", 15, v32)
	mMovie:__wf_atom_e57658c2("Picker.FavoritesLabel", 1, mMovie:__wf_atom_5e6e15c8("Picker.ColorPanel", 1) + v32 + 10)
	local mOwned2 = not __wf_atom_7e8ad928(v8) and v8.Picker.mOwned
	v23:SetVisible(not (v6.mIsLargeGrid or mOwned2 or _T.HidePurchaseInfo))
	mMovie:__wf_atom_2dedec1a("FavoritesLabel", 13, not v6.mIsLargeGrid and mOwned2)
	v6.mFoundCurrColor = false
	v6:Redraw(nil, false, v28)
end

local function fn15()
	local module6 = require("EE.Interface.Components.Grid")
	v7 = module6.CreateGrid(mMovie, "Picker.PaletteGrid.Palette", nil, 2, 4)
	v7:SetCallbacks("PalettePressed", "PaletteFocused", "PaletteUnfocused")
	v7.ElementWidth = 140
	v7.ElementHeight = 140
	v7.ElementDimBuffer = 20
	v7.ElementHeightBuffer = 28
	v7.Width = 350
	v7.Height = 650
	v7.mUseCornerForSelected = true
	module3.InitializeGridItem(mMovie, v7)
	v7:AttachScrollBar("Picker.PaletteGrid.ScrollBar", -27)
	v7:EnableSmoothScroll()
	v7.VisibleRangeMaterial = visibleRangeMaterial
	v7.TextVisibleRangeMaterial = visibleRangeTextMaterial
	v7.RectangleVisibleRangeMaterial = visibleRangeRectangleMaterial

	function v7.mClipCreatedCallback(p, _)
		module3.OnGridItemCreated(mMovie, v7, p)
	end

	function v7.mOnFocusedCallback(data)
		if data.mClipName == nil or data.Filler then
			return
		end

		local isSelected = v7.mSelectedElement ~= nil and data.Id == v7.mSelectedElement.Id
		module3.OnGridItemFocusChanged(mMovie, v7, data, {
			IsSelected = isSelected,
			IsFocused = true,
			ShowInfoPopup = true,
			DisableSaturation = true
		})
	end

	function v7.mOnUnfocusedCallback(data)
		if data.mClipName == nil or data.Filler then
			return
		end

		local isSelected = v7.mSelectedElement ~= nil and data.Id == v7.mSelectedElement.Id
		module3.OnGridItemFocusChanged(mMovie, v7, data, {
			IsSelected = isSelected,
			IsFocused = false,
			DisableSaturation = true
		})
	end

	function v7.mOnSelectedCallback(data)
		if data.Filler or v8 == data then
			return
		end

		if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v8.mClipName)) then
			v7.mElementDrawCallback(v8)
			mMovie:__wf_atom_1ca72041(
				v8.mClipName .. ".Bg",
				"RectInnerColor",
				_G.UIColorObject_White.r,
				_G.UIColorObject_White.g,
				_G.UIColorObject_White.b,
				0.1
			)
		end

		local picker = data.Picker

		if not (__wf_atom_7e8ad928(picker) or __wf_atom_7e8ad928(picker.mItem)) then
			v8 = data
			storeItem = picker
			fn()

			if data.mClipName ~= nil then
				mMovie:__wf_atom_1ca72041(
					data.mClipName .. ".Bg",
					"RectInnerColor",
					_G.UIColorObject_White.r,
					_G.UIColorObject_White.g,
					_G.UIColorObject_White.b,
					0.4
				)
			end
		end

		v7.mElementDrawCallback(data)
	end

	function v7.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		local isSelected

		if v7.mSelectedElement == nil then
			isSelected = false
		else
			isSelected = data.Id == v7.mSelectedElement.Id
		end

		local focusedElement = v7:GetFocusedElement()
		local v27 = {
			IsSelected = isSelected,
			IsFocused = not __wf_atom_7e8ad928(focusedElement) and data.Id == focusedElement.Id,
			HideCountThreshold = 0,
			DisableSaturation = true
		}

		if not data.Filler then
			v27.HidePrice = data.Count > 0 or _T.HidePurchaseInfo
		end

		module3.DrawGridItem(mMovie, v7, data, v27)
	end
end

fn3 = function(p)
	local hidePurchaseInfo = _T.HidePurchaseInfo
	v7:RemoveElements(true, true)
	local count = 0
	local v27 = nil

	for i = 1, #v13 do
		local picker = v13[i]

		if not (not hidePurchaseInfo or picker.mOwned or picker.mStoreItem:GetItem() == defaultColourPalette) then
			continue
		end

		if picker.mOwned then
			count += 1
		end

		if v27 == nil and picker.mOwned then
			if p == nil or p ~= picker.mStoreItem:GetItem() then
				local __wf_atom_8f6061c7 = Resource(picker.mItem):__wf_atom_8f6061c7()

				if not __wf_atom_7e8ad928(__wf_atom_8f6061c7) then
					for j = 1, #__wf_atom_8f6061c7 do
						if __wf_atom_8f6061c7[j] ~= _T.ColorPickerCurrentColor then
							continue
						end

						v27 = i
						break
					end
				end
			else
				v27 = i
			end
		end

		v7:AddElement({ Picker = picker, Count = 1 }, true)
	end

	local howManyElements = v7:GetHowManyElements()

	for _ = 1, howManyElements % v7.mColumns do
		v7:AddElement({ Filler = true }, true)
	end

	local convertColorNumberToHex = module.ConvertColorNumberToHex(v22.FloatingContent)
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(v22.FloatingContentHighlight)
	local v28 = "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/ColorPickerCollectedLabel",
		false,
		{
			COLOR = "<font color=\"" .. convertColorNumberToHex2 .. "\">",
			OWNED = module.FormatNumber(count),
			TOTAL = module.FormatNumber(howManyElements),
			NO_COLOR = "</font>"
		}
	) .. "</font></p>"
	mMovie:__wf_atom_50d60589("Picker.CollectedLabel", 36, v28)
	local v29 = v27 == nil and 1 or v27
	v7:Redraw(function()
		if __wf_atom_7e8ad928(_T.ColorPickerSpecificColorsInfo) and v29 <= v7:GetHowManyElements() then
			v7:ScrollToElement(v29, nil, true)
			v7:SelectElementById(v29)
		end
	end)
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v19) then
		v19:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v19) then
		v19:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v19)) then
		v19:SelectElementById(tonumber(p), true)
	end
end

local function fn16()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		module.Ternary(Engine.IsPlayingWithController(), "<MENU_RTRIGGER1>", "<MENU_RIGHT_CLICK>"),
		true
	)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
		module.Ternary(Engine.IsPlayingWithController(), "<MENU_SELECT>", "<MENU_CLICK>"),
		true
	)
	local v27 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ColorPickerRemoveFavTip", true, {
		CALLOUT = __wf_atom_8e9ac384
	}) .. "\r" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ColorPickerDragFavTip", true, {
		CALLOUT = __wf_atom_8e9ac384_2
	})
	mMovie:__wf_atom_50d60589("Picker.FavoritesLabel", 36, v27)
	mMovie:__wf_atom_7d7314f1("FavoritesLabel.Label.text", "/Lotus/Language/Menu/ColorPickerToggleFavTip", {
		CALLOUT = __wf_atom_8e9ac384
	})
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("FavoritesLabel.Label", 40)
	mMovie:__wf_atom_e57658c2("FavoritesLabel.Bg", 14, __wf_atom_5e6e15c8 + 20)
	mMovie:__wf_atom_e57658c2("FavoritesLabel.Bg", 0, -(__wf_atom_5e6e15c8 / 2))
end

local function fn17(category)
	if __wf_atom_7e8ad928(v19) or v19.mCurrCategory == category then
		return
	end

	flag = true

	local function fn18()
		mMovie:__wf_atom_2dedec1a("Picker.FavoritesLabel", 13, category == v18.FAVORITE)
		mMovie:__wf_atom_2dedec1a("Picker.ColorListBg", 13, category == v18.PALETTE)
		mMovie:__wf_atom_2dedec1a("Picker.CollectedLabel", 13, category == v18.PALETTE)
	end

	if category == v18.FAVORITE or category == v18.CUSTOM then
		__wf_atom_ec43d06e(mMovie, "Picker.PaletteGrid", 0, { 12 }, { 0 }, 0.1)
		__wf_atom_ec43d06e(mMovie, "Picker.ColorPanel", 0, { 12 }, { 0 }, 0.1, 0, function()
			fn18()
			mMovie:__wf_atom_2dedec1a("Picker.PaletteGrid", 13, false)
			mMovie:__wf_atom_e57658c2("Picker.ColorPanel", 0, v20 - 344)
			__wf_atom_ec43d06e(mMovie, "Picker.ColorPanel", 0, { 12 }, { 100 }, 0.15, 0.05, function()
				flag = false
			end)
			fn()
		end)
	else
		mMovie:__wf_atom_2dedec1a("Picker.PaletteGrid", 13, true)
		__wf_atom_ec43d06e(mMovie, "Picker.ColorPanel", 0, { 12 }, { 0 }, 0.1, 0, function()
			fn18()
			mMovie:__wf_atom_e57658c2("Picker.ColorPanel", 0, v20)
			__wf_atom_ec43d06e(mMovie, "Picker.ColorPanel", 0, { 12 }, { 100 }, 0.15, 0.05)
			__wf_atom_ec43d06e(mMovie, "Picker.PaletteGrid", 0, { 12 }, { 100 }, 0.15, 0.05, function()
				flag = false
			end)
			fn()
		end)
	end

	v19.mCurrCategory = category

	if category == v18.FAVORITE then
		v6:EnableDrag()
	elseif not Engine.__wf_atom_dd1285f1() then
		v6.mClickDrag.Enabled = false
	end
end

local function fn18()
	local module6 = require("Lotus.Interface.Components.ThemedCategoriesMenu")
	v19 = module6.Create(mMovie, "Picker.CategoryMenu")
	v19.mAlign = module.LEFT_ALIGNED
	v19.mCurrCategory = v18.PALETTE

	function v19.mOnSelectedCallback(p)
		fn17(p.Category)
	end

	if __wf_atom_7e8ad928(_T.ColorPickerSpecificColorsInfo) then
		v19:AddElement(
			{
				Category = v18.PALETTE,
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ColorPickerCategoryPalettes", false),
				Icon = categoryIcons[1]
			},
			true
		)
		v19:AddElement(
			{
				Category = v18.FAVORITE,
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ColorPickerCategoryFavorites", false),
				Icon = categoryIcons[2]
			},
			true
		)
	else
		v19:AddElement(
			{
				Category = v18.CUSTOM,
				Name = mMovie:__wf_atom_8e9ac384(_T.ColorPickerSpecificColorsInfo.Title, false),
				Icon = module.Ternary(
					__wf_atom_7e8ad928(_T.ColorPickerSpecificColorsInfo.Icon),
					categoryIcons[1],
					_T.ColorPickerSpecificColorsInfo.Icon
				)
			},
			true
		)
	end

	v19:Redraw(nil, true, true)
end

fn2 = function(p, p2)
	local mOwned2 = p.mOwned or p.mStoreItem:GetItem() == defaultColourPalette
	local mOwned3 = p2.mOwned or p2.mStoreItem:GetItem() == defaultColourPalette

	if mOwned2 and not mOwned3 then
		return true
	end

	if mOwned2 or not mOwned3 then
		return mMovie:__wf_atom_8e9ac384(p.mStoreItem:__wf_atom_014a76a2():c_str(), false) < mMovie:__wf_atom_8e9ac384(
			p2.mStoreItem:__wf_atom_014a76a2():c_str(),
			false
		)
	end

	return false
end

local function fn19()
	if __wf_atom_7e8ad928(v7) then
		return
	end

	local _, v27 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("Bg", 15, v27 + 300)
	local v28 = v7.mRowSeparation * v7.mRows - v7.ElementDimBuffer
	local _, v29 = module.GetRootBasedPosition(mMovie, "Picker.PaletteGrid")
	module.GetVisibilitySize(mMovie, v28)
	module.GetVisibilityCenter(mMovie, v29 + v28 / 2)
end

local function fn20()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Picker", 2)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("Picker", 3)
	local v27 = __wf_atom_5e6e15c8_3 + v7.Width
	local v28 = __wf_atom_5e6e15c8_4 + v7.Height
	return __wf_atom_5e6e15c8_3 <= __wf_atom_5e6e15c8
		and __wf_atom_5e6e15c8 <= v27
		and __wf_atom_5e6e15c8_4 <= __wf_atom_5e6e15c8_2
		and __wf_atom_5e6e15c8_2 <= v28
end

function SetSquadTitle(p)
	v21 = true

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p, false)
		_T.SetSquadOverlayTitle(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ColorPickerTitle", false),
			__wf_atom_8e9ac384
		)
	end
end

local function fn21()
	v13 = {}
	table.insert(v13, {
		mItem = "/Lotus/Types/StoreItems/SuitCustomizations/ColourPickerDefaultsItemA",
		mIsAccessibility = false,
		mOwned = true
	})
	table.sort(v13, fn2)
	local mItems = {}

	for _, v27 in ipairs(v13) do
		table.insert(mItems, v27.mItem)
	end

	v14 = UISys.__wf_atom_c0dbe47c(mItems)
	flag = true
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
end

function Initialize()
	local module6 = require("Lotus.Interface.Libs.TimerMgr")
	v4 = module6.CreateTimerMgr()
	v = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(v) then
		v14 = UISys.__wf_atom_c0dbe47c({ v2:__wf_atom_5b41f63b() })
		flag = true
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
	end

	if not __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		v24 = mMovie:__wf_atom_2ad5cd23():Execute("IsOpenedFromPauseMenu", "")
	end

	mMovie:__wf_atom_2dedec1a("Picker", 13, false)

	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		local _colorPickerUseCustomBg = _T.ColorPickerUseCustomBg
	end

	_T.ColorPickerUseCustomBg = nil
	v25 = true
	v22.FloatingContent = module4.GetColor(9, true)
	v22.Content = module4.GetColor(6, true)
	v22.ContentObject = module.ConvertColorNumberToProceduralRGB(v22.Content)
	v22.FloatingContentHighlight = module4.GetColor(10, true)
	v22.Background1 = module4.GetColor(2, true)
	v22.Background1Object = module.ConvertColorNumberToProceduralRGB(v22.Background1)
	v22.BackerHighlight = module4.GetColor(1, true)
	mMovie:__wf_atom_e57658c2("FavoritesLabel.Label", 44, v22.FloatingContent)
	mMovie:OverrideMaterial("FavoritesLabel.Bg", favBgMaterial)
	mMovie:__wf_atom_e57658c2("FavoritesLabel.Bg", 11, v22.Background1)
	mMovie:__wf_atom_e57658c2("Picker.FavoritesLabel", 44, v22.FloatingContent)
	mMovie:__wf_atom_2dedec1a("Picker.FavoritesLabel", 13, false)
	mMovie:OverrideMaterial("Picker.ColorListBg", _G.UIMaterial_RectangleNoDepth)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(v22.BackerHighlight)
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(v22.Background1)
	mMovie:__wf_atom_1ca72041(
		"Picker.ColorListBg",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.05
	)
	mMovie:__wf_atom_1ca72041(
		"Picker.ColorListBg",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.8
	)
	v3 = module5.Create(mMovie)
	v3:Register(mMovie, "Bg", { v3.ANCHOR_H_LEFT, v3.ANCHOR_V_TOP })
	v3:Register(mMovie, "Picker", { v3.ANCHOR_H_LEFT, v3.ANCHOR_V_CENTRE })
	v3:Register(mMovie, "FavoritesLabel", { v3.ANCHOR_H_RIGHT, v3.ANCHOR_V_BOTTOM })
	v3:Register(mMovie, "PurchaseBtn", { v3.ANCHOR_H_RIGHT, v3.ANCHOR_V_BOTTOM })
	v3:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_2dedec1a("Bg", 13, false)
	mMovie:__wf_atom_e57658c2("Bg", 11, v22.Background1)
	mMovie:__wf_atom_e57658c2("Bg", 12, 75)
	mMovie:OverrideMaterial("Bg", customBgMaterial)
	v20 = mMovie:__wf_atom_5e6e15c8("Picker.ColorPanel", 0)
	table.insert(v10, {
		mVisible = true,
		mLabel = "/Lotus/Language/Menu/Exit",
		mCallback = function()
			mMovie:Execute("onKeyDown_MENU_CANCEL", "")
		end,
		mCallout = "MENU_CANCEL"
	})

	if Engine.__wf_atom_2a979d69() then
		table.insert(v10, {
			mVisible = true,
			mLabel = "/Lotus/Language/Menu/Loadout_Apply",
			mCallback = function()
				local focusedElement = v6:GetFocusedElement()

				if not __wf_atom_7e8ad928(focusedElement) then
					mMovie:Execute("ColorSelected", focusedElement.Id)
				end
			end
		})
		table.insert(v10, {
			mVisible = true,
			mLabel = "/Lotus/Language/SystemMessages/Favorite",
			mCallback = function()
				fn11()
			end
		})
	end

	fn4()
	local module7 = require("Lotus.Interface.Components.ThemedButton")
	v23 = module7.Create(mMovie, "PurchaseBtn", "/Lotus/Language/Menu/Global_BuyItem", "PurcasePalette")
	v23:SetSpecialMode()
	v23:SetWidth(150)
	v23:SetVisible(false)
	v23:Redraw()
	colors = {}
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			colors = __wf_atom_9be88b01:__wf_atom_0e7d8487()

			if colors == nil then
				colors = {}
			end
		end
	end

	fn21()
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v4) then
		v4:Update(__wf_atom_fa1258d0())
	end

	if __wf_atom_7e8ad928(v) then
		if v14 == nil then
			LogBug("Where did the loader go?")
		elseif v14:__wf_atom_86399a47() then
			v = Resource(v2)
		end
	end

	local v27 = (not _T.TopMenuOpen or v24) and __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(profileReduxMovie)))
	mMovie:SetVisible(v27)

	if flag2 then
		mMovie:Close()
		return
	end

	if v14 ~= nil then
		if not v14:__wf_atom_86399a47() then
			return
		end

		flag = false
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

		for _, v28 in ipairs(v13) do
			v28.mItem = Resource(v28.mItem)
		end

		if not v5 then
			fn15()
			fn18()
			fn3()
			fn14()

			if not __wf_atom_7e8ad928(_T.ColorPickerCallback) then
				colorPickerCallback = _T.ColorPickerCallback
			end

			if not __wf_atom_7e8ad928(_T.ColorPickerOnCloseCallback) then
				colorPickerOnCloseCallback = _T.ColorPickerOnCloseCallback
			end

			mMovie:__wf_atom_e57658c2("Picker.PaletteGrid", 12, 0)
			v19:SelectElement(1)
			fn16()
			v4:AddTimer(0.15, function()
				flag = false
				__wf_atom_ec43d06e(mMovie, "Picker.PaletteGrid", 0, { 12 }, { 100 }, 0.15)
			end)
			mMovie:__wf_atom_2dedec1a("FavoritesLabel", 13, v19.mCurrCategory ~= v18.CUSTOM)
			fn19()
			module.PlaySound(_G.UISound_WindowOpen)
			mMovie:__wf_atom_2dedec1a("Picker", 13, true)
			v5 = true
		end

		v14 = nil
	end

	if
		not v15
		and not __wf_atom_7e8ad928(v6)
		and not __wf_atom_7e8ad928(colorPickerCallback)
		and color ~= _T.ColorPickerCurrentColor
	then
		color = _T.ColorPickerCurrentColor
		colorPickerCallback(_T.ColorPickerCurrentColor, nil)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Update(__wf_atom_fa1258d0())
	end

	mMovie:__wf_atom_40912f8e(not fn20())
	fn9()
end

function RollOver()
	module.PlaySound(_G.UISound_Focus)
end

function onKeyDown_MENU_CANCEL()
	if not flag then
		fn6()
	end

	return true
end

function ColorFocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:FocusElementById((tonumber(p)))
	end
end

function ColorUnfocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:UnfocusElementById((tonumber(p)))
	end
end

function ColorPressed(p)
	if not __wf_atom_7e8ad928(v6) then
		local elementById = v6:GetElementById((tonumber(p)))

		if not (__wf_atom_7e8ad928(elementById) or elementById.IsPadding) then
			v6:PressedElementById((tonumber(p)))
		end
	end
end

function ColorSelected(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:SelectElementById((tonumber(p)))
	end
end

function PaletteFocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:FocusElementById((tonumber(p)))
		module.PlaySound(_G.UISound_Focus)
	end
end

function PaletteUnfocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:UnfocusElementById((tonumber(p)))
	end
end

function PalettePressed(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:SelectElementById((tonumber(p)))
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_ItemTip)
	end
end

function SetPage(p)
	if not (flag or __wf_atom_7e8ad928(v6)) then
		flag = true
		v6:SetCurrentPage(tonumber(p), function()
			flag = false
		end)
	end
end

function RollOverPage(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:FocusPageById((tonumber(p)))
	end
end

function RollOutPage(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:UnfocusPageById((tonumber(p)))
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (flag or __wf_atom_7e8ad928(v7.mScrollBar)) then
		module.PlaySound(_G.UISound_Scroll)
		v7.mScrollBar:ScrollByStep((tonumber(p)))
	end
end

local function fn22(_) end

function onKeyDown_MENU_RIGHT_X(_, p)
	fn22(p)
	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	fn22(p)
	return true
end

function onKeyDown_MENU_RTRIGGER1()
	if flag then
		return
	end

	fn11()
	return true
end

function onKeyDown_MENU_CLICK()
	if flag or Engine.IsPlayingWithController() then
		return
	end

	fn7()
end

function onKeyUp_MENU_CLICK()
	if flag or Engine.IsPlayingWithController() then
		return
	end

	fn8()
end

function onKeyDown_MENU_RIGHT_CLICK()
	if flag then
		return
	end

	fn11()
	return true
end

local function fn23(p)
	if not __wf_atom_7e8ad928(v19) then
		v19.mMuteFocusSound = true
		local focusedElement = v19:GetFocusedElement()

		if v19.mSelectedElement and (focusedElement == nil or focusedElement.Id ~= v19.mSelectedElement.Id) then
			v19:FocusElementById(v19.mSelectedElement.Id)
		end

		v19:ToggleFocusedElement(p)
		v19:SelectCurrentElement()
		v19.mMuteFocusSound = false
	end
end

function onKeyDown_MENU_RTRIGGER2()
	if flag then
		return
	end

	fn23(module.INCREMENT)
	return true
end

function onKeyDown_MENU_LTRIGGER2()
	if flag then
		return
	end

	fn23(module.DECREMENT)
	return true
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v3) then
		v3:Update(p, p2)
	end

	fn19()
end

function IconCacheFlushed()
	fn16()
end

function OnGamepadTransition(_)
	fn16()
end

function SetIgnoreTopMenu(p)
	v16 = p == "true"
end

function SupportsThemes()
	return true
end