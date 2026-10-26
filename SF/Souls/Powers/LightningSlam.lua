require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget <= abilityCheckDistance
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

function ActivateAbility(p, object, object2)
	if gRegion:IsMaster() then
		object:__wf_atom_30e3d82b():__wf_atom_c3393b16(50, 50, 360, 90)
		object:__wf_atom_d2b2176d():AddUpgrade(169, 4, 0)
	end

	if __wf_atom_7e8ad928(object2) then
		object2 = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(leapAttachFX) then
		object:Attach(leapAttachFX, EMPTY_SYMBOL)
	end

	object:__wf_atom_9b5dcd3b(prepareLeapAnim, true, 4, 1, false)
	local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(startLeapAnim, false, 4, 1, false)
	local v = startLeapAnim:__wf_atom_091354f5(Symbol("Takeoff")) * __wf_atom_9b5dcd3b
	Sleep(v)

	if not __wf_atom_7e8ad928(landingGroundFX) then
		gRegion:CreateEntity(leapJumpFX, object:GetPosition(), object:__wf_atom_dc309f8a())
	end

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
	Sleep(__wf_atom_9b5dcd3b - v)
	local v2 = __wf_atom_5784a397(abilityTelegraphTime.minValue, abilityTelegraphTime.maxValue)
	object:__wf_atom_9b5dcd3b(leapApexAnim, false, 4, 2, false)
	object:SetVisibility(false, false)
	local v3 = 0.1
	local v4, v5, v6

	if __wf_atom_7e8ad928(targetIndicatorDecoFX) or __wf_atom_7e8ad928(object2) then
		v4 = v2
	else
		v5 = gRegion:CreateEntity(targetIndicatorDecoFX, object2:GetPosition(), __wf_atom_80368bb1)
		v6 = gRegion:CreateEntity(targetIndicatorDecoFX, object2:GetPosition(), __wf_atom_80368bb1)
		v5:__wf_atom_8f04e01e(0)
		v6:__wf_atom_8f04e01e(1)
		v4 = v2
	end

	while v4 > 0 and not __wf_atom_7e8ad928(object2) do
		if drawLandingAreaDebug then
			v3 = __wf_atom_104bfe98(8, v3, v4 / v2)
			gRegion:__wf_atom_b5c21154(
				object2:GetPosition() + Vector(0, 0.5, 0),
				0.1,
				Color(255, 255, 255, 255),
				Rotation(0, 90, 0),
				__wf_atom_03df4e1d()
			)
			gRegion:__wf_atom_b5c21154(
				object2:GetPosition() + Vector(0, 0.5, 0),
				v3,
				Color(255, 0, 0),
				Rotation(0, 90, 0),
				__wf_atom_03df4e1d()
			)
		end

		if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v6)) then
			v5:SetPosition(object2:GetPosition() + Vector(0, -0.5, 0))
			v6:SetPosition(object2:GetPosition() + Vector(0, -0.5, 0))
			v5:__wf_atom_8f04e01e((v2 - v4) / v2)
		end

		v4 -= __wf_atom_03df4e1d()
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v6)) then
		v5:PlayTriggeredFade()
		v6:PlayTriggeredFade()
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

	local position

	if __wf_atom_7e8ad928(object2) then
		position = object:GetPosition()
	else
		position = object2:GetPosition()
	end

	Sleep(abilityLandingTimeAfterTelegraph)
	local v7 = __wf_atom_fa8d0177(object:GetPosition(), position)
	object:SetVisibility(true, false)
	object:__wf_atom_3c986cd9(position, v7)
	local __wf_atom_9b5dcd3b2 = object:__wf_atom_9b5dcd3b(landLeapAnim, false, 4, 1, true)
	local v8 = landLeapAnim:__wf_atom_091354f5(Symbol("SkyFall")) * __wf_atom_9b5dcd3b2
	Sleep(v8)
	local radialDamageData2 = Engine.RadialDamageData()
	radialDamageData2.baseAmount = landingDamageBase + landingDamageMod * __wf_atom_68de036a
	radialDamageData2.stabilityDamage = landingStabilityBase + landingStabilityMod * __wf_atom_68de036a
	radialDamageData2.radius = landingDamageRadius
	radialDamageData2.radiusMin = landingDamageRadius * 0.4
	radialDamageData2.fallOff = 1
	radialDamageData2.fallOffMax = 0.2
	radialDamageData2.checkForCover = false
	radialDamageData2:__wf_atom_7498285f(5, 1)
	radialDamageData2:__wf_atom_d6f4d914(31, true)
	radialDamageData2:__wf_atom_98d98d81(position)
	radialDamageData2:__wf_atom_6b472125(object)
	radialDamageData2:__wf_atom_34a8a27a(p)
	gRegion:__wf_atom_f6ec80de(radialDamageData2)

	if not __wf_atom_7e8ad928(landingGroundFX) then
		gRegion:CreateEntity(landingGroundFX, position, __wf_atom_80368bb1)
	end

	if not __wf_atom_7e8ad928(landingImpactFX) then
		gRegion:CreateEntity(landingImpactFX, position, __wf_atom_80368bb1)
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

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:__wf_atom_d2b2176d():RemoveUpgrade(169, 4, 0)
	end
end

function DeactivateAbility(_, _, _) end