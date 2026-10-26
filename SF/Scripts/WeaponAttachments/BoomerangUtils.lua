function Fear(_, p, instance)
	if not instance:IsA(__wf_atom_67c46eba) then
		return
	end

	if gRegion:IsMaster() then
		local v = Symbol("CASTREACT")
		local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, 10)

		for _, v2 in ipairs(all) do
			if
				v2:__wf_atom_129d1aba(p)
				or v2:IsKilled()
				or v2:__wf_atom_bedb4e3f()
				or not v2:IsA(__wf_atom_9e85eea2)
			then
				continue
			end

			if v2:__wf_atom_7b82e9e1(6) or v2:__wf_atom_7b82e9e1(12) or v2 == instance then
				continue
			end

			local __wf_atom_30e3d82b = v2:__wf_atom_30e3d82b()

			if
				__wf_atom_7e8ad928(__wf_atom_30e3d82b)
				or not __wf_atom_30e3d82b:__wf_atom_04ea4887()
				or (v2:__wf_atom_fc8d8e90() or v2:__wf_atom_464a4772())
			then
				continue
			end

			v2:__wf_atom_58c8ffec(v, false, 4, 1, false, __wf_atom_5784a397(0, v2:__wf_atom_1ba2008d(v)))
		end

		if instance:__wf_atom_bb81a9df() < 0.35 then
			instance:__wf_atom_921c1a5f(deathAnim[__wf_atom_5784a397(1, 3)], false, 3, 3, true)
			instance:__wf_atom_7470861b():__wf_atom_f756036f(false)
			instance:__wf_atom_15b36b95(false)
			instance:__wf_atom_7470861b():__wf_atom_b6bcaf97(false)
			local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_0a399e71(true, 0)
				__wf_atom_30e3d82b:SetPaused(true, Symbol("Kid"))
			end
		end
	end
end