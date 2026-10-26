local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local v = {}
local v2 = 1
local flag = true
local v3 = 1
local v4 = false
local v5 = nil
local v6 = false
local flag2 = false
local v7 = 0
local v8 = nil
local v9 = 0
local v10 = 0
local v11 = __wf_atom_10cd16b2(0, 0.05)
local v12 = __wf_atom_10cd16b2(0, 0.05)
local v13 = nil
local v14 = nil
local total = 0
local mStruggleValue = 0
local scriptedStruggleParams = nil
local v15 = false
local value = 0

local function fn()
	gRegion:__wf_atom_eab484a7():CameraControl():__wf_atom_57715abb(true)
	local v16 = (__wf_atom_7e8ad928(scriptedStruggleParams) or __wf_atom_7e8ad928(scriptedStruggleParams.ScreenShakeSpeed))
		and 1
		or scriptedStruggleParams.ScreenShakeSpeed
	local v17 = (__wf_atom_7e8ad928(scriptedStruggleParams) or __wf_atom_7e8ad928(scriptedStruggleParams.ScreenShakeStrength))
		and 0.4
		or scriptedStruggleParams.ScreenShakeStrength
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess:__wf_atom_f846a58a(v16)
	postProcess:__wf_atom_a2b7fcd3(v17)
	postProcess:__wf_atom_85583806(Rotation(1, 1, 2))
	postProcess:__wf_atom_bf9e86f0(0.4)
end

local function fn2()
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
		local postProcess = __wf_atom_8ad59546.postProcess
		postProcess:__wf_atom_f846a58a(0)
		postProcess:__wf_atom_a2b7fcd3(0)
		postProcess:__wf_atom_85583806(Rotation(0, 0, 0))
		postProcess:__wf_atom_bf9e86f0(0)
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	__wf_atom_eab484a7:CameraControl():__wf_atom_57715abb(false)
end

