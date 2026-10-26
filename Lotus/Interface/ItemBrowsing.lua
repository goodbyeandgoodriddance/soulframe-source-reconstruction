local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.CardUtilitiesRedux")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.SequencerUtilities")
local module6 = require("SF.Interface.Libs.UIUtilities")
local module7 = require("Lotus.Interface.UIStyleUtilities")
local module8 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = false
local v3 = nil
local v4 = nil
local v5 = false
local flag = true
local v6 = nil
local v7 = nil
local v8 = { Materials = {}, Size = 0, YPos = 0 }
local mLabel2 = "/Lotus/Language/Menu/MissionStats_Done"
local mLabel3 = "/Menu/Confirm_Item_Cancel"
local v9 = ""
local v10 = {}
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = false
local v17 = 0
local v18 = true
local v19 = { Enabled = false, VariableLower = true }
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local topMenuOpen = false
local v24 = nil
local v25 = nil
local hideCountThreshold = 0
local v26 = false
local v27 = false
local v28 = nil
local v29 = { Loader = nil, IsLoading = false }
local v30 = { Active = false, Controller = nil }
local v31 = false
local v32 = nil
local v36 = nil
local v37 = nil
local v38 = { BROWSE = 1, SELECT = 2 }
local browse = nil
local gameData = nil
local v40 = nil
local v41 = nil
local v42 = nil
local flag2 = false
local v43 = false
local v44 = false
local v45 = false
local fn
local fn2

function GetCards()
	return nil
end

function GetSelectedCards()
	return {}
end

function GetSelectedElement()
	return nil
end

local function fn3()
	if flag2 then
		return
	end

	flag2 = true

	if not __wf_atom_7e8ad928(v28) then
		gRegion:__wf_atom_dd1e4d10(v28)
	end

	if v44 and not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.CurrentSearchTerm = nil
	module.RegisterHideHud(false)

	if not __wf_atom_7e8ad928(v41) then
		if flag2 and v44 then
			v41:Execute("ForcePrevBGVis", "false")
		end

		v41:Close()
	end

	fn3()

	if v ~= nil then
		if not __wf_atom_7e8ad928(v.StepSequencer) then
			v.StepSequencer:Destroy()
		end

		v = nil
	end

	if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(_T[v15]) or v16) then
		_T[v15](v21, v7:GetSortById())
	end

	module6.ClearGridModMaterials()

	if v43 then
		_T.DisableUIInput()
	end

	if not (v6 or __wf_atom_7e8ad928(gGameRules)) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if topMenuOpen then
		local mainMenuSuitAvatar = module.GetMainMenuSuitAvatar()

		if not __wf_atom_7e8ad928(mainMenuSuitAvatar) then
			mainMenuSuitAvatar:SetVisibility(true)
			mainMenuSuitAvatar:__wf_atom_e424c72a(true)
		end
	end
end

function OnUpdateSessionSettings() end

function IsFusionMode()
	return false
end

local function fn4()
	if _T.ForegroundMovie and _T.CanShowPlayTypeDropDown then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "true")
	end

	if _T.ForegroundMovie then
		_T.ForceHideLobbyStatusMessage = false
	end

	fn3()
	flag = true

	if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(_T[v15])) then
		_T[v15](v21, v7:GetSortById())
		v16 = true
	end

	mMovie:Close()
end

function TransitionOut()
	fn4()
end

local function fn5()
	module2.PlaySound(_G.UISound_WindowClose)
	local v46

	if _T.IsInScreenStack then
		v46 = _T.IsInScreenStack("ItemBrowsing")
	else
		v46 = false
	end

	if v46 then
		_T.GoToPreviousScreen()
	else
		fn4()
	end
end

local function fn6()
	local v46 = {}

	for i = 1, #v10 do
		local v47 = v10[i]

		if not v47.mVisible then
			continue
		end

		local v48 = { Label = v47.mLabel, CallBack = v47.mCallback, CallOut = v47.mCallout }

		if v47.mPosition == nil then
			table.insert(v46, v48)
		else
			table.insert(v46, v47.mPosition, v48)
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v46, getfenv(1))
	end
end

local function fn7()
	local count = 0
	__wf_atom_83c14687(0)
	v7:RunForAllElements(function(p)
		if p.Selected then
			count += 1
		end
	end)
	return count
end

local function fn8(state, p)
	if state.mClipName == nil then
		return false
	end

	if v22 ~= nil and _T[v22] ~= nil then
		local v46, v47 = _T[v22]({ state })

		if not v46 then
			if v47 ~= nil and p == nil then
				module2.ShowMessage(v47)
			end

			return false
		end
	end

	local v46

	if v17 == 1 then
		v46 = not v19.Enabled or v19.VariableLower
	else
		v46 = false
	end

	if
		(state.Selected or not (fn7() < v17) and (not v19.Enabled or v19.VariableLower))
		and not (state.Selected or v46)
	then
		return false
	end

	if v46 and not state.Selected then
		v7:RunForAllElements(function(state2)
			if state2.Selected then
				state2.Selected = false

				if state2.mClipName ~= nil then
					v7.mElementDrawCallback(state2)
				end
			end
		end)
	end

	state.Selected = not state.Selected or v46

	if state.Selected then
		v7.mLastSelectedId = state.Id
	end

	return true
end

local function fn9(focusedElement)
	if v23 == nil or _T[v23] == nil or focusedElement == nil then
		return true
	end

	local v46, v47 = _T[v23](focusedElement)

	if not v46 then
		if v47 ~= nil then
			module2.ShowMessage(v47)
		end

		return false
	end

	return true
end

function ToggleSelection()
	fn8(v7:GetFocusedElement())
end

