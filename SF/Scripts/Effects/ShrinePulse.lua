local function fn(instance, p)
	if not __wf_atom_7e8ad928(instance) and instance:IsMaster() and instance:IsA(__wf_atom_4ebf67cb) then
		local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:__wf_atom_19516b62(p)
			end
		end
	end
end

function PulseShrine(object, object2)
	local v = 0
	local total = 0
	local flag = true

	if __wf_atom_7e8ad928(object2:__wf_atom_a96eb2aa()) then
		return
	end

	local __wf_atom_6be84646 = object2:__wf_atom_a96eb2aa():__wf_atom_6be84646()

	if not _T.ShrinePulses then
		_T.ShrinePulses = {}
	end

	local position = object:GetPosition()

	if _T.ShrinePulses[__wf_atom_6be84646] == position then
		flag = false
	end

	_T.ShrinePulses[__wf_atom_6be84646] = position

	if not flag then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	__wf_atom_3d96ddcd:Attach(pulseFX, EMPTY_SYMBOL)

	while v < 1 do
		local v2 = __wf_atom_084b3e93()
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, 1)
		__wf_atom_3d96ddcd:SetMaterialParam(Symbol("EmissiveMapAtten"), __wf_atom_24a82b69(v) * 6)
		local v3 = v2 * energyToGive
		total += v3

		if flag then
			fn(object2, v3)
		end

		Sleep(0)
	end
end