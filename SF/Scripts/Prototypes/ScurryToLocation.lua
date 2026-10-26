local module = require("SF.Scripts.Libs.CommonFunctionsLib")
Symbol("Grineer")
local v = WeakResource("/SF/Types/Player/EnvoyAvatar")
local v2 = Resource("/SF/Animations/Wildlife/Rat/Burrow_anim.fbx")
local ratguidePathTrail = nil
local v3 = nil
local module2 = require("SF.Scripts.Libs.SparrowLib")

local function fn(ratGuideCurrentWaypoint)
	if __wf_atom_7e8ad928(ratguidePathTrail) then
		print("No trail effect created")
		return
	end

	ratguidePathTrail:__wf_atom_a64eca67(ratGuideCurrentWaypoint:GetPosition())
	ratguidePathTrail:__wf_atom_c709edee(225)

	if not (#ratguidePathTrail:__wf_atom_7df70ec2() > 0) then
		print("AnimalTrail: Failed - zero length path")
		return
	end

	local __wf_atom_f2f158da = ratguidePathTrail:__wf_atom_f2f158da()
	ratguidePathTrail:__wf_atom_7cbad21b((math.floor(__wf_atom_f2f158da / 5)))
	ratguidePathTrail:__wf_atom_fa550593()
end

local function fn2(object) -- 1 equivalent call inferred from this helper
	local nearestTagged = gRegion:FindNearestTagged(waypointTag, object:__wf_atom_a2a18137())

	if not __wf_atom_7e8ad928(nearestTagged) then
		_T.RatGuideCurrentWaypoint = nearestTagged
		_T.RatGuidePreviousWaypoint = nearestTagged
	end
end

function ScurryAway(object, instance)
	if gRegion:IsMaster() then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()
		__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("Invulnerable"), 26, 6, 0)

		if __wf_atom_7e8ad928(_T.RatGuideCurrentWaypoint) and __wf_atom_7e8ad928(_T.RatGuidePreviousWaypoint) then
			fn2(__wf_atom_3d96ddcd) -- inferred equivalent call
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

		if useSoulPath then
			if __wf_atom_7e8ad928(_T.RatguidePathTrail) then
				if not __wf_atom_7e8ad928(pathTrailEffectType) then
					ratguidePathTrail = gRegion:CreateEntity(
						pathTrailEffectType,
						__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
						__wf_atom_80368bb1
					)
					fn(ratGuideCurrentWaypoint)
					_T.RatguidePathTrail = ratguidePathTrail
				end
			elseif not __wf_atom_7e8ad928(_T.RatguidePathTrail) then
				ratguidePathTrail = _T.RatguidePathTrail
				ratguidePathTrail:SetPosition(_T.RatGuidePreviousWaypoint:__wf_atom_a2a18137())
				fn(ratGuideCurrentWaypoint)
			end
		end

		module2.AddSparrowDestination(ratGuideCurrentWaypoint, nil, "RatGuide", module2.PRIORITY.CRITICAL, nil, mOwner)
		_T.RatGuideCurrentWaypoint = __wf_atom_31c6f706[1]
		_T.RatGuidePreviousWaypoint = ratGuideCurrentWaypoint
		v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_a2a18137 = ratGuideCurrentWaypoint:__wf_atom_a2a18137()
		local __wf_atom_dc309f8a = ratGuideCurrentWaypoint:__wf_atom_dc309f8a()
		local v4 = __wf_atom_fa8d0177(__wf_atom_3d96ddcd:__wf_atom_a2a18137(), __wf_atom_a2a18137)
		local v5 = 0.5
		v4.pitch = 0
		v4.bank = 0
		__wf_atom_3d96ddcd:__wf_atom_84d66e8e(v4)
		local __wf_atom_0e0a6fee = v3:__wf_atom_0e0a6fee(__wf_atom_a2a18137)

		if ratGuideCurrentWaypoint:__wf_atom_a5304c35(__wf_atom_0e0a6fee) > 0.1 then
			local v6 = __wf_atom_a2a18137 - __wf_atom_3d96ddcd:GetPosition()
			Normalize(v6)
			local v7 = __wf_atom_a2a18137 + v6 * -0.5
			__wf_atom_0e0a6fee = v3:__wf_atom_0e0a6fee(v7)
		end

		local v6 = ratGuideCurrentWaypoint:__wf_atom_db682341() == Symbol("RatGuidePointFinal")
		object:Disable()
		local v7 = false

		while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) do
			if __wf_atom_7e8ad928(instance) or instance:IsKilled() or not instance:IsA(v) then
				instance = gRegion:__wf_atom_c4f78a8f()
			else
				local __wf_atom_a5304c35 = __wf_atom_3d96ddcd:__wf_atom_a5304c35(__wf_atom_0e0a6fee)
				local __wf_atom_8a6b8fc3 = __wf_atom_3d96ddcd:__wf_atom_8a6b8fc3(instance)

				if __wf_atom_a5304c35 <= v5 then
					local position = __wf_atom_3d96ddcd:GetPosition()

					if
						__wf_atom_a2a18137.y - position.y > 0.1
						and ratGuideCurrentWaypoint:__wf_atom_a5304c35(__wf_atom_0e0a6fee) > 0.1
					then
						__wf_atom_3d96ddcd:__wf_atom_9b788a35((__wf_atom_fa8d0177(position, __wf_atom_a2a18137)))
						__wf_atom_3d96ddcd:__wf_atom_e4df34a5(false)
						__wf_atom_3d96ddcd:__wf_atom_3c986cd9(__wf_atom_a2a18137, __wf_atom_dc309f8a, false)
						__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ratTransitionToPerchAnim, true, 3, 1, true)
						__wf_atom_30e3d82b:__wf_atom_b414eabf()
						__wf_atom_30e3d82b:__wf_atom_24ddbdc3()

						if not v6 then
							__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ratLoopOnPerchAnim, false, 3, 2, true)
						end
					end

					if not v6 then
						break
					end

					if __wf_atom_7e8ad928(v2) then
						local v8 = 100

						while v8 > 0 do
							Sleep(0)

							if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
								break
							else
								v8 = instance:__wf_atom_312d8d57(__wf_atom_3d96ddcd)
							end
						end
					else
						__wf_atom_3d96ddcd:__wf_atom_921c1a5f(v2, false, 4, 1, true)
						__wf_atom_3d96ddcd:__wf_atom_8914dfde("Teleport", 2)
					end

					if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
						break
					end

					local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RatCinematicPoint"))
					__wf_atom_3d96ddcd:Teleport(
						__wf_atom_0a6a5887:GetPosition(),
						__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
						true
					)
					instance:SetMeshScale(1)
					Sleep(0)

					if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
						break
					end

					__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ratLoopOnPerchAnim, false, 3, 2, true)
					return
				else
					if __wf_atom_a5304c35 <= 2 then
						v5 = math.min(v5 + __wf_atom_03df4e1d(), 3)
					elseif v7 and __wf_atom_8a6b8fc3 >= 70 then
						__wf_atom_30e3d82b:__wf_atom_b414eabf()
						v7 = false
					elseif not v7 and __wf_atom_8a6b8fc3 < 8 then
						local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
							Symbol("RatDropPoint"),
							__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
							0,
							5
						)

						if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
							__wf_atom_3d96ddcd:__wf_atom_921c1a5f(nil, false)
						else
							__wf_atom_3d96ddcd:__wf_atom_9b788a35((__wf_atom_fa8d0177(
								__wf_atom_3d96ddcd:GetPosition(),
								__wf_atom_f738b4af:__wf_atom_a2a18137()
							)))
							__wf_atom_3d96ddcd:__wf_atom_3c986cd9(
								__wf_atom_f738b4af:__wf_atom_a2a18137(),
								__wf_atom_f738b4af:__wf_atom_2f2bada0(),
								false
							)
							__wf_atom_3d96ddcd:__wf_atom_e4df34a5(true)
							__wf_atom_3d96ddcd:__wf_atom_921c1a5f(ratTransitionFromPerchAnim, true, 3, 1, true)
						end

						__wf_atom_3d96ddcd:__wf_atom_e4df34a5(true)
						__wf_atom_30e3d82b:__wf_atom_b783ff91(__wf_atom_0e0a6fee, v4.heading)
						v7 = true
					end

					if
						v7
						and (__wf_atom_30e3d82b:__wf_atom_0d7e0a1f() or __wf_atom_30e3d82b:__wf_atom_d3f9d901() or __wf_atom_3d96ddcd:__wf_atom_8a6b8fc3(ratGuideCurrentWaypoint) <= 0.1)
					then
						__wf_atom_30e3d82b:__wf_atom_b414eabf()
						__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
						break
					end
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
				gRegion:__wf_atom_5b35a0c8(__wf_atom_a2a18137, Color(0, 255, 0), "Rat Destination", 1, 0)
			end

			Sleep(0)
		end

		Sleep(0.7)

		if not (__wf_atom_7e8ad928(object) or _T.RatGuideIsStandBy) then
			object:Enable()
		end
	end
