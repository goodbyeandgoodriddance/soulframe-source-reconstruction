local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.PlayerPetLib")
local v = WeakResource("/SF/Weapons/OneOffWeapons/WolfPupStick/WolfCubStickWeapon")
local lastThrownFetchStickPickup = nil
local v2 = nil
local v3 = nil
local v4 = Rotation(-90, 30, 0)
local v5 = Vector(0, 0.3, 0)
local v6 = nil

function Evaluate(object, _)
	v2 = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(v2) or object:__wf_atom_9af7625d(v2) < 1 then
		return false
	end

	if object:__wf_atom_c138b19b(fetchIdleStart, true) or object:__wf_atom_c138b19b(fetchIdleLoop, true) then
		object:__wf_atom_921c1a5f(nil, false)
	end

	local __wf_atom_35a10d3c = v2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(v) then
		local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
		local flag

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup)
			or not (object:__wf_atom_a5304c35(__wf_atom_e919fb8e.lastThrownFetchStickPickup:GetPosition()) <= serchingRange)
		then
			flag = false
		else
			lastThrownFetchStickPickup = __wf_atom_e919fb8e.lastThrownFetchStickPickup
			flag = true
		end

		if flag then
			return true
		end

		local v7 = v2
		local thrownFetchStick

		if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
			if not __wf_atom_7e8ad928(v7) then
				local __wf_atom_e919fb8e2 = v7:__wf_atom_e919fb8e()

				if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.lastThrownFetchStickPickup) then
					if not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.thrownFetchStick) then
						thrownFetchStick = __wf_atom_e919fb8e2.thrownFetchStick
					end
				else
					thrownFetchStick = __wf_atom_e919fb8e2.lastThrownFetchStickPickup
				end
			end
		else
			thrownFetchStick = lastThrownFetchStickPickup
		end

		if thrownFetchStick == nil then
			return false
		end

		if gRegion:__wf_atom_2202ffb6():__wf_atom_417a583d(thrownFetchStick:GetPosition(), 1, 2, -2) then
			return true
		end

		if not __wf_atom_7e8ad928(v2) then
			local __wf_atom_e919fb8e_2 = v2:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.lastThrownFetchStickPickup = nil
		end

		return false
	elseif v2:__wf_atom_08998754() == 2 or v2:__wf_atom_ee4f0cba() > 1 then
		return false
	else
		return not (object:__wf_atom_9af7625d(v2) > maxDistanceFromPlayerForAnticipation * maxDistanceFromPlayerForAnticipation)
	end
end

local function fn(object, object2)
	local total = 0
	local total2 = 0
	local flag = false

	while not (__wf_atom_7e8ad928(v2) or v2:IsKilled()) do
		local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
		local flag2

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup)
			or not (object2:__wf_atom_a5304c35(__wf_atom_e919fb8e.lastThrownFetchStickPickup:GetPosition()) <= serchingRange)
		then
			flag2 = false
		else
			lastThrownFetchStickPickup = __wf_atom_e919fb8e.lastThrownFetchStickPickup
			flag2 = true
		end

		if flag2 then
			return true
		end

		local thrownFetchStick = lastThrownFetchStickPickup

		if __wf_atom_7e8ad928(thrownFetchStick) then
			thrownFetchStick = v2:__wf_atom_e919fb8e().thrownFetchStick
		end

		if not __wf_atom_7e8ad928(thrownFetchStick) then
			return true
		end

		local __wf_atom_35a10d3c = v2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(v) then
			total += __wf_atom_084b3e93()

			if total > 0.5 then
				return false
			end
		end

		if v2:__wf_atom_08998754() == 2 and v2:__wf_atom_ee4f0cba() > 1 then
			total2 += __wf_atom_084b3e93()

			if giveUpOnPlayerRunningTimeout <= total2 then
				return false
			end
		else
			total2 = 0
		end

		if
			object2:__wf_atom_9af7625d(v2) > maxDistanceFromPlayerForAnticipation * maxDistanceFromPlayerForAnticipation
			or object2:__wf_atom_9af7625d(v2) < 1
		then
			object:StartMoving(v2:GetPosition(), 1, false, 1, maxDistanceFromPlayerForAnticipation * 0.5, false)

			if object2:__wf_atom_c138b19b(fetchIdleStart, true) or object2:__wf_atom_c138b19b(fetchIdleLoop, true) then
				object2:__wf_atom_921c1a5f(nil, false)
			end

			return false
		else
			if flag then
				object2:__wf_atom_84d66e8e(__wf_atom_fa8d0177(object2:GetPosition(), v2:GetPosition()))
			else
				flag = true

				if
					v2:__wf_atom_ee4f0cba() < 1
					and not (__wf_atom_7e8ad928(fetchIdleStart) or __wf_atom_7e8ad928(fetchIdleLoop))
				then
					object:__wf_atom_b414eabf()
					object2:__wf_atom_84d66e8e(__wf_atom_fa8d0177(object2:GetPosition(), v2:GetPosition()))
					object2:__wf_atom_921c1a5f(fetchIdleStart, true, 2, 3, false)
					object2:__wf_atom_921c1a5f(fetchIdleLoop, false, 2, 2, false)
				end
			end

			Sleep(0)
		end
	end

	return false
