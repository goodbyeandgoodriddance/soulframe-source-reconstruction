local total = 0
local v = Vector()
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v2 = 8

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not npcRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		return 0
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_be152500)
		or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
		or __wf_atom_be152500:GetState() ~= 0
	then
		return 0
	end

	if gRegion:__wf_atom_2202ffb6():__wf_atom_e6b7a771(
		object:GetPosition(),
		__wf_atom_9a1e4ed3.avatar:GetPosition(),
		object:__wf_atom_30e3d82b()
	) < 1 then
		return 0
	end

	return 1
end

function CheckIfStuck(object)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()

	if __wf_atom_7e8ad928(object) then
		return false
	end

	if Distance(v, __wf_atom_a2a18137) / __wf_atom_084b3e93() < 1 then
		total += __wf_atom_084b3e93()

		if total >= 0.15 then
			return true
		end
	else
		total = 0
	end

	v = __wf_atom_a2a18137
	return false
end

function DoSweep(object, p, p2, p3, object2)
	local v3 = { __wf_atom_7e6ed5fa, __wf_atom_d127f143, __wf_atom_8d0b7f88 }
	local damageData = Engine.DamageData()
	damageData.baseAmount = 50
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(19, true)
	damageData:__wf_atom_6b472125(p)
	damageData:__wf_atom_34a8a27a(object)
	local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(p2, p3, sweepRadius, v3, nil)
	local v4 = {}
	local v5 = {}

	for _, v6 in ipairs(__wf_atom_4ea726bc) do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		if v6:IsA(__wf_atom_7b01f9ce) then
			v6 = v6:__wf_atom_6009c8ed()

			if __wf_atom_7e8ad928(v6) then
				continue
			end
		end

		if v6:IsA(__wf_atom_7e6ed5fa) then
			local __wf_atom_18aa6e58 = v6:__wf_atom_18aa6e58()

			if not (v6:IsKilled() or v6:__wf_atom_129d1aba(p) or v4[__wf_atom_18aa6e58]) then
				v6:__wf_atom_649bf33e(damageData)
				v6:PlaySound(chargeImpactSound, false)
				v4[__wf_atom_18aa6e58] = true
			end
		elseif v6:__wf_atom_c6f1f83d() > 0 and not table.find(v5, v6) then
			v6:__wf_atom_649bf33e(damageData)
			table.insert(v5, v6)
		end
	end

	if __wf_atom_7e8ad928(object2) or not (object2:IsVisible() and v4[object2:__wf_atom_18aa6e58()]) then
		return false
	end

	object:__wf_atom_e8954328()
	return true
end

