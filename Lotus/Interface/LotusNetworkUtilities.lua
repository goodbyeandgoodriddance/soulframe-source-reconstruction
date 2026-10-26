module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.MissionRequirementUtilities")
SESSION_FFA = nil
SESSION_CLAN_ONLY = 1
SESSION_ALLIANCE_ONLY = 2
local v = Symbol("SolNode973")
local v2 = WeakResource("/Lotus/Interface/ThemedProjectionManager.swf")
local v3 = Resource("/Lotus/Interface/ArenaGambling.swf")
local v4 = WeakResource("/Lotus/Levels/ClanDojo/ClanDojoProcLevel")
local v5 = WeakResource("/Lotus/Levels/ClanDojo/ClanDojoDuelProcLevel")
local v6 = WeakResource("/Lotus/Levels/ClanDojo/ClanDojoCustomObstacleCourseProcLevel")
WeakResource("/Lotus/Types/Keys/SacrificeQuest/SacrificeQuestKeyTrackUmbraC")
WeakResource("/Lotus/Weapons/Tenno/Melee/Swords/UmbraKatana/UmbraKatana")
local v7 = {}
local v8 = {}
local fn
local fn2

local function fn3()
	local v9 = 2
	local v10 = getfenv(v9)

	while not v10.mMovie do
		v9 += 1
		v10 = getfenv(v9)
	end

	return v10
end

local function fn4()
	return _T.gSelectedNodeName ~= nil and string.find(_T.gSelectedNodeName, module2.KEY_TAG) ~= nil
end

function IsPlayingLevelKey()
	return (fn4())
end

local function fn5()
	return _T.gSelectedNodeName ~= nil and string.find(_T.gSelectedNodeName, "Dojo") ~= nil
end

function IsPlayingDojoKey()
	return (fn5())
end

local function fn6()
	return fn4() and _T.gKeyGameMode == _T.MATCHMAKING_QUICKMATCH_GAMEMODE
end

function IsPlayingPublicLevelKey()
	return (fn6())
end

local function fn7()
	local name = module.Ternary(_T.gSelectedNodeName == nil, "", _T.gSelectedNodeName)

	if (not name or name == "") and not __wf_atom_7e8ad928(_T.gPendingMission) then
		name = tostring(_T.gPendingMission.name)
	end

	return string.find(name, module2.HUB_TAG) ~= nil
end

local function fn8()
	return not (fn5() or fn7())
end

function IsHostElectionAllowed()
	return fn8()
end

local function fn9(p)
	return p
end

local function fn10(p)
	if __wf_atom_72884638("LotusGameRules.ForceRandomLevelSeed") then
		return math.random(1, 100000)
	end

	return (math.floor(gGameRules:__wf_atom_91a79d39() / (24 * p)))
end

function GetRotatingMissionSeed(p)
	return fn10(p)
end

local function fn11(value, p, p2, p3, maxPlayers)
	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if __wf_atom_7e8ad928(__wf_atom_15811761) or not gMatchingService:__wf_atom_607c7363() then
		_T.LNU_levelGenerationSeed = nil
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()
		local regionId

		if
			_T.gActiveMatchMakingMode == _T.MATCHMAKING_INVITE_ONLY_GAMEMODE
			or fn4()
			and not (value and string.find(value, module2.HARD_MODE_TAG))
			and (_T.gActiveMatchMakingMode ~= _T.MATCHMAKING_QUICKMATCH_GAMEMODE or not gMatchingService:__wf_atom_a676a953())
		then
			regionId = 1
		elseif p and _T.gActiveMatchMakingMode == _T.MATCHMAKING_QUICKMATCH_GAMEMODE then
			regionId = __wf_atom_7611b6b4.regionId
		else
			regionId = _T.gActiveMatchMakingMode == _T.MATCHMAKING_OFFLINE_GAMEMODE and 1 or 3
		end

		local v9 = value ~= nil and string.find(value, module2.HUB_TAG) and true or false

		if
			not v9
			and (not value or value == "")
			and not __wf_atom_7e8ad928(gGameRules)
			and gGameRules:IsA(__wf_atom_589d05aa)
			and gMatchingService:__wf_atom_a676a953()
		then
			p = true

			if gGameRules:IsA(__wf_atom_e714d8ac) then
				value = tostring(gGameRules:__wf_atom_72fc675e().location) .. module2.HUB_TAG
				v9 = true
			elseif not __wf_atom_7e8ad928(gGameRules:__wf_atom_72fc675e().levelKeyName) then
				value = tostring(gGameRules:__wf_atom_72fc675e().levelKeyName:__wf_atom_5b41f63b()) .. module2.KEY_TAG
			end
		end

		local settings = __wf_atom_15811761:GetSettings()
		local v10 = settings.regionId == 2 and not v9 and 2 or regionId
		local v11

		if value then
			v11 = tostring(value)
			local v12 = string.find(value, module2.TAG_SEPERATOR)

			if v12 ~= nil then
				v11 = string.sub(value, 1, v12 - 1)
			end
		else
			v11 = ""
		end

		local gameModeId = not p and 0 or module2.BuildGameModeIdForNode(value)
		local regionId2 = fn9(v10)

		if __wf_atom_15811761:__wf_atom_d271695b() then
			regionId2 = settings.regionId
		end

		if
			settings.regionId ~= regionId2
			or settings.gameModeId ~= gameModeId
			or maxPlayers and maxPlayers > 0
			or not maxPlayers and settings.maxPlayers > 4
		then
			_T.LNU_levelGenerationSeed = nil
			settings.regionId = regionId2
			settings.gameModeId = gameModeId
			print("In setting place, region id is: " .. tostring(regionId2))

			if maxPlayers and maxPlayers > 0 then
				settings.maxPlayers = maxPlayers
			elseif p2 == true then
				settings.maxPlayers = 4
			elseif gameModeId == 3973 then
				settings.maxPlayers = 2
			elseif settings.maxPlayers > 4 then
				settings.maxPlayers = 4
			end

			if
				_G.CachedGoalInfo
				and _G.CachedGoalInfo[v11]
				and (_G.CachedGoalInfo[v11].mMaxConclave > 0 or _G.CachedGoalInfo[v11].mBonusActive and _G.CachedGoalInfo[v11].mBonusMaxConclave > 0)
			then
				settings.eloRating = module.Ternary(
					_G.CachedGoalInfo[v11].mBonusActive and _G.CachedGoalInfo[v11].mBonusMaxConclave > 0,
					_G.CachedGoalInfo[v11].mBonusMaxConclave,
					_G.CachedGoalInfo[v11].mMaxConclave
				)
			else
				local v12 = p2 and __wf_atom_72884638("Multiplayer.RankedPVP")
				fn(settings, v12)
			end

			settings.guildId = ""

			if p2 then
				if _G.gClanOnlyMatchMaking == SESSION_CLAN_ONLY then
					settings.guildId = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_5ff594a3()
				elseif _G.gClanOnlyMatchMaking == SESSION_ALLIANCE_ONLY then
					settings.guildId = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_12956d9a()
				end
			end

			if settings.gameModeId == 0 then
				settings.maxPlayers = 4
			end

			print("Host changed to gameModeId=" .. settings.gameModeId .. " (" .. tostring(value) .. ")" .. "ELO=" .. tostring(settings.eloRating))
			gMatchingService:__wf_atom_c8d901d4(settings, p3)
		end
	end

	return true
end

function Host_AdvertisePublicGame(p, p2, p3, p4, maxPlayers)
	return fn11(p, p2, p3, p4, maxPlayers)
end

function ConfirmLaunchFailurePopup() end

local function fn12(object, p)
	local v9 = WeakResource(p)

	if not __wf_atom_7e8ad928(v9) then
		object:__wf_atom_fce3b660(v9)
	end
end

local function fn13(p, p2, p3)
	local v9 = _T.gSelectedNodeName and string.find(_T.gSelectedNodeName, module2.NEMESIS_MISSION_TAG) ~= nil
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		__wf_atom_83c14687(0)
		local v10 = __wf_atom_bb46d8b6[i]
		local decoded = cjson.decode(v10.loadout)
		local v11 = {}

		if p2 then
			for _, pvpLoadOut in ipairs(decoded.PvpLoadOuts) do
				for _, item in ipairs(pvpLoadOut.Items) do
					table.insert(v11, item)
				end
			end
		else
			v11 = {
				decoded.NORMAL[1],
				decoded.NORMAL[2],
				decoded.NORMAL[3],
				decoded.NORMAL[4],
				decoded.NORMAL[5]
			}

			if decoded.OPERATOR then
				table.insert(v11, decoded.OPERATOR[3])
			end

			if decoded.OPERATOR_ADULT then
				table.insert(v11, decoded.OPERATOR_ADULT[3])
			end

			if p3 and decoded.ARCHWING then
				for j = 1, #decoded.ARCHWING do
					table.insert(v11, decoded.ARCHWING[j])
				end
			end

			if decoded.DATAKNIFE then
				table.insert(v11, decoded.DATAKNIFE[1])
			end

			if decoded.operatorSuit then
				fn12(p, decoded.operatorSuit)
			end

			if decoded.OperatorSkins then
				for j = 1, #decoded.OperatorSkins do
					fn12(p, decoded.OperatorSkins[j])
				end
			end

			if decoded.FocusAbility then
				fn12(p, decoded.FocusAbility)
			end

			for j = 1, #decoded.Consumables do
				fn12(p, decoded.Consumables[j])
			end

			if v9 then
				local _nemesis = decoded.Nemesis
			end
		end

		if v10.extraLoadoutDeps and v10.extraLoadoutDeps ~= "" then
			local decoded2 = cjson.decode(v10.extraLoadoutDeps)

			if decoded2.LoadoutDeps then
				for j = 1, #decoded2.LoadoutDeps do
					fn12(p, decoded2.LoadoutDeps[j])
				end
			end
		end

		for j = 1, #v11 do
			if __wf_atom_7e8ad928(v11[j]) or __wf_atom_7e8ad928(v11[j].ItemType) then
				continue
			end

			fn12(p, v11[j].ItemType)

			if not __wf_atom_7e8ad928(v11[j].WeaponUpgrades) then
				local v12 = v11[j]

				for k = 1, #v12.WeaponUpgrades do
					fn12(p, v12.WeaponUpgrades[k])
				end
			end

			if __wf_atom_7e8ad928(v11[j].ModularPartTypes) then
				continue
			end

			local v12 = v11[j]

			for k = 1, #v12.ModularPartTypes do
				fn12(p, v12.ModularPartTypes[k])
			end
		end

		if not __wf_atom_7e8ad928(decoded.ShipType) then
			fn12(p, decoded.ShipType)
		end
	end
