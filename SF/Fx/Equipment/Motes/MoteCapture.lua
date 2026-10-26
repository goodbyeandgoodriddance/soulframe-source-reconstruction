local maxStages = 5
local v = 2
local moveAwayDistance = 40
local moveSpeed = 6
local infiniteFleeDistance = false
local stageFxType = Type()
local finalFxType = Type()
local v2 = Vector(0, 0, 0)

function MoteAvatarSetup(object)
	if gRegion:IsMaster() then
		local __wf_atom_e0933a42 = object:__wf_atom_e0933a42()

		if __wf_atom_7e8ad928(__wf_atom_e0933a42) then
			__wf_atom_e0933a42 = object
		end

		object:Attach(
			pickUpAttachmentOnAvatar,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_e0933a42,
			1
		)
		object:SetVisibility(false, false)

		if __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) and not __wf_atom_7e8ad928(moteAgentType) then
			object:__wf_atom_67e66702(moteAgentType, EMPTY_SYMBOL, Symbol("Neutral"), false)
		end
	end
end

local function fn(position, p)
	local __wf_atom_28ce676a = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(math.max(0, moveAwayDistance - 10), moveAwayDistance), 5)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_ce415137(1)
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_9b7f7161(
		position,
		__wf_atom_9341614d(p, Rotation(math.random(-45, 45), 0, 0)),
		1,
		1,
		0,
		0,
		false
	)
	return __wf_atom_28ce676a
end

