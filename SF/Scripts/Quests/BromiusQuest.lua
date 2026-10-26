local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module7 = require("SF.Scripts.Libs.QuestLib")
local module8 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module9 = require("Lotus.Scripts.Libs.AudioLib")
local module10 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module11 = require("SF.Scripts.NightFoldLib")
local module12 = require("SF.Interface.SFUtilities")
local module13 = require("SF.Scripts.Libs.RespawnLib")
local module14 = require("SF.Scripts.Libs.ModifySkyLib")
local v = {
	questStartSpawn = Symbol("BromiusQuest-QuestStartSpawn"),
	floppetMergeSpawn = Symbol("BromiusQuest-FloppetMergeSpawn"),
	clawedTree = Symbol("BromiusQuest-ClawedTree"),
	jug = Symbol("BromiusQuest-JugContextAction"),
	clawedTreeTeleport = Symbol("BromiusQuest-ClawedTreeTeleport")
}
local v2 = Symbol("NeathPortal-D-Council")
local v3 = nil
local v4 = nil
local v5 = Type("/SF/Types/Input/BossIntroForceWalkInputFilter")
local v6 = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest")
local v7 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v8 = Type("/SF/Types/Gameplay/TeleportPlayersHereScriptTrigger")
local v9 = Type("/SF/Types/Gameplay/TeleportPlayersHereInstantlyScriptTrigger")
local v10 = {}
local flag = false
local v11 = nil
local v12 = Symbol("WazardFightState")

local function fn(total, p, p2, p3)
	local v13 = __wf_atom_7e8ad928(p3) and 3 or p3

	if gRegion:IsMaster() then
		local v14 = Symbol("OvercastSky")
		local v15 = Symbol("DefaultMainSky")
		local all = gRegion:FindAll(__wf_atom_4d4372ee)
		local v16 = nil

		for _, v17 in ipairs(all) do
			if v17:__wf_atom_db682341() == v14 and p then
				v16 = v17
			elseif v17:__wf_atom_db682341() == v15 and not p then
				v16 = v17
			else
				v17:Enable(false)
				v17:__wf_atom_e2779837(false)
			end
		end

		if not __wf_atom_7e8ad928(v16) then
			v16:Enable(true)
			v16:__wf_atom_e2779837(true)

			if p2 then
				local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

				if total < __wf_atom_cb3427c9 then
					total += 24
				end

				v16:SetTimeOfDay(__wf_atom_cb3427c9)
				local v17 = 1

				while v17 > 0 and not __wf_atom_7e8ad928(v16) do
					v17 = math.max(0, v17 - __wf_atom_084b3e93() / v13)
					local v18 = __wf_atom_24a82b69(v17)
					v16:SetTimeOfDay((__wf_atom_104bfe98(__wf_atom_cb3427c9, total, 1 - v18)))
					Sleep(0)
				end
			else
				v16:SetTimeOfDay(total)
			end
		end
	end
end

function AllowDynamicCombatInQuestZone(p)
	local v13 = { Symbol("WevetwoodContainerHint"), Symbol("GalvinarCorruptionSpreadZone") }

	for _, v14 in ipairs(v13) do
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v14)

		for _, v15 in ipairs(__wf_atom_2226b35c) do
			module2.SetDynamicCombatAllowed(v15, p)
		end
	end

	module.TaggedFirePorts(Symbol("Neathuns-D-Council"), "Disable")
end

local function fn2(mOwner2, p, p2, p3, p4, p5, p6)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v4 = tostring(module7.GetReadableTaskTag(mOwner2, p))
	local v13 = p6 == nil or p6

	if gRegion:IsMaster() then
		print("Starting" .. v4)
	elseif p2 then
		print("Starting" .. v4 .. " (client)")
	else
		return false
	end

	if v13 and __wf_atom_7e8ad928(v3) then
		v3 = module.WaitForAiDir()
	end

	local isInOverworld = module.IsInOverworld()

	if not (p4 or isInOverworld) then
		print("Early out, this task doesn't run in dungeons")
		return
	end

	if gRegion:IsMaster() and module.IsInOverworld() then
		AllowDynamicCombatInQuestZone(false)
	end

	if not __wf_atom_7e8ad928(p5) then
		fn(p5, false, false, 3)
	end

	flag = false
	module7.TrackQuest(mOwner)
	return true
end

local function fn3(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(p) or not (p and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(object) <= 50) then
		object:Attach(v9, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn4(p, p2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("StreamingDungeonEntranceWp"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		50
	)

	if p then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("UnlockNeathuns"), __wf_atom_0a6a5887:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			nearestTagged:FirePort("TriggerPort")
			print("Unlocked Quest Neathuns")
		end

		module.SetQuestProcLevel(
			Symbol("Neathuns-D-Council"),
			WeakResource("/SF/Levels/Procs/Neathuns/NeathunsBromiusQuest")
		)
		module3.AddQuestDestination(__wf_atom_f738b4af, mOwner, p2)

		if not __wf_atom_7e8ad928(v11) then
			v11:Destroy()
		end

		v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887, 30, __wf_atom_28d5d4aa, mOwner, p2)
	else
		module.TaggedFirePorts(Symbol("LockNeathuns"), "TriggerPort")
		print("Locked Quest Neathuns")
	end
end

function InputHandler_StartDemo()
	_T.StartTCDemo = true
end

function SoundPulseMaterialEmission(object)
	while not __wf_atom_7e8ad928(_T.TreeTalkSoundInstance) and _T.TreeTalkSoundInstance:__wf_atom_946fdac0() >= 0 do
		local __wf_atom_31aab74c = _T.TreeTalkSoundInstance:__wf_atom_31aab74c()
		object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 20 + __wf_atom_31aab74c * 100, 0, 0, 0)
		Sleep(0)
	end

	object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 10, 0, 0, 0)
end

function BromiusQuestStart()
	if module7.QuestIsActive(v6) or module7.HasCompletedQuest(v6) then
		return
	end

	if gRegion:IsMaster() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsKilled() do
			Sleep(0)
		end

		module7.StartQuest(Resource(v6))
	end
end

function FindTheSap(p)
	if not fn2(mOwner, p, false, true, false) then
		return
	end

	fn4(false)

	if flag and _G.EnableDevTeleportToActiveStep then
		fn3(gRegion:__wf_atom_0a6a5887(v.questStartSpawn), true)
	end

	if not module.IsInOverworld() then
		module6.UpdateOrAddHudTask(mOwner, "/SF/Language/Quests/BromiusReturnToMidrath")
		return
	end

	Sleep(2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-FindTheSapSearchAreaWaypoint"))
	v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887, 100, __wf_atom_28d5d4aa, mOwner, p)
	module6.UpdateOrAddHudTask(mOwner, p)
	module.WaitToExitNightfold()
	module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	local v13 = WeakResource("/SF/Types/PickUps/Resources/Organics/Sap/WevetWoodSapResource")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	local __wf_atom_ee725e9c = __wf_atom_d2b2176d:__wf_atom_ee725e9c(v13)
	local v14 = __wf_atom_ee725e9c

	while __wf_atom_ee725e9c == v14 do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			__wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		else
			v14 = __wf_atom_d2b2176d:__wf_atom_ee725e9c(v13)
		end

		Sleep(1)
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	module6.CompleteHudTask(mOwner, nil, p, 3)
	module5.PlayGlobalTransmission(transmissionSet, Symbol("VerminiaWantsSnack"), true)

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

