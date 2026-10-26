local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Interface.Libs.MusicCommon")
local module4 = require("SF.Scripts.Libs.ConversationLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.NightFoldLib")
local module7 = require("EE.Interface.Utilities")
local module8 = require("Lotus.Scripts.Libs.StoryLib")
local module9 = require("SF.Scripts.Libs.StatsLib")
local module10 = require("SF.Scripts.Libs.QuestLib")
local module11 = require("Lotus.Scripts.Libs.AudioLib")
local module12 = require("Lotus.Interface.LotusUtilities")
WeakResource("/SF/Characters/PlayerCharacters/Hair/ArtStationTest/Cloth/MiddleHairBCloth")
Type("/SF/Characters/PlayerCharacters/Hair/ArtStationTest/Cloth/ForgetFireHairBSkelClothEx")
Type("/SF/Characters/PlayerCharacters/Hair/ArtStationTest/Cloth/MiddleHairBClothInverted")
local v = false
local flag = true
local bromiusBondDiorama2 = nil
local taskID = nil
local v2 = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest")

local function fn(p)
	for _, v3 in lights do
		if p then
			v3:TurnOn()
		else
			v3:TurnOff()
		end
	end
end

local function fn2(p, object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		if v3:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v3, Symbol("Envoy"))
			end
		else
			v3:__wf_atom_a7ee9662(p, true)
		end
	end
end

local function fn3(p) -- 1 equivalent call inferred from this helper
	for _, v3 in pairs(deorations) do
		v3:SetVisibility(p)
	end
end

function PrepairBromuisAwakenCine(p)
	fn3(true) -- inferred equivalent call
	fn(true)
	fn2(false, p)

	if not __wf_atom_7e8ad928(introStingerSound) then
		module7.PlaySound(introStingerSound)
	end
end

function HideAvatarActors()
	for _, v3 in avatarTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			break
		else
			__wf_atom_0a6a5887:SetVisibility(false)
		end
	end
end

function RestoreAvatarLocalVis()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		if not v3:__wf_atom_4417a5d4() then
			v3:__wf_atom_a7ee9662(true, true)
		end
	end
end

function OnSaveLoadOutComplete(_, _)
	module12.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	module12.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
	v = true
end

local function fn4()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FloppetTummyTrigger"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(bromiusTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	__wf_atom_0a6a5887:__wf_atom_dc5956fc(__wf_atom_0a6a5887_2, headBone)
end

function PlaydialougeLine()
	Sleep(delay)
	module.PlayGlobalTransmission(transmissionSet, transmissionTag)
end

local function fn5(object)
	local v3 = {
		__wf_atom_7b01f9ce,
		__wf_atom_d127f143,
		__wf_atom_43e0c427,
		__wf_atom_3feeb44a,
		__wf_atom_4ebf67cb
	}
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	__wf_atom_4e50d390.bank = 0
	local v4 = 1 - __wf_atom_421b01aa(math.abs(__wf_atom_4e50d390.pitch / 90), 0, 1)
	local v5 = birdSummonOffset.z * v4
	local v6 = birdSummonOffset.y * v4
	local selected = object:EyePosition() + __wf_atom_9341614d(Vector(birdSummonOffset.x, v6, v5), __wf_atom_4e50d390)
	local v7 = Vector()

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_fbb89790(object:EyePosition(), selected, 0.2, nil, v3, nil, v7))) then
		selected = v7
	end

	selected.y = object:EyePosition().y
	return selected
end

