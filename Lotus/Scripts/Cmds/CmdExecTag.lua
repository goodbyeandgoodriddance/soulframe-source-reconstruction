local v = WeakResource("/EE/Types/Effects/PortForwarder")

function ExecTag(value)
	if type(value) ~= "string" then
		return
	end

	local v2 = Symbol(value)

	if not v2:__wf_atom_8598f3a9() or v2 == EMPTY_SYMBOL then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v2)

	for i = 1, #__wf_atom_2226b35c do
		local v3 = __wf_atom_2226b35c[i]

		if __wf_atom_7e8ad928(v3) then
			continue
		end

		if v3:IsA(__wf_atom_589cefdb) then
			v3:FirePort("Execute")
		elseif v3:IsA(v) then
			v3:FirePort("TriggerPort")
		elseif v3:IsA(__wf_atom_c9fc989f) then
			v3:FirePort("StartPlaying")
		end
	end
end