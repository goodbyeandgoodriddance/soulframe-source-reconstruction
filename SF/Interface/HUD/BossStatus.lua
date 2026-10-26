local v = { HEALTH = 0, STABILITY = 1 }
local v2 = { SHOWING = 0, SHOWN = 1, SHIFTING = 2, HIDING = 3 }
local v3 = {}
local mClipNames = { "Container.BossBar" }
local v4 = 1
local flag = false
local flag2 = false
local v5 = false
local health = v.HEALTH
local v6 = 0
local v7 = false
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Interface.SFUtilities")

function Initialize()
	v7 = module2.IsHardModeActive()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.BossBar.Bar", 12, 0)
	mMovie:OverrideMaterial("Container.BossBar.Bar.Bg", healthMaterial)
	mMovie:OverrideMaterial("Container.BossBar.Bar.FillLeft", healthMaterial)
	mMovie:OverrideMaterial("Container.BossBar.Bar.FillRight", healthMaterial)
	mMovie:OverrideMaterial("Container.BossBar.Bar.StabilityFillLeft", stabilityMaterial)
	mMovie:OverrideMaterial("Container.BossBar.Bar.StabilityFillRight", stabilityMaterial)
	mMovie:OverrideMaterial("Container.BossBar.Bar.Light", lightMaterial)
	mMovie:__wf_atom_1ca72041("Container.BossBar.Bar.Light", "FlickerIntensity", 0, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("Container.BossBar.Bar.Light", 5, 100)
	mMovie:__wf_atom_e57658c2("Container.BossBar.Bar.Light", 6, 100)
	mMovie:OverrideMaterial("Container.BossBar.Lightning", lightningMaterial)
	v6 = mMovie:__wf_atom_5e6e15c8("Container.BossBar", 1)
end

local function fn()
	local selected

	if #mClipNames > 0 then
		selected = table.remove(mClipNames)
	else
		selected = "Container.BossBar" .. v4
		__wf_atom_86cbd68d(mMovie, "Container.BossBar.duplicateMovieClip", "BossBar" .. v4, v4 + 100)
		v4 += 1
	end

	mMovie:__wf_atom_2dedec1a(selected, 13, true)
	return selected
end

local function fn2(p)
	for i, v8 in ipairs(v3) do
		if v8 ~= p then
			continue
		end

		table.remove(v3, i)
		break
	end
end

function PlaySingleBossIntro()
	local v8 = v6

	for i = #v3, 1, -1 do
		local v9 = v3[i]

		if v9.mState == v2.HIDING then
			local mClipName = v9.mClipName
			table.insert(mClipNames, mClipName)
			mMovie:__wf_atom_2dedec1a(mClipName, 13, false)
			table.remove(v3, i)
		else
			mMovie:__wf_atom_e57658c2(v9.mClipName, 5, 210)
			mMovie:__wf_atom_e57658c2(v9.mClipName, 6, 210)
			mMovie:__wf_atom_e57658c2(v9.mClipName, 1, v8)
			mMovie:__wf_atom_e57658c2(v9.mBarClip, 12, 0.01)
			v9.mState = v2.SHOWING
		end
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Container.IntroDetail", 12, 100)
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 1, 0, function()
		for _, v9 in ipairs(v3) do
			local v10 = v9
			__wf_atom_ec43d06e(mMovie, v9.mClipName, 2, { 5, 6, 1 }, { 100, 100, -16 }, 0.5, 1.2, function()
				__wf_atom_ec43d06e(mMovie, v10.mBarClip, 2, { 12 }, { 100 }, 0.5, function()
					v10.mState = v2.SHOWN
				end)

				if v7 then
					__wf_atom_ec43d06e(mMovie, v10.mClipName .. ".PurpleCloud", 2, { 12 }, { 100 }, 0.5)
				end
			end)
		end

		__wf_atom_ec43d06e(mMovie, "Container.IntroDetail", 2, { 12 }, { 0 }, 1, 1)
	end)
end

local function fn3()
	for _, v8 in ipairs(v3) do
		if v8.mState ~= v2.SHOWING then
			continue
		end

		local v9 = v8
		__wf_atom_ec43d06e(mMovie, v8.mClipName, 2, { 12 }, { 100 }, 0.5, 0, function()
			v9.mState = v2.SHOWN
		end)

		if v7 then
			__wf_atom_ec43d06e(mMovie, v8.mClipName .. ".PurpleCloud", 2, { 12 }, { 100 }, 0.5)
		end
	end
end

