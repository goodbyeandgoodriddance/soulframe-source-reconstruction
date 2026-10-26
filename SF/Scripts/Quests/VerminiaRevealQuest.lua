local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module7 = require("SF.Scripts.NightFoldLib")
local module8 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module9 = require("SF.Scripts.Libs.ModifySkyLib")
local v = Symbol("VerminiaRuinsCamp")
local v2 = Symbol("VerminiaAncientRootsTrigger")
local v3 = Symbol("VerminiaNearRuinsTrigger")
local v4 = Symbol("HighlandsRuinCamp")
local v5 = nil
local v6 = nil
local v7 = false
local v8 = nil
local v9 = { Symbol("VadagarSidaesStake") }
Resource("/SF/Objects/Dendrit/Props/RatCage01B.fbx")
local v10 = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/AncestorVerminiaDiscoveryQuest")
local v11 = Vector(-164.404, -56.1359, -658.443)
local v12 = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesProcLevel")
local v13 = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesRuinsProcLevel")
local v14 = Symbol("GladesTreeEntrance")

function EmptyCallback() end

function OnInventoryCommitCallback()
	gGameData:SyncInventoryFromDB("EmptyCallback")
end

local function fn()
	for _, v15 in ipairs(v9) do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
		end
	end
end

local function fn2()
	for _, v15 in ipairs(v9) do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Disable()
		end
	end
end

function ClearSky()
	if __wf_atom_7e8ad928(_T.PreviousTOD) then
		_T.PreviousTOD = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	end

	local previousTOD = _T.PreviousTOD
	module9.ClearWeatherAndDisableCycle(3)
	module9.FadeTimeOfDay(previousTOD, 3)
end

function SetupSky()
	module9.SetTimeOfDay(1)
	module9.ClearWeatherAndDisableCycle(0, Symbol("DefaultMainSky"))
	module9.SetOvercast(1, 0, Symbol("DefaultMainSky"))
	module9.SetRaining(true)
end

local function fn3(p) -- 2 equivalent calls inferred from this helper
	gladeGateForwarder = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(gladeGateForwarder) then
		return
	end

	gladeGateForwarder:FirePort("TriggerPort")
end

local function fn4(mOwner2, p, p2, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v6 = tostring(module4.GetReadableTaskTag(mOwner2, p))

	if not module.IsInOverworld() then
		print("TC Demo: Not in overworld, early out at stage")
		return false
	end

	if gRegion:IsMaster() then
		print("Starting" .. v6)
	elseif p2 then
		print("Starting" .. v6 .. " (client)")
	else
		return false
	end

	if __wf_atom_7e8ad928(v5) then
		v5 = module.WaitForAiDir()
	end

	while not module.HasStreamedLevel("/SF/Levels/Tent") do
		Sleep(0)
	end

	module.TaggedFirePorts(Symbol("VerminiaQuestSetupForwarder"), "TriggerPort")
	fn3(Symbol("GladesGate")) -- inferred equivalent call
	print("Auto encounters disabled for the TC demo")
	module4.TrackQuest(mOwner)
	module6.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaDoorMusicLock"))
	local taggedChildren = module.FindTaggedChildren(
		__wf_atom_0a6a5887:__wf_atom_be0bea4a(),
		Symbol("MusicBolderAction")
	)

	if #taggedChildren > 0 and not __wf_atom_7e8ad928(taggedChildren[1]) then
		taggedChildren[1]:Disable()
	end

	return true
end

function IntroContinue()
	RemoveMixEffect()
	v7 = true
end

local function fn5(p, object)
	v7 = false
	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
		Symbol("DemoPause"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15(p),
		"IntroContinue"
	)

	while not v7 do
		if __wf_atom_7e8ad928(object) or object:__wf_atom_7d4910e4() and not object:__wf_atom_e9546dc6() then
			Sleep(0)
		else
			return
		end
	end

	gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(Symbol("DemoPause"), __wf_atom_8e4fda44:__wf_atom_e7d83c15(p))
end

local function fn6(p, p2)
	local v15 = Symbol("FreedRatGuide")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("RatPrisonCage"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("ClientRatScaler"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if gRegion:IsMaster() then
			local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(p)

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
				local position = __wf_atom_0a6a5887_4:GetPosition()
				local __wf_atom_dc309f8a = __wf_atom_0a6a5887_4:__wf_atom_dc309f8a()

				if not __wf_atom_7e8ad928(p2) then
					local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(p2)

					if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
						__wf_atom_dc309f8a = __wf_atom_fa8d0177(position, __wf_atom_0a6a5887_5:GetPosition())
					end
				end

				local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
					ratAgentType,
					position,
					__wf_atom_dc309f8a,
					EMPTY_SYMBOL,
					0,
					true,
					0,
					0
				)

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					__wf_atom_0a6a5887 = __wf_atom_402b3832:__wf_atom_50a7d83e()
				end
			end
		else
			repeat
				Sleep(0)
				__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)
			until not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(__wf_atom_589cefdb)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Enable()
		end

		__wf_atom_0a6a5887:SetMeshScale(3.5)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			__wf_atom_0a6a5887_3:FirePort("Execute")
		end

		module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner)
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RatWispers"))

	for _, v16 in ipairs(__wf_atom_2226b35c) do
		v16:Enable()
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		local taggedChildren = module.FindTaggedChildren(
			__wf_atom_0a6a5887_2:__wf_atom_be0bea4a(),
			Symbol("FreeRatAction")
		)

		if #taggedChildren > 0 then
			taggedChildren[1]:Disable()
		end
	end
