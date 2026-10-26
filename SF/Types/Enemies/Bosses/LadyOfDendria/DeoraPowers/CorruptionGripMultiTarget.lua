local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Rotation(0, 90, 0)
local inRangeColour2 = Color(255, 255, 255, 255)
local selectedTargets = {}
local affectedTargets = {}
local v2 = {}
local v3 = {}
local v4 = false
local v5 = { "Hold", "Stay", "Stop" }

local function fn(selectedTargets2, p)
	for k, item in pairs(selectedTargets2) do
		if item == p then
			return k
		end
	end
end

local function fn2(p, list) -- 3 equivalent calls inferred from this helper
	for i = 1, #list do
		if p == list[i] then
			return true
		end
	end

	return false
end

local function fn3()
	for i = #selectedTargets, 1, -1 do
		if __wf_atom_7e8ad928(selectedTargets[i]) or fn2(selectedTargets[i], affectedTargets) then -- inferred equivalent call
			continue
		end

		local __wf_atom_bb3e7833 = selectedTargets[i]:__wf_atom_bb3e7833(corruptionSlowFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
			print("destroy")
		end

		selectedTargets[i]:__wf_atom_d2b2176d():AddUpgrade(101, 2, 0)
		selectedTargets[i]:SetDisableMovement(true)
		selectedTargets[i]:Attach(corruptionLockFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		table.insert(affectedTargets, selectedTargets[i])
		table.remove(selectedTargets, i)
	end
end

local function fn4(all, p)
	for i = 1, #all do
		local v6 = all[i]

		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(corruptionSlowFx)
		local v7 = Distance(p, Vector(v6:__wf_atom_a2a18137().x, p.y, v6:__wf_atom_a2a18137().z))

		if v7 <= gripRadius and not fn2(v6, selectedTargets) then -- inferred equivalent call
			table.insert(selectedTargets, v6)
			v6:__wf_atom_d2b2176d():AddUpgrade(101, 2, gripSlowAmount)
			v6:MotionControl():__wf_atom_99fc7a82(true)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				v6:Attach(corruptionSlowFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			inRangeColour2 = inRangeColour
			continue
		end

		if not (gripRadius < v7 and fn2(v6, selectedTargets)) then -- inferred equivalent call
			continue
		end

		table.remove(selectedTargets, fn(selectedTargets, v6))
		v6:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, gripSlowAmount)
		v6:MotionControl():__wf_atom_99fc7a82(false)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		inRangeColour2 = OutRangeColour
	end
end

local function fn5(object, object2)
	object:__wf_atom_9b5dcd3b(castSuccess, false, 4, 3, true)
	object:__wf_atom_8914dfde("Blast", 5)

	for i = 1, #v2 do
		object2:__wf_atom_98d98d81(v2[i])
		gRegion:__wf_atom_f6ec80de(object2)
		gRegion:CreateEntity(corruptionBlastFx, v2[i], __wf_atom_80368bb1)
	end
end

local function fn6()
	for i = 1, #v2 do
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(corruptionPuddleFx, v2[i], __wf_atom_80368bb1)
		__wf_atom_7ccf4243:SetMeshScale(gripRadius + 0.6)
		table.insert(v3, i, __wf_atom_7ccf4243)

		if debugOn then
			gRegion:__wf_atom_b5c21154(v2[i] + Vector(0, 0.5, 0), gripRadius, inRangeColour2, v, 4)
		end

		Sleep(vfxSpawnDelay)
	end
end

local function fn7(object, object2)
	if __wf_atom_7e8ad928(object) then
		return object2:__wf_atom_2f2bada0()
	end

	local v6 = __wf_atom_fa8d0177(object2:__wf_atom_a2a18137(), object:__wf_atom_a2a18137())
	v6.pitch = 0
	v6.bank = 0
	return v6
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local total = 0

	for i = 1, #__wf_atom_d8853f2a do
		local v6 = __wf_atom_d8853f2a[i]

		if not (v6.visible and v6:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v6.distanceToTarget

		if not (minAttackStartRange <= distanceToTarget and distanceToTarget <= maxAttackStartRange and v6.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		total += (1 - distanceToTarget / maxAttackStartRange) / #__wf_atom_d8853f2a
		object:__wf_atom_f7170fc9(v6.avatar)
	end

	return total
end

function ActivateAbility(p, object, p2)
	local v6 = { affectedTargets = affectedTargets, selectedTargets = selectedTargets }
	module2.SetAbilityStats(p, mOwner, v6)

	if not __wf_atom_7e8ad928(castStart) then
		local deoraCorruptionTransmission = math.random(1, #v5)

		if _T.deoraCorruptionTransmission == deoraCorruptionTransmission then
			local v7 = (deoraCorruptionTransmission - 1 + math.random(1, #v5 - 1)) % #v5 + 1
			deoraCorruptionTransmission = v7 < 1 and 1 or #v5 < v7 and #v5 or v7
		end

		_T.deoraCorruptionTransmission = deoraCorruptionTransmission
		module.PlayGlobalTransmission(deoraTransmissionSet, Symbol(v5[deoraCorruptionTransmission]))
		local __wf_atom_9b5dcd3b = object:__wf_atom_9b5dcd3b(castStart, false, 4, 3, true)
		Sleep(__wf_atom_9b5dcd3b)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local all = gRegion:FindAll(__wf_atom_c4f78a8f, object:__wf_atom_a2a18137(), 0, 200)
	local total = 0

	for i = 1, #all do
		local __wf_atom_a2a18137 = all[i]:__wf_atom_a2a18137()
		table.insert(v2, i, __wf_atom_a2a18137)
		gRegion:Raycast(v2[i] + Vector(0, 0.1, 0), v2[i] - Vector(0, 10, 0), nil, nil, v2[i], true)
	end

	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = aoeDamage + damageRankMod * __wf_atom_68de036a
	radialDamageData.stabilityDamage = aoeStabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
	radialDamageData:__wf_atom_7498285f(aoeDamageType, 1)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(p)
	radialDamageData.radius = aoeRadius
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_12cf5317(20)
	object:__wf_atom_9b5dcd3b(castStartLoop, false, 4, 2, false)
	mOwner:__wf_atom_7ccf4243(castFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	fn6()
	local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

	while total < gripLength do
		Sleep(0)
		local __wf_atom_c6f1f83d2 = object:__wf_atom_c6f1f83d()
		total += __wf_atom_084b3e93()
		object:MotionControl():__wf_atom_3a1d0c16(fn7(p2, object))

		if total <= escapeTime then
			for i = 1, #v2 do
				fn4(all, v2[i])
			end

			v4 = #selectedTargets > 0

			if __wf_atom_c6f1f83d2 < __wf_atom_c6f1f83d and stopOnDamage == true then
				object:__wf_atom_9b5dcd3b(castFailAnim, false, 4, 1, true)
				break
			end
		elseif escapeTime <= total then
			inRangeColour2 = grippedColour

			if #selectedTargets >= 1 then
				fn3()

				if not object:__wf_atom_c138b19b(castSuccessLoop) and v4 == true then
					fn5(object, radialDamageData)
					break
				end
			elseif v4 == false then
				if object:__wf_atom_c138b19b(castSuccessLoop) then
					break
				end

				fn5(object, radialDamageData)
				break
			end
		end

		if debugOn then
			__wf_atom_c6f1f83d = __wf_atom_c6f1f83d2

			for i = 1, #v2 do
				gRegion:__wf_atom_b5c21154(v2[i], gripRadius, inRangeColour2, v, 0)
			end
		else
			__wf_atom_c6f1f83d = __wf_atom_c6f1f83d2
		end
	end
end

function CleanUpAbility(object)
	object:__wf_atom_9b5dcd3b(castEnd, false, 4, 1, true)

	for i = 1, #affectedTargets do
		local v6 = affectedTargets[i]

		if __wf_atom_7e8ad928(v6) then
			continue
		end

		v6:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, gripSlowAmount)
		v6:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, 0)
		v6:MotionControl():__wf_atom_99fc7a82(false)
		v6:SetDisableMovement(false)
		v6:__wf_atom_0650fed7(corruptionLockFx)
	end

	for _, v6 in ipairs(selectedTargets) do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		v6:__wf_atom_d2b2176d():RemoveUpgrade(101, 2, gripSlowAmount)
		v6:MotionControl():__wf_atom_99fc7a82(false)
		v6:SetDisableMovement(false)
		v6:__wf_atom_0650fed7(corruptionSlowFx)
	end
end

function DeactivateAbility(p, p2, _, _)
	__wf_atom_7e8ad928(p2)
	local abilityStats = module2.GetAbilityStats(p, mOwner, true)
	affectedTargets = abilityStats.affectedTargets
	selectedTargets = abilityStats.selectedTargets
	CleanUpAbility(p2)
end