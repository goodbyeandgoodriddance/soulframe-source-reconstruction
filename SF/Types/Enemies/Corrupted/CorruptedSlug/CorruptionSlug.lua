local v = {
	Symbol("SPIKE1"),
	Symbol("SPIKE2"),
	Symbol("SPIKE3"),
	Symbol("SPIKE4"),
	Symbol("SPIKE5"),
	Symbol("SPIKE6"),
	Symbol("SPIKE7"),
	Symbol("SPIKE8"),
	Symbol("SPIKE9")
}
local v2 = {
	1.15,
	1,
	1.1,
	0.95,
	0.85,
	0.9,
	0.95,
	0.9,
	0.8
}

function SlugUpdate(object)
	object:Attach(carapaceType, Symbol("CARAPACE"))
	local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local ___wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
	local ___wf_atom_80368bb1 = __wf_atom_80368bb1
	local ___wf_atom_80368bb1_2 = __wf_atom_80368bb1
	local ___wf_atom_28d5d4aa3 = __wf_atom_28d5d4aa
	local ___wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
	local ___wf_atom_28d5d4aa5 = __wf_atom_28d5d4aa
	local ___wf_atom_28d5d4aa6 = __wf_atom_28d5d4aa
	local flag = false
	local v3 = 0
	local v4 = false
	local v5 = {}
	local v6 = {}
	local v7 = 6
	local v8 = 1
	local v9 = 0

	while true do
		local position = object:GetPosition()
		local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(position, 25)

		if __wf_atom_7e8ad928(__wf_atom_06db1fb1) then
			if not flag then
				object:__wf_atom_921c1a5f(hideAnim, true, false, 0, EMPTY_SYMBOL)
				object:__wf_atom_921c1a5f(hiddenAnim, false, true, 0, EMPTY_SYMBOL)
				flag = true
			end

			Sleep(1)
		else
			local v10 = __wf_atom_06db1fb1:GetPosition() - position
			local v11 = Vector(v10.x, 0, v10.z)
			Normalize(v11)
			local __wf_atom_a06d543c = __wf_atom_06db1fb1:__wf_atom_a06d543c()
			local v12 = Dot(v10, __wf_atom_a06d543c) < -0.25
			Dot(v11, object:__wf_atom_a06d543c())

			if flag then
				object:MakeInvulnerable()
			else
				object:MakeVulnerable()
			end

			if v3 == 1 and v4 then
				object:__wf_atom_921c1a5f(idleAnim, false, true, 0, EMPTY_SYMBOL)
				v4 = false
				v5 = {}
			elseif v4 or v3 == 1 then
				v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / 2, 0, 1)

				for _, v13 in ipairs(v5) do
					if __wf_atom_7e8ad928(v13) then
						continue
					end

					v13:__wf_atom_8f04e01e(v3)
					local v14 = __wf_atom_06db1fb1:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3")) - object:__wf_atom_1c374cc9(v13:__wf_atom_f5bac0e4()) + Vector(0, 0.3, 0)
					__wf_atom_fa8d0177(__wf_atom_28d5d4aa, v14)
				end
			else
				object:__wf_atom_921c1a5f(chargeAnim, false, false, 0, EMPTY_SYMBOL, 1)
				v5 = reloadSpikes(object)
				v4 = true
				flag = false

				for _, v13 in ipairs(v5) do
					table.insert(v6, v13)
				end
			end

			v7 = __wf_atom_421b01aa(v7 - __wf_atom_084b3e93(), 0, 6)

			if Length(v10) <= 5 and not v4 and v7 == 0 then
				object:__wf_atom_921c1a5f(fireAnim, false, false, 0, EMPTY_SYMBOL)

				for _, v13 in ipairs(v6) do
					if __wf_atom_7e8ad928(v13) then
						continue
					end

					gRegion:__wf_atom_8d991675(v13:GetPosition(), 0.25, Color(0, 255, 255), 5)
					local v14 = __wf_atom_06db1fb1:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5")) - v13:GetPosition()
					Normalize(v14)

					if not (Dot(v13:__wf_atom_a06d543c(), v14) > 0.35) then
						continue
					end

					local v15 = __wf_atom_06db1fb1:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3")) - object:__wf_atom_1c374cc9(v13:__wf_atom_f5bac0e4()) + Vector(0, 0.3, 0)
					local v16 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v15)
					local position2 = v13:GetPosition()
					gRegion:CreateEntity(spikeProjType, position2, v16):SetMeshScale(v13:__wf_atom_c082fc3d(), true)
					v13:Destroy()
					Sleep(math.random(1, 2) * 0.05)
				end

				v4 = false
				v3 = 0
				v7 = 6
			end

			if not v4 then
				if Length(v10) < 18 then
					if v12 then
						v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93() / 0.5, 0, 1)

						if v8 == 1 and not flag then
							object:__wf_atom_921c1a5f(hideAnim, true, false, 0, EMPTY_SYMBOL)
							object:__wf_atom_921c1a5f(hiddenAnim, false, true, 0, EMPTY_SYMBOL)
							flag = true
							v9 = 0
						end
					else
						v8 = __wf_atom_421b01aa(v8 - __wf_atom_084b3e93() / 0.5, 0, 1)

						if v8 == 0 and flag then
							object:__wf_atom_921c1a5f(unhideAnim, true, false, 0, EMPTY_SYMBOL)
							object:__wf_atom_921c1a5f(idleAnim, false, true, 0, EMPTY_SYMBOL)
							flag = false
						end
					end
				elseif flag then
					v8 = __wf_atom_421b01aa(v8 - __wf_atom_084b3e93() / 0.5, 0, 1)

					if v8 == 0 and flag then
						object:__wf_atom_921c1a5f(unhideAnim, true, false, 0, EMPTY_SYMBOL)
						object:__wf_atom_921c1a5f(idleAnim, false, true, 0, EMPTY_SYMBOL)
						flag = false
					end
				end
			end

			if flag or v4 then
				v9 = __wf_atom_421b01aa(v9 - __wf_atom_084b3e93() / 0.5, 1, 5)
			else
				v9 = __wf_atom_421b01aa(v9 + __wf_atom_084b3e93() / 4, 1, 5)
			end

			local v13 = v11 + math.sin(6.283185307179586 * Time() * 0.2) * __wf_atom_edfe0d73(
				Vector(0, 1, 0),
				object:__wf_atom_a06d543c()
			) * math.sin(6.283185307179586 * Time() * 0.1543) * 0.1 * v9

			if Length(v10) > 2 then
				local v14 = math.abs((math.sin(6.283185307179586 * Time() * 0.1 * v9))) * 0.75 + 0.25
				object:SetPosition(position + v13 * v9 * __wf_atom_084b3e93() * v14)
			end

			local v14 = Length(v10) < 5 and 3 or 15
			object:__wf_atom_9b788a35((__wf_atom_9d2f097a(
				object:__wf_atom_dc309f8a(),
				__wf_atom_fa8d0177(__wf_atom_28d5d4aa, v13),
				__wf_atom_084b3e93() * v14
			)))
			Sleep(0)
		end
	end
