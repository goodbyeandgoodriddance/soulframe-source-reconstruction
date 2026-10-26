local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.Components.ThemedCustomizationButton")
local v = { Min = 0.125, Max = 0.5 }
local flag = false
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = false
local v12 = nil
local v13 = { TrackAvatar = true, x = 0, y = 0 }
local v14 = { Loader = nil, IsLoading = nil, Tag = nil, Selection = nil }
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = WeakResource("/SF/Types/Game/UIStyle")
local v20 = WeakResource("/EE/Types/Engine/UISounds")
local v21 = WeakResource("/EE/Types/Engine/UIBackground")
local v22 = WeakResource("/Lotus/Interface/Graphics/CustomUI/Cursors/BaseMouse")
local v23 = WeakResource("/Lotus/Interface/Graphics/CustomUI/Cursors/BaseController")
local storeItem = Resource("/Lotus/StoreItems/Interface/Graphics/CustomUI/Cursors/MouseDefault")
local storeItem2 = Resource("/Lotus/StoreItems/Interface/Graphics/CustomUI/Cursors/ControllerDefault")
local v24 = WeakResource("/Lotus/Interface/Graphics/CustomUI/Backgrounds/SpringFestivalBackground")
local v25 = WeakResource("/Lotus/Upgrades/Skins/Sigils/LunarBackgroundSigil")
local v26 = {}
local v27 = nil
local v28 = nil
local v29 = false
local flag2 = false
local fn
local fn2

function IsOpenedFromPauseMenu()
	return true
end

function IsInputBlocked()
	return flag
end

local function fn3(item)
	if __wf_atom_7e8ad928(v7) then
		return false
	end

	local v30 = v7

	for _, v31 in pairs(v30) do
		if v31.IsExternalProduct or not v31:IsPackage() then
			continue
		end

		local __wf_atom_72915748 = v31:__wf_atom_72915748()

		for i = 1, #__wf_atom_72915748 do
			local v32 = Resource(__wf_atom_72915748[i].mTypeName)

			if v32 ~= nil and not __wf_atom_7e8ad928((v32:GetItem())) and v32:GetItem() == item then
				return true
			end
		end
	end

	return false
end

local function fn4(p, p2)
	local result = {}
	local inventory = gGameData:GetInventory()
	local v30 = __wf_atom_7e8ad928(inventory) and {} or inventory:__wf_atom_da43e3f3()
	local v31 = true

	if __wf_atom_7e8ad928(v6) then
		return result
	end

	local __wf_atom_caa82b8d = v6:__wf_atom_caa82b8d(p)

	for _, storeItem3 in pairs(__wf_atom_caa82b8d) do
		local owned = storeItem3:AlwaysAvailable() or p2

		if not owned then
			local item = storeItem3:GetItem()

			for _, v32 in pairs(v30) do
				if item ~= v32.mItemType then
					continue
				end

				owned = true
				break
			end
		end

		if Engine.__wf_atom_578fc9dd() then
			v31 = (not fn3(storeItem3:GetItem()) or owned) and true or false
		end

		if v31 then
			table.insert(result, {
				StoreItem = storeItem3,
				Owned = owned,
				Count = module.Ternary(owned, 1, nil),
				HideCountThreshold = 0
			})
		end
	end

	return result
end

local function fn5()
	return fn4(v19)
end

local function fn6()
	return fn4(v20)
end

local function fn7()
	return fn4(v21)
end

local function fn8()
	return fn4(v25, true)
end

local function fn9(p, storeItem3)
	local v30 = fn4(p)
	table.insert(v30, 1, { StoreItem = storeItem3, Owned = true, Count = 1, HideCountThreshold = 0 })

	for _, v31 in ipairs(v30) do
		v31.IconWidth = 60
		v31.IconHeight = 60
	end

	return v30
end

local function fn10()
	return fn9(v22, storeItem)
end

local function fn11()
	return fn9(v23, storeItem2)
end

