local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.StatsLib")
local module7 = require("Lotus.Scripts.Libs.AudioLib")
local module8 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module9 = require("SF.Scripts.NightFoldLib")
local module10 = require("SF.Interface.SFUtilities")
local module11 = require("SF.Scripts.Libs.TaleLib")
local module12 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module13 = require("SF.Scripts.Libs.ChallengeLib")
local module14 = require("Lotus.Interface.WorldStateUtilities")
local v = Symbol("MT_SUBBOSS")
local v2 = Symbol("RandomTeam")
local v3 = Symbol("SubBossProgressEntity")
local v4 = Symbol("SubBossHelperEntity")
local v5 = Symbol("SubBossMusic")
local v6 = WeakResource("/SF/Types/Game/Encounters/CombatEncounterHint")
local v7 = Symbol("Neutral")
Symbol("TaleSubboss")
local v8 = nil
local v9 = nil
local position = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = false
local v19 = false
local v20 = false
local v21 = nil
local v22 = Symbol("HardModeBossStarted")
local v23 = nil

local function fn(position2)
	local __wf_atom_0e0a6fee = v11:__wf_atom_0e0a6fee(position2)
	local groundPos = module4.GetGroundPos(__wf_atom_0e0a6fee)

	if __wf_atom_7e8ad928(v10) then
		local v24 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		print("Creating object: " .. tostring(position2) .. " -> " .. tostring(__wf_atom_0e0a6fee) .. " -> " .. tostring(groundPos))
		v10 = gRegion:CreateEntity(dropOnDeathObjectType, groundPos + Vector(0, 1, 0), v24)
		local v25 = Vector(Random(0, 2) - 1, 0, Random(0, 2) - 1)
		Normalize(v25)
		local v26 = Vector(0, 1, 0) * Random(5, 10) + v25 * Random(1, 2)
		v10:__wf_atom_66d7a6a9(v26, 2)
		v10:__wf_atom_276fe711(v26)
	elseif not __wf_atom_7e8ad928(v10) then
		v10:__wf_atom_e6ed03c8()
		v10:__wf_atom_0ed81088(true)
		local v24 = Vector()
		gRegion:__wf_atom_c20d246a(
			v10:GetPosition(),
			v10:GetPosition() - Vector(0, 5, 0),
			{
				__wf_atom_4ebf67cb,
				__wf_atom_3feeb44a,
				__wf_atom_43e0c427,
				__wf_atom_7b01f9ce,
				__wf_atom_3feeb44a
			},
			nil,
			v24
		)

		if v24 == __wf_atom_28d5d4aa then
			v10:SetPosition(__wf_atom_0e0a6fee + Vector(0, 0.25, 0))
		end

		v10:__wf_atom_03d03fec(false)
		v10:__wf_atom_1b57cb83(false)
		print("Unattached existing object")
	end

	if not __wf_atom_7e8ad928(v10) then
		if isSiegeSubBoss then
			module5.AddSparrowDestination(v10, v9, tostring(siegeTag) .. "Drop", module5.PRIORITY.HIGH, Range(1, 40))
		else
			module5.AddSparrowDestination(v10, v9, nil, module5.PRIORITY.HIGH, Range(1, 40))
		end
	end
end

function OnKilled(object)
	if __wf_atom_7e8ad928(v8) then
		return
	end

	if not object:__wf_atom_bedb4e3f() then
		v8:__wf_atom_8e6fec76(4)
	end

	if not __wf_atom_7e8ad928(dropOnDeathObjectType) then
		fn(object:GetPosition())
	end

	if module.IsHardModeActive() then
		module.HardModeIncrementSubBossKillCount(1)
		gGameRules:SetNetPersistentVar(v22, 0)

		if v21 and v21 ~= false then
			module9.RegisterPreventNighfoldUsage(false)
			v21 = false
		end
	end

	Sleep(2)

	if infamyStandingIncrease > 0 then
		gGameData:__wf_atom_e7f3cb75(infamySyndicate, infamyStandingIncrease)
	end

	if playCelebration and not v19 then
		local v24 = WeakResource("/SF/Interface/HUD/Notification.swf")

		if not __wf_atom_7e8ad928(v24) then
			local v25 = {
				LocArgs = { NAME = bossName }
			}

			if infamyStandingIncrease > 0 then
				v25.InfamyDelta = math.round(infamyStandingIncrease)
			end

			module10.ExecuteForAllPlayers(function(p)
				gGameRules:__wf_atom_6680e8ba(
					p,
					v24,
					"SubbossKilled",
					{ bossName, tostring(5), (tostring(1)) },
					5,
					"SubbossKilled",
					true
				)
			end)
		end
	end
