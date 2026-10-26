local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = true
local count = 0
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = false
local v14 = false
local v15 = nil
local v16 = nil
local v17 = true
local v18 = false
local label = "/Menu/Confirm_Item_Ok"
local label2 = "/Menu/Confirm_Item_Yes"
local label3 = "/Menu/Confirm_Item_No"
local label4 = ""
local delay = nil
local delay2 = nil
local v19 = nil
local v20 = nil
local flag = false
local v21 = 0
local v22 = 0
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = {}
local v28 = { _ko = true, _ja = true, _zh = true, _tc = true }

local function fn()
	local v29 = v16

	if not v18 then
		v29 = mMovie:__wf_atom_8e9ac384(v29, true, {
			OPEN_BOLD = "<font face=\"Roboto Bold\">",
			CLOSE_BOLD = "</font>",
			OPEN_HIGHLIGHT = "<font color=\"#FloatingContent\">",
			CLOSE_HIGHLIGHT = "</font>"
		})
	end

	local v30 = module2.ReplaceTextColors(v29, v27)
	local v31 = "<p><font color=\"#" .. v27[6] .. "\">" .. v30 .. "</font></p>"
	mMovie:__wf_atom_50d60589("Dialog.Label", 36, v31)
end

local function fn2()
	local color = module3.GetColor(2, true)
	local color2 = module3.GetColor(9, true)
	local color3 = module3.GetColor(6)
	v27 = {}
	v27[6] = string.format("%X", color3:__wf_atom_dcecedb0())
	fn()
	mMovie:__wf_atom_e57658c2("PleaseWaitBacker", 11, color)
	local v29 = {
		"FancyBits.LeftLines",
		"FancyBits.RightLines",
		"Dialog.LeftLines.FadeLineTop",
		"Dialog.LeftLines.FadeLineMiddle",
		"Dialog.LeftLines.FadeLineBottom",
		"Dialog.RightLines.FadeLineTop",
		"Dialog.RightLines.FadeLineMiddle",
		"Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v29 do
		local v30 = v29[i]
		mMovie:__wf_atom_e57658c2(v30, 11, color2)
		mMovie:__wf_atom_1ca72041(v30, "RipplesColor", color3.red / 255, color3.green / 255, color3.blue / 255, 0.9)
	end

	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color2)
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color)
	mMovie:__wf_atom_1ca72041(
		"Dialog.BGPanel",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.1
	)
	mMovie:__wf_atom_1ca72041(
		"Dialog.BGPanel",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Dialog.BGPanel2",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0
	)
	mMovie:__wf_atom_1ca72041(
		"Dialog.BGPanel2",
		"RectInnerColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		1
	)

	if not __wf_atom_7e8ad928(v3) then
		v3:RunForAllElements(function(p)
			if not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mButton)) then
				p.mButton:UpdateColors()
			end
		end)
	end

	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 11, color)
end

