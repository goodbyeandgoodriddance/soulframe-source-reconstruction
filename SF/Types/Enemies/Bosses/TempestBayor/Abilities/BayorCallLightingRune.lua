local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_f3044fe0 = object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.numRuneCharges) then
		__wf_atom_e919fb8e.numRuneCharges = 0
	end

	local v = __wf_atom_5784a397(1, 3)

	if
		__wf_atom_f3044fe0 > 0
		or module.InfiniteEnergy()
		or v <= __wf_atom_e919fb8e.numRuneCharges
		or isTennoConDemo
	then
		return 1
	end

	return 0
end

function GetTargetPosition(object)
	local position = object:GetPosition()
	local v = __wf_atom_e97f3142(object:__wf_atom_4e50d390())
	local v2 = __wf_atom_edfe0d73(Vector(0, 1, 0), v)

	if Dot(v2, object:__wf_atom_a06d543c()) < 0 then
		v2 *= -1
	end

	local v3 = position + (v * math.random(1, 1.5) + v2 * math.random(0.25, 0.5))
	local v4 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_d0a48db7,
		WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
		WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
	}

	if not __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(
		position + Vector(0, 4, 0),
		position - Vector(0, 2, 0),
		v4,
		nil,
		position
	)) then
		position = v3
	end

	return position
end

function FailCast(object, object2, p)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local radialDamageData = Engine.RadialDamageData()
	object2:__wf_atom_921c1a5f(weaponEndAnim, false, false, 0, EMPTY_SYMBOL)
	radialDamageData.baseAmount = baseDamage
	radialDamageData.stabilityDamage = baseStabilityDamage
	radialDamageData.radius = strikeRadius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData.hitType = 4
	radialDamageData:__wf_atom_7498285f(5, 1)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_d6f4d914(19, true)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_a2a18137())
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(p)
	radialDamageData.ignoreSource = false
	radialDamageData.burstEffectType = failStrikeFxType
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	Sleep(0.5)
	__wf_atom_e919fb8e.Exploded = true
end

