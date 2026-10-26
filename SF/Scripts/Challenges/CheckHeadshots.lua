function GetCount(object)
	local __wf_atom_af937b39 = object:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) or __wf_atom_7e8ad928((__wf_atom_af937b39:__wf_atom_9be88b01())) then
		return 0
	end

	return __wf_atom_af937b39:__wf_atom_af5caba7().mHeadshots
end

function MatchTagEvent(p, _)
	print("[CheckHeadshots] start")
	local v = GetCount(p)
	print(`[CheckHeadshots] User has {v} count (when needed {countToPass})`)

	if countToPass <= v then
		print("[CheckHeadshots] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end