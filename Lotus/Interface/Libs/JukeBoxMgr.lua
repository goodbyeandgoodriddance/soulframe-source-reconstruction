module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local module3 = require("Lotus.Interface.SequencerUtilities")
local result = nil
local v = nil
local flag = false
local count = 0
local v2 = 0
local v3 = nil
local v4 = false
local v5 = nil
local v6 = false
local v7 = false
local v8 = {}
local v9 = false
LM_NONE = 0
LM_LOOP = 1
LM_LOOPONE = 2
local LM_LOOP2 = LM_LOOP
local v10 = 0
local v11 = 0
local v12 = nil
local v13 = {}
local v14 = 1
local v15 = Range(__wf_atom_deb1202b(-50), __wf_atom_deb1202b(0))
local v16 = 0
local v17 = 1
local v18 = 1
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = Resource("/Lotus/Fx/Levels/Hub/OperatorQuarters/JukeboxSequencerDeco")
local v23 = nil
local v24 = {}
local rounded = 0
local v25 = 0
local v26 = {
	Symbol("SoundValues0"),
	Symbol("SoundValues1"),
	Symbol("SoundValues2"),
	Symbol("SoundValues3"),
	Symbol("SoundValues4")
}
local v27 = { 0, 0, 0, 0 }
local v28 = Range(0, 1)

local function fn(data, data2)
	if data.Locked ~= data2.Locked then
		return data2.Locked
	end

	if data.Fingerprint == nil and data2.Fingerprint ~= nil or data.Fingerprint ~= nil and data2.Fingerprint == nil then
		return data2.Fingerprint ~= nil
	end

	return data.Name < data2.Name
end

function GetSongs()
	if flag then
		return result
	end

	return nil
end

local function fn2()
	local entity = module.GetEntityFromTag("Jukebox")

	if __wf_atom_7e8ad928(entity) then
		return
	end

	v23 = module.GetEntityFromTag("JUKEBOX_SEQUENCER")

	if __wf_atom_7e8ad928(v23) then
		v23 = gRegion:CreateEntity(v22, entity:GetPosition() + Vector(0, 0.035, 0), Rotation(-90, 0, 0))
		v23:__wf_atom_b811702e(Symbol("JUKEBOX_SEQUENCER"))
		v23:SetMeshScale(3.5)
	end
end

local function fn3() -- 4 equivalent calls inferred from this helper
	return v5 ~= nil and v5 <= #result and result[v5].Fingerprint ~= nil
end

function IsPlayingStepSequencer()
	return fn3() -- inferred equivalent call
end

function GetCurrentStepSequencer()
	if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
		return v12.StepSequencer
	end

	return nil
end

function GetStepSequencerDelta()
	if v10 > 0 then
		return (math.min(v11 / v10, 1))
	end

	return 0
end

local function fn4(p)
	if __wf_atom_7e8ad928(v3) then
		local stepSequencer

		if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
			stepSequencer = v12.StepSequencer
		end

		if not __wf_atom_7e8ad928(stepSequencer) then
			stepSequencer:SetPaused(p)

			if not __wf_atom_7e8ad928(v21) then
				v21:__wf_atom_e8c1db20(module.Ternary(p, "", result[v5].MongoId))
			end

			v4 = p
		end
	elseif p then
		v3:Pause()

		if not __wf_atom_7e8ad928(v21) then
			v21:__wf_atom_84de3437(nil)
		end

		v4 = true
	else
		v3:Resume()

		if not __wf_atom_7e8ad928(v21) then
			v21:__wf_atom_84de3437(result[v5].Song)
		end

		v4 = false
	end
end

local function fn5(stepSequencer)
	local v29 = __wf_atom_309179eb(v15:__wf_atom_48a8e71b(v17 * v18))

	for i = 0, 3 - 1 do
		stepSequencer:__wf_atom_4a8c303d(i, v29)
	end
end

