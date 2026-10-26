local v = nil

local function fn(avatar) -- 1 equivalent call inferred from this helper
	local __wf_atom_4e50d390 = avatar:__wf_atom_4e50d390()
	__wf_atom_4e50d390.pitch = 0
	__wf_atom_4e50d390.bank = 0
	return __wf_atom_e97f3142(__wf_atom_4e50d390)
end

local function fn2(position, p, object) -- 1 equivalent call inferred from this helper
	local position2 = object:GetPosition()
	position2.y = position.y
	local v2 = position2 - position
	Normalize(v2)
	return __wf_atom_d08b2f29(p, v2) <= npcAllowableTargetFov
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local v2 = Time()

	if v2 - __wf_atom_30e3d82b:__wf_atom_6b8adb0a(npcCoordinatedCooldownIdentifier) < npcCoordinatedCooldown then
		return 0
	end

	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget >= npcMinRange and __wf_atom_9a1e4ed3.distanceToTarget <= npcMaxRange)
	then
		return 0
	end

	if npcAllowableTargetFov < 180 and __wf_atom_9a1e4ed3.avatar:__wf_atom_535d5cbb() then
		local v3 = fn(__wf_atom_9a1e4ed3.avatar) -- inferred equivalent call

		if not fn2(__wf_atom_9a1e4ed3.avatar:GetPosition(), v3, object2) then -- inferred equivalent call
			return 0
		end
	end

	object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
	__wf_atom_30e3d82b:__wf_atom_11d3ea0f(npcCoordinatedCooldownIdentifier, v2)
	return 1
end

local function fn3(object, __wf_atom_1c374cc9, __wf_atom_1c374cc9_2) -- 1 equivalent call inferred from this helper
	local v2 = Distance(__wf_atom_1c374cc9_2, __wf_atom_1c374cc9) / averagePredictedProjectileSpeed
	return __wf_atom_1c374cc9_2 + object:__wf_atom_278a2d05() * v2
end

function ActivateAbility(object, object2, object3, p)
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	object2:MotionControl():__wf_atom_3a1d0c16(__wf_atom_4e50d390)
	object2:MotionControl():__wf_atom_3959d938(true)
	object2:__wf_atom_8914dfde(
		animEventToWaitFor,
		object2:__wf_atom_9b5dcd3b(activateAnim, false, 4, 1, false, animRate)
	)

	if
		not __wf_atom_7e8ad928(activateAnim)
		and not __wf_atom_7e8ad928(animEventToWaitFor)
		and animEventToWaitFor ~= ""
		and not object2:__wf_atom_c138b19b(activateAnim)
	then
		return
	end

	local __wf_atom_74d951b0 = object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()

	if __wf_atom_7e8ad928(object3) then
		object3 = object2:__wf_atom_5d790fbf()
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Hand)

	if not __wf_atom_7e8ad928(object3) then
		__wf_atom_74d951b0 = fn3(object3, __wf_atom_1c374cc9, object3:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE1"))) -- inferred equivalent call
	end

	if not __wf_atom_7e8ad928(beamType) then
		local v2 = object2:Attach(beamType, Hand)

		if not __wf_atom_7e8ad928(v2) then
			v2:__wf_atom_a64eca67(__wf_atom_74d951b0)
			v2:__wf_atom_7fff6c98(Color(255, 0, 0, 0))
		end
	end

	local v2 = p <= 0 and 1 or p
	local v3 = #projTypes < v2 and #projTypes or v2
	v = projTypes[v3]
	local __wf_atom_2a745663 = object2:__wf_atom_d2b2176d():__wf_atom_2a745663(
		1,
		10,
		object:__wf_atom_1bb5b1ff(),
		object
	)
	local v4

	if calcAngle then
		v4 = Engine.__wf_atom_2e1382d1(__wf_atom_1c374cc9, __wf_atom_74d951b0, v, true)
	else
		v4 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_74d951b0)
	end

	local entity = gRegion:CreateEntity(v, __wf_atom_1c374cc9, v4, object2)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object2)
		entity:__wf_atom_c6dbdab6(object)
		entity:__wf_atom_c2d9fb01(__wf_atom_2a745663)
		object2:PlaySound(launchSound, false)

		if not __wf_atom_7e8ad928(object3) and setTarget then
			entity:SetTarget(object3)
		end
	end
end

function DeactivateAbility(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:MotionControl():__wf_atom_3959d938(false)
	end

	Sleep(0)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(nil, false)
	end
end