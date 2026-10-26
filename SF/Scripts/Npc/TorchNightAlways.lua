function ForceTorchAlways(object)
	if not __wf_atom_7e8ad928(object) then
		if forceTorchOn then
			object:SetBlackboardBool(Symbol("ForceTorch"), true)
		else
			object:SetBlackboardBool(Symbol("ForceTorch"), false)
		end
	end
end