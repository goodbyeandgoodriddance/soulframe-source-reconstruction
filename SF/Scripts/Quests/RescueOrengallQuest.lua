local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.QuestFunctionsLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local module7 = require("SF.Scripts.Libs.SparrowLib")
local module8 = require("Lotus.Scripts.Libs.StoryLib")
local module9 = require("Lotus.Scripts.Libs.AudioLib")
local module10 = require("SF.Scripts.Libs.RaycastLib")
local module11 = require("Lotus.Interface.LotusUtilities")
local module12 = require("SF.Scripts.Libs.DungeonLocationInfo")
local v = Symbol("/SF/Language/Codex/PupFetchMemory")
local v2 = nil
local v3 = nil
local v4 = Symbol("BanneretPlayerInvulnerabilitySymbol")
local v5 = WeakResource("/SF/Levels/OutroScene.level")
local v6 = WeakResource("/SF/Levels/Portraits/Dioramas/TempestBayorWithPupDioramaB.level")
local v7 = WeakResource("/SF/Types/Npcs/Actions/OrengallQuestAmbushConversationAction")
local v8 = WeakResource("/SF/Levels/QuestLevels/OrengalCubChoice.level")
local v9 = nil
local v10 = nil
local v11 = WeakResource("/SF/Types/Quests/OmenBeastQuests/TheOmenOrengall")
local v12 = Symbol("PostOrengallQuest")
local v13 = nil
local v14 = Symbol("ActiveOrengallBossEncounter")
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil

local function fn(p, p2, p3, p4)
	local v23 = mOwner:GetName() .. "-" .. tostring(module2.GetReadableTaskTag(mOwner, p))

	if __wf_atom_7e8ad928(p2) then
		module7.RemoveSparrowDestination(nil, v23)
	else
		module7.AddSparrowDestination(p2, nil, v23, module7.PRIORITY.QUEST, Range(5, 3.4028234663852886e38), mOwner, p)
	end

	if not __wf_atom_7e8ad928(p3) then
		if __wf_atom_7e8ad928(v19) then
			if not __wf_atom_7e8ad928(p2) then
				module2.DestroyAreaMarker(p2)
			end
		else
			v19:Destroy()
		end

		v19 = module2.CreateAreaMarker(p2, p3, p4, mOwner, p)
	end
end

local function fn2(p)
	Sleep(1)
	local __wf_atom_bb972fd2 = mOwner:__wf_atom_bb972fd2()
	local v23 = 0

	for _, v24 in ipairs(__wf_atom_bb972fd2) do
		local v25 = tostring(module2.GetReadableTaskTag(mOwner, v24))

		if string.find(v25, "RescueCub") then
			v23 += 1
		end
	end

	if p then
		v23 -= 1
	end

	if v23 == 1 then
		return 2
	end

	return v23 == 0 and 3 or 0
end

function PostQuestRewardScreen()
	_T.ForceShowPup = true
end

