function MatchTagEvent(_, _, _, instance)
	print("activated an ability", instance)

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(baseRuneAbility) then
		return false
	end

	return instance:IsA(baseRuneAbility)
end