local module = require("Lotus.Interface.UIUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local v = {
	{ Slot = 1, Key = "<SELECT_SUB_GEAR_0>", Page = 0, Index = nil },
	{ Slot = 2, Key = "<SELECT_SUB_GEAR_1>", Page = 0, Index = nil },
	{ Slot = 3, Key = "<SELECT_SUB_GEAR_2>", Page = 0, Index = nil }
}
local v2 = {
	{ Clip = "Callout", Alpha = 100 },
	{ Clip = "BraceLeft", Alpha = 50 },
	{ Clip = "BraceRight", Alpha = 50 },
	{ Clip = "CalloutBg", Alpha = 90 }
}
local v3 = false
local v4 = {}
local v5 = false
local flag = false
local v6 = false
local classicControls = false
local flag2 = false
local total = 0
local total2 = 0
local v7 = nil
local v8 = -1
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil

local function fn()
	if __wf_atom_7e8ad928(v9) then
		return
	end

	local v13 = v10
	v10 = v9:__wf_atom_d2b2176d():__wf_atom_84479917()

	if v13 ~= v10 then
		if v13 ~= nil then
			local ternary = module2.Ternary(v13, flightInputFilter, inputFilter)
			v9:__wf_atom_cf966a74(ternary)
		end

		local ternary = module2.Ternary(v10, flightInputFilter, inputFilter)
		v9:__wf_atom_aeb02c14(ternary)
	end
end

function Shutdown()
	if not __wf_atom_7e8ad928(_T.HUD_RemoveMotionClip) then
		_T.HUD_RemoveMotionClip(mMovie, "Info")
	end

	if not __wf_atom_7e8ad928(_T.HUD_GetAnchorMgr) then
		local HUD_GetAnchorMgr = _T.HUD_GetAnchorMgr()

		if HUD_GetAnchorMgr ~= nil then
			HUD_GetAnchorMgr:Unregister(mMovie, "Info")
		end
	end

	if not __wf_atom_7e8ad928(_T.ShowWeaponPanel) then
		_T.ShowWeaponPanel()
	end

	if not __wf_atom_7e8ad928(_T.ShowAbilityPanel) then
		_T.ShowAbilityPanel()
	end

	if not __wf_atom_7e8ad928(_T.SubGear_GetSubGearLayout) then
		_T.SubGear_GetSubGearLayout = nil
	end

	if not __wf_atom_7e8ad928(v9) then
		local v13 = v10

		if v13 ~= nil then
			local ternary = module2.Ternary(v13, flightInputFilter, inputFilter)
			v9:__wf_atom_cf966a74(ternary)
		end

		local __wf_atom_92aa9d91 = v9:__wf_atom_92aa9d91()

		if not __wf_atom_7e8ad928(__wf_atom_92aa9d91) and __wf_atom_92aa9d91:IsA(lotusInputController) then
			__wf_atom_92aa9d91:__wf_atom_97f06647(false)
		end
	end
end

local function fn2(state)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	local v13

	if state.Index ~= nil then
		v13 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(state.Index, state.Page)
	end

	local v14 = "Info.Slot" .. tostring(state.Slot)
	local v15

	if state.Slot == 1 or state.Index == nil then
		v15 = false
	else
		v15 = not __wf_atom_7e8ad928(v13) and __wf_atom_d2b2176d:__wf_atom_57948ee9(v13) > 1
	end

	mMovie:__wf_atom_7f57ab2f(v14, "Count", 13, v15)
	mMovie:__wf_atom_7f57ab2f(v14, "CountBg", 13, v15)

	if v15 then
		local __wf_atom_b62f2024 = __wf_atom_d2b2176d:__wf_atom_b62f2024(state.Index, state.Page)

		if state.prevCount == nil or __wf_atom_b62f2024 ~= state.prevCount then
			mMovie:__wf_atom_48bd5a59(v14, "Count", 36, "x" .. module2.FormatNumber(__wf_atom_b62f2024))
			local color = module3.GetColor(6, true)
			local color2 = module3.GetColor(12, true)
			mMovie:__wf_atom_4c1c1986(v14, "Count", 44, module2.Ternary(__wf_atom_b62f2024 > 0, color, color2))
			mMovie:__wf_atom_4c1c1986(v14, "Icon", 12, module2.Ternary(__wf_atom_b62f2024 > 0, 100, 40))
			state.prevCount = __wf_atom_b62f2024
		end
	end
