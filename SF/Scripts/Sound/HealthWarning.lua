function Initialize(instance)
	if useAttachParent then
		instance = instance:__wf_atom_3d96ddcd()
	end

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_67c46eba) then
		return
	end

	local maxHealth = instance:GetMaxHealth()
	local v = instance:__wf_atom_c6f1f83d() / maxHealth
	local isKilled = instance:IsKilled()
	local v2 = false
	local v3 = false

	while true do
		local isKilled2 = instance:IsKilled()
		local killedSound2 = nil

		if isKilled2 and not isKilled then
			killedSound2 = killedSound
		else
			local v4 = instance:__wf_atom_c6f1f83d() / maxHealth

			if v2 or not (v4 <= criticalHealthRatio and criticalHealthRatio < v) then
				v2 = false

				if v3 or not (v4 <= lowHealthRatio and lowHealthRatio < v) then
					if v3 and lowHealthRatio < v4 and v <= lowHealthRatio then
						killedSound2 = exitLowHealthSound
						v3 = false
					end
				else
					killedSound2 = lowHealthSound
					v3 = true
				end
			else
				killedSound2 = criticalHealthSound
				v2 = true
			end

			v = v4
		end

		if not __wf_atom_7e8ad928(killedSound2) then
			instance:PlaySound(killedSound2, false, 1, false, nil, 1)
		end

		Sleep(0.05)
		isKilled = isKilled2
	end
end