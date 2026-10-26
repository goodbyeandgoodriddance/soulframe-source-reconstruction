local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 0.05
local v2 = 1
local v3 = 13

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.2
			v2 = 1
		elseif p == 2 then
			v = 0.25
			v2 = 1.25
		elseif p == 3 then
			v = 0.3
			v2 = 1.5
		else
			v = 0.35
			v2 = 1.75
		end
	end

	local v4 = {
		HEALTH = module2.FormatNumber(v * 100, 0)
	}
	return cjson.encode(v4)
end

function EvaluateAbility(object, instance)
	if instance:HasTag((mOwner:__wf_atom_37768748())) then
		return false
	end

	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(instance, _, p, p2)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.2
			v2 = 1
		elseif p == 2 then
			v = 0.25
			v2 = 1.25
		elseif p == 3 then
			v = 0.3
			v2 = 1.5
		else
			v = 0.35
			v2 = 1.75
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(instance, v2)
	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()

	if p2 then
		instance:__wf_atom_78128d94(__wf_atom_37768748)
	else
		instance:RemoveTag(__wf_atom_37768748)
	end

	if not gRegion:IsMaster() then
		return runeDamageBuff
	end

	if p2 then
		__wf_atom_7470861b:__wf_atom_1fa97530(7, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, __wf_atom_37768748)
		return runeDamageBuff
	else
		__wf_atom_7470861b:__wf_atom_56b2394e(7, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, __wf_atom_37768748)
	end

	return runeDamageBuff
end

local function fn2(object, _, object2, p, radius, p2)
	if gRegion:IsMaster() then
		local baseAmount = object2:__wf_atom_21059808() * p2
		local stabilityDamage = object2:__wf_atom_483e7ddc().stabilityDamage * p2
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = baseAmount
		radialDamageData.stabilityDamage = stabilityDamage
		radialDamageData:__wf_atom_d6f4d914(17, true)
		radialDamageData:__wf_atom_7498285f(v3, 1)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(object2)
		radialDamageData.radius = radius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_98d98d81(p)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end

	gRegion:CreateEntity(aoeExplosionFx, p, Rotation(0, 90, 0), object, object)
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928((module.GetWeaponMote(mOwner:__wf_atom_3371f607()))) then
		return
	end

	module.AddCastImmunity(object2)
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

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldProjectorFX = nil
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldDeco = nil
	Sleep(0)
	object2:__wf_atom_d2b2176d():__wf_atom_d5651846()

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true) then
		return
	end

	local v4 = fn(object2, __wf_atom_3371f607, p, true)
	local v5 = v * object2:GetMaxHealth()
	module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	module.RemoveCastImmunity(object2)

	if not __wf_atom_7e8ad928(shieldProjectorFx) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldProjectorFX = object2:Attach(
			shieldProjectorFx,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	local v6 = object2:__wf_atom_f46ecadd(shieldDecoAttachOffsetBone) + shieldDecoAttachOffset

	if not __wf_atom_7e8ad928(shieldDecoType) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldDeco = object2:Attach(
			shieldDecoType,
			shieldDecoAttachBone,
			v6,
			object2:__wf_atom_dc309f8a(),
			object2
		)
	end

	local __wf_atom_55597fe3 = object2:__wf_atom_7470861b():__wf_atom_55597fe3()
	local __wf_atom_b518a791 = __wf_atom_55597fe3:__wf_atom_b518a791()
	local __wf_atom_679ed446 = __wf_atom_55597fe3:__wf_atom_679ed446()
	local __wf_atom_3371f607_2 = __wf_atom_55597fe3:__wf_atom_3371f607()
	Sleep(0.5)
	local runeActivationCost = module3.GetRuneActivationCost()
	local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	local v7 = v5
	local total = 0
	local v8 = false

	while total <= 20 and not v8 do
		local __wf_atom_b518a791_2 = __wf_atom_55597fe3:__wf_atom_b518a791()
		local __wf_atom_679ed446_2 = __wf_atom_55597fe3:__wf_atom_679ed446()
		local __wf_atom_3371f607_3 = __wf_atom_55597fe3:__wf_atom_3371f607()

		if
			__wf_atom_b518a791_2 ~= __wf_atom_b518a791
			or __wf_atom_679ed446_2 ~= __wf_atom_679ed446
			or __wf_atom_3371f607_3 ~= __wf_atom_3371f607_2
		then
			if __wf_atom_55597fe3.hitType == 3 then
				v7 -= __wf_atom_55597fe3.healthDamage

				if gRegion:IsMaster() then
					object:__wf_atom_19516b62(
						-runeActivationCost * __wf_atom_55597fe3.healthDamage / v5,
						__wf_atom_2e4994f1
					)
				end

				if v7 <= 0 then
					__wf_atom_3371f607_2 = __wf_atom_3371f607_3
					__wf_atom_679ed446 = __wf_atom_679ed446_2
					__wf_atom_b518a791 = __wf_atom_b518a791_2
					v8 = true
				else
					__wf_atom_3371f607_2 = __wf_atom_3371f607_3
					__wf_atom_679ed446 = __wf_atom_679ed446_2
					__wf_atom_b518a791 = __wf_atom_b518a791_2
				end
			else
				__wf_atom_3371f607_2 = __wf_atom_3371f607_3
				__wf_atom_679ed446 = __wf_atom_679ed446_2
				__wf_atom_b518a791 = __wf_atom_b518a791_2
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	fn2(object2, object, __wf_atom_3371f607, object2:__wf_atom_a2a18137() + v6, 4, v4)
	object:__wf_atom_19516b62(-object:__wf_atom_f3044fe0(__wf_atom_2e4994f1), __wf_atom_2e4994f1)
end

function DeactivateAbility(_, object, _, p)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkRuneActive = nil

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldProjectorFX) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldProjectorFX:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldDeco) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbArcaneBulkwarkShieldDeco:Destroy()
	end

	fn(object, __wf_atom_3371f607, p, false)
end