function Initialize()
	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(1)
	end

	_T.DialogOpen = true
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Image", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 12, 0)
	mMovie:__wf_atom_e57658c2("PleaseWaitBacker", 12, 0)
	mMovie:__wf_atom_e57658c2("PleaseWaitBacker", 5, 125)
	mMovie:__wf_atom_e57658c2("PleaseWaitBacker", 6, 125)
	mMovie:__wf_atom_2dedec1a("Dialog.Image", 13, false)
	v20 = mMovie:__wf_atom_8e9ac384("/Menu/SkipCinematicConfirm", false)

	if _T.SetButtons then
		_T.SetButtons(mMovie, {}, getfenv(1))
	end

	local module4 = require("Lotus.Interface.Components.ThemedSpinner")
	v2 = module4.Create(mMovie, "Dialog.Spinner")
	v2:SetActive(false)
	local module5 = require("Lotus.Interface.Libs.TimerMgr")
	v = module5.CreateTimerMgr()
	local v29 = {
		"FancyBits.LeftLines",
		"Dialog.LeftLines.FadeLineTop",
		"Dialog.LeftLines.FadeLineMiddle",
		"Dialog.LeftLines.FadeLineBottom"
	}

	for i = 1, #v29 do
		mMovie:OverrideMaterial(v29[i], leftLineMaterial)
	end

	local v30 = {
		"FancyBits.RightLines",
		"Dialog.RightLines.FadeLineTop",
		"Dialog.RightLines.FadeLineMiddle",
		"Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v30 do
		mMovie:OverrideMaterial(v30[i], rightLineMaterial)
	end

	mMovie:OverrideMaterial("Dialog.BgPanel", containerMaterial)
	mMovie:OverrideMaterial("Dialog.BgPanel2", containerMaterial)
	mMovie:__wf_atom_e57658c2("Dialog.Blurer", 12, 0)
	v6 = false
	v10 = {}
	v10[6] = true
	v10[4] = true
	v10[5] = true
	v11 = {}
	v11[1] = true
	v11[2] = true
	v11[3] = true
	v12 = {}
	v12[1] = false
	v12[2] = false
	v12[3] = false
	module.PlaySound(_G.UISound_WindowOpen)

	if _T.LiteModeBlocking then
		v9 = 0
		mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, v9 * 100)
		mMovie:__wf_atom_2dedec1a("FancyBits", 13, false)
	end

	fn2()
end

local function fn3(p, value, value2, p2)
	local v29 = value or 0.5
	local v30 = value2 or 0.01

	if v5 > 0 then
		local function fn4(p3, p4)
			if not p then
				p4 = 1 - p4
			end

			mMovie:__wf_atom_1ca72041(p3, "AlphaTestThreshold", p4, 0, 1, 1)
		end

		if p then
			__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel", 2, { function(p3)
					fn4("Dialog.BGPanel", p3)
				end }, { 1 }, v29, v30, function()
				__wf_atom_ec43d06e(mMovie, "Dialog.BgPanel", 2, { 12 }, { 60 }, v29)
			end)
			__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel2", 2, { function(p3)
					fn4("Dialog.BGPanel2", p3)
				end }, { 1 }, v29, 0, function()
				mMovie:__wf_atom_e57658c2("Dialog.BgPanel2", 12, 0)
				mMovie:__wf_atom_e57658c2("Dialog.Blurer", 12, 100)
			end)
		else
			mMovie:__wf_atom_e57658c2("Dialog.Blurer", 12, 0)
			__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel", 1, { function(p3)
					fn4("Dialog.BGPanel", p3)
				end }, { 1 }, v29)
		end

		__wf_atom_ec43d06e(mMovie, "FancyBits", 2, { function(p3)
				if not p then
					p3 = 0.7 - p3
				end

				local v31 = {
					"FancyBits.LeftLines",
					"FancyBits.RightLines",
					"Dialog.LeftLines.FadeLineTop",
					"Dialog.LeftLines.FadeLineMiddle",
					"Dialog.LeftLines.FadeLineBottom",
					"Dialog.RightLines.FadeLineTop",
					"Dialog.RightLines.FadeLineMiddle",
					"Dialog.RightLines.FadeLineBottom"
				}

				for i = 1, #v31 do
					mMovie:__wf_atom_1ca72041(v31[i], "VisibilitySize", p3, 0, 0, 0)
				end
			end }, { 0.7 }, v29, 0)
	end

	local v31 = v29 / 2
	local ternary = module.Ternary(p, 0.05, 0)
	local ternary2 = module.Ternary(p, 100, 0)
	__wf_atom_ec43d06e(mMovie, "Dialog.Image", 2, { 12 }, { ternary2 }, v31, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Label", 2, { 12 }, { ternary2 }, v31, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Buttons", 2, { 12 }, { ternary2 }, v31, ternary, p2)

	if v5 == 0 then
		v2:SetActive(p, v31, ternary)
		__wf_atom_ec43d06e(mMovie, "PleaseWaitBacker", 0, { 12 }, { 100 }, v31)
		mMovie:__wf_atom_e57658c2("FancyBits.LeftLines", 12, 0)
		mMovie:__wf_atom_e57658c2("FancyBits.RightLines", 12, 0)
		mMovie:__wf_atom_e57658c2("Dialog.LeftLines", 12, 0)
		mMovie:__wf_atom_e57658c2("Dialog.RightLines", 12, 0)
	end
