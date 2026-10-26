local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = {
	ADVERTISING = 0,
	CREATING = 1,
	SEARCHING = 2,
	WAITING_FOR_PLAYERS = 3,
	JOIN_TIMEOUT = 4,
	PROGRESS = 5,
	ABORT = 6,
	SUCCESS = 7,
	FAILED = 8,
	CUSTOM = 9,
	CLOSING = 10
}
local v2 = 0
local v3 = nil
local v4 = nil
local v5 = nil
local tag = nil
local v6 = -1
local count = 0
local v7 = -1
local v8 = -1
local name = nil
local v9 = false
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local flag = false
local v16 = -1
local v17 = 0
local v18 = {}
local v19 = {
	Hacking1 = "HACKING_A",
	Hacking2 = "HACKING_B",
	Hacking3 = "HACKING_C",
	InVault1 = "INSIDE_A",
	InVault2 = "INSIDE_B",
	InVault3 = "INSIDE_C"
}
local v20 = Resource("/Lotus/Interface/SurvivalReward.swf")

local function fn()
	if not gMatchingService:__wf_atom_d309183e() then
		_T.PendingScenarioHubName = gRegion:__wf_atom_eab484a7():__wf_atom_6be84646() .. module3.SCENARIO_BEACON_TAG .. module3.GetSecondCount() % 500000
		_T.InitScenario = true
	end

	_T.CreatingScenarioBeacon = true

	if not gGameRules:IsA(__wf_atom_311a7128) then
		gGameRules:SetNetPersistentVar(Symbol("SquadLink_AcceptingLinks"), 1)
	end

	v3:SetActive(true)
	mMovie:__wf_atom_2dedec1a("Notification.Icon", 13, false)
end

local function fn2()
	for i = 1, 3 do
		local v21 = "Notification.TimedObjectives.Objective" .. i
		mMovie:__wf_atom_c90af43a(v21 .. ".Icon", objectiveIcons[i])
		mMovie:__wf_atom_4c1c1986(v21, "IconOverlay", 12, 0)
		mMovie:__wf_atom_4c1c1986(v21, "Time", 12, 0)
	end

	mMovie:__wf_atom_50d60589("Notification.TextObjective", 36, "")
	mMovie:__wf_atom_50d60589("Notification.PlayerValues", 36, "")
end

local function fn3(p)
	for k, v21 in pairs(v18) do
		v18[k] = math.max(0, v21 - p)
		mMovie:__wf_atom_48bd5a59("Notification.TimedObjectives.Objective" .. k, "Time", 36, module2.FormatNumber(v21))
	end
end

local function fn4()
	local v21 = 0
	local total = 90
	local v22 = v10 and not __wf_atom_7e8ad928(v10.Vaults)
	local v23 = v10 and not __wf_atom_7e8ad928(v10.Exterminate)
	mMovie:__wf_atom_2dedec1a("Notification.TimedObjectives", 13, v22)
	mMovie:__wf_atom_2dedec1a("Notification.TextObjective", 13, v23)

	if v22 then
		local v24 = v21 + 24
		total += 24
		local flag2 = false
		v18 = {}

		for i, vault in ipairs(v10.Vaults) do
			local v25 = "Notification.TimedObjectives.Objective" .. i

			if vault.s == 1 then
				mMovie:__wf_atom_c90af43a(v25 .. ".IconOverlay", objectiveCompleteTexture)
				mMovie:__wf_atom_4c1c1986(v25, "IconOverlay", 12, 100)
				mMovie:__wf_atom_4c1c1986(v25, "IconOverlay", 11, v12)
			elseif vault.s == 2 then
				mMovie:__wf_atom_c90af43a(v25 .. ".IconOverlay", objectiveFailedTexture)
				mMovie:__wf_atom_4c1c1986(v25, "IconOverlay", 12, 100)
				mMovie:__wf_atom_4c1c1986(v25, "IconOverlay", 11, v13)
			else
				mMovie:__wf_atom_4c1c1986(v25, "IconOverlay", 12, 0)
			end

			if vault.t == nil then
				mMovie:__wf_atom_4c1c1986(v25, "Time", 12, 0)
			else
				v18[i] = tonumber(vault.t)
				mMovie:__wf_atom_48bd5a59(v25, "Time", 36, vault.t)
				mMovie:__wf_atom_4c1c1986(v25, "Time", 12, 100)
				flag2 = true
			end
		end

		if flag2 then
			v24 += 10
			total += 10
		end
	end

	if v23 then
		local formatNumber = module2.FormatNumber(module2.Ternary(
			v10.Exterminate.Progress ~= nil,
			v10.Exterminate.Progress,
			0
		))
		local formatNumber2 = module2.FormatNumber(module2.Ternary(
			v10.Exterminate.Total ~= nil,
			v10.Exterminate.Total,
			0
		))
		mMovie:__wf_atom_7d7314f1("Notification.TextObjective.text", "/Lotus/Language/SquadLink/ExterminateTotal", {
			CURRENT = formatNumber,
			TOTAL = formatNumber2
		})
	end

	total += mMovie:__wf_atom_5e6e15c8("Notification.Action", 41)
