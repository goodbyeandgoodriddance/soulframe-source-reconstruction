require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")

local function fn(p) -- 1 equivalent call inferred from this helper
	return 1 - math.pow(1 - p, 3)
end

local function fn2(instance, p, p2, fn3, p3)
	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	local total = 0
	__wf_atom_fa8d0177(__wf_atom_28d5d4aa, p - __wf_atom_a2a18137)

	if p3 == nil then
		p3 = 0.5
	end

	while total < p2 and p3 < Distance(instance:__wf_atom_a2a18137(), p) do
		local v

		if fn3 == nil then
			v = fn(total / p2) -- inferred equivalent call
		else
			v = fn3(total / p2)
		end

		local v2 = (1 - v) * __wf_atom_a2a18137 + v * p
		instance:SetPosition(v2)
		__wf_atom_fa8d0177(__wf_atom_28d5d4aa, p - v2)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function DissolveOut(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v = 0

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 1, 0, 1)
		object:__wf_atom_68f2c268(v)
		Sleep(0)
	end
end

local function fn3(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_15b36b95(p)
	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if
		__wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhost)
		or __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58])
	then
		return
	end

	for _, v in pairs(_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58]) do
		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_15b36b95(p)
		end
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if __wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443() then
		local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget

		if
			distanceToTarget >= 0
			and distanceToTarget <= triggerDistance
			and avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5
		then
			object:__wf_atom_f7170fc9(avatar)
			return 1
		end
	end

	return 0
end

