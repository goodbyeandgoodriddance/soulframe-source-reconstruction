module(..., package.seeall)
local v = {
	"/Lotus/Language/Objectives/ObjectiveTimeLeft",
	"/Lotus/Language/Objectives/ObjectiveTimeLimit",
	"/Lotus/Language/Objectives/ObjectiveTimeNextWave"
}
local v2 = Resource("/Lotus/Interface/Icons/GameModes/GenericObjectiveIcon.png")
local v3 = nil
local v4 = Symbol("GhostTower")
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local v5 = nil

local function fn(__wf_atom_72fc675e) -- 1 equivalent call inferred from this helper
	return string.find(tostring(__wf_atom_72fc675e.activeMissionTag), "Void")
end

local function fn2(__wf_atom_72fc675e) -- 1 equivalent call inferred from this helper
	return __wf_atom_72fc675e.missionType == 28
end

local function fn3()
	if v5 ~= nil then
		return v5
	end

	v5 = 1
	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

	if __wf_atom_7e8ad928(__wf_atom_72fc675e) then
		return v5
	end

	if __wf_atom_72fc675e.goalTag == v4 or fn(__wf_atom_72fc675e) then -- inferred equivalent call
		v5 = 10
	elseif fn2(__wf_atom_72fc675e) then -- inferred equivalent call
		v5 = 5
	end

	return v5
end

NO_ICON = 0
GENERIC_ICON = 1
ATTACK_ICON = 2
EXTRACT_ICON = 3
LOOT_ICON = 4
DEFEND_ICON = 5
LETTER_ICON_A = 6
LETTER_ICON_B = 7
LETTER_ICON_C = 8
LETTER_ICON_D = 9
LETTER_ICON_E = 10
LETTER_ICON_F = 11
ALERT_PANEL = 12
NEW_QUEST = 13
GRINEEROBJ_ICON = 14
CORPUSOBJ_ICON = 15
TESHINOBJ_ICON = 16
DRIFTEROBJ_ICON = 17
local v6 = nil

local function fn4()
	if not v6 then
		v6 = {
			{ icon = "<MISSION_MARKER_GENERIC>", color = 39 },
			{ icon = "<MISSION_MARKER_ATTACK>", color = 2 },
			{ icon = "<MISSION_MARKER_EXTRACTION>", color = 17 },
			{ icon = "<MISSION_MARKER_LOOT>", color = 32 },
			{ icon = "<MISSION_MARKER_DEFEND>", color = 39 },
			{ icon = "<MISSION_MARKER_A>", color = 39 },
			{ icon = "<MISSION_MARKER_B>", color = 39 },
			{ icon = "<MISSION_MARKER_C>", color = 39 },
			{ icon = "<MISSION_MARKER_D>", color = 39 },
			{ icon = "<MISSION_MARKER_E>", color = 39 },
			{ icon = "<MISSION_MARKER_F>", color = 39 },
			{ icon = "<MISSION_MARKER_ALERT>", color = 39 },
			{ icon = "<QUEST>", color = 20 },
			{ icon = "<MISSION_MARKER_GRN>", color = 39 },
			{ icon = "<MISSION_MARKER_CRP>", color = 39 },
			{ icon = "<MISSION_MARKER_TSH>", color = 39 },
			{ icon = "<MISSION_MARKER_DRFT>", color = 39 }
		}
	end

	return v6
end

local function fn5(data, color) -- 1 equivalent call inferred from this helper
	local v7 = __wf_atom_7e8ad928(color) and 20 or color
	return "<font color=\"" .. data.Colorize(v7) .. "\">"
end

local function fn6(data, p, p2, p3, _, p4, p5)
	local v7 = "<p>"
	local v8 = " "
	local v9 = fn4()

	if p2 > 0 and p2 <= #v9 then
		v7 ..= fn5(data, v9[p2].color) .. data.Localize(v9[p2].icon) .. "</font>" -- inferred equivalent call
	elseif p2 == 0 then
		v8 = ""
	end

	local v10 = __wf_atom_7e8ad928(p5) and true or p5
	local localize = data.Localize(p, nil, v10)
	local v11

	if p4 then
		v11 = v7 .. "<font face=\"Noto Sans\" color=\"" .. data.Colorize(41) .. "\"><b>" .. v8 .. localize
	else
		v11 = v7 .. "<font face=\"Noto Sans\" color=\"" .. data.Colorize(41) .. "\">" .. v8 .. localize
	end

	if p3 then
		v11 ..= p3
	end

	local v12

	if p4 then
		v12 = v11 .. "</b></font></p>"
	else
		v12 = v11 .. "</font></p>"
	end

	data.SetLabel(v12)
end

local function fn7()
	if __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) and _T.GetHudTracker then
		_T.SecObjectiveHudTracker = {}

		for i = 1, 5 do
			local v7 = "SecObjectiveUIText" .. i
			local hudTracker = _T.GetHudTracker(v7)

			if not __wf_atom_7e8ad928(hudTracker) and hudTracker.Removing then
				hudTracker = nil
			end

			if not __wf_atom_7e8ad928(hudTracker) then
				table.insert(_T.SecObjectiveHudTracker, hudTracker)
			end
		end
	end
