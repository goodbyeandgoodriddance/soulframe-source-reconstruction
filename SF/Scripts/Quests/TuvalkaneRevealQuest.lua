local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module7 = require("SF.Interface.SFUtilities")
local v = Symbol("DiscoverTuvalkaneAncestor")
local v2 = Symbol("GoToForge")
local v3 = Symbol("HelmitPickup")
local v4 = Symbol("ToTuvalkaneForgeWaypoint0")
local v5 = Symbol("ToTuvalkaneForgeWaypoint1")
local v6 = Symbol("DigSiteCamp")
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = Symbol("TuvalkaneHelm")
local v11 = WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/QuestAssets/TuvalkanesHelmetWeapon")
local v12 = WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/ProgressionQuests/AncestorTuvalkaneDiscoveryQuest")
local v13 = nil
local completetime = module6.COMPLETETIME

local function fn(mOwner2, p, p2)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v8 = tostring(module4.GetReadableTaskTag(mOwner2, p))

	if not module.IsInOverworld() then
		print("Quest: Not in overworld, early out at stage: " .. v8)
		return false
	end

	if gRegion:IsMaster() then
		print("Starting" .. v8)
	elseif p2 then
		print("Starting" .. v8 .. " (client)")
	else
		return false
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = module.WaitForAiDir()
	end

	module4.TrackQuest(mOwner)
	module6.UpdateOrAddHudTask(mOwner, p)
	return true
end

local function fn2()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v6)
	module2.SetEncounterChillout(__wf_atom_0a6a5887, true)
	module2.SetEncounterHeaviesBlocked(__wf_atom_0a6a5887, true)
	module2.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
	__wf_atom_0a6a5887:__wf_atom_252fae6e(5)
end

function StartTuvalkaneDiscoveryQuest(_, object)
	if not (gRegion:IsMaster() and module.IsInOverworld()) then
		return
	end

	module5.CloseTransmissions()
	local v14 = Resource(v12)

	if not __wf_atom_7e8ad928(v14) then
		_T.StartedFromHelm = isStartedFromHelm

		if module4.QuestIsActive(v12) then
			return
		end

		while __wf_atom_7e8ad928(object) and object:IsKilled() do
			Sleep(0)
		end

		module4.StartQuest(v14)
	end
end

function GoToDigSite(p)
	if not (module.IsInOverworld() and fn(mOwner, p, false)) then
		return
	end

	v13 = gRegion:__wf_atom_0a6a5887(Symbol("EnableTuvalkaneQuestAssets"))

	if not __wf_atom_7e8ad928(v13) then
		v13:FirePort("TriggerPort")
	end

	if _T.StartedFromHelm == true then
		module6.CompleteHudTask(mOwner, nil, p, module6.COMPLETETIME)
		Sleep(module6.COMPLETETIME)
		module4.CompleteTaskWithID(mOwner, p)
	else
		fn2()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HelmitPickup"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("HelmitPickup"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and gRegion:IsMaster() then
			module6.CompleteHudTask(mOwner, nil, p, module6.COMPLETETIME)
			Sleep(module6.COMPLETETIME)
			module4.CompleteTaskWithID(mOwner, p)
		else
			local __wf_atom_a3d1d403 = __wf_atom_0a6a5887_2:__wf_atom_a3d1d403(true)
			local v14 = false
			v9 = module4.CreateAreaMarker(__wf_atom_0a6a5887, 50, __wf_atom_28d5d4aa, mOwner, p)
			module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)

			while not __wf_atom_7e8ad928(__wf_atom_a3d1d403) do
				if not module.IsInOverworld() then
					return
				end

				if
					not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
					and not __wf_atom_c4f78a8f:IsKilled()
					and __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition()) <= 8
					and v14 == false
				then
					module6.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/PickUpHelm")
					v14 = true
				end

				Sleep(0)
			end

			if __wf_atom_7e8ad928(__wf_atom_a3d1d403) and gRegion:IsMaster() and not module.IsStreamingLevel() then
				module6.CompleteHudTask(mOwner, nil, p, module6.COMPLETETIME)
				Sleep(module6.COMPLETETIME)
				module4.CompleteTaskWithID(mOwner, p)
			end
		end
	end
end

local function fn3(p, p2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v6)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(p2)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		v7:AddEncounter(p)
		v7:__wf_atom_c4c644af(__wf_atom_0a6a5887_2:GetPosition(), p, __wf_atom_0a6a5887)
	end
end

