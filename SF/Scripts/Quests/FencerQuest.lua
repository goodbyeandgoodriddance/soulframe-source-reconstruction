local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
require("SF.Scripts.Libs.ConversationLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.RaycastLib")
local module7 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module8 = require("SF.Scripts.NightFoldLib")
local module9 = require("SF.Scripts.Libs.RespawnLib")
local module10 = require("Lotus.Scripts.Libs.AudioLib")
local module11 = require("EE.Interface.Utilities")
local module12 = require("SF.Interface.SFUtilities")
local v = nil
Symbol("PullWeaponCinDirectionWp")
local v2 = Symbol("ShipwreckHighlight")
local v3 = Vector(0, -150, 0)
local v4 = Symbol("FencerRibbonTrigger")
local v5 = Symbol("GhostShipOffshoreTrigger")
local v6 = WeakResource("/SF/Upgrades/Skins/Helmets/FencerQuestItemHelmet")
Symbol("SaboteurHub")
local v7 = Symbol("RandomTeam")
local v8 = Symbol("BlockingBehavior")
local v9 = nil
local level2 = nil
local v10 = nil
local v11 = Symbol("MestraFightState")
local v12 = Symbol("MestraDefeated")
local v13 = Symbol("MestraRibbonPicked")
local areaMarkerAtPos = {}

local function fn(object, object2)
	return object:__wf_atom_5b41f63b() < object2:__wf_atom_5b41f63b()
end

local function fn2(object)
	local __wf_atom_db682341s = {}

	for _, v14 in ipairs(interactableDecoTypes) do
		local all = gRegion:FindAll(v14)

		for _, v15 in ipairs(all) do
			local __wf_atom_db682341 = v15:__wf_atom_db682341()

			if __wf_atom_db682341 ~= EMPTY_SYMBOL then
				table.insert(__wf_atom_db682341s, __wf_atom_db682341)
			end
		end
	end

	for _, v14 in ipairs(__wf_atom_db682341s) do
		if not (__wf_atom_7e8ad928(object) or object:__wf_atom_db682341() ~= v14) then
			continue
		end

		_T.FencerTrackerCleared = false
		gGameData:__wf_atom_04988606(v14, "OnTrackerCleared")

		while not _T.FencerTrackerCleared do
			Sleep(0)
		end
	end
end

function AddSparrowShipwreckDest(p, p2, p3, p4)
	local v14 = "MestraShipwreck" .. p4
	module5.AddSparrowDestination(p, p2, v14, module5.PRIORITY.QUEST, Range(0, 3.4028234663852886e38), p2, p3)
end

function OnTrackerCleared(_)
	_T.FencerTrackerCleared = true
end

function DoTriggerFade()
	if shouldFade then
		module3.Fade(true, 0.5, -1, false)
		return
	end

	if shouldEquipWeapon then
		forceEquipTempItem()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FencerBossWp"))

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_fa8d0177(
			__wf_atom_c4f78a8f:GetPosition(),
			__wf_atom_0a6a5887:GetPosition()
		))
	end

	module3.Fade(false, 0.5, 0, false)
end

function SetUpShipWreck(_, _) end

function SpawnAncestorTransmission() end

function forceEquipTempItem()
	if __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v14 in pairs(__wf_atom_ef7900cf) do
		local __wf_atom_d2b2176d = v14:__wf_atom_d2b2176d()

		if gRegion:IsMaster() then
			local v15 = itemToEquip[3]

			if not __wf_atom_7e8ad928(_T.DuelWeapon) then
				v15 = itemToEquip[_T.DuelWeapon]
			end

			v14:GiveItem(v15, true)
		end

		__wf_atom_d2b2176d:__wf_atom_b9375444(false)
	end

	module3.BlockAbilities(true, true)
	module3.DeactivateAbilities(false, true, true)
end

function forceUnequipItem()
	if __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v14 in pairs(__wf_atom_ef7900cf) do
		local __wf_atom_d2b2176d = v14:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_b9375444(true)

		if not gRegion:IsMaster() then
			continue
		end

		__wf_atom_d2b2176d:Unequip(0, 1)
		module12.BuildLoadout(v14, v14:__wf_atom_a96eb2aa():__wf_atom_a4299765())
	end

	module3.BlockAbilities(false, true)
end

function AddLocalBoatLevelOffsetToVector(data)
	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	return (Vector(data.x - 250 * __wf_atom_7d5c620f, data.y, data.z - 250 * __wf_atom_7d5c620f))
end

function IsBoatLevelStreamed()
	local __wf_atom_b2b2c625 = gRegion:__wf_atom_b2b2c625()

	for _, v14 in ipairs(__wf_atom_b2b2c625) do
		local v15 = tostring(v14)

		if string.find(v15, "/SF/Levels/QuestLevels/PirateShip.level") then
			return true
		end
	end

	return false
end