end

local function fn8(p)
	if _T.ObjProgressBar == nil then
		_T.ObjProgressBar = {}
	end

	if _T.ObjProgressBar[p] == nil and _T.GetHudTracker then
		local hudTracker = _T.GetHudTracker(p)

		if hudTracker ~= nil and not hudTracker.Removing then
			_T.ObjProgressBar[p] = hudTracker
		end
	end
end

local function fn9(p)
	if _T.ObjectiveTimer == nil then
		_T.ObjectiveTimer = {}
	end

	if _T.ObjectiveTimer[p] == nil and _T.GetHudTracker then
		local hudTracker = _T.GetHudTracker(p)

		if hudTracker ~= nil and not hudTracker.Removing then
			_T.ObjectiveTimer[p] = hudTracker
		end
	end
end

local function fn10()
	if __wf_atom_7e8ad928(_T.ExtractionTimer) and _T.GetHudTracker then
		_T.ExtractionTimer = _T.GetHudTracker("ExtractionTimer")

		if not __wf_atom_7e8ad928(_T.ExtractionTimer) and _T.ExtractionTimer.Removing then
			_T.ExtractionTimer = nil
		end
	end
end

FONT_XS = 16
FONT_S = 18
FONT_M = 20
FONT_L = 22
FONT_XL = 24

function DestroyAllTrackers()
	_T.ObjectiveTitleTracker = nil
	_T.ObjectiveSubTitleTracker = nil
	_T.ObjectiveHudTracker = nil
	_T.SecObjectiveHudTracker = nil
	_T.ObjProgressBar = nil
	_T.NpcHealthTracker = nil
	_T.ObjectiveTimer = nil
	_T.CachesHudTracker = nil
	_T.LootChallengeTitle = nil
	_T.LootChallengeTimer = nil
	_T.ExtractionTimer = nil
	_T.BonusTracker = nil
	_T.DebugHudTracker = nil
end

function SetTitleObjText(p, p2, p3, p4, p5)
	local v7 = fn3()

	if __wf_atom_7e8ad928(_T.AddHudTracker) then
		module2.ShowErrorMessage("[HC] SetTitleObjText _T.AddHudTracker is invalid!")
		return
	end

	if _T.ObjectiveTitleTracker == nil then
		_T.ObjectiveTitleTracker = {}
	end

	local v8 = "TitleUIText"

	if _T.DuviriActivityId ~= nil then
		v8 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p5 ~= nil then
		v8 ..= p5
	end

	local objectiveTitleTracker = _T.ObjectiveTitleTracker
	local v9 = objectiveTitleTracker[v8]

	if v9 == nil then
		v9 = nil
	elseif __wf_atom_7e8ad928(v9.Movie) then
		objectiveTitleTracker[v8] = nil
		v9 = nil
	end

	if v9 == nil then
		v9 = _T.AddHudTracker(v8, module.HT_LABEL, 0.5, v7, true)

		if _T.DuviriActivityId ~= nil then
			v9.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.ObjectiveTitleTracker[v8] = v9
	end

	local v10 = __wf_atom_7e8ad928(p3) and true or p3
	local v11 = __wf_atom_7e8ad928(p4) and 20 or __wf_atom_421b01aa(p4, 16, 24)
	local localize = v9.Localize(p, nil, v10)
	local v12 = "<p><font face=\"Noto Sans\" color=\"" .. v9.Colorize(41) .. "\" size=\"" .. v11 .. "\"><b>" .. localize

	if p2 then
		v12 ..= p2
	end

	local v13 = v12 .. "</b></font></p>"
	v9.SetLabel(v13)
end

function ClearTitleObjText(p)
	local v7 = "TitleUIText"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p ~= nil then
		v7 ..= p
	end

	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker(v7, 0.5)
	end

	if _T.ObjectiveTitleTracker ~= nil then
		_T.ObjectiveTitleTracker[v7] = nil
	end
end

function SetSubTitleObjText(p, p2, p3)
	local v7 = fn3() + 1

	if __wf_atom_7e8ad928(_T.AddHudTracker) then
		module2.ShowErrorMessage("[HC] SetSubTitleObjText _T.AddHudTracker is invalid!")
		return
	end

	if _T.ObjectiveSubTitleTracker == nil then
		_T.ObjectiveSubTitleTracker = {}
	end

	local v8 = "SubTitleUIText"

	if _T.DuviriActivityId ~= nil then
		v8 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p3 ~= nil then
		v8 ..= p3
	end

	local objectiveSubTitleTracker = _T.ObjectiveSubTitleTracker
	local v9 = objectiveSubTitleTracker[v8]

	if v9 == nil then
		v9 = nil
	elseif __wf_atom_7e8ad928(v9.Movie) then
		objectiveSubTitleTracker[v8] = nil
		v9 = nil
	end

	if v9 == nil then
		v9 = _T.AddHudTracker(v8, module.HT_LABEL, 0.5, v7, true)

		if _T.DuviriActivityId ~= nil then
			v9.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.ObjectiveSubTitleTracker[v8] = v9
	end

	local localize = v9.Localize(p, nil, true)
	local v10 = "<p><font face=\"Noto Sans\" color=\"" .. v9.Colorize(41) .. "\" size=\"14\">" .. localize

	if p2 then
		v10 ..= p2
	end

	local v11 = v10 .. "</font></p>"
	v9.SetLabel(v11)
	v9.SetOffset(0, -15, true)