end

local function fn5()
	if __wf_atom_7e8ad928(v10) then
		return
	end

	local flag2 = true
	local v21 = ""
	local v22 = ""

	for k, responder in pairs(v10.Responders) do
		if flag2 then
			flag2 = false
		else
			v21 ..= "\r\n"
			v22 ..= "\r\n"
		end

		v21 ..= k

		if responder.s then
			local v23 = v19[responder.s]

			if v23 then
				v22 ..= mMovie:__wf_atom_8e9ac384(" <" .. v23 .. ">", true)
			end
		end

		if responder.k then
			v22 ..= module2.FormatNumber(responder.k)
		end

		if not responder.h then
			continue
		end

		if responder.h == -1 then
			v22 ..= " " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/DeadPlayer", false)
		elseif responder.h == -2 then
			v22 ..= " [HC] DOWN"
		else
			local _ = responder.h == 0
		end
	end

	mMovie:__wf_atom_50d60589("Notification.Action", 36, v21)
	mMovie:__wf_atom_50d60589("Notification.PlayerValues", 36, v22)
	fn4()
end

local function fn6(_, vaults)
	v10.Vaults = vaults
	fn4()
end

local function fn7(_, progress)
	if v10.Exterminate == nil then
		v10.Exterminate = {}
	end

	v10.Exterminate.Progress = progress
	fn4()
end

local function fn8(_, total)
	if v10.Exterminate == nil then
		v10.Exterminate = {}
	end

	v10.Exterminate.Total = total
	fn4()
end

local function fn9(_, responders)
	for k, responder in pairs(responders) do
		__wf_atom_f2daf912("SquadLink - Responder Status: " .. k .. " " .. responder.s)
	end

	v10.Responders = responders
	fn5()
end

local function fn10()
	local color = module.GetColor(9, false)
	local color2 = module.GetColor(2, false)
	local color3 = module.GetColor(6, true)
	v11 = color:__wf_atom_dcecedb0()
	local color4 = module.GetColor(10, true)
	v12 = module.GetColor(11, true)
	v13 = module.GetColor(12, true)
	v15 = module2.ConvertColorNumberToHex(color3)
	v14 = module2.ConvertColorNumberToHex(v11)
	mMovie:__wf_atom_1ca72041(
		"Notification.Bg",
		"RectEdgeColor",
		color.red / 255,
		color.green / 255,
		color.blue / 255,
		0.15
	)
	mMovie:__wf_atom_1ca72041(
		"Notification.Bg",
		"RectInnerColor",
		color2.red / 255,
		color2.green / 255,
		color2.blue / 255,
		0.4
	)
	mMovie:__wf_atom_e57658c2("Notification.Title", 44, v11)
	mMovie:__wf_atom_4c1c1986("Notification.TimedObjectives.Objective" .. 1, "Time", 44, color4)
	mMovie:__wf_atom_4c1c1986("Notification.TimedObjectives.Objective" .. 2, "Time", 44, color4)
	mMovie:__wf_atom_4c1c1986("Notification.TimedObjectives.Objective" .. 3, "Time", 44, color4)
	mMovie:__wf_atom_e57658c2("Notification.TextObjective", 44, color3)
	fn5()
end

local function fn11() -- 1 equivalent call inferred from this helper
	if _T.ScenarioStateChangeHandlers then
		_T.ScenarioStateChangeHandlers.Responders = nil
	end

	mMovie:Close()
