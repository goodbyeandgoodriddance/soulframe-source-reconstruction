local v = nil
local v2 = false
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Effects.IdolEffects")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v3 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v4 = Vector(0, 1, 0)
mSummonHerdConfig1 = {
	spawnPositions = {
		{ pos = Vector(3, 0, 0), rot = Rotation(-40, 0, 0), waveDelay = 0 },
		{ pos = Vector(-3, 0, 0), rot = Rotation(40, 0, 0), waveDelay = 0 },
		{ pos = Vector(7, 0, 6), rot = Rotation(-40, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-7, 0, 6), rot = Rotation(40, 0, 0), waveDelay = 0 }
	},
	distanceFromTarget = 10
}
mSummonHerdConfig2 = {
	spawnPositions = {
		{ pos = Vector(0, 0, 0), rot = Rotation(0, 0, 0), waveDelay = 0 },
		{ pos = Vector(5, 0, -2), rot = Rotation(0, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-5, 0, -2), rot = Rotation(0, 0, 0), waveDelay = 0 },
		{ pos = Vector(10, 0, -4), rot = Rotation(0, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-10, 0, -4), rot = Rotation(0, 0, 0), waveDelay = 0 }
	},
	distanceFromTarget = 15
}
mSummonHerdConfig3 = {
	spawnPositions = {
		{ pos = Vector(7, 0, 0), rot = Rotation(-90, 0, 0), waveDelay = 0 },
		{ pos = Vector(-7, 0, 0), rot = Rotation(90, 0, 0), waveDelay = 0 },
		{ pos = Vector(0, 0, 7), rot = Rotation(-90, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(0, 0, -7), rot = Rotation(90, 0, 0), waveDelay = 0 }
	},
	distanceFromTarget = 11
}
mAllSummonConfigs = {
	{ table = mSummonHerdConfig1 },
	{ table = mSummonHerdConfig2 },
	{ table = mSummonHerdConfig3 }
}

local function fn(object, instance)
	return not __wf_atom_7e8ad928(instance)
		and not (instance:IsKilled() or instance:__wf_atom_129d1aba(object))
		and not instance:HasTag(mOwner:__wf_atom_37768748())
		and instance:IsVisible()
end

local function fn2(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		__wf_atom_d2b2176d:Unequip(0, 2)
		Sleep(0)
	end
end

function EvaluateAbility(object, object2, _)
	local aimPosition = object2:GetAimPosition()
	local v5 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
	local v6 = object2:__wf_atom_0251b5eb(2, 30, 4, true, true, false, false) or {}
	local v7 = {}

	for _, v8 in ipairs(v6) do
		if not (fn(object2, v8) and Dot(v8:__wf_atom_a2a18137() - aimPosition, v5) > 0) then
			continue
		end

		table.insert(v7, v8)
	end

	if #v7 > 0 then
		object:__wf_atom_f7170fc9(v7[1])
	end

	return true
end

function ActivateAbility(object, object2, object3, _)
	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	module.SetForceAim(object2, mOwner, true)
	local __wf_atom_74d951b0 = object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	fn2(object2)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v5

	if not __wf_atom_7e8ad928(pactFxType) then
		v5 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if object2:__wf_atom_59cb39a4() then
		if not module.PlayAnimAndSuspendUntilEvent(object, summonHerdAnim, "Cast", false, 2, 1, false) then
			return
		end
	elseif not module.PlayAnimAndSuspendUntilEvent(object, summonHerdAnim, "Cast", false, 4, 1, false) then
		return
	end

	if gRegion:IsMaster() then
		local v6

		if v2 or object2:IsKilled() or object2:__wf_atom_bedb4e3f() then
			print("WARNING - Mendicant Rider - Summon Herd aborted early.")
			v6 = true
		else
			v6 = false
		end

		if not v6 then
			if __wf_atom_7e8ad928(object3) then
				v = __wf_atom_74d951b0
			else
				v = object3:__wf_atom_a2a18137()
			end

			object2:__wf_atom_8a035cd5(Symbol("_LocalHandleProjectileSpawning"), false)
		end
	end

	module.RemoveCastImmunity(object2)
	module.SetForceAim(object2, mOwner, false)
	module.EnableWeaponFiring(object2, mOwner, true)

	while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(summonHerdAnim) do
		Sleep(0)
	end

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():__wf_atom_1870de39(false)
	end

	Sleep(0.6)

	if not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end
end

function HugTheGround(object)
	object:__wf_atom_53bcb18b(__wf_atom_28d5d4aa)
	local taggedChild = module2.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("HerdDeco"))

	if __wf_atom_7e8ad928(taggedChild) then
		return
	end

	taggedChild:__wf_atom_de14bbe2()
	taggedChild:SetVisibility(true, true)
	local v5 = triggeredAnim:__wf_atom_091354f5(Symbol("MoveStart")) * triggeredAnim:__wf_atom_8bb4ded3()
	Sleep(v5)
	local v6 = Vector(0, 1, 0)
	local v7 = Vector(0, -10, 0)
	object:__wf_atom_53bcb18b(object:__wf_atom_a06d543c() * object:__wf_atom_510474d7())
	local __wf_atom_dcc5c1a1 = object:__wf_atom_dcc5c1a1()
	__wf_atom_dcc5c1a1.y = 0
	Normalize(__wf_atom_dcc5c1a1)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()
	local droppedProjectileRate2 = droppedProjectileRate
	local v8 = false
	local v9

	while true do
		droppedProjectileRate2 += __wf_atom_084b3e93()

		if droppedProjectileRate < droppedProjectileRate2 then
			droppedProjectileRate2 = 0
			local position = object:GetPosition()
			local v10 = __wf_atom_d919c2d7(object:__wf_atom_dc309f8a(), Rotation(180, 0, 0))
			local entity = gRegion:CreateEntity(
				droppedProjectile,
				position,
				v10,
				__wf_atom_9f2332e5,
				__wf_atom_9f2332e5
			)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_8fcdea81(object:__wf_atom_7be51ede())
				entity:__wf_atom_c6dbdab6(__wf_atom_9f2332e5)
				local __wf_atom_083a9e64 = __wf_atom_9f2332e5:__wf_atom_083a9e64()
				entity:__wf_atom_c35005f7(__wf_atom_083a9e64:__wf_atom_13497abe())
				__wf_atom_083a9e64:__wf_atom_95203424(entity)
				entity:__wf_atom_53bcb18b(entity:__wf_atom_a06d543c() * entity:__wf_atom_510474d7())
			end
		end

		local __wf_atom_a2a18137_2 = object:__wf_atom_a2a18137()

		if not v8 then
			local __wf_atom_dcc5c1a1_2 = object:__wf_atom_dcc5c1a1()
			local v10 = Length(__wf_atom_dcc5c1a1_2)

			if v10 == 0 then
				v10 = object:__wf_atom_510474d7()
			end

			local v11 = __wf_atom_a2a18137_2 + __wf_atom_dcc5c1a1 * v10 * __wf_atom_084b3e93() * 2
			local v12 = Vector()
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v11 + v6, v11 + v7, v3, nil, v12)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			then
				local v13 = v12 + v4 - object:__wf_atom_a2a18137()
				Normalize(v13)
				object:__wf_atom_53bcb18b(v13 * v10)
			else
				__wf_atom_dcc5c1a1_2.y = 0
				Normalize(__wf_atom_dcc5c1a1_2)
				object:__wf_atom_53bcb18b(__wf_atom_dcc5c1a1_2 * v10)
			end
		end

		if v8 then
			if __wf_atom_a2a18137_2 - __wf_atom_a2a18137 ~= __wf_atom_28d5d4aa then
				local v10 = Vector()
				local v11 = __wf_atom_9341614d(Vector(0, 0.5, 0), object:__wf_atom_2f2bada0())
				v9 = gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137 + v11, __wf_atom_a2a18137_2 + v11, v3, nil, v10)

				if v9 and not v9:HasTag(Symbol("TreeDeco")) then
					break
				end
			end

			__wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		end

		Sleep(0)
		v8 = not v8
	end

	if v9:__wf_atom_83a62c41() ~= v9 then
		print(v9:__wf_atom_83a62c41())
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function _LocalHandleProjectileSpawning(object)
	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(Symbol("HerdConfig"))

	if not (__wf_atom_ccd337ec <= 0) and __wf_atom_ccd337ec ~= 1 and __wf_atom_ccd337ec ~= 2 then
	end

	local v5 = 3
	object:__wf_atom_cecb2d55(Symbol("HerdConfig"), v5)
	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	local tbl = mAllSummonConfigs[v5].table
	local spawnPositions = tbl.spawnPositions
	local v6 = object:GetPosition() - v
	Normalize(v6)
	local _ = Distance(object:GetPosition(), v) + 3 > tbl.distanceFromTarget
	local v7 = v
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local v8 = Rotation(__wf_atom_2f2bada0.heading + 45, 0, 0)

	for i = 1, #spawnPositions do
		local v9

		if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			print("WARNING - Mendicant Rider - Summon Herd aborted early.")
			v9 = true
		else
			v9 = false
		end

		if v9 then
			continue
		end

		if spawnPositions[i].waveDelay > 0 then
			Sleep(spawnPositions[i].waveDelay)
		end

		local pos = spawnPositions[i].pos
		local _rot = spawnPositions[i].rot
		local v10 = v7 + __wf_atom_9341614d(pos, v8) + Vector(0, 1, 0)
		local v11 = __wf_atom_fa8d0177(v10, v)
		local entity = gRegion:CreateEntity(herdProjectile, v10, v11, __wf_atom_9fb9a1d6, __wf_atom_9fb9a1d6)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(__wf_atom_9fb9a1d6)
			entity:__wf_atom_7c167bd0(object)
			local __wf_atom_083a9e64 = __wf_atom_9fb9a1d6:__wf_atom_083a9e64()
			entity:__wf_atom_c35005f7(__wf_atom_083a9e64:__wf_atom_13497abe())
			__wf_atom_083a9e64:__wf_atom_95203424(entity)
			entity:__wf_atom_8a035cd5(Symbol("HugTheGround"), false)
		end

		gRegion:Raycast(v10, v10 - Vector(0, 2, 0), nil, nil, v10, true)
		gRegion:CreateEntity(projectileSpawnFxType, v10, __wf_atom_80368bb1, object, object)
		Sleep(0.1)
	end
end

function DeactivateAbility(_, object, _, _)
	if not object:__wf_atom_c138b19b(summonHerdAnim, true) then
		object:__wf_atom_2f91774e()
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) then
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
		v2 = true
	end
end