function GetCount(object)
	local __wf_atom_af937b39 = object:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) or __wf_atom_7e8ad928((__wf_atom_af937b39:__wf_atom_9be88b01())) then
		return 0
	end

	local kills = 0

	for _, mSkillTree in __wf_atom_af937b39:__wf_atom_af5caba7().mSkillTrees do
		if mSkillTree.type == skillTree then
			kills = mSkillTree.kills
		end
	end

	return kills
end

function MatchTagEvent(p, _)
	print("[CheckSkillTreeKills] start")
	local v = GetCount(p)
	print(`[CheckSkillTreeKills] User has {v} kills count (when needed {countToPass})`)

	if countToPass <= v then
		print("[CheckSkillTreeKills] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end