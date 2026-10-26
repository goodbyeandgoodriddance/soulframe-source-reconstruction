local v = Symbol("WazzardArtilleryImmunity")
local v2 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v3 = Symbol("BlockingBehavior")

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and distanceFromTarget:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

function ActivateAbility(p, object, object2, _, _)
	local position = object:GetPosition()
	_T.WazardTreeAbilityActivated = true

	if gRegion:IsMaster() and not blockingAnimations then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v3, object)
		end
	end

	local v4 = Vector()
	local v5 = object:GetPosition() + Vector(0, 0.1, 0)
	local v6 = v5 + Vector(0, -5, 0)
	local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v5, v6, v2, nil, v4)
	local v7

	if __wf_atom_c20d246a then
		v7 = gRegion:CreateEntity(
			treePushTrigger,
			v4 + treePushTriggerOffset,
			object:__wf_atom_dc309f8a(),
			object,
			object
		)
	else
		v7 = gRegion:CreateEntity(
			treePushTrigger,
			object:GetPosition() + treePushTriggerOffset,
			object:__wf_atom_dc309f8a(),
			object,
			object
		)
	end

	object:__wf_atom_8d98f2fc(false, false, false)

	if blockingAnimations then
		object:__wf_atom_8914dfde(
			activateAnimDisappearEvent,
			object:__wf_atom_9b5dcd3b(activateAnim, false, 3, 1, true)
		)
	elseif not module.PlayAnimAndSuspendUntilEvent(p, activateAnim, activateAnimDisappearEvent, false, 2, 1, false) then
		return
	end

	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()

	if not __wf_atom_7e8ad928(object2) then
		__wf_atom_dc309f8a = __wf_atom_fa8d0177(position, object2:GetPosition())
	end

	__wf_atom_dc309f8a.pitch = 0
	__wf_atom_dc309f8a.bank = 0
	gRegion:CreateEntity(disappearingFx, position, __wf_atom_dc309f8a)
	local v8

	if __wf_atom_c20d246a then
		if gRegion:IsMaster() then
			v8 = gRegion:CreateEntity(treeTransformDeco, v4, __wf_atom_dc309f8a, object, object, 3)
		else
			v8 = gRegion:CreateEntity(treeTransformDeco, v4, __wf_atom_dc309f8a, object, object, 4)
		end
	elseif gRegion:IsMaster() then
		v8 = gRegion:CreateEntity(treeTransformDeco, object:GetPosition(), __wf_atom_dc309f8a, object, object, 3)
	else
		v8 = gRegion:CreateEntity(treeTransformDeco, object:GetPosition(), __wf_atom_dc309f8a, object, object, 4)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	if gRegion:IsMaster() then
		object:__wf_atom_dd875cd8(true)
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v, 26, 6, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(v)
	end

	object:Attach(polymorphTreeAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:SetVisibility(false, true)
	Sleep(attackTimeAfterDisappearing)

	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(_T.WazzardArtilleryAttackTargets) then
			_T.WazzardArtilleryAttackTargets = {}
		end

		_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()] = {}

		if not __wf_atom_7e8ad928(targetFxType) then
			local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

				for i = 1, #__wf_atom_ef7900cf do
					if not (__wf_atom_ef7900cf[i]:__wf_atom_9af7625d(object) < distanceFromTarget.maxValue * distanceFromTarget.maxValue) then
						continue
					end

					table.insert(_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()], __wf_atom_ef7900cf[i])
					__wf_atom_ef7900cf[i]:Attach(
						targetFxType,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1,
						object
					)
				end

				local __wf_atom_d8853f2a = __wf_atom_30e3d82b:__wf_atom_d8853f2a()

				for i = 1, #__wf_atom_d8853f2a do
					if __wf_atom_7e8ad928(__wf_atom_d8853f2a[i].avatar) then
						continue
					end

					local v9 = false

					for j = 1, #_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()] do
						if _T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()][j] ~= __wf_atom_d8853f2a[i].avatar then
							continue
						end

						v9 = true
						break
					end

					if v9 then
						continue
					end

					table.insert(
						_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()],
						__wf_atom_d8853f2a[i].avatar
					)
					__wf_atom_d8853f2a[i].avatar:Attach(
						targetFxType,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1,
						object
					)
				end
			end
		end
	end

	Sleep(attackChargingTime)

	if gRegion:IsMaster() then
		object:__wf_atom_8a035cd5(Symbol("BombArea"), false)
	end

	local v9

	if gRegion:IsMaster() then
		v9 = gRegion:CreateEntity(returnPositionWarningFx, position, object:__wf_atom_dc309f8a(), object, object, 1)
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Destroy()
	end

	Sleep(attackLastingDuration)
	Sleep(timeAfterAttackingEndingToReappear)
	local v10

	if __wf_atom_7e8ad928(object2) then
		v10 = object:__wf_atom_dc309f8a()
	else
		v10 = __wf_atom_fa8d0177(position, object2:GetPosition())
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:PlayTriggeredFade()
	end

	gRegion:CreateEntity(reappearingFx, position, v10, object, object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(reappearRadialDamage))
	radialDamageData.stabilityDamage = reappearRadialStabilityDamage
	radialDamageData.radius = reappearRadialDamageRadius
	radialDamageData.fallOff = reappearRadialDamageFalloff
	radialDamageData.staticCoverOnly = true
	radialDamageData:__wf_atom_7498285f(explodeDamageType, 1)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_d2b2176d:__wf_atom_e55d02aa())
	radialDamageData:__wf_atom_98d98d81(position)
	radialDamageData.hostAuthoritative = false
	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if gRegion:IsMaster() then
		object:Teleport(position, v10)
	end

	if gRegion:IsMaster() then
		object:Attach(polymorphWazardAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, 3)
	end

	object:SetVisibility(true, true)

	if gRegion:IsMaster() then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9f17ac89(v)
		__wf_atom_7470861b:__wf_atom_63396172(v)
		object:__wf_atom_dd875cd8(false)
		object:__wf_atom_3c986cd9(position, v10)
		object:__wf_atom_8d98f2fc(true, true, true)
		object:__wf_atom_921c1a5f(reappearingAnimation, true, 3, 1, blockingAnimations)
	end