end

local function fn3(data)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	local v13

	if data.Index ~= nil then
		v13 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(data.Index, data.Page)
	end

	local v14 = "Info.Slot" .. tostring(data.Slot)
	mMovie:__wf_atom_7f57ab2f(v14, "Icon", 13, not __wf_atom_7e8ad928(v13))

	if not __wf_atom_7e8ad928(v13) then
		local iconTexture, v15 = module4.GetIconTexture(v13, true)
		mMovie:__wf_atom_c90af43a(v14 .. ".Icon", iconTexture)
		mMovie:__wf_atom_4c1c1986(v14, "Icon", 15, module2.Ternary(v15, 124, 83))
	end

	local color = module3.GetColor(2, true)
	local color2 = module3.GetColor(9, true)
	mMovie:__wf_atom_4c1c1986(v14, "CalloutBg", 11, color)
	mMovie:__wf_atom_4c1c1986(v14, "CountBg", 11, color)
	mMovie:__wf_atom_4c1c1986(v14, "BraceLeft", 11, color2)
	mMovie:__wf_atom_4c1c1986(v14, "BraceRight", 11, color2)
	mMovie:__wf_atom_4c1c1986(v14, "Callout", 44, color2)
	fn2(data)
end

local function fn4(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	if not p then
		if __wf_atom_7e8ad928(v11) and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9:__wf_atom_d2b2176d())) then
			v11 = v9:__wf_atom_d2b2176d():__wf_atom_3999e0fb()
		end

		local v13 = v11

		if __wf_atom_7e8ad928(v13) then
			print("SubGearHud: No sub gear selector found on inventory controller")
		else
			local __wf_atom_e883908f = v13:__wf_atom_e883908f()
			local __wf_atom_68fc1021 = v13:__wf_atom_68fc1021()
			local v14 = {}

			for i, _ in ipairs(__wf_atom_e883908f) do
				v14[i] = 0
			end

			flag = false

			for i = 1, __wf_atom_d2b2176d:__wf_atom_62abd325(__wf_atom_68fc1021) do
				local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i - 1, __wf_atom_68fc1021)

				if
					__wf_atom_d2b2176d:__wf_atom_b62f2024(i - 1, __wf_atom_68fc1021) == 0
					or __wf_atom_7e8ad928(__wf_atom_ba1c3957)
				then
					continue
				end

				for j, v15 in ipairs(__wf_atom_e883908f) do
					if __wf_atom_ba1c3957:IsA(v15.filter) then
						v14[j] += 1
					end
				end

				for _, v15 in ipairs(v14) do
					if v15 > 1 then
						flag = true
					end
				end

				if flag then
					break
				end
			end
		end
	end

	local v13 = ""
	local v14

	if v6 and not classicControls then
		v14 = not v5 and "/Lotus/Language/Menu/FishHud_ControllerHint"
			or flag and "/Lotus/Language/Menu/FishHud_Hint"
			or v13
	else
		v14 = flag and "/Lotus/Language/Menu/FishHud_Hint" or v13
	end

	mMovie:__wf_atom_7d7314f1("Info.Hint.text", v14)
end

local function fn5()
	if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928((v9:__wf_atom_d2b2176d())) then
		return
	end

	if __wf_atom_7e8ad928(v11) and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9:__wf_atom_d2b2176d())) then
		v11 = v9:__wf_atom_d2b2176d():__wf_atom_3999e0fb()
	end

	local v13 = v11

	if not __wf_atom_7e8ad928(v13) then
		local __wf_atom_e883908f = v13:__wf_atom_e883908f()
		local __wf_atom_68fc1021 = v13:__wf_atom_68fc1021()

		for _, v14 in ipairs(v) do
			v14.Page = __wf_atom_68fc1021
		end

		for i, v14 in ipairs(__wf_atom_e883908f) do
			local selectedIndex = v14.selectedIndex

			if selectedIndex >= 0 then
				v[i].Index = selectedIndex
			end
		end
	end
end

