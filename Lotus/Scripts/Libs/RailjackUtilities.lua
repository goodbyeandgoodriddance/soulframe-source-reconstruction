module(..., package.seeall)
POI_APPROACH_DISTANCE = 300
SUB_OBJECTIVE_COMPLETE = 10
CAPITAL_SHIP_APPROACH_DISTANCE = 900
POI_COMPLETION_XP = 10000
POI_COMPLETION_LOC = "/Lotus/Language/CorpusRailjack/PoiCompletedXpAward"
NOT_READY_STATUS = 0
GOOD_STATUS = 1
FAIR_STATUS = 2
CRITICAL_STATUS = 3
SYM_POI_HINT_TAG = Symbol("PointOfInterestHint")
SYM_POI_MISSION_HINT_TAG = Symbol("PoiMissionHint")
SYM_POI_MISSION_TAG = Symbol("PoiMission")
SYM_POI_LOOT_DUNGEON_TAG = Symbol("LootDungeon")
SYM_POI_TAG = Symbol("POI")
SYM_CAPITAL_SHIP_TAG = Symbol("CapitalShip")
local v = WeakResource("/Lotus/Types/Game/CrewShip/EnterRailJack")
local v2 = WeakResource("/Lotus/Types/Game/CrewShip/ExitShip")
local v3 = WeakResource("/Lotus/Types/Game/MarkerInfos/EnterShipObjectiveMarkerInfoNoReticleAlwaysInRange")
local v4 = WeakResource("/Lotus/Types/Game/MarkerInfos/ExitMarkerInfo")
local v5 = WeakResource("/Lotus/Types/Game/CrewShip/PointOfInterestAgent")
local v6 = WeakResource("/Lotus/Types/Game/CrewShip/PointOfInterestAvatar")
local v7 = Symbol("POI TIER 0")
local v8 = Symbol("POI TIER 1")
local v9 = Symbol("POI TIER 2")
local v10 = Symbol("POI TIER 3")
local v11 = Symbol("POI TIER 4")
local v12 = { 3, 0, 1, 4, 2 }
local v13 = Symbol("HangarRefPoint")
local v14 = Symbol("RJAbilityDelayCheck")
local v15 = Symbol("RJSubMissionStarted")
local module = require("Lotus.Interface.LotusUtilities")

local function fn(object, object2, p, p2)
	object:__wf_atom_267bfc41(object2:GetPosition(), p, p2)
	object:__wf_atom_56c0cff9(true)
	object:__wf_atom_2ce9f9a3(12)
	object:__wf_atom_ce415137(10)
	object:__wf_atom_06c7577b()
	object:__wf_atom_24161393()
	object:Start()

	while not object:__wf_atom_2ddd6354() do
		Sleep(0.1)
	end

	return object
end

function GetSpawnPositionQuery(p, p2, p3, p4)
	return (fn(p, p2, p3, p4))
end

function IsInCapitalShip(object)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return nil
	end

	return __wf_atom_e800787c:__wf_atom_dd89d98c() == 1
end

function NumOfTennoOnRailjackShip()
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return 0
	end

	return __wf_atom_257dee98:__wf_atom_0e4f587f()
end

function GetTennoOnRailjack()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local result = {}

	for i = 1, #__wf_atom_ef7900cf do
		local v16 = __wf_atom_ef7900cf[i]

		if __wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(v16:__wf_atom_d2b2176d():__wf_atom_5d9ae734()) then
			continue
		end

		if not v16:__wf_atom_d2b2176d():__wf_atom_5d9ae734():__wf_atom_e5a7c293() then
			continue
		end

		table.insert(result, v16)
	end

	return result
end

local function fn2(object) -- 1 equivalent call inferred from this helper
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return nil
	end

	return __wf_atom_e800787c:__wf_atom_dd89d98c() == 1
end

function NumOfTennoOnCapitalShip()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local count = 0

	for i = 1, #__wf_atom_ef7900cf do
		local v16 = __wf_atom_ef7900cf[i]

		if __wf_atom_7e8ad928(v16) or fn2(v16) ~= true then -- inferred equivalent call
			continue
		end

		count += 1
	end

	return count
end

function ZoneCheckArray(p, list)
	local result = {}

	for i = 1, #list do
		if list[i]:__wf_atom_e800787c():__wf_atom_db682341() == p then
			table.insert(result, list[i])
		end
	end

	return result
end

local function fn3(p, object)
	local v16 = {}

	if __wf_atom_7e8ad928(object) then
		return v16
	end

	local result = gRegion:__wf_atom_2226b35c(p)
	local count = #result
	local v17 = 1

	while v17 <= count do
		if object:__wf_atom_e82540fe(result[v17]) then
			v17 += 1
		else
			result[v17] = result[count]
			result[count] = nil
			count -= 1
		end
	end

	return result
end

