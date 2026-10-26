local v = Symbol("RiderSlamImmunity")

local function fn(object, p)
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

	if
		__wf_atom_9a1e4ed3.visible
		and __wf_atom_9a1e4ed3:__wf_atom_a3309443()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	else
		return 0
	end
end

function ActivateAbility(object, object2, entity, _)
	if
		gRegion:IsMaster()
		and __wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()))
	then
		entity = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	fn(object2, true)
	local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(slamAnim, false, 3, 1, true, 1)
	object2:__wf_atom_8914dfde(jumpAnimEvent, __wf_atom_921c1a5f)

	if not object2:__wf_atom_c138b19b(slamAnim) then
		object:__wf_atom_e8954328()
		return
	end

	object2:__wf_atom_7470861b():__wf_atom_9fba31e6(v, 26, 6, 0)
	object2:__wf_atom_8914dfde(lockRotAnimEvent, __wf_atom_921c1a5f)

	if not object2:__wf_atom_c138b19b(slamAnim) then
		object:__wf_atom_e8954328()
		return
	end

	if not __wf_atom_7e8ad928(entity) then
		local v2 = __wf_atom_fa8d0177(object2:GetPosition(), entity:GetPosition())
		object2:__wf_atom_3c986cd9(object2:GetPosition(), v2, true)
	end

	object2:__wf_atom_8914dfde(slamAnimEvent, __wf_atom_921c1a5f)

	if object2:__wf_atom_c138b19b(slamAnim) then
		if gRegion:IsMaster() then
			local position = object2:GetPosition()
			gRegion:Raycast(position + Vector(0, 1, 0), position - Vector(0, 4, 0), nil, nil, position, true)
			gRegion:CreateEntity(aoeSlamFX, position, __wf_atom_80368bb1, object2, object2, 1)
			gRegion:CreateEntity(
				shockwaveType,
				object2:GetPosition() + shockwaveOffset,
				object2:__wf_atom_dc309f8a(),
				object2,
				object2,
				1
			)
		end

		object2:__wf_atom_7470861b():__wf_atom_63396172(v)
		local __wf_atom_68de036a = object2:__wf_atom_68de036a()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = AOEDamageAmount + damageRankMod * __wf_atom_68de036a
		radialDamageData.stabilityDamage = AoeStabilityDamageAmount + stabilityRankMod * __wf_atom_68de036a
		radialDamageData.radius = AoeDamageRadius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_7498285f(7, 1)
		radialDamageData:__wf_atom_12cf5317(15000)
		radialDamageData:__wf_atom_98d98d81(object2:GetPosition())
		radialDamageData:__wf_atom_6b472125(object2)
		radialDamageData:__wf_atom_34a8a27a(object)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		fn(object2, false)

		while object2:__wf_atom_c138b19b(slamAnim, true) do
			Sleep(0)
		end
	else
		object2:__wf_atom_2f91774e()
		object:__wf_atom_e8954328()
	end
end

function DeactivateAbility(_, object, _, _)
	fn(object, false)
	object:__wf_atom_7470861b():__wf_atom_63396172(v)
end