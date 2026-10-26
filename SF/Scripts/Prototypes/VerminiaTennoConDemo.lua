local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ConversationLib")
local module4 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local module7 = require("SF.Scripts.Libs.QuestLib")
local v = nil
local v2 = nil
local v3 = true
local flag = false
local v4 = nil
local flag2 = false
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest")
local v14 = WeakResource("/SF/Levels/BromiusQuestIntro.level")
local v15 = false
local v16 = WeakResource("/SF/Interface/ColourCustomization.swf")
local v17 = WeakResource("/SF/Interface/Foundry.swf")
local v18 = Symbol("FaceLights")

function SlidePlayer()
	local playerDialougePosition = playerDialougePosition
	module3.MovePlayerToPosition(v12, playerDialougePosition)
end

local function fn(p)
	local cameraControl = v12:CameraControl()

	if __wf_atom_7e8ad928(fashionCameraSpotInstance) then
		fashionCameraSpotInstance = gRegion:__wf_atom_f738b4af(Symbol("FashionCamera"), v12:__wf_atom_8992aa91(), 0, 5)
	end

	local localPlayerAncestorOfType = module4.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)
	local v19 = not __wf_atom_7e8ad928(localPlayerAncestorOfType) and localPlayerAncestorOfType.mRank == -1
	_T.VendorDialougCamera = fashionCameraSpotInstance

	if not __wf_atom_7e8ad928(musicLoop) and v4 == nil and not p then
		v4 = module5.PlaySound(musicLoop)
	end

	if v19 then
		gGameData:RankUpAncestor(localPlayerAncestorOfType.mType, "OnAncestorCallback")

		if _T.VerminiaQuest_PlayBromiusCin == nil then
			_T.VerminiaQuest_PlayBromiusCin = true
		end

		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
			Symbol("SparrowPerchPoint"),
			v12:__wf_atom_a2a18137(),
			0,
			10
		)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			module6.RemoveSparrowDestination(__wf_atom_f738b4af)
		end
	elseif not p then
		module.PlayLocalTransmission(
			verminiaTransmissionSet,
			vendorGreetingTransmissionTag,
			gRegion:__wf_atom_c4f78a8f(),
			false
		)
	end

	if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(fashionCameraSpotInstance)) then
		cameraControl:SetCameraSpot(fashionCameraSpotInstance, 1.5)
		cameraControl:__wf_atom_fd14c463(0.7)
		fashionCameraSpotInstance:__wf_atom_802e6d6a(99999)
		gRegion:__wf_atom_0a6a5887(Symbol("VerminiaTalkAction"))
		v12:EnableFootIK(false)
		fashionCameraSpotInstance:Activate()
	end
end

local function fn2(p)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v18, v12:GetPosition(), 0, 5)

	if not __wf_atom_7e8ad928(__wf_atom_439c0d29) then
		for _, v19 in __wf_atom_439c0d29 do
			if p then
				v19:TurnOn()
			else
				v19:TurnOff()
			end
		end
	end
end

local function fn3(p)
	if __wf_atom_7e8ad928(v12) then
		return
	end

	local cameraControl = v12:CameraControl()

	if __wf_atom_7e8ad928(fashionCameraSpotInstance) then
		fashionCameraSpotInstance = gRegion:__wf_atom_f738b4af(Symbol("FashionCamera"), v12:__wf_atom_8992aa91(), 0, 5)
	end

	local __wf_atom_2f2bada0 = fashionCameraSpotInstance:__wf_atom_2f2bada0()
	v12:__wf_atom_51075230(__wf_atom_2f2bada0)

	if not cameraControl:__wf_atom_c8c5ba0a() then
		cameraControl:__wf_atom_fd14c463(0.7)
	end

	cameraControl:SetCameraSpot(nil, 0.7)

	if __wf_atom_7e8ad928(v12) then
		return
	end

	v12:EnableFootIK(true)

	if not (flag or p) then
		module.PlayLocalTransmission(verminiaTransmissionSet, vendorLeaveTransmissionTag, v12, false)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end

	fn2(false)
