local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ConversationLib")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local v = nil
local v2 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v3 = Symbol("Invulnerable")
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = WeakResource("/SF/Types/Lore/MidrathHubKeysLoreFragement")
local v9 = Symbol("SaboteurHub")

function OnInventoryCommitCallback()
	gGameData:SyncInventoryFromDB("EmptyCallback")
end

function GiveLoreDrop(p, p2, p3)
	if not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
		return
	end

	if not __wf_atom_7e8ad928(p2) then
		if p3 == EMPTY_SYMBOL then
			module3.GiveLoreFragment(p2, p)
		else
			module3.GiveLoreFragmentMemory(p2, p, p3)
		end

		for _, v10 in gRegion:FindAll(markerInfo) do
			v10:__wf_atom_ff716ec1(true)
		end
	end
end

function OpenDoor()
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SilentRoseTalkAction"))

	for _, v10 in ipairs(__wf_atom_a8553251) do
		if v10:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition()) < 30 then
			GiveLoreDrop(Resource("/SF/Types/Lore/MidrathHubKeysLoreFragement"), v10, v9)
		end
	end
end

function EvaluateAileasConvo()
	if __wf_atom_7e8ad928(v8) then
		return true
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled()) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_d2b2176d:__wf_atom_705a2744(v8, v9)) then
			return true
		end
	end

	return false
end

function SlidePlayer(p)
	if __wf_atom_7e8ad928(wp) then
		return
	end

	module5.SlidePlayer(p, wp, moveTime)
end

function StartAileasConversation(object, object2)
	if object2:__wf_atom_4417a5d4() then
		v = object:__wf_atom_3d96ddcd()
		object2:__wf_atom_8a035cd5(Symbol("AileasConversation"), false)
	end
end

function AttachBottle() end

function AileasConversation(object)
	if __wf_atom_7e8ad928(_T.AlieasConvoStage) then
		_T.AlieasConvoStage = 1
	end

	if __wf_atom_7e8ad928(_T.AileasConvoCompleted) then
		_T.AileasConvoCompleted = false
	end

	if not gGameData then
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("HubTaskNpcCamspot"), object:GetPosition(), 0, 10)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local flag = false
	object:__wf_atom_dd875cd8(true)
	object:__wf_atom_aeb02c14(v2)
	__wf_atom_d2b2176d:Unequip(0, 0)
	module4.CloseTransmissions()
	local v10 = { Loop = conversationMenuMusic }
	v4 = module5.CreateConversation(Localize(tostring(npcName), false), __wf_atom_f738b4af, conversationMenuMovie)

	if __wf_atom_7e8ad928(v10) then
		v4:Start()
	else
		v4:Start(v10)
	end

	object:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
	local v11 = { Text = "/SF/Language/Quests/AileasInvertationResponse" }
	v11.Text = Localize(v11.Text, false)
	local v12 = "InviteResponse"

	function v11.Callback()
		v5 = v12
		v6 = v11
	end

	local v13 = { Text = "/SF/Language/Quests/AilesaHubTaskCourageResponse" }
	v13.Text = Localize(v13.Text, false)
	local v14 = "NoInviteResponse"

	function v13.Callback()
		v5 = v14
		v6 = v13
	end

	local v15 = { Text = "/SF/Language/Quests/AileasHubTaskSpiritResponse" }
	v15.Text = Localize(v15.Text, false)
	local v16 = "NoInviteResponse"

	function v15.Callback()
		v5 = v16
		v6 = v15
	end

	local v17 = { Text = "/SF/Language/Quests/AilesaHubTaskGraceResponse" }
	v17.Text = Localize(v17.Text, false)
	local v18 = "NoInviteResponse"

	function v17.Callback()
		v5 = v18
		v6 = v17
	end

	local v19 = { Text = "/SF/Language/Quests/TaskItemAquiredEarly" }
	v19.Text = Localize(v19.Text, false)
	local v20 = "HasItem"

	function v19.Callback()
		v5 = v20
		v6 = v19
	end

	local v21 = { Text = "/SF/Language/Quests/TaskItemAquired" }
	v21.Text = Localize(v21.Text, false)
	local v22 = "HasItem"

	function v21.Callback()
		v5 = v22
		v6 = v21
	end

	local v23 = { Text = "/SF/Language/Quests/TaskItemNotAquired" }
	v23.Text = Localize(v23.Text, false)
	local v24 = "HasNoItem"

	function v23.Callback()
		v5 = v24
		v6 = v23
	end

	local v25 = {
		Text = "/SF/Language/Quests/LeaveConvo",
		"Exit"
	}
	v25.Text = Localize(v25.Text, false)
	local v26 = nil

	function v25.Callback()
		v5 = v26
		v6 = v25
	end

	gGameData:SyncInventoryFromDB("EmptyCallback")
	gGameData:GetInventory()
	local anyPlayerHasItem = module3.AnyPlayerHasItem(hubTaskItem, false)
	v4:SetChoices(nil)

	if _T.AlieasConvoStage < 2 and not module.QuestIsActive(taskQuestRef) then
		module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ConversationIntro"), object, true)

		if module.TaggedTaskIsActive(questRef, Symbol("GoToSilentRose")) and not anyPlayerHasItem then
			v4:SetChoices({ v11 })
		elseif anyPlayerHasItem then
			v4:SetChoices({ v19 })
		else
			v4:SetChoices({ v15, v17, v13 })
		end
	elseif _T.AlieasConvoStage < 3 or module.QuestIsActive(taskQuestRef) then
		module4.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("RestartingConvo"), object, true)

		if anyPlayerHasItem then
			v4:SetChoices({ v21 })
		else
			v4:SetChoices({ v23 })
		end
	end

	while v4:Update() do
		if not __wf_atom_7e8ad928(v5) then
			if v5 == "InviteResponse" then
				module4.PlayDialogMenuTransmission(
					npcTransmissionSet,
					Symbol("SilentRoseTaskInvitationResponse"),
					object,
					true
				)

				if not module.QuestIsActive(taskQuestRef) then
					print("Staring background Quest task... " .. tostring(taskQuestRef))
					module.StartQuest(taskQuestRef)
					module.TrackQuest(taskQuestRef, true)
				end

				_T.AlieasConvoStage = 2
				_T.AlieasQuestConvoStepCompleted = true
				break
			elseif v5 == "NoInviteResponse" then
				module4.PlayDialogMenuTransmission(
					npcTransmissionSet,
					Symbol("SilentRoseTaskNoInvitationResponse"),
					object,
					true
				)

				if not module.QuestIsActive(taskQuestRef) then
					print("Staring background Quest task... " .. tostring(taskQuestRef))
					module.StartQuest(taskQuestRef)
					module.TrackQuest(taskQuestRef, true)
				end

				_T.AlieasConvoStage = 2
				break
			elseif v5 == "HasItem" then
				_T.AileasConvoCompleted = true
				flag = true
				break
			elseif v5 == "HasNoItem" then
				module4.PlayDialogMenuTransmission(
					npcTransmissionSet,
					Symbol("SilentRoseTaskHasNoItemResponse"),
					object,
					true
				)
				module.TrackQuest(taskQuestRef)
				_T.AlieasConvoStage = 2
				break
			elseif v5 == "Exit" then
				break
			end
		end

		Sleep(0)
	end

	if flag then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Bottle"))
		object:__wf_atom_d2b2176d():ConsumeMiscItem(hubTaskItem, 1)
		giveBottleCine:__wf_atom_a3d2b66b(object, Symbol("Envoy"))
		giveBottleCine:__wf_atom_a3d2b66b(hubNpc, hubNpcAnimName)
		giveBottleCine:__wf_atom_a3d2b66b(__wf_atom_0a6a5887, Symbol("Bottle"))
		giveBottleCine:StartRelative(hubNpcAnimName, hubNpc:__wf_atom_a2a18137(), hubNpc:__wf_atom_dc309f8a())
	end

	while not __wf_atom_7e8ad928(giveBottleCine) and giveBottleCine:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	v4:Close()

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		__wf_atom_7470861b:__wf_atom_63396172(v3)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_cf966a74(v2)
		object:__wf_atom_dd875cd8(false)
	end

	if flag then
		hubNpc:__wf_atom_d30cffc0()
		hubNpc:__wf_atom_d927a2a4(drinkingIdle, true)
		GiveLoreDrop(Resource("/SF/Types/Lore/MidrathHubKeysLoreFragement"), object, Symbol("SaboteurHub"))
	end
