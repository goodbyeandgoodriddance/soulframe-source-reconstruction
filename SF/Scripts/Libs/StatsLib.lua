module(..., package.seeall)
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = {
	[0] = "ES_NONE",
	[1] = "ES_SETUP",
	[2] = "ES_ACTIVE",
	[3] = "ES_COMPLETE",
	[4] = "ES_SUCCEEDED",
	[5] = "ES_FAILED",
	[6] = "ES_SHUTDOWN"
}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = nil
local v8 = {}
local v9 = nil
local v10 = false
local v11 = 0
local v12 = nil
local v13 = nil
local v14 = {}
local v15 = Symbol("SPARROW_GUIDE")
local v16 = Symbol("SPARROW_GUIDE_DESTINATION")
local v17 = Symbol("SPARROW_GUIDE_LEVEL")
local v18 = Symbol("FAST_TRAVEL")
local v19 = Symbol("FAST_TRAVEL_DESTINATION")
local v20 = Symbol("FAST_TRAVEL_LEVEL")
local v21 = Symbol("CHAT_COMMAND")
local v22 = Symbol("CHAT_COMMAND_ERROR")
local v23 = Symbol("CHAT_COMMAND_UNKNOWN")
local v24 = Symbol("SIEGE_START")
local v25 = Symbol("SIEGE_ABANONDED")
local v26 = Symbol("SIEGE_COMPLETE")
local v27 = Symbol("HardModeActive")
mChatCommandType = {
	SuccessNormal = 1,
	FailNormal = 2,
	SuccessPosition = 3,
	FailPosition = 4,
	UnknownCommand = 5
}
mAncestorsRevealable = { ["/SF/Types/Game/Ancestors/Orlick/OrlickAncestor"] = false }
mTrackedLevels = {
	["/SF/Levels/Procs/Quest/UnderCityGarrenTotem"] = Symbol("STAG_QUEST"),
	["/SF/Levels/Procs/GladesofAndurin/GladesProcDemo"] = Symbol("STAG_QUEST")
}
mSparrowDestinationType = {
	None = 1,
	Single = 2,
	Multi = 3,
	Waypoint = 4,
	Quest = 5,
	Tale = 6,
	Exit = 7
}
local v28 = {
	[mSparrowDestinationType.None] = "SD_NONE",
	[mSparrowDestinationType.Single] = "SD_SINGLE",
	[mSparrowDestinationType.Multi] = "SD_MULTI",
	[mSparrowDestinationType.Waypoint] = "SD_WAYPOINT",
	[mSparrowDestinationType.Quest] = "SD_QUEST",
	[mSparrowDestinationType.Tale] = "SD_TALE",
	[mSparrowDestinationType.Exit] = "SD_EXIT"
}

