local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("SF.Scripts.Libs.EncounterLib")
local module6 = require("SF.Scripts.FirstLoginUtils")
local module7 = require("Lotus.Interface.LotusUtilities")
local module8 = require("EE.Interface.Utilities")
local module9 = require("SF.Interface.SFUtilities")
local module10 = require("SF.Scripts.Libs.StatsLib")
local module11 = require("SF.Scripts.NightFoldLib")
local module12 = require("SF.Scripts.Libs.TransmissionSet")
local module13 = require("SF.Scripts.Libs.ModifySkyLib")
local v = nil
local v2 = nil
local v3 = false
local v4 = Type("/SF/Types/Gameplay/TeleportPlayersHereInstantlyScriptTrigger")
local flag = false
local v5 = WeakResource("/SF/Interface/QuestScreens/FactionChoice.swf")
local v6 = Type("/SF/Interface/FactionChoiceCameraSpot")
local v7 = { Symbol("ChampionSyndicate"), Symbol("SilentRoseSyndicate"), Symbol("FeySyndicate") }
local v8 = { Symbol("DescendantOfTethren"), Symbol("TricksterSirin"), Symbol("BabeOfOscelda") }
local v9 = {
	Symbol("Wield-Or-Yield"),
	Symbol("Baduns"),
	Symbol("Blue-Blood"),
	Symbol("Prove-Me-Wrong")
}
local v10 = nil
local v11 = nil
local v12 = {
	Resource("/SF/Upgrades/Skins/Head/ChildHeadA"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadB"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadC"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadD"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadE")
}

local function fn()
	if flag then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickTowerZone"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrlickTowerZone"))
		Sleep(0.1)
	end

	__wf_atom_0a6a5887:FirePort("Enable")
	local __wf_atom_80cf57aa = __wf_atom_0a6a5887:__wf_atom_80cf57aa()
	local v13 = math.max(__wf_atom_80cf57aa.x, __wf_atom_80cf57aa.y)
	local all = gRegion:FindAll(__wf_atom_f806fd7a, __wf_atom_0a6a5887:GetPosition(), 0, v13)
	local v14 = Symbol("StrongPointArea")

	for _, v15 in ipairs(all) do
		if not (module5.EncounterHintHasTag(v15, v14) and __wf_atom_0a6a5887:__wf_atom_1eaf335c(v15:GetPosition())) then
			continue
		end

		module5.SetEncounterHeaviesBlocked(v15, true)
		v15:__wf_atom_252fae6e(1)
	end

	module2.TaggedFirePorts(Symbol("TutorialZoneBlockDynamicCombat"), "Enable")
	flag = true
end

