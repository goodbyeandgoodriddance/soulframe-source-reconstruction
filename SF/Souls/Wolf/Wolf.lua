local v = 20
local v2 = 0
local v3 = 0
local v4 = nil
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")

local function fn(object, instance, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_e55d02aa2 = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_7e8ad928(__wf_atom_e55d02aa2) then
		return
	end

	local isA = instance:IsA(__wf_atom_47cae841)

	for i = 0, math.min(__wf_atom_e55d02aa:__wf_atom_87a16e10(), __wf_atom_e55d02aa2:__wf_atom_87a16e10()) do
		local __wf_atom_c497b0ae = __wf_atom_e55d02aa:__wf_atom_c497b0ae(i)
		local __wf_atom_c497b0ae2 = __wf_atom_e55d02aa2:__wf_atom_c497b0ae(i)
		local __wf_atom_cc3c265a = __wf_atom_e55d02aa:__wf_atom_cc3c265a(i)

		if not (__wf_atom_7e8ad928(__wf_atom_c497b0ae) or __wf_atom_7e8ad928(__wf_atom_c497b0ae2)) then
			if isA then
				__wf_atom_e55d02aa2:__wf_atom_66c5fa3f(i, __wf_atom_cc3c265a)
			end

			if __wf_atom_c497b0ae:__wf_atom_1bb5b1ff() == __wf_atom_c497b0ae2:__wf_atom_1bb5b1ff() then
				__wf_atom_c497b0ae2:__wf_atom_80e49f0d(__wf_atom_c497b0ae:__wf_atom_1fcd5380())

				if p then
					__wf_atom_c497b0ae2:__wf_atom_6e77b6d9(__wf_atom_c497b0ae:__wf_atom_de7e7709())
				end
			end
		end

		local __wf_atom_2e4994f1 = __wf_atom_e55d02aa:__wf_atom_2e4994f1(i)
		__wf_atom_e55d02aa2:__wf_atom_9e7c0c61(
			__wf_atom_e55d02aa:__wf_atom_f3044fe0(__wf_atom_2e4994f1),
			__wf_atom_2e4994f1,
			true
		)
	end
end

local function fn2(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local __wf_atom_e0730826 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(
		p,
		50,
		false,
		false,
		summonWolfType
	)

	for i = 1, #__wf_atom_e0730826 do
		if
			__wf_atom_7e8ad928(__wf_atom_e0730826[i])
			or __wf_atom_7e8ad928(__wf_atom_e0730826[i]:__wf_atom_50a7d83e())
		then
			continue
		end

		if __wf_atom_e0730826[i]:__wf_atom_50a7d83e():__wf_atom_6115a2e2() ~= p then
			continue
		end

		__wf_atom_e0730826[i]:__wf_atom_50a7d83e():__wf_atom_65fd9d84(p2)
	end
end

local function fn3(p, object, p2, p3)
	if p2 then
		local position = object:GetPosition()
		v2 = 30

		if not (v3 <= 0) then
			v3 -= p3
			return
		end

		if not v4 then
			v4 = {}
			module.SetAbilityStats(p, "WOLF", v4)
		end

		local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, v2)

		for _, v5 in ipairs(all) do
			if v5:__wf_atom_4402f880(object) then
				continue
			end

			local soulPulseEnemyFxType = soulPulseEnemyFxType
			local flag = true

			for k in pairs(v4) do
				if v5 ~= k then
					continue
				end

				flag = false
				break
			end

			if flag then
				v4[v5] = v5:Attach(soulPulseEnemyFxType, EMPTY_SYMBOL)
			end
		end

		v3 += 0.2
	else
		if not v4 then
			v4 = module.GetAbilityStats(p, "WOLF", true)
		end

		for _, v5 in pairs(v4) do
			if __wf_atom_7e8ad928(v5) then
				continue
			end

			if v5:IsA(__wf_atom_9578cbaa) then
				v5:PlayTriggeredFade()
			else
				v5:Destroy()
			end
		end

		v4 = nil
		v2 = 0
		v3 = 0
	end
end

function EvaluateAbility(_, instance)
	return not Game.__wf_atom_2b221245(true) and not instance:IsA(wolftype)
end

function NpcEvaluateAbility(_, _)
	return 0
end

function HasQueuedSoulStealTarget(object)
	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget) or __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if
		__wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58])
		or __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].target)
	then
		return false
	end

	return true
