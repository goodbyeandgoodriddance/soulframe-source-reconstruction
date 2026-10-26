local v = Symbol("CloakHDR")
local v2 = Symbol("CloakVector")

local function fn(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_b5e70cef)
	local result = {}

	for i = 1, #__wf_atom_f582136d do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
			table.insert(result, __wf_atom_f582136d[i])
		end
	end

	for i = 1, #__wf_atom_f582136d2 do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
			table.insert(result, __wf_atom_f582136d2[i])
		end
	end

	return result
end

local function fn2(object, data, data2, list)
	local v3 = cloakColorMult / 255
	object:SetMaterialParam(v2, data2.x, data2.y, data2.z, 1)
	object:SetMaterialParam(v, data.red * v3, data.green * v3, data.blue * v3, 1)

	for i = 1, #list do
		if __wf_atom_7e8ad928(list[i]) then
			continue
		end

		list[i]:SetMaterialParam(v, data.red * v3, data.green * v3, data.blue * v3, 1)
		list[i]:SetMaterialParam(v2, data2.x, data2.y, data2.z, 1)
	end
end

local function fn3(object, object2, _, total, _, p)
	local v3 = __wf_atom_24a82b69(total)

	if __wf_atom_7e8ad928(object2) then
		object:__wf_atom_a763aa1a(v3)
	else
		object2:__wf_atom_a763aa1a(v3)
		local v4 = Noise(Time() * 0.2) * 2 * p
		local v5 = (3 + __wf_atom_a3cc989c((Time() + 3) * 0.2)) * p
		local v6 = Noise((Time() + 7) * 0.2) * 2 * p
		object2:__wf_atom_0f35d64f(Vector(v4, v5, v6), 1)
	end

	if __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(object:__wf_atom_f51f1faa()) then
		object:__wf_atom_f51f1faa()
	end
end

local function fn4(mBoneName, object, list)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(mBoneName)
	object:SetMaterialParam(v2, __wf_atom_1c374cc9.x, __wf_atom_1c374cc9.y, __wf_atom_1c374cc9.z, 2.5)

	for i = 1, #list do
		if not __wf_atom_7e8ad928(list[i]) then
			list[i]:SetMaterialParam(v2, __wf_atom_1c374cc9.x, __wf_atom_1c374cc9.y, __wf_atom_1c374cc9.z, 2.5)
		end
	end
end

