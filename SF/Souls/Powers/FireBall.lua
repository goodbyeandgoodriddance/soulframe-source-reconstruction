require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		return 0
	end

	if __wf_atom_9a1e4ed3.distanceToTarget >= 7.6 then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	end

	local position = __wf_atom_9a1e4ed3.avatar:GetPosition()
	local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()

	if position.y > __wf_atom_a2a18137.y and position.y - __wf_atom_a2a18137.y > 2 then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	end

	return 0
end

function StealWait(_)
	Sleep(15)

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:SetEnabled(false)
	end
end

function InitializeAbility(_, object)
	if object:__wf_atom_535d5cbb() then
		object:__wf_atom_8a035cd5(Symbol("StealWait"), false)
	end
end

function ActivateAbility(p, object, object2)
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	local v = Symbol("GAME_L1_ARM3")
	object:Attach(fireballCastFx, v, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)

	if object:__wf_atom_535d5cbb() then
		object:__wf_atom_1d50db01(subTree, 8, false)
		object:__wf_atom_e06358f3(Symbol("REQ_UPPERBODY_TREE"))
		object:__wf_atom_8914dfde("CastAbility", 1)
	else
		object:MotionControl():__wf_atom_3a1d0c16(object:__wf_atom_4e50d390())
		object:__wf_atom_9b5dcd3b(npcActivateAnim, false, 2, 1, true)
		object:__wf_atom_8914dfde(npcAnimEventToWaitFor, 1)
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(v)
	local __wf_atom_74d951b0 = object:__wf_atom_d2b2176d():__wf_atom_74d951b0()

	if not __wf_atom_7e8ad928(object2) then
		__wf_atom_74d951b0 = object2:__wf_atom_d0069154()
	end

	local entity = gRegion:CreateEntity(
		projType,
		__wf_atom_1c374cc9,
		__wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_74d951b0),
		object
	)
	gRegion:CreateEntity(fireballCastBurstFx, __wf_atom_1c374cc9, __wf_atom_4e50d390, p)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object)
		entity:__wf_atom_c6dbdab6(mOwner)

		if object:__wf_atom_8efce136() then
			entity:__wf_atom_533c6916(25)
			entity:__wf_atom_ac3c846c(25)
			entity:__wf_atom_e61acfb1(2)
		end

		entity:Attach(fireballAttachFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
	end
end

function DeactivateAbility(_, object)
	local v = Symbol("REQ_UPPERBODY_TREE")

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_7bcdbf55(v) do
		Sleep(0)
	end

	object:__wf_atom_1d50db01(nil, 8, false)
end

function OnHit(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and __wf_atom_7be51ede:__wf_atom_631bafa1() then
		local __wf_atom_eeff090c = object:__wf_atom_eeff090c()
		local v = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, __wf_atom_eeff090c)
		v.pitch += 90
		local v2 = object:__wf_atom_a2a18137() - __wf_atom_eeff090c * 0.25
		local entity = gRegion:CreateEntity(fireballHitDeco, v2, __wf_atom_80368bb1, __wf_atom_7be51ede)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetMeshScale(object:__wf_atom_cfe217b8() / 5)
		end
	end

	object:Die()
end