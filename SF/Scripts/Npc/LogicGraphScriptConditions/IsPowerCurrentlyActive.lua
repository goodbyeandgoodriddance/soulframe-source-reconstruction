function Evaluate(object)
	local __wf_atom_e55d02aa = object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_248bb7ae = __wf_atom_e55d02aa:__wf_atom_248bb7ae(powerSuitAbility)
	local v = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()[__wf_atom_248bb7ae + 1]

	if __wf_atom_7e8ad928(v) or not v:IsActive() then
		return false
	end

	v:IsActive()
	return true
end