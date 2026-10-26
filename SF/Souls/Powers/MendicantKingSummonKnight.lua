local v = Symbol("BlockingBehavior")

function StormNearestPlayer(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_50a7d83e()) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local v2 = nil

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		if v3:__wf_atom_8a6b8fc3(__wf_atom_50a7d83e) < 9999 then
			v2 = v3
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		object:__wf_atom_30b587a4()
		object:StormTarget(v2)
	end
end

local function fn(object)
	local v2 = GetAllies(object)
	local count = 0

	for _, v3 in pairs(v2) do
		for _, className in pairs(knightAgentTypes) do
			if v3:IsA(className) then
				count += 1
			end
		end
	end

	if numberOfKnightsToSpawn <= count then
		return casterAgentType
	end

	return knightAgentTypes[__wf_atom_5784a397(1, #knightAgentTypes)]
end

local function fn2(object, object2, object3)
	local v2 = fn(object2)

	if not __wf_atom_7e8ad928(v2) and gRegion:IsMaster() then
		local position = object:GetPosition()
		local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
		local v3 = math.max(0, object2:__wf_atom_68de036a() + alliesSpawnLevelDifferenceFromKing)
		local EMPTY_SYMBOL = EMPTY_SYMBOL

		if not __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()) then
			EMPTY_SYMBOL = object2:__wf_atom_30e3d82b():__wf_atom_8537d7d4()
		end

		local __wf_atom_402b3832 = object3:__wf_atom_402b3832(v2, position, __wf_atom_2f2bada0, EMPTY_SYMBOL, v3)
		Sleep(Random(0.2, 0.4))

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			print("Entity is null!")
			return
		end

		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(spawnAnims[__wf_atom_5784a397(1, #spawnAnims)], false, 4, 1, false)
		StormNearestPlayer(__wf_atom_402b3832)
	end
end

local function fn3(object, list)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.HasFinishedSummoningInitialArmy == nil and #list < maxAllies then
		__wf_atom_e919fb8e.HasFinishedSummoningInitialArmy = false
		return true
	end

	if __wf_atom_e919fb8e.HasFinishedSummoningInitialArmy == false and #list < maxAllies then
		return true
	end

	local __wf_atom_2cec6d56 = gGameRules:__wf_atom_2cec6d56()

	if list ~= nil and #list >= maxAllies then
		__wf_atom_e919fb8e.HasFinishedSummoningInitialArmy = true
		return false
	end

	if list == nil or #list == 0 then
		if __wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay == nil then
			__wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay = gGameRules:__wf_atom_2cec6d56()
			return false
		end

		if
			__wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay == nil
			or not (__wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay + zeroAlliesDelayDuration < __wf_atom_2cec6d56)
		then
			return false
		end

		__wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay = nil
		__wf_atom_e919fb8e.lastAllySpawnTime = nil
	else
		if not (#list < maxAllies) then
			return false
		end

		if __wf_atom_e919fb8e.lastAllySpawnTime == nil then
			__wf_atom_e919fb8e.lastAllySpawnTime = gGameRules:__wf_atom_2cec6d56()
			return false
		end

		if
			__wf_atom_e919fb8e.lastAllySpawnTime == nil
			or not (__wf_atom_e919fb8e.lastAllySpawnTime + spawnAllyDelayDuration < __wf_atom_2cec6d56)
		then
			return false
		end

		__wf_atom_e919fb8e.lastAllySpawnTime = nil
		__wf_atom_e919fb8e.zeroAlliesSpawnTimeDelay = nil
	end

	return true
end

function GetAllies(p)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local __wf_atom_e0730826 = v2:__wf_atom_e0730826(p, 100, true, false)
	local result = {}
	local v3 = 1

	if __wf_atom_e0730826 == nil then
		return result
	end

	for _, v4 in pairs(__wf_atom_e0730826) do
		for _, className in pairs(knightAgentTypes) do
			if not v4:IsA(className) then
				continue
			end

			result[v3] = v4
			v3 += 1
		end

		if not v4:IsA(casterAgentType) then
			continue
		end

		result[v3] = v4
		v3 += 1
	end

	return result
end

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local v2 = GetAllies(object2)

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		return 0
	end

	if not fn3(object2, v2) then
		return 0
	end

	local all = gRegion:FindAll(corruptionSpawnDeco, object2:GetPosition(), 0, 50)

	if __wf_atom_7e8ad928(all) then
		return 0
	end

	for k in pairs(all) do
		if all[k]:__wf_atom_c6f1f83d() == -1 then
			continue
		end

		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	end

	return 0
end

function Unsummon(instance)
	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_58c8ffec(Symbol("UNSUMMON"), true, 3, 3, true)
		instance:Destroy()
	end
end

function DestroyMounds(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(_T.MendicantKingCurrentMounds) then
		for _, mendicantKingCurrentMound in pairs(_T.MendicantKingCurrentMounds) do
			if not __wf_atom_7e8ad928(mendicantKingCurrentMound) then
				mendicantKingCurrentMound:Destroy()
			end
		end
	end

	if not __wf_atom_7e8ad928(_T.WarningFXs) then
		for _, warningFX in pairs(_T.WarningFXs) do
			if not __wf_atom_7e8ad928(warningFX) then
				warningFX:Destroy()
			end
		end
	end

	local v2 = GetAllies(__wf_atom_6009c8ed)

	for _, v3 in pairs(v2) do
		local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("Unsummon"), false)
		end
	end
end

function HandleArmorUpgradeBasedOffAllies(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	while __wf_atom_6009c8ed:__wf_atom_06a75154() or __wf_atom_6009c8ed:__wf_atom_52077f7a(Symbol("IsReady")) ~= true do
		Sleep(0)
	end

	while true do
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		local v2 = __wf_atom_7e8ad928(__wf_atom_e919fb8e.previousAlliesCount) and 0
			or __wf_atom_e919fb8e.previousAlliesCount
		local v3 = GetAllies(__wf_atom_6009c8ed)

		if __wf_atom_7e8ad928(_T.MendicantSummonKnightFXInstance) and #v3 > 0 then
			__wf_atom_6009c8ed:__wf_atom_d2b2176d():AddUpgrade(20, 0, armourBuffAmount)
			local mendicantSummonKnightFXInstance = __wf_atom_6009c8ed:Attach(
				armourUpgradeActiveFX,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				__wf_atom_6009c8ed,
				1
			)
			_T.MendicantSummonKnightFXInstance = mendicantSummonKnightFXInstance
		elseif v2 > 0 and #v3 <= 0 then
			__wf_atom_6009c8ed:__wf_atom_d2b2176d():RemoveUpgrade(20, 0, armourBuffAmount)
			local mendicantSummonKnightFXInstance = _T.MendicantSummonKnightFXInstance
			_T.MendicantSummonKnightFXInstance = nil
			__wf_atom_6009c8ed:Attach(armourUpgradeBreakFX, EMPTY_SYMBOL)
			__wf_atom_6009c8ed:__wf_atom_58c8ffec(NoAlliesReactionSymbol, false, 4, 1, true, __wf_atom_5784a397(1, 3))

			if not __wf_atom_7e8ad928(mendicantSummonKnightFXInstance) then
				mendicantSummonKnightFXInstance:Destroy()
			end
		end

		__wf_atom_e919fb8e.previousAlliesCount = #v3
		Sleep(0)
	end
end

function ActivateAbility(p, object)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local all = gRegion:FindAll(corruptionSpawnDeco, object:GetPosition(), 0, 50)

	for k in pairs(all) do
		if all[k]:__wf_atom_c6f1f83d() == -1 then
			all[k] = nil
		end
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(all) then
		return
	end

	local v3 = 1000
	local v4 = nil

	for _, v5 in pairs(all) do
		if __wf_atom_7e8ad928(v5) then
			continue
		end

		local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(v5)

		if not (__wf_atom_8a6b8fc3 < v3) then
			continue
		end

		v4 = v5
		v3 = __wf_atom_8a6b8fc3
	end

	if v4 == nil then
		print("Could not find valid corruption entity nearby!")
		return
	end

	if gRegion:IsMaster() then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object)
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v4:GetPosition())
		__wf_atom_30e3d82b:__wf_atom_b783ff91(__wf_atom_0e0a6fee)
		__wf_atom_30e3d82b:StartMoving(__wf_atom_0e0a6fee, 0, true)
		local __wf_atom_2cec6d56 = gGameRules:__wf_atom_2cec6d56()
		local flag = true

		while gGameRules:__wf_atom_2cec6d56() <= __wf_atom_2cec6d56 + moveTimeoutDuration do
			if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v4) then
				print("entity is null!")
				return
			end

			if object:__wf_atom_8a6b8fc3(v4) < closeEnoughDistance then
				flag = false
				break
			else
				Sleep(0)
			end
		end

		if flag then
			print("Timed out moving towards target")
			return
		end

		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_702e65d8(v4, true)
		object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, false)
		object:__wf_atom_8914dfde(animEvent, 2)
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
		Sleep(0.5)
		local damageData = Engine.DamageData()
		damageData.baseAmount = 200
		damageData:__wf_atom_7498285f(7, 1)
		damageData:__wf_atom_6b472125(object)
		damageData:__wf_atom_34a8a27a(p)

		if __wf_atom_7e8ad928(v4) then
			print("Mound no longer exists!")
			return
		else
			v4:__wf_atom_649bf33e(damageData)
			fn2(v4, object, __wf_atom_2202ffb6)
		end
	end

	if not __wf_atom_7e8ad928(activateAnim) then
		while object:__wf_atom_c138b19b(activateAnim) do
			Sleep(0.1)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end
end