local function fn6(p, p2)
	if __wf_atom_7e8ad928(v3) then
		if fn3() then -- inferred equivalent call
			local stepSequencer

			if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
				stepSequencer = v12.StepSequencer
			end

			if not __wf_atom_7e8ad928(stepSequencer) then
				stepSequencer:SetPaused(true)
			end
		end
	else
		v3:Stop(true)
		v3 = nil
	end

	v5 = nil
	v10 = 0
	v11 = 0
	v4 = false

	if p ~= nil and p <= #result then
		v5 = p
		local v29 = result[p]

		if v29.Fingerprint == nil then
			local song = result[p].Song
			v3 = module.PlaySound(song)
			print("Jukebox: Playing song " .. p .. ", started = " .. tostring(not __wf_atom_7e8ad928(v3)))

			if not __wf_atom_7e8ad928(v3) then
				if v7 and not v4 then
					fn4(true)
				end

				v3:__wf_atom_ff2a5387(v16)

				if not __wf_atom_7e8ad928(v21) then
					v21:__wf_atom_84de3437(song)
					v21:__wf_atom_e8c1db20("")
				end

				if not p2 and p ~= v13[1] then
					table.insert(v13, 1, p)

					if #v13 > 500 then
						table.remove(v13, 501)
					end

					v14 = 1
				end
			end
		else
			if v12 == nil then
				v12 = module3.CreateStepSequencerLoader()
			end

			module3.ResLoadNotePacks(v12, v29.NotePacks, v29.Fingerprint)
			print("Jukebox: Playing mandachord song " .. p .. ", started = " .. tostring(not __wf_atom_7e8ad928(v3)))

			if not __wf_atom_7e8ad928(v21) then
				v21:__wf_atom_84de3437(nil)
				v21:__wf_atom_e8c1db20(v29.MongoId)
			end

			if not p2 and p ~= v13[1] then
				table.insert(v13, 1, p)

				if #v13 > 500 then
					table.remove(v13, 501)
				end

				v14 = 1
			end
		end

		v6 = true

		if not __wf_atom_7e8ad928(v19) and (not __wf_atom_7e8ad928(v3) or v29.Fingerprint ~= nil) then
			v19(v29, v3)
		end
	end
end

function PlaySong(p)
	fn6(p)
end

local function fn7()
	v8 = {}

	for i = 1, v2 do
		if __wf_atom_7e8ad928(result[i]) or not result[i].AutoplayEnabled then
			continue
		end

		table.insert(v8, i)
	end
end

function IsShuffleMode()
	return v9
end

function ToggleShuffleMode()
	v9 = not v9

	if not __wf_atom_7e8ad928(v21) then
		v21:__wf_atom_6f2d0fd5(v9)
	end
end

function GetLoopMode()
	return LM_LOOP2
end

function ToggleLoopMode()
	LM_LOOP2 = (LM_LOOP2 + 1) % 3

	if not __wf_atom_7e8ad928(v21) then
		local ternary = module.Ternary(LM_LOOP2 == LM_NONE, 0, module.Ternary(LM_LOOP2 == LM_LOOPONE, 2, 1))
		v21:__wf_atom_1d7eceba(ternary)
	end
end

