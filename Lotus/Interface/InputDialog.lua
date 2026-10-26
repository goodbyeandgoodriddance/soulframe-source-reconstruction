local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local label = "/Menu/Confirm_Item_Yes"
local label2 = "/Menu/Confirm_Item_No"
local flag = false
local count = 0
local v6 = nil
local v7 = nil
local v8 = true
local v9 = true
local v10 = {}
local v11 = ""
local v12 = ""
local v13 = nil
local flag2 = false
local v14 = nil

local function fn()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v7, true)
	local v15 = module2.ReplaceTextColors(__wf_atom_8e9ac384, v10)
	local v16 = "<p><font color=\"#" .. v10[9] .. "\">" .. v15 .. "</font></p>"
	mMovie:__wf_atom_50d60589("Dialog.Label", 36, v16)
end

local function fn2()
	local color = module3.GetColor(2, true)
	local color2 = module3.GetColor(9, true)
	local color3 = module3.GetColor(6)
	mMovie:__wf_atom_7df746cd(color)
	v10 = {}
	v10[9] = string.format("%X", color2)
	fn()
	mMovie:__wf_atom_e57658c2("Dialog.Desc", 11, color3:__wf_atom_dcecedb0())
	local v15 = {
		"FancyBits.LeftLines",
		"FancyBits.RightLines",
		"Dialog.LeftLines.FadeLineTop",
		"Dialog.LeftLines.FadeLineMiddle",
		"Dialog.LeftLines.FadeLineBottom",
		"Dialog.RightLines.FadeLineTop",
		"Dialog.RightLines.FadeLineMiddle",
		"Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v15 do
		local v16 = v15[i]
		mMovie:__wf_atom_e57658c2(v16, 11, color2)
		mMovie:__wf_atom_1ca72041(v16, "RipplesColor", color3.red / 255, color3.green / 255, color3.blue / 255, 0.9)
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

	if v3 then
		v3:UpdateColors()
	end

	if v2 then
		v2:RunForAllElements(function(p)
			if p.mButton then
				p.mButton:UpdateColors()
			end
		end)
	end
end

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	flag = false
	flag2 = false
	module.PlaySound(_G.UISound_WindowOpen)
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()

	if _T.SetButtons then
		_T.SetButtons(mMovie, nil)
	end

	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if not __wf_atom_7e8ad928(movie) then
		movie:__wf_atom_2004c47f()
	end

	local v15 = {
		"FancyBits.LeftLines",
		"Dialog.LeftLines.FadeLineTop",
		"Dialog.LeftLines.FadeLineMiddle",
		"Dialog.LeftLines.FadeLineBottom"
	}

	for i = 1, #v15 do
		mMovie:OverrideMaterial(v15[i], leftLineMaterial)
	end

	local v16 = {
		"FancyBits.RightLines",
		"Dialog.RightLines.FadeLineTop",
		"Dialog.RightLines.FadeLineMiddle",
		"Dialog.RightLines.FadeLineBottom"
	}

	for i = 1, #v16 do
		mMovie:OverrideMaterial(v16[i], rightLineMaterial)
	end

	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	mMovie:OverrideMaterial("Dialog.BgPanel", containerMaterial)
	mMovie:OverrideMaterial("Dialog.BgPanel2", containerMaterial)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Desc", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Input", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 12, 0)
	mMovie:__wf_atom_50d60589(
		"Dialog.Input.Label",
		57,
		module.Ternary(Engine.IsPlayingWithController() and Engine.__wf_atom_fc67ba71(), "dynamic", "input")
	)
	fn2()
end

