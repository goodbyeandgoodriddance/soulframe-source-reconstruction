local module = require("Lotus.Scripts.Libs.AudioLib")

function EnableTaggedSequencer()
	module.EnableTaggedSequencers(seqTagName, true)
end

function DisableTaggedSequencer()
	module.EnableTaggedSequencers(seqTagName, false)
end

function DisableSequencerOnAnimEvent(object, _, _)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(seqType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end
end

function EnableSequencerOnAnimEvent(object, _, _)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(seqType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
	end
end