function ShowGroupedDecos()
	local v46 = 0

	if __wf_atom_7e8ad928(_T.DojoMgr) then
		local shipDecoRoom = module.GetShipDecoRoom()
		local v47 = module.GetDecoArea(shipDecoRoom) == module.DECO_AREA_APARTMENT
		v46 = gGameData:__wf_atom_31e514d3(shipDecoRoom, v47)
	else
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_58b2e21e = __wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_58b2e21e()
			local componentParams = _T.DojoMgr:BuildComponentParams(__wf_atom_58b2e21e)
			v46 = _T.DojoMgr.mDojo:GetJsonComponent(componentParams):__wf_atom_47a3d3d2()
		end
	end

	local v47 = Resource("/Lotus/Interface/DecoTemplate.swf")
	v41 = mMovie:PushChildMovie(v47)
	_T.HideBackground()
	local v48 = WeakResource("/Lotus/Interface/DecorationsHud.swf")
	local movie = __wf_atom_8e4fda44:FindMovie(v48)

	if not (__wf_atom_7e8ad928(v41) or __wf_atom_7e8ad928(movie)) then
		movie:Execute("Hide", "")
	end

	if __wf_atom_7e8ad928(_T.DojoMgr) then
	end

	v41:Execute("SetTitle", Localize("/Lotus/Language/Dojo/DecoTemplateTitle", {
		CAPACITY_REMAINING = v46
	}))
	v41:Execute("SetOnTransitionOutFunction", "OnFadeDecoTemplate")

	function _T.OnCloseDecoTemplate()
		_T.ShowBackground(0)
	end

	v41:Execute("SetOnPlaceDecoTemplateFunction", "OnPlaceDecoTemplate")

	function _T.OnPlaceDecoTemplate(groupedDeco)
		_T.ShowBackground(0)
		v21 = {
			{
				groupedDeco = groupedDeco,
				capacityCost = 1,
				Count = 1,
				IsVault = false,
				TreasureIds = nil
			}
		}
		fn4()
	end

	v41:Execute("SetOnDeleteDecoTemplateFunction", "OnDeleteDecoTemplate")

	function _T.OnDeleteDecoTemplate(_)
		_T.ShowBackground(0)
	end

	v41:Execute("SetCallback", "OnCloseDecoTemplate")

	function _T.OnCloseDecoTemplate()
		_T.ShowBackground(0)
	end

	v41:Execute("Initialize", "")
end

local v46 = {}

local function fn10()
	local function fn11(p, p2)
		if p ~= nil then
			if p then
				if p2 ~= nil and #v46 > 0 then
					if _T.GlyphOnPurchase ~= nil then
						_T.GlyphOnPurchase(p, p2)
					end

					v46[1].Count = p2.mQuantity
					v46[1].PurchasedStoreItem = p2.mStoreItem
					v46[1].NotOwned = false
					v7.mElementDrawCallback(v46[1])
				end
			else
				module2.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
			end
		end

		v46 = nil
	end

	if v17 == 1 and #v46 > 0 and v46[1].NotOwned and v46[1].Price > 0 then
		_T.BuyItem(v46[1].StoreItem, fn11)

		if v ~= nil and not __wf_atom_7e8ad928(v.StepSequencer) then
			v2 = v.StepSequencer:__wf_atom_160c488b()

			if not v2 then
				v.StepSequencer:SetPaused(true)
			end
		end
	else
		v21 = {}
		fn4()
	end
end

function OnCloseDetailedPurchase()
	if v ~= nil and not (__wf_atom_7e8ad928(v.StepSequencer) or v2) then
		v.StepSequencer:SetPaused(false)
	end
end

function OnConfirmSelection(p)
	if tonumber(p) == 4 then
		fn10()
	elseif not v19.Enabled and v17 > 1 and v7.mLastSelectedId ~= nil then
		local elementById = v7:GetElementById(v7.mLastSelectedId)

		if not __wf_atom_7e8ad928(elementById) then
			fn8(elementById)
			v7.mElementDrawCallback(elementById)
			v7.mLastSelectedId = nil
		end
	end
end

local function fn11(instance, __wf_atom_0aa77159, __wf_atom_ee03557f, p, flag3, p2, p3)
	if
		instance:IsA(__wf_atom_ca04301b)
		or instance:IsA(__wf_atom_6e7519b4)
		or instance:IsA(__wf_atom_d00f34c2)
		or instance:IsA(__wf_atom_c1ce4aea)
		or not p3 and instance:IsA(__wf_atom_7b01f9ce)
	then
		return __wf_atom_0aa77159, __wf_atom_ee03557f, flag3
	end

	local v47 = not (instance:IsA(__wf_atom_0ee166be) and instance:__wf_atom_e0345189()) and 1
		or instance:__wf_atom_9dc935f3() * 1.5
	local position = instance:GetPosition()

	if p then
		local v48 = (instance:__wf_atom_0aa77159() - instance:GetPosition()) * v47 + instance:GetPosition()
		local v49 = (instance:__wf_atom_ee03557f() - instance:GetPosition()) * v47 + instance:GetPosition()

		if flag3 then
			__wf_atom_ee03557f = v49
			__wf_atom_0aa77159 = v48
			flag3 = false
		else
			__wf_atom_8787c9ce(__wf_atom_0aa77159, __wf_atom_0aa77159, v48)
			__wf_atom_cfa3edf5(__wf_atom_ee03557f, __wf_atom_ee03557f, v49)
		end
	else
		local v48 = (instance:__wf_atom_0aa77159() - position) * v47
		local v49 = (instance:__wf_atom_ee03557f() - position) * v47

		if flag3 then
			__wf_atom_ee03557f = v49
			__wf_atom_0aa77159 = v48
			flag3 = false
		else
			__wf_atom_8787c9ce(__wf_atom_0aa77159, __wf_atom_0aa77159, v48)
			__wf_atom_cfa3edf5(__wf_atom_ee03557f, __wf_atom_ee03557f, v49)
		end
	end

	if p2 ~= nil then
		__wf_atom_0aa77159 += p2
		__wf_atom_ee03557f += p2
	end

	local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()

	for _, v48 in ipairs(__wf_atom_be0bea4a) do
		__wf_atom_0aa77159, __wf_atom_ee03557f = fn11(v48, __wf_atom_0aa77159, __wf_atom_ee03557f, p)
	end

	return __wf_atom_0aa77159, __wf_atom_ee03557f, flag3
