function NpcEvaluateAbility(object, object2)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()

	for i = 1, #__wf_atom_d8853f2a do
		local v = __wf_atom_d8853f2a[i]

		if not v.visible or (__wf_atom_7e8ad928(v.avatar) or v.avatar:__wf_atom_bedb4e3f()) then
			continue
		end

		local distanceToTarget = v.distanceToTarget

		if not (targetDistance.minValue <= distanceToTarget and distanceToTarget <= targetDistance.maxValue and v.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		object:__wf_atom_f7170fc9(v.avatar)
		return 1
	end

	return 0
end

function ActivateAbility(_, object, _)
	if not __wf_atom_7e8ad928(castAnim) then
		object:__wf_atom_8914dfde("Cast", object:__wf_atom_921c1a5f(castAnim, false, 3, 1, true))
	end

	if __wf_atom_7e8ad928(castAnim) or object:__wf_atom_c138b19b(castAnim) then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = damageRadius
		radialDamageData.baseAmount = 25
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_98d98d81(object:__wf_atom_1c374cc9(damageBone))
		radialDamageData.stabilityDamage = stabilityDamage
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		gRegion:CreateEntity(castFX, object:GetPosition() + Vector(0, 1.5, 0), __wf_atom_80368bb1)

		if not object:__wf_atom_c138b19b(castAnim, true) then
			return
		end

		Sleep(0.5)
	end
end

function DeactivateAbility(_, object, _, _)
	if not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(castAnim, true) then
		object:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
	end
end