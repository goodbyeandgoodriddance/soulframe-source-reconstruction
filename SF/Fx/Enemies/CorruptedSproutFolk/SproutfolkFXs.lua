function ShowLeash(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local v = 2.5

		while v > 0 do
			object:__wf_atom_a64eca67((__wf_atom_575542c8:__wf_atom_1c374cc9(Symbol("GAME_R1_HAND_LOW"))))
			v -= __wf_atom_084b3e93()
			Sleep(0)
		end
	end
end

function DestroyAllBlockFX(object)
	local __wf_atom_f582136d = object:__wf_atom_3d96ddcd():__wf_atom_f582136d(blockFX)

	for i = 1, #__wf_atom_f582136d do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
			__wf_atom_f582136d[i]:Destroy()
		end
	end
end