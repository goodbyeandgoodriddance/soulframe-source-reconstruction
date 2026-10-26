local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Scripts.Libs.JobLib")
local module5 = require("Lotus.Scripts.HudTrackers")
local v = nil

local function fn(state)
	state.UIColor_LightBlue = 12769497
	state.UIColor_MediumBlue = 8100006
	state.UIColor_DarkBlue = 4546669
	state.UIColor_MediumGrey = 8421504
	state.UIColor_DarkGrey = 2368548
	state.UIColor_Yellow = 15258973
	state.UIColor_Orange = 13466625
	state.UIColor_Gold = 16763904
	state.UIColor_Health = 13379881
	state.UIColor_Shield = 54783
	state.UIColor_Overshield = 11731199
	state.UIColor_Stamina = 4502359
	state.UIColor_Armor = 14591541
	state.UIColor_Red = 13108230
	state.UIColor_Green = 9298982
	state.UIColor_LightGreen = 12118144
	state.UIColor_White = 15724527
	state.UIColor_Black = 0
	state.UIColor_PositiveReputation = 5030911
	state.UIColor_NegativeReputation = 16731212
	state.UIColor_OpposedReputation = 15647744
	state.UIColor_PvpTeamOne = 15044409
	state.UIColor_PvpTeamTwo = 3000544
	state.UIColor_PvpKill = 15945236
	state.UIColor_Hyperlink = 3394815
	state.UIColorObject_White = module.ConvertColorNumberToProceduralRGB(state.UIColor_White)
	state.UIColorObject_Black = module.ConvertColorNumberToProceduralRGB(state.UIColor_Black)
	state.UIColorObject_Yellow = module.ConvertColorNumberToProceduralRGB(state.UIColor_Yellow)
	state.UIColorObject_DarkBlue = module.ConvertColorNumberToProceduralRGB(state.UIColor_DarkBlue)
end

local v2 = -1
local v3 = nil
local v4 = {}
local flag = false

local function fn2(removeHudTracker, ...)
	if flag then
		removeHudTracker(...)
		return
	end

	table.insert(v4, { removeHudTracker, ... })

	if #v4 > 400 and _G.functionQueueOverflow == nil then
		LogBug("DS queue overflow")
		_G.functionQueueOverflow = true
	end
end

function OnSquadCountdown(squadCountdownTimer)
	local v5 = not __wf_atom_7e8ad928(_T.gPendingMission)
		and string.find(tostring(_T.gPendingMission.name), module2.HUB_TAG)
		and gMatchingService:__wf_atom_5529af13() == tostring(_T.gPendingMission.name)
		and true
		or false

	if squadCountdownTimer <= 5.9 and squadCountdownTimer > 0 and not v5 then
		print("OnSquadCountdown: " .. squadCountdownTimer)
	end

	local v6 = v2
	v2 = squadCountdownTimer
	_T.SquadCountdownTimer = squadCountdownTimer

	if v2 == -1 then
		return
	end

	if _T.gPendingMission and v6 == -1 and v2 > 0 then
		if string.find(tostring(_T.gPendingMission.name), module2.HUB_TAG) then
			v2 = 5.9
		else
			v2 = module.Ternary(_T.gActiveMatchMakingMode == _T.MATCHMAKING_QUICKMATCH_GAMEMODE, 10.9, 5.9)
		end

		print("Is Host - showing play now. Countdown time=" .. tostring(v2))
		gMatchingService:SquadSetCountdownTimer(v2)
	else
		local gPendingMission = _T.gPendingMission
		local v7 = squadCountdownTimer <= 0
		local v8, v9

		if not (__wf_atom_7e8ad928(gPendingMission) or __wf_atom_7e8ad928(gPendingMission.name)) then
			v8, v9 = module2.GetMissionVoteInfo(__wf_atom_0a47125f, gPendingMission, v7)
		end

		if v8 and v9 and squadCountdownTimer <= 0 then
			print("Mission name: " .. tostring(v9))

			if
				(gMatchingService:__wf_atom_1b24a1bb() or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) and _T.gActiveMatchMakingMode == _T.MATCHMAKING_OFFLINE_GAMEMODE)
				and not __wf_atom_7e8ad928(v3)
				and _T.SetActiveJob
			then
				_T.SetActiveJob(v3, 0)
				v3 = nil
				v2 = -1
				_T.gPendingMission = nil
			end
		end
	end
