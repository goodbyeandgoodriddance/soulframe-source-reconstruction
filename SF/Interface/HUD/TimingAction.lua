local module = require("SF.Scripts.NightFoldLib")
local module2 = require("EE.Interface.Utilities")
local flag = false
local v = nil
local flag2 = false
local v2 = false
local flag3 = true
local v3 = false
local v4 = nil
local looping = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = Symbol("QTESpeed")
local v14 = Symbol("QTE")
local v15 = { NORMAL = 1, LOOPING = 2 }
local v16 = nil
local successSoundWazzard2 = nil
local beginMinigameSoundWazzard2 = nil

local function fn()
	v = 0
	v6 = 1
	v8 = 0.7
	v7 = 0.3
	v9 = 7
	looping = v15.LOOPING
	v10 = mMovie:__wf_atom_cfc41e35("TimingAction", "IndicatorCircle", 14)
	v11 = mMovie:__wf_atom_5e6e15c8("TimingAction", 0)
	v12 = mMovie:__wf_atom_5e6e15c8("TimingAction", 1)
	mMovie:__wf_atom_1ca72041("TimingAction.TargetDonut", "CircleSettings", 0.3, 0.99, 0.95, 1)
	local __wf_atom_7be51ede = mMovie:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		successSoundWazzard2 = successSoundWazzard
		beginMinigameSoundWazzard2 = beginMinigameSoundWazzard
	else
		v16 = __wf_atom_7be51ede:__wf_atom_25103871()
		successSoundWazzard2 = successSoundMockery
		beginMinigameSoundWazzard2 = beginMinigameSoundMockery
	end

	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(v14, __wf_atom_8e4fda44:__wf_atom_e7d83c15("USE"), HitInput)
	UpdatePrompt()
	TransitionIn()
end

local function fn2(p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p, 5)
	__wf_atom_ec43d06e(
		mMovie,
		p,
		1,
		{ 5, 6 },
		{ 1.05 * __wf_atom_5e6e15c8, 1.05 * __wf_atom_5e6e15c8 },
		0.05,
		0,
		function()
			__wf_atom_ec43d06e(mMovie, p, 1, { 5, 6 }, { __wf_atom_5e6e15c8, __wf_atom_5e6e15c8 }, 0.1)
		end
	)
end

local function fn3(p)
	if p <= 0.01 then
		if not v2 then
			if not __wf_atom_7e8ad928(beginMinigameSoundWazzard2) then
				module2.PlaySound(beginMinigameSoundWazzard2)
			end

			v2 = true
			v5 = Time()
			v9 = math.max(v9 * 0.8, 2)
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:__wf_atom_cecb2d55(v13, v9)
			end
		end
	elseif p >= 0.95 and v2 then
		module2.PlaySound(expandWarningSound)
		v2 = false
	end

	local v17 = __wf_atom_104bfe98(v10, 60, p)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 14, v17)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 15, v17)
	local v18 = (1 - p) * v6
	local v19

	if v18 <= v8 then
		v19 = v7 <= v18
	else
		v19 = false
	end

	if v19 then
		if not flag2 then
			flag2 = true
			module2.PlaySound(readyToPressPromptSound)
			__wf_atom_ec43d06e(mMovie, "TimingAction.TargetDonut", 1, { 12 }, { 40 }, 0.01)
		end
	elseif flag2 then
		flag2 = false
		__wf_atom_ec43d06e(mMovie, "TimingAction.TargetDonut", 1, { 12 }, { 20 }, 0.01)
	end
end

function UpdatePrompt()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v17

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v17 = __wf_atom_c4f78a8f:__wf_atom_4dc54686()
	end

	local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c("<USE>", v17)
	mMovie:__wf_atom_48bd5a59("TimingAction", "PromptHolder.Prompt", 36, __wf_atom_c7fa5e0c)
end

local function fn4()
	flag = false
	flag3 = true
	mMovie:__wf_atom_4c1c1986("TimingAction", "Background", 11, 4916485)
	mMovie:__wf_atom_4c1c1986("TimingAction", "Background", 11, _G.UIColor_Negative)
	mMovie:__wf_atom_4c1c1986("TimingAction", "BackgroundDeco", 11, _G.UIColor_Negative)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 11, _G.UIColor_Negative)
	__wf_atom_ec43d06e(mMovie, "TimingAction.TargetCircle", 1, { 12 }, { 10 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "TimingAction.FailGlow", 1, { 12 }, { 20 }, 0.1)
	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = false
	musicResultsRMIArgs.mSuccess = false
	gRegion:__wf_atom_c4f78a8f():__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	TransitionOut()
end

local function fn5()
	mMovie:__wf_atom_4c1c1986("TimingAction", "Background", 12, 70)
	mMovie:__wf_atom_4c1c1986("TimingAction", "BackgroundDeco", 12, 30)
	mMovie:__wf_atom_4c1c1986("TimingAction", "BackgroundDeco", 11, 8152122)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetCircle.Border", 11, 6124631)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetCircle.Fill", 11, 6124631)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetCircle.Fill", 12, 70)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetCircle", 12, 50)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 11, 14524216)
	mMovie:__wf_atom_4c1c1986("TimingAction", "Burst", 12, 0)
	mMovie:__wf_atom_4c1c1986("TimingAction", "FailGlow", 12, 0)
	mMovie:__wf_atom_4c1c1986("TimingAction", "FailGlow", 11, _G.UIColor_Red)
	mMovie:__wf_atom_4c1c1986("TimingAction", "Mist", 12, 0)
end

