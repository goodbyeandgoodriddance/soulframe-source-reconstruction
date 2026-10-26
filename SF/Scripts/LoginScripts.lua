local v = WeakResource("/SF/Interface/BodySelection.swf")
local v2 = WeakResource("/SF/Interface/MotherSelection.swf")
local v3 = WeakResource("/SF/Interface/QuestScreens/FactionChoice.swf")
local v4 = { Symbol("CharacterSelectCin"), Symbol("CharacterSelectFollowUpCin"), Symbol("BeachCinematic") }
local v5 = Symbol("FirstLoginArsenalWp")
local v6 = Resource("/SF/Types/Input/BlockAllInputFilter")
local v7 = WeakResource("/SF/Types/Quests/WarsongPrologueQuest")
local v8 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.NightFoldLib")
local module3 = require("SF.Scripts.FirstLoginUtils")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.SFCinematics")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("SF.Scripts.Libs.StatsLib")
local module8 = require("SF.Scripts.Libs.TransmissionSet")
local module9 = require("SF.Scripts.Libs.SparrowLib")
local module10 = require("SF.Scripts.Libs.ModifySkyLib")
local v9 = Resource("/SF/Sounds/Dialog/TransmissionSets/EmpressWispersTransmissionSet")
local v10 = Symbol("LogInWakeUp")
local v11 = false
local v12 = 20

local function fn(object, p) -- 2 equivalent calls inferred from this helper
	local __wf_atom_cdcc10f5 = object:__wf_atom_cdcc10f5(p, 0)

	if #__wf_atom_cdcc10f5 > 0 then
		return __wf_atom_cdcc10f5[1]
	end

	return nil
end

function SetupBodyDecos()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("EnvoyDecoMale"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("EnvoyDecoFemale"))
	__wf_atom_0a6a5887_2:SetVisibility(false)
	local __wf_atom_3a61ed37 = gGameData:GetInventory():__wf_atom_3a61ed37()

	if __wf_atom_3a61ed37 then
		local __wf_atom_035fdfa8 = __wf_atom_3a61ed37:__wf_atom_035fdfa8(0)
		local v13 = WeakResource("/SF/Characters/PlayerCharacters/Hair/ArtStationTest/Cloth/MiddleHairBClothDeco")
		local v14 = WeakResource("/SF/Characters/PlayerCharacters/Hair/Hair1A/Cloth/Hair1ACloth")
		local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(v13)
		local __wf_atom_bb3e7833_2 = __wf_atom_0a6a5887_2:__wf_atom_bb3e7833(v14)
		local color = __wf_atom_3a61ed37:GetColor(0, 0)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			local v15 = Type(module3.GetEnvoyHairForMotherHair(__wf_atom_035fdfa8))
			local v16 = Type((module3.GetEnvoyHeadSkinForMotherTone(color)))
			local v17 = fn(v15, 1) -- inferred equivalent call
			local v18 = fn(v15, 0) -- inferred equivalent call

			if v17.mType ~= v13 then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end

				__wf_atom_bb3e7833 = __wf_atom_0a6a5887:Attach(
					Type(v17.mType),
					v17.mBoneName,
					v17:__wf_atom_1118f075(),
					v17:__wf_atom_01934aa5(),
					__wf_atom_0a6a5887
				)
			end

			if v18.mType ~= v14 then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					__wf_atom_bb3e7833_2:Destroy()
				end

				__wf_atom_bb3e7833_2 = __wf_atom_0a6a5887_2:Attach(
					Type(v18.mType),
					v18.mBoneName,
					v18:__wf_atom_1118f075(),
					v18:__wf_atom_01934aa5(),
					__wf_atom_0a6a5887_2
				)
			end

			local __wf_atom_d24efbb2 = v16:__wf_atom_c4774ee9(1, 0):__wf_atom_d24efbb2()
			local __wf_atom_d24efbb2_2 = v16:__wf_atom_c4774ee9(0, 0):__wf_atom_d24efbb2()

			if __wf_atom_d24efbb2 ~= __wf_atom_0a6a5887:__wf_atom_b6b760b5() then
				__wf_atom_0a6a5887:__wf_atom_45cf0e1a(__wf_atom_d24efbb2, false, false)
			end

			if __wf_atom_d24efbb2_2 ~= __wf_atom_0a6a5887_2:__wf_atom_b6b760b5() then
				__wf_atom_0a6a5887_2:__wf_atom_45cf0e1a(__wf_atom_d24efbb2_2, false, false)
			end
		end

		local weaponCustomization = SF.WeaponCustomization()
		weaponCustomization:SetColor(0, 0, color)
		weaponCustomization:__wf_atom_59cc106e(0, 0, true)
		local __wf_atom_bb3e7833_3 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(WeakResource("/SF/Characters/PlayerCharacters/ForgetFire/ForgetFireNakedBodyDeco"))
		local __wf_atom_bb3e7833_4 = __wf_atom_bb3e7833_3:__wf_atom_bb3e7833(WeakResource("/SF/Characters/PlayerCharacters/Template/MaleLowerBodyDeco"))
		__wf_atom_3a61ed37:ApplyCustomization(__wf_atom_0a6a5887, {}, false, 0)
		__wf_atom_3a61ed37:ApplyCustomization(__wf_atom_bb3e7833, {}, true, 1)
		weaponCustomization:ApplyCustomization(__wf_atom_bb3e7833_3, {}, false, 0)
		weaponCustomization:ApplyCustomization(__wf_atom_bb3e7833_4, {}, false, 0)
		local __wf_atom_bb3e7833_5 = __wf_atom_0a6a5887_2:__wf_atom_bb3e7833(WeakResource("/SF/Characters/PlayerCharacters/ForgetFire/ForgetFireNakedBodyFemaleDeco"))
		local __wf_atom_bb3e7833_6 = __wf_atom_bb3e7833_5:__wf_atom_bb3e7833(WeakResource("/SF/Characters/PlayerCharacters/Template/FemaleLowerBodyDeco"))
		__wf_atom_3a61ed37:ApplyCustomization(__wf_atom_0a6a5887_2, {}, false, 0)
		__wf_atom_3a61ed37:ApplyCustomization(__wf_atom_bb3e7833_2, {}, true, 1)
		weaponCustomization:ApplyCustomization(__wf_atom_bb3e7833_5, {}, false, 0)
		weaponCustomization:ApplyCustomization(__wf_atom_bb3e7833_6, {}, false, 0)
	end