end

function SetContextObjectsFromSquadLoadOuts(p, p2, p3)
	fn13(p, p2, p3)
end

local function fn14(list, object)
	for _, v9 in ipairs(list) do
		if not __wf_atom_7e8ad928(v9.agent) then
			object:__wf_atom_fce3b660(v9.agent)
		end

		if __wf_atom_7e8ad928(v9.weaponOverrides) then
			continue
		end

		for _, weaponOverride in ipairs(v9.weaponOverrides) do
			if not __wf_atom_7e8ad928(weaponOverride) then
				object:__wf_atom_fce3b660(weaponOverride)
			end
		end
	end
end

function AddEnemiesToContextObjects(p, p2)
	fn14(p, p2)
end

local function fn15(object, object2, p)
	fn14(object2:__wf_atom_0958db03(), object)
	fn14(object2:__wf_atom_1db08652(), object)
	local __wf_atom_65a78aaf = object2:__wf_atom_65a78aaf()

	for i = 1, #__wf_atom_65a78aaf do
		object:__wf_atom_fce3b660(__wf_atom_65a78aaf[i].resource)
	end

	local __wf_atom_4ccf4f85 = object2:__wf_atom_4ccf4f85()

	for i = 1, #__wf_atom_4ccf4f85 do
		object:__wf_atom_fce3b660(__wf_atom_4ccf4f85[i].resource)
	end

	local __wf_atom_bd54da48 = object2:__wf_atom_bd54da48()

	for i = 1, #__wf_atom_bd54da48 do
		object:__wf_atom_fce3b660(__wf_atom_bd54da48[i])
	end

	local __wf_atom_5623185e = object2:__wf_atom_5623185e()

	for i = 1, #__wf_atom_5623185e do
		object:__wf_atom_fce3b660(__wf_atom_5623185e[i])
	end

	for _, buddyAgent in pairs(object2.buddyAgents) do
		object:__wf_atom_fce3b660(buddyAgent)
	end

	local __wf_atom_d74a2fe7 = object2:__wf_atom_d74a2fe7()

	for i = 1, #__wf_atom_d74a2fe7 do
		if not __wf_atom_7e8ad928(__wf_atom_d74a2fe7[i]) then
			object:__wf_atom_fce3b660(__wf_atom_d74a2fe7[i])
		end
	end

	local __wf_atom_ba72f07d = object2:__wf_atom_ba72f07d()

	for i = 1, #__wf_atom_ba72f07d do
		if not __wf_atom_7e8ad928(__wf_atom_ba72f07d[i]) then
			object:__wf_atom_fce3b660(__wf_atom_ba72f07d[i])
		end
	end

	local __wf_atom_82c10278 = object2:__wf_atom_82c10278()

	for i = 1, #__wf_atom_82c10278 do
		local v9 = __wf_atom_82c10278[i]

		if not __wf_atom_7e8ad928(v9) then
			object:__wf_atom_fce3b660(v9)
		end
	end

	if not __wf_atom_7e8ad928(object2.eomBoss) then
		object:__wf_atom_fce3b660(object2.eomBoss)
	end

	if not __wf_atom_7e8ad928(object2.eomBossTransmission) then
		object:__wf_atom_fce3b660(object2.eomBossTransmission)
	end

	if not __wf_atom_7e8ad928(object2.eomBossTaunt) then
		object:__wf_atom_fce3b660(object2.eomBossTaunt)
	end

	if object2.syndicateId ~= "" then
		local location = tostring(object2.location)

		if
			_T.CachedSyndicateMissions[location]
			and not __wf_atom_7e8ad928(_T.CachedSyndicateMissions[location].mBuddyAgents)
		then
			for i = 1, #_T.CachedSyndicateMissions[location].mBuddyAgents do
				object:__wf_atom_fce3b660(_T.CachedSyndicateMissions[location].mBuddyAgents[i])
			end
		end
	end

	if
		__wf_atom_7e8ad928(p)
		and _T.CachedGoalKeys
		and not __wf_atom_7e8ad928(_T.CachedGoalKeys[tostring(object2.location)])
	then
		p = _T.CachedGoalKeys[tostring(object2.location)]
	end

	if not __wf_atom_7e8ad928(p) then
		object:__wf_atom_fce3b660(p)
	end

	if not __wf_atom_7e8ad928(object2.keyChainName) then
		object:__wf_atom_fce3b660(object2.keyChainName)
	end

	if not __wf_atom_7e8ad928(object2.transmissionOverrides) then
		object:__wf_atom_fce3b660(object2.transmissionOverrides)
	end

	if object2.tier > 0 then
	end

	fn12(object, nil)

	if object2.voidStorm and not __wf_atom_7e8ad928(_T.VoidTearDefaultEnemySpec) then
		fn14(_T.VoidTearDefaultEnemySpec:__wf_atom_0958db03(), object)
	end

	local starChart = module2.GetStarChart()

	if __wf_atom_7e8ad928(starChart) then
		return
	end

	local v9 = nil

	if __wf_atom_7e8ad928(p) then
		v9 = starChart:__wf_atom_db2d8292(object2.location)
	else
		local v10 = Resource(p)

		if not __wf_atom_7e8ad928(v10) then
			v9 = starChart:__wf_atom_161b95d4()[v10:__wf_atom_1c4ed35a()]
		end
	end

	if __wf_atom_7e8ad928(v9) then
		return
	end

	if v9.resources ~= nil then
		for _, resource in ipairs(v9.resources) do
			if not __wf_atom_7e8ad928(resource.mStoreItem) then
				object:__wf_atom_fce3b660(resource.mStoreItem)
			end

			if not __wf_atom_7e8ad928(resource.mItemType) then
				object:__wf_atom_fce3b660(resource.mItemType)
			end

			if not __wf_atom_7e8ad928(resource.mDecoType) then
				object:__wf_atom_fce3b660(resource.mDecoType)
			end
		end
	end

	if v9.drops ~= nil then
		for _, drop in ipairs(v9.drops) do
			if not __wf_atom_7e8ad928(drop.mStoreItem) then
				object:__wf_atom_fce3b660(drop.mStoreItem)
			end

			if not __wf_atom_7e8ad928(drop.mItemType) then
				object:__wf_atom_fce3b660(drop.mItemType)
			end

			if not __wf_atom_7e8ad928(drop.mDecoType) then
				object:__wf_atom_fce3b660(drop.mDecoType)
			end
		end
	end

	if not __wf_atom_7e8ad928(object2.vipAgent) then
		object:__wf_atom_fce3b660(object2.vipAgent)
		local __wf_atom_d5d42e7f = starChart:__wf_atom_d5d42e7f(object2.location, object2.vipAgent)

		for i = 1, #__wf_atom_d5d42e7f do
			object:__wf_atom_fce3b660(__wf_atom_d5d42e7f[i])
		end
	end

	object:__wf_atom_11c734e9(v9:__wf_atom_9e39ddca())
end

function AddMissionContextObjects(p, p2)
	fn15(p, p2)
end

local function fn16(object, p, p2)
	if p == 1 then
		local HARD_MODE_ARCHWING_LEVEL_MODIFIER, v9

		if
			object.archwingRequired
			and not object.isSharkwingMission
			and object.missionType ~= 28
			and string.find(tostring(object.levelOverride:__wf_atom_5b41f63b()), "GrineerFortress") == nil
		then
			HARD_MODE_ARCHWING_LEVEL_MODIFIER = module2.HARD_MODE_ARCHWING_LEVEL_MODIFIER
			v9 = v8
		else
			HARD_MODE_ARCHWING_LEVEL_MODIFIER = module2.HARD_MODE_LEVEL_MODIFIER
			v9 = v7
		end

		object.tier = 1
		object.difficulty = 1

		if not p2 then
			object.minEnemyLevel += HARD_MODE_ARCHWING_LEVEL_MODIFIER
			object.maxEnemyLevel += HARD_MODE_ARCHWING_LEVEL_MODIFIER
		end

		for _, v10 in pairs(v9) do
			object:__wf_atom_a0a06714(v10)
		end
	end
end

function ApplyDifficultyChanges(p, p2, p3)
	fn16(p, p2, p3)
