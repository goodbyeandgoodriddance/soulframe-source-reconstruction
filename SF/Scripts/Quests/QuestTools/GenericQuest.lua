local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("SF.Scripts.Libs.TaleLib")
local module7 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module8 = require("SF.Scripts.NightFoldLib")
local module9 = require("EE.Interface.Utilities")
local module10 = require("SF.Scripts.Libs.TransmissionSet")
local v = false
local v2 = false
local v3 = WeakResource("/SF/Interface/DiegeticNote.swf")
local flag = false
local v4 = false
local v5 = nil
local v6 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v7 = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
local v8 = Resource("/Lotus/Types/Lore/PrimaryCodexManifest")
local v9 = Symbol("PauseAgents")
local v10 = Resource("/SF/Interface/HUD/Notification.swf")
local v11 = false
local v12 = Type("/SF/Types/Gameplay/TeleportPlayersHereInstantlyScriptTrigger")
local completetime = module5.COMPLETETIME
local flag2 = false
local v13 = nil
local v14 = Type("/SF/Types/Quests/QuestTools/GoToLocationTaskTrigger")
local v15 = nil
local v16 = Type("/SF/Types/Game/MarkerInfos/EncounterMarkerInfo")

local function fn(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(p) or not (p and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(object) <= 50) then
		object:Attach(v12, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn2(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and (__wf_atom_7be51ede:__wf_atom_4417a5d4() or allowMultiplayer) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.interactionCompleted = true
	end
end

local function fn3(object)
	object:Disable()
	v2 = true
end

local function fn4(object)
	if object:__wf_atom_7be51ede():__wf_atom_4417a5d4() or allowMultiplayer then
		object:Disable()
		v = true
	end
end

local function fn5(object)
	if v4 and not module6.IsMissionEncounter(object) then
		return
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 3 or __wf_atom_4026dfb5 == 4 then
		flag = true
	end
end

local function fn6(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetBlackboardBool(Symbol("ForceNoPatrolling"), true)
	end
end

local function fn7()
	if not __wf_atom_7e8ad928(v5) then
		local __wf_atom_be637430 = v5:__wf_atom_be637430()

		for _, v17 in ipairs(__wf_atom_be637430) do
			v17:__wf_atom_f54283ea()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local nearestObject = module2.NearestObject(v17:__wf_atom_50a7d83e():GetPosition(), __wf_atom_ef7900cf)

			if not __wf_atom_7e8ad928(nearestObject) then
				v17:StormTarget(nearestObject)
			end
		end
	end
end

local function fn8(object, p)
	local v17 = v15 or gRegion:CreateEntity(v14, object:GetPosition(), object:__wf_atom_dc309f8a(), nil, nil, p)

	if __wf_atom_7e8ad928(v17) then
		return
	end

	v17:Enable()
	__wf_atom_55142dd4(v17, "OnTouched", fn4)

	while not v do
		if
			not __wf_atom_7e8ad928(_T.ForceGotToCompletedTrigger)
			and _T.ForceGotToCompletedTrigger:__wf_atom_db682341() == v17:__wf_atom_db682341()
		then
			break
		end

		Sleep(0.5)
	end
end

local function fn9(sparrowBehaviour, object, p)
	if sparrowBehaviour == 0 then
		return
	end

	local v17 = Range(5, 3.4028234663852886e38)
	local v18

	if sparrowBehaviour == 2 then
		v17 = Range(15, 3.4028234663852886e38)
		v18 = 40
	else
		v18 = 20
	end

	module4.AddQuestDestination(object, mOwner, p, v17)
	return (module.CreateAreaMarkerAtPos(object:GetPosition(), v18, __wf_atom_28d5d4aa, mOwner, p))
end

local function fn10(instance, object)
	local v17, v18

	if instance:IsA(__wf_atom_f806fd7a) then
		v17 = instance:__wf_atom_103377cc() + 5
		v18 = instance:__wf_atom_be637430()
	end

	for _, v19 in ipairs(v18) do
		v17 = math.max(v19:__wf_atom_50a7d83e():__wf_atom_1c8f7b2d(instance), v17)
	end

	object:__wf_atom_400189c4((math.min(v17 + 5, 80)))
end

local function fn11(deliverResources, amountsToDeliver, allowMultiplayer)
	for i, _ in ipairs(amountsToDeliver) do
		local count = 0
		local v17

		if allowMultiplayer then
			v17 = gRegion:__wf_atom_ef7900cf()
		else
			v17 = gRegion:__wf_atom_c4f78a8f()
		end

		for j = 1, #v17 do
			local __wf_atom_d2b2176d = v17[j]:__wf_atom_d2b2176d()
			local __wf_atom_ee725e9c = __wf_atom_d2b2176d:__wf_atom_ee725e9c(deliverResources[i], true, true)

			if not (count < amountsToDeliver[i]) then
				continue
			end

			for _ = 1, __wf_atom_ee725e9c do
				__wf_atom_d2b2176d:__wf_atom_5106368a(deliverResources[i])
				__wf_atom_d2b2176d:__wf_atom_ee725e9c(deliverResources[i], true, true)
				count += 1

				if amountsToDeliver[i] <= count then
					break
				end
			end
		end
	end
end

local function fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module2.WaitForAiDir()

	if isQuestStarter then
		if not module.CanQuestBeStarted(questResource) then
			return false
		end

		if not __wf_atom_7e8ad928(questStarterPortForwarderTag) then
			module2.TaggedFirePorts(Symbol(questStarterPortForwarderTag), "TriggerPort")
		end
	end

	v11 = false

	if v11 and _G.EnableDevTeleportToActiveStep and module.IsQuestTracked(mOwner) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(__wf_atom_95e89f02)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			fn(__wf_atom_0a6a5887, true)
		end
	end

	if mOwner ~= nil then
		v13 = module.GetQuestReplicationMode(mOwner)

		if mOwner:__wf_atom_6d0c070b() then
			flag2 = true
		end
	end

	return true
end

function PlayTransmission(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if flag2 then
		module10.PlayLocalTransmission(
			ancestorTransmissionSet,
			ancestorTransmissionTag,
			gRegion:__wf_atom_c4f78a8f(),
			true
		)
	else
		module10.PlayGlobalTransmission(ancestorTransmissionSet, ancestorTransmissionTag, true)
	end

	if gRegion:IsMaster() or flag2 then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function DissolveOutQuestEntities()
	local v17 = 0

	while v17 < 1 do
		v17 = __wf_atom_421b01aa(v17 + __wf_atom_084b3e93(), 0, 1)

		for _, v18 in pairs(actorInstances) do
			v18:__wf_atom_68f2c268(v17)
		end

		Sleep(0)
	end
end

function TryToAddQuestToJobBoard(object)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if not object:IsEnabled() then
		return
	end

	if module.CanQuestBeStarted(questResource) then
		local marker = nil
		local position = object:GetPosition()
		local __wf_atom_5b41f63b = questResource:__wf_atom_5b41f63b()
		local jobBoardsInRange = module6.GetJobBoardsInRange(position, Range(0, 1), true)
		local v17 = Localize(Resource(questResource):__wf_atom_014a76a2():c_str(), false)
		local questDescription = tostring(questDescription)

		local function fn13(p)
			if __wf_atom_7e8ad928(marker) then
				marker = gRegion:CreateEntity(v16, position, __wf_atom_80368bb1)
			end

			p.marker = marker
			p.quest = questResource
		end

		module6.AddToJobBoards(__wf_atom_5b41f63b, jobBoardsInRange, v17, questDescription, v16, fn13, function(_) end)
	end
end

function StartQuest()
	if isQuestStarter then
		module.StartQuest(questResource)
	end
end

function GotoLocation(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		module5.UpdateOrAddHudTask(mOwner, p)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(locationTriggerTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
			__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnTouched", fn4)
			local v17 = fn9(sparrowBehaviour, __wf_atom_0a6a5887, p)

			while not v do
				Sleep(0.5)
			end

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				return
			end

			if sparrowBehaviour ~= 0 then
				if not __wf_atom_7e8ad928(v17) then
					module.DestroyAreaMarker(v17)
				end

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					module4.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
				end
			end

			if isQuestStarter then
				module.StartQuest(questResource)
				return
			end

			if startObjective then
				module5.CompleteHudTask(mOwner, nil, p, completetime)
			end

			Sleep(completetime)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

function LookAt(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		if startObjective then
			module5.UpdateOrAddHudTask(mOwner, p)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(lookAtTriggerTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
			__wf_atom_55142dd4(__wf_atom_0a6a5887, "Activated", fn3)
			local v17 = fn9(sparrowBehaviour, __wf_atom_0a6a5887, p)

			while not v2 do
				Sleep(0.2)
			end

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				return
			end

			if sparrowBehaviour ~= 0 then
				if not __wf_atom_7e8ad928(v17) then
					module.DestroyAreaMarker(v17)
				end

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					module4.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
				end
			end

			if isQuestStarter then
				module.StartQuest(questResource)
				return
			end

			if startObjective then
				module5.CompleteHudTask(mOwner, nil, p, completetime)
			end

			Sleep(completetime)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

function CanInteract()
	if __wf_atom_7e8ad928(_T.QuestInteractCondition) or not _T.QuestInteractCondition[interactTaskTagID:c_str()] then
		return false
	end

	return true
end

function Interact(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		local v17 = nil
		local v18 = nil

		if __wf_atom_7e8ad928(_T.QuestInteractCondition) then
			_T.QuestInteractCondition = {}
		end

		_T.QuestInteractCondition[p] = true

		if interactableDecoTag ~= EMPTY_SYMBOL then
			v18 = gRegion:__wf_atom_0a6a5887(interactableDecoTag)

			if not __wf_atom_7e8ad928(v18) then
				v18:SetVisibility(true)

				if interactableTag == EMPTY_SYMBOL then
					v17 = v18:__wf_atom_bb3e7833(__wf_atom_0f45538d)

					if not __wf_atom_7e8ad928(v17) then
						v17:Enable()
					end
				end
			end
		end

		if interactableTag ~= EMPTY_SYMBOL then
			v17 = gRegion:__wf_atom_0a6a5887(interactableTag)

			if not (__wf_atom_7e8ad928(v17) or v17:IsEnabled()) then
				v17:Enable()
			end
		end

		if pickupWaypointTag ~= EMPTY_SYMBOL and not __wf_atom_7e8ad928(pickupResource) then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(pickupWaypointTag)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				local entity = gRegion:CreateEntity(
					pickupResource,
					__wf_atom_0a6a5887:GetPosition(),
					__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
					nil,
					nil
				)

				if not __wf_atom_7e8ad928(entity) then
					local v19 = false

					while not v19 do
						if __wf_atom_7e8ad928(entity) then
							return
						end

						v19 = not __wf_atom_7e8ad928(entity:__wf_atom_a3d1d403()) or v19

						if __wf_atom_7e8ad928(entity) then
							return
						else
							Sleep(0)
						end
					end

					v17 = entity:__wf_atom_a3d1d403(true)
				end
			end
		end

		v11 = false

		if v11 and not __wf_atom_7e8ad928(v17) then
			local __wf_atom_e919fb8e = v17:__wf_atom_e919fb8e()

			if __wf_atom_e919fb8e ~= nil then
				__wf_atom_e919fb8e.interactionCompleted = false
			end
		end

		if not __wf_atom_7e8ad928(v17) or waitForInteractableToExist then
			if startObjective then
				module5.UpdateOrAddHudTask(mOwner, p)
			end

			local v19 = nil

			if __wf_atom_7e8ad928(v18) then
				if not __wf_atom_7e8ad928(v17) then
					v19 = v17
				end
			else
				v19 = v18
			end

			if sparrowDestinationTag ~= EMPTY_SYMBOL then
				v19 = gRegion:__wf_atom_0a6a5887(sparrowDestinationTag)
			end

			local v20

			if not (__wf_atom_7e8ad928(v19) or isQuestStarter) then
				v20 = fn9(sparrowBehaviour, v19, p)
			end

			if waitForInteractableToExist and interactableTag ~= EMPTY_SYMBOL then
				while true do
					v17 = gRegion:__wf_atom_0a6a5887(interactableTag)

					if not __wf_atom_7e8ad928(v17) then
						break
					end

					Sleep(2)
				end
			end

			__wf_atom_55142dd4(v17, "OnActivated", fn2)
			local __wf_atom_e919fb8e = v17:__wf_atom_e919fb8e()

			while true do
				if __wf_atom_e919fb8e == nil then
					if not __wf_atom_7e8ad928(v17) then
						__wf_atom_e919fb8e = v17:__wf_atom_e919fb8e()
					end
				elseif __wf_atom_e919fb8e.interactionCompleted ~= nil and __wf_atom_e919fb8e.interactionCompleted then
					break
				end

				if not __wf_atom_7e8ad928(v17) then
					if not v17:IsEnabled() then
						v17:Enable()
					end

					if not _T.QuestInteractCondition[p] then
						_T.QuestInteractCondition[p] = true
					end
				end

				Sleep(2)
			end

			if __wf_atom_7e8ad928(v19) then
				return
			end

			while __wf_atom_8e4fda44:__wf_atom_6b69b901(v3) do
				Sleep(2)
			end

			_T.QuestInteractCondition[p] = false

			if isQuestStarter then
				module.StartQuest(questResource)
				return
			end

			if startObjective then
				module5.CompleteHudTask(mOwner, nil, p, completetime)
			end

			if sparrowBehaviour ~= 0 then
				if not __wf_atom_7e8ad928(v20) then
					module.DestroyAreaMarker(v20)
				end

				if not __wf_atom_7e8ad928(v19) then
					module4.RemoveSparrowDestination(v19, p)
				end
			end

			Sleep(completetime)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

function Defeat(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		module5.UpdateOrAddHudTask(mOwner, p)

		if module2.IsInOverworld() and encounterHintTag:__wf_atom_8598f3a9() then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(encounterHintTag)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				v5 = __wf_atom_0a6a5887
				__wf_atom_0a6a5887:__wf_atom_71694ad6(0)
				module3.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
				local subBossTimerSymb = module3.GetSubBossTimerSymb(__wf_atom_0a6a5887, false)

				if not __wf_atom_7e8ad928(subBossTimerSymb) then
					gGameData:__wf_atom_04988606(subBossTimerSymb, "")
					Sleep(0)
				end

				local v17 = Symbol("QuestHintCallback-" .. tostring(p))
				__wf_atom_0a6a5887:__wf_atom_7dd025d4(fn5, v17)

				if disablePatrollers then
					__wf_atom_0a6a5887:__wf_atom_c361f7f8(fn6, v17)
				end

				__wf_atom_0a6a5887:__wf_atom_b447e001(fn7, Symbol("OnCampAlerted"), 3, true)
				local v18 = fn9(sparrowBehaviour, __wf_atom_0a6a5887, p)

				while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
					if flag then
						if disablePatrollers then
							__wf_atom_0a6a5887:__wf_atom_cdea4419(v17)
						end

						__wf_atom_0a6a5887:__wf_atom_4ab4e145(Symbol("OnCampAlerted"))
						module5.CompleteHudTask(mOwner, nil, p, completetime)

						if sparrowBehaviour ~= 0 then
							if not __wf_atom_7e8ad928(v18) then
								module.DestroyAreaMarker(v18)
							end

							if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
								module4.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
							end
						end

						Sleep(completetime)
						module.CompleteTaskWithID(mOwner, p)
						return
					else
						if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(v18)) then
							fn10(__wf_atom_0a6a5887, v18)
						end

						Sleep(0.5)
					end
				end
			end
		end
	end
end

function DefeatCustom(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		module5.UpdateOrAddHudTask(mOwner, p)

		if module2.IsInOverworld() then
			local v17 = nil

			if encounterLocationTag:__wf_atom_8598f3a9() then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(encounterLocationTag)

				if not __wf_atom_7e8ad928(encounterHintType) then
					local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
					v17 = gRegion:CreateEntity(encounterHintType, __wf_atom_0a6a5887:GetPosition(), __wf_atom_80368bb1)
					__wf_atom_7d789620:__wf_atom_ccbb5582(v17)

					if __wf_atom_7e8ad928(encounterTemplate) then
						__wf_atom_7d789620:ActivateRandomEncounterAtSpecificHint(v17)
					else
						__wf_atom_7d789620:ActivateSpecificEncounterAtSpecificHint(v17, encounterTemplate)
					end
				end

				for i = 1, #encountersToDisable do
					local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(encountersToDisable[i])

					if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
						__wf_atom_0a6a5887_2:Disable()
					end
				end

				if not __wf_atom_7e8ad928(v17) then
					local subBossTimerSymb = module3.GetSubBossTimerSymb(v17, false)

					if not __wf_atom_7e8ad928(subBossTimerSymb) then
						gGameData:__wf_atom_04988606(subBossTimerSymb, "")
						Sleep(0)
					end

					local v18 = Symbol("QuestHintCallback-" .. tostring(p))
					v17:__wf_atom_7dd025d4(fn5, v18)

					if disablePatrollers then
						v17:__wf_atom_c361f7f8(fn6, v18)
					end

					local v19 = fn9(sparrowBehaviour, v17, p)

					while not __wf_atom_7e8ad928(v17) do
						if flag then
							if disablePatrollers then
								v17:__wf_atom_cdea4419(v18)
							end

							module5.CompleteHudTask(mOwner, nil, p, completetime)

							if sparrowBehaviour ~= 0 then
								if not __wf_atom_7e8ad928(v19) then
									module.DestroyAreaMarker(v19)
								end

								if not __wf_atom_7e8ad928(v17) then
									module4.RemoveSparrowDestination(v17, p)
								end
							end

							Sleep(completetime)
							module.CompleteTaskWithID(mOwner, p)
							return
						else
							if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v19)) then
								fn10(v17, v19)
							end

							Sleep(0.5)
						end
					end
				end
			end
		end
	end
end

function DefeatMission(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		module5.UpdateOrAddHudTask(mOwner, p)

		if module2.IsInOverworld() then
			local v17 = nil
			local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
			local v18 = nil
			local v19 = Symbol("QuestHintCallback-" .. tostring(p))

			if encounterHintTag:__wf_atom_8598f3a9() then
				v4 = true
				v17 = gRegion:__wf_atom_0a6a5887(encounterHintTag)

				if __wf_atom_7e8ad928(v17) then
					while not __wf_atom_7e8ad928(v17) do
						if flag then
							if disablePatrollers then
								v17:__wf_atom_cdea4419(v19)
							end

							module5.CompleteHudTask(mOwner, nil, p, completetime)

							if sparrowBehaviour ~= 0 then
								if not __wf_atom_7e8ad928(v18) then
									module.DestroyAreaMarker(v18)
								end

								if not __wf_atom_7e8ad928(v17) then
									module4.RemoveSparrowDestination(v17, p)
								end
							end

							Sleep(completetime)
							module.CompleteTaskWithID(mOwner, p)
							return
						else
							if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v18)) then
								fn10(v17, v18)
							end

							Sleep(0.5)
						end
					end
				else
					v17:__wf_atom_71694ad6(0)
					v17:Enable()
					module3.SetMissionEncounterAllowed(v17, false)
					local subBossTimerSymb = module3.GetSubBossTimerSymb(v17, false)

					if not (__wf_atom_7e8ad928(subBossTimerSymb) or __wf_atom_7e8ad928(gGameData)) then
						gGameData:__wf_atom_04988606(subBossTimerSymb, "")
						Sleep(0)
					end

					if __wf_atom_7e8ad928(encounterTemplate) then
						if
							missionTag ~= EMPTY_SYMBOL
							and not __wf_atom_7d789620:PrimeMissionOnHint(missionTag, v17)
						then
							print("Failed to prime hint " .. v17:__wf_atom_5b41f63b() .. " with mission tag " .. tostring(missionTag))
							return
						end
					elseif not __wf_atom_7d789620:__wf_atom_aba65605(encounterTemplate, v17) then
						print("Failed to prime hint " .. v17:__wf_atom_5b41f63b() .. " with encounter " .. encounterTemplate:__wf_atom_5b41f63b())
						return
					end

					v17:__wf_atom_99a5d75c(fn5, v19)

					if disablePatrollers then
						v17:__wf_atom_c361f7f8(fn6, v19)
					end

					v18 = fn9(sparrowBehaviour, v17, p)

					while not __wf_atom_7e8ad928(v17) do
						if flag then
							if disablePatrollers then
								v17:__wf_atom_cdea4419(v19)
							end

							module5.CompleteHudTask(mOwner, nil, p, completetime)

							if sparrowBehaviour ~= 0 then
								if not __wf_atom_7e8ad928(v18) then
									module.DestroyAreaMarker(v18)
								end

								if not __wf_atom_7e8ad928(v17) then
									module4.RemoveSparrowDestination(v17, p)
								end
							end

							Sleep(completetime)
							module.CompleteTaskWithID(mOwner, p)
							return
						else
							if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v18)) then
								fn10(v17, v18)
							end

							Sleep(0.5)
						end
					end
				end
			else
				if
					not __wf_atom_7e8ad928(encounterTemplate)
					and encounterTemplate:IsA(__wf_atom_5ffe867f)
					and Resource(encounterTemplate):__wf_atom_7026c43c()
				then
					v17 = __wf_atom_7d789620:__wf_atom_c4c644af(__wf_atom_28d5d4aa, encounterTemplate)
				end

				while not __wf_atom_7e8ad928(v17) do
					if flag then
						if disablePatrollers then
							v17:__wf_atom_cdea4419(v19)
						end

						module5.CompleteHudTask(mOwner, nil, p, completetime)

						if sparrowBehaviour ~= 0 then
							if not __wf_atom_7e8ad928(v18) then
								module.DestroyAreaMarker(v18)
							end

							if not __wf_atom_7e8ad928(v17) then
								module4.RemoveSparrowDestination(v17, p)
							end
						end

						Sleep(completetime)
						module.CompleteTaskWithID(mOwner, p)
						return
					else
						if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v18)) then
							fn10(v17, v18)
						end

						Sleep(0.5)
					end
				end
			end
		end
	end
end

local function fn13(instance) -- 1 equivalent call inferred from this helper
	if
		__wf_atom_7e8ad928(instance)
		or instance:IsA(__wf_atom_6a50bd07) and instance:IsA(__wf_atom_8d0b7f88) and instance:__wf_atom_c6f1f83d() <= 0
	then
		return true
	end

	return false
end

function Destroy(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		local __wf_atom_0a6a5887s = {}
		local __wf_atom_0a6a5887s2 = {}
		local v17 = {}

		if #destructibleTags > 0 then
			for _, v18 in ipairs(destructibleTags) do
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v18)

				if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					continue
				end

				if not __wf_atom_7e8ad928(destructibleTypeToSpawn) then
					__wf_atom_0a6a5887 = gRegion:CreateEntity(
						destructibleTypeToSpawn,
						__wf_atom_0a6a5887:GetPosition(),
						__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
						nil,
						nil
					)
				end

				table.insert(__wf_atom_0a6a5887s, __wf_atom_0a6a5887)
				table.insert(__wf_atom_0a6a5887s2, __wf_atom_0a6a5887)
				table.insert(v17, (fn9(sparrowBehaviour, __wf_atom_0a6a5887, p)))
			end
		end

		local count = #__wf_atom_0a6a5887s
		local count2 = 0
		local v18 = -1

		while #__wf_atom_0a6a5887s > 0 do
			for i, v19 in ipairs(__wf_atom_0a6a5887s) do
				if not fn13(v19) then -- inferred equivalent call
					continue
				end

				local sparrowBehaviour = sparrowBehaviour
				local v20 = v17[i]
				local v21 = __wf_atom_0a6a5887s2[i]

				if sparrowBehaviour ~= 0 then
					if not __wf_atom_7e8ad928(v20) then
						module.DestroyAreaMarker(v20)
					end

					if not __wf_atom_7e8ad928(v21) then
						module4.RemoveSparrowDestination(v21, p)
					end
				end

				table.remove(__wf_atom_0a6a5887s, i)
				count2 += 1
			end

			if startObjective and count2 ~= v18 then
				module5.UpdateOrAddHudCounterTask(mOwner, p, nil, count2, count)
				v18 = count2
			end

			Sleep(2)
		end

		if count > 0 then
			if isQuestStarter then
				module.StartQuest(questResource)
				return
			end

			if startObjective then
				module5.UpdateOrAddHudCounterTask(mOwner, p, nil, count, count)
				Sleep(0.5)
				module5.CompleteHudTask(mOwner, nil, p, completetime)
				Sleep(completetime)
			end

			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

local function fn14()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local playerAvatars = {}

	for _, v17 in ipairs(__wf_atom_3c8e1a7a) do
		if __wf_atom_7e8ad928(v17) or not (not flag2 or v17:IsLocal()) then
			continue
		end

		local playerAvatar = v17:GetPlayerAvatar(0)

		if not __wf_atom_7e8ad928(playerAvatar) then
			table.insert(playerAvatars, playerAvatar)
		end
	end

	return playerAvatars
end

function Gather(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if (gRegion:IsMaster() or flag2) and not __wf_atom_7e8ad928(gatherResource) then
		local v17 = nil
		local flag3 = true
		local v18

		if deliveryInteractableTag == EMPTY_SYMBOL then
			flag3 = false
		else
			v18 = gRegion:__wf_atom_0a6a5887(deliveryInteractableTag)
		end

		if not __wf_atom_7e8ad928(v18) then
			v17 = v18:__wf_atom_e919fb8e()

			if v17 ~= nil then
				v17.amountToDeliver = amountToDeliver
			end
		end

		v11 = false

		if v11 and not __wf_atom_7e8ad928(v18) and v17 ~= nil then
			v17.deliveryComplete = false
			v17.itemsDelivered = 0
		end

		local v19 = fn14()
		local total = 0

		for i = 1, #v19 do
			total += v19[i]:__wf_atom_d2b2176d():__wf_atom_ee725e9c(gatherResource, true, true)
		end

		local v20 = false
		local v21 = -1
		local deliveryComplete = nil
		local itemsDelivered = nil
		local v22 = -1
		local v23 = nil
		local v24 = false

		while not v20 do
			local v25 = fn14()
			local total2 = 0

			for i = 1, #v25 do
				total2 += v25[i]:__wf_atom_d2b2176d():__wf_atom_ee725e9c(gatherResource, true, true)
			end

			if v17 == nil then
				v18 = gRegion:__wf_atom_0a6a5887(deliveryInteractableTag)

				if not __wf_atom_7e8ad928(v18) then
					v17 = v18:__wf_atom_e919fb8e()
				end
			elseif v17.itemsDelivered ~= nil then
				total2 += v17.itemsDelivered
			end

			if amountToGather <= total2 then
				if startObjective and total2 ~= v21 then
					module5.UpdateOrAddHudCounterTask(mOwner, p, nil, total2, amountToGather)
					Sleep(2)
					module5.CompleteHudTask(mOwner, nil, p, completetime)
					v21 = total2
				end

				if flag3 then
					if not __wf_atom_7e8ad928(v18) then
						if not v18:IsEnabled() then
							v18:Enable()
						end

						if v17 == nil then
							v17 = v18:__wf_atom_e919fb8e()
						elseif v17.deliveryComplete == nil then
							v17.deliveryComplete = false
						else
							deliveryComplete = v17.deliveryComplete
							itemsDelivered = v17.itemsDelivered
						end

						if not v24 then
							v23 = fn9(sparrowBehaviour, v18, p)

							if not __wf_atom_7e8ad928(v23) then
								v24 = true
							end
						end
					end

					if not __wf_atom_7e8ad928(deliveryObjective) then
						if deliveryComplete == nil then
							deliveryComplete = false
						elseif deliveryComplete then
							if startObjective and itemsDelivered ~= v22 then
								module5.UpdateOrAddHudCounterTask(
									mOwner,
									p,
									deliveryObjective,
									itemsDelivered,
									amountToDeliver
								)
								Sleep(2)
								module5.CompleteHudTask(mOwner, nil, p, completetime)
								v22 = itemsDelivered
							end

							if sparrowBehaviour ~= 0 then
								if not __wf_atom_7e8ad928(v23) then
									module.DestroyAreaMarker(v23)
								end

								if not __wf_atom_7e8ad928(v18) then
									module4.RemoveSparrowDestination(v18, p)
								end
							end

							v20 = true
							v24 = false
						else
							itemsDelivered = itemsDelivered == nil and 0 or itemsDelivered

							if startObjective and itemsDelivered ~= v22 then
								module5.UpdateOrAddHudCounterTask(
									mOwner,
									p,
									deliveryObjective,
									itemsDelivered,
									amountToDeliver
								)
								v22 = itemsDelivered
							end
						end
					end
				else
					v20 = true

					if startObjective then
						module5.CompleteHudTask(mOwner, nil, p, completetime)
					end
				end
			else
				if not __wf_atom_7e8ad928(v18) and v18:IsEnabled() then
					v18:Disable()
				end

				if total2 < amountToGather then
					if startObjective and total2 ~= v21 then
						module5.UpdateOrAddHudCounterTask(mOwner, p, nil, total2, amountToGather)
						v21 = total2
					end
				elseif startObjective and total2 ~= v21 then
					module5.UpdateOrAddHudCounterTask(mOwner, p, nil, total2, amountToGather)
					Sleep(2)
					module5.CompleteHudTask(mOwner, nil, p, completetime)
					v21 = total2
				end
			end

			Sleep(4)
		end

		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function Deliver(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		if startObjective then
			module5.UpdateOrAddHudTask(mOwner, p)
		end

		local flag3 = false
		local v17

		if deliveryInteractableTag == EMPTY_SYMBOL then
			flag3 = true
		else
			v17 = gRegion:__wf_atom_0a6a5887(deliveryInteractableTag)
		end

		local v18, v19

		if not __wf_atom_7e8ad928(v17) then
			v17:Enable()
			v18 = v17:__wf_atom_e919fb8e()

			if v18 ~= nil then
				v18.deliverResources = deliverResources
				v18.amountsToDeliver = amountsToDeliver
			end

			v19 = fn9(sparrowBehaviour, v17, p)
		end

		v11 = false

		if v11 and not __wf_atom_7e8ad928(v17) and v18 ~= nil then
			v18.deliveryComplete = false
			v18.itemsDelivered = 0
		end

		local v20 = false
		local deliveryComplete = nil

		while not v20 do
			if flag3 then
				fn11(deliverResources, amountsToDeliver, allowMultiplayer)

				if startObjective then
					module5.CompleteHudTask(mOwner, nil, p, completetime)
					break
				else
					v20 = true
				end
			else
				if not __wf_atom_7e8ad928(v17) then
					if v18 == nil then
						v18 = v17:__wf_atom_e919fb8e()
					elseif v18.deliveryComplete == nil then
						v18.deliveryComplete = false
					else
						deliveryComplete = v18.deliveryComplete
					end
				end

				if deliveryComplete == nil then
					deliveryComplete = false
				elseif deliveryComplete then
					if startObjective then
						module5.CompleteHudTask(mOwner, nil, p, completetime)
					end

					if sparrowBehaviour == 0 then
						break
					end

					if not __wf_atom_7e8ad928(v19) then
						module.DestroyAreaMarker(v19)
					end

					if __wf_atom_7e8ad928(v17) then
						break
					end

					module4.RemoveSparrowDestination(v17, p)
					break
				end

				Sleep(4)
			end
		end

		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function Equip(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		if startObjective then
			module5.UpdateOrAddHudTask(mOwner, p)
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v17 = false

		while not v17 do
			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			else
				local v18 = {
					__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(5),
					__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
				}

				if #v18 > 0 then
					for i = 1, #v18 do
						if __wf_atom_7e8ad928(v18[i]) or not v18[i]:IsA(__wf_atom_2fc5c2e8) then
							continue
						end

						local v19 = v18[i]

						for j = 0, v19:__wf_atom_06f3cb74() - 1 do
							local __wf_atom_b9a1f18c = v19:__wf_atom_b9a1f18c(j)

							if
								__wf_atom_7e8ad928(__wf_atom_b9a1f18c)
								or not (__wf_atom_b9a1f18c:IsA(v6) or __wf_atom_b9a1f18c:IsA(v7))
								or not __wf_atom_b9a1f18c:IsA(upgradeResource)
							then
								continue
							end

							v17 = true
							break
						end
					end
				end
			end

			Sleep(4)
		end

		if isQuestStarter then
			module.StartQuest(questResource)
			return
		end

		if startObjective then
			module5.CompleteHudTask(mOwner, nil, p, completetime)
		end

		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function CheckLore(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		local memories2 = not checkIfLoreFragmentIsCompleted and {} or loreFragment:__wf_atom_22020464()

		if #memories > 0 then
			memories2 = memories
		end

		if #memories2 > 0 then
			numberOfRequiredMemories = #memories2
		else
			memories2 = loreFragment:__wf_atom_22020464()
		end

		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
		local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			return
		end

		if forceSpawnDiscoveryTriggerTag ~= EMPTY_SYMBOL then
			local nearestTagged = gRegion:FindNearestTagged(forceSpawnDiscoveryTriggerTag, playerAvatar:GetPosition())

			if not __wf_atom_7e8ad928(nearestTagged) then
				local __wf_atom_e919fb8e = nearestTagged:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.spawnAllMotes = true
			end
		end

		local v17 = nil
		local v18

		if sparrowDestinationTag ~= EMPTY_SYMBOL then
			v18 = gRegion:__wf_atom_0a6a5887(sparrowDestinationTag)

			if not __wf_atom_7e8ad928(v18) then
				v17 = fn9(sparrowBehaviour, v18, p)
			end
		end

		local v19 = false
		local v20 = nil
		local v21 = -1

		while not v19 do
			if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
			end

			if __wf_atom_7e8ad928(playerAvatar) and not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

				if __wf_atom_7e8ad928(playerAvatar) then
					return
				end
			end

			if numberOfRequiredMemories > 0 then
				if loreFragment:__wf_atom_7188fa33() then
					v20 = 0

					for i = 1, #memories2 do
						if not module2.HasSpecificLoreMemoryUnlocked(playerAvatar, loreFragment, memories2[i]) then
							continue
						end

						v20 += 1

						if numberOfRequiredMemories <= v20 then
							break
						end
					end
				elseif not __wf_atom_7e8ad928(playerAvatar) then
					v20 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_afc2f523(loreFragment)
				end

				if startObjective and v20 ~= v21 then
					module5.UpdateOrAddHudCounterTask(mOwner, p, nil, v20, numberOfRequiredMemories)
					v21 = v20
				end

				v19 = numberOfRequiredMemories <= v20
			elseif module2.HasFragment(loreFragment) then
				v19 = true
			elseif startObjective then
				module5.UpdateOrAddHudTask(mOwner, p)
			end

			if not v19 then
				Sleep(4)
			end
		end

		if startObjective then
			module5.CompleteHudTask(mOwner, nil, p, completetime)
		end

		if sparrowBehaviour ~= 0 then
			if not __wf_atom_7e8ad928(v17) then
				module.DestroyAreaMarker(v17)
			end

			if not __wf_atom_7e8ad928(v18) then
				module4.RemoveSparrowDestination(v18, p)
			end
		end

		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

local function fn15(filter)
	if __wf_atom_7e8ad928(v8) then
		return nil
	end

	local __wf_atom_19f75a1e = v8:__wf_atom_19f75a1e()

	for i = 1, #__wf_atom_19f75a1e do
		if __wf_atom_19f75a1e[i].tag:c_str() == filter then
			return __wf_atom_19f75a1e[i]
		end
	end

	return nil
end

function CheckNumberOfCodexCompleted(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		local v17 = false
		local v18 = -1

		if not showProgress then
			module5.UpdateOrAddHudTask(mOwner, p)
		end

		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return
		end

		__wf_atom_18a5d83b:__wf_atom_af5caba7()
		local reqScans = {}
		local v19

		if useFilter then
			v19 = fn15(filter)
		end

		local v20

		if v19 then
			v20 = v8:__wf_atom_1e5f4e2f(v19)
		else
			v20 = v8:__wf_atom_e9f78799()
		end

		for _, v21 in v20 do
			reqScans[v21.type:__wf_atom_5b41f63b()] = v21.reqScans
		end

		while not v17 do
			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local count = 0

				for _, mScan in __wf_atom_18a5d83b:__wf_atom_af5caba7().mScans do
					local __wf_atom_5b41f63b = mScan.type:__wf_atom_5b41f63b()

					if not (reqScans[__wf_atom_5b41f63b] ~= nil and mScan.scans >= reqScans[__wf_atom_5b41f63b]) then
						continue
					end

					count += 1

					if not (numberEntriesToUnlock <= count) then
						continue
					end

					v17 = true
					break
				end

				if count ~= v18 and showProgress then
					module5.UpdateOrAddHudTask(
						mOwner,
						p,
						nil,
						Localize("/SF/Language/Quests/GenericChallengeHudFormat", {
							PROGRESS = module9.FormatNumber(count, 0),
							REQUIRED = module9.FormatNumber(numberEntriesToUnlock, 0)
						}),
						false
					)
					v18 = count
				end
			end

			Sleep(2)
		end

		module5.CompleteHudTask(mOwner, nil, p, completetime)
		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function CheckCodex(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		module5.UpdateOrAddHudTask(mOwner, p)

		if not __wf_atom_7e8ad928(codexEntry) then
			local reqScans = v8:__wf_atom_fee280ca(codexEntry).reqScans
			local v17 = false

			while not v17 do
				local mScans = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7().mScans

				for _, mScan in ipairs(mScans) do
					if mScan.type ~= codexEntry then
						continue
					end

					v17 = reqScans <= mScan.scans
					break
				end

				if v17 then
					break
				else
					Sleep(4)
				end
			end
		end

		module5.CompleteHudTask(mOwner, nil, p, completetime)
		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function WaitForQuest(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if (gRegion:IsMaster() or flag2) and not __wf_atom_7e8ad928(questResource) then
		module5.UpdateOrAddHudTask(mOwner, p)
		local v17 = false

		while not v17 do
			Sleep(4)
			v17 = (module.HasPersonalCompletedQuest(questResource) or module.HasCompletedQuest(questResource))
				and true
				or v17
		end

		module5.CompleteHudTask(mOwner, nil, p, completetime)
		Sleep(completetime)
		module.CompleteTaskWithID(mOwner, p)
	end
end

function TalkToNPC(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(hubNpcSpawnPointTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			if startObjective then
				module5.UpdateOrAddHudTask(mOwner, p)
			end

			local v17 = fn9(sparrowBehaviour, __wf_atom_0a6a5887, p)

			if proximityTriggerTag ~= EMPTY_SYMBOL then
				v15 = gRegion:__wf_atom_0a6a5887(proximityTriggerTag)
			end

			fn8(__wf_atom_0a6a5887, v13)

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				return
			end

			local appearAtPosition = module7.AppearAtPosition(
				nil,
				hubNpcType,
				__wf_atom_0a6a5887:GetPosition(),
				nil,
				__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
				v13
			)
			gRegion:CreateEntity(
				talkActionType,
				appearAtPosition:__wf_atom_1c374cc9(attachBone),
				__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
				nil,
				nil,
				v13
			)

			if dissolveIn then
				module7.DissolveIn(appearAtPosition)
			else
				appearAtPosition:SetVisibility(true)
			end

			while
				__wf_atom_7e8ad928(_T.NPCConversationFinished)
				or _T.NPCConversationFinished.conversationID ~= conversationID
			do
				Sleep(1)
			end

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				return
			end

			if dissolveOut then
				module7.DissolveOut(appearAtPosition)
			else
				appearAtPosition:SetVisibility(false)
			end

			_T.NPCConversationFinished = {}

			if startObjective then
				module5.CompleteHudTask(mOwner, nil, p, completetime)
			end

			if sparrowBehaviour ~= 0 then
				if not __wf_atom_7e8ad928(v17) then
					module.DestroyAreaMarker(v17)
				end

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					module4.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
				end
			end

			Sleep(completetime)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

function QuestCompleteCelebration(p)
	if not fn12(isQuestStarter, questResource, questStarterPortForwarderTag, __wf_atom_95e89f02) then
		return
	end

	if gRegion:IsMaster() or flag2 then
		if __wf_atom_7e8ad928(questResource) then
			questResource = mOwner
		end

		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local questname = Localize(Resource(questResource):__wf_atom_014a76a2():c_str(), false)

		for _, v17 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v17) then
				continue
			end

			local __wf_atom_a96eb2aa = v17:__wf_atom_a96eb2aa()

			if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
				gGameRules:__wf_atom_8085277a(
					__wf_atom_a96eb2aa,
					Localize("/SF/Language/Quests/QuestCompleted", { QUESTNAME = questname }),
					1,
					Symbol("Default")
				)
			end
		end

		module.CompleteTaskWithID(mOwner, p)
		module6.RemoveFromAllJobBoards(questResource:__wf_atom_5b41f63b())
	end
end

function AncestorTaskTurnIn(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if __wf_atom_7e8ad928(_T.AncestorTaskTurnsQueue) then
		_T.AncestorTaskTurnsQueue = {}
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	table.insert(_T.AncestorTaskTurnsQueue, {
		Quest = mOwner,
		ancestorId = ancestorSym,
		TransmissionSet = ancestorTransmissionSet,
		DialogueTag = ancestorTransmissionTag,
		AnimTag = triggeredAnimTag
	})
end

function AncestorStartTask(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module.GetQuestReplicationMode(mOwner)

	if
		not __wf_atom_7e8ad928(_T.TechTreeTaskAcecpted)
		and _T.TechTreeTaskAcecpted.idSymbol == ancestorSym
		and not (__wf_atom_7e8ad928(ancestorTransmissionTag) or __wf_atom_7e8ad928(ancestorTransmissionSet))
	then
		module7.PlayAncestorTransmission(
			ancestorTransmissionSet,
			ancestorTransmissionTag,
			_T.TechTreeTaskAcecpted.HubNpc,
			triggeredAnimTag,
			nil,
			false,
			false
		)
	end

	if not _G.logQuestSteps then
		local _enableLogging = enableLogging
	end

	_T.TechTreeTaskAcecpted = {}
	Sleep(1)
	module.CompleteTaskWithID(mOwner, p)
end

function AncestorComment(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v17 = module7.TryAppearRelativeToPlayer(__wf_atom_c4f78a8f, ancestorDecoType, nil, {
		distance = 3,
		minSpawnDist = 1,
		maxSpawnVerticalDist = 2,
		tryBehind = false,
		validateFunc = function()
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				return false
			end

			local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
			return not (__wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() or playerAvatar:__wf_atom_799d95f5() or _T.LocalPlayerInNightFold)
		end
	}, true)
	module7.DissolveIn(v17)

	if not (__wf_atom_7e8ad928(ancestorTransmissionTag) or __wf_atom_7e8ad928(ancestorTransmissionSet)) then
		module7.PlayAncestorTransmission(
			ancestorTransmissionSet,
			ancestorTransmissionTag,
			v17,
			triggeredAnimTag,
			nil,
			true
		)
	end

	module7.DissolveOut(v17)
	module.CompleteTaskWithID(mOwner, p)
end

function AncestorEnableInviteToNightfoldContextAction(p)
	module2.WaitForLoginSequence()
	module2.WaitForLevel()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(interactableTag)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(ancestorNPCTag)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(disableWispersPortforwarder)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
	end

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_7e8ad928(ancestorWatingIdle)) then
		__wf_atom_0a6a5887_2:SetVisibility(true, true)
		__wf_atom_0a6a5887_2:__wf_atom_d927a2a4(ancestorWatingIdle)
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:FirePort("TriggerPort")
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	module4.AddSparrowDestination(__wf_atom_0a6a5887_2, nil, nil, module4.PRIORITY.QUEST, nil, mOwner, p)
end

local function fn16(targetAncestor)
	local localPlayerAncestorOfType = module7.GetLocalPlayerAncestorOfType(targetAncestor, true)

	if not __wf_atom_7e8ad928(localPlayerAncestorOfType) then
		local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			__wf_atom_330f77f5:__wf_atom_b4984563(
				v10,
				"AncestorDiscovered",
				{ Resource(localPlayerAncestorOfType.mType):__wf_atom_014a76a2():c_str(), (tostring(7)) },
				7,
				"AncestorDiscovered",
				true
			)
		end

		if showAncestorTutPrompt then
			_T.ShowImpactMessage("/SF/Language/Tutorial/AncestorDiscovered", 5)
		end
	end
end

function AncestorInviteToNightFoldWithCin(object, object2)
	local ancestorNPCInstance = ancestorNPCInstance
	local inviteToNightFoldCine2

	if __wf_atom_7e8ad928(inviteToNightFoldCine) then
		inviteToNightFoldCine2 = gRegion:__wf_atom_f738b4af(Symbol("InviteToNightfold"), object2:GetPosition(), 0, 10)
	else
		inviteToNightFoldCine2 = inviteToNightFoldCine
	end

	if __wf_atom_7e8ad928(inviteToNightFoldCine2) then
		return
	end

	if inviteToNightFoldCine2:IsA(__wf_atom_804af126) then
		inviteToNightFoldCine2:SetInstigatorAvatar(object2)
	end

	object:Disable()
	module8.RegisterPreventNighfoldUsage(true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NavBridgeToOrlickOffice"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Disable")
	end

	local v17

	if gRegion:IsMaster() then
		v17 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(
			object,
			agentPauseRadiusFromAncestor,
			true
		)

		for _, v18 in ipairs(v17) do
			if not __wf_atom_7e8ad928(v18) then
				v18:SetPaused(true, v9)
			end
		end
	end

	inviteToNightFoldCine2:FirePort("StartPlaying")

	while inviteToNightFoldCine2:__wf_atom_7d4910e4() do
		Sleep(0)

		if inviteToNightFoldCine2:__wf_atom_e9546dc6() then
			break
		end
	end

	module8.RegisterPreventNighfoldUsage(false)
	ancestorNPCInstance:SetVisibility(false)

	if module.CanCompleteTask(Resource(questType)) then
		module.DestroyAreaMarker(ancestorNPCInstance)
		module5.CompleteAllHudTasks(questType, 5)
		module.CompleteTaskWithTag(Resource(questType), Symbol("InviteToNightfold"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Enable")
	end

	if gRegion:IsMaster() then
		for _, v18 in ipairs(v17) do
			if not __wf_atom_7e8ad928(v18) then
				v18:SetPaused(false, v9)
			end
		end
	end

	fn16(targetAncestor)
end