local function fn2(p, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_a2a18137 = __wf_atom_c4f78a8f:__wf_atom_a2a18137()
	local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
	__wf_atom_4e50d390.pitch = 0
	local v13 = __wf_atom_e97f3142(__wf_atom_4e50d390)
	v13.y = 0
	local v14 = __wf_atom_a2a18137 + v13 * 25
	local randomPointInRangeOnNav = v:__wf_atom_e8649655(v14, 5, 5, Symbol("Flat"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VIP Nav Volume"))

	if
		not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		and Distance(randomPointInRangeOnNav, __wf_atom_0a6a5887:GetPosition()) > 65
	then
		randomPointInRangeOnNav = v:__wf_atom_e8649655(__wf_atom_0a6a5887:GetPosition(), 5, 5, Symbol("Flat"))
	end

	if p then
		randomPointInRangeOnNav = v:GetRandomPointInRangeOnNav(
			randomPointInRangeOnNav,
			3,
			5,
			true,
			0.1,
			nil,
			true,
			Symbol("Flat")
		)
	end

	local dummyAgentType = dummyAgentType

	if p2 then
		dummyAgentType = heavyDummyAgentType
	end

	local selected

	if not __wf_atom_7e8ad928(dummyAgentType) then
		selected = v:__wf_atom_402b3832(
			dummyAgentType,
			randomPointInRangeOnNav,
			__wf_atom_fa8d0177(randomPointInRangeOnNav, __wf_atom_a2a18137),
			Symbol("RandomTeam"),
			1
		)
	end

	if __wf_atom_7e8ad928(selected) then
		local randomPointInRangeOnNav2 = v:GetRandomPointInRangeOnNav(
			__wf_atom_a2a18137,
			25,
			30,
			true,
			0.1,
			nil,
			true,
			Symbol("Flat")
		)
		selected = v:__wf_atom_402b3832(
			dummyAgentType,
			randomPointInRangeOnNav2,
			__wf_atom_fa8d0177(randomPointInRangeOnNav2, __wf_atom_a2a18137),
			Symbol("RandomTeam"),
			1
		)
	end

	local __wf_atom_50a7d83e = selected:__wf_atom_50a7d83e()
	module3.AddSparrowDestination(__wf_atom_50a7d83e, nil, nil, module3.PRIORITY.QUEST, nil, mOwner, v11)
	return selected
end

local function fn3(items)
	for _, item in pairs(items) do
		if
			__wf_atom_7e8ad928(item)
			or item:__wf_atom_50a7d83e():IsKilled()
			or item:__wf_atom_50a7d83e():__wf_atom_bedb4e3f()
		then
			continue
		end

		item:__wf_atom_30b587a4()
	end
end

local function fn4(p)
	local v13 = {}
	table.insert(v13, (fn2(false, p)))
	table.insert(v13, (fn2(true, false)))
	table.insert(v13, (fn2(true, false)))
	Sleep(1)
	fn3(v13)
	local flag2 = true

	while flag2 do
		flag2 = false

		for _, v14 in pairs(v13) do
			if
				__wf_atom_7e8ad928(v14)
				or __wf_atom_7e8ad928(v14:__wf_atom_50a7d83e())
				or v14:__wf_atom_50a7d83e():IsKilled()
				or v14:__wf_atom_50a7d83e():__wf_atom_bedb4e3f()
			then
				continue
			end

			flag2 = true
			break
		end

		Sleep(0.5)
	end
end

function SetupSky(p)
	local v13 = Symbol("OvercastSky")
	local v14 = Symbol("OvercastPostVolume")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v14)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v15 in ipairs(all) do
		if v15:__wf_atom_db682341() == v13 then
			v15:Enable(true)
			v15:SetTimeOfDay(p)
			v15:__wf_atom_e2779837(true)
		else
			v15:__wf_atom_e2779837(false)
			v15:Enable(false)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
		__wf_atom_0a6a5887:__wf_atom_e35eb214():__wf_atom_54a04966(0)
	end
end

local function fn5(p)
	local v13 = Symbol("TutorialSparrowNagTriggers")

	if p then
		module2.TaggedFirePorts(v13, "Enable")
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v13)

	for _, v14 in ipairs(__wf_atom_2226b35c) do
		v14:Destroy()
	end
end

local function fn6() -- 4 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(gGameData) then
		return true
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()
	local __wf_atom_df64c481 = gGameData:__wf_atom_df64c481()
	return __wf_atom_0cbd9965 ~= EMPTY_SYMBOL and __wf_atom_df64c481 and true or false
end

local function fn7(_, p)
	if not fn6() then -- inferred equivalent call
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if p == __wf_atom_eab484a7 then
			module6.LoadInitialGear()
			module6.GiveInitialGear(__wf_atom_eab484a7:__wf_atom_50a7d83e())
		end
	end
end

local function fn8(mOwner2, p, p2, p3, p4)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if _T.OnPlayerSpawnedCallbacks then
		_T.OnPlayerSpawnedCallbacks[p] = fn7
	end

	if (p4 == nil or p4) and __wf_atom_7e8ad928(v) then
		v = module2.WaitForAiDir()
	end

	if not module2.IsInOverworld() then
		print("Early out, this task doesn't run in dungeons")
		return
	end

	fn()
	module9.SetSoloPlayerMode(true)

	while module2.IsStreamingLevel() or not module2.HasStreamedLevel("/SF/Levels/Tent") do
		Sleep(0)
	end

	if p2 then
		module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldMarket"), "TriggerPort")
		module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldTree"), "TriggerPort")
	else
		module2.TaggedFirePorts(Symbol("Q1-HideNightfoldMarket"), "TriggerPort")
		module2.TaggedFirePorts(Symbol("Q1-HideNightfoldTree"), "TriggerPort")
	end

	v3 = false

	if p3 then
		module11.RegisterPreventNighfoldUsage(p3, nfBlockedId, true)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module6.LoadInitialGear()

	if not fn6() then -- inferred equivalent call
		if __wf_atom_c4f78a8f:IsA(childAvatarType) then
			local adultAvatar = __wf_atom_c4f78a8f:__wf_atom_e919fb8e().adultAvatar
			module6.GiveInitialGear(adultAvatar)
			adultAvatar:__wf_atom_68f2c268(1)
		else
			module6.GiveInitialGear(__wf_atom_c4f78a8f)
		end
	end

	module2.TaggedFirePorts(Symbol("RuinsAtGrandadsHouse"), "Disable")
	module9.BlockFastTravel(true)
	module.TrackQuest(mOwner)
	v2 = tostring(module.GetReadableTaskTag(mOwner2, p))
	print("Starting" .. v2)
	return true
end

local function fn9(p)
	if __wf_atom_7e8ad928(v2) then
		print("Finished task")
	else
		print("Finished " .. v2)
	end

	if _T.OnPlayerSpawnedCallbacks then
		_T.OnPlayerSpawnedCallbacks[p] = nil
	end

	module9.BlockFastTravel(false)
	module9.SetSoloPlayerMode(false)
	module.CompleteTaskWithID(mOwner, p)
end

local function fn10(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(p) or not (p and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(object) <= 50) then
		object:Attach(v4, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function CanShowMessage(instance, p, p2, p3)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_67c46eba) or instance:IsKilled() then
		return false
	end

	if not __wf_atom_7e8ad928(p2) and p3 < instance:__wf_atom_8a6b8fc3(p2) or not module2.IsInOverworld() then
		return false
	end

	if p or not module2.IsInNightFold(instance) then
		return true
	end

	return false
end

function DissolveOut(object)
	Sleep(1)
	local v13 = 0

	while v13 < 1 do
		v13 = __wf_atom_421b01aa(v13 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(v13)
		Sleep(0)
	end
end

function DissolveOutAndDestroy(p)
	DissolveOut(p)
	gRegion:__wf_atom_dd1e4d10(p)
end

function BloomHit()
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local v13 = 0

	while v13 < 1 do
		v13 = __wf_atom_421b01aa(v13 + __wf_atom_084b3e93(), 0, 1)
		local blur = __wf_atom_24a82b69(v13)
		__wf_atom_8ad59546.postProcess:__wf_atom_2bd5152a(1, 1, 1, blur * 2)
		__wf_atom_8ad59546.postProcessBias.bloom = blur * 4
		__wf_atom_8ad59546.postProcessBias.blur = blur
		Sleep(0)
	end

	local v14 = 0

	while v14 < 1 do
		v14 = __wf_atom_421b01aa(v14 + __wf_atom_084b3e93() * 0.25, 0, 1)
		local blur = __wf_atom_24a82b69(1 - v14)
		__wf_atom_8ad59546.postProcess:__wf_atom_2bd5152a(1, 1, 1, blur * 2)
		__wf_atom_8ad59546.postProcessBias.bloom = blur * 4
		__wf_atom_8ad59546.postProcessBias.blur = blur
		Sleep(0)
	end
end

function DissolveIn(object)
	Sleep(1)
	object:__wf_atom_8a035cd5(Symbol("BloomHit"), false)
	local v13 = 0

	while v13 < 1 do
		v13 = __wf_atom_421b01aa(v13 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(1 - v13)
		Sleep(0)
	end
end

function DissolveInAndBecome(p)
	DissolveIn(p)
	gRegion:__wf_atom_eab484a7():AssignAvatar(p)
end

function HideShowAncestorsStations(p)
	for _, v13 in pairs(ancestorsWeakRes) do
		module11.SetHideAncestorStation(v13, p)
	end
end

function GiveQuestOnFirstLogin()
	if gGameRules then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		__wf_atom_72fc675e.soloMode = false
		gGameRules:SetMission(__wf_atom_72fc675e)
	end

	if not fn6() then -- inferred equivalent call
		module6.LoadInitialGear()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		module6.GiveInitialGear(__wf_atom_c4f78a8f)
	end

	local firstQuestRes = firstQuestRes
	module.StartQuest(firstQuestRes)
	module13.SetWeatherCycleEnabled(true, 0, Symbol("DefaultMainSky"))
end

function P1WakeUp(p)
	if not fn8(mOwner, p, false, false) then
		return
	end

	_T.InTutorialBeforePactChoice = true
	_T.ProgressionScreenDisabled = true
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-WakeUp-TeleportLocation"))

	if v3 and _G.EnableDevTeleportToActiveStep then
		fn10(__wf_atom_0a6a5887, true)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v13 = nil

	while module2.IsInNightFold(__wf_atom_c4f78a8f) do
		Sleep(0)
		v13 = v13 or true
	end

	if v13 then
		Sleep(2)
	end

	module11.RegisterPreventNighfoldUsage(true, nfBlockedId, true)

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > 100
	then
		module2.Fade(true, 0.5, 1, true)
		local __wf_atom_dc309f8a = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
		__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_dc309f8a)
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
		Sleep(0.5)
	end

	module2.Fade(false, 0.5, 1, true)
	_T.Q1PlayedEnterHutCin = false
	fn5(true)
	Sleep(5)
	module12.WaitForTransmissions(true)
	local v14 = WeakResource("/SF/Interface/UpdatesInfoScreen.swf")
	local movie = __wf_atom_8e4fda44:FindMovie(v14)

	if not __wf_atom_7e8ad928(movie) then
		while not (__wf_atom_7e8ad928(__wf_atom_8e4fda44) or __wf_atom_7e8ad928(movie)) do
			Sleep(0.5)
		end

		Sleep(3)
	end

	module2.TaggedFirePorts(Symbol("FirstLoginQuestSetUp"), "TriggerPort")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-P1-Instrument"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		v10 = gRegion:CreateEntity(soulModeFxType, __wf_atom_0a6a5887_2:GetPosition(), __wf_atom_80368bb1)
		Sleep(0)

		if not __wf_atom_7e8ad928(v10) then
			v10:__wf_atom_b811702e(Symbol("SOUL_MODE_HIDDEN"))
		end
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-WakeUp-SparrowDestination"))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("IntroSparrowPath"))

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_4)) then
		module3.AddSparrowDestination(__wf_atom_0a6a5887_3, nil, "MapGuide", module3.PRIORITY.QUEST, nil, mOwner, p)
		module3.SetupWaypointPath("MapGuide", __wf_atom_0a6a5887_4)
	end

	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-P1-EnterHutTrigger"))

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) and __wf_atom_0a6a5887_5:IsEnabled() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	if __wf_atom_c4f78a8f:__wf_atom_08998754() == 4 then
		__wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_17c1c30f()
	end

	_T.HideAnimalTutorial = true
	module12.PlayGlobalTransmission(transmissionSet, Symbol("Rouse-Melodies"), false)
	Sleep(4)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		module3.RemoveSparrowDestination(__wf_atom_0a6a5887_3)
	end

	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-WakeUpHutInterior-SparrowDestination"))
	module3.AddSparrowDestination(__wf_atom_0a6a5887_6, nil, nil, module3.PRIORITY.QUEST, nil, mOwner, p)
	module3.SpawnSparrow(__wf_atom_c4f78a8f)
	__wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_9f4f79f7(true)
	_T.FirstLoginQuestFlootPickedUp = false

	while not _T.FirstLoginQuestFlootPickedUp do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v10) then
		v10:Destroy()
	end

	module9.RegisterHideHud(true)
	module3.RemoveSparrow()
	_T.SoulSongMusicPuzzleSuccess = false

	while not _T.SoulSongMusicPuzzleSuccess do
		Sleep(0)
	end

	_T.HideAnimalTutorial = false

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
		module3.RemoveSparrowDestination(__wf_atom_0a6a5887_6)
	end

	fn9(p)