local function fn12(currSelection)
	local mSelectedElement = v3.CustomizationList.mSelectedElement

	if
		not __wf_atom_7e8ad928(mSelectedElement)
		and mSelectedElement.ItemSelectionData.TempSelection ~= currSelection
	then
		if not __wf_atom_7e8ad928(currSelection) then
			local v30 = { currSelection:GetItem():__wf_atom_5b41f63b() }
			v14.Loader = UISys.__wf_atom_c0dbe47c(v30, true)
			v14.IsLoading = true
			v14.Selection = currSelection:GetItem()
			v14.Tag = mSelectedElement.Tag
		end

		flag = true
		v8:SetActive(true)
		mSelectedElement.ItemSelectionData.TempSelection = currSelection
		module.PlaySound(_G.UISound_WindowOpen)
	end
end

local function fn13(p, fn14)
	local mSelectedElement = v3.CustomizationList.mSelectedElement

	if not __wf_atom_7e8ad928(mSelectedElement) then
		if p then
			if __wf_atom_7e8ad928(fn14) then
				fn12(mSelectedElement.ItemSelectionData.CurrSelection)
			else
				fn14(mSelectedElement.ItemSelectionData.CurrSelection)
			end

			mSelectedElement.ItemSelectionData.TempSelection = nil
			module.PlaySound(_G.UISound_WindowClose)
		else
			mSelectedElement.ItemSelectionData.CurrSelection = mSelectedElement.ItemSelectionData.TempSelection
			v3.CustomizationList.mElementDrawCallback(mSelectedElement)
			module.PlaySound(_G.UISound_SweetenerTwo)

			if flag2 then
				fn2()
			end
		end
	end

	flag2 = false
end

local function fn14(tempSelection)
	local mSelectedElement = v3.CustomizationList.mSelectedElement

	if
		not __wf_atom_7e8ad928(mSelectedElement)
		and mSelectedElement.ItemSelectionData.TempSelection ~= tempSelection
	then
		v2:__wf_atom_e65f45eb(tempSelection:GetItem())
		mSelectedElement.ItemSelectionData.TempSelection = tempSelection
		module.PlaySound(_G.UISound_WindowOpen)
	end
end

local function fn15(p)
	fn13(p, fn14)
end

local function fn16(tempSelection)
	local mSelectedElement = v3.CustomizationList.mSelectedElement

	if
		not __wf_atom_7e8ad928(mSelectedElement)
		and mSelectedElement.ItemSelectionData.TempSelection ~= tempSelection
	then
		if tempSelection == storeItem then
			v2:__wf_atom_efeb9802()
		else
			v2:__wf_atom_efeb9802(tempSelection:GetItem())
		end

		mSelectedElement.ItemSelectionData.TempSelection = tempSelection
		module.PlaySound(_G.UISound_WindowOpen)
	end
end

local function fn17(p)
	fn13(p, fn16)
end

local function fn18(tempSelection)
	local mSelectedElement = v3.CustomizationList.mSelectedElement

	if
		not __wf_atom_7e8ad928(mSelectedElement)
		and mSelectedElement.ItemSelectionData.TempSelection ~= tempSelection
	then
		if tempSelection == storeItem2 then
			v2:__wf_atom_6ce0cfa9()
		else
			v2:__wf_atom_6ce0cfa9(tempSelection:GetItem())
		end

		mSelectedElement.ItemSelectionData.TempSelection = tempSelection
		module.PlaySound(_G.UISound_WindowOpen)
	end
end

local function fn19(p)
	fn13(p, fn18)
end

local function fn20(p)
	local v30 = __wf_atom_104bfe98(v.Min, v.Max, tonumber(p.mLabel) / 100)
	v2:__wf_atom_d73f7305(v30)
end

local function fn21(p)
	v2:__wf_atom_9668b6f9(p.mChecked)
	v18.mShowLabels = p.mChecked
	v18:Redraw(nil, true, true)
end

