local v = 13
local v2 = Symbol("StarterBowRuneCB")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v3 = 1

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, starterBowRuneLevel)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	module.AddCastImmunity(object2)

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if starterBowRuneLevel == 1 then
			v3 = 0.9
		elseif starterBowRuneLevel == 2 then
			v3 = 1.1
		elseif starterBowRuneLevel == 3 then
			v3 = 1.3
		else
			v3 = 1.5
		end
	end

	module3.GetRuneDamageBuff(object2, v3)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
			activeArrowFxType,
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

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneEnergyType = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneFireSFX = buffAttackSFX
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowAttachFX = arrowAttachFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowDieFX = arrowExplodeFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneLevel = starterBowRuneLevel
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)
	local v4 = true

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v4 do
		Sleep(0)
		v4 = __wf_atom_3371f607:GetState() == 13
			or __wf_atom_3371f607:GetState() == 14
			or __wf_atom_3371f607:GetState() == 3
	end

	Sleep(0)
end

function DeactivateAbility(_, object, _, _)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneActive)) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneActive = nil
		end
	end
end

local function fn(p, instance)
	local v4 = Symbol("POST_DEATH_ABILITY_ACTIVE")
	return not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_4402f880(p)
		and (instance:IsKilled() or instance:__wf_atom_bedb4e3f() and instance:__wf_atom_52077f7a(v4))
end

function DissolveArrow(object, _, object2, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_e919fb8e().StarterBowRuneBuffed) then
		return
	end

	object2:Attach(arrowExplodeFxType, EMPTY_SYMBOL)

	if fn(object:__wf_atom_6009c8ed(), object3) then
		object3:Attach(arrowTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		object3:__wf_atom_9356c1bd(6, object3)
	end
end

function OnNewProjectile(object, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or object2:__wf_atom_1c9b5d2a() ~= 1 then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = object:__wf_atom_0395f752()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneActive)
	then
		return
	end

	local v4 = __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneLevel) and 1
		or __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneLevel

	if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
		if v4 == 1 then
			v3 = 0.9
		elseif v4 == 2 then
			v3 = 1.1
		elseif v4 == 3 then
			v3 = 1.3
		else
			v3 = 1.5
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(__wf_atom_6009c8ed, v3)
	local runeActivationCost = module3.GetRuneActivationCost()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneEnergyType) then
		local __wf_atom_e55d02aa = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_19516b62(
				-runeActivationCost,
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneEnergyType
			)
		end

		module.NotifyRuneSuccess(__wf_atom_6009c8ed, object)
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneFireSFX) then
		__wf_atom_6009c8ed:PlaySound(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneFireSFX, false)
	end

	local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.StarterBowRuneBuffed = true
	object2:__wf_atom_facb3053(4)

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowAttachFX) then
		object2:Attach(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowAttachFX, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowDieFX) then
		object2:__wf_atom_5856e05f(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].StarterBowRuneArrowDieFX, true)
	end

	object2:__wf_atom_62ceacfc(1)
	object2:__wf_atom_d97c6174(v, runeDamageBuff)
	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	object2:__wf_atom_7c5964b8(upgradedValue)
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_f354682d(v2, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_308a9a4d(v2)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v3 = 0.9
		elseif p == 2 then
			v3 = 1.1
		elseif p == 3 then
			v3 = 1.3
		else
			v3 = 1.5
		end
	end

	local v4 = {
		DAMAGE = module2.FormatNumber(v3 * 100, 0)
	}
	return cjson.encode(v4)
end