end

function CreateRatGuide()
	if gRegion:IsMaster() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local nearestTagged = gRegion:FindNearestTagged(
			Symbol("RatGuideStart"),
			__wf_atom_c4f78a8f:__wf_atom_a2a18137()
		)
		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
		local nearestTagged2 = gRegion:FindNearestTagged(
			Symbol("FreedRatGuide"),
			__wf_atom_c4f78a8f:__wf_atom_a2a18137()
		)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ClientRatScaler"))

		if __wf_atom_7e8ad928(nearestTagged2) or __wf_atom_7e8ad928(nearestTagged) then
			if
				__wf_atom_7e8ad928(ratGuideAvatarType)
				or __wf_atom_7e8ad928(nearestTagged)
				or __wf_atom_7e8ad928(__wf_atom_2202ffb6)
			then
				return
			end

			while not __wf_atom_2202ffb6:ReadyToCreateAgents() do
				Sleep(0)
			end

			local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
				ratGuideAvatarType,
				nearestTagged:__wf_atom_a2a18137(),
				nearestTagged:__wf_atom_2f2bada0()
			)

			if __wf_atom_7e8ad928(__wf_atom_402b3832) then
				print("ERROR: Could not create rat guide agent")
				return
			else
				nearestTagged2 = __wf_atom_402b3832:__wf_atom_50a7d83e()
			end
		else
			Sleep(1)
			nearestTagged2:Teleport(nearestTagged:__wf_atom_a2a18137(), nearestTagged:__wf_atom_2f2bada0(), true)
		end

		nearestTagged2:SetMeshScale(3.5)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:FirePort("Execute")
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RatWispers"))

		for _, v4 in ipairs(__wf_atom_2226b35c) do
			v4:Enable()
		end

		Sleep(1)
		_T.RatGuidePreviousWaypoint = nil
		_T.RatGuideCurrentWaypoint = nil
		local taggedChild = module.FindTaggedChild(nearestTagged2:__wf_atom_be0bea4a(), Symbol("GuideTrigger"))
		taggedChild:Enable()
		taggedChild:__wf_atom_400189c4(4)
	end
