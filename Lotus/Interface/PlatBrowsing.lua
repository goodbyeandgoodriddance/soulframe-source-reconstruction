local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.CardUtilitiesRedux")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.SequencerUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("Lotus.Interface.UIStyleUtilities")
local module8 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = false
local v3 = nil
local v4 = nil
local v5 = false
local flag = true
local v6 = nil
local v7 = { Materials = {}, Size = 0, YPos = 0 }
local v8 = "/Lotus/Language/Menu/MissionStats_Done"
local v9 = "/Lotus/Language/Menu/Global_BuyItem"
local mLabel = "/Menu/Confirm_Item_Cancel"
local v10 = ""
local v11 = {}
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = false
local v18 = 0
local v19 = true
local flag2 = false
local v20 = nil
local v21 = nil
local v22 = nil
local topMenuOpen = false
local v23 = nil
local v24 = nil
local hideCountThreshold = 0
local v25 = false
local v26 = { BROWSE = 1, SELECT = 2 }
local browse = nil
local gameData = nil
local v27 = nil
local v28 = nil
local flag3 = false
local v29 = false
local v30 = false
local fn

function GetCards()
	return nil
end

function GetSelectedCards()
	return {}
end

function GetSelectedElement()
	return nil
end

local function fn2()
	if flag3 then
		return
	end

	flag3 = true

	if v30 and not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	module.RegisterHideHud(false)

	if not __wf_atom_7e8ad928(v28) then
		if flag3 and v30 then
			v28:Execute("ForceHidingBackground", "false")
		end

		v28:Close()
	end

	fn2()

	if v ~= nil then
		if not __wf_atom_7e8ad928(v.StepSequencer) then
			v.StepSequencer:Destroy()
		end

		v = nil
	end

	if not (__wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(_T[v16]) or v17) then
		_T[v16](v21, v6:GetSortById())
	end

	module6.ClearGridModMaterials()

	if v29 then
		_T.DisableUIInput()
	end
end

function IsFusionMode()
	return false
end

local function fn3()
	if _T.ForegroundMovie and _T.CanShowPlayTypeDropDown then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "true")
	end

	if _T.ForegroundMovie then
		_T.ForceHideLobbyStatusMessage = false
	end

	fn2()
	flag = true

	if not (__wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(_T[v16])) then
		_T[v16](v21, v6:GetSortById())
		v17 = true
	end

	mMovie:Close()
end

function TransitionOut()
	fn3()
end

local function fn4()
	module2.PlaySound(_G.UISound_WindowClose)
	local v31

	if _T.BackgroundMovie == nil then
		v31 = false
	else
		v31 = _T.IsInScreenStack("ItemBrowsing")
	end

	if v31 then
		_T.GoToPreviousScreen()
	else
		fn3()
	end
end

local function fn5()
	local v31 = {}

	for i = 1, #v11 do
		local v32 = v11[i]

		if not v32.mVisible then
			continue
		end

		local v36 = { Label = v32.mLabel, CallBack = v32.mCallback, CallOut = v32.mCallout }

		if v32.mPosition == nil then
			table.insert(v31, v36)
		else
			table.insert(v31, v32.mPosition, v36)
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v31, getfenv(1))
	end
end

local function fn6()
	local count = 0
	__wf_atom_83c14687(0)
	v6:RunForAllElements(function(p)
		if p.Selected then
			count += 1
		end
	end)
	return count
end

local function fn7(state, p)
	if state.mClipName == nil then
		return false
	end

	if v22 ~= nil and _T[v22] ~= nil then
		local v31, v32 = _T[v22]({ state })

		if not v31 then
			if v32 ~= nil and p == nil then
				module2.ShowMessage(v32)
			end

			return false
		end
	end

	if (state.Selected or not (fn6() < v18)) and not state.Selected and v18 ~= 1 then
		return false
	end

	if v18 == 1 and not state.Selected then
		v6:RunForAllElements(function(state2)
			if state2.Selected then
				state2.Selected = false

				if state2.mClipName ~= nil then
					v6.mElementDrawCallback(state2)
				end
			end
		end)
	end

	state.Selected = not state.Selected or v18 == 1

	if state.Selected then
		v6.mLastSelectedId = state.Id
	end

	return true
