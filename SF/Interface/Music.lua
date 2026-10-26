local v = WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")
local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Interface.Libs.MusicCommon")
local module4 = require("SF.Scripts.Libs.StatsLib")
local module5 = require("SF.Scripts.Libs.QuestLib")
local module6 = require("SF.Scripts.NightFoldLib")
local v2 = 5
local v3 = nil
local v4 = {}
local v5 = {}
local v6 = {}
local total = -0.112
local v7 = 0
local flag = true
local v8 = nil
local v9 = __wf_atom_10cd16b2(0, 0.2)
local count = 0
local flag2 = false
local v10 = 0
local v11 = 0
local v12 = 0
local count2 = 0
local v13 = false
local v14 = false
local v15 = nil
local v16 = nil
local v17 = 1
local mDeoraCinematicStartDelta = 0.2
local mDeoraCinematicEndDelta = 0.9
local v18 = 0
local mDeoraCinematic = nil
local v19 = __wf_atom_10cd16b2(0, 0.5)
local v20 = nil
local v21 = __wf_atom_10cd16b2(0, 0.5)
local v22 = 0
local v23 = nil
local y = 0
local position = Vector(0, 0, 0)
local count3 = 0
local v24 = 1
local v25 = {}
local musicGameAllowedAttempts = -1
local count4 = 0
local count5 = 0
local v26 = nil
local position2 = nil
local v27 = nil
local successSound2 = nil

local function fn() -- 1 equivalent call inferred from this helper
	local songMidiData = songMidiData

	if _T.MusicGameMidiOverride then
		songMidiData = _T.MusicGameMidiOverride
	end

	return songMidiData
end

local function fn2()
	local songMidiData = fn() -- inferred equivalent call
	successSound2 = successSound

	if not (__wf_atom_7e8ad928(songMidiData) or __wf_atom_7e8ad928(songMidiData:__wf_atom_4c700ca0())) then
		successSound2 = songMidiData:__wf_atom_4c700ca0()
	end

	if _T.MusicGameSuccessSoundOverride then
		successSound2 = _T.MusicGameSuccessSoundOverride
	end

	local result = {}
	Resource(songMidiData:__wf_atom_1bb5b1ff())
	v2 = songMidiData:__wf_atom_1e34340d()
	local __wf_atom_b17a4143 = songMidiData:__wf_atom_b17a4143()

	for i = 1, #__wf_atom_b17a4143 do
		local v28 = __wf_atom_b17a4143[i]
		local note = v28.note
		local start = v28.start
		table.insert(result, { module3.MidiNoteToInstrumentSoundIndex(note), start / v2 })
	end

	return result
end

local function fn3()
	gRegion:PlaySound(whiteFlashSound, Vector(0, 0, 0), false)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local v28 = 0

	while v28 < 1 do
		v28 = __wf_atom_421b01aa(v28 + __wf_atom_084b3e93(), 0, 1)
		local bloom = v28 * 4 + 1
		postProcess.bloom = bloom
		postProcess:__wf_atom_2bd5152a(bloom, bloom, bloom, bloom)
		Sleep(0)
	end
end

local function fn4() -- 2 equivalent calls inferred from this helper
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess.bloom = 1
	postProcess:__wf_atom_2bd5152a(1, 1, 1, 1)
end

local function fn5() -- 2 equivalent calls inferred from this helper
	if tutorialEasyMode then
		_T.MusicPuzzleTutorialDifficulty = true
	end

	if tutorialSlowMode then
		_T.MusicPuzzleTutorialSpeed = true
	end
end

local function fn6() -- 2 equivalent calls inferred from this helper
	if tutorialEasyMode then
		_T.MusicPuzzleTutorialDifficulty = nil
	end

	if tutorialSlowMode then
		_T.MusicPuzzleTutorialSpeed = nil
	end
end

