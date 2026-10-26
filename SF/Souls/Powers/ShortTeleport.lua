local v = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
local _ = { __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local v2 = Symbol("ShortTeleport")

local function fn(object, p)
	if gRegion:IsMaster() then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		if p then
			__wf_atom_7470861b:__wf_atom_6cbcca8d(v2, 26, 6, 0, 0)
			__wf_atom_7470861b:__wf_atom_77b5f32e(v2)
			__wf_atom_7470861b:__wf_atom_180051f1()

			if not object:__wf_atom_59a15398() then
				object:__wf_atom_4bf24e79()
			end

			object:__wf_atom_dd875cd8(true)
			object:__wf_atom_994cbb44(0, v2)
			object:__wf_atom_e3a5b02f(false)
			object:__wf_atom_8d98f2fc(false, false, false)

			if disablePhysics then
				object:__wf_atom_30964595(false)
				object:__wf_atom_e4df34a5(false)
				object:__wf_atom_0ed81088(false)
				object:SetDisableGravity(true)
			end
		else
			__wf_atom_7470861b:__wf_atom_a8cf605f(v2)
			__wf_atom_7470861b:__wf_atom_9f17ac89(v2)
			__wf_atom_7470861b:__wf_atom_180051f1()

			if object:__wf_atom_59a15398() then
				object:__wf_atom_404d062c()
			end

			object:__wf_atom_a7ee9662(true)
			object:__wf_atom_dd875cd8(false)
			object:__wf_atom_d61b16cd(0, v2)
			object:__wf_atom_e3a5b02f(true)
			object:__wf_atom_8d98f2fc(true, true, true)

			if disablePhysics then
				object:__wf_atom_30964595(true)
				object:__wf_atom_e4df34a5(true)
				object:__wf_atom_0ed81088(true)
				object:SetDisableGravity(false)
			end
		end
	elseif p then
		if not object:__wf_atom_59a15398() then
			object:__wf_atom_4bf24e79()
		end
	elseif object:__wf_atom_59a15398() then
		object:__wf_atom_404d062c()
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return 0
	end

	local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()

	if
		__wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:IsKilled()
		or not (__wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3.sightedBySelf)
	then
		return 0
	end

	if useRangeFromTarget.maxValue > 0 and not useRangeFromTarget:Contains(__wf_atom_9a1e4ed3.distanceToTarget) then
		return 0
	end

	local position = __wf_atom_9a1e4ed3.avatar:GetPosition()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	if backToOwningHint then
		local __wf_atom_76724198 = __wf_atom_30e3d82b:__wf_atom_76724198()

		if __wf_atom_7e8ad928(__wf_atom_76724198) then
			return 0
		end

		local position2 = __wf_atom_76724198:GetPosition()

		if __wf_atom_2202ffb6:__wf_atom_3c37bceb(position2, 10, 0) then
			object:__wf_atom_e638fc23(position2)
			return 1
		end

		return 0
	else
		local v3 = { object2, __wf_atom_9a1e4ed3.avatar }

		if findHintsWithTag ~= EMPTY_SYMBOL then
			local position2 = object2:GetPosition()

			if findHintsFromTarget and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
				position2 = __wf_atom_9a1e4ed3.avatar:GetPosition()
			end

			local v4 = gRegion:__wf_atom_439c0d29(
					findHintsWithTag,
					position2,
					findHintsRange.minValue,
					findHintsRange.maxValue
				)
				or {}
			local shuffleTable = module2.ShuffleTable(v4)

			for _, v5 in shuffleTable do
				if not (v5:__wf_atom_8a6b8fc3(__wf_atom_9a1e4ed3.avatar) > 5 and v5:__wf_atom_8a6b8fc3(object2) > object2:__wf_atom_8a6b8fc3(__wf_atom_9a1e4ed3.avatar)) then
					continue
				end

				if __wf_atom_2202ffb6:__wf_atom_61f4e310(v5) then
					continue
				end

				local position3 = v5:GetPosition()

				if not (__wf_atom_2202ffb6:__wf_atom_3c37bceb(position3, 4, 0) and __wf_atom_30e3d82b:__wf_atom_da5e11fd(position3)) then
					continue
				end

				object:__wf_atom_e638fc23(position3)
				object2:__wf_atom_4509f563(findHintsWithTag, v5)
				return 1
			end
		end

		local v4 = math.rad(__wf_atom_9a1e4ed3.avatar:__wf_atom_4e50d390().heading + Random(
			angleOffsetFromTargetView.minValue,
			angleOffsetFromTargetView.maxValue
		))
		local v5 = 6.283185307179586 / numPosChecks

		for _ = 1, numPosChecks do
			local __wf_atom_ff1686f2 = desiredRangeFromTarget:__wf_atom_ff1686f2()
			local v6 = position + Vector(__wf_atom_ff1686f2 * math.sin(v4), 0, __wf_atom_ff1686f2 * math.cos(v4))

			if __wf_atom_2202ffb6:__wf_atom_3c37bceb(v6, 4, 0) then
				local v7 = Vector()

				if not __wf_atom_7e8ad928(gRegion:__wf_atom_fbb89790(
					v6 + groundFinderRaycastOffset,
					v6 - groundFinderRaycastOffset,
					groundFinderSweepRadius,
					v3,
					v,
					nil,
					v7
				)) then
					local v8 = v7 + Vector(0, groundFinderSweepRadius / 2, 0)

					if
						not __wf_atom_2202ffb6:__wf_atom_417a583d(v8, 1, 3, -3)
						or minRangeFromDesiredPosition > 0
						and object2:__wf_atom_c215662d(v8) < minRangeFromDesiredPosition * minRangeFromDesiredPosition
						or not __wf_atom_30e3d82b:__wf_atom_da5e11fd(v8)
					then
						return 0
					end

					object:__wf_atom_e638fc23(v8)
					return 1
				end
			end

			v4 += v5
		end

		return 0
	end
end

local function fn2(p)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v3 = 3.4028234663852886e38

	for _, v4 in pairs(__wf_atom_ef7900cf) do
		if __wf_atom_7e8ad928(v4) or v4:IsKilled() or v4:__wf_atom_bedb4e3f() or v4:__wf_atom_7b82e9e1(7) then
			continue
		end

		local v5 = Distance(v4:__wf_atom_a2a18137(), p)

		if v5 < v3 then
			v3 = v5
		end
	end
end

local function fn3(object, p, p2, p3)
	if gRegion:IsMaster() then
		gRegion:CreateEntity(areaDamageFx, p2, p3, object)
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = areaDamageRadius
		radialDamageData:__wf_atom_98d98d81(p2)
		radialDamageData:__wf_atom_d6f4d914(18, true)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		radialDamageData.checkForCover = false
		radialDamageData.fallOff = areaDamageFalloff
		radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(areaDamage))
		radialDamageData.stabilityDamage = areaDamageStability
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end
end

