local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.QuestLib")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("SF.Interface.Libs.MusicCommon")
local module8 = require("SF.Scripts.Libs.RespawnLib")
local flag = false
local v = nil
local v2 = Symbol("RandomTeam")
local v3 = nil
local position = nil
local v4 = nil
local v5 = nil
local v6 = nil
local overrideSpawnDistanceRange2 = nil
local v7 = false
local v8 = Symbol("Guard")
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = {}

function DissolveOutDecos()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("WazzardFrame"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StructureHideFX"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Burst")
	end

	local v17 = 0

	while v17 < 2 do
		v17 = __wf_atom_421b01aa(v17 + __wf_atom_084b3e93(), 0, 2)

		for _, v18 in pairs(__wf_atom_2226b35c) do
			if not __wf_atom_7e8ad928(v18) then
				v18:__wf_atom_a763aa1a(v17 / 2)
			end
		end

		Sleep(0)
	end

	Sleep(1)

	if gRegion:IsMaster() then
		for i = #__wf_atom_2226b35c, 1, -1 do
			gRegion:__wf_atom_dd1e4d10(__wf_atom_2226b35c[i])
		end
	end

	module2.TaggedFirePorts(Symbol("BromiusQuestWazzardFrameNav"), "Enable")
end

local function fn()
	v5 = v4:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if #v5 > 0 and not flag then
		return true
	end

	local pointInstances = module.FindPointInstances(v4, WeakResource("/SF/Types/Game/EncounterCustomBoundsTrigger"))

	if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
		return true
	end

	print("Waiting for custom trigger...")

	while not module.ShouldShutDown(v4) or flag do
		local __wf_atom_b7c04e13 = v4:__wf_atom_b7c04e13()

		for _, pointInstance in ipairs(pointInstances) do
			if __wf_atom_7e8ad928(pointInstance) then
				return false
			end

			for _, v17 in ipairs(__wf_atom_b7c04e13) do
				if
					__wf_atom_7e8ad928(v17)
					or v17:IsKilled()
					or not pointInstance:__wf_atom_1eaf335c(v17:GetPosition())
				then
					continue
				end

				print("Custom trigger, starting enemy spawns")
				v15 = pointInstance
				return true
			end
		end

		Sleep(0.1)
	end

	return false
end