function SwitchToBird()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local cameraControl = __wf_atom_c4f78a8f:CameraControl()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(bromiusTag)

	if not __wf_atom_0a6a5887:IsVisible() then
		__wf_atom_0a6a5887:SetVisibility(true)
	end

	fn4()
	module2.AttunateFovOverTime(cameraControl, fovInTime, fovAtten)

	if gRegion:IsMaster() then
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("WaitForDialouge"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput),
			_CalloutPressed
		)
		module2.BlockAbilities(true)

		if not __wf_atom_7e8ad928(_T.ShowImpactMessage) then
			_T.ShowImpactMessage("/SF/Language/Tutorial/SummonFloppet", -1)
		end

		while flag do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(_T.ShowImpactMessage) then
			_T.HideImpactMessage()
		end

		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("WaitForDialouge"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput)
		)
		__wf_atom_c4f78a8f:__wf_atom_921c1a5f(SummonBirdAnim, false, 4, 1, false)
		__wf_atom_c4f78a8f:__wf_atom_8914dfde("SFXFloppetLaunch", 4)
		Sleep(0.1)
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			return
		end

		local v3 = __wf_atom_3c8e1a7a[1]
		__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
		local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
		local entity = gRegion:CreateEntity(
			floppetType,
			fn5(__wf_atom_c4f78a8f),
			__wf_atom_4e50d390,
			__wf_atom_c4f78a8f
		)
		entity:SetDisableGravity(true)
		entity:__wf_atom_6a95c7b8(__wf_atom_c4f78a8f)
		__wf_atom_c4f78a8f:__wf_atom_8914dfde("SummonBird", 4)
		entity:SetDisableGravity(false)
		entity:__wf_atom_f0f9fb38(__wf_atom_c4f78a8f:__wf_atom_4e50d390())
		entity:__wf_atom_7c2670d6()
		Sleep(swapTransitionDelay)
		local gameCamera = gRegion:GetGameCamera()

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:CameraControl())) then
			__wf_atom_c4f78a8f:CameraControl():__wf_atom_4efcb2f5(gameCamera, cameraTransitionTIme)
		end

		module2.BlockAbilities(false)
		v3:__wf_atom_6c552f4c(9, entity)
		v3:AssignAvatar(entity, true, false)
	end
end

function TransitionToInsideBromius()
	module2.Fade(true, 0, 1)
	Sleep(0.75)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FloppetBromiusStart"))

	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) or not __wf_atom_ef7900cf[i]:IsA(floppetType) then
				continue
			end

			__wf_atom_ef7900cf[i]:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
		end
	end
end

function RevealBromiusInsides()
	module2.Fade(false, 0.5)
end

function SwitchToPlayer()
	module2.Fade(true, 0.3, -1, true)

	if gRegion:IsMaster() then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for i = 1, #__wf_atom_3c8e1a7a do
			local v3 = __wf_atom_3c8e1a7a[i]
			local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

			if not __wf_atom_50a7d83e:__wf_atom_4417a5d4() then
				continue
			end

			v3:AssignAvatar((v3:GetPlayerAvatar(0)))
			__wf_atom_50a7d83e:Destroy()
		end

		_T.FloppetFlightCompleted = true
	end
end

function SwapBromiusDecos()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusMidCorruptionFightDeco"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CorruptedBromius"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		print("BromiusFight: Cannot find BromiusDeco in Cinematic level")
	elseif swapToAvatar then
		__wf_atom_0a6a5887:SetVisibility(false)
		__wf_atom_0a6a5887_2:SetVisibility(true)
		__wf_atom_0a6a5887_2:__wf_atom_30964595(true)
		__wf_atom_0a6a5887_2:__wf_atom_78ad8b9f(128, 1)
	else
		__wf_atom_0a6a5887:SetVisibility(true)
		__wf_atom_0a6a5887:SetMeshScale(2, true)
		__wf_atom_0a6a5887_2:SetVisibility(false)
		__wf_atom_0a6a5887_2:__wf_atom_30964595(false)
	end
end

function LoopHaningIntro(object)
	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
		Symbol("WaitForDialouge"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput),
		_CalloutPressed
	)

	for _, v3 in transmissions do
		while flag do
			Sleep(0)
		end

		module.PlayGlobalTransmission(transmissionSet, v3, false)
		Sleep(transmissionDelay)
	end

	gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
		Symbol("WaitForDialouge"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput)
	)
	object:__wf_atom_398939a1()
end

function _CalloutPressed()
	flag = false
end