end

function DisableVerminiaDoorLock()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaDoorMusicLock"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local taggedChildren = module.FindTaggedChildren(
			__wf_atom_0a6a5887:__wf_atom_be0bea4a(),
			Symbol("MusicBolderAction")
		)

		if #taggedChildren > 0 and not __wf_atom_7e8ad928(taggedChildren[1]) then
			taggedChildren[1]:Disable()
		end
	end
end

function BeginTCDemoQuest(p)
	if not fn4(mOwner, p, false, true) then
		return
	end

	while __wf_atom_72884638("Script.ScriptImGui") do
		__wf_atom_489de21b("TC Demo 2024")

		if __wf_atom_80afb308("Start Demo") then
			break
		end

		__wf_atom_05a856ad("Press MELEE at the black screen to continue")
		__wf_atom_05a856ad("Press ESC to wake up during the sleeping cinematic")
		__wf_atom_05a856ad("")

		if __wf_atom_80afb308("Cancel") then
			return
		end

		__wf_atom_05a856ad("Ctrl+Alt+L to restart the quest later")
		__wf_atom_48bcafdc()
		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while module.IsInNightFold(__wf_atom_c4f78a8f) do
		Sleep(0)
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("PostLoginCinLoop"), v11)
	gRegion:__wf_atom_c4f78a8f():Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
	SetupSky()
	_T.ProgressionScreenDisabled = true
	local all = gRegion:FindAll(__wf_atom_f806fd7a)

	for _, v15 in ipairs(all) do
		local __wf_atom_4026dfb5 = v15:__wf_atom_4026dfb5()

		if __wf_atom_4026dfb5 ~= 0 and __wf_atom_4026dfb5 ~= 6 then
			v15:__wf_atom_8e6fec76(6)
		end
	end

	module.Fade(true, 0, 1)
	fn5("MELEE")
	print("Finished " .. v6)
	module4.CompleteTaskWithID(mOwner, p)
end

