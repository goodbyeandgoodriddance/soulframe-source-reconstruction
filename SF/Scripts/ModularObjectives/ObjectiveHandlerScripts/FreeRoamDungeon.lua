local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module5 = require("SF.Scripts.Libs.QuestLib")
local v = Symbol("DungeonDeedId")
local v2 = Symbol("DungeonDeedStatus")
local v3 = {}
local v4 = {}

local function fn(instance, list, object)
	local v5

	if instance:IsA(__wf_atom_af605003) then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		__wf_atom_7d789620:AddEncounter(instance)
		v5 = __wf_atom_7d789620:__wf_atom_c4c644af(object:GetPosition() + Vector(1, 0, 1), instance, object)

		if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(list) then
			return v5
		end

		for _, v6 in ipairs(list) do
			v5:__wf_atom_ed6d3248(v6)
		end

		return v5
	else
		v5 = gRegion:CreateEntity(instance, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		v5:FirePort("Execute")
		object:__wf_atom_d494454b(v5)
		return v5
	end
end

function MarkExit(p)
	local v5 = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))[1]

	if p then
		module2.AddSparrowDestination(v5, nil, nil, module2.PRIORITY.EXIT)
		print("Marked exit shrine")
	else
		module2.RemoveSparrowDestination(v5)
		print("Unmarked exit shrine")
	end
end

function MarkStreamTunnel(p)
	local v5 = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Spawn"))[1]

	if p then
		module2.AddSparrowDestination(v5, nil, nil, module2.PRIORITY.EXIT, Range(0, 100))
		print("Marked streaming tunnel")
	else
		module2.RemoveSparrowDestination(v5)
		print("Unmarked streaming tunnel")
	end
end

function FreeRoamDungeon(object)
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	print("Starting on " .. __wf_atom_5b41f63b)
	module.WaitForLevel()
	module.WaitForAiDir()
	print("Started, running setup...")
	object:__wf_atom_8e6fec76(1)
	local activeQuests = module5.GetActiveQuests()
	local currentLocationQuest = module4.GetCurrentLocationQuest()
	local v5 = not __wf_atom_7e8ad928(activeQuests)
		and #activeQuests > 0
		and not __wf_atom_7e8ad928(currentLocationQuest)
	local v6

	if v5 then
		v6 = false
	else
		for _, v7 in ipairs(eventsToAlwaysTrigger) do
			fn(v7, nil, object)
			table.insert(v4, v7)
			print("Created event")
		end

		if not __wf_atom_7e8ad928(dungeonDeedNpc) and module4.GetCurrentLocation() == "UndercityPortalSproutCave" then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DungeonDeedNpcSpawn"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and module.HasFragment(deedNpcRequiredFragment) then
				gRegion:CreateEntity(
					dungeonDeedNpc,
					__wf_atom_0a6a5887:GetPosition(),
					__wf_atom_0a6a5887:__wf_atom_dc309f8a()
				)
				print("Spawned dungeon deed npc")
			end
		end

		MarkExit(true)
		v6 = true
	end

	object:__wf_atom_8e6fec76(2)
	print("Setup completed")
	local total = 0

	while not Game.__wf_atom_2b221245(false) do
		if __wf_atom_7e8ad928(object) then
			print("Null encounterhint")
			break
		end

		local count = 0

		for i = #v3, 1, -1 do
			if __wf_atom_7e8ad928(v3[i]) then
				table.remove(v3, i)
			elseif v3[i]:IsA(__wf_atom_f806fd7a) then
				if v3[i]:__wf_atom_4026dfb5() >= 3 then
					count += 1
				elseif
					(v3[i]:__wf_atom_4026dfb5() == 0 or v3[i] == object)
					and v3[i]:__wf_atom_5b6b447d() == EMPTY_SYMBOL
				then
					table.remove(v3, i)
				end
			end
		end

		local objsInQueue = module3.GetObjsInQueue()

		if #objsInQueue > 0 then
			MarkExit(false)
			MarkStreamTunnel(false)
			v6 = false
		end

		for i = #objsInQueue, 1, -1 do
			if not (__wf_atom_7e8ad928(objsInQueue[i]) or __wf_atom_7e8ad928(objsInQueue[i].enc)) then
				if objsInQueue[i].enc:IsA(__wf_atom_f806fd7a) then
					table.insert(v3, objsInQueue[i].enc)
					print("Tracking existing encounterhint")
				else
					local v7 = fn(objsInQueue[i].enc, objsInQueue[i].tags, object)
					table.insert(v3, v7)
					print("Created newly added encounter")
				end
			end

			table.remove(objsInQueue, i)
		end

		if not (v5 or v6) and (#v3 > 0 and #v3 <= count or #v3 == 0) then
			MarkExit(true)
			MarkStreamTunnel(true)
			v6 = true
		end

		total += __wf_atom_03df4e1d()
		Sleep(0)
	end

	for i = 1, #v3 do
		if __wf_atom_7e8ad928(v3[i]) or not v3[i]:IsA(__wf_atom_f806fd7a) then
			continue
		end

		v3[i]:__wf_atom_8e6fec76(6)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8e6fec76(6)
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_0ab0a47f(v)
		gGameRules:__wf_atom_0ab0a47f(v2)
	end

	_T.DeedNpcEncounterTag = nil
	print("Shutdown")
	MarkExit(false)
	MarkStreamTunnel(false)
	module3.RemoveObjects(object)
end