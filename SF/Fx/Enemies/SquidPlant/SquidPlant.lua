function WakePlant(object)
	Sleep(math.random(5, 15) * 0.1)

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b())) then
		object:__wf_atom_30e3d82b():__wf_atom_f54283ea()
	end
end

function WakeNearbyPlants(object)
	if not (gRegion:IsMaster() and #wakeTypeList ~= 0) then
		return
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(object:GetPosition(), 20, wakeTypeList)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if wakeImmedate and not __wf_atom_7e8ad928(__wf_atom_a56d7910) and #__wf_atom_a56d7910 > 0 then
		__wf_atom_a56d7910[1]:__wf_atom_30e3d82b():__wf_atom_f54283ea()

		if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
			__wf_atom_a56d7910[1]:__wf_atom_30e3d82b():StormTarget(__wf_atom_9a1e4ed3.entity)
		end
	end

	for _, v in ipairs(__wf_atom_a56d7910) do
		if __wf_atom_7e8ad928(v) then
			continue
		end

		v:__wf_atom_8a035cd5(Symbol("WakePlant"), false)

		if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
			v:__wf_atom_30e3d82b():StormTarget(__wf_atom_9a1e4ed3.entity)
		end
	end
end

function SetDormantState(object)
	if not gRegion:IsMaster() then
		return
	end

	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:SetBlackboardBool(Symbol("Parent"), isParent)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_a260af73(idleLockOnPriority)

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_03ddcde6(false)
	end

	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		if __wf_atom_30e3d82b:__wf_atom_351e924e() then
			object:__wf_atom_a260af73(alertedLockonPriority)
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(lootType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			object:__wf_atom_8a035cd5(Symbol("WakeNearbyPlants"), false)
			object:Attach(eruptFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
			object:__wf_atom_921c1a5f(eruptAnim, false, 2, 1, true)

			if __wf_atom_7e8ad928(object) then
				break
			end

			local position = object:GetPosition()
			local v = math.random(5, 6)
			local __wf_atom_ed99d1ed = uprootHeightRange:__wf_atom_ed99d1ed(0.75)
			local v2 = 0

			while not __wf_atom_7e8ad928(object) and v2 < 1 do
				v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 2, 0, 1)
				local v3 = 1 + (v + 1) * math.pow(v2 - 1, 3) + v * math.pow(v2 - 1, 2)
				object:SetPosition(position + Vector(0, v3 * __wf_atom_ed99d1ed, 0))
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_03ddcde6(true)
			end

			if not __wf_atom_7e8ad928(object) then
				object:SetBlackboardBool(Symbol("Alerted"), true)
				object:__wf_atom_921c1a5f(floatAnim, false, 2, 2, false)
				object:__wf_atom_dd875cd8(false)
			end

			local __wf_atom_ff1686f2 = squidLife:__wf_atom_ff1686f2()
			local v3 = 0

			while v3 < 1 do
				v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / __wf_atom_ff1686f2, 0, 1)
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(object) then
				object:Suicide()
			end
		end

		Sleep(0)
	end
end

function Evaluate(_)
	return true
end

function Activate(instance)
	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	instance:__wf_atom_8914dfde("Explode", instance:__wf_atom_921c1a5f(explodeAnim, true, 3))

	if __wf_atom_7e8ad928(instance) then
		return false
	end

	local position = instance:GetPosition()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = damageAmount
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData.radius = damageRadius
	radialDamageData:__wf_atom_12cf5317(damageImpulse)
	radialDamageData:__wf_atom_98d98d81(position)
	radialDamageData:__wf_atom_6b472125(instance)
	radialDamageData.ignoreSource = true
	radialDamageData.checkForCover = false

	if doPoisonDamage then
		radialDamageData:__wf_atom_d6f4d914(6, true)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(explosionFxType, position, __wf_atom_80368bb1, nil, nil, 1)
	instance:Destroy()
end