function TransitionToSilvernSea(object)
	module2.Fade(true)

	while object:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_aeb02c14(blockMovementInputFilter)
	end

	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(gRegion) then
			module9.TrackExitLevel(
				WeakResource("/SF/Levels/Procs/Neathuns/NeathunsBromiusQuest"),
				gRegion:__wf_atom_22941262(),
				"teleport"
			)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusArenaStreamTrigger"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
		end
	end

	Sleep(2)

	if gClient:IsStreamingLevel() then
		return
	end

	module2.Fade(false)

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	__wf_atom_c4f78a8f:__wf_atom_cf966a74(blockMovementInputFilter)
end

function OnStreamingToMidrathCompleted()
	module2.Fade(true, 0)

	while Game.__wf_atom_2b221245() or gRegion:__wf_atom_83b2f434() do
		Sleep(0)
	end

	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PlayerSPTeleportLoc"))

		for i = 1, #__wf_atom_ef7900cf do
			if not __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				__wf_atom_ef7900cf[i]:Teleport(
					__wf_atom_2226b35c[i]:GetPosition(),
					__wf_atom_2226b35c[i]:__wf_atom_dc309f8a()
				)
			end
		end

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			__wf_atom_ef7900cf[i]:MotionControl():__wf_atom_99fc7a82(false)
			__wf_atom_ef7900cf[i]:CameraControl():__wf_atom_25382a0d(1, false)
		end
	end

	Sleep(1)
	module2.Fade(false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(blockMovementInputFilter)
	end
end

function AvatarPlayInstrument(p)
	module3.AvatarPlayInstrument(p, plantAcornCineTag, instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end

function BromiusSoulSong(instance, object)
	_T.MusicGameMidiOverride = songMidiData
	_T.MusicGameSuccessSoundOverride = successSoundOverride
	_T.SpiritChestMusicGame = true
	_T.BromiusSoulSongFinished = false
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SaveBromiusCin"))

	if object:__wf_atom_8efce136() then
		module6.RegisterPreventNighfoldUsage(true)
		module2.UnequipWeapon(object, true)
		module2.SetImmunity(object, true)
		_T.BromiusSoulSong = true
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)

		if gRegion:IsMaster() then
			if instance:IsA(__wf_atom_8b8e8b22) then
				instance:Disable()
			end

			if not __wf_atom_7e8ad928(object) then
				__wf_atom_0a6a5887:SetInstigatorAvatar(object)
			end

			if not __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
				__wf_atom_0a6a5887:FirePort("StartPlaying")
			end

			while not __wf_atom_7e8ad928(object) and object:__wf_atom_0473b7a9() do
				Sleep(0)
			end
		else
			while not __wf_atom_7e8ad928(object) and not object:IsKilled() and object:__wf_atom_0473b7a9() do
				Sleep(0)
			end
		end

		_T.BromiusSoulSong = false

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
			module2.SetImmunity(object, false)

			if object:__wf_atom_8161e6ba().mSuccess then
				_T.BromiusSoulSongFinished = true
				TeleportToCouncil()
				module6.RegisterPreventNighfoldUsage(false)
			elseif gRegion:IsMaster() and instance:IsA(__wf_atom_8b8e8b22) then
				instance:Enable()
			end
		end
	elseif gRegion:IsMaster() then
		if instance:IsA(__wf_atom_8b8e8b22) then
			if not instance:IsEnabled() then
				return
			end

			instance:Disable()
		end

		if not __wf_atom_7e8ad928(object) then
			__wf_atom_0a6a5887:SetInstigatorAvatar(object)
		end

		if not __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			__wf_atom_0a6a5887:FirePort("StartPlaying")
		end

		local __wf_atom_239dd8f4 = __wf_atom_0a6a5887:__wf_atom_239dd8f4()
		local v3 = false

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) do
			if v3 then
				if not object:__wf_atom_0473b7a9() then
					break
				end
			else
				v3 = object:__wf_atom_0473b7a9() and true or v3
			end

			if __wf_atom_239dd8f4 <= 0 then
				__wf_atom_239dd8f4 = __wf_atom_0a6a5887:__wf_atom_239dd8f4()
			end

			if __wf_atom_0a6a5887:__wf_atom_1ee2a2df() >= 0.2 then
				__wf_atom_0a6a5887:__wf_atom_01142e3f(0.2)
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:__wf_atom_01142e3f(-1)
			__wf_atom_0a6a5887:__wf_atom_3b451945(__wf_atom_239dd8f4)
		end

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		if object:__wf_atom_8161e6ba().mSuccess then
			gRegion:__wf_atom_c4f78a8f()
			_T.BromiusSoulSongFinished = true
			TeleportToCouncil()
			module6.RegisterPreventNighfoldUsage(false)
		elseif instance:IsA(__wf_atom_8b8e8b22) then
			instance:Enable()
		end
	end