end

local function fn12(entity, p, p2)
	local __wf_atom_0aa77159 = entity:__wf_atom_0aa77159()
	local __wf_atom_ee03557f = entity:__wf_atom_ee03557f()

	if not p then
		local position = entity:GetPosition()
		__wf_atom_0aa77159 -= position
		__wf_atom_ee03557f -= position
	end

	local v47 = __wf_atom_ee03557f - __wf_atom_0aa77159
	local v48 = math.max(v47.x, v47.y, v47.z) == 0
	local __wf_atom_be0bea4a = entity:__wf_atom_be0bea4a()

	for _, v49 in ipairs(__wf_atom_be0bea4a) do
		__wf_atom_0aa77159, __wf_atom_ee03557f, v48 = fn11(v49, __wf_atom_0aa77159, __wf_atom_ee03557f, p, v48, nil, p2)
	end

	return __wf_atom_0aa77159, __wf_atom_ee03557f
end

local function fn13()
	if not v18 and v17 == 1 then
		local mSelectedElement = v7.mSelectedElement

		if mSelectedElement == nil then
			mSelectedElement = v7:GetFocusedElement()
		end

		if mSelectedElement ~= nil and not mSelectedElement.Selected then
			fn8(mSelectedElement, true)
		end
	end

	if v19.Enabled and v19.VariableLower or not (fn7() < v17) then
		v46 = {}
		v7:RunForAllElements(function(p)
			if p.Selected then
				table.insert(v46, p)
			end
		end)

		if v22 ~= nil and _T[v22] ~= nil then
			local v47, v48 = _T[v22](v46)

			if not v47 then
				if v48 ~= nil then
					module2.ShowMessage(v48)
				end

				v46 = nil
				return
			end
		end

		local confirmPopupText = nil

		for _, v47 in ipairs(v46) do
			if v47.ConfirmPopupText ~= nil then
				confirmPopupText = v47.ConfirmPopupText
			end
		end

		if confirmPopupText == nil then
			confirmPopupText = v20
		end

		if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(_T[v14])) then
			confirmPopupText = _T[v14](v46)
		end

		if confirmPopupText == nil then
			fn10()
		else
			module2.ShowConfirmMessage(confirmPopupText, "OnConfirmSelection")
		end
	else
		local v47 = v17 - fn7()
		local v48 = mMovie:PushChildMovie(_G.UIMovie_ConfirmMovie)
		v48:Execute(
			"SetText",
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NeedToSelectMore", false, {
				HOW_MANY = v47
			})
		)
		v48:Execute("SetNumOptions", 1)
	end
end

