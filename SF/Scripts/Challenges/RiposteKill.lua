function MatchAttackEvent(object, _)
	if not object:__wf_atom_d0af6a2c() then
		return false
	end

	local __wf_atom_3371f607 = object:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
		local __wf_atom_75a0566d = __wf_atom_3371f607:__wf_atom_75a0566d()
		return not __wf_atom_7e8ad928(__wf_atom_75a0566d) and __wf_atom_75a0566d:__wf_atom_f824cfe6() == 33
	end

	return false
end