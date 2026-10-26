local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = Symbol("ExplosiveBuildUpRuneCB")
local v2 = WeakResource("/SF/Types/Game/SFCasterMeleeWeapon")
local v3 = 10
local v4 = 6
local v5 = 6

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(p, object)
	local v6 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()
	local v7 = __wf_atom_7e8ad928(p) and 1 or p
	local v8 = tonumber(v6) or 0
	local v9 = tonumber(v7) or 1

	if v8 == 0 then
		if v9 == 1 then
			v5 = 2
			v4 = 7
			v3 = 10
		elseif v9 == 2 then
			v5 = 2.35
			v4 = 6
			v3 = 10
		elseif v9 == 3 then
			v5 = 2.65
			v4 = 5
			v3 = 10
		else
			v5 = 3
			v4 = 4
			v3 = 10
		end
	end
end

local function fn2(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(v2) then
		return false
	end

	for i = 0, instance:__wf_atom_ca3e110b() - 1 do
		if instance:__wf_atom_3d08948b(i):IsA(__wf_atom_b734e29f) then
			return true
		end
	end

	return false
end

function ActivateAbility(object, object2, _, explosiveBuildupRuneLevel)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	module.AddCastImmunity(object2)
	fn(explosiveBuildupRuneLevel, weaponMote)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		if not __wf_atom_7e8ad928(activeFxType) then
			local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
					__wf_atom_66088189,
					EMPTY_SYMBOL
				)
			end
		end

		if not __wf_atom_7e8ad928(activeOffhandFxType) then
			local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				mOwner:__wf_atom_7ccf4243(activeOffhandFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
					__wf_atom_66088189,
					EMPTY_SYMBOL
				)
			end
		end
	end

	if fn2(__wf_atom_3371f607) then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnTraceHit"), true)

		if gRegion:IsMaster() then
			local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
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

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneLevel = explosiveBuildupRuneLevel
	Sleep(0)
	local runeActivationCost = module3.GetRuneActivationCost()
	local v6 = false

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:__wf_atom_9f71ab59()
		and not v6
	do
		if __wf_atom_3371f607:__wf_atom_160ce839() then
			v6 = true

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
	object:__wf_atom_0650fed7(attachFxType)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		if fn2(__wf_atom_3371f607) and gRegion:IsMaster() then
			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
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

		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneActive)) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneActive = nil
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

local function fn3(p, object, object2, radius, p2)
	local runeDamageBuff = module3.GetRuneDamageBuff(p, p2)
	local baseAmount = object2:__wf_atom_21059808() * runeDamageBuff
	local stabilityDamage = object2:__wf_atom_483e7ddc().stabilityDamage * runeDamageBuff
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = baseAmount
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData:__wf_atom_7498285f(13, 1)
	radialDamageData:__wf_atom_6b472125(p)
	radialDamageData:__wf_atom_34a8a27a(object2)
	radialDamageData.radius = radius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_d0069154())
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(deathFxType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, p)
	local entity = gRegion:CreateEntity(deathDecoType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, p)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(radialDamageData.radius)
	end
end

function OnKilled(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget) then
		return
	end

	for i = 1, #__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget do
		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i])
			or not (__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].hits > 0)
		then
			continue
		end

		local weapon = __wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].weapon

		if __wf_atom_7e8ad928(weapon) or __wf_atom_7e8ad928(weapon:__wf_atom_6009c8ed()) then
			continue
		end

		local v6 = __wf_atom_421b01aa(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].hits / v4, 0, 1)
		fn3(weapon:__wf_atom_6009c8ed(), object, weapon, v3, v6 * v5)
	end

	__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget = nil
	object:SetVisibility(false)
	Sleep(1)
end

local function fn4(__wf_atom_6009c8ed, instance, __wf_atom_3371f607, _, p)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget) then
		__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget = {}
	end

	local v6 = nil
	local v7 = false

	for i = 1, #__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget do
		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i])
			or __wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].weapon)
			or __wf_atom_3371f607 ~= __wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].weapon
		then
			continue
		end

		v7 = __wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[i].hits > 0
		v6 = i
		break
	end

	if p then
		__wf_atom_55142dd4(instance, "OnKilled")

		if __wf_atom_7e8ad928((instance:__wf_atom_bb3e7833(attachFxType))) then
			instance:Attach(attachFxType, EMPTY_SYMBOL)
		end

		if __wf_atom_7e8ad928(v6) then
			local v8 = { weapon = __wf_atom_3371f607, markTime = Time(), hits = 0 }
			table.insert(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget, v8)
			v6 = #__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget
		end

		if v7 then
			if Time() - __wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].markTime < 0.5 then
				__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits += 1
			else
				fn3(__wf_atom_6009c8ed, instance, __wf_atom_3371f607, v3, v5)

				if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget)) then
					__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].markTime = Time()
					__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits = 1
				end
			end
		else
			__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].markTime = Time()
			__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits = 1
		end
	else
		if not v7 then
			return
		end

		__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits += 1
		local hits = __wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits

		if v4 <= hits then
			__wf_atom_e919fb8e.ExplosiveBuildUpRuneTarget[v6].hits = 0
			fn3(__wf_atom_6009c8ed, instance, __wf_atom_3371f607, v3, v5)
			local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(attachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function OnCasterProjectileHit(object, p, object2, instance)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or object2:__wf_atom_9f2332e5() ~= __wf_atom_3371f607 then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or __wf_atom_7e8ad928(instance)
		or not instance:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_7e8ad928(instance)
		or instance:IsKilled()
		or instance:__wf_atom_129d1aba(__wf_atom_6009c8ed)
		or __wf_atom_7e8ad928(mOwner)
		or not instance:IsVisible()
	then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneLevel)
	then
		return
	end

	fn(p)
	local v6 = not __wf_atom_7e8ad928(object2:__wf_atom_e919fb8e().ExplosiveBuildUpRuneBuffed)
	fn4(__wf_atom_6009c8ed, instance, __wf_atom_3371f607, attachFxType, v6)
end

function OnCasterTraceHit(object, p, p2, instance)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or p2 ~= __wf_atom_3371f607 then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or __wf_atom_7e8ad928(instance)
		or not instance:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_7e8ad928(instance)
		or instance:IsKilled()
		or instance:__wf_atom_129d1aba(__wf_atom_6009c8ed)
		or __wf_atom_7e8ad928(mOwner)
		or not instance:IsVisible()
	then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneLevel)
	then
		return
	end

	fn(p)
	local v6 = not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneActive))
	fn4(__wf_atom_6009c8ed, instance, __wf_atom_3371f607, attachFxType, v6)
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
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].ExplosiveBuildupRuneActive)
	then
		return
	end

	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	object2:__wf_atom_7c5964b8(upgradedValue)
	local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.ExplosiveBuildUpRuneBuffed = true
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) and not fn2(instance) then
		instance:__wf_atom_f354682d(v, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) and not fn2(instance) then
		instance:__wf_atom_308a9a4d(v)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, p2)
	local v6 = {
		VALUE = v4 - 1,
		BONUS = module2.FormatNumber(v5 * 100, 0)
	}
	return cjson.encode(v6)
end