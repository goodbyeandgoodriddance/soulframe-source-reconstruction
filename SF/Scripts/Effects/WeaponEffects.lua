function PerfectCounter(object)
	local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		__wf_atom_66088189:Attach(perfectParryFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function AttachEffectAttachment(object)
	if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(effectType))) then
		object:Attach(effectType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function DestroyEffectAttachment(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(effectType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		if PlayTriggeredFade then
			__wf_atom_bb3e7833:PlayTriggeredFade()
		else
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function HideWeapon(object, p)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	if p then
		local __wf_atom_15197633 = __wf_atom_21ed1a39:__wf_atom_15197633()

		if __wf_atom_7e8ad928(__wf_atom_15197633) or __wf_atom_15197633:__wf_atom_ae149090() then
			return
		end
	end

	object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	object:Attach(dissolveEffects, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	object:Attach(projType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)
	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_afd78c4b)

	for i = 1, #__wf_atom_f582136d2 do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
			__wf_atom_f582136d2[i]:Disable()
		end
	end

	local v = dissolveTime * object:__wf_atom_f43b1463()

	while v < dissolveTime and not __wf_atom_7e8ad928(object) do
		local v2 = v / dissolveTime

		for i = 1, #__wf_atom_f582136d do
			if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
				__wf_atom_f582136d[i]:__wf_atom_68f2c268((math.min(1, v2 * 3)))
			end
		end

		Sleep(0)
		v += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_68f2c268(1)
	end

	for i = 1, #__wf_atom_f582136d2 do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
			__wf_atom_f582136d2[i]:Disable()
		end
	end
end

local v = Symbol("PersistentTrail")

function ShowWeapon(object, p)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	if p then
		local __wf_atom_15197633 = __wf_atom_21ed1a39:__wf_atom_15197633()

		if
			__wf_atom_7e8ad928(__wf_atom_15197633)
			or __wf_atom_15197633:__wf_atom_ae149090()
			or __wf_atom_15197633:__wf_atom_daeda44a() == 2
		then
			return
		end
	end

	object:__wf_atom_68f2c268(1)
	object:Attach(projType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	object:Attach(dissolveEffects, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_afd78c4b)

	for i = 1, #__wf_atom_f582136d do
		if __wf_atom_7e8ad928(__wf_atom_f582136d[i]) or not __wf_atom_f582136d[i]:HasTag(v) then
			continue
		end

		__wf_atom_f582136d[i]:Enable()
	end

	local dissolveInTime2 = dissolveInTime
	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_7e616794)

	while dissolveInTime2 > 0 and not __wf_atom_7e8ad928(object) do
		for i = 1, #__wf_atom_f582136d2 do
			if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
				__wf_atom_f582136d2[i]:__wf_atom_68f2c268(dissolveInTime2 / dissolveInTime)
			end
		end

		object:__wf_atom_68f2c268(dissolveInTime2 / dissolveInTime)
		Sleep(0)
		dissolveInTime2 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_68f2c268(0)
	end
end

function ScaleForWaveProj(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_014b4ff7) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		object:SetMeshScale(__wf_atom_3d96ddcd:__wf_atom_cefac394() * scaleCoeff)
		Sleep(0)
	end
end

function OnSpearProjectileCreated(_, _, object)
	if not __wf_atom_7e8ad928(object:__wf_atom_6009c8ed()) and object:__wf_atom_3e33d5dd() < 4 then
		object:__wf_atom_6009c8ed():__wf_atom_d2b2176d():__wf_atom_f5bb7c84(object:__wf_atom_3e33d5dd(), 1)
	end
end

function WeaponTrailByVelocity(object)
	while true do
		local v2 = __wf_atom_421b01aa(Length(object:__wf_atom_278a2d05()) / maxVel, 0, 1)
		object:__wf_atom_c71cf539(minEdgeTime + v2 * (maxEdgeTime - minEdgeTime))
		Sleep(0)
	end
end

function Overheat(object)
	Sleep(0.5)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_21ed1a39 = __wf_atom_3d96ddcd:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	__wf_atom_21ed1a39:__wf_atom_04eb25d8()
	local clipSize = __wf_atom_21ed1a39:GetClipSize()
	local v2 = Symbol("EmissiveMapAtten")
	local v3 = Symbol("EmissiveTintColorLo")
	local v4 = Symbol("EmissiveTintColorHi")
	Color(0, 0, 0, 255)
	local v5 = nil
	local v6 = false

	while not __wf_atom_7e8ad928(__wf_atom_21ed1a39) do
		local v7 = 1 - __wf_atom_21ed1a39:__wf_atom_04eb25d8() / clipSize

		if __wf_atom_21ed1a39:__wf_atom_04eb25d8() <= warningAmmoThreshold and __wf_atom_7e8ad928(v5) then
			v5 = __wf_atom_3d96ddcd:Attach(overheatWarningFxType, EMPTY_SYMBOL)
		end

		if
			(__wf_atom_21ed1a39:__wf_atom_04eb25d8() > warningAmmoThreshold or v7 == 1)
			and not __wf_atom_7e8ad928(v5)
		then
			v5:Destroy()
		end

		local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()
		local v8 = not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(__wf_atom_6009c8ed:__wf_atom_e919fb8e().ZapCasterOverheat))
		object:__wf_atom_8f04e01e(v7)

		if blendEmissiveTint then
			local emissiveTintHot2

			if blendTintIsSwap then
				if v8 then
					emissiveTintHot2 = emissiveTintHot
				else
					emissiveTintHot2 = emissiveTintCool
				end
			else
				emissiveTintHot2 = emissiveTintCool:__wf_atom_104bfe98(emissiveTintHot, v7)
			end

			__wf_atom_3d96ddcd:SetMaterialParam(
				v3,
				emissiveTintHot2:__wf_atom_6f94332f(),
				emissiveTintHot2:__wf_atom_5cad32b9(),
				emissiveTintHot2:__wf_atom_0973634e(),
				1
			)
			__wf_atom_3d96ddcd:SetMaterialParam(
				v4,
				emissiveTintHot2:__wf_atom_6f94332f(),
				emissiveTintHot2:__wf_atom_5cad32b9(),
				emissiveTintHot2:__wf_atom_0973634e(),
				1
			)
		end

		if v8 and not v6 then
			if not __wf_atom_7e8ad928(thresholdBurstFxType) then
				object:Attach(thresholdBurstFxType, EMPTY_SYMBOL)
			end

			v6 = true
		end

		if not v8 or v7 == 1 then
			local __wf_atom_f582136d = object:__wf_atom_f582136d(thresholdBurstFxType)

			for _, v9 in __wf_atom_f582136d do
				v9:Destroy()
			end

			v6 = false
		end

		if v7 == 1 then
			local v9 = object:Attach(overheatFxType, EMPTY_SYMBOL)

			if playFadeOnOverheat then
				object:PlayTriggeredFade()
			end

			if scaleWeaponEmissive then
				__wf_atom_3d96ddcd:SetMaterialParam(v2, emissiveAttenOverheat)
			end

			while v7 ~= 0 do
				v7 = 1 - __wf_atom_21ed1a39:__wf_atom_04eb25d8() / clipSize
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(chargeReadySound) then
				object:PlaySound(chargeReadySound, false)
			end

			if blendEmissiveTint then
				__wf_atom_3d96ddcd:SetMaterialParam(
					v3,
					emissiveTintCool:__wf_atom_6f94332f(),
					emissiveTintCool:__wf_atom_5cad32b9(),
					emissiveTintCool:__wf_atom_0973634e(),
					1
				)
				__wf_atom_3d96ddcd:SetMaterialParam(
					v4,
					emissiveTintCool:__wf_atom_6f94332f(),
					emissiveTintCool:__wf_atom_5cad32b9(),
					emissiveTintCool:__wf_atom_0973634e(),
					1
				)
			end

			local v10 = 0

			while v10 < 1 do
				v10 = __wf_atom_421b01aa(v10 + __wf_atom_084b3e93() / 0.75, 0, 1)
				__wf_atom_3d96ddcd:SetMaterialParam(v2, emissiveAttenCool * v10)
				Sleep(0)
			end

			v9:Destroy()
		end

		Sleep(0)
	end
end

function OverheatSpawnerSelect(object)
	local creator = nil

	if weaponAttached then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			creator = __wf_atom_3d96ddcd:__wf_atom_21ed1a39()
		end
	else
		creator = object:GetCreator()
	end

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_6009c8ed = creator:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or __wf_atom_7e8ad928(__wf_atom_6009c8ed:__wf_atom_e919fb8e().ZapCasterOverheat)
	then
		if weaponAttached and not __wf_atom_7e8ad928(object) then
			object:Attach(spawnerCool, EMPTY_SYMBOL)
		else
			gRegion:CreateEntity(spawnerCool, __wf_atom_a2a18137, __wf_atom_2f2bada0)
		end
	elseif weaponAttached and not __wf_atom_7e8ad928(object) then
		object:Attach(spawnerHot, EMPTY_SYMBOL)
	else
		gRegion:CreateEntity(spawnerHot, __wf_atom_a2a18137, __wf_atom_2f2bada0)
	end
end