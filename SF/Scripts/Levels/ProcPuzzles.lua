local v = Symbol("Objective")
local v2 = Symbol("LightMirrorMover")
local v3 = { INITIALIZING = 0, IDLE = 1, ACTIVATED = 2, COMPLETED = 3 }
local v4 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.DungeonLocationInfo")

local function fn(_) end

local function fn2(p, list, value)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(sProcPuzzleLootDoorShowTag)
	local flag = false
	local v5 = value or 100

	if __wf_atom_7e8ad928(p) then
		flag = true
	else
		__wf_atom_2226b35c = module.FilterObjectsInLayerIndex(p, __wf_atom_2226b35c)
	end

	local v6 = Symbol("Dead-End")
	local v7 = Symbol("VineDoorOppositeSide")
	local result = {}

	for _, door in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v7, door:GetPosition(), 0, 10)
		local v8 = nil
		local v9 = nil

		if flag then
			p = module.GetLayerIndex(door)
		end

		if not __wf_atom_7e8ad928(p) then
			for _, v10 in ipairs(__wf_atom_439c0d29) do
				local __wf_atom_e800787c = v10:__wf_atom_e800787c()

				if __wf_atom_7e8ad928(__wf_atom_e800787c) then
					continue
				end

				local layerIndex = __wf_atom_e800787c:GetLayerIndex()

				if p < layerIndex and __wf_atom_e800787c:__wf_atom_db682341() == v6 then
					v8 = v10
					v9 = layerIndex
					break
				elseif layerIndex == p then
					local v11 = Vector()
					local v12 = v10:GetPosition() + __wf_atom_9341614d(Vector(0, 0, -1), v10:__wf_atom_dc309f8a()) * 100
					gRegion:Raycast(v10:GetPosition(), v12, nil, nil, v11, true)

					if v11 ~= __wf_atom_28d5d4aa and not __wf_atom_7e8ad928(v11) then
						local v13 = v4:__wf_atom_3c9cb048(v11) + 1

						if p < v13 then
							v8 = v10
							v9 = v13
							break
						end
					end
				end
			end
		end

		if __wf_atom_7e8ad928(v9) then
			continue
		end

		for i = #list, 1, -1 do
			local spawn = list[i]
			local __wf_atom_e800787c = spawn:__wf_atom_e800787c()

			if
				__wf_atom_7e8ad928(__wf_atom_e800787c)
				or __wf_atom_e800787c:__wf_atom_db682341() ~= v6
				or __wf_atom_e800787c:GetLayerIndex() ~= v9
			then
				continue
			end

			local __wf_atom_57856d42 = v4:__wf_atom_57856d42(v8:GetPosition(), spawn:GetPosition())

			if not (__wf_atom_57856d42 ~= 0 and __wf_atom_57856d42 <= v5) then
				continue
			end

			local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(sProcPuzzleTargetShowTag, door:GetPosition(), 0, 50)
			local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(p, __wf_atom_439c0d29_2)

			if not (#filterObjectsInLayerIndex > 0) then
				continue
			end

			local nearestObject = module.NearestObject(door:GetPosition(), filterObjectsInLayerIndex)

			if __wf_atom_7e8ad928(nearestObject) then
				continue
			end

			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
				sProcPuzzleSequence,
				nearestObject:GetPosition(),
				0,
				10
			)

			if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				table.insert(result, {
					spawn = spawn,
					door = door,
					statue = nearestObject,
					scriptTrigger = __wf_atom_f738b4af
				})
			end
		end
	end

	return result
end

