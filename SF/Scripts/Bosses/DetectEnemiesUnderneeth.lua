function DetectPresenceUnderneethEnemy(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or __wf_atom_3d96ddcd:IsKilled()
		or __wf_atom_3d96ddcd:__wf_atom_bedb4e3f()
	then
		return
	end

	__wf_atom_3d96ddcd:SetBlackboardBool(Symbol("IsUnderneeth"), isUnderneeth)
end