fn2 = function(p)
	if not __wf_atom_7e8ad928(v3) and v3.mState ~= v3.State.CUSTOMIZATION then
		v3:Back()
	end

	v3.CustomizationList:RemoveElements(true, true)
	local isPlayingWithController = Engine.IsPlayingWithController()
	local __wf_atom_ce8334fc = v2:__wf_atom_ce8334fc()
	local v30 = {
		{
			TopTitle = "/Lotus/Language/UIStyle/Style_Title",
			Type = module5.Types.ITEM_SELECTION,
			BigButton = true,
			NameTag = "/Lotus/Language/UIStyle/Style_Theme",
			Tag = "THEME",
			ItemSelectionData = {
				HidePrice = true,
				TopTitle = "/Lotus/Language/UIStyle/Style_Theme",
				GetItemsFunction = fn5,
				OnItemSelectedFunction = fn12,
				OnSelectionDoneFunction = fn13
			}
		},
		{
			Type = module5.Types.ITEM_SELECTION,
			BigButton = true,
			NameTag = "/Lotus/Language/UIStyle/Style_Background",
			Tag = "BACKGROUND",
			ItemSelectionData = {
				HidePrice = true,
				TopTitle = "/Lotus/Language/UIStyle/Style_Background",
				GetItemsFunction = fn7,
				OnItemSelectedFunction = fn12,
				OnSelectionDoneFunction = fn13
			}
		},
		{
			Enabled = v4:__wf_atom_cb0fd61c() == v24,
			Type = module5.Types.ITEM_SELECTION,
			BigButton = true,
			NameTag = "/Lotus/Language/UIStyle/Style_LunarAnimal",
			Tag = "LUNARANIMAL",
			ItemSelectionData = {
				TopTitle = "/Lotus/Language/UIStyle/Style_LunarAnimal",
				GetItemsFunction = fn8,
				OnItemSelectedFunction = fn14,
				OnSelectionDoneFunction = fn15,
				HidePrice = true
			}
		},
		{
			Type = module5.Types.ITEM_SELECTION,
			BigButton = true,
			NameTag = "/Lotus/Language/UIStyle/Style_Sounds",
			Tag = "SOUNDS",
			ItemSelectionData = {
				HidePrice = true,
				TopTitle = "/Lotus/Language/UIStyle/Style_Sounds",
				GetItemsFunction = fn6,
				OnItemSelectedFunction = fn12,
				OnSelectionDoneFunction = fn13
			}
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Options_InventoryLabels",
			Tag = "SHOWLABELS",
			mInitialValue = true,
			mDefaultValue = true,
			mValueChangedCallback = fn21,
			ElementHeight = 38,
			ElementSeparation = 5
		},
		{
			Enabled = not isPlayingWithController,
			Type = module5.Types.ITEM_SELECTION,
			NameTag = "/Lotus/Language/UIStyle/Style_MouseCursor",
			Tag = "MOUSECURSOR",
			mUseItemIcon = false,
			ItemSelectionData = {
				TopTitle = "/Lotus/Language/UIStyle/Style_Cursors",
				GetItemsFunction = fn10,
				OnItemSelectedFunction = fn16,
				OnSelectionDoneFunction = fn17
			},
			ElementHeight = 38,
			ElementSeparation = 5
		},
		{
			Enabled = isPlayingWithController,
			Type = module5.Types.ITEM_SELECTION,
			NameTag = "/Lotus/Language/UIStyle/Style_ControllerCursor",
			Tag = "CONTROLLERCURSOR",
			mUseItemIcon = false,
			ItemSelectionData = {
				TopTitle = "/Lotus/Language/UIStyle/Style_Cursors",
				GetItemsFunction = fn11,
				OnItemSelectedFunction = fn18,
				OnSelectionDoneFunction = fn19
			},
			ElementHeight = 38,
			ElementSeparation = 5
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/UIStyle/Style_CursorColor",
			mColorRegions = { "CursorColor" },
			ElementHeight = 38,
			ElementSeparation = 5
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Options_CursorScale",
			mValueChangedCallback = fn20,
			mDefaultValue = (__wf_atom_ce8334fc - v.Min) / (v.Max - v.Min) * 100,
			ElementHeight = 38,
			ElementSeparation = 5
		}
	}

	for _, v31 in ipairs(v30) do
		if v31.Enabled == false then
			continue
		end

		if v31.Type == module5.Types.ITEM_SELECTION then
			v31.ItemSelectionData.CurrSelection = nil
			v31.ItemSelectionData.TempSelection = nil
			local v32 = nil

			if v31.Tag == "THEME" then
				v32 = v4:__wf_atom_a4bdf2b8()
			elseif v31.Tag == "SOUNDS" then
				v32 = v4:__wf_atom_f57f9624()
			elseif v31.Tag == "BACKGROUND" then
				v32 = v4:__wf_atom_cb0fd61c()
			elseif v31.Tag == "LUNARANIMAL" then
				local v35
				v35, v32 = module3.GetAnimalLogo(true)
			elseif v31.Tag == "MOUSECURSOR" then
				v32 = v2:__wf_atom_5e82576e()
			elseif v31.Tag == "CONTROLLERCURSOR" then
				v32 = v2:__wf_atom_6718d7a0()
			end

			if __wf_atom_7e8ad928(v32) and (v31.Tag == "MOUSECURSOR" or v31.Tag == "CONTROLLERCURSOR") then
				v31.ItemSelectionData.CurrSelection = module.Ternary(v31.Tag == "MOUSECURSOR", storeItem, storeItem2)
			elseif not __wf_atom_7e8ad928(v32) then
				if p then
					v26[v31.Tag] = v32
				end

				v31.ItemSelectionData.CurrSelection = v6:__wf_atom_232fd31d(WeakResource(v32))
			end
		elseif v31.Type == module5.Types.COLOR then
			local __wf_atom_f452accf = v2:__wf_atom_f452accf()

			if __wf_atom_f452accf == 16777215 then
				__wf_atom_f452accf = nil
			end

			v31.InitialColor = __wf_atom_f452accf
		elseif v31.Tag == "SHOWLABELS" then
			v31.mInitialValue = v2:__wf_atom_2e306518()
		end

		v3.CustomizationList:AddElement(v31, true)
	end

	v3.CustomizationList:Redraw(nil, true, true)
