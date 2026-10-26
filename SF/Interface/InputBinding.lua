local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local flag = true
local v2 = false
local flag2 = false
local v3 = nil
local v4 = nil
local flag3 = false
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = nil
local v9 = {}
local v10 = nil
local fn
local v11 = {}
local v12 = nil
local v13 = {}
local section = 1
local v14 = {}
local v15 = {
	JUMP = { InputCode = "JUMP", Invert = false },
	MOVE_FORWARD = { InputCode = "MOVE_Z", Invert = false },
	MOVE_LEFT = { InputCode = "MOVE_X", Invert = true },
	MOVE_BACKWARD = { InputCode = "MOVE_Z", Invert = true },
	MOVE_RIGHT = { InputCode = "MOVE_X", Invert = false },
	AIM_POWER = { InputCode = "AIM_POWER", Invert = false },
	TOGGLE_CROUCH = { InputCode = "CROUCH", Invert = false },
	HOLD_TO_CROUCH = { InputCode = "HOLD_CROUCH", Invert = false },
	SPRINT_ROLL = { InputCode = "PRE_RUN", Invert = false },
	SPRINT = { InputCode = "RUN", Invert = false },
	ROLL = { InputCode = "ACTION", Invert = false },
	USE = { InputCode = "USE", Invert = false },
	QUICK_MELEE = { InputCode = "MELEE", Invert = false },
	MELEE_THROW = { InputCode = "MELEE_THROW", Invert = false },
	MELEE_PARRY = { InputCode = "MELEE_PARRY", Invert = false },
	MELEE_HEAVY = { InputCode = "MELEE_HEAVY", Invert = false },
	SWITCH_WEAPON = { InputCode = "NEXT_INV", Invert = false },
	CHAT = {
		InputCode = "TOGGLE_CHAT_WINDOW",
		Invert = false,
		RestrictedKeys = { "MOUSE_B0" }
	},
	PUSH_TO_TALK = { InputCode = "PUSH_TO_TALK", Invert = false },
	INSPECT = { InputCode = "INSPECT", Invert = false },
	POWER_A = { InputCode = "ACTIVATE_ABILITY_0", Invert = false },
	POWER_B = { InputCode = "ACTIVATE_ABILITY_1", Invert = false },
	POWER_C = { InputCode = "ACTIVATE_ABILITY_2", Invert = false },
	POWER_D = { InputCode = "ACTIVATE_ABILITY_3", Invert = false },
	POWER_E = { InputCode = "ACTIVATE_ABILITY_4", Invert = false },
	SUMMON_SPARROW = { InputCode = "SUMMON_SPARROW", Invert = false },
	SHOW_LEVEL_MAP = { InputCode = "SHOW_LEVEL_MAP", Invert = false },
	GOTO_NIGHT_FOLD = { InputCode = "GOTO_NIGHT_FOLD", Invert = false },
	SHOW_INVENTORY = { InputCode = "SHOW_INVENTORY", Invert = false },
	TOGGLE_QUESTS_JOURNAL = { InputCode = "TOGGLE_QUESTS_JOURNAL", Invert = false },
	REVERSE_CAMERA = { InputCode = "REVERSE_CAMERA_OFFSET", Invert = false },
	GEAR_HOTKEY_0 = { InputCode = "GEAR_HOTKEY_0", Invert = false },
	GEAR_HOTKEY_1 = { InputCode = "GEAR_HOTKEY_1", Invert = false },
	EMOTE_WHEEL = { InputCode = "MINI_INVENTORY_HOLD", Invert = false },
	CONSUMABLES_HOLD = { InputCode = "CONSUMABLES_HOLD", Invert = false },
	SHAWZIN_NOTE_1 = { InputCode = "SHAWZIN_NOTE_1", Invert = false },
	SHAWZIN_NOTE_2 = { InputCode = "SHAWZIN_NOTE_2", Invert = false },
	SHAWZIN_NOTE_3 = { InputCode = "SHAWZIN_NOTE_3", Invert = false },
	SHAWZIN_NOTE_4 = { InputCode = "SHAWZIN_NOTE_4", Invert = false },
	SHAWZIN_NOTE_5 = { InputCode = "SHAWZIN_NOTE_5", Invert = false }
}
local v16 = {
	{ name = "/SF/Language/Menu/GeneralBindings" },
	{ name = "/SF/Language/Menu/AimPowerBindings" },
	{ name = "/SF/Language/Menu/MusicTitle" }
}
local fn2

