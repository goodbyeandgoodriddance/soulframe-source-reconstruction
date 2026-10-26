local v = Symbol("GAME_R1_WEAPON1")

function StartWireGrab(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) or not __wf_atom_21ed1a39:IsA(__wf_atom_77e05d3b) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_75a0566d = __wf_atom_21ed1a39:__wf_atom_75a0566d()

	if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
		return
	end

	local __wf_atom_2a745663 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("AutoTarget")
	)
	local wireLevelOne = wireLevelOne

	if __wf_atom_2a745663 == 2 then
		wireLevelOne = wireLevelTwo
	elseif __wf_atom_2a745663 == 3 or __wf_atom_2a745663 == 4 then
		wireLevelOne = wireLevelThree
	end

	local v2 = nil
	local v3 = false

	while
		not __wf_atom_7e8ad928(__wf_atom_75a0566d)
		and __wf_atom_75a0566d:__wf_atom_f824cfe6() == 19
		and __wf_atom_75a0566d:__wf_atom_d6411cd7()
	do
		if __wf_atom_7e8ad928(v2) and not v3 then
			local __wf_atom_1ffe3ac8 = __wf_atom_21ed1a39:__wf_atom_1ffe3ac8()

			if not (__wf_atom_7e8ad928(__wf_atom_1ffe3ac8) or __wf_atom_7e8ad928(__wf_atom_6009c8ed)) then
				v2 = __wf_atom_6009c8ed:Attach(wireLevelOne, v, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

				if not __wf_atom_7e8ad928(v2) then
					v2:__wf_atom_341daa34(__wf_atom_1ffe3ac8, 0)
					v3 = true
				end

				if __wf_atom_2a745663 == 4 then
					__wf_atom_6009c8ed:Attach(lightningBeamType, v, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_341daa34(
						__wf_atom_1ffe3ac8,
						0
					)
				end
			end
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end
end