end

function BromiusCin(p)
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if __wf_atom_7e8ad928(p) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(p, mixEffect, mixingGroup)
	end

	Symbol("BromiusIntroCin")
	module2.StreamAndPlayCinematicLevel(v14, false, false, 0, 0)

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end
end

function BromiusCinEnd(object)
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(object, mixEffect, mixingGroup)
	end

	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(fashionCameraSpotInstance) then
		fashionCameraSpotInstance = gRegion:__wf_atom_0a6a5887(Symbol("FashionCamera"))
	end

	object:__wf_atom_51075230((fashionCameraSpotInstance:__wf_atom_2f2bada0()))

	if not cameraControl:__wf_atom_c8c5ba0a() then
		cameraControl:__wf_atom_fd14c463(0.7)
	end

	Sleep(3)
	cameraControl:SetCameraSpot(nil, 0.7)
	module2.Fade(false, 0, 1)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GladesGateOpen"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:FirePort("TriggerPort")
end

local function fn4(p)
	module.CloseTransmissions()

	if not module2.PlayCinematicWithTagAndWait(Symbol("WarningPoem"), false, p) then
		return
	end

	BromiusCin(p)
	BromiusCinEnd(p)
	_T.ProgressionScreenDisabled = nil
end

function OnAncestorCallback()
	v3 = true
end

local function fn5(mConvoMovie, vendorAncestorRes)
	local v19 = {
		mMovie = mConvoMovie,
		mLabel = Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), {}),
		mOverwriteCurrencies = true,
		mMinWidth = 525,
		mLevel = module4.GetAncestorRank(vendorAncestorRes) + 1
	}
	local v20 = not (v19.mLevel > 1) and 0 or vendorAncestorRes:__wf_atom_071f014c(v19.mLevel - 1)
	local v21 = vendorAncestorRes:__wf_atom_071f014c(v19.mLevel) - v20
	local v22 = module4.GetAncestorXP(vendorAncestorRes) - v20
	v19.mRankProgress = __wf_atom_421b01aa(v22 / v21, 0, 1) * 100

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v19)
	end
end