function SoulSong(instance, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(object, mixEffect, mixingGroup)
	end

	if not __wf_atom_7e8ad928(musicMidiOverride) then
		_T.MusicGameMidiOverride = musicMidiOverride
	end

	if forceCompletion then
		_T.MusicGameForceCompletion = true
	end

	fn5() -- inferred equivalent call

	if gRegion:__wf_atom_c4f78a8f() == object then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)

		if instance:IsA(__wf_atom_8b8e8b22) then
			module6.RegisterPreventNighfoldUsage(true)
			local v28 = Symbol("Invulnerable")
			object:__wf_atom_d2b2176d():Unequip(0, 2)
			object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
			local __wf_atom_7470861b = object:__wf_atom_7470861b()
			__wf_atom_7470861b:__wf_atom_9fba31e6(v28, 26, 6, 0)

			if gRegion:IsMaster() then
				if instance:IsA(__wf_atom_8b8e8b22) then
					instance:Disable()
				end

				object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
			else
				while not __wf_atom_7e8ad928(object) and not object:IsKilled() and object:__wf_atom_0473b7a9() do
					Sleep(0)
				end
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
				__wf_atom_7470861b:__wf_atom_63396172(v28)
				local __wf_atom_8161e6ba = object:__wf_atom_8161e6ba()

				if __wf_atom_8161e6ba.mSuccess then
					if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
						__wf_atom_b3845a20:__wf_atom_64d1f332(object, mixEffect, mixingGroup)
					end

					if doWhiteFlash then
						fn3()
					end

					if not __wf_atom_7e8ad928(doneForwarder) then
						doneForwarder:FirePort("TriggerPort")
					end

					if doWhiteFlash then
						fn4() -- inferred equivalent call
					end

					fn6() -- inferred equivalent call
					_T.SoulSongMusicPuzzleSuccess = true
				elseif
					(replayable or not __wf_atom_8161e6ba.mSuccess)
					and gRegion:IsMaster()
					and instance:IsA(__wf_atom_8b8e8b22)
				then
					instance:Enable()
				end
			end

			module6.RegisterPreventNighfoldUsage(false)
		end
	elseif gRegion:IsMaster() then
		if instance:IsA(__wf_atom_8b8e8b22) then
			if not instance:IsEnabled() then
				return
			end

			instance:Disable()
		end

		object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)

		if __wf_atom_7e8ad928(object) then
			if replayable and instance:IsA(__wf_atom_8b8e8b22) then
				instance:Enable()
			end
		else
			local __wf_atom_8161e6ba = object:__wf_atom_8161e6ba()

			if __wf_atom_8161e6ba.mSuccess then
				if doWhiteFlash then
					fn3()
				end

				if not __wf_atom_7e8ad928(doneForwarder) then
					doneForwarder:FirePort("TriggerPort")
				end

				if doWhiteFlash then
					fn4() -- inferred equivalent call
				end

				fn6() -- inferred equivalent call
				_T.SoulSongMusicPuzzleSuccess = true
			elseif (replayable or not __wf_atom_8161e6ba.mSuccess) and instance:IsA(__wf_atom_8b8e8b22) then
				instance:Enable()
			end
		end
	end
end

function SoulSongChild(p, p2)
	_T.MusicGameCamera = gRegion:GetGameCamera()
	SoulSong(p, p2)
	_T.MusicGameCamera = nil
end

function SoulSongEmerge(_, object)
	_T.MusicGameCamera = gRegion:GetGameCamera()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(object, mixEffect, mixingGroup)
	end

	if not __wf_atom_7e8ad928(musicMidiOverride) then
		_T.MusicGameMidiOverride = musicMidiOverride
	end

	if forceCompletion then
		_T.MusicGameForceCompletion = true
	end

	fn5() -- inferred equivalent call
	__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and object:__wf_atom_0473b7a9() do
		Sleep(0)
	end

	_T.MusicGameCamera = nil
end

function DestroyInstrumentAfter(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if disableIK then
		__wf_atom_3d96ddcd:EnableFootIK(true)
	end

	if not forceRemoveInstrument then
		while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(5) do
			Sleep(0)
		end
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function AvatarPlayInstrument(object)
	if disableIK then
		object:EnableFootIK(false)
	end

	module3.AvatarPlayInstrument(
		object,
		"SaveDeoraSoulCin",
		instrumentDecoType,
		musicStartAnim,
		musicLoopAnim,
		musicEndAnim,
		nil,
		instrumentRotation,
		instrumentOffset
	)
end

local function fn7(p) -- 12 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return nil
	end

	return gRegion:PlaySound(p, __wf_atom_c4f78a8f:GetPosition(), false)
end

local function fn8()
	if not __wf_atom_7e8ad928(v15) then
		v15:Attach(rebuildSpawner, EMPTY_SYMBOL)

		if __wf_atom_7e8ad928(v16) then
			v16 = fn7(statueSound) -- inferred equivalent call
		end
	end

	local v28 = count3 * (1 / v24) + count / #v3 * (1 / v24)

	if __wf_atom_7e8ad928(v20) then
		v19:__wf_atom_09294a87(v28)
		return
	end

	if __wf_atom_7e8ad928(mDeoraCinematic) then
		local position3 = v20:GetPosition()
		position3.y = y + 1.3
		gRegion:CreateEntity(deoraRebuildSpawner, position3, __wf_atom_80368bb1)
		v21:__wf_atom_09294a87(__wf_atom_104bfe98(0, 1.3, __wf_atom_24a82b69(v28)))
		v22 = 1
	else
		v19:__wf_atom_09294a87(v28)
		local position3 = v20:GetPosition()
		position3.y = y + 1.3
		gRegion:CreateEntity(deoraRebuildSpawner, position3, __wf_atom_80368bb1)
		v20:Attach(deoraSuccessAttachFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	v23 = fn7(deoraSound) -- inferred equivalent call
	v23:__wf_atom_ff2a5387(__wf_atom_104bfe98(-12, 2, v28))
end

local function fn9()
	if not __wf_atom_7e8ad928(v15) then
		if not __wf_atom_7e8ad928(v16) then
			v16:Stop(false)
		end

		if count > 0 then
			fn7(statueCollapseSound) -- inferred equivalent call

			if not __wf_atom_7e8ad928(v15) then
				v15:Attach(collapseSpawner, EMPTY_SYMBOL)
			end
		end
	end

	if not __wf_atom_7e8ad928(v20) then
		if not __wf_atom_7e8ad928(mDeoraCinematic) then
			v21:__wf_atom_09294a87(__wf_atom_104bfe98(0, 1.3, __wf_atom_24a82b69(count3 * (1 / v24))))
			v20:Attach(deoraCollapseSpawner, EMPTY_SYMBOL, Vector(0, 0.5, 0))
		end

		fn7(deoraCollapseSound) -- inferred equivalent call
	end

	count = 0
	v19:__wf_atom_09294a87(count3 * (1 / v24))
end

function Fail(_)
	Sleep(1)
	fn7(failSound) -- inferred equivalent call
end

function Awaken(object)
	gRegion:PlaySound(successSound2, object:GetPosition(), false)
	local v28 = 0

	while v28 < 1 and not __wf_atom_7e8ad928(object) do
		v28 = __wf_atom_421b01aa(v28 + __wf_atom_084b3e93() * 0.3, 0, 1)
		local v29 = v28 * 10 * Noise(Time()) + v28 * 4
		local v30 = __wf_atom_104bfe98(v29, 5, (math.pow(v28, 8)))
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v30)
		Sleep(0)
	end
end

function Looted(object)
	local v28 = 0

	while v28 < 1 and not __wf_atom_7e8ad928(object) do
		v28 = __wf_atom_421b01aa(v28 + __wf_atom_084b3e93() * 0.3, 0, 1)
		local v29 = v28 * 10 * Noise(Time()) + v28 * 4
		local v30 = __wf_atom_104bfe98(v29, 5, (math.pow(v28, 8)))
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v30)
		Sleep(0)
	end