end

local function fn17(object, object2, p, p2, gameRules, gameRules2, p3, p4)
	if __wf_atom_7e8ad928(object) or object == EMPTY_SYMBOL then
		return
	end

	local v9 = tostring(object)

	if object2 == nil then
		print("LotusNetworkUtilities:Host_LoadMission, missionInfo is null")
		return
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()
	module2.ApplyPostNewWarMissionOverrides(object2)
	_T.gSelectedNodeName = object:c_str()
	_G.gSelectedNodeName = _T.gSelectedNodeName
	local v10 = string.find(_T.gSelectedNodeName, module2.HUB_TAG)
	local soloMode = object2.soloMode
	local isAutonomous = v10 ~= nil
	local result = isAutonomous and not __wf_atom_7e8ad928(_T.gDojoData) and _T.gDojoData.Result
	local v11 = string.find(v9, "DojoDuel") ~= nil
	local v12 = string.find(v9, "DojoCustomObstacleCourse") ~= nil

	if soloMode then
		if not __wf_atom_7e8ad928(__wf_atom_15811761) then
			local settings = __wf_atom_15811761:GetSettings()

			if settings.regionId ~= 2 then
				settings.regionId = 2
				gMatchingService:__wf_atom_c8d901d4(settings, "OnUpdateSessionSettings")
			end
		end
	elseif v10 == nil and not (v11 or v12) then
		local ternary = module.Ternary(p4 == true, object2.maxPlayersOverride, nil)

		if not fn11(_T.gSelectedNodeName, nil == nil, p2, "OnUpdateSessionSettings", ternary) then
			module.ShowMessage("/Lotus/Language/Menu/Multiplayer_FailedToHost", "ConfirmLaunchFailurePopup")
			return
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		print("_GetMissionOpenLevelArgs: playerProfile is null")
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local gameModeIdForNode = module2.BuildGameModeIdForNode(_T.gSelectedNodeName)

		if not p2 then
			__wf_atom_9be88b01:__wf_atom_100dfae2(gameModeIdForNode)
		end

		__wf_atom_9be88b01:__wf_atom_ba654377(gameModeIdForNode)
	end

	if __wf_atom_7e8ad928(_T.gKeyChainUsed) then
		if (__wf_atom_7e8ad928(p3) or p3) and fn4() then
			if soloMode then
				object2.levelKeyOwnerId = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()
			else
				object2.levelKeyOwnerId = gMatchingService:__wf_atom_c05ba044()
			end
		end
	else
		object2.levelKeyOwnerId = ""
	end

	if
		p4
		and __wf_atom_7e8ad928(p)
		and string.find(_T.gSelectedNodeName, module2.NIGHTMARE_TAG)
		and object2.missionType ~= 18
	then
		local __wf_atom_d5226f21 = module2.GetStarChart():__wf_atom_d5226f21(object2.location)
		object2.seed = __wf_atom_d5226f21.mission.seed
		object2.difficulty = 1
		object2.minEnemyLevel += 10
		object2.maxEnemyLevel += 10
		object2.periodicMissionTag = Symbol("NightmareRegion" .. __wf_atom_d5226f21.region + 1)
		object2.periodicMissionCooldown = module2.NIGHTMARE_MISSION_INTERVAL
	end

	local flag

	if string.find(v9, module2.HARD_MODE_TAG) == nil and string.find(v9, module2.HARD_DAILY_TAG) == nil then
		flag = false
	else
		fn16(object2, 1, string.find(v9, module2.HARD_DAILY_TAG) ~= nil)
		flag = true
	end

	local levelOverride = object2.levelOverride
	local v13 = not soloMode
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.hostingMultiplayer = v13
	levelArgs.migrateServer = true

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) and module2.IsSeasonActive() then
		local mSeasonInfo = __wf_atom_9be88b01:__wf_atom_92662866().mSeasonInfo

		if mSeasonInfo.mSeason == 2 and mSeasonInfo.mPhase > 1 then
			local location = tostring(object2.location)

			if
				not object2.archwingRequired
				and object2.missionType ~= 28
				and object2.missionType ~= 18
				and object2.missionType ~= 22
				and object2.missionType ~= 0
				and object2.missionType ~= 20
				and object2.minEnemyLevel > 5
				and object2.conclaveRange.maxValue <= 0
				and object2.goalId == ""
				and object2.sortieId == ""
				and __wf_atom_7e8ad928(object2.keyChainName)
				and not string.find(location, "EventNode")
				and object2.periodicMissionTag ~= module2.ELITE_ALERT_PERIODIC_MISSION_TAG
				and object2.periodicMissionTag ~= module2.ELITE_ALERT_PERIODIC_MISSION_TAG_ALT
				and object2.faction ~= 5
				and object2:__wf_atom_a91b48fb() > 4
			then
				object2:__wf_atom_b5312e70(nil)
			end
		end
	end

	if object2.missionType == 28 then
		levelArgs.streamingLayer = 255
		module2.__wf_atom_71968a76(object2.location, levelArgs)

		if _T.LNU_levelGenerationSeed then
			levelArgs:__wf_atom_5d58caf8(__wf_atom_3e61816b(_T.LNU_levelGenerationSeed))
		end
	end

	if result then
		local v14 = Resource(v4)
		levelOverride = v14:__wf_atom_96ea76e4(_T.gDojoData.Body)

		if __wf_atom_7e8ad928(levelOverride) then
			print("Error constructing Dojo with data retrieved!")
			return nil
		end

		local __wf_atom_ff2a5161 = v14:__wf_atom_ff2a5161()

		for i = 1, #__wf_atom_ff2a5161 do
			levelArgs:__wf_atom_fce3b660(__wf_atom_ff2a5161[i])
		end

		object2.location = Symbol(_T.gDojoData.GuildId)
		gMatchingService:__wf_atom_080915b6(v14:__wf_atom_001889b4())
	elseif v11 then
		local v14 = Resource(v5)

		if __wf_atom_7e8ad928(_T.gPendingDuel) then
			levelOverride = nil
		else
			levelOverride = v14:__wf_atom_e5a74bea({ _T.DojoMgr:GetStandaloneComponent(_T.gPendingDuel.RoomId) })
		end

		if __wf_atom_7e8ad928(levelOverride) then
			print("Error constructing Dojo Duel level!")
			return nil
		end

		local __wf_atom_ff2a5161 = v14:__wf_atom_ff2a5161()

		for i = 1, #__wf_atom_ff2a5161 do
			levelArgs:__wf_atom_fce3b660(__wf_atom_ff2a5161[i])
		end
	elseif v12 then
		local roomID = _T.ActivatedObstacleCourse.RoomID
		_G.obstacleCourseRoomID = roomID
		local v14 = { _T.DojoMgr:GetStandaloneComponent(roomID) }
		local v15 = Resource(v6)
		levelOverride = v15:__wf_atom_e5a74bea(v14)

		if __wf_atom_7e8ad928(levelOverride) then
			print("Error constructing custom obstacle course level!")
			return nil
		end

		local __wf_atom_ff2a5161 = v15:__wf_atom_ff2a5161()

		for i = 1, #__wf_atom_ff2a5161 do
			levelArgs:__wf_atom_fce3b660(__wf_atom_ff2a5161[i])
		end
	elseif not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_311a7128) then
		levelOverride = gGameRules:GetLevelForMission(levelOverride, object)

		if __wf_atom_7e8ad928(levelOverride) then
			print("Error nil level from GetLevelForMission!")
			return nil
		end
	end

	if __wf_atom_7e8ad928(levelOverride) then
		print("Error nil level from missionInfo.levelOverride!")
		return nil
	end

	levelArgs:SetLevel(levelOverride:__wf_atom_5b41f63b())
	local __wf_atom_cf762a4f = object2:__wf_atom_cf762a4f()
	print("Host loading " .. gMatchingService:__wf_atom_8b0475eb() .. " with MissionInfo: \n" .. __wf_atom_cf762a4f)
	levelArgs:__wf_atom_98718663(__wf_atom_cf762a4f)

	if object2.soloMode then
		levelArgs.isSoloMode = true
	end

	if result then
		local decoded = cjson.decode(_T.gDojoData.Body)

		if _T.gDojoData.DryDockRequired then
			local v14 = false

			for i = 1, #decoded.DojoComponents do
				if decoded.DojoComponents[i].pf ~= "/Lotus/Levels/ClanDojo/DojoRailjackHangar.level" then
					continue
				end

				v14 = true
				break
			end

			if not v14 then
				print("Dojo does not have a DryDock component, where would we park the Railjack?!")
				return nil
			end
		end

		levelArgs:__wf_atom_98718663(_T.gDojoData.GuildId)
		levelArgs:__wf_atom_98718663(decoded.Name)
		levelArgs:__wf_atom_98718663(gMatchingService:__wf_atom_6020c572())

		if decoded.TradeTax == nil then
			levelArgs:__wf_atom_98718663("0")
		else
			levelArgs:__wf_atom_98718663((tostring(decoded.TradeTax)))
		end

		if decoded.Class == nil then
			levelArgs:__wf_atom_98718663("0")
		else
			levelArgs:__wf_atom_98718663((tostring(decoded.Class)))
		end

		if decoded.NumContributors ~= nil then
			levelArgs:__wf_atom_98718663((tostring(decoded.NumContributors)))
		end

		if decoded.CeremonyResetDate ~= nil then
			local numberLong = decoded.CeremonyResetDate["$date"]["$numberLong"]
			levelArgs:__wf_atom_98718663((string.sub(numberLong, 1, string.len(numberLong) - 3)))
		end
	elseif v11 then
		levelArgs:__wf_atom_98718663(gGameRules:__wf_atom_5ff594a3())
		levelArgs:__wf_atom_98718663(gGameRules:__wf_atom_84083b39())
		levelArgs:__wf_atom_98718663(_T.gPendingDuel.RoomId)
	elseif v12 then
		local roomID = _T.ActivatedObstacleCourse.RoomID
		_G.obstacleCourseRoomID = roomID
		levelArgs:__wf_atom_98718663(gGameRules:__wf_atom_5ff594a3())
		levelArgs:__wf_atom_98718663(gGameRules:__wf_atom_84083b39())
		levelArgs:__wf_atom_98718663(_T.ActivatedObstacleCourse.RoomID)
		levelArgs:__wf_atom_98718663((tostring(_T.ActivatedObstacleCourse.courseMode)))
	end

	if not __wf_atom_7e8ad928(object2.loadingScreenOverride) then
		levelArgs:__wf_atom_1958a607(object2.loadingScreenOverride:__wf_atom_5b41f63b())
	end

	if p2 then
		levelArgs.gameRules = gameRules
	end

	if v10 ~= nil and not result and (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_e714d8ac)) then
		levelArgs.gameRules = gameRules2
		levelArgs.loadToLobby = true
		levelArgs.isLobby = true
		module2.ApplyPostNewWarHubLevelArgs(levelArgs, (string.sub(_T.gSelectedNodeName, 1, v10 - 1)))
	end

	if __wf_atom_7e8ad928(levelArgs.gameRules) then
		levelArgs.gameRules = object2.gameRules
	end

	fn13(levelArgs, object2.missionType == 10 and not (v11 or isAutonomous), object2.archwingRequired)
	fn15(levelArgs, object2, p)

	if v11 and not __wf_atom_7e8ad928(_T.gPendingDuel.OpponentId) then
		local __wf_atom_215d83a3 = gGameRules:__wf_atom_215d83a3(_T.gPendingDuel.OpponentId)

		for i = 0, 6 - 1 do
			local __wf_atom_ed5c034d = __wf_atom_215d83a3:__wf_atom_ed5c034d(0, i)

			if __wf_atom_7e8ad928(__wf_atom_ed5c034d) or __wf_atom_7e8ad928(__wf_atom_ed5c034d.mItemType) then
				continue
			end

			fn12(levelArgs, __wf_atom_ed5c034d.mItemType)

			if __wf_atom_7e8ad928(__wf_atom_ed5c034d.mWeaponUpgrades) then
				continue
			end

			for j = 1, #__wf_atom_ed5c034d.mWeaponUpgrades do
				fn12(levelArgs, __wf_atom_ed5c034d.mWeaponUpgrades[j])
			end
		end
	end

	local v14 = string.find(_T.gSelectedNodeName, module2.ACTIVE_MISSION_TAG)

	if v14 then
		local v15 = string.sub(_T.gSelectedNodeName, 1, v14 - 1)
		local v16 = nil
		local mLevelObjects = nil

		if _T.CachedActiveMissions[v15] then
			v16 = _T.CachedActiveMissions[v15].mCustomEnemies:__wf_atom_0958db03()
			mLevelObjects = _T.CachedActiveMissions[v15].mLevelObjects
		else
			print("GetMissionOpenLevelArgs: Active mission expired! Using default enemySpec")

			if _T.VoidTearDefaultEnemySpec then
				v16 = _T.VoidTearDefaultEnemySpec:__wf_atom_0958db03()
			end
		end

		if mLevelObjects then
			for _, mLevelObject in pairs(mLevelObjects) do
				levelArgs:__wf_atom_fce3b660(mLevelObject)
			end
		end

		if v16 then
			fn14(v16, levelArgs)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local __wf_atom_92662866 = __wf_atom_9be88b01:__wf_atom_92662866()

		for _, mGoal in ipairs(__wf_atom_92662866.mGoals) do
			if
				__wf_atom_7e8ad928(mGoal.mRoamingVIP)
				or not (object2:__wf_atom_7ebd1b67() == EMPTY_SYMBOL or mGoal.mFaction == object2.faction)
			then
				continue
			end

			if not (Engine.__wf_atom_db2b0cee(mGoal.mActivation) < 0 and Engine.__wf_atom_db2b0cee(mGoal.mExpiry) > 0) then
				continue
			end

			levelArgs:__wf_atom_fce3b660(mGoal.mRoamingVIP)
		end
	end

	levelArgs:__wf_atom_11c734e9(object2:__wf_atom_fda0d558())
	local hasRelayReconstructionEnemy, _ = module2.HasRelayReconstructionEnemy(object2)

	if hasRelayReconstructionEnemy then
		local __wf_atom_6e0a7c39 = __wf_atom_c67f9605:__wf_atom_6e0a7c39()
		levelArgs:__wf_atom_fce3b660(__wf_atom_6e0a7c39.enhancement)
		levelArgs:__wf_atom_fce3b660(__wf_atom_6e0a7c39.item)
		levelArgs:__wf_atom_fce3b660(__wf_atom_6e0a7c39.enemyMarkerType)
		levelArgs:__wf_atom_fce3b660(__wf_atom_6e0a7c39.enemySpawnTransmission)
	end

	if flag then
		levelArgs:__wf_atom_fce3b660(nil)
	end

	if
		object2.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG
		or object2.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG_ALT
	then
		levelArgs:__wf_atom_fce3b660(nil)
	end

	if isAutonomous or not fn8() then
		levelArgs.chooseBestHost = false
	else
		levelArgs.chooseBestHost = true
	end

	levelArgs.loadFromLobby = v13
	levelArgs.isAutonomous = isAutonomous

	if not __wf_atom_7e8ad928(object2.gameRules) and object2.gameRules:IsA(__wf_atom_311a7128) then
		levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
	end

	print("Lobby::Host_StartMatch: launching level for " .. _T.gSelectedNodeName .. " (" .. levelOverride:__wf_atom_5b41f63b() .. ")")

	if object2.missionType ~= 28 then
		return levelArgs
	end

	print("ContextObjects:")
	local contextObjects = levelArgs.contextObjects

	for i = 1, #contextObjects do
		if __wf_atom_7e8ad928(contextObjects[i]) then
			assert(
				false,
				"null context object at index " .. i .. "! Check for broken types referenced by mission info enemySpec etc"
			)
		else
			print("    " .. tostring(contextObjects[i]:__wf_atom_5b41f63b()))
		end
	end

	return levelArgs
