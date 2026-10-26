local v = WeakResource("/SF/Types/Game/Encounters/Locations/DungeonEntranceHintUndercity")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.DungeonLocationInfo")

function InitDungeonEntrance(initScript)
	if not module.IsInOverworld() then
		print("Not usable in dungeon proc levels, place in the overworld near a dungeon entrance")
		return
	end

	local position = initScript:GetPosition()
	local v2 = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v2, position, 80)

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		print("DungeonEntranceInit early out, no entrance found within 80m!")
		return
	end

	local __wf_atom_db682341 = __wf_atom_e2db08ce:__wf_atom_db682341()
	local entranceId = tostring(__wf_atom_db682341)

	if not __wf_atom_7e8ad928(overrideProcLevel) then
		module.SetProcLevelForStreamingTunnel(__wf_atom_db682341, overrideProcLevel, module.LEVEL_PRIORITY.WORLD)
	end

	if #procLevelGenTags > 0 then
		local nearestStreamTrigger = module.GetNearestStreamTrigger(__wf_atom_e2db08ce:GetPosition())

		if not __wf_atom_7e8ad928(nearestStreamTrigger) then
			for _, v3 in ipairs(procLevelGenTags) do
				if v3 ~= EMPTY_SYMBOL then
					nearestStreamTrigger:__wf_atom_11c734e9(v3)
				end
			end
		end
	end

	module2.SetDungeonEntranceSubboss(tostring(__wf_atom_db682341), subBossAgentType, subBossName)

	if not __wf_atom_7e8ad928(subBossAgentType) and includeSubbossInTales then
		local all = gRegion:FindAll(v, position, 0, 100)
		local nearestObject = module.NearestObject(position, all)

		if not __wf_atom_7e8ad928(nearestObject) then
			local __wf_atom_e919fb8e = nearestObject:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.subbossCanSpawnInTales = true
			__wf_atom_e919fb8e.dungeonEntranceId = tostring(__wf_atom_db682341)
			__wf_atom_e919fb8e.subBossName = subBossName
			__wf_atom_e919fb8e.subbossTaleTitle = subbossTaleTitle
		end
	end

	local __wf_atom_e919fb8e = initScript:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.entranceId = entranceId
	initScript:__wf_atom_b811702e(Symbol("DungeonInit-" .. entranceId))
	_G.DungeonEntranceInfo[entranceId].initScript = initScript
	_G.DungeonEntranceInfo[entranceId].entranceWp = __wf_atom_e2db08ce
	_G.DungeonEntranceInfo[entranceId].procLevel = overrideProcLevel
end

function RunScriptTrigger(object)
	module.WaitForLevel()
	module.WaitForAiDir()

	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Execute")
	end
end