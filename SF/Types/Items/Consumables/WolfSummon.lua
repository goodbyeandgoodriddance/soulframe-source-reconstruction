local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local module3 = require("SF.Scripts.Libs.PlayerPetLib")
local v = nil

local function fn(p)
	local __wf_atom_3c37bceb = gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(p, 10)

	if __wf_atom_3c37bceb or needsNav then
		return __wf_atom_3c37bceb
	end

	return not __wf_atom_7e8ad928(gRegion:Raycast(p + Vector(0, 5, 0), p - Vector(0, 10, 0), nil, nil, p, true))
end

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
	then
		return false
	end

	return (fn(object:GetPosition() + object:__wf_atom_a06d543c() * 4))
end

local function fn2(object, position, __wf_atom_d0069154, p)
	local v2 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v3 = Vector()
	return gRegion:__wf_atom_fbb89790(__wf_atom_d0069154, p, 1.25, { object, position }, v2, nil, v3)
end

local function fn3(object, position)
	if shouldReposition and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(position)) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
		local __wf_atom_d0069154 = object:__wf_atom_d0069154()
		object:__wf_atom_cb05c7fd(__wf_atom_d0069154)
		local v2 = __wf_atom_d0069154 + object:__wf_atom_a06d543c() * 2

		if not __wf_atom_7e8ad928(fn2(object, position, __wf_atom_d0069154, v2)) then
			local __wf_atom_28ce676a = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
			__wf_atom_28ce676a:__wf_atom_267bfc41(object:GetPosition(), Range(2, 15), 1)
			__wf_atom_28ce676a:__wf_atom_4a7833f4()
			__wf_atom_28ce676a:__wf_atom_655394dc()
			__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1.35, 3.4028234663852886e38))
			__wf_atom_28ce676a:__wf_atom_e275b192(object:GetPosition(), object:__wf_atom_a06d543c(), 60)
			__wf_atom_28ce676a:__wf_atom_9699b67c(false)
			__wf_atom_28ce676a:__wf_atom_06c7577b()
			__wf_atom_28ce676a:__wf_atom_0f52bdf4(object:GetPosition(), Range(2, 15), -1, 1, 1, 0, false)
			__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("OrengallReposition"))
			__wf_atom_28ce676a:Start()

			repeat
				Sleep(0)
			until __wf_atom_28ce676a:__wf_atom_2ddd6354()

			local __wf_atom_5802ff81 = __wf_atom_28ce676a:__wf_atom_5802ff81()

			if #__wf_atom_5802ff81 == 0 then
				print("Orengall repositioning: no points")

				if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
					__wf_atom_30e3d82b:MoveTo(position, false, false, true)
				end
			elseif not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
				__wf_atom_30e3d82b:__wf_atom_ab26d234(__wf_atom_5802ff81[1], false, false, true)
			end
		end
	end
end

