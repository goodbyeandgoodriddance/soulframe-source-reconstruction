local module = require("Lotus.Scripts.Libs.AudioLib")

function OnMount(_, object)
	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():__wf_atom_b9375444(false)
	end

	local position = gRegion:__wf_atom_c4f78a8f():GetPosition()
	module.EnableNearestTaggedSoundSysVolume(Symbol("WarsongWolfRideMusic"), true, position)
end

function OnDismount(_, _) end