local v = nil
Type("/SF/Types/Enemies/Sinecure/OdeDrone/HitProxies/OdeDroneCarryObjectHitProxy")
local v2 = -1
local module = require("SF.Scripts.Libs.EncounterLib")

local function fn(carryObjectWeights)
	local total = 0

	for i = 1, #carryObjectWeights do
		total += carryObjectWeights[i]
	end

	local v3 = math.random() * total
	local total2 = 0

	for i = 1, #carryObjectWeights do
		total2 += carryObjectWeights[i]

		if v3 <= total2 then
			return i
		end
	end
end

local function fn2(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if #possibleCarryObjects == 0 then
		object:__wf_atom_78ad8b9f(4, 0)
		return
	end

	object:__wf_atom_921c1a5f(nil, false)
	object:__wf_atom_78ad8b9f(5, 1)
	local v3 = fn(carryObjectWeights)
	local v4 = Resource(possibleCarryObjects[v3])
	local __wf_atom_b6b760b5 = v4:__wf_atom_b6b760b5()
	local v5 = __wf_atom_b6b760b5:__wf_atom_0aa77159() * v4:__wf_atom_c082fc3d()
	local v6 = __wf_atom_b6b760b5:__wf_atom_ee03557f() * v4:__wf_atom_c082fc3d()
	local v7 = v6.x - v5.x - 0.1
	local __wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
	local __wf_atom_28d5d4aa3 = __wf_atom_28d5d4aa
	local __wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

	if not (__wf_atom_7e8ad928(carryMinAnim) or __wf_atom_7e8ad928(carryMaxAnim)) then
		__wf_atom_28d5d4aa2 = carryMinAnim:__wf_atom_df9e931d(Symbol("GAME_L1_HAND"), 0)
		__wf_atom_28d5d4aa3 = carryMinAnim:__wf_atom_df9e931d(Symbol("GAME_R1_HAND"), 0)
		__wf_atom_28d5d4aa4 = carryMaxAnim:__wf_atom_df9e931d(Symbol("GAME_L1_HAND"), 0)
		__wf_atom_28d5d4aa = carryMaxAnim:__wf_atom_df9e931d(Symbol("GAME_R1_HAND"), 0)
	end

	local v8 = Distance(__wf_atom_28d5d4aa2, __wf_atom_28d5d4aa3)
	local v9 = Distance(__wf_atom_28d5d4aa4, __wf_atom_28d5d4aa)
	local v10 = v9 - v8

	if v10 == 0 then
		return
	end

	object:__wf_atom_78ad8b9f(4, (__wf_atom_421b01aa((v7 - v8) / v10, v8, v9)))
	Sleep(0)
	local v11 = __wf_atom_0a00e162(object:__wf_atom_8e4cf043(Symbol("GAME_L1_HAND")))
	local v12 = __wf_atom_d919c2d7(v11, Rotation(object:__wf_atom_2f2bada0().heading, 0, 0))
	local __wf_atom_4f3dd5f0 = object:__wf_atom_4f3dd5f0(Symbol("GAME_L1_HAND"))
	local v13 = (object:__wf_atom_4f3dd5f0(Symbol("GAME_R1_HAND")) - __wf_atom_4f3dd5f0) / 2 + carryObjectOffsets[v3]
	local v14 = __wf_atom_9341614d(v13, v12)
	v = object:Attach(possibleCarryObjects[v3], Symbol("GAME_L1_HAND"), v14, v12)

	if __wf_atom_7e8ad928(v) then
		return
	end

	v:__wf_atom_0ed81088(false)
	v:__wf_atom_b811702e(Symbol("OdeDroneCarryItem"))
	local __wf_atom_be0bea4a = v:__wf_atom_be0bea4a()

	for _, v15 in ipairs(__wf_atom_be0bea4a) do
		for _, className in ipairs(typesToDestroyFromCarriedObject) do
			if v15:IsA(className) then
				gRegion:__wf_atom_dd1e4d10(v15)
			end
		end
	end

	local v15 = v14 + __wf_atom_9341614d(Vector(0, (v6.y - v5.y) / 2, 0), v11)
	object:Attach(carryObjectHitProxies[v3], Symbol("GAME_L1_HAND"), v15, v12):__wf_atom_93a91ac2()
end

local function fn3(object)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for _, v3 in ipairs(__wf_atom_be0bea4a) do
		if not v3:HasTag(Symbol("OdeDroneCarryItem")) then
			continue
		end

		v3:__wf_atom_e6ed03c8()
		gRegion:__wf_atom_dd1e4d10(v3)
	end

	object:__wf_atom_78ad8b9f(4, 0)
	object:__wf_atom_78ad8b9f(5, 0)
	local __wf_atom_be0bea4a2 = object:__wf_atom_be0bea4a()

	for _, v3 in ipairs(__wf_atom_be0bea4a2) do
		if __wf_atom_7e8ad928(v3) or not v3:HasTag(Symbol("OdeDroneCarryItemHitProxy")) then
			continue
		end

		gRegion:__wf_atom_dd1e4d10(v3)
		break
	end
end

function OdeDrone(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if #possibleCarryObjects ~= #carryObjectWeights then
		print("ERROR: Ode drone size of possibleCarryObjects does not match size of carryObjectWeights")
		return
	end

	object:__wf_atom_51cd6126(Symbol("OdeDroneDropObjectOnDamaged"), "OnDamaged")

	if gRegion:IsMaster() then
		fn2(object)
		Sleep(0)

		if object:__wf_atom_52077f7a(Symbol("SiegeMineLaying")) then
			fn3(object)
		end
	end
end

function Charge(p)
	if __wf_atom_7e8ad928(p) then
	end
end

function Fire(p)
	if __wf_atom_7e8ad928(p) then
	end
end

function NpcEvaluateAbility(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return 0
	end

	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local v3 = Time()
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if
		v3 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(alarmGlobalCooldownIdentifier) < alarmGlobalCooldown
		or not __wf_atom_30e3d82b:__wf_atom_351e924e()
	then
		return 0
	end

	if not __wf_atom_7e8ad928(object2:__wf_atom_d2b2176d()) then
		local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:__wf_atom_dedeec57() then
			return 0
		end
	end

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget > alarmTargetRange.minValue
		and __wf_atom_9a1e4ed3.distanceToTarget < alarmTargetRange.maxValue
	then
		if v2 == -1 then
			v2 = v3
			return 0
		end

		if v2 > v3 - alarmRequiredHaveTargetTime then
			return 0
		end

		if alarmSkipTeammateCheck then
			object:__wf_atom_e638fc23(__wf_atom_9a1e4ed3.avatar:GetPosition())
			__wf_atom_30e3d82b:__wf_atom_11d3ea0f(alarmGlobalCooldownIdentifier, v3)
			v2 = -1
			return 1
		else
			local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

			for i = 1, #__wf_atom_694c2c5b do
				if
					__wf_atom_7e8ad928(__wf_atom_694c2c5b[i])
					or object2 == __wf_atom_694c2c5b[i]
					or __wf_atom_694c2c5b[i]:IsKilled()
				then
					continue
				end

				if not (__wf_atom_694c2c5b[i]:__wf_atom_9af7625d(object2) < alarmTargetRange.maxValue * alarmTargetRange.maxValue) then
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
				__wf_atom_30e3d82b:__wf_atom_11d3ea0f(alarmGlobalCooldownIdentifier, v3)
				v2 = -1
				return 1
			end
		end
	elseif
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		v2 = -1
	end

	return 0
end

function ActivateAbility(_, object, _, _, position)
	if gRegion:IsMaster() then
		object:__wf_atom_78ad8b9f(6, 1)
		object:__wf_atom_e06358f3(Symbol("ALARM"))
		local v3 = alarmAllyCallingRange * alarmAllyCallingRange
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_eda97f5a()) then
			position = __wf_atom_30e3d82b:__wf_atom_eda97f5a():GetPosition()
		end

		local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

		for _, v4 in ipairs(__wf_atom_694c2c5b) do
			if __wf_atom_7e8ad928(v4) or v4:IsKilled() or v4 == object or v4:__wf_atom_bedb4e3f() then
				continue
			end

			if not (v4:__wf_atom_9af7625d(object) <= v3) then
				continue
			end

			local __wf_atom_30e3d82b2 = v4:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b2) then
				__wf_atom_30e3d82b2:__wf_atom_03cc4f3c(alarmOrderAddedToAllies, position, 0)
			end
		end

		local total = 0

		while total < 5 do
			total += __wf_atom_084b3e93()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_eda97f5a()) then
				object:__wf_atom_84d66e8e(__wf_atom_fa8d0177(
					object:GetPosition(),
					__wf_atom_30e3d82b:__wf_atom_eda97f5a():GetPosition()
				))
			end

			Sleep(0)
		end

		object:__wf_atom_78ad8b9f(6, 0)
		object:__wf_atom_e06358f3(Symbol(""))
	end
