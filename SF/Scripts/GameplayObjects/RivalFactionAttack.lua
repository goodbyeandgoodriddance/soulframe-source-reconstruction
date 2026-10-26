local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil
local v2 = nil

function SetupRivalEncounter(instance)
	v2 = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(v2) or not v2:IsA(__wf_atom_f806fd7a) or math.random() > chanceToSpawn then
		instance:Destroy()
		return
	end

	local position = v2:GetPosition()
	v = module.WaitForAiDir()
	v:AddEncounter(rivalEncounterType)
	v:__wf_atom_c4c644af(position, rivalEncounterType, v2, delayedSpawnTime)
	instance:Destroy()
end