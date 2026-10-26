function GetCount(object)
	local __wf_atom_af937b39 = object:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) or __wf_atom_7e8ad928((__wf_atom_af937b39:__wf_atom_9be88b01())) then
		return 0
	end

	local total = 0

	for _, mLongGun in __wf_atom_af937b39:__wf_atom_af5caba7().mLongGuns do
		total += mLongGun.kills
	end

	return total
end

function MatchTagEvent(p, _)
	print("[CheckSecondaryKills] start")
	local v = GetCount(p)
	print(`[CheckSecondaryKills] User has {v} kills count (when needed {countToPass})`)

	if countToPass <= v then
		print("[CheckSecondaryKills] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end