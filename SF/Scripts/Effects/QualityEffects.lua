local module = require("SF.Interface.SFUtilities")

function QualityEffects(instance)
	Sleep(0)

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_be6b4883) then
		return
	end

	local mQuality = instance:__wf_atom_60763aad().mQuality

	if mQuality > 0 and mQuality <= #qualityEffectTypes then
		instance:Attach(
			qualityEffectTypes[mQuality],
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			nil,
			module.GetReplicationMode()
		)
	end
end