end

function ToggleSelection()
	fn7(v6:GetFocusedElement())
end

local v31 = {}

local function fn8()
	local function fn9()
		v21 = v31
		fn3()
	end

	local function fn10(p, p2)
		if p == nil then
			return
		end

		if not p then
			module2.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
			return
		end

		if v31[1] ~= nil then
			v31[1].Count = p2.mQuantity
		end

		fn9()
	end

	if v18 == 1 and v31[1] ~= nil and (v31[1].RegularPrice ~= nil or v31[1].PremiumPrice ~= nil) then
		local saleInfo = module.GetSaleInfo(v31[1].StoreItem)
		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = v31[1].StoreItem, Sale = saleInfo },
			CALLBACK = fn10
		}
		v28 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
		v28:Execute("SetExitCallback", "OnCloseDetailedPurchase")

		if v ~= nil and not __wf_atom_7e8ad928(v.StepSequencer) then
			v2 = v.StepSequencer:__wf_atom_160c488b()

			if not v2 then
				v.StepSequencer:SetPaused(true)
			end
		end
	else
		fn9()
	end
end

function OnCloseDetailedPurchase()
	if v ~= nil and not (__wf_atom_7e8ad928(v.StepSequencer) or v2) then
		v.StepSequencer:SetPaused(false)
	end
end

function OnConfirmSelection(p)
	if tonumber(p) == 4 then
		fn8()
	elseif not flag2 and v18 > 1 and v6.mLastSelectedId ~= nil then
		local elementById = v6:GetElementById(v6.mLastSelectedId)

		if not __wf_atom_7e8ad928(elementById) then
			fn7(elementById)
			v6.mElementDrawCallback(elementById)
			v6.mLastSelectedId = nil
		end
	end
end

local function fn9()
	if not v19 and v18 == 1 then
		local mSelectedElement = v6.mSelectedElement

		if mSelectedElement == nil then
			mSelectedElement = v6:GetFocusedElement()
		end

		if mSelectedElement ~= nil and not mSelectedElement.Selected then
			fn7(mSelectedElement, true)
		end
	end

	if flag2 or not (fn6() < v18) then
		v31 = {}
		v6:RunForAllElements(function(p)
			if p.Selected then
				table.insert(v31, p)
			end
		end)

		if v22 ~= nil and _T[v22] ~= nil then
			local v32, v36 = _T[v22](v31)

			if not v32 then
				if v36 ~= nil then
					module2.ShowMessage(v36)
				end

				return
			end
		end

		local confirmPopupText = nil

		for _, v32 in ipairs(v31) do
			if v32.ConfirmPopupText ~= nil then
				confirmPopupText = v32.ConfirmPopupText
			end
		end

		if confirmPopupText == nil then
			confirmPopupText = v20
		end

		if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(_T[v15])) then
			confirmPopupText = _T[v15](v31)
		end

		if confirmPopupText == nil then
			fn8()
		else
			module2.ShowConfirmMessage(confirmPopupText, "OnConfirmSelection")
		end
	else
		local v32 = v18 - fn6()
		local v36 = mMovie:PushChildMovie(_G.UIMovie_ConfirmMovie)
		v36:Execute(
			"SetText",
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NeedToSelectMore", false, {
				HOW_MANY = v32
			})
		)
		v36:Execute("SetNumOptions", 1)
	end
end