function SetUpProcPuzzles(p)
	module.WaitForLevel()
	v4 = module.WaitForAiDir()
	_T.GetSpawnDoorPairs = fn2
	Sleep(5)
	local currentLocationQuest, v5 = module2.GetCurrentLocationQuest()

	if not (__wf_atom_7e8ad928(currentLocationQuest) or __wf_atom_7e8ad928(v5)) then
		print("Puzzle setup script early out due to active quest in this dungeon")
		return
	end

	local currentLocation = module2.GetCurrentLocation()
	local activeDungeonTaleInfo, _, _ = module2.GetActiveDungeonTaleInfo()
	local v6 = false
	local v7 = nil

	if not __wf_atom_7e8ad928(activeDungeonTaleInfo) and currentLocation == activeDungeonTaleInfo then
		local v8 = Symbol("MT_RETRIEVE_DUNGEON")
		local all = gRegion:FindAll(__wf_atom_f806fd7a)
		local v9 = 20

		while __wf_atom_7e8ad928(v7) and not v6 and v9 > 0 do
			for _, v10 in ipairs(all) do
				if __wf_atom_7e8ad928(v10) then
					continue
				end

				local __wf_atom_5b6b447d = v10:__wf_atom_5b6b447d()

				if __wf_atom_5b6b447d == v8 then
					print("Puzzle setup script detected an active hint")
					return
				end

				if __wf_atom_5b6b447d == EMPTY_SYMBOL then
					continue
				end

				print("A tale is active in this dungeon, but doesn't involve a puzzle")
				v6 = true
			end

			v9 -= __wf_atom_084b3e93()
			Sleep(0.2)
		end
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(sProcPuzzleLootSpawnTag)

	if #gRegion:__wf_atom_2226b35c(sProcPuzzleStartTag) > 0 then
		print("Found portal puzzles from the previous session, due to host migration. No new portal puzzles were created.")
		return
	end

	local v8 = fn2(nil, (gRegion:__wf_atom_2226b35c(sProcCustomDeadEndTag)))

	if #v8 == 0 then
		print("No portal puzzle targets where found on this tile. No proc puzzles were created.")
		return
	end

	local v9 = math.random(0, 0.99)
	local randomizeTableOrder = module.RandomizeTableOrder(v8)

	if v9 < 0.75 then
		for i = 1, #randomizeTableOrder do
			if randomizeTableOrder[i].statue:__wf_atom_e800787c():__wf_atom_db682341() == v then
				v9 = i
				break
			elseif i == #randomizeTableOrder then
				v9 = 0
			end
		end
	end

	if v9 < 1 then
		v9 = __wf_atom_5784a397(1, #randomizeTableOrder)
	end

	local spawn = randomizeTableOrder[v9].spawn
	local statue = randomizeTableOrder[v9].statue
	local scriptTrigger = randomizeTableOrder[v9].scriptTrigger
	fn(randomizeTableOrder[v9])

	if __wf_atom_7e8ad928(statue) or __wf_atom_7e8ad928(spawn) then
		print("Proc puzzle can not match loot dead ends with puzzle in the adjacent tile. No proc puzzles were created.")
		return
	end

	local layerIndex = module.GetLayerIndex(spawn)
	local door = randomizeTableOrder[v9].door
	local v10 = statue:GetPosition() + statue:__wf_atom_a06d543c() * 3
	gRegion:CreateEntity(puzzleStartWaypointType, v10, __wf_atom_fa8d0177(v10, statue:GetPosition()))
	statue:FirePort("TriggerPort")
	door:FirePort("TriggerPort")
	local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_2226b35c)

	for _, v11 in ipairs(filterObjectsInLayerIndex) do
		if not __wf_atom_7e8ad928(v11) then
			gRegion:CreateEntity(procPuzzleLootType, v11:GetPosition(), v11:__wf_atom_dc309f8a(), p)
		end
	end

	if not __wf_atom_7e8ad928(scriptTrigger) then
		scriptTrigger:FirePort("Execute")
	end
end

function ActivatePuzzle(_, object)
	local position = object:GetPosition()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(sProcPuzzleSequence, position, 0, 10)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		if not __wf_atom_f738b4af:IsRunning() then
			__wf_atom_f738b4af:FirePort("Execute")
		end

		__wf_atom_f738b4af:SetState(scriptStateNumber)
	end
end

function SpawnMirrorPuzzleSequence(object)
	for _, v5 in ipairs(sequenceMirrors) do
		if __wf_atom_7e8ad928(v5) or v5:__wf_atom_db682341() ~= v2 then
			continue
		end

		local v6

		if v5:__wf_atom_1bb5b1ff() == __wf_atom_6a50bd07 then
			v6 = v5
		else
			v6 = v5:__wf_atom_bb3e7833(__wf_atom_6a50bd07)
		end

		if not __wf_atom_7e8ad928(v6) then
			v6:FirePort("Enable")
		end

		v5:FirePort("Show")
	end

	if not __wf_atom_7e8ad928(sequenceBeam) then
		sequenceBeam:Enable()
	end

	for _, v5 in ipairs(sequenceDecorations) do
		v5:FirePort("Show")
	end

	for _, v5 in ipairs(sequenceStartMoverKeys) do
		v5:FirePort("MoveTo")
	end

	while object:GetState() ~= v3.COMPLETED do
		Sleep(1)
	end

	for _, v5 in ipairs(sequenceMirrors) do
		if __wf_atom_7e8ad928(v5) or v5:__wf_atom_db682341() ~= v2 then
			continue
		end

		local v6

		if v5:__wf_atom_1bb5b1ff() == __wf_atom_6a50bd07 then
			v6 = v5
		else
			v6 = v5:__wf_atom_bb3e7833(__wf_atom_6a50bd07)
		end

		if not __wf_atom_7e8ad928(v6) and v6:__wf_atom_b81a6e66() then
			v6:FirePort("Disable")
		end

		v5:FirePort("Show")
	end
end

function DebugNearestPuzzle(object)
	if not object:IsEnabled() then
		return
	end

	print("Alert! Debug puzzle trigger has been accidentally submitted. It can cause troubles if not removed from the level.")
	local position = object:GetPosition()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(sProcPuzzleTargetShowTag, position, 0, 5)
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(sProcPuzzleSequence, position, 0, 5)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:FirePort("TriggerPort")
	end

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af2) then
		__wf_atom_f738b4af2:FirePort("Execute")
	end
end