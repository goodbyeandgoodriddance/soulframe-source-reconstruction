local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = Symbol("BlockingBehavior")

function EvaluateAbility(_, _)
	return false
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		return 0
	end

	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	local __wf_atom_be152500 = object:__wf_atom_d2b2176d():__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_9fb9a1d6)
		or __wf_atom_be152500 ~= __wf_atom_9fb9a1d6
		or __wf_atom_9fb9a1d6:__wf_atom_ed08f97f()
		or __wf_atom_9fb9a1d6:GetState() ~= 0
	then
		return 0
	end

	return 1
end

local function fn(object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928(object) then
		return
	end

	_T.ElementalBladeRemaining = 1
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and setAsAbilityWeapon then
		__wf_atom_9fb9a1d6:__wf_atom_4bfd7505(true)
	end

	if gRegion:IsMaster() then
		local v2 = Symbol(module3.GetDamageTypeTag(damageType))
		__wf_atom_d2b2176d:AddUpgrade(296, 0, damageConversionPct, __wf_atom_77e05d3b, nil, 26, v2)
		__wf_atom_d2b2176d:AddUpgrade(308, 0, 1, __wf_atom_77e05d3b, nil, damageType)
		__wf_atom_d2b2176d:AddUpgrade(312, 0, explosiveRadius, __wf_atom_77e05d3b)

		if attackSpeedPct > 0 then
			__wf_atom_d2b2176d:AddUpgrade(315, 3, attackSpeedPct, __wf_atom_77e05d3b, nil)
		end

		if movementSpeedPct > 0 then
			__wf_atom_d2b2176d:AddUpgrade(101, 3, movementSpeedPct, __wf_atom_77e05d3b, nil)
		end

		if healthRegen > 0 then
			__wf_atom_d2b2176d:AddUpgrade(82, 0, healthRegen)
		end

		if stabilityArmour > 0 then
			__wf_atom_d2b2176d:AddUpgrade(168, 0, stabilityArmour)
		end

		if guardBreak then
			__wf_atom_d2b2176d:AddUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
		end

		if castRadialDmgRange > 0 and not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			local __wf_atom_483e7ddc = __wf_atom_9fb9a1d6:__wf_atom_483e7ddc()
			local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(castRadialDmgBone)
			local radialDamageData = Engine.RadialDamageData()
			radialDamageData.baseAmount = __wf_atom_483e7ddc.baseAmount * castRadialDmgPct
			radialDamageData.stabilityDamage = __wf_atom_483e7ddc.stabilityDamage * castRadialStabilityDmgPct

			for i = 0, Engine.__wf_atom_aee2d71e - 1 do
				radialDamageData:__wf_atom_7498285f(i, __wf_atom_483e7ddc:__wf_atom_bf612a92(i))
			end

			radialDamageData.radius = castRadialDmgRange
			radialDamageData.hostAuthoritative = true
			radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
			radialDamageData:__wf_atom_6b472125(object)
			radialDamageData:__wf_atom_34a8a27a(__wf_atom_9fb9a1d6)
			gRegion:__wf_atom_f6ec80de(radialDamageData)
		end
	end

	local duration2 = duration
	_T.ElementalBladeRemaining = duration2 / duration

	while duration2 > 0 and not (__wf_atom_7e8ad928(mOwner) or mOwner:__wf_atom_31446586()) do
		duration2 -= __wf_atom_084b3e93()
		_T.ElementalBladeRemaining = duration2 / duration
		Sleep(0)
	end

	_T.ElementalBladeRemaining = nil
end

local function fn2(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and setAsAbilityWeapon then
		__wf_atom_9fb9a1d6:__wf_atom_4bfd7505(false)
	end

	if gRegion:IsMaster() then
		local v2 = Symbol(module3.GetDamageTypeTag(damageType))
		__wf_atom_d2b2176d:RemoveUpgrade(296, 0, damageConversionPct, __wf_atom_77e05d3b, nil, 26, v2)
		__wf_atom_d2b2176d:RemoveUpgrade(308, 0, 1, __wf_atom_77e05d3b, nil, damageType)
		__wf_atom_d2b2176d:RemoveUpgrade(312, 0, explosiveRadius, __wf_atom_77e05d3b)

		if attackSpeedPct > 0 then
			__wf_atom_d2b2176d:RemoveUpgrade(315, 3, attackSpeedPct, __wf_atom_77e05d3b, nil)
		end

		if movementSpeedPct > 0 then
			__wf_atom_d2b2176d:RemoveUpgrade(101, 3, movementSpeedPct, __wf_atom_77e05d3b, nil)
		end

		if healthRegen > 0 then
			__wf_atom_d2b2176d:RemoveUpgrade(82, 0, healthRegen)
		end

		if stabilityArmour > 0 then
			__wf_atom_d2b2176d:RemoveUpgrade(168, 0, stabilityArmour)
		end

		if guardBreak then
			__wf_atom_d2b2176d:RemoveUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
		end

		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	end

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end
end

function StealWait(p)
	fn(p)
	fn2(p)

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:SetEnabled(false)
	end
end

function InitializeAbility(_, object)
	if object:__wf_atom_535d5cbb() then
		object:__wf_atom_8a035cd5(Symbol("StealWait"), false)
	end
end

function ActivateAbility(object, object2)
	if not object2:__wf_atom_535d5cbb() then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object2, 1)
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		if module.PlayAnimAndSuspendUntilEvent(object, activateAnimNpc, animEventNpc, false, 4, 1, false) then
			local __wf_atom_30e3d82b2 = object2:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b2) then
				__wf_atom_30e3d82b2:__wf_atom_42b767a2(v)
			end

			object2:Attach(fxOnNpcActivate, castRadialDmgBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		else
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
			end

			return
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if object2 == __wf_atom_c4f78a8f then
		module2.PlayGlobalTransmission(demoTransmissionSet, Symbol("SwordIgnited"))
		__wf_atom_c4f78a8f:__wf_atom_921c1a5f(equipAnim, false, 3, 1, false)
	end

	object:__wf_atom_6a4cf64f()
	fn(object2)
end

function DeactivateAbility(_, p)
	fn2(p)
end