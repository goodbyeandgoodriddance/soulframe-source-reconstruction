local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ConversationLib")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local module7 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module8 = require("SF.Scripts.NightFoldLib")
local v = nil
local v2 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v3 = Symbol("Invulnerable")
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/ProgressionQuests/VerminiaRankOne")
local v11 = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/AncestorVerminiaDiscoveryQuest")

local function fn(object)
	if not __wf_atom_7e8ad928(object) then
		local v12 = 0

		while not __wf_atom_7e8ad928(object) and v12 < 1 do
			v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93(), 0, 1)
			object:__wf_atom_68f2c268(v12)
			Sleep(0)
		end

		object:SetVisibility(false, true)
	end
end

function ConsumeItem(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_921c1a5f(placeAnim, false, 4, 1, false)
	object:__wf_atom_8914dfde("CreateItem", 4)
	local v12

	if not __wf_atom_7e8ad928(p) then
		v12 = object:Attach(p, Symbol("GAME_R1_WEAPON1"), Vector(-0.03, -0.04, 0), __wf_atom_80368bb1)
		v12:SetMeshScale(0.5, true)
		v12:__wf_atom_0ed81088(false)
	end

	object:__wf_atom_8914dfde("Placed", 4)

	if not __wf_atom_7e8ad928(v12) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WallplacementPoint"))
		v12:__wf_atom_e6ed03c8()
		v12:__wf_atom_0ed81088(true)
		v12:SetPosition(__wf_atom_0a6a5887:GetPosition())
		v12:__wf_atom_9b788a35(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
	end

	if p2 then
		object:__wf_atom_d2b2176d():ConsumeMiscItem(hubTaskItem, 1)
	end

	object:__wf_atom_8914dfde("ShrineReaction", 4)
	Sleep(2)
	fn(v12)
end

function SlidePlayer(object)
	v9 = gRegion:__wf_atom_f738b4af(wpSymbol, object:GetPosition(), 0, 10)

	if __wf_atom_7e8ad928(v9) then
		return
	end

	module5.SlidePlayer(object, v9, moveTime)
end

function StartVerminiaConversation(object, object2)
	if object2:__wf_atom_4417a5d4() then
		v = object:__wf_atom_3d96ddcd()
		object2:__wf_atom_8a035cd5(Symbol("VerminiaConversation"), false)
	end
end

function VerminiaConversation(object)
	if __wf_atom_7e8ad928(_T.ConvoStage) then
		_T.ConvoStage = 1
	end

	if __wf_atom_7e8ad928(_T.RankConvoCompleted) then
		_T.RankConvoCompleted = false
	end

	if not gGameData then
		return
	end

	v8 = gRegion:__wf_atom_f738b4af(Symbol("VerminiaNpc"), object:GetPosition(), 0, 20)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("ConversationCam"), object:GetPosition(), 0, 10)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(Symbol("VerminiaRankUpCtx"), object:GetPosition(), 0, 10)
	object:__wf_atom_dd875cd8(true)
	object:__wf_atom_aeb02c14(v2)
	__wf_atom_d2b2176d:Unequip(0, 0)
	module4.CloseTransmissions()
	local v12 = { Loop = conversationMenuMusic }
	v4 = module5.CreateConversation(Localize(tostring(npcName), false), __wf_atom_f738b4af)

	if __wf_atom_7e8ad928(v12) then
		v4:Start()
	else
		v4:Start(v12)
	end

	object:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
	local v13 = { Text = "/SF/Language/Quests/VerminiaICanRead" }
	v13.Text = Localize(v13.Text, false)
	local v14 = "CanYouTho"

	function v13.Callback()
		v5 = v14
		v6 = v13
	end

	local v15 = { Text = "/SF/Language/Quests/VerminiaGiveItem" }
	v15.Text = Localize(v15.Text, false)
	local v16 = "GiveItem"

	function v15.Callback()
		v5 = v16
		v6 = v15
	end

	local v17 = { Text = "/SF/Language/Quests/VerminiaComeBackToNf" }
	v17.Text = Localize(v17.Text, false)
	local v18 = "ComeBackHome"

	function v17.Callback()
		v5 = v18
		v6 = v17
	end

	gGameData:SyncInventoryFromDB("EmptyCallback")
	gGameData:GetInventory()
	local anyPlayerHasItem = module3.AnyPlayerHasItem(hubTaskItem, false)

	if _T.ConvoStage < 2 then
		module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ConversationIntro"), object, true)
		v4:SetChoices({ v13, v17 })
	elseif _T.ConvoStage < 3 then
		if anyPlayerHasItem then
			module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("RestartingConvo"), object, true)
			v4:SetChoices({ v15 })
		else
			module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("NoItemResponse"), object, true)
			v4:Close()

			if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
				__wf_atom_7470861b:__wf_atom_63396172(v3)
			end
		end
	end

	while v4:Update() do
		if not __wf_atom_7e8ad928(v5) then
			if v5 == "CanYouTho" then
				v5 = nil
				module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("CanYouRead"), object, true)
				v4:SetChoices({ v13, v17 })
			elseif v5 == "ComeBackHome" then
				v5 = nil
				module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ComeHome"), object, true)

				if anyPlayerHasItem then
					v4:SetChoices({ v15 })
				else
					_T.ConvoStage = 2
					break
				end
			elseif v5 == "GiveItem" then
				v5 = nil
				__wf_atom_d2b2176d:ConsumeMiscItem(hubTaskItem, 1)
				module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("FlowerGiven"), object, true)
				module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("FlowerEaten"), object, true)
				_T.ConvoStage = 3
				_T.RankConvoCompleted = true
				break
			end
		end

		Sleep(0)
	end

	v4:Close()

	if not __wf_atom_7e8ad928(object) then
		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			__wf_atom_7470861b:__wf_atom_63396172(v3)
		end

		object:__wf_atom_cf966a74(v2)
		object:__wf_atom_dd875cd8(false)
	end

	if _T.ConvoStage == 2 then
		module2.UpdateOrAddHudTask(mOwner, findHueTaskLoc)
	end

	if _T.RankConvoCompleted then
		__wf_atom_f738b4af2:__wf_atom_e95c24e1(object:__wf_atom_a96eb2aa())
		module8.SetForceInteractDisable(ancestorRes, false)
		module8.SetHideAncestorNPC(ancestorRes, false)

		if not __wf_atom_7e8ad928(ancestorRes) then
			module7.RankUpAncestorAndTryStartNextRank(object, ancestorRes, nil, rankUpQuest, Symbol("TalkToVerminia"))
		end

		local __wf_atom_f738b4af3 = gRegion:__wf_atom_f738b4af(
			Symbol("VerminiaVanishPoint"),
			object:GetPosition(),
			0,
			40
		)
		module7.DissolveOut(v8, __wf_atom_f738b4af3:GetPosition())
	end
