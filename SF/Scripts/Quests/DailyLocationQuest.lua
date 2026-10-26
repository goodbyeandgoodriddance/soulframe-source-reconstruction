local v = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.EncounterLib")
local module6 = require("SF.Scripts.Libs.StatsLib")
local module7 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v2 = {
	{
		encHintTag = Symbol("TowerCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/TowerCampLoreFragment"
	},
	{
		encHintTag = Symbol("VillageCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/VillageCampLoreFragment"
	},
	{
		encHintTag = Symbol("FortCurlailCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/FortCurlailCampLoreFragment"
	},
	{
		encHintTag = Symbol("GladeEntranceCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/GladeEntranceCampLoreFragment"
	},
	{
		encHintTag = Symbol("MinesCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/MinesCampLoreFragment"
	},
	{
		encHintTag = Symbol("HamletCamp"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/HamletCampLoreFragment"
	},
	{
		encHintTag = Symbol("SproutCaveLocation"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/SproutCaveLocationLoreFragment"
	},
	{
		encHintTag = Symbol("WishingWellLocation"),
		loreFragment = "/SF/Types/Quests/LocationLoreQuests/WishingWellLocationLoreFragment"
	}
}
local v3 = {
	Symbol("MT_MINIBOSS"),
	Symbol("MT_RESCUE"),
	Symbol("MT_BALLOON"),
	Symbol("MT_RETRIEVE")
}
local v4 = Resource("/SF/Interface/HUD/Notification.swf")
local v5 = Resource("/SF/Types/PickUps/DropTables/Encounters/EncounterDropTable")
local v6 = Resource("/SF/Types/Npcs/OrlickNpc")
local v7 = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
local v8 = Resource("/SF/Sounds/Dialog/TransmissionSets/OrlickTransmissionset")
local v9 = Symbol("LocationLoreSpawn")
local v10 = Symbol("LocationLoreSpawnLast")
local v11 = WeakResource("/SF/Objects/Ode/Props/GiveLoreSSE")
local v12 = Resource("/Lotus/Types/Lore/PrimaryCodexManifest")
local v13 = nil

local function fn() -- 2 equivalent calls inferred from this helper
	local __wf_atom_7679fa17 = gGameRules:__wf_atom_7679fa17()

	if __wf_atom_7679fa17 <= 0 then
		print("GetLocationResetFrequency: defaulting to 3hrs. Val is an invalid value: " .. tostring(__wf_atom_7679fa17))
		return 3
	else
		return __wf_atom_7679fa17
	end
end

local function fn2(p, p2)
	local result = {}

	if p2 < p then
		print("_PickNRandomLocations warning: cannot pick more than totalLocations, picking totalLocations...")
		p = p2
	end

	if p == p2 then
		print("_PickNRandomLocations warning: picking n locations from n total locations will give you 1..n")

		for i = 1, p do
			table.insert(result, i)
		end

		_T.DevTestForceLocationReroll = nil
		return result
	else
		local v14 = __wf_atom_04d7eaaa()
		local v15 = fn() -- inferred equivalent call
		local v16 = math.floor(gGameRules:__wf_atom_91a79d39() / (v15 * 3600))

		if _T.DevTestForceLocationReroll then
			v16 = __wf_atom_5784a397(1, 99999)
			_T.DevTestForceLocationReroll = nil
		end

		local v17 = __wf_atom_3e61816b(v16)
		__wf_atom_01bfe5c4(v17)

		for i = 1, p2 do
			table.insert(result, i)
		end

		local v18 = p2
		local result2 = {}

		while p2 - p < v18 do
			local v19 = __wf_atom_c08f5a0e(1, v18)
			local v20 = result[v19]
			local v21 = result[v18]
			table.insert(result2, v20)
			result[v19] = v21
			v18 -= 1
		end

		__wf_atom_01bfe5c4(v14)
		return result2
	end
end

local function fn3()
	v13 = {}

	if not __wf_atom_7e8ad928(_T.LocationEncounterData) then
		for k, v14 in pairs(_T.LocationEncounterData) do
			if v14.status and v14.status == 2 then
				v13[k] = v14
			end
		end
	end

	_T.LocationEncounterData = {}
	local v14 = fn2(3, #v2)

	for _, v15 in ipairs(v14) do
		local v16 = v2[v15]
		local c_str = v16.encHintTag:c_str()
		local v17 = {}

		if v13[c_str] ~= nil then
			continue
		end

		for k, v18 in v16 do
			v17[k] = v18
		end

		_T.LocationEncounterData[c_str] = v17
	end

	for k, v15 in pairs(v13) do
		_T.LocationEncounterData[k] = v15
	end
end

local function fn4(position, p)
	local v14

	if p then
		v14 = gRegion:__wf_atom_f738b4af(Symbol("OdeEncounterPinEnable"), position, 0, 100)
	else
		v14 = gRegion:__wf_atom_f738b4af(Symbol("OdeEncounterPinDisable"), position, 0, 100)
	end

	if not __wf_atom_7e8ad928(v14) then
		v14:FirePort("TriggerPort")
	end
end

function _AncestorDissolveIn(object)
	local loreSpawnAncestor = _T.LoreSpawnAncestor

	if not __wf_atom_7e8ad928(loreSpawnAncestor) then
		module7.DissolveIn(loreSpawnAncestor, object:__wf_atom_a2a18137(), nil)
	end
end

local function fn5(childHint)
	if __wf_atom_7e8ad928(childHint) then
		return
	end

	print("Lore stage")
	local __wf_atom_26b04ea9 = childHint:__wf_atom_26b04ea9()
	local v14 = _T.LocationEncounterData[__wf_atom_26b04ea9:__wf_atom_db682341():c_str()]
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local overrideLoreFragmentPosition = _T.OverrideLoreFragmentPosition
	_T.OverrideLoreFragmentPosition = nil

	for _, v15 in pairs(__wf_atom_3c8e1a7a) do
		local playerAvatar = v15:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if
			__wf_atom_7e8ad928(__wf_atom_d2b2176d)
			or not (playerAvatar:__wf_atom_1c8f7b2d(__wf_atom_26b04ea9) <= 120)
		then
			continue
		end

		local v16 = playerAvatar:GetPosition() + playerAvatar:__wf_atom_acb19668() * 2

		if overrideLoreFragmentPosition ~= nil then
			v16 = overrideLoreFragmentPosition
		end

		if not __wf_atom_7e8ad928(v5) then
			local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
			local __wf_atom_e93896ba = __wf_atom_7d789620:__wf_atom_e93896ba(0)
			local __wf_atom_dcf48c53 = __wf_atom_7d789620:__wf_atom_dcf48c53()
			local __wf_atom_57203011 = __wf_atom_7d789620:__wf_atom_57203011()
			local v17 = __wf_atom_5784a397(__wf_atom_dcf48c53, __wf_atom_57203011)
			v5:__wf_atom_0ad20b11(playerAvatar, v14.encHint, __wf_atom_e93896ba, v17)
		end

		__wf_atom_d2b2176d:__wf_atom_355b9a20(2000, playerAvatar, EMPTY_SYMBOL)
		gGameRules:__wf_atom_f15eca68(v14.encHintTag:c_str(), WeakResource(v14.loreFragment), v15, v16)
	end

	module2.RemoveSparrowDestination(__wf_atom_26b04ea9)
end

local function fn6(objectType)
	if __wf_atom_7e8ad928(objectType) then
		return nil
	end

	local filtered = SF.Filter()
	filtered.objectType = objectType
	filtered.tag = Symbol("Fragments")
	local __wf_atom_1e5f4e2f = v12:__wf_atom_1e5f4e2f(filtered)

	for _, v14 in pairs(__wf_atom_1e5f4e2f) do
		if v14.type:IsA(objectType) then
			return v14
		end
	end

	return nil
end

function OnLoreSpawned(object)
	if not __wf_atom_7e8ad928(_T.LoreSpawnAncestor) then
		gRegion:__wf_atom_dd1e4d10(_T.LoreSpawnAncestor)
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

		if not __wf_atom_7e8ad928(playerAvatar) then
			object:Teleport(Vector(0, -300, 0), __wf_atom_80368bb1)
			Sleep(3)

			while module3.TransmissionPlaying() do
				Sleep(0.1)
			end

			if not __wf_atom_7e8ad928(object) then
				local loreSpawnAncestor = module7.TryAppearRelativeToPlayer(playerAvatar, v6, nil, {
					distance = 3,
					minSpawnDist = 1,
					maxSpawnVerticalDist = 2,
					tryBehind = true,
					validateFunc = function()
						local __wf_atom_eab484a7_2 = gRegion:__wf_atom_eab484a7()

						if __wf_atom_7e8ad928(__wf_atom_eab484a7_2) then
							return false
						end

						local playerAvatar2 = __wf_atom_eab484a7_2:GetPlayerAvatar(0)
						return not (__wf_atom_7e8ad928(playerAvatar2) or playerAvatar2:IsKilled() or playerAvatar2:__wf_atom_799d95f5() or _T.LocalPlayerInNightFold)
					end
				}, true)

				if not (__wf_atom_7e8ad928(loreSpawnAncestor) or __wf_atom_7e8ad928(object)) then
					while __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() do
						playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
						Sleep(0.3)
					end

					_T.LoreSpawnAncestor = loreSpawnAncestor
					playerAvatar:__wf_atom_8a035cd5(Symbol("_AncestorDissolveIn"), true)
					local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()
					local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v11)
					local v14 = false

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						local info = __wf_atom_bb3e7833:GetInfo()

						if not __wf_atom_7e8ad928(info) then
							local __wf_atom_db94558a = info:__wf_atom_db94558a()

							if not __wf_atom_7e8ad928(__wf_atom_db94558a) then
								local v15 = fn6(__wf_atom_db94558a)

								if not __wf_atom_7e8ad928(v15) then
									v14 = __wf_atom_d2b2176d:__wf_atom_96a19f31(__wf_atom_db94558a) == v15.reqScans - 1
								end
							end
						end
					end

					Sleep(1)
					object:Teleport(
						loreSpawnAncestor:GetPosition() + loreSpawnAncestor:__wf_atom_acb19668() * 1.5 + loreSpawnAncestor:__wf_atom_a06d543c() * 0.5,
						loreSpawnAncestor:__wf_atom_dc309f8a()
					)
					module3.PlayLocalTransmission(v8, v14 and v10 or v9, playerAvatar)
				end
			end
		end
	end
end

function ChildScriptCaptureLore(_)
	local loreSpawnAncestor = _T.LoreSpawnAncestor

	if not __wf_atom_7e8ad928(loreSpawnAncestor) then
		module7.DissolveOut(loreSpawnAncestor)
	end
end

function CaptureLore(object, object2)
	if __wf_atom_7e8ad928(object2) then
		print("CaptureLore error: capturing lore but instigator null!")
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		print("CaptureLore error: capturing local player null!")
		return
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if not __wf_atom_7e8ad928(playerAvatar) then
		local info = object:GetInfo()
		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			print("CaptureLore error: capturing lore but local avatar inventory null!")
			return
		end

		local __wf_atom_db94558a = info:__wf_atom_db94558a()

		if __wf_atom_7e8ad928(__wf_atom_db94558a) then
			print("CaptureLore error: lore capture target " .. object:GetName() .. " does not have a loreFragment setup!")
			return
		end

		local v14 = fn6(__wf_atom_db94558a)

		if __wf_atom_7e8ad928(v14) then
			print("CaptureLore error: no codex entry found for lore!")
			return
		end

		local v15 = math.min(__wf_atom_d2b2176d:__wf_atom_96a19f31(__wf_atom_db94558a) + 1, v14.reqScans)
		local __wf_atom_330f77f5 = __wf_atom_eab484a7:__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			__wf_atom_330f77f5:__wf_atom_b4984563(
				v4,
				"LocationDiscovered",
				{
					tostring(v14.locName),
					tostring(v15),
					tostring(v14.reqScans),
					"true",
					"",
					(tostring(11))
				},
				11,
				"LocationDiscovered",
				true
			)
		end

		module.GiveLoreFragment(playerAvatar, __wf_atom_db94558a)

		if math.random() < 0.5 and not __wf_atom_7e8ad928((module7.GetLocalPlayerAncestorOfType(v7))) then
			module3.PlayLocalTransmission(v8, Symbol("LoreMoteTaken"), playerAvatar)
		end

		if isChallengeScan then
			local __wf_atom_0d9c1a58 = object2:__wf_atom_0d9c1a58()
			__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, challengeTag)
		end

		playerAvatar:__wf_atom_8a035cd5(Symbol("ChildScriptCaptureLore"), false)
	end
end

function OnChildEncStatusChanged(childHint)
	local __wf_atom_4026dfb5 = childHint:__wf_atom_4026dfb5()
	local __wf_atom_26b04ea9 = childHint:__wf_atom_26b04ea9()

	if __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		print("OnChildEncStatusChanged error: " .. childHint:GetName() .. " has no parent hint!")
	else
		local c_str = __wf_atom_26b04ea9:__wf_atom_db682341():c_str()
		print("OnChildEncStatusChanged: " .. c_str .. " has new status " .. module5.STATE_STR[__wf_atom_4026dfb5])
		local v14 = _T.LocationEncounterData[c_str]

		if not v14 then
			print("OnChildEncStatusChanged error: " .. childHint:GetName() .. " has no encounter data! This could be due to rollover (this case is very unlikely in retail / without force reroll button)!")
			return
		end

		v14.status = __wf_atom_4026dfb5
		v14.childHint = childHint
		module6.LogDynamicQuestStatusChange(
			__wf_atom_26b04ea9,
			v14.status,
			v14.encHintTag,
			v14.missionTag,
			module5.GetEnemyLevel(childHint)
		)

		if __wf_atom_4026dfb5 == 2 then
			v14.pendingTransmissionEvent = "_Intro"
		elseif __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 3 then
			if math.random() <= 0.05 then
				v14.pendingTransmissionEvent = "_AltSuccess"
			else
				v14.pendingTransmissionEvent = "_Success"
			end

			fn4(v14.encHint:GetPosition(), false)
		end

		if __wf_atom_4026dfb5 == 4 then
			fn5(childHint)
		end
	end
end

local function fn7(state) -- 2 equivalent calls inferred from this helper
	return "LoreLocation-" .. tostring(state.encHintTag)
end

local function fn8(state, _)
	if
		_G.DisableDailyLocationEncounters
		or (__wf_atom_7e8ad928(state) or not state.encHintTag:__wf_atom_8598f3a9())
	then
		return false
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(state.encHintTag)
	local c_str = state.encHintTag:c_str()

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("SetupLocation warning: Location with tag " .. c_str .. " not found")
		return false
	end

	local __wf_atom_5b6b447d = __wf_atom_0a6a5887:__wf_atom_5b6b447d()

	if __wf_atom_5b6b447d == EMPTY_SYMBOL then
		local __wf_atom_e370bfde = __wf_atom_0a6a5887:__wf_atom_e370bfde()

		if __wf_atom_7e8ad928(__wf_atom_e370bfde) or #__wf_atom_e370bfde == 0 then
			print("SetupLocation: No available encounter type found for " .. c_str)
			return false
		end

		for i = #__wf_atom_e370bfde, 1, -1 do
			local v14 = false

			for _, v15 in ipairs(v3) do
				if v15 ~= __wf_atom_e370bfde[i] then
					continue
				end

				v14 = true
				break
			end

			if not v14 then
				table.remove(__wf_atom_e370bfde, i)
			end
		end

		if #__wf_atom_e370bfde == 0 then
			return false
		end

		state.encHint = __wf_atom_0a6a5887
		__wf_atom_0a6a5887:Enable()
		print("SetupLocation: Location encounter task starting: " .. c_str)
		local randomizeTableOrder = module.RandomizeTableOrder(__wf_atom_e370bfde)

		for i = #randomizeTableOrder, 1, -1 do
			local count = 0

			for _, v14 in pairs(_T.LocationEncounterData) do
				if v14.missionTag == randomizeTableOrder[i] then
					count += 1
				end
			end

			if count >= 2 and #randomizeTableOrder > 1 then
				table.remove(randomizeTableOrder, i)
			end
		end

		state.missionTag = randomizeTableOrder[__wf_atom_5784a397(1, #randomizeTableOrder)]
		print("SetupLocation: Encounter type " .. tostring(state.missionTag) .. " selected for " .. c_str)
		module2.AddSparrowDestination(
			__wf_atom_0a6a5887,
			nil,
			fn7(state), -- inferred equivalent call
			module2.PRIORITY.HIGH,
			Range(50, 3.4028234663852886e38)
		)
		fn4(__wf_atom_0a6a5887:GetPosition(), true)
		__wf_atom_0a6a5887:__wf_atom_99a5d75c("OnChildEncStatusChanged", (Symbol(c_str .. "EncCallback")))

		if __wf_atom_7e8ad928(v:PrimeMissionOnHint(state.missionTag, __wf_atom_0a6a5887)) then
			state.status = 0
		end

		module6.LogDynamicQuestStatusChange(
			__wf_atom_0a6a5887,
			1,
			state.encHintTag,
			state.missionTag,
			module5.GetEnemyLevel(__wf_atom_0a6a5887)
		)
		return true
	else
		state.missionTag = __wf_atom_5b6b447d
		state.encHint = __wf_atom_0a6a5887
		__wf_atom_0a6a5887:Enable()
		return true
	end
end

local function fn9(missionTag, pendingTransmissionEvent, encHint)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v14 = encHint:__wf_atom_8f18e876() * 1.25
	local v15 = module4.HasCompletedQuest(WeakResource("/SF/Types/Quests/TCDemoQuest")) and "_Good" or "_Evil"

	for _, v16 in ipairs(__wf_atom_ef7900cf) do
		if not (v16:__wf_atom_1c8f7b2d(encHint) <= v14) then
			continue
		end

		if module3.PlayLocalTransmission(
			transmissionSet,
			Symbol(tostring(missionTag) .. pendingTransmissionEvent .. v15),
			v16
		) then
			continue
		end

		module3.PlayLocalTransmission(transmissionSet, Symbol("Generic" .. pendingTransmissionEvent .. v15), v16)
	end
end

local function fn10(state, p, p2) -- 3 equivalent calls inferred from this helper
	gRegion:__wf_atom_5b35a0c8(state.encHint:GetPosition(), p, "[" .. tostring(state.encHintTag) .. "] " .. p2, 1, 0)
end

local function fn11(state)
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.encHint) or state.finished then
		return true
	end

	if state.pendingTransmissionEvent then
		fn9(state.missionTag, state.pendingTransmissionEvent, state.encHint)
		state.pendingTransmissionEvent = nil
	end

	if state.status == 4 then
		if _T.DebugDrawDailyLocations then
			local v14 = Color(0, 192, 0)
			gRegion:__wf_atom_5b35a0c8(
				state.encHint:GetPosition(),
				v14,
				"[" .. tostring(state.encHintTag) .. "] Finished",
				1,
				0
			)
		end

		module2.RemoveSparrowDestination(state.encHint, fn7(state)) -- inferred equivalent call
		state.finished = true
		return true
	else
		if (state.status == 0 or state.status == 6) and state.encHint:__wf_atom_5b6b447d() == EMPTY_SYMBOL then
			print("_MonitorEncounter: Attempting to re-prime encounter " .. tostring(state.missionTag) .. " for " .. tostring(state.encHintTag))

			if __wf_atom_7e8ad928(state.childHint) then
				if not __wf_atom_7e8ad928(v:PrimeMissionOnHint(state.missionTag, state.encHint)) then
					print("_MonitorEncounter: Re-primed encounter " .. tostring(state.missionTag) .. " for " .. tostring(state.encHintTag))
				end
			else
				print("_MonitorEncounter: Couldn't reprime encounter because child hint is still active for " .. tostring(state.encHintTag))
				return false
			end
		end

		if not _T.DebugDrawDailyLocations then
			return false
		end

		if state.status == 2 then
			fn10(state, Color(0, 255, 0), "In Progress " .. tostring(state.missionTag)) -- inferred equivalent call
		elseif state.encHint:__wf_atom_5b6b447d() == EMPTY_SYMBOL then
			fn10(state, Color(255, 0, 0), "Not Primed " .. tostring(state.missionTag)) -- inferred equivalent call
		else
			fn10(state, Color(255, 255, 0), "Primed " .. tostring(state.missionTag)) -- inferred equivalent call
		end

		return false
	end
end

local function fn12(p)
	local c_str = p.encHintTag:c_str()

	if v13 and v13[c_str] then
		print("ShouldSetupLocation: Encounter " .. c_str .. " is live, so does not require setting up again")
		return false
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p.encHintTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or module5.GetMissionEncounterAllowed(__wf_atom_0a6a5887) then
		if __wf_atom_72884638("Debug.Game.LocationEncountersResetOnLogin") then
			return true
		end

		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
		local v14 = fn() -- inferred equivalent call

		for _, v15 in pairs(__wf_atom_3c8e1a7a) do
			local __wf_atom_02d9b60c = gGameRules:__wf_atom_02d9b60c(v15:__wf_atom_ef151cfd(), p.encHintTag:c_str())

			if __wf_atom_7e8ad928(__wf_atom_02d9b60c) then
				return true
			end

			if math.floor(tonumber(__wf_atom_02d9b60c.mDate.sec) / (v14 * 3600)) < math.floor(gGameRules:__wf_atom_93691ff2() / (v14 * 3600)) then
				return true
			end
		end

		print("ShouldSetupLocation: Skipping " .. c_str .. " because all players have already completed it in the " .. tostring(v14) .. "hr window (SFGameRules.DailyLocationResetFrequency)!")
		p.loreCompleted = true
		return false
	else
		p.blocked = true
		print("ShouldSetupLocation: Skipping " .. c_str .. " because it is blocked!")
		return false
	end
end

function UnprimeInactiveLocations()
	local v14 = WeakResource("/SF/Types/Game/Encounters/Tales/RegionMissionEncounterHint")

	for _, v15 in ipairs(v2) do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15.encHintTag)
		local v16 = false

		for _, v17 in pairs(_T.LocationEncounterData) do
			if v15.encHintTag ~= v17.encHintTag then
				continue
			end

			v16 = true
			break
		end

		if
			v16 and module5.GetMissionEncounterAllowed(__wf_atom_0a6a5887)
			or __wf_atom_7e8ad928(__wf_atom_0a6a5887)
			or __wf_atom_0a6a5887:__wf_atom_5b6b447d() == EMPTY_SYMBOL
		then
			continue
		end

		__wf_atom_0a6a5887:__wf_atom_75628d88(EMPTY_SYMBOL)

		if __wf_atom_0a6a5887:IsA(v14) then
			__wf_atom_0a6a5887:Disable()
		end

		fn4(__wf_atom_0a6a5887:GetPosition(), false)
		module2.RemoveSparrowDestination(__wf_atom_0a6a5887)
	end
end

function RunDailyLocationEncounters(_)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v = module.WaitForAiDir()
	Sleep(1)
end