local function fn10()
	v29 = not _T.UIInputEnabled

	if v29 then
		_T.EnableUIInput()
	end

	local module9 = require("Lotus.Interface.Components.CategorizedGrid")
	v6 = module9.CreateCategorizedGrid(mMovie, "GridFrame.Grid.Item", 4, 4, "GridFrame.Category", "GridFrame.SortMenu")
	v6:SetCallbacks("GridItemPressed", "GridItemFocused", "GridItemUnfocused")
	v6.mScrollAlwaysVisible = true
	v6.mLastSelectedId = nil
	v6.mUseCornerForSelected = true
	v6.ElementDimBuffer = 24
	v6.ElementWidth = 284
	v6.ElementHeight = 284
	v6.Width = 1304
	v6.Height = 700
	module6.InitializeGridItem(mMovie, v6)
	v6:AttachScrollBar("GridFrame.ScrollBar", -22)
	v6.mScrollBarHorizontalOffset = nil
	v6:EnableSmoothScroll()
	v6.mSortMenuHorizontalOffset = nil
	v6.mSortMenuVerticalOffset = nil
	v6.mSortMenu.mDirection = 1
	v6.mSortMenu:SetWidth(200)
	v6.mSelectedScale = 200
	v6.RectangleVisibleRangeMaterial = rectangleVisibleRangeMat
	v6.VisibleRangeMaterial = visibleRangeMat
	v6.TextVisibleRangeMaterial = textVisibleRangeMat
	v6.FlareVisibleRangeMaterial = flareVisibleRangeMat
	v6.mMuteGridOpenSound = true
	v6.mCategoryMenu.mAlign = module2.LEFT_ALIGNED
	v6.mCategoryMenu.mHideEmptyCategories = true

	function v6.mClipCreatedCallback(p, _)
		module6.OnGridItemCreated(mMovie, v6, p)
	end

	function v6.mOnFocusedCallback(data)
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

		module6.OnGridItemFocusChanged(mMovie, v6, data, { IsFocused = true, ShowInfoPopup = true })
	end

	function v6.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		if v ~= nil and not __wf_atom_7e8ad928(v.StepSequencer) then
			v.StepSequencer:SetPaused(true)
		end

		module6.OnGridItemFocusChanged(mMovie, v6, p, { IsFocused = false })
	end

	function v6.mOnSelectedCallback(p)
		if not fn7(p) then
			return
		end

		if flag2 then
			v11[1].mVisible = fn6() >= 1
			fn5()
		end

		v6.mElementDrawCallback(p)

		if browse == v26.SELECT and fn6() == v18 then
			fn9()
		end
	end

	function v6.mElementDrawCallback(data)
		local mClipName = data.mClipName

		if data.Hide then
			mMovie:__wf_atom_2dedec1a(mClipName, 13, false)
			return
		end

		mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		local focusedElement = v6:GetFocusedElement()
		local isFocused = focusedElement ~= nil and focusedElement.Id == data.Id
		local v32 = {
			Locked = data.Locked,
			LockedMsg = data.LockedTag,
			HideCountThreshold = hideCountThreshold,
			IsFillter = data.Filler,
			IsFocused = isFocused,
			IsSelected = data.Selected
		}

		if data.SellInfo ~= nil then
			v32.SellInfo = data.SellInfo
		end

		if data.SpecialPrice ~= nil then
			v32.SpecialPriceInfo = { LabelType = data.PriceLabelType, Price = data.SpecialPrice }
		end

		if v25 and data.Count ~= nil and data.Count > 0 then
			v32.HidePrice = true
		end

		module6.DrawGridItem(mMovie, v6, data, v32)
	end

	function v6.AdditionalFilterFunction(p)
		if v27.mLowerSearchTerm == nil or v27.mLowerSearchTerm == "" then
			return false
		end

		local v32 = string.find(p.mLowerItemName, v27.mLowerSearchTerm, 1, true) ~= nil
		local v36 = string.find(p.mLowerItemDescription, v27.mLowerSearchTerm, 1, true) ~= nil
		return not (v32 or v36)
	end

	v6.mSortBy = nil
	v6.mFilterBy = nil
	v6:SetCategory(0)
	v6:SetSortBy("RANK")
end

