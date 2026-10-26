local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("MockeryTearsProjectileAbility")
local v2 = false

local function fn(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
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

function ActivateAbility(p, object, entity)
	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	if __wf_atom_7e8ad928(entity) then
		return
	end

	fn(object, true)
	local v3 = module.PlayAnim(p, introAnim, false, 4, 1, false)
	Sleep(v3)

	if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v4 = module.PlayAnim(p, loopAnim, false, 4, 1, false)
	local __wf_atom_b4c3edde = loopAnim:__wf_atom_b4c3edde(Symbol(castAnimEventSymbol))
	local count = 0
	local total = 0

	while count < __wf_atom_b4c3edde and not (v2 or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v5 = loopAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol), count) * v4 - total
		total += v5
		Sleep(v5)

		if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
			break
		end

		if gRegion:IsMaster() then
			local v6 = object:__wf_atom_1c374cc9(projectileSpawnBone) + Vector(
				Random(-0.25, 0.25),
				Random(1, 1.5),
				Random(-0.25, 0.25)
			)
			local __wf_atom_8e4cf043 = object:__wf_atom_8e4cf043(projectileSpawnBone)

			if not __wf_atom_7e8ad928(attachFX) then
				object:Attach(attachFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			local entity2 = gRegion:CreateEntity(
				projectileType,
				v6,
				__wf_atom_8e4cf043,
				__wf_atom_9fb9a1d6,
				__wf_atom_9fb9a1d6
			)

			if not __wf_atom_7e8ad928(entity2) then
				entity2:__wf_atom_8fcdea81(object)
				entity2:__wf_atom_c6dbdab6(__wf_atom_9fb9a1d6)
				local __wf_atom_083a9e64 = __wf_atom_9fb9a1d6:__wf_atom_083a9e64()
				entity2:__wf_atom_c35005f7(__wf_atom_083a9e64:__wf_atom_13497abe())
				__wf_atom_083a9e64:__wf_atom_95203424(entity2)
				entity2:__wf_atom_53bcb18b(Vector(Random(-0.2, 0.2), 1, Random(-0.2, 0.2)) * entity2:__wf_atom_510474d7())

				if not __wf_atom_7e8ad928(entity) then
					entity2:SetTarget(entity)
				end
			end
		end

		count += 1
	end

	if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v5 = v4 - loopAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol), count - 1) * v4
	Sleep(v5)

	if v2 or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v6 = module.PlayAnim(p, endAnim, false, 4, 1, false)
	Sleep(v6)
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
		v2 = true
	end
end