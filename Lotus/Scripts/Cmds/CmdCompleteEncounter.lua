function EndEncounter(p)
	local all = gRegion:FindAll(__wf_atom_f806fd7a)

	for _, v in ipairs(all) do
		if v:IsPrimed() and v:IsActive() then
			local __wf_atom_e529dedd = v:__wf_atom_e529dedd()

			for _, v2 in ipairs(__wf_atom_e529dedd) do
				if not v2:__wf_atom_dd85e6db():IsMissionEncounter() then
					continue
				end

				if success then
					if p then
						_T.QualifiedForBountyBonus = true
					end

					v2:__wf_atom_8e6fec76(4)
				else
					v2:__wf_atom_8e6fec76(5)
				end
			end
		else
			local __wf_atom_dd85e6db = v:__wf_atom_dd85e6db()

			if
				not __wf_atom_7e8ad928(__wf_atom_dd85e6db)
				and __wf_atom_dd85e6db:__wf_atom_7026c43c()
				and v:IsActive()
			then
				if success then
					if p then
						_T.QualifiedForBountyBonus = true
					end

					v:__wf_atom_8e6fec76(4)
				else
					v:__wf_atom_8e6fec76(5)
				end
			end
		end
	end
end

function StartEncAtCursor(p)
	local __wf_atom_74d951b0 = gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_74d951b0()
	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_c4c644af(__wf_atom_74d951b0, p)
end