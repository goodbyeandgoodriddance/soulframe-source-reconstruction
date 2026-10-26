local v = Symbol("Guard")
local v2 = { STARTUP = 0, SPAWNED = 1, KILLED = 2 }
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module7 = require("SF.Scripts.Libs.TaleLib")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local flag = false
local v8 = nil
local position = nil
local total = 0
local v9 = nil
local v10 = 0
local entities = {}
local v11 = {}

local function fn(groundPos, __wf_atom_dc309f8a, enemyLevel, object)
	if not spawnGuards and __wf_atom_7e8ad928(companionEncounterType) then
		return true
	end

	local numGuards2 = 0
	local v12 = false
	v11 = v6:__wf_atom_6199ef01()

	if module.IsInOverworld() then
		local count = 0

		for _, v13 in ipairs(v11) do
			local __wf_atom_50a7d83e = v13:__wf_atom_50a7d83e()

			if
				__wf_atom_7e8ad928(__wf_atom_50a7d83e)
				or __wf_atom_50a7d83e:IsKilled()
				or not (__wf_atom_50a7d83e:__wf_atom_d5fda8be(groundPos) <= 15)
			then
				continue
			end

			count += 1
		end

		if v6:__wf_atom_3634e6d2() == 0 then
			numGuards2 = numGuards
			v12 = true
		elseif count == 0 then
			numGuards2 = 1
		end
	else
		numGuards2 = numGuards
		local __wf_atom_549749d8 = gRegion:__wf_atom_549749d8(faction)

		for _, v13 in ipairs(__wf_atom_549749d8) do
			if v13:IsKilled() or not (v13:__wf_atom_d5fda8be(groundPos) <= 15) then
				continue
			end

			numGuards2 = math.max(numGuards2 - 1, 0)
		end
	end

	if v12 and not __wf_atom_7e8ad928(companionEncounterType) then
		v3:AddEncounter(companionEncounterType)
		v3:__wf_atom_c4c644af(groundPos, companionEncounterType, v6)
	else
		local v13 = 360 / numGuards2

		for i = 1, numGuards2 do
			local v14 = groundPos + __wf_atom_9341614d(
				Vector(4, 0, 0),
				__wf_atom_d919c2d7(__wf_atom_dc309f8a, Rotation(i * v13, 0, 0))
			)
			local __wf_atom_0e0a6fee = v3:__wf_atom_0e0a6fee(v14)
			local guardAgentType = guardAgentTypes[__wf_atom_5784a397(1, #guardAgentTypes)]

			if __wf_atom_7e8ad928(guardAgentType) then
				guardAgentType = module2.GetRandomEnemyAgentType(nil, nil, enemyLevel.minValue, v6, 1, 1)
			end

			local __wf_atom_402b3832 = v3:__wf_atom_402b3832(
				guardAgentType,
				__wf_atom_0e0a6fee,
				__wf_atom_dc309f8a,
				module2.DEFAULT_TEAM,
				enemyLevel.minValue
			)
			__wf_atom_402b3832:SetPatrolRoute(nil)

			if i <= 2 then
				__wf_atom_402b3832:__wf_atom_03cc4f3c(v, __wf_atom_0e0a6fee, 2)
			end

			object:__wf_atom_97f955c1(__wf_atom_402b3832)

			if not (numGuards2 > 1 and i < numGuards2) then
				continue
			end

			Sleep(math.random() * 0.5)

			if __wf_atom_7e8ad928(object) then
				return false
			end
		end
	end

	return true
end

local function fn2(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or not __wf_atom_50a7d83e:__wf_atom_3bba15f7() then
		return
	end

	__wf_atom_50a7d83e:SetVisibility(false, true)
	__wf_atom_50a7d83e:__wf_atom_8914dfde(makeVisibleAnimEvent, 10)

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetVisibility(true, true)
	end
end

local function fn3()
	local v12

	if module.IsInOverworld() then
		v12 = module2.FindPointInstances(v6, nil, bossSpawnPointTag)

		if __wf_atom_7e8ad928(v12) or #v12 == 0 then
			v12 = gRegion:__wf_atom_439c0d29(bossSpawnPointTag, v6:GetPosition(), 0, 50)
		end

		if __wf_atom_7e8ad928(v12) or #v12 == 0 then
			print("Fallback to hint position used to spawn miniboss")
			v12 = {}
			table.insert(v12, v6)
		end
	else
		local v13 = Symbol("Intermediate")
		local v14 = Symbol("Objective")
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(bossSpawnPointTag)

		if __wf_atom_7e8ad928(__wf_atom_2226b35c) or #__wf_atom_2226b35c == 0 then
			print("No spawn point for miniboss, using fallback gNpcSpawnPointType")
			__wf_atom_2226b35c = gRegion:FindAll(gNpcSpawnPointType)
		end

		local firstIndexForTileType = module.GetFirstIndexForTileType(v14)
		v12 = module.FilterObjectsInLayerIndex(firstIndexForTileType, __wf_atom_2226b35c)

		if __wf_atom_7e8ad928(v12) or #v12 == 0 then
			local firstIndexForTileType2 = module.GetFirstIndexForTileType(v13)
			v12 = module.FilterObjectsInLayerIndex(firstIndexForTileType2, __wf_atom_2226b35c)
		end

		if __wf_atom_7e8ad928(v12) or #v12 == 0 then
			print("No valid spawnpoint found, fallback to use all spawns")
			v12 = __wf_atom_2226b35c
		end
	end

	local v13 = (__wf_atom_7e8ad928(v12) or #v12 == 0) and { v6 } or v12
	return v13[__wf_atom_5784a397(1, #v13)]
end

local function fn4(object, __wf_atom_12d9eb4f)
	if not module.IsInOverworld() then
		local v12 = Symbol("Objective")
		local all = gRegion:FindAll(__wf_atom_f806fd7a)
		local firstIndexForTileType = module.GetFirstIndexForTileType(v12)
		local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(firstIndexForTileType, all)

		for _, v13 in ipairs(filterObjectsInLayerIndex) do
			module2.SetEncounterHeaviesBlocked(v13, true)
		end
	end

	local bossSpawnPoint = object:__wf_atom_e919fb8e().bossSpawnPoint

	if __wf_atom_7e8ad928(bossSpawnPoint) and not __wf_atom_7e8ad928(v6) then
		bossSpawnPoint = v6:__wf_atom_e919fb8e().bossSpawnPoint
	end

	if __wf_atom_7e8ad928(bossSpawnPoint) then
		bossSpawnPoint = fn3()
	end

	local position2 = bossSpawnPoint:GetPosition()
	local __wf_atom_dc309f8a = bossSpawnPoint:__wf_atom_dc309f8a()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("OdeAtmosphereGen"), position2, 0, 15)

	for _, v12 in ipairs(__wf_atom_439c0d29) do
		gRegion:__wf_atom_dd1e4d10(v12)
	end

	if not __wf_atom_7e8ad928(guardedChestType) then
		local position3 = nil
		local v12 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		local v13 = math.max(25, v6:__wf_atom_103377cc())
		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("GuardedChestSpawn"), position2, 0, v13)

		if __wf_atom_7e8ad928(__wf_atom_439c0d29_2) or not (#__wf_atom_439c0d29_2 > 0) then
			local encounterLootSpawns = module2.GetEncounterLootSpawns(
				position2,
				Range(5, v13),
				1,
				true,
				false,
				true,
				5
			)

			if not __wf_atom_7e8ad928(encounterLootSpawns) and #encounterLootSpawns > 0 then
				local encounterLootSpawn = encounterLootSpawns[__wf_atom_5784a397(1, #encounterLootSpawns)]

				if __wf_atom_7e8ad928(encounterLootSpawn.spawnPt) then
					print("Spawning chest at tac map terrain pos")
					position3, v12 = module4.GetGroundAlignedSpawnPosRot(
						guardedChestType,
						encounterLootSpawn.pos,
						encounterLootSpawn.rot
					)
				else
					print("Spawning chest at an empty loot chest spawnpoint")
					position3 = encounterLootSpawn.spawnPt:GetPosition()
					v12 = encounterLootSpawn.spawnPt:__wf_atom_dc309f8a()
				end
			end
		else
			print("Spawning boss chest at GuardedChestSpawn")
			local v14 = __wf_atom_439c0d29_2[__wf_atom_5784a397(1, #__wf_atom_439c0d29_2)]
			position3 = v14:GetPosition()
			v12 = v14:__wf_atom_dc309f8a()
			v14:FirePort("Disable")
		end

		if __wf_atom_7e8ad928(position3) then
			print("No valid spawn position for the boss chest!")
		else
			v7 = gRegion:CreateEntity(guardedChestType, position3, v12)
			object:__wf_atom_d494454b(v7)
			print("Chest successfully spawned")
		end
	end

	if not __wf_atom_7e8ad928(mineType) then
		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("MineSpawn"), v6:GetPosition(), 0, 70)

		if not __wf_atom_7e8ad928(__wf_atom_439c0d29_2) and #__wf_atom_439c0d29_2 > 0 then
			local randomizeTableOrder = module.RandomizeTableOrder(__wf_atom_439c0d29_2)
			local __wf_atom_3634e6d2 = v6:__wf_atom_3634e6d2()

			for i = 1, math.min(math.min(maxNumMines, #randomizeTableOrder), math.floor(__wf_atom_3634e6d2 / 5) * 2) do
				local v12 = module4.GetGroundAlignedSpawnPosRot(mineType, randomizeTableOrder[i]:GetPosition()) + Vector(0, 0.05, 0)
				local entity = gRegion:CreateEntity(mineType, v12, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
				table.insert(entities, entity)
				object:__wf_atom_d494454b(entity)
			end
		end
	end

	local enemyLevel = module2.GetEnemyLevel(v6)
	local groundPos = module4.GetGroundPos(position2)

	if not fn(groundPos, __wf_atom_dc309f8a, enemyLevel, object) then
		print("Early out after SpawnGuards")
		return false
	end

	if waitForSpawnPointEnable then
		print("waitForSpawnPointEnable")

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(bossSpawnPoint) or bossSpawnPoint:IsEnabled()) do
			Sleep(0)
		end

		if __wf_atom_7e8ad928(object) then
			return false
		else
			print("waitForSpawnPointEnable done")
		end
	end

	local bossLevelOverride2

	if bossLevelOverride > 0 then
		bossLevelOverride2 = bossLevelOverride
	elseif module.IsInOverworld() then
		bossLevelOverride2 = enemyLevel.maxValue + 5
	else
		bossLevelOverride2 = math.ceil(enemyLevel.maxValue * 1.25)
	end

	local v12

	if #bossAgentTypes > 0 then
		v12 = bossAgentTypes[__wf_atom_5784a397(1, #bossAgentTypes)]
	else
		v12 = module2.GetRandomEnemyAgentType(nil, faction, bossLevelOverride2, object, 0, 3, true, true)
	end

	if __wf_atom_7e8ad928(v12) then
		print("Nil agentType")
		return false
	end

	if not __wf_atom_7e8ad928(preSpawnTransmissionSet) then
		module5.PlayGlobalTransmission(
			preSpawnTransmissionSet,
			preSpawnTransmissionSymbol,
			holdSpawnUntilPreSpawnTransmissionComplete
		)
		Sleep(PreSpawnTransmissionSleepTime)
	end

	v4 = v3:__wf_atom_402b3832(v12, groundPos, __wf_atom_dc309f8a, module2.DEFAULT_TEAM, bossLevelOverride2, spawnAnim)

	if __wf_atom_7e8ad928(v4) then
		print("Nil mBossAgent")
		return false
	end

	v5 = v4:__wf_atom_50a7d83e()
	object:__wf_atom_97f955c1(v4)

	if __wf_atom_7e8ad928(v5) then
		print("Nil mBossAvatar")
		return false
	end

	module3.AddSparrowDestination(v5, v6, nil, module3.PRIORITY.HIGH, Range(6, v6:__wf_atom_8f18e876()))

	if markObjectiveOnMap and not __wf_atom_7e8ad928(__wf_atom_12d9eb4f) then
		object:__wf_atom_d494454b((v5:Attach(__wf_atom_12d9eb4f, EMPTY_SYMBOL)))
	end

	if not module.IsInOverworld() then
		v4:__wf_atom_d1a3cfcf(true)
		v3:__wf_atom_5e16fe4a(v5)
	end

	if spawnInvsibleUntilAnimEvent then
		print("Invisible boss")
		fn2(v4)
	end

	return true
end

local function fn5(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return false
	end

	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local __wf_atom_50a7d83e2 = object2:__wf_atom_50a7d83e()

	if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_7e8ad928(__wf_atom_50a7d83e2)) then
		return __wf_atom_50a7d83e:__wf_atom_a5304c35(position) < __wf_atom_50a7d83e2:__wf_atom_a5304c35(position)
	end

	return false
end

local function fn6()
	if not module.IsInOverworld() then
		return
	end

	if not (total >= 15) then
		total += __wf_atom_084b3e93()
		return
	end

	local __wf_atom_6199ef01 = v6:__wf_atom_6199ef01()
	local v12 = {}

	for i = #__wf_atom_6199ef01, 1, -1 do
		local __wf_atom_50a7d83e = __wf_atom_6199ef01[i]:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e == v5 or __wf_atom_50a7d83e:IsKilled() then
			table.remove(__wf_atom_6199ef01, i)
		elseif __wf_atom_6199ef01[i]:__wf_atom_04ea4887() then
			table.insert(v12, __wf_atom_6199ef01[i])
			table.remove(__wf_atom_6199ef01, i)
		end
	end

	if not (#v12 <= 1 and #__wf_atom_6199ef01 > 0) then
		total = 12
		return
	end

	table.sort(__wf_atom_6199ef01, fn5)

	if not __wf_atom_7e8ad928(__wf_atom_6199ef01[1]) then
		__wf_atom_6199ef01[1]:StormTarget(v5, 7)
	end

	if not __wf_atom_7e8ad928(__wf_atom_6199ef01[2]) then
		__wf_atom_6199ef01[2]:StormTarget(v5, 7)
	end

	total = 0
end

function Main(object)
	print("Miniboss encounter started")
	v3 = module.WaitForAiDir()
	v6 = object:__wf_atom_26b04ea9()
	v9 = object:__wf_atom_dd85e6db()
	v10 = object:__wf_atom_2b1fe281()
	local __wf_atom_d0c8d09f = v9:__wf_atom_d0c8d09f()
	local __wf_atom_12d9eb4f = v9:__wf_atom_12d9eb4f()

	if object:__wf_atom_2b1fe281() >= v2.SPAWNED then
		print("Host migration")
		module.WaitForLevel()

		if v10 >= v2.SPAWNED then
			local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

			for _, v12 in ipairs(__wf_atom_6199ef01) do
				local __wf_atom_50a7d83e = v12:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and __wf_atom_50a7d83e:__wf_atom_464a4772() then
					v4 = v12
				end

				if __wf_atom_7e8ad928(v4) then
					for _, className in ipairs(bossAgentTypes) do
						if not v12:IsA(className) then
							continue
						end

						v4 = v12
						break
					end
				end

				if __wf_atom_7e8ad928(v4) then
					continue
				end

				v5 = v4:__wf_atom_50a7d83e()
				module3.AddSparrowDestination(v5, v6, nil, module3.PRIORITY.HIGH, Range(6, v6:__wf_atom_8f18e876()))
				print("Boss avatar found")
				break
			end
		end

		if v10 == v2.KILLED then
			flag = true
		end
	else
		object:__wf_atom_8e6fec76(1)

		if __wf_atom_7e8ad928(v6) then
			v6 = object
		end

		if module2.WaitForParentEncounterActive(object) then
			if markObjectiveOnMap then
				module2.RemoveMissionMarker(v6)
			end

			if not fn4(object, __wf_atom_12d9eb4f) then
				print("Shutdown due to streaming (2)")
				return
			end

			if _T.PlayEncounterTransmissions or not module.IsInOverworld() then
				if __wf_atom_7e8ad928(questToCheck) then
					module5.PlayGlobalTransmission(__wf_atom_d0c8d09f, introTransmissionTag)
				else
					module5.PlayQuestDependentTransmission(
						__wf_atom_d0c8d09f,
						questToCheck,
						introTransmissionTag,
						introTransmissionPostQuestTag
					)
				end
			end

			object:__wf_atom_8e6fec76(2)
			object:__wf_atom_8776856a(v2.SPAWNED)
		else
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8e6fec76(6)
			end

			print("Failed to start encounter")
			return
		end
	end

	module6.UpdateOrAddHudTask(object)
	position = object:GetPosition()
	local v12 = false
	local total2 = 0
	local v13

	if not __wf_atom_7e8ad928(v7) then
		v13 = v7:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	end

	while not module2.PrimedMissionShouldShutDown(object, v6) do
		if flag then
			local v14 = (not mustPickUpItemToComplete or __wf_atom_7e8ad928(v8)) and true or false

			if v14 and mustOpenChestToComplete and not __wf_atom_7e8ad928(v7) then
				if not v12 and __wf_atom_7e8ad928(v8) then
					module3.AddSparrowDestination(v7, v6, nil, module3.PRIORITY.HIGH, Range(0, v6:__wf_atom_8f18e876()))
					v12 = true

					if openChestLocText ~= EMPTY_SYMBOL then
						module6.UpdateOrAddHudTask(object, nil, openChestLocText)
					end
				end

				if not (__wf_atom_7e8ad928(v13) or v13:__wf_atom_272baebc()) then
					v14 = false
				end
			end

			if v14 then
				object:__wf_atom_8e6fec76(4)
				print("Can complete encounter")
				break
			end
		elseif
			__wf_atom_7e8ad928(v5)
			or v5:IsKilled()
			or completeEncounterWhenInPredeath and v5:__wf_atom_bedb4e3f()
		then
			local groundPos = module4.GetGroundPos(position)

			if not __wf_atom_7e8ad928(bossItemDrop) then
				v8 = gRegion:CreateEntity(bossItemDrop, groundPos, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
				object:__wf_atom_d494454b(v8)

				if mustPickUpItemToComplete then
					module3.AddSparrowDestination(v8, v6, nil, module3.PRIORITY.HIGH, Range(0, v6:__wf_atom_8f18e876()))

					if pickUpItemLocText ~= EMPTY_SYMBOL then
						module6.UpdateOrAddHudTask(object, nil, pickUpItemLocText)
					end
				end
			end

			object:__wf_atom_8776856a(v2.KILLED)
			flag = true
		else
			if v4:__wf_atom_04ea4887() then
				fn6()
			end

			if _T.DungeonObjDebugDraw then
				gRegion:__wf_atom_5b35a0c8(v5:GetPosition() + Vector(0, 1, 0), Color(0, 255, 0), "Miniboss", 1, 0)

				for _, v14 in ipairs(entities) do
					if not __wf_atom_7e8ad928(v14) then
						gRegion:__wf_atom_5b35a0c8(v14:GetPosition() + Vector(0, 1, 0), Color(0, 255, 0), "Mine", 1, 0)
					end
				end
			end
		end

		if not (__wf_atom_7e8ad928(v5) or v5:IsKilled()) then
			position = v5:GetPosition()

			if not __wf_atom_7e8ad928(v5) then
				if total2 >= 3 then
					if module.AnyPlayerNearPos(position, 60, true) then
						module6.UpdateVisibility(true)
					end

					total2 = 0
				else
					total2 += __wf_atom_084b3e93()
				end
			end
		end

		Sleep(0)
	end

	print("Miniboss encounter ending...")

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to streaming (3)")
		return
	end

	if object:__wf_atom_3634e6d2() == 0 or object:__wf_atom_4026dfb5() == 4 then
		object:__wf_atom_8e6fec76(4)
		print("Succeeded")
		module3.RemoveSparrowDestination(v5)

		if module.IsInOverworld() then
			module6.CompleteHudTask(object)
			Sleep(4)

			if __wf_atom_7e8ad928(object) then
				print("Shutdown due to streaming (4)")
				return
			end

			module6.RemoveHudGroup(object)
			module2.SetEncounterHeaviesBlocked(object, false)

			while
				not (__wf_atom_7e8ad928(v7) and __wf_atom_7e8ad928(v5))
				and not __wf_atom_7e8ad928(object)
				and v3:__wf_atom_c6f505f2(object) > 0
			do
				Sleep(0)
			end
		else
			Sleep(1)

			if __wf_atom_7e8ad928(object) then
				print("Shutdown due to streaming (5)")
				return
			end

			module5.PlayGlobalTransmission(__wf_atom_d0c8d09f, deedDoneTransmissionTag)

			if not __wf_atom_7e8ad928(dropTable) then
				module2.GiveDeedRewards(object, dropTable)
			end

			module6.RemoveHudGroup(object)

			while
				not __wf_atom_7e8ad928(object)
				and object:__wf_atom_4026dfb5() ~= 6
				and not Game.__wf_atom_2b221245(false)
			do
				Sleep(0)
			end
		end
	else
		print("Shutdown")
		object:__wf_atom_8e6fec76(6)
	end

	print("Miniboss encounter ended")
	module2.RemoveMessengerIntel(object, true)
	module6.RemoveHudGroup(object)
	module2.RemoveAgents(object)
	module2.RemoveObjects(object)
end

function MinibossEncounterOnPrimed(object)
	v6 = object:__wf_atom_26b04ea9()

	if __wf_atom_7e8ad928(v6) then
		v6 = object
	end

	local bossSpawnPoint = fn3()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.bossSpawnPoint = bossSpawnPoint
	object:__wf_atom_c53e1842(bossSpawnPoint:GetPosition())

	if module.IsInOverworld() then
		module2.SetEncounterHeaviesBlocked(v6, true)
		module2.EnableFortificationHints(v6)
	else
		local __wf_atom_e800787c = object:__wf_atom_e800787c()

		if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
			local layerIndex = __wf_atom_e800787c:GetLayerIndex()
			local all = gRegion:FindAll(__wf_atom_f806fd7a, object:GetPosition(), 0, 50)

			for _, v12 in ipairs(all) do
				if module.IsIntileIndex(v12, layerIndex) then
					module2.SetEncounterHeaviesBlocked(v12, true)
				end
			end
		end
	end

	if #randomMessengerText == 0 or module7.HintIsReserved(object) then
		return
	end

	local v12 = randomMessengerText[__wf_atom_5784a397(1, #randomMessengerText)]
	module2.AddMessengerIntel(object, messengerContainerHintType, v12, overrideMarker)
end

function Enhancement(object)
	object:__wf_atom_48a580fd(locOverride)
	object:SetMeshScale(scale, true)
	object:__wf_atom_986f733d(Symbol("MiniBoss"), deltaAtten)
end