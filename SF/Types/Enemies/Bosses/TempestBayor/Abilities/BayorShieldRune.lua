local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Effects.IdolEffects")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_f3044fe0 = object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.numRuneCharges) then
		__wf_atom_e919fb8e.numRuneCharges = 0
	end

	if __wf_atom_f3044fe0 > 0 or module.InfiniteEnergy() or forceForTcDemo then
		local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

		if
			__wf_atom_9a1e4ed3.visible
			and not (__wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f())
		then
			local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

			if
				__wf_atom_7e8ad928(__wf_atom_be152500)
				or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
				or __wf_atom_be152500:GetState() ~= 0
			then
				return 0
			end

			return 1
		end
	end

	return 0
end

function ActivateAbility(object, object2, _, _)
	if not module.PlayAnimAndSuspendUntilEvent(object, blockStartAnim, createShieldEvent, false, 4, 1, false) then
		return
	end

	object2:__wf_atom_8a035cd5(Symbol("DoShield"), false)

	if gRegion:IsMaster() then
		object:__wf_atom_19516b62(-50, (object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
		local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.BreakWeapon = true
	end
end

function DeactivateAbility(_, object, _, _)
	repeat
		Sleep(0)
	until __wf_atom_7e8ad928(object) or not object:__wf_atom_c138b19b(blockEndAnim)
end

function DoShield(instance)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local duration = duration
	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
	instance:SetBlackboardBool(Symbol("OverShieldActive"), true)
	local v

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		v = __wf_atom_35a10d3c:__wf_atom_66088189(1, 0)
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	mOwner:__wf_atom_a7328d06(true)
	instance:__wf_atom_78128d94(__wf_atom_37768748)
	instance:__wf_atom_2b0feace(true)
	__wf_atom_7470861b:__wf_atom_1fa97530(7, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_1fa97530(3, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_1fa97530(4, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_1fa97530(5, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_e2ff9126(20, __wf_atom_37768748)
	__wf_atom_d2b2176d:AddUpgrade(20, 0, addionalArmour)
	__wf_atom_d2b2176d:AddUpgrade(316, 4, damageRedirectionRange)
	__wf_atom_d2b2176d:AddUpgrade(169, 4, stabilityDamageReduction)
	__wf_atom_d2b2176d:AddUpgrade(315, 4, WeaponFireRateIncrease)
	local v2 = instance:Attach(shieldProjectionFx, EMPTY_SYMBOL)
	local v3 = instance:Attach(shieldOrbFx, shieldOrbAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	v:__wf_atom_921c1a5f(weaponStartAnim, false, false, 0, EMPTY_SYMBOL)
	module.PlayUpperBodyAnim(__wf_atom_e55d02aa, blockLoopAnim, false, 4, 1, false)
	local __wf_atom_55597fe3 = __wf_atom_7470861b:__wf_atom_55597fe3()
	local __wf_atom_b518a791 = __wf_atom_55597fe3:__wf_atom_b518a791()
	local __wf_atom_679ed446 = __wf_atom_55597fe3:__wf_atom_679ed446()
	local __wf_atom_3371f607 = __wf_atom_55597fe3:__wf_atom_3371f607()
	local total = 0
	local count = 0

	while not (instance:IsKilled() or instance:__wf_atom_bedb4e3f()) do
		local __wf_atom_b518a791_2 = __wf_atom_55597fe3:__wf_atom_b518a791()
		local __wf_atom_679ed446_2 = __wf_atom_55597fe3:__wf_atom_679ed446()
		local __wf_atom_3371f607_2 = __wf_atom_55597fe3:__wf_atom_3371f607()
		v:__wf_atom_921c1a5f(weaponLoopAnim, false, false, 0, EMPTY_SYMBOL)

		if not instance:__wf_atom_c138b19b(blockLoopAnim) then
			module.PlayUpperBodyAnim(__wf_atom_e55d02aa, blockLoopAnim, false, 4, 1, false)
		end

		if
			__wf_atom_b518a791_2 ~= __wf_atom_b518a791
			or __wf_atom_679ed446_2 ~= __wf_atom_679ed446
			or __wf_atom_3371f607_2 ~= __wf_atom_3371f607
		then
			total += __wf_atom_55597fe3.baseAmount

			if __wf_atom_3371f607_2:IsA(WeakResource("/SF/Souls/Corrupted/CorruptedBoomerangRangedMeleeWeapon")) then
				count += 1
			end

			instance:Attach(hitReactFx, shieldOrbAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			__wf_atom_3371f607 = __wf_atom_3371f607_2
			__wf_atom_679ed446 = __wf_atom_679ed446_2
			__wf_atom_b518a791 = __wf_atom_b518a791_2
		end

		Sleep(0)

		if not (duration > 0) then
			continue
		end

		duration -= __wf_atom_084b3e93()

		if duration <= 0 or boomerangHitsToBreak <= count then
			break
		end
	end

	v:__wf_atom_921c1a5f(weaponEndAnim, false, false, 0, EMPTY_SYMBOL)
	module.PlayAnimAndSuspendUntilEvent(__wf_atom_e55d02aa, blockEndAnim, detonateShieldEvent, false, 4, 1, false)
	instance:RemoveTag(__wf_atom_37768748)

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	instance:__wf_atom_2b0feace(false)
	__wf_atom_7470861b:__wf_atom_56b2394e(7, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(3, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(4, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(5, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_fbf4e632(20, __wf_atom_37768748)
	__wf_atom_d2b2176d:RemoveUpgrade(20, 0, addionalArmour)
	__wf_atom_d2b2176d:RemoveUpgrade(316, 4, damageRedirectionRange)
	__wf_atom_d2b2176d:RemoveUpgrade(169, 4, stabilityDamageReduction)
	__wf_atom_d2b2176d:RemoveUpgrade(315, 4, WeaponFireRateIncrease)

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end

	local position = instance:GetPosition()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = baseDamage + absorbedDamageMultiplier * total
	radialDamageData.stabilityDamage = baseStabilityDamage + absorbedDamageMultiplier * total
	radialDamageData.radius = blastRadius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData.hitType = 4
	radialDamageData:__wf_atom_7498285f(5, 1)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_98d98d81(position)
	radialDamageData:__wf_atom_6b472125(instance)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
	radialDamageData.burstEffectType = breakFx
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	__wf_atom_e919fb8e.BreakWeapon = false
	instance:SetBlackboardBool(Symbol("MeleeOnly"), false)
end