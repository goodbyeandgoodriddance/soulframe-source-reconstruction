module(..., package.seeall)
HUD_PRIORITY = {
	BACKGROUND = 1,
	DEFAULT = 10,
	ENCOUNTER_ACTIVE = 10,
	ENCOUNTER_INACTIVE = 9,
	JOB_ACTIVE = 11,
	JOBS = 8,
	QUEST = 20
}
COMPLETETIME = 3
local v = Symbol("TransientTask")
local v2 = 0
local v3 = nil
local v4 = false
local v5 = nil
local v6 = nil
local v7 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")

local function fn(object)
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		__wf_atom_dd85e6db = object:__wf_atom_90813fa0()
	end

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		local __wf_atom_66046837 = object:__wf_atom_66046837()

		if not __wf_atom_7e8ad928(__wf_atom_66046837) then
			__wf_atom_dd85e6db = Resource(__wf_atom_66046837:__wf_atom_5b41f63b())
		end
	end

	return __wf_atom_dd85e6db
end

local function fn2(instance) -- 1 equivalent call inferred from this helper
	local position = instance:GetPosition()
	position.x = math.floor(position.x)
	position.y = math.floor(position.y)
	position.z = math.floor(position.z)
	return (string.gsub(tostring(position), "Vector", ""))
end

function GetObjectId(instance)
	if type(instance) == "table" then
		return instance.hudId
	end

	if instance:IsA(__wf_atom_cce305dd) then
		if __wf_atom_1ef90898(instance) then
			return instance:__wf_atom_5b41f63b()
		end

		return instance:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
	else
		if instance:IsA(__wf_atom_67c46eba) then
			return instance:GetName()
		end

		if instance:IsA(__wf_atom_f806fd7a) then
			local v8 = instance:__wf_atom_26b04ea9() or instance
			local v9 = v8:__wf_atom_db682341() or v8:GetName()
			local v10 = fn(instance)
			local v11 = Symbol("MT_NONE")

			if not __wf_atom_7e8ad928(v10) then
				v11 = v10:__wf_atom_55116686()
			end

			if v11 == Symbol("MT_NONE") or v11 == Symbol("") then
				v11 = instance:__wf_atom_5b6b447d()
			end

			return tostring(v9) .. "-" .. tostring(v11)
		else
			return instance:GetName() .. "-" .. fn2(instance) -- inferred equivalent call
		end
	end
end

local function fn3(owner, groupId, default)
	if default == nil then
		if __wf_atom_7e8ad928(owner) or type(owner) == "table" or not owner:IsA(__wf_atom_cce305dd) then
			default = HUD_PRIORITY.DEFAULT
		else
			default = HUD_PRIORITY.QUEST
		end
	end

	if __wf_atom_7e8ad928(_T.ObjHudTaskInfo) then
		_T.ObjHudTaskInfo = {}
	end

	if not __wf_atom_7e8ad928(_T.ObjHudTaskInfo[groupId]) then
		return _T.ObjHudTaskInfo[groupId]
	end

	_T.ObjHudTaskInfo[groupId] = {
		title = nil,
		tasks = {},
		quest = nil,
		owner = nil,
		priority = default,
		groupId = groupId,
		TrackerName = "HudTitle_" .. tostring(groupId)
	}

	if type(owner) == "table" or not owner:IsA(__wf_atom_cce305dd) then
		_T.ObjHudTaskInfo[groupId].owner = owner
	else
		_T.ObjHudTaskInfo[groupId].quest = WeakResource(owner)
	end

	return _T.ObjHudTaskInfo[groupId]
end

local function fn4(p)
	local trackedJournalEntry = module2.GetTrackedJournalEntry()

	if trackedJournalEntry == nil then
		return false
	end

	if trackedJournalEntry.mType == 0 and not __wf_atom_7e8ad928(p.quest) then
		if module2.IsQuestTracked(p.quest) and module2.QuestIsActive(p.quest) then
			return true
		end
	elseif p.groupId == trackedJournalEntry.mId then
		return true
	end

	return false
