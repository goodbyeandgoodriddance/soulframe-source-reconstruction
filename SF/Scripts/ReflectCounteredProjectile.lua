local v = { 0, 1, 2, 3, 4, 5 }

local function fn(p, __wf_atom_e5d0bedf, p2, _, instance, p3, instance2, p4)
	local entity = gRegion:CreateEntity(p, __wf_atom_e5d0bedf, p2, instance, nil, ObjectType_RM_REPLICATED)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	if not __wf_atom_7e8ad928(reflectedSound) then
		instance:PlaySound(reflectedSound, false)
	end

	if not __wf_atom_7e8ad928(reflectedVfxType) then
		gRegion:CreateEntity(p, __wf_atom_e5d0bedf, p2, instance)
	end

	local __wf_atom_ae4f866b = entity:__wf_atom_ae4f866b(true, true, instance2, p3)
	local v2 = entity:__wf_atom_4f93fb7b() * reflectedProjectileDamageMultiplier

	if instance:__wf_atom_4417a5d4() then
		entity:__wf_atom_8fcdea81(instance)
	end

	entity:__wf_atom_7ebba814(instance)
	entity:SetInRift(instance2:__wf_atom_dc88744c())
	entity:__wf_atom_533c6916(__wf_atom_ae4f866b)
	entity:__wf_atom_c2d9fb01(v2)
	entity:SetTarget(instance2)

	if Random(0, 1) < reflectedProjectileProcChance then
		entity:__wf_atom_9866bacc(reflectedProjectileProc, true)
	end

	if instance2:__wf_atom_ee4f0cba() >= 0.0125 then
		local __wf_atom_278a2d05 = instance2:__wf_atom_278a2d05()
		local __wf_atom_510474d7 = entity:__wf_atom_510474d7()
		local v3 = p4 + __wf_atom_278a2d05 * (Distance(__wf_atom_e5d0bedf, p4) / __wf_atom_510474d7)
		local v4 = __wf_atom_fa8d0177(__wf_atom_e5d0bedf, v3)
		local v5 = v3 - __wf_atom_e5d0bedf
		Normalize(v5)
		entity:__wf_atom_53bcb18b(v5 * __wf_atom_510474d7)
		entity:__wf_atom_9b788a35(v4)
	end
end

function ReflectCounteredProjectile(p, instance, instance2, object)
	if
		__wf_atom_7e8ad928(p)
		or __wf_atom_7e8ad928(instance)
		or not instance:IsA(__wf_atom_7e6ed5fa)
		or __wf_atom_7e8ad928(instance2)
		or not instance2:IsA(__wf_atom_7e6ed5fa)
		or __wf_atom_7e8ad928(object)
		or instance:__wf_atom_8c3af1a5(instance2:__wf_atom_e93896ba())
	then
		return
	end

	local __wf_atom_3371f607 = object:__wf_atom_3371f607()
	local v2 = nil

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_483e7ddc = object:__wf_atom_483e7ddc()

		if not __wf_atom_7e8ad928(__wf_atom_483e7ddc) then
			__wf_atom_3371f607 = __wf_atom_483e7ddc:__wf_atom_3371f607()
		end

		if __wf_atom_7e8ad928(__wf_atom_3371f607) then
			local __wf_atom_c98157ce = object:__wf_atom_c98157ce()

			if not __wf_atom_7e8ad928(__wf_atom_c98157ce) then
				v2 = Type(__wf_atom_c98157ce:__wf_atom_5b41f63b())
			end
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_7e8ad928(v2) then
		return
	end

	if not (__wf_atom_7e8ad928(__wf_atom_3371f607) or __wf_atom_3371f607:IsA(__wf_atom_2fc5c2e8) or __wf_atom_3371f607:IsA(__wf_atom_baf9587d)) then
		return
	end

	local __wf_atom_7470861b = instance2:__wf_atom_7470861b()

	if __wf_atom_7e8ad928(__wf_atom_7470861b) then
		return
	end

	local __wf_atom_e5d0bedf = object:__wf_atom_e5d0bedf()
	local v3 = __wf_atom_edfe0d73(Vector(0, 1, 0), instance:__wf_atom_a06d543c()) * Random(-0.1, 0.1)
	local v4 = Vector(0, Random(-0.125, 0.125), 0)
	local v5 = __wf_atom_7470861b:__wf_atom_96c119f5(v[__wf_atom_5784a397(1, 6)]) + v3 + v4
	local v6 = __wf_atom_fa8d0177(__wf_atom_e5d0bedf, v5)

	if not __wf_atom_7e8ad928(v2) and v2:IsA(__wf_atom_baf9587d) then
		fn(v2, __wf_atom_e5d0bedf, v6, p, instance, p, instance2, v5)
	elseif __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_2fc5c2e8) then
		if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_baf9587d) then
			local __wf_atom_e14d8a8c = __wf_atom_3371f607:__wf_atom_e14d8a8c()

			if __wf_atom_7e8ad928(__wf_atom_e14d8a8c) then
				return
			else
				fn(__wf_atom_e14d8a8c, __wf_atom_e5d0bedf, v6, p, instance, p, instance2, v5)
			end
		end
	else
		local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(object:__wf_atom_dc52498d())

		if __wf_atom_7e8ad928(__wf_atom_3d08948b) or not __wf_atom_3d08948b:IsA(__wf_atom_ed85f483) then
			return
		end

		local chargedProjectileType = __wf_atom_3d08948b.chargedProjectileType

		if __wf_atom_7e8ad928(chargedProjectileType) then
			chargedProjectileType = __wf_atom_3d08948b.projectileType

			if __wf_atom_7e8ad928(chargedProjectileType) then
				return
			end
		end

		fn(chargedProjectileType, __wf_atom_e5d0bedf, v6, p, instance, __wf_atom_3371f607, instance2, v5)
	end
end