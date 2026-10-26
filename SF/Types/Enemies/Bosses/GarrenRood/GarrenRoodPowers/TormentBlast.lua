local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Rotation(0, 90, 0)

local function fn(object)
	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = spearRemovedDamageRadius
	radialDamageData.baseAmount = spearRemovedDamage + damageRankMod * __wf_atom_68de036a
	radialDamageData.stabilityDamage = spearRemovedStabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
	radialDamageData:__wf_atom_7498285f(aoeDamageType, 1)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_1c374cc9(damageSpawnBone))
	gRegion:__wf_atom_f6ec80de(radialDamageData)
end

function EvaluateAbility(object, object2, _)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local total = 0

	for i = 1, #__wf_atom_d8853f2a do
		local v2 = __wf_atom_d8853f2a[i]

		if not (v2.visible and v2:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v2.distanceToTarget

		if not (aoeRangeMin <= distanceToTarget and distanceToTarget <= aoeRangeMid and v2.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		total += (1 - distanceToTarget / aoeRangeMid) / #__wf_atom_d8853f2a
		object:__wf_atom_f7170fc9(v2.avatar)
	end

	return total
end

function ActivateAbility(p, object)
	local radialDamageData = Engine.RadialDamageData()
	local v2 = {
		closeDamage = inrangeDamage,
		closeStabDamage = innerStabilityDamage,
		farDamage = outRangeDamage,
		farStabDamage = outerStabilityDamage
	}
	module.SetAbilityStats(p, mOwner, v2)
	radialDamageData.radius = aoeRangeMax
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_1c374cc9(damageSpawnBone))

	if ignoreFactionSym then
		radialDamageData:__wf_atom_caac739b(ignoreFactionSym)
	end

	radialDamageData:__wf_atom_1e7d87e6(WeakResource("/EE/Types/Engine/Decoration"))
	radialDamageData:__wf_atom_a8149853(Symbol("OnHit"))

	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():AddUpgrade(169, 3, 0.5)
	end

	object:__wf_atom_9b5dcd3b(activateAnim, false, 2, 3, true)

	if object:__wf_atom_71a94e55(castFXSpawnBone) then
		object:Attach(castingVFX, castFXSpawnBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
	end

	object:__wf_atom_8914dfde("SpearRemoved", 4)
	fn(object)
	object:__wf_atom_8914dfde("CastLoopStart", 4)
	object:__wf_atom_9b5dcd3b(castLoopAnim, false, 2, 2, true)
	Sleep(castDuration)
	object:__wf_atom_9b5dcd3b(endAbilityAnim, false, 2, 1, true)
	object:__wf_atom_8914dfde("CastFinished", 4)

	if drawDebugRadius then
		gRegion:__wf_atom_b5c21154(
			object:__wf_atom_1c374cc9(damageSpawnBone) + Vector(0, 0.5, 0),
			aoeRangeMid,
			debugColourMidRange,
			v,
			10
		)
		gRegion:__wf_atom_b5c21154(
			object:__wf_atom_1c374cc9(damageSpawnBone) + Vector(0, 0.5, 0),
			aoeRangeMax,
			debugColourMaxRange,
			v,
			10
		)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if object:__wf_atom_71a94e55(castFXSpawnBone) then
		local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(castFXSpawnBone)
		gRegion:CreateEntity(explosionVFX, __wf_atom_1c374cc9, __wf_atom_80368bb1, object)
	end

	Sleep(5)
end

function DeactivateAbility(p, object, _, _)
	object:__wf_atom_0650fed7(castingVFX)
	module.GetAbilityStats(p, mOwner, true)
	object:__wf_atom_0650fed7(explosionVFX)

	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():RemoveUpgrade(169, 3, 0.5)
	end
end

function OnHit(object, object2)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_a043ba8b = __wf_atom_e55d02aa:__wf_atom_a043ba8b()
	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local v2 = Distance(
		object:__wf_atom_1c374cc9(damageSpawnBone),
		Vector(
			object2:__wf_atom_a2a18137().x,
			object:__wf_atom_1c374cc9(damageSpawnBone).y,
			object2:__wf_atom_a2a18137().z
		)
	)
	local abilityStats = module.GetAbilityStats(__wf_atom_e55d02aa, __wf_atom_a043ba8b, false)

	if aoeRangeMin <= v2 and v2 <= aoeRangeMid then
		local damageData = Engine.DamageData()
		damageData.baseAmount = abilityStats.closeDamage + damageRankMod * __wf_atom_68de036a
		damageData.stabilityDamage = abilityStats.closeStabDamage + stabilityDamageRankMod * __wf_atom_68de036a
		damageData:__wf_atom_7498285f(aoeDamageType, 1)
		damageData:__wf_atom_d6f4d914(31, true)
		damageData:__wf_atom_34a8a27a(object)
		object2:__wf_atom_649bf33e(damageData)
	elseif aoeRangeMid <= v2 and v2 <= aoeRangeMax and object2 == gRegion:__wf_atom_c4f78a8f() then
		local damageData = Engine.DamageData()
		damageData.baseAmount = abilityStats.farDamage + damageRankMod * __wf_atom_68de036a
		damageData.stabilityDamage = abilityStats.farStabDamage + stabilityDamageRankMod * __wf_atom_68de036a
		damageData:__wf_atom_7498285f(aoeDamageType, 1)
		damageData:__wf_atom_d6f4d914(31, true)
		damageData:__wf_atom_34a8a27a(object)
		object2:__wf_atom_649bf33e(damageData)
	end
end