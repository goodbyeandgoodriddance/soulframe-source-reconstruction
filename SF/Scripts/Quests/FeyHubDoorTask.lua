local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.ConversationLib")
local module3 = require("SF.Interface.Libs.MusicCommon")
local module4 = require("SF.Scripts.NightFoldLib")
local module5 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = Resource("/Lotus/Types/Input/DialogInputFilter")
local v2 = Symbol("Invulnerable")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = Resource("/SF/Animations/Player/Contextual/Oaths/ShrineOffering01_anim.fbx")
local v7 = Resource("/SF/Animations/Player/Contextual/Oaths/ShrineOffering02_anim.fbx")
local v8 = {}
local v9 = nil
local v10 = { "RiverPearlResource", "GossamerQuartzResource", "MoraniteResource" }
local v11 = WeakResource("/SF/Types/Lore/MidrathHubKeysLoreFragement")
local v12 = Symbol("FeyHub")

function AvatarPlayInstrument(p)
	module3.AvatarPlayInstrument(p, nil, instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end

function EvaluateDoorRiddleOffering()
	if __wf_atom_7e8ad928(v11) then
		return true
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return false
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if not __wf_atom_7e8ad928(playerAvatar) then
		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if not (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_d2b2176d:__wf_atom_705a2744(v11, v12)) then
			return true
		end
	end

	return false
end

function GiveLoreDrop(p, p2, p3)
	if not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
		return
	end

	if not __wf_atom_7e8ad928(p2) then
		if p3 == EMPTY_SYMBOL then
			module5.GiveLoreFragment(p2, p)
		else
			module5.GiveLoreFragmentMemory(p2, p, p3)
		end

		for _, v13 in gRegion:FindAll(markerInfo) do
			v13:__wf_atom_ff716ec1(true)
		end
	end
end

local function fn(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if p then
		__wf_atom_d2b2176d:Unequip(0, 2)
		return
	end

	__wf_atom_d2b2176d:Unequip(0, 0)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		Sleep(0)
	end
end

function ShirneOfferingSong(instance, object)
	_T.SpiritChestMusicGame = true
	_T.MusicGameMidiOverride = songMidiData
	_T.MusicGameSuccessSoundOverride = successSoundOverride

	if object:__wf_atom_8efce136() then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)
		module4.RegisterPreventNighfoldUsage(true)

		if instance:IsA(__wf_atom_8b8e8b22) then
			local v13 = Symbol("Invulnerable")
			fn(object)
			local __wf_atom_7470861b = object:__wf_atom_7470861b()
			__wf_atom_7470861b:__wf_atom_9fba31e6(v13, 26, 6, 0)

			if gRegion:IsMaster() then
				instance:Disable()
				object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
			else
				while object:__wf_atom_0473b7a9() do
					Sleep(0)
				end
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
				__wf_atom_7470861b:__wf_atom_63396172(v13)
			end

			_T.SpiritChestMusicGame = false
			_T.MusicGameMidiOverride = nil
			_T.MusicGameSuccessSoundOverride = nil
			module4.RegisterPreventNighfoldUsage(false)
		end
	elseif gRegion:IsMaster() then
		instance:Disable()
		object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
	end
end

function SlidePlayer(p)
	module2.SlidePlayer(p, v9, 1)
end

local function fn2(object)
	if not __wf_atom_7e8ad928(object) then
		local v13 = 0

		while not __wf_atom_7e8ad928(object) and v13 < 1 do
			v13 = __wf_atom_421b01aa(v13 + __wf_atom_084b3e93(), 0, 1)
			object:__wf_atom_68f2c268(v13)
			Sleep(0)
		end

		object:SetVisibility(false, true)
	end
end

function PlaceItemAnim(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_921c1a5f(v6, false, 4, 1, false)
	object:__wf_atom_8914dfde("CreateItem", 4)
	local v13

	if not __wf_atom_7e8ad928(p) then
		v13 = object:Attach(p, Symbol("GAME_R1_WEAPON1"), Vector(-0.03, -0.04, 0), __wf_atom_80368bb1)
		v13:SetMeshScale(0.5, true)
		v13:__wf_atom_0ed81088(false)
	end

	object:__wf_atom_8914dfde("Placed", 4)

	if not __wf_atom_7e8ad928(v13) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WallplacementPoint"))
		v13:__wf_atom_e6ed03c8()
		v13:__wf_atom_0ed81088(true)
		v13:SetPosition(__wf_atom_0a6a5887:GetPosition())
		v13:__wf_atom_9b788a35(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
	end

	if p2 then
		object:__wf_atom_d2b2176d():ConsumeMiscItem(hubTaskItems[3], 1)
	end

	object:__wf_atom_8914dfde("ShrineReaction", 4)

	if p2 then
		spiritdeco:Attach(successFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local v14 = 0

		while v14 < 4 do
			v14 = __wf_atom_421b01aa(v14 + __wf_atom_084b3e93(), 0, 4)
			local v15 = 1 - math.abs(0.5 - v14 / 4) * 2
			local v16 = __wf_atom_104bfe98(0, 3, v15)
			walldeco:SetMaterialParam(Symbol("EmissiveMapAtten"), v16)
			Sleep(0)
		end

		module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("GiveCorectOffering"), object, false)
		Sleep(2)
		fn2(v13)
		walldeco:FirePort("PlayTriggeredFade")

		if not __wf_atom_7e8ad928(blockingVol) then
			blockingVol:Disable()
		end
	else
		Sleep(1)
		spiritdeco:Attach(failFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("GiveWrongOffering"), object, false)
		Sleep(2)
		object:__wf_atom_921c1a5f(v7, false, 4, 1, false)
		object:__wf_atom_8914dfde("TakeItem", 4)
		v13:SetVisibility(false, true)
		v13:Destroy()
		local v14 = object:Attach(v13, Symbol("GAME_R1_WEAPON1"), Vector(-0.03, -0.04, 0), __wf_atom_80368bb1)
		v14:SetMeshScale(0.5, true)
		v14:__wf_atom_0ed81088(false)
		object:__wf_atom_8914dfde("DestroyItem", 2)
		v14:Destroy()
	end
end

function GiveOffering(object, object2)
	if not gGameData then
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("HubTaskNpcCamspot"), object2:GetPosition(), 0, 10)
	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local flag = false
	v9 = gRegion:__wf_atom_0a6a5887(Symbol("ShrineWp"))
	object2:__wf_atom_dd875cd8(true)
	object2:__wf_atom_aeb02c14(v)
	__wf_atom_d2b2176d:Unequip(0, 0)
	module.CloseTransmissions()
	local v13 = { Loop = conversationMenuMusic }
	v3 = module2.CreateConversation(Localize(tostring(npcName), false), __wf_atom_f738b4af, conversationMenuMovie)

	if __wf_atom_7e8ad928(v13) then
		v3:Start()
	else
		v3:Start(v13)
	end

	object2:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
	local v14 = { Text = "/SF/Language/Quests/LeaveShrine" }
	v14.Text = Localize(v14.Text, false)
	local v15 = "LeaveShrine"

	function v14.Callback()
		v4 = v15
		v5 = v14
	end

	local v16 = { Text = "/SF/Language/Quests/GiveShineOfferingRiverPearl" }
	v16.Text = Localize(v16.Text, false)
	local v17 = "CorectResponse"

	function v16.Callback()
		v4 = v17
		v5 = v16
	end

	local v18 = { Text = "/SF/Language/Quests/GiveShineOfferingMornanite" }
	v18.Text = Localize(v18.Text, false)
	local v19 = "SoulsBane"

	function v18.Callback()
		v4 = v19
		v5 = v18
	end

	local v20 = { Text = "/SF/Language/Quests/GiveShineOfferingGossamerQuartz" }
	v20.Text = Localize(v20.Text, false)
	local v21 = "Lullily"

	function v20.Callback()
		v4 = v21
		v5 = v20
	end

	gGameData:GetInventory()
	gGameData:SyncInventoryFromDB("EmptyCallback")

	for i, itemWeakRes in ipairs(hubTaskItems) do
		local anyPlayerHasItem = module5.AnyPlayerHasItem(itemWeakRes, false)
		table.insert(v8, { itemWeakRes = itemWeakRes, hasitem = anyPlayerHasItem, name = v10[i] })
	end

	v3:SetChoices(nil)
	module.PlayDialogMenuTransmission(npcTransmissionSet, Symbol("ConversationIntro"), object2, true)
	local v22 = {}

	if #v8 > 1 then
		for _, v23 in ipairs(v8) do
			if v23.hasitem ~= true then
				continue
			end

			if v23.name == "RiverPearlResource" then
				table.insert(v22, v16)
			elseif v23.name == "MoraniteResource" then
				table.insert(v22, v18)
			elseif v23.name == "GossamerQuartzResource" then
				table.insert(v22, v20)
			end
		end

		table.insert(v22, v14)
	end

	if v22 then
		v3:SetChoices(v22)
	else
		v3:SetChoices({ v14 })
	end

	while v3:Update() do
		if not __wf_atom_7e8ad928(v4) then
			if v4 == "CorectResponse" then
				v3:SetChoices(nil)
				PlaceItemAnim(object2, sangeliaMesh, true)
				flag = true
				_T.OfferingCompleted = true
				break
			elseif v4 == "Lullily" then
				v3:SetChoices(nil)
				PlaceItemAnim(object2, lullilyMesh, false)
				v3:SetChoices(v22)
				v4 = nil
			elseif v4 == "SoulsBane" then
				v3:SetChoices(nil)
				PlaceItemAnim(object2, soulsBaneMesh, false)
				v3:SetChoices(v22)
				v4 = nil
			elseif v4 == "LeaveShrine" then
				print("Good Bye")
				break
			end
		end

		Sleep(0)
	end

	v3:Close()

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		__wf_atom_7470861b:__wf_atom_63396172(v2)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_cf966a74(v)
		object2:__wf_atom_dd875cd8(false)
	end

	if flag then
		local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

		for _, v23 in ipairs(__wf_atom_a8553251) do
			if v23:__wf_atom_a5304c35(object:GetPosition()) < 30 then
				GiveLoreDrop(Resource("/SF/Types/Lore/MidrathHubKeysLoreFragement"), v23, Symbol("FeyHub"))
			end
		end
	end
end