local function fn3()
	if __wf_atom_7e8ad928(_T.NumCubsRescued) then
		_T.NumCubsRescued = 0
	end

	if _T.NumCubsRescued <= 1 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("SFXWolfCubABStinger"))
		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("SFXWolfCubABDistant"))
		local v23, v24

		if not (__wf_atom_7e8ad928(__wf_atom_2226b35c) or __wf_atom_7e8ad928(__wf_atom_2226b35c2)) then
			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				v23 = __wf_atom_2226b35c[__wf_atom_5784a397(1, #__wf_atom_2226b35c)]
				v24 = __wf_atom_2226b35c2[__wf_atom_5784a397(1, #__wf_atom_2226b35c2)]
			else
				v23 = module.NearestObject(__wf_atom_c4f78a8f:GetPosition(), __wf_atom_2226b35c)
				v24 = module.NearestObject(__wf_atom_c4f78a8f:GetPosition(), __wf_atom_2226b35c2)
			end
		end

		if not __wf_atom_7e8ad928(v23) then
			v23:FirePort("Enable")
		end

		if not __wf_atom_7e8ad928(v24) then
			v24:FirePort("Enable")
		end
	end
end

local function fn4(position, p)
	while not module.AnyPlayerNearPos(position, p, true) do
		if not module.IsInOverworld() then
			return false
		end

		Sleep(0.2)
	end

	return true
end

local function fn5(p, p2)
	local entity = gRegion:CreateEntity(wolfTrailType, p, __wf_atom_80368bb1)
	entity:__wf_atom_a64eca67(p2)
	entity:__wf_atom_c709edee(225)

	if #entity:__wf_atom_7df70ec2() > 0 then
		entity:__wf_atom_7cbad21b((math.floor(entity:__wf_atom_f2f158da() / 2)))
		entity:__wf_atom_fa550593()
		return entity
	else
		print("Failed to spawn Orengall trail")
	end
end

local function fn6(object)
	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	if not (__wf_atom_7e8ad928(__wf_atom_6199ef01) or __wf_atom_7e8ad928(__wf_atom_6199ef01[1])) then
		local __wf_atom_50a7d83e = __wf_atom_6199ef01[1]:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
			v10 = __wf_atom_50a7d83e:Attach(
				orengallAmbushTigger,
				Symbol("GAME_C1_SPINE1"),
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)
			object:__wf_atom_d494454b(v10)
			return true
		end
	end
end

local function fn7(orengallAttackDoneAvatar)
	local v23 = Resource("/SF/Animations/Wildlife/Wolf/TentTeleportStart_anim.fbx")
	local v24 = Type("/SF/Fx/Abilities/Common/Summon/DesummonAttachFX")

	if not __wf_atom_7e8ad928(v24) then
		orengallAttackDoneAvatar:Attach(
			v24,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			orengallAttackDoneAvatar,
			1
		)
	end

	local __wf_atom_921c1a5f = orengallAttackDoneAvatar:__wf_atom_921c1a5f(v23, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	orengallAttackDoneAvatar:Destroy()
end

function ShowDiorama()
	module8.PlayCinematic(v17, nil, false, true, 1, 1)
end

function StartOrengalQuest(object)
	if not (gRegion:IsMaster() and module.IsInOverworld()) or module2.QuestIsActive(v11) then
		return
	end

	module4.CloseTransmissions()

	if not __wf_atom_7e8ad928(Resource(v11)) then
		while __wf_atom_7e8ad928(object) and object:IsKilled() do
			Sleep(0)
		end

		module2.StartQuest(Resource(v11))
	end
end

local function fn8(value) -- 20 equivalent calls inferred from this helper
	print("Streaming shutdown: " .. (value or "Unnamed task"))
end

function VisionsOfOrengal(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	module2.TrackQuest(mOwner)
	gGameData:__wf_atom_04988606(Symbol("OrengallQuest"), "")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("OrengalNote"))

	for i = 1, #__wf_atom_2226b35c do
		local v23 = __wf_atom_2226b35c[i]

		if not __wf_atom_7e8ad928(v23) then
			v23:Destroy()
		end
	end

	if not module.PlayCinematicWithTagAndWait(Symbol("VisionOfOrengal")) then
		fn8("VisionsOfOrengal: Cinematic didn't complete") -- inferred equivalent call
		return
	end

	module.Fade(false)

	if gRegion:IsMaster() then
		print("Orengall Quest: VisionsOfOrengal done")
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function FakeOutEnding()
	local v23 = { Label = "/SF/Language/Objectives/CompletedOrengallRescue", CacheIndex = 1 }
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		module2.TriggerPlayerProgressionCelebration(__wf_atom_c4f78a8f, v23)
	end
end

function RescueOrengal(p)
	if not module2.InitializeTask(mOwner, p, false, true) then
		return
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("UC-Mines-Mill"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CampSetUpForwarder"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("OrengalCampEncounter"))
	local position = __wf_atom_0a6a5887_3:GetPosition()

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("TriggerPort")
	end

	local combatBlockingContainer = module6.SpawnCombatBlockingContainer(randomCombatBlockingContainerType, position)
	fn(p, __wf_atom_0a6a5887_3, 50)
	module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), true)
	local v23 = 0

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) and v23 ~= 4 and v23 ~= 3 do
		v23 = __wf_atom_0a6a5887_3:__wf_atom_4026dfb5()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or not module.IsInOverworld() then
		fn8("RescueOrengal 2") -- inferred equivalent call
		return
	end

	fn(p, (gRegion:__wf_atom_0a6a5887(Symbol("TrappedOrengal"))))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(freeOrengalContextActionTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		fn8("RescueOrengal 2.5") -- inferred equivalent call
		return
	end

	__wf_atom_0a6a5887_4:Enable()

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) and __wf_atom_0a6a5887_4:IsEnabled() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		fn8("RescueOrengal 3") -- inferred equivalent call
		return
	end

	fn(p, nil)

	if __wf_atom_7e8ad928(v19) then
		if not __wf_atom_7e8ad928(nil) then
			module2.DestroyAreaMarker(nil)
		end
	else
		v19:Destroy()
	end

	Sleep(1.5)
	local v24 = nil

	for _, v25 in pairs(gRegion:__wf_atom_3c8e1a7a()) do
		if __wf_atom_7e8ad928(v25) or not __wf_atom_0a6a5887_4:__wf_atom_c5ea85f0(v25) then
			continue
		end

		v24 = v25:__wf_atom_50a7d83e()
		break
	end

	local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("FreeOrengal"))
	__wf_atom_0a6a5887_5:SetInstigatorAvatar(v24)
	module.PlayCinematicAndWait(__wf_atom_0a6a5887_5)
	module.Fade(false)
	local __wf_atom_0a6a5887_6 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallFakeOutTrigger"))
	Sleep(2)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_6) then
		__wf_atom_0a6a5887_6:FirePort("Execute")
		module9.PlaySound(fakeEndingCue)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or not module.IsInOverworld() then
		fn8("RescueOrengal 4") -- inferred equivalent call
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("OdeFenceTrap"), position, 0, 200)

	for _, v25 in ipairs(__wf_atom_439c0d29) do
		gRegion:__wf_atom_dd1e4d10(v25)
	end

	if not __wf_atom_7e8ad928(combatBlockingContainer) then
		combatBlockingContainer:Destroy()
	end

	if gRegion:IsMaster() then
		module5.CompleteHudTask(mOwner, nil, p, module5.COMPLETETIME)
		Sleep(module5.COMPLETETIME)
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function TwoDayWait(p)
	module.WaitForLevel()

	if not module.IsInOverworld() then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("UC-Mines-Mill"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	fn(p, nil)
	module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), true)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_7d789620 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	local v23 = Symbol("OrengallQuest")
	local v24 = 180
	local v25 = nil
	local v26 = nil

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(0.1)
	end

	if gGameData:__wf_atom_b3cdb701(v23) then
		if gGameData:__wf_atom_b3be0cc6(v23) > 1440.0000921600058 then
			gGameData:__wf_atom_a975522c(v23, 1, false, "")
		end
	else
		gGameData:__wf_atom_a975522c(v23, 1440.0000921600058, false, "")
	end

	while not gGameData:__wf_atom_b3cdb701(v23) do
		Sleep(1)
	end

	while not gGameData:__wf_atom_20bf298d(v23) do
		Sleep(10)

		while __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) do
			Sleep(1)
		end

		v24 -= 10

		if not (v24 <= 0) then
			continue
		end

		local v27 = true
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		if not __wf_atom_7e8ad928(v25) then
			local __wf_atom_7df70ec2 = v25:__wf_atom_7df70ec2()

			for _, v28 in ipairs(__wf_atom_ef7900cf) do
				for _, v29 in ipairs(__wf_atom_7df70ec2) do
					if not (v28:__wf_atom_d5fda8be(v29) <= 50) then
						continue
					end

					v27 = false
					break
				end

				if not v27 then
					break
				end
			end
		end

		if not (v27 and #__wf_atom_ef7900cf > 0) then
			continue
		end

		if not __wf_atom_7e8ad928(v25) then
			v25:Destroy()
		end

		if not __wf_atom_7e8ad928(v26) then
			v26:Destroy()
		end

		local v28 = __wf_atom_ef7900cf[__wf_atom_5784a397(1, #__wf_atom_ef7900cf)]
		local v29 = v28:GetPosition() + v28:__wf_atom_a06d543c() * __wf_atom_5784a397(50, 60)
		local v30 = Vector()
		__wf_atom_2202ffb6:__wf_atom_3cc125d0(v29, v30)
		local randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(v30, 15, 25, true, 0.5)

		if v30 == __wf_atom_28d5d4aa or __wf_atom_7e8ad928(randomPointInRangeOnNav) then
			v24 = 20
		else
			local groundAlignedSpawnPosRot, v31 = module10.GetGroundAlignedSpawnPosRot(deadNpcType, v30)

			if not __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
				v25 = fn5(randomPointInRangeOnNav, v30)
				v26 = gRegion:CreateEntity(deadNpcType, groundAlignedSpawnPosRot, v31)
				v24 = __wf_atom_5784a397(180, 240)
			end
		end
	end

	gGameData:__wf_atom_04988606(v23, "")

	if gRegion:IsMaster() then
		Sleep(6)
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function OrengallAmbushDynamic(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	module9.EnableTaggedSequencers(Symbol("SFXHowlWaitOverHint"), true)
	module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), false)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local encounterHints = __wf_atom_7d789620:SelectEncounterHints(Symbol("OrengallAmbush"))
	local v23 = Symbol("StrongPointArea")
	local v24 = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/GruntAvatarBase")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local areaMarkers = {}
	local v25 = nil

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		Sleep(0)
	end

	local sortByDistance = module.SortByDistance(encounterHints, __wf_atom_c4f78a8f:GetPosition())
	local count = 0

	for _, v26 in ipairs(sortByDistance) do
		local __wf_atom_5b6b447d = v26:__wf_atom_5b6b447d()

		if not (v26:__wf_atom_1c8f7b2d(__wf_atom_c4f78a8f) > 200 and (__wf_atom_7e8ad928(__wf_atom_5b6b447d) or __wf_atom_5b6b447d == EMPTY_SYMBOL) and v26:__wf_atom_4026dfb5() < 2) then
			continue
		end

		if v26:__wf_atom_f43d338d() or not module6.EncounterHintHasTag(v26, v23) then
			continue
		end

		local areaMarker = module2.CreateAreaMarker(v26, 60, __wf_atom_28d5d4aa, mOwner, v18)
		module7.AddSparrowDestination(
			areaMarker,
			nil,
			nil,
			module7.PRIORITY.QUEST,
			Range(15, 3.4028234663852886e38),
			mOwner,
			v18
		)
		table.insert(areaMarkers, areaMarker)
		count += 1

		if count >= 3 then
			break
		end
	end

	while __wf_atom_7e8ad928(_T.OrengallAttackDoneAvatar) and module.IsInOverworld() do
		if __wf_atom_7e8ad928(v10) then
			for _, v26 in ipairs(sortByDistance) do
				if __wf_atom_7e8ad928(v26) or v26:__wf_atom_4026dfb5() ~= 2 then
					continue
				end

				local __wf_atom_5b6b447d = v26:__wf_atom_5b6b447d()

				if not (__wf_atom_7e8ad928(__wf_atom_5b6b447d) or __wf_atom_5b6b447d == EMPTY_SYMBOL) then
					continue
				end

				local __wf_atom_6199ef01 = v26:__wf_atom_6199ef01()

				if not __wf_atom_7e8ad928(__wf_atom_6199ef01) and #__wf_atom_6199ef01 == 1 then
					local __wf_atom_50a7d83e = __wf_atom_6199ef01[1]:__wf_atom_50a7d83e()

					if
						not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
						and not __wf_atom_50a7d83e:IsKilled()
						and __wf_atom_50a7d83e:IsA(v24)
						and not __wf_atom_50a7d83e:__wf_atom_464a4772()
						and fn6(v26)
					then
						break
					end
				end

				if not (__wf_atom_7e8ad928(v25) and __wf_atom_7e8ad928(v10) and module6.EncounterHintHasTag(v26, v23)) then
					continue
				end

				local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

				if __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) then
					continue
				end

				local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_c4f78a8f2:GetPosition() + __wf_atom_c4f78a8f2:__wf_atom_a06d543c() * 30)

				if not __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
					v25 = fn5(
						__wf_atom_0e0a6fee,
						__wf_atom_7d789620:GetRandomPointInRangeOnNav(v26:GetPosition(), 0, 10, true, 0.5)
					)
					v26:__wf_atom_d494454b(v25)
				end

				__wf_atom_c4f78a8f2:Attach(soulModeTutorialTriggerType, EMPTY_SYMBOL)
			end
		end

		Sleep(1)
	end

	if not module.IsInOverworld() then
		fn8("Orengall ambush streaming 5") -- inferred equivalent call
		return
	end

	for _, v26 in ipairs(areaMarkers) do
		if not __wf_atom_7e8ad928(v26) then
			v26:Destroy()
		end
	end

	local orengallAttackDoneAvatar = _T.OrengallAttackDoneAvatar
	local position = orengallAttackDoneAvatar:GetPosition()
	local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(position, 50)

	if not __wf_atom_7e8ad928(__wf_atom_06db1fb1) then
		local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee((position + __wf_atom_06db1fb1:GetPosition()) / 2)
		local v26 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, __wf_atom_06db1fb1:GetPosition())
		local __wf_atom_30e3d82b = orengallAttackDoneAvatar:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_493b6680(position, v26, true, false)
		end
	end

	v19 = module2.CreateAreaMarker(orengallAttackDoneAvatar, 30, __wf_atom_28d5d4aa, mOwner, p)
	Sleep(1)

	if __wf_atom_7e8ad928(orengallAttackDoneAvatar) then
		fn8("Orengall ambush streaming 6") -- inferred equivalent call
		return
	end

	local __wf_atom_bb3e7833 = orengallAttackDoneAvatar:__wf_atom_bb3e7833(v7)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = orengallAttackDoneAvatar:Attach(
			Type("/SF/Types/Npcs/Actions/OrengallQuestAmbushConversationAction"),
			EMPTY_SYMBOL,
			Vector(0, 0, 2.7),
			Rotation(0, 180, 0)
		)
	end

	__wf_atom_bb3e7833:Enable()
	_T.OrengallConversationCompleted = false
	fn(p, __wf_atom_bb3e7833)
	module5.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/OrengallTalkObjective")

	while not _T.OrengallConversationCompleted do
		if module.IsInOverworld() then
			Sleep(1)
		else
			fn8("Orengall ambush streaming 7") -- inferred equivalent call
			return
		end
	end

	fn(p, nil)

	if __wf_atom_7e8ad928(v19) then
		if not __wf_atom_7e8ad928(nil) then
			module2.DestroyAreaMarker(nil)
		end
	else
		v19:Destroy()
	end

	module5.CompleteHudTask(mOwner, nil, p, module5.COMPLETETIME)

	while not module2.AllPlayersReady(mOwner, p) do
		Sleep(1)
	end

	Sleep(module5.COMPLETETIME)
	fn7(orengallAttackDoneAvatar)

	if gRegion:IsMaster() then
		print("Orengal Quest: Stage 3 done")
		_T.OrengallAttackDoneAvatar = nil
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function OrengallAmbush(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	module9.EnableTaggedSequencers(Symbol("SFXHowlWaitOverHint"), true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CampfireOrengalAmbush"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallAmbushTrapWaypoint"))
	local position = __wf_atom_0a6a5887_2:GetPosition()
	local combatBlockingContainer = module6.SpawnCombatBlockingContainer(
		randomCombatBlockingContainerType,
		__wf_atom_0a6a5887:GetPosition()
	)
	local combatBlockingContainer2 = module6.SpawnCombatBlockingContainer(
		randomCombatBlockingContainerType,
		__wf_atom_0a6a5887_2:GetPosition()
	)
	module6.SetDynamicCombatAllowed(__wf_atom_0a6a5887, false)
	module.TaggedFirePorts(Symbol("OrengallAmbushSetup"), "TriggerPort")
	module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), false)
	Sleep(5)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or not module.IsInOverworld() then
		fn8("Orengall ambush streaming 0") -- inferred equivalent call
		return
	end

	module5.UpdateOrAddHudTask(mOwner, p)
	fn(p, __wf_atom_0a6a5887, 70, Vector(30, 0, 30))

	if not fn4(__wf_atom_0a6a5887:GetPosition(), 50) then
		fn8("Orengall ambush streaming 1") -- inferred equivalent call
		return
	end

	fn(p, __wf_atom_0a6a5887)

	if
		module2.IsQuestTracked(mOwner)
		and __wf_atom_7e8ad928((module7.GetSparrowForPlayer(gRegion:__wf_atom_c4f78a8f())))
	then
		module7.SpawnSparrow()
	end

	if not fn4(__wf_atom_0a6a5887:GetPosition(), 8) then
		fn8("Orengall ambush streaming 2") -- inferred equivalent call
		return
	end

	local v23 = Symbol("OrengallAmbushTrailEnd")
	local v24 = Symbol("SparrowPerchPoint")
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallAmbushTrailStart"))
	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(v23)
	__wf_atom_0a6a5887_3:__wf_atom_31c6f706()
	__wf_atom_0a6a5887_3:__wf_atom_b811702e(v24)
	__wf_atom_0a6a5887_4:__wf_atom_b811702e(v24)
	local v25 = __wf_atom_0a6a5887_3

	while true do
		local __wf_atom_31c6f706 = v25:__wf_atom_31c6f706()

		if __wf_atom_7e8ad928(__wf_atom_31c6f706) or #__wf_atom_31c6f706 == 0 then
			break
		end

		fn5(v25:GetPosition(), __wf_atom_31c6f706[1]:GetPosition())
		v25 = __wf_atom_31c6f706[1]
	end

	module5.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/OrengallAmbushTracks")
	fn(p, __wf_atom_0a6a5887_3)

	if
		module2.IsQuestTracked(mOwner)
		and __wf_atom_7e8ad928((module7.GetSparrowForPlayer(gRegion:__wf_atom_c4f78a8f())))
	then
		module7.SpawnSparrow()
	end

	local position2 = __wf_atom_0a6a5887_3:GetPosition()

	while not (module.AnyPlayerNearPos(position2, 6) or module.AnyPlayerNearPos(position, 35)) do
		if module.IsInOverworld() then
			Sleep(0.2)
		else
			fn8("Orengall ambush streaming 3") -- inferred equivalent call
			return
		end
	end

	local v26 = Symbol("FenceTrapEncounterHint")
	local name = mOwner:GetName()
	local entity = gRegion:CreateEntity(trapType, position, __wf_atom_80368bb1)
	fn(p, v25)
	module7.SetupWaypointPath(name, __wf_atom_0a6a5887_3)
	local v27 = nil

	while not __wf_atom_7e8ad928(entity) do
		Sleep(1)
	end

	while __wf_atom_7e8ad928(v27) do
		if module.IsInOverworld() then
			v27 = gRegion:__wf_atom_f738b4af(v26, position, 0, 20)
			Sleep(1)
		else
			fn8("Orengall ambush streaming 4") -- inferred equivalent call
			return
		end
	end

	module7.RemoveSparrowDestination(v25, name)
	module7.RemoveWaypointPath(name)
	local __wf_atom_4026dfb5 = v27:__wf_atom_4026dfb5()
	local v28 = false

	while not __wf_atom_7e8ad928(v27) and __wf_atom_4026dfb5 ~= 4 and __wf_atom_4026dfb5 ~= 3 do
		if not v28 and __wf_atom_7e8ad928(v10) and v27:__wf_atom_3634e6d2() == 1 and __wf_atom_4026dfb5 == 2 then
			v28 = fn6(v27)
		end

		__wf_atom_4026dfb5 = v27:__wf_atom_4026dfb5()
		Sleep(0)
	end

	if not v28 then
		v10 = gRegion:CreateEntity(orengallAmbushTigger, position + Vector(0, 1, 0), __wf_atom_80368bb1)
		v27:__wf_atom_d494454b(v10)
	end

	if not module.IsInOverworld() then
		fn8("Orengall ambush streaming 5") -- inferred equivalent call
		return
	end

	while __wf_atom_7e8ad928(_T.OrengallAttackDoneAvatar) do
		Sleep(0)
	end

	local orengallAttackDoneAvatar = _T.OrengallAttackDoneAvatar
	local __wf_atom_30e3d82b = orengallAttackDoneAvatar:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:MoveTo(__wf_atom_0a6a5887_4, false, true, false)
		Sleep(5)
	end

	if __wf_atom_7e8ad928(orengallAttackDoneAvatar) then
		fn8("Orengall ambush streaming 6") -- inferred equivalent call
		return
	end

	local __wf_atom_bb3e7833 = orengallAttackDoneAvatar:__wf_atom_bb3e7833(v7)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = orengallAttackDoneAvatar:Attach(
			Type("/SF/Types/Npcs/Actions/OrengallQuestAmbushConversationAction"),
			EMPTY_SYMBOL,
			Vector(0, 0, 2.7),
			Rotation(0, 180, 0)
		)
	end

	__wf_atom_bb3e7833:Enable()
	_T.OrengallConversationCompleted = false
	fn(p, __wf_atom_bb3e7833)
	module5.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/OrengallTalkObjective")

	while not _T.OrengallConversationCompleted do
		if module.IsInOverworld() then
			Sleep(1)
		else
			fn8("Orengall ambush streaming 7") -- inferred equivalent call
			return
		end
	end

	fn(p, nil)

	if __wf_atom_7e8ad928(v19) then
		if not __wf_atom_7e8ad928(nil) then
			module2.DestroyAreaMarker(nil)
		end
	else
		v19:Destroy()
	end

	module5.CompleteHudTask(mOwner, nil, p, module5.COMPLETETIME)

	while not module2.AllPlayersReady(mOwner, p) do
		Sleep(1)
	end

	Sleep(2)
	fn7(orengallAttackDoneAvatar)

	if not __wf_atom_7e8ad928(combatBlockingContainer) then
		combatBlockingContainer:Destroy()
	end

	if not __wf_atom_7e8ad928(combatBlockingContainer2) then
		combatBlockingContainer2:Destroy()
	end

	if gRegion:IsMaster() then
		print("Orengal Quest: Stage 3 done")

		if not __wf_atom_7e8ad928(v10) then
			v10:Destroy()
		end

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Disable()
		end

		_T.OrengallAttackDoneAvatar = nil
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function PlayRescueDiorama()
	module4.CloseTransmissions()
	module8.PlayCinematic(cubRescueDioramaLevel, nil, false, true, 1, 1)