end

function GetMissionOpenLevelArgs(p, p2, p3, p4, gameRules, gameRules2, p5, p6)
	return (fn17(p, p2, p3, p4, gameRules, gameRules2, p5, p6))
end

function Host_LoadMission(p, p2, p3, p4, gameRules, gameRules2, p5)
	local v9 = fn17(p, p2, p3, p4, gameRules, gameRules2, p5, true)

	if v9 == nil then
		module.ShowMessage("/Lotus/Language/Menu/Multiplayer_FailedToHost")
		return nil
	end

	Engine.OpenLevel(v9)
	return v9
end

function JoinLobby(p, object, p2)
	local mMovie = fn3().mMovie

	if gMatchingService:__wf_atom_607c7363() and not __wf_atom_7e8ad928(p2) then
		gMatchingService:__wf_atom_760bf754(p)
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if object:__wf_atom_e6770097() then
		print("LotusNetworkUtilities - lobby ready!")
		mMovie:Execute(p, "true")
	else
		print("LotusNetworkUtilities.lua - JoinLobby")
		gMatchingService:JoinSquadSession(__wf_atom_18a5d83b, object, false, 255, p)
	end
end

local function fn18(p, object, p2, p3)
	local mMovie

	if p3 == nil then
		mMovie = fn3().mMovie
	end

	if gMatchingService:__wf_atom_607c7363() and not __wf_atom_7e8ad928(p2) then
		gMatchingService:__wf_atom_760bf754(p)
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if object:__wf_atom_e6770097() then
		print("LotusNetworkUtilities - lobby ready!")

		if not __wf_atom_7e8ad928(mMovie) then
			mMovie:Execute(p, "true")
		end
	else
		print("LotusNetworkUtilities.lua - JoinLobby")
		gMatchingService:JoinSession(__wf_atom_18a5d83b, object, false, 255, p)
	end
end

function JoinDojo(p, p2, p3, p4)
	fn18(p, p2, p3, p4)
end

local function fn19(p, pvpRank)
	if not p then
		return pvpRank
	end

	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		__wf_atom_83c14687(0)
		local v9 = __wf_atom_bb46d8b6[i]
		local decoded = cjson.decode(v9.loadout)

		if decoded.pvpRank and pvpRank < decoded.pvpRank then
			pvpRank = decoded.pvpRank
		end
	end

	return pvpRank
end

function GetMaxSquadPvpRank(p, p2)
	return fn19(p, p2)
end

fn = function(p, p2)
	p.eloRating = module2.GetPlayerEloRating(p2)
	local v9 = fn19(p2, 0)
	local pvpEloRatingForRank = module2.GetPVPEloRatingForRank(v9)

	if p.eloRating < pvpEloRatingForRank then
		p.eloRating = pvpEloRatingForRank
	end
end

