local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.UIUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.BindingsUtil")
local v = {}
local v2 = true
local v3 = false
local flag = false
local v4 = nil
local flag2 = false
local v5 = nil
local v6 = false
local v7 = nil
local v8 = false
local v9 = nil
local v10 = false
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = {
	AIMING = {
		"AIM_WEAPON",
		"SHOW_SECRET_1",
		"VIEW_QUICK_PROGRESS",
		"REVERSE_CAMERA_OFFSET",
		"SHOW_LEVEL_MAP",
		"VIEW_HUMAN_PLAYERS",
		"CAMERA_TARGET_NEXT",
		"CAMERA_TARGET_PREV",
		"CAMERA_TARGET_TOGGLE"
	},
	MOVEMENT = { "JUMP", "MOVE_X", "LOOK_X", "MOVE_Y", "RUN", "PRE_RUN", "ACTION", "CROUCH" },
	WEAPONS = {
		"MELEE_PARRY",
		"PRE_ATTACK",
		"MELEE_THROW",
		"MELEE_CHANNEL",
		"MELEE_HEAVY",
		"MELEE",
		"RELOAD",
		"SECONDARY_FIRE",
		"AIM_WEAPON",
		"NEXT_INV",
		"TROOPER_POWER"
	},
	ABILITIES = {
		"ACTIVATE_ABILITY_0",
		"ACTIVATE_ABILITY_1",
		"ACTIVATE_ABILITY_2",
		"ACTIVATE_ABILITY_3"
	},
	ACTIONS = {
		"AIM_POWER",
		"CONSUMABLES_HOLD",
		"CONSUMABLES_TOGGLE",
		"INSPECT",
		"VIEW_RAILJACK_SYSTEMS",
		"TOGGLE_RAILJACK_CAMERA",
		"USE",
		"GOTO_NIGHT_FOLD",
		"SUMMON_SPARROW",
		"GEAR_HOTKEY_0",
		"GEAR_HOTKEY_1",
		"GEAR_HOTKEY_2",
		"GEAR_HOTKEY_3",
		"GEAR_HOTKEY_4",
		"GEAR_HOTKEY_5",
		"GEAR_HOTKEY_6",
		"GEAR_HOTKEY_7",
		"GEAR_HOTKEY_8",
		"GEAR_HOTKEY_9",
		"GEAR_HOTKEY_10",
		"GEAR_HOTKEY_11"
	}
}
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local v21 = {}
local v22 = {}
local v23 = {}
local v24 = nil
local defaultFilter = module5.defaultFilter
local meleeFilter = module5.meleeFilter
local powerMenuFilter = module5.powerMenuFilter
local lunaroFilter = module5.lunaroFilter
local placementFilter = module5.placementFilter
local frameFighterFilter = module5.frameFighterFilter
local railjackFilter = module5.railjackFilter
local shawzinFilter = module5.shawzinFilter
local archwingFilter = module5.archwingFilter
local duviriMeleeFilter = module5.duviriMeleeFilter
local v25 = nil
local v26 = nil
local v27 = false
local v28 = 0
local v29 = nil
local v30 = nil
local v31 = nil
local v32 = nil

local function fn(p)
	if isRemotePlay then
		return __wf_atom_c67f9605:__wf_atom_f776b156()
	end

	if p then
		return __wf_atom_c67f9605:__wf_atom_622bc136()
	end

	return nil
end

local function fn2()
	v2 = false
end

local function fn3()
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.2, 0, fn2)
end

local function fn4()
	v2 = true
	module2.PlaySound(_G.UISound_Close)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.2, 0, function()
		flag = true
	end)
end

local function fn5(p, p2)
	if __wf_atom_7e8ad928(v4) then
		return
	end

	local v33 = v16[p]
	local v34 = defaultFilter

	if p == module5.SECTION_ID.POWER_MENU then
		v34 = powerMenuFilter
	elseif p == module5.SECTION_ID.LUNARO then
		v34 = lunaroFilter
	elseif p == module5.SECTION_ID.PLACEMENT then
		v34 = placementFilter
	elseif p == module5.SECTION_ID.FRAME_FIGHTER then
		v34 = frameFighterFilter
	elseif p == module5.SECTION_ID.RAILJACK then
		v34 = railjackFilter
	elseif p == module5.SECTION_ID.SHAWZIN then
		v34 = shawzinFilter
	end

	local v35 = {}

	for i = 1, #v24 do
		v35[i] = { Mapping = v24[i], mOverrideClipName = v24[i].OverrideClipName }
	end

	local settings = v4:Settings()
	local v36 = fn(p2)

	local function fn6(action, p3, p4)
		if not p2 then
			local __wf_atom_76a9183f = settings:__wf_atom_76a9183f(action, p3, v36, p4)

			for i = #__wf_atom_76a9183f, 1, -1 do
				if __wf_atom_76a9183f[i] == "" then
					table.remove(__wf_atom_76a9183f, i)
				end
			end

			if #__wf_atom_76a9183f > 0 then
				return __wf_atom_76a9183f
			end
		end

		local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(action, p3, p4, true, false, p2 == true)

		for i = #__wf_atom_c2e9085e, 1, -1 do
			if
				__wf_atom_c2e9085e[i] == ""
				or not p2 and settings:__wf_atom_989cf70c(__wf_atom_c2e9085e[i], v36, p4)
			then
				table.remove(__wf_atom_c2e9085e, i)
			end
		end

		return __wf_atom_c2e9085e
	end

	local function fn7(p3, list, p4)
		for _, button in ipairs(list) do
			local v38 = nil

			for i = 1, #v35 do
				if v35[i].Mapping.Button ~= button then
					continue
				end

				v38 = i
				break
			end

			if not v38 then
				table.insert(v35, {
					Mapping = { Button = button, Platform = "ALL", ReadOnly = true }
				})
				v38 = #v35
			end

			v35[v38][p4] = p3
		end
	end

	for i = 1, #v33 do
		local v37 = v33[i]
		local ternary = module2.Ternary(v37.Invert and v37.Action ~= "MOVE_X", v37.Invert, false)
		local v38

		if v34 == placementFilter or v34 == frameFighterFilter or v34 == railjackFilter then
			v38 = true
		elseif v37.Action == "MOVE_Y" or v37.Action == "PRE_MOVE_DOWN" then
			v38 = false
		else
			v38 = v37.Action ~= "MELEE_CHANNEL"
		end

		if v38 then
			fn7(v37, fn6(v37.Action, ternary, v34), "Data")
		end

		if p == module5.SECTION_ID.PLACEMENT then
			continue
		end

		local v39 = v37.Action == "MELEE_SWING" or v37.Action == "MELEE_CHANNEL"
		local v40

		if v34 == railjackFilter then
			v40 = false
		else
			v40 = v37.Action == "MOVE_Y" or v37.Action == "PRE_MOVE_DOWN"
		end

		if v39 then
			fn7(v37, fn6(v37.Action, ternary, meleeFilter), "Data2")
		end

		if v40 then
			fn7(v37, fn6(v37.Action, ternary, archwingFilter), "Data2")
		end

		if v37.IsDuviriMelee then
			fn7(v37, fn6(v37.Action, false, duviriMeleeFilter), "Data")
		end
	end

	if p == module5.SECTION_ID.GENERAL then
		v17 = v35
	elseif p == module5.SECTION_ID.POWER_MENU then
		v18 = v35
	elseif p == module5.SECTION_ID.LUNARO then
		v19 = v35
	elseif p == module5.SECTION_ID.PLACEMENT then
		v20 = v35
	elseif p == module5.SECTION_ID.FRAME_FIGHTER then
		v21 = v35
	elseif p == module5.SECTION_ID.RAILJACK then
		v22 = v35
	elseif p == module5.SECTION_ID.SHAWZIN then
		v23 = v35
	end