end

function TalkToAlieas(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	while not _T.AlieasQuestConvoStepCompleted do
		Sleep(2)
	end
end

function CheckForItem(p)
	if module3.AnyPlayerHasItem(hubTaskItem) then
		module.CompleteTaskWithID(p)
	end
end

function GetTheBooze(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	if __wf_atom_7e8ad928(_T.AileasConvoCompleted) then
		_T.AileasConvoCompleted = false
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled() do
		Sleep(1)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		__wf_atom_d2b2176d:__wf_atom_705a2744(v8, v9)
	end

	if not module3.IsInOverworld() then
		return
	end

	module2.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CampfireSalzbrimNorth"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BurningSage-1.0-DebugTeleport"))

	if gRegion:IsMaster() then
		local v10 = module3.WaitForAiDir()

		if not module3.AnyPlayerHasItem(taskItem) then
			v10:PrimeMissionOnHint(Symbol("MT_SILENTROSEHUBTASK"), __wf_atom_0a6a5887)
			v7 = module.CreateAreaMarker(__wf_atom_0a6a5887, 50, __wf_atom_28d5d4aa, mOwner, p)
			module6.AddSparrowDestination(
				__wf_atom_0a6a5887_2,
				mOwner,
				p,
				module6.PRIORITY.QUEST,
				Range(0, 3.4028234663852886e38),
				mOwner,
				p
			)
		end
	end

	while module3.AnyPlayerHasItem(taskItem) == false do
		if not module3.IsInOverworld() then
			return
		end

		Sleep(2)
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module6.RemoveSparrowDestination(v7, "GetSilentRoseItem")
		module.DestroyAreaMarker(__wf_atom_0a6a5887)
	end

	Sleep(1)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("Aileas"))
	module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
	module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/SilentRoseBoozeQuestReturn")
	module6.AddQuestDestination(__wf_atom_0a6a5887_3, mOwner, p, Range(2, 3.4028234663852886e38))

	while
		_T.AileasConvoCompleted == false
		and (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or not __wf_atom_d2b2176d:__wf_atom_705a2744(v8, v9))
	do
		Sleep(2)
	end

	module2.CompleteHudTask(mOwner, nil, p, module2.COMPLETETIME)
	Sleep(module2.COMPLETETIME)
	module.CompleteTaskWithID(mOwner, p)
end