local v = 5
local v2 = 2
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function EvaluateAbility(p, object)
	if not module.EvaluateUltAbility(p, object) then
		return false
	end

	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(0)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or not __wf_atom_28224c27:__wf_atom_c5d04cb3() then
		return true
	end

	return false
end

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
	mOwner:__wf_atom_a7328d06(true)

	if object2:__wf_atom_8efce136() then
		_T.ForceReticle = true
	end

	local __wf_atom_535d5cbb = object2:__wf_atom_535d5cbb()
	module.EnableWeaponSlot(object2, "Idol", true, 0)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	while __wf_atom_7e8ad928(__wf_atom_28224c27) or not __wf_atom_28224c27:__wf_atom_ed08f97f() do
		Sleep(0)
		__wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)
	end

	local v3 = false
	local v4 = 1

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) and not __wf_atom_7e8ad928(object2) and not v3 and v4 > 0 do
		if __wf_atom_d2b2176d:__wf_atom_9d6c02e9(0) == 0 then
			v3 = true
		elseif object2:__wf_atom_4417a5d4() then
			object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
		end

		v4 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if not v3 then
		return
	end

	local pactFxType = pactFxType

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	if not __wf_atom_7e8ad928(pactFxType) then
		object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if object2:__wf_atom_4417a5d4() and not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		__wf_atom_28224c27:__wf_atom_01e1d257(abilityComboContext)
	end

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		local __wf_atom_66088189 = __wf_atom_28224c27:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:Attach(weaponFxType, EMPTY_SYMBOL)
		end
	end

	local v5 = 1
	local v6 = false

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) and v5 > 0 do
		v6 = not v6 and __wf_atom_28224c27:__wf_atom_9f71ab59() and true or v6
		Sleep(0)
		v5 -= __wf_atom_084b3e93()
	end

	if __wf_atom_7e8ad928(__wf_atom_28224c27) then
		return
	end

	local __wf_atom_43a5fce0 = __wf_atom_28224c27:__wf_atom_43a5fce0()

	if __wf_atom_7e8ad928(__wf_atom_43a5fce0) then
		return
	end

	if object2:__wf_atom_8efce136() then
		_T.ForceReticle = false
	end

	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)

	if not __wf_atom_7e8ad928(object2) then
		if object2:__wf_atom_4417a5d4() then
			object2:__wf_atom_d2b2176d():__wf_atom_1870de39(false)
		end

		module.SetForceAim(object2, mOwner, false)
		module.EnableWeaponFiring(object2, mOwner, true)
	end

	if __wf_atom_535d5cbb then
		object:__wf_atom_3fe03b9d()

		while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_43a5fce0)) do
			Sleep(0)
		end
	end

	mOwner:__wf_atom_d14eed1a()
	mOwner:__wf_atom_a7328d06(false)
end

function DeactivateAbility(object, object2, _, _)
	local __wf_atom_28224c27 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(0)

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		local __wf_atom_43a5fce0 = __wf_atom_28224c27:__wf_atom_43a5fce0()

		if not __wf_atom_7e8ad928(__wf_atom_43a5fce0) then
			local __wf_atom_a2a18137 = __wf_atom_43a5fce0:__wf_atom_a2a18137()
			local v3 = __wf_atom_fa8d0177(
				__wf_atom_a2a18137,
				__wf_atom_a2a18137 + __wf_atom_43a5fce0:__wf_atom_278a2d05(),
				__wf_atom_43a5fce0:__wf_atom_acb19668()
			)
			mOwner:__wf_atom_7ccf4243(projectileExplodeFxType, __wf_atom_a2a18137, v3)
			local radialDamageData = Engine.RadialDamageData()
			radialDamageData.baseAmount = 200
			radialDamageData.radius = 5
			radialDamageData.stabilityDamage = 50
			radialDamageData:__wf_atom_7498285f(13, 1)
			radialDamageData:__wf_atom_6b472125(object2)
			radialDamageData:__wf_atom_d6f4d914(17, true)
			radialDamageData:__wf_atom_34a8a27a(object)
			radialDamageData:__wf_atom_12cf5317(100)
			radialDamageData.fallOff = 0
			radialDamageData:__wf_atom_98d98d81(__wf_atom_a2a18137)
			gRegion:__wf_atom_f6ec80de(radialDamageData)
		end
	end

	object:__wf_atom_ac42b904(object:__wf_atom_e8008ec5(mOwner))
	module.EnableWeaponSlot(object2, "Idol", false, 0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	if not __wf_atom_7e8ad928(pactFxType) then
		local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(pactFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function AdjustTorso(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v3 = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v3:__wf_atom_09294a87(0)
	__wf_atom_e919fb8e.OverrideSpineArgs = { ForwardAngle = 0, SideAngle = 0 }

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and not mOwner:__wf_atom_9e62504e() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v3:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v3:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		if __wf_atom_e919fb8e.OverrideSpineArgs then
			__wf_atom_e919fb8e.OverrideSpineArgs.SideAngle = __wf_atom_421b01aa(object:__wf_atom_ed1dbb61(), -25, 35) / 4
		end

		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end

	__wf_atom_e919fb8e.OverrideSpineArgs = nil
end

function VirtueSwap(_) end

function BayorResponse(instance, _, instance2)
	if __wf_atom_7e8ad928(instance2) and not instance2:__wf_atom_464a4772() or not instance2:IsA(bayorType) then
		return
	end

	local __wf_atom_59cb39a4 = instance2:__wf_atom_59cb39a4()
	instance:__wf_atom_533c6916(0)

	if gRegion:IsMaster() then
		instance2:Attach(GlaiveBlockFX, Symbol("GAME_R1_WEAPON1"), __wf_atom_28d5d4aa, Rotation(0, 0, 0), instance2)
		local v3 = Symbol("GlaiveBlock")

		if not __wf_atom_59cb39a4 then
			instance2:__wf_atom_58c8ffec(
				v3,
				false,
				4,
				1,
				false,
				__wf_atom_5784a397(0, instance2:__wf_atom_1ba2008d(v3))
			)
		end

		instance:Destroy()
	end
end