function P1BringSapToVerminia(p)
	if not fn2(mOwner, p, true, true, false) then
		return
	end

	fn4(false)
	module11.SetForceStationReveal(verminiaAncestorWeakRes, true)
	module11.SetForceInteractDisable(verminiaAncestorWeakRes, true)
	module6.UpdateOrAddHudTask(mOwner, p)

	while module.IsStreamingLevel() or not module.HasStreamedLevel("/SF/Levels/Tent") do
		Sleep(0)
	end

	if flag and _G.EnableDevTeleportToActiveStep then
		fn3(gRegion:__wf_atom_0a6a5887(v.questStartSpawn), true)
	end

	if module.IsInOverworld() then
		_T.BromiusVerminiaConvoDone = false
		local v13 = Symbol("VerminiaTalkAction")
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuestStartTrigger"))

		while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
			Sleep(5)
			__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuestStartTrigger"))
		end

		__wf_atom_0a6a5887:Enable()
		module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
		local v14 = nil

		while not _T.BromiusVerminiaConvoDone do
			Sleep(1)

			if module.IsInOverworld() then
				if
					not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
					and not __wf_atom_0a6a5887:__wf_atom_c5ea85f0(gRegion:__wf_atom_eab484a7())
					and (__wf_atom_7e8ad928(v14) or Time() - v14 > 20)
				then
					module7.NotifyIfReadyPlayersWaiting(v6, p)
					v14 = Time()
				end
			else
				module6.UpdateOrAddHudTask(mOwner, "/SF/Language/Quests/BromiusReturnToMidrath")

				if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuestStartTrigger"))
				else
					__wf_atom_0a6a5887:Disable()
				end

				local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v13)

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
					__wf_atom_0a6a5887_2:Enable()
				end

				while not module.IsInOverworld() do
					module7.NotifyIfReadyPlayersWaiting(v6, p, true)
					Sleep(20)
				end

				return
			end
		end

		module6.CompleteHudTask(mOwner, nil, p, 3)
		_T.BromiusVerminiaConvoDone = nil
		module11.SetForceStationReveal(verminiaAncestorWeakRes, false)
		module11.SetForceInteractDisable(verminiaAncestorWeakRes, false)

		if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(p)) then
			module7.SetLocalPlayerReady(v6, p)
		end

		Sleep(1)
		module7.WaitForAllPlayersReady(v6, p)

		if gRegion:IsMaster() then
			if __wf_atom_7e8ad928(v4) then
				print("Finished task")
			else
				print("Finished " .. v4)
			end

			module7.CompleteTaskWithID(mOwner, p)
		end
	else
		module6.UpdateOrAddHudTask(mOwner, "/SF/Language/Quests/BromiusReturnToMidrath")
	end
end

function VerminiaQuestGiverCTX(object, object2)
	object2:__wf_atom_aeb02c14(v7)
	object:__wf_atom_e95c24e1(object2:__wf_atom_a96eb2aa())
	module.Fade(true, 0.5, 1)
	Sleep(1.5)
	module.SetMeleeEnabled(false)
	Sleep(2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusLoginLoopCin"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuestStartTrigger"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:Disable()
		end

		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaTalkAction"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			__wf_atom_0a6a5887_3:Enable()
		end
	else
		__wf_atom_0a6a5887:SetInstigatorAvatar(object2)
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("StranglingVine"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusLoginStartCin"))
		__wf_atom_0a6a5887_2:SetInstigatorAvatar(object2)
		module.Fade(false, 2, 1, false)
		__wf_atom_0a6a5887:FirePort("StartPlaying")
		Sleep(4)
		__wf_atom_0a6a5887:__wf_atom_398939a1()

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			module.SetMeleeEnabled(false)

			while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_0a6a5887_2:__wf_atom_7d4910e4()) do
				Sleep(0)
			end

			Sleep(0)

			if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
				for _, v13 in ipairs(__wf_atom_2226b35c) do
					v13:__wf_atom_a763aa1a(0)
				end
			end

			while
				not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)
				and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4()
				and not (__wf_atom_0a6a5887_2:__wf_atom_e9546dc6() or __wf_atom_0a6a5887_2:__wf_atom_a5549761(true) < 0.2)
			do
				Sleep(0)
			end

			module.SetMeleeEnabled(true)
		end

		module.Fade(true, 0, 1)
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v13 in pairs(__wf_atom_ef7900cf) do
			if not v13:__wf_atom_4417a5d4() then
				v13:__wf_atom_a7ee9662(true, true)
			end
		end

		Sleep(3.5)
		module.Fade(false, 0.4, 1, false)
		module.PlayCinematicWithTagAndWait(Symbol("BromiusHandoff"), nil, object2)
		module.TaggedFirePorts(Symbol("BromiusQuest-VerminiaConvo"), "Execute")
	end
end

function VerminiaVanishes(_, object)
	object:__wf_atom_a0f85752(false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaLeaveTarget"))
	module8.DissolveOut(object, __wf_atom_0a6a5887:GetPosition())
end

function SwapFloppet(_, object)
	if gRegion:IsMaster() then
		EnableFloppet()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local position = object:GetPosition()
		local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
		_T.OverrideSparrow = {
			pos = position,
			rot = __wf_atom_dc309f8a,
			agent = floppetAgentTypeCin
		}
		print("Spawn override: " .. floppetAgentTypeCin:__wf_atom_5b41f63b())
		module3.SpawnSparrow(__wf_atom_c4f78a8f)
		_T.OverrideSparrow = nil
		module3.SetSparrowMode(nil)
	end
end

function VerminiaFloppetApproach(_, object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNpcFloppetMerge"))
	local groundPos = module4.GetGroundPos(__wf_atom_0a6a5887:GetPosition())
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaPoppetFullCin"))
	local __wf_atom_d5fda8be = __wf_atom_c4f78a8f:__wf_atom_d5fda8be(groundPos)
	Sleep(0.5)
	local v13

	if gRegion:IsMaster() then
		v13 = gRegion:CreateEntity(sparrowDecoType, __wf_atom_0a6a5887:GetPosition(), Rotation())
		__wf_atom_0a6a5887_2:SetInstigatorAvatar(object)
		local position = __wf_atom_0a6a5887:GetPosition()
		local v14 = __wf_atom_fa8d0177(position, object:GetPosition())
		local position2 = __wf_atom_0a6a5887:GetPosition()
		__wf_atom_0a6a5887_2:__wf_atom_8f4c0eeb(Symbol("Verminia"), position2, v14, 0.5)
		__wf_atom_0a6a5887_2:FirePort("StartPlayingRelative")
	end

	if __wf_atom_c4f78a8f == object then
		module.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)

		if gRegion:IsMaster() then
			gRegion:__wf_atom_dd1e4d10(v13)
		end
	elseif __wf_atom_d5fda8be >= 8 then
		module.Fade(true, 0.2, -1, true)
		Sleep(1)
		module.Fade(false, 0.5, -1, false)
		module.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)

		if gRegion:IsMaster() then
			gRegion:__wf_atom_dd1e4d10(v13)
		end

		module.Fade(true, 0.2, -1, true)
		Sleep(1)
		module.Fade(false, 0.5, -1, false)
	end
end

