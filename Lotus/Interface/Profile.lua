local v = {
	MAIN = 1,
	LEADERBOARD_ROOT = 2,
	LEADERBOARD_LIST = 3,
	DEFENSE_ROOT = 4,
	DEFENSE_LIST = 5,
	SURVIVAL_ROOT = 6,
	SURVIVAL_LIST = 7,
	INTERCEPTION_ROOT = 8,
	INTERCEPTION_LIST = 9,
	EXCAVATION_ROOT = 10,
	EXCAVATION_LIST = 11,
	DEFECTION_ROOT = 12,
	DEFECTION_LIST = 13,
	DISRUPTION_ROOT = 14,
	DISRUPTION_LIST = 15,
	QUEST_ROOT = 16,
	QUEST_LIST = 17,
	ENDLESS_EXTERMINATION_ROOT = 18,
	ENDLESS_EXTERMINATION_LIST = 19,
	HOVERBOARD_RACE_ROOT = 20,
	HOVERBOARD_RACE_LIST = 21
}
local v2 = { "/Lotus/Language/Labels/NormalMode", "/Lotus/Language/Labels/HardMode" }
local v3 = {}
local module = require("Lotus.Interface.LotusNetworkUtilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("EE.Interface.Components.List")
local v4 = false
local flag = false
local v5 = nil
local v6 = nil
local v7 = false
local v8 = ""
local LEADERBOARD_ROOT = v.LEADERBOARD_ROOT
local v9 = false
local formattingFunction = nil
local v10 = nil
local v11 = {}
local v12 = false
local flag2 = false
local flag3 = false
local v13 = nil
local v14 = 0
local v15 = 0
local labels = {}
local v16 = {
	{ Root = true, Title = "/Lotus/Language/Menu/Profile_CurrentLeaderboards" },
	{ Root = true, Title = "/Lotus/Language/Menu/Profile_WeeklyLeaderboards" },
	{
		Title = "/Lotus/Language/Menu/Profile_ObstacleScoreLeaderboard",
		Collection = "weekly.accounts.DojoObstacleScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Time",
		FormattingFunction = function(p)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/TimeFormat_SecondsShort",
				false
			)
			local v16 = 180 - p / 1000
			local _, _, v17, v18 = module2.GetSecondElements(v16)
			return string.format(
				"%d" .. __wf_atom_8e9ac384 .. " %g" .. __wf_atom_8e9ac384_2,
				v17,
				module3.Round(v18, 2)
			)
		end
	},
	{
		Title = "/Lotus/Language/Menu/Profile_CustomObstacleScoreLeaderboard",
		Collection = "weekly.accounts.DojoCustomObstacleScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Time",
		FormattingFunction = function(p)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/TimeFormat_SecondsShort",
				false
			)
			local v16 = p / 1000
			local _, _, v17, v18 = module2.GetSecondElements(v16)
			return string.format(
				"%d" .. __wf_atom_8e9ac384 .. " %g" .. __wf_atom_8e9ac384_2,
				v17,
				module3.Round(v18, 2)
			)
		end
	},
	{ Root = true, Title = "/Lotus/Language/Menu/Profile_DailyLeaderboards" },
	{ Root = true, Title = "/Lotus/Language/Game/SB_Title" },
	{
		Root = true,
		Title = "/Lotus/Language/Menu/Profile_DedicatedServers",
		Hidden = Engine.__wf_atom_fc67ba71()
	},
	{ Root = true, Title = "/Lotus/Language/Menu/Profile_ArchivedLeaderboards" },
	{
		Title = "/Lotus/Language/G1Quests/RiotMoaEventName",
		Collection = "archived.RiotMoaEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true
	},
	{
		Title = "/Lotus/Language/G1Quests/FomorianRevengeGlobalName",
		Collection = "archived.FomorianEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true
	},
	{
		Title = "/Lotus/Language/G1Quests/InfestedEventName",
		Collection = "archived.InfestedEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Time",
		SubClan = true
	},
	{
		Title = "/Lotus/Language/G1Quests/PortalEventName",
		Collection = "archived.PortalEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true
	},
	{
		Title = "/Lotus/Language/G1Quests/ExcavationEventName",
		Collection = "archived.ExcavationEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true
	},
	{
		Title = "/Lotus/Language/G1Quests/InfestedCorpusHiveEventName",
		Collection = "archived.HiveEvent",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/G1Quests/RescueEventInGameTitle",
		Collection = "archived.SpectersOfLiberty",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		PersonalOnly = true
	},
	{
		Title = "/Lotus/Language/Menu/Profile_RetrievalEvent",
		Collection = "archived.TethrasDoom",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_ForestEvent",
		Collection = "archived.CiceroCrisis",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_InvasionEventG",
		Collection = "archived.GradivusDilemmaG",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_InvasionEventC",
		Collection = "archived.GradivusDilemmaC",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_SurvivalEvent",
		Collection = "archived.SurvivalEvent",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Time"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_CaptureEvent",
		Collection = "archived.AridFear",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_SabotageEvent",
		Collection = "archived.SlingStone",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
	},
	{
		Title = "/Lotus/Language/G1Quests/FusionMoaEventInGameTitle",
		Collection = "archived.FusionMoa",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Kills"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_KillsLeaderboard",
		Collection = "archived.Kills",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Kills"
	},
	{
		Title = "/Lotus/Language/Menu/Profile_ZephyrScoreDesc",
		Collection = "weekly.accounts.ZephyrScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_ZephyrScore",
		Hidden = true
	},
	{
		Title = "/Lotus/Language/Menu/Profile_SentinelGameScoreDesc",
		Collection = "weekly.accounts.SentinelGameScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_SentinelGameScore",
		Hidden = true
	},
	{
		Title = "/Lotus/Language/Menu/Profile_PlatformerScoreDesc",
		Collection = "weekly.accounts.PlatformerScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_PlatformerScore",
		Hidden = true
	},
	{
		Title = "/Lotus/Language/Menu/Profile_RadioSetsScoreDesc",
		Collection = "weekly.accounts.RadioSetsScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_RadioSetsScore",
		Hidden = true
	},
	{
		Title = "/Lotus/Language/Menu/Profile_InvadersScoreDesc",
		Collection = "weekly.accounts.InvadersScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_InvadersScore",
		Hidden = true
	}
}
local v17 = {
	{
		Title = "/Lotus/Language/Events/MechSurvivalName",
		Collection = "MechSurvivalScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true,
		GoalTag = "MechSurvival",
		ArchiveDate = module3.Ternary(
			Engine.__wf_atom_578fc9dd(),
			1635379200,
			module3.Ternary(Engine.__wf_atom_fc67ba71(), 1614024000, 1611151200)
		)
	},
	{
		Title = "/Lotus/Language/Events/TacAlertHalloweenLanternEndless",
		Collection = "Halloween19ScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true,
		GoalTag = "Halloween19Endless",
		DisableInChina = true,
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1572616800, 1572616800)
	},
	{
		Title = "/Lotus/Language/Events/AmalgamEventName",
		Collection = "AmalgamEventScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true,
		GoalTag = "AmalgamEventScoredMission",
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1561384800, 1558634400)
	},
	{
		Title = "/Lotus/Language/G1Quests/AmbulasEventName",
		Collection = "AmbulasEventScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true,
		GoalTag = "AmbulasEvent",
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1495555200, 1494525600)
	},
	{
		Title = "/Lotus/Language/G1Quests/ColonistRescueEventTitle",
		Collection = "ColonistRescueEventScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Points",
		SubClan = true,
		GoalTag = "ColonistRescueEvent",
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1490623200, 1488826800)
	},
	{
		Title = "/Lotus/Language/G1Quests/KelaEventTitle",
		Collection = "KelaEventBonusScoreMax",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Kills",
		SubClan = true,
		GoalTag = "KelaEventBonus",
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1466438400, 1462204800)
	},
	{
		Title = "/Lotus/Language/G1Quests/ProjectSinisterTitle",
		Collection = "ProjectSinisterEventScore",
		ScoreLoc = "/Lotus/Language/Menu/Profile_Wave",
		SubClan = true,
		DecodeDurationPersonal = true,
		GoalTag = "ProjectSinisterBonus",
		ArchiveDate = module3.Ternary(Engine.__wf_atom_fc67ba71(), 1461254400, 1453870800)
	}
}
local v18 = { BardQuestTimeAttack = "/Lotus/Language/BardQuest/BardQuestScoreAttackMission" }
local v19 = {}
local v20 = {}
local v21 = {}
local v22 = {}
local v23 = {}
local v24 = {}
local v25 = {}
local v26 = {}
local v27 = {}
local v28 = nil
local v29 = {
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballWins",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_WINS",
		guildCollection = "weekly.speedball.guilds.SB_WINS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballPoints",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_POINTS",
		guildCollection = "weekly.speedball.guilds.SB_POINTS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballGoals",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_GOALS",
		guildCollection = "weekly.speedball.guilds.SB_GOALS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballAssists",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_ASSISTS",
		guildCollection = "weekly.speedball.guilds.SB_ASSISTS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballRebounds",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_REBOUNDS",
		guildCollection = "weekly.speedball.guilds.SB_REBOUNDS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballSaves",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_SAVES",
		guildCollection = "weekly.speedball.guilds.SB_SAVES"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballPasses",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_PASSES",
		guildCollection = "weekly.speedball.guilds.SB_PASSES"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballCatches",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_CATCHES",
		guildCollection = "weekly.speedball.guilds.SB_CATCHES"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballInterceptions",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_INTERCEPTIONS",
		guildCollection = "weekly.speedball.guilds.SB_INTERCEPTIONS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballChecks",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_CHECKS",
		guildCollection = "weekly.speedball.guilds.SB_CHECKS"
	},
	{
		title = "/Lotus/Language/Menu/Profile_SpeedballSteals",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "weekly.speedball.accounts.SB_STEALS",
		guildCollection = "weekly.speedball.guilds.SB_STEALS"
	}
}
local v30 = nil
local v31 = {
	{
		title = "/Lotus/Language/Menu/LB_HostScore",
		units = "/Lotus/Language/Menu/Profile_Points",
		personalCollection = "dedServers.accounts.DEDICATED_SERVER_SCORE",
		guildCollection = "dedServers.guilds.DEDICATED_SERVER_SCORE"
	},
	{
		title = "/Lotus/Language/Menu/LB_MaxUptime",
		units = "/Lotus/Language/Menu/Profile_Time",
		personalCollection = "dedServers.accounts.DEDICATED_SERVER_MAX_UPTIME",
		guildCollection = "dedServers.guilds.DEDICATED_SERVER_MAX_UPTIME"
	}
}
local v32 = 0
local v33 = 0
local v34 = 0
local v35 = 0
local v36 = ""
local id = 1
local fn

