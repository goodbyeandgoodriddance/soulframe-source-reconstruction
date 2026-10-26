function windDestroy(instance)
	local total = 0

	while total < 1 and not __wf_atom_7e8ad928(instance) do
		total += __wf_atom_084b3e93() * 2
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end