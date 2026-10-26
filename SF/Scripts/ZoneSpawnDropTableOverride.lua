function OnSpawn(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_7247d14f = gGameRules:__wf_atom_7247d14f(hardModeDebuffAuraUpgrade, __wf_atom_c4f78a8f)
	local dropTableOverrides = dropTableOverrides

	if not __wf_atom_7e8ad928(__wf_atom_7247d14f) then
		for k, v in pairs(hardModeDropTableOverrides) do
			if not __wf_atom_7e8ad928(v) then
				dropTableOverrides[k] = v
			end
		end
	end

	local __wf_atom_1bb5b1ff = gRegion:__wf_atom_8ad59546():__wf_atom_1bb5b1ff()

	for i, v in ipairs(regionLevelInfos) do
		local dropTableOverride = dropTableOverrides[i]

		if __wf_atom_1bb5b1ff ~= v or __wf_atom_7e8ad928(dropTableOverride) then
			continue
		end

		object:__wf_atom_c6a78fe5(dropTableOverride)
		break
	end
end