function StartVerminiaQuest(_, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if module4.HasCompletedQuest(v10) and gRegion:IsMaster() then
		return
	end

	if gRegion:IsMaster() then
		module4.StartQuest(Resource(v10))
	end
end

function QuestAreaSetUpTrigger(_, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if module4.QuestIsActive(v10) then
		if gRegion:IsMaster() and not __wf_atom_7e8ad928(notUnlockedSetupForwarder) then
			notUnlockedSetupForwarder:FirePort("TriggerPort")
		end

		__wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(Symbol("ClientSkyUpdate"))))
	elseif
		(module4.HasCompletedQuest(v10) or not module4.QuestIsActive(v10))
		and gRegion:IsMaster()
		and not __wf_atom_7e8ad928(unlockedSetupForwarder)
	then
		unlockedSetupForwarder:FirePort("TriggerPort")
	end
end

function DisableVerminiaStuffPreQuest()
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if module4.HasCompletedQuest(v10) then
		if gRegion:IsMaster() and not __wf_atom_7e8ad928(unlockedSetupForwarder) then
			unlockedSetupForwarder:FirePort("TriggerPort")
		end
	elseif not module4.QuestIsActive(v10) and gRegion:IsMaster() and not __wf_atom_7e8ad928(hideEverythingForwader) then
		hideEverythingForwader:FirePort("TriggerPort")
	end
end

function SparrowCinematic(p)
	if not (fn4(mOwner, p, true) and module.IsInOverworld()) then
		return
	end

	module.PlayCinematicWithTagAndWait(Symbol("SparrowIntroCin"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FinalCosmeticOptionCin"))
	module.WaitForCinematicToFinish(__wf_atom_0a6a5887)

	if gRegion:IsMaster() then
		print("Finished " .. v6)
	end

	print("Finished " .. v6)
	module4.CompleteTaskWithID(mOwner, p)
end

function GotoRuins(p)
	if not fn4(mOwner, p, false, false) then
		return
	end

	module.SetQuestProcLevel(v14, v13)

	if isTcDemoFlow then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_c4f78a8f:__wf_atom_4417a5d4() then
			__wf_atom_c4f78a8f:__wf_atom_d2b2176d():Unequip(0, 2)
		end

		if _T.devSkipCinematics then
			module.Fade(false, 0.5, 1, false)
		else
			local nearestTagged = gRegion:FindNearestTagged(Symbol("PostLoginCinLoop"), v11)
			local nearestTagged2 = gRegion:FindNearestTagged(Symbol("PostLoginCin"), v11)
			nearestTagged:FirePort("StartPlaying")
			fn5("MENU_CANCEL", nearestTagged)
			nearestTagged:Stop()
			module.WaitForCinematicToFinish(nearestTagged2, false)
		end
	end

	if module.IsInOverworld() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v)
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNimrodStageStart"))
		local position = __wf_atom_0a6a5887_2:GetPosition()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v15 = false
		local __wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition())
		fn2()

		if __wf_atom_a5304c35 >= 150 then
			module6.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/VerminiaExploreTheGlades")
			local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaQuestStart"))
			v8 = module4.CreateAreaMarker(__wf_atom_0a6a5887_4, 50, __wf_atom_28d5d4aa, mOwner, p)
			module3.AddQuestDestination(__wf_atom_0a6a5887_4, mOwner, p)
		end

		while not (module.AnyPlayerInTrigger(__wf_atom_0a6a5887) or module.AnyPlayerNearPos(position, 60)) do
			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)
			elseif __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			elseif __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
				__wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNimrodStageStart"))
				Sleep(1)
			elseif __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition()) <= 150 and v15 == false then
				v15 = true
				gRegion:__wf_atom_0a6a5887(Symbol("VerminiaQuestAreaSetUpStep1")):FirePort("TriggerPort")
				v8 = module4.CreateAreaMarker(__wf_atom_0a6a5887_3, 50, __wf_atom_28d5d4aa, mOwner, p)
				module6.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/VerminiaRevealGotoRuins")
				module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
			end

			Sleep(0.1)
		end

		print("Finished " .. v6)
		module4.CompleteTaskWithID(mOwner, p)
	elseif module8.GetCurrentLocation() == tostring(v14) then
		module6.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/VerminiaExploreTheGlades")
		local v15 = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))[1]
		module3.AddSparrowDestination(v15, nil, nil, module3.PRIORITY.EXIT)
	end
