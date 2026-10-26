local v = 1
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module2.UpgradeMatchesSlotPolarity(object) and 1 or module2.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 1
		elseif p == 2 then
			v = 2
		elseif p == 3 then
			v = 3
		else
			v = 4
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 2
		elseif p == 2 then
			v = 4
		elseif p == 3 then
			v = 6
		else
			v = 8
		end
	elseif p == 1 then
		v = 4
	elseif p == 2 then
		v = 6
	elseif p == 3 then
		v = 8
	else
		v = 10
	end

	v *= v3
end

function OnUpgradeApplied(object, object2, p, _, p2)
	fn(p, object, p2)
	local v2 = false

	while not __wf_atom_7e8ad928(object) do
		object:__wf_atom_d2b2176d()

		if object2:__wf_atom_815bfe69() and not v2 then
			object:__wf_atom_d2b2176d():AddUpgrade(41, 0, v, object2:__wf_atom_1bb5b1ff(), object2)
			v2 = true
		elseif not object2:__wf_atom_815bfe69() and v2 then
			object:__wf_atom_d2b2176d():RemoveUpgrade(41, 0, v, object2:__wf_atom_1bb5b1ff(), object2)
			v2 = false
		end

		Sleep(5)
	end
end

function GetStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = { BONUS = module.FormatNumber(v, 1) }
	return cjson.encode(v2)
end