end

local function fn12(p)
	__wf_atom_ec43d06e(mMovie, "Notification", 2, { 0 }, { -370 }, 0.25, 0, function()
		if not p then
			fn11() -- inferred equivalent call
		end
	end)
end

local function fn13()
	__wf_atom_ec43d06e(mMovie, "Notification", 4, { 0 }, { 0 }, 0.25)
end

local function fn14(p)
	if v4 == p then
		return
	end

	v4 = p

	if v4 == v.ADVERTISING then
		if not __wf_atom_7e8ad928(v5) then
			v5:Close()
		end

		if not __wf_atom_7e8ad928(acceptedMovie) then
			v5 = mMovie:PushChildMovie(acceptedMovie)
		end

		v16 = 10
	elseif v4 == v.CREATING then
		if not __wf_atom_7e8ad928(v5) then
			v5:Execute("SetShrunk", "")
		end

		fn()
		mMovie:__wf_atom_7d7314f1("Notification.Title.text", "/Lotus/Language/SquadLink/Create")
		mMovie:__wf_atom_7d7314f1("Notification.Action.text", "/Lotus/Language/SquadLink/Send")
	elseif v4 == v.SEARCHING then
		v6 = 0
		v3:SetActive(true)
		mMovie:__wf_atom_2dedec1a("Notification.Icon", 13, false)
		mMovie:__wf_atom_7d7314f1("Notification.Title.text", "/Lotus/Language/SquadLink/Sent")
		mMovie:__wf_atom_7d7314f1("Notification.Action.text", "/Lotus/Language/SquadLink/WaitingReply")
	elseif v4 == v.WAITING_FOR_PLAYERS then
		mMovie:__wf_atom_7d7314f1("Notification.Title.text", "/Lotus/Language/SquadLink/Received")
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/SquadLink/WaitingAcknowledge", false, {
			SECONDS = math.ceil(v7),
			PLAYER_NAME = name
		})
		mMovie:__wf_atom_7d7314f1("Notification.Action.text", __wf_atom_8e9ac384)
	elseif v4 == v.JOIN_TIMEOUT then
		v7 = -1
		v8 = 5
		mMovie:__wf_atom_7d7314f1("Notification.Title.text", "/Lotus/Language/SquadLink/Timeout")
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			module2.Ternary(v9, "/Lotus/Language/SquadLink/TimeoutDeclined", "/Lotus/Language/SquadLink/TimeoutRetry"),
			false,
			{ SECONDS = math.ceil(v8), PLAYER_NAME = name }
		)
		mMovie:__wf_atom_7d7314f1("Notification.Action.text", __wf_atom_8e9ac384)
	elseif v4 == v.PROGRESS then
		if __wf_atom_7e8ad928(v5) and not __wf_atom_7e8ad928(acceptedMovie) and v3:IsActive() then
			v5 = mMovie:PushChildMovie(acceptedMovie)
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:Execute("SetAccepted", "")
		end

		if flag then
			gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
				Symbol("SquadLinkSearch"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
			)
			flag = false
		end

		fn13()
		v6 = -1
		v7 = -1
		v8 = -1
		v3:SetActive(false)
		mMovie:__wf_atom_2dedec1a("Notification.Icon", 13, true)

		if not gGameRules:IsA(__wf_atom_311a7128) then
			gGameRules:__wf_atom_0ab0a47f(Symbol("SquadLink_AcceptingLinks"))
		end

		_T.ScenarioSendBeaconRequest = nil
		_T.ScenarioAdvertisingInfo = nil

		if
			name == nil
			and (not _T.ScenarioInitiator or gRegion:__wf_atom_eab484a7():__wf_atom_6be84646() ~= _T.ScenarioInitiator)
		then
			local scenarioInitiator = _T.ScenarioInitiator
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/SquadLink/ProgressClientStatus",
				false,
				{ PLAYER_NAME = scenarioInitiator }
			)
			mMovie:__wf_atom_7d7314f1("Notification.Action.text", __wf_atom_8e9ac384)
		else
			_T.ScenarioStateChangeHandlers = _T.ScenarioStateChangeHandlers or {}
			_T.ScenarioStateChangeHandlers.Responders = fn9
			v10 = {}
		end

		mMovie:__wf_atom_7d7314f1("Notification.Title.text", "/Lotus/Language/SquadLink/InProgress")
	elseif v4 == v.ABORT then
		_T.PendingScenarioHubShutdown = true
		mMovie:__wf_atom_7d7314f1("Notification.Action.text", "/Lotus/Language/Menu/NavBar_QuickMatchAborting")
	elseif v4 == v.SUCCESS then
		_T.PendingScenarioHubShutdown = true
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(successMovie)

		if not __wf_atom_7e8ad928(successSound) then
			module2.PlaySound(successSound)
		end
	elseif v4 == v.FAILED then
		_T.PendingScenarioHubShutdown = true
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(successMovie)

		if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
			__wf_atom_5d67a2c5:Execute("SetFailed", "true")
		end

		if not __wf_atom_7e8ad928(successSound) then
			module2.PlaySound(successSound)
		end
	elseif v4 == v.CLOSING then
		fn12()
	end

	fn4()
