function PulseShield(instance)
	local __wf_atom_575542c8 = instance:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		print("Avatar not found")
		return
	end

	local __wf_atom_c6f1f83d = __wf_atom_575542c8:__wf_atom_c6f1f83d()
	local maxHealth = __wf_atom_575542c8:GetMaxHealth()
	local v = __wf_atom_421b01aa(__wf_atom_c6f1f83d / maxHealth * 1 + 0.25, 0, 1)
	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 0.15, 0, 1)
		instance:__wf_atom_a763aa1a(1 - __wf_atom_421b01aa(v2 * v, 0, 0.9))
		Sleep(0)
	end

	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / 0.6, 0, 1)
		instance:__wf_atom_a763aa1a(1 - __wf_atom_421b01aa((1 - v3) * v, 0, 0.9))
		Sleep(0)
	end

	instance:Destroy()
end

function GroundDecoStability(instance)
	local __wf_atom_575542c8 = instance:__wf_atom_575542c8()
	instance:__wf_atom_e6ed03c8()

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) do
		local __wf_atom_c6f1f83d = __wf_atom_575542c8:__wf_atom_c6f1f83d()
		local maxHealth = __wf_atom_575542c8:GetMaxHealth()
		local v = __wf_atom_421b01aa(__wf_atom_c6f1f83d / maxHealth * 1 + 0.25, 0.1, 0.75)

		if v < 0.265 then
			instance:Destroy()
		end

		instance:__wf_atom_a763aa1a(1 - v)
		local __wf_atom_1c374cc9 = __wf_atom_575542c8:__wf_atom_1c374cc9(Symbol("GAME_C1_HIP1"))
		gRegion:Raycast(__wf_atom_1c374cc9, __wf_atom_1c374cc9 + Vector(0, -2, 0), nil, nil, __wf_atom_1c374cc9, true)
		instance:SetPosition(__wf_atom_1c374cc9)
		Sleep(0.005)
	end
end