function PlayAnimOnAlert(object)
	if alertedAnimDelayMin > alertedAnimDelayMax then
		alertedAnimDelayMax = alertedAnimDelayMin
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(idleAnim, false, 3, 2, true)

		while not object:__wf_atom_04ea4887() do
			Sleep(0)
		end

		if alertedAnimDelayMax > 0 then
			local v = Random(0, 1) * (alertedAnimDelayMax - alertedAnimDelayMin) + alertedAnimDelayMin
			Sleep(v)
		end

		__wf_atom_50a7d83e:__wf_atom_921c1a5f(alertAnim, false, 3, 1, true)

		if not __wf_atom_7e8ad928(alertSequencer) then
			alertSequencer:Enable()
		end
	end
end