local function fn6()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<POWER_MODIFIER>", true)
	local v13 = __wf_atom_8e9ac384 == "<POWER_MODIFIER>" and "" or __wf_atom_8e9ac384

	for i, v14 in ipairs(v) do
		local v15 = "Info.Slot" .. tostring(v14.Slot) .. "."
		local v16 = i - 1 == v12
		mMovie:__wf_atom_50d60589(v15 .. "Callout", 36, v13)

		for j = 1, #v2 do
			mMovie:__wf_atom_e57658c2(v15 .. v2[j].Clip, 12, module2.Ternary(v16, v2[j].Alpha, 0))
		end
	end
end

local function fn7()
	if v6 and classicControls then
		if __wf_atom_7e8ad928(v11) and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9:__wf_atom_d2b2176d())) then
			v11 = v9:__wf_atom_d2b2176d():__wf_atom_3999e0fb()
		end

		local v13 = v11

		if not __wf_atom_7e8ad928(v13) then
			v12 = v13:__wf_atom_a0ad8b4a()
		end

		fn6()
	else
		v[1].Key = module2.Ternary(v6, "<ACTIVATE_ABILITY_MENU_0>", "<SELECT_SUB_GEAR_0>")
		v[2].Key = module2.Ternary(v6, "<ACTIVATE_ABILITY_MENU_1>", "<SELECT_SUB_GEAR_1>")
		v[3].Key = module2.Ternary(v6, "<ACTIVATE_ABILITY_MENU_2>", "<SELECT_SUB_GEAR_2>")
		local v13 = not v6 or v5

		for _, v14 in ipairs(v) do
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v14.Key, true)
			local v15 = __wf_atom_8e9ac384 == v14.Key and "" or __wf_atom_8e9ac384
			local v16 = "Info.Slot" .. tostring(v14.Slot) .. "."
			mMovie:__wf_atom_50d60589(v16 .. "Callout", 36, v15)

			for i = 1, #v2 do
				mMovie:__wf_atom_e57658c2(v16 .. v2[i].Clip, 12, module2.Ternary(v13, v2[i].Alpha, 0))
			end
		end
	end

	fn4()
end

local function fn8()
	if classicControls then
		_T.ShowWeaponPanel()
		_T.ShowAbilityPanel()
		mMovie:__wf_atom_e57658c2("Info", 12, 0)
	else
		mMovie:__wf_atom_e57658c2("Info", 12, 100)
		_T.HideWeaponPanel()
		_T.HideAbilityPanel()
	end
end

local function fn9()
	local result = {}

	for i = 1, 3 do
		local v13 = "Info.Slot" .. i
		local v14 = {
			x = mMovie:__wf_atom_5e6e15c8(v13 .. ".CallOut", 2) + -50,
			y = mMovie:__wf_atom_5e6e15c8(v13 .. ".CallOut", 3) + 40
		}
		local transformPixelToViewportCoordinates = module2.TransformPixelToViewportCoordinates(mMovie, v14)
		local v15 = v13 .. ".Count"
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v15, 15)
		local _, v16 = module2.TransformPositionToGlobal(mMovie, v15, 0, __wf_atom_5e6e15c8)
		local v17 = mMovie:__wf_atom_5e6e15c8(v13 .. ".Icon", 14) / 2
		local v18 = {
			x = module2.TransformPositionToGlobal(mMovie, v13, v17, 0) + -50,
			y = transformPixelToViewportCoordinates.y + v16 + 40
		}
		local transformPixelToViewportCoordinates2 = module2.TransformPixelToViewportCoordinates(mMovie, v18)
		table.insert(result, {
			topLeft = {
				x = transformPixelToViewportCoordinates.x,
				y = transformPixelToViewportCoordinates.y
			},
			bottomRight = {
				x = transformPixelToViewportCoordinates2.x,
				y = transformPixelToViewportCoordinates2.y
			}
		})
	end

	return result
end

