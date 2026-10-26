function CompletePoiObjective()
	local all = gRegion:FindAll(__wf_atom_f806fd7a)

	for _, v in ipairs(all) do
		if not v:IsActive() then
			continue
		end

		local __wf_atom_dd85e6db = v:__wf_atom_dd85e6db()

		if __wf_atom_dd85e6db:__wf_atom_d1c34673(Symbol("PoiMission")) and v:__wf_atom_2b1fe281() > 1 then
			v:__wf_atom_8e6fec76(4)
		elseif __wf_atom_dd85e6db:__wf_atom_d1c34673(Symbol("CapitalShip")) and v:__wf_atom_2b1fe281() > 1 then
			v:__wf_atom_8e6fec76(4)
		end
	end
end