local function fn8(p)
	if v2 == 0 then
		return
	end

	local scrollIndex = nil
	local v29 = false

	if v14 > 1 then
		v14 -= 1
		scrollIndex = v13[v14]
		v29 = true
	elseif #v8 > 0 then
		if v9 then
			scrollIndex = v8[math.random(#v8)]
		else
			local v30 = nil

			if v5 == nil then
				if p == nil then
					scrollIndex = v8[1]
				else
					v30 = p
				end
			else
				v30 = v5
			end

			if v30 ~= nil then
				scrollIndex = v8[1]

				for i = 2, #v8 do
					if not (v30 < v8[i]) then
						continue
					end

					scrollIndex = v8[i]
					break
				end
			end
		end
	end

	if scrollIndex ~= nil and result[scrollIndex] ~= nil then
		_T.Jukebox.ScrollIndex = scrollIndex
		fn6(scrollIndex, v29)
	end
end

function PlayNextSong(p)
	fn8(p)
end

function PlayPreviousSong()
	if v2 == 0 then
		return
	end

	if v14 < 500 and v14 < #v13 then
		v14 += 1
		local scrollIndex = v13[v14]

		if scrollIndex ~= nil then
			_T.Jukebox.ScrollIndex = scrollIndex
			fn6(scrollIndex, true)
		end
	end
end

function ToggleSong(p)
	if result == nil or result[p].Locked then
		return
	end

	if v5 == p and (not __wf_atom_7e8ad928(v3) or result[p].Fingerprint ~= nil) then
		fn4(not v4)
	else
		fn6(p)
	end
end

function StopCurrentSong()
	if not __wf_atom_7e8ad928(v3) then
		v3:Stop(true)
		return
	end

	local stepSequencer

	if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
		stepSequencer = v12.StepSequencer
	end

	if not __wf_atom_7e8ad928(stepSequencer) then
		stepSequencer:SetPaused(true)
		v11 = v10
	end
end

function GetPlayingSongIndex()
	return v5
end

function GetPlayingSongInstance()
	return v3
end

function IsSongPaused()
	return v4
end

function IsSongLocked(p)
	return result[p] == nil or result[p].Locked
end

function SetSongStartCallback(p)
	v19 = p
end

function SetSongEndCallback(p)
	v20 = p
end

function SetVolume(p)
	v17 = p
	v16 = __wf_atom_309179eb(v15:__wf_atom_48a8e71b(p))

	if not __wf_atom_7e8ad928(v21) then
		v21:__wf_atom_f3782e0e(p)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_ff2a5387(v16)
	end

	local stepSequencer

	if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
		stepSequencer = v12.StepSequencer
	end

	if not __wf_atom_7e8ad928(stepSequencer) then
		fn5(stepSequencer)
	end
end

function GetVolume()
	return (v15:__wf_atom_b636405b(v15:__wf_atom_421b01aa((__wf_atom_deb1202b(v16)))))
end

local function fn9()
	if __wf_atom_7e8ad928(v23) then
		return
	end

	v25 += __wf_atom_fa1258d0()

	if not (v25 > 0.016) then
		return
	end

	v25 -= 0.016
	local v29 = 0

	if not v4 then
		if __wf_atom_7e8ad928(v3) then
			local stepSequencer

			if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
				stepSequencer = v12.StepSequencer
			end

			if not __wf_atom_7e8ad928(stepSequencer) then
				v29 = stepSequencer:__wf_atom_28288912() * 0.2
			end
		else
			v29 = v3:__wf_atom_31aab74c()
		end
	end

	if not (__wf_atom_7e8ad928(v3) or v4) then
		v29 = v3:__wf_atom_31aab74c()
	end

	local v30 = __wf_atom_421b01aa((v29 - v28.minValue) / (v28.maxValue - v28.minValue), 0, 1)

	for i = rounded, 2, -1 do
		v24[i] = v24[i - 1]
	end

	v24[1] = math.pow(v30, 0.75)

	if not __wf_atom_7e8ad928(v23) then
		for i = 1, 5 do
			for j = 1, 4 do
				if v4 then
					v27[j] = 0.3
				else
					local v31 = (i - 1) * 4 + j

					if v31 <= #v24 then
						v27[j] = v24[v31]
					else
						v27[j] = 0
					end
				end
			end

			v23:SetMaterialParam(v26[i], v27[1], v27[2], v27[3], v27[4])
		end
	end
end

function UpdateJukeBox()
	if not flag and not __wf_atom_7e8ad928(v) and v:__wf_atom_86399a47() then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local v29 = nil
		local v30 = nil
		local v31 = nil

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			v21 = __wf_atom_18a5d83b:Settings()

			if not __wf_atom_7e8ad928(v21) then
				v29 = v21:__wf_atom_f876c97b()
				v30 = v21:__wf_atom_9ff89e69()
				v17 = v21:__wf_atom_04612704()
				v16 = __wf_atom_309179eb(v15:__wf_atom_48a8e71b(v17))
				v18 = v21:__wf_atom_2a43fe87()
			end
		end

		table.sort(result, fn)
		local v32, v33

		if __wf_atom_7e8ad928(v21) then
			v32 = {}
			v33 = {}
		else
			v33 = v21:__wf_atom_3102916e()
			v32 = v21:__wf_atom_030b0610()
		end

		for i = 1, #result do
			if result[i].Locked then
				continue
			end

			if
				v31 == nil and not __wf_atom_7e8ad928(v29) and result[i].Song == v29
				or v30 ~= nil and result[i].MongoId == v30
			then
				v31 = i
			end

			if __wf_atom_7e8ad928(result[i].Song) then
				if result[i].MongoId ~= nil then
					for j = 1, #v32 do
						if v32[j] ~= result[i].MongoId then
							continue
						end

						result[i].AutoplayEnabled = false
						break
					end
				end
			else
				result[i].Song = Resource(result[i].Song)

				for j = 1, #v33 do
					if not v33[j]:IsA(result[i].Song) then
						continue
					end

					result[i].AutoplayEnabled = false
					break
				end
			end
		end

		flag = true

		if v31 ~= nil then
			fn6(v31)
		end

		if not __wf_atom_7e8ad928(v21) then
			local __wf_atom_8e96b4db = v21:__wf_atom_8e96b4db()
			LM_LOOP2 = module.Ternary(
				__wf_atom_8e96b4db == 0,
				LM_NONE,
				module.Ternary(__wf_atom_8e96b4db == 2, LM_LOOPONE, LM_LOOP)
			)

			if v21:__wf_atom_cc158257() then
				v9 = not v9

				if not __wf_atom_7e8ad928(v21) then
					v21:__wf_atom_6f2d0fd5(v9)
				end
			end
		end

		fn7()
	end

	if flag then
		if v6 and __wf_atom_7e8ad928(v3) then
			local v29 = true

			if fn3() then -- inferred equivalent call
				if v10 > 0 then
					if not v4 then
						v11 += __wf_atom_fa1258d0()
					end

					v29 = v10 <= v11
				else
					v29 = false
				end
			end

			if v29 then
				if not __wf_atom_7e8ad928(v20) then
					v20(false)
				end

				if not (__wf_atom_7e8ad928(gGameRules) or gGameRules:__wf_atom_c2f94cbd()) then
					if LM_LOOP2 == LM_LOOP then
						fn8()
					elseif LM_LOOP2 == LM_LOOPONE and v5 ~= nil then
						fn6(v5, true)
					else
						local stepSequencer

						if
							fn3
							and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer))
						then
							stepSequencer = v12.StepSequencer
						end

						if not __wf_atom_7e8ad928(stepSequencer) then
							stepSequencer:SetPaused(true)
						end

						v5 = nil
					end
				end
			end
		end

		if module3.UpdateStepSequencer(v12) then
			v12.StepSequencer:__wf_atom_b811702e(Symbol("JukeboxSequencer"))
			fn5(v12.StepSequencer)
			v10 = v12.StepSequencer:__wf_atom_eeab2580(false) * 10

			if v7 and not v4 or v4 then
				fn4(true)
			end
		end
	end

	fn9()