function IsInputBlocked()
	return flag
end

local function fn3()
	flag = false
end

local function fn4()
	mMovie:__wf_atom_0cf0fdbe(0)
	mMovie:__wf_atom_7df746cd(module2.MovieBackgroundColor)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("_root", 4, -5000)
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { 100, 0 }, 0.35, 0, fn3)
end

local function fn5(list, state)
	local action = state.Action
	state.Action = action.InputCode
	state.Invert = action.Invert
	state.RestrictedKeys = action.RestrictedKeys
	state.Value = action.Value
	local v17 = "/SF/Language/Settings/Input_" .. state.Action

	if state.Invert then
		v17 ..= "_Invert"
	end

	state.Name = mMovie:__wf_atom_8e9ac384(v17, true)
	state.Binds = __wf_atom_8e4fda44:__wf_atom_c2e9085e(state.Action, state.Invert, state.InputFilter, false, false)
		or {}
	local v18 = __wf_atom_8e4fda44:__wf_atom_c2e9085e(state.Action, state.Invert, state.InputFilter, false, true) or {}

	for i = 1, #list do
		for j = 1, #list[i].Binds do
			for k = 1, #state.Binds do
				if not (list[i].Binds[j] == state.Binds[k] and list[i].InputFilter == state.InputFilter) then
					continue
				end

				if list[i].Value < state.Value then
					state.Binds[j] = nil
					v18[j] = nil
				else
					list[i].Binds[j] = nil

					if j == 1 then
						list[i].PrimaryBinding = nil
					else
						list[i].SecondaryBinding = nil
					end
				end
			end
		end
	end

	if v18[1] ~= nil then
		local v19 = "/SF/Language/Menu/InputBindings_" .. v18[1]
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v19, false)

		if v19 == __wf_atom_8e9ac384 then
			if Engine.__wf_atom_84bb79c2() then
				local v20 = string.gsub(v18[1], "EN_", "")
				state.PrimaryBinding = string.gsub(v20, "_", "")
			else
				state.PrimaryBinding = v18[1]
			end
		else
			state.PrimaryBinding = __wf_atom_8e9ac384
		end
	end

	if v18[2] ~= nil then
		local v19 = "/SF/Language/Menu/InputBindings_" .. v18[2]
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v19, false)

		if v19 == __wf_atom_8e9ac384 then
			if Engine.__wf_atom_84bb79c2() then
				local v20 = string.gsub(v18[2], "EN_", "")
				state.SecondaryBinding = string.gsub(v20, "_", "")
			else
				state.SecondaryBinding = v18[2]
			end
		else
			state.SecondaryBinding = __wf_atom_8e9ac384
		end
	end

	if state.RestrictedKeys == nil then
		state.RestrictedKeys = {}
	end

	list[#list + 1] = state
end

local function fn6()
	flag = true
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12, 4 }, { 0, -5000 }, 0.2, 0, function()
		flag2 = true
	end)
end

