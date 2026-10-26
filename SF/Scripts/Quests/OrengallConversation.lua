local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.ConversationLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local v = Resource("/Lotus/Types/Input/DialogInputFilter")
local v2 = Symbol("Invulnerable")
local v3 = Symbol("/SF/Language/Pacts/OrengalName")
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil

function EvaluateOrengallAmbushConversation()
	return not _T.OrengallConversationCompleted
end

function OrengallAmbushConversation(object, object2)
	if object2:__wf_atom_4417a5d4() then
		v7 = object:__wf_atom_3d96ddcd()
		object2:__wf_atom_8a035cd5(Symbol("OrengallConversation"), false)
	end
end

function OrengallConversation(object)
	if __wf_atom_7e8ad928(_T.OrengallConversationStage) then
		_T.OrengallConversationStage = 1
	end

	v7:__wf_atom_921c1a5f(conversationIdleAnim, false, 3, 2, true)
	local v8 = Vector(-1, 1.2, 4)
	local v9 = Rotation(151.629, -13, 0)
	local v10 = v7:Attach(cameraSpotType, EMPTY_SYMBOL, v8, v9)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_7470861b:__wf_atom_9fba31e6(v2, 26, 6, 0)
	object:__wf_atom_dd875cd8(true)
	object:__wf_atom_aeb02c14(v)
	__wf_atom_d2b2176d:Unequip(0, 0)
	module.CloseTransmissions()
	local v11 = { Loop = conversationMenuMusic }
	v4 = module2.CreateConversation(Localize(tostring(v3), false), v10, newConversationMovie)
	v4:Start(v11)
	local v12 = { Text = "/SF/Language/Quests/OrengallDialogueInitiaResponse" }
	v12.Text = Localize(v12.Text, false)
	local v13 = "FreedOrengall"

	function v12.Callback()
		v5 = v13
		v6 = v12
	end

	local v14 = {
		Text = "/SF/Language/Quests/OrengallDialogueCourageResponse",
		SuccessState = true,
		Skill = 1,
		Attribute = 0
	}
	v14.Text = Localize(v14.Text, false)
	local v15 = "FreedVirtueChoices"

	function v14.Callback()
		v5 = v15
		v6 = v14
	end

	local v16 = {
		Text = "/SF/Language/Quests/OrengallDialogueSpiritResponse",
		SuccessState = true,
		Skill = 2,
		Attribute = 1
	}
	v16.Text = Localize(v16.Text, false)
	local v17 = "FreedVirtueChoices"

	function v16.Callback()
		v5 = v17
		v6 = v16
	end

	local v18 = {
		Text = "/SF/Language/Quests/OrengallDialogueGraceResponse",
		SuccessState = true,
		Skill = 3,
		Attribute = 2
	}
	v18.Text = Localize(v18.Text, false)
	local v19 = "FreedVirtueChoices"

	function v18.Callback()
		v5 = v19
		v6 = v18
	end

	v4:SetChoices(nil)

	if _T.OrengallConversationStage < 2 then
		module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ConversationIntro"), object, true)
		v4:SetChoices({ v12 })
	elseif _T.OrengallConversationStage < 3 then
		v5 = "FreedOrengall"
	elseif _T.OrengallConversationStage < 4 then
		v5 = "FreedVirtueChoices"

		if _T.OrengallConversationAttribute then
			v6 = { Attribute = _T.OrengallConversationAttribute }
		end
	end

	while v4:Update() do
		if not __wf_atom_7e8ad928(v5) then
			if v5 == "FreedVirtueChoices" then
				v4:SetChoices(nil)
				v4:ChangeAffinity("2")
				_T.OrengallConversationStage = 3

				if v6.Attribute == 0 then
					module.PlayDialogMenuTransmission(
						npcTransmissionSet,
						Symbol("VirtueChoiceMadeCourage"),
						object,
						true
					)
				elseif v6.Attribute == 1 then
					module.PlayDialogMenuTransmission(
						npcTransmissionSet,
						Symbol("VirtueChoiceMadeSpirit"),
						object,
						true
					)
				else
					module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("VirtueChoiceMadeGrace"), object, true)
				end

				_T.OrengallConversationCompleted = true
				_T.OrengallConversationAttribute = v6.Attribute
				gGameData:__wf_atom_109e1c51(v6.Attribute, "OrengallQuest", "")
				break
			else
				if v5 == "FreedOrengall" then
					v4:SetChoices(nil)
					_T.OrengallConversationStage = 2
					module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ConversationResponse"), object, true)
					v4:SetChoices({ v14, v16, v18 })
				end

				v5 = nil
			end
		end

		Sleep(0)
	end

	v4:Close()

	if not __wf_atom_7e8ad928(v10) then
		v10:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		__wf_atom_7470861b:__wf_atom_63396172(v2)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_cf966a74(v)
		object:__wf_atom_dd875cd8(false)
	end

	module3.SetLocalPlayerReadyTag(WeakResource("/SF/Types/Quests/OmenBeastQuests/TheOmenOrengall"), "OrengalAmbush")
end