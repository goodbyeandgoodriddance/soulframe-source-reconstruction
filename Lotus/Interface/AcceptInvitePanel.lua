local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = false
local v3 = true
local v4 = nil
local v5 = nil

local function fn()
	local color = module2.GetColor(2, true)
	local color2 = module2.GetColor(9, true)
	local color3 = module2.GetColor(6)
	mMovie:__wf_atom_e57658c2("Container.Dialog.Label", 11, color3:__wf_atom_dcecedb0())
	local v6 = {
		"Container.FancyBits.LeftLines",
		"Container.FancyBits.RightLines",
		"Container.Dialog.LeftLines.FadeLineTop",
		"Container.Dialog.LeftLines.FadeLineMiddle",
		"Container.Dialog.LeftLines.FadeLineBottom",
		"Container.Dialog.RightLines.FadeLineTop",
		"Container.Dialog.RightLines.FadeLineMiddle",
		"Container.Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v6 do
		local v7 = v6[i]
		mMovie:__wf_atom_e57658c2(v7, 11, color2)
		mMovie:__wf_atom_1ca72041(v7, "RipplesColor", color3.red / 255, color3.green / 255, color3.blue / 255, 0.9)
	end

	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color2)
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color)
	mMovie:__wf_atom_1ca72041(
		"Container.Dialog.BGPanel",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.3
	)
	mMovie:__wf_atom_1ca72041(
		"Container.Dialog.BGPanel",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Container.Dialog.BGPanel2",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0
	)
	mMovie:__wf_atom_1ca72041(
		"Container.Dialog.BGPanel2",
		"RectInnerColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		1
	)
	v4:UpdateColors()
	v5:UpdateColors()
	mMovie:__wf_atom_7df746cd(color)
end

function HasFocus()
	return not v3
end

