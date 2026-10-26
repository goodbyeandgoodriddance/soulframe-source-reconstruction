local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 1
local v2 = 1
local bbEmpowerProjHealPct = 0
local v3 = 3
local v4 = Symbol("EmpoweredProjectileRuneCB")

local function fn(p, _, object)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 1.25
		elseif p == 2 then
			v = 1.5
		elseif p == 3 then
			v = 1.75
		else
			v = 2
		end

		if buffStabilityDamage then
			if p == 1 then
				v2 = 1.25
			elseif p == 2 then
				v2 = 1.75
			elseif p == 3 then
				v2 = 2.25
			else
				v2 = 2.75
			end
		end

		if empowerType == Symbol("Heal") then
			if p == 1 then
				v = 0.5
				bbEmpowerProjHealPct = 0.2
			elseif p == 2 then
				v = 0.75
				bbEmpowerProjHealPct = 0.25
			elseif p == 3 then
				v = 1
				bbEmpowerProjHealPct = 0.3
			else
				v = 1.25
				bbEmpowerProjHealPct = 0.35
			end
		end
	end
end

function GetHealAbilityStats(p, _, p2, _, _, _)
	fn(p, nil, p2)
	local v5 = {
		DAMAGE = module2.FormatNumber(v * 100, 0),
		HEAL = module2.FormatNumber(bbEmpowerProjHealPct * 100, 0)
	}
	return cjson.encode(v5)
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

	fn(p, weaponMote)
	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v)
	local runeDamageBuff2 = module3.GetRuneDamageBuff(object2, v2)
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

	local bbEmpowerProjDamageType = 13

	if empowerType == Symbol("Fire") then
		bbEmpowerProjDamageType = 3
	elseif empowerType == Symbol("Heal") then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjHealPct = bbEmpowerProjHealPct
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneType = weaponType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjEmpowerType = empowerType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjDamageType = bbEmpowerProjDamageType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjCount = 0
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjDamageMult = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjStabilityMult = runeDamageBuff2
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjAreaDamagePct = 0.5
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjExplosionRadius = explosionRadius
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneProjectileFxType = projectileFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneBuffAttackSFX = buffAttackSFX
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneImpactFxType = impactFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjTargetAvatarFxType = targetAvatarFxType
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)

	if weaponType == Symbol("Flyblades") then
		local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(1)

		if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
			__wf_atom_3d08948b:__wf_atom_9a37af87(5, 0)
			__wf_atom_3d08948b:__wf_atom_9a37af87(6, 1)
			__wf_atom_3d08948b:__wf_atom_9a37af87(7, 0)
			__wf_atom_3d08948b:__wf_atom_9a37af87(8, 1)
			__wf_atom_3d08948b:__wf_atom_51d978c0(false)
			__wf_atom_3d08948b:__wf_atom_ff0c7f12(false, v3, 0.5)
			__wf_atom_3d08948b:__wf_atom_ff0c7f12(true, v3, 0.5)
		end

		__wf_atom_3371f607:__wf_atom_36d7c7d8()
		__wf_atom_3371f607:__wf_atom_3bb2e7ee(true)
	end

	Sleep(0)
	local runeActivationCost = module3.GetRuneActivationCost()

	if weaponType == Symbol("Caster") or weaponType == Symbol("Flyblades") then
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
	elseif weaponType == Symbol("Bow") then
		local v5 = true

		while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v5 do
			Sleep(0)
			v5 = __wf_atom_3371f607:GetState() == 13
				or __wf_atom_3371f607:GetState() == 14
				or __wf_atom_3371f607:GetState() == 3

			if v5 then
				continue
			end

			if gRegion:IsMaster() then
				local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
				object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
			end

			module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
		end
	end

	Sleep(0.1)
end