end

local function fn11()
	local __wf_atom_dcecedb0 = gGameData:GetInventory():__wf_atom_3a61ed37():GetColor(0, 0):__wf_atom_dcecedb0()
	local v13 = 1

	for i, mMotherSkinColor in ipairs(module6.mMotherSkinColors) do
		if mMotherSkinColor:__wf_atom_dcecedb0() ~= __wf_atom_dcecedb0 then
			continue
		end

		v13 = i
		break
	end

	local v14 = Resource(v12[v13])

	if __wf_atom_7e8ad928(v14) then
		return nil
	end

	local v15

	if __wf_atom_7e8ad928(gGameData) then
		v15 = false
	else
		v15 = gGameData:__wf_atom_8856b776()
	end

	return (v14:__wf_atom_c4774ee9(v15 and 0 or 1, 0))
end

local function fn12(entity)
	if not __wf_atom_7e8ad928(entity) then
		local v13 = fn11()

		if not __wf_atom_7e8ad928(v13) then
			entity:__wf_atom_45cf0e1a(v13:__wf_atom_d24efbb2(), false, false)
			v13:__wf_atom_e6329949(1, entity)
		end
	end
end

local function fn13()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_c4f78a8f:IsA(childAvatarType) then
		local position = __wf_atom_c4f78a8f:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
		local entity = gRegion:CreateEntity(childAvatarType, position, __wf_atom_dc309f8a)
		gRegion:__wf_atom_eab484a7():AssignAvatar(entity)
		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.adultAvatar = __wf_atom_c4f78a8f
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local weaponCustomization = SF.WeaponCustomization()
		weaponCustomization:__wf_atom_2754430f(0, __wf_atom_e55d02aa:__wf_atom_eb82ab1f():GetColors(0))
		weaponCustomization:ApplyCustomization(entity)
		fn12(entity)
		__wf_atom_c4f78a8f:__wf_atom_68f2c268(1)
	end
end

function P1NightfoldIntro(p)
	if not fn8(mOwner, p, false, true) then
		return
	end

	fn9(p)
end

