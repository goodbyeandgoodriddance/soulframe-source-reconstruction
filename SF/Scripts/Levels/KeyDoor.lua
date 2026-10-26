local module = require("SF.Scripts.Libs.EncounterLib")

function SetupKeyDoor(object)
	while __wf_atom_7e8ad928(_T.LootChestsSpawned) do
		Sleep(0)
	end

	Sleep(1)
	gRegion:__wf_atom_5b35a0c8(object:GetPosition(), Color(255, 255, 255), "Proc Locked Door", 1, 9999)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v = Symbol(tostring(doorNearSide:__wf_atom_5b41f63b()) .. "[KeyDoorNearSide]")
	local v2 = Symbol(tostring(doorNearSide:__wf_atom_5b41f63b()) .. "[KeyDoorFarSide]")
	local v3 = WeakResource("/SF/Types/Gameplay/LootChestSpawn")
	local v4 = WeakResource("/SF/Types/PickUps/LootContainers/LootChestBase")
	local v5 = Symbol("LockedKeyDoorHint")
	local position = doorNearSide:GetPosition()
	local __wf_atom_5633d172 = __wf_atom_7d789620:__wf_atom_5633d172(doorNearSide)
	local __wf_atom_5633d172_2 = __wf_atom_7d789620:__wf_atom_5633d172(doorFarSide)
	__wf_atom_7d789620:__wf_atom_fb33438e(v, __wf_atom_5633d172, 1, true, v5)
	__wf_atom_7d789620:__wf_atom_fb33438e(v2, __wf_atom_5633d172_2, 1, true, v5)
	local pointsOfInterest = module.GeneratePointsOfInterest(nil, nil, true, false)

	for i = #pointsOfInterest, 1, -1 do
		if not (__wf_atom_7d789620:__wf_atom_a499cdc0(__wf_atom_7d789620:__wf_atom_42d54916(pointsOfInterest[i]), v) == 0 or __wf_atom_7d789620:__wf_atom_57856d42(
			pointsOfInterest[i],
			position
		) > 100) then
			continue
		end

		table.remove(pointsOfInterest, i)
	end

	local v6 = __wf_atom_5784a397(1, #pointsOfInterest)
	gRegion:__wf_atom_5b35a0c8(pointsOfInterest[v6], Color(255, 255, 255), "[X] Pick Up Door Key", 1, 9999)
	gRegion:CreateEntity(keyPickupObjType, pointsOfInterest[v6], __wf_atom_80368bb1)
	local all = gRegion:FindAll(v3)

	for i = #all, 1, -1 do
		if __wf_atom_7d789620:__wf_atom_ab4fd7ad(all[i], v2) == 0 then
			table.remove(all, i)
		else
			local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(all[i]:GetPosition(), 1, { v4 })

			if not __wf_atom_7e8ad928(__wf_atom_a56d7910) and #__wf_atom_a56d7910 > 0 then
				table.remove(all, i)
			end
		end
	end

	local v7 = __wf_atom_5784a397(1, #all)
	gRegion:__wf_atom_5b35a0c8(all[v7]:GetPosition(), Color(255, 255, 255), "Door Loot", 1, 9999)
	gRegion:CreateEntity(lootChestType, all[v7]:GetPosition(), all[v7]:__wf_atom_dc309f8a())
end

function RunScriptTrigger(object)
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
		Sleep(0)
	end

	object:FirePort("Execute")
end