local function fn4()
	local flag3 = true

	for _, v8 in ipairs(v3) do
		if v8.mState ~= v2.SHIFTING then
			continue
		end

		local v9 = v8
		local v10 = flag3
		__wf_atom_ec43d06e(mMovie, v8.mClipName, 2, { 0 }, { v8.mTargetX }, 0.5, 0, function()
			v9.mState = v2.SHOWN

			if v10 then
				fn3()
			end
		end)
		flag3 = false
	end

	if flag3 then
		fn3()
	end
end

local function fn5()
	local flag3 = true

	for _, v8 in ipairs(v3) do
		if v8.mState ~= v2.HIDING then
			continue
		end

		local v9 = v8
		__wf_atom_ec43d06e(mMovie, v8.mClipName, 2, { 12 }, { 0 }, 2, 0, function()
			local mClipName = v9.mClipName
			table.insert(mClipNames, mClipName)
			mMovie:__wf_atom_2dedec1a(mClipName, 13, false)
			fn2(v9)
		end)

		if not flag3 then
			continue
		end

		__wf_atom_ec43d06e(mMovie, "Container.IntroDetail", 0, {}, {}, 1, 0, fn4)
		flag3 = false
	end

	if flag3 then
		fn4()
	end
end

function PlayGroupIntro()
	for _, v8 in ipairs(v3) do
		mMovie:__wf_atom_e57658c2(v8.mClipName, 5, 100)
		mMovie:__wf_atom_e57658c2(v8.mClipName, 6, 100)
		mMovie:__wf_atom_e57658c2(v8.mClipName, 1, -16)

		if v8.mState ~= v2.SHIFTING then
			mMovie:__wf_atom_e57658c2(v8.mClipName, 0, v8.mTargetX)
		end

		if v8.mState == v2.SHOWING then
			mMovie:__wf_atom_e57658c2(v8.mClipName, 12, 0.01)
		else
			mMovie:__wf_atom_e57658c2(v8.mClipName, 12, 100)
		end
	end

	mMovie:__wf_atom_e57658c2("Container.IntroDetail", 12, 0)
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	fn5()
end

function TransitionOut(p)
	if not flag2 then
		flag2 = true
		local v8 = __wf_atom_7e8ad928(p) and 0 or p
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 2, v8, function()
			if flag2 then
				mMovie:Close()
			end
		end)
	end
end

local function fn6(state)
	if mMovie:__wf_atom_1b848254(state.mBarClip .. ".FillLeft") then
		state.mQueuedPulseHealth = true
		return
	end

	mMovie:__wf_atom_4c1c1986(state.mBarClip, "FillLeft", 6, 200)
	mMovie:__wf_atom_4c1c1986(state.mBarClip, "FillRight", 6, 200)
	__wf_atom_ec43d06e(mMovie, state.mBarClip .. ".FillLeft", 6, { 6 }, { 100 }, 0.5)
	__wf_atom_ec43d06e(mMovie, state.mBarClip .. ".FillRight", 6, { 6 }, { 100 }, 0.5, function()
		if state.mQueuedPulseHealth then
			state.mQueuedPulseHealth = false
			fn6(state)
		end
	end)
end

local function fn7(p)
	local mBossAvatar = p.mBossAvatar
	local v8

	if health == v.STABILITY then
		v8 = mBossAvatar:__wf_atom_7470861b():__wf_atom_96e24059() == 0 and 0
			or mBossAvatar:__wf_atom_7470861b():__wf_atom_5d3f45d7() / mBossAvatar:__wf_atom_7470861b():__wf_atom_96e24059()
	else
		v8 = mBossAvatar:__wf_atom_c6f1f83d() / mBossAvatar:GetMaxHealth()
	end

	p.mSmoothMainBarRatio:__wf_atom_4453e49c(v8)
end