local function fn14()
	local itemBrowsingElementWidth = _T.ItemBrowsingElementWidth or 142
	local itemBrowsingElementHeight = _T.ItemBrowsingElementHeight or 142
	local module9 = require("Lotus.Interface.Components.CategorizedGrid")
	v7 = module9.CreateCategorizedGrid(
		mMovie,
		"GridFrame.Grid.Item",
		8,
		4,
		"GridFrame.Categories.Menu",
		"GridFrame.SearchSort.SortMenu",
		nil,
		nil,
		nil,
		Engine.__wf_atom_2a979d69()
	)
	v7:SetCallbacks("GridItemPressed", "GridItemFocused", "GridItemUnfocused")
	v7.mScrollAlwaysVisible = true
	v7.mLastSelectedId = nil
	v7.mUseCornerForSelected = true
	v7.ElementDimBuffer = 24
	v7.ElementWidth = itemBrowsingElementWidth
	v7.ElementHeight = itemBrowsingElementHeight
	v7.Width = 1304
	v7.Height = 700
	module6.InitializeGridItem(mMovie, v7)
	v7:AttachScrollBar("GridFrame.ScrollBar", -22)
	v7.mScrollBarHorizontalOffset = nil
	v7:EnableSmoothScroll()
	v7.mSortMenuHorizontalOffset = nil
	v7.mSortMenuVerticalOffset = nil
	v7.mSortMenu.mDirection = 1
	v7.mSortMenu:SetWidth(200)
	v7.mSelectedScale = 100
	v7.RectangleVisibleRangeMaterial = rectangleVisibleRangeMat
	v7.VisibleRangeMaterial = visibleRangeMat
	v7.TextVisibleRangeMaterial = textVisibleRangeMat
	v7.FlareVisibleRangeMaterial = flareVisibleRangeMat
	v7.mMuteGridOpenSound = true
	v7.mCategoryMenu.mAlign = module2.LEFT_ALIGNED
	v7.mCategoryMenu.mHideEmptyCategories = true

	function v7.mClipCreatedCallback(p, _)
		module6.OnGridItemCreated(mMovie, v7, p)
	end

	function v7.mOnFocusedCallback(data)
		if data.mClipName == nil then
			return
		end

		if
			not __wf_atom_7e8ad928(data.StoreItem)
			and not __wf_atom_7e8ad928(data.StoreItem:GetItem())
			and data.StoreItem:GetItem():IsA(__wf_atom_9eddfa99)
		then
			if v == nil then
				v = module5.CreateStepSequencerLoader()
			end

			local noteType = data.NoteType == nil and 3 or data.NoteType
			local item = data.StoreItem:GetItem()
			module5.ResLoadNotePacks(v, {
				{ NoteType = noteType, NotePack = item }
			}, item)
		end

		local showToolTip

		if data.ShowToolTip == nil then
			showToolTip = false
		else
			showToolTip = data.ShowToolTip
		end

		local showInfoPopup = data.ShowInfoPopup == nil or data.ShowInfoPopup
		module6.OnGridItemFocusChanged(mMovie, v7, data, {
			IsSelected = data.Selected,
			IsFocused = true,
			ShowInfoPopup = showInfoPopup,
			ShowToolTip = showToolTip
		})
	end

	function v7.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		if v ~= nil and not __wf_atom_7e8ad928(v.StepSequencer) then
			v.StepSequencer:SetPaused(true)
		end

		module6.OnGridItemFocusChanged(mMovie, v7, p, { IsSelected = p.Selected, IsFocused = false })
	end

	function v7.mOnSelectedCallback(p)
		if not fn8(p) then
			return
		end

		if v19.Enabled then
			local v47 = fn7()
			local v48 = false

			if v36 == p and v37 ~= nil then
				v36 = nil
				v37 = nil
				fn13()
				v48 = true
			else
				v36 = p
				v37 = 0.5
			end

			if v48 or v47 ~= 1 or not v27 then
				if not v48 and v47 == 1 and v31 and not (__wf_atom_7e8ad928(v32) or __wf_atom_7e8ad928(_T[v32])) then
					_T[v32](p.StoreItem)
				end
			else
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if
					__wf_atom_7e8ad928(__wf_atom_18a5d83b)
					or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01()))
				then
					return
				end

				local storeItem = p.StoreItem

				if __wf_atom_7e8ad928(storeItem) or __wf_atom_7e8ad928(storeItem:__wf_atom_47a670f8()) then
					return
				end

				local __wf_atom_47a670f8 = storeItem:__wf_atom_47a670f8()

				if v29.Deco ~= __wf_atom_47a670f8 then
					if not __wf_atom_7e8ad928(v28) then
						gRegion:__wf_atom_dd1e4d10(v28)
					end

					v29.Deco = __wf_atom_47a670f8
					v29.Loader = UISys.__wf_atom_c0dbe47c({ __wf_atom_47a670f8:__wf_atom_5b41f63b() })
					v29.IsLoading = true
					v42:SetActive(true)
				end
			end

			v10[1].mVisible = v19.VariableLower and v47 >= 1 and true or not v19.VariableLower and v17 <= v47
			fn6()
		end

		v7.mElementDrawCallback(p)

		if browse == v38.SELECT and not v19.Enabled and fn7() == v17 then
			fn13()
		end
	end

	function v7.mElementDrawCallback(data)
		local mClipName = data.mClipName

		if data.Hide then
			mMovie:__wf_atom_2dedec1a(mClipName, 13, false)
			return
		end

		mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		local focusedElement = v7:GetFocusedElement()
		local isFocused = focusedElement ~= nil and focusedElement.Id == data.Id
		local v48 = {
			CustomTags = data.CustomTags,
			Locked = data.Locked,
			LockedMsg = data.LockedTag,
			HideCountThreshold = hideCountThreshold,
			IsFillter = data.Filler,
			IsFocused = isFocused,
			IsSelected = data.Selected,
			HidePrice = data.HidePrice
		}

		if data.SellInfo ~= nil then
			v48.SellInfo = data.SellInfo
		end

		if data.SpecialPrice ~= nil then
			v48.SpecialPriceInfo = {
				LabelPrefix = data.PriceLabelPrefix,
				LabelType = data.PriceLabelType,
				Price = data.SpecialPrice
			}
		end

		if v26 and data.Count ~= nil and data.Count > 0 then
			v48.HidePrice = true
		end

		module6.DrawGridItem(mMovie, v7, data, v48)
	end

	function v7.AdditionalFilterFunction(p)
		if #v40.mLabel == 0 or #p.mLowerItemName == 0 then
			return false
		end

		local v47 = string.find(p.mLowerItemName, __wf_atom_d99ae0ec(v40.mLabel), 1, true) ~= nil
		local v48 = string.find(p.mLowerItemDescription, __wf_atom_d99ae0ec(v40.mLabel), 1, true) ~= nil
		return not (v47 or v48)
	end

	v7.mSortBy = nil
	v7.mFilterBy = nil
	v7:SetCategory(0)
	v7:SetSortBy("RANK")
end

