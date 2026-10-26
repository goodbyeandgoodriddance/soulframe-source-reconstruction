require("SF.Scripts.Libs.CommonFunctionsLib")

function MockeryFinisherEndscript(_, object)
	object:__wf_atom_8a035cd5(Symbol("ChildScript"), false)
end

function ChildScript(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowGuideDeco"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowGuideDeco"))
		Sleep(0)
	end

	__wf_atom_0a6a5887:SetVisibility(false)
	object:__wf_atom_8914dfde("sparrowVisible", 2)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true)
	end
end