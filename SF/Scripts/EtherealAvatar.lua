function ApplyEthereal(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		return
	end

	object:SetVisibility(false, true)
	Sleep(0)
	local __wf_atom_70f5d0a5 = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_70f5d0a5(object)
	local __wf_atom_2586e47b = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_2586e47b(__wf_atom_70f5d0a5)

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb())) do
		if gMatchingService:__wf_atom_9c7c90fb():__wf_atom_3179c2db(__wf_atom_2586e47b) then
			Sleep(0)

			if not __wf_atom_7e8ad928(projectorAttachment) then
				object:Attach(projectorAttachment, EMPTY_SYMBOL)
			end

			if not __wf_atom_7e8ad928(sphereDeco) then
				object:Attach(sphereDeco, EMPTY_SYMBOL)
			end

			if not __wf_atom_7e8ad928(materialOverride) then
				object:__wf_atom_a887a262(0, materialOverride, true)
				object:__wf_atom_a887a262(1, materialOverride, true)

				for _, v in object:__wf_atom_f582136d(__wf_atom_8d0b7f88) do
					v:__wf_atom_a887a262(0, materialOverride, false)
				end
			end

			object:__wf_atom_a763aa1a(1)
			object:SetVisibility(true, true)
			local v = 1

			while v > 0 do
				v = __wf_atom_421b01aa(v - __wf_atom_084b3e93(), 0, 1)
				object:__wf_atom_a763aa1a(v)
				Sleep(0)
			end

			break
		else
			Sleep(0)
		end
	end
end