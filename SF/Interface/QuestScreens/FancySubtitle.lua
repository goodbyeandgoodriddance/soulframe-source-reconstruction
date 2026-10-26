local module = require("SF.Interface.SFUtilities")
local v = nil

function Initialize()
	module.RegisterHideSubtitles(true)
	module.DissolveIn(mMovie, nil, 3)
	local module2 = require("Lotus.Interface.Libs.TimerMgr")
	v = module2.CreateTimerMgr()
	v:AddTimer(5, function()
		module.DissolveOut(mMovie, nil, 3)
	end)
	v:AddTimer(15, function()
		module.RegisterHideSubtitles(false)
		mMovie:Close()
	end)
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_084b3e93())
	end
end