function ShowDecoWhileMeleeing(object)
	while true do
		local v = false
		local isVisible = object:IsVisible()
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_a06e971d) then
			local __wf_atom_21ed1a39 = __wf_atom_3d96ddcd:__wf_atom_21ed1a39()

			if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) and __wf_atom_21ed1a39:IsA(__wf_atom_77e05d3b) then
				v = __wf_atom_21ed1a39:__wf_atom_9f71ab59()

				if v and #ignoreComboContext > 0 then
					local __wf_atom_75a0566d = __wf_atom_21ed1a39:__wf_atom_75a0566d()

					if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
						local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

						for _, v2 in ipairs(ignoreComboContext) do
							if v2 ~= __wf_atom_f824cfe6 then
								continue
							end

							v = false
							break
						end
					end
				end
			end
		end

		if v and not isVisible then
			object:SetVisibility(true, true)
		elseif not v and isVisible then
			object:SetVisibility(false, true)
		end

		Sleep(0)
	end
end