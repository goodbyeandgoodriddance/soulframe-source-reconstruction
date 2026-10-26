local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function GetEnergyType(object, object2)
	local __wf_atom_35a10d3c = object:__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return nil
	end

	local weaponMoteAbility = module.GetWeaponMoteAbility(__wf_atom_35a10d3c)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = object2:__wf_atom_b9421344(weaponMoteAbility, __wf_atom_35a10d3c)

		if __wf_atom_b9421344 < object2:__wf_atom_87a16e10() then
			return object2:__wf_atom_2e4994f1(__wf_atom_b9421344)
		end
	end

	return nil
end

function MatchAttackEvent(object, object2)
	if not object:__wf_atom_d0af6a2c() or __wf_atom_7e8ad928(object2:__wf_atom_50a7d83e()) then
		return false
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_50a7d83e():__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local v = GetEnergyType(__wf_atom_d2b2176d, __wf_atom_e55d02aa)

	if v == nil or __wf_atom_e55d02aa:__wf_atom_6a5c92a7(v) <= 0 then
		return false
	end

	local v2 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(v) / __wf_atom_e55d02aa:__wf_atom_6a5c92a7(v)

	if energyMaxPercentage < v2 and energyMaxPercentage < 1 then
		return false
	end

	return not (v2 < energyMinPercentage and energyMinPercentage > -1)
end