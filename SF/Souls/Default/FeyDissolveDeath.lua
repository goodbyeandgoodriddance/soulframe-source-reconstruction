local v = Symbol("POST_DEATH_ABILITY_ACTIVE")

local function fn(object, p, p2)
	local v2 = math.pow(p, 2)
	object:__wf_atom_e3c998ce(
		Symbol("GAME_C1_HIP1"),
		Rotation(),
		Vector(v2 * (2 * p2 - 1), v2 * (3 + 2 * p2), v2 * (2 * (p2 * 7.12312 % 1 - 1)))
	)
end

local function fn2(object, object2, p, total, p2, _, p3)
	local v2 = __wf_atom_24a82b69(total)

	if __wf_atom_7e8ad928(object2) then
		fn(object, v2, p3)
		object:__wf_atom_a763aa1a(v2)
	else
		object2:__wf_atom_a763aa1a(v2)
		local v3 = (p.x * 1 + Noise(Time() * 0.2) * 2) * p2
		local v4 = (4 + __wf_atom_a3cc989c((Time() + 3) * 0.2)) * p2
		local v5 = (p.z * 1 + Noise((Time() + 7) * 0.2)) * 2 * p2
		object2:__wf_atom_0f35d64f(Vector(v3, v4, v5), 1)
	end

	if __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(object:__wf_atom_f51f1faa()) then
		object:__wf_atom_f51f1faa():__wf_atom_cec01d38(0)
	end
end

function Dissolve(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(creator) then
		return
	end

	if __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) and __wf_atom_3d96ddcd:__wf_atom_52077f7a(v) then
		__wf_atom_3d96ddcd:SetBlackboardBool(v, false)
		__wf_atom_3d96ddcd:__wf_atom_ec1735df()
	end

	if creator:IsA(powerSuitType) then
		creator = creator:__wf_atom_6009c8ed()
	end

	local v2 = __wf_atom_3d96ddcd:__wf_atom_a2a18137() - creator:__wf_atom_a2a18137()
	Normalize(v2)
	__wf_atom_7abf2d2f()
	local v3 = not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:__wf_atom_464a4772())
	local v4 = math.random(1, 3)
	local __wf_atom_c6e1a103 = __wf_atom_3d96ddcd:__wf_atom_c6e1a103()
	local v5 = 0

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_c6e1a103 == 0 do
		Sleep(0)
		__wf_atom_c6e1a103 = __wf_atom_3d96ddcd:__wf_atom_c6e1a103()

		if not (v3 and floatKill) then
			continue
		end

		v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() * 0.3, 0, 1)
		local v6 = __wf_atom_24a82b69(v5)
		__wf_atom_3d96ddcd:__wf_atom_e3c998ce(Symbol("GAME_C1_HIP1"), Rotation(), Vector(0, v6 * v4, 0))
		Sleep(0)
	end

	local v6

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v6 = __wf_atom_3d96ddcd:__wf_atom_cbf8e541(0)

		if v3 then
			v6:__wf_atom_986f733d(Symbol("ChannelingKill"), 0.15)
			__wf_atom_3d96ddcd:__wf_atom_986f733d(Symbol("ChannelingKill"), 0.15)
			v6:SetDisableGravity(true)
		end
	end

	local total = 0

	while total < 1 and not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(v6)) do
		if floatKill then
			total += __wf_atom_084b3e93() * 0.3
		else
			total += __wf_atom_084b3e93() * 0.8
		end

		if v3 then
			v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() * 0.3, 0, 1)
			local v7 = __wf_atom_24a82b69(v5)
			__wf_atom_3d96ddcd:__wf_atom_e3c998ce(Symbol("GAME_C1_HIP1"), Rotation(), Vector(0, v7 * v4, 0))
		end

		__wf_atom_3d96ddcd:__wf_atom_a763aa1a(1 - __wf_atom_24a82b69(total))
		v6:__wf_atom_a763aa1a(__wf_atom_24a82b69(total))
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_c6e1a103_2 = __wf_atom_3d96ddcd:__wf_atom_c6e1a103()

		if __wf_atom_c6e1a103_2 > 0 then
			for i = 0, __wf_atom_c6e1a103_2 - 1 do
				local __wf_atom_cbf8e541 = __wf_atom_3d96ddcd:__wf_atom_cbf8e541(i)
				gRegion:__wf_atom_dd1e4d10(__wf_atom_cbf8e541)
			end
		end

		if gGameRules:IsPvpEnabled() then
			local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()
			local __wf_atom_a96eb2aa = __wf_atom_3d96ddcd:__wf_atom_a96eb2aa()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				return
			end
		end

		if __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:Destroy()
		end
	end
