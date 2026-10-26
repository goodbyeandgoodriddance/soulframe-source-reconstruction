local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Interface.SFUtilities")
local v = nil
local v2 = nil
local v3 = Type("/SF/Types/Quests/QuestTools/GoToLocationTaskTrigger")
local v4 = nil
local v5 = false

local function fn()
	if not __wf_atom_7e8ad928(portForwardersByTag) and #portForwardersByTag > 0 then
		for _, v6 in ipairs(portForwardersByTag) do
			module2.TaggedFirePorts(Symbol(v6), "TriggerPort")
		end
	end
end

local function fn2()
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(levelTagsToStream) and #levelTagsToStream > 0 then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.taggedLevelTags = levelTagsToStream
		Engine.StreamRegion(levelArgs)

		if entityTagToCheckForLayerLoaded ~= EMPTY_SYMBOL and entityTagToCheckForLayerLoaded ~= nil then
			while __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(entityTagToCheckForLayerLoaded))) do
				Sleep(0)
			end
		end
	end
end

local function fn3()
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(levelTagsToStream) and #levelTagsToStream > 0 then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.taggedLevelTags = levelTagsToStream
		levelArgs.isAutonomous = isAutonomous
		Engine.__wf_atom_94cafc05(levelArgs)
	end
end

local function fn4(object)
	if object:__wf_atom_7be51ede():__wf_atom_4417a5d4() or allowMultiplayer then
		object:Disable()
		v5 = true
	end
end

local function fn5(object, questReplicationMode)
	local v6 = v4
		or gRegion:CreateEntity(v3, object:GetPosition(), object:__wf_atom_dc309f8a(), nil, nil, questReplicationMode)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	v6:Enable()
	__wf_atom_55142dd4(v6, "OnTouched", fn4)

	while not v5 do
		if
			not __wf_atom_7e8ad928(_T.ForceGotToCompletedTrigger)
			and _T.ForceGotToCompletedTrigger:__wf_atom_db682341() == v6:__wf_atom_db682341()
		then
			break
		end

		Sleep(0.5)
	end
end

function QuestStateSet(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	v2 = tostring(mOwner) .. " is active."
	fn()
	fn2()

	if not __wf_atom_7e8ad928(p) then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function QuestCleanup(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	v2 = tostring(mOwner) .. " is completed."
	fn()
	fn3()

	if not __wf_atom_7e8ad928(p) then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function ActiveQuestStateSet()
	if
		module.HasCompletedQuest(questType)
		or not module.QuestIsActive(questType)
		or (__wf_atom_7e8ad928(questType) or __wf_atom_7e8ad928(portForwardersByTag))
	then
		return
	end

	v2 = tostring(questType) .. " is active."
	fn()
	fn2()
end

function ActiveTaskStateSet()
	Sleep(1)

	if module.HasCompletedQuest(questType) or not module.QuestIsActive(questType) then
		return
	end

	if __wf_atom_7e8ad928(questType) or __wf_atom_7e8ad928(portForwardersByTag) or __wf_atom_7e8ad928(taskTags) then
		return
	end

	for _, v6 in ipairs(taskTags) do
		if not module.TaggedTaskIsActive(questType, v6) then
			continue
		end

		v2 = tostring(v6) .. " is active."
		fn()
		break
	end
end

function PostQuestStateSet()
	if not module.HasCompletedQuest(questType) or module.QuestIsActive(questType) then
		return
	end

	if not __wf_atom_7e8ad928(globalEncounterTagsToAddToAIDirector) then
		v = module2.WaitForAiDir()

		for _, v6 in ipairs(globalEncounterTagsToAddToAIDirector) do
			v:__wf_atom_25131806(v6)
		end
	end

	if __wf_atom_7e8ad928(questType) or __wf_atom_7e8ad928(portForwardersByTag) then
		return
	end

	v2 = " is complete."
	fn()
end

function QuestNotStartedStateSet()
	if not (module.QuestIsActive(questType) or module.HasCompletedQuest(questType)) then
		if __wf_atom_7e8ad928(questType) or __wf_atom_7e8ad928(portForwardersByTag) then
			return
		end

		v2 = " has not started."
		fn()

		if not __wf_atom_7e8ad928(globalEncounterTagsToAddToAIDirector) then
			v = module2.WaitForAiDir()

			for _, v6 in ipairs(globalEncounterTagsToAddToAIDirector) do
				v:__wf_atom_25131806(v6)
			end
		end
	end
end

function LoadLevelByRegionId(_)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	local questReplicationMode = module.GetQuestReplicationMode(mOwner)

	if proximityTriggerTag ~= EMPTY_SYMBOL then
		v4 = gRegion:__wf_atom_0a6a5887(proximityTriggerTag)

		if __wf_atom_7e8ad928(v4) then
			print("UtilitiyTaskStreamInLevelRegion: There is no proximity trigger, level will not be streamed in for this quest.")
			return
		else
			fn5(nil, questReplicationMode)
		end
	end

	local v6 = module2.AddStreamedLevelOffSetVector(worldOffSetVector)
	module2.StreamInLevelRegion(streamedInLevelWeakRes, nil, v6, streamingLayerIdx, isAutonomous, nil)
end

function UnloadLevelByRegionId(_)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module2.StreamOutLevelRegion(streamingLayerIdx)
end

function StreamInLevelRegionWhenSP(taskId)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	local questReplicationMode = module.GetQuestReplicationMode(mOwner)

	if proximityTriggerTag ~= EMPTY_SYMBOL then
		v4 = gRegion:__wf_atom_0a6a5887(proximityTriggerTag)

		if __wf_atom_7e8ad928(v4) then
			print("UtilitiyTaskStreamInLevelRegion: There is no proximity trigger, level will not be streamed in for this quest.")
			return
		else
			fn5(nil, questReplicationMode)
		end
	end

	local v6 = module2.AddStreamedLevelOffSetVector(worldOffSetVector)

	if __wf_atom_7e8ad928(_T.StreamedInQuestLevels) then
		_T.StreamedInQuestLevels = {}
	end

	for _, streamedInQuestLevel in pairs(_T.StreamedInQuestLevels) do
		if streamedInQuestLevel.taskId == taskId and streamedInQuestLevel.IsStreamedIn == true then
			return
		end
	end

	while module2.IsInMultiplayerSession() do
		Sleep(0.5)
	end

	local streamInLevelRegion = module2.StreamInLevelRegion(
		streamedInLevelWeakRes,
		nil,
		v6,
		streamingLayerIdx,
		isAutonomous,
		nil
	)
	table.insert(_T.StreamedInQuestLevels, {
		Quest = mOwner,
		TaskId = taskId,
		StreamedLevel = streamedInLevelWeakRes,
		IsStreamedIn = streamInLevelRegion
	})
end

function HideTaggedEntities()
	if #entityTags > 0 then
		for _, v6 in ipairs(entityTags) do
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v6)

			for _, v7 in ipairs(__wf_atom_2226b35c) do
				v7:SetVisibility(false)

				if destroyEntities == true then
					v7:Destroy()
				end
			end
		end
	end
end

function LoadTaggedLevels(p, p2)
	levelTagsToStream = p
	entityTagToCheckForLayerLoaded = p2
	fn2()
end

function UnloadTaggedLevels(p)
	levelTagsToStream = p
	isAutonomous = false
	fn3()
end