local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local radius = 12
local stabilityDamage = 200
local v = 10

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		stabilityDamage = 100
		radius = 5
	elseif p == 2 then
		stabilityDamage = 200
		radius = 6
	elseif p == 3 then
		stabilityDamage = 250
		radius = 7
	else
		stabilityDamage = 300
		radius = 8
	end

	stabilityDamage *= magikForceCalc
	radius *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn2(object, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_58367d88 = object2:__wf_atom_7470861b():__wf_atom_58367d88(false)
	local __wf_atom_a769ebe3 = object:__wf_atom_a769ebe3(0)
	local __wf_atom_a769ebe3_2 = object:__wf_atom_a769ebe3(1)
	local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(object:__wf_atom_a769ebe3(2), 168)
	local __wf_atom_2a745663_2 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3,
		20,
		nil,
		nil,
		26
	)
	local __wf_atom_2a745663_3 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
		20,
		nil,
		nil,
		26
	)
	local v2 = __wf_atom_2a745663 + (__wf_atom_2a745663_2 + __wf_atom_2a745663_3)
	local __wf_atom_2a745663_4 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3,
		20,
		nil,
		nil,
		21
	)
	local v3 = v2 + (__wf_atom_2a745663_4 - __wf_atom_2a745663_2)
	local total = 0

	for i = 0, 2 do
		total += __wf_atom_d2b2176d:__wf_atom_2a745663(__wf_atom_58367d88 + __wf_atom_a769ebe3, 20, nil, nil, i) - __wf_atom_2a745663_4
	end

	local v4 = v3 + total / (1 + 2 - 0)
	local __wf_atom_2a745663_5 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
		20,
		nil,
		nil,
		25
	)
	local v5 = v4 + (__wf_atom_2a745663_5 - __wf_atom_2a745663_3)
	local __wf_atom_2a745663_6 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
		20,
		nil,
		nil,
		23
	)
	local v6 = v5 + (__wf_atom_2a745663_6 - __wf_atom_2a745663_3)
	local __wf_atom_2a745663_7 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
		20,
		nil,
		nil,
		24
	)
	local v7 = v6 + (__wf_atom_2a745663_7 - __wf_atom_2a745663_3)
	local total2 = 0

	for i = 3, 6 do
		total2 += __wf_atom_d2b2176d:__wf_atom_2a745663(__wf_atom_58367d88 + __wf_atom_a769ebe3_2, 20, nil, nil, i) - __wf_atom_2a745663_6 - __wf_atom_2a745663_5 + __wf_atom_2a745663_3
	end

	for i = 7, 12 do
		total2 += __wf_atom_d2b2176d:__wf_atom_2a745663(__wf_atom_58367d88 + __wf_atom_a769ebe3_2, 20, nil, nil, i) - __wf_atom_2a745663_7 - __wf_atom_2a745663_5 + __wf_atom_2a745663_3
	end

	return v7 + total2 / (1 + 12 - 3)
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	local motionControl = object2:MotionControl()
	motionControl:__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	motionControl:__wf_atom_3959d938(true)
	motionControl:__wf_atom_8717c451(true)
	Sleep(0)
	object2:Attach(castFxType, EMPTY_SYMBOL)
	local v2 = nil
	local v3

	if object2:__wf_atom_59cb39a4() then
		v3 = 0.75
	else
		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		if not __wf_atom_7e8ad928(pactFxType) then
			v2 = object2:Attach(pactFxType, EMPTY_SYMBOL)
		end

		local v4 = module.PlayAnim(object, jumpAnim, false, 2, 3, true, 0.5, object2)
		v3 = 1.25

		if not module.SuspendUntilEvent(object, jumpAnim, "StopCamAnim", v4) or __wf_atom_7e8ad928(object2) then
			return
		end

		object2:CameraControl():StopAnim()

		if not module.SuspendUntilEvent(object, jumpAnim, "Cast", v4) then
			return
		end

		motionControl:__wf_atom_4bb21efc(Vector(0, 7, 0))
		object2:PlaySound(JumpSound, false, 1, false)

		repeat
			Sleep(0)
		until not object2:__wf_atom_c138b19b(jumpAnim) or object2:__wf_atom_9f57166e() < 0
	end

	local v4 = object2:Attach(launchAttachFxType, EMPTY_SYMBOL)
	object2:SetDisableGravity(true)
	module.SetForceAim(object2, mOwner, true)
	module.PlayAnim(object, stallAnim, false, 2, 2, true)
	Sleep(v3)
	motionControl:__wf_atom_3959d938(false)
	motionControl:__wf_atom_8717c451(false)
	object2:SetDisableGravity(false)

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	local v5 = object2:Attach(diveAttachFxType, EMPTY_SYMBOL)

	if not __wf_atom_7e8ad928(v5) then
		module.SetAbilityStats(object, mOwner, v5)
	end

	object2:PlaySound(diveSound, false, 1, false)

	if module.SlamToGround(object2, slamStartAnim, slamEndAnim, "SlamCast") then
		local v6 = fn2(object, object2)
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = radius
		local v7 = math.pow(__wf_atom_421b01aa(v6 / 200, 0, 1), 0.5)
		v = __wf_atom_104bfe98(10, 30, v7)
		radialDamageData.baseAmount = math.min(v6, 200) / v * 50
		radialDamageData:__wf_atom_7498285f(0, 1)
		radialDamageData:__wf_atom_98d98d81(object2:GetPosition())
		radialDamageData:__wf_atom_6b472125(object2)
		radialDamageData:__wf_atom_34a8a27a(object)
		radialDamageData:__wf_atom_12cf5317(150)
		radialDamageData.fallOff = 0.25
		radialDamageData.checkForCover = false
		radialDamageData.hostAuthoritative = false
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		radialDamageData.radius = radius * (1 + v7)
		radialDamageData.baseAmount = 1
		radialDamageData.stabilityDamage = stabilityDamage
		radialDamageData.blockableProjType = 4
		radialDamageData:__wf_atom_d6f4d914(31, true)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		local position = object2:GetPosition()
		local __wf_atom_2f2bada0 = object2:__wf_atom_2f2bada0()
		gRegion:CreateEntity(bearType, position, __wf_atom_2f2bada0, object)
		gRegion:CreateEntity(Impactfx, position, __wf_atom_2f2bada0, object2)
		object2:PlaySound(ImpactSound, false, 1, false)

		if not __wf_atom_7e8ad928(v5) then
			v5:Destroy()
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end
	elseif not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end
