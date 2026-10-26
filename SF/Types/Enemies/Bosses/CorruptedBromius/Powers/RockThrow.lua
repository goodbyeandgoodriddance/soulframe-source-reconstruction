require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local v = Symbol("BromiusRockThrowImmunity")

local function fn(object, p, p2)
	Vector(0, 0, 0)
	local v2

	if __wf_atom_7e8ad928(p2) then
		v2 = object:GetPosition() + Vector(0, 5.5, 0)
	elseif p2 then
		v2 = object:__wf_atom_1c374cc9(Symbol(throwRightHandStartBoneName))
	else
		v2 = object:__wf_atom_1c374cc9(Symbol(throwLeftHandStartBoneName))
	end

	return v2, Engine.__wf_atom_2e1382d1(v2, p, throwProjType, true)
end

local function fn2(object, position, p)
	local v2, v3 = fn(object, position, p)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(rockHoldFx)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	local entity = gRegion:CreateEntity(throwProjType, v2, v3, object, object, 1)
	entity:__wf_atom_7c167bd0(object)
	entity:__wf_atom_7ebba814(object)
end

local function fn3(position, p) -- 1 equivalent call inferred from this helper
	local v2 = __wf_atom_fa8d0177(position, p)
	v2.pitch = 0
	v2.bank = 0
	return v2
end

local function fn4(object, entity, p)
	local v2 = Vector(0, 0, 0)
	local total = 0
	local v3 = nil

	while total < p and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(object)) then
			local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(entity)
			local __wf_atom_510474d7 = throwProjType:__wf_atom_510474d7()
			local v4 = __wf_atom_8a6b8fc3 / __wf_atom_510474d7

			if v3 ~= nil then
				local _, v5 = fn(object, v3, true)
				v4 = __wf_atom_8a6b8fc3 / (math.cos((math.rad((math.abs(v5.pitch))))) * __wf_atom_510474d7)
			end

			if not entity:__wf_atom_7b82e9e1(4) then
				v2 = entity:MotionControl():__wf_atom_0cf4ee4b()
			end

			local v5 = entity:__wf_atom_a06d543c() * rockThrowPredictAddOn
			local v6 = 1

			if Length(v2) < 0.1 then
				v5 = 0
			elseif Length(v2) > rockThrowAngleMultipleVelocityThreshold then
				local v7 = entity:GetPosition() + v2 * v4
				local v8 = Distance(v7, entity:GetPosition())
				local v9 = object:GetPosition() - entity:GetPosition()
				local v10 = v7 - entity:GetPosition()
				Normalize(v9)
				Normalize(v10)
				local v11 = math.abs((__wf_atom_d08b2f29(v9, v10)))

				if v11 > 180 then
					v11 = 360 - v11
				end

				local v12 = 90 - math.deg((math.asin((__wf_atom_421b01aa(v8 / 2 / __wf_atom_8a6b8fc3, -1, 1)))))
				v6 = __wf_atom_421b01aa(
					(v11 / 180 + 1 - v12 / 180) * rockThrowAnglePredictMultiple,
					rockThrowAnglePredictRange.minValue,
					rockThrowAnglePredictRange.maxValue
				)
			end

			v3 = entity:GetPosition() + v2 * v4 * rockThrowPredictMultiple * v6 + v5
			local v7 = fn3(object:GetPosition(), v3) -- inferred equivalent call

			if showDebug then
				gRegion:__wf_atom_b5c21154(v3 + Vector(0, 0.1, 0), 1, debugColour, Rotation(0, 90, 0), 0)
				gRegion:__wf_atom_5b35a0c8(v3 + Vector(0, 1, 0), Color(0, 255, 0), "Predict Position", 2, 0)
			end

			object:__wf_atom_84d66e8e(v7)
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	object:__wf_atom_84d66e8e((object:__wf_atom_0e1e5bc9()))
	return v3
end

