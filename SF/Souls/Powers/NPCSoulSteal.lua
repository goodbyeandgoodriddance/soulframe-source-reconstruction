mPlayerAvatars = {}
Vector(0, -0.15, 0)
local v = nil
local v2 = WeakResource("/SF/Types/Player/EnvoyAvatar")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Interface.SFUtilities")
require("Lotus.Scripts.Libs.EasingLib")
require("SF.Scripts.Libs.AncestorsFunctionLib")
require("SF.Souls.Powers.EntitySoulModeScans")
require("SF.Scripts.Libs.CommonFunctionsLib")
local v3 = nil
local pullTime = 0.75
local fn

local function fn2(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		__wf_atom_d2b2176d:Unequip(0, 2)
		Sleep(0)
	end
end

local function fn3() -- 1 equivalent call inferred from this helper
	mPlayerAvatars = gRegion:__wf_atom_ef7900cf()
end

function NpcEvaluateAbility(_, _, _)
	fn3() -- inferred equivalent call
	local mPlayerAvatar = mPlayerAvatars[1]

	if __wf_atom_7e8ad928(mPlayerAvatar) then
		return
	end

	if __wf_atom_7e8ad928((mPlayerAvatar:__wf_atom_bb3e7833(__wf_atom_faccb0cf))) then
		return 0
	end

	return 1
end

local function fn4(p, ...)
	module.SetAbilityStats(p, mOwner, { ... })
end

function CheckQueuedSoulStealTarget(object)
	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget) then
		return nil
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58]) then
		return nil
	end

	local target = _T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].target
	local pos = _T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].pos
	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58] = nil
	return target, pos
end

function QueueSoulStealTarget(object, target, pos)
	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget) then
		_T.SoulStealTargetQueuedTarget = {}
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58]) then
		_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58] = {}
	end

	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].target = target
	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].pos = pos
end

local function fn5(object, _, _, p, instigatorAvatar)
	if p <= 0 then
		return
	end

	object:__wf_atom_19516b62(p, (object:__wf_atom_2e4994f1(v)))
	local __wf_atom_e919fb8e = instigatorAvatar:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.numRuneCharges) then
		__wf_atom_e919fb8e.numRuneCharges = 1
	else
		__wf_atom_e919fb8e.numRuneCharges += 1
	end

	instigatorAvatar:__wf_atom_cecb2d55(Symbol("numRuneCharges"), __wf_atom_e919fb8e.numRuneCharges)
	Sleep(0)
end

local function fn6(object) -- 4 equivalent calls inferred from this helper
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_a8e8c5c4 = __wf_atom_d2b2176d:__wf_atom_a8e8c5c4()

	if
		__wf_atom_7e8ad928(__wf_atom_a8e8c5c4)
		or __wf_atom_d2b2176d:__wf_atom_d93821d0((__wf_atom_a8e8c5c4:__wf_atom_55da7898()))
	then
		return nil
	end

	return __wf_atom_a8e8c5c4
end

local function fn7(instigatorAvatar, object, _)
	local v4

	if instigatorAvatar:__wf_atom_8efce136() and instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_aba9c26e(0) ~= 14 then
		fn2(instigatorAvatar)
		v4 = true
	else
		v4 = false
	end

	if __wf_atom_7e8ad928(instigatorAvatar) or instigatorAvatar:IsKilled() then
		return
	end

	local v5 = module.PlayUpperBodyAnim(object, noTargetPullAnim, false, 2, 1, false)
	Sleep(v5)

	if instigatorAvatar:__wf_atom_8efce136() and v4 then
		local __wf_atom_a8e8c5c4 = fn6(instigatorAvatar) -- inferred equivalent call

		if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
			instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
		end
	end
end

function NotifySoulCollectChallenge(instance, object, object2)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_0d9c1a58 = object2:__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
		return
	end

	local v4 = instance:IsA(__wf_atom_4ebf67cb) or instance:IsA(__wf_atom_43e0c427)

	if not (v4 or __wf_atom_7e8ad928(object)) then
		v4 = not __wf_atom_7e8ad928(object:__wf_atom_87088114()) and object:__wf_atom_87088114():IsA(__wf_atom_4ebf67cb)
	end

	if not v4 then
		return
	end

	__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, Symbol("SOUL_COLLECT"))
end