function Initialize()
	local module4 = require("Lotus.Interface.Components.ThemedButton")
	v4 = module4.Create(
		mMovie,
		"Container.Dialog.AcceptButton",
		"/Lotus/Language/Menu/Global_Accept",
		nil,
		"<MENU_GENERIC1>"
	)
	v5 = module4.Create(
		mMovie,
		"Container.Dialog.DeclineButton",
		"/Lotus/Language/Menu/Global_Decline",
		nil,
		"<MENU_CANCEL>"
	)
	v4:SetWidth(169)
	v5:SetWidth(169)

	function v4.mOnReleasedCallback()
		mMovie:Execute("OnAccept", "")
	end

	function v5.mOnReleasedCallback()
		mMovie:Execute("OnCancel", "")
	end

	v4:Redraw()
	v5:Redraw()
	mMovie:__wf_atom_2dedec1a("_root", 13, false)
	mMovie:__wf_atom_c884ca43(true)
	v = module3.Create(mMovie)
	v:Register(mMovie, "Container", { v.ANCHOR_V_BOTTOM, v.ANCHOR_H_CENTRE })
	v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local v6 = {
		"Container.FancyBits.LeftLines",
		"Container.Dialog.LeftLines.FadeLineTop",
		"Container.Dialog.LeftLines.FadeLineMiddle",
		"Container.Dialog.LeftLines.FadeLineBottom"
	}

	for i = 1, #v6 do
		mMovie:OverrideMaterial(v6[i], leftLineMaterial)
	end

	local v7 = {
		"Container.FancyBits.RightLines",
		"Container.Dialog.RightLines.FadeLineTop",
		"Container.Dialog.RightLines.FadeLineMiddle",
		"Container.Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v7 do
		mMovie:OverrideMaterial(v7[i], rightLineMaterial)
	end

	mMovie:OverrideMaterial("Container.Dialog.BGPanel", containerMaterial)
	mMovie:OverrideMaterial("Container.Dialog.BGPanel2", containerMaterial)
	fn()

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Container.Dialog.Label", 49, "Arial Unicode MS")
	end

	v2 = true
end

local function fn2(p, value, value2, p2)
	local v6 = value or 0.5
	local v7 = value2 or 0.01

	if p then
		__wf_atom_ec43d06e(mMovie, "Container.Dialog.BGPanel", 2, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Container.Dialog.BGPanel", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v6, v7, function()
			__wf_atom_ec43d06e(mMovie, "Container.Dialog.BGPanel", 2, { 12 }, { 90 }, v6)
		end)
		__wf_atom_ec43d06e(mMovie, "Container.Dialog.BGPanel2", 2, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Container.Dialog.BGPanel2", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v6, 0, function()
			mMovie:__wf_atom_e57658c2("Container.Dialog.BGPanel2", 12, 0)
			mMovie:__wf_atom_e57658c2("Container.Dialog.Blurer", 12, 100)
		end)
	else
		mMovie:__wf_atom_e57658c2("Container.Dialog.Blurer", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Container.Dialog.BGPanel", 1, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Container.Dialog.BGPanel", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v6)
	end

	__wf_atom_ec43d06e(mMovie, "Container.FancyBits", 2, { function(p3)
			if not p then
				p3 = 0.7 - p3
			end

			local v8 = {
				"Container.FancyBits.LeftLines",
				"Container.FancyBits.RightLines",
				"Container.Dialog.LeftLines.FadeLineTop",
				"Container.Dialog.LeftLines.FadeLineMiddle",
				"Container.Dialog.LeftLines.FadeLineBottom",
				"Container.Dialog.RightLines.FadeLineTop",
				"Container.Dialog.RightLines.FadeLineMiddle",
				"Container.Dialog.RightLines.FadeLineBottom"
			}

			for i = 1, #v8 do
				mMovie:__wf_atom_1ca72041(v8[i], "VisibilitySize", p3, 0, 0, 0)
			end
		end }, { 0.7 }, v6, 0)
	local v8 = v6 / 2
	local ternary = module.Ternary(p, 0.05, 0)
	local ternary2 = module.Ternary(p, 100, 0)
	__wf_atom_ec43d06e(mMovie, "Container.Dialog.Label", 2, { 12 }, { ternary2 }, v8, ternary)
	__wf_atom_ec43d06e(mMovie, "Container.Dialog.Buttons", 2, { 12 }, { ternary2 }, v8, ternary, p2)
end

function IconCacheFlushed()
	if mMovie then
		if v4 ~= nil then
			v4:Redraw()
		end

		if v5 ~= nil then
			v5:Redraw()
		end
	end
end

local function fn3()
	mMovie:__wf_atom_7d7314f1("Container.Dialog.Label.text", _T.UserInvitePending, true)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Container.Dialog.Label", 41)

	if __wf_atom_5e6e15c8 ~= nil then
		local v6 = __wf_atom_5e6e15c8 + 75
		mMovie:__wf_atom_e57658c2("Container.Dialog", 1, -v6)
		mMovie:__wf_atom_e57658c2("Container.FancyBits", 1, -v6 / 2)
		mMovie:__wf_atom_e57658c2("Container.Dialog.BGPanel", 15, v6)
		mMovie:__wf_atom_e57658c2("Container.Dialog.BGPanel2", 15, v6)
		mMovie:__wf_atom_e57658c2("Container.Dialog.Blurer", 15, v6)
		mMovie:__wf_atom_e57658c2("Container.Dialog.AcceptButton", 1, __wf_atom_5e6e15c8 + 32)
		mMovie:__wf_atom_e57658c2("Container.Dialog.DeclineButton", 1, __wf_atom_5e6e15c8 + 32)
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v2 then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	local v6 = v3
	v3 = __wf_atom_7e8ad928(__wf_atom_8e4fda44:__wf_atom_1dca1cfb())
		or __wf_atom_7e8ad928(_T.UserInvitePending) and not _T.UserInGameInvitePending
		or _G.mDoNotDisturb
		or not __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(factionChoiceMovie))
	v3 = v3 and true or false

	if v6 ~= v3 then
		if v3 then
			mMovie:__wf_atom_e57658c2("Container.Dialog.BGPanel", 12, 100)
			fn2(false, 0.25, nil, function()
				mMovie:__wf_atom_2dedec1a("_root", 13, false)
			end)
		else
			mMovie:__wf_atom_2dedec1a("_root", 13, true)
			mMovie:__wf_atom_e57658c2("Container.Dialog.Blurer", 12, 0)
			mMovie:__wf_atom_e57658c2("Container.Dialog.BGPanel2", 12, 100)
			mMovie:__wf_atom_1ca72041("Container.Dialog.BGPanel2", "AlphaTestThreshold", 0, 0, 1, 1)
			fn3()
			fn2(true, 0.5, nil)

			if _T.UserInGameInvitePending then
				v4:SetActive(false)
			end
		end

		mMovie:__wf_atom_c884ca43(v3)
	end

	if not v3 and mMovie:__wf_atom_387f260e("Container.Dialog.Label", 36) ~= _T.UserInvitePending then
		fn3()
	end