end

function OnPreDeath(p)
	OnKilled(p)
end

local function fn2()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		subBossSpawnPointTag,
		position,
		0,
		(math.max(40, v9:__wf_atom_103377cc() + 5))
	)
	local pointInstances = module.FindPointInstances(v9, nil, subBossSpawnPointTag)
	local mergeTables = module2.MergeTables(__wf_atom_439c0d29, pointInstances, true)
	local v24

	if #mergeTables > 0 then
		return mergeTables[__wf_atom_5784a397(1, #mergeTables)]
	end

	return v24
end

local function fn3(pointInstances)
	while not module.PrimedMissionShouldShutDown(v8, v9) do
		for _, v24 in ipairs(pointInstances) do
			if __wf_atom_7e8ad928(v24) then
				return false
			end

			if not v24:IsEnabled() then
				continue
			end

			if v24:IsA(__wf_atom_62e6d04b) and v24:IsFull() or not v24:IsA(__wf_atom_62e6d04b) then
				return true
			end
		end

		Sleep(0.1)
	end

	return false
end

local function fn4(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_50a7d83e()) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local v24 = nil

	for _, v25 in ipairs(__wf_atom_ef7900cf) do
		if v25:__wf_atom_8a6b8fc3(__wf_atom_50a7d83e) < 9999 then
			v24 = v25
		end
	end

	if not __wf_atom_7e8ad928(v24) then
		object:__wf_atom_30b587a4()
		object:StormTarget(v24)
	end

	local position2 = __wf_atom_50a7d83e:GetPosition()
	local v25

	if not __wf_atom_7e8ad928(v24) then
		v25 = __wf_atom_fa8d0177(position2, v24:__wf_atom_a2a18137())
	end

	if gRegion:IsMaster() then
		__wf_atom_50a7d83e:Teleport(position2, v25)
		__wf_atom_50a7d83e:__wf_atom_3c986cd9(position2, v25)
	end
end

local function fn5(_)
	return nil
end

local function fn6()
	if not module2.IsInOverworld() then
		local pointInstances = module.FindPointInstances(v9, __wf_atom_46b5a019, Symbol("PointOfInterest"))

		if not __wf_atom_7e8ad928(pointInstances) and #pointInstances > 0 then
			local nearestObject = module2.NearestObject(v14:GetPosition(), pointInstances, 10)

			if not __wf_atom_7e8ad928(nearestObject) then
				local v24 = fn5(nearestObject)

				if not __wf_atom_7e8ad928(v24) then
					nearestObject:__wf_atom_9b788a35(v24)
				end

				if not nearestObject:IsEnabled() then
					nearestObject:Enable()
				end
			end
		end
	end
end

function TrackOnSpawnStorming(object)
	local v24 = Symbol("StormTarget")

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_8d28b9c3(v24) do
		if __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_eda97f5a()) then
			Sleep(1)
		else
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v24)
			break
		end
	end
end

