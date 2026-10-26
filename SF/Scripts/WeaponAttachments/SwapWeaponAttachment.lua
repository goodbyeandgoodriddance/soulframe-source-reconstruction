function SwapAttachmentMesh(object)
	object:__wf_atom_45cf0e1a(mesh, true, false)

	if not __wf_atom_7e8ad928(swapSound) then
		object:PlaySound(swapSound, false, 1, false)
	end
end