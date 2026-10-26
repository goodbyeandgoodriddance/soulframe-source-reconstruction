local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local choices = {}
local v5 = false
local v6 = 1.5
local v7 = __wf_atom_10cd16b2(0, 0.5)
local v8 = nil
local v9 = ""
local conversationSoundOverrides = { Enter = 0, Exit = 0, Loop = 0 }
conversationSoundOverrides.Enter = nil
conversationSoundOverrides.Exit = nil
conversationSoundOverrides.Loop = nil
local flag = false
local text = nil
local flag2 = false
local v10 = 0
local v11 = false
local v12 = nil
local v13 = nil
local fn
local v14 = false

function SetBackChoice(p)
	text = p
end

local function fn2(p)
	__wf_atom_ec43d06e(mMovie, "Menu.SpeakerInfo.StatePopout", 2, { 1 }, { 0 - module.Ternary(p, 45, 0) }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Menu.SpeakerInfo.ColorBg", 2, { 12 }, { module.Ternary(p, 80, 0) }, 0.3)
end

local function fn3()
	local v15 = -mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Blurer", 1)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Content.Dialogue", 42)
	local v16 = math.floor(0.5 + bgWidth / 2 - (borderPadding + __wf_atom_5e6e15c8))
	v10 = v16 * 2
	mMovie:__wf_atom_e57658c2("Menu.ChoicesPanel.Bg", 14, bgWidth)
	mMovie:__wf_atom_e57658c2("Menu.ChoicesPanel.Blurer", 14, bgWidth - v15 * 2)
	mMovie:__wf_atom_e57658c2("Menu.ChoicesPanel.Content", 0, -v16)
	mMovie:__wf_atom_e57658c2("Menu.ChoicesPanel.Content.Dialogue", 14, v10)
end

local function fn4()
	v3:RemoveElements(true, true)

	for _, v15 in ipairs(choices) do
		v3:AddElement(v15, true)

		if v15.Tag ~= "Goodbye" then
			continue
		end

		local v16 = v15

		fn = function()
			v3.mOnSelectedCallback(v16)
		end
	end

	fn3()
	v3:Redraw()
	fn2(false)

	if #choices > 0 then
		v5 = false
		mMovie:__wf_atom_0c1c47f2(inputFilter)
	end
end

local function fn5(p, p2, p3, p4)
	if not p4 then
		__wf_atom_ec43d06e(mMovie, p, 8, { p2 }, { p3 }, 0.334, 0, function()
			mMovie:__wf_atom_e57658c2(p, p2, p3)
		end)
		return
	end

	mMovie:__wf_atom_290807ee(p)
	mMovie:__wf_atom_e57658c2(p, p2, p3)
end

