local v = Symbol("WazzardSpiderPolymorph")

local function fn(entity)
	if __wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(entity:__wf_atom_50a7d83e()) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_50a7d83e = entity:__wf_atom_50a7d83e()
	local v2 = nil

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		if v3:__wf_atom_8a6b8fc3(__wf_atom_50a7d83e) < 9999 then
			v2 = v3
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		entity:__wf_atom_30b587a4()
		entity:StormTarget(v2)
	end
end

function SpawnSpider(object, _, object2, targetPosition)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local v2 = __wf_atom_fa8d0177(object:GetPosition(), targetPosition)
	local v3 = math.max(0, object:__wf_atom_68de036a() + spidersSpawnLevelDifferenceFromWazzard)
	local EMPTY_SYMBOL = EMPTY_SYMBOL

	if not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
		EMPTY_SYMBOL = object:__wf_atom_30e3d82b():__wf_atom_8537d7d4()
	end

	local __wf_atom_402b3832 = object2:__wf_atom_402b3832(spiderAgentType, __wf_atom_1c374cc9, v2, EMPTY_SYMBOL, v3)
	local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetVisibility(true)
	end

	if __wf_atom_7e8ad928(__wf_atom_402b3832) then
		print("Entity is null!")
		return
	end

	if __wf_atom_7e8ad928(_T.MendicantWazzardSpiders) then
		_T.MendicantWazzardSpiders = {}
	end

	_T.MendicantWazzardSpiders[#_T.MendicantWazzardSpiders + 1] = {
		entity = __wf_atom_402b3832,
		IsKilled = false,
		targetPosition = targetPosition
	}
end

local function fn2(object, _, object2)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local v3 = spiderSpawnSpreadHalfAngle * 2 / numberOfSpidersToSpawn
	local v4 = -spiderSpawnSpreadHalfAngle
	local v5 = {}

	for _ = 1, numberOfSpidersToSpawn do
		local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		local __wf_atom_ff1686f2 = spiderSpawnRadiusRange:__wf_atom_ff1686f2()
		local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
		local v6

		if __wf_atom_7e8ad928(object2) then
			v6 = __wf_atom_a2a18137 + object:__wf_atom_a06d543c() * 4 - __wf_atom_a2a18137
		else
			v6 = object2:__wf_atom_a2a18137() - __wf_atom_a2a18137
		end

		Normalize(v6)
		local v7 = __wf_atom_9341614d(v6, Rotation(v4, 0, 0))
		local v8 = __wf_atom_a2a18137.x + v7.x * __wf_atom_ff1686f2
		local v9 = __wf_atom_a2a18137.z + v7.z * __wf_atom_ff1686f2
		local v10 = Vector(v8, __wf_atom_a2a18137.y, v9)
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v10)
		local v11 = Vector(__wf_atom_0e0a6fee.x, __wf_atom_0e0a6fee.y + 0.2, __wf_atom_0e0a6fee.z)

		if debugDraw then
			local v12 = Color(255, 0, 93)
			gRegion:__wf_atom_8d991675(v11, 1, v12, 3)
		end

		if not __wf_atom_7e8ad928(spiderAgentType) and gRegion:IsMaster() then
			SpawnSpider(object, object2, __wf_atom_2202ffb6, v11)
		end

		object:Attach(
			wazzardTransitionDeco,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_fa8d0177(__wf_atom_a2a18137, v10)
		)
		v5[#v5 + 1] = v11
		v4 += v3
	end

	object:SetVisibility(false)
	object:__wf_atom_d1b42aad(false)
	object:__wf_atom_30964595(false)
	object:__wf_atom_0ed81088(false)

	if gRegion:IsMaster() then
		object:__wf_atom_dd875cd8(true)
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v, 26, 6, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(v)
	end

	local v6 = 0

	for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
		if __wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) then
			continue
		end

		local __wf_atom_50a7d83e = mendicantWazzardSpider.entity:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:__wf_atom_3c986cd9(
			mendicantWazzardSpider.targetPosition,
			__wf_atom_50a7d83e:__wf_atom_dc309f8a()
		)
		v6 = __wf_atom_50a7d83e:__wf_atom_921c1a5f(spiderJumpAnim, false, 3, 1, true)
	end

	Sleep(v6)

	for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
		if not (__wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity)) then
			fn(mendicantWazzardSpider.entity)
		end
	end
