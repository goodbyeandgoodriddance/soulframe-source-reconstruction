function BromiusHeadHitReactOnDamage(object, object2)
	local __wf_atom_64c2ae79 = object2:__wf_atom_64c2ae79()

	if not __wf_atom_7e8ad928(__wf_atom_64c2ae79) then
		if not __wf_atom_7e8ad928(middleHeadProxy) and __wf_atom_64c2ae79:IsA(middleHeadProxy) then
			object:__wf_atom_78ad8b9f(107, 0)
		elseif __wf_atom_7e8ad928(leftHeadProxy) or not __wf_atom_64c2ae79:IsA(leftHeadProxy) then
			if not __wf_atom_7e8ad928(rightHeadProxy) and __wf_atom_64c2ae79:IsA(rightHeadProxy) then
				object:__wf_atom_78ad8b9f(107, 2)
			end
		else
			object:__wf_atom_78ad8b9f(107, 1)
		end
	end
end