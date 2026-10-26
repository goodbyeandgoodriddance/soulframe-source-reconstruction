local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.Libs.TimerMgr")
local timerMgr = module2.CreateTimerMgr()
local v = true
local flag = false
local fn

local function fn2()
	module.PlaySound(closeSound)
	v = true
	__wf_atom_ec43d06e(mMovie, "Item", 8, { 4 }, { 10000 }, 0.35)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.35, 0, function()
		mMovie:Close()
	end)

	if not (__wf_atom_7e8ad928(_T.OnGiftScreenClosingCallbackMovie) or __wf_atom_7e8ad928(_T.OnGiftScreenClosingCallbackFunction)) then
		_T.OnGiftScreenClosingCallbackMovie:Execute(_T.OnGiftScreenClosingCallbackFunction, "")
		_T.OnGiftScreenClosingCallbackMovie = nil
		_T.OnGiftScreenClosingCallbackFunction = nil
	end
end

local function fn3()
	if not v then
		if flag then
			fn2()
		else
			fn()
		end
	end
end

function GiftClick()
	fn3()
end

local function fn4(p)
	local v2 = p * 0.6
	_G.UIMaterial_VisibilityRange:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, v2)
	visRangeTextMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, v2)
end

local function fn5()
	local v2 = {}

	if flag then
		table.insert(v2, {
			Label = "/Lotus/Language/Menu/Badlands_Continue",
			CallBack = fn2,
			CallOut = "MENU_SELECT"
		})
	elseif Engine.IsPlayingWithController() then
		table.insert(v2, {
			Label = "/Lotus/Language/Menu/UnwrapGift",
			CallBack = fn3,
			CallOut = "MENU_SELECT"
		})
	end

	_T.SetButtons(mMovie, v2, getfenv(1))
end

fn = function()
	flag = true
	v = true
	fn5()
	__wf_atom_86cbd68d(mMovie, "Gift.gotoAndPlay", 2)
	timerMgr:AddTimer(0.2, function()
		module.CreateParticles(mMovie, "Item", completedFx)
	end)
	__wf_atom_ec43d06e(mMovie, "Item", 8, { 12, 4 }, { 100, 0 }, 0.35, 0.3, function()
		mMovie:__wf_atom_e57658c2("Message", 12, 100)
		v = false
		__wf_atom_ec43d06e(mMovie, "Message.Title", 2, { 77 }, { 36 }, 20, 0.3)
		__wf_atom_ec43d06e(mMovie, "Message", 0, { fn4 }, { 1 }, 0.35)
	end)
end

