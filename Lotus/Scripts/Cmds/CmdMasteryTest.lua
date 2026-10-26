local module = require("Lotus.Interface.LotusUtilities")

function MasteryTest(p)
	if p > 0 then
		module.OpenTrainingMission(p, true)
	else
		__wf_atom_f2daf912("Rank must be positive")
	end
end