local function fn14(p)
	local v13 = WeakResource(p)
	local v14

	if __wf_atom_7e8ad928(v13) then
		v14 = nil
	else
		v14 = __wf_atom_8e4fda44:FindMovie(v13)

		if __wf_atom_7e8ad928(v14) then
			__wf_atom_8e4fda44:__wf_atom_3e5e23c0(v13, function(p2)
				v14 = p2
			end)
		end

		while __wf_atom_7e8ad928(v14) do
			Sleep(0)
		end

		v14:__wf_atom_62d09591(true)
	end

	while not __wf_atom_7e8ad928(v14) do
		Sleep(0)
	end

	print("closing movie")
end

local function fn15(object, p, p2)
	local total = 0

	while not __wf_atom_7e8ad928(object) and total < 1.5 do
		total += __wf_atom_084b3e93()
		object:__wf_atom_68f2c268(__wf_atom_104bfe98(p, p2, (math.min(total / 1.5, 1))))
		Sleep(0)
	end
end

function DissolveOutPillar(object)
	fn15(object, 0, 1)
	object:FirePort("Hide")
end

function DissolveInPillar(object)
	object:__wf_atom_68f2c268(1)
	object:FirePort("Show")
	fn15(object, 1, 0)
end

function OpenFactionChoiceScreen()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("IntroFactionChoicePillar"))

	for _, v13 in ipairs(__wf_atom_2226b35c) do
		v13:__wf_atom_8a035cd5(Symbol("DissolveOutPillar"), false)
	end

	local gameCamera = gRegion:GetGameCamera()
	local v13

	if not __wf_atom_7e8ad928(gameCamera) then
		v13 = gRegion:CreateEntity(v6, gameCamera:GetPosition(), gameCamera:__wf_atom_dc309f8a())
		v13:__wf_atom_888efbe9(gameCamera:__wf_atom_c277aed8())
		local cameraControl = gRegion:__wf_atom_c4f78a8f():CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:SetCameraSpot(v13, 0.1)
		end
	end

	fn14(v5)
	_T.InTutorialBeforePactChoice = false

	if v13 then
		gRegion:__wf_atom_dd1e4d10(v13)
	end
end

function FactionConfirmationPrompt(_)
	Sleep(2)

	while _T.TopMenuOpen do
		Sleep(1)
	end

	_T.FactionConfirmationPromptClosed = false
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.firstString = "/SF/Language/Menu/ConfirmPactSelectionYes"
	dialogSettings.secondString = "/SF/Language/Menu/ConfirmPactSelectionNo"
	dialogSettings.firstDelay = 2
	dialogSettings.secondDelay = 2

	if fn6() then -- inferred equivalent call
		dialogSettings.locString = "/SF/Language/Menu/FinishedTryingPacts"
		dialogSettings:SetCallback("FinishTryingPacts")
	else
		dialogSettings.titleString = gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_014a76a2():c_str()
		dialogSettings.locString = "/SF/Language/Menu/ConfirmPactSelection"
		dialogSettings:SetCallback("ConfirmFactionSelection")
	end

	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function OnDamaged(object)
	if not __wf_atom_7e8ad928(object) and object:__wf_atom_7470861b():__wf_atom_cd0c45b2() then
		object:SetHealth(object:GetMaxHealth())
	end
end

local function fn16() -- 6 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
		return
	end

	Sleep(0.3)
	_T.CurrentTutorialMessage = nil
	_T.HideImpactMessage()
	Sleep(0.3)
end