local function fn7()
	if __wf_atom_7e8ad928(v15) then
		v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
	end

	print(v15 .. "Spawning sub-boss")
	local v24 = fn2()
	local maxValue = module.GetEnemyLevel(v9).maxValue

	if bossLevelOverride > 0 then
		maxValue = bossLevelOverride
	end

	if __wf_atom_7e8ad928(triggerType) then
		triggerType = __wf_atom_62e6d04b
	end

	local pointInstances = module.FindPointInstances(v9, triggerType, Symbol("SubBossSpawnTrigger"))

	if not __wf_atom_7e8ad928(pointInstances) and #pointInstances > 0 and not fn3(pointInstances) then
		print("Early out due to streaming into a dungeon, or boss trigger became null")
		return false
	end

	local subBossAgentType = subBossAgentType
	local bossName = bossName

	if __wf_atom_7e8ad928(subBossAgentType) and not module2.IsInOverworld() then
		subBossAgentType, bossName = module8.GetThisDungeonSubBoss()
	end

	if __wf_atom_7e8ad928(subBossAgentType) then
		print("No subboss agent type found")
		return false
	end

	if v8:GetNumRegisteredAgentsOfType(subBossAgentType) > 0 then
		local __wf_atom_3b73b479 = v8:__wf_atom_3b73b479(subBossAgentType)

		if not __wf_atom_7e8ad928(__wf_atom_3b73b479) and #__wf_atom_3b73b479 > 0 then
			v13 = __wf_atom_3b73b479[1]
		end
	elseif __wf_atom_7e8ad928(v24) then
		local v25 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

		if module2.IsInOverworld() then
			local __wf_atom_4e9476e3 = v11:__wf_atom_4e9476e3(position)

			if not __wf_atom_7e8ad928(__wf_atom_4e9476e3) then
				v25 = __wf_atom_fa8d0177(position, __wf_atom_4e9476e3:GetPosition())
			end
		else
			v25 = fn5(v9) or v25
		end

		local __wf_atom_0e0a6fee = v11:__wf_atom_0e0a6fee(position)
		v13 = v11:__wf_atom_402b3832(subBossAgentType, __wf_atom_0e0a6fee, v25, v2, maxValue)

		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. "Created agent at hint position")
	else
		if not module2.IsInOverworld() then
			local v25 = fn5(v24)

			if not __wf_atom_7e8ad928(v25) then
				v24:__wf_atom_9b788a35(v25)
			end
		end

		if v24:IsA(gNpcSpawnPointType) then
			v13 = v11:CreateAgent(subBossAgentType, v24, v2, maxValue)

			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Created agent at tagged NpcSpawnPoint")
		else
			v13 = v11:__wf_atom_402b3832(subBossAgentType, v24:GetPosition(), v24:__wf_atom_dc309f8a(), v2, maxValue)

			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Created agent at tagged entity")
		end
	end

	if __wf_atom_7e8ad928(v13) then
		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. "Nil agent!")
		return false
	else
		v8:__wf_atom_97f955c1(v13)
		v14 = v13:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(v14) then
			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Nil avatar!")
			return false
		else
			if not __wf_atom_7e8ad928(bossName) then
				v14:__wf_atom_17e77e5b(Localize(bossName, nil))
				v14:__wf_atom_5cb037b2(Symbol(bossName))
			end

			if endOnPreDeath then
				v14:__wf_atom_d705eea0("OnPreDeath")
			end

			__wf_atom_55142dd4(v14, "OnKilled")
			fn6()

			if module.IsHardModeActive() and __wf_atom_7e8ad928((v14:__wf_atom_bb3e7833(hardModeAttachFxType))) then
				local v25 = Symbol("GAME_C1_SPINE3")

				if not v14:__wf_atom_71a94e55(v25) then
					v25 = Symbol("GAME_C1_COG")
				end

				v14:Attach(hardModeAttachFxType, v25)
			end

			if not __wf_atom_7e8ad928(v17) then
				v17:Enable()
			end

			if not __wf_atom_7e8ad928(additionalGuardsEncounter) and v9:__wf_atom_f599384e() == 0 then
				v11:AddEncounter(additionalGuardsEncounter)
				v12 = v11:__wf_atom_c4c644af(position + Vector(1, 0, 1), additionalGuardsEncounter, v9)

				if __wf_atom_7e8ad928(v15) then
					v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
				end

				print(v15 .. "Activating guard encounter for")
			end

			if not __wf_atom_7e8ad928(spawnAnimation) then
				v14:__wf_atom_52bae0cc(spawnAnimation, 4, true)
			end

			if not __wf_atom_7e8ad928(spawnFX) then
				v14:Attach(spawnFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			if not __wf_atom_7e8ad928(spawnSound) then
				v14:PlaySound(spawnSound, false)
			end

			module2.StartPluginScripts(postSubBossSpawnnScripts, v8)

			if shouldStormTargetOnSpawn then
				fn4(v13)
				v14:__wf_atom_8a035cd5(Symbol("TrackOnSpawnStorming"), false)
			end

			if not dissolveIn then
				return true
			end

			v14:__wf_atom_68f2c268(1)
			local v25 = 0

			while not __wf_atom_7e8ad928(v14) and v25 < 1 do
				v25 = __wf_atom_421b01aa(v25 + __wf_atom_084b3e93(), 0, 1)
				v14:__wf_atom_68f2c268((math.pow(1 - v25, 2)))
				Sleep(0)
			end

			if __wf_atom_7e8ad928(v14) then
				return false
			else
				v14:__wf_atom_68f2c268(0)
			end

			return true
		end
	end
end

local function fn8(object, p)
	local v24

	if p then
		v24 = v3
	else
		v24 = v4
	end

	local pointInstances = module.FindPointInstances(object, nil, v24)

	for _, pointInstance in pairs(pointInstances) do
		if pointInstance:IsA(WeakResource("/EE/Types/Effects/PortForwarder")) then
			pointInstance:FirePort("TriggerPort")
		elseif pointInstance:IsA(__wf_atom_3a0953be) then
			gRegion:CreateEntity(
				dropOnDeathObjectType,
				pointInstance:GetPosition(),
				pointInstance:__wf_atom_dc309f8a(),
				object
			)
		end
	end
end

local function fn9()
	local count = 0
	local flag = false
	local v24 = 0

	while not __wf_atom_7e8ad928(v8) do
		count += 1
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local nearestObject = module2.NearestObject(position, __wf_atom_ef7900cf)

		if v8:__wf_atom_8a6b8fc3(nearestObject) < waitToSpawnDistance then
			if __wf_atom_7e8ad928(warningSequencerType) then
				return true
			end

			if flag then
				if flag and v24 > 0 then
					v24 -= 1
				elseif flag and v24 <= 0 then
					return true
				end
			else
				local v25 = __wf_atom_f55d6358(
					nearestObject:GetPosition() + Vector(0, 2, 0),
					position + Vector(0, 2, 0),
					0.4
				)
				local entity = gRegion:CreateEntity(warningSequencerType, v25, __wf_atom_80368bb1)
				entity:Enable()
				v8:__wf_atom_d494454b(entity)
				v24 = entity:__wf_atom_0df68063()
				flag = true
			end
		end

		if count > 1000 then
			return false
		else
			Sleep(1)
		end
	end

	return false
end

function TimerSetCallback()
	v18 = true
end

function ReinforcementMonitor(object)
	local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()
	local v24 = module2.WaitForAiDir()
	v24:AddEncounter(reinforcementEncounterType)
	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	if __wf_atom_7e8ad928(__wf_atom_6199ef01) or #__wf_atom_6199ef01 == 0 then
		return
	end

	local v25 = __wf_atom_6199ef01[1]

	if __wf_atom_7e8ad928(v25) then
		return
	end

	local __wf_atom_50a7d83e = v25:__wf_atom_50a7d83e()

	while
		not __wf_atom_7e8ad928(object)
		and object:__wf_atom_4026dfb5() == 2
		and not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() or __wf_atom_50a7d83e:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(v25))
	do
		if v25:__wf_atom_351e924e() then
			__wf_atom_26b04ea9:__wf_atom_3634e6d2()

			if __wf_atom_7e8ad928(__wf_atom_26b04ea9) or not (__wf_atom_26b04ea9:__wf_atom_3634e6d2() > 1) then
				if __wf_atom_7e8ad928(v23) then
					Sleep(reinforcementDelay)

					if
						__wf_atom_7e8ad928(__wf_atom_50a7d83e)
						or (__wf_atom_50a7d83e:IsKilled() or __wf_atom_50a7d83e:__wf_atom_bedb4e3f())
					then
						break
					end

					v23 = v24:__wf_atom_c4c644af(
						__wf_atom_26b04ea9:GetPosition(),
						reinforcementEncounterType,
						__wf_atom_26b04ea9
					)

					if not (__wf_atom_7e8ad928(v23) or __wf_atom_7e8ad928(reinforcementSpawnAnimation)) then
						local __wf_atom_6199ef01_2 = v23:__wf_atom_6199ef01()

						for _, v26 in ipairs(__wf_atom_6199ef01_2) do
							v26:__wf_atom_52bae0cc(reinforcementSpawnAnimation, 4, true)
						end
					end
				end
			else
				Sleep(0)
			end
		end

		Sleep(0)
	end
