local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
require("Lotus.Interface.LotusUtilities")
local module4 = require("SF.Scripts.NightFoldLib")
require("EE.Interface.Utilities")
require("SF.Interface.SFUtilities")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("SF.Scripts.Libs.TransmissionSet")
local module7 = require("Lotus.Scripts.Libs.AudioLib")
local module8 = require("SF.Scripts.Libs.SparrowLib")
local module9 = require("SF.Scripts.Libs.TaleLib")
require("SF.Scripts.Libs.CodexLib")
local module10 = require("SF.Scripts.Libs.ChallengeLib")
local v = nil
local v2 = Symbol("PolluterCritterSpawnWp")
local entities = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = Symbol("OdeOrganHatch")
local v8 = Symbol("OdeOrganHatchDoor")
local v9 = Symbol("PolluterHatchDestructionFx")
local v10 = Symbol("PolluterResetFluidPortForwarder")
local v11 = {
	"/SF/Language/Progression/PolluterTowerObjectiveRescueCritters",
	"/SF/Language/Progression/PolluterTowerObjectiveKillMiniboss",
	"/SF/Language/Progression/PolluterTowerObjectiveOpenBomb"
}
local aiDir = nil
local v12 = {}
local abandonTime2 = 0
local flag = false
local v13 = {
	Started = 0,
	TowerAlerted = 1,
	DoorsOpened = 3,
	OuterDoorsOpened = 4,
	PowerOff = 5
}
local started = 0
local v14 = nil
local v15 = nil
local towerAlerted = nil
local encounterTemplate = nil
local position = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local crittersFreed = 0
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = Symbol()
WeakResource("/SF/Types/Player/EnvoyAvatar")
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = nil
local flag2 = false
local reinforcementSpawnDelaytime2 = 0
local v30 = false
local v31 = nil
local v32 = nil
local v35 = {}
local flag3 = false
local v36 = Symbol("OrganMinigameEnded")

local function fn(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local position2

	if module2.IsInNightFold(object) then
		position2 = object:__wf_atom_4c2e0189()
	else
		position2 = object:GetPosition()
	end

	if __wf_atom_7e8ad928(position2) or not (Distance(v14:GetPosition(), position2) < abandonDistance) then
		return false
	end

	return true
end

local function fn2()
	if #v12 == 0 then
		return true
	end

	for _, v37 in ipairs(v12) do
		if __wf_atom_7e8ad928(v37) or v37:IsKilled() or v37:IsA(__wf_atom_9d7477c0) or fn(v37) then
			return true
		end
	end

	return false
end

local function fn3(p)
	local regionId = module2.GetRegionIdFromDensityVolume(v14:GetPosition())
	local jobBoardsInRegion = module9.GetJobBoardsInRegion(regionId)
	local v37 = "Tower" .. tostring(v25)

	if not p then
		module9.RemoveFromAllJobBoards(v37)
		return
	end

	local v38 = nil

	local function fn4(object)
		if __wf_atom_7e8ad928(v38) then
			v38 = gRegion:CreateEntity(towerMarkerType, v14:GetPosition(), __wf_atom_80368bb1)
			object:SetMarker(v38)
			object:SetEnemyLevel(v14)
		end

		return v38
	end

	module9.AddToJobBoards(
		v37,
		jobBoardsInRegion,
		"/SF/Language/Progression/PolluterTowerStartedB",
		"/SF/Language/Objectives/OrganLongDesc",
		towerMarkerType,
		fn4
	)
end

local function fn4()
	v35 = v14:__wf_atom_fe00d825() or {}

	for i = #v35, 1, -1 do
		if __wf_atom_7e8ad928(v35[i]) then
			table.remove(v35, i)
		end
	end

	if #v35 >= 1 then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("PolluterChestWP"), position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		local lootContainer = module.SpawnLootContainer(
			chestType,
			nearestTagged:GetPosition(),
			nearestTagged:__wf_atom_dc309f8a(),
			true,
			v14
		)
		v14:__wf_atom_d494454b(lootContainer)
	end
end

