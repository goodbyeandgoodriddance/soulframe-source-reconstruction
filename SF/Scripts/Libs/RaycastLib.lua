module(..., package.seeall)
local v = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }

local function fn(p)
	local v2 = __wf_atom_e97f3142(p)

	if v2 == Vector(0, 0, 1) then
		return (Rotation(0, 90, 0))
	end

	local v3 = Vector(v2.y, -v2.x, v2.z)

	if __wf_atom_edfe0d73(v3, v2) == __wf_atom_28d5d4aa then
		v3 = Vector(-v2.z, v2.y, v2.x)
	end

	local v4 = __wf_atom_edfe0d73(v3, v2)
	return (__wf_atom_671e9fd0(v3, v2, v4))
end

local function fn2(p, p2)
	local v2 = math.rad(p2)
	local v3 = Vector(0, 0, 1)
	local v4 = Vector(0, 1, 0)
	return math.cos(v2) <= Dot(__wf_atom_9341614d(v3, p), v4)
end

local function fn3(p, p2, p3, p4, p5)
	local v2 = p2 or Vector(0, 2, 0)
	local v3 = p3 or Vector(0, -5, 0)
	local v4 = Vector()
	gRegion:__wf_atom_c20d246a(p + v2, p + v3, p4 or v, nil, v4)

	if v4 == __wf_atom_28d5d4aa then
		return p5 or p
	end

	return v4
end

local function fn4(p, p2)
	if not __wf_atom_7e8ad928(p2) then
		p = __wf_atom_d919c2d7(p, Rotation(0, 0, p2))
	end

	return (__wf_atom_d919c2d7(p, Rotation(0, 90, 0)))
end

function GetGroundPos(p, p2, p3, p4, p5)
	return (fn3(p, p2, p3, p4, p5))
end

function CorrectGroundHitAngle(p, p2)
	return (fn4(p, p2))
end

function GetValidTerrainPos(p, p2, p3, value)
	local v2 = Vector()
	local v3 = Rotation()
	local v4 = __wf_atom_4240d7fd()
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(
		p + Vector(0, 5, 0),
		p + Vector(0, -10, 0),
		nil,
		nil,
		v4,
		v2,
		v3,
		true
	)
	local v5 = v4:Get()

	if
		__wf_atom_267afa54
		and not __wf_atom_7e8ad928(v5)
		and (p2 or v5:IsA(__wf_atom_5a5ce2a1))
		and fn2(v3, value or 30)
	then
		if p3 then
			return v2, v3
		end

		return v2
	end
end

function GetGroundAlignedSpawnPosRot(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return nil, nil
	end

	local v2 = Vector(0, 3, 0)
	local v3 = Vector(0, -7, 0)
	local v4 = Vector()
	local v5 = Rotation()
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(p2 + v2, p2 + v3, nil, nil, nil, v4, v5, true)

	if p4 and (__wf_atom_7e8ad928(__wf_atom_267afa54) or not __wf_atom_267afa54:IsA(__wf_atom_5a5ce2a1)) then
		return nil, nil
	end

	if __wf_atom_7e8ad928(__wf_atom_267afa54) then
		return p2, __wf_atom_80368bb1
	end

	local v6 = fn(v5)

	if not (__wf_atom_7e8ad928(p5) or fn2(v5, p5)) then
		return nil, nil
	end

	local v7 = Resource(p)
	local __wf_atom_b6b760b5 = v7:__wf_atom_b6b760b5()
	local v8 = __wf_atom_b6b760b5:__wf_atom_0aa77159() * v7:__wf_atom_c082fc3d()
	local v9 = __wf_atom_b6b760b5:__wf_atom_ee03557f() * v7:__wf_atom_c082fc3d()
	local v10 = v4 + __wf_atom_9341614d(Vector(0, v8.y, v8.z), v6)
	local v11 = v4 + __wf_atom_9341614d(Vector(v8.x, v8.y, v9.z), v6)
	local v12 = v4 + __wf_atom_9341614d(Vector(v9.x, v8.y, v9.z), v6)
	local v13 = Vector()
	local v14 = Vector()
	local v15 = Vector()

	if
		__wf_atom_7e8ad928(gRegion:Raycast(v10 + v2, v10 + v3, nil, nil, v13, true))
		or __wf_atom_7e8ad928(gRegion:Raycast(v11 + v2, v11 + v3, nil, nil, v14, true))
		or __wf_atom_7e8ad928(gRegion:Raycast(v12 + v2, v12 + v3, nil, nil, v15, true))
	then
		return v4, v6
	end

	local v16 = v15 - v13
	local v17 = v14 - v13
	local v18 = __wf_atom_edfe0d73(v17, v16)
	local v19 = fn(__wf_atom_fa8d0177(__wf_atom_28d5d4aa, v18))

	if not __wf_atom_7e8ad928(p3) then
		v19 = __wf_atom_d919c2d7(v19, p3)
	end

	return v4, v19
end

function AngleWithinLimit(p, p2)
	return (fn2(p, p2))
end

function ObjTypeHasHeightClearance(p, p2)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	local v2 = Resource(p)
	local __wf_atom_b6b760b5 = v2:__wf_atom_b6b760b5()
	local v3 = __wf_atom_b6b760b5:__wf_atom_0aa77159() * v2:__wf_atom_c082fc3d()
	local v4 = __wf_atom_b6b760b5:__wf_atom_ee03557f() * v2:__wf_atom_c082fc3d()
	local v5 = p2 + Vector(0, v4.y - v3.y, 0)
	local v6 = Vector()

	if __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(p2 + Vector(0, 0.1, 0), v5 + Vector(0, 0.1, 0), v, nil, v6)) then
		return true
	end

	return false
end

function ObjectHasSizeClearance(p, list, p2)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	local v2 = Vector(0, 1.5, 0)
	local v3 = Vector(0, -0.25, 0)

	for i = 1, 3 do
		local v4 = p + __wf_atom_9341614d(Vector(p2, 0, 0), Rotation(120 * (i - 1), 0, 0))
		local v5 = Vector()
		local raycastResult = gRegion:Raycast(p + v2, v4 + v3, nil, nil, v5, true)

		if __wf_atom_7e8ad928(raycastResult) or v5 == __wf_atom_28d5d4aa then
			return
		end

		if __wf_atom_7e8ad928(list) or not (#list > 0) then
			continue
		end

		local v6 = false

		for _, className in ipairs(list) do
			if not raycastResult:IsA(className) then
				continue
			end

			v6 = true
			break
		end

		if not v6 then
			return false
		end
	end

	return true
end

function SweepAvatarToGround(p, p2, p3, p4)
	local v2 = Vector()
	local v3 = Vector()

	if gRegion:__wf_atom_df3098a0(p, p2 + Vector(0, 1, 0), p2 + Vector(0, -5, 0), p3, p4 or v, v2, v3) then
		return v2
	end

	return p2
end