function P2NightfoldFactionSelection(p)
	if not fn8(mOwner, p, false, true) then
		return
	end

	module9.RegisterHideHud(false)
	_T.InTutorialBeforePactChoice = true
	_T.ProgressionScreenDisabled = true
	HideShowAncestorsStations(true)
	fn5(false)
	fn13()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-TreeActionWp"))
	local __wf_atom_be0bea4a = gRegion:__wf_atom_f738b4af(
		Symbol("WorldTreeAction"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		5
	):__wf_atom_be0bea4a()

	if #__wf_atom_be0bea4a > 0 then
		for i = 1, #__wf_atom_be0bea4a do
			__wf_atom_be0bea4a[i]:Destroy()
		end
	end

	module2.TaggedFirePorts(Symbol("Q1-P2NightfoldFactionSelectionSetup"), "TriggerPort")
	module2.PlayCinematicWithTagAndWait(Symbol("Q1-WakeUp-GoToNightfold"), false, nil, 0.5)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_799d95f5()) then
		_T.SkipNightfoldTransition = true
		Sleep(2)
		__wf_atom_c4f78a8f:GoToNightFold()
		local adultAvatar = __wf_atom_c4f78a8f:__wf_atom_e919fb8e().adultAvatar
		adultAvatar:__wf_atom_fb9d7578(true)
		adultAvatar:__wf_atom_972e5bcd()
		_T.SkipNightfoldTransition = nil
		Sleep(2)
	end

	while not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_799d95f5()) do
		Sleep(0)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("TentTestWp"))

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)) then
		module2.PlayCinematicWithTagAndWait(Symbol("Q1-P2-GranpaNightfoldCin"), false, nil, 0.5)
		Sleep(3)
		fn16() -- inferred equivalent call
	end

	module2.TaggedFirePorts(Symbol("Q1-P2-PostCinSetup"), "TriggerPort")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("IntroFactionChoicePillar"))

	for _, v13 in ipairs(__wf_atom_2226b35c) do
		v13:__wf_atom_8a035cd5(Symbol("DissolveInPillar"), false)
	end

	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-TreeActionWp"))
	local __wf_atom_be0bea4a2 = gRegion:__wf_atom_f738b4af(
		Symbol("WorldTreeAction"),
		__wf_atom_0a6a5887_3:GetPosition(),
		0,
		1
	):__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a2 do
		__wf_atom_be0bea4a2[i]:Destroy()
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		__wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
	end

	local v13 = Resource("/SF/Types/Player/NightFoldInputFilter")
	local __wf_atom_92aa9d91 = __wf_atom_c4f78a8f2:__wf_atom_92aa9d91()
	__wf_atom_92aa9d91:__wf_atom_17c1c30f()
	__wf_atom_92aa9d91:__wf_atom_8595f516()
	__wf_atom_92aa9d91:__wf_atom_9f4f79f7(true)
	__wf_atom_c4f78a8f2:__wf_atom_f747bba3(true)
	__wf_atom_c4f78a8f2:__wf_atom_cf966a74(v13)
	__wf_atom_c4f78a8f2:__wf_atom_cf966a74(childInputFilter)
	__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(false)
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

		for _, v14 in ipairs(__wf_atom_36b4a6e5) do
			if not __wf_atom_7e8ad928(v14) then
				v14:SetEnabled(true)
			end
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		__wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-P2-FactionChoice"))
	module3.AddSparrowDestination(__wf_atom_0a6a5887_4, nil, nil, module3.PRIORITY.QUEST, nil, mOwner, p)
	_T.NightfoldFactionChoice = true
	_T.FactionConfirmationPromptClosed = true
	module12.PlayGlobalTransmission(transmissionSet, Symbol("BloodAncestors"), false)
	_T.FinishedFactionChoiceLoop = false

	while _T.FinishedFactionChoiceLoop == false do
		if not (__wf_atom_7e8ad928(_T.FactionSelectionClosed) and __wf_atom_7e8ad928(_T.FactionConfirmationPromptClosed)) then
			if _T.FactionSelectionClosed then
				module3.RemoveSparrowDestination(__wf_atom_0a6a5887_4)
				__wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
				local __wf_atom_e55d02aa2 = __wf_atom_c4f78a8f2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
				local __wf_atom_1bb5b1ff = __wf_atom_e55d02aa2:__wf_atom_1bb5b1ff()
				__wf_atom_e55d02aa2:__wf_atom_5de8eac1((__wf_atom_c67f9605:__wf_atom_89d4ac2a(
					__wf_atom_c67f9605:__wf_atom_a1680b24(__wf_atom_1bb5b1ff),
					__wf_atom_1bb5b1ff
				)))

				if _T.FactionConfirmationPromptClosed then
					__wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
					__wf_atom_c4f78a8f2:__wf_atom_7470861b():__wf_atom_422ff021(true)
					__wf_atom_c4f78a8f2:__wf_atom_5a87af66("OnDamaged")

					if not __wf_atom_7e8ad928(testRangeMusic) and _T.ActiveLoopInstance == nil then
						_T.ActiveLoopInstance = module8.PlaySound(testRangeMusic)
					end

					_T.FactionSelectionClosed = false
					local v14 = v9[1]

					if not __wf_atom_7e8ad928(v14) then
						module12.PlayGlobalTransmission(transmissionSet, v14, false)
						table.remove(v9, 1)
					end

					fn4(false)

					if __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
						_T.CurrentTutorialMessage = "/SF/Language/Tutorial/SoulAbilities_KBM"
						_T.ShowImpactMessage("/SF/Language/Tutorial/SoulAbilities_KBM", -1)
					elseif _T.CurrentTutorialMessage ~= "/SF/Language/Tutorial/SoulAbilities_KBM" then
						fn16() -- inferred equivalent call
						_T.CurrentTutorialMessage = "/SF/Language/Tutorial/SoulAbilities_KBM"
						_T.ShowImpactMessage("/SF/Language/Tutorial/SoulAbilities_KBM", -1)
					end

					fn4(true)
					__wf_atom_c4f78a8f2:__wf_atom_7470861b():__wf_atom_422ff021(false)
					fn16() -- inferred equivalent call
					_T.playerSelfHeal = false
					module2.TaggedFirePorts(Symbol("FactionConfirmationTrigger"), "Execute")
				end
			end

			Sleep(2)
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(_T.ActiveLoopInstance) then
		_T.ActiveLoopInstance:Stop(false)
		_T.ActiveLoopInstance = nil
		module8.PlaySound(factionConfirmMusic)
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

	if not __wf_atom_7e8ad928(__wf_atom_0cbd9965) then
		for i = 1, #v7 do
			if __wf_atom_0cbd9965 == v7[i] then
				module12.PlayGlobalTransmission(transmissionSet, v8[_T.FirstLoginQuestCurrentFactionChoice], false)
			end
		end
	end

	__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(true)
	local __wf_atom_92aa9d91_2 = __wf_atom_c4f78a8f2:__wf_atom_92aa9d91()
	__wf_atom_92aa9d91_2:__wf_atom_9f4f79f7(false)
	__wf_atom_c4f78a8f2:__wf_atom_f747bba3(false)
	__wf_atom_92aa9d91_2:__wf_atom_17c1c30f()
	__wf_atom_92aa9d91_2:__wf_atom_8595f516()
	__wf_atom_c4f78a8f2:__wf_atom_aeb02c14(v13)
	local __wf_atom_e55d02aa2 = __wf_atom_c4f78a8f2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa2) then
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa2:__wf_atom_36b4a6e5()

		for _, v14 in ipairs(__wf_atom_36b4a6e5) do
			if not __wf_atom_7e8ad928(v14) then
				v14:SetEnabled(false)
			end
		end
	end

	_T.NightfoldFactionChoice = false
	_T.ProgressionScreenDisabled = false
	module3.RemoveSparrowDestination(__wf_atom_0a6a5887_4)
	fn9(p)
end