end

function PhaseMonitor(object)
	local v24 = module2.WaitForAiDir()

	while not (v24:IsEnabled() and v24:__wf_atom_5e711c72()) do
		Sleep(0)
	end

	local __wf_atom_76724198 = object:__wf_atom_30e3d82b():__wf_atom_76724198()
	local __wf_atom_26b04ea9 = __wf_atom_76724198:__wf_atom_26b04ea9()
	local __wf_atom_2b1fe281 = __wf_atom_76724198:__wf_atom_2b1fe281()
	local v25

	if __wf_atom_2b1fe281 > 1 then
		v25 = __wf_atom_2b1fe281 - 1
	else
		v25 = 1
	end

	while
		not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and not object:__wf_atom_bedb4e3f()
		and v25 <= #phaseHealthThresholds
	do
		if phaseHealthThresholds[v25] >= object:__wf_atom_bb81a9df() then
			if v25 <= #phaseReinforcementEncounter and not __wf_atom_7e8ad928(phaseReinforcementEncounter[v25]) then
				v24:AddEncounter(phaseReinforcementEncounter[v25])
				v23 = v24:__wf_atom_c4c644af(
					__wf_atom_26b04ea9:GetPosition(),
					phaseReinforcementEncounter[v25],
					__wf_atom_76724198
				)

				while waitForPhaseEnd and not __wf_atom_7e8ad928(v23) and v23:__wf_atom_4026dfb5() <= 2 do
					Sleep(0)
				end
			end

			v25 += 1

			if not __wf_atom_7e8ad928(__wf_atom_76724198) then
				__wf_atom_76724198:__wf_atom_8776856a(v25)
			end
		end

		Sleep(0)
	end
