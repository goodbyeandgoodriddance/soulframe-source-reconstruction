local module = require("SF.Scripts.Libs.EncounterLib")

function CaclulateDebuff(instance, attributeName, p, p2, p3)
	local attribute = instance:GetAttribute(attributeName)
	return (__wf_atom_421b01aa(p - attribute * p2, p3, p))
end

function AddCastCooldownDebuff(_, object)
	Sleep(1)

	if __wf_atom_7e8ad928(object) or not module.IsHardModeActive() then
		return
	end

	object:__wf_atom_d2b2176d():AddUpgrade(
		222,
		2,
		(CaclulateDebuff(object, 1, basePowerCooldownDebuff, powerCooldownDebuffMod, minCogahCooldownDebuff))
	)
end

function RemoveCastCooldownDebuff(_, object)
	object:__wf_atom_d2b2176d():RemoveUpgrade(
		222,
		2,
		(CaclulateDebuff(object, 1, basePowerCooldownDebuff, powerCooldownDebuffMod, minCogahCooldownDebuff))
	)
end