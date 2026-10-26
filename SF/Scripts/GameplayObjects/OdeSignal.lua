local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.AudioLib")
local v = { ALLCLEAR = 1, BEGONE = 2, RESUPPLY = 3, ALARM = 4 }
local v2 = WeakResource("/SF/Objects/GameplayProps/Lantern/BalloonCrateAppendLanternEffectDeco")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = Symbol("EncOdeSignalsConsole")
local v9 = Symbol("EncOdeSignalsBeacon")
local v10 = Symbol("OdeSignalsConsoleOperator")
local v11 = String("/SF/Language/Objectives/OdeSignalsChoice2")
local v12 = String("/SF/Language/Objectives/OdeSignalsChoice3")

local function fn(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.interactionActivated = true
		__wf_atom_e919fb8e.instigator = __wf_atom_7be51ede
	end
end

local function fn2()
	v4:__wf_atom_0e990c03(v.ALARM)
	v4:Activate()

	while v4:__wf_atom_b81a6e66() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:__wf_atom_920a5a62()
	end

	v6:Destroy()
	v3 = module2.WaitForAiDir()
	v3:AddEncounter(reinforcementEncounterType)
	v3:__wf_atom_c4c644af(v5:GetPosition(), reinforcementEncounterType, v5, 5)
end

local function fn3()
	v4:__wf_atom_0e990c03(v.RESUPPLY)
	v4:Activate()

	while v4:__wf_atom_b81a6e66() do
		Sleep(0)
	end

	v6:Destroy()

	if not __wf_atom_7e8ad928(v7) then
		v7:__wf_atom_920a5a62()
	end

	local groundPos = module3.GetGroundPos(v5:GetPosition())
	local v13 = groundPos + Vector(0, 300, 0)
	local total = 0
	local entity = gRegion:CreateEntity(odeSignalsSupplyDropType, v13, Rotation(__wf_atom_5784a397(0, 360), 0, 0))

	if __wf_atom_7e8ad928(entity) then
		return
	end

	v5:__wf_atom_d494454b(entity)

	while total <= 3 do
		Sleep(0)
		total += __wf_atom_03df4e1d()

		if __wf_atom_7e8ad928(entity) then
			return
		else
			entity:SetPosition(__wf_atom_f55d6358(v13, groundPos, (math.min(1, total / 3))))
		end
	end

	entity:SetPosition(groundPos)
	local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(v2)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:FirePort("Destroy")
	end
end

local function fn4()
	v4:__wf_atom_0e990c03(v.ALLCLEAR)
	v4:Activate()

	while v4:__wf_atom_b81a6e66() do
		Sleep(0)
	end
end

local function fn5(p, p2, position, minValue, maxValue)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(p2, position, minValue, maxValue)
	local pointInstances = module.FindPointInstances(p, nil, p2)
	local mergeTables = module2.MergeTables(__wf_atom_439c0d29, pointInstances, true)
	local v13

	if not (__wf_atom_7e8ad928(mergeTables) or not (#mergeTables > 0)) then
		return mergeTables[math.random(1, #mergeTables)]
	end

	return v13
end

function SetupOdeSignals(instance)
	v5 = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(v5) or not v5:IsA(__wf_atom_f806fd7a) or math.random() > chanceToSpawn then
		instance:Destroy()
		return
	end

	local position = v5:GetPosition()
	local v13 = Vector(25421.85, 12657.18, 2130.492)
	local minValue = spawnRange.minValue or 0
	local maxValue = spawnRange.maxValue

	if maxValue == 0 then
		maxValue = v5:__wf_atom_103377cc()
	end

	local v14 = fn5(v5, v8, position, minValue, maxValue)
	local v15 = fn5(v5, v9, position, minValue, maxValue)

	if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v15) then
		instance:Destroy()
		return
	end

	local v16 = __wf_atom_fa8d0177(v15:GetPosition(), v13)
	local entity = gRegion:CreateEntity(odeSignalsConsoleType, v14:GetPosition(), v14:__wf_atom_dc309f8a())
	v5:__wf_atom_d494454b(entity)
	v4 = gRegion:CreateEntity(odeSignalsBeaconType, v15:GetPosition(), v16)
	v5:__wf_atom_d494454b(v4)
	v4:SetVisibility(true, true)
	v4:Enable()
	v14:FirePort("Disable")
	v15:FirePort("Disable")
	local __wf_atom_6199ef01 = v5:__wf_atom_6199ef01()

	if isSiegeEncounter then
		__wf_atom_6199ef01 = v5:__wf_atom_be637430()
	end

	module.CleanUpOutOfRangeEnemies(v5, __wf_atom_6199ef01)

	for _, v17 in ipairs(__wf_atom_6199ef01) do
		if __wf_atom_7e8ad928(v17) or v17:__wf_atom_1bb5b1ff() ~= casterAgentType then
			continue
		end

		v7 = v17
		local nearestTagged = gRegion:FindNearestTagged(v10, v7:__wf_atom_50a7d83e():GetPosition())

		if __wf_atom_7e8ad928(nearestTagged) then
			break
		end

		v7:__wf_atom_89b5b38c(nearestTagged)
		break
	end

	if __wf_atom_7e8ad928(v7) then
		v3 = module2.WaitForAiDir()

		if v10 ~= EMPTY_SYMBOL then
			local v17 = fn5(v5, v10, position, minValue, maxValue)

			if not __wf_atom_7e8ad928(v17) then
				position = v17:GetPosition()
			end
		end

		local enemyLevel = module.GetEnemyLevel(v5)
		local v17 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		v7 = v3:__wf_atom_402b3832(casterAgentType, position, v5:__wf_atom_dc309f8a(), Symbol("RandomTeam"), v17)
		v5:__wf_atom_97f955c1(v7)
	end

	while not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v7)) do
		if __wf_atom_7e8ad928(v5) or v5:__wf_atom_4026dfb5() == 6 or v5:__wf_atom_3634e6d2(true) <= 0 then
			instance:Destroy()
			return
		end

		if v5:__wf_atom_04ea4887() then
			break
		end

		local __wf_atom_d8853f2a = v7:__wf_atom_d8853f2a()

		if
			__wf_atom_7e8ad928(__wf_atom_d8853f2a)
			or not (#__wf_atom_d8853f2a > 0 and __wf_atom_d8853f2a[1].visible)
		then
			Sleep(0)
		else
			break
		end
	end

	if __wf_atom_7e8ad928(v5) then
		instance:Destroy()
		return
	end

	v6 = entity:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	if __wf_atom_7e8ad928(v6) then
		instance:Destroy()
		return
	end

	v6:Enable()
	module4.EnableSequencerAttachments(v4, true, Symbol("SignalEnemyAlertedAlarm"))
	__wf_atom_55142dd4(v6, "OnFinished", fn)

	if not __wf_atom_7e8ad928(v7) then
		v7:__wf_atom_aa4361c1(Symbol("UseAction"), v6, 2, 1)
	end

	local __wf_atom_e919fb8e = v6:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.interactionActivated = false
	local v17

	while true do
		v17 = v6:__wf_atom_e919fb8e()

		if v17 == nil then
			if not __wf_atom_7e8ad928(v6) then
				v6:__wf_atom_e919fb8e()
			end
		elseif v17.interactionActivated ~= nil and v17.interactionActivated then
			break
		end

		Sleep(2)
	end

	if __wf_atom_7e8ad928(v5) then
		instance:Destroy()
		return
	end

	if v17.instigator:IsA(__wf_atom_9e85eea2) then
		fn2()
	elseif v17 ~= nil then
		while v17.selectedChoice == nil do
			if __wf_atom_7e8ad928(v5) then
				instance:Destroy()
				return
			else
				Sleep(2)
			end
		end

		if v17.selectedChoice.Text == Localize(v11, false) then
			fn2()
		elseif v17.selectedChoice.Text == Localize(v12, false) then
			fn3()
		else
			fn4()
			v6:Destroy()
		end
	end

	instance:Destroy()
end