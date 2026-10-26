local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 0
ignoreTargetsTypes = {}
local v2 = true
local total = 0
local flag = true
local v3 = false
local garrenLightAttachement = nil
local color = nil
local v4 = false
local v5 = {
	{ tag = Symbol("PunctInvulnerable"), dmgType = 1 },
	{ tag = Symbol("ImpactInvulnerable"), dmgType = 0 },
	{ tag = Symbol("SlashInvulnerable"), dmgType = 2 }
}

function NpcEvaluateAbility(object, object2)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local total2 = 0

	for i = 1, #__wf_atom_d8853f2a do
		local v6 = __wf_atom_d8853f2a[i]

		if not (v6.visible and v6:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v6.distanceToTarget

		if not (minNpcRange <= distanceToTarget and distanceToTarget <= npcMaxRange and v6.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		total2 += (1 - distanceToTarget / npcMaxRange) / #__wf_atom_d8853f2a
		object:__wf_atom_f7170fc9(v6.avatar)
	end

	return total2
end

local function fn(object)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if not __wf_atom_be0bea4a[i]:HasTag(Symbol("GarrenLight")) then
			continue
		end

		garrenLightAttachement = __wf_atom_be0bea4a[i]
		break
	end
end

local function fn2(object)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	for _, v6 in pairs(v5) do
		__wf_atom_7470861b:__wf_atom_9fba31e6(v6.tag, v6.dmgType, 6, 0)
	end
end

local function fn3(entity, object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(entity) then
		return
	end

	local v6 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), entity:__wf_atom_a2a18137())
	v6.pitch = 0
	v6.bank = 0
	return v6
end

function ActivateAbility(p, object, entity)
	if gRegion:IsMaster() then
		object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	end

	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	if __wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = chargeVelocityMult * object:__wf_atom_c082fc3d()
	fn(object)
	fn2(object)

	if not __wf_atom_7e8ad928(garrenLightAttachement) then
		color = garrenLightAttachement:GetColor()
	end

	local v7 = { garrenLightAttachement = garrenLightAttachement, lightStartColour = color }
	module.SetAbilityStats(p, mOwner, v7)
	local motionControl = object:MotionControl()
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_0e1e5bc9 = object:__wf_atom_0e1e5bc9()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(chargeStart, false, 4, 3, true)
	local v8 = chargeStart:__wf_atom_091354f5(Symbol("StartRotation")) * __wf_atom_9b5dcd3b
	local __wf_atom_091354f5 = chargeStart:__wf_atom_091354f5(Symbol("StopRotation"))
	local v9 = __wf_atom_091354f5 - v8
	local total2 = 0
	local total3 = 0

	while total2 < __wf_atom_9b5dcd3b do
		if v3 == true then
			object:__wf_atom_9b5dcd3b(chargeStumble, true, 4, 1, true)
			break
		end

		if v8 < total2 and total2 < __wf_atom_091354f5 then
			if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(entity)) then
				local v10 = fn3(entity, object) -- inferred equivalent call
				local v11 = __wf_atom_9d2f097a(__wf_atom_0e1e5bc9, v10, total3 / v9)
				object:__wf_atom_51075230(v11)
				object:__wf_atom_84d66e8e(v11)
				object:Teleport(object:GetPosition(), v11, false)
			end

			total3 += __wf_atom_084b3e93()
		end

		Sleep(0)
		total2 += __wf_atom_084b3e93()
	end

	if __wf_atom_7e8ad928(entity) then
		return
	end

	v = Distance(
		object:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL")),
		Vector(entity:__wf_atom_a2a18137().x, object:__wf_atom_a2a18137().y, entity:__wf_atom_a2a18137().z)
	)
	local v10 = v + chargeMisDistnace
	motionControl:__wf_atom_0d3a9295(500)
	local position = object:GetPosition()
	local v11 = Vector(0, 0, 0)
	local _distanceToTarget = entity.distanceToTarget
	local __wf_atom_0e1e5bc9_2 = object:__wf_atom_0e1e5bc9()
	flag = true
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL"))
	local v12 = __wf_atom_e97f3142(__wf_atom_0e1e5bc9_2)
	motionControl:__wf_atom_3a1d0c16(__wf_atom_0e1e5bc9_2)
	motionControl:__wf_atom_4bb21efc(v12 * v6)
	object:__wf_atom_921c1a5f(chargeLoop, false, 2, 2, true)
	Sleep(0)
	local total4 = 0
	local v13 = false
	local v14 = false

	while flag and not __wf_atom_7e8ad928(entity) do
		local position2 = object:GetPosition()
		local v15 = Distance(position, position2)
		local v16 = Distance(
			object:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL")),
			Vector(entity:__wf_atom_a2a18137().x, object:__wf_atom_a2a18137().y, entity:__wf_atom_a2a18137().z)
		)

		if total4 > 0.2 and CheckIfStuck(object, v11, position2) then
			flag = false
			object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
			object:__wf_atom_921c1a5f(chargeFail, true, 4, 1, true)
			break
		elseif v4 == true then
			flag = false
			object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
			object:__wf_atom_921c1a5f(chargeCrash, true, 4, 1, true)
			break
		elseif v10 < v15 or maxChargeDistance < v15 and not v13 then
			object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
			object:__wf_atom_921c1a5f(chargeSlamMiss, true, 4, 1, true)
			flag = false
			break
		else
			if v16 <= trackingEndDistance and v2 then
				v12 = object:__wf_atom_a06d543c()
				v2 = false
			elseif v2 and not __wf_atom_7e8ad928(entity) and entity:IsVisible() then
				local v17 = __wf_atom_e97f3142(GetChargeDirectionFromTarget(entity, object))
				v12 = __wf_atom_a1467d4b(
					object:__wf_atom_a06d543c(),
					v17,
					targetTrackingTurnRate * __wf_atom_084b3e93()
				)
				local v18 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v12)
				object:MotionControl():__wf_atom_3a1d0c16(v18)
				object:__wf_atom_51075230(v18)
				object:__wf_atom_84d66e8e(v18)

				if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
					__wf_atom_30e3d82b:__wf_atom_6fd98d44(__wf_atom_28d5d4aa, v18, __wf_atom_28d5d4aa)
				end
			end

			motionControl:__wf_atom_4bb21efc(v12 * v6)

			if v16 <= trackingEndTell and v14 == false and not __wf_atom_7e8ad928(garrenLightAttachement) then
				garrenLightAttachement:SetColor(trackingFinishedColour)
				v14 = true
			end

			local __wf_atom_1c374cc9_2 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL"))

			if damageDebug then
				gRegion:__wf_atom_8d991675(__wf_atom_1c374cc9_2, slamHitRadius, damageDebugAreaColour, 1)
			end

			local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(
				__wf_atom_1c374cc9,
				__wf_atom_1c374cc9_2,
				slamHitRadius,
				acceptedTargetsTypes,
				nil
			)

			if not (__wf_atom_7e8ad928(__wf_atom_4ea726bc) or __wf_atom_4ea726bc[1]:__wf_atom_7470861b():__wf_atom_246e3020()) then
				object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
				DoFinisher(__wf_atom_4ea726bc[1], object)
				flag = false
			end

			total4 += __wf_atom_084b3e93()
			Sleep(0)
			__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
			v11 = position2
		end
	end
