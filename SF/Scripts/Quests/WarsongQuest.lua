local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.QuestFunctionsLib")
local module3 = require("SF.Scripts.Quests.QuestTools.QuestStateHandler")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local module7 = require("SF.Scripts.NightFoldLib")
local module8 = require("SF.Scripts.Libs.AvatarLib")
local module9 = require("SF.Scripts.Libs.TransmissionSet")
local module10 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module11 = require("SF.Scripts.Libs.EncounterLib")
local module12 = require("EE.Interface.Utilities")
local module13 = require("SF.Types.Items.Consumables.WolfSummon")
local module14 = require("Lotus.Scripts.Libs.AudioLib")
local module15 = require("SF.Scripts.Libs.CinematicLib")
local module16 = require("SF.Scripts.Libs.ModifySkyLib")
local v = nil
local v2 = Vector(-0.15, 0, -0.15)
local v3 = nil
Symbol("WarsongQuest-P9-AcornGateDoorTrigger")
local v4 = Symbol("WarsongQuest-P09-BayorDeerTrigger")
local v5 = Symbol("WarsongQuest-P11-FishGateDoorTrigger")
WeakResource("/SF/Interface/Minigames/Fish.swf")
local v6 = Symbol("WarsongQuest-P12-HorseGateDoorTrigger")
WeakResource("/SF/Levels/Procs/FallenFortress/FFxDeepWater")
local v7 = nil
local v8 = nil
local v9 = false
local v10 = nil
local completetime = module10.COMPLETETIME
local v11 = nil
local v12 = { courage = 0, grace = 0, spirit = 0, total = 0 }
v12.courage = 0
v12.grace = 0
v12.spirit = 0
v12.total = 0
local v13 = { courage = 0.5, grace = 0.1, spirit = 0.2 }
local v14 = Type("/SF/Types/Input/BossIntroForceWalkInputFilter")
local v15 = Type("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon")
local v16 = Type("/SF/Souls/Corrupted/CorruptedSoul")

local function fn(mOwner, p, p2)
	_T.ProgressionScreenDisabled = true
	module4.WaitForLevel()
	module4.WaitForLoginSequence()

	if not module4.IsInOverworld() then
		return false
	end

	if (p2 == nil or p2) and __wf_atom_7e8ad928(v7) then
		v7 = module4.WaitForAiDir()
	end

	while module4.IsStreamingLevel() do
		Sleep(0)
	end

	v10 = false

	if not __wf_atom_7e8ad928(v7) then
		v7:__wf_atom_7c91fbf5(false)
	end

	module5.BlockFastTravel(true)
	_T.DisableSquadLevelScalling = disableSquadLevelScalling
	v8 = tostring(module.GetReadableTaskTag(mOwner, p))
	print("Starting" .. v8)
	return true
end

function IntroContinue()
	v9 = true
end

local function fn2(p, object)
	v9 = false
	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
		Symbol("DemoPause"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15(p),
		"IntroContinue"
	)

	while not v9 do
		if __wf_atom_7e8ad928(object) or object:__wf_atom_7d4910e4() and not object:__wf_atom_e9546dc6() then
			Sleep(0)
		else
			return
		end
	end

	gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(Symbol("DemoPause"), __wf_atom_8e4fda44:__wf_atom_e7d83c15(p))
end

local function fn3(p)
	v12 = module8.StorePlayerAttribute(p)
	module8.CreateAndSwapControllableAvatar(motherAvatarType, false, true, true)
	Sleep(0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module8.ApplyPlayerAttributeDistribution(__wf_atom_c4f78a8f, v12, v13)
	module8.GiveAndInitalizeCustomWeaponOrPact(__wf_atom_c4f78a8f, motherWeaponType)
	return __wf_atom_c4f78a8f
end

function _ScriptTriggerTestMotherAvatar(_, p)
	fn3(p):__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_19516b62(100, 4)
end

local function fn4(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)
	local v17 = {}

	for i = 1, #__wf_atom_2226b35c do
		local v18 = module11.DisableNearbyEncounters(
			__wf_atom_2226b35c[i],
			Range(0, __wf_atom_2226b35c[i]:__wf_atom_8f18e876()),
			true
		)
		module4.MergeTables(v17, v18, true)
		__wf_atom_2226b35c[i]:Enable()
	end

	return v17
end

function UpdateAttachedRavenAvatar(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()
	object:__wf_atom_1d50db01(ravenIdleSubtree)
	object:__wf_atom_921c1a5f(ravenIdleAnim, false, 3, 2, true)
	local v17 = 0

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f)) do
		local heading = __wf_atom_c4f78a8f:__wf_atom_2f2bada0().heading
		local v18 = __wf_atom_0a00e162(__wf_atom_c4f78a8f:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1")))
		local __wf_atom_fa6a8faf = object:__wf_atom_fa6a8faf()
		local __wf_atom_45c0553e = object:__wf_atom_45c0553e(true)
		local v19 = __wf_atom_f55d6358(__wf_atom_fa6a8faf, v2, v17)
		local v20 = __wf_atom_d919c2d7(v18, Rotation(heading, 90, 0))
		object:__wf_atom_e310f01f(v19, (__wf_atom_9d2f097a(__wf_atom_45c0553e, v20, v17)))

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bayorRavenOverrideAnim) then
			local bayorRavenOverrideAnim = __wf_atom_e919fb8e.bayorRavenOverrideAnim
			object:__wf_atom_921c1a5f(__wf_atom_e919fb8e.bayorRavenOverrideAnim, true, 3, 1, true)

			if __wf_atom_e919fb8e.bayorRavenOverrideAnim == bayorRavenOverrideAnim then
				__wf_atom_e919fb8e.bayorRavenOverrideAnim = nil
			end

			object:__wf_atom_921c1a5f(ravenIdleAnim, false, 3, 2, true)
		end

		v17 = math.min(v17 + __wf_atom_084b3e93(), 1)
		Sleep(0)
	end
end

function DestroyAttachedRavenAvatar()
	if not __wf_atom_7e8ad928(v) then
		v:Destroy()
		v = nil
	end
end

function SetupHelmetCarry(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TempestBayor"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BayorDecoBody"))
	gRegion:__wf_atom_0a6a5887(Symbol("BayorHelmetDeco")):AttachToInPlace(__wf_atom_0a6a5887_2, Symbol("GAME_L1_ARM3"))
	__wf_atom_0a6a5887:__wf_atom_9373d0eb(20, true)
	Sleep(0.3)
	gRegion:__wf_atom_0a6a5887(Symbol("RavenDeco")):SetVisibility(false, true)
end

