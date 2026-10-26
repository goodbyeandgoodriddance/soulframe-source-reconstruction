local module = require("SF.Scripts.Libs.TransmissionSet")
local v = {}

local function fn(position, position2)
	local v2 = position2 - position
	Normalize(v2)
	local v3 = position2 + distancePastTargetToLand * v2

	if gRegion:__wf_atom_2202ffb6():__wf_atom_417a583d(v3, distancePastTargetToLand * 0.5, 3, -3) then
		return gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v3)
	end

	return nil
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()

	for i = 1, #__wf_atom_d8853f2a do
		local v2 = __wf_atom_d8853f2a[i]

		if not (v2.visible and v2:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v2.distanceToTarget

		if not (triggerRange.minValue <= distanceToTarget and distanceToTarget <= triggerRange.maxValue and v2.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		if __wf_atom_7e8ad928((fn(object2:GetPosition(), v2.avatar:GetPosition()))) then
			continue
		end

		object:__wf_atom_f7170fc9(v2.avatar)
		return 1
	end

	return 0
end

function GetChargeDirectionFromTarget(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v2 = __wf_atom_fa8d0177(object2:__wf_atom_a2a18137(), object:__wf_atom_a2a18137())
	v2.pitch = 0
	v2.bank = 0
	return v2
end

local function fn2(p, list) -- 1 equivalent call inferred from this helper
	for i = 1, #list do
		if p == list[i] then
			return true
		end
	end

	return false
end

local function fn3(list, object, object2)
	local v2 = false

	for i = 1, #list do
		if __wf_atom_7e8ad928(list[i]) or fn2(list[i], v) then -- inferred equivalent call
			continue
		end

		local damageData = Engine.DamageData()
		damageData.baseAmount = chargeDamage
		damageData.stabilityDamage = stabilityDamage
		damageData:__wf_atom_7498285f(0, 1)
		damageData:__wf_atom_34a8a27a(object)
		local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
		Normalize(__wf_atom_a06d543c)
		damageData:__wf_atom_12cf5317(__wf_atom_a06d543c * 3)
		list[i]:__wf_atom_649bf33e(damageData)
		table.insert(v, list[i])

		if v2 then
			continue
		end

		gRegion:PlaySound(impactSound, list[i]:GetPosition(), false, 0, object2, list[i], nil, true)
		v2 = true
	end
end

local function fn4(p, p2, total) -- 2 equivalent calls inferred from this helper
	return total <= p2 and p <= total
end

function DoPhasethrough(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v2

	if not __wf_atom_7e8ad928(attachFX) then
		v2 = __wf_atom_6009c8ed:Attach(attachFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	__wf_atom_6009c8ed:__wf_atom_1c374cc9(Symbol(bonePositionSyn))
	local __wf_atom_9b5dcd3b = __wf_atom_6009c8ed:__wf_atom_9b5dcd3b(phaseThroughAnim, false, 3, 1, true)
	local v3 = phaseThroughAnim:__wf_atom_091354f5(Symbol("StartTrace")) * __wf_atom_9b5dcd3b
	local v4 = phaseThroughAnim:__wf_atom_091354f5(Symbol("EndTrace")) * __wf_atom_9b5dcd3b
	__wf_atom_6009c8ed:__wf_atom_d1b42aad(false)
	__wf_atom_6009c8ed:SetDisableGravity(true)
	Sleep(0.1)
	local total = 0

	while
		not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and __wf_atom_6009c8ed:__wf_atom_c138b19b(phaseThroughAnim, false)
	do
		local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(Symbol(bonePositionSyn))

		if fn4(v3, v4, total) and damageDebug then -- inferred equivalent call
			gRegion:__wf_atom_8d991675(__wf_atom_1c374cc9, traceRadius, damageDebugAreaColour, 1)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_6009c8ed:__wf_atom_d1b42aad(true)
	__wf_atom_6009c8ed:SetDisableGravity(false)

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end
end

function ActivateAbility(object, object2, avatar)
	module.PlayGlobalTransmission(transmissionSet, Symbol("SmokeAbility"))

	if
		__wf_atom_7e8ad928(avatar)
		and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()))
	then
		avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar
	end

	if not gRegion:IsMaster() then
		return
	end

	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	secondaryScriptArgs:__wf_atom_a17e41c6(avatar)
	object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("DoPhasethrough"), secondaryScriptArgs)
	local v2

	if not __wf_atom_7e8ad928(attachFX) then
		v2 = object2:Attach(attachFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local position = object2:GetPosition()

	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local position2 = avatar:GetPosition()
	object2:__wf_atom_1c374cc9(Symbol(bonePositionSyn))
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol(bonePositionSyn))
	local v3 = fn(position, position2)

	if __wf_atom_7e8ad928(v3) then
		return
	end

	object2:__wf_atom_3c986cd9(v3, (__wf_atom_fa8d0177(position, v3)))
	local __wf_atom_9b5dcd3b = object2:__wf_atom_9b5dcd3b(phaseThroughAnim, false, 3, 1, true)
	local v4 = phaseThroughAnim:__wf_atom_091354f5(Symbol("StartTrace")) * __wf_atom_9b5dcd3b
	local v5 = phaseThroughAnim:__wf_atom_091354f5(Symbol("EndTrace")) * __wf_atom_9b5dcd3b
	object2:__wf_atom_d1b42aad(false)
	object2:SetDisableGravity(true)
	Sleep(0.1)
	object2:__wf_atom_68f2c268(0.5)
	local total = 0

	while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(phaseThroughAnim, false) do
		local __wf_atom_1c374cc9_2 = object2:__wf_atom_1c374cc9(Symbol(bonePositionSyn))

		if fn4(v4, v5, total) then -- inferred equivalent call
			if damageDebug then
				gRegion:__wf_atom_8d991675(__wf_atom_1c374cc9_2, traceRadius, damageDebugAreaColour, 1)
			end

			local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(
				__wf_atom_1c374cc9,
				__wf_atom_1c374cc9_2,
				traceRadius,
				acceptedTargetsTypes,
				nil
			)

			if not __wf_atom_7e8ad928(__wf_atom_4ea726bc) then
				fn3(__wf_atom_4ea726bc, object, object2)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
		__wf_atom_1c374cc9 = __wf_atom_1c374cc9_2
	end

	object2:__wf_atom_d1b42aad(true)
	object2:SetDisableGravity(false)
	object2:__wf_atom_68f2c268(0)
	object2:Teleport(
		gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(object2:__wf_atom_a2a18137()),
		object2:__wf_atom_2f2bada0()
	)

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end
end