end

local function fn3(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(_T.MendicantWazzardSpiders) then
		return true
	end

	if __wf_atom_e919fb8e.spiderSpawnStartTime == nil then
		__wf_atom_e919fb8e.spiderSpawnStartTime = gGameRules:__wf_atom_2cec6d56()
	end

	local __wf_atom_2cec6d56 = gGameRules:__wf_atom_2cec6d56()

	if
		__wf_atom_e919fb8e.spiderSpawnStartTime ~= nil
		and __wf_atom_e919fb8e.spiderSpawnStartTime + spiderTimerDuration < __wf_atom_2cec6d56
	then
		__wf_atom_e919fb8e.spiderSpawnStartTime = nil
		return true
	end

	for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
		if not (__wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) or mendicantWazzardSpider.entity:__wf_atom_50a7d83e():IsKilled()) then
			return false
		end
	end

	__wf_atom_e919fb8e.spidersAllKilled = true
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return true
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		local __wf_atom_7d789620 = __wf_atom_2202ffb6:__wf_atom_7d789620()

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			__wf_atom_30e3d82b:__wf_atom_5a0e15fd(
				abilityGlobalCooldownSymbol,
				__wf_atom_7d789620:__wf_atom_179042e1() + abilityGlobalCooldownDuration
			)
		end
	end

	return true
end

local function fn4(p, object)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	if not __wf_atom_7e8ad928(_T.MendicantWazzardSpiders) then
		for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
			if __wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) then
				continue
			end

			local __wf_atom_50a7d83e = mendicantWazzardSpider.entity:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				__wf_atom_50a7d83e:Destroy()
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
		local v3 = math.rad((__wf_atom_5784a397(0, 360)))
		local __wf_atom_a2a18137 = __wf_atom_9a1e4ed3.avatar:__wf_atom_a2a18137()
		local __wf_atom_ff1686f2 = respawnFromPlayerRange:__wf_atom_ff1686f2()
		local v4 = __wf_atom_a2a18137.x + __wf_atom_ff1686f2 * math.cos(v3)
		local v5 = __wf_atom_a2a18137.z + __wf_atom_ff1686f2 * math.sin(v3)
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee((Vector(v4, __wf_atom_a2a18137.y, v5)))
		local entity = gRegion:CreateEntity(wazzardRespawnWarningFX, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
		local v6 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, __wf_atom_9a1e4ed3.avatar:__wf_atom_a2a18137())
		local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(__wf_atom_9a1e4ed3.avatar)
		Sleep(warningToRespawnDuration)

		if __wf_atom_7e8ad928(object) then
			print("agent no longer exists!")
			return
		end

		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = AOEDamageAmount
		radialDamageData.stabilityDamage = AoeStabilityDamageAmount
		radialDamageData.radius = AoeDamageRadius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_7498285f(7, 1)
		radialDamageData:__wf_atom_98d98d81(__wf_atom_0e0a6fee + Vector(0, 1, 0))
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		gRegion:__wf_atom_f6ec80de(radialDamageData)

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end

		if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
			v6 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, __wf_atom_9a1e4ed3.avatar:__wf_atom_a2a18137())
		end

		if __wf_atom_8a6b8fc3 < doNotTeleportFailSafeDistance and gRegion:IsMaster() then
			object:Teleport(__wf_atom_0e0a6fee, v6)
			object:__wf_atom_3c986cd9(__wf_atom_0e0a6fee, v6)
		end

		gRegion:CreateEntity(respawnFX, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
	end

	object:SetVisibility(true)
	object:__wf_atom_d1b42aad(true)
	object:__wf_atom_30964595(true)
	object:__wf_atom_0ed81088(true)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.spidersAllKilled ~= nil and __wf_atom_e919fb8e.spidersAllKilled == true then
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()
		local damageAmountOnRespawn2 = damageAmountOnRespawn

		if __wf_atom_c6f1f83d < damageAmountOnRespawn then
			damageAmountOnRespawn2 = __wf_atom_c6f1f83d - 2
		end

		if not (object:IsKilled() or object:__wf_atom_bedb4e3f()) then
			object:SetHealth(__wf_atom_c6f1f83d - damageAmountOnRespawn2)
		end
	end

	object:__wf_atom_921c1a5f(respawnAnim, false, 4, 1, false)
end

local function fn5(object)
	for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
		if __wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) then
			continue
		end

		local __wf_atom_50a7d83e = mendicantWazzardSpider.entity:__wf_atom_50a7d83e()

		if mendicantWazzardSpider.IsKilled or not __wf_atom_50a7d83e:IsKilled() then
			continue
		end

		mendicantWazzardSpider.IsKilled = true
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()
		local damageAmountOnSpiderDeath2 = damageAmountOnSpiderDeath

		if __wf_atom_c6f1f83d < damageAmountOnSpiderDeath then
			damageAmountOnSpiderDeath2 = __wf_atom_c6f1f83d - 2
		end

		if not (object:IsKilled() or object:__wf_atom_bedb4e3f()) then
			object:SetHealth(__wf_atom_c6f1f83d - damageAmountOnSpiderDeath2)
		end
	end
