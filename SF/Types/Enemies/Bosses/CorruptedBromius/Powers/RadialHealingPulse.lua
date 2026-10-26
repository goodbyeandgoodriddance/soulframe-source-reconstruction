require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local v = nil
local v2 = 0
local total = 0
local v3 = {}
local v4 = false
local v5 = Symbol("ButtSlam")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v5)

	if
		not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		and object2:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > allowedDistanceFromLeashTag
	then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if __wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443() then
		local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget

		if
			distanceToTarget >= 0
			and distanceToTarget <= triggerDistance
			and avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5
		then
			object:__wf_atom_f7170fc9(avatar)
			return 1
		end
	end

	return 0
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_7e8ad928(__wf_atom_9d766292) then
		return
	end

	local __wf_atom_483e7ddc = __wf_atom_9d766292:__wf_atom_483e7ddc()

	if not __wf_atom_7e8ad928(__wf_atom_483e7ddc) and __wf_atom_483e7ddc:__wf_atom_a9630944() == 4 then
		v4 = true
	end
end

function ClientSendOutPulseWave(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = nil

	if not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d()) then
		object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	local v7 = pulseMaxRange / pulseGrowSpeed

	if not __wf_atom_7e8ad928(pulseIndicatorFX) then
		v6 = gRegion:CreateEntity(pulseIndicatorFX, object:GetPosition(), __wf_atom_80368bb1, nil, nil, 1)
		v6:SetMeshScale(0)
	end

	local position = object:GetPosition()
	local total2 = 0

	while total2 < v7 and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v8 = total2 / v7 * pulseMaxRange
		local v9 = v8 + pulseWidth

		if not __wf_atom_7e8ad928(v6) then
			v6:SetMeshScale(v9)
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v8, debugColour, Rotation(0, 90, 0), 0)
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v9, debugColour, Rotation(0, 90, 0), 0)
		end

		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:PlayTriggeredFade()
	end
end

function ClientStartPulseWave(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("ClientSendOutPulseWave"), false)
end

local function fn(p, list) -- 2 equivalent calls inferred from this helper
	for _, v6 in ipairs(list) do
		if not __wf_atom_7e8ad928(v6) and v6 == p then
			return true
		end
	end

	return false
end

function SendOutPulseWave(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = nil
	local v7

	if not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d()) then
		v7 = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	local v8 = pulseMaxRange / pulseGrowSpeed

	if not __wf_atom_7e8ad928(pulseIndicatorFX) then
		v6 = gRegion:CreateEntity(pulseIndicatorFX, object:GetPosition(), __wf_atom_80368bb1, nil, nil, 1)
		v6:SetMeshScale(0)
	end

	local position = object:GetPosition()
	local total2 = 0
	local v9 = {}

	while total2 < v8 and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v10 = total2 / v8 * pulseMaxRange
		local v11 = v10 + pulseWidth

		if not __wf_atom_7e8ad928(v6) then
			v6:SetMeshScale(v11)
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v10, debugColour, Rotation(0, 90, 0), 0)
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v11, debugColour, Rotation(0, 90, 0), 0)
			gRegion:__wf_atom_5b35a0c8(
				position + Vector(0, 3, 0),
				Color(0, 255, 0),
				"Heal Stat: " .. total .. "/" .. pulseMaxHealingPercentage,
				2,
				0
			)
		end

		for _, v12 in ipairs(v3) do
			if
				__wf_atom_7e8ad928(v12)
				or not (v12:__wf_atom_d5fda8be(position) < v11)
				or not (v10 < v12:__wf_atom_d5fda8be(position))
			then
				continue
			end

			if fn(v12, v9) then -- inferred equivalent call
				continue
			end

			table.insert(v9, v12)
			local damageData = Engine.DamageData()
			damageData.baseAmount = pulseDamage
			damageData:__wf_atom_7498285f(pulseDamageType, 1)
			damageData:__wf_atom_d6f4d914(pulseDamageProc, true)
			damageData.baseProcChance = pulseDamageProcChance
			damageData.stabilityDamage = pulseStabilityDamage
			damageData:__wf_atom_6b472125(object)
			damageData:__wf_atom_34a8a27a(v7)
			v12:__wf_atom_649bf33e(damageData)

			if __wf_atom_7e8ad928(v12:__wf_atom_7470861b()) or v12:__wf_atom_7470861b():__wf_atom_246e3020() then
				continue
			end

			local v13 = object:GetMaxHealth() * pulseHealingPercentage / 100

			if not (total <= pulseMaxHealingPercentage - pulseHealingPercentage) then
				continue
			end

			total += pulseHealingPercentage
			object:Heal(object, v13)
		end

		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:PlayTriggeredFade()
	end
end

function SendOutInitialPulseWave(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(healingLoopSound) and v == nil then
		v = object:PlaySound(healingLoopSound, false, 1, false)
	end

	local v6 = nil
	local v7

	if not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d()) then
		v7 = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	local v8 = initPulseMaxRange / initPulseGrowSpeed

	if not __wf_atom_7e8ad928(initPulseIndicatorFX) then
		v6 = gRegion:CreateEntity(initPulseIndicatorFX, object:GetPosition(), __wf_atom_80368bb1, nil, nil, 1)
		v6:SetMeshScale(0)
	end

	local position = object:GetPosition()
	local total2 = 0
	local v9 = {}

	while total2 < v8 and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v10 = total2 / v8 * initPulseMaxRange
		local v11 = v10 + initPulseWidth

		if not __wf_atom_7e8ad928(v6) then
			v6:SetMeshScale(v11)
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v10, debugColour, Rotation(0, 90, 0), 0)
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v11, debugColour, Rotation(0, 90, 0), 0)
		end

		for _, v12 in ipairs(v3) do
			if
				__wf_atom_7e8ad928(v12)
				or not (v12:__wf_atom_d5fda8be(position) < v11)
				or not (v10 < v12:__wf_atom_d5fda8be(position))
			then
				continue
			end

			if fn(v12, v9) then -- inferred equivalent call
				continue
			end

			table.insert(v9, v12)
			local damageData = Engine.DamageData()
			damageData.baseAmount = initPulseDamage
			damageData:__wf_atom_7498285f(initPulseDamageType, 1)
			damageData:__wf_atom_d6f4d914(initPulseDamageProc, true)
			damageData.baseProcChance = initPulseDamageProcChance
			damageData.stabilityDamage = initPulseStabilityDamage
			damageData:__wf_atom_6b472125(object)
			damageData:__wf_atom_34a8a27a(v7)
			v12:__wf_atom_649bf33e(damageData)
		end

		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:PlayTriggeredFade()
	end
