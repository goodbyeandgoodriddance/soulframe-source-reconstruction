function MatchAttackEvent(object, _)
	if object:__wf_atom_d0af6a2c() then
		local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

		if
			not __wf_atom_7e8ad928(__wf_atom_6ce58983)
			and __wf_atom_6ce58983:IsA(__wf_atom_67c46eba)
			and __wf_atom_6ce58983:__wf_atom_e93896ba() == faction
		then
			return true
		end
	end

	return false
end