local function fn6(object, p, p2, p3)
	local item = object:GetItem()
	local iconTexture = object:GetIconTexture()
	local uiTexture_Blueprint = nil
	local v2 = p3 == nil and 1 or p3
	local v3

	if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_3cecff09) then
		if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_0b6f0357) then
			v3 = mMovie:__wf_atom_8e9ac384(object:__wf_atom_014a76a2():c_str(), false)
		else
			v3 = -object:__wf_atom_ee4fa4fd() * v2 .. " " .. mMovie:__wf_atom_8e9ac384(
				object:__wf_atom_014a76a2():c_str(),
				false
			)
			v2 = 1
		end
	else
		uiTexture_Blueprint = _G.UITexture_Blueprint
		v3 = mMovie:__wf_atom_8e9ac384(tostring(object:__wf_atom_619b1891()), false)

		if v3 == "" or v3 == nil then
			local c_str = object:__wf_atom_014a76a2():c_str()
			local v4 = {
				ITEM = mMovie:__wf_atom_8e9ac384(c_str, false)
			}
			v3 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/BlueprintAndItem", false, v4)
		end
	end

	if p2 ~= nil and not __wf_atom_7e8ad928(item) then
		if not item:IsA(__wf_atom_f9559e3c) or Resource(item):__wf_atom_4eb36b35() then
			if p2 == 0 then
				v3 = Localize("/Lotus/Language/Menu/Global_3Days", {}) .. " " .. v3
			elseif p2 == 1 then
				v3 = Localize("/Lotus/Language/Menu/Global_7Days", {}) .. " " .. v3
			end
		else
			local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(p2)
			v3 ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
				NUM_USES = __wf_atom_5df94bc3
			}) .. ")"
		end
	end

	if v2 > 1 then
		v3 ..= " x " .. v2
	end

	mMovie:__wf_atom_50d60589("Message.Title", 36, v3)
	local v4, sender

	if Engine.__wf_atom_578fc9dd() then
		v4 = "<font face=\"Arial Unicode MS\" size=\"18\">"
		sender = "</font>" .. v4 .. " " .. p
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Message.Content", 14)
		mMovie:__wf_atom_e57658c2("Message.Content", 5, 150)
		mMovie:__wf_atom_e57658c2("Message.Content", 6, 150)
		mMovie:__wf_atom_e57658c2("Message.Content", 0, -(__wf_atom_5e6e15c8 * 1.5) / 2)
		mMovie:__wf_atom_e57658c2("Message.Content", 1, -4)
		mMovie:OverrideMaterial("Message.Content", _G.UIMaterial_FontSharpen)
	else
		v4 = "<font color=\"#FFFFFF\">"
		sender = "</font>" .. v4 .. "<b>" .. p .. "</b>"
	end

	local v5 = "<p>" .. v4 .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftSender", false, {
		SENDER = sender
	}) .. "</font></p>"
	mMovie:__wf_atom_50d60589("Message.Content", 36, v5)

	if not __wf_atom_7e8ad928(object:GetItem()) and object:GetItem():IsA(__wf_atom_746ce1f6) then
		mMovie:__wf_atom_e57658c2("Item", 14, 335)
	end

	mMovie:__wf_atom_c90af43a("Item.Image", iconTexture)

	if uiTexture_Blueprint == nil then
		mMovie:__wf_atom_2dedec1a("Item.Background", 13, false)
	else
		mMovie:__wf_atom_c90af43a("Item.Background", uiTexture_Blueprint)
	end
end

local function fn7()
	module.PlaySound(shakeGiftSound)
	__wf_atom_ec43d06e(mMovie, "Gift", 8, { function(p)
			local v2 = math.sin(3.1415927410125732 * 8 * p) * 10
			mMovie:__wf_atom_e57658c2("Gift", 0, 800 + v2)
		end }, { 1 }, 1, 0, function()
		timerMgr:AddTimer(4, function()
			if not flag then
				fn7()
			end
		end)
	end)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("_root", 4, -10000)
	mMovie:__wf_atom_e57658c2("Message", 12, 0)
	mMovie:__wf_atom_e57658c2("Item", 12, 0)
	mMovie:__wf_atom_e57658c2("Item", 4, 10000)
	_T.ShowStoreItemReceived = fn6
	fn5()
	mMovie:OverrideMaterial("Message", _G.UIMaterial_VisibilityRange)
	mMovie:OverrideMaterial("Message.Title", visRangeTextMaterial)
	mMovie:OverrideMaterial("Message.Content", visRangeTextMaterial)
	mMovie:OverrideMaterial("Message.Bg", _G.UIMaterial_VisibilityRange)
	mMovie:SetCallbacks("Btn", "GiftRollOver", "GiftRollOut", "GiftClick", "")
	fn4(0)
	module.PlaySound(openSound)
	mMovie:__wf_atom_7df746cd(0)
	module.FadeBackground(mMovie, 0.8, 0.2, 0, function()
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12, 4 }, { 100, 10000 }, 0.45, 0, function()
			v = false
			fn7()
		end)
	end)
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(timerMgr) then
		timerMgr:Update(__wf_atom_fa1258d0())
	end
end

function onKeyDown_MENU_SELECT()
	if flag then
		fn2()
	elseif Engine.IsPlayingWithController() then
		fn3()
	end
end

function IsInputBlocked()
	return v
end

function GiftRollOver()
	if not v then
		mMovie:__wf_atom_e57658c2("Gift", 5, 105)
		mMovie:__wf_atom_e57658c2("Gift", 6, 105)
	end
end

function GiftRollOut()
	mMovie:__wf_atom_e57658c2("Gift", 5, 100)
	mMovie:__wf_atom_e57658c2("Gift", 6, 100)
end