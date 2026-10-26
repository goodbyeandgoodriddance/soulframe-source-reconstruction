local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("MockeryExpandingAOEAbility")
local flag = false

local function fn(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(19, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(17, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(18, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
		object:__wf_atom_994cbb44(2, v)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(19, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(17, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(18, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, v)
		object:__wf_atom_d61b16cd(2, v)
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if
		__wf_atom_9a1e4ed3.visible
		and __wf_atom_9a1e4ed3:__wf_atom_a3309443()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	else
		return 0
	end
end

function InitializeAbility(_, _) end

function ActivateAbility(p, object, _)
	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	fn(object, true)
	local v2 = module.PlayAnim(p, introAnim, false, 4, 1, false)
	local v3 = introAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol)) * v2

	if flag then
		return
	end

	if __wf_atom_7e8ad928(preShockwaveFX) then
		Sleep(v3)
	else
		Sleep(v3 - preShockwaveDelayTime)

		if not (flag or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
			object:__wf_atom_8a035cd5(Symbol("HandlePreShockwaveVFX"), false)
			Sleep(preShockwaveDelayTime)
		end
	end

	if flag or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	gRegion:CreateEntity(
		shockwaveType,
		object:__wf_atom_1c374cc9(shockwaveSpawnBone) + spawnOffset,
		object:__wf_atom_dc309f8a(),
		object,
		object
	)
	Sleep(v2 - v3)
	local v4 = module.PlayAnim(p, loopAnim, false, 4, 1, false)
	local __wf_atom_b4c3edde = loopAnim:__wf_atom_b4c3edde(Symbol(castAnimEventSymbol))
	local count = 0
	local total = 0

	while count < __wf_atom_b4c3edde and not (flag or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v5 = loopAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol), count) * v4 - total
		total += v5

		if __wf_atom_7e8ad928(preShockwaveFX) then
			Sleep(v5)
		else
			Sleep(v5 - preShockwaveDelayTime)

			if flag or object:IsKilled() or object:__wf_atom_bedb4e3f() then
				break
			end

			object:__wf_atom_8a035cd5(Symbol("HandlePreShockwaveVFX"), false)
			Sleep(preShockwaveDelayTime)
		end

		if flag or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			break
		end

		if gRegion:IsMaster() then
			gRegion:CreateEntity(
				shockwaveType,
				object:__wf_atom_1c374cc9(shockwaveSpawnBone) + spawnOffset,
				object:__wf_atom_dc309f8a(),
				object,
				object
			)
		end

		count += 1
	end

	if flag or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v5 = v4 - loopAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol), count - 1) * v4
	Sleep(v5)

	if flag or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v6 = module.PlayAnim(p, endAnim, false, 4, 1, false)
	Sleep(v6)
end

function HandlePreShockwaveVFX(object)
	local entity = gRegion:CreateEntity(
		preShockwaveFX,
		object:__wf_atom_1c374cc9(shockwaveSpawnBone) + spawnOffset,
		object:__wf_atom_dc309f8a(),
		object,
		object
	)

	if preShockwaveFXLifetime > 0 then
		Sleep(preShockwaveFXLifetime)

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end
	end
end

function DeactivateAbility(_, p, _)
	fn(p, false)
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_7e8ad928(__wf_atom_9d766292) then
		return
	end

	if
		__wf_atom_9d766292:__wf_atom_78650070(19)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(18)
	then
		flag = true
	end
end