end

function ClearSubTitleObjText(p)
	local v7 = "SubTitleUIText"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p ~= nil then
		v7 ..= p
	end

	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker(v7, 0.5)
	end

	if _T.ObjectiveSubTitleTracker ~= nil then
		_T.ObjectiveSubTitleTracker[v7] = nil
	end
end

function SetPrimaryObjText(p, p2, p3, p4, p5)
	local v7 = fn3() + 2
	local v8 = not __wf_atom_7e8ad928(_T.ActiveJob)
	local isQuest = v8 and _T.ActiveJob.isQuest
	local v9 = not p4
	local v10 = (__wf_atom_7e8ad928(p2) or p2 < 0) and 1 or p2

	if __wf_atom_7e8ad928(_T.AddHudTracker) then
		module2.ShowErrorMessage("[HC] SetPrimaryObjText _T.AddHudTracker is invalid!")
		return
	end

	if _T.ObjectiveHudTracker == nil then
		_T.ObjectiveHudTracker = {}
	end

	local v11 = "ObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v11 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p5 ~= nil then
		v11 ..= p5
	end

	local objectiveHudTracker = _T.ObjectiveHudTracker
	local v12 = objectiveHudTracker[v11]

	if v12 == nil then
		v12 = nil
	elseif __wf_atom_7e8ad928(v12.Movie) then
		objectiveHudTracker[v11] = nil
		v12 = nil
	end

	if v12 == nil then
		v12 = _T.AddHudTracker(v11, module.HT_LABEL, 0.5, v7, v9)

		if _T.DuviriActivityId ~= nil then
			v12.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.ObjectiveHudTracker[v11] = v12
	end

	if __wf_atom_7e8ad928(_T.VoidTearProgress) then
		v12.SetOffset(0, module2.Ternary(v8, -5, 0), true)
	else
		v12.SetOffset(0, 20, true)
	end

	fn6(v12, p, v10, p3, v7, not isQuest)
	return v12
end

function ClearPrimaryObjText(p)
	if p == nil then
		print("ObjectiveText.lua::ClearPrimaryObjText()")
	else
		print("ObjectiveText.lua::ClearPrimaryObjText(" .. p .. ")")
	end

	local v7 = "ObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p ~= nil then
		v7 ..= p
	end

	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker(v7, 0.5)
	end

	if _T.ObjectiveHudTracker ~= nil then
		_T.ObjectiveHudTracker[v7] = nil
	end
end

function SetPrimaryObjVisible(p, p2)
	if _T.ObjectiveHudTracker == nil then
		return
	end

	local v7 = "ObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p2 ~= nil then
		v7 ..= p2
	end

	if _T.ObjectiveHudTracker[v7] == nil then
		return
	end

	_T.ObjectiveHudTracker[v7].SetVisible(p)
end

function SetSecondaryObjText(p, p2, p3, p4, p5)
	local v7 = fn3() + 3
	local v8 = (__wf_atom_7e8ad928(p2) or p2 < 0) and 1 or p2

	if __wf_atom_7e8ad928(p4) then
		p4 = __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) and 1 or math.min(#_T.SecObjectiveHudTracker, 10)
	end

	if __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) then
		_T.SecObjectiveHudTracker = {}
	end

	for i = 1, p4 do
		if __wf_atom_7e8ad928(_T.SecObjectiveHudTracker[i]) then
			table.insert(_T.SecObjectiveHudTracker, false)
		end
	end

	local v9 = not p5
	local v10 = "SecObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v10 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p4 ~= nil then
		v10 ..= p4
	end

	local secObjectiveHudTracker = _T.SecObjectiveHudTracker
	local v11 = secObjectiveHudTracker[v10]

	if v11 == nil then
		v11 = nil
	elseif __wf_atom_7e8ad928(v11.Movie) then
		secObjectiveHudTracker[v10] = nil
		v11 = nil
	end

	if v11 == nil then
		v11 = _T.AddHudTracker(v10, module.HT_LABEL, 0.5, v7, v9)
		v11.SetOffset(27, -14, true)

		if _T.DuviriActivityId ~= nil then
			v11.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.SecObjectiveHudTracker[p4] = v11
	end

	fn6(v11, p, v8, p3, v7, false)
	return v11
end

