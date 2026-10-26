local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = nil

local function fn(standingRewarded, __wf_atom_8e9ac384, iconTexture)
	mMovie:__wf_atom_2dedec1a("Title.Subtitle", 13, __wf_atom_8e9ac384 ~= nil)

	if __wf_atom_8e9ac384 ~= nil then
		mMovie:__wf_atom_50d60589("Title.Subtitle.Label", 36, __wf_atom_8e9ac384)
		local v3 = mMovie:__wf_atom_5e6e15c8("Title.Subtitle.Label", 40) + 20
		mMovie:__wf_atom_e57658c2("Title.Subtitle.LineLeft", 0, -(v3 / 2))
		mMovie:__wf_atom_e57658c2("Title.Subtitle.LineRight", 0, v3 / 2 - 5)
	end

	mMovie:__wf_atom_7d7314f1("Title.RepGain.text", "/Lotus/Language/Challenges/Challenge_CompletedRep", {
		AFFINITY = module.FormatNumber(standingRewarded, 0)
	})
	mMovie:__wf_atom_c90af43a("Title.Icon", iconTexture)
end

local function fn2()
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:Close()
	end)
end

local function fn3()
	local color = module2.GetColor(2, true)
	local color2 = module2.GetColor(6, true)
	local color3 = module2.GetColor(9, true)
	local color4 = module2.GetColor(10, true)
	mMovie:__wf_atom_e57658c2("Title.Bg", 11, color)
	mMovie:OverrideMaterial("Title.Bg", titleBgMaterial)
	mMovie:__wf_atom_e57658c2("Title.Bg", 12, 80)
	mMovie:__wf_atom_e57658c2("Title.RepGain", 44, color2)
	mMovie:__wf_atom_e57658c2("Title.Subtitle.Label", 44, color3)
	mMovie:__wf_atom_e57658c2("Title.Subtitle.LineLeft", 11, color3)
	mMovie:__wf_atom_e57658c2("Title.Subtitle.LineRight", 11, color3)
	mMovie:__wf_atom_e57658c2("Title.LineLeft", 11, color3)
	mMovie:__wf_atom_e57658c2("Title.LineRight", 11, color3)
	mMovie:__wf_atom_e57658c2("Title.LineLeft", 12, 80)
	mMovie:__wf_atom_e57658c2("Title.LineRight", 12, 80)
	mMovie:OverrideMaterial("Title.LineLeft", vitLinesMaterial)
	mMovie:OverrideMaterial("Title.LineRight", vitLinesMaterial)
	mMovie:__wf_atom_e57658c2("Title.Icon", 11, color4)
	mMovie:__wf_atom_e57658c2("Title.Icon", 12, 30)
end

local function fn4()
	local visibilitySize = module.GetVisibilitySize(mMovie, 150)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 100)
	titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	vitLinesMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	vitLinesMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

function Initialize()
	fn3()
	local module3 = require("EE.Interface.AnchorMgr")
	v = module3.Create(mMovie)
	v:Register(mMovie, "Title", { v.ANCHOR_H_CENTRE, v.ANCHOR_V_TOP })
	v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	fn4()
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module4.CreateTimerMgr()
	local flag

	if _T.StandingSyndicateRewarded == nil then
		flag = false
	else
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			_T.StandingSyndicateRewarded:__wf_atom_818ea3a7():c_str(),
			false
		)
		local iconTexture = _T.StandingSyndicateRewarded:GetIconTexture()
		fn(_T.StandingRewarded, __wf_atom_8e9ac384, iconTexture)
		_T.StandingSyndicateRewarded = nil
		_T.StandingRewarded = nil
		flag = true
	end

	if flag then
		v2:AddTimer(0.1, function()
			mMovie:__wf_atom_e57658c2("_root", 12, 1)
			__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.25)
			module.PlaySound(openSound)
			module.CreateParticles(mMovie, "Title", openFx, 0, 0)
			mMovie:__wf_atom_e57658c2("Title.Icon", 14, 100)
			mMovie:__wf_atom_e57658c2("Title.Icon", 15, 100)
			__wf_atom_ec43d06e(mMovie, "Title.Icon", 2, { 14, 15 }, { 250, 250 }, 0.35, 0.15, function()
				__wf_atom_ec43d06e(mMovie, "Title.Icon", 0, { 14, 15 }, { 320, 320 }, 4)
			end)
			v2:AddTimer(3.5, fn2)
		end)
	else
		fn2()
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(__wf_atom_fa1258d0())
	end
end

function onViewportSizeChanged(_, _)
	if v ~= nil then
		v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	fn4()
end

function SupportsThemes()
	return true
end