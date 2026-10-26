local v = 13
local v2 = Symbol("StarterFlybladeRuneCB")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v3 = 1
local v4 = 3

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
			v3 = 0.4
		elseif p == 2 then
			v3 = 0.6
		elseif p == 3 then
			v3 = 0.8
		else
			v3 = 1
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v3)
	module.AddCastImmunity(object2)
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

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneDamagePct = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneAttachFxType = flybladeAttachFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneBuffAttackSFX = buffAttackSFX
	local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(1)

	if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
		__wf_atom_3d08948b:__wf_atom_9a37af87(5, 0)
		__wf_atom_3d08948b:__wf_atom_9a37af87(6, 1)
		__wf_atom_3d08948b:__wf_atom_9a37af87(7, 0)
		__wf_atom_3d08948b:__wf_atom_9a37af87(8, 1)
		__wf_atom_3d08948b:__wf_atom_51d978c0(false)
		__wf_atom_3d08948b:__wf_atom_ff0c7f12(false, v4, 0.5)
		__wf_atom_3d08948b:__wf_atom_ff0c7f12(true, v4, 2)
	end

	__wf_atom_3371f607:__wf_atom_36d7c7d8()
	local runeActivationCost = module3.GetRuneActivationCost()
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)
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

function DeactivateAbility(_, object, _, _)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneActive = nil
		end
	end

	local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(1)

	if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
		__wf_atom_3d08948b:__wf_atom_1f5f2e79()
		__wf_atom_3d08948b:__wf_atom_51d978c0(true)
		__wf_atom_3d08948b:__wf_atom_6d658747()
	end
end

local function fn(p, instance)
	local v5 = Symbol("POST_DEATH_ABILITY_ACTIVE")
	return not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_4402f880(p)
		and (instance:IsKilled() or instance:__wf_atom_bedb4e3f() and instance:__wf_atom_52077f7a(v5))
end

function OnFlybladeHit(object, _, object2, instance)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_e919fb8e().StarterFlybladeRuneBuffed) then
		return
	end

	local name = object2:GetName()
	local v5 = string.find(name, "RProjectile") and true or false

	if fn(object:__wf_atom_6009c8ed(), instance) then
		instance:__wf_atom_9356c1bd(6, instance)
	end

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_67c46eba) then
		if not __wf_atom_7e8ad928(flybladeGroundFxType) then
			gRegion:CreateEntity(flybladeGroundFxType, object2:__wf_atom_a2a18137(), __wf_atom_80368bb1)
		end
	elseif not __wf_atom_7e8ad928(flybladeTargetFxType) and v5 then
		instance:Attach(flybladeTargetFxType, Symbol("GAME_C1_SPINE5"), __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
	end
end

function OnNewProjectile(object, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneActive)) then
		local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.StarterFlybladeRuneBuffed = true
		object2:__wf_atom_facb3053(4)
		object2:Attach(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneAttachFxType, EMPTY_SYMBOL)

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneDieFxType) then
			object2:__wf_atom_5856e05f(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneDieFxType, true)
		end

		object2:__wf_atom_62ceacfc(1)
		object2:__wf_atom_d97c6174(v, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneDamagePct)
		local upgradedValue = Engine.UpgradedValue(0)
		upgradedValue:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue)

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneBuffAttackSFX) then
			__wf_atom_6009c8ed:PlaySound(
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneBuffAttackSFX,
				false
			)
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterFlybladeRuneBuffAttackSFX = nil
		end
	end
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_f354682d(v2, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_308a9a4d(v2)
		local __wf_atom_3d08948b = instance:__wf_atom_3d08948b(1)

		if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
			__wf_atom_3d08948b:__wf_atom_1f5f2e79()
			__wf_atom_3d08948b:__wf_atom_51d978c0(true)
			__wf_atom_3d08948b:__wf_atom_6d658747()
		end
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v3 = 0.4
		elseif p == 2 then
			v3 = 0.6
		elseif p == 3 then
			v3 = 0.8
		else
			v3 = 1
		end
	end

	local v5 = {
		DAMAGE = module2.FormatNumber(v3 * 100, 0)
	}
	return cjson.encode(v5)
end