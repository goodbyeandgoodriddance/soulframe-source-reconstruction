local module = require("EE.Interface.Utilities")

function OnUpgradeApplied(p, object, _, _, object2)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_60ba1637 = object2:__wf_atom_60ba1637()

	if __wf_atom_7e8ad928(__wf_atom_60ba1637) then
		return
	end

	local victim = __wf_atom_60ba1637.victim

	if
		__wf_atom_7e8ad928(victim)
		or victim:IsKilled()
		or victim:__wf_atom_bedb4e3f()
		or victim:__wf_atom_129d1aba(p)
	then
		return
	end

	local v = (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object)) and 1
		or math.max(1, object:__wf_atom_b6c3ed85(object2:__wf_atom_1bb5b1ff()))
	local v2 = armorReduction * v

	if victim:__wf_atom_d2b2176d():__wf_atom_66066571(upgradeID) then
		local __wf_atom_07dc8ba3 = victim:__wf_atom_d2b2176d():__wf_atom_07dc8ba3(upgradeID)

		if v2 <= Abs(__wf_atom_07dc8ba3) then
			return
		else
			victim:__wf_atom_d2b2176d():__wf_atom_e3f17301(upgradeID)
		end
	end

	victim:__wf_atom_d2b2176d():__wf_atom_56004282(upgradeID, 20, 0, -v2)
end

function GetAbilityStats(_, _, _, _, _, _)
	local v = {
		BONUS = module.FormatNumber(armorReduction, 0)
	}
	return cjson.encode(v)
end