module(..., package.seeall)
local module = require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("Lotus.Scripts.Libs.AbilitiesLib")
local module5 = require("SF.Scripts.NightFoldLib")
local v = Type("/SF/Types/Game/MarkerInfos/SparrowAreaQuestMarkerInfo")
local v2 = {
	Default = Type("/SF/Types/Quests/PlayerProgressionCelebrations/QuestCompletionSparrowCinematic"),
	ChampionSyndicate = Type("/SF/Types/Quests/PlayerProgressionCelebrations/EndOfMissionChampionCinematic"),
	SilentRoseSyndicate = Type("/SF/Types/Quests/PlayerProgressionCelebrations/EndOfMissionSaboteurCinematic"),
	FeySyndicate = Type("/SF/Types/Quests/PlayerProgressionCelebrations/EndOfMissionWardSparrowCinematic")
}
local v3 = false
local v4 = Resource("/SF/Sounds/Dialog/TransmissionSets/EmpressWispersTransmissionSet")
local v5 = Symbol("NightfoldWakeUp")
local v6 = Resource("/SF/Animations/Player/Contextual/Zipline/ArmHangLoop_anim.fbx")
local v7 = Type("/SF/Types/Gameplay/TeleportPlayersHereInstantlyScriptTrigger")

local function fn(level)
	local v8 = "Loading Level " .. level:__wf_atom_5b41f63b() .. "..."
	print(v8)

	if not __wf_atom_7e8ad928(level) then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.level = level
		levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
		levelArgs.gameRules = gClient:__wf_atom_2aee259b()
		levelArgs.hostingMultiplayer = false
		levelArgs.restartLevel = false
		Engine.OpenLevel(levelArgs)
	end
end

local function fn2() -- 2 equivalent calls inferred from this helper
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return
	else
		return questController:GetActiveQuests()
	end
end

local function fn3() -- 1 equivalent call inferred from this helper
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return
	else
		return questController:GetInactiveQuests()
	end
end

local function fn4()
	local result = fn2() or {} -- inferred equivalent call
	local v8 = fn3() -- inferred equivalent call

	for _, v9 in ipairs(v8) do
		table.insert(result, v9)
	end

	return result
end

local function fn5() -- 1 equivalent call inferred from this helper
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return
	else
		return questController:__wf_atom_6f96efc5()
	end
end

local function fn6() -- 1 equivalent call inferred from this helper
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return
	else
		return questController:__wf_atom_d1c9eff3()
	end
end

local function fn7()
	local result = fn5() or {} -- inferred equivalent call
	local v8 = fn6() -- inferred equivalent call

	for _, v9 in ipairs(v8) do
		table.insert(result, v9)
	end

	return result
end

local function fn8(p, p2)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:__wf_atom_d5cc4473(p, p2 or false)
end

local function fn9(list)
	local v8 = fn2() -- inferred equivalent call

	for _, v9 in ipairs(v8) do
		for _, v10 in ipairs(list) do
			if v9 == v10 then
				return true
			end
		end
	end

	return false
end

local function fn10(p, p2)
	if _G.devFakeQuestIncomplete then
		return false
	end

	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:__wf_atom_433ff74c(p, p2 or false)
end

local function fn11(p)
	if _G.devFakeQuestIncomplete then
		return false
	end

	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:__wf_atom_433ff74c(p, true)
end

local function fn12(list)
	if _G.devFakeQuestIncomplete then
		return false
	end

	if __wf_atom_7e8ad928(list) or #list == 0 then
		return true
	end

	for i = #list, 1, -1 do
		if __wf_atom_7e8ad928(list[i]) then
			table.remove(list, i)
		end
	end

	if __wf_atom_7e8ad928(list) or #list == 0 then
		return true
	end

	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	local count = 0

	if __wf_atom_7e8ad928(questController) then
		return count == #list
	end

	local __wf_atom_62750b0b = questController:__wf_atom_62750b0b()

	for _, v8 in ipairs(list) do
		for _, v9 in ipairs(__wf_atom_62750b0b) do
			if v9 ~= v8 then
				continue
			end

			count += 1
			break
		end
	end

	return count == #list
