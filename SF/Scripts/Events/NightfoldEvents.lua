local module = require("SF.Scripts.Libs.TransmissionSet")

function PlayerSeesPupInTuvalkanesStation(_, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	module.PlayLocalTransmission(transmissionSet, Symbol("AwkwardWithDogs"), __wf_atom_c4f78a8f)
end