end

local function fn9(entity, p)
	if module.IsInOverworld() ~= p then
		return false
	end

	local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_589cefdb)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return false
	end

	__wf_atom_bb3e7833:FirePort("Execute")

	while _T.StoryLib_PlayingCin do
		Sleep(0)
	end

	return module.IsInOverworld() == p
end

local count = 0
local count2 = 0
local v23 = nil

local function fn10(position)
	local __wf_atom_0e0a6fee = v9:__wf_atom_0e0a6fee(position)
	local groundPos = module10.GetGroundPos(__wf_atom_0e0a6fee, Vector(0, 1, 0), Vector(0, -10, 0))
	v23 = gRegion:CreateEntity(v16, groundPos, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
	print("OrengallQuest key spawn at " .. tostring(groundPos))
	module7.AddSparrowDestination(v23, mOwner, nil, module7.PRIORITY.QUEST + 1, nil, mOwner, v18)
end

function OnKilled(object)
	count2 += 1

	if count <= count2 and not __wf_atom_7e8ad928(object) then
		local position = object:GetPosition()
		local __wf_atom_f51f1faa = object:__wf_atom_f51f1faa()

		if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
			position = __wf_atom_f51f1faa:GetPosition()
		end

		fn10(position)
	end
end

local function fn11(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 2 then
		local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

		for _, v24 in ipairs(__wf_atom_6199ef01) do
			local __wf_atom_50a7d83e = v24:__wf_atom_50a7d83e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
				continue
			end

			__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
			count += 1
			module7.AddSparrowDestination(__wf_atom_50a7d83e, nil, nil, module7.PRIORITY.QUEST, nil, mOwner, v18)
		end
	elseif __wf_atom_4026dfb5 == 1 then
		if not module.IsInOverworld() then
			fn3()
		end
	elseif __wf_atom_4026dfb5 == 3 then
		module7.RemoveSparrowDestination(nil, "CubRescue")
		Sleep(2)

		if not __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(v23) then
			fn10(object:GetPosition())
		end
	end
end

local function fn12(entity, object, p)
	if module.IsInOverworld() then
		local v24 = Vector(__wf_atom_5784a397(10, 30), 0, __wf_atom_5784a397(10, 30))
		v19 = module2.CreateAreaMarker(entity, 60, v24, mOwner, v18)
	end

	local v24 = false

	while __wf_atom_7e8ad928(v23) do
		Sleep(1)

		if __wf_atom_7e8ad928(entity) then
			return false
		end

		if
			v24
			or __wf_atom_7e8ad928(object)
			or object:__wf_atom_4026dfb5() ~= 2
			or not (object:__wf_atom_3634e6d2() <= p)
		then
			continue
		end

		if p == 0 then
			continue
		end

		v24 = fn6(object)
		module9.EnableNearestTaggedSequencer(Symbol("SFXWolfCubVocalFarABC"), false, entity:GetPosition())
		module9.EnableNearestTaggedSoundSysVolume(Symbol("MusicOrengallCubsAB"), false, entity:GetPosition())
	end

	print("Key dropped")
	module9.EnableNearestTaggedSequencer(Symbol("SFXWolfCubVocalFarABC"), false, entity:GetPosition())
	module9.EnableNearestTaggedSoundSysVolume(Symbol("MusicOrengallCubsAB"), false, entity:GetPosition())

	while not __wf_atom_7e8ad928(v23) do
		Sleep(1)

		if __wf_atom_7e8ad928(entity) then
			return false
		end
	end

	print("Key picked up")
	module7.AddSparrowDestination(entity, nil, "CubRescue", module7.PRIORITY.QUEST, nil, mOwner, v18)

	while not entity:__wf_atom_b81a6e66() do
		Sleep(0.5)

		if __wf_atom_7e8ad928(entity) then
			return false
		end
	end

	module7.RemoveSparrowDestination(nil, "CubRescue")

	if __wf_atom_7e8ad928(v19) then
		if not __wf_atom_7e8ad928(nil) then
			module2.DestroyAreaMarker(nil)
		end
	else
		v19:Destroy()
	end

	return true
end

function DummyRescueStage(p)
	module.WaitForLevel()
	Sleep(1)
	_T.NumCubsRescued = fn2(nil)
	local v24 = module5.GetQuestTaskLoc(mOwner, p) or ""
	module5.UpdateOrAddHudTask(mOwner, "OrengallPuppyRescue", v24)
	module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), false)
	fn3()
