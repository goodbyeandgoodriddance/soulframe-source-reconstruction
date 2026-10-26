module(..., package.seeall)
require("SF.Scripts.Libs.AncestorsFunctionLib")
local _ = {}
WeakResource("/SF/Commands/CmdAncestor")

function AncestorManager(_)
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	if __wf_atom_7e8ad928(_T.ForceAnscestorStationsNightfold) then
		_T.ForceAnscestorStationsNightfold = false
	end

	__wf_atom_48bcafdc()
	return false
end