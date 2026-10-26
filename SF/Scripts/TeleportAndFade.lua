local v = WeakResource("")
local v2 = Resource("")

local function fn(object, p, p2)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_be6aab9a(true)
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:IsA(__wf_atom_4d316097) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				if p then
					__wf_atom_e55d02aa:__wf_atom_2ffcdee6()
				end

				__wf_atom_e55d02aa:__wf_atom_c62d97c1(p2)
				Sleep(0)
			end
		end
	end
end

local function fn2(instance, instance2)
	local position = nil
	local v3 = Rotation()
	local v4 = not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb)
	local v5 = not __wf_atom_7e8ad928(instance) and instance:IsA(WeakResource("/EE/Types/Game/PickUp"))

	if v4 and instance:IsA(__wf_atom_7e6ed5fa) then
		instance:AbortContextAction()
	end

	local v6 = instance

	for _, v7 in pairs(_T.transferenceUmbra) do
		if v7 ~= instance then
			continue
		end

		v6 = instance:__wf_atom_6f4c1c1b()
		break
	end

	local v7

	if v4 then
		v7 = v6:__wf_atom_0d9c1a58()

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_5d9ae734 = v6:__wf_atom_d2b2176d():__wf_atom_5d9ae734()

			if not __wf_atom_7e8ad928(__wf_atom_5d9ae734) then
				if __wf_atom_7e8ad928(instance2) or not __wf_atom_5d9ae734:__wf_atom_e82540fe(instance2) then
					return
				end
			end
		end
	end

	local v8 = "none"

	if alwaysTeleportToWaypoint or not v4 or __wf_atom_7e8ad928(v7) then
		if v5 then
			if __wf_atom_7e8ad928(gGameRules) or gGameRules:__wf_atom_e22d6f15() ~= 28 then
				if instance:__wf_atom_25e4d3e4() then
					local __wf_atom_9c8d290f = instance:__wf_atom_9c8d290f()
					v8 = "10"
					local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

					if __wf_atom_2202ffb6:__wf_atom_426b73b4(__wf_atom_9c8d290f, 10) then
						if useTeleportWaypointTag and not __wf_atom_7e8ad928(teleportWaypointTag) then
							local nearestTagged = gRegion:FindNearestTagged(teleportWaypointTag, __wf_atom_9c8d290f)

							if not __wf_atom_7e8ad928(nearestTagged) then
								local position2 = nearestTagged:GetPosition()
								v3 = nearestTagged:__wf_atom_dc309f8a()
								__wf_atom_9c8d290f = position2 + Vector(
									Random(-waypointRadiusRange, waypointRadiusRange),
									0,
									Random(-waypointRadiusRange, waypointRadiusRange)
								)
								v8 = "11"

								if v4 or v5 then
									print("Script Teleport and Fade: " .. instance:__wf_atom_5b41f63b() .. " to: " .. nearestTagged:__wf_atom_5b41f63b())
								end
							end
						end
					else
						local v9 = Vector()

						if gRegion:Raycast(
							__wf_atom_9c8d290f,
							Vector(__wf_atom_9c8d290f.x, __wf_atom_9c8d290f.y - 100, __wf_atom_9c8d290f.z),
							nil,
							nil,
							v9,
							true
						) then
							__wf_atom_9c8d290f = v9
							v8 = "12"
						else
							__wf_atom_2202ffb6:__wf_atom_3c37bceb(__wf_atom_9c8d290f, 100, 0, 0)
						end
					end

					position = __wf_atom_9c8d290f + Vector(0, 1, 0)
				elseif instance:IsA(WeakResource("/Lotus/Types/PickUps/GameplayObjectPickup")) then
					local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
					local position2 = instance:GetPosition()
					__wf_atom_2202ffb6:__wf_atom_3c37bceb(position2, 100, 0, 0)
					position = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_a70d9d07(
						position2,
						5,
						true,
						1
					)
					v8 = "14"
				elseif not __wf_atom_7e8ad928(teleportWaypoint) then
					position = teleportWaypoint:GetPosition()
					v3 = teleportWaypoint:__wf_atom_dc309f8a()
					print("Script Teleport and Fade: " .. instance:__wf_atom_5b41f63b() .. " to: " .. teleportWaypoint:__wf_atom_5b41f63b())
					v8 = "15a"
				end
			else
				local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
				position = instance:GetPosition()
				v8 = "8"

				if not __wf_atom_2202ffb6:__wf_atom_3c37bceb(position, 5, 0, -2) then
					local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

					if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
						position = __wf_atom_c4f78a8f:GetPosition()
						v8 = "9"
					end
				end
			end
		elseif __wf_atom_7e8ad928(teleportWaypoint) then
			if useTeleportWaypointTag and not __wf_atom_7e8ad928(teleportWaypointTag) then
				local nearestTagged = gRegion:FindNearestTagged(teleportWaypointTag, instance:GetPosition())

				if not __wf_atom_7e8ad928(nearestTagged) then
					position = nearestTagged:GetPosition()
					v3 = nearestTagged:__wf_atom_dc309f8a()
					v8 = "16"

					if v4 or v5 then
						print("Script Teleport and Fade: " .. instance:__wf_atom_5b41f63b() .. " to: " .. nearestTagged:__wf_atom_5b41f63b())
					end
				end
			elseif v4 and instance:IsA(__wf_atom_47cae841) and instance:__wf_atom_d063a16a() then
				position = v6:GetLastValidPosition()
			end
		else
			position = teleportWaypoint:GetPosition()
			v3 = teleportWaypoint:__wf_atom_dc309f8a()
			v8 = "15b"

			if v4 or v5 then
				print("Script Teleport and Fade: " .. instance:__wf_atom_5b41f63b() .. " to: " .. teleportWaypoint:__wf_atom_5b41f63b())
			end
		end
	else
		local __wf_atom_04b7536b = v7:__wf_atom_04b7536b()

		if instance:__wf_atom_d063a16a() then
			position = v6:GetLastValidPosition()
			v8 = "5"

			if position == __wf_atom_28d5d4aa and instance:IsA(__wf_atom_c0fefb76) then
				local __wf_atom_eff0517e = v7:__wf_atom_eff0517e()

				if not __wf_atom_7e8ad928(__wf_atom_eff0517e) then
					position = __wf_atom_eff0517e:GetLastValidPosition()
					v8 = "6"
				end
			end
		else
			if not __wf_atom_7e8ad928(__wf_atom_04b7536b) and __wf_atom_04b7536b:__wf_atom_d063a16a() then
				position = __wf_atom_04b7536b:GetLastValidPosition()
				v8 = "1"
			end

			if position == nil and useTeleportWaypointTag and not __wf_atom_7e8ad928(teleportWaypointTag) then
				local nearestTagged = gRegion:FindNearestTagged(teleportWaypointTag, instance:GetPosition())

				if not __wf_atom_7e8ad928(nearestTagged) then
					position = nearestTagged:GetPosition()
					v8 = "2"
				end
			end

			if position == nil then
				position = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(
					instance:GetPosition(),
					120,
					80
				)
				v8 = "3"
			end
		end

		v3 = Rotation()

		if
			not __wf_atom_7e8ad928(__wf_atom_04b7536b)
			and instance ~= __wf_atom_04b7536b
			and __wf_atom_04b7536b:__wf_atom_d063a16a()
			and v7:__wf_atom_50a7d83e() == __wf_atom_04b7536b
		then
			position = __wf_atom_04b7536b:GetLastValidPosition()
			v8 = "7"
		end
	end

	if
		#randomTeleportWaypoints > 0
		and (useRandomForNpcsOnly and not instance:IsA(__wf_atom_c9cec0ec) or not useRandomForNpcsOnly)
	then
		local v9 = {}

		for i = 1, #randomTeleportWaypoints do
			if randomTeleportWaypoints[i]:IsEnabled() then
				table.insert(v9, randomTeleportWaypoints[i])
			end
		end

		local v10 = __wf_atom_5784a397(1, #v9)

		if not __wf_atom_7e8ad928(v9[v10]) then
			position = v9[v10]:GetPosition()
			v3 = v9[v10]:__wf_atom_dc309f8a()
			print("Script Teleport and Fade: " .. instance:__wf_atom_5b41f63b() .. " to: " .. v9[v10]:__wf_atom_5b41f63b())
			v8 = "17"
		end
	end

	if v4 then
		fn(instance, false, true)

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_eff0517e = v7:__wf_atom_eff0517e()
			local __wf_atom_04b7536b = v7:__wf_atom_04b7536b()

			if __wf_atom_eff0517e ~= instance then
				fn(__wf_atom_eff0517e, false, true)
			end

			if __wf_atom_04b7536b ~= instance then
				fn(__wf_atom_04b7536b, false, true)
			end
		end

		if not __wf_atom_7e8ad928(instance) and instance:IsA(v) then
			local __wf_atom_7470861b = instance:__wf_atom_7470861b()

			if __wf_atom_7470861b:__wf_atom_0e8b4cda() then
				__wf_atom_7470861b:__wf_atom_4807c4aa()
			end
		end
	end

	if position == nil or __wf_atom_7e8ad928(instance) then
		if not __wf_atom_7e8ad928(instance) then
			if v4 and not __wf_atom_7e8ad928(v7) then
				if not __wf_atom_7e8ad928(instance2) then
					local teleportAndFade = _T.TeleportAndFade

					if teleportAndFade == nil then
						teleportAndFade = {}
						_T.TeleportAndFade = teleportAndFade
					end

					local __wf_atom_5b41f63b = instance2:__wf_atom_5b41f63b()

					if teleportAndFade[__wf_atom_5b41f63b] == nil then
						teleportAndFade[__wf_atom_5b41f63b] = 1
						print("ERROR: TeleportAndFade.lua: " .. instance:__wf_atom_5b41f63b() .. " Was not teleported to a waypoint because the waypoint for " .. __wf_atom_5b41f63b .. " was null")
						local __wf_atom_e800787c = instance2:__wf_atom_e800787c()

						if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
							local __wf_atom_b6b760b5 = __wf_atom_e800787c:__wf_atom_b6b760b5()

							if not __wf_atom_7e8ad928(__wf_atom_b6b760b5) then
								local __wf_atom_5b41f63b2 = __wf_atom_b6b760b5:__wf_atom_5b41f63b()
								local v9 = string.gsub(__wf_atom_5b41f63b2, "([/][^/]+)$", "")
								LogBug("TeleportAndFade missing waypoint in " .. v9)
							end
						end
					end
				end

				local __wf_atom_0d0a614d = gRegion:__wf_atom_0d0a614d()

				if not __wf_atom_7e8ad928(__wf_atom_0d0a614d) then
					instance:Teleport(__wf_atom_0d0a614d, instance:__wf_atom_dc309f8a())
				end
			else
				local lastValidPosition

				if v4 and instance:__wf_atom_d063a16a() then
					lastValidPosition = instance:GetLastValidPosition()
					v8 = "18"
				else
					lastValidPosition = instance:GetPosition()
					v8 = "19"
				end

				position = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(
					lastValidPosition,
					maxHorizontalDistance,
					maxVerticalDistance
				)
				instance:Teleport(position, (Rotation()))
			end
		end
	else
		instance:Teleport(position, v3)

		if v4 and not __wf_atom_7e8ad928(v7) then
			if not (__wf_atom_7e8ad928(blockingAnim) or __wf_atom_7e8ad928(instance:__wf_atom_a96eb2aa())) then
				instance:__wf_atom_921c1a5f(blockingAnim, false, 2, 1, true)
			end

			instance:__wf_atom_d2b2176d():__wf_atom_d5651846()
			local __wf_atom_28224c27 = instance:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:__wf_atom_3e33d5dd() ~= 0 then
				instance:__wf_atom_d2b2176d():__wf_atom_477c650b(true, true)
			end
		end

		instance:__wf_atom_8f1276cf(Vector())

		if not __wf_atom_7e8ad928(teleportSound) then
			instance:PlaySound(teleportSound, false, 1, true)
		end

		if not __wf_atom_7e8ad928(TeleportEffect) then
			gRegion:CreateEntity(TeleportEffect, position, v3)
		end

		if not __wf_atom_7e8ad928(AvatarEffect) then
			instance:Attach(AvatarEffect, EMPTY_SYMBOL)
		end

		if v4 then
			if causeDamage then
				instance:SetHealth(instance:__wf_atom_c6f1f83d() * (1 - damageRatio))
			end

			if causeProc then
				local damageData = Engine.DamageData()
				damageData:__wf_atom_d6f4d914(procType, true)
				instance:__wf_atom_649bf33e(damageData)
			end

			if useWaypointFacingAngle then
				instance:__wf_atom_f0f9fb38(v3)
				instance:MotionControl():__wf_atom_3a1d0c16(v3)
			end

			instance:__wf_atom_076a23a5()
			instance:__wf_atom_30483d98()

			if not __wf_atom_7e8ad928(v7) then
				local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

				if __wf_atom_d2b2176d:__wf_atom_051c6efa() == 3 then
					instance:SetArchwingSkyMode(false)
				end

				__wf_atom_d2b2176d:__wf_atom_d5651846()
				local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)

				if not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:__wf_atom_3e33d5dd() ~= 0 then
					__wf_atom_d2b2176d:__wf_atom_477c650b(true, true)
				end
			end
		end

		if
			__wf_atom_7e8ad928(instance2)
			or __wf_atom_7e8ad928(instance)
			or not instance2:HasTag(Symbol("FixMe2022"))
		then
			Sleep(0.1)

			if not __wf_atom_7e8ad928(instance) then
				instance:Teleport(position, v3)
			end

			Sleep(0.1)

			if not __wf_atom_7e8ad928(instance) then
				instance:Teleport(position, v3)
			end
		else
			instance:SetDisableMovement(true)
			instance:MotionControl():__wf_atom_5ab9523f(0)
			instance:__wf_atom_aeb02c14(v2)
			local total = 0

			while
				not __wf_atom_7e8ad928(instance)
				and instance:__wf_atom_278a2d05() ~= __wf_atom_28d5d4aa
				and total < 1
			do
				Sleep(0)

				if not __wf_atom_7e8ad928(instance) then
					instance:Teleport(position, v3)
				end

				total += __wf_atom_084b3e93()
			end

			if not __wf_atom_7e8ad928(instance) then
				instance:SetDisableMovement(false)
				instance:MotionControl():__wf_atom_5ab9523f(1)
				instance:__wf_atom_cf966a74(v2)
			end
		end
	end

	if v4 then
		fn(instance, true, false)

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_eff0517e = v7:__wf_atom_eff0517e()
			local __wf_atom_04b7536b = v7:__wf_atom_04b7536b()

			if __wf_atom_eff0517e ~= instance then
				fn(__wf_atom_eff0517e, true, false)
			end

			if __wf_atom_04b7536b ~= instance then
				fn(__wf_atom_04b7536b, true, false)
			end
		end
	end

	if closeDestinationTeleport and not __wf_atom_7e8ad928(teleportWaypoint) then
		position = teleportWaypoint:GetPosition()
		v8 = "20"
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("CloseTeleporter"), position, 0, 10)

		if not __wf_atom_7e8ad928(__wf_atom_439c0d29) and #__wf_atom_439c0d29 > 0 then
			__wf_atom_439c0d29[1]:FirePort("TriggerPort")
		end
	end

	if __wf_atom_7e8ad928(instance) then
		print("TeleportAndFade: " .. v8 .. " NULLINSTIGATOR -> " .. (tostring(position) or "none"))
	else
		print("TeleportAndFade: " .. v8 .. " " .. instance:__wf_atom_5b41f63b() .. " -> " .. (tostring(position) or "none"))
	end