function Dissolve(instance)
	if not instance:IsA(__wf_atom_7e6ed5fa) then
		return
	end

	local dissolveInstigator = _T.DissolveInstigator
	local v3 = Color()
	v3.red = 47
	v3.green = 175
	v3.blue = 209
	v3.alpha = 255
	local v4

	if not (__wf_atom_7e8ad928(dissolveInstigator) or not dissolveInstigator:IsA(__wf_atom_7e6ed5fa)) then
		v4 = dissolveInstigator:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(v4) then
			v4:__wf_atom_8e1ec29f(v3)
		end
	end

	local total = 0
	local v5 = {}

	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_986f733d(Symbol("ChannelingKill"), 0.5)
		local __wf_atom_c6e1a103 = instance:__wf_atom_c6e1a103()

		if __wf_atom_c6e1a103 > 0 then
			for i = 0, __wf_atom_c6e1a103 - 1 do
				local __wf_atom_cbf8e541 = instance:__wf_atom_cbf8e541(i)

				if not __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
					__wf_atom_cbf8e541:Attach(fxToAttach, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v4)
				end
			end
		else
			instance:Attach(fxToAttach, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v4)
		end

		local __wf_atom_d0069154 = instance:__wf_atom_d0069154()
		local __wf_atom_9633b12e = instance:__wf_atom_7470861b():__wf_atom_9633b12e()
		local mBoneName

		if not __wf_atom_7e8ad928(__wf_atom_9633b12e) then
			mBoneName = __wf_atom_9633b12e[math.random(1, #__wf_atom_9633b12e)].mBoneName
			gRegion:CreateEntity(decoEffect, instance:__wf_atom_1c374cc9(mBoneName), __wf_atom_80368bb1, v4)
		end

		if __wf_atom_7e8ad928(mBoneName) then
			mBoneName = Symbol("GAME_C1_HIP1")
		end

		local v6 = fn(instance)
		fn2(instance, v3, __wf_atom_d0069154, v6)
		local v7 = false
		local v8 = { false, false, false }

		while total < 1 and not __wf_atom_7e8ad928(instance) do
			local __wf_atom_c6e1a103_2 = instance:__wf_atom_c6e1a103()

			if __wf_atom_c6e1a103_2 > 0 then
				local v9 = false

				for i = 0, __wf_atom_c6e1a103_2 - 1 do
					local __wf_atom_cbf8e541 = instance:__wf_atom_cbf8e541(i)

					if v7 or __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
						v5[i] = 1
					else
						v6 = fn(__wf_atom_cbf8e541)
						fn2(__wf_atom_cbf8e541, v3, __wf_atom_d0069154, v6)
						v5[i] = __wf_atom_421b01aa(__wf_atom_cbf8e541:__wf_atom_10adff0f(), 80, 400) / 174
						v9 = i == __wf_atom_c6e1a103_2 - 1 or v9

						for j = 1, #effectsToRemove do
							local __wf_atom_bb3e7833 = __wf_atom_cbf8e541:__wf_atom_bb3e7833(effectsToRemove[j])

							if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
								__wf_atom_bb3e7833:Destroy()
							end
						end
					end

					if __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
						v8[i] = true
					else
						fn3(
							__wf_atom_cbf8e541,
							__wf_atom_cbf8e541,
							v3,
							total,
							__wf_atom_d0069154,
							v5[i] * weightModifier
						)

						if not __wf_atom_7e8ad928(mBoneName) then
							fn4(mBoneName, __wf_atom_cbf8e541, v6)
						end

						if total > 0.7 and not v8[i] then
							Effects.__wf_atom_e0419a8d(__wf_atom_cbf8e541, __wf_atom_8939e086)
							v8[i] = true
						end
					end
				end

				if v9 then
					v7 = true
				end
			else
				fn3(instance, nil, v3, total, __wf_atom_d0069154, 0)

				if not __wf_atom_7e8ad928(mBoneName) then
					fn4(mBoneName, instance, v6)
				end
			end

			Sleep(0)
			total += __wf_atom_084b3e93() * speed
		end

		local __wf_atom_c6e1a103_2 = instance:__wf_atom_c6e1a103()

		if __wf_atom_c6e1a103_2 > 0 then
			for i = 0, __wf_atom_c6e1a103_2 - 1 do
				instance:__wf_atom_cbf8e541(i):Destroy()
			end
		end

		if gGameRules:IsPvpEnabled() then
			local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()
			local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				return
			end
		end

		if instance:IsA(__wf_atom_7e6ed5fa) then
			return
		end

		if not __wf_atom_7e8ad928(instance) then
			instance:Destroy()
		end
	end
end

function NotifyChannelingKill(object, instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	for i = 1, #excludedAvatarTypes do
		if instance:__wf_atom_464a4772() or instance:IsA(excludedAvatarTypes[i]) then
			return
		end
	end

	_T.DissolveInstigator = object:__wf_atom_6009c8ed()
	instance:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
end

function NotifyOnDamageDone(object, _, instance)
	Sleep(0)

	if not __wf_atom_7e8ad928(instance) and instance:IsKilled() then
		for i = 1, #excludedAvatarTypes do
			if instance:__wf_atom_464a4772() or instance:IsA(excludedAvatarTypes[i]) then
				return
			end
		end

		_T.DissolveInstigator = object:__wf_atom_6009c8ed()
		instance:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
	end
end

function NotifyOnProjectileKill(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()

	if __wf_atom_7e8ad928(__wf_atom_9f2332e5) then
		return
	end

	local __wf_atom_81548e8e = object:__wf_atom_81548e8e()

	if not __wf_atom_81548e8e:IsA(__wf_atom_7e6ed5fa) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_81548e8e) and __wf_atom_81548e8e:IsKilled() then
		for i = 1, #excludedAvatarTypes do
			if __wf_atom_81548e8e:__wf_atom_464a4772() or __wf_atom_81548e8e:IsA(excludedAvatarTypes[i]) then
				return
			end
		end

		_T.DissolveInstigator = __wf_atom_9f2332e5:__wf_atom_6009c8ed()
		__wf_atom_81548e8e:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
	end
end

function TestMyDissolve(object)
	Sleep(1)
	local v3 = Vector(0.2, 1.2, 0.15)
	object:SetMaterialParam(Symbol("CloakVector"), v3.x, v3.y, v3.z, 1)
	local total = 0

	while true do
		object:__wf_atom_a763aa1a(total)
		Sleep(0)
		total += __wf_atom_084b3e93() / 2

		if not (total > 1) then
			continue
		end

		local v4 = Color(math.random(0, 255), math.random(0, 255), math.random(0, 255), 255)
		object:SetMaterialParam(v, v4.red / 25, v4.green / 25, v4.blue / 25, 1)
		local v5 = Vector((math.random() - 0.5) * 0.5, math.random() * 2, (math.random() - 0.5) * 0.5)
		object:SetMaterialParam(Symbol("CloakVector"), v5.x, v5.y, v5.z, 1)
		total = 0
	end
end

function InfestedRagdollDissolve(object)
	Sleep(3)

	if object:__wf_atom_f83a55c6() > 0.01 then
		return
	end

	local total = 0

	while total < 1 and not __wf_atom_7e8ad928(object) do
		object:__wf_atom_a763aa1a(total)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end