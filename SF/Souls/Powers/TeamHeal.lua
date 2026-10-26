local v = Symbol("OdeTeamHealCooldown")
local v2 = Symbol("BlockingBehavior")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()

	if not __wf_atom_9a1e4ed3.visible then
		return 0
	end

	local v3 = Time()

	if v3 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v) < teamCooldown then
		return 0
	end

	if allowSelfHeal and object2:__wf_atom_bb81a9df() < healthPctToBegin then
		object:__wf_atom_f7170fc9(object2)
		__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v, v3)
		return 1
	else
		local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

		for _, v4 in ipairs(__wf_atom_694c2c5b) do
			if
				not (allowSelfHeal or v4 ~= object2)
				or (v4:IsKilled() or v4:__wf_atom_bedb4e3f())
				or not (v4:__wf_atom_bb81a9df() < healthPctToBegin)
			then
				continue
			end

			if not (v4:__wf_atom_9af7625d(object2) < distanceToTeammate * distanceToTeammate) then
				continue
			end

			local v5 = false

			for _, tag in ipairs(disallowedTags) do
				if not v4:HasTag(tag) then
					continue
				end

				v5 = true
				break
			end

			if v5 then
				continue
			end

			local visible = false

			if not __wf_atom_7e8ad928(v4:__wf_atom_30e3d82b()) then
				local __wf_atom_d8853f2a = v4:__wf_atom_30e3d82b():__wf_atom_d8853f2a()

				for i = 1, #__wf_atom_d8853f2a do
					if __wf_atom_d8853f2a[i].entity ~= __wf_atom_9a1e4ed3.entity then
						continue
					end

					visible = __wf_atom_d8853f2a[i].visible
					break
				end
			end

			if not (visible and (_T.OdeTeamHealActive == nil or not _T.OdeTeamHealActive[v4:__wf_atom_18aa6e58()])) then
				continue
			end

			object:__wf_atom_f7170fc9(v4)
			__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v, v3)
			return 1
		end

		return 0
	end
end

function ActivateAbility(p, object, object2, _)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	if object2 ~= object then
		object:__wf_atom_84d66e8e(__wf_atom_fa8d0177(object:GetPosition(), object2:GetPosition()))
	end

	object:Attach(
		healFxStartingHealOnCaster,
		healFxStartingHealOnCasterAttachBone,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		object
	)

	if
		not module.PlayAnimAndSuspendUntilEvent(p, startAnim, animEventToApplyHeal, false, 2, 1, false)
		or (__wf_atom_7e8ad928(object2) or object2:IsKilled())
	then
		return
	end

	if not __wf_atom_7e8ad928(healFxCastMovingDeco) then
		local entity = gRegion:CreateEntity(
			healFxCastMovingDeco,
			object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE4")),
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_045760db(object2, Symbol("GAME_C1_SPINE3"), castMovingFXTravelTime)
		end
	end

	object2:Attach(
		healFxStartingHealOnTeammate,
		healFxStartingHealOnTeammateAttachBone,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		object
	)
	Sleep(0)

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, object)
	end

	if object2 ~= object then
		object:__wf_atom_84d66e8e((__wf_atom_fa8d0177(object:GetPosition(), object2:GetPosition())))
	end

	if
		gRegion:IsMaster()
		and not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_bedb4e3f() or object2:IsKilled())
	then
		object2:Heal(object2, object2:GetMaxHealth() * healOnCastPctOfMaxHealth, object)
	end

	local v3 = gRegion:IsMaster() and 3 or 4

	if healTime > 0 and healPctOfMaxHealth > 0 and not __wf_atom_7e8ad928(buffingObject) then
		object2:Attach(buffingObject, buffingObjectAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, v3)
		object2:__wf_atom_8a035cd5(Symbol("HealOverTime"), false)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(startAnim) do
		Sleep(0)
	end
end

function HealOverTime(instance)
	local isMaster = gRegion:IsMaster()
	local healTime = healTime
	local v3 = 0
	local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(buffingObject)
	local creator = __wf_atom_bb3e7833:GetCreator()

	if __wf_atom_7e8ad928(instance) then
		print("TeamHeal.lua attached the buff on... nothing!")

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	elseif instance:IsA(__wf_atom_7e6ed5fa) then
		if __wf_atom_7e8ad928(creator) then
			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		else
			local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()

			if _T.OdeTeamHealActive == nil then
				_T.OdeTeamHealActive = {}
			end

			_T.OdeTeamHealActive[__wf_atom_18aa6e58] = true

			while
				not __wf_atom_7e8ad928(instance)
				and not instance:IsKilled()
				and not instance:__wf_atom_bedb4e3f()
				and healTime > 0
				and (not stopHealOnFullHealth or instance:__wf_atom_bb81a9df() < 1)
			do
				if isMaster then
					local maxHealth = instance:GetMaxHealth()
					v3 += healPctOfMaxHealth * maxHealth * __wf_atom_084b3e93()

					if v3 > 1 then
						local v4 = math.floor(v3)
						v3 -= v4
						instance:Heal(instance, v4, creator)
					end
				end

				healTime -= __wf_atom_084b3e93()
				Sleep(0)
			end

			if _T.OdeTeamHealActive ~= nil then
				_T.OdeTeamHealActive[__wf_atom_18aa6e58] = nil
			end

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	else
		print("TeamHeal.lua attached the buff on a non-avatar! " .. instance:__wf_atom_5b41f63b())

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function DeactivateAbility(_, object, object2, _)
	if
		not __wf_atom_7e8ad928(object2)
		and (healTime <= 0 or healPctOfMaxHealth <= 0)
		and _T.OdeTeamHealActive ~= nil
	then
		_T.OdeTeamHealActive[object2:__wf_atom_18aa6e58()] = nil
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v2)
		end
	end
end