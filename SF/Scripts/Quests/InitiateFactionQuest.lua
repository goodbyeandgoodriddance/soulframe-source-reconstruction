local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local v = Resource("/SF/Interface/NewConversationMenu.swf")
local v2 = nil

function AlreadyInitiated(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

	if __wf_atom_0cbd9965 ~= Symbol("") and gGameData:__wf_atom_51dd1b95(__wf_atom_0cbd9965).mInitiated then
		print("Initiate Faction Quest early bail - Already Initiated")
		module.CompleteTaskWithID(mOwner, p)
	end
end

function AllSyndicatesInitiated(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local mInitiated = false

	while not mInitiated do
		Sleep(2)
		mInitiated = true

		for _, v3 in ipairs(allSyndicates) do
			local v4 = Resource(v3)

			if __wf_atom_7e8ad928(v3) then
				mInitiated = false
			else
				local __wf_atom_e0f044e1 = v4:__wf_atom_e0f044e1()
				local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(__wf_atom_e0f044e1)
				mInitiated = mInitiated and __wf_atom_51dd1b95.mInitiated
			end
		end
	end

	module.CompleteTaskWithID(mOwner, p)
end

function IsSupportedSyndicateInitiated()
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()
	local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(__wf_atom_0cbd9965)

	if not __wf_atom_7e8ad928(__wf_atom_51dd1b95) then
		return __wf_atom_51dd1b95.mInitiated
	end

	print("IsSupportedSyndicateInitiated - No affiliation found for " .. tostring(__wf_atom_0cbd9965))
	return false
end

function SupportedSyndicateInitiatedTask(p)
	if IsSupportedSyndicateInitiated() then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function PledgeToSyndicateTask(p)
	print("PledgeToSyndicateTask Start " .. tostring(p))
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v3 = Resource(syndicate)
	local showOnHudTracker = showOnHudTracker

	if showOnHudTracker then
		module2.UpdateOrAddHudTask(mOwner, p)
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()
	local __wf_atom_e0f044e1 = v3:__wf_atom_e0f044e1()

	while __wf_atom_0cbd9965 ~= __wf_atom_e0f044e1 do
		Sleep(2)

		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		__wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

		if not (showOnHudTracker and __wf_atom_0cbd9965 ~= __wf_atom_e0f044e1 and __wf_atom_0cbd9965 ~= EMPTY_SYMBOL) then
			continue
		end

		module2.RemoveHudTask(mOwner, nil, p)
		showOnHudTracker = false
	end

	if IsSupportedSyndicateInitiated() then
		Sleep(2)
	end

	if showOnHudTracker then
		module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
	end

	print("PledgeToSyndicateTask END " .. tostring(p))
	module.CompleteTaskWithID(mOwner, p)
end

function GoToSyndicateHub(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if IsSupportedSyndicateInitiated() then
		Sleep(2)
	end

	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	if
		(__wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) or not module3.HasStreamedLevel(syndicateHubLevel))
		and not module3.IsInOverworld()
	then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(syndicateHubMidrathWp)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	module.TrackQuest(mOwner)
	module4.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p, Range(10, 3.4028234663852886e38))
	module2.UpdateOrAddHudTask(mOwner, p)
	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	while
		__wf_atom_7e8ad928(playerAvatar)
		or not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and playerAvatar:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) > 15
	do
		__wf_atom_eab484a7 = __wf_atom_eab484a7 or gRegion:__wf_atom_eab484a7()

		if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			return
		end

		if __wf_atom_7e8ad928(playerAvatar) then
			playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
		end

		if CheckForHubKey() then
			break
		else
			Sleep(0.5)
		end
	end

	if CheckForHubKey() == false then
		module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
		module2.UpdateOrAddHudTask(mOwner, p, secondTaskStepLoc)
	end

	while CheckForHubKey() == false do
		Sleep(0.5)
	end

	while not (__wf_atom_7e8ad928(__wf_atom_8e4fda44) or __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(v))) do
		Sleep(1)
	end

	module.TrackQuest(mOwner)
	module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
	Sleep(module2.COMPLETETIME)
	module.CompleteTaskWithID(mOwner, p)
end