end

function StartSquadLinkSearch(p)
	if flag and p == 1 then
		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("SquadLinkSearch"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
		)
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("SquadLinkSearch"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS"),
			"StopSquadLinkSearch"
		)
		_T.ScenarioSendBeaconRequest = true
	end
end

function StopSquadLinkSearch(p)
	if flag and p == 1 then
		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("SquadLinkSearch"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
		)
		flag = false
		_T.ScenarioSendBeaconRequest = nil
		fn14(v.ABORT)
	end
end

function Initialize()
	_T.SQUADLINK_VaultStatusChanged = fn6
	_T.SQUADLINK_ExterminateKillProgressChanged = fn7
	_T.SQUADLINK_ExterminateKillTotalChanged = fn8
	mMovie:__wf_atom_e57658c2("Notification", 0, -370)
	local module4 = require("Lotus.Interface.Components.ThemedSpinner")
	v3 = module4.Create(mMovie, "Notification.Spinner")
	v3:SetScale(30)
	v3:SetActive(false)
	mMovie:__wf_atom_2dedec1a("Notification.Icon", 13, true)
	mMovie:__wf_atom_e57658c2("Notification.Icon", 12, module2.Ternary(not __wf_atom_7e8ad928(iconTexture), 100, 0))
	mMovie:__wf_atom_c90af43a("Notification.Icon", iconTexture)
	mMovie:__wf_atom_e57658c2("Notification.BgIcon", 12, module2.Ternary(not __wf_atom_7e8ad928(iconTexture), 50, 0))
	mMovie:__wf_atom_c90af43a("Notification.BgIcon", bgIconTexture)
	mMovie:OverrideMaterial("Notification.Bg", _G.UIMaterial_Button)
	v17 = mMovie:__wf_atom_5e6e15c8("Notification", 1)
	fn10()
	fn2()

	if _T.ScenarioSendBeaconRequest and not gMatchingService:__wf_atom_d309183e() then
		fn14(v.CREATING)
	elseif not __wf_atom_7e8ad928(gGameRules) and gMatchingService:__wf_atom_d309183e() then
		fn14(v.PROGRESS)
	elseif _T.ScenarioAdvertisingInfo then
		fn14(v.ADVERTISING)
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("SquadLinkSearch"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS"),
			"StartSquadLinkSearch"
		)
		flag = true
	end
end

