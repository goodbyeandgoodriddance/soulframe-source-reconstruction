local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local flag = false
local total = 0
local v3 = {}
local v4 = {}
local count = 0
local count2 = 0
local v5 = {}

local function fn()
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 0, function()
		flag = true
	end)
end

local function fn2(object)
	mMovie:__wf_atom_e57658c2(object.mClipName, 0, object.mUser1.mX)
	mMovie:__wf_atom_e57658c2(object.mClipName, 1, object.mUser1.mY)
	local alpha = object:GetAlpha()
	mMovie:__wf_atom_4c1c1986(object.mClipName, "InnerLine", 12, alpha)
	local deg = module3.ToDeg(module3.GetAngleBetweenPoints(
		object.mUser2.mX,
		object.mUser2.mY,
		object.mUser1.mX,
		object.mUser1.mY
	))
	mMovie:__wf_atom_e57658c2(object.mClipName, 16, -deg + 180)
	local _ = object.mId == 1
	local distanceBetweenPoints = module3.GetDistanceBetweenPoints({
		X = object.mUser1.mX,
		Y = object.mUser1.mY
	}, {
		X = object.mUser2.mX,
		Y = object.mUser2.mY
	})
	mMovie:__wf_atom_4c1c1986(object.mClipName, "InnerLine", 15, distanceBetweenPoints * (alpha / 100))
end

local function fn3(state)
	local v6 = (state.mDelta + total) % 21.991148575128552
	local v7 = v6 / 21.991148575128552
	local v8 = v6 * state.mSpin + state.mSpinDelta
	local v9 = 100 + 150 * (1 - v7)
	state.mX = -math.sin(v8) * v9
	mMovie:__wf_atom_e57658c2(state.mClipName, 0, state.mX)
	state.mY = math.cos(v8) * v9
	mMovie:__wf_atom_e57658c2(state.mClipName, 1, state.mY)
	local v10 = v6 / 21.991148575128552
	local v11

	if v10 > 0.85 then
		v11 = 1 - (v10 - 0.85) / 0.15
	else
		v11 = not (v10 < 0.15) and 1 or v10 / 0.15
	end

	state.mAlpha = v11 * 100
	mMovie:__wf_atom_e57658c2(state.mClipName, 12, state.mAlpha)
	local v12 = __wf_atom_104bfe98(state.mOffScale, state.mScale, v11)
	mMovie:__wf_atom_e57658c2(state.mClipName, 5, v12)
	mMovie:__wf_atom_e57658c2(state.mClipName, 6, v12)
end