function P3NightfoldArsenal(p)
	if not fn8(mOwner, p, false, true) then
		return
	end

	v11 = p
	_T.ProgressionScreenDisabled = true
	HideShowAncestorsStations(true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("IntroNightfoldReturnPoint"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Missing nightfold exit waypoint!")
	else
		__wf_atom_c4f78a8f:__wf_atom_43b67ec1(__wf_atom_0a6a5887:GetPosition())
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("TentTestWp"))

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_799d95f5()) then
		module2.Fade(true, 0)
		Sleep(2)
		_T.SkipNightfoldTransition = true
		__wf_atom_c4f78a8f:GoToNightFold()
		__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887_2:GetPosition(), __wf_atom_0a6a5887_2:__wf_atom_dc309f8a())
		_T.SkipNightfoldTransition = nil
		Sleep(2)
		module2.Fade(false)
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-P3-MainTentRevealLookTrigger"))
	module3.AddSparrowDestination(__wf_atom_0a6a5887_3, nil, nil, module3.PRIORITY.QUEST, nil, mOwner, p)
	module2.TaggedFirePorts(Symbol("Q1-P3NightfoldArsenalSetup"), "TriggerPort")
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-TreeActionWp"))
	local __wf_atom_be0bea4a = gRegion:__wf_atom_f738b4af(
		Symbol("WorldTreeAction"),
		__wf_atom_0a6a5887_4:GetPosition(),
		0,
		1
	):__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		__wf_atom_be0bea4a[i]:Destroy()
	end

	module12.PlayGlobalTransmission(transmissionSet, Symbol("Hope-For-Minnow"), false)

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or module2.IsInNightFold(__wf_atom_c4f78a8f)) then
		module2.WaitToEnterNightfold()
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("NightfoldArsenal"))

	while not __wf_atom_0a6a5887_5:IsEnabled() do
		Sleep(0)
	end

	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("ArsenalWp"))
	module3.RemoveSparrowDestination(__wf_atom_0a6a5887_3)
	module3.AddSparrowDestination(__wf_atom_0a6a5887_6, nil, nil, module3.PRIORITY.QUEST, nil, mOwner, p)

	if __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
		_T.CurrentTutorialMessage = "/SF/Language/Tutorial/ExploreTheTent"
		_T.ShowImpactMessage("/SF/Language/Tutorial/ExploreTheTent", -1)
	elseif _T.CurrentTutorialMessage ~= "/SF/Language/Tutorial/ExploreTheTent" then
		fn16() -- inferred equivalent call
		_T.CurrentTutorialMessage = "/SF/Language/Tutorial/ExploreTheTent"
		_T.ShowImpactMessage("/SF/Language/Tutorial/ExploreTheTent", -1)
	end

	module2.TaggedFirePorts(Symbol("IntroQuestInTentMessage"), "Enable")
	_T.TutorialStepTalisman = true
	local v13 = WeakResource("/SF/Interface/Character.swf")
	local movie = __wf_atom_8e4fda44:FindMovie(v13)

	while __wf_atom_7e8ad928(movie) do
		movie = __wf_atom_8e4fda44:FindMovie(v13)
		Sleep(0.1)
	end

	if _T.TutorialHasTalisman then
		while not (__wf_atom_7e8ad928(movie) and _T.TutorialTalismanEquipped) do
			movie = __wf_atom_8e4fda44:FindMovie(v13)
			Sleep(0.1)
		end
	else
		while not __wf_atom_7e8ad928(movie) do
			Sleep(0.1)
		end
	end

	_T.TutorialStepTalisman = false
	module2.TaggedFirePorts(Symbol("IntroQuestInTentMessage"), "Disable")
	module3.RemoveSparrowDestination(__wf_atom_0a6a5887_6)
	module11.ClearPreventNighfoldUsage(nfBlockedId)
	fn5(false)
	_T.mCanJump = nil
	Sleep(1)

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and module2.IsInNightFold(__wf_atom_c4f78a8f) then
		if __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
			_T.CurrentTutorialMessage = "/SF/Language/Tutorial/ExitNightFold"
			_T.ShowImpactMessage("/SF/Language/Tutorial/ExitNightFold", -1)
		elseif _T.CurrentTutorialMessage ~= "/SF/Language/Tutorial/ExitNightFold" then
			fn16() -- inferred equivalent call
			_T.CurrentTutorialMessage = "/SF/Language/Tutorial/ExitNightFold"
			_T.ShowImpactMessage("/SF/Language/Tutorial/ExitNightFold", -1)
		end

		module2.WaitToExitNightfold()
	end

	HideShowAncestorsStations(false)
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

		for _, v14 in ipairs(__wf_atom_36b4a6e5) do
			if not __wf_atom_7e8ad928(v14) then
				v14:SetEnabled(true)
			end
		end
	end

	module3.RemoveSparrowDestination(nil, mOwner:GetName())
	Sleep(1)
	fn16() -- inferred equivalent call
	_T.ProgressionScreenDisabled = false
	fn9(p)
end