local function fn5()
	print("Attempting to spawn critters")

	if __wf_atom_7e8ad928(position) then
		print("Error spawning critters: mHintPos is null")
		return
	end

	v4 = gRegion:__wf_atom_439c0d29(v7, position, 0, 50)
	v5 = gRegion:__wf_atom_439c0d29(v8, position, 0, 50)
	local v37 = math.random(critterCount)
	local count = 0

	for i = 1, #v4 do
		local v38 = v4[i]
		local v39 = v38:GetPosition() + __wf_atom_9341614d(
			Vector(0, 0, critterSpawnPointScanDistance),
			v38:__wf_atom_dc309f8a()
		)

		if debugCritterSpawns then
			gRegion:__wf_atom_8d991675(v39, 0.1, Color(255, 0, 0), 60)
			gRegion:__wf_atom_b5c21154(v39, critterSpawnPointScanRadius, Color(0, 0, 255), Rotation(0, 90, 0), 60)
		end

		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v2, v39, 0, critterSpawnPointScanRadius)

		if __wf_atom_7e8ad928(__wf_atom_439c0d29) or #__wf_atom_439c0d29 == 0 then
			__wf_atom_439c0d29 = { gRegion:FindNearestTagged(v2, v39) }

			if __wf_atom_7e8ad928(__wf_atom_439c0d29) or #__wf_atom_439c0d29 == 0 then
				print("Error: Could not find valid spawn waypoint for hatch: " .. v38:__wf_atom_5b41f63b())
			else
				print("Scan failed to find spawn waypoint for hatch: " .. v38:__wf_atom_5b41f63b() .. ", using closest waypoint")
			end
		end

		local v40 = __wf_atom_439c0d29[math.random(#__wf_atom_439c0d29)]
		local corruptionStuckBeaverDuckType = corruptionStuckBeaverDuckType

		if i == v37 then
			corruptionStuckBeaverDuckType = corruptionStuckBeaverType
		end

		local entity = gRegion:CreateEntity(
			corruptionStuckBeaverDuckType,
			v40:GetPosition(),
			v40:__wf_atom_dc309f8a(),
			nil,
			nil,
			1
		)

		if __wf_atom_7e8ad928(entity) then
			print("Error when spawning critter deco on waypoint: " .. v40:__wf_atom_5b41f63b())
		else
			count += 1
			table.insert(entities, entity)
			table.insert(v3, v40)
			v40:__wf_atom_b811702e(Symbol())
			print("Successful critter spawn " .. count .. " on waypoint " .. v40:__wf_atom_5b41f63b() .. ", type: " .. corruptionStuckBeaverDuckType:__wf_atom_5b41f63b())

			if debugCritterSpawns then
				gRegion:__wf_atom_8d991675(v40:GetPosition(), 1, Color(0, 0, 255), 10)
			end
		end
	end

	if critterCount <= count then
		print("Successfully spawned " .. count .. " critter decos")
	else
		print("Error: Critter spawn failed. Spawned " .. count .. " critter decos")
	end
end

function DissolveAndDestroy(object)
	local v37 = 0

	while v37 < 1 do
		v37 = __wf_atom_421b01aa(v37 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v37)
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

local function fn6()
	local flag4 = true

	while flag4 do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		flag4 = false

		for _, v38 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v38) or not (v38:__wf_atom_a5304c35(position) < 100) then
				continue
			end

			flag4 = true
			break
		end

		Sleep(1)
	end

	print("Cleaning up critter decos")

	for i = 1, #entities do
		if not __wf_atom_7e8ad928(entities[i]) then
			entities[i]:__wf_atom_8a035cd5(Symbol("DissolveAndDestroy"), false)
		end
	end

	for i = 1, #v3 do
		if not __wf_atom_7e8ad928(v3[i]) then
			v3[i]:__wf_atom_b811702e(v2)
		end
	end

	for i = 1, #v4 do
		if not __wf_atom_7e8ad928(v4[i]) then
			v4[i]:__wf_atom_b811702e(v7)
		end
	end

	for i = 1, #v5 do
		if __wf_atom_7e8ad928(v5[i]) then
			continue
		end

		v5[i]:__wf_atom_b811702e(v8)
		v5[i]:FirePort("Close")
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v9, position, 0, 50)

	for i = 1, #__wf_atom_439c0d29 do
		if not __wf_atom_7e8ad928(__wf_atom_439c0d29[i]) then
			__wf_atom_439c0d29[i]:Destroy()
		end
	end

	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(v10, position, 0, 50)

	for _, v37 in ipairs(__wf_atom_439c0d29_2) do
		if not __wf_atom_7e8ad928(v37) then
			v37:FirePort("TriggerPort")
		end
	end

	entities = {}
	_T.OrganBeaversFreed = 0
	_T.VentsOpened = 0
	_T.CrittersFreed = 0
	crittersFreed = 0
	v6 = {}
end

function Reinforcements(_, _) end