local function fn6(p)
	fn3()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Content.Dialogue", 42)
	local v15 = math.floor(0.5 + mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Content.Dialogue", 41) + __wf_atom_5e6e15c8 * 2)
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Menu.ChoicesPanel.Content.Dialogue", 36)
	mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Content.Dialogue", 43)

	if #choices > 0 then
		v15 = #__wf_atom_387f260e == 0 and 0 or v15 + dialoguePadding
	end

	mMovie:__wf_atom_e57658c2("Menu.ChoicesPanel.Content.Choices", 1, v15)
	local total = 0

	for _, v16 in ipairs(choices) do
		total += mMovie:__wf_atom_cfc41e35(v16.mClipName, "Btn", 15)
	end

	local v16 = math.floor(v15 + 0.5 + total - choicesPadding / 2 + __wf_atom_5e6e15c8)
	local v17 = v16 + borderPadding * 2 + module.Ternary(#choices <= 0, 7, 0)
	fn5("Menu.ChoicesPanel.Bg", 15, v17, p)
	fn5("Menu.SpeakerInfo", 1, -v17 + titleOffset, p)
	fn5("Menu.ChoicesPanel.Content", 1, -v16 - borderPadding, p)
	fn5("Menu.ChoicesPanel.Blurer", 15, v17 - -mMovie:__wf_atom_5e6e15c8("Menu.ChoicesPanel.Blurer", 1) * 2, p)
end

local function fn7()
	if (tonumber(_T.HideSubtitles) or 0) < 1 then
		return
	end

	local subtitleText = _T.SubtitleText
	local flag3, v15

	if subtitleText and (not flag2 or subtitleText ~= v9) then
		v9 = subtitleText
		v11 = false
		v13 = nil
		module.AnimateTyping(mMovie, nil, "Menu.ChoicesPanel.Content.Dialogue", v9, nil, 1, 0)
		flag3 = true
		v15 = true
	else
		flag3 = false
		v15 = false
	end

	if v13 ~= nil then
		return
	end

	local conversationInfo = _T.ConversationInfo
	local v16

	if flag3 or conversationInfo ~= nil then
		v16 = conversationInfo ~= v4
	else
		v16 = false
	end

	local v17

	if conversationInfo == nil then
		v17 = false
	else
		v17 = conversationInfo.Choices ~= choices
	end

	if not flag2 or v16 or v17 then
		v4 = conversationInfo

		if conversationInfo == nil then
			choices = nil
		else
			choices = conversationInfo.Choices
		end

		fn4()
		flag3 = true
	end

	if flag3 then
		fn6(v15)
	end
end

local function fn8()
	fn7()
	mMovie:__wf_atom_50d60589("Menu.ChoicesPanel.Content.Dialogue", 36, "")
	mMovie:__wf_atom_50d60589("Menu.SpeakerInfo.Name", 36, v4.Speaker or "[HC] [WARNING] UNSET!")
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Menu.SpeakerInfo.Name", 40)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Menu.SpeakerInfo.Name", 14)
	local v15

	if __wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8 then
		v15 = __wf_atom_5e6e15c8_2 / __wf_atom_5e6e15c8
		__wf_atom_5e6e15c8 = __wf_atom_5e6e15c8_2
	else
		v15 = 1
	end

	mMovie:__wf_atom_e57658c2("Menu.SpeakerInfo.Name", 5, v15 * 100)
	mMovie:__wf_atom_e57658c2("Menu.SpeakerInfo.Name", 6, v15 * 100)
	mMovie:__wf_atom_e57658c2("Menu.SpeakerInfo.Bg", 14, __wf_atom_5e6e15c8 + 100)
	mMovie:__wf_atom_e57658c2("Menu.SpeakerInfo.Bg", 15, titleHeight)
end

local function fn9()
	local module4 = require("EE.Interface.Components.List")
	v3 = module4.CreateList(mMovie, "Menu.ChoicesPanel.Content.Choices.Choice")
	v3.mElementDelayTime = 0.05
	v3.mElementTransitionTime = 0.4
	v3.mInterpolationProps = { 12 }
	v3.mInterpolationValues = { 100 }

	function v3.GetInterpolationProperties(p, _)
		return p.mInterpolationProps, p.mInterpolationValues
	end

	function v3.SetupPreInterpolationValues(_, p)
		mMovie:__wf_atom_e57658c2(p.mClipName, 12, 0)
	end

	function v3.CalculateY(_, p)
		return mMovie:__wf_atom_5e6e15c8(p.mClipName, 1)
	end

	function v3:GetAttributeLabel(data, p)
		local attribute = data.Attribute

		if attribute == nil then
			return data.Text
		end

		local v15 = self.mCurrentElementIndex == data.mIndex
		local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
		local attributeTypeTag = module2.GetAttributeTypeTag(attribute)
		return "<p><font >" .. data.Text .. "<font color=\"" .. convertColorNumberToHex .. "\" alpha=\"" .. (p or v15 and 255 or 0) .. "\"> (" .. Localize("/SF/Language/Menu/" .. attributeTypeTag, nil) .. ")</font></font></p>"
	end

	v3.ListSetClipCallbacks = v3.SetClipCallbacks

	function v3.SetClipCallbacks(object, p)
		object:ListSetClipCallbacks(p)
		mMovie:SetCallbacks(
			p .. ".GamepadBtn",
			object.mRollOverElementCallback,
			object.mRollOutElementCallback,
			object.mSelectElementCallback,
			object.mPressElementCallback
		)
	end

	function v3.mElementDrawCallback(data)
		local mClipName = data.mClipName
		local v15 = not data.Disable
		mMovie:__wf_atom_2dedec1a(mClipName, 67, v15)
		local attribute = data.Attribute
		local v16 = attribute ~= nil
		mMovie:__wf_atom_7f57ab2f(mClipName, "Icon.Pip", 13, not v16)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Icon.Skill", 13, v16)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Glow.Skill", 13, v16)
		local v17

		if v16 then
			mMovie:__wf_atom_c90af43a(mClipName .. ".Icon.Skill", skillIcons[attribute + 1])
			mMovie:__wf_atom_c90af43a(mClipName .. ".Glow.Skill", skillGlow)
			v17 = 70
		else
			mMovie:__wf_atom_c90af43a(mClipName .. ".Icon.Pip", pipIconDisabled)
			v17 = 38
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 0, v17)
		local v18 = v10 - v17
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 14, v18)
		mMovie:__wf_atom_933bbce0(mClipName .. ".Glow.Text", textGlow, textGlowMat)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 12, 0)
		mMovie:__wf_atom_48bd5a59(mClipName, "Label", 46, "center")
		mMovie:__wf_atom_48bd5a59(mClipName, "Label", 36, v3:GetAttributeLabel(data))
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 44, module.Ternary(v15, _G.UIColor_White, _G.UIColor_FadedTint))
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 12, 50)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Pip", 12, 20)
		local v19 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 42) * 2
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 41)
		local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 40)
		local v20 = math.floor(0.5 + __wf_atom_cfc41e35 + v19 + choicesPadding)

		if v16 then
			v20 = math.max(60, v20)
		end

		local v21 = v17 - 24
		mMovie:__wf_atom_4c1c1986(mClipName, "Lines", 0, v21)
		mMovie:__wf_atom_4c1c1986(mClipName, "Lines", 14, v10 - v21)
		mMovie:__wf_atom_4c1c1986(mClipName, "Lines", 12, 0)
		mMovie:OverrideMaterial(mClipName .. ".Lines.Top", textFocusLines)
		mMovie:OverrideMaterial(mClipName .. ".Lines.Bottom", textFocusLines)
		mMovie:__wf_atom_4c1c1986(mClipName, "Lines.Top", 1, -(__wf_atom_cfc41e35 + v19) / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Lines.Bottom", 1, (__wf_atom_cfc41e35 + v19) / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow.Text", 14, __wf_atom_cfc41e35_2 * 1.2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow.Text", 15, __wf_atom_cfc41e35 * 1.5)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow.Text", 0, v17 + __wf_atom_cfc41e35_2 / 2)
		mMovie:OverrideMaterial(mClipName .. ".Backer", textBacker)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, 30)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 0, -8)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 14, v10 - -16)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 15, __wf_atom_cfc41e35 + v19 + v19)
		mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, v10)
		mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 15, v20)
		mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBtn", 100, data.Id)
		mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBtn", 14, v20)
		mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBtn", 15, v20)
		mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBtn", 0, v10 - v20)
		mMovie:__wf_atom_c0d7a318(mClipName, "Btn", "noMenuSelection", true)
		local v22 = 0
		local mElement = v3.mElements[data.mIndex - 1]

		if mElement then
			local mClipName2 = mElement.mClipName
			v22 = v22 + mMovie:__wf_atom_5e6e15c8(mClipName2, 1) + mMovie:__wf_atom_cfc41e35(mClipName2, "Btn", 15) / 2
		end

		local v23 = v22 + v20 / 2
		mMovie:__wf_atom_e57658c2(mClipName, 1, v23)
	end

	function v3.mOnFocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Glow", 2, { 12 }, { 100 }, 0.35)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Lines", 2, { 12 }, { 100 }, 0.35)
		__wf_atom_ec43d06e(
			mMovie,
			p.mClipName .. ".Icon.Pip",
			2,
			{ 5, 6, 12 },
			{ iconFocusScale, iconFocusScale, 90 },
			0.35
		)

		if p.Attribute == nil then
			mMovie:__wf_atom_c90af43a(p.mClipName .. ".Icon.Pip", pipIcon)
		end

		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Label", 2, { function(p2)
				mMovie:__wf_atom_48bd5a59(p.mClipName, "Label", 36, v3:GetAttributeLabel(p, p2))
				mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 12, 100)
			end }, { 255 }, 0.35)
	end

	function v3.mOnUnfocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Glow", 2, { 12 }, { 0 }, 0.35)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Lines", 2, { 12 }, { 0 }, 0.35)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Icon.Pip", 2, { 5, 6, 12 }, { 100, 100, 20 }, 0.35)

		if p.Attribute == nil then
			mMovie:__wf_atom_c90af43a(p.mClipName .. ".Icon.Pip", pipIconDisabled)
		end

		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Label", 2, { function(p2)
				mMovie:__wf_atom_48bd5a59(p.mClipName, "Label", 36, v3:GetAttributeLabel(p, p2))
				mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 12, 50)
			end }, { 0 }, 0.35)
	end

	function v3.mOnSelectedCallback(p)
		if not __wf_atom_7e8ad928(v4.Callback) then
			v5 = true
			mMovie:__wf_atom_0c1c47f2(nil)
			v4.Callback(p)
			v13 = 0.5

			if p.SuccessState ~= nil then
				fn2(true)
			end
		end
	end

	v3.List_OnElementTransitionEnded = v3.OnElementTransitionEnded

	function v3.OnElementTransitionEnded(_, p)
		v3:List_OnElementTransitionEnded(p)

		if p ~= nil and p.mIndex == 1 and not v3.mHasSetCursorPosition and v4.CursorSnapping then
			if __wf_atom_7e8ad928(gRegion) then
				return
			end

			local v15 = p.mClipName .. ".Icon.Pip"
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v15, 2)

			if not Engine.IsPlayingWithController() then
				__wf_atom_5e6e15c8 = mMovie:__wf_atom_97cd8326() / 2
			end

			local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(mMovie, {
				x = __wf_atom_5e6e15c8,
				y = mMovie:__wf_atom_5e6e15c8(v15, 3)
			})
			local v16 = transformPixelToViewportCoordinates.x * mMovie:__wf_atom_d5a50cb5()
			local v17 = transformPixelToViewportCoordinates.y * mMovie:__wf_atom_c4f6543f()
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7:__wf_atom_a16f9b3c(v16, v17)
			end

			__wf_atom_8e4fda44:__wf_atom_b005c93e(v16, v17)
			mMovie:__wf_atom_fbca497c(true)
			v3.mHasSetCursorPosition = true
		end
	end

	v3:SetCallbacks("ChoicePressed", "ChoiceFocused", "ChoiceUnfocused")
