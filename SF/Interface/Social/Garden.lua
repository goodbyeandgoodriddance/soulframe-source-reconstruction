local v = false

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 80)
end

function Update()
	if not v then
		local __wf_atom_18aa6e58 = mMovie:__wf_atom_8cdb5ac9():__wf_atom_3d96ddcd():__wf_atom_18aa6e58()

		for i = 1, #_T.GardenClaimedPlots do
			local gardenClaimedPlot = _T.GardenClaimedPlots[i]

			if gardenClaimedPlot.P ~= __wf_atom_18aa6e58 then
				continue
			end

			mMovie:__wf_atom_50d60589("Name", 36, gardenClaimedPlot.N)
			mMovie:__wf_atom_50d60589("Message", 36, gardenClaimedPlot.M)
			mMovie:__wf_atom_50d60589("Date", 36, gardenClaimedPlot.date)
			break
		end

		v = true
	end
end