function Update()
	if not v5 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	local mMovie2 = mMovie
	local v47

	if topMenuOpen or _T.TopMenuOpen ~= true then
		v47 = not (_T.DecoTemplatePreviewOpen or _T.ProfileMenuOpen)
	else
		v47 = false
	end

	mMovie2:SetVisible(v47)
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v42) then
		v42:Update()
	end

	if v37 ~= nil then
		v37 -= __wf_atom_fa1258d0()

		if v37 <= 0 then
			v36 = nil
			v37 = nil
		end
	end

	if module5.UpdateStepSequencer(v) == true and not __wf_atom_7e8ad928(v.StepSequencer) then
		local focusedElement = v7:GetFocusedElement()

		if not __wf_atom_7e8ad928(focusedElement) and focusedElement.NoteType ~= nil then
			for i = 0, 3 - 1 do
				v.StepSequencer:__wf_atom_86df3407(i, focusedElement.NoteType ~= 3 and focusedElement.NoteType ~= i)
			end

			if focusedElement.NoteType ~= 3 then
				local __wf_atom_41e7eab5 = v.StepSequencer:__wf_atom_41e7eab5()
				local v48 = math.floor(__wf_atom_41e7eab5 / 4)

				for i = 0, __wf_atom_41e7eab5 - 1 do
					if not (v.StepSequencer:__wf_atom_795ce616(i, focusedElement.NoteType) > 0) then
						continue
					end

					local v49 = math.floor(i / v48)

					if v49 > 0 then
						v.StepSequencer:__wf_atom_7e8611b5(v.StepSequencer:__wf_atom_e5f28db1(v49 * v48))
					end

					break
				end
			end
		end

		v.StepSequencer:SetPaused(not __wf_atom_7e8ad928(v41))
	end

	if v29.IsLoading and not __wf_atom_7e8ad928(v29.Loader) and v29.Loader:__wf_atom_86399a47() then
		v29.IsLoading = false
		v42:SetActive(false)
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local __wf_atom_dd7246c7 = __wf_atom_eab484a7:__wf_atom_dd7246c7()
			local __wf_atom_a06d543c = __wf_atom_dd7246c7:__wf_atom_a06d543c()
			local __wf_atom_acb19668 = __wf_atom_dd7246c7:__wf_atom_acb19668()
			local v48 = __wf_atom_dd7246c7:GetPosition() + __wf_atom_a06d543c
			local v49 = __wf_atom_fa8d0177(v48, __wf_atom_dd7246c7:GetPosition(), __wf_atom_acb19668)
			local v50 = gRegion:IsMaster() and 3 or 4
			v28 = gRegion:CreateEntity(Type(__wf_atom_7e616794), __wf_atom_28d5d4aa, v49, nil, nil, v50)

			if not __wf_atom_7e8ad928(v28) then
				local entity = gRegion:CreateEntity(
					Type(v29.Deco),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					nil,
					v28,
					v50
				)

				if __wf_atom_7e8ad928(entity) then
					gRegion:__wf_atom_dd1e4d10(v28)
				else
					entity:__wf_atom_c529459a(1, 0, false, nil)
					entity:SetPosition(v48)
					local v51 = __wf_atom_edfe0d73(__wf_atom_a06d543c, __wf_atom_acb19668)
					entity:__wf_atom_e424c72a(true)
					local v52, v53 = fn12(entity, true)

					if v52 == v53 then
						v52, v53 = fn12(entity, true, true)
					end

					local midpoint = (v52 + v53) / 2
					local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
					local v55 = v53 - v52
					local v56 = math.max(v55.x, v55.y, v55.z, 0.001)
					local __wf_atom_c082fc3d = entity:__wf_atom_c082fc3d()
					local v57 = 0.8 * (__wf_atom_c082fc3d / v56)
					local v58 = (__wf_atom_28d5d4aa - midpoint) * (v57 / __wf_atom_c082fc3d)
					entity:SetMeshScale(v57)
					entity:SetPosition(v48 + v58 - v51 / 2)
					local __wf_atom_311ccfda = entity:__wf_atom_311ccfda()
					entity:SetVisibility(true, true)
					v28:SetPosition(v48 - v51 / 2)
					v28:Rotate(__wf_atom_311ccfda, true)
					v28:AttachEntity(entity, EMPTY_SYMBOL, v58, __wf_atom_80368bb1)
				end
			end
		end
	end

	if v27 and not __wf_atom_7e8ad928(v30.Controller) then
		v30.Controller:Update()
	end

	if v27 and v30.Active and not __wf_atom_7e8ad928(v28) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local delta, v48 = v30.Controller:GetDelta()

			if delta ~= 0 or v48 ~= 0 then
				local __wf_atom_dd7246c7 = __wf_atom_eab484a7:__wf_atom_dd7246c7()
				local __wf_atom_acb19668 = __wf_atom_dd7246c7:__wf_atom_acb19668()
				local __wf_atom_a06d543c = __wf_atom_dd7246c7:__wf_atom_a06d543c()
				local v49 = __wf_atom_edfe0d73(__wf_atom_a06d543c, __wf_atom_acb19668)
				local v50 = __wf_atom_46f1c89b(__wf_atom_acb19668, -delta)
				local v51 = __wf_atom_46f1c89b(v49, v48)
				local v52 = __wf_atom_d919c2d7(v50, v51)
				v28:Rotate(v52, false)
			end
		end
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v7.mScrollBar) then
		v7.mScrollBar:Update(__wf_atom_084b3e93())
	end
end

local function fn15()
	if v11 == nil then
		v4:AddTimer(0.1, fn15)
	end

	if v17 == 0 then
		browse = v38.BROWSE
	else
		browse = v38.SELECT
	end

	local v47 = nil

	if __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(_T[v12]) then
		v7.mFilterBy = 0
	else
		local v48 = _T[v12]()
		v47 = 0

		for _, v49 in ipairs(v48) do
			v7:AddCategory(v49)
		end
	end

	local sortId

	if __wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(_T[v13]) then
		v7:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false),
			Attribute = "Name"
		})
		sortId = "Name"
	else
		local v48
		v48, sortId = _T[v13]()

		for i = 1, #v48 do
			if __wf_atom_7e8ad928(sortId) then
				sortId = v48[i].SortId
			end

			v7:AddSortBy(v48[i])
		end
	end

	if not (__wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(_T[v11])) then
		local v48, v49 = _T[v11]()

		if #v48 == 0 and v25 ~= nil then
			module2.ShowMessage(v25)
		end

		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
		local inventory = gGameData:GetInventory()
		v7.PurchasedItems = module4.GetPurchasedItems(__wf_atom_964056fd, inventory)

		for i = 1, #v48 do
			__wf_atom_83c14687(0)
			v48[i].Id = i

			if v48[i].Card == nil then
				if v49 or v48[i].StoreItem == nil and v48[i].Type == nil then
					v7:AddElement(v48[i], true)
				else
					local v50

					if v48[i].StoreItem == nil then
						v50 = module4.GetItemTypeWithStoreInfo(mMovie, v48[i].Type, __wf_atom_964056fd, {
							GetVisibilityMaterial = true,
							GameData = gameData,
							AppendInfo = v48[i],
							OverrideExisting = false
						})
					else
						v50 = module4.GetStoreItemInfo(mMovie, v48[i].StoreItem, {
							GetVisibilityMaterial = true,
							GameData = gameData,
							AppendInfo = v48[i],
							OverrideExisting = false,
							ItemInfo = v48[i].ItemInfo
						}, __wf_atom_964056fd, nil, true)
					end

					local v51 = v50 == nil and {} or v50
					v51.StoreItem = v48[i].StoreItem
					v51.Id = v48[i].Id
					v51.Count = module2.Ternary(v48[i].HideOwnedTag, nil, v48[i].Count)

					if v51.OverrideToolTip ~= nil then
						v51.ToolTip = v51.OverrideToolTip
					end

					v7:AddElement(v51, true)
				end
			else
				module3.AddToCollectionGrid(v7, i, v48[i])
			end
		end
	end

	if v7.mSortBy == nil then
		if v47 ~= nil then
			v7:SetCategory(v47)
		end

		if sortId ~= nil then
			v7:SetSortBy(sortId)
		end
	end

	v10 = {}

	if not (__wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(_T[v24])) then
		local v48 = _T[v24]()
		table.insert(v10, v48)
	end

	table.insert(v10, {
		mVisible = false,
		mLabel = mLabel2,
		mCallback = function()
			mMovie:Execute("FinishSelection", "")
		end,
		mCallout = "MENU_GENERIC1"
	})

	if __wf_atom_72884638("LotusProfileTypes.DecoGroupingEnabled") then
		table.insert(v10, {
			mVisible = true,
			mLabel = Localize("/Lotus/Language/Dojo/DecoTemplateShowMenu", nil),
			mCallback = function()
				mMovie:Execute("ShowGroupedDecos", "")
			end,
			mCallout = "MENU_GENERIC1"
		})
	end

	table.insert(v10, {
		mVisible = true,
		mLabel = mLabel3,
		mCallback = function()
			mMovie:Execute("ConfirmCancel", "")
		end,
		mCallout = "MENU_CANCEL"
	})
	v7:RunForAllElements(function(state)
		if state.Name then
			state.mLowerItemName = __wf_atom_d99ae0ec(state.Name)
		elseif state.mName then
			state.mLowerItemName = __wf_atom_d99ae0ec(state.mName)
		else
			state.mLowerItemName = ""
		end

		if state.Description then
			state.mLowerItemDescription = __wf_atom_d99ae0ec(state.Description)
		elseif state.Card and state.Card.mDesc then
			state.mLowerItemDescription = __wf_atom_d99ae0ec(state.Card.mDesc)
		else
			state.mLowerItemDescription = ""
		end
	end)
	mMovie:__wf_atom_2dedec1a("GridFrame", 13, true)
	fn(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true)
	v7:Redraw(function()
		flag = false
		fn6()
	end)