function MoteMovementUpdate(object, value, data)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_f7e7be53 ~= object then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		__wf_atom_f7e7be53 = object
	end

	local position = __wf_atom_f7e7be53:GetPosition()
	gRegion:__wf_atom_06db1fb1(__wf_atom_f7e7be53:GetPosition(), 15)
	local count = 0
	local flag = true
	local v3 = false
	local __wf_atom_28d5d4aa2 = Vector(0, 0, 0)
	local v4 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_3ae8d73b
	}
	local v5 = 0
	Vector(0, 0, 0)
	local v6 = Vector(0, 0, 0)
	local v7 = 0
	Vector(0, 0, 0)
	local v8 = 0
	local v9 = nil
	local v10 = nil
	local v11 = 1
	local v12 = 1

	if data ~= nil then
		if data.moveAwayDistance ~= nil then
			moveAwayDistance = data.moveAwayDistance
		end

		if data.maxStages ~= nil then
			maxStages = data.maxStages
		end

		if data.stageFxType ~= nil then
			stageFxType = data.stageFxType
		end

		if data.finalFxType ~= nil then
			finalFxType = data.finalFxType
		end

		if data.moveSpeed ~= nil then
			moveSpeed = data.moveSpeed
		end

		if data.infiniteFleeDistance ~= nil then
			infiniteFleeDistance = data.infiniteFleeDistance
		end
	end

	local v13 = Vector(0, value or 1.5, 0)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while not v3 do
		position = __wf_atom_f7e7be53:GetPosition()

		if not flag then
			v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93(), 0, v5)
			v12 -= __wf_atom_084b3e93() / 1 * 0.7
			local __wf_atom_dc309f8a = __wf_atom_f7e7be53:__wf_atom_dc309f8a()
			__wf_atom_dc309f8a.heading += math.sin(Time() * 3.141592653589793 * 2.1 * 0.2 + Time() * 4 * 0.2) * 1
			__wf_atom_f7e7be53:__wf_atom_9b788a35(__wf_atom_dc309f8a)

			if v9 ~= nil and v9:__wf_atom_2ddd6354() then
				v11 = 1
				local __wf_atom_5802ff81 = v9:__wf_atom_5802ff81()

				if #__wf_atom_5802ff81 > 0 then
					local v14 = __wf_atom_5802ff81[__wf_atom_5784a397(1, #__wf_atom_5802ff81)]
					v10 = gRegion:__wf_atom_2202ffb6():__wf_atom_73927e88(position, v14)

					if #v10 == 0 then
						v10 = nil
					end
				else
					__wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
					v10 = nil
					v11 = 1
					flag = true
				end

				v9 = nil
			end

			if v10 ~= nil and #v10 > 0 then
				if
					__wf_atom_f7e7be53:__wf_atom_c215662d(v10[v11]) < 0.3
					or __wf_atom_a93b9922(position - v13, v10[v11]) < 0.3
				then
					v11 += 1

					if #v10 < v11 then
						__wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
						v10 = nil
						v11 = 1
						flag = true
					end
				elseif
					v11 < #v10
					and (v10[v11].y < position.y or v10[v11].y < v10[v11 + 1].y)
					and not gRegion:__wf_atom_c20d246a(position, v10[v11 + 1], v4, nil, v6)
				then
					v11 += 1
				end

				if v10 ~= nil and v11 <= #v10 then
					local v14 = v10[v11] + v13 - position
					Normalize(v14)
					__wf_atom_28d5d4aa2 = v14 * math.max(moveSpeed * 0.3, moveSpeed * v12)
				end
			end

			if v8 == v5 then
				v8 = 0
				v5 = 0.05
				local v14 = Vector(0, 0, 0)
				v7 = not gRegion:__wf_atom_c20d246a(position, position - Vector(0, 1, 0), v4, nil, v14) and 0
					or 1 + (v14.y - position.y)
				gRegion:__wf_atom_628723a6(position, position - Vector(0, 1, 0), Color(255, 0, 0), v5)
				gRegion:__wf_atom_628723a6(v14, v14 + Vector(0, v7, 0), Color(0, 255, 0), v5)
				gRegion:__wf_atom_628723a6(position, position + __wf_atom_28d5d4aa2 * 1, Color(0, 0, 255), v5)
				Vector(0, 0, 0)
				v6 = Vector(0, 0, 0)

				if gRegion:__wf_atom_c20d246a(
					position,
					position + __wf_atom_f7e7be53:__wf_atom_a06d543c() * 1,
					v4,
					nil,
					v6
				) then
					local v15 = position - v6
					v15 = v15 * 1 - math.abs((Length(v15)))
				end
			end

			if v7 == 0 then
				position.y -= 1.2 * __wf_atom_084b3e93()
			else
				position.y += v7 * __wf_atom_084b3e93() * 2.4
			end

			if
				v10 == nil
				or not (#v10 > 0 and v11 <= #v10 and math.pow(moveSpeed * __wf_atom_084b3e93(), 2) > __wf_atom_a93b9922(v10[v11], position))
			then
				position += __wf_atom_28d5d4aa2 * __wf_atom_084b3e93()
			else
				position = __wf_atom_bdb9797f(position, position + __wf_atom_28d5d4aa2 * __wf_atom_084b3e93(), v10[v11])
			end

			__wf_atom_f7e7be53:SetPosition(position)
		end

		if flag then
			v12 = 1

			if count == maxStages - 1 then
				v = 1.5
			end

			local v14

			if infiniteFleeDistance then
				v14 = gRegion:__wf_atom_06db1fb1(position)
			else
				v14 = gRegion:__wf_atom_06db1fb1(position, v)
			end

			if not __wf_atom_7e8ad928(v14) then
				if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
					__wf_atom_3d96ddcd:Destroy()
					Sleep(0.5)
				end

				count += 1

				if count < maxStages then
					gRegion:CreateEntity(stageFxType, position, __wf_atom_80368bb1)
					local v15 = position - v14:GetPosition()
					v15.y = 0
					Normalize(v15)
					v9 = fn(position, v15)
					v9:__wf_atom_a49949e0(Symbol("MoteCapture"), Color(255, 0, 0))
					v9:Start()
					flag = false
				end
			end
		end

		v3 = count == maxStages or v3
		Sleep(0)
	end

	if v3 then
		gRegion:CreateEntity(finalFxType, position, __wf_atom_80368bb1)
	end
end

function CaptureCleanup(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		__wf_atom_f7e7be53 = object
	end

	local __wf_atom_e919fb8e = __wf_atom_f7e7be53:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.shouldFire = false
end

function FreezeUpdate(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		__wf_atom_f7e7be53 = object
	end

	Vector(0, 0, 0)
	local __wf_atom_e919fb8e = __wf_atom_f7e7be53:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.moteFrozenAvatars = {}
	local v3 = {}

	while true do
		local position = __wf_atom_f7e7be53:GetPosition()

		for _, v4 in ipairs(v3) do
			if not table.find(__wf_atom_e919fb8e.moteFrozenAvatars, v4) then
				table.insert(__wf_atom_e919fb8e.moteFrozenAvatars, v4)
			end
		end

		for _, moteFrozenAvatar in ipairs(__wf_atom_e919fb8e.moteFrozenAvatars) do
			if __wf_atom_7e8ad928(moteFrozenAvatar) then
				continue
			end

			local v4 = __wf_atom_421b01aa(math.abs((Length(moteFrozenAvatar:GetPosition() - position))) / 25, 0, 1)
			local v5 = __wf_atom_421b01aa(1 - math.pow(1 - v4, 2), 0.1, 1)
			local __wf_atom_5439d809 = moteFrozenAvatar:__wf_atom_5439d809()
			local v6

			if moteFrozenAvatar:__wf_atom_aea547fa() then
				v6 = __wf_atom_421b01aa(__wf_atom_5439d809 - __wf_atom_084b3e93() * 5, v5, 1)
			else
				v6 = __wf_atom_421b01aa(__wf_atom_5439d809 + __wf_atom_084b3e93() * 2, v5, 1)
			end

			if __wf_atom_7e8ad928((moteFrozenAvatar:__wf_atom_bb3e7833(iceAttachFxType))) then
				moteFrozenAvatar:Attach(iceAttachFxType, EMPTY_SYMBOL)
			end

			local __wf_atom_bb3e7833 = moteFrozenAvatar:__wf_atom_bb3e7833(iceProjType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_a763aa1a(v6)
			end

			moteFrozenAvatar:__wf_atom_986f733d(Symbol("Freeze"), v6)
		end

		Sleep(0)
	end
end

function FreezeCleanup(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		__wf_atom_f7e7be53 = object
	end

	local __wf_atom_e919fb8e = __wf_atom_f7e7be53:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.moteFrozenAvatars then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(freezeEntityType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		for _, moteFrozenAvatar in ipairs(__wf_atom_e919fb8e.moteFrozenAvatars) do
			if not __wf_atom_7e8ad928(moteFrozenAvatar) then
				moteFrozenAvatar:__wf_atom_8a035cd5(Symbol("FreezeEnd"), false)
			end
		end

		__wf_atom_e919fb8e.moteFrozenAvatars = nil
	end
end

function FreezeEnd(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(iceAttachFxType)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(iceProjType)
	local __wf_atom_5439d809 = object:__wf_atom_5439d809()

	while __wf_atom_5439d809 < 1 and not __wf_atom_7e8ad928(object) do
		__wf_atom_5439d809 = __wf_atom_421b01aa(__wf_atom_5439d809 + __wf_atom_084b3e93(), 0, 1)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:__wf_atom_a763aa1a(__wf_atom_5439d809)
		end

		object:__wf_atom_986f733d(Symbol("Freeze"), __wf_atom_5439d809)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:Destroy()
	end
end

function MovementSpawner(object)
	__wf_atom_7e8ad928(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.shouldFire = true
	Vector(0, 0, 0)
	local v3 = Vector(0, 0, 0)
	local v4 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_3ae8d73b
	}
	Vector(0, 0, 0)
	local fireInitialDelay = fireInitialDelay

	while fireInitialDelay > 0 do
		fireInitialDelay -= __wf_atom_084b3e93()
		Sleep(0)
	end

	while true do
		if __wf_atom_e919fb8e.shouldFire then
			local position = object:GetPosition()

			if fireInterval - math.abs((Length(position - v3))) <= 0 then
				local v5 = Vector(
					math.random(-v2.x * 100, v2.x * 100) * 0.01,
					math.random(-v2.y * 100, v2.y * 100) * 0.01,
					math.random(-v2.z * 100, v2.z * 100) * 0.01
				)
				v3 = object:GetPosition() + v5

				if projectToGround then
					gRegion:__wf_atom_c20d246a(v3, v3 - Vector(0, 4, 0), v4, nil, v3)
				end

				gRegion:CreateEntity(
					spawnType,
					v3,
					Rotation(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
				)
			end
		end

		Sleep(0)
	end
end

function MagnetUpdate(object)
	local __wf_atom_be152500s = {}

	while true do
		local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(object:GetPosition(), 20, __wf_atom_4ebf67cb)

		for _, v3 in ipairs(__wf_atom_a56d7910) do
			local __wf_atom_be152500 = v3:__wf_atom_d2b2176d():__wf_atom_be152500(0)

			if __wf_atom_7e8ad928(__wf_atom_be152500) or table.find(__wf_atom_be152500s, __wf_atom_be152500) then
				continue
			end

			table.insert(__wf_atom_be152500s, __wf_atom_be152500)
			local __wf_atom_b6b760b5 = __wf_atom_be152500:__wf_atom_66088189(1, 0):__wf_atom_b6b760b5()
			local v4 = Vector(
				math.random(-100, 100) * 0.01,
				math.random(-100, 100) * 0.01,
				math.random(-100, 100) * 0.01
			)
			Normalize(v4)
			local v5 = v4 * 2
			local v6 = Rotation(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
			local v7 = object:Attach(weaponOrbitType, EMPTY_SYMBOL, v5, v6)

			if not __wf_atom_7e8ad928(v7) then
				v7:__wf_atom_45cf0e1a(__wf_atom_b6b760b5, true, true)
			end
		end

		for _, v3 in ipairs(__wf_atom_be152500s) do
			print(v3:GetName())
		end

		Sleep(1)
	end
end