local function fn4(p, object)
	local v16 = {}

	if __wf_atom_7e8ad928(object) then
		return v16
	end

	local all = gRegion:FindAll(p)

	for i = #all, 1, -1 do
		if not object:__wf_atom_e82540fe(all[i]) then
			table.remove(all, i)
		end
	end

	return all
end

function FindNpcAgentTypeOnShip(className, object)
	if __wf_atom_7e8ad928(object) then
		return className
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if __wf_atom_7e8ad928(__wf_atom_7d789620) then
		return className
	end

	local result = __wf_atom_7d789620:__wf_atom_fea8daa9(object:__wf_atom_5fd2f98b())
	local count = #result
	local v16 = 1

	while v16 <= count do
		if result[v16]:IsA(className) then
			v16 += 1
		else
			result[v16] = result[count]
			result[count] = nil
			count -= 1
		end
	end

	return result
end

function FindTypeOnShip(p, p2)
	return (fn4(p, p2))
end

function FindTaggedOnShip(p, p2)
	return (fn3(p, p2))
end

local function fn5(p, object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for i = #__wf_atom_2226b35c, 1, -1 do
		if object:__wf_atom_e82540fe(__wf_atom_2226b35c[i]) then
			return __wf_atom_2226b35c[i]
		end
	end

	return nil
end

local function fn6(p, object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local all = gRegion:FindAll(p)

	for i = #all, 1, -1 do
		if object:__wf_atom_e82540fe(all[i]) then
			return all[i]
		end
	end
end

function FindFirstTypeOnShip(p, p2)
	return fn6(p, p2)
end

function FindFirstTaggedOnShip(p, p2)
	return (fn5(p, p2))
end

local function fn7(object)
	local result = {}

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object) then
		return result
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for i = #__wf_atom_ef7900cf, 1, -1 do
		if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) or not object:__wf_atom_e82540fe(__wf_atom_ef7900cf[i]) then
			continue
		end

		table.insert(result, __wf_atom_ef7900cf[i])
	end

	return result
end

function GetPlayerAvatarsOnShip(p)
	return (fn7(p))
end

function IsPlayerAvatarOnShip(p, object)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return
	else
		return object:__wf_atom_e82540fe(p)
	end
end

function GetShipFromEntity(p)
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return nil
	end

	return __wf_atom_257dee98:GetShipFromEntity(p)
end

function GetMalfunctionSpawner()
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return nil
	end

	local __wf_atom_247a5d2e = __wf_atom_257dee98:__wf_atom_247a5d2e()

	if __wf_atom_7e8ad928(__wf_atom_247a5d2e) then
		return nil
	end

	local __wf_atom_6009c8ed = __wf_atom_247a5d2e:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return nil
	end

	return __wf_atom_6009c8ed:GetMalfunctionSpawner()
end

local function fn8(p, p2)
	if __wf_atom_7e8ad928(_T.RailjackSequences) then
		return false
	end

	for _, railjackSequence in ipairs(_T.RailjackSequences) do
		if railjackSequence.sequenceID ~= p2 then
			continue
		end

		for _, avatar in ipairs(railjackSequence.avatars) do
			if avatar == p then
				return true
			end
		end
	end

	return false
end

function IsRailjackSeqPlaying(p, p2)
	return (fn8(p, p2))
end

function SetRailjackSeqPlaying(p, sequenceID)
	if not fn8(p, sequenceID) then
		if __wf_atom_7e8ad928(_T.RailjackSequences) then
			_T.RailjackSequences = {}
		end

		local v16 = false

		for i, railjackSequence in ipairs(_T.RailjackSequences) do
			if railjackSequence.sequenceID ~= sequenceID then
				continue
			end

			table.insert(_T.RailjackSequences[i].avatars, p)
			v16 = true
		end

		if not v16 then
			table.insert(_T.RailjackSequences, {
				sequenceID = sequenceID,
				avatars = { p }
			})
		end
	end
end

local function fn9(p, p2)
	if fn8(p, p2) then
		for i, railjackSequence in ipairs(_T.RailjackSequences) do
			if railjackSequence.sequenceID ~= p2 then
				continue
			end

			for j, avatar in ipairs(railjackSequence.avatars) do
				if avatar ~= p then
					continue
				end

				table.remove(_T.RailjackSequences[i].avatars, j)
				break
			end

			if #_T.RailjackSequences[i].avatars ~= 0 then
				continue
			end

			table.remove(_T.RailjackSequences, i)
			return
		end
	end
end