end

function RescueTheCubs(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	v18 = p

	if __wf_atom_7e8ad928(v9) then
		v9 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if fn2() <= 1 then
		_T.NumCubsRescued = 0
		v15 = cubCageType[1]
		v16 = cageKeyType[1]
		v17 = cubRescueDioramaLevels[1]
	else
		v15 = cubCageType[2]
		v16 = cageKeyType[2]
		v17 = cubRescueDioramaLevels[2]
	end

	module.TaggedFirePorts(Symbol("CampfireRavineEntrance"), "Disable")
	module.TaggedFirePorts(Symbol("OrengallBrokenPatrolCart"), "Show")
	module.TaggedFirePorts(Symbol("OrengallPatrolCartRepairPoi"), "Enable")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallPupRescuePatrol"))
	local position = __wf_atom_0a6a5887:GetPosition()
	local combatBlockingContainer = module6.SpawnCombatBlockingContainer(
		randomCombatBlockingContainerType,
		__wf_atom_0a6a5887:GetPosition()
	)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("OdeSiegeEngine"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		100
	)
	module.DestroyObjectList(__wf_atom_439c0d29, true)
	__wf_atom_0a6a5887:Enable()
	__wf_atom_0a6a5887:__wf_atom_7dd025d4(fn11, v14)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("OrengallPupCageSpawn"), position, 0, 50)
	local entity = gRegion:CreateEntity(v15, __wf_atom_f738b4af:GetPosition(), __wf_atom_f738b4af:__wf_atom_dc309f8a())
	__wf_atom_f738b4af:FirePort("Disable")
	module7.AddQuestDestination(entity, mOwner, p, Range(1, 3.4028234663852886e38), true)

	if not fn12(entity, __wf_atom_0a6a5887, 1) then
		fn8("Pup rescue dungeon streaming, waiting for rescue") -- inferred equivalent call
		return
	end

	if not fn9(entity, true) then
		fn8("Pup rescue dungeon streaming, diorama") -- inferred equivalent call
		return
	end

	fn3()
	_T.NumCubsRescued = fn2(true)
	local v24 = module5.GetQuestTaskLoc(mOwner, p) or ""
	module5.UpdateOrAddHudTask(mOwner, "OrengallPuppyRescue", v24)

	if not __wf_atom_7e8ad928(combatBlockingContainer) then
		combatBlockingContainer:Destroy()
	end

	print("Midrath pup rescued, task complete")
	module2.CompleteTaskWithID(mOwner, p)
