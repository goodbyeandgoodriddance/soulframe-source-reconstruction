local v = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v2 = Symbol("ReleaseProjectile")

function ProjectileChargeFinished(object, _)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish = nil
end

function MeleeEnd(object, _)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish) then
		for _, v3 in pairs(__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish) do
			if not __wf_atom_7e8ad928(v3) then
				v3:Die()
			end
		end
	end
end

function ReleaseProjectile(object, p)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) or __wf_atom_7e8ad928(projectileType) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(projectileSpawnBone)
	local __wf_atom_a06d543c = __wf_atom_6009c8ed:__wf_atom_a06d543c()

	if useCameraVectorPlayer and __wf_atom_6009c8ed:__wf_atom_a96eb2aa() then
		__wf_atom_a06d543c = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_74d951b0() - __wf_atom_1c374cc9
		Normalize(__wf_atom_a06d543c)
	end

	local v3 = __wf_atom_9341614d(__wf_atom_a06d543c, launchDirOffset)
	local v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, __wf_atom_a06d543c)

	if useBoneRotation then
		local __wf_atom_75a0566d = __wf_atom_21ed1a39:__wf_atom_75a0566d()
		local v5 = false

		if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
			local __wf_atom_fe33ffd0 = __wf_atom_75a0566d:__wf_atom_fe33ffd0()

			if not __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
				local __wf_atom_3b3a2be6 = __wf_atom_fe33ffd0:__wf_atom_3b3a2be6(v2, p)

				if __wf_atom_3b3a2be6 >= 0 then
					local __wf_atom_3ef82711 = __wf_atom_fe33ffd0:__wf_atom_3ef82711(__wf_atom_6009c8ed)
					v5 = __wf_atom_6009c8ed:__wf_atom_4c15ba90(
						projectileSpawnBone,
						__wf_atom_3ef82711,
						__wf_atom_3b3a2be6,
						v4
					)
				end
			end
		end

		if not v5 then
			v4 = __wf_atom_6009c8ed:__wf_atom_8e4cf043(projectileSpawnBone)
		end
	end

	local v5 = __wf_atom_1c374cc9 + __wf_atom_9341614d(spawnOffset, v4)
	local v6 = __wf_atom_d919c2d7(v4, initialRotationOffset)

	if alignLaunchAngle then
		v6.pitch = 0
		v6.heading = __wf_atom_6009c8ed:__wf_atom_dc309f8a().heading
	end

	local v7

	if
		addSeeking
		and not __wf_atom_7e8ad928(__wf_atom_6009c8ed:__wf_atom_5d790fbf())
		and __wf_atom_6009c8ed:__wf_atom_5d790fbf():IsA(__wf_atom_4ebf67cb)
	then
		v7 = __wf_atom_6009c8ed:__wf_atom_5d790fbf()

		if alignLaunchAngle then
			v6.heading = __wf_atom_fa8d0177(v5, v7:GetPosition()).heading
		end
	end

	local entity = gRegion:CreateEntity(projectileType, v5, v6, __wf_atom_21ed1a39, __wf_atom_21ed1a39)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(__wf_atom_6009c8ed)
		entity:__wf_atom_c6dbdab6(__wf_atom_21ed1a39)
		local __wf_atom_083a9e64 = __wf_atom_21ed1a39:__wf_atom_083a9e64()
		entity:__wf_atom_c35005f7(__wf_atom_083a9e64:__wf_atom_13497abe())
		__wf_atom_083a9e64:__wf_atom_95203424(entity)
		local v8 = v3 * entity:__wf_atom_510474d7()

		if alignLaunchAngle then
			v3.y = 0
		end

		entity:__wf_atom_53bcb18b(v8)

		if projectileLifeOverride > 0 then
			entity:__wf_atom_82343b4a(projectileLifeOverride)
		end

		if destroyWithoutChargeFinish then
			local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish) then
				__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish = {}
			end

			table.insert(__wf_atom_e919fb8e.ReleaseProjectilesWaitingForChargeFinish, entity)
			__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("DestroyProjectileOnAttackInterrupt"), false)
		end

		if not __wf_atom_7e8ad928(v7) then
			entity:SetTarget(v7)
		end

		if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
			__wf_atom_21ed1a39:ApplyEnergyColor(entity)
		end

		if setDamageFromWeapon then
			local __wf_atom_f792e63d = __wf_atom_21ed1a39:__wf_atom_010c2f81(0):__wf_atom_f792e63d()
			entity:__wf_atom_533c6916(__wf_atom_f792e63d.baseAmount * damagePct)
			entity:__wf_atom_350ac13e(__wf_atom_f792e63d.stabilityDamage * staggerDamagePct)
			entity:__wf_atom_ac3c846c(__wf_atom_f792e63d.baseAmount * explosiveDamagePct)
			entity:__wf_atom_00eb9325(__wf_atom_f792e63d.stabilityDamage * explosiveStaggerDamagePct)
			__wf_atom_21ed1a39:__wf_atom_7058a700(entity, (__wf_atom_083a9e64:__wf_atom_f9b5aca2()))
			entity:__wf_atom_9866bacc(31, true)
			local upgradedValue = Engine.UpgradedValue(0)
			upgradedValue:__wf_atom_fae96c2e(4, 0)
			entity:__wf_atom_7c5964b8(upgradedValue)
		end

		if groundOffsetHeight > 0 then
			entity:__wf_atom_8a035cd5(Symbol("HugTheGround"), false)
		end
	end
