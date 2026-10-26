local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.Libs.ConversationLib")
local module4 = require("SF.Interface.Libs.MusicCommon")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.QuestLib")
local module7 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module8 = require("Lotus.Scripts.Libs.AudioLib")
require("Lotus.Interface.LotusUtilities")
require("EE.Interface.Utilities")
local v = Resource("/Lotus/Types/Input/DialogInputFilter")
local v2 = Symbol("Invulnerable")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 0

local function fn(treeWord, translation, sound)
	return {
		Text = Localize(treeWord, false),
		Callback = function()
			v4 = translation
			v5 = sound
		end
	}
end

local function fn2(p, __wf_atom_c4f78a8f)
	local total = 0

	while total < p do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			return false
		end
	end

	return true
end

function VerminiaNightfoldConversation(object)
	-- [DEDUP] synthesized from 5 duplicated terminal regions
	local function deduplicatedTail()
		if not __wf_atom_7e8ad928(v3) then
			v3:Close()
		end

		module2.CloseTransmissions()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if gRegion:IsMaster() then
		object:Disable()
	end

	if __wf_atom_c4f78a8f:__wf_atom_4417a5d4() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaConversationPostCinCamera"))
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:CameraControl():__wf_atom_fd14c463(3)
		end

		__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v)
		__wf_atom_d2b2176d:Unequip(0, 0)
		npcInstance:__wf_atom_d927a2a4(npcTalkIdleAnim)
		module2.CloseTransmissions()
		v3 = module3.CreateConversation(
			Localize("/SF/Language/Characters/Verminia", false),
			__wf_atom_0a6a5887,
			nil,
			nil
		)
		v3:Start()
		local v9 = {
			Text = "/SF/Language/Quests/CaughtInRoots",
			SuccessState = nil,
			Skill = nil,
			Attribute = nil
		}
		v9.Text = Localize(v9.Text, false)
		local v10 = "Roots"
		local v11 = nil

		function v9.Callback()
			v4 = v10
			v8 = v9
			v5 = v11
		end

		local v12 = {
			Text = "/SF/Language/Quests/Monster",
			SuccessState = nil,
			Skill = nil,
			Attribute = nil
		}
		v12.Text = Localize(v12.Text, false)
		local v13 = "Monster"
		local v14 = nil

		function v12.Callback()
			v4 = v13
			v8 = v12
			v5 = v14
		end

		local v15 = {
			Text = "/SF/Language/Quests/BearWithThreeHeads",
			SuccessState = nil,
			Skill = nil,
			Attribute = nil
		}
		v15.Text = Localize(v15.Text, false)
		local v16 = "Bear"
		local v17 = nil

		function v15.Callback()
			v4 = v16
			v8 = v15
			v5 = v17
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WitchStationDeco_HeroRat"))
		v3:SetChoices({ v9, v12, v15 })

		while v3:Update() do
			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				return deduplicatedTail()
			else
				if not __wf_atom_7e8ad928(v4) then
					if v4 == "Roots" then
						v3:SetChoices(nil)
						module2.PlayDialogMenuTransmission(
							transmissionSet,
							Symbol("Nightfold-ConvoRoots"),
							__wf_atom_c4f78a8f,
							false,
							0
						)
						fn2(15.5, __wf_atom_c4f78a8f)
						__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratReactionAnim, false, false)
						fn2(4, __wf_atom_c4f78a8f)
					elseif v4 == "Monster" then
						v3:SetChoices(nil)
						module2.PlayDialogMenuTransmission(
							transmissionSet,
							Symbol("Nightfold-ConvoMonster"),
							__wf_atom_c4f78a8f,
							false,
							0
						)
						fn2(8, __wf_atom_c4f78a8f)
						__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratReactionAnim, false, false)
						fn2(6, __wf_atom_c4f78a8f)
					elseif v4 == "Bear" then
						v3:SetChoices(nil)
						local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("WitchStationDeco_Rat"))
						__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratReactionAnim, false, false)

						for _, v18 in ipairs(__wf_atom_2226b35c) do
							fn2(math.random(0, 1) / 10, __wf_atom_c4f78a8f)

							if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
								break
							else
								v18:FirePort("PlayTriggeredAnim")
							end
						end

						module2.PlayDialogMenuTransmission(
							transmissionSet,
							Symbol("Nightfold-ConvoBear"),
							__wf_atom_c4f78a8f,
							false,
							0
						)
						fn2(7.5, __wf_atom_c4f78a8f)
						__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratJumpReactionAnim, false, false)
						break
					end

					v3:SetChoices({ v9, v12, v15 })
					v4 = nil
				end

				Sleep(0)
			end
		end

		module2.PlayLocalTransmission(transmissionSet, Symbol("Nightfold-Poppets"), __wf_atom_c4f78a8f, false)

		if fn2(3, __wf_atom_c4f78a8f) then
			__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratReactionAnim, false, false)

			if fn2(2, __wf_atom_c4f78a8f) then
				__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(ratReactionAnim, false, false)

				if fn2(7, __wf_atom_c4f78a8f) then
					module2.PlayLocalTransmission(
						transmissionSet,
						Symbol("Nightfold-SapDream"),
						__wf_atom_c4f78a8f,
						false
					)
					Sleep(1)

					while module2.TransmissionPlaying() do
						Sleep(0)

						if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
							return deduplicatedTail()
						end
					end

					_T.BromiusVerminiaConvoDone = true
					v3:Close()
					module8.EnableTaggedSequencers(Symbol("verminiaBromiusQuestMusicSeq"), false)
					npcInstance:__wf_atom_d927a2a4(npcIdleAnim)
					__wf_atom_c4f78a8f:__wf_atom_cf966a74(v)
					_T.ForceDialogClose = nil
					module2.PlayDialogMenuTransmission(
						transmissionSet,
						Symbol("Nightfold-ToWevetWood"),
						__wf_atom_c4f78a8f,
						false,
						0
					)
					local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNightfoldNpc"))
					module7.DissolveOut(__wf_atom_0a6a5887_3)
					gRegion:__wf_atom_0a6a5887(Symbol("VerminiaTalkAction")):FirePort("Disable")

					if not __wf_atom_7e8ad928(v6) then
						gRegion:__wf_atom_dd1e4d10(v6)
					end
				else
					return deduplicatedTail()
				end
			else
				return deduplicatedTail()
			end
		else
			return deduplicatedTail()
		end
	end
