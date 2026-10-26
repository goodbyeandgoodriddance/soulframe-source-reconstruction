local v = nil
local v2 = false
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
		{ pos = Vector(7, 0, 5), rot = Rotation(-90, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-7, 0, 5), rot = Rotation(90, 0, 0), waveDelay = 0 },
		{ pos = Vector(7, 0, 10), rot = Rotation(-90, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-7, 0, 10), rot = Rotation(90, 0, 0), waveDelay = 0 },
		{ pos = Vector(7, 0, 15), rot = Rotation(-90, 0, 0), waveDelay = 0.25 },
		{ pos = Vector(-7, 0, 15), rot = Rotation(90, 0, 0), waveDelay = 0 }
	},
	distanceFromTarget = 11
}
mAllSummonConfigs = {
	{ table = mSummonHerdConfig1 },
	{ table = mSummonHerdConfig2 },
	{ table = mSummonHerdConfig3 }
}

local function fn(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local v3 = Symbol("RiderSlamImmunity")
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(19, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(17, v3)
		__wf_atom_7470861b:__wf_atom_e2ff9126(18, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v3)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v3)
		object:__wf_atom_994cbb44(2, v3)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(19, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(17, v3)
		__wf_atom_7470861b:__wf_atom_fbf4e632(18, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, v3)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, v3)
		object:__wf_atom_d61b16cd(2, v3)
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if __wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(object2) then
		return 0
	end

	local v3 = Distance(avatar:GetPosition(), object2:GetPosition())
	local contains = npcUseRange:Contains(v3)

	if __wf_atom_9a1e4ed3:__wf_atom_a3309443() and contains then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	end

	print("WARNING - Mendicant Rider - Summon Herd failed evaluation. Distance: " .. v3)
	return 0
end

function ActivateAbility(_, object, entity, _)
	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	if __wf_atom_7e8ad928(summonHerdAnim) then
		return
	end

	fn(object, true)
	local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(summonHerdAnim, false, 3, 1, true)
	local v3 = summonHerdAnim:__wf_atom_091354f5(Symbol(summonAnimEvent)) * __wf_atom_921c1a5f

	if gRegion:IsMaster() then
		object:__wf_atom_5127af76(entity, entity:GetPosition())
	end

	Sleep(v3)

	if gRegion:IsMaster() then
		local v4

		if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			print("WARNING - Mendicant Rider - Summon Herd aborted early.")
			v4 = true
		else
			v4 = false
		end

		if not v4 then
			v = entity
			object:__wf_atom_8a035cd5(Symbol("_LocalHandleProjectileSpawning"), false)
		end
	end

	fn(object, false)

	while object:__wf_atom_c138b19b(summonHerdAnim, true) do
		Sleep(0)
	end
end

function _LocalHandleProjectileSpawning(object)
	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(Symbol("HerdConfig"))
	local v3

	if __wf_atom_ccd337ec <= 0 then
		v3 = 1
	elseif __wf_atom_ccd337ec == 1 then
		v3 = 2
	elseif __wf_atom_ccd337ec == 2 then
		v3 = 3
	elseif __wf_atom_ccd337ec == 3 then
		v3 = 1
	else
		v3 = __wf_atom_ccd337ec
	end

	object:__wf_atom_cecb2d55(Symbol("HerdConfig"), v3)
	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	local tbl = mAllSummonConfigs[v3].table
	local spawnPositions = tbl.spawnPositions

	if __wf_atom_7e8ad928(v) then
		return
	end

	local v4 = object:GetPosition() - v:GetPosition()
	Normalize(v4)
	local v5

	if Distance(object:GetPosition(), v:GetPosition()) + 3 > tbl.distanceFromTarget then
		v5 = v:GetPosition() + v4 * tbl.distanceFromTarget
	else
		v5 = object:GetPosition() + object:__wf_atom_a06d543c() * 3
	end

	local v6 = __wf_atom_fa8d0177(v5, v:GetPosition())
	local v7 = Rotation(v6.heading, 0, 0)

	for i = 1, #spawnPositions do
		local v8

		if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			print("WARNING - Mendicant Rider - Summon Herd aborted early.")
			v8 = true
		else
			v8 = false
		end

		if v8 then
			continue
		end

		if spawnPositions[i].waveDelay > 0 then
			Sleep(spawnPositions[i].waveDelay)
		end

		local pos = spawnPositions[i].pos
		local rot = spawnPositions[i].rot
		local v9 = v5 + __wf_atom_9341614d(pos, v7) + Vector(0, 1, 0)
		local v10 = __wf_atom_d919c2d7(rot, v7)
		local entity = gRegion:CreateEntity(herdProjectile, v9, v10, __wf_atom_9fb9a1d6, __wf_atom_9fb9a1d6)
		gRegion:Raycast(v9, v9 - Vector(0, 2, 0), nil, nil, v9, true)
		gRegion:CreateEntity(projectileSpawnFxType, v9, __wf_atom_80368bb1, object, object)
		Sleep(0.1)

		if __wf_atom_7e8ad928(entity) then
			continue
		end

		entity:__wf_atom_8fcdea81(object)
		entity:__wf_atom_c6dbdab6(__wf_atom_9fb9a1d6)
	end
end

function DeactivateAbility(_, object, _, _)
	fn(object, false)

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