function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
	then
		return false
	end

	if object:__wf_atom_d2b2176d():__wf_atom_73decaf7(true) then
		return false
	end

	return not __wf_atom_7e8ad928(throwableElixerItem)
end

function Activate(object, object2)
	if __wf_atom_7e8ad928(throwableElixerItem) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if object:IsMaster() then
		object:GiveItem(throwableElixerItem, true)
		local __wf_atom_97d575cf = __wf_atom_d2b2176d:__wf_atom_97d575cf(4)

		if
			not __wf_atom_7e8ad928(__wf_atom_97d575cf)
			and __wf_atom_97d575cf:__wf_atom_1bb5b1ff() == throwableElixerItem:__wf_atom_1bb5b1ff()
			and __wf_atom_97d575cf:IsA(__wf_atom_f7761fed)
		then
			__wf_atom_97d575cf:__wf_atom_a3138207(object2:__wf_atom_e14d8a8c())
		end
	end
end

function DeactivateItem(_, _) end