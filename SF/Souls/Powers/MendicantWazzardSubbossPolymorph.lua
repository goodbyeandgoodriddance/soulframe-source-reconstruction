local v = Symbol("WazzardPolymorph")

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

function Polymorph(instance, _, object, targetPosition)
	local __wf_atom_1c374cc9 = instance:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local __wf_atom_2f2bada0 = instance:__wf_atom_2f2bada0()
	local v2 = math.max(0, instance:__wf_atom_68de036a() + polymorphSpawnLevelDifferenceFromWazzard)
	local EMPTY_SYMBOL = EMPTY_SYMBOL

	if not __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b()) then
		EMPTY_SYMBOL = instance:__wf_atom_30e3d82b():__wf_atom_8537d7d4()
	end

	local __wf_atom_402b3832 = object:__wf_atom_402b3832(
		polymorphAgentType,
		__wf_atom_1c374cc9,
		__wf_atom_2f2bada0,
		EMPTY_SYMBOL,
		v2
	)
	local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetVisibility(true)
	end

	if __wf_atom_7e8ad928(__wf_atom_402b3832) then
		print("Entity is null!")
		return
	end

	local __wf_atom_50a7d83e2 = __wf_atom_402b3832:__wf_atom_50a7d83e()

	if transferStabilityToPolymorphs and instance:IsA(__wf_atom_7e6ed5fa) then
		local __wf_atom_50a7d83e3 = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e3) then
			local v3 = instance:__wf_atom_7470861b():__wf_atom_5d3f45d7() / instance:__wf_atom_7470861b():__wf_atom_96e24059() * __wf_atom_50a7d83e3:__wf_atom_7470861b():__wf_atom_96e24059()
			__wf_atom_50a7d83e3:__wf_atom_7470861b():__wf_atom_8577591c(v3)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e2) then
		__wf_atom_50a7d83e2:SetHealth(instance:__wf_atom_bb81a9df() * __wf_atom_50a7d83e2:GetMaxHealth(true))
	end

	_T.MendicantWazzardPolymorphForm = {
		entity = __wf_atom_402b3832,
		IsKilled = false,
		targetPosition = targetPosition
	}
end

local function fn2(object, _, p)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee((object:__wf_atom_a2a18137()))
	local v3 = Vector(__wf_atom_0e0a6fee.x, __wf_atom_0e0a6fee.y + 0.2, __wf_atom_0e0a6fee.z) + object:__wf_atom_a06d543c() * 3

	if not __wf_atom_7e8ad928(polymorphAgentType) and gRegion:IsMaster() then
		Polymorph(object, p, __wf_atom_2202ffb6, v3)
	end

	object:Attach(wazzardTransitionDeco, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(polymorphFxType) then
		object:Attach(polymorphFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	object:__wf_atom_d1b42aad(false)
	object:__wf_atom_30964595(false)
	object:__wf_atom_0ed81088(false)

	if gRegion:IsMaster() then
		object:__wf_atom_dd875cd8(true)
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v, 26, 6, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(v)
	end

	if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)) then
		local __wf_atom_50a7d83e = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:__wf_atom_3c986cd9(
			_T.MendicantWazzardPolymorphForm.targetPosition,
			__wf_atom_50a7d83e:__wf_atom_dc309f8a()
		)
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(wazzardPolymorphSpawnAnim, false, 3, 1, true)
		local __wf_atom_c082fc3d = __wf_atom_50a7d83e:__wf_atom_c082fc3d()
		local v4 = 0

		while v4 < 1 and not __wf_atom_7e8ad928(__wf_atom_50a7d83e) do
			v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() / 0.65, 0, 1)
			object:__wf_atom_68f2c268(__wf_atom_421b01aa(v4 * 6.5, 0, 1))
			__wf_atom_50a7d83e:SetMeshScale(__wf_atom_c082fc3d * v4)
			Sleep(0)
		end
	end

	object:SetVisibility(false)
	object:__wf_atom_68f2c268(0)

	if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)) then
		fn(_T.MendicantWazzardPolymorphForm.entity)
	end