end

local function fn6(p)
	v29 = p
	v30 = v16[v29]

	if v29 == module5.SECTION_ID.GENERAL then
		v31 = v17
	elseif v29 == module5.SECTION_ID.POWER_MENU then
		v31 = v18
	elseif v29 == module5.SECTION_ID.LUNARO then
		v31 = v19
	elseif v29 == module5.SECTION_ID.PLACEMENT then
		v31 = v20
	elseif v29 == module5.SECTION_ID.FRAME_FIGHTER then
		v31 = v21
	elseif v29 == module5.SECTION_ID.RAILJACK then
		v31 = v22
	elseif v29 == module5.SECTION_ID.SHAWZIN then
		v31 = v23
	end

	v9:RemoveElements(true, true)
	local v33 = __wf_atom_9a2b0be4("Graphics.DeviceIconType")
	__wf_atom_8e4fda44:__wf_atom_5707e854()
	local v34

	if
		Engine.__wf_atom_6d151271()
		or v33 == "DIT_PS5"
		or v33 == "DIT_AUTO" and __wf_atom_8e4fda44:__wf_atom_5707e854() == 6
	then
		v34 = "PS5"
	elseif
		Engine.__wf_atom_e43a530e()
		or v33 == "DIT_PS4"
		or v33 == "DIT_AUTO" and __wf_atom_8e4fda44:__wf_atom_5707e854() == 2
	then
		v34 = "PS4"
	elseif Engine.__wf_atom_84bb79c2() then
		v34 = "XBONE"
	elseif Engine.__wf_atom_b290ec01() or __wf_atom_9a2b0be4("Graphics.DeviceIconType") == "DIT_SWITCH" then
		v34 = "SWITCH"
	else
		v34 = "PC"
	end

	for _, v35 in pairs(v31) do
		if not (v35 ~= nil and (v35.Mapping.Platform == "ALL" or v35.Mapping.Platform == v34)) then
			continue
		end

		local posX = nil
		local posY = nil
		local v38 = v9:AddElement(v35, true)

		if v35.Mapping.AnchorIndex == nil then
			if v35.Mapping.OverrideClipName then
				posX = mMovie:__wf_atom_5e6e15c8(v35.Mapping.OverrideClipName, 0)
				posY = mMovie:__wf_atom_5e6e15c8(v35.Mapping.OverrideClipName, 1)
			end
		else
			posX = mMovie:__wf_atom_5e6e15c8("ControllerMapping.KeyAnchor" .. v35.Mapping.AnchorIndex, 0)
			posY = mMovie:__wf_atom_5e6e15c8("ControllerMapping.KeyAnchor" .. v35.Mapping.AnchorIndex, 1)

			if v35.Mapping.TextAlign == "right" then
				posX = posX - mMovie:__wf_atom_5e6e15c8(v9.mClipName, 14) - 10
			elseif v35.Mapping.TextAlign == "left" then
				posX += 10
			end
		end

		v38.PosX = posX
		v38.PosY = posY
	end

	v9:Redraw()
end

local function fn7(p, p2)
	for _, v33 in pairs(p2 or v17) do
		if v33.Data and v33.Data.Action == p then
			return true
		end
	end

	return false
end

