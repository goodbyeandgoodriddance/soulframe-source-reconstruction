function StartMod(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object3) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_28224c27(1)) then
		local __wf_atom_06f3cb74 = object3:__wf_atom_06f3cb74()
		local __wf_atom_18aa6e58 = object3:__wf_atom_18aa6e58()

		for i = 1, __wf_atom_06f3cb74 do
			local __wf_atom_b9a1f18c = object3:__wf_atom_b9a1f18c(i - 1)
			object2:__wf_atom_e85205e8(__wf_atom_b9a1f18c, __wf_atom_18aa6e58)
			__wf_atom_d2b2176d:RemoveUpgrade(__wf_atom_b9a1f18c)
		end
	end
end