function P1FloppetMerge(p)
	if not fn2(mOwner, p, false, true, false) then
		return
	end

	fn4(false)
	module.TaggedFirePorts(Symbol("P1FloppetMergeSetup"), "TriggerPort")
	module.WaitToExitNightfold()

	if flag and _G.EnableDevTeleportToActiveStep then
		fn3(gRegion:__wf_atom_0a6a5887(v.floppetMergeSpawn), true)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNpcFloppetMerge"))
	local groundPos = module4.GetGroundPos(__wf_atom_0a6a5887:GetPosition())
	module6.UpdateOrAddHudTask(mOwner, p)
	module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887, 70, __wf_atom_28d5d4aa, mOwner, p)
	local v13 = false

	while v13 == false do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v14 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(groundPos) or not module.IsInOverworld() then
				return
			end

			v13 = not v14:IsKilled() and v14:__wf_atom_d5fda8be(groundPos) <= 10 or v13
			Sleep(1)
		end
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaPoppetFullCin"))

	while
		not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)
		and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4()
		and not __wf_atom_0a6a5887_2:__wf_atom_e9546dc6()
	do
		Sleep(0)
	end

	module3.RemoveSparrowDestination(__wf_atom_0a6a5887, "BromiusQuest")

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	module6.CompleteHudTask(mOwner, nil, p, 3)

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

function P2ToWevetWood(p)
	if not fn2(mOwner, p, false, true, false) then
		return
	end

	fn4(false)
	module.TaggedFirePorts(Symbol("P2ToWevetwoodSetup"), "TriggerPort")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusSapPickupToBeHiddenDuringToWevetwood"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Destroy()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WevetwoodBrokenTree"))
	__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(brokenTreeAnimStanding, false, true)

	if flag then
		EnableFloppet()

		if _G.EnableDevTeleportToActiveStep then
			fn3(gRegion:__wf_atom_0a6a5887(v.floppetMergeSpawn), true)
		end
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusWevetSparrowPath"))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(v.clawedTree)
	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("ClawedTreeDialogueTrigger"))
	local v13 = module3.AddQuestDestination(__wf_atom_0a6a5887_4, mOwner, p)
	module3.SetupWaypointPath(v13, __wf_atom_0a6a5887_3, false)
	v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887_4, 100, __wf_atom_28d5d4aa, mOwner, p)
	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusMemory"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
		__wf_atom_0a6a5887_6:PrefetchStreaming()
	end

	local __wf_atom_0a6a5887_7 = gRegion:__wf_atom_0a6a5887(Symbol("BromusQuest-P2Ambush"))
	__wf_atom_0a6a5887_7:Enable()

	if not __wf_atom_7e8ad928(sproutEncounterHintTypes[1]) then
		local entity = gRegion:CreateEntity(
			sproutEncounterHintTypes[1],
			__wf_atom_0a6a5887_7:GetPosition(),
			__wf_atom_80368bb1
		)
		v3:__wf_atom_ccbb5582(entity)
	end

	Sleep(3)
	module6.UpdateOrAddHudTask(mOwner, p)

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) and __wf_atom_0a6a5887_5:IsEnabled() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	_T.TreeTalkSoundInstance = gRegion:PlaySound(
		elmThreeSound,
		__wf_atom_0a6a5887_2:GetPosition() + Vector(0, 6, 0),
		false,
		4,
		nil,
		nil,
		nil,
		true
	)
	__wf_atom_0a6a5887_2:__wf_atom_8a035cd5(Symbol("SoundPulseMaterialEmission"), false)
	__wf_atom_0a6a5887_4:FirePort("Enable")

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) and __wf_atom_0a6a5887_4:IsEnabled() do
		Sleep(0)
	end

	Sleep(1)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	module6.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	fn(12, false, false, 3)
	module14.ClearWeatherAndDisableCycle()
	module.PlayCinematicWithTagAndWait(Symbol("BromiusMemory"), false, nil, 0.5)
	fn(__wf_atom_cb3427c9, false, false, 3)
	module14.SetWeatherCycleEnabled(true)
	fn3(gRegion:__wf_atom_0a6a5887(v.clawedTreeTeleport), false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local sparrowForPlayer = module3.GetSparrowForPlayer(__wf_atom_c4f78a8f)

	if not __wf_atom_7e8ad928(sparrowForPlayer) then
		sparrowForPlayer:Destroy()
	end

	Sleep(2)
	module.TaggedFirePorts(Symbol("BromiusTreeFall"), "Execute")
	_T.TreeTalkSoundInstance = gRegion:PlaySound(
		brokenTreeSound,
		__wf_atom_0a6a5887_2:GetPosition() + Vector(0, 6, 0),
		false
	)

	while not __wf_atom_7e8ad928(_T.TreeTalkSoundInstance) do
		Sleep(0)
	end

	Sleep(1)
	_T.BromiusTreeFell = true

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

function MarkMapWithMusicPuzzleHints()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-TreeTalkPuzzle"))
	module7.DestroyAreaMarker(__wf_atom_0a6a5887)

	for i, remainingTreeTalkTrigger in ipairs(_T.RemainingTreeTalkTriggers) do
		module7.CreateAreaMarker(remainingTreeTalkTrigger, 60, __wf_atom_28d5d4aa)
		module3.AddSparrowDestination(
			remainingTreeTalkTrigger,
			_T.TreePuzzleTask.owner,
			"BromiusTree" .. i,
			module3.PRIORITY.QUEST + 1,
			Range(15, 3.4028234663852886e38),
			_T.TreePuzzleTask.owner,
			_T.TreePuzzleTask.taskId
		)
	end

	_T.TreePuzzleTask = nil
end

local function fn5(p) -- 4 equivalent calls inferred from this helper
	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("BromiusNoteFound" .. p))

	if not __wf_atom_7e8ad928(__wf_atom_d163c8e5) and __wf_atom_d163c8e5 ~= 0 then
		_T.MusicHintNotesDiscovered[p] = true
	end
end

function P2TreePuzzle(taskId)
	if not fn2(mOwner, taskId, true, true, false) then
		return
	end

	_T.TreePuzzleTask = { owner = mOwner, taskId = taskId }
	fn4(false)

	if __wf_atom_7e8ad928(_T.MusicHintNotesDiscovered) then
		_T.MusicHintNotesDiscovered = {}
		_T.MusicHintMidi = bromiusSong
	end

	if gRegion:IsMaster() then
		module.TaggedFirePorts(Symbol("P2TreePuzzleSetup"), "TriggerPort")
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v.clawedTreeTeleport)
		local __wf_atom_0a6a5887s = {}

		if flag then
			EnableFloppet()

			if _G.EnableDevTeleportToActiveStep then
				fn3(__wf_atom_0a6a5887, true)
			end
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-TreeTalkPuzzle"))

		for i = 3, 1, -1 do
			local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("TreeTalkTrigger" .. tostring(i)))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
				table.insert(__wf_atom_0a6a5887s, __wf_atom_0a6a5887_3)
			end
		end

		if #__wf_atom_0a6a5887s == 0 then
			return
		end

		local sortByDistance = module.SortByDistance(__wf_atom_0a6a5887s, __wf_atom_0a6a5887_2:GetPosition())
		local sortByDistance2 = module.SortByDistance(sortByDistance, sortByDistance[1]:GetPosition())
		_T.RemainingTreeTalkTriggers = sortByDistance2
		_T.MusicHintNotesDiscovered[1] = true
		gGameRules:SetNetPersistentVar(Symbol("BromiusNoteFound1"), 1)
		module9.EnableTaggedSequencers(Symbol("TreePuzzleHint"), true)

		for i, v13 in ipairs(sortByDistance2) do
			if __wf_atom_7e8ad928(sproutEncounterHintTypes[i]) then
				continue
			end

			local entity = gRegion:CreateEntity(sproutEncounterHintTypes[i], v13:GetPosition(), __wf_atom_80368bb1)
			v3:__wf_atom_ccbb5582(entity)

			if i == 2 then
				entity:Disable()
			end
		end

		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-ClawedTreeTeleport"))
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			Symbol("BromiusTalkingTreesDeco"),
			__wf_atom_0a6a5887_3:GetPosition(),
			0,
			130
		)

		for _, v13 in ipairs(__wf_atom_439c0d29) do
			v13:Attach(soulModeFxType, EMPTY_SYMBOL)
		end

		if not __wf_atom_7e8ad928(v11) then
			v11:Destroy()
		end

		v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887_2, 100, __wf_atom_28d5d4aa, mOwner, taskId)
		module3.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, taskId)
		Sleep(3)
		module6.UpdateOrAddHudTask(mOwner, taskId)
		_T.TreePuzzleComplete = nil
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-DissolveWevetwoodBarrier"))

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) do
			Sleep(0)

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or not module.IsInOverworld() then
				return
			end
		end

		Sleep(1)
		_T.BromiusWevetwoodBarrierGone = true

		for i = 1, 4 do
			gGameRules:__wf_atom_0ab0a47f(Symbol("BromiusNoteFound" .. i))
		end

		if __wf_atom_7e8ad928(v4) then
			print("Finished task")
		else
			print("Finished " .. v4)
		end

		module7.CompleteTaskWithID(mOwner, taskId)
	else
		fn5(1) -- inferred equivalent call
		fn5(2) -- inferred equivalent call
		fn5(3) -- inferred equivalent call
		fn5(4) -- inferred equivalent call
	end
