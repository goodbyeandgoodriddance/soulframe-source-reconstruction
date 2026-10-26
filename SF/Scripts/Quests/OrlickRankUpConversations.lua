local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.ConversationLib")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Interface.SFUtilities")
local v = nil
local v2 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v3 = Symbol("Invulnerable")
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local flag = nil
local flag2 = false
local v9 = false
local v10 = false

function TimerSetCallback()
	v10 = true
end

function DitherOutAvatar(object)
	local v11 = 0

	while v11 < 1 do
		v11 = __wf_atom_421b01aa(v11 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v11)
		Sleep(0)
	end
end

function DitherInAvatar(object)
	object:__wf_atom_68f2c268(1)
	local v11 = 1

	while not __wf_atom_7e8ad928(object) and v11 > 0 do
		v11 = __wf_atom_421b01aa(v11 - __wf_atom_084b3e93() / 1.5, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v11))
		Sleep(0)
	end
end

function InitalizeChoices(items, p, p2)
	local response = nil
	local canProgress = nil
	local result = {}

	for k, item in pairs(items) do
		local responses = {}
		local selection = {}

		for k2, text in pairs(item) do
			local tag = "Stage" .. tostring(k) .. "Choice" .. tostring(k2)
			local v11 = { Text = text }
			v11.Text = __wf_atom_8e4fda44:__wf_atom_03ff0530():__wf_atom_8e9ac384(v11.Text, true)
			local v12 = k2

			function v11.Callback()
				v5 = tag
				v6 = v11
				v8 = v12
			end

			for k3, v13 in pairs(p[k]) do
				if k3 == k2 then
					response = v13
				end
			end

			for k3, v13 in pairs(p2[k]) do
				if k3 ~= k2 then
					continue
				end

				if v13 == "true" then
					canProgress = true
				else
					canProgress = false
				end
			end

			table.insert(responses, k2, {
				Response = response,
				Tag = tag,
				CanProgress = canProgress
			})
			table.insert(selection, k2, v11)
		end

		table.insert(result, k, { Selection = selection, Responses = responses })
	end

	return result
end

function ConfirmChoice(p)
	if tonumber(p) == 4 then
		flag = true
	else
		flag = false
	end
end

function ShowChoiceConfirmation(p)
	flag2 = true
	flag = nil
	local choice = Localize(p, false)
	local v11 = Localize("/SF/Language/Menu/ConfirmCodexTitleChoice", { CHOICE = choice })
	module5.ShowYesOrNoMessage(v11, "ConfirmChoice")

	while flag2 do
		if flag == true then
			if debugDontSave and v9 then
				break
			end

			gGameData:__wf_atom_e2b1c77d(recordPlayerChoiceSymbol, p)
			break
		elseif flag == false then
			flag2 = false
			break
		else
			Sleep(0)
		end
	end
end

function orlickConversation(object, object2)
	if not object2:__wf_atom_4417a5d4() then
		return
	end

	v9 = false
	local startingStage = startingStage

	if __wf_atom_7e8ad928(v) and not findCustomSpot then
		v = module2.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("ConversationCamera"))
	elseif __wf_atom_7e8ad928(v) then
		v = gRegion:__wf_atom_0a6a5887(cameraSpotTag)
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = gRegion:__wf_atom_f738b4af(npcTag, object2:GetPosition(), 0, 10)
	end

	if not gGameData then
		return
	end

	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object2:__wf_atom_dd875cd8(true)
	object2:__wf_atom_aeb02c14(v2)
	__wf_atom_d2b2176d:Unequip(0, 0)
	module3.CloseTransmissions()
	local v11 = { Loop = conversationMenuMusic }
	v4 = module4.CreateConversation(Localize(tostring(npcName), false), v)

	if __wf_atom_7e8ad928(v11) then
		v4:Start()
	else
		v4:Start(v11)
	end

	if hideAvatar then
		object2:__wf_atom_8a035cd5(Symbol("DitherOutAvatar"), false)
	end

	local v12 = { stage1ChoiceStrings, stage2ChoiceStrings, stage3ChoiceStrings }
	local v13 = { stage1Responces, stage2Responces, stage3Responces }
	local v14 = { stage1ResponceProgression, stage2ResponceProgression, stage3ResponceProgression }
	local v15 = InitalizeChoices(v12, v13, v14)

	if startingStage == 1 or alwaysPlayIntro then
		module3.PlayDialogMenuTransmission(npcTransmissionSet, conversationIntroTag, object2, not alwaysPlayIntro)
	end

	v4:SetChoices(v15[startingStage].Selection)

	while v4:Update() do
		if __wf_atom_7e8ad928(v5) then
			if flag2 then
				if flag then
					break
				end
			elseif #v4.mConvoInfo.Choices == 0 then
				v4:SetChoices(v15[startingStage].Selection)
			end
		elseif v5 == v15[startingStage].Responses[v8].Tag then
			v4:SetChoices(nil)
			v5 = nil
			local response = v15[startingStage].Responses[v8].Response
			module3.PlayDialogMenuTransmission(npcTransmissionSet, response, object2)

			if startingStage == 3 then
				if recordPlayerChoice and not gGameData:__wf_atom_10192cfa(recordPlayerChoiceSymbol) then
					local recordedChoice = recordedChoices[v8]
					ShowChoiceConfirmation(recordedChoice)
				else
					break
				end
			elseif v15[startingStage].Responses[v8].CanProgress == true then
				startingStage += 1
			end
		end

		Sleep(0)
	end

	object:__wf_atom_e95c24e1(object2:__wf_atom_a96eb2aa())
	v4:Close()

	if not __wf_atom_7e8ad928(object2) then
		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			__wf_atom_7470861b:__wf_atom_63396172(v3)
		end

		object2:__wf_atom_cf966a74(v2)
		object2:__wf_atom_dd875cd8(false)
	end

	if hideAvatar then
		object2:__wf_atom_8a035cd5(Symbol("DitherInAvatar"), false)
	end

	_T.NPCConversationFinished = { conversationID = conversationID }