local function fn7()
	_T.PolluterTowerAlerted = true
	local __wf_atom_e529dedd = v14:__wf_atom_e529dedd()

	for _, v37 in ipairs(__wf_atom_e529dedd) do
		module.SetEncounterAlerted(v37, true)
	end

	module.AlertEnemies(v14, true)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v37 in pairs(__wf_atom_ef7900cf) do
		v37:Attach(alertPerceptionHint, Symbol("GAME_C1_ROOT"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn8()
	_T.PolluterTowerOpened = nil
	local position2 = gRegion:__wf_atom_c4f78a8f():GetPosition()
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusic"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganDucking"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicInterior"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicBalcony"), false, position2)

	if not __wf_atom_7e8ad928(dropTable) then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
		local enemyLevel = module.GetEnemyLevel(v14)
		local v37 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

		for _, v38 in pairs(__wf_atom_3c8e1a7a) do
			local playerAvatar = v38:GetPlayerAvatar(0)

			if __wf_atom_7e8ad928(playerAvatar) or not (playerAvatar:__wf_atom_1c8f7b2d(v14) <= 200) then
				continue
			end

			local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

			if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				continue
			end

			if __wf_atom_d2b2176d:__wf_atom_705a2744(lore, Symbol("/SF/Language/Lore/TheOrganMemory1")) then
				if __wf_atom_d2b2176d:__wf_atom_705a2744(lore, Symbol("/SF/Language/Lore/TheOrganMemory2")) then
					if __wf_atom_d2b2176d:__wf_atom_705a2744(lore, Symbol("/SF/Language/Lore/TheOrganMemory3")) then
						v19 = nil
					else
						v19 = Symbol("/SF/Language/Lore/TheOrganMemory3")
					end
				else
					v19 = Symbol("/SF/Language/Lore/TheOrganMemory2")
				end
			else
				v19 = Symbol("/SF/Language/Lore/TheOrganMemory1")
			end

			if not __wf_atom_7e8ad928(v19) then
				module2.GiveLoreFragmentMemory(playerAvatar, lore, v19)
			end

			dropTable:__wf_atom_0ad20b11(playerAvatar, v14, __wf_atom_e93896ba, v37)
		end
	end

	gGameData:__wf_atom_a975522c(v25, 3600 * towerResetHours, true, "")
	Sleep(sparrowCelebrationDelay)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		or __wf_atom_c4f78a8f ~= gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
		or module4.IsNightfoldBlockedById(1)
	then
		print("Player on zipline, no celebration")
		return
	end

	print("Player not on zipline so enabling celebration")
	__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PlayerProgressCelebration"), false)
end

function PlayerProgressCelebration(_)
	local v37 = {}

	for _, v38 in ipairs(v12) do
		if __wf_atom_7e8ad928(v38) then
			continue
		end

		local __wf_atom_a96eb2aa = v38:__wf_atom_a96eb2aa()

		if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
			gGameRules:__wf_atom_8085277a(
				__wf_atom_a96eb2aa,
				"/SF/Language/Progression/PolluterTowerCompleted",
				1,
				Symbol("Default"),
				cjson.encode(v37)
			)
		end
	end
end

local function fn9()
	if not flag3 then
		return
	end

	if _T.PolluterTowerAlerted then
		_T.EncounterAlerted = true

		if not __wf_atom_7e8ad928(v27) then
			v27:FirePort("TriggerPort")
		end

		if not v30 then
			module6.PlayGlobalTransmission(transmissionSet, Symbol("FirstKill"), true)
			v30 = true
			v20 = gRegion:CreateEntity(teslaAttackType, position, __wf_atom_80368bb1)
		end
	end
end

local function fn10(p)
	local c_str = v25:c_str()

	if p == -1 then
		gGameRules:__wf_atom_4ca02fbf(c_str)
		module9.EnableEncounterMarker(v14, false, true)
		module3.UntrackEntry(c_str, 4)
	else
		module9.EnableEncounterMarker(v14, true, true)
		local mNodes = { Localize(v11[p], false) }

		for _ = p + 1, #v11 do
			table.insert(mNodes, "???")
		end

		local journalEntry = SF.JournalEntry(4, c_str)
		journalEntry.mEntity = v14
		journalEntry.mNodes = mNodes
		journalEntry.mName = "/SF/Language/Progression/PolluterTowerStartedB"
		journalEntry.mDesc = "/SF/Language/Objectives/OrganLongDesc"
		module3.TrackEntry(c_str, 4, true)
		gGameRules:__wf_atom_d032ba30(journalEntry)
	end
end

function IntroStinger(_, _, _)
	Sleep(introStingerDelay)

	if not __wf_atom_7e8ad928(notificationMovie) then
		for _, v37 in ipairs(v12) do
			if __wf_atom_7e8ad928(v37) then
				continue
			end

			local __wf_atom_a96eb2aa = v37:__wf_atom_a96eb2aa()

			if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				gGameRules:__wf_atom_6680e8ba(
					__wf_atom_a96eb2aa,
					notificationMovie,
					"PolluterStart",
					{ polluterNotificationLoc:c_str(), (tostring(8)) },
					8,
					"PolluterStart",
					true
				)
			end
		end

		local position2 = gRegion:__wf_atom_c4f78a8f():GetPosition()
		module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusic"), true, position2)
		module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganDucking"), true, position2)
		module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicInterior"), true, position2)
		module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicBalcony"), true, position2)
		module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerActivate"), true, position2)
		Sleep(2)
		module6.PlayGlobalTransmission(transmissionSet, Symbol("ActivateOrgan"), true)
		module5.AddHudTask(
			v14,
			v25:c_str(),
			v25:c_str(),
			"/SF/Language/Progression/PolluterTowerObjectiveRescueCritters"
		)
		fn10(1)
	end