end

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
		and not object2:__wf_atom_bedb4e3f()
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

function ActivateAbility(p, object, p2)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_702e65d8(p2, true)
	end

	object:__wf_atom_8d98f2fc(false, false, false)
	object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, true)
	object:__wf_atom_8914dfde(warningFxEvent, 2)
	fn2(object, p, p2)

	repeat
		Sleep(0)
		fn5(object)
	until fn3(object)

	if object:__wf_atom_e919fb8e().spidersAllKilled then
		Sleep(2.5)
	else
		for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
			if __wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) then
				continue
			end

			local __wf_atom_50a7d83e = mendicantWazzardSpider.entity:__wf_atom_50a7d83e()
			local entity = mendicantWazzardSpider.entity

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				entity:SetPaused(true, (Symbol("AvatarPause")))
				entity:__wf_atom_b414eabf()
				__wf_atom_50a7d83e:__wf_atom_70c29967(spiderFadeoutTime, 0, false)
			end

			gRegion:CreateEntity(
				spiderDespawnDeco,
				__wf_atom_50a7d83e:GetPosition(),
				__wf_atom_50a7d83e:__wf_atom_dc309f8a()
			)
		end

		Sleep(spiderFadeoutTime)
	end

	if __wf_atom_7e8ad928(object) then
		print("agent no longer exists!")
		return
	end

	fn4(p, object)
	__wf_atom_30e3d82b:__wf_atom_920a5a62()
end

function DeactivateAbility(_, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	if gRegion:IsMaster() then
		object:__wf_atom_dd875cd8(false)
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9f17ac89(v)
		__wf_atom_7470861b:__wf_atom_63396172(v)
	end

	object:__wf_atom_8d98f2fc(true, true, true)

	if not object:__wf_atom_c138b19b(respawnAnim, true) then
		object:__wf_atom_2f91774e()
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.spiderSpawnStartTime = nil
	__wf_atom_e919fb8e.spidersAllKilled = false

	if not __wf_atom_7e8ad928(_T.MendicantWazzardSpiders) then
		for _, mendicantWazzardSpider in pairs(_T.MendicantWazzardSpiders) do
			if __wf_atom_7e8ad928(mendicantWazzardSpider) or __wf_atom_7e8ad928(mendicantWazzardSpider.entity) then
				continue
			end

			local __wf_atom_50a7d83e = mendicantWazzardSpider.entity:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				__wf_atom_50a7d83e:Destroy()
			end
		end
	end

	_T.MendicantWazzardSpiders = {}
end

function TransitionDecoToTarget(object, p, p2, p3)
	Vector(0, 0, 0)
	local v2 = 0

	while v2 < 1 and not __wf_atom_7e8ad928(object) do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / p3, 0, 1)
		object:SetPosition((__wf_atom_f55d6358(p, p2, v2)))
		Sleep(0)
	end
end