local function fn20(sessionSearch, p)
	if p then
		sessionSearch.maxEloDifference = 1
		sessionSearch.enforceElo = true
	else
		sessionSearch.maxEloDifference = 10
	end

	fn(sessionSearch, p)

	if module2.IsPvpGameModeId(sessionSearch.gameModeId) and _G.gClanOnlyMatchMaking then
		sessionSearch.guildOnly = true
	end
end

function FindPublicSessionsForNode(value, p, incrementalPingLimit, callback)
	if gMatchingService:IsBlockingTaskPending() or string.find(value, module2.HUB_TAG) then
		return false
	end

	print("FindPublicSessionsForNode")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local settings = __wf_atom_18a5d83b:Settings()
	local __wf_atom_7611b6b4 = settings:__wf_atom_7611b6b4()
	local sessionSearch = Engine.SessionSearch()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 1
	else
		sessionSearch.matchType = 2
	end

	sessionSearch.gameModeId = module2.BuildGameModeIdForNode(value)
	sessionSearch.regionId = fn9(__wf_atom_7611b6b4.regionId)

	if module2.IsPvpGameModeId(sessionSearch.gameModeId) then
		if _G.gClanOnlyMatchMaking == SESSION_ALLIANCE_ONLY then
			sessionSearch.guildId = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_12956d9a()
		else
			sessionSearch.guildId = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_5ff594a3()
		end
	end

	local v9 = string.find(value, module2.KEY_TAG)

	if v9 then
		local map = string.sub(value, 1, v9 - 1)

		if gMatchingService:__wf_atom_a676a953() and _G.Scenario and _G.Scenario.ScenarioId then
			map ..= _G.Scenario.ScenarioId
		end

		sessionSearch.map = map
		sessionSearch.wantMap = true
	end

	local v10 = string.find(value, module2.TAG_SEPERATOR)
	local v11

	if v10 == nil then
		v11 = value
	else
		v11 = string.sub(value, 1, v10 - 1)
	end

	local __wf_atom_d5226f21 = module2.GetStarChart():__wf_atom_d5226f21(Symbol(v11))
	local v12 = false

	if __wf_atom_d5226f21.mission and __wf_atom_d5226f21.mission.missionType == 28 then
		if __wf_atom_7e8ad928(_T.gPendingMission.job) then
			sessionSearch.eloRating = module2.GetModifiedPlainsElo(value, module2.PLAINS_ELO_INSIDE_SAFE_ZONE)
			sessionSearch.maxEloDifference = 1
			sessionSearch.enforceElo = true
			v12 = true
			sessionSearch.wantMap = true
			local __wf_atom_0a97e32a = module2.GetStarChart():__wf_atom_0a97e32a(Symbol(v11))

			if __wf_atom_0a97e32a ~= 0 then
				sessionSearch.map = tostring((fn10(__wf_atom_0a97e32a)))
			end
		else
			sessionSearch.wantMap = true
			sessionSearch.map = _T.gPendingMission.job
		end
	end

	if module2.CanMergeSquad(sessionSearch.gameModeId) then
		sessionSearch.wantPlayers = true
		sessionSearch.players = math.max(1, gMatchingService:__wf_atom_8b3e33a6())
		fn20(sessionSearch, __wf_atom_72884638("Multiplayer.RankedPVP"))
		print("Looking for session with " .. sessionSearch.players .. " free slot(s)")
	elseif _G.StalkerMode then
		sessionSearch.wantPlayers = true
		sessionSearch.players = 0
	elseif _T.gActiveMatchMakingMode == _T.MATCHMAKING_QUICKMATCH_GAMEMODE then
		local v13 = __wf_atom_72884638("Multiplayer.RankedPVP") and module2.IsPvpGameModeId(sessionSearch.gameModeId)

		if not v12 then
			fn20(sessionSearch, v13)
		end

		if
			__wf_atom_d5226f21.missionsCompleted == 0
			and (__wf_atom_d5226f21.nodeType == 0 or __wf_atom_d5226f21.nodeType == 8)
			and not (_T.CachedAlerts and _T.CachedAlerts[v11] and _T.CachedAlerts[v11].mVisible)
			and not (_G.CachedGoalInfo[v11] or _T.CachedInvasionInfo and _T.CachedInvasionInfo[v11])
			and not (_T.CachedSyndicateMissions and _T.CachedSyndicateMissions[v11] and _T.CachedSyndicateMissions[v11].mVisible)
			and (not __wf_atom_d5226f21.mission or __wf_atom_d5226f21.mission.missionType ~= 32)
			and not gMatchingService:__wf_atom_a676a953()
		then
			sessionSearch.allowJoinInProgress = false
		end

		if
			_G.CachedGoalInfo[v11]
			and (_G.CachedGoalInfo[v11].mMaxConclave > 0 or _G.CachedGoalInfo[v11].mBonusActive and _G.CachedGoalInfo[v11].mBonusMaxConclave > 0)
		then
			sessionSearch.eloRating = module.Ternary(
				_G.CachedGoalInfo[v11].mBonusActive and _G.CachedGoalInfo[v11].mBonusMaxConclave > 0,
				_G.CachedGoalInfo[v11].mBonusMaxConclave,
				_G.CachedGoalInfo[v11].mMaxConclave
			)
			sessionSearch.maxEloDifference = 0
			sessionSearch.enforceElo = true
		end

		print("Client gameModeId=" .. sessionSearch.gameModeId .. ", ELO=" .. sessionSearch.eloRating .. ", range " .. sessionSearch.maxEloDifference .. ", allowJoinInProgress=" .. tostring(sessionSearch.allowJoinInProgress))
	end

	if __wf_atom_72884638("Multiplayer.DedicatedServersOnly") then
		sessionSearch.dedicatedServer = true
	end

	if callback then
		callback(sessionSearch)
	end

	local __wf_atom_517d18d6 = settings:__wf_atom_517d18d6()

	if __wf_atom_517d18d6 < 1500 then
		sessionSearch.maxPing = __wf_atom_517d18d6
	end

	if incrementalPingLimit then
		print("Incremental search ping limit: " .. tostring(incrementalPingLimit))
		sessionSearch.incrementalPingLimit = incrementalPingLimit
	end

	gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, p)
	return true
end

function FindSessionById(p, p2, p3, ignoreBadReputation)
	if gMatchingService:IsBlockingTaskPending() then
		return false
	end

	print("LNU - FindSessionById")
	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) then
		print("Current session id=" .. tostring(__wf_atom_15811761:__wf_atom_855a3505()))

		if __wf_atom_15811761:__wf_atom_855a3505() == p then
			return false
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local sessionSearch = Engine.SessionSearch()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 0
	else
		sessionSearch.matchType = 2
	end

	if p3 == true then
		sessionSearch.originalSessionId = p
	else
		sessionSearch.sessionId = p
	end

	if ignoreBadReputation then
		sessionSearch.ignoreBadReputation = ignoreBadReputation
	end

	gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, p2)
	return true
end

local function fn21(originalSessionId, p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()

	if gMatchingService:__wf_atom_c5171bd3() then
		__wf_atom_7611b6b4.matchType = 0
	else
		__wf_atom_7611b6b4.matchType = 2
	end

	__wf_atom_7611b6b4.regionId = 1
	__wf_atom_7611b6b4.minPlayers = 1
	__wf_atom_7611b6b4.maxPlayers = 200
	__wf_atom_7611b6b4.enableVoice = false
	__wf_atom_7611b6b4.customSettings = cjson.encode({ dojoP2P = true })

	if originalSessionId == nil then
		__wf_atom_7611b6b4.gameModeId = module2.BuildGameModeIdForClanDojo()
		__wf_atom_7611b6b4.originalSessionId = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_5ff594a3()
		__wf_atom_7611b6b4:__wf_atom_1484e91e(__wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_84083b39())
	else
		__wf_atom_7611b6b4.gameModeId = module2.BuildGameModeIdForDojoDuel()
		__wf_atom_7611b6b4.originalSessionId = originalSessionId
		__wf_atom_7611b6b4:__wf_atom_1484e91e(p)
	end

	return __wf_atom_7611b6b4
end

function GetDojoHostSettings(originalSessionId, p)
	return fn21(originalSessionId, p)
end

local function fn22(p, p2, originalSessionId, p3)
	print("LotusNetworkUtilities::HostClanDojoLobby")

	if gMatchingService:IsBlockingTaskPending() then
		print("Can't host dojo due to active session or pending async task. MatchingService state=" .. tostring(gMatchingService:GetState()))
		return false, "/Lotus/Language/Menu/HostDojoFailureSessionActive", false
	end

	if Engine.IsPlayingWithController() and (p >= 10 or p >= 5 and not gGameRules:__wf_atom_137430a3()) then
		print("Failed to host/join dojo, connection issues")
		return false, "/Lotus/Language/Menu/Dojo_ConnectionError", true
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v9 = fn21(originalSessionId, p3)
	print("Host settings: matchType=" .. tostring(v9.matchType) .. ", originalSessionId (guildId)=" .. tostring(v9.originalSessionId) .. ", regionId=" .. tostring(v9.regionId) .. ", gameModeId=" .. tostring(v9.gameModeId) .. ", map=" .. v9:__wf_atom_2402a457()[1])

	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
		gMatchingService:HostSquadSession(__wf_atom_18a5d83b, v9, p2)
	else
		gMatchingService:__wf_atom_c8d901d4(v9, p2)
	end

	return true, "", false
end

function HostClanDojoLobby(p, p2, originalSessionId, p3)
	return fn22(p, p2, originalSessionId, p3)
end

function JoinClanDojoLobby(p, p2, originalSessionId, map, p3)
	print("LotusUtils::JoinClanDojoLobby")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local sessionSearch = Engine.SessionSearch()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 0
	else
		sessionSearch.matchType = 2
	end

	if originalSessionId == nil then
		sessionSearch.originalSessionId = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_5ff594a3()
	else
		sessionSearch.originalSessionId = originalSessionId
	end

	if Engine.IsPlayingWithController() then
		sessionSearch.gameModeId = module2.BuildGameModeIdForDojoDuel()
		sessionSearch.wantMap = true

		if map == nil then
			sessionSearch.map = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_84083b39()
		else
			sessionSearch.map = map
		end
	end

	if _T.gNumDojoTries == nil then
		_T.gNumDojoTries = 0
	end

	_T.gNumDojoTries = _T.gNumDojoTries + 1
	print("Num dojo tries=" .. tostring(_T.gNumDojoTries))

	if _T.gNumDojoTries == 1 then
		_T.gJoinDojoStartTime = Time()
	elseif not p3 then
		local v9 = Time() - _T.gJoinDojoStartTime
		print("Time passed " .. tostring(v9))

		if v9 > 30 then
			_T.gNumDojoTries = 10

			if p2 ~= nil then
				local v10, v11, v12 = fn22(_T.gNumDojoTries, p2, originalSessionId, map)

				if not v10 then
					return v11, v12
				end
			end

			return nil, nil
		end
	end

	print("Searching for originalSessionId (guildId)=" .. tostring(sessionSearch.originalSessionId))
	gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, p)
	return nil, nil
