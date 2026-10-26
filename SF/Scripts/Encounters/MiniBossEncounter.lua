local v = nil
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("SF.Scripts.Libs.RespawnLib")
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

local function fn()
	local v14 = WeakResource("/SF/Types/PickUps/LootContainers/LootChestBase")
	local __wf_atom_2b1fe281 = v4:__wf_atom_2b1fe281()
	local v15 = (__wf_atom_2b1fe281 - __wf_atom_2b1fe281 % 100) / 100
	local __wf_atom_fe00d825 = v4:__wf_atom_fe00d825()

	for _, v16 in ipairs(__wf_atom_fe00d825) do
		if not (v16:IsA(v14) and __wf_atom_7e8ad928(v16:__wf_atom_bb3e7833(__wf_atom_0f45538d))) then
			continue
		end

		v15 += 1
	end

	local v16 = v15 * 100 + #v5
	v4:__wf_atom_8776856a(v16)
end

local function fn2()
	v5 = v4:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if #v5 > 0 then
		return true
	end

	local pointInstances = module.FindPointInstances(v4, WeakResource("/SF/Types/Game/EncounterCustomBoundsTrigger"))

	if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
		return true
	end

	print("Waiting for custom trigger...")

	while not module.ShouldShutDown(v4) do
		local __wf_atom_b7c04e13 = v4:__wf_atom_b7c04e13()

		for _, pointInstance in ipairs(pointInstances) do
			if __wf_atom_7e8ad928(pointInstance) then
				return false
			end

			for _, v14 in ipairs(__wf_atom_b7c04e13) do
				if
					__wf_atom_7e8ad928(v14)
					or v14:IsKilled()
					or not pointInstance:__wf_atom_1eaf335c(v14:GetPosition())
				then
					continue
				end

				print("Custom trigger, starting enemy spawns")
				return true
			end
		end

		Sleep(0.1)
	end

	return false
end