local function fn4(mUser, mUser2, _)
	if mUser == mUser2 then
		return
	end

	count2 += 1
	local v6 = {
		mUser1 = mUser,
		mUser2 = mUser2,
		GetAlpha = function(self)
			return (math.min(self.mUser1.mAlpha, self.mUser2.mAlpha))
		end,
		mClipName = "NexusContainer.Line" .. count2,
		mId = count2
	}

	if not mMovie:__wf_atom_253d7085(v6.mClipName) then
		local v7 = StringSplit(".", v6.mClipName)
		__wf_atom_86cbd68d(mMovie, "NexusContainer.Line1.duplicateMovieClip", v7[#v7], count2)
	end

	mMovie:__wf_atom_e57658c2(v6.mClipName, 11, v5.FloatingContent)
	mMovie:OverrideMaterial(v6.mClipName .. ".InnerLine", lineMaterial)
	table.insert(v4, v6)
end

local function fn5(total2)
	count += 1
	local v6 = {
		mDelta = total2,
		mClipName = "NexusContainer.User" .. count,
		mId = count
	}

	if not mMovie:__wf_atom_253d7085(v6.mClipName) then
		local v7 = StringSplit(".", v6.mClipName)
		__wf_atom_86cbd68d(mMovie, "NexusContainer.User1.duplicateMovieClip", v7[#v7], count + 1000)
	end

	v6.mSpinDelta = count % 3 / 3 * 6.283185307179586
	v6.mSpin = 0.15
	v6.mOffScale = __wf_atom_5784a397(1, 60)
	v6.mScale = __wf_atom_5784a397(10, 30)
	v6.mAlpha = 0
	mMovie:__wf_atom_e57658c2(v6.mClipName, 11, v5.FloatingContent)
	mMovie:__wf_atom_933bbce0(v6.mClipName, userIcon, lineMaterial)
	table.insert(v3, v6)
end

local function fn6()
	total = 0

	while total < 21.991148575128552 do
		fn5(total)

		if #v3 > 3 then
			fn4(v3[#v3], v3[#v3 - 3])
		end

		total += Random(0.35, 1)
	end

	local shuffleTable = module3.ShuffleTable(module3.CopyTable(v3))
	local shuffleTable2 = module3.ShuffleTable(module3.CopyTable(v3))

	for i = 1, #shuffleTable do
		fn4(shuffleTable[i], shuffleTable2[i])
	end
end

function Initialize()
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	mMovie:__wf_atom_f0448d34(not __wf_atom_7e8ad928(_T.RailjackHud_Movie))
	v5.FloatingContent = module.GetColor(9, true)
	fn6()
	local module5 = require("Lotus.Interface.Components.ThemedSpinner")
	v2 = module5.Create(mMovie, "Spinner")
	v2:SetActive(false)
	mMovie:__wf_atom_e57658c2("Spinner", 5, 100)
	mMovie:__wf_atom_e57658c2("Spinner", 6, 100)
	mMovie:__wf_atom_7d7314f1("MissionName.MissionName.text", "/Lotus/Language/SquadLink/SquadLink")
	mMovie:__wf_atom_7d7314f1("Success.Success.text", "/Lotus/Language/SquadLink/Available")
	mMovie:__wf_atom_7d7314f1("Desc.Description.text", "/Lotus/Language/SquadLink/SendHint")
end

function Update()
	local v6 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v6)
	total += __wf_atom_084b3e93() * 1.5

	for i = 1, #v3 do
		fn3(v3[i])
	end

	for i = 1, #v4 do
		fn2(v4[i])
	end

	if not __wf_atom_7e8ad928(v) then
		v:Update(v6)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v6)
	end

	if flag then
		mMovie:Close()
	end
end

function SetShrunk()
	v2:SetActive(true)
	__wf_atom_ec43d06e(mMovie, "NexusContainer", 8, { 12 }, { 0 }, 0.5)
	__wf_atom_86cbd68d(mMovie, "_root.gotoAndPlay", "Shrunk")
end

function SetAccepted()
	v2:SetActive(false)
	__wf_atom_ec43d06e(mMovie, "NexusContainer", 8, { 12 }, { 100 }, 0.5)
	mMovie:__wf_atom_50d60589("Success.Success", 36, "ACCEPTED")
	mMovie:__wf_atom_7d7314f1("Desc.Description.text", "/Lotus/Language/SquadLink/AcceptedDesc")
	__wf_atom_86cbd68d(mMovie, "_root.gotoAndPlay", "Accepted")
	v:AddTimer(0.3, function()
		if not __wf_atom_7e8ad928(burstFx) then
			local rootBasedPosition, v6 = module2.GetRootBasedPosition(mMovie, "Success")
			local screenParticles = module2.CreateScreenParticles(
				mMovie,
				burstFx,
				rootBasedPosition,
				v6,
				__wf_atom_392793db
			)
			module2.ApplyParticleThemeColors(screenParticles)
		end
	end)
	v:AddTimer(5, fn)
end

function SupportsThemes()
	return true
end

function TrySendBeacon()
	local v6 = _T.ScenarioState and _T.ScenarioState.ActiveScenario and not _T.ScenarioSendBeaconRequest

	if v6 then
		_T.ScenarioSendBeaconRequest = true
		_T.ScenarioBeaconRequestSent = true
	end

	return v6
end