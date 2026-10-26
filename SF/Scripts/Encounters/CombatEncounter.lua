local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.ModifySkyLib")
local v = Symbol("RandomTeam")
local v2 = WeakResource("/SF/Types/Npc/EncounterNpcAlternateSpawnControl")
local v3 = nil
local position = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local overrideSpawnDistanceRange2 = nil
local v8 = false
local v9 = Symbol("Guard")
local v10 = false
local v11 = nil

local function fn()
	local v12 = WeakResource("/SF/Types/PickUps/LootContainers/LootChestBase")
	local __wf_atom_2b1fe281 = v4:__wf_atom_2b1fe281()
	local v13 = (__wf_atom_2b1fe281 - __wf_atom_2b1fe281 % 100) / 100
	local __wf_atom_fe00d825 = v4:__wf_atom_fe00d825()

	for _, v14 in ipairs(__wf_atom_fe00d825) do
		if not (v14:IsA(v12) and __wf_atom_7e8ad928(v14:__wf_atom_bb3e7833(__wf_atom_0f45538d))) then
			continue
		end

		v13 += 1
	end

	local v14 = v13 * 100 + #v6
	v4:__wf_atom_8776856a(v14)
end

local function fn2()
	v6 = v4:__wf_atom_6199ef01()

	if not skipCullOutOfRangeEnemies then
		module.CleanUpOutOfRangeEnemies(v4, v6)
	end

	if #v6 > 0 then
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

			for _, v12 in ipairs(__wf_atom_b7c04e13) do
				if
					__wf_atom_7e8ad928(v12)
					or v12:IsKilled()
					or not pointInstance:__wf_atom_1eaf335c(v12:GetPosition())
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
	if not module2.IsInOverworld() or v4:__wf_atom_e464a32f() > 0 then
		return
	end

	local v12 = __wf_atom_5784a397(numChestsToSpawn.minValue, numChestsToSpawn.maxValue)
	local __wf_atom_2b1fe281 = v4:__wf_atom_2b1fe281()
	local v13 = v12 - (__wf_atom_2b1fe281 - __wf_atom_2b1fe281 % 100) / 100

	if v13 <= 0 then
		return
	end

	local v14 = Range(5, (math.max(v4:__wf_atom_103377cc() + 5, 15)))
	local encounterLootSpawns = module.GetEncounterLootSpawns(position, v14, v13, true, false, true, 5, v4)

	for i = 1, math.min(v13, #encounterLootSpawns) do
		local chestTypeRare2

		if v8 and i == 1 and not __wf_atom_7e8ad928(chestTypeRare) then
			chestTypeRare2 = chestTypeRare
		elseif __wf_atom_7e8ad928(chestTypeRare) or not (rareChestChance > 0 and math.random() <= rareChestChance) then
			chestTypeRare2 = chestTypeCommon
		else
			chestTypeRare2 = chestTypeRare
		end

		local v15 = __wf_atom_5784a397(1, #encounterLootSpawns)
		local pos = encounterLootSpawns[v15].pos
		local rot = encounterLootSpawns[v15].rot

		if __wf_atom_7e8ad928(encounterLootSpawns[v15].spawnPt) then
			pos, rot = module3.GetGroundAlignedSpawnPosRot(
				chestTypeRare2,
				encounterLootSpawns[v15].pos,
				encounterLootSpawns[v15].rot,
				false,
				30
			)
		end

		if __wf_atom_7e8ad928(pos) then
			continue
		end

		local lootContainer = module.SpawnLootContainer(chestTypeRare2, pos, rot, true, v4)
		table.remove(encounterLootSpawns, v15)
		v4:__wf_atom_d494454b(lootContainer)
	end
end

local function fn4(i, p, p2, p3, p4, p5, p6, spawnCount)
	if v10 and not __wf_atom_7e8ad928(p2[i]) then
		if p2[i].useCustomAgentType then
			return p2[i].agentType
		end

		return (module.GetRandomEnemyAgentType(
			nil,
			faction,
			p,
			v4,
			p2[i].agentSpec.archetype,
			p2[i].agentSpec.rank,
			p2[i].agentSpec.exclusiveRank
		))
	elseif #customAgentTypes > 0 then
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

local function fn5()
	local v12 = {}
	local v13 = {}
	local result = {}
	local v14 = {}
	local __wf_atom_8f18e876 = v4:__wf_atom_8f18e876()

	if useSpawnControls then
		local v15

		if dynamicSpawnControlTag == EMPTY_SYMBOL then
			v15 = module.FindPointInstances(v4, __wf_atom_96b9d246)
		else
			v15 = gRegion:__wf_atom_439c0d29(dynamicSpawnControlTag, position, 0, overrideSpawnDistanceRange2.maxValue)
		end

		local v16 = { Symbol("ScoutSpawnControl") }

		if not __wf_atom_7e8ad928(v15) and #v15 > 0 then
			for _, v17 in ipairs(v15) do
				local __wf_atom_db682341 = v17:__wf_atom_db682341()
				local v18 = true

				for _, v19 in ipairs(v16) do
					if __wf_atom_db682341 ~= v19 then
						continue
					end

					v18 = false
					break
				end

				if not v18 or __wf_atom_7e8ad928(v17) or not (v17:__wf_atom_1c8f7b2d(v4) <= __wf_atom_8f18e876) then
					continue
				end

				if v17:IsA(v2) then
					table.insert(v13, v17)
				else
					table.insert(v12, v17)
				end
			end

			if #v13 > 0 then
				table.insert(v12, v13[__wf_atom_5784a397(1, #v13)])
			end

			for _, v17 in ipairs(v12) do
				if __wf_atom_7e8ad928(v17) then
					continue
				end

				local __wf_atom_dcc0a6f8 = v17:__wf_atom_dcc0a6f8()

				if not (#__wf_atom_dcc0a6f8 > 0) then
					continue
				end

				local __wf_atom_f7c1604d = v17:__wf_atom_f7c1604d(#__wf_atom_dcc0a6f8)
				local filterDisallowedSpawnpoints = module.FilterDisallowedSpawnpoints(__wf_atom_f7c1604d)
				local rounded = math.min(
					module2.Round((v17:__wf_atom_1d28ac91() or 1) * (scaledSpawnMult[__wf_atom_421b01aa(v7, 1, #scaledSpawnMult)] or 1)),
					20
				)

				if module.GetEncounterChillout(v4) then
					rounded = module2.Round(rounded * 0.65)
				end

				table.insert(result, {
					spawnPoints = filterDisallowedSpawnpoints,
					spawnCount = rounded
				})

				for _, v18 in ipairs(__wf_atom_dcc0a6f8) do
					table.insert(v14, v18)
				end
			end
		end
	end

	if useHintSpawns then
		local pointInstances = module.FindPointInstances(v4, gNpcSpawnPointType)
		v14 = module2.MergeTables(v14, pointInstances, true)
	end

	return result, (module.FilterDisallowedSpawnpoints(v14))
end

local function fn6()
	if useFoundSpawns then
		local v12 = not module2.IsInOverworld()
		local v13

		if v12 then
			v13 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue + 1
			)
		else
			v13 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnDistanceRange2.minValue,
				overrideSpawnDistanceRange2.maxValue * 1.5
			)

			for i = #v13, 1, -1 do
				if v13[i]:IsEnabled() then
					if foundSpawnsWithTag:__wf_atom_8598f3a9() and not v13[i]:HasTag(foundSpawnsWithTag) then
						table.remove(v13, i)
					elseif v13[i]:__wf_atom_a5304c35(position) > overrideSpawnDistanceRange2.maxValue + 2 then
						table.remove(v13, i)
					end
				else
					table.remove(v13, i)
				end
			end
		end

		if v12 then
			local layerIndex = module2.GetLayerIndex(v4)
			module2.FilterObjectsInLayerIndex(layerIndex, v13)
		end

		local randomizeTableOrder = module2.RandomizeTableOrder(v13)
		return (module.FilterDisallowedSpawnpoints(randomizeTableOrder))
	else
		return {}
	end
end

local function fn7(list)
	local v12 = nil
	local encounterChillout = module.GetEncounterChillout(v4)
	local v13

	if encounterChillout then
		v13 = false
	else
		v13 = module.GetEncounterBoostEnemies(v4)
	end

	local rounded = __wf_atom_5784a397(baseSpawnCount.minValue, baseSpawnCount.maxValue)

	if encounterChillout then
		rounded = module2.Round(rounded * 0.65)
	elseif v13 then
		rounded = baseSpawnCount.maxValue
	end

	if #scaledSpawnMult >= 1 then
		rounded = module2.Round(rounded * scaledSpawnMult[__wf_atom_421b01aa(v7, 1, #scaledSpawnMult)])
	end

	local v14 = scaledSquadTier[__wf_atom_421b01aa(v7, 1, #scaledSquadTier)] or 0

	if __wf_atom_7e8ad928(squadListResource) then
		if useRandomSquadComposition and #list == 0 then
			v12 = module.GetRandomSquadList(rounded, nil, v14)
			v10 = true
		end

		return rounded, v12, v13
	else
		local randomSquadList = module.GetRandomSquadList(rounded, squadListResource, v14)
		v10 = true
		return rounded, randomSquadList, v13
	end
end

local function fn8(list)
	local v12

	if not (limitOvercrowdingRadius > 0) then
		return v12
	end

	local all = gRegion:FindAll(__wf_atom_9e85eea2, position, 0, limitOvercrowdingRadius)
	v12 = 0

	for _, v13 in ipairs(all) do
		if __wf_atom_7e8ad928(v13) or v13:IsKilled() or v13:__wf_atom_e93896ba() ~= faction then
			continue
		end

		v12 -= 1
	end

	for _, v13 in ipairs(list) do
		v12 += v13.spawnCount
	end

	return v12
end

function MaintainAlertness(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	while not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(object) or object:IsKilled()) do
		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_1793a706())
			or __wf_atom_30e3d82b:__wf_atom_1793a706() == 1
		then
			__wf_atom_30e3d82b:__wf_atom_30b587a4()
		end

		Sleep(1)
	end
end

local function fn9()
	v6 = v4:__wf_atom_6199ef01()

	if not skipCullOutOfRangeEnemies then
		module.CleanUpOutOfRangeEnemies(v4, v6)
	end

	if #v6 > 0 then
		return
	end

	v7 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v12, v13 = fn5()
	local __wf_atom_e919fb8e = v4:__wf_atom_e919fb8e()
	local v14

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.reservedSpawnPoints) then
		v14 = fn6()
	else
		v14 = __wf_atom_e919fb8e.reservedSpawnPoints
	end

	local mergeTables = module2.MergeTables(v13, v14, true)
	local spawnCount2, v15, v16 = fn7(v12)

	if #v12 == 0 then
		table.insert(v12, { spawnPoints = mergeTables, spawnCount = spawnCount2 })
	end

	local enemyLevel = module.GetEnemyLevel(v4)
	local v17 = fn8(v12)

	if not __wf_atom_7e8ad928(v17) and v17 <= 0 then
		print("Enemy cap is <= 0")
		return
	end

	local total = 0

	for i = 1, #v12 do
		total += v12[i].spawnCount
	end

	local v18 = v4:__wf_atom_2b1fe281() % 100
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
		position,
		overrideSpawnDistanceRange2,
		total,
		nil,
		nil,
		nil,
		nil,
		canSpawnInWater
	)
	local v19 = false
	local count = 0

	for i, v20 in ipairs(v12) do
		local spawnPoints = v20.spawnPoints
		local spawnCount = v20.spawnCount

		for j = 1, spawnCount do
			local v21

			if not (__wf_atom_7e8ad928(spawnPoints) or not (#spawnPoints > 0)) then
				v21 = spawnPoints[1]
			end

			local v22 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
			local v23 = fn4(j, v22, v15, v21, i == #v12, v16, v19, spawnCount)
			local v24

			if not __wf_atom_7e8ad928(v23) then
				if __wf_atom_7e8ad928(v21) then
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

					local v25 = __wf_atom_fa8d0177(position, randomPointInRangeOnNav)
					local v26 = Rotation(v25.heading, 0, 0)

					if spawnAlert or module.GetEncounterAlerted(v4) then
						local nearestObject = module2.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf)

						if not __wf_atom_7e8ad928(nearestObject) then
							v26 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
						end
					end

					if delayBetweenSpawns > -1 then
						Sleep(delayBetweenSpawns)
					end

					v24 = v3:__wf_atom_402b3832(v23, randomPointInRangeOnNav, v26, v, v22)
				else
					local __wf_atom_66a525a6 = v21:__wf_atom_66a525a6()

					if __wf_atom_66a525a6 > 0 then
						v22 = __wf_atom_66a525a6
					end

					if delayBetweenSpawns > -1 then
						Sleep(delayBetweenSpawns)
					end

					v24 = v3:CreateAgent(v23, v21, v, v22)
					table.remove(spawnPoints, 1)
				end

				if module.IsHeavyAgent(v24) then
					v19 = true
				end
			end

			if __wf_atom_7e8ad928(v24) then
				print("Failed to spawn agent")
			else
				v4:__wf_atom_97f955c1(v24)

				if not __wf_atom_7e8ad928(v5) then
					v5:__wf_atom_97f955c1(v24)
				end

				if shouldFadeInAgents then
					v24:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("FadeIn"), false)
				end

				if not v8 then
					v8 = module.IsHeavyAgent(v24)
				end

				count += 1
				local __wf_atom_50a7d83e = v24:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					if spawnAlert or module.GetEncounterAlerted(v4) then
						v24:__wf_atom_30b587a4()

						if alertStormNearestPlayer then
							local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()
							local nearestObject = module2.NearestObject(
								__wf_atom_50a7d83e:GetPosition(),
								__wf_atom_ef7900cf2
							)

							if not __wf_atom_7e8ad928(nearestObject) then
								v24:StormTarget(nearestObject)
							end
						end
					end

					if maintainAlertness or module.GetEncounterAlerted(v4) then
						__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("MaintainAlertness"), false)
					end
				end

				if v18 > 0 and v18 <= count then
					print("Restored up to previous enemy count")
					return
				end

				if not __wf_atom_7e8ad928(v17) and v17 <= count then
					print("Spawn cap reached")
					return
				end
			end

			if j < spawnCount2 then
				Sleep(0)
			end

			if module.ShouldShutDown(v4) then
				return
			end
		end
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

function FilterRandomPlugins()
	local result = {}

	for i, v12 in ipairs(randomizedPluginScripts) do
		if not (i <= #randomizedPluginsRequiredTag) or __wf_atom_7e8ad928(randomizedPluginsRequiredTag[i]) then
			continue
		end

		if #module.FindPointInstances(v4, nil, randomizedPluginsRequiredTag[i]) > 0 then
			table.insert(result, v12)
		elseif #gRegion:__wf_atom_439c0d29(
			randomizedPluginsRequiredTag[i],
			v4:GetPosition(),
			0,
			v4:__wf_atom_103377cc()
		) > 0 then
			table.insert(result, v12)
		end
	end

	return result
end

local function fn10(object, fn11)
	v3 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	position = object:GetPosition()
	v5 = object:__wf_atom_26b04ea9()
	overrideSpawnDistanceRange2 = Range(0, object:__wf_atom_103377cc())
	v4 = object

	if overrideSpawnDistanceRange.minValue >= 0 and overrideSpawnDistanceRange.maxValue > 0 then
		overrideSpawnDistanceRange2 = overrideSpawnDistanceRange
	end

	if not fn2() then
		print("Shutdown due to level streaming")
		return false
	end

	v4:__wf_atom_8e6fec76(1)

	if #setupScripts > 0 then
		local v12 = module2.StartPluginScripts(setupScripts, object)

		while not __wf_atom_7e8ad928(v4) and #v12 > 0 and v4:__wf_atom_4026dfb5() ~= 6 do
			for i = #v12, 1, -1 do
				if not (__wf_atom_7e8ad928(v12[i]) or not v12[i]:IsRunning()) then
					continue
				end

				table.remove(v12, i)
			end

			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(v4) or v4:__wf_atom_4026dfb5() == 6 then
		return false
	end

	fn11()
	Sleep(0)

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return false
	end

	v4:__wf_atom_2cc8420c(v4:__wf_atom_dd85e6db())
	return true
end

local function fn11()
	local flag = false

	if
		canBeAttackedByRivals
		and not __wf_atom_7e8ad928(v4)
		and not __wf_atom_7e8ad928(rivalEncounter)
		and __wf_atom_5784a397(0, 100) < rivalEncounterProb
	then
		print("Activating guard encounter for pollution tower")
		v3:AddEncounter(rivalEncounter)
		v11 = v3:__wf_atom_c4c644af(position, rivalEncounter, v4)
	end

	while not module.ShouldShutDown(v4) and v4:__wf_atom_3634e6d2() > 0 do
		v6 = v4:__wf_atom_6199ef01()

		if not skipCullOutOfRangeEnemies then
			module.CleanUpOutOfRangeEnemies(v4, v6)
		end

		if alertAllOnCombat and not flag then
			for _, v12 in ipairs(v6) do
				if not v12:__wf_atom_04ea4887() then
					continue
				end

				flag = true
				break
			end

			if flag then
				for _, v12 in ipairs(v6) do
					v12:__wf_atom_30b587a4()

					if guardRadiusWhenAllAlerted > 0 then
						v12:__wf_atom_03cc4f3c(v9, position, guardRadiusWhenAllAlerted)
					end
				end
			end
		end

		Sleep(1)
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
		fn()
		v4:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v4) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveAgents(v4)
	module.RemoveObjects(v4)
	Sleep(0)
end

function StartCombatEncounter(object)
	if fn10(object, fn9) then
		fn3()
		module2.StartPluginScripts(pluginScripts, object)
		local v12 = FilterRandomPlugins()
		module2.StartRandomPluginScript(v12, object)
		object:__wf_atom_8e6fec76(2)
		fn11()
		fn12()
	elseif __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
	else
		object:__wf_atom_8e6fec76(6)
	end
end

function StartCombatEncounterLite(object)
	if fn10(object, fn9) then
		module2.StartPluginScripts(pluginScripts, object)
		local v12 = FilterRandomPlugins()
		module2.StartRandomPluginScript(v12, object)
		object:__wf_atom_8e6fec76(2)
		fn11()
		fn12()
	elseif __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
	else
		object:__wf_atom_8e6fec76(6)
	end
end

local function fn13()
	local maxValue = module.GetEnemyLevel(v4).maxValue
	local nightTorchBearerTypes

	if canSpawnAltHeavyGuard and math.random() <= 0.1 then
		nightTorchBearerTypes = { (module.GetRandomEnemyAgentType(nil, faction, maxValue, v4, 0, 2, true)) }
	else
		local gruntAgentType2 = nil

		if __wf_atom_7e8ad928(gruntAgentTypeElite) or not (maxValue > 10) then
			if not __wf_atom_7e8ad928(gruntAgentType) then
				gruntAgentType2 = gruntAgentType
			end
		else
			gruntAgentType2 = gruntAgentTypeElite
		end

		local v12 = gruntAgentType2 or module.GetRandomEnemyAgentType(nil, faction, maxValue, v4, 1, 1)

		if canSpawnRanged and math.random() <= 0.33 then
			nightTorchBearerTypes = { v12, (module.GetRandomEnemyAgentType(nil, faction, maxValue, v4, 2, 1)) }
		else
			nightTorchBearerTypes = { v12, v12 }

			if not __wf_atom_7e8ad928(nightTorchBearerType) and math.random() <= 0.33 then
				local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

				if
					__wf_atom_cb3427c9 >= 22
					or __wf_atom_cb3427c9 < 6
					or module4.IsOvercast()
					or module4.IsRaining()
				then
					nightTorchBearerTypes[1] = nightTorchBearerType
				end
			end
		end
	end

	local pointInstances = module.FindPointInstances(v4, gNpcSpawnPointType)
	local mergeTables = module2.MergeTables(pointInstances, fn6(), true)

	for i = 1, #nightTorchBearerTypes do
		local randomPointInRangeOnNav, v12

		if __wf_atom_7e8ad928(mergeTables) or __wf_atom_7e8ad928(mergeTables[i]) then
			randomPointInRangeOnNav = v3:GetRandomPointInRangeOnNav(
				position,
				math.max(overrideSpawnDistanceRange2.minValue, 2),
				overrideSpawnDistanceRange2.maxValue,
				true,
				0.5
			)
			v12 = __wf_atom_fa8d0177(position, randomPointInRangeOnNav)
		else
			randomPointInRangeOnNav = mergeTables[i]:GetPosition()
			v12 = mergeTables[i]:__wf_atom_dc309f8a()
		end

		local __wf_atom_402b3832 = v3:__wf_atom_402b3832(
			nightTorchBearerTypes[i] or nightTorchBearerTypes[#nightTorchBearerTypes],
			randomPointInRangeOnNav,
			v12,
			v,
			maxValue
		)
		v4:__wf_atom_97f955c1(__wf_atom_402b3832)
	end
end

function StartCombatEncounterGuards(object)
	if fn10(object, fn13) then
		module2.StartPluginScripts(pluginScripts, object)
		local v12 = FilterRandomPlugins()
		module2.StartRandomPluginScript(v12, object)
		object:__wf_atom_8e6fec76(2)
		fn11()
		fn12()
	elseif __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
	else
		object:__wf_atom_8e6fec76(6)
	end
end

function OnEnabled(object)
	Sleep(0)
	position = object:GetPosition()
	v5 = object:__wf_atom_26b04ea9()
	overrideSpawnDistanceRange2 = Range(0, object:__wf_atom_103377cc())
	v4 = object

	if reserveSpawnPoints then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.reservedSpawnPoints) then
			__wf_atom_e919fb8e.reservedSpawnPoints = {}
		end

		local v12 = fn6()

		for _, v13 in ipairs(v12) do
			v13:Disable()
			table.insert(__wf_atom_e919fb8e.reservedSpawnPoints, v13)
		end
	end
end