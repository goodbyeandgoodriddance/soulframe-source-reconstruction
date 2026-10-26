require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("RopeCut")
local v2 = Symbol("GAME_C1_SPINE1")
local v3 = Symbol("SFXVocalGrappleBreak")

function EvaluateAbility(object, object2, _)
	local __wf_atom_f036f03b = object2:__wf_atom_92aa9d91():__wf_atom_f036f03b()

	if
		__wf_atom_7e8ad928(__wf_atom_f036f03b)
		or not __wf_atom_f036f03b:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_f036f03b:IsKilled()
		or __wf_atom_f036f03b:__wf_atom_129d1aba(object2)
	then
		return false
	end

	object:__wf_atom_f7170fc9(__wf_atom_f036f03b)
	return true
end

function NpcEvaluateAbility(object, instance)
	if instance:HasTag(v) then
		print("Bailing because rope was cut by player")
		return 0
	end

	local __wf_atom_9a1e4ed3 = instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_9a1e4ed3.visible then
		local _ = __wf_atom_9a1e4ed3.distanceToTarget > maxRange
	end

	local avatar = __wf_atom_9a1e4ed3.avatar

	if __wf_atom_7e8ad928(avatar) or avatar:__wf_atom_bedb4e3f() then
		return 0
	end

	if avatar:__wf_atom_535d5cbb() then
		local __wf_atom_4e50d390 = avatar:__wf_atom_4e50d390()
		local v4 = __wf_atom_e97f3142(__wf_atom_4e50d390)
		local v5 = instance:GetPosition() - avatar:GetPosition()
		Normalize(v5)

		if math.deg((math.acos((Dot(v4, v5))))) > 45 then
			return 0
		end
	end

	local __wf_atom_7b82e9e1 = avatar:__wf_atom_7b82e9e1(12)

	if __wf_atom_7b82e9e1 ~= targetWhenKnockedDown or __wf_atom_7b82e9e1 == targetWhenStanding then
		return 0
	end

	for _, className in ipairs(forbiddenTargetTypes) do
		if avatar:IsA(className) then
			return 0
		end
	end

	if __wf_atom_9a1e4ed3.distanceToTarget >= minRange or not avatar:__wf_atom_4ec961d6() then
		object:__wf_atom_f7170fc9(avatar)
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

local function fn(object) -- 7 equivalent calls inferred from this helper
	return "MachetePull" .. object:__wf_atom_5b41f63b()
end

local function fn2(entity, p, __wf_atom_1c374cc9) -- 2 equivalent calls inferred from this helper
	local v4 = Distance(__wf_atom_1c374cc9, p) / 30
	return __wf_atom_1c374cc9 + entity:__wf_atom_278a2d05() * v4
end

