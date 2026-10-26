local v = WeakResource("/SF/Types/Quests/TCDemoQuest")
local v2 = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesProcDemo")
local v3 = Symbol("GladesProcEntrance")
local v4 = Symbol("AvakotWellCamp")
local v5 = Symbol("CollectorShip")
local v6 = Symbol("GladeEntranceCamp")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local module7 = require("SF.Scripts.Libs.StatsLib")
local module8 = require("SF.Scripts.Libs.TransmissionSet")
local module9 = require("SF.Scripts.Libs.ModifySkyLib")

local function fn(object, list)
	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		local position = object:GetPosition()

		for _, v7 in ipairs(list) do
			if not __wf_atom_7e8ad928(v7) and v7:__wf_atom_1eaf335c(position) then
				return true
			end
		end
	end
end

function GiveLoreDrop()
	if not (next(loredrops) ~= nil and __wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:__wf_atom_bc01af29() then
				for _, v7 in ipairs(loredrops) do
					if __wf_atom_d2b2176d:__wf_atom_96a19f31(v7) < 1 then
						module.GiveLoreFragment(__wf_atom_50a7d83e, v7)
					end
				end
			end
		end
	end
end

local function fn2(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)
	local v7 = nil

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(__wf_atom_f51baf83, __wf_atom_0a6a5887:GetPosition())

		if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
			__wf_atom_e2db08ce:__wf_atom_f0d175d4(0)
		end

		local nearestTagged = gRegion:FindNearestTagged(Symbol("LockShrineWp"), __wf_atom_0a6a5887:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			v7 = gRegion:FindNearestTagged(Symbol("ResShrine"), nearestTagged:GetPosition())
		end
	end

	if not __wf_atom_7e8ad928(v7) then
		local __wf_atom_f582136d = v7:__wf_atom_f582136d(__wf_atom_8b8e8b22)

		for _, v8 in ipairs(__wf_atom_f582136d) do
			v8:Disable()
		end
	end
end

function CinematicIntro(p)
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if gRegion:IsMaster() then
		print("Garren Quest: Stage 1 Cinematics")
	else
		print("Garren Quest: Stage 1 Cinematics (client)")
	end

	module2.TrackQuest(mOwner)

	function _T.InterruptNightFoldFunction()
		module.WaitForLevel()

		if
			module2.TaggedTaskIsActive(v, Symbol("Cinematics"))
			or module2.TaggedTaskIsActive(v, Symbol("TalkToAvakot"))
		then
			module9.ClearWeatherAndDisableCycle()
			_T.GarrenIntroCinPlaying = true
			module.PlayCinematicWithTagAndWait(Symbol("QuestIntroCin"))
		else
			print("Skipping Stag quest cinematic.")
		end

		_T.GarrenIntroCinPlaying = nil
	end

	while __wf_atom_7e8ad928(_T.GarrenIntroCinPlaying) do
		Sleep(0)
	end

	while _T.GarrenIntroCinPlaying do
		Sleep(0)
	end

	module9.SetWeatherCycleEnabled(true)

	if gRegion:IsMaster() then
		module.WaitToExitNightfold()
		Sleep(2)
		module.WaitToExitNightfold()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickWakeUpScript"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickWakeUpScriptAnywhere"))
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			return
		end

		__wf_atom_0a6a5887:FirePort("Enable")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsEnabled() do
			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			end

			if
				__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				or not (__wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) > 30)
			then
				Sleep(1)
			else
				__wf_atom_0a6a5887_2:FirePort("Execute")
				__wf_atom_0a6a5887:FirePort("Disable")
				break
			end
		end

		Sleep(10)
		module8.WaitForTransmissions()
		Sleep(2)
		print("Garren Quest: Stage 1 done")
		module2.CompleteTaskWithID(mOwner, p)
	end
end

local function fn3(blockCombatDynamicContainer, position) -- 4 equivalent calls inferred from this helper
	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_ccbb5582((gRegion:CreateEntity(
		blockCombatDynamicContainer,
		position,
		__wf_atom_80368bb1
	)))
end