function Update()
	if not v5 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:SetVisible(topMenuOpen or _T.TopMenuOpen ~= true)
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	v27:Update(__wf_atom_fa1258d0())

	if module5.UpdateStepSequencer(v) == true and not __wf_atom_7e8ad928(v.StepSequencer) then
		local focusedElement = v6:GetFocusedElement()

		if not __wf_atom_7e8ad928(focusedElement) and focusedElement.NoteType ~= nil then
			for i = 0, 3 - 1 do
				v.StepSequencer:__wf_atom_86df3407(i, focusedElement.NoteType ~= 3 and focusedElement.NoteType ~= i)
			end

			if focusedElement.NoteType ~= 3 then
				local __wf_atom_41e7eab5 = v.StepSequencer:__wf_atom_41e7eab5()
				local v32 = math.floor(__wf_atom_41e7eab5 / 4)

				for i = 0, __wf_atom_41e7eab5 - 1 do
					if not (v.StepSequencer:__wf_atom_795ce616(i, focusedElement.NoteType) > 0) then
						continue
					end

					local v36 = math.floor(i / v32)

					if v36 > 0 then
						v.StepSequencer:__wf_atom_7e8611b5(v.StepSequencer:__wf_atom_e5f28db1(v36 * v32))
					end

					break
				end
			end
		end

		v.StepSequencer:SetPaused(not __wf_atom_7e8ad928(v28))
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v6.mScrollBar) then
		v6.mScrollBar:Update(__wf_atom_084b3e93())
	end
end