local function fn2(object)
	object:__wf_atom_3bb2e7ee(false)
	local __wf_atom_3d08948b = object:__wf_atom_3d08948b(1)

	if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
		__wf_atom_3d08948b:__wf_atom_1f5f2e79()
		__wf_atom_3d08948b:__wf_atom_51d978c0(true)
		__wf_atom_3d08948b:__wf_atom_6d658747()
	end
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
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneActive = nil

			if __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneType == Symbol("Flyblades") then
				fn2(__wf_atom_3371f607)
			end
		end
	end
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
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneActive)
	then
		return
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjCount += 1

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneBuffAttackSFX) then
		__wf_atom_6009c8ed:PlaySound(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneBuffAttackSFX, false)
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneProjectileFxType) then
		object2:Attach(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneProjectileFxType, EMPTY_SYMBOL)
	end

	local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.bbEmpowerProjRuneHit = false
	object2:__wf_atom_facb3053(4)
	object2:__wf_atom_9866bacc(31, true)
	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	object2:__wf_atom_7c5964b8(upgradedValue)
	object2:__wf_atom_d97c6174(
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjDamageType,
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjDamageMult
	)
	object2:__wf_atom_746d4173(2, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjStabilityMult)
end

function OnProjectileHit(object, _, object2, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or object2:__wf_atom_9f2332e5() ~= __wf_atom_3371f607 then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
	then
		return
	end

	local __wf_atom_e919fb8e2 = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbEmpowerProjRuneHit) then
		return
	end

	if not __wf_atom_e919fb8e2.bbEmpowerProjRuneHit then
		__wf_atom_e919fb8e2.bbEmpowerProjRuneHit = true

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneImpactFxType) then
			gRegion:CreateEntity(
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjRuneImpactFxType,
				object2:GetPosition(),
				__wf_atom_80368bb1
			)
		end

		if gRegion:IsMaster() then
			if
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjExplosionRadius > 0
				and __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjEmpowerType ~= Symbol("Heal")
			then
				local radialDamageData = Engine.RadialDamageData()
				radialDamageData.baseAmount = object2:__wf_atom_ae4f866b(true, true) / __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjCount * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjAreaDamagePct
				radialDamageData.stabilityDamage = object2:__wf_atom_9e9d47f8(true, true) / __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjCount * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjAreaDamagePct
				radialDamageData.radius = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjExplosionRadius
				radialDamageData.fallOff = 0
				radialDamageData.checkForCover = false
				radialDamageData:__wf_atom_7498285f(
					__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjDamageType,
					1
				)
				radialDamageData:__wf_atom_98d98d81(object2:GetPosition())
				radialDamageData:__wf_atom_12cf5317(100)
				radialDamageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
				radialDamageData:__wf_atom_34a8a27a(__wf_atom_3371f607)
				gRegion:__wf_atom_f6ec80de(radialDamageData)
			end

			if
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjExplosionRadius > 0
				and __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjEmpowerType == Symbol("Heal")
			then
				local all = gRegion:FindAll(
					__wf_atom_4ebf67cb,
					__wf_atom_6009c8ed:__wf_atom_a2a18137(),
					0,
					__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjExplosionRadius
				)

				for _, v5 in ipairs(all) do
					if
						__wf_atom_7e8ad928(v5)
						or not gGameRules:__wf_atom_8c3af1a5(
							__wf_atom_6009c8ed:__wf_atom_e93896ba(),
							v5:__wf_atom_e93896ba()
						)
					then
						continue
					end

					local __wf_atom_c6f1f83d = v5:__wf_atom_c6f1f83d()
					local maxHealth = v5:GetMaxHealth()
					local v6 = maxHealth * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbEmpowerProjHealPct

					if not (__wf_atom_c6f1f83d < maxHealth) then
						continue
					end

					v5:Heal(v5, v6, __wf_atom_6009c8ed)
					v5:NotifyHeal(__wf_atom_6009c8ed:__wf_atom_a96eb2aa(), v6, 0, 1)
					module.NotifyHeal(__wf_atom_6009c8ed, v5:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
				end
			end
		end
	end
end