function TalkToAvakot(p)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 2 Talk to Avakot (client)")
		return
	end

	print("Garren Quest: Stage 2 Talk to Avakot")
	module.WaitForLevel()
	module.WaitForAiDir()

	if not module.IsInOverworld() then
		print("Garren Quest: Stage 2 early out, not in overworld")
		return
	end

	module2.TrackQuest(mOwner)
	module.TaggedFirePorts(Symbol("MidGarrenCloseGladeVines"), "TriggerPort")
	module.TaggedFirePorts(Symbol("DemoQuestSetupPartOne"), "TriggerPort")
	module.TaggedFirePorts(Symbol("AvakotCageSetup"), "TriggerPort")
	_T.GotOdeItem = nil
	_T.AvakotMenuStage = nil
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)
	fn3(blockCombatDynamicContainer, __wf_atom_0a6a5887:GetPosition()) -- inferred equivalent call
	module6.SetEncounterHeaviesBlocked(__wf_atom_0a6a5887, true)
	__wf_atom_0a6a5887:__wf_atom_252fae6e(3)

	while _T.GarrenIntroCinPlaying do
		Sleep(0)
	end

	module.WaitForLoginSequence()
	module.WaitToExitNightfold()
	Sleep(1)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("AvakotCageWaypoint"))
	module5.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)

	if not module.IsInOverworld() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local entity = gRegion:CreateEntity(tutorialTriggerType, __wf_atom_c4f78a8f:GetPosition(), __wf_atom_80368bb1)

	while not __wf_atom_7e8ad928(entity) do
		Sleep(0)
	end

	module4.UpdateOrAddHudTask(mOwner, p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module2.CreateAreaMarker(__wf_atom_0a6a5887, 45, __wf_atom_28d5d4aa, mOwner, p)
	end

	local total = 0

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and module.IsInOverworld() do
		local __wf_atom_4026dfb5 = __wf_atom_0a6a5887:__wf_atom_4026dfb5()

		if
			__wf_atom_4026dfb5 == 4
			or __wf_atom_4026dfb5 == 3
			or __wf_atom_0a6a5887:__wf_atom_f43d338d()
			or __wf_atom_0a6a5887:__wf_atom_c6ecf9af()
			or not __wf_atom_0a6a5887:IsEnabled()
		then
			module.TaggedFirePorts(Symbol("AvakotCageHelp"), "TriggerPort")
			Sleep(3)
			module4.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/TalkToAvakot")

			while not _T.GotOdeItem do
				Sleep(0)

				if module.IsInOverworld() then
					continue
				end

				print("Garren Quest: Stage 2 early out waiting to complete Avakot dialog, exited overworld")
				return
			end

			print("Garren Quest: Stage 2 Talk to Avakot done")
			module4.CompleteHudTask(mOwner, nil, p, 3)
			module2.CompleteTaskWithID(mOwner, p)
			break
		else
			Sleep(0)
			total += __wf_atom_084b3e93()
		end
	end
end

local function fn4(p)
	print("Garren Quest: Stage 3a Find the Totem (in overworld)")
	local v7 = Symbol("UndercityPortalAvakotWell")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v7)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v4)
	module2.CreateAreaMarker(__wf_atom_0a6a5887_2, 45, __wf_atom_28d5d4aa, mOwner, p)
	module5.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	module.TaggedFirePorts(Symbol("DemoUnderCitySetup"), "TriggerPort")
	module.SetQuestProcLevel(v7, WeakResource("/SF/Levels/Procs/Quest/UnderCityGarrenTotem"))
	Sleep(4)
	module4.UpdateOrAddHudTask(mOwner, p)
end

function RetrieveTotemDungeon(task)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 3 Find the Totem (client)")
		return
	end

	print("Garren Quest: Stage 3 Find the Totem")
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module2.TrackQuest(mOwner)
	print("Running task script for quest " .. mOwner:__wf_atom_1bb5b1ff():GetName() .. " task " .. tostring(task))

	if module.IsInOverworld() then
		fn4(task)
		return
	end

	if not module.HasStreamedLevel("UnderCityObjTotem") then
		return
	end

	print("Garren Quest: Stage 3b Find the Totem (in undercity)")
	_T.GarrenUCQuest = { quest = mOwner, task = task }
	module3.SetCurrentLocationQuest(mOwner, task)
	module4.CompleteHudTask(mOwner, nil, task)
	Sleep(3)
	module4.UpdateOrAddHudTask(mOwner, task, "/SF/Language/Quests/RetrieveTheTotem")
	module.TaggedFirePorts(Symbol("DemoUnderCitySetup"), "TriggerPort")
	module.TaggedFirePorts(Symbol("DisableStreamTrigger"), "TriggerPort")
	module.TaggedFirePorts(Symbol("TrapEncounterSetup"), "TriggerPort")
	module6.AddDungeonObjective(talkToAvakotScript)
	module6.AddDungeonObjective(retrieveTotemScript)

	while not _T.TotemPickedUp do
		if module.IsInOverworld() then
			print("Returned to overworld before picking up the totem")
			return
		else
			Sleep(0)
		end
	end

	module7.ReplicateLogEvent("STAG_QUEST", "AquireTotem")
	module4.CompleteHudTask(mOwner, nil, task, 4)
	module2.CompleteTaskWithID(mOwner, task)
