local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("EE.Interface.Utilities")
require("Lotus.Scripts.Libs.AudioLib")
local v = 25
local v2 = 1.2
local v3 = nil

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v2 = 1.25
		v = 15
	elseif p == 2 then
		v2 = 1.5
		v = 18
	elseif p == 3 then
		v2 = 1.8
		v = 20
	else
		v2 = 1.9
		v = 25
	end

	v2 *= magikForceCalc
	v *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn2(object, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_58367d88 = object2:__wf_atom_7470861b():__wf_atom_58367d88(false)
	local __wf_atom_a769ebe3 = object:__wf_atom_a769ebe3(0)
	local __wf_atom_a769ebe3_2 = object:__wf_atom_a769ebe3(1)
	local result = {}
	local result2 = {}

	for i = 0, 2 do
		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			__wf_atom_58367d88 + __wf_atom_a769ebe3,
			20,
			nil,
			nil,
			i
		)
		local v4 = math.floor(0.5 + __wf_atom_2a745663 * v2 - __wf_atom_2a745663)

		if not (v4 > 0) then
			continue
		end

		result[i] = v4
		local v5 = math.floor(v4 * 0.35 + 0.5)

		if v5 > 0 then
			result2[i] = v5
		end
	end

	for i = 3, 6 do
		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
			20,
			nil,
			nil,
			i
		)
		local v4 = math.floor(0.5 + __wf_atom_2a745663 * v2 - __wf_atom_2a745663)

		if not (v4 > 0) then
			continue
		end

		result[i] = v4
		local v5 = math.floor(v4 * 0.35 + 0.5)

		if v5 > 0 then
			result2[i] = v5
		end
	end

	for i = 7, 12 do
		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			__wf_atom_58367d88 + __wf_atom_a769ebe3_2,
			20,
			nil,
			nil,
			i
		)
		local v4 = math.floor(0.5 + __wf_atom_2a745663 * v2 - __wf_atom_2a745663)

		if not (v4 > 0) then
			continue
		end

		result[i] = v4
		local v5 = math.floor(v4 * 0.35 + 0.5)

		if v5 > 0 then
			result2[i] = v5
		end
	end

	return result, result2
end

local function fn3(object, items)
	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		for k, item in pairs(items) do
			__wf_atom_d2b2176d:AddUpgrade(20, 0, item, nil, nil, k)
		end

		object:Attach(attachFxType, EMPTY_SYMBOL)
	end
end

local function fn4(object, items)
	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		for k, item in pairs(items) do
			__wf_atom_d2b2176d:RemoveUpgrade(20, 0, item, nil, nil, k)
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:PlayTriggeredFade()
		end
	end
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	local motionControl = object2:MotionControl()
	motionControl:__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	motionControl:__wf_atom_3959d938(true)
	Sleep(0)
	object2:Attach(castFxType, EMPTY_SYMBOL)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)
	motionControl:__wf_atom_3959d938(false)
	local armourBoostByType, allyArmourByType = fn2(object, object2)
	local v5 = {
		armourBoostByType = armourBoostByType,
		allies = {},
		allyArmourByType = allyArmourByType
	}
	module.SetAbilityStats(object, mOwner, v5)
	fn3(object2, armourBoostByType)

	if not __wf_atom_7e8ad928(activeLoopSound) and v3 == nil then
		v3 = object2:PlaySound(activeLoopSound, false, 1, false)
	end

	while v > 0 do
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa, object2:GetPosition(), 0, 15)
		local allies = {}

		for _, v6 in ipairs(all) do
			if not (v6 ~= object2 and v6:__wf_atom_129d1aba(object2)) then
				continue
			end

			local __wf_atom_18aa6e58 = v6:__wf_atom_18aa6e58()

			if v5.allies[__wf_atom_18aa6e58] then
				v5.allies[__wf_atom_18aa6e58] = nil
			else
				fn3(v6, allyArmourByType)
			end

			allies[__wf_atom_18aa6e58] = v6
		end

		for _, ally in pairs(v5.allies) do
			if not __wf_atom_7e8ad928(ally) then
				fn4(ally, allyArmourByType)
			end
		end

		v5.allies = allies
		Sleep(0.5)
		v -= 0.5
	end

	object2:PlaySound(deactiveSound, false, 1, false)

	if not __wf_atom_7e8ad928(v3) then
		v3:Stop(false)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end
end

function DeactivateAbility(p, object, _, _)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if not __wf_atom_7e8ad928(abilityStats) then
		fn4(object, abilityStats.armourBoostByType)

		for _, ally in pairs(abilityStats.allies) do
			if not __wf_atom_7e8ad928(ally) then
				fn4(ally, abilityStats.allyArmourByType)
			end
		end
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:MotionControl():__wf_atom_3959d938(false)
	end
end

function DebugDisplay(object)
	local abilityStats = module.GetAbilityStats(mOwner:__wf_atom_c78fa517(), mOwner)
	local module2 = require("Lotus.Interface.LotusUtilities")
	local v4 = ""
	local v5 = ""

	for k, v6 in pairs(abilityStats.armourBoostByType) do
		v4 ..= "\n" .. module2.GetDamageTypeTag(k) .. ": " .. v6
	end

	for k, v6 in pairs(abilityStats.allyArmourByType) do
		v5 ..= "\n" .. module2.GetDamageTypeTag(k) .. ": " .. v6
	end

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() do
		gRegion:__wf_atom_5b35a0c8(object:EyePosition() + Vector(0, 0.5, 0), Color(255, 255, 255), v4, 1, 0)

		for _, ally in pairs(abilityStats.allies) do
			if not __wf_atom_7e8ad928(ally) then
				gRegion:__wf_atom_5b35a0c8(ally:EyePosition() + Vector(0, 0.5, 0), Color(255, 255, 255), v5, 1, 0)
			end
		end

		Sleep(0)
	end
end