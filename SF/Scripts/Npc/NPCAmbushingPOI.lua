local v = Symbol("DoAmbush")

function AmbushSetUp(object, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_30e3d82b())) then
		return
	end

	object2:SetBlackboardBool(v, true)
	object:Disable()
end