end

function DeactivateAbility(_, _) end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_78ad8b9f(5, 0)

	if not __wf_atom_7e8ad928(v) and v:__wf_atom_f7e7be53() == object then
		local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_L1_HAND"))
		local __wf_atom_1c374cc9_2 = object:__wf_atom_1c374cc9(Symbol("GAME_R1_HAND"))

		for i = 1, #possibleCarryObjects do
			if not v:IsA(possibleCarryObjects[i]) then
				continue
			end

			local v3 = (__wf_atom_1c374cc9 + __wf_atom_1c374cc9_2) / 2 + carryObjectOffsets[i]
			local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
			gRegion:CreateEntity(physicsObjects[i], v3, __wf_atom_2f2bada0):__wf_atom_8a035cd5(
				Symbol("DestroyIfRolledTooFar"),
				false
			)
			break
		end

		v:__wf_atom_e6ed03c8()

		if not __wf_atom_7e8ad928(v) then
			gRegion:__wf_atom_dd1e4d10(v)
		end

		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

		for _, v3 in ipairs(__wf_atom_be0bea4a) do
			if __wf_atom_7e8ad928(v3) or not v3:HasTag(Symbol("OdeDroneCarryItemHitProxy")) then
				continue
			end

			gRegion:__wf_atom_dd1e4d10(v3)
			return
		end
	end