function ActivateAbility(p, object, avatar, _)
	module2.PlayGlobalTransmission(transmissionSet, Symbol("DecoySpawn"))
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if gRegion:IsMaster() then
		local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
		local v = 5

		if
			__wf_atom_7e8ad928(avatar)
			and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
		then
			avatar = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar
		end

		if __wf_atom_7e8ad928(avatar) then
			avatar = object
		end

		if __wf_atom_7e8ad928(avatar) then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			v = __wf_atom_35a10d3c:__wf_atom_55da7898()
		end

		theta = math.rad(theta)
		local v2 = 6.283185307179586 / (spawnAvatarAmount + 1)
		local __wf_atom_2f2bada0 = avatar:__wf_atom_2f2bada0()
		local __wf_atom_a2a18137 = avatar:__wf_atom_a2a18137()
		local v3 = Rotation(__wf_atom_2f2bada0.heading, 0, 0)
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local v4 = {}

		for _ = 0, spawnAvatarAmount do
			local v5 = __wf_atom_9341614d(
				Vector(spawnCircleRadius * math.sin(theta), 0, spawnCircleRadius * math.cos(theta)),
				v3
			) + avatar:__wf_atom_a2a18137()

			if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
				v5 = __wf_atom_7d789620:__wf_atom_0e0a6fee(v5) + spawnAvatarOffset
			end

			table.insert(v4, v5)
			theta += v2
		end

		fn3(object, false)
		local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(castAnim, false, 2, 1, true)
		local v5 = castAnim:__wf_atom_091354f5(Symbol("CastPower")) * __wf_atom_921c1a5f

		if showDebug then
			for i = 1, #v4 do
				if showDebug then
					gRegion:__wf_atom_b5c21154(v4[i], 1, debugColour, Rotation(0, 90, 0), v5)
				end
			end
		end

		object:__wf_atom_8914dfde("CastPower", 10)
		DissolveOut(object)

		for i = 1, #v4 do
			gRegion:CreateEntity(spawnAvatarFX, v4[i], __wf_atom_80368bb1, object, object, 1)
		end

		Sleep(0.5)

		if __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhost) then
			_T.CircadeGhostKnightTrickGhost = {}
		end

		if __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhostHitWrong) then
			_T.CircadeGhostKnightTrickGhostHitWrong = {}
		end

		local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()
		_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58] = {}
		_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58] = {}
		_T.CircadeGhostKnightTrickHitWrong = 0
		local v6 = __wf_atom_5784a397(0, 2)
		local v7 = v4[1]
		local v8 = __wf_atom_fa8d0177(v4[1], __wf_atom_a2a18137)
		object:Teleport(v4[1], v8)
		object:__wf_atom_68f2c268(0)
		print(object:GetName())
		local spawnAvatar = spawnAvatar

		if usingHealVersion then
			spawnAvatar = healVersionSpawnAvatar
		end

		for i = 2, spawnAvatarAmount + 1 do
			local v9 = __wf_atom_fa8d0177(v4[i], __wf_atom_a2a18137)
			local v10

			if v6 == i then
				object:Teleport(v4[i], v9)
				v10 = gRegion:CreateEntity(spawnAvatar, v7, v8, object)
			else
				v10 = gRegion:CreateEntity(spawnAvatar, v4[i], v9, object)
			end

			local __wf_atom_d2b2176d = v10:__wf_atom_d2b2176d()
			table.insert(_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58], v10)
			v10:GiveItem(Resource(__wf_atom_35a10d3c), true)
			__wf_atom_d2b2176d:Equip(v, 0, 2)
			v10:__wf_atom_921c1a5f(trickAnim, false, 2, 2, true)
			v10:SetDisableGravity(true)
		end

		object:SetDisableGravity(true)
		object:__wf_atom_c2377fc8(Symbol("GAME_C1_HEAD1"), false)
		object:__wf_atom_921c1a5f(trickAnim, false, 2, 2, true)

		if not __wf_atom_7e8ad928(realAvatarGhostModeRevealingEffect) then
			object:Attach(realAvatarGhostModeRevealingEffect, EMPTY_SYMBOL, Vector(0, 1.3, 0), __wf_atom_80368bb1, p, 1)
			_T.NeedSoulModeVisUpdate = true
		end

		fn3(object, true)
		local v9 = false

		while
			(usingHealVersion and not triggerHealOnOneWrongHit and _T.CircadeGhostKnightTrickHitWrong < spawnAvatarAmount or not usingHealVersion and _T.CircadeGhostKnightTrickHitWrong == 0 or usingHealVersion and triggerHealOnOneWrongHit and _T.CircadeGhostKnightTrickHitWrong == 0)
			and not (v9 or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
		do
			v9 = object:__wf_atom_30e3d82b():__wf_atom_211da8d8() < 1

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not module.IsSoulModeActive(__wf_atom_c4f78a8f) then
				object:__wf_atom_9b5dcd3b(trickAnim, false, 2, 2, false)
			else
				object:__wf_atom_9b5dcd3b(tauntAnim, false, 2, 2, false)
			end

			Sleep(0)
		end

		if v9 then
			object:__wf_atom_921c1a5f(hitCorrectQuitAnim, false, 2, 1, true)
		else
			object:__wf_atom_921c1a5f(hitWrongQuitAnim, false, 2, 1, true)
		end
	else
		object:__wf_atom_8914dfde("CastPower", 10)
		object:SetDisableGravity(true)
		object:__wf_atom_c2377fc8(Symbol("GAME_C1_HEAD1"), false)
		local spawnAvatar = spawnAvatar

		if usingHealVersion then
			spawnAvatar = healVersionSpawnAvatar
		end

		local all = gRegion:FindAll(spawnAvatar)

		while __wf_atom_7e8ad928(all) or #all ~= spawnAvatarAmount do
			Sleep(0)
			all = gRegion:FindAll(spawnAvatar)
		end

		for _, v in ipairs(all) do
			v:SetDisableGravity(true)
		end

		object:__wf_atom_921c1a5f(trickAnim, false, 2, 2, false)

		while not (object:__wf_atom_c138b19b(hitCorrectQuitAnim) or object:__wf_atom_c138b19b(hitWrongQuitAnim)) do
			if object:__wf_atom_c138b19b(trickAnim) or object:__wf_atom_c138b19b(tauntAnim) then
				if
					__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
					or not (module.IsSoulModeActive(__wf_atom_c4f78a8f) and object:__wf_atom_c138b19b(trickAnim))
				then
					if object:__wf_atom_c138b19b(tauntAnim) and not module.IsSoulModeActive(__wf_atom_c4f78a8f) then
						object:__wf_atom_9b5dcd3b(trickAnim, false, 2, 2, false)
					end
				else
					object:__wf_atom_9b5dcd3b(tauntAnim, false, 2, 2, false)
				end
			end

			Sleep(0)
		end
	end
end

function MoveBackToSource(instance)
	local creator = instance:GetCreator()
	instance:__wf_atom_51075230((__wf_atom_fa8d0177(instance:__wf_atom_a2a18137(), creator:__wf_atom_a2a18137())))
	instance:__wf_atom_921c1a5f(ghostFlyBackAnim, false, 2, 1, true)
	fn2(
		instance,
		creator:__wf_atom_a2a18137() + ghostMovingBackTargetOffset,
		ghostMovingBackTime,
		fn,
		ghostMovingBackStopDistance
	)
	gRegion:CreateEntity(healFX, instance:GetPosition() + Vector(0, 1.5, 0), __wf_atom_80368bb1)
	creator:Attach(healAttachFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	instance:Destroy()
end

local function fn4(p, __wf_atom_18aa6e58)
	if
		__wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhostHitWrong)
		or __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58])
	then
		return false
	end

	for _, v in pairs(_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58]) do
		if not __wf_atom_7e8ad928(v) and p == v then
			return true
		end
	end

	return false