local function fn(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local position = object:GetPosition()
	return object:GetName() .. module.Round(position.x) .. module.Round(position.y) .. module.Round(position.z)
end

function LogLootChestLootedStats(object)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) then
		return
	end

	local v29 = fn(object)

	if not (__wf_atom_7e8ad928(v29) or __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		local name = tostring(object:GetName())
		local v30 = v2[v29]

		if __wf_atom_7e8ad928(v30) then
			local v31 = v3[v29]

			if not __wf_atom_7e8ad928(v31) then
				__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CHEST_LOOTED_PROC"), v31)
				__wf_atom_21342f4a:__wf_atom_cc4a7193(Symbol("CHEST_LOOTED_PROC"), name, v31, object)
				v3[v29] = nil
			end
		else
			local level = v30.level
			local location = v30.location
			local range = v30.range
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CHEST_LOOTED_ENC"), level)
			local v31 = _GetEventJsonText({ l = location }, range)
			__wf_atom_21342f4a:__wf_atom_cc4a7193(Symbol("CHEST_LOOTED_ENC"), name, level, object, v31)
			v2[v29] = nil
		end
	end
end

local function fn2() -- 15 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	return gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()
end

function LogEncounterLootChestSpawnedStats(object, p, range)
	if not gRegion:IsMaster() then
		return
	end

	local v29 = fn(object)
	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v30 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(statsActiveLevelName) or __wf_atom_7e8ad928(v29) or __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		if not __wf_atom_7e8ad928(range) then
			v13 = range
		end

		local location = tostring(p)

		if location == "" then
			return
		end

		local name = tostring(object:GetName())
		local v30 = _GetEventJsonText({ l = location }, range)
		v2[v29] = { location = location, level = statsActiveLevelName, range = range }
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CHEST_SPAWNED_ENC"), statsActiveLevelName)
		__wf_atom_21342f4a:__wf_atom_cc4a7193(Symbol("CHEST_SPAWNED_ENC"), name, statsActiveLevelName, object, v30)
	end
end

function LogProcLootChestSpawnedStats(object)
	if not gRegion:IsMaster() then
		return
	end

	local v29 = fn(object)
	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v30 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if not (__wf_atom_7e8ad928(statsActiveLevelName) or __wf_atom_7e8ad928(v29) or __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		local name = tostring(object:GetName())
		v3[v29] = statsActiveLevelName
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CHEST_SPAWNED_PROC"), statsActiveLevelName)
		__wf_atom_21342f4a:__wf_atom_cc4a7193(Symbol("CHEST_SPAWNED_PROC"), name, statsActiveLevelName, object)
	end
end

function _NormalizeBossFightName(value)
	return string.gsub(value, " ", "_")
end

function _GetBossFight(p)
	if __wf_atom_7e8ad928(_T.StatsActiveBossFights) then
		_T.StatsActiveBossFights = {}
	elseif not __wf_atom_7e8ad928(_T.StatsActiveBossFights[p]) then
		local statsActiveBossFight = _T.StatsActiveBossFights[p]
		return
			statsActiveBossFight.bundleName,
			statsActiveBossFight.numPlayers,
			statsActiveBossFight.lastStage,
			statsActiveBossFight.trackedAvatarNames
	end

	return nil, nil, nil, nil
end

function ClearBossFights()
	if not __wf_atom_7e8ad928(_T.StatsActiveBossFights) then
		for _, statsActiveBossFight in ipairs(_T.StatsActiveBossFights) do
			EndBossFight(statsActiveBossFight)
		end
	end
end

function StartBossFight(p, numPlayers)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(numPlayers) then
		return
	end

	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v29 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if __wf_atom_7e8ad928(statsActiveLevelName) then
		return
	end

	local v29 = _NormalizeBossFightName(p)

	if not __wf_atom_7e8ad928((_GetBossFight(v29))) then
		print("STATS StartBossFight called when tracking is already active for name: " .. v29)
		return
	end

	local bundleName = "BT_BOSS_" .. v29 .. "::" .. tostring(numPlayers) .. "::" .. statsActiveLevelName
	_T.StatsActiveBossFights[v29] = {
		bundleName = bundleName,
		numPlayers = numPlayers,
		lastStage = nil,
		trackedAvatarNames = {}
	}
	__wf_atom_21342f4a:__wf_atom_b4ca4b6e(Symbol(bundleName))
end

function AddBossFightNpcEventTracking(p, object)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return
	end

	local v29 = _NormalizeBossFightName(p)
	local v30, _, _, v31 = _GetBossFight(v29)

	if __wf_atom_7e8ad928(v30) then
		print("STATS AddBossFightNpcEventTracking called with unknown name: " .. v29)
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if __wf_atom_7e8ad928(__wf_atom_5b41f63b) then
		return
	end

	if not __wf_atom_7e8ad928(v31[__wf_atom_5b41f63b]) then
		print("STATS AddBossFightNpcEventTracking called for \"" .. v29 .. "\" but npc is already tracked: " .. __wf_atom_5b41f63b)
		return
	end

	_T.StatsActiveBossFights[v29].trackedAvatarNames[__wf_atom_5b41f63b] = true
	__wf_atom_21342f4a:__wf_atom_80206ab4(Symbol(__wf_atom_5b41f63b), Symbol(v30))
end

function EndBossFightNpcEventTracking(p, object)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return
	end

	local v29 = _NormalizeBossFightName(p)
	local v30, _, _, v31 = _GetBossFight(v29)

	if __wf_atom_7e8ad928(v30) then
		print("STATS EndBossFightNpcEventTracking called with unknown name: " .. v29)
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if __wf_atom_7e8ad928(__wf_atom_5b41f63b) then
		return
	end

	if not __wf_atom_7e8ad928(v31[__wf_atom_5b41f63b]) then
		print("STATS EndBossFightNpcEventTracking called for \"" .. v29 .. "\" but npc is not tracked: " .. __wf_atom_5b41f63b)
	end

	_T.StatsActiveBossFights[v29].trackedAvatarNames[__wf_atom_5b41f63b] = nil
	__wf_atom_21342f4a:__wf_atom_b4110dee(Symbol(__wf_atom_5b41f63b), Symbol(v30))
end

function EndBossFight(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v29 = _NormalizeBossFightName(p)
	local v30, v31, v32, v33 = _GetBossFight(v29)

	if __wf_atom_7e8ad928(v30) or __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v33) then
		print("STATS missing boss fight tracking data for name: " .. v29)
		return
	end

	if not __wf_atom_7e8ad928(v32) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("BOSS_FIGHT_STAGE_TIME_" .. tostring(v31)), v32)
	end

	__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(v30))

	for k, _ in pairs(v33) do
		__wf_atom_21342f4a:__wf_atom_b4110dee(Symbol(k), Symbol(v30))
	end

	_T.StatsActiveBossFights[v29] = nil
end

