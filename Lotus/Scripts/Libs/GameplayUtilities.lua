module(..., package.seeall)

function WaitForOpeningCin()
	local v = Symbol("OpenCinDone")

	while
		not __wf_atom_7e8ad928(gGameRules)
		and gGameRules:__wf_atom_d163c8e5(v, 0) < 1
		and not __wf_atom_72884638("Server.FastLoad")
	do
		Sleep(0)
	end
end