end

function MouseCatcherPressed(_) end

local function fn4()
	local screenDimensions, v29 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, v29)
end

function onViewportSizeChanged(_, _)
	fn4()
end

local function fn5()
	local vOuterPadding2 = vOuterPadding
	local v29 = math.max((buttonSize + hInnerPadding) * v5 - hInnerPadding + hOuterPadding * 2, minDialogWidth)

	if not __wf_atom_7e8ad928(v15) then
		vOuterPadding2 = vOuterPadding2 + mMovie:__wf_atom_5e6e15c8("Dialog.Image", 15) + v22
		v29 = math.max(v29, mMovie:__wf_atom_5e6e15c8("Dialog.Image", 14))
	end

	mMovie:__wf_atom_e57658c2("Dialog.Label", 14, v29 - hOuterPadding * 2)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 1, vOuterPadding2)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 0, -(v29 / 2) + hOuterPadding)
	mMovie:__wf_atom_50d60589("Dialog.Label", 36, "")
	fn()
	local v30 = vOuterPadding2 + mMovie:__wf_atom_5e6e15c8("Dialog.Label", 41) + module.Ternary(
		not __wf_atom_7e8ad928(v15),
		20,
		vInnerPadding
	)
	local v31 = v5 * (buttonSize + hInnerPadding) - hInnerPadding
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 0, -v31 / 2)
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 1, v30)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Buttons", 15)
	mMovie:__wf_atom_e57658c2("Dialog.Spinner", 1, v30 + __wf_atom_5e6e15c8 / 2)
	local v32 = v30 + __wf_atom_5e6e15c8 + vOuterPadding
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel", 14, v29)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel", 15, v32)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel2", 14, v29)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel2", 15, v32)
	mMovie:__wf_atom_e57658c2("Dialog.Blurer", 14, v29)
	mMovie:__wf_atom_e57658c2("Dialog.Blurer", 15, v32)
	local v39 = v32 - 128

	local function fn6(p)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineTop", 1, 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineTop", 15, 62)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineMiddle", 1, 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineMiddle", 15, v39)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineBottom", 1, v39 + 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineBottom", 15, 62)
	end

	fn6("Dialog.LeftLines")
	fn6("Dialog.RightLines")
	local v40 = v29 / 2
	mMovie:__wf_atom_e57658c2("Dialog.LeftLines", 0, -v40 + 2)
	mMovie:__wf_atom_e57658c2("Dialog.RightLines", 0, v40 - 2)
	mMovie:__wf_atom_e57658c2("FancyBits.LeftLines", 0, -v40 + 1)
	mMovie:__wf_atom_e57658c2("FancyBits.RightLines", 0, v40 - 1)
	fn4()
	local v41 = mMovie:__wf_atom_54eeda24() / 2
	mMovie:__wf_atom_e57658c2("Dialog", 1, v41 - v32 / 2)
end

local function fn6(p)
	local v29 = tonumber(p)
	v5 = __wf_atom_7e8ad928(v29) and 1 or v29
end

function SetNumOptions(p)
	fn6(p)
end

