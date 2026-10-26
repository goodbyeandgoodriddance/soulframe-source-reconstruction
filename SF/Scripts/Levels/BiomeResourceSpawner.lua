local module = require("Lotus.Scripts.Libs.SpawnObjectsOnTerrain")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.FishingLib")
local v = nil
local v2 = nil
local v3 = false
local v4 = nil
local total = 0
local v5 = Vector(0, 0, 1)
local v6 = WeakResource("/SF/Types/PickUps/Resources/Textiles/BrineflossManualPickup")
local v7 = WeakResource("/SF/Types/PickUps/LootContainers/Holiday/LootScarecrow")
local v8 = WeakResource("/SF/Types/PickUps/Resources/Organics/RiverPearlManualPickup")
local v9 = WeakResource("/SF/Objects/Events/WinterSolstice/BirdFeederBaseDeco")
local v10 = WeakResource("/SF/Types/Gameplay/Fishing/FishingHotspot")

local function fn(object)
	v4 = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(v4.SpawnedResourceGroups) then
		v4.SpawnedResourceGroups = {}
	end

	if __wf_atom_7e8ad928(v4.fishingHotspots) then
		v4.fishingHotspots = {}
	end

	if __wf_atom_7e8ad928(v4.CleaningSpawnedResources) then
		v4.CleaningSpawnedResources = false
	end

	v3 = false

	if __wf_atom_7e8ad928(v4.TotalResourceSpawns) then
		v4.TotalResourceSpawns = 0
	end

	if __wf_atom_7e8ad928(v4.TotalRiverPearls) then
		v4.TotalRiverPearls = 0
	end

	if __wf_atom_7e8ad928(v4.CurrentRiverPearls) then
		v4.CurrentRiverPearls = 0
	end

	if __wf_atom_7e8ad928(v4.TotalBrineFloss) then
		v4.TotalBrineFloss = 0
	end

	if __wf_atom_7e8ad928(v4.CurrentBrineFloss) then
		v4.CurrentBrineFloss = 0
	end

	if __wf_atom_7e8ad928(v4.TotalRiverSpawnAttempts) then
		v4.TotalRiverSpawnAttempts = 0
	end

	if __wf_atom_7e8ad928(v4.FishHotSpotsSpawned) then
		v4.FishHotSpotsSpawned = 0
	end

	if __wf_atom_7e8ad928(v4.CurrentFishHotSpots) then
		v4.CurrentFishHotSpots = 0
	end

	if __wf_atom_7e8ad928(v4.LoggingEnabled) then
		v4.LoggingEnabled = false
	end

	if showLogging then
		v4.LoggingEnabled = true
	end
end

local function fn2(p, p2)
	local v11 = p2 or __wf_atom_7e8ad928(v2) and 0 or v2:GetColor(p, false).green

	for _, v12 in pairs(waterBiomeIDs) do
		if not __wf_atom_7e8ad928(v12) and v12 == v11 then
			return true
		end
	end

	return false
end

local function fn3(p, p2) -- 2 equivalent calls inferred from this helper
	local v11 = Vector(p.x, 0, p.z)
	local v12 = Vector(p2.x, 0, p2.z)
	return Distance(v11, v12)
end