function GoToForge(taskId)
	if not (module.IsInOverworld() and fn(mOwner, taskId, false)) then
		return
	end

	fn2()
	v13 = gRegion:__wf_atom_0a6a5887(Symbol("EnableTuvalkaneQuestAssets"))

	if not __wf_atom_7e8ad928(v13) then
		v13:FirePort("TriggerPort")
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_58442306()
		module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, taskId)
		module6.UpdateOrAddHudTask(mOwner, nil, "/SF/Language/Quests/PickUpHelm")
		module6.RemoveHudTask(mOwner, nil, taskId)
	end

	_T.TuvHelmQuestTask = { owner = mOwner, taskId = taskId }
	local v14 = false

	while not v14 do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v15 in pairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v15) then
				continue
			end

			local __wf_atom_48e698f2 = v15:__wf_atom_48e698f2()

			if __wf_atom_7e8ad928(__wf_atom_48e698f2) or not __wf_atom_48e698f2:IsA(__wf_atom_4d316097) then
				continue
			end

			local __wf_atom_35a10d3c = __wf_atom_48e698f2:__wf_atom_35a10d3c(0)

			if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or __wf_atom_35a10d3c ~= v11 then
				continue
			end

			v14 = true
			break
		end

		if __wf_atom_7e8ad928(v13) then
			return
		else
			Sleep(0.1)
		end
	end

	module6.CompleteHudTask(mOwner, nil, nil, module6.COMPLETETIME)
	module3.RemoveSparrowDestination(__wf_atom_0a6a5887)
	Sleep(completetime)
	module6.UpdateOrAddHudTask(mOwner, taskId, "/SF/Language/Quests/TuvalkaneDiscoveryGoToForge")
	local areaMarkerAtPos = module4.CreateAreaMarkerAtPos(
		gRegion:__wf_atom_0a6a5887(v):GetPosition(),
		50,
		__wf_atom_28d5d4aa,
		mOwner,
		taskId
	)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("TuvalkaneWhispers"))

	for _, v15 in pairs(__wf_atom_2226b35c) do
		if not __wf_atom_7e8ad928(v15) then
			v15:Enable()
		end
	end

	Sleep(3)
	fn3(firstEncounterType, v4)
	Sleep(10)
	fn3(secondEncounterType, v5)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Enable()
	end

	module.TaggedFirePorts(Symbol("TuvHelmTutorialTrigger"), "Enable")

	while not _T.TuvQuestReachedForge do
		Sleep(0.5)
	end

	_T.TuvHelmQuestTask = nil
	_T.TuvQuestReachedForge = nil

	if not __wf_atom_7e8ad928(areaMarkerAtPos) then
		module4.DestroyAreaMarker(areaMarkerAtPos)
	end

	module6.RemoveHudTask(mOwner, nil, taskId)
	module4.CompleteTaskWithID(mOwner, taskId)
end

function OnInteractWithForge(object, _)
	if gRegion:IsMaster() then
		_T.TuvQuestReachedForge = true
		object:Disable()
	end
end

function CheckToEnableHelmet(instance)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.TaggedFirePorts(Symbol("TuvalkaneHelmIdleSeq"), "Enable")
	module.TaggedFirePorts(Symbol("DigSiteHelmBarkTrigger"), "Enable")
	local v14 = module4.QuestIsActive(v12)
		and not (module4.TaggedTaskIsActive(Resource(v12), v2) or module4.TaggedTaskIsActive(
			Resource(v12),
			Symbol("GoToDigSite")
		))

	if __wf_atom_7e8ad928(v7) then
		v7 = module.WaitForAiDir()
	end

	local __wf_atom_35a10d3c = module7.GetEnvoyInventoryControl():__wf_atom_35a10d3c(0)
	local v15 = not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c == v11

	if module4.HasCompletedQuest(v12) or v14 or v15 then
		module.TaggedFirePorts(Symbol("TuvalkaneHelmIdleSeq"), "Disable")
		module.TaggedFirePorts(Symbol("DigSiteHelmBarkTrigger"), "Disable")
		instance:Destroy()
	end

	if not (__wf_atom_7e8ad928(hintTag) or __wf_atom_7e8ad928(missionTag)) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(hintTag)

		if not gRegion:IsMaster() then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
			Sleep(0)
			v7:PrimeMissionOnHint(missionTag, __wf_atom_0a6a5887)
		end
	end
end

function CheckHowQuestStarted(p)
	if _T.StartedFromHelm == true then
		module4.CompleteTaskWithID(mOwner, p)
	end
end

function HideHelmetDeco()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v10)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(false)
	end
end

function SwapHelmetAssets()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v10)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_5106368a(v11)
	module.UnequipWeapon(__wf_atom_c4f78a8f, true)
end