local function fn5(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 3 or __wf_atom_4026dfb5 == 4 then
		module14.EnableNearestTaggedSoundSysVolume(Symbol("WarsongWolfRideMusic"), false, object:GetPosition())
	end
end

local function fn6(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.triggerCompleted = true
	object:Disable()
end

local function fn7(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(1, true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(2, true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(3, true)

	if p > 0 then
		__wf_atom_e55d02aa:__wf_atom_94e73c15(1, false)
	end

	if p > 1 then
		__wf_atom_e55d02aa:__wf_atom_94e73c15(2, false)
	end

	if p > 2 then
		__wf_atom_e55d02aa:__wf_atom_94e73c15(3, false)
	end

	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(false)
	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
	__wf_atom_eb82ab1f:__wf_atom_51596c11(nil, 2)
	__wf_atom_eb82ab1f:__wf_atom_51596c11(nil, 3)
	__wf_atom_eb82ab1f:SetSkin(helmType, 0)
	__wf_atom_eb82ab1f:__wf_atom_51596c11(transmogHelmType, 0)
	__wf_atom_eb82ab1f:SetSkin(chestType, 2)
	__wf_atom_eb82ab1f:SetSkin(legsType, 3)
	__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f)
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Update(0)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	local v17 = {
		__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(5),
		__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
	}

	if #v17 > 0 then
		for i = 1, #v17 do
			if not __wf_atom_7e8ad928(v17[i]) and v17[i]:IsA(__wf_atom_2fc5c2e8) and v17[i]:IsA(v15) then
				return
			end
		end
	end

	module8.GiveAndInitalizeCustomWeaponOrPact(__wf_atom_c4f78a8f, v15, v16, true)
end

local function fn8(synodAgentType, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)
	local __wf_atom_402b3832 = v7:__wf_atom_402b3832(
		synodAgentType,
		__wf_atom_0a6a5887:GetPosition(),
		__wf_atom_0a6a5887:__wf_atom_dc309f8a()
	)
	Sleep(1)
	__wf_atom_402b3832:__wf_atom_50a7d83e():__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("Invulnerable"), 26, 6, 0)
	return __wf_atom_402b3832
end

local function fn9(p)
	v11 = gRegion:__wf_atom_0a6a5887(Symbol("BayorCollectorShip"))

	if __wf_atom_7e8ad928(v11) then
		return
	end

	if v11:IsVisible() and not p then
	end

	v11:SetVisibility(p, true)
end

local function fn10(p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v17 in ipairs(__wf_atom_3c8e1a7a) do
		if v17:IsLocal() then
			continue
		end

		local __wf_atom_50a7d83e = v17:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:__wf_atom_dd875cd8(not p)
		end

		local playerAvatar = v17:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) or playerAvatar == __wf_atom_50a7d83e then
			continue
		end

		playerAvatar:__wf_atom_dd875cd8(not p)
	end
end

local function fn11(p, p2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = 1, #__wf_atom_2226b35c do
			if not __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
				__wf_atom_2226b35c[i]:SetVisibility(p2, true)
			end
		end
	end
end

function BayorTentStopped(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Bayor"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:PrefetchStreaming()
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Knightmaiden"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("StartPlaying")
	end
end

function PlayTentScene()
	__wf_atom_8e4fda44:__wf_atom_ebf17acc(bayorTentLevel)
	__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
	gClient:__wf_atom_b3845a20()
	gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Knightmaiden"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:PrefetchStreaming()
	end

	local __wf_atom_0a6a5887_2 = __wf_atom_392793db:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Mother"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("StartPlaying")
		__wf_atom_55142dd4(__wf_atom_0a6a5887_2, "OnStopped", "BayorTentStopped")
		Sleep(1.5)
		__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 0.5)

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	__wf_atom_8e4fda44:__wf_atom_62a19abc()
end

local function fn12(object, p, p2, p3)
	local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		ravenAgentType,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0,
		ravenIdleAnim
	)

	if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
		v = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_6a95c7b8(object)
			v:__wf_atom_98a0c9bd(Symbol("SPARROW_APPEAR_FX"), false)
			v:__wf_atom_98a0c9bd(Symbol("SPARROW_GUIDE_VFX"), false)
			v:__wf_atom_98a0c9bd(Symbol("SPARROW_LIGHT"), false)
			v:SetMeshScale(1, true)
			v:__wf_atom_18619c34(1)
			local __wf_atom_e919fb8e = v:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.ignoreInitialSparrowScale = true
			object:AttachEntity(v, Symbol("GAME_R1_ARM1"), p, p2)
			v:__wf_atom_8a035cd5(Symbol("UpdateAttachedRavenAvatar"), false)
			v:SetVisibility(p3, true)
		end
	end
end

local function fn13(object, p)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.noSparrowBehavior = true
	local v17 = Vector()
	local v18 = Rotation()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RavenDeco"))
	local flag

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		flag = false
	else
		v17 = __wf_atom_0a6a5887:__wf_atom_a2a18137() + Vector(0, 0.16, 0)
		v18 = __wf_atom_0a6a5887:__wf_atom_2f2bada0()
		v18.pitch += 100
		__wf_atom_0a6a5887:SetVisibility(false)
		flag = true
	end

	module6.RemoveSparrow(object)
	local heading = object:__wf_atom_2f2bada0().heading
	local v19 = __wf_atom_0a00e162(object:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1")))
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1"))
	local v20 = __wf_atom_d919c2d7(v19, Rotation(heading, 90, 0))
	local v21 = v2

	if flag then
		v21 = __wf_atom_9341614d(v17 - __wf_atom_1c374cc9, v19)
		v20 = __wf_atom_d919c2d7(v19, v18)
	end

	fn12(object, v21, v20, p)
end

function P01MotherDreamToBayorIntro(p)
	if not fn(mOwner, p, false) then
		return
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
	fn10(false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
	end

	if not module4.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xCorridorA") then
		if not __wf_atom_7e8ad928(skyCastleLevel) then
			module4.StreamInLevelRegion(skyCastleLevel, nil, Vector(0, -250, 0), 305, false, nil)
		end

		while not module4.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xCorridorA") do
			Sleep(1)
		end
	end

	while module4.IsStreamingLevel() do
		Sleep(0)
	end

	module16.SwapSkyTo(Symbol("OdeSkyCastleSky"))
	module16.SetTimeOfDay(1)
	module8.CreateAndSwapControllableAvatar(bayorAvatarType)
	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
	__wf_atom_8e4fda44:__wf_atom_5d67a2c5(continueMovie)

	while __wf_atom_8e4fda44:__wf_atom_6b69b901(continueMovie) do
		Sleep(0)
	end

	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(fancySubtitleMovie, "MovieLoaded")
	module9.PlayGlobalTransmission(transmissionSet, Symbol("EmpressSplinterInHeart"), false)
	Sleep(3)

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end

	PlayTentScene()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Knightmaiden"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	module16.SwapSkyTo(Symbol("OdeSkyCastleSky"))
	module16.SetTimeOfDay(1)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P1-Scene01-Bayor"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	fn13(gRegion:__wf_atom_c4f78a8f(), true)
	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(true)
	end

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P02BayorIntro(p)
	if not fn(mOwner, p, true) then
		return
	end

	_T.DisableLocationNotifications = true
	local v17, v18

	if not module4.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xCorridorA") then
		module4.Fade(true, 0)

		if not __wf_atom_7e8ad928(skyCastleLevel) then
			module4.StreamInLevelRegion(skyCastleLevel, nil, Vector(0, -250, 0), 305, false, nil)
		end

		module8.CreateAndSwapControllableAvatar(bayorAvatarType)

		while not module4.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xCorridorA") do
			Sleep(1)
		end

		v18 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP2Start"))

		if __wf_atom_7e8ad928(v18) then
			return
		end

		v17 = gRegion:__wf_atom_c4f78a8f()

		if not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v18)) then
			v17:Teleport(v18:GetPosition(), v18:__wf_atom_dc309f8a())
		end
	end

	if __wf_atom_7e8ad928(v17) then
		gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	while not __wf_atom_2202ffb6:ReadyToCreateAgents() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v18) then
		v18 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP2Start"))

		if __wf_atom_7e8ad928(v18) then
			return
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
	end

	__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)
	__wf_atom_c4f78a8f:CameraControl():__wf_atom_25382a0d(0.75)
	v = __wf_atom_c4f78a8f:__wf_atom_bb3e7833((ravenAgentType:__wf_atom_c6772fb4()))

	if __wf_atom_7e8ad928(v) then
		fn13(__wf_atom_c4f78a8f, false)
	end

	module4.Fade(false, 2)

	if not __wf_atom_7e8ad928(v) then
		v:SetVisibility(true, true)
	end

	module2.WaitForGoToLocation(Symbol("WarsongQuest-P2-EndOfHall"), p, 2, false, nil, nil)

	if __wf_atom_7e8ad928(v18) then
		return
	end

	if not __wf_atom_7e8ad928(fadeToIchorSnd) then
		module12.PlaySound(fadeToIchorSnd)
	end

	module4.Fade(true, 1, 1, false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("InquisitorSpawn"))
	local entity = gRegion:CreateEntity(
		inquisitorDecoType,
		__wf_atom_0a6a5887:GetPosition(),
		__wf_atom_0a6a5887:__wf_atom_dc309f8a()
	)
	gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P2-SynodSpawn"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P2-SynodP3"))
	local v19 = fn8(synodAgentType, Symbol("WarsongQuest-P2-SynodSpawn"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P2-WalkTalkWp"))

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_e6ed03c8()
		gRegion:__wf_atom_dd1e4d10(v)
	end

	module8.SwapLastAssignedControllableAvatar(true)
	module8.CreateAndSwapControllableAvatar(bayorHelmetAvatarType, false, true)
	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_e919fb8e = __wf_atom_c4f78a8f2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.noSparrowBehavior = true
	local nearestTagged = gRegion:FindNearestTagged(Symbol("BayorHelm"), __wf_atom_c4f78a8f2:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:SetVisibility(true, true)
	end

	local heading = __wf_atom_c4f78a8f2:__wf_atom_2f2bada0().heading
	local v20 = __wf_atom_0a00e162(__wf_atom_c4f78a8f2:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1")))
	__wf_atom_c4f78a8f2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1"))
	fn12(__wf_atom_c4f78a8f2, v2, __wf_atom_d919c2d7(v20, Rotation(heading, 90, 0)), true)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("BayorFather"), false)
	Sleep(1.25)
	__wf_atom_c4f78a8f2:Teleport(__wf_atom_0a6a5887_3:GetPosition(), __wf_atom_0a6a5887_3:__wf_atom_dc309f8a())
	__wf_atom_c4f78a8f2:__wf_atom_f0f9fb38(__wf_atom_0a6a5887_3:__wf_atom_dc309f8a())
	__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(true)
	__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(true)
	__wf_atom_c4f78a8f2:CameraControl():__wf_atom_25382a0d(0.75)
	module4.Fade(false, 1, 0, true)
	Sleep(2)
	v19:MoveTo(__wf_atom_0a6a5887_2, false, false, false)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("SynodPissPits"), true)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("SynodINeedBlueBlood"), true)

	if __wf_atom_7e8ad928(v18) then
		return
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P2-Scene02-Bayor"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:__wf_atom_a3d2b66b(v19:__wf_atom_50a7d83e(), Symbol("Synod"))
		__wf_atom_0a6a5887_4:__wf_atom_a3d2b66b(entity, Symbol("OdeInquisitor"))
		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("RavenDeco"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
			__wf_atom_0a6a5887_4:__wf_atom_a3d2b66b(__wf_atom_0a6a5887_5, Symbol("Raven"))
		end

		DestroyAttachedRavenAvatar()
	end

	module2.WaitForTaggedQuestCinematicToEnd(Symbol("WarsongQuest-P2-Scene02-Bayor"))

	if __wf_atom_7e8ad928(v18) then
		return
	end

	module4.Fade(true, 0)
	local __wf_atom_c4f78a8f3 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f3) then
		__wf_atom_c4f78a8f3:CameraControl():__wf_atom_25382a0d(1)
	end

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_e6ed03c8()
		gRegion:__wf_atom_dd1e4d10(v)
	end

	__wf_atom_e919fb8e.noSparrowBehavior = false
	module8.SwapLastAssignedControllableAvatar(true)
	module4.StreamOutLevelRegion(305)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P04StartRain()
	module16.SetRaining(true, 1)
end

function P04WolfRide(p)
	if not fn(mOwner, p, true) then
		return
	end

	module4.Fade(true, 0)
	_T.DisableMotePickup = true
	_T.DisableLocationNotifications = false
	fn10(true)
	gGameRules:__wf_atom_0daba688(false)
	local summonWolfFromScript = module13.SummonWolfFromScript(rideableWolfAgentType, nil, true)
	summonWolfFromScript:__wf_atom_e5d015a7(Symbol("Wolf"))
	summonWolfFromScript:Attach(
		wolfRideCueType,
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		summonWolfFromScript
	)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP4CinLoop"))
	local nearestTagged = gRegion:FindNearestTagged(Symbol("WarsongP4PostLoginCin"), __wf_atom_0a6a5887:GetPosition())

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_a3d2b66b(summonWolfFromScript, Symbol("Wolf"))
		__wf_atom_0a6a5887:PrefetchStreaming()
	end

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_a3d2b66b(summonWolfFromScript, Symbol("Wolf"))
	end

	module16.SwapSkyTo(Symbol("DefaultMainSky"))
	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(9)
	module16.SetOvercast(1)
	module16.SetWindy(0.5)
	Sleep(3)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_80368bb1)
	module4.UnequipWeapon(__wf_atom_c4f78a8f, true)

	while __wf_atom_c4f78a8f:GetPosition() ~= __wf_atom_0a6a5887:GetPosition() do
		Sleep(0)
	end

	module4.Fade(false, 2)
	fn4(Symbol("WarsongP4BlockerHint"))
	__wf_atom_0a6a5887:FirePort("StartPlaying")
	fn2("MENU_CANCEL", __wf_atom_0a6a5887)
	__wf_atom_0a6a5887:Stop()
	module4.WaitForCinematicToFinish(nearestTagged)
	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(false)
	summonWolfFromScript:__wf_atom_e5d015a7(Symbol("Orengal"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongRuinHint"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_f2daf912("ERROR - Warsong P4 - Failed to find Ruin Hint.")
	else
		__wf_atom_0a6a5887_2:Enable()
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		__wf_atom_7d789620:AddEncounter(ruinsEncounterType)
		__wf_atom_7d789620:ActivateSpecificEncounterAtSpecificHint(__wf_atom_0a6a5887_2, ruinsEncounterType):__wf_atom_7dd025d4(
			fn5,
			Symbol("WarsongQuest-P4-RuinsEncounter")
		)
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("P05WarsongRainTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:Enable()
	end

	local randomEntitiesAtWaypoints = module4.CreateRandomEntitiesAtWaypoints(
		animalCageTypes,
		Symbol("AnimalCageSpawn"),
		__wf_atom_0a6a5887_2
	)
	local v17 = {}

	for _, randomEntitiesAtWaypoint in pairs(randomEntitiesAtWaypoints) do
		table.insert(v17, randomEntitiesAtWaypoint:__wf_atom_bb3e7833(__wf_atom_0f45538d))
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("P5MotherSword"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:SetVisibility(true, true)
	end

	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongRuinSparrowPerchPoint"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
		module6.AddQuestDestination(__wf_atom_0a6a5887_5, mOwner, p)
	end

	module2.WaitForMultipleInteractions(v17, p, true, mOwner, 0, "/SF/Language/Quests/WarsongObj04.1")

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P05SpawnControlHandleImmortalSpawns(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("_LocalP05EnemyImmortality"), false)
	end
end

function _LocalP05EnemyImmortality(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.bImmortalityActive = true

	while
		not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bImmortalityActive)
		and __wf_atom_e919fb8e.bImmortalityActive
	do
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

			if not (__wf_atom_7e8ad928(__wf_atom_216d6edd) or __wf_atom_216d6edd:__wf_atom_535d5cbb()) then
				object:Heal(object, 100, object, true, 1)
			end
		end

		Sleep(math.random(0.1, 0.3))
	end

	Sleep(math.random(0.1, 0.3))

	if not __wf_atom_7e8ad928(object) and not object:IsKilled() and object:__wf_atom_e93896ba() == Symbol("TENNO") then
		object:SetHealth(100)
		object:__wf_atom_dd875cd8(true)
	end
end

local v17 = Symbol("Warsong-P05-SpawnControl-FightA")

function P05ScriptTriggerUnlockFight(_, object)
	object:__wf_atom_2f3f52aa(5)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v17)

	if #__wf_atom_2226b35c <= 0 then
		return
	end

	local v18 = {}

	for i = 1, #__wf_atom_2226b35c do
		local __wf_atom_cfb1f23d = __wf_atom_2226b35c[i]:__wf_atom_cfb1f23d()

		for j = 1, #__wf_atom_cfb1f23d do
			if __wf_atom_7e8ad928(__wf_atom_cfb1f23d[j]) or __wf_atom_cfb1f23d[j]:IsKilled() then
				continue
			end

			local __wf_atom_e919fb8e = __wf_atom_cfb1f23d[j]:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.bImmortalityActive = false

			if __wf_atom_cfb1f23d[j]:__wf_atom_e93896ba() ~= Symbol("TENNO") then
				table.insert(v18, __wf_atom_cfb1f23d[j])
			end
		end
	end

	local sortByDistance = module4.SortByDistance(v18, object:GetPosition())

	for i = 1, #sortByDistance do
		local __wf_atom_30e3d82b = sortByDistance[i]:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
			__wf_atom_30e3d82b:StormTarget(object)
		end

		Sleep(0.2)
	end
end

function P05Knightmaiden(p)
	if not fn(mOwner, p, true) then
		return
	end

	module4.PauseOverworldResourceSpawning()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CastleBridgeMainCamp"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CastleBridgeSmallCamp"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Disable()
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP5SwordSwitch"))
	local v18

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:Enable()
		v18 = gRegion:FindNearestTagged(Symbol("P5MotherStatue"), __wf_atom_0a6a5887_3:GetPosition())
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		module.DevTeleportPlayers(Symbol("WarsongP5SwordStart"), true)
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("P5MotherSword"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:SetVisibility(true, true)
	end

	gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P5-Scene04")):PrefetchStreaming()
	module2.WaitForGoToLocation(Symbol("WarsongQuest-P05-ApproachStatue"), p, 2)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("EmpressHeraldsToEmptyHearts"), false)

	while __wf_atom_0a6a5887_3:IsEnabled() do
		Sleep(1)
	end

	module4.TaggedFirePorts(Symbol("WarsongP5CastleSetUp"), "TriggerPort")
	module3.LoadTaggedLevels({ Symbol("WarsongQuestBridgePreBattle") })
	module3.UnloadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P5-Scene03"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) then
		module4.UnequipWeapon(gRegion:__wf_atom_c4f78a8f(), true)

		if not __wf_atom_7e8ad928(v18) then
			__wf_atom_0a6a5887_5:__wf_atom_a3d2b66b(v18, Symbol("MotherArmourBody"))
		end

		__wf_atom_0a6a5887_5:FirePort("StartPlaying")
		module14.EnableNearestTaggedSoundSysVolume(
			Symbol("WarsongWolfRideMusic"),
			false,
			__wf_atom_c4f78a8f:GetPosition()
		)

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_5) and __wf_atom_0a6a5887_5:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP5Start"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
			gRegion:__wf_atom_c4f78a8f():Teleport(
				__wf_atom_0a6a5887_6:GetPosition(),
				__wf_atom_0a6a5887_6:__wf_atom_dc309f8a()
			)
		end

		__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(true)
	end

	gGameRules:__wf_atom_0daba688(false)
	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("P5FinalBattleOverTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
		__wf_atom_0a6a5887_6:Disable()
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("DressingScreenDeco"))

	for _, v19 in pairs(__wf_atom_2226b35c) do
		v19:SetVisibility(false, true)
	end

	module16.ClearWeatherAndDisableCycle()
	module16.SwapSkyTo(Symbol("WarsongIntroSky"))
	module16.SetTimeOfDay(2)
	module16.SetLightning(true, 1, false)
	local __wf_atom_0a6a5887_7 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P5-Scene04"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_7) then
		module4.TaggedFirePorts(Symbol("WarsongQuest-P5-Scene04-CinSetup"), "TriggerPort")
		__wf_atom_0a6a5887_7:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_7) and __wf_atom_0a6a5887_7:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	module4.TaggedFirePorts(Symbol("WarsongQuest-P5-Scene04-CinTakedown"), "TriggerPort")
	module16.SetRaining(true)
	Sleep(1)
	module5.SetLevelUpNotificationsVisible(false)
	local v19 = fn3(gRegion:__wf_atom_c4f78a8f())
	v19:__wf_atom_e25a34ac(true)
	local __wf_atom_0a6a5887_8 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P5-Scene05"))
	local __wf_atom_0a6a5887_9 = gRegion:__wf_atom_0a6a5887(Symbol("MothersHelmetDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_8) then
		__wf_atom_0a6a5887_8:__wf_atom_a3d2b66b(v19, Symbol("Mother"))
		__wf_atom_0a6a5887_8:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_8) and __wf_atom_0a6a5887_8:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_9) then
		__wf_atom_0a6a5887_9:SetVisibility(false, true)
	end

	module10.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887_10 = gRegion:__wf_atom_0a6a5887(Symbol("Warsong-P05SpawnHeavy"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_10) then
		__wf_atom_0a6a5887_10:Enable()
	end

	local __wf_atom_0a6a5887_11 = gRegion:__wf_atom_0a6a5887(Symbol("StartCombatTutorialTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_11) then
		__wf_atom_0a6a5887_11:Enable()
	end

	module4.SetImmunity(gRegion:__wf_atom_c4f78a8f(), true)
	module2.WaitForGoToLocation(Symbol("WarsongQuest-P5-MotherLandTrigger"), p, 0)
	Sleep(2)

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_6) or __wf_atom_0a6a5887_6:IsEnabled()) do
		Sleep(0)
	end

	local v20 = {
		Symbol("Warsong-P05-SpawnControl-FightA"),
		Symbol("Warsong-P05-SpawnControl-FightB"),
		Symbol("Warsong-P05-SpawnControl"),
		Symbol("KnightmaidenFinalFight")
	}

	for i = 1, #v20 do
		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(v20[i])

		for j = 1, #__wf_atom_2226b35c2 do
			if not __wf_atom_7e8ad928(__wf_atom_2226b35c2[j]) then
				__wf_atom_2226b35c2[j]:FirePort("RemoveAgents")
			end
		end
	end

	local __wf_atom_c4f78a8f3 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f3) then
		__wf_atom_c4f78a8f3:__wf_atom_e25a34ac(true)
	end

	module4.SetImmunity(__wf_atom_c4f78a8f3, false)
	module4.UnequipWeapon(__wf_atom_c4f78a8f3, true)
	__wf_atom_c4f78a8f3:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6():__wf_atom_cfecab5d(true)
	local __wf_atom_283678c5 = gRegion:__wf_atom_283678c5(__wf_atom_9e85eea2, __wf_atom_c4f78a8f3:GetPosition(), 0, 10)

	for _, v21 in pairs(__wf_atom_283678c5) do
		v21:Destroy()
	end

	local __wf_atom_0a6a5887_12 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P5-Scene06"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_12) then
		__wf_atom_55142dd4(__wf_atom_0a6a5887_12, "OnStopped", "OnP05StageDone")
		__wf_atom_0a6a5887_12:FirePort("StartPlaying")
		module14.EnableTaggedSequencers(Symbol("WarsongBattleCue"), false)

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_12) and __wf_atom_0a6a5887_12:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function _P06CommonSetup()
	gRegion:__wf_atom_c4f78a8f():__wf_atom_e25a34ac(true)
	module16.SwapSkyTo(Symbol("WarsongIntroSky"))
	module16.SetTimeOfDay(2)
	module16.IsSkyValid(Symbol("WarsongIntroSky")):__wf_atom_2ee34f0b(Vector(1, 0.35, 0.5))
	module16.SetRaining(true)
	module16.SetLightning(true, 1, false)
	module14.EnableTaggedSoundSysVolumes(Symbol("WarsongCastleExtBattleAmb"), false)