local function fn10(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_f582136d = __wf_atom_6009c8ed:__wf_atom_f582136d(v)
	local result = {}

	if __wf_atom_7e8ad928(__wf_atom_f582136d) or not (#__wf_atom_f582136d > 0) then
		local __wf_atom_76724198 = __wf_atom_6009c8ed:__wf_atom_30e3d82b():__wf_atom_76724198()

		if __wf_atom_7e8ad928(__wf_atom_76724198) then
			return result
		end

		local __wf_atom_bc193479 = __wf_atom_76724198:__wf_atom_bc193479()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PoiMarker"))

		for _, v16 in ipairs(__wf_atom_2226b35c) do
			if v16:__wf_atom_bc193479() == __wf_atom_bc193479 then
				table.insert(result, v16)
			end
		end

		return result
	else
		for _, v16 in ipairs(__wf_atom_f582136d) do
			local __wf_atom_f582136d2 = v16:__wf_atom_f582136d(v3)

			for _, v17 in ipairs(__wf_atom_f582136d2) do
				table.insert(result, v17)
			end
		end

		return result
	end
end

function GetEnterMarkers(p)
	return (fn10(p))
end

local function fn11(p, p2)
	local v16 = fn10(p2)

	for _, v17 in ipairs(v16) do
		if p or not v17:IsEnabled() then
			if p and not v17:IsEnabled() then
				v17:Enable()
			end
		else
			v17:Disable()
		end
	end
end

function SetCrewShipEnterMarker(p, p2)
	fn11(p, p2)
end

function SetCrewShipEnterMarkerDisplayRange(p, p2)
	local v16 = fn10(p2)

	for _, v17 in ipairs(v16) do
		if v17:MarkerType() ~= 105 then
			v17:__wf_atom_14f387e1(p)
		end
	end
end

local function fn12(p, p2)
	local v16 = fn4(v2, p2)
	local __wf_atom_bb3e7833s = {}
	local v17 = nil

	for i = 1, #v16 do
		local __wf_atom_bb3e7833 = v16[i]:__wf_atom_bb3e7833(v4)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			continue
		end

		table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)

		if not __wf_atom_7e8ad928(v17) then
			continue
		end

		local __wf_atom_e800787c = __wf_atom_bb3e7833:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= Symbol("Exit") then
			continue
		end

		v17 = __wf_atom_bb3e7833
	end

	for _, v18 in ipairs(__wf_atom_bb3e7833s) do
		if p == false and v18:IsEnabled() then
			v18:Disable()
		elseif p == true then
			if not __wf_atom_7e8ad928(v17) and v18 ~= v17 then
				v18:__wf_atom_fb3c4935(1)
				v18:__wf_atom_14d8a2fd(false)
			end

			v18:__wf_atom_410ecf84(true, false)
			v18:__wf_atom_0088c689(7)

			if not v18:IsEnabled() then
				v18:Enable()
			end
		end
	end
end

function GetCrewShipExitAction(p)
	local v16 = fn4(v2, p)

	for i = 1, #v16 do
		local __wf_atom_e800787c = v16[i]:__wf_atom_e800787c()

		if not __wf_atom_7e8ad928(__wf_atom_e800787c) and __wf_atom_e800787c:__wf_atom_db682341() == Symbol("Exit") then
			return v16[i]
		end
	end
end

function GetCrewShipEnterActions(object)
	return (object:__wf_atom_6009c8ed():__wf_atom_f582136d(v))
end

function SetCrewShipExitMarker(p, p2)
	fn12(p, p2)
end

local function fn13(p, list)
	local __wf_atom_8e079833 = gGameRules:__wf_atom_257dee98():__wf_atom_8e079833(false)

	for i = 1, #__wf_atom_8e079833 do
		local v16 = __wf_atom_8e079833[i]
		local v17 = false

		for j = 1, #list do
			if v16 == list[j] then
				v17 = true
			end
		end

		if v17 ~= false then
			continue
		end

		local v18 = fn4(v2, v16)

		for j = 1, #v18 do
			local v19 = v18[j]

			if __wf_atom_7e8ad928(v19) then
				continue
			end

			local __wf_atom_f582136d = v19:__wf_atom_f582136d(v4)

			for k = 1, #__wf_atom_f582136d do
				local v20 = __wf_atom_f582136d[k]

				if __wf_atom_7e8ad928(v20) or p ~= false or not v20:IsEnabled() then
					if not __wf_atom_7e8ad928(v20) and p == true and not v20:IsEnabled() then
						v20:Enable()
					end
				else
					v20:Disable()
				end
			end
		end
	end
end

function SetAllCrewShipExitMarkers(p, p2)
	fn13(p, p2)
end

function ResetRailjackSeqPlaying(p, p2)
	fn9(p, p2)
end

function PopulateLootCrates(p, p2, p3, list)
	local v16 = fn3(p2, p)

	if __wf_atom_7e8ad928(v16) then
		return
	end

	for _, v17 in ipairs(list) do
		if not (__wf_atom_7abf2d2f() <= v17) then
			continue
		end

		local v18 = __wf_atom_5784a397(1, #v16)
		local v19 = v16[v18]
		gRegion:CreateEntity(p3, v19:GetPosition(), v19:__wf_atom_dc309f8a())
		table.remove(v16, v18)

		if #v16 == 0 then
			break
		end
	end
end

function ArePlayersNearEntity(p, p2)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v16 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_5d9ae734 = v16:__wf_atom_d2b2176d():__wf_atom_5d9ae734()
		local v17 = nil

		if __wf_atom_7e8ad928(__wf_atom_5d9ae734) then
			v17 = v16
		elseif __wf_atom_5d9ae734:__wf_atom_e5a7c293() then
			v17 = __wf_atom_5d9ae734:__wf_atom_6009c8ed()
		else
			local __wf_atom_91d76a5f = __wf_atom_5d9ae734:__wf_atom_91d76a5f(0)

			if not __wf_atom_7e8ad928(__wf_atom_91d76a5f) and __wf_atom_91d76a5f:__wf_atom_040adbbd() == v16 then
				v17 = __wf_atom_5d9ae734:__wf_atom_6009c8ed()
			end
		end

		if not __wf_atom_7e8ad928(v17) and v17:__wf_atom_8a6b8fc3(p) < p2 then
			return true
		end
	end

	return false
end

function GetNearestPlayerOrShip(p, p2)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v16 = nil

	for _, v17 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_5d9ae734 = v17:__wf_atom_d2b2176d():__wf_atom_5d9ae734()
		local v18 = nil

		if __wf_atom_7e8ad928(__wf_atom_5d9ae734) then
			v18 = v17
		elseif __wf_atom_5d9ae734:__wf_atom_e5a7c293() then
			v18 = __wf_atom_5d9ae734:__wf_atom_6009c8ed()
		else
			local __wf_atom_91d76a5f = __wf_atom_5d9ae734:__wf_atom_91d76a5f(0)

			if not __wf_atom_7e8ad928(__wf_atom_91d76a5f) and __wf_atom_91d76a5f:__wf_atom_040adbbd() == v17 then
				v18 = __wf_atom_5d9ae734:__wf_atom_6009c8ed()
			end
		end

		if
			not __wf_atom_7e8ad928(v18)
			and v18:__wf_atom_8a6b8fc3(p) < p2
			and (__wf_atom_7e8ad928(v16) or not __wf_atom_7e8ad928(v16) and v18:__wf_atom_8a6b8fc3(p) < v16:__wf_atom_8a6b8fc3(p))
		then
			return v18
		end
	end
end

local function fn14(p, p2)
	local result = gRegion:__wf_atom_2226b35c(p)
	local count = #result
	local v16 = 1

	while v16 <= count do
		if result[v16]:__wf_atom_bc193479() == p2 then
			v16 += 1
		else
			result[v16] = result[count]
			result[count] = nil
			count -= 1
		end
	end

	return result
end

function FindTaggedInScope(p, p2)
	return (fn14(p, p2))
end

function FindFirstTaggedInScope(p, p2)
	local v16 = fn14(p, p2)

	if #v16 > 0 then
		return v16[1]
	end

	return nil
end

function TeleportPlayersOutOfEnemyShips()
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if not __wf_atom_7e8ad928(__wf_atom_257dee98) then
		local __wf_atom_247a5d2e = __wf_atom_257dee98:__wf_atom_247a5d2e()
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v16 in ipairs(__wf_atom_ef7900cf) do
			local __wf_atom_5d9ae734 = v16:__wf_atom_d2b2176d():__wf_atom_5d9ae734()

			if __wf_atom_7e8ad928(__wf_atom_5d9ae734) or __wf_atom_5d9ae734 == __wf_atom_247a5d2e then
				continue
			end

			local __wf_atom_6009c8ed = __wf_atom_5d9ae734:__wf_atom_6009c8ed()

			if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
				continue
			end

			local __wf_atom_be6b2a2f = v16:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

			if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_3be5e2e6) then
				__wf_atom_be6b2a2f:FirePort("ForceUserToDismountNoAnim")
				v16:__wf_atom_e6ed03c8()
			end

			v16:Teleport(__wf_atom_6009c8ed:GetPosition(), __wf_atom_80368bb1)
		end
	end
end

local function fn15(object)
	local result = {}

	for _, v16 in pairs(v12) do
		local __wf_atom_91d76a5f = object:__wf_atom_91d76a5f(v16)

		if not __wf_atom_7e8ad928(__wf_atom_91d76a5f) then
			table.insert(result, __wf_atom_91d76a5f)
		end
	end

	return result
end

function GetShipEmplacements(p)
	return (fn15(p))
end

function DismountShipEmplacements(p, p2)
	local v16 = fn15(p)

	for _, v17 in pairs(v16) do
		v17:FirePort("ForceUserToDismount")

		if p2 then
			v17:Disable()
		end
	end
end

function SetShipEmplacementsEnabled(p, p2)
	local v16 = __wf_atom_7e8ad928(p2) and true or p2
	local v17 = fn15(p)

	for _, v18 in pairs(v17) do
		v18:FirePort("ForceUserToDismount")

		if v16 then
			v18:Enable()
		else
			v18:Disable()
		end
	end
end

function CreateCheatTracker()
	local v16 = _T.AddHudTracker("Cheat", 6)
	v16.SetLabel("<p><font face=\"Noto Sans\" color=\"#FF0000\">LotusGameRules.MissionDebug ENABLED</font></p>")
	v16.SetVisible(false)
end

function RemoveCheatTracker()
	local hudTracker = _T.GetHudTracker("Cheat")
	_T.RemoveHudTracker(hudTracker)
end

function UpdateCheatTracker()
	local hudTracker = _T.GetHudTracker("Cheat")

	if __wf_atom_7e8ad928(hudTracker) then
		return
	end

	if __wf_atom_72884638("LotusGameRules.MissionDebug") then
		hudTracker.SetVisible(true)
	else
		hudTracker.SetVisible(false)
	end
end

local function fn16(scenarioBeacon) -- 2 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(scenarioBeacon) or scenarioBeacon:IsKilled() or not scenarioBeacon:IsVisible() then
		return false
	end

	return true
end

function GetActiveBeacons()
	local scenarioBeacons = {}

	for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
		if fn16(scenarioBeacon) then -- inferred equivalent call
			table.insert(scenarioBeacons, scenarioBeacon)
		end
	end

	return scenarioBeacons
end

function GetNumActiveBeacons()
	local count = 0

	for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
		if fn16(scenarioBeacon) then -- inferred equivalent call
			count += 1
		end
	end

	return count
end

function GetNumBeaconsInInventories()
	local v16 = WeakResource("/Lotus/Types/Restoratives/ScenarioBeacon")
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v17 = { ACTIVE = 1, INACTIVE = 2, DESTROYED = 3 }
	local count = 0

	for _, v18 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_6be84646 = v18:__wf_atom_a96eb2aa():__wf_atom_6be84646()
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("OPLK_" .. __wf_atom_6be84646))
		local __wf_atom_d2b2176d = v18:__wf_atom_d2b2176d()

		if __wf_atom_d163c8e5 == v17.DESTROYED then
			continue
		end

		for i = 1, __wf_atom_d2b2176d:__wf_atom_62abd325(0) do
			local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i - 1, 0)

			if
				__wf_atom_7e8ad928(__wf_atom_ba1c3957)
				or not __wf_atom_ba1c3957:IsA(v16)
				or not (v18:__wf_atom_d2b2176d():__wf_atom_b62f2024(i - 1, 0) > 0)
			then
				continue
			end

			count += 1
		end
	end

	return count