end

function RescueCubDungeon(p)
	if not gRegion:IsMaster() then
		return
	end

	module.WaitForLevel()
	module.WaitForLoginSequence()
	v9 = module.WaitForAiDir()
	local v24 = Symbol("UndercityPortalMine")
	v18 = p
	local v25 = fn2()

	if module.IsInOverworld() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("UC-Mines-Mill"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			module6.SetMissionEncounterAllowed(__wf_atom_0a6a5887, false)
		end

		print("Pup rescue stage (in overworld)")
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v24)
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("MineEntranceMarkerWp"))
		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("MinesCamp"))
		local position = __wf_atom_0a6a5887_3:GetPosition()
		module.SetQuestProcLevel(v24, WeakResource("/SF/Levels/Procs/Quest/OrengallPupRescueUCMill"))
		v19 = module2.CreateAreaMarker(__wf_atom_0a6a5887_3, 50, __wf_atom_28d5d4aa, mOwner, p)
		__wf_atom_0a6a5887_4:__wf_atom_71694ad6(0)
		__wf_atom_0a6a5887_4:__wf_atom_252fae6e(13)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2 = gRegion:__wf_atom_f738b4af(
				Symbol("StreamingDungeonEntranceWp"),
				__wf_atom_0a6a5887_2:GetPosition(),
				0,
				30
			)
		end

		module7.AddQuestDestination(__wf_atom_0a6a5887_2, mOwner, p, Range(0, 3.4028234663852886e38), true)
		local v26

		if v25 == 0 then
			v26 = wolfHowlBSequencers
		else
			v26 = wolfHowlSequencers
		end

		for _, v27 in ipairs(v26) do
			gRegion:CreateEntity(v27, __wf_atom_0a6a5887_3:GetPosition() + Vector(0, 1, 0), __wf_atom_80368bb1)
		end

		while not module.AnyPlayerNearPos(position, 6) do
			Sleep(0.5)
		end

		if not __wf_atom_7e8ad928(v19) then
			v19:Teleport(__wf_atom_0a6a5887_2:GetPosition(), __wf_atom_80368bb1)
		end
	elseif module12.GetCurrentLocation() == tostring(v24) then
		print("Pup rescue stage (in undercity)")

		if v25 <= 1 then
			_T.NumCubsRescued = 0
			v15 = cubCageType[1]
			v16 = cageKeyType[1]
			v17 = cubRescueDioramaLevels[1]
		else
			v15 = cubCageType[2]
			v16 = cageKeyType[2]
			v17 = cubRescueDioramaLevels[2]
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallCageGuardsHint"))
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallPupCageSpawn"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			print("Can't find spawn for cub cage. Incorrect proc tiles loaded. Likely overriden by something, like a Tale.")
			return
		end

		local entity = gRegion:CreateEntity(
			v15,
			__wf_atom_0a6a5887_2:GetPosition(),
			__wf_atom_0a6a5887_2:__wf_atom_dc309f8a()
		)
		v20 = gRegion:__wf_atom_c4f78a8f()
		v21 = v20:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if gRegion:IsMaster() then
			v22 = gRegion:CreateObject(Type("/SF/Types/Quests/OmenBeastQuests/OrengallQuestAssets/DungeonWolfSummonAbilityMod"))
			v21:AddUpgrade(v22)
		end

		module12.SetCurrentLocationQuest(mOwner, p)
		module.TaggedFirePorts(Symbol("OrengallQuestCryptSetup"), "TriggerPort")
		module.TaggedFirePorts(Symbol("FloodInOrengallDungeon"), "Execute")
		module.TaggedFirePorts(Symbol("UCCubHowlBreadcrumb"), "Enable")
		__wf_atom_0a6a5887:Enable()
		__wf_atom_0a6a5887:__wf_atom_7dd025d4(fn11, v14)
		__wf_atom_0a6a5887_2:FirePort("Disable")
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("BridgeTileWaterPuzzleLootChestSpawn"))

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or __wf_atom_7e8ad928(lootChestType)) then
			gRegion:CreateEntity(
				lootChestType,
				__wf_atom_0a6a5887_3:GetPosition(),
				__wf_atom_0a6a5887_3:__wf_atom_dc309f8a()
			)
		end

		local all = gRegion:FindAll(WeakResource("/SF/Types/Game/Encounters/Ode/Hints/InteriorCombatEncounterHint"))

		for _, v26 in ipairs(all) do
			v26:__wf_atom_252fae6e(13)
		end

		__wf_atom_0a6a5887:__wf_atom_252fae6e(14)
		module7.AddQuestDestination(entity, mOwner, p, Range(1, 3.4028234663852886e38), true)

		if fn12(entity, __wf_atom_0a6a5887, 0) then
			module7.RemoveSparrowDestination(nil, "CubRescue")

			if not fn9(entity, false) then
				fn8("Pup rescue dungeon streaming, diorama") -- inferred equivalent call
				return
			end

			if gRegion:IsMaster() and not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(v22)) then
				v21:RemoveUpgrade(v22, true)
			end

			local v26 = module.FindTaggedInTileType(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))[1]
			module7.AddQuestDestination(v26, mOwner, p)
			_T.NumCubsRescued = fn2(true)
			local v27 = module5.GetQuestTaskLoc(mOwner, p) or ""
			module5.UpdateOrAddHudTask(mOwner, "OrengallPuppyRescue", v27)
			print("Pup rescue UC dungeon stage done")
			module2.CompleteTaskWithID(mOwner, p)
		else
			fn8("Pup rescue dungeon streaming, waiting for rescue") -- inferred equivalent call

			if gRegion:IsMaster() and not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(v22)) then
				v21:RemoveUpgrade(v22, true)
			end
		end
	end
end

function ShowBossBarInCine()
	v2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallBossAvatar"))
	_T.SetForceShowHUD(true)
	_T.SetupBossAvatar(v2)
end

function RevivePlayers()
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v24 in ipairs(__wf_atom_3c8e1a7a) do
		local playerAvatar = v24:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:IsKilled() then
			continue
		end

		print("Reviving player for start of Styne intro cutscene")
		gGameRules:RespawnPlayer(v24, false)
		local playerAvatar2 = v24:GetPlayerAvatar(10)

		if not __wf_atom_7e8ad928(playerAvatar2) then
			playerAvatar2:Destroy()
			v24:__wf_atom_6c552f4c(10, nil)
		end

		if _T.EnabledShrine == nil then
			continue
		end

		local v25 = _T.EnabledShrine[v24:__wf_atom_ef151cfd()]

		if not __wf_atom_7e8ad928(v25) then
			v25:Destroy()
		end
	end
end

function TogglePlayerInvulnerability(p)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v24 in ipairs(__wf_atom_ef7900cf) do
		if v24:IsKilled() then
			continue
		end

		if p then
			v24:__wf_atom_7470861b():__wf_atom_c286b5da(v4, 10000000)
		else
			v24:__wf_atom_7470861b():__wf_atom_ad99acf2(v4)
		end
	end
end

