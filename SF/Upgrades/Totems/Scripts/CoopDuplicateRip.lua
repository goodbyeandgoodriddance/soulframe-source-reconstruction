local v = 0.02
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module2.UpgradeMatchesSlotPolarity(object) and 1 or module2.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 0.2
		elseif p == 2 then
			v = 0.3
		elseif p == 3 then
			v = 0.4
		else
			v = 0.5
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 0.2
		elseif p == 2 then
			v = 0.3
		elseif p == 3 then
			v = 0.4
		else
			v = 0.6
		end
	elseif p == 1 then
		v = 0.5
	elseif p == 2 then
		v = 0.6
	elseif p == 3 then
		v = 0.7
	else
		v = 0.8
	end

	v *= v3
end

function OnUpgradeApplied(object, _, p, _, p2)
	if gRegion:IsMaster() then
		fn(p, object, p2)

		if math.random() < v then
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.DuplicateSoulSteal = true
		end
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = {
		["1_IN_X"] = module.FormatNumber(1 / v, 0)
	}
	return cjson.encode(v2)
end