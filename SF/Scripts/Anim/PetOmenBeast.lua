local module = require("SF.Scripts.Libs.StatsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.PlayerPetLib")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module5 = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.ModifySkyLib")
local selectedSpawnIndex2 = 1
local v = nil
local v2 = nil
local v3 = {
	{
		wp = Symbol("FirePlace"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalSleepingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/WolfCub/SleepIdle_anim.fbx")
	},
	{
		wp = Symbol("InsideTent"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalStandingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/BattleDog/Idle01_anim.fbx")
	},
	{
		wp = Symbol("OrlicksDen"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalSleepingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/WolfCub/SleepIdle_anim.fbx")
	},
	{
		wp = Symbol("ForgeFire"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalSleepingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/WolfCub/SleepIdle_anim.fbx")
	},
	{
		wp = Symbol("WitchesCauldron"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalSleepingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/WolfCub/SleepIdle_anim.fbx")
	},
	{
		wp = Symbol("TestPos"),
		cin = Type("/SF/Types/Game/OmenBeasts/Orengall/OrngalStandingPettingCine"),
		idle = Resource("/SF/Animations/Wildlife/BattleDog/Idle01_anim.fbx")
	}
}

local function fn()
	local v4

	while true do
		v4 = math.random(1, #v3)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v3[v4].wp)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:IsEnabled() then
			break
		end

		Sleep(0)
	end

	return v4
end

local function fn2() -- 2 equivalent calls inferred from this helper
	return gRegion:IsMaster() and 3 or 4
end

function CreateOmenBeastDeco()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if canCheckForQuestProgression and not (__wf_atom_7e8ad928(requiredQuest) or _T.ForceShowPup) then
		for _, v4 in pairs(questsToHideOn) do
			if module2.QuestIsActive(v4) then
				return
			end
		end

		if not module2.HasCompletedQuest(requiredQuest) then
			return
		end
	end

	gGameData:GetInventory()
	gRegion:__wf_atom_c4f78a8f()

	if overrideRandomSpawn then
		selectedSpawnIndex2 = selectedSpawnIndex
	else
		selectedSpawnIndex2 = fn()
	end

	v = gRegion:__wf_atom_0a6a5887(omenbeastTag)

	if __wf_atom_7e8ad928(v) then
		local wp = v3[selectedSpawnIndex2].wp
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(wp)
		local v4 = fn2() -- inferred equivalent call
		v = gRegion:CreateEntity(
			omenBeastType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			nil,
			nil,
			v4
		)
	else
		local wp = v3[selectedSpawnIndex2].wp
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(wp)
		v:SetPosition(__wf_atom_0a6a5887:GetPosition())
		v:__wf_atom_9b788a35(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
		local __wf_atom_be0bea4a = v:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			if __wf_atom_be0bea4a[i]:IsA(__wf_atom_c9fc989f) then
				__wf_atom_be0bea4a[i]:Destroy()
			end
		end
	end

	v:Attach(v3[selectedSpawnIndex2].cin, EMPTY_SYMBOL)
	v:__wf_atom_7b7015c9(v3[selectedSpawnIndex2].idle)
end

function SetSkin(p)
	__wf_atom_7e8ad928(p)
end

local function fn3(value, object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			object = __wf_atom_c4f78a8f:CameraControl()
		end
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_5fcdec2b() then
		local __wf_atom_1b3db7e0 = object:__wf_atom_1b3db7e0()
		object:__wf_atom_fd14c463(0)
		object:SetCameraSpot(nil, value or 0.5)
		object:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end
end

function BondWithOmenBeast(object, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()
	local v4 = nil
	local v5 = nil

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_c9fc989f)
	targetAnimName = __wf_atom_3d96ddcd:__wf_atom_12695c30()

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	local v6 = openStatsDuringAnim and __wf_atom_4417a5d4

	if v6 then
		__wf_atom_bb3e7833:__wf_atom_6bd2ce4b(false)

		if __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(pupSummaryMovie) then
			v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(pupSummaryMovie)
		end
	end

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end

	if unequipWeapon and __wf_atom_4417a5d4 then
		if unequipInstant then
			__wf_atom_d2b2176d:Unequip(0, 2)
		else
			__wf_atom_d2b2176d:Unequip(0, 0)

			while not __wf_atom_7e8ad928(object2) and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
				Sleep(0)
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_bb3e7833:__wf_atom_a3d2b66b(object2, Symbol("Envoy"))
		__wf_atom_bb3e7833:__wf_atom_a3d2b66b(__wf_atom_3d96ddcd, targetAnimName)
		__wf_atom_bb3e7833:StartRelative(
			targetAnimName,
			__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
			__wf_atom_3d96ddcd:__wf_atom_2f2bada0()
		)
	end

	local v7 = false

	while not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:__wf_atom_7d4910e4() do
		Sleep(0)

		if not (v6 and __wf_atom_7e8ad928(v2)) then
			continue
		end

		v7 = true
		break
	end

	if v7 == true then
		module4.Fade(true, 1, 1, 1)
		__wf_atom_bb3e7833:Skip()
		module4.Fade(false, 1, 0, 1)
	elseif v6 and not __wf_atom_7e8ad928(cameraSpotType) then
		local gameCamera = gRegion:GetGameCamera()
		v4 = object2:CameraControl()
		v5 = gRegion:CreateEntity(cameraSpotType, gameCamera:GetPosition(), gameCamera:__wf_atom_dc309f8a())

		if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v4) then
			if not __wf_atom_7e8ad928(v5) then
				v5:Destroy()
			end

			if not __wf_atom_7e8ad928(object) then
				object:Enable()
			end

			return
		else
			v5:__wf_atom_888efbe9(gameCamera:__wf_atom_c277aed8())
			local __wf_atom_1b3db7e0 = v4:__wf_atom_1b3db7e0()
			v4:__wf_atom_fd14c463(0)
			v4:SetCameraSpot(v5, 0.5)
			v4:__wf_atom_fd14c463(__wf_atom_1b3db7e0)

			while not __wf_atom_7e8ad928(v2) do
				Sleep(0.5)
			end
		end
	end

	if not __wf_atom_7e8ad928(object) then
		object:Enable()
	end

	if Random(0, 1) < supportUpChance then
		module3.TrainPet(__wf_atom_a96eb2aa, 5, supportChallangeCooldown)
	end

	module.LogPetOmenBeast(__wf_atom_3d96ddcd:__wf_atom_1bb5b1ff())

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_8d0b7f88) then
		__wf_atom_3d96ddcd:__wf_atom_f173c8ad(true)
	end

	if v6 then
		fn3(0.5, v4)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end

	if not __wf_atom_7e8ad928(object) then
		object:Enable()
	end
end

function SpawnOmenBeastPet()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_a96eb2aa = __wf_atom_c4f78a8f:__wf_atom_a96eb2aa()
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if overrideRandomSpawn then
		selectedSpawnIndex2 = selectedSpawnIndex
	else
		selectedSpawnIndex2 = fn()
	end

	local wp = v3[selectedSpawnIndex2].wp
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(wp)

	if canCheckForQuestProgression and not (__wf_atom_7e8ad928(requiredQuest) or _T.ForceShowPup) then
		for _, v4 in pairs(questsToHideOn) do
			if module2.QuestIsActive(v4) then
				return
			end
		end

		if not (module2.HasPersonalCompletedQuest(requiredQuest) or _T.ReadyForPupLoreInOrengallQuest) then
			return
		end
	end

	if gRegion:IsMaster() then
		local __wf_atom_1915cc84 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_1915cc84()
		local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_1915cc84) then
			__wf_atom_1915cc84 = module3.CreatePet(
				agentType,
				__wf_atom_0a6a5887:GetPosition(),
				__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
				nil,
				nil,
				nil,
				__wf_atom_c4f78a8f
			)
		else
			module5.SetAbilityStats(__wf_atom_e55d02aa, mOwner, __wf_atom_1915cc84)
			__wf_atom_1915cc84:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
			local __wf_atom_ed5c034d = __wf_atom_a96eb2aa:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0)

			if __wf_atom_7e8ad928(__wf_atom_ed5c034d) then
				print("PLAYER PET:missing weaponInfo for pet")
			elseif __wf_atom_7e8ad928((__wf_atom_1915cc84:GiveItem(Type(__wf_atom_ed5c034d.mItemType), false))) then
				print("PLAYER PET: missing suit for pet")
			else
				__wf_atom_c4f78a8f:__wf_atom_d2b2176d():SetSentinelForPlayer(__wf_atom_1915cc84)
			end
		end

		if __wf_atom_7e8ad928(__wf_atom_1915cc84) then
			print("PLAYER PET: Avatar was unable to be created for Host ")
			return
		end

		__wf_atom_1915cc84:SetBlackboardBool(Symbol("IsCubInNightFold"), true)
		__wf_atom_e919fb8e.PlayerWolfAvatar = __wf_atom_1915cc84
		module3.OpenPetStatusMovie()
		_T.NightFoldPupCreated = true
	else
		local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()
		local __wf_atom_1915cc84 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_1915cc84()

		if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
			__wf_atom_e919fb8e.OldWolfAvatar = __wf_atom_1915cc84
		end

		local entity = gRegion:CreateEntity(
			clientAvatar,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			__wf_atom_a96eb2aa,
			__wf_atom_a96eb2aa,
			fn2() -- inferred equivalent call
		)

		if __wf_atom_7e8ad928(entity) then
			print("PLAYER PET: Avatar was unable to be created for client")
		else
			module5.SetAbilityStats(__wf_atom_e55d02aa, mOwner, entity)
			local __wf_atom_ed5c034d = __wf_atom_a96eb2aa:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0)

			if __wf_atom_7e8ad928(__wf_atom_ed5c034d) then
				print("PLAYER PET: missing weaponInfo for pet")
			elseif __wf_atom_7e8ad928((entity:GiveItem(Type(__wf_atom_ed5c034d.mItemType), false))) then
				print("PLAYER PET: missing suit for pet")
			else
				__wf_atom_c4f78a8f:__wf_atom_d2b2176d():SetSentinelForPlayer(entity)
				entity:__wf_atom_65fd9d84(__wf_atom_c4f78a8f)
			end

			local __wf_atom_e919fb8e_2 = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.PlayerWolfAvatar = entity
			_T.NightFoldPupCreated = true
			module3.OpenPetStatusMovie()
			local petEnergyPct = module3.GetPetEnergyPct(__wf_atom_a96eb2aa)

			if _T.ReadyForPupLoreInOrengallQuest then
				local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallQuest-PlayerReceivesPup"))
				Sleep(1)

				while __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
					Sleep(0.5)
				end

				entity:__wf_atom_921c1a5f(clientPostTutorialIdleAnim, false, 4, 2, false)
				entity:Attach(clientPostTutorialIdleCine, EMPTY_SYMBOL)
				entity:Attach(clientPostTutorialPetCTX, offsetAttachBone, ctxOffSetVector, __wf_atom_80368bb1):Enable()
			elseif petEnergyPct <= 0.1 then
				entity:__wf_atom_921c1a5f(clientSleepIdleAnim, false, 4, 2, false)
				local v4 = entity:Attach(clientPetSleepCTX, offsetAttachBone, ctxOffSetVector, __wf_atom_80368bb1)
				entity:Attach(clientSleepIdleCine, EMPTY_SYMBOL)
				v4:Enable()
			elseif petEnergyPct >= 0.1 then
				entity:__wf_atom_921c1a5f(clientEnergyIdleAnim, false, 4, 2, false)
				entity:Attach(clientEnergyIdleCine, EMPTY_SYMBOL)
				entity:Attach(clientEnergyPetCTX, offsetAttachBone, ctxOffSetVector, __wf_atom_80368bb1):Enable()
			end
		end
	end
end

function SleepPoiArrive(_, object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	selectedSpawnIndex2 = selectedSpawnIndex
	object:Attach(pettingCtx, offsetAttachBone, ctxOffSetVector, __wf_atom_80368bb1):Enable()
	object:Attach(v3[selectedSpawnIndex2].cin, EMPTY_SYMBOL)

	if portforwarderTagToFire ~= EMPTY_SYMBOL then
		module4.TaggedFirePorts(portforwarderTagToFire, "TriggerPort")
	end
end

function PupNightfoldPoi(_, object)
	local sleepArriveAnim2 = nil
	local deepSleepAnim2 = nil
	local deepSleepCine2 = nil
	local sleepContextAction2 = nil

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_6115a2e2():__wf_atom_a96eb2aa()
	local __wf_atom_4febbf37 = __wf_atom_a96eb2aa:__wf_atom_4febbf37()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		local petEnergyPct = module3.GetPetEnergyPct(__wf_atom_a96eb2aa)

		if __wf_atom_4febbf37.mNeedsRest then
			deepSleepAnim2 = deepSleepAnim
			deepSleepCine2 = deepSleepCine
			sleepContextAction2 = sleepContextAction
		elseif petEnergyPct <= 0.1 then
			local v4 = __wf_atom_5784a397(1, #sleepLoopAnims)
			sleepArriveAnim2 = sleepArriveAnim
			deepSleepAnim2 = sleepLoopAnims[v4]
			deepSleepCine2 = sleepPettingCine[v4]
			sleepContextAction2 = sleepContextAction
		elseif petEnergyPct <= 0.8 and petEnergyPct >= 0.1 then
			local v4 = __wf_atom_5784a397(1, #sitLoopAnims)
			sleepArriveAnim2 = sitArrriveAnim
			deepSleepAnim2 = sitLoopAnims[v4]
			deepSleepCine2 = sitPettingCines[v4]
			sleepContextAction2 = sitContextAction
		elseif petEnergyPct >= 0.8 then
			local v4 = __wf_atom_5784a397(1, #highEnergyLoopAnims)
			sleepArriveAnim2 = highEnergyArriveAnim
			deepSleepAnim2 = highEnergyLoopAnims[v4]
			deepSleepCine2 = highEnergyPettingCine[v4]
			sleepContextAction2 = highEnergyContextAction
		end

		object:Attach(deepSleepCine2, EMPTY_SYMBOL)
		local v4 = object:Attach(sleepContextAction2, offsetAttachBone, ctxOffSetVector, __wf_atom_80368bb1)

		if not __wf_atom_7e8ad928(v4) then
			v4:Enable()
		end

		if portforwarderTagToFire ~= EMPTY_SYMBOL then
			module4.TaggedFirePorts(portforwarderTagToFire, "TriggerPort")
		end

		if not __wf_atom_7e8ad928(_T.PupIsWet) and _T.PupIsWet == true and not __wf_atom_7e8ad928(pupWasWetAnim) then
			Sleep(1)

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_921c1a5f(pupWasWetAnim, true, 4, 1, true)
			end
		end

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_921c1a5f(sleepArriveAnim2, true, 4, 1, true)
		end

		if __wf_atom_7e8ad928(object) then
			return
		else
			object:__wf_atom_921c1a5f(deepSleepAnim2, true, 4, 2, false)
		end
	end
end

function PupNightfoldLeave(_, object)
	local sleepDepartAnim2 = nil

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_6115a2e2():__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		if module3.GetPetEnergyPct(__wf_atom_a96eb2aa) <= 0.1 then
			sleepDepartAnim2 = sleepDepartAnim
		elseif
			module3.GetPetEnergyPct(__wf_atom_a96eb2aa) <= 0.8
			and module3.GetPetEnergyPct(__wf_atom_a96eb2aa) >= 0.1
		then
			sleepDepartAnim2 = sitDepartAnim
		elseif module3.GetPetEnergyPct(__wf_atom_a96eb2aa) >= 0.8 then
			sleepDepartAnim2 = highEnergyDepartAnim
		end

		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
		local taggedChild = module4.FindTaggedChild(__wf_atom_be0bea4a, Symbol("PettingCTX"))
		local taggedChild2 = module4.FindTaggedChild(__wf_atom_be0bea4a, Symbol("PetOmenBeast"))

		if gRegion:IsMaster() then
			if not __wf_atom_7e8ad928(taggedChild) then
				taggedChild:Destroy()
			end

			if not __wf_atom_7e8ad928(taggedChild2) then
				taggedChild2:Destroy()
			end
		end

		if portforwarderTagToFire ~= EMPTY_SYMBOL then
			module4.TaggedFirePorts(portforwarderTagToFire, "TriggerPort")
		end

		object:__wf_atom_921c1a5f(sleepDepartAnim2, true, 4, 1, true)
	end
end

function SleepPoiLeave(_, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
	local taggedChild = module4.FindTaggedChild(__wf_atom_be0bea4a, Symbol("PettingCTX"))
	local taggedChild2 = module4.FindTaggedChild(__wf_atom_be0bea4a, Symbol("PetOmenBeast"))

	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Destroy()
		end

		if not __wf_atom_7e8ad928(taggedChild2) then
			taggedChild2:Destroy()
		end
	end

	object:__wf_atom_921c1a5f(nil, true, 4, 1, false)

	if portforwarderTagToFire ~= EMPTY_SYMBOL then
		module4.TaggedFirePorts(portforwarderTagToFire, "TriggerPort")
	end
end

function PetTransmission()
	local __wf_atom_0a6a5887 = __wf_atom_4ec12570:__wf_atom_0a6a5887(petDecoTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_921c1a5f(transmissionAnimation, true, true)
	end
end