end

function ToggleAutoplaySong(p, autoplayEnabled)
	if #result < p then
		return
	end

	if autoplayEnabled == nil then
		autoplayEnabled = not result[p].AutoplayEnabled
	end

	result[p].AutoplayEnabled = autoplayEnabled

	if autoplayEnabled then
		table.insert(v8, p)
		table.sort(v8, function(a, b)
			return a < b
		end)
	else
		for i = 1, #v8 do
			if v8[i] ~= p then
				continue
			end

			table.remove(v8, i)
			return
		end
	end
end

function SaveAutoplaySettings()
	local songs = {}
	local mongoIds = {}

	for i = 1, #result do
		if result[i].MongoId == nil then
			if not result[i].AutoplayEnabled then
				table.insert(songs, result[i].Song)
			end
		elseif not result[i].AutoplayEnabled then
			table.insert(mongoIds, result[i].MongoId)
		end
	end

	if not __wf_atom_7e8ad928(v21) then
		v21:__wf_atom_92dbd2f6(songs)
		v21:__wf_atom_ed12f588(mongoIds)
	end
end

function RefreshStepSequencers(object)
	if _T.Jukebox ~= nil then
		local mongoId = nil

		for i = #result, 1, -1 do
			if result[i].Fingerprint == nil then
				continue
			end

			if v5 == i then
				mongoId = result[i].MongoId
			end

			table.remove(result, i)
		end

		v2 = count
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				local stepSequencers = __wf_atom_9be88b01:GetInventory():GetStepSequencers()
				local v29 = __wf_atom_7e8ad928(v21) and {} or v21:__wf_atom_030b0610()

				for i = 1, #stepSequencers do
					local stepSequencer = stepSequencers[i]
					local mName = stepSequencer.mName

					if mName == nil or mName == "" then
						mName = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSong", false, {
							INDEX = i
						})
					end

					local notePacks = {}

					for j = 0, 3 - 1 do
						table.insert(notePacks, {
							NoteType = j,
							NotePack = stepSequencer:__wf_atom_b07e7819(j)
						})
					end

					local mId = stepSequencer.mItemId.mId
					local autoplayEnabled = true

					for j = 1, #v29 do
						if mId ~= v29[j] then
							continue
						end

						autoplayEnabled = false
						break
					end

					table.insert(result, {
						Name = mName,
						Progress = 4,
						Required = 4,
						Locked = false,
						Fingerprint = stepSequencer.mFingerPrint,
						NotePacks = notePacks,
						MongoId = mId,
						AutoplayEnabled = autoplayEnabled
					})
				end

				v2 += #stepSequencers
				table.sort(result, fn)

				if mongoId then
					for i = #result, 1, -1 do
						if result[i].MongoId ~= mongoId then
							continue
						end

						local v30 = v4
						fn6(i)

						if not v30 then
							break
						end

						v4 = v30
						return
					end
				end
			end
		end
	end
