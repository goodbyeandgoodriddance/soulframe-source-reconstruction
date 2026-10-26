local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local _ = { 5197616, 4214832, 3162192 }
local v = nil
local v2 = nil
local v3 = nil
local conversationInfo = {}
local v4 = false
local v5 = 0
local v6 = 1.5
local v7 = __wf_atom_10cd16b2(0, 0.5)
local v8 = nil
local subtitleText = ""
local conversationSoundOverrides = { Enter = 0, Exit = 0, Loop = 0 }
conversationSoundOverrides.Enter = nil
conversationSoundOverrides.Exit = nil
conversationSoundOverrides.Loop = nil
local flag = false
local text = nil

function SetBackChoice(p)
	text = p
end

local function fn(p)
	__wf_atom_ec43d06e(mMovie, "SpeakerInfo.StatePopout", 2, { 1 }, { v5 - module.Ternary(p, 45, 0) }, 0.3)
	__wf_atom_ec43d06e(mMovie, "SpeakerInfo.ColorBg", 2, { 12 }, { module.Ternary(p, 80, 0) }, 0.3)
end

local function fn2()
	v3:RemoveElements(true, true)

	for i = 1, #conversationInfo.Choices do
		v3:AddElement(conversationInfo.Choices[i], true)
	end

	v3:Redraw()
	fn(false)
	local v9 = v3:GetHowManyElements() > 0
	mMovie:__wf_atom_2dedec1a("ChoicesPanel", 13, v9)

	if v9 then
		mMovie:__wf_atom_2dedec1a("ChoicesPanel", 67, true)
		__wf_atom_ec43d06e(mMovie, "ChoicesPanel", 2, { 12 }, { 100 }, 0.3, 0, function()
			v4 = false
		end)
	else
		mMovie:__wf_atom_e57658c2("ChoicesPanel", 12, 0)
		mMovie:__wf_atom_2dedec1a("ChoicesPanel", 67, false)
		v4 = false
	end
end

