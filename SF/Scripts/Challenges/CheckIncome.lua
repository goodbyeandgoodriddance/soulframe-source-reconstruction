function GetCount(object)
	local __wf_atom_af937b39 = object:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) or __wf_atom_7e8ad928((__wf_atom_af937b39:__wf_atom_9be88b01())) then
		return 0
	end

	return (math.max(__wf_atom_af937b39:__wf_atom_af5caba7().mIncome, gGameData:__wf_atom_7050e489()))
end

function MatchTagEvent(p, _)
	print("[CheckIncome] start")
	local v = GetCount(p)
	print(`[CheckIncome] User has {v} count (when needed {countToPass})`)

	if countToPass <= v then
		print("[CheckIncome] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end