end

function Initialize()
	topMenuOpen = _T.TopMenuOpen
	module.RegisterHideHud(true)
	v43 = not _T.UIInputEnabled

	if v43 then
		_T.EnableUIInput()
	end

	v6 = gGameRules:__wf_atom_b450ace7()

	if not v6 then
		gGameRules:__wf_atom_411c9025(true)
	end

	local module9 = require("Lotus.Interface.Components.ThemedSpinner")
	v42 = module9.Create(mMovie, "Spinner")

	if __wf_atom_7e8ad928(__wf_atom_392793db) and not _T.BackgroundVisible and (v43 or topMenuOpen) then
		if not __wf_atom_7e8ad928(_T.ShowBackground) then
			v44 = true
			_T.ShowBackground(0.25, nil, false)

			if topMenuOpen then
				local mainMenuSuitAvatar = module.GetMainMenuSuitAvatar()

				if not __wf_atom_7e8ad928(mainMenuSuitAvatar) and mainMenuSuitAvatar:__wf_atom_f63d17c0() then
					mainMenuSuitAvatar:__wf_atom_e424c72a(false)
				end
			end
		end
	else
		mMovie:__wf_atom_0cf0fdbe(1)
		mMovie:__wf_atom_7df746cd(module7.GetColor(2, true))
	end

	local module10 = require("Lotus.Interface.Libs.TimerMgr")
	v4 = module10.CreateTimerMgr()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_2dedec1a("GridFrame", 13, false)

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		gameData = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	v3 = module8.Create(mMovie)
	v3:Register(mMovie, "GridFrame.Categories", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "GridFrame.Grid", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "GridFrame.SearchSort", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "GridFrame.ScrollBar", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_RIGHT })
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
	local module11 = require("Lotus.Interface.Components.ThemedInputField")
	v40 = module11.Create(mMovie, "GridFrame.SearchSort.SearchBox", nil, nil, "<MENU_LTHUMB>")
	v40:SetType(v40.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
	v40.mMinSize = 200
	v40.mMaxSize = 200
	v40.mTextBuffer = 4
	v40.mAltButtonIcon = _G.UITexture_Search
	v40.mAltButtonVisible = true
	v40.mUnfocusedUnderlineColorOverride = nil
	v40.BaseInputFieldTextChanged = v40.InputFieldTextChanged

	function v40:InputFieldTextChanged(p)
		local mLabel = self.mLabel
		self:BaseInputFieldTextChanged(p)
		local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

		if self.mAltButtonicon ~= uiTexture_Search then
			self.mAltButtonicon = uiTexture_Search
			self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
		end

		if mLabel ~= self.mLabel and v7 ~= nil then
			v7:Redraw(flag and function()
				flag = false
				fn6()
			end or nil, true, true)
			_T.CurrentSearchTerm = p.mSearchTerm
		end
	end

	v40.BaseOnGamepadTransition = v40.OnGamepadTransition

	function v40:OnGamepadTransition()
		self:BaseOnGamepadTransition()
		local mAltButtonVisible = not Engine.IsPlayingWithController()
		self.mAltButtonVisible = mAltButtonVisible
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
	end

	v40.BaseSetClearHintVisible = v40.SetClearHintVisible

	function v40.SetClearHintVisible(object, p)
		object:BaseSetClearHintVisible(p)
		mMovie:__wf_atom_2dedec1a("InventorySelector.Stats", 13, not p)
	end

	v40:SetHint("/Lotus/Language/Menu/SearchPrompt")
	v40:Redraw()
	local module12 = require("Lotus.Interface.Components.RotationControl")
	v30.Controller = module12.Create(mMovie)
	v30.Controller.mUseControllerDeltaIfSet = true
	fn14()
	v4:AddTimer(0.1, fn15)

	if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "false")
		_T.ForceHideLobbyStatusMessage = true
	end

	module2.PlaySound(_G.UISound_ButtonSelect)
	module2.PlaySound(_G.UISound_WindowOpen)
	v5 = true
