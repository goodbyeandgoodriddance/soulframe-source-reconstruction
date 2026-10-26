require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local v = nil
local v2 = nil
local v3 = Symbol("BromiusClawSpikeImmunity")
local v4 = nil
local v5 = false

local function fn(position, p) -- 1 equivalent call inferred from this helper
	local v6 = __wf_atom_fa8d0177(position, p)
	v6.pitch = 0
	v6.bank = 0
	return v6
end

local function fn2(object, entity, p)
	local v6 = Vector(0, 0, 0)
	local total = 0

	while total < p and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		if IsFrozenSolid(object) or v5 then
			return
		end

		if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(object)) then
			local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(entity)
			local v7 = __wf_atom_8a6b8fc3 / spikeSpawnDistance
			local v8 = spikeSpawnInterval * ((1 - math.pow(spikeSpawnIntervalDecay, v7)) / (1 - spikeSpawnIntervalDecay))

			if not entity:__wf_atom_7b82e9e1(4) then
				v6 = entity:MotionControl():__wf_atom_0cf4ee4b()
			end

			local v9 = entity:__wf_atom_a06d543c() * spikePredictAddOn
			local v10 = 1
			local spikePredictMaxSpeed2 = Length(v6)

			if spikePredictMaxSpeed < spikePredictMaxSpeed2 then
				spikePredictMaxSpeed2 = spikePredictMaxSpeed
				Normalize(v6)
				v6 *= spikePredictMaxSpeed2
			end

			if spikePredictMaxSpeed2 < 0.1 then
				v9 = 0
			elseif spikeAngleMultipleVelocityThreshold < spikePredictMaxSpeed2 then
				local v11 = entity:GetPosition() + v6 * v8
				local v12 = Distance(v11, entity:GetPosition())
				local v13 = object:GetPosition() - entity:GetPosition()
				local v14 = v11 - entity:GetPosition()
				Normalize(v13)
				Normalize(v14)
				local v15 = math.abs((__wf_atom_d08b2f29(v13, v14)))

				if v15 > 180 then
					v15 = 360 - v15
				end

				local v16 = 90 - math.deg((math.asin((__wf_atom_421b01aa(v12 / 2 / __wf_atom_8a6b8fc3, -1, 1)))))
				v10 = __wf_atom_421b01aa(
					(v15 / 180 + 1 - v16 / 180) * spikeAnglePredictMultiple,
					spikeAnglePredictRange.minValue,
					spikeAnglePredictRange.maxValue
				)
			end

			local v11 = entity:GetPosition() + v6 * v8 * spikePredictMultiple * v10 + v9
			local v12 = fn(object:GetPosition(), v11) -- inferred equivalent call

			if showDebug then
				gRegion:__wf_atom_628723a6(
					object:GetPosition() + Vector(0, 1, 0),
					object:GetPosition() + object:__wf_atom_a06d543c() * 10,
					debugColour,
					0
				)
				gRegion:__wf_atom_b5c21154(v11, 1, debugColour, Rotation(0, 90, 0), 0)
				gRegion:__wf_atom_5b35a0c8(v11 + Vector(0, 1, 0), Color(0, 255, 0), "Predict Position", 2, 0)
			end

			v4 = v11
			object:__wf_atom_84d66e8e(v12)
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	object:__wf_atom_84d66e8e((object:__wf_atom_0e1e5bc9()))
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

local function fn3(position, aoeRadius)
	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_ef7900cf()
	end

	for _, v6 in ipairs(v2) do
		if not __wf_atom_7e8ad928(v6) and v6:__wf_atom_d5fda8be(position) < aoeRadius then
			return true
		end
	end
end

