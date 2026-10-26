local module = require("Lotus.Scripts.Libs.AudioLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module4 = require("SF.Scripts.NightFoldLib")
local v = Symbol("HideForEcho")
local v2 = WeakResource("/SF/Types/NeutralCreatures/Beaver/BeaverAvatar")
local v3 = Symbol("DoNothing")
local v4 = Symbol("CritterSpawnAnimation")
local v5 = Symbol("SOUL_MODE_HIDDEN")
local v6 = Symbol("OdeOrganHatch")
local v7 = Symbol("OdeOrganHatchDoor")
local v8 = Symbol("PolluterStopFluidPortForwarder")
local v9 = Type("/SF/Fx/Events/Ode/PollutionTower/TowerHatchDestructionFX")
local v10 = nil
local v11 = Symbol("CAGE_FREED")
local v12 = Symbol("CAGE_FREED_SCARED")
local v13 = false
local v14 = nil
local module5 = require("SF.Scripts.Libs.SparrowLib")
local v15 = Symbol("/Lotus/Language/Actions/CompleteXP")

local function fn(instance)
	if __wf_atom_7e8ad928(instance) then
		return nil
	end

	for i = 1, #decoTypes do
		if instance:IsA(decoTypes[i]) then
			return i
		end
	end

	return nil
end

local function fn2(object, object2)
	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_f4133158()
		object2:AttachToInPlace(object, EMPTY_SYMBOL)
		object2:__wf_atom_e310f01f(
			object2:__wf_atom_fa6a8faf() / object:__wf_atom_c082fc3d(),
			object2:__wf_atom_45c0553e()
		)
	end

	if __wf_atom_7e8ad928(closedAnim) then
		object:__wf_atom_45cf0e1a(closedMesh, false, false)
	else
		object:__wf_atom_7b7015c9(closedAnim, true)
	end

	object:PlaySound(plantBombSound, false, 1, false)

	if not __wf_atom_7e8ad928(_T.PlantBombHint) then
		module3.CompleteHudTask(_T.PlantBombHint, nil, "PlantBomb")
		_T.PlantBombHint = nil
	end
end

function cageDamage(object, object2)
	local damageData = Engine.DamageData()
	damageData.baseAmount = ealryUnlockDamage
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(17, true)
	damageData:__wf_atom_d6f4d914(5, true)
	damageData:__wf_atom_8e0ba0ec(-5)
	damageData:__wf_atom_34a8a27a(object2)
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	Normalize(__wf_atom_a06d543c)
	damageData:__wf_atom_12cf5317(__wf_atom_a06d543c)
	object:__wf_atom_649bf33e(damageData)
	object:PlaySound(cageLockedSound, false)
end

function PlayDelayedSpawnAnimation(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v16 = randomSpawnDelay.minValue + math.random() * (randomSpawnDelay.maxValue - randomSpawnDelay.minValue)
	local total = 0

	while total < v16 do
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	object:SetBlackboardBool(v4, true)
	object:__wf_atom_52bae0cc(nil, 0, false)
	object:__wf_atom_e06358f3(v11)
	object:__wf_atom_8914dfde("SpawnEnd", 5)
	object:SetBlackboardBool(v4, false)
end

function PlayDelayedSpawnScaredAnimation(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v16 = randomSpawnDelay.minValue + math.random() * (randomSpawnDelay.maxValue - randomSpawnDelay.minValue)
	local total = 0

	while total < v16 do
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	object:SetBlackboardBool(v4, true)
	object:__wf_atom_52bae0cc(nil, 0, false)
	object:__wf_atom_e06358f3(v12)
	object:__wf_atom_8914dfde("SpawnEnd", 5)
	object:SetBlackboardBool(v4, false)
end

function Unlock(instance, object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if usePortScriptTrigger then
		v10 = gRegion:FindNearestTagged(scriptTriggerTag, instance:__wf_atom_a2a18137())
	end

	v14 = gRegion:__wf_atom_f738b4af(ichorPumpTag, object:GetPosition(), 0, 60)

	if __wf_atom_7e8ad928(v14) then
		local all = gRegion:FindAll(__wf_atom_9e85eea2, object:__wf_atom_a2a18137(), 0, 20)
		local v16 = false

		for i = 1, #all do
			local v17 = object:__wf_atom_129d1aba(all[i]) or all[i]:__wf_atom_e93896ba():c_str() == "Neutral"

			if all[i]:IsKilled() or v17 then
				continue
			end

			v16 = true
			break
		end

		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if object:__wf_atom_799d95f5(true) or __wf_atom_e919fb8e.nightfoldTransition then
			if gRegion:IsMaster() then
				instance:Enable()
			end
		else
			if object == __wf_atom_c4f78a8f then
				object:__wf_atom_aeb02c14(blockMovementInputFilter)
				module4.RegisterPreventNighfoldUsage(true, "unlockCages")
			end

			object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")

			if unequipWeapon then
				module2.UnequipWeapon(object, unequipInstant)
			end

			module.EnableTaggedSequencers(Symbol("animalFreedSeq"), true)
			local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

			if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				return
			end

			local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_3a0953be)

			for _, v17 in ipairs(__wf_atom_f582136d) do
				v17:Destroy()
			end

			if useUnlockAnim == true and v16 then
				local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(cageUnlockAnim, false, 4, 1, false)
				local v17 = cageUnlockAnim:__wf_atom_091354f5(Symbol("Unlocked")) * __wf_atom_9b5dcd3b
				local total = 0

				while total < v17 do
					if __wf_atom_7e8ad928(object) or object:IsKilled() or v13 then
						if gRegion:IsMaster() then
							instance:Enable()
						end

						return
					else
						if total >= 3 then
							break
						end

						Sleep(0)
						total += __wf_atom_084b3e93()
					end
				end
			end

			if __wf_atom_7e8ad928(openAnim) or __wf_atom_7e8ad928(openingAnim) or __wf_atom_7e8ad928(closedAnim) then
				if not __wf_atom_7e8ad928(openMesh) then
					__wf_atom_3d96ddcd:__wf_atom_45cf0e1a(openMesh, false, false)
				end
			else
				__wf_atom_3d96ddcd:FirePort("PlayTriggeredAnim")
				__wf_atom_3d96ddcd:__wf_atom_7b7015c9(openAnim, true)
			end

			__wf_atom_3d96ddcd:PlaySound(cageOpenSound, false)

			if not combatSpawnAgentsImmediatelyOnUnlock then
				while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(cageUnlockAnim) do
					Sleep(0)
				end
			end

			if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				return
			end

			local __wf_atom_be0bea4a = __wf_atom_3d96ddcd:__wf_atom_be0bea4a()
			local __wf_atom_402b3832s = {}
			local position = object:GetPosition()
			local v17 = nil

			if gRegion:IsMaster() then
				local taggedChildren = module2.FindTaggedChildren(__wf_atom_be0bea4a, prisonerDecoTag)
				local v18 = {}
				local v19 = false

				for i = 1, #taggedChildren do
					if __wf_atom_7e8ad928(taggedChildren[i]) or not taggedChildren[i]:IsA(__wf_atom_8d0b7f88) then
						continue
					end

					local v20 = fn(taggedChildren[i])

					if __wf_atom_7e8ad928(v20) then
						continue
					end

					local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
						agentTypes[v20],
						taggedChildren[i]:GetPosition(),
						taggedChildren[i]:__wf_atom_dc309f8a(),
						EMPTY_SYMBOL,
						0,
						true,
						0,
						0,
						dummySpawnAnimations[v20]
					)

					if
						__wf_atom_7e8ad928(__wf_atom_402b3832)
						or __wf_atom_7e8ad928(__wf_atom_402b3832:__wf_atom_50a7d83e())
					then
						continue
					end

					local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
					__wf_atom_50a7d83e:Teleport(taggedChildren[i]:GetPosition(), taggedChildren[i]:__wf_atom_dc309f8a())

					if v16 or requiredAnimalCountInCin < i then
						if
							__wf_atom_7e8ad928(scaredFreeCins[v18[1]])
							or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d())
							or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
							or not object:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_a07f65c2()
						then
							__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("PlayDelayedSpawnAnimation"), false)
						else
							__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("PlayDelayedSpawnScaredAnimation"), false)
						end
					end

					gRegion:__wf_atom_2202ffb6():__wf_atom_fdd7548c(
						__wf_atom_402b3832,
						4,
						13,
						object:GetPosition(),
						object,
						0,
						50,
						true
					)

					if __wf_atom_50a7d83e:IsA(__wf_atom_6c243c5e) then
						for j = 1, #critterTypesToFadeOut do
							if
								__wf_atom_7e8ad928(critterTypesToFadeOut[j])
								or not __wf_atom_50a7d83e:IsA(critterTypesToFadeOut[j])
							then
								continue
							end

							__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DissolveCritterOnAnimEvent"), false)
						end

						__wf_atom_50a7d83e:__wf_atom_dd3e4432(false)

						if not v19 then
							v19 = true

							if not isOrganEventTrigger then
								__wf_atom_50a7d83e:__wf_atom_9333cc3c(object)
							end
						end

						if isOrganEventTrigger then
							__wf_atom_50a7d83e:Attach(
								pollutorFreeFxType,
								EMPTY_SYMBOL,
								__wf_atom_28d5d4aa,
								__wf_atom_80368bb1,
								nil,
								1
							)
							__wf_atom_50a7d83e:SetBlackboardBool(v3, true)
						end
					end

					local v21 = WeakResource("/SF/Fx/Gameplay/Interactables/SoulModeSphereDeco")
					local __wf_atom_0c59b746 = __wf_atom_50a7d83e:__wf_atom_0c59b746()

					for j = 1, #__wf_atom_0c59b746 do
						local __wf_atom_18aa6e58 = __wf_atom_0c59b746[j]:__wf_atom_18aa6e58()

						if __wf_atom_7e8ad928(__wf_atom_18aa6e58) or not __wf_atom_18aa6e58:IsA(v21) then
							continue
						end

						__wf_atom_50a7d83e:__wf_atom_8f12baaa(__wf_atom_0c59b746[j])
					end

					__wf_atom_402b3832s[i] = __wf_atom_402b3832
					v18[i] = v20
					taggedChildren[i]:SetVisibility(false)
					gRegion:__wf_atom_dd1e4d10(taggedChildren[i])
				end

				Sleep(0)

				if
					#__wf_atom_402b3832s >= 1
					and #v18 > 0
					and not __wf_atom_7e8ad928(object)
					and canPlayCine
					and (not v16 or forcePlayReleaseCine)
				then
					local __wf_atom_dc309f8a = __wf_atom_3d96ddcd:__wf_atom_dc309f8a()
					__wf_atom_dc309f8a.heading += 180
					__wf_atom_dc309f8a.pitch *= -1
					__wf_atom_dc309f8a.bank *= -1
					local v20 = math.abs(instance:__wf_atom_28a0479a().z) + math.abs(instance:__wf_atom_fa6a8faf().z) * __wf_atom_3d96ddcd:__wf_atom_c082fc3d()
					local v21 = __wf_atom_9341614d(Vector(0, 0, v20), __wf_atom_dc309f8a)
					local v22 = __wf_atom_3d96ddcd:GetPosition() - v21
					local freeCin = freeCins[v18[1]]

					if
						not __wf_atom_7e8ad928(scaredFreeCins[v18[1]])
						and not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d())
						and not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
						and object:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_a07f65c2()
					then
						freeCin = scaredFreeCins[v18[1]]
					end

					local entity = gRegion:CreateEntity(freeCin, v22, __wf_atom_dc309f8a, object, object)
					local __wf_atom_99c400ff, _ = entity:__wf_atom_99c400ff(Symbol("Envoy"), 0)
					entity:SetPosition(entity:GetPosition() - __wf_atom_9341614d(__wf_atom_99c400ff, __wf_atom_dc309f8a))
					local __wf_atom_38aeafad = entity:__wf_atom_38aeafad()

					for i = #__wf_atom_38aeafad, 1, -1 do
						if not (__wf_atom_38aeafad[i] == Symbol("Envoy") or __wf_atom_38aeafad[i] == Symbol("CinematicCamera")) then
							continue
						end

						table.remove(__wf_atom_38aeafad, i)
					end

					if not __wf_atom_7e8ad928(entity) then
						if not __wf_atom_7e8ad928(bombAttachment) then
							v17 = gRegion:CreateEntity(
								bombAttachment,
								object:GetPosition(),
								__wf_atom_dc309f8a,
								__wf_atom_3d96ddcd,
								__wf_atom_3d96ddcd
							)

							if not __wf_atom_7e8ad928(v17) then
								entity:__wf_atom_a3d2b66b(v17, bombAnimName)
							end
						end

						local count = 0

						for i = 1, #__wf_atom_402b3832s do
							if requiredAnimalCountInCin <= count then
								break
							end

							local __wf_atom_50a7d83e = __wf_atom_402b3832s[i]:__wf_atom_50a7d83e()
							__wf_atom_50a7d83e:__wf_atom_52bae0cc(nil, 0, false)

							if
								not __wf_atom_7e8ad928(__wf_atom_38aeafad)
								and i <= #__wf_atom_38aeafad
								and __wf_atom_38aeafad[i] == Symbol("DucksDuckling1")
							then
								__wf_atom_38aeafad[i] = Symbol("MaleDuck")
							end

							__wf_atom_50a7d83e:__wf_atom_701bf429(__wf_atom_38aeafad[i])
							entity:__wf_atom_a3d2b66b(__wf_atom_50a7d83e, __wf_atom_38aeafad[i])
							count += 1
						end

						if isQuestRelatedCine then
							if waitForDeltaFromEnd == 0 then
								_T.WaitForQuestCineCompletion = module2.PlayCinematicAndWait(entity, false, object)
							else
								_T.WaitForQuestCineCompletion = module2.PlayCinematicAndWait(
									entity,
									false,
									object,
									waitForDeltaFromEnd
								)
							end

							Sleep(0.5)
						else
							entity:SetInstigatorAvatar(object)
							entity:FirePort("StartPlaying")
							module.EnableTaggedSoundSysVolumes(Symbol("WarsongMndHorseRideMusic"), false)
							__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("CorruptionFlowFadeOut"), false)

							while
								not __wf_atom_7e8ad928(entity)
								and entity:__wf_atom_7d4910e4()
								and not entity:__wf_atom_e9546dc6()
							do
								Sleep(0)
							end

							for _, v23 in ipairs(__wf_atom_402b3832s) do
								if __wf_atom_7e8ad928(v23) or __wf_atom_7e8ad928(v23:__wf_atom_50a7d83e()) then
									continue
								end

								v23:__wf_atom_50a7d83e():__wf_atom_e5d015a7(EMPTY_SYMBOL)
							end
						end
					end
				end
			end

			if combatSpawnAgentsImmediatelyOnUnlock then
				while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(cageUnlockAnim) do
					Sleep(0)
				end
			elseif not __wf_atom_7e8ad928(object) then
				object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
			end

			if __wf_atom_7e8ad928(object) then
				return
			end

			if not gRegion:IsMaster() and object == __wf_atom_c4f78a8f and not v16 then
				Sleep(0.5)

				while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
					Sleep(0)
				end

				if __wf_atom_7e8ad928(object) then
					return
				end
			end

			local taggedChildren = module2.FindTaggedChildren(__wf_atom_be0bea4a, v)

			for i = 1, #taggedChildren do
				if __wf_atom_7e8ad928(taggedChildren[i]) or not taggedChildren[i]:IsA(__wf_atom_3ae8d73b) then
					continue
				end

				taggedChildren[i]:PlayTriggeredFade()
			end

			if fadeOutAttachRoot and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("FadeOutAttachRoot"), false)
			end

			if gRegion:IsMaster() then
				local position2 = object:GetPosition()
				position2.y = position.y + object:GetHeight()
				local position3 = object:GetPosition()
				local v18 = {
					__wf_atom_7b01f9ce,
					__wf_atom_d127f143,
					__wf_atom_43e0c427,
					__wf_atom_3feeb44a,
					__wf_atom_4ebf67cb
				}
				local v19 = Vector()
				object:GetPosition()

				if
					gRegion:__wf_atom_f54ffdb8(position2, position3, v18, {}, false, nil, v19)
					and v19.y - object:GetPosition().y > 0.3
				then
					object:Teleport(v19, object:__wf_atom_2f2bada0())
				end

				if resetCageDebug then
					local _ = not __wf_atom_7e8ad928(closedMesh)
				end

				if not __wf_atom_7e8ad928(bombAttachment) then
					fn2(__wf_atom_3d96ddcd, v17)
				end

				if isOrganEventTrigger then
					local taggedChildren2 = module2.FindTaggedChildren(__wf_atom_be0bea4a, v5)

					for i = 1, #taggedChildren2 do
						if __wf_atom_7e8ad928(taggedChildren2[i]) or not taggedChildren2[i]:IsA(__wf_atom_3ae8d73b) then
							continue
						end

						taggedChildren2[i]:Destroy()
					end

					module5.RemoveSparrowDestination(__wf_atom_3d96ddcd)

					if
						#__wf_atom_402b3832s > 0
						and not (__wf_atom_7e8ad928(__wf_atom_402b3832s[1]) or __wf_atom_7e8ad928(__wf_atom_402b3832s[1]:__wf_atom_50a7d83e()))
					then
						__wf_atom_402b3832s[1]:__wf_atom_50a7d83e():__wf_atom_8a035cd5(
							Symbol("OnFreedOrganEvent"),
							false
						)
					end
				end

				__wf_atom_3d96ddcd:Activate()
				instance:Disable()

				if not __wf_atom_7e8ad928(v10) then
					v10:FirePort("Execute")
				end

				module5.RemoveSparrowDestination(instance)
			end

			if not __wf_atom_7e8ad928(object) and object == __wf_atom_c4f78a8f then
				module4.ClearPreventNighfoldUsage("unlockCages")
				object:__wf_atom_cf966a74(blockMovementInputFilter)
				object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
				object:__wf_atom_d2b2176d():__wf_atom_355b9a20(500, object, v15)
			end

			Sleep(1)

			if gRegion:IsMaster() then
				if destroyAgentsAfterCine then
					for i = 1, #__wf_atom_402b3832s do
						if
							__wf_atom_7e8ad928(__wf_atom_402b3832s[i])
							or __wf_atom_7e8ad928(__wf_atom_402b3832s[i]:__wf_atom_50a7d83e())
						then
							continue
						end

						__wf_atom_402b3832s[i]:__wf_atom_50a7d83e():Destroy()
					end
				end

				if not __wf_atom_7e8ad928(instance) then
					instance:Destroy()
				end
			end
		end
	else
		object:__wf_atom_9b5dcd3b(cageUnlockAnim, false, 4, 0, false)
		Sleep(0.1)
		cageDamage(object, instance:__wf_atom_3d96ddcd())
		instance:Enable()
		_T.ShowImpactMessage("/SF/Language/Tutorial/Cages", 3)
	end
