local v = nil
local v2 = nil
local v3 = nil
local v4 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v5 = Symbol("Invulnerable")
local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.ConversationLib")
local module3 = require("SF.Scripts.Libs.StatsLib")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module5 = require("Lotus.Scripts.Libs.AudioLib")

function AvakotHelpWiggle(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()

	while __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	local v6 = 0

	while not (__wf_atom_7e8ad928(_T.curTransmission) or __wf_atom_7e8ad928(object)) do
		object:PlaySound(avakotWiggleSound, false)

		while v6 < 1 and not __wf_atom_7e8ad928(object) do
			v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93(), 0, 1)
			local v7 = 1 - v6
			local v8 = Noise(5 + Time() * 1)
			local v9 = Noise(2 + Time() * 1)
			local v10 = Noise(5 + Time() * 1)
			object:SetPosition(position + Vector(v8 * 0, math.abs(v9) * v7 * 0.4, v10 * 0))
			object:__wf_atom_9b788a35(__wf_atom_dc309f8a + Rotation(v8 * 10 * v7, v9 * 20 * v7, v10 * 10 * v7))
			Sleep(0)
		end

		Sleep(0)
		v6 = 0
	end
end

function AvakotConversation(_, object)
	module3.ReplicateLogEvent("STAG_QUEST", "TalkToAvakot", "Midrath")

	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_8a035cd5(Symbol("DoConversation"), false)
	end
end