end

function TeleportToCouncil()
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("BromisFinalConvoTp"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TreeGrowthCine"))

	if __wf_atom_7e8ad928(__wf_atom_2226b35c) or __wf_atom_2226b35c == 0 then
		return
	end

	for i = 1, #__wf_atom_ef7900cf do
		if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
			continue
		end

		__wf_atom_ef7900cf[i]:MotionControl():__wf_atom_99fc7a82(false)
		__wf_atom_ef7900cf[i]:CameraControl():__wf_atom_25382a0d(1, false)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusEndCinJugPlacement"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusJugCineDeco"))
	__wf_atom_0a6a5887_3:SetPosition(__wf_atom_0a6a5887_2:GetPosition())
	__wf_atom_0a6a5887_3:__wf_atom_9b788a35(__wf_atom_0a6a5887_2:__wf_atom_dc309f8a())
	__wf_atom_0a6a5887_3:SetVisibility(true)
	__wf_atom_0a6a5887_3:__wf_atom_25c58c94(false, true)
	Sleep(0)
	__wf_atom_0a6a5887_3:__wf_atom_25c58c94(true)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end

	while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	for i = 1, #__wf_atom_ef7900cf do
		if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
			continue
		end

		__wf_atom_ef7900cf[i]:Teleport(__wf_atom_2226b35c[i]:GetPosition(), __wf_atom_2226b35c[i]:__wf_atom_dc309f8a())
		__wf_atom_ef7900cf[i]:__wf_atom_e25a34ac(false)
	end

	module10.CompleteTaskWithTag(Resource(activeQuest), Symbol("6-SilvernSea"))
end

function ShowDiorama()
	module8.PlayCinematic(bromiusBondDiorama2, nil, false, true, nil, 1)
end

function SlidePlayer()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusConvoWP"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module4.SlidePlayer(__wf_atom_c4f78a8f, __wf_atom_0a6a5887, 0.5)
	end
end