end

function RetrievedTotem(task)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 3 Find the Totem (client)")
		return
	end

	print("Garren Quest: Stage 3 Find the Totem")
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module2.TrackQuest(mOwner)
	print("Running task script for quest " .. mOwner:__wf_atom_1bb5b1ff():GetName() .. " task " .. tostring(task))

	if module.IsInOverworld() then
		fn4(task)
		return
	end

	if not module.HasStreamedLevel("UnderCityObjTotem") then
		return
	end

	print("Garren Quest: Stage 3b Find the Totem (in undercity)")
	_T.GarrenUCQuest = { quest = mOwner, task = task }
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TotemTeleportWp"))
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local flag = false
	local v7 = false

	for _, v8 in ipairs(__wf_atom_ef7900cf) do
		if not (v8:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) <= 20) then
			continue
		end

		v7 = true
		break
	end

	if not v7 then
		gRegion:CreateEntity(
			teleportHereScriptTriggerType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		):FirePort("Execute")
		flag = true
	end

	if flag then
		module4.RemoveHudTask(mOwner, nil, task)
		module.TaggedFirePorts(Symbol("TotemFromCheckpoint"), "TriggerPort")
	end

	Sleep(7)
	module.TaggedFirePorts(Symbol("TotemPickedUpForwarder"), "TriggerPort")
	module.TaggedFirePorts(Symbol("SparrowGrabTotemSeq"), "Enable")
	gRegion:CreateEntity(absorbJotarScript, __wf_atom_0a6a5887:GetPosition(), __wf_atom_80368bb1):FirePort("Execute")
	local taggedInTileType = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))

	if not __wf_atom_7e8ad928(taggedInTileType) and #taggedInTileType > 0 then
		module5.AddQuestDestination(taggedInTileType[1], mOwner, task)
	end

	print("Waiting to return to Midrath...")

	while not module.IsInOverworld() do
		Sleep(0)
	end

	_T.TotemPickedUp = nil
	print("Garren Quest: Stage 3 Find the Totem done")
	module2.CompleteTaskWithID(mOwner, task)
end

function ExitedUnderCity(p)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 4 Exit Undercity (client)")
		return
	end

	print("Garren Quest: Stage 4 Exit Undercity")
	module.WaitForLevel()
	module.WaitForAiDir()

	if not module.IsInOverworld() then
		print("Garren Quest: Stage 4 early out, not in overworld")
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DemoMount"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("StagQuestMusicSparrowPath"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("RiverCinMusicAction"))
	module.TaggedFirePorts(Symbol("GarrenQuestSpawnZone"), "Enable")
	fn3(blockCombatDynamicContainer, __wf_atom_0a6a5887:GetPosition()) -- inferred equivalent call
	fn3(blockCombatDynamicContainer, __wf_atom_0a6a5887_2:GetPosition()) -- inferred equivalent call
	local v7 = module5.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, p)
	module5.GenerateRoadPath(v7, __wf_atom_0a6a5887_2:GetPosition())
	print("Garren Quest: Stage 4 Exit Undercity done")
	module2.CompleteTaskWithID(mOwner, p)
end

local function fn5()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v6)
	module6.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("Glades-AtCamp"))
	module6.SetMissionEncounterAllowed(__wf_atom_0a6a5887_2, false)
end