end

function SetTitle(p, p2)
	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(p, p2)
	end
end

function SetElementsFunction(p)
	v11 = p
end

function SetCategoriesFunction(p)
	v12 = p
end

function SetSortByFunction(p)
	v13 = p
end

function SetConfirmTextFunction(p)
	v14 = p
end

function SetCustomButtonFunction(p)
	v24 = p
end

function SetCallBack(p)
	v15 = p
end

local function fn16(p)
	v17 = tonumber(p)

	if not __wf_atom_7e8ad928(v7) then
		v7.mSelectElementsOnFocus = v17 == 1
	end
end

function SetRequiredSelections(p)
	fn16(p)
end

function SetVariableSelection(p, p2)
	v19.Enabled = true
	v19.VariableLower = p2 == nil or p2 == "true"
	fn16(p)
end

function SetValidationFunction(p)
	v22 = p
end

function SetRightClickFunction(p)
	v23 = p
end

function SetExitCallout(p)
	mLabel2 = p
end

function SetBuyCallout(_) end

function SetCancelCallout(p)
	mLabel3 = p
end

function SetCancelConfirmText(p)
	v9 = p
end

function SetConfirmPopupText(p)
	if p == "" then
		p = nil
	end

	v20 = p
end

function SetRequiresConfirmation(p)
	v18 = p == "true"
end

function SetNoElementsMessage(p)
	v25 = p
end

function SetHideCountThreshold(p)
	hideCountThreshold = tonumber(p)
end

function SetHidePriceIfOwned(p)
	v26 = p == "true"
end

function SetShowGridLabels(p)
	local mShowLabels = p == "true"

	if not __wf_atom_7e8ad928(v7) then
		v7.mShowLabels = mShowLabels
	end
end

function SetShowGridModLabels(p)
	local mShowModLabels = p == "true"

	if not __wf_atom_7e8ad928(v7) then
		v7.mShowModLabels = mShowModLabels
	end
end

function SetGridCanPreview(p)
	local canPreviewElements = p == "true"

	if not __wf_atom_7e8ad928(v7) then
		v7.CanPreviewElements = canPreviewElements
	end
end

function SetDecoPreviewMode(p)
	v27 = p == "true"
	local v47 = v27 and { Center = 0, Size = 0.9, FadeSize = 0.3 } or nil
	_T.ShowBackground(0.15, nil, nil, v47)
	fn2()
end

function SetGenericPreviewMode(p)
	v31 = p == "true"
	local v47 = v31 and { Center = 0, Size = 0.9, FadeSize = 0.3 } or nil
	_T.ShowBackground(0.15, nil, nil, v47)
	fn2()
end

function SetOnSelectedCallback(p)
	v32 = p
end

function RedrawElement(p)
	v7.mElementDrawCallback(_T[p])
end

function Close()
	fn4()
end

function ExitScreen()
	fn5()
end

function OnConfirmCancel(p)
	if tonumber(p) == 4 then
		fn5()
	end
end

function ConfirmCancel()
	if v9 == "" then
		fn5()
	else
		module2.ShowYesOrNoMessage(v9, "OnConfirmCancel")
	end
end

function FinishSelection()
	fn13()
end

function onKeyUp_MENU_CANCEL()
	if flag then
		return
	end

	if __wf_atom_7e8ad928(v7) or not v7:onKeyUp_MENU_CANCEL() then
		mMovie:Execute("ConfirmCancel", "")
	end

	return true
end

fn2 = function(p)
	local screenDimensions, _ = module2.GetScreenDimensions(mMovie)
	local v47 = v27 or v31

	if v47 then
		screenDimensions /= 2
	end

	local width = screenDimensions - 180

	if width ~= v7.Width then
		v7.Width = width
		v7.ElementDimBuffer = module2.Ternary(v47, 12, 24)
		module6.InitializeGridItem(mMovie, v7)
		module6.FitGridToWidth(v7)
		v7.mVisibleElements = v7.mColumns * v7.mRows

		if not p then
			v7:Redraw(nil, nil, true)
		end
	end

	if v47 then
		v7.mSortMenu:SetWidth(150)
		v40.mMinSize = 190
		v40.mMaxSize = 190
		v40:Redraw()
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("GridFrame.Grid", 0)
		mMovie:__wf_atom_e57658c2(
			"GridFrame.SearchSort",
			0,
			__wf_atom_5e6e15c8 + width - v7.mSortMenu.mWidth - v40.mWidth + 20
		)
		mMovie:__wf_atom_e57658c2("GridFrame.SearchSort.SearchBox", 0, v7.mSortMenu.mWidth + 11)
		mMovie:__wf_atom_e57658c2("GridFrame.ScrollBar", 0, __wf_atom_5e6e15c8 + width + 28)
	end

	v8.Materials = {
		visibleRangeMat,
		rectangleVisibleRangeMat,
		textVisibleRangeMat,
		flareVisibleRangeMat,
		_G.UIMaterial_PigmentVisibilityRange
	}

	for _, v49 in pairs(_G.UIMaterial_CosmeticEnhancersStore) do
		table.insert(v8.Materials, v49)
	end

	for _, v49 in pairs(_G.UIMaterial_FocusLensStore) do
		table.insert(v8.Materials, v49)
	end

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v49 in pairs(uiMaterial_Mod) do
			table.insert(v8.Materials, v49)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v49 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v8.Materials, v49)
		end
	end

	local __wf_atom_d0fcaf32 = mMovie:__wf_atom_d0fcaf32()
	v8.Height = v7.mRows * v7.mRowSeparation - v7.ElementDimBuffer
	v8.YPos = mMovie:__wf_atom_5e6e15c8("GridFrame", 1) + mMovie:__wf_atom_5e6e15c8("GridFrame.Grid", 1) + v8.Height / 2
	local visibilityCenter = module2.GetVisibilityCenter(mMovie, v8.YPos - __wf_atom_d0fcaf32 / 2)
	local visibilitySize = module2.GetVisibilitySize(mMovie, v8.Height)
	local visibilityFadeSize = module2.GetVisibilityFadeSize(mMovie, 5)

	for _, material in pairs(v8.Materials) do
		material:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
		material:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
		material:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end