end

function OnP05StageDone()
	local v18 = Type("/SF/Types/NeutralCreatures/Beaver/PlayerBeaverAvatar")
	module8.CreateAndSwapControllableAvatar(v18, true, true)
	_P06CommonSetup()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P6-Scene07"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end
end

function P06River(p)
	if not fn(mOwner, p, false) then
		return
	end

	if not module4.IsOverworldResourceSpawningPaused() then
		module4.PauseOverworldResourceSpawning()
	end

	if not gRegion:__wf_atom_c4f78a8f():IsA(beaverAvatarType) then
		module8.CreateAndSwapControllableAvatar(beaverAvatarType, false, true)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P6-Scene07"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if not __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			_P06CommonSetup()
			module4.TaggedFirePorts(Symbol("WarsongQuest-P6-Scene07-CinSetup"), "TriggerPort")
			__wf_atom_0a6a5887:FirePort("StartPlaying")
		end

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	module5.SetLevelUpNotificationsVisible(true)

	if not __wf_atom_7e8ad928(beaverBasketRescueMusic) and __wf_atom_7e8ad928(v3) then
		v3 = module12.PlaySound(beaverBasketRescueMusic)
	end

	module14.EnableTaggedSequencers(Symbol("BabyCry"), true)
	gRegion:__wf_atom_c4f78a8f():__wf_atom_92aa9d91():__wf_atom_9f4f79f7(false)
	module2.WaitForGoToLocation(Symbol("WarsongQuest-P6-BeaverRiverEndTrigger"), p, 0, true, mOwner)
	local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(beaverTitleCardMovie)

	while _T.WarsongTitleCardActive do
		Sleep(0)
	end

	Sleep(2)
	module4.Fade(true, 2, 1, false)
	Sleep(2)

	if not __wf_atom_7e8ad928(fadeToBeaverEndSound) then
		module12.PlaySound(fadeToBeaverEndSound)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Stop(false)
	end

	Sleep(3.75)
	module16.ClearWeather()
	module16.SwapSkyTo(Symbol("DefaultMainSky"))
	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(19)
	module14.EnableTaggedSequencers(Symbol("BabyCry"), false)
	module8.SwapLastAssignedControllableAvatar(true, true, true)
	Sleep(0.8)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P6-Scene09"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:PrefetchStreaming()
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P6-Scene08"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:FirePort("StartPlaying")
		module4.Fade(true, 0, 1, false)
		__wf_atom_5d67a2c5:Execute("CloseTitlecard", "")
		module4.Fade(false, 1.5, 0, true)

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) and __wf_atom_0a6a5887_3:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)
	module16.SetTimeOfDay(19)
	module3.UnloadTaggedLevels({ Symbol("WarsongQuestBridgePreBattle") })
	module3.LoadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	module4.ResumeOverworldResourceSpawning()
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P6-Scene09"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) and __wf_atom_0a6a5887_4:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	gRegion:__wf_atom_c4f78a8f():__wf_atom_92aa9d91():__wf_atom_9f4f79f7(true)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