end

local function fn22()
	local module6 = require("Lotus.Interface.Components.ThemedCustomizationList")
	v3 = module6.Create(mMovie, "Settings")
	v3.DPDHideRelated = true
	v3.CustomizationList.mElementWidth = 448
	v3.CustomizationList.mElementHeight = 138
	v3.CustomizationList.mUseOverrideLoc = true
	v3.CustomizationList.mTopTitleForNone = true

	function v3.CustomizationList.mApplyColorCallback(_, p)
		v2:__wf_atom_60eb7702(module.Ternary(p == nil, 16777215, p))
	end

	function v3.StateChangedCallBack(p)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Settings/Options_StyleManager", false)
		local v30 = (p ~= v3.State.ITEM_SELECTION or __wf_atom_7e8ad928(v3.CustomizationList.mSelectedElement))
			and ""
			or mMovie:__wf_atom_8e9ac384(v3.CustomizationList.mSelectedElement.NameTag, false)

		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle(__wf_atom_8e9ac384, v30, true)
		end
	end

	v3.CustomizationList.VisibleRangeMaterial = panelVisRangeMaterial
	v3.CustomizationList.TextVisibleRangeMaterial = panelTextVisRangeMaterial
	v3.CustomizationList.RectangleVisibleRangeMaterial = panelBgVisRangeMaterial
	v3.CustomizationList.VisibleRangeFadeIconMaterial = panelVisRangeFadeIconMaterial
	v3:UpdateVisRanges()
end

function Shutdown()
	if not __wf_atom_7e8ad928(v3) then
		if v3:Back() and v14.IsLoading then
			if not __wf_atom_7e8ad928(v14.Loader) then
				v14.Loader:Abort()
			end

			fn()
		end

		v3:Shutdown()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	_T.DisableHeadTracking = false
	_T.InfoPopup_Data = nil
	_T.HidePurchaseInfo = nil

	if not (v11 or __wf_atom_7e8ad928(v10)) then
		v10:__wf_atom_e424c72a(false)
	end

	if v9 ~= nil then
		module3.StandKneelingAvatar(v10, v9)
		module2.SetupLoginLighting(false, v27, v28)

		if not __wf_atom_7e8ad928(_T.HideBackground) then
			_T.HideBackground()
		end
	end

	_T.UIStyleScreenOpen = false