end

function MainLoop(object)
	module2.WaitForAiDir()
	v8 = object
	v9 = object:__wf_atom_26b04ea9() or object

	if __wf_atom_7e8ad928(v15) then
		v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
	end

	print(v15 .. "Sub-boss encounter starting")
	position = v9:GetPosition()
	v11 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v17 = module.FindTaggedInstanceRef(v9, v5)

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if checkIfAllowedToSpawn then
		local worldStateOverride = module14.GetWorldStateOverride("tcmr")
		local v24 = worldStateOverride and tonumber(worldStateOverride)

		if __wf_atom_7e8ad928(v24) or gGameRules:__wf_atom_93691ff2() < v24 then
			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "SubBoss encounter shut down early due to timer not being ")

			for _, v25 in ipairs(encounterHintTagsToAdd) do
				object:__wf_atom_61860938(v25)
			end

			module.RemoveAgents(object)
			module.RemoveObjects(object)
			v9:__wf_atom_75628d88(EMPTY_SYMBOL)
			object:__wf_atom_8e6fec76(6)
			return
		end
	end

	local subBossTimerSymb = module.GetSubBossTimerSymb(v9, module.IsHardModeActive())

	if isSiegeSubBoss or gGameData:__wf_atom_20bf298d(subBossTimerSymb) then
		object:__wf_atom_8e6fec76(1)
		local v24

		if not __wf_atom_7e8ad928(warningFxType) then
			local v25 = fn2()
			local v26

			if __wf_atom_7e8ad928(v25) then
				v26 = position
			else
				v26 = v25:GetPosition()
			end

			v24 = gRegion:CreateEntity(warningFxType, v26, __wf_atom_80368bb1)
			v24:SetMeshScale(20, true)
		end

		if shouldOnlySpawnIfPlayerCloseEnough and not fn9() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8e6fec76(6)
			end
		else
			if not __wf_atom_7e8ad928(v24) then
				v24:FadeOut()
			end

			module2.StartPluginScripts(preSubbossSpawnScripts, v8)

			if not fn7() then
				object:__wf_atom_8e6fec76(6)
				return
			end

			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Setup completed")
			object:__wf_atom_8e6fec76(2)
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			if not (__wf_atom_7e8ad928(__wf_atom_3c8e1a7a) or __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v14)) then
				v16 = module6.StartSubBossFight(
					v14:__wf_atom_1bb5b1ff(),
					#__wf_atom_3c8e1a7a,
					tostring(v9:__wf_atom_db682341()),
					module.GetEnemyLevel(v9)
				)
			end

			if usePhases then
				v14:__wf_atom_8a035cd5(Symbol("PhaseMonitor"), false)
			end

			if not __wf_atom_7e8ad928(reinforcementEncounterType) then
				object:__wf_atom_8a035cd5(Symbol("ReinforcementMonitor"), false)
			end

			v19 = module11.HintIsReserved(v9)

			if v19 then
				local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()
				local subbossTaleTitle = tostring(__wf_atom_dd85e6db:__wf_atom_4f3855f9())
				local v25 = tostring(__wf_atom_dd85e6db:__wf_atom_c1f3dd00())
				local bossName = bossName
				local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

				if __wf_atom_7e8ad928(__wf_atom_e919fb8e.subBossName) or __wf_atom_e919fb8e.subBossName == "" then
					if not module2.IsInOverworld() then
						local _
						_, bossName, subbossTaleTitle = module8.GetThisDungeonSubBoss()
					end
				else
					bossName = __wf_atom_e919fb8e.subBossName
				end

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.subbossTaleTitle) then
					subbossTaleTitle = __wf_atom_e919fb8e.subbossTaleTitle
				end

				module12.AddHudTitle(object, nil, subbossTaleTitle)
				module12.UpdateOrAddHudTask(object, nil, v25, nil, nil, nil, nil, nil, {
					TextParams = { BOSSNAME = bossName }
				})
				module5.AddSparrowDestination(v14, v9, nil, module5.PRIORITY.HIGH, Range(10, v9:__wf_atom_8f18e876()))
			end

			while not module.PrimedMissionShouldShutDown(object, v9) do
				if
					isSiegeSubBoss
					and not __wf_atom_7e8ad928(v13)
					and v13:__wf_atom_351e924e()
					and not (__wf_atom_7e8ad928(v9) or v9:__wf_atom_04ea4887())
				then
					v9:__wf_atom_bebcda98()
				end

				if __wf_atom_7e8ad928(v14) or v14:__wf_atom_e93896ba() ~= v7 then
					if
						module.IsHardModeActive()
						and not __wf_atom_7e8ad928(v14)
						and v14:__wf_atom_a5a91da2()
						and not v20
					then
						v20 = true
						v8:__wf_atom_b811702e(Symbol("ActiveSubBossHint"))
						gGameRules:SetNetPersistentVar(v22, 1)

						if not v21 and v21 ~= true then
							module9.RegisterPreventNighfoldUsage(true)
							module9.SetPreventNightfoldUsageReason(module9.BT_COMBAT)
							v21 = true
						end
					end

					Sleep(0)
				else
					object:__wf_atom_f7bbb462(v14:__wf_atom_30e3d82b())
					OnKilled(v14)
					break
				end
			end

			while object:__wf_atom_c0b8d0bd() do
				Sleep(0)
			end

			if waitForParentHintToShutDown then
				while not __wf_atom_7e8ad928(v9) and v9:__wf_atom_4026dfb5() <= 2 do
					Sleep(0)
				end
			end

			module7.EnableTaggedSoundSysVolumes(Symbol("SubBossMusic"), false)

			if not __wf_atom_7e8ad928(v17) then
				v17:Disable()
			end

			module6.EndSubBossFight(v16, object:__wf_atom_4026dfb5())
			v16 = nil
			local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()
			module13.NotifySubbossComplete(__wf_atom_4026dfb5 == 4)

			if __wf_atom_4026dfb5 == 4 then
				if __wf_atom_7e8ad928(v15) then
					v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
				end

				print(v15 .. "Sub-boss defeated")

				if not isSiegeSubBoss then
					gGameData:__wf_atom_a975522c(subBossTimerSymb, 1800, true, "TimerSetCallback")

					while not v18 do
						Sleep(0)
					end
				end

				if module.IsHardModeActive() then
					gGameRules:SetNetPersistentVar(v22, 2)
					module.SetHardModeLevel()
				end

				if not __wf_atom_7e8ad928(v9) then
					v9:__wf_atom_71694ad6(parentHintCooldown)
				end

				if v19 then
					module12.CompleteHudTask(object)
					Sleep(4)
				end
			else
				if __wf_atom_7e8ad928(v15) then
					v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
				end

				print(v15 .. "Sub-boss encounter shutdown")

				if not __wf_atom_7e8ad928(v14) and v14:__wf_atom_b2f8ef81() then
					v14:__wf_atom_3d96ddcd():Destroy()
				end

				if module.IsHardModeActive() then
					gGameRules:SetNetPersistentVar(v22, 0)
				end

				if not __wf_atom_7e8ad928(v12) then
					v12:__wf_atom_8e6fec76(6)
				end

				object:__wf_atom_8e6fec76(6)
			end

			if __wf_atom_7e8ad928(object) then
				print("Streaming at shutdown")
				return
			end

			if module.IsHardModeActive() and v21 and v21 ~= false then
				module9.RegisterPreventNighfoldUsage(false)
				v21 = false
			end

			for _, v25 in ipairs(encounterHintTagsToAdd) do
				object:__wf_atom_61860938(v25)
			end

			module12.RemoveHudGroup(object)
			module.RemoveAgents(object)
			module.RemoveObjects(object)

			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Sub-boss encounter shutdown done")
		end
	else
		local v24 = "SubBoss encounter shut down early due to timer " .. tostring(subBossTimerSymb)

		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. v24)

		for _, v25 in ipairs(encounterHintTagsToAdd) do
			object:__wf_atom_61860938(v25)
		end

		module.RemoveAgents(object)
		module.RemoveObjects(object)
		v9:__wf_atom_75628d88(EMPTY_SYMBOL)
		object:__wf_atom_8e6fec76(6)
	end