end

function P2Council(p)
	if not fn2(mOwner, p, false, true, false) then
		return
	end

	if flag and _G.EnableDevTeleportToActiveStep then
		fn3(gRegion:__wf_atom_0a6a5887(Symbol("TeleportPostJugCin")), true)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SapDrinkMemory"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:PrefetchStreaming()
	end

	fn4(false)
	module.TaggedFirePorts(Symbol("WevetwoodBarrierFinalState"), "TriggerPort")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v.jug)
	module3.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887_2, 50, __wf_atom_28d5d4aa, mOwner, p)
	module6.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("QuestSproutEncounter"))
	__wf_atom_0a6a5887_3:Enable()

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) and __wf_atom_0a6a5887_3:__wf_atom_4026dfb5() ~= 4 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("BromiusJug"), __wf_atom_0a6a5887_2:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:Attach(interactProjectorType, EMPTY_SYMBOL)
	end

	__wf_atom_0a6a5887_2:Enable()
	module3.SpawnSparrow()

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:IsEnabled() do
		Sleep(0)
	end

	Sleep(1.75)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local sparrowForPlayer = module3.GetSparrowForPlayer(__wf_atom_c4f78a8f)

	if not __wf_atom_7e8ad928(sparrowForPlayer) then
		sparrowForPlayer:Destroy()
	end

	module6.CompleteHudTask(mOwner, nil, p)

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	fn(23, false, false, 3)
	module14.ClearWeatherAndDisableCycle()
	module.PlayCinematicWithTagAndWait(Symbol("SapDrinkMemory"), false, nil, 0.5)
	module14.SetWeatherCycleEnabled(true)
	fn3(gRegion:__wf_atom_0a6a5887(Symbol("TeleportPostJugCin")), false)
	fn(__wf_atom_cb3427c9, false, false, 3)
	module9.EnableTaggedSoundSysVolumes(Symbol("InLevelCorruptedMusic"), false)

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

local v13 = Symbol("BromiusKnightFightB")
local v14 = Symbol("WazardMendicantEncounter")
local v15 = Symbol("EncounterCallback")

local function fn6(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 2 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local sparrowForPlayer = module3.GetSparrowForPlayer(__wf_atom_c4f78a8f)

		if not __wf_atom_7e8ad928(sparrowForPlayer) then
			sparrowForPlayer:Destroy()
		end

		module6.UpdateOrAddHudTask(mOwner, "SubTask", "/SF/Language/Quests/DefeatMendicantKnights")
	elseif __wf_atom_4026dfb5 == 4 then
		module6.CompleteHudTask(mOwner, nil, "SubTask", 3)
		module3.RemoveSparrowDestination(object)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusKnightFightBMain"))

		if __wf_atom_0a6a5887:IsEnabled() then
			module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner)
		else
			_T.StartWazzardBossStage = true
		end
	end
end

local function fn7(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 2 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local sparrowForPlayer = module3.GetSparrowForPlayer(__wf_atom_c4f78a8f)

		if not __wf_atom_7e8ad928(sparrowForPlayer) then
			sparrowForPlayer:Destroy()
		end

		module6.UpdateOrAddHudTask(mOwner, "SubTask", "/SF/Language/Quests/DefeatMendicantKnights")
	elseif __wf_atom_4026dfb5 == 4 then
		module6.CompleteHudTask(mOwner, nil, "SubTask", 3)
		module3.RemoveSparrowDestination(object)
		_T.StartWazzardBossStage = true
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WazardEntranceVO"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
		end
	end
end

function P3WazardRetrieveSeed(p)
	if not fn2(mOwner, p, false) then
		return
	end

	fn4(false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WazardMedicantBossSpawn"))
	module13.LockRespawnShrine(__wf_atom_0a6a5887, Symbol("WazardShrine"))

	if flag then
		module.TaggedFirePorts(Symbol("WevetwoodBarrierFinalState"), "TriggerPort")

		if _G.EnableDevTeleportToActiveStep then
			fn3(gRegion:__wf_atom_0a6a5887(Symbol("TeleportPostJugCin")), true)
		end
	end

	module.TaggedFirePorts(Symbol("P3WazardRetrieveSeedSetup"), "TriggerPort")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaWazardVO"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaWazardFirstSpawn"))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WazzardSparrowPath1"))
	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("WazzardSparrowPath2"))
	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(v14)
	local midpoint = (__wf_atom_0a6a5887_3:GetPosition() + __wf_atom_0a6a5887_6:GetPosition()) / 2
	v11 = module7.CreateAreaMarkerAtPos(
		midpoint,
		__wf_atom_0a6a5887_3:__wf_atom_a5304c35(midpoint) + 20,
		__wf_atom_28d5d4aa,
		mOwner,
		p
	)
	local v16 = module3.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, p)
	module3.SetupWaypointPath(v16, __wf_atom_0a6a5887_4, false)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("BromiusKnightFightA"))
	local __wf_atom_0a6a5887_7 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusKnightFightAMain"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol(v13))
	local __wf_atom_0a6a5887_8 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusKnightFightBMain"))

	for _, v17 in pairs(__wf_atom_2226b35c) do
		v17:__wf_atom_7dd025d4(fn6, v15)
	end

	for _, v17 in pairs(__wf_atom_2226b35c2) do
		v17:__wf_atom_7dd025d4(fn7, v15)
	end

	__wf_atom_0a6a5887_7:__wf_atom_7dd025d4(fn6, v15)
	__wf_atom_0a6a5887_8:__wf_atom_7dd025d4(fn7, v15)
	module.TaggedFirePorts(Symbol("VerminiaMendicantVO"), "Enable")
	Sleep(3)
	module5.WaitForTransmissions(true)
	module6.UpdateOrAddHudTask(mOwner, p)
	local v17 = false
	local v18 = false

	while not _T.StartWazzardBossStage do
		if not module.IsInOverworld() then
			print("P3WazardRetrieveSeed - Bail, player left overworld")
			return
		end

		if not (v17 or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_0a6a5887_2:IsEnabled()) then
			local v19 = module3.AddQuestDestination(__wf_atom_0a6a5887_7, mOwner, p)
			module3.SetupWaypointPath(v19, __wf_atom_0a6a5887_5, true)
			v17 = true
		end

		local v19 = false

		for _, v20 in ipairs(__wf_atom_2226b35c) do
			if __wf_atom_7e8ad928(v20) then
				continue
			end

			local __wf_atom_4026dfb5 = v20:__wf_atom_4026dfb5()

			if __wf_atom_4026dfb5 == 1 or __wf_atom_4026dfb5 == 2 then
				v19 = true
			end
		end

		for _, v20 in ipairs(__wf_atom_2226b35c2) do
			if __wf_atom_7e8ad928(v20) then
				continue
			end

			local __wf_atom_4026dfb5 = v20:__wf_atom_4026dfb5()

			if __wf_atom_4026dfb5 == 1 or __wf_atom_4026dfb5 == 2 then
				v19 = true
			end
		end

		if v18 and not v19 then
			Sleep(3)
			module6.UpdateOrAddHudTask(mOwner, p)
			v18 = false
		elseif not v18 and v19 then
			module6.RemoveHudTask(mOwner, nil, p)
			v18 = true
		end

		Sleep(0.2)
	end

	_T.StartWazzardBossStage = nil

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

