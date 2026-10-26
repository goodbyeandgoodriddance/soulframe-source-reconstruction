local module = require("SF.Scripts.NightFoldLib")

function ApplyRulesToLocalAvatarWhileInside(object)
	local v

	if detectNonStandardAvatars == true then
		v = object:__wf_atom_fdb586e3()
	else
		while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
			Sleep(0)
		end

		v = gRegion:__wf_atom_c4f78a8f()
	end

	if tennoOnly == true and v:IsA(__wf_atom_7e6ed5fa) == false then
		return
	end

	local v2 = false
	v:GiveItem(forcedGivenItem, forcedGivenItemEquipped)
	local __wf_atom_d2b2176d = v:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_9fb9a1d6()) then
		__wf_atom_d2b2176d:__wf_atom_9fb9a1d6():__wf_atom_cfecab5d(hideHolsteredMeleeWeapons)
	end

	while not __wf_atom_7e8ad928(v) and object:__wf_atom_4b409d7b(v) do
		v:__wf_atom_aeb02c14(forceInputFilter)

		if restrictNightfold and not v2 then
			module.RegisterPreventNighfoldUsage(true, "AvatarRestrictions")
			v2 = true
		end

		if forceWalk then
			v:MotionControl():__wf_atom_99fc7a82(forceWalk)
		end

		if restrictNightfold and not __wf_atom_7e8ad928(v:CameraControl()) and setFOVWhileInside > 0 then
			v:CameraControl():__wf_atom_25382a0d(setFOVWhileInside, false)
		end

		v:__wf_atom_a142b1ea(allowRun)
		__wf_atom_d2b2176d:EnableWeaponFiring(allowWeaponFiring)
		local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

		if not (__wf_atom_7e8ad928(__wf_atom_e55d02aa) or allowAbilities) then
			__wf_atom_e55d02aa:__wf_atom_2ffcdee6()
			__wf_atom_e55d02aa:__wf_atom_c31a704b(allowAbilities)
		end

		__wf_atom_d2b2176d:__wf_atom_c8700ab5(allowWeaponsDrawn)
		Sleep(0.1)
	end

	if not __wf_atom_7e8ad928(v) then
		if restrictNightfold then
			module.RegisterPreventNighfoldUsage(false, "AvatarRestrictions")
		end

		v:__wf_atom_cf966a74(forceInputFilter)
		v:MotionControl():__wf_atom_99fc7a82(onExitForceWalk)

		if restrictNightfold and not __wf_atom_7e8ad928(v:CameraControl()) and setFOVWhileInside > 0 then
			v:CameraControl():__wf_atom_25382a0d(1, false)
		end

		__wf_atom_d2b2176d:__wf_atom_c8700ab5(onExitAllowWeaponsDrawn)
		__wf_atom_d2b2176d:EnableWeaponFiring(onExitAllowWeaponFiring)
		local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_c31a704b(onExitAllowAbilities)
		end

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_9fb9a1d6()) then
			__wf_atom_d2b2176d:__wf_atom_9fb9a1d6():__wf_atom_cfecab5d(not onExitShowHolsteredMeleeWeapons)
		end

		v:__wf_atom_a142b1ea(onExitAllowRun)
	end
end