function SpawnSpike(instance)
	local creator = instance:GetCreator()
	local __wf_atom_68de036a = creator:__wf_atom_68de036a()
	local v6 = instance:__wf_atom_dc309f8a() + Rotation(0, 10, math.random(-25, 25))
	local entity = gRegion:CreateEntity(spikeFx, instance:GetPosition(), v6, creator, creator)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = aoeRadius
	radialDamageData.baseAmount = aoeDamage + damageRankMod * __wf_atom_68de036a
	radialDamageData.stabilityDamage = aoeStabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
	radialDamageData.hitAirborneTargets = hitAirborne
	radialDamageData.checkForCover = checkCover
	radialDamageData.baseProcChance = aoeDamageProcChance
	radialDamageData.blockableProjType = 4
	radialDamageData:__wf_atom_7498285f(aoeDamageType, 1)
	radialDamageData:__wf_atom_d6f4d914(aoeDamageProc, true)
	radialDamageData:__wf_atom_98d98d81(instance:GetPosition())
	radialDamageData.fallOff = aoeDamageFallOff

	if not __wf_atom_7e8ad928(creator) then
		radialDamageData:__wf_atom_6b472125(creator)
		radialDamageData:__wf_atom_34a8a27a(creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	end

	local flag

	if
		(__wf_atom_7e8ad928(_T.BromiusSpikeLineHit) or not _T.BromiusSpikeLineHit)
		and fn3(instance:GetPosition(), aoeRadius)
	then
		_T.BromiusSpikeLineHit = true
		flag = true
	else
		flag = false
	end

	if spikeLifeTime > spikeAoeDelay then
		if aoeRadius >= 1 then
			Sleep(spikeAoeDelay)

			if showDebug then
				gRegion:__wf_atom_b5c21154(instance:GetPosition(), aoeRadius, debugColour, Rotation(0, 90, 0), 1)
			end

			if flag then
				gRegion:__wf_atom_f6ec80de(radialDamageData)
			end

			if fn3(instance:GetPosition(), aoeRadius) then
				_T.BromiusSpikeLineHit = true
			end
		end

		Sleep(spikeLifeTime - spikeAoeDelay)

		if not __wf_atom_7e8ad928(entity) then
			entity:PlayTriggeredFade()
		end
	else
		Sleep(spikeLifeTime)

		if not __wf_atom_7e8ad928(entity) then
			entity:PlayTriggeredFade()
		end

		if aoeRadius >= 1 then
			Sleep(spikeAoeDelay - spikeLifeTime)

			if showDebug then
				gRegion:__wf_atom_b5c21154(instance:GetPosition(), aoeRadius, debugColour, Rotation(0, 90, 0), 1)
			end

			if flag then
				gRegion:__wf_atom_f6ec80de(radialDamageData)
			end

			if fn3(instance:GetPosition(), aoeRadius) then
				_T.BromiusSpikeLineHit = true
			end
		end
	end

	if not __wf_atom_7e8ad928(spikeExplodeFx) then
		gRegion:CreateEntity(spikeExplodeFx, instance:GetPosition(), __wf_atom_80368bb1, creator, creator)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function ClientCreateSpike(object, _, total, _, p)
	_T.BromiusSpikeLineHit = false

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v6 = spikeSpawnTotalDistance / spikeSpawnDistance + 1
	local spikeSpawnInterval = spikeSpawnInterval

	for _ = 1, v6 do
		if __wf_atom_6009c8ed:IsKilled() or __wf_atom_6009c8ed:__wf_atom_bedb4e3f() then
			break
		end

		if not __wf_atom_7e8ad928(_T.BromiusSpikeLineHit) then
			local _bromiusSpikeLineHit = _T.BromiusSpikeLineHit
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(total, aoeRadius, debugColour, Rotation(0, 90, 0), 3)
		end

		local entity = gRegion:CreateEntity(
			spikeDropElement,
			total,
			__wf_atom_80368bb1,
			__wf_atom_6009c8ed,
			__wf_atom_6009c8ed
		)
		Sleep(0)

		if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_6009c8ed)) then
			entity:__wf_atom_7ebba814(__wf_atom_6009c8ed)
		end

		total += p * spikeSpawnDistance
		Sleep(spikeSpawnInterval)
		spikeSpawnInterval *= spikeSpawnIntervalDecay
	end
end

local function fn4(p, object, object2)
	_T.BromiusSpikeLineHit = false
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol(p))
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()

	if not __wf_atom_7e8ad928(v4) then
		__wf_atom_a06d543c = v4 - __wf_atom_1c374cc9
		__wf_atom_a06d543c.y = 0
		Normalize(__wf_atom_a06d543c)
	end

	if not __wf_atom_7e8ad928(v) then
		__wf_atom_1c374cc9 = v:__wf_atom_0e0a6fee(__wf_atom_1c374cc9) + spikeSpawnStartPosOffset
	end

	local entity = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(entity) then
		entity = entity:__wf_atom_9a1e4ed3()

		if not __wf_atom_7e8ad928(entity) then
			entity = entity.entity
		end
	end

	if not __wf_atom_7e8ad928(entity) and Length(entity:MotionControl():__wf_atom_0cf4ee4b()) < 0.01 then
		__wf_atom_a06d543c = entity:__wf_atom_a2a18137() - __wf_atom_1c374cc9
	end

	Normalize(__wf_atom_a06d543c)
	secondaryScriptArgs:__wf_atom_37d0a93a(__wf_atom_1c374cc9)
	secondaryScriptArgs:__wf_atom_a17e41c6(entity)
	secondaryScriptArgs:__wf_atom_37d0a93a(__wf_atom_a06d543c)
	local _spikeSpawnInterval = spikeSpawnInterval
	object2:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("ClientCreateSpike"), secondaryScriptArgs)
	local v6 = spikeSpawnTotalDistance / spikeSpawnDistance + 1
	local spikeSpawnInterval = spikeSpawnInterval

	if showDebug then
		gRegion:__wf_atom_628723a6(
			__wf_atom_1c374cc9 + Vector(0, 1, 0),
			__wf_atom_1c374cc9 + __wf_atom_a06d543c * spikeSpawnTotalDistance,
			debugColour,
			4
		)
	end

	for _ = 1, v6 do
		if object:IsKilled() or object:__wf_atom_bedb4e3f() then
			break
		end

		if not __wf_atom_7e8ad928(_T.BromiusSpikeLineHit) then
			local _bromiusSpikeLineHit = _T.BromiusSpikeLineHit
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(__wf_atom_1c374cc9, aoeRadius, debugColour, Rotation(0, 90, 0), 3)
		end

		local v7 = __wf_atom_fa8d0177(Vector(0, 0, 0), Vector(__wf_atom_a06d543c.x, 0, __wf_atom_a06d543c.z))
		local entity2 = gRegion:CreateEntity(spikeDropElement, __wf_atom_1c374cc9, v7, object, object)

		if not __wf_atom_7e8ad928(entity2) then
			entity2:__wf_atom_7ebba814(object)
		end

		__wf_atom_1c374cc9 += __wf_atom_a06d543c * spikeSpawnDistance
		Sleep(spikeSpawnInterval)
		spikeSpawnInterval *= spikeSpawnIntervalDecay
	end
