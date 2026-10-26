local v = Range(3, 6)
local bowChargedRainArrowCount2 = 20
local v2 = Symbol("RAIN_ARROW_COUNT")
local v3 = Symbol("RAIN_ARROW_DISTANCE")
local v4 = Symbol("Neutral")
local v5 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}

local function fn(object, object2)
	local __wf_atom_74d951b0 = object:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	local eyePosition = object:EyePosition()
	local v6 = __wf_atom_74d951b0 - eyePosition
	local v7 = Length(v6)
	local v8 = 40

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object)) then
		v8 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(v8, 461, object2:__wf_atom_1bb5b1ff(), object2, 26, v3)
	end

	if v8 < v7 then
		Normalize(v6)
		__wf_atom_74d951b0 = eyePosition + v6 * v8
	end

	return __wf_atom_74d951b0
end

function SpawnRainChargeFx(object)
	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(5)
	local v6 = fn(object, __wf_atom_28224c27)
	local v7 = __wf_atom_10cd16b2(v6.x, 0.1)
	local v8 = __wf_atom_10cd16b2(v6.y, 0.1)
	local v9 = __wf_atom_10cd16b2(v6.z, 0.1)
	local entity = gRegion:CreateEntity(targetFxType, v6, __wf_atom_80368bb1)

	while
		not __wf_atom_7e8ad928(__wf_atom_28224c27)
		and not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and (__wf_atom_28224c27:GetState() == 13 or __wf_atom_28224c27:GetState() == 14)
	do
		local __wf_atom_083a9e64 = __wf_atom_28224c27:__wf_atom_083a9e64()
		local v10 = (__wf_atom_7e8ad928(__wf_atom_083a9e64) or not __wf_atom_083a9e64:IsA(__wf_atom_1a007764)) and 0
			or __wf_atom_083a9e64:__wf_atom_925e4bdd()
		local __wf_atom_48a8e71b = v:__wf_atom_48a8e71b((math.sqrt(v10)))
		local v11 = fn(object, __wf_atom_28224c27)
		local v12 = __wf_atom_084b3e93()
		v6.x = v7:__wf_atom_2490589b(v11.x, v12)
		v6.y = v8:__wf_atom_2490589b(v11.y, v12)
		v6.z = v9:__wf_atom_2490589b(v11.z, v12)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetPosition(v6)
			entity:SetMeshScale(__wf_atom_48a8e71b)
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:PlayTriggeredFade()
	end
end

function StartRainCharge(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not __wf_atom_6009c8ed:__wf_atom_8efce136() then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("SpawnRainChargeFx"), false)
end

