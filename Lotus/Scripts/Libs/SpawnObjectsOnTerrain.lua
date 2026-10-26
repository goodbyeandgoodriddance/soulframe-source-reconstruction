module(..., package.seeall)
local v = WeakResource("/EE/Types/Engine/Terrain")
local v2 = WeakResource("/EE/Types/Effects/Landscape")
local v3 = Vector(0, 10, 0)
local v4 = Vector(0, -300, 0)
local v5 = Color(192, 192, 192)
local v6 = Color(0, 160, 64)
local v7 = nil
local v8 = __wf_atom_4240d7fd()

local function fn(p, p2, p3, p4)
	if v7 then
		if __wf_atom_7e8ad928(p4) then
			p4 = Color(255, 255, 255)
		end

		gRegion:__wf_atom_628723a6(p, p2, p4, 30)

		if not __wf_atom_7e8ad928(p3) then
			gRegion:__wf_atom_5b35a0c8(p2, p4, p3, 1, 20)
		end
	end
end

local function fn2(p, p2)
	local v9 = math.rad(p2)
	local v10 = Vector(0, 0, 1)
	local v11 = Vector(0, 1, 0)
	return math.cos(v9) <= Dot(__wf_atom_9341614d(v10, p), v11)
end

local function fn3(p, p2)
	local v9 = Vector(0, 0, 1)
	local v10 = Vector(0, 1, 0)
	return math.abs(Dot(__wf_atom_9341614d(v9, p), v10) - Dot(__wf_atom_9341614d(v9, p2), v10)) <= 0.984807753012208
end

local function fn4(instance, list)
	if instance:IsA(v) or instance:IsA(v2) then
		return true
	end

	if not __wf_atom_7e8ad928(list) then
		for _, className in ipairs(list) do
			if not __wf_atom_7e8ad928(className) and instance:IsA(className) then
				return true
			end
		end
	end

	return false
end

function FindValidSpawnPos(p, p2, p3, p4, list, p5, p6, p7, p8, p9)
	local v9 = __wf_atom_7e8ad928(p6) and 25 or p6
	local v10 = __wf_atom_7e8ad928(p9) and 1.5 or p9
	local v11 = Vector()
	local v12 = Rotation()
	local v13 = p + v4
	v8:Set(nil)
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(p, v13, p4, nil, v8, v11, v12, true)
	local v14 = v8:Get()
	local v15 = p2 * 2 + p7

	if not __wf_atom_7e8ad928(list) then
		if __wf_atom_7e8ad928(p5) then
			for _, v16 in pairs(list) do
				if not __wf_atom_7e8ad928(v16) and Distance(v16, v11) < v15 then
					return
				end
			end
		else
			for i = 1, #list do
				if __wf_atom_7e8ad928(list[i].points) then
					continue
				end

				local v16

				if i == p5 then
					v16 = p2 * 2 + p7
				else
					v16 = p2 * 2
				end

				for _, point in pairs(list[i].points) do
					if not __wf_atom_7e8ad928(point) and Distance(point, v11) < v16 then
						return
					end
				end
			end
		end
	end

	local v16 = p + Vector(0, 0.5, 0)
	local v17 = Color(255, 255, 255)

	if v7 then
		gRegion:__wf_atom_5b35a0c8(v16, v17, "SpawnObjectsOnTerrain.lua", 1, 20)
	end

	fn(p, v13, nil, v5)

	if not __wf_atom_267afa54 or __wf_atom_7e8ad928(v14) then
		fn(p, v13, nil, Color(255, 0, 0))
		return
	end

	local __wf_atom_1bb5b1ff = v14:__wf_atom_1bb5b1ff()

	if p3 and not fn4(__wf_atom_1bb5b1ff, p8) then
		fn(p, v13, nil, Color(255, 0, 0))
		local v18 = v11 + Vector(0, 1, 0)
		local v19 = Color(255, 0, 0)

		if v7 then
			gRegion:__wf_atom_5b35a0c8(v18, v19, "[Valid surface]", 1, 20)
		end
	else
		local v18 = v11 + Vector(0, 1, 0)
		local v19 = v5

		if v7 then
			gRegion:__wf_atom_b5c21154(v18, p2, v19, v12, 20)
		end

		if fn2(v12, v9) then
			local v20 = v11 + Vector(0, 1, 0)
			local v21 = v6

			if v7 then
				gRegion:__wf_atom_b5c21154(v20, p2, v21, v12, 20)
			end

			if not __wf_atom_7e8ad928(p2) and p2 >= 0.5 then
				local v22 = {
					Vector(p2, 0, 0),
					Vector(-p2, 0, 0),
					Vector(0, 0, p2),
					Vector(0, 0, -p2)
				}

				for i = 1, #v22 do
					local v23 = v11 + v22[i]
					local v24 = Vector()
					local v25 = Rotation()
					v8:Set(nil)
					local __wf_atom_267afa54_2 = gRegion:__wf_atom_267afa54(
						v23 + v3,
						v23 + v4,
						p4,
						nil,
						v8,
						v24,
						v25,
						true
					)
					local v26 = v8:Get()

					if
						__wf_atom_267afa54_2
						and (not p3 or fn4(v26, p8))
						and not (v10 < math.abs(v11.y - v24.y))
						and fn3(v12, v25)
					then
						fn(v24, v24 + Vector(0, 3, 0), nil, v6)
						fn(p, v24 + Vector(0, 3, 0), nil, v6)
					else
						fn(v24, v24 + Vector(0, 3, 0), nil, v5)
						fn(p, v24 + Vector(0, 3, 0), nil, v5)
						local v27 = v11 + Vector(0, 1, 0)
						local v28 = Color(255, 0, 0)

						if v7 then
							gRegion:__wf_atom_5b35a0c8(v27, v28, "[Edge check]", 1, 20)
						end

						return
					end
				end
			end

			local v22 = math.random(0, 360)
			local v23 = __wf_atom_d919c2d7(v12, Rotation(0, 0, v22))
			local v24 = __wf_atom_d919c2d7(v23, Rotation(0, 90, 0))
			fn(p, v13, nil, Color(0, 255, 0))
			return v11, v24
		else
			local v20 = v11 + Vector(0, 1, 0)
			local v21 = Color(255, 0, 0)

			if v7 then
				gRegion:__wf_atom_5b35a0c8(v20, v21, "[Angle limit]", 1, 20)
			end
		end
	end