function DoConversation(object)
	_T.PausePatrols = true
	local v6 = Symbol("/SF/Language/Characters/Avakot")

	if not __wf_atom_7e8ad928(avakotMenuMusic) and __wf_atom_7e8ad928(v) then
		v = module5.PlaySound(avakotMenuMusic)
	end

	local v7 = { Text = "/SF/Language/Quests/StagQuestAvakotDialogueGetInfo" }
	v7.Text = Localize(v7.Text, false)
	local v8 = "GetInfo"

	function v7.Callback()
		v3 = v8
	end

	local v9 = { Text = "/SF/Language/Quests/LeaveShrine" }
	v9.Text = Localize(v9.Text, false)
	local v10 = "Close"

	function v9.Callback()
		v3 = v10
	end

	local v11 = { Text = "/SF/Language/Quests/StagQuestAvakotDialoguePayDracs" }
	v11.Text = Localize(v11.Text, false)
	local v12 = "PayDracs"

	function v11.Callback()
		v3 = v12
	end

	local v13 = {
		Text = "/SF/Language/Quests/StagQuestAvakotDialogueThreaten",
		SuccessState = false,
		Skill = 1,
		Disable = true
	}
	v13.Text = Localize(v13.Text, false)
	local v14 = "Threaten"

	function v13.Callback()
		v3 = v14
	end

	local v15 = {
		Text = "/SF/Language/Quests/StagQuestAvakotDialoguePersuade",
		SuccessState = true,
		Skill = 2
	}
	v15.Text = Localize(v15.Text, false)
	local v16 = "Persuade"

	function v15.Callback()
		v3 = v16
	end

	local v17 = {
		Text = "/SF/Language/Quests/StagQuestAvakotDialogueHumor",
		SuccessState = false,
		Skill = 3,
		Disable = true
	}
	v17.Text = Localize(v17.Text, false)
	local v18 = "Humor"

	function v17.Callback()
		v3 = v18
	end

	local v19 = { Text = "/SF/Language/Quests/StagQuestAvakotDialogueOdeAreAfterStag" }
	v19.Text = Localize(v19.Text, false)
	local v20 = "OdeAreAfterStag"

	function v19.Callback()
		v3 = v20
	end

	local v21 = { Text = "/SF/Language/Quests/StagQuestAvakotDialogueNeedAKerchief" }
	v21.Text = Localize(v21.Text, false)
	local v22 = "NeedAKerchief"

	function v21.Callback()
		v3 = v22
	end

	local v23 = { Text = "/SF/Language/Quests/StagQuestAvakotDialogueAvakotStory" }
	v23.Text = Localize(v23.Text, false)
	local v24 = "AvakotStory"

	function v23.Callback()
		v3 = v24
	end

	local v25 = { Text = "/SF/Language/Quests/StagQuestAvakotDialogueGiveTalkyOdeThing" }
	v25.Text = Localize(v25.Text, false)
	local v26 = "GiveTalkyOdeThing"

	function v25.Callback()
		v3 = v26
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_7470861b:__wf_atom_9fba31e6(v5, 26, 6, 0)
	object:__wf_atom_dd875cd8(true)
	object:__wf_atom_aeb02c14(v4)
	__wf_atom_d2b2176d:Unequip(0, 0)

	if __wf_atom_7e8ad928(_T.AvakotMenuStage) then
		_T.AvakotMenuStage = 1
		module.CloseTransmissions()
		avakotNpc:__wf_atom_d927a2a4(avakotTalkIdleAnim)
		module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("PopUp"), object, false, 60)
		Sleep(1.5)
	end

	v2 = module2.CreateConversation(Localize(tostring(v6), false), avakotCameraSpot)
	v2:Start()
	v2:SetChoices(nil)
	v2:AllowExit(false)
	_T.AvakotTalking = true
	module.WaitForTransmissions(true, nil, true)
	_T.AvakotTalking = false
	avakotNpc:__wf_atom_d927a2a4(avakotIdleAnim)
	v2:SetChoices(({
		{ v7, v9 },
		{ v11, v13, v15, v17 },
		{ v19, v21, v23, v25 }
	})[_T.AvakotMenuStage])

	while v2:Update() do
		if not __wf_atom_7e8ad928(v3) then
			_T.AvakotTalking = true
			v2:SetChoices(nil)
			avakotNpc:__wf_atom_d927a2a4(avakotTalkIdleAnim)

			if v3 == "Close" then
				if math.random() <= 0.5 then
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("Sneeze"), object, true, 60)
				end

				break
			else
				if v3 == "GetInfo" then
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("WhatDoYouKnow"), object, true, 60)
					v2:SetChoices({ v11, v13, v15, v17 })
					_T.AvakotMenuStage = 2
				elseif v3 == "PayDracs" or v3 == "Persuade" then
					local v27 = Symbol("PayedDracs")
					local v28

					if v3 == "Persuade" then
						v27 = Symbol("SuccessPersuade")
						v28 = "1.5"
					else
						v28 = "0.3"
					end

					v2:ChangeAffinity(v28)
					module.PlayDialogMenuTransmission(avakotTransmissionSet, v27, object, true, 60)
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("GladeInfo"), object, true, 60)
					avakotNpc:__wf_atom_d927a2a4(avakotIdleAnim)
					v2:SetChoices({ v19, v21, v23, v25 })
					_T.AvakotMenuStage = 3
				elseif v3 == "OdeAreAfterStag" then
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("OdeStag"), object, true, 60)
					v2:SetChoices({ v19, v21, v23, v25 })
				elseif v3 == "NeedAKerchief" then
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("Kerchief"), object, true, 60)
					v2:SetChoices({ v19, v21, v23, v25 })
				elseif v3 == "AvakotStory" then
					v2:ChangeAffinity(1)
					module.PlayDialogMenuTransmission(avakotTransmissionSet, Symbol("AvakotStory"), object, true, 60)
					v2:SetChoices({ v19, v21, v23, v25 })
				elseif v3 == "GiveTalkyOdeThing" then
					v2:Close()
					module3.ReplicateLogEvent("STAG_QUEST", "EndTalkToAvakot", "Midrath")
				end

				avakotNpc:__wf_atom_d927a2a4(avakotIdleAnim)
				_T.AvakotTalking = false
				v3 = nil
			end
		end

		Sleep(0)
	end

	v2:Close()

	if not __wf_atom_7e8ad928(v) then
		v:Stop(false)
	end

	if _T.AvakotMenuStage == 3 and not _T.GotOdeItem and gRegion:IsMaster() then
		Sleep(0)

		while module.TransmissionPlaying() do
			Sleep(0)
		end

		_T.AvakotTalking = true
		module4.PlayCinematicWithTagAndWait(Symbol("AvakotHandOffCin"))
		_T.AvakotTalking = false
		_T.GotOdeItem = true
	end

	__wf_atom_7470861b:__wf_atom_63396172(v5)
	avakotNpc:__wf_atom_d927a2a4(avakotIdleAnim)
	object:__wf_atom_cf966a74(v4)
	object:__wf_atom_dd875cd8(false)
	_T.ForceDialogClose = nil
	_T.AvakotTalking = nil
	_T.PausePatrols = false
	_T.TriggerSproutfolkDialog = true
