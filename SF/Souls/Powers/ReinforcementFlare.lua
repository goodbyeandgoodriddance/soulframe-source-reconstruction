local v = Symbol("BlockingBehavior")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local v2 = Time()
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if
		v2 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(uniqueGlobalCooldownIdentifier) < globalCooldown
		or not __wf_atom_30e3d82b:__wf_atom_351e924e()
	then
		return 0
	end

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget > npcUseMinRange and __wf_atom_9a1e4ed3.distanceToTarget < npcUseMaxRange)
	then
		return 0
	end

	local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

	for i = 1, #__wf_atom_694c2c5b do
		if
			__wf_atom_7e8ad928(__wf_atom_694c2c5b[i])
			or object2 == __wf_atom_694c2c5b[i]
			or __wf_atom_694c2c5b[i]:IsKilled()
			or not (__wf_atom_694c2c5b[i]:__wf_atom_9af7625d(object2) < npcUseMaxRange * npcUseMaxRange)
		then
			continue
		end

		local __wf_atom_30e3d82b2 = __wf_atom_694c2c5b[i]:__wf_atom_30e3d82b()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b2)
			or __wf_atom_30e3d82b2:__wf_atom_eda97f5a() == __wf_atom_9a1e4ed3.entity
		then
			continue
		end

		object:__wf_atom_e638fc23(__wf_atom_9a1e4ed3.avatar:GetPosition())
		__wf_atom_30e3d82b:__wf_atom_11d3ea0f(uniqueGlobalCooldownIdentifier, v2)
		return 1
	end

	return 0
end

function ActivateAbility(p, object, _, _, position)
	local v2

	if not __wf_atom_7e8ad928(flareEffectToAttach) then
		v2 = object:Attach(flareEffectToAttach, flareEffectToAttachBodyPart)
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object, 1)
		object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
	end

	local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(startingAnimation, false, 4, 1, false)
	local v3 = startingAnimation:__wf_atom_091354f5(flareEffectToAttachAnimationEvent) * __wf_atom_9b5dcd3b

	if v3 <= 0 or __wf_atom_9b5dcd3b <= v3 then
		v3 = __wf_atom_9b5dcd3b
	end

	local total = 0

	while total < v3 do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if __wf_atom_7e8ad928(object) or not object:__wf_atom_c138b19b(startingAnimation) then
			return
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(fxOnLaunchStartingBodyPart)

	if not __wf_atom_7e8ad928(fxOnLaunch) then
		gRegion:CreateEntity(fxOnLaunch, __wf_atom_1c374cc9, __wf_atom_80368bb1, object, object)
	end

	if not __wf_atom_7e8ad928(flareProjectileToLaunch) then
		local v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, Vector(0, 1, 0))
		v4.heading = math.random(-180, 180)
		v4.pitch += math.random(-angleVariationFromUpDirection, angleVariationFromUpDirection)
		local entity = gRegion:CreateEntity(flareProjectileToLaunch, __wf_atom_1c374cc9, v4, object)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(p)
		end
	end

	if gRegion:IsMaster() then
		local v4 = allyCallingRange * allyCallingRange
		local __wf_atom_30e3d82b2 = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b2:__wf_atom_eda97f5a()) then
			position = __wf_atom_30e3d82b2:__wf_atom_eda97f5a():GetPosition()
		end

		local __wf_atom_694c2c5b = __wf_atom_30e3d82b2:__wf_atom_694c2c5b()

		for _, v5 in ipairs(__wf_atom_694c2c5b) do
			if __wf_atom_7e8ad928(v5) or v5:IsKilled() or v5 == object or v5:__wf_atom_bedb4e3f() then
				continue
			end

			if not (v5:__wf_atom_9af7625d(object) <= v4) then
				continue
			end

			local __wf_atom_30e3d82b3 = v5:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b3) then
				__wf_atom_30e3d82b3:__wf_atom_03cc4f3c(orderAddedToAllies, position, 0)
			end
		end
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(startingAnimation) do
		Sleep(0)
	end
end

function DeactivateAbility(_, object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end

		if
			not object:IsKilled()
			and not object:__wf_atom_bedb4e3f()
			and object:__wf_atom_c138b19b(startingAnimation)
		then
			object:__wf_atom_921c1a5f(nil, false, 2, 1, true)
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(flareEffectToAttach)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end