function BondWithBromius(object, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	module2.TaggedFirePorts(Symbol("BromiusApproachAcornsPlantedFlare"), "Disable")
	object2:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.TaskID then
		taskID = __wf_atom_e919fb8e.TaskID
	end

	module5.SetSparrowMode(nil)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Unequip(0, 0)

		while not __wf_atom_7e8ad928(object2) and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
			Sleep(0)
		end
	end

	fn2(false)
	module2.TaggedFirePorts(Symbol("BromiusFinalConvo"), "Execute")
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(object2, mixEffect, mixingGroup)
	end

	while not _T.BromiusConversationCOmpleted or __wf_atom_7e8ad928(_T.BromiusConversationCOmpleted) do
		Sleep(0)
	end

	object:__wf_atom_e95c24e1(object2:__wf_atom_a96eb2aa())

	if not __wf_atom_7e8ad928(taskID) then
		local v3 = false

		while not module10.AllPlayersReady(v2, Symbol(taskID)) do
			Sleep(0)

			if __wf_atom_7e8ad928(_T.ShowImpactMessage) or v3 then
				continue
			end

			_T.ShowImpactMessage(
				Localize("/SF/Language/Quests/BromiusQuestTitle", false) .. " - " .. Localize(
					"/SF/Language/Quests/WaitingForOtherPlayers",
					false
				),
				-1
			)
			v3 = true
		end
	end

	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end

	module2.TaggedFirePorts(Symbol("BromiusTreeHealingCinSetup"), "TriggerPort")
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	object:Disable()
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_c9fc989f)
	local v3 = Symbol("Bromius")

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_bb3e7833:__wf_atom_a3d2b66b(object2, Symbol("Envoy"))
			__wf_atom_bb3e7833:__wf_atom_a3d2b66b(__wf_atom_3d96ddcd, v3)
			__wf_atom_bb3e7833:StartRelative(
				v3,
				__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
				__wf_atom_3d96ddcd:__wf_atom_dc309f8a()
			)
		end

		module11.EnableTaggedSequencers(Symbol("PlantSeedsMusic"), false)
		__wf_atom_b3845a20:__wf_atom_64d1f332(object2, mixEffect, mixingGroup)
		fn2(false, __wf_atom_bb3e7833)

		while not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		fn2(true, __wf_atom_bb3e7833)
	end

	_T.StoryLib_SkipFadeOnExit = true
	_T.StoryLib_SkipClearFade = true
	__wf_atom_3d96ddcd:SetVisibility(false)
	bromiusBondDiorama2 = bromiusBondDiorama

	if __wf_atom_7e8ad928(object2) then
		object:Enable()
		__wf_atom_3d96ddcd:SetVisibility(true)
	else
		object2:__wf_atom_8a035cd5(Symbol("ShowDiorama"), false)
		_T.AutoCloseEndCard = true

		while __wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8()) do
			Sleep(0)
		end

		while not __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8()) do
			Sleep(0)
		end

		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)

		while __wf_atom_8e4fda44:__wf_atom_6b69b901(WeakResource("/SF/Interface/EndCard.swf")) do
			Sleep(0)
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_e25a34ac(false)
		end

		if gRegion:IsMaster() then
			module10.CompleteTaskWithTag(Resource(v2), Symbol("7-PlantWevetSeeds"))
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusJugPort"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:FirePort("TriggerPort")
		end

		module10.WakeUpInNightFold(
			5,
			nil,
			nil,
			true,
			{ Label = "/SF/Language/Quests/BromiusQuestCompletedProgression", CacheIndex = 1 },
			Symbol("FloppetSplitCine")
		)
	end
end

function forceQuipTempItem()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	__wf_atom_c4f78a8f:__wf_atom_a96eb2aa():__wf_atom_36b99b9d(itemToEquip, 1)
	__wf_atom_d2b2176d:__wf_atom_b9375444(false)
	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
end

function forceUnequipItem()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:__wf_atom_b9375444(true)
	__wf_atom_d2b2176d:Unequip(0, 1)
	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(false)
end

function PrepairBromiusHealCinematic(object)
	if gRegion:IsMaster() then
		for _, v3 in ipairs(cineDecos) do
			gRegion:CreateEntity(
				v3,
				Vector(object:GetPosition().x, object:GetPosition().y, object:GetPosition().z),
				object:__wf_atom_dc309f8a(),
				object
			)
		end

		object:ReinitializeGreenRoom()
		object:PlaceGreenRoomEntities()
	end
end

function TearDownBromiusHealCinematic(object)
	for _, v3 in pairs(avatarTags) do
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v3, object:GetPosition(), 0, 30)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			__wf_atom_f738b4af:Destroy()
		end
	end
end

local function fn6(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if p then
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 1)
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(1, 1)
	else
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 2)
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(1, 2)
	end

	for i = 1, 12 do
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(i)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27:__wf_atom_cfecab5d(p)
		end
	end
end

local function fn7(object, p, p2, p3) -- 4 equivalent calls inferred from this helper
	local __wf_atom_66088189 = object:__wf_atom_66088189(p, p2)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		__wf_atom_66088189:__wf_atom_a763aa1a(p3)
	end
end