function ClearSecondaryObjText(p)
	fn7()

	if __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) then
		return
	end

	if __wf_atom_7e8ad928(p) then
		if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
			for i = 1, #_T.SecObjectiveHudTracker do
				local v7 = "SecObjectiveUIText"

				if _T.DuviriActivityId ~= nil then
					v7 ..= "_" .. _T.DuviriActivityId .. "d"
				end

				if i ~= nil then
					v7 ..= i
				end

				_T.RemoveHudTracker(v7, 0.5)
			end
		end

		_T.SecObjectiveHudTracker = nil
	else
		local v7 = "SecObjectiveUIText"

		if _T.DuviriActivityId ~= nil then
			v7 ..= "_" .. _T.DuviriActivityId .. "d"
		end

		if p ~= nil then
			v7 ..= p
		end

		if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
			_T.RemoveHudTracker(v7, 0.5)
		end

		_T.SecObjectiveHudTracker[p] = nil
	end
end

function GetSecondaryObjTracker(p)
	if __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) then
		return
	end

	local v7 = __wf_atom_7e8ad928(p) and 1 or p

	if not __wf_atom_7e8ad928(_T.SecObjectiveHudTracker[v7]) then
		fn7()

		if not __wf_atom_7e8ad928(_T.SecObjectiveHudTracker[v7]) then
			return _T.SecObjectiveHudTracker[v7]
		end
	end
end