end

function CalculateScenarioBeaconStatus()
	local v16 = {}

	for i = #_T.ScenarioBeacons, 1, -1 do
		if
			__wf_atom_7e8ad928(_T.ScenarioBeacons[i])
			or not _T.ScenarioBeacons[i]:IsVisible()
			or _T.ScenarioBeacons[i]:IsKilled()
		then
			table.insert(v16, 0)
		else
			table.insert(v16, _T.ScenarioBeacons[i]:__wf_atom_bb81a9df())
		end
	end

	local v17 = 0

	for i = 1, #v16 do
		v17 += v16[i]
	end

	if v17 > 0 then
		v17 /= #v16
	end

	local scenarioReadyForSquadSupportStatus = _T.ScenarioReadyForSquadSupportStatus
	local v18 = gGameRules:__wf_atom_e22d6f15() == 32 and "Waiting" or "Scanning"

	if v17 > 0.75 then
		_T.ScenarioReadyForSquadSupportStatus = GOOD_STATUS
	elseif v17 > 0.5 then
		_T.ScenarioReadyForSquadSupportStatus = FAIR_STATUS
		v18 ..= "Fair"
	elseif v17 > 0 then
		_T.ScenarioReadyForSquadSupportStatus = CRITICAL_STATUS
		v18 ..= "Critical"
	else
		_T.ScenarioReadyForSquadSupportStatus = NOT_READY_STATUS
		return
	end

	if
		_T.ScenarioReadyForSquadSupportStatus ~= scenarioReadyForSquadSupportStatus
		and not __wf_atom_7e8ad928(_T.ScenarioSetLocalSquadMissionStatus)
	then
		_T.ScenarioSetLocalSquadMissionStatus(v18)
	end