end

function OnFindClanDojoSessionComplete(p, p2, p3, originalSessionId, p4, p5)
	print("LotusUtils::OnFindClanDojoSessionComplete - success=" .. tostring(p))
	local __wf_atom_754c4d7d = gMatchingService:__wf_atom_754c4d7d()

	if p and not __wf_atom_7e8ad928(__wf_atom_754c4d7d) and #__wf_atom_754c4d7d ~= 0 then
		print("Available clandojo hosts:")

		for i = 1, #__wf_atom_754c4d7d do
			print("searchResults[" .. i .. "]=" .. __wf_atom_754c4d7d[i]:__wf_atom_6c164199())
		end

		local v9 = ""

		for i = 1, #__wf_atom_754c4d7d do
			local v10 = __wf_atom_754c4d7d[i]

			if v10:__wf_atom_366d49f7() == 0 then
				v9 = "/Lotus/Language/Menu/SocialOverlay_SessionFull"
			elseif gMatchingService:__wf_atom_b05c9a8f(v10:StrictNAT()) then
				if __wf_atom_c67f9605:__wf_atom_6d03a710() then
					v9 = "/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked"
				elseif __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
					v9 = "/Lotus/Language/Menu/MainMenu_BugReportMissionsBlocked"
				else
					print("joining " .. v10:__wf_atom_6c164199())
					fn18(p2, v10, nil, originalSessionId)
					return nil, nil
				end
			else
				v9 = "/Lotus/Language/Menu/SocialOverlay_SessionStrictNAT"
			end
		end

		return v9, nil
	else
		if p3 == nil or p5 then
			return "", nil
		end

		print("No clandojo hosts found -- preparing to host locally")
		local v9, v10, v11 = fn22(_T.gNumDojoTries, p3, originalSessionId, p4)

		if v9 then
			return nil, nil
		end

		return v10, v11
	end
end

function StartLobby() end

function ExitLobby()
	if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
		_T.ForegroundMovie:Execute("SetLobbyStatusMessage", "")
		_T.ForegroundMovie:Execute("EnableKeyButton", "true")
	end

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("TerminateQuickMatch", "")
	end

	_T.gSelectedRegionId = -1
end

local function fn23()
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		if __wf_atom_bb46d8b6[i].isLocal then
			return __wf_atom_bb46d8b6[i]
		end
	end

	return nil
end

function GetLocalSquadMember()
	return fn23()
end

local function fn24(p)
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		if __wf_atom_bb46d8b6[i].onlineId == p then
			return __wf_atom_bb46d8b6[i]
		end
	end

	return nil
end

function GetSquadMemberByOnlineId(p)
	return fn24(p)
end

function GetSquadMemberByName(p)
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		if __wf_atom_bb46d8b6[i].name == p then
			return __wf_atom_bb46d8b6[i]
		end
	end

	return nil
end

local function fn25(p, p2)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		return "/Language/Menu/SignInMessageBoxTitle"
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		return "/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked"
	end

	if __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
		return "/Lotus/Language/Menu/MainMenu_BugReportMissionsBlocked"
	end

	if Engine.__wf_atom_84bb79c2() then
		__wf_atom_18a5d83b:__wf_atom_b2098de3(1)

		if not __wf_atom_18a5d83b:__wf_atom_b2644498() then
			return "/Lotus/Language/Menu/GameInvitesDisabledXBone"
		end
	end

	if module2.InQuestCommitment(gGameData) and module2.IsCampLevel() then
		return "/Lotus/Language/Menu/GameInvitesDisabled"
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if __wf_atom_7e8ad928(__wf_atom_15811761) then
		if _T.gActiveMatchMakingMode == _T.MATCHMAKING_OFFLINE_GAMEMODE then
			return "/Lotus/Language/Menu/GameInvitesDisabledFrontend"
		end

		return nil
	else
		local settings = __wf_atom_15811761:GetSettings()
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if p ~= nil and p.session.id == __wf_atom_15811761:__wf_atom_855a3505() then
			return "/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame"
		end

		if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_1316e0c2) then
			if settings.regionId == 1 then
				local v9 = fn23()
				local __wf_atom_74999b9e = gMatchingService:__wf_atom_74999b9e()

				if
					__wf_atom_74999b9e ~= ""
					and (__wf_atom_7e8ad928(v9) or __wf_atom_74999b9e ~= v9.onlineId)
					and not (gMatchingService:__wf_atom_607c7363() and __wf_atom_7e8ad928(fn24(__wf_atom_74999b9e)))
				then
					return "/Lotus/Language/Menu/SocialOverlay_SessionRequiresInvite"
				end
			end
		else
			local __wf_atom_5ff594a3 = gGameRules:__wf_atom_5ff594a3()

			if __wf_atom_5ff594a3 == "" or __wf_atom_5ff594a3 ~= __wf_atom_9be88b01:__wf_atom_5ff594a3() then
				return "/Lotus/Language/Menu/SocialOverlay_GuestInviteDenied"
			end
		end

		local name = nil

		if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
			local gPendingMission = _T.gPendingMission

			if not __wf_atom_7e8ad928(gPendingMission) then
				name = gPendingMission.name
			end
		else
			local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

			if __wf_atom_72fc675e.soloMode then
				return "/Lotus/Language/Menu/GameInvitesDisabled"
			else
				name = __wf_atom_72fc675e.location
			end
		end

		if
			(name == module2.OROKIN_TOWER_NODE_TAG or name == module2.ENTRATI_LANDSCAPE_NODE_TAG)
			and not module2.HasCompletedDeimosIntroQuest()
		then
			return "/Lotus/Language/InfestedMicroplanet/DeimosHubSquadInviteDisabled"
		end

		if settings.regionId == 2 then
			return "/Lotus/Language/Menu/SocialOverlay_SessionLocked"
		end

		if __wf_atom_15811761:__wf_atom_366d49f7() == 0 then
			if gMatchingService:__wf_atom_607c7363() then
				return "/Lotus/Language/Menu/SocialOverlay_HostSessionFull"
			end

			return "/Lotus/Language/Menu/SocialOverlay_SessionFull"
		elseif
			__wf_atom_7e8ad928(_T.gPendingMission)
			or _T.gPendingMission.name ~= v
			or not (gMatchingService:__wf_atom_8b3e33a6() >= 2)
		then
			local v9 = fn23()

			if v9 ~= nil and v9.teamToJoin ~= nil and __wf_atom_15811761:__wf_atom_7dc42df1(v9.teamToJoin) == 0 then
				return "/Lotus/Language/Menu/SocialOverlay_TeamFull"
			end

			local v10 = false

			if gMatchingService:__wf_atom_a676a953() then
				local v11 = p and p.session and gMatchingService:IsPlayerInRelay(p.session.hostAccountId) and true
					or false
				v10 = p2 and gMatchingService:__wf_atom_72d1389e(p2) and true or v11
			end

			if gMatchingService:__wf_atom_a676a953() and gMatchingService:__wf_atom_fd0cb1b6() and not v10 then
				return "/Lotus/Language/SquadLink/GameInviteHubFull"
			end

			return nil
		elseif gMatchingService:__wf_atom_607c7363() then
			return "/Lotus/Language/Menu/SocialOverlay_HostSessionFull"
		else
			return "/Lotus/Language/Menu/SocialOverlay_SessionFull"
		end
	end
end

function CheckGameInvitePermission(p, p2)
	return fn25(p, p2)
end

function InviteFriends()
	if __wf_atom_7e8ad928(_T.BackgroundMovie) then
		return
	end

	local v9 = fn25(nil)

	if v9 == nil then
		return (_T.OpenScreen("InvitePanel"))
	end

	module.ShowMessage(v9)
end

