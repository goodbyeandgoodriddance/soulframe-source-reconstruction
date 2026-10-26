function UpdatePulse(object)
	Sleep(0)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_465d956f)

	while not __wf_atom_7e8ad928(object) and __wf_atom_f582136d and not __wf_atom_7e8ad928(__wf_atom_f582136d[1]) do
		local __wf_atom_fea764d9 = __wf_atom_f582136d[1]:__wf_atom_fea764d9()

		if not __wf_atom_7e8ad928(__wf_atom_fea764d9[2]) then
			local __wf_atom_31aab74c = __wf_atom_fea764d9[2]:__wf_atom_31aab74c()
			local v = __wf_atom_104bfe98(0.5, 30, __wf_atom_31aab74c)
			object:SetMaterialParam(Symbol("EmissiveMapAtten"), v)
			local v2 = Vector(0.4, 1, 0.4)
			local v3 = Vector(1.4, 2, 1.4)
			local v4 = __wf_atom_f55d6358(v2, v3, __wf_atom_31aab74c)
			object:__wf_atom_fd3ec680(Symbol("vScales"), -1, v4.x, v4.y, v4.z, 0, true)
		end

		Sleep(0)
	end
end