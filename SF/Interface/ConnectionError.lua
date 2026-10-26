function Initialize()
	mMovie:__wf_atom_0cf0fdbe(0)
	mMovie:__wf_atom_7d7314f1("WarningWidget.Message.Label.text", "/Menu/ConnectionDelay")

	if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		local movie = __wf_atom_8e4fda44:FindMovie(mainMenuMovie)

		if not __wf_atom_7e8ad928(movie) then
			local __wf_atom_08c20354, _ = mMovie:__wf_atom_08c20354(mMovie:__wf_atom_97cd8326(), 0)
			local v = (mMovie:__wf_atom_d5a50cb5() - __wf_atom_08c20354) / 2
			local __wf_atom_6efc7cd1, _ = mMovie:__wf_atom_6efc7cd1(v, 0)
			mMovie:__wf_atom_e57658c2("WarningWidget", 0, __wf_atom_6efc7cd1 + movie:__wf_atom_5e6e15c8("Logo", 0))
		end
	end
end

function Shutdown() end