function GoToLeaderAndInitiateFaction(p)
	print("GoToLeaderAndInitiateFaction Start " .. tostring(p))
	Sleep(module2.COMPLETETIME)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v3

	if module3.IsInOverworld() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(syndicateHubMidrathWp)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		else
			v3 = gRegion:__wf_atom_f738b4af(entranceTag, __wf_atom_0a6a5887:GetPosition(), 0, 100) or __wf_atom_0a6a5887
		end
	else
		v3 = gRegion:__wf_atom_0a6a5887(leaderNpcTag)
		module.TrackQuest(mOwner)
	end

	module2.UpdateOrAddHudTask(mOwner, p)
	module4.AddQuestDestination(v3, mOwner, p, Range(1, 3.4028234663852886e38))
	print("GoToLeaderAndInitiateFaction Begin wait for IsSupportedSyndicateInitiated")

	while not IsSupportedSyndicateInitiated() do
		Sleep(1)
	end

	while not (__wf_atom_7e8ad928(__wf_atom_8e4fda44) or __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(v))) do
		Sleep(1)
	end

	print("GoToLeaderAndInitiateFaction COMPLETED wait for IsSupportedSyndicateInitiated, cleaning up")
	module4.RemoveQuestDestinations(mOwner, p)
	module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
	Sleep(module2.COMPLETETIME)
	module.CompleteTaskWithID(mOwner, p)
	print("GoToLeaderAndInitiateFaction DONE")
end

function InitiateFaction(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	print("inititating with faction")
	local __wf_atom_e0f044e1 = Resource(syndicate):__wf_atom_e0f044e1()
	gGameData:__wf_atom_1e0d81b6(__wf_atom_e0f044e1, 0, "OnSacrificeResult")
	module.CompleteTaskWithID(mOwner, p)
end

function OnSacrificeResult(_, _) end

function CheckForHubKey()
	if __wf_atom_7e8ad928(doorKeylore) then
		return false
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return false
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return false
	end

	return playerAvatar:__wf_atom_d2b2176d():__wf_atom_705a2744(doorKeylore, memorySym)
end

function OpenHubEntranceCheck(instance, object)
	if __wf_atom_7e8ad928(doorKeylore) or not __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		return true
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v3 in ipairs(__wf_atom_3c8e1a7a) do
		if not v3:IsLocal() then
			continue
		end

		local playerAvatar = v3:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() then
			continue
		end

		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if
			__wf_atom_7e8ad928(__wf_atom_d2b2176d)
			or not __wf_atom_d2b2176d:__wf_atom_705a2744(doorKeylore, memorySym)
		then
			continue
		end

		if instance:IsA(__wf_atom_8dae4ec6) and v3:IsA(__wf_atom_c9cec0ec) then
			instance:__wf_atom_411d235d(v3)
		end

		return true
	end

	if not gRegion:IsMaster() then
		return false
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if
		instance:IsA(__wf_atom_8dae4ec6)
		and not __wf_atom_a96eb2aa:IsLocal()
		and instance:__wf_atom_f8fab1c0(__wf_atom_a96eb2aa)
	then
		return true
	end

	return false
end

function ReverseOpenHubEntranceCheck(p, p2)
	return not OpenHubEntranceCheck(p, p2)
end

function EnableHubTask(_)
	if __wf_atom_7e8ad928(doorKeylore) then
		return true
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = module3.WaitForAiDir()
	end

	local playerAvatar = gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	if playerAvatar:__wf_atom_d2b2176d():__wf_atom_705a2744(doorKeylore, memorySym) then
		if not __wf_atom_7e8ad928(setupHubDoorTaskPortForwaderDelete) then
			setupHubDoorTaskPortForwaderDelete:FirePort("TriggerPort")
		end
	else
		setupHubDoorTaskPortForwader:FirePort("TriggerPort")

		if not (__wf_atom_7e8ad928(hintTag) or __wf_atom_7e8ad928(missionTag)) then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(hintTag)

			if not gRegion:IsMaster() then
				return
			end

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Enable()
				Sleep(0)
				v2:PrimeMissionOnHint(missionTag, __wf_atom_0a6a5887)
			end
		end
	end
end

function HasCompletedQuest(p, p2)
	if p2 then
		return module.HasPersonalCompletedQuest(p)
	end

	return module.HasCompletedQuest(p)
end

function WaitForQuest(p)
	module3.WaitForLoginSequence()
	local v3 = true
	local v4 = false

	while not HasCompletedQuest(questToWaitFor, personalCompletion) do
		Sleep(2)
		v3 = false
		v4 = true
	end

	if not v3 and extraDelayAfterQuestCompletion > 0 then
		Sleep(extraDelayAfterQuestCompletion)
		v4 = true
	end

	if not v4 then
		Sleep(5)
	end

	module.CompleteTaskWithID(mOwner, p)
end