end

function ActivateAbility(object, instance, _, p)
	if instance:IsA(wolftype) then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local magikForceCalc = module.magikForceCalc(instance, p, mOwner)
	module.magikEnergyCalc(instance, p, mOwner)

	if p <= 1 then
		v = 20
	elseif p == 2 then
		v = 25
	elseif p == 3 then
		v = 30
	else
		v = 40
	end

	v *= magikForceCalc
	module.AddCastImmunity(instance)
	module.Fear(instance, 10)
	instance:MotionControl():__wf_atom_3a1d0c16(instance:__wf_atom_4e50d390())
	instance:__wf_atom_a1b79f95():__wf_atom_2b40a711(false)
	Sleep(0)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.numWolves) then
		__wf_atom_e919fb8e.numWolves = 0
	end

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v5

	if not __wf_atom_7e8ad928(pactFxType) then
		v5 = instance:Attach(pactFxType, EMPTY_SYMBOL)
	end

	instance:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end

	module.RemoveCastImmunity(instance)

	if gRegion:IsMaster() then
		local __wf_atom_0d9c1a58 = instance:__wf_atom_0d9c1a58()
		local position = instance:GetPosition()
		local __wf_atom_4e50d390 = instance:__wf_atom_4e50d390()
		__wf_atom_4e50d390.pitch = 0
		__wf_atom_4e50d390.bank = 0
		local entity = gRegion:CreateEntity(wolftype, position, __wf_atom_4e50d390, __wf_atom_0d9c1a58)

		if __wf_atom_7e8ad928(entity) then
			object:__wf_atom_e8954328()
			return
		end

		entity:__wf_atom_6a95c7b8(instance)
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true, true)
		secondaryScriptArgs:__wf_atom_a17e41c6(entity)
		object:__wf_atom_e6831c5c(mOwner, Symbol("WolfSpawn"), secondaryScriptArgs)
		local __wf_atom_921c1a5f = entity:__wf_atom_921c1a5f(summonJumpInAnim, false, 4, 1)
		fn(instance, entity, true)
		fn2(instance, entity)
		entity:GiveItem(wolfweapon, false)
		entity:__wf_atom_8914dfde("TakeOver", __wf_atom_921c1a5f)
		__wf_atom_e919fb8e.numWolves += 1
		local v6 = v
		local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
		local __wf_atom_d2b2176d = entity:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_da1b89a8()
		__wf_atom_d2b2176d:Update(0)

		if not __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
			entity:__wf_atom_6a95c7b8(instance)
			__wf_atom_0d9c1a58:__wf_atom_6c552f4c(4, entity)
			__wf_atom_0d9c1a58:AssignAvatar(entity)
			Sleep(0.1)
			entity:Attach(takeOverFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			local cameraControl = entity:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_dc7b15db(wolfColorGrade, 0, -1, 0, 1)
				cameraControl:__wf_atom_5626a8c4(0.7, 1.05, 1.05, v6)
			end
		end

		local currentSparrowDestination = module2.GetCurrentSparrowDestination()
		local v7

		if not (__wf_atom_7e8ad928(currentSparrowDestination) or __wf_atom_7e8ad928(currentSparrowDestination.entity)) then
			if currentSparrowDestination.entity:IsA(__wf_atom_9e85eea2) then
				v7 = __wf_atom_7d789620:__wf_atom_6acb01b3(currentSparrowDestination.entity, 2, 5)
			else
				v7 = __wf_atom_7d789620:__wf_atom_0e0a6fee(currentSparrowDestination.entity:GetPosition(), 20, 10)
			end
		end

		local v8

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_a06d543c = entity:__wf_atom_a06d543c()
			local __wf_atom_a2a18137 = entity:__wf_atom_a2a18137()
			__wf_atom_a2a18137.y = entity:EyePosition().y
			local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_a2a18137 + __wf_atom_a06d543c * 5)
			local __wf_atom_2f2bada0 = entity:__wf_atom_2f2bada0()
			local v9 = Symbol("RandomTeam")
			v8 = __wf_atom_7d789620:__wf_atom_402b3832(smellType, __wf_atom_0e0a6fee, __wf_atom_2f2bada0, v9, 1)
			v8:__wf_atom_b783ff91(v7)
		end

		object:__wf_atom_e6831c5c(mOwner, Symbol("WolfCloakMonitor"), secondaryScriptArgs)
		object:__wf_atom_6a4cf64f()
		local v9 = false
		local v10 = true

		while not __wf_atom_7e8ad928(entity) and not entity:IsKilled() and v6 > 0 do
			local v11 = HasQueuedSoulStealTarget(instance)

			if entity:__wf_atom_611b620c() and not v9 then
				v9 = true
			elseif v11 or __wf_atom_d2b2176d:__wf_atom_9f71ab59() or v9 and not entity:__wf_atom_611b620c() then
				instance:Attach(teleportOutFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

				if not v11 then
					local v12 = 0

					while v12 < 1 do
						v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93() / 0.75, 0, 1)
						instance:__wf_atom_68f2c268(v12)
						Sleep(0)
					end
				end

				if not __wf_atom_7e8ad928(entity) then
					position = entity:__wf_atom_a2a18137()
					__wf_atom_4e50d390 = entity:__wf_atom_2f2bada0()
				end

				instance:Teleport(position, __wf_atom_4e50d390)
				fn2(entity, instance)
				break
			else
				if instance:__wf_atom_c6f1f83d() < __wf_atom_c6f1f83d then
					break
				end

				fn3(object, entity, v10, __wf_atom_084b3e93())
				Sleep(0)
				v6 -= __wf_atom_084b3e93()
			end
		end

		fn3(object, entity, false, __wf_atom_084b3e93())
		object:__wf_atom_c497b0ae(1):__wf_atom_80e49f0d(30)

		if not __wf_atom_7e8ad928(v8) then
			local __wf_atom_50a7d83e = v8:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				__wf_atom_50a7d83e:Destroy()
			end
		end

		if not __wf_atom_7e8ad928(instance) then
			local __wf_atom_e919fb8e_2 = instance:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.teleportToPlayer = true
		end

		object:__wf_atom_e8954328()
	else
		if not instance:__wf_atom_4417a5d4() then
			return
		end

		while true do
			local playerAvatar = gRegion:GetPlayerAvatar()

			if playerAvatar ~= instance and playerAvatar == instance and not __wf_atom_7e8ad928(instance) then
				instance:__wf_atom_a1b79f95():__wf_atom_2b40a711(false)
			end

			Sleep(0)
		end
	end