end

local function fn5(instance)
	if not (type(instance) ~= "table" and instance:IsA(__wf_atom_f806fd7a)) then
		return false
	end

	if module4.EncounterHintHasTag(instance, v) then
		return true
	end

	local __wf_atom_26b04ea9 = instance:__wf_atom_26b04ea9()

	if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) and module4.EncounterHintHasTag(__wf_atom_26b04ea9, v) then
		return true
	end

	return false
end

local function fn6(p) -- 3 equivalent calls inferred from this helper
	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker(p, 0)
	end
end

local function fn7(p, p2)
	if _T.ObjHudTaskInfo[p].tasks[p2] ~= nil then
		fn6(_T.ObjHudTaskInfo[p].tasks[p2].TrackerName) -- inferred equivalent call
	end

	_T.ObjHudTaskInfo[p].tasks[p2] = nil
	v3 = true
	v4 = false

	if _T.ObjHudTaskInfo[p].Queued ~= nil then
		local v8 = _T.ObjHudTaskInfo[p].Queued[p2]

		if v8 ~= nil then
			v8()
			_T.ObjHudTaskInfo[p].Queued[p2] = nil
		end
	end
end

local function fn8(trackerName, value, p, p2, p3, p4, p5, value2, isLocalProgress, objectiveData)
	if __wf_atom_7e8ad928(_T.GetHudTracker) or not (gRegion:IsMaster() or isLocalProgress) then
		return
	end

	local v8 = tostring(p)
	local v9 = p4 or false
	local v10, v11, v12, v13, v14

	if p3 then
		v10 = 1
		v11 = 1
		v12 = 26
		v13 = 32
		v14 = 0
	else
		v10 = value2 or 2
		v11 = 2
		v12 = 23
		v13 = 58
		v14 = -3
	end

	local v15 = p5 or v11
	local hudTracker = _T.GetHudTracker(trackerName)

	if not __wf_atom_7e8ad928(hudTracker) and hudTracker.Removing then
		hudTracker = nil
	end

	if __wf_atom_7e8ad928(hudTracker) then
		hudTracker = _T.AddHudTracker(trackerName, 6, 0, v10, not isLocalProgress)
		hudTracker.SetAutonomousVisibility(true)
		hudTracker.SetStyle(v15)
		hudTracker.SetTrackingId(value or "")
	end

	local textParams

	if objectiveData ~= nil then
		textParams = objectiveData.TextParams
		objectiveData.TextParams = nil
	end

	local extraTextParams

	if objectiveData ~= nil then
		extraTextParams = objectiveData.ExtraTextParams
		objectiveData.ExtraTextParams = nil
	end

	hudTracker.Data.ObjectiveData = objectiveData
	local v16 = "<p>"
	local v17

	if p3 then
		v17 = v16 .. "<font size=\"" .. v12 .. "\">"
	else
		v17 = v16 .. "<font size=\"" .. v12 .. "\" face=\"Spectral Regular\">"
	end

	if v7 == nil then
		v7 = module3.IsRetailServer()
	end

	if not __wf_atom_7e8ad928(p2) and p2 ~= "" then
		if v7 then
			local _ = Localize(p2, nil) == p2
		end

		v17 ..= "<font color=\"" .. module3.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\"><b>" .. hudTracker.Localize(p2, extraTextParams) .. "</b></font>  "
	end

	if v7 then
		local _ = Localize(v8, nil) == v8
	end

	local v18 = (v17 .. hudTracker.Localize(v8, textParams)) .. "</font></p>"

	if
		module2.IsTrackedJournalEntry(value)
		and (module5.SparrowGuidingForPlayer(gRegion:__wf_atom_c4f78a8f()) or v2 > 0 or v9)
	then
		hudTracker.SetVisible(true)
	else
		hudTracker.SetVisible(false)
	end

	hudTracker.SetLabel(v18)
	hudTracker.SetOffset(v13, v14, false)
	hudTracker.SetCompleted(v9)
	print(trackerName, "*********************************************")
	return hudTracker
