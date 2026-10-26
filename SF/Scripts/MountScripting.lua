function EnableKnockdownTrigger(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or __wf_atom_3d96ddcd:__wf_atom_08998754() ~= 2
		or not (__wf_atom_3d96ddcd:__wf_atom_ee4f0cba() > 1)
	then
		return false
	end

	return true
end