end

function _MonitorCinematicEnd(object)
	local position3 = object:GetPosition()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SaveDeoraSoulCin"), position3, 0, 20)

	if _T.BromiusSoulSong then
		__wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SaveBromiusCin"), position3, 0, 20)
	end

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(__wf_atom_f738b4af)
		and __wf_atom_f738b4af:__wf_atom_7d4910e4()
	do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = false
	musicResultsRMIArgs.mSuccess = true
	object:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
end

function DissolveOut(object)
	local v28 = object:GetPosition() + Vector(0, 10, 0) + __wf_atom_e97f3142(object:__wf_atom_4e50d390()) * 10
	module.DissolveOut(object, v28)
end

function LoadEternium(_)
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = eterniumLevel
	levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
	levelArgs.gameRules = gClient:__wf_atom_2aee259b()
	levelArgs.restartLevel = false
	levelArgs.migrateServer = false
	levelArgs.loadToLobby = false
	levelArgs.hostingMultiplayer = false
	Engine.OpenLevel(levelArgs)
end

function ToEternium(object)
	if module5.QuestIsActive(v) and not module5.IsQuestInReplay(v) then
		return
	end

	object:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 1 / 3)
	Sleep(3)

	if __wf_atom_7e8ad928(eterniumLevel) then
		return
	end

	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) or not gRegion:IsMaster() then
		LoadEternium()
		return
	end

	gMatchingService:LeaveSquad("LoadEternium")

	while true do
		Sleep(1)
	end
end

local function fn10()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local position3 = __wf_atom_c4f78a8f:GetPosition()
	local cameraControl = __wf_atom_c4f78a8f:CameraControl()
	cameraControl:__wf_atom_4dab66dd(position3, -1, 20, 1)
	cameraControl:__wf_atom_928a45c5(musicColorGrade, true)
	cameraControl:__wf_atom_fd14c463(0.5)
	cameraControl:SetCameraSpot(nil, 0.5)
	flag = false
	v7 = 5

	if _T.SpiritChestMusicGame then
		v7 = 1
	end

	__wf_atom_ec43d06e(mMovie, "Frame", 8, { 12 }, { 0 }, 1, 0)
	mMovie:__wf_atom_0c1c47f2(nil)
	__wf_atom_c4f78a8f:SetVisibility(true, true)

	if not __wf_atom_7e8ad928(v8) then
		v8:__wf_atom_74d17eae(1, 0)
		gRegion:__wf_atom_dd1e4d10(v8)
	end

	if not __wf_atom_7e8ad928(v26) then
		v26:Stop(false)
	end

	for i = 1, #v25 do
		if not __wf_atom_7e8ad928(v25[i]) then
			v25[i]:Stop(false)
		end
	end

	if __wf_atom_7e8ad928(mDeoraCinematic) then
		local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs.mIsPlaying = false
		local musicGameComplete = _T.MusicGameComplete
		local perfectPerformace = _T.PerfectPerformace

		if musicGameComplete == nil or not musicGameComplete then
			musicGameComplete = false
		end

		musicResultsRMIArgs.mSuccess = musicGameComplete

		if perfectPerformace == nil or not perfectPerformace then
			perfectPerformace = false
		end

		musicResultsRMIArgs.mPerfect = perfectPerformace
		__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	elseif _T.BromiusSoulSong and not gRegion:IsMaster() then
		local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs.mIsPlaying = false
		musicResultsRMIArgs.mSuccess = true
		__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	elseif flag2 then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("_MonitorCinematicEnd"), false)
	else
		local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs.mIsPlaying = false
		__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	end

	if flag2 and not v13 and __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("ToEternium"), false)
	end
