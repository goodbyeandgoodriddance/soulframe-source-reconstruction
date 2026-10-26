local v = 5
local v2 = 2
local v3 = Symbol("BlockingBehavior")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	local level = _T.AbilityLevelQueryParms.Level
	local avatar = _T.AbilityLevelQueryParms.Avatar
	local magikForceCalc = module.magikForceCalc(avatar, level, mOwner)

	if level == 1 then
		v = 3.5
		v2 = 0.5
	end

	if level == 2 then
		v = 4
		v2 = 1
	end

	if level == 3 then
		v = 4.5
		v2 = 1.25
	end

	if level == 4 then
		v = 5
		v2 = 1.5
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = 20,
		ValuePost = "/SF/Language/Menu/DT_SLASH"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = 8,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/SF/Language/Upgrades/WEAPON_STABILITY_DAMAGE",
		Value = v2 + 1,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, object2, _, _)
	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:__wf_atom_8a035cd5(Symbol("VirtueSwap"), false)
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	module.SetForceAim(object2, mOwner, true)
	object2:__wf_atom_8a035cd5(Symbol("AdjustTorso"), false)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)

	if object2:__wf_atom_59cb39a4() then
		if not module.PlayAnimAndSuspendUntilEvent(object, airAnim, "Cast", false, 2, 1, false) then
			return
		end
	elseif not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
	local __wf_atom_28224c27 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
	local v5

	if __wf_atom_7e8ad928(__wf_atom_28224c27) then
		v5 = __wf_atom_1c374cc9
	else
		v5 = __wf_atom_28224c27:__wf_atom_4227f14a()
	end

	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	local entity = gRegion:CreateEntity(projectileType, v5, __wf_atom_4e50d390, object)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object2)
		entity:__wf_atom_c6dbdab6(object)
		entity:__wf_atom_129183dd(__wf_atom_1c374cc9, (object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()))
	end

	module.RemoveCastImmunity(object2)
	mOwner:__wf_atom_a7328d06(true)
	mOwner:__wf_atom_d14eed1a()
end

function DeactivateAbility(_, object, _, _)
	while
		not __wf_atom_7e8ad928(object)
		and (object:__wf_atom_c138b19b(activateAnim) or object:__wf_atom_c138b19b(airAnim))
	do
		Sleep(0)
	end

	Sleep(0.2)

	if not __wf_atom_7e8ad928(object) then
		module.EnableWeaponSlot(object, "Idol", false, 0)

		if object:__wf_atom_4417a5d4() then
			object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end

		module.SetForceAim(object, mOwner, false)
		module.EnableWeaponFiring(object, mOwner, true)
	end
end

function AdjustTorso(object)
	object:__wf_atom_e919fb8e()
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v4 = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v4:__wf_atom_09294a87(0)

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and not mOwner:__wf_atom_9e62504e() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v4:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v4:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		object:__wf_atom_187571ae(0, object:__wf_atom_ed1dbb61())
		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end

	object:__wf_atom_ae3321f6()
end