local function fn2(i, p, p2, p3, p4, p5, spawnCount)
	if #customAgentTypes > 0 then
		if __wf_atom_7e8ad928(customAgentTypes[i]) then
			return customAgentTypes[__wf_atom_5784a397(1, #customAgentTypes)]
		end

		return customAgentTypes[i]
	elseif p4 and not p5 and p3 and i == spawnCount then
		return (module.GetRandomEnemyAgentType(p2, faction, p, v4, 0, 2, true))
	else
		return (module.GetRandomEnemyAgentType(p2, faction, p, v4))
	end
end

local function fn3()
	local result = {}
	local result2 = {}
	local pointInstances = module.FindPointInstances(v4, __wf_atom_96b9d246)

	if not __wf_atom_7e8ad928(pointInstances) and #pointInstances > 0 then
		for _, pointInstance in ipairs(pointInstances) do
			local __wf_atom_dcc0a6f8 = pointInstance:__wf_atom_dcc0a6f8()

			if not (#__wf_atom_dcc0a6f8 > 0) then
				continue
			end

			table.insert(result, {
				spawnPoints = pointInstance:__wf_atom_f7c1604d(#__wf_atom_dcc0a6f8),
				spawnCount = math.min(
					module2.Round(pointInstance:__wf_atom_1d28ac91() * scaledSpawnMult[__wf_atom_421b01aa(v6, 1, #scaledSpawnMult)]),
					20
				)
			})

			for _, v17 in ipairs(__wf_atom_dcc0a6f8) do
				table.insert(result2, v17)
			end
		end
	end

	if useHintSpawns then
		local pointInstances2 = module.FindPointInstances(v4, gNpcSpawnPointType)
		result2 = module2.MergeTables(result2, pointInstances2, true)
	end

	return result, result2
end

local function fn4()
	if useFoundSpawns then
		local v17 = not module2.IsInOverworld()
		local v18

		if v17 then
			v18 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue + 1
			)
		else
			v18 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue * 1.5
			)

			for i = #v18, 1, -1 do
				if v18[i]:IsEnabled() then
					if v18[i]:__wf_atom_a5304c35(position) > overrideSpawnDistanceRange2.maxValue + 2 then
						table.remove(v18, i)
					end
				else
					table.remove(v18, i)
				end
			end
		end

		if v17 then
			local layerIndex = module2.GetLayerIndex(v4)
			module2.FilterObjectsInLayerIndex(layerIndex, v18)
		end

		local randomizeTableOrder = module2.RandomizeTableOrder(v18)
		return (module.FilterDisallowedSpawnpoints(randomizeTableOrder))
	else
		return {}
	end
end

local function fn5()
	local encounterChillout = module.GetEncounterChillout(v4)
	local v17

	if encounterChillout then
		v17 = false
	else
		v17 = module.GetEncounterBoostEnemies(v4)
	end

	local maxValue = __wf_atom_5784a397(baseSpawnCount.minValue, baseSpawnCount.maxValue)

	if encounterChillout then
		maxValue = math.ceil(maxValue * 0.5)
	elseif v17 then
		maxValue = baseSpawnCount.maxValue
	end

	if #scaledSpawnMult >= 1 then
		return module2.Round(maxValue * scaledSpawnMult[__wf_atom_421b01aa(v6, 1, #scaledSpawnMult)]), v17
	end

	return maxValue, v17
end

local function fn6(list)
	local v17

	if not (limitOvercrowdingRadius > 0) then
		return v17
	end

	local __wf_atom_e0730826 = v3:__wf_atom_e0730826(v4, limitOvercrowdingRadius, false)
	v17 = 0

	for _, v18 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v18:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_e93896ba() ~= faction
		then
			continue
		end

		v17 -= 1
	end

	for _, v18 in ipairs(list) do
		v17 += v18.spawnCount
	end

	return v17
end

local function fn7()
	if not canSpawnGrunts then
		return
	end

	v5 = v4:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if #v5 > 0 then
		return
	end

	v6 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v17, v18 = fn3()
	local v19 = fn4()
	local mergeTables = module2.MergeTables(v18, v19, true)
	local spawnCount2, v20 = fn5()

	if #v17 == 0 then
		table.insert(v17, { spawnPoints = mergeTables, spawnCount = spawnCount2 })
	end

	local questEnemyLevelRangeOveride2

	if
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module5.HasCompletedQuest(questRef) and not module5.QuestIsActive(questRef)
	then
		questEnemyLevelRangeOveride2 = module.GetEnemyLevel(v4)
	else
		questEnemyLevelRangeOveride2 = questEnemyLevelRangeOveride
	end

	local v21 = fn6(v17)

	if not __wf_atom_7e8ad928(v21) and v21 <= 0 then
		print("Enemy cap is <= 0")
		return
	end

	local v22 = v4:__wf_atom_2b1fe281() % 100
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v23 = false
	local count = 0

	for i, v24 in ipairs(v17) do
		local spawnPoints = v24.spawnPoints
		local spawnCount = v24.spawnCount
		local v25 = Range(0.05, 0.15)
		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
			position,
			overrideSpawnDistanceRange2,
			spawnCount
		)

		for j = 1, spawnCount do
			local v26

			if not (__wf_atom_7e8ad928(spawnPoints) or not (#spawnPoints > 0)) then
				v26 = spawnPoints[1]
			end

			local v27 = __wf_atom_5784a397(questEnemyLevelRangeOveride2.minValue, questEnemyLevelRangeOveride2.maxValue)
			local v28 = fn2(j, v27, v26, i == #v17, v20, v23, spawnCount)
			local v29

			if not __wf_atom_7e8ad928(v28) then
				if __wf_atom_7e8ad928(v26) then
					local randomPointInRangeOnNav

					if #randomSpawnsOnNavInRange > 0 then
						randomPointInRangeOnNav = randomSpawnsOnNavInRange[#randomSpawnsOnNavInRange]
						table.remove(randomSpawnsOnNavInRange, #randomSpawnsOnNavInRange)
					else
						randomPointInRangeOnNav = v3:GetRandomPointInRangeOnNav(
							position,
							math.max(overrideSpawnDistanceRange2.minValue, 2),
							overrideSpawnDistanceRange2.maxValue,
							true,
							0.5
						)
					end

					local v30 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

					if spawnAlert then
						local nearestObject = module2.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf)

						if not __wf_atom_7e8ad928(nearestObject) then
							v30 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
						end
					end

					v29 = v3:__wf_atom_402b3832(v28, randomPointInRangeOnNav, v30, v2, v27)
				else
					local __wf_atom_66a525a6 = v26:__wf_atom_66a525a6()

					if __wf_atom_66a525a6 > 0 then
						v27 = __wf_atom_66a525a6
					end

					v29 = v3:CreateAgent(v28, v26, v2, v27)
					table.remove(spawnPoints, 1)
				end

				if module.IsHeavyAgent(v29) then
					v23 = true
				end
			end

			if __wf_atom_7e8ad928(v29) then
				print("Failed to spawn agent")
			else
				v4:__wf_atom_97f955c1(v29)

				if shouldFadeInAgents then
					v29:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("FadeIn"), false)
				end

				if not v7 then
					v7 = module.IsHeavyAgent(v29)
				end

				count += 1
				local __wf_atom_50a7d83e = v29:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and spawnAlert then
					v29:__wf_atom_30b587a4()
					local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()
					local nearestObject = module2.NearestObject(__wf_atom_50a7d83e:GetPosition(), __wf_atom_ef7900cf2)

					if not __wf_atom_7e8ad928(nearestObject) then
						v29:StormTarget(nearestObject)
					end
				end

				if v22 > 0 and v22 <= count then
					print("Restored up to previous enemy count")
					return
				end

				if not __wf_atom_7e8ad928(v21) and v21 <= count then
					print("Spawn cap reached")
					return
				end
			end

			if j < spawnCount2 then
				Sleep(__wf_atom_104bfe98(v25.minValue, v25.maxValue, math.random()))
			end

			if module.ShouldShutDown(v4) and not flag then
				return
			end
		end
	end
end

function DeactivateAbilities()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v17 in __wf_atom_3c8e1a7a do
		if __wf_atom_7e8ad928(v17) then
			continue
		end

		local playerAvatar = v17:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_2ffcdee6()
		end
	end
end

local function fn8()
	print("Spawning Medicant")
	_T.WazardCinematicPlayed = false

	if __wf_atom_7e8ad928(bossAgentType) or not canSpawnBoss or __wf_atom_7e8ad928(v4) then
		return
	end

	local position2 = v14:GetPosition()
	local __wf_atom_dc309f8a = v14:__wf_atom_dc309f8a()
	local bossLevelOverride2

	if bossLevelOverride > 0 then
		bossLevelOverride2 = bossLevelOverride
	elseif
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module5.HasCompletedQuest(questRef) and not module5.QuestIsActive(questRef)
	then
		local enemyLevel = module.GetEnemyLevel(v4)
		bossLevelOverride2 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	else
		bossLevelOverride2 = questEnemyLevelRangeOveride
	end

	v9 = v3:__wf_atom_402b3832(
		bossAgentType,
		position2,
		__wf_atom_dc309f8a,
		module.DEFAULT_TEAM,
		bossLevelOverride2,
		nil
	)

	if __wf_atom_7e8ad928(v9) then
		return false
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Mendicant Wazzard Encounter"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v9:__wf_atom_243da0d3(__wf_atom_0a6a5887, true)
	end

	v9:__wf_atom_6c491aa2(startingGuardBehavior, false)
	v9:__wf_atom_f54283ea()
	v4:__wf_atom_97f955c1(v9)
	v10 = v9:__wf_atom_50a7d83e()

	if shouldFadeInAgents then
		FadeIn(v10)
	end

	v11 = module2.FindTaggedChild(v10:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

	if __wf_atom_7e8ad928(v11) then
		v11 = v10:Attach(
			Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
			Symbol("GAME_C1_SPINE1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	v10:__wf_atom_7c8621d6()
	v10:SetVisibility(false)
	module2.SetImmunity(v10, true)

	if bossName ~= "" then
		v10:__wf_atom_5cb037b2(Symbol(bossName))
	end

	if __wf_atom_7e8ad928(v10) or v10:IsKilled() or v10:__wf_atom_bedb4e3f() then
		_T.WazardCinematicPlayed = true
	else
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WazardSpawnCin"))

		if flag then
			local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WazzardPowerRemoval"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
				__wf_atom_0a6a5887_3:FirePort("Execute")
			end

			v14:Destroy()
			v10:SetVisibility(true)

			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_920a5a62()
			end

			_T.WazardCinematicPlayed = true
		elseif not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():Unequip(0, 2)
			__wf_atom_0a6a5887_2:Teleport(module4.GetGroundPos(v15:GetPosition()), v15:__wf_atom_dc309f8a())
			DeactivateAbilities()
			Sleep(0)
			module2.TaggedFirePorts(Symbol("WazzardDecosTrigger"), "TriggerPort")
			Sleep(0)

			if not __wf_atom_7e8ad928(wazardDissolveDecoTrigger) then
				gRegion:CreateEntity(wazardDissolveDecoTrigger, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
			end

			v14:Destroy()
			v10:SetVisibility(true)

			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_920a5a62()
			end

			module2.PlayCinematicWithTagAndWait(Symbol("WazardSpawnCin"))
			_T.WazardCinematicPlayed = true
		end
	end

	while v10:__wf_atom_c138b19b(spawnAnimation, false) do
		Sleep(0)
	end

	module2.SetImmunity(v10, false)
	v10:SetVisibility(true)

	if not __wf_atom_7e8ad928(v11) then
		v11:Enable()
		v11:__wf_atom_400189c4(bossBarActivationRadius)
	end
end

function FadeIn(object)
	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(true, true)
	end

	local fadeInDuration2 = fadeInDuration

	while fadeInDuration2 >= 0 and not __wf_atom_7e8ad928(object) do
		fadeInDuration2 -= __wf_atom_084b3e93()
		object:__wf_atom_a763aa1a(__wf_atom_421b01aa(fadeInDuration2 / fadeInDuration, 0, 1))
		Sleep(0)
	end
end

function GiveLoreDrop(p, p2, p3)
	if not __wf_atom_7e8ad928(p2) then
		if p3 == EMPTY_SYMBOL then
			module2.GiveLoreFragment(p2, p)
		else
			module2.GiveLoreFragmentMemory(p2, p, p3)
		end
	end
end

function EnableBlightZoneRespawning()
	v = gRegion:__wf_atom_0a6a5887(disabledShrineTag)

	if __wf_atom_7e8ad928(v) then
		print("Blighted Zone did not activate, Normal respawning enabled")
		return
	end

	module8.ActivateBlightZone(v, useBlightSpawning, true, false, ResetFight)
	print("Blighted Zone active")
end

function DisableBlightZoneRespawning()
	module8.DeactivateBlightZone(true)
end

local function fn9()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MendicantWazardSpawn"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887 = v4
	end

	local groundPos = module4.GetGroundPos(__wf_atom_0a6a5887:GetPosition())

	if not __wf_atom_7e8ad928(mendicantWazardDeco) then
		local groundAlignedSpawnPosRot, _ = module4.GetGroundAlignedSpawnPosRot(
			mendicantWazardDeco,
			groundPos,
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		v14 = gRegion:CreateEntity(
			mendicantWazardDeco,
			groundAlignedSpawnPosRot,
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		v4:__wf_atom_d494454b(v14)
	end
end

local function fn10(object)
	v3 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v12 = object:__wf_atom_26b04ea9()
	v13 = object:__wf_atom_dd85e6db()
	v4 = object

	if shouldWaitForParentHint then
		v4:__wf_atom_8e6fec76(1)

		if module.WaitForParentEncounterActive(object) then
			while not __wf_atom_7e8ad928(v12) and v12:__wf_atom_4026dfb5() == 1 do
				Sleep(0)
			end
		else
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8e6fec76(6)
			end

			return
		end
	end

	position = object:GetPosition()
	overrideSpawnDistanceRange2 = Range(0, object:__wf_atom_103377cc())
	local all = gRegion:FindAll(bossAgentType:__wf_atom_c6772fb4())

	if #all > 0 then
		if flag then
			v10 = all[1]
			v10:Destroy()
		else
			v10 = all[1]
			v9 = v10:__wf_atom_30e3d82b()
			v11 = module2.FindTaggedChild(v10:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

			if __wf_atom_7e8ad928(v11) then
				v11 = v10:Attach(
					Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
					Symbol("GAME_C1_SPINE1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)
			end

			if not __wf_atom_7e8ad928(v11) then
				v11:Enable()
				v11:__wf_atom_400189c4(bossBarActivationRadius)
			end

			v4:__wf_atom_2cc8420c(v4:__wf_atom_dd85e6db())
			return true
		end
	end

	if overrideSpawnDistanceRange.minValue > 0 and overrideSpawnDistanceRange.maxValue > 0 then
		overrideSpawnDistanceRange2 = overrideSpawnDistanceRange
	end

	fn9()

	if not fn() then
		print("Shutdown due to level streaming")
		return false
	end

	if checkTODbeforeSpawning then
		while module6.IsDaytime() and not (module.ShouldShutDown(v4) or flag) do
			Sleep(5)
		end
	end

	if shouldEnableBlightedZone and __wf_atom_7e8ad928(_T.BlightZoneRespawning) and not _T.BlightZoneRespawning then
		EnableBlightZoneRespawning()
	end

	fn8()
	fn7()
	Sleep(0)

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return false
	end

	v4:__wf_atom_2cc8420c(v4:__wf_atom_dd85e6db())
	return true
end

local function fn11()
	v4:__wf_atom_4026dfb5()
	_T.SeedRecovered = false
	local flag2 = false

	while not module.ShouldShutDown(v4) or flag do
		v5 = v4:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v4, v5)
		module8.UpdateBlightZone()

		if alertAllOnCombat and not flag2 then
			for _, v17 in ipairs(v5) do
				if not v17:__wf_atom_04ea4887() then
					continue
				end

				flag2 = true
				break
			end

			if flag2 then
				for _, v17 in ipairs(v5) do
					v17:__wf_atom_30b587a4()

					if guardRadiusWhenAllAlerted > 0 then
						v17:__wf_atom_03cc4f3c(v8, position, guardRadiusWhenAllAlerted)
					end
				end
			end
		end

		if not __wf_atom_7e8ad928(v10) and not __wf_atom_7e8ad928(v11) and v10:__wf_atom_bedb4e3f() then
			_T.WazzardPreDeath = true
			v11:Disable()

			if gRegion:IsMaster() then
				for i = 1, #v16 do
					if
						__wf_atom_7e8ad928(v16[i])
						or not v16[i]:__wf_atom_bedb4e3f()
						or __wf_atom_7e8ad928((v16[i]:__wf_atom_a96eb2aa()))
					then
						continue
					end

					v16[i]:InstantRevive()
				end
			end
		end

		if __wf_atom_7e8ad928(v10) or v10:IsKilled() then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SeedSongAction"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Enable()
			end

			v4:__wf_atom_8e6fec76(4)
			break
		else
			Sleep(1)
		end
	end

	if v4:__wf_atom_4026dfb5() == 4 then
		if shouldEnableBlightedZone then
			DisableBlightZoneRespawning()
		end

		if not __wf_atom_7e8ad928(loreDrop) and gRegion:IsMaster() then
			local __wf_atom_b7c04e13 = v4:__wf_atom_b7c04e13()

			for _, v17 in ipairs(__wf_atom_b7c04e13) do
				GiveLoreDrop(loreDrop, v17, loreMemeorySymbol)
			end
		end

		if firePostFightPorts then
			for _, v17 in ipairs(postFightPorts) do
				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v17, v4:GetPosition(), 0, 100)
				Sleep(delay)
				__wf_atom_f738b4af:FirePort("TriggerPort")
			end
		end
	end
end

local function fn12()
	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return
	end

	if v4:__wf_atom_3634e6d2() == 0 then
		v4:__wf_atom_050639fe()
		v4:__wf_atom_8776856a(0)
		v4:__wf_atom_8e6fec76(4)

		if module2.IsInOverworld() then
			while not __wf_atom_7e8ad928(v4) and v4:__wf_atom_e464a32f() > 0 and v3:__wf_atom_c6f505f2(v4) > 0 do
				Sleep(0)
			end
		else
			v4:Disable()
		end
	else
		local v17 = #v5
		v4:__wf_atom_8776856a(v17)
		v4:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return
	end

	if shouldEnableBlightedZone then
		DisableBlightZoneRespawning()
	end

	_T.WazzardPreDeath = nil
	module.RemoveAgents(v4)
	module.RemoveObjects(v4)
	Sleep(0)
end

function ResetFight()
	print("Reset wazzard Fight")
	flag = true

	if not (__wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v11)) then
		v11:Disable()
	end

	module3.CloseTransmissions()
	v16 = v4:__wf_atom_b7c04e13()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v17 = false

	while not v17 do
		v17 = true

		for i = 1, #__wf_atom_3c8e1a7a do
			local flag2 = false

			for j = 1, #v16 do
				if
					__wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i])
					or __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e() ~= v16[j]
				then
					continue
				end

				flag2 = true
				break
			end

			if not flag2 then
				continue
			end

			v17 = false
			break
		end

		Sleep(0.2)
	end

	module8.RefillHealthPotions(5)
	Sleep(1)
	fn10(v4)
	fn11()
	flag = false
end

function StartCombatEncounter(object)
	print("---- Starting wazard encounter ----")
	v4 = object

	if not fn10(object) then
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn11()
	fn12()
end

function StartSimpleMiniBossEncounter(object)
	if not fn10(object) then
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn11()
	fn12()
end

function RecoverSeed(instance, recoverSeedInstigatorAvatar)
	if __wf_atom_7e8ad928(recoverSeedInstigatorAvatar) then
		return
	end

	if gRegion:IsMaster() then
		recoverSeedInstigatorAvatar:__wf_atom_d2b2176d():Unequip(0, 2)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GetSeedCinematic"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WazardTreeContextFx"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.recoverSeedInstigatorAvatar = recoverSeedInstigatorAvatar
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("AcornDeco"))
		__wf_atom_0a6a5887:__wf_atom_a3d2b66b(__wf_atom_0a6a5887_3, Symbol("CouncilAcorn"))
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WazardTreeDeco"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
			local __wf_atom_bb3e7833 = __wf_atom_0a6a5887_4:__wf_atom_bb3e7833(WeakResource("/SF/Fx/Cinematics/WazzardFight/AcornAttachFlare"))

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:SetVisibility(false, false)
			end
		end

		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("SeedSongWaypoint"))
		__wf_atom_0a6a5887_3:SetVisibility(false, false)

		if __wf_atom_0a6a5887_5 == nil then
			__wf_atom_0a6a5887:Teleport(instance:GetPosition(), recoverSeedInstigatorAvatar:__wf_atom_dc309f8a())
		else
			__wf_atom_0a6a5887:Teleport(__wf_atom_0a6a5887_5:GetPosition(), __wf_atom_0a6a5887_5:__wf_atom_dc309f8a())
		end

		if gRegion:IsMaster() then
			__wf_atom_0a6a5887:SetInstigatorAvatar(recoverSeedInstigatorAvatar)
			__wf_atom_0a6a5887:FirePort("StartPlaying")
		end

		__wf_atom_0a6a5887:__wf_atom_239dd8f4()
	end

	if instance:IsA(__wf_atom_8b8e8b22) then
		instance:Disable()
	end

	local total = 0

	while not (__wf_atom_7e8ad928(recoverSeedInstigatorAvatar) or recoverSeedInstigatorAvatar:__wf_atom_0473b7a9()) do
		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:__wf_atom_a763aa1a((math.min(total / 2, 1)))
			total += __wf_atom_03df4e1d()
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:__wf_atom_a763aa1a(1)
	end

	while not __wf_atom_7e8ad928(recoverSeedInstigatorAvatar) and recoverSeedInstigatorAvatar:__wf_atom_0473b7a9() do
		Sleep(0)
	end

	if recoverSeedInstigatorAvatar:__wf_atom_8161e6ba().mSuccess or not gRegion:IsMaster() then
		_T.SeedRecovered = true
	else
		instance:Enable()
	end
end

function AvatarPlayInstrument(p)
	module7.AvatarPlayInstrument(p, "SaveDeoraSoulCin", instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end

function GrabAcorn(_, object)
	object:SetVisibility(true, true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WazardTreeDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(false, true)
	end
end

function DestroyWazzard(_, instance)
	instance:Destroy()
end

function TreeCinFinished(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WazardTreeDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_0a6a5887)
	end
end

function TreeCinBegin(object)
	while object:__wf_atom_1ee2a2df() < cinRangeLoop.minValue do
		Sleep(0)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v17 = __wf_atom_e919fb8e.recoverSeedInstigatorAvatar == __wf_atom_c4f78a8f

	if v17 then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(timingActionMovie)
	end

	Sleep(0.5)
	object:__wf_atom_01142e3f(object:__wf_atom_1ee2a2df())

	while not _T.SeedRecovered and (gRegion:IsMaster() or v17) do
		Sleep(0)
	end

	object:__wf_atom_01142e3f(-1)
end

function BanishWazzardFade(_)
	module2.Fade(true, 1, -1, true)
end

function TeleportToCouncil(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-NethunsWarp"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local position2 = __wf_atom_0a6a5887:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
		local __wf_atom_c6290621 = object:__wf_atom_c6290621()
		local v17 = Symbol("Envoy")
		local v18 = nil

		for _, v19 in ipairs(__wf_atom_c6290621) do
			if __wf_atom_7e8ad928(v19) or v19:__wf_atom_12695c30() ~= v17 then
				continue
			end

			position2 = v19:__wf_atom_0d7d47e6(position2)
			v18 = v19
			break
		end

		local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()
		object:__wf_atom_d6890e9c(true)
		object:Teleport(position2, __wf_atom_dc309f8a)

		for _, v19 in ipairs(__wf_atom_a8553251) do
			if v19 ~= v18 then
				v19:Teleport(position2, __wf_atom_dc309f8a)
			end
		end
	end

	module2.Fade(false, 1, -1, true)
	Sleep(4)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local v17 = Localize("/SF/Language/Quests/Wevetseed", {})
		__wf_atom_eab484a7:__wf_atom_330f77f5():AddLogMessage(v17, "\"Icon\":" .. wevetSeedIcon:__wf_atom_5b41f63b(), 3)
	end
end