local function fn7(p)
	local v29 = Resource(p)

	if __wf_atom_7e8ad928(v29) or v15 == v29 or v29:__wf_atom_5583ebb9() then
		v15 = nil
		mMovie:__wf_atom_2dedec1a("Dialog.Image", 13, false)
	else
		v15 = v29
		mMovie:__wf_atom_933bbce0("Dialog.Image", v29, _G.UIMaterial_Rectangle)
		mMovie:__wf_atom_1ca72041("Dialog.Image", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041("Dialog.Image", "RectInnerColor", 1, 1, 1, 1)
		mMovie:__wf_atom_2dedec1a("Dialog.Image", 13, true)
		v23 = tonumber(v23)
		v24 = tonumber(v24)

		if v24 == nil then
			local __wf_atom_80cf57aa = v29:__wf_atom_80cf57aa()

			if v23 == nil then
				v24 = math.min(512, __wf_atom_80cf57aa.y)
				v23 = __wf_atom_80cf57aa.x / (__wf_atom_80cf57aa.y / v24)
			else
				v24 = __wf_atom_80cf57aa.y / (__wf_atom_80cf57aa.x / v23)
			end
		elseif v23 == nil then
			local __wf_atom_80cf57aa = v29:__wf_atom_80cf57aa()
			v23 = __wf_atom_80cf57aa.x / (__wf_atom_80cf57aa.y / v24)
		end

		mMovie:__wf_atom_e57658c2("Dialog.Image", 1, v21)
		mMovie:__wf_atom_e57658c2("Dialog.Image", 14, v23)
		mMovie:__wf_atom_e57658c2("Dialog.Image", 15, v24)
		mMovie:__wf_atom_50d60589("Dialog.Label", 45, v25 or "left")

		if not __wf_atom_7e8ad928(v26) then
			module.CreateUIParticles(mMovie, "Dialog", v26, 0, v21)
		end
	end

	fn5()
end

function ImageReady(p, p2)
	if p then
		fn7(p2)
	end
end

function SetImage(value, p, p2, p3, p4, p5, p6)
	local v29 = tonumber(p3)

	if v29 ~= nil then
		v21 = v29
	end

	local v30 = tonumber(p6)

	if v30 ~= nil then
		v22 = v30
	end

	v23 = p
	v24 = p2
	v25 = p4

	if p5 ~= "" and p5 ~= "nil" then
		v26 = Resource(p5)
	end

	if type(value) == "string" then
		if not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:RequestResource(value, "ImageReady")
		end
	elseif __wf_atom_1ef90898(value) then
		if not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:RequestResource(value:__wf_atom_5b41f63b(), "ImageReady")
		end
	else
		fn7(value)
	end
end

local function fn8(value)
	local v29 = _G.StalkerMode
		and value
		and string.find(value, "You will be returned to")
		and "Target's transference connection was interrupted..."
		or value

	if v29 ~= v16 then
		if v29 == v20 and module2.InQuestCommitment(gGameData) then
			v29 = "/Menu/SkipCinematicHoldConfirm"
			flag = true
			gGameRules:__wf_atom_fb52d63c()
		end

		v16 = v29
		fn()

		if v28[__wf_atom_b953295d():c_str()] or Engine.__wf_atom_578fc9dd() then
			mMovie:__wf_atom_50d60589("Dialog.Label", 49, "Arial Unicode MS")
		end
	end
end

function SetText(p)
	fn8(p)
end

function SetTextAlign(p)
	mMovie:__wf_atom_50d60589("Dialog.Label", 45, p)
end

local function fn9(p)
	v7 = p
end

function SetCallback(p)
	fn9(p)
end

function SetYesTag(p)
	label2 = p
end

function SetNoTag(p)
	label3 = p
end

local function fn10()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_2ad5cd23 == nil or v7 == nil then
		if not __wf_atom_7e8ad928(v4) then
			mMovie:__wf_atom_b35a24ab(v4)
		end
	else
		local v29 = ""
		local v30

		if v4 == 4 then
			module.PlaySound(_G.UISound_ButtonSelect)
			v30 = "Yes"
		else
			v30 = v4 == 5 and "No" or v4 == 6 and "Third" or v29
		end

		__wf_atom_2ad5cd23:Execute(v7, v30)
	end

	v13 = true

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_24ce2091("")
	end
end

function Shutdown()
	_T.DialogOpen = nil

	if flag and not __wf_atom_7e8ad928(gGameRules) and gGameRules:Paused() then
		gGameRules:__wf_atom_9141808b()
	end

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(-1)
	end

	if not v13 and v14 then
		v4 = 5
		fn10()
	end
end

local function fn11()
	fn10()
	mMovie:Close()
end

local function fn12()
	module.PlaySound(_G.UISound_WindowClose)
	v17 = true
	__wf_atom_ec43d06e(mMovie, "MouseCatcherBtn", 0, { 12 }, { 0 }, 0.2)
	fn3(false, 0.25, nil, fn11)
end

function TransitionOut()
	fn12()
end

local function fn13(p)
	if not v17 and v5 > 0 then
		print("Dialog::" .. "SendResult(" .. tostring(p) .. ")")
		v4 = p

		if v4 == 4 then
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ButtonSelect)
		else
			if v4 == 5 then
			end

			module.PlaySound(_G.UISound_Select)
		end

		if v10[p] then
			fn12()
		else
			fn10()
		end
	end
