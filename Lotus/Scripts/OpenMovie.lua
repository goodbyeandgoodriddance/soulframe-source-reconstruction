function Start(_)
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(pushMovie)
end

function StartAsync(_)
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(asyncMovie, function() end)
end

function CloseAsync(_)
	local movie = __wf_atom_8e4fda44:FindMovie(asyncMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("CloseAsync", "")
	end
end