end

function PrepCin(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if not __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		module2.UnequipWeapon(__wf_atom_02a7a2f4, unequipInstant)
		Sleep(0)
		local nearestTagged = gRegion:FindNearestTagged(Symbol("AnimalPrisonCage"), __wf_atom_02a7a2f4:GetPosition())

		if not __wf_atom_7e8ad928(openMesh) then
			__wf_atom_7e8ad928(nearestTagged)
		end
	end
end

function OnDamaged(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	print(object:__wf_atom_5b41f63b() .. " damaged during cage opening animation, popping input filter")

	if object == __wf_atom_c4f78a8f and module4.IsNightfoldBlockedById("unlockCages") then
		module4.ClearPreventNighfoldUsage("unlockCages")
		object:__wf_atom_cf966a74(blockMovementInputFilter)
	end

	v13 = true
	object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
end

function ClampRotation(p)
	while p < 0 do
		p += 360
	end

	while p >= 360 do
		p -= 360
	end

	return p
end

function CorruptionFlowFadeOut(object)
	Sleep(0)
	local total = 0

	while total < corruptionFlowFadeOutDelay do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
	local taggedChildren = module2.FindTaggedChildren(__wf_atom_be0bea4a, v)

	for i = 1, #taggedChildren do
		if __wf_atom_7e8ad928(taggedChildren[i]) or not taggedChildren[i]:IsA(__wf_atom_3ae8d73b) then
			continue
		end

		taggedChildren[i]:PlayTriggeredFade()
	end
end

function DissolveOut(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v16 = 0

	while v16 < p do
		v16 = __wf_atom_421b01aa(v16 + __wf_atom_084b3e93(), 0, p)
		object:__wf_atom_68f2c268(v16 / p)
		Sleep(0)
	end

	if p2 then
		gRegion:__wf_atom_dd1e4d10(object)
	end
end

function FadeOutAttachRoot(p)
	local total = 0

	while total < fadeOutAttachRootDelay do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	DissolveOut(p, 0.5, true)
end

function DissolveCritterOnAnimEvent(object)
	object:__wf_atom_8914dfde("DissolveAndDestroy", 5)
	DissolveOut(object, 0.5, true)
end

local function fn3(instance, heading, p)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local heading2 = instance:__wf_atom_2f2bada0().heading
	local v16

	if heading2 - heading > 180 then
		v16 = heading2 - 360
	else
		v16 = heading2
	end

	if v16 - heading < -180 then
		v16 += 360
	end

	if math.abs(v16 - heading) <= 5 then
		return
	end

	instance:__wf_atom_84d66e8e(Rotation(heading, 0, 0))
	local total = 0

	while true do
		if heading2 - heading > 180 then
			heading2 -= 360
		end

		if heading2 - heading < -180 then
			heading2 += 360
		end

		if math.abs(heading2 - heading) > 5 and total < p then
			Sleep(0)
			total += __wf_atom_084b3e93()
			heading2 = instance:__wf_atom_2f2bada0().heading
		else
			break
		end
	end

	instance:Teleport(instance:GetPosition(), Rotation(heading, 0, 0))
end

function OnFreedOrganEvent(instance)
	if __wf_atom_7e8ad928(_T.OrganBeaversFreed) then
		_T.OrganBeaversFreed = 0
	end

	if __wf_atom_7e8ad928(_T.CrittersFreed) then
		_T.CrittersFreed = 0
	end

	if not instance:IsA(v2) or _T.OrganBeaversFreed >= 4 then
		instance:SetBlackboardBool(v3, false)
		return
	end

	_T.OrganBeaversFreed = _T.OrganBeaversFreed + 1
	print("Ode Organ event: Freed beaver number " .. _T.OrganBeaversFreed)

	while not __wf_atom_7e8ad928(instance) and instance:__wf_atom_06a75154() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(instance) then
		_T.CrittersFreed += 1
		print("Error in ode organ event: Beaver agent or avatar is null after spawn animation")
	else
		local nearestTagged = gRegion:FindNearestTagged(v6, instance:GetPosition())

		if __wf_atom_7e8ad928(nearestTagged) then
			_T.CrittersFreed += 1
			print("Error in ode organ event: Beaver could not find a hatch nearby")
		else
			local nearestTagged2 = gRegion:FindNearestTagged(v7, nearestTagged:GetPosition())

			if __wf_atom_7e8ad928(nearestTagged2) then
				_T.CrittersFreed += 1
				print("Error in ode organ event: Beaver could not find a hatch door nearby")
			else
				local v16 = Rotation(nearestTagged:__wf_atom_dc309f8a().heading, 0, 0)
				local v17 = Rotation(v16.heading + 180, 0, 0)
				local v18 = nearestTagged:GetPosition() + __wf_atom_9341614d(Vector(0, 0, 1.2), v16) + Vector(0, -0.8, 0)
				local v19 = nearestTagged:GetPosition() + __wf_atom_9341614d(Vector(0, 0, 0.4), v16) + Vector(0, -0.8, 0)

				if gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(v18, 10) then
					nearestTagged:__wf_atom_b811702e(Symbol())
					nearestTagged2:__wf_atom_b811702e(Symbol())
					local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

					if instance:__wf_atom_a5304c35(v18) < 100 then
						__wf_atom_30e3d82b:__wf_atom_b783ff91(
							v18,
							__wf_atom_fa8d0177(v18, nearestTagged:GetPosition()).heading
						)
					end

					local total = 0

					while
						not __wf_atom_7e8ad928(instance)
						and __wf_atom_30e3d82b:__wf_atom_6132e1f6()
						and not (__wf_atom_30e3d82b:__wf_atom_0d7e0a1f() or __wf_atom_30e3d82b:__wf_atom_d3f9d901())
					do
						total += __wf_atom_084b3e93()

						if organBeaverMaxMoveTime < total then
							break
						else
							Sleep(0)
						end
					end

					if __wf_atom_7e8ad928(instance) then
						_T.CrittersFreed += 1
						print("Error in ode organ event: Beaver avatar is null after moving to pipe hatch")
					else
						__wf_atom_30e3d82b:__wf_atom_b414eabf()
						__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
						instance:__wf_atom_e4df34a5(false)
						instance:SetDisableGravity(true)
						local __wf_atom_385aec48 = nearestTagged2:__wf_atom_385aec48()
						local _t, _t2, heading, _t3, _t4, _t5, v20, v21, _t6

						if __wf_atom_385aec48 then
							while not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(nearestTagged2) or __wf_atom_385aec48 or nearestTagged2:__wf_atom_385aec48()) do
								Sleep(0.1)
							end

							if __wf_atom_7e8ad928(instance) then
								_t = _T
								_t.CrittersFreed += 1
								print("Error in ode organ event: Beaver avatar is null after hatch opened")
							else
								if
									instance:__wf_atom_7bcdbf55(Symbol("HOP_START"))
									or instance:__wf_atom_7bcdbf55(Symbol("HOP_CYCLE"))
								then
									instance:__wf_atom_e06358f3(Symbol("HOP_STOP"))
								end

								Sleep(0)

								while
									not __wf_atom_7e8ad928(instance)
									and instance:__wf_atom_7bcdbf55(Symbol("HOP_STOP"))
								do
									Sleep(0)
								end

								if __wf_atom_7e8ad928(instance) then
									_t2 = _T
									_t2.CrittersFreed += 1
									print("Error in ode organ event: Beaver avatar is null after hop stop")
								else
									module5.RemoveSparrowDestination(instance)
									heading = __wf_atom_fa8d0177(instance:GetPosition(), v19).heading
									fn3(instance, heading, 2)

									if __wf_atom_7e8ad928(instance) then
										_t3 = _T
										_t3.CrittersFreed += 1
										print("Error in ode organ event: Beaver avatar is null after turning to climb anim start position")
									else
										instance:MotionControl():__wf_atom_d327aef9(
											v19,
											0,
											true,
											false,
											v17,
											2,
											true,
											true
										)
										instance:__wf_atom_921c1a5f(beaverJogCycleAnim, false, 3, 2, false)

										while instance:MotionControl():__wf_atom_5b89cdd7() do
											Sleep(0)
										end

										if __wf_atom_7e8ad928(instance) then
											_t4 = _T
											_t4.CrittersFreed += 1
											print("Error in ode organ event: Beaver avatar is null after moving to step up animation starting position")
										else
											instance:__wf_atom_921c1a5f(nil, false)
											fn3(instance, v17.heading, 2)

											if __wf_atom_7e8ad928(instance) then
												_t5 = _T
												_t5.CrittersFreed += 1
												print("Error in ode organ event: Beaver avatar is null after turning to hatch")
											else
												instance:Teleport(v19, v17)
												instance:__wf_atom_921c1a5f(beaverStepUpAnim, true, 3, 1, true)
												instance:__wf_atom_921c1a5f(beaverJogCycleAnim, true, 3, 3, true)
												DissolveOut(instance, 0.5, false)
												v20 = gRegion:__wf_atom_c4f78a8f()
												module.EnableNearestTaggedSequencer(
													Symbol("SFXAnimalInteriorDestruction"),
													true,
													v20:GetPosition()
												)
												Sleep(1)
												v21 = gRegion:FindNearestTagged(v8, nearestTagged:GetPosition())

												if not __wf_atom_7e8ad928(v21) then
													v21:FirePort("TriggerPort")
													gRegion:CreateEntity(
														v9,
														nearestTagged:GetPosition(),
														nearestTagged:__wf_atom_dc309f8a()
													)
												end

												if __wf_atom_7e8ad928(_T.CrittersFreed) then
													_T.CrittersFreed = 0
												end

												_t6 = _T
												_t6.CrittersFreed += 1
												print("Ode organ event: Beaver number " .. _T.CrittersFreed .. " successfully entered pipe hatch")

												if not __wf_atom_7e8ad928(instance) then
													gRegion:__wf_atom_dd1e4d10(instance)
												end
											end
										end
									end
								end
							end
						else
							module5.AddSimpleDestination(
								instance,
								"OrganBeaver" .. _T.OrganBeaversFreed,
								module5.PRIORITY.TALE,
								Range(0, 3.4028234663852886e38)
							)
							fn3(
								instance,
								__wf_atom_fa8d0177(instance:GetPosition(), nearestTagged:GetPosition()).heading,
								2
							)

							if __wf_atom_7e8ad928(instance) then
								_T.CrittersFreed += 1
								print("Error in ode organ event: Beaver avatar is null after turning to climb anim start position")
							else
								instance:__wf_atom_e06358f3(Symbol("HOP_START"))

								while not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(nearestTagged2) or __wf_atom_385aec48 or nearestTagged2:__wf_atom_385aec48()) do
									Sleep(0.1)
								end

								if __wf_atom_7e8ad928(instance) then
									_t = _T
									_t.CrittersFreed += 1
									print("Error in ode organ event: Beaver avatar is null after hatch opened")
								else
									if
										instance:__wf_atom_7bcdbf55(Symbol("HOP_START"))
										or instance:__wf_atom_7bcdbf55(Symbol("HOP_CYCLE"))
									then
										instance:__wf_atom_e06358f3(Symbol("HOP_STOP"))
									end

									Sleep(0)

									while
										not __wf_atom_7e8ad928(instance)
										and instance:__wf_atom_7bcdbf55(Symbol("HOP_STOP"))
									do
										Sleep(0)
									end

									if __wf_atom_7e8ad928(instance) then
										_t2 = _T
										_t2.CrittersFreed += 1
										print("Error in ode organ event: Beaver avatar is null after hop stop")
									else
										module5.RemoveSparrowDestination(instance)
										heading = __wf_atom_fa8d0177(instance:GetPosition(), v19).heading
										fn3(instance, heading, 2)

										if __wf_atom_7e8ad928(instance) then
											_t3 = _T
											_t3.CrittersFreed += 1
											print("Error in ode organ event: Beaver avatar is null after turning to climb anim start position")
										else
											instance:MotionControl():__wf_atom_d327aef9(
												v19,
												0,
												true,
												false,
												v17,
												2,
												true,
												true
											)
											instance:__wf_atom_921c1a5f(beaverJogCycleAnim, false, 3, 2, false)

											while instance:MotionControl():__wf_atom_5b89cdd7() do
												Sleep(0)
											end

											if __wf_atom_7e8ad928(instance) then
												_t4 = _T
												_t4.CrittersFreed += 1
												print("Error in ode organ event: Beaver avatar is null after moving to step up animation starting position")
											else
												instance:__wf_atom_921c1a5f(nil, false)
												fn3(instance, v17.heading, 2)

												if __wf_atom_7e8ad928(instance) then
													_t5 = _T
													_t5.CrittersFreed += 1
													print("Error in ode organ event: Beaver avatar is null after turning to hatch")
												else
													instance:Teleport(v19, v17)
													instance:__wf_atom_921c1a5f(beaverStepUpAnim, true, 3, 1, true)
													instance:__wf_atom_921c1a5f(beaverJogCycleAnim, true, 3, 3, true)
													DissolveOut(instance, 0.5, false)
													v20 = gRegion:__wf_atom_c4f78a8f()
													module.EnableNearestTaggedSequencer(
														Symbol("SFXAnimalInteriorDestruction"),
														true,
														v20:GetPosition()
													)
													Sleep(1)
													v21 = gRegion:FindNearestTagged(v8, nearestTagged:GetPosition())

													if not __wf_atom_7e8ad928(v21) then
														v21:FirePort("TriggerPort")
														gRegion:CreateEntity(
															v9,
															nearestTagged:GetPosition(),
															nearestTagged:__wf_atom_dc309f8a()
														)
													end

													if __wf_atom_7e8ad928(_T.CrittersFreed) then
														_T.CrittersFreed = 0
													end

													_t6 = _T
													_t6.CrittersFreed += 1
													print("Ode organ event: Beaver number " .. _T.CrittersFreed .. " successfully entered pipe hatch")

													if not __wf_atom_7e8ad928(instance) then
														gRegion:__wf_atom_dd1e4d10(instance)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				else
					_T.CrittersFreed += 1
					print("Error in ode organ event: Nearby hatch could not find nav pos")
				end
			end
		end
	end
end

function PlayKickCagePOIAnimalReaction(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("AnimalPrisonCage"), object:GetPosition())

	if __wf_atom_7e8ad928(nearestTagged) then
		return
	end

	local __wf_atom_be0bea4a = nearestTagged:__wf_atom_be0bea4a()
	local taggedChildren = module2.FindTaggedChildren(__wf_atom_be0bea4a, prisonerDecoTag)

	for _, v16 in ipairs(taggedChildren) do
		if __wf_atom_7e8ad928(v16) or not v16:IsA(__wf_atom_8d0b7f88) then
			continue
		end

		local v17 = fn(v16)

		if not __wf_atom_7e8ad928(v17) then
			v16:__wf_atom_921c1a5f(kickCageReactionAnims[v17], false, 3, 1, true)
		end
	end
end