local function fn4(object, object2, object3, p, p2, p3)
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
	local v2

	if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
		v2 = object:__wf_atom_a06d543c()
	else
		v2 = __wf_atom_dd7246c7:__wf_atom_a06d543c()
	end

	local __wf_atom_a97361bb = object:__wf_atom_a97361bb()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	__wf_atom_2202ffb6:__wf_atom_7d789620()
	local __wf_atom_22941262 = object2:__wf_atom_22941262()
	local v3 = nil

	if not p3 then
		if __wf_atom_7e8ad928(p) then
			local __wf_atom_f2e7f4a9 = object:__wf_atom_d2b2176d():__wf_atom_f2e7f4a9()

			if
				not __wf_atom_7e8ad928(v3)
				and v3:__wf_atom_a3309443()
				and v3.visible
				and v3.distanceToTarget <= enemiesSearchRange
				and v3:__wf_atom_e93896ba() ~= Symbol("Neutral")
				and not v3:__wf_atom_50a7d83e():__wf_atom_464a4772()
			then
				v3 = __wf_atom_f2e7f4a9
			end

			if __wf_atom_7e8ad928(v3) then
				local all = gRegion:FindAll(__wf_atom_9e85eea2, object:__wf_atom_a2a18137(), 0, enemiesSearchRange)

				for i = 1, #all do
					if __wf_atom_7e8ad928(all[i]) or all[i]:IsKilled() or object:__wf_atom_129d1aba(all[i]) then
						continue
					end

					if
						all[i]:__wf_atom_e93896ba() == Symbol("Neutral")
						or (all[i]:__wf_atom_464a4772() or all[i]:IsA(targetExclusionType))
					then
						continue
					end

					v3 = all[i]
					break
				end
			end
		else
			v3 = p
		end
	end

	local v4, v5

	if __wf_atom_7e8ad928(v3) then
		v4 = 60
		v5 = 2
	else
		v4 = 110
		v5 = 5
	end

	local v6 = __wf_atom_a2a18137 + __wf_atom_9341614d(v2, Rotation(v4, 0, 0)) * v5

	if not __wf_atom_7e8ad928(v3) then
		__wf_atom_2f2bada0 = __wf_atom_fa8d0177(v6, v3:__wf_atom_a2a18137())
	end

	if not __wf_atom_7e8ad928(v3) and v3:IsA(__wf_atom_4ebf67cb) then
		local v7 = __wf_atom_fa8d0177(v3:__wf_atom_a2a18137(), v6)
		v7.pitch = 0
		v3:MotionControl():__wf_atom_3a1d0c16(v7)
	end

	local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
		agentType,
		v6,
		__wf_atom_2f2bada0,
		EMPTY_SYMBOL,
		__wf_atom_22941262,
		true,
		0,
		0,
		summonAnim
	)
	local v7

	if not (__wf_atom_7e8ad928(__wf_atom_402b3832) or __wf_atom_7e8ad928(__wf_atom_402b3832:__wf_atom_50a7d83e())) then
		v7 = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not p2 then
			module3.SetPlayerPetAppeanceSkin(v7, __wf_atom_a96eb2aa)
		end

		v7:PlaySound(appearSound, false, 1, false)
		v7:SetFaction(__wf_atom_a97361bb)
		v7:__wf_atom_6a95c7b8(object)
		v7:__wf_atom_8f0b611f(mOwner)
		v7:Attach(perceptionHint, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		__wf_atom_402b3832:__wf_atom_2e7b29b1(false)

		if not mountEnabled then
			v7:__wf_atom_0650fed7(mountActionType)
		end

		module2.SetAbilityStats(object2, mOwner, v7)
	end

	if __wf_atom_7e8ad928(v7) then
		return nil
	end

	if __wf_atom_7e8ad928(v3) then
		if not __wf_atom_7e8ad928(object3) then
			object3:__wf_atom_04c57ae1(false, noTargetCooldown)
		end
	else
		local __wf_atom_a2a18137_2 = v7:__wf_atom_a2a18137()
		local __wf_atom_a2a18137_3 = v3:__wf_atom_a2a18137()
		local v8 = __wf_atom_fa8d0177(__wf_atom_a2a18137_2, __wf_atom_a2a18137_3)
		local v9 = __wf_atom_a2a18137_3 - __wf_atom_a2a18137_2
		Normalize(v9)
		local v10 = __wf_atom_a2a18137_3 - 1 * v9
		v7:__wf_atom_3c986cd9(v10, v8)
		v7:__wf_atom_921c1a5f(summonJumpInAnim, true, 3, 1, true, 2)

		if __wf_atom_7e8ad928(v3) then
			return v7
		end

		if v3:IsA(__wf_atom_43e0c427) then
			v3 = v3:__wf_atom_6009c8ed()

			if __wf_atom_7e8ad928(v3) then
				return v7
			end
		end

		if v3:IsFrozenSolid(1) or v3:IsFrozenSolid(0) or v3:IsFrozenSolid(2) then
			v3:__wf_atom_d70bf41b(4)
			v3:__wf_atom_0fab63d3(true)
			local __wf_atom_bb3e7833 = v3:__wf_atom_bb3e7833(WeakResource("/SF/Fx/Abilities/Ward/FeyStone/AttachFxTarget"))

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		v7:Teleport(v7:__wf_atom_0d7d47e6(v10), v8)
		v7:MotionControl():__wf_atom_2b8da3d2(__wf_atom_28d5d4aa)
		v7:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		v7:__wf_atom_921c1a5f(nil, false)
		v7:__wf_atom_9373d0eb(5, false)
		v3:__wf_atom_a763aa1a(0)
		v3:__wf_atom_7470861b():__wf_atom_28a77bdf(0)
		local __wf_atom_634139d6 = v7:__wf_atom_634139d6(v3, finisherCollection)

		if __wf_atom_7e8ad928(__wf_atom_634139d6) then
			local damageData = Engine.DamageData()
			damageData:__wf_atom_d6f4d914(20, true)
			damageData:__wf_atom_812165c6(0)
			damageData:__wf_atom_6b472125(v7)
			v3:__wf_atom_649bf33e(damageData)
			local __wf_atom_921c1a5f = v7:__wf_atom_921c1a5f(finisherAnim, false, 4, 1, true, 1)
			v3:__wf_atom_e310f01f(__wf_atom_28d5d4aa, __wf_atom_80368bb1)
			v3:__wf_atom_f6c0dfe1(true)
			v3:__wf_atom_dc5956fc(v7, Symbol("GAME_chin"))
			v3:__wf_atom_dd875cd8(true)
			v3:__wf_atom_d1b42aad(false)
			v3:__wf_atom_30964595(false)
			v3:SetDisableGravity(true)
			v3:__wf_atom_0fab63d3(false)
			v3:__wf_atom_9373d0eb(20, true)
			local __wf_atom_f51f1faa = v3:__wf_atom_f51f1faa()
			local v11 = 1

			while
				__wf_atom_7e8ad928(__wf_atom_f51f1faa)
				and v11 > 0
				and not (__wf_atom_7e8ad928(v3) or v3:IsKilled())
			do
				v11 -= __wf_atom_084b3e93()
				__wf_atom_f51f1faa = v3:__wf_atom_f51f1faa()
				Sleep(0)
			end

			local v12

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				v12 = __wf_atom_f51f1faa:__wf_atom_fec6bb4d(1)

				if __wf_atom_7e8ad928(v12) then
					local __wf_atom_0f84fdc7 = __wf_atom_f51f1faa:__wf_atom_0f84fdc7()

					if #__wf_atom_0f84fdc7 > 0 then
						v12 = __wf_atom_0f84fdc7[1]
					end
				end

				if __wf_atom_7e8ad928(v12) then
					__wf_atom_f51f1faa:__wf_atom_f6c0dfe1(true)
					__wf_atom_f51f1faa:__wf_atom_dc5956fc(v7, Symbol("GAME_chin"))
				else
					v3:AttachRagdoll(v12, v7, Symbol("GAME_chin"), true)
				end

				__wf_atom_f51f1faa:__wf_atom_0bd69c3e(false)
				__wf_atom_f51f1faa:SetDisableGravity(true)
				__wf_atom_f51f1faa:__wf_atom_f217efeb(true)
				__wf_atom_f51f1faa:__wf_atom_41296388(true)
			end

			while __wf_atom_921c1a5f > 0.3 and not (__wf_atom_7e8ad928(v3) or v3:IsKilled()) do
				__wf_atom_921c1a5f -= __wf_atom_084b3e93()
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				__wf_atom_f51f1faa:__wf_atom_e6ed03c8()
				__wf_atom_f51f1faa:__wf_atom_0bd69c3e(true)
				__wf_atom_f51f1faa:__wf_atom_f217efeb(false)
				__wf_atom_f51f1faa:__wf_atom_41296388(false)
				__wf_atom_f51f1faa:SetDisableGravity(false)

				if not __wf_atom_7e8ad928(v12) then
					v3:__wf_atom_8391ca00(v12)
				end
			end

			Sleep(0)

			if not __wf_atom_7e8ad928(v3) then
				local v13 = Vector(0, 1, 0)
				local v14 = __wf_atom_edfe0d73(v7:__wf_atom_a06d543c(), v13)
				local damageData2 = Engine.DamageData()
				damageData2:__wf_atom_d6f4d914(20, true)
				damageData2:__wf_atom_812165c6(0)
				damageData2:__wf_atom_6b472125(v7)
				damageData2:__wf_atom_12cf5317(v14 * (victimThrowImpulse or 200))
				v3:__wf_atom_649bf33e(damageData2)
				v3:__wf_atom_e6ed03c8()
				v3:SetDisableGravity(false)
				v3:__wf_atom_d1b42aad(true)
				v3:__wf_atom_9373d0eb(20, false)
				v3:__wf_atom_dd875cd8(false)
				v3:__wf_atom_30964595(true)
				v3:__wf_atom_0fab63d3(true)
				local damageData3 = Engine.DamageData()
				damageData3.baseAmount = v3:GetMaxHealth() * 10
				damageData3:__wf_atom_7498285f(2, 1)
				damageData3:__wf_atom_6b472125(v7)
				damageData3:__wf_atom_812165c6(0)
				damageData3.hitType = 3
				v3:__wf_atom_649bf33e(damageData3)
			end
		else
			Sleep(0.2)
			v7:__wf_atom_70ca09b9(__wf_atom_634139d6, v3)

			while not __wf_atom_7e8ad928(v7) and v7:__wf_atom_611b620c() do
				Sleep(0)
			end
		end

		if not __wf_atom_7e8ad928(v3) and v3:IsA(__wf_atom_67c46eba) and not v3:IsKilled() then
			v3:__wf_atom_7470861b():__wf_atom_0ab36782()
		end

		if not despawnAfterAttack then
			if shouldLookAtAvatar then
				__wf_atom_402b3832:__wf_atom_702e65d8(object, true)
			end

			fn3(v7, object)
			return v7
		end
	end

	return v7
end

function MonitorWater(object)
	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_dfd1f05e()) do
		Sleep(0)
	end

	Sleep(1.5)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8a035cd5(Symbol("DespawnWolfImmediately"), false)
	end
