local module = require("SF.Scripts.Libs.QuestLib")

function SetQuestCompletedEncounterTag()
	if module.HasCompletedQuest(questWres) then
		gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_25131806(globalEncounterTag)
	end
end