local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")

function KickOffArrivalCin(_)
	module2.PlayCinematicWithTagAndWait(Symbol("CollectorCin"))
	module.PlayGlobalTransmission(deoraTransmissionSet, Symbol("CollectorLanded"))
	_T.CollectorShipLanded = true
end

function CollectorDissolveIn()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887:__wf_atom_68f2c268((__wf_atom_104bfe98(1, 0, total / 1)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_68f2c268(0)
	end
end

function CollectorDissolveOut()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887:__wf_atom_68f2c268((__wf_atom_104bfe98(0, 1, total / 1)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:__wf_atom_68f2c268(1)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorHidingPlace"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887:Teleport(__wf_atom_0a6a5887_2:GetPosition(), __wf_atom_80368bb1)
	end
end

function CollectorShake(object)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_1ee2a2df = object:__wf_atom_1ee2a2df()

	while __wf_atom_1ee2a2df < 0.91 and not __wf_atom_7e8ad928(object) do
		__wf_atom_1ee2a2df = object:__wf_atom_1ee2a2df()
		postProcess:__wf_atom_54a04966(__wf_atom_1ee2a2df)
		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:PlaySound(endSound, false)
	end

	local v = 1

	while v > 0 and not __wf_atom_7e8ad928(postProcess) do
		v = __wf_atom_421b01aa(v - __wf_atom_084b3e93() / 3, 0, 1)
		postProcess:__wf_atom_54a04966(v * 4)
		Sleep(0)
	end
end