function SetBossFightStage(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local v29 = _NormalizeBossFightName(p)
	local v30, v31, v32 = _GetBossFight(v29)

	if __wf_atom_7e8ad928(v30) then
		print("STATS SetBossFightStage called with unknown name: " .. v29)
		return
	end

	local lastStage = v29 .. "_" .. p2

	if v32 == lastStage then
		return
	end

	if not __wf_atom_7e8ad928(v32) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("BOSS_FIGHT_STAGE_TIME_" .. tostring(v31)), v32)
	end

	_T.StatsActiveBossFights[v29].lastStage = lastStage
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("BOSS_FIGHT_STAGE_COUNT_" .. tostring(v31)), lastStage)
	__wf_atom_21342f4a:StartTimer(Symbol("BOSS_FIGHT_STAGE_TIME_" .. tostring(v31)), lastStage)
end

function StartSubBossFight(object, numPlayers, p, levelRange)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(object) then
		return
	end

	local v29 = GetEventContext()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(v29) then
		return
	end

	local locationName = __wf_atom_7e8ad928(p) and "" or p
	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v30 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	local npcFullName = string.find(__wf_atom_5b41f63b, "CircadeGhostKnightAvatar") and "CircadeGhostKnightAvatar"
		or __wf_atom_5b41f63b
	local v30 = npcFullName .. "_" .. locationName .. "_" .. tostring(numPlayers)

	if not __wf_atom_7e8ad928(v14[v30]) then
		print("StartSubBossFight attempted to start a fight but the handle already exists. End the fight with EndSubBossFight first!")
		return v30
	end

	local v31 = _GetEventJsonText({ n = numPlayers, l = locationName, b = npcFullName }, levelRange)

	if __wf_atom_7e8ad928(v31) then
		print("StartSubBossFight failed to construct json, event will be skipped!")
		return
	end

	__wf_atom_21342f4a:__wf_atom_cc4a7193(v29, "SUBBOSS_FIGHT_START", statsActiveLevelName, __wf_atom_c4f78a8f, v31)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("SUBBOSS_FIGHT_START_" .. tostring(numPlayers)), npcFullName)
	__wf_atom_21342f4a:StartTimer(Symbol("SUBBOSS_FIGHT_" .. tostring(numPlayers)), npcFullName)
	v14[v30] = {
		levelName = statsActiveLevelName,
		locationName = locationName,
		npcFullName = npcFullName,
		numPlayers = numPlayers,
		levelRange = levelRange
	}
	return v30
end

function EndSubBossFight(p, p2)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(v14[p]) then
		print("EndSubBossFight called with unrecognized handle (\"" .. tostring(p) .. "\"). Are you missing StartSubBossFight?")
		return
	end

	local v29 = GetEventContext()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(v29) then
		return
	end

	local v30 = v14[p]
	local levelName = v30.levelName
	local npcFullName = v30.npcFullName
	local numPlayers = v30.numPlayers
	local levelRange = v30.levelRange
	v14[p] = nil
	local v31 = { n = numPlayers, l = v30.locationName, b = npcFullName }
	local v32 = _GetEventJsonText(v31, levelRange)

	if __wf_atom_7e8ad928(v32) then
		print("LogStatsEventWithContext failed to construct json, event will be skipped!")
		return
	end

	local v33 = p2 == 4 and "SUBBOSS_FIGHT_SUCCEEDED" or p2 == 5 and "SUBBOSS_FIGHT_FAILED" or "SUBBOSS_FIGHT_ABANDONED"
	__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("SUBBOSS_FIGHT_" .. tostring(numPlayers)), npcFullName)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol(v33 .. "_" .. tostring(numPlayers)), npcFullName)
	__wf_atom_21342f4a:__wf_atom_cc4a7193(v29, v33, levelName, __wf_atom_c4f78a8f, v32)
end

function LogEnterNightfold()
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		return
	end

	local __wf_atom_64f0a713 = __wf_atom_21342f4a:__wf_atom_64f0a713("/SF/Levels/Tent")
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("ENTER_NIGHTFOLD"), __wf_atom_64f0a713)
	__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_TIME"), __wf_atom_64f0a713)
	__wf_atom_21342f4a:__wf_atom_008d812c(Symbol("MISSION_TIME"))
end

function LogLeaveNightfold()
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gMatchingService) then
		return
	end

	local __wf_atom_64f0a713 = __wf_atom_21342f4a:__wf_atom_64f0a713("/SF/Levels/Tent")
	local v29 = __wf_atom_b953295d():c_str():gsub("_", "")
	__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_TIME"), __wf_atom_64f0a713)
	__wf_atom_21342f4a:StartTimer(Symbol("MISSION_TIME"), v29)
end

function LogPetOmenBeast(object)
	if not __wf_atom_7e8ad928(object) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("PET_OMEN_BEAST"), object:__wf_atom_5b41f63b())
	end
end

function _GetPlayerLevel()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			return __wf_atom_d2b2176d:__wf_atom_f7423942()
		end
	end

	return 0
