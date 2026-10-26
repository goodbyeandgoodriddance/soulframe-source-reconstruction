local v = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }

local function fn(object)
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	__wf_atom_a06d543c.y = 0
	Normalize(__wf_atom_a06d543c)
	local position = object:GetPosition()
	local v2 = position + __wf_atom_a06d543c * 2 + Vector(0, maxObstacleHeight, 0)
	local v3 = Vector()
	local v4 = Rotation()

	if DRAW_DEBUG then
		gRegion:__wf_atom_c189a462(position, v2, Color(0, 0, 255, 255), 5)
	end

	return not gRegion:__wf_atom_267afa54(position, v2, nil, v, nil, v3, v4, false, true)
end

local function fn2(object, data)
	if __wf_atom_7e8ad928((object:__wf_atom_7be51ede())) then
		return
	end

	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	__wf_atom_a06d543c.y = 0
	local position = object:GetPosition()
	local total = 0

	while not __wf_atom_7e8ad928(object) and total < data.lifeTime and fn(object) do
		position += __wf_atom_a06d543c * (data.speed * __wf_atom_084b3e93())
		local v2 = position + Vector(0, 4, 0)
		local v3 = v2 - Vector(0, 14, 0)
		local v4 = Vector()
		local v5 = Rotation()

		if DRAW_DEBUG then
			gRegion:__wf_atom_c189a462(v2, v3, Color(255, 0, 0, 255), 5)
		end

		if gRegion:__wf_atom_267afa54(v2, v3, nil, v, nil, v4, v5, false, true) then
			v4.y += data.heightOffsetFromGround

			if DRAW_DEBUG then
				gRegion:__wf_atom_8d991675(v4, 0.5, Color(0, 255, 0, 255), 5)
			end

			position = v4
		end

		local v6 = position - object:__wf_atom_a2a18137()
		Normalize(v6)
		object:__wf_atom_53bcb18b(v6 * data.speed)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Die()
	end
end

function SetProjectileMotion(p)
	local v2 = {
		lifeTime = projectileLifeTime,
		speed = projtileSpeed,
		heightOffsetFromGround = projtileHeightOffsetFromGround
	}
	Sleep(0)
	fn2(p, v2)
end