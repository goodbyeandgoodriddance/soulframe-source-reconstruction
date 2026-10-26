local v = 0.25
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 0.05
		elseif p == 2 then
			v = 0.08
		elseif p == 3 then
			v = 0.1
		else
			v = 0.15
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 0.075
		elseif p == 2 then
			v = 0.1
		elseif p == 3 then
			v = 0.15
		else
			v = 0.2
		end
	elseif p == 1 then
		v = 0.1
	elseif p == 2 then
		v = 0.15
	elseif p == 3 then
		v = 0.2
	else
		v = 0.25
	end

	v *= v3
end

function OnUpgradeApplied(object, object2, p, _, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928((object:__wf_atom_d2b2176d())) then
		return
	end

	fn(p, object, p2)
	local v2 = v
	local v3 = false

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if object2:__wf_atom_815bfe69() and not v3 then
			__wf_atom_d2b2176d:AddUpgrade(138, operationType, v2)
			v3 = true
		elseif not object2:__wf_atom_815bfe69() and v3 then
			__wf_atom_d2b2176d:RemoveUpgrade(138, operationType, v2)
			v3 = false
		end

		Sleep(5)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = {
		BONUS = module2.FormatNumber(v * 100, 0)
	}
	return cjson.encode(v2)
end