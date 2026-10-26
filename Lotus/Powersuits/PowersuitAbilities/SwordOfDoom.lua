local module = require("Lotus.Powersuits.PowersuitAbilities.PVPLib")
local module2 = require("Lotus.Scripts.PostProcess.BasePostProcessFade")
local module3 = require("Lotus.Scripts.Libs.AbilitiesLib")
local module4 = require("Lotus.Scripts.Effects.EnergyElement")
local module5 = require("Lotus.Interface.LotusUtilities")
local v = 5
local v2 = 6
local damageAmount = 300
local augmentOneProcChance = 0.1

local function fn(p)
	if module.IsPvpEnabled() then
		if p == 1 then
			v = 1.5
			v2 = 1.5
			damageAmount = 78
		elseif p == 2 then
			v = 2
			v2 = 2
			damageAmount = 80
		elseif p == 3 then
			v = 2.5
			v2 = 2.5
			damageAmount = 82
		else
			v = 3
			v2 = 3
			damageAmount = 88
		end
	elseif p == 1 then
		v = 5
		v2 = 6
		damageAmount = 100
	elseif p == 2 then
		v = 5
		v2 = 6
		damageAmount = 125
	elseif p == 3 then
		v = 5
		v2 = 6
		damageAmount = 200
	else
		v = 5
		v2 = 6
		damageAmount = 250
	end
end

