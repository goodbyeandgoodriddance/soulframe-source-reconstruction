local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module6 = require("SF.Scripts.Libs.TaleLib")
local v = nil
local v2 = nil

function Main(object)
	module3.WaitForAiDir()
	print("Dungeon entrance encounter started")
	v = object:__wf_atom_26b04ea9() or object
	v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()
	object:__wf_atom_8e6fec76(1)
	local dungeonEntranceWaypointNearPos = module5.GetDungeonEntranceWaypointNearPos(v:GetPosition())

	if __wf_atom_7e8ad928(dungeonEntranceWaypointNearPos) then
		print("Dungeon entrance encounter aborted, no entrance found!")
		return
	end

	local v3 = WeakResource("/EE/Types/Effects/PortForwarder")
	local pointInstances = module.FindPointInstances(v, v3)

	for _, pointInstance in ipairs(pointInstances) do
		pointInstance:FirePort("TriggerPort")
	end

	local __wf_atom_db682341 = dungeonEntranceWaypointNearPos:__wf_atom_db682341()
	local interiorProcLevelOverride2 = nil

	for i, v4 in ipairs(entranceTags) do
		if __wf_atom_db682341 ~= v4 then
			continue
		end

		interiorProcLevelOverride2 = matchingInteriorProcLevelOverrides[i]
		break
	end

	if __wf_atom_7e8ad928(interiorProcLevelOverride2) and not __wf_atom_7e8ad928(interiorProcLevelOverride) then
		interiorProcLevelOverride2 = interiorProcLevelOverride
	end

	if not __wf_atom_7e8ad928(interiorProcLevelOverride2) then
		module3.SetProcLevelForStreamingTunnel(
			__wf_atom_db682341,
			interiorProcLevelOverride2,
			module3.LEVEL_PRIORITY.DYNAMIC
		)
	end

	local enemyLevel = module.GetEnemyLevel(v, false)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("StreamingDungeonEntranceWp"),
		dungeonEntranceWaypointNearPos:GetPosition(),
		0,
		50
	)
	local __wf_atom_55116686 = __wf_atom_dd85e6db:__wf_atom_55116686()
	module2.AddSparrowDestination(
		__wf_atom_f738b4af,
		v,
		nil,
		module2.PRIORITY.HIGH,
		Range(0, v:__wf_atom_8f18e876() + 1)
	)

	if updateHud then
		module4.UpdateOrAddHudTask(object)
	end

	local v4 = tostring(__wf_atom_db682341)
	module5.SetActiveDungeonTaleInfo(v4, enemyLevel.maxValue, __wf_atom_55116686)
	local __wf_atom_e919fb8e = v:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		if __wf_atom_55116686 == Symbol("MT_SUBBOSS") then
			_G.DungeonEntranceInfo = _G.DungeonEntranceInfo or {}
			_G.DungeonEntranceInfo[v4] = _G.DungeonEntranceInfo[v4] or {}
			_G.DungeonEntranceInfo[v4].subbossTitle = __wf_atom_e919fb8e.subbossTaleTitle
		end

		_G.DungeonEntranceInfo[v4].ambientMissionTag = __wf_atom_55116686
	end

	object:__wf_atom_8e6fec76(2)
	print("Surface dungeon tale active")

	if #randomObjectTypes > 0 and math.random() <= objChance then
		local v5 = __wf_atom_5784a397(1, #randomObjectTypes)
		local randomObjectType = randomObjectTypes[v5]

		if not (__wf_atom_7e8ad928(randomObjectType) or __wf_atom_7e8ad928(objSpawnTags[v5])) then
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
				objSpawnTags[v5],
				object:GetPosition(),
				0,
				(math.max(object:__wf_atom_103377cc(), 30))
			)
			local pointInstances2 = module.FindPointInstances(v, nil, objSpawnTags[v5])
			local mergeTables = module3.MergeTables(__wf_atom_439c0d29, pointInstances2)

			if not __wf_atom_7e8ad928(mergeTables) and #mergeTables > 0 then
				local mergeTable = mergeTables[__wf_atom_5784a397(1, #mergeTables)]
				local position = mergeTable:GetPosition()
				local __wf_atom_dc309f8a = mergeTable:__wf_atom_dc309f8a()
				object:__wf_atom_d494454b((gRegion:CreateEntity(randomObjectType, position, __wf_atom_dc309f8a)))
			end
		end
	end

	local v5 = WeakResource("/SF/Types/Game/Encounters/CombatEncounterHint")
	local pointInstances2 = module.FindPointInstances(v, v5)

	if
		(__wf_atom_7e8ad928(pointInstances2) or not (#pointInstances2 > 0))
		and #randomEncounters > 0
		and __wf_atom_7e8ad928(v:__wf_atom_dd85e6db())
	then
		local randomEncounter = randomEncounters[__wf_atom_5784a397(1, #randomEncounters)]

		if not __wf_atom_7e8ad928(randomEncounter) then
			v2:AddEncounter(randomEncounter)
			v2:__wf_atom_c4c644af(object:GetPosition(), randomEncounter, v)
		end
	end

	local total = 0

	while not (__wf_atom_7e8ad928(object) or module.PrimedMissionShouldShutDown(object, v)) do
		if total >= 3 then
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for _, v6 in ipairs(__wf_atom_ef7900cf) do
				if not (v6:__wf_atom_1c8f7b2d(dungeonEntranceWaypointNearPos) <= 60) then
					continue
				end

				module4.UpdateVisibility(true)
				break
			end

			total = 0
		else
			total += __wf_atom_084b3e93()
		end

		Sleep(0)
	end

	print("Surface dungeon tale ending")

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8e6fec76(6)
	end

	module2.RemoveSparrowDestination(__wf_atom_f738b4af)
	module.RemoveAgents(object)
	module.RemoveObjects(object)
	local v6 = 5

	while
		not __wf_atom_7e8ad928(object)
		and v6 > 0
		and not (Game.__wf_atom_2b221245(false) or Game.__wf_atom_2b221245(true))
	do
		Sleep(0)
		v6 -= __wf_atom_084b3e93()
	end

	module4.RemoveHudGroup(object)
	print("Surface dungeon tale shutdown")
end

function OnPrimed(p)
	module.SetDynamicCombatAllowed(p, false)

	if #randomMessengerText == 0 or module6.HintIsReserved(p) then
		return
	end

	local v3 = randomMessengerText[__wf_atom_5784a397(1, #randomMessengerText)]
	module.AddMessengerIntel(p, messengerContainerHintType, v3, overrideMarker)
end