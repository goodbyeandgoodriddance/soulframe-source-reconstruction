local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module7 = require("Lotus.Interface.BindingsUtil")
local module8 = require("EE.Interface.Utilities")
local module9 = require("SF.Scripts.NightFoldLib")
local module10 = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.FirstLoginUtils")
local v = Resource("/SF/Interface/HUD/Notification.swf")
local v2 = true
local v3 = nil

local function fn(ancestorTransmissionSet, ancestorTransmissionTags, p, p2)
	if p > 0 then
		Sleep(p)
	end

	for i = 1, #ancestorTransmissionTags do
		if p2 then
			module3.PlayLocalTransmission(
				ancestorTransmissionSet,
				ancestorTransmissionTags[i],
				gRegion:__wf_atom_c4f78a8f(),
				true
			)
		elseif gRegion:IsMaster() then
			module3.PlayGlobalTransmission(ancestorTransmissionSet, ancestorTransmissionTags[i], true)
		end

		while module3.TransmissionPlaying() do
			Sleep(0)
		end
	end
end

function GiveLoreDrop(p)
	if not (next(loreDropsRewards) ~= nil and __wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

		if not __wf_atom_7e8ad928(playerAvatar) then
			local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				for _, v4 in ipairs(loreDropsRewards) do
					if __wf_atom_d2b2176d:__wf_atom_96a19f31(v4) < 1 then
						module2.GiveLoreFragment(playerAvatar, v4)
					end
				end
			end
		end
	end

	if completeThisQuestTask and gRegion:IsMaster() then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function GiveItemReward()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v4 in ipairs(__wf_atom_3c8e1a7a) do
		if not v4:IsLocal() then
			continue
		end

		local playerAvatar = v4:GetPlayerAvatar(0)

		for _, v5 in ipairs(itemRewards) do
			playerAvatar:GiveItem(Resource(v5:__wf_atom_5b41f63b()), false)
		end
	end
end

function GiveUpgradeRewards()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v4 in ipairs(__wf_atom_3c8e1a7a) do
		if not v4:IsLocal() then
			continue
		end

		local __wf_atom_d2b2176d = v4:GetPlayerAvatar(0):__wf_atom_d2b2176d()

		for _, v5 in ipairs(upgradeRewards) do
			__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v5, "")
		end
	end
end

function GiveStoreBundleReward()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v4 in ipairs(__wf_atom_3c8e1a7a) do
		if not v4:IsLocal() or __wf_atom_7e8ad928(itemRewardsBundle) then
			continue
		end

		v4:GetPlayerAvatar(0):__wf_atom_d2b2176d():AddStoreItem(itemRewardsBundle, nil)
	end
end

local function fn2(experienceReward)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v4 in pairs(__wf_atom_3c8e1a7a) do
		local playerAvatar = v4:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:__wf_atom_355b9a20(experienceReward, playerAvatar, EMPTY_SYMBOL)
		end
	end
end

function SoulTriggeredAnim()
	v3 = gRegion:__wf_atom_c4f78a8f()
	v3:__wf_atom_921c1a5f(pickUpAnim, false, 4, 1, true)
	v3:__wf_atom_8914dfde("PickUp", 2)
	v3:__wf_atom_921c1a5f(knockbackAnim, false, 4, 1, true)
end

function StartAncestorProgressionPickup(object, object2)
	local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor, true)

	if __wf_atom_7e8ad928(interactDeco) then
		return
	end

	module3.CloseTransmissions()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(ancestorNPCTag)

	if isTrackedDest and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module5.RemoveSparrowDestination(__wf_atom_0a6a5887)
	end

	if not __wf_atom_7e8ad928(Resource(questType)) and __wf_atom_7e8ad928(localPlayerAncestorOfType) then
		if not __wf_atom_7e8ad928(pickUpAnim) then
			object2:__wf_atom_921c1a5f(pickUpAnim, false, 2, 1, true)
			object2:__wf_atom_8914dfde("PickUp", 2)

			if knockPlayerBack then
				module.StartQuest(Resource(questType))
				object2:__wf_atom_921c1a5f(knockbackAnim, false, 4, 1, true)
			else
				interactDeco:AttachToInPlace(object2, Symbol("GAME_R1_WEAPON1"))
				module.StartQuest(Resource(questType))
				object2:__wf_atom_8914dfde("HidePickup", 2)
				gRegion:__wf_atom_dd1e4d10(interactDeco)
			end
		end

		object:Disable()

		if attenuateFOV then
			gRegion:__wf_atom_c4f78a8f():CameraControl():__wf_atom_25382a0d(0.7, false)
		end
	end
