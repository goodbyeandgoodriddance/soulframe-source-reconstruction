function DoFinisher(object, instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(envoyAvatarType) then
		return
	end

	object:Disable()
	Sleep(0)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_f7e7be53:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			SF.__wf_atom_4659f336(__wf_atom_9fb9a1d6, false, true)
		end
	end

	if gRegion:IsMaster() and not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(soulHealFinisher)) then
		instance:Heal(instance, instance:GetMaxHealth())
		instance:__wf_atom_70ca09b9(soulHealFinisher, __wf_atom_f7e7be53)
	end

	local total = 0

	while not __wf_atom_7e8ad928(instance) and not instance:__wf_atom_611b620c() and total < 7 do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	local total2 = 0

	while not __wf_atom_7e8ad928(instance) and instance:__wf_atom_611b620c() and total2 < 7 do
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function TeleportToSoul()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StartSoulPlane"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerSPTeleportLoc"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraSPTeleporterLoc"))
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))

	if
		__wf_atom_7e8ad928(__wf_atom_0a6a5887)
		or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)
		or __wf_atom_7e8ad928(__wf_atom_0a6a5887_3)
	then
		return
	end

	if gRegion:IsMaster() then
		__wf_atom_0a6a5887_4:Teleport(__wf_atom_0a6a5887_3:GetPosition(), __wf_atom_0a6a5887_3:__wf_atom_dc309f8a())
		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:Teleport(
				__wf_atom_0a6a5887_2:GetPosition(),
				__wf_atom_0a6a5887_2:__wf_atom_dc309f8a()
			)

			if __wf_atom_ef7900cf[i]:__wf_atom_bedb4e3f() then
				__wf_atom_ef7900cf[i]:InstantRevive()
			end
		end

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:MotionControl():__wf_atom_99fc7a82(true)
			__wf_atom_ef7900cf[i]:CameraControl():__wf_atom_25382a0d(0.65, true)
		end
	end
end