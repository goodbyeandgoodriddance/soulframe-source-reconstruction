function MatchAttackEvent(object, _)
	local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

	for _, className in ipairs(vehicleTypes) do
		if __wf_atom_6ce58983:IsA(className) then
			return (__wf_atom_6ce58983:__wf_atom_16d5a01d())
		end
	end

	return true
end