module(..., package.seeall)
local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.StatsLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module7 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = Type("/SF/Fx/Characters/Ancestors/AncestorFlare")
local v2 = Type("/SF/Fx/Characters/Ancestors/AncestorExitFlare")
local v3 = Type("/SF/Fx/Characters/Ancestors/AncestorAttachFX")
local v4 = nil
local v5 = nil

local function fn(p, p2, p3, p4)
	local v6 = __wf_atom_f55d6358(p, p2, p3)
	local v7 = math.sin(p3 * 3.141592653589793 * 2 * 3) * 1
	local v8 = math.sin(2 + p3 * 3.141592653589793 * 2 * 3) * 2
	local v9 = math.sin(5 + p3 * 3.141592653589793 * 2 * 3) * 1
	return v6 + Vector(v7, v8, v9) * __wf_atom_24a82b69(p4)
end

local function fn2(p, callback, ...)
	if not __wf_atom_7e8ad928(gGameData) and gGameData:__wf_atom_852b2680() ~= p then
		return
	end

	if callback then
		callback(...)
	end

	repeat
		Sleep(1)
	until not __wf_atom_7e8ad928(gGameData) and gGameData:__wf_atom_852b2680() ~= p
end

local function fn3(callback, ...)
	if callback then
		callback(...)
	end

	repeat
		Sleep(1)
	until not __wf_atom_7e8ad928(gGameData) and gGameData:__wf_atom_852b2680() == nil
end

local function fn4(object, distance, p)
	local v6 = p or object:__wf_atom_a06d543c()
	local v7 = { __wf_atom_4ebf67cb }
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	__wf_atom_a2a18137.y = object:EyePosition().y
	local v8 = __wf_atom_a2a18137 + v6 * distance
	local v9 = Vector()

	if not gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137, v8, v7, nil, v9) then
		v9 = v8
	end

	local __wf_atom_0e0a6fee = v5:__wf_atom_0e0a6fee(v9)
	local groundPos = module3.GetGroundPos(
		__wf_atom_0e0a6fee,
		__wf_atom_28d5d4aa,
		Vector(0, -5, 0),
		nil,
		__wf_atom_28d5d4aa
	)

	if groundPos == __wf_atom_28d5d4aa then
		return nil
	end

	return groundPos
end

function DissolveIn(object, p, p2, p3)
	object:SetVisibility(true, true)
	local v6 = object:GetPosition() + Vector(0, 1, 0)

	if __wf_atom_7e8ad928(p) then
		v4 = v6 + Vector(math.random(-30, 30), math.random(-10, 30), math.random(-30, 30))
	else
		v4 = p
	end

	local v7 = gRegion:IsMaster() and 3 or 4
	local entity = gRegion:CreateEntity(v, v4, Rotation(), nil, nil, v7)
	object:__wf_atom_68f2c268(1)
	local v8 = 0

	while v8 < 1 and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(entity)) do
		v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93() * 0.5, 0, 1)
		entity:SetPosition((fn(v4, v6, math.pow(v8, 0.5), 1 - v8)))
		object:__wf_atom_68f2c268(1 - math.pow(__wf_atom_421b01aa(v8 - 0.5, 0, 1) * 2, 10))
		local v9 = math.pow(v8, 0.25)
		entity:__wf_atom_008aae7f(v9)
		local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_d00f34c2)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_edd3fec6(v9)
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		gRegion:__wf_atom_dd1e4d10(entity)
	end

	if not __wf_atom_7e8ad928(object) then
		if __wf_atom_7e8ad928(p3) then
			object:Attach(v3, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		else
			object:Attach(p3, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	if not __wf_atom_7e8ad928(p2) then
		module2.EnableTaggedSequencers(p2, true)
	end
end

function DissolveOut(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(p3) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v3)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	else
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(p3)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	object:SetVisibility(false, true)
	v4 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3"))

	if __wf_atom_7e8ad928(p) then
		p = v4 + Vector(math.random(-30, 30), math.random(-1, 10), math.random(-30, 30))
	end

	local v6 = gRegion:IsMaster() and 3 or 4
	local entity = gRegion:CreateEntity(v2, v4, Rotation(), nil, nil, v6)
	local v7 = 0

	while v7 < 1 do
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93() * 0.2, 0, 1)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetPosition((fn(v4, p, __wf_atom_24a82b69(v7), v7)))
			local v8 = math.pow(1 - v7, 2)
			entity:__wf_atom_008aae7f(v8)
			local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_d00f34c2)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_edd3fec6(v8)
			end
		end

		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(entity)

	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(false, true)
	end