end

function ActivateAbility(object, p)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v2 = object:Attach(whistleDeco, Symbol("GAME_L1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:PlaySound(castSound, false, 0, false)

	if not __wf_atom_7e8ad928(activateAnim) then
		object:__wf_atom_8914dfde("RockSummon", (object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, true)))
	end

	if gRegion:IsMaster() then
		gRegion:__wf_atom_2202ffb6():__wf_atom_5ed7114d(summonPerceptionInfo, object, object:GetPosition())
		v = fn4(object, __wf_atom_e55d02aa, p)

		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_8a035cd5(Symbol("MonitorWater"), false)
		end

		while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(v2)) do
			if not (object:__wf_atom_c138b19b(activateAnim) or object:__wf_atom_3c281634(activateAnim)) then
				gRegion:__wf_atom_dd1e4d10(v2)
			end

			Sleep(0)
		end

		if mountEnabled then
			while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(v)) do
				Sleep(0)
			end
		end

		if not (__wf_atom_7e8ad928(v) or v:IsKilled()) then
			v:__wf_atom_8a035cd5(Symbol("DespawnWolf"), false)
		end
	else
		while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
			if not (__wf_atom_7e8ad928(v2) or object:__wf_atom_c138b19b(activateAnim) or object:__wf_atom_3c281634(activateAnim)) then
				v2:Destroy()
			end

			Sleep(0)
		end
	end
