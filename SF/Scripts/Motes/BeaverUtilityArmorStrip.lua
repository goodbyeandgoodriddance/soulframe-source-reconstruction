local v = Symbol("BEAVER_UTILITY_ARMOR_STRIP")
local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return armorReduction + armorReductionPerLevel * (p - 1)
end

function ArmorStripOnSoulSteal(object, _, p, _, _)
	local lastSoulStealTargetAvatar = object:__wf_atom_e919fb8e().LastSoulStealTargetAvatar

	if
		__wf_atom_7e8ad928(lastSoulStealTargetAvatar)
		or lastSoulStealTargetAvatar:__wf_atom_129d1aba(object)
		or lastSoulStealTargetAvatar:IsKilled()
		or lastSoulStealTargetAvatar:__wf_atom_bedb4e3f()
	then
		return
	end

	if gRegion:IsMaster() then
		local v2 = fn(p) -- inferred equivalent call
		lastSoulStealTargetAvatar:__wf_atom_d2b2176d():__wf_atom_56004282(v, 20, 0, -v2)
	end
end

function GetAbilityStats(p, _, _, _, _, _)
	local v2 = { BONUS = module.FormatNumber(fn(p), 0) } -- inferred equivalent call
	return cjson.encode(v2)
end