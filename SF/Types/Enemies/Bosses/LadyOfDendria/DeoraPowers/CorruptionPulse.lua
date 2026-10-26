local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local v = {}
local damageSpikes = {}

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local total = 0

	for i = 1, #__wf_atom_d8853f2a do
		local v2 = __wf_atom_d8853f2a[i]

		if not (v2.visible and v2:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v2.distanceToTarget

		if not (distanceToTarget >= 0 and distanceToTarget <= triggerDistance and v2.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		total += (1 - distanceToTarget / triggerDistance) / #__wf_atom_d8853f2a
		object:__wf_atom_f7170fc9(v2.avatar)
	end

	return total
end

local function fn(object)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v2 = 360 / spikeSpawnTotal

	for i = 1, spikeSpawnTotal do
		local v3 = i * v2
		local v4 = spikeSpawnRadius.minValue + math.random() * (spikeSpawnRadius.maxValue - spikeSpawnRadius.minValue)
		local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_a2a18137 + __wf_atom_9341614d(Vector(v4, 0, 0), Rotation(v3, 0, 0)))
		local groundPos = module2.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
		table.insert(v, i, groundPos)
	end
end

local function fn2(object, __wf_atom_1c374cc9)
	if __wf_atom_7e8ad928(spikeEntity) then
		return
	end

	for i = 1, #v do
		local v2 = __wf_atom_fa8d0177(v[i], __wf_atom_1c374cc9)
		local entity = gRegion:CreateEntity(spikeEntity, v[i], v2, object, object)
		table.insert(damageSpikes, entity)
	end
end

function ActivateAbility(p, object)
	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	object:__wf_atom_1c374cc9(damageBone)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = damageRadius
	radialDamageData.baseAmount = aoeDamage + damageRankMod * __wf_atom_68de036a
	radialDamageData.stabilityDamage = aoeStabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
	radialDamageData.hitAirborneTargets = true
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_7498285f(aoeDamageType, 1)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(p)
	radialDamageData:__wf_atom_a8149853(Symbol("OnHit"))
	local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(castAnim, false, 3, 1, false)
	local v2 = castAnim:__wf_atom_091354f5(Symbol("GroundStab")) * __wf_atom_9b5dcd3b
	fn(object)
	local total = 0

	while total < v2 do
		total += __wf_atom_084b3e93()

		if showDebug then
			for i = 1, #v do
				gRegion:__wf_atom_b5c21154(v[i], 1, debugColour, Rotation(0, 90, 0), 0)
			end
		end

		Sleep(0)
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(damageBone)
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
	fn2(object, __wf_atom_1c374cc9)
	local v3 = { damageSpikes = damageSpikes }
	module.SetAbilityStats(p, mOwner, v3)

	if showDebug then
		gRegion:__wf_atom_b5c21154(__wf_atom_1c374cc9, damageRadius, debugColour, Rotation(0, 90, 0), 3)
	end

	object:Attach(spearSlamFxType, Symbol("GAME_R1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
end

function DeactivateAbility(p, object, _, _)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if __wf_atom_7e8ad928(abilityStats) then
		return
	end

	local cleanUpTimer = cleanUpTimer
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	damageSpikes = abilityStats.damageSpikes

	while
		cleanUpTimer > 0
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_7470861b) or __wf_atom_7470861b:__wf_atom_bedb4e3f())
	do
		cleanUpTimer -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if #damageSpikes >= 1 then
		for i = 1, #damageSpikes do
			if not __wf_atom_7e8ad928(damageSpikes[i]) then
				damageSpikes[i]:Destroy()
			end
		end
	end

	if not (__wf_atom_7e8ad928(deactivateSound) or __wf_atom_7e8ad928(object)) then
		object:PlaySound(deactivateSound, false)
	end
end

function OnHit(object, object2)
	if object2 == gRegion:__wf_atom_c4f78a8f() then
		local v2 = object2:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()
		object2:MotionControl():__wf_atom_4bb21efc(v2 * pushForce)
	end
end

function SpikeDamage(instance, object)
	if not __wf_atom_7e8ad928((object:__wf_atom_9d766292())) then
		local creator = instance:GetCreator()
		local v2 = __wf_atom_7e8ad928(creator) and 0 or creator:__wf_atom_68de036a()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = damageRadius
		radialDamageData.baseAmount = aoeDamage + damageRankMod * v2
		radialDamageData.stabilityDamage = aoeStabilityDamage + stabilityDamageRankMod * v2
		radialDamageData.hitAirborneTargets = true
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_7498285f(aoeDamageType, 1)
		radialDamageData:__wf_atom_6b472125(instance)
		radialDamageData:__wf_atom_34a8a27a(instance)
		radialDamageData:__wf_atom_caac739b(Symbol("Sinecure"))
		radialDamageData:__wf_atom_98d98d81(instance:__wf_atom_a2a18137() + Vector(0, 1, 0))
		radialDamageData:__wf_atom_a8149853(Symbol("OnHit"))
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		gRegion:CreateEntity(spikeBurstFxType, instance:__wf_atom_a2a18137(), __wf_atom_80368bb1)

		if showDebug then
			gRegion:__wf_atom_b5c21154(instance:__wf_atom_a2a18137(), damageRadius, debugColour, Rotation(0, 90, 0), 3)
		end

		instance:Destroy()
	end
end