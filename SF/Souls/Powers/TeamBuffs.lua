local v = Symbol("BlockingBehavior")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if requireEnemyTarget and __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_216d6edd()) then
		return 0
	end

	local v2 = Time()

	if v2 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(cooldownUniqueId) < teamCooldown then
		return 0
	end

	local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

	if
		#__wf_atom_694c2c5b < teammateCountRequired
		or _T.OdeTeamBuffActive ~= nil and _T.OdeTeamBuffActive[object2:__wf_atom_18aa6e58()]
	then
		return 0
	end

	local v3 = object2
	local v4 = 100000000
	local count = 0

	for _, v5 in ipairs(__wf_atom_694c2c5b) do
		if
			not (alsoCastOnSelf or v5 ~= object2)
			or (v5:IsKilled() or v5:__wf_atom_bedb4e3f())
			or not v5:__wf_atom_3a6b0cbb()
		then
			continue
		end

		local __wf_atom_9af7625d = v5:__wf_atom_9af7625d(object2)

		if not (__wf_atom_9af7625d < distanceToTeammates * distanceToTeammates) then
			continue
		end

		if __wf_atom_9af7625d < v4 then
			v3 = v5
			v4 = __wf_atom_9af7625d
		end

		count += 1

		if teammateCountRequired <= count then
			break
		end
	end

	if teammateCountRequired <= count then
		object:__wf_atom_f7170fc9(v3)
		__wf_atom_30e3d82b:__wf_atom_11d3ea0f(cooldownUniqueId, v2)
		return 1
	else
		return 0
	end
end

function ActivateAbility(p, object, object2, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object)
	end

	if not __wf_atom_7e8ad928(object2) and object2 ~= object then
		object:__wf_atom_84d66e8e(__wf_atom_fa8d0177(object:GetPosition(), object2:GetPosition()))
	end

	object:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)

	if _T.OdeTeamBuffActive == nil then
		_T.OdeTeamBuffActive = {}
	end

	if not module.PlayAnimAndSuspendUntilEvent(p, startAnim, animEventToApplyBuff, false, 2, 1, false) then
		return
	end

	local v2 = gRegion:IsMaster() and 3 or 4

	if alsoCastOnSelf and not _T.OdeTeamBuffActive[object:__wf_atom_18aa6e58()] then
		object:Attach(buffingObject, buffingObjectAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, v2):__wf_atom_8a035cd5(
			Symbol("ApplyBuff"),
			false
		)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

		for _, v3 in ipairs(__wf_atom_694c2c5b) do
			if __wf_atom_7e8ad928(v3) or v3 == object or (v3:IsKilled() or v3:__wf_atom_bedb4e3f()) then
				continue
			end

			if
				not (v3:__wf_atom_9af7625d(object) < distanceToTeammates * distanceToTeammates)
				or _T.OdeTeamBuffActive[v3:__wf_atom_18aa6e58()]
			then
				continue
			end

			v3:Attach(buffingObject, buffingObjectAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
			v3:__wf_atom_8a035cd5(Symbol("ApplyBuff"), false)
			Sleep(delayBetweenApplyingToEachTeammate:__wf_atom_ff1686f2())
		end
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(startAnim) do
		Sleep(0)
	end
end

function ApplyBuff(instance)
	local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(buffingObject)

	if __wf_atom_7e8ad928(instance) then
		print("TeamBuffs.lua attached the buff on... nothing!")

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	elseif instance:IsA(__wf_atom_7e6ed5fa) then
		if _T.OdeTeamBuffActive == nil then
			_T.OdeTeamBuffActive = {}
		end

		local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()
		_T.OdeTeamBuffActive[instance:__wf_atom_18aa6e58()] = true
		local __wf_atom_68de036a = instance:__wf_atom_68de036a()
		local v2 = baseArmourAdded + armourAddedMultiplierPerLevel * __wf_atom_68de036a
		local v3 = baseMagicArmourAdded + magicArmourAddedMultiplierPerLevel * __wf_atom_68de036a
		local v4 = baseDamageAdded + damageAddedMultiplierPerLevel * __wf_atom_68de036a
		local v5 = baseStabilityDamageSubtraction + stabilityDamageSubtractionMultiplierPerLevel * __wf_atom_68de036a

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(instance) then
			instance:__wf_atom_d2b2176d():AddUpgrade(20, 0, v2, nil, nil, 21)
			instance:__wf_atom_d2b2176d():AddUpgrade(20, 0, v3, nil, nil, 25)
			instance:__wf_atom_d2b2176d():AddUpgrade(292, 0, v4)
			instance:__wf_atom_d2b2176d():AddUpgrade(168, 0, v5)

			if guardBreak then
				instance:__wf_atom_d2b2176d():AddUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
			end
		end

		local duration = duration
		local creator = __wf_atom_bb3e7833:GetCreator()

		while
			duration > 0
			and not (__wf_atom_7e8ad928(creator) or creator:IsKilled() or creator:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(instance) or instance:IsKilled() or instance:__wf_atom_bedb4e3f())
		do
			Sleep(0)
			duration -= __wf_atom_084b3e93()
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(instance) then
			instance:__wf_atom_d2b2176d():RemoveUpgrade(20, 0, v2, nil, nil, 21)
			instance:__wf_atom_d2b2176d():RemoveUpgrade(20, 0, v3, nil, nil, 25)
			instance:__wf_atom_d2b2176d():RemoveUpgrade(292, 0, v4)
			instance:__wf_atom_d2b2176d():RemoveUpgrade(168, 0, v5)

			if guardBreak then
				instance:__wf_atom_d2b2176d():RemoveUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
			end
		end

		if _T.OdeTeamBuffActive ~= nil then
			_T.OdeTeamBuffActive[__wf_atom_18aa6e58] = nil
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	else
		print("TeamBuffs.lua attached the buff on a non-avatar! " .. instance:__wf_atom_5b41f63b())

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function DeactivateAbility(_, object, _, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
	end
end