function GotoMusicPuzzle(p)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 5 Learn Song (client)")
		return
	end

	print("Garren Quest: Stage 5 Learn Song")
	module.WaitForLevel()

	if not module.IsInOverworld() then
		print("Garren Quest: Stage 5 early out, not in overworld")
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RiverCinMusicAction"))
	local areaMarker = module2.CreateAreaMarker(__wf_atom_0a6a5887, 45, __wf_atom_28d5d4aa, mOwner, p)
	module.TaggedFirePorts(Symbol("DemoQuestSetupPartTwo"), "TriggerPort")
	module.TaggedFirePorts(v6, "Disable")
	module.TaggedFirePorts(Symbol("GarrenQuestSpawnZone"), "Enable")
	fn3(blockCombatDynamicContainer, __wf_atom_0a6a5887:GetPosition()) -- inferred equivalent call
	fn5()
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("RoadForkCamp"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:__wf_atom_252fae6e(module6.GetEnemyLevel(__wf_atom_0a6a5887_2, true).minValue)
	end

	module.WaitForLoginSequence()
	module2.TrackQuest(mOwner)
	module4.UpdateOrAddHudTask(mOwner, p)
	module5.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local total = 0

	while
		__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		or not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) > 20
	do
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:FirePort("Enable")
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraCin"))
	local flag = false

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) do
		if flag then
			if not __wf_atom_0a6a5887_3:__wf_atom_7d4910e4() then
				module9.SetWeatherCycleEnabled(true)

				if not __wf_atom_7e8ad928(areaMarker) then
					areaMarker:Destroy()
				end

				module5.RemoveSparrowDestination(__wf_atom_0a6a5887)
				print("Garren Quest: Stage 5 Learn Song done")
				module2.CompleteTaskWithID(mOwner, p)
				break
			end
		elseif __wf_atom_0a6a5887_3:__wf_atom_7d4910e4() then
			module9.ClearWeatherAndDisableCycle()
			module7.ReplicateLogEvent("STAG_QUEST", "EndSongPuzzle")
			local __wf_atom_bb3e7833 = gRegion:__wf_atom_c4f78a8f():__wf_atom_bb3e7833(instrumentDecoType)
			gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
			flag = true
		end

		Sleep(0)
	end
end

function SetExitShrineEnabled(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ResShrine"))

	for _, v7 in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_be0bea4a = v7:__wf_atom_be0bea4a()

		for _, v8 in ipairs(__wf_atom_be0bea4a) do
			if not v8:IsA(__wf_atom_589cefdb) then
				continue
			end

			if p then
				v8:FirePort("Enable")
			else
				v8:FirePort("Disable")
			end
		end
	end
end

local function fn6(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GladesGarrenDiscoveryTrigger"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v6)
	local midpoint = (__wf_atom_0a6a5887:GetPosition() + __wf_atom_0a6a5887_2:GetPosition()) / 2
	module2.CreateAreaMarkerAtPos(midpoint, 45, __wf_atom_28d5d4aa, mOwner, p)
end

function GarrenFightStartMonitor(p)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 6 Find the Stag (client)")
		return
	end

	print("Garren Quest: Stage 6 Find the Stag")
	module.WaitForLevel()

	if module.IsInOverworld() then
		print("Garren Quest: Stage 6a Find the Stag (overworld)")
		module.WaitForLoginSequence()
		module2.TrackQuest(mOwner)
		module3.OverrideDungeonKey(v3, missionKey)
		module4.UpdateOrAddHudTask(mOwner, p)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887 = gRegion:__wf_atom_f738b4af(
				Symbol("StreamingDungeonEntranceWp"),
				__wf_atom_0a6a5887:GetPosition(),
				0,
				50
			)
		end

		local v7 = module5.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("StagQuestGladeSparrowPath"))
		module5.SetupWaypointPath(v7, __wf_atom_0a6a5887_2)
		fn5()
		module.TaggedFirePorts(Symbol("GarrenQuestSpawnZone"), "Enable")
		module.TaggedFirePorts(v6, "Disable")
		module.TaggedFirePorts(Symbol("DemoGladeCampTrigger"), "Enable")
		module.SetQuestProcLevel(v3, v2)
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorCin"))

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_4)) then
			__wf_atom_0a6a5887_3:SetPosition(__wf_atom_0a6a5887_4:GetPosition())
		end

		fn6(p)
	else
		if not module.HasStreamedLevel("GarrenRoodBossArena") then
			return
		end

		print("Garren Quest: Stage 6b Find the Stag (glades)")
		SetExitShrineEnabled(false)
		module4.CompleteHudTask(mOwner, nil, p)
		Sleep(3)
		module4.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/FindGarren")
		module2.TrackQuest(mOwner)
		module.TaggedFirePorts(Symbol("DemoGladeSetup"), "TriggerPort")
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowDestPuzzle"))
		module5.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)

		while not (_T.StagShrinePuzzleSolved or _T.deoraFightSequence) do
			Sleep(0)
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowDestBoss"))
		module5.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)

		while not _T.deoraFightSequence do
			Sleep(0)
		end

		print("Garren Quest: Stage 6 Find the Stag done")
		module2.CompleteTaskWithID(mOwner, p)
		_T.StagShrinePuzzleSolved = nil
	end
end

function ShowDiorama()
	module.StreamAndPlayCinematicLevel(WeakResource("/SF/Levels/GarrenQuestOutro.level"), false, false)