end

function DissolveOld(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_6009c8ed = creator:__wf_atom_6009c8ed()
	local total = 0
	local v2 = {}
	local v3 = __wf_atom_3d96ddcd:__wf_atom_a2a18137() - __wf_atom_6009c8ed:__wf_atom_a2a18137()
	Normalize(v3)
	local v4 = __wf_atom_7abf2d2f()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:__wf_atom_986f733d(Symbol("ChannelingKill"), 0.5)
		local v5 = false
		local v6 = { false, false, false }

		while total < 1 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
			local __wf_atom_c6e1a103 = __wf_atom_3d96ddcd:__wf_atom_c6e1a103()

			if __wf_atom_c6e1a103 > 0 then
				local v7 = false

				for i = 0, __wf_atom_c6e1a103 - 1 do
					local __wf_atom_cbf8e541 = __wf_atom_3d96ddcd:__wf_atom_cbf8e541(i)

					if v5 or __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
						v2[i] = 1
					else
						__wf_atom_cbf8e541:__wf_atom_cec01d38(0)
						v2[i] = __wf_atom_421b01aa(__wf_atom_cbf8e541:__wf_atom_10adff0f(), 80, 400) / 174
						v7 = i == __wf_atom_c6e1a103 - 1 or v7

						for j = 1, #effectsToRemove do
							local __wf_atom_bb3e7833 = __wf_atom_cbf8e541:__wf_atom_bb3e7833(effectsToRemove[j])

							if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
								__wf_atom_bb3e7833:Destroy()
							end
						end
					end

					fn2(__wf_atom_cbf8e541, __wf_atom_cbf8e541, v3, total, v2[i], __wf_atom_3d96ddcd, v4)

					if not (total > 0.7) or v6[i] then
						continue
					end

					Effects.__wf_atom_e0419a8d(__wf_atom_cbf8e541, __wf_atom_8939e086)
					v6[i] = true
				end

				if v7 then
					v5 = true
				end
			else
				fn2(__wf_atom_3d96ddcd, nil, v3, total, 0, __wf_atom_3d96ddcd, v4)
			end

			Sleep(0)
			total += __wf_atom_084b3e93() / math.max(0.001, timer)
		end

		local __wf_atom_c6e1a103 = __wf_atom_3d96ddcd:__wf_atom_c6e1a103()

		if __wf_atom_c6e1a103 > 0 then
			for i = 0, __wf_atom_c6e1a103 - 1 do
				__wf_atom_3d96ddcd:__wf_atom_cbf8e541(i):Destroy()
			end
		end

		if gGameRules:IsPvpEnabled() then
			local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()
			local __wf_atom_a96eb2aa = __wf_atom_3d96ddcd:__wf_atom_a96eb2aa()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				return
			end
		end

		if __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:Destroy()
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

local function fn3(position, p)
	local selected

	if not (arrowRadius > 0) then
		return { p }
	end

	selected = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, arrowRadius) or {}

	if table.find(selected, p) then
		return selected
	end

	table.insert(selected, p)
	return selected
end

local function fn4(__wf_atom_7be51ede, instance)
	return not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_4402f880(__wf_atom_7be51ede)
		and (instance:IsKilled() or instance:__wf_atom_bedb4e3f() and instance:__wf_atom_52077f7a(v))
end

function DisolveArrow(object, p)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v2 = fn3(object:GetPosition(), p)

	for _, v3 in ipairs(v2) do
		if not fn4(__wf_atom_7be51ede, v3) then
			continue
		end

		v3:Attach(ArrowTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_e55d02aa)
		v3:__wf_atom_9356c1bd(6, v3)
	end
end