function IsInputBlocked()
	return v4
end

local function fn2()
	if v10 ~= nil then
		local v38 = v10.mScrollBar.mHeight - 10
		local visibilitySize = module3.GetVisibilitySize(mMovie, v38)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Panel.ProfileList", 3)
		local visibilityCenter = module3.GetVisibilityCenter(mMovie, v38 / 2 + __wf_atom_5e6e15c8 + 5)
		local visibilityFadeSize = module3.GetVisibilityFadeSize(mMovie, 10)
		local v39 = { menuVisibleRange, menuTextVisibleRange, menuBackerVisibleRange }

		for _, v40 in ipairs(v39) do
			v40:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			v40:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			v40:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
		end
	end
end

function Shutdown()
	_T.SelectedIsGuild = nil
	_T.SelectedProfileName = nil
	_T.SelectedProfileId = nil
	_T.gToolTip = nil

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	local mainMenuSuitAvatar = module2.GetMainMenuSuitAvatar()

	if not __wf_atom_7e8ad928(mainMenuSuitAvatar) then
		mainMenuSuitAvatar:SetVisibility(true)
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):Close()
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "PROFILE_LEADERBOARDS")
	end
end

local function fn3()
	local v38 = {}

	for i = #v11, 1, -1 do
		local v39 = v11[i]

		if v39.mVisible then
			table.insert(v38, {
				Label = v39.mLabel,
				CallBack = v39.mCallback,
				CallOut = v39.mCallout
			})
		end
	end

	_T.SetButtons(mMovie, v38, getfenv(1))
end

local function fn4(p)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p, true)
	mMovie:__wf_atom_50d60589("Panel.Title", 36, string.upper(__wf_atom_8e9ac384))
end