end

local function fn3(object, p, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_0d9c1a58()) or _T.RespawnInProgress then
		return
	end

	_T.InterruptRunningFade = true
	Sleep(0.01)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local __wf_atom_89894bd1 = __wf_atom_8ad59546:__wf_atom_89894bd1()
	Sleep(initialDelay)

	if p == 0 then
		__wf_atom_8ad59546:__wf_atom_47f0b80b(p2)
		print("PPF: TeleportAndFadeInstant: " .. p2)
		Sleep(0)
	else
		_T.InterruptRunningFade = false
		local total = 0

		while total < 1 do
			if _T.InterruptRunningFade then
				return
			end

			__wf_atom_8ad59546:__wf_atom_47f0b80b((__wf_atom_104bfe98(__wf_atom_89894bd1, p2, total)))
			total += __wf_atom_084b3e93() / p
			Sleep(0)
		end

		__wf_atom_8ad59546:__wf_atom_47f0b80b(p2)
		print("PPF: TeleportAndFadeEnd: " .. p2)
		_T.InterruptRunningFade = nil
		Sleep(0)
	end
end

local function fn4(instance, object, object2)
	local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local __wf_atom_80368bb1 = __wf_atom_80368bb1
	local lastValidPosition

	if instance:__wf_atom_d063a16a() then
		lastValidPosition = instance:GetLastValidPosition()
	elseif __wf_atom_7e8ad928(object) or not object:__wf_atom_d063a16a() then
		if __wf_atom_7e8ad928(object2) then
			print("TeleportAndFade: ERROR: No player - No place to return avatar to!")
			return
		end

		if __wf_atom_7e8ad928((object2:__wf_atom_50a7d83e())) then
			lastValidPosition = object2:__wf_atom_50a7d83e():GetPosition()
			__wf_atom_80368bb1 = object2:__wf_atom_50a7d83e():__wf_atom_dc309f8a()
		else
			print("TeleportAndFade: ERROR: No location to teleport warframe to inside ship so is ejected without player!")
			return
		end
	else
		lastValidPosition = object:GetLastValidPosition()
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Teleport(lastValidPosition, __wf_atom_80368bb1)
	end