function BlindImpact(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	gRegion:CreateEntity(impactFxType, object:GetPosition(), object:__wf_atom_dc309f8a())
	local position

	if __wf_atom_7e8ad928(object2) then
		if __wf_atom_7e8ad928(object) then
			object:Die()
			return
		else
			position = object:GetPosition()
		end
	else
		position = object2:__wf_atom_d0069154()
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		object:Die()
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		object:Die()
		return
	end

	if __wf_atom_e55d02aa:__wf_atom_f5ca3244() then
		mOwner = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyBlindAbilityPrime"))
	else
		mOwner = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyBlindAbility"))
	end

	local __wf_atom_e8008ec5 = __wf_atom_e55d02aa:__wf_atom_e8008ec5(mOwner)
	local v4 = not (__wf_atom_e8008ec5 < __wf_atom_e55d02aa:__wf_atom_87a16e10()) and 1
		or __wf_atom_e55d02aa:__wf_atom_cc3c265a(__wf_atom_e8008ec5)
		or 1
	local magikForceCalc = module.magikForceCalc(__wf_atom_7be51ede, v4, mOwner)

	if v4 == 1 then
		v = 3.5
		v2 = 0.5
	end

	if v4 == 2 then
		v = 4
		v2 = 1
	end

	if v4 == 3 then
		v = 4.5
		v2 = 1.25
	end

	if v4 == 4 then
		v = 5
		v2 = 1.5
	end

	v *= magikForceCalc
	v2 *= magikForceCalc

	if __wf_atom_7be51ede:__wf_atom_4417a5d4() then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = 20
		radialDamageData:__wf_atom_7498285f(2, 1)
		radialDamageData:__wf_atom_6b472125(__wf_atom_7be51ede)
		radialDamageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
		local feyBlindHitTargets = {}
		local v5 = position + Vector(Random(-0.1, 0.1), 0, Random(-0.1, 0.1))
		radialDamageData.radius = 8
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_98d98d81(v5)
		radialDamageData:__wf_atom_a8149853(Symbol("RadialHit"))
		_T.feyBlindHitTargets = feyBlindHitTargets
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		_T.feyBlindHitTargets = nil
		local secondaryScriptArgs = SF.SecondaryScriptArgs(false)

		for _, v6 in ipairs(feyBlindHitTargets) do
			if
				__wf_atom_7e8ad928(v6)
				or not v6:IsA(__wf_atom_4ebf67cb)
				or (v6:IsKilled() or v6:__wf_atom_129d1aba(__wf_atom_7be51ede))
			then
				continue
			end

			secondaryScriptArgs:__wf_atom_a17e41c6(v6)
		end

		if secondaryScriptArgs:__wf_atom_ad6e68e0() then
			secondaryScriptArgs:__wf_atom_079cbbd0(v)
			__wf_atom_e55d02aa:__wf_atom_e6831c5c(mOwner, Symbol("DoBlind"), secondaryScriptArgs)
		end
	end

	object:Die()
end

function ProjectileDie(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_e21e8409(abilityType)
			local v4

			if __wf_atom_e55d02aa:__wf_atom_f5ca3244() then
				v4 = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyBlindAbilityPrime"))
			else
				v4 = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyBlindAbility"))
			end

			if not __wf_atom_7e8ad928(v4) then
				v4:__wf_atom_a7328d06(false)
			end
		end
	end
end

function RadialHit(_, p)
	table.insert(_T.feyBlindHitTargets, p)
end

function DoBlind(object)
	local __wf_atom_7bd6bf56 = object:__wf_atom_7bd6bf56(mOwner)
	local v4 = object:__wf_atom_7e5453c1(mOwner)[1]
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local v5 = Symbol("GiveStun")

	for _, v6 in ipairs(__wf_atom_7bd6bf56) do
		if __wf_atom_7e8ad928(v6) or not __wf_atom_7e8ad928(v6:__wf_atom_bb3e7833(blindAttachFxType)) then
			continue
		end

		local v7 = Symbol("GAME_C1_HEAD")

		if v6:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
			v7 = Symbol("GAME_C1_HEAD")
		elseif v6:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
			v7 = Symbol("GAME_C1_HEAD1")
		elseif v6:__wf_atom_71a94e55(Symbol("GAME_C_HEAD")) then
			v7 = Symbol("GAME_C_HEAD")
		elseif v6:__wf_atom_71a94e55(Symbol("GAME_C1_HORN")) then
			v7 = Symbol("GAME_C1_HORN")
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v6:__wf_atom_30e3d82b()) then
			if v6:__wf_atom_464a4772() then
				v4 /= 2
			end

			v6:__wf_atom_17db995b(__wf_atom_37768748)
			v6:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, v6:__wf_atom_cbac6c9f(__wf_atom_37768748, v4))
			v6:__wf_atom_8a035cd5(v5, false)
		end

		v6:__wf_atom_d50c5af7(
			blindAttachFxType,
			v7,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			v4,
			object:__wf_atom_6009c8ed()
		)
	end
end

function GiveStun(object)
	local v4 = Symbol("BLINDED")
	local v5 = Symbol("BLINDED_LOOP")
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v6

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v6 = __wf_atom_30e3d82b:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v6) then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(v6) then
		v6:__wf_atom_d2b2176d():AddUpgrade(169, 3, v2)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v3, v6, 1)
	end

	local __wf_atom_d2b2176d = v6:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)
	v6:__wf_atom_58c8ffec(v4, false, 4, 1, true, __wf_atom_5784a397(0, v6:__wf_atom_1ba2008d(v4)))

	while
		not __wf_atom_7e8ad928(v6)
		and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
		and __wf_atom_30e3d82b:__wf_atom_11cb6d4a()
	do
		if not (v6:__wf_atom_fc8d8e90(v4, false) or v6:__wf_atom_fc8d8e90(v5, false)) then
			v6:__wf_atom_58c8ffec(v5, false, 4, 2, true, __wf_atom_5784a397(0, v6:__wf_atom_1ba2008d(v5)))
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v6) then
		if v6:__wf_atom_fc8d8e90(v5, false) then
			v6:__wf_atom_921c1a5f(nil, false, 3, 1, true)
		end

		__wf_atom_d2b2176d:__wf_atom_1870de39(true)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v3)
		end

		if gRegion:IsMaster() then
			v6:__wf_atom_d2b2176d():RemoveUpgrade(169, 3, v2)
		end
	end
end

function VirtueSwap(p)
	module2.FeyVirtueSwap(p, 0.75)
end