function GetChargeDirectionFromTarget(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v3 = __wf_atom_fa8d0177(object2:__wf_atom_a2a18137(), object:__wf_atom_a2a18137())
	v3.pitch = 0
	v3.bank = 0
	return v3
end

function ActivateAbility(p, object, _, _)
	local motionControl = object:MotionControl()
	motionControl:__wf_atom_3959d938(true)
	local total2 = 0
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v3

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v3 = __wf_atom_30e3d82b:__wf_atom_216d6edd() or nil
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(sweepBoneName)
	local __wf_atom_4417a5d4 = object:__wf_atom_4417a5d4()
	object:Attach(attachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(activateStartAnim) then
		if turnToTarget then
			local v4 = module.PlayAnim(p, activateStartAnim, false, 2, 3, true)

			if startOnChargeStartEvent then
				v4 = activateStartAnim:__wf_atom_091354f5(Symbol(chargeStartAnimEvent)) * v4
			end

			local __wf_atom_0e1e5bc9 = object:__wf_atom_0e1e5bc9()

			while total2 < v4 do
				if
					not (object:__wf_atom_c138b19b(activateStartAnim, true) or object:__wf_atom_3c281634(activateStartAnim))
					or object:IsFrozenSolid()
				then
					return
				end

				if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and not __wf_atom_7e8ad928(v3) and v3:IsVisible() then
					local position = v3:GetPosition()
					local v5 = __wf_atom_fa8d0177(object:GetPosition(), position)
					local v6 = __wf_atom_9d2f097a(__wf_atom_0e1e5bc9, v5, total2 / v4)
					object:__wf_atom_51075230(v6)
					object:__wf_atom_84d66e8e(v6)
				end

				Sleep(0)
				total2 += __wf_atom_084b3e93()
			end
		else
			object:__wf_atom_8914dfde("ChargeStart", object:__wf_atom_921c1a5f(activateStartAnim, false, 4, 3, true))
			__wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(sweepBoneName)

			while
				not __wf_atom_7e8ad928(object)
				and not object:IsKilled()
				and not object:IsFrozenSolid()
				and (object:__wf_atom_c138b19b(activateStartAnim, false) or object:__wf_atom_3c281634(activateStartAnim))
			do
				if __wf_atom_4417a5d4 then
					local __wf_atom_1c374cc9_2 = object:__wf_atom_1c374cc9(sweepBoneName)

					if __wf_atom_a93b9922(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2) > 1 then
						if DoSweep(p, object, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2, v3) then
							break
						else
							__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
						end
					end
				end

				Sleep(0)
			end
		end
	end

	if not stopOnHit then
		object:ProcessAnimEvent(Symbol("PassThroughTarget"))
	end

	object:__wf_atom_921c1a5f(activateLoopAnims[math.random(1, #activateLoopAnims)], false, 2, 2, true)
	local v4 = object:__wf_atom_a06d543c() * 10
	local v5 = false
	local v6 = false

	while not (v5 or __wf_atom_7e8ad928(object) or object:IsKilled() or object:IsFrozenSolid() or __wf_atom_7e8ad928(v3)) do
		local __wf_atom_1c374cc9_2 = object:__wf_atom_1c374cc9(sweepBoneName)

		if __wf_atom_4417a5d4 then
			motionControl:__wf_atom_4bb21efc(v4)

			if __wf_atom_a93b9922(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2) > 1 then
				if not v6 and DoSweep(p, object, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2, v3) then
					if stopOnHit then
						break
					else
						v6 = true
					end
				end

				__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
			end
		end

		v2 -= 10 * __wf_atom_084b3e93()

		if CheckIfStuck(object) then
			object:SetBlackboardBool(Symbol("Stuck"), true)
			break
		end

		local v7 = v3:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()
		Normalize(v7)
		local v8 = Dot(object:__wf_atom_a06d543c(), v7)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if v8 < 0 then
			v5 = object:__wf_atom_8a6b8fc3(v3) > minStopDistanceFromPlayer
			__wf_atom_e919fb8e.tooFarToDoMeleeAttack = true
		elseif stopIfCloseEnough then
			v5 = object:__wf_atom_8a6b8fc3(v3) < closeEnoughDistanceToEndCharge
			__wf_atom_e919fb8e.tooFarToDoMeleeAttack = false
		end

		if trackTarget and object:__wf_atom_8a6b8fc3(v3) > trackingEndDistance then
			local v9 = __wf_atom_e97f3142(GetChargeDirectionFromTarget(v3, object))
			local v10 = __wf_atom_a1467d4b(
				object:__wf_atom_a06d543c(),
				v9,
				targetTrackingTurnRate * __wf_atom_084b3e93()
			)
			local v11 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v10)
			object:MotionControl():__wf_atom_3a1d0c16(v11)
			object:__wf_atom_51075230(v11)
			object:__wf_atom_84d66e8e(v11)

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, v11, __wf_atom_28d5d4aa)
			end

			v4 = v10 * chargeSpeed
		end

		Sleep(0)
	end
end

local function fn(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		return
	end

	object:__wf_atom_9b5dcd3b(nil, false)

	for _ = 1, __wf_atom_9fb9a1d6:__wf_atom_75a0566d():__wf_atom_5e696f4d(comboContext) do
		if object:__wf_atom_4417a5d4() then
			__wf_atom_9fb9a1d6:__wf_atom_01e1d257(comboContext)
		end
	end

	while
		not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and __wf_atom_9fb9a1d6:__wf_atom_85821ed3()
		or not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:__wf_atom_9f71ab59()
	do
		Sleep(0)
	end
end

function DeactivateAbility(p, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	local motionControl = object:MotionControl()
	motionControl:__wf_atom_3959d938(false)
	motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)

	if not stopOnHit then
		object:ProcessAnimEvent(Symbol("PassThroughTargetEnd"))
	end

	if object:__wf_atom_52077f7a(Symbol("Stuck")) then
		object:SetBlackboardBool(Symbol("Stuck"), false)
		object:__wf_atom_921c1a5f(chargeFailAnim, false, 4, 1, true)

		while object:__wf_atom_c138b19b(chargeFailAnim, false) or object:__wf_atom_3c281634(chargeFailAnim) do
			Sleep(0)
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	else
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local v3 = __wf_atom_e919fb8e.tooFarToDoMeleeAttack == nil or not __wf_atom_e919fb8e.tooFarToDoMeleeAttack

		if
			__wf_atom_7e8ad928(__wf_atom_9fb9a1d6)
			or __wf_atom_9fb9a1d6:__wf_atom_9f71ab59()
			or not (shouldPlayMeleeAttackOnStop and v3)
		then
			if not (__wf_atom_7e8ad928(activateEndAnim) or object:__wf_atom_c138b19b(activateEndAnim) or object:__wf_atom_3c281634(activateEndAnim)) then
				if object:IsFrozenSolid() then
					object:__wf_atom_9b5dcd3b(nil, false)
				else
					module.PlayAnim(p, activateEndAnim, false, 4, 1, true)
				end
			end
		else
			fn(object)
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		object:Attach(blastFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end