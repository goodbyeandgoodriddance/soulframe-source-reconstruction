local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return armorReduction + armorReductionPerLevel * (p - 1)
end

function OnUpgradeApplied(p, _, p2, _, object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_60ba1637 = object:__wf_atom_60ba1637()

	if __wf_atom_7e8ad928(__wf_atom_60ba1637) then
		return
	end

	local victim = __wf_atom_60ba1637.victim

	if
		__wf_atom_7e8ad928(victim)
		or victim:IsKilled()
		or victim:__wf_atom_bedb4e3f()
		or victim:__wf_atom_129d1aba(p)
	then
		return
	end

	local v = fn(p2) -- inferred equivalent call
	victim:__wf_atom_d2b2176d():__wf_atom_56004282(upgradeID, 20, 0, -v)
end

function GetAbilityStats(p, _, _, _, _, _)
	local v = { BONUS = module.FormatNumber(fn(p), 0) } -- inferred equivalent call
	return cjson.encode(v)
end