function P4UnlockMapTree(p)
	if not fn8(mOwner, p, false) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-P4-DebugTeleportLocation"))
	module2.WaitToExitNightfold()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > 100
	then
		module2.Fade(true, 0.5, 1, true)
		local __wf_atom_dc309f8a = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
		__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_dc309f8a)
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
		Sleep(0.5)
		module2.Fade(false, 0.5, 1, true)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("q1FirstEnemyEncounter"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Enable()
		__wf_atom_0a6a5887_2:Start()
	end

	Sleep(2)
	module2.TaggedFirePorts(Symbol("IntroTreeDiscover"), "TriggerPort")
	module3.RemoveSparrowDestination(nil, mOwner:GetName())
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("TreeWP"))
	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("BirdGuidePathTutStart"))
	module3.AddSparrowDestination(__wf_atom_0a6a5887_3, nil, "MapGuide", module3.PRIORITY.QUEST, nil, mOwner, p)
	module3.SetupWaypointPath("MapGuide", __wf_atom_0a6a5887_4)
	module12.PlayGlobalTransmission(transmissionSet, Symbol("Go-Play"), true)
	Sleep(1)
	module12.PlayGlobalTransmission(transmissionSet, Symbol("Appy-Bairnday"), true)
	module3.RemoveSparrow(playerAvatar)
	module4.UpdateOrAddHudTask(mOwner, p)
	Sleep(1.5)

	if not (__wf_atom_7e8ad928(playerAvatar) or __wf_atom_7e8ad928(tutorialTriggerType)) then
		playerAvatar:Attach(tutorialTriggerType, EMPTY_SYMBOL)
	end

	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("DiscoverTreeIntroTrigger"))
	local hasSpecificLoreMemoryUnlocked = module2.HasSpecificLoreMemoryUnlocked(playerAvatar, mapTreelore, memorySym)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("MapTreeJobBoard"),
		__wf_atom_0a6a5887_5:GetPosition(),
		0,
		100
	)

	while module2.IsInOverworld() do
		if __wf_atom_7e8ad928(playerAvatar) and not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
		end

		local v13, v14

		if hasSpecificLoreMemoryUnlocked then
			if
				__wf_atom_7e8ad928(playerAvatar)
				or __wf_atom_7e8ad928(__wf_atom_0a6a5887_5)
				or __wf_atom_0a6a5887_5:IsEnabled()
			then
				Sleep(0.5)
			else
				while not hasSpecificLoreMemoryUnlocked do
					if not module2.IsInOverworld() then
						return
					end

					if __wf_atom_7e8ad928(playerAvatar) and not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
						playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
					end

					hasSpecificLoreMemoryUnlocked = module2.HasSpecificLoreMemoryUnlocked(
						playerAvatar,
						mapTreelore,
						memorySym
					)
					Sleep(2)
				end

				v13 = gRegion:__wf_atom_0a6a5887(Symbol("IntroQuestThunder"))

				if not __wf_atom_7e8ad928(v13) then
					v13:Disable()
				end

				module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldMarket"), "TriggerPort")
				module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldTree"), "TriggerPort")
				v14 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-TreeActionWp"))
				gRegion:__wf_atom_f738b4af(Symbol("WorldTreeAction"), v14:GetPosition(), 0, 5):Attach(
					treeInteractionFX,
					EMPTY_SYMBOL,
					Vector(0, 2, 3)
				)
				module3.RemoveSparrowDestination(nil, "MapGuide")
				fn9(p)

				while not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_f738b4af:IsEnabled()) do
					Sleep(0)
				end

				if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
					__wf_atom_f738b4af:Disable()
				end

				break
			end
		elseif __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) or __wf_atom_0a6a5887_5:IsEnabled() then
			Sleep(0.5)
		else
			module4.RemoveHudTask(mOwner, nil, p)
			Sleep(4)
			module12.WaitForTransmissions(true)
			module4.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/CleanseTheCoruption")

			while not hasSpecificLoreMemoryUnlocked do
				if not module2.IsInOverworld() then
					return
				end

				if __wf_atom_7e8ad928(playerAvatar) and not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
					playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
				end

				hasSpecificLoreMemoryUnlocked = module2.HasSpecificLoreMemoryUnlocked(
					playerAvatar,
					mapTreelore,
					memorySym
				)
				Sleep(2)
			end

			v13 = gRegion:__wf_atom_0a6a5887(Symbol("IntroQuestThunder"))

			if not __wf_atom_7e8ad928(v13) then
				v13:Disable()
			end

			module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldMarket"), "TriggerPort")
			module2.TaggedFirePorts(Symbol("Q1-ShowNightfoldTree"), "TriggerPort")
			v14 = gRegion:__wf_atom_0a6a5887(Symbol("Q1-TreeActionWp"))
			gRegion:__wf_atom_f738b4af(Symbol("WorldTreeAction"), v14:GetPosition(), 0, 5):Attach(
				treeInteractionFX,
				EMPTY_SYMBOL,
				Vector(0, 2, 3)
			)
			module3.RemoveSparrowDestination(nil, "MapGuide")
			fn9(p)

			while not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_f738b4af:IsEnabled()) do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				__wf_atom_f738b4af:Disable()
			end

			break
		end
	end
end

function HandleEnterHutCin()
	if not _T.Q1PlayedEnterHutCin then
		local __wf_atom_be0bea4a = gRegion:__wf_atom_0a6a5887(Symbol("GrandfaDoorCineAction")):__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			__wf_atom_be0bea4a[i]:Destroy()
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local position = __wf_atom_c4f78a8f:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
		local entity = gRegion:CreateEntity(childAvatarType, position, __wf_atom_dc309f8a)
		entity:__wf_atom_68f2c268(1)
		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.adultAvatar = __wf_atom_c4f78a8f
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			LogBug("Player does not have active power suit. Avatar: " .. __wf_atom_c4f78a8f:GetName())
		end

		local weaponCustomization = SF.WeaponCustomization()
		weaponCustomization:__wf_atom_2754430f(0, __wf_atom_e55d02aa:__wf_atom_eb82ab1f():GetColors(0))
		weaponCustomization:ApplyCustomization(entity)
		fn12(entity)
		entity:__wf_atom_8a035cd5(Symbol("DissolveInAndBecome"), false)
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)

		if __wf_atom_7e8ad928(childInputFilter) or __wf_atom_7e8ad928(entity) then
			return
		end

		entity:__wf_atom_aeb02c14(childInputFilter)
		module2.PlayCinematicWithTagAndWait(Symbol("Q1-WakeUp-EnterHut"), false, nil, 0.5)
		_T.Q1PlayedEnterHutCin = true
	end
end

function FlootPickUp()
	_T.FirstLoginQuestFlootPickedUp = true
end

function StopEnemyPatrol(_, object)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b())) then
		object:__wf_atom_30e3d82b():SetPatrolRoute(nil)
	end
end

function PlayNimrodSequence()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodDecoIntro"))
	local position = __wf_atom_0a6a5887:GetPosition()

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("PlayTriggeredAnim")
	end

	Sleep(2)
	gRegion:CreateEntity(lightingFX, position, __wf_atom_80368bb1)
	Sleep(0.1)
	gRegion:CreateEntity(lightingExplosionFX, position, Rotation(0, 90, 0))
	Sleep(1.5)
	module12.PlayGlobalTransmission(transmissionSet, Symbol("NimrodThunder"), false)
end

local v13 = nil
local flag2 = nil
local v14 = nil
local firstSelectedLoadout = nil
local firstSupportedSyndicate = nil

local function fn17() -- 2 equivalent calls inferred from this helper
	_T.FactionConfirmationPromptClosed = true
	_T.FinishedFactionChoiceLoop = true
	gGameData:__wf_atom_cee160bc()
end

