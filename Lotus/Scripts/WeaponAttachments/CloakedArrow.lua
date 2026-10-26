function HideProjector(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9578cbaa)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:SetVisibility(false, true)
	end
end

function ShowProjector(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9578cbaa)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:SetVisibility(true, true)
	end
end