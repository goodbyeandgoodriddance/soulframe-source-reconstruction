local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("EE.Interface.AnchorMgr")
local v = WeakResource("/Lotus/Interface/SubGearHud.swf")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = {}
local flag = false
local flag2 = false
local v9 = 0

local function fn(p)
	if module3.IsTransmissionPlaying() then
		local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("PreviewClose", "")
		end
	end

	if p and not __wf_atom_7e8ad928(v3) then
		v3:Close()
	end

	module2.PlaySound(_G.UISound_WindowClose)
	mMovie:Close()
end

function CountdownDone()
	if v7 ~= nil then
		return
	end

	v7 = false

	if not __wf_atom_7e8ad928(_T.ScenarioBeaconInviteInfo) then
		gMatchingService:__wf_atom_c415a49f(
			_T.ScenarioBeaconInviteInfo.accountId,
			_T.ScenarioBeaconInviteInfo.bindingServerId,
			3
		)
	end

	fn(false)
end

function DestroyBeaconDeco(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	object:PlaySound(beaconDestroySound, false, 1, true)
	object:__wf_atom_921c1a5f(closingAnim, true, false)
	object:__wf_atom_921c1a5f(closedAnim, false, true)
	object:PlayTriggeredFade(true)
end

function OnAccept()
	v7 = true

	if not __wf_atom_7e8ad928(beaconAcceptCallSound) then
		module2.PlaySound(beaconAcceptCallSound)
	end

	if not __wf_atom_7e8ad928(_T.ScenarioBeaconInviteInfo) then
		_T.PendingScenarioHubName = _T.ScenarioBeaconInviteInfo.hubName
		gMatchingService:__wf_atom_c415a49f(
			_T.ScenarioBeaconInviteInfo.accountId,
			_T.ScenarioBeaconInviteInfo.bindingServerId,
			1
		)
	end

	if not __wf_atom_7e8ad928(_T.ScenarioBeacon) then
		_T.ScenarioBeacon:__wf_atom_8a035cd5(Symbol("DestroyBeaconDeco"), false)
		_T.ScenarioBeacon = nil
	end

	fn(true)
end

function OnDecline()
	v7 = false

	if not __wf_atom_7e8ad928(_T.ScenarioBeaconInviteInfo) then
		gMatchingService:__wf_atom_c415a49f(
			_T.ScenarioBeaconInviteInfo.accountId,
			_T.ScenarioBeaconInviteInfo.bindingServerId,
			3
		)
	end

	fn(true)
end

local function fn2()
	local visibilityCenter = module2.GetVisibilityCenter(mMovie, 900, false)
	local visibilitySize = module2.GetVisibilitySize(mMovie, 1150, false)
	local visibilityFadeSize = module2.GetVisibilityFadeSize(mMovie, 25)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	bgVisRange:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

local function fn3()
	local module5 = require("EE.Interface.Components.List")
	v6 = module5.CreateList(mMovie, "Panel.RewardItem")
	v6.mForceHorizontalSeparation = 0
	v6.mForcedVerticalSeparation = -34

	function v6.mElementDrawCallback(p)
		if p.Reward ~= nil then
			local reward = p.Reward
			mMovie:__wf_atom_c90af43a(p.mClipName .. ".Icon", reward:GetIconTexture())
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(reward:__wf_atom_014a76a2():c_str(), false)
			mMovie:__wf_atom_48bd5a59(p.mClipName, "Label", 36, "10x " .. __wf_atom_8e9ac384)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 44, v8.Content)
		end
	end

	if not __wf_atom_7e8ad928(rewardItem) then
		v6:AddElement({ Reward = rewardItem, Count = 10 })
	end
end

local function fn4()
	v8.Background1 = module.GetColor(2, true)
	v8.FloatingContent = module.GetColor(9, true)
	v8.FloatingContentHighlight = module.GetColor(10, true)
	v8.Content = module.GetColor(6, true)
	mMovie:__wf_atom_e57658c2("HintPanel.Bg", 11, v8.Background1)
	mMovie:__wf_atom_e57658c2("HintPanel.LineTop", 11, v8.FloatingContent)
	mMovie:__wf_atom_e57658c2("HintPanel.LineBottom", 11, v8.FloatingContent)
	mMovie:__wf_atom_e57658c2("HintPanel.Prompt", 44, v8.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 11, v8.Background1)
	mMovie:__wf_atom_e57658c2("Panel.Lines", 11, v8.FloatingContent)
	mMovie:__wf_atom_e57658c2("Panel.Desc", 44, v8.Content)
	mMovie:__wf_atom_e57658c2("Panel.PayoffTitle", 44, v8.FloatingContent)
	mMovie:__wf_atom_e57658c2("Panel.PayoffDesc", 44, v8.Content)
	mMovie:__wf_atom_e57658c2("Panel.RewardTitle", 44, v8.FloatingContent)
end

function ViewDetailedPanel(p)
	if flag2 and p == 1 then
		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("ViewDetailedPanel"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
		)
		flag2 = false
		mMovie:__wf_atom_290807ee("HintPanel")
		__wf_atom_ec43d06e(mMovie, "HintPanel", 2, { 12, 0 }, { 0, v9 + 400 }, 0.15)
		__wf_atom_ec43d06e(mMovie, "Panel", 2, { 12 }, { 100 }, 0.25, 0.15)
		mMovie:__wf_atom_c884ca43(false)
	end