end

function GetNearbyMarkedSpawnPos(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("AncestorSpawnTrigger"),
		object:__wf_atom_a2a18137(),
		0,
		20
	)

	for k, v6 in pairs(__wf_atom_439c0d29) do
		if not (v6:IsA(__wf_atom_f53c239e) or v6:__wf_atom_4b409d7b(object)) then
			continue
		end

		for k2, v7 in pairs(v6:__wf_atom_be0bea4a()) do
			if not (v7:IsA(__wf_atom_7e616794) and v7:HasTag(Symbol("AncestorSpawnPoint"))) then
				continue
			end

			local groundPos = module3.GetGroundPos(
				v7:__wf_atom_a2a18137(),
				__wf_atom_28d5d4aa,
				Vector(0, -5, 0),
				nil,
				__wf_atom_28d5d4aa
			)

			if groundPos ~= __wf_atom_28d5d4aa then
				return groundPos
			end
		end
	end

	return nil
end

function AppearAtPosition(object, p, p2, object2, p3, p4)
	module6.WaitForLevel()
	module6.WaitForLoginSequence()
	local v6 = p4 or gRegion:IsMaster() and 3 or 4
	local entity = gRegion:CreateEntity(p, p2, Rotation(), nil, nil, v6)
	entity:__wf_atom_68f2c268(0)
	local v7

	if __wf_atom_7e8ad928(object) then
		v7 = gRegion:__wf_atom_c4f78a8f():__wf_atom_a2a18137()
	else
		v7 = object:__wf_atom_a2a18137()
	end

	if not __wf_atom_7e8ad928(object2) then
		v7 = object2:__wf_atom_a2a18137()
	end

	local v8 = __wf_atom_fa8d0177(entity:GetPosition(), v7)

	if not __wf_atom_7e8ad928(p3) then
		v8 = p3
	end

	v8.pitch = 0
	v8.bank = 0
	entity:__wf_atom_9b788a35(v8)
	return entity
end

function TryAppearRelativeToPlayer(object, p, p2, p3, p4)
	local v6 = nil

	while __wf_atom_7e8ad928(v6) do
		if p3.validateFunc == nil or p3.validateFunc() then
			if __wf_atom_7e8ad928(object) then
				object = gRegion:__wf_atom_c4f78a8f()
			else
				local v7 = GetNearbyMarkedSpawnPos(object)

				if v7 then
					if object:__wf_atom_a5304c35(v7) > 1.5 then
						v6 = AppearAtPosition(object, p, v7, p2)
					end
				else
					v6 = TryAppearInfrontOfPlayer(object, p, p2, p3, false)
				end
			end
		end

		if not __wf_atom_7e8ad928(v6) then
			continue
		end

		if __wf_atom_7e8ad928(p4) or not p4 then
			break
		else
			Sleep(2)
		end
	end

	return v6
end

function TryAppearInfrontOfPlayer(object, p, p2, data, p3)
	if __wf_atom_7e8ad928(v5) then
		v5 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local distance = data.distance or 7
	local minSpawnDist = data.minSpawnDist or 1
	local maxSpawnVerticalDist = data.maxSpawnVerticalDist or 2
	local tryBehind = data.tryBehind or false
	local v6 = nil

	while __wf_atom_7e8ad928(v6) do
		if __wf_atom_7e8ad928(object) then
			object = gRegion:__wf_atom_c4f78a8f()
		end

		if object then
			local v7 = fn4(object, distance, object:__wf_atom_a06d543c())
			local v8 = not v7

			if not v8 then
				if minSpawnDist <= object:__wf_atom_d5fda8be(v7) then
					v8 = math.abs(v7.y - object:GetPosition().y) <= maxSpawnVerticalDist
				else
					v8 = false
				end
			end

			if v7 == nil then
				v8 = false
			end

			if not v8 and tryBehind then
				local v9
				v7, v9 = fn4(object, distance, object:__wf_atom_a06d543c() * -1)
				_ = v9
				v8 = not v7

				if not v8 then
					if minSpawnDist <= object:__wf_atom_d5fda8be(v7) then
						v8 = math.abs(v7.y - object:GetPosition().y) <= maxSpawnVerticalDist
					else
						v8 = false
					end
				end

				if v7 == nil then
					v8 = false
				end
			end

			if v8 then
				v6 = AppearAtPosition(object, p, v7, p2)
			end
		end

		if not __wf_atom_7e8ad928(v6) then
			continue
		end

		if __wf_atom_7e8ad928(p3) or not p3 then
			break
		else
			Sleep(2)
		end
	end

	return v6