end

local function fn13(className)
	local v8 = fn4()

	for _, v9 in ipairs(v8) do
		if v9:IsA(className) then
			return v9
		end
	end
end

local function fn14(className)
	local v8 = fn7()

	for _, v9 in ipairs(v8) do
		if v9:IsA(className) then
			return v9
		end
	end
end

local function fn15(p, p2)
	local v8 = fn13(p)
	local v9 = tostring(p2)

	if __wf_atom_7e8ad928(v8) then
		return false
	end

	local __wf_atom_bb972fd2 = v8:__wf_atom_bb972fd2()

	for _, v10 in ipairs(__wf_atom_bb972fd2) do
		if tostring(v10) ~= v9 then
			continue
		end

		local __wf_atom_23accb14 = v8:__wf_atom_23accb14(v10)

		if not __wf_atom_7e8ad928(__wf_atom_23accb14) then
			return __wf_atom_23accb14:IsActive()
		end
	end

	return false
end

local function fn16(p, p2)
	local v8 = fn14(p)
	local v9 = tostring(p2)

	if __wf_atom_7e8ad928(v8) then
		return false
	end

	local __wf_atom_bb972fd2 = v8:__wf_atom_bb972fd2()

	for _, v10 in ipairs(__wf_atom_bb972fd2) do
		if tostring(v10) == v9 then
			return true
		end
	end

	return false
end

local function fn17(object, p, value, p2)
	local _blockQuestStageCompletion = _G.BlockQuestStageCompletion
	local v8

	if __wf_atom_7e8ad928(p) then
		v8 = object:__wf_atom_23accb14(object:__wf_atom_bb972fd2()[1])
	elseif p2 then
		v8 = object:__wf_atom_f9a6a9ad(p)
	else
		v8 = object:__wf_atom_23accb14(Symbol(p))
	end

	local __wf_atom_db682341 = v8:__wf_atom_db682341()
	local v9 = "Completing quest task " .. object:GetName() .. " [" .. tostring(p) .. "] " .. tostring(__wf_atom_db682341) .. "..."
	print(v9)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if not __wf_atom_7e8ad928(questController) then
		if p2 then
			questController:CompleteTaskWithTag(object, p, value or "")
		elseif __wf_atom_7e8ad928(p) then
			questController:CompleteCurrentTask(object, value or "")
		else
			questController:CompleteTaskWithID(object, Symbol(p), value or "")
		end

		local v10 = "Completed quest task " .. object:GetName() .. " [" .. tostring(p) .. "] " .. tostring(__wf_atom_db682341)
		print(v10)
		module.RemoveQuestDestinations(object, (tostring(p)))
		OnQuestTaskCompleted(object)
	end
end

local function fn18()
	if __wf_atom_7e8ad928(gGameData) then
		return nil, nil
	end

	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	if v8 == nil then
		return nil, nil
	end

	return fn13(WeakResource(v8.mId)), v8
end

function GetQuestId(p)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	if type(p) == "string" then
		return p
	end

	if not p:IsA(__wf_atom_cce305dd) then
		return nil
	end

	if __wf_atom_1ef90898(p) then
		return p:__wf_atom_5b41f63b()
	end

	return p:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
end

local function fn19(p, p2, p3, p4)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if p3 or __wf_atom_7e8ad928(p) then
		local v8

		if not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

			for _, v9 in ipairs(__wf_atom_d10f2b47) do
				if v9.mId == "" then
					continue
				end

				v8 = v9
				break
			end
		end

		if v8 ~= nil then
			if v8.mType == p2 and v8.mId == p then
				return
			else
				_UntrackJournalEntry(v8.mId, v8.mType)
			end
		end

		if not __wf_atom_7e8ad928(p) and p2 ~= nil then
			local journalEntry = SF.JournalEntry(p2, p)
			gGameData:__wf_atom_615921da(journalEntry)
		end
	else
		local v8

		if not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

			for _, v9 in ipairs(__wf_atom_d10f2b47) do
				if v9.mId == "" then
					continue
				end

				v8 = v9
				break
			end
		end

		if v8 == nil and p2 ~= nil then
			local journalEntry = SF.JournalEntry(p2, p)
			gGameData:__wf_atom_615921da(journalEntry)
		end
	end

	if gRegion:IsMaster() then
		module.UpdateSparrowDestination(p4)
	end