end

function PostPlantingBromiusConvo(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(_T.BromiusConversationStage) then
		_T.BromiusConversationStage = 1
	end

	v7 = object
	local cameraSpotInstance = cameraSpotInstance
	local __wf_atom_7470861b = __wf_atom_c4f78a8f:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	gRegion:__wf_atom_f738b4af(Symbol("BromiusCineDeco"), object:GetPosition(), 0, 30)
	__wf_atom_7470861b:__wf_atom_9fba31e6(v2, 26, 6, 0)
	__wf_atom_c4f78a8f:__wf_atom_dd875cd8(true)
	__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v)
	__wf_atom_d2b2176d:Unequip(0, 0)
	npcInstance:__wf_atom_7b7015c9(npcTalkIdleAnim)
	module2.CloseTransmissions()
	v3 = module3.CreateConversation(Localize(npcName, nil), cameraSpotInstance, nil)
	v3:Start()
	local v9 = {
		Text = "/SF/Language/Quests/BromiusDialogueConvoGraceChoice",
		SuccessState = true,
		Skill = 1,
		Attribute = 0
	}
	v9.Text = Localize(v9.Text, false)
	local v10 = "FreedVirtueChoices"
	local v11 = nil

	function v9.Callback()
		v4 = v10
		v8 = v9
		v5 = v11
	end

	local v12 = {
		Text = "/SF/Language/Quests/BromiusDialogueConvoCourageChoice",
		SuccessState = true,
		Skill = 2,
		Attribute = 1
	}
	v12.Text = Localize(v12.Text, false)
	local v13 = "FreedVirtueChoices"
	local v14 = nil

	function v12.Callback()
		v4 = v13
		v8 = v12
		v5 = v14
	end

	local v15 = {
		Text = "/SF/Language/Quests/BromiusDialogueConvoSpiritChoice",
		SuccessState = true,
		Skill = 3,
		Attribute = 2
	}
	v15.Text = Localize(v15.Text, false)
	local v16 = "FreedVirtueChoices"
	local v17 = nil

	function v15.Callback()
		v4 = v16
		v8 = v15
		v5 = v17
	end

	v3:SetChoices(nil)
	module2.PlayDialogMenuTransmission(transmissionSet, Symbol("BromiusWorry"), __wf_atom_c4f78a8f, true)
	v3:SetChoices({ v9, v12, v15 })

	if _T.BromiusConversationStage == 2 then
		v4 = "FreedVirtueChoices"

		if _T.BromiusConversationAttribute then
			v8 = { Attribute = _T.BromiusConversationAttribute }
		end
	end

	while v3:Update() do
		if not __wf_atom_7e8ad928(v4) then
			if v4 == "FreedVirtueChoices" then
				v3:SetChoices(nil)
				v3:ChangeAffinity("2")
				_T.BromiusConversationStage = 3
				_T.BromiusConversationCOmpleted = true
				_T.BromiusConversationAttribute = v8.Attribute
				gGameData:__wf_atom_109e1c51(v8.Attribute, "BromiusQuest", "")
				break
			else
				v4 = nil
			end
		end

		Sleep(0)
	end

	v3:Close()

	if not __wf_atom_7e8ad928(cameraSpotInstance) then
		cameraSpotInstance:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		__wf_atom_7470861b:__wf_atom_63396172(v2)
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(v)
		__wf_atom_c4f78a8f:__wf_atom_dd875cd8(false)
	end

	module6.SetLocalPlayerReadyTag(WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest"), "7-PlantWevetSeeds")
end

function TreeFall()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WevetwoodBrokenTree"))
	__wf_atom_0a6a5887:__wf_atom_8a035cd5(Symbol("TreeTalkEmissive"), false)
	__wf_atom_0a6a5887:__wf_atom_921c1a5f(brokenTreeAnimFalling, false, false)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("SapDripSpawner"))

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Destroy()
	end

	Sleep(5)
	module4.ShowMusicHint(1, treeTalkPuzzleMidi, 1.3)

	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(Symbol("BromiusNoteFound1"), 1)
	end

	Sleep(3.5)
	module.TaggedFirePorts(Symbol("FallenTrunkPushTrigger"), "Enable")
	Sleep(0.5)
	module.TaggedFirePorts(Symbol("FallenTrunkPushTrigger"), "Disable")
	module.TaggedFirePorts(Symbol("FallenTrunkColl"), "Enable")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:CameraControl():__wf_atom_4dab66dd(__wf_atom_c4f78a8f:GetPosition(), -1, 10, 2)
	end

	Sleep(2)
	__wf_atom_0a6a5887:__wf_atom_921c1a5f(brokenTreeAnimFell, false, true)