end

function _GetEventJsonText(items, p)
	local v29 = { p = tostring((_GetPlayerLevel())) }

	if not __wf_atom_7e8ad928(p) then
		v29.d = tostring(p.minValue) .. ":" .. tostring(p.maxValue)
	end

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_d163c8e5(v27, 0) ~= 0 then
		v29.h = 1
	end

	if not __wf_atom_7e8ad928(items) then
		for k, item in pairs(items) do
			v29[k] = item
		end
	end

	return cjson.encode(v29)
end

function LogUseSparrowGuide(p, p2, data)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(v28[p]) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v29 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if module.IsInNightFold(__wf_atom_c4f78a8f) then
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713("/SF/Levels/Tent")
	end

	local v29 = v28[p]
	local v30 = {}

	if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2.distance) or __wf_atom_7e8ad928(p2.entity)) then
		v30.i = p2.distance
		local v31 = tostring(p2.entity:__wf_atom_db682341())

		if v31 == "" then
			v30.e = tostring(p2.entity:GetName())
		else
			v30.e = v31
		end
	end

	if not __wf_atom_7e8ad928(data) then
		v30.v = { data.x, data.y, data.z }

		if __wf_atom_7e8ad928(v30.i) then
			v30.i = Distance(__wf_atom_c4f78a8f:GetPosition(), data)
		end
	end

	local v31 = _GetEventJsonText(v30)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(v16, v29)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(v17, statsActiveLevelName)
	__wf_atom_21342f4a:__wf_atom_cc4a7193(v15, v29, statsActiveLevelName, __wf_atom_c4f78a8f, v31)
end

function LogFastTravel(p, data)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(data) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v29 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if module.IsInNightFold(__wf_atom_c4f78a8f) then
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713("/SF/Levels/Tent")
	end

	local v29 = {}

	if not __wf_atom_7e8ad928(data) then
		v29.v = { data.x, data.y, data.z }
		v29.i = Distance(__wf_atom_c4f78a8f:GetPosition(), data)
	end

	local v30 = _GetEventJsonText(v29)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(v19, p)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(v20, statsActiveLevelName)
	__wf_atom_21342f4a:__wf_atom_cc4a7193(v18, p, statsActiveLevelName, __wf_atom_c4f78a8f, v30)
end

function LogEventWithContext(p, object, p2, p3, p4)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local v29 = GetEventContext()

	if __wf_atom_7e8ad928(v29) then
		print("LogStatsEventWithContext called without a valid context, event will be skipped!")
		return
	end

	if __wf_atom_7e8ad928(p2) and not __wf_atom_7e8ad928(v13) then
		p2 = v13
	else
		v13 = p2
	end

	local v30 = _GetEventJsonText(p3, p2)

	if __wf_atom_7e8ad928(v30) then
		print("LogStatsEventWithContext failed to construct json, event will be skipped!")
		return
	end

	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v31 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v31)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if p4 then
		ReplicateLogEvent(v29, tostring(p), statsActiveLevelName, object:GetPosition(), v30)
	else
		__wf_atom_21342f4a:__wf_atom_cc4a7193(v29, tostring(p), statsActiveLevelName, object, v30)
	end
end