local function fn11()
	if v12 == nil then
		v4:AddTimer(0.1, fn11)
	end

	if v18 == 0 then
		browse = v26.BROWSE
	else
		browse = v26.SELECT
	end

	local v32 = nil

	if __wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(_T[v13]) then
		v6.mFilterBy = 0
	else
		local v36 = _T[v13]()
		v32 = 0

		for _, v37 in ipairs(v36) do
			v6:AddCategory(v37)
		end
	end

	local sortId

	if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(_T[v14]) then
		v6:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false),
			Attribute = "Name"
		})
		sortId = "Name"
	else
		local v36
		v36, sortId = _T[v14]()

		for i = 1, #v36 do
			if __wf_atom_7e8ad928(sortId) then
				sortId = v36[i].SortId
			end

			v6:AddSortBy(v36[i])
		end
	end

	if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(_T[v12])) then
		local v36 = _T[v12]()

		if #v36 == 0 and v24 ~= nil then
			module2.ShowMessage(v24)
		end

		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
		local inventory = gGameData:GetInventory()
		v6.PurchasedItems = module4.GetPurchasedItems(__wf_atom_964056fd, inventory)

		for i = 1, #v36 do
			__wf_atom_83c14687(0)
			v36[i].Id = i

			if v36[i].Card == nil then
				if v36[i].StoreItem == nil and v36[i].Type == nil then
					v6:AddElement(v36[i], true)
				else
					local v37

					if v36[i].StoreItem == nil then
						v37 = module4.GetItemTypeWithStoreInfo(mMovie, v36[i].Type, __wf_atom_964056fd, {
							GetVisibilityMaterial = true,
							GameData = gameData,
							AppendInfo = v36[i],
							OverrideExisting = false
						})
					else
						v37 = module4.GetStoreItemInfo(mMovie, v36[i].StoreItem, {
							GetVisibilityMaterial = true,
							GameData = gameData,
							AppendInfo = v36[i],
							OverrideExisting = false,
							ItemInfo = v36[i].ItemInfo
						}, __wf_atom_964056fd, nil, true)
					end

					local v38 = v37 == nil and {} or v37
					v38.StoreItem = v36[i].StoreItem
					v38.Id = v36[i].Id
					v38.Count = module2.Ternary(v36[i].HideOwnedTag, nil, v36[i].Count)
					v6:AddElement(v38, true)
				end
			else
				module3.AddToCollectionGrid(v6, i, v36[i])
			end
		end
	end

	if v6.mSortBy == nil then
		if v32 ~= nil then
			v6:SetCategory(v32)
		end

		if sortId ~= nil then
			v6:SetSortBy(sortId)
		end
	end

	v11 = {}
	table.insert(v11, {
		mVisible = false,
		mLabel = "/Lotus/Language/Menu/MissionStats_Done",
		mCallback = function()
			mMovie:Execute("FinishSelection", "")
		end,
		mCallout = "MENU_GENERIC1"
	})
	table.insert(v11, {
		mVisible = true,
		mLabel = mLabel,
		mCallback = function()
			mMovie:Execute("ConfirmCancel", "")
		end,
		mCallout = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(v23) or __wf_atom_7e8ad928(_T[v23])) then
		local v36 = _T[v23]()
		table.insert(v11, v36)
	end

	v6:RunForAllElements(function(state)
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
	v6:Redraw(function()
		flag = false
		fn5()
	end)
end

function Initialize()
	topMenuOpen = _T.TopMenuOpen
	module.RegisterHideHud(true)

	if __wf_atom_7e8ad928(__wf_atom_392793db) and not (_T.BackgroundVisible or _T.IsInScreenStack("LoadOut")) then
		if not __wf_atom_7e8ad928(_T.ShowBackground) then
			v30 = true
			_T.ShowBackground(0.25, nil, false)
		end
	else
		mMovie:__wf_atom_0cf0fdbe(1)
		mMovie:__wf_atom_7df746cd(module7.GetColor(2, true))
	end

	local module9 = require("Lotus.Interface.Libs.TimerMgr")
	v4 = module9.CreateTimerMgr()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_2dedec1a("GridFrame", 13, false)

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		gameData = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	v3 = module8.Create(mMovie)
	v3:Register(mMovie, "GridFrame.Category", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "GridFrame.Grid", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "GridFrame.SortMenu", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "GridFrame.SearchBox", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "GridFrame.ScrollBar", { v3.ANCHOR_V_CENTRE, v3.ANCHOR_H_RIGHT })
	local module10 = require("Lotus.Interface.Components.SearchBox")
	v27 = module10.Create(mMovie, "GridFrame.SearchBox")
	v27.mWidth = 200

	function v27.OnSearchChanged(_)
		v6:Redraw(nil, true, true)
	end

	v27:Initialize()
	fn10()
	v4:AddTimer(0.1, fn11)

	if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "false")
		_T.ForceHideLobbyStatusMessage = true
	end

	module2.PlaySound(_G.UISound_ButtonSelect)
	module2.PlaySound(_G.UISound_WindowOpen)
	v5 = true
end

function SetTitle(p)
	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(p)
	end
end

function SetElementsFunction(p)
	v12 = p
end

function SetCategoriesFunction(p)
	v13 = p
end

function SetSortByFunction(p)
	v14 = p
end

function SetConfirmTextFunction(p)
	v15 = p
end

function SetCustomButtonFunction(p)
	v23 = p
end

function SetCallBack(p)
	v16 = p
end

local function fn12(p)
	v18 = tonumber(p)

	if not __wf_atom_7e8ad928(v6) then
		v6.mSelectElementsOnFocus = v18 == 1
	end
end

function SetRequiredSelections(p)
	fn12(p)
end

function SetVariableSelection(p)
	flag2 = true
	fn12(p)
end

function SetValidationFunction(p)
	v22 = p
end

function SetExitCallout(p)
	v8 = p
end

function SetBuyCallout(p)
	v9 = p
end

function SetCancelCallout(p)
	mLabel = p
end

function SetCancelConfirmText(p)
	v10 = p
end

function SetConfirmPopupText(p)
	if p == "" then
		p = nil
	end

	v20 = p
end

function SetRequiresConfirmation(p)
	v19 = p == "true"
end

function SetNoElementsMessage(p)
	v24 = p
end

function SetHideCountThreshold(p)
	hideCountThreshold = tonumber(p)
end

function SetHidePriceIfOwned(p)
	v25 = p == "true"
end

function SetShowGridLabels(p)
	local mShowLabels = p == "true"

	if not __wf_atom_7e8ad928(v6) then
		v6.mShowLabels = mShowLabels
	end
end

function Close()
	fn3()
end

function ExitScreen()
	fn4()
end

function OnConfirmCancel(p)
	if tonumber(p) == 4 then
		fn4()
	end
end

function ConfirmCancel()
	if v10 ~= "" then
		module2.ShowYesOrNoMessage(v10, "OnConfirmCancel")
		return
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("HideScreenForPlatPurchase", "false")
	fn4()
end

function FinishSelection()
	fn9()
end

function onKeyUp_MENU_CANCEL()
	if flag then
		return
	end

	if __wf_atom_7e8ad928(v6) or not v6:onKeyUp_MENU_CANCEL() then
		mMovie:Execute("ConfirmCancel", "")
	end

	return true
end

fn = function(p, p2, p3)
	if __wf_atom_7e8ad928(v6) then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(p, p2)
	end

	local screenDimensions, _ = module2.GetScreenDimensions(mMovie)
	local width = screenDimensions - 180

	if width ~= v6.Width then
		v6.Width = width
		module6.InitializeGridItem(mMovie, v6)
		module6.FitGridToWidth(v6)
		v6.mVisibleElements = v6.mColumns * v6.mRows

		if not p3 then
			v6:Redraw(nil, nil, true)
		end
	end

	v7.Materials = {
		visibleRangeMat,
		rectangleVisibleRangeMat,
		textVisibleRangeMat,
		flareVisibleRangeMat,
		_G.UIMaterial_PigmentVisibilityRange
	}

	for _, v32 in pairs(_G.UIMaterial_CosmeticEnhancersStore) do
		table.insert(v7.Materials, v32)
	end

	for _, v32 in pairs(_G.UIMaterial_FocusLensStore) do
		table.insert(v7.Materials, v32)
	end

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v32 in pairs(uiMaterial_Mod) do
			table.insert(v7.Materials, v32)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v32 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v7.Materials, v32)
		end
	end

	local __wf_atom_d0fcaf32 = mMovie:__wf_atom_d0fcaf32()
	v7.Height = v6.mRows * v6.mRowSeparation - v6.ElementDimBuffer
	v7.YPos = mMovie:__wf_atom_5e6e15c8("GridFrame", 1) + mMovie:__wf_atom_5e6e15c8("GridFrame.Grid", 1) + v7.Height / 2
	local visibilityCenter = module2.GetVisibilityCenter(mMovie, v7.YPos - __wf_atom_d0fcaf32 / 2)
	local visibilitySize = module2.GetVisibilitySize(mMovie, v7.Height)
	local visibilityFadeSize = module2.GetVisibilityFadeSize(mMovie, 5)

	for _, material in pairs(v7.Materials) do
		material:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
		material:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
		material:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end
