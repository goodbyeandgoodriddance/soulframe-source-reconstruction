function PlaySoundFromTransmission()
	local curTransmission = _T.curTransmission

	if __wf_atom_7e8ad928(curTransmission) then
		return
	end

	if waitForEnd then
		while _T.curTransmission == curTransmission do
			Sleep(0)
		end
	end

	if delay > 0 then
		Sleep(delay)
	end

	if not __wf_atom_7e8ad928(sound) then
		local v = nil

		if soundEmitterTag:__wf_atom_8598f3a9() then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(soundEmitterTag)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				v = __wf_atom_0a6a5887
			end
		end

		if __wf_atom_7e8ad928(v) then
			gRegion:PlaySound(sound, __wf_atom_28d5d4aa, false)
		else
			v:PlaySound(sound, false)
		end
	end

	for _, v in ipairs(enableSequencersWithTags) do
		if not v:__wf_atom_8598f3a9() then
			continue
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v)

		for _, v2 in ipairs(__wf_atom_2226b35c) do
			if v2:IsA(__wf_atom_465d956f) then
				v2:Enable()
			end
		end
	end

	for _, v in ipairs(disableSequencersWithTags) do
		if not v:__wf_atom_8598f3a9() then
			continue
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v)

		for _, v2 in ipairs(__wf_atom_2226b35c) do
			if v2:IsA(__wf_atom_465d956f) then
				v2:Disable()
			end
		end
	end
end