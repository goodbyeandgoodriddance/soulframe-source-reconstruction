local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.TableLib")
local module5 = require("Lotus.Scripts.Libs.Query")
local module6 = require("SF.Scripts.Libs.QuestLib")
local v = Symbol("RandomTeam")
local v2 = Symbol("Grineer")
local v3 = Symbol("Guard")
local v4 = Symbol("PauseTrappedAnimal")
local v5 = Range(2.5, 3.5)
local v6 = WeakResource("/SF/Types/Quests/OmenBeastQuests/TheOmenOrengall")
local v7 = Type("/SF/Types/Gameplay/CollectableNotes/Midrath/NoteOrengalQuestStartPickup")
local v8 = Type("/SF/Objects/GameplayProps/Lantern/PaperLanternRedDeco")
local v9 = nil
local position = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = false
local v14 = false
local v15 = nil
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = nil
local v20 = nil
local v21 = nil
local __wf_atom_402b3832s = {}
local v22 = { __wf_atom_4ebf67cb, __wf_atom_43e0c427, __wf_atom_3feeb44a, __wf_atom_7b01f9ce }

local function fn(groundAlignedSpawnPosRot, p)
	local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(groundAlignedSpawnPosRot, p, __wf_atom_3a0953be)

	for i = #__wf_atom_a56d7910, 1, -1 do
		if __wf_atom_7e8ad928(__wf_atom_a56d7910[i]) or __wf_atom_7e8ad928(__wf_atom_a56d7910[i]:HasTag()) then
			continue
		end

		table.remove(__wf_atom_a56d7910, i)
	end

	local __wf_atom_a56d7910_2 = gRegion:__wf_atom_a56d7910(groundAlignedSpawnPosRot, p, __wf_atom_46b5a019)
	return #__wf_atom_a56d7910 > 0 or #__wf_atom_a56d7910_2 > 0
end

local function fn2(p, p2, _, p3, _)
	local v23 = p3 or position
	local __wf_atom_28ce676a = v9:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(v23, p, p2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("DynamicCampsiteEncounter.lua"), Color("0xFFCC00"))
	return __wf_atom_28ce676a
end

local function fn3()
	local v23 = fn2(v5, 1.5)
	v16 = module5.GetPositions(maxEnemiesByFire, v23)
	local v24 = fn2(v19, 3, 10)
	v17 = module5.GetPositions(10, v24)

	if #poiTypes > 0 or useOuterSpawnRing then
		local v25 = fn2(v20, 4)
		v18 = module5.GetPositions(15, v25)
	end
end

