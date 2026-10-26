require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget >= abilityCheckDistance
	then
		local abilityCheckDistanceTime = abilityCheckDistanceTime

		while
			not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
			and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
			and abilityCheckDistanceTime > 0
			and __wf_atom_9a1e4ed3.distanceToTarget <= abilityCheckDistance
		do
			abilityCheckDistanceTime -= __wf_atom_084b3e93()

			if abilityCheckDistanceTime <= 0 then
				object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
				return 1
			else
				Sleep(0)
			end
		end
	end

	return 0
end

local function fn(object, object2, p)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local v = math.rad((__wf_atom_5784a397(-10, 10)))
	local __wf_atom_dc309f8a = object2:__wf_atom_dc309f8a()
	local cameraControl = object2:CameraControl()

	if not __wf_atom_7e8ad928(cameraControl) then
		__wf_atom_dc309f8a = cameraControl:__wf_atom_9d937e7e()
	end

	local v2 = __wf_atom_9341614d(
		Vector(landingDistanceFromPlayer * math.sin(v), 0, landingDistanceFromPlayer * math.cos(v)),
		__wf_atom_dc309f8a
	)
	local v3 = object2:GetPosition() + v2
	local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v3)
	local v4 = object:__wf_atom_a5304c35(__wf_atom_0e0a6fee) / 3
	local v5 = object:GetPosition() - object2:GetPosition()
	Normalize(v5)

	if not p then
		local v6 = v5 * v4
		__wf_atom_0e0a6fee = object:GetPosition() - v6
	end

	return __wf_atom_0e0a6fee, (__wf_atom_fa8d0177(object:GetPosition(), object2:GetPosition()))
end

