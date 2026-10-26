module(..., package.seeall)
local module = require("Lotus.Scripts.Libs.ObjectiveText")

local function fn(data)
	local jobType = Resource(data.job)

	if __wf_atom_7e8ad928(jobType) then
		print("Mission job is null, so _T.ActiveJob will be cleared")
		return nil
	end

	local _, _, v = string.find(data.jobId, ".*_(.*)")
	local v2 = MongoId()
	local location

	if __wf_atom_7e8ad928(v) or v2:Parse(v) then
		location = EMPTY_SYMBOL
	else
		location = Symbol(v)
	end

	local v3 = {
		jobId = data.jobId,
		jobType = jobType,
		jobTypeAnchor = Type(data.job),
		stages = {},
		reward = Resource(data.jobReward),
		skipInventoryUpdate = data.jobSkipInv,
		minEnemyLevel = data.jobMinEnemyLevel,
		maxEnemyLevel = data.jobMaxEnemyLevel,
		isQuest = data.isQuest,
		tier = data.jobTier,
		requiredItems = {},
		location = location,
		category = data.jobCategory
	}
	local jobAlternateLocationTag = data.jobAlternateLocationTag

	if jobAlternateLocationTag then
		v3.alternateLocationTag = Symbol(jobAlternateLocationTag)
	end

	for _, jobStage in pairs(data.jobStages) do
		table.insert(v3.stages, WeakResource(jobStage))
	end

	for _, requiredItem in pairs(data.requiredItems) do
		table.insert(v3.requiredItems, Resource(requiredItem))
	end

	return v3
end

function GetJobFromMission(p)
	return (fn(p))
end

function UpdateActiveJobFromMission(p)
	if not __wf_atom_7e8ad928((Resource(p.job))) then
		_T.ActiveJob = fn(p)
	end
end

function GetJobChainNumCompletedJobs(p, p2)
	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(p)

	if __wf_atom_7e8ad928(__wf_atom_13d5b7e9) or __wf_atom_7e8ad928(gGameData) then
		return -1
	end

	local v = Resource(__wf_atom_13d5b7e9:__wf_atom_6e1dcf41())

	if __wf_atom_7e8ad928(v) then
		return -1
	end

	local __wf_atom_7bf42726 = v:__wf_atom_7bf42726()

	for i = 1, #__wf_atom_7bf42726 do
		local v2 = __wf_atom_7bf42726[i]

		if v2.mLocationTag ~= p2 then
			continue
		end

		local count = 0

		for j = 1, #v2.mJobs do
			local mJob = v2.mJobs[j]

			if gGameData:__wf_atom_e44b96c7(v2.mLocationTag, WeakResource(mJob.mJobInfo)) then
				count += 1
			end
		end

		return count
	end

	return -1
end

function GetNextJobChainMission(data)
	if __wf_atom_7e8ad928(data.jobType) or data.jobId == nil or data.syndicateTag == nil then
		return nil
	end

	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(data.syndicateTag)

	if __wf_atom_7e8ad928(__wf_atom_13d5b7e9) or __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local v = Resource(__wf_atom_13d5b7e9:__wf_atom_6e1dcf41())

	if __wf_atom_7e8ad928(v) then
		return nil
	end

	local _, _, v2 = string.find(data.jobId, ".*_(.*)")
	local v3 = Symbol(v2)
	local __wf_atom_7bf42726 = v:__wf_atom_7bf42726()

	for i = 1, #__wf_atom_7bf42726 do
		local v4 = __wf_atom_7bf42726[i]

		if v4.mLocationTag ~= v3 then
			continue
		end

		for j = 1, #v4.mJobs do
			if v4.mJobs[j].mJobInfo ~= data.jobType then
				continue
			end

			if j < #v4.mJobs then
				return v4.mJobs[j + 1].mJobInfo
			end

			return nil
		end

		break
	end

	return nil
end

local function fn2(object)
	local name = object:GetName()
	local v = string.find(name, "Easy")

	if v == nil then
		v = string.find(name, "VeryHard")
	end

	if v == nil then
		v = string.find(name, "Hard")
	end

	if v ~= nil then
		name = string.sub(name, 1, v - 1) .. "Challenge"
	end

	return name
