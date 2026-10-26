function TeleportToTagged()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol(teleportTag))
	local playerAvatar = gRegion:GetPlayerAvatar()

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	playerAvatar:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	playerAvatar:__wf_atom_f0f9fb38(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
end