local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 1
local v2 = 1
local bbCCProjAreaDamagePct = 0.5
local bbCCProjDuration2 = 3
local v3 = 3
local v4 = 13
local v5 = Symbol("CrowdControlProjectileRuneCB")

local function fn(p, object)
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

		if crowdControlType == Symbol("Knockdown") then
			if p == 1 then
				bbCCProjAreaDamagePct = 0.4
				v2 = 2
			elseif p == 2 then
				bbCCProjAreaDamagePct = 0.6
				v2 = 2.5
			elseif p == 3 then
				bbCCProjAreaDamagePct = 0.8
				v2 = 3
			else
				bbCCProjAreaDamagePct = 1
				v2 = 3.5
			end
		elseif crowdControlType == Symbol("Bestone") or crowdControlType == Symbol("Lift") then
			if p == 1 then
				bbCCProjDuration2 = 4
			elseif p == 2 then
				bbCCProjDuration2 = 5
			elseif p == 3 then
				bbCCProjDuration2 = 6
			else
				bbCCProjDuration2 = 7
			end
		end
	end
end

function GetKnockdownAbilityStats(p, _, p2, _, _, _)
	fn(p, p2)
	local v6 = {
		DAMAGE = module2.FormatNumber(v * 100, 0),
		STAGGER = module2.FormatNumber(v2 * 100, 0),
		AREADAMAGE = module2.FormatNumber(bbCCProjAreaDamagePct * 100, 0)
	}
	return cjson.encode(v6)
end

function GetBestoneAbilityStats(p, _, p2, _, _, _)
	fn(p, p2)
	local v6 = {
		DAMAGEMULT = module2.FormatNumber(v * 100, 0),
		DURATION = module2.FormatNumber(bbCCProjDuration2, 0)
	}
	return cjson.encode(v6)
end

function GetLiftAbilityStats(p, _, p2, _, _, _)
	fn(p, p2)
	local v6 = {
		DAMAGEMULT = module2.FormatNumber(v * 100, 0),
		DURATION = module2.FormatNumber(bbCCProjDuration2, 0)
	}
	return cjson.encode(v6)
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

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneType = weaponType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjControlType = crowdControlType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjCount = 0
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjDamageMult = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjStabilityMult = runeDamageBuff2
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjAreaDamagePct = bbCCProjAreaDamagePct
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjExplosionRadius = 3
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneProjectileFxType = projectileFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneBuffAttackSFX = buffAttackSFX
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneImpactFxType = impactFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjTargetAvatarFxType = targetAvatarFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjTargetGroundFxType = targetGroundFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjTargetLargeGroundFxType = targetLargeGroundFxType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjPerceptionHintType = perceptionHintType
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjDuration = bbCCProjDuration2
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjVIPDurationMult = 0.5
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
	elseif weaponType == Symbol("Bow") then
		local v6 = true

		while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v6 do
			Sleep(0)
			v6 = __wf_atom_3371f607:GetState() == 13
				or __wf_atom_3371f607:GetState() == 14
				or __wf_atom_3371f607:GetState() == 3

			if v6 then
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
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneActive = nil

			if __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneType == Symbol("Flyblades") then
				fn2(__wf_atom_3371f607)
			end
		end
	end
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_f354682d(v5, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_308a9a4d(v5)
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
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneActive)
	then
		return
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjCount += 1

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneBuffAttackSFX) then
		__wf_atom_6009c8ed:PlaySound(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneBuffAttackSFX, false)
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneProjectileFxType) then
		object2:Attach(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneProjectileFxType, EMPTY_SYMBOL)
	end

	local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.bbCCProjRuneHit = false
	object2:__wf_atom_facb3053(4)
	object2:__wf_atom_9866bacc(31, true)
	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	object2:__wf_atom_7c5964b8(upgradedValue)

	if __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjControlType == Symbol("Knockdown") then
		object2:__wf_atom_d97c6174(v4, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjDamageMult)
		object2:__wf_atom_746d4173(2, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjStabilityMult)
	end
end

