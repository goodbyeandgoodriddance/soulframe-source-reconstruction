local v = nil
local v2 = ""

function ReadGraveStone(_, _)
	if __wf_atom_7e8ad928(titleTextLoc) or __wf_atom_7e8ad928(bodyTextLoc) then
		return
	end

	local v3 = Localize(titleTextLoc:c_str(), nil)
	local v4 = Localize(bodyTextLoc:c_str(), nil)

	if not __wf_atom_7e8ad928(customGraveBacker) then
		v2 = customGraveBacker:__wf_atom_5b41f63b()
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(graveMovieRes) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(graveMovieRes)

		if useNoteLayout then
			v:__wf_atom_f62a8704("InitializeNote", { v3, v4, "", "", "", v2, "" })
		else
			v:__wf_atom_f62a8704("InitializeGraveStone", { v3, v4, v2 })
		end
	end

	while not __wf_atom_7e8ad928(v) do
		Sleep(0)
	end
end