end

function GetSlamTarget(_, list)
	if not __wf_atom_7e8ad928(list) then
		for i = 1, list do
			if list[i] == gRegion:__wf_atom_c4f78a8f() then
				return list[i]
			end
		end
	end

	return nil
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928((mOwner:__wf_atom_c78fa517())) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if object:IsFrozenSolid(1) or object:IsFrozenSolid(0) or object:IsFrozenSolid(2) then
		v3 = true
		return
	end

	if not (__wf_atom_9d766292:__wf_atom_78650070(19) or __wf_atom_9d766292:__wf_atom_78650070(17)) then
		return
	end

	if flag then
		v4 = true
	else
		v3 = true
	end
end

function DoFinisher(object, object2)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		object2:__wf_atom_921c1a5f(chargeFail, false, 4, 1, false)
	elseif __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		object2:__wf_atom_921c1a5f(chargeSlamMiss, true, 4, 1, true)
		local __wf_atom_7470861b = object2:__wf_atom_7470861b()

		for _, v6 in pairs(v5) do
			__wf_atom_7470861b:__wf_atom_63396172(v6.tag)
		end
	else
		if gRegion:IsMaster() and not __wf_atom_7e8ad928(chargeSlamFinisher) then
			object2:__wf_atom_70ca09b9(chargeSlamFinisher, object)
		end

		local total2 = 0

		while not object2:__wf_atom_611b620c() and total2 < 7 do
			total2 += __wf_atom_084b3e93()
			Sleep(0)
		end

		local total3 = 0

		while object2:__wf_atom_611b620c() and total3 < 7 do
			total3 += __wf_atom_084b3e93()
			Sleep(0)
		end

		local __wf_atom_7470861b = object2:__wf_atom_7470861b()

		for _, v6 in pairs(v5) do
			__wf_atom_7470861b:__wf_atom_63396172(v6.tag)
		end
	end
end

function GetChargeDirectionFromTarget(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = __wf_atom_fa8d0177(object2:__wf_atom_a2a18137(), object:__wf_atom_a2a18137())
	v6.pitch = 0
	v6.bank = 0
	return v6
end

function CheckIfStuck(p, p2, p3)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	if math.pow(__wf_atom_a93b9922(p2, p3) / __wf_atom_084b3e93(), 2) < 1 then
		total += __wf_atom_084b3e93()

		if total >= 0.005 then
			return true
		end
	else
		total = 0
	end

	return false
end

function DeactivateAbility(p, object, _, _)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if not (__wf_atom_7e8ad928(abilityStats) or __wf_atom_7e8ad928(abilityStats.garrenLightAttachement) or __wf_atom_7e8ad928(abilityStats.lightStartColour)) then
		abilityStats.garrenLightAttachement:SetColor(abilityStats.lightStartColour)
	end

	if gRegion:IsMaster() then
		object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		for _, v6 in pairs(v5) do
			__wf_atom_7470861b:__wf_atom_63396172(v6.tag)
		end
	end

	object:MotionControl():__wf_atom_3959d938(false)
end

function SecondSlamHit()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenRood"))
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = secondSlamRadius
	radialDamageData.fallOff = secondSlamFalloff
	radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(secondSlamDamage))
	radialDamageData:__wf_atom_6b472125(__wf_atom_0a6a5887)
	radialDamageData:__wf_atom_12cf5317(1)
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData:__wf_atom_98d98d81(__wf_atom_0a6a5887:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL")))

	if damageDebug then
		gRegion:__wf_atom_8d991675(
			__wf_atom_0a6a5887:__wf_atom_1c374cc9(Symbol("GAME_C1_INSIDE_BELL")),
			secondSlamRadius,
			damageDebugAreaColour,
			10
		)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)
end