end

local function fn2(p)
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

function OpenBodySelectMovieSkipFwd(object)
	fn2(v)
	object:Stop()
end

function InitializeMotherSelection(_)
	_T.MotherSelectionState = nil
end

function PrepareMotherComplexionCin(object)
	if not (__wf_atom_7e8ad928(object) or object:__wf_atom_af9ae957()) then
		object:__wf_atom_398939a1()
	end
end

function ShowMotherComplexionMovie(motherCutscene)
	if _T.MotherSelectionState ~= nil and _T.MotherSelectionState < 3 then
		return
	end

	_T.MotherCutscene = motherCutscene
	_T.MotherSelectionState = 1

	if not (__wf_atom_7e8ad928(motherCutscene) or motherCutscene:__wf_atom_af9ae957()) then
		motherCutscene:__wf_atom_398939a1()
	end

	fn2(v2)
end

function ShowMotherHairMovie(motherCutscene)
	if _T.MotherSelectionState ~= 2 then
		return
	end

	_T.MotherCutscene = motherCutscene
	_T.MotherSelectionState = 3

	if not (__wf_atom_7e8ad928(motherCutscene) or motherCutscene:__wf_atom_af9ae957()) then
		motherCutscene:__wf_atom_398939a1()
	end

	fn2(v2)
end

function ShowMotherEyeMovie(motherCutscene)
	if _T.MotherSelectionState ~= 6 then
		return
	end

	_T.MotherCutscene = motherCutscene
	_T.MotherSelectionState = 7

	if not (__wf_atom_7e8ad928(motherCutscene) or motherCutscene:__wf_atom_af9ae957()) then
		motherCutscene:__wf_atom_398939a1()
	end

	fn2(v2)
	_T.MotherSelectionState = nil
end