end

local function fn7(p, object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v7 in ipairs(__wf_atom_ef7900cf) do
		if v7:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v7, Symbol("Envoy"))
			end
		else
			v7:__wf_atom_a7ee9662(p, true)
		end
	end
end

function PrepareCin(p)
	fn7(false, p)
end

function SetPlayerVisibility(_)
	while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
		Sleep(0)
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v7 in ipairs(__wf_atom_ef7900cf) do
		if not v7:__wf_atom_4417a5d4() then
			v7:__wf_atom_a7ee9662(true, true)
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	if gRegion:IsMaster() then
		__wf_atom_c4f78a8f:__wf_atom_51075230(__wf_atom_c4f78a8f:MotionControl():__wf_atom_d9cb4b97())
		return
	end

	local v7 = { Vector(1, 0.1, 0), Vector(-1, 0.1, 0), Vector(0, 0.1, 1), Vector(1, 0.1, -1) }
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v8 = {}

	for _, v9 in ipairs(__wf_atom_3c8e1a7a) do
		table.insert(v8, v9:__wf_atom_ef151cfd())
	end

	table.sort(v8)
	local __wf_atom_ef151cfd = gRegion:__wf_atom_eab484a7():__wf_atom_ef151cfd()
	local v9 = v7[1]

	for i, v10 in ipairs(v8) do
		if v10 ~= __wf_atom_ef151cfd then
			continue
		end

		v9 = v7[i]
		break
	end

	__wf_atom_c4f78a8f:Teleport(
		__wf_atom_c4f78a8f:GetPosition() + v9,
		__wf_atom_c4f78a8f:MotionControl():__wf_atom_d9cb4b97()
	)
	__wf_atom_c4f78a8f:__wf_atom_51075230(__wf_atom_c4f78a8f:MotionControl():__wf_atom_d9cb4b97())
end