end

function reloadSpikes(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(spikeType)
	local v3 = {}
	local result = {}

	for _, v4 in ipairs(__wf_atom_f582136d) do
		table.insert(v3, v4:__wf_atom_f5bac0e4())
	end

	for i, v4 in ipairs(v) do
		if not __wf_atom_7e8ad928(table.find(v3, v4)) then
			continue
		end

		local v5 = object:Attach(spikeType, v4)
		v5:SetMeshScale(v2[i])
		table.insert(result, v5)
	end

	return result
end

function TargetLooking(object)
	local __wf_atom_216d6edd = object:__wf_atom_216d6edd()

	if __wf_atom_7e8ad928(__wf_atom_216d6edd) then
		return false
	end

	local v3 = __wf_atom_216d6edd:GetPosition() - object:__wf_atom_50a7d83e():GetPosition()
	local __wf_atom_a06d543c = __wf_atom_216d6edd:__wf_atom_a06d543c()
	return Dot(v3, __wf_atom_a06d543c) < -0.25
end

function ChargeSpikesEvaluate(object)
	return not __wf_atom_7e8ad928(object) and object:__wf_atom_09c6191a(Symbol("Charged")) == 0
end

function ChargeSpikes(object)
	if __wf_atom_7e8ad928(object:__wf_atom_e919fb8e().spikes) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.spikes = {}
	end

	local spikes = object:__wf_atom_e919fb8e().spikes
	local v3 = 0
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

	if __wf_atom_7e8ad928(__wf_atom_216d6edd) then
		return false
	end

	object:__wf_atom_921c1a5f(chargeAnim, false, 2, 1, false, 1)
	local v4 = reloadSpikes(object)

	for _, v5 in ipairs(v4) do
		table.insert(spikes, v5)
	end

	while v3 ~= 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / 2, 0, 1)

		for _, v5 in ipairs(v4) do
			if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(__wf_atom_216d6edd) or __wf_atom_7e8ad928(object) then
				continue
			end

			v5:__wf_atom_8f04e01e(v3)
			local v6 = __wf_atom_216d6edd:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3")) - object:__wf_atom_1c374cc9(v5:__wf_atom_f5bac0e4()) + Vector(0, 0.3, 0)
			__wf_atom_fa8d0177(__wf_atom_28d5d4aa, v6)
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_5a0e15fd(Symbol("Charged"), 1)
	end

	return true