function StreamBoatLevel(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if _T.mBoatLevelRequested ~= nil then
		return
	end

	if IsBoatLevelStreamed() then
		_T.mBoatLevelRequested = true
		return
	end

	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	print("I'm streaming into new level now. My playerId is", __wf_atom_7d5c620f)
	_T.mBoatLevelRequested = true
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = pirateBoatLevel
	levelArgs.streamingLayer = 350
	levelArgs.streamingMode = 1

	if p then
		levelArgs:__wf_atom_c4be912d(p)
	end

	levelArgs:__wf_atom_60471db9(AddLocalBoatLevelOffsetToVector(v3), __wf_atom_80368bb1)
	levelArgs.streamingPriority = 2
	Engine.StreamRegion(levelArgs)
end

function CheckBowEmote(object)
	if _T.BowEmoteCheckRunning then
		return
	end

	_T.BowEmoteCheckRunning = true
	local flag = false
	local flag2 = false
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v14

	if __wf_atom_7e8ad928(_T.fencerTimesDefeated) then
		v14 = 3
	else
		v14 = _T.fencerTimesDefeated + 1
	end

	while not __wf_atom_7e8ad928(object) and not flag and object:__wf_atom_bb81a9df() >= 1 do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		else
			local __wf_atom_1cfa7bd2 = __wf_atom_c4f78a8f:__wf_atom_1cfa7bd2()

			if __wf_atom_1cfa7bd2 == bowEmote then
				flag = true
				break
			end

			if __wf_atom_1cfa7bd2 == deepBowEmote then
				flag2 = true
				flag = true
				break
			end
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		if v14 == 3 then
			module4.PlayGlobalTransmission(ancestorTransmissionSet, Symbol("PlayerNoBowEnc3"), false)
		elseif flag2 then
			module4.PlayGlobalTransmission(ancestorTransmissionSet, playerDeepBowTransmissionTag[v14], false)
		elseif flag then
			module4.PlayGlobalTransmission(ancestorTransmissionSet, playerBowTransmissionTag[v14], false)
		else
			module4.PlayGlobalTransmission(ancestorTransmissionSet, playerNoBowTransmissionTag[v14], false)
		end
	end

	_T.BowEmoteCheckRunning = false
end

local function fn3(ancestorTransmissionSet, p, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("FencerAncestorWp"), __wf_atom_c4f78a8f:GetPosition())
	local position = nearestTagged:GetPosition()
	local appearAtPosition = module7.AppearAtPosition(
		__wf_atom_c4f78a8f,
		ancestorDecoType,
		position,
		nil,
		nearestTagged:__wf_atom_dc309f8a()
	)

	if __wf_atom_7e8ad928(appearAtPosition) then
		return nil
	end

	appearAtPosition:__wf_atom_68f2c268(0)

	if __wf_atom_7e8ad928(p2) then
		p2 = false
	end

	appearAtPosition:__wf_atom_8a035cd5(Symbol("AncestorDissolveIn"), not p2)

	if not __wf_atom_7e8ad928(ancestorTransmissionSet) then
		module4.PlayRadialTransmission(ancestorTransmissionSet, p, position, 100, true)
	end

	return appearAtPosition
end

function AncestorDissolveIn(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	module7.DissolveIn(p)
end

function GiveFightRewards()
	if not __wf_atom_7e8ad928(rewardBpType) then
		gRegion:__wf_atom_c4f78a8f():GiveItem(rewardBpType, false)
	end
end

function GiveQuestRewards(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PlayerProgressCelebration"), false)
	end

	fn2()
	module.CompleteTaskWithID(mOwner, p)
end

function PlayerProgressCelebration(_)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local v14 = {}

	for _, v15 in ipairs(__wf_atom_ef7900cf) do
		if __wf_atom_7e8ad928(v15) then
			continue
		end

		local __wf_atom_a96eb2aa = v15:__wf_atom_a96eb2aa()

		if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
			gGameRules:__wf_atom_8085277a(
				__wf_atom_a96eb2aa,
				"/SF/Language/Quests/FencerPactQuestCompleted",
				1,
				Symbol("Default"),
				cjson.encode(v14)
			)
		end
	end
end

function OnInventoryCommitCallback()
	gGameData:SyncInventoryFromDB("EmptyCallback")
end

function CheckForItem(p)
	if module3.AnyPlayerHasItem(hubTaskItem) then
		module.CompleteTaskWithID(p)
	end
end

function FencerInteraction()
	IsBoatLevelStreamed()
end

local function fn4(object)
	object:Disable()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	__wf_atom_3d96ddcd:SetVisibility(false, false)
	local __wf_atom_db682341 = __wf_atom_3d96ddcd:__wf_atom_db682341()

	if __wf_atom_db682341 ~= EMPTY_SYMBOL then
		gGameData:__wf_atom_a975522c(__wf_atom_db682341, 14400, true, "")
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("ShipwreckHighlight"), __wf_atom_3d96ddcd:GetPosition())
	nearestTagged:__wf_atom_68f2c268(0)
	nearestTagged:SetVisibility(false, true)

	for k, fencerTrigger in pairs(_T.FencerTriggers) do
		if fencerTrigger ~= object then
			continue
		end

		table.remove(_T.FencerTriggers, k)
		break
	end
end

local function fn5(object)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FencerFightTrigger"))
	local v14 = __wf_atom_2226b35c[1]

	for _, v15 in pairs(__wf_atom_2226b35c) do
		if v15:IsEnabled() or v15 == object then
			continue
		end

		v14 = v15
		break
	end

	_T.FencerTriggers = _T.FencerTriggers or {}
	local __wf_atom_3d96ddcd = v14:__wf_atom_3d96ddcd()
	__wf_atom_3d96ddcd:SetVisibility(true, false)
	v14:Enable()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("ShipwreckHighlight"), __wf_atom_3d96ddcd:GetPosition())
	nearestTagged:__wf_atom_68f2c268(0)
	nearestTagged:SetVisibility(true, true)

	if module.HasCompletedQuest(questResource) then
		fn2(object:__wf_atom_3d96ddcd())
	else
		table.insert(_T.FencerTriggers, v14)
	end
end

function fadeInPirate(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v14 = 1.5 + math.random() * 0.6
	object:__wf_atom_68f2c268(1)
	local v15 = v14

	while v15 >= 0 do
		object:__wf_atom_68f2c268(v15 / v14)
		v15 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	object:__wf_atom_68f2c268(0)
end

local function fn6()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FencerPirateEnemyWp"))
	local result = {}

	for i = 1, math.min(#__wf_atom_2226b35c, numOfPirates) do
		local v14 = Vector(0.5 - math.random(), 0, 0.5 - math.random())
		local __wf_atom_402b3832 = v10:__wf_atom_402b3832(
			fencerPirateEnemyType,
			__wf_atom_2226b35c[i]:GetPosition() + v14,
			__wf_atom_2226b35c[i]:__wf_atom_dc309f8a(),
			v7,
			level2
		)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			continue
		end

		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("fadeInPirate"), false)
		end

		Sleep((i - 1) * 0.35)
		__wf_atom_402b3832:__wf_atom_30b587a4()
		__wf_atom_402b3832:StormTarget(gRegion:__wf_atom_c4f78a8f(), 12)
		table.insert(result, __wf_atom_402b3832)
	end

	return result
end

local function fn7(list)
	for k, v14 in pairs(list) do
		if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v14:__wf_atom_50a7d83e()) or v14:__wf_atom_50a7d83e():IsKilled()) then
			continue
		end

		table.remove(list, k)
	end

	return list
end

local function fn8()
	if not __wf_atom_7e8ad928(dropTable) then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for _, v14 in pairs(__wf_atom_3c8e1a7a) do
			local playerAvatar = v14:GetPlayerAvatar(0)

			if not __wf_atom_7e8ad928(playerAvatar) then
				dropTable:__wf_atom_0ad20b11(playerAvatar, gRegion:__wf_atom_c4f78a8f(), __wf_atom_e93896ba, level2)
			end
		end
	end
end