end

function IsEventFailed()
	if
		__wf_atom_7e8ad928(_G.Scenario)
		or __wf_atom_7e8ad928(_G.Scenario.state)
		or __wf_atom_7e8ad928(_G.Scenario.ProgressReq)
		or not (_G.Scenario.StartTime and _G.Scenario.EndTime)
	then
		return false
	end

	local __wf_atom_e9b9db5f = Engine.__wf_atom_e9b9db5f(_G.Scenario.StartTime)
	local __wf_atom_e9b9db5f2 = Engine.__wf_atom_e9b9db5f(_G.Scenario.EndTime)
	return __wf_atom_e9b9db5f <= 0 and __wf_atom_e9b9db5f2 <= 0
end

function IsEventSuccessful()
	if
		__wf_atom_7e8ad928(_G.Scenario)
		or __wf_atom_7e8ad928(_G.Scenario.state)
		or __wf_atom_7e8ad928(_G.Scenario.ProgressReq)
	then
		return false
	end

	return _G.Scenario.state.Progress >= _G.Scenario.ProgressReq
end

function DoesDojoHaveCompletedDryDock()
	local v16 = false

	if __wf_atom_7e8ad928(_T.DojoMgr) then
		return gGameRules:IsA(__wf_atom_e714d8ac)
			and not gGameRules:IsA(__wf_atom_1316e0c2)
			and gGameData:__wf_atom_e9d1e802(WeakResource("/Lotus/Types/Items/ShipFeatureItems/RailjackKeyShipFeatureItem"))
			and true
			or false
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v13)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return v16
	end

	local componentParams = _T.DojoMgr:BuildComponentParams(__wf_atom_0a6a5887)
	local jsonComponent = _T.DojoMgr.mDojo:GetJsonComponent(componentParams)

	if jsonComponent:__wf_atom_8598f3a9() and jsonComponent:__wf_atom_0a1f891f() then
		return true
	end

	return v16
