local module = require("EE.Interface.Utilities")
local module2 = require("EE.Interface.AnchorMgr")
local flag = true
local v = false
local flag2 = false
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = false
local flag3 = false
local v7 = 0
local v8 = 0
local v9 = 0
local v10 = 0
local v11 = 0
local v12 = 0

function Shutdown() end

function IsInputBlocked()
	return flag
end

local function fn()
	flag = true
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.25, 0, function()
		flag2 = true
	end)
end

function Initialize()
	v2 = module2.Create(mMovie, true)
	v2:Register(mMovie, "ULCorner", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "URCorner", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	v2:Register(mMovie, "BLCorner", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "BRCorner", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_RIGHT })
	v2:Register(mMovie, "Instructions", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "ConfirmBtn", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "CancelBtn", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	local settings = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()
	v7 = settings:__wf_atom_2968f251()
	v8 = settings:__wf_atom_147dcfd3()
	v9 = v7
	v10 = v8
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.25, 0, function()
		flag = false
	end)
	local module3 = require("Lotus.Interface.Components.Button")
	v4 = module3.CreateButton(
		mMovie,
		"ConfirmBtn",
		"/Lotus/Language/Menu/MissionStats_Done",
		"Done",
		"<MENU_GENERIC1>",
		nil,
		nil,
		true
	)
	v4.mAlignment = "center"
	v4:Redraw()
	v3 = module3.CreateButton(
		mMovie,
		"CancelBtn",
		"/Menu/Confirm_Item_Cancel",
		"ExitScreen",
		"<MENU_CANCEL>",
		nil,
		nil,
		true
	)
	v3.mAlignment = "center"
	v3:Redraw()
	mMovie:__wf_atom_7d7314f1(
		"Instructions.text",
		module.Ternary(
			Engine.IsPlayingWithController(),
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_ControllerMenu",
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_NonControllerMenu"
		)
	)
	_T.SetButtons(mMovie, {})
	v = true
end

function SpecialMode()
	if Engine.__wf_atom_fc67ba71() then
		v2:Unregister(mMovie, "ConfirmBtn")
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ConfirmBtn", 0)
		mMovie:__wf_atom_e57658c2("ConfirmBtn", 0, __wf_atom_5e6e15c8 - 100)
		v2:Register(mMovie, "ConfirmBtn", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
		flag3 = true
		v3:SetVisible(false)
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v then
		return
	end

	if flag2 then
		_T.SetButtons(mMovie, nil)
		mMovie:Close()
	else
		mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

		if v6 and __wf_atom_7e8ad928(v5) then
			v6 = false

			if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
				_T.ForegroundMovie:Execute("SetInputBlocked", "0")
			end

			mMovie:__wf_atom_2ad5cd23():Execute("OnChildScreenClosed", "HudMargin")
			fn()
		end

		local v13 = 0.125
		local v14 = 0.125
		local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
		local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()

		if __wf_atom_d5a50cb5 / __wf_atom_c4f6543f < 16 / 9 then
			v14 = (__wf_atom_c4f6543f - 675 * (__wf_atom_d5a50cb5 / 1600)) / 2 / __wf_atom_c4f6543f
		else
			v13 = (__wf_atom_d5a50cb5 - 1200 * (__wf_atom_c4f6543f / 900)) / 2 / __wf_atom_d5a50cb5
		end

		local v15

		if flag or v11 == 0 then
			v15 = false
		else
			v9 = __wf_atom_421b01aa(v9 + v11 * 0.1 * __wf_atom_fa1258d0(), 0, v13)
			v15 = true
		end

		if not flag and v12 ~= 0 then
			v10 = __wf_atom_421b01aa(v10 + v12 * 0.1 * __wf_atom_fa1258d0(), 0, v14)
			v15 = true
		end

		if v15 and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			local settings = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()
			settings:__wf_atom_ee90b52a(v9, false)
			settings:__wf_atom_0cf5ba2d(v10, false)
			v2:Update(__wf_atom_d5a50cb5, __wf_atom_c4f6543f, true)
		end
	end
end

local function fn2()
	local settings = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()

	if v9 ~= v7 then
		settings:__wf_atom_ee90b52a(v9, true)
	end

	if v10 ~= v8 then
		settings:__wf_atom_0cf5ba2d(v10, true)
	end

	mMovie:__wf_atom_2ad5cd23():Execute("HudMarginsChanged", "")
end

function Done()
	if not flag then
		if flag3 then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				__wf_atom_18a5d83b:Settings():__wf_atom_9986240e(true)
			end

			if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
				_T.ForegroundMovie:Execute("SetInputBlocked", "1")
			end

			flag = true

			if not __wf_atom_7e8ad928(saveSpinnerMovie) then
				v6 = true
				v5 = mMovie:PushChildMovie(saveSpinnerMovie)
				v5:Execute("SetMessage", "/Menu/CheckPoint")
			end

			__wf_atom_a0f6588f:__wf_atom_507ce99c(0, "OnProfileSaved")
		else
			if v7 ~= v9 or v8 ~= v10 then
				fn2()
			end

			fn()
		end
	end
end

function ExitScreen()
	if not flag and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		local settings = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()
		settings:__wf_atom_ee90b52a(v9, false)
		settings:__wf_atom_0cf5ba2d(v10, false)
		fn()
	end
end

function OnProfileSaved(p)
	print("HudMarginAdjustment::OnProfileSaved")

	if not p then
		print("ERROR: Profile failed to save")
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("onHudMarginsChanged", "")

	if __wf_atom_7e8ad928(v5) then
		fn()
	else
		v5:Execute("Finished", "")
	end
end

function onKeyDown_MENU_SELECT()
	if not flag then
		v4:CalloutTriggered()
	end
end

function onKeyDown_MENU_CANCEL()
	if flag then
		return
	end

	if not flag3 then
		v3:CalloutTriggered()
	end

	return true
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2, true)
	end