function SpawnRain(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local bowChargedRainPosition = __wf_atom_e919fb8e.BowChargedRainPosition
	local bowChargedRainWeapon = __wf_atom_e919fb8e.BowChargedRainWeapon
	local bowChargedRainRadius = __wf_atom_e919fb8e.BowChargedRainRadius
	local bowChargedRainProjType = __wf_atom_e919fb8e.BowChargedRainProjType
	local bowChargedRainArrowCount = __wf_atom_e919fb8e.BowChargedRainArrowCount

	if __wf_atom_7e8ad928(bowChargedRainProjType) or __wf_atom_7e8ad928(bowChargedRainWeapon) then
		return
	end

	local __wf_atom_3d08948b = bowChargedRainWeapon:__wf_atom_3d08948b(3)
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local __wf_atom_f7f6708f = bowChargedRainWeapon:__wf_atom_f7f6708f()
	Sleep(1.5)
	local v6 = Range(0.05, 0.1)
	local v7 = bowChargedRainPosition - __wf_atom_a06d543c * 4
	local v8 = Vector(0, 0, 0)
	local _ = bowChargedRainRadius * math.sqrt((__wf_atom_7abf2d2f()))
	local _ = math.random() * 2 * 3.141592653589793
	local count = 0

	while
		count < bowChargedRainArrowCount
		and not (__wf_atom_7e8ad928(bowChargedRainProjType) or __wf_atom_7e8ad928(__wf_atom_3d08948b))
	do
		v8.x = v7.x
		v8.z = v7.z
		v8.y = v7.y
		local v9 = bowChargedRainRadius * math.sqrt((math.random()))
		local v10 = math.random() * 2 * 3.141592653589793
		v8.x += math.cos(v10) * v9
		v8.z += math.sin(v10) * v9
		v8.y += 5 * Random(1, 2)
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa, bowChargedRainPosition, 0, bowChargedRainRadius)
		local v11 = {}

		for i = 1, #all do
			if all[i]:__wf_atom_8c3af1a5(__wf_atom_e93896ba) or all[i]:__wf_atom_e93896ba() == v4 then
				continue
			end

			table.insert(v11, all[i])
		end

		local v12 = __wf_atom_2f2bada0 + Rotation(Random(-10, 10), Random(50, 80), 0)

		if #v11 > 0 and math.random() < math.min(1, #v11 / 4) then
			local v13 = v11[math.random(1, #v11)]
			local __wf_atom_96c119f5 = v13:__wf_atom_7470861b():__wf_atom_96c119f5(0)
			v8.x = __wf_atom_96c119f5.x + Random(-1, 1)
			v8.z = __wf_atom_96c119f5.z + Random(-1, 1)
			local v14 = __wf_atom_96c119f5 + Vector(0, 1, 0) + v13:MotionControl():__wf_atom_0cf4ee4b() * 0.25
			v12 = __wf_atom_fa8d0177(v8, v14)
		end

		local v13 = Vector()
		local v14 = (v8.y - bowChargedRainPosition.y) / math.sin((math.rad(v12.pitch)))
		local v15 = v8 + __wf_atom_9341614d(Vector(0, 0, v14), v12)
		local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v15, v8, v5, nil, v13)

		if
			__wf_atom_c20d246a
			and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			and v13.y - v15.y >= 1
		then
			v8 = v13
		end

		__wf_atom_3d08948b:__wf_atom_2f00a1b2(v8, v12, bowChargedRainProjType, 0, count, __wf_atom_f7f6708f)
		local __wf_atom_ff1686f2 = v6:__wf_atom_ff1686f2()
		Sleep(__wf_atom_ff1686f2)
		count += 1
	end
end

function OnNewRainProjectile(_, object, object2)
	local __wf_atom_6009c8ed = object2:__wf_atom_6009c8ed()
	local bowChargedRainArrowCount = bowChargedRainArrowCount2

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.BowChargedRainArrowCount) then
			bowChargedRainArrowCount = __wf_atom_e919fb8e.BowChargedRainArrowCount
		end
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.numberOfProjectiles = bowChargedRainArrowCount
	local __wf_atom_d293da5d = object:__wf_atom_d293da5d()
	local upgradedValue = Engine.UpgradedValue(0)

	for i = 0, 4 do
		local __wf_atom_4d8ee71d, v6 = __wf_atom_d293da5d:__wf_atom_4d8ee71d(i)

		if not __wf_atom_4d8ee71d then
			continue
		end

		if i == 2 then
			v6 = 1 + (v6 - 1) / bowChargedRainArrowCount
		elseif i < 4 then
			v6 /= bowChargedRainArrowCount
		end

		upgradedValue:__wf_atom_fae96c2e(i, v6)
	end

	upgradedValue:__wf_atom_fae96c2e(2, 0.2)
	object:__wf_atom_746d4173(2, 0.2)
	object:__wf_atom_df6a4117(upgradedValue)

	if bowChargedRainArrowCount > 0 then
		local upgradedValue2 = Engine.UpgradedValue(0)
		upgradedValue2:__wf_atom_fae96c2e(2, 1 / bowChargedRainArrowCount)
		object:__wf_atom_7c5964b8(upgradedValue2)
	end
end

function FireRainFromWeapon(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_a07433fe = __wf_atom_21ed1a39:__wf_atom_a07433fe()
	local bowChargedRainProjType

	if not __wf_atom_7e8ad928(__wf_atom_a07433fe) then
		bowChargedRainProjType = __wf_atom_a07433fe:__wf_atom_b6645301()
	end

	if __wf_atom_7e8ad928(bowChargedRainProjType) then
		return
	end

	__wf_atom_6009c8ed:PlaySound(shootArrowSound, false, 1, false)

	if __wf_atom_6009c8ed:__wf_atom_631bafa1() then
		local __wf_atom_083a9e64 = __wf_atom_21ed1a39:__wf_atom_083a9e64()
		local v6 = (__wf_atom_7e8ad928(__wf_atom_083a9e64) or not __wf_atom_083a9e64:IsA(__wf_atom_1a007764)) and 0
			or __wf_atom_083a9e64:__wf_atom_925e4bdd()
		local bowChargedRainPosition = fn(__wf_atom_6009c8ed, __wf_atom_21ed1a39)
		local __wf_atom_48a8e71b = v:__wf_atom_48a8e71b((math.sqrt(v6)))
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.BowChargedRainPosition = bowChargedRainPosition
		__wf_atom_e919fb8e.BowChargedRainWeapon = __wf_atom_21ed1a39
		__wf_atom_e919fb8e.BowChargedRainProjType = bowChargedRainProjType
		__wf_atom_e919fb8e.BowChargedRainRadius = __wf_atom_48a8e71b

		if not (__wf_atom_7e8ad928(__wf_atom_21ed1a39) or __wf_atom_7e8ad928(__wf_atom_6009c8ed)) then
			bowChargedRainArrowCount2 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
				bowChargedRainArrowCount2,
				461,
				__wf_atom_21ed1a39:__wf_atom_1bb5b1ff(),
				__wf_atom_21ed1a39,
				26,
				v2
			)
		end

		__wf_atom_e919fb8e.BowChargedRainArrowCount = bowChargedRainArrowCount2
		__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("SpawnRain"), false)
	end
end