local function fn4(p)
	local v11 = fn2(p)
	local v12 = __wf_atom_4240d7fd()
	v12:Set(nil)
	local v13

	if v11 then
		v13 = v:__wf_atom_4d26da3a(p, 50)

		if v4.LoggingEnabled and v3 then
			v4.TotalRiverSpawnAttempts += 1
		end
	else
		v13 = v:__wf_atom_0e0a6fee(p, 5, 50)

		if Distance(v13, p) < 0.01 then
			return nil, nil
		end
	end

	if v11 then
		local v14 = Vector()
		local v15 = false

		if gRegion:Raycast(v13 + Vector(0, 1, 0), v13 - Vector(0, 5, 0), nil, v12, v14, true) then
			local v16 = Vector()
			local v17 = __wf_atom_4240d7fd()
			v17:Set(nil)
			v15 = gRegion:Raycast(v14, v14 - Vector(0, maxWaterDepth, 0), v12:Get(), v17, v16, true)
				and v17:Get() ~= v12:Get()
				and true
				or false
		end

		if not v15 then
			return nil, nil
		end
	end

	if fn3(v13, v:__wf_atom_c280ad8f(v13, 5)) < 3 then -- inferred equivalent call
		return nil, nil
	end

	local v14 = Vector()

	if not __wf_atom_7e8ad928(gRegion:Raycast(v13, v13 + Vector(0, 50, 0), nil, nil, v14, true)) then
		return nil
	end

	if showLogging and v3 then
		local v15 = __wf_atom_7e8ad928(v2) and 0 or v2:GetColor(p, false).green
		gRegion:__wf_atom_5b35a0c8(
			Vector(v13.x, v13.y + 4, v13.z),
			Color(245, 66, 66),
			"Biome is: " .. tostring(v15),
			2,
			10,
			false
		)
		gRegion:__wf_atom_8d991675(v13, 3, Color(225, 225, 225), 10)
	end

	return v13, v12:Get()
end

local function fn5(object)
	local v11 = math.random(-180, 180)
	local v12 = __wf_atom_9341614d(v5, Rotation(v11, 0, 0))
	local minSpawnDist2 = minSpawnDist
	local maxSpawnDist2 = maxSpawnDist

	if object:__wf_atom_8efce136() and math.abs(object:__wf_atom_4e50d390().heading - v11) < 130 then
		minSpawnDist2 = math.max(minSpawnDist, 40)
		maxSpawnDist2 = minSpawnDist2 + (maxSpawnDist - minSpawnDist)
	end

	return object:GetPosition() + v12 * math.random(minSpawnDist2, maxSpawnDist2)
end

local function fn6(fishingHotspots, p) -- 1 equivalent call inferred from this helper
	for i, v11 in ipairs(fishingHotspots) do
		if v11.mHotspot == p then
			return i
		end
	end

	return nil
end

local function fn7(resources, points, k)
	local count = 0

	for i = #resources, 1, -1 do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v11 = resources[i]
		local flag = true

		if __wf_atom_7e8ad928(v11) then
			if k == v4.FishingHotspotGroupIndex then
				table.remove(resources, i)
				table.remove(points, i)
				count += 1
				Sleep(0.1)
			end
		else
			local isA = v11:IsA(v10)

			for _, v12 in __wf_atom_ef7900cf do
				if __wf_atom_7e8ad928(v12) then
					continue
				end

				if v12:__wf_atom_799d95f5() and fn3(v12:__wf_atom_4c2e0189(), points[i]) <= removalDistance then -- inferred equivalent call
					flag = false
					break
				end

				if not (v12:__wf_atom_a5304c35(points[i]) <= removalDistance) then
					continue
				end

				flag = false
				break
			end

			if flag and v11:__wf_atom_49ad2492(10) and not isA then
				flag = false
			end

			if flag then
				if not __wf_atom_7e8ad928(v11) then
					if v4.LoggingEnabled and v3 then
						if v11:IsA(v8) then
							v4.CurrentRiverPearls -= 1
						end

						if v11:IsA(v6) then
							v4.CurrentBrineFloss -= 1
						end

						if isA then
							v4.CurrentFishHotSpots -= 1
						end
					end

					if isA then
						local i2 = fn6(v4.fishingHotspots, v11) -- inferred equivalent call
						table.remove(v4.fishingHotspots, i2)
					end

					gRegion:__wf_atom_dd1e4d10(v11)
				end

				table.remove(resources, i)
				table.remove(points, i)
				count += 1
				Sleep(0.1)
			end

			Sleep(0)
		end
	end

	if count > 0 then
		total += count

		if v4.LoggingEnabled and v3 then
			v4.TotalResourceSpawns -= count
		end
	end
end

