local v = nil
local module = require("Lotus.Scripts.Libs.SpawnObjectsOnTerrain")
local module2 = require("EE.Interface.Utilities")

local function fn()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while __wf_atom_7e8ad928(gClient) or gClient:IsLoading() or not gClient:__wf_atom_2ad290b4() do
		Sleep(0)
	end
end

local function fn2(volume)
	local __wf_atom_80cf57aa = volume:__wf_atom_80cf57aa()
	local __wf_atom_a06d543c = volume:__wf_atom_a06d543c()
	local __wf_atom_acb19668 = volume:__wf_atom_acb19668()
	local v2 = __wf_atom_edfe0d73(__wf_atom_a06d543c, __wf_atom_acb19668) * (__wf_atom_8d119bab(
		-__wf_atom_80cf57aa.x,
		__wf_atom_80cf57aa.x
	) * 0.5) + __wf_atom_acb19668 * (__wf_atom_8d119bab(-__wf_atom_80cf57aa.y, __wf_atom_80cf57aa.y) * 0.5) + __wf_atom_a06d543c * (__wf_atom_8d119bab(
		-__wf_atom_80cf57aa.z,
		__wf_atom_80cf57aa.z
	) * 0.5)
	return volume:GetPosition() + v2
end

local function fn3(volume)
	local v2 = math.random() * 2 * 3.141592653589793
	local v3 = volume:__wf_atom_4e28532a() * math.sqrt((math.random()))
	local v4 = Vector(v3 * math.cos(v2), 0, v3 * math.sin(v2))
	return volume:GetPosition() + v4
end

local function fn4(p, category, maxSpawns, resourceTypes, resourceDropTable, terrainOnly)
	if maxSpawns == 0 or #resourceTypes == 0 then
		return nil
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if #__wf_atom_2226b35c == 0 then
		return nil
	end

	local v2 = {
		category = category,
		spawnCount = 0,
		maxSpawns = maxSpawns,
		resourceTypes = resourceTypes,
		resourceDropTable = resourceDropTable,
		terrainOnly = terrainOnly,
		spawners = {}
	}

	for _, volume in ipairs(__wf_atom_2226b35c) do
		local v3, v4

		if volume:__wf_atom_bbcb227c() then
			v3 = volume:__wf_atom_4e28532a()
			v4 = v3
		elseif volume:__wf_atom_642b7ae0() then
			v3 = volume:__wf_atom_0d6bb7d4()
			v4 = volume:__wf_atom_7bb1d979() * 0.5
		else
			if not volume:__wf_atom_fdefab34() then
				print("ERROR...Tried to init a resource spawner with an unsupported volume.")
				continue
			end

			local __wf_atom_80cf57aa = volume:__wf_atom_80cf57aa()
			v3 = module2.Ternary(
				__wf_atom_80cf57aa.x > __wf_atom_80cf57aa.z,
				__wf_atom_80cf57aa.x,
				__wf_atom_80cf57aa.z
			) * 0.5
			v4 = __wf_atom_80cf57aa.y * 0.5
		end

		local v5 = {
			volume = volume,
			navHorizontalSearchDist = math.min(v3, 50),
			navVerticalSearchDist = math.min(v4, 50),
			spawnedResources = {},
			spawnedPoints = {}
		}
		table.insert(v2.spawners, v5)
	end

	return v2
end

