local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("SF.Scripts.Libs.RaycastLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local clues = nil
local v9 = nil
local position = nil
local v10 = nil

function OnDestroyed(object)
	gRegion:CreateEntity(nil, object:GetPosition() + Vector(0, 0.5, 0), __wf_atom_80368bb1)
end

function OnKilled(object)
	v9 = gRegion:CreateEntity(odeOrdersNotePickup, object:GetPosition(), __wf_atom_80368bb1)
	v3:__wf_atom_d494454b(v9)
	module3.RemoveSparrowDestination(object)
	module3.AddSparrowDestination(v9, v3)
end

local function fn(p)
	for i = #p, 1, -1 do
		if __wf_atom_7e8ad928(p[i]) then
			p.remove(p, i)
		end
	end
end

local function fn2()
	local v11 = gRegion:__wf_atom_f738b4af(Symbol("TreasureBulliesSpawn"), position, 0, v10) or v3
	local position2 = v11:GetPosition()
	local v12 = Symbol("Grunt")
	local v13 = Symbol("Heavy")
	local enemyLevel = module2.GetEnemyLevel(v3)
	local v14 = { v12, v13, v12 }

	for i = 1, #v14 do
		local v15 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		local __wf_atom_c91d5f5b = v:__wf_atom_c91d5f5b(bullySquadAgentTypes[i], v11, 5, Symbol("RandomTeam"), v15)

		if __wf_atom_7e8ad928(__wf_atom_c91d5f5b) then
			continue
		end

		v3:__wf_atom_97f955c1(__wf_atom_c91d5f5b)
		local __wf_atom_50a7d83e = __wf_atom_c91d5f5b:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		if not (__wf_atom_7e8ad928(soulModeAttachType) or __wf_atom_50a7d83e:__wf_atom_a586ea4c(soulModeAttachType)) then
			local v16 = __wf_atom_50a7d83e:Attach(soulModeAttachType, EMPTY_SYMBOL)
			v3:__wf_atom_d494454b(v16)
		end

		__wf_atom_c91d5f5b:__wf_atom_03cc4f3c(Symbol("Guard"), position2, 5)
		module3.AddSparrowDestination(__wf_atom_50a7d83e, v3)

		if i ~= #v14 then
			continue
		end

		__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
		gRegion:__wf_atom_5b35a0c8(
			__wf_atom_50a7d83e:GetPosition() + Vector(0, 2, 0),
			Color(255, 0, 0),
			"Sinecure: WHERE'S THE KEY?! One of you knows something",
			2,
			30
		)
	end

	fn(villagerAgentTypes)

	if #villagerAgentTypes > 0 then
		for _ = 1, 2 do
			local villagerAgentType = villagerAgentTypes[__wf_atom_5784a397(1, #villagerAgentTypes)]
			local __wf_atom_c91d5f5b = v:__wf_atom_c91d5f5b(villagerAgentType, v11, 8, Symbol("RandomTeam"), 1)

			if not __wf_atom_7e8ad928(__wf_atom_c91d5f5b) then
				v3:__wf_atom_97f955c1(__wf_atom_c91d5f5b)
			end
		end
	end
end

local function fn3(name)
	local v11 = {}

	if not __wf_atom_7e8ad928(buriedTreasureDecoBrick) then
		v11[buriedTreasureDecoBrick:GetName()] = "hidden under stones"
	end

	if not __wf_atom_7e8ad928(buriedTreasureDeco) then
		v11[buriedTreasureDeco:GetName()] = "buried"
	end

	if not __wf_atom_7e8ad928(sackContainer) then
		v11[sackContainer:GetName()] = "in a cloth sack"
	end

	if not __wf_atom_7e8ad928(buriedTreasureDecoBrick) then
		v11[boxContainer:GetName()] = "in a small chest"
	end

	if #validDestroyableContainerTypesToFind > 0 then
		v11.DestroyableItem = "in a fragile container"
	end

	local v12 = {}
	local v13 = nil

	for k, v14 in pairs(v11) do
		if k == name then
			v13 = "The key is " .. v14
		else
			table.insert(v12, "The key is not " .. v14)
		end
	end

	clues = {}

	for i = 1, numberOfClues - 2 do
		local v14 = __wf_atom_5784a397(1, #v12)
		clues[i] = v12[v14]
		table.remove(v12, v14)
	end

	_T.TreasureKeyPos = v6:GetPosition()
	table.insert(clues, v13)
	table.insert(clues, "DistanceClue")
	_T.Clues = clues
end

local function fn4() -- 2 equivalent calls inferred from this helper
	return Rotation(__wf_atom_5784a397(0, 360), 0, 0)
end

local function fn5(p)
	local v11 = nil
	local v12 = nil
	local isVolume = false
	v8 = module.RandomizeTableOrder(v8)

	for i = 1, #v8 do
		if not (v8[i].numItemsSpawned < v8[i].maxSpawnCount) then
			continue
		end

		local itemContainers = v8[i].itemContainers

		if p then
			itemContainers = v8[i].noteContainers
		end

		if __wf_atom_7e8ad928(itemContainers) or not (#itemContainers > 0) then
			continue
		end

		local v13 = __wf_atom_5784a397(1, #itemContainers)
		v12 = itemContainers[v13]
		table.remove(itemContainers, v13)
		local v14 = __wf_atom_5784a397(1, #v8[i].spawnPoints)
		v11 = v8[i].spawnPoints[v14]
		table.remove(v8[i].spawnPoints, v14)
		v8[i].numItemsSpawned += 1
		isVolume = v8[i].isVolume
		break
	end

	local position2, v13

	if isVolume then
		local randomPointInVolume = module.GetRandomPointInVolume(v11, true)
		local __wf_atom_0e0a6fee = v:__wf_atom_0e0a6fee(randomPointInVolume)
		position2, v13 = module5.GetGroundAlignedSpawnPosRot(buriedTreasureDeco, __wf_atom_0e0a6fee, fn4(), false, 30) -- inferred equivalent call
	else
		position2 = v11:GetPosition()
		v13 = v11:__wf_atom_dc309f8a()
	end

	local entity = gRegion:CreateEntity(v12, position2, v13)
	v3:__wf_atom_d494454b(entity)

	for _, v14 in ipairs(v8) do
		for i = #v14.spawnPoints, 1, -1 do
			if v14.spawnPoints[i]:__wf_atom_d5fda8be(position2) <= 10 then
				table.remove(v14.spawnPoints, i)
			end
		end
	end

	return entity, v12
end

local function fn6()
	validDestroyableContainerTypesToFind = fn(validDestroyableContainerTypesToFind)
	v8 = {
		{
			tag = Symbol("TreasureBrickSpawn"),
			maxSpawnCount = 1,
			noteContainers = { buriedTreasureDecoBrickClue },
			itemContainers = { buriedTreasureDecoBrick }
		},
		{
			tag = Symbol("BuriedTreasureVolume"),
			maxSpawnCount = 2,
			noteContainers = { buriedTreasureDecoClue, buriedTreasureDecoClue, journalNote },
			itemContainers = { buriedTreasureDeco },
			isVolume = true
		},
		{
			tag = Symbol("BuriedTreasureVolumeSand"),
			maxSpawnCount = 2,
			noteContainers = { buriedTreasureDecoSand },
			itemContainers = { buriedTreasureDecoSand },
			isVolume = true
		},
		{
			tag = Symbol("NoteSpawnPoint"),
			maxSpawnCount = 1,
			noteContainers = { singlePaperNote, multiPaperNote, journalNote, rolledMessageNote }
		},
		{
			tag = Symbol("HiddenPosterSpawnPoint"),
			maxSpawnCount = 2,
			noteContainers = { singlePaperNote }
		},
		{
			tag = Symbol("TreasureSackSpawnPoint"),
			maxSpawnCount = 1,
			noteContainers = { sackContainerClue },
			itemContainers = { sackContainer }
		},
		{
			tag = Symbol("HiddenItemSpawnPoint"),
			maxSpawnCount = 2,
			noteContainers = { sackContainerClue, boxContainerClue },
			itemContainers = { sackContainer, boxContainer }
		},
		{
			tag = Symbol("VillageNpc"),
			maxSpawnCount = 1,
			noteContainers = { singlePaperNote }
		},
		{
			destroyableTypes = validDestroyableContainerTypesToFind,
			maxSpawnCount = 1,
			noteContainers = { sackContainerClue, journalNote },
			itemContainers = { sackContainer, boxContainer },
			isDestroyable = true
		}
	}

	for _, v11 in ipairs(v8) do
		if __wf_atom_7e8ad928(v11.tag) then
			if not __wf_atom_7e8ad928(v11.destroyableTypes) then
				v11.spawnPoints = {}

				for _, destroyableType in ipairs(v11.destroyableTypes) do
					local all = gRegion:FindAll(destroyableType, position, 15, v10 * 1.5)
					module.MergeTables(v11.spawnPoints, all, true)
				end
			end
		else
			v11.spawnPoints = gRegion:__wf_atom_439c0d29(v11.tag, position, 0, v10 * 1.5)
		end

		v11.numItemsSpawned = 0
	end

	for i = #v8, 1, -1 do
		fn(v8[i].noteContainers)
		fn(v8[i].itemContainers)
		fn(v8[i].spawnPoints)
	end

	for i = #v8, 1, -1 do
		if __wf_atom_7e8ad928(v8[i].spawnPoints) or #v8[i].spawnPoints == 0 then
			table.remove(v8, i)
		elseif
			(__wf_atom_7e8ad928(v8[i].itemContainers) or #v8[i].itemContainers == 0)
			and (__wf_atom_7e8ad928(v8[i].noteContainers) or #v8[i].noteContainers == 0)
		then
			table.remove(v8, i)
		end
	end

	local v11, v12 = fn5()
	v6 = gRegion:CreateEntity(keyPickupType, v11:GetPosition(), __wf_atom_80368bb1)
	v3:__wf_atom_d494454b(v6)
	fn3(v12:GetName())
	v5 = {}

	for i = 1, numberOfClues do
		v5[i] = fn5(true)
	end

	local v13 = v10 * 2
	local randomPointInRangeOnNav = v:GetRandomPointInRangeOnNav(position, v10, v13, true, 0.5)
	local groundAlignedSpawnPosRot, v14 = module5.GetGroundAlignedSpawnPosRot(
		buriedTreasureDeco,
		randomPointInRangeOnNav,
		fn4(), -- inferred equivalent call
		false,
		30
	)

	if not __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
		v7 = gRegion:CreateEntity(buriedTreasureDeco, groundAlignedSpawnPosRot, v14)
		v3:__wf_atom_d494454b(v7)
	end
end

function Main(object)
	print("Clear patrol encounter started")
	v = module.WaitForAiDir()
	v2 = object:__wf_atom_dd85e6db()
	v3 = object
	v4 = v3:__wf_atom_26b04ea9()
	position = v4:GetPosition()
	v10 = v3:__wf_atom_103377cc()
	object:__wf_atom_8e6fec76(1)
	module2.RemoveMissionMarker(v4)
	fn6()
	fn2()

	if not __wf_atom_7e8ad928(areaMarkerType) then
		local areaMarker = module2.CreateAreaMarker(areaMarkerType, v4:GetPosition(), v10 * 1.5, true)
		v3:__wf_atom_d494454b(areaMarker)
	end

	object:__wf_atom_8e6fec76(2)
	local count = #clues
	local v11 = nil
	local v12 = {
		killEnemies = 0,
		readTheOrders = 1,
		findCluesAndKey = 2,
		findTreasure = 3,
		foundTreasure = 4
	}
	local total = 0

	while not module2.PrimedMissionShouldShutDown(object, v4) do
		local __wf_atom_2b1fe281 = v3:__wf_atom_2b1fe281()

		if __wf_atom_2b1fe281 ~= v11 then
			if __wf_atom_2b1fe281 == v12.killEnemies then
				module4.UpdateOrAddHudTask(object)
			elseif __wf_atom_2b1fe281 == v12.readTheOrders then
				module4.UpdateOrAddHudTask(object, "ODEORDERS", "Read the Ode orders")
			elseif __wf_atom_2b1fe281 == v12.findCluesAndKey then
				module4.UpdateOrAddHudTask(object, "FINDKEY", "Find the key")
				module4.UpdateOrAddHudTask(
					v3,
					"CLUECOUNTER",
					"Search Lummins Village for clues",
					numberOfClues - #clues .. "/" .. numberOfClues
				)

				if #clues == 0 then
					module4.CompleteHudTask(v3, nil, "CLUECOUNTER")
				end
			elseif __wf_atom_2b1fe281 == v12.findTreasure then
				module4.UpdateOrAddHudTask(object, "FINALSTAGE", "Find and unlock the Silent Rose cache")
				module3.AddSparrowDestination(v7, object)
				module3.SpawnSparrow()
			end

			v11 = __wf_atom_2b1fe281
		end

		if __wf_atom_2b1fe281 == v12.killEnemies then
			if not __wf_atom_7e8ad928(v9) then
				module4.CompleteHudTask(object, nil, nil, 5)
				v3:__wf_atom_8776856a(v12.readTheOrders)
			end
		elseif __wf_atom_2b1fe281 == v12.readTheOrders then
			if __wf_atom_7e8ad928(v9) then
				module4.CompleteHudTask(object, nil, "ODEORDERS", 5)
				v3:__wf_atom_8776856a(v12.findCluesAndKey)
			elseif #clues < numberOfClues or __wf_atom_7e8ad928(v6) then
				module4.RemoveHudTask(object, nil, "ODEORDERS")
				v3:__wf_atom_8776856a(v12.findCluesAndKey)
			end
		elseif __wf_atom_2b1fe281 == v12.findCluesAndKey then
			if #clues < count then
				module4.UpdateOrAddHudTask(
					v3,
					"CLUECOUNTER",
					"Search Lummins Village for clues",
					numberOfClues - #clues .. "/" .. numberOfClues
				)

				if #clues == 0 then
					module4.CompleteHudTask(v3, nil, "CLUECOUNTER")
				end

				if #clues == 0 then
					local registeredAreaMarker = module2.GetRegisteredAreaMarker(v3)

					if not __wf_atom_7e8ad928(registeredAreaMarker) then
						registeredAreaMarker:Destroy()
					end

					if not __wf_atom_7e8ad928(v6) then
						local v13 = Vector(__wf_atom_5784a397(-23, 23), 0, __wf_atom_5784a397(-23, 23))
						local areaMarker = module2.CreateAreaMarker(areaMarkerType, v6:GetPosition() + v13, 25, true)
						v3:__wf_atom_d494454b(areaMarker)
					end
				end

				count = #clues
			end

			if __wf_atom_7e8ad928(v6) then
				module4.CompleteHudTask(object, nil, "FINDKEY", 5)
				v3:__wf_atom_8776856a(v12.findTreasure)
			end
		elseif __wf_atom_2b1fe281 == v12.findTreasure and module.AnyPlayerNearPos(v7:GetPosition(), 3) then
			module4.CompleteHudTask(object, nil, "FINALSTAGE", 5)
			object:__wf_atom_8e6fec76(4)
			break
		end

		if __wf_atom_2b1fe281 <= v12.findCluesAndKey then
			if total >= 5 then
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

				for _, v13 in ipairs(__wf_atom_ef7900cf) do
					if not (v13:__wf_atom_1c8f7b2d(v3) <= v10) then
						continue
					end

					module4.UpdateVisibility(true)
					break
				end

				total = 0
			else
				total += __wf_atom_084b3e93()
			end
		end

		local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_4026dfb5() == 4 then
		module4.CompleteHudTask(object)
		Sleep(3)

		if __wf_atom_7e8ad928(object) then
			return
		end
	else
		if not __wf_atom_7e8ad928(nil) then
			(nil):__wf_atom_8e6fec76(6)
		end

		object:__wf_atom_8e6fec76(6)
	end

	module4.RemoveHudGroup(object)
	module2.RemoveObjects(object)
	print("Clear patrol encounter ended")
end

local function fn7(object, p) -- 1 equivalent call inferred from this helper
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:__wf_atom_355b9a20(p, object, EMPTY_SYMBOL)
		end
	end
end

function ReadNote(instance, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v11

	if __wf_atom_7e8ad928(_T.Clues) or not (#_T.Clues > 0) then
		v11 = "Clue Test"
	else
		v11 = _T.Clues[1]
		table.remove(_T.Clues, 1)
	end

	if v11 == "DistanceClue" and not __wf_atom_7e8ad928(_T.TreasureKeyPos) then
		local _ = instance:__wf_atom_a5304c35(_T.TreasureKeyPos) * 0.75
		v11 = "The note contains a crudely drawn map with a circled area, check your world map [M]"
	end

	local v12 = StringSplit("+", v11)
	local v13 = v12[1] or ""
	local v14 = v12[2] or ""
	local v15 = v12[3] or ""
	local v16 = ""
	local v17 = ""
	local v18 = ""
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("VillageNpc"), instance:GetPosition(), 0, 2)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		gRegion:__wf_atom_5b35a0c8(
			__wf_atom_f738b4af:GetPosition() + Vector(0, 1.5, 0),
			Color(255, 255, 0),
			"Villager: Here, I think you dropped this",
			2,
			20
		)
	end

	if not __wf_atom_7e8ad928(customNoteBacker) then
		v16 = customNoteBacker:__wf_atom_5b41f63b()
	end

	if not __wf_atom_7e8ad928(noteOverlayImage) then
		v17 = noteOverlayImage:__wf_atom_5b41f63b()
	end

	if not __wf_atom_7e8ad928(noteCloseFX) then
		v18 = noteCloseFX:__wf_atom_5b41f63b()
	end

	local v19 = nil

	if __wf_atom_7e8ad928(v19) and not __wf_atom_7e8ad928(noteMovieRes) then
		v19 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v19:__wf_atom_f62a8704("InitializeNote", {
			v13,
			v14,
			v15,
			tostring(false),
			tostring(1),
			v16,
			v17,
			v18
		})
	end

	while not __wf_atom_7e8ad928(v19) do
		Sleep(0)
	end

	fn7(object, 50) -- inferred equivalent call
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end

function ReadOdeOrders(instance, p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v11 = StringSplit(
		"+",
		"Sinecure,+We have intel suggesting the key to a filthy Gruul stash lies hidden within the walls and orchards of Luminns. Find and destroy this abomination. Search every house, every crate and meager sack of grain. Leave no stone unturned, interrogate everyone, tear the place apart if you have to.+- Chief Gruulseeker Bob"
	)
	local v12 = v11[1] or ""
	local v13 = v11[2] or ""
	local v14 = v11[3] or ""
	local v15 = __wf_atom_7e8ad928(customNoteBacker) and "" or customNoteBacker:__wf_atom_5b41f63b()
	local v16 = __wf_atom_7e8ad928(noteOverlayImage) and "" or noteOverlayImage:__wf_atom_5b41f63b()
	local v17 = __wf_atom_7e8ad928(noteCloseFX) and "" or noteCloseFX:__wf_atom_5b41f63b()
	local v18 = nil

	if __wf_atom_7e8ad928(v18) and not __wf_atom_7e8ad928(noteMovieRes) then
		v18 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v18:__wf_atom_f62a8704("InitializeNote", {
			v12,
			v13,
			v14,
			tostring(false),
			tostring(1),
			v15,
			v16,
			v17
		})
	end

	while not __wf_atom_7e8ad928(v18) do
		Sleep(0)
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end