end

local function fn11()
	count3 += 1

	if count3 < v24 then
		if not __wf_atom_7e8ad928(winPhaseSounds[count3]) then
			v25[count3] = fn7(winPhaseSounds[count3]) -- inferred equivalent call
		end
	elseif _T.SkipMusicMovie then
		_T.MusicGameComplete = true
		flag2 = true
		fn10()
		_T.SkipMusicMovie = false
	else
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SongName.Text", 1)
		mMovie:__wf_atom_e57658c2("SongName.Text", 1, __wf_atom_5e6e15c8 + 100)
		__wf_atom_ec43d06e(mMovie, "SongName.Text", 4, { 1 }, { __wf_atom_5e6e15c8 }, 1, 0)

		if not __wf_atom_7e8ad928(v15) then
			if _T.SpiritChestMusicGame then
				mMovie:__wf_atom_2dedec1a("Title", 13, false)
				mMovie:__wf_atom_e57658c2("Title", 12, 0)
				__wf_atom_ec43d06e(mMovie, "Title", 8, { 12 }, { 100 }, 1, 0)
				_T.SpiritChestMusicGame = false
				_T.MusicGameComplete = true
				flag2 = true
				v22 = 0
				v15:__wf_atom_8a035cd5(Symbol("Looted"), false)
				fn10()
				return
			else
				v15:__wf_atom_8a035cd5(Symbol("Awaken"), false)
			end
		end

		_T.MusicGameComplete = true
		flag2 = true
		v22 = 0
		fn10()
	end
end

local function fn12(p, p2)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<SHAWZIN_NOTE_" .. tostring(p2) .. ">", true, {}, true)
	mMovie:__wf_atom_48bd5a59(p, "Callout.Tf", 36, __wf_atom_8e9ac384)
	local ternary = module2.Ternary(Engine.IsPlayingWithController(), 90, 120)
	mMovie:__wf_atom_4c1c1986(p, "Callout", 5, ternary)
	mMovie:__wf_atom_4c1c1986(p, "Callout", 6, ternary)
	mMovie:__wf_atom_4c1c1986(p, "Callout", 1, module2.Ternary(Engine.IsPlayingWithController(), 1, -1))
end