function WazzardSunset()
	module5.PlayGlobalTransmission(transmissionSet, Symbol("Knights-Defeated"), false)
	Sleep(2)
	module9.PlaySound(skyChangeSound)
	fn(4, false, true, 5)
	module.TaggedFirePorts(Symbol("BromiusKnightFightB"), "Enable")
	module.TaggedFirePorts(Symbol("BromiusKnightFightBMain"), "Enable")
end

local function fn8(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 2 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local sparrowForPlayer = module3.GetSparrowForPlayer(__wf_atom_c4f78a8f)

		if not __wf_atom_7e8ad928(sparrowForPlayer) then
			sparrowForPlayer:Destroy()
		end

		gGameRules:SetNetPersistentVar(v12, 1)
	elseif __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 3 then
		_T.WazzardDefeated = true
		object:Disable()
		gGameRules:__wf_atom_0ab0a47f(v12)
	end
end

function P3WazardFight(p)
	if not fn2(mOwner, p, true, true, false) then
		return
	end

	if gRegion:IsMaster() then
		fn4(false)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WazardMedicantBossSpawn"))
		module13.LockRespawnShrine(__wf_atom_0a6a5887, Symbol("WazardShrine"))
		module.TaggedFirePorts(Symbol("P3WazarFightSetup"), "TriggerPort")
		module.TaggedFirePorts(Symbol("BromiusKnightFightA"), "Disable")
		module.TaggedFirePorts(Symbol("BromiusKnightFightB"), "Disable")
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaWazardSecondSpawn"))

		if flag and _G.EnableDevTeleportToActiveStep then
			fn3(__wf_atom_0a6a5887_2, true)
		end

		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(v14)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			print("Early out, combat hint not found for wazard")
			return
		end

		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WazzardSparrowPath3"))
		__wf_atom_0a6a5887_3:Enable()
		__wf_atom_0a6a5887_3:__wf_atom_7dd025d4(fn8, v15)

		if not __wf_atom_7e8ad928(v11) then
			v11:Destroy()
		end

		local v16 = module3.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, p, Range(5, 3.4028234663852886e38))
		module3.SetupWaypointPath(v16, __wf_atom_0a6a5887_4, false)
		module6.UpdateOrAddHudTask(mOwner, p)
		v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887_3, 50, __wf_atom_28d5d4aa, mOwner, p)
		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("WazzardDeathTarget"))
		local v17 = false
		local v18 = false

		while not _T.WazzardDefeated do
			if _T.WazardTreeAbilityActivated and not v17 then
				module5.PlayGlobalTransmission(transmissionSet, Symbol("WazardFightTree"))
				v17 = true
			end

			if not v18 and _T.WazzardPreDeath then
				module3.AddQuestDestination(__wf_atom_0a6a5887_5, mOwner, p, Range(5, 3.4028234663852886e38))
				v18 = true
			end

			Sleep(0)
		end

		local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNpcNeathuns"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
			__wf_atom_0a6a5887_6:SetVisibility(true, true)
		end

		local __wf_atom_0a6a5887_7 = gRegion:__wf_atom_0a6a5887(Symbol("GetSeedCinematic"))

		while not _T.SeedRecovered or __wf_atom_0a6a5887_7:__wf_atom_7d4910e4() do
			Sleep(0.1)
		end

		module13.UnlockRespawnShrine(Symbol("WazardShrine"))
		module6.CompleteHudTask(mOwner, nil, p, 3)
		Sleep(3)

		if not __wf_atom_7e8ad928(v11) then
			v11:Destroy()
		end

		if __wf_atom_7e8ad928(v4) then
			print("Finished task")
		else
			print("Finished " .. v4)
		end

		module7.CompleteTaskWithID(mOwner, p)
	else
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v12, 0)

		while __wf_atom_d163c8e5 == 0 do
			Sleep(0)
			__wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v12, 0)
		end

		module13.ActivateBlightZone(nil, true, true, false, nil)

		while __wf_atom_d163c8e5 == 1 do
			module13.UpdateBlightZone()
			Sleep(0)
			__wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v12, 2)
		end

		module13.DeactivateBlightZone(true)
	end
end

function OnAgentDestroyed(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SproutFolkSpawner"))
	__wf_atom_0a6a5887:ReturnAgentsToIdle()
	local v16 = Symbol("Flee")
	local __wf_atom_cfb1f23d = __wf_atom_0a6a5887:__wf_atom_cfb1f23d()

	for _, v17 in pairs(__wf_atom_cfb1f23d) do
		if __wf_atom_7e8ad928(v17) or v17:IsKilled() then
			continue
		end

		local __wf_atom_30e3d82b = v17:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v16, __wf_atom_0a6a5887)
		end
	end

	module3.RemoveSparrowDestination(p)
end

