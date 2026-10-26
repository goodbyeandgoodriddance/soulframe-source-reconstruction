local v = Symbol("FLARE_SINECURE_REINFORCEMENT")
local __wf_atom_1bb5b1ffs = { WeakResource("/SF/Types/Game/SFNpcAvatar"), __wf_atom_7b01f9ce }
local v2 = WeakResource("/EE/Types/Engine/SimpleBlockingVolume")
local v3 = WeakResource("/EE/Types/Navigation/AvoidanceVolumeEntity")
local flag = false
local v4 = Symbol("InteruptDamage")
local v5 = Symbol("POIChopTreeDeco")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")

local function fn(object, contextActionTag)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(contextActionTag, object:GetPosition(), 0, 5)
	local v6

	if #__wf_atom_439c0d29 > 0 then
		v6 = __wf_atom_439c0d29[1]
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(v6) then
		__wf_atom_30e3d82b:UseContextAction(v6, true)
	end

	return v6
end

local function fn2(object)
	object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(propToDropBone)
	local __wf_atom_8e4cf043 = object:__wf_atom_8e4cf043(propToDropBone)
	local v6 = __wf_atom_1c374cc9 + __wf_atom_9341614d(propToDropOffset, __wf_atom_dc309f8a)
	gRegion:CreateEntity(propToDrop, v6, __wf_atom_8e4cf043)
	return propToDrop
end

local function fn3(object)
	local v6 = nil

	if __wf_atom_7e8ad928(object) then
		return v6
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_d2b2176d:__wf_atom_9d6c02e9(4) < 4 then
		local __wf_atom_8e4cf043 = object:__wf_atom_8e4cf043(pickUpBone)
		local v7 = object:__wf_atom_1c374cc9(pickUpBone) + __wf_atom_9341614d(pickUpDecoOffset, __wf_atom_8e4cf043)
		v6 = gRegion:CreateEntity(pickUpPlacedType, v7, __wf_atom_8e4cf043, object)

		if gRegion:IsMaster() then
			object:__wf_atom_78ad8b9f(103, 0)
			__wf_atom_d2b2176d:__wf_atom_6cdc5077()
		end
	end

	return v6
end

local function fn4(object)
	Sleep(delay)

	if not __wf_atom_7e8ad928(object) then
		local creator = object:GetCreator()

		if not __wf_atom_7e8ad928(creator) and creator:IsA(__wf_atom_032e921b) then
			creator:FirePort("Burst")
		end
	end
end

local function fn5(object, object2)
	Sleep(delay)

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_c082fc3d = object2:__wf_atom_c082fc3d()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()

	if math.abs(__wf_atom_dc309f8a.bank) > 11 or math.abs(__wf_atom_dc309f8a.pitch) > 11 then
		object:Disable()
		return
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(leanBackContactBone)
	local position = object:GetPosition()
	local v6 = Vector(position.x, __wf_atom_1c374cc9.y, position.z)
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local v7 = 10 * __wf_atom_a06d543c + v6
	local v8 = Vector()
	gRegion:__wf_atom_c20d246a(v6, v7, __wf_atom_1bb5b1ffs, nil, v8)

	if __wf_atom_7e8ad928(v8) or Distance(v6, v8) > 1.5 then
		object:Disable()
	elseif v8 ~= __wf_atom_28d5d4aa then
		local v9 = Vector(v8.x, position.y, v8.z) - __wf_atom_a06d543c * leanBackContactBoneOffset * __wf_atom_c082fc3d
		local total = 0

		while total < leanBackTime and not (__wf_atom_7e8ad928(object2) or object2:IsKilled()) do
			object2:SetPosition((__wf_atom_f55d6358(
				position,
				v9,
				__wf_atom_24a82b69(__wf_atom_421b01aa(total / leanBackTime, 0, 1))
			)))
			Sleep(0)
			total += __wf_atom_084b3e93()
		end
	end
end