local v18 = Symbol("WarsongMendicantEncounter-P7")
local v19 = {
	Symbol("MendicantInteriorCombatHint"),
	Symbol("MendicantInteriorCombatHint-Connector"),
	Symbol("MendicantInteriorCombatHint-SmallRoom")
}

function P07BayorGivesSword(p)
	if not fn(mOwner, p, true) then
		return
	end

	module4.Fade(true, 0)
	module5.SetLevelUpNotificationsVisible(false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module8.GiveAndInitalizeCustomWeaponOrPact(__wf_atom_c4f78a8f, nil, v16, true)
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(1, true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(2, true)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(3, true)
	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
	__wf_atom_eb82ab1f:__wf_atom_51596c11(nil, 2)
	__wf_atom_eb82ab1f:__wf_atom_51596c11(nil, 3)
	__wf_atom_eb82ab1f:SetSkin(helmType, 0)
	__wf_atom_eb82ab1f:__wf_atom_51596c11(transmogHelmType, 0)
	__wf_atom_eb82ab1f:SetSkin(chestType, 2)
	__wf_atom_eb82ab1f:SetSkin(legsType, 3)
	__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f)
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Update(0)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()

	if not module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxCageRoom") then
		if not __wf_atom_7e8ad928(acornFishProcLevel) then
			module4.StreamInLevelRegion(acornFishProcLevel, nil, Vector(0, -250, 0), 347, false, nil)
		end

		while not module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxCageRoom") do
			module4.Fade(true, 0)
			Sleep(1)
		end
	end

	while module4.IsStreamingLevel() do
		module4.Fade(true, 0)
		Sleep(0)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P7-Scene10"))
	__wf_atom_0a6a5887:PrefetchStreaming()
	Sleep(1)
	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	module16.SwapSkyTo(Symbol("DefaultMainSky"))
	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(3)
	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
		module4.Fade(false, 1)

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("TempestBayor"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		40
	)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P7-BayorFaceDir"))
	__wf_atom_f738b4af:__wf_atom_30e3d82b()
	__wf_atom_f738b4af:Teleport(__wf_atom_f738b4af:GetPosition(), __wf_atom_0a6a5887_2:__wf_atom_dc309f8a())
	__wf_atom_f738b4af:__wf_atom_921c1a5f(bayorDecoIdleAnim, false, 3, 2, true)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("CorruptedWeaponPickUp"), __wf_atom_0a6a5887:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:Destroy()
	end

	local nearestTagged2 = gRegion:FindNearestTagged(Symbol("CorruptedSwordDeco"), __wf_atom_0a6a5887:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged2) then
		nearestTagged2:SetVisibility(true, true)
	end

	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(false)
	end

	module8.ShowAcquiredNotification(v16)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P7-TentInterior"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		_T.mNightFoldPosition = __wf_atom_0a6a5887_3:GetPosition()
		_T.mNightFoldView = __wf_atom_0a6a5887_3:__wf_atom_dc309f8a()
	end

	_T.DisableProgressionSummary = true
	module11.SetEncounterHintsEnabledByTags(v19, false)
	gRegion:__wf_atom_0a6a5887(v18):Enable()
	module9.PlayGlobalTransmission(transmissionSet, Symbol("BayorBecomeOrDrown"), true)
	module2.WaitForInteraction(Symbol("WarsongQuest-P09-BanglenutInteract"), p, 2, true, mOwner)

	if not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) then
		local __wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()
		module15.DestroyEntityFromCinBlackboard(__wf_atom_0a6a5887, __wf_atom_e919fb8e, __wf_atom_f738b4af)
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(flashBackSound) then
		module12.PlaySound(flashBackSound)
	end

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P07PickUpBayorSword(object, object2)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 0)
	object2:__wf_atom_aeb02c14(swordPickupInputFilter)
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local total = 0

	while total <= 0.6 do
		object2:Teleport(
			__wf_atom_f55d6358(object2:GetPosition(), position, (math.min(total / 0.6, 1))),
			(__wf_atom_9d2f097a(object2:__wf_atom_2f2bada0(), __wf_atom_dc309f8a, (math.min(total / 0.6, 1))))
		)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	Sleep(0.5)
	object2:Teleport(object:GetPosition(), object:__wf_atom_dc309f8a())
	local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(pickUpSwordAnim, false, 2, 1, true)
	local v20 = object2:GiveItem(swordWeaponType, false)
	__wf_atom_d2b2176d:Equip(5, 0, 2)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	__wf_atom_d2b2176d:Update(0)
	local v21

	if not __wf_atom_7e8ad928(v20) then
		v21 = v20:__wf_atom_66088189(1, 0)
	end

	if not __wf_atom_7e8ad928(v21) then
		v21:__wf_atom_a763aa1a(1)
	end

	local v22 = pickUpSwordAnim:__wf_atom_091354f5(Symbol("GrabSword")) * __wf_atom_921c1a5f
	local v23 = pickUpSwordAnim:__wf_atom_091354f5(Symbol("HolsterSword")) * __wf_atom_921c1a5f - v22
	Sleep(v22)
	module5.SetLevelUpNotificationsVisible(false)
	module8.ShowAcquiredNotification(v15)
	swordPickup:AttachToInPlace(object2, Symbol("GAME_R1_WEAPON1"))
	local v24 = 0
	local v25 = nil
	local v26 = nil
	local __wf_atom_fa6a8faf = swordPickup:__wf_atom_fa6a8faf()
	local __wf_atom_45c0553e = swordPickup:__wf_atom_45c0553e()

	if not __wf_atom_7e8ad928(v20) then
		local __wf_atom_66088189 = v20:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			v25 = __wf_atom_66088189:__wf_atom_fa6a8faf()
			v26 = __wf_atom_66088189:__wf_atom_45c0553e()
		end
	end

	while v24 < v23 do
		v24 = math.min(v23, v24 + __wf_atom_084b3e93())

		if not __wf_atom_7e8ad928(v25) then
			local v27 = __wf_atom_f55d6358(__wf_atom_fa6a8faf, v25, v24 / v23)
			local v28 = __wf_atom_9d2f097a(__wf_atom_45c0553e, v26, v24 / v23)
			swordPickup:__wf_atom_e310f01f(v27, v28)
		end

		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(swordPickup)
	object2:__wf_atom_cf966a74(swordPickupInputFilter)

	if not __wf_atom_7e8ad928(v21) then
		v21:__wf_atom_a763aa1a(0)
	end

	object:Disable()