function SetSecondaryObjVisible(p, p2)
	if _T.SecObjectiveHudTracker == nil then
		return
	end

	if p2 == nil then
		p2 = __wf_atom_7e8ad928(_T.SecObjectiveHudTracker) and 1 or math.min(#_T.SecObjectiveHudTracker, 10)
	end

	local v7 = "SecObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p2 ~= nil then
		v7 ..= p2
	end

	if _T.SecObjectiveHudTracker[v7] == nil then
		return
	end

	_T.SecObjectiveHudTracker[v7].SetVisible(p)
end

function SetObjProgressBar(p, p2, p3, p4, p5, p6, p7, p8, p9)
	local v7 = fn3() + 4
	local v8 = not p7

	if _T.ObjProgressBar == nil then
		_T.ObjProgressBar = {}
	end

	local v9 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v9 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p9 ~= nil then
		v9 ..= p9
	end

	local objProgressBar = _T.ObjProgressBar
	local v10 = objProgressBar[v9]

	if v10 == nil then
		v10 = nil
	elseif __wf_atom_7e8ad928(v10.Movie) then
		objProgressBar[v9] = nil
		v10 = nil
	end

	if v10 == nil then
		v10 = _T.AddHudTracker(v9, module.HT_PROGRESS_BAR, 0.5, v7, v8)
		v10.SetOffset(30, 8, true)

		if _T.DuviriActivityId ~= nil then
			v10.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.ObjProgressBar[v9] = v10
	end

	local v11 = __wf_atom_7e8ad928(p6)
		and (p5 and "/Lotus/Language/Menu/ProgressPercentage" or "/Lotus/Language/Menu/ProgressXOfY")
		or p6

	if __wf_atom_7e8ad928(p4) then
		p4 = v2
	end

	local current = __wf_atom_7e8ad928(p2) and 0 or p2
	local total = (__wf_atom_7e8ad928(p3) or p3 == 0) and 100 or p3

	if not __wf_atom_7e8ad928(p8) then
		v10.SetIconSize(p8)
	end

	v10.SetSortPriority(v7, false)
	v10.SetIcon(p4)
	v10.SetLabel(p, 1)
	v10.SetGoalLabel(v10.Localize(v11, { CURRENT = current, TOTAL = total }))
	v10.SetValue(current / total)
	return v10
end

function SetObjProgressBarLabel(p, p2)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p2 ~= nil then
		v7 ..= p2
	end

	fn8(v7)
	local objProgressBar = _T.ObjProgressBar
	local v8 = objProgressBar[v7]

	if v8 == nil then
		v8 = nil
	elseif __wf_atom_7e8ad928(v8.Movie) then
		objProgressBar[v7] = nil
		v8 = nil
	end

	if v8 == nil then
		return
	end

	v8.SetLabel(p, 1)
end

function UpdateObjProgressBar(current, p, p2, p3)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p3 ~= nil then
		v7 ..= p3
	end

	fn8(v7)
	local objProgressBar = _T.ObjProgressBar
	local v8 = objProgressBar[v7]

	if v8 == nil then
		v8 = nil
	elseif __wf_atom_7e8ad928(v8.Movie) then
		objProgressBar[v7] = nil
		v8 = nil
	end

	if v8 == nil then
		return
	end

	local total = (__wf_atom_7e8ad928(p) or p == 0) and 100 or p
	local v9 = __wf_atom_7e8ad928(p2) and "/Lotus/Language/Menu/ProgressXOfY" or p2
	v8.SetGoalLabel(v8.Localize(v9, { CURRENT = current, TOTAL = total }))
	v8.SetValue((math.min(1, current / total)))
end

function UpdateObjProgressBarPct(current, p, p2)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p2 ~= nil then
		v7 ..= p2
	end

	fn8(v7)
	local objProgressBar = _T.ObjProgressBar
	local v8 = objProgressBar[v7]

	if v8 == nil then
		v8 = nil
	elseif __wf_atom_7e8ad928(v8.Movie) then
		objProgressBar[v7] = nil
		v8 = nil
	end

	if v8 == nil then
		return
	end

	local total = (__wf_atom_7e8ad928(p) or p == 0) and 100 or p
	v8.SetGoalLabel(v8.Localize("/Lotus/Language/Menu/ProgressPercentage", {
		CURRENT = current,
		TOTAL = total
	}))
	v8.SetValue(current / total)
end

function SetObjProgressBarColor(value, p, p2, p3)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p3 ~= nil then
		v7 ..= p3
	end

	fn8(v7)
	local objProgressBar = _T.ObjProgressBar
	local v8 = objProgressBar[v7]

	if v8 == nil then
		v8 = nil
	elseif __wf_atom_7e8ad928(v8.Movie) then
		objProgressBar[v7] = nil
		v8 = nil
	end

	if v8 == nil then
		return
	end

	local v9 = type(value) ~= "number" and 41 or value
	v8.SetIconColor(v9)
	v8.SetGoalColor(v9)
	v8.SetLabelColor(v9)
	v8.SetProgressColor(v9, true)
	v8.SetBlinkColor(p, p2)
end

function RemoveObjProgressBar(p)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p ~= nil then
		v7 ..= p
	end

	if _T.ObjProgressBar[v7] ~= nil then
		if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
			_T.RemoveHudTracker(v7, 0.5)
		end

		_T.ObjProgressBar[v7] = nil
	end
end

function GetObjProgressBarTracker(p)
	if _T.ObjProgressBar == nil then
		return nil
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p ~= nil then
		v7 ..= p
	end

	fn8(v7)
	return _T.ObjProgressBar[v7]
end

function SetObjProgressBarVisible(p, p2)
	if _T.ObjProgressBar == nil then
		return
	end

	local v7 = "ObjProgressBar"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if p2 ~= nil then
		v7 ..= p2
	end

	local objProgressBar = _T.ObjProgressBar
	local v8 = objProgressBar[v7]

	if v8 == nil then
		v8 = nil
	elseif __wf_atom_7e8ad928(v8.Movie) then
		objProgressBar[v7] = nil
		v8 = nil
	end

	if v8 ~= nil then
		v8.SetVisible(p)
	end
end

function SetNpcHealthTracker(p, p2)
	local v7 = fn3() + 5
	local v8 = __wf_atom_7e8ad928(p2) and 20 or p2

	if _T.NpcHealthTracker == nil then
		_T.NpcHealthTracker = {}
	end

	local v9 = "NpcHealthTracker"

	if _T.DuviriActivityId ~= nil then
		v9 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	local npcHealthTracker = _T.NpcHealthTracker
	local v10 = npcHealthTracker[v9]

	if v10 == nil then
		v10 = nil
	elseif __wf_atom_7e8ad928(v10.Movie) then
		npcHealthTracker[v9] = nil
		v10 = nil
	end

	if v10 == nil then
		v10 = _T.AddHudTracker(v9, module.HT_HEALTH_TRACKER, 0.5, v7, true)
		v10.SetOffset(30, 5, true)

		if _T.DuviriActivityId ~= nil then
			v10.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.NpcHealthTracker[v9] = v10
	end

	v10.SetTarget(p)
	v10.SetHealthWarningThreshold(v8)
	v10.SetRemoveOnNullTarget(true)
	v10.SetSortPriority(v7, false)
end

function GetNpcHealthTracker()
	if _T.NpcHealthTracker == nil then
		return
	end

	local v7 = "NpcHealthTracker"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	return _T.NpcHealthTracker[v7]
end

function ClearNpcHealthTracker()
	if _T.NpcHealthTracker == nil then
		return
	end

	local v7 = "NpcHealthTracker"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if _T.NpcHealthTracker[v7] then
		if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
			_T.RemoveHudTracker(v7, 0.5)
		end

		_T.NpcHealthTracker[v7] = nil
	end
end

BLANK_STRING = 0
TIMELEFT_STRING = 1
TIMELIMIT_STRING = 2
NEXTWAVE_STRING = 3

function SetObjTimer(p, p2, p3, p4, p5, p6, p7, p8, p9)
	local v7 = fn3() + 6
	local v8 = not p9

	if _T.ObjectiveTimer == nil then
		_T.ObjectiveTimer = {}
	end

	local v9 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v9 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	local objectiveTimer = _T.ObjectiveTimer
	local v10 = objectiveTimer[v9]

	if v10 == nil then
		v10 = nil
	elseif __wf_atom_7e8ad928(v10.Movie) then
		objectiveTimer[v9] = nil
		v10 = nil
	end

	if v10 == nil then
		v10 = _T.AddHudTracker(v9, module.HT_TIMER, 0.5, v7, v8)
		v10.SetOffset(30, 5, true)

		if _T.DuviriActivityId ~= nil then
			v10.AddToLocation({ ActivityId = _T.DuviriActivityId })
		end

		_T.ObjectiveTimer[v9] = v10
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = false
	end

	local v11 = __wf_atom_7e8ad928(p3) and true or p3

	if __wf_atom_7e8ad928(p4) then
		p4 = false
	end

	if not __wf_atom_7e8ad928(p6) then
		local v12 = __wf_atom_7e8ad928(p7) and 3 or p7
		v10.ShowMessage(tostring(p6), v12)
	end

	if __wf_atom_7e8ad928(p8) then
		if not __wf_atom_7e8ad928(p5) and p5 > 0 and p5 <= #v then
			v10.SetLabel(v[p5])
		end
	else
		v10.SetLabel(p8)
	end

	v10.StartTimer(p, p2, v11, p4, function()
		if v11 then
			_T.ObjectiveTimer = nil
		end
	end)
	v10.SetSortPriority(v7, false)
	return v10
end

function GetObjTime()
	local v7 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	fn9(v7)

	if not (_T.ObjectiveTimer ~= nil and _T.ObjectiveTimer[v7] ~= nil) then
		return 0
	end

	return _T.ObjectiveTimer[v7].Data.Time
end

function GetObjTimeTracker()
	local v7 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	fn9(v7)

	if _T.ObjectiveTimer == nil then
		return
	else
		return _T.ObjectiveTimer[v7]
	end
end

function PauseObjTimer(p)
	local v7 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	fn9(v7)

	if _T.ObjectiveTimer == nil then
		return
	end

	if _T.ObjectiveTimer[v7] ~= nil then
		_T.ObjectiveTimer[v7].SetPaused(p, true)
	end
end

function RemoveObjTimer()
	if _T.ObjectiveTimer == nil then
		return
	end

	local v7 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if _T.ObjectiveTimer[v7] ~= nil then
		if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
			_T.RemoveHudTracker(v7, 0.5)
		end

		_T.ObjectiveTimer[v7] = nil
	end
end

function SetObjTimerVisible(p)
	if _T.ObjectiveTimer == nil then
		return
	end

	local v7 = "ObjectiveTimer"

	if _T.DuviriActivityId ~= nil then
		v7 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	if _T.ObjectiveTimer[v7] == nil then
		return
	end

	_T.ObjectiveTimer[v7].SetVisible(p)
end

function SetCachesObjectiveText(p, p2, p3)
	local v7 = fn3() + 7

	if __wf_atom_7e8ad928(_T.CachesHudTracker) then
		_T.CachesHudTracker = _T.AddHudTracker("CachesUiTracker", module.HT_LABEL, 0.5, v7, true)

		if not __wf_atom_7e8ad928(_T.CachesHudTracker) then
			if
				__wf_atom_7e8ad928(_T.NpcHealthTracker)
				and __wf_atom_7e8ad928(_T.ObjectiveTimer)
				and __wf_atom_7e8ad928(_T.ExtractionTimer)
			then
				_T.CachesHudTracker.SetOffset(0, 0, true)
			else
				_T.CachesHudTracker.SetOffset(0, 10, true)
			end
		end
	end

	local v8 = (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p3)) and "" or tostring(": " .. p2 .. " / " .. p3)
	fn6(_T.CachesHudTracker, p, 4, v8, v7, false)