end

function SetScaleAtLastWp(object, object2)
	if __wf_atom_7e8ad928(object2) then
		object2 = gRegion:__wf_atom_f738b4af(Symbol("FreedRatGuide"), object:__wf_atom_a2a18137(), 0, 10)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:SetMeshScale(1)
		local nearestTagged = gRegion:FindNearestTagged(waypointTag, object2:__wf_atom_a2a18137())
		object2:Teleport(nearestTagged:__wf_atom_a2a18137(), nearestTagged:__wf_atom_2f2bada0(), true)
		local taggedChild = module.FindTaggedChild(object2:__wf_atom_be0bea4a(), Symbol("GuideTrigger"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Disable()
		end
	end
end

function ScaleClientRatGuide(_, _)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FreedRatGuide"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:SetMeshScale(3.5)
end

local function fn3(p)
	local v4 = Symbol("FreedRatGuide")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local taggedChild = module.FindTaggedChild(__wf_atom_0a6a5887:__wf_atom_be0bea4a(), Symbol("GuideTrigger"))
	Sleep(preDelay)

	if not __wf_atom_7e8ad928(taggedChild) then
		if p then
			_T.RatGuideIsStandBy = true
			taggedChild:Disable()
		else
			_T.RatGuideIsStandBy = false
			taggedChild:Enable()
		end
	end
end

function EnableRatStandBy(object)
	if waitForTouching then
		while not object:__wf_atom_acccc08b() do
			Sleep(1)
		end
	end

	fn3(true)
end

function DisableRatStandBy()
	fn3(false)
end