local function fn3(p, value, value2, p2)
	local v15 = value or 0.5
	local v16 = value2 or 0.01

	if p then
		__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel", 2, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Dialog.BGPanel", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v15, v16, function()
			__wf_atom_ec43d06e(mMovie, "Dialog.BgPanel", 2, { 12 }, { 60 }, v15)
		end)
		__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel2", 2, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Dialog.BGPanel2", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v15, 0, function()
			mMovie:__wf_atom_e57658c2("Dialog.BgPanel2", 12, 0)
			mMovie:__wf_atom_e57658c2("Dialog.Blurer", 12, 100)
		end)
	else
		mMovie:__wf_atom_e57658c2("Dialog.Blurer", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Dialog.BGPanel", 1, { function(p3)
				if not p then
					p3 = 1 - p3
				end

				mMovie:__wf_atom_1ca72041("Dialog.BGPanel", "AlphaTestThreshold", p3, 0, 1, 1)
			end }, { 1 }, v15)
	end

	__wf_atom_ec43d06e(mMovie, "FancyBits", 2, { function(p3)
			if not p then
				p3 = 0.7 - p3
			end

			local v17 = {
				"FancyBits.LeftLines",
				"FancyBits.RightLines",
				"Dialog.LeftLines.FadeLineTop",
				"Dialog.LeftLines.FadeLineMiddle",
				"Dialog.LeftLines.FadeLineBottom",
				"Dialog.RightLines.FadeLineTop",
				"Dialog.RightLines.FadeLineMiddle",
				"Dialog.RightLines.FadeLineBottom"
			}

			for i = 1, #v17 do
				mMovie:__wf_atom_1ca72041(v17[i], "VisibilitySize", p3, 0, 0, 0)
			end
		end }, { 0.7 }, v15, 0)
	local v17 = v15 / 2
	local ternary = module.Ternary(p, 0.05, 0)
	local ternary2 = module.Ternary(p, 100, 0)
	__wf_atom_ec43d06e(mMovie, "Dialog.Label", 2, { 12 }, { ternary2 }, v17, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Desc", 2, { 12 }, { ternary2 }, v17, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Input", 2, { 12 }, { ternary2 }, v17, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Buttons", 2, { 12 }, { ternary2 }, v17, ternary, p2)
end

function MouseCatcherPressed(_) end

local function fn4(p, p2)
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
	local v15 = tonumber(p)
	local v16 = tonumber(p2)

	if not (Engine.__wf_atom_fc67ba71() or v15 < __wf_atom_97cd8326 or v16 < __wf_atom_54eeda24) then
		__wf_atom_97cd8326 = math.max(v15, __wf_atom_97cd8326)
		__wf_atom_54eeda24 = math.max(v16, __wf_atom_54eeda24)
	end

	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, __wf_atom_97cd8326)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, __wf_atom_54eeda24)
end

function onViewportSizeChanged(p, p2)
	fn4(p, p2)
end

function SetText(p)
	print("InputDialog::_SetText(" .. p .. ")")
	v6 = p
end

function SetCancelEnable(p)
	v9 = p == "true"
end

function SetTextNoAnim(p)
	print("InputDialog::_SetText(" .. p .. ") no anim")
	v6 = p
	mMovie:__wf_atom_7d7314f1("_root.tf.text", v6)
end

function SetCaption(p)
	print("InputDialog::_SetCaption(" .. p .. ")")
	v7 = p
end

function SetContent(p)
	print("InputDialog::_SetContent(" .. p .. ")")
	v11 = p
	v12 = p
end

function SetMaxChars(p)
	v13 = p
end

function SetCallback(p)
	v5 = p
end

function SetMultiline(_)
	flag2 = true
end

function SetYesTag(p)
	label = p
end

function SetNoTag(p)
	label2 = p
end

function SetConditionalWord(p)
	v14 = p
end

function SetDialogWidth(p)
	minDialogWidth = tonumber(p) or minDialogWidth
end

local function fn5()
	print("Dialog::TransitionOutDone()")
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if v5 == nil then
		if not __wf_atom_7e8ad928(v4) then
			mMovie:__wf_atom_b35a24ab(v4)
		end
	elseif __wf_atom_2ad5cd23 == nil then
		if _T[v5] then
			_T[v5](v11, v12, v4)
		end
	else
		__wf_atom_2ad5cd23:__wf_atom_f62a8704(v5, { v11, v12, v4 })
	end

	if v3.mSelected then
		mMovie:__wf_atom_2004c47f()
	end

	mMovie:Close()