function ActivateAbility(object, instance, entity, _)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	if __wf_atom_7e8ad928(entity) then
		if
			__wf_atom_7e8ad928(instance:__wf_atom_30e3d82b())
			or __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3())
			or __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity)
		then
			return
		else
			entity = instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end
	end

	if __wf_atom_7e8ad928(entity) or instance:HasTag(v) then
		return
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	local __wf_atom_1c374cc9 = entity:__wf_atom_1c374cc9(v2)
	local v4 = fn2(entity, instance:__wf_atom_1c374cc9(Hand), __wf_atom_1c374cc9) -- inferred equivalent call
	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	local v5 = __wf_atom_fa8d0177(__wf_atom_a2a18137, v4)
	local v6 = fn(instance) -- inferred equivalent call
	_T[v6] = {}
	_T[v6].target = entity
	_T[v6].pulling = false
	instance:MotionControl():__wf_atom_3a1d0c16(v5)
	instance:__wf_atom_8914dfde(animEventToWaitFor, instance:__wf_atom_9b5dcd3b(activateAnim, false, 2, 1, true))

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_1c374cc9_2 = instance:__wf_atom_1c374cc9(Hand)

	if ObstructionCheckBone:__wf_atom_8598f3a9() then
		local __wf_atom_1c374cc9_3 = instance:__wf_atom_1c374cc9(ObstructionCheckBone)

		if not __wf_atom_7e8ad928(gRegion:__wf_atom_3ec9f18c(
			__wf_atom_1c374cc9_3,
			__wf_atom_1c374cc9_2,
			0.075,
			instance,
			__wf_atom_1c374cc9_2
		)) then
			local v7 = __wf_atom_1c374cc9_2 - __wf_atom_1c374cc9_3
			Normalize(v7)
			__wf_atom_1c374cc9_2 -= v7 * 0.2
		end
	end

	if not __wf_atom_7e8ad928(entity) then
		v4 = fn2(entity, __wf_atom_1c374cc9_2, entity:__wf_atom_1c374cc9(v2)) -- inferred equivalent call
	end

	instance:PlaySound(sound, false, 0, true)
	local v7 = __wf_atom_fa8d0177(__wf_atom_1c374cc9_2, v4)
	local entity2 = gRegion:CreateEntity(projType, __wf_atom_1c374cc9_2, v7)
	local beam

	if not __wf_atom_7e8ad928(entity2) then
		entity2:SetInRift(instance:__wf_atom_dc88744c())
		_T[v6].proj = entity2
		beam = gRegion:CreateEntity(beamType, entity2:__wf_atom_a2a18137(), __wf_atom_80368bb1, object)

		if not __wf_atom_7e8ad928(beam) then
			_T[v6].beam = beam
			entity2:AttachEntity(beam, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	Vector()

	if not __wf_atom_7e8ad928(beam) then
		beam:__wf_atom_a64eca67(__wf_atom_1c374cc9_2)
	end

	if not __wf_atom_7e8ad928(entity2) then
		entity2:__wf_atom_8fcdea81(instance)
		entity2:SetTarget(entity)
	end

	if gRegion:IsMaster() then
		local maxTime = maxTime

		while maxTime > 0 and not __wf_atom_7e8ad928(entity2) do
			Sleep(0)
			maxTime -= __wf_atom_084b3e93()

			if _T[v6].pulling then
				break
			end
		end

		if not object:IsMaster() then
			return
		end

		if __wf_atom_7e8ad928(_T[v6]) or not _T[v6].pulling then
			object:__wf_atom_e8954328()
			return
		end
	end

	while not gRegion:IsMaster() or _T[v6].pulling do
		Sleep(0)
	end

	if object:IsMaster() then
		object:__wf_atom_e8954328()
	end

	if not __wf_atom_7e8ad928(postPullCreateFx) then
		local target = _T[v6].target
		gRegion:CreateEntity(postPullCreateFx, __wf_atom_1c374cc9_2, v7, instance, target)
	end
end

function OnEmbed(instance)
	local __wf_atom_7be51ede = instance:__wf_atom_7be51ede()
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local v4 = fn(__wf_atom_7be51ede) -- inferred equivalent call
		local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not (__wf_atom_7e8ad928(_T[v4]) or __wf_atom_7e8ad928(__wf_atom_e55d02aa)) then
			local target = _T[v4].target

			if
				not __wf_atom_7e8ad928(target)
				and (target:__wf_atom_8efce136() or gRegion:IsMaster() and not target:__wf_atom_535d5cbb())
			then
				local secondaryScriptArgs = SF.SecondaryScriptArgs(true)

				if
					not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
					and __wf_atom_3d96ddcd == target
					and not (__wf_atom_7be51ede:IsKilled() or canBeBlocked and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(26))
					and not (canBeDodged and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(4))
				then
					secondaryScriptArgs:__wf_atom_a17e41c6(__wf_atom_3d96ddcd)
				end

				__wf_atom_e55d02aa:ActivateSecondaryScript(abilityType, Symbol("DoPull"), secondaryScriptArgs)
			end
		end
	end

	instance:Destroy()
end

function DoPull(object, _, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local v4 = fn(__wf_atom_6009c8ed) -- inferred equivalent call

	if __wf_atom_7e8ad928(_T[v4]) then
		return
	end

	local beam = _T[v4].beam
	local v5 = nil
	_T[v4].pulling = true

	if __wf_atom_7e8ad928(object2) then
		Sleep(0)

		if not __wf_atom_7e8ad928(_T[v4]) then
			_T[v4].pulling = false
		end
	else
		if not __wf_atom_7e8ad928(hitFX) then
			v5 = object2:Attach(hitFX, Symbol("GAME_C1_SPINE2"), __wf_atom_28d5d4aa)
		end

		if not __wf_atom_7e8ad928(beam) then
			beam:Destroy()
		end

		local beam2 = __wf_atom_6009c8ed:Attach(beamType, Hand)
		_T[v4].beam = beam2

		if useCutMechanic then
			__wf_atom_6009c8ed:__wf_atom_921c1a5f(pullLoopAnim, false, 3, 2, true)
			local v6

			if gRegion:IsMaster() then
				print("Creating Rope Cut Deco on Host")
				local lookAtRotation = __wf_atom_6009c8ed:GetLookAtRotation(object2:__wf_atom_a2a18137())
				v6 = gRegion:CreateEntity(
					ropeCutDecoType,
					object2:__wf_atom_a2a18137(),
					lookAtRotation,
					__wf_atom_6009c8ed,
					__wf_atom_6009c8ed
				)
			end

			__wf_atom_6009c8ed:Attach(cutReadyEffect, Hand)
			Sleep(0.1)

			if not gRegion:IsMaster() then
				print("Getting Replica Deco")

				while __wf_atom_7e8ad928(v6) do
					if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
						v6 = gRegion:__wf_atom_e2db08ce(ropeCutDecoType, __wf_atom_6009c8ed:__wf_atom_a2a18137())
					end

					Sleep(0)
				end
			end

			local pullDelayTime = pullDelayTime

			while
				pullDelayTime > 0
				and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:__wf_atom_c6f1f83d() < 1)
			do
				local v7 = Vector()
				__wf_atom_c37ab6c1(v7, __wf_atom_6009c8ed:__wf_atom_a2a18137(), object2:__wf_atom_a2a18137())
				Normalize(v7)
				object2:MotionControl():__wf_atom_4bb21efc(v7 * pushVelMagnitude)

				if __wf_atom_7e8ad928(v6) or v6:__wf_atom_c6f1f83d() < 1 then
					print("Player cut the rope")
					__wf_atom_6009c8ed:__wf_atom_78128d94(v)
				end

				if __wf_atom_6009c8ed:HasTag(v) or object2:__wf_atom_7b82e9e1(4) or object2:__wf_atom_7b82e9e1(25) then
					print("Initiating backfire")

					if not __wf_atom_7e8ad928(beam2) then
						beam2:Destroy()
					end

					if not __wf_atom_7e8ad928(soundRopeCut) then
						object2:PlaySound(soundRopeCut, false, 0, true)
					end

					__wf_atom_6009c8ed:__wf_atom_0650fed7(cutReadyEffect)

					if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T[v4]) then
						_T[v4].pulling = false
						local damageData = Engine.DamageData()
						damageData.baseAmount = 1
						damageData:__wf_atom_812165c6(2)
						local v8 = __wf_atom_6009c8ed:__wf_atom_a06d543c() * -1

						if object2:__wf_atom_7b82e9e1(4) or object2:__wf_atom_7b82e9e1(25) then
							VectorAdd(v8, object2:__wf_atom_278a2d05(), v7)
							damageData:__wf_atom_d6f4d914(20, true)
							damageData:__wf_atom_1f3b492b(11)
							local __wf_atom_30e3d82b = __wf_atom_6009c8ed:__wf_atom_30e3d82b()

							if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
								__wf_atom_30e3d82b:__wf_atom_b414eabf()
								__wf_atom_30e3d82b:__wf_atom_9356c1bd(6, v3)
							end
						else
							damageData:__wf_atom_d6f4d914(16, true)
							damageData:__wf_atom_1f3b492b(4)
						end

						Normalize(v8)
						damageData:__wf_atom_12cf5317(v8 * backfireImpulse)
						__wf_atom_6009c8ed:__wf_atom_649bf33e(damageData)
					end

					if not __wf_atom_7e8ad928(v6) then
						v6:Destroy()
					end

					if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T[v4]) then
						_T[v4].pulling = false
					end

					return
				else
					if not __wf_atom_7e8ad928(v6) then
						local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(ropeCutProxyType)
						local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
						local __wf_atom_a2a18137_2 = __wf_atom_6009c8ed:__wf_atom_a2a18137()
						local v8 = Distance(__wf_atom_a2a18137, __wf_atom_a2a18137_2)
						local v9 = v8 / 2
						local v10 = Vector()
						local v11 = Vector()
						VectorAdd(v11, object2:__wf_atom_a2a18137(), ropeCutOffset)
						VectorAdd(v10, v11, v7 * v9)
						v6:SetPosition(v10)
						v6:__wf_atom_9b788a35((__wf_atom_6009c8ed:GetLookAtRotation(object2:__wf_atom_a2a18137())))

						if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
							__wf_atom_bb3e7833:__wf_atom_f947c7cc(v8, ropeCutHitboxScale, ropeCutHitboxScale)
						end
					end

					if not __wf_atom_7e8ad928(beam2) then
						beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(v2)))
					end

					pullDelayTime -= __wf_atom_084b3e93()
					Sleep(0)
				end
			end

			__wf_atom_6009c8ed:__wf_atom_0650fed7(cutReadyEffect)

			if not __wf_atom_7e8ad928(v6) then
				v6:Destroy()
			end
		elseif not __wf_atom_7e8ad928(beam2) then
			beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(Symbol("GAME_C1_TORSO"))))
		end

		if
			__wf_atom_7e8ad928(object2)
			or __wf_atom_7e8ad928(__wf_atom_6009c8ed)
			or __wf_atom_6009c8ed:__wf_atom_c6f1f83d() < 1
		then
			if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T[v4]) then
				_T[v4].pulling = false
			end

			if not __wf_atom_7e8ad928(beam2) then
				beam2:Destroy()
			end
		else
			local motionControl = object2:MotionControl()

			if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and useCutMechanic then
				__wf_atom_6009c8ed:__wf_atom_921c1a5f(EndAnim, false, 3, 1, true)
			end

			if object2:__wf_atom_8efce136() or gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
				print("Initiating player damage")
				local damageData = Engine.DamageData()
				damageData.baseAmount = 10
				damageData:__wf_atom_7498285f(0, 1)
				damageData:__wf_atom_d6f4d914(17, true)

				if useCutMechanic then
					local v6 = Vector()
					__wf_atom_c37ab6c1(v6, __wf_atom_6009c8ed:__wf_atom_a2a18137(), object2:__wf_atom_a2a18137())
					Normalize(v6)
					damageData:__wf_atom_12cf5317(v6 * 500)
				end

				damageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
				damageData:__wf_atom_34a8a27a(object)
				damageData:__wf_atom_812165c6(0)
				object2:__wf_atom_649bf33e(damageData)
			end

			local v6 = 1
			local v7 = 2.5
			local v8 = false

			while
				__wf_atom_7e8ad928(object2)
				or not object2:__wf_atom_7b82e9e1(12)
				or __wf_atom_7e8ad928(__wf_atom_6009c8ed)
			do
				if not (__wf_atom_7e8ad928(beam2) or __wf_atom_7e8ad928(object2)) then
					beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(v2)))
				end

				v6 -= __wf_atom_084b3e93()

				if v6 < 0 then
					break
				else
					Sleep(0)
				end
			end

			if not __wf_atom_7e8ad928(object2) then
				object2:PlaySound(slideSound, false, 0, true)
			end

			while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
				if not (__wf_atom_7e8ad928(beam2) or __wf_atom_7e8ad928(object2)) then
					beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(v2)))
				end

				if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_6009c8ed)) then
					if not __wf_atom_7e8ad928(motionControl) then
						local v9 = object2:GetPosition() - __wf_atom_6009c8ed:GetPosition()
						Normalize(v9)
						motionControl:__wf_atom_0d3a9295(10)
						motionControl:__wf_atom_2b8da3d2(Vector() - v9 * 10)
					end

					if not v8 and v7 < 2.5 and not __wf_atom_7e8ad928(VictimStruggleAnim) then
						object2:__wf_atom_921c1a5f(VictimStruggleAnim, false, 2, 2, true)
						v8 = true
					end

					if object2:__wf_atom_8a6b8fc3(__wf_atom_6009c8ed) < 2.5 or v7 < 0 then
						break
					end
				end

				Sleep(0)
				v7 -= __wf_atom_084b3e93()
			end

			if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(motionControl)) then
				motionControl:__wf_atom_2b8da3d2(Vector())
				motionControl:__wf_atom_48af5046()
				motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
			end

			if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled() or useCutMechanic) then
				__wf_atom_6009c8ed:__wf_atom_8914dfde(
					"EndPull",
					__wf_atom_6009c8ed:__wf_atom_921c1a5f(EndAnim, false, 3, 1, true)
				)
			end

			if not (__wf_atom_7e8ad928(VictimStruggleAnim) or __wf_atom_7e8ad928(object2)) then
				object2:__wf_atom_921c1a5f(nil, false, 3, 2, true)
			end

			if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
				__wf_atom_6009c8ed:PlaySound(soundDetach, false, 0, true)
			end

			if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T[v4]) then
				_T[v4].pulling = false
			end

			if not __wf_atom_7e8ad928(v5) then
				v5:Destroy()
			end
		end
	end