end

local function fn2(object, object2)
	if
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(fetchIdleLoop)
		and object2:__wf_atom_c138b19b(fetchIdleLoop, true)
	then
		local __wf_atom_2f2bada0 = v2:__wf_atom_2f2bada0()
		local __wf_atom_2f2bada0_2 = object2:__wf_atom_2f2bada0()
		local heading = __wf_atom_2f2bada0.heading
		local heading2 = __wf_atom_2f2bada0_2.heading

		if heading - heading2 > 180 then
			heading -= 360
		end

		if heading - heading2 < -180 then
			heading += 360
		end

		if math.abs(heading - heading2) > angleToPlayFetchTurn then
			object2:__wf_atom_921c1a5f(fetchIdleStartRun, false, 4, 1, true)
		else
			object2:__wf_atom_921c1a5f(nil, false)
		end
	end

	local thrownFetchStick = lastThrownFetchStickPickup

	if __wf_atom_7e8ad928(thrownFetchStick) then
		thrownFetchStick = v2:__wf_atom_e919fb8e().thrownFetchStick
	end

	if __wf_atom_7e8ad928(thrownFetchStick) then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	Sleep(0)
	Sleep(0)
	local total = 0

	while not __wf_atom_7e8ad928(thrownFetchStick) do
		thrownFetchStick = lastThrownFetchStickPickup

		if __wf_atom_7e8ad928(thrownFetchStick) then
			thrownFetchStick = v2:__wf_atom_e919fb8e().thrownFetchStick
		end

		if Length(thrownFetchStick:__wf_atom_278a2d05()) < 0.1 then
			break
		end

		local v7 = Vector()
		local position = thrownFetchStick:GetPosition()
		local v8 = thrownFetchStick:__wf_atom_278a2d05() * 2 + position

		if gRegion:Raycast(v8, v8 + Vector(0, -10, 0), nil, nil, v7, true) then
			v8 = v7
		end

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			v8 = __wf_atom_7d789620:__wf_atom_0e0a6fee(v8)
		end

		object:StartMoving(v8, 2, false, 1, movementStopDistance * 0.5, false)
		total += __wf_atom_084b3e93()

		if thrownStickTimeoutTime < total then
			return false
		end

		object:__wf_atom_f8fa00b4(thrownFetchStick)
		Sleep(0)
	end

	local v7 = v2
	local thrownFetchStick2

	if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_e919fb8e = v7:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup) then
				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.thrownFetchStick) then
					thrownFetchStick2 = __wf_atom_e919fb8e.thrownFetchStick
				end
			else
				thrownFetchStick2 = __wf_atom_e919fb8e.lastThrownFetchStickPickup
			end
		end
	else
		thrownFetchStick2 = lastThrownFetchStickPickup
	end

	if __wf_atom_7e8ad928(thrownFetchStick2) then
		return false
	end

	thrownFetchStick2:GetPosition()

	if not __wf_atom_7e8ad928(thrownFetchStick2) then
		local position = thrownFetchStick2:GetPosition()

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			position = __wf_atom_7d789620:__wf_atom_0e0a6fee(position)
		end

		object:StartMoving(position, 2, false, 1, distToPickUpStick / 2, false)
		object:__wf_atom_f8fa00b4(thrownFetchStick2)
	end

	while
		not __wf_atom_7e8ad928(thrownFetchStick2)
		and not __wf_atom_7e8ad928(object)
		and object2:__wf_atom_9af7625d(thrownFetchStick2) > distToPickUpStick * distToPickUpStick
	do
		local position = thrownFetchStick2:GetPosition()

		if gRegion:__wf_atom_2202ffb6():__wf_atom_417a583d(position, 1, 2, -2) then
			if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
				position = __wf_atom_7d789620:__wf_atom_0e0a6fee(position)
			end

			object:StartMoving(position, 2, false, 1, distToPickUpStick / 2, false)
			object:__wf_atom_f8fa00b4(thrownFetchStick2)
			Sleep(0)
			local v8 = v2

			if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
				if __wf_atom_7e8ad928(v8) then
					thrownFetchStick2 = nil
				else
					local __wf_atom_e919fb8e = v8:__wf_atom_e919fb8e()

					if __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup) then
						if __wf_atom_7e8ad928(__wf_atom_e919fb8e.thrownFetchStick) then
							thrownFetchStick2 = nil
						else
							thrownFetchStick2 = __wf_atom_e919fb8e.thrownFetchStick
						end
					else
						thrownFetchStick2 = __wf_atom_e919fb8e.lastThrownFetchStickPickup
					end
				end
			else
				thrownFetchStick2 = lastThrownFetchStickPickup
			end
		else
			if not __wf_atom_7e8ad928(v2) then
				local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.lastThrownFetchStickPickup = nil
			end

			return false
		end
	end

	if __wf_atom_7e8ad928(thrownFetchStick2) then
		local v8 = v2

		if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
			if __wf_atom_7e8ad928(v8) then
				thrownFetchStick2 = nil
			else
				local __wf_atom_e919fb8e = v8:__wf_atom_e919fb8e()

				if __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup) then
					if __wf_atom_7e8ad928(__wf_atom_e919fb8e.thrownFetchStick) then
						thrownFetchStick2 = nil
					else
						thrownFetchStick2 = __wf_atom_e919fb8e.thrownFetchStick
					end
				else
					thrownFetchStick2 = __wf_atom_e919fb8e.lastThrownFetchStickPickup
				end
			end
		else
			thrownFetchStick2 = lastThrownFetchStickPickup
		end

		if
			__wf_atom_7e8ad928(thrownFetchStick2)
			or object2:__wf_atom_9af7625d(thrownFetchStick2) > distToPickUpStick * distToPickUpStick
		then
			return false
		end
	end

	object2:__wf_atom_921c1a5f(grabStickAnimation, false, 4, 1, false)
	object:__wf_atom_b414eabf()
	object2:__wf_atom_8914dfde("PickUpStick", 1)

	if __wf_atom_7e8ad928(thrownFetchStick2) then
		return false
	end

	local __wf_atom_bb3e7833 = thrownFetchStick2:__wf_atom_bb3e7833(__wf_atom_465d956f)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	object2:AttachEntity(thrownFetchStick2, Symbol("GAME_C1_WEAPON"), Vector(0, -0.2, 0), Rotation(90, 0, 0))
	v3 = module.FindTaggedChild(thrownFetchStick2:__wf_atom_be0bea4a(), Symbol("PickUpFx"))

	if not __wf_atom_7e8ad928(v3) then
		v3:SetVisibility(false, true)
		v3:Disable()
	end

	if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(thrownFetchStick2)) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(
			Symbol("WOLF_FETCH"),
			thrownFetchStick2:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
		)
	end

	return true