end

function Initialize(object, object2)
	if _T.Jukebox == nil then
		_T.Jukebox = {}
	end

	local v29 = __wf_atom_72884638("LotusGameRules.UnlockJukebox")

	if result == nil and not __wf_atom_7e8ad928(object) then
		local __wf_atom_b4650026 = object:__wf_atom_d2b2176d():__wf_atom_b4650026()
		local v30 = {}
		result = {}

		for i = 1, #__wf_atom_b4650026 do
			local v31 = Resource(__wf_atom_b4650026[i].mItemType)

			if __wf_atom_b4650026[i].mRegion == "" then
				__wf_atom_b4650026[i].mRegion = v31:__wf_atom_22e8d9b1()
			end

			result[i] = {
				Tag = tostring(v31:__wf_atom_014a76a2()),
				Song = v31:__wf_atom_af868460(),
				RegionLocName = __wf_atom_b4650026[i].mRegion,
				Progress = __wf_atom_b4650026[i].mItemCount,
				Required = v31:__wf_atom_3563f9c2(),
				Locked = false,
				AutoplayEnabled = true
			}

			if v29 then
				result[i].Progress = result[i].Required
			end

			if result[i].Progress >= result[i].Required then
				count += 1
				v30[count] = result[i].Song:__wf_atom_5b41f63b()
				result[i].Name = Localize(result[i].Tag, nil)
			else
				result[i].Locked = true
				result[i].Name = object2:__wf_atom_8e9ac384("/Lotus/Language/Menu/Jukebox_Undiscovered_Track", true, {
					REGION = Localize(__wf_atom_b4650026[i].mRegion, nil)
				})
			end
		end

		v2 = count
		v = UISys.__wf_atom_c0dbe47c(v30)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				local stepSequencers = __wf_atom_9be88b01:GetInventory():GetStepSequencers()

				for i = 1, #stepSequencers do
					local stepSequencer = stepSequencers[i]
					local mName = stepSequencer.mName

					if mName == nil or mName == "" then
						mName = object2:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSong", false, {
							INDEX = i
						})
					end

					local notePacks = {}

					for j = 0, 3 - 1 do
						table.insert(notePacks, {
							NoteType = j,
							NotePack = stepSequencer:__wf_atom_b07e7819(j)
						})
					end

					table.insert(result, {
						Name = mName,
						Progress = 4,
						Required = 4,
						Locked = false,
						Fingerprint = stepSequencer.mFingerPrint,
						NotePacks = notePacks,
						MongoId = stepSequencer.mItemId.mId,
						AutoplayEnabled = true
					})
				end

				v2 += #stepSequencers
			end
		end
	end

	rounded = module.Round(21.5)

	for i = 1, rounded do
		v24[i] = 0
	end

	fn2()