function Initialize()
	if not __wf_atom_7e8ad928(_T.HUD_GetAnchorMgr) then
		local HUD_GetAnchorMgr = _T.HUD_GetAnchorMgr()

		if not __wf_atom_7e8ad928(HUD_GetAnchorMgr) then
			HUD_GetAnchorMgr:Register(mMovie, "Info", {
				HUD_GetAnchorMgr.ANCHOR_V_BOTTOM,
				HUD_GetAnchorMgr.ANCHOR_H_RIGHT
			})
			HUD_GetAnchorMgr:Update(
				mMovie:__wf_atom_d5a50cb5(),
				mMovie:__wf_atom_c4f6543f(),
				true,
				HUD_GetAnchorMgr.mHudScalePadding
			)
		end
	end

	_T.HUD_AddMotionClip(mMovie, "Info")

	if _T.WareframeChallenge then
		mMovie:__wf_atom_2dedec1a("Info", 13, false)
	end

	v6 = Engine.IsPlayingWithController()
	fn7()

	if v6 then
		classicControls = __wf_atom_8e4fda44:__wf_atom_981c3f0b("POWER_MENU") == ""
	end

	if Engine.__wf_atom_2a979d69() then
		_T.SubGear_GetSubGearLayout = fn9
	end

	_T.classicControls = classicControls
	fn8()
	v9 = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(v9) then
		return
	end

	fn()
	fn5()

	for _, v13 in ipairs(v) do
		fn3(v13)
	end

	local __wf_atom_92aa9d91 = v9:__wf_atom_92aa9d91()

	if not __wf_atom_7e8ad928(__wf_atom_92aa9d91) and __wf_atom_92aa9d91:IsA(lotusInputController) then
		__wf_atom_92aa9d91:__wf_atom_97f06647(true)
	end

	fn4()
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_084b3e93())
	v3 = true

	if #v4 > 0 then
		for i = 1, #v4 do
			v4[i][1](v4[i][2])
		end

		v4 = {}
	end

	v3 = false

	if __wf_atom_7e8ad928(v7) then
		v7 = gGameRules:__wf_atom_b56d2aa8()
	end

	if Engine.__wf_atom_2a979d69() then
		mMovie:__wf_atom_e57658c2("_root", 0, -50)
		mMovie:__wf_atom_e57658c2("_root", 1, 40)
	end

	if not __wf_atom_7e8ad928(v7) then
		local __wf_atom_5e6e15c8 = v7:__wf_atom_5e6e15c8("_root", 12)
		local v13 = not v7:__wf_atom_a91463a8("_root", 13) and 0 or __wf_atom_5e6e15c8

		if v8 ~= v13 then
			v8 = v13
			mMovie:__wf_atom_e57658c2("_root", 12, v13)
		end
	end

	fn()

	if v6 then
		local classicControls2 = __wf_atom_8e4fda44:__wf_atom_981c3f0b("POWER_MENU") == ""

		if classicControls ~= classicControls2 then
			_T.classicControls = classicControls2
			classicControls = classicControls2
			fn8()
		end

		if classicControls then
			local v13 = nil

			if
				__wf_atom_7e8ad928(v11)
				and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9:__wf_atom_d2b2176d()))
			then
				v11 = v9:__wf_atom_d2b2176d():__wf_atom_3999e0fb()
			end

			local v14 = v11

			if not __wf_atom_7e8ad928(v14) then
				v13 = v14:__wf_atom_a0ad8b4a()
			end

			if v13 ~= v12 then
				v12 = v13
				fn6()
			end
		end
	elseif classicControls then
		classicControls = false
		v12 = nil
		_T.classicControls = false
		fn8()
	end

	if __wf_atom_7e8ad928(v11) and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9:__wf_atom_d2b2176d())) then
		v11 = v9:__wf_atom_d2b2176d():__wf_atom_3999e0fb()
	end

	if not __wf_atom_7e8ad928(v11) and v11:__wf_atom_62b6bb8c() then
		flag2 = true
		total = 0
		total2 = 0.6
	end

	if flag2 then
		if total2 >= 0.6 then
			fn5()

			for _, v13 in ipairs(v) do
				fn3(v13)
			end

			fn4()
			total2 = 0
		else
			total2 += __wf_atom_084b3e93()
		end

		total += __wf_atom_084b3e93()

		if total >= 2 then
			flag2 = false
		end
	end
end

function HandleHudScale(p)
	module.HandleHudScale(mMovie, (tonumber(p)))
end

function OnPowerModifierHeld(p)
	if not Engine.IsPlayingWithController() or classicControls then
		return
	end

	v5 = p == "true"

	for i = 1, 3 do
		local v13 = "Info.Slot" .. tostring(i)

		for j = 1, #v2 do
			__wf_atom_ec43d06e(
				mMovie,
				v13 .. "." .. v2[j].Clip,
				8,
				{ 12 },
				{ module2.Ternary(v5, v2[j].Alpha, 0) },
				0.25
			)
		end
	end

	fn4(true)
end

function OnGamepadTransition(p)
	v6 = p == "false"
	fn7()
end