local function fn5(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(19, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(17, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(18, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
		object:__wf_atom_994cbb44(2, v)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(19, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(17, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(18, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, v)
		object:__wf_atom_d61b16cd(2, v)
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if __wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443() then
		local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget

		if
			triggerDistance.minValue <= distanceToTarget
			and distanceToTarget <= triggerDistance.maxValue
			and avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5
		then
			object:__wf_atom_f7170fc9(avatar)
			return 1
		end
	end

	return 0
end

function ActivateAbility(_, object, entity, _)
	if gRegion:IsMaster() then
		local v2 = 0

		if
			__wf_atom_7e8ad928(entity)
			and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
		then
			entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end

		local position

		if not __wf_atom_7e8ad928(throwAnim) then
			fn5(object, true)
			local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(throwAnim, false, 2, 1, false)
			local v3 = throwAnim:__wf_atom_091354f5(Symbol(footSlamAnimEvent)) * __wf_atom_921c1a5f
			local v4 = throwAnim:__wf_atom_091354f5(Symbol(throwAnimEvent)) * __wf_atom_921c1a5f
			Sleep(v3)
			local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol(footSlamRightBoneName))
			local radialDamageData = Engine.RadialDamageData()
			radialDamageData.radius = footSlamAoeRadius
			radialDamageData.baseAmount = footSlamAoeDamage
			radialDamageData.stabilityDamage = footSlamAoeStabilityDamage
			radialDamageData.hitAirborneTargets = footSlamHitAirborne
			radialDamageData.checkForCover = footSlamCheckCover
			radialDamageData.baseProcChance = footSlamAoeDamageProcChance
			radialDamageData.blockableProjType = 4
			radialDamageData:__wf_atom_7498285f(footSlamAoeDamageType, 1)
			radialDamageData:__wf_atom_d6f4d914(footSlamAoeDamageProc, true)
			radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
			radialDamageData.fallOff = footSlamAoeDamageFallOff
			radialDamageData:__wf_atom_6b472125(object)
			radialDamageData:__wf_atom_34a8a27a(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
			gRegion:__wf_atom_f6ec80de(radialDamageData)
			gRegion:CreateEntity(slamFxType, __wf_atom_1c374cc9, __wf_atom_80368bb1)

			if showDebug then
				gRegion:__wf_atom_b5c21154(__wf_atom_1c374cc9, footSlamAoeRadius, debugColour, Rotation(0, 90, 0), 2)
			end

			v2 = __wf_atom_921c1a5f - v4

			if debugUseThrowTime then
				v2 = __wf_atom_921c1a5f - debugThrowTime
				position = fn4(object, entity, debugThrowTime - v3)
			else
				position = fn4(object, entity, v4 - v3)
			end
		end

		if not __wf_atom_7e8ad928(entity) then
			if position == nil then
				position = entity:GetPosition()
			end

			fn2(object, position, false)
		end

		if v2 > 0 then
			Sleep(v2)
		end

		fn5(object, false)
	elseif not __wf_atom_7e8ad928(throwAnim) then
		local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(throwAnim, false, 2, 1, false)
		local v2 = throwAnim:__wf_atom_091354f5(Symbol(footSlamAnimEvent)) * __wf_atom_921c1a5f
		Sleep(v2)
		local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol(footSlamLeftBoneName))
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = footSlamAoeRadius
		radialDamageData.baseAmount = footSlamAoeDamage
		radialDamageData.stabilityDamage = footSlamAoeStabilityDamage
		radialDamageData.hitAirborneTargets = footSlamHitAirborne
		radialDamageData.checkForCover = footSlamCheckCover
		radialDamageData.blockableProjType = 4
		radialDamageData:__wf_atom_7498285f(footSlamAoeDamageType, 1)
		radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
		radialDamageData.fallOff = footSlamAoeDamageFallOff
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end
end

function DeactivateAbility(_, object, _, _)
	object:__wf_atom_78ad8b9f(128, 1)
end