end

function StartSoulSteal(object)
	while
		not __wf_atom_7e8ad928(object)
		and (__wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) or object:__wf_atom_63087342())
	do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		object:__wf_atom_92aa9d91():SetForceAim(true)
		local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:TryToActivateAbility(0)
		end

		object:__wf_atom_92aa9d91():SetForceAim(false)
	end
end

function DeactivateAbility(p, object, _, _, _)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.numWolves = math.max(0, (__wf_atom_e919fb8e.numWolves or 0) - 1)
	fn3(p, abilityStats, false, __wf_atom_084b3e93())

	if not __wf_atom_7e8ad928(abilityStats) then
		if object:__wf_atom_4417a5d4() then
			local __wf_atom_0d9c1a58 = object:__wf_atom_0d9c1a58()

			if not __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
				__wf_atom_0d9c1a58:AssignAvatar(object)
			end

			if HasQueuedSoulStealTarget(object) then
				object:__wf_atom_8a035cd5(Symbol("StartSoulSteal"), false)
			end

			object:__wf_atom_a1b79f95():__wf_atom_2b40a711(true)
		end

		if gRegion:IsMaster() then
			fn(abilityStats, object, false)
			fn2(abilityStats, object)
			local __wf_atom_0d9c1a58 = object:__wf_atom_0d9c1a58()

			if not __wf_atom_7e8ad928(object) then
				local __wf_atom_e919fb8e2 = object:__wf_atom_e919fb8e()

				if
					__wf_atom_7e8ad928(__wf_atom_e919fb8e2.teleportToPlayer)
					or not __wf_atom_e919fb8e2.teleportToPlayer
				then
					object:Teleport(abilityStats:__wf_atom_a2a18137(), (abilityStats:__wf_atom_2f2bada0()))
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
				object:__wf_atom_68f2c268(1)
				object:Attach(teleportInFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				object:PlaySound(desummonWhoosh, false, 1, false, nil, 1)
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(abilityStats) then
				abilityStats:Destroy()
			end

			Sleep(0.2)
			local v5 = 0

			while not __wf_atom_7e8ad928(object) and v5 < 1 do
				v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93(), 0, 1)
				object:__wf_atom_68f2c268((math.pow(1 - v5, 2)))
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_68f2c268(0)
				local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(castFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		else
			object:__wf_atom_68f2c268(1)
			object:Attach(teleportInFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			object:PlaySound(desummonWhoosh, false, 1, false, nil, 1)
			Sleep(0.2)
			local v5 = 0

			while not __wf_atom_7e8ad928(object) and v5 < 1 do
				v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93(), 0, 1)
				object:__wf_atom_68f2c268((math.pow(1 - v5, 2)))
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_68f2c268(0)
				local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(castFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		end
	end
end

function WolfSpawn(object, _, object2)
	if __wf_atom_7e8ad928(object2) then
		object:__wf_atom_e8954328()
		return
	end

	module.SetAbilityStats(object, mOwner, object2)

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_68f2c268(1)
		object2:Attach(wolfSummonAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		object2:PlaySound(summonWhoosh, false, 1, false, nil, 1)
	end

	local total = 0

	while total < 0.4 do
		total += __wf_atom_084b3e93()

		if __wf_atom_7e8ad928(object2) then
			object:__wf_atom_e8954328()
			return
		else
			object2:__wf_atom_68f2c268(1 - total)
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_68f2c268(0)
	end
end

function WolfCloakMonitor(_, _, object)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_f43b1463() ~= 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v5 = true

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_e919fb8e.stopCloak) do
		local v6 = __wf_atom_d2b2176d:__wf_atom_9f71ab59() or object:__wf_atom_611b620c()

		if (object:__wf_atom_08998754() == 2 and object:__wf_atom_ee4f0cba() > 1 or v6) and not v5 then
			object:__wf_atom_8a035cd5(Symbol("WolfShow"), false)
			object:__wf_atom_9373d0eb(7, false)
			v5 = true
		elseif object:__wf_atom_08998754() ~= 2 and not v6 and v5 then
			object:__wf_atom_8a035cd5(Symbol("WolfHide"), false)
			object:__wf_atom_9373d0eb(7, true)
			v5 = false
		end

		Sleep(0)
	end
end

function WolfHide(object)
	local v5 = 0

	while v5 < 0.8 and not __wf_atom_7e8ad928(object) do
		v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() / 0.2, 0, 0.8)
		object:__wf_atom_68f2c268(v5)
		Sleep(0)
	end
end

function WolfShow(object)
	local v5 = 0

	while v5 < 0.8 and not __wf_atom_7e8ad928(object) do
		v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() / 0.1, 0, 0.8)
		object:__wf_atom_68f2c268(0.8 - v5)
		Sleep(0)
	end
end