function CmdAddJob(p, p2, p3)
	local jobType = Resource(p)

	if __wf_atom_7e8ad928(jobType) then
		__wf_atom_f2daf912("Job type not found")
		return
	end

	local DEBUG_JOBS = _T.DEBUG_JOBS or {}
	_T.DEBUG_JOBS = DEBUG_JOBS

	for i = 1, #DEBUG_JOBS do
		if DEBUG_JOBS[i].jobType == jobType then
			return
		end
	end

	local __wf_atom_d4fa771b = jobType:__wf_atom_d4fa771b()
	local stages = {}
	local xpAmounts = {}

	for i = 1, #__wf_atom_d4fa771b do
		stages[i] = __wf_atom_d4fa771b[i].encounterChoices[__wf_atom_5784a397(
			1,
			#__wf_atom_d4fa771b[i].encounterChoices
		)]
		xpAmounts[i] = 0
	end

	table.insert(DEBUG_JOBS, {
		jobId = jobType:__wf_atom_5b41f63b(),
		name = Localize(tostring(jobType:__wf_atom_4f3855f9()), nil),
		desc = Localize(tostring(jobType:__wf_atom_9d4f2308()), nil),
		icon = jobType:GetIconTexture(),
		stages = stages,
		reward = nil,
		seed = __wf_atom_3e61816b(__wf_atom_5784a397(0, 1073741824)),
		jobType = jobType,
		jobTypeName = jobType:__wf_atom_5b41f63b(),
		masteryReq = 0,
		minEnemyLevel = tonumber(p2) or 15,
		maxEnemyLevel = tonumber(p3) or 20,
		xpAmounts = xpAmounts,
		syndicateTag = EMPTY_SYMBOL,
		transmissionSet = jobType:__wf_atom_d0c8d09f(),
		skipInventoryUpdate = true,
		expiry = nil,
		hasCompleted = false,
		isDebug = true
	})
	_T.RefreshJobs = true
end