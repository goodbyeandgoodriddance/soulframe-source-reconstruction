require("SF.Scripts.Libs.CommonFunctionsLib")
Symbol("Grineer")
local v = WeakResource("/SF/Types/Player/EnvoyAvatar")
local v2 = nil
require("SF.Scripts.Libs.SparrowLib")

local function fn(instance)
	local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()
	local v3 = nil

	for _, v4 in pairs(__wf_atom_be0bea4a) do
		if v4:IsA(v) then
			v3 = v4
		end
	end

	if not __wf_atom_7e8ad928(v3) then
		return v3
	end

	print("Couldn't find attached Rider!")
end

local function fn2(object, ratGuideCurrentWaypoint, object2)
	local __wf_atom_31c6f706 = ratGuideCurrentWaypoint:__wf_atom_31c6f706()

	if __wf_atom_7e8ad928(__wf_atom_31c6f706) or __wf_atom_7e8ad928(__wf_atom_31c6f706[1]) then
		return nil
	end

	_T.RatGuideCurrentWaypoint = __wf_atom_31c6f706[1]
	_T.RatGuidePreviousWaypoint = ratGuideCurrentWaypoint
	local ratGuideCurrentWaypoint2 = _T.RatGuideCurrentWaypoint

	if __wf_atom_7e8ad928(ratGuideCurrentWaypoint2) then
		return
	end

	v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_a2a18137 = ratGuideCurrentWaypoint2:__wf_atom_a2a18137()
	ratGuideCurrentWaypoint2:__wf_atom_dc309f8a()
	local v3 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), __wf_atom_a2a18137)
	v3.pitch = 0
	v3.bank = 0
	object:__wf_atom_84d66e8e(v3)
	local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(__wf_atom_a2a18137)

	if ratGuideCurrentWaypoint2:__wf_atom_a5304c35(__wf_atom_0e0a6fee) > 0.1 then
		local v4 = __wf_atom_a2a18137 - object:GetPosition()
		Normalize(v4)
		local v5 = __wf_atom_a2a18137 + v4 * -0.5
		__wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v5)
	end

	object2:__wf_atom_b783ff91(__wf_atom_0e0a6fee, v3.heading)
	return __wf_atom_0e0a6fee
end

local function fn3(object) -- 1 equivalent call inferred from this helper
	local nearestTagged = gRegion:FindNearestTagged(waypointTag, object:__wf_atom_a2a18137())

	if not __wf_atom_7e8ad928(nearestTagged) then
		_T.RatGuideCurrentWaypoint = nearestTagged
		_T.RatGuidePreviousWaypoint = nearestTagged
	end
end