local function fn6()
	fn5()
	__wf_atom_ec43d06e(mMovie, "TimingAction.IndicatorCircle", 0, { 12 }, { 90 }, 0.1)
	v = 0
	flag = true
	v2 = false
	flag3 = false
	flag2 = false
	v5 = Time()
end

local function fn7(p)
	mMovie:__wf_atom_e57658c2("TimingAction", 0, 7 * Noise(p) + v11)
	mMovie:__wf_atom_e57658c2("TimingAction", 1, 7 * Noise(-p) + v12)
end

local function fn8(p)
	module2.PlaySound(failSound)

	if looping ~= v15.LOOPING then
		fn4()
		return
	end

	if p then
		fn6()
		return
	end

	flag = false
	flag3 = true
	fn2("TimingAction.IndicatorCircle")
	module2.PlaySound(incorrectSound)
	mMovie:__wf_atom_4c1c1986("TimingAction", "BackgroundDeco", 11, _G.UIColor_Negative)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 11, _G.UIColor_Negative)
	__wf_atom_ec43d06e(mMovie, "TimingAction.IndicatorCircle", 0, { 12 }, { 0 }, 1, 0, fn6)
	__wf_atom_ec43d06e(mMovie, "TimingAction", 0, { fn7 }, { 1 }, 0.5, 0.1, function()
		__wf_atom_ec43d06e(mMovie, "TimingAction", 0, { 0, 1 }, { v11, v12 }, 0.3, 0, fn6)
	end)
end

local function fn9()
	if not __wf_atom_7e8ad928(successSoundWazzard2) then
		module2.PlaySound(successSoundWazzard2)
	end

	module2.CreateParticles(mMovie, "TimingAction.BackgroundDeco", successFx, nil, 0)
	flag = false
	flag3 = true

	if not __wf_atom_7e8ad928(v16) then
		v16.mStruggleValue = 2
	end

	mMovie:__wf_atom_4c1c1986("TimingAction", "BackgroundDeco", 11, 6124631)
	__wf_atom_ec43d06e(mMovie, "TimingAction.Mist", 1, { 12 }, { 100 }, 0.15)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 11, 8968574)
	fn2("TimingAction.IndicatorCircle")
	fn2("TimingAction.TargetCircle")
	__wf_atom_ec43d06e(mMovie, "TimingAction.BackgroundDeco", 2, { 5, 6, 12 }, { 100, 100, 0 }, 3.1, 0)
	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = false
	musicResultsRMIArgs.mSuccess = true
	gRegion:__wf_atom_c4f78a8f():__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	TransitionOut()
end

function HitInput()
	if flag3 then
		return
	end

	local v17 = (1 - v) * v6
	local v18

	if v17 <= v8 then
		v18 = v7 <= v17
	else
		v18 = false
	end

	if v18 then
		fn9()
	else
		fn8(false)
	end
end

function Initialize()
	module.RegisterPreventNighfoldUsage(true)
	mMovie:__wf_atom_fbca497c(false)
	mMovie:__wf_atom_e57658c2("TimingAction", 12, 0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	__wf_atom_c4f78a8f:CameraControl():__wf_atom_dc7b15db(musicColorGrade, 0.5, -1, 0, 1)
	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = true
	__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	fn5()
	mMovie:OverrideMaterial("TimingAction.Mist", mistMaterial)
	mMovie:OverrideMaterial("TimingAction.IndicatorCircle", circleMaterial)
	mMovie:OverrideMaterial("TimingAction.TargetDonut", circleMaterial)
	mMovie:__wf_atom_4c1c1986("TimingAction", "IndicatorCircle", 12, 0)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetDonut", 12, 20)
	mMovie:__wf_atom_4c1c1986("TimingAction", "TargetDonut", 11, 6124631)
	fn()
	UpdatePrompt()
end

function Update()
	local v17 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v17)

	if flag then
		v = 0.5 - math.cos((Time() - v5) * v9) / 2
		fn3(v)
	end

	if flag and not __wf_atom_7e8ad928(v16) and v16.mStruggleValue <= 0 then
		fn4()
	end

	local v18 = (1 - v) * v6
	local v19

	if v18 <= v8 then
		v19 = v7 <= v18
	else
		v19 = false
	end

	if v19 and v3 and flag then
		fn9()
	end
end

function StartQTE()
	__wf_atom_ec43d06e(mMovie, "TimingAction.IndicatorCircle", 1, { 12 }, { 100 }, 0.05, 0)
	v5 = Time()
	flag = true
	flag3 = false
	v4 = module2.PlaySound(loopSound)
end

function TransitionIn()
	__wf_atom_ec43d06e(mMovie, "TimingAction", 1, { 12 }, { 100 }, 0.7, 0, StartQTE)
end

function EndQTE()
	mMovie:Close()

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end
end

function TransitionOut()
	gRegion:__wf_atom_c4f78a8f():CameraControl():__wf_atom_928a45c5(musicColorGrade, true)
	flag = false
	__wf_atom_ec43d06e(mMovie, "TimingAction", 0, {}, {}, 0.1, 0, function()
		__wf_atom_ec43d06e(mMovie, "TimingAction", 0, { 12 }, { 0 }, 0.5, 0, EndQTE)
	end)
end

function Shutdown()
	module.RegisterPreventNighfoldUsage(false)

	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	__wf_atom_eab484a7:__wf_atom_1006e6fc(v14, __wf_atom_8e4fda44:__wf_atom_e7d83c15("USE"))
end

function OnGamepadTransition(_)
	UpdatePrompt()
end