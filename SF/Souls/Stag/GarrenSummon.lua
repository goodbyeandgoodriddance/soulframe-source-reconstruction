local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 30
local v2 = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")

function NpcEvaluateAbility(_, _)
	return 0
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function PulseFX(_) end

function PulseDownFX(p)
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	local v3 = 0

	while v3 < 1 and not __wf_atom_7e8ad928(p) do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 2, 0, 1)
		postProcessBias:__wf_atom_2bd5152a(0, 0, 0, (1 - v3) * 2)
		Sleep(0)
	end
end

function RadialHit(p, instance)
	if instance:IsMaster() and instance:IsA(__wf_atom_4ebf67cb) and not instance:__wf_atom_4402f880(p) then
		if not _T.FeyHitEntities then
			_T.FeyHitEntities = {}
		end

		table.insert(_T.FeyHitEntities, instance)
		instance:__wf_atom_986f733d(Symbol("FeyHit"), 0.5)
	end
end

function ClearRadialHits(p)
	Sleep(3)
	__wf_atom_7e8ad928(p)

	if _T.FeyHitEntities then
		for i = 1, #_T.FeyHitEntities do
			local feyHitEntity = _T.FeyHitEntities[i]

			if not __wf_atom_7e8ad928(feyHitEntity) then
				feyHitEntity:__wf_atom_558ce619(Symbol("FeyHit"))
			end
		end
	end
end

