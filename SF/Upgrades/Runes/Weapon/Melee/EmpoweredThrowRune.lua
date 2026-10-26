local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local bbEmpoweredThrowRuneAreaDamagePct = 1
local v = 1
local v2 = 8
local v3 = 13
local v4 = Symbol("EmpoweredThrowectileRuneCB")

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			bbEmpoweredThrowRuneAreaDamagePct = 0.4
			v = 2
		elseif p == 2 then
			bbEmpoweredThrowRuneAreaDamagePct = 0.6
			v = 2.5
		elseif p == 3 then
			bbEmpoweredThrowRuneAreaDamagePct = 0.8
			v = 3
		else
			bbEmpoweredThrowRuneAreaDamagePct = 1
			v = 3.5
		end
	end

	local v5 = {
		STAGGER = module2.FormatNumber(v * 100, 0),
		AREADAMAGE = module2.FormatNumber(bbEmpoweredThrowRuneAreaDamagePct * 100, 0)
	}
	return cjson.encode(v5)
end

local function fn(object, instance, p)
	local bbEmpoweredThrowDeco = nil
	local v5 = nil
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local __wf_atom_80368bb1 = __wf_atom_80368bb1
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(p) then
		if instance:IsA(__wf_atom_baf9587d) then
			local taggedChild = module4.FindTaggedChild(instance:__wf_atom_be0bea4a(), Symbol("ActualGlaiveDeco"))

			if not __wf_atom_7e8ad928(taggedChild) then
				v5 = taggedChild:__wf_atom_b6b760b5()
				__wf_atom_28d5d4aa = taggedChild:__wf_atom_fa6a8faf()
				__wf_atom_80368bb1 = taggedChild:__wf_atom_45c0553e()
			end
		else
			if not __wf_atom_7e8ad928(object) then
				v5 = object:__wf_atom_b6b760b5()
			end

			__wf_atom_28d5d4aa = Vector(0, 0, 0)
			__wf_atom_80368bb1 = Rotation(0, 0, 0)
		end

		if not __wf_atom_7e8ad928(v5) then
			bbEmpoweredThrowDeco = instance:Attach(p, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			bbEmpoweredThrowDeco:__wf_atom_45cf0e1a(v5, false, false)
			bbEmpoweredThrowDeco:SetMeshScale(2, true)
		end
	end

	__wf_atom_e919fb8e.bbEmpoweredThrowDeco = bbEmpoweredThrowDeco
	return bbEmpoweredThrowDeco
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
			bbEmpoweredThrowRuneAreaDamagePct = 0.4
			v = 2
		elseif p == 2 then
			bbEmpoweredThrowRuneAreaDamagePct = 0.6
			v = 2.5
		elseif p == 3 then
			bbEmpoweredThrowRuneAreaDamagePct = 0.8
			v = 3
		else
			bbEmpoweredThrowRuneAreaDamagePct = 1
			v = 3.5
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v)
	module.AddCastImmunity(object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneProperlyThrown = false
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowStabilityPct = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneAreaDamagePct = bbEmpoweredThrowRuneAreaDamagePct
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionRadius = 4
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowEnergyType = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco = nil
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionFX = explosionFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneWeaponAttachDeco = weaponAttachDeco
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneBuffAttackSFX = buffAttackSFX
	Sleep(0)
	__wf_atom_d2b2176d:__wf_atom_d5651846()
	Sleep(0)
	__wf_atom_3371f607:__wf_atom_01e1d257(v2)
	local v5 = 1

	while not __wf_atom_7e8ad928(__wf_atom_3371f607) and not __wf_atom_3371f607:__wf_atom_9f71ab59() and v5 > 0 do
		Sleep(0)
		v5 -= __wf_atom_084b3e93()
	end

	local __wf_atom_3b3a2be6 = __wf_atom_3371f607:__wf_atom_75a0566d():__wf_atom_fe33ffd0():__wf_atom_3b3a2be6(
		Symbol("JoinSwords"),
		0
	)
	Sleep(0)
	local v6 = false
	local v7 = nil

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:__wf_atom_9f71ab59()
		and not v6
	do
		if __wf_atom_3b3a2be6 > 0 and __wf_atom_7e8ad928(v7) then
			if not __wf_atom_7e8ad928(__wf_atom_3371f607:__wf_atom_66088189(1, 2)) then
				v7 = __wf_atom_3371f607:__wf_atom_66088189(1, 2)
			end
		elseif __wf_atom_7e8ad928(v7) then
			if __wf_atom_7e8ad928(__wf_atom_3371f607:__wf_atom_66088189(1, 1)) then
				v7 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)
			else
				v7 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)
			end
		end

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco)
			and not __wf_atom_7e8ad928(v7)
		then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco = fn(v7, v7, weaponAttachDeco)
		end

		if __wf_atom_3371f607:__wf_atom_160ce839() then
			module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
			v6 = true
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
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneActive = nil

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco) then
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco:Destroy()
			end
		end
	end