end

function OnPrimed(object)
	local v24 = module2.WaitForAiDir()

	while not v24:__wf_atom_5e711c72() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		print("Streaming at shutdown")
		return
	end

	v9 = object:__wf_atom_26b04ea9() or object

	if __wf_atom_7e8ad928(v15) then
		v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
	end

	print(v15 .. "Primed sub-boss encounter")

	if not module2.IsInOverworld() then
		local subBossTimerSymb = module.GetSubBossTimerSymb(object, module.IsHardModeActive())
		v9:__wf_atom_ed6d3248(subBossTimerSymb)
	end

	if not isSiegeSubBoss then
		module.SetEncounterHeaviesBlocked(v9, true)
	end
end

function InitSubBoss(object)
	v9 = object

	if __wf_atom_7e8ad928(v15) then
		v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
	end

	print(v15 .. "Init sub-boss")
	local v24 = false
	module2.WaitForLevel()
	local v25 = module2.WaitForAiDir()

	if not module2.IsInOverworld() then
		while not v25:__wf_atom_5e711c72() do
			Sleep(0)
		end

		local currentLocation = module8.GetCurrentLocation()
		local activeDungeonTaleInfo, _, _ = module8.GetActiveDungeonTaleInfo()

		if not __wf_atom_7e8ad928(activeDungeonTaleInfo) and activeDungeonTaleInfo == currentLocation then
			print("A tale is already active in this dungeon")
			return
		end

		local thisDungeonSubBoss, _ = module8.GetThisDungeonSubBoss()

		if __wf_atom_7e8ad928(thisDungeonSubBoss) then
			return
		end
	end

	if module.IsHardModeActive() then
		gGameRules:SetNetPersistentVar(v22, 0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_5b6b447d() == EMPTY_SYMBOL then
		if module11.HintIsReserved(object) then
			print("Subboss hint is reserved for a tale")
			return
		end

		if
			isSiegeSubBoss
			and (_T.OngoingSiege and _T.OngoingSiege == siegeTag or __wf_atom_7e8ad928(gGameData) or not gGameData:__wf_atom_20bf298d(siegeTag))
		then
			return
		end

		if module.GetSubbossEncounterTemplateName(object) ~= nil then
			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "Found a sub-boss encounter")

			if #requiredQuestsToComplete > 0 and not module3.HasCompletedQuestsInList(requiredQuestsToComplete) then
				if __wf_atom_7e8ad928(v15) then
					v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
				end

				print(v15 .. "Early out due to an incomplete quest")
			elseif #blockedDuringQuests > 0 and module3.AnyQuestIsActive(blockedDuringQuests) then
				if __wf_atom_7e8ad928(v15) then
					v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
				end

				print(v15 .. "Early out due to an active quest")
			else
				local __wf_atom_5b6b447d = object:__wf_atom_5b6b447d()
				local subBossTimerSymb = module.GetSubBossTimerSymb(object, module.IsHardModeActive())

				if
					__wf_atom_7e8ad928(gGameData)
					or not (gGameData:__wf_atom_20bf298d(subBossTimerSymb) or v24 or isSiegeSubBoss)
				then
					local v26 = "Sub-boss can't spawn due to an active timer " .. tostring(subBossTimerSymb)

					if __wf_atom_7e8ad928(v15) then
						v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
					end

					print(v15 .. v26)
					fn8(object, true)

					if __wf_atom_5b6b447d == v then
						object:__wf_atom_75628d88(EMPTY_SYMBOL)

						if __wf_atom_7e8ad928(v15) then
							v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
						end

						print(v15 .. "Unprimed sub-boss hint")

						for _, v27 in ipairs(encounterHintTagsToAdd) do
							object:__wf_atom_61860938(v27)
						end
					end
				else
					local v26 = "No active timer, sub-boss can spawn here " .. tostring(subBossTimerSymb)

					if __wf_atom_7e8ad928(v15) then
						v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
					end

					print(v15 .. v26)

					if __wf_atom_5b6b447d == EMPTY_SYMBOL then
						if v25:PrimeMissionOnHint(v, object, not isSiegeSubBoss) then
							if __wf_atom_7e8ad928(v15) then
								v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
							end

							print(v15 .. "Primed hint")

							for _, v27 in ipairs(encounterHintTagsToAdd) do
								local v28 = "Adding encounter system tag " .. tostring(v27)

								if __wf_atom_7e8ad928(v15) then
									v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
								end

								print(v15 .. v28)
								object:__wf_atom_1f5c6559(v27)
							end

							if disableCombatHintRadius > 0 then
								local all = gRegion:FindAll(v6, object:GetPosition(), 0, disableCombatHintRadius)

								for _, v27 in ipairs(all) do
									if v27 ~= object then
										v27:Disable()
									end
								end
							end

							fn8(object, false)
						else
							if __wf_atom_7e8ad928(v15) then
								v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
							end

							print(v15 .. "Failed to prime hint")
						end
					end
				end
			end
		else
			if __wf_atom_7e8ad928(v15) then
				v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
			end

			print(v15 .. "No SubBoss encounter template exists on this hint!")
		end
	else
		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. "Hint already primed")
	end