local function fn7()
	for k, v17 in pairs(v15) do
		v15[k].Value = __wf_atom_8e4fda44:__wf_atom_e7d83c15(v17.InputCode)
	end

	local v17 = {}
	fn5(v17, { Action = v15.JUMP, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MOVE_FORWARD, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MOVE_LEFT, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MOVE_BACKWARD, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MOVE_RIGHT, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.TOGGLE_CROUCH, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.HOLD_TO_CROUCH, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SPRINT_ROLL, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SPRINT, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.ROLL, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.USE, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.QUICK_MELEE, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MELEE_THROW, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MELEE_PARRY, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.MELEE_HEAVY, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SWITCH_WEAPON, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.AIM_POWER, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.POWER_B, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.POWER_C, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.POWER_D, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.POWER_E, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.CHAT, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.PUSH_TO_TALK, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.INSPECT, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SUMMON_SPARROW, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SHOW_LEVEL_MAP, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.GOTO_NIGHT_FOLD, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.SHOW_INVENTORY, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.TOGGLE_QUESTS_JOURNAL, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.REVERSE_CAMERA, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.GEAR_HOTKEY_0, InputFilter = defaultFilter })
	fn5(v17, { Action = v15.CONSUMABLES_HOLD, InputFilter = defaultFilter })
	local v18 = {}
	fn5(v18, { Action = v15.POWER_A, InputFilter = powerAimFilter })
	fn5(v18, { Action = v15.POWER_E, InputFilter = powerAimFilter })
	local v19 = {}
	fn5(v19, { Action = v15.SHAWZIN_NOTE_1, InputFilter = shawzinFilter })
	fn5(v19, { Action = v15.SHAWZIN_NOTE_2, InputFilter = shawzinFilter })
	fn5(v19, { Action = v15.SHAWZIN_NOTE_3, InputFilter = shawzinFilter })
	fn5(v19, { Action = v15.SHAWZIN_NOTE_4, InputFilter = shawzinFilter })
	fn5(v19, { Action = v15.SHAWZIN_NOTE_5, InputFilter = shawzinFilter })
	v13 = {}
	table.insert(v13, v17)
	table.insert(v13, v18)
	table.insert(v13, v19)
	v3:RemoveElements(true, true)
	local v20 = v13[section]

	for i = 1, #v20 do
		v3:AddElement(v20[i], true)
	end

	v3:Redraw(nil, true, true)
end

local function fn8()
	local scrollValue = v3.mScrollBar:GetScrollValue()
	fn7()
	v3.mScrollBar:SetScrollValue(scrollValue)
end

local function fn9(value)
	if flag3 then
		if not __wf_atom_7e8ad928(v5) then
			v:RemoveTimer(v5)
		end

		flag3 = false
		v4:Close()

		if value ~= nil and value ~= "" then
			if string.find(value, "error:") then
				local v17 = string.gsub(value, "error:", "")
				module.ShowMessage(v17)
			else
				if v6 ~= nil then
					for i = 1, #v13 do
						local v17 = v13[i]

						for j = 1, #v17 do
							local v18 = v17[j]

							if v18.Action ~= v6.Action then
								continue
							end

							local childFilters = {}
							local v19 = v14[v18.InputFilter]
							local parentFilter

							if v19 ~= nil then
								parentFilter = v19.ParentFilter

								if v19.ChildFilters ~= nil then
									childFilters = v19.ChildFilters
								end
							end

							if i == section then
								if
									(v7 == 0 or v18.Invert ~= v6.Invert)
									and v18.Binds
									and v18.Binds[2] ~= nil
									and v18.Binds[2] ~= value
								then
									mMovie:AddInputBinding(
										v18.Action,
										v18.Binds[2],
										1,
										v18.Invert,
										v18.InputFilter,
										parentFilter,
										childFilters
									)
								end

								if
									(v7 == 1 or v18.Invert ~= v6.Invert)
									and v18.Binds
									and v18.Binds[1] ~= nil
									and v18.Binds[1] ~= value
								then
									mMovie:AddInputBinding(
										v18.Action,
										v18.Binds[1],
										0,
										v18.Invert,
										v18.InputFilter,
										parentFilter,
										childFilters
									)
								end
							else
								for k = 1, #v18.Binds do
									if v18.Binds[k] ~= nil then
										mMovie:AddInputBinding(
											v18.Action,
											v18.Binds[k],
											k - 1,
											v18.Invert,
											v18.InputFilter,
											parentFilter,
											childFilters
										)
									end
								end
							end
						end
					end

					v6 = nil
				end

				fn8()
			end
		end
	end
end

function EndRebind(p)
	fn9(p)
end

local function fn10(p, p2)
	local floatingContent = v9.FloatingContent

	if __wf_atom_7e8ad928(p2) or p2 == "" then
		p2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InputBinding_NotBound", false)
		floatingContent = v9.ContentDisabled
	end

	mMovie:__wf_atom_50d60589(p, 36, p2)
	mMovie:__wf_atom_e57658c2(p, 44, floatingContent)
end