end

local function fn5() -- 1 equivalent call inferred from this helper
	local scenarioBeacon = _T.ScenarioBeacon

	if __wf_atom_7e8ad928(scenarioBeacon) then
		return
	end

	scenarioBeacon:Attach(beaconFx, EMPTY_SYMBOL)
end

function Initialize()
	mMovie:__wf_atom_c884ca43(true)
	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
		Symbol("ViewDetailedPanel"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS"),
		"ViewDetailedPanel"
	)
	flag2 = true
	v9 = mMovie:__wf_atom_5e6e15c8("HintPanel", 0)
	mMovie:__wf_atom_e57658c2("HintPanel", 0, v9 + 400)
	__wf_atom_ec43d06e(mMovie, "HintPanel", 2, { 0 }, { v9 }, 0.2)
	v2 = module4.Create(mMovie)
	v3 = mMovie:PushChildMovie(countdownMovie)
	v3:Execute("SetPosition", "1200,824," .. v2.ANCHOR_V_BOTTOM .. "," .. v2.ANCHOR_H_RIGHT)
	v3:Execute("SetScale", "80,80")
	v3:Execute("SetCountdownSoundThreshold", "20")
	v3:Execute("SetCountdown", "20,CountdownDone")
	fn4()
	local movie = __wf_atom_8e4fda44:FindMovie(v)

	if not __wf_atom_7e8ad928(movie) then
		flag = true
		movie:SetVisible(false)
	end

	mMovie:OverrideMaterial("Panel.Lines", _G.UIMaterial_VitruvianLines)
	mMovie:__wf_atom_e57658c2("Panel", 12, 0)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 15, 600)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 12, 80)
	mMovie:OverrideMaterial("Panel.Bg", bgVisRange)
	mMovie:__wf_atom_c90af43a("HintPanel.Icon", iconTexture)
	mMovie:__wf_atom_933bbce0("Panel.Icon", bgIconTexture, bgIconMaterial)
	mMovie:__wf_atom_7d7314f1("Panel.PayoffTitle.text", "/Lotus/Language/SquadLink/TheirRewardTitle")
	mMovie:__wf_atom_7d7314f1("Panel.RewardTitle.text", "/Lotus/Language/SquadLink/YourRewardTitle")
	mMovie:__wf_atom_7d7314f1("HintPanel.Prompt.text", "/Lotus/Language/SquadLink/ScenarioResponsePrompt", {
		KEY = "<VIEW_RAILJACK_SYSTEMS>"
	})
	mMovie:__wf_atom_50d60589("Panel.Desc", 36, _T.ScenarioBeaconInviteInfo.playerName .. " - [HC] Objective Text")
	mMovie:__wf_atom_50d60589("Panel.PayoffDesc", 36, "[HC] Their reward")
	fn3()
	local module5 = require("Lotus.Interface.Components.ThemedButton")
	v4 = module5.Create(mMovie, "Panel.AcceptBtn", "/Lotus/Language/Menu/Global_Accept", "OnAccept")
	v4:SetWidth(122)
	v5 = module5.Create(
		mMovie,
		"Panel.DeclineBtn",
		"/Lotus/Language/Menu/Global_Decline",
		"OnDecline",
		"<MENU_CANCEL>",
		false
	)
	v5:SetWidth(122)
	module2.PlaySound(_G.UISound_VotingStarted)

	if not __wf_atom_7e8ad928(beaconRequestCallSound) then
		module2.PlaySound(beaconRequestCallSound)
	end

	mMovie:__wf_atom_e57658c2("Panel.CommFrameAlt", 12, 0)

	if not __wf_atom_7e8ad928(aidTransmission) then
		module3.ForceCloseTransmission(true)
		_T.BlockTransmissionFadeOut = true
		_T.TransmissionOverrideMovie = mMovie
		_T.TransmissionOverrideMainClipName = "Panel.CommFrameAlt"
		_T.TransmissionOverrideSubtitles = true
		_T.TransmissionMaskedMaterial = true
		module3.CreateHudlessTransmission(aidTransmission)
	end

	fn2()
	fn5() -- inferred equivalent call
end

function OnPortraitLoaded()
	__wf_atom_ec43d06e(mMovie, "Panel.Icon", 8, { 12 }, { 0 }, 0.25)
end

function OnTransmissionDone()
	__wf_atom_ec43d06e(mMovie, "Panel.Icon", 8, { 12 }, { 100 }, 0.25)
	_T.TransmissionMaskedMaterial = nil
	_T.TransmissionOverrideSubtitles = nil
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Shutdown()
	__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():ClearInvite("all")
	_T.UserInvitePending = nil
	_T.ScenarioBeaconInviteInfo = nil
	_T.BlockTransmissionFadeOut = nil

	if flag2 then
		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("ViewDetailedPanel"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
		)
		flag2 = false
	end

	if flag then
		local movie = __wf_atom_8e4fda44:FindMovie(v)

		if not __wf_atom_7e8ad928(movie) then
			movie:SetVisible(true)
		end
	end
end

function onViewportSizeChanged()
	fn2()
end

function SupportsThemes()
	return true
end