end

function InitDungeonEntranceSubboss(object)
	if not module2.IsInOverworld() then
		print("Not usable in dungeon proc levels, place in the overworld near a dungeon entrance")
		return
	end

	local v24 = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v24, object:GetPosition(), 80)

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		print("InitDungeonEntranceSubboss early out, no entrance found within 80m!")
		return
	end

	local __wf_atom_db682341 = __wf_atom_e2db08ce:__wf_atom_db682341()
	module8.SetDungeonEntranceSubboss(__wf_atom_db682341, subBossAgentType, bossName)
end

function SubBossScriptTrigger(p)
	module2.WaitForLevel()

	if __wf_atom_7e8ad928(encounterHint) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameData) then
		return
	end

	local subBossTimerSymb = module.GetSubBossTimerSymb(encounterHint, module.IsHardModeActive())
	local v24 = nil

	while not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(encounterHint)) do
		local v25 = not gGameData:__wf_atom_20bf298d(subBossTimerSymb)

		if v24 ~= v25 and not encounterHint:IsActive() then
			if v25 then
				if not __wf_atom_7e8ad928(timerActivePortForwarder) then
					timerActivePortForwarder:FirePort("TriggerPort")
				end
			elseif not __wf_atom_7e8ad928(timerInactivePortForwarder) then
				timerInactivePortForwarder:FirePort("TriggerPort")
			end

			v24 = v25
		end

		Sleep(60)
	end