local function fn8(data, p)
	local mBossAvatar = data.mBossAvatar

	if __wf_atom_7e8ad928(mBossAvatar) or mBossAvatar:__wf_atom_e93896ba() == Symbol("Neutral") then
		return
	end

	if not (v5 or flag2) then
		local __wf_atom_96e24059 = mBossAvatar:__wf_atom_7470861b():__wf_atom_96e24059()
		local __wf_atom_5d3f45d7 = mBossAvatar:__wf_atom_7470861b():__wf_atom_5d3f45d7()
		local v8

		if health == v.STABILITY then
			v8 = __wf_atom_96e24059 == 0 and 0 or __wf_atom_5d3f45d7 / __wf_atom_96e24059
		else
			local maxHealth = mBossAvatar:GetMaxHealth()
			v8 = mBossAvatar:__wf_atom_c6f1f83d() / maxHealth
			local v9 = __wf_atom_96e24059 == 0 and 0 or 1 - __wf_atom_5d3f45d7 / __wf_atom_96e24059
			data.mSmoothStabilityBarRatio:__wf_atom_09294a87(v9)
		end

		if v8 == 0 then
			v5 = true
			data.mSmoothStabilityBarRatio:__wf_atom_09294a87(0)
		end

		if data.mSmoothMainBarRatio.mTargetVal ~= v8 then
			data.mSmoothMainBarRatio:__wf_atom_09294a87(v8)
			__wf_atom_ec43d06e(mMovie, data.mBarClip, 0, {}, {}, 0.5)
			fn6(data)
		end
	end

	data.mSmoothMainBarRatio:Update(p)
	data.mSmoothStabilityBarRatio:Update(p)
	local v8 = math.max(0.1, data.mSmoothMainBarRatio:__wf_atom_9e368823() * 100)
	local v9 = math.max(0.1, data.mSmoothStabilityBarRatio:__wf_atom_9e368823() * 100)
	mMovie:__wf_atom_4c1c1986(data.mBarClip, "FillLeftMask", 5, v8)
	mMovie:__wf_atom_4c1c1986(data.mBarClip, "FillRightMask", 5, v8)
	mMovie:__wf_atom_4c1c1986(data.mBarClip, "StabilityFillLeftMask", 5, v9)
	mMovie:__wf_atom_4c1c1986(data.mBarClip, "StabilityFillRightMask", 5, v9)
end

local function fn9(state)
	local v8

	if _T.ShowBossBarLightning then
		_T.ShowBossBarLightning -= __wf_atom_084b3e93()
		local v9 = __wf_atom_421b01aa(_T.ShowBossBarLightning, 0, 1)
		v8 = __wf_atom_24a82b69(v9)

		if _T.ShowBossBarLightning <= 0 then
			_T.ShowBossBarLightning = nil
		end
	else
		v8 = 0
	end

	mMovie:__wf_atom_4c1c1986(state.mClipName, "Lightning", 12, v8 * 100)
end

local function fn10(state, p)
	local mIsGroupBoss = state.mIsGroupBoss
	local mBossDangerous = state.mBossDangerous
	local __wf_atom_9e368823 = state.mSmoothMainBarRatio:__wf_atom_9e368823()

	if not (mBossDangerous or mIsGroupBoss) then
		if __wf_atom_9e368823 < 0.5 then
			local v8 = __wf_atom_104bfe98(65, 100, (__wf_atom_9e368823 - 0.085) / 0.415)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 5, v8)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 6, v8)
		else
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 5, 100)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 6, 100)
		end

		if __wf_atom_9e368823 < 0.085 then
			if not (state.mFlickerTime < 3) then
				mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 12, 0)
				return
			end

			mMovie:__wf_atom_1ca72041(state.mBarClip .. ".Light", "FlickerIntensity", state.mFlickerTime / 3, 0, 0, 0)
			local v8 = math.max(0, 3 - state.mFlickerTime) / 3 * 100
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 12, v8)
			state.mFlickerTime += p
		else
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 12, 100)
			mMovie:__wf_atom_1ca72041(state.mBarClip .. ".Light", "FlickerIntensity", 0, 0, 0, 0)
			state.mFlickerTime = 0
		end
	end
end