function Initialize(_, p)
	v12 = p
	v = module4.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)

	if not __wf_atom_7e8ad928(v) and (v.mRank == -1 or v.mRank == 0) then
		module4.StartAncestorRankUps(p, vendorAncestorRes, nil)
	end

	local questIsActive = module7.QuestIsActive(v13)

	if not (module7.HasCompletedQuest(v13) or questIsActive) then
		flag = true
	end

	fn()
	fn2(true)
	v6 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
	v6:Start()
	fn5(v6.mConvoMovie, vendorAncestorRes)
	local v19 = { Text = "/SF/Language/Characters/VerminiaConvo_CustomizeCharacter" }
	v19.Text = Localize(v19.Text, false)
	v19.Tag = "CustomizeCharacter"
	local v20 = "CustomizeCharacter"

	function v19.Callback()
		v7 = v20
	end

	local v21 = { Text = "/SF/Language/Characters/VerminiaConvo_OpenBestitching" }
	v21.Text = Localize(v21.Text, false)
	v21.Tag = "Bestitch"
	local v22 = "Bestitch"

	function v21.Callback()
		v7 = v22
	end

	local v23 = { Text = "/SF/Language/Characters/VerminiaConvo_OpenFoundry" }
	v23.Text = Localize(v23.Text, false)
	v23.Tag = "BrewPotion"
	local v24 = "BrewPotion"

	function v23.Callback()
		v7 = v24
	end

	local v25 = { Text = "/SF/Language/Characters/Goodbye" }
	v25.Text = Localize(v25.Text, false)
	v25.Tag = "Exit"
	local v26 = "Exit"

	function v25.Callback()
		v7 = v26
	end

	v6:SetChoices({ v21, v19, v23, v25 })
	v6:SetBackChoice("Exit")

	while v6:Update() do
		if not __wf_atom_7e8ad928(v7) then
			if v7 == "BrewPotion" then
				OpenCraftingMovie()
				v6:Close(true)

				while not __wf_atom_7e8ad928(v8) do
					Sleep(0)
				end

				v6 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
				v6:UseCursorSnapping(false)
				v6:Start()
				v6:SetChoices({ v21, v19, v23, v25 })
				v6:SetBackChoice("Exit")
				fn(true)
				fn5(v6.mConvoMovie, vendorAncestorRes)
			elseif v7 == "CustomizeCharacter" then
				_T.Customization_InitialState = "Character"
				OpenColorCustomization()
				v6:Close(true)

				while not __wf_atom_7e8ad928(v8) do
					Sleep(0)
				end

				v6 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
				v6:UseCursorSnapping(false)
				v6:Start()
				v6:SetChoices({ v21, v19, v23, v25 })
				v6:SetBackChoice("Exit")
				fn(true)
				fn5(v6.mConvoMovie, vendorAncestorRes)
			elseif v7 == "Bestitch" then
				_T.Customization_InitialState = "Bestitch"
				OpenColorCustomization()
				v6:Close(true)

				while not __wf_atom_7e8ad928(v8) do
					Sleep(0)
				end

				v6 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
				v6:UseCursorSnapping(false)
				v6:Start()
				v6:SetChoices({ v21, v19, v23, v25 })
				v6:SetBackChoice("Exit")
				fn(true)
				fn5(v6.mConvoMovie, vendorAncestorRes)
			elseif v7 == "Exit" then
				v6:Close(true)
				break
			end

			v7 = nil
		end

		Sleep(0)
	end

	_T.OrlickIMGUI = nil
	fn3()

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(v6.mConvoMovie)
	end

	while flag2 == false do
		if __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(verminiaNPC) then
			break
		end

		if __wf_atom_7e8ad928(v5) and not v15 then
			if not __wf_atom_7e8ad928(_T.SetButtons) then
				_T.SetButtons(_T.BackgroundMovie, nil)
			end

			v12:CameraControl():SetCameraSpot(nil, 0.7)
			Close()
			break
		else
			Sleep(0)
		end
	end
end

function ShowParticleEffect()
	if __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(swapFXSpawner) or __wf_atom_7e8ad928(v2) then
		return
	end

	v9 = v12:Attach(swapFXSpawner, EMPTY_SYMBOL)
	Sleep(0)
	v10 = v12:__wf_atom_f582136d(smokeFXType)
	v11 = #v10 > 0 and v10[#v10] or nil

	if not __wf_atom_7e8ad928(v11) then
		v11:__wf_atom_8cd234d5(v2, v2)
	end
end

function OnColorChange(p)
	if __wf_atom_7e8ad928(v12) then
		return
	end

	v2 = p
	v12:__wf_atom_8a035cd5(Symbol("ShowParticleEffect"), false)
end

function OpenColorCustomization()
	if gGameRules:__wf_atom_3aa103d3() then
		flag2 = true
		return
	end

	_T.ColorCustomization_OnColorChange = OnColorChange
	v15 = true
	v8 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v16)
end

function OpenCraftingMovie()
	_T.Foundry_Ancestor = vendorAncestorRes
	_T.Foundry_AllowReforge = false
	_T.Foundry_IgnoreReforgeBlueprintRank = true
	_T.Foundry_NPC = "Verminia"
	v8 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v17)
end

function OnVerminiaMovieLoaded(p)
	v5 = p
	v15 = false

	if not __wf_atom_7e8ad928(v5) then
		return
	end

	Close()
end

function Close()
	if flag2 then
		return
	end

	flag2 = true

	if not __wf_atom_7e8ad928(v5) then
		v5:Close()
	end

	if __wf_atom_7e8ad928(_T.SuppressSounds) then
		module5.PlaySound(closeSound)
	end

	Sleep(0)

	if flag then
		fn4(v12)
	else
		fn3()
	end
end