end

function OnEmbedPullTo(instance)
	local __wf_atom_7be51ede = instance:__wf_atom_7be51ede()
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local v4 = fn(__wf_atom_7be51ede) -- inferred equivalent call
		local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not (__wf_atom_7e8ad928(_T[v4]) or __wf_atom_7e8ad928(__wf_atom_e55d02aa)) then
			local target = _T[v4].target

			if
				not __wf_atom_7e8ad928(target)
				and (target:__wf_atom_8efce136() or gRegion:IsMaster() and not target:__wf_atom_535d5cbb())
			then
				local secondaryScriptArgs = SF.SecondaryScriptArgs(true)

				if
					not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
					and __wf_atom_3d96ddcd == target
					and not (__wf_atom_7be51ede:IsKilled() or canBeBlocked and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(26))
					and not (canBeDodged and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(4))
				then
					secondaryScriptArgs:__wf_atom_a17e41c6(__wf_atom_3d96ddcd)
				end

				__wf_atom_e55d02aa:ActivateSecondaryScript(abilityType, Symbol("PullTo"), secondaryScriptArgs)
			end
		end
	end

	instance:Destroy()
end

function PullTo(object, _, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local v4 = fn(__wf_atom_6009c8ed) -- inferred equivalent call

	if __wf_atom_7e8ad928(_T[v4]) then
		return
	end

	local beam = _T[v4].beam
	_T[v4].pulling = true

	if __wf_atom_7e8ad928(object2) then
		Sleep(0)

		if not __wf_atom_7e8ad928(_T[v4]) then
			_T[v4].pulling = false
		end
	else
		if not __wf_atom_7e8ad928(chargeFx) then
			__wf_atom_6009c8ed:Attach(chargeFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		end

		if not __wf_atom_7e8ad928(beam) then
			beam:Destroy()
		end

		local beam2 = __wf_atom_6009c8ed:Attach(beamType, Hand)
		_T[v4].beam = beam2

		if not __wf_atom_7e8ad928(beam2) then
			beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(v2)))
		end

		__wf_atom_6009c8ed:__wf_atom_9b5dcd3b(LoopAnim, false, 2, 2, false)

		if not __wf_atom_7e8ad928(object2) then
			object2:PlaySound(slideSound, false, 0, true)
		end

		local v5 = 2.5
		local motionControl = __wf_atom_6009c8ed:MotionControl()
		local position = __wf_atom_6009c8ed:GetPosition()
		local v6 = position - object2:GetPosition()
		local v7 = 0
		local v8 = nil
		local v9 = Vector()
		local v10 = Vector()
		local v11 = false
		local v12

		if object2:__wf_atom_8efce136() or gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
			v12 = Engine.DamageData()
			v12:__wf_atom_7498285f(5, 1)
			v12:__wf_atom_d6f4d914(5, true)
			v12:__wf_atom_6b472125(__wf_atom_6009c8ed)
			v12:__wf_atom_34a8a27a(object)
			v12:__wf_atom_812165c6(0)
		end

		while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
			if not __wf_atom_7e8ad928(beam2) then
				beam2:__wf_atom_a64eca67((object2:__wf_atom_1c374cc9(v2)))
			end

			if v12 then
				v11 = v11 or __wf_atom_6009c8ed:__wf_atom_c215662d(position) > 0

				if v11 then
					v7 -= __wf_atom_084b3e93()
					local total = 0

					while v7 <= 0 do
						total += 60
						v7 += 0.1
					end

					if total > 0 then
						v12.baseAmount = total
						object2:__wf_atom_649bf33e(v12)
					end
				end
			end

			object2:__wf_atom_c5f1c61a(v9)
			__wf_atom_6009c8ed:__wf_atom_c5f1c61a(v10)
			v6 = v9 - v10
			Normalize(v6)
			local v13 = __wf_atom_fa8d0177(v10, v9)
			motionControl:__wf_atom_4bb21efc(v6 * 30, true)
			__wf_atom_6009c8ed:__wf_atom_84d66e8e(v13)
			v8 = __wf_atom_6009c8ed:__wf_atom_8a6b8fc3(object2)

			if v8 < 1 or v5 < 0 then
				break
			end

			Sleep(0)
			v5 -= __wf_atom_084b3e93()
		end

		if not __wf_atom_7e8ad928(v8) and v8 < 1 then
			if
				not __wf_atom_7e8ad928(object2)
				and (object2:__wf_atom_8efce136() or gRegion:IsMaster() and not object2:__wf_atom_535d5cbb())
			then
				local damageData = Engine.DamageData()
				damageData.baseAmount = 60
				damageData:__wf_atom_7498285f(0, 1)
				damageData:__wf_atom_d6f4d914(19, true)
				damageData:__wf_atom_d6f4d914(5, true)
				damageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
				damageData:__wf_atom_34a8a27a(object)
				damageData:__wf_atom_812165c6(0)
				object2:__wf_atom_649bf33e(damageData)
			end

			if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(kickFx)) then
				v6.y = 0
				gRegion:CreateEntity(
					kickFx,
					__wf_atom_6009c8ed:GetPosition(),
					__wf_atom_fa8d0177(v6, __wf_atom_28d5d4aa),
					object
				)
			end
		end

		if not __wf_atom_7e8ad928(motionControl) then
			motionControl:__wf_atom_2b8da3d2(__wf_atom_28d5d4aa)
			motionControl:__wf_atom_48af5046()
			motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		end

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			__wf_atom_6009c8ed:__wf_atom_8914dfde(
				"EndPull",
				__wf_atom_6009c8ed:__wf_atom_921c1a5f(EndAnim, false, 3, 1, true)
			)

			if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
				__wf_atom_6009c8ed:PlaySound(soundDetach, false, 0, true)
			end
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T[v4]) then
			_T[v4].pulling = false
		end
	end
end

function DeactivateAbility(_, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not object:IsKilled() then
		object:__wf_atom_921c1a5f(nil, false, 2, 1, false)
	end

	local v4 = fn(object) -- inferred equivalent call

	if _T[v4] == nil then
		return
	end

	if not __wf_atom_7e8ad928(_T[v4].proj) then
		_T[v4].proj:Destroy()
	end

	if not __wf_atom_7e8ad928(_T[v4].beam) then
		_T[v4].beam:Destroy()
		object:PlaySound(soundDetach, false, 0, true)
	end

	if clearTargetDataOnDeactivation then
		_T[v4] = nil
	end
end

function HookToTarget(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v4 = fn(creator) -- inferred equivalent call

	if __wf_atom_7e8ad928(_T[v4]) or __wf_atom_7e8ad928(_T[v4].target) then
		_T[v4] = nil
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(tetherType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:__wf_atom_e3b0f25a(_T[v4].target)
	end

	_T[v4] = nil
end