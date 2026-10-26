local v = 10
local v2 = 10
local v3 = Symbol("ArmourBuffCastUpgrade")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v4 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v5 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v4 == 0 then
		if p == 1 then
			v = 12
			v2 = 8
		elseif p == 2 then
			v = 15
			v2 = 10
		elseif p == 3 then
			v = 18
			v2 = 12
		else
			v = 22
			v2 = 15
		end
	elseif v4 == 1 then
		if p == 1 then
			v = 12
			v2 = 10
		elseif p == 2 then
			v = 16
			v2 = 15
		elseif p == 3 then
			v = 20
			v2 = 18
		else
			v = 25
			v2 = 20
		end
	elseif p == 1 then
		v = 10
		v2 = 10
	elseif p == 2 then
		v = 12
		v2 = 15
	elseif p == 3 then
		v = 14
		v2 = 20
	else
		v = 16
		v2 = 25
	end

	v *= v5
	v2 *= v5
end

function OnUpgradeApplied(p, _, p2, _, p3)
	if gRegion:IsMaster() then
		fn(p2, p, p3)

		for _, v4 in ipairs(gRegion:__wf_atom_ef7900cf()) do
			v4:__wf_atom_d2b2176d():__wf_atom_0f765e85(v3, v, 20, 0, v2)
			v4:__wf_atom_d50c5af7(attachFxArmourType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v)
		end
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v4 = { BONUS = module2.FormatNumber(v, 0), RANGE = module2.FormatNumber(v2, 0) }
	return cjson.encode(v4)
end