function ActivateAbility(object, instigatorAvatar, entity, _, _)
	if __wf_atom_7e8ad928(entity) then
		if
			__wf_atom_7e8ad928(instigatorAvatar)
			or __wf_atom_7e8ad928(instigatorAvatar:__wf_atom_30e3d82b())
			or __wf_atom_7e8ad928(instigatorAvatar:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3())
			or __wf_atom_7e8ad928(instigatorAvatar:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity)
		then
			return
		else
			entity = instigatorAvatar:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end
	end

	if __wf_atom_7e8ad928(entity) then
		return
	end

	if __wf_atom_7e8ad928(entity) then
		fn7(instigatorAvatar, object)
		return
	end

	if instigatorAvatar:__wf_atom_8efce136() then
		_T.ForceSoulMode = true
	end

	local v4 = nil
	local stealAbility = module.GetStealAbility(entity)
	local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		fn7(instigatorAvatar, object)
		return
	end

	local isA = entity:IsA(__wf_atom_4ebf67cb)
	local isA2 = entity:IsA(__wf_atom_43e0c427)
	local v5

	if isA and entity then
		v5 = entity
	elseif isA2 then
		v5 = entity:__wf_atom_6009c8ed() or nil
	end

	local __wf_atom_e919fb8e = instigatorAvatar:__wf_atom_e919fb8e()
	local duplicateSoulSteal = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.DuplicateSoulSteal)
		and __wf_atom_e919fb8e.DuplicateSoulSteal
	instigatorAvatar:PlaySound(soulStealActivateSound, false, 1, false)
	local v6 = __wf_atom_fa8d0177(instigatorAvatar:GetPosition(), entity:GetPosition())
	instigatorAvatar:MotionControl():__wf_atom_3a1d0c16(v6)
	local info = not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:GetInfo() or SF.SoulStealInfo()
	local __wf_atom_bb3e7833_2 = entity:__wf_atom_bb3e7833(soulType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		v4 = __wf_atom_bb3e7833_2:__wf_atom_e919fb8e()
		v4.InstigatorAvatar = instigatorAvatar
	end

	local v7 = nil
	local v8 = not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsA(restoreType)
	local __wf_atom_35a10d3c = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local __wf_atom_a8e8c5c4 = fn6(instigatorAvatar) -- inferred equivalent call
	local v9

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
		v9 = 0
	else
		__wf_atom_35a10d3c:__wf_atom_36d7c7d8()
		v9 = __wf_atom_35a10d3c:__wf_atom_6170b185()
	end

	v = object:__wf_atom_248bb7ae(mMoteAbilityType)
	local __wf_atom_c497b0ae = object:__wf_atom_c497b0ae(v)

	if
		not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4)
		and not __wf_atom_7e8ad928(__wf_atom_c497b0ae)
		and __wf_atom_35a10d3c ~= __wf_atom_a8e8c5c4
		and v8
		and (isA or isA2)
	then
		if instigatorAvatar:__wf_atom_4417a5d4() then
			instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
		end

		if __wf_atom_a8e8c5c4:IsA(__wf_atom_77e05d3b) then
			__wf_atom_a8e8c5c4:__wf_atom_36d7c7d8()
			v9 = __wf_atom_a8e8c5c4:__wf_atom_6170b185()
		end
	end

	local v10 = v9 + 1
	assert(25 == 25)

	if __wf_atom_7e8ad928(v10) then
		v3 = enemyPullAnim[1]
	else
		v3 = enemyPullAnim[v10]
	end

	local v11

	if isA or isA2 then
		pullTime = 0.25
		instigatorAvatar:PlaySound(avatarTargetCastSound, false, 1, false)

		if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
			local weaponMote = module.GetWeaponMote(__wf_atom_a8e8c5c4)

			if not __wf_atom_7e8ad928(weaponMote) then
				instigatorAvatar:PlaySound(weaponMote:__wf_atom_cea69207(), false, 1, false)
			end
		end

		v11 = module.PlayAnim(object, v3, false, 4, 1, false)
		module.EnableWeaponFiring(instigatorAvatar, mOwner, false)
		v7 = v5:Attach(preStealTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)

		if v5:IsA(v2) then
			v5:__wf_atom_921c1a5f(envoySoulStealReaction, false, 4, 1, true)
		else
			v5:__wf_atom_58c8ffec(Symbol("SOUL_STEAL"), false, 4, 1, true)
		end
	else
		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			v4.PullTime = pullTime
		end

		v11 = module.PlayAnim(object, pullAnim, false, 4, 1, false)
		instigatorAvatar:PlaySound(otherTargetCastSound, false, 1, false)
	end

	local __wf_atom_ee2eb1db = info:__wf_atom_ee2eb1db()
	local v12 = Symbol("GAME_R1_ARM3")
	local _ = 0 <= 0
	fn5(object, __wf_atom_c497b0ae, __wf_atom_a8e8c5c4, 50, instigatorAvatar)
	instigatorAvatar:__wf_atom_8914dfde("SoulStealComplete", 3)
	local v13 = not duplicateSoulSteal and { instigatorAvatar } or gRegion:__wf_atom_ef7900cf()

	if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_bb3e7833)) then
		DoCrit(__wf_atom_bb3e7833, entity, instigatorAvatar, duplicateSoulSteal)
	end

	for _, v14 in ipairs(v13) do
		if isA2 then
			fn4(v14:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), fn, v5, __wf_atom_bb3e7833, stealAbility)
		else
			fn4(v14:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), fn, entity, __wf_atom_bb3e7833, stealAbility)
		end

		if not __wf_atom_7e8ad928(v7) then
			v7:Destroy()
		end

		if not (__wf_atom_7e8ad928(__wf_atom_ee2eb1db) or __wf_atom_7e8ad928(mOwner)) then
			mOwner:__wf_atom_7ccf4243(__wf_atom_ee2eb1db, v12, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end
end

function DoCrit(instance, instance2, instigatorAvatar, p)
	if __wf_atom_7e8ad928(instance2) and not __wf_atom_7e8ad928(instance) then
		instance2 = instance:__wf_atom_f7e7be53()
	end

	local v4 = nil
	local v5 = nil
	local __wf_atom_e55d02aa = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v6 = not __wf_atom_7e8ad928(instance2) and instance2:IsA(__wf_atom_4ebf67cb)
	local v7 = not __wf_atom_7e8ad928(instance2) and instance2:IsA(__wf_atom_43e0c427)
	local v8

	if v6 and instance2 then
		v8 = instance2
	elseif v7 then
		v8 = instance2:__wf_atom_6009c8ed() or nil
	end

	local __wf_atom_35a10d3c = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local __wf_atom_a8e8c5c4 = fn6(instigatorAvatar) -- inferred equivalent call
	local v9 = not __wf_atom_7e8ad928(instance) and instance:IsA(restoreType)

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
		__wf_atom_35a10d3c:__wf_atom_36d7c7d8()
	end

	local v10

	if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
		v10 = module.GetWeaponMoteAbility(__wf_atom_a8e8c5c4)

		if not __wf_atom_7e8ad928(v10) and __wf_atom_35a10d3c ~= __wf_atom_a8e8c5c4 and v9 and v6 then
			if instigatorAvatar:__wf_atom_4417a5d4() then
				instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
			end

			if __wf_atom_a8e8c5c4:IsA(__wf_atom_77e05d3b) then
				__wf_atom_a8e8c5c4:__wf_atom_36d7c7d8()
			end
		end
	end

	if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(instance2) or __wf_atom_7e8ad928(instigatorAvatar) or __wf_atom_7e8ad928(__wf_atom_e55d02aa)) then
		local __wf_atom_bb3e7833 = instance2:__wf_atom_bb3e7833(soulType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_e6ed03c8()
			local __wf_atom_e919fb8e = __wf_atom_bb3e7833:__wf_atom_e919fb8e()

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
				v4 = instance:__wf_atom_876731d0()
				v5 = instance:__wf_atom_9fe17f23()
				__wf_atom_e919fb8e.InstigatorAvatar = instigatorAvatar
			end

			local v11 = string.find(__wf_atom_bb3e7833:GetName(), "Spirit")
			local v12 = string.find(__wf_atom_bb3e7833:GetName(), "Grace")
			local v13 = string.find(__wf_atom_bb3e7833:GetName(), "Power")

			if __wf_atom_e55d02aa:__wf_atom_f5ca3244() then
				local __wf_atom_e919fb8e_2 = instigatorAvatar:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.wyldVirtueBuff = true
			end

			if v11 then
				__wf_atom_bb3e7833:Attach(
					spiritBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			elseif v12 then
				__wf_atom_bb3e7833:Attach(
					graceBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			elseif v13 then
				__wf_atom_bb3e7833:Attach(
					courageBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			end

			local __wf_atom_be0bea4a = instance2:__wf_atom_be0bea4a()
			local v14 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoCourage")
			local v15 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoGrace")
			local v16 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoSpirit")
			local v17 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoCourageChild")
			local v18 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoGraceChild")
			local v19 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoSpiritChild")

			for _, v20 in ipairs(__wf_atom_be0bea4a) do
				if not (v20:IsA(v14) or v20:IsA(v15) or v20:IsA(v16) or v20:IsA(v17) or v20:IsA(v18) or v20:IsA(v19)) then
					continue
				end

				v20:PlayTriggeredFade()
			end

			__wf_atom_bb3e7833:__wf_atom_8a035cd5(Symbol("PullToMe"), false)

			if p then
				for _, instigatorAvatar2 in gRegion:__wf_atom_ef7900cf() do
					if instigatorAvatar2 == instigatorAvatar then
						continue
					end

					local entity = gRegion:CreateEntity(
						Type(__wf_atom_bb3e7833),
						__wf_atom_bb3e7833:GetPosition(),
						__wf_atom_bb3e7833:__wf_atom_dc309f8a()
					)
					local __wf_atom_e919fb8e2 = entity:__wf_atom_e919fb8e()

					if __wf_atom_7e8ad928(__wf_atom_e919fb8e2) then
						continue
					end

					__wf_atom_e919fb8e2.InstigatorAvatar = instigatorAvatar2
					entity:__wf_atom_8a035cd5(Symbol("PullToMe"), false)
				end
			end
		end
	end

	local v11 = not p and { instigatorAvatar } or gRegion:__wf_atom_ef7900cf()

	for _, v12 in ipairs(v11) do
		local __wf_atom_e55d02aa2 = v12:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		module.Fear(v12, 8, true)

		if not (v6 or v7) or (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v12)) then
			continue
		end

		local v13 = instance2:GetPosition() - v12:GetPosition() + Vector(0, 1, 0)
		Normalize(v13)
		local damageData = Engine.DamageData()
		v8:__wf_atom_c6f1f83d()
		local __wf_atom_a8e8c5c4_2 = fn6(v12) -- inferred equivalent call
		local damageData2 = Engine.DamageData()

		if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4_2) then
			local __wf_atom_18007d51 = __wf_atom_a8e8c5c4_2:__wf_atom_18007d51()
			__wf_atom_18007d51:__wf_atom_c39e64aa(damageData2)
			__wf_atom_18007d51:__wf_atom_56712eb7(damageData2)

			if not __wf_atom_7e8ad928(v10) and v8:IsA(__wf_atom_7e6ed5fa) then
				fn5(__wf_atom_e55d02aa2, v10, __wf_atom_a8e8c5c4_2, v8:__wf_atom_a6233307(), instigatorAvatar)
			end
		end

		damageData.baseAmount = damageData2.baseAmount * enemyCritDmgAmount
		damageData:__wf_atom_7498285f(0, 1)

		if __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v5) then
			if __wf_atom_7e8ad928(__wf_atom_a8e8c5c4_2) then
				damageData:__wf_atom_6b472125(v12)
				damageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa2)
				print("soulSteal fallback from pact", __wf_atom_e55d02aa2:__wf_atom_5b41f63b())
			else
				damageData:__wf_atom_6b472125(v12)
				damageData:__wf_atom_34a8a27a(__wf_atom_a8e8c5c4_2)
				print("soulSteal fallback from last held weapon", __wf_atom_a8e8c5c4_2:__wf_atom_5b41f63b())
			end
		else
			damageData:__wf_atom_6b472125(v5)
			damageData:__wf_atom_34a8a27a(v4)
		end

		damageData:__wf_atom_12cf5317(v13 * -10)
		v8:__wf_atom_649bf33e(damageData)
	end