end

function PlayAncestorTransmission(p, p2, object, p3, items, p4, p5)
	local v6 = p5 == nil or p5

	if not __wf_atom_7e8ad928(items) then
		for k, item in pairs(items) do
			if item == p2 then
				module4.ReplicateLogEvent("STAG_QUEST", "StartStagPuzzle")
			end
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(object)) then
		object:PlayTriggeredAnim(p3)
	end

	if object:IsClientOnly() or object:__wf_atom_3eb2b0a9() and not p4 then
		module5.PlayLocalTransmission(p, p2, __wf_atom_c4f78a8f, v6)
	else
		module5.PlayGlobalTransmission(p, p2, v6)
	end

	while _T.KeepDialogAncestorActive do
		Sleep(0)
	end
end

function GetLocalPlayerAncestors(p, p2, p3, ...)
	if p2 then
		fn2(p, p3, ...)
	end

	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return nil
	end

	return inventory:__wf_atom_a87d87b5()
end

function GetLocalPlayerAncestorOfType(p, p2, p3, ...)
	local v6 = GetLocalPlayerAncestors(p, p2, p3, ...)

	for i, v7 in ipairs(v6) do
		if v7.mType == p then
			return v7
		end
	end

	return nil
end

function GetAncestorLevelForUpgrade(p, p2)
	if __wf_atom_7e8ad928((GetLocalPlayerAncestorOfType(p))) then
		return 0
	end

	return Resource(p):__wf_atom_5e4b2220(p2)
end

function GetAncestorUpgradeRankValueForTag(p, p2, p3)
	local v6 = Resource(p)

	if __wf_atom_7e8ad928(v6) then
		return 0
	end

	return v6:__wf_atom_af51b5ec(p2, p3)
end

function GetAncestorHasUpgradeTagAndQuestSet(p, p2, p3)
	local v6 = Resource(p)

	if __wf_atom_7e8ad928(v6) then
		return 0
	end

	return v6:__wf_atom_99672b20(p2, p3)
end

function GetAncestorRankLocalizeTag(p, p2, p3)
	local v6 = Resource(p)

	if __wf_atom_7e8ad928(v6) then
		return 0
	end

	return v6:__wf_atom_4aef631c(p2, p3)
end

function GetAncestorRankLocalizeDescTag(p, p2, p3)
	local v6 = Resource(p)

	if __wf_atom_7e8ad928(v6) then
		return 0
	end

	return v6:__wf_atom_d48c73c9(p2, p3)
end

function GetAncestorRankIcon(p, p2, p3)
	if __wf_atom_7e8ad928((GetLocalPlayerAncestorOfType(p))) then
		return 0
	end

	return Resource(p):__wf_atom_430346b6(p2, p3)
end

function GetAncestorListOfUpgradeTagsForQuest(p, p2)
	if __wf_atom_7e8ad928((GetLocalPlayerAncestorOfType(p))) then
		return 0
	end

	return Resource(p):__wf_atom_0942f434(p2)
end

function GetAncestorRank(p, p2, p3, ...)
	if p2 then
		fn2(p, p3, ...)
	end

	if __wf_atom_7e8ad928(gGameData) then
		return 0
	end

	local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

	for i, v6 in ipairs(__wf_atom_a87d87b5) do
		if v6.mType == p then
			return v6.mRank
		end
	end

	return 0
end

function GetAllAncestorRankTasks(object, p, p2, ...)
	if p then
		fn2(object, p2, ...)
	end

	local result = { Resource() }

	for i = 0, object:__wf_atom_d5b255f8() do
		table.insert(result, object:__wf_atom_9c773049(i))
	end

	return result
end

function GetAncestorsWithRank(p, p2, p3, ...)
	local result = {}

	if p < -1 then
		print("Can't check for ancestors with invalid rank: " .. tostring(p))
		return nil
	end

	if p2 then
		fn3(p3, ...)
	end

	if __wf_atom_7e8ad928(gGameData) then
		return result
	end

	local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

	for i, v6 in ipairs(__wf_atom_a87d87b5) do
		if v6.mRank == p then
			table.insert(result, v6)
		end
	end

	return result
end

function GetAncestorXP(p)
	if __wf_atom_7e8ad928(gGameData) then
		return 0
	end

	local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

	for i, v6 in ipairs(__wf_atom_a87d87b5) do
		if v6.mType == p then
			return v6.mXP
		end
	end

	return 0