function P4IntoNeathens(currentTaskID)
	_T.CurrentTaskID = currentTaskID
	gGameRules:__wf_atom_3033c325(false)

	if not fn2(mOwner, currentTaskID, false, true, true, nil, false) then
		return
	end

	module9.EnableTaggedSoundSysVolumes(Symbol("InLevelCorruptedMusic"), true)
	_T.DrunkBias = 0

	if module.IsInOverworld() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("NeathunsSparrowWP2"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			module3.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, currentTaskID)
		end

		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNpcNeathuns"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			__wf_atom_0a6a5887_3:SetVisibility(true, true)
		end

		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaIntoNeathunsVO"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
			__wf_atom_0a6a5887_4:FirePort("Enable")
		end

		if flag and _G.EnableDevTeleportToActiveStep then
			fn3(__wf_atom_0a6a5887_4, true)
		end

		fn4(true, currentTaskID)
		Sleep(5)
		module5.WaitForTransmissions()
		module6.UpdateOrAddHudTask(mOwner, currentTaskID)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, currentTaskID)
		end
	elseif module10.GetCurrentLocation() == tostring(v2) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SynodCine"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("SynodVisionTrigger"))
		module.TaggedFirePorts(Symbol("BromiusVerminiaVO"), "Enable")
		module.TaggedFirePorts(Symbol("CorruptedHeadsVO"), "Enable")
		module.TaggedFirePorts(Symbol("BromiusTrigger"), "Enable")
		module.TaggedFirePorts(Symbol("BromiusPortForwarder"), "TriggerPort")
		module.TaggedFirePorts(Symbol("CorridorVo"), "Enable")
		module.TaggedFirePorts(Symbol("CoughWalkTrigger"), "Enable")
		module5.PlayGlobalTransmission(transmissionSet, Symbol("BromiusRoar"))
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("SteelCorridor2"))
		module3.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, currentTaskID)
		module6.UpdateOrAddHudTask(mOwner, currentTaskID)
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("BigSproutSpawner"))
		module3.AddSparrowDestination(
			__wf_atom_0a6a5887_4,
			mOwner,
			nil,
			module3.PRIORITY.QUEST,
			nil,
			mOwner,
			currentTaskID
		)
		__wf_atom_55142dd4(__wf_atom_0a6a5887_4, "OnAgentDestroyed")

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:IsEnabled() do
				Sleep(0)
			end

			_T.DrunkBias = 0
			_T.ApplyDrunk = false
			Sleep(1)
		else
			while
				__wf_atom_0a6a5887_2:IsEnabled()
				or not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4() or __wf_atom_0a6a5887:__wf_atom_e9546dc6())
			do
				Sleep(0)

				if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
					return
				end
			end

			_T.DrunkBias = 0
			_T.ApplyDrunk = false

			while
				not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
				and __wf_atom_0a6a5887:__wf_atom_7d4910e4()
				and not __wf_atom_0a6a5887:__wf_atom_e9546dc6()
			do
				Sleep(0)
			end

			module.Fade(true, 0, 1, false)
			Sleep(1.7)
		end

		while not (__wf_atom_7e8ad928(v6) or module7.AllPlayersReady(v6, currentTaskID)) do
			Sleep(1)
		end

		_T.CurrentTaskID = nil
		module.TaggedFirePorts(Symbol("SynodToBromius"), "TriggerPort")

		if __wf_atom_7e8ad928(v4) then
			print("Finished task")
		else
			print("Finished " .. v4)
		end

		module7.CompleteTaskWithID(mOwner, currentTaskID)
	end
end

function ToHallwayCinTeardown()
	if __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
		return
	end

	while _T.IsolatePlayers do
		HideOtherAvatars()
		Sleep(0)
	end
end

function SynodCinTeardown()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)

	if not __wf_atom_7e8ad928(v5) then
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(v5)
	end

	ShowOtherAvatars()
	module.Fade(true, 0)

	if __wf_atom_7e8ad928(v6) or not _T.CurrentTaskID then
		return
	end

	module7.SetLocalPlayerReady(v6, _T.CurrentTaskID)
end

function RemovePlayerEffects(_, _)
	while _T.DrunkBias > 0 do
		_T.DrunkBias = _T.DrunkBias - 0.1
		Sleep(0)
	end

	_T.ApplyDrunk = false
end

function StartBromiusFight()
	module.Fade(false, 1, 1, false)
	module.TaggedFirePorts(Symbol("SynodToBromius"), "TriggerPort")
end