end

function TeleportAndFade(instance, p)
	if
		__wf_atom_7e8ad928(instance)
		or ignorePlayerAvatars
		and instance:IsA(__wf_atom_7e6ed5fa)
		and not __wf_atom_7e8ad928(instance:__wf_atom_a96eb2aa())
	then
		return
	end

	local isA = instance:IsA(__wf_atom_47cae841)

	if instance:IsA(v) then
		instance:__wf_atom_7470861b():__wf_atom_e0a84bd2(3, 3)
	end

	if isA and not instance:__wf_atom_0a0c4594() then
		local __wf_atom_4221009f = instance:__wf_atom_4221009f()

		if not __wf_atom_7e8ad928(__wf_atom_4221009f) then
			instance:GetOffVehicle(__wf_atom_4221009f, Vector(), true)
			__wf_atom_4221009f:__wf_atom_8a035cd5(Symbol("TeleportAndFade"), false)
		end
	end

	local v3 = nil

	if ejectPlayerToSpace then
		if instance:IsA(__wf_atom_7e6ed5fa) and not instance:__wf_atom_a96eb2aa() then
			local __wf_atom_0d9c1a58 = instance:__wf_atom_0d9c1a58()

			if not __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
				fn4(instance, __wf_atom_0d9c1a58:__wf_atom_04b7536b(), __wf_atom_0d9c1a58)
				return
			end
		end

		if instance:IsA(__wf_atom_7e6ed5fa) then
			v3 = instance:__wf_atom_a96eb2aa()
		end
	end

	if instance:IsA(WeakResource("/EE/Types/Engine/HitProxyPhysics")) then
		local __wf_atom_6009c8ed = instance:__wf_atom_6009c8ed()
		local v4 = nil

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			if __wf_atom_6009c8ed:IsA(__wf_atom_7e6ed5fa) then
				local _ = __wf_atom_6009c8ed:__wf_atom_535d5cbb()
					and not (__wf_atom_6009c8ed:IsKilled() or __wf_atom_7e8ad928(__wf_atom_6009c8ed:__wf_atom_f51f1faa()))
				v4 = __wf_atom_6009c8ed
			else
				local _ = teleportRagdolls and __wf_atom_6009c8ed:IsA(__wf_atom_43e0c427)
			end
		end

		if v4 then
			v4:__wf_atom_a42838a7(true)
			v4:__wf_atom_8a035cd5(Symbol("TeleportAndFade"), false)
		end
	end

	local v4

	if
		tennoAvatarsOnly
		and not (instance:IsA(__wf_atom_7e6ed5fa) or instance:IsA(__wf_atom_c0fefb76) or instance:IsA(__wf_atom_f1872364) or instance:IsA(__wf_atom_47cae841) and instance:__wf_atom_535d5cbb())
	then
		v4 = instance
		local v5 = false

		for _, v6 in pairs(_T.transferenceUmbra) do
			if v6 ~= instance then
				continue
			end

			v4 = instance:__wf_atom_6f4c1c1b()
			v5 = true
			break
		end

		if not v5 then
			return
		end
	else
		v4 = instance
	end

	if instance:IsA(__wf_atom_4ebf67cb) then
		if instance:__wf_atom_ae149090() then
			return
		end

		local __wf_atom_0d9c1a58 = v4:__wf_atom_0d9c1a58()

		if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
			if v4:IsA(__wf_atom_f1872364) or v4:IsA(__wf_atom_47cae841) then
				if gRegion:IsMaster() then
					fn2(v4, p)
				end
			elseif instance:__wf_atom_4417a5d4() then
				fn2(v4, p)
			end
		elseif __wf_atom_0d9c1a58:IsLocal() then
			_T.TeleportAndFadeActive = true

			if
				_T.gActiveMatchMakingMode == _T.MATCHMAKING_OFFLINE_GAMEMODE
				and _T.TopMenuOpen
				and not __wf_atom_7e8ad928(_T.TopMenuMovie)
			then
				_T.TopMenuMovie:Execute("ForceClose", "")
			end

			if Engine.__wf_atom_2a979d69() and _T.Touch_StopAutoMove then
				_T.Touch_StopAutoMove()
			end

			local gGameRules = gGameRules

			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_411c9025(true)
			end

			instance:__wf_atom_be6aab9a(false)

			if not gRegion:__wf_atom_c3b255b8() then
				fn3(instance, fadeToChangeTime, fadeToFinalValue)
			end

			fn2(instance, p)

			if __wf_atom_7e8ad928(instance) then
				return
			end

			if not onlyTeleportCurrentAvatar then
				if instance:IsA(__wf_atom_c0fefb76) then
					local __wf_atom_eff0517e = __wf_atom_0d9c1a58:__wf_atom_eff0517e()

					if not __wf_atom_7e8ad928(__wf_atom_eff0517e) and __wf_atom_eff0517e ~= instance then
						fn2(__wf_atom_eff0517e, p)
					end
				else
					local __wf_atom_04b7536b = __wf_atom_0d9c1a58:__wf_atom_04b7536b()

					if not (__wf_atom_7e8ad928(__wf_atom_04b7536b) or __wf_atom_04b7536b:__wf_atom_535d5cbb()) then
						fn2(__wf_atom_04b7536b, p)
					end
				end
			end

			Sleep(fullyFadedDuration)

			if __wf_atom_7e8ad928(instance) then
				return
			end

			if not __wf_atom_7e8ad928(v3) then
				instance = v3:__wf_atom_50a7d83e()

				while not __wf_atom_7e8ad928(instance) and instance:__wf_atom_8bd952f1() do
					Sleep(0)
					instance = v3:__wf_atom_50a7d83e()
				end
			end

			if gRegion:__wf_atom_c3b255b8() then
				_T.InterruptRunningFade = true
				Sleep(0)
				fn3(instance, 0, fadeFromFinalValue)
			else
				fn3(instance, fadeFromChangeTime, fadeFromFinalValue)
			end

			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_411c9025(false)
			end

			_T.TeleportAndFadeActive = nil
		elseif gRegion:IsMaster() and alwaysTeleportToWaypoint then
			Sleep(initialDelay + fadeToChangeTime)

			if not __wf_atom_7e8ad928(instance) then
				fn2(instance, p)
			end
		end
	elseif instance:IsA(WeakResource("/EE/Types/Game/PickUp")) then
		if not __wf_atom_7e8ad928(instance:__wf_atom_3d96ddcd()) then
			instance:__wf_atom_e6ed03c8()
		end

		fn2(instance, p)
	end