end

function GetCrewshipLoadOutFromString(value)
	local crewShipLoadOut = SF.CrewShipLoadOut()
	crewShipLoadOut:__wf_atom_cd8b80fd(value)

	if not string.find(value, "CrewShipCustomization") then
		return crewShipLoadOut
	end

	local decoded = cjson.decode(value)

	if not (not __wf_atom_7e8ad928(decoded.CrewShipCustomization) and decoded.CrewShipCustomization.Skins) then
		return crewShipLoadOut
	end

	local skin = decoded.CrewShipCustomization.Skins[2]
	local v16

	if not (__wf_atom_7e8ad928(skin) or skin.ItemType == "") then
		v16 = WeakResource(skin.ItemType)
	end

	local __wf_atom_eb82ab1f = crewShipLoadOut.mShip:__wf_atom_eb82ab1f()

	if not __wf_atom_7e8ad928(v16) then
		__wf_atom_eb82ab1f:SetSkin(v16, 6)
		crewShipLoadOut.mShip:SetCustomization(__wf_atom_eb82ab1f)
		crewShipLoadOut.mShip:__wf_atom_ce74621b()
	end

	return crewShipLoadOut
end

function BuildCrewShipLoadOut(object, p, p2)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p)) then
		object:__wf_atom_e892819b(p)

		if p2 then
			object:__wf_atom_16e7bd09()
		end

		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(_T.ConvertCapacityToShields)) then
			_T.ConvertCapacityToShields(__wf_atom_6009c8ed, object)
		end

		local v16 = __wf_atom_7e8ad928(gRegion) and {} or gRegion:FindAll(__wf_atom_1e218e76)

		for i = 1, #v16 do
			v16[i]:ApplyCustomization()
		end
	end
end

function SpawnCrewShip(object)
	local v16 = nil
	local v17 = nil

	while __wf_atom_7e8ad928(v16) do
		if __wf_atom_7e8ad928(object) then
			return
		end

		if __wf_atom_7e8ad928(v17) and not __wf_atom_7e8ad928(gGameRules) then
			v17 = gGameRules:__wf_atom_257dee98()
		end

		if not __wf_atom_7e8ad928(v17) then
			v16 = v17:__wf_atom_a2e79445(object:__wf_atom_e800787c())
		end

		if __wf_atom_7e8ad928(v16) then
			Sleep(0.1)
		end
	end

	local v18 = nil

	while __wf_atom_7e8ad928(v18) do
		if __wf_atom_7e8ad928(object) then
			return
		end

		v18 = v16:__wf_atom_6009c8ed()

		if __wf_atom_7e8ad928(v18) then
			Sleep(0.1)
		end
	end

	return v16, v18
end

function GetPoiAvatarAndCrewshipFromHint(object)
	local count = 0
	local v16 = nil

	while count < 10 do
		if __wf_atom_7e8ad928(object) then
			return nil, nil
		end

		v16 = object:__wf_atom_3b73b479(v5)

		if #v16 > 0 then
			local __wf_atom_50a7d83e = v16[1]:__wf_atom_50a7d83e()
			return __wf_atom_50a7d83e, (__wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		else
			count += 1
			Sleep(0)
		end
	end

	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v6, object:GetPosition(), 100)

	if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		return __wf_atom_e2db08ce, (__wf_atom_e2db08ce:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	end

	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		print("Null template on " .. object:__wf_atom_5b41f63b())
	else
		print("Null ship for " .. __wf_atom_dd85e6db:__wf_atom_5b41f63b())
	end

	local v17 = "Agent List: "

	for _, v18 in ipairs(v16) do
		v17 ..= v18:__wf_atom_5b41f63b() .. " "
	end

	print(v17)
	return nil, nil
end

function GetPoiTier(object)
	local v16 = gRegion:FindInScope(object:__wf_atom_bc193479(), __wf_atom_01047f90)

	if #v16 == 0 then
		return -1
	end

	local __wf_atom_db682341 = v16[1]:__wf_atom_db682341()

	if __wf_atom_db682341 == v7 then
		return 0
	end

	if __wf_atom_db682341 == v8 then
		return 1
	end

	if __wf_atom_db682341 == v9 then
		return 2
	end

	if __wf_atom_db682341 == v10 then
		return 3
	end

	if __wf_atom_db682341 == v11 then
		return 4
	end

	return -1
end

local function fn17(instance, tag, list, p)
	if __wf_atom_7e8ad928(instance) then
		return false
	end

	if not __wf_atom_7e8ad928(list) and #list > 0 then
		for _, className in ipairs(list) do
			if instance:IsA(className) then
				return false
			end
		end
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_3d23b036) then
		if p then
			local v16 = p - 1

			if v16 > 0 then
				return fn17(__wf_atom_3d96ddcd, tag, list, v16)
			end
		end

		return false
	elseif __wf_atom_7e8ad928(tag) then
		return true
	else
		return __wf_atom_3d96ddcd:HasTag(tag)
	end