end

function SendResult_MENU_SELECT()
	if not v17 and v5 > 0 then
		print("SendResult_MENU_SELECT()")
		fn13(4)
	end

	return true
end

function SendResult_MENU_CANCEL()
	if not v17 and v5 > 1 then
		print("SendResult_MENU_CANCEL()")
		fn13(5)
	end

	return true
end

function SendResult_MENU_GENERIC2()
	if not v17 and v5 > 2 then
		print("SendResult_MENU_GENERIC1()")
		fn13(6)
	end

	return true
end

local function fn14(p)
	if not __wf_atom_7e8ad928(v3) then
		local elementInIndex = v3:GetElementInIndex(p)

		if not __wf_atom_7e8ad928(elementInIndex) then
			return elementInIndex.mButton
		end
	end
end

local function fn15(p)
	local v29 = fn14(p)

	if not __wf_atom_7e8ad928(v29) and v29:IsActive() and not __wf_atom_7e8ad928(v29.mOnPressedCallback) then
		v29:mOnPressedCallback()
	end
end

function onKeyDown_MENU_SELECT()
	v8 = "MENU_SELECT"

	if flag then
		local v29 = fn14(1)

		if not __wf_atom_7e8ad928(v29) and v29:IsActive() then
			v29:TryPressed(true, true)
		end
	end

	return true
end

function onKeyUp_MENU_SELECT()
	if not v17 and v8 == "MENU_SELECT" and v5 > 0 then
		if flag then
			local v29 = fn14(1)

			if not __wf_atom_7e8ad928(v29) and v29:IsActive() then
				v29:TryPressed(false, true)
			end
		else
			fn15(1)
		end
	end

	v8 = nil
	return true
end

function onKeyDown_MENU_CANCEL()
	v8 = "MENU_CANCEL"
	return true
end

function onKeyUp_MENU_CANCEL()
	if not v17 and v8 == "MENU_CANCEL" then
		fn15(v5)
	end

	v8 = nil
	return true
end

function onKeyDown_MENU_GENERIC2()
	v8 = "MENU_GENERIC2"
	return true
end

function onKeyUp_MENU_GENERIC2()
	if not v17 and v8 == "MENU_GENERIC2" and v5 > 2 then
		fn15(2)
	end

	v8 = nil
	return true
end

local function fn16()
	if not __wf_atom_7e8ad928(v3) then
		v3:FocusElement(v5)
		v17 = false
	end

	if _T.DialogOpenCallback ~= nil then
		_T.DialogOpenCallback()
		_T.DialogOpenCallback = nil
	end
end

