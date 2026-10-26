local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 1
local v2 = 1
local v3 = 11
local v4 = 13

function GetAbilityStats(p, _, _, _, _, _)
	if p == 1 then
		v = 1.25
		v2 = 1
	elseif p == 2 then
		v = 1.5
		v2 = 1.25
	elseif p == 3 then
		v = 1.75
		v2 = 1.5
	else
		v = 2
		v2 = 1.75
	end

	local v5 = {
		DAMAGE = module2.FormatNumber(v * 100, 0),
		AREADAMAGE = module2.FormatNumber(v2 * 100, 0)
	}
	return cjson.encode(v5)
end

local function fn(object, object2, p, p2)
	module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if p == 1 then
		v = 1.25
		v2 = 1
	elseif p == 2 then
		v = 1.5
		v2 = 1.25
	elseif p == 3 then
		v = 1.75
		v2 = 1.5
	else
		v = 2
		v2 = 1.75
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(object, v)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if gRegion:IsMaster() then
		if p2 then
			__wf_atom_d2b2176d:AddUpgrade(401, 0, runeDamageBuff, object2:__wf_atom_1bb5b1ff(), object2, v4)
			__wf_atom_d2b2176d:AddUpgrade(319, 4, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, Symbol(), false, 31)
			__wf_atom_d2b2176d:AddUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
		else
			__wf_atom_d2b2176d:RemoveUpgrade(401, 0, runeDamageBuff, object2:__wf_atom_1bb5b1ff(), object2, v4)
			__wf_atom_d2b2176d:RemoveUpgrade(319, 4, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, Symbol(), false, 31)
			__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
		end
	end
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn2(object, _, object2, position, radius, p)
	if gRegion:IsMaster() then
		local baseAmount = object2:__wf_atom_21059808() * p
		local stabilityDamage = object2:__wf_atom_483e7ddc().stabilityDamage * p
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = baseAmount
		radialDamageData.stabilityDamage = stabilityDamage
		radialDamageData:__wf_atom_7498285f(v4, 1)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(object2)
		radialDamageData:__wf_atom_d6f4d914(16, true)
		radialDamageData.radius = radius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_98d98d81(position)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end

	gRegion:CreateEntity(aoeSlamFX, position, Rotation(0, 90, 0), object, object)
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928((module.GetWeaponMote(mOwner:__wf_atom_3371f607()))) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	module.AddCastImmunity(object2)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	fn(object2, __wf_atom_3371f607, p, true)
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

		local __wf_atom_7ccf4243_2 = mOwner:__wf_atom_7ccf4243(
			trailType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(__wf_atom_7ccf4243_2) then
			__wf_atom_7ccf4243_2:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
		end
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	Sleep(0)
	__wf_atom_d2b2176d:__wf_atom_d5651846()
	Sleep(0)
	object2:__wf_atom_bd0a3e86(0)
	Sleep(0.1)
	object2:__wf_atom_8a035cd5(Symbol("_ForwardMove"), false)
	__wf_atom_3371f607:__wf_atom_01e1d257(v3)

	while not object2:__wf_atom_aea547fa() do
		Sleep(0)
	end

	Sleep(0.1)
	fn2(object2, object, __wf_atom_3371f607, __wf_atom_66088189:GetPosition(), 4, v2)
	module.NotifyRuneSuccess(object2, __wf_atom_3371f607)

	if gRegion:IsMaster() then
		local runeActivationCost = module3.GetRuneActivationCost()
		local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
		object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
	end
end

function _ForwardMove(object)
	local motionControl = object:MotionControl()
	local total = 0

	while total <= 0.7 do
		motionControl:__wf_atom_4bb21efc(object:__wf_atom_a06d543c() * 3.5)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function DeactivateAbility(_, p, _, p2)
	module.RemoveCastImmunity(p)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	fn(p, __wf_atom_3371f607, p2, false)
end