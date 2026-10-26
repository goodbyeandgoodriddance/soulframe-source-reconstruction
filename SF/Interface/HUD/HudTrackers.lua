local module = require("SF.Scripts.HudTrackers")
require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.Libs.TimerMgr")
local module3 = require("EE.Interface.AnchorMgr")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module5 = require("SF.Interface.SFUtilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = 0
local v5 = nil
local v6 = {}
local v7 = { Initialized = false, mDispatchingQueuedFuncs = false }
local playerAvatar = nil
local gGameRules2 = nil

local function fn(callback, ...)
	if not v7.Initialized then
		return
	end

	if v7.mDispatchingQueuedFuncs then
		callback(...)
		return
	end

	table.insert(v6, { callback, ... })

	if #v6 > 400 and _G.functionQueueOverflow == nil then
		LogBug("Hud queue overflow")
		_G.functionQueueOverflow = true
	end
end

local function fn2(p)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	table.sort(p.List, function(a, b)
		if a.Data.SortPriority == b.Data.SortPriority then
			return a.Index < b.Index
		end

		return a.Data.SortPriority < b.Data.SortPriority
	end)
	local v8 = 0

	for _, v9 in ipairs(p.List) do
		if v9.NeedsInit or v9.Removing then
			continue
		end

		if v9.Data.IgnoreStacking or v9.Visible == false then
			local offsetY = v9.Data.OffsetY
			mMovie:__wf_atom_e57658c2(v9.ClipName, 1, offsetY)
		else
			local v10 = v8 + v9.Data.OffsetY
			mMovie:__wf_atom_e57658c2(v9.ClipName, 1, v10)

			if v9.Data.Height + v9.Data.OffsetY >= 0 then
				v8 = v8 + v9.Data.Height + v9.Data.OffsetY
			end

			if v9.Data.Padding ~= nil then
				v8 += v9.Data.Padding
			end
		end

		if v9.Data.OffsetX ~= 0 then
			mMovie:__wf_atom_e57658c2(v9.ClipName, 0, v9.BaseX + v9.Data.OffsetX)
		end
	end

	if v4 ~= v8 then
		v4 = v8
	end
end

function onViewportSizeChanged(_, _)
	if v2 ~= nil then
		v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end

function Initialize()
	v = module2.CreateTimerMgr()
	v2 = module3.Create(mMovie, true)
	v2:Register(mMovie, "HudTracker", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "SmallNotification", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())

	for _, v8 in ipairs({
		"ProgressBar",
		"Timer",
		"HealthTracker",
		"OpponentBar",
		"Label",
		"IconBar",
		"TemperatureBar",
		"CorruptionMeter",
		"ProgressTracker"
	}) do
		mMovie:__wf_atom_7f57ab2f("HudTracker.Trackers", v8, 13, false)
	end

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_48bd5a59("HudTracker.Trackers", "Label", 49, "Arial Unicode MS")
		mMovie:__wf_atom_48bd5a59("HudTracker.Trackers.HealthTracker", "Name", 49, "Arial Unicode MS")
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v5 = __wf_atom_18a5d83b:Settings()
	end

	local __wf_atom_7be51ede = mMovie:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		playerAvatar = __wf_atom_7be51ede:GetPlayerAvatar(0)
	end

	local v8 = {
		defaultBroadcastIcon = defaultBroadcastIcon,
		healthShieldDisplayType = healthShieldDisplayType,
		defenseTargetNearDeath = defenseTargetNearDeath,
		timeLostFx = timeLostFx,
		radialProgressMaterial = radialProgressMaterial,
		temperatureSegmentMaterial = temperatureSegmentMaterial,
		corruptionFillMaterial = corruptionFillMaterial
	}
	module.Initialize(mMovie, v5, v, v8, fn, fn, fn2)
	mMovie:OverrideMaterial("SmallNotification.Notification.Banner", _G.UIMaterial_DarkPaperBacker)
	mMovie:__wf_atom_2dedec1a("SmallNotification.Notification", 13, false)
	mMovie:__wf_atom_2dedec1a("SmallNotification", 13, true)
	_T.ShowEncounterNotification = EnableHudAlert
	_T.HideEncounterNotification = DisableHudAlert
	_T.AddHudTracker = module.AddHudTracker
	_T.GetHudTracker = module.GetHudTracker
	v7.Initialized = true
end

function Update()
	if __wf_atom_7e8ad928(gGameRules2) or gGameRules2 ~= gGameRules then
		gGameRules2 = gGameRules
		module.SetGameRules(gGameRules2)
	end

	local v8 = __wf_atom_084b3e93()
	local v9 = __wf_atom_fa1258d0()
	local __wf_atom_7be51ede = mMovie:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		playerAvatar = __wf_atom_7be51ede:GetPlayerAvatar(0)
	end

	local v10 = _T.HideHud ~= nil and _T.HideHud > 0 or _T.TopMenuOpen

	if not __wf_atom_7e8ad928(playerAvatar) then
		v10 = v10 or playerAvatar:IsKilled() or module4.IsStreamingLevel()
	end

	mMovie:SetVisible(not v10)
	mMovie:__wf_atom_88d9cd84(v9)

	if not __wf_atom_7e8ad928(v) then
		v:Update(v8)
	end

	v7.mDispatchingQueuedFuncs = true

	if #v6 > 0 then
		for i = 1, #v6 do
			v6[i][1](
				v6[i][2],
				v6[i][3],
				v6[i][4],
				v6[i][5],
				v6[i][6],
				v6[i][7],
				v6[i][8],
				v6[i][9],
				v6[i][10],
				v6[i][11],
				v6[i][12]
			)
		end

		v6 = {}
	end

	v7.mDispatchingQueuedFuncs = false
	UpdateHudAlert()
	module.UpdateHudTrackers(v8)
end

function Shutdown() end

local function fn3()
	if
		not mMovie:IsVisible()
		or (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:__wf_atom_799d95f5())
	then
		return false
	end

	if __wf_atom_7e8ad928((playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa())) then
		return false
	end

	local v8

	if _T.HideHudSelective == nil then
		v8 = false
	else
		v8 = _T.HideHudSelective > 0
	end

	return not v8 and not (_T.IsNightfoldAlertActive and _T.IsNightfoldAlertActive())
end

local function fn4()
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:__wf_atom_799d95f5() then
		return false
	end

	if _T.TutorialStepTalisman then
		return true
	end

	local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()
	local __wf_atom_a4299765 = gGameData:__wf_atom_a4299765()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if
		not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
		and module5.AreUpgradesAvailableForSkillTree(
			__wf_atom_d2b2176d,
			Resource(__wf_atom_e55d02aa:__wf_atom_c45b4ac3())
		)
	then
		return true
	end

	local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(0, 3)
	local v8 = not __wf_atom_7e8ad928(__wf_atom_ed5c034d) and Resource(__wf_atom_ed5c034d.mItemType)
	local mItemId = __wf_atom_ed5c034d.mItemId
	local v9

	if __wf_atom_7e8ad928(v8) then
		v9 = false
	else
		v9 = module5.AreUpgradesAvailableForSkillTree(__wf_atom_d2b2176d, Resource(v8:__wf_atom_c45b4ac3())) and true
			or module5.DoesWeaponHaveFillableRuneSlot(v8, mItemId) and true
			or false
	end

	if v9 then
		return true
	end

	local __wf_atom_ed5c034d2 = __wf_atom_a4299765:__wf_atom_ed5c034d(0, 2)
	local v10 = not __wf_atom_7e8ad928(__wf_atom_ed5c034d2) and Resource(__wf_atom_ed5c034d2.mItemType)
	local mItemId2 = __wf_atom_ed5c034d2.mItemId
	local v11

	if __wf_atom_7e8ad928(v10) then
		v11 = false
	else
		v11 = module5.AreUpgradesAvailableForSkillTree(__wf_atom_d2b2176d, Resource(v10:__wf_atom_c45b4ac3()))
			and true
			or module5.DoesWeaponHaveFillableRuneSlot(v10, mItemId2) and true
			or false
	end

	if v11 then
		return true
	end

	return false
end

function UpdateHudAlert()
	local v8 = fn3()

	if v3 ~= v8 then
		if v8 then
			__wf_atom_ec43d06e(mMovie, "SmallNotification", 8, { 12 }, { 100 }, 0.25, 0.25)

			if fn4() then
				EnableHudAlert("/SF/Language/Menu/UpgradesAvailableInNightfold")
			else
				DisableHudAlert()
			end
		else
			mMovie:__wf_atom_290807ee("SmallNotification")
			mMovie:__wf_atom_e57658c2("SmallNotification", 12, 0)
		end

		v3 = v8
	end
end

function EnableHudAlert(p)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_2dedec1a("SmallNotification.Notification", 13, true)
	mMovie:__wf_atom_e57658c2("SmallNotification.Notification", 12, 0)
	__wf_atom_ec43d06e(mMovie, "SmallNotification.Notification", 8, { 12 }, { 100 }, 1 / 3)
	local function fn5()
		if not v3 then
			return
		end

		__wf_atom_ec43d06e(mMovie, "SmallNotification.Notification.Decal.Glow", 0, { 16 }, { 359 }, 25, 0, fn5)
	end

	mMovie:__wf_atom_4c1c1986("SmallNotification.Notification", "LongGlow", 12, 0)
	mMovie:__wf_atom_4c1c1986("SmallNotification.Notification", "Decal.Glow", 12, 50)
	__wf_atom_ec43d06e(mMovie, "SmallNotification.Notification.LongGLow", 8, { 12 }, { 20 }, 0.5, 0, function()
		__wf_atom_ec43d06e(mMovie, "SmallNotification.Notification.LongGlow", 8, { 12 }, { 0 }, 0.5)
	end)
	mMovie:__wf_atom_c90af43a("SmallNotification.Notification.Decal.Icon", newAlertIcon)
	mMovie:__wf_atom_48bd5a59("SmallNotification.Notification", "Label", 36, mMovie:__wf_atom_8e9ac384(p, true))
	mMovie:__wf_atom_4c1c1986("SmallNotification.Notification", "Label", 11, _G.UIColor_Yellow)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("SmallNotification.Notification", "Label", 40)
	local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35("SmallNotification.Notification", "Label", 0)
	mMovie:__wf_atom_4c1c1986("SmallNotification.Notification", "Banner", 14, __wf_atom_cfc41e35 + 70)
	mMovie:__wf_atom_4c1c1986(
		"SmallNotification.Notification",
		"LongGlow",
		0,
		__wf_atom_cfc41e35_2 + __wf_atom_cfc41e35 / 2
	)
	mMovie:__wf_atom_4c1c1986("SmallNotification.Notification", "LongGlow", 14, __wf_atom_cfc41e35 + 300)
	fn5()
end

function DisableHudAlert()
	__wf_atom_ec43d06e(mMovie, "SmallNotification.Notification", 8, { 12 }, { 0 }, 1, 0, function()
		mMovie:__wf_atom_2dedec1a("SmallNotification.Notification", 13, false)
	end)
end