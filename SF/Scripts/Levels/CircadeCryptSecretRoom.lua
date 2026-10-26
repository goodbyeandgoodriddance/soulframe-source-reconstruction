local module = require("SF.Scripts.Libs.TransmissionSet")
local v = Resource("/SF/Sounds/Dialog/TransmissionSets/CircadeCryptTransmissionSet")
local v2 = Symbol("RedMuralDrapeBarrierTimer")
local v3 = Symbol("BlueMuralDrapeBarrierTimer")
local v4 = Symbol("GreenMuralDrapeBarrierTimer")
local v5 = false
local v6 = false
local v7 = false

function OnTimerExpired(object, _)
	if object:__wf_atom_db682341() == v2 and not v5 then
		Sleep(1)
		module.PlayGlobalTransmission(v, Symbol("PuzzleCompleteA"), false)
		v5 = true
	elseif object:__wf_atom_db682341() == v3 and not v6 then
		Sleep(1)
		module.PlayGlobalTransmission(v, Symbol("PuzzleCompleteB"), false)
		v6 = true
	elseif object:__wf_atom_db682341() == v4 and not v7 then
		Sleep(1)
		module.PlayGlobalTransmission(v, Symbol("PuzzleCompleteC"), false)
		v7 = true
	end
end

function Initialize()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v3)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(v4)

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		Sleep(0)
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)
	end

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) do
		Sleep(0)
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)
	end

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) do
		Sleep(0)
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)
	end

	v5 = false
	v6 = false
	v7 = false
	__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnTimerExpired")
	__wf_atom_55142dd4(__wf_atom_0a6a5887_2, "OnTimerExpired")
	__wf_atom_55142dd4(__wf_atom_0a6a5887_3, "OnTimerExpired")

	while not (v5 or v6 or v7) do
		Sleep(1)
	end
end