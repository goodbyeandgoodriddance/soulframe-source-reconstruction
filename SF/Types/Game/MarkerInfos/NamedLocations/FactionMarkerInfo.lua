function Initialize(p)
	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(1)
	end

	local playerAvatar = nil

	while __wf_atom_7e8ad928(playerAvatar) do
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

			if not __wf_atom_7e8ad928(playerAvatar) then
				break
			end
		end

		Sleep(1)
	end

	local __wf_atom_705a2744 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_705a2744(loreFragment, loreMemory)
	local all = gRegion:FindAll(p)

	for _, v in all do
		local __wf_atom_e919fb8e = v:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.faction = faction
		__wf_atom_e919fb8e.originalIcon = v:__wf_atom_e32e2012()
		v:__wf_atom_ff716ec1(__wf_atom_705a2744)
	end
end