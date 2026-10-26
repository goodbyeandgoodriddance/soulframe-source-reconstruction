function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local v = 0

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return
	end

	local position = object2:GetPosition()
	position.y = 0

	if not (__wf_atom_9a1e4ed3:__wf_atom_a3309443() and __wf_atom_9a1e4ed3.distanceToTarget <= kickStartingRange) then
		return v
	end

	local avatar = __wf_atom_9a1e4ed3.avatar
	local position2 = avatar:GetPosition()

	if not (math.abs(position2.y - object2:GetPosition().y) <= maxElevationDifference) then
		return v
	end

	local v2 = Rotation(object2:__wf_atom_0e1e5bc9().heading, 0, 0)
	position2.y = 0
	local v3 = math.abs((__wf_atom_a6515464(position, v2, position2)))

	if v3 > 180 then
		v3 = 360 - math.mod(v3, 360)
	end

	if v3 < maxAngleToIgnore then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	end

	return v
end

local function fn(heading, p) -- 1 equivalent call inferred from this helper
	local v = heading + p

	if v >= 180 then
		return v - 360
	end

	if v < -180 then
		return v + 360
	end

	return v
end

function ActivateAbility(_, object, entity, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(entity) then
		entity = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3().entity
	end

	local motionControl = entity:MotionControl()
	local motionControl2 = object:MotionControl()
	local damageData = Engine.DamageData()
	damageData.baseAmount = kickDamage
	damageData:__wf_atom_6b472125(object)
	damageData:__wf_atom_34a8a27a(object)
	damageData:__wf_atom_7498285f(0, 50)
	damageData:__wf_atom_d6f4d914(17, true)
	damageData:__wf_atom_d6f4d914(31, true)
	local damageData2 = Engine.DamageData()
	damageData2:__wf_atom_6b472125(object)
	damageData2:__wf_atom_34a8a27a(object)
	damageData2:__wf_atom_d6f4d914(17, true)
	object:Attach(kickFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:__wf_atom_9b5dcd3b(kickAnim, false, 4, 1, true)

	if gRegion:IsMaster() then
		local __wf_atom_091354f5 = kickAnim:__wf_atom_091354f5(Symbol("Kick"))
		local __wf_atom_80368bb1_2 = __wf_atom_80368bb1

		while __wf_atom_091354f5 > 0 do
			if not __wf_atom_7e8ad928(entity) then
				__wf_atom_80368bb1_2 = __wf_atom_fa8d0177(object:GetPosition(), entity:GetPosition())
			end

			local v = maxRotationPerSecond * __wf_atom_084b3e93()
			local heading = __wf_atom_80368bb1_2.heading
			local heading2 = object:__wf_atom_0e1e5bc9().heading

			if heading - heading2 > 180 then
				heading -= 360
			end

			if heading - heading2 < -180 then
				heading += 360
			end

			local v2 = math.clamp(heading - heading2, -1 * v, v)
			__wf_atom_80368bb1_2.heading = fn(object:__wf_atom_0e1e5bc9().heading, v2) -- inferred equivalent call
			object:__wf_atom_84d66e8e(__wf_atom_80368bb1_2)
			object:__wf_atom_51075230(__wf_atom_80368bb1_2)

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, __wf_atom_80368bb1_2, __wf_atom_28d5d4aa)
			end

			object:__wf_atom_5127af76(entity, entity:GetPosition())
			Sleep(0)
			__wf_atom_091354f5 -= __wf_atom_084b3e93()
		end

		local v = entity:GetPosition() - object:GetPosition()
		local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(entity)
		local v2

		if __wf_atom_8a6b8fc3 == 0 then
			v2 = entity:__wf_atom_a06d543c()
		else
			v2 = v / __wf_atom_8a6b8fc3
		end

		if
			__wf_atom_8a6b8fc3 < kickContactRange
			and not __wf_atom_7e8ad928(entity)
			and math.abs(entity:GetPosition().y - object:GetPosition().y) <= maxElevationDifference
		then
			damageData:__wf_atom_12cf5317(v2 * impulseAmount)
			local v3 = -1 * v2 * reverseImpulseAmount
			damageData2:__wf_atom_12cf5317(v3)
			entity:__wf_atom_649bf33e(damageData)
			entity:__wf_atom_9b5dcd3b(slideBackAnim, false, 2, 2, true)
			entity:Attach(slideFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			motionControl:__wf_atom_4bb21efc(v2 * impulseAmount)
			motionControl2:__wf_atom_4bb21efc(v3)
			Sleep(0.1)

			while entity:__wf_atom_7b82e9e1(17) do
				Sleep(0)
			end

			object:__wf_atom_9b5dcd3b(slideBackAnim, false, 2, 2, true)
			Sleep(0)
			object:__wf_atom_649bf33e(damageData2)
			object:__wf_atom_8a035cd5(Symbol("ImpulseAnimWatcher"), false)
			entity:__wf_atom_8a035cd5(Symbol("ImpulseAnimWatcher"), false)
		end

		while object:__wf_atom_c138b19b(kickAnim) do
			Sleep(0)
		end
	else
		Sleep(0)

		while object:__wf_atom_c138b19b(kickAnim) do
			Sleep(0)
		end
	end
end

function ImpulseAnimWatcher(object)
	local __wf_atom_278a2d05 = object:__wf_atom_278a2d05()

	while Length(__wf_atom_278a2d05) >= 2 do
		__wf_atom_278a2d05 = object:__wf_atom_278a2d05()
		Sleep(0)
	end

	object:__wf_atom_9b5dcd3b(nil, false, 2, 1, true)
end