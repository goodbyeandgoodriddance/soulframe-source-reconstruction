local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("SF.Scripts.Libs.StatsLib")
local v = {}
local v2 = {}
local v3 = {}
local positions = {}
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = {}
local v8 = nil
local v9 = nil
local v10 = nil

local function fn()
	local v11

	if not (__wf_atom_7e8ad928(objectSpawnTagWithContainer) or objectSpawnTagWithContainer == EMPTY_SYMBOL) then
		v11 = gRegion:__wf_atom_2226b35c(objectSpawnTagWithContainer)
	end

	local v12

	if not (__wf_atom_7e8ad928(objectSpawnTag) or objectSpawnTag == EMPTY_SYMBOL) then
		v12 = gRegion:__wf_atom_2226b35c(objectSpawnTag)
	end

	local mergeTables = module.MergeTables(v11, v12, true)

	if __wf_atom_7e8ad928(mergeTables) or #mergeTables == 0 then
		mergeTables = module3.GetAvailableLootCrateSpawns()
	end

	return mergeTables
end

local function fn2()
	local __wf_atom_103377cc = v6:__wf_atom_103377cc()
	local position = v6:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(objectSpawnTagWithContainer, position, 0, 50)
	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(objectSpawnTag, position, 0, __wf_atom_103377cc)
	return (module.MergeTables(__wf_atom_439c0d29, __wf_atom_439c0d29_2, true))
end

