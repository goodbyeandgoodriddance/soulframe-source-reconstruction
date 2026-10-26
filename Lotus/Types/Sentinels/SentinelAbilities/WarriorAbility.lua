local function fn(object, p, p2, p3)
	local v = p * (1 + p2 / p3)

	if __wf_atom_7e8ad928(object) then
		return v
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return v * __wf_atom_d2b2176d:__wf_atom_2a745663(
			1,
			467,
			__wf_atom_35a10d3c:__wf_atom_1bb5b1ff(),
			__wf_atom_35a10d3c
		)
	end

	return v
end

function GetDescriptionInfo(p, p2)
	local v = fn(nil, 15, p, p2)
	local v2 = v >= 10 and 4 or 3
	local v3 = {
		DISTANCE = string.sub("" .. v, 0, v2)
	}
	return cjson.encode(v3)
end

function NpcEvaluateAbility(_, object, p, p2)
	local v = fn(object, 15, p, p2)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_456732aa = __wf_atom_30e3d82b:__wf_atom_456732aa(v, invalidTargetTypes, true)

	if __wf_atom_7e8ad928(__wf_atom_456732aa.avatar) then
		return 0
	end

	local __wf_atom_dbb22a12 = object:__wf_atom_dbb22a12()

	if not __wf_atom_7e8ad928(__wf_atom_dbb22a12) and __wf_atom_dbb22a12:__wf_atom_611b620c() then
		return 0
	end

	local __wf_atom_30e3d82b2 = __wf_atom_456732aa.avatar:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b2) or __wf_atom_30e3d82b2:__wf_atom_04ea4887() then
		__wf_atom_30e3d82b:__wf_atom_4c229c87(__wf_atom_456732aa)
		return 1
	else
		return 0
	end
end

function ActivateAbility(_, object, _, p, p2)
	local v = fn(object, 15, p, p2)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:AllowFire(true)
		local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
		local __wf_atom_dbb22a12 = object:__wf_atom_dbb22a12()
		local v2 = 0

		while
			not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_9a1e4ed3.visible
			and __wf_atom_9a1e4ed3:__wf_atom_a3309443()
		do
			local __wf_atom_8a6b8fc3 = __wf_atom_9a1e4ed3:__wf_atom_8a6b8fc3(__wf_atom_dbb22a12)

			if v + 2 < __wf_atom_8a6b8fc3 then
				break
			end

			Sleep(0)

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				continue
			end

			v2 += __wf_atom_084b3e93()

			if v2 > 1 then
				local __wf_atom_456732aa = __wf_atom_30e3d82b:__wf_atom_456732aa(v, invalidTargetTypes, true)

				if
					__wf_atom_456732aa.entity ~= __wf_atom_9a1e4ed3.entity
					and __wf_atom_456732aa.distanceToTarget + 4 < __wf_atom_9a1e4ed3.distanceToTarget
				then
					__wf_atom_30e3d82b:__wf_atom_4c229c87(__wf_atom_456732aa)
				end

				v2 -= 1
			end

			__wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
		end
	end
end

function DeactivateAbility(_, object, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:AllowFire(false)
		__wf_atom_30e3d82b:__wf_atom_56055f0b()
	end
end