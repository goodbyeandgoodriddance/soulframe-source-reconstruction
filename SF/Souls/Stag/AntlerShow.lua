Symbol("GAME_R1_WEAPON1")

function AntlerAttach(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) or not __wf_atom_21ed1a39:IsA(__wf_atom_77e05d3b) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:Attach(antlersType, EMPTY_SYMBOL)
	__wf_atom_6009c8ed:PlaySound(garrenSound, false, 1, false)
	Sleep(1)

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_be0bea4a = __wf_atom_6009c8ed:__wf_atom_be0bea4a()

	for _, v in ipairs(__wf_atom_be0bea4a) do
		if v:IsA(antlersType) then
			v:Destroy()
		end
	end
end

function AntlerDestroy(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) or not __wf_atom_21ed1a39:IsA(__wf_atom_77e05d3b) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_6009c8ed:__wf_atom_bb3e7833(antlersType)
	Sleep(1)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end