end

function ClientSendOutInitPulseWave(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = nil

	if not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d()) then
		object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	local v7 = initPulseMaxRange / initPulseGrowSpeed

	if not __wf_atom_7e8ad928(initPulseIndicatorFX) then
		v6 = gRegion:CreateEntity(initPulseIndicatorFX, object:GetPosition(), __wf_atom_80368bb1, nil, nil, 1)
		v6:SetMeshScale(0)
	end

	local position = object:GetPosition()
	local total2 = 0

	while total2 < v7 and not (object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		local v8 = total2 / v7 * initPulseMaxRange
		local v9 = v8 + initPulseWidth

		if not __wf_atom_7e8ad928(v6) then
			v6:SetMeshScale(v9)
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v8, debugColour, Rotation(0, 90, 0), 0)
			gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v9, debugColour, Rotation(0, 90, 0), 0)
		end

		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:PlayTriggeredFade()
	end
end

function ClientStartInitPulseWave(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("ClientSendOutInitPulseWave"), false)
end

function ActivateAbility(object, object2, _, _)
	v4 = false

	if gRegion:IsMaster() then
		object2:__wf_atom_30e3d82b():__wf_atom_b414eabf()
		local v6

		if __wf_atom_7e8ad928(castAnim) then
			v6 = 0
		else
			local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(castAnim, false, 2, 1, true)
			v6 = __wf_atom_921c1a5f - castAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol)) * __wf_atom_921c1a5f
			object2:__wf_atom_8914dfde(castAnimEventSymbol, 10)
		end

		v2 = 0
		object2:__wf_atom_51cd6126(Symbol("BromiusRadialPulseInterDamage"), "OnDamaged")
		v3 = gRegion:__wf_atom_ef7900cf()
		object2:__wf_atom_8a035cd5(Symbol("SendOutInitialPulseWave"), false)
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		object:ActivateSecondaryScript(
			mOwner:__wf_atom_e14d8a8c(),
			Symbol("ClientStartInitPulseWave"),
			secondaryScriptArgs
		)
		Sleep(v6)
		total = 0
		local v7 = 0
		local count = 0
		local pulseSendInterval2 = 0

		while
			not object2:__wf_atom_7b82e9e1(12)
			and not object2:__wf_atom_7b82e9e1(6)
			and not v4
			and total < pulseMaxHealingPercentage
			and not __wf_atom_7e8ad928(object2)
			and not object2:IsKilled()
			and not object2:__wf_atom_bedb4e3f()
			and count < pulseMaxCastAmount
		do
			if
				pulseSendInterval2 <= 0
				or not (__wf_atom_7e8ad928(smallRoarAnim) or __wf_atom_7e8ad928(smallRoarEventSymbol))
			then
				local v8 = __wf_atom_7e8ad928(smallRoarAnim) and 0
					or object2:__wf_atom_921c1a5f(smallRoarAnim, false, 2, 1, true)
				local v9 = Time()

				for _ = 1, smallRoarNumPulses do
					if not __wf_atom_7e8ad928(smallRoarAnim) then
						object2:__wf_atom_8914dfde(smallRoarEventSymbol, 10)
					end

					object2:__wf_atom_8a035cd5(Symbol("SendOutPulseWave"), false)
					local secondaryScriptArgs2 = SF.SecondaryScriptArgs(true)
					object:ActivateSecondaryScript(
						mOwner:__wf_atom_e14d8a8c(),
						Symbol("ClientStartPulseWave"),
						secondaryScriptArgs2
					)
					count += 1
				end

				local v10 = v8 - (Time() - v9)

				if v10 > 0 then
					Sleep(v10)
				end

				pulseSendInterval2 = pulseSendInterval
				v7 = pulseMaxRange / pulseGrowSpeed - v10
			end

			pulseSendInterval2 -= __wf_atom_084b3e93()

			if v7 > 0 then
				v7 -= __wf_atom_084b3e93()
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v) then
			object2:PlaySound(abilityEndSound, false, 1, false)
			v:Stop(false)
		end

		while v7 > 0 and total < pulseMaxHealingPercentage do
			v7 -= __wf_atom_084b3e93()
			Sleep(0)
		end

		if total == pulseMaxHealingPercentage and not __wf_atom_7e8ad928(succuessEndAnim) then
			object2:__wf_atom_921c1a5f(succuessEndAnim, true, 2, 1, true)
		end
	elseif not __wf_atom_7e8ad928(castAnim) then
		object2:__wf_atom_921c1a5f(castAnim, false, 2, 1, true)
		object2:__wf_atom_8914dfde(castAnimEventSymbol, 10)
	end
end

function DeactivateAbility(_, object, _, _)
	if gRegion:IsMaster() and not (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
		object:__wf_atom_3ede53b4(Symbol("BromiusRadialPulseInterDamage"))
	end
end