local function fn3()
	if v4:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL then
		return
	end

	if #trapTypes > 0 and trapChance > 0 and math.random() <= trapChance then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			trapSpawnTag,
			position,
			trapSpawnDistanceFromHint.minValue,
			trapSpawnDistanceFromHint.maxValue
		)
		local v14 = math.min(__wf_atom_5784a397(numTraps.minValue, numTraps.maxValue), #__wf_atom_439c0d29)

		if v14 > 0 then
			for _ = 1, v14 do
				local v15 = __wf_atom_5784a397(1, #__wf_atom_439c0d29)
				local v16 = __wf_atom_439c0d29[v15]
				local trapType = trapTypes[__wf_atom_5784a397(1, #trapTypes)]
				local entity = gRegion:CreateEntity(
					trapType,
					v16:GetPosition(),
					Rotation(__wf_atom_5784a397(0, 360), 0, 0)
				)
				v4:__wf_atom_d494454b(entity)
				v16:FirePort("Disable")
				table.remove(__wf_atom_439c0d29, v15)
			end
		end
	end
end

local function fn4()
	if not module2.IsInOverworld() or v4:__wf_atom_e464a32f() > 0 then
		return
	end

	local v14 = __wf_atom_5784a397(numChestsToSpawn.minValue, numChestsToSpawn.maxValue)
	local __wf_atom_2b1fe281 = v4:__wf_atom_2b1fe281()
	local v15 = v14 - (__wf_atom_2b1fe281 - __wf_atom_2b1fe281 % 100) / 100

	if v15 <= 0 then
		return
	end

	local v16 = Range(5, (math.max(v4:__wf_atom_103377cc() + 5, 15)))
	local encounterLootSpawns = module.GetEncounterLootSpawns(position, v16, v15, true, false, true, 5)

	for i = 1, math.min(v15, #encounterLootSpawns) do
		local chestTypeRare2

		if v7 and i == 1 and not __wf_atom_7e8ad928(chestTypeRare) then
			chestTypeRare2 = chestTypeRare
		elseif __wf_atom_7e8ad928(chestTypeRare) or not (rareChestChance > 0 and math.random() <= rareChestChance) then
			if
				__wf_atom_7e8ad928(chestTypeUncommon)
				or not (uncommonChestChance > 0 and math.random() <= uncommonChestChance + rareChestChance)
			then
				chestTypeRare2 = chestTypeCommon
			else
				chestTypeRare2 = chestTypeUncommon
			end
		else
			chestTypeRare2 = chestTypeRare
		end

		local v17 = __wf_atom_5784a397(1, #encounterLootSpawns)
		local pos = encounterLootSpawns[v17].pos
		local rot = encounterLootSpawns[v17].rot

		if __wf_atom_7e8ad928(encounterLootSpawns[v17].spawnPt) then
			pos, rot = module3.GetGroundAlignedSpawnPosRot(
				chestTypeRare2,
				encounterLootSpawns[v17].pos,
				encounterLootSpawns[v17].rot,
				false,
				30
			)
		end

		if __wf_atom_7e8ad928(pos) then
			continue
		end

		local lootContainer = module.SpawnLootContainer(chestTypeRare2, pos, rot, true, v4)
		table.remove(encounterLootSpawns, v17)
		v4:__wf_atom_d494454b(lootContainer)
	end
end

local function fn5(i, p, p2, p3, p4, p5, p6, spawnCount)
	if useSquadLists then
		return (module.GetRandomEnemyAgentType(
			nil,
			faction,
			p,
			v4,
			p2[i].agentSpec.archetype,
			p2[i].agentSpec.rank,
			p2[i].agentSpec.exclusiveRank
		))
	end

	if #customAgentTypes > 0 then
		if __wf_atom_7e8ad928(customAgentTypes[i]) then
			return customAgentTypes[__wf_atom_5784a397(1, #customAgentTypes)]
		end

		return customAgentTypes[i]
	elseif p5 and not p6 and p4 and i == spawnCount then
		return (module.GetRandomEnemyAgentType(p3, faction, p, v4, 0, 2, true))
	else
		return (module.GetRandomEnemyAgentType(p3, faction, p, v4))
	end
end

local function fn6()
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

			for _, v14 in ipairs(__wf_atom_dcc0a6f8) do
				table.insert(result2, v14)
			end
		end
	end

	if useHintSpawns then
		local pointInstances2 = module.FindPointInstances(v4, gNpcSpawnPointType)
		result2 = module2.MergeTables(result2, pointInstances2, true)
	end

	return result, result2
end

local function fn7()
	if useFoundSpawns then
		local v14 = not module2.IsInOverworld()
		local v15

		if v14 then
			v15 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue + 1
			)
		else
			v15 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue * 1.5
			)

			for i = #v15, 1, -1 do
				if v15[i]:IsEnabled() then
					if v15[i]:__wf_atom_a5304c35(position) > overrideSpawnDistanceRange2.maxValue + 2 then
						table.remove(v15, i)
					end
				else
					table.remove(v15, i)
				end
			end
		end

		if v14 then
			local layerIndex = module2.GetLayerIndex(v4)
			module2.FilterObjectsInLayerIndex(layerIndex, v15)
		end

		local randomizeTableOrder = module2.RandomizeTableOrder(v15)
		return (module.FilterDisallowedSpawnpoints(randomizeTableOrder))
	else
		return {}
	end
end

local function fn8()
	local v14 = nil
	local v15 = nil
	local encounterChillout = module.GetEncounterChillout(v4)
	local v16

	if encounterChillout then
		v16 = false
	else
		v16 = module.GetEncounterBoostEnemies(v4)
	end

	if useSquadLists and #customSquadLists > 0 then
		v6 = __wf_atom_421b01aa(v6, 1, #customSquadLists)

		for i = v6, 1, -1 do
			if __wf_atom_7e8ad928(customSquadLists[i]) then
				continue
			end

			local randomSquad = customSquadLists[i]:GetRandomSquad()

			if __wf_atom_7e8ad928(randomSquad) then
				continue
			end

			local __wf_atom_c6d95510 = randomSquad:__wf_atom_c6d95510()
			return #__wf_atom_c6d95510, __wf_atom_c6d95510, v16
		end

		return v14, v15, v16
	else
		local maxValue = __wf_atom_5784a397(baseSpawnCount.minValue, baseSpawnCount.maxValue)

		if encounterChillout then
			maxValue = math.ceil(maxValue * 0.5)
		elseif v16 then
			maxValue = baseSpawnCount.maxValue
		end

		if #scaledSpawnMult >= 1 then
			return module2.Round(maxValue * scaledSpawnMult[__wf_atom_421b01aa(v6, 1, #scaledSpawnMult)]), v15, v16
		end

		return maxValue, v15, v16
	end
end

local function fn9(list)
	local v14

	if not (limitOvercrowdingRadius > 0) then
		return v14
	end

	local __wf_atom_e0730826 = v3:__wf_atom_e0730826(v4, limitOvercrowdingRadius, false)
	v14 = 0

	for _, v15 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v15:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_e93896ba() ~= faction
		then
			continue
		end

		v14 -= 1
	end

	for _, v15 in ipairs(list) do
		v14 += v15.spawnCount
	end

	return v14
end

local function fn10()
	if not canSpawnGrunts then
		return
	end

	v5 = v4:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if #v5 > 1 then
		return
	end

	v6 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v14, v15 = fn6()
	local v16 = fn7()
	local mergeTables = module2.MergeTables(v15, v16, true)
	local spawnCount2, v17, v18 = fn8()

	if #v14 == 0 then
		table.insert(v14, { spawnPoints = mergeTables, spawnCount = spawnCount2 })
	end

	local questEnemyLevelRangeOveride2

	if
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module4.HasCompletedQuest(questRef) and not module4.QuestIsActive(questRef)
	then
		questEnemyLevelRangeOveride2 = module.GetEnemyLevel(v4)
	else
		questEnemyLevelRangeOveride2 = questEnemyLevelRangeOveride
	end

	local v19 = fn9(v14)

	if not __wf_atom_7e8ad928(v19) and v19 <= 0 then
		print("Enemy cap is <= 0")
		return
	end

	local v20 = v4:__wf_atom_2b1fe281() % 100
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v21 = false
	local count = 0

	for i, v22 in ipairs(v14) do
		local spawnPoints = v22.spawnPoints
		local spawnCount = v22.spawnCount
		local v23 = Range(0.05, 0.15)
		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
			position,
			overrideSpawnDistanceRange2,
			spawnCount
		)

		for j = 1, spawnCount do
			local v24

			if not (__wf_atom_7e8ad928(spawnPoints) or not (#spawnPoints > 0)) then
				v24 = spawnPoints[1]
			end

			local v25 = __wf_atom_5784a397(questEnemyLevelRangeOveride2.minValue, questEnemyLevelRangeOveride2.maxValue)
			local v26 = fn5(j, v25, v17, v24, i == #v14, v18, v21, spawnCount)
			local v27

			if not __wf_atom_7e8ad928(v26) then
				if __wf_atom_7e8ad928(v24) then
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

					local v28 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

					if spawnAlert then
						local nearestObject = module2.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf)

						if not __wf_atom_7e8ad928(nearestObject) then
							v28 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
						end
					end

					v27 = v3:__wf_atom_402b3832(v26, randomPointInRangeOnNav, v28, v2, v25)
				else
					local __wf_atom_66a525a6 = v24:__wf_atom_66a525a6()

					if __wf_atom_66a525a6 > 0 then
						v25 = __wf_atom_66a525a6
					end

					v27 = v3:CreateAgent(v26, v24, v2, v25)
					table.remove(spawnPoints, 1)
				end

				if module.IsHeavyAgent(v27) then
					v21 = true
				end
			end

			if __wf_atom_7e8ad928(v27) then
				print("Failed to spawn agent")
			else
				v4:__wf_atom_97f955c1(v27)

				if shouldFadeInAgents then
					v27:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("FadeIn"), false)
				end

				if not v7 then
					v7 = module.IsHeavyAgent(v27)
				end

				count += 1
				local __wf_atom_50a7d83e = v27:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and spawnAlert then
					v27:__wf_atom_30b587a4()
					local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()
					local nearestObject = module2.NearestObject(__wf_atom_50a7d83e:GetPosition(), __wf_atom_ef7900cf2)

					if not __wf_atom_7e8ad928(nearestObject) then
						v27:StormTarget(nearestObject)
					end
				end

				if v20 > 0 and v20 <= count then
					print("Restored up to previous enemy count")
					return
				end

				if not __wf_atom_7e8ad928(v19) and v19 <= count then
					print("Spawn cap reached")
					return
				end
			end

			if j < spawnCount2 then
				Sleep(__wf_atom_104bfe98(v23.minValue, v23.maxValue, math.random()))
			end

			if module.ShouldShutDown(v4) then
				return
			end
		end
	end
end

local function fn11()
	if
		__wf_atom_7e8ad928(bossAgentType)
		or not canSpawnBoss
		or __wf_atom_7e8ad928(v4)
		or v4:GetNumRegisteredAgentsOfType(bossAgentType) > 0
	then
		return
	end

	local position2 = v4:GetPosition()
	local __wf_atom_dc309f8a = v4:__wf_atom_dc309f8a()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(bossSpawnPointTag, v4:GetPosition(), 0, 20)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		position2 = __wf_atom_f738b4af:GetPosition()
		__wf_atom_dc309f8a = __wf_atom_f738b4af:__wf_atom_dc309f8a()
	end

	local bossLevelOverride2

	if bossLevelOverride > 0 then
		bossLevelOverride2 = bossLevelOverride
	elseif
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module4.HasCompletedQuest(questRef) and not module4.QuestIsActive(questRef)
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

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:Disable()
	end

	if __wf_atom_7e8ad928(v9) then
		return false
	end

	if randomPatrol then
		v9:__wf_atom_5a0e15fd(Symbol("RandomPatrol"), 1)
	end

	if forcePoi then
		v9:__wf_atom_5a0e15fd(Symbol("ForcePoi"), 1)
	end

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
	v10:__wf_atom_5cb037b2(Symbol(bossName))

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

local function fn12(p)
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(dropTable) then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local enemyLevel = module.GetEnemyLevel(p)
		local v14 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		dropTable:__wf_atom_0ad20b11(p, p, __wf_atom_e93896ba, v14)
		_T.idleTimoutReset = true
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

	if not __wf_atom_7e8ad928(v) then
		module6.ActivateBlightZone(v, useBlightSpawning, useSpectatorMode, false, nil)
	end
end

function DisableBlightZoneRespawning()
	module6.DeactivateBlightZone(true)
end

local function fn13(object)
	v3 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v12 = object:__wf_atom_26b04ea9() or object
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

	if __wf_atom_7e8ad928(v12) then
		return false
	end

	position = v12:GetPosition()
	overrideSpawnDistanceRange2 = Range(0, v12:__wf_atom_103377cc())

	if removeParentChestSpawns then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("LootChest"), position, 0, 30)

		for i = 1, #__wf_atom_439c0d29 do
			__wf_atom_439c0d29[i]:Destroy()
		end
	end

	if overrideSpawnDistanceRange.minValue > 0 and overrideSpawnDistanceRange.maxValue > 0 then
		overrideSpawnDistanceRange2 = overrideSpawnDistanceRange
	end

	if not fn2() then
		print("Shutdown due to level streaming")
		return false
	end

	if checkTODbeforeSpawning then
		while module5.IsDaytime() and not module.ShouldShutDown(v4) do
			Sleep(5)
		end
	end

	if shouldEnableBlightedZone then
		EnableBlightZoneRespawning()
	end

	fn11()
	fn10()
	Sleep(0)

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return false
	end

	v4:__wf_atom_2cc8420c(v4:__wf_atom_dd85e6db())
	return true
end

local function fn14()
	v4:__wf_atom_4026dfb5()
	local flag = false

	while not module.ShouldShutDown(v4) do
		v5 = v4:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v4, v5)

		if alertAllOnCombat and not flag then
			for _, v14 in ipairs(v5) do
				if not v14:__wf_atom_04ea4887() then
					continue
				end

				flag = true
				break
			end

			if flag then
				for _, v14 in ipairs(v5) do
					v14:__wf_atom_30b587a4()

					if guardRadiusWhenAllAlerted > 0 then
						v14:__wf_atom_03cc4f3c(v8, position, guardRadiusWhenAllAlerted)
					end
				end
			end
		end

		if __wf_atom_7e8ad928(v10) then
			v4:__wf_atom_8e6fec76(4)
			break
		end

		if v10:IsKilled() then
			v4:__wf_atom_8e6fec76(4)
			break
		else
			Sleep(1)
		end
	end

	if __wf_atom_7e8ad928(v4) then
		return
	end

	if v4:__wf_atom_4026dfb5() == 4 then
		if giveDirectReward and not __wf_atom_7e8ad928(dropTable) then
			local __wf_atom_b7c04e13 = v4:__wf_atom_b7c04e13()

			for _, v14 in ipairs(__wf_atom_b7c04e13) do
				fn12(v14)
			end
		end

		if not __wf_atom_7e8ad928(loreDrop) and gRegion:IsMaster() then
			local __wf_atom_b7c04e13 = v4:__wf_atom_b7c04e13()

			for _, v14 in ipairs(__wf_atom_b7c04e13) do
				GiveLoreDrop(loreDrop, v14, loreMemeorySymbol)
			end
		end

		if firePostFightPorts then
			for _, v14 in ipairs(postFightPorts) do
				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v14, v4:GetPosition(), 0, 100)
				Sleep(delay)
				__wf_atom_f738b4af:FirePort("TriggerPort")
			end
		end
	end
end

local function fn15()
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
		fn()
		v4:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return
	end

	if shouldEnableBlightedZone then
		DisableBlightZoneRespawning()
	end

	module.RemoveAgents(v4)
	module.RemoveObjects(v4)
	Sleep(0)
end

function StartCombatEncounter(object)
	if not fn13(object) then
		return
	end

	fn4()
	fn3()
	object:__wf_atom_8e6fec76(2)
	fn14()
	fn15()
end

function StartSimpleMiniBossEncounter(object)
	if not fn13(object) then
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn14()
	fn15()
end