end

function SpawnLeft(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d())
		or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
	then
		return
	end

	if IsFrozenSolid(object) or v5 then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	fn4(spikeSpawnLeftHandStartBoneName, object, __wf_atom_e55d02aa)
end

function SpawnRight(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d())
		or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
	then
		return
	end

	if IsFrozenSolid(object) or v5 then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	fn4(spikeSpawnRightHandStartBoneName, object, __wf_atom_e55d02aa)
end

local function fn5(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(19, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(17, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(18, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v3)
		object:__wf_atom_994cbb44(2, v3)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(19, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(17, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(18, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, v3)
		object:__wf_atom_d61b16cd(2, v3)
	end
end

local function fn6(entity, p) -- 4 equivalent calls inferred from this helper
	return not __wf_atom_7e8ad928(entity) and entity:__wf_atom_c6f1f83d() < p
end

function ActivateAbility(_, object, entity, _)
	if not gRegion:IsMaster() then
		return
	end

	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")

	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	object:__wf_atom_30e3d82b():__wf_atom_b414eabf()
	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	fn5(object, true)
	local v6

	if __wf_atom_7e8ad928(entity) then
		v6 = 100
	else
		entity:__wf_atom_c6f1f83d()
		v6 = entity:__wf_atom_c6f1f83d()
	end

	for i = 1, spawnTimes do
		if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			return
		end

		if IsFrozenSolid(object) or v5 then
			break
		end

		local v7 = 0

		if i == 1 then
			if not __wf_atom_7e8ad928(castAnim) then
				local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(castAnim, false, 2, 1, false)
				local v8 = castAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol)) * __wf_atom_921c1a5f
				v7 = __wf_atom_921c1a5f - v8
				fn2(object, entity, v8)
			end

			object:__wf_atom_8a035cd5(Symbol("SpawnLeft"), false)
		else
			local v8

			if __wf_atom_7e8ad928(loopAnim) then
				v8 = 0
			else
				if fn6(entity, v6) then -- inferred equivalent call
					return
				end

				local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(loopAnim, false, 2, 1, false)
				local v9 = loopAnim:__wf_atom_091354f5(Symbol(loopAnimRightHandEventSymbol)) * __wf_atom_921c1a5f
				local v10 = loopAnim:__wf_atom_091354f5(Symbol(loopAnimLeftHandEventSymbol)) * __wf_atom_921c1a5f
				local v11 = math.min(v9, v10)
				v7 = __wf_atom_921c1a5f - math.max(v9, v10)
				v8 = math.abs(v10 - v9)
				fn2(object, entity, v11)
			end

			if fn6(entity, v6) then -- inferred equivalent call
				return
			end

			object:__wf_atom_8a035cd5(Symbol("SpawnRight"), false)
			fn2(object, entity, v8)

			if fn6(entity, v6) then -- inferred equivalent call
				return
			else
				object:__wf_atom_8a035cd5(Symbol("SpawnLeft"), false)
			end
		end

		if fn6(entity, v6) or (object:IsKilled() or object:__wf_atom_bedb4e3f()) then -- inferred equivalent call
			return
		end

		if IsFrozenSolid(object) or v5 then
			break
		end

		if v7 > 0 then
			Sleep(v7 - 0.2)
		end

		if __wf_atom_7e8ad928(castAnim) and __wf_atom_7e8ad928(loopAnim) then
			Sleep(betweenSpawnRoundsInterval)
		end
	end

	if not __wf_atom_7e8ad928(endAnim) then
		object:__wf_atom_921c1a5f(endAnim, true, 2, 1, true)
	end

	fn5(object, false)
	local v7 = 1

	while object:__wf_atom_58dabbc7() and v7 > 0 do
		Sleep(0)
		v7 -= __wf_atom_084b3e93()
	end
end

function DeactivateAbility(_, _, _, _) end

function IsFrozenSolid(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return object:IsFrozenSolid()
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928((mOwner:__wf_atom_c78fa517())) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_7e8ad928(__wf_atom_9d766292) then
		return
	end

	if
		__wf_atom_9d766292:__wf_atom_78650070(19)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(18)
	then
		v5 = true
	end
end