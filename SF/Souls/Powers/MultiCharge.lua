local total = 0
local flag = false
local v = Vector()
local count = 0
local v2 = {}
local v3 = nil

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

	if
		doNavTraceCheck
		and gRegion:__wf_atom_2202ffb6():__wf_atom_e6b7a771(
			object:GetPosition(),
			__wf_atom_9a1e4ed3.avatar:GetPosition(),
			object:__wf_atom_30e3d82b()
		) < 1
	then
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
	local v4 = { __wf_atom_7e6ed5fa, __wf_atom_d127f143, __wf_atom_8d0b7f88 }
	local damageData = Engine.DamageData()
	damageData.baseAmount = 50
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(19, true)
	damageData:__wf_atom_6b472125(p)
	damageData:__wf_atom_34a8a27a(object)
	local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(p2, p3, sweepRadius, v4, nil)
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

			if not (v6:IsKilled() or v6:__wf_atom_129d1aba(p) or v2[__wf_atom_18aa6e58]) then
				v6:__wf_atom_649bf33e(damageData)
				v6:PlaySound(chargeImpactSound, false)
				v2[__wf_atom_18aa6e58] = true
			end
		elseif v6:__wf_atom_c6f1f83d() > 0 and not table.find(v5, v6) then
			v6:__wf_atom_649bf33e(damageData)
			table.insert(v5, v6)
		end
	end

	if __wf_atom_7e8ad928(object2) or not (object2:IsVisible() and v2[object2:__wf_atom_18aa6e58()]) then
		return false
	end

	object:__wf_atom_e8954328()
	return true
end