function TrackTaleStart(data, p)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local hudId = tostring(data.hudId)

	if not __wf_atom_7e8ad928(v8[hudId]) then
		return
	end

	local missionTags = {}
	local locationId = nil
	local missionTag = nil

	for _, path in pairs(data.paths) do
		for _, v29 in pairs(path) do
			table.insert(missionTags, (tostring(v29.missionTag)))

			if not (__wf_atom_7e8ad928(v29.nextNodes) or #v29.nextNodes == 0) then
				continue
			end

			locationId = tostring(v29.locationId)
			missionTag = tostring(v29.missionTag)
		end
	end

	if __wf_atom_7e8ad928(locationId) or __wf_atom_7e8ad928(missionTag) then
		return
	end

	local v29 = {
		d = tostring(data.enemyLevel.minValue) .. ":" .. tostring(data.enemyLevel.maxValue),
		i = hudId,
		f = tostring(data.faction),
		n = missionTags
	}

	if p then
		LogEventWithContext("TALE_RESUME", gRegion:__wf_atom_c4f78a8f(), nil, v29, false)
	else
		LogEventWithContext("TALE_START", gRegion:__wf_atom_c4f78a8f(), nil, v29, false)
	end

	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_STATUS"), "ES_ACTIVE")
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_START"), locationId .. ":" .. missionTag)
	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v30 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	local v30 = "BT_DYNAMIC_QUEST" .. "::" .. tostring(locationId) .. ":" .. tostring(missionTag) .. "::" .. tostring(statsActiveLevelName)
	__wf_atom_21342f4a:__wf_atom_b4ca4b6e(Symbol(v30))
	v8[hudId] = true
end

function TrackTaleNodePrimed(data, p, p2, p3, p4)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local hudId = tostring(data.hudId)
	local locationId = tostring(p.locationId)

	if v8[hudId] == locationId then
		return
	end

	local v29 = {
		d = tostring(data.enemyLevel.minValue) .. ":" .. tostring(data.enemyLevel.maxValue),
		i = hudId,
		f = tostring(data.faction),
		l = locationId,
		m = tostring(p.missionTag),
		x = p3,
		y = p4
	}
	LogEventWithContext("TALE_NODE_PRIMED", p2, nil, v29, false)
	v8[hudId] = locationId
end

function TrackTaleNodeComplete(data, p, p2, p3, p4)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local hudId = tostring(data.hudId)
	local locationId = tostring(p.locationId)
	local v29 = {
		d = tostring(data.enemyLevel.minValue) .. ":" .. tostring(data.enemyLevel.maxValue),
		i = hudId,
		f = tostring(data.faction),
		l = locationId,
		m = tostring(p.missionTag),
		x = p3,
		y = p4
	}
	LogEventWithContext("TALE_NODE_COMPLETE", p2, nil, v29, false)
end

function TrackTaleEnd(data, p)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(data) then
		return
	end

	local hudId = tostring(data.hudId)
	local missionTags = {}
	local locationId = nil
	local missionTag = nil

	for _, path in pairs(data.paths) do
		for _, v29 in pairs(path) do
			table.insert(missionTags, (tostring(v29.missionTag)))

			if not (__wf_atom_7e8ad928(v29.nextNodes) or #v29.nextNodes == 0) then
				continue
			end

			locationId = tostring(v29.locationId)
			missionTag = tostring(v29.missionTag)
		end
	end

	if __wf_atom_7e8ad928(locationId) or __wf_atom_7e8ad928(missionTag) then
		return
	end

	local v29 = {
		d = tostring(data.enemyLevel.minValue) .. ":" .. tostring(data.enemyLevel.maxValue),
		i = hudId,
		f = tostring(data.faction),
		n = missionTags
	}

	if p then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_STATUS"), "ES_SHUTDOWN")
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_ABANDONED"), locationId .. ":" .. missionTag)
		LogEventWithContext("TALE_ABANDONED", gRegion:__wf_atom_c4f78a8f(), nil, v29, false)
	else
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_STATUS"), "ES_COMPLETE")
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_COMPLETE"), locationId .. ":" .. missionTag)
		LogEventWithContext("TALE_COMPLETE", gRegion:__wf_atom_c4f78a8f(), nil, v29, false)
	end

	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v30 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	local v30 = "BT_DYNAMIC_QUEST" .. "::" .. tostring(locationId) .. ":" .. tostring(missionTag) .. "::" .. tostring(statsActiveLevelName)
	__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(v30))
	v8[hudId] = nil
end

function LogDynamicQuestStatusChange(p, p2, p3, p4, p5)
	local v29 = v[p2]

	if not (__wf_atom_7e8ad928(v29) or __wf_atom_7e8ad928(gRegion)) then
		local v30 = GetEventContext()

		if __wf_atom_7e8ad928(v30) then
			print("LogDynamicQuestStatusChange called without a valid context, event will be skipped!")
			return
		end

		v13 = p5
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_STATUS"), (tostring(v29)))
		local statsActiveLevelName

		if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
			local v31 = fn2() -- inferred equivalent call
			statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v31)
		else
			statsActiveLevelName = _G.StatsActiveLevelName
		end

		local v31 = "BT_DYNAMIC_QUEST" .. "::" .. tostring(p3) .. ":" .. tostring(p4) .. "::" .. tostring(statsActiveLevelName)

		if p2 == 2 and v31 ~= v7 then
			if not __wf_atom_7e8ad928(v7) then
				__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(v7))
			end

			v7 = v31
			__wf_atom_21342f4a:__wf_atom_b4ca4b6e(Symbol(v7))
		elseif v31 == v7 and p2 >= 3 then
			__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(v7))
			v7 = nil
		end

		local v32 = { l = tostring(p3), m = tostring(p4) }
		local v33 = _GetEventJsonText(v32, p5)
		local statsActiveLevelName2

		if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
			local v34 = fn2() -- inferred equivalent call
			statsActiveLevelName2 = __wf_atom_21342f4a:__wf_atom_64f0a713(v34)
		else
			statsActiveLevelName2 = _G.StatsActiveLevelName
		end

		if p2 == 0 then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_SPAWN"), tostring(p3) .. ":" .. tostring(p4))
			__wf_atom_21342f4a:__wf_atom_cc4a7193(v30, "DYNAMIC_QUEST_SPAWN", statsActiveLevelName2, p, v33)
		elseif p2 == 2 then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_START"), tostring(p3) .. ":" .. tostring(p4))
			__wf_atom_21342f4a:__wf_atom_cc4a7193(v30, "DYNAMIC_QUEST_START", statsActiveLevelName2, p, v33)
		elseif p2 == 4 then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("DYNAMIC_QUEST_COMPLETE"), tostring(p3) .. ":" .. tostring(p4))
			__wf_atom_21342f4a:__wf_atom_cc4a7193(v30, "DYNAMIC_QUEST_COMPLETE", statsActiveLevelName2, p, v33)
		end
	end
