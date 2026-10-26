require("SF.Scripts.Libs.AncestorsFunctionLib")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("Lotus.Scripts.Libs.AudioLib")
local module6 = require("SF.Scripts.Libs.StatsLib")
local module7 = require("SF.Scripts.Libs.EncounterLib")
local v = WeakResource("/SF/Types/Quests/AncestorProgression/OrlickProgression/OrlickDiscoveryQuest")
local v2 = WeakResource("/SF/Types/Quests/AncestorProgression/OrlickProgression/QuestAssets/OrlicksQuillQuestItem")
WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
WeakResource("/SF/Types/Quests/AncestorProgression/OrlickProgression/QuestAssets/OrlikAncestorTrailEffect")
local v3 = Type("/SF/Types/Gameplay/CollectableNotes/Midrath/OrlickDiscoveryCollectableNotePickup")
local v4 = Symbol("OrlickScrollClue")
local v5 = Symbol("ScrollPickupPoint")
local v6 = nil
local v7 = nil

local function fn()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("orlick scroll already exists!")
		return
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v5)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887 = gRegion:CreateEntity(
			v3,
			__wf_atom_0a6a5887_2:GetPosition(),
			__wf_atom_0a6a5887_2:__wf_atom_dc309f8a(),
			nil,
			nil,
			1
		)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("unable to create orlick scroll clue!")

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			print("was unable to find scroll waypoint!")
		end
	end
end

local function fn2(mOwner2, p, p2, p3)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v6 = tostring(module3.GetReadableTaskTag(mOwner2, p))

	if not module.IsInOverworld() then
		print("Quest: Not in overworld, early out at stage: " .. v6)
		return false
	end

	if gRegion:IsMaster() then
		print("Starting" .. v6)
		fn()
		v7 = module.WaitForAiDir()
		EnableOrlickEncounters()
	elseif p2 then
		print("Starting" .. v6 .. " (client)")
	else
		return false
	end

	HideQuill()
	module3.TrackQuest(mOwner, true)

	if __wf_atom_7e8ad928(p3) or p3 == true then
		module4.UpdateOrAddHudTask(mOwner, p)
		module4.UpdateVisibility(true, 20)
	end

	return true
end

function EnableOrlickEncounters()
	if v:IsA((WeakResource("/SF/Types/Quests/AncestorProgression/OrlickProgression/OrlickDiscoveryQuest"))) then
		gRegion:__wf_atom_0a6a5887(Symbol("OrlickTowerZone")):FirePort("Enable")
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TowerCamp"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Disable()
			module7.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickQuestTower"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:Enable()
			__wf_atom_0a6a5887_2:__wf_atom_252fae6e(3)
			module7.SetEncounterHeaviesBlocked(__wf_atom_0a6a5887_2, true)
		end
	end
end

function HideQuill()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickInkwell"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local taggedChild = module.FindTaggedChild(__wf_atom_0a6a5887:__wf_atom_be0bea4a(), Symbol("Quill"))

	if not __wf_atom_7e8ad928(taggedChild) then
		taggedChild:SetVisibility(false)
	end
end

local function fn3(questEncounterHint, object)
	if __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(v7) then
		return
	end

	local entity = gRegion:CreateEntity(questEncounterHint, object:GetPosition(), __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(entity) then
		v7:__wf_atom_ccbb5582(entity)
		module7.SetEncounterHeaviesBlocked(entity, blockHeaviesInEncounter)
		entity:__wf_atom_252fae6e(enemyLevelOverride)
	end
end

function FindTower(p)
	if not (module.IsInOverworld() and fn2(mOwner, p, true, false)) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickWhispersStartQuest"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(destinationTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Enable")
	end

	module2.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)
	module4.UpdateOrAddHudTask(mOwner, p)
	Sleep(7)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:Attach(tutorialTriggerType, EMPTY_SYMBOL)
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsEnabled() do
		Sleep(1)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	if gRegion:IsMaster() then
		module3.CompleteTaskWithID(mOwner, p)
	end
end