local function fn17()
	v6 = true
	local _ = { mClipName = "Dialog" }

	if v5 == 0 then
		mMovie:__wf_atom_2dedec1a("Dialog.Buttons", 13, false)
	else
		local module4 = require("Lotus.Interface.Components.ThemedButton")
		local module5 = require("EE.Interface.Components.List")
		v3 = module5.CreateList(mMovie, "Dialog.Buttons.Button")
		v3.mTransitionInDeltaY = 0
		v3.mTransitionOutDeltaY = 0
		v3.mElementTransitionTime = 0
		v3.mForcedVerticalSeparation = 0
		v3.mForcedHorizontalSeparation = buttonSize + hInnerPadding
		v3.mMaxButtonWidth = 0

		function v3:mElementDrawCallback()
			if __wf_atom_7e8ad928(self.mButton) then
				local v29 = "SendResult_" .. self.Callout
				local v30 = not flag or self.Label ~= label2
				local mButton = module4.Create(
					mMovie,
					self.mClipName,
					self.Label,
					module.Ternary(v30, v29, nil),
					"<" .. self.Callout .. ">"
				)

				if not v30 then
					mButton:SetReleasedCallback(v29)
				end

				mButton:SetId(self.Id)
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 40)
				local mMaxButtonWidth = __wf_atom_5e6e15c8 == nil and 0 or __wf_atom_5e6e15c8

				if v3.mMaxButtonWidth < mMaxButtonWidth then
					v3.mMaxButtonWidth = mMaxButtonWidth
				end

				mButton:SetWidth(buttonSize)

				if self.Delay then
					v11[self.Id] = false
					v12[self.Id] = true
					mButton:SetActive(false)
				end

				if flag and self.Label == label2 then
					mButton.mRequiresHold = 1
				end

				mButton.mBackerMaterial = buttonMaterial
				mButton:Redraw()
				self.mButton = mButton
			end
		end

		if v5 == 1 then
			v3:AddElement({ Label = label, Result = 4, Callout = "MENU_SELECT", Delay = delay }, true)
		elseif v5 >= 2 then
			v3:AddElement({ Label = label2, Result = 4, Callout = "MENU_SELECT", Delay = delay }, true)

			if v5 == 3 then
				v3:AddElement({
					Label = label4,
					Result = 6,
					Callout = "MENU_GENERIC2",
					Delay = delay2
				}, true)
			end

			v3:AddElement({
				Label = label3,
				Result = 5,
				Callout = "MENU_CANCEL",
				Delay = module.Ternary(v5 == 3, v19, delay2)
			}, true)
		end

		v3:Redraw(nil, false, true)

		if not Engine.IsPlayingWithController() then
			v3.mMaxButtonWidth += 28
		end

		if v3.mMaxButtonWidth > buttonSize then
			buttonSize = v3.mMaxButtonWidth
			v3.mForcedHorizontalSeparation = buttonSize + hInnerPadding
			v3:Redraw()
		end
	end

	fn5()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 0)
	__wf_atom_ec43d06e(mMovie, "MouseCatcherBtn", 0, { 12 }, { module.Ternary(v9 ~= nil, v9, 0.9) * 100 }, 0.2, 0.1)
	fn3(true, 0.5, nil)
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	v:AddTimer(0.2, fn16)
end

function Update()
	local v29 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v29)

	if not __wf_atom_7e8ad928(v) then
		v:Update(v29)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Update()
	end

	if not v6 then
		if __wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(v5) then
			count += 1

			if count > 5 then
				mMovie:Close()
			end

			return
		else
			fn17()
		end
	end

	if not __wf_atom_7e8ad928(v3) then
		for i = 1, #v3.mElements do
			if not v12[i] then
				continue
			end

			local mElement = v3.mElements[i]

			if mElement then
				if mElement.Delay then
					mElement.Delay -= __wf_atom_084b3e93()
					mElement.mButton.mFormatSuffix = string.format(" (%d)", (math.ceil(mElement.Delay)))
					mElement.mButton:SetText(mElement.Label)

					if mElement.Delay <= 0 then
						mElement.Delay = nil
						v11[i] = true
						v12[i] = false
						mElement.mButton:SetActive(true)
					end
				else
					v12[i] = false
				end
			else
				v12[i] = false
			end
		end
	end
end

