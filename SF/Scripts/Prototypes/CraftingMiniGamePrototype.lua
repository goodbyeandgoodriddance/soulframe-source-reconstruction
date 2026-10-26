function CraftingInterface()
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(craftingMovie)
end

function HammerStrikeEvent()
	local movie = __wf_atom_8e4fda44:FindMovie(craftingMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("NotifyHammerStrike", "")
	end
end