end

function IsAttachedToCrewship(p, p2, p3, p4)
	return fn17(p, p2, p3, p4)
end

function IsAttachedToRailjack(p, p2, p3)
	return fn17(p, Symbol("RailJackAvatar"), p2, p3)
end

function SetExternalCamerasEnabled(p)
	if p then
		_T.Railjack_DisableExternalCameras = nil
		return
	end

	if _T.Railjack_DisableExternalCamerasCallback then
		_T.Railjack_DisableExternalCamerasCallback()
	end

	_T.Railjack_DisableExternalCameras = true
end

function GetCrewMembers()
	if __wf_atom_7e8ad928(gGameRules) then
		return {}
	end

	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if not __wf_atom_7e8ad928(__wf_atom_257dee98) then
		local __wf_atom_247a5d2e = __wf_atom_257dee98:__wf_atom_247a5d2e()

		if not __wf_atom_7e8ad928(__wf_atom_247a5d2e) then
			return __wf_atom_247a5d2e:GetCrewMembers()
		end
	end

	return {}
end

function GiveXpReward(p, p2)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v16 in ipairs(__wf_atom_ef7900cf) do
		v16:__wf_atom_d2b2176d():__wf_atom_355b9a20(p, v16, Symbol(p2))
	end
end

function GivePoiCompletionReward(object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v16 in ipairs(__wf_atom_ef7900cf) do
		v16:__wf_atom_d2b2176d():__wf_atom_355b9a20(POI_COMPLETION_XP, v16, Symbol(POI_COMPLETION_LOC))
	end

	local v16 = fn14(Symbol("PoiRewardsScriptTrigger"), object:__wf_atom_bc193479())
	local v17

	if #v16 > 0 then
		v17 = v16[1]
	end

	if not __wf_atom_7e8ad928(v17) then
		v17:FirePort("Execute")
	end
end

function CheckRunDelayAfterRJAbilityUse(p, instance)
	if __wf_atom_7e8ad928(p) or (__wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_dd81e462)) then
		return
	end

	if p == instance:__wf_atom_716c39e8() then
		local __wf_atom_6009c8ed = instance:__wf_atom_6009c8ed()

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			__wf_atom_6009c8ed:__wf_atom_92aa9d91():__wf_atom_c31c5d26()
		end
	end
end

function RequestAction(object)
	local __wf_atom_e22d6f15 = gGameRules:__wf_atom_e22d6f15()

	if __wf_atom_7e8ad928(__wf_atom_e22d6f15) or __wf_atom_e22d6f15 ~= 32 then
		return true
	end

	if gGameRules:__wf_atom_d163c8e5(v15, 0) == 1 then
		return false
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if
		__wf_atom_7e8ad928(__wf_atom_7d789620)
		or __wf_atom_7d789620:__wf_atom_e7abf1ad() < 1
		or __wf_atom_7e8ad928(object)
	then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local __wf_atom_6b8adb0a = __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v14)
	local v16 = Time()

	if __wf_atom_6b8adb0a > 0 and __wf_atom_6b8adb0a <= v16 then
		__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v14, v16 + 30)
		print("Action granted to " .. object:GetName())
		return true
	else
		return false
	end
end

function IsAbilitySchedulerActive(object)
	local __wf_atom_e22d6f15 = gGameRules:__wf_atom_e22d6f15()

	if __wf_atom_7e8ad928(__wf_atom_e22d6f15) or __wf_atom_e22d6f15 ~= 32 or __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	return not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v14) > 0
end

function DisableAbilityScheduler(object)
	print("disabling ability scheduler")
	local __wf_atom_e22d6f15 = gGameRules:__wf_atom_e22d6f15()

	if __wf_atom_7e8ad928(__wf_atom_e22d6f15) or __wf_atom_e22d6f15 ~= 32 or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v14, 0)
	print("Disabled ability scheduler")
end

function SetupAbilityScheduler(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v14, Time() + 10)
	print("Starting delay set up for PoI ability scheduler")
end

function GetAbilityTransmissionDelay()
	return 6
end