end

local function fn23()
	if not __wf_atom_7e8ad928(v3) and v3:Back() then
		return
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local v30 = v26.THEME ~= v4:__wf_atom_a4bdf2b8()
		local v31 = v26.BACKGROUND ~= v4:__wf_atom_cb0fd61c()
		local v32 = v26.SOUNDS ~= v4:__wf_atom_f57f9624()
		gGameData:__wf_atom_cb591d9b(v30, v31, v32)
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) and v29 then
		_T.DisableUIInput()
	end

	module.PlaySound(_G.UISound_GridOpenTwo)
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:Execute("OnStyleManagerClosed", "")
	end

	mMovie:Close()
end

function Close()
	fn23()
end

local function fn24()
	local v30 = {}

	if not __wf_atom_7e8ad928(v3) then
		local hidePurchaseInfo = v3.mState == v3.State.ITEM_SELECTION
			and not __wf_atom_7e8ad928(v3.CustomizationList.mSelectedElement)
			and v3.CustomizationList.mSelectedElement.Tag == "LUNARANIMAL"
		_T.HidePurchaseInfo = hidePurchaseInfo
		local v31 = v3:UpdateButtons()

		for _, v32 in pairs(v31) do
			table.insert(v30, v32)
		end
	end

	table.insert(v30, {
		Label = v3.mState == v3.State.CUSTOMIZATION and "/Lotus/Language/Menu/Exit" or "/Lotus/Language/Menu/Global_Back",
		CallBack = function()
			mMovie:Execute("Close", "")
		end,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v30, getfenv(1))
end

function UpdateButtons()
	fn24()
end

local function fn25()
	local module6 = require("Lotus.Interface.Components.ThemedCategoriesMenu")
	v15 = module6.Create(mMovie, "Components.CategoriesMenu")
	v15.mAlign = module.LEFT_ALIGNED
	v15.mRealRootX = v15.mInitialRootX
	v15.mInitialRootX = v15.mRealRootX + module.Ternary(Engine.IsPlayingWithController(), -36, 0)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAll", false),
			Icon = _G.UICategoryIcon_AllOn
		},
		true
	)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Categories/WARFRAME", false),
			Icon = categoryIcons[1]
		},
		true
	)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ItemInventory_Weapons", false),
			Icon = categoryIcons[2]
		},
		true
	)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Categories/SENTINEL", false),
			Icon = categoryIcons[3]
		},
		true
	)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Categories/APPEARANCE", false),
			Icon = categoryIcons[4]
		},
		true
	)
	v15:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Categories/ENHANCEMENTS", false),
			Icon = categoryIcons[5]
		},
		true
	)
	v15:Redraw()
	v15:SelectElement(1)
end

local function fn26()
	local module6 = require("Lotus.Interface.Components.DropDownMenu")
	v16 = module6.Create(mMovie, "Components.Dropdown")
	v16.mSelectedPrefix = "/SortingLabels/NoPrefix"
	v16:SetCallbacks("SortByPressed", "SortByFocused", "SortByUnfocused")
	v16:SetWidth(185)

	function v16.mElementDrawCallback(data)
		mMovie:__wf_atom_50d60589(data.mClipName .. ".Label", 36, data.Name)
		local mMovie = mMovie
		mMovie:__wf_atom_7f57ab2f(
			data.mClipName,
			"Check",
			13,
			v16.mSelectedElement ~= nil and v16.mSelectedElement.Id == data.Id
		)
	end

	v16:AddElement({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortName", false)
	}, true)
	v16:AddElement({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Arsenal_Rank", false)
	}, true)
	v16:AddElement({
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Polarity", false)
	}, true)
	v16:AddElement({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Owned", false)
	}, true)
	v16:Redraw()
	v16:SelectElementById(1)
end

local function fn27()
	local color = module3.GetColor(0, true)
	local color2 = module3.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("Components.Title", 11, color2)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color)
	mMovie:__wf_atom_1ca72041(
		"Components.Border",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.35
	)
	mMovie:__wf_atom_1ca72041(
		"Components.Border",
		"RectInnerColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0
	)

	if not __wf_atom_7e8ad928(v17) then
		v17:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v27) then
		local color3 = module3.GetColor(13)
		v27:SetColor(color3)
	end