end

function PrepareVerminiaConversation(object, _)
	v8 = gRegion:__wf_atom_f738b4af(Symbol("VerminiaNpcRankUp1Npc"), object:GetPosition(), 0, 20)

	if __wf_atom_7e8ad928(v8) then
		print("VerminiaNPC not found ending conversation Setup")
		return
	end

	v8:SetVisibility(true, true)
	v8:Attach(talkAction, Symbol("GAME_C1_SPINE2"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	v8:__wf_atom_d927a2a4(npcTalkIdleAnim)
end

function HideVerminia(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WitchStationDeco_HeroRat"))
	local v12, v13, v14 = module7.CheckForPendingRankUp(ancestorRes)

	if v12 and module.TaggedTaskIsActive(v13, Symbol("RankCompleted")) then
		module.CompleteTaskWithTag(v13, v14)
		module8.SetForceInteractDisable(ancestorRes, true)
		module8.SetHideAncestorNPC(ancestorRes, true)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:__wf_atom_7b7015c9(noteRatAnim)
		end
	end
end

function FindVerminia(p)
	if not module.InitializeTask(mOwner, p, true) or module.QuestIsActive(v11) then
		return
	end

	_T.RankConvoCompleted = false
	module8.SetForceInteractDisable(ancestorRes, true)
	module8.SetHideAncestorNPC(ancestorRes, true)
	local __wf_atom_d2b2176d = gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d()

	if not (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_7e8ad928(noteLore) or __wf_atom_d2b2176d:__wf_atom_705a2744(noteLore, memorySym)) then
		while module3.WaitToEnterNightfold() do
			Sleep(1)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WitchStationDeco_HeroRat"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNoteSpawn"))
		gRegion:CreateEntity(
			verminiaNoteClue,
			__wf_atom_0a6a5887_2:GetPosition(),
			__wf_atom_0a6a5887_2:__wf_atom_dc309f8a(),
			nil,
			nil
		)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:__wf_atom_7b7015c9(noteRatAnim)
		end

		while module3.WaitToExitNightfold() do
			Sleep(0)
		end
	end

	module.EnableQuestStepInJournal(v10, p, true)

	if module3.IsInOverworld() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(rankConvoSetupTag)
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
			__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(rankConvoSetupTag)
			Sleep(1)
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:FirePort("Execute")
		end

		if
			not __wf_atom_7e8ad928(__wf_atom_d2b2176d)
			and not __wf_atom_7e8ad928(noteLore)
			and __wf_atom_d2b2176d:__wf_atom_705a2744(noteLore, memorySym)
		then
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(verminiaLocationWP)
			module2.UpdateOrAddHudTask(mOwner, p)
			local v12 = false
			__wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887_2:GetPosition())

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				v7 = module.CreateAreaMarker(__wf_atom_0a6a5887_2, 40, __wf_atom_28d5d4aa, mOwner, p)
				module6.AddSparrowDestination(
					__wf_atom_0a6a5887_2,
					nil,
					"VermniniaRankUp",
					module6.PRIORITY.QUEST,
					nil,
					mOwner
				)

				if not __wf_atom_7e8ad928(nil) then
					module6.SetupWaypointPath("VermniniaRankUp", nil, false)
				end
			end

			while not (v12 or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)) do
				if not module3.IsInOverworld() then
					return
				end

				if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
				elseif
					not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)
					and __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887_2:GetPosition()) <= 10
				then
					module6.RemoveSparrowDestination(nil, "VermniniaRankUp")
					v7:Destroy()
					v12 = true
				end

				Sleep(0.1)
			end
		end
	elseif
		not __wf_atom_7e8ad928(__wf_atom_d2b2176d)
		and not __wf_atom_7e8ad928(noteLore)
		and __wf_atom_d2b2176d:__wf_atom_705a2744(noteLore, memorySym)
	then
		module2.UpdateOrAddHudTask(mOwner, p)
	end
end