function P5BromiusFight(p)
	gGameRules:__wf_atom_3033c325(true)

	if not fn2(mOwner, p, false, true, true, nil, false) then
		return
	end

	module6.UpdateOrAddHudTask(mOwner, p)
	print("Bromis Quest: Stage 6 Defeat Bromius")

	if module.IsInOverworld() then
		if flag and _G.EnableDevTeleportToActiveStep then
			fn3(gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-Neathuns")), true)
		end

		fn4(true, p)
	elseif module10.GetCurrentLocation() == tostring(v2) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusArenaEntrance"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for _, v16 in ipairs(__wf_atom_ef7900cf) do
				if not (v16:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > 40) then
					continue
				end

				gRegion:CreateEntity(v8, __wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a()):FirePort("Execute")
				break
			end

			Sleep(2)
			module.TaggedFirePorts(Symbol("BromiusFightController"), "Execute")
		end
	end

	local v16 = nil
	local v17 = false
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic"))
	local v18

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v18 = __wf_atom_0a6a5887:__wf_atom_e800787c()
	end

	while __wf_atom_7e8ad928(_T.BromiusFightCompleted) or not _T.BromiusFightCompleted do
		if __wf_atom_7e8ad928(v16) then
			v16 = gRegion:__wf_atom_c4f78a8f()
		elseif v18 and (v18 == v16:__wf_atom_e800787c()) ~= v17 then
			v17 = not v17

			if not v17 then
				local v19 = 3.4028234663852886e38
				local shrine = nil

				for _, v20 in ipairs(_T.activeShrineIndex) do
					if __wf_atom_7e8ad928(v20.shrine) then
						continue
					end

					local __wf_atom_9af7625d = v16:__wf_atom_9af7625d(v20.shrine)

					if not (__wf_atom_9af7625d < v19) then
						continue
					end

					shrine = v20.shrine
					v19 = __wf_atom_9af7625d
				end

				if not __wf_atom_7e8ad928(shrine) then
					module3.AddQuestDestination(shrine, mOwner, p)
				end
			end
		end

		if v17 then
			if __wf_atom_7e8ad928(_T.PreventingNightfold) then
				_T.needsBarRestored = true
			end
		elseif
			__wf_atom_7e8ad928(_T.mBromiusAvatar)
			and not __wf_atom_7e8ad928(_T.PreventingNightfold)
			and _T.PreventingNightfold
		then
			_T.PreventingNightfold = nil
			module11.ClearPreventNighfoldUsage()

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(nil)
			end
		end

		Sleep(1)
	end

	if __wf_atom_7e8ad928(v4) then
		print("Finished task")
	else
		print("Finished " .. v4)
	end

	module7.CompleteTaskWithID(mOwner, p)
end

local function fn9(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:PickUpItem(
		gRegion:CreateEntity(acornsPickUpType, object:GetPosition(), __wf_atom_80368bb1),
		true,
		true
	)
	__wf_atom_d2b2176d:__wf_atom_b9375444(false)
end

function AttenFOV(object)
	local cameraControl = object:CameraControl()
	module.AttunateFovOverTime(cameraControl, fovIn, fovAtten)
end

local function fn10()
	module.Fade(true, 0)

	while Game.__wf_atom_2b221245() or gRegion:__wf_atom_83b2f434() do
		Sleep(0)
	end

	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PlayerSPTeleportLoc"))

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:Teleport(
				__wf_atom_2226b35c[i]:GetPosition(),
				__wf_atom_2226b35c[i]:__wf_atom_dc309f8a()
			)
			__wf_atom_ef7900cf[i]:__wf_atom_f0f9fb38(__wf_atom_2226b35c[i]:__wf_atom_dc309f8a())
		end

		Sleep(2)

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:__wf_atom_e25a34ac(true)
			__wf_atom_ef7900cf[i]:__wf_atom_921c1a5f(nightfoldFallupAnim, false, 3, 1, false)
		end

		for i = 1, #__wf_atom_ef7900cf do
			if not __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				fn9(__wf_atom_ef7900cf[i])
			end
		end

		module.Fade(false)
		Sleep(1)

		for i = 1, #__wf_atom_ef7900cf do
			if not __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				__wf_atom_ef7900cf[i]:__wf_atom_8a035cd5(Symbol("AttenFOV"), false)
			end
		end
	else
		module.Fade(false)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusWater"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true)
	end

	module9.EnableTaggedSequencers(Symbol("BromiusQuestWater"), true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(blockMovementInputFilter)
	end
end

function P6NightfoldCin(p)
	if not fn2(mOwner, p, true) then
		return
	end

	module12.BlockFastTravel(true)
	gGameRules:HideGameSession(true)
	fn(19, false, false, 3)
	module14.ClearWeatherAndDisableCycle()
	fn10()
	fn4(false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SaveBromiusCin"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("TreeGrowthCine"))
	module6.UpdateOrAddHudTask(mOwner, p)

	while not _T.BromiusSoulSongFinished do
		Sleep(0)
	end

	if gRegion:IsMaster() then
		if not __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			__wf_atom_0a6a5887:FirePort("StartPlaying")
		end

		if not __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() then
			__wf_atom_0a6a5887_2:FirePort("StartPlaying")
		end
	end

	module12.BlockFastTravel(false)
end

local function fn11()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AcornSpawnRef"))
	local v16 = {}

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local v17 = 360 / acornsSpawnTotal

		for i = 1, acornsSpawnTotal do
			local v18 = i * v17
			local v19 = acornSpawnRadius.minValue + math.random() * (acornSpawnRadius.maxValue - acornSpawnRadius.minValue)
			local v20 = __wf_atom_0a6a5887:GetPosition() + __wf_atom_9341614d(Vector(v19, 0, 0), Rotation(v18, 0, 0))
			table.insert(v16, i, (module4.GetGroundPos(v20)))
		end

		for k, v18 in v16 do
			local entity = gRegion:CreateEntity(acornsType, v18, __wf_atom_80368bb1)
			table.insert(v10, k, entity)
		end
	end
end

local function fn12()
	if __wf_atom_7e8ad928(v10) then
		return
	end

	for _, v16 in v10 do
		if not __wf_atom_7e8ad928(v16) then
			v16:Destroy()
		end
	end
end

function P6PlantWevetSeeds(taskID)
	if not (fn2(mOwner, taskID, true) and module.IsInOverworld()) then
		return
	end

	module14.ClearWeatherAndDisableCycle()
	gGameRules:HideGameSession(true)
	fn4(false)
	gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_b9375444(true)
	gGameRules:SetNetPersistentVar(Symbol("BromiusAcornsPlanted"), 0)
	_T.acornsPlanted = gGameRules:__wf_atom_d163c8e5(Symbol("BromiusAcornsPlanted"))
	_T.deadTreesToBeHealed = {
		Symbol("CoTALIVE1"),
		Symbol("CoTALIVE2"),
		Symbol("CoTALIVE0"),
		Symbol("CoTALIVE4"),
		Symbol("CoTALIVE3")
	}
	_T.ProgressionScreenDisabled = true

	if __wf_atom_7e8ad928(_T.acornsToPlant) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		_T.acornsToPlant = #__wf_atom_ef7900cf + 1
	end

	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromisFinalConvoTp"))

		if flag then
			module.TaggedFirePorts(Symbol("WevetwoodBarrierFinalState"), "TriggerPort")

			if _G.EnableDevTeleportToActiveStep then
				fn3(__wf_atom_0a6a5887, true)
			end
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("TreeGrowthCine"))
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("AcornPlantingTrigger"))
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("FinalAcornPlantingTrigger"))
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusCineDeco"))
		module6.UpdateOrAddHudTask(mOwner, taskID)

		while __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		module.TaggedFirePorts(Symbol("AcornPlantingSetupPortForwarder"), "TriggerPort")
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v16 = false

		if __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition()) >= 100 then
			v11 = module7.CreateAreaMarker(__wf_atom_0a6a5887, 40, __wf_atom_28d5d4aa, mOwner, taskID)
			module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, taskID)
		end

		while not (v16 or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) do
			if not module.IsInOverworld() then
				return
			end

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			elseif
				not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
				and __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition()) <= 20
			then
				module3.RemoveSparrowDestination(__wf_atom_0a6a5887, "BromiusQuest")
				v16 = true
			end

			Sleep(0.1)
		end

		fn11()
		Sleep(0.5)
		_T.SparrowMode = "KeepActive"
		module9.EnableTaggedSequencers(Symbol("BromiusQuestWater"), true)

		if module9.EnableTaggedSequencers(Symbol("PlantSeedsMusic"), true) == false then
			module9.EnableTaggedSequencers(Symbol("PlantSeedsMusic"), true)
		end

		local v17 = false

		while _T.acornsPlanted < _T.acornsToPlant do
			module6.UpdateVisibility(true)

			if _T.acornsPlanted == _T.acornsToPlant - 1 and not v17 then
				for _, v18 in __wf_atom_2226b35c do
					v18:Disable()
				end

				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
					Symbol("AncestorSpawnTrigger"),
					__wf_atom_0a6a5887_4:GetPosition(),
					0,
					15
				)

				if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
					__wf_atom_f738b4af:Enable()
				end

				__wf_atom_0a6a5887_3:Enable()

				if not __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(Symbol("FinalBromiusDirtMound")))) then
					local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("BromiusDirtMound"))

					for _, v18 in ipairs(__wf_atom_2226b35c2) do
						local __wf_atom_be0bea4a = v18:__wf_atom_be0bea4a()

						for _, v19 in ipairs(__wf_atom_be0bea4a) do
							v19:SetVisibility(false, true)
						end
					end

					module3.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, taskID)
				end

				v17 = true
			end

			Sleep(0.5)
		end

		Sleep(1)
		fn12()
		gGameRules:__wf_atom_0ab0a47f(Symbol("BromiusAcornsPlanted"))
		module6.UpdateOrAddHudTask(mOwner, taskID, "/SF/Language/Quests/BromiusSpeakWithTheArbearer")
		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusTreeHealSparrowHover"))
		module3.RemoveSparrowDestination(__wf_atom_0a6a5887_3)
		module3.AddQuestDestination(__wf_atom_0a6a5887_5, mOwner, taskID)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
			if not __wf_atom_7e8ad928(bromiusCelebrationCine) then
				__wf_atom_0a6a5887_4:Attach(bromiusCelebrationCine, EMPTY_SYMBOL)
			end

			if __wf_atom_7e8ad928(bondContextTrigger) then
				print("Failed to attach talk trigger, finishing the quest now")
			else
				local __wf_atom_e919fb8e = __wf_atom_0a6a5887_4:Attach(
					bondContextTrigger,
					Symbol("GAME_C1_ROOT"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				):__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.TaskID = taskID
				print("Bromius Talk trigger attached. woo")
				module.TaggedFirePorts(Symbol("BromiusApproachAcornsPlantedFlare"), "Enable")
			end
		end

		while not module7.AllPlayersReady(questType, taskID) do
			Sleep(0)
		end

		v3:__wf_atom_25131806(Symbol("PostBromiusQuest"))
		AllowDynamicCombatInQuestZone(true)
		module.TaggedFirePorts(Symbol("UnlockNeathuns"), "TriggerPort")
		module.TaggedFirePorts(Symbol("CouncilOfTreesAcornPlantingBarrier"), "Hide")
		module14.SetWeatherCycleEnabled(true)
	else
		local v16 = nil

		while __wf_atom_7e8ad928(v16) do
			v16 = gRegion:__wf_atom_0a6a5887(Symbol("BondWithBromius"))
			Sleep(1)
		end

		if not __wf_atom_7e8ad928(v16) then
			local __wf_atom_e919fb8e = v16:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.TaskID = taskID
		end
	end
end

function RemoveNpc(instance)
	Sleep(10)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v16 = 2.5

	while v16 >= 0 do
		instance:__wf_atom_a763aa1a(__wf_atom_421b01aa(1 - v16 / 5, 0, 1))
		Sleep(0)
		v16 -= __wf_atom_03df4e1d()
	end

	instance:Destroy()
end

function PlayTransmissions()
	for _, v16 in ipairs(transmissionTags) do
		if isLocal then
			module5.PlayLocalTransmission(transmissionSet, v16, gRegion:__wf_atom_c4f78a8f(), true)
		else
			module5.PlayGlobalTransmission(transmissionSet, v16)
		end
	end
end

function FadeCameraShake(p, p2, p3)
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	local __wf_atom_09197f82 = postProcessBias:__wf_atom_09197f82()
	local __wf_atom_d38fbfc6 = postProcessBias:__wf_atom_d38fbfc6()
	local v16 = __wf_atom_d38fbfc6
	local v17 = __wf_atom_09197f82
	local total = 0

	while v17 ~= p or v16 ~= p2 do
		total += __wf_atom_084b3e93()

		if v17 ~= p then
			if __wf_atom_09197f82 < p then
				v17 = __wf_atom_421b01aa(v17 + 2 * __wf_atom_084b3e93() / p3, __wf_atom_09197f82, p)
			else
				v17 = __wf_atom_421b01aa(v17 - 2 * __wf_atom_084b3e93() / p3, p, __wf_atom_09197f82)
			end

			postProcessBias:__wf_atom_54a04966(v17)
		end

		if v16 ~= p2 then
			if __wf_atom_d38fbfc6 < p2 then
				v16 = __wf_atom_421b01aa(v16 + 0.2 * __wf_atom_084b3e93() / p3, __wf_atom_d38fbfc6, p2)
			else
				v16 = __wf_atom_421b01aa(v16 - 0.2 * __wf_atom_084b3e93() / p3, p2, __wf_atom_d38fbfc6)
			end

			postProcessBias:__wf_atom_f846a58a(v16)
		end

		Sleep(0)
	end
end

function MemoryCinStateAdjustments(object)
	local position = object:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("DeathCabbage"), position, 0, 50)

	for _, v16 in ipairs(__wf_atom_439c0d29) do
		v16:SetVisibility(showCurrentDayEntities)
	end