function Initialize()
	module2.RegisterHideHud(true)

	if not __wf_atom_7e8ad928(_T.ConversationSoundOverrides) then
		conversationSoundOverrides = _T.ConversationSoundOverrides
	end

	v8 = module.PlaySound(conversationSoundOverrides.Loop or loopingMusic)
	module.PlaySound(conversationSoundOverrides.Enter or enterSound)
	_T.HideSubtitles = true
	conversationInfo = _T.ConversationInfo
	_T.ConversationInfo = nil
	v2 = gRegion:__wf_atom_c4f78a8f()
	mMovie:__wf_atom_e57658c2("SpeakerInfo.Name", 44, 16182747)
	mMovie:__wf_atom_e57658c2("SpeakerInfo.Affinity", 44, 16182747)
	mMovie:__wf_atom_c90af43a("SpeakerInfo.BgFill", backerTextures[1])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.BgLeft", backerTextures[2])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.BgRight", backerTextures[2])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.LineTop", lineTextures[1])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.LineBottom", lineTextures[1])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.ColorBg", backerTextures[4])
	mMovie:__wf_atom_e57658c2("SpeakerInfo.ColorBg", 12, 0)
	mMovie:__wf_atom_c90af43a("SpeakerInfo.ColorBg", backerTextures[4])
	v5 = mMovie:__wf_atom_5e6e15c8("SpeakerInfo.StatePopout", 1)
	mMovie:__wf_atom_c90af43a("SpeakerInfo.StatePopout.Chevron1", stateTextures[1])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.StatePopout.Chevron2", stateTextures[1])
	mMovie:__wf_atom_c90af43a("SpeakerInfo.StatePopout.ChevronBacker", stateTextures[2])
	mMovie:__wf_atom_e57658c2("SpeakerInfo.StatePopout.Chevron1", 11, 16182747)
	mMovie:__wf_atom_e57658c2("SpeakerInfo.StatePopout.Chevron2", 11, 16182747)
	mMovie:__wf_atom_e57658c2("SpeakerInfo.StatePopout.State", 44, 16182747)
	mMovie:__wf_atom_c90af43a("ChoicesPanel.Bg", backerTextures[3])
	mMovie:__wf_atom_c90af43a("ChoicesPanel.LineTop", lineTextures[2])
	mMovie:__wf_atom_c90af43a("ChoicesPanel.LineBottom", lineTextures[2])
	mMovie:__wf_atom_e57658c2("SpeakerInfo.BgFill", 12, 75)
	mMovie:__wf_atom_e57658c2("SpeakerInfo.BgLeft", 12, 75)
	mMovie:__wf_atom_e57658c2("SpeakerInfo.BgRight", 12, 75)
	mMovie:__wf_atom_e57658c2("ChoicesPanel.Bg", 12, 75)
	mMovie:OverrideMaterial("Backer", backerMaterial)
	mMovie:__wf_atom_1ca72041("Backer", "AAEdgeExtend", 100, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("Backer", 11, _G.UIColor_Black)
	mMovie:__wf_atom_e57658c2("Backer", 12, 50)
	mMovie:OverrideMaterial("Darkener", _G.UIMaterial_VisibilityRange)
	mMovie:__wf_atom_1ca72041("Darkener", "VisibilityFadeSize", 0.1, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Darkener", "VisibilitySize", 0.6, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Darkener", "VisibilityCenter", 0, 0, 0, 0)
	require("SF.Interface.Components.Button")
	local module5 = require("EE.Interface.Components.List")
	v3 = module5.CreateList(mMovie, "ChoicesPanel.Choice1")
	v3:SetCallbacks("ChoicePressed", "ChoiceFocused", "ChoiceUnfocused")
	v3.mForcedVerticalSeparation = 20
	v3.mForcedHorizontalSeparation = 0

	function v3.CalculateHeight(p)
		return (mMovie:__wf_atom_cfc41e35(p.mClipName, "Label", 41))
	end

	function v3.CalculateY(data, p)
		local mInitialY = data.mInitialY

		for i = 1, p.mIndex - 1 do
			mInitialY += data.CalculateHeight(data.mElements[i]) + data.mForcedVerticalSeparation
		end

		return mInitialY
	end

	function v3.mElementDrawCallback(data)
		local v9 = not data.Disable
		mMovie:__wf_atom_2dedec1a(data.mClipName, 67, v9)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Skill", 13, data.Skill ~= nil)

		if data.Skill ~= nil then
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Skill.Bg", skillBackers[data.Skill])
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Skill.Icon", skillIcons[data.Skill])
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Skill.Edge", skillEdge)
			local v10 = 45 + module.Ternary(data.Skill == 2, -15, 0)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Skill.Icon", 14, v10)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Skill.Icon", 15, v10)
		end

		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Glow", glowTexture)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 11, 6836521)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 12, 0)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Leaf", leafIcon)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Leaf", 14, 32)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Leaf", 15, 32)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, data.Text)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, module.Ternary(v9, _G.UIColor_White, 8616547))
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Label", 41)
		local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Label", 40)
		local __wf_atom_cfc41e35_3 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Label", 0)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn", 15, __wf_atom_cfc41e35 + 15)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 15, __wf_atom_cfc41e35 + 30)
		local v10 = __wf_atom_cfc41e35 / 2 - 12
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 0, __wf_atom_cfc41e35_3 + __wf_atom_cfc41e35_2 / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 14, __wf_atom_cfc41e35_2 * 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 1, v10)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Leaf", 1, v10)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Skill", 1, v10)
	end

	function v3.mOnFocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Glow", 2, { 12 }, { 100 }, 0.35)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Leaf", 2, { 14, 15 }, { 41, 41 }, 0.35)
	end

	function v3.mOnUnfocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Glow", 2, { 12 }, { 0 }, 0.35)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Leaf", 2, { 14, 15 }, { 32, 32 }, 0.35)
	end

	function v3.mOnSelectedCallback(p)
		if not __wf_atom_7e8ad928(conversationInfo.Callback) then
			v4 = true
			conversationInfo.Callback(p)
			__wf_atom_ec43d06e(mMovie, "ChoicesPanel", 2, { 12 }, { 0 }, 0.3)
			mMovie:__wf_atom_2dedec1a("ChoicesPanel", 67, false)

			if p.SuccessState ~= nil then
				local ternary = module.Ternary(p.SuccessState, 4609306, 5771280)
				mMovie:__wf_atom_e57658c2("SpeakerInfo.ColorBg", 11, ternary)
				mMovie:__wf_atom_e57658c2("SpeakerInfo.StatePopout.ChevronBacker", 11, ternary)
				mMovie:__wf_atom_50d60589(
					"SpeakerInfo.StatePopout.State",
					36,
					module.Ternary(p.SuccessState, "SUCCESS", "FAILURE")
				)
				fn(true)
			end
		end
	end

	local module6 = require("EE.Interface.AnchorMgr")
	v = module6.Create(mMovie)
	v:Register(mMovie, "FriendshipMeter", { v.ANCHOR_H_LEFT, v.ANCHOR_V_CENTRE })
	v:Register(mMovie, "SpeakerInfo", { v.ANCHOR_H_LEFT, v.ANCHOR_V_CENTRE })
	v:Register(mMovie, "ChoicesPanel", { v.ANCHOR_H_LEFT, v.ANCHOR_V_CENTRE })
	v:Register(mMovie, "Backer", { v.ANCHOR_H_LEFT, v.ANCHOR_V_CENTRE })
	v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_50d60589("SpeakerInfo.Name", 36, conversationInfo.Speaker or "AVAKOT")
	mMovie:__wf_atom_50d60589("SpeakerInfo.Dialogue", 36, "")
	fn2()
	__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal1.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal2.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal3.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal4.gotoAndStop", 10)
	__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal5.gotoAndStop", 10)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546.postProcessBias.horizonDOF = 1