end

function _T.HandleAcceptInviteFade()
	if v3 then
		mMovie:__wf_atom_2dedec1a("_root", 13, false)
	end
end

function OnAccept()
	if _T.UserInGameInvitePending then
		_T.UserInvitePending = nil
		_T.UserInGameInvitePending = nil
	elseif not __wf_atom_7e8ad928(_T.SquadOverlay) then
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_ButtonSelect)
		module.PlaySound(_G.UISound_DialogOpen)
		_T.SquadOverlay:Execute("JoinInviteConfirm", (tostring(4)))
	end
end

function OnCancel()
	if not __wf_atom_7e8ad928(_T.SquadOverlay) then
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_GridOpenTwo)
		_T.SquadOverlay:Execute("JoinInviteConfirm", (tostring(5)))
	end
end

function IsInputBlocked()
	return v3
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v) then
		v:Update(p, p2)
	end
end

function onMenuScaleChanged()
	if not __wf_atom_7e8ad928(v) then
		v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end

function onKeyUp_MENU_SELECT()
	local v6

	if Engine.IsPlayingWithController() then
		v6 = true
	else
		local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())
		v6 = (__wf_atom_7e8ad928(movie) or not movie:Execute("IsFull", "")) and true or false
	end

	if v6 and not (v3 or Engine.IsPlayingWithController()) then
		v4:mOnReleasedCallback()
		return true
	else
		return false
	end
end

function onKeyUp_MENU_GENERIC1()
	local v6

	if Engine.IsPlayingWithController() then
		v6 = true
	else
		local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())
		v6 = (__wf_atom_7e8ad928(movie) or not movie:Execute("IsFull", "")) and true or false
	end

	if v6 and not v3 then
		if not __wf_atom_7e8ad928(v4) then
			v4:mOnReleasedCallback()
		end

		return true
	else
		return false
	end
end

function onKeyDown_MENU_CANCEL()
	local v6

	if Engine.IsPlayingWithController() then
		v6 = true
	else
		local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())
		v6 = (__wf_atom_7e8ad928(movie) or not movie:Execute("IsFull", "")) and true or false
	end

	if v6 and not v3 and Engine.IsPlayingWithController() then
		if not __wf_atom_7e8ad928(v5) then
			v5:mOnReleasedCallback()
		end

		return true
	else
		return false
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	if Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_3aa103d3() then
		gGameRules:__wf_atom_5aa33f5c()
		return true
	else
		return false
	end
end

function OnGamepadTransition(_)
	if not __wf_atom_7e8ad928(v4) then
		v4:Redraw()
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Redraw()
	end
end

function OnStyleChangedCallback()
	fn()
end

function SupportsThemes()
	return true
end