end

function ClearTheRuins(p)
	if not fn4(mOwner, p, false, true) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("RatPrisonCage"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Enable()
		__wf_atom_0a6a5887_2:SetVisibility(true)
	end

	module2.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
	module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	fn2()
	__wf_atom_0a6a5887:Enable()

	while __wf_atom_0a6a5887:__wf_atom_4026dfb5() ~= 2 do
		Sleep(0.1)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end
	end

	v5:AddEncounter(clearAreaEncounterType)
	local __wf_atom_c4c644af = v5:__wf_atom_c4c644af(
		__wf_atom_0a6a5887:GetPosition() + Vector(1, 0, 1),
		clearAreaEncounterType,
		__wf_atom_0a6a5887
	)

	if not module2.WaitForEncounterToStart(__wf_atom_c4c644af) then
		return
	end

	print("Encounter started at stage " .. v6)
	local v15 = module2.WaitForEncounterToFinish(__wf_atom_c4c644af)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		print("Exit due to streaming (1), task " .. v6)
		return
	end

	if not v15 then
		print("Encounter abandoned / shut down! " .. v6)
		return
	end

	__wf_atom_0a6a5887:Disable()
	Sleep(1)
	module6.CompleteHudTask(mOwner, nil, p, 3)
	Sleep(4)
	module3.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)
	module6.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/VerminiaOpenRatCage")

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		print("Exit due to streaming (1.5), task " .. v6)
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_0a6a5887_2:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	while true do
		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			print("Exit due to streaming (2), task " .. v6)
			return
		end

		if
			__wf_atom_7e8ad928(__wf_atom_bb3e7833)
			or not __wf_atom_bb3e7833:IsEnabled() and _T.WaitForQuestCineCompletion == true
		then
			break
		else
			Sleep(0)
		end
	end

	module9.SetRaining(true)
	module6.CompleteHudTask(mOwner, nil, p, 3)
	Sleep(3)
	module4.CompleteTaskWithID(mOwner, p)
end

