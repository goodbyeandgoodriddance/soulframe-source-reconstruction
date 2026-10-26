function DestroyEmptyContainerHint(instance)
	Sleep(minAliveTime)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_8f18e876 = instance:__wf_atom_8f18e876()

	while true do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v = false

		for _, v2 in ipairs(__wf_atom_ef7900cf) do
			if v2:__wf_atom_8a6b8fc3(instance) <= __wf_atom_8f18e876 then
				v = true
			end
		end

		if not v then
			break
		end

		Sleep(5)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end