end

fn = function(p, p2, p3)
	if __wf_atom_7e8ad928(v7) then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(p, p2)
	end

	fn2(p3)
end

function onViewportSizeChanged(p, p2)
	fn(p, p2)
end

function GridItemFocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:FocusElementById((tonumber(p)))
	end
end

function GridItemUnfocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:UnfocusElementById((tonumber(p)))
	end
end

function GridItemPressed(p)
	if not (flag or __wf_atom_7e8ad928(v7)) then
		v7:SelectElementById(tonumber(p), true)
		module2.PlaySound(_G.UISound_ItemTipSection)
	end
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v7.mCategoryMenu) then
		v7.mCategoryMenu:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v7.mCategoryMenu) then
		v7.mCategoryMenu:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v7.mCategoryMenu)) then
		v7.mCategoryMenu:SelectElementById(tonumber(p), true)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v7.mSortMenu) then
		v7.mSortMenu:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v7.mSortMenu) then
		v7.mSortMenu:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (flag or __wf_atom_7e8ad928(v7.mSortMenu)) then
		v7.mSortMenu:SelectElementById(tonumber(p), true)
	end
end

function onKeyDown_MENU_CLICK()
	if
		flag
		or not v27
		or not (module2.GetScreenCursor(mMovie).x > mMovie:__wf_atom_97cd8326() / 2)
		or __wf_atom_7e8ad928(v28)
		or __wf_atom_7e8ad928(v30.Controller)
	then
		return
	end

	v30.Active = true
	v30.Controller:SetMouseDown(true)
	return true
end

function onKeyUp_MENU_CLICK()
	if v27 and v30.Active and not __wf_atom_7e8ad928(v30.Controller) then
		v30.Active = false
		v30.Controller:SetMouseDown(false)
		return true
	end
end

function onKeyDown_MENU_X(_, _)
	if flag or not v27 or __wf_atom_7e8ad928(v30.Controller) then
		return
	end

	local active = mMovie:__wf_atom_5e6e15c8("GridFrame.ScrollBar", 30) > 10

	if v45 ~= active then
		v45 = active
		v30.Active = active
		v30.Controller:SetMouseDown(active)
		mMovie:__wf_atom_40912f8e(active)
	end
end

function onKeyDown_MENU_RIGHT_X(_, p)
	if not __wf_atom_7e8ad928(v30.Controller) then
		v30.Controller:SetRightStickTensionX(flag and 0 or p / 2 or 0)
	end

	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	if not __wf_atom_7e8ad928(v30.Controller) then
		v30.Controller:SetRightStickTensionX(flag and 0 or p / 2 or 0)
	end

	return true
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	if not __wf_atom_7e8ad928(v30.Controller) then
		v30.Controller:SetRightStickTensionY(flag and 0 or -p / 2 or 0)
	end

	return true
end

function onKeyUp_MENU_RIGHT_Y(_, p)
	if not __wf_atom_7e8ad928(v30.Controller) then
		v30.Controller:SetRightStickTensionY(flag and 0 or -p / 2 or 0)
	end

	return true
end

function onKeyDown_MENU_LTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v7)) then
		v7:PreviousCategory()
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v7)) then
		v7:NextCategory()
	end

	return true
end

function onKeyDown_MENU_RTHUMB()
	fn9(v7:GetFocusedElement())
	return true
end

function onKeyDown_MENU_RIGHT_CLICK()
	fn9(v7:GetFocusedElement())
	return true
end

function ScrubStartDrag()
	if not __wf_atom_7e8ad928(v7.mScrollBar) then
		v7.mScrollBar:StartDrag()
	end
end

function ScrubStopDrag()
	if not __wf_atom_7e8ad928(v7.mScrollBar) then
		v7.mScrollBar:StopDrag()
	end
end

function ScrollBarClick()
	if not __wf_atom_7e8ad928(v7.mScrollBar) then
		v7.mScrollBar:ClickScrollBar()
	end
end

function DropDownArrowPressed()
	if not __wf_atom_7e8ad928(v7.mSortMenu) then
		v7.mSortMenu:ArrowPressed()
	end
end

function DropDownArrowFocused()
	if not __wf_atom_7e8ad928(v7.mSortMenu) then
		v7.mSortMenu:ArrowFocused()
	end
end

function DropDownArrowUnfocused()
	if not __wf_atom_7e8ad928(v7.mSortMenu) then
		v7.mSortMenu:ArrowUnfocused()
	end
end

function RollOver()
	module2.PlaySound(_G.UISound_Focus)
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	local mScrollBar

	if v7 and not __wf_atom_7e8ad928(v7.mScrollBar) then
		mScrollBar = v7.mScrollBar
	end

	if not (flag or __wf_atom_7e8ad928(mScrollBar)) then
		mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyUp_HIDE_PAUSE_MENU()
	return true
end

function IsInputBlocked()
	return flag
end

function SupportsThemes()
	return true
end

function HideScreenForPlatPurchase(p)
	if p == "true" then
		__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0)
		return
	end

	fn(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.15, 0)
end

function OnLobbyReady(p)
	if not p then
		print("Session hosting failed")
	end
end

function SetUseCornerForSelected(p)
	if not __wf_atom_7e8ad928(v7) then
		v7.mUseCornerForSelected = p == "true"
	end
end