function LightningStrikeWeapon(p, object, p2, object2, p3)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	object2:__wf_atom_921c1a5f(p3, false, false, 0, EMPTY_SYMBOL)
	local v = module.PlayAnim(p, p2, false, 4, 1, false)
	local __wf_atom_091354f5 = strikeStartAnim:__wf_atom_091354f5(Symbol(animEventLightningStrike))
	local total = 0

	while total < __wf_atom_091354f5 do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if not __wf_atom_e919fb8e.CorruptionGrip then
			continue
		end

		FailCast(object, object2, p)
		return
	end

	local v2 = object2:Attach(weaponStrikeFx, Symbol("GAME_C1_BLADETIP"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	while total < v do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if not __wf_atom_e919fb8e.CorruptionGrip then
			continue
		end

		FailCast(object, object2, p)
		return
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end
end

function ActivateAbility(object, object2, entity)
	local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local v = nil
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	local numRuneCharges = __wf_atom_5784a397(strikeRange.minValue, strikeRange.maxValue)

	if
		not __wf_atom_7e8ad928(__wf_atom_e919fb8e.numRuneCharges)
		and __wf_atom_e919fb8e.numRuneCharges > 0
		and useRuneChargeCount
	then
		numRuneCharges = __wf_atom_e919fb8e.numRuneCharges
	end

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		v = __wf_atom_35a10d3c:__wf_atom_66088189(1, 0)
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local v2 = object2:Attach(chargeFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	LightningStrikeWeapon(object, object2, strikeStartAnim, v, weaponStartAnim)

	for _ = 1, numRuneCharges - 1 do
		LightningStrikeWeapon(object, object2, strikeLoopAnim, v, weaponLoopAnim)
	end

	module.PlayAnim(object, strikeEndAnim, false, 4, 1, false)

	if __wf_atom_7e8ad928(entity) then
		if
			__wf_atom_7e8ad928(object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3())
			or __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity)
		then
			return
		else
			entity = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end
	end

	local v3 = entity:Attach(markFx, EMPTY_SYMBOL)

	for i = 1, numRuneCharges do
		if __wf_atom_7e8ad928(entity) then
			return
		end

		local v4 = GetTargetPosition(entity)
		local swingAAnim2 = nil

		if i % 2 == 1 then
			swingAAnim2 = swingAAnim
		elseif i % 2 == 0 then
			swingAAnim2 = swingBAnim
		end

		local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
		object2:__wf_atom_3c986cd9(__wf_atom_a2a18137, (__wf_atom_fa8d0177(__wf_atom_a2a18137, v4)))
		local v5 = module.PlayAnim(object, swingAAnim2, false, 4, 1, false)
		local __wf_atom_091354f5 = swingAAnim2:__wf_atom_091354f5(Symbol(animEventMidSwing))
		local __wf_atom_091354f5_2 = swingAAnim2:__wf_atom_091354f5(Symbol("BeamStart"))
		local __wf_atom_091354f5_3 = swingAAnim2:__wf_atom_091354f5(Symbol("BeamEnd"))
		v:Attach(swingFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local total = 0

		while total < __wf_atom_091354f5_2 do
			total += __wf_atom_084b3e93()

			if not __wf_atom_7e8ad928(entity) then
				v4 = GetTargetPosition(entity)
			end

			Sleep(0)
		end

		local v6 = v:Attach(strikeBeamType, Symbol("GAME_C1_BLADETIP"))

		if not __wf_atom_7e8ad928(v6) then
			v6:__wf_atom_a64eca67(v4 + Vector(0, 1, 0))
		end

		while total < __wf_atom_091354f5 do
			total += __wf_atom_084b3e93()

			if not __wf_atom_7e8ad928(entity) then
				v4 = GetTargetPosition(entity)
			end

			Sleep(0)
		end

		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = baseDamage
		radialDamageData.stabilityDamage = baseStabilityDamage
		radialDamageData.radius = strikeRadius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData.hitType = 4
		radialDamageData:__wf_atom_7498285f(5, 1)
		radialDamageData:__wf_atom_d6f4d914(31, true)
		radialDamageData:__wf_atom_98d98d81(v4)
		radialDamageData:__wf_atom_6b472125(object2)
		radialDamageData:__wf_atom_34a8a27a(object)
		radialDamageData.ignoreSource = true
		radialDamageData.burstEffectType = strikeFxType
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		Sleep(__wf_atom_091354f5_3 - total)

		if not __wf_atom_7e8ad928(v6) then
			v6:Destroy()
		end

		Sleep(v5 - __wf_atom_091354f5_3)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	local swingAToIdleAnim2

	if numRuneCharges % 2 == 1 then
		swingAToIdleAnim2 = swingAToIdleAnim
	else
		swingAToIdleAnim2 = swingBToIdleAnim
	end

	v:__wf_atom_921c1a5f(weaponEndAnim, false, false, 0, EMPTY_SYMBOL)
	module.PlayAnim(object, swingAToIdleAnim2, false, 4, 1, false)

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	if gRegion:IsMaster() then
		object:__wf_atom_19516b62(-50, (object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
		local __wf_atom_e919fb8e2 = object2:__wf_atom_e919fb8e()

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e2.numRuneCharges)
			or not (numRuneCharges < __wf_atom_e919fb8e2.numRuneCharges)
		then
			__wf_atom_e919fb8e2.numRuneCharges = 0
		else
			__wf_atom_e919fb8e2.numRuneCharges -= numRuneCharges
		end

		object2:__wf_atom_cecb2d55(Symbol("numRuneCharges"), __wf_atom_e919fb8e2.numRuneCharges)
	end
end

function DeactivateAbility(_, object, object2)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_0650fed7(markFx)
	end

	__wf_atom_e919fb8e.Exploded = false
end