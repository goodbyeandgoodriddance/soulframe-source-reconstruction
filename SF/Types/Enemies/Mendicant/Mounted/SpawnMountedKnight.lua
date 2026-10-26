local bbActiveMountAvatar = nil
local v = nil
local v2 = nil

function SpawnAgentMount(instance)
	instance:SetVisibility(false)
	Sleep(0)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local bSpawnRotation = instance:__wf_atom_dc309f8a()
	local position = instance:GetPosition()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bSpawnRotation) then
		bSpawnRotation = __wf_atom_e919fb8e.bSpawnRotation
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("MendicantHorse"), position, 0, 5)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		local __wf_atom_68de036a = instance:__wf_atom_68de036a()
		v = v2:__wf_atom_402b3832(
			mountAgentType,
			position,
			bSpawnRotation,
			EMPTY_SYMBOL,
			__wf_atom_68de036a,
			spawnAnimation
		)

		if __wf_atom_7e8ad928(v) then
			print("Failed to spawn mount")
			instance:Destroy()
			return
		else
			bbActiveMountAvatar = v:__wf_atom_50a7d83e()
		end
	else
		bbActiveMountAvatar = __wf_atom_f738b4af
		v = __wf_atom_f738b4af:__wf_atom_30e3d82b()
	end

	bbActiveMountAvatar:SetVisibility(false)
	local __wf_atom_e919fb8e_2 = instance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.bbActiveMountAvatar = bbActiveMountAvatar
	Sleep(0)
	bbActiveMountAvatar:__wf_atom_2f5a3d03(instance, true)
	Sleep(0.25)
	instance:__wf_atom_d2b2176d():Equip(5, 0, 2)
	instance:SetVisibility(true)
	bbActiveMountAvatar:SetVisibility(true)
	local entity = gRegion:CreateEntity(gooEffects, position, bSpawnRotation)
	local entity2 = gRegion:CreateEntity(moreSpawnEffects, position, bSpawnRotation)
	local v3 = 1

	while v3 > 0 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_a763aa1a(v3)
		Sleep(0)
		v3 -= __wf_atom_084b3e93() * 3
	end

	while bbActiveMountAvatar:__wf_atom_06a75154() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity2) then
		entity2:Destroy()
	end

	while v3 < 1 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_a763aa1a(v3)
		Sleep(0)
		v3 += __wf_atom_084b3e93() * 2
	end
end