end

function _UntrackJournalEntry(p, p2)
	if __wf_atom_7e8ad928(gGameData) or p == nil or p2 == nil then
		return
	end

	local journalEntry = SF.JournalEntry(p2, p)
	gGameData:__wf_atom_38fa4a7b(journalEntry)
end

local function fn20(object, p, value)
	if not __wf_atom_7e8ad928(gGameRules) then
		if __wf_atom_7e8ad928(object) then
			print("Couldn't start quest. The quest is nil!")
		else
			if not __wf_atom_7e8ad928((fn13(object))) then
				print("Couldn't start quest " .. object:__wf_atom_5b41f63b() .. " because it's already active!")
				return
			end

			local questController = gGameRules:GetQuestController()
			print("Starting quest " .. object:__wf_atom_5b41f63b())
			questController:StartQuest(object, p, value or "")
		end
	end
end

function StartQuest(p, p2)
	fn20(p, false, p2)
end

function StartQuestWithoutPrereqs(p, p2)
	fn20(p, true, p2)
end

function OnQuestStarted(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if IsAnythingTracked() then
		local name = Localize(Resource(p):__wf_atom_014a76a2():c_str(), false)
		local v8 = Localize("/SF/Language/Quests/QuestAddedToJournalImpactMessage", { NAME = name })

		if _T.ShowImpactMessage ~= nil then
			_T.ShowImpactMessage(v8, 3)
		end
	else
		fn19(GetQuestId(p), 0, false, nil)
	end
end

function OnQuestTaskCompleted(p)
	if __wf_atom_7e8ad928(p) then
	end
end

function CompleteTaskWithID(p, p2, p3)
	fn17(p, p2, p3)
end

function CompleteCurrentTask(p, p2)
	fn17(p, nil, p2)
end

function CompleteTaskWithTag(p, p2, p3)
	fn17(p, p2, p3, true)
end

function GetActiveQuests()
	return fn2()
end

function GetInactiveQuests()
	return fn3()
end

function GetAllAcceptedQuests()
	return (fn4())
end

function GetAllPersonalAcceptedQuests()
	return (fn7())
end

function GetQuestController()
	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		local questController = gGameRules:GetQuestController()

		if not __wf_atom_7e8ad928(questController) then
			return questController
		end

		print("Error: Null controller")
	end

	return nil
end

function GetAcceptedQuestFromType(p)
	return fn13(p)
end

function QuestIsActive(p, p2)
	return fn8(p, p2)
end

function AnyQuestIsActive(p)
	return (fn9(p))
end

function QuestIsAccepted(p)
	local v8 = fn4()

	for _, v9 in ipairs(v8) do
		if v9 == p then
			return true
		end
	end

	return false
end

function HasCompletedQuest(p, p2)
	return fn10(p, p2)
end

function HasPersonalCompletedQuest(p)
	return fn11(p)
end

function HasCompletedQuestsInList(p)
	return (fn12(p))
end

function IsPersonalQuestTaskInProgress(p, p2)
	return (fn16(p, p2))
end

function GetPersonalCompletedQuest(p)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return nil
	end

	local __wf_atom_484518ad = questController:__wf_atom_484518ad()

	for _, v8 in ipairs(__wf_atom_484518ad) do
		if v8:__wf_atom_1bb5b1ff() == p then
			return v8
		end
	end

	return nil
end

function GetQuestNodesData(instance)
	local result = {}

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_cce305dd) then
		return result
	end

	local v8 = instance:__wf_atom_bb972fd2() or {}
	local v9 = instance:__wf_atom_4507c88c() or {}
	local v10 = false

	for _, v11 in ipairs(v9) do
		v10 = v11.mActive == true or v10
		local mNodeIds = v11.mNodeIds or {}

		for _, mNodeId in ipairs(mNodeIds) do
			local __wf_atom_23accb14 = instance:__wf_atom_23accb14(mNodeId)

			if __wf_atom_7e8ad928(__wf_atom_23accb14) then
				continue
			end

			local mCompleted = false
			local flag = false

			if v10 and v11.mActive then
				mCompleted = true

				for _, v12 in ipairs(v8) do
					if mNodeId ~= v12 then
						continue
					end

					mCompleted = false
					flag = true
					break
				end
			elseif not (v10 or v11.mActive) then
				mCompleted = true
			end

			local __wf_atom_68085970 = __wf_atom_23accb14:__wf_atom_68085970()

			if not (__wf_atom_68085970 or mCompleted) then
				continue
			end

			local _EMPTY_SYMBOL = EMPTY_SYMBOL
			local __wf_atom_b2cbbf03 = instance:__wf_atom_b2cbbf03(mNodeId)
			local __wf_atom_3a3d2e39 = __wf_atom_23accb14:__wf_atom_3a3d2e39()
			local mHasSubtask = __wf_atom_b2cbbf03 ~= EMPTY_SYMBOL
				and __wf_atom_b2cbbf03 ~= __wf_atom_3a3d2e39
				and not mCompleted

			if #result > 0 and result[#result].mDescTag == __wf_atom_3a3d2e39 then
				result[#result].mCompleted = mCompleted

				if mHasSubtask then
					result[#result].mHasSubtask = true

					if result[#result].mOverrideTag == EMPTY_SYMBOL then
						result[#result].mOverrideTag = __wf_atom_b2cbbf03
					end
				end

				if flag then
					result[#result].mActive = true
				end
			elseif Localize(__wf_atom_3a3d2e39:c_str(), {}) ~= "" then
				table.insert(result, {
					mNode = __wf_atom_23accb14,
					mCompleted = mCompleted,
					mActive = flag,
					mDescTag = __wf_atom_3a3d2e39,
					mOverrideTag = __wf_atom_b2cbbf03,
					mVisible = (not v10 or v11.mActive or __wf_atom_68085970) and true or false,
					mHasSubtask = mHasSubtask
				})
			end
		end
	end

	return result
end

function TaggedTaskIsActive(p, p2)
	local v8 = fn13(p)

	if __wf_atom_7e8ad928(v8) then
		return false
	end

	local __wf_atom_bb972fd2 = v8:__wf_atom_bb972fd2()

	for _, v9 in ipairs(__wf_atom_bb972fd2) do
		local __wf_atom_23accb14 = v8:__wf_atom_23accb14(v9)

		if not __wf_atom_7e8ad928(__wf_atom_23accb14) and __wf_atom_23accb14:__wf_atom_db682341() == p2 then
			return __wf_atom_23accb14:IsActive()
		end
	end

	return false
end

function IsQuestInReplay(p)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	local __wf_atom_a1f556ba = questController:__wf_atom_a1f556ba()

	for _, v8 in ipairs(__wf_atom_a1f556ba) do
		if v8 == p then
			return true
		end
	end

	return false
end

function TalesAllowed()
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	return not (__wf_atom_7e8ad928(questController) or not questController:__wf_atom_2457d7dd())
end

function TaskIsActive(p, p2)
	return fn15(p, p2)
end

function SymbolIsValidQuestTask(p, p2)
	local v8 = fn13(p)
	return not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928((v8:__wf_atom_23accb14(p2))))
end

function CanQuestBeStarted(p)
	if not __wf_atom_7e8ad928(p) then
		if HasCompletedQuest(p) or QuestIsActive(p) or IsQuestInReplay(p) then
			return false
		end

		local questController

		if __wf_atom_7e8ad928(gGameRules) then
			print("Error: Null gameRules")
		else
			questController = gGameRules:GetQuestController()

			if __wf_atom_7e8ad928(questController) then
				print("Error: Null controller")
				questController = nil
			end
		end

		if not __wf_atom_7e8ad928(questController) then
			if questController:__wf_atom_47f2b5b0(p) then
				return true
			end

			return false
		end
	end
end

function CanCompleteTask(object)
	return not __wf_atom_7e8ad928(object) and (object:__wf_atom_6d0c070b() or gRegion:IsMaster())
end

function SetLocalPlayerReady(p, p2, value)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if not __wf_atom_7e8ad928(questController) then
		questController:__wf_atom_4849b414(p, Symbol(p2), Symbol(value or ""))
	end
end

function SetLocalPlayerReadyTag(p, p2, p3)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if not __wf_atom_7e8ad928(questController) then
		local activeQuests = questController:GetActiveQuests()

		for _, activeQuest in ipairs(activeQuests) do
			if activeQuest:__wf_atom_1bb5b1ff() ~= p then
				continue
			end

			local __wf_atom_f9a6a9ad = activeQuest:__wf_atom_f9a6a9ad(Symbol(p2))

			if __wf_atom_7e8ad928(__wf_atom_f9a6a9ad) then
				break
			end

			SetLocalPlayerReady(p, __wf_atom_f9a6a9ad:__wf_atom_cb9e9bb0(), p3)
			return
		end
	end
end

function IsPlayerReady(p, p2)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:IsPlayerReady(p, Symbol(p2))
end

function AllPlayersReady(p, p2)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:AllPlayersReady(p, Symbol(p2))
end

function AnyPlayersReady(p, p2)
	local questController

	if __wf_atom_7e8ad928(gGameRules) then
		print("Error: Null gameRules")
	else
		questController = gGameRules:GetQuestController()

		if __wf_atom_7e8ad928(questController) then
			print("Error: Null controller")
			questController = nil
		end
	end

	if __wf_atom_7e8ad928(questController) then
		return false
	end

	return questController:AnyPlayersReady(p, Symbol(p2))
end

function NotifyIfReadyPlayersWaiting(p, p2)
	if
		not __wf_atom_7e8ad928(p)
		and AnyPlayersReady(p, p2)
		and not (IsPlayerReady(p, p2) or __wf_atom_7e8ad928(_T.ShowImpactMessage))
	then
		local v8 = Localize(Resource(p):__wf_atom_014a76a2():c_str(), false)
		local v9 = Localize("/SF/Language/Quests/OtherPlayersAreWaiting", false)
		_T.ShowImpactMessage(v8 .. " - " .. v9, 8)
	end
end

function WaitForAllPlayersReady(p, p2)
	local v8 = Localize(Resource(p):__wf_atom_014a76a2():c_str(), false)
	local v9 = Localize("/SF/Language/Quests/WaitingForOtherPlayers", false)
	local v10 = false

	while not (__wf_atom_7e8ad928(p) or AllPlayersReady(p, p2)) do
		Sleep(0.1)

		if __wf_atom_7e8ad928(_T.ShowImpactMessage) or v10 then
			continue
		end

		_T.ShowImpactMessage(v8 .. " - " .. v9, -1)
		v10 = true
	end

	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end
end

function ResetQuest(p, value)
	if not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(p)) then
		gGameRules:GetQuestController():ResetQuest(p, value or "")
	end
end

function EnableQuestStepInJournal(className, p, p2)
	local v8 = GetActiveQuests()
	local v9 = nil

	for _, v10 in ipairs(v8) do
		if not v10:IsA(className) then
			continue
		end

		v9 = v10
		break
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:__wf_atom_23accb14(Symbol(p)):__wf_atom_20416a7d(p2)
	end
end

function GetQuestReplicationMode(object)
	if not object:__wf_atom_6d0c070b() then
		return 1
	end

	if gRegion:IsMaster() then
		return 3
	end

	return 4
end

function LoadLevel(level)
	fn(level)
end

function TrackEntry(p, p2, p3, p4)
	fn19(p, p2, p3, p4)
end

function UntrackEntry(p, p2, _)
	_UntrackJournalEntry(p, p2)
end

function TrackQuest(p, p2, p3)
	fn19(GetQuestId(p), 0, p2, p3)
end

function GetTrackedJournalEntry()
	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

	for _, v8 in ipairs(__wf_atom_d10f2b47) do
		if v8.mId ~= "" then
			return v8
		end
	end

	return nil
end

function IsTrackedJournalEntry(p)
	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	return v8 ~= nil and p == v8.mId
end

function IsAnyQuestTracked()
	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	return v8 ~= nil and v8.mType == 0
end

function IsAnythingTracked()
	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	return v8 ~= nil
end

function IsQuestTracked(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	return v8 ~= nil and GetQuestId(p) == v8.mId
end

function Deprecated_GetTrackedQuest()
	return fn18()
end

function Deprecated_ClearTrackedQuest()
	fn19(GetQuestId(nil), 0, true, nil)
end

function ClearTrackedEntry()
	local v8

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v9 in ipairs(__wf_atom_d10f2b47) do
			if v9.mId == "" then
				continue
			end

			v8 = v9
			break
		end
	end

	if v8 == nil then
		return
	end

	_UntrackJournalEntry(v8.mId, v8.mType)
end

function PreLoginQuestIsActive(className)
	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		print("Warning: QUEST_LIB PreLoginQuestIsActive: player already logged in, returning false by default!")
		return false
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
		__wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			print("Warning: QUEST_LIB PreLoginQuestIsActive: no profile data found in local data, returning false by default!")
			return false
		end
	end

	local __wf_atom_e85aed62 = __wf_atom_18a5d83b:__wf_atom_9be88b01():GetInventory():__wf_atom_e85aed62()

	for _, v8 in pairs(__wf_atom_e85aed62) do
		if v8.mItemType:IsA(className) then
			return not v8.mCompleted
		end
	end

	return false
end

local function fn21(object, p)
	local __wf_atom_23accb14 = object:__wf_atom_23accb14(Symbol(p))

	if __wf_atom_7e8ad928(__wf_atom_23accb14) then
		return EMPTY_SYMBOL
	end

	return __wf_atom_23accb14:__wf_atom_db682341()
end

function GetReadableTaskTag(p, p2)
	return fn21(p, p2)
end

function InitializeTask(p, p2, p3, p4, callback)
	module2.WaitForLevel()

	if callback then
		callback()
	end

	module2.WaitForLoginSequence()
	local v8 = tostring(fn21(p, p2))

	if module2.IsInOverworld() ~= (p4 or true) then
		print("Quest: Not in overworld, early out at stage: " .. v8)
		return false
	end

	if gRegion:IsMaster() then
		print("Starting" .. v8)
	elseif p3 then
		print("Starting" .. v8 .. " (client)")
	else
		return false
	end

	module2.WaitForAiDir()
	return true
end

local function fn22(object, object2, p)
	local v8 = Symbol(p)
	object:__wf_atom_ff716ec1(true)
	object:__wf_atom_c2a0916e(object2:__wf_atom_014a76a2())
	local __wf_atom_23accb14 = object2:__wf_atom_23accb14(v8)
	local EMPTY_SYMBOL = EMPTY_SYMBOL

	if not __wf_atom_7e8ad928(__wf_atom_23accb14) then
		EMPTY_SYMBOL = object2:__wf_atom_b2cbbf03(v8)

		if __wf_atom_7e8ad928(EMPTY_SYMBOL) then
			EMPTY_SYMBOL = __wf_atom_23accb14:__wf_atom_3a3d2e39()
		end
	end

	object:__wf_atom_313b2fd2(EMPTY_SYMBOL)
end

function CreateAreaMarker(object, value, p, p2, p3)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return __wf_atom_bb3e7833
	end

	local v8 = p or __wf_atom_28d5d4aa
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if v8 == __wf_atom_28d5d4aa then
		__wf_atom_bb3e7833 = object:Attach(v, EMPTY_SYMBOL)
		__wf_atom_bb3e7833:__wf_atom_efa3eed3((__wf_atom_7d789620:__wf_atom_0e0a6fee(object:GetPosition())))
	else
		local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(object:GetPosition() + v8)
		__wf_atom_bb3e7833 = gRegion:CreateEntity(v, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
		__wf_atom_bb3e7833:AttachToInPlace(object, EMPTY_SYMBOL)
	end

	__wf_atom_bb3e7833:__wf_atom_400189c4(value or 25)

	if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p3)) then
		fn22(__wf_atom_bb3e7833, p2, p3)
	end

	return __wf_atom_bb3e7833
end

function CreateAreaMarkerAtPos(p, value, p2, p3, p4)
	local v8 = p2 or __wf_atom_28d5d4aa
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if __wf_atom_7e8ad928(__wf_atom_7d789620) then
		return nil
	end

	local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(p + v8)
	local entity = gRegion:CreateEntity(v, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
	entity:__wf_atom_400189c4(value or 25)

	if not (__wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p4)) then
		fn22(entity, p3, p4)
	end

	return entity
end

function DestroyAreaMarker(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end

function TriggerPlayerProgressionCelebration(object, p, value)
	if value == "Syndicate" then
		local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

		if __wf_atom_0cbd9965:__wf_atom_8598f3a9() then
			value = __wf_atom_0cbd9965:c_str()
		end
	end

	if not __wf_atom_7e8ad928(object) then
		local v8 = 5

		while not __wf_atom_7e8ad928(object) and v8 > 0 do
			v8 -= __wf_atom_084b3e93()
			Sleep(0)
		end

		local v9 = 20

		while not __wf_atom_7e8ad928(object) do
			local v10

			if __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) and not __wf_atom_7e8ad928(object) then
				v10 = not module2.PlayerIsInBattle(object)
			else
				v10 = false
			end

			if v10 or not (v9 > 0) then
				break
			end

			v9 -= __wf_atom_084b3e93()
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

			while
				not __wf_atom_7e8ad928(object)
				and (__wf_atom_e919fb8e.nightfoldTransition or __wf_atom_e919fb8e.inOdeZipLine or object:__wf_atom_c138b19b(v6))
			do
				Sleep(0)
			end

			Sleep(1)
		end
	end

	module5.RegisterPreventNighfoldUsage(true)

	if __wf_atom_7e8ad928(object) then
		module3.ShowProgressionScreen(false, p)
	elseif value == "NoCin" then
		module3.ShowProgressionScreen(false, p)
	else
		local v8

		if __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) and not __wf_atom_7e8ad928(object) then
			v8 = not module2.PlayerIsInBattle(object)
		else
			v8 = false
		end

		if v8 then
			object:__wf_atom_9b5dcd3b(nil, false, 3, 1)
			local envoyInventoryControl = module3.GetEnvoyInventoryControl()
			module4.EnableWeaponFiring(object, "ProgressionCelebration", false)

			if not __wf_atom_7e8ad928(envoyInventoryControl) then
				envoyInventoryControl:Unequip(0, 0)
			end

			local v9 = 2

			while
				not __wf_atom_7e8ad928(object)
				and not object:IsKilled()
				and not __wf_atom_7e8ad928(envoyInventoryControl)
				and envoyInventoryControl:__wf_atom_aba9c26e(0) ~= 14
			do
				v9 -= __wf_atom_084b3e93()

				if v9 <= 0 then
					if __wf_atom_7e8ad928(envoyInventoryControl) then
						break
					end

					envoyInventoryControl:Unequip(0, 2)
					break
				else
					Sleep(0)
				end
			end

			local v10 = nil
			local v11 = nil

			if __wf_atom_7e8ad928(object) then
				module3.ShowProgressionScreen(false, p)
			else
				local motionControl = object:MotionControl()
				v10 = object:Attach(v2[value or "Default"], EMPTY_SYMBOL)
				v11 = object:Attach(Type("/SF/Characters/WildLife/Sparrow/SparrowGuide/SparrowGuideDeco"), EMPTY_SYMBOL)
				v11:__wf_atom_e6ed03c8()
				module.ApplySparrowCustomizationToDeco(object, v11)
				v10:SetInstigatorAvatar(object)
				v10:__wf_atom_a3d2b66b(v11, v11:__wf_atom_12695c30())
				v10:StartRelative(Symbol("Envoy"), object:__wf_atom_a2a18137(), motionControl:__wf_atom_d9cb4b97())
				Sleep(0.6)
				module3.ShowProgressionScreen(false, p)
				module2.WaitForCinematicToFinish(v10)
				module4.EnableWeaponFiring(object, "ProgressionCelebration", true)
				Sleep(1)
			end

			if not __wf_atom_7e8ad928(v10) then
				v10:Destroy()
			end

			if not __wf_atom_7e8ad928(v11) then
				v11:Destroy()
			end
		else
			module3.ShowProgressionScreen(false, p)
		end
	end

	Sleep(1.5)
	gGameRules:__wf_atom_5c2cb2f7()
	module5.RegisterPreventNighfoldUsage(false)
end

function _CalloutPressed()
	v3 = false
end

function WakeUpInNightFold(value, value2, value3, p, p2, p3, p4, p5)
	module2.Fade(true, 0, 1)
	local v8 = value2 or 1.5
	local v9 = value3 or 0.5
	local v10 = value or 1.5

	while module2.IsStreamingLevel() or not module2.HasStreamedLevel("/SF/Levels/Tent") do
		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_b9375444(true)
	_T.mWorldView = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()

	if not module2.IsInNightFold(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_43b67ec1((__wf_atom_c4f78a8f:GetPosition()))
		_T.SkipNightfoldTransition = true
		__wf_atom_c4f78a8f:GoToNightFold()
	end

	module5.RegisterPreventNighfoldUsage(true, "WakeUpInNightFold", false, 15)
	Sleep(1)

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	module2.Fade(true, 0, 1)
	_T.SkipNightfoldTransition = false
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TentWakeUpLoop"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("TentWakeUpEnd"))

	if p5 ~= nil and p5 ~= EMPTY_SYMBOL then
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(p5)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			__wf_atom_0a6a5887_2 = __wf_atom_0a6a5887_3
		end
	end

	if not p4 then
		__wf_atom_0a6a5887:SetInstigatorAvatar(__wf_atom_c4f78a8f)
		__wf_atom_0a6a5887:FirePort("StartPlaying")
		module2.Fade(false, v8)
		Sleep(v10)
		__wf_atom_0a6a5887:__wf_atom_398939a1()
	end

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	__wf_atom_0a6a5887_2:SetInstigatorAvatar(__wf_atom_c4f78a8f)
	__wf_atom_0a6a5887_2:FirePort("StartPlaying")
	module2.Fade(false, v8)

	if p then
		Sleep(v9)
		module3.ShowProgressionScreen(false, p2)

		if not __wf_atom_7e8ad928(v4) and not __wf_atom_7e8ad928(v5) and Random(0, 1) < 0.1 then
			_T.ForceShowHud = true
			__wf_atom_c4f78a8f:__wf_atom_1a73b1c2((v4:__wf_atom_89fb3a41(v5, {})))
			Sleep(0.3)
			_T.ForceShowHud = false
		end

		module2.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)
	end

	if not __wf_atom_7e8ad928(p3) then
		module2.PlayCinematicWithTagAndWait(p3)
	end

	module5.RegisterPreventNighfoldUsage(false, "WakeUpInNightFold")
end

function ForceCompleteQuest(_) end

local function fn23(p, p2)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(p2) or not (p2 and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) <= 50) then
		__wf_atom_0a6a5887:Attach(v7, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function TeleportPlayers(p, p2)
	fn23(p, p2)
end

function DevTeleportPlayers(p, p2)
	Sleep(1)
	fn23(p, p2)
end