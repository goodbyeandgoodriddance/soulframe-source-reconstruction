local v = nil

function NpcEvaluateAbility(_, object)
	local __wf_atom_694c2c5b = object:__wf_atom_30e3d82b():__wf_atom_694c2c5b()
	local count = 0

	for _, v2 in ipairs(__wf_atom_694c2c5b) do
		if
			v2 == object
			or (v2:IsKilled() or v2:__wf_atom_bedb4e3f())
			or not (v2:__wf_atom_bb81a9df() < healthPctToBegin)
		then
			continue
		end

		if not (v2:__wf_atom_9af7625d(object) < distanceToTeammate * distanceToTeammate) then
			continue
		end

		count += 1

		if hurtAgentsToBegin <= count then
			return 1
		end
	end

	return 0
end

function OnTriggerTouched(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:Attach(healingFx, Symbol("GAME_C1_ROOT"))
	end
end

function OnUntouched(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_0650fed7(healingFx)
	end
end

function ActivateAbility(_, object, _, _)
	object:__wf_atom_921c1a5f(loopingAnim, false, 2, 2)
	v = object:Attach(healingTrigger, triggerAttachBoneName)
	Sleep(0.5)
	local total = 0

	while
		not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and total < healTime
		and (object:__wf_atom_c138b19b(loopingAnim) or object:__wf_atom_3c281634(loopingAnim))
		and not __wf_atom_7e8ad928(v)
		and v:__wf_atom_acccc08b()
	do
		total += __wf_atom_084b3e93()
		local __wf_atom_6f4fd712 = v:__wf_atom_6f4fd712()

		for _, v2 in pairs(__wf_atom_6f4fd712) do
			if __wf_atom_7e8ad928(v2) or v2:__wf_atom_bedb4e3f() or v2:IsKilled() then
				continue
			end

			if not object:__wf_atom_8c3af1a5(v2:__wf_atom_e93896ba()) then
				continue
			end

			v2:Heal(v2, healPerSecond * __wf_atom_084b3e93())
		end

		Sleep(0)
	end
end

function DeactivateAbility(_, object, _, _)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(nil, false, 2)
		object:__wf_atom_0650fed7(healingTrigger)
	end
end