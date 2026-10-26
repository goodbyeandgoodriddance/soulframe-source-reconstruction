local v = false
local v2 = WeakResource("/SF/Types/Player/EnvoyAvatar")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()

	for i = 1, #__wf_atom_d8853f2a do
		local v3 = __wf_atom_d8853f2a[i]

		if not v3.visible or (__wf_atom_7e8ad928(v3.avatar) or v3.avatar:__wf_atom_bedb4e3f()) then
			continue
		end

		local distanceToTarget = v3.distanceToTarget

		if not (minTargetDistance <= distanceToTarget and distanceToTarget <= maxTargetDistance and v3.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		object:__wf_atom_f7170fc9(v3.avatar)
		return 1
	end

	return 0
end

local function fn(entity, object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(entity) then
		return
	end

	local v3 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), entity:__wf_atom_a2a18137())
	v3.pitch = 0
	v3.bank = 0
	return v3
end

function ActivateAbility(p, object, entity)
	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	local v3 = 1
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_0e1e5bc9 = object:__wf_atom_0e1e5bc9()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(npcActivateAnim, false, 2, 1, false)
	local v4 = npcActivateAnim:__wf_atom_091354f5(Symbol(castingAnimEvent)) * __wf_atom_9b5dcd3b
	object:Attach(bellowCastFx, launchBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
	local total = 0

	while total < v4 do
		if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(entity)) then
			local v5 = fn(entity, object) -- inferred equivalent call
			local v6 = __wf_atom_9d2f097a(__wf_atom_0e1e5bc9, v5, total / v4)
			object:__wf_atom_51075230(v6)
			object:__wf_atom_84d66e8e(v6)
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	while object:__wf_atom_c138b19b(npcActivateAnim) do
		if v3 < maxshots then
			object:__wf_atom_8914dfde(fireProjectileAnimEvent, 4)
			LaunchProjectile(p, object, entity)
			v3 += 1
		end

		Sleep(0)
	end
end

function LaunchProjectile(p, object, _)
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(headBone)
	local __wf_atom_1c374cc9_2 = object:__wf_atom_1c374cc9(launchBone)
	local v3 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9_2)
	object:Attach(bellowFireFX, launchBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
	local v4

	if canUseAltProjectile and v == true then
		v4 = gRegion:CreateEntity(altProjType, __wf_atom_1c374cc9_2, v3, object)
		v = not v
	elseif canUseAltProjectile and v == false then
		v4 = gRegion:CreateEntity(projType, __wf_atom_1c374cc9_2, v3, object)
		v = not v
	else
		v4 = gRegion:CreateEntity(projType, __wf_atom_1c374cc9_2, v3, object)
	end

	gRegion:CreateEntity(bellowCastBurstFx, __wf_atom_1c374cc9_2, __wf_atom_4e50d390, p)

	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_8fcdea81(object)
		v4:__wf_atom_c6dbdab6(mOwner)
	end
end

function OnHit(object, instance)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return
	end

	if instance:IsA(v2) then
		object:Die()
	end
end

function OnDeath(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local entity = gRegion:CreateEntity(
		bellowDeathDeco,
		object:__wf_atom_a2a18137(),
		object:__wf_atom_2f2bada0(),
		object:__wf_atom_7be51ede()
	)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(object:__wf_atom_cfe217b8() / 5)
	end
end