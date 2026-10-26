function PulseScale(object)
	math.random()
	local v = Vector(2, 2, 2)
	local v2 = Vector(2, 2, 2)
	local v3 = Vector(2, 2, 3)
	local v4 = Vector(0.5, 0.5, 0.5)
	local v5 = Vector(3, 3, 3)
	local v6 = 1

	while not __wf_atom_7e8ad928(object) do
		if v6 < 0.1 then
			object:__wf_atom_83fac646(Symbol("GAME_L1_ARM2"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v)
		elseif v6 < 0.2 then
			object:__wf_atom_83fac646(Symbol("GAME_R1_ARM1"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v2)
		elseif v6 < 0.3 then
			object:__wf_atom_83fac646(Symbol("GAME_C1_SPINE1"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v3)
			object:__wf_atom_83fac646(Symbol("GAME_C1_NECK2"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v4)
		else
			object:__wf_atom_83fac646(Symbol("GAME_C1_NECK2"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v5)
		end

		Sleep(0)
	end
end