end

local function fn5(position, p) -- 1 equivalent call inferred from this helper
	return __wf_atom_a93b9922(Vector(position.x, 0, position.z), Vector(p.x, 0, p.z))
end

function FindValidFishingHotspotSpawnPos(p, p2, list, p3)
	local v9 = Vector()
	local v10 = Rotation()
	local v11 = p + v4
	v8:Set(nil)
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(p, v11, nil, nil, v8, v9, v10, true)
	local v12 = v8:Get()

	if not __wf_atom_7e8ad928(list) and not __wf_atom_7e8ad928(p3) and p3 <= #list then
		for _, resource in pairs(list[p3].resources) do
			if __wf_atom_7e8ad928(resource) then
				continue
			end

			local v13 = resource:__wf_atom_4e28532a() + p2

			if fn5(resource:GetPosition(), v9) < v13 * v13 then -- inferred equivalent call
				return
			end
		end
	end

	local v13 = p + Vector(0, 0.5, 0)
	local v14 = Color(255, 255, 255)

	if v7 then
		gRegion:__wf_atom_5b35a0c8(v13, v14, "SpawnObjectsOnTerrain.lua", 1, 20)
	end

	fn(p, v11, nil, v5)

	if not __wf_atom_267afa54 or __wf_atom_7e8ad928(v12) then
		fn(p, v11, nil, Color(255, 0, 0))
		return
	end

	local v15 = math.random(0, 360)
	local v16 = __wf_atom_d919c2d7(v10, Rotation(0, 0, v15))
	local v17 = __wf_atom_d919c2d7(v16, Rotation(0, 90, 0))
	fn(p, v11, nil, Color(0, 255, 0))
	return v9, v17
end