end

local function fn28()
	local inventory = gGameData:GetInventory()
	local module6 = require("EE.Interface.Components.Grid")
	v18 = module6.CreateGrid(mMovie, "Components.SampleGrid.Element", nil, 2, 2)
	v18.mColumnSeparation = 204
	v18.mRowSeparation = 204
	v18.ElementDimBuffer = 19
	v18.PurchasedItems = module4.GetPurchasedItems(v6, inventory)
	v18:AttachScrollBar("Components.SampleGrid.ScrollBar")
	v18:SetCallbacks("SampleGridItemPressed", "SampleGridItemFocused", "SampleGridItemUnfocused")
	module2.InitializeGridItem(mMovie, v18)

	function v18.mClipCreatedCallback(p, _)
		module2.OnGridItemCreated(mMovie, v18, p)
	end

	function v18.mOnFocusedCallback(p)
		module2.OnGridItemFocusChanged(mMovie, v18, p, { IsFocused = true, ShowInfoPopup = true })
	end

	function v18.mOnUnfocusedCallback(p)
		module2.OnGridItemFocusChanged(mMovie, v18, p, { IsFocused = false, ShowInfoPopup = true })
	end

	function v18.mElementDrawCallback(p)
		module2.DrawGridItem(mMovie, v18, p)
	end

	for _, v30 in pairs(sampleElements) do
		local storeItemInfo = module4.GetStoreItemInfo(mMovie, v30)
		v18:AddElement(storeItemInfo, true)
	end

	v18:Redraw()
end

function PlaySound()
	module.PlaySound(_G.UISound_Open)
end

local function fn29()
	local module6 = require("Lotus.Interface.Components.ThemedButton")
	v17 = module6.Create(mMovie, "Components.SoundBtn", "/Lotus/Language/UIStyle/Style_PlaySampleSound", "PlaySound")
	v17.mMinSize = 185
	v17:Resize()
end

function Initialize()
	if not (__wf_atom_7e8ad928(_T.EnableUIInput) or _T.UIInputEnabled) then
		_T.EnableUIInput()
		v29 = true
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v2 = __wf_atom_18a5d83b:Settings()
	end

	module.PlaySound(_G.UISound_GridOpen)
	v10 = gRegion:__wf_atom_c4f78a8f()
	_T.DisableHeadTracking = true
	local module6 = require("Lotus.Interface.Components.ThemedSpinner")
	v8 = module6.Create(mMovie, "Spinner")
	local module7 = require("EE.Interface.AnchorMgr")
	v5 = module7.Create(mMovie)
	v5:Register(mMovie, "Settings", { v5.ANCHOR_V_TOP, v5.ANCHOR_H_LEFT })
	v5:Register(mMovie, "Components", { v5.ANCHOR_V_TOP, v5.ANCHOR_H_LEFT })
	v5:Register(mMovie, "Spinner", { v5.ANCHOR_V_CENTRE, v5.ANCHOR_H_CENTRE })
	v5:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v4 = gClient:__wf_atom_3cb140dc()
	v6 = gGameRules:__wf_atom_964056fd()

	if not __wf_atom_7e8ad928(v6) then
		v7 = v6:__wf_atom_83dea059(true)
	end

	if not __wf_atom_7e8ad928(v10) then
		v11 = v10:__wf_atom_f63d17c0()
		v10:__wf_atom_e424c72a(true)

		if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
			v9 = module3.SetKneelingAvatar(v10, cameraSpot)
			v27, v28 = module2.SetupLoginLighting(true, nil, nil, playerLight)

			if not __wf_atom_7e8ad928(_T.ShowBackground) then
				_T.ShowBackground(0.25, v13, true)
			end
		end
	end

	local module8 = require("Lotus.Interface.Components.RotationControl")
	v12 = module8.Create(mMovie)
	mMovie:__wf_atom_7d7314f1("Components.Title.text", "/Lotus/Language/UIStyle/Style_Sample", false)
	mMovie:OverrideMaterial("Components.Border", _G.UIMaterial_Button)
	fn27()
	fn25()
	fn26()
	fn29()
	fn28()
	fn22()
	fn2(true)
	fn24()

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Settings/Options_StyleManager", true))
	end

	_T.UIStyleScreenOpen = true
