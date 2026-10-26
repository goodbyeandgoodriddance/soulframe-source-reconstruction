local function fn(p)
	for i = 1, #mixingGroups do
		local mixingGroup = mixingGroups[i]

		if __wf_atom_7e8ad928(mixingGroup) or not mixingGains[i] or not mixingOcclusions[i] then
			continue
		end

		mixingGroup:__wf_atom_c2a0827a(__wf_atom_104bfe98(0, mixingGains[i], p))
		mixingGroup:__wf_atom_c1782862(__wf_atom_104bfe98(0, mixingOcclusions[i], p))
	end
end

function AimGravityFX(instance)
	local isA = instance:IsA(__wf_atom_7e6ed5fa)
	local v = nil
	local v2 = nil
	Sleep(0.1)

	if
		instance:__wf_atom_08998754() == 20
		or instance:__wf_atom_08998754() == 21
		or instance:__wf_atom_08998754() == 22
	then
		return
	end

	instance:PlaySound(aimGravityEnterSound, false, -1, false)

	if not __wf_atom_7e8ad928(aimGravitySpawner) then
		v = instance:Attach(aimGravitySpawner, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(aimGlideAttach) then
		v2 = instance:Attach(aimGlideAttach, EMPTY_SYMBOL)
	end

	instance:__wf_atom_c2c1e7e7()
	local v3 = 0

	while
		not __wf_atom_7e8ad928(instance)
		and not instance:IsKilled()
		and (instance:__wf_atom_7b82e9e1(0) or instance:__wf_atom_7b82e9e1(26))
		and instance:__wf_atom_7b82e9e1(15)
		and instance:__wf_atom_c2c1e7e7() > 0
		and (not isA or instance:__wf_atom_535d5cbb())
	do
		local __wf_atom_c2c1e7e7 = instance:__wf_atom_c2c1e7e7()

		if not __wf_atom_7e8ad928(v2) then
			v2:SetMaterialParam(
				SF.__wf_atom_473a1df0,
				(math.pow(__wf_atom_421b01aa(__wf_atom_c2c1e7e7 * 2, 0, 1), 0.5))
			)
		end

		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * mixerRatioSpeed, 0, 1)
		fn(v3)
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) then
		instance:PlaySound(aimGravityExitSound, false, -1, false)
	end

	if not __wf_atom_7e8ad928(v) then
		v:Destroy()
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	while v3 > 0 do
		v3 = __wf_atom_421b01aa(v3 - __wf_atom_084b3e93(), 0, 1)
		fn(v3)
		Sleep(0)
	end
end