end

local function fn9(instance, groupId, value, p)
	if __wf_atom_7e8ad928(instance) or fn5(instance) then
		return
	end

	local isLocalProgress = false

	if type(instance) ~= "table" then
		if instance:IsA(__wf_atom_cce305dd) then
			value = value or instance:__wf_atom_014a76a2():c_str()
			isLocalProgress = instance:__wf_atom_6d0c070b()
		elseif instance:IsA(__wf_atom_f806fd7a) then
			local v8 = fn(instance)

			if not __wf_atom_7e8ad928(v8) then
				value = value or tostring(v8:__wf_atom_4f3855f9())
			end
		end
	end

	local title = (__wf_atom_7e8ad928(value) or tostring(value or "") == "") and "  " or value
	local flag = true

	if not __wf_atom_7e8ad928(_T.ObjHudTaskInfo) then
		local v8 = _T.ObjHudTaskInfo[groupId]

		if
			not __wf_atom_7e8ad928(v8)
			and (v8.owner == instance or __wf_atom_7e8ad928(instance))
			and v8.title == title
			and (v8.priority == p or p == nil)
		then
			flag = false
		end
	end

	local v8 = fn3(instance, groupId, p)

	if p ~= nil then
		SetGroupPriority(instance, groupId, p)
	end

	v8.title = title
	v8.isLocalProgress = isLocalProgress

	if flag then
		local v9 = fn8(v8.TrackerName, tostring(groupId), v8.title, nil, true, nil, nil, nil, v8.isLocalProgress)

		if not __wf_atom_7e8ad928(v9) then
			v9.SetVisible(false)
		end

		v3 = true
	end
end

local fn10

local function fn11(instance, p) -- 1 equivalent call inferred from this helper
	local __wf_atom_23accb14 = instance:__wf_atom_23accb14(Symbol(p))

	if __wf_atom_7e8ad928(__wf_atom_23accb14) then
		return ""
	end

	local __wf_atom_3a3d2e39 = __wf_atom_23accb14:__wf_atom_3a3d2e39()

	if __wf_atom_3a3d2e39:__wf_atom_8598f3a9() then
		return (__wf_atom_3a3d2e39:c_str())
	end

	return nil
end

local function fn12(p) -- 6 equivalent calls inferred from this helper
	return GetObjectId(p)
end