function FollowTheVoices(p)
	if not fn2(mOwner, p, true, false) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(destinationTag)
	local v8 = Symbol("AwakenOrlick")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v8)

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) do
		Sleep(0.1)
		__wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v8)
	end

	__wf_atom_0a6a5887_2:Enable()
	module2.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickTowerDoor"))
	local v9

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		v9 = __wf_atom_0a6a5887_3:Attach(soulModeOverlayType, EMPTY_SYMBOL)
		Sleep(0)

		if not __wf_atom_7e8ad928(v9) then
			v9:__wf_atom_b811702e(Symbol("SOUL_MODE_HIDDEN"))
		end
	end

	Sleep(15)
	module4.UpdateOrAddHudTask(mOwner, p)
	module4.UpdateVisibility(true, 20)
	Sleep(3)
	module.TaggedFirePorts(Symbol("OrlickSoulModeTutorial"), "Enable")
	_T.HideAnimalTutorial = true

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_0a6a5887_2:__wf_atom_272baebc()) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Destroy()
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	local __wf_atom_ae2c2cee = __wf_atom_0a6a5887_2:__wf_atom_ae2c2cee()
	module6.ReplicateLogEvent("ORLICK_QUEST", "FindOrlick")
	module.PlayCinematicWithTagAndWait(Symbol("OrlickRevealCine"), false, __wf_atom_ae2c2cee)
	module4.CompleteHudTask(mOwner, nil, p, module4.COMPLETETIME)
	Sleep(module4.COMPLETETIME)
	_T.HideAnimalTutorial = false

	if gRegion:IsMaster() then
		module3.CompleteTaskWithID(mOwner, p)
	end
end

function FindTheGraveStone(p)
	if not fn2(mOwner, p, true) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GraveYardWP"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickDiscoveryNPC"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DisableOrlickWispers"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:FirePort("TriggerPort")
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(ancestorNPCTag)

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_4) or __wf_atom_7e8ad928(ancestorWatingIdle)) then
		__wf_atom_0a6a5887_4:SetVisibility(true, true)
		__wf_atom_0a6a5887_4:__wf_atom_d927a2a4(ancestorWatingIdle)
	end

	if gRegion:IsMaster() then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("OrlickQuillEncounters"))

		if #__wf_atom_2226b35c >= 1 and not __wf_atom_7e8ad928(questEncounterHint) then
			for _, v8 in ipairs(__wf_atom_2226b35c) do
				fn3(questEncounterHint, v8)
			end
		end
	end

	if not module.AnyPlayerHasItem(v2, true) then
		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			module2.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p)
		end

		while not module.AnyPlayerHasItem(v2, true) do
			Sleep(0)
		end

		if gRegion:IsMaster() then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			for _, v8 in ipairs(__wf_atom_3c8e1a7a) do
				local v9 = Resource(v2)
				local __wf_atom_50a7d83e = v8:__wf_atom_50a7d83e()

				if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:HasItem(v2)) then
					__wf_atom_50a7d83e:GiveItem(v9, false)
				end
			end
		end

		module5.EnableTaggedSequencers(Symbol("SFXOrlickScrollHint"), false)
	end

	local c_str = followUpTaskDesc:c_str()
	module4.CompleteHudTask(mOwner, nil, p, module4.COMPLETETIME)
	module4.UpdateOrAddHudTask(mOwner, p, c_str)
	module4.UpdateVisibility(true, 20)
	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("OrickDiscovery_ReturnToOfficeTrigger"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
		return
	end

	__wf_atom_0a6a5887_5:Enable()

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		module2.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) and __wf_atom_0a6a5887_5:IsEnabled() do
		Sleep(0)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
			return
		end
	end

	module4.RemoveHudTask(mOwner, nil, p)

	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(v4)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
			print("no scroll to destroy!")
		else
			gRegion:__wf_atom_dd1e4d10(__wf_atom_0a6a5887_6)
		end

		module3.CompleteTaskWithID(mOwner, p)
	end
end

function OrlickQuestActive()
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if not module.IsInOverworld() then
		return
	end

	if not __wf_atom_7e8ad928(_T.OrlickTowerMarker) then
		_T.OrlickTowerMarker:Destroy()
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(destinationTag)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("GraveYardWP"))

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)) then
		local v8 = __wf_atom_0a6a5887_2:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) + 5
		_T.OrlickTowerMarker = module3.CreateAreaMarker(__wf_atom_0a6a5887, v8)
	end
end

function OrlickQuestDone()
	if not __wf_atom_7e8ad928(_T.OrlickTowerMarker) then
		_T.OrlickTowerMarker:Destroy()
		_T.OrlickTowerMarker = nil
	end
end

function SoulModeTutorial(object, p)
	if module.CanShowMessage(p, false) then
		_T.CurrentTutorialMessage = "/SF/Language/Tutorial/SoulWayfinding_KBM"
		_T.ShowImpactMessage(_T.CurrentTutorialMessage, 8)
	end

	object:Disable()
end