local function fn8(p, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_28224c27 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(p)

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		fn7(__wf_atom_28224c27, 1, 1, p2) -- inferred equivalent call
		fn7(__wf_atom_28224c27, 1, 0, p2) -- inferred equivalent call
		fn7(__wf_atom_28224c27, 1, 2, p2) -- inferred equivalent call
		fn7(__wf_atom_28224c27, 1, 3, p2) -- inferred equivalent call
		local __wf_atom_d8f0938a = __wf_atom_28224c27:__wf_atom_d8f0938a()

		for _, v3 in ipairs(__wf_atom_d8f0938a) do
			if not __wf_atom_7e8ad928(v3) then
				v3:__wf_atom_a763aa1a(p2)
			end
		end
	end
end

local function fn9(object, p)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local v3 = Type(__wf_atom_e55d02aa:__wf_atom_eb82ab1f():__wf_atom_035fdfa8(4))

	if __wf_atom_7e8ad928(v3) then
		return
	end

	local __wf_atom_cdcc10f5 = v3:__wf_atom_cdcc10f5(object:__wf_atom_f115b657() and 0 or 1, 0)

	for _, v4 in ipairs(__wf_atom_cdcc10f5) do
		if __wf_atom_7e8ad928(v4.mType) then
			continue
		end

		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v4.mType)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			continue
		end

		local __wf_atom_f582136d = __wf_atom_bb3e7833:__wf_atom_f582136d(__wf_atom_b5e70cef)

		for _, v5 in ipairs(__wf_atom_f582136d) do
			v5:__wf_atom_84dbc46b(p)
		end
	end
end

function HideUpsideDownClothesAndWeapons(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module2.Fade(true, 0, 1)

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		fn9(__wf_atom_c4f78a8f, -1)
		fn8(5, 1)
		fn8(0, 1)
		fn8(1, 1)

		for _, v3 in ipairs(clothesToHideInCinematic) do
			local __wf_atom_f582136d = __wf_atom_c4f78a8f:__wf_atom_f582136d(v3)

			for _, v4 in ipairs(__wf_atom_f582136d) do
				v4:__wf_atom_a763aa1a(1)
			end
		end
	end

	module2.Fade(false, 2, 1, false)
end

function UnhideUpsideDownClothesAndWeapons(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		fn9(__wf_atom_c4f78a8f, 1)
		fn8(5, 0)
		fn8(0, 0)
		fn8(1, 0)

		for _, v3 in ipairs(clothesToHideInCinematic) do
			local __wf_atom_f582136d = __wf_atom_c4f78a8f:__wf_atom_f582136d(v3)

			for _, v4 in ipairs(__wf_atom_f582136d) do
				v4:__wf_atom_a763aa1a(0)
			end
		end
	end
end

function DissolveOut(object)
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v3)
		Sleep(0)
	end
end

function DissolveIn(object)
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(1 - v3)
		Sleep(0)
	end
end

function BloomHit()
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93(), 0, 1)
		local blur = __wf_atom_24a82b69(v3)
		__wf_atom_8ad59546.postProcess:__wf_atom_2bd5152a(1, 1, 1, blur * 2)
		__wf_atom_8ad59546.postProcessBias.bloom = blur * 10
		__wf_atom_8ad59546.postProcessBias.blur = blur
		Sleep(0)
	end

	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() * 0.25, 0, 1)
		local blur = __wf_atom_24a82b69(1 - v4)
		__wf_atom_8ad59546.postProcess:__wf_atom_2bd5152a(1, 1, 1, blur * 2)
		__wf_atom_8ad59546.postProcessBias.bloom = blur * 10
		__wf_atom_8ad59546.postProcessBias.blur = blur
		Sleep(0)
	end
end

function BecomeEvil(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("BloomHit"), false)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_e919fb8e = v3:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.synodFlashBack = {}
		__wf_atom_e919fb8e.synodFlashBack.goodAttachments = v3:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_e919fb8e.synodFlashBack.goodAttachments do
			__wf_atom_e919fb8e.synodFlashBack.goodAttachments[i]:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
		end

		__wf_atom_e919fb8e.synodFlashBack.evilAttachments = {}

		for i = 1, #evilDecos do
			local v4 = v3:Attach(evilDecos[i], EMPTY_SYMBOL)
			v4:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
			v4:__wf_atom_68f2c268(1)
			table.insert(__wf_atom_e919fb8e.synodFlashBack.evilAttachments, v4)
		end

		fn6(v3, true)
		Sleep(1)
		__wf_atom_e919fb8e.synodFlashBack.priorMats = {}

		for i = 0, 7 do
			__wf_atom_e919fb8e.synodFlashBack.priorMats[i] = v3:__wf_atom_807f6a09(i)
			v3:__wf_atom_a887a262(i, hiddenMaterial, false)
		end
	end
