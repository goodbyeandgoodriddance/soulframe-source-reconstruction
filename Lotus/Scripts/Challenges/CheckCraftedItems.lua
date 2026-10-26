function MatchTagEvent(_, _, _, _, instance)
	if __wf_atom_7e8ad928(instance) then
		return false
	end

	for i = 1, #requiredItems do
		if instance:IsA(requiredItems[i]) then
			return true
		end
	end

	return false
end