end

function TreeTalkPuzzle(object, object2)
	local treeTalkAnimStart = treeTalkAnimStart
	local treeTalkAnimLoop = treeTalkAnimLoop
	local treeTalkAnimStop = treeTalkAnimStop

	if not __wf_atom_7e8ad928(treeTalkAnimStart) then
		module.UnequipWeapon(object2, true)
		object2:__wf_atom_aeb02c14(blockMovementInput)
		object2:__wf_atom_921c1a5f(treeTalkAnimStart, false, 4, 1, false, startAnimRate)
		object2:__wf_atom_8914dfde("TouchTree", 2)

		if not __wf_atom_7e8ad928(treeTalkAnimLoop) then
			object2:__wf_atom_921c1a5f(treeTalkAnimLoop, false, 4, 2, false)
			Sleep(1)
		end

		if not __wf_atom_7e8ad928(treeTalkAnimStop) then
			object2:__wf_atom_921c1a5f(treeTalkAnimStop, true, 4, 1, false)
			object2:__wf_atom_cf966a74(blockMovementInput)
		end
	end

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() or not object2:__wf_atom_535d5cbb() then
		return
	end

	if gRegion:IsMaster() then
		object:Disable()
		object2:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), false)
	end

	if object2:__wf_atom_4417a5d4() then
		local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs.mIsPlaying = true
		object2:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
		local __wf_atom_7470861b = object2:__wf_atom_7470861b()
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		local v9 = object2:EyePosition() + Vector(0, -0.35, 0) + __wf_atom_9341614d(
			object2:__wf_atom_a06d543c() * 2.3,
			Rotation(105, 0, 0)
		)
		local v10 = __wf_atom_fa8d0177(
			v9,
			object2:EyePosition() + Vector(0, -0.4, 0) + object2:__wf_atom_a06d543c() * 0.79
		)
		v6 = gRegion:CreateEntity(cameraSpotType, v9, v10)
		__wf_atom_7470861b:__wf_atom_9fba31e6(v2, 26, 6, 0)
		object2:__wf_atom_dd875cd8(true)
		object2:__wf_atom_aeb02c14(v)
		__wf_atom_d2b2176d:Unequip(0, 0)
		module2.CloseTransmissions()
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("DemoSkipCheat"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("MENU_CANCEL"),
			"InputHandler_CheatPuzzle"
		)
		local v11 = {
			{ translation = "know", treeWord = "Foosh?", sound = treeTalkPuzzleSoundFoosh },
			{ translation = "now", treeWord = "Alosh?", sound = treeTalkPuzzleSoundAlosh },
			{ translation = "touch", treeWord = "Kreek?", sound = treeTalkPuzzleSoundKreek },
			{ translation = "wind", treeWord = "Wysh?", sound = treeTalkPuzzleSoundWysh },
			{ translation = "silent", treeWord = "Stook?", sound = treeTalkPuzzleSoundStook },
			{ translation = "sap", treeWord = "Hiff?", sound = treeTalkPuzzleSoundHiff },
			{ translation = "death", treeWord = "Croak?", sound = treeTalkPuzzleSoundCroak },
			{ translation = "dream", treeWord = "Pok?", sound = treeTalkPuzzleSoundPok },
			{ translation = "change", treeWord = "Ha?", sound = treeTalkPuzzleSoundHa },
			{ translation = "fall", treeWord = "Tak?", sound = treeTalkPuzzleSoundTak },
			{ translation = "seed", treeWord = "Tuck?", sound = treeTalkPuzzleSoundTuck },
			{ translation = "grow", treeWord = "Wa?", sound = treeTalkPuzzleSoundWa }
		}
		local v12 = { 11, 6, 5 }
		local v13 = false
		local count = 0
		v4 = nil

		while count < 1 and not (v13 or _T.SkipPuzzleCheat) do
			local v14 = v11[v12[count + 1]]
			local v15 = { (fn(v14.treeWord, v14.translation, v14.sound)) }
			local copyTable = module.CopyTable(v11)

			while #v15 < 3 do
				local v16 = __wf_atom_5784a397(1, #copyTable)

				if copyTable[v16].translation ~= v14.translation then
					table.insert(v15, (fn(copyTable[v16].treeWord, copyTable[v16].translation, copyTable[v16].sound)))
				end

				table.remove(copyTable, v16)
			end

			local randomizeTableOrder = module.RandomizeTableOrder(v15)
			local v16 = __wf_atom_7e8ad928(_T.BackgroundMovie) and ""
				or _T.BackgroundMovie:__wf_atom_8e9ac384("/SF/Language/Quests/TreePuzzlePrompt", true, {
					WORD = v14.translation
				})
			v3 = module3.CreateConversation(v16, v6)
			v3:Start()
			v3:SetChoices(randomizeTableOrder)

			while v3:Update() and not _T.SkipPuzzleCheat do
				if __wf_atom_7e8ad928(v4) then
					Sleep(0)
				else
					print("menu selection is ", v4)

					if v5 ~= nil then
						object2:PlaySound(v5, true)
						v5 = nil
					end

					if v4 == v14.translation then
						__wf_atom_f2daf912("Right answer")
						count += 1
					else
						__wf_atom_f2daf912("Wrong answer")
						v13 = true
					end

					v4 = nil
					break
				end
			end
		end

		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("DemoSkipCheat"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("MENU_CANCEL")
		)
		v3:Close()
		__wf_atom_7470861b:__wf_atom_63396172(v2)
		object2:__wf_atom_cf966a74(v)
		object2:__wf_atom_dd875cd8(false)
		_T.ForceDialogClose = nil
		_T.SkipPuzzleCheat = nil
		local musicResultsRMIArgs2 = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs2.mIsPlaying = false
		musicResultsRMIArgs2.mSuccess = not v13
		object2:__wf_atom_0a2fdbe5(musicResultsRMIArgs2)
		Sleep(0.2)

		if v13 and not (__wf_atom_7e8ad928(object2) or object2:IsKilled()) then
			local v14 = object2:__wf_atom_a06d543c() * 5 * -1 + Vector(0, 0.5, 0)
			local damageData = Engine.DamageData()
			damageData.baseAmount = 10
			damageData:__wf_atom_7498285f(0, 1)
			damageData:__wf_atom_d6f4d914(0, true)
			damageData:__wf_atom_d6f4d914(19, true)
			damageData:__wf_atom_12cf5317(v14)
			object2:__wf_atom_649bf33e(damageData)

			if not __wf_atom_7e8ad928(treePuzzleFailSound) then
				object2:PlaySound(treePuzzleFailSound, false)
			end

			Sleep(5)

			if not __wf_atom_7e8ad928(object) then
				object:Enable()
			end

			return
		else
			module.TaggedFirePorts(Symbol("WevetwoodBarrierSeq"), "Disable")
			module.TaggedFirePorts(Symbol("WevetwoodBarrierDisableSeq"), "Enable")
			Sleep(1)
		end
	end

	_T.TreePuzzleComplete = true
end

function TreeTalkPuzzleShowHint()
	module4.ShowMusicHint(nil, treeTalkPuzzleMidi, 0)
end

function TreeTalkEmissive(object)
	while not __wf_atom_7e8ad928(_T.TreeTalkSoundInstance) and _T.TreeTalkSoundInstance:__wf_atom_946fdac0() >= 0 do
		local __wf_atom_31aab74c = _T.TreeTalkSoundInstance:__wf_atom_31aab74c()
		object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 10 + __wf_atom_31aab74c * 100, 0, 0, 0)
		Sleep(0)
	end

	object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 5, 0, 0, 0)