end

function onKeyDown_MENU_X(_, p)
	v11 = tonumber(p)
end

function onKeyUp_MENU_X()
	v11 = 0
end

function onKeyDown_MENU_Y(_, p)
	v12 = -tonumber(p)
end

function onKeyUp_MENU_Y()
	v12 = 0
end

function onKeyDown_MENU_UP()
	if not Engine.__wf_atom_fc67ba71() then
		v12 = -1
	end

	return true
end

function onKeyDown_MENU_DOWN()
	if not Engine.__wf_atom_fc67ba71() then
		v12 = 1
	end

	return true
end

function onKeyDown_MENU_LEFT()
	if not Engine.__wf_atom_fc67ba71() then
		v11 = -1
	end

	return true
end

function onKeyDown_MENU_RIGHT()
	if not Engine.__wf_atom_fc67ba71() then
		v11 = 1
	end

	return true
end

function onKeyUp_MENU_UP()
	if not Engine.__wf_atom_fc67ba71() then
		v12 = 0
	end

	return true
end

function onKeyUp_MENU_DOWN()
	if not Engine.__wf_atom_fc67ba71() then
		v12 = 0
	end

	return true
end

function onKeyUp_MENU_LEFT()
	if not Engine.__wf_atom_fc67ba71() then
		v11 = 0
	end

	return true
end

function onKeyUp_MENU_RIGHT()
	if not Engine.__wf_atom_fc67ba71() then
		v11 = 0
	end

	return true
end

function IconCacheFlushed()
	if v4 ~= nil then
		v4:Redraw()
	end

	if v3 ~= nil then
		v3:Redraw()
	end

	mMovie:__wf_atom_7d7314f1(
		"Instructions.text",
		module.Ternary(
			Engine.IsPlayingWithController(),
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_ControllerMenu",
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_NonControllerMenu"
		)
	)
end

function OnGamepadTransition(p)
	local v13 = p == "true"
	mMovie:__wf_atom_fbca497c(v13)

	if v4 ~= nil then
		v4:Redraw()
	end

	if v3 ~= nil then
		v3:Redraw()
	end

	mMovie:__wf_atom_7d7314f1(
		"Instructions.text",
		module.Ternary(
			Engine.IsPlayingWithController(),
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_ControllerMenu",
			"/Lotus/Language/Menu/HudMarginAdjustmentInstruction_NonControllerMenu"
		)
	)
end