local function fn6(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_1bb5b1ff = object2:__wf_atom_1bb5b1ff()
		table.insert(__wf_atom_1bb5b1ffs, __wf_atom_1bb5b1ff)
	end

	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local v6 = object:GetPosition() + __wf_atom_a06d543c * raycastForwardDepth
	local v7 = Vector()
	gRegion:__wf_atom_c20d246a(v6 + Vector(0, 1, 0), v6 + Vector(0, -1, 0), __wf_atom_1bb5b1ffs, nil, v7)
	Sleep(delay)

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	object2:__wf_atom_1b57cb83(false)
	object2:AttachToInPlace(object, EMPTY_SYMBOL)
	object2:__wf_atom_e310f01f(
		Vector(0, v7.y - object2:GetPosition().y + leanBackContactBoneOffset, 1.75),
		Rotation(180, 0, 0)
	)
end

local function fn7(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_55597fe3 = object:__wf_atom_7470861b():__wf_atom_55597fe3()
	local v6

	if not __wf_atom_7e8ad928(__wf_atom_55597fe3) then
		v6 = __wf_atom_55597fe3:__wf_atom_679ed446()

		if __wf_atom_7e8ad928(v6) then
			v6 = object
		end
	end

	if not v6:IsA(__wf_atom_7e616794) then
		return
	end

	local damageData = Engine.DamageData()
	damageData.baseAmount = 1
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(19, true)
	damageData:__wf_atom_8e0ba0ec(-5)
	damageData:__wf_atom_34a8a27a(v6)
	local __wf_atom_a06d543c = v6:__wf_atom_a06d543c()
	Normalize(__wf_atom_a06d543c)
	damageData:__wf_atom_12cf5317(__wf_atom_a06d543c * 3)
	object:__wf_atom_649bf33e(damageData)
	object:__wf_atom_3ede53b4(v4)
	flag = false
end

local function fn8(object, object2, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local v6, v7, v8

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v7 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(v2)
		v6 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_8b8e8b22)
		v8 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(v3)

		if p and removeOtherChildPois then
			local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_46b5a019)

			for _, v9 in ipairs(__wf_atom_f582136d) do
				if v9 ~= object then
					v9:FirePort("Disable")
				end
			end
		end
	end

	if p then
		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_e06358f3(Symbol("DisableFootIK"))
		end

		if __wf_atom_7e8ad928(v7) then
			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				__wf_atom_3d96ddcd:__wf_atom_0ed81088(false)
			end
		else
			v7:FirePort("Disable")
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:FirePort("Disable")
		end

		Sleep(chairSitAnimDelay)

		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_51cd6126(v4, "OnDamaged")
		end
	end

	while not __wf_atom_7e8ad928(v6) do
		if flag then
			fn7(object2)
		end

		if not v6:__wf_atom_acccc08b() then
			break
		end

		local __wf_atom_6f4fd712 = v6:__wf_atom_6f4fd712()

		for i = #__wf_atom_6f4fd712, 1, -1 do
			local v9 = __wf_atom_6f4fd712[i]

			if __wf_atom_7e8ad928(v9) then
				table.remove(__wf_atom_6f4fd712, i)
			elseif v9:IsKilled() then
				table.remove(__wf_atom_6f4fd712, i)
			end
		end

		if #__wf_atom_6f4fd712 == 0 then
			break
		else
			Sleep(0.1)
		end
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_e06358f3(Symbol("EnableFootIK"))
	end

	if __wf_atom_7e8ad928(v7) then
		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:__wf_atom_0ed81088(true)
		end
	else
		v7:FirePort("Enable")
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:FirePort("Enable")
	end
end

local function fn9(object, object2, p)
	local position = object:GetPosition()
	local v6 = position + object:__wf_atom_a06d543c() * moveToOffset
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v7 = __wf_atom_dc309f8a + moveToRotation
	local total = 0

	while total < p do
		object2:Teleport(
			__wf_atom_f55d6358(position, v6, __wf_atom_24a82b69(__wf_atom_421b01aa(total / p, 0, 1))),
			(__wf_atom_9d2f097a(__wf_atom_dc309f8a, v7, __wf_atom_24a82b69(__wf_atom_421b01aa(total / p, 0, 1))))
		)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

local function fn10(object, object2, p)
	local position = object2:GetPosition()
	local position2 = object:GetPosition()
	object2:__wf_atom_dc309f8a()
	object:__wf_atom_dc309f8a()
	local total = 0

	while total < p do
		object2:SetPosition((__wf_atom_f55d6358(
			position,
			position2,
			__wf_atom_24a82b69(__wf_atom_421b01aa(total / p, 0, 1))
		)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

local function fn11(object)
	if object:__wf_atom_04ea4887() then
		local __wf_atom_e55d02aa = object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			object:__wf_atom_11d3ea0f(v, Time())
			local __wf_atom_9a1e4ed3 = object:__wf_atom_9a1e4ed3()

			if not (__wf_atom_7e8ad928(__wf_atom_9a1e4ed3) or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)) then
				__wf_atom_e55d02aa:__wf_atom_e638fc23(__wf_atom_9a1e4ed3.avatar:GetPosition())
			end

			__wf_atom_e55d02aa:__wf_atom_66c5fa3f(1, 0)
			__wf_atom_e55d02aa:TryToActivateAbility(0)
		end
	end
end

function ToggleSight(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_30e3d82b():__wf_atom_707fb30f(isBlind, -1, isBlind)
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	flag = true
	object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
end

function DisableChairCollisionOnArrive(p, p2)
	fn8(p, p2, true)
end

function EnableChairCollisionOnLeave(p, p2)
	fn8(p, p2, false)
end

local function fn12(object)
	local __wf_atom_d8853f2a = object:__wf_atom_d8853f2a()

	for i = 1, #__wf_atom_d8853f2a do
		if not __wf_atom_7e8ad928(__wf_atom_d8853f2a[i].avatar) then
			return true
		end
	end

	local investigateTargets = object:GetInvestigateTargets()

	for i = 1, #investigateTargets do
		if not __wf_atom_7e8ad928(investigateTargets[i].avatar) then
			return true
		end
	end

	return false
end

function ArcheryTargetShooting(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local shootForcedTarget2

	if __wf_atom_7e8ad928(shootForcedTarget) then
		shootForcedTarget2 = gRegion:__wf_atom_f738b4af(Symbol("ArcheryTargetPoint"), object:GetPosition(), 0, 20)
	else
		shootForcedTarget2 = shootForcedTarget
	end

	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if shootIgnoreLiveTarget then
		__wf_atom_30e3d82b:__wf_atom_707fb30f(true, -1, true)
		__wf_atom_30e3d82b:__wf_atom_8c9ce280(true)
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	object2:__wf_atom_d2b2176d():AddUpgrade(383, 4, 0)
	local v6 = 0
	local v7 = false

	while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(shootForcedTarget2) or object2:IsKilled()) do
		__wf_atom_2202ffb6:__wf_atom_836b0e3a(object2)
		__wf_atom_30e3d82b:__wf_atom_0a399e71(true, v6)
		__wf_atom_30e3d82b:__wf_atom_ae219cdf(shootForcedTarget2, shootTime, false, false)
		local v8 = shootTime + shootDelay

		while
			v8 > 0
			and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(shootForcedTarget2) or object2:IsKilled())
		do
			v7 = fn12(__wf_atom_30e3d82b)

			if shootIgnoreLiveTarget or not v7 then
				v8 -= 0.2
				Sleep(0.2)
			else
				break
			end
		end

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not shootIgnoreLiveTarget and (v7 or fn12(__wf_atom_30e3d82b)) then
			break
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_0a399e71(false, v6)
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
		__wf_atom_30e3d82b:__wf_atom_cf391375()
		object2:__wf_atom_d2b2176d():RemoveUpgrade(383, 4, 0)
	end
end

function PlayRandomAnims(_, _) end

function DropProp(_, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn2(object)
end

function DropMultiplePropsOnExit(_, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn2(object)

	for i, v6 in ipairs(otherPropAttachmentsToUnequip) do
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v6)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			continue
		end

		__wf_atom_bb3e7833:__wf_atom_e6ed03c8()
		local position = __wf_atom_bb3e7833:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_bb3e7833:__wf_atom_dc309f8a()
		__wf_atom_bb3e7833:Destroy()

		if not __wf_atom_7e8ad928(otherPropsToDrop[i]) then
			gRegion:CreateEntity(otherPropsToDrop[i], position, __wf_atom_dc309f8a)
		end
	end
end

function LeanBack(p, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn5(p, object)
end

function LieDown(p, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn6(p, object)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, -1, true)
	end
end

function GetUpFromBed(_, object)
	object:__wf_atom_e6ed03c8()

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_30e3d82b():__wf_atom_707fb30f(false, -1, false)
	end
end

local function fn13(object) -- 2 equivalent calls inferred from this helper
	return object:__wf_atom_d2b2176d():__wf_atom_9d6c02e9(4) < 4
end

function EvaluatePOI(_, object)
	local v6 = true

	if gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9() ~= 0 then
		if not (allowedAtDayTime or module.IsNight()) then
			v6 = false
		end

		if not allowedAtNightTime and module.IsNight() then
			v6 = false
		end
	end

	if allowedWhenCarryingPickUps then
		if not (#allowedPickUpItems > 0) then
			return v6
		end

		if not fn13(object) then -- inferred equivalent call
			v6 = false
			return false
		end

		local flag2 = false

		for _, v7 in ipairs(allowedPickUpItems) do
			if not object:HasItem(v7) then
				continue
			end

			flag2 = true
			break
		end

		if flag2 then
			return v6
		end

		return false
	else
		return not fn13(object) and v6 -- inferred equivalent call
	end
end

function TreeChop(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	if not object2:__wf_atom_30e3d82b():__wf_atom_04ea4887() then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v5, object:GetPosition(), 0, 3)

		for _, v6 in ipairs(__wf_atom_439c0d29) do
			if __wf_atom_7e8ad928(v6) then
				continue
			end

			v6:Destroy()
			break
		end

		if not __wf_atom_7e8ad928(portForwarderToTrigger) then
			portForwarderToTrigger:FirePort("TriggerPort")
		end
	end

	fn2(object2)

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end
end

function SendSignal(object, object2)
	Sleep(delay)

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("OdeSignalButton"),
		object:GetPosition(),
		0,
		searchRangeMax
	)

	for _, v6 in ipairs(__wf_atom_439c0d29) do
		if not v6:IsEnabled() then
			continue
		end

		v6:Activate()
		break
	end
end

function RerollRandomizeSpawner(p, _)
	fn4(p)
end

function PickUp(instance, object)
	Sleep(delay)

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v6 = nil

	if isAttachedToPickUp then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_3feeb44a) then
			__wf_atom_7e8ad928(instance)
		end
	else
		v6 = instance:__wf_atom_bb3e7833(pickUpDecoType)

		if not __wf_atom_7e8ad928(v6) then
			v6:GetPosition()
			v6:__wf_atom_dc309f8a()
			v6:SetVisibility(false)
		end
	end

	object:GiveItem(pickUpItemType, true)
	Sleep(postDelay)

	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	instance:Disable()

	if isAttachedToPickUp then
		instance:Destroy()
	else
		if reuseCooldown == -1 then
			instance:Destroy()
			return
		end

		Sleep(reuseCooldown)

		if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(v6)) then
			v6:SetVisibility(true)
			instance:Enable()
		end
	end
end

local function fn14(object) -- 1 equivalent call inferred from this helper
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9d6c02e9 = __wf_atom_d2b2176d:__wf_atom_9d6c02e9(4)

	if __wf_atom_9d6c02e9 < 4 then
		__wf_atom_d2b2176d:__wf_atom_08ff49d5(__wf_atom_9d6c02e9)
	end
end

function DropPickUp(instance, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn14(object) -- inferred equivalent call
	object:__wf_atom_30e3d82b():__wf_atom_920a5a62()

	if disableAfterUse and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function PlacePickUp(instance, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	fn3(object)
	object:__wf_atom_30e3d82b():__wf_atom_920a5a62()

	if disableAfterUse and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function ThrowPickUpProp(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local v6 = fn3(object2)

	if not __wf_atom_7e8ad928(v6) then
		v6:__wf_atom_66d7a6a9(
			__wf_atom_9341614d(object2:__wf_atom_a06d543c(), throwPickUpForceAngle) * throwPickUpForce,
			2
		)
	end

	object2:__wf_atom_30e3d82b():__wf_atom_920a5a62()

	if disableAfterUse and not __wf_atom_7e8ad928(object) then
		object:Disable()
	end
end

function UseContextAction(_, p)
	fn(p, contextActionTag)
end

function PlayAnimationInSight(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local v6 = object:Attach(lookTriggerType, Symbol("GAME_C1_HEAD1"), Vector(0, 0.5, 0), __wf_atom_80368bb1, object)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	while not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(object2) or object2:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_04ea4887()) do
		local flag2 = false

		for _, v7 in ipairs(__wf_atom_a8553251) do
			if v6:__wf_atom_1c85e812(v7) then
				flag2 = true
			end
		end

		if flag2 then
			if not __wf_atom_7e8ad928(triggeredAnim) then
				object2:__wf_atom_921c1a5f(triggeredAnim, true, 2, 1, true)
			end

			if __wf_atom_7e8ad928(loopedAnim) then
				break
			end

			object2:__wf_atom_921c1a5f(loopedAnim, true, 2, 1, true)
			break
		else
			Sleep(1)
		end
	end

	if not (__wf_atom_7e8ad928(object2) or object2:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Destroy()
	end
end

function ClearLookTrigger(object, object2)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_f53c239e)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if not (__wf_atom_7e8ad928(object2) or object2:IsKilled()) then
		object2:__wf_atom_30e3d82b():__wf_atom_920a5a62()
	end
end

function ScoutFlareOnAlertExit(_, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:SetPosture(4)

	while not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_351e924e()) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	object:SetPosture(3)
	fn11(__wf_atom_30e3d82b)
end

function ScoutFlareOnSpawn(p)
	Sleep(delay)
	fn11(p)
end

function InspectWeaponRackEnter(p, p2)
	fn9(p, p2, 1)
end

function InspectWeaponRackExit(p, object)
	if object:__wf_atom_30e3d82b():__wf_atom_04ea4887() then
		fn2(object)
	end

	fn10(p, object, 0.5)
end

local function fn15(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v6

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v6 = __wf_atom_30e3d82b:__wf_atom_7443779f()

		if __wf_atom_7e8ad928(v6) then
			return (gRegion:__wf_atom_e2db08ce(__wf_atom_46b5a019, object:GetPosition()))
		end
	end

	return v6
end

function AnimEventCreateProps(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local v6 = fn15(object)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	for i, v7 in ipairs(propsToCreate) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local v8 = propsToCreateOffsets[i] or __wf_atom_28d5d4aa
		local v9 = propsToCreateRotations[i] or __wf_atom_80368bb1
		v6:Attach(v7, EMPTY_SYMBOL, v8, v9, v6):__wf_atom_1b57cb83(false)
	end
end

function AnimEventEquipProps(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	module2.EnableNearestTaggedSequencer(Symbol("POIDistantSFX"), true, object:GetPosition())
	local v6 = fn15(object)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	for i, v7 in ipairs(propsToDestroy) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(propsToDestroy[i])

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	for i, v7 in ipairs(propsToEquip) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local v8 = propsToEquipOffsets[i] or __wf_atom_28d5d4aa
		local v9 = propsToEquipRotations[i] or __wf_atom_80368bb1
		object:Attach(v7, propsToEquipBones[i] or EMPTY_SYMBOL, v8, v9, object)
	end
end

function AnimEventUnequipProp(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	module2.EnableNearestTaggedSequencer(Symbol("POIDistantSFX"), false, object:GetPosition())
	local v6 = fn15(object)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	for i, v7 in ipairs(propsToEquip) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(propsToEquip[i])

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	for i, v7 in ipairs(propsToCreate) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local v8 = propsToCreateOffsets[i] or __wf_atom_28d5d4aa
		local v9 = propsToCreateRotations[i] or __wf_atom_80368bb1
		v6:Attach(v7, EMPTY_SYMBOL, v8, v9, v6):__wf_atom_1b57cb83(false)
	end
end

function AnimEventDestroyProp(_, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local v6 = fn15(object)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	for i, v7 in ipairs(propsToDestroy) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local v8 = v6:__wf_atom_bb3e7833(propsToDestroy[i]) or object:__wf_atom_bb3e7833(propsToDestroy[i])

		if not __wf_atom_7e8ad928(v8) then
			v8:FirePort("Destroy")
		end
	end
end

function HubNpcsTriggerAnimation()
	if #hubNpcs > 0 then
		hubNpcs = module.RandomizeTableOrder(hubNpcs)

		for _, v6 in ipairs(hubNpcs) do
			if __wf_atom_7e8ad928(v6) then
				continue
			end

			v6:PlayTriggeredAnim(hubNpcTriggeredAnimTag)
			Sleep(math.random(hubNpcTriggeredAnimDelay.minValue, hubNpcTriggeredAnimDelay.maxValue))
		end
	end
end

function SetBlindOnSpawn(object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_707fb30f(true, -1, true)
		object:__wf_atom_8c9ce280(true)
	end
end

function PushThrall(object)
	local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(
		object:GetPosition(),
		3,
		WeakResource("/SF/Types/NeutralPeople/DendritFemaleFarmerAvatar")
	)

	if #__wf_atom_a56d7910 == 0 then
		return
	end

	local v6 = __wf_atom_a56d7910[1]
	local __wf_atom_30e3d82b = v6:__wf_atom_30e3d82b()
	v6:SetFaction(Symbol("Grineer"))
	gRegion:__wf_atom_2202ffb6():__wf_atom_836b0e3a(v6)
	__wf_atom_30e3d82b:__wf_atom_0a399e71(true, 0)
	local __wf_atom_a06d543c = v6:__wf_atom_a06d543c()
	local citadelThrallPushForce = citadelThrallPushForce
	v6:MotionControl():__wf_atom_4bb21efc((__wf_atom_a06d543c + Vector(0, 0.25, 0)) * citadelThrallPushForce)
	v6:__wf_atom_921c1a5f(citadelThrallHitAnim, true, 2, 1, false)
	v6:__wf_atom_921c1a5f(citadelThrallFallAnim, false, 2, 2, false)
end