function ShouldOpenFactionChoiceScreen()
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	if
		gGameData:__wf_atom_0cbd9965() == EMPTY_SYMBOL
		and module4.HasCompletedQuest(WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp"))
	then
		return true
	end

	return false
end

function OpenFactionChoiceScreen(_, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if p then
		module5.FadeToBlack(true, 0)
	else
		module5.FadeToBlack(true, 0.3)
	end

	fn2(v3)
end

function LoadInitialGear()
	return module3.LoadInitialGear()
end

local v13 = 1
local v14 = false

function OnStopped(_)
	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
	__wf_atom_72fc675e.soloMode = true
	gGameRules:SetMission(__wf_atom_72fc675e)
	gGameRules:HideGameSession(true)

	if v8 == nil then
		v8 = LoadInitialGear()
	end

	if v8 then
		if v13 == #v4 and not v8:__wf_atom_86399a47() then
			v8:__wf_atom_cf280c82()
		end

		if v8:__wf_atom_86399a47() then
			module3.GiveInitialGear(gRegion:__wf_atom_c4f78a8f())
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not v14 then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v5)

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f)) then
			__wf_atom_c4f78a8f:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
			v14 = true
		end
	end

	if v13 == #v4 then
		print("destroying prisoner scene...")

		if _T.PrisonerStreamLayer == nil then
			print("could not find prisoner scene layer! prisoner scene not destroyed!")
		else
			local levelArgs = Engine.OpenLevelArgs()
			levelArgs.streamingLayer = _T.PrisonerStreamLayer
			Engine.__wf_atom_94cafc05(levelArgs)
			_T.PrisonerStreamLayer = nil
		end
	end

	while v13 <= #v4 do
		local v15 = v4[v13]
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)
		v13 += 1

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			continue
		end

		__wf_atom_0a6a5887:FirePort("StartPlaying")
		__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnStopped")
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v6)
	end

	module.Fade(false, 0)
	module3.OnFirstLoginSequenceFinished()
end

function StartFirstLoginCins()
	module.Fade(true, 0, 1, false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CharacterSelectCin"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CharacterSelectCin"))
		Sleep(0)
	end

	if not (module4.QuestIsActive(v7) or module4.HasCompletedQuest(v7)) then
		module4.StartQuest(Resource(v7))
	end

	Sleep(1)

	while module4.QuestIsActive(v7) do
		Sleep(0.1)
	end

	module10.ClearWeatherAndDisableCycle(0, Symbol("DefaultMainSky"))
	OnStopped()
end

function RollForWispers(p)
	if not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v10)) then
		if Random(0, 1) < 0.02 then
			_T.ForceShowHud = true
			module8.PlayLocalTransmission(v9, v10, p)
			Sleep(0.3)
			_T.ForceShowHud = false
			v11 = true
		else
			v12 = __wf_atom_5784a397(10, 30)
		end
	end
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local v15 = Symbol("Sparrow1")
	local __wf_atom_59c6b81d = object:__wf_atom_59c6b81d()

	for _, v16 in ipairs(__wf_atom_59c6b81d) do
		if not __wf_atom_7e8ad928(v16) and not v16:IsA(__wf_atom_4ebf67cb) and v16:__wf_atom_12695c30() == v15 then
			return v16
		end
	end

	return nil
end

