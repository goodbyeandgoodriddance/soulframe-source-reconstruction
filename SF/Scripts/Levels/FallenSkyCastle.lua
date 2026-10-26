local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.AncestorsFunctionLib")
require("SF.Scripts.Libs.RaycastLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.QuestLib")

function ActivateTransmission(_)
	if delay > 0 then
		Sleep(delay)
	end

	local wazzardTransmissionSet = wazzardTransmissionSet
	local wazzardTransmissionTag = wazzardTransmissionTag

	if isLocal then
		module.PlayLocalTransmission(wazzardTransmissionSet, wazzardTransmissionTag, gRegion:__wf_atom_c4f78a8f(), true)
	else
		module.PlayGlobalTransmission(wazzardTransmissionSet, wazzardTransmissionTag, true)
	end
end

local function fn(instance, p, p2)
	if __wf_atom_7e8ad928(instance) then
		local wazzardTransmissionSet = wazzardTransmissionSet

		if isLocal then
			module.PlayLocalTransmission(wazzardTransmissionSet, p, gRegion:__wf_atom_c4f78a8f(), p2)
		else
			module.PlayGlobalTransmission(wazzardTransmissionSet, p, p2)
		end
	else
		instance:SetVisibility(true, true)
		instance:__wf_atom_68f2c268(0)
		instance:Attach(dissolveInFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local wazzardTransmissionSet = wazzardTransmissionSet

		if isLocal then
			module.PlayLocalTransmission(wazzardTransmissionSet, p, gRegion:__wf_atom_c4f78a8f(), true)
		else
			module.PlayGlobalTransmission(wazzardTransmissionSet, p, true)
		end

		if not __wf_atom_7e8ad928(instance) then
			gRegion:CreateEntity(dissolveOutFx, instance:GetPosition(), instance:__wf_atom_2f2bada0(), instance)
			local v = 0

			while v < 1 do
				v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / dissolveDuration, 0, 1)
				instance:__wf_atom_68f2c268(v)
				Sleep(0)
			end

			instance:SetVisibility(false, true)
			instance:Destroy()
		end
	end
end

local function fn2(p, p2, p3)
	if __wf_atom_7e8ad928(p) then
		local wazzardTransmissionSet = wazzardTransmissionSet

		if isLocal then
			module.PlayLocalTransmission(wazzardTransmissionSet, p2, gRegion:__wf_atom_c4f78a8f(), true)
		else
			module.PlayGlobalTransmission(wazzardTransmissionSet, p2, true)
		end
	else
		local v = { distance = 8, minSpawnDist = 4, maxSpawnVerticalDist = 3, tryBehind = false }
		local v2

		if __wf_atom_7e8ad928(p3) then
			v2 = module2.TryAppearRelativeToPlayer(p, wazzardDecoType, p, v, true)

			if not __wf_atom_7e8ad928(v2) then
				local position = v2:GetPosition()
				position.y += 2
				v2:SetPosition(position)
			end
		else
			v2 = module2.AppearAtPosition(p, wazzardDecoType, p3, nil)
		end

		fn(v2, p2, true)
	end
end

function ActivateAtWaypoint(p, p2)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if delay > 0 then
		Sleep(delay)
	end

	if __wf_atom_7e8ad928(spawnWaypoint) then
		spawnWaypoint = p
	end

	fn(module2.AppearAtPosition(p2, wazzardDecoType, spawnWaypoint:GetPosition(), nil), wazzardTransmissionTag, true)
end

function InitializeSkyCastle(_)
	module3.WaitForLevel()
	module3.WaitForAiDir()

	if #blockedDuringQuests > 0 and module4.AnyQuestIsActive(blockedDuringQuests) then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local all = gRegion:FindAll(__wf_atom_f806fd7a)
	local v = 99
	local v2 = nil

	for i = 1, #all do
		local v3 = all[i]

		if
			__wf_atom_7e8ad928(v3)
			or not __wf_atom_7e8ad928(v3:__wf_atom_dd85e6db())
			or v3:__wf_atom_4026dfb5() ~= 0
		then
			continue
		end

		local __wf_atom_19688c5e = v3:__wf_atom_19688c5e()

		for _, v4 in ipairs(__wf_atom_19688c5e) do
			if v4 ~= Symbol("MendicantAmbush") then
				continue
			end

			local layerIndex = module3.GetLayerIndex(v3)

			if not (layerIndex < v) then
				continue
			end

			v2 = v3
			v = layerIndex
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		local __wf_atom_19688c5e = v2:__wf_atom_19688c5e()

		for _, v3 in ipairs(__wf_atom_19688c5e) do
			if v3 ~= Symbol("MendicantAmbush") then
				v2:__wf_atom_61860938(v3)
			end
		end

		__wf_atom_7d789620:PrimeMissionOnHint(Symbol("MT_AMBUSH"), v2)
	end

	Sleep(2)
	local wazzardTransmissionSet = wazzardTransmissionSet
	local v3 = Symbol("EnteringInvitingTaunting")

	if isLocal then
		module.PlayLocalTransmission(wazzardTransmissionSet, v3, gRegion:__wf_atom_c4f78a8f(), true)
	else
		module.PlayGlobalTransmission(wazzardTransmissionSet, v3, true)
	end

	local v4 = false
	local v5 = false

	while not (v4 and v5) do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v6 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v6) then
				continue
			end

			local playerIsInBattle = module3.PlayerIsInBattle(v6)
			local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(v6:GetPosition())

			if not playerIsInBattle then
				continue
			end

			local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(__wf_atom_9e85eea2, __wf_atom_0e0a6fee, 15)

			if
				__wf_atom_7e8ad928(__wf_atom_e2db08ce)
				or __wf_atom_e2db08ce:__wf_atom_e93896ba() == Symbol("Neutral")
				or __wf_atom_e2db08ce:__wf_atom_464a4772()
			then
				continue
			end

			if v5 or __wf_atom_e2db08ce:IsA(decapedeType) then
				if not v4 and __wf_atom_e2db08ce:IsA(decapedeType) then
					fn2(v6, Symbol("SummonDecapede"))
					v4 = true
				end
			else
				v5 = true
			end
		end

		Sleep(2)
	end
end

function PlayMendicantTransmission(object)
	local position = object:GetPosition()
	local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(position, 30)
	position.y += 5
	fn2(__wf_atom_06db1fb1, Symbol("SummonMendicantGrunts"), position)
end

function MonitorAmbushCondition(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if #blockedDuringQuests > 0 and module4.AnyQuestIsActive(blockedDuringQuests) then
		return
	end

	local __wf_atom_103377cc = __wf_atom_3d96ddcd:__wf_atom_103377cc()
	gRegion:__wf_atom_ef7900cf()
	local v = nil

	while __wf_atom_7e8ad928(v) do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v2 in ipairs(__wf_atom_ef7900cf) do
			if v2:__wf_atom_1c8f7b2d(__wf_atom_3d96ddcd) <= __wf_atom_103377cc then
				v = v2
			end
		end

		Sleep(1)

		if _T.SkyCastleMendicantTransmissionPlayed then
			return
		end
	end

	_T.SkyCastleMendicantTransmissionPlayed = true
	__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("PlayMendicantTransmission"), false)
	Sleep(3)
end