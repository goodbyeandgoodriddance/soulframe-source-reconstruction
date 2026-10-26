module(..., package.seeall)
require("SF.Scripts.Libs.PlayerPetLib")
mSkillTmp = {}
mXPAmount = 40

function PetsManager(_)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gRegion) then
		return false
	end

	if __wf_atom_7e8ad928(_T.ForceAnscestorStationsNightfold) then
		_T.ForceAnscestorStationsNightfold = false
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_cbbadcfc = __wf_atom_eab484a7:__wf_atom_cbbadcfc()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return
	end

	local __wf_atom_1915cc84 = __wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_1915cc84()

	if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
		__wf_atom_1915cc84:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_e919fb8e = __wf_atom_1915cc84:__wf_atom_e919fb8e()

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.RankupAnim) then
			local _rankupAnim = __wf_atom_e919fb8e.RankupAnim
		end
	end

	__wf_atom_eab484a7:__wf_atom_4febbf37()
	__wf_atom_48bcafdc()
	return false
end