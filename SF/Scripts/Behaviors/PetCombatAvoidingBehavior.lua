require("SF.Scripts.Libs.PlayerPetLib")
local v = 1
local v2 = nil
local v3 = -10000
local total = 0
local position = nil
local v4 = nil
local maxValue = -1
local v5 = nil

local function fn(object, instance)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if not __wf_atom_7e8ad928(object:__wf_atom_216d6edd()) then
		local __wf_atom_30e3d82b = object:__wf_atom_216d6edd():__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_351e924e() then
			if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
				v3 = __wf_atom_7d789620:__wf_atom_72261e9c()
			end

			return true
		end
	end

	local __wf_atom_14bb6996 = object:__wf_atom_14bb6996()

	for i = 1, #__wf_atom_14bb6996 do
		if __wf_atom_7e8ad928(__wf_atom_14bb6996[i].avatar) then
			continue
		end

		local __wf_atom_30e3d82b = __wf_atom_14bb6996[i].avatar:__wf_atom_30e3d82b()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or not __wf_atom_30e3d82b:__wf_atom_351e924e()
			or not (__wf_atom_14bb6996[i].distanceToTarget < maxEnemyDistanceToCare)
		then
			continue
		end

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			v3 = __wf_atom_7d789620:__wf_atom_72261e9c()
		end

		return true
	end

	if
		not __wf_atom_7e8ad928(__wf_atom_7d789620)
		and __wf_atom_7d789620:__wf_atom_72261e9c() - v3 < delayToReturnToNonCombatState
	then
		return true
	end

	if
		__wf_atom_7e8ad928(instance)
		or not (instance:IsA(__wf_atom_ee1ed4db) and instance:__wf_atom_2f24c2df() < delayToReturnToNonCombatState)
	then
		return object:__wf_atom_211da8d8() < delayToReturnToNonCombatState
	end

	return true
end

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v6

	if not __wf_atom_7e8ad928(object) then
		v6 = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v6) then
			v6 = gRegion:__wf_atom_c4f78a8f()
		end
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(v6) or not fn(__wf_atom_30e3d82b, object) then
		return false
	end

	local __wf_atom_a96eb2aa = v6:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return false
	end

	v5 = __wf_atom_a96eb2aa:__wf_atom_4febbf37()
	return v6:__wf_atom_08998754() ~= 2 or not (v6:__wf_atom_ee4f0cba() > 1)
end

function StartTacPosQuery(object, _)
	local v6

	if not __wf_atom_7e8ad928(object) then
		v6 = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v6) then
			v6 = gRegion:__wf_atom_c4f78a8f()
		end
	end

	if __wf_atom_7e8ad928(v6) then
		return false
	end

	local position2 = object:GetPosition()
	total = 0
	local position3 = v6:GetPosition()
	local v7 = consideredMovePosRange.maxValue * 0.2
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
	v4:__wf_atom_267bfc41(position3, consideredMovePosRange, v7)
	v4:__wf_atom_62a3e89b(20, 30, -30)
	v4:__wf_atom_4a7833f4()
	v4:__wf_atom_655394dc()
	v4:__wf_atom_06c7577b()
	v4:__wf_atom_7e9d12f8(40)
	v4:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	v4:__wf_atom_bacad54b()
	v4:__wf_atom_9699b67c(false)
	v4:__wf_atom_09d2b44e(false)
	v4:__wf_atom_a49949e0(Symbol("PetCombatBehavior"), Color("0xFF00FF"))
	v4:__wf_atom_0f52bdf4(position3, distanceFromPlayerDuringCombat, -1, 1, 1, 0, false)
	v4:__wf_atom_37c09cee(position3, Range(moveIfTooCloseDistanceFromPlayer, 3.4028234663852886e38))
	v4:__wf_atom_0f52bdf4(position2, Range(0, maxEnemyDistanceToCare), -1, 1, 1, 0, false)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		local __wf_atom_d8853f2a = __wf_atom_30e3d82b:__wf_atom_d8853f2a()
		local v8 = 6

		for i = 1, #__wf_atom_d8853f2a do
			if __wf_atom_7e8ad928(__wf_atom_d8853f2a[i].entity) then
				continue
			end

			v4:__wf_atom_37c09cee(
				__wf_atom_d8853f2a[i].entity:GetPosition(),
				Range(moveIfTooCloseDistanceFromEnemies, 3.4028234663852886e38)
			)
			v8 -= 1

			if v8 <= 0 then
				break
			end
		end

		local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

		if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
			local v9 = position2 - __wf_atom_216d6edd:GetPosition()
			v9.y = 0
			Normalize(v9)
			v4:__wf_atom_9b7f7161(position2, v9, 1, 1, -0.9, 0, false)
		end
	end

	v4:Start()
	return true
end

function SetResponseAnim(object)
	local v6

	if not __wf_atom_7e8ad928(object) then
		v6 = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v6) then
			v6 = gRegion:__wf_atom_c4f78a8f()
		end
	end

	if __wf_atom_7e8ad928(v6) then
		return
	end

	local __wf_atom_a96eb2aa = v6:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	for k, v7 in pairs(responseStatLevel) do
		if not (__wf_atom_a96eb2aa:__wf_atom_4fec12f3(v) <= v7) then
			continue
		end

		v2 = reponseAnims[k]
		break
	end
