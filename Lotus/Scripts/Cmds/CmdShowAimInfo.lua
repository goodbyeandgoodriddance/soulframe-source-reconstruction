function CmdShowAimInfo()
	if _T.CmdShowAimInfo then
		_T.CmdShowAimInfo = nil
		return
	end

	local v = Color(255, 0, 0, 255)
	local v2 = Color(255, 255, 255, 255)
	_T.CmdShowAimInfo = true

	while _T.CmdShowAimInfo do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				local __wf_atom_74d951b0 = __wf_atom_d2b2176d:__wf_atom_74d951b0()
				local __wf_atom_f2e7f4a9 = __wf_atom_d2b2176d:__wf_atom_f2e7f4a9()
				local v3, v4

				if __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) then
					v3 = __wf_atom_74d951b0
					v4 = "nil"
				else
					v3 = __wf_atom_f2e7f4a9:__wf_atom_a2a18137()
					v4 = __wf_atom_f2e7f4a9:__wf_atom_5b41f63b() .. "\n" .. tostring(v3) .. ", " .. tostring(__wf_atom_f2e7f4a9:__wf_atom_2f2bada0()) .. "\n" .. __wf_atom_f2e7f4a9:__wf_atom_db682341():c_str()
				end

				gRegion:__wf_atom_8d991675(__wf_atom_74d951b0, 0.025, v2, 0)
				gRegion:__wf_atom_8d991675(v3, 0.025, v, 0)
				gRegion:__wf_atom_628723a6(__wf_atom_74d951b0, v3, v2, 0)
				gRegion:__wf_atom_5b35a0c8(__wf_atom_74d951b0, v2, v4, 1, 0)
			end
		end

		Sleep(0)
	end
end