function OnOwnerSet(object)
	local __wf_atom_95e72410 = object:__wf_atom_95e72410()

	if __wf_atom_7e8ad928(__wf_atom_95e72410) then
		return
	end

	local __wf_atom_30e3d82b = __wf_atom_95e72410:__wf_atom_30e3d82b()

	while not (__wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_95e72410:IsKilled()) do
		if __wf_atom_30e3d82b:__wf_atom_04ea4887() then
			local __wf_atom_d2b2176d = __wf_atom_95e72410:__wf_atom_d2b2176d()

			if __wf_atom_d2b2176d:__wf_atom_97d575cf(4) == object then
				local __wf_atom_8e4cf043 = __wf_atom_95e72410:__wf_atom_8e4cf043(weaponBone)
				local v = __wf_atom_95e72410:__wf_atom_1c374cc9(weaponBone) + __wf_atom_9341614d(decoOffset, __wf_atom_8e4cf043)
				gRegion:CreateEntity(forceDropDeco, v, __wf_atom_8e4cf043, __wf_atom_95e72410)

				if gRegion:IsMaster() then
					__wf_atom_95e72410:__wf_atom_78ad8b9f(103, 0)
					__wf_atom_d2b2176d:__wf_atom_6cdc5077()
				end

				break
			end
		end

		Sleep(1)
	end
end