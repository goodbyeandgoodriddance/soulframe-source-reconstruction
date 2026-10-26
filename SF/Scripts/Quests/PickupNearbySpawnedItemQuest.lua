local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("EE.Interface.Utilities")
local v = nil

local function fn(spawnObjectType)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local position = __wf_atom_c4f78a8f:GetPosition()
	local ___wf_atom_80368bb1 = __wf_atom_80368bb1
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_7d789620 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("ResShrine"), position)
	local randomPointInRangeOnNav, v2

	if __wf_atom_7e8ad928(nearestTagged) then
		randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
			position,
			minDistance,
			maxDistance,
			sameNavIsland,
			heightAboveNav
		)
		v2 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	else
		randomPointInRangeOnNav = nearestTagged:GetPosition() + __wf_atom_edfe0d73(
			nearestTagged:__wf_atom_acb19668(),
			nearestTagged:__wf_atom_a06d543c()
		)
		v2 = nearestTagged:__wf_atom_dc309f8a()
		v2.heading += 90

		if not __wf_atom_2202ffb6:__wf_atom_3c37bceb(randomPointInRangeOnNav, 2) then
			randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
				randomPointInRangeOnNav,
				minDistance,
				maxDistance,
				sameNavIsland,
				heightAboveNav
			)
		end
	end

	local groundAlignedSpawnPosRot, v3 = module4.GetGroundAlignedSpawnPosRot(
		spawnObjectType,
		randomPointInRangeOnNav,
		v2
	)

	if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
		return groundAlignedSpawnPosRot, v3
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("NotePickup"), groundAlignedSpawnPosRot, 0, 10)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) or not __wf_atom_f738b4af:__wf_atom_93b324ab() then
		return groundAlignedSpawnPosRot, v3
	end

	if not takesPriority then
		return
	end

	v = __wf_atom_f738b4af
	return groundAlignedSpawnPosRot, v3
end

function GetSparrowId(object, object2)
	if not __wf_atom_7e8ad928(object) then
		return object:GetName() .. "PickupSpawnedItem"
	end

	if __wf_atom_7e8ad928(object2) then
		return "PickupSpawnedItem"
	end

	return object2:GetName() .. "PickupSpawnedItem"
end

function SpawnedAndPickedUpItem(p)
	print("SpawnedAndPickedUpItem started")
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.WaitForAiDir()

	if not module.IsInOverworld() then
		print("SpawnedAndPickedUpItem: Not in overworld, early out")
		return
	end

	local spawnObjectType2

	if __wf_atom_7e8ad928(spawnObjectTableType) then
		spawnObjectType2 = spawnObjectType
	else
		spawnObjectType2 = spawnObjectTableType
	end

	local v2, v3 = fn(spawnObjectType2)

	while __wf_atom_7e8ad928(v2) do
		Sleep(5)
		v2, v3 = fn(spawnObjectType2)
	end

	if takesPriority and not __wf_atom_7e8ad928(v) then
		v:FirePort("Disable")
	end

	local v4

	if not __wf_atom_7e8ad928(spawnObjectTableType) then
		v4 = gRegion:__wf_atom_e2db08ce(spawnObjectTableType, v2, 10)

		if __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(spawnObjectTableDefaultMesh) then
			v4 = gRegion:CreateEntity(spawnObjectTableType, v2, v3, nil, nil, module6.Ternary(gRegion:IsMaster(), 3, 4))
		else
			v4:__wf_atom_45cf0e1a(spawnObjectTableDefaultMesh, false, false)
		end
	end

	local entity = gRegion:CreateEntity(
		spawnObjectType,
		v2 + spawnOffset,
		v3,
		nil,
		nil,
		module6.Ternary(gRegion:IsMaster(), 3, 4)
	)

	if showOnSparrow then
		module5.AddQuestDestination(entity, mOwner, p)
	end

	if showOnHudTracker then
		module2.UpdateOrAddHudTask(mOwner, p)
		module3.TrackQuest(mOwner)
	end

	local __wf_atom_93b324ab = entity:__wf_atom_93b324ab()
	local v5 = false

	while __wf_atom_93b324ab do
		Sleep(0.5)

		if __wf_atom_7e8ad928(entity) then
			print("SpawnedAndPickedUpItem: We streamed out of overworld?")
			local _ = v5 or not showOnHudTracker
			return false
		else
			__wf_atom_93b324ab = entity:__wf_atom_93b324ab()
		end
	end

	if showOnHudTracker then
		module2.CompleteHudTask(mOwner, nil, p)
	end

	if showOnSparrow and not __wf_atom_7e8ad928(entity) then
		module5.RemoveSparrowDestination(entity)
	end

	if not __wf_atom_7e8ad928(v4) and not __wf_atom_7e8ad928(spawnObjectTableTakenMesh) and __wf_atom_7e8ad928(v) then
		v4:__wf_atom_45cf0e1a(spawnObjectTableTakenMesh, false, false)
	end

	Sleep(4)

	if showOnHudTracker then
		module2.RemoveHudGroup(mOwner)
	end

	entity:Destroy()

	if not __wf_atom_7e8ad928(v) then
		v:FirePort("Enable")
	end

	print("SpawnedAndPickedUpItem completed")
	module3.CompleteTaskWithID(mOwner, p)