end

local function fn11()
	if not module2.IsInOverworld() then
		return
	end

	for _, v37 in pairs(reinforcementEncounterTypes) do
		aiDir:AddEncounter(v37)
	end

	v29 = module.CreateReinforcementMgr(aiDir, v14)
	v29.mActivationStyle = module.AS_SPECIFIC_ENCOUNTER_TYPE
	v29.mActivationPosStyle = module.APS_SPECIFIC_POS
	v29.mSpecificEncounterTypes = reinforcementEncounterTypes
	v29.mIncludeChildHints = true
	v29.mActivationPos = position

	function v29.ShouldReinforce(data, _)
		if data.mReinforceDelay < data.mTimeSinceLastReinforcement and data.mNumAgents <= 2 and not flag2 then
			flag2 = true
		end

		if flag2 and reinforcementSpawnDelaytime2 <= 0 then
			flag2 = false
			reinforcementSpawnDelaytime2 = reinforcementSpawnDelaytime
			return true
		else
			return false
		end
	end
end

local function fn12()
	v18 = position
	local v37 = false
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local position2

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		position2 = position
	else
		position2 = __wf_atom_c4f78a8f:GetPosition()
	end

	while not (_T.ShutdownTower or module.ShouldShutDown(v14)) do
		local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
			position2 = __wf_atom_c4f78a8f2:GetPosition()
		end

		v12 = gRegion:__wf_atom_ef7900cf()

		if fn2() then
			if flag then
				gGameRules:__wf_atom_008b0b38(false, 0, "/SF/Language/Progression/PolluterTowerFailTimer")
				flag = false
				MusicShutdown()
			end
		else
			if flag then
				abandonTime2 -= __wf_atom_03df4e1d()

				if abandonTime2 <= 0 then
					gGameRules:__wf_atom_008b0b38(false, 0, "/SF/Language/Progression/PolluterTowerFailTimer")
					flag = false
					MusicShutdown()
					v14:__wf_atom_8e6fec76(6)
					break
				end
			else
				abandonTime2 = abandonTime
			end

			flag = true

			if flag3 then
				local v38 = abandonTime2
				gGameRules:__wf_atom_008b0b38(true, math.ceil(v38), "/SF/Language/Progression/PolluterTowerFailTimer")
				flag = true
				MusicShutdown()
			end
		end

		if towerAlerted == v13.Started then
			fn9()

			if (_T.OrganBeaversFreed >= 1 or _T.VentsOpened >= 1) and not flag3 then
				v14:__wf_atom_8a035cd5(Symbol("IntroStinger"), false)
				flag3 = true

				for i, v38 in ipairs(entities) do
					module8.AddSimpleDestination(
						v38,
						"OrganCritter" .. i,
						module8.PRIORITY.TALE,
						Range(0, 3.4028234663852886e38)
					)
				end

				module8.RemoveSparrowDestination(v14)
			end

			if
				not __wf_atom_7e8ad928(_T.CrittersFreed)
				and _T.CrittersFreed <= 3
				and _T.CrittersFreed ~= crittersFreed
			then
				_T.PolluterTowerAlerted = true
				crittersFreed = _T.CrittersFreed
				module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerFirstVent"), true, position2)
				module6.PlayGlobalTransmission(transmissionSet, Symbol("FirstVent"), false)
			end

			if __wf_atom_7e8ad928(_T.CrittersFreed) or not (_T.CrittersFreed >= 4) then
				local v38 = __wf_atom_084b3e93()

				if flag2 then
					reinforcementSpawnDelaytime2 -= v38
				end

				if not __wf_atom_7e8ad928(v29) then
					v29:Update(v38)
				end
			else
				_T.EncounterAlerted = false
				module8.AddSparrowDestination(
					v14,
					v14,
					nil,
					module8.PRIORITY.TALE,
					Range(v14:__wf_atom_103377cc(), 3.4028234663852886e38),
					nil,
					nil,
					nil,
					true,
					true
				)
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

				for _, v38 in pairs(__wf_atom_ef7900cf) do
					v38:__wf_atom_0650fed7(alertPerceptionHint)
				end

				local miniBossEncounter = miniBossEncounter

				if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(miniBossEncounter)) then
					print("Activating guard encounter for pollution tower")
					aiDir:AddEncounter(miniBossEncounter)
					v17 = aiDir:__wf_atom_c4c644af(position, miniBossEncounter, v14)
				end

				module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerAllVent"), true, position2)
				print("Swapping to doors opened state")
				module6.PlayGlobalTransmission(transmissionSet, Symbol("OpenAllVents"), true)

				if not __wf_atom_7e8ad928(v22) then
					v22:FirePort("TriggerPort")
				end

				Sleep(0.5)
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OdeOrganBoss"))
				local nearestTagged = gRegion:FindNearestTagged(Symbol("OdeOrganMainDoorPatrolRoute"), position)

				if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(nearestTagged)) then
					local __wf_atom_30e3d82b = __wf_atom_0a6a5887:__wf_atom_30e3d82b()

					if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
						__wf_atom_30e3d82b:SetPatrolRoute(nearestTagged)
					end
				end

				module5.AddHudTask(
					v14,
					v25:c_str(),
					v25:c_str(),
					"/SF/Language/Progression/PolluterTowerObjectiveKillMiniboss"
				)
				fn10(2)
				module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerBanneret"), true, position2)
				towerAlerted = v13.TowerAlerted
			end
		elseif towerAlerted == v13.TowerAlerted then
			fn9()

			if _T.PolluterBossKilled then
				module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerAllArtery"), true, position2)
				module6.PlayGlobalTransmission(transmissionSet, Symbol("FirstArtery"), false)
				v31:Enable()
				v32:Enable()

				if not __wf_atom_7e8ad928(v23) then
					v23:FirePort("TriggerPort")
				end

				module5.AddHudTask(
					v14,
					v25:c_str(),
					v25:c_str(),
					"/SF/Language/Progression/PolluterTowerObjectiveOpenBomb"
				)
				fn10(3)
				local upperTowerEncounter = upperTowerEncounter

				if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(upperTowerEncounter)) then
					print("Activating guard encounter for pollution tower")
					aiDir:AddEncounter(upperTowerEncounter)
					v17 = aiDir:__wf_atom_c4c644af(position, upperTowerEncounter, v14)
				end

				if not __wf_atom_7e8ad928(v21) then
					v21:Enable()
				end

				towerAlerted = v13.DoorsOpened
			end
		elseif towerAlerted == v13.DoorsOpened then
			if not __wf_atom_7e8ad928(v20) then
				v20:Destroy()
			end

			if _T.OrganMinigameEnded then
				towerAlerted = v13.OuterDoorsOpened
				_T.PolluterBombExploded = true
			elseif _T.OrganMinigameStarted then
				if not v37 then
					v37 = true

					for _, v38 in pairs(organReinforcementEncounterTypes) do
						aiDir:AddEncounter(v38)
					end

					v29.mSpecificEncounterTypes = organReinforcementEncounterTypes
					reinforcementSpawnDelaytime = organReinforcementSpawnDelayTime
					reinforcementSpawnDelaytime2 = 0
					flag2 = true
					local nearestTagged = gRegion:FindNearestTagged(Symbol("OrganTeleportTrigger"), v14:GetPosition())

					if not __wf_atom_7e8ad928(nearestTagged) then
						nearestTagged:Enable()
					end
				end

				local v38 = __wf_atom_084b3e93()

				if flag2 then
					reinforcementSpawnDelaytime2 -= v38
				end

				if not __wf_atom_7e8ad928(v29) then
					v29:Update(v38)
				end
			end
		elseif towerAlerted == v13.OuterDoorsOpened then
			if _T.PolluterBombExploded then
				local __wf_atom_c4f78a8f3 = gRegion:__wf_atom_c4f78a8f()

				if __wf_atom_7e8ad928(__wf_atom_c4f78a8f3) then
					position2 = position
				else
					position2 = __wf_atom_c4f78a8f3:GetPosition()
				end

				module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerShutdown"), true, position2)
				MusicShutdown()
				module6.PlayGlobalTransmission(transmissionSet, Symbol("MissionSuccess"), true)
				towerAlerted = v13.PowerOff
			end
		elseif towerAlerted == v13.PowerOff then
			module5.CompleteHudTask(v14, v25:c_str(), v25:c_str())
			fn10(-1)
			local nearestTagged = gRegion:FindNearestTagged(Symbol("PolluterTowerFinalPort"), position)

			if not __wf_atom_7e8ad928(nearestTagged) then
				nearestTagged:FirePort("TriggerPort")
			end

			print("Ending pollution tower encounter")
			fn3(false)
			_T.ShutdownTower = true
			v14:__wf_atom_8e6fec76(6)
		end

		Sleep(0)
	end

	if module.ShouldShutDown(v14) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v38 in pairs(__wf_atom_ef7900cf) do
			v38:__wf_atom_0650fed7(alertPerceptionHint)
		end

		if _T.ShutdownTower then
			fn8()
			module10.NotifyTagAllPlayers(Symbol("POLLUTION_TOWER_SUCCESS"))
		else
			module6.PlayGlobalTransmission(transmissionSet, Symbol("MissionFailed"), false)
			module10.NotifyTagAllPlayers(Symbol("POLLUTION_TOWER_FAILURE"))
		end

		if not __wf_atom_7e8ad928(v20) then
			v20:Destroy()
		end

		module4.RegisterPreventNighfoldUsage(false)
		_T.PolluterTowerAlerted = false
		_T.EncounterAlerted = false
		local __wf_atom_e529dedd = v14:__wf_atom_e529dedd()

		for _, v38 in ipairs(__wf_atom_e529dedd) do
			module.SetEncounterAlerted(v38, false)
		end

		_T.ShutdownTower = false

		if not __wf_atom_7e8ad928(v28) then
			v28:FirePort("TriggerPort")
		end

		v29 = nil
		v14:__wf_atom_4ab4e145(Symbol("OnAlertCallback"))
		module5.RemoveHudTask(v14, v25:c_str(), v25:c_str())
		fn10(-1)
		fn6()
	end