end

function SetTimedChallengeObj(p, p2, p3, p4)
	local v7 = fn3() + 8
	local v8 = fn3() + 9
	local v9 = not p4

	if not __wf_atom_7e8ad928(p3) then
		if __wf_atom_7e8ad928(_T.LootChallengeTitle) then
			_T.LootChallengeTitle = _T.AddHudTracker("TreasureHuntTitle", module.HT_LABEL, 0.5, v7, v9)
		end

		fn6(_T.LootChallengeTitle, p3, 4, nil, v7, true)
		_T.LootChallengeTitle.SetOffset(0, 20, true)
	end

	if __wf_atom_7e8ad928(_T.LootChallengeTimer) then
		_T.LootChallengeTimer = _T.AddHudTracker("TreasureHuntTimer", module.HT_TIMER, 0.5, v8, v9)
	end

	if not __wf_atom_7e8ad928(p2) then
		_T.LootChallengeTimer.ShowMessage(tostring(p2), 3)
	end

	_T.LootChallengeTimer.SetLabel(v[2])
	_T.LootChallengeTimer.StartTimer(p, false, false, false)
	_T.LootChallengeTimer.SetSortPriority(v8, false)
	_T.LootChallengeTimer.SetOffset(30, 0, true)
end

function RemoveTimedChallengeObj()
	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker("TreasureHuntTitle", 0.5)
		_T.RemoveHudTracker("TreasureHuntTimer", 0.5)
	end

	_T.LootChallengeTitle = nil
	_T.LootChallengeTimer = nil
end

