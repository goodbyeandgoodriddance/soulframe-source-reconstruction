local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return staggerDamage + staggerDamagePerLevel * (p - 1)
end

local function fn2(p) -- 2 equivalent calls inferred from this helper
	return staggerRadius + staggerRadiusPerLevel * (p - 1)
end

function RadialBlastOnSoulSteal(object, p, p2, _, _)
	local lastSoulStealTargetAvatar = object:__wf_atom_e919fb8e().LastSoulStealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulStealTargetAvatar) or lastSoulStealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	if gRegion:IsMaster() then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		radialDamageData:__wf_atom_98d98d81(lastSoulStealTargetAvatar:GetPosition())
		radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(0))
		radialDamageData.stabilityDamage = fn(p2) -- inferred equivalent call
		radialDamageData.radius = fn2(p2) -- inferred equivalent call
		radialDamageData:__wf_atom_7498285f(0, 1)
		radialDamageData.checkForCover = false
		radialDamageData.fallOff = 1
		radialDamageData.hostAuthoritative = true
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end
end

function GetAbilityStats(p, _, _, _, _, _)
	local v = { BONUS = module.FormatNumber(fn(p), 0), RADIUS = module.FormatNumber(fn2(p), 0) } -- inferred equivalent call
	return cjson.encode(v)
end