function NimrodBattle(p)
	if not fn4(mOwner, p, false, true) then
		return
	end

	fn6(Symbol("RatGuideStart"), v)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v)
	fn2()
	__wf_atom_0a6a5887:Disable()
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodSpawn"))
	v5:AddEncounter(clearAreaEncounterType)
	local __wf_atom_c4c644af = v5:__wf_atom_c4c644af(__wf_atom_0a6a5887_2:GetPosition(), clearAreaEncounterType)
	module.TaggedFirePorts(Symbol("NimrodLookTrigger"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodOnePoppetStandByOn"), "Enable")

	if not module2.WaitForEncounterToStart(__wf_atom_c4c644af) then
		print("Exit due to streaming (1), task " .. v6)
		return
	end

	print("Encounter started at stage " .. v6)
	module9.SetOvercast(1)
	module9.SetLightning(true, 0.5)
	module9.SetRaining(true)
	local v15 = module2.WaitForEncounterToFinish(__wf_atom_c4c644af)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Exit due to streaming (2), task " .. v6)
		return
	end

	module9.SetLightning(false)

	if not v15 then
		print("Failed " .. v6)
		return
	end

	module.TaggedFirePorts(Symbol("NimrodPhaseOne"), "Disable")
	module.TaggedFirePorts(Symbol("NimrodOnePoppetStandByOn"), "Disable")
	module.TaggedFirePorts(Symbol("NimrodOnePoppetStandByOff"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodOnePoppetStandByOff"), "Execute")
	print("Finished " .. v6)
	module4.CompleteTaskWithID(mOwner, p)
end

function ExploreArea(p)
	if not fn4(mOwner, p, false, true) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	fn2()
	fn6(Symbol("ExploreAreaStart"), Symbol("NimrodSpawnPt2"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodSpawnPt2"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaWispers2"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:Enable()
	end

	v5:AddEncounter(clearAreaEncounterType)
	local __wf_atom_c4c644af = v5:__wf_atom_c4c644af(__wf_atom_0a6a5887_2:GetPosition(), clearAreaEncounterType)
	module.TaggedFirePorts(Symbol("NimrodLookTrigger2"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodPhaseTwo"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodTwoPoppetStandByOn"), "Enable")

	if not module2.WaitForEncounterToStart(__wf_atom_c4c644af) then
		print("Exit due to streaming (1), task " .. v6)
		return
	end

	print("Encounter started at stage " .. v6)
	module.TaggedFirePorts(Symbol("NimrodLookTrigger2"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodPhaseTwo"), "Enable")
	module9.SetOvercast(1)
	module9.SetLightning(true, 0.5)
	module9.SetRaining(true)
	local v15 = module2.WaitForEncounterToFinish(__wf_atom_c4c644af)
	module9.SetLightning(false)

	if not v15 then
		print("Failed " .. v6)
		return
	end

	module.TaggedFirePorts(Symbol("NimrodPhaseTwo"), "Disable")
	module.TaggedFirePorts(Symbol("NimrodTwoPoppetStandByOn"), "Disable")
	module.TaggedFirePorts(Symbol("NimrodTwoPoppetStandByOff"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodTwoPoppetStandByOff"), "Execute")
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(v2)
	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaDoorMusicLock"))
	local taggedChildren = module.FindTaggedChildren(
		__wf_atom_0a6a5887_5:__wf_atom_be0bea4a(),
		Symbol("MusicBolderAction")
	)

	if #taggedChildren > 0 and not __wf_atom_7e8ad928(taggedChildren[1]) then
		taggedChildren[1]:Enable()
	end

	while not module.AnyPlayerInTrigger(__wf_atom_0a6a5887_4) do
		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
			__wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(v2)
		end

		Sleep(0.1)
	end

	print("Finished " .. v6)
	module6.CompleteHudTask(mOwner, nil, p, 2)
	Sleep(2)
	module4.CompleteTaskWithID(mOwner, p)
end

local function fn7(_, object)
	if _T.NimrodSkyCleared then
		return
	end

	if not __wf_atom_7e8ad928(object) and object:IsLocal() then
		local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_5c7adae9(skyPotionType)) then
			__wf_atom_50a7d83e:GiveItem(skyPotionType, false)
		end

		if gGameData:__wf_atom_a4299765() then
			local __wf_atom_6b29f1ed = gGameData:__wf_atom_a4299765():__wf_atom_6b29f1ed()
			local v15 = false

			for _, v16 in ipairs(__wf_atom_6b29f1ed) do
				if v16.mItemType == skyPotionType then
					v15 = true
				end
			end

			if not v15 then
				gGameData:__wf_atom_a6b3ae2b(skyPotionType)
				gGameData:__wf_atom_993aebc4("EmptyCallback")
			end
		end

		gGameRules:CommitInventoryCheckpointToDB(0, 0, 0, "OnInventoryCommitCallback")
	end
end

function ThirdNimrodFight(p)
	module7.RegisterPreventNighfoldUsage(true)
	local v15 = fn4(mOwner, p, false, true)

	if _T.OnPlayerSpawnedCallbacks then
		_T.OnPlayerSpawnedCallbacks[p] = fn7
	end

	fn7(gGameRules, gRegion:__wf_atom_eab484a7())
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)

	if not v15 then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	Sleep(timeToWaitBeforeThunder)
	module.TaggedFirePorts(Symbol("NimrodThunderWarning"), "Enable")
	Sleep(timeToWaitAfterThunderBeforeTransmission)
	module5.PlayGlobalTransmission(transmissionSet, Symbol("PhaseThree"), true)
	module.TaggedFirePorts(Symbol("NimrodCue"), "Enable")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodSpawnPt3"))
	module3.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)
	v5:AddEncounter(clearAreaEncounterType)
	local __wf_atom_c4c644af = v5:__wf_atom_c4c644af(__wf_atom_0a6a5887_2:GetPosition(), clearAreaEncounterType)

	if not module2.WaitForEncounterToStart(__wf_atom_c4c644af) then
		print("Exit due to streaming (1), task " .. v6)
		return
	end

	print("Encounter started at stage " .. v6)

	if not _T.NimrodSkyCleared then
		module9.SetOvercast(1)
		module9.SetLightning(true, 0.5)
		module9.SetRaining(true)
	end

	module.TaggedFirePorts(Symbol("NimrodLookTrigger3"), "Enable")
	module.TaggedFirePorts(Symbol("NimrodPhaseThree"), "Enable")
	local v16 = module2.WaitForEncounterToFinish(__wf_atom_c4c644af)
	module3.RemoveSparrowDestination(__wf_atom_0a6a5887_2)

	if not v16 then
		print("Failed " .. v6)
		return
	end

	module.TaggedFirePorts(Symbol("NimrodPhaseThree"), "Disable")
	module.TaggedFirePorts(Symbol("NimrodCue"), "Disable")
	Sleep(5)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
	end

	module6.CompleteHudTask(mOwner, nil, p, 3)
	module4.CompleteTaskWithID(mOwner, p)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodFakeOutTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:FirePort("Execute")
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodDefeat"))
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	local motionControl = __wf_atom_c4f78a8f:MotionControl()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		__wf_atom_d2b2176d:Unequip(0, 0)
	end

	while
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and not __wf_atom_c4f78a8f:IsKilled()
		and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
	do
		Sleep(0)
	end

	__wf_atom_0a6a5887_4:SetInstigatorAvatar(__wf_atom_c4f78a8f)
	__wf_atom_0a6a5887_4:StartRelative(
		Symbol("Envoy"),
		__wf_atom_c4f78a8f:__wf_atom_a2a18137(),
		motionControl:__wf_atom_d9cb4b97()
	)
	fn()
	module.SetQuestProcLevel(v14, v12)
end

function NimrodDefeatToast()
	if gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	module4.TriggerPlayerProgressionCelebration(__wf_atom_c4f78a8f, {
		Label = "/SF/Language/Objectives/CompletedNimrodEncounter",
		CacheIndex = 1
	})
end

function ThirdNimrodFightEnd(p)
	module7.RegisterPreventNighfoldUsage(false)

	if _T.OnPlayerSpawnedCallbacks then
		_T.OnPlayerSpawnedCallbacks[p] = nil
	end

	if not _T.NimrodSkyCleared then
		ClearSky()
		_T.NimrodSkyCleared = true
	end

	module9.SetWeatherCycleEnabled(true, 1800)
end

function TCDemoAncestorReset(p)
	module.Fade(false, 0.5, 1, true)
	module4.CompleteTaskWithID(mOwner, p)
	__wf_atom_8e4fda44:__wf_atom_bcb70491(Resource("/SF/Commands/CmdAncestor"), "VerminiaAncestor Reset")
end

function AddMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end

function RemoveMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end

function SetGladesSparrowDest()
	module.WaitForLoginSequence()

	if not (__wf_atom_7e8ad928(requiredQuest) or module4.HasCompletedQuest(requiredQuest)) then
		return
	end

	fn3(Symbol("GladesGateOpen")) -- inferred equivalent call
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GladesReturnEntrance"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module3.AddSparrowDestination(
			__wf_atom_0a6a5887,
			nil,
			String("SouthernExit"),
			module3.PRIORITY.CRITICAL,
			nil,
			mOwner
		)
	end
end