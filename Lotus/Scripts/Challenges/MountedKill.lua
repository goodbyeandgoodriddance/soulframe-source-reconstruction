function MatchAttackEvent(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_6ce58983():__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return false
	end

	for _, className in ipairs(dropshipTypes) do
		if __wf_atom_3d96ddcd:IsA(className) then
			return true
		end
	end

	return false
end