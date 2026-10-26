function TeleportToArena(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraToGarrenTransition"))

	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerArenaTeleportLoc"))
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraArenaTeleporterLoc"))
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))
		__wf_atom_0a6a5887_4:Teleport(__wf_atom_0a6a5887_3:GetPosition(), __wf_atom_0a6a5887_3:__wf_atom_dc309f8a())

		for i = 1, #__wf_atom_ef7900cf do
			if not __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				__wf_atom_ef7900cf[i]:Teleport(
					__wf_atom_0a6a5887_2:GetPosition(),
					__wf_atom_0a6a5887_2:__wf_atom_dc309f8a()
				)
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:FirePort("StartPlaying")

			while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
				Sleep(0)
			end

			if __wf_atom_0a6a5887:__wf_atom_e9546dc6() then
				local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenRood"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
					print("host: DeoraToGarrenTransition cinematic skipped: enabling garren visibility!")
					__wf_atom_0a6a5887_5:SetVisibility(true, true)
				end
			end
		end

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:MotionControl():__wf_atom_99fc7a82(false)
			__wf_atom_ef7900cf[i]:CameraControl():__wf_atom_25382a0d(1, false)
		end

		__wf_atom_0a6a5887_4:SetBlackboardBool(Symbol("DeoraHealed"), true)
	elseif not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) do
			Sleep(0)
		end

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		if __wf_atom_0a6a5887:__wf_atom_e9546dc6() then
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenRood"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				print("client: DeoraToGarrenTransition cinematic skipped: enabling garren visibility!")
				__wf_atom_0a6a5887_2:SetVisibility(true, true)
			end
		end
	end
end

function HideDeoraWeapon()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_9fb9a1d6 = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	SF.__wf_atom_4659f336(__wf_atom_9fb9a1d6, false, true)
end

function HideDeoraWeaponEnd()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_9fb9a1d6 = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if gRegion:IsMaster() then
		__wf_atom_0a6a5887:__wf_atom_d2b2176d():Unequip(0, 2)
		__wf_atom_9fb9a1d6:__wf_atom_cfecab5d(true)
	end

	SF.__wf_atom_4659f336(__wf_atom_9fb9a1d6, false, true)
end

function HideDeora()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:SetVisibility(false)
end

function EquipWeapon()
	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		if __wf_atom_7e8ad928(__wf_atom_ef7900cf) then
			return
		end

		for i = 1, #__wf_atom_ef7900cf do
			__wf_atom_ef7900cf[i]:__wf_atom_d2b2176d():Equip(5, 0, 2)
		end
	end
end

function UnequipWeapon()
	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		if __wf_atom_7e8ad928(__wf_atom_ef7900cf) then
			return
		end

		for i = 1, #__wf_atom_ef7900cf do
			local __wf_atom_d2b2176d = __wf_atom_ef7900cf[i]:__wf_atom_d2b2176d()
			local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

			if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and __wf_atom_9fb9a1d6:__wf_atom_c5d04cb3() then
				__wf_atom_9fb9a1d6:__wf_atom_36d7c7d8()
			end

			__wf_atom_d2b2176d:Unequip(0, 2)
		end
	end
end

function ShowHealedGarren()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true, true)
	end
end