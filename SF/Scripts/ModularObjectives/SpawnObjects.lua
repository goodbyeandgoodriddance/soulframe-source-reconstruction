local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("Lotus.Scripts.Libs.Query")
local v = {}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = nil
local v6 = nil
local v7 = nil
local position = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil

local function fn()
	local v12 = math.max(v6:__wf_atom_103377cc(), 15)
	local position2 = v6:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(objectSpawnTagWithContainer, position2, 0, v12)
	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(objectSpawnTag, position2, 0, v12)
	local spawnPts = module.MergeTables(__wf_atom_439c0d29, __wf_atom_439c0d29_2, true)

	if canSpawnAtLootChestSpawns and (__wf_atom_7e8ad928(spawnPts) or #spawnPts == 0) then
		local encounterLootSpawns = module3.GetEncounterLootSpawns(position2, Range(0, v12), 1, true, true, true)
		spawnPts = {}

		for _, encounterLootSpawn in ipairs(encounterLootSpawns) do
			table.insert(spawnPts, encounterLootSpawn.spawnPt)
		end
	end

	local __wf_atom_ba2e9888 = v6:__wf_atom_ba2e9888()

	if __wf_atom_ba2e9888 > 0 then
		for i = #spawnPts, 1, -1 do
			local position3 = spawnPts[i]:GetPosition()

			if position3.y < position2.y - 5 or position3.y > position2.y + __wf_atom_ba2e9888 then
				table.remove(spawnPts, i)
			end
		end
	end

	local __wf_atom_5e5adb53 = v10:__wf_atom_5e5adb53(v6)

	for i = #spawnPts, 1, -1 do
		if v10:__wf_atom_5e5adb53(spawnPts[i]) ~= __wf_atom_5e5adb53 then
			table.remove(spawnPts, i)
		end
	end

	return spawnPts
end

local function fn2(object)
	if __wf_atom_7e8ad928(containerDecos) or #containerDecos == 0 then
		return false
	end

	if objectSpawnTagWithContainer == EMPTY_SYMBOL and objectSpawnTag == EMPTY_SYMBOL then
		return true
	end

	local v12 = Symbol("LootChestSpawnPt")
	local __wf_atom_db682341 = object:__wf_atom_db682341()

	if __wf_atom_db682341 == objectSpawnTagWithContainer or __wf_atom_db682341 == v12 then
		return true
	end
end

local function fn3(p)
	local navSpawnRadius = navSpawnRadius

	if navSpawnRadius <= 0 then
		navSpawnRadius = v6:__wf_atom_103377cc()
	end

	local v12 = math.max(navSpawnRadius, 15)
	local __wf_atom_28ce676a = v10:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(0, v12), 3)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(queryAngleLimit)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(navEdgeDistanceFilter, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("SimpleSpawnObjects.lua"), Color("0xFF00FF"))

	if spawnOnRoad then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(true)
	end

	local positions = module6.GetPositions(p, __wf_atom_28ce676a)

	if spawnOnRoad and #positions == 0 then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
		positions = module6.GetPositions(p, __wf_atom_28ce676a)
	end

	return positions
end

local function fn4(list, yokeStatueSpawnTag) -- 1 equivalent call inferred from this helper
	for _, v12 in ipairs(list) do
		if v12:HasTag(yokeStatueSpawnTag) then
			return v12
		end
	end
end