end

function ReturnToOwner(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return false
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local position = v2:GetPosition()
	object:StartMoving(position, 2, false, 1, offsetDistanceFromOwnerForStickDrop, false)

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(v2)
		and object2:__wf_atom_c215662d(position) > math.pow(
			movementStopDistance + offsetDistanceFromOwnerForStickDrop,
			2
		)
	do
		position = v2:GetPosition()

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			position = __wf_atom_7d789620:__wf_atom_0e0a6fee(position)
		end

		object:StartMoving(position, 2, false, 1, offsetDistanceFromOwnerForStickDrop, false)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_b414eabf()
	end

	return true
end

function ApplyTorque(object)
	Sleep(0)

	if not __wf_atom_7e8ad928((object:__wf_atom_4dfc315a())) then
		return
	end

	local v7 = Vector()
	v7.y = -15
	object:ApplyTorque(__wf_atom_9341614d(v7, object:__wf_atom_2f2bada0()), 2)
end

function ThrowPickup(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_ce9f0833 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_ce9f0833(4)

	if __wf_atom_7e8ad928(__wf_atom_ce9f0833) then
		return
	end

	object:__wf_atom_017e8c6b(true)
	__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_b9375444(false)
	local __wf_atom_414f70dd = __wf_atom_21ed1a39:__wf_atom_414f70dd(0)

	if not __wf_atom_7e8ad928(__wf_atom_414f70dd) and __wf_atom_414f70dd:IsA(__wf_atom_f8238f9d) then
		__wf_atom_414f70dd:__wf_atom_275f9d34()
	end

	if gRegion:IsMaster() then
		local v7 = Symbol("GAME_R1_WEAPON1")
		local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(v7)
		local __wf_atom_a06d543c = __wf_atom_6009c8ed:__wf_atom_a06d543c()

		if __wf_atom_6009c8ed:__wf_atom_a96eb2aa() then
			__wf_atom_a06d543c = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_74d951b0() - __wf_atom_1c374cc9
			Normalize(__wf_atom_a06d543c)
		end

		local __wf_atom_75a0566d = __wf_atom_21ed1a39:__wf_atom_75a0566d()

		if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
			local __wf_atom_fe33ffd0 = __wf_atom_75a0566d:__wf_atom_fe33ffd0()

			if not __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
				local __wf_atom_3b3a2be6 = __wf_atom_fe33ffd0:__wf_atom_3b3a2be6(Symbol("ThrowPickUp"), 0)

				if __wf_atom_3b3a2be6 >= 0 then
					local __wf_atom_3ef82711 = __wf_atom_fe33ffd0:__wf_atom_3ef82711(__wf_atom_6009c8ed)

					if __wf_atom_6009c8ed:__wf_atom_ba6fe6a7(
						v7,
						__wf_atom_3ef82711,
						__wf_atom_3b3a2be6,
						__wf_atom_1c374cc9
					) then
						local v8 = Rotation()

						if __wf_atom_6009c8ed:__wf_atom_4c15ba90(v7, __wf_atom_3ef82711, __wf_atom_3b3a2be6, v8) then
							__wf_atom_1c374cc9 += __wf_atom_9341614d(v5, v8)
						end
					end
				end
			end
		end

		local v8 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_74d951b0())
		local v9 = __wf_atom_d919c2d7(v8, v4)
		local entity = gRegion:CreateEntity(__wf_atom_ce9f0833, __wf_atom_1c374cc9, v9, __wf_atom_6009c8ed)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_7ebba814(__wf_atom_6009c8ed)
			entity:__wf_atom_34a8a27a(__wf_atom_6009c8ed)
			local v10 = __wf_atom_a1467d4b(__wf_atom_a06d543c, Vector(0, 1, 0), 20)
			entity:__wf_atom_66d7a6a9(v10 * 20, 2)
			entity:__wf_atom_276fe711(v10 * 20)
			local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.lastThrownFetchStickPickup = entity
		end
	end

	while not __wf_atom_7e8ad928(__wf_atom_21ed1a39) and __wf_atom_21ed1a39:GetState() == 1 do
		Sleep(0)
	end

	if
		gRegion:IsMaster()
		and not (__wf_atom_7e8ad928(__wf_atom_21ed1a39) or __wf_atom_7e8ad928(__wf_atom_6009c8ed))
	then
		local __wf_atom_97d575cf = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_97d575cf(4)

		if not __wf_atom_7e8ad928(__wf_atom_97d575cf) and __wf_atom_97d575cf == __wf_atom_21ed1a39 then
			__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_6cdc5077()
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_b9375444(true)
	end
end

function Sit(object, object2)
	if __wf_atom_7e8ad928(lastThrownFetchStickPickup) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return false
	end

	if not (__wf_atom_7e8ad928(lastThrownFetchStickPickup) or __wf_atom_7e8ad928(fetchDrop)) then
		object2:__wf_atom_921c1a5f(fetchDrop, false, 4, 1, false)
		object2:__wf_atom_8914dfde("Drop", 1)

		if not __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
			lastThrownFetchStickPickup:__wf_atom_e6ed03c8()
			lastThrownFetchStickPickup:Teleport(
				lastThrownFetchStickPickup:GetPosition(),
				lastThrownFetchStickPickup:__wf_atom_dc309f8a()
			)
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:SetVisibility(true, true)
			v3:Enable()
		end

		while object2:__wf_atom_c138b19b(fetchDrop) do
			Sleep(0)
		end
	end

	object2:__wf_atom_921c1a5f(idleToSit, false, 4, 3, true)
	Sleep(0)

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(lastThrownFetchStickPickup)
		and object2:__wf_atom_c138b19b(idleToSit)
	do
		Sleep(0)
	end

	local v7 = object2:Attach(pettingCine[__wf_atom_5784a397(1, #pettingCine)], EMPTY_SYMBOL)
	local v8 = object2:Attach(pettingCTX, EMPTY_SYMBOL, Vector(0, 0, 2))

	if not __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
		object2:__wf_atom_921c1a5f(SitLoop, false, 4, 2, true)
		local count = 0

		while count < petRewardTimer do
			count += 1

			if
				(__wf_atom_7e8ad928(v7) or not v7:__wf_atom_7d4910e4())
				and not __wf_atom_7e8ad928(lastThrownFetchStickPickup)
			then
				Sleep(1)
			else
				break
			end
		end
	end

	local v9

	if not __wf_atom_7e8ad928(v2) then
		v9 = v2:__wf_atom_a96eb2aa()
	end

	if not __wf_atom_7e8ad928(v9) then
		local v10 = __wf_atom_5784a397(traningThresholdRange.minValue, traningThresholdRange.maxValue)

		if __wf_atom_7e8ad928(v6.FetchCount) or not (v10 <= v6.FetchCount) then
			v6.FetchCount += 1
		else
			module2.TrainPet(v9, 3, staminaCooldownTimer)
			v6.FetchCount = 0
		end
	end

	if not __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
		if v7:__wf_atom_7d4910e4() then
			while v7:__wf_atom_7d4910e4() and not __wf_atom_7e8ad928(lastThrownFetchStickPickup) do
				Sleep(0.5)
			end

			object2:__wf_atom_921c1a5f(StandIdle, false, 4, 1, false)
		else
			object2:__wf_atom_921c1a5f(sitToIdle, false, 4, 3, false)
			Sleep(0)

			while
				not __wf_atom_7e8ad928(object2)
				and object2:__wf_atom_c138b19b(sitToIdle)
				and not __wf_atom_7e8ad928(lastThrownFetchStickPickup)
			do
				Sleep(0)
			end

			object2:__wf_atom_921c1a5f(StandIdle, false, 4, 2, false)
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.lastThrownFetchStickPickup = nil
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Destroy()
	end

	lastThrownFetchStickPickup = nil
	object:__wf_atom_24ddbdc3()
	return true
end

function Activate(object, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v7 = v2
	local thrownFetchStick

	if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_e919fb8e = v7:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup) then
				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.thrownFetchStick) then
					thrownFetchStick = __wf_atom_e919fb8e.thrownFetchStick
				end
			else
				thrownFetchStick = __wf_atom_e919fb8e.lastThrownFetchStickPickup
			end
		end
	else
		thrownFetchStick = lastThrownFetchStickPickup
	end

	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()
	module2.SetCanPet(__wf_atom_6115a2e2:__wf_atom_a96eb2aa(), false, "Fetching")
	v6 = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(v6.FetchCount) then
		v6.FetchCount = 0
	end

	if __wf_atom_7e8ad928(thrownFetchStick) or thrownFetchStick:__wf_atom_f7e7be53() ~= object then
		if not fn(__wf_atom_30e3d82b, object) then
			return
		end

		if fn2(__wf_atom_30e3d82b, object) then
			object:__wf_atom_086a7266()
			ReturnToOwner(__wf_atom_30e3d82b, object)
			Sit(__wf_atom_30e3d82b, object)
		end
	else
		lastThrownFetchStickPickup = thrownFetchStick
		ReturnToOwner(__wf_atom_30e3d82b, object)
		Sit(__wf_atom_30e3d82b, object)
	end
end

function Deactivate(object, _)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(nil, false)
		object:__wf_atom_086a7266()
		local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()
		local thrownFetchStick

		if __wf_atom_7e8ad928(lastThrownFetchStickPickup) then
			if not __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
				local __wf_atom_e919fb8e = __wf_atom_6115a2e2:__wf_atom_e919fb8e()

				if __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastThrownFetchStickPickup) then
					if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.thrownFetchStick) then
						thrownFetchStick = __wf_atom_e919fb8e.thrownFetchStick
					end
				else
					thrownFetchStick = __wf_atom_e919fb8e.lastThrownFetchStickPickup
				end
			end
		else
			thrownFetchStick = lastThrownFetchStickPickup
		end

		module2.SetCanPet(__wf_atom_6115a2e2:__wf_atom_a96eb2aa(), true, "Fetching")

		if
			not __wf_atom_7e8ad928(thrownFetchStick)
			and thrownFetchStick:__wf_atom_f7e7be53() == object
			and (__wf_atom_7e8ad928(__wf_atom_6115a2e2) or __wf_atom_6115a2e2:__wf_atom_9af7625d(object) < math.pow(
				offsetDistanceFromOwnerForStickDrop + movementStopDistance,
				2
			))
		then
			thrownFetchStick:__wf_atom_e6ed03c8()
			thrownFetchStick:Teleport(thrownFetchStick:GetPosition(), thrownFetchStick:__wf_atom_dc309f8a())

			if not __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
				local __wf_atom_e919fb8e = __wf_atom_6115a2e2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.lastThrownFetchStickPickup = nil
			end
		end
	end
end

function PickupWorldStick(object, object2, p)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	if not __wf_atom_7e8ad928((object2:__wf_atom_3d96ddcd())) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_921c1a5f(grabStickAnimation, false, 4, 1, false)
	__wf_atom_30e3d82b:__wf_atom_b414eabf()
	object:__wf_atom_8914dfde("PickUpStick", 1)

	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(__wf_atom_465d956f)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	object:AttachEntity(object2, Symbol("GAME_C1_WEAPON"), Vector(0, -0.2, 0), Rotation(90, 0, 0))
	v3 = module.FindTaggedChild(object2:__wf_atom_be0bea4a(), Symbol("PickUpFx"))

	if not __wf_atom_7e8ad928(v3) then
		v3:SetVisibility(false, true)
		v3:Disable()
	end
end

function DropStick(object, object2, _)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(fetchDrop) then
		return false
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(fetchDrop, false, 4, 1, false)
		object:__wf_atom_8914dfde("Drop", 1)
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_e6ed03c8()
		object2:Teleport(object2:GetPosition(), object2:__wf_atom_dc309f8a())
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:SetVisibility(true, true)
		v3:Enable()
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(fetchDrop) do
		Sleep(0)
	end

	return true
end