local function fn5(isGuild, label, p, percent, showPercent, rank, highlight, localizedLabel)
	local v38 = {
		Id = id,
		IsGuild = isGuild,
		Label = label,
		Value = p,
		Percent = percent,
		ShowPercent = showPercent,
		Rank = rank,
		Highlight = highlight
	}
	id += 1

	if localizedLabel == nil then
		v38.LocalizedLabel = 1
	else
		v38.LocalizedLabel = localizedLabel
	end

	v5:InsertElement(#v5.mElements + 1, v38, true)
end

function RollOver(_)
	module3.PlaySound(_G.UISound_Focus)
end

function RollOut(_)
	_T.gToolTip = nil
end

local function fn6(value)
	if value == "" then
		return ""
	end

	if string.sub(value, 0, 1) ~= "/" then
		return string.upper(value)
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(value, true)

	if __wf_atom_8e9ac384 == value then
		return ""
	end

	return __wf_atom_8e9ac384
end

local function fn7(value)
	if not (string.find(value, module2.NIGHTMARE_TAG) == nil and string.find(value, module2.EVENT_TAG) == nil) then
		return ""
	end

	if v18[value] ~= nil then
		return fn6(v18[value])
	end

	if string.sub(value, 0, 1) == "/" then
		local v38 = WeakResource(value)

		if v38 ~= nil and v38:IsA(keyItemType) then
			local v39 = Resource(v38)

			if not __wf_atom_7e8ad928(v39) then
				return fn6(v39:__wf_atom_014a76a2():c_str())
			end
		end

		return ""
	else
		local __wf_atom_d5226f21 = module2.GetStarChart():__wf_atom_d5226f21(Symbol(value))

		if __wf_atom_7e8ad928(__wf_atom_d5226f21) or __wf_atom_d5226f21.name == EMPTY_SYMBOL then
			return string.upper(value)
		end

		return fn6(__wf_atom_d5226f21.locTag:c_str())
	end
end

local function fn8(p, indent, func)
	local v38 = p == nil and { Label = "", Func = nil }
		or {
			Label = mMovie:__wf_atom_8e9ac384(p, false),
			Func = func,
			Indent = indent
		}
	v10.MaxIndent = math.max(v10.MaxIndent, indent)
	v10:AddElement(v38, true)
	local v39 = v10.mVisibleElements / v10:GetHowManyElements()

	if v39 > 0 and v39 < 1 then
		mMovie:__wf_atom_2dedec1a("Panel.ScrollBar2", 13, true)
	else
		mMovie:__wf_atom_2dedec1a("Panel.ScrollBar2", 13, false)
	end
end

local function fn9(p, p2, p3)
	v36 = p
	mMovie:__wf_atom_7d7314f1("Panel.LeaderboardHeader.Value.text", p)
	v5:RemoveElements(true)
	fn5(nil, "/Lotus/Language/Menu/Profile_RetrievingStats", "", 0, false)
	local v38 = ""

	if v32 == 0 then
		v38 = mMovie:__wf_atom_8e9ac384(v16[v34].Title, false)
	elseif v32 == 1 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Defense", false) .. " / " .. fn7(v19[v33][v34])
	elseif v32 == 2 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Survival", false) .. " / " .. fn7(v20[v33][v34])
	elseif v32 == 3 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Territory", false) .. " / " .. fn7(v21[v33][v34])
	elseif v32 == 4 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Excavation", false) .. " / " .. fn7(v22[v33][v34])
	elseif v32 == 5 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Evacuation", false) .. " / " .. fn7(v23[v33][v34])
	elseif v32 == 7 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_Generic", false) .. " / " .. fn7(v26[v33][v34])
	elseif v32 == 8 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_EndlessExtermination", false) .. " / " .. fn7(v24[v33][v34])
	elseif v32 == 9 then
		v38 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/HoverboardRace", false) .. " / " .. fn7(v27[v33][v34])
	end

	local v39 = string.upper(v38)
	local v40

	if p3 then
		local v41 = v39 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_Ranking", false)

		if p2 > 0 then
			v40 = v41 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_Clan", false)
		else
			v40 = v41 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_Personal", false)
		end
	else
		local v41 = v39 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_Top", false)

		if p2 > 0 then
			v40 = v41 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Tier" .. p2 .. "NameCapPlural", false)
		else
			v40 = v41 .. " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Lobby_PlayersTitle", false)
		end
	end

	mMovie:__wf_atom_50d60589("Panel.Title", 36, v40)
	mMovie:__wf_atom_7d7314f1("Panel.BG.Label.text", v40)
end

local function fn10(p)
	if v32 == 1 or v32 == 3 or v32 == 7 then
		return true
	end

	local decodeDurationGuild

	if #v16[v34] >= 4 then
		if p then
			decodeDurationGuild = v16[v34].DecodeDurationGuild
		else
			decodeDurationGuild = v16[v34].DecodeDurationPersonal
		end
	else
		decodeDurationGuild = false
	end

	if decodeDurationGuild then
		return true
	end

	return false
end

local function fn11(collection, p, scoreLoc, p2)
	local v39 = math.floor(10) - 1
	local v40 = 20 - v39
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(v6) then
		return
	end

	v13:SetActive(true)
	local selectedProfileId, v41

	if p then
		selectedProfileId = v6:__wf_atom_5ff594a3()
		v41 = math.max(1, v6:__wf_atom_7d674792())
	else
		if _T.SelectedProfileId == nil then
			selectedProfileId = __wf_atom_18a5d83b:__wf_atom_e75653c3()
		else
			selectedProfileId = _T.SelectedProfileId
		end

		v41 = 0
	end

	fn9(scoreLoc, v41, true)
	local v42 = v41 > 0 and "OnGuildLeaderboard" or "OnLeaderboard"
	v6:__wf_atom_233c0b82(v42, collection, selectedProfileId, "", v41, v39, v40, fn10(v41 > 0), p2)
end

local function fn12(collection, p, scoreLoc, p2)
	fn9(scoreLoc, p, false)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	v13:SetActive(true)
	local v39 = p > 0 and "OnGuildLeaderboard" or "OnLeaderboard"
	v6:__wf_atom_233c0b82(v39, collection, "", "", p, 0, 20, fn10(p > 0), p2)
end

local function fn13(collection, scoreLoc, p)
	if __wf_atom_7e8ad928(v6) then
		return
	end

	v13:SetActive(true)
	local __wf_atom_e75653c3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()
	local __wf_atom_5ff594a3 = v6:__wf_atom_5ff594a3()
	local v38 = math.floor(10) - 1
	local v39 = 20 - v38
	fn9(scoreLoc, 0, true)
	v6:__wf_atom_233c0b82(
		"OnLeaderboard",
		collection,
		__wf_atom_e75653c3,
		__wf_atom_5ff594a3,
		0,
		v38,
		v39,
		fn10(false),
		p
	)
end

local function fn14(collection, scoreLoc, p)
	if __wf_atom_7e8ad928(v6) then
		return
	end

	v13:SetActive(true)
	local __wf_atom_5ff594a3 = v6:__wf_atom_5ff594a3()
	fn9(scoreLoc, 0, false)
	v6:__wf_atom_233c0b82("OnLeaderboard", collection, "", __wf_atom_5ff594a3, 0, 0, 20, fn10(false), p)
end

local function fn15(p)
	LEADERBOARD_ROOT = p
	local ternary = module3.Ternary(
		LEADERBOARD_ROOT == v.MAIN,
		"/Lotus/Language/Menu/Exit",
		"/Lotus/Language/Menu/Global_Back"
	)

	if ternary ~= v11[1].mLabel then
		v11[1].mLabel = ternary
		fn3()
	end
end

local function fn16(p, list, fn17)
	if fn17 == nil then
		for i, v38 in ipairs(list) do
			if v38 == p then
				return i
			end
		end
	else
		for i, v38 in ipairs(list) do
			if fn17(v38) == p then
				return i
			end
		end
	end

	return 0
end

local function fn17(p)
	local v38 = p[v33][v34]

	if v35 > 1 then
		return v38 .. "_HM"
	end

	return v38
end