function SetExtractObjText(p)
	local v7 = fn3() + 2

	if _T.ObjectiveHudTracker == nil then
		_T.ObjectiveHudTracker = {}
	end

	local v8 = "ObjectiveUIText"

	if _T.DuviriActivityId ~= nil then
		v8 ..= "_" .. _T.DuviriActivityId .. "d"
	end

	local objectiveHudTracker = _T.ObjectiveHudTracker
	local v9 = objectiveHudTracker[v8]

	if v9 == nil then
		v9 = nil
	elseif __wf_atom_7e8ad928(v9.Movie) then
		objectiveHudTracker[v8] = nil
		v9 = nil
	end

	if v9 == nil then
		v9 = _T.AddHudTracker("ObjectiveUIText", module.HT_LABEL, 0.5, v7, true)
		_T.ObjectiveHudTracker[v8] = v9
	end

	fn6(v9, __wf_atom_7e8ad928(p) and "/Lotus/Language/Objectives/GetToExtraction" or p, 3, nil, v7, true)
end

function SetExtractionTimer(p, p2)
	local v7 = fn3() + 30

	if __wf_atom_7e8ad928(_T.ExtractionTimer) then
		_T.ExtractionTimer = _T.AddHudTracker("ExtractionTimer", module.HT_TIMER, 0.5, v7, true)
		_T.ExtractionTimer.SetOffset(30, 5, true)
	end

	if not __wf_atom_7e8ad928(p2) then
		_T.ExtractionTimer.ShowMessage(tostring(p2), 3)
	end

	_T.ExtractionTimer.SetLabel("/Lotus/Language/Objectives/ExtractionCountdown")
	_T.ExtractionTimer.StartTimer(p, false, true, false)
	_T.ExtractionTimer.SetSortPriority(v7, false)
end

function GetExtractionTime()
	fn10()

	if __wf_atom_7e8ad928(_T.ExtractionTimer) then
		return 0
	end

	return _T.ExtractionTimer.Data.Time
end

function RemoveExtractionTimer()
	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker("ExtractionTimer", 0.5)
	end

	_T.ExtractionTimer = nil
end

function ClearExtractObjText()
	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker("ExtractionTimer", 0.5)
	end

	_T.ExtractionTimer = nil
end

local v7 = WeakResource("/Lotus/Types/Keys/SolarisQuest/SolarisQuestKeyChain")
local v8 = WeakResource("/Lotus/Types/Gameplay/InfestedMicroplanet/Jobs/VaultQuestBounty")

local function fn11()
	local activeQuest = gGameData:GetInventory():GetActiveQuest()

	if not __wf_atom_7e8ad928(activeQuest) and activeQuest == v7 then
		print("SolarisQuest is active, no Bonus UI")
		return false
	end

	if __wf_atom_7e8ad928(_T.ActiveJob) or _T.ActiveJob.jobType ~= v8 then
		return true
	end

	print("TC Demo active, no bonus UI")
	return false
end

function AddBountyBonus(p, p2)
	if not fn11() then
		return
	end

	local v9 = fn3() + 3
	_T.BonusTracker = _T.AddHudTracker("BountyBonus", module.HT_LABEL, nil, v9)
	local v10 = "<p><font face=\"Noto Sans\" color=\"" .. _T.BonusTracker.Colorize(41) .. "\">"
	_T.BonusTracker.SetLabel(v10 .. _T.BonusTracker.Localize("<CHECKMARK_OUTLINE>", {}, true) .. "  " .. _T.BonusTracker.Localize("/Lotus/Language/Objectives/BonusObjective") .. ": " .. _T.BonusTracker.Localize(p, p2) .. "</font></p>")
	_T.BonusTracker.SetOffset(2, -11, true)
end

function SetBountyBonusAchieved(p, p2)
	if not fn11() then
		return
	end

	if not _T.BonusTracker then
		_T.BonusTracker = _T.GetHudTracker("BountyBonus")
	end

	if __wf_atom_7e8ad928(_T.BonusTracker) then
		print("OBJTXT - Couldn't update bonus tracker, tracker not found")
		return
	end

	local v9 = "<p><font face=\"Noto Sans\" color=\"" .. _T.BonusTracker.Colorize(41) .. "\">"
	_T.BonusTracker.SetLabel(v9 .. _T.BonusTracker.Localize("<CHECKMARK>", {}, true) .. "  " .. _T.BonusTracker.Localize("/Lotus/Language/Objectives/BonusObjective") .. ": " .. _T.BonusTracker.Localize(p, p2) .. "</font></p>")
end

function SetBountyBonusFailed(p, p2)
	if not fn11() then
		return
	end

	if not _T.BonusTracker then
		_T.BonusTracker = _T.GetHudTracker("BountyBonus")
	end

	if __wf_atom_7e8ad928(_T.BonusTracker) then
		print("OBJTXT - Couldn't update bonus tracker, tracker not found")
		return
	end

	local v9 = "<p><font face=\"Noto Sans\" color=\"" .. _T.BonusTracker.Colorize(13) .. "\">"
	_T.BonusTracker.SetLabel(v9 .. _T.BonusTracker.Localize("<CHECKMARK_FAIL>", {}, true) .. "  " .. _T.BonusTracker.Localize("/Lotus/Language/Objectives/BonusObjective") .. ": " .. _T.BonusTracker.Localize(p, p2) .. "</font></p>")