function ShowInviteCommand(p)
	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if __wf_atom_7e8ad928(__wf_atom_15811761) then
		return false
	end

	return not p or p.session.id ~= __wf_atom_15811761:__wf_atom_855a3505()
end

function CheckJoinSessionPermission(p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		return "/Language/Menu/SignInMessageBoxTitle"
	end

	if Engine.__wf_atom_84bb79c2() then
		__wf_atom_18a5d83b:__wf_atom_b2098de3(1)

		if not __wf_atom_18a5d83b:__wf_atom_b2644498() then
			return "/Lotus/Language/Menu/GameJoinDisabledXBone"
		end
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		return "/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked"
	end

	if __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
		return "/Lotus/Language/Menu/MainMenu_BugReportMissionsBlocked"
	end

	if p.session.id == "" or p.state == 0 or p.state == 1 or p.state == 2 then
		return "/Lotus/Language/Menu/SocialOverlay_FriendNotInSession"
	end

	if module2.IsSortieGameModeId(p.session.gameModeId) then
		local v9 = fn2()

		if v9 ~= nil then
			return v9
		end
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) and p.session.id == __wf_atom_15811761:__wf_atom_855a3505() then
		return "/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame"
	end

	if p.session.filledSlots < 255 and p.session.filledSlots >= p.session.totalSlots and not _G.StalkerMode then
		return "/Lotus/Language/Menu/SocialOverlay_SessionFull"
	end

	if p.session.regionId == 2 then
		return "/Lotus/Language/Menu/SocialOverlay_SessionLocked"
	end

	if
		p.session.regionId == 1
		and p.session.gameModeId ~= module2.BuildGameModeIdForClanDojo()
		and p.session.gameModeId ~= module2.BuildGameModeIdForDojoDuel()
	then
		return "/Lotus/Language/Menu/SocialOverlay_SessionRequiresInvite"
	end

	if not gMatchingService:__wf_atom_b05c9a8f(p.session.strictNAT) then
		return "/Lotus/Language/Menu/SocialOverlay_SessionStrictNAT"
	end

	if __wf_atom_c67f9605:__wf_atom_172c2f5c(gRegion:__wf_atom_ade7f08f().level) then
		return "/Lotus/Language/Menu/SocialOverlay_SessionJoinFromTutorial"
	end

	if gMatchingService:__wf_atom_a676a953() then
		if not gMatchingService:IsPlayerInRelay(p.session.hostAccountId) then
			return "/Lotus/Language/SquadLink/ScenarioJoinNotAllowed"
		end
	elseif module2.IsScenarioGameModeId(p.session.gameModeId) then
		return "/Lotus/Language/SquadLink/ScenarioRequiresInvite"
	end

	if
		module2.GetNodeNameFromGameModeId(p.session.gameModeId) == tostring(module2.OROKIN_TOWER_NODE_TAG)
		and not module2.HasCompletedDeimosIntroQuest()
	then
		return "/Lotus/Language/InfestedMicroplanet/DeimosHubSquadJoinDisabled"
	end

	return nil
end

function ShowJoinSessionCommand(p)
	if p.session.id == "" or p.state == 0 or p.state == 2 then
		return false
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()
	local uiMode = module2.GetUIMode()

	if __wf_atom_7e8ad928(__wf_atom_15811761) then
		return uiMode ~= module2.UI_MODE_IN_GAME
	end

	return p.session.id ~= __wf_atom_15811761:__wf_atom_855a3505()
		and (uiMode == module2.UI_MODE_IN_SPACE_SHIP or uiMode == module2.UI_MODE_IN_SPACE_HUB or uiMode == module2.UI_MODE_IN_DOJO)
end

local function fn26()
	return not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
end

function InSession()
	return fn26()
end

function HostSquadSession(p, gameModeId, maxPlayers, originalSessionId)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()

	if gMatchingService:__wf_atom_c5171bd3() then
		__wf_atom_7611b6b4.matchType = 0
	else
		__wf_atom_7611b6b4.matchType = 2
	end

	__wf_atom_7611b6b4.minPlayers = 1

	if __wf_atom_7e8ad928(maxPlayers) then
		__wf_atom_7611b6b4.maxPlayers = 4
	else
		__wf_atom_7611b6b4.maxPlayers = maxPlayers
	end

	if __wf_atom_7611b6b4.maxPlayers > 4 then
		__wf_atom_7611b6b4.maxPlayers = 4
	end

	if gGameRules:__wf_atom_9020da04() then
		__wf_atom_7611b6b4.regionId = 2
	else
		__wf_atom_7611b6b4.regionId = module.Ternary(
			_T.gActiveMatchMakingMode == _T.MATCHMAKING_INVITE_ONLY_GAMEMODE,
			1,
			3
		)
	end

	if __wf_atom_7e8ad928(gameModeId) then
		__wf_atom_7611b6b4.gameModeId = module.Ternary(
			module2.GetUIMode() == module2.UI_MODE_IN_DOJO,
			module2.BuildGameModeIdForClanDojo(),
			0
		)
	else
		print("hosting squad session with gameModeIdOverride" .. tostring(gameModeId))
		__wf_atom_7611b6b4.gameModeId = gameModeId
	end

	if originalSessionId == nil then
		__wf_atom_7611b6b4.originalSessionId = ""
	else
		__wf_atom_7611b6b4.originalSessionId = originalSessionId
	end

	__wf_atom_7611b6b4:__wf_atom_c2db5000()
	__wf_atom_7611b6b4.eloRating = module2.GetPlayerEloRating()
	gMatchingService:HostSquadSession(__wf_atom_18a5d83b, __wf_atom_7611b6b4, p)
end

function GetMissionInfoForKey(p)
	local v9 = Resource(p)
	local v10

	if not __wf_atom_7e8ad928(v9) then
		v10 = v9:__wf_atom_72fc675e()
		v10.levelKeyName = WeakResource(p)
	end

	return v10
end

function InSquad()
	return gMatchingService:__wf_atom_8b3e33a6() >= 1
end

function CheckInvitation(data, p)
	if not (data.playerName and data.accountId and data.session.id) then
		return "/Lotus/Language/Menu/SocialOverlay_SessionExpired"
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		return "/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked"
	end

	if __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
		return "/Lotus/Language/Menu/MainMenu_BugReportMissionsBlocked"
	end

	if not gMatchingService:__wf_atom_b05c9a8f(data.session.strictNAT) then
		return "/Lotus/Language/Menu/SocialOverlay_SessionStrictNAT"
	end

	if fn26() and data.session.id == gMatchingService:__wf_atom_15811761():__wf_atom_855a3505() then
		return "/Lotus/Language/Menu/SocialOverlay_AlreadyInGame"
	end

	if _T.LockedGoalList then
		local name

		if data.session.gameModeId == 0 and p then
			name = p.name

			if name then
				local v9 = string.find(name, module2.TAG_SEPERATOR)

				if v9 ~= nil then
					name = string.sub(name, 1, v9 - 1)
				end
			end
		else
			name = module2.GetNodeNameFromGameModeId(data.session.gameModeId)
		end

		if _T.LockedGoalList[name] then
			return "/Lotus/Language/Menu/SocialOverlay_EventMissionLocked"
		end
	end

	if p ~= nil and p.sortieId ~= nil and p.sortieId ~= "" then
		local v9 = fn2()

		if v9 ~= nil then
			return v9
		end
	end

	return nil
end

local function fn27(object)
	local __wf_atom_2402a457 = object:GetSettings():__wf_atom_2402a457()

	if
		not __wf_atom_7e8ad928(__wf_atom_2402a457)
		and #__wf_atom_2402a457 > 0
		and string.find(__wf_atom_2402a457[1], "/Keys/")
		and not string.find(__wf_atom_2402a457[1], "DojoKey")
	then
		local v9 = Resource(__wf_atom_2402a457[1])

		if not __wf_atom_7e8ad928(v9) then
			return tostring(v9:__wf_atom_5b41f63b()) .. module2.KEY_TAG
		end
	end
end