end

function LogEncounterStatusChange(object, p)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) or (p == 0 or p == 1) then
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if p == 2 then
		if v4[__wf_atom_5b41f63b] == nil then
			v11 += 1
		end

		v4[__wf_atom_5b41f63b] = 2
		v5[__wf_atom_5b41f63b] = object:GetPosition()
		local v29 = v6
		local name = object:__wf_atom_dd85e6db():GetName()
		local statsActiveLevelName

		if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
			local v30 = fn2() -- inferred equivalent call
			statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v30)
		else
			statsActiveLevelName = _G.StatsActiveLevelName
		end

		v29[__wf_atom_5b41f63b] = "BT_ENCOUNTER::" .. name .. "::" .. statsActiveLevelName
		UpdateActiveEncounter()
	else
		if p ~= 4 and p ~= 6 and p ~= 5 or v4[__wf_atom_5b41f63b] == nil then
			return
		end

		v4[__wf_atom_5b41f63b] = nil
		v5[__wf_atom_5b41f63b] = nil
		v11 -= 1
		UpdateActiveEncounter()
	end
end

function UpdateActiveEncounter()
	if not (gRegion:IsMaster() and v10 ~= true) then
		return
	end

	v10 = true

	while v11 > 0 do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled()) then
			local v29 = v9
			local v30 = -1

			for k, _ in pairs(v4) do
				local v31 = Distance(__wf_atom_c4f78a8f:GetPosition(), v5[k])

				if not (v30 == -1 or v30 < v31) then
					continue
				end

				v29 = k
				v30 = v31
			end

			if v29 ~= v9 then
				if v9 ~= nil then
					__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(v6[v9]))
				end

				v9 = v29
				__wf_atom_21342f4a:__wf_atom_b4ca4b6e(Symbol(v6[v9]))
			end
		end

		Sleep(1)
	end

	v10 = false
end

local function fn3(value) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(value) then
		return value
	end

	local v29, v30 = string.find(value, "DynamicRandomEncounterHint")

	if __wf_atom_7e8ad928(v29) then
		return value
	end

	return (string.sub(value, 0, v30))
end

local function fn4(statsCombatEncountersData) -- 1 equivalent call inferred from this helper
	local result = {}

	for k, item in pairs(statsCombatEncountersData) do
		result[k] = item
	end

	return result
end

function TrackCombat()
	if not (_G.StatsCombatEncountersLoopEnabled and gRegion:IsMaster()) then
		return
	end

	if __wf_atom_7e8ad928(v12) then
		v12 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

		if __wf_atom_7e8ad928(v12) then
			return
		end
	end

	if __wf_atom_7e8ad928(_G.StatsCombatEncountersData) then
		_G.StatsCombatEncountersData = {}
	end

	local result = fn4(_G.StatsCombatEncountersData) -- inferred equivalent call
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_e0730826 = v12:__wf_atom_e0730826(__wf_atom_c4f78a8f, 40)

		if not __wf_atom_7e8ad928(__wf_atom_e0730826) and #__wf_atom_e0730826 > 0 then
			local v29 = {}

			for _, v30 in pairs(__wf_atom_e0730826) do
				local __wf_atom_76724198 = v30:__wf_atom_76724198()

				if __wf_atom_7e8ad928(__wf_atom_76724198) then
					continue
				end

				local name = __wf_atom_76724198:__wf_atom_dd85e6db():GetName()
				local statsActiveLevelName

				if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
					local v31 = fn2() -- inferred equivalent call
					statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v31)
				else
					statsActiveLevelName = _G.StatsActiveLevelName
				end

				local v31 = "BT_ENCOUNTER::" .. name .. "::" .. statsActiveLevelName

				if not (__wf_atom_76724198:__wf_atom_4026dfb5() == 2 and __wf_atom_7e8ad928(v29[v31])) then
					continue
				end

				if not (__wf_atom_c4f78a8f:__wf_atom_d5fda8be((v30:__wf_atom_50a7d83e():GetPosition())) <= 20 or v30:__wf_atom_79e28bce(__wf_atom_c4f78a8f)) then
					continue
				end

				v29[v31] = 1
			end

			for k, _ in pairs(v29) do
				k = fn3(k) -- inferred equivalent call

				if __wf_atom_7e8ad928(_G.StatsCombatEncountersData[k]) then
					_G.StatsCombatEncountersData[k] = true
					__wf_atom_21342f4a:__wf_atom_b4ca4b6e(Symbol(k))
				else
					result[k] = nil
				end
			end
		end
	end

	for k, v29 in pairs(result) do
		if not v29 then
			continue
		end

		_G.StatsCombatEncountersData[k] = nil
		__wf_atom_21342f4a:__wf_atom_eb5e77b7(Symbol(k))
	end