end

local function fn2(position, object, object2, object3)
	if __wf_atom_7e8ad928(object3) then
		return
	end

	local __wf_atom_0395f752 = object2:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object3:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
	then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionFX) then
		gRegion:CreateEntity(
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionFX,
			object:GetPosition(),
			__wf_atom_80368bb1
		)
	end

	if gRegion:IsMaster() then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData:__wf_atom_6b472125(object3)
		radialDamageData:__wf_atom_34a8a27a(object2)
		radialDamageData:__wf_atom_98d98d81(position)
		radialDamageData.baseAmount = object:__wf_atom_ae4f866b(true, true) * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneAreaDamagePct
		radialDamageData.stabilityDamage = object:__wf_atom_9e9d47f8(true, true) * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneAreaDamagePct
		radialDamageData.radius = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionRadius
		radialDamageData:__wf_atom_7498285f(v3, 1)
		radialDamageData.checkForCover = false
		radialDamageData.fallOff = 0
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end
end

function GlaiveUpdate(object)
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local taggedChild = module4.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("ActualGlaiveDeco"))

	while object:__wf_atom_8107dcc6() ~= 2 and object:__wf_atom_8107dcc6() ~= 3 do
		taggedChild:SetVisibility(false, true)
		Sleep(0)
	end

	if object:__wf_atom_8107dcc6() == 2 then
		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:SetVisibility(true, true)

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbEmpoweredThrowDeco) then
				__wf_atom_e919fb8e.bbEmpoweredThrowDeco:SetVisibility(false, true)
			end
		end

		while object:__wf_atom_8107dcc6() ~= 3 do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:SetVisibility(false, true)

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbEmpoweredThrowDeco) then
				__wf_atom_e919fb8e.bbEmpoweredThrowDeco:SetVisibility(true, true)
			end
		end
	end

	fn2(object:GetPosition(), object, __wf_atom_9f2332e5, object:__wf_atom_7be51ede())
end

function OnNewProjectile(object, instance)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or (instance:__wf_atom_1c9b5d2a() ~= 1 or not instance:IsA(__wf_atom_9c4e6f99))
	then
		return
	end

	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneActive)
	then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowActiveDeco:Destroy()
	end

	fn(
		object:__wf_atom_66088189(1, 0),
		instance,
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneWeaponAttachDeco
	)
	local __wf_atom_e919fb8e_2 = instance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.bbExplosionRadius = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneExplosionRadius

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneBuffAttackSFX) then
		__wf_atom_6009c8ed:PlaySound(
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowRuneBuffAttackSFX,
			false
		)
	end

	instance:__wf_atom_62ceacfc(1)
	instance:__wf_atom_746d4173(2, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowStabilityPct)
	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	instance:__wf_atom_7c5964b8(upgradedValue)
	instance:__wf_atom_facb3053(4)
	instance:__wf_atom_2937dd29(v3)
	local v5 = instance:__wf_atom_838df820() * 2
	local v6 = instance:__wf_atom_41b69224() * 2
	instance:__wf_atom_24a5f5d3(v5)
	instance:__wf_atom_dd2e524d(v6)
	instance:__wf_atom_cecdb8bb(false)
	instance:__wf_atom_8a035cd5(Symbol("GlaiveUpdate"), false)
	local runeActivationCost = module3.GetRuneActivationCost()
	__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_19516b62(
		-runeActivationCost,
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpoweredThrowEnergyType
	)
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_f354682d(v4, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_308a9a4d(v4)
	end
end