end

local function fn3()
	if v7.mTargetVal ~= v6 then
		mMovie:__wf_atom_e57658c2("FriendshipMeter", 5, 26)
		mMovie:__wf_atom_e57658c2("FriendshipMeter", 6, 26)
		__wf_atom_ec43d06e(mMovie, "FriendshipMeter", 4, { 5, 6 }, { 20, 20 }, 1.5)
	end

	local __wf_atom_2490589b = v7:__wf_atom_2490589b(v6, __wf_atom_084b3e93())
	local v9 = 1

	if __wf_atom_2490589b < 0 then
		local v10 = math.abs(__wf_atom_2490589b)

		while v10 > 0 do
			local v11 = math.floor(0.5 + __wf_atom_104bfe98(25, 39, __wf_atom_421b01aa(v10, 0, 1)))
			__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal" .. 6 - v9 .. ".gotoAndStop", v11)
			v10 -= 1
			v9 += 1
		end

		for _ = v9, 5 do
			__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal" .. 6 - v9 .. ".gotoAndStop", 10)
		end
	else
		while __wf_atom_2490589b > 0 do
			local v10 = math.floor(0.5 + __wf_atom_104bfe98(10, 24, __wf_atom_421b01aa(__wf_atom_2490589b, 0, 1)))
			__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal" .. v9 .. ".gotoAndStop", v10)
			__wf_atom_2490589b -= 1
			v9 += 1
		end

		for _ = v9, 5 do
			__wf_atom_86cbd68d(mMovie, "FriendshipMeter.Petal" .. v9 .. ".gotoAndStop", 10)
		end
	end
end

function Update()
	local v9 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v9)

	if _T.SubtitleText and _T.SubtitleText ~= subtitleText then
		subtitleText = _T.SubtitleText
		module.AnimateTyping(mMovie, nil, "SpeakerInfo.Dialogue", subtitleText, nil, 2, 0)
	end

	if _T.ConversationInfo ~= nil then
		conversationInfo = _T.ConversationInfo
		_T.ConversationInfo = nil
		fn2()
	end

	fn3()

	if not __wf_atom_7e8ad928(v2) and v2:IsKilled() then
		TransitionOut()
	end
end

function Shutdown() end

function TransitionOut()
	if flag then
		return
	end

	if text then
		if not __wf_atom_7e8ad928(conversationInfo.Callback) then
			conversationInfo.Callback({ Text = text })
		end
	else
		flag = true
		module2.RegisterHideHud(false)
		_T.HideSubtitles = nil

		if not __wf_atom_7e8ad928(v8) then
			v8:Stop(false)
			v8 = nil
		end

		if not __wf_atom_7e8ad928(gRegion) then
			local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
			__wf_atom_8ad59546.postProcessBias.horizonDOF = 0
		end

		mMovie:__wf_atom_0c1c47f2(nil)
		module.PlaySound(conversationSoundOverrides.Exit or exitSound)
		module3.DissolveOutAndClose(mMovie)
	end
end

function onViewportSizeChanged(_, _)
	local _, v9 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("Backer", 15, v9 + 200)
end

function onKeyDown_MENU_CANCEL()
	if not conversationInfo.AllowExit then
		return false
	end

	if conversationInfo.Skippable and not __wf_atom_7e8ad928(_T.curTransmission) then
		module4.CloseTransmissions()
		fn2()
		return false
	else
		TransitionOut()
		return true
	end
end

function ChangeAffinity(p)
	v6 = __wf_atom_421b01aa(-5, 5, v6 + tonumber(p))
end

function ChoicePressed(p)
	if v3 == nil or v4 then
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