function StartRegularLoginCins()
	if _G.LoginSequencePlayed then
		return
	end

	if not _T.FirstLoginSequencePlayed and gRegion:__wf_atom_c519a397() then
		_G.LoginSequencePlayed = true
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

	while __wf_atom_7e8ad928(__wf_atom_50a7d83e) do
		Sleep(0)
		__wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	end

	gRegion:PlaySound(startSound, Vector(), false)
	local v15 = _T.FirstLoginSequencePlayed == nil
	module7.ClearTables()

	if v15 then
		local firstLoginSequencePlayed = _T.FirstLoginSequencePlayed == true
		local __wf_atom_32216982 = gGameRules:__wf_atom_32216982(firstLoginSequencePlayed)
		local v16 = fn3(__wf_atom_32216982)

		if v16 ~= nil then
			module9.ApplySparrowCustomizationToDeco(__wf_atom_50a7d83e, v16)
		end

		if not __wf_atom_7e8ad928(__wf_atom_32216982) then
			local nearestTagged = gRegion:FindNearestTagged(Symbol("PostLoginCin"), __wf_atom_32216982:GetPosition())
			__wf_atom_32216982:FirePort("StartPlaying")
			v12 = __wf_atom_5784a397(10, 30)

			while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
				if not v11 then
					if v12 <= 0 then
						RollForWispers(__wf_atom_50a7d83e)
					end

					v12 -= __wf_atom_084b3e93()
				end

				Sleep(0)
			end

			if module3.ShouldDoFirstLoginSequence(false) then
				if not __wf_atom_7e8ad928(__wf_atom_32216982) then
					__wf_atom_32216982:Skip()
				end

				return
			else
				local shouldSkipPostLoginCin = module3.ShouldSkipPostLoginCin()

				if shouldSkipPostLoginCin and not __wf_atom_7e8ad928(__wf_atom_32216982) then
					__wf_atom_32216982:Skip()
					module.Fade(true, 0)
				end

				while not module2.IsNightFoldStreamed() do
					Sleep(0)
				end

				local v17 = ShouldOpenFactionChoiceScreen()
				local v18 = not gGameData:__wf_atom_df64c481()
				local v19

				if v17 or v18 then
					v19 = LoadInitialGear()

					while not v19:__wf_atom_86399a47() do
						Sleep(0)
					end
				end

				local __wf_atom_32216982_2 = gGameRules:__wf_atom_32216982(firstLoginSequencePlayed)

				if not __wf_atom_7e8ad928(__wf_atom_32216982_2) and __wf_atom_32216982 ~= __wf_atom_32216982_2 then
					__wf_atom_32216982:Skip()
					nearestTagged = gRegion:FindNearestTagged(
						Symbol("PostLoginCin"),
						__wf_atom_32216982_2:GetPosition()
					)
					__wf_atom_32216982_2:FirePort("StartPlaying")
					__wf_atom_32216982 = __wf_atom_32216982_2
				end

				module6.BuildLoadout(__wf_atom_50a7d83e, __wf_atom_eab484a7:__wf_atom_a4299765())

				if v18 then
					module3.GiveInitialGear(__wf_atom_50a7d83e)
				end

				__wf_atom_32216982:Stop()
				gRegion:PlaySound(continueSound, Vector(), false)
				module7.PostLoginSetup()

				if not (__wf_atom_7e8ad928(nearestTagged) or shouldSkipPostLoginCin) then
					while not (__wf_atom_7e8ad928(nearestTagged) or nearestTagged:__wf_atom_7d4910e4()) do
						Sleep(0)
					end

					while not __wf_atom_7e8ad928(nearestTagged) and nearestTagged:__wf_atom_7d4910e4() do
						Sleep(0)
					end
				end

				if v17 then
					local v20 = shouldSkipPostLoginCin
						or not __wf_atom_7e8ad928(nearestTagged) and nearestTagged:__wf_atom_e9546dc6()
					OpenFactionChoiceScreen(v19, v20)
				end
			end
		end
	else
		while not module2.IsNightFoldStreamed() do
			Sleep(0)
		end

		module6.BuildLoadout(__wf_atom_50a7d83e, __wf_atom_eab484a7:__wf_atom_a4299765())
		gRegion:PlaySound(continueSound, Vector(), false)
		Sleep(0.5)
	end

	_T.FirstLoginSequencePlayed = nil
	print("setting global Login sequence played")
	_G.LoginSequencePlayed = true
	local v16 = Symbol("P16")

	if
		not gGameData:__wf_atom_7f86fc42(v16)
		and module4.HasCompletedQuest(WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp"))
	then
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(welcomeMovieWRes, "OnWelcomeMovieLoaded")
		gGameData:__wf_atom_c9bb8504(v16)
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_fd87a8ab(0)
		gGameRules:__wf_atom_fd87a8ab(1)
	end

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:__wf_atom_cf966a74(v6)
	end
end

function RunScriptTriggerOnLevelStart(object)
	if
		module3.ShouldDoFirstLoginSequence(true)
		and not (__wf_atom_7e8ad928(gRegion) or gRegion:__wf_atom_c519a397() or __wf_atom_7e8ad928(gRegion:__wf_atom_8ad59546()))
	then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
	end

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while __wf_atom_7e8ad928(gClient) or gClient:IsLoading() or not gClient:__wf_atom_2ad290b4() do
		Sleep(0)
	end

	while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
		Sleep(0)
	end

	object:FirePort("Execute")
end