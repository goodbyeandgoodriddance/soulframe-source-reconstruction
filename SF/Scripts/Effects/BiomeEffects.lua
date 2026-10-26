function BiomeCheck(object)
	Sleep(0.2)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	__wf_atom_575542c8:__wf_atom_e800787c()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	local v = __wf_atom_575542c8:Attach(effectsList[1], EMPTY_SYMBOL)
	Color(0, 0, 0)
	local v2 = 0
	local v3 = 0

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) do
		local __wf_atom_e800787c = __wf_atom_575542c8:__wf_atom_e800787c()
		local green

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			green = v2
		elseif __wf_atom_e800787c:IsA(__wf_atom_84f14cb7) and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			green = __wf_atom_0a6a5887:GetColor(__wf_atom_575542c8:GetPosition(), false).green
			v3 = v2
		else
			green = 0
		end

		if green ~= v3 or __wf_atom_575542c8:__wf_atom_799d95f5() then
			if not __wf_atom_7e8ad928(v) then
				v:Destroy()
			end

			if not __wf_atom_575542c8:__wf_atom_799d95f5() then
				local v4 = effectsList[green + 1]

				if not __wf_atom_7e8ad928(v4) then
					v = __wf_atom_575542c8:Attach(v4, EMPTY_SYMBOL)
				end
			end
		end

		Sleep(1)
		v2 = green
	end
end