function PrepCin(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if not __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		module3.UnequipWeapon(__wf_atom_02a7a2f4, true)
		Sleep(0)
	end
end

function DissolveOutWeaponHighlightFx(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v14 = 0

	while v14 < 1 do
		v14 = __wf_atom_421b01aa(v14 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v14 / 1)
		Sleep(0)
	end

	object:SetVisibility(false, true)
end

local function fn9(object, object2, p)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	__wf_atom_3d96ddcd:GetPosition()
	__wf_atom_3d96ddcd:__wf_atom_dc309f8a()
	local groundPos = module6.GetGroundPos(__wf_atom_3d96ddcd:GetPosition())

	if __wf_atom_7e8ad928(groundPos) then
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v2, __wf_atom_3d96ddcd:GetPosition(), 0, 10)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:__wf_atom_8a035cd5(Symbol("DissolveOutWeaponHighlightFx"), false)
	end

	local __wf_atom_b6b760b5 = __wf_atom_3d96ddcd:__wf_atom_b6b760b5()

	if __wf_atom_7e8ad928(__wf_atom_b6b760b5) or __wf_atom_7e8ad928(pullWeaponCins) or #pullWeaponCins == 0 then
		return
	end

	local v14 = 1

	for i = 1, #weaponMeshTypes do
		if not __wf_atom_b6b760b5:IsA(weaponMeshTypes[i]) then
			continue
		end

		v14 = i
		break
	end

	if #pullWeaponCins < v14 or __wf_atom_7e8ad928(pullWeaponCins[v14]) then
		return
	end

	local pullWeaponCin = pullWeaponCins[v14]
	local entity = gRegion:CreateEntity(pullWeaponCin, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object2, object2)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	local __wf_atom_38aeafad = entity:__wf_atom_38aeafad()

	if __wf_atom_7e8ad928(__wf_atom_38aeafad) then
		return
	end

	for i = #__wf_atom_38aeafad, 1, -1 do
		if not (__wf_atom_38aeafad[i] == Symbol("Envoy") or __wf_atom_38aeafad[i] == Symbol("CinematicCamera") or __wf_atom_38aeafad[i] == Symbol("DRTRAIL0")) then
			continue
		end

		table.remove(__wf_atom_38aeafad, i)
	end

	if #__wf_atom_38aeafad == 0 then
		return
	end

	local v15 = __wf_atom_38aeafad[1]
	local __wf_atom_99c400ff, _ = entity:__wf_atom_99c400ff(Symbol("Envoy"), 0)
	local __wf_atom_99c400ff2, _ = entity:__wf_atom_99c400ff(v15, 0)

	if __wf_atom_7e8ad928(__wf_atom_99c400ff) or __wf_atom_7e8ad928(__wf_atom_99c400ff2) then
		return
	end

	local distance2d = module3.Distance2d(__wf_atom_99c400ff, __wf_atom_99c400ff2)
	local groundPos2 = module6.GetGroundPos(__wf_atom_3d96ddcd:GetPosition() + __wf_atom_9341614d(
		Vector(0, 0, distance2d),
		Rotation(__wf_atom_fa8d0177(__wf_atom_3d96ddcd:GetPosition(), object2:GetPosition()).heading, 0, 0)
	))
	local v16 = __wf_atom_fa8d0177(groundPos2, groundPos)
	entity:Teleport(__wf_atom_3d96ddcd:GetPosition() - __wf_atom_9341614d(__wf_atom_99c400ff2, v16), v16)
	entity:SetInstigatorAvatar(object2)
	entity:__wf_atom_a3d2b66b(__wf_atom_3d96ddcd, v15)
	entity:FirePort("StartPlaying")
	local nearestTagged = gRegion:FindNearestTagged(Symbol("FencerAncestorWp"), object2:GetPosition())
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	local __wf_atom_936e9564 = object2:CameraControl():__wf_atom_936e9564()
	local v17 = 0

	while
		not __wf_atom_7e8ad928(object2)
		and not object2:IsKilled()
		and not __wf_atom_7e8ad928(entity)
		and entity:__wf_atom_7d4910e4()
		and not entity:__wf_atom_e9546dc6()
	do
		v17 = __wf_atom_421b01aa(v17 + __wf_atom_03df4e1d(), 0, 2)

		if p and v17 < 2 and not __wf_atom_7e8ad928(nearestTagged) then
			local v18 = __wf_atom_24a82b69(v17 / 2)
			local v19 = __wf_atom_fa8d0177(object2:GetPosition(), nearestTagged:GetPosition())

			if __wf_atom_936e9564 then
				v19.heading += 20
			else
				v19.heading -= 20
			end

			object2:__wf_atom_f0f9fb38((__wf_atom_9d2f097a(__wf_atom_4e50d390, v19, v18)))
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	__wf_atom_3d96ddcd:SetVisibility(false, true)
end

function WatchPlayerRespawn()
	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v11, 0)

	while __wf_atom_d163c8e5 ~= 1 do
		module9.UpdateBlightZone()
		Sleep(0)
		__wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v11, 0)
	end

	forceUnequipItem()
	Sleep(5)
	module9.DeactivateBlightZone(true)
end

function HandleRespawn(p)
	module3.Fade(true, 0.5, -1, false)
	EnableBlightZoneRespawning(p)
	WatchPlayerRespawn()
end

function PrepareShipCine(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ShowPirateShipPort"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("TriggerPort")
	end

	gRegion:__wf_atom_0a6a5887(Symbol("PirateShipWaterPlane")):SetMaterialParam(
		Symbol("ShipCapsule2"),
		8.75,
		0,
		10,
		6.5
	)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("FencerBoss"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		local __wf_atom_30e3d82b = __wf_atom_0a6a5887_2:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v8, __wf_atom_0a6a5887_2)
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v8)
			__wf_atom_0a6a5887_2:__wf_atom_921c1a5f(nil, false)
			__wf_atom_0a6a5887_2:GiveItem(bossSword, true)
		end
	end

	PrepareFencerCine(p)
end

function PrepareFencerCine(object)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v14 in pairs(__wf_atom_a8553251) do
		if v14:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v14, Symbol("Envoy"))
			end
		else
			v14:__wf_atom_a7ee9662(false, true)
		end
	end
end

function RestoreAvatarLocalVis()
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v14 in pairs(__wf_atom_a8553251) do
		if not v14:__wf_atom_4417a5d4() then
			v14:__wf_atom_a7ee9662(true, true)
		end
	end
end

local function fn10()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FencerBoss"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_4d75e5e7()
		Sleep(0)
		gRegion:__wf_atom_dd1e4d10(__wf_atom_0a6a5887)
	end
end

function CheckAnyInNightfold()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local count = #__wf_atom_ef7900cf
	local count2 = 0

	for _, v14 in ipairs(__wf_atom_ef7900cf) do
		if not module3.IsInNightFold(v14) then
			count2 += 1
		end
	end

	if count2 < count then
		_T.ShowImpactMessage("/SF/Language/SystemMessages/HUD_PlayersWaitingAtExtraction", 3, nil, nil, {
			NumAvatarsInside = count2,
			Capacity = count
		})
	end

	return count2 < count
end