local function fn18() -- 1 equivalent call inferred from this helper
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return nil
	end

	local __wf_atom_247a5d2e = __wf_atom_257dee98:__wf_atom_247a5d2e()

	if __wf_atom_7e8ad928(__wf_atom_247a5d2e) then
		return nil
	end

	local __wf_atom_6009c8ed = __wf_atom_247a5d2e:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return nil
	end

	return __wf_atom_6009c8ed:GetHyperDriveState()
end

function HavePlayersLeftHyperSpace()
	local v16 = fn18() -- inferred equivalent call
	return v16 == 0 or v16 == 1
end

function GetHyperDriveState()
	return fn18()
end

function GetResourceManifestId()
	local v16 = 0

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		return v16
	end

	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

	if __wf_atom_72fc675e.faction == 0 then
		return 0
	end

	return __wf_atom_72fc675e.faction == 1 and 1 or v16
end

function LoadMissionKey(object)
	_T.RailJackNextMissionNode = Symbol(object:__wf_atom_5b41f63b() .. module.KEY_TAG)
	local __wf_atom_d5226f21 = module.GetStarChart():__wf_atom_d5226f21(Symbol("CrewShipGenericTunnel"))
	gGameRules:__wf_atom_257dee98():__wf_atom_f7aa6106(__wf_atom_d5226f21.mission)
end

function SetupRJQuestMission()
	_T.gQuestMission = true
	_T.gDisableFocusPickups = true
	_T.gDisableStalker = true
	_T.AllowWrinkles = false
	gGameRules:SetNetPersistentVar(Symbol("StopNormalTransmissions"), 1)
end

function DisableTransferenceForDepressurization(p, p2)
	local v16 = fn7(p)

	while p2 > 0 do
		for _, v17 in ipairs(v16) do
			if __wf_atom_7e8ad928(v17) then
				continue
			end

			local isA = v17:IsA(__wf_atom_47cae841)
			local v18 = v17:IsA(__wf_atom_c0fefb76) or v17:IsA(__wf_atom_47cae841) and v17:__wf_atom_0a0c4594()

			if __wf_atom_7e8ad928(v17) or not v18 or v17:__wf_atom_8bd952f1() or not v17:__wf_atom_535d5cbb() then
				if isA and not v18 and not __wf_atom_7e8ad928(v17:__wf_atom_4221009f()) and gRegion:IsMaster() then
					v17:GetOffVehicle(v17:__wf_atom_4221009f(), __wf_atom_28d5d4aa, true)
				end
			else
				v17:__wf_atom_588bae9c(true)
			end
		end

		Sleep(0)
		p2 -= __wf_atom_084b3e93()
	end
end

function DeactivateRailJack(p, p2, p3)
	local v16 = p3 == nil or p3
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return nil
	end

	local __wf_atom_247a5d2e = __wf_atom_257dee98:__wf_atom_247a5d2e()

	if __wf_atom_7e8ad928(__wf_atom_247a5d2e) then
		return nil
	end

	if __wf_atom_7e8ad928(__wf_atom_247a5d2e) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_247a5d2e:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v17 = {
		__wf_atom_247a5d2e:__wf_atom_91d76a5f(1),
		__wf_atom_247a5d2e:__wf_atom_91d76a5f(2),
		(__wf_atom_247a5d2e:__wf_atom_91d76a5f(3))
	}
	v17[#v17 + 1] = __wf_atom_247a5d2e:__wf_atom_91d76a5f(0)

	if p2 then
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, p)

		if __wf_atom_6009c8ed:__wf_atom_59a15398() then
			__wf_atom_6009c8ed:__wf_atom_404d062c()
		end

		for i = 1, #v17 do
			v17[i]:Enable()
		end

		__wf_atom_6009c8ed:__wf_atom_7470861b():__wf_atom_63396172(Symbol("CapitalShipInvuln"))
		local v18 = fn5(Symbol("TogglePlayerSpawnsScript"), __wf_atom_247a5d2e)
		v18:SetState(1)
		v18:FirePort("Execute")
	else
		if not __wf_atom_6009c8ed:__wf_atom_59a15398() then
			__wf_atom_6009c8ed:__wf_atom_d2b2176d():AddUpgrade(101, 2, p)
			__wf_atom_6009c8ed:__wf_atom_4bf24e79()
		end

		for i = 1, #v17 do
			v17[i]:Disable()
		end

		__wf_atom_6009c8ed:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("CapitalShipInvuln"), 26, 6, 0)

		if _T.RailjackStopHullBreach then
			_T.RailjackStopHullBreach()
		end

		local v18 = fn5(Symbol("TogglePlayerSpawnsScript"), __wf_atom_247a5d2e)
		v18:SetState(0)
		v18:FirePort("Execute")
	end

	if v16 then
		__wf_atom_247a5d2e:__wf_atom_4cae056d()
	else
		__wf_atom_247a5d2e:__wf_atom_818829a7()
	end

	_T.PlayerPanelUpdateRequired = true
	__wf_atom_6009c8ed:__wf_atom_a142b1ea(p2)
end