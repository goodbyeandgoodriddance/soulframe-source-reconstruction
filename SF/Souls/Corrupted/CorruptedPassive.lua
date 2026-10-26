require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Souls.Common.CommonPassive")

function AddCorruptedUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if isGrace then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.suitAttribute = 2
	end

	module.AddPactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
end