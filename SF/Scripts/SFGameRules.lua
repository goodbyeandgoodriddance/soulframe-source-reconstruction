local v = Symbol("TENNO")
local v2 = Symbol("HardModeActive")

function OnLevelLoaded(_)
	if not _T.OnPlayerSpawnedCallbacks then
		_T.OnPlayerSpawnedCallbacks = {}
	end
end

function OnPlayerSpawned(p, p2)
	for _, onPlayerSpawnedCallback in pairs(_T.OnPlayerSpawnedCallbacks) do
		onPlayerSpawnedCallback(p, p2)
	end
end

function OnAgentCreated(_, object)
	local __wf_atom_8b3e33a6 = gMatchingService:__wf_atom_8b3e33a6()

	if __wf_atom_8b3e33a6 < 2 then
		return
	end

	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local __wf_atom_6f203663 = object:__wf_atom_6f203663()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_66ddf29d(v) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()
	local v3, v4

	if gGameRules:__wf_atom_d163c8e5(v2, 0) ~= 0 then
		if __wf_atom_50a7d83e:__wf_atom_464a4772() then
			v3 = __wf_atom_8b3e33a6 * 0.8
			v4 = __wf_atom_8b3e33a6 * 0.7
		else
			if __wf_atom_6f203663 == 2 or __wf_atom_6f203663 == 1 then
				v3 = __wf_atom_8b3e33a6 * 0.5
			else
				v3 = __wf_atom_8b3e33a6 * 0.3
			end

			v4 = __wf_atom_8b3e33a6 * 0.5
		end
	elseif __wf_atom_50a7d83e:__wf_atom_464a4772() then
		v3 = (__wf_atom_8b3e33a6 - 1) * 0.6
		v4 = (__wf_atom_8b3e33a6 - 1) * 0.6
	else
		if __wf_atom_6f203663 == 2 or __wf_atom_6f203663 == 1 then
			v3 = (__wf_atom_8b3e33a6 - 1) * 0.25
		else
			v3 = (__wf_atom_8b3e33a6 - 1) * 0.15
		end

		v4 = (__wf_atom_8b3e33a6 - 1) * 0.4
	end

	__wf_atom_d2b2176d:AddUpgrade(170, 3, v3)
	__wf_atom_d2b2176d:AddUpgrade(84, 3, v4)
	__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:GetMaxHealth())
end