end

function DeactivateAbility(p, object)
	local __wf_atom_8efce136 = object:__wf_atom_8efce136()
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if abilityStats then
		local abilityStat = abilityStats[1]
		local abilityStat2 = abilityStats[2]
		local v4

		if __wf_atom_7e8ad928(abilityStat2) or not (abilityStat2:IsA(__wf_atom_4ebf67cb) and abilityStat2) then
			if not (__wf_atom_7e8ad928(abilityStat2) or not abilityStat2:IsA(__wf_atom_43e0c427)) then
				v4 = abilityStat2:__wf_atom_6009c8ed() or nil
			end
		else
			v4 = abilityStat2
		end

		module.EnableWeaponFiring(object, mOwner, true)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
			SF.__wf_atom_4659f336(__wf_atom_35a10d3c, true, false)
		end

		if not __wf_atom_7e8ad928(v4) then
			local __wf_atom_bb3e7833 = abilityStat2:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				local info = __wf_atom_bb3e7833:GetInfo()

				if not __wf_atom_7e8ad928(info) then
					local __wf_atom_7f40d458 = info:__wf_atom_7f40d458(true)

					if not __wf_atom_7e8ad928(__wf_atom_7f40d458) then
						gRegion:CreateEntity(__wf_atom_7f40d458, abilityStat2:GetPosition(), __wf_atom_80368bb1)
					end
				end
			end

			if v4:__wf_atom_fc8d8e90(Symbol("SOUL_STEAL")) then
				v4:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
			end
		end

		abilityStat(p, object, abilityStat2, unpack(abilityStats, 3))

		if __wf_atom_8efce136 then
			_T.ForceSoulMode = nil
		end

		while
			not __wf_atom_7e8ad928(object)
			and (object:__wf_atom_c138b19b(pullAnim, true) or object:__wf_atom_3c281634(pullAnim))
		do
			Sleep(0)
		end
	else
		while
			not __wf_atom_7e8ad928(object)
			and (object:__wf_atom_c138b19b(pullAnim, true) or object:__wf_atom_3c281634(pullAnim))
		do
			Sleep(0)
		end

		module.EnableWeaponFiring(object, mOwner, true)
	end
