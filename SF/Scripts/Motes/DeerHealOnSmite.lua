local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return healAmount + healAmountPerLevel * (p - 1)
end

function OnUpgradeApplied(object, _, p, _, _)
	if gRegion:IsMaster() then
		object:Heal(object, fn(p), object) -- inferred equivalent call
	end
end

function GetAbilityStats(p, _, _, _, _, _)
	local v = { BONUS = module.FormatNumber(fn(p), 0) } -- inferred equivalent call
	return cjson.encode(v)
end