function ClawShow(object)
	local v = WeakResource("/SF/Characters/PlayerCharacters/Orengal/OrengalClawDeco")
	Sleep(1)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(v)
	local __wf_atom_d2b2176d = __wf_atom_3d96ddcd:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)
	local __wf_atom_28224c27_2 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)
	local v2 = true

	while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_bb3e7833)) do
		local v3 = __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_28224c27:__wf_atom_c5d04cb3()
		local v4 = not v3
			and not __wf_atom_7e8ad928(__wf_atom_28224c27_2)
			and __wf_atom_d2b2176d:__wf_atom_a028fd97(0) == 0
			or v3
		local v5 = not v4
			and __wf_atom_28224c27:__wf_atom_9f71ab59()
			and __wf_atom_28224c27:__wf_atom_5e005c29() == 2
			and true
			or v4

		if v5 or not v2 then
			if v5 and not v2 then
				__wf_atom_bb3e7833:SetVisibility(true)
				__wf_atom_bb3e7833:__wf_atom_a763aa1a(0)
				__wf_atom_bb3e7833:Attach(clawShowFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		else
			__wf_atom_bb3e7833:Attach(clawHideFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			Sleep(0.25)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:SetVisibility(false)
				__wf_atom_bb3e7833:__wf_atom_a763aa1a(1)
			end
		end

		Sleep(0)
		v2 = v5
	end
end

function SpawnExtraHitEffect(object, object2, _, _)
	if not __wf_atom_7e8ad928(extraFxType) then
		local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

		if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
			gRegion:CreateEntity(
				extraFxType,
				object2:__wf_atom_3e5615f2(),
				__wf_atom_80368bb1,
				__wf_atom_21ed1a39,
				__wf_atom_21ed1a39
			)
		end
	end
end