local function fn4(heading, reappearAngleOffset) -- 3 equivalent calls inferred from this helper
	local v3 = heading + reappearAngleOffset

	if v3 > 360 then
		return v3 - 360
	end

	if v3 < -360 then
		return v3 + 360
	end

	return v3
end

function ActivateAbility(p, object, _, _, p2)
	module.EnableWeaponFiring(object, mOwner, false)
	object:__wf_atom_994cbb44(0, mOwner:__wf_atom_37768748())

	if not __wf_atom_7e8ad928(destinationWarningFx) then
		gRegion:CreateEntity(destinationWarningFx, p2, object:__wf_atom_2f2bada0(), object)
	end

	if not module.PlayAnimAndSuspendUntilEvent(p, activateAnim, activateAnimEvent, false, 4, 1, blockingAnimation) then
		return
	end

	if areaDamageOnDisappear then
		fn3(object, p, object:GetPosition(), object:__wf_atom_2f2bada0())
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_92aa9d91 = __wf_atom_c4f78a8f:__wf_atom_92aa9d91()

		if __wf_atom_92aa9d91:__wf_atom_5d790fbf() == object then
			__wf_atom_92aa9d91:__wf_atom_70c1e444()
		end
	end

	local v3 = nil
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v4 = nil

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
			v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, object:__wf_atom_a06d543c())

			if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
				v4 = __wf_atom_fa8d0177(p2, __wf_atom_9a1e4ed3.avatar:GetPosition())

				if reappearAngleOffset ~= 0 then
					v4.heading = fn4(v4.heading, reappearAngleOffset) -- inferred equivalent call
				end
			end

			v4.pitch = 0
			v4.bank = 0
			object:Teleport(p2, v4)
		end
	end

	if disappearanceDurationDuringTeleport > 0 then
		gRegion:CreateEntity(teleportOutFX, __wf_atom_a2a18137, object:__wf_atom_2f2bada0(), object)
		fn(object, true)
		object:__wf_atom_921c1a5f(nil, false, 2, 1, false)
		v3 = gRegion:CreateEntity(trailToDestinationFx, __wf_atom_a2a18137, object:__wf_atom_2f2bada0(), object)

		if __wf_atom_7e8ad928(v3) then
			Sleep(disappearanceDurationDuringTeleport)
		else
			local total = 0
			local v5 = p2 - __wf_atom_a2a18137
			local v6 = math.random() < 0.5
			local v7 = math.random() * 0.4 + 0.4

			if v6 then
				v7 *= -1
			end

			local v8 = __wf_atom_edfe0d73(v5, Vector(0, 1, 0)) * v7
			v8.y = 0

			while total <= disappearanceDurationDuringTeleport do
				Sleep(0)
				total += __wf_atom_084b3e93()
				local v9 = math.min(1, total / disappearanceDurationDuringTeleport)
				local v10 = v8 * math.sin(3.141592653589793 * v9)
				v3:SetPosition(__wf_atom_a2a18137 + v5 * v9 + v10)
			end
		end
	end

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
			v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, object:__wf_atom_a06d543c())

			if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar) then
				local v5 = fn2(object:__wf_atom_a2a18137())

				if not __wf_atom_7e8ad928(v5) then
					v4 = __wf_atom_fa8d0177(p2, v5:GetPosition())

					if reappearAngleOffset ~= 0 then
						v4.heading = fn4(v4.heading, reappearAngleOffset) -- inferred equivalent call
					end
				end
			else
				v4 = __wf_atom_fa8d0177(p2, __wf_atom_9a1e4ed3.avatar:GetPosition())

				if reappearAngleOffset ~= 0 then
					v4.heading = fn4(v4.heading, reappearAngleOffset) -- inferred equivalent call
				end
			end

			v4.pitch = 0
			v4.bank = 0
			object:Teleport(p2, v4)
		end

		local entity = gRegion:CreateEntity(extraFxBeforeReappearing, p2, v4, object)
		_T.reappearFX = entity
		Sleep(extraDisappearTimeBeforeReappearing)

		if object:__wf_atom_03270b83() then
			object:__wf_atom_3c986cd9(p2, v4)
		end
	else
		Sleep(extraDisappearTimeBeforeReappearing)
	end

	module.PlayAnim(p, reappearAnim, false, 4, 1, true)

	if not __wf_atom_7e8ad928(reappearSound) then
		object:PlaySound(reappearSound, false)
	end

	if becomeVisibleAnimEvent ~= "" then
		object:__wf_atom_8914dfde(becomeVisibleAnimEvent, 0.5)
	end

	if not __wf_atom_7e8ad928(v3) then
		gRegion:__wf_atom_dd1e4d10(v3)
	end

	if not __wf_atom_7e8ad928(_T.reappearFX) then
		_T.reappearFX:Destroy()
	end

	fn(object, false)

	if reappearAnimEventForAreaDamage ~= "" then
		object:__wf_atom_8914dfde(reappearAnimEventForAreaDamage, 2)
	end

	fn3(object, p, p2, v4)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(reappearAnim) do
		Sleep(0.1)
	end
end

function DeactivateAbility(_, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not object:__wf_atom_c138b19b(reappearAnim, true) then
		object:__wf_atom_2f91774e()
	end

	module.EnableWeaponFiring(object, mOwner, true)
	object:__wf_atom_d61b16cd(0, mOwner:__wf_atom_37768748())
end