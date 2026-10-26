local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local v = nil
local flag = nil

function CloseTitlecard()
	__wf_atom_ec43d06e(mMovie, "_root", 8, {}, {}, 0, 10, function()
		Close()
	end)
end

function Initialize()
	module2.RegisterHideSubtitles(true)
	v = Time()
	flag = false
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end

	mMovie:__wf_atom_fbca497c(false)
	mMovie:SetFrameCallback("FeaturesAnim", "PlaySoundsForFeatures")
	mMovie:__wf_atom_c90af43a("Soulframe", soulframeLogoTexture)
	mMovie:__wf_atom_c90af43a("Warsongs", warsongsLogoTexture)
	mMovie:__wf_atom_e57658c2("Warsongs", 12, 70)
	mMovie:__wf_atom_50d60589(
		"ReleaseDateAnim.Subtitle.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Updates/Tennocon2026_ReleaseDate", false)
	)
	mMovie:__wf_atom_50d60589(
		"FeaturesAnim.Feature1.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Updates/Tennocon2026_Fishing", false)
	)
	mMovie:__wf_atom_c90af43a("FeaturesAnim.Feature1.Icon", fishingTexture)
	mMovie:__wf_atom_50d60589(
		"FeaturesAnim.Feature2.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Updates/Tennocon2026_Envoy", false)
	)
	mMovie:__wf_atom_c90af43a("FeaturesAnim.Feature2.Icon", envoyTexture)
	mMovie:__wf_atom_50d60589(
		"FeaturesAnim.Feature3.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Updates/Tennocon2026_Pack", false)
	)
	mMovie:__wf_atom_c90af43a("FeaturesAnim.Feature3.Icon", packTexture)
	mMovie:__wf_atom_50d60589(
		"ReleaseDateAnim.Subtitle.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Updates/Tennocon2026_ReleaseDate", false)
	)

	if _T.Tennocon2026EndcardPart == 1 then
		if not __wf_atom_7e8ad928(logoOneSound) then
			module.PlaySound(logoOneSound)
		end

		__wf_atom_86cbd68d(mMovie, "FeaturesAnim.gotoAndStop", 1)
		mMovie:__wf_atom_e57658c2("Soulframe", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Soulframe", 8, { 12 }, { 100 }, 0.9)
		mMovie:__wf_atom_e57658c2("Warsongs", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Warsongs", 8, { 12 }, { 70 }, 0.9)
		module2.DissolveIn(mMovie, nil, 1, 0)
	else
		if not __wf_atom_7e8ad928(logoTwoSound) then
			module.PlaySound(logoTwoSound)
		end

		__wf_atom_86cbd68d(mMovie, "ReleaseDateAnim.gotoAndStop", "StopAnim")
	end

	mMovie:__wf_atom_02a20470(true)
end

function Update()
	local v2 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v2)
end

function Shutdown()
	module2.RegisterHideSubtitles(false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end

function Close()
	if flag then
		return
	end

	flag = true

	if not __wf_atom_7e8ad928(fadeOutSound) then
		module.PlaySound(fadeOutSound)
	end

	module2.DissolveOutAndClose(mMovie)
end

function PlaySoundsForFeatures(_, p)
	if p == "FishingStart" then
		module.PlaySound(fishingSound)
	elseif p == "EmoStart" then
		module.PlaySound(emoSound)
	elseif p == "WolfStart" then
		module.PlaySound(wolfSound)
	end
end

function onKeyDown_MENU_CANCEL()
	if Time() - v < 1.5 then
		return
	end

	Close()
end