local function fn3(__wf_atom_6009c8ed, instance)
	return instance:IsA(__wf_atom_4ebf67cb)
		and not (__wf_atom_7e8ad928(instance) or instance:IsKilled())
		and not (instance:__wf_atom_129d1aba(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(mOwner))
		and not instance:HasTag(mOwner:__wf_atom_37768748())
		and instance:IsVisible()
end

function OnProjectileHit(object, _, object2, object3)
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

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbCCProjRuneHit) then
		return
	end

	if not __wf_atom_e919fb8e2.bbCCProjRuneHit then
		__wf_atom_e919fb8e2.bbCCProjRuneHit = true

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneImpactFxType) then
			gRegion:CreateEntity(
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjRuneImpactFxType,
				object2:GetPosition(),
				__wf_atom_80368bb1
			)
		end

		if fn3(__wf_atom_6009c8ed, object3) then
			local __wf_atom_e919fb8e3 = object3:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e3.bbCCProjSourceAv = __wf_atom_6009c8ed
			__wf_atom_e919fb8e3.bbCCProjSourceWeaponSlot = __wf_atom_0395f752

			if __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjControlType == Symbol("Bestone") then
				object3:__wf_atom_8a035cd5(Symbol("HandleBestoneTarget"), false)
			elseif __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjControlType == Symbol("Lift") then
				object3:__wf_atom_8a035cd5(Symbol("HandleLiftTarget"), false)
			end
		end

		if
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjControlType == Symbol("Knockdown")
			and gRegion:IsMaster()
		then
			local radialDamageData = Engine.RadialDamageData()
			radialDamageData.baseAmount = object2:__wf_atom_ae4f866b(true, true) / __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjCount * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjAreaDamagePct
			radialDamageData.stabilityDamage = object2:__wf_atom_9e9d47f8(true, true) / __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjCount * __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjAreaDamagePct
			radialDamageData.radius = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbCCProjExplosionRadius
			radialDamageData.fallOff = 0
			radialDamageData.checkForCover = false
			radialDamageData:__wf_atom_7498285f(v4, 1)
			radialDamageData:__wf_atom_98d98d81(object2:GetPosition())
			radialDamageData:__wf_atom_12cf5317(100)
			radialDamageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
			radialDamageData:__wf_atom_34a8a27a(__wf_atom_3371f607)
			radialDamageData:__wf_atom_d6f4d914(19, true)
			gRegion:__wf_atom_f6ec80de(radialDamageData)
		end
	end
end

function HandleBestoneTarget(instance)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	instance:__wf_atom_78128d94(__wf_atom_37768748)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local bbCCProjSourceWeaponSlot = __wf_atom_e919fb8e.bbCCProjSourceWeaponSlot
	local __wf_atom_e919fb8e2 = __wf_atom_e919fb8e.bbCCProjSourceAv:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot])
	then
		return
	end

	if not module.ApplyBestoneFrozenSolid(
		instance,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjTargetAvatarFxType,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjPerceptionHintType,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjDamageMult
	) then
		return
	end

	local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
	local v6 = false
	local bbCCProjDuration = __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjDuration

	if instance:__wf_atom_464a4772() then
		bbCCProjDuration *= __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjVIPDurationMult
	end

	while bbCCProjDuration > 0 do
		v6 = instance:__wf_atom_c6f1f83d() < __wf_atom_c6f1f83d or v6

		if not instance:IsFrozenSolid() then
			break
		end

		Sleep(0)
		bbCCProjDuration -= __wf_atom_084b3e93()
	end

	module.RemoveBestoneFrozenSolid(
		instance,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjTargetAvatarFxType,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjPerceptionHintType,
		v6
	)

	if not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) then
		instance:RemoveTag(__wf_atom_37768748)
	end
end

function HandleLiftTarget(instance)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	instance:__wf_atom_78128d94(__wf_atom_37768748)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local bbCCProjSourceWeaponSlot = __wf_atom_e919fb8e.bbCCProjSourceWeaponSlot
	local bbCCProjSourceAv = __wf_atom_e919fb8e.bbCCProjSourceAv
	local __wf_atom_e919fb8e2 = bbCCProjSourceAv:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot])
	then
		return
	end

	__wf_atom_e919fb8e.bbLiftInstigatorAvatar = bbCCProjSourceAv
	local bbCCProjDuration = __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjDuration

	if instance:__wf_atom_464a4772() then
		bbCCProjDuration *= __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjVIPDurationMult
	end

	local v6 = {
		liftAttachFxType = __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjTargetAvatarFxType,
		liftPoolFxType = __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjTargetGroundFxType,
		liftPoolLargeFxType = __wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjTargetLargeGroundFxType
	}
	module.ApplyRagdollLift(
		instance,
		bbCCProjDuration,
		__wf_atom_e919fb8e2.Runes[bbCCProjSourceWeaponSlot].bbCCProjDamageMult,
		v6,
		liftStartAnim,
		liftJointType
	)

	if not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) then
		instance:RemoveTag(__wf_atom_37768748)
	end
end