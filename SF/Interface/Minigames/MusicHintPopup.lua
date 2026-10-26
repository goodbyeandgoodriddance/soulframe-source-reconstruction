local module = require("SF.Interface.Libs.MusicCommon")
local module2 = require("EE.Interface.Utilities")
local v = 5
local v2 = nil
local v3 = false
local v4 = nil
local v5 = nil
local musicHintNote = nil

local function fn(musicHintMidi)
	local result = {}
	Resource(musicHintMidi:__wf_atom_1bb5b1ff())
	v = musicHintMidi:__wf_atom_1e34340d()
	local __wf_atom_b17a4143 = musicHintMidi:__wf_atom_b17a4143()

	for i = 1, #__wf_atom_b17a4143 do
		local v6 = __wf_atom_b17a4143[i]
		local note = v6.note
		local start = v6.start
		table.insert(result, { module.MidiNoteToInstrumentSoundIndex(note), start / v })
	end

	return result
end

local function fn2(p, list)
	local v6 = 54 + 27 * (1 - list[1])
	local v7 = __wf_atom_104bfe98(-268, 270, list[2])
	mMovie:__wf_atom_e57658c2(p, 0, v7)
	mMovie:__wf_atom_e57658c2(p, 1, v6)
	mMovie:__wf_atom_e57658c2(p, 5, 70)
	mMovie:__wf_atom_e57658c2(p, 6, 70)
	mMovie:__wf_atom_7f57ab2f(p, "NoteHoverBurst", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "NoteHover", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "IncorrectNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "PerfectNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "CorrectNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "NeutralNote", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "Callout", 13, false)
	mMovie:OverrideMaterial(p .. ".GoldHighlight", wavyMaterial)
	mMovie:__wf_atom_e57658c2(p .. ".GoldHighlight", 12, 0)
	mMovie:__wf_atom_e57658c2(p, 12, 90)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v4, true, {}, true)
	mMovie:__wf_atom_48bd5a59(p, "Callout.Tf", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_7f57ab2f(p, "Callout", 13, true)
end

local function fn3(musicHintNote2, p, p2)
	mMovie:OverrideMaterial("Frame.ProgressIndicator.Line", dividerMaterial)
	mMovie:__wf_atom_1ca72041("Frame.ProgressIndicator.Line", "VisibilitySize", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Frame.ProgressIndicator.Line", "VisibilityFadeSize", 0, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("Frame.ProgressIndicator.Line", 12, 80)

	for i = 1, p2 do
		local v6 = "Pip" .. i
		__wf_atom_86cbd68d(mMovie, "Frame.ProgressIndicator.Pip.duplicateMovieClip", v6, i + 1050)
		local v7 = __wf_atom_104bfe98(-65, 65, (i - 1) / (p2 - 1))
		mMovie:__wf_atom_4c1c1986("Frame.ProgressIndicator", v6, 0, v7)
		mMovie:__wf_atom_7f57ab2f("Frame.ProgressIndicator", v6 .. ".Fill", 13, i <= p)
		mMovie:__wf_atom_4c1c1986("Frame.ProgressIndicator", v6 .. ".Backer", 12, 70)

		if i ~= musicHintNote2 or __wf_atom_7e8ad928(_T.MusicHintNote) then
			continue
		end

		mMovie:__wf_atom_4c1c1986("Frame.ProgressIndicator", v6 .. ".Fill", 12, 0)
	end

	mMovie:__wf_atom_7f57ab2f("Frame.ProgressIndicator", "Pip", 13, false)
end

local function fn4(list)
	if not _T.MusicHintNotesDiscovered then
		return
	end

	for i = 1, #list do
		local v6 = not __wf_atom_7e8ad928(_T.MusicHintNotesDiscovered[i])
		local v7 = "Frame.Note" .. i
		mMovie:__wf_atom_2dedec1a(v7, 13, v6)
	end
end

local function fn5(list)
	for i = 1, #list do
		local v6 = "Note" .. i
		__wf_atom_86cbd68d(mMovie, "Frame.Note.duplicateMovieClip", v6, i + 1001)
		fn2("Frame." .. v6, list[i])
	end

	fn4(list)
	mMovie:__wf_atom_2dedec1a("Frame.Note", 13, false)
end

local function fn6()
	if __wf_atom_7e8ad928(musicHintNote) then
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.4, 0.2, function()
			if v3 then
				module2.PlaySound(notEnoughNotesSound)
			end
		end)
	else
		local v6 = "Frame.Note" .. musicHintNote
		mMovie:__wf_atom_e57658c2(v6 .. ".GoldHighlight", 12, 100)
		mMovie:__wf_atom_e57658c2(v6, 5, 100)
		mMovie:__wf_atom_e57658c2(v6, 6, 100)
		__wf_atom_ec43d06e(mMovie, v6, 8, { 12 }, { 100 }, 1.1)

		if not __wf_atom_7e8ad928(_T.MusicHintNote) then
			__wf_atom_ec43d06e(
				mMovie,
				"Frame.ProgressIndicator.Pip" .. musicHintNote .. ".Fill",
				8,
				{ 12 },
				{ 100 },
				1.1,
				1
			)
		end

		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.4, 0.2, function()
			module2.CreateUIParticles(mMovie, v6, highlightFx, nil, 0, nil, nil, nil, nil, true)
			__wf_atom_ec43d06e(mMovie, v6 .. ".GoldHighlight", 8, { 12 }, { 100 }, 0.8)
		end)
	end

	__wf_atom_ec43d06e(mMovie, "close", 8, {}, {}, 0, 4.4, function()
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.6, 0, function()
			mMovie:Close()
		end)
	end)
end

function Initialize()
	local musicHintMidi = Resource("/SF/Music/PlayerInstrument/Midi/BromiusQuest.mid")

	if not __wf_atom_7e8ad928(_T.MusicHintMidi) then
		musicHintMidi = _T.MusicHintMidi
	end

	if not __wf_atom_7e8ad928(_T.MusicHintNote) then
		musicHintNote = _T.MusicHintNote
	end

	v4 = "<TREE_SPEAK>"
	mMovie:__wf_atom_2dedec1a("Frame.Time", 13, false)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Frame", 0, 960)
	mMovie:__wf_atom_e57658c2("Frame", 1, 740)
	mMovie:__wf_atom_e57658c2("Frame.BackerLines", 12, 50)
	mMovie:__wf_atom_2dedec1a("Frame.HighlightShadow", 13, true)
	mMovie:__wf_atom_e57658c2("Frame.HighlightShadow", 0, 0)
	mMovie:__wf_atom_e57658c2("Frame.HighlightShadow", 1, 0)
	mMovie:__wf_atom_e57658c2("Frame.HighlightShadow", 12, 80)
	mMovie:__wf_atom_e57658c2("Frame.HighlightShadow", 14, 2712)
	mMovie:__wf_atom_e57658c2("Frame.HighlightShadow", 15, 712)
	v5 = fn(musicHintMidi)
	fn5(v5)
	v2 = 0

	if _T.MusicHintNotesDiscovered then
		for _ in pairs(_T.MusicHintNotesDiscovered) do
			v2 += 1
		end
	end

	fn3(musicHintNote, v2, #v5)
	v3 = v2 < #v5
	local v6 = __wf_atom_7e8ad928(_T.MusicHintDelay) and 0 or _T.MusicHintDelay
	__wf_atom_ec43d06e(mMovie, "close", 8, {}, {}, 0, v6, function()
		fn6()
	end)
end

function Update()
	local v6 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v6)
end

function Shutdown()
	_T.MusicHintDelay = nil
	_T.MusicHintNote = nil
end