function ActivateAbility(object, object2, _, _)
	if
		__wf_atom_7e8ad928(object2)
		or object2:IsKilled()
		or not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false)
	then
		return
	end

	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.stabilityDamage = 100
	radialDamageData.radius = 8
	radialDamageData:__wf_atom_6b472125(object2)
	radialDamageData:__wf_atom_34a8a27a(object)
	radialDamageData:__wf_atom_98d98d81(object2:__wf_atom_d0069154())
	radialDamageData:__wf_atom_12cf5317(400)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData.hitType = 3
	radialDamageData:__wf_atom_a8149853(Symbol("RadialHit"))
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	object2:Attach(aoeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local entity = gRegion:CreateEntity(aoeRadiusDecoType, radialDamageData:__wf_atom_e5d0bedf(), __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(radialDamageData.radius)
	end

	object:__wf_atom_6a4cf64f()

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_8a035cd5(Symbol("PulseFX"), false)
		object2:__wf_atom_8a035cd5(Symbol("ClearRadialHits"), false)
	end

	local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	local v3 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, __wf_atom_a06d543c)

	if not __wf_atom_7e8ad928(activateStartAnim) then
		local __wf_atom_df9e931d = activateStartAnim:__wf_atom_df9e931d(Symbol("GAME_C1_ROOT"), 1)
		local v4 = __wf_atom_9341614d(__wf_atom_df9e931d, v3)
		local v5 = {
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce,
			__wf_atom_d0a48db7,
			WeakResource("/EE/Types/Engine/SimpleBlockingVolume")
		}
		local v6 = __wf_atom_a2a18137 + v4 + Vector(0, 4, 0)
		local v7 = v6 - Vector(0, 20, 0)
		local v8 = Vector()
		local v9 = Vector()

		if __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(v6 + __wf_atom_a06d543c, v7 + __wf_atom_a06d543c, v5, nil, v8)) then
			v8 = v7 + __wf_atom_a06d543c
		end

		if __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(v6 - __wf_atom_a06d543c, v7 - __wf_atom_a06d543c, v5, nil, v9)) then
			v9 = v7 - __wf_atom_a06d543c
		end

		v3.pitch = __wf_atom_421b01aa(__wf_atom_fa8d0177(v9, v8).pitch, -40, 40)
		__wf_atom_a2a18137 = (v9 + v8) / 2 - __wf_atom_9341614d(__wf_atom_df9e931d, v3)
	end

	local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(stagDecoType, __wf_atom_a2a18137, v3)
	__wf_atom_7ccf4243:__wf_atom_921c1a5f(activateStartAnim, false, false, 0)
	local v4 = { allies = {}, enemies = {}, damage = 0 }
	module.SetAbilityStats(object, mOwner, v4)
	local v5 = Symbol(mOwner:__wf_atom_37768748():c_str() .. object2:__wf_atom_18aa6e58())
	local isMaster = gRegion:IsMaster()
	local v6 = Symbol("OnMeleeKill")
	local __wf_atom_1bb5b1ff = object:__wf_atom_1bb5b1ff()
	local v7 = Symbol("FASTFEAR")
	local v8 = 0
	local v9 = 0

	while not object2:IsKilled() and (object:__wf_atom_f3044fe0() > 0 or module.InfiniteEnergy()) do
		if isMaster then
			if v8 <= 0 then
				local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

				for k, v10 in pairs(_T.EnabledShrine) do
					if __wf_atom_7e8ad928(v10) or not (v10:__wf_atom_d5fda8be(__wf_atom_a2a18137) <= 50) then
						continue
					end

					for _, v11 in ipairs(__wf_atom_3c8e1a7a) do
						if v11:__wf_atom_ef151cfd() ~= k then
							continue
						end

						local playerAvatar = v11:GetPlayerAvatar(10)

						if not __wf_atom_7e8ad928(playerAvatar) then
							playerAvatar:__wf_atom_a1b79f95():ExecuteAction(v10)
						end
					end
				end

				local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, 50)
				local allies = {}
				local enemies = {}

				for _, v10 in ipairs(all) do
					if v10:IsA(v2) then
						continue
					end

					local __wf_atom_18aa6e58 = v10:__wf_atom_18aa6e58()

					if v10:__wf_atom_4402f880(object2) then
						if v10:__wf_atom_bedb4e3f() then
							v10:InstantRevive()
						end

						allies[__wf_atom_18aa6e58] = v10

						if v4.allies[__wf_atom_18aa6e58] then
							v4.allies[__wf_atom_18aa6e58] = nil
						else
							local __wf_atom_e55d02aa = v10:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

							if
								not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
								and __wf_atom_e55d02aa:IsA(__wf_atom_1bb5b1ff)
							then
								__wf_atom_e55d02aa:__wf_atom_d3eff879(mOwner, v6)
							end

							v10:__wf_atom_d2b2176d():AddUpgrade(366, 0, 100, __wf_atom_77e05d3b)
							v10:Attach(damageBuffFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
						end
					else
						enemies[__wf_atom_18aa6e58] = v10

						if v4.enemies[__wf_atom_18aa6e58] then
							v4.enemies[__wf_atom_18aa6e58] = nil
						else
							v10:__wf_atom_51cd6126(v5, "OnDamaged")
						end
					end
				end

				for _, ally in pairs(v4.allies) do
					if __wf_atom_7e8ad928(ally) then
						continue
					end

					local __wf_atom_e55d02aa = ally:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

					if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
						__wf_atom_e55d02aa:__wf_atom_2a5bca4a(mOwner, v6)
					end

					ally:__wf_atom_d2b2176d():RemoveUpgrade(366, 0, 100, __wf_atom_77e05d3b)
					local __wf_atom_bb3e7833 = ally:__wf_atom_bb3e7833(damageBuffFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end

				for _, enemy in pairs(v4.enemies) do
					if not __wf_atom_7e8ad928(enemy) then
						enemy:__wf_atom_3ede53b4(v5)
					end
				end

				v4.allies = allies
				v4.enemies = enemies
				v8 = 0.25
			end

			if v4.damage > 0 then
				local v10 = math.floor(v4.damage * 0.5)

				if v10 > 0 then
					v4.damage -= v10 / 0.5

					for _, ally in pairs(v4.allies) do
						if __wf_atom_7e8ad928(ally) or ally:IsKilled() then
							continue
						end

						ally:Heal(ally, v10, object2)
						ally:Attach(healFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					end
				end
			end
		end

		if v9 < 0 then
			for _, enemy in pairs(v4.enemies) do
				if __wf_atom_7e8ad928(enemy) then
					continue
				end

				local __wf_atom_8a6b8fc3 = enemy:__wf_atom_8a6b8fc3(__wf_atom_7ccf4243)
				local v10 = 50 / __wf_atom_8a6b8fc3
				local v11 = Random(1, 10)

				if __wf_atom_8a6b8fc3 <= 5 and not enemy:__wf_atom_fc8d8e90(v7) then
					enemy:__wf_atom_58c8ffec(v7, false, 4, 1, true, __wf_atom_5784a397(0, 2))
				elseif v11 < v10 and not enemy:__wf_atom_fc8d8e90(v7) then
					enemy:__wf_atom_58c8ffec(v7, false, 4, 1, true, __wf_atom_5784a397(0, 2))
				end
			end

			v9 = 2
		end

		Sleep(0)
		v -= __wf_atom_084b3e93()
		v8 -= __wf_atom_084b3e93()
		v9 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
		__wf_atom_7ccf4243:PlayTriggeredFade()
		__wf_atom_7ccf4243:__wf_atom_921c1a5f(deActivateStartAnim, false, false, 0)
	end
end

function DeactivateAbility(p, object, _, _)
	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_8a035cd5(Symbol("PulseDownFX"), false)
	end

	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if abilityStats then
		local v3 = Symbol(mOwner:__wf_atom_37768748():c_str() .. object:__wf_atom_18aa6e58())
		local v4 = Symbol("OnMeleeKill")

		for _, ally in pairs(abilityStats.allies) do
			if __wf_atom_7e8ad928(ally) then
				continue
			end

			local __wf_atom_e55d02aa = ally:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:__wf_atom_2a5bca4a(mOwner, v4)
			end

			ally:__wf_atom_d2b2176d():RemoveUpgrade(366, 0, 100, __wf_atom_77e05d3b)
			local __wf_atom_bb3e7833 = ally:__wf_atom_bb3e7833(damageBuffFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		for _, enemy in pairs(abilityStats.enemies) do
			if not __wf_atom_7e8ad928(enemy) then
				enemy:__wf_atom_3ede53b4(v3)
			end
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) == 0 then
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 0)
	end
end

function OnDamaged(object)
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()
	local abilityStats = module.GetAbilityStats(__wf_atom_c78fa517, mOwner)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()
	object:Attach(damageFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	abilityStats.damage += __wf_atom_9d766292:__wf_atom_9232afe2()
end

function OnMeleeKill(_, _, _, object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()

	if __wf_atom_7e8ad928(__wf_atom_c78fa517) then
		return
	end

	local abilityStats = module.GetAbilityStats(__wf_atom_c78fa517, mOwner)

	if abilityStats and abilityStats.enemies[object:__wf_atom_18aa6e58()] then
	end
end