local function fn18()
	if __wf_atom_7e8ad928(v6) or not (#v17 > 0) then
		return
	end

	local mGoals = v6:__wf_atom_92662866().mGoals

	local function fn19(p)
		return p.Title
	end

	local v38 = fn16("/Lotus/Language/Menu/Profile_CurrentLeaderboards", v16, fn19)
	local v39 = fn16("/Lotus/Language/Menu/Profile_ArchivedLeaderboards", v16, fn19)

	for i = 1, #v17 do
		local v40 = v17[i]

		if not (not Engine.__wf_atom_578fc9dd() or v40.DisableInChina == nil) then
			continue
		end

		local goalTag = v40.GoalTag
		local v41 = false

		for j = 1, #mGoals do
			if not (mGoals[j].mTag and mGoals[j].mTag:c_str() == goalTag) then
				continue
			end

			v38 += 1
			v39 += 1
			v40.Collection = "events.accounts." .. v40.Collection
			table.insert(v16, v38, v40)
			v41 = true
			break
		end

		if v41 or v40.ArchiveDate == nil or not (Engine.__wf_atom_db2b0cee(v40.ArchiveDate) < 0) then
			continue
		end

		v40.Collection = "archived." .. v40.Collection
		v39 += 1
		table.insert(v16, v39, v40)
	end
end

local function fn19(p)
	fn8(p.Title, 0, nil)

	if p.Title == "/Lotus/Language/Menu/Profile_WeeklyLeaderboards" then
		fn8("/Lotus/Language/Missions/MissionName_Defense", 1, function()
			fn15(v.DEFENSE_ROOT)
			fn()
		end)
		fn8("/Lotus/Language/Missions/MissionName_Survival", 1, function()
			fn15(v.SURVIVAL_ROOT)
			fn()
		end)
		fn8("/Lotus/Language/Missions/MissionName_Territory", 1, function()
			fn15(v.INTERCEPTION_ROOT)
			fn()
		end)
		fn8("/Lotus/Language/Missions/MissionName_Excavation", 1, function()
			fn15(v.EXCAVATION_ROOT)
			fn()
		end)
		fn8("/Lotus/Language/Missions/MissionName_Evacuation", 1, function()
			fn15(v.DEFECTION_ROOT)
			fn()
		end)
		fn8("/Lotus/Language/Missions/MissionName_Artifact", 1, function()
			fn15(v.DISRUPTION_ROOT)
			fn()
		end)

		if module2.HasCompletedQuest(bardKeyChainWRes) then
			fn8("/Lotus/Language/Missions/MissionName_Generic", 1, function()
				fn15(v.QUEST_ROOT)
				fn()
			end)
		end

		fn8("/Lotus/Language/Missions/MissionName_EndlessExtermination", 1, function()
			fn15(v.ENDLESS_EXTERMINATION_LIST)
			fn()
		end)

		if flag2 then
			fn8("/Lotus/Language/Menu/Profile_ZephyrLeaderboard", 1, function()
				for i = 1, #v16 do
					if v16[i].Collection ~= "weekly.accounts.ZephyrScore" then
						continue
					end

					v34 = i
					break
				end

				fn15(v.LEADERBOARD_LIST)
				fn()
			end)
		end

		if flag3 then
			fn8("/Lotus/Language/Menu/Profile_SentinelGameLeaderboard", 1, function()
				for i = 1, #v16 do
					if v16[i].Collection ~= "weekly.accounts.SentinelGameScore" then
						continue
					end

					v34 = i
					break
				end

				fn15(v.LEADERBOARD_LIST)
				fn()
			end)
		end
	end

	if p.Title == "/Lotus/Language/Menu/Profile_DailyLeaderboards" then
		fn8("/Lotus/Language/Game/HoverboardRace", 1, function()
			fn15(v.HOVERBOARD_RACE_ROOT)
			fn()
		end)
	end

	if p.Title == "/Lotus/Language/Game/SB_Title" then
		for _, v38 in pairs(v29) do
			local v39 = v38
			fn8(v38.title, 1, function()
				fn15(v.LEADERBOARD_LIST)
				v32 = 10
				v28 = v39
				fn()
			end)
		end
	end

	if p.Title == "/Lotus/Language/Menu/Profile_DedicatedServers" then
		for _, v38 in pairs(v31) do
			local v39 = v38
			fn8(v38.title, 1, function()
				fn15(v.LEADERBOARD_LIST)
				v32 = 11
				v30 = v39
				fn()
			end)
		end
	end
end

fn = function(p)
	if __wf_atom_7e8ad928(v6) then
		return
	end

	local v38

	if v6:__wf_atom_84083b39() == "" then
		v38 = false
	else
		v38 = not v6:__wf_atom_100362b3()
	end

	v10.MaxIndent = -1
	v10:RemoveElements(true)

	if not p then
		formattingFunction = nil
	end

	if LEADERBOARD_ROOT == v.LEADERBOARD_ROOT then
		v32 = 0
		v33 = 0
		v35 = 0

		for i = 1, #v16 do
			local v39 = v16[i]

			if v39.Hidden then
				continue
			end

			if v39.Root then
				fn19(v39)
			else
				local v40 = i
				fn8(v39.Title, 1, function()
					if __wf_atom_7e8ad928(v39.FormattingFunction) then
						formattingFunction = nil
					else
						formattingFunction = v39.FormattingFunction
					end

					v34 = v40
					fn15(v.LEADERBOARD_LIST)
					fn(true)
				end)
			end
		end
	elseif LEADERBOARD_ROOT == v.LEADERBOARD_LIST then
		local v39 = nil
		local v40 = nil

		if v32 == 0 then
			v39 = v16[v34]
			v40 = module3.CopyTable(v39)
			local v41 = nil
			local v42 = nil

			for _, v44 in ipairs({ "weekly", "library" }) do
				v41 = string.match(v39.Collection, v44 .. ".accounts.([%a%d]+)")

				if not v41 then
					continue
				end

				v42 = v44
				break
			end

			if v41 ~= nil then
				v40.Collection = v42 .. ".guilds." .. v41
			end

			local v44 = string.match(v39.Collection, "events.accounts.([%a%d]+)")

			if v44 ~= nil then
				v40.Collection = "archived." .. v44
			end
		elseif v32 == 1 then
			local v41 = fn17(v19)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Wave"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Wave"
			}
		elseif v32 == 2 then
			local v41 = fn17(v20)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Time"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Time"
			}
		elseif v32 == 3 then
			local v41 = fn17(v21)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Rounds"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Rounds"
			}
		elseif v32 == 4 then
			local v41 = fn17(v22)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
		elseif v32 == 5 then
			local v41 = fn17(v23)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
		elseif v32 == 6 then
			local v41 = fn17(v25)
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
		elseif v32 == 7 then
			local v41 = v26[v33][v34]
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Time"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Time"
			}
		elseif v32 == 8 then
			local v41 = v24[v33][v34]
			v39 = {
				Collection = "weekly.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
			v40 = {
				Collection = "weekly.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
		elseif v32 == 9 then
			local v41 = v27[v33][v34]
			v39 = {
				Collection = "daily.accounts." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
			v40 = {
				Collection = "daily.guilds." .. v41,
				ScoreLoc = "/Lotus/Language/Menu/Profile_Points"
			}
		elseif v32 == 10 then
			local units = v28.units
			v39 = { Collection = v28.personalCollection, ScoreLoc = units }
			v40 = { Collection = v28.guildCollection, ScoreLoc = units }
		elseif v32 == 11 then
			local units = v30.units
			v39 = { Collection = v30.personalCollection, ScoreLoc = units }
			v40 = { Collection = v30.guildCollection, ScoreLoc = units }
		end

		fn8("/Lotus/Language/Menu/Profile_Ranking", 0, nil)
		fn8("/Lotus/Language/Menu/Profile_Personal", 1, function()
			fn11(v39.Collection, false, v39.ScoreLoc, false)
		end)

		if v38 and not v40.PersonalOnly then
			fn8("/Lotus/Language/Menu/Profile_Clan", 1, function()
				fn11(v40.Collection, true, v40.ScoreLoc, false)
			end)
		end

		if
			v38 and (string.find(v39.Collection, "weekly.") ~= nil or string.find(v39.Collection, "events.") ~= nil)
			or v39.SubClan
		then
			fn8("/Lotus/Language/Menu/Profile_Clan", 0, nil)
			fn8("/Lotus/Language/Menu/Profile_Top", 1, function()
				fn14(v39.Collection, v39.ScoreLoc, false)
			end)
			fn8("/Lotus/Language/Menu/Profile_Personal", 1, function()
				fn13(v39.Collection, v39.ScoreLoc, false)
			end)
		end

		fn8("/Lotus/Language/Menu/Profile_Top", 0, nil)
		fn8("/Lotus/Language/Menu/Lobby_PlayersTitle", 1, function()
			fn12(v39.Collection, 0, v39.ScoreLoc, false)
		end)

		if not v40.PersonalOnly then
			for i = 1, 5 do
				local v42 = i
				fn8("/Lotus/Language/Clan/Tier" .. i .. "NameCapPlural", 1, function()
					fn12(v40.Collection, v42, v40.ScoreLoc, false)
				end)
			end
		end
	elseif LEADERBOARD_ROOT == v.DEFENSE_ROOT then
		v32 = 1

		for i = 1, #v19 do
			local v40 = i
			fn8(v19[i][1], 0, function()
				v33 = v40
				fn15(v.DEFENSE_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.DEFENSE_LIST then
		v32 = 1
		local v39 = v19[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				local v43 = i
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					v35 = v43
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.SURVIVAL_ROOT then
		v32 = 2

		for i = 1, #v20 do
			local v40 = i
			fn8(v20[i][1], 0, function()
				v33 = v40
				fn15(v.SURVIVAL_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.SURVIVAL_LIST then
		local v39 = v20[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				local v43 = i
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					v35 = v43
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.INTERCEPTION_ROOT then
		v32 = 3

		for i = 1, #v21 do
			local v40 = i
			fn8(v21[i][1], 0, function()
				v33 = v40
				fn15(v.INTERCEPTION_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.INTERCEPTION_LIST then
		local v39 = v21[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				local v43 = i
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					v35 = v43
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.EXCAVATION_ROOT then
		v32 = 4

		for i = 1, #v22 do
			local v40 = i
			fn8(v22[i][1], 0, function()
				v33 = v40
				fn15(v.EXCAVATION_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.EXCAVATION_LIST then
		local v39 = v22[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				local v43 = i
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					v35 = v43
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.DEFECTION_ROOT then
		v32 = 5

		for i = 1, #v23 do
			local v40 = i
			fn8(v23[i][1], 0, function()
				v33 = v40
				fn15(v.DEFECTION_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.DEFECTION_LIST then
		local v39 = v23[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				local v43 = i
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					v35 = v43
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.DISRUPTION_ROOT then
		v32 = 6

		for i = 1, #v25 do
			local v40 = i
			fn8(v25[i][1], 0, function()
				v33 = v40
				fn15(v.DISRUPTION_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.DISRUPTION_LIST then
		local v39 = v25[v33]

		for i = 1, #v2 do
			fn8(v2[i], 0, nil)

			for j = 2, #v39 do
				local v42 = j
				fn8(fn7(v39[j]), 1, function()
					v34 = v42
					fn15(v.LEADERBOARD_LIST)
					fn()
				end)
			end

			if not v12 then
				break
			end
		end
	elseif LEADERBOARD_ROOT == v.QUEST_ROOT then
		v32 = 7

		for i = 1, #v26 do
			local v40 = i
			fn8(v26[i][1], 0, function()
				v33 = v40
				fn15(v.QUEST_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.QUEST_LIST then
		local v39 = v26[v33]

		for i = 2, #v39 do
			local v42 = i
			fn8(fn7(v39[i]), 0, function()
				v34 = v42
				fn15(v.LEADERBOARD_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.ENDLESS_EXTERMINATION_ROOT then
		v32 = 8

		for i = 1, #v24 do
			local v40 = i
			fn8(v24[i][1], 0, function()
				v33 = v40
				fn15(v.ENDLESS_EXTERMINATION_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.ENDLESS_EXTERMINATION_LIST then
		v32 = 8
		v33 = 1
		local v39 = v24[v33]

		for i = 2, #v39 do
			local v42 = i
			fn8(fn7(v39[i]), 0, function()
				v34 = v42
				fn15(v.LEADERBOARD_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.HOVERBOARD_RACE_ROOT then
		v32 = 9

		for i = 1, #v27 do
			local v40 = i
			fn8(v27[i][1], 0, function()
				v33 = v40
				fn15(v.HOVERBOARD_RACE_LIST)
				fn()
			end)
		end
	elseif LEADERBOARD_ROOT == v.HOVERBOARD_RACE_LIST then
		local v39 = v27[v33]

		for i = 2, #v39 do
			local v41 = i
			fn8("/Lotus/Language/Races/" .. v39[i], 0, function()
				v34 = v41
				fn15(v.LEADERBOARD_LIST)
				fn()
			end)
		end
	end

	v10:Redraw()
	v10.mScrollBar:SetScrollValue(0, true, true)
end

function ShowRootProfileList()
	fn15(v.MAIN)
	fn()
end

function ShowLeaderboards()
	fn15(v.LEADERBOARD_ROOT)
	fn()
end

function ProfileListPressed(p)
	if not (v4 or __wf_atom_7e8ad928(v10)) then
		v10:SelectElementById((tonumber(p)))
	end
end

function ProfileListFocused(p)
	if not __wf_atom_7e8ad928(v10) then
		v10:FocusElementById(tonumber(p), true)
	end
end

function ProfileListUnfocused(p)
	if not __wf_atom_7e8ad928(v10) then
		v10:UnfocusElementById((tonumber(p)))
	end
end

local function fn20()
	v10 = module5.CreateList(mMovie, "Panel.ProfileList.Row1")
	v10:SetCallbacks("ProfileListPressed", "ProfileListFocused", "ProfileListUnfocused")
	v10.mVisibleElements = 16
	v10.mForcedVerticalSeparation = 40
	v10.mScroll = 1
	v10.mInitialDepth = 2000
	v10.mLowerBoundBuffer = 1
	v10:AttachScrollBar("Panel.ProfileScrollBar", 8)
	v10:EnableSmoothScroll()

	function v10.mClipCreatedCallback(p)
		mMovie:OverrideMaterial(p .. ".Highlight", menuVisibleRange)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 11, v3.FloatingContentHighlight)
		mMovie:OverrideMaterial(p .. ".ItemName", menuTextVisibleRange)
		mMovie:__wf_atom_7f57ab2f(p, "ItemName", 54, true)
		mMovie:__wf_atom_48bd5a59(p, "ItemName", 46, "center")
		mMovie:__wf_atom_4c1c1986(p, "ItemName", 90, v3.Background1)
		mMovie:OverrideMaterial(p .. ".Title", menuTextVisibleRange)
		mMovie:__wf_atom_4c1c1986(p, "Title", 44, v3.FloatingContentHighlight)
		mMovie:__wf_atom_7f57ab2f(p, "Title", 54, true)
		mMovie:__wf_atom_48bd5a59(p, "Title", 46, "center")
		mMovie:__wf_atom_4c1c1986(p, "Title", 90, v3.Background1)
		mMovie:OverrideMaterial(p .. ".Bg", menuBackerVisibleRange)
		mMovie:__wf_atom_1ca72041(
			p .. ".Bg",
			"RectEdgeColor",
			v3.FloatingContentObject.red / 255,
			v3.FloatingContentObject.green / 255,
			v3.FloatingContentObject.blue / 255,
			0.35
		)
		mMovie:__wf_atom_1ca72041(
			p .. ".Bg",
			"RectInnerColor",
			v3.Background1Object.red / 255,
			v3.Background1Object.green / 255,
			v3.Background1Object.blue / 255,
			0.35
		)
	end

	function v10.mElementDrawCallback(data)
		local label = tostring(data.Label)
		local v38 = data.Indent ~= v10.MaxIndent

		if v38 then
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Title", 36, TitleCase(label))
		else
			mMovie:__wf_atom_48bd5a59(data.mClipName, "ItemName", 36, string.upper(label))
		end

		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Title", 13, v38)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "ItemName", 13, not v38)
		local v39 = v10:GetFocusedElement() == data

		if v39 then
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ItemName", 44, v3.FloatingContentHighlight)
		else
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ItemName", 44, v3.FloatingContent)
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "Highlight", 12, module3.Ternary(v39, 100, 0))
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg", 13, not v38)
	end

	function v10.mOnFocusedCallback(p)
		if p.Func and not __wf_atom_7e8ad928(p.mClipName) then
			module3.PlaySound(_G.UISound_Focus)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "ItemName", 44, v3.FloatingContentHighlight)
			__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 0, { 12 }, { 60 }, 0.15)
			v9 = true
		end
	end

	function v10.mOnUnfocusedCallback(p)
		if p.Func and not __wf_atom_7e8ad928(p.mClipName) then
			mMovie:__wf_atom_4c1c1986(p.mClipName, "ItemName", 44, v3.FloatingContent)
			__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 0, { 12 }, { 0 }, 0.15)
		end
	end

	function v10.mOnSelectedCallback(p)
		if p.Func ~= nil then
			module3.PlaySound(_G.UISound_Select)
			table.insert(labels, (tostring(p.Label)))

			if type(p.Func) == "string" then
				getfenv()[p.Func]()
			elseif type(p.Func) == "function" then
				p.Func()
			end
		end
	end

	v10._List_ToggleFocusedElement = v10.ToggleFocusedElement

	function v10.ToggleFocusedElement(object, p)
		local v38 = object:GetHowManyElements() + 1
		local count = 0

		while true do
			object:_List_ToggleFocusedElement(p)
			local focusedElement = object:GetFocusedElement()
			count += 1

			if v38 < count then
				break
			end

			if focusedElement ~= nil and focusedElement.Func ~= nil then
				return
			end
		end

		object:FocusElement(3, true)
	end

	function v10.mScrollBar.mScrubStartDragCallback()
		v9 = true
	end
end

local function fn21(items, p)
	local v38 = {}

	for k in pairs(items) do
		table.insert(v38, k)
	end

	table.sort(v38, p)
	local count = 0
	return function()
		count += 1

		if v38[count] == nil then
			return nil
		end

		return v38[count], items[v38[count]]
	end
end

local function fn22()
	local starChart = module2.GetStarChart()
	local __wf_atom_2cdd5bc9 = starChart:__wf_atom_2cdd5bc9()
	local __wf_atom_161b95d4 = starChart:__wf_atom_161b95d4()

	for i = 1, #__wf_atom_161b95d4 do
		__wf_atom_83c14687(0)
		local v38 = __wf_atom_161b95d4[i]
		local v39 = { v38.name }
		local v40 = { v38.name }
		local v41 = { v38.name }
		local v42 = { v38.name }
		local v43 = { v38.name }
		local v44 = { v38.name }
		local v45 = { v38.name }

		for j = 1, #__wf_atom_2cdd5bc9 do
			local v46 = __wf_atom_2cdd5bc9[j]

			if not (v46.region + 1 == i and v46.name:__wf_atom_8598f3a9() and v46.mission.location:__wf_atom_8598f3a9() and (v46.nodeType == 0 or v46.nodeType == 4)) then
				continue
			end

			local missionForLocation = starChart:BuildMissionForLocation(v46.name)
			local missionType = missionForLocation.missionType

			if missionType == 8 then
				if missionForLocation.maxWaveNum == 0 then
					table.insert(v39, v46.name:c_str())
				end
			elseif missionType == 2 then
				table.insert(v40, v46.name:c_str())
			elseif missionType == 13 then
				table.insert(v41, v46.name:c_str())
			elseif missionType == 17 then
				table.insert(v42, v46.name:c_str())
			elseif missionType == 27 then
				table.insert(v43, v46.name:c_str())
			elseif missionType == 30 then
				table.insert(v44, v46.name:c_str())
			elseif missionType == 33 then
				table.insert(v45, v46.name:c_str())
			end
		end

		if #v39 > 1 then
			table.insert(v19, v39)
		end

		if #v40 > 1 then
			table.insert(v20, v40)
		end

		if #v41 > 1 then
			table.insert(v21, v41)
		end

		if #v42 > 1 then
			table.insert(v22, v42)
		end

		if #v43 > 1 then
			table.insert(v23, v43)
		end

		if #v44 > 1 then
			table.insert(v24, v44)
		end

		if #v45 > 1 then
			table.insert(v25, v45)
		end
	end

	local v38 = { (mMovie:__wf_atom_8e9ac384("/Lotus/Language/BardQuest/BardQuestTitle", false)) }

	for k, _ in fn21(v18) do
		table.insert(v38, k)
	end

	table.insert(v26, v38)
	v27[1] = { "/Lotus/Language/Locations/VenusLandscape" }

	for i = 1, 22 do
		local v39 = "VenusRace" .. tostring(i)
		table.insert(v27[1], v39)
	end
end

local function fn23()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, mMovie:__wf_atom_d5a50cb5())
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, mMovie:__wf_atom_c4f6543f())
end

local function fn24(p)
	module3.AnimateTyping(mMovie, _G.UISound_Type, "Panel.Status", mMovie:__wf_atom_8e9ac384(p, true))
end

function StatListPressed(p)
	v5:SelectElementById((tonumber(p)))
end

function StatListFocused(p)
	v5:FocusElementById(tonumber(p), true)
end

function StatListUnfocused(p)
	v5:UnfocusElementById((tonumber(p)))
end

local function fn25()
	v3.FloatingContentObject = module4.GetColor(9, false)
	v3.FloatingContent = v3.FloatingContentObject:__wf_atom_dcecedb0()
	v3.FloatingContentHex = "#" .. string.format("%X", v3.FloatingContent)
	v3.FloatingContentHighlightObject = module4.GetColor(10, false)
	v3.FloatingContentHighlight = v3.FloatingContentHighlightObject:__wf_atom_dcecedb0()
	v3.FloatingContentHighlightHex = "#" .. string.format("%X", v3.FloatingContentHighlight)
	v3.Content = module4.GetColor(6, true)
	v3.ContentHighlight = module4.GetColor(7, true)
	v3.Background1Object = module4.GetColor(2, false)
	v3.Background1 = v3.Background1Object:__wf_atom_dcecedb0()
	v3.BackerHighlight = module4.GetColor(1, true)
	v3.Negative = module4.GetColor(12, true)
	mMovie:OverrideMaterial("Panel.BG", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Panel.BG",
		"RectEdgeColor",
		v3.FloatingContentObject.red / 255,
		v3.FloatingContentObject.green / 255,
		v3.FloatingContentObject.blue / 255,
		0.2
	)
	mMovie:__wf_atom_1ca72041(
		"Panel.BG",
		"RectInnerColor",
		v3.Background1Object.red / 255,
		v3.Background1Object.green / 255,
		v3.Background1Object.blue / 255,
		0.45
	)
	mMovie:__wf_atom_e57658c2("Panel.Status", 44, v3.Content)
	mMovie:__wf_atom_e57658c2("Panel.LeaderboardHeader.Rank", 44, v3.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("Panel.LeaderboardHeader.Label", 44, v3.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("Panel.LeaderboardHeader.Value", 44, v3.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("Panel.Title", 44, v3.FloatingContentHighlight)
end

local function fn26(time)
	if time == nil then
		time = module2.SecondsToFormattedTime(mMovie, v14)
	end

	local v38 = (("<p><font color=\"" .. v3.FloatingContentHex .. "\">") .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/SystemMessages/WeeklyLeaderboardReset",
		true,
		{
			TIME = time,
			OPEN_COLOR = "</font><font color=\"" .. v3.FloatingContentHighlightHex .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. v3.FloatingContentHex .. "\">"
		}
	)) .. "</font></p>"
	mMovie:__wf_atom_50d60589("Panel.ResetTimer", 36, v38)
end

function Initialize()
	module3.PlaySound(_G.UISound_DialogOpen)

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		v6 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_Leaderboards", false), "")
	end

	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	mMovie:__wf_atom_976dcedd("MouseCatcherBtn", "noMenuSelection", true)
	fn23()
	fn25()

	if _T.SelectedProfileImage == nil then
		module2.InitializeProfileIconList()
		module2.RegisterProfileIcon(mMovie, "Panel.Player.ProfileImage", gRegion:__wf_atom_e23b2855()[1])
	end

	local module6 = require("Lotus.Interface.Components.ThemedSpinner")
	v13 = module6.Create(mMovie, "Panel.Spinner", function(p)
		v4 = p

		if p then
			mMovie:__wf_atom_50d60589("Panel.Status", 36, "")
			mMovie:__wf_atom_290807ee("Panel.Status")
		end
	end)
	v5 = module5.CreateList(mMovie, "Panel.StatRow1")
	v5:SetCallbacks("StatListPressed", "StatListFocused", "StatListUnfocused")
	v5.mVisibleElements = 21
	v5.mForcedVerticalSeparation = 30
	v5:AttachScrollBar("Panel.ScrollBar")
	v5.mScroll = 1

	function v5.mClipCreatedCallback(p)
		mMovie:__wf_atom_7f57ab2f(p, "Rank", 54, true)
		mMovie:__wf_atom_7f57ab2f(p, "Label", 54, true)
		mMovie:__wf_atom_7f57ab2f(p, "Value", 54, true)
		mMovie:__wf_atom_4c1c1986(p, "Backer", 11, v3.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p, "Backer", 12, 5)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 11, v3.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 12, 0)
	end

	function v5:mElementDrawCallback()
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Backer", 13, self.Id % 2 == 0)
		self.TextColor = v3.FloatingContent

		if
			_T.SelectedProfileName == nil and self.Label == v8
			or _T.SelectedProfileName ~= nil and self.Label == _T.SelectedProfileName
			or self.Highlight
		then
			self.TextColor = v3.Content
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Rank", 44, self.TextColor)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, self.TextColor)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Value", 44, self.TextColor)

		if self.LocalizedLabel then
			mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Label.text", self.Label)
		else
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 36, self.Label)
		end

		if type(self.Value) == "number" then
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Value", 36, module3.FormatNumber(self.Value))
		else
			mMovie:__wf_atom_50d60589(self.mClipName .. ".Value", 36, self.Value)
		end

		if __wf_atom_7e8ad928(self.Rank) then
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Rank", 36, "")
		else
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Rank", 36, self.Rank)
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 40)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Highlight", 0, __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 / 2)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Highlight", 14, __wf_atom_5e6e15c8_2 + 140)
	end

	function v5.mOnFocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 0, { 12 }, { 60 }, 0.15)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 44, v3.FloatingContentHighlight)
		v9 = false
	end

	function v5.mOnUnfocusedCallback(p)
		_T.gToolTip = nil
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 0, { 12 }, { 0 }, 0.15)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 44, p.TextColor)
	end

	function v5.mScrollBar.mScrubStartDragCallback()
		v9 = false
	end

	__wf_atom_86cbd68d(mMovie, "Panel.ScrollBar.swapDepths", 1500)
	mMovie:__wf_atom_2dedec1a("Panel.Title", 54, true)
	mMovie:__wf_atom_50d60589("Panel.Title", 46, "center")
	fn4("")
	fn24("/Lotus/Language/Menu/LeaderboardsInstruction")
	mMovie:__wf_atom_e57658c2("Panel", 4, 10000)
	mMovie:__wf_atom_e57658c2("Panel", 12, 0)
	v4 = true
	__wf_atom_ec43d06e(mMovie, "Panel", 7, { 4, 12 }, { 0, 100 }, 0.4, 0, function()
		v4 = false
	end)

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0.25, nil, false)
	end

	local mainMenuSuitAvatar = module2.GetMainMenuSuitAvatar()

	if not __wf_atom_7e8ad928(mainMenuSuitAvatar) then
		mainMenuSuitAvatar:SetVisibility(false)
	end

	mMovie:__wf_atom_7d7314f1("Panel.BackBtn.Label.text", "/Lotus/Language/Menu/Global_Back")
	mMovie:__wf_atom_976dcedd("Panel.BackBtn", "callback", "Back")
	mMovie:__wf_atom_7d7314f1("Panel.LeaderboardHeader.Rank.text", "/Lotus/Language/Menu/Global_Rank")
	mMovie:__wf_atom_7d7314f1("Panel.LeaderboardHeader.Label.text", "/Lotus/Language/Menu/Global_Name")
	mMovie:__wf_atom_7d7314f1("Panel.LeaderboardHeader.Value.text", "/Lotus/Language/Menu/Profile_Kills")
	mMovie:__wf_atom_2dedec1a("Panel.LeaderboardHeader", 13, false)

	if not __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))) then
		v8 = "pablo"
	end

	mMovie:__wf_atom_0cf0fdbe(0)
	mMovie:__wf_atom_7df746cd(0)

	if not __wf_atom_7e8ad928(v6) then
		v12 = module2.HasUnlockedHardMode()
		local __wf_atom_ebdc4e6e = v6:GetInventory():__wf_atom_ebdc4e6e()

		for _, v38 in pairs(__wf_atom_ebdc4e6e) do
			if v38.mItemType == zephyrSuit then
				flag2 = true
			end
		end

		local __wf_atom_db1ae7f4 = v6:GetInventory():__wf_atom_db1ae7f4()

		for _, v38 in pairs(__wf_atom_db1ae7f4) do
			if not (v38.mItemType == wyrmSentinel or v38.mItemType == wyrmPrimeSentinel) then
				continue
			end

			flag3 = true
			break
		end

		v14 = v6:__wf_atom_32ca84d5()
	end

	mMovie:__wf_atom_50d60589("Panel.Status", 46, "bottom")
	fn26()
	fn18()
	fn20()
	fn()
	fn2()
	table.insert(v11, {
		mVisible = true,
		mLabel = "/Lotus/Language/Menu/Exit",
		mCallback = function()
			if not __wf_atom_7e8ad928(mMovie) then
				mMovie:Execute("Back", "")
			end
		end,
		mCallout = "MENU_CANCEL"
	})
	fn3()
	fn22()
	mMovie:__wf_atom_e57658c2("Panel.BG", 12, 95)
	v9 = true
	flag = true

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "PROFILE_LEADERBOARDS")
	end
end

function Update()
	if not flag then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v13) then
		v13:Update()
	end

	v15 -= __wf_atom_fa1258d0()

	if v15 <= 0 then
		v15 += 1
		v14 -= 1

		if v14 < 0 and not __wf_atom_7e8ad928(v6) then
			v14 = v6:__wf_atom_32ca84d5()
		end

		fn26(module2.SecondsToFormattedTime(mMovie, v14))
	end
end

local function fn27()
	_T.SelectedProfileName = nil
	_T.SelectedProfileId = nil
	_T.SelectedProfileImage = nil
	_T.gToolTip = nil

	if flag then
		v4 = true
		__wf_atom_ec43d06e(mMovie, "Panel", 0, { 12 }, { 0 }, 0.25, 0, function()
			mMovie:Close()
		end)

		if not __wf_atom_7e8ad928(nil) then
			__wf_atom_ec43d06e(nil, "_root", 0, { 12 }, { 0 }, 0.2)
		end
	end

	module3.PlaySound(_G.UISound_DialogClose)
end

local function fn28()
	if not __wf_atom_7e8ad928(nil) then
		(nil):Execute("TransitionOut", "")
	end

	v7 = true
	fn27()
end

function TransitionOut()
	fn28()
end

function Close()
	fn27()
end

function Back()
	if v4 then
		return
	end

	module3.PlaySound(_G.UISound_WindowClose)

	if LEADERBOARD_ROOT == v.LEADERBOARD_LIST then
		if v32 == 1 then
			fn15(v.DEFENSE_LIST)
		elseif v32 == 2 then
			fn15(v.SURVIVAL_LIST)
		elseif v32 == 3 then
			fn15(v.INTERCEPTION_LIST)
		elseif v32 == 4 then
			fn15(v.EXCAVATION_LIST)
		elseif v32 == 5 then
			fn15(v.DEFECTION_LIST)
		elseif v32 == 6 then
			fn15(v.DISRUPTION_LIST)
		elseif v32 == 7 then
			fn15(v.QUEST_LIST)
		elseif v32 == 9 then
			fn15(v.HOVERBOARD_RACE_LIST)
		else
			fn15(v.LEADERBOARD_ROOT)
		end

		fn()
	elseif
		LEADERBOARD_ROOT == v.DEFENSE_ROOT
		or LEADERBOARD_ROOT == v.SURVIVAL_ROOT
		or LEADERBOARD_ROOT == v.INTERCEPTION_ROOT
		or LEADERBOARD_ROOT == v.EXCAVATION_ROOT
		or LEADERBOARD_ROOT == v.DEFECTION_ROOT
		or LEADERBOARD_ROOT == v.DISRUPTION_ROOT
	then
		fn15(v.LEADERBOARD_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.DEFENSE_LIST then
		fn15(v.DEFENSE_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.SURVIVAL_LIST then
		fn15(v.SURVIVAL_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.INTERCEPTION_LIST then
		fn15(v.INTERCEPTION_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.EXCAVATION_LIST then
		fn15(v.EXCAVATION_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.DEFECTION_LIST then
		fn15(v.DEFECTION_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.DISRUPTION_LIST then
		fn15(v.DISRUPTION_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.HOVERBOARD_RACE_LIST then
		fn15(v.HOVERBOARD_RACE_ROOT)
		fn()
	elseif LEADERBOARD_ROOT == v.LEADERBOARD_ROOT then
		fn28()
	else
		fn15(v.LEADERBOARD_ROOT)
		fn()
	end

	if LEADERBOARD_ROOT == v.LEADERBOARD_ROOT then
		labels = {}
	elseif #labels > 0 then
		table.remove(labels, #labels)
	end
end

local function fn29(p, _, p2)
	module3.PlaySound(_G.UISound_ItemTipSection)
	v13:SetActive(false)
	v5:RemoveElements(true)

	if __wf_atom_7e8ad928(v6) then
		return
	end

	local __wf_atom_0a838764 = v6:__wf_atom_0a838764()
	local v38 = ""

	for i, v39 in ipairs(labels) do
		if i > 1 then
			v38 ..= " / "
		end

		v38 ..= __wf_atom_0a63ecce(v39)
	end

	if v35 > 1 then
		v38 ..= " (" .. mMovie:__wf_atom_8e9ac384(v2[v35], false) .. ")"
	end

	fn4(v38)

	if #labels > 0 then
		table.remove(labels, #labels)
	end

	if p then
		local count = #__wf_atom_0a838764

		if count == 0 then
			mMovie:__wf_atom_2dedec1a("Panel.LeaderboardHeader", 13, false)
			v5:RemoveElements()
			fn24("/Lotus/Language/Menu/Profile_Unranked")
		else
			mMovie:__wf_atom_2dedec1a("Panel.LeaderboardHeader", 13, true)
			mMovie:__wf_atom_50d60589("Panel.Status", 36, "")
			local v39 = count > 20 and 20 or count
			local v40 = fn10(p2)
			local v41 = v36 == "/Lotus/Language/Menu/Profile_Time"

			for i = 1, v39 do
				local v42 = __wf_atom_0a838764[i]
				local name = v42.name

				if p2 and module3.IsUGCRestricted() then
					name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_GuildBtn", false)
				end

				local score

				if v40 then
					if v42.score == 0 then
						if v42.score == 0 and v42.duration > 0 then
							score = module2.SecondsToFormattedTime(mMovie, v42.duration)
						else
							score = v42.score
						end
					else
						local secondsToFormattedTime = module2.SecondsToFormattedTime(mMovie, v42.duration)
						score = v42.score .. " ~ " .. secondsToFormattedTime
					end
				elseif __wf_atom_7e8ad928(formattingFunction) then
					if v41 then
						score = module2.SecondsToFormattedTime(mMovie, v42.score)
					else
						score = v42.score
					end
				else
					score = formattingFunction(v42.score)
				end

				fn5(p2, name, score, 0, false, v42.rank)
			end

			v5:Redraw()
		end
	else
		mMovie:__wf_atom_2dedec1a("Panel.LeaderboardHeader", 13, false)
		v5:RemoveElements()
		fn24("/Lotus/Language/Menu/Profile_FailedToConnect")
	end
end

function OnLeaderboard(p, p2)
	fn29(p, p2, false)
end

function OnGuildLeaderboard(p, p2)
	fn29(p, p2, true)
end

function ReplayTutorial()
	module3.PlaySound(_G.UISound_Select)

	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
		module3.ShowConfirmMessage("/Lotus/Language/Menu/Profile_ReplayTutorialConfirm", "LoadDojo")
	else
		module3.ShowMessage("/Lotus/Language/Menu/Profile_ReplayTutorialSessionActive")
	end
end

function LoadDojo(p)
	if tonumber(p) ~= 4 then
		return
	end

	module.__wf_atom_e6044212()
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not v9 and v5.mScrollBar ~= nil and v5.mScrollBar.mEnabled then
		v5.mScrollBar:ScrollBy(tonumber(p) * v5.mScrollBar.mScrollStep * 3)
	elseif v9 and v10.mScrollBar ~= nil and v10.mEnabled then
		v10.mScrollBar:ScrollBy(tonumber(p) * v10.mScrollBar.mScrollStep * 3)
	end
end

function onKeyUp_MENU_SELECT()
	if not v4 then
		v10:SelectCurrentElement()
	end

	return true
end

function onViewportSizeChanged(_, _)
	fn23()
	fn2()
end

function SupportsThemes()
	return true
end