end

function CanFireSpikes(object)
	return not __wf_atom_7e8ad928(object) and object:__wf_atom_09c6191a(Symbol("Charged")) == 1
end

function FireSpikes(object)
	local spikes = object:__wf_atom_e919fb8e().spikes or {}
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

	if __wf_atom_7e8ad928(__wf_atom_216d6edd) then
		return false
	end

	object:__wf_atom_8914dfde("FireProjectiles", object:__wf_atom_921c1a5f(fireAnim, false, 2, 1, false))

	for _, spike in ipairs(spikes) do
		if __wf_atom_7e8ad928(spike) or __wf_atom_7e8ad928(__wf_atom_216d6edd) then
			continue
		end

		local v3 = __wf_atom_216d6edd:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5")) - spike:GetPosition()
		Normalize(v3)

		if not (Dot(spike:__wf_atom_a06d543c(), v3) > 0.35) then
			continue
		end

		local v4 = __wf_atom_216d6edd:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3")) - object:__wf_atom_1c374cc9(spike:__wf_atom_f5bac0e4()) + Vector(0, 0.3, 0)
		local v5 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v4)
		local position = spike:GetPosition()
		local entity = gRegion:CreateEntity(spikeProjType, position, v5)
		entity:__wf_atom_8fcdea81(object)
		entity:SetMeshScale(spike:__wf_atom_c082fc3d(), true)
		spike:Destroy()
		Sleep(math.random(1, 2) * 0.05)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_5a0e15fd(Symbol("Charged"), 0)
	end

	return true
end

function ToggleInmunity(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_21ed1a39():__wf_atom_15197633():__wf_atom_d2b2176d()

	if p == 0 then
		object:__wf_atom_21ed1a39():__wf_atom_886269c8(true)
		__wf_atom_d2b2176d:__wf_atom_066a9716(Symbol("Hidden"), 46, 3, -0.9)
	else
		object:__wf_atom_21ed1a39():__wf_atom_886269c8(false)
		__wf_atom_d2b2176d:__wf_atom_56004282(Symbol("Hidden"), 46, 3, -0.9)
	end
end

function OnDeath(object)
	if gRegion:IsMaster() then
		local spikes = object:__wf_atom_e919fb8e().spikes or {}

		for _, spike in ipairs(spikes) do
			if __wf_atom_7e8ad928(spike) then
				continue
			end

			gRegion:CreateEntity(spikeDestroyFX, spike:GetPosition(), spike:__wf_atom_dc309f8a())
			spike:Destroy()
		end
	end
end