end

function OnIconCacheFlushed(object)
	for i = 1, #result do
		if result[i].Locked then
			result[i].Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Jukebox_Undiscovered_Track", true, {
				REGION = Localize(result[i].RegionLocName, nil)
			})
		end
	end
end

function OnProfileSaved()
	if not __wf_atom_7e8ad928(v21) then
		v18 = v21:__wf_atom_2a43fe87()
		local stepSequencer

		if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
			stepSequencer = v12.StepSequencer
		end

		if not __wf_atom_7e8ad928(stepSequencer) then
			fn5(stepSequencer)
		end
	end
end

function SetSequencerFxEntity(p)
	v23 = p
end

function UpdateSequencerColor()
	if not __wf_atom_7e8ad928(v23) then
		local mEnergyColor = Color(212, 227, 255, 255)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				local mShipInterior = __wf_atom_9be88b01:__wf_atom_247a5d2e(gRegion:IsMaster()).mShipInterior

				if not __wf_atom_7e8ad928(mShipInterior) then
					mEnergyColor = mShipInterior.mColors.mEnergyColor
				end
			end
		end

		v23:SetMaterialParam(
			Symbol("TintColor"),
			mEnergyColor.red / 255,
			mEnergyColor.green / 255,
			mEnergyColor.blue / 255,
			1
		)
		module2.ApplyHighLow(v23, mEnergyColor)
		v23:SetMaterialParam(
			Symbol("EmissiveTintColorHi"),
			mEnergyColor.red / 255,
			mEnergyColor.green / 255,
			mEnergyColor.blue / 255,
			1
		)
		v23:SetMaterialParam(
			Symbol("EmissiveTintColorLo"),
			mEnergyColor.red / 255,
			mEnergyColor.green / 255,
			mEnergyColor.blue / 255,
			1
		)
	end
end

function SetSuppressed(p)
	v7 = p

	if v7 then
		if __wf_atom_7e8ad928(v3) then
			if fn3() and not v4 then -- inferred equivalent call
				fn4(true)
			end
		elseif not v4 then
			fn4(true)
		end
	end
end

function Reset()
	if __wf_atom_7e8ad928(v3) then
		local stepSequencer

		if fn3 and not (__wf_atom_7e8ad928(v12) or v12.IsLoading or __wf_atom_7e8ad928(v12.StepSequencer)) then
			stepSequencer = v12.StepSequencer
		end

		if not __wf_atom_7e8ad928(stepSequencer) then
			stepSequencer:SetPaused(true)
			v11 = v10
		end
	else
		v3:Stop(true)
	end

	result = nil
	v = nil
	flag = false
	count = 0
	v2 = 0
	v3 = nil
	v4 = false
	v5 = nil
	v6 = false
	v10 = 0
	v11 = 0
	v9 = false
	v8 = {}
	v19 = nil
	v20 = nil
end