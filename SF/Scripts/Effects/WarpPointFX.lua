function ActivateWarpPointFx(object)
	if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(warpActivateFxType))) then
		object:Attach(warpActivateFxType, EMPTY_SYMBOL, Vector(0, 0, -3), __wf_atom_80368bb1)
	end
end

function DeactivateWarpPointFx(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(warpActivateFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end