end

function CheckForPrerequists()
	local count = 0

	for _, v2 in pairs(questPrerequsits) do
		if module3.HasCompletedQuest(v2) then
			count += 1
		end
	end

	return #questPrerequsits <= count
end

function SpawnAncestorHint(_, _)
	print("SpawnAncestorHint started")
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.WaitForAiDir()

	if not module.IsInOverworld() then
		print("SpawnedAndPickedUpItem: Not in overworld, early out")
		return
	end

	Sleep(20)

	if module3.QuestIsActive(questType) or module3.HasCompletedQuest(questType) or CheckForPrerequists() == false then
		return
	end

	local spawnObjectType2

	if __wf_atom_7e8ad928(spawnObjectTableType) then
		spawnObjectType2 = spawnObjectType
	else
		spawnObjectType2 = spawnObjectTableType
	end

	local v2, v3 = fn(spawnObjectType2)
	local v4 = nil

	while __wf_atom_7e8ad928(v2) do
		Sleep(5)
		v2, v3 = fn(spawnObjectType2)
	end

	if takesPriority and not __wf_atom_7e8ad928(v) then
		v:FirePort("Disable")
	end

	local v5

	if not __wf_atom_7e8ad928(spawnObjectTableType) then
		v5 = gRegion:__wf_atom_e2db08ce(spawnObjectTableType, v2, 10)

		if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(spawnObjectTableDefaultMesh) then
			v5 = gRegion:CreateEntity(spawnObjectTableType, v2, v3, nil, nil, module6.Ternary(gRegion:IsMaster(), 3, 4))
		else
			v5:__wf_atom_45cf0e1a(spawnObjectTableDefaultMesh, false, false)
		end

		v4 = v5:Attach(markerType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local entity = gRegion:CreateEntity(
		spawnObjectType,
		v2 + spawnOffset,
		v3,
		nil,
		nil,
		module6.Ternary(gRegion:IsMaster(), 3, 4)
	)

	if showOnSparrow then
		local v6 = GetSparrowId(questType, spawnObjectType)
		module5.AddSparrowDestination(
			entity,
			nil,
			v6,
			module5.PRIORITY.HIGH,
			nil,
			nil,
			nil,
			v4:__wf_atom_e32e2012(),
			true
		)
	end

	if notifyPlayer and not (__wf_atom_7e8ad928(_T.ShowImpactMessage) or module3.IsAnyQuestTracked()) then
		_T.ShowImpactMessage("/SF/Language/Objectives/AncestorNoteNotification", notificationTime)
	end

	local __wf_atom_93b324ab = entity:__wf_atom_93b324ab()
	local v6 = false

	while __wf_atom_93b324ab do
		Sleep(0.5)

		if __wf_atom_7e8ad928(entity) then
			print("SpawnedAndPickedUpItem: We streamed out of overworld?")
			local _showOnHudTracker = showOnHudTracker
			return false
		else
			if not v6 and module3.QuestIsActive(questType) or module3.HasCompletedQuest(questType) then
				if showOnSparrow and not __wf_atom_7e8ad928(entity) then
					module5.RemoveSparrowDestination(entity)
				end

				if not __wf_atom_7e8ad928(v4) then
					v4:Destroy()
				end

				v6 = true
			end

			__wf_atom_93b324ab = entity:__wf_atom_93b324ab()
		end
	end

	if not v6 and showOnSparrow and not __wf_atom_7e8ad928(entity) then
		module5.RemoveSparrowDestination(entity)
	end

	if not __wf_atom_7e8ad928(v5) and not __wf_atom_7e8ad928(spawnObjectTableTakenMesh) and __wf_atom_7e8ad928(v) then
		v5:__wf_atom_45cf0e1a(spawnObjectTableTakenMesh, false, false)
	end

	Sleep(4)

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	if not __wf_atom_7e8ad928(v) then
		v:FirePort("Enable")
	end

	if not (v6 or __wf_atom_7e8ad928(v4)) then
		v4:Destroy()
	end

	print("SpawnedAndPickedUpItem completed")

	if gRegion:IsMaster() and module.IsInOverworld() and not __wf_atom_7e8ad928(Resource(questType)) then
		module3.StartQuest(Resource(questType))
	end
end