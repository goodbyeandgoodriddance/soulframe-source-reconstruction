function TurnOffDynamicMusic()
	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		__wf_atom_a374c1f8:__wf_atom_f9f0178d(false)
		__wf_atom_a374c1f8:__wf_atom_117cb74f(-2)

		if Duration > 0 then
			Sleep(Duration)
			__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
		end
	end
end

function TurnOnDynamicMusic()
	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
	end
end

function GoToDynamicMusicState()
	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		__wf_atom_a374c1f8:__wf_atom_f9f0178d(false)

		if StateName == EMPTY_SYMBOL then
			__wf_atom_a374c1f8:__wf_atom_117cb74f(StateNumber)
		else
			__wf_atom_a374c1f8:__wf_atom_cfa47f99(StateName)
		end

		if Duration > 0 then
			Sleep(Duration)
			__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
		end
	end
end

function StartMusic()
	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		__wf_atom_a374c1f8:__wf_atom_c4ac666f(MusicType)

		if StateNumber >= 0 or StateName:__wf_atom_8598f3a9() then
			__wf_atom_a374c1f8:__wf_atom_f9f0178d(false)
			Sleep(0.5)

			if StateName == EMPTY_SYMBOL then
				__wf_atom_a374c1f8:__wf_atom_117cb74f(StateNumber)
			else
				__wf_atom_a374c1f8:__wf_atom_cfa47f99(StateName)
			end

			if Duration > 0 then
				Sleep(Duration)
				__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
			end
		end
	end
end

function StopMusic()
	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
		__wf_atom_a374c1f8:__wf_atom_c4ac666f(nil)
	end
end

function ClearCustomMusicState()
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		return
	end

	__wf_atom_a374c1f8:__wf_atom_f9f0178d(true)
end

function SetCustomMusicState()
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

	if __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
		return
	end

	__wf_atom_a374c1f8:__wf_atom_f9f0178d(false)
	__wf_atom_a374c1f8:__wf_atom_117cb74f(StateNumber)
end