local function fn8()
	local v33 = {}

	for i = #v, 1, -1 do
		local v34 = v[i]

		if v34.mVisible then
			table.insert(v33, {
				Label = v34.mLabel,
				CallBack = v34.mCallback,
				CallOut = v34.mCallout
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v33, getfenv(1))
	end
end

local function fn9(p)
	v27 = p

	if v27 then
		if not __wf_atom_7e8ad928(v32) then
			return
		end

		local v33 = {
			AIMING = {},
			MOVEMENT = {},
			WEAPONS = {},
			ABILITIES = {},
			ACTIONS = {},
			MISC = {}
		}

		if v25.Mapping.ReadOnly or not __wf_atom_7e8ad928(v25.Data) and v25.Data.ReadOnly then
			module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_CannotRebindButton", true))
			v27 = not v27
		elseif
			v29 == module5.SECTION_ID.POWER_MENU
			and not __wf_atom_7e8ad928(v25.Data)
			and v25.Data.Action == "POWER_MENU"
		then
			module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_CannotRebindInConfig", true, {
				BUTTON = v25.Data.Label
			}))
			v27 = not v27
		else
			local v34

			if Engine.__wf_atom_6d151271() then
				v34 = "PS5"
			elseif Engine.__wf_atom_e43a530e() then
				v34 = "PS4"
			elseif Engine.__wf_atom_84bb79c2() then
				v34 = "XBONE"
			elseif Engine.__wf_atom_b290ec01() then
				v34 = "SWITCH"
			else
				v34 = "PC"
			end

			local function fn10(p2)
				for k, v35 in pairs(v15) do
					for i = 1, #v35 do
						if v35[i] ~= p2.Action then
							continue
						end

						p2.SortIndex = i
						table.insert(v33[k], p2)
						return
					end
				end

				table.insert(v33.MISC, p2)
			end

			for _, v35 in pairs(v30) do
				__wf_atom_83c14687(0)

				if
					v35.Action == "NONE"
					or v35.ReadOnly
					or not (__wf_atom_7e8ad928(v35.Platform) or v35.Platform == v34)
				then
					continue
				end

				if v25.Mapping.IsStick then
					if v35.StickAction then
						fn10(v35)
					end
				elseif v25.Mapping.TouchPad or v35.StickAction then
					if
						(v29 ~= module5.SECTION_ID.POWER_MENU or v35.Action ~= "POWER_MENU")
						and not v35.ExcludePowers
					then
						fn10(v35)
					end
				else
					fn10(v35)
				end
			end

			for _, list in pairs(v33) do
				table.sort(list, function(a, b)
					if a.SortIndex == nil or b.SortIndex == nil or a.SortIndex == b.SortIndex then
						return a.Label < b.Label
					end

					return a.SortIndex < b.SortIndex
				end)
			end

			local result = {}

			local function fn11(list)
				for i = 1, #list do
					table.insert(result, list[i])
				end
			end

			if #v33.AIMING > 0 then
				table.insert(result, {
					Label = "/Lotus/Language/Menu/InputAimingOrCamera",
					Type = module.TITLE
				})
				fn11(v33.AIMING)
			end

			if #v33.MOVEMENT > 0 then
				table.insert(result, {
					Label = "/Lotus/Language/Menu/InputMovement",
					Type = module.TITLE
				})
				fn11(v33.MOVEMENT)
			end

			if #v33.WEAPONS > 0 then
				table.insert(result, {
					Label = "/SF/Language/Categories/Weapon",
					Type = module.TITLE
				})
				fn11(v33.WEAPONS)
			end

			if #v33.ABILITIES > 0 then
				table.insert(result, {
					Label = "/Lotus/Language/Menu/MenuAbilities",
					Type = module.TITLE
				})
				fn11(v33.ABILITIES)
			end

			if #v33.ACTIONS > 0 then
				table.insert(result, {
					Label = "/Lotus/Language/Menu/ArtifactCards_ActionsTitle",
					Type = module.TITLE
				})
				fn11(v33.ACTIONS)
			end

			if #v33.MISC > 0 then
				table.insert(result, { Label = "/SF/Language/Categories/Misc", Type = module.TITLE })
				fn11(v33.MISC)
			end

			if #result > 0 then
				local v35

				if Engine.__wf_atom_fc67ba71() or Engine.IsPlayingWithController() then
					v35 = nil
				else
					v35 = __wf_atom_8e4fda44:__wf_atom_5707e854()
					__wf_atom_8e4fda44:__wf_atom_91df2e50(v8 and 2 or 1)
				end

				v32 = mMovie:PushChildMovie(genericMenuScreen)

				if not __wf_atom_7e8ad928(v32) then
					v32:Execute("SetTitle", "")
					v2 = true

					for _, v36 in ipairs(result) do
						local label = v36.Label
						local mRightText = ""
						local action = v36.Action
						local invert = v36.Invert == true

						if action ~= nil then
							for _, v39 in pairs(v31) do
								local data = v39.Data
								local data2 = v39.Data2

								if not (data and data.Action == action and (data.Invert == true) == invert or data2 and data2.Action == action and (data2.Invert == true) == invert) then
									continue
								end

								local button = v39.Mapping.Button

								if not button then
									break
								end

								local v40 = "<" .. button .. ">"
								local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v40, true)

								if __wf_atom_8e9ac384 ~= v40 then
									mRightText = __wf_atom_8e9ac384
								end

								break
							end
						end

						v36.mName = label
						v36.mRightText = mRightText
						v36.mSelected = false
						v36.mFocused = false
					end

					function _T.MenuSelectionDone(list)
						if v35 ~= nil then
							__wf_atom_8e4fda44:__wf_atom_91df2e50(v35)
						end

						v2 = false

						if list[1] == nil or list[1].Type ~= nil then
							fn9(not v27)
						else
							v26 = list[1]

							if v25 then
								fn9(not v27)
							end
						end
					end

					v32:Execute("SetCallBack", "MenuSelectionDone")

					function _T.GetMenuEntries()
						return result
					end

					v32:Execute("SetElementsFunction", "GetMenuEntries")
				end
			else
				module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_NoActionsInConfig", true))
				v27 = not v27
			end
		end
	else
		if v26 ~= nil and v25 ~= nil then
			local v33 = {}
			local v34 = -1

			for k, v35 in pairs(v31) do
				if v35.Mapping == v25.Mapping then
					v34 = k
				elseif v26.IsArchwing then
					if v35.Data2 and v35.Data2.Action == v26.Action and v35.Data2.Invert == v26.Invert then
						table.insert(v33, k)
					end
				elseif v35.Data and v35.Data.Action == v26.Action and v35.Data.Invert == v26.Invert then
					table.insert(v33, k)
				end
			end

			if v34 ~= -1 then
				local v35 = v31[v34]

				if #v33 > 0 then
					for i = #v33, 1, -1 do
						local v36 = v31[v33[i]]
						local flag3 = true
						local flag4 = true

						if v35.Data2 and v36.Data2 then
							if v26.IsArchwing then
								flag3 = false
							else
								flag4 = false
							end
						end

						if i == 1 then
							if flag3 then
								local data = v35.Data
								local data2 = v36.Data
								v36.Data = data
								v35.Data = data2
							end

							if flag4 then
								local data2 = v35.Data2
								local data2_2 = v36.Data2
								v36.Data2 = data2
								v35.Data2 = data2_2
							end
						else
							if flag3 then
								v36.Data = v35.Data
							end

							if flag4 then
								v36.Data2 = v35.Data2
							end
						end

						if v36.Mapping and v36.Data and v36.Data.Action == "AIM_POWER" then
							local button = v36.Mapping.Button

							for _, v37 in pairs(v18) do
								if not (v37.Data and button == v37.Mapping.Button) then
									continue
								end

								v36.Data = nil
								module2.ShowMessage(mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/Input_CannotRebindSpectralSight",
									true
								))
							end
						end

						if not (v35.Mapping and v35.Data and v35.Data.Action == "AIM_POWER") then
							continue
						end

						local button = v35.Mapping.Button

						for _, v37 in pairs(v18) do
							if not (v37.Data and button == v37.Mapping.Button) then
								continue
							end

							v35.Data = nil
							module2.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Input_CannotRebindSpectralSight",
								true
							))
						end
					end
				else
					if v26.IsArchwing then
						v35.Data2 = v26
					else
						v35.Data = v26
					end

					if v26 and v26.Action == "AIM_POWER" then
						local button = v35.Mapping.Button

						for _, v36 in pairs(v18) do
							if not (v36.Data and button == v36.Mapping.Button) then
								continue
							end

							v35.Data = nil
							module2.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Input_CannotRebindSpectralSight",
								true
							))
						end
					end
				end

				if v29 == module5.SECTION_ID.GENERAL then
					local v36 = nil

					for _, v38 in pairs(v17) do
						if not (v38.Data and v38.Data.Action == "POWER_MENU") then
							continue
						end

						v36 = v38
						break
					end

					if v36 then
						local v38 = nil
						local v39 = nil

						for _, v40 in pairs(v18) do
							if v40.Mapping == v36.Mapping then
								v38 = v40
							elseif v40.Data and v40.Data.Action == "POWER_MENU" then
								v39 = v40
							end
						end

						assert(v38)

						if v39 then
							v39.Data = v38.Data
						end

						v38.Data = v36.Data
					end
				end
			end
		end

		fn6(v29)
		v26 = nil
		v25 = nil
		flag2 = true
	end