end

function TransitionOut()
	module.PlaySound(_G.UISound_WindowClose)
	v8 = true
	module.FadeBackground(mMovie, 0, 0.2)
	fn3(false, 0.25, nil, fn5)
end

local function fn6()
	if not v8 then
		print("SendResult_MENU_SELECT()")
		local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(v3.mClipName .. ".Label", 36)
		local v15 = __wf_atom_932a80f8(__wf_atom_387f260e, nil)

		if v15 > 0 then
			module.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/SocialOverlay_InvalidCharacter",
				false
			) .. __wf_atom_f50c9d2d(__wf_atom_387f260e, v15, v15))
			local v16 = 5

			if not v8 then
				print("Dialog::" .. "SendResult(" .. tostring(v16) .. ")")
				module.PlaySound(_G.UISound_Select)
				v4 = v16
				module.PlaySound(_G.UISound_WindowClose)
				v8 = true
				module.FadeBackground(mMovie, 0, 0.2)
				fn3(false, 0.25, nil, fn5)
			end
		else
			v11 = __wf_atom_387f260e

			if v14 == nil or string.lower(v11) == v14 then
				local v16 = 4

				if not v8 then
					print("Dialog::" .. "SendResult(" .. tostring(v16) .. ")")
					module.PlaySound(_G.UISound_Select)
					v4 = v16
					module.PlaySound(_G.UISound_WindowClose)
					v8 = true
					module.FadeBackground(mMovie, 0, 0.2)
					fn3(false, 0.25, nil, fn5)
				end
			end
		end
	end
end

function SendResult_MENU_SELECT()
	fn6()
	return true
end

function SendResult_MENU_CANCEL()
	if v8 or not v9 then
		return true
	end

	print("SendResult_MENU_CANCEL()")
	local v15 = 5

	if v8 then
		return true
	end

	print("Dialog::" .. "SendResult(" .. tostring(v15) .. ")")
	module.PlaySound(_G.UISound_Select)
	v4 = v15
	module.PlaySound(_G.UISound_WindowClose)
	v8 = true
	module.FadeBackground(mMovie, 0, 0.2)
	fn3(false, 0.25, nil, fn5)
	return true
end

function onKeyDown_MENU_SELECT()
	return true
end

function onKeyUp_MENU_SELECT()
	if not flag2 or Engine.IsPlayingWithController() then
		fn6()
	end

	return true
end

function onKeyDown_MENU_CANCEL()
	return true
end

function onKeyUp_MENU_CANCEL()
	if v8 or not v9 then
		return true
	end

	print("SendResult_MENU_CANCEL()")
	local v15 = 5

	if v8 then
		return true
	end

	print("Dialog::" .. "SendResult(" .. tostring(v15) .. ")")
	module.PlaySound(_G.UISound_Select)
	v4 = v15
	module.PlaySound(_G.UISound_WindowClose)
	v8 = true
	module.FadeBackground(mMovie, 0, 0.2)
	fn3(false, 0.25, nil, fn5)
	return true
end

local function fn7()
	if not __wf_atom_7e8ad928(v2) then
		v2:FocusElement(2)
		v8 = false
	end
end