end

function Activate(p, p2)
	StartTacPosQuery(p, p2)
	position = nil
	total = 0
	maxValue = -1
	SetResponseAnim(p)

	if distanceFromPlayerDuringCombat.maxValue > moveIfTooFarDistanceFromPlayer then
		distanceFromPlayerDuringCombat.maxValue = moveIfTooFarDistanceFromPlayer
	end

	if distanceFromPlayerDuringCombat.minValue < moveIfTooCloseDistanceFromPlayer then
		distanceFromPlayerDuringCombat.minValue = moveIfTooCloseDistanceFromPlayer
	end
end

function Update(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not fn(__wf_atom_30e3d82b, object) then
		return true
	end

	local v6

	if not __wf_atom_7e8ad928(object) then
		v6 = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v6) then
			v6 = gRegion:__wf_atom_c4f78a8f()
		end
	end

	if __wf_atom_7e8ad928(v6) then
		return false
	end

	if not __wf_atom_7e8ad928(v4) and v4:__wf_atom_2ddd6354() then
		local __wf_atom_5802ff81 = v4:__wf_atom_5802ff81()

		if #__wf_atom_5802ff81 > 0 then
			position = __wf_atom_5802ff81[1]
			maxValue = -1
		else
			position = v6:GetPosition()
			maxValue = distanceFromPlayerDuringCombat.maxValue
		end

		v4 = nil
	end

	if position == nil then
		total += p2
	else
		local stopDistance2 = stopDistance

		if maxValue > 0 then
			stopDistance2 = maxValue
		end

		local v7 = object:__wf_atom_c215662d(position) <= stopDistance2 * stopDistance2

		if v7 or __wf_atom_30e3d82b:__wf_atom_46292900() then
			if v7 then
				__wf_atom_30e3d82b:__wf_atom_b414eabf()
				local position2 = nil

				if __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_216d6edd()) then
					if not __wf_atom_7e8ad928(v6) then
						position2 = v6:GetPosition()
					end
				else
					position2 = __wf_atom_30e3d82b:__wf_atom_216d6edd():GetPosition()
				end

				object:__wf_atom_84d66e8e((__wf_atom_fa8d0177(object:GetPosition(), position2)))
				total += p2

				if
					not __wf_atom_7e8ad928(v2)
					and not object:__wf_atom_c138b19b(v2, true)
					and __wf_atom_a6515464(object:GetPosition(), object:__wf_atom_0e1e5bc9(), position2) < angleToTargetToBark
				then
					object:__wf_atom_921c1a5f(v2, false, 2, 2, false)
				end
			end
		else
			if maxValue <= 0 then
				__wf_atom_30e3d82b:StartMoving(position, moveStyle, false, 1, stopDistance, false)
			else
				__wf_atom_30e3d82b:StartMoving(position, moveStyle, false, 1, maxValue, false)
			end

			if not __wf_atom_7e8ad928(v2) and object:__wf_atom_c138b19b(v2, true) then
				object:__wf_atom_921c1a5f(nil, false, 2, 2, false)
			end
		end
	end

	if total >= repositionCheckInterval and (__wf_atom_7e8ad928(v4) or v4:__wf_atom_2ddd6354()) then
		local __wf_atom_9af7625d = object:__wf_atom_9af7625d(v6)

		if
			__wf_atom_9af7625d < moveIfTooCloseDistanceFromPlayer * moveIfTooCloseDistanceFromPlayer
			or moveIfTooFarDistanceFromPlayer * moveIfTooFarDistanceFromPlayer < __wf_atom_9af7625d
		then
			StartTacPosQuery(object, p)
			return
		end

		local __wf_atom_d8853f2a = __wf_atom_30e3d82b:__wf_atom_d8853f2a()

		for i = 1, #__wf_atom_d8853f2a do
			if
				not (__wf_atom_d8853f2a[i].distanceToTarget <= moveIfTooCloseDistanceFromEnemies)
				or __wf_atom_7e8ad928(__wf_atom_d8853f2a[i].entity)
				or not __wf_atom_d8853f2a[i].entity:IsA(__wf_atom_67c46eba)
			then
				continue
			end

			if not (not __wf_atom_d8853f2a[i].entity:__wf_atom_7b82e9e1(12) or __wf_atom_d8853f2a[i].entity:__wf_atom_7b82e9e1(14)) then
				continue
			end

			StartTacPosQuery(object, p)
			return
		end
	end
end

function Deactivate(object, _)
	if not __wf_atom_7e8ad928(object) then
		for i = 1, #reponseAnims do
			if __wf_atom_7e8ad928(reponseAnims[i]) or not object:__wf_atom_c138b19b(reponseAnims[i], true) then
				continue
			end

			object:__wf_atom_921c1a5f(nil, false, 2, 2, false)
			return
		end
	end
end