end

function TeleportAndFadeFromContextAction(p, instance)
	if
		__wf_atom_7e8ad928(instance)
		or tennoAvatarsOnly and not (instance:IsA(__wf_atom_7e6ed5fa) or instance:IsA(__wf_atom_c0fefb76))
	then
		return
	end

	if instance:IsA(__wf_atom_4ebf67cb) then
		if instance:__wf_atom_ae149090() then
			return
		end

		local v3 = {}

		for i = 1, #disableTags do
			local disableTag = disableTags[i]

			if not disableTag:__wf_atom_8598f3a9() then
				continue
			end

			for _, v4 in ipairs(gRegion:__wf_atom_2226b35c(disableTag)) do
				table.insert(v3, v4)
			end
		end

		for i = #v3, 1, -1 do
			local v4 = v3[i]

			if v4:IsEnabled() then
				v4:Disable()
			else
				table.remove(v3, i)
			end
		end

		local __wf_atom_0d9c1a58 = instance:__wf_atom_0d9c1a58()

		if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
			if
				not __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b())
				and not instance:IsA(__wf_atom_ee1ed4db)
				and __wf_atom_7e8ad928(instance:__wf_atom_3d96ddcd())
				and gRegion:IsMaster()
			then
				local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
				local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

				if
					not __wf_atom_7e8ad928(__wf_atom_72fc675e.vipAgent)
					and instance:__wf_atom_30e3d82b():IsA(__wf_atom_72fc675e.vipAgent)
					or not __wf_atom_7d789620:__wf_atom_29cdfd09(instance:__wf_atom_30e3d82b(), false)
					or instance:__wf_atom_464a4772()
				then
					fn2(instance, p)
				end
			end
		elseif __wf_atom_0d9c1a58:IsLocal() then
			local gGameRules = gGameRules

			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_411c9025(true)
			end

			instance:__wf_atom_be6aab9a(false)

			if not gRegion:__wf_atom_c3b255b8() then
				fn3(instance, fadeToChangeTime, fadeToFinalValue)
			end

			fn2(instance, p)

			if not onlyTeleportCurrentAvatar then
				if instance:IsA(__wf_atom_c0fefb76) then
					local __wf_atom_eff0517e = __wf_atom_0d9c1a58:__wf_atom_eff0517e()

					if not __wf_atom_7e8ad928(__wf_atom_eff0517e) and __wf_atom_eff0517e ~= instance then
						fn2(__wf_atom_eff0517e, p)
					end
				else
					local __wf_atom_04b7536b = __wf_atom_0d9c1a58:__wf_atom_04b7536b()

					if not __wf_atom_7e8ad928(__wf_atom_04b7536b) then
						fn2(__wf_atom_04b7536b, p)
					end
				end
			end

			Sleep(fullyFadedDuration)

			if not gRegion:__wf_atom_c3b255b8() then
				fn3(instance, fadeFromChangeTime, fadeFromFinalValue)
			end

			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_411c9025(false)
			end
		elseif gRegion:IsMaster() and alwaysTeleportToWaypoint then
			Sleep(initialDelay + fadeToChangeTime)
			fn2(instance, p)
		end

		for _, v4 in ipairs(v3) do
			if not __wf_atom_7e8ad928(v4) then
				v4:Enable()
			end
		end
	elseif instance:IsA(WeakResource("/EE/Types/Game/PickUp")) then
		if not __wf_atom_7e8ad928(instance:__wf_atom_3d96ddcd()) then
			instance:__wf_atom_e6ed03c8()
		end

		fn2(instance, p)
	end
