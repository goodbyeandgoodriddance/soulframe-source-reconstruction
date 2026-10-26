local baseAmount = 50
local radius = 8
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v2 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v == 0 then
		if p == 1 then
			baseAmount = 50
			radius = 4
		elseif p == 2 then
			baseAmount = 75
			radius = 5
		elseif p == 3 then
			baseAmount = 100
			radius = 6
		else
			baseAmount = 125
			radius = 7
		end
	elseif v == 1 then
		if p == 1 then
			baseAmount = 75
			radius = 4
		elseif p == 2 then
			baseAmount = 100
			radius = 5
		elseif p == 3 then
			baseAmount = 125
			radius = 6
		else
			baseAmount = 150
			radius = 7
		end
	elseif p == 1 then
		baseAmount = 100
		radius = 8
	elseif p == 2 then
		baseAmount = 125
		radius = 9
	elseif p == 3 then
		baseAmount = 150
		radius = 10
	else
		baseAmount = 200
		radius = 12
	end

	baseAmount *= v2
	radius *= v2
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	fn(p2, object, object2)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = baseAmount
	radialDamageData.radius = radius
	radialDamageData.stabilityDamage = 20
	radialDamageData:__wf_atom_7498285f(13, 1)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_12cf5317(100)
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = true
	radialDamageData.staticCoverOnly = true
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(deathFxType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object)
	local entity = gRegion:CreateEntity(deathDecoType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(radialDamageData.radius)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v = {
		BONUS = module2.FormatNumber(baseAmount, 0),
		RANGE = module2.FormatNumber(radius, 0)
	}
	return cjson.encode(v)
end