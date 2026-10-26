local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = 0
local v3 = true
local v4 = true
local v5 = true
local v6 = true
local flag = false

local function fn()
	local screenDimensions, v7 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("Vignette", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Vignette", 15, screenDimensions)
	mMovie:__wf_atom_e57658c2("Vignette2", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Vignette2", 15, screenDimensions)
	mMovie:__wf_atom_e57658c2("Blurer", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Blurer", 15, v7)
	mMovie:__wf_atom_e57658c2("Noise", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Noise", 15, v7)
	mMovie:__wf_atom_1ca72041("Noise", "TileRepeats", screenDimensions / 256, v7 / 256, 1, 1)
end

local function fn2()
	local color = module3.GetColor(2, true)
	mMovie:__wf_atom_e57658c2("Vignette", 11, color)
	mMovie:__wf_atom_e57658c2("Vignette2", 11, color)
	mMovie:__wf_atom_7df746cd(color)
	fn()
end

function OnStyleChangedCallback()
	fn2()
end

local function fn3()
	if flag then
		return
	end

	if v3 then
		module3.ApplyColorCorrection(true, 0.5, 0.5)
	end

	if v4 then
		module.FadeBackground(mMovie, 0.5, 0.35)
	end

	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.35)

	if v6 then
		module2.RegisterHideHud(true)
	end
end

function TransitionIn()
	fn3()
end

local function fn4(p, p2)
	flag = true
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, module.Ternary(p2, 0, 0.5), 0, function()
		if v6 then
			module2.RegisterHideHud(false)
		end

		if not p then
			mMovie:Close()
		end
	end)
	module3.ApplyColorCorrection(false)

	if not p2 then
		module.FadeBackground(mMovie, 0, 0.5)
	end
end

function TransitionOut(p, p2)
	fn4(p == "true", p2 == "true")
end

function EnableColorCorrection(p)
	v3 = p ~= "false"

	if v3 then
		module3.ApplyColorCorrection(true, 0.5, 0.5)
	else
		module3.ApplyColorCorrection(false)
	end
end

function EnableBackgroundFade(p)
	v4 = p ~= "false"

	if v4 then
		module.FadeBackground(mMovie, 0.5, 0.35)
	else
		module.FadeBackground(mMovie, 0, 0.5)
	end
end

function EnableBackgroundBlur(p)
	v5 = p ~= "false"

	if v5 then
		__wf_atom_ec43d06e(mMovie, "Blurer", 8, { 12 }, { 100 }, 0.5)
	else
		__wf_atom_ec43d06e(mMovie, "Blurer", 8, { 12 }, { 0 }, 0.5)
	end
end

function SetAlpha(p, value)
	__wf_atom_ec43d06e(mMovie, "Vignette", 0, { 12 }, { (tonumber(p)) }, 0.35)
	__wf_atom_ec43d06e(mMovie, "Vignette2", 0, { 12 }, { (tonumber(value or 0)) }, 0.35)
end

function SetColor(p)
	mMovie:__wf_atom_e57658c2("Vignette", 11, p)
	mMovie:__wf_atom_e57658c2("Vignette2", 11, p)
	mMovie:__wf_atom_7df746cd(p)
end

function Initialize()
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	fn2()
	mMovie:__wf_atom_0cf0fdbe(0)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Vignette", 12, 100)
	mMovie:__wf_atom_e57658c2("Vignette2", 12, 0)
	mMovie:__wf_atom_e57658c2("Noise", 12, 5)
	mMovie:OverrideMaterial("Noise", noiseMaterial)
	mMovie:OverrideMaterial("Vignette2.BlackBg", _G.UIMaterial_VisibilityRange)
	mMovie:__wf_atom_1ca72041("Vignette2.BlackBg", "VisibilityCenter", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Vignette2.BlackBg", "VisibilitySize", 0.65, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Vignette2.BlackBg", "VisibilityFadeSize", 0.3, 0, 0, 0)
	v:AddTimer(0.1, fn3)
end

function onViewportSizeChanged(_, _, _, _)
	fn()
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v7 = __wf_atom_fa1258d0()

	if not __wf_atom_7e8ad928(v) then
		v:Update(v7)
	end

	mMovie:__wf_atom_88d9cd84(v7)
	v2 = (v2 + v7) % 1
	mMovie:__wf_atom_1ca72041("Noise", "TileOffset", v2 * 3, v2 * 3, 1, 1)
end

function SetHideHud(p)
	v6 = p == "true"
end

function HideScreenForPlatPurchase(p)
	if p == "true" then
		__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0)
	else
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.15, 0)
	end
end