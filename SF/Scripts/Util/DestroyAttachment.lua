function DestroyOwnerAttachmentOfType(object)
	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_bb3e7833 = creator:__wf_atom_bb3e7833(attachmentType)

	if not __wf_atom_7e8ad928(attachmentType) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
	end

	if checkRagdoll and creator:IsA(__wf_atom_4ebf67cb) and not __wf_atom_7e8ad928((creator:__wf_atom_f51f1faa())) then
		local __wf_atom_bb3e7833_2 = creator:__wf_atom_bb3e7833(attachmentType)

		if not __wf_atom_7e8ad928(attachmentType) then
			gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833_2)
		end
	end
end