end

function DestroyIfRolledTooFar(instance)
	if __wf_atom_7e8ad928(instance) or not gRegion:IsMaster() then
		return
	end

	local position = instance:GetPosition()
	local __wf_atom_b6b760b5 = instance:__wf_atom_b6b760b5()

	while not __wf_atom_7e8ad928(instance) do
		if instance:__wf_atom_b6b760b5() ~= __wf_atom_b6b760b5 then
			break
		end

		if __wf_atom_a93b9922(instance:GetPosition(), position) > 36 then
			local v3 = -1

			for i = 1, #possibleCarryObjects do
				if not instance:IsA(possibleCarryObjects[i]) then
					continue
				end

				v3 = i
				break
			end

			if v3 ~= -1 and not __wf_atom_7e8ad928(carryObjectDropTables) and v3 <= #carryObjectDropTables then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
				local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
				local enemyLevel = module.GetEnemyLevel(__wf_atom_c4f78a8f)
				local v4 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

				for i = 1, #__wf_atom_ef7900cf do
					local v5 = __wf_atom_ef7900cf[i]

					if __wf_atom_ef7900cf[i]:__wf_atom_a5304c35(position) < maxRewardDistance then
						carryObjectDropTables[v3]:__wf_atom_0ad20b11(v5, __wf_atom_c4f78a8f, __wf_atom_e93896ba, v4)
					end
				end
			end

			instance:MakeVulnerable()
			instance:Damage(999)
			break
		else
			Sleep(0)
		end
	end
end

function OnDeath(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) then
	end
end