function GetChargeDirectionFromTarget(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v4 = __wf_atom_fa8d0177(object2:__wf_atom_a2a18137(), object:__wf_atom_a2a18137())
	v4.pitch = 0
	v4.bank = 0
	return v4
end

function DoCharge(object, object2)
	local motionControl = object2:MotionControl()
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

	if __wf_atom_7e8ad928(__wf_atom_216d6edd) then
		return
	end

	v2 = {}
	__wf_atom_216d6edd:__wf_atom_a2a18137()
	local v4

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v4 = __wf_atom_30e3d82b:__wf_atom_216d6edd() or nil
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(sweepBoneName)
	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	object2:Attach(attachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local activateStartAnim = activateStartAnim

	if
		__wf_atom_7e8ad928(runningActivateStartAnim)
		or not (object2:__wf_atom_ee4f0cba() >= minimumSpeedForRunningStart)
	then
		if not __wf_atom_7e8ad928(firstChargeStartAnim) and count == 0 then
			activateStartAnim = firstChargeStartAnim
		end
	else
		activateStartAnim = runningActivateStartAnim
	end

	if not __wf_atom_7e8ad928(activateStartAnim) then
		if count == 0 then
			local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
			secondaryScriptArgs:__wf_atom_a17e41c6(object2)
			object:__wf_atom_e6831c5c(mOwner, Symbol("ChargeStart"), secondaryScriptArgs)
		end

		motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		object2:__wf_atom_8914dfde("ChargeStart", object2:__wf_atom_921c1a5f(activateStartAnim, false, 4, 3, true))

		if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
			local __wf_atom_a2a18137 = __wf_atom_216d6edd:__wf_atom_a2a18137()
			local v5 = __wf_atom_fa8d0177(object2:GetPosition(), __wf_atom_a2a18137)
			local v6 = __wf_atom_a2a18137 - object2:GetPosition()
			Normalize(v6)
			local __wf_atom_421b01aa = leapRange:__wf_atom_421b01aa(__wf_atom_30e3d82b:__wf_atom_9a1e4ed3().distanceToTarget)
			local v7 = object2:__wf_atom_a2a18137() + v6 * __wf_atom_421b01aa
			local v8

			if onlyAdjustRotationAtStart then
				v8 = object2:__wf_atom_a2a18137()
			else
				v8 = v3:__wf_atom_0e0a6fee(v7)
			end

			object2:__wf_atom_3c986cd9(v8, v5, true)
		end

		__wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(sweepBoneName)

		while
			not __wf_atom_7e8ad928(object2)
			and not object2:IsKilled()
			and not object2:__wf_atom_7470861b():__wf_atom_bedb4e3f()
			and not object2:IsFrozenSolid()
			and (object2:__wf_atom_c138b19b(activateStartAnim, false) or object2:__wf_atom_3c281634(activateStartAnim))
		do
			if __wf_atom_4417a5d4 then
				local __wf_atom_1c374cc9_2 = object2:__wf_atom_1c374cc9(sweepBoneName)

				if __wf_atom_a93b9922(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2) > 1 then
					DoSweep(object, object2, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2, v4)
					local v5 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2)
					local v6 = Rotation(v5.heading, 0, v5.bank)
					gRegion:CreateEntity(damageVolType, object2:GetPosition(), v6)
					__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
				end
			end

			Sleep(0)
		end
	end

	object2:GetPosition()
	local activateLoopAnim = activateLoopAnims[math.random(1, #activateLoopAnims)]
	object2:ProcessAnimEvent(Symbol("PassThroughTarget"))
	object2:__wf_atom_921c1a5f(activateLoopAnim, false, 2, 2, true)
	local v5 = object2:__wf_atom_a06d543c() * chargeSpeed
	local v6 = false

	while not (v6 or __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_7470861b():__wf_atom_bedb4e3f() or object2:IsFrozenSolid() or __wf_atom_7e8ad928(__wf_atom_216d6edd)) do
		if __wf_atom_4417a5d4 then
			motionControl:__wf_atom_4bb21efc(v5)
			local __wf_atom_1c374cc9_2 = object2:__wf_atom_1c374cc9(sweepBoneName)
			object2:GetPosition()

			if CheckIfStuck(object2) then
				flag = true
				motionControl:__wf_atom_3959d938(false)
				motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
				object2:__wf_atom_921c1a5f(chargeFailAnim, false, 4, 1, true)

				while object2:__wf_atom_c138b19b(chargeFailAnim, false) or object2:__wf_atom_3c281634(chargeFailAnim) do
					Sleep(0)
				end

				return
			elseif __wf_atom_a93b9922(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2) > 1 then
				DoSweep(object, object2, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2, v4)
				local v7 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2)
				local v8 = Rotation(v7.heading, 0, v7.bank)
				gRegion:CreateEntity(damageVolType, object2:GetPosition(), v8)
				__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
			end
		end

		local v7 = __wf_atom_216d6edd:__wf_atom_a2a18137() - object2:__wf_atom_a2a18137()
		Normalize(v7)
		local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()

		if Dot(__wf_atom_a06d543c, v7) < 0 then
			v6 = object2:__wf_atom_8a6b8fc3(__wf_atom_216d6edd) > minStopDistanceFromPlayer
		elseif trackTarget and object2:__wf_atom_8a6b8fc3(__wf_atom_216d6edd) > trackingEndDistance then
			local v8 = __wf_atom_e97f3142(GetChargeDirectionFromTarget(__wf_atom_216d6edd, object2))
			local v9 = __wf_atom_a1467d4b(
				object2:__wf_atom_a06d543c(),
				v8,
				targetTrackingTurnRate * __wf_atom_084b3e93()
			)
			local v10 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v9)
			object2:MotionControl():__wf_atom_3a1d0c16(v10)
			object2:__wf_atom_51075230(v10)
			object2:__wf_atom_84d66e8e(v10)

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, v10, __wf_atom_28d5d4aa)
			end

			v5 = v9 * chargeSpeed
		end

		Sleep(0)
	end

	object2:ProcessAnimEvent(Symbol("PassThroughTargetEnd"))
	object2:__wf_atom_2f91774e()
	motionControl:__wf_atom_3959d938(false)
	motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
	local __wf_atom_091354f5 = activateEndAnim:__wf_atom_091354f5(aoeStopAnimEvent)

	if adjustRotationAtEnd and not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
		local v7 = __wf_atom_fa8d0177(object2:GetPosition(), __wf_atom_216d6edd:__wf_atom_a2a18137())
		object2:__wf_atom_3c986cd9(object2:__wf_atom_a2a18137() + object2:__wf_atom_a06d543c() * 5, v7, true)
	end

	object2:__wf_atom_921c1a5f(activateEndAnim, false, 4, 1, true)
	object2:Attach(blastFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(attachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	while
		not __wf_atom_7e8ad928(object2)
		and not object2:IsKilled()
		and not object2:__wf_atom_7470861b():__wf_atom_bedb4e3f()
		and not object2:IsFrozenSolid()
		and (object2:__wf_atom_c138b19b(activateEndAnim, false) or object2:__wf_atom_3c281634(activateEndAnim))
	do
		if __wf_atom_4417a5d4 and __wf_atom_091354f5 > 0 then
			local __wf_atom_1c374cc9_2 = object2:__wf_atom_1c374cc9(sweepBoneName)

			if __wf_atom_a93b9922(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2) > 1 then
				DoSweep(object, object2, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2, v4)
				local v7 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2)
				local v8 = Rotation(v7.heading, 0, v7.bank)
				gRegion:CreateEntity(damageVolType, object2:GetPosition(), v8)
				__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
			end

			__wf_atom_091354f5 -= __wf_atom_084b3e93()
		end

		Sleep(0)
	end
end

function ActivateAbility(p, object, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(__wf_atom_216d6edd)
		and not object:IsKilled()
		and not object:IsFrozenSolid()
		and not object:__wf_atom_7470861b():__wf_atom_bedb4e3f()
		and count < numCharges
	do
		object:__wf_atom_7601b116(__wf_atom_216d6edd:GetPosition())
		DoCharge(p, object)

		if flag then
			break
		end

		count += 1
		Sleep(0)
	end
end

function DeactivateAbility(object, object2, _, _)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	object2:__wf_atom_2f91774e()

	if object2:IsFrozenSolid() then
		object2:__wf_atom_9b5dcd3b(nil, false)
	end

	local motionControl = object2:MotionControl()
	motionControl:__wf_atom_3959d938(false)
	motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
	object2:ProcessAnimEvent(Symbol("PassThroughTargetEnd"))
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(attachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if chargeEndBBVar:__wf_atom_8598f3a9() then
		object2:__wf_atom_cecb2d55(
			chargeEndBBVar,
			gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_179042e1()
		)
	end

	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	secondaryScriptArgs:__wf_atom_a17e41c6(object2)
	object:__wf_atom_e6831c5c(mOwner, Symbol("ChargeEnd"), secondaryScriptArgs)
end