end

local function fn10()
	local module6 = require("EE.Interface.Components.List")
	v9 = module6.CreateList(mMovie, "ControllerMapping.ButtonMapping1")
	v9.mForcedVerticalSeparation = 40
	v9.mElementTransitionTime = 0
	v9.mWrapAroundNavigation = false
	v9:SetCallbacks("KeyBindingPressed", "KeyBindingFocused", "KeyBindingUnfocused")

	function v9.OnFocusChanged(data, p)
		local color = module4.GetColor(module2.Ternary(p, 10, 9), true)

		if data.mOverrideClipName then
			mMovie:__wf_atom_4c1c1986(data.mOverrideClipName, "Label", 44, color)
			return
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "Tf", 44, color)

		if data.Mapping.AnchorIndex ~= nil then
			mMovie:__wf_atom_2dedec1a("ControllerMapping.KeyAnchor" .. data.Mapping.AnchorIndex, 13, p)
			mMovie:__wf_atom_2dedec1a("ControllerMapping.Ring" .. data.Mapping.AnchorIndex, 13, p)
		end
	end

	function v9.mOnFocusedCallback(p)
		module2.PlaySound(_G.UISound_Focus)
		v9.OnFocusChanged(p, true)
	end

	function v9.mOnUnfocusedCallback(p)
		v9.OnFocusChanged(p, false)
	end

	function v9.mOnSelectedCallback(p)
		v25 = p

		if v25 then
			module2.PlaySound(_G.UISound_Select)
			fn9(not v27)
		end
	end

	v9._List_CalculateX = v9.CalculateX

	function v9.CalculateX(_, p)
		if p.PosX then
			return p.PosX
		end

		return v9:_List_CalculateX(p)
	end

	v9._List_CalculateY = v9.CalculateY

	function v9.CalculateY(_, p)
		if p.PosY then
			return p.PosY
		end

		return v9:_List_CalculateY(p)
	end

	function v9.mElementDrawCallback(data)
		local count = 0
		local v33 = ""
		local v34 = 100
		local focusedElement = v9:GetFocusedElement()
		local v35 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id

		if __wf_atom_7e8ad928(data.Data) then
			if __wf_atom_7e8ad928(data.Data2) then
				count += 1
				v33 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NotAvailable", false)
				v34 = 60
			end
		else
			count += 1
			v33 ..= data.Data.Label

			if Engine.__wf_atom_5f0554d9() and data.Data.Action == "NEXT_INV" then
				count += 1
				v33 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/HoldForMeleeMode", false)
			end
		end

		if not __wf_atom_7e8ad928(data.Data2) then
			count += 1
			v33 ..= "\r\n" .. data.Data2.Label
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v33, true)

		if isRemotePlay and data.Mapping.Button == "GAMEPAD_SELECT" then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Share", false)
			v34 = 100
		end

		local color = module4.GetColor(module2.Ternary(v35, 10, 9), true)

		if data.mOverrideClipName then
			mMovie:__wf_atom_48bd5a59(data.mOverrideClipName, "Label", 46, "center")
			mMovie:__wf_atom_48bd5a59(data.mOverrideClipName, "Label", 36, __wf_atom_8e9ac384)
			mMovie:__wf_atom_4c1c1986(data.mOverrideClipName, "Label", 44, color)
			mMovie:__wf_atom_e57658c2(data.mOverrideClipName, 12, v34)
		else
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Tf", 46, "center")
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Tf", 36, __wf_atom_8e9ac384)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Tf", 44, color)

			if data.Mapping.TextAlign then
				mMovie:__wf_atom_48bd5a59(data.mClipName, "Tf", 45, data.Mapping.TextAlign)
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Tf", 41)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn1", 15, __wf_atom_5e6e15c8 + 5)
			mMovie:__wf_atom_e57658c2(data.mClipName, 12, v34)
		end
	end