function FencerCombat(object, object2)
	module3.SetImmunity(gRegion:__wf_atom_c4f78a8f(), true)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local position = __wf_atom_3d96ddcd:GetPosition()
	local __wf_atom_dc309f8a = __wf_atom_3d96ddcd:__wf_atom_dc309f8a()
	_T.FightEnded = false

	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(v11, 0)
	end

	if __wf_atom_7e8ad928(_T.fencerTimesDefeated) then
		_T.fencerTimesDefeated = 0
	end

	if not gRegion:IsMaster() then
		return
	end

	if CheckAnyInNightfold() then
		object:Enable()
		return
	end

	fn10()
	gGameRules:HideGameSession(true)
	_T.FencerBowDone = 0
	_T.PirateLevelStreamed = true
	SetUpFencerQuest()

	if IsBoatLevelStreamed() then
		BoatLevelSkySetUp()
	end

	local v14

	if not __wf_atom_7e8ad928(blockingHint) then
		v14 = gRegion:CreateEntity(blockingHint, object:GetPosition(), __wf_atom_80368bb1)
	end

	local v15 = nil
	v9 = object
	module8.RegisterPreventNighfoldUsage(true)
	module8.SetPreventNightfoldUsageReason(module8.BT_COMBAT)
	module12.BlockFastTravel(true)
	fn9(object, object2, false)

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		gGameRules:HideGameSession(false)
		__wf_atom_3d96ddcd:__wf_atom_f4133158()
		__wf_atom_3d96ddcd:Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_3d96ddcd:SetVisibility(true, true)
		object:Enable()
	else
		if not (__wf_atom_7e8ad928(blightzoneEnablerTrigger) or __wf_atom_7e8ad928(object2)) then
			v = gRegion:CreateEntity(
				blightzoneEnablerTrigger,
				object2:GetPosition(),
				__wf_atom_80368bb1,
				nil,
				nil,
				ObjectType_RM_REPLICATED
			)
		end

		if module.HasCompletedQuest(questResource) then
			Sleep(1)
		end

		if not __wf_atom_7e8ad928(shipLevelEnterSound) then
			module10.PlaySound(shipLevelEnterSound)
		end

		__wf_atom_3d96ddcd:__wf_atom_f4133158()
		__wf_atom_3d96ddcd:Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_3d96ddcd:SetVisibility(true, true)

		if __wf_atom_7e8ad928(object) then
			return
		end

		if not __wf_atom_7e8ad928(v15) then
			v15:Destroy()
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			print("Nil host player avatar, falling back to trigger position")
			_T.PossitionBeforeTeleport = object:GetPosition()
		else
			_T.PossitionBeforeTeleport = __wf_atom_c4f78a8f:GetPosition()
		end

		if CheckAnyInNightfold() then
			module3.WaitToExitNightfold(true)
		end

		object:Enable()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PirateShipTp"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			for _, v16 in pairs(gRegion:__wf_atom_ef7900cf()) do
				v16:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
			end
		end

		Sleep(0)
		v10 = module3.WaitForAiDir()
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("FencerBossWp"))
		local v16 = nil
		local v17 = v7
		level2 = level
		local v18 = {}
		local v19 = _T.fencerTimesDefeated and _T.fencerTimesDefeated == 2 and true or false
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("FencerHandshake"))
		gRegion:FindNearestTagged(Symbol("FencerAncestorWp"), _T.PossitionBeforeTeleport)
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("FencerHandshakeAvatar"))
		local nearestTagged = gRegion:FindNearestTagged(Symbol("FencerWakeUpPos"), _T.PossitionBeforeTeleport)
		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("FencerWakeUpCin"))

		if not __wf_atom_7e8ad928(nearestTagged) then
			if v19 and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
				__wf_atom_0a6a5887_3:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
			end

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
				__wf_atom_0a6a5887_5:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			v16 = v10:__wf_atom_402b3832(
				fencerBossType,
				__wf_atom_0a6a5887_2:GetPosition(),
				__wf_atom_0a6a5887_2:__wf_atom_dc309f8a(),
				v17,
				level2
			)
		end

		_T.FencerFightDeath = false
		__wf_atom_3d96ddcd:SetVisibility(true, true)
		Sleep(0)
		local v20

		if not __wf_atom_7e8ad928(v16) then
			v20 = v16:__wf_atom_50a7d83e()

			if module.HasCompletedQuest(questResource) then
				if not (__wf_atom_7e8ad928(fadeFromWhiteTriggerType) or __wf_atom_7e8ad928(object2)) then
					Sleep(0.5)
					gRegion:CreateEntity(
						fadeFromWhiteTriggerType,
						object2:GetPosition(),
						__wf_atom_80368bb1,
						nil,
						nil,
						ObjectType_RM_REPLICATED
					)

					if not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(bowAnim)) then
						v20:__wf_atom_921c1a5f(bowAnim, false, 3, 1)
					end
				end
			else
				gRegion:__wf_atom_0a6a5887(Symbol("PirateIntroCin")):__wf_atom_a3d2b66b(v20, Symbol("Mestra"))
				module4.PlayGlobalTransmission(
					ancestorTransmissionSet,
					boatIntroTransmissionTag[_T.fencerTimesDefeated + 1],
					false
				)
				module3.PlayCinematicWithTagAndWait(Symbol("PirateIntroCin"))

				if not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(flourishAnim)) then
					v20:__wf_atom_921c1a5f(flourishAnim, false, 3, 1)
				end
			end

			Sleep(1)
			v16:__wf_atom_f54283ea()
			module3.SetImmunity(gRegion:__wf_atom_c4f78a8f(), false)

			if __wf_atom_7e8ad928(v16) then
				print("FencerCombat: Boss is nil!")
				return
			end

			v20:__wf_atom_8a035cd5(Symbol("CheckBowEmote"), false)
			v20:SetFaction(v17)
			Sleep(2)
			local v21 = _T.fencerTimesDefeated + 1
			local v22 = false
			local total = 0
			local flag = false

			while
				not __wf_atom_7e8ad928(v20)
				and v20:__wf_atom_bb81a9df() > 0.05
				and not (v20:__wf_atom_bedb4e3f() or v22 or _T.FencerFightDeath)
			do
				if total >= 30 and v20:__wf_atom_bb81a9df() > 0.1 and (not v19 or #v18 > 1) then
					module4.PlayGlobalTransmission(ancestorTransmissionSet, Symbol("RandomTaunts" .. v21))
					total = 0
				elseif not module4.TransmissionPlaying() then
					total += __wf_atom_084b3e93()
				end

				if v19 then
					if flag then
						v18 = fn7(v18)

						if #v18 < 1 then
							v22 = true
						end
					elseif v20:__wf_atom_bb81a9df() < 0.5 then
						module3.SetImmunity(v20, true)
						local taggedChild = module3.FindTaggedChild(
							v16:__wf_atom_50a7d83e():__wf_atom_be0bea4a(),
							Symbol("BossAwarenessTrigger")
						)

						if not __wf_atom_7e8ad928(taggedChild) then
							taggedChild:Disable()
							taggedChild:Destroy()
						end

						v20:SetFaction(Symbol("TENNO"))
						v20:__wf_atom_2f3f52aa(-3)
						v20:__wf_atom_8d98f2fc(false, false, false)
						module4.CloseTransmissions()
						module4.PlayGlobalTransmission(ancestorTransmissionSet, Symbol("MestraDefeated"), false)
						module4.PlayGlobalTransmission(ancestorTransmissionSet, Symbol("PirateInvasion"), false)
						module4.PlayGlobalTransmission(ancestorTransmissionSet, Symbol("MestraAid"), false)
						local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("PirateEndCin"))

						if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
							__wf_atom_0a6a5887_6:__wf_atom_a3d2b66b(v20, Symbol("Mestra"))
						end

						local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

						if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
							local __wf_atom_92aa9d91 = __wf_atom_c4f78a8f2:__wf_atom_92aa9d91()

							if __wf_atom_92aa9d91:__wf_atom_5d790fbf() == v20 then
								__wf_atom_92aa9d91:__wf_atom_70c1e444()
							end
						end

						module3.PlayCinematicWithTagAndWait(Symbol("PirateEndCin"), nil, nil, 2)
						v16:__wf_atom_920a5a62()

						if _T.FencerFightDeath then
							break
						end

						v18 = fn6()
						v21 += 1
						flag = true
					end
				end

				Sleep(0)
			end

			module3.SetImmunity(v20, true)
		end

		_T.FightEnded = true
		gGameRules:HideGameSession(false)

		if module.HasCompletedQuest(questResource) then
			fn5(object)
		end

		if _T.FencerFightDeath then
			fn10()

			if v19 then
				local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("HidePirateShipPort"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
					__wf_atom_0a6a5887_6:FirePort("TriggerPort")
				end

				for _, v21 in pairs(v18) do
					local __wf_atom_50a7d83e = v21:__wf_atom_50a7d83e()

					if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
						continue
					end

					__wf_atom_50a7d83e:__wf_atom_4d75e5e7()
					Sleep(0)
					gRegion:__wf_atom_dd1e4d10(__wf_atom_50a7d83e)
				end
			end

			if not __wf_atom_7e8ad928(v14) then
				v14:Destroy()
			end

			if not module.HasCompletedQuest(questResource) then
				fn5(object)
			end

			module8.RegisterPreventNighfoldUsage(false)
			module12.BlockFastTravel(false)
			gGameRules:SetNetPersistentVar(v11, 1)
			Sleep(1)
			gGameRules:__wf_atom_0ab0a47f(v11, 0)
		else
			if not v19 then
				module3.SetImmunity(gRegion:__wf_atom_c4f78a8f(), true)

				if not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(v16)) then
					v16:__wf_atom_b414eabf()
					v16:__wf_atom_aa4361c1(v8, v20)
					v20:__wf_atom_d2b2176d():__wf_atom_d5651846()

					if not module.HasCompletedQuest(questResource) then
						module4.PlayGlobalTransmission(
							ancestorTransmissionSet,
							shootTransmissionTag[_T.fencerTimesDefeated + 1],
							false
						)
					end

					if not (__wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(Symbol("PirateShotCin")))) or __wf_atom_7e8ad928(v20)) then
						module3.UnequipWeapon(v20, true)
						v20:GiveItem(pistolWeapon, true)
						v16:__wf_atom_42b767a2(v8)
						v20:__wf_atom_921c1a5f(nil, false)
						local v21 = Symbol("KillShotInvuln")
						local __wf_atom_7470861b = v20:__wf_atom_7470861b()
						__wf_atom_7470861b:__wf_atom_9fba31e6(v21, 26, 6, 0)
						__wf_atom_7470861b:__wf_atom_a8705ecf(v21, 26, 6, 0)
						__wf_atom_7470861b:__wf_atom_b7a4551c(v21, 26, 6, 0)
						__wf_atom_7470861b:__wf_atom_180051f1()
						__wf_atom_7470861b:__wf_atom_77b5f32e(v21)
						module3.PlayCinematicWithTagAndWait(Symbol("PirateShotCin"))
					end
				end
			end

			if not __wf_atom_7e8ad928(v20) then
				v20:__wf_atom_4d75e5e7()
				Sleep(0)

				if not __wf_atom_7e8ad928(v20) then
					gRegion:__wf_atom_dd1e4d10(v20)
				end
			end

			fn4(object)

			if v19 and not (__wf_atom_7e8ad928(fadeToWhiteTriggerType) or __wf_atom_7e8ad928(object2)) then
				gRegion:CreateEntity(
					fadeToWhiteTriggerType,
					object2:GetPosition(),
					__wf_atom_80368bb1,
					nil,
					nil,
					ObjectType_RM_REPLICATED
				)
			end

			if not __wf_atom_7e8ad928(shipLevelExitSound) then
				module10.PlaySound(shipLevelExitSound)
			end

			Sleep(1)

			for _, v21 in pairs(gRegion:__wf_atom_ef7900cf()) do
				if v21:__wf_atom_bedb4e3f() then
					v21:SetHealth(v21:GetMaxHealth(true))
				end

				v21:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
			end

			module3.SetImmunity(gRegion:__wf_atom_c4f78a8f(), false)
			Sleep(1)

			if gRegion:IsMaster() then
				gGameRules:SetNetPersistentVar(v11, 1)
			end

			if not v19 then
				WakeUpAtBeach()
			end

			if not __wf_atom_7e8ad928(v14) then
				v14:Destroy()
			end

			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
				Symbol("ShipwreckHighlight"),
				object:__wf_atom_3d96ddcd():GetPosition(),
				0,
				10
			)

			if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				__wf_atom_f738b4af:__wf_atom_68f2c268(0)
				__wf_atom_f738b4af:SetVisibility(false, true)
			end

			if v19 then
				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
					if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
						__wf_atom_0a6a5887_3:__wf_atom_a3d2b66b(__wf_atom_0a6a5887_4, Symbol("Mestra"))
					end

					module3.PlayCinematicWithTagAndWait(Symbol("FencerHandshake"))

					if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
						__wf_atom_0a6a5887_4:Destroy()
					end
				end
			else
				Sleep(4)

				if not module.HasCompletedQuest(questResource) then
					local v21 = fn3(ancestorTransmissionSet, dueloSuccessTransmission[_T.fencerTimesDefeated + 1])
					module7.DissolveOut(v21)
					Sleep(1)
					module4.PlayGlobalTransmission(
						ancestorTransmissionSet,
						dueloSuccessVanishTransmission[_T.fencerTimesDefeated + 1],
						true
					)
				end
			end

			module8.RegisterPreventNighfoldUsage(false)
			module12.BlockFastTravel(false)

			if module.HasCompletedQuest(questResource) then
				local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("FencerWakeUpCin"))

				while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) and __wf_atom_0a6a5887_6:__wf_atom_7d4910e4() do
					Sleep(0)
				end

				fn8()
			end

			_T.FencerDefeated = true

			if v19 then
				fn2()
			end

			Sleep(5)
			module9.DeactivateBlightZone()

			if not __wf_atom_7e8ad928(v) then
				v:Destroy()
			end

			gGameRules:__wf_atom_0ab0a47f(v11, 0)
		end
	end