end

function onViewportSizeChanged(p, p2)
	fn(p, p2)
end

function GridItemFocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:FocusElementById((tonumber(p)))
	end
end

function GridItemUnfocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:UnfocusElementById((tonumber(p)))
	end
end

function GridItemPressed(p)
	if not (flag or __wf_atom_7e8ad928(v6)) then
		v6:SelectElementById(tonumber(p), true)
		module2.PlaySound(_G.UISound_ItemTipSection)
	end
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v6.mCategoryMenu) then
		v6.mCategoryMenu:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v6.mCategoryMenu) then
		v6.mCategoryMenu:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v6.mCategoryMenu)) then
		v6.mCategoryMenu:SelectElementById(tonumber(p), true)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (flag or __wf_atom_7e8ad928(v6.mSortMenu)) then
		v6.mSortMenu:SelectElementById(tonumber(p), true)
	end
end

function onKeyDown_MENU_LTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v6)) then
		v6:PreviousCategory()
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v6)) then
		v6:NextCategory()
	end

	return true
end

function ScrubStartDrag()
	if not __wf_atom_7e8ad928(v6.mScrollBar) then
		v6.mScrollBar:StartDrag()
	end
end

function ScrubStopDrag()
	if not __wf_atom_7e8ad928(v6.mScrollBar) then
		v6.mScrollBar:StopDrag()
	end
end

function ScrollBarClick()
	if not __wf_atom_7e8ad928(v6.mScrollBar) then
		v6.mScrollBar:ClickScrollBar()
	end
end

function DropDownArrowPressed()
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:ArrowPressed()
	end
end

function DropDownArrowFocused()
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:ArrowFocused()
	end
end

function DropDownArrowUnfocused()
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:ArrowUnfocused()
	end
end

function onKeyDown_MENU_GENERIC2()
	if not __wf_atom_7e8ad928(v6) then
		local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v6.mSortClipName, 13)

		if not __wf_atom_7e8ad928(v6.mSortMenu) and __wf_atom_a91463a8 and not v6.mSortMenu:IsVisible() then
			v6.mSortMenu:ArrowPressed(true)
		end
	end
end

function RollOver()
	module2.PlaySound(_G.UISound_Focus)
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	local mScrollBar

	if v6 and not __wf_atom_7e8ad928(v6.mScrollBar) then
		mScrollBar = v6.mScrollBar
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