end

function DestroyWrongAvatar(instance)
	gRegion:CreateEntity(destroyAvatarFX, instance:__wf_atom_a2a18137(), __wf_atom_80368bb1, nil, nil, 1)
	Sleep(0.5)
	instance:Destroy()
end

function DeactivateAbility(_, object, _, _)
	fn3(object, true)
	object:SetDisableGravity(false)
	object:__wf_atom_c2377fc8(Symbol("GAME_C1_HEAD1"), true)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

		if not __wf_atom_7e8ad928(realAvatarGhostModeRevealingEffect) then
			object:__wf_atom_0650fed7(realAvatarGhostModeRevealingEffect)
		end

		if
			__wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhost)
			or __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58])
		then
			return
		end

		if not (__wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhostHitWrong) or __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58])) then
			for _, v in pairs(_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58]) do
				if __wf_atom_7e8ad928(v) then
					continue
				end

				v:__wf_atom_8a035cd5(Symbol("MoveBackToSource"), false)
				Sleep(wrongGhostMoveBackDelayTime)
			end
		end

		for _, v in pairs(_T.CircadeGhostKnightTrickGhost[__wf_atom_18aa6e58]) do
			if __wf_atom_7e8ad928(v) or fn4(v, __wf_atom_18aa6e58) then
				continue
			end

			if
				triggerHealOnOneWrongHit
				and not __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickHitWrong)
				and _T.CircadeGhostKnightTrickHitWrong > 0
			then
				v:__wf_atom_8a035cd5(Symbol("MoveBackToSource"), false)
				Sleep(wrongGhostMoveBackDelayTime)
			else
				v:__wf_atom_8a035cd5(Symbol("DestroyWrongAvatar"), false)
			end
		end

		local v = (object:GetMaxHealth() - object:__wf_atom_c6f1f83d()) * (healPercentage / 100)

		if not __wf_atom_7e8ad928(_T.CircadeGhostKnightTrickHitWrong) and _T.CircadeGhostKnightTrickHitWrong > 0 then
			object:Heal(
				object,
				v * (100 + (_T.CircadeGhostKnightTrickHitWrong - 1) * healPercentagePerOneMoreWrongAvatar) / 100
			)
		end
	end
end

function TrickAvatarOnDamage(instance, object)
	instance:__wf_atom_15b36b95(false)

	if gRegion:IsMaster() then
		local creator = instance:GetCreator()

		if __wf_atom_7e8ad928(creator) then
			return
		end

		local __wf_atom_18aa6e58 = creator:__wf_atom_18aa6e58()

		if fn4(instance, __wf_atom_18aa6e58) then
			return
		end

		module2.PlayGlobalTransmission(transmissionSet, Symbol("DecoyHit"))
		gRegion:CreateEntity(HitWrongAvatarFX, instance:__wf_atom_a2a18137(), __wf_atom_80368bb1, nil, nil, 1)

		if usingHealVersion then
			if triggerHealOnOneWrongHit then
				_T.CircadeGhostKnightTrickHitWrong += 1
			else
				table.insert(_T.CircadeGhostKnightTrickGhostHitWrong[__wf_atom_18aa6e58], instance)
				_T.CircadeGhostKnightTrickHitWrong += 1
				instance:SetDisableGravity(true)
				module.SetImmunity(instance, true)
				fn2(instance, instance:__wf_atom_a2a18137() + Vector(0, 1, 0), 1.2, fn)
				instance:Attach(healVersionAvatarAttachFX, EMPTY_SYMBOL, Vector(0, 1, 0), __wf_atom_80368bb1)
			end
		else
			local __wf_atom_679ed446 = object:__wf_atom_679ed446()
			local damageData = Engine.DamageData()
			local __wf_atom_e55d02aa = creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			damageData.baseAmount = HitWrongAvatarDamage
			damageData:__wf_atom_7498285f(damageType, 1)
			damageData:__wf_atom_d6f4d914(damageProc, true)
			damageData.baseProcChance = procChance
			damageData.stabilityDamage = HitWrongStabilityDamage

			if __wf_atom_7e8ad928(creator) then
				damageData:__wf_atom_6b472125(instance)
				damageData:__wf_atom_34a8a27a(instance)
			else
				damageData:__wf_atom_6b472125(creator)
				damageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
			end

			if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(__wf_atom_7e6ed5fa) then
				__wf_atom_679ed446:__wf_atom_649bf33e(damageData)
			end

			_T.CircadeGhostKnightTrickHitWrong += 1
			instance:Destroy()
		end
	elseif usingHealVersion and not triggerHealOnOneWrongHit then
		instance:SetDisableGravity(true)
	end
end