end

local function fn11()
	if Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(v4) then
		local settings = v4:Settings()
		local ternary = module2.Ternary(Engine.__wf_atom_84bb79c2(), settings:__wf_atom_2203c0db() + 1, 0)
		local v33 = __wf_atom_c67f9605:__wf_atom_ee321bee() <= ternary and 0 or ternary
		settings:__wf_atom_f1bb918d(v33)
		gClient:__wf_atom_fb095a34()

		for i = 1, #v16 do
			for j = 1, #v16[i] do
				__wf_atom_8e4fda44:__wf_atom_b2822ea0(v16[i][j].Action, isRemotePlay)
			end

			fn5(i)
		end

		fn6(v29)
		local v34 = "/Lotus/Language/Menu/ControllerConfig" .. v33 .. "Title"

		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384(v34, false), nil, true)
		end
	end
end

function RestoreDefaultBindings()
	module2.PlaySound(_G.UISound_Select)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 5
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_DefaultsConfirm", false)
	dialogSettings.firstString = "/Lotus/Language/Menu/CategoryAll"
	dialogSettings.secondString = v5.mSelectedElement.Name
	dialogSettings.thirdString = "/Lotus/Language/Menu/NavBar_Cancel"
	dialogSettings:SetCallback("ConfirmRestoreDefaultBindings")
	module2.ShowCustomMessage(dialogSettings)
end

local function fn12()
	if not fn7("JUMP") then
		module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Error_ActionNotbound", true, {
			ACTION = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_JUMP", true)
		}))
		return false
	end

	if not fn7("AIM_POWER") then
		module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Error_ActionNotbound", true, {
			ACTION = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_AIM_POWER", true)
		}))
		return false
	end

	if fn7("USE") then
		return true
	end

	module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Error_NoContextActionBound", true))
	return false
end

local function fn13()
	if not v2 and fn12() then
		if flag2 then
			module2.ShowYesOrNoMessage("/Lotus/Language/Menu/Global_DiscardChangesConfirm", "SaveChanges")
		else
			fn4()
		end
	end
end

function GoBack()
	fn13()
end

local function fn14()
	table.insert(v, {})
	v[1].mVisible = true
	v[1].mLabel = "/Lotus/Language/Menu/Back"

	v[1].mCallback = function()
		mMovie:Execute("GoBack", "")
	end

	v[1].mCallout = "MENU_CANCEL"
	table.insert(v, {})
	v[2].mVisible = true
	v[2].mLabel = "/Lotus/Language/Menu/Global_Defaults"

	v[2].mCallback = function()
		mMovie:Execute("RestoreDefaultBindings", "")
	end

	v[2].mCallout = "MENU_GENERIC1"
	table.insert(v, {})
	v[3].mVisible = false
	v[3].mLabel = "/Lotus/Language/Menu/Global_ChangeConfigs"
	v[3].mCallback = fn11
	v[3].mCallout = "MENU_GENERIC2"
end

local function fn15()
	if v12 == nil then
		v12 = mMovie:__wf_atom_5e6e15c8("ControllerMapping", 0)
		v13 = mMovie:__wf_atom_5e6e15c8("ControllerArt", 0)
		v14 = mMovie:__wf_atom_5e6e15c8("Powers", 0)
	end

	local module6 = require("Lotus.Interface.Components.ThemedCategoriesMenu")
	v5 = module6.Create(mMovie, "CategoryMenu")
	v5.mAlign = module2.LEFT_ALIGNED
	v5.mShowCallouts = false
	v5.mDisplayMode = v5.Modes.TEXT

	function v5.mOnSelectedCallback(p)
		v2 = true
		local ternary = module2.Ternary(v29 ~= nil, v29, 0)
		local ternary2 = module2.Ternary(p.Section < ternary, -1, 1)
		__wf_atom_ec43d06e(mMovie, "ControllerArt", 2, { 12, 0 }, { 0, v13 + 400 * ternary2 }, 0.15)
		local v33 = __wf_atom_9a2b0be4("Graphics.DeviceIconType")
		local __wf_atom_5707e854 = __wf_atom_8e4fda44:__wf_atom_5707e854()
		local __wf_atom_e43a530e = Engine.__wf_atom_e43a530e()

		if not __wf_atom_e43a530e then
			if v33 == "DIT_PS4" or v33 == "DIT_PS5" then
				__wf_atom_e43a530e = true
			elseif v33 == "DIT_AUTO" then
				__wf_atom_e43a530e = __wf_atom_5707e854 == 2 or __wf_atom_5707e854 == 6
			else
				__wf_atom_e43a530e = false
			end
		end

		if __wf_atom_e43a530e then
			__wf_atom_ec43d06e(mMovie, "Powers", 2, { 12, 0 }, { 0, v14 + 400 * ternary2 }, 0.15)
		end

		__wf_atom_ec43d06e(mMovie, "ControllerMapping", 2, { 12, 0 }, { 0, v12 + 400 * ternary2 }, 0.15, 0, function()
			fn6(p.Section)
			mMovie:__wf_atom_e57658c2("ControllerArt", 0, v13 - 400 * ternary2)
			mMovie:__wf_atom_e57658c2("ControllerMapping", 0, v12 - 400 * ternary2)
			local v34 = __wf_atom_9a2b0be4("Graphics.DeviceIconType")
			local __wf_atom_5707e854_2 = __wf_atom_8e4fda44:__wf_atom_5707e854()
			local __wf_atom_e43a530e2 = Engine.__wf_atom_e43a530e()

			if not __wf_atom_e43a530e2 then
				if v34 == "DIT_PS4" or v34 == "DIT_PS5" then
					__wf_atom_e43a530e2 = true
				elseif v34 == "DIT_AUTO" then
					__wf_atom_e43a530e2 = __wf_atom_5707e854_2 == 2 or __wf_atom_5707e854_2 == 6
				else
					__wf_atom_e43a530e2 = false
				end
			end

			if __wf_atom_e43a530e2 then
				mMovie:__wf_atom_e57658c2("Powers", 0, v14 - 400 * ternary2)
				__wf_atom_ec43d06e(mMovie, "Powers", 2, { 12, 0 }, { 100, v14 }, 0.3, 0.25)
			end

			__wf_atom_ec43d06e(mMovie, "ControllerArt", 2, { 12, 0 }, { 100, v13 }, 0.3, 0.25)
			__wf_atom_ec43d06e(mMovie, "ControllerMapping", 2, { 12, 0 }, { 100, v12 }, 0.3, 0.25, function()
				v2 = false
			end)
		end)
		module2.PlaySound(_G.UISound_Select)
	end

	v5:AddElement(
		{
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GeneralBindings", true),
			Section = module5.SECTION_ID.GENERAL
		},
		true
	)

	if not isRemotePlay then
		v5:AddElement(
			{
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Input_AIM_POWER", true),
				Section = module5.SECTION_ID.POWER_MENU
			},
			true
		)
		v5:AddElement(
			{
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MusicTitle", true),
				Section = module5.SECTION_ID.SHAWZIN
			},
			true
		)
	end

	v5:Redraw()
	v5:FocusElement(1)
	v5:SelectCurrentElement()
