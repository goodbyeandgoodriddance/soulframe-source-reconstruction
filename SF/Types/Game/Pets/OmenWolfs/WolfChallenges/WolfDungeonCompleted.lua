local module = require("SF.Scripts.Libs.PlayerPetLib")

function DungeonExplored(object, object2)
	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()
		local __wf_atom_b725e497 = object2:__wf_atom_d2b2176d():__wf_atom_b725e497()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			if not __wf_atom_7e8ad928(__wf_atom_b725e497) then
				module.TrainPet(__wf_atom_a96eb2aa, 4)
				module.TrainPet(__wf_atom_a96eb2aa, 2)
			end

			__wf_atom_539492fe:__wf_atom_c2038c7a(gRegion:__wf_atom_eab484a7(), Symbol("DUNGEON_EXPLORED"))

			if dungeonChallengeTag:__wf_atom_8598f3a9() then
				__wf_atom_539492fe:__wf_atom_c2038c7a(gRegion:__wf_atom_eab484a7(), dungeonChallengeTag)
			end

			_T.PendingChallengeUpload = true
			print("Completed dungeon", dungeonChallengeTag)

			if not __wf_atom_7e8ad928(object) then
				object:Disable()
			end
		end
	end
end