function PostFightPrepareCin(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_d2b2176d():Unequip(0, 2)
		__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
		__wf_atom_c4f78a8f:CameraControl():__wf_atom_25382a0d(1, false)
	end

	fn7(false, p)
end

function GarrenFightEndMonitor(p)
	if gRegion:IsMaster() then
		print("Garren Quest: Stage 6 Defeat Garren")
		module.WaitForLevel()
		_T.GarrenFightEndMonitor = true

		if module.IsInOverworld() then
			print("Garren Quest: Stage 6a Defeat Garren (overworld)")
			module.WaitForLoginSequence()
			module2.TrackQuest(mOwner)
			module3.OverrideDungeonKey(v3, missionKey)
			module4.UpdateOrAddHudTask(mOwner, p)
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887 = gRegion:__wf_atom_f738b4af(
					Symbol("StreamingDungeonEntranceWp"),
					__wf_atom_0a6a5887:GetPosition(),
					0,
					30
				)
			end

			module5.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
			fn5()
			module.TaggedFirePorts(Symbol("GarrenQuestSpawnZone"), "Enable")
			module.TaggedFirePorts(v6, "Disable")
			module.TaggedFirePorts(Symbol("DemoGladeCampTrigger"), "Enable")
			module.SetQuestProcLevel(v3, v2)
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
			local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorCin"))

			if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_3)) then
				__wf_atom_0a6a5887_2:SetPosition(__wf_atom_0a6a5887_3:GetPosition())
			end

			fn6(p)
		elseif module.HasStreamedLevel("GarrenRoodBossArena") then
			print("Garren Quest: Stage 6a Defeat Garren (glades)")
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			SetExitShrineEnabled(false)
			module2.TrackQuest(mOwner)
			module4.CompleteHudTask(mOwner, nil, p)
			Sleep(3)
			module4.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/DefeatGarrenBoss")
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenArenaEntrance"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

				for _, v7 in ipairs(__wf_atom_ef7900cf) do
					if not (v7:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > 50) then
						continue
					end

					gRegion:CreateEntity(
						teleportHereScriptTriggerType,
						__wf_atom_0a6a5887:GetPosition(),
						__wf_atom_0a6a5887:__wf_atom_dc309f8a()
					):FirePort("Execute")
					break
				end
			end

			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("HealGarrenCin"))

			while __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) do
				Sleep(0.1)
				__wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("HealGarrenCin"))
			end

			module.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)
			local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightCin"))

			while __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) do
				Sleep(0.1)
				__wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightCin"))
			end

			module.WaitForCinematicToFinish(__wf_atom_0a6a5887_3)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
				__wf_atom_0a6a5887_3:__wf_atom_8a035cd5(Symbol("ShowDiorama"), false)
			end

			while
				__wf_atom_7e8ad928(__wf_atom_392793db)
				or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())
			do
				Sleep(0)
			end

			gGameRules:CommitInventoryCheckpointToDB(0, 0)

			while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
				Sleep(0)
			end

			local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))
			local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightGarren"))
			__wf_atom_0a6a5887_4:SetPosition(__wf_atom_0a6a5887_5:GetPosition())
			__wf_atom_0a6a5887_4:__wf_atom_9b788a35(__wf_atom_0a6a5887_5:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_4:SetVisibility(true, true)
			local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))
			local __wf_atom_0a6a5887_7 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightDeora"))
			__wf_atom_0a6a5887_6:SetVisibility(false)
			__wf_atom_0a6a5887_6:Teleport(__wf_atom_0a6a5887_7:GetPosition(), __wf_atom_0a6a5887_7:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_6:SetPosition(__wf_atom_0a6a5887_7:GetPosition())
			__wf_atom_0a6a5887_6:__wf_atom_9b788a35(__wf_atom_0a6a5887_7:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_6:SetVisibility(true, true)
			fn7(true)
			module.Fade(true, 0)
			module.Fade(false, 0.5)
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("WarpPoint"))
			local v7 = Symbol("Boss")

			for _, v8 in ipairs(__wf_atom_2226b35c) do
				v8:Enable()

				if v8:__wf_atom_e800787c():__wf_atom_db682341() == v7 then
					module5.AddSparrowDestination(v8, nil, nil, module5.PRIORITY.EXIT, Range(0, 100))
				end
			end

			module5.AddSparrowDestinationTag(Symbol("GladeExitWp"), nil, module5.PRIORITY.EXIT)
			SetExitShrineEnabled(true)
			module7.ReplicateLogEvent("STAG_QUEST", "OutroCinFinished")
			print("Garren Quest: Stage 6 Defeat Garren done")
			module2.CompleteTaskWithID(mOwner, p)
			Sleep(0.5)

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PostQuestRewardScreen"), false)
			end

			while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
				Sleep(0)
			end
		end

		_T.GarrenFightEndMonitor = nil
	else
		print("Garren Quest: Stage 6 Defeat Garren (client)")
		module.WaitForLevel()
		_T.GarrenFightEndMonitor = true
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightCin"))

		while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
			Sleep(1)
			__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightCin"))
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			module.WaitForCinematicToFinish(__wf_atom_0a6a5887)
		end

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			_T.GarrenFightEndMonitor = nil
			return
		end

		__wf_atom_0a6a5887:__wf_atom_8a035cd5(Symbol("ShowDiorama"), false)

		while __wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8()) do
			Sleep(0)
		end

		gGameRules:CommitInventoryCheckpointToDB(0, 0)

		while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
			Sleep(0)
		end

		fn7(true)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightGarren"))
		__wf_atom_0a6a5887_2:SetPosition(__wf_atom_0a6a5887_3:GetPosition())
		__wf_atom_0a6a5887_2:__wf_atom_9b788a35(__wf_atom_0a6a5887_3:__wf_atom_dc309f8a())
		__wf_atom_0a6a5887_2:SetVisibility(true, true)
		Sleep(0.5)

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PostQuestRewardScreen"), false)
		end

		while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
			Sleep(0)
		end

		_T.GarrenFightEndMonitor = nil
	end
end

function PostQuestRewardScreen()
	_T.ForceShowPup = false
	local v7 = { Label = questCompletedLable, CacheIndex = 1 }
	module2.WakeUpInNightFold(5, nil, nil, true, v7)
end

function BackInOverworld(p)
	if not gRegion:IsMaster() then
		print("Garren Quest: Stage 7 Back to Midrath (client)")
		return
	end

	print("Garren Quest: Stage 7 Back to Midrath")
	Sleep(3)
	module4.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/BromiusReturnToMidrath")

	while not module.IsInOverworld() do
		Sleep(1)
	end

	module7.ReplicateLogEvent("STAG_QUEST", "QuestComplete", nil, nil, nil, "QuestComplete")
	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_25131806(Symbol("TaleOfGarrenRoodCompleted"))
	module.WaitForLevel()

	if module.IsInOverworld() then
		while Game.__wf_atom_2b221245(false) do
			Sleep(0.25)
		end

		module.SetQuestProcLevel(v3, nil)
	end

	module4.CompleteHudTask(mOwner, nil, p)
	gGameRules:UnHideGameSession()
	module2.CompleteTaskWithID(mOwner, p)