end

local function fn3() end

local function fn4()
	print("DS ClearVotesPostJob")
	_T.gPendingMission = nil
	_T.gDojoData = nil
	module3.ResetSquadMission(false)

	if _T.ActiveJob and _T.CancelActiveJob then
		_T.CancelActiveJob()
	end

	v2 = -1
	_T.gPendingMission = nil

	if gMatchingService:__wf_atom_1b24a1bb() then
		gMatchingService:SetSquadMissionReady(false)

		if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
			local settings = gMatchingService:__wf_atom_15811761():GetSettings()
			settings:__wf_atom_c2db5000()

			if _T.PreBountySessionRegionId ~= nil then
				settings.regionId = _T.PreBountySessionRegionId
				_T.PreBountySessionRegionId = nil
			end

			gMatchingService:__wf_atom_c8d901d4(settings, fn3)
		end
	end
end

function OnSquadMissionSelected(_, p)
	if _T.DS_CancelMission then
		return
	end

	print("OnSquadMissionSelected " .. tostring(p))
	local decoded

	if p and p ~= "" then
		decoded = cjson.decode(p)

		if decoded.jobLevelGenerationSeed and not decoded.jobId then
			print("Client trying to cancel")
			_T.DS_CancelMission = true
			fn4()
			_T.DS_CancelMission = nil
			return
		else
			if decoded.name == nil then
				decoded = nil
			end

			if decoded and decoded.requiredItems ~= nil then
				local requiredItems = {}

				for _, requiredItem in pairs(decoded.requiredItems) do
					table.insert(requiredItems, Resource(requiredItem))
				end

				decoded.requiredItems = requiredItems
			end
		end
	end

	if __wf_atom_7e8ad928(_T.gPendingMission) and decoded then
		_T.gPendingMission = decoded

		if _T.gPendingMission.name then
			local name = _T.gPendingMission.name
			local v5 = string.find(name, module2.TAG_SEPERATOR)

			if v5 then
				string.sub(name, v5, (string.len(name)))
				name = string.sub(name, 1, v5 - 1)
			end

			_T.gPendingMission.name = Symbol(_T.gPendingMission.name)
			_T.gPendingMission.baseNodeName = Symbol(name)
		end

		if not __wf_atom_7e8ad928(_T.gPendingMission.job) then
			v3 = module4.GetJobFromMission(_T.gPendingMission)
		end
	end
end

function DedicatedServerInit()
	function _T.ShowWeaponPanel(...) end

	function _T.HideWeaponPanel(...) end

	function _T.ShowAbilityPanel(...) end

	function _T.HideAbilityPanel(...) end

	function _T.SetAbilityTimer(...) end

	function _T.AddAbilityTimer(...) end

	function _T.SetFocusTimer(...) end

	function _T.AddLogMessage(...) end

	function _T.AddPvpKillMessage(...) end

	function _T.ShowImpactMessage(...) end

	function _T.HideImpactMessage(...) end

	_T.AddHudTracker = module5.AddHudTracker

	function _T.RemoveHudTracker(...)
		fn2(module5.RemoveHudTracker, ...)
	end

	_T.GetHudTracker = module5.GetHudTracker
	local module6 = require("Lotus.Interface.Libs.TimerMgr")
	v = module6.CreateTimerMgr()
	module5.Initialize(nil, nil, v, {}, nil, fn2, nil)
	fn(_T)
	fn(_G)
	gMatchingService:__wf_atom_d5084db1("OnSquadCountdown")
	gMatchingService:__wf_atom_136b526f("OnSquadMissionSelected")

	function _T.ClearVotesPostJob()
		fn4()
	end
end

local v5 = Symbol("IdleFailTimer")

local function fn5()
	module5.MissionTimerWaitBeforeEndMission()
end

local function fn6()
	if
		gGameRules:__wf_atom_074a5c37(v5)
		and gGameRules:__wf_atom_a4ec8f85(v5) <= 0
		and gGameRules:__wf_atom_d2a1d577(v5)
	then
		v:AddTimer(1.5, fn5)
	end
end

function DedicatedServerUpdate(_, p)
	if not __wf_atom_7e8ad928(v) then
		v:Update(p)
	end

	flag = true

	if #v4 > 0 then
		for i = 1, #v4 do
			v4[i][1](
				v4[i][2],
				v4[i][3],
				v4[i][4],
				v4[i][5],
				v4[i][6],
				v4[i][7],
				v4[i][8],
				v4[i][9],
				v4[i][10],
				v4[i][11],
				v4[i][12]
			)
		end

		v4 = {}
	end

	flag = false
	module5.UpdateHudTrackers(p)
	fn6()