fn10 = function(instance, p, p2, text, value, p3, p4, styleHint, priority, objectiveData)
	if __wf_atom_7e8ad928(instance) or fn5(instance) then
		return
	end

	local v8 = __wf_atom_7e8ad928(p2) and "MainTask" or p2
	local v9 = false

	if not __wf_atom_7e8ad928(_T.ObjHudTaskInfo) then
		if __wf_atom_7e8ad928(p) then
			for k, v10 in _T.ObjHudTaskInfo do
				if v10.tasks[v8] == nil then
					continue
				end

				p = k
				v9 = true
				break
			end

			if not v9 then
				p = fn12(instance) -- inferred equivalent call
			end
		else
			local v10 = _T.ObjHudTaskInfo[p]

			if not __wf_atom_7e8ad928(v10) and v10.tasks[v8] ~= nil then
				v9 = true
			end
		end
	end

	if __wf_atom_7e8ad928(p) then
		p = fn12(instance) -- inferred equivalent call
	end

	if
		_T.ObjHudTaskInfo ~= nil
		and _T.ObjHudTaskInfo[p] ~= nil
		and _T.ObjHudTaskInfo[p].tasks ~= nil
		and _T.ObjHudTaskInfo[p].tasks[v8] ~= nil
		and _T.ObjHudTaskInfo[p].tasks[v8].removalTime ~= nil
	then
		_T.ObjHudTaskInfo[p].Queued = _T.ObjHudTaskInfo[p].Queued or {}

		if _T.ObjHudTaskInfo[p].Queued[v8] == nil then
			local function fn13()
				fn10(instance, p, v8, text, value, p3, p4, styleHint, priority)
			end

			_T.ObjHudTaskInfo[p].Queued[v8] = fn13
			return
		end
	end

	local v10 = fn3(instance, p)

	if __wf_atom_7e8ad928(p4) or p4 == instance then
		if type(instance) ~= "table" then
			if instance:IsA(__wf_atom_cce305dd) then
				v10.isLocalProgress = instance:__wf_atom_6d0c070b()

				if text == nil then
					local task = v10.tasks[v8]

					if task == nil or task.text == nil then
						text = fn11(instance, v8) -- inferred equivalent call
					else
						text = task.text
					end
				end

				if v8 ~= nil and text ~= nil then
					if type(text) ~= "string" then
						text = tostring(text)
					end

					local questController = module2.GetQuestController()

					if not __wf_atom_7e8ad928(questController) then
						local v11

						if value == nil then
							v11 = text
						else
							local extraTextParams, textParams

							if objectiveData ~= nil then
								textParams = objectiveData.TextParams
								extraTextParams = objectiveData.ExtraTextParams
							end

							v11 = Localize(value, extraTextParams) .. " " .. Localize(text, textParams)
						end

						questController:__wf_atom_ed8365e0(instance, Symbol(v8), Symbol(v11))
					end
				end
			elseif instance:IsA(__wf_atom_f806fd7a) then
				local v11 = fn(instance)

				if not __wf_atom_7e8ad928(v11) then
					text = text or v11:__wf_atom_c1f3dd00()
				end
			end
		end
	else
		local v11 = fn(p4)

		if not __wf_atom_7e8ad928(v11) then
			text = text or v11:__wf_atom_c1f3dd00()
		end
	end

	local v11 = {
		text = tostring(text or ""),
		extraText = tostring(value or ""),
		completed = p3 or false,
		styleHint = styleHint,
		removalTime = nil,
		priority = priority,
		TrackerName = "HudTask_" .. tostring(v10.groupId) .. "_" .. v8
	}
	local v12 = not v9

	if not v12 then
		if __wf_atom_7e8ad928(v10.tasks[v8]) then
			v12 = true
		else
			local task = v10.tasks[v8]

			for k, v13 in pairs(v11) do
				if task[k] == v13 then
					continue
				end

				task[k] = v13
				v12 = true
			end
		end
	end

	if __wf_atom_7e8ad928(v11.text) or v11.text == "" then
		return
	end

	if __wf_atom_7e8ad928(v10.title) then
		fn9(instance, p)
	end

	if __wf_atom_7e8ad928(v10.tasks[v8]) then
		v10.tasks[v8] = v11
	end

	local v13 = fn8(
		v11.TrackerName,
		tostring(v10.groupId),
		v11.text,
		v11.extraText,
		false,
		v11.completed,
		v11.styleHint,
		v11.priority,
		v10.isLocalProgress,
		objectiveData
	)

	if not __wf_atom_7e8ad928(v13) then
		v13.SetVisible(false)
	end

	if v12 and v5 ~= nil and v5 ~= v10 and not fn4(v10) then
		v12 = false
	end

	if v12 then
		v2 = 8
	end

	if v12 then
		v3 = true
		fn4(v10)
	end
end

