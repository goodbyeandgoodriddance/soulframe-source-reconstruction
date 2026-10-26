function DissolveGhost(object)
	gRegion:CreateEntity(ghostDeathFX, object:__wf_atom_a2a18137(), __wf_atom_80368bb1)
	local v = 0

	while not __wf_atom_7e8ad928(object) and v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(v)
		Sleep(0)
	end
end