local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("EE.Interface.AnchorMgr")
local v = {
	Title = "/SF/Language/Inventory/Title",
	ShowCurrency = true,
	PopulateElements = function()
		return {}
	end,
	OnItemSelected = function() end,
	OnClosed = function() end,
	xPos = nil,
	yPos = nil
}
local v2 = nil
local fullscreenItemPickerUiOptions = nil
local v3 = false
local v4 = nil
local v5 = {}
local _ = { BG = _G.UIColor_DarkBrown }

local function fn(p, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end

	local screenDimensions, _ = module.GetScreenDimensions(mMovie)

	if v4 ~= nil then
		v4:UpdateWidth(screenDimensions - (mMovie:__wf_atom_97cd8326() - v4.mDefaultWidth))
	end

	local screenDimensions2, v6 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, screenDimensions2)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, v6)
end

function MarkDirty()
	v3 = true
end

local function fn2()
	if v3 == false then
		return
	end

	mMovie:__wf_atom_2dedec1a("InfoMessage", 13, false)

	if fullscreenItemPickerUiOptions.xPos ~= nil then
		mMovie:__wf_atom_e57658c2("Panel", 0, fullscreenItemPickerUiOptions.xPos)
	end

	if fullscreenItemPickerUiOptions.yPos ~= nil then
		mMovie:__wf_atom_e57658c2("Panel", 1, fullscreenItemPickerUiOptions.yPos)
	end

	v4:RemoveElements(true, true)
	local populateElements = fullscreenItemPickerUiOptions.PopulateElements()

	for _, populateElement in ipairs(populateElements) do
		v4:AddElement(populateElement, true)
	end

	v4:SetTitle(mMovie:__wf_atom_8e9ac384(fullscreenItemPickerUiOptions.Title or "", true))
	v4:Redraw(nil, true, true)
	v3 = false
end

local function fn3()
	if fullscreenItemPickerUiOptions.ShowCurrency == false then
		return
	end

	local v6 = { mMovie = mMovie }
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		v6.mLabel = __wf_atom_eab484a7:__wf_atom_6be84646()
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		v6.mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
		local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
		local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
		v6.mRankProgress = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a) * 100
	end

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v6)
	end
end

function MouseCatcherPressed() end

function Initialize()
	v2 = module3.Create(mMovie)
	v2:Register(mMovie, "Top", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	v2:Register(mMovie, "CloseBtn", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_CENTRE })
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_976dcedd("MouseCatcherBtn", "noMenuSelection", true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, nil, "MouseCatcherPressed")
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 11, 0)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 90)
	fullscreenItemPickerUiOptions = _T.FullscreenItemPickerUiOptions or {}

	for k, v6 in pairs(v) do
		if fullscreenItemPickerUiOptions[k] == nil then
			fullscreenItemPickerUiOptions[k] = v6
		end
	end

	local module4 = require("EE.Interface.Components.ItemGrid")
	v4 = module4.Create(getfenv(1), "Top.GridContainer", {})
	v4.mDefaultWidth = 1700

	function v4.mOnFocusedCallback(p)
		module.PlaySound(_G.UISound_Focus)
		v4.UpdateFocused(p, true)
		module2.SetItemInfoPopupRect(
			mMovie,
			p,
			mMovie:__wf_atom_cfc41e35(p.mClipName, "Btn", 2),
			mMovie:__wf_atom_cfc41e35(p.mClipName, "Btn", 3),
			mMovie:__wf_atom_cfc41e35(p.mClipName, "Btn", 14) - 30,
			mMovie:__wf_atom_cfc41e35(p.mClipName, "Btn", 15) - 24
		)
	end

	function v4.mOnUnfocusedCallback(p)
		module.PlaySound(_G.UISound_Unfocus)
		v4.UpdateFocused(p, false)
	end

	function v4.mOnSelectedCallback(p)
		if p.Unselectable or v4.mMultiSelect then
			return
		end

		local v6 = fullscreenItemPickerUiOptions.OnElementSelected(p)

		if v6 == "AdvanceAndShutdown" then
			AdvanceAndShutdown()
		elseif v6 == "Refresh" then
			MarkDirty()
		end
	end

	MarkDirty()
	fn2()
	fn3()
	UpdateButtons()
	fn(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.5)
	module.PlaySound(inventoryOpenSound)
end

function onViewportSizeChanged(p, p2)
	fn(p, p2)
end

function Update()
	local v6 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v6)
	fn2()
end

local function fn4()
	_T.FullscreenItemPickerUiOptions = nil

	if fullscreenItemPickerUiOptions ~= nil and fullscreenItemPickerUiOptions.OnClosed ~= nil then
		fullscreenItemPickerUiOptions.OnClosed()
		fullscreenItemPickerUiOptions.OnClosed = nil
	end
end

function Shutdown(p)
	if not p then
		fn4()
	end
end

local function fn5()
	mMovie:Close()
end

function AdvanceAndShutdown()
	module.PlaySound(inventoryCloseSound)
	mMovie:__wf_atom_0c1c47f2(nil)
	fn4()

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 0, fn5)
end

function ConfirmSelectedItems()
	local numberRequired = fullscreenItemPickerUiOptions.NumberRequired

	if numberRequired == nil or v4.mCount == numberRequired then
		if fullscreenItemPickerUiOptions.OnElementSelected(v5) then
			AdvanceAndShutdown()
		end
	else
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.titleString = Localize("/SF/Language/Inventory/SelectedCount", {
			COUNT = v4.mCount,
			REQ = numberRequired
		})

		if numberRequired < v4.mCount then
			dialogSettings.locString = Localize("/SF/Language/Inventory/TooManySelected", {
				NUM = v4.mCount - numberRequired
			})
		else
			dialogSettings.locString = Localize("/SF/Language/Inventory/TooFewSelected", {
				NUM = numberRequired - v4.mCount
			})
		end

		module.ShowCustomMessage(dialogSettings)
	end
end

function UpdateButtons()
	local v6 = {}

	if v4.mMultiSelect then
		table.insert(v6, {
			Label = "/SF/Language/Menu/Menu_Confirm",
			CallBack = ConfirmSelectedItems,
			CallOut = "MENU_GENERIC2"
		})
	end

	table.insert(v6, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = AdvanceAndShutdown,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v6, getfenv(1))
	end
end

function onKeyDown_MENU_CANCEL(_, _)
	AdvanceAndShutdown()
	return true
end

function OpenedFromPauseMenu()
	fn(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function PrepareToClose()
	AdvanceAndShutdown()
end