end

function SetUpFencerQuest()
	if not IsBoatLevelStreamed() then
		_T.PirateLevelStreamed = false
		StreamBoatLevel("PirateBoatLevelLoaded")
	end
end

function StartFencerQuest(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if not (gRegion:IsMaster() and module3.IsInOverworld()) then
		return
	end

	fn2()
	local nearestTagged = gRegion:FindNearestTagged(v4, gRegion:__wf_atom_c4f78a8f():GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		local __wf_atom_3d96ddcd = nearestTagged:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			local __wf_atom_db682341 = __wf_atom_3d96ddcd:__wf_atom_db682341()

			if __wf_atom_db682341 ~= EMPTY_SYMBOL then
				gGameData:__wf_atom_a975522c(__wf_atom_db682341, 1, false, "")
			end
		end
	end

	local v14 = fn3(ancestorTransmissionSet, ancestorTransmissionTag)

	if not __wf_atom_7e8ad928(v14) then
		module7.DissolveOut(v14)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function DoKillShot(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:SetHealth(100, false)
	local v14 = Symbol("KillShotInvuln")
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(v14, 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_a8705ecf(v14, 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_b7a4551c(v14, 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_180051f1()
	__wf_atom_7470861b:__wf_atom_77b5f32e(v14)

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v8, object)
	end

	local v15 = 5

	while
		not __wf_atom_7e8ad928(object)
		and (object:__wf_atom_bedb4e3f() or object:__wf_atom_58dabbc7() or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59())
		and v15 > 0
	do
		v15 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		_T.WaitForShoot = 0
		__wf_atom_30e3d82b:__wf_atom_cca1dc04(shootPower, gRegion:__wf_atom_c4f78a8f(), false)
		local total = 0

		while _T.WaitForShoot == 0 and total < 4 do
			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end
end

local function fn11()
	for i = #areaMarkerAtPos, 1, -1 do
		local v14 = areaMarkerAtPos[i]
		table.remove(areaMarkerAtPos, i)
		module5.RemoveSparrowDestination(v14)
		module.DestroyAreaMarker(v14)
	end
end

function FindRibbonTask(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if module3.IsInOverworld() then
		_T.GhostShipStage = ghostShipStage
		_T.FencerRibbonFound = false
		module2.UpdateOrAddHudCounterTask(mOwner, p, nil, shipwrecksCompleted, 3)

		if gRegion:IsMaster() then
			EnableAvailableRibbons(p)
			gGameRules:SetNetPersistentVar(v13, 0)
		end

		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v13, 0)

		while __wf_atom_d163c8e5 ~= 1 do
			Sleep(0.5)
			__wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v13, 0)
		end

		module2.UpdateOrAddHudCounterTask(mOwner, p, nil, shipwrecksCompleted + 1, 3)
		fn11()
		local v14 = fn3(ancestorTransmissionSet, ancestorTransmissionTag)

		if not __wf_atom_7e8ad928(v14) then
			module7.DissolveOut(v14)
		end

		if gRegion:IsMaster() then
			gGameRules:__wf_atom_0ab0a47f(v13, 0)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end

local function fn12(p, p2)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if gRegion:IsMaster() and module3.IsInOverworld() then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

		if #__wf_atom_2226b35c < 1 then
			return
		end

		for k, v14 in pairs(__wf_atom_2226b35c) do
			local __wf_atom_3d96ddcd = v14:__wf_atom_3d96ddcd()

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				local __wf_atom_db682341 = __wf_atom_3d96ddcd:__wf_atom_db682341()

				if __wf_atom_db682341 ~= EMPTY_SYMBOL and not gGameData:__wf_atom_b3cdb701(__wf_atom_db682341) then
					__wf_atom_3d96ddcd:SetVisibility(true, false)
					v14:Enable()
					local areaMarkerAtPos2 = module.CreateAreaMarkerAtPos(
						v14:GetPosition(),
						100,
						__wf_atom_28d5d4aa,
						mOwner,
						p2
					)
					table.insert(areaMarkerAtPos, areaMarkerAtPos2)
					AddSparrowShipwreckDest(areaMarkerAtPos2, mOwner, p2, k)
				end
			end

			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v5, v14:GetPosition(), 0, 100)

			if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				__wf_atom_f738b4af:FirePort("Enable")
			end
		end
	end
end

function EnableAllFights()
	fn12(Symbol(""))
end

function EnableAvailableRibbons(p)
	fn12(v4, p)
end

function DisableAllRibbons(p)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if gRegion:IsMaster() and module3.IsInOverworld() then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v4)

		if #__wf_atom_2226b35c < 1 then
			return
		end

		local position = gRegion:__wf_atom_c4f78a8f():GetPosition()

		for _, v14 in pairs(__wf_atom_2226b35c) do
			local __wf_atom_3d96ddcd = v14:__wf_atom_3d96ddcd()

			if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:__wf_atom_db682341() == EMPTY_SYMBOL then
				continue
			end

			if __wf_atom_3d96ddcd:__wf_atom_a5304c35(position) > 50 then
				__wf_atom_3d96ddcd:SetVisibility(false, true)
			end

			v14:Disable()
		end

		module3.TaggedFirePorts(v5, "Disable")
		module.CompleteTaskWithID(mOwner, p)
	end
end

local function fn13()
	local v14 = 1

	for i = 1, #weaponMeshTypes do
		if not weaponMesh:IsA(weaponMeshTypes[i]) then
			continue
		end

		v14 = i
		break
	end

	local pullWeaponCin = pullWeaponCins[v14]
	local entity = gRegion:CreateEntity(pullWeaponCin, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	local __wf_atom_38aeafad = entity:__wf_atom_38aeafad()

	for i = #__wf_atom_38aeafad, 1, -1 do
		if not (__wf_atom_38aeafad[i] == Symbol("Envoy") or __wf_atom_38aeafad[i] == Symbol("CinematicCamera") or __wf_atom_38aeafad[i] == Symbol("DRTRAIL0")) then
			continue
		end

		table.remove(__wf_atom_38aeafad, i)
	end

	if #__wf_atom_38aeafad == 0 then
		return
	end

	local __wf_atom_99c400ff, _ = entity:__wf_atom_99c400ff(__wf_atom_38aeafad[1], 0)
	gRegion:__wf_atom_dd1e4d10(entity)

	for _, fencerTrigger in pairs(_T.FencerTriggers) do
		local __wf_atom_3d96ddcd = fencerTrigger:__wf_atom_3d96ddcd()
		local groundPos = module6.GetGroundPos(__wf_atom_3d96ddcd:GetPosition(), nil, nil, {
			__wf_atom_3d96ddcd:__wf_atom_1bb5b1ff()
		})
		local v15 = Vector(groundPos.x, groundPos.y, groundPos.z)
		v15.y += __wf_atom_99c400ff.y
		__wf_atom_3d96ddcd:SetPosition(v15)
		__wf_atom_3d96ddcd:SetVisibility(true, false)

		if not __wf_atom_7e8ad928(weaponMesh) then
			__wf_atom_3d96ddcd:__wf_atom_45cf0e1a(weaponMesh, false, false)
		end

		fencerTrigger:Enable()
	end
end

local function fn14(taskId)
	fn13()

	for k, fencerTrigger in pairs(_T.FencerTriggers) do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

				if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()

					if not __wf_atom_7e8ad928(__wf_atom_eb82ab1f) then
						local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(0)

						if
							not __wf_atom_7e8ad928(__wf_atom_035fdfa8)
							and __wf_atom_035fdfa8 == WeakResource("/SF/Upgrades/Skins/Helmets/FencerQuestItemHelmet")
						then
							local nearestTagged = gRegion:FindNearestTagged(
								Symbol("ShipwreckHighlight"),
								fencerTrigger:GetPosition()
							)

							if not __wf_atom_7e8ad928(nearestTagged) then
								nearestTagged:__wf_atom_68f2c268(0)
								nearestTagged:SetVisibility(true, true)
							end
						end
					end
				end
			end
		end

		if __wf_atom_7e8ad928(fencerTrigger) then
			continue
		end

		local areaMarkerAtPos2 = module.CreateAreaMarkerAtPos(
			fencerTrigger:GetPosition(),
			100,
			__wf_atom_28d5d4aa,
			mOwner,
			taskId
		)
		AddSparrowShipwreckDest(areaMarkerAtPos2, mOwner, taskId, k)
		table.insert(areaMarkerAtPos, areaMarkerAtPos2)
		_T.MestraQuestInfo = { owner = mOwner, taskId = taskId }
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v5, fencerTrigger:GetPosition(), 0, 100)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			__wf_atom_f738b4af:FirePort("Enable")
		end
	end
end

local function fn15(list, _)
	local v14 = __wf_atom_04d7eaaa()
	__wf_atom_01bfe5c4(gGameRules:__wf_atom_d7c43e35())
	table.sort(list, fn)
	local seededShuffleTable = module11.SeededShuffleTable(list)
	__wf_atom_01bfe5c4(v14)
	_T.FencerTriggers = {}

	for i = 1, #seededShuffleTable do
		local __wf_atom_3d96ddcd = seededShuffleTable[i]:__wf_atom_3d96ddcd()
		local _EMPTY_SYMBOL = EMPTY_SYMBOL

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			continue
		end

		local __wf_atom_db682341 = __wf_atom_3d96ddcd:__wf_atom_db682341()

		if __wf_atom_db682341 == EMPTY_SYMBOL or gGameData:__wf_atom_b3cdb701(__wf_atom_db682341) then
			continue
		end

		table.insert(_T.FencerTriggers, seededShuffleTable[i])
	end

	if #_T.FencerTriggers < 1 then
		table.insert(_T.FencerTriggers, seededShuffleTable[__wf_atom_5784a397(1, #seededShuffleTable)])
	end

	return true
end

function DefeatFencerTask(taskId)
	module3.WaitForLevel()
	module3.WaitForLoginSequence()

	if module3.IsInOverworld() then
		_T.fencerTimesDefeated = fencerTimesDefeated
		_T.FencerTriggers = {}
		_T.DuelWeapon = fencerTimesDefeated + 1

		if __wf_atom_7e8ad928(_T.FencerTriggers) or not (#_T.FencerTriggers >= 1) then
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FencerFightTrigger"))

			if #__wf_atom_2226b35c < 1 then
				print("No fencer triggers found")
				return
			end

			if not fn15(__wf_atom_2226b35c, 3 - fencerTimesDefeated) then
				print("Fencer Quest Error: Not enough triggers for the ammount wanted active")
				return
			end
		end

		gRegion:__wf_atom_c4f78a8f()
		_T.GhostShipStage = ghostShipStage
		fn14(taskId)
		_T.FencerDefeated = false

		if gRegion:IsMaster() then
			gGameRules:SetNetPersistentVar(v12, fencerTimesDefeated)
		end

		local flag = false
		local total = 0

		if WearFencerHelmCondition(nil, gRegion:__wf_atom_c4f78a8f()) then
			module2.UpdateOrAddHudTask(mOwner, taskId)
		end

		while not _T.FencerDefeated do
			if total >= 3 then
				if flag or WearFencerHelmCondition(nil, gRegion:__wf_atom_c4f78a8f()) then
					if flag and WearFencerHelmCondition(nil, gRegion:__wf_atom_c4f78a8f()) then
						module2.UpdateOrAddHudTask(mOwner, taskId, taskLocString)
						flag = false
					end
				else
					module2.UpdateOrAddHudTask(mOwner, taskId, "/SF/Language/Quests/FencerPactQuestEquipRibbon")
					flag = true
				end

				total = 0
			else
				total += 0.5
			end

			if not gRegion:IsMaster() and gGameRules:__wf_atom_d163c8e5(v12, 0) > fencerTimesDefeated then
				_T.FencerDefeated = true
			end

			Sleep(0.5)
		end

		if gRegion:IsMaster() then
			gGameRules:SetNetPersistentVar(v12, fencerTimesDefeated + 1)
		end

		if flag then
			module2.UpdateOrAddHudTask(mOwner, taskId)
		end

		if fencerTimesDefeated >= 2 then
			module3.StreamAndPlayCinematicLevel(LevelWeakRes, false, false)
			fn2()
			Sleep(1)
		end

		_T.DuelWeapon = nil
		module2.CompleteHudTask(mOwner, nil, taskId, module2.COMPLETETIME)
		Sleep(module2.COMPLETETIME)
		fn11()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FencerWakeUpCin"))

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		if gRegion:IsMaster() then
			module.CompleteTaskWithID(mOwner, taskId)
		end
	end
end

function BeMasterAndHaveHelm(p, p2)
	if gRegion:IsMaster() then
		return WearFencerHelmCondition(p, p2)
	end

	return false
end

function WearFencerHelmCondition(_, object)
	if __wf_atom_7e8ad928(object) or object ~= gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0) then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return false
	end

	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()

	if __wf_atom_7e8ad928(__wf_atom_eb82ab1f) then
		return false
	end

	local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(0)
	return not __wf_atom_7e8ad928(__wf_atom_035fdfa8) and __wf_atom_035fdfa8 == v6
end

function AllPlayersKilled()
	if _T.FencerQuestAllPlayersKilledActive ~= nil then
		return
	end

	_T.FencerQuestAllPlayersKilledActive = true
	gRegion:__wf_atom_ef7900cf()
	local v14 = false

	while not v14 do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		v14 = true

		for i = 1, #__wf_atom_ef7900cf do
			local v15 = __wf_atom_ef7900cf[i]

			if not (__wf_atom_7e8ad928(v15) or v15:__wf_atom_bedb4e3f() or v15:IsKilled()) then
				continue
			end

			v14 = false
			break
		end

		Sleep(0)
	end

	module9.DeactivateBlightZone()

	if not __wf_atom_7e8ad928(shipLevelExitDeathSound) then
		module10.PlaySound(shipLevelExitDeathSound)
	end

	if gRegion:IsMaster() then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("FencerWakeUpPos"), _T.PossitionBeforeTeleport)
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for i = 1, #__wf_atom_ef7900cf do
			local v15 = __wf_atom_ef7900cf[i]

			if not __wf_atom_7e8ad928(v15) then
				v15:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
			end
		end

		forceUnequipItem()
	end

	if not gRegion:IsMaster() then
		return
	end

	WakeUpAtBeach()

	if not module.HasCompletedQuest(questResource) then
		module4.PlayGlobalTransmission(
			ancestorTransmissionSet,
			dueloFailTransmissionTag[_T.fencerTimesDefeated + 1],
			false
		)
	end

	Sleep(1)
	_T.FencerFightDeath = true
	_T.FencerQuestAllPlayersKilledActive = nil
end

function AllPlayersRespawned()
	Sleep(3)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v14 in pairs(__wf_atom_a8553251) do
		v14:Teleport(_T.PossitionBeforeTeleport, __wf_atom_80368bb1)
	end

	module3.Fade(false, 1, 1, false)
	_T.FencerFightDeath = true
	module9.DeactivateBlightZone()
end

function EnableBlightZoneRespawning(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local _allPlayersKilled = AllPlayersKilled
	module9.ActivateBlightZone(nil, true, true, false, AllPlayersKilled)
end

function ShipZoneAttib(object)
	Sleep(0)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PirateShipWaterPlanes"))

	while not __wf_atom_7e8ad928(object) do
		local v14 = Rotation()
		v14.pitch = Noise(Time() * 0.03) * 15
		v14.bank = Noise(3 + Time() * 0.02) * 10
		object:__wf_atom_9b788a35(v14)
		v14.pitch = -v14.pitch
		v14.bank = -v14.bank

		for i = 1, #__wf_atom_2226b35c do
			__wf_atom_2226b35c[i]:__wf_atom_9b788a35(v14)
		end

		Sleep(0)
	end
end

function GiveQuestBlueprint(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local EMPTY_SYMBOL2 = EMPTY_SYMBOL

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		EMPTY_SYMBOL2 = __wf_atom_3d96ddcd:__wf_atom_db682341()
	end

	if EMPTY_SYMBOL2 ~= EMPTY_SYMBOL then
		gGameData:__wf_atom_a975522c(EMPTY_SYMBOL2, 1, false, "")
	end

	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(v13, 1)
	end

	_T.FencerRibbonFound = true
	__wf_atom_3d96ddcd:SetVisibility(false, false)
end

function PirateBoatLevelLoaded(p, p2)
	if __wf_atom_7e8ad928(p) then
		print("PIRATEBOATLEVEL: Failed to destroy level on layer " .. p2)
		_T.PirateLevelStreamed = false
	else
		print("PIRATEBOATLEVEL: Level on layer " .. p2 .. " fully destroyed")
		_T.PirateLevelStreamed = true
	end

	BoatLevelSkySetUp()
end

function BoatLevelSkySetUp()
	local v14 = not _T.fencerTimesDefeated and 0 or _T.fencerTimesDefeated

	if module.HasCompletedQuest(questResource) then
		v14 = __wf_atom_5784a397(0, 2)
	end

	local v15 = not (v14 > 0)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PirateShipMoonVfx"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetVisibility(v15, true)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PirateShipSky"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("PirateShipWaterPlane"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	__wf_atom_0a6a5887_2:SetMaterialParam(Symbol("ShipCapsule2"), 8.75, 0, 10, 0)

	if v14 and v14 ~= 0 then
		if v14 and v14 == 1 then
			__wf_atom_0a6a5887:__wf_atom_a887a262(0, __wf_atom_0a6a5887:__wf_atom_807f6a09(2))
			__wf_atom_0a6a5887:SetMaterialParam(Symbol("TintColor"), 0.37, 0.42, 0.42, 0)
		elseif v14 and v14 == 2 then
			__wf_atom_0a6a5887:__wf_atom_a887a262(0, __wf_atom_0a6a5887:__wf_atom_807f6a09(3))
			__wf_atom_0a6a5887:SetMaterialParam(Symbol("TintColor"), 0.088, 0.088, 0.088, 0)
		end
	else
		__wf_atom_0a6a5887:__wf_atom_a887a262(0, __wf_atom_0a6a5887:__wf_atom_807f6a09(1))
		__wf_atom_0a6a5887:SetMaterialParam(Symbol("TintColor"), 0.37, 0.42, 0.42, 0)
	end
end

function WakeUpAtBeach()
	gRegion:__wf_atom_0a6a5887(Symbol("FencerWakeUpCin"))
	gRegion:__wf_atom_c4f78a8f()
	module3.PlayCinematicWithTagAndWait(Symbol("FencerWakeUpCin"))
end

function GhostShipAppearance(object)
	_T.GhostShipStage = _T.GhostShipStage or 1

	if __wf_atom_7e8ad928(ghostShipWaypoint) then
		print("Missing ghost ship waypoint!")
		return
	end

	local v14 = math.min((_T.GhostShipStage - 1) / 4, 5)
	local v15 = Range(0.6, 0.8)
	local v16 = Range(175, 275)
	local __wf_atom_1c8f7b2d = ghostShipWaypoint:__wf_atom_1c8f7b2d(object)
	v16.maxValue = math.min(v16.maxValue, __wf_atom_1c8f7b2d)
	v16.minValue = math.min(v16.maxValue, v16.minValue)
	local v17 = __wf_atom_104bfe98(v16.maxValue, v16.minValue, v14)
	local v18 = math.min(1, __wf_atom_1c8f7b2d / v17)
	local v19 = __wf_atom_104bfe98(v15.minValue, v15.maxValue, v14) * v18
	local position = object:GetPosition()
	local position2 = ghostShipWaypoint:GetPosition()
	position.y = position2.y
	local v20 = position + __wf_atom_9341614d(Vector(0, 0, v17), __wf_atom_fa8d0177(position, position2))
	local v21 = Rotation(45, 0, 0)
	local v22 = __wf_atom_d919c2d7(__wf_atom_fa8d0177(position2, position), v21)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GhostShipOffshoreDeco"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887 = gRegion:CreateEntity(ghostShipDecoType, v20, v22)
	else
		__wf_atom_0a6a5887:SetVisibility(false, false)
		__wf_atom_0a6a5887:Teleport(v20, v22)
	end

	__wf_atom_0a6a5887:SetMeshScale(v19)
	__wf_atom_0a6a5887:__wf_atom_68f2c268(1)
	__wf_atom_0a6a5887:SetVisibility(true, false)
	local v23 = 2

	while v23 >= 0 do
		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end

		__wf_atom_0a6a5887:__wf_atom_68f2c268(v23 / 2)
		v23 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_0a6a5887:__wf_atom_68f2c268(0)
	__wf_atom_7e8ad928(object)
end

function BlockConvo(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not __wf_atom_c4f78a8f:__wf_atom_4417a5d4() then
		return
	end

	if module3.PlayerIsInBattle(__wf_atom_c4f78a8f) then
		_T.ShowImpactMessage(postConverationImpactMessage, 3)
		return false
	end

	if module.HasCompletedQuest(completedQuestWeakRes) then
		return true
	end

	return false
end

function ShowCarmo(_, _)
	if __wf_atom_7e8ad928(mestraInstance) then
		return
	end

	if module.HasCompletedQuest(completedQuestWeakRes) then
		AncestorDissolveIn(mestraInstance)
		mestraInstance:__wf_atom_48fa6bc4()
	else
		mestraInstance:__wf_atom_d30cffc0()
		mestraInstance:SetVisibility(false, false)
	end
end