end

function StartAncestorProgression(object, p)
	local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor)
	module3.CloseTransmissions()
	v3 = p
	local __wf_atom_d2b2176d = v3:__wf_atom_d2b2176d()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(startCinTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsA(__wf_atom_804af126) then
		__wf_atom_0a6a5887:SetInstigatorAvatar(p)
	end

	if not __wf_atom_7e8ad928(relatedQuests) and module.QuestIsActive(relatedQuests) then
		module.ForceCompleteQuest(relatedQuests)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(ancestorNPCTag)

	if isTrackedDest and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		module5.RemoveSparrowDestination(__wf_atom_0a6a5887_2)
	end

	if
		not __wf_atom_7e8ad928(Resource(questType))
		and (__wf_atom_7e8ad928(localPlayerAncestorOfType) or not module.TaggedTaskIsActive(
			Resource(questType),
			activeQuestTaskTag
		))
	then
		__wf_atom_d2b2176d:Unequip(0, 0)

		while not __wf_atom_7e8ad928(v3) and not v3:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
			Sleep(0)
		end

		module.StartQuest(Resource(questType))
	end
end

local function fn3()
	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(notUnlockedSetupForwarder) then
			notUnlockedSetupForwarder:FirePort("TriggerPort")
		end

		for _, v4 in ipairs(encounterhintsToOverride) do
			if not v4:IsEnabled() then
				continue
			end

			module10.SetMissionEncounterAllowed(v4, overrideMissionEncounterAllowed)
			module10.SetEncounterChillout(v4, shouldChilloutEncounter)
			module10.SetEncounterHeaviesBlocked(v4, blockHeaviesInEncounter)
			v4:__wf_atom_252fae6e(agentLevelOverride)
		end

		for _, v4 in ipairs(blockTalesAtHints) do
			if not __wf_atom_7e8ad928(v4) then
				module10.SetMissionEncounterAllowed(v4, false)
			end
		end
	end
end

function CheckToEnableQuestStart(_)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if module.QuestIsActive(questType) then
		if not __wf_atom_7e8ad928(notUnlockedSetupForwarder) then
			notUnlockedSetupForwarder:FirePort("TriggerPort")
		end

		fn3()
	else
		module4.GetLocalPlayerAncestorOfType(targetAncestor)

		if __wf_atom_7e8ad928(preRecQuest) or module.HasCompletedQuest(preRecQuest) then
			if
				module.HasCompletedQuest(questType)
				and gRegion:IsMaster()
				and not __wf_atom_7e8ad928(unlockedSetupForwarder)
			then
				unlockedSetupForwarder:FirePort("TriggerPort")
			elseif gRegion:IsMaster() then
				if not __wf_atom_7e8ad928(notUnlockedSetupForwarder) then
					notUnlockedSetupForwarder:FirePort("TriggerPort")
				end

				fn3()
			end
		else
			unlockedSetupForwarder:FirePort("TriggerPort")
		end

		_T.ForgeAmbiantDialougePlayed = false
	end
end

function CinematicAncestorIntroduction(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(startCinTag)
	module6.UpdateOrAddHudTask(mOwner, p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if __wf_atom_0a6a5887:IsA(__wf_atom_804af126) then
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(awakenAncestorTriggerTag)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				local v4

				if __wf_atom_0a6a5887_2:IsA(__wf_atom_0f45538d) then
					v4 = __wf_atom_0a6a5887_2:__wf_atom_ae2c2cee()
				else
					v4 = __wf_atom_0a6a5887_2:__wf_atom_fdb586e3()
				end

				if not __wf_atom_7e8ad928(v4) then
					__wf_atom_0a6a5887:SetInstigatorAvatar(v4)
				end
			end
		end

		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while
			not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
			and __wf_atom_0a6a5887:__wf_atom_7d4910e4()
			and not __wf_atom_0a6a5887:__wf_atom_e9546dc6()
		do
			Sleep(0)
		end

		if module.CanCompleteTask(mOwner) then
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

function SimpleAncestorIntroduction(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(ancestorNPCTag)
	interactDeco = gRegion:__wf_atom_0a6a5887(soulDeco)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Cannot find tagged npc instance in level")
		return
	end

	module6.UpdateOrAddHudTask(mOwner, p)

	if forceJournalTrackQuest then
		module.TrackQuest(mOwner)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("NavBridgeToOrlickOffice"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("Disable")
	end

	if isTrackedDest and sparrowDestId ~= EMPTY_SYMBOL then
		module5.AddSparrowDestination(
			__wf_atom_0a6a5887,
			nil,
			tostring(sparrowDestId),
			module5.PRIORITY.QUEST,
			nil,
			mOwner
		)
	end

	while true do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			break
		end

		if
			__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
			or not (__wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) <= 5)
		then
			Sleep(0.5)
		else
			local v4

			if gRegion:IsMaster() then
				v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(
					__wf_atom_0a6a5887,
					agentPauseRadiusFromAncestor,
					true
				)

				for _, v5 in ipairs(v4) do
					if not __wf_atom_7e8ad928(v5) then
						v5:SetPaused(true, pauseAgentSym)
					end
				end
			end

			Sleep(0.5)

			if __wf_atom_7e8ad928(interactDeco) then
				module4.DissolveIn(__wf_atom_0a6a5887, nil, dissolveInAudioTag)
			else
				module4.DissolveIn(__wf_atom_0a6a5887, interactDeco:GetPosition(), dissolveInAudioTag)
			end

			fn(ancestorTransmissionSet, ancestorTransmissionTags, 0, true)
			module.CompleteTaskWithID(mOwner, p)

			for _, v5 in ipairs(v4) do
				if not __wf_atom_7e8ad928(v5) then
					v5:SetPaused(false, pauseAgentSym)
				end
			end

			break
		end
	end
end

function EnableInviteToNightfoldContextAction(p)
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

	module6.UpdateOrAddHudTask(mOwner, p)
	module5.AddSparrowDestination(__wf_atom_0a6a5887_2, nil, nil, module5.PRIORITY.QUEST, nil, mOwner, p)
end

local function fn4(targetAncestor)
	local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor, true)

	if not __wf_atom_7e8ad928(localPlayerAncestorOfType) then
		local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			__wf_atom_330f77f5:__wf_atom_b4984563(
				v,
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

function InviteToNightFold(object, _)
	local ancestorNPCInstance = ancestorNPCInstance
	local v4 = not __wf_atom_7e8ad928((module4.GetLocalPlayerAncestorOfType(targetAncestor, true)))

	if not v4 then
		gGameData:RankUpAncestor(
			targetAncestor,
			module8.Ternary(reconnectToIRC, "OnAncestorCallbackReconnectToIRC", "OnAncestorCallback")
		)
	end

	module.CompleteTaskWithTag(Resource(questType), Symbol("InviteToNightfold"))
	object:Disable()
	print("RegisterPreventNighfoldUsage V")
	module9.RegisterPreventNighfoldUsage(true)

	if not __wf_atom_7e8ad928(ancestorTransmissionSet) then
		fn(ancestorTransmissionSet, ancestorTransmissionTags, 0)
	end

	if ancestorNPCInstance:IsA(__wf_atom_8d0b7f88) then
		module4.DissolveOut(ancestorNPCInstance)
	end

	module9.RegisterPreventNighfoldUsage(false)
	ancestorNPCInstance:SetVisibility(false)
	GiveLoreDrop()

	if not v4 then
		fn4(targetAncestor)
	end
end

function InviteToNightFoldWithCin(object, object2)
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

	local v4 = not __wf_atom_7e8ad928((module4.GetLocalPlayerAncestorOfType(targetAncestor, true)))
	object:Disable()
	module9.RegisterPreventNighfoldUsage(true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NavBridgeToOrlickOffice"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Disable")
	end

	local v5

	if gRegion:IsMaster() then
		v5 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(
			object,
			agentPauseRadiusFromAncestor,
			true
		)

		for _, v6 in ipairs(v5) do
			if not __wf_atom_7e8ad928(v6) then
				v6:SetPaused(true, pauseAgentSym)
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

	module9.RegisterPreventNighfoldUsage(false)
	ancestorNPCInstance:SetVisibility(false)

	if module.CanCompleteTask(Resource(questType)) then
		module.DestroyAreaMarker(ancestorNPCInstance)
		module6.CompleteAllHudTasks(questType, 5)
		module.CompleteTaskWithTag(Resource(questType), Symbol("InviteToNightfold"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Enable")
	end

	if gRegion:IsMaster() then
		for _, v6 in ipairs(v5) do
			if not __wf_atom_7e8ad928(v6) then
				v6:SetPaused(false, pauseAgentSym)
			end
		end
	end

	if not v4 then
		fn4(targetAncestor)
	end
end

function StartNewRank(p)
	if __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(ancestorNPCTag))) then
		return
	end

	fn(ancestorTransmissionSet, ancestorTransmissionTags, 0)
	module.CompleteTaskWithID(mOwner, p)
end

function EndRank(p)
	module2.WaitToEnterNightfold()

	if __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(ancestorNPCTag))) then
		return
	end

	fn(ancestorTransmissionSet, ancestorTransmissionTags, 0)
	module.CompleteTaskWithID(mOwner, p)
end

function TriggerGhostlyWispers(object)
	if playLocally then
		if _T.ForgeAmbiantDialougePlayed == false or module.QuestIsActive(Resource(questType)) == false then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			module3.PlayLocalTransmission(
				ancestorTransmissionSet,
				ancestorTransmissionTags[1],
				__wf_atom_c4f78a8f,
				true
			)

			while module3.TransmissionPlaying() do
				Sleep(0)
			end

			object:Disable()
			_T.ForgeAmbiantDialougePlayed = true
		end
	elseif module.QuestIsActive(Resource(questType)) == true then
		module3.PlayGlobalTransmission(ancestorTransmissionSet, ancestorTransmissionTags[1], true)

		while module3.TransmissionPlaying() do
			Sleep(0)
		end

		object:Disable()
	end
end

function TriggerGhostlyWispersSimple(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if playOnlyWhenQuestActive and module.QuestIsActive(Resource(questType)) == false then
		return
	end

	module3.PlayLocalTransmission(ancestorTransmissionSet, ancestorTransmissionTags[1], __wf_atom_c4f78a8f, true)

	while module3.TransmissionPlaying() do
		Sleep(0)
	end

	object:Disable()
end

function CreatePathToAncestor(object)
	if __wf_atom_7e8ad928(pathTrailEffect) then
		print("No trail effect created")
		return
	end

	pathTrailEffect:__wf_atom_a64eca67(object:GetPosition())
	pathTrailEffect:__wf_atom_c709edee(225)

	if not (#pathTrailEffect:__wf_atom_7df70ec2() > 0) then
		print("AnimalTrail: Failed - zero length path")
		return
	end

	local __wf_atom_f2f158da = pathTrailEffect:__wf_atom_f2f158da()
	pathTrailEffect:__wf_atom_7cbad21b((math.floor(__wf_atom_f2f158da / distanceBetweenFootprints)))
	pathTrailEffect:__wf_atom_fa550593()
end

function CraftWeaponsRankUpTask(p)
	local function fn5()
		local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor)

		if not localPlayerAncestorOfType then
			return 0
		end

		local count = #localPlayerAncestorOfType.mCompletedRecipes

		if craftingRequirement <= count then
			module.CompleteTaskWithID(mOwner, p)
			_T.Ancestor_PendingRankUp = true
			return 1
		else
			return (math.max(0, count / craftingRequirement))
		end
	end

	if not _T.Foundry_GetRankXP then
		_T.Foundry_GetRankXP = {}
	end

	_T.Foundry_GetRankXP[targetAncestor:__wf_atom_5b41f63b()] = fn5
end

function RankOneEndTask(_)
	local function fn5()
		if module4.GetAncestorRank(targetAncestor, true) == 0 then
			_T.Ancestor_PendingRankUp = true
		end

		return 1
	end

	if not _T.Foundry_GetRankXP then
		_T.Foundry_GetRankXP = {}
	end

	_T.Foundry_GetRankXP[targetAncestor:__wf_atom_5b41f63b()] = fn5
end

function RankOneQuestFinished()
	if _T.Foundry_GetRankXP then
		_T.Foundry_GetRankXP[targetAncestor:__wf_atom_5b41f63b()] = nil

		if not next(_T.Foundry_GetRankXP) then
			_T.Foundry_GetRankXP = nil
		end
	end
end

function OnAncestorCallbackReconnectToIRC()
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

	if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
		__wf_atom_7190444e:__wf_atom_239e1070(true)
	end

	OnAncestorCallback()
end

function OnAncestorCallback()
	v2 = true
end

function DiscoverWanderingAncestor()
	if __wf_atom_7e8ad928(targetAncestor) then
		return
	end

	local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor)

	if localPlayerAncestorOfType then
		if #itemRewards ~= 0 and allowSubsiquentRewards then
			GiveItemReward()
		end

		if allowExtraloreDrops and #loreDropsRewards ~= 0 then
			GiveLoreDrop()
		end
	else
		if #loreDropsRewards ~= 0 then
			GiveLoreDrop()
		end

		if #itemRewards ~= 0 then
			GiveItemReward()
		end

		if #upgradeRewards ~= 0 then
			GiveUpgradeRewards()
		end

		fn2(experienceReward)
		Sleep(0)
		gGameData:RankUpAncestor(targetAncestor, "OnAncestorCallback")

		if not localPlayerAncestorOfType then
			fn4(targetAncestor)
		end
	end
end

function TutorialItemReady(p, p2)
	if not p then
		return
	end

	local v4 = Resource(p2)

	if __wf_atom_7e8ad928(v4) then
		return
	end

	local locForAction = module7.GetLocForAction("CONSUMABLES", nil, false, false, false)
	local locForAction2 = module7.GetLocForAction("SELECT", nil, false, true, true)
	local locString = Localize(v4:__wf_atom_3a3d2e39():c_str(), nil)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = locString
	dialogSettings.titleString = v4:__wf_atom_014a76a2():c_str()
	dialogSettings.icon = v4:__wf_atom_5b41f63b() .. ",100,100"
	module8.ShowCustomMessage(dialogSettings):Execute(
		"SetCallout",
		Localize(tutPrompt, { CONSUMABLES = locForAction, SELECT = locForAction2 })
	)
end

local function fn5() -- 1 equivalent call inferred from this helper
	local v4 = WeakResource("/SF/StoreItems/Types/Items/Consumables/VerminiaPotion")
	gGameRules:RequestResource(v4:__wf_atom_5b41f63b(), "TutorialItemReady")
end

function GiveQuestRewards(p)
	print("GiveQuestRewards START")
	module2.WaitForLoginSequence()
	module2.WaitForLevel()

	if disableNightfold then
		print("RegisterPreventNighfoldUsage X")
		module9.RegisterPreventNighfoldUsage(true)
	end

	local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

	while
		not __wf_atom_7e8ad928(__wf_atom_330f77f5) and __wf_atom_330f77f5:__wf_atom_aaf836a8()
		or __wf_atom_8e4fda44:FindMovie(v)
	do
		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(ancestorTransmissionSet) and #ancestorTransmissionTags >= 1 then
		module3.PlayLocalTransmission(ancestorTransmissionSet, ancestorTransmissionTags[1], __wf_atom_c4f78a8f, false)
		Sleep(rewardAfterAuidoDelay)
	end

	if #loreDropsRewards ~= 0 then
		GiveLoreDrop()
	end

	if #itemRewards ~= 0 then
		GiveItemReward()
	end

	if #upgradeRewards ~= 0 then
		GiveUpgradeRewards()
	end

	if not __wf_atom_7e8ad928(itemRewardsBundle) then
		GiveStoreBundleReward()
	end

	if experienceReward > 0 then
		fn2(experienceReward)
	end

	if showTutPopUp then
		Sleep(6)
		fn5() -- inferred equivalent call
	else
		Sleep(2)
	end

	if disableNightfold then
		module9.RegisterPreventNighfoldUsage(false)
	end

	if questType ~= nil then
		module.SetLocalPlayerReady(questType, p)

		while not module.AllPlayersReady(questType, p) do
			Sleep(0)
		end
	end

	print("GiveQuestRewards END")

	if module.CanCompleteTask(mOwner) then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function AncestorRankUpQuestXP(p)
	local function fn6()
		local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(targetAncestor)

		if not localPlayerAncestorOfType then
			return 0
		end

		if not module4.CheckForPendingRankUpFromXP(Resource(targetAncestor)) then
			return localPlayerAncestorOfType.mXP, false
		end

		module.CompleteTaskWithID(mOwner, p)
		_T.Ancestor_PendingRankUp = true
		return 1, true
	end

	if not _T.Foundry_GetRankXP then
		_T.Foundry_GetRankXP = {}
	end

	_T.Foundry_GetRankXP[targetAncestor:__wf_atom_5b41f63b()] = fn6
end