function BossDeath()
	TogglePlayerInvulnerability(false)
	_T.OrengallAttackDoneAvatar = nil
	local v24 = Resource("/SF/Animations/Wildlife/Wolf/Howl_anim.fbx")
	local v25 = Resource("/SF/Animations/Wildlife/Wolf/Idle05_anim.fbx")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorCinTaleLeaving"))
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()
	local v26 = nil
	local v27 = nil

	for _, v28 in ipairs(__wf_atom_a8553251) do
		if not v28:IsKilled() then
			v26 = v28
		end
	end

	if not gRegion:IsMaster() then
		return
	end

	v2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallBossAvatar"))
	v2:__wf_atom_30e3d82b():__wf_atom_f8fa00b4(v26, __wf_atom_28d5d4aa)
	v2:__wf_atom_7470861b():__wf_atom_77fc7548(v2:GetMaxHealth() * 0.01)
	Sleep(1.5)

	if not __wf_atom_7e8ad928(v2) then
		v2:__wf_atom_7470861b():__wf_atom_e1faa796(false)
		v2:__wf_atom_7470861b():__wf_atom_b6bcaf97(false)
		Sleep(0)
		v2:Attach(
			Resource("/SF/Types/Quests/OmenBeastQuests/OrengallQuestAssets/OrengallKillAttachedTrigger"),
			Symbol("GAME_C1_SPINE1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	_T.SetForceShowHUD(false)

	while not __wf_atom_7e8ad928(v2) and not v2:IsKilled() and __wf_atom_7e8ad928(v27) do
		Sleep(0)
	end

	_T.SetupBossAvatar(nil)
	__wf_atom_0a6a5887:SetVisibility(true)
	__wf_atom_0a6a5887_2:FirePort("StartPlaying")
	module9.EnableNearestTaggedSequencer(Symbol("SFXCubHowlStingerFromShip"), true, __wf_atom_0a6a5887:GetPosition())
	local v28

	if __wf_atom_7e8ad928(v26) then
		v28 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallAvatar"))
	else
		v28 = gRegion:FindNearestTagged(Symbol("OrengallAvatar"), v26:GetPosition())
	end

	if __wf_atom_7e8ad928(v28) then
		return
	end

	while __wf_atom_7e8ad928(_T.OrengallAttackDoneAvatar) do
		Sleep(0)
	end

	v28:__wf_atom_921c1a5f(v24, false, 4, 1)
	Sleep(1.25)
	v28:Teleport((module10.GetGroundPos(v28:GetPosition())))
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("OrengalSiegeFire"))

	for _, v29 in ipairs(__wf_atom_2226b35c) do
		if not __wf_atom_7e8ad928(v29) then
			v29:PlayTriggeredFade()
		end
	end

	Sleep(6)
	module9.EnableNearestTaggedSequencer(Symbol("SFXCubHowlStingerFromShipB"), true, __wf_atom_0a6a5887:GetPosition())
	Sleep(0.5)
	v28:__wf_atom_30e3d82b():__wf_atom_f8fa00b4(__wf_atom_0a6a5887, __wf_atom_28d5d4aa)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("OrengallWaitPos"), v28:GetPosition())
	v28:Attach(orengallPettingCin, EMPTY_SYMBOL)
	v28:__wf_atom_e5d015a7(Symbol("Orengal"))
	v28:__wf_atom_30e3d82b():MoveTo(nearestTagged, false, true, false)
	Sleep(4)
	v28:__wf_atom_30e3d82b():__wf_atom_f8fa00b4(v26, __wf_atom_28d5d4aa)
	v28:__wf_atom_921c1a5f(Resource("/SF/Animations/Wildlife/Wolf/HeadDown_anim.fbx"), true, 4, 3, false)
	v28:__wf_atom_921c1a5f(v25, false, 4, 2, false)
	__wf_atom_0a6a5887:SetVisibility(false)

	if not __wf_atom_7e8ad928(v28) then
		v28:Attach(orengallPettingCTX, Symbol("GAME_C1_HEAD"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	_T.OrengallAttackDoneAvatar = nil
end

local function fn13(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 1 then
		return
	end

	if __wf_atom_4026dfb5 == 2 then
		print("Encounter Is active")
	elseif __wf_atom_4026dfb5 == 4 then
		module9.EnableTaggedSoundSysVolumes(Symbol("MusicOrengallBossFight"), false)
		module9.EnableTaggedSequencers(Symbol("SFXWolfCubCDistant"), false)
		module5.CompleteHudTask(mOwner, nil, v13)
		module4.CloseTransmissions()
		module.PlayCinematicWithTagAndWait(Symbol("ExitTankCine"))
		object:Disable()
	elseif __wf_atom_4026dfb5 == 6 then
	end
end

function RescueTheFinalCub(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengalBossCampEnc"))
	module6.SpawnCombatBlockingContainer(randomCombatBlockingContainerType, __wf_atom_0a6a5887:GetPosition())
	module5.RemoveHudTask(mOwner, nil, "OrengallPuppyRescue")
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("PollutionTowerAirdelands"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Disable()
		module6.SetMissionEncounterAllowed(__wf_atom_0a6a5887_2, false)
	end

	module6.SetMissionEncounterAllowedOnTagged(Symbol("NorthGate"), false)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("ShipPostion"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		400
	)

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or __wf_atom_7e8ad928(__wf_atom_f738b4af)) then
		local position = __wf_atom_f738b4af:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_f738b4af:__wf_atom_dc309f8a()
		gRegion:__wf_atom_0a6a5887(Symbol("CollectorCinTaleLeaving")):Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_0a6a5887_3:Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_0a6a5887_3:SetVisibility(true)
	end

	local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("OrengalBossCampSetUp"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_4) then
		__wf_atom_0a6a5887_4:FirePort("TriggerPort")
	end

	__wf_atom_0a6a5887:__wf_atom_7dd025d4(fn13, v14)
	__wf_atom_0a6a5887:__wf_atom_8e6fec76(1)
	v13 = p
	module9.EnableTaggedSequencers(Symbol("SFXWolfCubCDistant"), true)
	module9.EnableTaggedSequencers(Symbol("SFXWolfCubCStinger"), true)

	if not _G.PlayedOrengallRescueDialog then
		module4.PlayGlobalTransmission(questTransmissionSet, Symbol("FinalPupStageStart"), true)
		_G.PlayedOrengallRescueDialog = true
	end

	local questTaskLoc = module5.GetQuestTaskLoc(mOwner, p)
	module5.UpdateOrAddHudTask(mOwner, "OrengallPuppyRescue", questTaskLoc)
	fn(p, __wf_atom_0a6a5887, 60)
	_T.NumCubsRescued = 2
	fn3()
end

function BondWithOrengall(object, object2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PollutionTowerAirdelands"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
		module6.SetMissionEncounterAllowed(__wf_atom_0a6a5887, true)
	end

	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_c9fc989f)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	local v24 = Symbol("Orengal")
	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("whateveridyouwant"), 26, 6, 0)

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Unequip(0, 0)

		while not __wf_atom_7e8ad928(object2) and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_bb3e7833:__wf_atom_a3d2b66b(object2, Symbol("Envoy"))
		__wf_atom_bb3e7833:__wf_atom_a3d2b66b(__wf_atom_3d96ddcd, v24)
		__wf_atom_bb3e7833:StartRelative(
			Symbol("Envoy"),
			__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
			__wf_atom_3d96ddcd:__wf_atom_dc309f8a()
		)
	end

	while not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(-1)
	__wf_atom_3d96ddcd:SetVisibility(false)

	if LoadCubChoice(v8, nil, 1, 1) and not __wf_atom_7e8ad928(object2) then
		_T.StoryLib_SkipFadeOnExit = true
		_T.StoryLib_SkipClearFade = true
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(-1)
		_T.EndCardId = 2
		_T.AutoCloseEndCard = true
		v17 = v5
		object2:__wf_atom_8a035cd5(Symbol("ShowDiorama"), false)

		while __wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8()) do
			Sleep(0)
		end

		while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(object2) then
			while __wf_atom_8e4fda44:__wf_atom_6b69b901(WeakResource("/SF/Interface/EndCard.swf")) do
				Sleep(0)
			end

			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
			v17 = v6
			object2:__wf_atom_8a035cd5(Symbol("ShowDiorama"), false)

			while
				__wf_atom_7e8ad928(__wf_atom_392793db)
				or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())
			do
				Sleep(0)
			end

			while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(object2) then
				local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengalBossCampEnc"))

				if __wf_atom_7e8ad928(v19) then
					if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
						module2.DestroyAreaMarker(__wf_atom_0a6a5887_2)
					end
				else
					v19:Destroy()
				end

				__wf_atom_7470861b:__wf_atom_63396172(Symbol("whateveridyouwant"))

				if not gRegion:IsMaster() then
					return
				end

				print("Orengal Quest: Stage 4 done")

				if __wf_atom_7e8ad928(v9) then
					v9 = module.WaitForAiDir()
				end

				v9:__wf_atom_25131806(v12)
				__wf_atom_3d96ddcd:Destroy()
				module2.CompleteTaskWithTag(Resource(v11), Symbol("RescueTheFinalCub"))
				return
			end
		end
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	__wf_atom_3d96ddcd:SetVisibility(true)
	object:Enable()
end

function WaitForPupIntro(p)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	gRegion:__wf_atom_c4f78a8f():__wf_atom_e25a34ac(true)

	while not module.HasStreamedLevel("/SF/Levels/Tent") do
		Sleep(1)
	end

	module11.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())

	if module2.IsPersonalQuestTaskInProgress(v11, p) then
		_T.ReadyForPupLoreInOrengallQuest = true
	end

	module.TaggedFirePorts(Symbol("OrengallQuest-GrantPupTrainingLore"), "Execute")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallQuest-PlayerReceivesPup"))

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	if gRegion:IsMaster() then
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function SpawnSecret(p)
	if not module2.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(secretSpawnTag)
	local v24

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v24 = gRegion:CreateEntity(
			secretSpawnType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		local __wf_atom_bb3e7833 = v24:__wf_atom_bb3e7833(__wf_atom_0f45538d)

		while
			not __wf_atom_7e8ad928(v24)
			and not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
			and __wf_atom_bb3e7833:IsEnabled()
		do
			Sleep(0.2)
		end
	end

	if not __wf_atom_7e8ad928(v24) then
		module2.CompleteTaskWithID(mOwner, p)
	end
end

function PrepaireOrengalVisionCine(object)
	_T.orengallVisionCinObjects = {}
	_T.orengallVisionCinObjectPositions = {}
	_T.orengallVisionCinObjectRotations = {}
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ChainedOrengallComponent"))

	for i, v24 in ipairs(__wf_atom_2226b35c) do
		if __wf_atom_7e8ad928(v24) then
			continue
		end

		_T.orengallVisionCinObjects[i] = v24
		_T.orengallVisionCinObjectPositions[i] = v24:GetPosition()
		_T.orengallVisionCinObjectRotations[i] = v24:__wf_atom_dc309f8a()
	end

	if gRegion:IsMaster() then
		for _, v24 in ipairs(agentEntitities) do
			gRegion:CreateEntity(
				v24,
				Vector(object:GetPosition().x, object:GetPosition().y + 9, object:GetPosition().z),
				object:__wf_atom_dc309f8a(),
				object
			)
		end

		object:ReinitializeGreenRoom()
		object:PlaceGreenRoomEntities()
	end
end

function TeardownOrengalVisionCine(object)
	for i, orengallVisionCinObject in ipairs(_T.orengallVisionCinObjects) do
		if __wf_atom_7e8ad928(orengallVisionCinObject) then
			continue
		end

		orengallVisionCinObject:__wf_atom_f4133158()
		orengallVisionCinObject:Teleport(_T.orengallVisionCinObjectPositions[i], _T.orengallVisionCinObjectRotations[i])
	end

	local __wf_atom_59c6b81d = object:__wf_atom_59c6b81d()

	for _, v24 in ipairs(__wf_atom_59c6b81d) do
		if __wf_atom_7e8ad928(v24) or not v24:IsA(__wf_atom_4ebf67cb) then
			continue
		end

		v24:Destroy()
	end
end

function PrepairCubChoiceCinematic(object)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local v24 = not __wf_atom_7e8ad928(__wf_atom_eab484a7:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0).mItemType)

	if not (gRegion:IsMaster() or _T.CubChoiceTaskInProgressLocal or v24) then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for _, v25 in ipairs(__wf_atom_3c8e1a7a) do
			if v25:__wf_atom_3c213d6b() then
				__wf_atom_eab484a7 = v25
			end
		end
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	while __wf_atom_7e8ad928(playerAvatar) do
		Sleep(0.2)
		playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
	end

	if __wf_atom_7e8ad928(playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()) then
		print("Null ActivePowerSuit")
		return
	end

	local v25, v26, v27

	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AvatarProxySpawn"))
		v25 = gRegion:CreateEntity(
			envoyAvatarType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		v26 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		v27 = gRegion:CreateObject(v26, v25)
	else
		local __wf_atom_0a6a5887 = __wf_atom_392793db:__wf_atom_0a6a5887(Symbol("AvatarProxySpawn"))
		v25 = __wf_atom_392793db:CreateEntity(
			envoyAvatarType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a()
		)
		v26 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		v27 = __wf_atom_392793db:CreateObject(v26, v25)
	end

	if __wf_atom_7e8ad928(v27) then
		print("Null suit")
		return
	end

	local __wf_atom_d2b2176d = v25:__wf_atom_d2b2176d()
	v25:__wf_atom_72cd7949((playerAvatar:__wf_atom_f115b657()))
	__wf_atom_d2b2176d:GiveItem(v27, true)
	v27:SetCustomization((v26:__wf_atom_eb82ab1f()))
	__wf_atom_d2b2176d:Update(0)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	v25:__wf_atom_e5d015a7(Symbol("Envoy"))
	object:__wf_atom_a3d2b66b(v25, Symbol("Envoy"))
	object:ReinitializeGreenRoom()
	object:PlaceGreenRoomEntities()
end

function PrepairOrengallCubEndCinematic(_)
	if not __wf_atom_7e8ad928(_T.SelectedPupDeco) then
		_T.SelectedPupDeco:__wf_atom_e5d015a7(Symbol("Wolf"))
	end
end

function TeardownPlayerReceivesPup(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_e25a34ac(false)
	end
end

function TeardownBanneretIntroCine(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallTank"))

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_ec1735df()
	end
end

function PrepairBanneretIntroCine(object)
	if gRegion:IsMaster() then
		RevivePlayers()
		TogglePlayerInvulnerability(true)
	end

	module11.ClearTransmissionQueue()
	module11.InterruptTransmission()

	if __wf_atom_7e8ad928(bossAgentType) or not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(v9) then
		v9 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(bossSpawnPointTag)
	v3 = v9:CreateAgent(bossAgentType, __wf_atom_0a6a5887, Symbol("RandomTeam"), 20)

	if __wf_atom_7e8ad928(v3) then
		return
	end

	v2 = v3:__wf_atom_50a7d83e()
	v2:__wf_atom_b811702e(Symbol("OrengallBossAvatar"))
	v2:SetBlackboardBool(Symbol("WaitForCombat"), true)
	v2:__wf_atom_7470861b():__wf_atom_b6bcaf97(true)
	local __wf_atom_9fb9a1d6 = v2:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_e5d015a7(Symbol("StyneWeapon"))
		end
	end

	v2:__wf_atom_7c8621d6()
	v2:__wf_atom_17e77e5b(Localize(bossName, nil))
	v2:__wf_atom_5cb037b2(Symbol(bossName))
	v3:__wf_atom_30b587a4()
	v2:Attach(
		Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
		Symbol("GAME_C1_SPINE1"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1
	):__wf_atom_b811702e(Symbol("BossBarTrigger"))
	object:ReinitializeGreenRoom()
	object:PlaceGreenRoomEntities()
end

function PrepareOrengallPettingCin(_)
	gRegion:__wf_atom_c4f78a8f():__wf_atom_e25a34ac(true)
end

function triggerTransmissions(object)
	if module2.QuestIsActive(Resource(v11)) == false then
		module4.PlayGlobalTransmission(questTransmissionSet, questTransmissionTag, true)

		while module4.TransmissionPlaying() do
			Sleep(0)
		end

		object:Disable()
	end
end

function EquipWeapon()
	if gRegion:IsMaster() then
		v2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallBossAvatar"))
		v2:__wf_atom_d2b2176d():Equip(5, 0, 2)
	end
end

function PreQuestSetup()
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if not gRegion:IsMaster() then
		return
	end

	local v24 = WeakResource("/SF/Types/Quests/OmenBeastQuests/TheOmenOrengall")

	if module2.HasCompletedQuest(v24) and not module2.QuestIsActive(v24) then
		if __wf_atom_7e8ad928(v9) then
			v9 = module.WaitForAiDir()
		end

		v9:__wf_atom_25131806(v12)
	else
		if module2.QuestIsActive(v24) then
			return
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("OrengallNoteSpawn"))

		if __wf_atom_7e8ad928(__wf_atom_2226b35c) or not (#__wf_atom_2226b35c > 0) then
			print("ERROR: No note spawnpoints found for Orengall quest note!")
		else
			for i = 1, #__wf_atom_2226b35c do
				local v25 = __wf_atom_2226b35c[i]
				gRegion:CreateEntity(noteType, v25:GetPosition(), v25:__wf_atom_dc309f8a())
			end
		end

		module9.EnableTaggedSoundSysVolumes(Symbol("SFXWolfCubLandscapeHowl"), true)
	end
end

function GrantPupTrainingLore(_, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	if not (module2.HasPersonalCompletedQuest(v11) or module2.QuestIsActive(v11, true)) then
		module.Fade(false)
		return
	end

	if module2.QuestIsActive(v11, true) and not _T.ReadyForPupLoreInOrengallQuest then
		module.Fade(false)
		return
	end

	local __wf_atom_22020464 = loreFragment:__wf_atom_22020464()
	local v24 = {}

	for _, v25 in ipairs(__wf_atom_22020464) do
		if not module.HasSpecificLoreMemoryUnlocked(__wf_atom_c4f78a8f, loreFragment, v25) then
			table.insert(v24, v25)
		end
	end

	if #v24 == 0 and not module2.QuestIsActive(v11) then
		return
	end

	local v25 = #v24 == 1 and v24[1] == v

	if not (module2.QuestIsActive(v11, true) or v25) then
		if not module.IsInNightFold(__wf_atom_c4f78a8f) then
			_T.SkipNightfoldTransition = 1
		end

		while not module.IsInNightFold(__wf_atom_c4f78a8f) do
			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				return
			else
				Sleep(0)
			end
		end

		__wf_atom_c4f78a8f:__wf_atom_e25a34ac(true)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallQuest-WakeUpTp"))
		__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
		__wf_atom_c4f78a8f:__wf_atom_51075230(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("OrengallQuest-PlayerReceivesPup"))
		__wf_atom_0a6a5887_2:SetInstigatorAvatar(__wf_atom_c4f78a8f)

		while not _T.NightFoldPupCreated do
			Sleep(0)
		end

		module.PlayCinematicAndWait(__wf_atom_0a6a5887_2, false)
	end

	if module2.QuestIsActive(v11, true) then
		module2.WakeUpInNightFold(
			5,
			nil,
			nil,
			true,
			{ Label = "/SF/Language/Quests/OrengallQuestCompletedProgression", CacheIndex = 1 },
			nil,
			true,
			Symbol("OrengallQuest-PlayerReceivesPup")
		)
	end

	local flag = false

	for _, v26 in ipairs(v24) do
		if v26 == v then
			continue
		end

		module.GiveLoreFragmentMemory(__wf_atom_c4f78a8f, loreFragment, v26, true)
		flag = true
	end

	if flag then
		__wf_atom_c4f78a8f:Attach(
			Type(tutorialTrigger),
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_c4f78a8f,
			1
		)
	end

	_T.ReadyForPupLoreInOrengallQuest = nil

	if module.HasSpecificLoreMemoryUnlocked(__wf_atom_c4f78a8f, loreFragment, v) then
		return
	end

	while module.IsInNightFold(__wf_atom_c4f78a8f) do
		Sleep(2)
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local playerAvatar = nil

	while __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() or not playerAvatar:__wf_atom_8efce136() do
		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
			module3.WaitForWeaponEquip(stickWeaponWeakRes)
		end

		Sleep(3)
	end

	module.GiveLoreFragmentMemory(playerAvatar, loreFragment, v, true)
	playerAvatar:Attach(
		Type(fetchStickTutorialTrigger),
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		playerAvatar,
		1
	)
end

function PreparePupIntroCin(object)
	object:__wf_atom_a3d2b66b(gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_1915cc84(), Symbol("WolfCub"))
end

function LoadCubChoice(p, p2, value, value2)
	local v24 = value or 0
	local v25 = value2 or 0
	local module13 = require("Lotus.Interface.UIStyleUtilities")
	local module14 = require("Lotus.Interface.Libs.DioramaLoader")
	local module15 = require("EE.Interface.Utilities")
	local v26 = nil
	local v27 = Resource("/SF/Interface/QuestScreens/PupSelection.swf")
	local currentBackgroundInfo = module13.GetCurrentBackgroundInfo()

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	local movie = __wf_atom_8e4fda44:FindMovie(module15.GetChatMovie())
	local v28 = not __wf_atom_7e8ad928(movie) and movie:IsVisible()
	local v29 = nil

	if __wf_atom_7e8ad928(v29) and not __wf_atom_7e8ad928(v11) then
		local activeQuests = module2.GetActiveQuests()
		local v30 = nil

		for _, activeQuest in ipairs(activeQuests) do
			if not activeQuest:IsA(v11) then
				continue
			end

			v30 = activeQuest
			break
		end

		if __wf_atom_7e8ad928(v30) then
			print("Orengal Quest is not active...can only show the pup selection during the quest.")
			return false
		else
			v29 = v30:__wf_atom_f9a6a9ad(Symbol("RescueTheFinalCub")):__wf_atom_cb9e9bb0()
		end
	end

	_T.CubChoiceTaskInProgressLocal = module2.IsPersonalQuestTaskInProgress(v11, v29)
	module11.RegisterHideSquadOverlay(true)
	local v30 = {
		WeakResource("/Lotus/Interface/ChatRedux.swf"),
		WeakResource("/Lotus/Interface/Notifications.swf"),
		WeakResource("/SF/Interface/GenericNotification.swf")
	}

	for _, v31 in ipairs(v30) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v31)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(false)
		end
	end

	if _T.StoryLib_MoviesToAlpha ~= nil then
		for _, v31 in ipairs(_T.StoryLib_MoviesToAlpha) do
			local movie2 = __wf_atom_8e4fda44:FindMovie(v31)

			if not __wf_atom_7e8ad928(movie2) then
				movie2:__wf_atom_e57658c2("_root", 12, 0)
			end
		end
	end

	__wf_atom_8e4fda44:__wf_atom_06b56505(0)

	if not __wf_atom_7e8ad928(p2) then
		gRegion:__wf_atom_c4f78a8f():__wf_atom_aeb02c14(p2)
	end

	_T.BlockAmbientTransmissions = true

	if __wf_atom_7e8ad928(p) then
		return false
	end

	local dioramaLoader = module14.CreateDioramaLoader(_T.BackgroundMovie)
	dioramaLoader:LoadDiorama(p)

	if dioramaLoader:IsLoading() then
		if v24 ~= 0 then
			dioramaLoader:SetFadeParams(v24, 0, v25)
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(v24)
		end

		while not dioramaLoader:LoadingComplete() do
			Sleep(0)
		end

		dioramaLoader:FinishLoad()

		if __wf_atom_7e8ad928(v26) and not __wf_atom_7e8ad928(v27) then
			v26 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v27)
			v26:__wf_atom_f62a8704("SetupPupSelection", { v11:__wf_atom_5b41f63b(), (tostring(v29)) })
		end

		if gRegion:IsMaster() then
		end

		while not __wf_atom_7e8ad928(v26) do
			Sleep(1)

			if not __wf_atom_7e8ad928(movie) then
				movie:SetVisible(false)
			end

			if not _T.StoryLib_BlockTransmissions or __wf_atom_7e8ad928(_T.curTransmission) then
				continue
			end

			module11.ClearTransmissionQueue()
			module11.InterruptTransmission()
		end

		while not module2.AllPlayersReady(v11, v29) do
			Sleep(0)
		end

		while not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) do
			Sleep(0)
		end

		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	__wf_atom_8e4fda44:__wf_atom_06b56505(1)

	for _, v31 in ipairs(v30) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v31)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(true)
		end
	end

	module11.RegisterHideSquadOverlay(false)

	if not __wf_atom_7e8ad928(movie) then
		movie:SetVisible(v28)
	end

	if not __wf_atom_7e8ad928(p2) then
		gRegion:__wf_atom_c4f78a8f():__wf_atom_cf966a74(p2)
	end

	if currentBackgroundInfo.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(
			0,
			currentBackgroundInfo.HighlightOffset,
			currentBackgroundInfo.HighlightOn,
			currentBackgroundInfo.VisRangeInfo
		)
	end

	_T.StoryLib_BlockTransmissions = nil
	_T.StoryLib_PlayingCin = false
	return true
end