function MoveToDestination(object, instance)
	if gRegion:IsMaster() then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()
		__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("Invulnerable"), 26, 6, 0)

		if __wf_atom_7e8ad928(_T.RatGuideCurrentWaypoint) and __wf_atom_7e8ad928(_T.RatGuidePreviousWaypoint) then
			fn3(__wf_atom_3d96ddcd) -- inferred equivalent call
			object:__wf_atom_400189c4(7)
		end

		local ratGuideCurrentWaypoint = _T.RatGuideCurrentWaypoint

		if __wf_atom_7e8ad928(ratGuideCurrentWaypoint) then
			return
		end

		local __wf_atom_31c6f706 = ratGuideCurrentWaypoint:__wf_atom_31c6f706()

		if __wf_atom_7e8ad928(__wf_atom_31c6f706) then
			return
		end

		_T.RatGuideCurrentWaypoint = __wf_atom_31c6f706[1]
		_T.RatGuidePreviousWaypoint = ratGuideCurrentWaypoint
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_a2a18137 = ratGuideCurrentWaypoint:__wf_atom_a2a18137()
		local __wf_atom_dc309f8a = ratGuideCurrentWaypoint:__wf_atom_dc309f8a()
		local v3 = __wf_atom_fa8d0177(__wf_atom_3d96ddcd:__wf_atom_a2a18137(), __wf_atom_a2a18137)
		v3.pitch = 0
		v3.bank = 0
		__wf_atom_3d96ddcd:__wf_atom_84d66e8e(v3)
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(__wf_atom_a2a18137)

		if ratGuideCurrentWaypoint:__wf_atom_a5304c35(__wf_atom_0e0a6fee) > 0.1 then
			local v4 = __wf_atom_a2a18137 - __wf_atom_3d96ddcd:GetPosition()
			Normalize(v4)
			local v5 = __wf_atom_a2a18137 + v4 * -0.5
			__wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v5)
		end

		local _ = ratGuideCurrentWaypoint:__wf_atom_db682341() == finalWaypointTag
		__wf_atom_3d96ddcd:__wf_atom_e4df34a5(false)
		__wf_atom_30e3d82b:__wf_atom_b783ff91(__wf_atom_0e0a6fee, v3.heading)
		object:Disable()
		local v4 = true

		while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) do
			if __wf_atom_7e8ad928(instance) or instance:IsKilled() or not instance:IsA(v) then
				instance = gRegion:__wf_atom_c4f78a8f()

				if not instance:IsA(v) then
					instance = fn(instance)
				end
			else
				local __wf_atom_a5304c35 = __wf_atom_3d96ddcd:__wf_atom_a5304c35(__wf_atom_0e0a6fee)
				local __wf_atom_8a6b8fc3 = __wf_atom_3d96ddcd:__wf_atom_8a6b8fc3(instance)
				local v5 = ratGuideCurrentWaypoint:__wf_atom_db682341() == waypointTag
				local closeEnoughToWaypointDistance = closeEnoughToWaypointDistance

				if __wf_atom_a5304c35 <= (v5 and 0.5 or closeEnoughToWaypointDistance) and v4 then
					local position = __wf_atom_3d96ddcd:GetPosition()

					if
						__wf_atom_a2a18137.y - position.y > 0.1
						and ratGuideCurrentWaypoint:__wf_atom_a5304c35(__wf_atom_0e0a6fee) > 0.1
						or alwaysExecuteLanding
					then
						if shouldStop or ratGuideCurrentWaypoint:__wf_atom_db682341() == waypointTag then
							__wf_atom_30e3d82b:__wf_atom_b414eabf()
							__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
							v4 = false

							if shouldTeleport then
								__wf_atom_3d96ddcd:Teleport(
									ratGuideCurrentWaypoint:__wf_atom_a2a18137(),
									__wf_atom_dc309f8a,
									false
								)
								Sleep(0)
							end

							__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ravenLoopOnPerchAnim, false, 3, 2, true)
						else
							__wf_atom_0e0a6fee = fn2(__wf_atom_3d96ddcd, ratGuideCurrentWaypoint, __wf_atom_30e3d82b)
							ratGuideCurrentWaypoint = _T.RatGuideCurrentWaypoint
						end
					end

					if __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
						__wf_atom_30e3d82b:__wf_atom_b414eabf()
						__wf_atom_30e3d82b:__wf_atom_24ddbdc3()

						if shouldTeleport then
							__wf_atom_3d96ddcd:Teleport(
								ratGuideCurrentWaypoint:__wf_atom_a2a18137(),
								__wf_atom_dc309f8a,
								false
							)
							Sleep(0)
						end

						__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ravenLoopOnPerchAnim, false, 3, 2, true)
						return
					end
				elseif not (v4 and __wf_atom_8a6b8fc3 >= 70) and not v4 and __wf_atom_8a6b8fc3 < 25 then
					__wf_atom_3d96ddcd:__wf_atom_921c1a5f(nil, false)
					__wf_atom_0e0a6fee = fn2(__wf_atom_3d96ddcd, ratGuideCurrentWaypoint, __wf_atom_30e3d82b)
					ratGuideCurrentWaypoint = _T.RatGuideCurrentWaypoint
					v4 = true
				end

				if
					v4
					and (__wf_atom_30e3d82b:__wf_atom_0d7e0a1f() or __wf_atom_30e3d82b:__wf_atom_d3f9d901() or __wf_atom_3d96ddcd:__wf_atom_8a6b8fc3(ratGuideCurrentWaypoint) <= 0.1)
				then
					__wf_atom_30e3d82b:__wf_atom_b414eabf()
					__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
					break
				end
			end

			if canShowDebug then
				gRegion:__wf_atom_8d991675(__wf_atom_3d96ddcd:GetPosition(), 0.1, Color(0, 255, 255), 0)
				gRegion:__wf_atom_628723a6(
					__wf_atom_0e0a6fee,
					__wf_atom_0e0a6fee + Vector(0, 2, 0),
					Color(0, 255, 0),
					0
				)
				gRegion:__wf_atom_5b35a0c8(__wf_atom_a2a18137, Color(0, 255, 0), "Raven Destination", 1, 0)
			end

			Sleep(0)
		end

		Sleep(0.7)

		if not (__wf_atom_7e8ad928(object) or _T.RatGuideIsStandBy) then
			object:Enable()
		end
	end
end