local function fn13(p, p2, p3, removalTime)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v8 = __wf_atom_7e8ad928(p3) and "MainTask" or p3

	if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2])) then
		if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2].tasks) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2].tasks[v8])) then
			_T.ObjHudTaskInfo[p2].tasks[v8].completed = true

			if not __wf_atom_7e8ad928(removalTime) then
				_T.ObjHudTaskInfo[p2].tasks[v8].removalTime = removalTime

				if v5 == _T.ObjHudTaskInfo[p2] then
					v2 = removalTime or 8
				end
			end

			if _T.ObjectiveTrackers ~= nil and _T.ObjectiveTrackers[p2] ~= nil then
				local trackerName = _T.ObjHudTaskInfo[p2].tasks[v8].TrackerName
				local v9 = _T.ObjectiveTrackers[p2][trackerName]

				if not __wf_atom_7e8ad928(v9) then
					v9.SetCompleted(true)
				end
			end
		end

		if v5 == _T.ObjHudTaskInfo[p2] then
			v2 = 8
		end
	end

	if _T.ObjHudTaskInfo ~= nil and v5 == _T.ObjHudTaskInfo[p2] then
		v3 = true
		v4 = false
	end
end

local function fn14(p, p2, removalTime)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2]) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2].tasks)) then
		local tasks = _T.ObjHudTaskInfo[p2].tasks

		for k, task in pairs(tasks) do
			tasks[k].completed = true

			if not __wf_atom_7e8ad928(removalTime) then
				tasks[k].removalTime = removalTime
			end

			if not (_T.ObjectiveTrackers ~= nil and _T.ObjectiveTrackers[p2] ~= nil) then
				continue
			end

			local trackerName = task.TrackerName
			local v8 = _T.ObjectiveTrackers[p2][trackerName]

			if not __wf_atom_7e8ad928(v8) then
				v8.SetCompleted(true)
			end
		end

		v2 = 8
	end

	v3 = true
	v4 = false
end

local function fn15(p, p2, p3, removalTime)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v8 = __wf_atom_7e8ad928(p3) and "MainTask" or p3

	if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2]) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2].tasks)) then
		if
			__wf_atom_7e8ad928(removalTime)
			or not (removalTime > 0)
			or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2].tasks[v8])
		then
			fn7(p2, v8)
		else
			_T.ObjHudTaskInfo[p2].tasks[v8].removalTime = removalTime
		end
	end
end

local function fn16(p, p2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p2])) then
		fn6(_T.ObjHudTaskInfo[p2].TrackerName) -- inferred equivalent call
		_T.ObjHudTaskInfo[p2] = nil
		v3 = true
		v4 = false
	end
end

local function fn17(p, priority)
	if __wf_atom_7e8ad928(_T.ObjHudTaskInfo) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[p]) then
		return
	end

	if priority ~= _T.ObjHudTaskInfo[p].priority then
		_T.ObjHudTaskInfo[p].priority = priority

		if module2.IsAnythingTracked() then
			return
		end

		local v8 = nil

		for _, v9 in pairs(_T.ObjHudTaskInfo) do
			if v8 == nil or v9.priority > v8.priority then
				v8 = v9
			end
		end

		if v8 ~= v5 and not fn4(v5) then
			v2 = 8
			v3 = true
			v4 = false
		end
	end
end

function RemoveHudTracker(p)
	fn6(p) -- inferred equivalent call
end

function AddHudTitle(owner, p, p2, p3)
	if __wf_atom_7e8ad928(owner) then
		return nil
	end

	if p == nil then
		p = fn12(owner) -- inferred equivalent call
	end

	fn9(owner, p, p2, p3)
end

