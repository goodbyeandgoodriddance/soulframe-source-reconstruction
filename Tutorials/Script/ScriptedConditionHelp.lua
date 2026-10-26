function Evaluate(object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget >= triggerMinRange
		and __wf_atom_9a1e4ed3.distanceToTarget <= triggerMaxRange
	then
		return true
	end

	return false
end