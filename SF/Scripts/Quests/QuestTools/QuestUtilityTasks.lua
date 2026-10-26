local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Interface.SFUtilities")
local v = Type("/SF/Types/Quests/QuestTools/GoToLocationTaskTrigger")
local v2 = nil
local v3 = false
local v4 = nil

local function fn(object)
	if object:__wf_atom_7be51ede():__wf_atom_4417a5d4() or allowMultiplayer then
		object:Disable()
		v3 = true
	end
end

local function fn2(object, questReplicationMode)
	local v5 = v2
		or gRegion:CreateEntity(v, object:GetPosition(), object:__wf_atom_dc309f8a(), nil, nil, questReplicationMode)

	if __wf_atom_7e8ad928(v5) then
		return
	end

	v5:Enable()
	__wf_atom_55142dd4(v5, "OnTouched", fn)

	while not v3 do
		if
			not __wf_atom_7e8ad928(_T.ForceGotToCompletedTrigger)
			and _T.ForceGotToCompletedTrigger:__wf_atom_db682341() == v5:__wf_atom_db682341()
		then
			break
		end

		Sleep(0.5)
	end
end

function UtitlityTaskCreateEnocunterAtLocation(_)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	local questReplicationMode = module.GetQuestReplicationMode(mOwner)

	if proximityTriggerTag ~= EMPTY_SYMBOL then
		v2 = gRegion:__wf_atom_0a6a5887(proximityTriggerTag)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(encounterPostionWaypointTag)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(parentHintTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	fn2(nil, questReplicationMode)

	if gRegion:IsMaster() then
		v4 = module2.WaitForAiDir()
		v4:AddEncounter(specificEncounterType)
		v4:__wf_atom_c4c644af(__wf_atom_0a6a5887:GetPosition(), specificEncounterType, __wf_atom_0a6a5887_2)
	end
end

function UtilityTaskSetSoloPlayerMode(_)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if soloModeEnabled then
		if gRegion:IsMaster() then
			module3.DisbandMultiplayer()
			Sleep(1)

			if not module3.GetIsBlockingPartyInvites() then
				module3.SetSoloPlayerMode(true)
			end
		else
			if not module3.GetIsBlockingPartyInvites() then
				module3.SetSoloPlayerMode(true)
			end

			if waitToLeaveNightfold then
				module2.WaitToExitNightfold()
			end

			module3.DisbandMultiplayer()
		end
	else
		module3.SetSoloPlayerMode(false)
	end
end