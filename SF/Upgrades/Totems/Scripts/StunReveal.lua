local stabilityDamage = 50
local radius = 8
local v = false
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			stabilityDamage = 100
			radius = 5
		elseif p == 2 then
			stabilityDamage = 125
			radius = 6
		elseif p == 3 then
			stabilityDamage = 150
			radius = 7
		else
			stabilityDamage = 200
			radius = 8
		end
	elseif v2 == 1 then
		if p == 1 then
			stabilityDamage = 125
			radius = 5
		elseif p == 2 then
			stabilityDamage = 150
			radius = 6
		elseif p == 3 then
			stabilityDamage = 175
			radius = 8
		else
			stabilityDamage = 225
			radius = 10
		end
	elseif p == 1 then
		stabilityDamage = 125
		radius = 5
	elseif p == 2 then
		stabilityDamage = 175
		radius = 6
	elseif p == 3 then
		stabilityDamage = 200
		radius = 8
	else
		stabilityDamage = 275
		radius = 10
	end

	stabilityDamage *= v3
	radius *= v3
end

local function fn2(object, object2, _)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
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
	gRegion:CreateEntity(deathFxType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object2, nil, 1)
	local entity = gRegion:CreateEntity(deathDecoType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object2)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(radialDamageData.radius)
	end

	local cameraControl = object2:CameraControl()

	if not v then
		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_4dab66dd(object2:GetPosition(), -1, cameraShake, 2)
		end

		v = true
		Sleep(1.4)
		v = false
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulRevealTargetAvatar = object:__wf_atom_e919fb8e().lastSoulRevealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulRevealTargetAvatar) or lastSoulRevealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p2, object, object2)
	local __wf_atom_1c374cc9 = lastSoulRevealTargetAvatar:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, radius)

	for _, v2 in ipairs(all) do
		if __wf_atom_7e8ad928(v2) or gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v2:__wf_atom_e93896ba()) then
			continue
		end

		fn2(v2, object)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = {
		BONUS = module2.FormatNumber(stabilityDamage, 0),
		RANGE = module2.FormatNumber(radius, 0)
	}
	return cjson.encode(v2)
end