local function fn18()
	print("Called GiveGear")

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() and not gGameData:__wf_atom_df64c481() then
		local __wf_atom_d2b2176d = v13:__wf_atom_d2b2176d()
		local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
		local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()
		local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
		flag2 = true
		local __wf_atom_035fdfa8s = {
			__wf_atom_eb82ab1f:__wf_atom_035fdfa8(2),
			__wf_atom_eb82ab1f:__wf_atom_035fdfa8(3),
			__wf_atom_eb82ab1f:__wf_atom_035fdfa8(0)
		}

		for _, v15 in ipairs(__wf_atom_035fdfa8s) do
			assert(table.find(firstSelectedLoadout.gear, v15), "Invalid skin: " .. v15:__wf_atom_5b41f63b())
		end

		assert(
			table.find(firstSelectedLoadout.gear, __wf_atom_e55d02aa:__wf_atom_e14d8a8c()),
			"Invalid suit: " .. __wf_atom_e55d02aa:__wf_atom_5b41f63b()
		)
		assert(
			table.find(firstSelectedLoadout.gear, __wf_atom_9fb9a1d6:__wf_atom_e14d8a8c()),
			"Invalid weapon: " .. __wf_atom_9fb9a1d6:__wf_atom_5b41f63b()
		)
		local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(6)
		assert(
			not __wf_atom_7e8ad928(__wf_atom_035fdfa8) and table.find(module6.mInitialHeadSkins, __wf_atom_035fdfa8),
			"Invalid head skin"
		)
		table.insert(__wf_atom_035fdfa8s, __wf_atom_035fdfa8)
		local __wf_atom_035fdfa8_2 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(4)
		assert(
			not __wf_atom_7e8ad928(__wf_atom_035fdfa8_2) and table.find(module6.mInitialHairSkins, __wf_atom_035fdfa8_2),
			"Invalid hair skin"
		)
		table.insert(__wf_atom_035fdfa8s, __wf_atom_035fdfa8_2)
		ShowBlockingMessage(1)
		gGameData:__wf_atom_814c9017(
			__wf_atom_e55d02aa,
			__wf_atom_9fb9a1d6,
			__wf_atom_035fdfa8s,
			"OnSaveLoadOutComplete",
			firstSupportedSyndicate
		)
	else
		fn17() -- inferred equivalent call
	end
end

function CloseAfterLoadoutBuilt()
	while true do
		if not __wf_atom_7e8ad928(v13) then
			local __wf_atom_d2b2176d = v13:__wf_atom_d2b2176d()

			if not (__wf_atom_d2b2176d:__wf_atom_e65461b9() or __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_e55d02aa())) then
				break
			end
		end

		Sleep(0)
	end

	fn17() -- inferred equivalent call
	ShowBlockingMessage(0)
end

function ConfirmFactionSelection(p)
	if tonumber(p) == 4 then
		module8.PlaySound(factionConfirmUI)
		flag2 = true
		v13 = gRegion:__wf_atom_c4f78a8f()
		firstSelectedLoadout = _T.FirstSelectedLoadout
		firstSupportedSyndicate = _T.FirstSupportedSyndicate
		module10.ReplicateLogEvent("PROLOGUE_QUEST", "ChoosePact", firstSelectedLoadout.virtueName)
		fn18()
	else
		_T.FactionConfirmationPromptClosed = true

		if not __wf_atom_7e8ad928(_T.ActiveLoopInstance) then
			_T.ActiveLoopInstance:Stop(false)
			_T.ActiveLoopInstance = nil
		end

		OpenFactionChoiceScreen()
	end
end

function FinishTryingPacts(p)
	if tonumber(p) == 4 then
		module8.PlaySound(factionConfirmUI)
		_T.FactionConfirmationPromptClosed = true
		_T.FinishedFactionChoiceLoop = true
		v13 = gRegion:__wf_atom_c4f78a8f()
		module9.BuildLoadout(v13)
	else
		_T.FactionConfirmationPromptClosed = true

		if not __wf_atom_7e8ad928(_T.ActiveLoopInstance) then
			_T.ActiveLoopInstance:Stop(false)
			_T.ActiveLoopInstance = nil
		end

		OpenFactionChoiceScreen()
	end
end

function FadeWhenFinishedTryingPacts()
	module2.Fade(true, 0, 1, false)
end

function ConfirmLogOutOnFailure()
	print("ConfirmLogOutOnFailure")
	_T.BackgroundMovie:Execute("DoLogoff", "")
end

function OnSaveLoadOutComplete(p, _)
	if p then
		module7.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
		flag2 = false
		v14 = p
		WaitToRequestLoadOut()
	else
		ShowBlockingMessage(0)
		module8.ShowMessage("/Lotus/Language/Menu/BackgroundError_FailedToConnect", "ConfirmLogOutOnFailure")
	end
end

function OnUpdateSessionSettings()
	WaitToRequestLoadOut()
end

function WaitToRequestLoadOut()
	if flag2 then
		return
	end

	if v14 then
		v14 = false
		module7.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())

		if not __wf_atom_7e8ad928(v13) then
			v13:__wf_atom_8a035cd5(Symbol("CloseAfterLoadoutBuilt"), false)
		end
	end
end

function ShowBlockingMessage(p)
	print("ShowBlockingMessage " .. p)

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", (tostring(p)))
	end
end

function PlayTransmissions()
	for _, v15 in ipairs(transmissionTags) do
		module12.PlayLocalTransmission(transmissionSet, v15, gRegion:__wf_atom_c4f78a8f(), true)
	end
end

function SpawnHiddenChest(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(secretSpawnTag)
	local v15

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v15 = gRegion:CreateEntity(
			secretSpawnType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		local __wf_atom_bb3e7833 = v15:__wf_atom_bb3e7833(__wf_atom_0f45538d)

		while
			not __wf_atom_7e8ad928(v15)
			and not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
			and __wf_atom_bb3e7833:IsEnabled()
			and not __wf_atom_bb3e7833:__wf_atom_272baebc()
		do
			Sleep(0.2)
		end
	end

	if not __wf_atom_7e8ad928(v15) then
		module.CompleteTaskWithID(mOwner, p)
	end
end

function FadeChildToAdult(_, instance)
	if instance:IsA(childAvatarType) then
		local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
		gRegion:__wf_atom_eab484a7():AssignAvatar(__wf_atom_e919fb8e.adultAvatar)
		__wf_atom_e919fb8e.adultAvatar:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
		instance:__wf_atom_8a035cd5(Symbol("DissolveOutAndDestroy"), false)
	end
end

function FadeGrandfather(_, object)
	object:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
end