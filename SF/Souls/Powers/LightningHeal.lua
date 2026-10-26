local v = __wf_atom_10cd16b2(0, 0.2)

function AdjustAvatarBendToTarget(object)
	Engine.__wf_atom_878bebe4(object)
	Sleep(0)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	while not (object:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(object) or object:IsKilled()) do
		local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()
		local v2

		if __wf_atom_7e8ad928(__wf_atom_216d6edd) then
			v2 = 0
		else
			local v3 = __wf_atom_216d6edd:EyePosition() - object:EyePosition()
			Normalize(v3)
			local v4 = -math.deg((math.atan(v3.y)))
			v2 = __wf_atom_421b01aa(v4, minAngle, maxAngle)
		end

		local __wf_atom_2490589b = v:__wf_atom_2490589b(v2, object:__wf_atom_5439d809() * __wf_atom_084b3e93())

		if humanoidAdjust then
			local v3 = __wf_atom_2490589b / 4
			object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE2"), Rotation(0, 0, v3), __wf_atom_28d5d4aa)
			object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE3"), Rotation(0, 0, v3), __wf_atom_28d5d4aa)
			object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE4"), Rotation(0, 0, v3), __wf_atom_28d5d4aa)
			object:__wf_atom_e3c998ce(Symbol("GAME_L1_CLAV1"), Rotation(0, 0, v3), __wf_atom_28d5d4aa)
			object:__wf_atom_e3c998ce(Symbol("GAME_R1_CLAV1"), Rotation(0, 0, v3), __wf_atom_28d5d4aa)
		elseif zForward then
			object:__wf_atom_e3c998ce(adjustBone, Rotation(__wf_atom_2490589b, 0, 0), __wf_atom_28d5d4aa)
		else
			object:__wf_atom_e3c998ce(adjustBone, Rotation(0, 0, __wf_atom_2490589b), __wf_atom_28d5d4aa)
		end

		Sleep(0)
	end
end

function ZapHeal(object)
	if __wf_atom_7e8ad928(object) or isEnabled == false then
		return
	end

	Sleep(0)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(spawnAnimation, false) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	Sleep(0)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if
		__wf_atom_7e8ad928(__wf_atom_e55d02aa)
		or __wf_atom_7e8ad928(__wf_atom_30e3d82b)
		or __wf_atom_7e8ad928(ammpedUpAbility)
		or __wf_atom_7e8ad928(object)
	then
		return
	end

	__wf_atom_30e3d82b:__wf_atom_cca1dc04(ammpedUpAbility, object, true)

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	object:__wf_atom_8a035cd5(Symbol("AdjustAvatarBendToTarget"), false)
	local v2 = object:Attach(ambientZapFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local v3 = nil
	local v4 = false
	local healCooldown2 = 0

	while
		not object:__wf_atom_bedb4e3f()
		and not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
		and _T.NimrodSkyCleared ~= true
	do
		local v5 = object:__wf_atom_c6f1f83d() / object:GetMaxHealth()

		if v5 < pctHealthAtWhichToStartHealing and pctHealthAtWhichToStopHealing < v5 then
			if v4 == false then
				v2:Destroy()
				v3 = object:Attach(zapLeadinFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				v4 = true
			end

			if healCooldown2 <= 0 then
				healCooldown2 = healCooldown

				while
					not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
					and __wf_atom_e55d02aa:__wf_atom_e01933cb()
					and __wf_atom_e55d02aa:__wf_atom_47fbd15c()
				do
					Sleep(0)
				end

				object:Attach(zapfx, Symbol("GAME_C1_HEAD1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)

				if not __wf_atom_7e8ad928(v3) then
					v3:Destroy()
				end

				object:__wf_atom_8a035cd5(Symbol("HealOverTime"), false)
				_T.ShowBossBarLightning = 3.5
				v2 = object:Attach(ambientZapFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				v4 = false
			end

			healCooldown2 -= __wf_atom_084b3e93()
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	if
		not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
		and __wf_atom_e55d02aa:__wf_atom_e21e8409(ammpedUpAbility):IsActive()
	then
		__wf_atom_e55d02aa:DeactivateAbility(ammpedUpAbility)
	end
end

function HealOverTime(object)
	local v2 = 3
	local v3 = (object:GetMaxHealth() - object:__wf_atom_c6f1f83d()) * (missingHealthRecoveryPercent / 100) / v2
	local total = 0

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and v2 > 0 do
		local v4 = v3 * __wf_atom_03df4e1d()

		if v4 < 1 then
			total += v4

			if total > 1 then
				object:SetHealth(object:__wf_atom_c6f1f83d() + math.floor(total))
				total = 0
			end
		else
			object:SetHealth(object:__wf_atom_c6f1f83d() + math.floor(v4))
		end

		v2 -= __wf_atom_03df4e1d()
		Sleep(0)
	end
end