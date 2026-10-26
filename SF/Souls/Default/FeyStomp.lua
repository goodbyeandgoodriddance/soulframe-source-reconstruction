local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local radius = 6
local stabilityDamage = 10
local v = 25

local function fn(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p == 1 then
		stabilityDamage = 100
		radius = 5
	elseif p == 2 then
		stabilityDamage = 150
		radius = 6
	elseif p == 3 then
		stabilityDamage = 175
		radius = 7
	else
		stabilityDamage = 200
		radius = 8
	end

	stabilityDamage *= magikForceCalc
	radius *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	fn(_T.AbilityLevelQueryParms.Level, _T.AbilityLevelQueryParms.Avatar)
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = radius,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/SF/Language/Upgrades/WEAPON_STABILITY_DAMAGE",
		Value = stabilityDamage + 1,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "STABILITY REDUCTION",
		Value = 1.5,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	mOwner:__wf_atom_a7328d06(true)
	module.EnableWeaponFiring(object2, mOwner, false)
	mOwner:__wf_atom_7ccf4243(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	module.AddCastImmunity(object2)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if gRegion:IsMaster() then
		object2:__wf_atom_d2b2176d():AddUpgrade(169, 2, 0.5)
	end

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v2

	if not __wf_atom_7e8ad928(pactFxType) then
		v2 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	object2:Attach(WindType, EMPTY_SYMBOL, Vector(0, 1.25, 0), __wf_atom_80368bb1)
	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)

	if gRegion:IsMaster() then
		local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, radius * 2)
		local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
		local v3 = Symbol(__wf_atom_37768748:c_str() .. "_Stability")

		for _, v4 in ipairs(all) do
			if v4:__wf_atom_129d1aba(object2) or not v4:IsA(__wf_atom_9e85eea2) then
				continue
			end

			v4:__wf_atom_d2b2176d():__wf_atom_0f765e85(v3, v, 169, 3, 0.5)
		end
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))

	if gRegion:IsMaster() then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = 1
		radialDamageData:__wf_atom_7498285f(0, 1)
		radialDamageData:__wf_atom_6b472125(object2)
		radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
		radialDamageData.stabilityDamage = stabilityDamage
		radialDamageData.radius = radius
		radialDamageData:__wf_atom_12cf5317(200)
		radialDamageData:__wf_atom_34a8a27a(object)
		radialDamageData:__wf_atom_d6f4d914(31, true)
		radialDamageData.fallOff = 0.5
		radialDamageData.checkForCover = false
		radialDamageData.hostAuthoritative = true
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
			stompFxType,
			Symbol("GAME_L1_WEAPON1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
			__wf_atom_7ccf4243:SetMeshScale(radius)
		end
	end

	local v3 = true

	while v > 0 do
		if v3 and not object2:__wf_atom_c138b19b(activateAnim) then
			module.EnableWeaponFiring(object2, mOwner, true)
			v3 = false
		end

		Sleep(0)
		v -= __wf_atom_084b3e93()
	end

	mOwner:__wf_atom_a7328d06(false)
end

function DeactivateAbility(_, object, _, p)
	fn(p, object)

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:__wf_atom_d2b2176d():RemoveUpgrade(169, 2, 0.5)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	module.EnableWeaponFiring(object, mOwner, true)
end