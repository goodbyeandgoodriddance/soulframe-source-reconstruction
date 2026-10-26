function eyeglowmonitor(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
		return
	end

	__wf_atom_3d96ddcd:__wf_atom_bb81a9df()

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if __wf_atom_3d96ddcd:__wf_atom_bb81a9df() <= 0 then
			object:__wf_atom_0869b376(1)
			Sleep(1.25)
			break
		else
			Sleep(0)
		end
	end
end