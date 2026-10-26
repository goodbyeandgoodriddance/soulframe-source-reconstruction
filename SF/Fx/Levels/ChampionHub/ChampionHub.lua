function FennGhost(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v = 0
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(ghostType)
	object:Attach(burstFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:PlaySound(activateSound, false)

	if reverse then
		Sleep(2)
	end

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / transitionTime, 0, 1)
		local v2 = __wf_atom_24a82b69(v)

		if reverse then
			v2 = 1 - v2
		end

		object:__wf_atom_a763aa1a(v2)
		object:__wf_atom_68f2c268(v2)
		__wf_atom_bb3e7833:__wf_atom_a763aa1a(1 - v2)
		__wf_atom_bb3e7833:__wf_atom_68f2c268(1 - v2)
		Sleep(0)
	end
end