local function fn11()
	v14 = {}
	local module3 = require("EE.Interface.Components.List")
	v3 = module3.CreateList(mMovie, "BindingList.Binding1")
	v3.mVisibleElements = 16
	v3.mScroll = 1
	v3.mColumnSeparation = 560
	v3.mForcedVerticalSeparation = 40
	v3.mElementTransitionTime = 0

	function v3:OnFocusedChanged(data, p, p2)
		if data == nil or data.mClipName == nil then
			return
		end

		local backerHighlightObject = v9.BackerHighlightObject
		local ternary = module.Ternary(p2, 0.3, 0.05)

		for i = 1, 3 do
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg.Part" .. i,
				"RectEdgeColor",
				backerHighlightObject.r,
				backerHighlightObject.g,
				backerHighlightObject.b,
				ternary
			)
		end

		local ternary2 = module.Ternary(p, "Binding1", "Binding2")
		local floatingContentHighlight = v9.FloatingContentHighlight

		if not p2 then
			local ternary3 = module.Ternary(p, data.PrimaryBinding, data.SecondaryBinding)
			local v17 = ternary3 == nil or ternary3 == ""
			floatingContentHighlight = module.Ternary(v17, v9.ContentDisabled, v9.FloatingContent)
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, ternary2, 44, floatingContentHighlight)
	end

	function v3.mOnFocusedCallback(p)
		v3:OnFocusedChanged(p, true, true)
	end

	function v3.mOnUnfocusedCallback(p)
		v3:OnFocusedChanged(p, true, false)
	end

	function v3.mOnSelectedCallback(data)
		v4 = mMovie:PushChildMovie(confirmMovie)
		v4:Execute("SetText", "/SF/Language/Menu/InputBinding_PressKey")
		v4:Execute("SetNumOptions", 0)
		v7 = 0
		v6 = data
		local childFilters = {}
		local v17 = v14[data.InputFilter]
		local parentFilter

		if v17 ~= nil then
			parentFilter = v17.ParentFilter

			if v17.ChildFilters ~= nil then
				childFilters = v17.ChildFilters
			end
		end

		v4:__wf_atom_6abb2e73(
			data.Action,
			data.RestrictedKeys,
			v7,
			data.Invert,
			data.InputFilter,
			parentFilter,
			childFilters
		)
		flag3 = true
		v5 = v:AddTimer(5, fn9)
	end

	function v3.mOnSecondaryFocusedCallback(p)
		v3:OnFocusedChanged(p, false, true)
	end

	function v3.mOnSecondaryUnfocusedCallback(p)
		v3:OnFocusedChanged(p, false, false)
	end

	function v3.mOnSecondarySelectedCallback(data)
		v4 = mMovie:PushChildMovie(confirmMovie)
		v4:Execute("SetText", "/SF/Language/Menu/InputBinding_PressKey")
		v4:Execute("SetNumOptions", 0)
		v7 = 1
		v6 = data
		local childFilters = {}
		local v17 = v14[data.InputFilter]
		local parentFilter

		if v17 ~= nil then
			parentFilter = v17.ParentFilter

			if v17.ChildFilters ~= nil then
				childFilters = v17.ChildFilters
			end
		end

		v4:__wf_atom_6abb2e73(
			data.Action,
			data.RestrictedKeys,
			v7,
			data.Invert,
			data.InputFilter,
			parentFilter,
			childFilters
		)
		flag3 = true
		v5 = v:AddTimer(5, fn9)
	end

	function v3.mElementDrawCallback(data)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Action", 44, v9.FloatingContent)
		module.SetFittedText(mMovie, data.mClipName .. ".Action", data.Name, "...")
		fn10(data.mClipName .. ".Binding1", data.PrimaryBinding)
		fn10(data.mClipName .. ".Binding2", data.SecondaryBinding)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn1", 100, data.Id)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn2", 100, data.Id)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 100, data.Id)
		mMovie:SetCallbacks(
			data.mClipName .. ".Btn1",
			"PrimaryBindingFocused",
			"PrimaryBindingUnfocused",
			"PrimaryBindingPressed",
			nil
		)
		mMovie:SetCallbacks(
			data.mClipName .. ".Btn2",
			"SecondaryBindingFocused",
			"SecondaryBindingUnfocused",
			"SecondaryBindingPressed",
			nil
		)
		mMovie:SetCallbacks(data.mClipName .. ".Bg", "ActionTextFocused", "ActionTextUnfocused", nil, nil)
		local backerHighlightObject = v9.BackerHighlightObject
		local background1Object = v9.Background1Object

		for i = 1, 3 do
			mMovie:OverrideMaterial(data.mClipName .. ".Bg.Part" .. i, _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg.Part" .. i,
				"RectInnerColor",
				background1Object.r,
				background1Object.g,
				background1Object.b,
				0.6
			)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg.Part" .. i,
				"RectEdgeColor",
				backerHighlightObject.r,
				backerHighlightObject.g,
				backerHighlightObject.b,
				0.05
			)
		end
	end

	v3:AttachScrollBar("BindingList.ScrollBar", -4)
	__wf_atom_86cbd68d(mMovie, "BindingList.ScrollBar.swapDepths", 1500)