local function fn4()
	local v23 = Vector(0, 2, 0)
	local v24 = Vector()

	for i = 1, 3 do
		local v25 = i * 120 + __wf_atom_5784a397(-42, 42)
		local v26 = v5.minValue + math.random() * (v5.maxValue - v5.minValue)
		local v27 = position + __wf_atom_9341614d(Vector(v26, 0, 0), Rotation(v25, 0, 0))
		local __wf_atom_0e0a6fee = v9:__wf_atom_0e0a6fee(v27, 2, 10)

		if not __wf_atom_7e8ad928(gRegion:__wf_atom_fbb89790(
			position + v23,
			__wf_atom_0e0a6fee + v23,
			1,
			campObjects,
			v22,
			nil,
			v24
		)) then
			continue
		end

		local v28 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, position)
		local v29 = Rotation(v28.heading, 0, 0)
		local campChairDeco = campChairDecos[__wf_atom_5784a397(1, #campChairDecos)]
		local groundAlignedSpawnPosRot, v30 = module3.GetGroundAlignedSpawnPosRot(
			campChairDeco,
			__wf_atom_0e0a6fee,
			v29,
			false,
			30
		)

		if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
			continue
		end

		local entity = gRegion:CreateEntity(campChairDeco, groundAlignedSpawnPosRot, v30)
		v10:__wf_atom_d494454b(entity)
	end
end

local function fn5(object, object2)
	local v23 = WeakResource("/SF/Types/Game/Encounters/PoiSpawner")

	if not __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) then
		local __wf_atom_f582136d = object2:__wf_atom_f582136d(__wf_atom_46b5a019)
		local __wf_atom_f582136d2 = object2:__wf_atom_f582136d(v23)
		local mergeTables = module2.MergeTables(__wf_atom_f582136d, __wf_atom_f582136d2)

		for _, mergeTable in ipairs(mergeTables) do
			mergeTable:Disable()
		end
	end
end

local function fn6()
	local chestTypeCommon2 = nil
	local v23 = nil
	local v24 = math.random()

	if commonChestSpawnChance <= v24 and v24 < animalCageSpawnChance then
		chestTypeCommon2 = chestTypeCommon
	elseif animalCageSpawnChance <= v24 and v24 < rareChestSpawnChance then
		v23 = cageTypes[__wf_atom_5784a397(1, #cageTypes)]
	elseif rareChestSpawnChance <= v24 and v24 < 1 then
		chestTypeCommon2 = chestTypeRare
	end

	local v25 = Range(0, (math.max(10, v21 + 3)))

	if not __wf_atom_7e8ad928(chestTypeCommon2) then
		local v26 = nil
		local encounterLootSpawns = module.GetEncounterLootSpawns(position, v25, 1, true, false, false)

		if __wf_atom_7e8ad928(encounterLootSpawns) or not (#encounterLootSpawns > 0) then
			if #v17 > 0 then
				for i = 1, #v17 do
					local groundAlignedSpawnPosRot, v27 = module3.GetGroundAlignedSpawnPosRot(
						chestTypeCommon2,
						v17[i],
						__wf_atom_fa8d0177(v17[i], position),
						false,
						30
					)

					if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) or fn(groundAlignedSpawnPosRot, 1.5) then
						continue
					end

					v26 = module.SpawnLootContainer(chestTypeCommon2, groundAlignedSpawnPosRot, v27, true, v10)
					table.remove(v17, i)
					break
				end
			end
		else
			local encounterLootSpawn = encounterLootSpawns[__wf_atom_5784a397(1, #encounterLootSpawns)]
			v26 = module.SpawnLootContainer(
				chestTypeCommon2,
				encounterLootSpawn.pos,
				encounterLootSpawn.rot,
				false,
				v10
			)
			fn5(encounterLootSpawn.spawnPt, v26)
		end

		if not __wf_atom_7e8ad928(v26) then
			v10:__wf_atom_d494454b(v26)
		end
	end

	if not __wf_atom_7e8ad928(v23) then
		local cage = nil
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("AnimalCageSpawn"), position, 0, v25.maxValue)

		if __wf_atom_7e8ad928(__wf_atom_439c0d29) or not (#__wf_atom_439c0d29 > 0) then
			if #v17 > 0 then
				for i = 1, #v17 do
					local groundAlignedSpawnPosRot, v26 = module3.GetGroundAlignedSpawnPosRot(
						v23,
						v17[i],
						__wf_atom_fa8d0177(v17[i], position),
						false,
						30
					)

					if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) or fn(groundAlignedSpawnPosRot, 1.5) then
						continue
					end

					cage = gRegion:CreateEntity(v23, groundAlignedSpawnPosRot, v26)
					table.remove(v17, i)
					break
				end
			end
		else
			module4.InPlaceShuffle(__wf_atom_439c0d29)

			for _, v26 in ipairs(__wf_atom_439c0d29) do
				if __wf_atom_7e8ad928(v26) or not __wf_atom_7e8ad928(v26:__wf_atom_e919fb8e().cage) then
					continue
				end

				cage = gRegion:CreateEntity(v23, v26:GetPosition(), v26:__wf_atom_dc309f8a())
				fn5(v26, cage)
				local __wf_atom_e919fb8e = v26:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.cage = cage

				if module6.HasCompletedQuest(v6) or module6.QuestIsActive(v6) then
					break
				end

				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
					Symbol("OrengallNotePlacementDeco"),
					cage:GetPosition(),
					0,
					10
				)

				if
					not __wf_atom_7e8ad928(__wf_atom_f738b4af)
					and #gRegion:__wf_atom_439c0d29(Symbol("OrengallNoteSpawn"), cage:GetPosition(), 0, 30) == 0
				then
					local entity = gRegion:CreateEntity(
						v7,
						__wf_atom_f738b4af:GetPosition(),
						__wf_atom_f738b4af:__wf_atom_dc309f8a()
					)

					if not __wf_atom_7e8ad928(entity) then
						v10:__wf_atom_d494454b(entity)
						local entity2 = gRegion:CreateEntity(v8, cage:GetPosition(), cage:__wf_atom_dc309f8a())

						if not __wf_atom_7e8ad928(entity2) then
							v10:__wf_atom_d494454b(entity2)
						end
					end
				end

				break
			end
		end

		if not __wf_atom_7e8ad928(cage) then
			v10:__wf_atom_d494454b(cage)
		end
	end
end

local function fn7()
	for _ = 1, numAdditionalObjects do
		if not (#additionalObjectTypes > 0 and math.random() <= additionalObjectChance) then
			continue
		end

		local v23 = __wf_atom_5784a397(1, #additionalObjectTypes)
		local additionalObjectType = additionalObjectTypes[v23]
		local position2 = nil
		local v24 = nil

		if not __wf_atom_7e8ad928(additionalObjectSpawnTag[v23]) and additionalObjectSpawnTag[v23] ~= EMPTY_SYMBOL then
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(additionalObjectSpawnTag[v23], position, 0, 12)

			if not __wf_atom_7e8ad928(__wf_atom_439c0d29) and #__wf_atom_439c0d29 > 0 then
				local v25 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
				position2 = v25:GetPosition()
				v24 = v25:__wf_atom_dc309f8a()
			end
		end

		if __wf_atom_7e8ad928(position2) then
			if #v17 == 0 then
				continue
			end

			v23 = __wf_atom_5784a397(1, #v17)
			position2 = v17[v23]
			v24 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			table.remove(v17, v23)
		end

		local isA = additionalObjectType:IsA(__wf_atom_8d0b7f88)
		local v25

		if alignObjectRotationToTerrain[v23] and isA then
			v25, v24 = module3.GetGroundAlignedSpawnPosRot(additionalObjectType, position2, v24, false, 30)
		else
			v25 = module3.GetGroundPos(position2)
		end

		if __wf_atom_7e8ad928(v25) or not (not isA or module3.ObjTypeHasHeightClearance(additionalObjectType, v25)) then
			continue
		end

		local entity = gRegion:CreateEntity(additionalObjectType, v25, v24)
		v10:__wf_atom_d494454b(entity)
	end

	if #poiTypes > 0 and #gRegion:__wf_atom_439c0d29(Symbol("DynamicPatrolRoute"), position, 0, 35) == 0 then
		local v23 = math.max(2, v10:__wf_atom_3634e6d2() - maxEnemiesByFire + 1)
		local v24 = __wf_atom_5784a397(v23, v23 + 2)

		if v24 > 0 then
			for _ = 1, v24 do
				if #v18 == 0 then
					break
				end

				local v25 = __wf_atom_5784a397(1, #v18)
				local v26 = v18[v25]
				local poiType = poiTypes[__wf_atom_5784a397(1, #poiTypes)]
				local entity = gRegion:CreateEntity(poiType, v26, __wf_atom_fa8d0177(position, v26))
				v10:__wf_atom_d494454b(entity)
				table.remove(v18, v25)
			end
		end
	end
end

local function fn8()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("CampfireWaypoint"), position, 0, (math.max(v21, 20)))
	local layerIndex = module2.GetLayerIndex(v10)
	local filterObjectsInLayerIndex = module2.FilterObjectsInLayerIndex(layerIndex, __wf_atom_439c0d29)

	for i = #filterObjectsInLayerIndex, 1, -1 do
		if not filterObjectsInLayerIndex[i]:IsEnabled() then
			table.remove(filterObjectsInLayerIndex, i)
		end
	end

	local v23

	if __wf_atom_7e8ad928(filterObjectsInLayerIndex) or not (#filterObjectsInLayerIndex > 0) then
		v23 = module3.GetGroundPos(position)
	else
		while __wf_atom_7e8ad928(v23) and #filterObjectsInLayerIndex > 0 do
			local v24 = __wf_atom_5784a397(1, #filterObjectsInLayerIndex)
			v23 = module3.GetGroundPos(filterObjectsInLayerIndex[v24]:GetPosition())
			filterObjectsInLayerIndex[v24]:Disable()
			table.remove(filterObjectsInLayerIndex, v24)
		end
	end

	if __wf_atom_7e8ad928(v23) then
		return
	end

	position = v23
	v10:SetPosition(v23)
	return true
end

local function fn9()
	if v10:__wf_atom_3634e6d2() > 0 then
		return
	end

	local enemyLevel = module.GetEnemyLevel(v10)
	v12 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v23 = ({ spawnCount1p, spawnCount2p, spawnCount3p })[v12]
	local encounterBoostEnemies = module.GetEncounterBoostEnemies(v10)
	local maxValue

	if encounterBoostEnemies then
		maxValue = v23.maxValue
		local __wf_atom_5b6b447d = v10:__wf_atom_5b6b447d()

		if not __wf_atom_7e8ad928(__wf_atom_5b6b447d) and __wf_atom_5b6b447d ~= EMPTY_SYMBOL then
			maxValue += 1
		end
	else
		maxValue = __wf_atom_5784a397(v23.minValue, v23.maxValue)
	end

	if module.GetEncounterChillout(v10) then
		maxValue = math.ceil(maxValue) * 0.5
	end

	if scaleWithEnemyLevel then
		maxValue += math.floor(enemyLevel.minValue / levelsPerBracket) * enemiesToAddPerBracket
	end

	local v24 = math.min(maxValue, maxNumEnemies)
	local randomSquadList = module.GetRandomSquadList(v24, squadOverride)

	if v24 <= 0 then
		fn4()
		return
	end

	local all = gRegion:FindAll(gNpcSpawnPointType, position, 0, (math.max(7, v21)))
	local filterDisallowedSpawnpoints = module.FilterDisallowedSpawnpoints(all)
	table.sort(filterDisallowedSpawnpoints, function(a, b)
		local __wf_atom_db682341 = a:__wf_atom_db682341()
		return __wf_atom_db682341 ~= EMPTY_SYMBOL and b:__wf_atom_db682341() == EMPTY_SYMBOL
			or string.find(tostring(__wf_atom_db682341), "Heavy")
	end)
	local __wf_atom_2b1fe281 = v10:__wf_atom_2b1fe281()
	local v25 = Vector(0, 2, 0)
	local v26 = Vector()
	local count = 0
	local count2 = 0

	for i = 1, v24 do
		local v27

		if not (__wf_atom_7e8ad928(filterDisallowedSpawnpoints) or not (#filterDisallowedSpawnpoints > 0) or not (i <= #filterDisallowedSpawnpoints) or fillFireSpotsFirst and (not fillFireSpotsFirst or #v16 ~= 0)) then
			v27 = filterDisallowedSpawnpoints[i]
		end

		local v28 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		local dogAgentType2

		if not __wf_atom_7e8ad928(v27) then
			dogAgentType2 = module.GetRandomEnemyAgentType(v27, v2, v28, v10)
			local __wf_atom_66a525a6 = v27:__wf_atom_66a525a6()

			if __wf_atom_66a525a6 > 0 then
				v28 = __wf_atom_66a525a6
			end
		end

		if __wf_atom_7e8ad928(dogAgentType2) then
			if __wf_atom_7e8ad928(randomSquadList) or not (i <= #randomSquadList) then
				if encounterBoostEnemies and i == 1 and not v13 and math.random() <= 1 then
					dogAgentType2 = module.GetRandomEnemyAgentType(nil, v2, v28, v10, 0, 2, true)
				elseif heavyChance > 0 and math.random() <= heavyChance and i == 1 then
					dogAgentType2 = module.GetRandomEnemyAgentType(nil, v2, v28, v10, 0, 2, true)
				elseif
					__wf_atom_7e8ad928(dogAgentType)
					or not (count > 0)
					or v14
					or not (math.random() <= dogSpawnChance)
				then
					dogAgentType2 = module.GetRandomEnemyAgentType(nil, v2, v28, v10)
				else
					dogAgentType2 = dogAgentType
				end
			else
				dogAgentType2 = module.GetRandomEnemyAgentType(
					nil,
					v2,
					v28,
					v10,
					randomSquadList[i].agentSpec.archetype,
					randomSquadList[i].agentSpec.rank,
					randomSquadList[i].agentSpec.exclusiveRank
				)
			end
		end

		if __wf_atom_7e8ad928(dogAgentType2) then
			print("ERROR: Couldn't find enemy type to spawn!")
		else
			local v29 = math.random() <= seatedChance
			local v30 = false
			local randomPointInRangeOnNav, v31

			if __wf_atom_7e8ad928(v27) then
				if #v16 > 0 then
					local v32 = __wf_atom_5784a397(1, #v16)
					randomPointInRangeOnNav = v16[v32]
					local v33 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
					v31 = Rotation(v33.heading, 0, 0)
					table.remove(v16, v32)
					v30 = true
				elseif useOuterSpawnRing and #v18 > 0 then
					local v32 = __wf_atom_5784a397(1, #v18)
					randomPointInRangeOnNav = v18[v32]
					local v33 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
					v31 = Rotation(v33.heading, 0, 0)
					table.remove(v18, v32)
				elseif useOuterSpawnRing or not (#v17 > 0) then
					randomPointInRangeOnNav = v9:GetRandomPointInRangeOnNav(
						position,
						v19.minValue,
						v19.maxValue,
						true,
						0.5
					)
					local v32 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
					v31 = Rotation(v32.heading, 0, 0)
				else
					local v32 = __wf_atom_5784a397(1, #v17)
					randomPointInRangeOnNav = v17[v32]
					local v33 = __wf_atom_fa8d0177(position, randomPointInRangeOnNav)
					v31 = Rotation(v33.heading, 0, 0)
					table.remove(v17, v32)
				end
			else
				randomPointInRangeOnNav = v27:GetPosition()
				v31 = v27:__wf_atom_dc309f8a()

				if v27:__wf_atom_a5304c35(position) <= v5.maxValue then
					v30 = true
				end
			end

			if not __wf_atom_7e8ad928(randomPointInRangeOnNav) then
				local __wf_atom_402b3832 = v9:__wf_atom_402b3832(dogAgentType2, randomPointInRangeOnNav, v31, v, v28)

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					v10:__wf_atom_97f955c1(__wf_atom_402b3832)

					if not __wf_atom_7e8ad928((__wf_atom_402b3832:__wf_atom_50a7d83e())) then
						if dogAgentType2:IsA(dogAgentType) then
							if #dogSleepingPois > 0 then
								local v32 = dogSleepingPois[__wf_atom_5784a397(1, #dogSleepingPois)]
								local entity = gRegion:CreateEntity(v32, randomPointInRangeOnNav, v31)
								v10:__wf_atom_d494454b(entity)
							end
						elseif v30 and not module.IsHeavyAgent(__wf_atom_402b3832) then
							local v32 = false
							module.HoldPosition(__wf_atom_402b3832, true)

							if
								v29
								and #campChairDecos > 0
								and count2 < maxNumSeats
								and __wf_atom_7e8ad928(gRegion:__wf_atom_fbb89790(
									position + v25,
									randomPointInRangeOnNav + v25,
									1,
									campObjects,
									v22,
									nil,
									v26
								))
							then
								local campChairDeco = campChairDecos[__wf_atom_5784a397(1, #campChairDecos)]
								local v33 = __wf_atom_fa8d0177(position, randomPointInRangeOnNav)
								local v34 = randomPointInRangeOnNav + __wf_atom_9341614d(
									Vector(1, 0, 0),
									Rotation(v33.heading, 0, 0)
								)
								local groundAlignedSpawnPosRot, v35 = module3.GetGroundAlignedSpawnPosRot(
									campChairDeco,
									v34,
									v31,
									false,
									15
								)

								if not __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
									local entity = gRegion:CreateEntity(campChairDeco, groundAlignedSpawnPosRot, v35)
									entity:__wf_atom_0ed81088(false)
									v10:__wf_atom_d494454b(entity)
									count2 += 1
									v32 = true
								end
							end

							if not v32 and #standingPois > 0 then
								local v33 = standingPois[__wf_atom_5784a397(1, #standingPois)]
								local entity = gRegion:CreateEntity(v33, randomPointInRangeOnNav, v31)
								v10:__wf_atom_d494454b(entity)
							end
						end
					end

					if not v14 then
						v14 = dogAgentType2 == dogAgentType
					end

					if not v13 then
						v13 = module.IsHeavyAgent(__wf_atom_402b3832)
					end

					count += 1

					if __wf_atom_2b1fe281 > 0 and __wf_atom_2b1fe281 <= count then
						break
					end
				end
			end
		end

		if i < v24 then
			Sleep(0)
		end

		if module.ShouldShutDown(v10, v15) then
			break
		end
	end
end

local function fn10()
	local enemyLevel = module.GetEnemyLevel(v10)
	v12 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v23 = ({ spawnCount1p, spawnCount2p, spawnCount3p })[v12]
	local v24 = __wf_atom_5784a397(v23.minValue, v23.maxValue)
	local randomSquadList = module.GetRandomSquadList(v24, squadOverride)
	local __wf_atom_2b1fe281 = v10:__wf_atom_2b1fe281()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("DogThreatenPoi"), position, 0, 15)
	local count = 0

	for i = 1, v24 do
		local v25 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		local v26

		if __wf_atom_7e8ad928(randomSquadList) or not (i <= #randomSquadList) then
			v26 = module.GetRandomEnemyAgentType(nil, v2, v25, v10)
		else
			v26 = module.GetRandomEnemyAgentType(
				nil,
				v2,
				v25,
				v10,
				randomSquadList[i].agentSpec.archetype,
				randomSquadList[i].agentSpec.rank,
				randomSquadList[i].agentSpec.exclusiveRank
			)
		end

		if __wf_atom_7e8ad928(v26) then
			print("ERROR: Couldn't find enemy type to spawn!")
		else
			local position2 = nil
			local v27 = nil

			if randomSquadList[i].agentSpec.archetype == 5 then
				if #__wf_atom_439c0d29 > 0 then
					position2 = __wf_atom_439c0d29[1]:GetPosition()
					v27 = __wf_atom_439c0d29[1]:__wf_atom_dc309f8a()
					table.remove(__wf_atom_439c0d29, 1)
				end
			else
				position2 = v9:GetRandomPointInRangeOnNav(position, 6, 8, true, 0.5)
				local v28 = __wf_atom_fa8d0177(position2, position)
				v27 = Rotation(v28.heading, 0, 0)
			end

			if not __wf_atom_7e8ad928(position2) then
				local __wf_atom_402b3832 = v9:__wf_atom_402b3832(v26, position2, v27, v, v25)

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					v10:__wf_atom_97f955c1(__wf_atom_402b3832)

					if
						not __wf_atom_7e8ad928((__wf_atom_402b3832:__wf_atom_50a7d83e()))
						and #standingPois > 0
						and randomSquadList[i].agentSpec.archetype ~= 5
					then
						local v28 = standingPois[__wf_atom_5784a397(1, #standingPois)]
						local entity = gRegion:CreateEntity(v28, position2, v27)
						v10:__wf_atom_d494454b(entity)
					end

					count += 1

					if __wf_atom_2b1fe281 > 0 and __wf_atom_2b1fe281 <= count then
						break
					end
				end
			end
		end

		if i < v24 then
			Sleep(0)
		end

		if module.ShouldShutDown(v10, v15) then
			break
		end
	end
end

local function fn11(object)
	v9 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v10 = object
	position = object:GetPosition()
	v15 = object:__wf_atom_26b04ea9() or object
	v19 = Range(v5.maxValue + 1, v5.maxValue + 3)
	v20 = Range(v19.maxValue + 6, v19.maxValue + 10)
	v21 = v15:__wf_atom_103377cc()
	v10:__wf_atom_8e6fec76(1)
	return true
end

local function fn12()
	local v23 = false
	local total = 0

	while not module.ShouldShutDown(v10, v15) and v10:__wf_atom_3634e6d2() - #__wf_atom_402b3832s > 0 do
		v11 = v10:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v10, v11)

		if not v23 and guardRadiusOnAlerted then
			for _, v24 in ipairs(v11) do
				if not v24:__wf_atom_04ea4887() then
					continue
				end

				if guardRadiusOnAlerted > 0 then
					for _, v25 in ipairs(v11) do
						v25:__wf_atom_03cc4f3c(v3, position, guardRadiusOnAlerted)
					end
				end

				v23 = true
				break
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

local function fn13()
	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	if module.ShouldShutDown(v10) then
		v10:__wf_atom_8776856a(#v11)
		module.RemoveAgents(v10)
		v10:__wf_atom_8e6fec76(6)
	else
		v10:__wf_atom_050639fe()
		v10:__wf_atom_8776856a(0)
		v10:__wf_atom_8e6fec76(4)

		if not module2.IsInOverworld() then
			v10:Disable()
		end
	end

	while not __wf_atom_7e8ad928(v10) and v10:__wf_atom_e464a32f() > 0 and v9:__wf_atom_c6f505f2(v10) > 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveAgents(v10)

	if removeObjectsOnCompletion or v10:__wf_atom_4026dfb5() ~= 4 then
		module.RemoveObjects(v10)
	end

	Sleep(0)
end

function Start(p)
	if not fn11(p) then
		return
	end

	if isInteriorCampsite then
		fn8()
	else
		local groundPos = module3.GetGroundPos(position)

		if __wf_atom_7e8ad928(groundPos) then
			print("Error: Couldn't find ground position for campfire, falling back to hint position!")
		else
			position = groundPos
		end
	end

	local v23 = true

	if math.random() <= cartSpawnChance and #cartTypes > 0 then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("OdeCartSpawn"), position, 0, 20)

		if #__wf_atom_439c0d29 > 0 then
			local v24 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]

			if v24:__wf_atom_1c8f7b2d(v10) <= 8 then
				v23 = false
			end

			local entity = gRegion:CreateEntity(
				cartTypes[__wf_atom_5784a397(1, #cartTypes)],
				v24:GetPosition(),
				v24:__wf_atom_dc309f8a()
			)
			v10:__wf_atom_d494454b(entity)
			v24:FirePort("Disable")
			seatedChance = 0
		end
	end

	if v23 and #campObjects > 0 then
		local campObject = campObjects[__wf_atom_5784a397(1, #campObjects)]
		local groundAlignedSpawnPosRot, v24 = module3.GetGroundAlignedSpawnPosRot(
			campObject,
			position,
			Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		)
		local entity = gRegion:CreateEntity(campObject, groundAlignedSpawnPosRot, v24)
		v10:__wf_atom_d494454b(entity)
	end

	fn3()
	v11 = v10:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v10, v11)
	fn9()

	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	fn6()
	fn7()
	module2.StartPluginScripts(pluginScripts, v10)
	v10:__wf_atom_8e6fec76(2)
	fn12()
	fn13()
end

function StartHunterFence(p)
	if not fn11(p) then
		return
	end

	if spawnAtHint then
		if not module2.IsInOverworld() then
			fn8()
		end
	else
		local __wf_atom_28ce676a = v9:__wf_atom_28ce676a()
		__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(0, 25), 3)
		__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
		__wf_atom_28ce676a:__wf_atom_4a7833f4()
		__wf_atom_28ce676a:__wf_atom_655394dc()
		__wf_atom_28ce676a:__wf_atom_06c7577b()
		__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
		__wf_atom_28ce676a:__wf_atom_df6829ae(Range(5, 3.4028234663852886e38))
		__wf_atom_28ce676a:__wf_atom_bacad54b()
		__wf_atom_28ce676a:__wf_atom_9699b67c(false)
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
		__wf_atom_28ce676a:__wf_atom_a49949e0(
			Symbol("DynamicCampsiteEncounter.lua-StartHunterFence"),
			Color("0xFFCC00")
		)
		__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), { 4, 27, 24, 40 })
		local positions = module5.GetPositions(1, __wf_atom_28ce676a)

		if #positions == 0 or __wf_atom_7e8ad928(v10) then
			return
		end

		position = positions[1]
		v10:__wf_atom_c53e1842(position)
	end

	local v23

	if #campObjects > 0 then
		local campObject = campObjects[__wf_atom_5784a397(1, #campObjects)]
		local groundPos = module3.GetGroundPos(position)
		local v24 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		v23 = gRegion:CreateEntity(campObject, groundPos, v24)
		v10:__wf_atom_d494454b(v23)
	end

	local v24 = __wf_atom_5784a397(1, #cageTypes)
	local entities = {}

	if #cageTypes > 0 then
		local cageType = cageTypes[v24]

		if not __wf_atom_7e8ad928(cageType) then
			local v25 = fn2(Range(0, 5), 1, 10)
			local positions = module5.GetPositions(1, v25)

			if #positions > 0 and not __wf_atom_7e8ad928(v10) then
				local v26 = __wf_atom_fa8d0177(position, positions[1])
				local groundAlignedSpawnPosRot, v27 = module3.GetGroundAlignedSpawnPosRot(
					cageType,
					positions[1],
					Rotation(v26.heading, 0, 0),
					true,
					10
				)

				if groundAlignedSpawnPosRot ~= nil then
					local entity = gRegion:CreateEntity(cageType, groundAlignedSpawnPosRot, v27)
					v10:__wf_atom_d494454b(entity)
					table.insert(entities, entity)
				end
			end
		end
	end

	v11 = v10:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v10, v11)

	if #v11 == 0 then
		fn10()

		if __wf_atom_7e8ad928(v10) then
			print("Shutdown due to level streaming")
			return
		end

		if math.random() <= randomHostileAgentChance and #randomHostileAgents > 0 then
			local enemyLevel = module.GetEnemyLevel(v10)

			for _ = 1, __wf_atom_5784a397(numRandomHostileAgents.minValue, numRandomHostileAgents.maxValue) do
				local __wf_atom_a70d9d07 = v9:__wf_atom_a70d9d07(position, 3, true, 0.5)
				local randomHostileAgent = randomHostileAgents[__wf_atom_5784a397(1, #randomHostileAgents)]
				local __wf_atom_402b3832 = v9:__wf_atom_402b3832(
					randomHostileAgent,
					__wf_atom_a70d9d07,
					__wf_atom_fa8d0177(position, __wf_atom_a70d9d07),
					EMPTY_SYMBOL,
					enemyLevel.minValue
				)
				v10:__wf_atom_97f955c1(__wf_atom_402b3832)
				__wf_atom_402b3832:__wf_atom_50a7d83e():__wf_atom_2f3f52aa(5)
			end
		else
			local animalAgentType = animalAgentTypes[v24]
			local v25 = 1

			if math.random() <= 0.01 then
				animalAgentType = rareAnimalAgentTypes[v24] or animalAgentType
			elseif math.random() <= 0.25 or #entities == 0 then
				v25 = 2
			end

			if not __wf_atom_7e8ad928(animalAgentType) then
				for _ = 1, v25 do
					local randomPointInRangeOnNav = v9:GetRandomPointInRangeOnNav(position, 1, 5, true, 0.5)
					local __wf_atom_402b3832 = v9:__wf_atom_402b3832(
						animalAgentType,
						randomPointInRangeOnNav,
						Rotation(__wf_atom_5784a397(0, 360), 0, 0),
						EMPTY_SYMBOL
					)

					if __wf_atom_7e8ad928(__wf_atom_402b3832) then
						continue
					end

					v10:__wf_atom_97f955c1(__wf_atom_402b3832)
					__wf_atom_402b3832:SetPaused(true, v4)
					table.insert(__wf_atom_402b3832s, __wf_atom_402b3832)
				end
			end
		end
	end

	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	v10:__wf_atom_8e6fec76(2)
	fn12()
	Sleep(1.5)

	if not __wf_atom_7e8ad928(v23) then
		local __wf_atom_bb3e7833 = v23:__wf_atom_bb3e7833(__wf_atom_8973af3f)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:PlayTriggeredFade()
			Sleep(2)
		end

		if not __wf_atom_7e8ad928(v23) then
			v23:Destroy()
		end
	end

	Sleep(1)

	for _, v25 in ipairs(__wf_atom_402b3832s) do
		if not __wf_atom_7e8ad928(v25) then
			v25:SetPaused(false, v4)
		end
	end

	fn13()
end