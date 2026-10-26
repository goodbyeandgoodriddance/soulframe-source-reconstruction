function OverrideAuxAttachment(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	__wf_atom_21ed1a39:__wf_atom_9cd0639b(auxiliaryIndex, localPos, localRot, lookAtEnable)
end

function ChangeToBehavior(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	if behaviorIndex < __wf_atom_21ed1a39:__wf_atom_ca3e110b() then
		__wf_atom_21ed1a39:SetBehavior(behaviorIndex)
	end
end