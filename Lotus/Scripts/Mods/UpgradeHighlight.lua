function UpgradeHighlightUpdate(object)
	local v = nil
	local v2 = nil

	while __wf_atom_7e8ad928(v) do
		v = object:__wf_atom_a21478e7()
		Sleep(0)
	end

	local __wf_atom_37a29496 = v:__wf_atom_37a29496()

	if not __wf_atom_7e8ad928(__wf_atom_37a29496) and __wf_atom_37a29496:IsA(__wf_atom_0b6f0357) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(modMarkerInfoType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		v:Attach(fusionBundleMarkerInfoType, EMPTY_SYMBOL)
	end

	local v3 = Range()
	v3.minValue = 0

	while true do
		if __wf_atom_7e8ad928(v2) then
			v2 = gRegion:__wf_atom_c4f78a8f()
			Sleep(0)
		else
			if not v2:IsA(__wf_atom_7e6ed5fa) then
				break
			end

			local __wf_atom_d2b2176d = v2:__wf_atom_d2b2176d()
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				Sleep(0)
				continue
			end

			v3.maxValue = __wf_atom_d2b2176d:__wf_atom_2a745663(
				0,
				95,
				__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
				__wf_atom_e55d02aa
			)
			local __wf_atom_1915cc84 = __wf_atom_d2b2176d:__wf_atom_1915cc84()

			if not (__wf_atom_7e8ad928(__wf_atom_1915cc84) or __wf_atom_1915cc84:IsKilled()) then
				local __wf_atom_e55d02aa2 = __wf_atom_1915cc84:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

				if not __wf_atom_7e8ad928(__wf_atom_e55d02aa2) then
					v3.maxValue += __wf_atom_1915cc84:__wf_atom_d2b2176d():__wf_atom_2a745663(
						0,
						95,
						__wf_atom_e55d02aa2:__wf_atom_1bb5b1ff(),
						__wf_atom_e55d02aa2
					)
				end
			end

			if v3.maxValue > 0 then
				local v4 = v:Attach(modTrackFx, EMPTY_SYMBOL)

				if not __wf_atom_7e8ad928(v4) then
					v4:__wf_atom_18f27a89(v3)
					break
				end
			end

			break
		end
	end
end