local function fn3()
	local v16 = (__wf_atom_7e8ad928(scriptedStruggleParams) or __wf_atom_7e8ad928(scriptedStruggleParams.inputCode))
		and "USE"
		or scriptedStruggleParams.inputCode
	local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(v16, false, promptInputFilter)
	local v17

	if
		Engine.IsPlayingWithController()
		or Engine.__wf_atom_dd1285f1()
		or not (#__wf_atom_c2e9085e > 0)
		or string.find(__wf_atom_c2e9085e[1], "EN_") ~= nil
	then
		local v18 = (__wf_atom_7e8ad928(scriptedStruggleParams) or __wf_atom_7e8ad928(scriptedStruggleParams.inputLoc))
			and "<USE>"
			or scriptedStruggleParams.inputLoc
		v17 = mMovie:__wf_atom_8e9ac384(v18, true)
	else
		v17 = __wf_atom_c2e9085e[1]
	end

	mMovie:__wf_atom_50d60589("Prompt.Callout.Label", 36, v17)
end

local function fn4()
	if scriptedStruggleParams and scriptedStruggleParams.overrideHold == true then
		v6 = false
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local settings = __wf_atom_18a5d83b:Settings()

			if not __wf_atom_7e8ad928(settings) then
				v6 = settings:__wf_atom_b1f7ee32()
			end
		end
	end

	if __wf_atom_7e8ad928(scriptedStruggleParams) or not scriptedStruggleParams.KeepHud then
		module2.RegisterHideHud(true)
	end

	v13 = mMovie:__wf_atom_5e6e15c8("Prompt", 0)
	v14 = mMovie:__wf_atom_5e6e15c8("Prompt", 1)
	mMovie:OverrideMaterial("Prompt.Bg", bgMaterial)
	mMovie:OverrideMaterial("Prompt.Bg.Mist", mistMaterial)
	mMovie:__wf_atom_e57658c2("Prompt.Glow", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Prompt.Glow", 12, 60)
	mMovie:__wf_atom_e57658c2("Prompt.CircleBg", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Prompt.CircleBg", 12, 45)
	mMovie:OverrideMaterial("Prompt.ProgressFill", progressMaterial)
	mMovie:__wf_atom_e57658c2("Prompt.ProgressBg", 12, 10)
	mMovie:__wf_atom_e57658c2("Prompt.Callout.Label", 44, 14524216)
	mMovie:__wf_atom_e57658c2("Prompt.Hint.Label", 44, 12363651)
	fn3()
	mMovie:__wf_atom_50d60589("Prompt.Hint.Label", 46, "bottom")
	mMovie:__wf_atom_7d7314f1(
		"Prompt.Hint.Label.text",
		module.Ternary(v6, "/Lotus/Language/Actions/StruggleHold", "/Lotus/Language/Actions/StruggleTap")
	)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Prompt.Hint.Label", 40)
	local v16 = -13 - (__wf_atom_421b01aa(__wf_atom_5e6e15c8, 50, 100) - 50) / 3 + 0
	mMovie:__wf_atom_e57658c2("Prompt.Hint.Label", 1, v16)
	local openSound = openSound

	if scriptedStruggleParams and scriptedStruggleParams.openSound then
		openSound = scriptedStruggleParams.openSound
	end

	module.PlaySound(openSound)
	fn()

	if not __wf_atom_7e8ad928(loopSound) and v8 == nil then
		local loopSound = loopSound

		if scriptedStruggleParams and scriptedStruggleParams.loopSound then
			loopSound = scriptedStruggleParams.loopSound
		end

		v8 = module.PlaySound(loopSound)
	end
end

function Initialize()
	v.Background1 = Color(20, 19, 29):__wf_atom_dcecedb0()
	v.FloatingContentHighlight = Color(245, 227, 173):__wf_atom_dcecedb0()
	local __wf_atom_7be51ede = mMovie:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		if _T.ScriptedStruggleParams then
			scriptedStruggleParams = _T.ScriptedStruggleParams
			_T.ScriptedStruggleParams = nil
			gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
				Symbol("Struggle"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15(scriptedStruggleParams.inputCode),
				CalloutPressed
			)
			fn4()
		end
	else
		if gRegion:__wf_atom_c4f78a8f() and not gRegion:__wf_atom_c4f78a8f():__wf_atom_40a4ba6c() then
			mMovie:Close()
			return
		end

		v5 = __wf_atom_7be51ede:__wf_atom_25103871()
		fn4()
	end
end

local function fn5()
	v4 = true
	fn2()

	if not __wf_atom_7e8ad928(v8) then
		v8:Stop(false)
	end

	__wf_atom_ec43d06e(mMovie, "Prompt", 8, { 12 }, { 0 }, 0.5, 0.25, function()
		mMovie:Close()
	end)
end

function Update()
	total += __wf_atom_084b3e93()

	if
		not __wf_atom_7e8ad928(v5)
		and total >= struggleDiffIncreaseTime
		and v5.mStruggleValue > 0
		and v5.mStruggleValue < 1
		and not v6
	then
		mStruggleValue = v5.mStruggleValue
		v5.mStruggleValue = mStruggleValue - (total - struggleDiffIncreaseTime) * struggleDiffIncreaseValue * __wf_atom_084b3e93()

		if v5.mStruggleValue <= 0 then
			v5.mStruggleValue = 0
			v15 = true
		end
	end

	if
		scriptedStruggleParams
		and not scriptedStruggleParams.constantDifficulty
		and not scriptedStruggleParams.continuous
		and scriptedStruggleParams.value ~= nil
		and scriptedStruggleParams.value > 0
		and scriptedStruggleParams.value < 1
		and total >= struggleDiffIncreaseTime
		and not v6
	then
		mStruggleValue = scriptedStruggleParams.value
		scriptedStruggleParams.value = mStruggleValue - (total - struggleDiffIncreaseTime) * struggleDiffIncreaseValue * __wf_atom_084b3e93()
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	value = 0

	if __wf_atom_7e8ad928(v5) then
		if scriptedStruggleParams then
			value = scriptedStruggleParams.value

			if scriptedStruggleParams.value < 1 or scriptedStruggleParams.continuous then
				scriptedStruggleParams.value = __wf_atom_421b01aa(
					scriptedStruggleParams.value - scriptedStruggleParams.decayRate * __wf_atom_084b3e93(),
					0,
					1
				)
			end
		else
			v2 += 1

			if v2 > 100 then
				v2 = 1
			end

			value = v2 / 100
		end
	else
		value = v5.mStruggleValue
	end

	value = __wf_atom_421b01aa(value, 0, 1)
	mMovie:__wf_atom_1ca72041("Prompt.ProgressFill", "AlphaTestThreshold", value, 0, 0, 0)
	local v16 = __wf_atom_104bfe98(90, 140, (math.pow(value, 0.5)))
	mMovie:__wf_atom_e57658c2("Prompt", 5, v16)
	mMovie:__wf_atom_e57658c2("Prompt", 6, v16)

	if v6 and flag2 then
		v9 = 0.35
	end

	if v9 > 0 then
		v9 = math.max(v9 - __wf_atom_084b3e93(), 0)
		local v17 = math.min(v9 / 0.15, 1) * 35
		v11:__wf_atom_09294a87(Noise(Time() + v10) * v17)
		v12:__wf_atom_09294a87(Noise(Time() + v10 + 0.5) * v17)
	end

	v11:Update(__wf_atom_084b3e93())
	v12:Update(__wf_atom_084b3e93())
	mMovie:__wf_atom_e57658c2("Prompt", 0, v13 + v11:__wf_atom_9e368823())
	mMovie:__wf_atom_e57658c2("Prompt", 1, v14 + v12:__wf_atom_9e368823())

	if not __wf_atom_7e8ad928(v8) then
		local v17 = value * 3 + 0.8
		v8:__wf_atom_53043d81(v17)
	end

	if scriptedStruggleParams or not __wf_atom_7e8ad928(v5) and v5.mStruggleValue > 0 then
		if flag2 then
			v7 -= __wf_atom_084b3e93()

			if v7 <= 0 then
				v7 = 0.15
				local ternary = module.Ternary(false, duviriPulseFx, calloutPulseFx)

				if not __wf_atom_7e8ad928(ternary) then
					module.CreateParticles(mMovie, "Prompt.Callout", ternary, nil, 0)
				end
			end

			if scriptedStruggleParams then
				scriptedStruggleParams.value = math.min(
					1,
					scriptedStruggleParams.value + scriptedStruggleParams.incHoldAmount * __wf_atom_fa1258d0()
				)

				if scriptedStruggleParams.value >= 1 and not scriptedStruggleParams.continuous then
					flag2 = false
					scriptedStruggleParams.success = true
					fn5()
				end
			end
		end

		if flag then
			flag = false
			local ternary = module.Ternary(v3 == 1, 120, 100)
			__wf_atom_ec43d06e(mMovie, "Prompt.Callout", 8, { 5, 6 }, { ternary, ternary }, 0.15, 0, function()
				v3 *= -1

				if not v4 or v3 == -1 then
					flag = true
				end
			end)
		end
	end

	if not v4 then
		if __wf_atom_7e8ad928(gRegion) then
			fn5()
			return
		end

		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			fn5()
			return
		end

		local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() then
			fn5()
		elseif not (__wf_atom_7e8ad928(v5) or playerAvatar:__wf_atom_40a4ba6c()) then
			fn5()
		end
	end
end

function Shutdown()
	if scriptedStruggleParams and not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not (__wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_7e8ad928(__wf_atom_8e4fda44)) then
			__wf_atom_eab484a7:__wf_atom_1006e6fc(
				Symbol("Struggle"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15(scriptedStruggleParams.inputCode)
			)
		end
	end

	if __wf_atom_7e8ad928(scriptedStruggleParams) or not scriptedStruggleParams.KeepHud then
		module2.RegisterHideHud(false)
	end

	fn2()
end

function Success()
	local successSound = successSound

	if not __wf_atom_7e8ad928(scriptedStruggleParams) and scriptedStruggleParams.successSound then
		successSound = scriptedStruggleParams.successSound
	end

	module.PlaySound(successSound)
	fn5()
end

function Failed()
	fn5()
end

function CalloutPressed(p)
	if v4 or v15 then
		return
	end

	local v16 = tonumber(p)

	if v6 and v16 and v16 == 1 then
		flag2 = true
		return
	end

	if v6 then
		flag2 = false
		return
	end

	if v16 == 1 then
		local ternary = module.Ternary(false, duviriPulseFx, calloutPulseFx)

		if not __wf_atom_7e8ad928(ternary) then
			module.CreateParticles(mMovie, "Prompt.Callout", ternary, nil, 0)
			local buttonSound = buttonSound

			if scriptedStruggleParams and scriptedStruggleParams.buttonSound then
				buttonSound = scriptedStruggleParams.buttonSound
			end

			local v17 = module.PlaySound(buttonSound)

			if not __wf_atom_7e8ad928(v17) then
				v17:__wf_atom_53043d81(value + 0.4)
			end
		end

		v9 = 0.5
		v10 = Random(0, 1)
	end

	if scriptedStruggleParams then
		if v16 and v16 == 1 and not scriptedStruggleParams.buttonDown then
			scriptedStruggleParams.value = math.min(1, scriptedStruggleParams.value + scriptedStruggleParams.incAmount)
			scriptedStruggleParams.buttonDown = true

			if scriptedStruggleParams.value >= 1 and not scriptedStruggleParams.continuous then
				local successSound = successSound

				if scriptedStruggleParams.successSound then
					successSound = scriptedStruggleParams.successSound
				end

				module.PlaySound(successSound)
				scriptedStruggleParams.success = true
				fn5()
			end
		elseif (not v16 or v16 == 0) and scriptedStruggleParams.buttonDown then
			scriptedStruggleParams.buttonDown = nil
		end
	end
end

function SupportsThemes()
	return true
end

function OnGamepadTransition(_)
	fn3()
end

function OpenFileFlashMovie(_, _)
	scriptedStruggleParams = {
		inputCode = "USE",
		value = 0.4,
		incAmount = 0.05,
		decayRate = 0.05,
		incHoldAmount = 0.3,
		inputLoc = "<USE>",
		constantDifficulty = true
	}
	gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
		Symbol("Struggle"),
		__wf_atom_8e4fda44:__wf_atom_e7d83c15(scriptedStruggleParams.inputCode),
		CalloutPressed
	)
	fn4()
	fn2()

	if not __wf_atom_7e8ad928(v8) then
		v8:Stop(false)
	end
end