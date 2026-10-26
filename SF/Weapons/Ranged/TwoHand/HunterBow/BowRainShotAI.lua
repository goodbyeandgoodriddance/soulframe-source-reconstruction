local v = Range(3, 6)
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
	object:PlaySound(shootArrowSound, false, 1, false)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local bowChargedRainPosition = __wf_atom_e919fb8e.BowChargedRainPosition
	local bowChargedRainWeapon = __wf_atom_e919fb8e.BowChargedRainWeapon
	local bowChargedRainRadius = __wf_atom_e919fb8e.BowChargedRainRadius
	local bowChargedRainProjType = __wf_atom_e919fb8e.BowChargedRainProjType

	if __wf_atom_7e8ad928(bowChargedRainProjType) then
		return
	end

	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local numberOfProjectiles = 20

	if not (__wf_atom_7e8ad928(bowChargedRainWeapon) or __wf_atom_7e8ad928(object)) then
		numberOfProjectiles = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
			numberOfProjectiles,
			461,
			bowChargedRainWeapon:__wf_atom_1bb5b1ff(),
			bowChargedRainWeapon,
			26,
			v2
		)
	end

	local __wf_atom_f7f6708f = bowChargedRainWeapon:__wf_atom_f7f6708f()
	object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	Sleep(arrowDelay)
	local v6 = Range(0.05, 0.1)
	local v7 = bowChargedRainPosition - __wf_atom_a06d543c * 4
	local v8 = Vector(0, 0, 0)
	local _ = bowChargedRainRadius * math.sqrt((__wf_atom_7abf2d2f()))
	local _ = math.random() * 2 * 3.141592653589793
	local count = 0
	local v9 = nil

	while count < numberOfProjectiles and not __wf_atom_7e8ad928(bowChargedRainProjType) do
		v8.x = v7.x
		v8.z = v7.z
		v8.y = v7.y
		local v10 = bowChargedRainRadius * math.sqrt((math.random()))
		local v11 = math.random() * 2 * 3.141592653589793
		v8.x += math.cos(v11) * v10
		v8.z += math.sin(v11) * v10
		v8.y += 5 * Random(1, 2)
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa, bowChargedRainPosition, 0, bowChargedRainRadius)
		local v12 = {}

		for i = 1, #all do
			if all[i]:__wf_atom_8c3af1a5(__wf_atom_e93896ba) or all[i]:__wf_atom_e93896ba() == v4 then
				continue
			end

			table.insert(v12, all[i])
		end

		local v13 = __wf_atom_2f2bada0 + Rotation(Random(-10, 10), Random(50, 80), 0)

		if #v12 > 0 and math.random() < math.min(1, #v12 / 4) then
			local v14 = v12[math.random(1, #v12)]
			local __wf_atom_96c119f5 = v14:__wf_atom_7470861b():__wf_atom_96c119f5(0)
			v8.x = __wf_atom_96c119f5.x + Random(-1, 1)
			v8.z = __wf_atom_96c119f5.z + Random(-1, 1)
			local v15 = __wf_atom_96c119f5 + Vector(0, 1, 0) + v14:MotionControl():__wf_atom_0cf4ee4b() * 0.25
			v13 = __wf_atom_fa8d0177(v8, v15)
		end

		local v14 = Vector()
		local v15 = (v8.y - bowChargedRainPosition.y) / math.sin((math.rad(v13.pitch)))
		local v16 = v8 + __wf_atom_9341614d(Vector(0, 0, v15), v13)
		local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v16, v8, v5, nil, v14)

		if
			__wf_atom_c20d246a
			and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			and v14.y - v16.y >= 1
		then
			v8 = v14
		end

		local v17 = object:__wf_atom_535d5cbb() and 0 or 1
		local entity = gRegion:CreateEntity(bowChargedRainProjType, v8, v13, bowChargedRainWeapon, nil, v17)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(bowChargedRainWeapon)

			if not v9 then
				local __wf_atom_d293da5d = entity:__wf_atom_d293da5d()
				v9 = Engine.UpgradedValue(0)

				for i = 0, 4 do
					local __wf_atom_4d8ee71d, v18 = __wf_atom_d293da5d:__wf_atom_4d8ee71d(i)

					if not __wf_atom_4d8ee71d then
						continue
					end

					if i == 2 then
						v18 = 1 + (v18 - 1) / numberOfProjectiles
					elseif i < 4 then
						v18 /= numberOfProjectiles
					end

					v9:__wf_atom_fae96c2e(i, v18)
				end
			end

			local __wf_atom_e919fb8e_2 = entity:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.numberOfProjectiles = numberOfProjectiles
			entity:__wf_atom_df6a4117(v9)
			entity:__wf_atom_946e648a(__wf_atom_f7f6708f)
		end

		local __wf_atom_ff1686f2 = v6:__wf_atom_ff1686f2()
		Sleep(__wf_atom_ff1686f2)
		count += 1
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
	__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("SpawnRain"), false)
end

advancedProjectileIndex = 1

