require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("LastEnergyBladeAbility")

local function fn(avatar) -- 1 equivalent call inferred from this helper
	local __wf_atom_4e50d390 = avatar:__wf_atom_4e50d390()
	__wf_atom_4e50d390.pitch = 0
	__wf_atom_4e50d390.bank = 0
	return __wf_atom_e97f3142(__wf_atom_4e50d390)
end

local function fn2(position, p, object) -- 1 equivalent call inferred from this helper
	local position2 = object:GetPosition()
	position2.y = position.y
	local v2 = position2 - position
	Normalize(v2)
	return __wf_atom_d08b2f29(p, v2) <= npcAllowableTargetFov
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v2 = Time()
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if
		v2 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v) < npcCoordinatedCooldown
		or (__wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f() or not (__wf_atom_9a1e4ed3.distanceToTarget > npcUseMinRange))
	then
		return 0
	end

	if npcAllowableTargetFov < 180 and __wf_atom_9a1e4ed3.avatar:__wf_atom_535d5cbb() then
		local v3 = fn(__wf_atom_9a1e4ed3.avatar) -- inferred equivalent call

		if not fn2(__wf_atom_9a1e4ed3.avatar:GetPosition(), v3, object) then -- inferred equivalent call
			return 0
		end
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		not __wf_atom_7e8ad928(__wf_atom_be152500)
		and (__wf_atom_d2b2176d:__wf_atom_9f71ab59() or __wf_atom_be152500:GetState() ~= 0)
	then
		return 0
	end

	__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v, v2)
	return 1
end

function StealWait(object)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = 10
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_d6f4d914(16, true)
	radialDamageData:__wf_atom_98d98d81(object:GetPosition())
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(mOwner:__wf_atom_c78fa517())
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	object:Attach(activateFxPlayer, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	Sleep(15)

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:SetEnabled(false)
	end
end

function InitializeAbility(_, object)
	if object:__wf_atom_535d5cbb() then
		object:__wf_atom_8a035cd5(Symbol("StealWait"), false)
	end
end

function ActivateAbility(p, object)
	if object:__wf_atom_535d5cbb() then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnMelee"), true)
		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			__wf_atom_9fb9a1d6:__wf_atom_01e1d257(0)
		end

		while
			not object:IsKilled()
			and not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6)
			and __wf_atom_9fb9a1d6:__wf_atom_85821ed3()
		do
			Sleep(0)
		end
	else
		local v2 = Symbol(npcAnimEventToWaitFor)
		local __wf_atom_b4c3edde = npcActivateAnim:__wf_atom_b4c3edde(v2)
		object:Attach(activateFx, Hand, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
		local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
		local v3 = Symbol("GAME_C1_SPINE1")
		local __wf_atom_510474d7 = Resource(npcProjectile):__wf_atom_510474d7()
		local v4 = 0
		local flag = false

		for i = 1, __wf_atom_b4c3edde do
			local v5 = 1 * npcActivateAnim:__wf_atom_091354f5(v2, i - 1) - v4
			v4 = v5

			while v5 > 0 do
				if object:__wf_atom_c138b19b(npcActivateAnim) then
					flag = true
				elseif flag then
					return
				end

				if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_929bb30b() then
					local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

					if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
						__wf_atom_28d5d4aa = __wf_atom_216d6edd:__wf_atom_1c374cc9(v3)
						local v6 = object:__wf_atom_d5fda8be(__wf_atom_28d5d4aa) / __wf_atom_510474d7
						local __wf_atom_b4b1510d = __wf_atom_216d6edd:__wf_atom_b4b1510d()
						VectorAdd(__wf_atom_28d5d4aa, __wf_atom_28d5d4aa, __wf_atom_b4b1510d * v6)
						local v7 = __wf_atom_fa8d0177(object:GetPosition(), __wf_atom_28d5d4aa)
						object:__wf_atom_51075230(v7)
						object:__wf_atom_84d66e8e(v7)
					end
				end

				Sleep(0)
				v5 -= __wf_atom_084b3e93()
			end

			if not flag and v5 > 0 then
				return
			end

			local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Hand)
			local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
			__wf_atom_2f2bada0.pitch = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_28d5d4aa).pitch
			local entity = gRegion:CreateEntity(npcProjectile, __wf_atom_1c374cc9, __wf_atom_2f2bada0, object)

			if __wf_atom_7e8ad928(entity) then
				continue
			end

			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(p)
		end

		if gRegion:IsMaster() then
			while object:__wf_atom_c138b19b(npcActivateAnim) do
				Sleep(0)
			end
		end
	end
end

function DeactivateAbility(_, object)
	if not object:__wf_atom_535d5cbb() then
		return
	end

	mOwner:__wf_atom_74f6ca7b(Symbol("OnMelee"), false)
end

function OnMelee(object, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_9fb9a1d6 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

	if __wf_atom_7e8ad928(__wf_atom_66088189) then
		return
	end

	local __wf_atom_75a0566d = __wf_atom_9fb9a1d6:__wf_atom_75a0566d()

	if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
		return
	end

	local __wf_atom_fe33ffd0 = __wf_atom_75a0566d:__wf_atom_fe33ffd0()

	if __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
		return
	end

	local __wf_atom_93e44bac = __wf_atom_fe33ffd0:__wf_atom_93e44bac()

	if __wf_atom_7e8ad928(__wf_atom_93e44bac) then
		return
	end

	local __wf_atom_091354f5 = __wf_atom_93e44bac:__wf_atom_091354f5(Symbol("StartMeleeSweep"))
	local __wf_atom_091354f5_2 = __wf_atom_93e44bac:__wf_atom_091354f5(Symbol("EndMeleeSweep"))

	if __wf_atom_091354f5_2 <= __wf_atom_091354f5 then
		return
	end

	local __wf_atom_f5bac0e4 = __wf_atom_66088189:__wf_atom_f5bac0e4()
	local __wf_atom_df9e931d = __wf_atom_93e44bac:__wf_atom_df9e931d(__wf_atom_f5bac0e4, __wf_atom_091354f5)
	local __wf_atom_df9e931d2 = __wf_atom_93e44bac:__wf_atom_df9e931d(__wf_atom_f5bac0e4, __wf_atom_091354f5_2)
	__wf_atom_9fb9a1d6:__wf_atom_4bfd7505(true)
	Sleep(__wf_atom_93e44bac:__wf_atom_8bb4ded3() / __wf_atom_9fb9a1d6:__wf_atom_bef8f035() * (__wf_atom_091354f5 + __wf_atom_091354f5_2) / 2)

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		__wf_atom_9fb9a1d6:__wf_atom_4bfd7505(false)
	end

	local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(__wf_atom_f5bac0e4)
	local __wf_atom_2f2bada0 = __wf_atom_6009c8ed:__wf_atom_2f2bada0()
	local v2 = __wf_atom_df9e931d2 - __wf_atom_df9e931d
	__wf_atom_2f2bada0.bank = math.deg((math.atan(v2.y / v2.x)))
	local entity = gRegion:CreateEntity(projectileType, __wf_atom_1c374cc9, __wf_atom_2f2bada0, __wf_atom_6009c8ed)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	entity:__wf_atom_8fcdea81(__wf_atom_6009c8ed)
	entity:__wf_atom_c6dbdab6(object)
end