end

function BromiusShake(_, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f:CameraControl():__wf_atom_4dab66dd(__wf_atom_c4f78a8f:GetPosition(), -1, 30, 2)
	Sleep(0.8)
	_T.DrunkBias = 0.5
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	postProcessBias:__wf_atom_54a04966(20)
	postProcessBias:__wf_atom_f846a58a(0.5)
	Sleep(1)
	FadeCameraShake(0, 0, 4)
end

function DeactivateAbilities()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v16 in __wf_atom_3c8e1a7a do
		if __wf_atom_7e8ad928(v16) then
			continue
		end

		local playerAvatar = v16:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_2ffcdee6()
		end
	end
end

function PlayCoughAnimation(_, _)
	if applyDelay > 0 then
		Sleep(applyDelay)
	end

	DeactivateAbilities()
	Sleep(0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(v5) then
		__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v5)
	end

	__wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_17c1c30f()
	__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)

	if isolatePlayers then
		HideOtherAvatars()
	end

	for _, v16 in pairs(gRegion:__wf_atom_ef7900cf()) do
		if v16 == gRegion:__wf_atom_c4f78a8f() then
			v16:__wf_atom_d2b2176d():Unequip(0, 2)
		end

		if not __wf_atom_7e8ad928(coughAnimation) then
			v16:__wf_atom_921c1a5f(coughAnimation, false, 4, 1, false)
		end
	end

	if applyDrunkEffect then
		_T.DrunkBias = drunkBiasIncrement
	end

	if not (__wf_atom_7e8ad928(v5) or applyForcedWalk) then
		Sleep(4)
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(v5)
		__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
	end

	if isolatePlayers then
		_T.IsolatePlayers = true
		ToHallwayCinTeardown()
	end
end

function RemoveDrunkEffects()
	local drunkBias = _T.DrunkBias or 0

	while drunkBias > 0 do
		drunkBias = math.max(0, drunkBias - __wf_atom_084b3e93() * 0.3)
		_T.DrunkBias = drunkBias
		Sleep(0)
	end
end

function HideAvatarsAndPlayCinematic(_, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(cinematicTag)

	if isolatePlayers then
		_T.IsolatePlayers = false
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetInstigatorAvatar(p)
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end
end

function HideOtherAvatars(_, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v16 in pairs(__wf_atom_ef7900cf) do
		if v16 ~= __wf_atom_c4f78a8f then
			v16:__wf_atom_a7ee9662(false, true)
		end
	end
end

function ShowOtherAvatars(_, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v16 in pairs(__wf_atom_ef7900cf) do
		if v16 ~= __wf_atom_c4f78a8f then
			v16:SetVisibility(true, true)
		end
	end
end

function DissolveWevetwoodBarrier(_, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local cameraControl = __wf_atom_c4f78a8f:CameraControl()
	local eyePosition = __wf_atom_c4f78a8f:EyePosition()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-BarrierLookTarget"))
	local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
	local v16 = __wf_atom_fa8d0177(eyePosition, __wf_atom_0a6a5887:GetPosition())
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WevetWoodBarrier"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		module9.EnableTaggedSequencers(Symbol("WevetwoodBarrierSeq"), false)
		module9.EnableTaggedSequencers(Symbol("WevetwoodBarrierDisableSeq"), true)
		cameraControl:__wf_atom_4dab66dd(eyePosition, -1, 5, 0)
		__wf_atom_0a6a5887_2:PlayTriggeredFade()
		local total = 0

		while total <= 2 and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) do
			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_9d2f097a(__wf_atom_4e50d390, v16, (total / 2) ^ 0.4))
			end

			total += __wf_atom_03df4e1d()
			Sleep(0)
		end
	end
end

function ManageLoot(p)
	if spawnWaypointTag == EMPTY_SYMBOL then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(spawnWaypointTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_bb3e7833 = gRegion:CreateEntity(
		objectType,
		__wf_atom_0a6a5887:GetPosition(),
		__wf_atom_0a6a5887:__wf_atom_dc309f8a()
	):__wf_atom_bb3e7833(__wf_atom_0f45538d)

	while not __wf_atom_7e8ad928(__wf_atom_bb3e7833) do
		if __wf_atom_bb3e7833:__wf_atom_272baebc() then
			if __wf_atom_7e8ad928(v4) then
				print("Finished task")
			else
				print("Finished " .. v4)
			end

			module7.CompleteTaskWithID(mOwner, p)
			break
		else
			Sleep(0.2)
		end
	end
end

function EnableFloppet()
	local weaponCustomization = SF.WeaponCustomization()

	if not __wf_atom_7e8ad928(floppetSkinType) then
		weaponCustomization:SetSkin(floppetSkinType, 2)
	end

	gGameRules:__wf_atom_51274c29(weaponCustomization)
	_T.OverrideSparrow = { agent = floppetAgentType }
	print("Floppet Enabled")
end

function DisableFloppet()
	gGameRules:__wf_atom_51274c29(SF.WeaponCustomization())
	_T.OverrideSparrow = nil
	print("Floppet Disabled")
end

function TreeDown()
	module.WaitForLevel()

	if not module.IsInOverworld() then
		_T.BromiusTreeFell = nil
	elseif not _T.BromiusTreeFell then
		module.TaggedFirePorts(Symbol("BrokenTreeFinalState"), "TriggerPort")
	end
end

function WevetwoodBarrierGone()
	module.WaitForLevel()

	if not module.IsInOverworld() then
		_T.BromiusWevetwoodBarrierGone = nil
	elseif not _T.BromiusWevetwoodBarrierGone then
		module.TaggedFirePorts(Symbol("WevetwoodBarrierFinalState"), "TriggerPort")
	end
end