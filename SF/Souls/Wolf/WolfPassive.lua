local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local v = Symbol("Neutral")
local v2 = 2
local v3 = 10
local v4 = 0.95
local v5 = WeakResource("/SF/Types/Quests/OmenBeastQuests/TheOmenOrengall")

local function fn(_, p, p2)
	local v6 = { __wf_atom_5a5ce2a1, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v7 = Vector()
	local __wf_atom_fbb89790 = gRegion:__wf_atom_fbb89790(p, p2, 0.5, nil, v6, nil, v7)

	if debugDraw then
		gRegion:__wf_atom_3fe54173(p, p2, 0.5, p2 - p, Color(255, 0, 0), 20)

		if not __wf_atom_7e8ad928(__wf_atom_fbb89790) then
			gRegion:__wf_atom_5b35a0c8(v7, Color(255, 255, 255), "->" .. __wf_atom_fbb89790:GetName(), 1, 20)
		end
	end

	return __wf_atom_fbb89790
end

local function fn2(object, object2, __wf_atom_a2a18137, p)
	local v6 = __wf_atom_a2a18137 + __wf_atom_9341614d(p, Rotation(110, 0, 0)) * 5
	local v7 = not (__wf_atom_7e8ad928(object2) or object2:IsKilled())
		and not object2:__wf_atom_129d1aba(object)
		and object2:IsVisible()

	if v7 then
		if object2:__wf_atom_e93896ba() == v then
			return false
		else
			return not object2:MotionControl():__wf_atom_38f58d22()
				and fn(object2, v6 + Vector(0, 1.5, 0), object2:__wf_atom_d0069154()) == object2
		end
	end

	return v7
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

local function fn3(instance) -- 1 equivalent call inferred from this helper
	for _, className in ipairs(invalidAvatarTypes) do
		if instance:IsA(className) then
			return false
		end
	end

	return true
end

local function fn4(object, object2, _, object3)
	object2:__wf_atom_6a4cf64f()

	if not gRegion:IsMaster() then
		return nil
	end

	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return nil
	end

	local __wf_atom_dd7246c7 = __wf_atom_a96eb2aa:__wf_atom_dd7246c7()
	local v6

	if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
		v6 = object:__wf_atom_a06d543c()
	else
		v6 = __wf_atom_dd7246c7:__wf_atom_a06d543c()
	end

	local __wf_atom_a97361bb = object:__wf_atom_a97361bb()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	__wf_atom_2202ffb6:__wf_atom_7d789620()
	local __wf_atom_22941262 = object2:__wf_atom_22941262()
	local aimPosition = object:GetAimPosition()
	local v7 = __wf_atom_e97f3142(object:__wf_atom_4e50d390())
	local v8 = object:__wf_atom_0251b5eb(2, enemiesSearchRange, 2, true, true, true, true) or {}
	local v9 = {}

	for _, v10 in ipairs(v8) do
		if not (fn3(v10) and Dot(object:__wf_atom_a2a18137() - aimPosition, v7) > 0) then -- inferred equivalent call
			continue
		end

		if not fn2(object, v10, __wf_atom_a2a18137, v6) then
			continue
		end

		table.insert(v9, v10)
	end

	if not (#v9 > 0) or (__wf_atom_7e8ad928(v9[1]) or v9[1]:__wf_atom_464a4772()) then
		return
	end

	local v10 = v9[1]
	local v11, v12

	if __wf_atom_7e8ad928(v10) then
		object2:__wf_atom_19516b62(10)
		v11 = 60
		v12 = 2
	else
		v11 = 110
		v12 = 5
	end

	local v13 = __wf_atom_a2a18137 + __wf_atom_9341614d(v6, Rotation(v11, 0, 0)) * v12

	if not __wf_atom_7e8ad928(v10) then
		__wf_atom_2f2bada0 = __wf_atom_fa8d0177(v13, v10:__wf_atom_a2a18137())
	end

	if not __wf_atom_7e8ad928(v10) then
		local v14 = __wf_atom_fa8d0177(v10:__wf_atom_a2a18137(), v13)
		v14.pitch = 0
		v10:MotionControl():__wf_atom_3a1d0c16(v14)
	end

	object:__wf_atom_1a73b1c2(wolfAttackTransmission)
	local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
		agentType,
		v13,
		__wf_atom_2f2bada0,
		EMPTY_SYMBOL,
		__wf_atom_22941262,
		true,
		0,
		0,
		summonAnim
	)
	local v14

	if not (__wf_atom_7e8ad928(__wf_atom_402b3832) or __wf_atom_7e8ad928(__wf_atom_402b3832:__wf_atom_50a7d83e())) then
		v14 = __wf_atom_402b3832:__wf_atom_50a7d83e()
		v14:SetFaction(__wf_atom_a97361bb)
		v14:__wf_atom_6a95c7b8(object)
		v14:__wf_atom_8f0b611f(mOwner)
		v14:Attach(wolfPerceptionHint, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		__wf_atom_402b3832:__wf_atom_2e7b29b1(false)
		__wf_atom_402b3832:__wf_atom_aa4361c1(Symbol("BlockingBehavior"), v14, 1)

		if not mountEnabled then
			v14:__wf_atom_0650fed7(mountActionType)
		end

		module.SetAbilityStats(object2, mOwner, v14)
	end

	if __wf_atom_7e8ad928(v14) then
		return nil
	end

	if __wf_atom_7e8ad928(v10) then
		if not __wf_atom_7e8ad928(object3) then
			object3:__wf_atom_04c57ae1(false, noTargetCooldown)
		end
	else
		local __wf_atom_a2a18137_2 = v14:__wf_atom_a2a18137()
		local __wf_atom_a2a18137_3 = v10:__wf_atom_a2a18137()
		local v15 = __wf_atom_fa8d0177(__wf_atom_a2a18137_2, __wf_atom_a2a18137_3)
		local v16 = __wf_atom_a2a18137_3 - __wf_atom_a2a18137_2
		Normalize(v16)
		local v17 = __wf_atom_a2a18137_3 - 1 * v16
		v14:__wf_atom_3c986cd9(v17, v15)
		v14:__wf_atom_921c1a5f(summonJumpInAnim, true, 3, 1, true, 2)
		v14:Teleport(v14:__wf_atom_0d7d47e6(v17), v15)
		v14:MotionControl():__wf_atom_2b8da3d2(Vector())
		v14:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		v14:__wf_atom_9b5dcd3b(nil, true, 3, 1, true)
		v14:__wf_atom_9373d0eb(5, false)

		if not __wf_atom_7e8ad928(v10) then
			v10:__wf_atom_a763aa1a(0)
			v10:__wf_atom_7470861b():__wf_atom_28a77bdf(0)
			v10:__wf_atom_9b5dcd3b(nil, true, 3, 1, true)
		end

		module.Fear(object, 12, false)
		local __wf_atom_634139d6 = v14:__wf_atom_634139d6(v10, finisherCollection)

		if __wf_atom_7e8ad928(__wf_atom_634139d6) then
			if not __wf_atom_7e8ad928(v10) then
				local damageData = Engine.DamageData()
				damageData:__wf_atom_d6f4d914(20, true)
				damageData:__wf_atom_812165c6(0)
				damageData:__wf_atom_6b472125(v14)
				v10:__wf_atom_649bf33e(damageData)
				local __wf_atom_921c1a5f = v14:__wf_atom_921c1a5f(finisherAnim, false, 4, 1, true, 1)
				v10:__wf_atom_e310f01f(__wf_atom_28d5d4aa, __wf_atom_80368bb1)
				v10:__wf_atom_f6c0dfe1(true)
				v10:__wf_atom_dc5956fc(v14, Symbol("GAME_chin"))
				v10:__wf_atom_dd875cd8(true)
				v10:__wf_atom_d1b42aad(false)
				v10:__wf_atom_30964595(false)
				v10:SetDisableGravity(true)
				v10:__wf_atom_0fab63d3(false)
				v10:__wf_atom_9373d0eb(20, true)
				local __wf_atom_f51f1faa = v10:__wf_atom_f51f1faa()
				local v18 = 1

				while
					__wf_atom_7e8ad928(__wf_atom_f51f1faa)
					and v18 > 0
					and not (__wf_atom_7e8ad928(v10) or v10:IsKilled())
				do
					v18 -= __wf_atom_084b3e93()
					__wf_atom_f51f1faa = v10:__wf_atom_f51f1faa()
					Sleep(0)
				end

				local v19

				if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
					v19 = __wf_atom_f51f1faa:__wf_atom_fec6bb4d(1)

					if __wf_atom_7e8ad928(v19) then
						local __wf_atom_0f84fdc7 = __wf_atom_f51f1faa:__wf_atom_0f84fdc7()

						if #__wf_atom_0f84fdc7 > 0 then
							v19 = __wf_atom_0f84fdc7[1]
						end
					end

					if __wf_atom_7e8ad928(v19) then
						__wf_atom_f51f1faa:__wf_atom_f6c0dfe1(true)
						__wf_atom_f51f1faa:__wf_atom_dc5956fc(v14, Symbol("GAME_chin"))
					else
						v10:AttachRagdoll(v19, v14, Symbol("GAME_chin"), true)
					end

					__wf_atom_f51f1faa:__wf_atom_0bd69c3e(false)
					__wf_atom_f51f1faa:SetDisableGravity(true)
					__wf_atom_f51f1faa:__wf_atom_f217efeb(true)
					__wf_atom_f51f1faa:__wf_atom_41296388(true)
				end

				while __wf_atom_921c1a5f > 0.3 and not (__wf_atom_7e8ad928(v10) or v10:IsKilled()) do
					__wf_atom_921c1a5f -= __wf_atom_084b3e93()
					Sleep(0)
				end

				if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
					__wf_atom_f51f1faa:__wf_atom_e6ed03c8()
					__wf_atom_f51f1faa:__wf_atom_0bd69c3e(true)
					__wf_atom_f51f1faa:__wf_atom_f217efeb(false)
					__wf_atom_f51f1faa:__wf_atom_41296388(false)
					__wf_atom_f51f1faa:SetDisableGravity(false)

					if not __wf_atom_7e8ad928(v19) then
						v10:__wf_atom_8391ca00(v19)
					end
				end

				Sleep(0)

				if not __wf_atom_7e8ad928(v10) then
					local v20 = Vector(0, 1, 0)
					local v21 = __wf_atom_edfe0d73(v14:__wf_atom_a06d543c(), v20)
					local damageData2 = Engine.DamageData()
					damageData2:__wf_atom_d6f4d914(20, true)
					damageData2:__wf_atom_812165c6(0)
					damageData2:__wf_atom_6b472125(v14)
					damageData2:__wf_atom_12cf5317(v21 * victimThrowImpulse)
					v10:__wf_atom_649bf33e(damageData2)
					v10:__wf_atom_e6ed03c8()
					v10:SetDisableGravity(false)
					v10:__wf_atom_d1b42aad(true)
					v10:__wf_atom_9373d0eb(20, false)
					v10:__wf_atom_dd875cd8(false)
					v10:__wf_atom_30964595(true)
					v10:__wf_atom_0fab63d3(true)
					local damageData3 = Engine.DamageData()
					damageData3.baseAmount = v10:GetMaxHealth() * 10
					damageData3:__wf_atom_7498285f(2, 1)
					damageData3:__wf_atom_6b472125(v14)
					damageData3:__wf_atom_812165c6(0)
					damageData3.hitType = 3
					v10:__wf_atom_649bf33e(damageData3)
				end
			end
		else
			Sleep(0.2)
			v14:__wf_atom_70ca09b9(__wf_atom_634139d6, v10)

			while not __wf_atom_7e8ad928(v14) and v14:__wf_atom_611b620c() do
				Sleep(0)
			end

			v14:Teleport(v14:__wf_atom_0d7d47e6(v14:__wf_atom_a2a18137()))
		end

		if not __wf_atom_7e8ad928(v10) and v10:IsA(__wf_atom_67c46eba) and not v10:IsKilled() then
			v10:__wf_atom_7470861b():__wf_atom_0ab36782()
		end
	end

	v14:__wf_atom_8a035cd5(Symbol("DespawnWolf"), false)
	return nil
end

local function fn5(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("WolfPack"))
	module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v2 = 2
		v3 = 10
	elseif __wf_atom_2a745663 == 2 then
		v2 = 3
		v3 = 12
	elseif __wf_atom_2a745663 == 3 then
		v2 = 4
		v3 = 16
	else
		v2 = 5
		v3 = 20
	end

	return true
end

local function fn6(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("WolfSummon"))
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v4 = 0.95
	elseif __wf_atom_2a745663 == 2 then
		v4 = 0.92
	elseif __wf_atom_2a745663 == 3 then
		v4 = 0.9
	else
		v4 = 0.88
	end

	local v6 = 0.02 * magikForceCalc
	v4 -= v6
	return true
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v6 = gRegion:IsMaster() and fn5(__wf_atom_6009c8ed)
	local v7 = gRegion:IsMaster() and fn6(__wf_atom_6009c8ed)
	local v8 = Symbol("WolfSpeed")
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.WolfDamagePassiveUpgrade = 0
	__wf_atom_e919fb8e.WolfDamagePassiveAvatars = {}
	local v9 = 5

	while not __wf_atom_7e8ad928(__wf_atom_6009c8ed) do
		if v7 and not module2.QuestIsActive(v5) then
			local all = gRegion:FindAll(__wf_atom_9e85eea2)

			for i = 1, #all do
				if __wf_atom_7e8ad928(all[i]) or all[i]:IsKilled() or all[i]:__wf_atom_e93896ba() == v then
					continue
				end

				if all[i]:__wf_atom_129d1aba(__wf_atom_6009c8ed) then
					continue
				end

				if not (all[i]:__wf_atom_464a4772() and all[i]:__wf_atom_8a6b8fc3(__wf_atom_6009c8ed) < 50 or all[i]:__wf_atom_3a6b0cbb() and all[i]:__wf_atom_8a6b8fc3(__wf_atom_6009c8ed) < 30) then
					continue
				end

				v9 -= __wf_atom_084b3e93()

				if not (v9 < 0) then
					continue
				end

				local v10 = Random(0, 1)

				if v4 < v10 then
					fn4(__wf_atom_6009c8ed, object)
					v9 = 90
				else
					v9 = 5
				end
			end
		end

		if v6 then
			local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_6009c8ed:GetPosition(), 0, 20)

			for i = #all, 1, -1 do
				if not all[i]:__wf_atom_129d1aba(__wf_atom_6009c8ed) then
					table.remove(all, i)
				end
			end

			local wolfDamagePassiveUpgrade = math.min(#all * v2, v3)
			local v10 = wolfDamagePassiveUpgrade ~= __wf_atom_e919fb8e.WolfDamagePassiveUpgrade
			local wolfDamagePassiveAvatars = {}

			for _, v11 in ipairs(all) do
				local __wf_atom_18aa6e58 = v11:__wf_atom_18aa6e58()

				if not __wf_atom_e919fb8e.WolfDamagePassiveAvatars[__wf_atom_18aa6e58] or v10 then
					local __wf_atom_d2b2176d = v11:__wf_atom_d2b2176d()

					if __wf_atom_e919fb8e.WolfDamagePassiveAvatars[__wf_atom_18aa6e58] then
						__wf_atom_d2b2176d:__wf_atom_066a9716(
							v8,
							366,
							1,
							__wf_atom_e919fb8e.WolfDamagePassiveUpgrade,
							__wf_atom_77e05d3b
						)
					end

					__wf_atom_d2b2176d:__wf_atom_56004282(v8, 366, 1, wolfDamagePassiveUpgrade, __wf_atom_77e05d3b)
				end

				__wf_atom_e919fb8e.WolfDamagePassiveAvatars[__wf_atom_18aa6e58] = nil
				wolfDamagePassiveAvatars[__wf_atom_18aa6e58] = v11
			end

			for _, wolfDamagePassiveAvatar in pairs(__wf_atom_e919fb8e.WolfDamagePassiveAvatars) do
				if not __wf_atom_7e8ad928(wolfDamagePassiveAvatar) then
					wolfDamagePassiveAvatar:__wf_atom_d2b2176d():__wf_atom_066a9716(
						v8,
						366,
						1,
						__wf_atom_e919fb8e.WolfDamagePassiveUpgrade,
						__wf_atom_77e05d3b
					)
				end
			end

			__wf_atom_e919fb8e.WolfDamagePassiveUpgrade = wolfDamagePassiveUpgrade
			__wf_atom_e919fb8e.WolfDamagePassiveAvatars = wolfDamagePassiveAvatars
		end

		Sleep(0)
	end
end

function DespawnWolf(instance)
	Sleep(despawnTime)

	if not __wf_atom_7e8ad928(despawnFxType) then
		instance:Attach(despawnFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	end

	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(despawnAnim, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	instance:Destroy()
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	local v6 = Symbol("WolfSpeed")

	for _, wolfDamagePassiveAvatar in pairs(__wf_atom_e919fb8e.WolfDamagePassiveAvatars) do
		if not __wf_atom_7e8ad928(wolfDamagePassiveAvatar) then
			wolfDamagePassiveAvatar:__wf_atom_d2b2176d():__wf_atom_066a9716(
				v6,
				366,
				1,
				__wf_atom_e919fb8e.WolfDamagePassiveUpgrade,
				__wf_atom_77e05d3b
			)
		end
	end
end