end

function P07BayorGivesSwordDeactivated()
	DeactivateFixAvatar()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_d2b2176d():BuildLoadOut(gGameData:__wf_atom_a4299765(), 0)
	end
end

function P09BanglenutLookatTrigger(_, object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_18aa6e58 = object:__wf_atom_3d96ddcd():__wf_atom_0c59b746()[2]:__wf_atom_18aa6e58()
	__wf_atom_18aa6e58:Enable()
	__wf_atom_18aa6e58:__wf_atom_a7ee9662(true, true)
	__wf_atom_f2daf912("nut on")

	while object:__wf_atom_1c85e812(__wf_atom_c4f78a8f) do
		Sleep(0)
	end

	__wf_atom_18aa6e58:__wf_atom_a7ee9662(false, true)
	__wf_atom_18aa6e58:Disable()
	__wf_atom_f2daf912("nut off")
end

function P09EnableWeaponsForDeerHunters(object)
	object:__wf_atom_50a7d83e():SetBlackboardBool(Symbol("ForceEquipWeapon"), true)
end

function P09ApproachHunter()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P09-DeerSpawn"))
	local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		deerAgentType,
		__wf_atom_0a6a5887:GetPosition(),
		__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0
	)

	if not __wf_atom_7e8ad928(deerLookTriggerSound) then
		__wf_atom_0a6a5887:PlaySound(deerLookTriggerSound, false, 1, false)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module14.EnableNearestTaggedSoundSysVolume(
		Symbol("WarsongBanglenutHuntMusic"),
		false,
		__wf_atom_c4f78a8f:GetPosition()
	)
	module14.EnableNearestTaggedSoundSysVolume(
		Symbol("WarsongBanglenutHuntDarkMusic"),
		true,
		__wf_atom_c4f78a8f:GetPosition()
	)
	__wf_atom_402b3832:MoveTo(
		gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P09-DeerDestination")),
		true,
		false,
		false
	)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P09-LookAtHunters"))
	__wf_atom_0a6a5887_2:Enable()
	__wf_atom_55142dd4(__wf_atom_0a6a5887_2, "Activated", fn6)
	local __wf_atom_e919fb8e = __wf_atom_0a6a5887_2:__wf_atom_e919fb8e()

	while true do
		if __wf_atom_e919fb8e == nil then
			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				__wf_atom_e919fb8e = __wf_atom_0a6a5887_2:__wf_atom_e919fb8e()
			end
		elseif __wf_atom_e919fb8e.triggerCompleted ~= nil and __wf_atom_e919fb8e.triggerCompleted then
			break
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	module9.PlayGlobalTransmission(transmissionSet, Symbol("EightyForPelt"), true)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("FlashAndFreeze"), true)
end

function P09BayorTransmissionTrigger()
	module9.PlayGlobalTransmission(transmissionSet, Symbol("SaFaFionn"), true)
end

function P09BayorAnims(object, _)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("TempestBayor"), object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_921c1a5f(bayorPrayerAnim, true, 3, 1, true)
		nearestTagged:__wf_atom_921c1a5f(bayorIdleStandAnim, false, 3, 2, true)
	end
end