local function fn8()
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	print("Dialog::TransitionIn()")
	flag = true
	local _ = { mClipName = "Dialog" }
	local module4 = require("Lotus.Interface.Components.ThemedButton")
	local module5 = require("Lotus.Interface.Components.ThemedInputField")
	local minDialogWidth = minDialogWidth
	local buttonSize = buttonSize
	local v15 = (buttonSize + hInnerPadding) * 2 - hInnerPadding

	if v15 < minDialogWidth - hOuterPadding * 2 then
		v15 = minDialogWidth - hOuterPadding * 2
		buttonSize = (v15 + hInnerPadding) / 2 - hInnerPadding
	else
		minDialogWidth = v15 + hOuterPadding * 2
	end

	v3 = module5.Create(mMovie, "Dialog.Input", "")
	v3.mMinSize = v15
	v3.mMaxSize = v15
	v3.mInnerAlpha = 100
	v3.mAltButtonVisible = true
	local module6 = require("EE.Interface.Components.List")
	v2 = module6.CreateList(mMovie, "Dialog.Buttons.Button1")
	v2.mTransitionInDeltaY = 0
	v2.mTransitionOutDeltaY = 0
	v2.mElementTransitionTime = 0
	v2.mForcedVerticalSeparation = 0
	v2.mForcedHorizontalSeparation = buttonSize + hInnerPadding

	function v2:mElementDrawCallback()
		if __wf_atom_7e8ad928(self.mButton) then
			local mButton = module4.Create(
				mMovie,
				self.mClipName,
				self.Label,
				"SendResult_" .. self.Callout,
				"<" .. self.Callout .. ">"
			)

			if #v2.mElements == 1 then
				mMovie:__wf_atom_e57658c2("Dialog.Buttons", 0, 0)
				mButton:SetAnchor(module.CENTER_ALIGNED)
			end

			mButton:SetId(self.Id)
			mButton.mMinSize = buttonSize
			mButton.mMaxSize = buttonSize
			mButton.mInnerAlpha = 100
			mButton:SetTextAlignment("center")
			mButton.mIsDiegetic = false
			mButton.Dialog_RollOver = mButton.RollOver

			function mButton.RollOver(object)
				object:Dialog_RollOver()
			end

			mButton.Dialog_RollOut = mButton.RollOut

			function mButton.RollOut(object)
				object:Dialog_RollOut()
			end

			mButton:Redraw()
			self.mButton = mButton
		end
	end

	v2:AddElement({ Label = label, Result = 4, Callout = "MENU_SELECT" }, true)

	if v9 then
		v2:AddElement({ Label = label2, Result = 5, Callout = "MENU_CANCEL" }, true)
	end

	local mX = -v15 / 2
	local vOuterPadding2 = vOuterPadding
	mMovie:__wf_atom_e57658c2("Dialog.Label", 1, vOuterPadding2)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 0, mX)
	mMovie:__wf_atom_e57658c2("Dialog.Label", 14, v15)
	fn()
	local v16 = vOuterPadding2 + mMovie:__wf_atom_5e6e15c8("Dialog.Label", 41) - 3 + vInnerPadding

	if v6 == nil then
		mMovie:__wf_atom_50d60589("Dialog.Desc", 36, "")
	else
		mMovie:__wf_atom_e57658c2("Dialog.Desc", 1, v16)
		mMovie:__wf_atom_e57658c2("Dialog.Desc", 0, mX)
		mMovie:__wf_atom_e57658c2("Dialog.Desc", 14, v15)
		mMovie:__wf_atom_7d7314f1("Dialog.Desc.text", v6)
		v16 = v16 + mMovie:__wf_atom_5e6e15c8("Dialog.Desc", 41) - 1 + vInnerPadding
	end

	mMovie:__wf_atom_e57658c2("Dialog.Input", 1, v16)
	v3.mX = mX
	mMovie:__wf_atom_2dedec1a("Dialog.Input.Label", 52, flag2)
	local v17 = mMovie:__wf_atom_5e6e15c8("Dialog.Input.Label", 50) + 9
	local mHeight

	if flag2 then
		local v18 = __wf_atom_7e8ad928(v13) and 4 or math.min(20, (math.ceil(v13 / 22)))
		local v19 = v17 * v18
		mMovie:__wf_atom_e57658c2("Dialog.Input.Label", 15, v19)
		mHeight = v19 + 4
		v3.mHeight = mHeight
		v3:SetMultiline(true, v18)
	else
		mHeight = v17 + 4
	end

	v3:Redraw()
	local v18 = v16 + (mHeight + vInnerPadding)
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 1, v18)
	mMovie:__wf_atom_e57658c2("Dialog.Buttons", 0, mX)
	v2:Redraw(nil, false, true)
	local v19 = v18 + mMovie:__wf_atom_5e6e15c8("Dialog.Buttons", 15) + vOuterPadding
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel", 14, minDialogWidth)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel", 15, v19)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel2", 14, minDialogWidth)
	mMovie:__wf_atom_e57658c2("Dialog.BGPanel2", 15, v19)
	mMovie:__wf_atom_e57658c2("Dialog.Blurer", 14, minDialogWidth)
	mMovie:__wf_atom_e57658c2("Dialog.Blurer", 15, v19)
	local v20 = v19 - 128

	local function fn9(p)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineTop", 1, 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineTop", 15, 62)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineMiddle", 1, 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineMiddle", 15, v20)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineBottom", 1, v20 + 64)
		mMovie:__wf_atom_4c1c1986(p, "FadeLineBottom", 15, 62)
	end

	fn9("Dialog.LeftLines")
	fn9("Dialog.RightLines")
	local halfMinDialogWidth2 = minDialogWidth / 2
	mMovie:__wf_atom_e57658c2("Dialog.LeftLines", 0, -halfMinDialogWidth2 + 2)
	mMovie:__wf_atom_e57658c2("Dialog.RightLines", 0, halfMinDialogWidth2 - 2)
	mMovie:__wf_atom_e57658c2("FancyBits.LeftLines", 0, -halfMinDialogWidth2 + 1)
	mMovie:__wf_atom_e57658c2("FancyBits.RightLines", 0, halfMinDialogWidth2 - 1)
	fn4(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local v21 = mMovie:__wf_atom_54eeda24() / 2 - v19 / 2
	module.FadeBackground(mMovie, 0.9, 0.2)
	mMovie:__wf_atom_e57658c2("Dialog", 1, v21)

	if not __wf_atom_7e8ad928(v13) then
		mMovie:__wf_atom_e57658c2("Dialog.Input.Label", 39, v13)
	end

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Dialog.Input.Label", 49, "Arial Unicode MS")
	end

	v3:SetText(v11)

	if not (Engine.__wf_atom_fc67ba71() and Engine.IsPlayingWithController()) then
		mMovie:__wf_atom_46a6af3b("Dialog.Input.Label")
	end

	fn2()
	fn3(true, 0.5, nil)
	v:AddTimer(0.2, fn7)
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)

	if not __wf_atom_7e8ad928(v) then
		v:Update(v15)
	end

	if flag then
		if v14 ~= nil then
			local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(v3.mClipName .. ".Label", 36)
			local v16 = v14 == string.lower(__wf_atom_387f260e)
			v2:RunForAllElements(function(p)
				if p.Result == 4 and p.mButton ~= nil then
					p.mButton:SetActive(v16)
				end
			end)
		end
	else
		if not __wf_atom_7e8ad928(v7) then
			fn8()
			return
		end

		count += 1

		if count > 5 then
			mMovie:Close()
		end
	end
end

function onKeyDown_MENU_UP()
	return true
end

function onKeyDown_MENU_DOWN()
	return true
end

function onKeyDown_MENU_UP_FROM_ANALOG()
	return true
end

function onKeyDown_MENU_DOWN_FROM_ANALOG()
	return true
end

function Global_onPress()
	__wf_atom_7e8ad928(_G.UISound_Select)
end

function OnGamepadTransition(p)
	local v15 = p == "true"
	mMovie:__wf_atom_fbca497c(v15)

	if v2 then
		v2:RunForAllElements(function(p2)
			if p2.mButton then
				p2.mButton:Redraw()
			end
		end)
	end

	local v16 = v15 or not Engine.__wf_atom_fc67ba71()

	if not v16 then
		mMovie:__wf_atom_2004c47f()
	end

	mMovie:__wf_atom_50d60589("Dialog.Input.Label", 57, module.Ternary(v16, "input", "dynamic"))

	if v16 then
		mMovie:__wf_atom_46a6af3b("Dialog.Input.Label")
	end
end

function OnStyleChangedCallback()
	fn2()
end

function SupportsThemes()
	return true
end