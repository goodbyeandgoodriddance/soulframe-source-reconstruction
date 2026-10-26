function ScaleDeco()
	local v = { 0 }
	local total = 0

	for i = 1, #targetDecos do
		v[i] = targetDecos[i]:__wf_atom_c082fc3d()
	end

	while total < 1 do
		for i = 1, #targetDecos do
			local v2 = __wf_atom_104bfe98(v[i], finalScale, total)

			if not __wf_atom_7e8ad928(targetDecos[i]) then
				targetDecos[i]:SetMeshScale(v2)
			end
		end

		total += __wf_atom_084b3e93() / scaleDuration
		Sleep(0)
	end
end