function DestroyFawn(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FawnDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		gRegion:CreateEntity(SpiritFX, object:__wf_atom_a2a18137(), __wf_atom_80368bb1)
		__wf_atom_0a6a5887:__wf_atom_de14bbe2(false, true, false, 1)
		__wf_atom_0a6a5887:__wf_atom_7b7015c9(nil)
		local v = 0

		while v < 1 do
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, 1)
			__wf_atom_0a6a5887:__wf_atom_68f2c268(v)
			Sleep(0)
		end

		gRegion:__wf_atom_dd1e4d10(__wf_atom_0a6a5887)
	end
end