function ActivateAbility(p, object, object2)
	local count = 0

	if gRegion:IsMaster() then
		object:__wf_atom_30e3d82b():__wf_atom_c3393b16(50, 50, 360, 90)
		object:__wf_atom_d2b2176d():AddUpgrade(169, 4, 0)
	end

	while count <= 0 do
		if __wf_atom_7e8ad928(object2) then
			object2 = gRegion:__wf_atom_c4f78a8f()
		end

		if not __wf_atom_7e8ad928(leapAttachFxType) then
			object:Attach(leapAttachFxType, EMPTY_SYMBOL)
		end

		local v, v2 = fn(object, object2, false)
		object:__wf_atom_3c986cd9(v, v2)
		local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(startLeapAnim, false, 4, 1, false)
		local v3 = startLeapAnim:__wf_atom_091354f5(Symbol("Takeoff")) * __wf_atom_9b5dcd3b
		Sleep(v3)
		local __wf_atom_68de036a = object:__wf_atom_68de036a()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = jumpDamageBase + jumpDamageMod * __wf_atom_68de036a
		radialDamageData.stabilityDamage = jumpStabilityBase + jumpStabilityMod * __wf_atom_68de036a
		radialDamageData.radius = jumpDamageRadius
		radialDamageData.fallOff = 1
		radialDamageData.radiusMin = jumpDamageRadius * 0.2
		radialDamageData.fallOff = 1
		radialDamageData.fallOffMax = 0.1
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_d6f4d914(0, true)
		radialDamageData:__wf_atom_7498285f(5, 1)
		radialDamageData:__wf_atom_98d98d81(object:GetPosition())
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		gRegion:__wf_atom_f6ec80de(radialDamageData)

		while object:__wf_atom_c138b19b(startLeapAnim) do
			Sleep(0)
		end

		local v4, v5 = fn(object, object2, false)
		object:__wf_atom_3c986cd9(v4, v5)
		local __wf_atom_9b5dcd3b2 = object:__wf_atom_9b5dcd3b(leapApexAnim, false, 4, 1, false)

		if invisAtApex then
			object:SetVisibility(false, false)
		end

		local v6 = 0.1
		local v7, v8, v9

		if __wf_atom_7e8ad928(targetFxType) or __wf_atom_7e8ad928(rangeFxType) or __wf_atom_7e8ad928(object2) then
			v7 = __wf_atom_9b5dcd3b2
		else
			v8 = gRegion:CreateEntity(targetFxType, object2:GetPosition(), __wf_atom_80368bb1)
			v9 = gRegion:CreateEntity(rangeFxType, object2:GetPosition(), __wf_atom_80368bb1)
			v7 = __wf_atom_9b5dcd3b2
		end

		while v7 > 0.5 and not __wf_atom_7e8ad928(object2) or object:__wf_atom_c138b19b(leapApexAnim) do
			if drawLandingAreaDebug then
				v6 = __wf_atom_104bfe98(8, v6, v7 / __wf_atom_9b5dcd3b2)
				gRegion:__wf_atom_b5c21154(
					object2:GetPosition() + Vector(0, 0.5, 0),
					0.1,
					Color(255, 255, 255, 255),
					Rotation(0, 90, 0),
					__wf_atom_03df4e1d()
				)
				gRegion:__wf_atom_b5c21154(
					object2:GetPosition() + Vector(0, 0.5, 0),
					v6,
					Color(255, 0, 0),
					Rotation(0, 90, 0),
					__wf_atom_03df4e1d()
				)
			end

			if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v9)) then
				v8:SetPosition(object2:GetPosition())
				v9:SetPosition(object2:GetPosition())
				v8:__wf_atom_8f04e01e((__wf_atom_9b5dcd3b2 - v7) / __wf_atom_9b5dcd3b2)
			end

			v7 -= __wf_atom_03df4e1d()
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:PlayTriggeredFade()
		end

		if not __wf_atom_7e8ad928(v9) then
			v9:PlayTriggeredFade()
		end

		if drawLandingAreaDebug then
			gRegion:__wf_atom_b5c21154(
				object2:GetPosition() + Vector(0, 0.5, 0),
				0.1,
				Color(255, 255, 255, 255),
				Rotation(0, 90, 0),
				1.5
			)
			gRegion:__wf_atom_b5c21154(
				object2:GetPosition() + Vector(0, 0.5, 0),
				8,
				Color(255, 0, 0),
				Rotation(0, 90, 0),
				1.5
			)
		end

		if invisAtApex then
			object:SetVisibility(true, false)
		end

		local v10, v11 = fn(object, object2, true)
		object:__wf_atom_3c986cd9(v10, v11)
		local v12 = v10 + __wf_atom_9341614d(Vector(0, 0, 2.5), v11)
		local __wf_atom_9b5dcd3b3 = object:__wf_atom_9b5dcd3b(landLeapAnim, false, 4, 1, true)
		local v13 = landLeapAnim:__wf_atom_091354f5(Symbol("SkyFall")) * __wf_atom_9b5dcd3b3
		Sleep(v13)
		local radialDamageData2 = Engine.RadialDamageData()
		radialDamageData2.baseAmount = landingDamageBase + landingDamageMod * __wf_atom_68de036a
		radialDamageData2.stabilityDamage = landingStabilityBase + landingStabilityMod * __wf_atom_68de036a
		radialDamageData2.radius = landingDamageRadius
		radialDamageData2.radiusMin = landingDamageRadius * 0.4
		radialDamageData2.fallOff = 1
		radialDamageData2.fallOffMax = 0.2
		radialDamageData2.checkForCover = false
		radialDamageData2:__wf_atom_7498285f(5, 1)
		radialDamageData2:__wf_atom_98d98d81(v12)
		radialDamageData2:__wf_atom_6b472125(object)
		radialDamageData2:__wf_atom_34a8a27a(p)
		gRegion:__wf_atom_f6ec80de(radialDamageData2)

		if drawLandingAreaDebug then
			gRegion:__wf_atom_8d991675(v12, 0.1, Color(255, 0, 0), 1)
		end

		if not __wf_atom_7e8ad928(landingImpactSound) then
			object:PlaySound(landingImpactSound, false, 1, false)
		end

		if not __wf_atom_7e8ad928(leapImpactFxType) then
			gRegion:CreateEntity(leapImpactFxType, object:GetPosition(), __wf_atom_80368bb1)
		end

		if gRegion:IsMaster() then
			object:__wf_atom_30e3d82b():__wf_atom_c3393b16(50, 50, 120, 90)
		end

		Sleep(0.1)

		if not __wf_atom_7e8ad928(landLeapAnim) then
			while object:__wf_atom_c138b19b(landLeapAnim) do
				Sleep(0.1)
			end
		end

		count += 1
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:__wf_atom_d2b2176d():RemoveUpgrade(169, 4, 0)
	end
end

function DeactivateAbility(_, _, _) end