end

local function fn10()
	mMovie:__wf_atom_2dedec1a("Menu.FriendshipMeter", 13, false)
	__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal1.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal2.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal3.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal4.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal5.gotoAndStop", 10)
end

local function fn11()
	for i, v15 in ipairs(skillColors) do
		skillColors[i] = _G[v15]
	end

	mMovie:__wf_atom_e57658c2("Menu.SpeakerInfo.Name", 44, _G.UIColor_Yellow)
	mMovie:OverrideMaterial("Menu.SpeakerInfo.Bg", _G.UIMaterial_FocusedBackerBorder)
	mMovie:OverrideMaterial("Menu.ChoicesPanel.Bg", _G.UIMaterial_UnfocusedBackerBorder)
	fn9()
	fn10()
	fn8()
	onViewportSizeChanged(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function Initialize()
	if flag2 then
		mMovie:Close()
	end

	module2.RegisterHideHud(true)
	module2.RegisterHideSubtitles(true)
	local module4 = require("EE.Interface.AnchorMgr")
	v = module4.Create(mMovie)
	v:Register(mMovie, "Menu", { v.ANCHOR_H_CENTRE, v.ANCHOR_V_BOTTOM })
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546.postProcessBias.horizonDOF = 1

	if _T.ConversationInfo == nil then
		mMovie:Close()
		return
	end

	if not __wf_atom_7e8ad928(_T.ConversationSoundOverrides) then
		conversationSoundOverrides = _T.ConversationSoundOverrides
	end

	v8 = module.PlaySound(conversationSoundOverrides.Loop or loopingMusic)
	module.PlaySound(conversationSoundOverrides.Enter or enterSound)
	v2 = gRegion:__wf_atom_c4f78a8f()
	mMovie:__wf_atom_50d60589("Menu.ChoicesPanel.Content.Dialogue", 36, "")
	fn6(true)
	fn11()

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie)
	end

	flag2 = true