end

function DeactivateAbility(_, object, _, _)
	object:__wf_atom_8d98f2fc(true, true, true)

	if not (__wf_atom_7e8ad928(_T.WazzardArtilleryAttackTargets) or __wf_atom_7e8ad928(_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()])) then
		_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()] = {}
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() then
		if not object:__wf_atom_c138b19b(reappearingAnimation, true) then
			object:__wf_atom_2f91774e()
		end

		object:__wf_atom_dd875cd8(false)
	end

	object:SetVisibility(true, true)

	if gRegion:IsMaster() then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9f17ac89(v)
		__wf_atom_7470861b:__wf_atom_63396172(v)
	end

	if not blockingAnimations then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v3)
		end
	end
end

function ExplosionWarningUpdate(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local total = 0
	local flag = true

	while not __wf_atom_7e8ad928(object) and total < attackChargingTime do
		if flag then
			local v4 = math.min(total / attackChargingTime, 1)
			object:SetMeshScale((damageTriggerRadiusRange:__wf_atom_48a8e71b((math.sqrt(v4)))))
		end

		if attackChargingTime < total then
			flag = false
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(object)) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:PlayTriggeredFade()
	end
end

function BombArea(object)
	if
		__wf_atom_7e8ad928(_T.WazzardArtilleryAttackTargets)
		or __wf_atom_7e8ad928(_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()])
	then
		print("WazzardArtillery - Unable to find attack pos")
		return
	end

	object:PlaySound(damageStartSound, false, 1, false)
	local maxValue = damageTriggerRadiusRange.maxValue
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v4 = Vector(0, 0, 0)
	local _ = maxValue * math.sqrt((__wf_atom_7abf2d2f()))
	local _ = math.random() * 2 * 3.141592653589793
	local count = #_T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()]
	local total = 0
	local v5 = 1

	while total < attackLastingDuration do
		local v6 = _T.WazzardArtilleryAttackTargets[object:__wf_atom_18aa6e58()][v5]

		if not __wf_atom_7e8ad928(v6) then
			local position = v6:GetPosition()
			local v7 = position - __wf_atom_a06d543c * 4
			v4.x = v7.x
			v4.z = v7.z
			v4.y = v7.y
			local v8 = maxValue * math.sqrt((math.random()))
			local v9 = math.random() * 2 * 3.141592653589793
			v4.x += math.cos(v9) * v8
			v4.z += math.sin(v9) * v8
			v4.y += 5 * Random(1, 2)
			local v10 = __wf_atom_2f2bada0 + Rotation(Random(-10, 10), Random(50, 80), 0)

			if math.random() < chanceToDropDirectlyAtTarget then
				v4.x = position.x + Random(-1, 1)
				v4.z = position.z + Random(-1, 1)
				local v11 = position + Vector(0, 1, 0) + v6:MotionControl():__wf_atom_0cf4ee4b() * 0.25
				v10 = __wf_atom_fa8d0177(v4, v11)
			end

			local v11 = Vector()
			local v12 = (v4.y - position.y) / math.sin((math.rad(v10.pitch)))
			local v13 = v4 + __wf_atom_9341614d(Vector(0, 0, v12), v10)
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v13, v4, v2, nil, v11)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
				and v11.y - v13.y >= 1
			then
				v4 = v11
			end

			local entity = gRegion:CreateEntity(damageProjectileType, v4, v10, __wf_atom_e55d02aa, object, 1)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_8fcdea81(object)
				entity:__wf_atom_c6dbdab6(__wf_atom_e55d02aa)
			end
		end

		local v7 = projectileInterval:__wf_atom_ff1686f2() / count
		Sleep(v7)
		total += v7
		local v8 = v5 + 1
		v5 = count < v8 and 0 or v8
	end
end