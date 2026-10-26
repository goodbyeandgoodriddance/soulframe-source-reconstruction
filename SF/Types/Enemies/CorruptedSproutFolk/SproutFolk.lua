function ToggleClawHand(object, p)
	local v = p > 0 and Vector(0.001, 0.001, 0.001) or Vector(1, 1, 1)
	local __wf_atom_15197633 = object:__wf_atom_21ed1a39():__wf_atom_15197633()
	__wf_atom_15197633:__wf_atom_83fac646(boneName, __wf_atom_80368bb1, __wf_atom_28d5d4aa, v)
	local __wf_atom_30e3d82b = __wf_atom_15197633:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_5a0e15fd(Symbol("ClawLaunched"), p)
	end
end