local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("DamageFieldAbility")

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v2 = Time()
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if v2 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v) < npcCoordinatedCooldown then
		return 0
	end

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget > npcUseMinRange and __wf_atom_9a1e4ed3.distanceToTarget < npcUseRange)
	then
		return 0
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_be152500)
		or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
		or __wf_atom_be152500:GetState() ~= 0
	then
		return 0
	end

	__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v, v2)
	return 1
end

function ActivateAbility(object, object2, _, _)
	object2:__wf_atom_d2b2176d():AddUpgrade(101, 2, 0.75)
	object2:MotionControl():__wf_atom_99fc7a82(true)

	if object2:__wf_atom_535d5cbb() then
		object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())

		if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false) then
			return
		end
	else
		local v2 = object2:__wf_atom_9b5dcd3b(activateAnim, false, 2, 1, true, -1) * activateAnim:__wf_atom_091354f5(Symbol("Cast"))
		object2:MotionControl():__wf_atom_3959d938(true)
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		local flag = false

		while v2 > 0 do
			if object2:__wf_atom_c138b19b(activateAnim) then
				flag = true
			elseif flag then
				return
			end

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_929bb30b() then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local v3 = __wf_atom_fa8d0177(object2:GetPosition(), __wf_atom_216d6edd:GetPosition())
					object2:__wf_atom_51075230(v3)
					object2:__wf_atom_84d66e8e(v3)
				end
			end

			Sleep(0)
			v2 -= __wf_atom_084b3e93()
		end
	end

	if __wf_atom_7e8ad928(object2) then
		return
	end

	local v2 = object2:Attach(damageFieldDecoType, attachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)

	if __wf_atom_7e8ad928(v2) then
		return
	end

	v2:SetMeshScale(3)
	module.SetAbilityStats(object, mOwner, v2)
	local v3 = v2:Attach(damageElementType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_7ebba814(object2)
		v3:__wf_atom_34a8a27a(object)
		v3:__wf_atom_dce9850f(10 / duration)
		v3:Enable()
	end

	while duration > 0 do
		Sleep(0)
		duration -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(v2) then
		local entity = gRegion:CreateEntity(endingFx, v2:GetPosition(), __wf_atom_80368bb1, object2)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetMeshScale(3)
		end

		v2:PlayTriggeredFade()
	end

	object:__wf_atom_e8954328()
end

function DeactivateAbility(p, object, _, _)
	object:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, 0.75)
	object:MotionControl():__wf_atom_99fc7a82(false)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if not __wf_atom_7e8ad928(abilityStats) then
		abilityStats:Destroy()
	end
end