local function fn11(state)
	local mIsGroupBoss = state.mIsGroupBoss
	local mBossDangerous = state.mBossDangerous
	local v8 = state.mSmoothMainBarRatio:__wf_atom_9e368823() < 0.085

	if mBossDangerous then
		mMovie:OverrideMaterial(state.mBarClip .. ".Bg", greyhealthMaterial)
		mMovie:OverrideMaterial(state.mBarClip .. ".FillLeft", greyhealthMaterial)
		mMovie:OverrideMaterial(state.mBarClip .. ".FillRight", greyhealthMaterial)
	else
		mMovie:OverrideMaterial(state.mBarClip .. ".Bg", healthMaterial)
		mMovie:OverrideMaterial(state.mBarClip .. ".FillLeft", healthMaterial)
		mMovie:OverrideMaterial(state.mBarClip .. ".FillRight", healthMaterial)
	end

	if mBossDangerous then
		mMovie:OverrideMaterial(state.mBarClip .. ".Light", greyhealthMaterial)
		mMovie:__wf_atom_c90af43a(state.mBarClip .. ".Light", noDamageXTexture)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 14, 28)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 15, 28)
	elseif mIsGroupBoss then
		mMovie:OverrideMaterial(state.mBarClip .. ".Light", lightMaterial)
		mMovie:__wf_atom_c90af43a(state.mBarClip .. ".Light", nil)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 5, 100)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 6, 100)
	else
		mMovie:OverrideMaterial(state.mBarClip .. ".Light", lightMaterial)
		mMovie:__wf_atom_c90af43a(state.mBarClip .. ".Light", nil)

		if v8 then
			state.mFlickerTime = 3
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 12, 0)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 5, 65)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 6, 65)
		else
			state.mFlickerTime = 0
			mMovie:__wf_atom_1ca72041(state.mBarClip .. ".Light", "FlickerIntensity", 0, 0, 0, 0)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 12, 100)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 5, 100)
			mMovie:__wf_atom_4c1c1986(state.mBarClip, "Light", 6, 100)
		end
	end

	if mBossDangerous then
		mMovie:OverrideMaterial(state.mBarClip .. ".RedNightIcon", greyhealthMaterial)
		mMovie:OverrideMaterial(state.mBarClip .. ".RedNightX", greyhealthMaterial)
		mMovie:__wf_atom_c90af43a(state.mBarClip .. ".RedNightX", noDamageXTexture)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "RedNightX", 14, 28)
		mMovie:__wf_atom_4c1c1986(state.mBarClip, "RedNightX", 15, 28)
		mMovie:__wf_atom_7f57ab2f(state.mBarClip, "RedNightX", 13, true)
	else
		mMovie:OverrideMaterial(state.mBarClip .. ".RedNightIcon", nil)
		mMovie:__wf_atom_7f57ab2f(state.mBarClip, "RedNightX", 13, false)
	end
end

function UpdateBossBar(state, p)
	fn8(state, p)
	local mBossDangerous = module3.IsUndamagableEnemy(mMovie, state.mBossAvatar) and true or false

	if state.mBossDangerous ~= mBossDangerous then
		state.mBossDangerous = mBossDangerous
		fn11(state)
	end

	fn10(state, p)
	fn9(state)

	if not __wf_atom_7e8ad928(state.mBossAvatar) then
		local __wf_atom_818ea3a7 = state.mBossAvatar:__wf_atom_818ea3a7()

		if state.mCurrentBossName ~= __wf_atom_818ea3a7 then
			state.mCurrentBossName = __wf_atom_818ea3a7
			mMovie:__wf_atom_48bd5a59(state.mClipName, "Name", 36, Localize(state.mCurrentBossName, true))
		end
	end
end

function Update()
	local v8 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v8)

	if flag then
		for _, v9 in ipairs(v3) do
			UpdateBossBar(v9, v8)
		end
	end

	if not flag2 then
		local flag3 = true
		local flag4 = true

		for _, v9 in ipairs(v3) do
			if __wf_atom_7e8ad928(v9.mBossAvatar) or v9.mBossAvatar:__wf_atom_e93896ba() == Symbol("Neutral") then
				continue
			end

			flag4 = false
			break
		end

		for _, v9 in ipairs(v3) do
			if not (v9.mSmoothMainBarRatio.mTargetVal > 0) then
				continue
			end

			flag3 = false
			break
		end

		if flag4 then
			TransitionOut()
		elseif flag3 then
			TransitionOut(0.5)
		end
	end

	local v9 = _T.HideHud ~= nil and _T.HideHud > 0
	mMovie:SetVisible(not v9)
end