end

function HealTutorialTask(p)
	local v7 = WeakResource("/SF/Types/Gameplay/Tutorial/TutorialTrigger")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("IntroHealthPotionSpawn"))
	local v8 = nil

	for _, v9 in ipairs(__wf_atom_2226b35c) do
		gRegion:CreateEntity(healthPotionPickupType, v9:GetPosition(), v9:__wf_atom_dc309f8a())
	end

	Sleep(15)

	local function fn8()
		local v9 = WeakResource("/SF/Types/Items/Consumables/HealingPotion")
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		for i = 1, __wf_atom_d2b2176d:__wf_atom_62abd325(0) do
			local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i - 1, 0)

			if
				not __wf_atom_7e8ad928(__wf_atom_ba1c3957)
				and __wf_atom_ba1c3957:IsA(v9)
				and __wf_atom_d2b2176d:__wf_atom_b62f2024(i - 1, 0) > 0
			then
				return true
			end
		end

		return false
	end

	while true do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled() then
			Sleep(5)
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		else
			local __wf_atom_c6f1f83d = __wf_atom_c4f78a8f:__wf_atom_c6f1f83d()
			v8 = v8 or __wf_atom_c4f78a8f:GetMaxHealth()

			if
				__wf_atom_c6f1f83d <= v8 * 0.75
				and __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_bb3e7833(v7))
				and not module.IsInNightFold(__wf_atom_c4f78a8f)
				and fn8()
			then
				break
			else
				Sleep(3)
			end
		end
	end

	local tutorialTriggerType = tutorialTriggerType
	local EMPTY_SYMBOL = EMPTY_SYMBOL
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local v9 = __wf_atom_c4f78a8f:Attach(tutorialTriggerType, EMPTY_SYMBOL, __wf_atom_28d5d4aa)

	while not __wf_atom_7e8ad928(v9) do
		Sleep(0)
	end

	if gRegion:IsMaster() then
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function UnderCityRetrieveTotem(instance)
	print("Started retrieve totem stage")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DemoTotemAction"))
	module5.AddSparrowDestination(__wf_atom_0a6a5887, nil, nil, module5.PRIORITY.QUEST)

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsEnabled() do
		Sleep(0)
	end

	module5.RemoveSparrowDestination(__wf_atom_0a6a5887)

	if gRegion:__wf_atom_577a4d19() == 1 then
		fn2(Symbol("DoorLockedAfterTotemPickedUp"))
	end

	print("Finished retrieve totem stage")
	instance:Destroy()
end

function UndercityAvakotEncounter(instance)
	print("Started Avakot stage")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TalkToAvakot"))
	_T.TalkedToAvakotInUndercity = nil
	module5.AddSparrowDestination(__wf_atom_0a6a5887, nil, nil, module5.PRIORITY.QUEST)
	Sleep(1.5)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("LevelEntranceWp"))
	local v7

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		v7 = gRegion:CreateEntity(tutorialTriggerType, __wf_atom_0a6a5887_2:GetPosition(), __wf_atom_80368bb1)
	end

	local total = 0

	while total < 5 and not _T.Discoveries do
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DemoTotemAction"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		return
	end

	local position = __wf_atom_0a6a5887_3:GetPosition()

	while not _T.TalkedToAvakotInUndercity do
		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end

		if _T.TotemPickedUp or module.AnyPlayerNearPos(position, 50) then
			print("Skipped Avakot stage")
			break
		else
			Sleep(0)
		end
	end

	module5.RemoveSparrowDestination(__wf_atom_0a6a5887)
	print("Finished Avakot stage")
	instance:Destroy()
end

