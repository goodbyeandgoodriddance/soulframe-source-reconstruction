local module = require("SF.Interface.SFUtilities")
local v = nil
local flag = false

function ConfirmCallback()
	if flag then
		return
	end

	flag = true
	gRegion:PlaySound(continueSound, Vector(), false)
	module.DissolveOutAndClose(mMovie)

	if _T.SetButtons ~= nil then
		_T.SetButtons(mMovie)
	end
end

local function fn()
	if _T.SetButtons == nil then
		return
	end

	local v2 = {}
	table.insert(v2, {
		Label = "/SF/Language/Envoy/BodySelectConfirm",
		CallBack = ConfirmCallback,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v2, getfenv(1))
	end
end

local function fn2()
	local v2 = { Halloween = halloweenStickers, Cardinal = cardinalStickers }

	if not (#v2[eventName] > 0) then
		__wf_atom_86cbd68d(mMovie, "Stickers.gotoAndStop", "Empty")
		return
	end

	__wf_atom_86cbd68d(mMovie, "Stickers.gotoAndStop", eventName)

	for k, v3 in v2[eventName] do
		mMovie:__wf_atom_c90af43a("Stickers.Sticker" .. k, v3)
	end
end

function Initialize()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		mMovie:Close()
		return
	end

	gRegion:PlaySound(startSound, Vector(), false)
	mMovie:__wf_atom_7d7314f1("TitleText.text", "/SF/Language/Updates/TitleText")
	local v2 = mMovie:__wf_atom_5e6e15c8("TitleText", 41) + 16
	mMovie:__wf_atom_e57658c2("TitleBacker", 15, v2)
	local v3 = v2 + mMovie:__wf_atom_5e6e15c8("TitleBacker", 1)
	mMovie:__wf_atom_e57658c2("TitleLine", 1, v3)
	mMovie:__wf_atom_c90af43a("TitleLine", underlineImage)
	local v4 = v3 + 10
	mMovie:__wf_atom_e57658c2("MessageContent", 1, v4)
	local v5 = v4 - 272
	mMovie:__wf_atom_e57658c2("MessageContent.BodyCopyText.Text", 15, 460 - v5)
	mMovie:__wf_atom_e57658c2("MessageContent.SignoffFlourish", 1, 528 - v5)
	local v6 = {
		PLAYER_NAME = __wf_atom_18a5d83b:__wf_atom_6be84646()
	}
	mMovie:__wf_atom_2dedec1a("MessageContent.BodyHeaderText", 54, true)
	mMovie:__wf_atom_7d7314f1("MessageContent.BodyHeaderText.text", "/SF/Language/Updates/BodyHeaderText", v6)
	mMovie:__wf_atom_7d7314f1("MessageContent.BodyCopyText.Text.text", "/SF/Language/Updates/BodyCopyTextP12")
	mMovie:__wf_atom_7d7314f1(
		"MessageContent.SignoffFlourish.BodySignoffText.text",
		"/SF/Language/Updates/SignoffFlourish"
	)
	local v7 = mMovie:__wf_atom_5e6e15c8("MessageContent.SignoffFlourish.BodySignoffText", 0) + mMovie:__wf_atom_5e6e15c8(
		"MessageContent.SignoffFlourish.BodySignoffText",
		40
	)
	mMovie:__wf_atom_e57658c2("MessageContent.SignoffFlourish", 0, -v7 / 2 - 16)
	module.DissolveIn(mMovie)
	module.RegisterHideHud(true)
	mMovie:OverrideMaterial("MessageContent.BodyCopyText.Text", _G.UIMaterial_VerticalVisibilityRangeText)
	local module2 = require("SF.Interface.Components.Scrollbar")
	v = module2.CreateScrollBar(getfenv(1), "MessageContent.BodyCopyText.ScrollBar", {
		mClipToScroll = "MessageContent.BodyCopyText.Text",
		mVisRangeMaterials = { _G.UIMaterial_VerticalVisibilityRangeText },
		mVisRangeFadeSize = 10
	})
	fn()
	fn2()
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Shutdown()
	module.RegisterHideHud(false)
end

function onKeyDown_MENU_UP()
	v:ScrollUp()
	return true
end

function onKeyDown_MENU_UP_FROM_ANALOG()
	v:ScrollUp()
	return true
end

function onKeyDown_MENU_DOWN()
	v:ScrollDown()
	return true
end

function onKeyDown_MENU_DOWN_FROM_ANALOG()
	v:ScrollDown()
	return true
end

function onKeyDown_MENU_SELECT(_, _)
	ConfirmCallback()
	return true
end

function onKeyDown_MENU_CANCEL(_, _)
	ConfirmCallback()
	return true
end

function onKeyDown_MENU_GENERIC1()
	ConfirmCallback()
	return true
end

function onKeyDown_MENU_GENERIC2()
	ConfirmCallback()
	return true
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not __wf_atom_7e8ad928(v) then
		v:ScrollByStep(p)
	end
end