end

function Startup(object)
	aiDir = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	if not object:IsEnabled() then
		print("Shutdown due to hint not enabled")
		return
	end

	v15 = object:__wf_atom_26b04ea9()
	v25 = object:__wf_atom_db682341()

	if not gGameData:__wf_atom_20bf298d(v25) then
		return false
	end

	encounterTemplate = object:__wf_atom_dd85e6db()
	v14 = object
	_T.ShutdownTower = false
	print("=====Starting encounter pollution tower")

	if shouldWaitForParentHint then
		v14:__wf_atom_8e6fec76(1)

		if module.WaitForParentEncounterActive(object) then
			while not __wf_atom_7e8ad928(v15) and v15:__wf_atom_4026dfb5() == 1 do
				Sleep(0)
			end
		else
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8e6fec76(6)
			end

			return
		end
	end

	_T.PolluterTowerOpened = nil
	_T.PolluterBombExploded = false
	_T.OrganBeaversFreed = 0
	_T.CrittersFreed = 0
	_T.VentsOpened = 0
	crittersFreed = 0
	v6 = {}
	_T.EncounterAlerted = false
	_T.OrganMinigameStarted = false
	position = object:GetPosition()
	v16 = object:__wf_atom_dc309f8a()
	_T.TowerWeakpoints = 0
	_T.MaxWeakpoints = #gRegion:__wf_atom_439c0d29(Symbol("OdeOrganWeakSpot"), position, 0, 100)
	module.FindAndChildNearbyHints(v14, __wf_atom_f806fd7a, true)
	started = v13.Started
	gRegion:__wf_atom_c4f78a8f():GetPosition()
	_T.FirstPolluterKillPlayed = false
	_T.FirstPolluterBombPickUp = false
	_T.PolluterBossKilled = false
	_T.PolluterTowerAlerted = false
	_T.OrganMinigameEnded = false
	gGameRules:SetNetPersistentVar(v36, 0)
	gGameRules:__wf_atom_09f9b5f5("OnEnemyDeath")
	gGameRules:__wf_atom_28869475("OnEnemyDeath")
	v14:__wf_atom_b447e001(fn7, Symbol("OnAlertCallback"), 3, true)
	v24 = gRegion:FindNearestTagged(Symbol("BombProtectionMover"), position)
	v21 = gRegion:FindNearestTagged(Symbol("OrganSwitch"), position)
	v27 = gRegion:FindNearestTagged(Symbol("PolluterEffectsEnabler"), position)
	v28 = gRegion:FindNearestTagged(Symbol("PolluterEffectsDisable"), position)
	v31 = gRegion:FindNearestTagged(Symbol("PolluterBirdCineTrigger"), position)
	v32 = gRegion:FindNearestTagged(Symbol("PolluterBirdCineEndTrigger"), position)
	v22 = gRegion:FindNearestTagged(Symbol("PolluterOpenDoors"), position)
	v23 = gRegion:FindNearestTagged(Symbol("PolluteUpperDoors"), position)
	towerAlerted = v13.Started
	v26 = object:__wf_atom_e919fb8e()
	v26.EncounterHint = v14
	v26.EncounterHintPos = position
	v26.EncounterTemplate = encounterTemplate
	v26.AiDir = aiDir
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("PollutorVentMask"), position, 0, 100)

	if #__wf_atom_439c0d29 < 1 then
		print("Early Out: there is no vents near hint pos")
		return
	end

	for _, v37 in pairs(__wf_atom_439c0d29) do
		v37:SetVisibility(true, true)
	end

	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("PollutionTowerTrigger"), position, 0, 100)

	if #__wf_atom_439c0d29_2 > 0 then
		for _, v37 in pairs(__wf_atom_439c0d29_2) do
			v37:Enable()
		end
	end

	fn4()
	Sleep(1)
	fn5()
	local initialGuardsEncounter = initialGuardsEncounter

	if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(initialGuardsEncounter)) then
		print("Activating guard encounter for pollution tower")
		aiDir:AddEncounter(initialGuardsEncounter)
		v17 = aiDir:__wf_atom_c4c644af(position, initialGuardsEncounter, v14)
	end

	Sleep(0)
	flag2 = false
	reinforcementSpawnDelaytime2 = reinforcementSpawnDelaytime
	fn11()
	v12 = gRegion:__wf_atom_ef7900cf()
	module4.RegisterPreventNighfoldUsage(true)
	module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
	v14:__wf_atom_8e6fec76(2)
	fn12()
	gGameRules:__wf_atom_09f9b5f5("OnEnemyDeath")

	if __wf_atom_7e8ad928(v14) then
		print("Shutdown due to level streaming")
		return false
	end

	v14:__wf_atom_2cc8420c(v14:__wf_atom_dd85e6db())
	return true
