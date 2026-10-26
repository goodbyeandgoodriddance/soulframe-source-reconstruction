function DoWarningShout(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()
	local __wf_atom_30e3d82b = __wf_atom_6009c8ed:__wf_atom_30e3d82b()

	if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsMaster()) then
		return
	end

	local v = -100

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object)) do
		Sleep(0)
		local __wf_atom_f9b5aca2 = __wf_atom_21ed1a39:__wf_atom_f9b5aca2()

		if __wf_atom_f9b5aca2 < v then
			break
		end

		if warningShoutTime < __wf_atom_f9b5aca2 then
			__wf_atom_30e3d82b:__wf_atom_9356c1bd(bark, barkFilter)
			break
		else
			v = __wf_atom_f9b5aca2
		end
	end
end