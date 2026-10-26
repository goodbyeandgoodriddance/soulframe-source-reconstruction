Symbol("Dead-End")
Symbol("Spawn")
Vector(0, 3, 0)
local debugEnvType2 = nil
local v = {}
local v2 = {}
local v3 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.DungeonLocationInfo")

local function fn(layerIndex, __wf_atom_2226b35c, __wf_atom_2226b35c2, __wf_atom_2226b35c3)
	local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_2226b35c)
	local filterObjectsInLayerIndex2 = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_2226b35c2)
	local filterObjectsInLayerIndex3 = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_2226b35c3)

	for _, v4 in ipairs(filterObjectsInLayerIndex) do
		v4:FirePort("Show")
	end

	for _, v4 in ipairs(filterObjectsInLayerIndex2) do
		v4:FirePort("TurnOn")
	end

	for _, v4 in ipairs(filterObjectsInLayerIndex3) do
		v4:FirePort("Enable")
	end
end

function ToggleEnvVariationsAndPuzzles()
	module.WaitForLevel()
	v3 = module.WaitForAiDir()
	Sleep(5)
	local currentLocationQuest, v4 = module2.GetCurrentLocationQuest()

	if not (__wf_atom_7e8ad928(currentLocationQuest) or __wf_atom_7e8ad928(v4)) then
		print("Environment script early out due to active quest in this dungeon")
		return
	end

	if __wf_atom_5784a397(0, 100) / 100 > generalChance then
		print("Environment script early out due to RNG decided against spawning")
		return
	end

	while __wf_atom_7e8ad928(debugEnvType2) do
		local v5 = __wf_atom_5784a397(1, #envNames)

		if envUsedInProc[v5] then
			debugEnvType2 = v5
		end
	end

	print("Proc environment puzzle selected " .. envNames[debugEnvType2] .. " environment variation to spawn.")

	if debugEnvType2 > 0 then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(sEnvVariationTags[debugEnvType2])
		local variations = {}

		for _, v5 in ipairs(__wf_atom_2226b35c) do
			table.insert(variations, (module.GetLayerIndex(v5)))
		end

		v.variations = variations
		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(sEnvPuzzleTags[debugEnvType2])
		local puzzles = {}

		for _, v5 in ipairs(__wf_atom_2226b35c2) do
			table.insert(puzzles, (module.GetLayerIndex(v5)))
		end

		v.puzzles = puzzles
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(sEnvPuzzleTags[debugEnvType2])
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(sEnvVariationTags[debugEnvType2])
	local all = gRegion:FindAll(__wf_atom_f806fd7a)
	v2 = module.SortPortalsInMultipleZonesByAccessType(v.puzzles)

	if sEnvPuzzleEntranceRestrictionTags[debugEnvType2] ~= EMPTY_SYMBOL then
		local v5 = false

		while not v5 and #v2 ~= 0 do
			for k, _ in pairs(v2) do
				local position = v2[k].entrance.door:GetPosition()
				local position2 = v2[k].exit.door:GetPosition()
				local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
					sEnvPuzzleEntranceRestrictionTags[debugEnvType2],
					position,
					0,
					entranceSearchRange
				)
				local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(
					sEnvPuzzleEntranceRestrictionTags[debugEnvType2],
					position2,
					0,
					entranceSearchRange
				)
				local __wf_atom_439c0d29_3 = gRegion:__wf_atom_439c0d29(
					sEnvPuzzleEntranceSpecificTags[debugEnvType2],
					position2,
					0,
					entranceSearchRange
				)
				local v6 = nil
				local v7 = nil
				local v8 = nil

				for _, v9 in ipairs(__wf_atom_439c0d29) do
					if module.GetLayerIndex(v9) == v2[k].id then
						v6 = v9
					end
				end

				for _, v9 in ipairs(__wf_atom_439c0d29_2) do
					if module.GetLayerIndex(v9) == v2[k].id then
						v7 = v9
					end
				end

				for _, v9 in ipairs(__wf_atom_439c0d29_3) do
					if module.GetLayerIndex(v9) == v2[k].id then
						v8 = v9
					end
				end

				if __wf_atom_7e8ad928(v6) then
					if __wf_atom_7e8ad928(v7) and __wf_atom_7e8ad928(v8) then
						table.remove(v2, k)
						break
					elseif k == #v2 then
						v5 = true
					end
				else
					table.remove(v2, k)
					break
				end
			end
		end
	end

	for k, v5 in pairs(v2) do
		local position = v5.entrance.door:GetPosition()
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			sEnvPuzzleEntranceSpecificTags[debugEnvType2],
			position,
			0,
			entranceSearchRange
		)

		if __wf_atom_7e8ad928(__wf_atom_439c0d29) or __wf_atom_7e8ad928(v2[k].id) then
			continue
		end

		local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(v2[k].id, __wf_atom_439c0d29)
		local v6

		if #filterObjectsInLayerIndex > 0 then
			v6 = filterObjectsInLayerIndex[1]
		end

		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local filterObjectsInLayerIndex2 = module.FilterObjectsInLayerIndex(
			v2[k].id,
			module.CopyTable(__wf_atom_2226b35c)
		)
		local v7

		if #filterObjectsInLayerIndex2 > 0 then
			v7 = filterObjectsInLayerIndex2[1]
		end

		if __wf_atom_7e8ad928(v7) or v7 == v6 then
			continue
		end

		__wf_atom_2226b35c[module.TableGetIndex(__wf_atom_2226b35c, v7)] = v6
	end

	local v5 = __wf_atom_5784a397(math.max(puzzleTilesMin, 0), (math.min(puzzleTilesMax, #v2)))
	v2 = module.RandomizeTableOrder(v2)
	local randomizeTableOrder = module.RandomizeTableOrder(__wf_atom_2226b35c)

	if #v2 > 0 then
		local count = 0
		local count2 = 0

		while count < v5 do
			local v6 = __wf_atom_5784a397(1, #v2)
			local v7 = v2[v6]

			for _, v8 in ipairs(randomizeTableOrder) do
				if v7.id ~= module.GetLayerIndex(v8) then
					continue
				end

				v8:FirePort("TriggerPort")
				count += 1
				local door = v2[v6].entrance.door
				local v9 = door:GetPosition() + door:__wf_atom_a06d543c() + Vector(0, 1, 0)

				if not __wf_atom_7e8ad928(playtestWaypointType) then
					gRegion:CreateEntity(playtestWaypointType, v9, __wf_atom_80368bb1)
				end

				if not (__wf_atom_7e8ad928(statsPuzzleStartedTriggerType) or __wf_atom_7e8ad928(statsPuzzleSolvedTriggerType)) then
					local v10 = Vector(0, statsTriggerDimensions.y / 2, 0)
					local v11 = v2[v6].entrance.door:GetPosition() + v10
					local v12 = __wf_atom_fa8d0177(v11, v11 + v2[v6].entrance.door:__wf_atom_a06d543c())
					local v13 = v2[v6].exit.door:GetPosition() + v10
					local v14 = __wf_atom_fa8d0177(v13, v13 + v2[v6].exit.door:__wf_atom_a06d543c())
					local entity = gRegion:CreateEntity(statsPuzzleStartedTriggerType, v11, v12, v8)
					local entity2 = gRegion:CreateEntity(statsPuzzleSolvedTriggerType, v13, v14, v8)

					if not __wf_atom_7e8ad928(entity) then
						entity:__wf_atom_f947c7cc(statsTriggerDimensions)
					end

					if not __wf_atom_7e8ad928(entity2) then
						entity2:__wf_atom_f947c7cc(statsTriggerDimensions)
					end
				end

				if not __wf_atom_7e8ad928(variationScriptTriggerTypes[debugEnvType2]) then
					local entity = gRegion:CreateEntity(
						variationScriptTriggerTypes[debugEnvType2],
						v8:GetPosition(),
						__wf_atom_80368bb1
					)
					Sleep(0)

					if not __wf_atom_7e8ad928(entity) then
						entity:FirePort("Execute")
					end
				end

				for _, v10 in ipairs(__wf_atom_2226b35c2) do
					if v7.id ~= module.GetLayerIndex(v10) then
						continue
					end

					v10:FirePort("Execute")
					count2 += 1
					table.remove(v.variations, module.TableGetIndex(v.variations, v7.id))
				end

				for _, v10 in pairs(all) do
					if __wf_atom_7e8ad928(v10) or v7.id ~= module.GetLayerIndex(v10) then
						continue
					end

					v10:FirePort("Disable")
				end

				break
			end
		end
	end
end

function ForceNearestPuzzleAndVariation(object)
	if not object:IsEnabled() then
		return
	end

	local layerIndex = module.GetLayerIndex(object)

	if not isOkToCheckIn and layerIndex ~= 1 then
		print("Alert! Debug puzzle trigger has been accidentally submitted. It can cause troubles if not removed from the level.")
		return
	end

	debugEnvType2 = debugEnvType
	local position = object:GetPosition()

	if not __wf_atom_7e8ad928(variationScriptTriggerTypes[debugEnvType2]) then
		local entity = gRegion:CreateEntity(variationScriptTriggerTypes[debugEnvType2], position, __wf_atom_80368bb1)
		Sleep(0)

		if not __wf_atom_7e8ad928(entity) then
			entity:FirePort("Execute")
		end
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(sEnvVariationTags[debugEnvType2], position, 0, 100)
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(sEnvPuzzleTags[debugEnvType2], position, 0, 100)
	local __wf_atom_f738b4af3 = gRegion:__wf_atom_f738b4af(
		sEnvPuzzleEntranceSpecificTags[debugEnvType2],
		position,
		0,
		5
	)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af3) then
		if not __wf_atom_7e8ad928(__wf_atom_f738b4af2) and module.GetLayerIndex(__wf_atom_f738b4af2) == layerIndex then
			__wf_atom_f738b4af2:FirePort("TriggerPort")
		end
	elseif module.GetLayerIndex(__wf_atom_f738b4af3) == layerIndex then
		__wf_atom_f738b4af3:FirePort("TriggerPort")
	end

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) and module.GetLayerIndex(__wf_atom_f738b4af) == layerIndex then
		__wf_atom_f738b4af:FirePort("Execute")
	end
end

function ShowVariation(p)
	fn(
		module.GetLayerIndex(p),
		gRegion:__wf_atom_2226b35c(sEnvPuzzleToggleDecoTag),
		gRegion:__wf_atom_2226b35c(sEnvPuzzleToggleLightTag),
		gRegion:__wf_atom_2226b35c(sEnvPuzzleToggleEntityTag)
	)
end