function AcquireBossAvatar(p, p2)
	local v8 = p == "true"
	local mIsGroupBoss = p2 == "true"
	mMovie:__wf_atom_62d09591(v8)

	if _T.PendingBossStatusAvatars == nil then
		return
	end

	for i = #_T.PendingBossStatusAvatars, 1, -1 do
		if __wf_atom_7e8ad928(_T.PendingBossStatusAvatars[i]) then
			table.remove(_T.PendingBossStatusAvatars, i)
		end
	end

	if #_T.PendingBossStatusAvatars == 0 then
		return
	end

	if flag2 then
		flag2 = false
	end

	v5 = false
	mMovie:__wf_atom_290807ee("_root")
	mMovie:__wf_atom_290807ee("Container.IntroDetail")
	local v9 = v3
	v3 = {}
	local count = #_T.PendingBossStatusAvatars

	if count > 3 then
		print("Attempting to show " .. count .. " boss bars, which has no UI layout. falling back to first three bars")
		_T.PendingBossStatusAvatars = {
			_T.PendingBossStatusAvatars[1],
			_T.PendingBossStatusAvatars[2],
			_T.PendingBossStatusAvatars[3]
		}
		count = 3
	end

	print("Showing " .. count .. " boss bars")

	for i, pendingBossStatusAvatar in ipairs(_T.PendingBossStatusAvatars) do
		local v10 = nil

		for j, v11 in ipairs(v9) do
			if v11.mBossAvatar ~= pendingBossStatusAvatar then
				continue
			end

			table.remove(v9, j)

			if v11.mState == v2.SHOWN then
				v11.mState = v2.SHIFTING
			else
				v11.mState = v2.SHOWING
			end

			v10 = v11
			break
		end

		local v11 = v10 == nil and {
			mBarIndex = nil,
			mClipName = fn(),
			mBarClip = nil,
			mBossAvatar = pendingBossStatusAvatar,
			mBossDangerous = false,
			mFlickerTime = 0,
			mIsGroupBoss = false,
			mCurrentBossName = nil,
			mSmoothMainBarRatio = __wf_atom_10cd16b2(1, 0.1),
			mSmoothStabilityBarRatio = __wf_atom_10cd16b2(0, 0.1),
			mTargetX = 0,
			mState = v2.SHOWING,
			mQueuedPulseHealth = false
		} or v10
		table.insert(v3, v11)
		v11.mBarIndex = i
		v11.mBarClip = v11.mClipName .. (mIsGroupBoss and ".GroupBar" or ".Bar")
		v11.mIsGroupBoss = mIsGroupBoss
		v11.mCurrentBossName = nil
		mMovie:__wf_atom_290807ee(v11.mClipName)
		mMovie:__wf_atom_290807ee(v11.mBarClip)
		mMovie:__wf_atom_2dedec1a(v11.mClipName, 13, true)
		mMovie:__wf_atom_7f57ab2f(v11.mBarClip, "StabilityBar.Fill", 13, health == v.HEALTH)
		fn7(v11)
		fn11(v11)
		mMovie:__wf_atom_7f57ab2f(v11.mBarClip, "RedNightIcon", 13, v7)
		mMovie:__wf_atom_7f57ab2f(v11.mBarClip, "RedNightX", 13, false)
		mMovie:__wf_atom_4c1c1986(v11.mClipName, "PurpleCloud", 12, 0)
		mMovie:OverrideMaterial(v11.mClipName .. ".PurpleCloud", cloudMaterial)
	end

	if mIsGroupBoss then
		if count == 1 then
			v3[1].mTargetX = 0
		elseif count == 2 then
			v3[1].mTargetX = -280
			v3[2].mTargetX = 280
		elseif count == 3 then
			v3[1].mTargetX = -560
			v3[2].mTargetX = 0
			v3[3].mTargetX = 560
		end

		for _, v10 in ipairs(v3) do
			mMovie:__wf_atom_7f57ab2f(v10.mClipName, "Bar", 13, false)
			mMovie:__wf_atom_7f57ab2f(v10.mClipName, "GroupBar", 13, true)
			mMovie:__wf_atom_4c1c1986(v10.mClipName, "Name", 50, 20)
		end
	else
		local v10 = v3[1]
		mMovie:__wf_atom_e57658c2(v10.mClipName, 0, 0)
		mMovie:__wf_atom_7f57ab2f(v10.mClipName, "Bar", 13, true)
		mMovie:__wf_atom_7f57ab2f(v10.mClipName, "GroupBar", 13, false)
		mMovie:__wf_atom_4c1c1986(v10.mClipName, "Name", 50, 23)
	end

	for _, v10 in ipairs(v9) do
		v10.mState = v2.HIDING
		table.insert(v3, v10)
	end

	_T.PendingBossStatusAvatars = nil

	if mIsGroupBoss then
		PlayGroupIntro()
	else
		PlaySingleBossIntro()
	end

	flag = true

	if v7 then
		module.PlaySound(bossStingerHardModeSound)
	else
		module.PlaySound(bossStingerSound)
	end
end

function Shutdown()
	mMovie:__wf_atom_62d09591(false)

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local __wf_atom_330f77f5 = __wf_atom_eab484a7:__wf_atom_330f77f5(false)

			if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
				__wf_atom_330f77f5:__wf_atom_819f9afc("BossStatus")
			end
		end
	end
end