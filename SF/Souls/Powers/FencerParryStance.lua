local v = Symbol("FencerParryStance")
local v2 = Symbol("BlockingBehavior")
local v3 = Symbol("ParryCounterNextHit")
local v4 = Symbol("ParryCounterPostActionEnable")

function NpcEvaluateAbility(_, object, _)
	if __wf_atom_7e8ad928(object:__wf_atom_30e3d82b():__wf_atom_216d6edd()) then
		return 0
	end

	local __wf_atom_be152500 = object:__wf_atom_d2b2176d():__wf_atom_be152500(0)

	if __wf_atom_7e8ad928(__wf_atom_be152500) or not __wf_atom_be152500:IsA(__wf_atom_77e05d3b) then
		return 0
	end

	return 1
end

local function fn(object, object2) -- 2 equivalent calls inferred from this helper
	local selected

	if __wf_atom_7e8ad928(object2) then
		selected = object:__wf_atom_0e1e5bc9()
	else
		selected = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), object2:__wf_atom_a2a18137())
	end

	selected.pitch = 0
	selected.bank = 0
	return selected
end

function ActivateAbility(_, object, _, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, object)
		__wf_atom_30e3d82b:__wf_atom_4edb59d4(true)
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) and immuneToProcsDuringParry then
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
	end

	if __wf_atom_7e8ad928(loopingAnimation) then
		object:__wf_atom_8914dfde(
			counterBeginningAnimEvent,
			object:__wf_atom_9b5dcd3b(startingAnimation, false, 4, 1, false)
		)
	else
		object:__wf_atom_8914dfde(
			counterBeginningAnimEvent,
			object:__wf_atom_9b5dcd3b(startingAnimation, false, 4, 3, false)
		)
	end

	local totalParryableDuration = totalParryableDuration

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) and immuneToDamageDuringParry then
		__wf_atom_7470861b:__wf_atom_9fba31e6(v, 26, 6, 0)
	end

	object:__wf_atom_51cd6126(v, "OnDamaged")
	object:__wf_atom_7f4035d0(false)

	while object:__wf_atom_c138b19b(startingAnimation, false) do
		while not __wf_atom_7e8ad928(object) and object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() do
			Sleep(0)
		end

		Sleep(0)
	end

	if object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() then
		return
	end

	if not __wf_atom_7e8ad928(loopingAnimation) then
		object:__wf_atom_9b5dcd3b(loopingAnimation, false, 4, 2, false)

		while totalParryableDuration > 0 do
			Sleep(0)
			totalParryableDuration -= __wf_atom_084b3e93()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local v5 = fn(object, __wf_atom_216d6edd) -- inferred equivalent call
					object:__wf_atom_cc999c7b(__wf_atom_216d6edd:__wf_atom_a2a18137())
					object:__wf_atom_51075230(v5)
				end
			end

			if object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() then
				break
			end
		end
	end

	if object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() then
		while not __wf_atom_7e8ad928(object) and object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() do
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local v5 = fn(object, __wf_atom_216d6edd) -- inferred equivalent call
					object:__wf_atom_cc999c7b(__wf_atom_216d6edd:__wf_atom_a2a18137())
					object:__wf_atom_51075230(v5)
				end
			end

			Sleep(0)
		end
	elseif __wf_atom_7e8ad928(endingAnimation) then
		object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
	else
		object:__wf_atom_9b5dcd3b(endingAnimation, false, 4, 1, false)

		while object:__wf_atom_c138b19b(endingAnimation, false) do
			Sleep(0)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_4edb59d4(false)
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v2)
			__wf_atom_30e3d82b:__wf_atom_b34aae35()
			__wf_atom_30e3d82b:__wf_atom_cf391375()
		end
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		if immuneToProcsDuringParry then
			__wf_atom_7470861b:__wf_atom_56b2394e(7, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(4, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(5, v)
		end

		if immuneToDamageDuringParry then
			__wf_atom_7470861b:__wf_atom_63396172(v)
		end
	end

	object:__wf_atom_3ede53b4(v)
	object:__wf_atom_7f4035d0(true)
end

function OnDamaged(object)
	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		local __wf_atom_9d766292 = object:__wf_atom_9d766292()

		if __wf_atom_9d766292:__wf_atom_871aeeac() == 3 then
			gRegion:CreateEntity(
				successfulParryFx,
				object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")),
				__wf_atom_80368bb1,
				object,
				object,
				1
			)
			object:PlaySound(successfulParrySfx, false, 0, true)
			local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

			if
				not __wf_atom_7e8ad928(__wf_atom_679ed446)
				and __wf_atom_679ed446:IsA(__wf_atom_67c46eba)
				and not __wf_atom_7e8ad928(__wf_atom_679ed446:__wf_atom_a96eb2aa())
			then
				local v5 = __wf_atom_679ed446:GetPosition() - object:GetPosition()
				local damageData = Engine.DamageData()
				damageData.baseAmount = 1
				damageData:__wf_atom_7498285f(2, 1)
				damageData:__wf_atom_812165c6(0)
				damageData:__wf_atom_d6f4d914(29, true)
				damageData:__wf_atom_12cf5317(v5)
				__wf_atom_679ed446:__wf_atom_649bf33e(damageData)
			end

			if not gRegion:IsMaster() then
				object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
				return
			end

			if object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() then
				return
			end

			local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

			if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
				local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

				if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
					__wf_atom_30e3d82b:__wf_atom_b414eabf()
					__wf_atom_30e3d82b:__wf_atom_b34aae35()
				end

				object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
				__wf_atom_9fb9a1d6:__wf_atom_01e1d257(successfulParryMeleeAttack)
				local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

				if not __wf_atom_7e8ad928(__wf_atom_66088189) then
					local __wf_atom_be0bea4a = __wf_atom_66088189:__wf_atom_be0bea4a()

					for i = 1, #__wf_atom_be0bea4a do
						if __wf_atom_be0bea4a[i]:__wf_atom_db682341() == v3 then
							__wf_atom_be0bea4a[i]:Destroy()
						end
					end
				end
			end
		end
	end
end

function DoParryCounter(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, object)
		__wf_atom_30e3d82b:__wf_atom_4edb59d4(true)
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		if immuneToDamageDuringParry then
			__wf_atom_7470861b:__wf_atom_9fba31e6(v, 26, 6, 0)
		end

		if immuneToProcsDuringParry then
			__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
			__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
			__wf_atom_7470861b:__wf_atom_1fa97530(4, v)
			__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
		end
	end

	object:__wf_atom_9ca12c31()

	if clearParrySymOnSuccess then
		object:__wf_atom_445bd6e4(v3)
	end

	object:__wf_atom_921c1a5f(postSuccessfulParryAnimation, true, 4, 1, true)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			__wf_atom_9fb9a1d6:__wf_atom_01e1d257(successfulParryMeleeAttack)
		end
	end

	Sleep(0)

	while object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_4edb59d4(false)
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v2)
		__wf_atom_30e3d82b:__wf_atom_b34aae35()
		__wf_atom_30e3d82b:__wf_atom_cf391375()
	end

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		if immuneToProcsDuringParry then
			__wf_atom_7470861b:__wf_atom_56b2394e(7, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(4, v)
			__wf_atom_7470861b:__wf_atom_56b2394e(5, v)
		end

		if immuneToDamageDuringParry then
			__wf_atom_7470861b:__wf_atom_63396172(v)
		end
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetBlackboardBool(v4, true)
		object:__wf_atom_c7512a3d()
		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			__wf_atom_9fb9a1d6:__wf_atom_01e1d257(successfulParryMeleeAttack)
			local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				local __wf_atom_be0bea4a = __wf_atom_66088189:__wf_atom_be0bea4a()

				for i = 1, #__wf_atom_be0bea4a do
					if __wf_atom_be0bea4a[i]:__wf_atom_db682341() == v3 then
						__wf_atom_be0bea4a[i]:Destroy()
					end
				end
			end
		end
	end
end

function OnDamageAvatarScript(object)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
		or not object:__wf_atom_348d7b5c(v3)
	then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_9d766292:__wf_atom_871aeeac() == 3 and not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if
			not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and __wf_atom_9fb9a1d6:__wf_atom_aab55bea()
			or not __wf_atom_7e8ad928(postSuccessfulParryAnimation)
			and object:__wf_atom_c138b19b(postSuccessfulParryAnimation)
		then
			gRegion:CreateEntity(
				successfulParryFx,
				object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")),
				__wf_atom_80368bb1,
				object,
				object,
				1
			)
			object:PlaySound(successfulParrySfx, false, 0, true)
			local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

			if
				not __wf_atom_7e8ad928(__wf_atom_679ed446)
				and __wf_atom_679ed446:IsA(__wf_atom_67c46eba)
				and not __wf_atom_7e8ad928(__wf_atom_679ed446:__wf_atom_a96eb2aa())
			then
				local v5 = __wf_atom_679ed446:GetPosition() - object:GetPosition()
				local damageData = Engine.DamageData()
				damageData.baseAmount = 1
				damageData:__wf_atom_7498285f(2, 1)
				damageData:__wf_atom_812165c6(0)
				damageData:__wf_atom_d6f4d914(29, true)
				damageData:__wf_atom_12cf5317(v5)
				__wf_atom_679ed446:__wf_atom_649bf33e(damageData)
			end
		end

		if object:__wf_atom_d2b2176d():__wf_atom_9f71ab59() then
			return
		end

		if
			__wf_atom_7e8ad928(__wf_atom_9fb9a1d6)
			or not __wf_atom_9fb9a1d6:__wf_atom_aab55bea()
			or not __wf_atom_7e8ad928(postSuccessfulParryAnimation)
			and object:__wf_atom_c138b19b(postSuccessfulParryAnimation)
		then
			object:__wf_atom_445bd6e4(v3)
		else
			local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_b414eabf()
				__wf_atom_30e3d82b:__wf_atom_b34aae35()
			end

			object:__wf_atom_8a035cd5(Symbol("DoParryCounter"), false)
		end
	end
end

function FencerParryUpdater(object)
	Sleep(0)
	local v5 = nil
	local v6 = false

	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		if __wf_atom_7e8ad928(v5) then
			v5 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
		end

		if not (object:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(v5)) then
			local __wf_atom_aab55bea = v5:__wf_atom_aab55bea()

			if __wf_atom_aab55bea ~= v6 then
				if not __wf_atom_aab55bea then
					object:__wf_atom_445bd6e4(v3)
					object:__wf_atom_c7512a3d()
					local __wf_atom_66088189 = v5:__wf_atom_66088189(1, 0)

					if not __wf_atom_7e8ad928(__wf_atom_66088189) then
						local __wf_atom_be0bea4a = __wf_atom_66088189:__wf_atom_be0bea4a()

						for i = 1, #__wf_atom_be0bea4a do
							if __wf_atom_be0bea4a[i]:__wf_atom_db682341() == v3 then
								__wf_atom_be0bea4a[i]:Destroy()
							end
						end
					end
				end

				v6 = __wf_atom_aab55bea
			end
		end

		Sleep(0.1)
	end
end