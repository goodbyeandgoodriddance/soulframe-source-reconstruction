local v = 10
local v2 = 10
local v3 = Symbol("AttackSpeedOnCollectUpgrade")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v4 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v5 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v4 == 0 then
		if p == 1 then
			v = 10
			v2 = 0.05
		elseif p == 2 then
			v = 12
			v2 = 0.07
		elseif p == 3 then
			v = 14
			v2 = 0.08
		else
			v = 16
			v2 = 0.1
		end
	elseif v4 == 1 then
		if p == 1 then
			v = 10
			v2 = 0.06
		elseif p == 2 then
			v = 12
			v2 = 0.08
		elseif p == 3 then
			v = 14
			v2 = 0.1
		else
			v = 16
			v2 = 0.12
		end
	elseif p == 1 then
		v = 10
		v2 = 0.08
	elseif p == 2 then
		v = 12
		v2 = 0.8
	elseif p == 3 then
		v = 14
		v2 = 0.1
	else
		v = 16
		v2 = 0.15
	end

	v *= v5
	v2 *= v5
end

function OnUpgradeApplied(object, p, p2, _, p3)
	if gRegion:IsMaster() then
		fn(p2, object, p3)
		object:__wf_atom_d2b2176d():__wf_atom_0f765e85(v3, v, 315, 3, v2, p)
		object:__wf_atom_d50c5af7(attachFxArmourType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v4 = { BONUS = module2.FormatNumber(v, 0), RANGE = module2.FormatNumber(v2, 0) }
	return cjson.encode(v4)
end