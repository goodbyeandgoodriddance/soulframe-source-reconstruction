local v = 13
local v2 = Symbol("StarterCasterRuneCB")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v3 = 1
Symbol("VictimIsVIP")
local v4 = WeakResource("/SF/Types/Game/SFCasterMeleeWeapon")

local function fn(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(v4) then
		return false
	end

	for i = 0, instance:__wf_atom_ca3e110b() - 1 do
		if instance:__wf_atom_3d08948b(i):IsA(__wf_atom_b734e29f) then
			return true
		end
	end

	return false
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, p)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v3 = 1.25
		elseif p == 2 then
			v3 = 1.5
		elseif p == 3 then
			v3 = 1.75
		else
			v3 = 2
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v3)
	module.AddCastImmunity(object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
			activeFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
			__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
		end
	end

	local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

	if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
			activeFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
			__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189_2, EMPTY_SYMBOL)
		end
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneDamagePct = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneAttachFxType = CasterAttachFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneDieFxType = CasterDieFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneBuffAttackSFX = buffAttackSFX

	if fn(__wf_atom_3371f607) then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnTraceHit"), true)

		if gRegion:IsMaster() then
			__wf_atom_d2b2176d:AddUpgrade(
				401,
				0,
				runeDamageBuff,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607,
				v
			)
			__wf_atom_d2b2176d:AddUpgrade(
				319,
				4,
				1,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607,
				26,
				Symbol(),
				false,
				31
			)
			__wf_atom_d2b2176d:AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
			__wf_atom_d2b2176d:AddUpgrade(252, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
		end
	else
		mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)
	end

	local runeActivationCost = module3.GetRuneActivationCost()
	Sleep(0)
	local v5 = false

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:__wf_atom_9f71ab59()
		and not v5
	do
		if __wf_atom_3371f607:__wf_atom_160ce839() then
			v5 = true

			if gRegion:IsMaster() then
				local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
				object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
			end

			module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
		end

		Sleep(0)
	end

	Sleep(0.1)
end

function DeactivateAbility(_, object, _, p)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if fn(__wf_atom_3371f607) then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnTraceHit"), false)

		if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
			if p == 1 then
				v3 = 1.25
			elseif p == 2 then
				v3 = 1.5
			elseif p == 3 then
				v3 = 1.75
			else
				v3 = 2
			end
		end

		local runeDamageBuff = module3.GetRuneDamageBuff(object, v3)

		if gRegion:IsMaster() then
			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:RemoveUpgrade(
				401,
				0,
				runeDamageBuff,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607,
				v
			)
			__wf_atom_d2b2176d:RemoveUpgrade(
				319,
				4,
				1,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607,
				26,
				Symbol(),
				false,
				31
			)
			__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
			__wf_atom_d2b2176d:RemoveUpgrade(252, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
		end
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneActive = nil
		end
	end
end

local function fn2(p, instance)
	local v5 = Symbol("POST_DEATH_ABILITY_ACTIVE")
	return not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_4402f880(p)
		and (instance:IsKilled() or instance:__wf_atom_bedb4e3f() and instance:__wf_atom_52077f7a(v5))
end

function OnCasterProjectileHit(object, _, object2, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_e919fb8e().StarterCasterRuneBuffed) then
		return
	end

	if not __wf_atom_7e8ad928(CasterTargetFx) and fn2(object:__wf_atom_6009c8ed(), object3) then
		object3:Attach(CasterTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		object3:__wf_atom_9356c1bd(6, object3)
	end
end

function OnCasterTraceHit(object, _, instance, object2)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_2dc5c74e) then
		return
	end

	local __wf_atom_6009c8ed = instance:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_0395f752 = instance:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
	then
		return
	end

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneActive) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneBuffAttackSFX)) then
		__wf_atom_6009c8ed:PlaySound(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneBuffAttackSFX, false)
	end

	if not __wf_atom_7e8ad928(CasterTargetFx) and fn2(object:__wf_atom_6009c8ed(), object2) then
		object2:Attach(CasterTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		object2:__wf_atom_9356c1bd(6, object2)
	end
end

function OnNewProjectile(object, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
	then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneActive) then
		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneBuffAttackSFX) then
			__wf_atom_6009c8ed:PlaySound(
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneBuffAttackSFX,
				false
			)
		end

		object2:__wf_atom_facb3053(4)
		object2:Attach(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneAttachFxType, EMPTY_SYMBOL)

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneDieFxType) then
			object2:__wf_atom_5856e05f(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneDieFxType, true)
		end

		object2:__wf_atom_62ceacfc(1)
		object2:__wf_atom_d97c6174(v, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterCasterRuneDamagePct)
		local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.StarterCasterRuneBuffed = true
		local upgradedValue = Engine.UpgradedValue(0)
		upgradedValue:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue)
	end
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) and not fn(instance) then
		instance:__wf_atom_f354682d(v2, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) and not fn(instance) then
		instance:__wf_atom_308a9a4d(v2)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v3 = 1.25
		elseif p == 2 then
			v3 = 1.5
		elseif p == 3 then
			v3 = 1.75
		else
			v3 = 2
		end
	end

	local v5 = {
		DAMAGE = module2.FormatNumber(v3 * 100, 0)
	}
	return cjson.encode(v5)
end