end

function GetChallengeMissionLocName(p)
	return (fn2(p))
end

local function fn3() -- 1 equivalent call inferred from this helper
	if _T.DeactivateTownDoorObjectiveMarker then
		_T.DeactivateTownDoorObjectiveMarker()
	end

	_T.ActiveChallengeMission = nil
	_T.TrackActiveChallenge = nil
	_T.ClearActiveChallengeMission = nil
end

function ClearActiveChallengeMission()
	fn3() -- inferred equivalent call
end

local function fn4()
	if _T.ActiveChallengeMission == nil then
		return
	end

	local challenge = _T.ActiveChallengeMission.challenge
	local __wf_atom_90b0de4e = gGameRules:__wf_atom_90b0de4e(challenge)
	local challengeDesc = ("/Lotus/Language/Challenges/Challenge_" .. fn2(challenge)) .. "_Desc"
	local setZarimanBounty = module.SetZarimanBounty
	local __wf_atom_18516282 = challenge:__wf_atom_18516282()
	module.SetBountyTitleText("/Lotus/Language/GameModes/ZarimanBountyHeader")
	module.SetZarimanBounty(1, challengeDesc, 1, 0, __wf_atom_18516282)
	return {
		ChallengeState = { IN_PROGRESS = 1, FAIL = 2, COMPLETE = 3 },
		challengeId = __wf_atom_90b0de4e,
		challengeDesc = challengeDesc,
		requiredCount = __wf_atom_18516282,
		setObjText = setZarimanBounty,
		progress = 0,
		previousProgress = _T.ActiveChallengeMission.previousProgress or 0,
		netVarSymbol = Symbol("ActiveChallengeProgress"),
		Update = function(state)
			if state.progress >= state.requiredCount then
				return state.ChallengeState.COMPLETE
			end

			if __wf_atom_539492fe:__wf_atom_3b3133b2(state.challengeId) then
				state.setObjText(1, state.challengeDesc, state.ChallengeState.FAIL, state.progress, state.requiredCount)
				return state.ChallengeState.FAIL
			end

			local progress = __wf_atom_539492fe:__wf_atom_ca6c1e48(state.challengeId) + state.previousProgress

			if progress == state.progress then
				return state.ChallengeState.IN_PROGRESS
			end

			state.progress = progress
			gGameRules:SetNetPersistentVar(state.netVarSymbol, state.progress)

			if state.progress >= state.requiredCount then
				state.setObjText(
					1,
					state.challengeDesc,
					state.ChallengeState.COMPLETE,
					state.progress,
					state.requiredCount
				)
				return state.ChallengeState.COMPLETE
			else
				state.setObjText(
					1,
					state.challengeDesc,
					state.ChallengeState.IN_PROGRESS,
					state.progress,
					state.requiredCount
				)
			end

			return state.ChallengeState.IN_PROGRESS
		end
	}
end

function SetActiveChallengeDebug(_) end

function SetActiveChallengeMission(activeChallengeMission)
	print("SetActiveChallengeMission called")
	_T.ActiveChallengeMission = activeChallengeMission
	_T.ActiveChallengeMission.challenge = Resource(_T.ActiveChallengeMission.challengeName)
	_T.TrackActiveChallenge = fn4
	_T.ClearActiveChallengeMission = fn3
end

function TryRecoverActiveChallenge()
	local __wf_atom_8b0475eb = gMatchingService:__wf_atom_8b0475eb()
	local decoded = cjson.decode(__wf_atom_8b0475eb)

	if decoded and decoded.challengeName then
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("ActiveChallengeProgress"), 0)
		print("recovering challenge mission. previous progress: " .. __wf_atom_d163c8e5)
		print("SetActiveChallengeMission called")

		if __wf_atom_d163c8e5 then
			decoded.previousProgress = __wf_atom_d163c8e5
		end

		_T.ActiveChallengeMission = decoded
		_T.ActiveChallengeMission.challenge = Resource(_T.ActiveChallengeMission.challengeName)
		_T.TrackActiveChallenge = fn4
		_T.ClearActiveChallengeMission = fn3
	end
end

function IsHardModeEventJob(_)
	return false
end