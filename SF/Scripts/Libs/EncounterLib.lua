module(..., package.seeall)
local v = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("Lotus.Scripts.Libs.Query")
local module4 = require("EE.Interface.Utilities")
local module5 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module6 = require("SF.Scripts.Libs.ChallengeLib")
local v2 = WeakResource("/EE/Types/Navigation/DynamicNavMeshVolume")
local v3 = WeakResource("/SF/Types/PickUps/LootContainers/LootChestBase")
local v4 = Symbol("Grineer")
local v5 = Symbol("NoHeavies")
local v6 = Symbol("BoostEnemies")
local v7 = Symbol("Chillout")
local v8 = Symbol("Alerted")
local v9 = Symbol("LootChestSpawnPt")
local v10 = Symbol("BlockMissionEncounters")
local v11 = Symbol("LootChest")
local v12 = Symbol("BlockingBehavior")
local v13 = Symbol("TENNO")
local v14 = Symbol("Neutral")
local v15 = Symbol("NoDynamicCombat")
local v16 = Symbol("MT_SUBBOSS")
local v17 = Symbol("MessengerZone")
local v18 = Symbol("StrongPointArea")
local v19 = WeakResource("/SF/Types/Player/NightFoldTransitionInputFilter")
local v20 = WeakResource("/SF/Types/Game/Encounters/Locations/DungeonEntranceHintUndercity")
local v21 = Resource("/SF/Types/Game/SquadList/OdeSquadList")
local _ = {
	{ tag = Symbol("OrlickTowerZone"), level = Range(1, 1) },
	{ tag = Symbol("GarrenQuestSpawnZone"), level = Range(3, 4) },
	{ tag = Symbol("BeginnerSpawnZone"), level = Range(3, 4) }
}
DEFAULT_TEAM = Symbol("RandomTeam")
STATE_STR = {
	[0] = "ES_NONE",
	[1] = "ES_SETUP",
	[2] = "ES_ACTIVE",
	[3] = "ES_COMPLETE",
	[4] = "ES_SUCCEEDED",
	[5] = "ES_FAILED",
	[6] = "ES_SHUTDOWN"
}
local v22 = nil
local v23 = { VadagarStagEncounter = "VadagarStag", MendicantKing = "MendicantKing" }
AS_RANDOM = 1
AS_SPECIFIC_ENCOUNTER_TYPE = 2
APS_NEAR_POS = 1
APS_SPECIFIC_POS = 2
APS_SPECIFIC_POS_WITH_TAGS = 3
APS_SPECIFIC_HINT = 4
APS_SPECIFIC_HINT_WITH_TAGS = 5
APS_ARRAY_POS = 6
local v24 = Symbol("HardModeActive")
local v25 = Symbol("HardModeEnemyLevel")
local v26 = Symbol("HardModeSubBossKillCount")
local v27 = Symbol("HardModeLevelIncrease")

local function fn(object)
	if not module.IsInOverworld() or __wf_atom_7e8ad928(object) then
		return 0
	end

	if __wf_atom_7e8ad928(v22) then
		v22 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	end

	if __wf_atom_7e8ad928(v22) then
		return 0
	end

	return v22:GetColor(object:GetPosition(), true).blue
end