end

function AvakotInUnderCity()
	Sleep(3)
	module.PlayGlobalTransmission(avakotTransmissionSet, Symbol("Psst"), true)
	module.PlayGlobalTransmission(avakotTransmissionSet, Symbol("OiLeggy"), true)
	module.PlayGlobalTransmission(avakotTransmissionSet, Symbol("SneezeReveal"))
	avakotNpc:PlayTriggeredAnim(Symbol("Sneeze"))
	avakotNpc:__wf_atom_d927a2a4(avakotIdleAnim)
end

function AvakotInUnderCityInteract(object, object2)
	if not gRegion:IsMaster() then
		return
	end

	module3.ReplicateLogEvent("STAG_QUEST", "TalkToAvakot", "UnderCity")
	object:Disable()
	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(v5, 26, 6, 0)
	object2:__wf_atom_dd875cd8(true)

	if not __wf_atom_7e8ad928(avakotLight) then
		avakotLight:FirePort("TurnOn")
	end

	local cameraControl = object2:__wf_atom_a96eb2aa():CameraControl()
	cameraControl:SetCameraSpot(avakotCameraSpot)
	object2:__wf_atom_aeb02c14(v4)
	Sleep(0.25)
	avakotNpc:__wf_atom_d927a2a4(avakotTalkIdleAnim)
	module.PlayGlobalTransmission(avakotTransmissionSet, Symbol("AvakotUnderCity"), true)
	avakotNpc:PlayTriggeredAnim(Symbol("IntoShell"))
	avakotNpc:__wf_atom_d927a2a4(avakotShellIdleAnim)
	cameraControl:SetCameraSpot(nil)
	object2:__wf_atom_cf966a74(v4)
	__wf_atom_7470861b:__wf_atom_63396172(v5)
	object2:__wf_atom_dd875cd8(false)

	if not __wf_atom_7e8ad928(avakotLight) then
		avakotLight:FirePort("TurnOff")
	end

	_T.TalkedToAvakotInUndercity = true
	Sleep(1.5)
	module.PlayGlobalTransmission(avakotTransmissionSet, Symbol("AvakotUnderCityDepart"), true)
end

function AvakotAnims(p)
	Sleep(2)
	local v6 = Symbol("Sneeze")
	local v7 = Symbol("Sniffle")
	gRegion:__wf_atom_ef7900cf()
	local v8 = 0
	local flag = nil

	while
		not _T.AvakotTalking
		and not __wf_atom_7e8ad928(cageDeco)
		and cageDeco:__wf_atom_c6f1f83d() > 0
		and not __wf_atom_7e8ad928(avakotNpc)
	do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		if v8 <= 0 then
			for _, v9 in ipairs(__wf_atom_ef7900cf) do
				if __wf_atom_7e8ad928(v9) or not (v9:__wf_atom_1c8f7b2d(p) <= 20) then
					continue
				end

				module.PlayLocalTransmission(avakotTransmissionSet, Symbol("HelpMe"), v9)
				flag = true
			end
		end

		if flag then
			AvakotHelpWiggle(cageDeco)
			v8 = 10
			flag = false
		end

		v8 -= 1
		Sleep(1)
	end

	while __wf_atom_7e8ad928(_T.AvakotMenuStage) or _T.AvakotMenuStage < 2 and not __wf_atom_7e8ad928(avakotNpc) do
		Sleep(0)
	end

	while not (_T.UnderCityStarted or __wf_atom_7e8ad928(avakotNpc)) do
		if _T.AvakotTalking then
			Sleep(1)
		else
			if math.random() <= 0.2 then
				avakotNpc:PlayTriggeredAnim(v6)
			elseif math.random() <= 0.4 then
				avakotNpc:PlayTriggeredAnim(v7)
			end

			Sleep(3 + math.random() * 3)
		end
	end

	print("Avakot anims ended")
end

function OrlickInTent()
	if _T.TriggerSproutfolkDialog then
		scriptTrigger:FirePort("Execute")
		_T.TriggerSproutfolkDialog = nil
	end
end