end

fn = function()
	v14.IsLoading = false
	local v30 = Resource(v14.Selection)

	if v14.Tag == "THEME" then
		v4:__wf_atom_6355f113(v30)
	elseif v14.Tag == "SOUNDS" then
		v4:__wf_atom_c9368b31(v30)
	else
		flag2 = true
		v4:__wf_atom_ccd7dcbc(v30)

		if not __wf_atom_7e8ad928(_T.ShowBackground) then
			_T.ShowBackground(0, v13, true)
		end
	end

	flag = false
	v8:SetActive(false)
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v8) then
		v8:Update()
	end

	if v14.IsLoading and not __wf_atom_7e8ad928(v14.Loader) and v14.Loader:__wf_atom_86399a47() then
		fn()
	end

	if not __wf_atom_7e8ad928(v12) then
		v12:Update()
	end

	if not __wf_atom_7e8ad928(v3) then
		v3.CustomizationList:Update(__wf_atom_fa1258d0())
	end
end

function onViewportSizeChanged(_, _)
	if v5 ~= nil then
		v5:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:UpdateVisRanges()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:OnViewportSizeChanged()
	end
end

function OnStyleChangedCallback()
	fn27()

	if not __wf_atom_7e8ad928(v3) then
		v3:OnStyleChanged()
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:RunForAllElements(function(p)
			v15:UpdateColors(p)
		end)
	end

	if not __wf_atom_7e8ad928(v16) then
		v16:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v18) then
		v18:RunForAllVisibleElements(function(p)
			v18:UpdateColors(p)
		end)
	end
end

function SupportsThemes()
	return true
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v15) then
		v15:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v15) then
		v15:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not __wf_atom_7e8ad928(v15) then
		v15:SelectElementById((tonumber(p)))
	end
end

function NonCustListDropDownArrowPressed()
	if not __wf_atom_7e8ad928(v16) then
		v16:ArrowPressed()
	end
end

function NonCustListDropDownArrowFocused()
	if not __wf_atom_7e8ad928(v16) then
		v16:ArrowFocused()
	end
end

function NonCustListDropDownArrowUnfocused()
	if not __wf_atom_7e8ad928(v16) then
		v16:ArrowUnfocused()
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v16) then
		v16:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v16) then
		v16:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (flag or __wf_atom_7e8ad928(v16)) then
		v16:SelectElementById(tonumber(p), true)
	end
end

function SampleGridItemPressed(_) end

function SampleGridItemFocused(p)
	if not __wf_atom_7e8ad928(v18) then
		v18:FocusElementById((tonumber(p)))
	end
end

function SampleGridItemUnfocused(p)
	if not __wf_atom_7e8ad928(v18) then
		v18:UnfocusElementById((tonumber(p)))
	end
end

local function fn30(p)
	if v15 then
		v15.mMuteFocusSound = true
		local focusedElement = v15:GetFocusedElement()

		if v15.mSelectedElement and (focusedElement == nil or focusedElement.Id ~= v15.mSelectedElement.Id) then
			v15:FocusElementById(v15.mSelectedElement.Id)
		end

		v15:ToggleFocusedElement(p)
		v15:SelectCurrentElement()
		v15.mMuteFocusSound = false
	end
end

function onKeyDown_MENU_CLICK()
	v12:SetMouseDown(true)
end

function onKeyUp_MENU_CLICK()
	v12:SetMouseDown(false)
end

function onKeyDown_MENU_LTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v15)) then
		fn30(module.DECREMENT)
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v15)) then
		fn30(module.INCREMENT)
	end

	return true
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Scroll(p)
	end
end

function OnGamepadTransition()
	v15.mInitialRootX = v15.mRealRootX + module.Ternary(Engine.IsPlayingWithController(), -36, 0)
	fn2()
end