end

function TreeTalkTrigger(object, object2)
	local treeTalkAnimStart = treeTalkAnimStart
	local treeTalkAnimLoop = treeTalkAnimLoop
	local treeTalkAnimStop = treeTalkAnimStop
	local treeTalkSoundInstance = nil
	object:Disable()

	if showNoteHint then
		module4.ShowMusicHint(treeTalkNote, treeTalkPuzzleMidi, 1.3)

		if gRegion:IsMaster() then
			gGameRules:SetNetPersistentVar(Symbol("BromiusNoteFound" .. treeTalkNote), treeTalkNote)
		end
	end

	if not __wf_atom_7e8ad928(treeTalkAnimStart) then
		local v9 = {
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce,
			__wf_atom_3feeb44a
		}
		local position = object2:GetPosition()
		local v10 = object:GetPosition() + __wf_atom_9341614d(object:__wf_atom_d32e11f8(), object:__wf_atom_dc309f8a())
		position.y += 1.6

		if alignWithActionDeco and not __wf_atom_7e8ad928(actionDecoration) then
			local position2 = actionDecoration:GetPosition()
			position2.y += 1.6
			local v11 = Vector()
			gRegion:__wf_atom_c20d246a(position, position2, v9, nil, v11)

			if v11 ~= __wf_atom_28d5d4aa then
				v10 = v11
			end
		end

		local v11 = v10 + __wf_atom_9341614d(Vector(0, 0, playerDistanceFromObject), __wf_atom_fa8d0177(v10, position))
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v11)
		local v12 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, v10)
		module.UnequipWeapon(object2, true)
		object2:__wf_atom_3c986cd9(__wf_atom_0e0a6fee, v12, true)
		object2:__wf_atom_921c1a5f(treeTalkAnimStart, false, 4, 1, true, startAnimRate)
		object2:__wf_atom_8914dfde("TouchTree", 2)

		if __wf_atom_7e8ad928(object2) then
			return
		end

		if not __wf_atom_7e8ad928(treeTalkSound) then
			treeTalkSoundInstance = gRegion:PlaySound(treeTalkSound, object:GetPosition() + Vector(0, 6, 0), false)
		end

		if not __wf_atom_7e8ad928(treeTalkAnimLoop) then
			object2:__wf_atom_921c1a5f(treeTalkAnimLoop, false, 4, 2, false)

			if not (__wf_atom_7e8ad928(treeTalkSoundInstance) or __wf_atom_7e8ad928(actionDecoration)) then
				_T.TreeTalkSoundInstance = treeTalkSoundInstance
				actionDecoration:__wf_atom_8a035cd5(Symbol("TreeTalkEmissive"), false)
			end

			Sleep(1)
		end

		if not __wf_atom_7e8ad928(treeTalkAnimStop) then
			object2:__wf_atom_921c1a5f(treeTalkAnimStop, false, 4, 1, false)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(actionDecoration) then
		module.RemoveAttachments(actionDecoration, __wf_atom_032e921b)
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("QuestSproutEncounter"), object:GetPosition(), 0, 20)

	if not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_f738b4af:IsEnabled()) then
		__wf_atom_f738b4af:Enable()
	end

	module6.DestroyAreaMarker(object)
	module5.RemoveSparrowDestination(object)

	if not __wf_atom_7e8ad928(_T.RemainingTreeTalkTriggers) then
		for i, _ in ipairs(_T.RemainingTreeTalkTriggers) do
			if _T.RemainingTreeTalkTriggers[i] == object then
				table.remove(_T.RemainingTreeTalkTriggers, i)
			end
		end

		if #_T.RemainingTreeTalkTriggers <= 0 then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-TreeTalkPuzzleHint"))
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusQuest-TreeTalkPuzzle"))
			__wf_atom_0a6a5887:Disable()
			__wf_atom_0a6a5887_2:Enable()
		end
	end
end

function OverrideMusicEndAnim(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_8161e6ba = __wf_atom_3d96ddcd:__wf_atom_8161e6ba()

	if not (__wf_atom_7e8ad928(__wf_atom_8161e6ba) or __wf_atom_8161e6ba.mSuccess) then
		__wf_atom_3d96ddcd:__wf_atom_1659a669(nil, false, 0, 1, true)
	end
end

function DestroyInstrumentAfter(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(5) do
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function AvatarPlayInstrument(object)
	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_0473b7a9()) do
		Sleep(0)
	end

	module4.AvatarPlayInstrument(object, nil, instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end