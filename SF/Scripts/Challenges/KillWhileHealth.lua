function MatchAttackEvent(object, object2)
	if not object:__wf_atom_d0af6a2c() or __wf_atom_7e8ad928(object2:__wf_atom_50a7d83e()) then
		return false
	end

	local __wf_atom_bb81a9df = object2:__wf_atom_50a7d83e():__wf_atom_bb81a9df()

	if healthMaxPercentage < __wf_atom_bb81a9df and healthMaxPercentage < 1 then
		return false
	end

	return not (__wf_atom_bb81a9df < healthMinPercentage and healthMinPercentage > -1)
end