end

function TransitionToBookHell(_, object)
	if module.QuestIsActive(questWeakRes) then
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

		if not object:__wf_atom_4417a5d4() then
			return
		end

		while
			module3.TransmissionPlaying()
			and (__wf_atom_7e8ad928(_T.TransmissionSoundInstance) or not (_T.TransmissionSoundInstance:__wf_atom_946fdac0() <= 1))
		do
			Sleep(0)
		end

		local acceptedQuest = module.GetAcceptedQuestFromType(questWeakRes)
		local questReplicationMode = module.GetQuestReplicationMode(acceptedQuest)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ORLICK_AVATAR_SPAWN"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			print("Transition to Book Hell: Cannot find spawn point for Orlick avatar.")
			return
		end

		local entity = gRegion:CreateEntity(
			orlickAvatarType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			object,
			object,
			questReplicationMode
		)
		module5.PlaySound(transitionSound)
		module6.RegisterHideHud(true)
		module2.Fade(true, 1, 1, true)
		Sleep(0.5)

		if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(entity)) then
			__wf_atom_a96eb2aa:__wf_atom_6c552f4c(1, entity)
			__wf_atom_a96eb2aa:AssignAvatar(entity, true, false)
			entity:__wf_atom_aeb02c14(orlickInputFilter)
		end

		module2.Fade(false, 1, 1, true)
	end
end

function transitionFromBookHell(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("A1P15_OrlickLocationTrigger"))

	if __wf_atom_0a6a5887 then
		_T.ForceGotToCompletedTrigger = __wf_atom_0a6a5887
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, #__wf_atom_3c8e1a7a do
		local v11 = __wf_atom_3c8e1a7a[i]
		local __wf_atom_50a7d83e = v11:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:__wf_atom_cf966a74((__wf_atom_50a7d83e:__wf_atom_4dc54686()))

		if not __wf_atom_50a7d83e:__wf_atom_4417a5d4() then
			continue
		end

		local playerAvatar = v11:GetPlayerAvatar(0)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("ORLICK_TOWER_CINE"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			break
		end

		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
			Symbol("OrlickNpc"),
			__wf_atom_0a6a5887_2:GetPosition(),
			0,
			5
		)
		local v12 = nil

		while __wf_atom_7e8ad928(__wf_atom_f738b4af) do
			__wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
				Symbol("OrlickNpc"),
				__wf_atom_0a6a5887_2:GetPosition(),
				0,
				5
			)
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			v12 = module2.FindTaggedChild(__wf_atom_f738b4af:__wf_atom_be0bea4a(), Symbol("AttachedBaby"))
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(__wf_atom_f738b4af, Symbol("Orlick"))
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(v12, Symbol("OrlickBaby"))
		end

		v11:AssignAvatar(playerAvatar)
		__wf_atom_50a7d83e:Destroy()
		module2.PlayCinematicWithTagAndWait(Symbol("ORLICK_TOWER_CINE"), false, playerAvatar)
		module6.RegisterHideHud(false)
		break
	end
end

function CreateCameraSpotAtLastCinePostion(_, _, _)
	local gameCamera = gRegion:GetGameCamera()
	v = gRegion:CreateEntity(cameraSpotType, gameCamera:GetPosition(), gameCamera:__wf_atom_dc309f8a())
	v:__wf_atom_888efbe9(gameCamera:__wf_atom_c277aed8())
end

function TransitionfromCineToConversation(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(conversationTag)

	if not (__wf_atom_7e8ad928(__wf_atom_02a7a2f4) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) then
		__wf_atom_02a7a2f4:__wf_atom_3e5bf6ab(__wf_atom_0a6a5887, true)
	end
end

function StartForceWalk(_, object)
	object:MotionControl():__wf_atom_99fc7a82(true)
end

function EndForceWalk(_, object)
	object:MotionControl():__wf_atom_99fc7a82(false)
end

function PosessBeaver(_, _, _)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_a96eb2aa = __wf_atom_c4f78a8f:__wf_atom_a96eb2aa()
	local entity = gRegion:CreateEntity(
		Type("/SF/Types/NeutralCreatures/Beaver/BeaverAvatar"),
		__wf_atom_c4f78a8f:GetPosition(),
		__wf_atom_c4f78a8f:__wf_atom_dc309f8a(),
		__wf_atom_c4f78a8f,
		__wf_atom_c4f78a8f,
		1
	)

	if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(entity)) then
		__wf_atom_a96eb2aa:__wf_atom_6c552f4c(4, entity)
		__wf_atom_a96eb2aa:AssignAvatar(entity, true, false)
	end
end