end

function PlayLocalSound()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_7be51ede = trigger:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and __wf_atom_7be51ede ~= __wf_atom_c4f78a8f then
		return
	end

	if
		inTrigger and trigger:IsTouching(__wf_atom_c4f78a8f)
		or not (inTrigger or trigger:IsTouching(__wf_atom_c4f78a8f))
	then
		if initialDelay > 0 then
			Sleep(initialDelay)
		end

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:PlaySound(sound, false, 0, false)
		end
	end
end

function TriggerTeleportAndFade(object)
	_T.TeleportAndFadeActive = true
	Sleep(initialDelay)
	local __wf_atom_70e8b091 = trigger:__wf_atom_70e8b091()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local isTouching = trigger:IsTouching(__wf_atom_c4f78a8f)

	if __wf_atom_7e8ad928(_T.gTriggerTeleportIndex) then
		_T.gTriggerTeleportIndex = {}
	end

	if
		__wf_atom_7e8ad928(_T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()])
		or #waypoints < _T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()]
	then
		_T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()] = 1
	end

	teleportWaypoint = waypoints[_T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()]]
	_T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()] = _T.gTriggerTeleportIndex[object:__wf_atom_5b41f63b()] + 1

	if isTouching then
		__wf_atom_c4f78a8f:__wf_atom_be6aab9a(false)
		fn3(__wf_atom_c4f78a8f, fadeToChangeTime, fadeToFinalValue)

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			fn2(__wf_atom_c4f78a8f, object)
		end
	end

	if gRegion:IsMaster() then
		for _, v3 in ipairs(__wf_atom_70e8b091) do
			if v3:IsA(WeakResource("/EE/Types/Game/PickUp")) and not __wf_atom_7e8ad928(v3:__wf_atom_3d96ddcd()) then
				v3:__wf_atom_e6ed03c8()
			end

			if not (v3:IsA(__wf_atom_4ebf67cb) and __wf_atom_7e8ad928(v3:__wf_atom_0d9c1a58())) then
				continue
			end

			fn2(v3, object)
		end
	end

	if isTouching then
		Sleep(fullyFadedDuration)

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			return
		else
			fn3(__wf_atom_c4f78a8f, fadeFromChangeTime, fadeFromFinalValue)
		end
	end

	_T.TeleportAndFadeActive = nil
end

function PlayLocalSoundOnInstigator(instance)
	if not (instance:IsA(__wf_atom_67c46eba) and instance:__wf_atom_8efce136()) then
		return
	end

	if initialDelay > 0 then
		Sleep(initialDelay)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:PlaySound(sound, false, 0, false)
	end

	if not (__wf_atom_7e8ad928(toggleTrigger) or __wf_atom_7e8ad928(selfTrigger)) then
		selfTrigger:Disable()
		toggleTrigger:Enable()
	end
end