function Update()
	local v21 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v21)

	if not __wf_atom_7e8ad928(v3) then
		v3:Update()
	end

	if v2 > 0 then
		v2 -= v21

		if v2 <= 0 then
			fn12()
		end
	end

	if v4 == v.CUSTOM then
		return
	end

	function _T.SquadLinkCompleteUICallback(p)
		_T.SquadLinkCompleteUICallback = nil

		if p == 1 then
			fn14(v.SUCCESS)
		else
			fn14(v.FAILED)
		end
	end

	if v4 == v.ABORT then
		if not gMatchingService:__wf_atom_d309183e() then
			fn14(v.CLOSING)
		end
	elseif v4 == v.ADVERTISING then
		if _T.ScenarioSendBeaconRequest then
			fn14(v.CREATING)
			return
		end

		if not _T.ScenarioAdvertisingInfo or v16 <= 0 then
			fn14(v.CLOSING)
			return
		end

		local v22 = math.floor(v16 * 10)
		v16 -= v21
		local v23 = math.floor(v16 * 10)

		if v23 ~= v22 and not __wf_atom_7e8ad928(v5) then
			local v24 = string.format(
				"%.1f    %s",
				math.max(v23 / 10, 0),
				v5:__wf_atom_8e9ac384("/Lotus/Language/SquadLink/SendHint", true)
			)
			v5:__wf_atom_7d7314f1("Desc.Description.text", v24)
		end
	elseif v4 == v.SUCCESS then
		fn14(v.CLOSING)
	elseif v4 == v.FAILED then
		fn14(v.CLOSING)
	elseif _T.CreatingScenarioBeacon and gMatchingService:__wf_atom_d309183e() then
		if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
			if not gMatchingService:IsBlockingTaskPending() then
				_T.SquadOverlay:Execute("HostLobby", "")
			end
		else
			_T.CreatingScenarioBeacon = false
			_T.ScenarioBeaconInvite = true

			if _T.InitScenario then
				local v22 = not _T.ScenarioState and {} or _T.ScenarioState
				local encoded = cjson.encode(v22)
				gMatchingService:__wf_atom_6ff767a1("all", cjson.encode({
					eventData = {
						{ eventName = "Init", state = encoded }
					}
				}))
				_T.InitScenario = nil
			end

			fn14(v.SEARCHING)
		end
	elseif v4 == v.PROGRESS and not gMatchingService:__wf_atom_d309183e() then
		fn14(v.ABORT)
	elseif
		(v4 == v.SEARCHING or v4 == v.WAITING_FOR_PLAYERS or v4 == v.JOIN_TIMEOUT)
		and _T.ScenarioPlayerCount
		and _T.ScenarioPlayerCount > 1
	then
		fn14(v.PROGRESS)
	elseif v6 >= 0 then
		local v22 = v6
		v6 -= __wf_atom_fa1258d0()

		if v6 < 0 then
			local v23 = (not (_T.ScenarioAdvertisingInfo and _T.ScenarioAdvertisingInfo.beaconTag) and "SolNode228" or _T.ScenarioAdvertisingInfo.beaconTag) .. string.gsub(
				gRegion:__wf_atom_eab484a7():__wf_atom_7933a10d(),
				"%s",
				"|"
			)
			tag = v23
			gGameRules:SendBeaconRequest(Symbol(v23), "OnSendBeaconRequest")
		elseif math.floor(v6) ~= math.floor(v22) then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/SquadLink/WaitingReply", false)
			local v23

			if v6 >= 5 then
				v23 = __wf_atom_8e9ac384 .. " "
			else
				v23 = __wf_atom_8e9ac384 .. "."
			end

			local v24

			if v6 >= 4 then
				v24 = v23 .. " "
			else
				v24 = v23 .. "."
			end

			local v25

			if v6 >= 3 then
				v25 = v24 .. " "
			else
				v25 = v24 .. "."
			end

			local v26

			if v6 >= 2 then
				v26 = v25 .. " "
			else
				v26 = v25 .. "."
			end

			local v27

			if v6 >= 1 then
				v27 = v26 .. " "
			else
				v27 = v26 .. "."
			end

			mMovie:__wf_atom_7d7314f1("Notification.Action.text", v27)
		end
	elseif v7 > 0 then
		local v22 = v7
		v7 -= __wf_atom_fa1258d0()

		if v7 < 0 then
			fn14(v.JOIN_TIMEOUT)
		elseif math.floor(v7) ~= math.floor(v22) then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/SquadLink/WaitingAcknowledge",
				false,
				{ SECONDS = math.ceil(v7), PLAYER_NAME = name }
			)
			mMovie:__wf_atom_7d7314f1("Notification.Action.text", __wf_atom_8e9ac384)
		end
	elseif v8 > 0 then
		local v22 = v8
		v8 -= __wf_atom_fa1258d0()

		if v8 < 0 then
			name = ""
			fn14(v.SEARCHING)
		elseif math.floor(v8) ~= math.floor(v22) then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				module2.Ternary(
					v9,
					"/Lotus/Language/SquadLink/TimeoutDeclined",
					"/Lotus/Language/SquadLink/TimeoutRetry"
				),
				false,
				{ SECONDS = math.ceil(v8), PLAYER_NAME = name }
			)
			mMovie:__wf_atom_7d7314f1("Notification.Action.text", __wf_atom_8e9ac384)
		end
	elseif v4 == v.PROGRESS then
		fn3(v21)
	end