end

function CheckAncestorIntroState(p, p2, p3)
	if p.mRank <= 0 and module.TaggedTaskIsActive(p2, p3) then
		return true, p2, p3
	end

	return false
end

function CheckForPendingRankUpFromXP(object)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameData:GetInventory()) then
		return false
	end

	local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

	for i, v6 in ipairs(__wf_atom_a87d87b5) do
		if v6.mType ~= object then
			continue
		end

		local v7 = object:__wf_atom_d5b255f8() - 1
		return v6.mRank ~= v7 and v6.mXP >= object:__wf_atom_071f014c(v6.mRank + 1)
	end

	return false
end

function CheckForPendingRankUp(p)
	local v6 = GetAllAncestorRankTasks(p)
	local v7 = Symbol("RankCompleted")

	for i, v8 in ipairs(v6) do
		if
			i == GetAncestorRank(p, false) + 1
			and (module.TaggedTaskIsActive(v8, v7) or module.HasCompletedQuest(v8))
		then
			return true, module.GetAcceptedQuestFromType(v8), v7
		end
	end

	return false
end

function GetActiveRankUPQuest(p)
	local v6 = GetAllAncestorRankTasks(p)

	for i, v7 in ipairs(v6) do
		if module.QuestIsActive(v7) then
			return v7
		end
	end
end

function StartAncestorRankUps(p, object, p2)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v6 = GetLocalPlayerAncestorOfType(object, true)
	local v7 = GetAllAncestorRankTasks(object, true)

	for k, v8 in pairs(v7) do
		if not module.QuestIsActive(v8) then
			continue
		end

		print("RankQuestIsActive")
		return
	end

	if v6.mRank == -1 then
		gGameData:RankUpAncestor(v6.mType, "OnAncestorCallback")
	end

	if not __wf_atom_7e8ad928(p2) then
		module6.GiveLoreFragment(p2, p)
	end

	if v6.mRank ~= object:__wf_atom_d5b255f8() and next(v7) ~= nil then
		local v8 = GetAncestorRank(object, true)

		if v8 < #v7 then
			local v9 = v8 + 1
			module.StartQuest(v7[v9])
		end
	end
end

function RankUpAncestorAndTryStartNextRank(p, object, p2, p3, p4)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v6 = GetLocalPlayerAncestorOfType(object, true)
	local v7 = GetAllAncestorRankTasks(object, true)
	local mRank = v6.mRank

	if not __wf_atom_7e8ad928(p3) and module.QuestIsActive(WeakResource(p3)) then
		module.CompleteTaskWithTag(p3, p4)
		gGameData:RankUpAncestor(v6.mType, "OnAncestorCallback")
		_T.Ancestor_PendingRankUp = false
	end

	if not __wf_atom_7e8ad928(p2) then
		module6.GiveLoreFragment(p2, p)
	end

	if v6.mRank ~= object:__wf_atom_d5b255f8() and next(v7) ~= nil then
		local v8 = GetAncestorRank(object, true)
		local v9 = v8 - mRank == 1

		if v8 < #v7 then
			if v9 then
				local v10 = v8 + 1
				module.StartQuest(v7[v10])
			else
				print("Can't start Rank " .. mRank + 1 .. " quest. RankUpAncestor must have failed.")
			end
		end
	end
end

function RefreshAncestorHudTrackers()
	local v6 = GetAncestorsWithRank(-1, true)
	local v7 = {}

	for i, v8 in ipairs(v6) do
		table.insert(v7, v8.mType:__wf_atom_5b41f63b())
	end

	local __wf_atom_c0dbe47c = UISys.__wf_atom_c0dbe47c(v7)

	while not __wf_atom_c0dbe47c:__wf_atom_86399a47() do
		Sleep(0.1)
	end

	for i, v8 in ipairs(v6) do
		local v9 = Type(v8.mType)
		local __wf_atom_c21a80eb = v9:__wf_atom_c21a80eb(0)

		if __wf_atom_7e8ad928(__wf_atom_c21a80eb) then
			continue
		end

		local personalCompletedQuest = module.GetPersonalCompletedQuest(__wf_atom_c21a80eb)

		if __wf_atom_7e8ad928(personalCompletedQuest) then
			continue
		end

		local c_str = v9:__wf_atom_5e1f5995(0):c_str()
		module7.AddHudTask(personalCompletedQuest, v9:__wf_atom_5b41f63b() .. "_0", v9:__wf_atom_5b41f63b(), c_str)
	end
end