end

function StartCombatTracking()
	module.WaitForLoginSequence()

	if _G.StatsCombatEncountersLoopEnabled then
		return
	end

	_G.StatsCombatEncountersLoopEnabled = true

	while _G.StatsCombatEncountersLoopEnabled do
		TrackCombat()
		Sleep(3)
	end
end

local function fn5(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		print("Stat log failed for puzzle, no identifier entity referenced!")
		return
	end

	local name = object:GetName()
	local layerIndex = module.GetLayerIndex(object)
	local tilesetName = module.GetTilesetName(layerIndex)
	local tileName = module.GetTileName(layerIndex)

	if __wf_atom_7e8ad928(tileName) or __wf_atom_7e8ad928(tilesetName) then
		print("Stat log failed for puzzle, no tile or tileset name found.")
		return
	end

	if __wf_atom_7e8ad928(p2) then
		if string.match(name, "PuzzleFire") then
			p2 = "Fire"
		elseif string.match(name, "PuzzleFlood") then
			p2 = "Flood"
		elseif string.match(name, "PuzzleHangingCage") then
			p2 = "HangingCage"
		elseif string.match(name, "PuzzleLightMirror") then
			p2 = "LightMirror"
		else
			p2 = "Miscellaneous"
		end
	end

	local v29 = p2 .. ":" .. tilesetName .. ":" .. tileName .. ":" .. name

	if p then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("PROC_PUZZLE_SOLVED"), v29)
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("PROC_PUZZLE_TIME"), v29)
	else
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("PROC_PUZZLE_STARTED"), v29)
		__wf_atom_21342f4a:StartTimer(Symbol("PROC_PUZZLE_TIME"), v29)
	end
end

function LogProcPuzzleStarted(p, p2)
	fn5(p, false, p2)
end

function LogProcPuzzleSolved(p, p2)
	fn5(p, true, p2)
end

function LogChatCommandUsed(p, p2)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(p) then
		return
	end

	if p2 == mChatCommandType.UnknownCommand then
		__wf_atom_21342f4a:__wf_atom_eb9c6c51(v23, p)
	elseif p2 == mChatCommandType.SuccessNormal then
		__wf_atom_21342f4a:__wf_atom_eb9c6c51(v21, p)
	elseif p2 == mChatCommandType.FailNormal then
		__wf_atom_21342f4a:__wf_atom_eb9c6c51(v22, p)
	elseif p2 == mChatCommandType.SuccessPosition or p2 == mChatCommandType.FailPosition then
		local statsActiveLevelName

		if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
			local v29 = fn2() -- inferred equivalent call
			statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
		else
			statsActiveLevelName = _G.StatsActiveLevelName
		end

		if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(statsActiveLevelName) then
			return
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			return
		end

		if p2 == mChatCommandType.SuccessPosition then
			__wf_atom_21342f4a:__wf_atom_cc4a7193(v21, p, statsActiveLevelName, __wf_atom_c4f78a8f)
		else
			__wf_atom_21342f4a:__wf_atom_cc4a7193(v22, p, statsActiveLevelName, __wf_atom_c4f78a8f)
		end
	end
end

function ReplicateLogEvent(p, p2, p3, p4, p5, p6)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	if __wf_atom_7e8ad928(_T.mStatsEventCompletedTable) then
		_T.mStatsEventCompletedTable = {}
	end

	local v29 = __wf_atom_7e8ad928(p2) and "" or p2
	local v30 = __wf_atom_7e8ad928(p3) and "" or p3

	if __wf_atom_7e8ad928(p4) then
		p4 = Vector(0, 0, 0)
	end

	local v31 = __wf_atom_7e8ad928(p5) and "" or p5

	if p6 then
		local v32 = p .. "^" .. v29 .. ":" .. v30

		if not __wf_atom_7e8ad928(_T.mStatsEventCompletedTable[v32]) then
			return false
		end

		_T.mStatsEventCompletedTable[v32] = true
	end

	__wf_atom_eab484a7:__wf_atom_b6fc6ddf(Symbol(p), v29, v30, p4, v31)
end

function GetContextFromLevel(p)
	if __wf_atom_7e8ad928(p) or not mTrackedLevels[p] then
		return Symbol("MISCELLANEOUS")
	end

	return mTrackedLevels[p]
end

function GetEventContext()
	local statsActiveLevelName

	if __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
		local v29 = fn2() -- inferred equivalent call
		statsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
	else
		statsActiveLevelName = _G.StatsActiveLevelName
	end

	if __wf_atom_7e8ad928(statsActiveLevelName) then
		return nil
	end

	return GetContextFromLevel(statsActiveLevelName)