function UndercityJotarEncounter(instance)
	print("Started absorb Jotar stage")
	local taggedInTileType = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))

	if __wf_atom_7e8ad928(taggedInTileType) or #taggedInTileType == 0 then
		print("No exit waypoint, likely streaming out")
		return
	end

	local position = taggedInTileType[1]:GetPosition()
	module.TaggedFirePorts(Symbol("KickDoorToBridge"), "Enable")
	module4.CompleteHudTask(_T.GarrenUCQuest.quest, nil, _T.GarrenUCQuest.task)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickNearJotar"))
	module5.AddSparrowDestination(__wf_atom_0a6a5887, nil, nil, module5.PRIORITY.QUEST, Range(3, 3.4028234663852886e38))
	module4.UpdateOrAddHudTask(_T.GarrenUCQuest.quest, _T.GarrenUCQuest.task, "/SF/Language/Quests/FollowTheSparrow")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("SkipJotarTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Enable()
	end

	local v7 = WeakResource("/SF/Types/Npcs/WanderingAncestorAvatar")
	local v8 = nil

	while __wf_atom_7e8ad928(v8) do
		if module.AnyPlayerNearPos(position, 40) then
			print("Skipped to exit (1)")
			break
		end

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_0a6a5887_2:IsEnabled()) then
			print("Skipped absorb Jotar stage (1)")
			break
		end

		Sleep(1)
		local all = gRegion:FindAll(v7)

		if not __wf_atom_7e8ad928(all) then
			v8 = all[1]
		end
	end

	module5.RemoveSparrowDestination(__wf_atom_0a6a5887)

	if not (_T.PlayerGrantedFennJotarRune or __wf_atom_7e8ad928(v8)) then
		module5.AddSparrowDestination(v8, nil, nil, module5.PRIORITY.QUEST, Range(5, 30))
		module4.UpdateOrAddHudTask(_T.GarrenUCQuest.quest, _T.GarrenUCQuest.task, "/SF/Language/Quests/AbsorbJotar")
	end

	while not _T.PlayerGrantedFennJotarRune do
		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_0a6a5887_2:IsEnabled()) then
			print("Skipped absorb Jotar stage (2)")
			break
		end

		if module.AnyPlayerNearPos(position, 40) then
			print("Skipped to exit (2)")
			break
		else
			Sleep(0)
		end
	end

	module7.ReplicateLogEvent("STAG_QUEST", "AbsorbJotar")

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Disable()
	end

	module5.RemoveSparrowDestination(v8)

	if _T.PlayerGrantedFennJotarRune then
		Sleep(3)
		module4.CompleteHudTask(_T.GarrenUCQuest.quest, nil, _T.GarrenUCQuest.task)
		Sleep(6)
	end

	module4.UpdateOrAddHudTask(_T.GarrenUCQuest.quest, _T.GarrenUCQuest.task, "/SF/Language/Quests/LeaveUnderCity")
	local streamingExitWaypoint = module.GetStreamingExitWaypoint()
	module5.AddSparrowDestination(streamingExitWaypoint, nil, nil, module5.PRIORITY.QUEST)
	print("Finished absorb Jotar stage")
	instance:Destroy()
end

function AbsorbJotarTutorial(p, p2)
	local v7 = WeakResource("/SF/Types/Npcs/WanderingAncestorAvatar")
	local all = gRegion:FindAll(v7)

	while __wf_atom_7e8ad928(all) or #all == 0 do
		Sleep(1)
		all = gRegion:FindAll(v7)
	end

	local _ = all[1]
	local v8 = false

	while not (_T.FennSoulStolen or _T.IsRuneTutorialActive) do
		local v9 = fn(p2, { p })

		if v8 or not v9 then
			if not v9 and v8 then
				if _T.HideImpactMessage then
					_T.HideImpactMessage()
				end

				v8 = false
			end
		else
			_T.ShowImpactMessage("/SF/Language/Tutorial/SoulAbsorbJotar_KBM", -1)
			v8 = true
		end

		Sleep(0)
	end

	if _T.HideImpactMessage then
		_T.HideImpactMessage()
	end
end

function StreamingCorridorLockedDoor(object)
	if not module.IsInOverworld() then
		return
	end

	if not module2.TaggedTaskIsActive(v, Symbol("FindTheTotem")) then
		gRegion:FindNearestTagged(Symbol("BlockStreamingDoor"), object:GetPosition()):FirePort("TriggerPort")
	end
end

function DissolveAwayBlockers()
	local v7 = 0
	local total = 0

	while v7 < 1 do
		v7 = math.min(total / 2, 1)

		for _, v8 in ipairs(decos) do
			v8:__wf_atom_a763aa1a(v7)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	for _, v8 in ipairs(decos) do
		v8:FirePort("Hide")
	end
end

function PostGarrenSetup()
	Sleep(5)

	if module2.HasCompletedQuest(v) and not module2.QuestIsActive(v) then
		module.TaggedFirePorts(Symbol("PostGarrenOpenGladeVines"), "TriggerPort")
	end
end

function RunScriptTrigger(object)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.WaitForAiDir()
	object:FirePort("Execute")
end

function ShowCollectorShip()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v5)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true)
	end
end

function HideCollectorShip()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v5)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(false)
	end
end