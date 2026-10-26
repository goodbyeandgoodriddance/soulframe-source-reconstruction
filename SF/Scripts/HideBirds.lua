function birdhider()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("MooseBird"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetVisibility(false)
	end
end

function birdShow()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("MooseBird"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetVisibility(true)
	end
end