local function fn2(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_19688c5e = object:__wf_atom_19688c5e()

	for _, v28 in ipairs(__wf_atom_19688c5e) do
		if p == v28 then
			return true
		end
	end

	local __wf_atom_cc31ec3f = object:__wf_atom_cc31ec3f()

	for _, v28 in ipairs(__wf_atom_cc31ec3f) do
		if v28 == p then
			return true
		end
	end

	return false
end

local function fn3(object) -- 2 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return
	else
		return object:__wf_atom_6f203663() == 2
	end
end

local function fn4(object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return
	else
		return object:__wf_atom_8077d924() == 2 or object:__wf_atom_8077d924() == 3
	end
end

local function fn5(p, object, p2, p3)
	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		return
	end

	if not p2 then
		local __wf_atom_4d26da3a = v:__wf_atom_4d26da3a(p, 1)

		if module.Distance2d(__wf_atom_4d26da3a, p) < 1 then
			return
		end
	end

	if not p3 then
		local __wf_atom_d7d7201a = __wf_atom_dd85e6db:__wf_atom_d7d7201a()

		for _, v28 in ipairs(__wf_atom_d7d7201a) do
			local __wf_atom_6e164b9d = v:__wf_atom_6e164b9d(v28)

			for _, v29 in ipairs(__wf_atom_6e164b9d) do
				if not (v29:IsEnabled() and v29:__wf_atom_a5304c35(p) < v29:__wf_atom_8f18e876()) then
					continue
				end

				local __wf_atom_ba2e9888 = v29:__wf_atom_ba2e9888()

				if not (__wf_atom_ba2e9888 > 0 and p.y > v29:GetPosition().y + __wf_atom_ba2e9888) then
					return false
				end
			end
		end
	end

	if not p2 then
		return true
	end

	local encounterHints = v:SelectEncounterHints(v18, 0, 3.4028234663852886e38, p, 0, 80)

	for _, encounterHint in ipairs(encounterHints) do
		if encounterHint:IsEnabled() and encounterHint:__wf_atom_a5304c35(p) < encounterHint:__wf_atom_103377cc() then
			return false
		end
	end

	return true
end

local function fn6(object, className)
	local __wf_atom_fe00d825 = object:__wf_atom_fe00d825()
	local result = {}

	for _, v28 in ipairs(__wf_atom_fe00d825) do
		if v28:IsA(className) then
			table.insert(result, v28)
		end
	end

	return result
end

local function fn7(object, className)
	local __wf_atom_fe00d825 = object:__wf_atom_fe00d825()

	for _, v28 in ipairs(__wf_atom_fe00d825) do
		if v28:IsA(className) then
			return v28
		end
	end
end

function RemoveObjects(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_fe00d825 = object:__wf_atom_fe00d825()

	for _, v28 in pairs(__wf_atom_fe00d825) do
		if __wf_atom_7e8ad928(v28) then
			continue
		end

		if v28:IsA(v2) then
			v28:FirePort("Enable")
		else
			if __wf_atom_7e8ad928(p) and v28:IsA(v3) then
				p = v9
			end

			if not __wf_atom_7e8ad928(p) and p ~= EMPTY_SYMBOL then
				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(p, v28:GetPosition(), 0, 1)

				if not __wf_atom_7e8ad928(__wf_atom_f738b4af) and __wf_atom_f738b4af:IsA(v2) then
					__wf_atom_f738b4af:FirePort("Enable")
				end
			end

			if not p2 then
				v28:Destroy()
			end

			if not __wf_atom_7e8ad928(v28) then
				gRegion:__wf_atom_dd1e4d10(v28)
			end
		end
	end
end

function GetNearbyPlayers(p, p2, p3)
	local v28 = p3 or gRegion:__wf_atom_ef7900cf()

	for i = #v28, 1, -1 do
		if p2 < v28[i]:__wf_atom_d5fda8be(p) then
			table.remove(v28, i)
		end
	end

	return v28
end

function FindPointInstances(object, className, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_62b7d4c2 = object:__wf_atom_62b7d4c2()

	for i = #__wf_atom_62b7d4c2, 1, -1 do
		if not (__wf_atom_7e8ad928(__wf_atom_62b7d4c2[i]) or not (__wf_atom_7e8ad928(__wf_atom_62b7d4c2[i]) or __wf_atom_7e8ad928(className) or __wf_atom_62b7d4c2[i]:IsA(className))) then
			continue
		end

		table.remove(__wf_atom_62b7d4c2, i)
	end

	for i = #__wf_atom_62b7d4c2, 1, -1 do
		if __wf_atom_7e8ad928(p) or __wf_atom_62b7d4c2[i]:__wf_atom_db682341() == p then
			continue
		end

		table.remove(__wf_atom_62b7d4c2, i)
	end

	return __wf_atom_62b7d4c2
end

function FindTaggedInstanceRef(object, p)
	local __wf_atom_62b7d4c2 = object:__wf_atom_62b7d4c2()

	for _, v28 in ipairs(__wf_atom_62b7d4c2) do
		if not __wf_atom_7e8ad928(v28) and v28:__wf_atom_db682341() == p then
			return v28
		end
	end
end

function GetHintWithRegisteredObject(list, p)
	for _, v28 in ipairs(list) do
		local __wf_atom_fe00d825 = v28:__wf_atom_fe00d825()

		for _, v29 in ipairs(__wf_atom_fe00d825) do
			if v29 == p then
				return v28
			end
		end
	end
end

function GetRegisteredObjectsOfType(p, p2)
	return (fn6(p, p2))
end

function GetFirstRegisteredObjectOfType(p, p2)
	return fn7(p, p2)
end

function SetEncounterHeaviesBlocked(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif p then
		object:__wf_atom_ed6d3248(v5)
	else
		object:__wf_atom_68e563a5(v5)
	end
end

function GetEncounterHeaviesBlocked(p)
	return fn2(p, v5)
end

function SetEncounterChillout(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif p then
		object:__wf_atom_ed6d3248(v7)
	else
		object:__wf_atom_68e563a5(v7)
	end
end

function GetEncounterChillout(p)
	return fn2(p, v7)
end

function SetEncounterAlerted(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif p then
		object:__wf_atom_ed6d3248(v8)
	else
		object:__wf_atom_68e563a5(v8)
	end
end

function GetEncounterAlerted(p)
	return fn2(p, v8)
end

function SetEncounterBoostEnemies(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif p then
		object:__wf_atom_ed6d3248(v6)
	else
		object:__wf_atom_68e563a5(v6)
	end
end

function GetEncounterBoostEnemies(p)
	return fn2(p, v6)
end

function SetMissionEncounterAllowed(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif not __wf_atom_7e8ad928(object) then
		if p then
			object:__wf_atom_68e563a5(v10)
		else
			object:__wf_atom_ed6d3248(v10)
		end
	end
end

function SetMissionEncounterAllowedOnTagged(p, p2)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsA(__wf_atom_f806fd7a) then
		if p2 then
			__wf_atom_0a6a5887:__wf_atom_68e563a5(v10)
		else
			__wf_atom_0a6a5887:__wf_atom_ed6d3248(v10)
		end
	end
end

function SetDynamicCombatAllowed(object, p)
	if not gRegion:IsMaster() then
		print("Error: Trying to add tag as client")
	elseif p then
		object:__wf_atom_61860938(v15)
	else
		object:__wf_atom_1f5c6559(v15)
	end
end

function GetMissionEncounterAllowed(p)
	return not fn2(p, v10)
end

function EncounterHintHasTag(p, p2)
	return fn2(p, p2)
end

function GetAvailableEncounterHintsWithTag(p, list)
	if __wf_atom_7e8ad928(list) then
		list = gRegion:FindAll(__wf_atom_f806fd7a)
	end

	if __wf_atom_7e8ad928(list) or #list == 0 then
		return
	end

	local result = {}

	for _, v28 in ipairs(list) do
		if not fn2(v28, p) or v28:__wf_atom_4026dfb5() ~= 0 or v28:__wf_atom_f43d338d() or not v28:IsEnabled() then
			continue
		end

		if v28:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL then
			continue
		end

		table.insert(result, v28)
	end

	return result
end

function SetEncounterHintsEnabledByTags(list, p)
	for _, v28 in ipairs(list) do
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v28)

		for _, v29 in ipairs(__wf_atom_2226b35c) do
			if p then
				v29:Enable()
			else
				v29:Disable()
			end
		end
	end
end

function EnableFortificationHints(object)
	local v28 = Symbol("Fortify")
	local __wf_atom_4ceec546 = object:__wf_atom_4ceec546()

	if not __wf_atom_7e8ad928(__wf_atom_4ceec546) then
		local __wf_atom_0d7f3535 = __wf_atom_4ceec546:__wf_atom_0d7f3535()

		for _, v29 in ipairs(__wf_atom_0d7f3535) do
			if v29:IsEnabled() or not fn2(v29, v28) then
				continue
			end

			v29:Enable()
		end
	end
end

function SpawnCombatBlockingContainer(p, p2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local entity = gRegion:CreateEntity(p, p2, __wf_atom_80368bb1)
	v:__wf_atom_ccbb5582(entity)
	return entity
end

function DisableNearbyEncounters(object, p, p2)
	local v28 = WeakResource("/SF/Types/Game/Encounters/ContainerHints/DynamicContainerHint")
	local all = gRegion:FindAll(__wf_atom_f806fd7a, object:GetPosition(), p.minValue, p.maxValue)

	for _, v29 in ipairs(all) do
		if __wf_atom_7e8ad928(v29) or v29 == object or v29:IsA(v28) then
			continue
		end

		if p2 and (v29:__wf_atom_4026dfb5() == 2 or v29:__wf_atom_4026dfb5() == 1) then
			v29:__wf_atom_8e6fec76(6)
		end

		if v29:__wf_atom_3634e6d2() > 0 then
			RemoveAgents(v29)
		end

		v29:Disable()
	end

	return all
end

function RemoveMissionMarker(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v28 = WeakResource("/SF/Types/Game/MarkerInfos/EncounterMarkerInfo")
	local __wf_atom_fe00d825 = object:__wf_atom_fe00d825()

	for i = #__wf_atom_fe00d825, 1, -1 do
		if __wf_atom_fe00d825[i]:IsA(v28) then
			__wf_atom_fe00d825[i]:Destroy()
		end
	end
end

function GetRegisteredAreaMarker(p)
	return (fn7(p, WeakResource("/SF/Types/Game/MarkerInfos/EncounterMarkerInfoArea")))
end

function CreateAreaMarker(p, p2, p3, p4)
	if p4 then
		if __wf_atom_7e8ad928(v) then
			v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		end

		p2 = v:__wf_atom_0e0a6fee(p2)
	end

	local entity = gRegion:CreateEntity(p, p2, __wf_atom_80368bb1)
	entity:__wf_atom_400189c4(p3)
	return entity
end

function WaitForEncounterToStart(object, callback)
	print("WaitForEncounterToBegin: Started")

	while not Game.__wf_atom_2b221245(false) do
		if not __wf_atom_7e8ad928(callback) then
			callback()
		end

		if __wf_atom_7e8ad928(object) or not (object:__wf_atom_4026dfb5() < 2) then
			Sleep(0)
		else
			print("WaitForEncounterToBegin: Done")
			return true
		end
	end

	print("WaitForEncounterToBegin: Exit due to streaming")
	return false
end

function WaitForEncounterToFinish(object, callback)
	if __wf_atom_7e8ad928(object) then
		print("WaitForEncounterToFinish: Nil encounter")
		return false
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	print("WaitForEncounterToFinish: " .. __wf_atom_5b41f63b)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_f43d338d() then
		print("WaitForEncounterToFinish: Hint in cooldown" .. __wf_atom_5b41f63b)
		return true
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_4026dfb5() < 3 do
		if not __wf_atom_7e8ad928(callback) then
			callback()
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		print("WaitForEncounterToFinish: nil encounter " .. __wf_atom_5b41f63b .. ", likely streaming")
		return false
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 3 then
		print("WaitForEncounterToFinish: " .. __wf_atom_5b41f63b .. " succeeded")
		return true
	end

	print("WaitForEncounterToFinish: " .. __wf_atom_5b41f63b .. " failed or shutdown")
	return false
end

function ShouldShutDown(object, object2)
	if __wf_atom_7e8ad928(object) or Game.__wf_atom_2b221245(false) then
		print("ShouldShutDown: No EncounterHint / streaming in progress")
		return true
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 6 then
		print("ShouldShutDown: EncounterHint state was set to Npc.ES_SHUTDOWN")
		return true
	end

	local v28 = (__wf_atom_4026dfb5 >= 4 or object:ShouldShutDown()) and true or false

	if
		v28
		and not __wf_atom_7e8ad928(object2)
		and object2 ~= object
		and not object2:ShouldShutDown()
		and object2:__wf_atom_4026dfb5() == 2
	then
		v28 = false
	end

	if v28 and object:__wf_atom_c0b8d0bd() then
		local __wf_atom_e529dedd = object:__wf_atom_e529dedd()

		for _, v29 in pairs(__wf_atom_e529dedd) do
			if v29:IsRunningPrimedMission() then
				return false
			end
		end
	end

	return v28
end

function IsMissionEncounter(object)
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) or __wf_atom_dd85e6db:__wf_atom_55116686() == EMPTY_SYMBOL then
		return false
	end

	return true
end

local function fn8(object) -- 1 equivalent call inferred from this helper
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) or __wf_atom_dd85e6db:__wf_atom_55116686() == EMPTY_SYMBOL then
		return false
	end

	return true
end

function GetMissionEncounterForHint(object)
	local __wf_atom_e529dedd = object:__wf_atom_e529dedd()

	for _, v28 in ipairs(__wf_atom_e529dedd) do
		if fn8(v28) then -- inferred equivalent call
			return v28
		end
	end

	return nil
end

function PrimedMissionShouldShutDown(object, object2, list, value, p)
	local v28 = p == nil or p

	if __wf_atom_7e8ad928(object) or Game.__wf_atom_2b221245(false) then
		print("PrimedMissionShouldShutDown: No EncounterHint / streaming in progress")
		return true
	end

	if object:__wf_atom_4026dfb5() >= 3 then
		print("PrimedMissionShouldShutDown: State is " .. STATE_STR[object:__wf_atom_4026dfb5()])
		return true
	end

	if not object:ShouldShutDown() then
		return false
	end

	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if __wf_atom_7e8ad928(object2) then
		return false
	end

	if object2:ShouldShutDown() or object2:__wf_atom_4026dfb5() == 6 then
		print("PrimedMissionShouldShutDown: Parent hint shutdown")
		return true
	end

	local v29 = nil
	local __wf_atom_179042e1 = v:__wf_atom_179042e1()
	local __wf_atom_ffb1ce41 = object2:__wf_atom_ffb1ce41()
	local __wf_atom_ffb1ce41_2 = object:__wf_atom_ffb1ce41()

	if
		__wf_atom_179042e1 < __wf_atom_ffb1ce41
		or __wf_atom_ffb1ce41 < 0 and __wf_atom_179042e1 < __wf_atom_ffb1ce41_2
	then
		return false
	end

	if not __wf_atom_7e8ad928(list) and #list > 0 and not __wf_atom_7e8ad928(v29) then
		v29 = gRegion:__wf_atom_ef7900cf()
		local v30 = value or 100

		for _, v31 in ipairs(list) do
			if __wf_atom_7e8ad928(list) then
				continue
			end

			for _, v32 in ipairs(v29) do
				if not (v32:__wf_atom_1c8f7b2d(v31) < v30) then
					continue
				end

				object2:__wf_atom_a9a8d68e(__wf_atom_179042e1 + 10)
				return false
			end
		end
	end

	local __wf_atom_4a0ffa6e = object2:__wf_atom_4a0ffa6e()

	if not (object2:__wf_atom_b3bb0c43(__wf_atom_4a0ffa6e) == 0 and v28) then
		return false
	end

	if __wf_atom_7e8ad928(v29) then
		v29 = gRegion:__wf_atom_ef7900cf()
	end

	if __wf_atom_7e8ad928(v29) or #v29 == 0 then
		object2:__wf_atom_a9a8d68e(__wf_atom_179042e1 + 10)
		return false
	end

	for _, v30 in ipairs(v29) do
		if not (module.IsInNightFold(v30) or v30:__wf_atom_4dc54686():IsA(v19)) then
			continue
		end

		if not (object2:__wf_atom_a5304c35(v30:__wf_atom_4c2e0189()) < __wf_atom_4a0ffa6e) then
			continue
		end

		object2:__wf_atom_a9a8d68e(__wf_atom_179042e1 + 10)
		return false
	end

	print("PrimedMissionShouldShutDown: No players in encounter radius")
	return true
end

function WaitForParentEncounterActive(object)
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if not __wf_atom_7e8ad928(__wf_atom_dd85e6db) and __wf_atom_dd85e6db:__wf_atom_7026c43c() then
		return true
	end

	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()

	if
		__wf_atom_7e8ad928(__wf_atom_26b04ea9)
		or __wf_atom_26b04ea9 == object
		or __wf_atom_7e8ad928((__wf_atom_26b04ea9:__wf_atom_dd85e6db()))
	then
		return true
	end

	local v28 = 0

	while not __wf_atom_7e8ad928(__wf_atom_26b04ea9) and v28 < 2 do
		v28 = __wf_atom_26b04ea9:__wf_atom_4026dfb5()

		if v28 == 6 then
			return false
		else
			Sleep(0)
		end
	end

	return not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_26b04ea9))
end

function ActivateDecorativeEncounters(object, list)
	local position = object:GetPosition()
	local result = {}

	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	for _, v28 in ipairs(list) do
		if __wf_atom_7e8ad928(v28) or not v28:IsA(__wf_atom_af605003) then
			continue
		end

		v:AddEncounter(v28)
		table.insert(result, (v:__wf_atom_c4c644af(position, v28, object)))
	end

	return result
end

function AlertEnemies(object, p)
	local v28

	if p then
		v28 = object:__wf_atom_be637430()
	else
		v28 = object:__wf_atom_6199ef01()
	end

	for _, v29 in ipairs(v28) do
		v29:__wf_atom_30b587a4()
	end
end

function GetRandomSquadList(p, p2, value)
	local rounded = module4.Round(p)

	if rounded <= 0 then
		return
	end

	local v28 = p2 or v21
	math.min(rounded, v28:__wf_atom_33eff407())
	local randomSquad = v28:GetRandomSquad(rounded, value or 0)

	if randomSquad:__wf_atom_ccf6f519() < rounded then
		randomSquad:__wf_atom_f85fe802(0, 1, false, rounded - randomSquad:__wf_atom_ccf6f519())
	end

	return randomSquad:__wf_atom_c6d95510()
end

local function fn9(p)
	local v28 = tostring(p)

	if string.find(v28, "Heavy") then
		return 0, 2, true
	end

	if string.find(v28, "Ranged") then
		return 2, 1, false
	end

	if string.find(v28, "Grunt") then
		return 1, 1, false
	end

	if string.find(v28, "Special") then
		return 4, 1, false
	end

	if string.find(v28, "Dog") then
		return 5, 1, false
	end

	if string.find(v28, "Officer") then
		return 0, 3, true
	end

	return 0, 4, false
end

local function fn10(instance, p, position)
	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local v28 = nil
	local v29 = nil

	if IsHardModeActive() then
		v28 = Range(GetHardEnemyModeLevel(), GetHardEnemyModeLevel() + 2)
	else
		v29 = Range(v:__wf_atom_dcf48c53(), v:__wf_atom_57203011())

		if module.IsInOverworld() then
			if __wf_atom_7e8ad928(position) then
				if __wf_atom_7e8ad928(instance) then
					return v28
				else
					position = instance:GetPosition()
				end
			end

			if IsHardModeActive() then
				return v28
			end

			if __wf_atom_7e8ad928(v22) then
				v22 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
			end

			if not __wf_atom_7e8ad928(v22) then
				local color = v22:GetColor(position, true)
				local v30 = math.max(math.floor((__wf_atom_104bfe98(v29.minValue, v29.maxValue, color.red / 255))), 1)
				local v31 = math.max(math.min(math.ceil(v30 + 3), v29.maxValue), v30)
				v28 = Range(v30, v31)
			end
		end

		if not p and not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_f806fd7a) then
			local __wf_atom_e0964d51 = (instance:__wf_atom_26b04ea9() or instance):__wf_atom_e0964d51()

			if __wf_atom_e0964d51 > 0 then
				v28 = Range(__wf_atom_e0964d51, __wf_atom_e0964d51)
			end
		end
	end

	local v30 = v28 or v29

	if _T.DisableSquadLevelScalling == true then
		return v30
	end

	local v31 = { 1, 1.03, 1.07, 1.12 }
	local v32 = math.max(
		math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 4),
		1
	)
	v30.minValue = math.ceil(v30.minValue ^ v31[v32])
	v30.maxValue = math.ceil(v30.maxValue ^ v31[v32])
	return v30
end

function SetHardModeLevel()
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local v28 = gGameRules:__wf_atom_d163c8e5(v25) + gGameRules:__wf_atom_d163c8e5(v27)
	gGameRules:SetNetPersistentVar(v25, v28)
end

function GetHardEnemyModeLevel()
	if __wf_atom_7e8ad928(gGameRules) then
		return 0
	end

	return gGameRules:__wf_atom_d163c8e5(v25)
end

function IsHardModeActive()
	return not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_d163c8e5(v24, 0) ~= 0
end

function GetHardModeSubBossKillCount()
	if __wf_atom_7e8ad928(gGameRules) then
		return 0
	end

	return gGameRules:__wf_atom_d163c8e5(v26, 0)
end

function HardModeIncrementSubBossKillCount(p)
	if not IsHardModeActive() or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	if gRegion:IsMaster() then
		local v28 = __wf_atom_7e8ad928(p) and 1 or p
		local v29 = GetHardModeSubBossKillCount() + v28
		gGameRules:SetNetPersistentVar(v26, v29)
		module6.NotifyTagAllPlayers(Symbol("HARD_MODE_SUBBOSS_KILL"))
	end

	for _, v28 in ipairs(gRegion:__wf_atom_ef7900cf()) do
		local __wf_atom_e919fb8e = v28:__wf_atom_e919fb8e()

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e)
			or __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode)
			or __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.subBossKillCallback)
		then
			continue
		end

		__wf_atom_e919fb8e.hardMode.subBossKillCallback(v28)
	end
end

function GetMaxGameEnemyLevel()
	return 60
end

function GetEnemyLevel(p, p2, p3)
	return (fn10(p, p2, p3))
end

function GetDungeonEnemyLevelFromSurface(p)
	local v28 = fn10(p)
	local v29 = v28.maxValue - v28.minValue
	v28.minValue = v28.maxValue + 1
	v28.maxValue = v28.minValue + v29
	return v28
end

function RemoveAgents(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	if not __wf_atom_7e8ad928(__wf_atom_6199ef01) then
		for i = 1, #__wf_atom_6199ef01 do
			if
				__wf_atom_7e8ad928(__wf_atom_6199ef01[i])
				or __wf_atom_7e8ad928(__wf_atom_6199ef01[i]:__wf_atom_50a7d83e())
			then
				continue
			end

			__wf_atom_6199ef01[i]:__wf_atom_50a7d83e():Destroy()
		end
	end
end

function GetRandomEnemyAgentType(object, p, p2, p3, value, value2, p4, p5)
	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local v28 = p or v4
	local archetype = value or 0
	local rank = value2 or 1
	local exclusiveRank = p4 or false
	local v29 = p5 or false
	local v30

	if __wf_atom_7e8ad928(p3) then
		v30 = false
	else
		v30 = fn2(p3, v5)
	end

	local v31, randomEnemyAgentType

	-- [DEDUP] synthesized from 3 duplicated terminal regions
	local function deduplicatedTail()
		if __wf_atom_7e8ad928(randomEnemyAgentType) then
			print("Failed to find agent type, trying finding on all regions same rank")
			randomEnemyAgentType = v:GetRandomEnemyAgentType(v28, p2, true, false, 0, false, archetype, v31, true)
		end

		if __wf_atom_7e8ad928(randomEnemyAgentType) then
			print("Failed to find agent type, trying finding ANY rank")
			randomEnemyAgentType = v:GetRandomEnemyAgentType(v28, p2, true, false, 0, false, archetype, v31, false)
		end

		if __wf_atom_7e8ad928(randomEnemyAgentType) then
			print("Failed to find agent type, trying finding ANY archetype")
			randomEnemyAgentType = v:GetRandomEnemyAgentType(v28, p2, true, false, 0, false, 0, 1, false)
		end

		return randomEnemyAgentType
	end

	if __wf_atom_7e8ad928(object) then
		v31 = not v29 and v30 and rank >= 2 and 1 or rank
		randomEnemyAgentType = v:GetRandomEnemyAgentType(
			v28,
			p2,
			true,
			false,
			fn(p3),
			true,
			archetype,
			v31,
			exclusiveRank
		)
		return deduplicatedTail()
	else
		local __wf_atom_0b636f17 = object:__wf_atom_0b636f17()
		local v32, v33

		if __wf_atom_7e8ad928(__wf_atom_0b636f17) then
			v32 = object:__wf_atom_db682341()

			if object:__wf_atom_7d7cb8da() then
				v33 = object:__wf_atom_645eb602()
				archetype = v33.archetype
				rank = v33.rank
				exclusiveRank = v33.exclusiveRank
			elseif not __wf_atom_7e8ad928(v32) and v32 ~= EMPTY_SYMBOL then
				archetype, rank, exclusiveRank = fn9(v32)
			end

			v31 = not v29 and v30 and rank >= 2 and 1 or rank
			randomEnemyAgentType = v:GetRandomEnemyAgentType(
				v28,
				p2,
				true,
				false,
				fn(p3),
				true,
				archetype,
				v31,
				exclusiveRank
			)
			return deduplicatedTail()
		else
			if not v30 then
				return __wf_atom_0b636f17
			end

			if not fn3(__wf_atom_0b636f17) then -- inferred equivalent call
				return __wf_atom_0b636f17
			end

			v32 = object:__wf_atom_db682341()

			if object:__wf_atom_7d7cb8da() then
				v33 = object:__wf_atom_645eb602()
				archetype = v33.archetype
				rank = v33.rank
				exclusiveRank = v33.exclusiveRank
			elseif not __wf_atom_7e8ad928(v32) and v32 ~= EMPTY_SYMBOL then
				archetype, rank, exclusiveRank = fn9(v32)
			end

			v31 = not v29 and v30 and rank >= 2 and 1 or rank
			randomEnemyAgentType = v:GetRandomEnemyAgentType(
				v28,
				p2,
				true,
				false,
				fn(p3),
				true,
				archetype,
				v31,
				exclusiveRank
			)
			return deduplicatedTail()
		end
	end
end

function IsHeavyAgent(p)
	return fn3(p)
end

function IsRangedAgent(p)
	return fn4(p)
end

function IsGruntAgent(object)
	local v28 = not fn3(object) -- inferred equivalent call
	return v28 and not fn4(object) -- inferred equivalent call
end

function CleanUpOutOfRangeEnemies(object, list, value)
	local v28 = value or 100

	for i = #list, 1, -1 do
		local __wf_atom_50a7d83e = list[i]:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or not (v28 <= __wf_atom_50a7d83e:__wf_atom_8a6b8fc3(object))
		then
			continue
		end

		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v29 = false

		for _, v30 in ipairs(__wf_atom_ef7900cf) do
			if v30:__wf_atom_8a6b8fc3(__wf_atom_50a7d83e) < v28 then
				v29 = true
			end
		end

		if v29 then
			continue
		end

		__wf_atom_50a7d83e:Destroy()
		print("Removed avatar out of range for hint " .. object:GetName())
	end
end

function FilterDisallowedSpawnpoints(list)
	local v28 = {
		Symbol("DoNotUse"),
		Symbol("MinibossSpawn"),
		Symbol("NpcSpawn"),
		Symbol("NpcNightSpawn"),
		Symbol("OdeSignalsConsoleOperator"),
		Symbol("OdeDroneSiegeSpawnPoint")
	}

	for i = #list, 1, -1 do
		if __wf_atom_7e8ad928(list[i]:__wf_atom_08228110()) then
			if not list[i]:IsEnabled() then
				table.remove(list, i)
				return list
			end

			local __wf_atom_db682341 = list[i]:__wf_atom_db682341()

			for _, v29 in ipairs(v28) do
				if __wf_atom_db682341 ~= v29 then
					continue
				end

				table.remove(list, i)
				break
			end
		else
			table.remove(list, i)
		end
	end

	return list
end

function FindNearbyEnemies(p, p2)
	local all = gRegion:FindAll(__wf_atom_9e85eea2, p, 0, p2)

	for i = #all, 1, -1 do
		if all[i]:IsKilled() then
			table.remove(all, i)
		else
			local __wf_atom_e93896ba = all[i]:__wf_atom_e93896ba()

			if __wf_atom_e93896ba == v13 or __wf_atom_e93896ba == v14 then
				table.remove(all, i)
			end
		end
	end

	return all
end

function RemoveNpc(instance)
	Sleep(10)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v28 = 2.5

	while v28 >= 0 do
		instance:__wf_atom_a763aa1a(__wf_atom_421b01aa(1 - v28 / 5, 0, 1))
		Sleep(0)
		v28 -= __wf_atom_03df4e1d()
	end

	instance:Destroy()
end

function RemaniningAgentsEscape(object, position)
	local __wf_atom_be637430 = object:__wf_atom_be637430()

	for _, v28 in pairs(__wf_atom_be637430) do
		if v28:__wf_atom_50a7d83e():__wf_atom_464a4772() then
			continue
		end

		v28:MoveTo(position, true, true, false)
		v28:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("RemoveNpc"), false)
	end
end

local function fn11(mCurrentHints)
	local total = 0

	for _, v28 in ipairs(mCurrentHints) do
		if v28:__wf_atom_4026dfb5() < 2 then
			total += 5
		end
	end

	return total
end

function CreateReinforcementMgr(mAiDir, object)
	return {
		mAiDir = mAiDir,
		mHint = object,
		mRootHint = object:__wf_atom_1271ed80(),
		mHintPos = object:GetPosition(),
		mHintRadius = object:__wf_atom_8f18e876(),
		mActivationStyle = AS_RANDOM,
		mActivationPosStyle = APS_NEAR_POS,
		mActivationTarget = nil,
		mActivationPos = object:GetPosition(),
		mActivationRadius = object:__wf_atom_8f18e876(),
		mRandomActivationFaction = EMPTY_SYMBOL,
		mSpecificActivationHint = object,
		mSpecificEncounterType = nil,
		mSpecificEncounterTypes = {},
		mSpecificRequiredTags = {},
		mRegisteredAgentCallback = nil,
		mRegisteredAgentCallbackId = nil,
		mTimeSinceLastReinforcement = 0,
		mNumAgents = 0,
		mMinNumAgents = { 3, 4, 5, 6 },
		mMaxNumAgents = { 12, 15, 17, 20 },
		mReinforceDelay = 15,
		mRapidReinforceDelay = 3,
		mRapid = 0,
		mNumRapidReinforcements = { 2, 3, 3, 4 },
		mCurrentHints = {},
		mIncludeChildHints = false,
		mActivationPoints = {},
		SetActivationTarget = function(p, mActivationTarget)
			p.mActivationTarget = mActivationTarget

			if __wf_atom_7e8ad928(mActivationTarget) then
				p.mActivationPos = p.mHintPos
			else
				p.mActivationPos = mActivationTarget:GetPosition()
			end
		end,
		SetActivationRadius = function(p, mActivationRadius)
			p.mActivationRadius = mActivationRadius
		end,
		ShouldReinforce = function(self, p)
			local mReinforceDelay = self.mReinforceDelay

			if self.mRapid > 0 then
				mReinforceDelay = self.mRapidReinforceDelay
			end

			return mReinforceDelay < self.mTimeSinceLastReinforcement
				and self.mNumAgents + 5 + fn11(self.mCurrentHints) <= self.mMaxNumAgents[p]
		end,
		Update = function(self, p)
			if not self.mAiDir:__wf_atom_02ebaed7() then
				return
			end

			for i = #self.mCurrentHints, 1, -1 do
				if not (__wf_atom_7e8ad928(self.mCurrentHints[i]) or self.mCurrentHints[i]:__wf_atom_4026dfb5() >= 3 or self.mCurrentHints[i]:__wf_atom_4026dfb5() == 0) then
					continue
				end

				table.remove(self.mCurrentHints, i)
			end

			self.mNumAgents = self.mRootHint:__wf_atom_3634e6d2(self.mIncludeChildHints)
			local v28 = math.min(math.max(gMatchingService:__wf_atom_8b3e33a6(), 1), 4)
			self.mTimeSinceLastReinforcement += p

			if self.mNumAgents < self.mMinNumAgents[v28] then
				self.mRapid = self.mNumRapidReinforcements[v28]
			end

			if not __wf_atom_7e8ad928(self.mActivationTarget) then
				self.mActivationPos = self.mActivationTarget:GetPosition()
			end

			if self:ShouldReinforce(v28) then
				local v29 = nil

				if self.mActivationStyle == AS_RANDOM then
					if self.mActivationPosStyle == APS_NEAR_POS then
						v29 = self.mAiDir:ActivateRandomEncounterNearPos(
							self.mActivationPos,
							0,
							self.mActivationRadius,
							2,
							2,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					elseif self.mActivationPosStyle == APS_SPECIFIC_POS then
						v29 = self.mAiDir:ActivateRandomEncounterAtPos(
							self.mActivationPos,
							2,
							2,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					elseif self.mActivationPosStyle == APS_SPECIFIC_POS_WITH_TAGS then
						v29 = self.mAiDir:__wf_atom_3e1308fd(
							self.mActivationPos,
							self.mSpecificRequiredTags,
							0,
							7,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					elseif self.mActivationPosStyle == APS_SPECIFIC_HINT then
						v29 = self.mAiDir:ActivateRandomEncounterAtSpecificHint(
							self.mSpecificActivationHint,
							2,
							8,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					elseif self.mActivationPosStyle == APS_SPECIFIC_HINT_WITH_TAGS then
						v29 = self.mAiDir:__wf_atom_23d8bd25(
							self.mSpecificActivationHint,
							self.mSpecificRequiredTags,
							0,
							7,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					elseif self.mActivationPosStyle == APS_ARRAY_POS then
						local mActivationPoint = self.mActivationPoints[__wf_atom_5784a397(1, #self.mActivationPoints)]
						v29 = self.mAiDir:ActivateRandomEncounterAtPos(
							mActivationPoint:GetPosition(),
							2,
							2,
							self.mRootHint,
							0,
							self.mRandomActivationFaction
						)
					end
				elseif self.mActivationStyle == AS_SPECIFIC_ENCOUNTER_TYPE then
					if #self.mSpecificEncounterTypes > 0 then
						local mSpecificEncounterType = self.mSpecificEncounterTypes[__wf_atom_5784a397(1, #self.mSpecificEncounterTypes)]

						if self.mActivationPosStyle == APS_NEAR_POS then
							v29 = self.mAiDir:ActivateSpecificEncounterNearPos(
								self.mActivationPos,
								0,
								self.mActivationRadius,
								mSpecificEncounterType,
								2,
								2,
								self.mRootHint
							)
						elseif self.mActivationPosStyle == APS_SPECIFIC_POS then
							v29 = self.mAiDir:__wf_atom_c4c644af(
								self.mActivationPos,
								mSpecificEncounterType,
								self.mRootHint,
								0
							)
						elseif self.mActivationPosStyle == APS_SPECIFIC_HINT then
							v29 = self.mAiDir:ActivateSpecificEncounterAtSpecificHint(
								self.mSpecificActivationHint,
								mSpecificEncounterType,
								self.mRootHint,
								0
							)
						elseif self.mActivationPosStyle == APS_ARRAY_POS then
							local mActivationPoint = self.mActivationPoints[__wf_atom_5784a397(1, #self.mActivationPoints)]
							v29 = self.mAiDir:__wf_atom_c4c644af(
								mActivationPoint:GetPosition(),
								mSpecificEncounterType,
								self.mRootHint,
								0
							)
						end
					else
						print("ReinforceMgr: Trying to activate with specific encounter which is nil \n")
					end
				end

				if __wf_atom_7e8ad928(v29) then
					print("ReinforceMgr tried to create a reinforcement encounter, but failed")
				else
					local v30

					if __wf_atom_7e8ad928(self.mActivationTarget) then
						v30 = v29:__wf_atom_1c8f7b2d(self.mHint)
					else
						v30 = v29:__wf_atom_1c8f7b2d(self.mActivationTarget)
					end

					print("ReinforceMgr succeeded in creating a reinforcement encounter. " .. v30 .. "m from activation target")
					self.mTimeSinceLastReinforcement = 0

					if self.mRapid > 0 then
						self.mRapid -= 1
					end

					if not (__wf_atom_7e8ad928(self.mRegisteredAgentCallback) or __wf_atom_7e8ad928(self.mRegisteredAgentCallbackId)) then
						v29:__wf_atom_c361f7f8(
							self.mRegisteredAgentCallback,
							Symbol(self.mRegisteredAgentCallbackId .. String(#self.mCurrentHints + 1))
						)
					end

					table.insert(self.mCurrentHints, v29)
				end
			end
		end
	}
end

function GetEncounterLootSpawns(p, p2, value, p3, p4, p5, p6, p7)
	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local v28 = value or 1
	local v29 = __wf_atom_7e8ad928(p3) and true or p3
	local v30 = __wf_atom_7e8ad928(p4) and true or p4
	local v31 = __wf_atom_7e8ad928(p5) and true or p5
	local result = {}
	local __wf_atom_3c9cb048 = v:__wf_atom_3c9cb048(p)
	local v32

	if __wf_atom_7e8ad928(p7) then
		v32 = {}
	else
		v32 = FindPointInstances(p7, nil, v9)
		local v33 = p2.maxValue + 100

		for i = #v32, 1, -1 do
			local v34 = v32[i]

			if __wf_atom_7e8ad928(v34) or not (v33 < v34:__wf_atom_8a6b8fc3(p7)) then
				continue
			end

			table.remove(v32, i)
		end
	end

	if v29 then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v9, p, 0, p2.maxValue)

		if #v32 > 0 then
			__wf_atom_439c0d29 = module.MergeTables(__wf_atom_439c0d29, v32, true)
		end

		for _, spawnPt in ipairs(__wf_atom_439c0d29) do
			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v11, spawnPt:GetPosition(), 0, 1)
			local position = spawnPt:GetPosition()

			if __wf_atom_7e8ad928(__wf_atom_f738b4af) and v:__wf_atom_3c9cb048(position) == __wf_atom_3c9cb048 then
				table.insert(result, {
					pos = spawnPt:GetPosition(),
					rot = spawnPt:__wf_atom_dc309f8a(),
					spawnPt = spawnPt
				})
			end
		end
	end

	if not ((v30 or v31) and #result < v28) then
		return result
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(p, p2, p2.maxValue > 20 and 3 or 2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("ChestSpawn"), Color("0xFFFFFF"))
	local positions = module3.GetPositions(10, __wf_atom_28ce676a)

	while #result < v28 and #positions > 0 do
		local v33 = __wf_atom_5784a397(1, #positions)
		local position = positions[v33]
		local rot

		if v30 then
			rot = __wf_atom_fa8d0177(position, p)
		else
			rot = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		end

		if not __wf_atom_7e8ad928(position) and v:__wf_atom_3c9cb048(position) == __wf_atom_3c9cb048 then
			if __wf_atom_7e8ad928(p6) or not (p6 > 0) then
				table.insert(result, { pos = position, rot = rot })
			else
				local v35 = Vector()
				__wf_atom_2202ffb6:__wf_atom_3cc125d0(position, v35)

				if p6 < Distance(position, v35) then
					table.insert(result, { pos = position, rot = rot })
				end
			end
		end

		table.remove(positions, v33)
	end

	return result
end

function GetAvailableLootChestSpawnsInRange(p, p2, p3)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v9, p, p2, p3)
	local result = {}

	for _, v28 in ipairs(__wf_atom_439c0d29) do
		if not __wf_atom_7e8ad928((gRegion:__wf_atom_f738b4af(v11, v28:GetPosition(), 0, 1))) then
			continue
		end

		table.insert(result, v28)
	end

	return result
end

function SpawnLootContainer(p, p2, p3, _, object, object2)
	local entity = gRegion:CreateEntity(p, p2, p3)

	if __wf_atom_7e8ad928(object2) then
		object2 = gRegion:__wf_atom_f738b4af(v9, p2, 0, 1)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:FirePort("Disable")
	end

	if not __wf_atom_7e8ad928(object) then
		module2.LogEncounterLootChestSpawnedStats(entity, object:__wf_atom_db682341(), GetEnemyLevel(object))
	end

	return entity
end

function IsValidDestinationForEncounter(p, p2)
	return fn5(p, p2)
end

function HoldPosition(object, p)
	if not __wf_atom_7e8ad928(object) then
		if p then
			object:__wf_atom_5a0e15fd(Symbol("HoldPosition"), 1)
		else
			object:ClearAgentBlackboardEntry(Symbol("HoldPosition"))
		end
	end
end

function RandomPatrol(object, p)
	if not __wf_atom_7e8ad928(object) then
		if p then
			object:__wf_atom_5a0e15fd(Symbol("RandomPatrol"), 1)
		else
			object:ClearAgentBlackboardEntry(Symbol("RandomPatrol"))
		end
	end
end

function DebugDrawPatrolRoute(_, _, _, _, _, _) end

function DebugDrawAgents(_, _) end

function GetRoadPatrolPts(p, p2, p3, p4)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v28 = Vector()
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(p, v28)
	local __wf_atom_10fe7249 = __wf_atom_2202ffb6:__wf_atom_10fe7249(v28)
	local isInOverworld = module.IsInOverworld()
	local v29 = {}
	local v30 = p4 or false

	for _, v31 in ipairs(__wf_atom_10fe7249) do
		local v32 = Vector()
		__wf_atom_2202ffb6:__wf_atom_ee2fdd07(v31, v32)
		local v33 = Distance(v28, v32)

		if not (v33 <= p2.maxValue and p2.minValue <= v33 and (not isInOverworld or __wf_atom_7e8ad928(p3) or fn5(v32, p3, true, v30))) then
			continue
		end

		table.insert(v29, v32)
	end

	if not __wf_atom_7e8ad928(v28) and #v29 > 0 then
		local sortPositionsByDistance = module.SortPositionsByDistance(v29, p, true)
		local v31 = math.min(50, p2.minValue * 0.5)

		for i = 1, #sortPositionsByDistance do
			for j = #sortPositionsByDistance, i + 1, -1 do
				if Distance(sortPositionsByDistance[i], sortPositionsByDistance[j]) < v31 then
					table.remove(sortPositionsByDistance, j)
				end
			end
		end

		local sortPositionsByDistance2 = module.SortPositionsByDistance(sortPositionsByDistance, p)

		while #sortPositionsByDistance2 > 0 do
			local v32 = __wf_atom_5784a397(math.max(#sortPositionsByDistance2 - 5, 1), #sortPositionsByDistance2)
			local __wf_atom_c708a30e = __wf_atom_2202ffb6:__wf_atom_c708a30e(v28, sortPositionsByDistance2[v32])

			for i = #__wf_atom_c708a30e, 2, -1 do
				if __wf_atom_c708a30e[i] == __wf_atom_c708a30e[i - 1] then
					table.remove(__wf_atom_c708a30e, i)
				end
			end

			if isInOverworld then
				for i = 1, #__wf_atom_c708a30e do
					if fn5(__wf_atom_c708a30e[i], p3, true, v30) then
						continue
					end

					for j = #__wf_atom_c708a30e, i, -1 do
						table.remove(__wf_atom_c708a30e, j)
					end

					break
				end
			end

			if #__wf_atom_c708a30e > 1 then
				return __wf_atom_c708a30e
			else
				table.remove(sortPositionsByDistance2, v32)
			end
		end
	end

	return {}
end

function GetRoadPointsBetweenPositions(p, p2)
	local __wf_atom_c708a30e = gRegion:__wf_atom_2202ffb6():__wf_atom_c708a30e(p, p2)

	for i = #__wf_atom_c708a30e, 2, -1 do
		if __wf_atom_c708a30e[i] == __wf_atom_c708a30e[i - 1] then
			table.remove(__wf_atom_c708a30e, i)
		end
	end

	return __wf_atom_c708a30e
end

function NearestRoadDest(object, list)
	local v28 = 3.4028234663852886e38
	local v29 = nil
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return list[1]
	end

	local position = __wf_atom_50a7d83e:GetPosition()

	for i = 1, #list do
		local v30 = Distance(position, list[i])

		if not (v30 < v28) then
			continue
		end

		v29 = list[i]
		v28 = v30
	end

	return v29
end

function UpdateDestinations(list, list2, p, p2, p3)
	if not __wf_atom_7e8ad928(list2) and #list2 > 0 then
		for _, v28 in ipairs(list) do
			if __wf_atom_7e8ad928(v28) then
				continue
			end

			local __wf_atom_049aa7d4 = v28:__wf_atom_049aa7d4()
			local __wf_atom_50a7d83e = v28:__wf_atom_50a7d83e()
			local __wf_atom_e919fb8e = __wf_atom_50a7d83e:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
				continue
			end

			if __wf_atom_049aa7d4 == __wf_atom_28d5d4aa then
				if
					(not v28:__wf_atom_04ea4887() or __wf_atom_e919fb8e.fleeAlongPatrolRoute)
					and v28:__wf_atom_17838662()
					and (p3 or fn5(v28:__wf_atom_d1d5ef7e(), p2))
				then
					v28:__wf_atom_b783ff91(v28:__wf_atom_d1d5ef7e(), 0)
				end
			elseif v28:__wf_atom_04ea4887() and __wf_atom_e919fb8e.fleeAlongPatrolRoute ~= true then
				v28:__wf_atom_24ddbdc3()
			else
				for i = 1, #list2 do
					if list2[i] ~= __wf_atom_049aa7d4 then
						continue
					end

					if __wf_atom_7e8ad928(p2) or p3 or fn5(list2[i], p2) then
						if __wf_atom_50a7d83e:__wf_atom_a5304c35(list2[i]) <= 3 then
							if i < #list2 then
								v28:__wf_atom_b783ff91(list2[i + 1], 0)
								break
							end

							if p then
								v28:__wf_atom_b783ff91(list2[1], 0)
							else
								v28:__wf_atom_24ddbdc3()
								__wf_atom_50a7d83e:__wf_atom_2341f576(__wf_atom_50a7d83e:GetPosition())
								break
							end
						end
					else
						v28:__wf_atom_24ddbdc3()
						__wf_atom_50a7d83e:__wf_atom_2341f576(__wf_atom_50a7d83e:GetPosition())
						break
					end
				end
			end

			if
				not p
				and __wf_atom_50a7d83e:__wf_atom_a5304c35(list2[#list2]) <= 3
				and __wf_atom_50a7d83e:__wf_atom_a5304c35(__wf_atom_049aa7d4) <= 3
			then
				return true
			end
		end
	end
end

function ReversePatrolRoute(list, list2)
	local result = {}

	for i = #list, 1, -1 do
		table.insert(result, list[i])
	end

	for _, v28 in ipairs(list2) do
		if not __wf_atom_7e8ad928(v28) then
			v28:__wf_atom_b783ff91(result[1], 0)
		end
	end

	return result
end

function PlayAnimOnAlert(object, p, p2)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
		return
	end

	if not __wf_atom_7e8ad928(p) then
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(p, false, 3, 2, false)

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_aa4361c1(v12, __wf_atom_50a7d83e, 1)
		end
	end

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) do
		if object:__wf_atom_04ea4887() then
			local v28 = Random(0, 1) * 0.5 + 0
			Sleep(v28)

			if __wf_atom_7e8ad928(p2) then
				if __wf_atom_50a7d83e:__wf_atom_c138b19b(p) then
					__wf_atom_50a7d83e:__wf_atom_921c1a5f(nil, false, 3, 1, false)
				end
			else
				__wf_atom_50a7d83e:__wf_atom_921c1a5f(p2, false, 3, 1, true)
			end

			if __wf_atom_7e8ad928(object) then
				break
			end

			object:__wf_atom_42b767a2(v12)
			break
		else
			Sleep(0)
		end
	end
end

function AddMessengerIntel(hint, p, text, p2, tale)
	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if
		not __wf_atom_7e8ad928(p)
		and __wf_atom_7e8ad928((gRegion:__wf_atom_f738b4af(v17, hint:GetPosition(), 0, 20)))
	then
		local entity = gRegion:CreateEntity(p, hint:GetPosition(), __wf_atom_80368bb1)
		v:__wf_atom_ccbb5582(entity)
		hint:__wf_atom_d494454b(entity)
	end

	local __wf_atom_90813fa0 = hint:__wf_atom_90813fa0()
	local __wf_atom_e919fb8e = hint:__wf_atom_e919fb8e()
	local markerType = nil

	if __wf_atom_7e8ad928(p2) then
		if not __wf_atom_7e8ad928(__wf_atom_90813fa0) then
			markerType = __wf_atom_90813fa0:__wf_atom_12d9eb4f()
		end
	else
		markerType = p2
	end

	local hoverText

	if not __wf_atom_7e8ad928(__wf_atom_90813fa0) then
		hoverText = __wf_atom_90813fa0:__wf_atom_c1f3dd00()
	end

	__wf_atom_e919fb8e.messages = __wf_atom_e919fb8e.messages or {}
	table.insert(__wf_atom_e919fb8e.messages, {
		hint = hint,
		text = text,
		markerType = markerType,
		hoverText = hoverText,
		tale = tale
	})
end

function RemoveMessengerIntel(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v17, object:GetPosition(), 0, 20)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:Destroy()
	end

	if p then
		local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(Symbol("MessengerMarker"), object:GetPosition(), 0, 20)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af2) then
			__wf_atom_f738b4af2:Destroy()
		end
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.messages) and #__wf_atom_e919fb8e.messages > 0 then
		for i = #__wf_atom_e919fb8e.messages, 1, -1 do
			table.remove(__wf_atom_e919fb8e.messages[i])
		end
	end
end

function FindRandomSpawnsOnNavInRange(p, p2, p3, p4, value, value2, p5, p6)
	if __wf_atom_7e8ad928(p4) then
		p4 = p2.maxValue > 15 and 3 or 2
	end

	if __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(p, p2, p4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(value or 45)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(value2 or 1.5, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()

	if not p6 then
		__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	end

	if not __wf_atom_7e8ad928(p5) then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(p5)
	end

	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("EncounterSpawn"), Color("0xFFFFFF"))
	return (module3.GetPositions(p3, __wf_atom_28ce676a))
end

function GeneratePointsOfInterest(minAreaSize, list, p, p2)
	print("Waiting for nav and tac map...")
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while not __wf_atom_7d789620:__wf_atom_d0c59e69() do
		Sleep(0)
	end

	print("Generating points of interest")
	local __wf_atom_7d789620_2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v28 = Symbol("Backdrop")
	local v29 = {}
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	gRegion:FindAll(__wf_atom_2ba8f9e2)
	local v30 = {
		numPoints = 20,
		sourceTags = {},
		sourceTypes = {},
		includeDoorsAsSources = true,
		minAreaSize = 4,
		maxAreaSize = 50,
		minDistFromSources = 1,
		maxDistFromSources = 3.4028234663852886e38,
		minDistBetweenPoints = 15,
		seed = __wf_atom_5784a397(1, 100000),
		projectToNearestNav = true
	}

	if not __wf_atom_7e8ad928(minAreaSize) then
		v30.minAreaSize = minAreaSize
	end

	for _, v31 in ipairs(all) do
		local __wf_atom_db682341 = v31:__wf_atom_db682341()
		local flag = false

		if __wf_atom_7e8ad928(list) or not (#list > 0) then
			if __wf_atom_db682341 ~= v28 and __wf_atom_db682341 ~= EMPTY_SYMBOL then
				flag = true
			end
		else
			for _, v32 in ipairs(list) do
				if __wf_atom_db682341 ~= v32 then
					continue
				end

				flag = true
				break
			end
		end

		if not flag then
			continue
		end

		local v32 = __wf_atom_7d789620_2:__wf_atom_5633d172(v31) + 1

		if not __wf_atom_7e8ad928(v29[v32]) then
			continue
		end

		v29[v32] = { tag = v31:__wf_atom_db682341(), index = v32, points = {} }
		v29[v32].points = __wf_atom_7d789620_2:FindPointsOfInterestInZone(
			v30.numPoints,
			v32 - 1,
			v30.sourceTags,
			v30.sourceTypes,
			v30.includeDoorsAsSources,
			v30.minAreaSize,
			v30.maxAreaSize,
			v30.minDistFromSources,
			v30.maxDistFromSources,
			v30.minDistBetweenPoints,
			v30.seed,
			v30.projectToNearestNav
		)

		for i = #v29[v32].points, 1, -1 do
			local __wf_atom_4d26da3a = __wf_atom_7d789620_2:__wf_atom_4d26da3a(v29[v32].points[i], 1)

			if Distance(__wf_atom_4d26da3a, v29[v32].points[i]) <= 2 then
				table.remove(v29[v32].points, i)
			end
		end

		if not p2 then
			continue
		end

		for _, point in ipairs(v29[v32].points) do
			gRegion:__wf_atom_628723a6(point, point + Vector(0, 2, 0), Color(0, 255, 0), 9999)
			gRegion:__wf_atom_5b35a0c8(
				point + Vector(0, 2.5, 0),
				Color(0, 255, 0),
				tostring(v29[v32].tag) .. " " .. v32,
				1,
				9999
			)
			gRegion:__wf_atom_b5c21154(point, v30.minAreaSize, Color(0, 255, 0), Rotation(0, 90, 0), 9999)
		end
	end

	print("Done generating points of interest")

	if p then
		local points = {}

		for _, v31 in pairs(v29) do
			for _, point in ipairs(v31.points) do
				table.insert(points, point)
			end
		end

		return points
	else
		local result = {}

		for _, v31 in pairs(v29) do
			if not __wf_atom_7e8ad928(v31.points and #v31.points > 0) then
				table.insert(result, v31)
			end
		end

		for i = #result, 1, -1 do
			for j = 1, i - 1 do
				if not (result[j].index > result[j + 1].index) then
					continue
				end

				local v31 = result[j]
				result[j] = result[j + 1]
				result[j + 1] = v31
			end
		end

		return result
	end
end

function AddDungeonObjective(enc, tags)
	if __wf_atom_7e8ad928(_T.DungeonObjQueue) then
		_T.DungeonObjQueue = {}
	end

	table.insert(_T.DungeonObjQueue, { enc = enc, tags = tags })
end

function GetObjsInQueue()
	if __wf_atom_7e8ad928(_T.DungeonObjQueue) then
		_T.DungeonObjQueue = {}
	end

	return _T.DungeonObjQueue
end

function GiveDeedRewards(p, object)
	if __wf_atom_7e8ad928(object) then
		print("Missing DropTable for GiveDeedRewards")
		return
	end

	for _, v28 in gRegion:__wf_atom_3c8e1a7a() do
		local playerAvatar = v28:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_e93896ba = __wf_atom_7d789620:__wf_atom_e93896ba(0)
		local __wf_atom_dcf48c53 = __wf_atom_7d789620:__wf_atom_dcf48c53()
		local __wf_atom_57203011 = __wf_atom_7d789620:__wf_atom_57203011()
		object:__wf_atom_0ad20b11(
			playerAvatar,
			p,
			__wf_atom_e93896ba,
			(__wf_atom_5784a397(__wf_atom_dcf48c53, __wf_atom_57203011))
		)
	end
end

function GetAvailableLootCrateSpawns()
	while __wf_atom_7e8ad928(_T.LootChestsSpawned) do
		Sleep(0)
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("LootChestSpawnPt"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("LootChest"))

	for i = #__wf_atom_2226b35c, 1, -1 do
		for j = #__wf_atom_2226b35c2, 1, -1 do
			if not (__wf_atom_2226b35c2[j]:__wf_atom_8a6b8fc3(__wf_atom_2226b35c[i]) <= 1) then
				continue
			end

			table.remove(__wf_atom_2226b35c2, j)
			table.remove(__wf_atom_2226b35c, i)
			break
		end
	end

	return __wf_atom_2226b35c
end

function GetSubbossEncounterTemplateName(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_969b3725 = object:__wf_atom_969b3725()

	for _, v28 in ipairs(__wf_atom_969b3725) do
		if v28:__wf_atom_55116686() == v16 and v28:__wf_atom_a7fb894a() > 0 then
			return v28:GetName()
		end
	end

	return nil
end

function GetSubBossTimerSymb(instance, _)
	local dungeonEntranceId = nil
	local v28 = GetSubbossEncounterTemplateName(instance)

	if __wf_atom_7e8ad928(v28) then
		return nil
	end

	if v23[v28] == nil then
		if module.IsInOverworld() then
			if instance:IsA(v20) then
				local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
					dungeonEntranceId = __wf_atom_e919fb8e.dungeonEntranceId or instance:GetName()
				end
			else
				dungeonEntranceId = instance:__wf_atom_db682341()

				if __wf_atom_7e8ad928(dungeonEntranceId) or dungeonEntranceId == EMPTY_SYMBOL then
					dungeonEntranceId = instance:GetName()
				end
			end
		else
			local currentLocation = module5.GetCurrentLocation()
			local v29 = "Dungeon-"

			if __wf_atom_7e8ad928(currentLocation) or currentLocation == "" then
				local __wf_atom_cc31ec3f = instance:__wf_atom_cc31ec3f()

				if not __wf_atom_7e8ad928(__wf_atom_cc31ec3f) and #__wf_atom_cc31ec3f > 1 then
					return __wf_atom_cc31ec3f[1]
				end

				dungeonEntranceId = v29 .. "Unknown"
			else
				dungeonEntranceId = v29 .. tostring(currentLocation)
			end
		end
	else
		dungeonEntranceId = tostring(v23[v28])
	end

	local v29 = tostring(dungeonEntranceId)
	return Symbol(v29 .. "-SubBoss")
end

function FindAndChildNearbyHints(object, className, p, position, p2)
	if p then
		local __wf_atom_62b7d4c2 = object:__wf_atom_62b7d4c2()

		for _, v28 in ipairs(__wf_atom_62b7d4c2) do
			if not (v28:IsA(className) and v28:__wf_atom_1271ed80() ~= object) then
				continue
			end

			v28:__wf_atom_da18e112(object)
			v28:__wf_atom_aa576d54()
		end
	else
		if __wf_atom_7e8ad928(position) then
			position = object:GetPosition()
		end

		if __wf_atom_7e8ad928(p2) then
			p2 = object:__wf_atom_8f18e876()
		end

		local all = gRegion:FindAll(className, position, 0, p2)

		if not __wf_atom_7e8ad928(all) then
			for _, v28 in ipairs(all) do
				if v28:__wf_atom_1271ed80() == object then
					continue
				end

				v28:__wf_atom_da18e112(object)
				object:__wf_atom_aa576d54()
			end
		end
	end
end