function P09Banglenuts(p)
	if not fn(mOwner, p, true) then
		return
	end

	module4.Fade(true, 0)
	module4.PauseOverworldResourceSpawning()
	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(19.5)
	local isSkyValid = module16.IsSkyValid(Symbol("DefaultMainSky"))

	if not __wf_atom_7e8ad928(isSkyValid) then
		isSkyValid:__wf_atom_2ee34f0b(Vector(-1, 0.2, -1))
		isSkyValid:__wf_atom_d0e0a161(true)
	end

	if module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxDeepWater") then
		module4.StreamOutLevelRegion(347)
	end

	module5.SetLevelUpNotificationsVisible(false)
	fn4(Symbol("WarsongBanglenutBlocker"))
	gGameRules:__wf_atom_0daba688(false)
	module4.TaggedFirePorts(Symbol("WarsongQuest-HideCorruptedTentInterior"), "TriggerPort")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P09-Teleport"))
	local position = __wf_atom_0a6a5887:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("Warsong-Part9Decos"), position, 0, 100)

	for _, v20 in pairs(__wf_atom_439c0d29) do
		v20:SetVisibility(true, true)
	end

	__wf_atom_c4f78a8f:Teleport(position, __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	__wf_atom_c4f78a8f:__wf_atom_921c1a5f(nil, false)
	Sleep(1)
	module8.SwitchToChildAvatar(childAvatarType, true)
	gRegion:__wf_atom_c4f78a8f():__wf_atom_e25a34ac(true)
	gRegion:__wf_atom_c4f78a8f():GiveItem(
		Resource("/SF/Weapons/Ranged/Thrown/Boomerang/BoomerangRangedMeleeWeapon"),
		false
	)
	local __wf_atom_d2b2176d = gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d()
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or __wf_atom_35a10d3c:__wf_atom_55da7898() ~= 5 then
		__wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_28224c27(5)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			__wf_atom_35a10d3c:__wf_atom_cfecab5d(true)
		end
	end

	Sleep(0.5)
	module2.WaitForTaggedQuestCinematicToEnd(Symbol("WarsongQuest-P9-Scene11"))

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		__wf_atom_35a10d3c:__wf_atom_cfecab5d(false)
	end

	module14.EnableTaggedSoundSysVolumes(Symbol("WarsongBanglenutHuntMusic"), true)
	module14.EnableTaggedSoundSysVolumes(Symbol("ArbinnHillsTwoMusicVol"), false)
	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("WarsongQuest-P09-Banglenut"), position, 0, 200)

	for _, v20 in ipairs(__wf_atom_439c0d29_2) do
		v20:SetVisibility(true)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v4)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("Warsongp9BayorWP"), __wf_atom_0a6a5887_2:GetPosition())
	local nearestTagged2 = gRegion:FindNearestTagged(Symbol("WarsongDeerWP"), __wf_atom_0a6a5887_2:GetPosition())
	local entity = gRegion:CreateEntity(
		bayorAvatarType,
		nearestTagged:GetPosition(),
		nearestTagged:__wf_atom_dc309f8a()
	)
	local entity2 = gRegion:CreateEntity(
		hurtedDeerDeco,
		nearestTagged2:GetPosition(),
		nearestTagged2:__wf_atom_dc309f8a()
	)

	if not __wf_atom_7e8ad928(entity) then
		fn11(Symbol("FeyArm"), true)
		entity:__wf_atom_921c1a5f(bayorIdleAnim, false, 3, 2, true)
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("Warsong-P09-BayorAnimTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:Enable()
	end

	module2.WaitForGoToLocation(v4, p, 2, true, mOwner, "/SF/Language/Quests/WarsongObj09.1")
	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		if not __wf_atom_7e8ad928(v14) then
			__wf_atom_c4f78a8f2:__wf_atom_aeb02c14(v14)
		end

		__wf_atom_c4f78a8f2:MotionControl():__wf_atom_1dd3a2bc(false)
		__wf_atom_c4f78a8f2:__wf_atom_92aa9d91():__wf_atom_17c1c30f()
		__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(true)
		module14.EnableTaggedSoundSysVolumes(Symbol("WarsongBanglenutHuntMusic"), false)
		module14.EnableNearestTaggedSoundSysVolume(Symbol("WarsongBanglenutHuntDarkMusic"), false)
		__wf_atom_c4f78a8f2:__wf_atom_d2b2176d():Unequip(0, 2)
	end

	module2.WaitForGoToLocation(
		Symbol("WarsongQuest-P09-BayorDeerTrigger2"),
		p,
		2,
		true,
		mOwner,
		"/SF/Language/Quests/WarsongObj09.1"
	)

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
		__wf_atom_c4f78a8f2:__wf_atom_921c1a5f(childAproachDeerAnim, false, 4, 1, false)
	end

	module4.Fade(true, 10, -1, true)
	Sleep(2)
	local entity3 = gRegion:CreateEntity(
		childAvatarType,
		nearestTagged:GetPosition(),
		nearestTagged:__wf_atom_dc309f8a()
	)
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P9-Scene12"))

	if not (__wf_atom_7e8ad928(entity3) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_4)) then
		entity3:__wf_atom_e5d015a7(Symbol("ChildEnvoyHead"))
		__wf_atom_0a6a5887_4:__wf_atom_a3d2b66b(entity3, Symbol("ChildEnvoyHead"))
	end

	module2.WaitForTaggedQuestCinematicToEnd(Symbol("WarsongQuest-P9-Scene12"))

	if not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f2)) then
		__wf_atom_c4f78a8f2:__wf_atom_cf966a74(v14)
		__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(false)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	if not __wf_atom_7e8ad928(entity2) then
		entity2:Destroy()
	end

	if not __wf_atom_7e8ad928(entity3) then
		entity3:Destroy()
	end

	isSkyValid:__wf_atom_d0e0a161(false)
	__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(false)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P115DoyenIntroTransmission()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WSP_11.5DoyenIntroAudioScriptTrigger"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WSP_11.5DoyenDeco"))

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_4b409d7b(__wf_atom_c4f78a8f) then
		__wf_atom_0a6a5887_2:__wf_atom_de14bbe2()
		module9.PlayGlobalTransmission(transmissionSet, Symbol("DoyenBornAShimmer"), true)
	end
end

function P115FishingWithDoyen(p)
	if not fn(mOwner, p, true) then
		return
	end

	gRegion:__wf_atom_0a6a5887(Symbol("WSP_11.5DoyenDeco"))

	if not module4.IsOverworldResourceSpawningPaused() then
		module4.PauseOverworldResourceSpawning()
	end

	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(7)
	module16.PauseTimeOfDay()
	module4.TaggedFirePorts(Symbol("WSP_11.5Portforwarder"), "TriggerPort")
	module4.TaggedFirePorts(Symbol("WarsongQuest-HideCorruptedTentInterior"), "TriggerPort")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongFishingStartWp"))
	fn4(Symbol("WarsongFishingBlocker"))
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f:__wf_atom_30483d98()

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module8.SwitchToChildAvatar(childAvatarType)
		gRegion:__wf_atom_c4f78a8f()
	else
		local position = __wf_atom_0a6a5887:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
		__wf_atom_c4f78a8f:Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
		module8.SwitchToChildAvatar(childAvatarType, nil, position, __wf_atom_dc309f8a)
		gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f2:__wf_atom_e25a34ac(true)
	Sleep(1)
	__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(true)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P11.5-CinLoop"))
	local entity = gRegion:CreateEntity(
		sparrowType,
		__wf_atom_0a6a5887_2:GetPosition(),
		__wf_atom_0a6a5887_2:__wf_atom_dc309f8a()
	)
	__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(entity, Symbol("Sparrow"))
	local __wf_atom_c4f78a8f3 = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f3:Teleport(__wf_atom_0a6a5887_2:GetPosition(), __wf_atom_80368bb1)

	while __wf_atom_c4f78a8f3:GetPosition() ~= __wf_atom_0a6a5887_2:GetPosition() do
		Sleep(0)
	end

	local nearestTagged = gRegion:FindNearestTagged(
		Symbol("WarsongQuest-P11.5-PostLoginCin"),
		__wf_atom_0a6a5887_2:GetPosition()
	)
	nearestTagged:__wf_atom_a3d2b66b(entity, Symbol("Sparrow"))
	__wf_atom_0a6a5887_2:FirePort("StartPlaying")
	fn2("MENU_CANCEL", __wf_atom_0a6a5887_2)
	__wf_atom_0a6a5887_2:Stop()
	module4.WaitForCinematicToFinish(nearestTagged)
	_T.WarsongFishing = true
	_T.WarsongFishingStarted = false
	_T.WarsongFishingLureEnteredWater = false
	_T.WarsongFishingHooked = false
	_T.WarsongFishingMinnowCaught = false
	_T.WarsongFishCaught = false
	_T.WarsongFishingCompleted = false
	local v20 = false
	local v21 = false
	local v22 = false

	while _T.WarsongFishingStarted ~= true do
		Sleep(0)
	end

	module9.PlayGlobalTransmission(transmissionSet, Symbol("DoyenSpinAndLob"), true)

	while _T.WarsongFishingCompleted ~= true do
		if _T.WarsongFishingLureEnteredWater and not v20 then
			module9.PlayGlobalTransmission(transmissionSet, Symbol("DoyenReelNowGentle"), true)
			v20 = true
		end

		if _T.WarsongFishingHooked and not v21 then
			module9.PlayGlobalTransmission(transmissionSet, Symbol("DoyenMindTheLine"), true)
			v21 = true
		end

		if _T.WarsongFishingMinnowCaught and not v22 then
			module9.PlayGlobalTransmission(transmissionSet, Symbol("DoyenLookAtThatOne"), true)
			v22 = true
		end

		if _T.WarsongFishingEnded then
			break
		else
			Sleep(0)
		end
	end

	Sleep(2)
	_T.WarsongFishing = false
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P11.5-Scene14"))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WSP_11.5DoyenDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:__wf_atom_a3d2b66b(__wf_atom_0a6a5887_4, Symbol("Doyen"))
		__wf_atom_0a6a5887_3:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) and __wf_atom_0a6a5887_3:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	__wf_atom_c4f78a8f2:MotionControl():__wf_atom_99fc7a82(true)
	module4.Fade(true, 0)
	module8.SwapLastAssignedControllableAvatar(true, true, true)
	local __wf_atom_c4f78a8f4 = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f4:MotionControl():__wf_atom_99fc7a82(false)
	__wf_atom_c4f78a8f4:__wf_atom_e25a34ac(false)
	module16.UnpauseTimeOfDay()

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

local v20 = Symbol("WarsongMendicantAmbush-P12")
local v21 = Symbol("MendicantsP12EncounterCallback")