function NpcEvaluateAbility(_, object)
	local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return 1
	end

	local __wf_atom_a07433fe = __wf_atom_35a10d3c:__wf_atom_a07433fe()

	if
		__wf_atom_7e8ad928(__wf_atom_a07433fe)
		or not __wf_atom_a07433fe:IsA(__wf_atom_ed85f483)
		or __wf_atom_a07433fe:__wf_atom_69525515() == advancedProjectileIndex
	then
		return 0
	end

	return 1
end

function CorrectAttachmentAim(object, _, p)
	local __wf_atom_35a10d3c = object:__wf_atom_95e72410():__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local v6 = Vector()
	local v7 = Rotation(90, 0, 180)

	if p == 0 then
		v6 = Vector(0, 0, 0.69)
		v7 = Rotation(0, -90, 0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		__wf_atom_35a10d3c:__wf_atom_9cd0639b(1, v6, v7, false)
	end
end

local function fn2(position, object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), position)
	v6.pitch = 0
	v6.bank = 0
	return v6
end

function ActivateAbility(object, object2, entity)
	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()))
	then
		entity = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	if __wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return
	end

	local __wf_atom_a07433fe = __wf_atom_35a10d3c:__wf_atom_a07433fe()
	local bowChargedRainProjType

	if not __wf_atom_7e8ad928(__wf_atom_a07433fe) then
		bowChargedRainProjType = __wf_atom_a07433fe:__wf_atom_b6645301()
	end

	if __wf_atom_7e8ad928(bowChargedRainProjType) then
		return
	end

	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	object2:__wf_atom_0e1e5bc9()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	local mark = entity:Attach(targetFxType, EMPTY_SYMBOL)
	__wf_atom_e919fb8e.mark = mark
	object2:__wf_atom_9373d0eb(0, false)
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	secondaryScriptArgs:__wf_atom_079cbbd0(1)
	object:__wf_atom_e6831c5c(mOwner, Symbol("CorrectAttachmentAim"), secondaryScriptArgs)
	__wf_atom_35a10d3c:__wf_atom_083a9e64():__wf_atom_26a4fa9a(13)
	object2:__wf_atom_33b8b73f(startAnim, true, 2, 1, true)
	__wf_atom_35a10d3c:__wf_atom_083a9e64():__wf_atom_26a4fa9a(14)
	object2:__wf_atom_33b8b73f(loopAnim, false, 2, 2, true)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	local position = entity:GetPosition()
	local total = 0
	local flag = nil

	while total < npcChargeTimer do
		if object2:__wf_atom_c138b19b(loopAnim) then
			flag = true
		elseif flag then
			__wf_atom_35a10d3c:__wf_atom_083a9e64():__wf_atom_26a4fa9a(8)
			local secondaryScriptArgs2 = SF.SecondaryScriptArgs(true)
			secondaryScriptArgs2:__wf_atom_079cbbd0(0)
			object:__wf_atom_e6831c5c(mOwner, Symbol("CorrectAttachmentAim"), secondaryScriptArgs2)
			object2:__wf_atom_33b8b73f(nil, false, 2, 2, true)
			return
		end

		if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(entity)) then
			local targetDirection = entity:__wf_atom_a06d543c()

			if entity:__wf_atom_535d5cbb() then
				targetDirection = entity:__wf_atom_92aa9d91():GetTargetDirection()
			end

			local v6 = entity:__wf_atom_ee4f0cba() * 0.8
			position = entity:GetPosition() + targetDirection * v6
			local __wf_atom_0e1e5bc9 = object2:__wf_atom_0e1e5bc9()
			local v7 = fn2(position, object2) -- inferred equivalent call
			local v8 = __wf_atom_0e1e5bc9 - v7

			if Abs(v8.heading) > 15 then
				object2:__wf_atom_51075230(v7)
				object2:__wf_atom_84d66e8e(v7)
			end

			if not __wf_atom_7e8ad928(mark) then
				mark:SetMeshScale((__wf_atom_104bfe98(0, 2.5, total / npcChargeTimer)))
			end
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	object2:PlaySound(shootArrowSound, false, 1, false)
	object2:__wf_atom_33b8b73f(fireAnim, false, 2, 1, false)
	__wf_atom_e919fb8e.BowChargedRainPosition = position
	__wf_atom_e919fb8e.BowChargedRainWeapon = __wf_atom_35a10d3c
	__wf_atom_e919fb8e.BowChargedRainProjType = bowChargedRainProjType
	__wf_atom_e919fb8e.BowChargedRainRadius = 2.5
	object2:__wf_atom_8a035cd5(Symbol("SpawnRain"), false)
	__wf_atom_35a10d3c:__wf_atom_083a9e64():__wf_atom_26a4fa9a(8)
end

function DeactivateAbility(object, object2, _, _)
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	secondaryScriptArgs:__wf_atom_079cbbd0(0)
	object:__wf_atom_e6831c5c(mOwner, Symbol("CorrectAttachmentAim"), secondaryScriptArgs)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.mark) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_e919fb8e.mark)
	end
end