function CreateOkCancel(p, p2, p3)
	print("Dialog::" .. "CreateOkCancel(description=" .. p .. ", leftItem=" .. tostring(p2) .. ", rightItem=" .. tostring(p3) .. ")")

	if
		(__wf_atom_7e8ad928(p2) or p2 == "" or p2 == "undefined")
		and (__wf_atom_7e8ad928(p3) or p3 == "" or p3 == "undefined")
	then
		fn6(0)
	else
		fn6(2)
		label2 = p2
		label3 = p3
	end

	fn8(p)
end

function CreateOk(p, p2)
	print("Dialog::" .. "CreateOk(description=" .. p .. ", leftItem=" .. tostring(p2) .. ")")

	if __wf_atom_7e8ad928(p2) or p2 == "" or p2 == "undefined" then
		fn6(0)
	else
		fn6(1)
		label = p2
	end

	fn8(p)
end

function CreateMultiButtonDialog(p, p2, p3, p4)
	print("Dialog::" .. "CreateMultiButtonDialog(description=" .. p .. ", firstItem=" .. tostring(p2) .. ", secondItem=" .. tostring(p3) .. ", thirdItem=" .. tostring(p4) .. ")")

	if
		(__wf_atom_7e8ad928(p2) or p2 == "" or p2 == "undefined")
		and (__wf_atom_7e8ad928(p3) or p3 == "" or p3 == "undefined")
		and (__wf_atom_7e8ad928(p4) or p4 == "" or p4 == "undefined")
	then
		fn6(0)
	else
		fn6(3)
		label2 = p2
		label4 = p3
		label3 = p4
	end

	fn8(p)
end

function onRawInputEvent(gDialogDeviceID, value, p)
	if v17 and not __wf_atom_7e8ad928(v3) then
		return false
	end

	_T.gDialogDeviceID = gDialogDeviceID

	if string.find(value, "_SPACE") == nil then
		return false
	end

	if flag then
		local v29 = fn14(1)

		if not __wf_atom_7e8ad928(v29) and v29:IsActive() then
			if p == "1" then
				if v29.mHoldInterpolation == nil then
					v29:TryPressed(true, true)
				end
			else
				v29:TryPressed(false, true)
			end
		end
	elseif p ~= "1" and not v17 and v5 > 0 then
		fn15(1)
	end

	return false
end

local function fn18(p, p2)
	v11[p] = p2

	if not __wf_atom_7e8ad928(v3) then
		local elementInIndex = v3:GetElementInIndex(p)

		if not __wf_atom_7e8ad928(elementInIndex) then
			local mButton = elementInIndex.mButton

			if not __wf_atom_7e8ad928(mButton) then
				mButton:SetActive(p2)
			end
		end
	end
end

function SetButtonActive(p)
	fn18(tonumber(p), true)
end

function SetButtonInactive(p)
	fn18(tonumber(p), false)
end

function SetResultClosesMovie(p)
	v10[tonumber(p)] = true
end

function SetResultDoesNotCloseMovie(p)
	v10[tonumber(p)] = false
end

function ForceClose()
	mMovie:Close()
end

function SetDisableLocalization(p)
	v18 = p == "true"
end

function SetButtonDelays(p, p2, p3)
	local v29 = tonumber(p)
	local v30 = tonumber(p2)
	local v31 = tonumber(p3)

	if v29 > 0 then
		delay = v29
	end

	if v30 > 0 then
		delay2 = v30
	end

	if v31 > 0 then
		v19 = v31
	end
end

function SetSendCallbackOnShutdown(p)
	v14 = p == "true"
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW()
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW_ALT()
	return true
end

function OnGamepadTransition(p)
	mMovie:__wf_atom_fbca497c(p == "true")
end

function OnStyleChangedCallback()
	fn2()
end

function SupportsThemes()
	return true
end

function OpenFileFlashMovie(p, p2)
	fn6(1)
	fn8("Debug dialog popup")
	v23 = p
	v24 = p2
	fn7(debugImage)
end