local function fn3(object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(containerDecos) or #containerDecos == 0 then
		return false
	end

	if
		objectSpawnTagWithContainer == EMPTY_SYMBOL and objectSpawnTag == EMPTY_SYMBOL
		or object:__wf_atom_db682341() == objectSpawnTagWithContainer
	then
		return true
	end
end

local function fn4(object)
	if module.IsInOverworld() and not __wf_atom_7e8ad928(v6) then
		v5 = fn2()
	else
		v5 = fn()
	end

	v = {}
	local v11 = false

	if not module.IsInOverworld() then
		local v12 = {}

		if not __wf_atom_7e8ad928(_T.GetSpawnDoorPairs) then
			local spawnDoorPairs = _T.GetSpawnDoorPairs(v9, v5)

			if not __wf_atom_7e8ad928(spawnDoorPairs) and #spawnDoorPairs > 0 then
				local v13 = __wf_atom_5784a397(1, #spawnDoorPairs)
				v12 = { spawnDoorPairs[v13].spawn }
				spawnDoorPairs[v13].door:FirePort("TriggerPort")
				spawnDoorPairs[v13].statue:FirePort("TriggerPort")
				spawnDoorPairs[v13].scriptTrigger:FirePort("Execute")
				v10 = gRegion:__wf_atom_f738b4af(
					Symbol("LightMirrorMoverTarget"),
					spawnDoorPairs[v13].statue:GetPosition(),
					0,
					5
				)
				v4 = spawnDoorPairs[v13]
				module2.AddSparrowDestination(v10, v6, nil, module2.PRIORITY.HIGH)
				module2.RemoveSparrowDestination(object)
				v11 = true
			end
		end

		if #v12 == 0 then
			local entranceWaypoint = module.GetEntranceWaypoint()
			local exitWaypoint = module.GetExitWaypoint()

			if not (__wf_atom_7e8ad928(entranceWaypoint) or __wf_atom_7e8ad928(exitWaypoint)) then
				local __wf_atom_57856d42 = v8:__wf_atom_57856d42(
					entranceWaypoint:GetPosition(),
					exitWaypoint:GetPosition()
				)

				if __wf_atom_57856d42 == 0 then
					__wf_atom_57856d42 = math.max(entranceWaypoint:__wf_atom_1c8f7b2d(exitWaypoint), 500)
				end

				local v13 = __wf_atom_57856d42 * 0.8

				for i = #v5, 1, -1 do
					if #v5 <= 1 then
						break
					end

					if v13 < v5[i]:__wf_atom_1c8f7b2d(exitWaypoint) then
						table.remove(v5, i)
					end
				end
			end
		else
			v5 = v12
		end
	end

	for i = 1, numItems do
		local position = nil
		local v12 = nil
		local v13 = nil

		if __wf_atom_7e8ad928(v5) or not (#v5 > 0) then
			if not __wf_atom_7e8ad928(v6) then
				position = v6:GetPosition()
				v12 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			end
		else
			local v14 = __wf_atom_5784a397(1, #v5)
			v13 = v5[v14]
			position = v13:GetPosition()
			v12 = v13:__wf_atom_dc309f8a()
			table.remove(v5, v14)
		end

		local v14, v15, v16, v17, v18, v19

		if __wf_atom_7e8ad928(v13) then
			v14 = containerDecos[__wf_atom_5784a397(1, #containerDecos)]

			if not __wf_atom_7e8ad928(v14) then
				v15, v16 = module4.GetGroundAlignedSpawnPosRot(v14, position, v12)
				v17 = gRegion:CreateEntity(v14, v15, v16)
				object:__wf_atom_d494454b(v17)
				Sleep(0)
				v18 = v17:__wf_atom_f582136d(__wf_atom_8d0b7f88)

				for j = #v18, 1, -1 do
					if v18[j]:__wf_atom_db682341() ~= Symbol("ScrollPlacementDeco") then
						table.remove(v18, j)
					end
				end

				if __wf_atom_7e8ad928(v18) or not (#v18 > 0) then
					position, v12 = module4.GetGroundAlignedSpawnPosRot(
						objectType,
						v15,
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
				else
					v19 = __wf_atom_5784a397(1, #v18)
					position = v18[v19]:GetPosition()
					v12 = v18[v19]:__wf_atom_dc309f8a()
				end
			end
		elseif fn3(v13) then -- inferred equivalent call
			v14 = containerDecos[__wf_atom_5784a397(1, #containerDecos)]

			if not __wf_atom_7e8ad928(v14) then
				v15, v16 = module4.GetGroundAlignedSpawnPosRot(v14, position, v12)
				v17 = gRegion:CreateEntity(v14, v15, v16)
				object:__wf_atom_d494454b(v17)
				Sleep(0)
				v18 = v17:__wf_atom_f582136d(__wf_atom_8d0b7f88)

				for j = #v18, 1, -1 do
					if v18[j]:__wf_atom_db682341() ~= Symbol("ScrollPlacementDeco") then
						table.remove(v18, j)
					end
				end

				if __wf_atom_7e8ad928(v18) or not (#v18 > 0) then
					position, v12 = module4.GetGroundAlignedSpawnPosRot(
						objectType,
						v15,
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
				else
					v19 = __wf_atom_5784a397(1, #v18)
					position = v18[v19]:GetPosition()
					v12 = v18[v19]:__wf_atom_dc309f8a()
				end
			end
		end

		v[i] = gRegion:CreateEntity(objectType, position, v12)
		v2[i] = v[i]:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		v3[i] = false

		if not __wf_atom_7e8ad928(v2[i]) then
			positions[i] = v2[i]:GetPosition()
		end

		if not (addSparrowDestination and __wf_atom_7e8ad928(v10)) then
			continue
		end

		if sparrowAlwaysInRange then
			module2.AddSparrowDestination(v[i], v6, nil, module2.PRIORITY.HIGH)
		else
			module2.AddSparrowDestination(v[i], v6, nil, module2.PRIORITY.HIGH, sparrowDestinationRange)
		end
	end

	if not __wf_atom_7e8ad928(v6) and numTraps.maxValue > 0 then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("AtmosGenSpawn"), v6:GetPosition(), 0, 50)

		if #__wf_atom_439c0d29 > 0 then
			local v12 = __wf_atom_5784a397(numTraps.minValue, (math.min(numTraps.maxValue, #__wf_atom_439c0d29)))

			if v12 > 0 then
				for _ = 1, v12 do
					local v13 = __wf_atom_5784a397(1, #__wf_atom_439c0d29)
					local trapType = trapTypes[__wf_atom_5784a397(1, #trapTypes)]
					object:__wf_atom_d494454b((gRegion:CreateEntity(
						trapType,
						__wf_atom_439c0d29[v13]:GetPosition(),
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)))
					__wf_atom_439c0d29[v13]:FirePort("Disable")
					table.remove(__wf_atom_439c0d29, v13)
				end
			end
		end
	end

	if numNearbyChestsToSpawn.maxValue > 0 and not (__wf_atom_7e8ad928(lootChestType) or __wf_atom_7e8ad928(v[1])) then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("LootSpawn"), v[1]:GetPosition(), 0, 30)
		local v12 = __wf_atom_5784a397(numNearbyChestsToSpawn.minValue, numNearbyChestsToSpawn.maxValue)

		if v12 > 0 then
			local __wf_atom_e800787c = v[1]:__wf_atom_e800787c()

			if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
				__wf_atom_439c0d29 = module.FilterObjectsInZone(__wf_atom_e800787c, __wf_atom_439c0d29)
			end

			for _ = 1, math.min(v12, #__wf_atom_439c0d29) do
				local v13 = __wf_atom_5784a397(1, #__wf_atom_439c0d29)
				object:__wf_atom_d494454b((module3.SpawnLootContainer(
					lootChestType,
					__wf_atom_439c0d29[v13]:GetPosition(),
					__wf_atom_439c0d29[v13]:__wf_atom_dc309f8a()
				)))
			end
		end
	end

	numNearbyChestsToSpawn = Range(2, 2)
	lootChestType = Type()
	return v11
end

function Main(object)
	print("Retrieve item encounter started")
	v8 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	object:__wf_atom_8e6fec76(1)
	v6 = object:__wf_atom_26b04ea9() or object
	v9 = v8:__wf_atom_3c9cb048(object:GetPosition() + Vector(0, 1, 0)) + 1
	local v11 = false

	if enablePuzzleInSameTile then
		v11 = fn4(object)
	else
		fn4(object)
	end

	if v11 and puzzleObjectiveLoc ~= EMPTY_SYMBOL then
		module5.UpdateOrAddHudTask(object, nil, puzzleObjectiveLoc)
		module6.LogProcPuzzleStarted(v4.scriptTrigger, "LightMirrorTaleOnly")
	else
		module5.UpdateOrAddHudTask(object)
	end

	if v11 and not module.IsInOverworld() then
		if not __wf_atom_7e8ad928(v10) then
			local nearestTagged = gRegion:FindNearestTagged(Symbol("VineDoorOppositeSide"), v10:GetPosition())

			if __wf_atom_7e8ad928(nearestTagged) then
				nearestTagged = v10
			end

			local __wf_atom_0e0a6fee = v8:__wf_atom_0e0a6fee(nearestTagged:GetPosition())

			if not __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
				local __wf_atom_57203011 = v8:__wf_atom_57203011()
				local randomEnemyAgentType = module3.GetRandomEnemyAgentType(
					nil,
					nil,
					__wf_atom_57203011,
					v6,
					0,
					2,
					true
				)
				local __wf_atom_dc309f8a = nearestTagged:__wf_atom_dc309f8a()

				if not __wf_atom_7e8ad928(randomEnemyAgentType) then
					object:__wf_atom_97f955c1((v8:__wf_atom_402b3832(
						randomEnemyAgentType,
						__wf_atom_0e0a6fee,
						__wf_atom_dc309f8a,
						Symbol("RandomTeam"),
						__wf_atom_57203011
					)))

					if not __wf_atom_7e8ad928(guardPoiType) then
						object:__wf_atom_d494454b((gRegion:CreateEntity(
							guardPoiType,
							__wf_atom_0e0a6fee,
							__wf_atom_dc309f8a
						)))
					end
				end
			end
		end

		if not __wf_atom_7e8ad928(v[1]) then
			local v12 = WeakResource("/SF/Types/Game/MarkerInfos/EncounterMarkerInfoArea")
			local __wf_atom_fe00d825 = v6:__wf_atom_fe00d825()
			local position = v[1]:GetPosition()

			for _, v13 in ipairs(__wf_atom_fe00d825) do
				if not v13:IsA(v12) then
					continue
				end

				v13:SetPosition(position)
				v13:__wf_atom_400189c4(30)
				break
			end

			if not __wf_atom_7e8ad928(v7[1]) then
				v7[1]:SetPosition(position)
			end
		end
	end

	object:__wf_atom_8e6fec76(2)
	local flag = false
	local v12 = false

	while not module3.PrimedMissionShouldShutDown(object, v6) do
		for i = #v2, 1, -1 do
			if __wf_atom_7e8ad928(v2[i]) or not v2[i]:IsEnabled() then
				v3[i] = true

				if not __wf_atom_7e8ad928(v7[i]) then
					v7[i]:Destroy()
				end
			else
				local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			end
		end

		if _T.DebugDrawDailyLocations then
			local _ = not __wf_atom_7e8ad928(v4)
		end

		flag = true

		for i = 1, #v3 do
			if v3[i] then
				continue
			end

			flag = false
			break
		end

		if not (__wf_atom_7e8ad928(v10) or v10:IsEnabled()) then
			module2.RemoveSparrowDestination(v10)
			module6.LogProcPuzzleSolved(v4.scriptTrigger, "LightMirrorTaleOnly")

			for _, v13 in ipairs(v2) do
				module2.AddSparrowDestination(v13, v6, nil, module2.PRIORITY.HIGH)
			end

			v10 = nil
		end

		if flag then
			if not (#postPickupReinforcementEncounters > 0) or v12 then
				break
			end

			local taggedInTileType = module.FindTaggedInTileType(Symbol("LevelExitWp"), Symbol("Exit"))

			if __wf_atom_7e8ad928(taggedInTileType) or not (#taggedInTileType > 0) then
				break
			end

			local postPickupReinforcementEncounter = postPickupReinforcementEncounters[__wf_atom_5784a397(1, #postPickupReinforcementEncounters)]
			v8:AddEncounter(postPickupReinforcementEncounter)
			v8:__wf_atom_c4c644af(taggedInTileType[1]:GetPosition(), postPickupReinforcementEncounter, v6)
			break
		else
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if flag or object:__wf_atom_4026dfb5() == 4 then
		print("Retrieve item encounter succeeded")
		object:__wf_atom_8e6fec76(4)
		module5.CompleteHudTask(object)
		Sleep(4)

		if __wf_atom_7e8ad928(object) then
			return
		end

		module5.RemoveHudGroup(object)

		for _, v13 in ipairs(v) do
			module2.RemoveSparrowDestination(v13)
		end

		if object:__wf_atom_e464a32f() > 0 then
			if module.IsInOverworld() then
				while not __wf_atom_7e8ad928(object) and v8:__wf_atom_c6f505f2(object) > 0 do
					Sleep(0)
				end
			else
				while
					not __wf_atom_7e8ad928(object)
					and object:__wf_atom_4026dfb5() ~= 6
					and not Game.__wf_atom_2b221245(false)
				do
					Sleep(0)
				end
			end
		end
	else
		print("Retrieve item encounter shutdown")
		object:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	module5.RemoveHudGroup(object)
	module3.RemoveObjects(object)
	print("Retrieve item encounter done")
end

function RetrieveEncounterOnPrimed(_) end

function RetrieveContextAction(instance)
	if not gRegion:IsMaster() then
		return
	end

	if xpAmount > 0 then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v11 in ipairs(__wf_atom_ef7900cf) do
			module.GiveXpToPlayer(xpAmount, v11)
		end
	end

	if not __wf_atom_7e8ad928(ghostAgentType) then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local v11 = { Range(8, 10), Range(15, 17) }

		for i = 1, 2 do
			local randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
				instance:GetPosition(),
				v11[i].minValue,
				v11[i].maxValue,
				true,
				__wf_atom_104bfe98(0.5, 0.8, math.random())
			)
			local __wf_atom_80368bb1 = __wf_atom_80368bb1
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local nearestObject = module.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf)

			if not __wf_atom_7e8ad928(nearestObject) then
				__wf_atom_80368bb1 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
			end

			local __wf_atom_402b3832 = __wf_atom_7d789620:__wf_atom_402b3832(
				ghostAgentType,
				randomPointInRangeOnNav,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
				__wf_atom_402b3832:__wf_atom_30b587a4()
			end
		end
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end