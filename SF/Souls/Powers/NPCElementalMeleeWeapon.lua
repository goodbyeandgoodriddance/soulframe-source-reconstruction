local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("Lotus.Interface.LotusUtilities")

function EvaluateAbility(_, _)
	return false
end

local function fn(object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928((mOwner:__wf_atom_c78fa517())) then
		return
	end

	_T.ElementalBladeRemaining = 1
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_18007d51 = __wf_atom_9fb9a1d6:__wf_atom_18007d51()

		if not __wf_atom_7e8ad928(__wf_atom_18007d51) then
			__wf_atom_18007d51:__wf_atom_9866bacc(damageType, true, false)
		end
	end

	if gRegion:IsMaster() then
		local v = Symbol(module3.GetDamageTypeTag(damageType))
		__wf_atom_d2b2176d:AddUpgrade(296, 0, damageConversionPct, __wf_atom_77e05d3b, nil, 26, v)
		__wf_atom_d2b2176d:AddUpgrade(308, 0, 1, __wf_atom_77e05d3b, nil, damageType)
		__wf_atom_d2b2176d:AddUpgrade(315, 3, attackSpeedPct, __wf_atom_77e05d3b, nil)
		__wf_atom_d2b2176d:AddUpgrade(101, 3, movementSpeedPct)
		__wf_atom_d2b2176d:AddUpgrade(82, 0, healthRegen)
		__wf_atom_d2b2176d:AddUpgrade(169, 2, stabilityDamageTakenMulti)
	end

	local duration2 = duration
	_T.ElementalBladeRemaining = duration2 / duration

	while duration2 > 0 and not (__wf_atom_7e8ad928(mOwner) or mOwner:__wf_atom_31446586()) or duration == -1 do
		duration2 -= __wf_atom_084b3e93()
		_T.ElementalBladeRemaining = duration2 / duration
		Sleep(0)
	end

	_T.ElementalBladeRemaining = nil
end

local function fn2(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_18007d51 = __wf_atom_9fb9a1d6:__wf_atom_18007d51()

		if not __wf_atom_7e8ad928(__wf_atom_18007d51) then
			__wf_atom_18007d51:__wf_atom_9866bacc(damageType, false, false)
		end
	end

	if gRegion:IsMaster() then
		local v = Symbol(module3.GetDamageTypeTag(damageType))
		__wf_atom_d2b2176d:RemoveUpgrade(296, 0, damageConversionPct, __wf_atom_77e05d3b, nil, 26, v)
		__wf_atom_d2b2176d:RemoveUpgrade(308, 0, 1, __wf_atom_77e05d3b, nil, damageType)
		__wf_atom_d2b2176d:RemoveUpgrade(315, 3, attackSpeedPct, __wf_atom_77e05d3b, nil)
		__wf_atom_d2b2176d:RemoveUpgrade(101, 3, movementSpeedPct)
		__wf_atom_d2b2176d:RemoveUpgrade(82, 0, healthRegen)
		__wf_atom_d2b2176d:RemoveUpgrade(169, 2, stabilityDamageTakenMulti)
	end

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end
end

function ActivateAbility(object, object2)
	if not object2:__wf_atom_535d5cbb() then
		__wf_atom_7e8ad928(object2:__wf_atom_30e3d82b())
		module2.SetImmunity(object2, true)

		if module.PlayAnimAndSuspendUntilEvent(object, activateAnimNpc, animEventNpc, false, 4, 1, false) then
			module2.SetImmunity(object2, false)
			object2:Attach(fxOnNpcActivate, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		else
			module2.SetImmunity(object2, false)
			return
		end
	end

	object:__wf_atom_6a4cf64f()
	fn(object2)
	mOwner:SetEnabled(false)
end

function ActivateAbilityNoAnimation(object, object2)
	if not object2:__wf_atom_535d5cbb() then
		__wf_atom_7e8ad928(object2:__wf_atom_30e3d82b())
		object2:Attach(fxOnNpcActivate, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	object:__wf_atom_6a4cf64f()
	fn(object2)
	mOwner:SetEnabled(false)
end

function DeactivateAbility(_, p)
	fn2(p)
end