end

local function fn12()
	if v7.mTargetVal ~= v6 then
		mMovie:__wf_atom_e57658c2("Menu.FriendshipMeter", 5, 26)
		mMovie:__wf_atom_e57658c2("Menu.FriendshipMeter", 6, 26)
		__wf_atom_ec43d06e(mMovie, "Menu.FriendshipMeter", 4, { 5, 6 }, { 20, 20 }, 1.5)
	end

	local __wf_atom_2490589b = v7:__wf_atom_2490589b(v6, __wf_atom_084b3e93())
	local v15 = 1

	if __wf_atom_2490589b < 0 then
		local v16 = math.abs(__wf_atom_2490589b)

		while v16 > 0 do
			local v17 = math.floor(0.5 + __wf_atom_104bfe98(25, 39, __wf_atom_421b01aa(v16, 0, 1)))
			__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal" .. 6 - v15 .. ".gotoAndStop", v17)
			v16 -= 1
			v15 += 1
		end

		for _ = v15, 5 do
			__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal" .. 6 - v15 .. ".gotoAndStop", 10)
		end
	else
		while __wf_atom_2490589b > 0 do
			local v16 = math.floor(0.5 + __wf_atom_104bfe98(10, 24, __wf_atom_421b01aa(__wf_atom_2490589b, 0, 1)))
			__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal" .. v15 .. ".gotoAndStop", v16)
			__wf_atom_2490589b -= 1
			v15 += 1
		end

		for _ = v15, 5 do
			__wf_atom_86cbd68d(mMovie, "Menu.FriendshipMeter.Petal" .. v15 .. ".gotoAndStop", 10)
		end
	end
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)
	fn7()
	fn12()

	if not __wf_atom_7e8ad928(v2) and v2:IsKilled() then
		TransitionOut()
	end

	if flag and v12 ~= nil then
		v12 -= v15

		if v12 < 0 then
			local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)
			local v16

			if __wf_atom_7e8ad928(movie) then
				v16 = false
			else
				v16 = movie:Execute("TransmissionActive", "")
			end

			if not v16 then
				v12 = nil

				if not v14 then
					v14 = true
					module2.DissolveOutAndClose(mMovie)
				end

				local movie2 = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/Subtitles.swf"))

				if not __wf_atom_7e8ad928(movie2) then
					movie2:Execute("DisplaySubTitle", "")
				end
			end
		end
	end

	if v13 ~= nil then
		v13 -= v15

		if v13 < 0 then
			v13 = nil
		end
	end
