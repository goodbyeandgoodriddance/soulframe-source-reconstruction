local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")

function FadeInIntro()
	_T.WarsongTitleCardActive = true
	__wf_atom_ec43d06e(mMovie, "Intro.MainText", 8, { 12 }, { 90 }, 2, 0.01, FadeOutIntro)
end

function FadeOutIntro()
	__wf_atom_ec43d06e(mMovie, "Intro", 8, { 12 }, { 0 }, 0.7, introHoldDuration, FadeInTitle)
end

function FadeInTitle()
	__wf_atom_ec43d06e(mMovie, "Title.MainText", 8, { 12 }, { 90 }, 2, timeBetweenIntroAndTitle, FadeOutTitle)
end

function FadeOutTitle()
	__wf_atom_ec43d06e(mMovie, "Title.MainText", 8, { 12 }, { 0 }, 0.7, titleHoldDuration, FadeInWarsongs)
end

function FadeInWarsongs()
	__wf_atom_ec43d06e(mMovie, "Warsongs", 2, { 12 }, { 100 }, timeBetweenTitleAndWarsongs, 0.2)

	if not __wf_atom_7e8ad928(titleCardSound) then
		module.PlaySound(titleCardSound)
	end

	_T.WarsongTitleCardActive = nil
	__wf_atom_86cbd68d(mMovie, "Warsongs.gotoAndPlay", 1)
end

function CloseTitlecard()
	module2.DissolveOutAndClose(mMovie)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Intro.MainText", 44, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("Intro.SubtitleText", 44, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("Title.MainText", 44, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("Title.SubtitleText", 44, _G.UIColor_White)
	mMovie:__wf_atom_50d60589(
		"Intro.MainText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/WarsongIntro", false)
	)
	mMovie:__wf_atom_50d60589(
		"Title.MainText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/WarsongSubtitle", false)
	)
	mMovie:__wf_atom_50d60589(
		"Title.SubtitleText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/WarsongQuestTitle", false)
	)
	mMovie:__wf_atom_e57658c2("Title.MainText", 12, 0)
	mMovie:__wf_atom_e57658c2("Title.SubtitleText", 12, 0)
	mMovie:__wf_atom_e57658c2("Intro.MainText", 12, 0)
	mMovie:__wf_atom_e57658c2("Intro.SubtitleText", 12, 0)
	mMovie:__wf_atom_e57658c2("Warsongs", 12, 0)
	__wf_atom_86cbd68d(mMovie, "Warsongs.gotoAndStop", 1)
	mMovie:__wf_atom_02a20470(true)
	FadeInIntro()
end

function Update()
	local v = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v)
end

function Close()
	mMovie:Close()
end

function OpenFileFlashMovie()
	mMovie:SetFrameCallback("Warsongs", "OnFrameEnter")
end

function OnFrameEnter(p, p2)
	if p == "Warsongs" and p2 == "StopAnimation" then
		__wf_atom_ec43d06e(mMovie, "_root", 2, nil, nil, 0, 2.75, CloseTitlecard)
	end
end