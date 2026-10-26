local stabilityDamage = 50
local radius = 8
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v2 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v == 0 then
		if p == 1 then
			stabilityDamage = 70
			radius = 5
		elseif p == 2 then
			stabilityDamage = 90
			radius = 6
		elseif p == 3 then
			stabilityDamage = 110
			radius = 8
		else
			stabilityDamage = 130
			radius = 10
		end
	elseif v == 1 then
		if p == 1 then
			stabilityDamage = 80
			radius = 5
		elseif p == 2 then
			stabilityDamage = 100
			radius = 8
		elseif p == 3 then
			stabilityDamage = 120
			radius = 10
		else
			stabilityDamage = 150
			radius = 12
		end
	elseif p == 1 then
		stabilityDamage = 100
		radius = 5
	elseif p == 2 then
		stabilityDamage = 150
		radius = 8
	elseif p == 3 then
		stabilityDamage = 200
		radius = 10
	else
		stabilityDamage = 300
		radius = 12
	end

	stabilityDamage *= v2
	radius *= v2
end

local function fn2(object, object2, _)
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 1
	radialDamageData.radius = radius
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData:__wf_atom_7498285f(13, 1)
	radialDamageData:__wf_atom_6b472125(object2)
	radialDamageData:__wf_atom_12cf5317(100)
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = true
	radialDamageData.staticCoverOnly = true
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(stunFxType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object2)
	local entity = gRegion:CreateEntity(stunDecoType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object2)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(radialDamageData.radius)
	end
end

function OnUpgradeApplied(object, _, p, _, p2)
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p, object, p2)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, radius)

	for _, v in ipairs(all) do
		if not gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v:__wf_atom_e93896ba()) then
			fn2(v, object)
		end
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v = {
		BONUS = module2.FormatNumber(stabilityDamage, 0),
		RANGE = module2.FormatNumber(radius, 0)
	}
	return cjson.encode(v)
end