local function fn5()
	v5 = fn()
	v = {}
	local v12 = fn3(numItems)
	local navSpawnRadius = navSpawnRadius

	if navSpawnRadius <= 0 then
		navSpawnRadius = v6:__wf_atom_103377cc()
	end

	local v13 = math.max(navSpawnRadius, 15)

	for i = 1, numItems do
		local position2 = nil
		local v14 = nil
		local v15 = nil
		local __wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
		local v16

		if randomizeObjectTypes then
			v16 = __wf_atom_5784a397(1, #objectTypes)
		else
			v16 = math.min(i, #objectTypes)
		end

		local objectType = objectTypes[v16]

		if not __wf_atom_7e8ad928(spawnOffsets[v16]) then
			__wf_atom_28d5d4aa2 = spawnOffsets[v16]
		end

		local v17 = false

		if __wf_atom_7e8ad928(v5) or not (#v5 > 0) then
			if not __wf_atom_7e8ad928(v6) then
				local v18

				if __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v12[i]) then
					v18 = v10:__wf_atom_0e0a6fee(position) or position
					print("No tac map spawnpoint found!")
				else
					v18 = v12[i]
				end

				v14 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

				if __wf_atom_7e8ad928(mustSpawnUpright[v16]) or not mustSpawnUpright[v16] then
					position2, v14 = module4.GetGroundAlignedSpawnPosRot(objectType, v18, v14)
				else
					position2 = module4.GetGroundPos(v18)
				end

				if __wf_atom_7e8ad928(position2) then
					if __wf_atom_7e8ad928(v18) then
						position2 = position
						print("Error spawning object, using hint fallback position")
					else
						print("Error spawning object, using navmesh fallback position")
						position2 = v18
					end
				end
			end
		else
			local v18 = __wf_atom_5784a397(1, #v5)
			v15 = v5[v18]
			position2 = v15:GetPosition()
			v14 = v15:__wf_atom_dc309f8a()
			v17 = true
			table.remove(v5, v18)

			if not __wf_atom_7e8ad928(mustSpawnUpright[v16]) and mustSpawnUpright[v16] then
				v14 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			end
		end

		if __wf_atom_7e8ad928(v15) or fn2(v15) then
			local containerDeco = containerDecos[__wf_atom_5784a397(1, #containerDecos)]

			if not __wf_atom_7e8ad928(containerDeco) then
				if not v17 then
					position2, v14 = module4.GetGroundAlignedSpawnPosRot(containerDeco, position2, v14)
				end

				local entity = gRegion:CreateEntity(containerDeco, position2, v14)
				v7:__wf_atom_d494454b(entity)
				Sleep(0)
				local __wf_atom_f582136d = entity:__wf_atom_f582136d(__wf_atom_8d0b7f88)

				for j = #__wf_atom_f582136d, 1, -1 do
					if __wf_atom_f582136d[j]:__wf_atom_db682341() ~= containerAttachTag then
						table.remove(__wf_atom_f582136d, j)
					end
				end

				if __wf_atom_7e8ad928(__wf_atom_f582136d) or not (#__wf_atom_f582136d > 0) then
					position2, v14 = module4.GetGroundAlignedSpawnPosRot(
						objectType,
						position2,
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
				else
					local v18 = __wf_atom_5784a397(1, #__wf_atom_f582136d)
					position2 = __wf_atom_f582136d[v18]:GetPosition()
					v14 = __wf_atom_f582136d[v18]:__wf_atom_dc309f8a()
				end
			end
		end

		v[i] = gRegion:CreateEntity(objectType, position2 + __wf_atom_28d5d4aa2, v14)
		v2[i] = v[i]:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		v3[i] = false

		if not __wf_atom_7e8ad928(v[i]) then
			print("Spawned object " .. v[i]:GetName())
			print(v[i]:GetPosition())
		end

		if spawnYokeObjects then
			v4[i] = fn4(v[i]:__wf_atom_be0bea4a(), yokeStatueSpawnTag) -- inferred equivalent call
		end

		if addSparrowDestination then
			module2.AddSparrowDestination(
				v[i],
				v6,
				nil,
				module2.PRIORITY.TALE,
				Range(sparrowMinRadius, v6:__wf_atom_8f18e876()),
				nil,
				nil,
				nil,
				true
			)
		end

		if not __wf_atom_7e8ad928(soulModeAttachType) then
			v[i]:Attach(soulModeAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v[i], 1)
		end

		v7:__wf_atom_d494454b(v[i])

		if i == 1 and moveHintPosition then
			v7:__wf_atom_c53e1842(position2)
		end

		if not (#randomAmbientEncounters > 0) then
			continue
		end

		local randomAmbientEncounter = randomAmbientEncounters[__wf_atom_5784a397(1, #randomAmbientEncounters)]

		if __wf_atom_7e8ad928(randomAmbientEncounter) then
			continue
		end

		v10:AddEncounter(randomAmbientEncounter)
		v10:__wf_atom_c4c644af(position2, randomAmbientEncounter, v6)
	end

	if #v == 0 then
		print("No objects spawned!")
		return false
	end

	local __wf_atom_fe00d825 = v6:__wf_atom_fe00d825()

	for _, v14 in ipairs(__wf_atom_fe00d825) do
		if not v14:IsA(__wf_atom_0f520c3c) then
			continue
		end

		v14:__wf_atom_400189c4(v13 + 5)
		break
	end

	return true
end

local function fn6(fallbackResourceType)
	local v12 = WeakResource("/SF/Types/PickUps/Resources/Textiles/BrineflossManualPickup")
	local v13 = WeakResource("/SF/Types/PickUps/LootContainers/Holiday/LootScarecrow")
	local v14 = WeakResource("/SF/Objects/Events/WinterSolstice/BirdFeederBaseDeco")

	if fallbackResourceType:IsA(v12) or fallbackResourceType:IsA(v13) or fallbackResourceType:IsA(v14) then
		return true
	end

	return false
end

local function fn7(taleResourceDropTable)
	if __wf_atom_7e8ad928(taleResourceDropTable) then
		return fallbackResourceType
	end

	local v12 = {
		WeakResource("/SF/Weapons/OneOffWeapons/OneOffWeaponBasePickUp"),
		WeakResource("/SF/Types/PickUps/Resources/Organics/RiverPearlManualPickup")
	}
	local count = 0
	local v13 = nil

	while count < 3 and v13 == nil do
		local __wf_atom_6ba3aebe = taleResourceDropTable:__wf_atom_6ba3aebe(
			v7,
			EMPTY_SYMBOL,
			0,
			__wf_atom_28d5d4aa,
			__wf_atom_28d5d4aa,
			false,
			position + Vector(0, -100, 0),
			__wf_atom_80368bb1
		)

		for i = #__wf_atom_6ba3aebe, 1, -1 do
			v13 = v13 or Type(__wf_atom_6ba3aebe[i]:__wf_atom_1bb5b1ff())

			for _, className in ipairs(v12) do
				if __wf_atom_7e8ad928(v13) or not v13:IsA(className) then
					continue
				end

				v13 = nil
			end

			gRegion:__wf_atom_dd1e4d10(__wf_atom_6ba3aebe[i])
		end

		count += 1
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v13) then
		print("Using fallback type " .. fallbackResourceType:__wf_atom_5b41f63b())
		return fallbackResourceType
	end

	print("Rolled " .. v13:__wf_atom_5b41f63b())
	return v13
end

local function fn8()
	if v7:__wf_atom_2b1fe281() == 1 then
		print("Found registered objects")
		v11 = math.min(numToGather, #v3)
		return false
	else
		local v12 = math.max(numToGather, __wf_atom_5784a397(randomNumToSpawn.minValue, randomNumToSpawn.maxValue))
		local v13 = fn3(v12 * 5)
		local v14

		if #v13 > 0 then
			v14 = { v13[1] }
			table.remove(v13, 1)

			while #v13 > 0 do
				local v15 = __wf_atom_5784a397(1, #v13)
				local flag = true

				for _, v16 in ipairs(v14) do
					if not (Distance(v16, v13[v15]) < 12) then
						continue
					end

					flag = false
					break
				end

				if flag then
					table.insert(v14, v13[v15])
				end

				table.remove(v13, v15)
			end
		end

		print("Spawning new objects")

		while __wf_atom_7e8ad928(_T.taleResourceDropTables) do
			Sleep(0)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(v7) then
			print("Early out for streaming, no density volume")
			return
		end

		local green = __wf_atom_0a6a5887:GetColor(position, false).green
		local fallbackResourceType2 = fn7(_T.taleResourceDropTables[green + 1])
		local v15 = fn6(fallbackResourceType2)
		local __wf_atom_1aa27d44 = fallbackResourceType2:__wf_atom_1aa27d44()

		if __wf_atom_7e8ad928(__wf_atom_1aa27d44) then
			print("Item not found for " .. fallbackResourceType2:__wf_atom_5b41f63b() .. "! Falling back to default item type " .. fallbackResourceType:__wf_atom_5b41f63b())
			fallbackResourceType2 = fallbackResourceType
			v15 = fn6(fallbackResourceType2)
			__wf_atom_1aa27d44 = fallbackResourceType2:__wf_atom_1aa27d44()
		end

		print("Item type is " .. __wf_atom_1aa27d44:__wf_atom_5b41f63b())
		v9 = __wf_atom_1aa27d44:__wf_atom_014a76a2()
		local v16 = math.max(v6:__wf_atom_103377cc(), 15)
		local all = gRegion:FindAll(fallbackResourceType2, position, 0, v16)

		for i, v17 in ipairs(all) do
			table.insert(v, v17)
			v2[i] = v[i]:__wf_atom_a3d1d403(true)

			if addSparrowDestination then
				module2.AddSparrowDestination(
					v17,
					v6,
					nil,
					module2.PRIORITY.TALE,
					Range(sparrowMinRadius, v6:__wf_atom_8f18e876()),
					nil,
					nil,
					nil,
					true
				)
			end
		end

		local v17 = math.max(v12 - #v, 0)
		print("numToSpawn = " .. v17)

		for i = 1, v17 do
			local position2 = nil
			local v18 = nil
			local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

			if __wf_atom_7e8ad928(v5) or not (#v5 > 0) then
				if not __wf_atom_7e8ad928(v6) then
					local v19

					if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v14[i]) then
						v19 = v10:__wf_atom_a70d9d07(position, v16, true, 0.5)
						print("No tac map spawnpoint found!")
					else
						v19 = v14[i]
					end

					local v20 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					local v21, v22

					if v15 then
						v21 = module4.GetGroundPos(v19)
						v22 = v20
					else
						v21, v22 = module4.GetGroundAlignedSpawnPosRot(fallbackResourceType2, v19, v20)
					end

					position2 = v21 or v19 or position
					v18 = v22 or v20
				end
			else
				local v19 = __wf_atom_5784a397(1, #v5)
				local v20 = v5[v19]
				position2 = v20:GetPosition()
				v18 = v20:__wf_atom_dc309f8a()
				table.remove(v5, v19)

				if v15 then
					v18 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
				end
			end

			local entity = gRegion:CreateEntity(fallbackResourceType2, position2 + __wf_atom_28d5d4aa, v18)

			if __wf_atom_7e8ad928(entity) then
				print("Failed to create pickup! " .. fallbackResourceType2:__wf_atom_5b41f63b() .. " " .. tostring(position2) .. " " .. tostring(v18))
			else
				if addSparrowDestination then
					module2.AddSparrowDestination(
						entity,
						v6,
						nil,
						module2.PRIORITY.TALE,
						Range(sparrowMinRadius, v6:__wf_atom_8f18e876()),
						nil,
						nil,
						nil,
						true
					)
				end

				table.insert(v, entity)
				local count = #v
				v2[count] = v[count]:__wf_atom_a3d1d403(true)
			end
		end

		if #v == 0 then
			print("No objects spawned!")
			return false
		end

		for i = 1, #v do
			if not __wf_atom_7e8ad928(soulModeAttachType) then
				v[i]:Attach(soulModeAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v[i], 1)
			end

			v3[i] = false
			v6:__wf_atom_d494454b(v[i])
		end

		if #randomAmbientEncounters > 0 then
			local randomAmbientEncounter = randomAmbientEncounters[__wf_atom_5784a397(1, #randomAmbientEncounters)]

			if not __wf_atom_7e8ad928(randomAmbientEncounter) then
				v10:AddEncounter(randomAmbientEncounter)
				v10:__wf_atom_c4c644af(position, randomAmbientEncounter, v6)
			end
		end

		local __wf_atom_fe00d825 = v6:__wf_atom_fe00d825()

		for _, v18 in ipairs(__wf_atom_fe00d825) do
			if not v18:IsA(__wf_atom_0f520c3c) then
				continue
			end

			v18:__wf_atom_400189c4(v16)
			break
		end

		v11 = math.min(numToGather, #v3)
		v7:__wf_atom_8776856a(1)
		return true
	end
end

local function fn9(p, p2)
	local count = 0

	for _, v12 in ipairs(v3) do
		if v12 then
			count += 1
		end
	end

	local v12 = p2 or #v3

	if __wf_atom_7e8ad928(v9) then
		module5.UpdateOrAddHudCounterTask(p, nil, nil, count, v12)
	else
		module5.UpdateOrAddHudCounterTask(p, nil, "/SF/Language/Objectives/GatherResourceDesc", count, v12, {
			TextParams = { RESOURCE = tostring(v9) }
		})
	end
end

local function fn10(object, fn11)
	v10 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	object:__wf_atom_8e6fec76(1)
	v6 = object:__wf_atom_26b04ea9() or object

	if v6 ~= object and not __wf_atom_7e8ad928(v6:__wf_atom_dd85e6db()) then
		while not __wf_atom_7e8ad928(v6) and v6:__wf_atom_4026dfb5() < 2 do
			Sleep(0)
		end
	end

	v7 = object

	if __wf_atom_7e8ad928(v6) then
		position = v7:GetPosition()
	else
		position = v6:GetPosition()
	end

	v8 = object:__wf_atom_dd85e6db()
	module.StartPluginScripts(setupScripts, object)

	if fn11() then
		local __wf_atom_c1f3dd00 = v8:__wf_atom_c1f3dd00()

		if not __wf_atom_7e8ad928(__wf_atom_c1f3dd00) and __wf_atom_c1f3dd00 ~= EMPTY_SYMBOL then
			if showHudCount then
				fn9(object, v11)
			else
				module5.UpdateOrAddHudTask(object)
			end
		end

		module.StartPluginScripts(pluginScripts, object)
		print("Setup complete")
	else
		print("Early out at SetupRetrieveItems")
		object:__wf_atom_8e6fec76(6)
	end
end

local function fn11()
	while not module3.PrimedMissionShouldShutDown(v7, v6) do
		for i = #v2, 1, -1 do
			if
				v3[i]
				or not __wf_atom_7e8ad928(v2[i])
				and (not useRetrieveActionIsEnabledCheck or v2[i]:IsEnabled())
				and (useActionDestroyedCheck or not v2[i]:__wf_atom_272baebc())
			then
				local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			else
				print("Retrieved action " .. i)

				if not spawnYokeObjects or v4[i] == nil or not v4[i]:HasTag(yokeStatueSpawnTag) then
					v3[i] = true
					module2.RemoveSparrowDestination(v[i])
					module2.RemoveCompassDestination(v[i])

					if showHudCount then
						fn9(v7)
					end
				end
			end
		end

		for i = #v, 1, -1 do
			if __wf_atom_7e8ad928(v[i]) and not v3[i] then
				print("Retrieved object " .. i)
				v3[i] = true
				module2.RemoveSparrowDestination(v[i])
				module2.RemoveCompassDestination(v[i])

				if showHudCount then
					fn9(v7)
				end
			else
				local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			end
		end

		local flag = true

		for i = 1, #v3 do
			if v3[i] then
				continue
			end

			flag = false
			break
		end

		if flag then
			return true
		else
			Sleep(0)
		end
	end

	return false
end

local function fn12()
	while not module3.PrimedMissionShouldShutDown(v7, v6) do
		for i = 1, #v2 do
			if __wf_atom_7e8ad928(v2[i]) or v2[i]:__wf_atom_272baebc() then
				if not v3[i] then
					v3[i] = true
					module2.RemoveSparrowDestination(v[i])
					module2.RemoveCompassDestination(v[i])

					if showHudCount then
						fn9(v7, v11)
					end
				end
			else
				local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			end
		end

		local count = 0

		for i = 1, #v3 do
			if v3[i] then
				count += 1
			end
		end

		if v11 <= count then
			return true
		else
			Sleep(0)
		end
	end

	return false
end

local function fn13(p)
	if __wf_atom_7e8ad928(v7) then
		return
	end

	module2.RemoveAllCompassDestinationsForOwner(v6)

	if p or v7:__wf_atom_4026dfb5() == 4 then
		print("Retrieve item encounter succeeded - done: " .. tostring(p) .. " or we are successful? " .. tostring(v7:__wf_atom_4026dfb5() == 4))
		v7:__wf_atom_8e6fec76(4)
		module5.CompleteHudTask(v7)
		Sleep(4)

		if __wf_atom_7e8ad928(v7) then
			return
		end

		module5.RemoveHudGroup(v7)

		if transientTaskXp > 0 then
			module.GiveXpToPlayersInRadius(transientTaskXp, v7:GetPosition(), 40)
		end

		for _, v12 in ipairs(v) do
			module2.RemoveSparrowDestination(v12)
			module2.RemoveCompassDestination(v12)
		end

		if v7:__wf_atom_e464a32f() > 0 then
			if module.IsInOverworld() then
				while not __wf_atom_7e8ad928(v7) and v10:__wf_atom_c6f505f2(v7) > 0 do
					Sleep(0)
				end
			else
				while
					not __wf_atom_7e8ad928(v7)
					and v7:__wf_atom_4026dfb5() ~= 6
					and not Game.__wf_atom_2b221245(false)
				do
					Sleep(0)
				end
			end
		end
	else
		print("Retrieve item encounter shutdown")
		v7:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v7) then
		return
	end

	v7:__wf_atom_8776856a(0)
	module5.RemoveHudGroup(v7)
	module3.RemoveObjects(v7)
end

function Main(object)
	local v12 = tostring(object:__wf_atom_db682341()) or ""
	print("Retrieve item encounter started " .. v12)
	fn10(object, function()
		return (fn5())
	end)
	object:__wf_atom_8e6fec76(2)
	fn13(fn11())
	print("Retrieve item encounter done: " .. v12)
end

function RetrieveResources(object)
	local v12 = tostring(object:__wf_atom_db682341()) or ""
	print("Retrieve resources encounter started " .. v12)
	fn10(object, function()
		return fn8()
	end)
	object:__wf_atom_8e6fec76(2)
	fn13(fn12())
	print("Retrieve resources encounter done" .. v12)
end

function RetrieveEncounterOnPrimed(p)
	module3.SetEncounterBoostEnemies(p, true)
end

function RetrieveContextAction(instance, object)
	if not gRegion:IsMaster() then
		return
	end

	if xpAmount > 0 then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v12 in ipairs(__wf_atom_ef7900cf) do
			module.GiveXpToPlayer(xpAmount, v12)
		end
	end

	if not __wf_atom_7e8ad928(itemToGive) then
		object:GiveItem(itemToGive, false)
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end