function CheckSingleSessionResults(p, p2, p3, p4, object, p5, p6, p7, p8)
	local __wf_atom_754c4d7d = gMatchingService:__wf_atom_754c4d7d()

	if p and p ~= "false" and #__wf_atom_754c4d7d ~= 0 then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			return "/Language/Menu/SignInMessageBoxTitle"
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		local v9 = __wf_atom_754c4d7d[1]
		local gameModeId = v9:GetSettings().gameModeId

		if v9:__wf_atom_366d49f7() == 0 and not _G.StalkerMode then
			return "/Lotus/Language/Menu/SocialOverlay_SessionFull"
		end

		if p3 ~= nil and p3 ~= 255 and v9:__wf_atom_7dc42df1(p3) == 0 then
			return "/Lotus/Language/Menu/SocialOverlay_TeamFull"
		end

		if v9:GetSettings().regionId == 2 and not p4 then
			return "/Lotus/Language/Menu/SocialOverlay_SessionLocked"
		end

		if module2.IsSessionExpired(v9) then
			return "/Lotus/Language/Menu/SocialOverlay_SessionExpired"
		end

		if __wf_atom_c67f9605:__wf_atom_6d03a710() then
			return "/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked"
		end

		if __wf_atom_c67f9605:__wf_atom_dd8bc9ed() then
			return "/Lotus/Language/Menu/MainMenu_BugReportMissionsBlocked"
		end

		if not gMatchingService:__wf_atom_b05c9a8f(v9:StrictNAT()) then
			return "/Lotus/Language/Menu/SocialOverlay_SessionStrictNAT"
		end

		if gameModeId == module2.BuildGameModeIdForClanDojo() or gameModeId == module2.BuildGameModeIdForDojoDuel() then
			if not __wf_atom_18a5d83b:__wf_atom_563ea37f() then
				return "/Lotus/Language/Menu/KubrowLocked_Busy"
			end

			local originalSessionId = v9:GetSettings().originalSessionId

			if originalSessionId == "" or originalSessionId ~= __wf_atom_9be88b01:__wf_atom_5ff594a3() then
				if not p2 then
					return "/Lotus/Language/Menu/SocialOverlay_SessionRequiresInvite"
				end
			elseif not __wf_atom_9be88b01:__wf_atom_503b306e() then
				return "/Lotus/Language/Menu/SocialOverlay_DojoKeyRequired"
			end
		end

		if module2.IsJunctionGameModeId(gameModeId) then
			return "/Lotus/Language/Menu/ServerIsFull"
		end

		if v9:GetSettings().regionId == 1 and not (p2 or p4) then
			return "/Lotus/Language/Menu/SocialOverlay_SessionRequiresInvite"
		end

		local starChart = module2.GetStarChart()
		local nodeName = module2.GetNodeNameFromGameModeId(gameModeId)

		if nodeName then
			if module2.IsHubGameModeId(gameModeId) and gGameRules:IsA(__wf_atom_e714d8ac) then
				if
					(gGameRules:__wf_atom_af3bd666() and nodeName == "TradeHUB1" or not gGameRules:__wf_atom_af3bd666() and nodeName ~= "TradeHUB1")
					and tostring(gGameRules:__wf_atom_72fc675e().location) ~= nodeName
				then
					if gMatchingService:__wf_atom_a676a953() then
						if not gMatchingService:IsPlayerInRelay(v9:__wf_atom_25c47a58()) then
							return "/Lotus/Language/SquadLink/ScenarioJoinNotAllowed"
						end
					elseif module2.IsScenarioGameModeId(gameModeId) then
						return "/Lotus/Language/SquadLink/ScenarioRequiresInvite"
					else
						return "/Lotus/Language/Menu/JoinFail_RelayFromRelay"
					end
				end

				if
					nodeName == tostring(module2.OROKIN_TOWER_NODE_TAG)
					and not module2.HasCompletedDeimosIntroQuest()
				then
					return "/Lotus/Language/InfestedMicroplanet/DeimosHubSquadJoinDisabled"
				end
			end

			local nodeModifierTag = module2.GetNodeModifierTagFromGameModeId(gameModeId)

			if
				(nodeModifierTag == module2.ACTIVE_MISSION_TAG or nodeModifierTag == module2.VOID_STORM_TAG)
				and not p6
			then
				if _T.MadeProjectionChoice then
					_T.MadeProjectionChoice = false
				else
					local v10 = object:PushChildMovie(v2)

					if not __wf_atom_7e8ad928(v10) then
						_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
						local voidT1 = module2.VOID_PROJECTION_ITEMS.VoidT1

						if #v9:GetSettings():__wf_atom_2402a457() > 0 then
							local v11 = v9:GetSettings():__wf_atom_2402a457()[1]

							if module2.VOID_PROJECTION_ITEMS[v11] then
								voidT1 = module2.VOID_PROJECTION_ITEMS[v11]
							end
						else
							local mActiveMissions = __wf_atom_9be88b01:__wf_atom_92662866().mActiveMissions

							for i = 1, #mActiveMissions do
								if tostring(mActiveMissions[i].mNode) ~= nodeName then
									continue
								end

								local mModifier = tostring(mActiveMissions[i].mModifier)

								if not module2.VOID_PROJECTION_ITEMS[mModifier] then
									break
								end

								voidT1 = module2.VOID_PROJECTION_ITEMS[mModifier]
								break
							end
						end

						v10:__wf_atom_f62a8704("SetExclusiveTier", { voidT1:__wf_atom_5b41f63b(), p5 })
						Sleep(0)
					end
				end
			end

			if not p7 then
				local v10

				if not __wf_atom_7e8ad928(starChart) then
					v10 = starChart:BuildMissionForLocation(Symbol(nodeName))
				end

				if
					not __wf_atom_7e8ad928(v10)
					and v10.missionType == 22
					and v10.faction == 1
					and not _T.MadeWagerChoice
				then
					local v11 = object:PushChildMovie(v3)

					if not __wf_atom_7e8ad928(v11) then
						_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
						nodeName = fn27(v9) or nodeName
						v11:__wf_atom_f62a8704("SetSectorNameAndCloseCallback", { nodeName, p5, (tostring(p8)) })
						Sleep(0)
					end
				end
			end

			nodeName ..= nodeModifierTag
		end

		local v10 = fn27(v9) or nodeName
		local v11 = v10 and module3.CheckConclaveRequirements(v10, p2)

		if v11 then
			if __wf_atom_7e8ad928(_T.BackgroundMovie) then
				return v11.text, v11
			end

			return _T.BackgroundMovie:__wf_atom_8e9ac384(v11.text, false, {
				PLAYER_NAME = v11.player,
				VALUE = v11.value,
				MIN = v11.MIN,
				MAX = v11.MAX,
				ITEM = v11.ITEM
			}), v11
		else
			if _T.LockedGoalList and _T.LockedGoalList[v10] then
				return "/Lotus/Language/Menu/SocialOverlay_EventMissionLocked"
			end

			if module2.IsPvpGameModeId(gameModeId) and __wf_atom_72884638("Multiplayer.RankedPVP") then
				local eloRating = v9:GetSettings().eloRating

				if (SF.__wf_atom_cdc5dc42(__wf_atom_18a5d83b) and 0 or 2) - eloRating >= 2 then
					return "/Lotus/Language/Menu/SocialOverlay_PVP_RankTooHigh"
				end
			end

			if
				_G.StalkerMode
				and (not v9:GetSettings().hasStarted or module2.IsPvpGameModeId(gameModeId) or module2.IsHubGameModeId(gameModeId) or module2.IsClanDojoGameModeId(gameModeId) or module2.IsDojoDuelGameModeId(gameModeId) or module2.IsSimulacrumGameModeId(gameModeId) or module2.IsPhotoboothGameModeId(gameModeId))
			then
				return "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
			end

			if
				gMatchingService:__wf_atom_a676a953()
				and not gMatchingService:IsPlayerInRelay(v9:__wf_atom_25c47a58())
			then
				return "/Lotus/Language/SquadLink/ScenarioJoinNotAllowed"
			end

			if v10 == tostring(module2.OROKIN_TOWER_NODE_TAG) and not module2.HasCompletedDeimosIntroQuest() then
				return "/Lotus/Language/InfestedMicroplanet/DeimosHubSquadJoinDisabled"
			end

			return v9
		end
	else
		if p ~= "false" then
			local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
			return __wf_atom_91952c92 == "" and "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
				or __wf_atom_91952c92
		end

		_T.MadeProjectionChoice = false
		_T.MadeWagerChoice = false
		return ""
	end
end

function ResetSquadMission(p)
	print("ResetSquadMission")

	if not p then
		local decoded = cjson.decode(gMatchingService:__wf_atom_8b0475eb())

		if
			decoded ~= nil
			and decoded.jobLevelGenerationSeed ~= nil
			and module2.GetUIMode() == module2.UI_MODE_IN_GAME
		then
			local v9 = { jobLevelGenerationSeed = decoded.jobLevelGenerationSeed }
			gMatchingService:SendSquadMission(cjson.encode(v9))
			return
		end
	end

	gMatchingService:SendSquadMission("")
end

function GetSquadMissionForInvite()
	local encoded = gMatchingService:__wf_atom_8b0475eb()
	local uiMode = module2.GetUIMode()

	if encoded ~= "" and cjson.decode(encoded).name ~= nil or __wf_atom_7e8ad928(gGameRules) then
		return encoded
	end

	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
	local location

	if uiMode == module2.UI_MODE_IN_SPACE_HUB or uiMode == module2.UI_MODE_IN_DOJO then
		if string.len((tostring(__wf_atom_72fc675e.location))) > 0 then
			location = tostring(__wf_atom_72fc675e.location) .. module2.HUB_TAG
		else
			location = gMatchingService:__wf_atom_5529af13() .. module2.HUB_TAG
		end
	else
		location = ""
	end

	if uiMode == module2.UI_MODE_IN_GAME then
		location = tostring(__wf_atom_72fc675e.location)
	end

	encoded = cjson.encode({ name = location, missionType = 28, quest = "", difficulty = "" })
	return encoded
end

fn2 = function()
	if module2.IsOverOmegaLimit() then
		return "/Lotus/Language/Menu/OmegaLimit_RestrictSortie"
	end

	return nil
end

function ConnectToScenarioRelay(p, hubChannel, p2)
	local v9 = Symbol(p)
	gGameRules:__wf_atom_efb96bf3(v9, hubChannel, p2)
	local v10 = fn17(v9, (module2.GetStarChart():BuildMissionForLocation(v9)))
	v10.loadToLobby = true
	v10.isLobby = true
	v10.isAutonomous = true
	gGameData:__wf_atom_a1dd9b66(v10, p .. module2.HUB_TAG)

	if not gGameRules:IsA(__wf_atom_e714d8ac) then
		_T.HubChannel = hubChannel
	end
end