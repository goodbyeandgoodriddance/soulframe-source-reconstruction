function AddScreenEffect(instance)
	local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or not __wf_atom_f7e7be53:IsA(__wf_atom_7e6ed5fa) then
		instance:Destroy()
		return
	end

	if #__wf_atom_f7e7be53:__wf_atom_f582136d(instance:__wf_atom_1bb5b1ff()) > 1 then
		instance:Destroy()
		return
	end

	if __wf_atom_f7e7be53:__wf_atom_8efce136() then
		__wf_atom_f7e7be53:Attach(screenEffectType, Symbol("GAME_C1_HEAD1"))
	end

	local __wf_atom_7470861b = __wf_atom_f7e7be53:__wf_atom_7470861b()
	local v = math.min(__wf_atom_7470861b:__wf_atom_2bf72530() * 0.4, 400)
	local __wf_atom_7faf4619 = __wf_atom_7470861b:__wf_atom_7faf4619()

	while not __wf_atom_7e8ad928(__wf_atom_7470861b) and __wf_atom_7faf4619 < v do
		__wf_atom_7faf4619 = __wf_atom_7470861b:__wf_atom_7faf4619()
		Sleep(0)
	end

	instance:Destroy()
end