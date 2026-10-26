function OnOwnerSet(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.WolfPupStickHitRemaining = 2
	end
end

function OnStickMeleeHit(_, object, object2, _)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_679ed446 = object:__wf_atom_679ed446()

	if __wf_atom_7e8ad928(__wf_atom_679ed446) or object2:__wf_atom_129d1aba(__wf_atom_679ed446) then
		return
	end

	local __wf_atom_464a4772 = object2:__wf_atom_464a4772()

	if not __wf_atom_464a4772 then
		local wolfPupStickHitRemaining = (__wf_atom_7e8ad928(__wf_atom_679ed446:__wf_atom_e919fb8e().WolfPupStickHitRemaining) and 2 or __wf_atom_679ed446:__wf_atom_e919fb8e().WolfPupStickHitRemaining) - 1

		if wolfPupStickHitRemaining <= 0 then
			__wf_atom_464a4772 = true
		else
			local __wf_atom_e919fb8e = __wf_atom_679ed446:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.WolfPupStickHitRemaining = wolfPupStickHitRemaining
		end
	end

	if __wf_atom_464a4772 and not __wf_atom_7e8ad928(__wf_atom_679ed446) then
		if
			gRegion:IsMaster()
			and not __wf_atom_7e8ad928((__wf_atom_679ed446:__wf_atom_d2b2176d():__wf_atom_97d575cf(4)))
		then
			__wf_atom_679ed446:__wf_atom_d2b2176d():__wf_atom_6cdc5077()
		end

		if not __wf_atom_7e8ad928(brokenFXSpawner) then
			local __wf_atom_1c374cc9 = __wf_atom_679ed446:__wf_atom_1c374cc9((Symbol("GAME_R1_WEAPON1")))
			gRegion:CreateEntity(brokenFXSpawner, __wf_atom_1c374cc9, __wf_atom_679ed446:__wf_atom_dc309f8a())
		end
	end
end