end

function HugTheGround(object)
	local v3 = Vector(0, 1, 0)
	local v4 = Vector(0, -10, 0)
	local __wf_atom_dcc5c1a1 = object:__wf_atom_dcc5c1a1()
	__wf_atom_dcc5c1a1.y = 0
	Normalize(__wf_atom_dcc5c1a1)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v5 = __wf_atom_10cd16b2(__wf_atom_a2a18137.y, 0.1)
	local v6 = false

	while true do
		local __wf_atom_a2a18137_2 = object:__wf_atom_a2a18137()
		local v7 = __wf_atom_084b3e93()

		if not v6 and v7 > 0 then
			local __wf_atom_dcc5c1a1_2 = object:__wf_atom_dcc5c1a1()
			local v8 = Length(__wf_atom_dcc5c1a1_2)

			if v8 == 0 then
				v8 = object:__wf_atom_510474d7()
			end

			local v9 = __wf_atom_a2a18137_2 + __wf_atom_dcc5c1a1 * v8 * v7 * 2
			local v10 = Vector()
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v9 + v3, v9 + v4, v, nil, v10)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			then
				local v11 = v10 + Vector(0, groundOffsetHeight, 0)
				v5:__wf_atom_09294a87(v11.y)
				v5:Update(v7)
				v11.y = v5:__wf_atom_9e368823()
				local v12 = v11 - __wf_atom_a2a18137_2
				Normalize(v12)
				object:__wf_atom_53bcb18b(v12 * v8)
			else
				__wf_atom_dcc5c1a1_2.y = 0
				Normalize(__wf_atom_dcc5c1a1_2)
				object:__wf_atom_53bcb18b(__wf_atom_dcc5c1a1_2 * v8)
			end
		end

		if v6 and v7 > 0 then
			if __wf_atom_a2a18137_2 - __wf_atom_a2a18137 ~= __wf_atom_28d5d4aa then
				local v8 = Vector()
				local v9 = __wf_atom_9341614d(Vector(0, 0.5, 0), object:__wf_atom_2f2bada0())
				local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(
					__wf_atom_a2a18137 + v9,
					__wf_atom_a2a18137_2 + v9,
					v,
					nil,
					v8
				)

				if __wf_atom_c20d246a and not __wf_atom_c20d246a:HasTag(Symbol("TreeDeco")) then
					break
				end
			end

			__wf_atom_a2a18137 = object:__wf_atom_a2a18137()
			v5:Update(v7)
		end

		Sleep(0)
		v6 = not v6
	end

	gRegion:__wf_atom_dd1e4d10(object)
end