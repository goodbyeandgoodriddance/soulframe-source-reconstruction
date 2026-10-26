local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local baseAmount = 50

local function fn(p, p2, object)
	local v = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v2 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v == 0 then
		if p == 1 then
			baseAmount = 30
		elseif p == 2 then
			baseAmount = 50
		elseif p == 3 then
			baseAmount = 80
		else
			baseAmount = 100
		end
	elseif v == 1 then
		if p == 1 then
			baseAmount = 50
		elseif p == 2 then
			baseAmount = 100
		elseif p == 3 then
			baseAmount = 125
		else
			baseAmount = 150
		end
	elseif p == 1 then
		baseAmount = 50
	elseif p == 2 then
		baseAmount = 125
	elseif p == 3 then
		baseAmount = 175
	else
		baseAmount = 250
	end

	baseAmount *= v2
end

local function fn2(lastSoulStealTargetAvatar, object)
	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(object)
	damageData:__wf_atom_34a8a27a(object)
	lastSoulStealTargetAvatar:__wf_atom_649bf33e(damageData)
	gRegion:CreateEntity(deathFxType, lastSoulStealTargetAvatar:__wf_atom_d0069154(), __wf_atom_80368bb1, object)

	if not __wf_atom_7e8ad928(burstSound) then
		object:PlaySound(burstSound, false, 1, false)
	end

	local entity = gRegion:CreateEntity(
		deathDecoType,
		lastSoulStealTargetAvatar:__wf_atom_d0069154(),
		__wf_atom_80368bb1,
		object
	)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(3)
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulStealTargetAvatar = object:__wf_atom_e919fb8e().LastSoulStealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulStealTargetAvatar) or lastSoulStealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	fn(p2, object, object2)
	fn2(lastSoulStealTargetAvatar, object)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v = {
		BONUS = module2.FormatNumber(baseAmount, 0)
	}
	return cjson.encode(v)
end