end

function DeactivateAbility(p, object, _, _)
	if object:__wf_atom_3c281634(jumpAnim) or object:__wf_atom_c138b19b(jumpAnim, true) then
		object:__wf_atom_9b5dcd3b(nil, false)
	else
		if
			object:__wf_atom_c138b19b(stallAnim)
			and not (object:__wf_atom_c138b19b(slamStartAnim) or object:__wf_atom_3c281634(slamStartAnim) or object:__wf_atom_c138b19b(slamEndAnim) or object:__wf_atom_3c281634(slamEndAnim))
		then
			object:__wf_atom_9b5dcd3b(nil, false)
		end

		module.StopSlamToGround(object, slamStartAnim, slamEndAnim)
	end

	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if not __wf_atom_7e8ad928(abilityStats) then
		abilityStats:Destroy()
	end

	local motionControl = object:MotionControl()
	motionControl:__wf_atom_3959d938(false)
	motionControl:__wf_atom_8717c451(true)
	object:CameraControl():StopAnim()
	object:SetDisableGravity(false)
	module.RemoveCastImmunity(object)
	module.SetForceAim(object, mOwner, false)
end

function BearCleanup(instance)
	Sleep(0)

	if not __wf_atom_7e8ad928(instance) then
		local total = 0

		while total < 1 and not __wf_atom_7e8ad928(instance) do
			instance:__wf_atom_a763aa1a(total)
			Sleep(0)
			total += __wf_atom_084b3e93()
		end

		instance:Destroy()
	end
end