end

function RemoveBountyBonus()
	if not fn11() then
		return
	end

	if not _T.BonusTracker then
		_T.BonusTracker = _T.GetHudTracker("BountyBonus")
	end

	if __wf_atom_7e8ad928(_T.BonusTracker) or __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		print("OBJTXT - Couldn't remove bonus tracker, tracker not found")
	else
		_T.RemoveHudTracker(_T.BonusTracker)
	end
end

function SetBountyTitleText(p)
	local v9 = fn3() + 20

	if __wf_atom_7e8ad928(_T.BountyTitleTracker) then
		_T.BountyTitleTracker = _T.AddHudTracker("BountyUIText", module.HT_LABEL, 0.5, v9, true)
	end

	local localize = _T.BountyTitleTracker.Localize(p, nil, true)
	local v10 = "<p><font face=\"Noto Sans\" color=\"" .. _T.BountyTitleTracker.Colorize(41) .. "\"><b>" .. localize .. "</b></font></p>"
	_T.BountyTitleTracker.SetLabel(v10)
	_T.BountyTitleTracker.SetOffset(0, 20)
end

function SetZarimanBounty(p, p2, p3, p4, p5)
	local v9 = (__wf_atom_7e8ad928(p) or p <= 0) and 1 or p

	if __wf_atom_7e8ad928(_T.ZarimanBountyTrackers) then
		_T.ZarimanBountyTrackers = {}
	end

	if __wf_atom_7e8ad928(_T.ZarimanBountyTrackers[v9]) then
		local v10 = fn3() + 20 + v9
		local v11 = "ZarimanBounty" .. v9
		_T.ZarimanBountyTrackers[v9] = _T.AddHudTracker(v11, module.HT_LABEL, nil, v10)
		_T.ZarimanBountyTrackers[v9].SetOffset(2, -11, true)
	end

	local v10 = "<p><font face=\"Noto Sans\" color=\"" .. _T.ZarimanBountyTrackers[v9].Colorize(41) .. "\">"
	local v11 = "<CHECKMARK_OUTLINE>"

	if p3 == 2 then
		v10 = "<p><font face=\"Noto Sans\" color=\"" .. _T.ZarimanBountyTrackers[v9].Colorize(13) .. "\">"
		v11 = "<CHECKMARK_FAIL>"
	elseif p3 == 3 then
		v11 = "<CHECKMARK>"
	end

	local v12 = { COUNT = module2.FormatNumber(p5) }
	local v13 = v10 .. _T.ZarimanBountyTrackers[v9].Localize(v11, {}, true) .. ": " .. _T.ZarimanBountyTrackers[v9].Localize(p2, v12) .. ": " .. module2.FormatNumber(p4) .. "/" .. module2.FormatNumber(p5) .. "</font></p>"
	_T.ZarimanBountyTrackers[v9].SetLabel(v13)
end

function RemoveZarimanBounty()
	if not _T.ZarimanBountyTracker then
		_T.ZarimanBountyTracker = _T.GetHudTracker("ZarimanBounty")
	end

	if __wf_atom_7e8ad928(_T.ZarimanBountyTracker) or __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		print("OBJTXT - Couldn't remove Zariman bounty tracker, tracker not found")
	else
		_T.RemoveHudTracker(_T.ZarimanBountyTracker)
	end
end

function SetDuviriActivityId(duviriActivityId)
	_T.DuviriActivityId = duviriActivityId
end

function ShowTutorialHint(p, p2, p3)
	v3 = p
	local v9 = tostring(p)
	local v10 = tonumber(p2) or -1
	_T.ShowImpactMessage(v9, v10, true, nil, false, nil, 3, nil, nil, nil, p3)
	_T.HintActive = true
end

function HideTutorialHint()
	v3 = nil

	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end

	_T.HintActive = false
end

function SetDebugText(_, _, _, _)
	if __wf_atom_7e8ad928(_T.AddHudTracker) then
	end
end

function ClearDebugText()
	if not __wf_atom_7e8ad928(_T.RemoveHudTracker) then
		_T.RemoveHudTracker("DebugUIText", 0.5)
	end

	_T.DebugHudTracker = nil
end

function UpdateAlignments(list)
	for _, v9 in ipairs(list) do
		v9.SetOffset(30, 5, true)
	end
end

function GetPriorityOffset()
	return (fn3())
end

function GetSubObjIndents(p)
	local v9, v10

	if p or not __wf_atom_7e8ad928(_T.ObjectiveHudTracker) then
		v9 = 30
		v10 = 5
	else
		v9 = 0
		v10 = 0
	end

	return v9, v10
end

function SetObjectiveTextUI(p, p2, p3, p4, p5, p6, p7)
	return fn6(p, p2, p3, p4, p5, p6, p7)
end