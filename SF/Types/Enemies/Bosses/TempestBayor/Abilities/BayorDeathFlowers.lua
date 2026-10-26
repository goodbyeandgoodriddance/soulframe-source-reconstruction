local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local v = {}
local position = nil
local v2 = nil
local v3 = {}
local flowers = {}

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget < arcRadius)
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

function CreateFlowers(p)
	local v4 = 2 * arcWidth / rowWidth
	local v5 = fieldSpreadDuration / v4
	local total = 0

	for i = 1, v4 do
		local v6 = CreateFlowerRowLocations(i, total)

		for j = total + 1, total + v6 do
			local v7 = __wf_atom_fa8d0177(v3[j], position)

			if __wf_atom_7e8ad928(flowerFieldEntity) then
				return
			end

			local entity = gRegion:CreateEntity(flowerFieldEntity, v3[j], v7, p, p)
			table.insert(flowers, entity)
		end

		total += v6
		Sleep(v5)
	end
end

function CreateFlowerRowLocations(p, p2)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v4 = math.sqrt(p) * 7
	local v5 = math.ceil(arcLength / v4)

	for i = 1, v5 do
		local v6 = arcRadius - 2 * arcWidth + p * rowWidth + math.random() * rowWidth
		local v7 = v2.heading - arcLength / 2 + i * v4 - math.random() * v4
		local v8 = __wf_atom_e97f3142(Rotation(v7, 0, 0))
		local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(position + v8 * v6)
		local groundPos = module2.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
		table.insert(v3, i + p2, groundPos)
	end

	return v5
end

local function fn(items, object) -- 1 equivalent call inferred from this helper
	for k, item in pairs(items) do
		if item == object then
			return k
		end
	end

	return nil
end

function ApplyFlowerFieldEffects(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(flowerSlowFx)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v4 = Distance(p, Vector(__wf_atom_a2a18137.x, p.y, __wf_atom_a2a18137.z))
	local v5 = math.abs(__wf_atom_fa8d0177(p, __wf_atom_a2a18137).heading - p2.heading)

	if arcRadius - 2 * arcWidth <= v4 and v4 <= arcRadius and v5 <= arcLength / 2 then
		local k = fn(v, object) -- inferred equivalent call

		if __wf_atom_7e8ad928(k) then
			table.insert(v, object)
			object:__wf_atom_d2b2176d():AddUpgrade(101, 2, fieldSlowAmount)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				object:Attach(flowerSlowFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end
end

function ActivateAbility(p, object, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local position2 = __wf_atom_30e3d82b:__wf_atom_216d6edd():GetPosition()
	local v4 = object:__wf_atom_9b5dcd3b(activateAnim, false, 4, 1, true) * activateAnim:__wf_atom_091354f5(spawnFieldEvent)
	object:MotionControl():__wf_atom_3959d938(true)

	while v4 > 0 do
		local v5 = __wf_atom_084b3e93()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_929bb30b() then
			local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

			if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
				position2 = __wf_atom_216d6edd:GetPosition()
				local v6 = __wf_atom_fa8d0177(object:GetPosition(), position2)
				local v7 = __wf_atom_e97f3142(v6)
				local v8 = __wf_atom_a1467d4b(object:__wf_atom_a06d543c(), v7, targetTrackingTurnRate)
				local v9 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v8)
				object:MotionControl():__wf_atom_3a1d0c16(v9)
				object:__wf_atom_51075230(v9)
				object:__wf_atom_84d66e8e(v9)
				__wf_atom_30e3d82b:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, v9, __wf_atom_28d5d4aa)
			end
		end

		Sleep(0)
		v4 -= v5
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(position2) then
		return
	end

	v2 = __wf_atom_fa8d0177(object:GetPosition(), position2)
	position = object:GetPosition()
	object:__wf_atom_8a035cd5(Symbol("CreateFlowers"), false)
	local v5 = { flowers = flowers }
	module.SetAbilityStats(p, mOwner, v5)
	object:__wf_atom_8a035cd5(Symbol("DoFlowerField"), false)
end

function DoFlowerField(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local abilityStats = module.GetAbilityStats(__wf_atom_e55d02aa, mOwner, true)

	if __wf_atom_7e8ad928(abilityStats) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local all = gRegion:FindAll(__wf_atom_c4f78a8f)
	local total = 0
	local total2 = 0
	local total3 = 0

	while total < duration do
		local v4 = __wf_atom_084b3e93()
		Sleep(0)
		total += v4
		total2 += v4

		for i = 1, #all do
			ApplyFlowerFieldEffects(all[i], position, v2)
		end

		if not (total2 >= 1) then
			continue
		end

		local damageData = Engine.DamageData()
		damageData:__wf_atom_6b472125(object)
		damageData:__wf_atom_7498285f(17, 1)
		damageData.baseAmount = damagePerSecond
		total2 = 0

		for i = 1, #v do
			v[i]:__wf_atom_649bf33e(damageData)
			total3 += damageData.baseAmount
		end

		object:Heal(object, total3 * absorbedHealthMult)
		total3 = 0
	end

	if not __wf_atom_7e8ad928(v) then
		for _ = 1, #v do
			local v4 = v[1]

			if __wf_atom_7e8ad928(v4) then
				continue
			end

			v4:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, fieldSlowAmount)
			local __wf_atom_bb3e7833 = v4:__wf_atom_bb3e7833(flowerSlowFx)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end

	flowers = abilityStats.flowers

	for i = 1, #flowers do
		if not __wf_atom_7e8ad928(flowers[i]) then
			gRegion:__wf_atom_dd1e4d10(flowers[i])
		end
	end

	__wf_atom_e55d02aa:__wf_atom_e8954328()
end

function DeactivateAbility(p, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928((module.GetAbilityStats(p, mOwner, true))) then
	end
end