function SpawnRandomObjectsInArea(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	v7 = __wf_atom_72884638("LotusGameRules.MissionDebug")

	if p3 <= 0 then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v9 = __wf_atom_7e8ad928(p8) and 0 or p8
	local v10 = __wf_atom_7e8ad928(p10) and 0 or p10
	local v11 = math.min(p3 * 5, 150)
	local count = 0
	local count2 = 0
	local result = {}
	local entities = {}

	while count < p3 and count2 < v11 do
		local __wf_atom_a70d9d07 = __wf_atom_7d789620:__wf_atom_a70d9d07(p4, p5, false, v10)
		local v12, v13 = FindValidSpawnPos(__wf_atom_a70d9d07, p2, p6, nil, result, nil, p7, v9, p9)

		if not __wf_atom_7e8ad928(v12) then
			local entity = gRegion:CreateEntity(p, v12 + Vector(0, v10, 0), v13)

			if not __wf_atom_7e8ad928(entity) then
				count += 1
				table.insert(result, __wf_atom_a70d9d07)
				table.insert(entities, entity)
			end
		end

		count2 += 1
		Sleep(0)
	end

	return entities, result
end

function GetValidSpawnPosInArea(p, p2, p3, p4, p5, p6, p7, p8)
	v7 = __wf_atom_72884638("LotusGameRules.MissionDebug")
	local v9 = __wf_atom_7e8ad928(p6) and 10 or p6
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v10 = nil
	local count = 0
	local v11 = nil

	while __wf_atom_7e8ad928(v10) and count <= 10 do
		local __wf_atom_a70d9d07 = __wf_atom_7d789620:__wf_atom_a70d9d07(p, p2, true, v9)
		v10, v11 = FindValidSpawnPos(__wf_atom_a70d9d07, p4, p3, nil, {}, nil, p5, 0, p7, p8)
		count += 1
		Sleep(0)
	end

	return v10, v11
end

function GetValidSpawnPositionsInArea(p, p2, p3, p4, p5, p6, p7, p8, list, p9, p10, p11)
	v7 = __wf_atom_72884638("LotusGameRules.MissionDebug")
	local v9 = {}
	local result = {}

	for i = 1, #list do
		table.insert(v9, list[i])
	end

	local v10 = __wf_atom_7e8ad928(p9) and 5 or p9
	local v11 = __wf_atom_7e8ad928(p10) and 0 or p10
	local v12 = __wf_atom_7e8ad928(p11) and true or p11

	for _ = 1, p do
		local v13 = __wf_atom_7e8ad928(p7) and 10 or p7
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local pos = nil
		local count = 0
		local rot = nil

		while __wf_atom_7e8ad928(pos) and count <= v10 do
			local __wf_atom_a70d9d07 = __wf_atom_7d789620:__wf_atom_a70d9d07(p2, p3, v12, v13)
			pos, rot = FindValidSpawnPos(__wf_atom_a70d9d07, p5, p4, nil, v9, nil, p6, v11, p8)
			count += 1
			Sleep(0)
		end

		table.insert(v9, pos)
		table.insert(result, { pos = pos, rot = rot })
	end

	return result
end

function GetValidGroundSpawnPos(p, p2, p3, p4, p5)
	v7 = __wf_atom_72884638("LotusGameRules.MissionDebug")
	local v9, v10 = FindValidSpawnPos(p, p3, p2, nil, {}, nil, p4, 0, p5)

	if __wf_atom_7e8ad928(v9) then
		return
	else
		return v9, v10
	end
end

local function fn6(p)
	local v9 = __wf_atom_e97f3142(p)

	if v9 == Vector(0, 0, 1) then
		return (Rotation(0, 90, 0))
	end

	local v10 = Vector(v9.y, -v9.x, v9.z)

	if __wf_atom_edfe0d73(v10, v9) == __wf_atom_28d5d4aa then
		v10 = Vector(-v9.z, v9.y, v9.x)
	end

	local v11 = __wf_atom_edfe0d73(v10, v9)
	return (__wf_atom_671e9fd0(v10, v9, v11))
end

function GetGroundAlignedSpawnPos(p, p2, p3)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return __wf_atom_28d5d4aa, __wf_atom_80368bb1
	end

	local v9 = Vector(0, 1, 0)
	local v10 = Vector()
	local v11 = Rotation()

	if __wf_atom_7e8ad928(gRegion:__wf_atom_267afa54(p2 + v9, p2 - v9, nil, nil, nil, v10, v11, true)) then
		return p2, __wf_atom_80368bb1
	end

	local v12 = fn6(v11)
	local v13 = Resource(p)
	local __wf_atom_b6b760b5 = v13:__wf_atom_b6b760b5()
	local v14 = __wf_atom_b6b760b5:__wf_atom_0aa77159() * v13:__wf_atom_c082fc3d()
	local v15 = __wf_atom_b6b760b5:__wf_atom_ee03557f() * v13:__wf_atom_c082fc3d()
	local v16 = v10 + __wf_atom_9341614d(Vector(0, v14.y, v14.z), v12)
	local v17 = v10 + __wf_atom_9341614d(Vector(v14.x, v14.y, v15.z), v12)
	local v18 = v10 + __wf_atom_9341614d(Vector(v15.x, v14.y, v15.z), v12)
	local v19 = Vector()
	local v20 = Vector()
	local v21 = Vector()

	if
		__wf_atom_7e8ad928(gRegion:Raycast(v16 + v9, v16 - v9, nil, nil, v19, true))
		or __wf_atom_7e8ad928(gRegion:Raycast(v17 + v9, v17 - v9, nil, nil, v20, true))
		or __wf_atom_7e8ad928(gRegion:Raycast(v18 + v9, v18 - v9, nil, nil, v21, true))
	then
		return v10, v12
	end

	local v22 = v21 - v19
	local v23 = v20 - v19
	local v24 = __wf_atom_edfe0d73(v23, v22)
	local v25 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v24)
	local v26 = __wf_atom_7e8ad928(p3) and 0.1 or p3
	return v10 + Vector(0, -v26, 0), (fn6(v25))
end