end

function Shutdown()
	if flag then
		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("SquadLinkSearch"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
		)
		flag = false
	end

	if not (__wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_311a7128)) then
		gGameRules:__wf_atom_0ab0a47f(Symbol("SquadLink_AcceptingLinks"))
	end

	_T.ScenarioSendBeaconRequest = nil
	_T.ScenarioAdvertisingInfo = nil
	_T.SQUADLINK_VaultStatusChanged = nil
	_T.SQUADLINK_ExterminateKillProgressChanged = nil
	_T.SQUADLINK_ExterminateKillTotalChanged = nil

	if not __wf_atom_7e8ad928(v5) then
		v5:Close()
	end
end

function OnStyleChangedCallback()
	fn10()
end

function SupportsThemes()
	return true
end

function OnSendBeaconRequest(p, p2)
	if v4 == v.ABORT then
		return
	end

	if p then
		local decoded = cjson.decode(p2)

		if __wf_atom_7e8ad928(decoded) or #decoded == 0 then
			print("no responses to beacon, retrying in " .. 5)
			v6 = 5
			count += 1

			if count > 5 then
				_T.ScenarioSendBeaconRequest = nil
				gGameRules:__wf_atom_0ab0a47f(Symbol("SquadLink_AcceptingLinks"))
				gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
					Symbol("SquadLinkSearch"),
					__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS")
				)
				gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
					Symbol("SquadLinkSearch"),
					__wf_atom_8e4fda44:__wf_atom_e7d83c15("VIEW_RAILJACK_SYSTEMS"),
					"StartSquadLinkSearch"
				)
				flag = true
				count = 0
				fn14(v.ADVERTISING)
			end
		else
			local loadOut

			if __wf_atom_7e8ad928(gGameData) then
				loadOut = ""
			else
				local __wf_atom_d21f18f2 = gGameData:__wf_atom_a4299765():__wf_atom_d21f18f2(0, 0)
				loadOut = SF.GameInviteLoadOutInfo(__wf_atom_d21f18f2):__wf_atom_1e82fc88()
			end

			local encoded = cjson.encode({
				name = tostring(gMatchingService:__wf_atom_706d8455()),
				tag = tag,
				quest = "",
				difficulty = "",
				loadOut = loadOut
			})
			gMatchingService:__wf_atom_b83bc045(
				decoded[1].accountId,
				decoded[1].name,
				encoded,
				"SendGameInviteCallback"
			)
			v7 = 20
			name = decoded[1].name
			v9 = false
			count = 0
		end
	elseif not __wf_atom_7e8ad928(_T.ShowNotification) then
		_T.ShowNotification("Failed to activate beacon")
	end
end

function SendGameInviteCallback(value)
	if value then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/SocialOverlay_GameInviteDeclined",
			false,
			{ PLAYER = "" }
		)

		if string.find(value, __wf_atom_8e9ac384) then
			v9 = true
			fn14(v.JOIN_TIMEOUT)
		elseif v4 == v.WAITING_FOR_PLAYERS then
			fn14(v.PROGRESS)
		elseif v4 == v.SEARCHING then
			fn14(v.WAITING_FOR_PLAYERS)
		end
	else
		print("SendGameInviteCallback: " .. tostring(value))
		fn14(v.JOIN_TIMEOUT)
	end
end

function SetCustom(p, p2, p3)
	mMovie:__wf_atom_7d7314f1("Notification.Title.text", p)
	mMovie:__wf_atom_7d7314f1("Notification.Action.text", p2)
	v2 = tonumber(p3)
	v3:SetActive(false)
	mMovie:__wf_atom_2dedec1a("Notification.Icon", 13, true)
	fn14(v.CUSTOM)
end

function AbortBeacon()
	fn14(v.ABORT)
end

function ShowBeaconReward(p, p2)
	if not __wf_atom_7e8ad928((__wf_atom_8e4fda44:__wf_atom_8b74c30b(v20))) then
		_T.DisplayReward(Resource(p), p2)
	end
end