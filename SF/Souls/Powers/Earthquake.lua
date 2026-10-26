local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("BlockingBehavior")

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget > npcUseMinRange and __wf_atom_9a1e4ed3.distanceToTarget < npcUseRange)
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

	return 1
end

function Damage(object, p, p2)
	local __wf_atom_68de036a = object:__wf_atom_68de036a()
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
	radialDamageData:__wf_atom_98d98d81(p2)
	radialDamageData.fallOff = aoeDamageFallOff

	if not __wf_atom_7e8ad928(object) then
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)
end

function ActivateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object2)
	end

	local __wf_atom_4c047e9d = object2:__wf_atom_d2b2176d():__wf_atom_4c047e9d()

	if not __wf_atom_7e8ad928(__wf_atom_4c047e9d) then
		local __wf_atom_66088189 = __wf_atom_4c047e9d:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	if module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "MeleeSlamHeavy", false, 2, 1, true) then
		object:__wf_atom_6a4cf64f()
		local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_L1_WEAPON1"))
		local v2 = Vector(__wf_atom_1c374cc9.x, object2:GetPosition().y, __wf_atom_1c374cc9.z)
		local __wf_atom_2f2bada0 = object2:__wf_atom_2f2bada0()
		local v3 = v2 + __wf_atom_9341614d(Vector(0.35, 0, 1), __wf_atom_2f2bada0)
		Damage(object2, object, v3)
		gRegion:CreateEntity(quakeStompType, v3, __wf_atom_2f2bada0, object2)
		gRegion:CreateEntity(swordCastFx, v3, __wf_atom_2f2bada0, object2)
		local v4 = 0

		while v4 <= 0.5 do
			Sleep(0.5)
			v4 = v4 + __wf_atom_084b3e93() + 0.5
		end

		while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(activateAnim) do
			Sleep(0.1)
		end

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	elseif not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
	end
end

function DeactivateAbility(_, object)
	if not __wf_atom_7e8ad928(object) then
		if object:__wf_atom_c138b19b(activateAnim, true) or object:__wf_atom_3c281634(activateAnim) then
			object:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
		end

		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	end
end