function RunCleanup(p)
	if not gRegion:IsMaster() then
		return
	end

	fn(p)
	local v11 = Time()

	while true do
		if __wf_atom_7e8ad928(v4.SpawnedResourceGroups) then
			Sleep(0)
		else
			if Time() - v11 > cleanupTimeInterval then
				v4.CleaningSpawnedResources = true
				total = 0

				for k, spawnedResourceGroup in v4.SpawnedResourceGroups do
					if not __wf_atom_7e8ad928(spawnedResourceGroup) then
						fn7(spawnedResourceGroup.resources, spawnedResourceGroup.points, k)
					end
				end

				v11 = Time()
				v4.CleaningSpawnedResources = false

				if showLogging and v3 then
					print("RESOURCE SPAWNING: Cleanup - Removed spawn count: " .. total .. ". Remaining spawn count: " .. v4.TotalResourceSpawns .. ".")
					print("--------------TOTAL RIVER SPAWN ATTEMPTS: " .. v4.TotalRiverSpawnAttempts)
					print("--------------TOTAL RIVER PEARLS: " .. v4.TotalRiverPearls .. " CURRENT RIVER PEARLS: " .. v4.CurrentRiverPearls)
					print("--------------TOTAL BRINEFLOSS: " .. v4.TotalBrineFloss .. " CURRENT BRINEFLOSS: " .. v4.CurrentBrineFloss)
					print("--------------TOTAL Fishing HotSpots: " .. v4.FishHotSpotsSpawned .. " CURRENT Fishing Hot Spots: " .. v4.CurrentFishHotSpots)
				end
			end

			Sleep(0.5)
		end
	end
end

local function fn8(p) -- 1 equivalent call inferred from this helper
	if p > 0 then
		local v11

		if p < #minDistBetweenSpawnsOverrides then
			v11 = minDistBetweenSpawnsOverrides[p + 1] >= 0
		else
			v11 = false
		end

		if v11 then
			return minDistBetweenSpawnsOverrides[p + 1]
		end
	end

	return minDistBetweenSpawns
end

local function fn9(p) -- 1 equivalent call inferred from this helper
	if p > 0 then
		local v11

		if p < #maxGroundAngleOverrides then
			v11 = maxGroundAngleOverrides[p + 1] >= 0
		else
			v11 = false
		end

		if v11 then
			return maxGroundAngleOverrides[p + 1]
		end
	end

	return maxGroundAngle
end

