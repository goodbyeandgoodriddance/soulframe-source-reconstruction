local v = 20
local v2 = 1.2
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v4 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v3 == 0 then
		if p == 1 then
			v = 5
			v2 = 0.1
		elseif p == 2 then
			v = 8
			v2 = 0.12
		elseif p == 3 then
			v = 10
			v2 = 0.14
		else
			v = 12
			v2 = 0.15
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 5
			v2 = 0.12
		elseif p == 2 then
			v = 10
			v2 = 0.14
		elseif p == 3 then
			v = 12
			v2 = 0.16
		else
			v = 15
			v2 = 0.18
		end
	elseif p == 1 then
		v = 5
		v2 = 0.14
	elseif p == 2 then
		v = 10
		v2 = 0.16
	elseif p == 3 then
		v = 15
		v2 = 0.18
	else
		v = 20
		v2 = 0.2
	end

	v *= v4
	v2 *= v4
end

function OnUpgradeApplied(object, _, p, _, p2)
	local lastSoulStealEnergyType = object:__wf_atom_e919fb8e().LastSoulStealEnergyType
	fn(p, object, p2)
	local attachFxCourageType2, v3

	if lastSoulStealEnergyType == 0 then
		attachFxCourageType2 = attachFxCourageType
		v3 = 21
	elseif lastSoulStealEnergyType == 2 then
		attachFxCourageType2 = attachFxGraceType
		v3 = 23
	elseif lastSoulStealEnergyType == 1 then
		attachFxCourageType2 = attachFxSpiritType
		v3 = 22
	else
		print("Error: Invalid energy type")
		return
	end

	object:__wf_atom_d50c5af7(attachFxCourageType2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v)
	object:__wf_atom_d2b2176d():__wf_atom_3c88d02d(v, v3, 3, v2)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v3 = { BONUS = module2.FormatNumber(v, 0), RANGE = module2.FormatNumber(v2, 0) }
	return cjson.encode(v3)
end