end

function LifeStealMoteApply(object, _)
	__wf_atom_f2daf912("Trying LifeSteal")

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	if __wf_atom_e55d02aa:__wf_atom_f3044fe0() >= __wf_atom_e55d02aa:__wf_atom_6a5c92a7() then
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

		if __wf_atom_c6f1f83d < object:GetMaxHealth() then
			__wf_atom_e55d02aa:__wf_atom_9e7c0c61(0)
			object:Heal(object, 50, object)
			object:NotifyHeal(object:__wf_atom_a96eb2aa(), 50, 0, 1)
			module.NotifyHeal(object, object:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
		end

		__wf_atom_f2daf912("Apply LifeSteal")
	end
end

local function fn8(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(_T.NumStolenEnergyRestores) then
		_T.NumStolenEnergyRestores = {}
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_6be84646 = object:__wf_atom_6be84646()
		local numStolenEnergyRestore = _T.NumStolenEnergyRestores[__wf_atom_6be84646]

		if __wf_atom_7e8ad928(numStolenEnergyRestore) then
			_T.NumStolenEnergyRestores[__wf_atom_6be84646] = 1
		else
			_T.NumStolenEnergyRestores[__wf_atom_6be84646] = numStolenEnergyRestore + 1
		end
	end
end

local function fn9(object, instance, info, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(info) then
		return
	end

	fn8(instance:__wf_atom_a96eb2aa())
	local __wf_atom_87a16e10 = object:__wf_atom_87a16e10()
	local v4 = math.max(info:__wf_atom_777fa6aa(), __wf_atom_084b3e93())
	local v5 = info:__wf_atom_fd53959a() + object:__wf_atom_6a5c92a7() * info:__wf_atom_fbd6c0a5()
	local __wf_atom_7d343c52 = info:__wf_atom_7d343c52()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local v6 = v5
	local __wf_atom_2a745663s = {}
	local v7 = {}
	local flag = false

	for i = 0, 2 do
		if not info:__wf_atom_d74a80d6(i) then
			continue
		end

		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			info:__wf_atom_fd53959a() + instance:GetAttribute(i) * info:__wf_atom_fbd6c0a5(),
			66,
			nil,
			nil,
			26,
			Symbol(module2.GetAttributeTypeTag(i))
		)
		__wf_atom_2a745663s[i] = __wf_atom_2a745663
		v7[i] = __wf_atom_2a745663
		v6 = info:__wf_atom_7d343c52()
		flag = true

		for j = 0, __wf_atom_87a16e10 - 1 do
			if object:__wf_atom_2e4994f1(j) ~= i then
				continue
			end

			local __wf_atom_c497b0ae = object:__wf_atom_c497b0ae(j)

			if __wf_atom_7e8ad928(__wf_atom_c497b0ae) then
				continue
			end

			local __wf_atom_1fcd5380 = __wf_atom_c497b0ae:__wf_atom_1fcd5380()

			if __wf_atom_1fcd5380 > 0 then
				__wf_atom_c497b0ae:__wf_atom_80e49f0d((math.max(
					__wf_atom_1fcd5380 - instance:__wf_atom_d2b2176d():__wf_atom_2a745663(
						30,
						222,
						object:__wf_atom_1bb5b1ff(),
						object,
						26,
						Symbol("FLOW_POINT_REDUCTION")
					),
					0
				)))
			end
		end
	end

	while
		not __wf_atom_7e8ad928(instance)
		and not __wf_atom_7e8ad928(object)
		and (__wf_atom_7e8ad928(object2) or object2:__wf_atom_4b409d7b(instance))
	do
		local v8 = __wf_atom_084b3e93() / v4
		local v9 = false

		if flag then
			local v10 = false

			for k, v11 in pairs(__wf_atom_2a745663s) do
				local v12 = math.min(v11 * v8, v7[k])

				if object:__wf_atom_f3044fe0(k) < object:__wf_atom_6a5c92a7(k) then
					object:__wf_atom_19516b62(v12, k)
					v10 = true
					v6 = 0
				end

				if not object2 then
					v7[k] -= v12
				end

				v9 = v9 or v7[k] > 0
			end

			if v10 or not (__wf_atom_7d343c52 > 0) then
				v6 = 0
			else
				local v11 = math.min(__wf_atom_7d343c52 * v8, v6)
				object:__wf_atom_19516b62(v11)
				v6 -= v11
				v9 = v9 or v6 > 0
			end
		else
			local v10 = math.min(v5 * v8, v6)
			object:__wf_atom_19516b62(v10)

			if not object2 then
				v6 -= v10
			end

			v9 = v6 > 0
		end

		if not v9 then
			break
		end

		Sleep(0)
	end
end

fn = function(object, object2, instance, instance2, object3)
	local info = not __wf_atom_7e8ad928(instance2) and instance2:GetInfo() or SF.SoulStealInfo()
	local __wf_atom_7f40d458 = info:__wf_atom_7f40d458(false)
	local __wf_atom_7f40d458_2 = info:__wf_atom_7f40d458(true)

	if not __wf_atom_7e8ad928(__wf_atom_7f40d458) then
		object2:Attach(__wf_atom_7f40d458, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(instance2) then
		if not __wf_atom_7e8ad928(__wf_atom_7f40d458_2) then
			gRegion:CreateEntity(__wf_atom_7f40d458_2, instance2:__wf_atom_a2a18137(), instance2:__wf_atom_2f2bada0())
		end

		if instance2:OnSteal(object2) then
			if not __wf_atom_7e8ad928(object3) then
				object3:SetEnabled(false)
			end

			if not __wf_atom_7e8ad928(instance2) and instance2:__wf_atom_e919fb8e().noDestroySoul == nil then
				instance2:Destroy()
			end
		end
	end

	if not __wf_atom_7e8ad928(object3) and gRegion:IsMaster() then
		object:__wf_atom_c83da9e6(object3:__wf_atom_1bb5b1ff())
	end

	if not __wf_atom_7e8ad928(instance) and gRegion:IsMaster() and instance:IsA(__wf_atom_3feeb44a) then
		object2:__wf_atom_d2b2176d():PickUpItem(instance, true, true)
	end

	if object2:__wf_atom_8efce136() then
		_T.ForceSoulMode = nil
	end

	fn9(object, object2, info)
end

function RestoreEnergyTrigger(object, object2)
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	fn9(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), object, __wf_atom_bb3e7833:GetInfo(), object2)
end

function HideSpawnedSoulModeHiddenEntityScript(object)
	Sleep(0)
	local v4 = Symbol("SOUL_MODE_HIDDEN")
	local v5 = Symbol("SOUL_MODE_HIDDEN_UPGRADED")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for _, v6 in ipairs(__wf_atom_f582136d) do
		if not (v6:__wf_atom_db682341() == v4 or v6:__wf_atom_db682341() == v5) then
			continue
		end

		v6:__wf_atom_a7ee9662(false, true)

		if v6:IsA(__wf_atom_d00f34c2) then
			v6:__wf_atom_edd3fec6(0)
		end

		v6:__wf_atom_a763aa1a(1)
	end
end

function SoulStealRemove(object)
	Sleep(10)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_558ce619(Symbol("SoulSteal"))
	end
end