end

function PostLoginSetup()
	__wf_atom_21342f4a:__wf_atom_09f8aacc(false, 600, true, 15000, 60)

	if __wf_atom_7e8ad928(gRegion) then
		print("PostLoginSetup called too early, no gRegion available!")
	else
		TrackEnterLevel(gRegion:__wf_atom_22941262(), "login", true)
	end
end

function _LevelChangeCommon(value, p, p2)
	if
		__wf_atom_7e8ad928(__wf_atom_21342f4a)
		or __wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(value)
		or __wf_atom_7e8ad928(p)
	then
		return nil, nil, nil
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return nil, nil, nil
	end

	local position = __wf_atom_c4f78a8f:GetPosition()

	if type(value) ~= "string" then
		value = __wf_atom_21342f4a:__wf_atom_64f0a713(value:__wf_atom_5b41f63b())
	end

	if p2 and value == _G.StatsActiveLevelName then
		return nil, nil, nil
	end

	local v29 = __wf_atom_7e8ad928(_T.StatsLastLevelEventTime) and -1 or _T.StatsLastLevelEventTime
	_T.StatsLastLevelEventTime = gGameRules:__wf_atom_93691ff2()
	return value, v29, position
end

function _LevelChangeSideEffects()
	ClearBossFights()
end

function TrackEnterLevel(object, p, p2)
	local v29, v30, v31 = _LevelChangeCommon(object, p, true)

	if __wf_atom_7e8ad928(v29) then
		return
	end

	local v32 = GetContextFromLevel(object)
	_G.StatsActiveLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(v29)
	_G.StatsLoadingLevelName = nil

	if p2 and not __wf_atom_7e8ad928(object) then
		__wf_atom_21342f4a:__wf_atom_dd273a12(object:__wf_atom_5b41f63b())
	end

	local v33 = { z = tostring(p), t = _T.StatsLastLevelEventTime, u = v30 }

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_d163c8e5(v27, 0) ~= 0 then
		v33.h = 1
	end

	ReplicateLogEvent(v32, "ENTER_LEVEL", v29, v31, cjson.encode(v33))
	print("STATS ENTER_LEVEL " .. v29)
end

function TrackExitLevel(p, statsLoadingLevelName, p2)
	local v29 = not __wf_atom_7e8ad928(_G.StatsActiveLevelName)
	local v30, v31, v32 = _LevelChangeCommon(p, p2, false)

	if __wf_atom_7e8ad928(v30) then
		return
	end

	local v33 = GetContextFromLevel(v30)

	if not __wf_atom_7e8ad928(statsLoadingLevelName) then
		if type(statsLoadingLevelName) ~= "string" then
			statsLoadingLevelName = __wf_atom_21342f4a:__wf_atom_64f0a713(statsLoadingLevelName:__wf_atom_5b41f63b())
		end

		if v30 == statsLoadingLevelName then
			return
		end

		if mTrackedLevels[statsLoadingLevelName] then
			v33 = mTrackedLevels[statsLoadingLevelName]
		end

		_G.StatsLoadingLevelName = statsLoadingLevelName
	end

	local v34 = { z = tostring(p2), u = _T.StatsLastLevelEventTime, t = v31 }

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_d163c8e5(v27, 0) ~= 0 then
		v34.h = 1
	end

	ReplicateLogEvent(v33, "EXIT_LEVEL", v30, v32, cjson.encode(v34))

	if v29 then
		__wf_atom_21342f4a:Upload(Symbol("EXIT_LEVEL"))
	end

	_LevelChangeSideEffects()
	print("STATS EXIT_LEVEL " .. v30)
end

function TrackSiegeStart(p)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	__wf_atom_eab484a7:__wf_atom_3d7b47e7(v24, (tostring(p)))
	LogEventWithContext(v24, gRegion:__wf_atom_c4f78a8f(), nil, { l = tostring(p) }, true)
end

function TrackSiegeEnd(p, p2, p3)
	if __wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	if p2 then
		__wf_atom_eab484a7:__wf_atom_3d7b47e7(v26, (tostring(p)))
		LogEventWithContext(v26, gRegion:__wf_atom_c4f78a8f(), nil, { s = p3, l = tostring(p) }, true)
	else
		__wf_atom_eab484a7:__wf_atom_3d7b47e7(v25, (tostring(p)))
		LogEventWithContext(v25, gRegion:__wf_atom_c4f78a8f(), nil, { s = p3, l = tostring(p) }, true)
	end
end

function ClearTables()
	ClearBossFights()
	_G.StatsActiveLevelName = nil
	_G.StatsLoadingLevelName = nil
	_T.mStatsEventCompletedTable = nil
	_T.StatsLastLevelEventTime = nil
	v8 = {}

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_1b443c2b()
	end
end