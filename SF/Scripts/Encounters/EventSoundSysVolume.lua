local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function AfterParentDestroyWaitForComatToEnd(object)
	Engine.__wf_atom_878bebe4(object)

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd())) do
		Sleep(1)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	Sleep(30)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and not __wf_atom_7e8ad928(object)
		and module.PlayerIsInBattle(__wf_atom_c4f78a8f)
	do
		Sleep(3)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	gRegion:__wf_atom_dd1e4d10(object)
end