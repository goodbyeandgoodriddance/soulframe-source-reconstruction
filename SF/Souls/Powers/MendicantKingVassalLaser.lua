local v = Symbol("BlockingBehavior")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

local function fn(object, object2) -- 1 equivalent call inferred from this helper
	if not __wf_atom_7e8ad928(object2) and turnViaAnimAdjustmentEvent then
		local position = object:GetPosition()
		local v2 = __wf_atom_fa8d0177(position, object2:GetPosition())
		v2.pitch = 0
		v2.bank = 0
		object:__wf_atom_3c986cd9(position, v2)
	end
end

function ActivateAbility(p, object, object2, _)
	if not gRegion:IsMaster() then
		return
	end

	if repeatFireCount < 1 then
		repeatFireCount = 1
	end

	if not blockingAnimations then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object)
		end
	end

	for i = 1, repeatFireCount do
		fn(object, object2) -- inferred equivalent call

		if i == 1 then
			object:__wf_atom_921c1a5f(startingAnim, false, 3, 3, blockingAnimations)
		elseif i == repeatFireCount then
			object:__wf_atom_921c1a5f(endAnim, false, 3, 1, blockingAnimations)
		else
			object:__wf_atom_921c1a5f(loopingAttackAnim, false, 3, 3, blockingAnimations)
		end

		local v2

		if not __wf_atom_7e8ad928(warningLaser) then
			if startOfWarningAnimEvent ~= "" then
				object:__wf_atom_8914dfde(startOfWarningAnimEvent, 6)
			end

			v2 = object:Attach(
				warningLaser,
				warningLaserAttachBone,
				warningLaserAttachOffset,
				warningLaserAttachRotation,
				object,
				1
			)

			if not __wf_atom_7e8ad928(v2) then
				object:PlaySound(chargeSound, false)
				v2:__wf_atom_341daa34(object2, 0)
			end
		end

		if startOfLaseringAnimEvent ~= "" then
			object:__wf_atom_8914dfde(startOfLaseringAnimEvent, 6)
		end

		local position, v3

		if __wf_atom_7e8ad928(v2) then
			position = object:__wf_atom_1c374cc9(warningLaserAttachBone) + warningLaserAttachOffset

			if __wf_atom_7e8ad928(object2) then
				v3 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, object:__wf_atom_a06d543c())
			else
				v3 = __wf_atom_fa8d0177(position, object2:__wf_atom_7470861b():__wf_atom_96c119f5(0))
			end
		else
			v2:__wf_atom_341daa34(nil, 0)
			position = v2:GetPosition()
			v3 = __wf_atom_fa8d0177(position, v2:__wf_atom_fdf659dc())
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end

		local entity = gRegion:CreateEntity(projectileType, position, v3, object)
		object:PlaySound(projectileLaunchSound, false)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(p)
		end

		Sleep(0)

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(startingAnim, false) do
			Sleep(0)
		end

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(loopingAttackAnim, false) do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end

		if __wf_atom_7e8ad928(object2) then
			break
		end

		local __wf_atom_8a6b8fc3 = object2:__wf_atom_8a6b8fc3(object)

		if npcUseRange.maxValue < __wf_atom_8a6b8fc3 or __wf_atom_8a6b8fc3 < npcUseRange.minValue then
			break
		end
	end
end

function DeactivateAbility(_, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not blockingAnimations then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	end

	if not __wf_atom_7e8ad928(startingAnim) and object:__wf_atom_c138b19b(startingAnim, true) then
		object:__wf_atom_921c1a5f(nil, false, 2, 1, false)
	end

	if not __wf_atom_7e8ad928(loopingAttackAnim) and object:__wf_atom_c138b19b(loopingAttackAnim, true) then
		object:__wf_atom_921c1a5f(nil, false, 2, 1, false)
	end

	if not __wf_atom_7e8ad928(warningLaser) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(warningLaser)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function ManageProjectile(instance)
	Sleep(0)
	local creator = instance:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		instance:Destroy()
		return
	end

	local __wf_atom_e55d02aa = creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if startOfLaseringAnimEvent ~= "" then
		creator:__wf_atom_8914dfde(startOfLaseringAnimEvent, 6)
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	if gRegion:IsMaster() then
		instance:__wf_atom_341daa34(nil, 0)
	end

	local position = instance:GetPosition()
	local v2 = __wf_atom_fa8d0177(position, instance:__wf_atom_fdf659dc())

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end

	local entity = gRegion:CreateEntity(projectileType, position, v2, creator)
	creator:PlaySound(projectileLaunchSound, false)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(creator)
		entity:__wf_atom_c6dbdab6(__wf_atom_e55d02aa)
	end

	while not __wf_atom_7e8ad928(entity) do
		Sleep(0)
	end
end