end

function DummyEncounter(object)
	v9 = object
	v8 = object
	object:__wf_atom_8e6fec76(2)
	local v24 = false

	while not module.ShouldShutDown(object) do
		if not v24 and object:__wf_atom_3634e6d2(true) > 0 then
			local __wf_atom_be637430 = object:__wf_atom_be637430()

			if not __wf_atom_7e8ad928(__wf_atom_be637430) and #__wf_atom_be637430 > 0 then
				local v25 = __wf_atom_be637430[1]

				if not __wf_atom_7e8ad928(v25) then
					__wf_atom_55142dd4(v25:__wf_atom_50a7d83e(), "OnKilled")
					v24 = true
				end
			end
		end

		Sleep(1)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local subBossTimerSymb = module.GetSubBossTimerSymb(v9, module.IsHardModeActive())

	if object:__wf_atom_4026dfb5() == 4 then
		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. "Sub-boss defeated")
		gGameData:__wf_atom_a975522c(subBossTimerSymb, 1800, true, "TimerSetCallback")

		while not v18 do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_71694ad6(parentHintCooldown)
		end
	else
		if __wf_atom_7e8ad928(v15) then
			v15 = "[" .. v9:GetName() .. "-" .. tostring(v9:__wf_atom_db682341()) .. "] "
		end

		print(v15 .. "Sub-boss encounter shutdown")

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_8e6fec76(6)
		end
	end
end

function SubbossHintOnStartup(object)
	module2.WaitForLevel()

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		return
	end

	if canSpawnInTales then
		__wf_atom_e919fb8e.subbossCanSpawnInTales = true
	end

	__wf_atom_e919fb8e.subBossName = bossName
end

function SetSubbossName(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(bossName) then
		__wf_atom_50a7d83e:__wf_atom_17e77e5b(Localize(bossName, nil))
		__wf_atom_50a7d83e:__wf_atom_5cb037b2(Symbol(bossName))
	end
end