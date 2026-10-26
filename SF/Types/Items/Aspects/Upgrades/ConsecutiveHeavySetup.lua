function MatchTagEvent(_, _, _, instance)
	if __wf_atom_7e8ad928(instance) or not (instance:IsA(__wf_atom_77e05d3b) and instance:__wf_atom_2341f55d()) then
		return false
	end

	return true
end

function ResetOnTagEvent(_, _, _, instance)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		local __wf_atom_75a0566d = instance:__wf_atom_75a0566d()

		if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
			local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

			if __wf_atom_f824cfe6 == 4 or __wf_atom_f824cfe6 == 16 then
				return true
			end
		end
	end

	return false
end