function RunSpawner(p)
	if not (enabled and gRegion:IsMaster()) then
		return
	end

	v3 = false

	if not module2.IsInOverworld() then
		return
	end

	fn(p)
	local v11 = { resources = {}, points = {} }
	table.insert(v4.SpawnedResourceGroups, v11)
	local v12 = #v4.SpawnedResourceGroups
	Sleep(delayStartTime)
	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v2 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	local resources = v11.resources
	local points = v11.points
	_T.taleResourceDropTables = biomeResources
	local count = 0

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v)) do
		if module2.IsOverworldResourceSpawningPaused() then
			Sleep(spawnTimeInterval)
		elseif __wf_atom_7e8ad928(v4.CleaningSpawnedResources) or v4.CleaningSpawnedResources then
			Sleep(spawnTimeInterval)
		elseif #resources >= maxSpawns or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) then
			Sleep(spawnTimeInterval)
		else
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local v13

			if #__wf_atom_ef7900cf > 0 then
				v13 = __wf_atom_ef7900cf[math.random(#__wf_atom_ef7900cf)]
			end

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(v13) or v13:__wf_atom_799d95f5() then
				Sleep(spawnTimeInterval)
			else
				local v14, v15 = fn4(fn5(v13))
				local v16, v17

				if not __wf_atom_7e8ad928(v14) then
					local v18 = __wf_atom_7e8ad928(v2) and 0 or v2:GetColor(v14, false).green
					v16, v17 = module.FindValidSpawnPos(
						v14 + Vector(0, 2, 0),
						0.5,
						true,
						v15,
						v4.SpawnedResourceGroups,
						v12,
						fn9(v18), -- inferred equivalent call
						fn8(v18), -- inferred equivalent call
						nil,
						nil
					)
				end

				local flag = true

				if __wf_atom_7e8ad928(v16) then
					flag = false
				else
					for _, v18 in __wf_atom_ef7900cf do
						if __wf_atom_7e8ad928(v18) or not (v18:__wf_atom_a5304c35(v16) <= minSpawnDist) then
							continue
						end

						flag = false
						break
					end
				end

				if flag then
					local green = v2:GetColor(v16, false).green
					local v18 = nil

					if green > 0 then
						local v19

						if green < #altBiomeResources then
							v19 = not __wf_atom_7e8ad928(altBiomeResources[green + 1])
						else
							v19 = false
						end

						if v19 and math.random() < altChance then
							v18 = altBiomeResources[green + 1]
						elseif green <= #biomeResources + 1 then
							v18 = biomeResources[green + 1]
						end
					end

					if not __wf_atom_7e8ad928(v18) then
						local __wf_atom_6ba3aebe = v18:__wf_atom_6ba3aebe(
							__wf_atom_c4f78a8f,
							EMPTY_SYMBOL,
							0,
							__wf_atom_28d5d4aa,
							__wf_atom_28d5d4aa,
							false,
							v16,
							v17
						)
						local v19 = nil

						for i = #__wf_atom_6ba3aebe, 1, -1 do
							if __wf_atom_7e8ad928(__wf_atom_6ba3aebe[i]) then
								continue
							end

							if i > 1 then
								gRegion:__wf_atom_dd1e4d10(__wf_atom_6ba3aebe[i])
							else
								v19 = __wf_atom_6ba3aebe[i]
							end
						end

						if not __wf_atom_7e8ad928(v19) then
							if v19:IsA(v6) or v19:IsA(v7) or v19:IsA(v9) then
								v19:Teleport(v16, Rotation(v17.heading, 0, 0))
							end

							table.insert(points, v16)
							table.insert(resources, v19)

							if v4.LoggingEnabled and v3 then
								v4.TotalResourceSpawns += 1

								if v19:IsA(v8) then
									v4.CurrentRiverPearls += 1
									v4.TotalRiverPearls += 1
								end

								if v19:IsA(v6) then
									v4.CurrentBrineFloss += 1
									v4.TotalBrineFloss += 1
								end
							end

							if showLogging and v3 then
								print("RESOURCE SPAWNING: " .. v19:GetName() .. " Spawned resource. Biome ID: " .. green .. ". Total spawn count: " .. v4.TotalResourceSpawns .. ".")

								if v19:IsA(v8) then
									print("--------------TOTAL RIVER PEARLS: " .. v4.TotalRiverPearls .. " CURRENT RIVER PEARLS: " .. v4.CurrentRiverPearls)
								end

								if v19:IsA(v6) then
									print("--------------TOTAL BRINEFLOSS: " .. v4.TotalBrineFloss .. " CURRENT BRINEFLOSS: " .. v4.CurrentBrineFloss)
								end
							end

							Sleep(spawnTimeInterval)
							count = 0
							continue
						end
					end
				end

				count += 1

				if maxSpawnAttempts <= count then
					Sleep(spawnTimeInterval)
					count = 0
				end
			end
		end
	end
end

function FishHotSpotSpawner(p)
	if not (enabled and gRegion:IsMaster()) then
		return
	end

	v3 = false

	if not module2.IsInOverworld() then
		return
	end

	fn(p)
	local v11 = { resources = {}, points = {} }
	table.insert(v4.SpawnedResourceGroups, v11)
	local count = #v4.SpawnedResourceGroups
	v4.FishingHotspotGroupIndex = count
	Sleep(delayStartTime)
	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v2 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	local resources = v11.resources
	local points = v11.points
	local count2 = 0

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v)) do
		if module2.IsOverworldResourceSpawningPaused() then
			Sleep(spawnTimeInterval)
		elseif __wf_atom_7e8ad928(v4.CleaningSpawnedResources) or v4.CleaningSpawnedResources then
			Sleep(spawnTimeInterval)
		elseif #resources >= maxSpawns or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) then
			Sleep(spawnTimeInterval)
		else
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local v12

			if #__wf_atom_ef7900cf > 0 then
				v12 = __wf_atom_ef7900cf[math.random(#__wf_atom_ef7900cf)]
			end

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(v12) or v12:__wf_atom_799d95f5() then
				Sleep(spawnTimeInterval)
			else
				local v13, _ = fn4(fn5(v12))
				local v14 = nil

				if __wf_atom_7e8ad928(v13) then
					count2 += 1

					if maxSpawnAttempts <= count2 then
						Sleep(spawnTimeInterval)
						count2 = 0
					end
				else
					local v15 = __wf_atom_7e8ad928(v2) and 0 or v2:GetColor(v13, false).green

					if fn2(v13, v15) then
						local nearestWaterVolume = module3.FindNearestWaterVolume(gRegion:__wf_atom_3bc831e3(), v13)

						if __wf_atom_7e8ad928(nearestWaterVolume) then
							Sleep(spawnTimeInterval)
						else
							if
								v15 == 1
								and not __wf_atom_7e8ad928(swampFishingHotSpots)
								and #swampFishingHotSpots > 0
							then
								v14 = swampFishingHotSpots[math.random(1, #swampFishingHotSpots)]
							elseif
								v15 == 2
								and not __wf_atom_7e8ad928(lakeFishingHotSpots)
								and #lakeFishingHotSpots > 0
							then
								v14 = lakeFishingHotSpots[math.random(1, #lakeFishingHotSpots)]
							elseif
								v15 == 7
								and not __wf_atom_7e8ad928(shorelineFishingHotSpots)
								and #shorelineFishingHotSpots > 0
							then
								v14 = shorelineFishingHotSpots[math.random(1, #shorelineFishingHotSpots)]
							elseif
								v15 == 11
								and not __wf_atom_7e8ad928(oceanFishingHotSpots)
								and #oceanFishingHotSpots > 0
							then
								v14 = oceanFishingHotSpots[math.random(1, #oceanFishingHotSpots)]
							end

							if __wf_atom_7e8ad928(v14) then
								Sleep(spawnTimeInterval)
							else
								local y = nearestWaterVolume:__wf_atom_80cf57aa().y
								local v16 = nearestWaterVolume:__wf_atom_a2a18137().y + y * 0.5 - 3

								if v16 < v13.y then
									v13.y = math.max(v13.y, v16)
								end

								local validFishingHotspotSpawnPos, _ = module.FindValidFishingHotspotSpawnPos(
									v13 + Vector(0, 2, 0),
									v14:__wf_atom_4e28532a(),
									v4.SpawnedResourceGroups,
									count
								)
								local flag = true

								if __wf_atom_7e8ad928(validFishingHotspotSpawnPos) then
									flag = false
								else
									for _, v17 in __wf_atom_ef7900cf do
										if
											__wf_atom_7e8ad928(v17)
											or not (v17:__wf_atom_a5304c35(validFishingHotspotSpawnPos) <= minSpawnDist)
										then
											continue
										end

										flag = false
										break
									end
								end

								if flag then
									local entity = gRegion:CreateEntity(
										v14,
										validFishingHotspotSpawnPos,
										__wf_atom_80368bb1
									)

									if not __wf_atom_7e8ad928(entity) then
										if showLogging and v3 then
											gRegion:__wf_atom_8d991675(
												validFishingHotspotSpawnPos,
												3,
												Color(49, 30, 99),
												15
											)
										end

										table.insert(points, validFishingHotspotSpawnPos)
										table.insert(resources, entity)

										if v4.LoggingEnabled and v3 then
											v4.FishHotSpotsSpawned += 1
											v4.CurrentFishHotSpots += 1
										end

										if showLogging and v3 then
											print("--------------Fish Hot Spots: " .. v4.FishHotSpotsSpawned .. " CURRENT Fishing Spots: " .. v4.CurrentFishHotSpots)
										end
									end
								end

								Sleep(spawnTimeInterval)
								count2 = 0
							end
						end
					else
						count2 += 1

						if maxSpawnAttempts <= count2 then
							Sleep(spawnTimeInterval)
							count2 = 0
						end
					end
				end
			end
		end
	end
end

function RunScriptTrigger(object)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	object:FirePort("Execute")
end