end

local function fn12()
	local module3 = require("Lotus.Interface.Components.ThemedCategoriesMenu")
	v12 = module3.Create(mMovie, "CategoryMenu")
	v12.mAlign = module.LEFT_ALIGNED
	v12.mShowCallouts = false
	v12.mDisplayMode = v12.Modes.TEXT

	function v12.mOnSelectedCallback(p)
		section = p.Section
		fn7()
	end

	for i = 1, #v16 do
		v12:AddElement({ Name = fn2(i), Section = i }, true)
	end

	v12:Redraw()
	v12:SelectElement(1)
end

function Initialize()
	local module3 = require("Lotus.Interface.Libs.TimerMgr")
	v = module3.CreateTimerMgr()
	v8 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	v9.Background1 = module2.GetColor(2, true)
	v9.Background1Object = module.ConvertColorNumberToProceduralRGB(v9.Background1)
	v9.BackerHighlight = module2.GetColor(1, true)
	v9.BackerHighlightObject = module.ConvertColorNumberToProceduralRGB(v9.BackerHighlight)
	v9.Content = module2.GetColor(6, true)
	v9.ContentDisabled = module2.GetColor(8, true)
	v9.FloatingContent = module2.GetColor(9, true)
	v9.FloatingContentHighlight = module2.GetColor(10, true)
	local module4 = require("EE.Interface.AnchorMgr")
	v10 = module4.Create(mMovie)
	v10:Register(mMovie, "BindingList", { v10.ANCHOR_V_TOP, v10.ANCHOR_H_LEFT })
	v10:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	fn11()
	fn12()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SettingsControls", false))
	end

	table.insert(v11, {
		mVisible = true,
		mLabel = "/Lotus/Language/Menu/Global_Back",
		mCallback = function()
			mMovie:Execute("BackButton", "")
		end,
		mCallout = "MENU_CANCEL"
	})
	table.insert(v11, {
		mVisible = true,
		mLabel = "/Lotus/Language/Menu/Global_Defaults",
		mCallback = function()
			mMovie:Execute("RestoreButton", "")
		end,
		mCallout = "MENU_GENERIC1"
	})
	fn()
	fn4()
	v2 = true
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v2 then
		return
	end

	if flag2 then
		mMovie:Close()
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end
end

function TransitionOut()
	fn6()
end

function RollOver()
	if not flag then
		module.PlaySound(beepSound)
	end
end