local function fn14(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 3 then
		_T.WarsongP12AmbushDefeated = true
		object:Disable()
	end
end

function P12HorseGate(p)
	if not fn(mOwner, p, true) then
		return
	end

	module4.Fade(true, 0)

	if not module4.IsOverworldResourceSpawningPaused() then
		module4.PauseOverworldResourceSpawning()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module5.SetLevelUpNotificationsVisible(false)
	fn7(0)
	module16.SetWeatherCycleEnabled(false)
	module16.SetTimeOfDay(3)
	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)

	if not module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxDeepWater") then
		if not __wf_atom_7e8ad928(fishRiderProcLevel) then
			module4.StreamInLevelRegion(fishRiderProcLevel, nil, Vector(0, -250, 0), 345, false, nil)
		end

		while not module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxDeepWater") do
			Sleep(1)
		end
	end

	while module4.IsStreamingLevel() do
		Sleep(0)
	end

	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v5)

	if not __wf_atom_0a6a5887:IsEnabled() then
		__wf_atom_0a6a5887:Enable()
	end

	module4.Fade(false, 2)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("EmpressFairByThyFall"), false)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P12-Scene15"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	__wf_atom_e55d02aa:__wf_atom_94e73c15(1, false)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(2, false)
	__wf_atom_e55d02aa:__wf_atom_94e73c15(3, true)
	ShowAbilityHudPopup(__wf_atom_e55d02aa, 1)
	ShowAbilityHudPopup(__wf_atom_e55d02aa, 2)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(v20)
	__wf_atom_0a6a5887_3:Enable()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	__wf_atom_7d789620:AddEncounter(mendicantP12EncounterType)
	__wf_atom_7d789620:ActivateSpecificEncounterAtSpecificHint(__wf_atom_0a6a5887_3, mendicantP12EncounterType)
	__wf_atom_0a6a5887_3:__wf_atom_7dd025d4(fn14, v21)

	while not _T.WarsongP12AmbushDefeated do
		Sleep(0.5)
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("ExitStreamTrigger"), __wf_atom_c4f78a8f:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_6887ec2f(true)
		nearestTagged:__wf_atom_a867ade3(true)
	end

	gRegion:__wf_atom_0a6a5887(v6):Enable()
	module9.PlayGlobalTransmission(transmissionSet, Symbol("EmpressWeakYourMarrow"), false)
	module2.WaitForInteraction(Symbol("WarsongQuest-P12-DoyenStaffInteractable"), p, 0)
	Sleep(1)
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P12-Scene16"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) and __wf_atom_0a6a5887_4:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	module2.WaitForGoToLocation(Symbol("WarsongQuest-P12-ExitProcTrigger"), p, 0)
	module16.SetTimeOfDay(4)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	gRegion:__wf_atom_0a6a5887(v5):Disable()
	module4.StreamOutLevelRegion(345)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

local v22 = Symbol("WarsongMendicantRiderEncounter")
local v23 = Symbol("RiderEncounterCallback")
local v24 = false

local function fn15(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 2 then
		return
	end

	if __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 3 then
		_T.WarsongRiderDefeated = true
		object:Disable()
	end
end

local function fn16(position)
	local v25 = position + _T.WarsongPlayerMountAvatar:__wf_atom_a06d543c() * 1.5
	local v26 = __wf_atom_fa8d0177(position, v25)
	local __wf_atom_50a7d83e = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		ravenAgentType,
		v25,
		v26,
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0
	):__wf_atom_50a7d83e()
	_T.RavenGuideAvatar = __wf_atom_50a7d83e
end

function P125MendicantRider(p)
	if not fn(mOwner, p, true) then
		return
	end

	module3.LoadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	fn9(true)

	if module4.HasStreamedLevel("/SF/Levels/Procs/FallenFortress/FFxDeepWater") then
		module4.StreamOutLevelRegion(345)
	end

	if not module4.IsOverworldResourceSpawningPaused() then
		module4.PauseOverworldResourceSpawning()
	end

	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module5.SetLevelUpNotificationsVisible(false)
	fn7(2)

	if v10 and _G.EnableDevTeleportToActiveStep then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(debugTeleportRiderTag)
		__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v22)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Early out, combat hint not found for mendicant rider")
		return
	end

	fn4(Symbol("WarsongP12BlockerHint"))
	__wf_atom_0a6a5887:Enable()
	__wf_atom_0a6a5887:__wf_atom_7dd025d4(fn15, v23)
	module16.SetWeatherCycleEnabled(false)
	module16.SetTimeOfDay(stageTOD)
	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)
	module10.UpdateOrAddHudTask(mOwner, p)
	module.CreateAreaMarker(__wf_atom_0a6a5887, 25, __wf_atom_28d5d4aa, mOwner, p)
	module2.WaitForGoToLocation(Symbol("WarsongQuest-P12.5-RiderApproach"), p, 2)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("MenRiderWickedComes"), true)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("MenRiderIchorousBlood"), false)

	while not _T.WarsongRiderDefeated do
		Sleep(0.5)
	end

	while __wf_atom_7e8ad928(_T.WarsongPlayerMountAvatar) do
		Sleep(0.1)
	end

	Sleep(1.5)
	module4.Fade(true, 1)

	if not __wf_atom_7e8ad928(_T.WarsongPlayerMountAvatar) then
		local position = _T.WarsongPlayerMountAvatar:GetPosition()
		module4.UnequipWeapon(__wf_atom_c4f78a8f, true)
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P12.5-Scene12.5"))
		fn16(position)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(_T.RavenGuideAvatar, Symbol("Raven"))
			__wf_atom_0a6a5887_2:FirePort("StartPlaying")

			while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) and __wf_atom_0a6a5887_2:__wf_atom_7d4910e4() do
				Sleep(0)
			end
		end

		_T.RavenGuideAvatar:__wf_atom_921c1a5f(ravenLoopOnPerchAnim, false, 3, 2, true)
		_T.WarsongPlayerMountAvatar:GetPosition()
		local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
		__wf_atom_c4f78a8f2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		__wf_atom_e55d02aa:__wf_atom_94e73c15(1, false)
		__wf_atom_e55d02aa:__wf_atom_94e73c15(2, false)
		__wf_atom_e55d02aa:__wf_atom_94e73c15(3, false)
		ShowAbilityHudPopup(__wf_atom_e55d02aa, 3)
	end

	module4.ResumeOverworldResourceSpawning()
	__wf_atom_0a6a5887:Disable()
	module10.CompleteHudTask(mOwner, nil, p, completetime)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P126DisableHorseRideMusic() end

