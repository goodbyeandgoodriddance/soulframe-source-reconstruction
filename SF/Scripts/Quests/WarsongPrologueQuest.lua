local v = Resource("/SF/Types/Input/BlockAllInputFilter")
local v2 = Resource("/SF/Sounds/Dialog/TransmissionSets/WarsongStoryboardsTransmissionSet")
local v3 = WeakResource("/SF/Types/Quests/WarsongPrologueQuest")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.FirstLoginUtils")
local module4 = require("SF.Scripts.NightFoldLib")
local module5 = require("SF.Scripts.Libs.StatsLib")
local module6 = require("SF.Scripts.Libs.QuestLib")

local function fn(soloMode)
	if not gRegion:IsMaster() then
		return false
	end

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

	if __wf_atom_72fc675e.soloMode == soloMode then
		return false
	end

	Sleep(3)
	__wf_atom_72fc675e.soloMode = soloMode
	gGameRules:SetMission(__wf_atom_72fc675e)
	gGameRules:HideGameSession(soloMode)
	return true
end

local function fn2()
	local playerAvatar = gRegion:GetPlayerAvatar()

	while not module.IsInNightFold(playerAvatar) do
		if not __wf_atom_7e8ad928(_T.ShowImpactMessage) then
			_T.ShowImpactMessage("/SF/Language/Tutorial/EnterNightFold", -1)
		end

		Sleep(0.1)

		if __wf_atom_7e8ad928(playerAvatar) then
			playerAvatar = gRegion:GetPlayerAvatar()
		end
	end

	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end

	Sleep(3)
end

function CinematicIntro(p)
	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end

	local v4 = not module3.ShouldDoFirstLoginSequence(false)

	if v4 then
		if not module6.InitializeTask(mOwner, p, false, true) then
			return
		end

		while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
			Sleep(0)
		end
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

	while __wf_atom_7e8ad928(__wf_atom_50a7d83e) do
		Sleep(0)
		__wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	end

	__wf_atom_50a7d83e:__wf_atom_aeb02c14(v)

	while not _G.gHasLoggedIn do
		Sleep(0)
	end

	if gMatchingService:__wf_atom_8b3e33a6() > 1 then
		if not gRegion:IsMaster() then
			gClient:ForceHostMigration()
			return
		end

		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for i = 1, #__wf_atom_3c8e1a7a do
			if not __wf_atom_3c8e1a7a[i]:IsLocal() then
				gMatchingService:__wf_atom_369780a2(__wf_atom_3c8e1a7a[i], false)
			end
		end
	end

	module.Fade(true, 0.5, 1, true)
	print("Warsong Prologue: Intro Cin and Mother Body Customization started!")
	module5.ReplicateLogEvent("PROLOGUE_QUEST", "StartPrologueCin")
	module6.TrackQuest(mOwner)

	if module6.TaggedTaskIsActive(v3, Symbol("Cinematics")) then
		if v4 then
			local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/Codex.swf"))

			if not __wf_atom_7e8ad928(movie) then
				movie:Close()
			end
		end

		while __wf_atom_7e8ad928(gGameData) do
			Sleep(0)
		end

		__wf_atom_50a7d83e:__wf_atom_cf966a74(v)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowIntroCin"))

		while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
			__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowIntroCin"))
			Sleep(0)
		end

		module.PlayCinematicAndWait(__wf_atom_0a6a5887)

		if __wf_atom_0a6a5887:__wf_atom_e9546dc6() then
			module.Fade(true, 1, 0, true)
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("FinalCosmeticOptionCin"))
		module.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)

		if v4 then
			module.Fade(true, 1, 0, false)
			module4.DisableAllSkiesButTagged("DefaultMainSky")
		end

		_T.WarsongPrologueQuestStartedFromBeginning = true

		if gRegion:IsMaster() then
			print("Warsong Prologue: Intro Cin and Mother Body Customization complete! (Stage 1)")
			module6.CompleteTaskWithID(mOwner, p)
		end
	else
		print("Skipping Warsong Prologue quest cinematic.")
		_T.WarsongPrologueIntroCinPlaying = nil
	end
end

function MotherCombatTutorial(p)
	if fn(true) then
		return
	end

	local v4 = not module3.ShouldDoFirstLoginSequence(false)

	if v4 then
		if not module6.InitializeTask(mOwner, p, false, true) then
			return
		end

		fn2()
	end

	print("Warsong Prologue: Mother Combat Tutorial started!")

	if __wf_atom_7e8ad928(_T.WarsongPrologueQuestStartedFromBeginning) then
		module.Fade(true, 0.5, 1, true)

		if v4 then
			local taggedSky = module4.GetTaggedSky(Symbol("NightFoldDynSky"))

			if not __wf_atom_7e8ad928(taggedSky) then
				taggedSky:Enable(false)
			end
		end
	end

	_T.WarsongPrologueQuestStartedFromBeginning = nil
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

	while __wf_atom_7e8ad928(__wf_atom_50a7d83e) do
		Sleep(0)
		__wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StartCombatTutorialTrigger"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		Sleep(0)
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StartCombatTutorialTrigger"))
	end

	__wf_atom_0a6a5887:FirePort("Execute")
	local __wf_atom_50a7d83e2 = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	__wf_atom_50a7d83e2:__wf_atom_aeb02c14(v)
	Sleep(4)
	module.Fade(true, 1, 0, true)
	__wf_atom_50a7d83e2:__wf_atom_cf966a74(v)

	while not _T.CombatTutorialEnded do
		Sleep(0.1)
	end

	module.Fade(true, 1, 1, true)
	__wf_atom_eab484a7:__wf_atom_6c552f4c(4, __wf_atom_50a7d83e)
	__wf_atom_eab484a7:AssignAvatar(__wf_atom_50a7d83e)
	__wf_atom_50a7d83e:__wf_atom_e25a34ac(true)
	__wf_atom_50a7d83e:__wf_atom_aeb02c14(v)
	Sleep(3)
	module.Fade(true, 1, 0, false)
	module2.PlayGlobalTransmission(v2, Symbol("WarsongStoryboards"), true)

	if v4 then
		local taggedSky = module4.GetTaggedSky(Symbol("NightFoldDynSky"))

		if not __wf_atom_7e8ad928(taggedSky) then
			taggedSky:Enable(true)
		end

		__wf_atom_50a7d83e:__wf_atom_51075230(__wf_atom_50a7d83e:__wf_atom_dc309f8a())
		module.Fade(true, 1, 0, true)
	end

	__wf_atom_50a7d83e:__wf_atom_e25a34ac(false)
	__wf_atom_50a7d83e:__wf_atom_cf966a74(v)

	if gRegion:IsMaster() then
		print("Warsong Prologue: Mother Combat Tutorial complete! (Stage 2)")
		module6.CompleteTaskWithID(mOwner, p)
	end

	fn(false)
end