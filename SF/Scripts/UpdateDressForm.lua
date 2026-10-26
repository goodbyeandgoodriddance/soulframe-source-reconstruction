function SwapDressFormMesh()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local v = __wf_atom_c4f78a8f:__wf_atom_f115b657() and 2 or 1

	if not __wf_atom_7e8ad928(dressFormHubNpc) then
		local bodyMesh = bodyMeshes[v]
		dressFormHubNpc:__wf_atom_45cf0e1a(Resource(bodyMesh), false, false)
	end
end