end

function OnEnemyDeath(object)
	local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

	if
		__wf_atom_7e8ad928(__wf_atom_6ce58983)
		or __wf_atom_6ce58983:__wf_atom_535d5cbb()
		or _T.FirstPolluterKillPlayed
	then
	end
end

function KeyUsed()
	_T.PolluterTowerOpened = 1
	module6.PlayGlobalTransmission(transmissionSet, Symbol("KeyUsed"), true)
end

function BombExploded()
	local position2 = gRegion:__wf_atom_c4f78a8f():GetPosition()
	module7.EnableNearestTaggedSequencer(Symbol("SFXOrganStingerShutdown"), true, position2)
	Sleep(3)
	_T.PolluterBombExploded = true
	_T.PolluterTowerOpened = 2
	MusicShutdown()
end

function BombCarryEnable(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_aeb02c14(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(true)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module4.RegisterPreventNighfoldUsage(true)
	end

	if _T.FirstPolluterBombPickUp then
		return
	end

	_T.FirstPolluterBombPickUp = true
	module6.PlayGlobalTransmission(transmissionSet, Symbol("BombPickup"), true)
end

function BombCarryDisable(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_cf966a74(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(false)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module4.RegisterPreventNighfoldUsage(false)
	end
end

function TowerHintInit(object)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module2.WaitForAiDir()
	v14 = object
	v25 = object:__wf_atom_db682341()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	while not __wf_atom_7e8ad928(gGameData) do
		if gGameData:__wf_atom_20bf298d(v25) then
			fn3(true)
			break
		else
			Sleep(60)
		end
	end
end

function StartBirdOrganistLoopCine(object, _)
	if not gRegion:IsMaster() then
		return
	end

	print("----Starting bird cinematic for organist")
	aiDir = module2.WaitForAiDir()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("OrganistCinematic"), object:GetPosition(), 0, 50)
	local __wf_atom_402b3832 = aiDir:__wf_atom_402b3832(
		Type("/SF/Types/Enemies/Sinecure/Caster/OdeOrganistAgent"),
		__wf_atom_f738b4af:GetPosition(),
		__wf_atom_f738b4af:__wf_atom_dc309f8a(),
		Symbol("RandomTeam"),
		10
	)
	Sleep(1)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		return
	end

	__wf_atom_f738b4af:__wf_atom_a3d2b66b(__wf_atom_402b3832:__wf_atom_50a7d83e(), Symbol("OdeOrganist"))
	module2.SetImmunity(__wf_atom_402b3832:__wf_atom_50a7d83e(), true)
	__wf_atom_f738b4af:FirePort("StartPlaying")
	__wf_atom_7e8ad928(_T.OrganistAvatar)
end

function TriggerBirdEndCine(object, _, _)
	if not gRegion:IsMaster() then
		return
	end

	print("----Stopping bird cinematic for organist")
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("OrganistCinematic"), object:GetPosition(), 0, 20)
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(Symbol("OdeOrganist"), object:GetPosition(), 0, 20)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) and __wf_atom_f738b4af:__wf_atom_7d4910e4() then
		print("--- Should be ending organist cinematic")
		__wf_atom_f738b4af:__wf_atom_a3d2b66b(__wf_atom_f738b4af2, Symbol("OdeOrganist"))
		__wf_atom_f738b4af:__wf_atom_398939a1()
		Sleep(5)
		module2.SetImmunity(__wf_atom_f738b4af2, false)
	end
end

function MiniBossKilled()
	_T.PolluterBossKilled = true
end

function PlayTransmission(object, _)
	if not __wf_atom_7e8ad928(transmissionSet) then
		module6.PlayGlobalTransmission(transmissionSet, sTransmissionSymbol, false)
	end

	_T.PolluterTowerAlerted = false
	local nearestTagged = gRegion:FindNearestTagged(Symbol("PolluterEffectsDisable"), object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:FirePort("TriggerPort")
	end
end

local function fn13(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("OdeOrganWeakSpot"), object:GetPosition(), 0, 100)

	for _, v37 in pairs(__wf_atom_439c0d29) do
		local __wf_atom_f582136d = v37:__wf_atom_f582136d(__wf_atom_ca04301b)
		local __wf_atom_f582136d2 = v37:__wf_atom_f582136d(__wf_atom_8973af3f)

		for _, v38 in pairs(__wf_atom_f582136d2) do
			v38:__wf_atom_a7ee9662(p, true)
		end

		for _, v38 in pairs(__wf_atom_f582136d) do
			if __wf_atom_7e8ad928(v38) then
				continue
			end

			v38:__wf_atom_a7ee9662(false, true)
			v38:__wf_atom_a7ee9662(true, true)
			v38:__wf_atom_a7ee9662(p, true)

			if p then
				v38:Enable()
			else
				v38:Disable()
			end
		end
	end
end

function PlayOrganAnim(object)
	if not __wf_atom_7e8ad928(organStartAnim) then
		object:__wf_atom_1659a669(organStartAnim, false, 4, 3, true)
		Sleep(0.2)

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(organStartAnim) do
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(organStartAnim) then
		object:__wf_atom_1659a669(organLoopAnim, false, 3, 2, true)
	else
		object:__wf_atom_1659a669(organLoopAnim, false, 4, 2, true)
	end

	while not (__wf_atom_7e8ad928(object) or _T.OrganMinigameEnded) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		if __wf_atom_7e8ad928(organStartAnim) then
			object:__wf_atom_1659a669(organEndAnim, false, 3, 1, true)
		else
			object:__wf_atom_1659a669(organEndAnim, false, 4, 1, true)
		end
	end
end

function MusicShutdown()
	if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(position) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local position2 = position

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		position2 = __wf_atom_c4f78a8f:GetPosition()
	end

	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusic"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganDucking"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicInterior"), false, position2)
	module7.EnableNearestTaggedSoundSysVolume(Symbol("TheOrganMusicBalcony"), false, position2)
end

function ActivateOrgan(object, object2)
	if gRegion:IsMaster() then
		object:Disable()
	end

	if __wf_atom_7e8ad928(object2) then
		return
	end

	if object2:__wf_atom_4417a5d4() then
		fn13(object2, true)

		if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(organMinigameMovie) then
			v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(organMinigameMovie)
		end

		if not gRegion:IsMaster() then
			local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
			musicResultsRMIArgs.mIsPlaying = true
			musicResultsRMIArgs.mSuccess = false
			gRegion:__wf_atom_c4f78a8f():__wf_atom_0a2fdbe5(musicResultsRMIArgs)
		end

		while not __wf_atom_7e8ad928(v) and v:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		if not gRegion:IsMaster() then
			local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
			musicResultsRMIArgs.mIsPlaying = false
			musicResultsRMIArgs.mSuccess = true
			gRegion:__wf_atom_c4f78a8f():__wf_atom_0a2fdbe5(musicResultsRMIArgs)
		end

		fn13(object2, false)

		if gRegion:IsMaster() and (_T.TowerWeakpoints == nil or _T.TowerWeakpoints < _T.MaxWeakpoints) then
			object:Enable()
		end
	elseif gRegion:IsMaster() then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("OrganMinigameReplicator"), object2:GetPosition())

		if __wf_atom_7e8ad928(nearestTagged) then
			return
		end

		nearestTagged:__wf_atom_dcb25c85(object2:__wf_atom_a96eb2aa())
		object2:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
		local __wf_atom_8161e6ba = object2:__wf_atom_8161e6ba()

		while not (__wf_atom_7e8ad928(object2) or __wf_atom_8161e6ba.mIsPlaying) do
			Sleep(0)
		end

		while not (__wf_atom_7e8ad928(object2) or __wf_atom_8161e6ba.mSuccess) do
			Sleep(0)
		end

		if
			__wf_atom_7e8ad928(_T.TowerWeakpoints)
			or __wf_atom_7e8ad928(_T.MaxWeakpoints)
			or _T.TowerWeakpoints >= _T.MaxWeakpoints
		then
			return
		end

		if _T.TowerWeakpoints < _T.MaxWeakpoints then
			object:Enable()
		end

		nearestTagged:__wf_atom_dcb25c85(nil)
	end
end

function OrganWeakpointDestroyed(object)
	if _T.TowerWeakpoints ~= nil then
		_T.TowerWeakpoints += 1

		if _T.TowerWeakpoints >= _T.MaxWeakpoints then
			_T.OrganMinigameEnded = true
			gGameRules:SetNetPersistentVar(v36, 1)
		end
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_ca04301b)
		local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_8973af3f)

		for _, v37 in pairs(__wf_atom_f582136d) do
			v37:__wf_atom_a7ee9662(false, true)
		end

		for _, v37 in pairs(__wf_atom_f582136d2) do
			v37:__wf_atom_a7ee9662(false, true)
		end
	end
end

function OrganVentDamaged(p)
	for _, v37 in ipairs(v6) do
		if p == v37 then
			return
		end
	end

	_T.VentsOpened = _T.VentsOpened or 0
	_T.VentsOpened += 1
	table.insert(v6, p)
	print("Organ vent number " .. _T.VentsOpened .. " opened")
end