end

function DespawnWolfImmediately(instance)
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

function WolfSpawned(object)
	object:__wf_atom_92aa9d91():__wf_atom_8d150708(false)
end

function DespawnWolf(p)
	Sleep(despawnTime)
	DespawnWolfImmediately(p)
end

function TriggerWolfAmbush(object, object2)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return false
	end

	if not fn(object:GetPosition() + object:__wf_atom_a06d543c() * 4) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local orengallAttackDoneAvatar

	if shouldKillAttached and not __wf_atom_7e8ad928(object2) then
		orengallAttackDoneAvatar = fn4(object, __wf_atom_e55d02aa, nil, object2:__wf_atom_3d96ddcd(), true)
	else
		orengallAttackDoneAvatar = fn4(object, __wf_atom_e55d02aa, nil, nil, true)
	end

	if __wf_atom_7e8ad928(orengallAttackDoneAvatar) then
		return
	end

	orengallAttackDoneAvatar:__wf_atom_b811702e(Symbol("OrengallAvatar"))

	if despawnAfterAttack then
		DespawnWolf(orengallAttackDoneAvatar)
	else
		_T.OrengallAttackDoneAvatar = orengallAttackDoneAvatar
	end
end

function SummonOrengallUpgrade(object, object2, _, _, p)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local v2 = module.WaitForAiDir()
	local total = 0
	local v3 = false
	local v4 = 0

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(v2)) do
		if v2:__wf_atom_37241977(__wf_atom_a96eb2aa) and __wf_atom_7e8ad928(v) then
			v3 = total > 25 and not v3 or v3

			if v3 and v4 <= 0 then
				gGameRules:__wf_atom_ae06b572(wolfAttackTransmission)
				Sleep(2.5)
				ActivateAbility(object)
				v4 = 20
				v3 = false
			end

			local v5 = __wf_atom_084b3e93()
			total += v5
			v4 -= v5
		end

		if __wf_atom_7e8ad928(object2) or object2:__wf_atom_c1f9859f(p) then
			if __wf_atom_7e8ad928(object2) and not object:__wf_atom_d2b2176d():__wf_atom_5c7adae9(p) then
				break
			else
				Sleep(0)
			end
		else
			break
		end
	end
end

function ActivateOrengallBooster(p, p2)
	SummonOrengallUpgrade(p, nil, nil, nil, p2)
end

function DeactivateOrengallBooster(_, _) end

function SummonWolfFromScript(p, object, p2)
	if __wf_atom_7e8ad928(object) then
		object = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	agentType = p
	enemiesSearchRange = 20
	return (fn4(object, __wf_atom_e55d02aa, nil, nil, nil, p2))
end