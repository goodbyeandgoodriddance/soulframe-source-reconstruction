function CopyMatOverridesToChildren(object)
	Sleep(0)
	local __wf_atom_c0d09e05 = object:__wf_atom_c0d09e05()

	if __wf_atom_c0d09e05 == 0 then
		return
	end

	local __wf_atom_0c59b746 = object:__wf_atom_0c59b746()

	if not __wf_atom_7e8ad928(__wf_atom_0c59b746) then
		for i = 1, #__wf_atom_0c59b746 do
			if __wf_atom_7e8ad928(__wf_atom_0c59b746[i].mInstance) then
				continue
			end

			local __wf_atom_c0d09e05_2 = __wf_atom_0c59b746[i].mInstance:__wf_atom_c0d09e05()

			for j = 0, __wf_atom_c0d09e05 - 1 do
				if not (j < __wf_atom_c0d09e05_2) then
					continue
				end

				local __wf_atom_3de89c8e = object:__wf_atom_3de89c8e(j)
				__wf_atom_0c59b746[i].mInstance:__wf_atom_a887a262(j, __wf_atom_3de89c8e)
			end
		end
	end
end