local position = nil
local v = nil
local v2 = false
local v3 = nil
local v4 = false
local v5 = nil
require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget >= abilityCheckDistance
	then
		local _abilityCheckDistanceTime = abilityCheckDistanceTime
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

local function fn(entity, object)
	if __wf_atom_7e8ad928(entity) then
		return
	end

	local v6 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), entity:__wf_atom_a2a18137())
	v6.pitch = 0
	v6.bank = 0
	return v6
end

function ActivateAbility(p, object, entity, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	if __wf_atom_7e8ad928(entity) then
		if
			__wf_atom_7e8ad928(object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3())
			or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity)
		then
			return
		else
			entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(entity) then
		v2 = true
	else
		position = entity:GetPosition()
	end

	object:__wf_atom_3c986cd9(object:GetPosition(), __wf_atom_fa8d0177(object:GetPosition(), entity:GetPosition()))
	mOwner:__wf_atom_7ccf4243(chargeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:__wf_atom_9b5dcd3b(shootStart, false, 4, 1, true)
	local __wf_atom_35a10d3c = entity:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	Sleep(0)
	local v6 = false
	local total = 0
	local v7 = true

	while object:__wf_atom_c138b19b(shootStart) do
		Sleep(0)

		if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:__wf_atom_aab55bea() or v6 then
			if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and not __wf_atom_35a10d3c:__wf_atom_aab55bea() and v6 then
				v6 = false
				total = 0
			end
		else
			total += __wf_atom_084b3e93()
			v6 = true
		end
	end

	v5 = total
	v4 = v6
	local shootLoop2, v8

	if ShootWhip(object, entity, p) then
		shootLoop2 = shootLoop
		v8 = 2
	else
		shootLoop2 = shootFail
		v8 = 1
		v7 = false
	end

	object:__wf_atom_9b5dcd3b(shootLoop2, false, 4, v8, false)

	if not v7 then
		return
	end

	local total2 = 0

	while total2 <= chargeUpTime do
		Sleep(0)
		total2 += __wf_atom_084b3e93()
	end

	v = object:__wf_atom_1c8f7b2d(entity)

	if not __wf_atom_7e8ad928(jumpSound) then
		object:PlaySound(jumpSound, false, 1, false)
	end

	object:__wf_atom_9b5dcd3b(jumpStart, false, 4, 1, true)
	local motionControl = object:MotionControl()
	local __wf_atom_30e3d82b2 = object:__wf_atom_30e3d82b()
	object:__wf_atom_0e1e5bc9()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b2) then
		__wf_atom_30e3d82b2:__wf_atom_b414eabf()
	end

	local v9 = v + chargeMissDistnace
	motionControl:__wf_atom_0d3a9295(500)
	local position2 = object:GetPosition()
	Vector(0, 0, 0)
	local __wf_atom_0e1e5bc9 = object:__wf_atom_0e1e5bc9()
	object:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL"))
	local v10 = __wf_atom_e97f3142(__wf_atom_0e1e5bc9)
	motionControl:__wf_atom_3a1d0c16(__wf_atom_0e1e5bc9)
	local v11 = v10 * chargeSpeedScaledMult
	motionControl:__wf_atom_4bb21efc(v11)
	object:__wf_atom_9b5dcd3b(jumpLoop, false, 4, 2, false)
	Sleep(0)
	local v12 = true
	local v13 = false
	local total3 = 0

	while v12 and not __wf_atom_7e8ad928(entity) do
		local position3 = object:GetPosition()
		local v14 = Distance(position2, position3)
		local __wf_atom_1c8f7b2d = object:__wf_atom_1c8f7b2d(entity)

		if v9 < v14 or v9 < v14 and not v13 then
			object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
			object:__wf_atom_921c1a5f(nil, true, 4, 1, true)
			return
		else
			if __wf_atom_1c8f7b2d <= 5 then
				v12 = false

				if not __wf_atom_7e8ad928(v3) then
					v3:Destroy()
				end

				v3 = nil
				object:MotionControl():__wf_atom_4bb21efc(v11 / 3)
				local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(jumpEnd, false, 4, 1, false)
				Sleep(__wf_atom_921c1a5f / 3)
				local radialDamageData = Engine.RadialDamageData()
				radialDamageData.baseAmount = 100
				radialDamageData.stabilityDamage = 50
				radialDamageData.radius = 3
				radialDamageData.radiusMin = 2
				radialDamageData.fallOff = 1
				radialDamageData.fallOffMax = 0.2
				radialDamageData.checkForCover = false
				radialDamageData:__wf_atom_7498285f(5, 1)
				radialDamageData:__wf_atom_98d98d81(object:GetPosition())
				radialDamageData:__wf_atom_6b472125(object)
				radialDamageData:__wf_atom_34a8a27a(p)
				gRegion:__wf_atom_f6ec80de(radialDamageData)
				object:Attach(strikeFx, EMPTY_SYMBOL)
			else
				if __wf_atom_1c8f7b2d <= trackingEndDistance then
					v10 = object:__wf_atom_a06d543c()
				elseif not __wf_atom_7e8ad928(entity) then
					local v15 = __wf_atom_e97f3142(fn(entity, object))
					v10 = __wf_atom_a1467d4b(
						object:__wf_atom_a06d543c(),
						v15,
						targetTrackingTurnRate * __wf_atom_084b3e93()
					)
					local v16 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v10)
					object:MotionControl():__wf_atom_3a1d0c16(v16)
					object:__wf_atom_51075230(v16)
					object:__wf_atom_84d66e8e(v16)

					if not __wf_atom_7e8ad928(__wf_atom_30e3d82b2) then
						__wf_atom_30e3d82b2:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, v16, __wf_atom_28d5d4aa)
					end
				end

				v11 = v10 * chargeSpeedScaledMult
				motionControl:__wf_atom_4bb21efc(v11)
			end

			total3 += __wf_atom_084b3e93()
			Sleep(0)
		end
	end

	object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
end

function OnTouchPlayer(_, _) end

function ShootWhip(object, object2, _)
	if v4 and v5 <= sucessfulParryWindow then
		return false
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(HAND_BONE_SYMBOL)
	local __wf_atom_1c374cc9_2 = object2:__wf_atom_1c374cc9(HIT_BONE_SYMBOL)
	__wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2)
	v3 = mOwner:__wf_atom_7ccf4243(beamType, HAND_BONE_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_341daa34(object2, 0)
	end

	return true
end