function AddHudTask(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	fn10(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
end

function UpdateOrAddHudCounterTask(p, p2, p3, p4, p5, p6, p7)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = GetObjectId(p)
	end

	local v8 = p5 <= p4
	local v9 = p6 == nil and {} or p6
	v9.IsCounter = true

	if v9.ExtraTextParams == nil then
		v9.ExtraTextParams = {}
	end

	v9.ExtraTextParams.PROGRESS = math.round(p4)
	v9.ExtraTextParams.REQUIRED = math.round(p5)
	return fn10(p, nil, p2, p3, "/SF/Language/Quests/GenericChallengeHudFormat", v8, p7, nil, nil, v9)
end

function UpdateOrAddHudTask(p, p2, p3, p4, p5, p6, p7, p8, p9)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = GetObjectId(p)
	end

	return fn10(p, nil, p2, p3, p4, p5, p6, p7, p8, p9)
end

function CompleteHudTask(p, p2, p3, removalTime)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	if __wf_atom_7e8ad928(p3) then
		p3 = GetObjectId(p)
	end

	fn13(p, GetObjectId(p), p3, removalTime)

	if not __wf_atom_7e8ad928(p2) then
		fn13(p, p2, p3, removalTime)
	end
end

function CompleteAllHudTasks(p, removalTime)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	return fn14(p, fn12(p), removalTime) -- inferred equivalent call
end

function RemoveHudGroup(p, p2)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	return fn16(p, p2 or fn12(p)) -- inferred equivalent call
end

function RemoveHudTask(p, p2, p3, removalTime)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	if __wf_atom_7e8ad928(p3) then
		p3 = GetObjectId(p)
	end

	fn15(p, GetObjectId(p), p3, removalTime)

	if not __wf_atom_7e8ad928(p2) then
		fn15(p, p2, p3, removalTime)
	end
end

function SetGroupPriority(p, p2, priority)
	if __wf_atom_7e8ad928(p) then
		return
	end

	fn17(p2 or fn12(p), priority) -- inferred equivalent call
end

function UpdateVisibility(p, value)
	if p then
		v2 = value or 8
	else
		v2 = 0
	end
end

local function fn18(p)
	if __wf_atom_7e8ad928(p.quest) or not module2.HasPersonalCompletedQuest(p.quest) then
		return false
	end

	for k, _ in pairs(p.tasks) do
		local v8 = Type(k)

		if __wf_atom_7e8ad928(v8) or not v8:IsA(__wf_atom_07450311) then
			continue
		end

		local __wf_atom_c21a80eb = v8:__wf_atom_c21a80eb(0)

		if module2.GetPersonalCompletedQuest(__wf_atom_c21a80eb) == p.quest then
			return true
		end
	end

	return false
end

local function fn19(p)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	if _T.ObjectiveTrackers == nil then
		_T.ObjectiveTrackers = {}
	end

	local trackedJournalEntry = module2.GetTrackedJournalEntry()
	local mId

	if trackedJournalEntry ~= nil then
		mId = tostring(trackedJournalEntry.mId)
	end

	if p then
		for k, objectiveTracker in pairs(_T.ObjectiveTrackers) do
			if k == mId then
				continue
			end

			for _, v8 in pairs(objectiveTracker) do
				v8.SetVisible(false)
			end
		end
	elseif v6 ~= nil and v6 ~= mId then
		local objectiveTracker = _T.ObjectiveTrackers[v6]

		for _, v8 in pairs(objectiveTracker) do
			v8.SetVisible(false)
		end
	end

	if mId ~= nil then
		local v8 = false
		local objectiveTracker = _T.ObjectiveTrackers[mId]

		if not __wf_atom_7e8ad928(objectiveTracker) then
			local v9, _ = next(objectiveTracker)
			v8 = v9 ~= nil and next(objectiveTracker, v9) ~= nil or false
		end

		local v9

		if v8 then
			v9 = module5.SparrowGuidingForPlayer(gRegion:__wf_atom_c4f78a8f())

			if v2 > 0 then
				v9 = true
				v2 = math.max(v2 - __wf_atom_03df4e1d(), 0)
			end
		else
			v9 = false
		end

		for _, v10 in pairs(objectiveTracker) do
			v10.SetVisible(v9)
		end
	end

	v6 = mId
end

function Update()
	_T.QuestTaskTrackers = _T.QuestTaskTrackers or {}
	local v8 = nil

	if module.IsStreamingLevel() then
		return
	end

	for k, v9 in pairs(_T.ObjHudTaskInfo) do
		if __wf_atom_7e8ad928(k) or not (__wf_atom_7e8ad928(v9.quest) and __wf_atom_7e8ad928(v9.owner)) then
			if not __wf_atom_7e8ad928(v9.quest) then
				if module2.QuestIsAccepted(v9.quest) and module2.QuestIsActive(v9.quest) or fn18(v9) then
					if not fn18(v9) then
						for k2, _ in pairs(v9.tasks) do
							if not module2.SymbolIsValidQuestTask(v9.quest, Symbol(k2)) then
								continue
							end

							if module2.TaskIsActive(v9.quest, Symbol(k2)) then
								continue
							end

							if not (__wf_atom_7e8ad928(_T.ObjHudTaskInfo[k].tasks[k2]) or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[k].tasks[k2].removalTime) or not (_T.ObjHudTaskInfo[k].tasks[k2].removalTime > 0)) then
								continue
							end

							fn7(k, k2)
						end
					end
				else
					local flag = true

					for _, _ in pairs(v9.Queued) do
						flag = false
						break
					end

					if flag then
						for k2, _ in pairs(v9.tasks) do
							if
								__wf_atom_7e8ad928(_T.ObjHudTaskInfo[k].tasks[k2].removalTime)
								or not (_T.ObjHudTaskInfo[k].tasks[k2].removalTime > 0)
							then
								continue
							end

							flag = false
							break
						end
					end

					if flag then
						_T.ObjHudTaskInfo[k] = nil
						v3 = true
						v4 = false
					end
				end
			end
		else
			_T.ObjHudTaskInfo[k] = nil
			v3 = true
			v4 = false
		end

		if not __wf_atom_7e8ad928(_T.ObjHudTaskInfo[k]) then
			for k2, _ in pairs(v9.tasks) do
				if
					__wf_atom_7e8ad928(_T.ObjHudTaskInfo[k].tasks[k2])
					or __wf_atom_7e8ad928(_T.ObjHudTaskInfo[k].tasks[k2].removalTime)
				then
					continue
				end

				if _T.ObjHudTaskInfo[k].tasks[k2].removalTime > 0 then
					_T.ObjHudTaskInfo[k].tasks[k2].removalTime = _T.ObjHudTaskInfo[k].tasks[k2].removalTime - __wf_atom_03df4e1d()
				else
					fn7(k, k2)
				end
			end
		end

		v9.hasPriority = false
	end

	local trackedJournalEntry = module2.GetTrackedJournalEntry()
	local isAnythingTracked = module2.IsAnythingTracked()

	if isAnythingTracked then
		local _mId = trackedJournalEntry.mId
	end

	for k, v9 in pairs(_T.ObjHudTaskInfo) do
		local v10 = false

		if isAnythingTracked then
			if trackedJournalEntry.mType == 0 and not __wf_atom_7e8ad928(v9.quest) then
				v10 = module2.IsQuestTracked(v9.quest) and module2.QuestIsActive(v9.quest) and true or false
			else
				v10 = k == trackedJournalEntry.mId or false
			end
		end

		if __wf_atom_7e8ad928(v9.tasks) or next(v9.tasks) == nil or not v10 then
			continue
		end

		v8 = v9
		break
	end

	if __wf_atom_7e8ad928(_T.GetHudTracker) then
		return
	end

	local count = 0

	if not __wf_atom_7e8ad928(v8) then
		for _, _ in pairs(v8.tasks) do
			count += 1
		end

		v8.hasPriority = true
	end

	if v3 or v8 ~= v5 then
		v5 = v8
	end

	fn19(v3)
	v3 = false
end

function GetQuestTaskLoc(object, p)
	local __wf_atom_23accb14 = object:__wf_atom_23accb14(Symbol(p))

	if __wf_atom_7e8ad928(__wf_atom_23accb14) then
		return ""
	end

	local __wf_atom_3a3d2e39 = __wf_atom_23accb14:__wf_atom_3a3d2e39()

	if __wf_atom_3a3d2e39:__wf_atom_8598f3a9() then
		return (__wf_atom_3a3d2e39:c_str())
	end

	return nil
end