end

local function fn3(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm)
		or _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e():__wf_atom_bb81a9df() < 0.15
	then
		return true
	end

	if __wf_atom_e919fb8e.polymorphSpawnStartTime == nil then
		__wf_atom_e919fb8e.polymorphSpawnStartTime = gGameRules:__wf_atom_2cec6d56()
	end

	local __wf_atom_2cec6d56 = gGameRules:__wf_atom_2cec6d56()

	if
		__wf_atom_e919fb8e.polymorphSpawnStartTime ~= nil
		and __wf_atom_e919fb8e.polymorphSpawnStartTime + polymorphTimerDuration < __wf_atom_2cec6d56
	then
		__wf_atom_e919fb8e.polymorphSpawnStartTime = nil
		return true
	end

	if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity) or _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e():IsKilled()) then
		return false
	end

	__wf_atom_e919fb8e.polymorphKilled = true
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

	local __wf_atom_a2a18137 = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e():__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e():__wf_atom_2f2bada0()

	if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)) then
		local __wf_atom_50a7d83e = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:Destroy()
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(__wf_atom_a2a18137)
		local entity = gRegion:CreateEntity(wazzardRespawnWarningFX, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
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
			__wf_atom_2f2bada0 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, __wf_atom_9a1e4ed3.avatar:__wf_atom_a2a18137())
		end

		if __wf_atom_8a6b8fc3 < doNotTeleportFailSafeDistance and gRegion:IsMaster() then
			object:Teleport(__wf_atom_0e0a6fee, __wf_atom_2f2bada0)
			object:__wf_atom_3c986cd9(__wf_atom_0e0a6fee, __wf_atom_2f2bada0)
		end

		gRegion:CreateEntity(respawnFX, __wf_atom_0e0a6fee, __wf_atom_80368bb1)
	end

	object:SetVisibility(true)
	object:__wf_atom_d1b42aad(true)
	object:__wf_atom_30964595(true)
	object:__wf_atom_0ed81088(true)
	object:__wf_atom_921c1a5f(respawnAnim, false, 4, 1, false)
end

local function fn5(object)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)
	then
		return
	end

	local __wf_atom_50a7d83e = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return
	end

	object:SetHealth((math.max(2, __wf_atom_50a7d83e:__wf_atom_c6f1f83d())))

	if transferStabilityToPolymorphs then
		local v2 = __wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_5d3f45d7() / __wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_96e24059() * object:__wf_atom_7470861b():__wf_atom_96e24059()
		object:__wf_atom_7470861b():__wf_atom_8577591c(v2)
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

	if object:__wf_atom_e919fb8e().polymorphKilled then
		Sleep(2.5)
	else
		if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)) then
			local __wf_atom_50a7d83e = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e()
			local entity = _T.MendicantWazzardPolymorphForm.entity

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				entity:SetPaused(true, (Symbol("AvatarPause")))
				entity:__wf_atom_b414eabf()
				__wf_atom_50a7d83e:__wf_atom_70c29967(polymorphFadeoutTime, 0, false)
			end

			gRegion:CreateEntity(
				polymorphDespawnDeco,
				__wf_atom_50a7d83e:GetPosition(),
				__wf_atom_50a7d83e:__wf_atom_dc309f8a()
			)
		end

		Sleep(polymorphFadeoutTime)
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
	__wf_atom_e919fb8e.polymorphSpawnStartTime = nil
	__wf_atom_e919fb8e.polymorphKilled = false

	if not (__wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm) or __wf_atom_7e8ad928(_T.MendicantWazzardPolymorphForm.entity)) then
		local __wf_atom_50a7d83e = _T.MendicantWazzardPolymorphForm.entity:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:Destroy()
		end
	end

	_T.MendicantWazzardPolymorphForm = nil
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