local function fn13(p) -- 2 equivalent calls inferred from this helper
	local songMidiData = songMidiData

	if _T.MusicGameMidiOverride then
		songMidiData = _T.MusicGameMidiOverride
	end

	if __wf_atom_7e8ad928(songMidiData) or not (#songMidiData:__wf_atom_cbc780a6() > 0) then
		return noteSounds[p]
	end

	return songMidiData:__wf_atom_cbc780a6()[p]
end

local function fn14(p) -- 2 equivalent calls inferred from this helper
	local songMidiData = songMidiData

	if _T.MusicGameMidiOverride then
		songMidiData = _T.MusicGameMidiOverride
	end

	if __wf_atom_7e8ad928(songMidiData) or not (#songMidiData:__wf_atom_c7210bef() > 0) then
		return trainNoteSounds[p]
	end

	return songMidiData:__wf_atom_c7210bef()[p]
end

local function fn15(p) -- 3 equivalent calls inferred from this helper
	return -54 + (5 - p) * 27.5
end

local function fn16(p, i)
	if v3[i][3] then
		return
	end

	if #v5 == 0 then
		mMovie:__wf_atom_50d60589("Title.Text", 36, "")
	end

	local v28

	if flag then
		v28 = v3[i][2] or nil
	end

	local v29 = v28 or total
	local v30 = __wf_atom_104bfe98(-268, 271, v29)

	if flag then
		fn7(fn14(p)) -- inferred equivalent call
	else
		fn7(fn13(p)) -- inferred equivalent call
		table.insert(v5, { p, total })
	end

	local v31

	if #v6 == 0 then
		local v32 = "Note" .. #v4 + 0
		__wf_atom_86cbd68d(mMovie, "Frame.Note.duplicateMovieClip", v32, #v4 + 1001)
		v31 = "Frame." .. v32
	else
		local v32 = math.random(#v6)
		v31 = v6[v32]
		table.remove(v6, v32)
	end

	mMovie:__wf_atom_50d60589(v31 .. ".Label", 36, (tostring(p)))
	mMovie:__wf_atom_2dedec1a(v31, 13, true)
	mMovie:__wf_atom_e57658c2(v31, 0, v30)
	mMovie:__wf_atom_e57658c2(v31, 1, fn15(p)) -- inferred equivalent call
	mMovie:__wf_atom_e57658c2(v31, 5, 50)
	mMovie:__wf_atom_e57658c2(v31, 6, 50)
	mMovie:__wf_atom_e57658c2(v31, 12, 100)
	__wf_atom_ec43d06e(mMovie, v31, 4, { 5, 6 }, { 100, 100 }, 0.5, 0)
	mMovie:__wf_atom_7f57ab2f(v31, "NoteHoverBurst", 13, false)
	mMovie:__wf_atom_7f57ab2f(v31, "NoteHover", 13, false)
	mMovie:__wf_atom_7f57ab2f(v31, "IncorrectNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(v31, "CorrectNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(v31, "PerfectNote", 13, false)
	mMovie:__wf_atom_4c1c1986(v31, "Callout.Tf", 44, 13550728)
	fn12(v31, p)
	v4[i] = v31
	v3[i][3] = true
end

local function fn17(p, p2)
	if p2 then
		local v28 = __wf_atom_7e8ad928(_T.MusicPuzzleTutorialDifficulty) and 1 or 2
		local v29 = not __wf_atom_7e8ad928(_T.MusicPuzzleTutorialSpeed) and 0.9 or 1
		local flag3 = true

		for i = 1, #v3 do
			local v30 = math.abs(v3[i][2] - total)

			if not (v30 < v28 * 0.06) then
				continue
			end

			if not v3[i][3] then
				fn16(v3[i][1], i)
			end

			local v31 = v4[i]
			local v32 = mMovie:__wf_atom_bd8fa442(v31, "CorrectNote", 13)
				or mMovie:__wf_atom_bd8fa442(v31, "PerfectNote", 13)

			if v3[i][1] == p and not v32 then
				flag3 = false

				if v30 < v28 * 0.06 * 0.1 then
					mMovie:__wf_atom_7f57ab2f(v31, "PerfectNote", 13, true)
					count2 += 1
				else
					mMovie:__wf_atom_7f57ab2f(v31, "CorrectNote", 13, true)
				end

				count += 1
				mMovie:__wf_atom_7f57ab2f(v31, "NoteHoverBurst", 13, true)
				mMovie:__wf_atom_4c1c1986(v31, "NoteHoverBurst", 12, 100)
				__wf_atom_ec43d06e(mMovie, v31 .. ".NoteHoverBurst", 2, { 12 }, { 0 }, 1.5, 0)
				mMovie:__wf_atom_e57658c2(v31 .. ".NoteHoverBurst.Inner", 5, 10)
				mMovie:__wf_atom_e57658c2(v31 .. ".NoteHoverBurst.Inner", 6, 10)
				__wf_atom_ec43d06e(mMovie, v31 .. ".NoteHoverBurst.Inner", 4, { 5, 6 }, { 100, 100 }, 1.5, 0)
				mMovie:__wf_atom_e57658c2(v31, 5, 80)
				mMovie:__wf_atom_e57658c2(v31, 6, 80)
				__wf_atom_ec43d06e(mMovie, v31, 4, { 5, 6 }, { 100, 100 }, 1.5, 0)
				fn7(correctNoteSound) -- inferred equivalent call
				fn8()

				if count == #v3 then
					if count2 == #v3 then
						_T.PerfectPerformace = true
					end

					fn11()
				end
			elseif flag3 and not v32 then
				mMovie:__wf_atom_7f57ab2f(v31, "IncorrectNote", 13, true)
			end
		end

		if flag3 then
			fn7(failSound) -- inferred equivalent call
			count5 += 1
			fn9()
			mMovie:__wf_atom_2dedec1a("Frame.Note", 13, true)
			mMovie:__wf_atom_e57658c2("Frame.Note", 12, 100)
			local mMovie2 = mMovie
			local v30 = nil or total
			mMovie2:__wf_atom_e57658c2("Frame.Note", 0, __wf_atom_104bfe98(-268, 271, v30) + v29 * 1 * 10)
			mMovie:__wf_atom_e57658c2("Frame.Note", 1, fn15(p)) -- inferred equivalent call
			local v31 = nil or total
			v11 = __wf_atom_104bfe98(-268, 271, v31) + v29 * 1 * 10
			v12 = fn15(p) -- inferred equivalent call
			mMovie:__wf_atom_e57658c2("Frame.Note", 5, 30)
			mMovie:__wf_atom_e57658c2("Frame.Note", 6, 30)
			__wf_atom_ec43d06e(mMovie, "Frame.Note", 4, { 5, 6 }, { 66, 66 }, 0.5, 0, function()
				__wf_atom_ec43d06e(mMovie, "Frame.Note", 2, { 12 }, { 0 }, 1, 0)
			end)
			mMovie:__wf_atom_7f57ab2f("Frame.Note", "NoteHoverBurst", 13, false)
			mMovie:__wf_atom_7f57ab2f("Frame.Note", "NoteHover", 13, false)
			mMovie:__wf_atom_7f57ab2f("Frame.Note", "IncorrectNote", 13, true)
			mMovie:__wf_atom_7f57ab2f("Frame.Note", "CorrectNote", 13, false)
			mMovie:__wf_atom_7f57ab2f("Frame.Note", "Button", 13, false)
			__wf_atom_86cbd68d(mMovie, "Frame.Note.swapDepths", 2000)
			fn12("Frame.Note", p)
			v10 = 1
		end

		fn7(fn13(p)) -- inferred equivalent call
	end
end

function Initialize()
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_2dedec1a("Frame.Note", 13, false)
	mMovie:__wf_atom_e57658c2("Frame.Backer", 12, 75)
	mMovie:__wf_atom_50d60589("Title.Text", 36, "")
	v11 = mMovie:__wf_atom_5e6e15c8("Frame", 0)
	v12 = mMovie:__wf_atom_5e6e15c8("Frame", 1)
	mMovie:__wf_atom_2dedec1a("Title", 13, false)
	_T.MusicGameComplete = false
	musicGameAllowedAttempts = _T.MusicGameAllowedAttempts or -1
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local cameraControl = __wf_atom_c4f78a8f:CameraControl()
	cameraControl:__wf_atom_dc7b15db(musicColorGrade, 2, -1, 0, 1)
	WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest")
	local v28 = __wf_atom_c4f78a8f:GetPosition() + Vector(0, 1, 0)
	v15 = gRegion:__wf_atom_f738b4af(Symbol("Statue"), v28, 0, 2)
	v20 = gRegion:__wf_atom_f738b4af(Symbol("ChildDeora"), v28, 0, 20)

	if _T.mDeoraCinematic then
		mDeoraCinematic = _T.mDeoraCinematic
		mDeoraCinematicStartDelta = _T.mDeoraCinematicStartDelta
		mDeoraCinematicEndDelta = _T.mDeoraCinematicEndDelta
	else
		mDeoraCinematic = gRegion:__wf_atom_f738b4af(Symbol("SaveDeoraSoulCin"), v28, 0, 20)
	end

	local activeQuests = module5.GetActiveQuests()

	for _, activeQuest in ipairs(activeQuests) do
		if activeQuest:__wf_atom_1bb5b1ff() ~= WeakResource("/SF/Types/Quests/TCDemoQuest") then
			continue
		end

		local __wf_atom_bb972fd2 = activeQuest:__wf_atom_bb972fd2()

		for _, v29 in ipairs(__wf_atom_bb972fd2) do
			if v29 == Symbol("XTTcxcg/") then
				module4.ReplicateLogEvent("STAG_QUEST", "StartSongPuzzle")
			end
		end
	end

	if __wf_atom_7e8ad928(v15) then
		if _T.MusicFocusTarget then
			local musicFocusTarget = _T.MusicFocusTarget
			position2 = gRegion:GetGameCamera():GetPosition()
			v27 = __wf_atom_fa8d0177(__wf_atom_c4f78a8f:__wf_atom_a2a18137(), musicFocusTarget:__wf_atom_a2a18137())
		elseif __wf_atom_7e8ad928(v20) then
			if _T.BromiusSoulSong then
				v24 = 1
				mDeoraCinematic = gRegion:__wf_atom_0a6a5887(Symbol("SaveBromiusCin"))
				mDeoraCinematicStartDelta = 0.2
			else
				local __wf_atom_dc309f8a = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
				flag = true
				__wf_atom_dc309f8a.heading += 100
				position2 = __wf_atom_c4f78a8f:EyePosition() + Vector(0, -0.35, 0) + __wf_atom_9341614d(
					__wf_atom_c4f78a8f:__wf_atom_a06d543c() * 2.3,
					Rotation(105, 0, 0)
				)
				v27 = __wf_atom_fa8d0177(
					position2,
					__wf_atom_c4f78a8f:EyePosition() + Vector(0, -0.4, 0) + __wf_atom_c4f78a8f:__wf_atom_a06d543c() * 0.79
				)
			end
		else
			local v29 = Distance(v20:GetPosition(), v28)

			if v29 > 30 then
				v20 = nil
				mDeoraCinematic = nil
			elseif v29 < 30 then
				v15 = nil
				v21:__wf_atom_09294a87(__wf_atom_104bfe98(0, 1.3, 0))
				position = v20:GetPosition()
				__wf_atom_c4f78a8f:SetVisibility(false, true)
				v24 = 3
				y = v20:GetPosition().y

				if not __wf_atom_7e8ad928(deoraRoundOneSound) and __wf_atom_7e8ad928(v26) then
					v26 = module2.PlaySound(deoraRoundOneSound)
				end
			end
		end
	else
		local __wf_atom_dc309f8a = v15:__wf_atom_dc309f8a()
		__wf_atom_dc309f8a.heading += 120
		position2 = v15:GetPosition() + __wf_atom_9341614d(Vector(0, 0.5, -2.5), __wf_atom_dc309f8a)
		v27 = __wf_atom_fa8d0177(
			position2,
			__wf_atom_f55d6358(v28, v15:GetPosition() + __wf_atom_9341614d(Vector(-0.8, 0.4, 0), __wf_atom_dc309f8a), 1)
		)

		if _T.SpiritChestMusicGame then
			flag = true
		end
	end

	if __wf_atom_7e8ad928(mDeoraCinematic) then
		if _T.MusicGameCamera then
			position2 = _T.MusicGameCamera:GetPosition()
			v27 = _T.MusicGameCamera:__wf_atom_dc309f8a()
			v8 = gRegion:CreateEntity(cameraSpotType, position2, v27)
			v8:__wf_atom_888efbe9(_T.MusicGameCamera:__wf_atom_c277aed8())
		else
			v8 = gRegion:CreateEntity(cameraSpotType, position2, v27)
		end

		cameraControl:__wf_atom_fd14c463(1)
		cameraControl:SetCameraSpot(v8, 0.5)
	end

	v3 = fn2()
	mMovie:__wf_atom_e57658c2("Frame.Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("Frame", 1, 800)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)

	if __wf_atom_7e8ad928(mDeoraCinematic) then
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 1, 0)
	end

	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = true
	__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
end

function Update()
	local v28 = math.min(__wf_atom_fa1258d0(), 1 / 30)
	mMovie:__wf_atom_88d9cd84(v28)

	if not __wf_atom_7e8ad928(mDeoraCinematic) and mDeoraCinematic:__wf_atom_7d4910e4() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not mDeoraCinematic:__wf_atom_725a3c2c(__wf_atom_c4f78a8f) then
			mMovie:Close()
			fn10()
		end

		if v18 <= 0 then
			v18 = mDeoraCinematic:__wf_atom_239dd8f4()
		end

		if flag2 then
			mDeoraCinematic:__wf_atom_01142e3f(-1)
			mDeoraCinematic:__wf_atom_3b451945(v18)
		else
			if mDeoraCinematic:__wf_atom_1ee2a2df() < mDeoraCinematicStartDelta then
				return
			end

			if v17 > 0 then
				mDeoraCinematic:__wf_atom_3b451945(v18 * __wf_atom_24a82b69(v17))
				v17 = __wf_atom_421b01aa(v17 - v28, 0, 1)
				mDeoraCinematicStartDelta = mDeoraCinematic:__wf_atom_1ee2a2df()

				if v17 <= 0 then
					__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 1, 0)
				else
					return
				end
			end

			v19:Update(v28)
			local __wf_atom_9e368823 = v19:__wf_atom_9e368823()
			local v29 = __wf_atom_104bfe98(mDeoraCinematicStartDelta, mDeoraCinematicEndDelta, __wf_atom_9e368823) + math.abs((Noise(Time() * 0.1))) * 0.005
			mDeoraCinematic:__wf_atom_01142e3f(__wf_atom_421b01aa(v29, 0, 1))
		end
	end

	v10 = __wf_atom_421b01aa(v10 - v28, 0, 1)
	local v29 = Noise(Time()) * 30 * v10 * v10
	local v30 = Noise(Time() + 3.33) * 30 * v10 * v10
	mMovie:__wf_atom_e57658c2("Frame.Note", 0, v11 + v29)
	mMovie:__wf_atom_e57658c2("Frame.Note", 1, v12 + v30)
	local v31 = __wf_atom_7e8ad928(_T.MusicPuzzleTutorialDifficulty) and 1 or 2
	local v32 = not __wf_atom_7e8ad928(_T.MusicPuzzleTutorialSpeed) and 0.9 or 1
	local v33 = total

	if not flag2 then
		total += v28 * 1 * v32 / v2
	end

	if not v13 then
		if flag then
			for i = 1, #v3 do
				if not (v33 <= v3[i][2] and total > v3[i][2]) then
					continue
				end

				fn16(v3[i][1], i)
				break
			end
		elseif not flag2 then
			for i = 1, #v3 do
				if not (v33 <= v3[i][2] and total > v3[i][2]) then
					continue
				end

				local v34 = fn7(fn14(v3[i][1])) -- inferred equivalent call

				if not __wf_atom_7e8ad928(v34) then
					v34:__wf_atom_ff2a5387(-5)
				end
			end
		end
	end

	local v34 = __wf_atom_104bfe98(-268, 271, total)
	mMovie:__wf_atom_e57658c2("Frame.Time", 0, v34)

	for i = 1, #v3 do
		local v35 = math.abs(v3[i][2] - total)

		if v35 < v31 * 0.06 then
			mMovie:__wf_atom_7f57ab2f(v4[i], "NoteHover", 13, true)
			mMovie:__wf_atom_4c1c1986(v4[i], "NoteHover", 12, (1 - v35 / (v31 * 0.06)) * 100)
		else
			mMovie:__wf_atom_7f57ab2f(v4[i], "NoteHover", 13, false)
		end
	end

	if total >= 1.1 then
		total = -0.112
		flag = false

		for _, v35 in pairs(v4) do
			mMovie:__wf_atom_7f57ab2f(v35, "NoteHoverBurst", 13, false)
			mMovie:__wf_atom_7f57ab2f(v35, "NoteHover", 13, false)
			mMovie:__wf_atom_7f57ab2f(v35, "IncorrectNote", 13, false)
			mMovie:__wf_atom_7f57ab2f(v35, "CorrectNote", 13, false)
			mMovie:__wf_atom_7f57ab2f(v35, "PerfectNote", 13, false)
			mMovie:__wf_atom_7f57ab2f(v35, "NoteHoverBurst", 13, false)
		end

		if count5 >= 1 then
			count4 += 1

			if musicGameAllowedAttempts >= 0 and count4 == musicGameAllowedAttempts then
				EndMusicGame(false)
			else
				count5 = 0
			end
		end

		if not flag2 and count >= 1 then
			fn9()
		end
	end

	if v7 > 0 then
		v7 = math.max(0, v7 - v28)
		mMovie:__wf_atom_e57658c2("_root", 12, v7 / 3 * 100)

		if v7 <= 0 then
			if _T.MusicCompleteCallback then
				_T.MusicCompleteCallback()
			end

			mMovie:Close()
			return
		end
	end

	if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(statueRepairAnim)) then
		if not v14 then
			v15:__wf_atom_921c1a5f(statueRepairAnim, false, true, 0)
			v15:__wf_atom_3322b766(0, 0.0001)
			v14 = true
		end

		local v35 = count / #v3 * (1 / v24)
		local v36 = flag2 and 1 or v35
		v9:__wf_atom_09294a87(v36)
		v9:Update(v28)
		local v37 = __wf_atom_421b01aa(Noise(Time() * 2) * 0.2 * v36, 0, 1)
		v15:__wf_atom_9e6bceb0(0, __wf_atom_104bfe98(0, 0.4, v37 + v9:__wf_atom_9e368823()))
	end

	if not __wf_atom_7e8ad928(v20) and __wf_atom_7e8ad928(mDeoraCinematic) then
		v21:Update(v28)
		local position3 = v20:GetPosition()
		position3.y = y + v21:__wf_atom_9e368823()
		v20:SetPosition(position3)
		local v35 = (position3.y - y - 0) / 1.3

		if not __wf_atom_7e8ad928(v8) then
			local v36 = __wf_atom_fa8d0177(v8:GetPosition(), position3 + Vector(0, 0.75, 0))
			v8:__wf_atom_888efbe9(__wf_atom_104bfe98(20, 35, v35))
			v8:__wf_atom_9b788a35(v36)
			v8:__wf_atom_74d17eae(0.3, v22 * 2 + 1)
			v22 = __wf_atom_421b01aa(v22 - v28 * 0.334, 0, 1)
			v8:__wf_atom_7e990320(__wf_atom_104bfe98(0, 10, __wf_atom_421b01aa(v35 * 5, 0, 1)))
		end
	end
end

function Shutdown()
	_T.MusicGameMidiOverride = nil
	_T.MusicGameForceCompletion = nil
end

function OnGamepadTransition(_)
	local v28 = 1
	local v29 = "Frame.Note" .. tostring(v28 - 1)

	while mMovie:__wf_atom_253d7085(v29) do
		fn12(v29, v3[v28][1])
		v28 += 1
		v29 = "Frame.Note" .. tostring(v28 - 1)
	end
end

function EndMusicGame(p)
	v13 = p == "true"
	count3 = 0
	musicGameAllowedAttempts = 0
	fn9()

	if not __wf_atom_7e8ad928(mDeoraCinematic) and mDeoraCinematic:__wf_atom_7d4910e4() then
		mDeoraCinematic:Skip()
	end

	if not __wf_atom_7e8ad928(v20) then
		v20:SetPosition(position)
	end

	fn10()
end

function onKeyDown_MENU_CANCEL()
	if
		not __wf_atom_7e8ad928(mDeoraCinematic) and mDeoraCinematic:__wf_atom_7d4910e4()
		or (forceCompletion or _T.MusicGameForceCompletion)
	then
		return false
	end

	EndMusicGame()
	return true
end

function onKeyDown_SHAWZIN_EXIT()
	if
		not __wf_atom_7e8ad928(mDeoraCinematic) and mDeoraCinematic:__wf_atom_7d4910e4()
		or (forceCompletion or _T.MusicGameForceCompletion)
	then
		return false
	end

	EndMusicGame()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_0()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_1()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_2()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_3()
	return true
end

function onKeyDown_SHAWZIN_NOTE_1()
	fn17(1, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_1()
	fn17(1, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_2()
	fn17(2, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_2()
	fn17(2, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_3()
	fn17(3, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_3()
	fn17(3, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_4()
	fn17(4, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_4()
	fn17(4, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_5()
	fn17(5, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_5()
	fn17(5, false)
	return true
end