end

local v6 = nil

function ShipReady(p)
	print("ShipReady")

	if __wf_atom_7e8ad928(p) then
		v6 = false
		return
	end

	print("ShipReady - success")
	v6 = p
end

local function fn7(object, p, object2, p2)
	local mItemType = nil
	v6 = nil
	local flag2

	if p.mShip.mItemId.mId == SF.__wf_atom_b8679e91 then
		flag2 = false
	else
		mItemType = p.mShip.mItemType
		flag2 = true
	end

	if __wf_atom_7e8ad928(mItemType) then
		return
	end

	local v7 = Type(mItemType)
	gRegion:__wf_atom_2202ffb6():SetEnabled(true)

	if flag2 then
		object:__wf_atom_6eff7563(p, true, true, "ShipReady", 260)
	elseif not __wf_atom_7e8ad928(v7) then
		object:__wf_atom_e7ef60d9(v7, nil, true, true, "ShipReady", 260)
	end

	while v6 == nil do
		Sleep(0)
	end

	print("CREWSHIP Loaded")
	print("RJ GoToMission - " .. tostring(p2))
	_T.RailJackNextMissionNode = Symbol(p2)
	_T.SeamlessRailJackTransition = gGameRules:IsA(__wf_atom_311a7128)
	local __wf_atom_d5226f21 = object2:__wf_atom_d5226f21(Symbol("CrewShipGenericTunnel"))
	gGameRules:__wf_atom_257dee98():__wf_atom_f7aa6106(__wf_atom_d5226f21.mission)
end

local function fn8(p, name)
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	while __wf_atom_7e8ad928(__wf_atom_257dee98) do
		Sleep(0.1)
		__wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()
	end

	fn7(__wf_atom_257dee98, nil, p, name)

	if v6 ~= false and not __wf_atom_7e8ad928(v6) then
		v6:__wf_atom_6009c8ed():SetHyperDriveState(4)
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v7 in ipairs(__wf_atom_ef7900cf) do
			local _ = v7:__wf_atom_d2b2176d():__wf_atom_5d9ae734() == v6
		end

		v6:__wf_atom_14f6a24d(Symbol("WarpOn"))
		v6:__wf_atom_14f6a24d(Symbol("SetupRailjackGameRules"))
		v6:__wf_atom_14f6a24d(Symbol("StreamVoidTunnel"))
	end
end

local function fn9(name) -- 1 equivalent call inferred from this helper
	if name == "CetusHub4_HUB" then
		return Symbol("SolNode228")
	elseif name == "SolarisUnitedHub1_HUB" then
		return Symbol("SolNode129")
	elseif name == "DeimosHub_HUB" then
		return Symbol("SolNode229")
	end

	print("Could not find landscape for " .. name)
	return EMPTY_SYMBOL
end

function DedicatedServerLoadMission(p, p2)
	local decoded = cjson.decode(p2)
	local name = decoded.name
	decoded.name = Symbol(decoded.name)

	if string.find(name, module2.HUB_TAG) then
		decoded.name = fn9(name) -- inferred equivalent call
	end

	if not decoded.baseNodeName then
		print("Has no base node name")
		local name2 = decoded.name
		local v7

		if name2 then
			v7 = tostring(name2)
			local v8 = string.find(v7, module2.TAG_SEPERATOR)

			if v8 ~= nil then
				v7 = string.sub(v7, 1, v8 - 1)
			end
		else
			v7 = ""
		end

		decoded.baseNodeName = Symbol(v7)
		print("Base node name after: " .. tostring(decoded.baseNodeName))
	end

	local missionVoteInfo, _ = module2.GetMissionVoteInfo(p, decoded, true)
	print("Pending mission name: " .. tostring(decoded.name))

	if string.find(tostring(decoded.name), "CrewBattle") then
		fn8(p, decoded.name)
	else
		module3.Host_LoadMission(
			decoded.name,
			missionVoteInfo,
			module.Ternary(not __wf_atom_7e8ad928(missionVoteInfo.levelKeyName), missionVoteInfo.levelKeyName, nil),
			false
		)
	end
end