function PrimaryBindingFocused(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		module.PlaySound(beepSound)
		v3:FocusElementById((tonumber(p)))
	end
end

function PrimaryBindingUnfocused(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		v3:UnfocusElementById((tonumber(p)))
	end
end

function PrimaryBindingPressed(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		v3:SelectElementById((tonumber(p)))
	end
end

function SecondaryBindingFocused(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		module.PlaySound(beepSound)
		local elementById = v3:GetElementById((tonumber(p)))
		v3.mOnSecondaryFocusedCallback(elementById)
	end
end

function SecondaryBindingUnfocused(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		local elementById = v3:GetElementById((tonumber(p)))
		v3.mOnSecondaryUnfocusedCallback(elementById)
	end
end

function SecondaryBindingPressed(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		local elementById = v3:GetElementById((tonumber(p)))
		v3.mOnSecondarySelectedCallback(elementById)
	end
end

function ActionTextFocused(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		local elementById = v3:GetElementById((tonumber(p)))
		_T.gToolTip = elementById.Name
	end
end

function ActionTextUnfocused(_)
	_T.gToolTip = nil
end

local function fn13()
	for i = 1, v3:GetHowManyElements() do
		local elementInIndex = v3:GetElementInIndex(i)

		for j = 1, #elementInIndex.Binds do
			mMovie:__wf_atom_042a8818(
				elementInIndex.Action,
				j - 1,
				elementInIndex.Invert,
				elementInIndex.InputFilter,
				false
			)
		end
	end

	for i = 1, v3:GetHowManyElements() do
		local elementInIndex = v3:GetElementInIndex(i)
		local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(
			elementInIndex.Action,
			elementInIndex.Invert,
			elementInIndex.InputFilter,
			false,
			false,
			true
		)
		local childFilters = {}
		local v17 = v14[elementInIndex.InputFilter]
		local parentFilter

		if v17 ~= nil then
			parentFilter = v17.ParentFilter

			if v17.ChildFilters ~= nil then
				childFilters = v17.ChildFilters
			end
		end

		for j = 1, #__wf_atom_c2e9085e do
			mMovie:AddInputBinding(
				elementInIndex.Action,
				__wf_atom_c2e9085e[j],
				j - 1,
				elementInIndex.Invert,
				elementInIndex.InputFilter,
				parentFilter,
				childFilters
			)
		end

		for j = 1, #v13 do
			local v18 = v13[j]

			for k = 1, #v18 do
				local v19 = v18[k]

				if v19.Action ~= elementInIndex.Action then
					continue
				end

				local childFilters2 = {}
				local v20 = v14[v19.InputFilter]
				local parentFilter2

				if v20 ~= nil then
					parentFilter2 = v20.ParentFilter

					if v20.ChildFilters ~= nil then
						childFilters2 = v20.ChildFilters
					end
				end

				if j == section then
					continue
				end

				for i2 = 1, #v19.Binds do
					if v19.Binds[i2] ~= nil then
						mMovie:AddInputBinding(
							v19.Action,
							v19.Binds[i2],
							i2 - 1,
							v19.Invert,
							v19.InputFilter,
							parentFilter2,
							childFilters2
						)
					end
				end
			end
		end
	end

	fn8()
end

fn2 = function(p)
	local name = v16[p].name
	return mMovie:__wf_atom_8e9ac384(name, false)
end

local function fn14(inputCode, invert, p, names, bindingIndex)
	local v17 = v13[bindingIndex]

	for i = 1, #v17 do
		local v18 = v17[i]

		if not (v18.Action == inputCode and v18.Invert == invert) then
			continue
		end

		if not __wf_atom_7e8ad928(v18.PrimaryBinding) then
			return true
		end

		if p then
			module.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Settings/InputBinding_ActionNotbound",
				true,
				{ ACTION = v18.Name, CATEGORY = fn2(bindingIndex) }
			))
		end

		if names ~= nil then
			table.insert(names, v18.Name)
		end

		return false
	end

	return false
end

local function fn15()
	local v17 = {}
	local actions = {}
	local actionGroups = {
		{ v15.TOGGLE_CROUCH, v15.HOLD_TO_CROUCH }
	}
	table.insert(actions, v15.JUMP)
	table.insert(actions, v15.MOVE_FORWARD)
	table.insert(actions, v15.MOVE_LEFT)
	table.insert(actions, v15.MOVE_BACKWARD)
	table.insert(actions, v15.MOVE_RIGHT)
	table.insert(actions, v15.SPRINT_ROLL)
	table.insert(actions, v15.USE)
	table.insert(actions, v15.AIM_POWER)
	table.insert(actions, v15.RELOAD)
	table.insert(actions, v15.QUICK_MELEE)
	table.insert(actions, v15.MELEE_THROW)
	table.insert(actions, v15.SWITCH_WEAPON)
	table.insert(actions, v15.GEAR_HOTKEY_0)
	table.insert(actions, v15.POWER_B)
	table.insert(actions, v15.POWER_C)
	table.insert(actions, v15.POWER_D)
	table.insert(v17, { Actions = actions, ActionGroups = actionGroups, BindingIndex = 1 })
	local actions2 = {}
	table.insert(actions2, v15.POWER_A)
	table.insert(actions2, v15.POWER_E)
	table.insert(v17, { Actions = actions2, ActionGroups = {}, BindingIndex = 2 })
	local actions3 = {}
	table.insert(actions3, v15.SHAWZIN_NOTE_1)
	table.insert(actions3, v15.SHAWZIN_NOTE_2)
	table.insert(actions3, v15.SHAWZIN_NOTE_3)
	table.insert(actions3, v15.SHAWZIN_NOTE_4)
	table.insert(actions3, v15.SHAWZIN_NOTE_5)
	table.insert(v17, { Actions = actions3, ActionGroups = {}, BindingIndex = 3 })

	for i = 1, #v17 do
		local v18 = v17[i]

		for j = 1, #v18.Actions do
			if not fn14(v18.Actions[j].InputCode, v18.Actions[j].Invert, true, nil, v18.BindingIndex) then
				return false
			end
		end

		for j = 1, #v18.ActionGroups do
			local actionGroup = v18.ActionGroups[j]
			local v19 = {}
			local v20 = false

			for k = 1, #actionGroup do
				if not fn14(actionGroup[k].InputCode, actionGroup[k].Invert, false, v19, v18.BindingIndex) then
					continue
				end

				v20 = true
				break
			end

			if v20 then
				continue
			end

			local actions4 = ""

			for k = 1, #v19 do
				actions4 ..= v19[k] .. "\r\n"
			end

			module.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Settings/InputBinding_ActionGroupNotBound",
				false,
				{ ACTIONS = actions4, CATEGORY = fn2(v18.BindingIndex) }
			))
			return false
		end
	end

	return true
end

local function fn16()
	if flag then
		return
	end

	if not fn15() then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/Error_InvalidControlSchemes", true))
		return
	end

	module.PlaySound(pressSound)
	__wf_atom_8e4fda44:__wf_atom_8ef89e30()

	if not __wf_atom_7e8ad928(v8) and Engine.__wf_atom_84bb79c2() then
		local settings = v8:Settings()
		settings:__wf_atom_7e1a90c3(__wf_atom_c67f9605:__wf_atom_622bc136(), false)

		for i = 1, #v13 do
			local v17 = v13[i]

			for j = 1, #v17 do
				local v18 = v17[j]

				for k = 1, #v18.Binds do
					settings:AddInputBinding(
						v18.Action,
						v18.Binds[k],
						v18.Invert,
						v18.InputFilter,
						__wf_atom_c67f9605:__wf_atom_622bc136(),
						false,
						k - 1
					)
				end
			end
		end

		settings:__wf_atom_6b99bafa(false)
	end

	_T.controlsChanged = true
	fn6()
end

function Shutdown()
	_T.gToolTip = nil

	if not __wf_atom_7e8ad928(v4) then
		v4:Close()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end
end

function BackButton()
	fn16()
end

function ConfirmRestoreDefaultBindings(p)
	if tonumber(p) == 4 then
		fn13()
	end
end

function RestoreButton()
	module.ShowConfirmMessage("/Lotus/Language/Menu/Global_DefaultsConfirm", "ConfirmRestoreDefaultBindings")
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (flag or __wf_atom_7e8ad928(v3.mScrollBar)) then
		v3.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

fn = function()
	local v17 = {}

	for i = #v11, 1, -1 do
		local v18 = v11[i]

		if v18.mVisible then
			table.insert(v17, {
				Label = v18.mLabel,
				CallBack = v18.mCallback,
				CallOut = v18.mCallout
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v17, getfenv(1))
	end
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v12) then
		v12:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v12) then
		v12:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v12)) then
		v12:SelectElementById((tonumber(p)))
	end
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v10) then
		v10:Update(p, p2)
	end
end

function SupportsThemes()
	return true
end