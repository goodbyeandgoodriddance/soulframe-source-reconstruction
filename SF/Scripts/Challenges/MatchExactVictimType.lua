function MatchAttackEvent(object, _)
	if not object:__wf_atom_d0af6a2c() then
		return false
	end

	local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

	if not __wf_atom_7e8ad928(__wf_atom_6ce58983) and __wf_atom_6ce58983:__wf_atom_1bb5b1ff() == targetType then
		print("matched", __wf_atom_6ce58983:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b(), targetType)
		return true
	end

	return false
end