local function fn5(p, resourceDropTable, spawner, data, terrainOnly)
	Vector()
	local volume = spawner.volume

	if __wf_atom_7e8ad928(volume) then
		print("ERROR...Tried to spawn a resource in an nil volume. Possibly streamed out.")
		return nil
	end

	local v2

	if volume:__wf_atom_bbcb227c() then
		v2 = fn3(volume)
	elseif volume:__wf_atom_642b7ae0() then
		v2 = fn3(volume)
	elseif volume:__wf_atom_fdefab34() then
		v2 = fn2(volume)
	else
		print("ERROR...Tried to spawn a resource in an unsupported volume.")
		return nil
	end

	v2.y = volume:GetPosition().y
	local __wf_atom_0e0a6fee = v:__wf_atom_0e0a6fee(v2, spawner.navHorizontalSearchDist, spawner.navVerticalSearchDist)

	if not (Distance(__wf_atom_0e0a6fee, v2) > 0.1 and volume:Contains(__wf_atom_0e0a6fee)) then
		return nil
	end

	local v3 = __wf_atom_0e0a6fee + Vector(0, 2, 0)
	local validSpawnPos, v4 = module.FindValidSpawnPos(
		v3,
		data.resourceRadius,
		terrainOnly,
		nil,
		spawner.spawnedPoints,
		nil,
		data.spawnAngleLimit,
		data.extraSpacing,
		data.extraAllowedSurfaces,
		data.edgeHeightDifferenceLimit
	)

	if __wf_atom_7e8ad928(validSpawnPos) then
		return nil
	end

	local v5 = nil

	if __wf_atom_7e8ad928(resourceDropTable) then
		if not __wf_atom_7e8ad928(p) then
			v5 = gRegion:CreateEntity(p, validSpawnPos, v4)
		end
	else
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_6ba3aebe = resourceDropTable:__wf_atom_6ba3aebe(
				__wf_atom_c4f78a8f,
				EMPTY_SYMBOL,
				0,
				__wf_atom_28d5d4aa,
				__wf_atom_28d5d4aa,
				false,
				validSpawnPos,
				v4
			)

			for i = #__wf_atom_6ba3aebe, 1, -1 do
				if __wf_atom_7e8ad928(__wf_atom_6ba3aebe[i]) then
					continue
				end

				if i > 1 then
					gRegion:__wf_atom_dd1e4d10(__wf_atom_6ba3aebe[i])
				else
					v5 = __wf_atom_6ba3aebe[i]
				end
			end
		end
	end

	if not __wf_atom_7e8ad928(v5) then
		table.insert(spawner.spawnedPoints, validSpawnPos)
		table.insert(spawner.spawnedResources, v5)
		return v5
	end

	return nil
end

local function fn6(data) -- 2 equivalent calls inferred from this helper
	print("[Resource Spawning] " .. data.category .. " Volumes: Spawned " .. data.spawnCount .. " of " .. data.maxSpawns .. " resources.")
end

function Start()
	if not enabled then
		return
	end

	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v2 = {}
	table.insert(
		v2,
		(fn4(Symbol("ForestSpawnVolume"), "Forest", maxForestSpawns, forestPickupTypes, forestResources, true))
	)
	table.insert(v2, (fn4(Symbol("RiverSpawnVolume"), "River", maxRiverSpawns, riverPickupTypes, riverResources, true)))
	table.insert(v2, (fn4(Symbol("CaveSpawnVolume"), "Cave", maxCaveSpawns, cavePickupTypes, caveResources, false)))
	local v3 = {
		resourceRadius = 0.3,
		spawnAngleLimit = 30,
		extraSpacing = minDistBetweenSpawns,
		extraAllowedSurfaces = nil,
		edgeHeightDifferenceLimit = nil
	}
	local total = 0
	local count = 0

	for _, v4 in v2 do
		total += v4.maxSpawns
	end

	local v4 = math.min(total, 1000)
	local v5 = math.min(v4 * 5, 1900)
	local count2 = 0
	local v6 = 1
	local count3 = 0

	while count < v4 and count2 < v5 and #v2 > 0 do
		local v7 = math.random(#v2)
		local v8 = v2[v7]
		local spawner = v8.spawners[math.random(#v8.spawners)]
		local resourceDropTable = v8.resourceDropTable
		local v9

		if spawnOneOfEach then
			v9 = v8.resourceTypes[v6]
		else
			v9 = v8.resourceTypes[math.random(#v8.resourceTypes)]
		end

		if not __wf_atom_7e8ad928((fn5(v9, resourceDropTable, spawner, v3, v8.terrainOnly))) then
			v6 += 1
			count += 1
			v8.spawnCount += 1

			if v8.spawnCount >= v8.maxSpawns then
				fn6(v8) -- inferred equivalent call
				table.remove(v2, v7)
			end
		end

		count2 += 1
		count3 += 1

		if not (count3 >= 10) then
			continue
		end

		Sleep(0)
		count3 = 0
	end

	for _, v7 in v2 do
		fn6(v7) -- inferred equivalent call
	end

	print("[Resource Spawning] Total Spawned Resources: " .. count .. " of " .. v4 .. ". Attempts: " .. count2)
end

function RunScriptTrigger(object)
	fn()
	object:FirePort("Execute")
end