local function fn2(object)
	local upgradedValue = Engine.UpgradedValue(damageAmount)
	local v3 = v
	local v4 = v2
	local v5 = nil

	if __wf_atom_7e8ad928(object) then
		return upgradedValue, v3, v4, v5
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return upgradedValue, v3, v4, v5
	end

	local __wf_atom_1bb5b1ff = __wf_atom_e55d02aa:__wf_atom_1bb5b1ff()
	__wf_atom_d2b2176d:ModifyValue(upgradedValue, 10, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	v3 = __wf_atom_d2b2176d:__wf_atom_2a745663(v, 9, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	v4 = __wf_atom_d2b2176d:__wf_atom_2a745663(v2, 3, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)

	if not module.IsPvpEnabled() then
		return upgradedValue, v3, v4, (__wf_atom_e55d02aa:__wf_atom_c497b0ae(3):__wf_atom_89d06f0f(true))
	end

	v5 = __wf_atom_e55d02aa:__wf_atom_9fb5dc25(12.5)
	return upgradedValue, v3, v4, v5
end

local function fn3(object, __wf_atom_d8a7670f)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local v3

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		v3 = __wf_atom_e55d02aa:__wf_atom_1bb5b1ff() or nil
	end

	if __wf_atom_d8a7670f == 1 then
		return __wf_atom_d2b2176d:__wf_atom_2a745663(augmentOneProcChance, 10, v3, __wf_atom_e55d02aa)
	end

	return nil
end

local function fn4(list)
	local avatar = _T.AbilityLevelQueryParms.Avatar

	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local __wf_atom_e55d02aa = avatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_248bb7ae = __wf_atom_e55d02aa:__wf_atom_248bb7ae(_T.AbilityLevelQueryParms.Ability)

	if __wf_atom_e55d02aa:__wf_atom_87a16e10() <= __wf_atom_248bb7ae then
		return
	end

	local __wf_atom_198bded6 = __wf_atom_e55d02aa:__wf_atom_198bded6(__wf_atom_248bb7ae)

	if __wf_atom_198bded6 <= 0 then
		return
	end

	local __wf_atom_d8a7670f = __wf_atom_e55d02aa:__wf_atom_d8a7670f(__wf_atom_248bb7ae)

	if __wf_atom_d8a7670f == 1 then
		if __wf_atom_198bded6 == 1 then
			augmentOneProcChance = 1
		elseif __wf_atom_198bded6 == 2 then
			augmentOneProcChance = 2
		elseif __wf_atom_198bded6 == 3 then
			augmentOneProcChance = 2.5
		else
			augmentOneProcChance = 3
		end
	end

	if __wf_atom_d8a7670f == 1 then
		if _T.AbilityLevelQueryParms.Modded then
			augmentOneProcChance = fn3(avatar, 1)
		end

		table.insert(list, {
			Label = "/Lotus/Language/Suits/SwordOfDoomAbilityAugment1Name",
			Title = true
		})
		table.insert(list, {
			Label = "/Lotus/Language/Labels/WEAPON_PROC_CHANCE",
			Value = math.floor(augmentOneProcChance * 100),
			ValueUnit = "/Lotus/Language/Game/UNIT_PERCENT"
		})
	end
end

function GetAbilityUpgradeLevelInfo()
	fn(_T.AbilityLevelQueryParms.Level)
	local v3 = module.IsPvpEnabled() and 12.5 or _T.AbilityLevelQueryParms.Ability:__wf_atom_89d06f0f(false)

	if _T.AbilityLevelQueryParms.Modded == true then
		local v4, v5, v6
		v4, v5, v6, v3 = fn2(_T.AbilityLevelQueryParms.Avatar)
		damageAmount = v4
		v = v5
		v2 = v6
		damageAmount = damageAmount:__wf_atom_37799654()
	end

	local abilityUpgradeLevelInfo = {}

	if v3 ~= nil then
		table.insert(abilityUpgradeLevelInfo, {
			Label = "/Lotus/Language/Game/EnergyPerSec",
			Value = v3,
			SmallerIsBetter = true,
			ValueIcon = "<ENERGY>"
		})
	end

	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = damageAmount,
		ValueIcon = "<DT_SLASH><DT_IMPACT><DT_PUNCTURE>"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/BLIND_RADIUS_NO_UNIT",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/BLIND_DURATION",
		Value = v2,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	fn4(abilityUpgradeLevelInfo)
	abilityUpgradeLevelInfo.Modded = _T.AbilityLevelQueryParms.Modded
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function GetAugmentDescriptionInfo(p, p2)
	if p2 == 1 then
		if p == 1 then
			augmentOneProcChance = 1
		elseif p == 2 then
			augmentOneProcChance = 2
		elseif p == 3 then
			augmentOneProcChance = 2.5
		else
			augmentOneProcChance = 3
		end
	end

	local v3 = p2 == 1 and {
		PROC = math.floor(augmentOneProcChance * 100)
	} or {}
	return cjson.encode(v3)
end

function InitializeAbility(_, _)
	if module.IsPvpEnabled() then
		if module.IsFightingGame() then
			mOwner:__wf_atom_b5374ea1(gGameRules:__wf_atom_db9127e8() + 100)
		else
			mOwner:__wf_atom_b5374ea1(100)
		end
	end
end

function EvaluateAbility(_, object)
	if object:__wf_atom_d2b2176d():__wf_atom_3a8378da() then
		return true
	end

	object:__wf_atom_623b3028(Symbol("/Lotus/Language/Game/AbilityActivationBlocked"))
	return false
end

function NpcEvaluateAbility(_, object)
	if not (__wf_atom_7e8ad928((object:__wf_atom_6115a2e2())) and object:__wf_atom_30e3d82b():__wf_atom_04ea4887()) then
		return 0
	end

	local v3 = { __wf_atom_7e6ed5fa }
	local v4 = object:__wf_atom_30e3d82b():__wf_atom_f0db2b89(15, v3) / 3
	local __wf_atom_a48b42a3 = object:__wf_atom_7470861b():__wf_atom_a48b42a3()
	local __wf_atom_bb81a9df = object:__wf_atom_bb81a9df()

	if __wf_atom_a48b42a3 < 0.5 then
		v4 *= 1.5
	end

	return v4 * (1 + (1 - __wf_atom_bb81a9df) * 1.5)
end

local function fn5(_, object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_d2b2176d():AddUpgrade(26, 4, 1)

	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_017e8c6b(false)
		end
	end
end

local function fn6(_, object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_d2b2176d():RemoveUpgrade(26, 4, 1)

	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_017e8c6b(true)
		end
	end
end

function ActivateAbility(suit, object, _, p)
	fn(p)
	local damageAmount2, blindRadius, blindDuration = fn2(object)
	local v3 = module3.GetAbilityStats(suit, mOwner) or {}
	v3.damageAmount = damageAmount2
	v3.blindRadius = blindRadius
	v3.blindDuration = blindDuration
	module3.SetAbilityStats(suit, mOwner, v3)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_198bded6 = suit:__wf_atom_198bded6()
	local __wf_atom_d8a7670f = suit:__wf_atom_d8a7670f()
	local v4

	if __wf_atom_198bded6 > 0 then
		v4 = __wf_atom_d8a7670f == 1
	else
		v4 = false
	end

	if v4 then
		if __wf_atom_d8a7670f == 1 then
			if __wf_atom_198bded6 == 1 then
				augmentOneProcChance = 1
			elseif __wf_atom_198bded6 == 2 then
				augmentOneProcChance = 2
			elseif __wf_atom_198bded6 == 3 then
				augmentOneProcChance = 2.5
			else
				augmentOneProcChance = 3
			end
		end

		augmentOneProcChance = fn3(object, __wf_atom_d8a7670f)
	end

	suit:__wf_atom_b26056dd(0)

	if module.IsPvpEnabled() then
		mOwner:__wf_atom_b5374ea1(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false))
	end

	local __wf_atom_4417a5d4 = object:__wf_atom_4417a5d4()

	if __wf_atom_4417a5d4 then
		object:Attach(localAttachEffect, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, suit)
	end

	local damageType = not v4 and 21 or module4.ElementType(suit, 5)
	local mItemType = suit:__wf_atom_d8e96504(4).mItemType

	local function fn7(_, object2, _)
		if not v3.instantCast then
			object2:__wf_atom_33b8b73f(equipAnim, true, 2, 1, false, false)
		end

		if v4 and gRegion:IsMaster() then
			v3.augmentOneProcChance = augmentOneProcChance
			__wf_atom_d2b2176d:AddUpgrade(408, 3, augmentOneProcChance, mItemType)
		end

		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(7)

		if
			not __wf_atom_7e8ad928(__wf_atom_28224c27)
			and __wf_atom_28224c27:IsA(__wf_atom_77e05d3b)
			and (__wf_atom_28224c27:__wf_atom_18007d51():__wf_atom_609f0f8e() or __wf_atom_28224c27:__wf_atom_18007d51():__wf_atom_a25f3b15())
		then
			__wf_atom_28224c27:__wf_atom_18007d51():__wf_atom_2c8638a6(true)
		end
	end

	local v5 = {
		ability = mOwner,
		suit = suit,
		weaponType = mItemType,
		damageAmount = damageAmount2,
		damageType = damageType,
		procChance = 0.15,
		abilityActiveAnim = true,
		weaponEquippedFnc = fn7
	}
	module3.__wf_atom_2b919e75(v5)
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_28224c27:__wf_atom_1bb5b1ff() ~= mItemType then
		return
	end

	suit:__wf_atom_6a4cf64f()
	suit:__wf_atom_3fe03b9d()
	suit:__wf_atom_7ee0a78b(true)
	module3.PreventEnergyGain(object, true)

	if module.IsPvpEnabled() then
		suit:__wf_atom_b26056dd(12.5)

		if gRegion:IsMaster() then
			object:__wf_atom_d2b2176d():AddUpgrade(66, 2, 0)
		end
	else
		suit:__wf_atom_b26056dd(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_89d06f0f(false))
	end

	local v6 = false

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		if __wf_atom_4417a5d4 and mOwner:__wf_atom_31446586() then
			suit:DeactivateAbility(mOwner:__wf_atom_1bb5b1ff())
			break
		end

		if v6 ~= (__wf_atom_d2b2176d:__wf_atom_be152500(0) == __wf_atom_28224c27) then
			v6 = not v6

			if v6 then
				fn5(suit, object, __wf_atom_28224c27)
			else
				fn6(suit, object, __wf_atom_28224c27)
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(suit, p, _, p2)
	fn(p2)
	local abilityStats = module3.GetAbilityStats(suit, mOwner)

	if abilityStats then
		damageAmount = abilityStats.damageAmount
	else
		damageAmount = Engine.UpgradedValue(damageAmount)
	end

	fn6(suit, p)
	module3.PreventEnergyGain(p, false)
	suit:__wf_atom_b26056dd(0)

	if module.IsPvpEnabled() then
		mOwner:__wf_atom_b5374ea1(100)
	end

	local mItemType = suit:__wf_atom_d8e96504(4).mItemType

	local function fn7(_, object)
		if gRegion:IsMaster() then
			if module.IsPvpEnabled() then
				object:__wf_atom_d2b2176d():RemoveUpgrade(66, 2, 0)
			end

			if abilityStats and abilityStats.augmentOneProcChance then
				object:__wf_atom_d2b2176d():RemoveUpgrade(408, 3, abilityStats.augmentOneProcChance, mItemType)
			end
		end
	end

	local v3 = {
		ability = mOwner,
		suit = suit,
		weaponType = mItemType,
		weaponSlot = 5,
		abilityActiveAnim = true,
		preRemoveFnc = fn7,
		damageAmount = damageAmount
	}
	module3.__wf_atom_eac30323(v3)
	module3.ClearAbilityStats(suit, mOwner)
end

function GiveSword(object, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local v3 = Type(object:__wf_atom_d8e96504(4).mItemType)
	module3.__wf_atom_b1ebea5e(object, mOwner, __wf_atom_6009c8ed, v3, 5, 4)
end

function RemoveSword(object, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local mItemType = object:__wf_atom_d8e96504(4).mItemType
	module3.__wf_atom_d9619324(__wf_atom_6009c8ed, mItemType, 5)

	if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(__wf_atom_6009c8ed:__wf_atom_30e3d82b())) then
		__wf_atom_6009c8ed:__wf_atom_30e3d82b():__wf_atom_cdd21129()
	end
end

function UpgradeMeleeTree(p, _, _, _, p2)
	module3.UpgradeMeleeTree(p, p2, 3)
end

function RevertFinishers(p)
	module3.RevertFinishers(p)
end

function AbilityPostMigration(object, p)
	module3.__wf_atom_1bd0ed94(p, object:__wf_atom_d8e96504(4).mItemType, 5)
end

function ReceivedWeapon(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v3 = 21
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local v4, v5

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		v4 = 0
		v5 = 0
	else
		v4 = __wf_atom_e55d02aa:__wf_atom_198bded6(3)
		v5 = __wf_atom_e55d02aa:__wf_atom_d8a7670f(3)

		if v4 > 0 and v5 == 1 then
			v3 = module4.ElementType(__wf_atom_e55d02aa, 5)
		end

		module3.__wf_atom_0426a0cf(__wf_atom_e55d02aa, object)
	end

	if module5.GetUIMode() ~= module5.UI_MODE_IN_GAME or _T.InSimulacrum then
		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			fn(__wf_atom_e55d02aa:__wf_atom_cc3c265a(3))
			local v6 = Symbol("DoomAugment")

			if __wf_atom_d2b2176d:__wf_atom_66066571(v6) then
				__wf_atom_d2b2176d:__wf_atom_066a9716(
					v6,
					408,
					3,
					__wf_atom_d2b2176d:__wf_atom_07dc8ba3(v6),
					object:__wf_atom_1bb5b1ff()
				)
			end

			if v4 > 0 and v5 == 1 then
				if 1 == 1 then
					if v4 == 1 then
						augmentOneProcChance = 1
					elseif v4 == 2 then
						augmentOneProcChance = 2
					elseif v4 == 3 then
						augmentOneProcChance = 2.5
					else
						augmentOneProcChance = 3
					end
				end

				augmentOneProcChance = __wf_atom_d2b2176d:__wf_atom_2a745663(
					augmentOneProcChance,
					10,
					__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
					__wf_atom_e55d02aa
				)
				__wf_atom_d2b2176d:__wf_atom_56004282(v6, 408, 3, augmentOneProcChance, object:__wf_atom_1bb5b1ff())
			end
		end

		damageAmount = fn2(__wf_atom_6009c8ed)
		object:__wf_atom_010c2f81(0):__wf_atom_321f94da(damageAmount:__wf_atom_97dd20f1(), v3, 0.15)
		__wf_atom_d2b2176d:__wf_atom_9f816202(366, damageAmount, object:__wf_atom_1bb5b1ff(), object)
	end

	if v3 ~= 21 then
		Sleep(0)
		local __wf_atom_66088189 = object:__wf_atom_66088189(1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local elementFxIdx = module4.ElementFxIdx(v3)
			__wf_atom_66088189:Attach(
				augmentOneSwordAttach[elementFxIdx],
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				__wf_atom_e55d02aa
			)
		end
	end
end

function RemovedWeapon(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or module5.GetUIMode() == module5.UI_MODE_IN_GAME and not _T.InSimulacrum
	then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local v3 = Symbol("DoomAugment")

		if __wf_atom_d2b2176d:__wf_atom_66066571(v3) then
			__wf_atom_d2b2176d:__wf_atom_066a9716(
				v3,
				408,
				3,
				__wf_atom_d2b2176d:__wf_atom_07dc8ba3(v3),
				object:__wf_atom_1bb5b1ff()
			)
		end

		fn(__wf_atom_e55d02aa:__wf_atom_cc3c265a(3))
		damageAmount = fn2(__wf_atom_6009c8ed)
		__wf_atom_d2b2176d:__wf_atom_6d2ab305(366, damageAmount, object:__wf_atom_1bb5b1ff(), object)
	end
end

function MeleeSwing(object, bank)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if
		__wf_atom_7e8ad928(__wf_atom_f7e7be53)
		or __wf_atom_f7e7be53 == object
		or not __wf_atom_f7e7be53:IsA(__wf_atom_4ebf67cb)
	then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_f7e7be53:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local __wf_atom_43cc9de1 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("DoomSwordProjectile"))

	if module.IsPvpEnabled() then
		__wf_atom_43cc9de1 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("DoomSwordProjectilePvP"))
	end

	local __wf_atom_1c374cc9 = __wf_atom_f7e7be53:__wf_atom_1c374cc9(object:__wf_atom_f5bac0e4())
	local __wf_atom_4e50d390 = __wf_atom_f7e7be53:__wf_atom_4e50d390()
	__wf_atom_4e50d390.bank = bank
	local entity = gRegion:CreateEntity(__wf_atom_43cc9de1, __wf_atom_1c374cc9, __wf_atom_4e50d390, __wf_atom_f7e7be53)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	entity:__wf_atom_8fcdea81(__wf_atom_f7e7be53)
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		entity:__wf_atom_c6dbdab6(__wf_atom_d2b2176d:__wf_atom_e55d02aa())
	else
		entity:__wf_atom_c6dbdab6(__wf_atom_9fb9a1d6)
	end

	if not __wf_atom_f7e7be53:__wf_atom_8efce136() then
		entity:__wf_atom_c2d9fb01(0)
	elseif not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_18007d51 = __wf_atom_9fb9a1d6:__wf_atom_18007d51()
		entity:__wf_atom_533c6916(__wf_atom_18007d51:__wf_atom_ae4f866b(
			false,
			false,
			__wf_atom_f7e7be53:__wf_atom_535d5cbb()
		))
		local v3 = __wf_atom_18007d51:__wf_atom_2cdd3b94() * 0.25

		if __wf_atom_9fb9a1d6:__wf_atom_bb46daaa() then
			v3 += __wf_atom_9fb9a1d6:__wf_atom_22a29a11()
		end

		if Engine.__wf_atom_41afbe8a() then
			entity:__wf_atom_9fba31e6(3, v3)
		else
			entity:__wf_atom_9fba31e6(2, 1 + v3)
		end

		if
			not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
			and __wf_atom_e55d02aa:__wf_atom_198bded6(3) > 0
			and __wf_atom_e55d02aa:__wf_atom_d8a7670f(3) == 1
		then
			local elementType = module4.ElementType(__wf_atom_e55d02aa, 5)
			local elementFxIdx = module4.ElementFxIdx(elementType)
			entity:Attach(
				augmentOneProjectileAttach[elementFxIdx],
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				__wf_atom_e55d02aa
			)
		end
	end
end

function HideMe(object)
	Sleep(0)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
		local __wf_atom_e55d02aa = __wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local __wf_atom_43cc9de1 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("ExaltedBladeMesh"))

			if not __wf_atom_7e8ad928(__wf_atom_43cc9de1) then
				object:__wf_atom_45cf0e1a(__wf_atom_43cc9de1, false, false)
			end

			local abilityStats = module3.GetAbilityStats(__wf_atom_e55d02aa, __wf_atom_e55d02aa:__wf_atom_c497b0ae(3))

			if abilityStats and abilityStats.instantCast then
				return
			end
		end
	end

	if _T.ArsenalOpen then
		return
	end

	if hideWithAtten then
		local v3 = 1

		while v3 > 0 and not __wf_atom_7e8ad928(object) do
			object:SetMaterialParam(SF.__wf_atom_f35beb09, v3 * 2)
			v3 -= __wf_atom_084b3e93() * 8
			Sleep(0)
		end
	else
		object:SetMaterialParam(SF.__wf_atom_f35beb09, 0)
	end

	object:__wf_atom_017e8c6b(true)
end

function ShowMe(object)
	object:__wf_atom_017e8c6b(false)
	object:Attach(swordSpawnEffect, EMPTY_SYMBOL)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local v3, v4

	if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		v4 = object:Attach(swordSpawnFlare, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_f7e7be53)
		v3 = object:Attach(swordSpawnLight, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_f7e7be53)
	end

	local v5 = Vector()
	local total = 0

	while total < 1 and not __wf_atom_7e8ad928(object) do
		object:SetMaterialParam(SF.__wf_atom_f35beb09, total * 2)
		v5.y = total * 0.9

		if not __wf_atom_7e8ad928(v4) then
			v4:__wf_atom_e310f01f(v5, __wf_atom_80368bb1)
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:__wf_atom_edd3fec6(10 - total * 2)
			v3:__wf_atom_e310f01f(v5, __wf_atom_80368bb1)
		end

		total += __wf_atom_084b3e93() * 6
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetMaterialParam(SF.__wf_atom_f35beb09, 2)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end
end

function OnSpawnLocalEffects(object)
	Sleep(0)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if
		__wf_atom_7e8ad928(__wf_atom_8ad59546)
		or __wf_atom_7e8ad928(__wf_atom_f7e7be53)
		or not __wf_atom_f7e7be53:__wf_atom_8efce136()
	then
		return
	end

	local total = 0

	while total < 1 do
		__wf_atom_8ad59546:__wf_atom_47f0b80b(__wf_atom_104bfe98(0, 0.16, total))
		total += __wf_atom_084b3e93() * 2.5
		Sleep(0)
	end

	local total2 = 0

	while total2 < 1 do
		__wf_atom_8ad59546:__wf_atom_47f0b80b(__wf_atom_104bfe98(0.16, 0, total2))
		total2 += __wf_atom_084b3e93() * 2
		Sleep(0)
	end

	__wf_atom_8ad59546:__wf_atom_47f0b80b(0)
end

local v3 = { suit = nil, duration = 0 }

function Blinded(object)
	local __wf_atom_37768748 = v3.suit:__wf_atom_c497b0ae(3):__wf_atom_37768748()
	local __wf_atom_cbac6c9f = object:__wf_atom_cbac6c9f(__wf_atom_37768748, v3.duration)
	object:__wf_atom_17db995b(__wf_atom_37768748)

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
		object:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, __wf_atom_cbac6c9f)

		if not object:__wf_atom_39ae2374(9) then
			object:__wf_atom_58c8ffec(Symbol("EXCALIBUR_BLIND"), false, 3, 1, true, __wf_atom_5784a397(0, 2))
		end
	end

	local __wf_atom_d50c5af7 = object:__wf_atom_d50c5af7(
		blindProjector,
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		__wf_atom_cbac6c9f
	)

	while __wf_atom_cbac6c9f > 0 and not (object:IsKilled() or object:__wf_atom_39ae2374(0)) do
		Sleep(0)
		__wf_atom_cbac6c9f -= __wf_atom_084b3e93()
	end

	if __wf_atom_cbac6c9f > 0 then
		if not __wf_atom_7e8ad928(__wf_atom_d50c5af7) then
			__wf_atom_d50c5af7:Destroy()
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
			object:__wf_atom_30e3d82b():__wf_atom_707fb30f(false, 0)
		end
	end
end

function DoBlind(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_f7e7be53:IsA(__wf_atom_4ebf67cb) then
		local __wf_atom_e55d02aa = __wf_atom_f7e7be53:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local __wf_atom_6557214c = __wf_atom_e55d02aa:__wf_atom_6557214c(25)

			if __wf_atom_6557214c <= __wf_atom_e55d02aa:__wf_atom_f3044fe0() then
				__wf_atom_e55d02aa:__wf_atom_19516b62(-__wf_atom_6557214c)
				__wf_atom_f7e7be53:Attach(
					__wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("BlindCastBurst")),
					Symbol("GAME_R1_WEAPON1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_f7e7be53
				)
				local v4 = Symbol("SOD_FadeWithoutBlocking")
				local v5 = Symbol("Blinded")
				fn(__wf_atom_e55d02aa:__wf_atom_cc3c265a(3))
				local blindRadius = v
				local blindDuration = v2
				local abilityStats = module3.GetAbilityStats(
					__wf_atom_e55d02aa,
					__wf_atom_e55d02aa:__wf_atom_c497b0ae(3)
				)

				if not __wf_atom_7e8ad928(abilityStats) then
					blindRadius = abilityStats.blindRadius
					blindDuration = abilityStats.blindDuration
				end

				v3.suit = __wf_atom_e55d02aa
				v3.duration = blindDuration
				local all = gRegion:FindAll(__wf_atom_7e6ed5fa, __wf_atom_f7e7be53:__wf_atom_a2a18137(), 0, blindRadius)

				for _, v6 in ipairs(all) do
					if v6:IsKilled() or __wf_atom_f7e7be53:__wf_atom_129d1aba(v6) or v6:__wf_atom_39ae2374(0) then
						continue
					end

					if v6:IsA(__wf_atom_9e85eea2) then
						v6:__wf_atom_8a035cd5(v5, false)
					elseif v6:__wf_atom_8efce136() then
						v6:__wf_atom_8a035cd5(v4, false)
						v6:PlaySound(blindSoundLocal, false, 0, false)
					end
				end
			end
		end
	end
end

function SOD_FadeWithoutBlocking(p)
	module2.AvatarFade(p, -1, 0, pvpBlindDuration, 0)
end

function ProjectileEffects(object)
	Sleep(0)
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()

	if not __wf_atom_7e8ad928(__wf_atom_9f2332e5) then
		__wf_atom_9f2332e5:ApplyEnergyColor(object)
	end

	object:SetMaterialParam(SF.__wf_atom_f35beb09, 1)
	object:SetMaterialParam(Symbol("MorphAmount"), 0)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_afd78c4b)

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_bb22d127 = object:__wf_atom_bb22d127()
		object:SetMeshScale(__wf_atom_bb22d127 * scaleFactor)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_bdccc470(__wf_atom_bb22d127)
		end

		Sleep(0)
	end
end