end

local function fn13()
	if flag then
		return
	end

	flag = true
	module2.RegisterHideHud(false)

	if not __wf_atom_7e8ad928(v8) then
		v8:Stop(false)
		v8 = nil
	end

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			__wf_atom_8ad59546.postProcessBias.horizonDOF = 0
		end
	end
end

function IsClosing()
	return flag
end

function Shutdown()
	fn13()
	_T.SkipWaitForTransmission = nil
	module2.RegisterHideSubtitles(false)
end

function TransitionOut()
	if flag then
		return
	end

	fn13()
	module.PlaySound(conversationSoundOverrides.Exit or exitSound)
	v12 = 0.5
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v) then
		v:Update(p, p2)
	end

	local visibilityCenter = module.GetVisibilityCenter(mMovie, mMovie:__wf_atom_97cd8326() / 2, true)
	local visibilitySize = module.GetVisibilitySize(mMovie, v10 - 150, true)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 50)
	textGlowMat:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	textGlowMat:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	textGlowMat:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

function onKeyDown_MENU_CANCEL()
	if flag or #choices == 0 or v4 == nil then
		return true
	end

	if __wf_atom_7e8ad928(_T.curTransmission) or not v4.Skippable then
		if not v4.AllowExit then
			return false
		end

		if fn ~= nil then
			fn()
		end

		if text then
			if not __wf_atom_7e8ad928(v4.Callback) then
				v4.Callback({ Text = text })
			end

			return
		end
	else
		module3.CloseTransmissions()
		fn4()
		return false
	end

	return true
end

function ChangeAffinity(p)
	v6 = __wf_atom_421b01aa(-5, 5, v6 + tonumber(p))
end

function ChoicePressed(p)
	if v3 == nil or v5 then
		return
	end

	module.PlaySound(uiChoicePressedSound)
	v3:SelectElementById((tonumber(p)))
end

function ChoiceFocused(p)
	if v3 == nil then
		return
	end

	module.PlaySound(_G.UISound_Focus)
	v3:FocusElementById((tonumber(p)))
end

function ChoiceUnfocused(p)
	if v3 == nil then
		return
	end

	module.PlaySound(_G.UISound_Unfocus)
	v3:UnfocusElementById((tonumber(p)))
end

function GoToMovieCallback(p)
	if not __wf_atom_7e8ad928(_T.WanderingVendorCallback) then
		_T.WanderingVendorCallback(p)
	end
end