end

function BecomeGood(_)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v3 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_e919fb8e = v3:__wf_atom_e919fb8e()

		if not __wf_atom_e919fb8e.synodFlashBack then
			break
		end

		v3:__wf_atom_68f2c268(0)
		__wf_atom_e919fb8e.synodFlashBack.goodAttachments = v3:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_e919fb8e.synodFlashBack.goodAttachments do
			__wf_atom_e919fb8e.synodFlashBack.goodAttachments[i]:__wf_atom_68f2c268(0)
		end

		for i = 1, #__wf_atom_e919fb8e.synodFlashBack.evilAttachments do
			gRegion:__wf_atom_dd1e4d10(__wf_atom_e919fb8e.synodFlashBack.evilAttachments[i])
		end

		for i = 0, 7 do
			v3:__wf_atom_a887a262(i, __wf_atom_e919fb8e.synodFlashBack.priorMats[i], false)
		end

		__wf_atom_e919fb8e.synodFlashBack = nil
		fn6(v3, false)
	end
end

function Grovel(object, object2)
	local v3 = gRegion:PlaySound(grovelSound, object2:GetPosition(), false)
	v3:__wf_atom_ff2a5387(-30)

	while not __wf_atom_7e8ad928(v3) do
		local __wf_atom_31aab74c = v3:__wf_atom_31aab74c()
		postProcessMaterial:__wf_atom_a042ff6c(
			Symbol("ChromaticShift"),
			__wf_atom_104bfe98(10, 200, __wf_atom_31aab74c),
			0,
			0,
			0
		)
		postProcessMaterial:__wf_atom_a042ff6c(Symbol("LensDistort"), __wf_atom_31aab74c * 0.15, 0, 0, 0)
		local __wf_atom_8d67d945 = object:__wf_atom_8d67d945()
		__wf_atom_8d67d945.radialBlurStrength = __wf_atom_31aab74c * 2
		__wf_atom_8d67d945:__wf_atom_2bd5152a(1, 1, 1, 1 + __wf_atom_31aab74c * 10)
		Sleep(0)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_7d4910e4() do
		local radialBlurStrength = math.abs((Noise(Time() * 0.15))) * 0.5
		postProcessMaterial:__wf_atom_a042ff6c(
			Symbol("ChromaticShift"),
			__wf_atom_104bfe98(10, 200, radialBlurStrength),
			0,
			0,
			0
		)
		postProcessMaterial:__wf_atom_a042ff6c(Symbol("LensDistort"), radialBlurStrength * 0.1, 0, 0, 0)
		local __wf_atom_8d67d945 = object:__wf_atom_8d67d945()
		__wf_atom_8d67d945.radialBlurStrength = radialBlurStrength
		__wf_atom_8d67d945:__wf_atom_2bd5152a(1, 1, 1, radialBlurStrength * 10 + 1)
		Sleep(0)
	end
end

function HideAcornForOneFrameHack(object)
	local v3 = Symbol("Acorn")
	local __wf_atom_59c6b81d = object:__wf_atom_59c6b81d()

	for _, v4 in ipairs(__wf_atom_59c6b81d) do
		if v4:__wf_atom_12695c30() == v3 then
			v4:__wf_atom_a763aa1a(1)
		end
	end

	Sleep(0)

	for _, v4 in ipairs(__wf_atom_59c6b81d) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_12695c30() ~= v3 then
			continue
		end

		v4:__wf_atom_a763aa1a(0)
	end
end

function DisableAcorns(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AcornRain"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end
end

function PrepairWazzardFightIntroCine(object)
	module.CloseTransmissions()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("Wazzard"), object:GetPosition())

	while __wf_atom_7e8ad928(nearestTagged) do
		nearestTagged = gRegion:FindNearestTagged(Symbol("Wazzard"), object:GetPosition())
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(nearestTagged) then
		object:__wf_atom_a3d2b66b(nearestTagged, Symbol("Wazzard"))
	end
end

function PrepareRub(object)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("BromiusCineDeco"), object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		object:__wf_atom_a3d2b66b(nearestTagged, Symbol("Bromius"))
	end
end