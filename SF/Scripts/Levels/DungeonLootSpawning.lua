local coopRareChest2 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.StatsLib")
local count = 0
local count2 = 0
local count3 = 0
local count4 = 0
local count5 = 0

local function fn(list, clusteredHiddenSpawnsMaxRange)
	local positions = {}
	local result = {}

	for _, v in ipairs(list) do
		if not __wf_atom_7e8ad928(v) then
			table.insert(positions, (v:GetPosition()))
		end
	end

	for i = 1, #positions - 1 do
		for j = i + 1, #positions do
			if Distance(positions[i], positions[j]) < clusteredHiddenSpawnsMaxRange then
				table.insert(result, { i, j })
			end
		end
	end

	if not (#result > 1) then
		return result
	end

	for _, v in ipairs(result) do
		local v2 = {}

		for i, list2 in ipairs(result) do
			local flag = false

			for _, v3 in ipairs(list2) do
				if not (v3 == v[1] or v3 == v[2]) then
					continue
				end

				flag = true
				break
			end

			if flag then
				table.insert(v2, i)
			end
		end

		if #v2 > 0 then
			local v3 = v2[1]
			result[v3] = module.MergeTables(result[v3], v, true)

			for i = #v2, 2, -1 do
				local v4 = v2[i]
				result[v3] = module.MergeTables(result[v3], result[v4], true)
				table.remove(result, v4)
			end
		else
			table.insert(result, v)
		end
	end

	for i, v in ipairs(result) do
		if #v > 2 then
			result[i] = module.RemoveDuplicatesFromTable(v)
		end
	end

	return result
end

local function fn2(spawns, list)
	local v = {}

	for _, list2 in ipairs(list) do
		for _, v2 in ipairs(list2) do
			table.insert(v, v2)
		end
	end

	table.sort(v)

	for i = #v, 1, -1 do
		table.remove(spawns, v[i])
	end

	return spawns
end

function SpawnDungeonChests(object)
	local _ = { x_, x__, x___, x____ }
	local v = WeakResource("/SF/Types/Gameplay/LootChestSpawnHidden")
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.TotalNumberOfHiddenSpawns = 0
	__wf_atom_e919fb8e.TotalNumberOfNormalSpawns = 0
	local v2 = {
		uncommon = __wf_atom_421b01aa(chanceToBeUncommonChest + chanceToBeRareChest, 0, 1),
		rare = chanceToBeRareChest
	}
	local v3 = {
		uncommon = __wf_atom_421b01aa(
			math.min(1, 1 - (chanceToBeRareChest + chanceToBeUncommonChest) * hiddenChestChanceMult),
			0,
			1
		),
		rare = math.min(1, chanceToBeRareChest * hiddenChestChanceMult)
	}
	local v4 = {
		Connector = { numSpawns = chestSpawnMinMaxSmallTile, chanceMult = 1, variation = 0 },
		Intermediate = { numSpawns = chestSpawnMinMaxLargeTile, chanceMult = 1, variation = 0 },
		["Dead-End"] = {
			numSpawns = Range(chestSpawnTargetDeadEndTile, chestSpawnTargetDeadEndTile),
			chanceMult = 1,
			variation = randomDeadEndSpawnVariation
		},
		Cap = {
			numSpawns = Range(chestSpawnTargetDeadEndTile, chestSpawnTargetDeadEndTile),
			chanceMult = 1,
			variation = randomDeadEndSpawnVariation
		}
	}
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(spawnedObjectTag)

	if debugDrawChests then
		for _, v5 in ipairs(__wf_atom_2226b35c) do
			gRegion:__wf_atom_5b35a0c8(v5:GetPosition(), Color(255, 0, 0), "Hand-Placed Chest", 1, 9999)
		end
	end

	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(spawnPointTag)
	__wf_atom_e919fb8e.TotalNumberOfSPawnPositions = #__wf_atom_2226b35c2

	for i = #__wf_atom_2226b35c2, 1, -1 do
		if debugDrawChests then
			if __wf_atom_2226b35c2[i]:IsA(v) then
				gRegion:__wf_atom_b5c21154(
					__wf_atom_2226b35c2[i]:GetPosition(),
					1,
					Color(128, 128, 0),
					Rotation(0, 90, 0),
					9999
				)
			else
				gRegion:__wf_atom_b5c21154(
					__wf_atom_2226b35c2[i]:GetPosition(),
					1,
					Color(128, 128, 128),
					Rotation(0, 90, 0),
					9999
				)
			end
		end

		for _, v5 in ipairs(__wf_atom_2226b35c) do
			if not (__wf_atom_2226b35c2[i]:__wf_atom_8a6b8fc3(v5) <= 1) then
				continue
			end

			table.remove(__wf_atom_2226b35c2, i)
			break
		end
	end

	local v5 = {}

	for i = 1, #__wf_atom_2226b35c2 do
		local __wf_atom_e800787c = __wf_atom_2226b35c2[i]:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if __wf_atom_7e8ad928(v5[layerIndex]) then
			v5[layerIndex] = {
				tag = tostring(__wf_atom_e800787c:__wf_atom_db682341()),
				numSpawns = 0,
				index = layerIndex,
				spawns = {}
			}
		end

		table.insert(v5[layerIndex].spawns, __wf_atom_2226b35c2[i])
	end

	local streamingExitWaypoint = module.GetStreamingExitWaypoint()
	local v6

	if not __wf_atom_7e8ad928(streamingExitWaypoint) then
		v6 = module.GetLayerIndex(streamingExitWaypoint)
		local v7 = v6 - 1

		if not __wf_atom_7e8ad928(v6) then
			local spawns = gRegion:__wf_atom_2226b35c(exitSpawnPointTag)
			local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(exitBossSpawnPointTag)
			local exitBossChestType2

			if #__wf_atom_2226b35c3 >= 1 then
				exitBossChestType2 = exitBossChestType
				spawns = __wf_atom_2226b35c3
			else
				exitBossChestType2 = rareChestType
			end

			for i = #spawns, 1, -1 do
				local __wf_atom_e800787c = spawns[i]:__wf_atom_e800787c()

				if __wf_atom_7e8ad928(__wf_atom_e800787c) then
					continue
				end

				local layerIndex = __wf_atom_e800787c:GetLayerIndex()

				if layerIndex < v7 or v6 < layerIndex then
					table.remove(spawns, i)
				end
			end

			if (__wf_atom_7e8ad928(spawns) or #spawns == 0) and not __wf_atom_7e8ad928(v5[v7]) then
				spawns = v5[v7].spawns
			end

			if __wf_atom_7e8ad928(spawns) or not (#spawns > 0) then
				print("Nowhere to spawn the dungeon end chest!")
			else
				local v8 = __wf_atom_5784a397(1, #spawns)
				local spawn = spawns[v8]
				local lootContainer = module2.SpawnLootContainer(
					exitBossChestType2,
					spawn:GetPosition(),
					spawn:__wf_atom_dc309f8a(),
					true,
					nil,
					spawn
				)
				count3 += 1
				module3.LogProcLootChestSpawnedStats(lootContainer)
				table.remove(spawns, v8)
			end
		end
	end

	if module.HasStreamedLevel(coopOnlyLevels) then
		coopRareChest2 = coopRareChest
	else
		coopRareChest2 = rareChestType
	end

	local v7 = {}

	for _, v8 in pairs(v5) do
		local spawns = {}
		local spawns2 = {}

		for _, spawn in ipairs(v8.spawns) do
			if spawn:IsA(v) then
				table.insert(spawns, spawn)
			else
				table.insert(spawns2, spawn)
			end
		end

		local v9 = fn(module.CopyTable(spawns), clusteredHiddenSpawnsMaxRange)

		for _, list in ipairs(v9) do
			table.insert(v7, {})

			for _, v10 in ipairs(list) do
				table.insert(v7[#v7], spawns[v10])
			end
		end

		if #v9 > 0 then
			spawns = fn2(spawns, v9)
		end

		v8.spawns = module.MergeTables(spawns, spawns2)
	end

	for _, v8 in pairs(v5) do
		if __wf_atom_7e8ad928(v4[v8.tag]) then
			v8.spawnScaling = v4.Connector
		else
			v8.spawnScaling = v4[v8.tag]
		end

		if v8.tag == "Intermediate" then
			local v9 = math.max(#v8.spawns - largeRoomApproxNumSpawnpoints.minValue, 0) / (largeRoomApproxNumSpawnpoints.maxValue - largeRoomApproxNumSpawnpoints.minValue)
			v8.numSpawns = __wf_atom_104bfe98(
				v8.spawnScaling.numSpawns.minValue,
				v8.spawnScaling.numSpawns.maxValue,
				(math.min(v9, 1))
			)
		else
			v8.numSpawns = __wf_atom_5784a397(v8.spawnScaling.numSpawns.minValue, v8.spawnScaling.numSpawns.maxValue)
			local variation = v8.spawnScaling.variation

			if variation > 0 and math.random() <= 0.5 then
				variation = -variation
			end

			v8.numSpawns += variation
		end

		v8.numSpawns = module.RandomRound(v8.numSpawns)
		v8.numSpawns = math.min(v8.numSpawns, #v8.spawns)
		local _ = #v8.spawns
		v8.spawns = module.RandomizeTableOrder(v8.spawns)
		local spawns = {}

		for i = #v8.spawns, 1, -1 do
			if not v8.spawns[i]:IsA(v) then
				continue
			end

			table.insert(spawns, v8.spawns[i])
			table.remove(v8.spawns, i)
		end

		v8.numSpawns = math.min(v8.numSpawns + #spawns, #v8.spawns + #spawns)

		for _ = 1, v8.numSpawns - #spawns do
			local v9 = __wf_atom_5784a397(1, #v8.spawns)
			table.insert(spawns, v8.spawns[v9])
			table.remove(v8.spawns, v9)
		end

		v8.spawns = spawns
	end

	local v8 = { objType = commonChestType, text = "Common", textColor = Color(192, 192, 192) }
	local v9 = { objType = uncommonChestType, text = "Uncommon", textColor = Color(128, 255, 128) }
	local v10 = { objType = rareChestType, text = "Rare", textColor = Color(255, 200, 0) }

	if #v7 == 0 then
		v3.rare = __wf_atom_421b01aa(v3.rare * spawnChanceMultiplierIfNoWrinklePuzzles, 0, 1)
		v3.uncommon = __wf_atom_421b01aa(v3.uncommon * spawnChanceMultiplierIfNoWrinklePuzzles, 0, 1)
	end

	for k, v11 in pairs(v5) do
		if not (v11.numSpawns > 0 and k ~= v6) then
			continue
		end

		for _ = 1, v11.numSpawns do
			local v12 = __wf_atom_5784a397(1, #v11.spawns)
			local spawn = v11.spawns[v12]
			local v13, flag

			if spawn:IsA(v) then
				v13 = v3
				flag = true
			else
				v13 = v2
				flag = false
			end

			local v14 = math.random()
			local v15

			if
				v14 <= __wf_atom_421b01aa(v13.rare * v11.spawnScaling.chanceMult, 0, 1)
				and not __wf_atom_7e8ad928(v10.objType)
			then
				count3 += 1

				if flag then
					count5 += 1
				end

				v15 = v10
			elseif
				v14 <= __wf_atom_421b01aa(v13.uncommon * v11.spawnScaling.chanceMult, 0, 1)
				and not __wf_atom_7e8ad928(v9.objType)
			then
				count2 += 1
				v15 = v9
			else
				count += 1
				v15 = v8
			end

			local lootContainer = module2.SpawnLootContainer(
				v15.objType,
				spawn:GetPosition(),
				spawn:__wf_atom_dc309f8a(),
				true,
				nil,
				spawn
			)
			local __wf_atom_e919fb8e_2 = lootContainer:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.ChestRarity = v15.text
			module3.LogProcLootChestSpawnedStats(lootContainer)
			table.remove(v11.spawns, v12)
		end
	end

	for _, list in ipairs(v7) do
		local count6 = 0

		for _, v11 in ipairs(list) do
			if count6 ~= 0 and (count6 ~= 1 or not (math.random(0, 1) < clusteredBonusChestSpawnChance)) then
				break
			end

			local lootContainer = module2.SpawnLootContainer(
				rareChestType,
				v11:GetPosition(),
				v11:__wf_atom_dc309f8a(),
				true,
				nil,
				v11
			)
			count3 += 1
			count4 += 1
			module3.LogProcLootChestSpawnedStats(lootContainer)
			count6 += 1
		end
	end

	_T.LootChestsSpawned = true
end

function SpawnDungeonWeaponRacks(_)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(spawnedObjectTag)

	if debugDrawChests then
		for _, v in ipairs(__wf_atom_2226b35c) do
			gRegion:__wf_atom_5b35a0c8(v:GetPosition(), Color(255, 0, 0), "Hand-Placed Weapon Rack", 1, 9999)
		end
	end

	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(spawnPointTag)
	local v = {}

	for i = 1, #__wf_atom_2226b35c2 do
		local __wf_atom_e800787c = __wf_atom_2226b35c2[i]:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if __wf_atom_7e8ad928(v[layerIndex]) then
			v[layerIndex] = {
				tag = tostring(__wf_atom_e800787c:__wf_atom_db682341()),
				numSpawns = 0,
				index = layerIndex,
				spawns = {}
			}
		end

		table.insert(v[layerIndex].spawns, __wf_atom_2226b35c2[i])
	end

	local v2 = {}

	for _, v3 in pairs(v) do
		local maxSpawnsInSmallTile = maxSpawnsInSmallTile

		if v3.tag == "Intermediate" then
			maxSpawnsInSmallTile = maxSpawnsInLargeTile
		end

		local v4 = math.min(maxSpawnsInSmallTile, #v3.spawns)
		v3.spawns = module.RandomizeTableOrder(v3.spawns)

		for i = 1, v4 do
			table.insert(v2, v3.spawns[i])
		end
	end

	local v3 = math.min(__wf_atom_5784a397(totalToSpawnInLevel.minValue, totalToSpawnInLevel.maxValue), #v2)
	local randomizeTableOrder = module.RandomizeTableOrder(v2)
	local count6 = 0

	for i = 1, v3 do
		local lootContainer = module2.SpawnLootContainer(
			commonChestType,
			randomizeTableOrder[i]:GetPosition(),
			randomizeTableOrder[i]:__wf_atom_dc309f8a(),
			true
		)
		module3.LogProcLootChestSpawnedStats(lootContainer)
		count6 += 1

		if destroySpawnPointObjectOnSpawned then
			randomizeTableOrder[i]:Destroy()
		end
	end
end

function RunScriptTrigger(object)
	module.WaitForLevel()
	object:FirePort("Execute")
end