end

function Shutdown()
	if not __wf_atom_7e8ad928(v32) then
		v32:Close()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if not (__wf_atom_7e8ad928(gGameRules) or gGameRules:Paused()) then
		gGameRules:IsA(__wf_atom_311a7128)
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			if v10 then
				__wf_atom_c4f78a8f:__wf_atom_e424c72a(true)
			end

			local cameraControl = __wf_atom_c4f78a8f:CameraControl()

			if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v11)) then
				cameraControl:SetCameraSpot(v11, 0)
			end
		end
	end
end

function Initialize()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	v4 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	v28 = 0
	local v33 = (isRemotePlay or not (__wf_atom_c67f9605:__wf_atom_ee321bee() > 1))
		and "/Lotus/Language/Menu/ControllerMappingTitle"
		or "/Lotus/Language/Menu/ControllerConfig" .. v28 .. "Title"

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384(v33, false))
	end

	if __wf_atom_7e8ad928(_T.ShowBackground) then
		mMovie:__wf_atom_0cf0fdbe(module4.MovieBackgroundAlpha)
		mMovie:__wf_atom_7df746cd(module4.MovieBackgroundColor)
	else
		_T.ShowBackground(0.25, nil, false)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v10 = __wf_atom_c4f78a8f:__wf_atom_f63d17c0()

		if v10 then
			__wf_atom_c4f78a8f:__wf_atom_e424c72a(false)
		end

		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			v11 = cameraControl:__wf_atom_4cd347da()

			if not __wf_atom_7e8ad928(v11) then
				cameraControl:SetCameraSpot(nil, 0)
			end
		end
	end

	if Engine.__wf_atom_b290ec01() or __wf_atom_9a2b0be4("Graphics.DeviceIconType") == "DIT_SWITCH" then
		local v34

		if __wf_atom_7e8ad928(gRegion) then
			v34 = "Console"
		else
			local __wf_atom_1dce657a = gRegion:__wf_atom_1dce657a(0)
			v34 = module2.Ternary(__wf_atom_1dce657a == 1, "Console", "Pro")
		end

		__wf_atom_86cbd68d(mMovie, "ControllerArt.gotoAndStop", v34)
		__wf_atom_86cbd68d(mMovie, "ControllerMapping.gotoAndStop", v34)
	end

	mMovie:__wf_atom_7d7314f1("ConfigurationLabel.text", "/Lotus/Language/Menu/ConfigurationLabel")
	mMovie:__wf_atom_2dedec1a("CancelButton", 13, false)
	mMovie:__wf_atom_2dedec1a("RestoreButton", 13, false)
	fn14()
	fn8()

	for i = 1, #module5.BINDINGS do
		local v34 = {}

		for k, v35 in pairs(module5.BINDINGS[i]) do
			v34[k] = v35
		end

		v16[i] = v34
	end

	if Engine.__wf_atom_b290ec01() or Engine.__wf_atom_e43a530e() then
		table.insert(v16[module5.SECTION_ID.GENERAL], {
			Label = "/Lotus/Language/Menu/Motion_Snap_Camera",
			Action = "MOTION_CAMERA_SNAP",
			ExcludePowers = true
		})
		table.insert(v16[module5.SECTION_ID.RAILJACK], {
			Label = "/Lotus/Language/Menu/Input_CENTER_VIEW",
			Action = "MOTION_CAMERA_SNAP",
			ExcludePowers = true,
			Invert = false
		})
	end

	for i = 1, #v16 do
		for j = 1, #v16[i] do
			v16[i][j].Label = mMovie:__wf_atom_8e9ac384(v16[i][j].Label, false)
		end
	end

	v24 = module5.GetControllerButtonLayout(isRemotePlay)
	local color = module4.GetColor(9, true)

	for i = 1, #v24 do
		if v24[i].AnchorIndex == nil then
			continue
		end

		mMovie:__wf_atom_2dedec1a("ControllerMapping.KeyAnchor" .. v24[i].AnchorIndex, 13, false)
		mMovie:__wf_atom_2dedec1a("ControllerMapping.Ring" .. v24[i].AnchorIndex, 13, false)
		mMovie:__wf_atom_e57658c2("ControllerMapping.KeyAnchor" .. v24[i].AnchorIndex, 11, color)
		mMovie:__wf_atom_e57658c2("ControllerMapping.Ring" .. v24[i].AnchorIndex, 11, color)
	end

	mMovie:__wf_atom_e57658c2("ControllerMapping.Lines", 11, color)
	mMovie:OverrideMaterial("ControllerArt", colorRemapMaterial)
	local color2 = module4.GetColor(2)
	local color3 = module4.GetColor(6)
	mMovie:__wf_atom_1ca72041("ControllerArt", "StartColor", color2.red / 255, color2.green / 255, color2.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("ControllerArt", "EndColor", color3.red / 255, color3.green / 255, color3.blue / 255, 1)
	mMovie:OverrideMaterial("ControllerMapping.Lines", lineMaterial)
	mMovie:__wf_atom_1ca72041(
		"ControllerMapping.Lines",
		"RipplesColor",
		color3.red / 255,
		color3.green / 255,
		color3.blue / 255,
		0.4
	)
	mMovie:__wf_atom_e57658c2("Powers.Background", 11, color2:__wf_atom_dcecedb0())
	mMovie:__wf_atom_7d7314f1(
		"Powers.Title.text",
		"/Lotus/Language/Menu/" .. module2.Ternary(
			isRemotePlay,
			"PS4_ControllerMappingTouchScreenTitle",
			"PS4_ControllerMappingTouchPadTitle"
		)
	)
	mMovie:__wf_atom_e57658c2("Powers.Title", 11, color)
	mMovie:__wf_atom_7d7314f1("Powers.RearTitle.text", "/Lotus/Language/Menu/PS4_ControllerMappingRearTouchPadTitle")
	mMovie:__wf_atom_e57658c2("Powers.RearTitle", 11, color)

	for i = 1, 5 do
		mMovie:__wf_atom_e57658c2("Powers.PadIcon" .. tostring(i), 11, color)
	end

	for i = 1, 4 do
		mMovie:__wf_atom_e57658c2("Powers.RearPadIcon" .. tostring(i), 11, color)
	end

	module3.DrawSeparator(mMovie, "Powers.Separator", 120)
	mMovie:__wf_atom_e57658c2("Powers.Separator", 11, color)
	fn5(module5.SECTION_ID.GENERAL)

	if not isRemotePlay then
		fn5(module5.SECTION_ID.POWER_MENU)
		fn5(module5.SECTION_ID.LUNARO)
		fn5(module5.SECTION_ID.PLACEMENT)
		fn5(module5.SECTION_ID.FRAME_FIGHTER)
		fn5(module5.SECTION_ID.RAILJACK)
		fn5(module5.SECTION_ID.SHAWZIN)
	end

	fn10()
	fn15()
	mMovie:__wf_atom_e57658c2("Lines", 12, 100)
	mMovie:__wf_atom_e57658c2("ButtonMappings", 12, 100)
	mMovie:__wf_atom_e57658c2("ControllerArt", 12, 100)
	mMovie:__wf_atom_e57658c2("Powers", 12, 100)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	local v34 = __wf_atom_9a2b0be4("Graphics.DeviceIconType")
	local __wf_atom_5707e854 = __wf_atom_8e4fda44:__wf_atom_5707e854()
	local __wf_atom_e43a530e = Engine.__wf_atom_e43a530e()

	if not __wf_atom_e43a530e then
		if v34 == "DIT_PS4" or v34 == "DIT_PS5" then
			__wf_atom_e43a530e = true
		elseif v34 == "DIT_AUTO" then
			__wf_atom_e43a530e = __wf_atom_5707e854 == 2 or __wf_atom_5707e854 == 6
		else
			__wf_atom_e43a530e = false
		end
	end

	v8 = __wf_atom_e43a530e
	mMovie:__wf_atom_2dedec1a("Powers", 13, v8)
	fn3()
	v3 = true
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v3 then
		return
	end

	if flag then
		mMovie:Close()
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if v6 and __wf_atom_7e8ad928(v7) then
		v6 = false
		fn4()
	end
end

function TransitionOut()
	fn4()
end

function ConfirmRestoreDefaultBindings(p)
	local v33 = tonumber(p)

	if v33 == 4 or v33 == 6 then
		if not __wf_atom_7e8ad928(v4) then
			v4:Settings():__wf_atom_f1bb918d(0)
		end

		gClient:__wf_atom_fb095a34()
		flag2 = true

		if v33 == 4 then
			fn5(module5.SECTION_ID.GENERAL, true)

			if not isRemotePlay then
				fn5(module5.SECTION_ID.POWER_MENU, true)
				fn5(module5.SECTION_ID.LUNARO, true)
				fn5(module5.SECTION_ID.PLACEMENT, true)
				fn5(module5.SECTION_ID.FRAME_FIGHTER, true)
				fn5(module5.SECTION_ID.RAILJACK, true)
				fn5(module5.SECTION_ID.SHAWZIN, true)
			end
		else
			fn5(v29, true)
		end

		fn6(v29)
	end
end

function OnProfileSaved(p)
	print("ControllerLayout::OnProfileSaved")

	if not p then
		print("ERROR: Profile failed to save")
	end

	if __wf_atom_7e8ad928(v7) then
		fn4()
	else
		v7:Execute("Finished", "")
	end
end

local function fn16()
	local v33 = {
		Filters = { defaultFilter, meleeFilter, archwingFilter, duviriMeleeFilter },
		Bindings = v16[module5.SECTION_ID.GENERAL]
	}
	local v34 = {
		Filters = { powerMenuFilter },
		Bindings = v16[module5.SECTION_ID.POWER_MENU]
	}
	local v35 = {
		Filters = { lunaroFilter },
		Bindings = v16[module5.SECTION_ID.LUNARO]
	}
	local v36 = {
		Filters = { placementFilter },
		Bindings = v16[module5.SECTION_ID.PLACEMENT]
	}
	local v37 = {
		Filters = { frameFighterFilter },
		Bindings = v16[module5.SECTION_ID.FRAME_FIGHTER]
	}
	local v38 = {
		Filters = { railjackFilter },
		Bindings = v16[module5.SECTION_ID.RAILJACK]
	}
	local v39 = {
		Filters = { shawzinFilter },
		Bindings = v16[module5.SECTION_ID.SHAWZIN]
	}

	for _, v40 in ipairs({ v33, v34, v35, v36, v37, v38, v39 }) do
		local filters = v40.Filters
		local bindings = v40.Bindings

		for _, binding in ipairs(bindings) do
			if binding.ReadOnly then
				continue
			end

			local action = binding.Action
			local invert = binding.Invert == true

			for _, filter in ipairs(filters) do
				mMovie:__wf_atom_042a8818(action, 0, invert, filter, true)
			end
		end
	end
end

local function fn17(action, button, invert, p, p2, object)
	local v33, v34 = action:gsub("LOOK_X", "LOOK_Y")

	if v34 == 0 then
		local v35
		v33, v35 = action:gsub("MOVE_X", "MOVE_Z")

		if v35 == 0 then
			return false
		else
			invert = true
		end
	end

	local v35, v36 = button:gsub("_([LR])X", "_%1Y")
	assert(v36 ~= 0)
	object:AddInputBinding(v33, v35, invert, p, p2)
	return true
end

local function fn18()
	if __wf_atom_7e8ad928(v4) then
		return
	end

	fn16()
	local v33 = fn()
	local settings = v4:Settings()
	settings:__wf_atom_7e1a90c3(v33)

	for _, v34 in pairs(v17) do
		local data = v34.Data
		local mapping = v34.Mapping

		if data then
			local action = data.Action
			local invert = data.Invert == true
			local button = mapping.Button

			if not fn17(action, button, invert, defaultFilter, v33, settings) then
				if action == "POWER_MENU" then
					settings:AddInputBinding("POWER_MENU", button, invert, powerMenuFilter, v33)
				elseif action == "SECONDARY_FIRE" then
					settings:AddInputBinding("MELEE_CHANNEL", button, invert, meleeFilter, v33)
				elseif data.IsDuviriMelee then
					settings:AddInputBinding(action, button, invert, duviriMeleeFilter, v33)
				end
			end

			settings:AddInputBinding(action, button, invert, defaultFilter, v33)
		end

		local data2 = v34.Data2

		if data2 then
			settings:AddInputBinding(data2.Action, mapping.Button, data2.Invert == true, archwingFilter, v33)
		end
	end

	for _, v34 in pairs(v18) do
		local data = v34.Data
		local mapping = v34.Mapping

		if not data then
			continue
		end

		local action = data.Action

		if action ~= "POWER_MENU" then
			settings:AddInputBinding(action, mapping.Button, false, powerMenuFilter, v33)
		end
	end

	for _, v34 in pairs(v19) do
		local data = v34.Data
		local mapping = v34.Mapping

		if not data then
			continue
		end

		local action = data.Action
		local button = mapping.Button
		local invert = data.Invert == true
		fn17(action, button, invert, lunaroFilter, v33, settings)
		settings:AddInputBinding(action, button, invert, lunaroFilter, v33)
	end

	for _, v34 in pairs(v20) do
		local data = v34.Data
		local mapping = v34.Mapping

		if not data then
			continue
		end

		local action = data.Action
		local button = mapping.Button
		local invert = data.Invert == true
		fn17(action, button, invert, placementFilter, v33, settings)
		settings:AddInputBinding(action, button, invert, placementFilter, v33)
	end

	for _, v34 in pairs(v21) do
		local data = v34.Data
		local mapping = v34.Mapping

		if not data then
			continue
		end

		local action = data.Action
		local button = mapping.Button
		local invert = data.Invert == true
		fn17(action, button, invert, frameFighterFilter, v33, settings)
		settings:AddInputBinding(action, button, invert, frameFighterFilter, v33)
	end

	for _, v34 in pairs(v22) do
		local data = v34.Data
		local mapping = v34.Mapping

		if not data then
			continue
		end

		local action = data.Action
		local button = mapping.Button
		local invert = data.Invert == true
		fn17(action, button, invert, railjackFilter, v33, settings)
		settings:AddInputBinding(action, button, invert, railjackFilter, v33)
	end

	for _, v34 in pairs(v23) do
		local data = v34.Data

		if not data or data.ReadOnly then
			continue
		end

		settings:AddInputBinding(data.Action, v34.Mapping.Button, data.Invert == true, shawzinFilter, v33)
	end

	settings:__wf_atom_6b99bafa(false)

	if Engine.__wf_atom_e43a530e() then
		settings:__wf_atom_6b99bafa(true)
	end

	__wf_atom_8e4fda44:__wf_atom_8ef89e30()
end

function SaveChanges(p)
	if tonumber(p) ~= 4 then
		fn4()
		return
	end

	v2 = true
	fn18()
	__wf_atom_8e4fda44:__wf_atom_8cd74846()

	if not __wf_atom_7e8ad928(saveSpinnerMovie) then
		v6 = true
		v7 = mMovie:PushChildMovie(saveSpinnerMovie)
		v7:Execute("SetMessage", "/Menu/CheckPoint")
	end

	__wf_atom_dd7f4712(v4:__wf_atom_9be88b01(), "OnProfileSaved")
	__wf_atom_a0f6588f:__wf_atom_507ce99c(0, "OnProfileSaved")
end

function onKeyDown_MENU_SELECT()
	if not v2 then
		v9:SelectCurrentElement()
	end
end

function KeyBindingPressed(p)
	if not (v2 or __wf_atom_7e8ad928(v9)) then
		v9:SelectElementById((tonumber(p)))
	end
end

function KeyBindingFocused(p)
	if not (v2 or __wf_atom_7e8ad928(v9)) then
		v9:FocusElementById((tonumber(p)))
	end
end

function KeyBindingUnfocused(p)
	if not (v2 or __wf_atom_7e8ad928(v9)) then
		v9:UnfocusElementById((tonumber(p)))
	end
end

function IsInputBlocked()
	return v2
end

function onViewportSizeChanged(_, _, _, _)
	local screenDimensions, v33 = module2.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("BackgroundBlur", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("BackgroundBlur", 0, 0)
	mMovie:__wf_atom_e57658c2("BackgroundBlur", 15, v33)
	mMovie:__wf_atom_e57658c2("BackgroundBlur", 1, 0)
end

function CategoryFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (v2 or __wf_atom_7e8ad928(v5)) then
		v5:SelectElementById((tonumber(p)))
	end
end

function OnGamepadTransition(p) end

function SupportsThemes()
	return true
end