function P126RideTheHorse(p)
	if not fn(mOwner, p, true) then
		return
	end

	module3.LoadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	fn9(true)
	fn4(Symbol("WarsongP12BlockerHint"))
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module5.SetLevelUpNotificationsVisible(false)
	fn7(3)

	if module4.IsInOverworld() then
		local v25 = Symbol("WarsongQuest-P12.6-RidableHorseDebugTeleport")
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v25)

		if Distance(__wf_atom_0a6a5887:GetPosition(), __wf_atom_c4f78a8f:GetPosition()) > 50 then
			module.DevTeleportPlayers(v25, true)
		end
	elseif not module4.IsInOverworld() then
		return
	end

	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	module4.TaggedFirePorts(Symbol("WarsongBridgeDebris"), "TriggerPort")
	module16.SetWeatherCycleEnabled(false)
	module16.SetTimeOfDay(stageTOD)
	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)
	module16.SetLightning(true, 0, true)
	module14.EnableTaggedSoundSysVolumes(Symbol("ArbinnHillsTwoMusicVol"), false)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("RavenStarStar"), false)

	if __wf_atom_7e8ad928(_T.WarsongPlayerMountAvatar) then
		local v25 = module4.WaitForAiDir()
		local __wf_atom_68de036a = __wf_atom_c4f78a8f:__wf_atom_68de036a()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RidableHorseSpawnPoint"))
		local __wf_atom_402b3832 = v25:__wf_atom_402b3832(
			ridableHorseAgentType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			EMPTY_SYMBOL,
			__wf_atom_68de036a
		)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			print("ERROR - Failed to spawn ridable horse from Warsong Mendicant Rider.")
			return
		end

		_T.WarsongPlayerMountAvatar = __wf_atom_402b3832:__wf_atom_50a7d83e()
		Sleep(0.2)

		if __wf_atom_7e8ad928(_T.RavenGuideAvatar) then
			fn16(_T.WarsongPlayerMountAvatar:GetPosition())
		end
	end

	local v25 = false

	while not v24 do
		v24 = _T.WarsongPlayerMountAvatar:__wf_atom_ff585b80()

		if
			not __wf_atom_7e8ad928(_T.RavenGuideAvatar)
			and not v25
			and _T.RavenGuideAvatar:__wf_atom_1c8f7b2d(__wf_atom_c4f78a8f) < 2.5
		then
			_T.RavenGuideAvatar:__wf_atom_921c1a5f(nil, false)
			local __wf_atom_bb3e7833 = _T.RavenGuideAvatar:__wf_atom_bb3e7833(__wf_atom_589cefdb)

			if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833:IsEnabled()) then
				__wf_atom_bb3e7833:Enable()
				__wf_atom_bb3e7833:FirePort("Execute")
			end

			v25 = true
		end

		Sleep(0)
	end

	Sleep(0.1)

	while not _T.WarsongPlayerMountAvatar:__wf_atom_43e52301() do
		Sleep(0)
	end

	_T.WarsongPlayerMountAvatar:__wf_atom_921c1a5f(playerMountHorseAnim, true, 3, 1, true)
	__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
	module9.PlayGlobalTransmission(transmissionSet, Symbol("EmpressRageyMangey"), false)
	module14.EnableTaggedSoundSysVolumes(Symbol("WarsongMndHorseRideMusic"), true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WSP12.6-RescueScaredAnimals"))
	local position = __wf_atom_0a6a5887:GetPosition()
	module10.UpdateOrAddHudTask(mOwner, p, hudTasks[1])
	local v26 = module2.HandleSparrowAndCreateMarker(2, __wf_atom_0a6a5887, p, mOwner)
	fn4(Symbol("WarsongP12-5BlockerHint"))
	local randomEntitiesAtWaypoints = module4.CreateRandomEntitiesAtWaypoints(
		animalCageTypes,
		Symbol("AnimalCageSpawn"),
		__wf_atom_0a6a5887
	)
	local v27 = {}

	for _, randomEntitiesAtWaypoint in pairs(randomEntitiesAtWaypoints) do
		table.insert(v27, randomEntitiesAtWaypoint:__wf_atom_bb3e7833(__wf_atom_0f45538d))
	end

	while not module4.AnyPlayerNearPos(position, 150, true) do
		Sleep(0)
	end

	while not module4.AnyPlayerNearPos(position, 35, true) do
		Sleep(0)
	end

	module10.CompleteHudTask(mOwner, nil, p, completetime)
	module2.HandleSparrowAndRemoveMarker(2, v26, __wf_atom_0a6a5887, p)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("Warsong-P126-SpawnControl-Final"))
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Warsong-P126-SpawnControl"))

	for i = 1, #__wf_atom_2226b35c do
		if not __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
			__wf_atom_2226b35c[i]:FirePort("RemoveAgents")
		end
	end

	while __wf_atom_0a6a5887_2:__wf_atom_cfb1f23d() do
		Sleep(0)
	end

	module14.EnableTaggedSoundSysVolumes(Symbol("WarsongMndHorseRideMusic"), false)
	module2.WaitForMultipleInteractions(v27, p, true, mOwner, 0, hudTasks[2])
	module2.WaitForGoToLocation(castleLocationTriggerTag, p, 2, true, mOwner, hudTasks[3])
	__wf_atom_0a6a5887_2:FirePort("RemoveAgents")
	module10.CompleteHudTask(mOwner, nil, p, completetime)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P13BayorBattle(p)
	if not fn(mOwner, p, true) then
		return
	end

	gGameRules:__wf_atom_3033c325(true)
	module3.LoadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })

	while __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(Symbol("WSP13_StageSetup")))) do
		Sleep(0)
	end

	module4.TaggedFirePorts(Symbol("WSP13_StageSetup"), "TriggerPort")
	fn9(true)
	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	module16.SetWeatherCycleEnabled(false)
	module16.SetTimeOfDay(stageTOD)
	module16.SetOvercast(1)
	module16.SetWindy(1)
	module16.SetRaining(true)
	module16.SetLightning(true, 0, true)
	print("Warsongs Quest: Stage 13 Defeat Defeat Bayor")

	if module4.IsInOverworld() then
		module.DevTeleportPlayers(debugTeleportWpSYM, true)
	end

	if not module4.IsInOverworld() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module5.SetLevelUpNotificationsVisible(false)
	fn7(3)
	fn4(Symbol("WS-BlockBridgeDynamicEncounters"))
	local v25 = nil
	local v26 = false
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(cinematicBossFightControllerTag)
	local v27

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		v27 = __wf_atom_0a6a5887_2:__wf_atom_e919fb8e()
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v25 = __wf_atom_0a6a5887:__wf_atom_e800787c()
	end

	while __wf_atom_7e8ad928(v27.BossFightCompleted) or not v27.BossFightCompleted do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		elseif v25 and (v25 == __wf_atom_c4f78a8f:__wf_atom_e800787c()) ~= v26 then
			v26 = not v26

			if not (v26 or __wf_atom_7e8ad928(nil)) then
				module6.AddQuestDestination(nil, mOwner, p)
			end
		end

		if v26 then
			if __wf_atom_7e8ad928(_T.PreventingNightfold) then
				_T.needsBarRestored = true
			end
		elseif
			__wf_atom_7e8ad928(_T.mBayorAvatar)
			and not __wf_atom_7e8ad928(_T.PreventingNightfold)
			and _T.PreventingNightfold
		then
			_T.PreventingNightfold = nil
			module7.ClearPreventNighfoldUsage()

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(nil)
			end
		end

		Sleep(1)
	end

	module4.TaggedFirePorts(Symbol("WSP13_StageCleanUp"), "TriggerPort")
	module16.ClearWeather()
	module16.SetWeatherCycleEnabled(true)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function P14SkyCastelTease(p)
	if not fn(mOwner, p, false) then
		return
	end

	module4.TaggedFirePorts(Symbol("WarsongQuest-SetCorruptedTentInterior"), "TriggerPort")
	print("Warsongs Quest: Stage 14 To the Sky")

	if module4.IsInOverworld() then
		module.DevTeleportPlayers(debugTeleportWpSYM, true)
	end

	if not module4.IsInOverworld() then
		return
	end

	module16.ClearWeatherAndDisableCycle()
	module16.SetTimeOfDay(stageTOD)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WSP14-ToSkyCastelBalloon"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("ToSkyCastle"))
	module6.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p)
	local v25 = nil
	local v26 = nil
	local v27 = nil

	while false == false do
		if __wf_atom_7e8ad928(v25) then
			v25 = gRegion:__wf_atom_0a6a5887(Symbol("WSP14-StarSkyCastleSequence"))
		end

		if __wf_atom_7e8ad928(v26) then
			v26 = gRegion:__wf_atom_0a6a5887(Symbol("WSP14-SkycastleStreamingHint"))
		end

		if __wf_atom_7e8ad928(v27) then
			v27 = gRegion:__wf_atom_0a6a5887(Symbol("WSP14-SkyCastleTP"))
		end

		if __wf_atom_7e8ad928(v26) or __wf_atom_7e8ad928(v25) or __wf_atom_7e8ad928(v27) then
			Sleep(1)
		else
			v26:FirePort("Enable")
			break
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true, true)
		__wf_atom_0a6a5887_2:Enable()
	end

	module6.RemoveSparrowDestination(__wf_atom_0a6a5887_2, p)
	module2.WaitForGoToLocation(Symbol("WSP14-StarSkyCastleSequence"), p, 0, false, mOwner)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(cinematicTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		Sleep(15)
		module4.Fade(true, 1)
		Sleep(5)
	else
		module4.PlayCinematicAndWait(__wf_atom_0a6a5887_3, false)
		module4.Fade(true, 1)
	end

	module.TeleportPlayers(Symbol("WSP14-BackToEarth"), false)
	v26:FirePort("Disable")
	Sleep(1)
	module4.Fade(false, 1)

	if __wf_atom_7e8ad928(v8) then
		print("Finished task")
	else
		print("Finished " .. v8)
	end

	module.CompleteTaskWithID(mOwner, p)
	_T.ProgressionScreenDisabled = false
	module5.SetLevelUpNotificationsVisible(true)
end

function TPToSkyTower(object, _)
	object:Disable()
	module16.SwapSkyTo(Symbol("OdeSkyCastleSky"))
	module16.SetTimeOfDay(13)
	module.TeleportPlayers(Symbol("WSP14-SkyCastleTP"), false)
end

function DissolveOut(object)
	local v25 = 0

	while v25 < 1 do
		v25 = __wf_atom_421b01aa(v25 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v25)
		Sleep(0)
	end
end

function DissolveIn(object)
	local v25 = 0

	while v25 < 1 do
		v25 = __wf_atom_421b01aa(v25 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(1 - v25)
		Sleep(0)
	end
end

function BlockPlayerMovement(_, object)
	if not __wf_atom_7e8ad928(elevatorInputFilter) then
		object:__wf_atom_aeb02c14(elevatorInputFilter)
	end
end

function FreePlayerMovement(_, object)
	if not __wf_atom_7e8ad928(elevatorInputFilter) then
		object:__wf_atom_cf966a74(elevatorInputFilter)
	end
end

function PickUpBanglenut()
	if not __wf_atom_7e8ad928(_T.BanglenutPicked) then
		_T.BanglenutPicked = _T.BanglenutPicked + 1
	end
end

function DeactivateFixAvatar()
	module8.EnsureAdultAvatar(childAvatarType, envoyAvatarType)
end

function ShowAbilityHudPopup(object, p)
	local v25

	if not __wf_atom_7e8ad928(object) then
		v25 = object:__wf_atom_c497b0ae(p)
	end

	if not __wf_atom_7e8ad928(v25) then
		module8.ShowAcquiredNotification(v25:__wf_atom_1bb5b1ff(), (tostring(p + 1)))
	end
end