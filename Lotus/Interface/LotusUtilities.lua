module(..., package.seeall)
local v = {
	"DT_IMPACT",
	"DT_PUNCTURE",
	"DT_SLASH",
	"DT_FIRE",
	"DT_FREEZE",
	"DT_ELECTRICITY",
	"DT_POISON",
	"DT_EXPLOSION",
	"DT_RADIATION",
	"DT_GAS",
	"DT_MAGNETIC",
	"DT_VIRAL",
	"DT_CORROSIVE",
	"DT_RADIANT",
	"DT_SENTIENT",
	"DT_CINEMATIC",
	"DT_SHIELD_DRAIN",
	"DT_HEALTH_DRAIN",
	"DT_ENERGY_DRAIN",
	"DT_FINISHER",
	"DT_SUICIDE",
	"DT_PHYSICAL",
	"DT_INVALID",
	"DT_BASE_ELEMENTAL",
	"DT_COMPOUND_ELEMENTAL",
	"DT_ANY_ELEMENTAL",
	"DT_ANY"
}
local v2 = {
	"MS_AKIMBO_DAGGER",
	"MS_AKIMBO_SHORT_SWORD",
	"MS_BAYONET",
	"MS_BERSERKER",
	"MS_BOW",
	"MS_BO_STAFF",
	"MS_DAGGER",
	"MS_ENERGY_SWORD",
	"MS_FIST",
	"MS_GLAIVE",
	"MS_HEAVY_AXE",
	"MS_HEAVY_SCYTHE",
	"MS_HEAVY_SWORD",
	"MS_KATANA_ALT",
	"MS_KATANA",
	"MS_KATANA_LONG",
	"MS_LONG_SWORD",
	"MS_MONKEY_STAFF",
	"MS_NUNCHAKU",
	"MS_RAPIER",
	"MS_SAW_HEAVY",
	"MS_SWORD_SHIELD",
	"MS_TONFA",
	"MS_WARFAN",
	"MS_WHIP",
	"MS_ANY"
}
local v3 = {
	"PT_KNOCKBACK",
	"PT_FRAILTY",
	"PT_BLEEDING",
	"PT_IMMOLATION",
	"PT_CHILLED",
	"PT_ELECTROCUTION",
	"PT_POISONED",
	"PT_FLASHBANG",
	"PT_RAD_TOX",
	"PT_ASPHYXIATION",
	"PT_MAGNETIZED",
	"PT_INFECTED",
	"PT_CAUSTIC_BURN",
	"PT_RADIANT",
	"PT_SENTIENT",
	"PT_MICROWAVE_BURN",
	"PT_STAGGERED",
	"PT_BIG_STAGGER",
	"PT_STUNNED",
	"PT_KNOCKED_DOWN",
	"PT_RAGDOLL",
	"PT_PARRIED",
	"PT_DISARMED",
	"PT_SILENCED",
	"PT_ROOTS",
	"PT_VOID",
	"PT_GLUE",
	"PT_SLEEP",
	"PT_LIFT_HIT",
	"PT_COUNTERED",
	"PT_GUARD_REACT",
	"PT_GUARD_BREAK",
	"MAX_ProcType"
}
local v4 = {
	"AP_UNIVERSAL",
	"AP_ATTACK",
	"AP_DEFENSE",
	"AP_TACTIC",
	"AP_POWER",
	"AP_PRECEPT",
	"AP_FUSION",
	"AP_WARD",
	"AP_UMBRA",
	"AP_COURAGE",
	"AP_SPIRIT",
	"AP_GRACE",
	"AP_ANY"
}
local v5 = {}
assert(#v == 26 + 1)
assert(#v3 == 32 + 1)
assert(#v2 == 25 + 1)
assert(#v4 == 12 + 1)
local v6 = WeakResource("/Lotus/Types/StoreItems/SuitCustomizations/ColourPickerDefaultsItemA")
WeakResource("/Lotus/Types/Items/MiscItems/PhotoboothTile")
local v7 = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ShipFeatureItem")
UI_MODE_IN_SPACE_SHIP = 1
UI_MODE_IN_SPACE_HUB = 2
UI_MODE_IN_DOJO = 3
UI_MODE_IN_GAME = 4
REGION_ID_DOJO = 14
REGION_ID_VOID = 15
REGION_ID_DERELICT = 17
REGION_ID_MOON = 18
REGION_ID_FORTRESS = 19
REGION_ID_DARK_SECTOR = 20
REGION_ID_DEEP_SPACE = 21
REGION_ID_ZARIMAN = 22
REGION_ID_DUVIRI = 23
REGION_ID_DOJO_DUEL = 97
REGION_ID_CLAN_DOJO = 98
REGION_ID_PVP = 99
REGION_ID_PHOTOBOOTH = 100
REGION_ID_SIMULACRUM = 101
SLIDER = 1
CHECKBOX = 2
TOGGLE = 3
BUTTON = 4
TITLE = 5
INPUTBOX = 6
SPACER = 7
INPUTCOUNT = 8
ICONBUTTON = 9
CHOICE = 10
COLOR = 11
DECO_AREA_UNKNOWN = 0
DECO_AREA_SHIP = 1
DECO_AREA_APARTMENT = 2
DECO_AREA_COUNT = 3
REPORT_PLAYER = 1
REPORT_CLAN_AD = 2
OUTSIDE_THE_SHIP_ROOM = {
	Name = Symbol("OutsideRoom"),
	LocTag = "/Lotus/Language/UiElements/OutsideRoom"
}
LISET_ROOM = { Name = Symbol("LisetRoom"), LocTag = "/Lotus/Language/UiElements/ShipLisetRoom" }
SHIP_ROOMS = {
	{
		Name = Symbol("OperatorChamberRoom"),
		LocTag = "/Lotus/Language/UiElements/ShipOperatorChamberRoom"
	},
	{ Name = Symbol("AlchemyRoom"), LocTag = "/Lotus/Language/UiElements/ShipAlchemyRoom" },
	{
		Name = Symbol("PersonalQuartersRoom"),
		LocTag = "/Lotus/Language/UiElements/ShipPersonalQuartersRoom"
	},
	{ Name = Symbol("BridgeRoom"), LocTag = "/Lotus/Language/UiElements/ShipBridgeRoom" },
	LISET_ROOM
}
APARTMENT_ROOMS = {}
SLOT_TYPES = { "WARFRAME_SLOT", "WEAPON_SLOT" }
SOUND_SET_EIDOLON = 1
SOUND_SET_FORTUNA = 2
SOUND_SET_ORB_VALLIS = 3
SOUND_SET_RAILJACK = 4
SOUND_SET_OROKIN_TOWER = 5
SOUND_SET_ZARIMAN = 6
SOUND_SET_DUVIRI = 7
SOUND_SET_ENTRATILAB = 8
TAG_SEPERATOR = "_"
ALERT_TAG = TAG_SEPERATOR .. "Alert"
ALERT_FLAG = 100000
NIGHTMARE_TAG = TAG_SEPERATOR .. "Nightmare"
NIGHTMARE_FLAG = 200000
NIGHTMARE_MISSION_INTERVAL = 28800
EVENT_TAG = TAG_SEPERATOR .. "Event"
EVENT_FLAG = 300000
PVP_TAG = TAG_SEPERATOR .. "PVP"
PVP_FLAG = 400000
INVASION_ATTACKER_TAG = TAG_SEPERATOR .. "InvasionAttacker"
INVASION_ATTACKER_FLAG = 500000
INVASION_DEFENDER_TAG = TAG_SEPERATOR .. "InvasionDefender"
INVASION_DEFENDER_FLAG = 600000
HUB_TAG = TAG_SEPERATOR .. "HUB"
HUB_FLAG = 700000
SYNDICATE_MISSION_TAG = TAG_SEPERATOR .. "Syndicate"
SYNDICATE_MISSION_FLAG = 1100000
KEY_TAG = TAG_SEPERATOR .. "Key"
KEY_FLAG = 1200000
SORTIE_MISSION_TAG = TAG_SEPERATOR .. "Sortie"
SORTIE_MISSION_FLAG = 1300000
ACTIVE_MISSION_TAG = TAG_SEPERATOR .. "ActiveMission"
ACTIVE_MISSION_FLAG = 1400000
KUVA_TOWER_MISSION_TAG = TAG_SEPERATOR .. "GhostTower"
KUVA_TOWER_MISSION_FLAG = 1500000
JUNCTION_TAG = TAG_SEPERATOR .. "JUNCTION"
JUNCTION_FLAG = 1600000
NEMESIS_MISSION_TAG = TAG_SEPERATOR .. "Nemesis"
NEMESIS_MISSION_FLAG = 1700000
ELITE_ALERT_TAG = TAG_SEPERATOR .. "EliteAlert"
ELITE_ALERT_FLAG = 1800000
ELITE_ALERT_PERIODIC_MISSION_TAG = Symbol("EliteAlert")
ELITE_ALERT_PERIODIC_MISSION_TAG_ALT = Symbol("EliteAlertB")
ELITE_ALERT_MISSION_INTERVAL = 3600
SCENARIO_BEACON_TAG = TAG_SEPERATOR .. "Scenario"
SCENARIO_BEACON_FLAG = 1900000
HARD_MODE_TAG = TAG_SEPERATOR .. "Hard"
HARD_MODE_FLAG = 2000000
HARD_MODE_LEVEL_MODIFIER = 100
HARD_MODE_ARCHWING_LEVEL_MODIFIER = 50
HARD_MODE_DUVIRI_LEVEL_MODIFIER = 20
HARD_MODE_DAILY_MISSION_INTERVAL = 86400
HARD_DAILY_TAG = TAG_SEPERATOR .. "HardDaily"
HARD_DAILY_FLAG = 2100000
VOID_STORM_TAG = TAG_SEPERATOR .. "VoidStorm"
VOID_STORM_FLAG = 2200000
LITE_SORTIE_MISSION_TAG = TAG_SEPERATOR .. "LiteSortie"
LITE_SORTIE_MISSION_FLAG = 2300000
KUVA_TOWER_MISSION_INTERVAL = 3600
OPTIONAL_GOAL_PREFIX = "OptionalGoal"
ANY_NODE_PREFIX = "AnyNode"
ZARIMAN_NODE_TAG = Symbol("ZarimanHub")
CETUS_NODE_TAG = Symbol("CetusHub4")
PLAINS_NODE_TAG = Symbol("SolNode228")
IRON_WAKE_NODE_TAG = Symbol("IronwakeHUB3")
FORTUNA_NODE_TAG = Symbol("SolarisUnitedHub1")
ORB_VALLIS_NODE_TAG = Symbol("SolNode129")
MARS_DUAL_DEFENSE_TAG = Symbol("SolNode450")
DEIMOS_DUAL_DEFENSE_TAG = Symbol("SolNode719")
OROKIN_TOWER_NODE_TAG = Symbol("DeimosHub")
ENTRATI_LAB_NODE_TAG = Symbol("EntratiLabHub")
ENTRATI_LANDSCAPE_NODE_TAG = Symbol("SolNode229")
SCENARIO_EVENT_HUB_TAG = Symbol("ScenarioEventHub5")
APARTMENT_NODE_TAG = Symbol("SolNode234")
ZARIMAN_MISSION_A_TAG = Symbol("SolNode230")
ZARIMAN_MISSION_B_TAG = Symbol("SolNode231")
ZARIMAN_MISSION_C_TAG = Symbol("SolNode232")
ZARIMAN_MISSION_D_TAG = Symbol("SolNode233")
ZARIMAN_MISSION_E_TAG = Symbol("SolNode235")
SCENARIO_EVENT_GROUND_TAG = Symbol("/Lotus/Types/Keys/TestKeyForestOpLinkFragment")
SCENARIO_EVENT_SPACE_TAG = Symbol("/Lotus/Types/Keys/TestKeyCrewBattleSentientSquadLink")
ENTRATI_LAB_ZONE_TAG = Symbol("EntratiLabHubZone")
DEIMOS_NECRALISK_ZONE_TAG = Symbol("DeimosHubZone")
PLAINS_ELO_IN_LISET = 0
PLAINS_ELO_INSIDE_SAFE_ZONE = 1
PLAINS_ELO_OUTSIDE_SAFE_ZONE = 2
PLAINS_ELO_BOUNTY_ACTIVE = 3
PLAINS_ELO_POST_NEW_WAR_OFFSET = 10
local v8 = Symbol("Darvo")
local v9 = Symbol("founders")
FactionNames = {
	"/Lotus/Language/Game/Faction_GrineerUC",
	"/Lotus/Language/Game/Faction_CorpusUC",
	"/Lotus/Language/Game/Faction_InfestationUC",
	"/Lotus/Language/Game/Faction_OrokinUC",
	"/Lotus/Language/Game/Faction_RedVeilUC",
	"/Lotus/Language/Game/Faction_SentientUC",
	"/Lotus/Language/Game/Faction_NarmerUC",
	"/Lotus/Language/Game/Faction_MITW",
	""
}
HIDDEN_PLAYER_NAME = "???"
SF_ALERTS = WeakResource("/Lotus/Types/Items/ShipFeatureItems/AlertsFeatureItem")
SF_ARSENAL = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ArsenalFeatureItem")
SF_ARSENAL_MELEE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ArsenalMeleeFeatureItem")
SF_CLAN = WeakResource("/Lotus/Types/Items/ShipFeatureItems/SocialMenuFeatureItem")
SF_FOUNDRY = WeakResource("/Lotus/Types/Items/ShipFeatureItems/FoundryFeatureItem")
SF_FOUNDRY_VESSEL_UPGRADE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/FoundryVesselUpgradeFeatureItem")
SF_GENETIC_FOUNDRY = WeakResource("/Lotus/Types/Items/ShipFeatureItems/GeneticFoundryFeatureItem")
SF_GENETIC_FOUNDRY_UPGRADE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/GeneticFoundryUpgradeFeatureItem")
SF_INFESTED_FOUNDRY = WeakResource("/Lotus/Types/Items/ShipFeatureItems/InfestedFoundryItem")
SF_INFESTED_FOUNDRY_UPGRADE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/InfestedFoundryUpgradeFeatureItem")
SF_INFESTED_FOUNDRY_SHARD_UPGRADE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/InfestedFoundryArchonShardFeatureItem")
SF_INFESTED_FOUNDRY_FUSION_UPGRADE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/InfestedFoundryArchonShardUpgradeFeatureItem")
SF_MARKET_TIER_ONE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/SocialMenuFeatureItem")
SF_MARKET_TIER_TWO = WeakResource("/Lotus/Types/Items/ShipFeatureItems/SocialMenuFeatureItem")
SF_MODS = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ModsFeatureItem")
SF_MODS_FUSION = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ModsFeatureItem")
SF_MODS_TRANSMUTE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ModsFeatureItem")
SF_CONCLAVE = WeakResource("/Lotus/Types/Items/ShipFeatureItems/SocialMenuFeatureItem")
SF_SOCIAL_MENU = WeakResource("/Lotus/Types/Items/ShipFeatureItems/SocialMenuFeatureItem")
SF_SOLAR_CHART = WeakResource("/Lotus/Types/Items/ShipFeatureItems/MercuryNavigationFeatureItem")
SF_VOID_PROJECTION = WeakResource("/Lotus/Types/Items/ShipFeatureItems/VoidProjectionFeatureItem")
SF_PERSONAL_QUARTERS = WeakResource("/Lotus/Types/Items/ShipFeatureItems/PersonalQuartersFeatureItem")
SF_RAILJACK_CEPHALON = WeakResource("/Lotus/Types/Items/ShipFeatureItems/RailjackCephalonShipFeatureItem")
SF_RAILJACK_KEY = WeakResource("/Lotus/Types/Items/ShipFeatureItems/RailjackKeyShipFeatureItem")
SF_ADVANCED_ORDIS = WeakResource("/Lotus/Types/Items/ShipFeatureItems/AdvancedOrdisFeatureItem")
MAX_PVP_LOADOUTS = 20
MAX_BIN_SLOTS = 999
VOID_PROJECTION_ITEMS = {}
POST_NEW_WAR_MISSIONS = {}
DUVIRI_MISSION_NODES = {
	"SolNode236",
	"SolNode237",
	"SolNode238",
	"/Lotus/Types/Keys/DuviriQuest/DuviriKullervoEventKey"
}
DUVIRI_ENDLESS_NODE = "SolNode238"
ENTRATI_LAB_MISSION_NODES = {
	"SolNode715",
	"SolNode716",
	"SolNode717",
	"SolNode718",
	"SolNode719",
	"SolNode720"
}
HT_PROGRESS_BAR = 1
HT_TIMER = 2
HT_HEALTH_TRACKER = 3
HT_ICON_BAR = 4
HT_OPPONENT_BAR = 5
HT_LABEL = 6
HT_TEMPERATURE_BAR = 7
HT_CORRUPTION_BAR = 8
HT_NODE_CONFLICT_BAR = 9
HT_DRAGON_TRACKER = 10
HT_ALCHEMY_BAR = 11
SCAN_ENTITY_TYPES = {
	__wf_atom_8d0b7f88,
	__wf_atom_4e9f6070,
	__wf_atom_3be5e2e6,
	__wf_atom_3d6e3759,
	__wf_atom_4ebf67cb,
	__wf_atom_7b01f9ce,
	__wf_atom_3feeb44a
}
TimeOfDayConstants = {
	HOURS_PER_SECOND_EIDOLON = 0.0026670001,
	HOURS_PER_SECOND_VENUS = 0.015,
	HOURS_PER_SECOND_ENTRATI = 0.0026670001,
	HOURS_PER_SECOND_ZARIMAN = 0.0016666667,
	TIME_OF_DAY_LABEL_NIGHT = "/Lotus/Language/Game/TimeOfDay_Night",
	TIME_OF_DAY_LABEL_DAY = "/Lotus/Language/Game/TimeOfDay_Day",
	TIME_OF_DAY_LABEL_WARM = "/Lotus/Language/Game/TimeOfDay_Warm",
	TIME_OF_DAY_LABEL_COLD = "/Lotus/Language/Game/TimeOfDay_Cold",
	TIME_OF_DAY_LABEL_FASS = "/Lotus/Language/Mods/ImmortalSixModName",
	TIME_OF_DAY_LABEL_VOME = "/Lotus/Language/Mods/ImmortalFourModName",
	TIME_OF_DAY_LABEL_CONFLICT = "/Lotus/Language/Game/Territory_Conflict",
	TIME_OF_DAY_LABEL_CORPUS = "/Lotus/Language/Zariman/ZarimanInfluenceCorpus",
	TIME_OF_DAY_LABEL_GRINEER = "/Lotus/Language/Zariman/ZarimanInfluenceGrineer"
}
local v10 = {
	Symbol("GAME_L1_ARM2"),
	Symbol("GAME_C1_HEAD1"),
	Symbol("GAME_R1_LEG1"),
	Symbol("GAME_L1_LEG2")
}
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local v11 = { "#FFFFFF", "#24D628", "#238DFF", "#C724D6" }
local v12 = { 16777215, 2414120, 2330111, 13051094 }
local total = 0
local v13 = Symbol("ScanPoint")
local v14 = Symbol("KuvaSurvival")
local v15 = {
	Default = { Scale = 1500, X = 0, Y = 0, Alpha = 5 },
	["/Lotus/Interface/Icons/Syndicates/FactionSigilRebels.png"] = { Scale = 2000, X = 40, Y = -40 },
	["/Lotus/Interface/Icons/Syndicates/FactionSigilOracle.png"] = {
		Scale = 1000,
		X = 0,
		Y = 0,
		Alpha = 8
	},
	["/Lotus/Interface/Icons/Syndicates/FactionSigilBusiness.png"] = { Scale = 2400, X = 0, Y = 20 },
	["/Lotus/Interface/Icons/Syndicates/FactionSigilAssassins.png"] = {
		Scale = 1300,
		X = -50,
		Y = 0
	},
	["/Lotus/Interface/Icons/Syndicates/FactionSigilChurch.png"] = { Scale = 1500, X = 0, Y = 60 },
	["/Lotus/Interface/Icons/Syndicates/FactionSigilEidolonHunter.png"] = {
		Scale = 1500,
		X = 0,
		Y = 40,
		Alpha = 15
	},
	["/Lotus/Interface/Graphics/Fortuna/FortunaTitleIcon.png"] = {
		Scale = 1000,
		X = 0,
		Y = 0,
		Alpha = 8
	},
	["/Lotus/Interface/Icons/Syndicates/FactionVentKidz.png"] = {
		Scale = 1500,
		X = 0,
		Y = 40,
		Alpha = 8
	},
	["/Lotus/Interface/Icons/Syndicates/FactionSigilSolarisUnited.png"] = {
		Scale = 1500,
		X = 0,
		Y = 0,
		Alpha = 15
	},
	["/Lotus/Interface/Icons/Syndicates/FactionSigilConclave.png"] = {
		Scale = 1300,
		X = 0,
		Y = 0,
		Alpha = 7
	}
}
local fn
local fn2
local fn3
local fn4
local v16 = {
	[2] = { [0] = true, [1] = true },
	[3] = { [2] = true, [3] = true },
	[4] = { [8] = true, [9] = true },
	[5] = { [4] = true, [5] = true },
	[6] = { [12] = true, [13] = true },
	[7] = { [16] = true, [17] = true },
	[8] = { [20] = true, [21] = true },
	[9] = { [24] = true, [25] = true },
	[10] = { [22] = true, [23] = true },
	[11] = { [18] = true, [19] = true },
	[12] = { [13] = true, [14] = true },
	[13] = { [6] = true, [7] = true },
	[16] = { [10] = true, [11] = true }
}

function GetWarframeFromOperator(object)
	local __wf_atom_0d9c1a58 = object:__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
		return nil
	end

	return __wf_atom_0d9c1a58:__wf_atom_eff0517e()
end

function UnmountVehicleAndGetRider(instance)
	if not instance:IsA(__wf_atom_47cae841) then
		return instance
	end

	local __wf_atom_4221009f = instance:__wf_atom_4221009f()

	if not __wf_atom_7e8ad928(__wf_atom_4221009f) then
		instance:GetOffVehicle(__wf_atom_4221009f, Vector(), true)
		instance = __wf_atom_4221009f
	end

	return instance
end

local function fn5(p, p2)
	local ternary = module.Ternary(p2 ~= nil, p2, 2)
	local v17 = getfenv(ternary)

	while not v17.mMovie or not __wf_atom_7e8ad928(p) and v17.mMovie ~= p do
		ternary += 1
		v17 = getfenv(ternary)
	end

	return v17
end

function ShouldBlockForTutorial()
	if _T.hasCheckedTutorial == nil or not _T.hasCheckedTutorial then
		return true
	end

	return _T.tutorialActive ~= nil and _T.tutorialActive
end

function GetPhotoshopDefaultSwatches()
	return {
		4591633,
		6756120,
		9773092,
		12265515,
		13708851,
		4003870,
		5775914,
		8663871,
		11421784,
		13260653,
		2100501,
		3873573,
		7419972,
		11428207,
		13928599,
		2492950,
		4067364,
		7216189,
		10299227,
		12464506,
		987681,
		1448500,
		2502747,
		3950990,
		5334711,
		530470,
		797252,
		1460087,
		1994408,
		2396358,
		930629,
		1526113,
		2716301,
		4169655,
		5619666,
		1650218,
		2442557,
		3828063,
		5543563,
		7388337,
		1125400,
		1721894,
		2914624,
		4303198,
		5491068,
		3816203,
		6317074,
		9409055,
		12106284,
		13750327,
		5916201,
		8347962,
		11111504,
		13546858,
		15126918,
		8143131,
		9589797,
		11366711,
		13014608,
		14530158,
		10107422,
		11751209,
		13529661,
		14786650,
		15254401,
		3282697,
		6301969,
		10767646,
		13726758,
		14127655,
		2694428,
		4994866,
		9398364,
		13213582,
		14991277,
		2631460,
		6117971,
		12499631,
		16118763,
		16777215,
		2106148,
		4673359,
		9872548,
		14082529,
		15989754,
		1908258,
		4145995,
		9080479,
		13225437,
		15199223
	}
end

function GetKubrowTypesTable()
	local v17 = {}

	for i = 1, #v17 do
		v17[i].Icon = _G.UITexture_CompanionIcons[i]
	end

	return v17
end

local function fn6(_, p, p2, p3, p4, p5, p6)
	local v17 = Localize("/Lotus/Language/Menu/TimeFormat_DaysShort", false)
	local v18 = Localize("/Lotus/Language/Menu/TimeFormat_HoursShort", false)
	local v19 = Localize("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
	local v20 = Localize("/Lotus/Language/Menu/TimeFormat_SecondsShort", false)

	if p5 then
		if p5 == "Compact" or p5 == "CompactTwoMax" or p5 == "CompactOne" then
			if p > 0 then
				if p5 == "CompactTwoMax" then
					return p6 .. string.format("%d" .. v17 .. " %d" .. v18, p, p2)
				elseif p5 == "CompactOne" then
					return p6 .. string.format("%d" .. v17, p)
				end

				return p6 .. string.format("%d" .. v17 .. " %d" .. v18 .. " %d" .. v19 .. " %d" .. v20, p, p2, p3, p4)
			elseif p2 > 0 then
				if p5 == "CompactTwoMax" then
					return p6 .. string.format("%d" .. v18 .. " %d" .. v19, p2, p3)
				elseif p5 == "CompactOne" then
					return p6 .. string.format("%d" .. v18, p2)
				end

				return p6 .. string.format("%d" .. v18 .. " %d" .. v19 .. " %d" .. v20, p2, p3, p4)
			elseif p3 > 0 then
				if p5 == "CompactOne" then
					return p6 .. string.format("%d" .. v19, p3)
				end

				return p6 .. string.format("%d" .. v19 .. " %d" .. v20, p3, p4)
			else
				return p6 .. string.format("%d" .. v20, p4)
			end
		else
			if p5 == "HoursOrMinutesOrSeconds" and p == 0 and p2 == 0 and p3 == 0 then
				local ternary = module.Ternary(
					p4 == 1,
					"/Lotus/Language/Menu/TimeFormat_Second",
					"/Lotus/Language/Menu/TimeFormat_Seconds"
				)
				return p6 .. Localize(ternary, { TIME = string.format("%d", p3) })
			end

			if (p5 == "HoursOrMinutes" or p5 == "HoursOrMinutesOrSeconds") and p == 0 and p2 == 0 then
				local ternary = module.Ternary(
					p3 == 1,
					"/Lotus/Language/Menu/TimeFormat_Minute",
					"/Lotus/Language/Menu/TimeFormat_Minutes"
				)
				return p6 .. Localize(ternary, { TIME = string.format("%d", p3) })
			end

			if p5 ~= "CompactHours" then
				local ternary = module.Ternary(
					p2 > 1 or p > 0,
					"/Lotus/Language/Menu/TimeFormat_Hours",
					"/Lotus/Language/Menu/TimeFormat_Hour"
				)
				return p6 .. Localize(ternary, {
					TIME = string.format("%d", p * 24 + p2)
				})
			end

			local v21 = p * 24 + p2

			if v21 > 0 then
				return p6 .. string.format("%d " .. v18, v21)
			end

			if p3 > 0 then
				return p6 .. string.format("%d " .. v19, p3)
			end

			return p6 .. string.format("%d " .. v20, p4)
		end
	elseif p > 0 then
		return p6 .. string.format("%d" .. v17 .. " %d" .. v18 .. " %d" .. v19 .. " %d" .. v20, p, p2, p3, p4)
	else
		return p6 .. string.format("%d" .. v18 .. " %d" .. v19 .. " %d" .. v20, p2, p3, p4)
	end
end

local function fn7(p)
	local v17 = math.floor(p / 86400)
	local v18 = p - v17 * 86400
	local v19 = math.floor(v18 / 3600)
	local v20 = v18 - v19 * 3600
	local v21 = math.floor(v20 / 60)
	return v17, v19, v21, v20 - v21 * 60
end

function GetSecondElements(p)
	return fn7(p)
end

local function fn8(p, p2, p3)
	local v17

	if p2 < 0 then
		p2 = -p2
		v17 = "-"
	else
		v17 = ""
	end

	local v18, v19, v20, v21 = fn7(p2)
	return fn6(p, v18, v19, v20, v21, p3, v17)
end

function SecondsToFormattedTime(p, p2, p3)
	return (fn8(p, p2, p3))
end

function GetTwitterStyleTime(p, p2, p3)
	local v17 = Localize("/Lotus/Language/Menu/TimeFormat_DaysShort", false)
	local v18 = Localize("/Lotus/Language/Menu/TimeFormat_HoursShort", false)
	local v19 = Localize("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
	local v20 = Localize("/Lotus/Language/Menu/TimeFormat_SecondsShort", false)
	local v21

	if p < 0 then
		p = -p
		v21 = "-"
	else
		v21 = ""
	end

	local v22, v23, v24, v25 = fn7(p)
	local v26

	if math.abs(v22) > 0 then
		v26 = v22 .. v17

		if p2 ~= false then
			v26 ..= " " .. v23 .. v18
		end
	elseif math.abs(v23) > 0 then
		v26 = v23 .. v18

		if p3 and math.abs(v24) > 0 then
			v26 ..= " " .. math.min(v24 + 1, 59) .. v19
		end
	elseif math.abs(v24) > 0 then
		v26 = math.min(v24 + module.Ternary(v25 <= 0.99, 0, 1), 59) .. v19
	else
		v26 = math.ceil(p) .. v20
	end

	return v21 .. v26
end

local function fn9(p)
	local v17 = Localize("/Lotus/Language/Menu/TimeFormat_DaysShort", false)
	local v18 = Localize("/Lotus/Language/Menu/TimeFormat_HoursShort", false)
	local v19 = Localize("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
	local v20 = Localize("/Lotus/Language/Menu/TimeFormat_SecondsShort", false)
	local v21

	if p < 0 then
		p = -p
		v21 = "-"
	else
		v21 = ""
	end

	local v22, v23, v24, v25 = fn7(p)
	local v26 = ""

	if math.abs(v22) > 0 then
		v26 = v22 .. v17
	elseif math.abs(v23) > 0 then
		v26 = v23 .. v18 .. " " .. v24 .. v19 .. " " .. math.floor(v25 + 0.5) .. v20
	elseif math.abs(v24) >= 0 then
		v26 = v24 .. v19 .. " " .. math.floor(v25 + 0.5) .. v20
	end

	return v21 .. v26
end

function GetStoreTime(p)
	return fn9(p)
end

local function fn10(p, _)
	local v17 = Localize("/Lotus/Language/Menu/TimeFormat_DaysShort", false)
	local v18 = Localize("/Lotus/Language/Menu/TimeFormat_HoursShort", false)
	local v19 = Localize("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
	local v20 = Localize("/Lotus/Language/Menu/TimeFormat_SecondsShort", false)
	local v21

	if p < 0 then
		p = -p
		v21 = "-"
	else
		v21 = ""
	end

	local v22, v23, v24, v25 = fn7(p)
	local v26 = not (math.abs(v22) > 0) and "" or v22 .. v17 .. " "

	if math.abs(v23) > 0 then
		v26 ..= v23 .. v18 .. " "
	end

	if math.abs(v24) >= 0 then
		v26 ..= v24 .. v19 .. " "
	end

	local v27 = v26 .. math.floor(v25 + 0.5) .. v20
	return v21 .. (v22 < 0 and "-1" or v27)
end

function GetFullTime(p)
	return fn10(p)
end

function GetPlayerAvatar(object, p, _)
	if not object:__wf_atom_69303ffc(p) then
		p = object:__wf_atom_50a7d83e()
	end

	return p
end

local function fn11()
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gClient) then
		return nil
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return nil
	end

	local __wf_atom_eff0517e = __wf_atom_eab484a7:__wf_atom_eff0517e()

	if __wf_atom_7e8ad928(__wf_atom_eff0517e) then
		__wf_atom_eff0517e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	end

	return __wf_atom_eff0517e
end

function GetMainMenuSuitAvatar()
	return fn11()
end

local function fn12()
	local v17 = fn11()

	if __wf_atom_7e8ad928(v17) then
		return nil
	end

	return (v17:__wf_atom_d2b2176d():__wf_atom_1915cc84())
end

function GetMainMenuSentinelAvatar()
	return fn12()
end

local function fn13(_, object, data, _, p, p2, p3)
	local v17 = __wf_atom_7e8ad928(p) and {} or p
	local v18 = __wf_atom_7e8ad928(v17.endLineTag) and "" or v17.endLineTag
	local v19 = __wf_atom_7e8ad928(v17.includeParagraphTag) and true or v17.includeParagraphTag
	local v20 = p2 == nil and "#FloatingContentHighlight" or p2
	local v21 = p3 == nil and "#FloatingContent" or p3

	if data ~= nil then
		v20 = v11[data.rarity + 1]
	end

	local v22 = ""

	if v19 then
		v22 ..= "<p>"
	end

	local v23 = v22 .. "<font color=\"" .. v20 .. "\">"

	if data == nil then
		if not __wf_atom_7e8ad928(object) then
			local v24 = Localize(tostring(object:__wf_atom_014a76a2()), false)

			if v17.Upper then
				v24 = string.upper(v24)
			end

			v23 ..= v24
		end
	else
		v23 ..= data.localizedTitle
	end

	local v24 = (v23 .. "<br></font>") .. "<font color=\"" .. v21 .. "\">"

	if data == nil then
		if not __wf_atom_7e8ad928(object) then
			v24 ..= Localize(tostring(object:__wf_atom_3a3d2e39()), false)
		end
	else
		v24 ..= data.localizedDescription
		local affixes = data.affixes

		if affixes ~= nil then
			for i = 1, #affixes do
				v24 = ((((v24 .. "<br>") .. "<font color=\"#FFFFFF\">") .. affixes[i]) .. "</font>") .. v18
			end
		end
	end

	local v25 = v24 .. "</font>"

	if v19 then
		return v25 .. "</p>"
	end

	return v25
end

function GetItemToolTipText(p, p2, p3, p4, p5, p6, p7)
	return fn13(p, p2, p3, p4, p5, p6, p7)
end

function GetItemRarityColor(p)
	return p == nil and 16777215 or v12[p.rarity + 1]
end

function OpenColorPicker(object, p, colorPickerCallback, colorPickerOnCloseCallback, colorPickerSpecificColorsInfo)
	_T.ColorPickerCurrentColor = p and string.format("0x%08X", p) or nil
	_T.ColorPickerCallback = colorPickerCallback
	_T.ColorPickerOnCloseCallback = colorPickerOnCloseCallback
	_T.ColorPickerSpecificColorsInfo = colorPickerSpecificColorsInfo

	if _T.InSimulacrum then
		_T.ColorPickerUseCustomBg = true
	end

	return (object:PushChildMovie(_G.UIMovie_ColorPicker))
end

function UpdateSuit(object, instance, p, p2)
	local specialSuitAvatar = nil

	if __wf_atom_7e8ad928(instance) then
		instance = fn11()
	end

	if _T.mSpecialSuitMode then
		specialSuitAvatar = _T.SpecialSuitAvatar
	elseif _T.mSentinelMode then
		if not __wf_atom_7e8ad928(instance) then
			if instance:IsA(__wf_atom_ee1ed4db) then
				specialSuitAvatar = instance
			else
				specialSuitAvatar = instance:__wf_atom_d2b2176d():__wf_atom_1915cc84()

				if __wf_atom_7e8ad928(specialSuitAvatar) and gGameRules:IsA(__wf_atom_311a7128) then
					specialSuitAvatar = gGameRules:__wf_atom_45d2bdd8(3)
				end
			end
		end
	else
		specialSuitAvatar = instance
	end

	if __wf_atom_7e8ad928(specialSuitAvatar) then
		return
	end

	if _T.suitTable == nil then
		_T.suitTable = {}
		_T.suitTable.desiredRot = -90
		_T.suitTable.lerpRot = _T.suitTable.desiredRot
		_T.suitTable.lerpHead = Rotation()
	end

	if __wf_atom_7e8ad928(_T.suitTable.lerpRot) then
		_T.suitTable.lerpRot = 0
	end

	if __wf_atom_7e8ad928(_T.suitTable.desiredRot) then
		_T.suitTable.desiredRot = -90
	end

	if __wf_atom_7e8ad928(_T.suitTable.lerpHead) then
		_T.suitTable.lerpHead = Rotation()
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(specialSuitAvatar) or not object:IsVisible() then
		return
	end

	local lastMX = object:__wf_atom_5e6e15c8("_root", 30)
	local lastMY = object:__wf_atom_5e6e15c8("_root", 31)
	local isPlayingWithController = Engine.IsPlayingWithController()

	if lastMX == -1000 and lastMY == -1000 then
		lastMX = _T.suitTable.lastMX
		lastMY = _T.suitTable.lastMY

		if lastMX == nil or lastMY == nil then
			lastMX = 0
			lastMY = 0
		end

		_T.suitTable.mouseOffScreen = true
	elseif _T.suitTable.mouseOffScreen then
		if not isPlayingWithController then
			_T.suitTable.lastMX = lastMX
			_T.suitTable.lastMY = lastMY
		end

		_T.suitTable.mouseOffScreen = false
	end

	local __wf_atom_76657dba = object:__wf_atom_76657dba("_root", "suitRotationX")

	if
		(isPlayingWithController or p2)
		and p
		and not __wf_atom_7e8ad928(__wf_atom_76657dba)
		and tonumber(__wf_atom_76657dba) ~= nil
	then
		total += tonumber(__wf_atom_76657dba) * 1000 * __wf_atom_084b3e93()
		lastMX = total
	end

	if _T.suitTable.wasUsingController ~= isPlayingWithController then
		_T.suitTable.wasUsingController = isPlayingWithController
		_T.suitTable.lastMX = lastMX
		_T.suitTable.lastMY = lastMY
	end

	if module.Ternary(p2, "", object:GetFocus()) == "" and p then
		if _T.suitTable.lastMX ~= nil then
			_T.suitTable.desiredRot = _T.suitTable.desiredRot + (_T.suitTable.lastMX - lastMX) * 0.5
		end

		if _T.suitTable.lastMY ~= nil then
			_T.suitTable.myDiff = _T.suitTable.lastMY - lastMY
		end
	end

	_T.suitTable.lerpRot = __wf_atom_104bfe98(_T.suitTable.lerpRot, _T.suitTable.desiredRot, __wf_atom_084b3e93() * 4)
	local v17

	if _T.suitTable.lerpRot <= _T.suitTable.desiredRot then
		v17 = 360 - math.abs(_T.suitTable.lerpRot % 360)
	else
		v17 = math.abs(_T.suitTable.lerpRot % 360)
	end

	if math.abs(_T.suitTable.desiredRot - _T.suitTable.lerpRot) < v17 then
		_T.suitTable.lerpRot = _T.suitTable.lerpRot % 360
		_T.suitTable.desiredRot = _T.suitTable.desiredRot % 360
	end

	local lerpRot = _T.suitTable.lerpRot

	if _T.mSentinelMode and _T.SENTINEL_DEFAULT_ROTATION ~= nil then
		lerpRot = (lerpRot + _T.SENTINEL_DEFAULT_ROTATION) % 360
	end

	local v18 = lerpRot % 360

	if v18 <= -180 then
		v18 += 360
	elseif v18 >= 180 then
		v18 -= 360
	end

	specialSuitAvatar:__wf_atom_51075230(Rotation(v18, 0, 0))
	local position = specialSuitAvatar:GetPosition()
	local __wf_atom_18aa6e58 = specialSuitAvatar:__wf_atom_18aa6e58()
	local v19 = _T.suitTable.positions and _T.suitTable.positions[__wf_atom_18aa6e58]

	if __wf_atom_7e8ad928(v19) then
		if _T.suitTable.desiredPos ~= nil and not specialSuitAvatar:IsA(__wf_atom_f1872364) then
			position = __wf_atom_f55d6358(position, _T.suitTable.desiredPos, __wf_atom_084b3e93() * 4)
		end
	else
		position = v19
	end

	if _T.suitTable.queuedTeleport == nil then
		local v20 = __wf_atom_7e8ad928(_T.suitTable.lerpRotZ) and 0 or _T.suitTable.lerpRotZ
		local v21 = __wf_atom_7e8ad928(_T.suitTable.lerpRotY) and 0 or _T.suitTable.lerpRotY
		specialSuitAvatar:Teleport(position, Rotation(v18, v21, v20))
		local v22

		if not __wf_atom_7e8ad928(gRegion) then
			v22 = gRegion:__wf_atom_c4f78a8f()
		end

		if
			not __wf_atom_7e8ad928(v22)
			and not v22:IsA(__wf_atom_c0fefb76)
			and (specialSuitAvatar == _T.MenuSuitAvatar or specialSuitAvatar == _T.KDriveAvatar)
			and v22 ~= specialSuitAvatar
		then
			v22:Teleport(position, Rotation(v18, 0, 0))

			if not __wf_atom_7e8ad928(_T.MenuSuitAvatar) and specialSuitAvatar == _T.KDriveAvatar then
				_T.MenuSuitAvatar:Teleport(position, Rotation(v18, 0, 0))
			end
		end
	else
		_T.suitTable.queuedTeleport = _T.suitTable.queuedTeleport - __wf_atom_fa1258d0()

		if _T.suitTable.queuedTeleport <= 0 then
			_T.suitTable.queuedTeleport = nil
		end
	end

	local v20 = Vector(lastMX, lastMY, -200)
	local __wf_atom_74b9a49b = object:__wf_atom_74b9a49b((specialSuitAvatar:EyePosition()))
	__wf_atom_74b9a49b.z = 0
	local v21 = __wf_atom_fa8d0177(__wf_atom_74b9a49b, v20)
	local v22 = __wf_atom_e97f3142(v21)

	if v22.z > 0 then
		v22.z = -v22.z
	end

	local v23 = __wf_atom_9341614d(v22, Rotation(90 - v18, 0, 0))
	local v24 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v23)
	v24.bank = 0
	v24.pitch = -v24.pitch
	v24.heading = __wf_atom_421b01aa(v24.heading, -70, 70)
	v24.pitch = __wf_atom_421b01aa(v24.pitch, -30, 20)
	_T.suitTable.lerpHead.heading = __wf_atom_104bfe98(
		_T.suitTable.lerpHead.heading,
		v24.heading,
		__wf_atom_084b3e93() * 8
	)
	_T.suitTable.lerpHead.pitch = __wf_atom_104bfe98(_T.suitTable.lerpHead.pitch, v24.pitch, __wf_atom_084b3e93() * 8)
	local __wf_atom_2a979d69 = Engine.__wf_atom_2a979d69()

	if isPlayingWithController or not __wf_atom_2a979d69 then
		_T.suitTable.lastMX = lastMX
		_T.suitTable.lastMY = lastMY
	elseif __wf_atom_2a979d69 then
		if p then
			_T.suitTable.lastMX = lastMX
			_T.suitTable.lastMY = lastMY
		else
			_T.suitTable.lastMX = nil
			_T.suitTable.lastMY = nil
		end
	end

	if isPlayingWithController then
		_T.suitTable.lastMX = total
	end
end

function UpdateMiniGameHeadTracking(p, state)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	state.heading = __wf_atom_104bfe98(state.heading, p.heading, __wf_atom_084b3e93() * 8)
	state.pitch = __wf_atom_104bfe98(state.pitch, p.pitch, __wf_atom_084b3e93() * 8)
	__wf_atom_c4f78a8f:__wf_atom_2f0092a2(Symbol("GAME_C1_HEAD1"), state)
	return state
end

function OnAvatarImageSet() end

function InitializeProfileIconList()
	if __wf_atom_7e8ad928(_T.profileIconList) then
		_T.profileIconList = {}

		function _T.GetLocalLoadout()
			local gGameData = gGameData

			if __wf_atom_7e8ad928(gGameData) then
				return nil
			end

			return (gGameData:__wf_atom_a4299765())
		end

		function _T.SetProfileIcon(_, p)
			local localLoadout = _T:GetLocalLoadout()

			if __wf_atom_7e8ad928(localLoadout) then
				return
			end

			local gGameData = gGameData

			if not __wf_atom_7e8ad928(gGameData) then
				gGameData:__wf_atom_1860f6b3(p, "OnAvatarImageSet")
			end

			localLoadout:__wf_atom_1860f6b3(p)
			local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

			if not __wf_atom_7e8ad928(__wf_atom_15811761) and __wf_atom_15811761:__wf_atom_e6770097() then
				print("SetProfileIcon - SendLobbyLoadout")
				gGameRules:SendLobbyLoadout()
			end

			_T:UpdateProfileIconList()
		end

		function _T.UpdateProfileIconList()
			if __wf_atom_7e8ad928(_T.profileIconList) then
				return
			end

			local localLoadout = _T.GetLocalLoadout()
			local profileIconList = {}

			for i = 1, #_T.profileIconList do
				local v17 = _T.profileIconList[i]

				if __wf_atom_7e8ad928(v17.Movie) then
					continue
				end

				local v18

				if __wf_atom_7e8ad928(v17.HumanPlayer) or v17.HumanPlayer:IsLocal() then
					v18 = localLoadout
				else
					v18 = v17.HumanPlayer:__wf_atom_a4299765()
				end

				if __wf_atom_7e8ad928(v18) then
					continue
				end

				local uiTexture_ProfilePlaceHolder = v18:__wf_atom_a6382ae5()

				if
					__wf_atom_7e8ad928(uiTexture_ProfilePlaceHolder)
					or __wf_atom_7e8ad928(uiTexture_ProfilePlaceHolder.mItemType)
				then
					uiTexture_ProfilePlaceHolder = _G.UITexture_ProfilePlaceHolder
				else
					local v19 = Resource(uiTexture_ProfilePlaceHolder.mItemType)

					if not __wf_atom_7e8ad928(v19) then
						uiTexture_ProfilePlaceHolder = v19:GetIconTexture()
					end
				end

				if not (__wf_atom_7e8ad928(uiTexture_ProfilePlaceHolder) or __wf_atom_7e8ad928(v17.Movie)) then
					v17.Movie:__wf_atom_c90af43a(v17.Clip, uiTexture_ProfilePlaceHolder)
				end

				profileIconList[#profileIconList + 1] = v17
			end

			_T.profileIconList = profileIconList
		end
	end
end

function UnregisterProfileIcon(p, p2)
	if __wf_atom_7e8ad928(_T.profileIconList) then
		return
	end

	for i = 1, #_T.profileIconList do
		if not (_T.profileIconList[i].Movie == p and _T.profileIconList[i].Clip == p2) then
			continue
		end

		table.remove(_T.profileIconList, i)
		break
	end
end

function RegisterProfileIcon(movie, clip, humanPlayer)
	if __wf_atom_7e8ad928(_T.profileIconList) then
		return
	end

	local count = #_T.profileIconList
	local v17 = { Movie = movie, Clip = clip, HumanPlayer = humanPlayer }
	local v18 = false

	for i = 1, count do
		if _T.profileIconList[i].Clip ~= v17.Clip then
			continue
		end

		_T.profileIconList[i] = v17
		v18 = true
		break
	end

	if not v18 then
		_T.profileIconList[count + 1] = v17
	end

	_T:UpdateProfileIconList()
end

local function fn14(p, mReason, p2, REPORT_PLAYER2, p3, p4)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if REPORT_PLAYER2 == REPORT_PLAYER then
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if __wf_atom_7190444e ~= nil then
			__wf_atom_7190444e:__wf_atom_414f1cde(p, mReason, p2, p3)
		end
	elseif REPORT_PLAYER2 == REPORT_CLAN_AD then
		gGameData:__wf_atom_03859ec9(p4, mReason, p2, p3)
	end
end

local function fn15(object, callback)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(_G.UIMovie_GenericSettings) then
		return
	end

	local v17 = object:PushChildMovie(_G.UIMovie_GenericSettings)

	if __wf_atom_7e8ad928(v17) then
		return
	end

	v17:Execute("SetTitle", "/Lotus/Language/Menu/ReportPlayer_DetailsTitle")
	v17:Execute("SetConfirmButtonActive", "true")

	function _T.ReportReason_Done(list, p)
		_T.ReportReason_Done = nil
		_T.ReportReason_GetSettings = nil

		if __wf_atom_7e8ad928(p) then
			local mContent = list[1].mContent
			local v18 = string.gsub(mContent, "\r\n", " ")
			local v19 = string.gsub(v18, "\n", " ")
			object:Execute("ConfirmReport", (string.gsub(v19, "\r", " ")))
		elseif not __wf_atom_7e8ad928(callback) then
			callback(false)
		end
	end

	v17:Execute("SetCallBack", "ReportReason_Done")

	function _T.ReportReason_GetSettings()
		local v18 = {}
		table.insert(v18, {
			mLabel = "/Lotus/Language/CrashHandler/STRING_DETAILS",
			mType = INPUTBOX,
			mMaxChars = 140,
			mWidth = 500,
			mHeight = 210,
			mMultiLine = true
		})
		return v18
	end

	v17:Execute("SetElementsFunction", "ReportReason_GetSettings")
end

function ShowReportMenu(object, p, callback, list, REPORT_PLAYER2, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(_G.UIMovie_GenericMenu) then
		return nil
	end

	if REPORT_PLAYER2 == nil then
		REPORT_PLAYER2 = REPORT_PLAYER
	end

	local mReason = ""
	local v17 = ""
	local v18 = fn5(object, 1)

	function v18.ConfirmReport(list2)
		if #list2 > 0 then
			v17 = list2
		end

		if #list > 0 then
			if #v17 > 0 then
				v17 = list .. ": " .. v17
			else
				v17 = list
			end
		end

		local v19 = module.ShowYesOrNoMessage("/Lotus/Language/Menu/ReportPlayer_ConfirmText", "OnConfirmReport")

		if not __wf_atom_7e8ad928(v19) then
			v19:Execute("SetSendCallbackOnShutdown", "true")
		end
	end

	function v18.OnConfirmReport(p3)
		if tonumber(p3) == 4 then
			fn14(p, mReason, v17, REPORT_PLAYER2, "OnReported", p2)
		elseif not __wf_atom_7e8ad928(callback) then
			callback(nil)
		end
	end

	function v18.OnReported(p3, _)
		local v19 = nil

		if p3 then
			module.ShowMessage("/Lotus/Language/Menu/ReportPlayerSuccess")
			v19 = mReason
		else
			module.ShowErrorMessage("/Lotus/Language/Menu/ReportPlayerFailed")
		end

		if not __wf_atom_7e8ad928(callback) then
			callback(v19)
		end

		v18.ConfirmReport = nil
		v18.OnConfirmReport = nil
		v18.OnReported = nil
	end

	local v19 = object:PushChildMovie(_G.UIMovie_GenericMenu)
	v19:Execute(
		"SetTitle",
		object:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_ReportPlayer", false) .. " " .. p
	)

	function _T.ReportSelectionDone(list2)
		_T.ReportSelectionDone = nil
		_T.GetReportOptions = nil

		if list2[1] == nil then
			if not __wf_atom_7e8ad928(callback) then
				callback(false)
			end
		else
			mReason = list2[1].mReason
			fn15(object, callback)
		end
	end

	v19:Execute("SetCallBack", "ReportSelectionDone")

	function _T.GetReportOptions()
		local v20 = {}
		table.insert(v20, { mName = "/Lotus/Language/Menu/ReportPlayer_Spam", mReason = "Spam" })
		table.insert(v20, {
			mName = "/Lotus/Language/Menu/ReportPlayer_OffensiveLanguage",
			mReason = "OffensiveLangauge"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/Menu/ReportPlayer_OffensiveName",
			mReason = "OffensiveName"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/Menu/ReportPlayer_Harassment",
			mReason = "Harassment"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/Menu/ReportPlayer_RealLifeThreat",
			mReason = "RealLifeThreat"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/CustomerSupport/ReportPlayer_Cheating",
			mReason = "Cheating"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/CustomerSupport/ReportPlayer_RealMoneyTrade",
			mReason = "RealMoneyTrade"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/CustomerSupport/ReportPlayer_Griefing",
			mReason = "Griefing"
		})
		table.insert(v20, {
			mName = "/Lotus/Language/CustomerSupport/ReportPlayer_HateSpeech",
			mReason = "HateSpeech"
		})
		return v20
	end

	v19:Execute("SetElementsFunction", "GetReportOptions")
	return v19
end

function ToRad(p)
	return (module.ToRad(p))
end

function TransformPixelToViewportCoordinates(p, p2, p3)
	return (module.TransformPixelToViewportCoordinates(p, p2, p3))
end

function GetRootBasedPosition(p, p2, p3)
	return module.GetRootBasedPosition(p, p2, p3)
end

function CreateScreenParticles(p, p2, p3, p4, p5, p6, p7)
	return module.CreateScreenParticles(p, p2, p3, p4, p5, p6, p7)
end

function SetupAbilityUIBySuitType(object, p, object2, _)
	local result = {}

	for i = 1, 4 do
		local v17

		if not __wf_atom_7e8ad928(object2) then
			v17 = object2:__wf_atom_84c080b8(i - 1)
		end

		if __wf_atom_7e8ad928(v17) then
			object:__wf_atom_7d7314f1(p .. ".Ability" .. i .. ".Name.text", "")
			object:__wf_atom_c90af43a(p .. ".Ability" .. i .. ".Icon", nil)
			object:__wf_atom_2dedec1a(p .. ".Ability" .. i .. ".Icon", 13, false)
		else
			local v18 = Resource(v17)
			result[i] = v18
			local __wf_atom_014a76a2 = v18:__wf_atom_014a76a2()
			object:__wf_atom_7d7314f1(p .. ".Ability" .. i .. ".Name.text", __wf_atom_014a76a2:c_str())
			local iconTexture = v18:GetIconTexture()

			if not __wf_atom_7e8ad928(iconTexture) then
				object:__wf_atom_c90af43a(p .. ".Ability" .. i .. ".Icon", iconTexture)
			end

			object:__wf_atom_2dedec1a(p .. ".Ability" .. i .. ".Icon", 13, not __wf_atom_7e8ad928(iconTexture))
		end
	end

	return result
end

function SetupAbilityUIBySuitInstance(object, p, object2, _)
	local result = {}

	for i = 1, 4 do
		local v17

		if not __wf_atom_7e8ad928(object2) then
			v17 = object2:__wf_atom_c497b0ae(i - 1)
		end

		if __wf_atom_7e8ad928(v17) then
			object:__wf_atom_7d7314f1(p .. ".Ability" .. i .. ".Name.text", "/Lotus/Language/Menu/Empty_Precept")
			object:__wf_atom_c90af43a(p .. ".Ability" .. i .. ".Icon", nil)
			object:__wf_atom_2dedec1a(p .. ".Ability" .. i .. ".Icon", 13, false)
		else
			result[i] = v17
			local __wf_atom_014a76a2 = v17:__wf_atom_014a76a2()
			object:__wf_atom_7d7314f1(p .. ".Ability" .. i .. ".Name.text", __wf_atom_014a76a2:c_str())
			local iconTexture = v17:GetIconTexture()

			if not __wf_atom_7e8ad928(iconTexture) then
				object:__wf_atom_c90af43a(p .. ".Ability" .. i .. ".Icon", iconTexture)
			end

			object:__wf_atom_2dedec1a(p .. ".Ability" .. i .. ".Icon", 13, not __wf_atom_7e8ad928(iconTexture))
		end
	end

	return result
end

function InitializeContextMenu(mMovie)
	_T.ContextMenu = {
		mIndex = 0,
		mMovie = nil,
		mIsShowing = false,
		mListItems = {},
		Add = function(state, label, pressedCallback)
			state.mIndex += 1
			state.mMovie:__wf_atom_2dedec1a("ContextMenu.Btn" .. state.mIndex, 67, true)
			state.mMovie:__wf_atom_2dedec1a("ContextMenu.Btn" .. state.mIndex, 13, true)
			state.mMovie:__wf_atom_976dcedd("ContextMenu.Btn" .. state.mIndex, "Id", state.mIndex)
			state.mMovie:__wf_atom_7d7314f1("ContextMenu.Btn" .. state.mIndex .. ".Label.text", label)
			state.mListItems[state.mIndex] = { Label = label, PressedCallback = pressedCallback }
		end,
		Clear = function(self)
			self.mIndex = 0
			self:Show()
		end,
		IsShowing = function(self)
			return self.mIsShowing
		end,
		Hide = function(self)
			if not self:IsShowing() then
				return
			end

			self.mIsShowing = false
			self.mMovie:__wf_atom_2dedec1a("ContextMenu", 67, false)
			self.mMovie:__wf_atom_2dedec1a("ContextMenu", 13, false)
		end,
		Show = function(self)
			self.mIsShowing = true

			if self.mIndex > 0 then
				self.mMovie:__wf_atom_2dedec1a("ContextMenu", 67, true)
				self.mMovie:__wf_atom_2dedec1a("ContextMenu", 13, true)
				local v17 = self.mMovie:__wf_atom_5e6e15c8("_root", 30) + 60
				local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8("_root", 31)
				self.mMovie:__wf_atom_e57658c2("ContextMenu", 0, v17)
				self.mMovie:__wf_atom_e57658c2("ContextMenu", 1, __wf_atom_5e6e15c8)
			else
				self:Hide()
			end

			for i = 1, 8 do
				local ternary = module.Ternary(i <= self.mIndex, true, false)
				self.mMovie:__wf_atom_2dedec1a("ContextMenu.Btn" .. i, 67, ternary)
				self.mMovie:__wf_atom_2dedec1a("ContextMenu.Btn" .. i, 13, ternary)
			end
		end
	}
	_T.ContextMenu.mMovie = mMovie
end

function GetPointsRemainingForItem(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mItemType) then
		return 0
	end

	return (__wf_atom_c67f9605:__wf_atom_b4a75eaa(p.mXP, p.mItemType))
end

local function fn16(object)
	local canPurchaseIfAlreadyOwned = __wf_atom_c67f9605:CanPurchaseIfAlreadyOwned(object)
	local v17 = false
	local v18 = false

	if not __wf_atom_7e8ad928(gGameRules) then
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
			local __wf_atom_9eeff5a1 = __wf_atom_964056fd:__wf_atom_9eeff5a1(object)

			if __wf_atom_9eeff5a1 == nil or not (__wf_atom_9eeff5a1.mSlot >= 14) then
				v17 = false
			else
				v17 = __wf_atom_9eeff5a1.mSlot <= 16
			end

			if __wf_atom_9eeff5a1 == nil then
				v18 = false
			else
				v18 = __wf_atom_9eeff5a1.mSlot == 17
			end
		end
	end

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_bc269564() or __wf_atom_7e8ad928(gGameData) then
		return canPurchaseIfAlreadyOwned or v17 or v18
	end

	local __wf_atom_380a0e2c = gGameData:GetInventory():__wf_atom_380a0e2c()
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if not __wf_atom_7e8ad928(object:GetItem()) then
		__wf_atom_5b41f63b = object:GetItem():__wf_atom_5b41f63b()
	end

	for i = 1, #__wf_atom_380a0e2c do
		if __wf_atom_380a0e2c[i] ~= __wf_atom_5b41f63b then
			continue
		end

		canPurchaseIfAlreadyOwned = false
		break
	end

	return canPurchaseIfAlreadyOwned or v17 or v18
end

function CanPurchaseIfAlreadyOwned(p)
	return fn16(p)
end

function GetSlotsForCategory(p)
	local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(p)

	if __wf_atom_8c8df26f < 6 then
		return (gGameData:GetInventory():__wf_atom_9ed9a33c(__wf_atom_8c8df26f))
	end
end

function HaveEnoughSlots(p, p2)
	local gGameData = gGameData
	local v17 = p2 == nil and 1 or p2
	local __wf_atom_8c8df26f = __wf_atom_c67f9605:__wf_atom_8c8df26f(p)
	return not (__wf_atom_8c8df26f < 6) or v17 <= gGameData:GetInventory():__wf_atom_9ed9a33c(__wf_atom_8c8df26f)
end

function IsXPLocked(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_d1a2145d = object:__wf_atom_d1a2145d()

	if not __wf_atom_7e8ad928(gGameData) then
		return gGameData:__wf_atom_a04e4a53() < __wf_atom_d1a2145d, __wf_atom_d1a2145d
	end

	print("IsXPLocked: gGameData was nil")
	return false
end

function CreateParticles(p, p2, p3, p4, p5)
	return module.CreateParticles(p, p2, p3, p4, p5)
end

local function fn17()
	local v17 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v17, "api%-dev") ~= nil
end

function IsDevServer()
	return fn17()
end

local function fn18()
	local v17 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v17, "api%-test") ~= nil
end

function IsTestServer()
	return fn18()
end

local function fn19()
	local v17 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v17, "/localhost/") ~= nil
end

function IsLocalServer()
	return fn19()
end

function IsRetailServer()
	return not (fn17() or fn18() or fn19())
end

local function fn20()
	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:IsA(__wf_atom_1316e0c2) or gGameRules:IsA(__wf_atom_abe10cec) or gGameRules:IsA(__wf_atom_e714d8ac) or gGameRules:IsA(__wf_atom_ed7f8200))
	then
		return false
	end

	return true
end

local function fn21()
	if __wf_atom_7e8ad928(gGameRules) then
		return __wf_atom_0a47125f
	end

	if gGameRules:IsA(__wf_atom_e714d8ac) or fn20() then
		return gGameRules:__wf_atom_aaa23ad1()
	end

	return gGameRules:GetStarChart()
end

local function fn22()
	local __wf_atom_161b95d4 = fn21():__wf_atom_161b95d4()
	local result = {}

	for i = 1, #__wf_atom_161b95d4 do
		local v17 = __wf_atom_161b95d4[i]
		local name = v17.name

		for j = 1, #v17.sectors do
			__wf_atom_83c14687(0)
			local sector = v17.sectors[j]

			if not (sector.nodeType == 0 or sector.nodeType == 4 or sector.nodeType == 8) then
				continue
			end

			local mission = sector.mission
			local randomizedItems = mission.missionReward.randomizedItems
			local enemyCacheOverride = mission.enemyCacheOverride
			table.insert(result, {
				name = sector.name:c_str(),
				locTag = sector.locTag:c_str(),
				regionLocTag = name,
				randomizedItems = randomizedItems,
				enemyCacheOverride = enemyCacheOverride
			})
		end
	end

	return result
end

function IsInGamePlay()
	return fn20()
end

local function fn23()
	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:IsA(__wf_atom_1316e0c2) or gGameRules:IsA(__wf_atom_abe10cec))
	then
		return false
	end

	return true
end

function IsInMissionOrDojo()
	return fn23()
end

local function fn24()
	if __wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_469b1d97) then
		return false
	end

	if gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:IsA(__wf_atom_abe10cec) then
		return true
	end

	return false
end

function IsInMission()
	return fn24()
end

function IsInNewWarAltCharacterMission()
	return false
end

function GetStarChart()
	return fn21()
end

function GetStarChartNodes()
	return fn22()
end

local function fn25()
	return not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_e714d8ac)
end

function IsInHub()
	return fn25()
end

local function fn26(p)
	return p == REGION_ID_DOJO
end

function RegionIsAKey(p)
	return fn26(p)
end

function ResourceDronesEnabledForRegion(p)
	return p ~= REGION_ID_VOID and p ~= REGION_ID_DOJO and p ~= REGION_ID_DARK_SECTOR and p ~= REGION_ID_DEEP_SPACE
end

local function fn27(value, p, p2)
	local v17 = p or fn21()

	if __wf_atom_7e8ad928(v17) or value == nil or value == "" then
		return nil, 0, 0
	end

	local gSelectedRegionId = 0
	local v18 = string.find(value, KEY_TAG)
	local KEY_FLAG2

	if v18 == nil then
		KEY_FLAG2 = 0
	else
		KEY_FLAG2 = KEY_FLAG

		if _T.gSelectedRegionId ~= nil and _T.gSelectedRegionId > 0 then
			gSelectedRegionId = _T.gSelectedRegionId
		end

		if not fn26(gSelectedRegionId) then
			local v19 = Resource((string.sub(value, 1, v18 - 1)))

			if not __wf_atom_7e8ad928(v19) then
				local v20 = tostring(v19:__wf_atom_211412ff())

				if v20 ~= "" then
					value = v20
				end
			end
		end
	end

	local v19 = string.find(value, ALERT_TAG)

	if v19 ~= nil then
		value = string.sub(value, 1, v19 - 1)
		KEY_FLAG2 = ALERT_FLAG
	end

	local v20 = string.find(value, NIGHTMARE_TAG)

	if v20 ~= nil then
		value = string.sub(value, 1, v20 - 1)
		KEY_FLAG2 = NIGHTMARE_FLAG
	end

	local v21 = string.find(value, EVENT_TAG)

	if v21 ~= nil then
		value = string.sub(value, 1, v21 - 1)
		KEY_FLAG2 = EVENT_FLAG
	end

	local v22 = string.find(value, PVP_TAG)

	if v22 ~= nil then
		value = string.sub(value, 1, v22 - 1)
		KEY_FLAG2 = PVP_FLAG
	end

	local v23 = string.find(value, INVASION_ATTACKER_TAG)

	if v23 ~= nil then
		value = string.sub(value, 1, v23 - 1)
		KEY_FLAG2 = INVASION_ATTACKER_FLAG
	end

	local v24 = string.find(value, INVASION_DEFENDER_TAG)

	if v24 ~= nil then
		value = string.sub(value, 1, v24 - 1)
		KEY_FLAG2 = INVASION_DEFENDER_FLAG
	end

	local v25 = string.find(value, SYNDICATE_MISSION_TAG)

	if v25 ~= nil then
		value = string.sub(value, 1, v25 - 1)
		KEY_FLAG2 = SYNDICATE_MISSION_FLAG
	end

	local v26 = string.find(value, SORTIE_MISSION_TAG)

	if v26 ~= nil then
		value = string.sub(value, 1, v26 - 1)
		KEY_FLAG2 = SORTIE_MISSION_FLAG
	end

	local v27 = string.find(value, LITE_SORTIE_MISSION_TAG)

	if v27 ~= nil then
		value = string.sub(value, 1, v27 - 1)
		KEY_FLAG2 = LITE_SORTIE_MISSION_FLAG
	end

	local v28 = string.find(value, HUB_TAG)

	if v28 ~= nil then
		value = string.sub(value, 1, v28 - 1)
		KEY_FLAG2 = HUB_FLAG
	end

	local v29 = string.find(value, ACTIVE_MISSION_TAG)

	if v29 ~= nil then
		value = string.sub(value, 1, v29 - 1)
		KEY_FLAG2 = ACTIVE_MISSION_FLAG
	end

	local v30 = string.find(value, KUVA_TOWER_MISSION_TAG)

	if v30 ~= nil then
		value = string.sub(value, 1, v30 - 1)
		KEY_FLAG2 = KUVA_TOWER_MISSION_FLAG
	end

	local v31 = string.find(value, NEMESIS_MISSION_TAG)

	if v31 ~= nil then
		value = string.sub(value, 1, v31 - 1)
		KEY_FLAG2 = NEMESIS_MISSION_FLAG
	end

	local v32 = string.find(value, ELITE_ALERT_TAG)

	if v32 ~= nil then
		value = string.sub(value, 1, v32 - 1)
		KEY_FLAG2 = ELITE_ALERT_FLAG
	end

	local v33 = string.find(string.lower(value), "junction")

	if v33 ~= nil then
		value = string.sub(value, 1, v33 - 1)
		KEY_FLAG2 = JUNCTION_FLAG
	end

	local v34 = string.find(value, HARD_DAILY_TAG)

	if v34 == nil then
		local v35 = string.find(value, HARD_MODE_TAG)

		if v35 ~= nil then
			value = string.sub(value, 1, v35 - 1)
			KEY_FLAG2 = HARD_MODE_FLAG
		end
	else
		value = string.sub(value, 1, v34 - 1)
		KEY_FLAG2 = HARD_DAILY_FLAG
	end

	local v35 = string.find(value, VOID_STORM_TAG)

	if v35 ~= nil then
		value = string.sub(value, 1, v35 - 1)
		KEY_FLAG2 = VOID_STORM_FLAG
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = v17:__wf_atom_d5226f21(Symbol(value))
	end

	return p2, KEY_FLAG2, gSelectedRegionId
end

function GetNodeInfo(p, p2, p3)
	return (fn27(p, p2, p3))
end

local function fn28(value, p, p2)
	local v17 = p or fn21()
	local v18, v19, v20 = fn27(value, v17, p2)
	local v21 = string.find(value, TAG_SEPERATOR)

	if v21 ~= nil then
		value = string.sub(value, 1, v21 - 1)
	end

	if not __wf_atom_7e8ad928(v18) then
		local v22 = v18.region + 1
		local v23 = module.Ternary(v20 > 0, v20, v22) * 1000

		if value ~= nil then
			local v24 = 0
			local v25 = 1

			for i = string.len(value), 1, -1 do
				local v26 = tonumber((string.sub(value, i, i)))

				if v26 == nil then
					break
				end

				v24 += v26 * v25
				v25 *= 10
			end

			if v24 == 0 and v19 == KEY_FLAG then
				v24 = v17:__wf_atom_9c2168df(value)
			end

			if v22 == 16 and (v24 == 10 or v24 == 11) and string.find(value, "ClanNode") then
				v24 += 80
			end

			return v23 + v24 + v19
		end
	end

	local gSelectedRegionId = _T.gSelectedRegionId
	return ((gSelectedRegionId == nil or gSelectedRegionId <= 0) and 1 or gSelectedRegionId) * 1000
end

function BuildGameModeIdForNode(p, p2, p3)
	return fn28(p, p2, p3)
end

function BuildGameModeIdForSimulacrum()
	return REGION_ID_SIMULACRUM
end

function IsSimulacrumGameModeId(p)
	return p == REGION_ID_SIMULACRUM
end

function BuildGameModeIdForPhotobooth()
	return REGION_ID_PHOTOBOOTH
end

function IsPhotoboothGameModeId(p)
	return p == REGION_ID_PHOTOBOOTH
end

function BuildGameModeIdForPVP(p)
	local v17 = tonumber(p)
	return REGION_ID_PVP * 1000 + v17
end

function BuildGameModeIdForClanDojo()
	return REGION_ID_CLAN_DOJO * 1000
end

function IsClanDojoGameModeId(p)
	return math.floor(p / 1000) == REGION_ID_CLAN_DOJO
end

function BuildGameModeIdForDojoDuel()
	return REGION_ID_DOJO_DUEL * 1000
end

function IsDojoDuelGameModeId(p)
	return math.floor(p / 1000) == REGION_ID_DOJO_DUEL
end

local function fn29(p)
	return math.floor(p / 100000) == math.floor(ALERT_FLAG / 100000)
end

function IsAlertGameModeId(p)
	return (fn29(p))
end

local function fn30(p)
	return math.floor(p / 100000) == math.floor(NIGHTMARE_FLAG / 100000)
end

function IsNightmareGameModeId(p)
	return (fn30(p))
end

local function fn31(p)
	return math.floor(p / 100000) == math.floor(EVENT_FLAG / 100000)
end

function IsEventGameModeId(p)
	return (fn31(p))
end

local function fn32(p)
	return math.floor(p / 100000) == math.floor(INVASION_ATTACKER_FLAG / 100000)
end

local function fn33(p)
	return math.floor(p / 100000) == math.floor(INVASION_DEFENDER_FLAG / 100000)
end

local function fn34(p)
	return math.floor(p / 100000) == math.floor(PVP_FLAG / 100000)
end

function IsPvpGameModeId(p)
	return (fn34(p))
end

local function fn35(p)
	return math.floor(p / 100000) == math.floor(SYNDICATE_MISSION_FLAG / 100000)
end

function IsSyndicateGameModeId(p)
	return (fn35(p))
end

local function fn36(p)
	return math.floor(p / 100000) == math.floor(SORTIE_MISSION_FLAG / 100000)
end

function IsSortieGameModeId(p)
	return fn36(p)
end

local function fn37(p)
	return math.floor(p / 100000) == math.floor(LITE_SORTIE_MISSION_FLAG / 100000)
end

local function fn38(p)
	return math.floor(p / 100000) == math.floor(HUB_FLAG / 100000)
end

function IsHubGameModeId(p)
	return (fn38(p))
end

local function fn39(p)
	return math.floor(p / 100000) == math.floor(ACTIVE_MISSION_FLAG / 100000)
end

local function fn40(p)
	return math.floor(p / 100000) == math.floor(KUVA_TOWER_MISSION_FLAG / 100000)
end

local function fn41(p)
	return math.floor(p / 100000) == math.floor(JUNCTION_FLAG / 100000)
end

function IsJunctionGameModeId(p)
	return (fn41(p))
end

local function fn42(p)
	return math.floor(p / 100) % 10 == 5
end

local function fn43(p)
	return math.floor(p / 100000) == math.floor(KEY_FLAG / 100000)
end

function IsKeyGameModeId(p)
	return (fn43(p))
end

local function fn44(p)
	return math.floor(p / 100000) == math.floor(HARD_MODE_FLAG / 100000)
end

function IsHardGameModeId(p)
	return (fn44(p))
end

function IsPlayingHardGameModeMission()
	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		return false
	end

	return gGameRules:__wf_atom_72fc675e().tier > 0
end

local function fn45(p)
	return math.floor(p / 100000) == math.floor(HARD_DAILY_FLAG / 100000)
end

function IsHardDailyGameModeId(p)
	return (fn45(p))
end

function IsScenarioGameModeId(p)
	if not _T.CachedScenarioGameModeIds then
		local v17 = fn21()
		_T.CachedScenarioGameModeIds = {
			fn28(tostring(SCENARIO_EVENT_HUB_TAG) .. HUB_TAG, v17),
			fn28(tostring(SCENARIO_EVENT_GROUND_TAG) .. KEY_TAG, v17),
			fn28(tostring(SCENARIO_EVENT_SPACE_TAG) .. KEY_TAG, v17)
		}
	end

	for _, cachedScenarioGameModeId in pairs(_T.CachedScenarioGameModeIds) do
		if p == cachedScenarioGameModeId then
			return true
		end
	end

	return false
end

local function fn46(p)
	return math.floor(p / 100000) == math.floor(VOID_STORM_FLAG / 100000)
end

function GetRegionFromGameModeId(p)
	return math.floor(p / 1000) % 100
end

function GetNodeFromGameModeId(p)
	return (tonumber((string.sub(tostring(p), -3))))
end

local function fn47(p)
	local v17 = math.floor(p / 1000) % 100
	local v18 = tonumber((string.sub(tostring(p), -3)))

	if fn34(p) then
		return "PvpNode" .. v18
	end

	if
		fn31(p)
		and (_G.CachedGoalInfo and _G.CachedGoalInfo["EventNode" .. v18] or _G.MergedGoalNodes and _G.MergedGoalNodes["EventNode" .. v18] or _T.LockedGoalList and _T.LockedGoalList["EventNode" .. v18])
	then
		return "EventNode" .. v18
	end

	if fn35(p) then
		return "SyndicateNode" .. v18
	end

	if fn36(p) then
		return "SortieNode" .. v18
	end

	if fn38(p) then
		local v19 = math.max(v17, 1)

		if v19 == 3 and p % 10 == 2 then
			return "TennoConHUB2"
		end

		if v19 == 3 and p % 10 == 3 then
			return "IronwakeHUB3"
		end

		if v19 == 3 and p % 10 == 4 then
			return (tostring(CETUS_NODE_TAG))
		end

		if v19 == 3 and p % 10 == 5 then
			return (tostring(SCENARIO_EVENT_HUB_TAG))
		end

		if v19 == 3 and p % 10 == 7 then
			return "DevStreamHUB7"
		end

		if v19 == 2 and p % 10 == 1 then
			return (tostring(FORTUNA_NODE_TAG))
		end

		local v20 = {
			[1] = "MercuryHUB",
			[2] = "VenusHUB",
			[3] = "EarthHUB",
			[4] = "TradeHUB1",
			[5] = "JupiterHUB",
			[6] = "SaturnHUB",
			[7] = "UranusHUB",
			[8] = "NeptuneHUB",
			[9] = "PlutoHUB",
			[10] = "CeresHUB",
			[11] = "ErisHUB",
			[12] = "SednaHUB",
			[13] = "EuropaHUB",
			[17] = "DeimosHub",
			[22] = "ZarimanHub"
		}

		if v20[v19] then
			return v20[v19]
		end

		print("Invalid hub gameModeId " .. p .. "! Defaulting to MercuryHUB")
		return v20[1]
	else
		if fn42(p) then
			return "CrewBattleNode" .. v18
		end

		if fn43(p) then
			local v19 = p % 1000
			return (fn21():__wf_atom_8be9ed2b(v19))
		end

		if v17 == 16 then
			if v18 >= 80 then
				return "ClanNode" .. v18 - 80
			end

			return "SettlementNode" .. v18
		elseif v18 > 0 then
			if v16[v17] and v16[v17][v18] == true then
				return "ClanNode" .. v18
			end

			return "SolNode" .. v18
		else
			return nil
		end
	end
end

function GetNodeNameFromGameModeId(p)
	return (fn47(p))
end

function GetNodeModifierTagFromGameModeId(p)
	if fn29(p) then
		return ALERT_TAG
	end

	if fn31(p) then
		return EVENT_TAG
	end

	if fn32(p) then
		return INVASION_ATTACKER_TAG
	end

	if fn33(p) then
		return INVASION_DEFENDER_TAG
	end

	if fn35(p) then
		return SYNDICATE_MISSION_TAG
	end

	if fn36(p) then
		return SORTIE_MISSION_TAG
	end

	if fn37(p) then
		return LITE_SORTIE_MISSION_TAG
	end

	if fn38(p) then
		return HUB_TAG
	end

	if fn39(p) then
		return ACTIVE_MISSION_TAG
	end

	if fn40(p) then
		return KUVA_TOWER_MISSION_TAG
	end

	if fn43(p) then
		return KEY_TAG
	end

	if fn30(p) then
		return NIGHTMARE_TAG
	end

	if fn45(p) then
		return HARD_DAILY_TAG
	end

	if fn44(p) then
		return HARD_MODE_TAG
	end

	if fn46(p) then
		return VOID_STORM_TAG
	end

	return ""
end

local function fn48(p)
	if not _T.CachedPvpNodes then
		_T.CachedPvpNodes = {}
	end

	return _T.CachedPvpNodes[p]
end

function CanMergeSquad(p)
	return (fn48(p))
end

function GetDisplayedNodeNameFromGameModeId(p)
	if fn35(p) or fn36(p) then
		local v17 = math.floor(p / 1000) % 100
		local v18 = tonumber((string.sub(tostring(p), -3)))
		return module.Ternary(v17 == 16, "SettlementNode", "SolNode") .. v18
	else
		return (fn47(p))
	end
end

function GetAlertExpiryforNode(value)
	local __wf_atom_92662866 = gGameData:__wf_atom_92662866()
	local v17 = string.find(value, ALERT_TAG)

	if v17 ~= nil then
		value = string.sub(value, 1, v17 - 1)
	end

	local mAlerts = __wf_atom_92662866.mAlerts

	for i = 1, #mAlerts do
		if mAlerts[i].mMissionInfo.location:c_str() == value then
			return mAlerts[i].mExpiry
		end
	end

	return nil
end

local function fn49(object, object2, p)
	if _T.CachedRegionStatus and _T.CachedRegionStatus[p] and _T.CachedRegionStatus[p].goal == true then
		return true
	end

	if __wf_atom_7e8ad928(object) then
		object = fn21()
	end

	if __wf_atom_7e8ad928(object2) then
		return false
	end

	local v17 = object:__wf_atom_161b95d4()[p]
	return not __wf_atom_7e8ad928(v17) and (v17:__wf_atom_cd4c573e() ~= 0 or object2:__wf_atom_72735915(p))
end

function IsRegionUnlocked(p, p2, p3)
	return fn49(p, p2, p3)
end

function IsChatTextActive()
	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if __wf_atom_7e8ad928(movie) then
		return false
	end

	return movie:Execute("IsMaximized", "")
end

function IsSessionExpired(object)
	if __wf_atom_7e8ad928(object) then
		return true
	end

	local settings = object:GetSettings()

	if not fn29(settings.gameModeId) then
		return false
	end

	local __wf_atom_2402a457 = settings:__wf_atom_2402a457()

	if __wf_atom_7e8ad928(__wf_atom_2402a457) or #__wf_atom_2402a457 <= 0 then
		return true
	end

	local sec = __wf_atom_2402a457[1]

	if string.len(sec) > 0 then
		local v17 = MongoDateTime()
		v17.sec = sec
		return Engine.__wf_atom_db2b0cee(v17) <= 0
	end

	return false
end

function CheckShowTutorial(p)
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local __wf_atom_51d50961 = gGameData:__wf_atom_51d50961()
	local v17 = Symbol(p)

	for i = 1, #__wf_atom_51d50961 do
		if __wf_atom_51d50961[i].node == v17 then
			return false
		end
	end

	gGameData:AdvanceTauntHistory(v17)
	__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
	return true
end

local function fn50(curTransmission, p)
	local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)

	if curTransmission == nil then
		curTransmission = _T.curTransmission
	end

	if not (__wf_atom_7e8ad928(curTransmission) or __wf_atom_7e8ad928(movie)) then
		if _T.curTransmission == curTransmission or p and _T.curTransmission:IsA(curTransmission) then
			movie:Execute("QueueClose", "")
		elseif not __wf_atom_7e8ad928(_T.QueuedTransmissions) then
			local v17 = 1

			while v17 <= #_T.QueuedTransmissions do
				if
					_T.QueuedTransmissions[v17].Transmission == curTransmission
					or p and _T.QueuedTransmissions[v17].Transmission:IsA(curTransmission)
				then
					table.remove(_T.QueuedTransmissions, v17)
					return
				else
					v17 += 1
				end
			end
		end
	end
end

function InterruptTransmission(p, p2)
	fn50(p, p2)
end

local function fn51(transmission, speakerData)
	if _T.QueuedTransmissions == nil then
		_T.QueuedTransmissions = {}
	end

	print("Queuing new transmission: " .. transmission:GetName())

	if SF.__wf_atom_ab12373e(transmission).mQueueDump then
		print("Dumping queued transmissions and interrupting current one")
		fn50()
		_T.QueuedTransmissions = {}
	end

	table.insert(_T.QueuedTransmissions, { Transmission = transmission, SpeakerData = speakerData })
end

function QueueTransmission(transmission, speakerData)
	fn51(transmission, speakerData)
end

local function fn52(transmission, speakerData)
	if __wf_atom_7e8ad928(transmission) then
		return
	end

	fn51(transmission, speakerData)

	if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie))) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(_G.UIMovie_TransmissionMovie)
	end
end

function CreateHudlessTransmission(transmission, speakerData)
	fn52(transmission, speakerData)
end

function IsTransmissionPlaying()
	if __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_TransmissionMovie) then
		return true
	end

	return false
end

function GetActualPlayerRank()
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return 0
	else
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		return (__wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3))
	end
end

local function fn53()
	if _T.HasCompletedVorsPrize then
		return true
	end

	if not __wf_atom_7e8ad928(gClient) then
		return false
	end

	_T.HasCompletedVorsPrize = true
	return true
end

function HasCompletedVorsPrize()
	return fn53()
end

local function fn54(p)
	if __wf_atom_7e8ad928(gClient) then
		return true
	end

	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			gGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		end
	end

	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return false
	end

	local __wf_atom_fe84572e = inventory:__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		if not __wf_atom_7e8ad928(__wf_atom_fe84572e[i]) and p == __wf_atom_fe84572e[i].mItemType then
			return __wf_atom_fe84572e[i].mCompleted
		end
	end

	return false
end

function HasCompletedQuest(p)
	return fn54(p)
end

function GetLocalizedQuestName(object)
	local v17 = string.gsub(tostring(object:__wf_atom_5b41f63b()), "/Lotus/Types/", "/Lotus/StoreItems/Types/")
	local v18 = Resource(v17)

	if __wf_atom_7e8ad928(v18) then
		return ""
	end

	return Localize(tostring(v18:__wf_atom_014a76a2()), nil)
end

function HasCompletedWITW()
	return false
end

function HasCompletedZariman()
	return false
end

local function fn55()
	return false
end

function HasCompletedNewWar()
	return fn55()
end

local function fn56()
	local postNewWar = false

	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) or gMatchingService:__wf_atom_1b24a1bb() then
		postNewWar = fn55()
	else
		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

		for i = 1, #__wf_atom_bb46d8b6 do
			if not __wf_atom_bb46d8b6[i].isHost then
				continue
			end

			postNewWar = cjson.decode(__wf_atom_bb46d8b6[i].loadout).PostNewWar
			break
		end
	end

	return postNewWar ~= nil and postNewWar ~= false
end

function HasSquadHostCompletedNewWar()
	return fn56()
end

local function fn57(_)
	return false
end

function CanOverridePostNewWar(p)
	return fn57(p)
end

local function fn58(p)
	if not p then
		return
	end

	local location = tostring(p.location)
	local v17 = POST_NEW_WAR_MISSIONS[location]

	if not v17 then
		return
	end

	if fn57(location) and fn56() then
		if not __wf_atom_7e8ad928(v17.levelOverride) then
			p.levelOverride = v17.levelOverride
		end

		if v17.goalTag then
			p.goalTag = v17.goalTag
		end

		if v17.extraEnemySpec then
			p.extraEnemySpec = Resource(v17.extraEnemySpec)
		end
	end
end

function ApplyPostNewWarMissionOverrides(p)
	fn58(p)
end

function SetLevelStreamingArgs(p, object)
	fn21():SetLevelStreamingArgs(p, object)

	if not p then
		return
	end

	local v17 = POST_NEW_WAR_MISSIONS[tostring(p)]

	if v17 and fn56() and v17.streamingOffset then
		object:__wf_atom_60471db9(v17.streamingOffset, Rotation())
	end
end

function ApplyPostNewWarHubLevelArgs(object, p)
	if p and POST_NEW_WAR_MISSIONS[p] and fn56() then
		object:__wf_atom_98718663("Alt")
	end
end

function IsDuviriNode(value)
	if not value then
		return false
	end

	local v17 = string.find(value, TAG_SEPERATOR)

	if v17 then
		value = string.sub(value, 1, v17 - 1)
	end

	for i = 1, #DUVIRI_MISSION_NODES do
		if DUVIRI_MISSION_NODES[i] == value then
			return true
		end
	end

	return string.find(value, "Duviri") ~= nil
end

function IsNonEndlessDuviriNode(p)
	if not (p and p ~= DUVIRI_ENDLESS_NODE) then
		return false
	end

	return IsDuviriNode(p)
end

function BuildMissionForLocation(p)
	local copy = fn21():BuildMissionForLocation(p):Copy()
	fn58(copy)
	return copy
end

local function fn59(p, p2)
	if POST_NEW_WAR_MISSIONS[tostring(p)] then
		return p2 + module.Ternary(fn55(), PLAINS_ELO_POST_NEW_WAR_OFFSET, 0)
	end

	return p2
end

function GetModifiedPlainsElo(p, p2)
	return fn59(p, p2)
end

function IsPlainsElo(p, p2)
	return p == p2 or p == p2 + PLAINS_ELO_POST_NEW_WAR_OFFSET
end

function CanAccessDeimosHub()
	return false
end

local function fn60()
	return false
end

function HasCompletedDeimosIntroQuest()
	return fn60()
end

local function fn61(item)
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local __wf_atom_92662866 = gGameData:__wf_atom_92662866()

	if _T.CachedFlashSales == nil then
		local mFlashSales = __wf_atom_92662866.mFlashSales
		_T.CachedFlashSales = {}

		for _, mFlashSale in ipairs(mFlashSales) do
			if not __wf_atom_7e8ad928(mFlashSale.mTypeName) then
				_T.CachedFlashSales[mFlashSale.mTypeName:__wf_atom_5b41f63b()] = mFlashSale
			end
		end
	end

	if _T.CachedFlashSales == nil then
		return nil
	end

	if not item:IsPackage() then
		item = item:GetItem()

		if __wf_atom_7e8ad928(item) then
			return nil
		end
	end

	local cachedFlashSale = _T.CachedFlashSales[item:__wf_atom_5b41f63b()]

	if __wf_atom_7e8ad928(cachedFlashSale) then
		return nil
	end

	local mFlashSales = __wf_atom_92662866.mFlashSales

	for _, mFlashSale in ipairs(mFlashSales) do
		if
			__wf_atom_7e8ad928(mFlashSale.mTypeName)
			or mFlashSale.mTypeName:__wf_atom_5b41f63b() ~= item:__wf_atom_5b41f63b()
		then
			continue
		end

		if not (Engine.__wf_atom_db2b0cee(mFlashSale.mStartDate) < 0 and Engine.__wf_atom_db2b0cee(mFlashSale.mEndDate) > 0) then
			continue
		end

		_T.CachedFlashSales[mFlashSale.mTypeName:__wf_atom_5b41f63b()] = mFlashSale
		cachedFlashSale = mFlashSale
		break
	end

	if
		Engine.__wf_atom_db2b0cee(cachedFlashSale.mStartDate) < 0
		and Engine.__wf_atom_db2b0cee(cachedFlashSale.mEndDate) > 0
		and cachedFlashSale.mShowInMarket
	then
		return cachedFlashSale
	end

	return nil
end

function GetSaleInfo(p)
	return (fn61(p))
end

local v17 = {
	[3] = true,
	[1] = true,
	[0] = true,
	[5] = true,
	[15] = true,
	[16] = true,
	[6] = true,
	[10] = true,
	[27] = true,
	[28] = true,
	[29] = true,
	[13] = true,
	[42] = true,
	[21] = true,
	[48] = true,
	[30] = true,
	[52] = true,
	[51] = true,
	[32] = true,
	[9] = nil,
	[11] = nil,
	[25] = nil,
	[26] = nil,
	[14] = nil,
	[2] = nil,
	[4] = nil,
	[8] = nil,
	[35] = nil,
	[19] = nil
}

local function fn62(object)
	return v17[object:__wf_atom_efa6f447()] ~= nil
end

function IsProratedPackageCategory(p)
	return (fn62(p))
end

local function fn63(p)
	return p
end

local function fn64(p, p2)
	return p < p2
end

local function fn65(p, p2)
	return p2 < p
end

local function fn66(list, p, p2, p3)
	local v18 = p2 or fn63
	local v19 = p3 and fn65 or fn64
	local count = #list
	local v20 = 1

	while v20 <= count do
		local v21 = math.floor((v20 + count) / 2)
		local v22 = v18(list[v21])

		if p == v22 then
			local v23 = v21 - 1
			local result = { v21, v21 }

			while p == v18(list[v23]) do
				local v24 = v23 - 1
				result[1] = v23
				v23 = v24
			end

			local v24 = v21 + 1

			while p == v18(list[v24]) do
				local v25 = v24 + 1
				result[2] = v24
				v24 = v25
			end

			return result
		elseif v19(p, v22) then
			count = v21 - 1
		else
			v20 = v21 + 1
		end
	end
end

function BinarySearch(p, p2, p3, p4)
	return fn66(p, p2, p3, p4)
end

local function fn67(p)
	if p then
		return p.type
	end

	return nil
end

local function fn68(object, mTypeName, object2, p)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_b30d5ab2 = object:__wf_atom_b30d5ab2(mTypeName)
	local v18

	if __wf_atom_b30d5ab2 == nil then
		v18 = false
	else
		v18 = #__wf_atom_b30d5ab2 > 0
	end

	if v18 then
		for i = 1, #__wf_atom_b30d5ab2 do
			if
				__wf_atom_b30d5ab2[i]:__wf_atom_12c87335()
				and __wf_atom_b30d5ab2[i] ~= object2
				and GetStoreItemPriceObject(__wf_atom_b30d5ab2[i], nil, p, false, nil, nil, false, object).UsePrice > 0
			then
				return true
			end
		end
	end

	return nil
end

local function fn69(mTypeName)
	if __wf_atom_7e8ad928(mTypeName) then
		return false
	end

	if _T.CachedGiftRewardMap == nil then
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			return false
		end

		local __wf_atom_af1369a3 = __wf_atom_964056fd:__wf_atom_af1369a3()
		_T.CachedGiftRewardMap = {}

		for i = 1, #__wf_atom_af1369a3 do
			local reward = __wf_atom_af1369a3[i].reward

			if __wf_atom_7e8ad928(reward) then
				continue
			end

			_T.CachedGiftRewardMap[reward:__wf_atom_5b41f63b()] = true

			if not reward:IsPackage() then
				continue
			end

			local __wf_atom_72915748 = reward:__wf_atom_72915748()

			for j = 1, #__wf_atom_72915748 do
				local mTypeName2 = __wf_atom_72915748[j].mTypeName

				if not __wf_atom_7e8ad928(mTypeName2) then
					_T.CachedGiftRewardMap[mTypeName2:__wf_atom_5b41f63b()] = true
				end
			end
		end
	end

	return _T.CachedGiftRewardMap ~= nil and _T.CachedGiftRewardMap[mTypeName:__wf_atom_5b41f63b()] ~= nil
end

local function fn70(instance, p, p2)
	if not (p2 or fn62(instance)) then
		return true
	end

	local __wf_atom_eca5585c = instance:__wf_atom_eca5585c()
	local v18 = false
	local v19

	if instance:IsA(__wf_atom_6317e6dc) then
		local v20 = string.gsub(__wf_atom_eca5585c, "Bronze", "")
		local v21 = string.gsub(v20, "Silver", "")
		local v22 = string.gsub(v21, "Gold", "")
		local v23 = string.gsub(v22, "Platinum", "")
		v19 = {
			v23 .. "Bronze",
			v23 .. "Silver",
			v23 .. "Gold",
			v23 .. "Platinum"
		}
	else
		v19 = { __wf_atom_eca5585c }
	end

	for i = 1, #v19 do
		v18 = v18 or fn66(p, v19[i], fn67)
	end

	return not v18
end

function ShouldGiveFromPackage(p, p2, p3)
	return fn70(p, p2, p3)
end

function ProratedBundlesEnabled()
	return true
end

function IsFoundersPack(object)
	return object:__wf_atom_ef0538a9() == v9
end

function IsFoundersPackOwned(p)
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	return gGameData:__wf_atom_a1deff4d(p) or gGameData:__wf_atom_651b839e() == 4
end

function GetStoreItemPriceObject(storeItem, rarity, p, p2, sale, data, p3, p4)
	local result = {
		ShowInMarket = false,
		Rarity = rarity,
		Sale = nil,
		Coupon = nil,
		ExternalProduct = nil,
		UsePremium = false,
		UsePrice = 0,
		UseOriginalPrice = 0,
		OriginalPrice = { Premium = 0, Credits = 0, External = 0 },
		ProratedPrice = { Premium = 0, Credits = 0, External = 0 },
		FinalPrice = { Premium = 0, Credits = 0, External = 0 },
		ProratedPercent = 0,
		FinalDiscountPercent = 0,
		DiscountPercent = 0,
		DiscountTags = {
			Coupon = nil,
			Sale = nil,
			PriceOverride = nil,
			Darvo = nil,
			Prorated = nil
		},
		ProratedItems = {}
	}

	if __wf_atom_7e8ad928(storeItem) or not storeItem:__wf_atom_12c87335() then
		return result
	end

	local v18 = (__wf_atom_7e8ad928(p2) and true or p2) and true

	if IsExternalProduct(storeItem) then
		result.ShowInMarket = true
		result.ExternalProduct = true
		local sale2 = fn61(storeItem)

		if sale2 ~= nil then
			result.Sale = sale2
		end

		if result.Sale ~= nil and result.Sale.mHideFromMarket then
			result.ShowInMarket = false
			return result
		end

		local v19 = GetProductId(storeItem)
		result.CatalogProductData = gGameData:__wf_atom_1d87f188(v19)

		if
			v19 == ""
			or result.CatalogProductData.productId ~= v19
			or result.CatalogProductData.listPrice.formatted == ""
		then
			result.ShowInMarket = false
			return result
		end

		result.ShowInMarket = result.CatalogProductData.listPrice.value > 0
			or (result.CatalogProductData.owned or Engine.__wf_atom_84bb79c2())
		result.OriginalPrice.External = result.CatalogProductData.basePrice.value
		result.FinalPrice.External = result.CatalogProductData.listPrice.value

		if result.CatalogProductData:__wf_atom_ef4b5bf6() then
			local v20 = 100 - 100 * (result.CatalogProductData.listPrice.value / result.CatalogProductData.basePrice.value)
			result.DiscountTags.Sale = true
			result.Sale = {
				mDiscount = v20,
				mEndDate = result.CatalogProductData.listPrice.endDate:Copy(),
				mStartDate = result.CatalogProductData.listPrice.startDate:Copy()
			}
			result.DiscountPercent = v20
			result.FinalDiscountPercent = v20
			return result
		else
			local v20 = { StoreItem = storeItem }
			fn2(v20)

			if
				v20.Coupon == nil
				or v20.Coupon.mAmount == nil
				or v20.Coupon.mAmount == 0
				or __wf_atom_7e8ad928(v20.Coupon.mExpiry)
				or not (Engine.__wf_atom_db2b0cee(v20.Coupon.mExpiry) > 0)
			then
				return result
			end

			result.Coupon = v20.Coupon
			result.DiscountTags.Coupon = true
			result.DiscountPercent = result.Coupon.mAmount * 100
			result.FinalDiscountPercent = result.DiscountPercent
			return result
		end
	else
		local v19

		if data == nil then
			v19 = false
		else
			v19 = data.RegularPrice ~= nil
				or data.RegularPriceOverride ~= nil
				or data.PremiumPrice ~= nil
				or data.PremiumPriceOverride ~= nil
		end

		local sale2 = fn61(storeItem)
		result.ShowInMarket = storeItem:ShowInMarket()

		if not __wf_atom_7e8ad928(sale2) then
			result.ShowInMarket = not sale2.mHideFromMarket
		end

		if v19 then
			if data.RegularPrice ~= nil then
				result.OriginalPrice.Credits = data.RegularPrice
			end

			if data.RegularPriceOverride ~= nil then
				result.OriginalPrice.Credits = data.RegularPriceOverride
			end

			if data.PremiumPrice ~= nil then
				result.OriginalPrice.Premium = data.PremiumPrice
			end

			if data.PremiumPriceOverride ~= nil then
				result.OriginalPrice.Premium = data.PremiumPriceOverride
			end
		elseif rarity == nil then
			for i = 0, 3 do
				local __wf_atom_ee4fa4fd = storeItem:__wf_atom_ee4fa4fd(i)
				local __wf_atom_8c904c63 = storeItem:__wf_atom_8c904c63(i)

				if not (__wf_atom_ee4fa4fd > 0 or __wf_atom_8c904c63 > 0 or result.OriginalPrice.Credits == nil) then
					continue
				end

				result.Rarity = i
				result.OriginalPrice.Credits = __wf_atom_ee4fa4fd
				result.OriginalPrice.Premium = __wf_atom_8c904c63
			end
		else
			result.OriginalPrice.Credits = storeItem:__wf_atom_ee4fa4fd(rarity)
			result.OriginalPrice.Premium = storeItem:__wf_atom_8c904c63(rarity)
		end

		if not (result.ShowInMarket or v19) then
			return result
		end

		if v18 and (result.OriginalPrice.Premium > 0 or result.OriginalPrice.Credits > 0) then
			if storeItem:IsPackage() then
				local __wf_atom_7a56f2d5 = storeItem:__wf_atom_7a56f2d5()
				local __wf_atom_f8f0c460 = storeItem:__wf_atom_f8f0c460()
				local __wf_atom_72915748 = storeItem:__wf_atom_72915748()
				local v20 = true
				local total2 = 0
				local v21 = 0

				for i = 1, #__wf_atom_72915748 do
					__wf_atom_83c14687()
					local mTypeName = __wf_atom_72915748[i].mTypeName

					if __wf_atom_7e8ad928(mTypeName) then
						print("Could not find subitem " .. tostring(i) .. " for " .. storeItem:__wf_atom_5b41f63b())
						return result
					end

					if not mTypeName:__wf_atom_12c87335() then
						return result
					end

					if __wf_atom_7e8ad928(p4) then
						local inventory = gGameData:GetInventory()
						local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

						if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
							p4 = SF.ProductUpsellHelper(__wf_atom_964056fd, inventory)
						end
					end

					v20 = v20 and mTypeName:__wf_atom_efa6f447() == 30
					local v22 = v18 and fn62(mTypeName) and __wf_atom_72915748[i].mPurchaseQuantity == 1

					if not v22 or (__wf_atom_7e8ad928(p) or fn70(mTypeName, p, v22)) then
						continue
					end

					local v23 = GetStoreItemPriceObject(
						mTypeName,
						__wf_atom_72915748[i].mDurability,
						p,
						false,
						nil,
						nil,
						false,
						p4
					)
					local v24 = fn68(p4, mTypeName, storeItem, p)
					local v25 = fn69(mTypeName)
					local v26 = not __wf_atom_7e8ad928(mTypeName:__wf_atom_ecd05e96())
					local credits, premium

					if v23.ShowInMarket or v24 or v25 or v26 then
						credits = v23.OriginalPrice.Credits
						premium = v23.OriginalPrice.Premium
					else
						credits = 0
						premium = 0
					end

					if not (credits > 0) then
						local _ = premium > 0
					end

					local flag

					if premium > 0 and __wf_atom_f8f0c460 > 0 then
						total2 += premium
						flag = true
					else
						flag = false
					end

					if flag then
						table.insert(result.ProratedItems, mTypeName)
					end
				end

				if v20 then
					result.ProratedItems = {}
					v21 = 0
					total2 = 0
				end

				if v21 > 0 and __wf_atom_7a56f2d5 > 0 then
					result.FinalPrice.Credits = result.OriginalPrice.Credits - math.ceil(v21 * result.OriginalPrice.Credits / __wf_atom_7a56f2d5)
					result.DiscountTags.Prorated = true
					result.ProratedPercent = (1 - result.FinalPrice.Credits / result.OriginalPrice.Credits) * 100
				else
					result.FinalPrice.Credits = result.OriginalPrice.Credits
				end

				if total2 > 0 and __wf_atom_f8f0c460 > 0 then
					result.FinalPrice.Premium = result.OriginalPrice.Premium - math.ceil(total2 * result.OriginalPrice.Premium / __wf_atom_f8f0c460)
					result.DiscountTags.Prorated = true
					result.ProratedPercent = (1 - result.FinalPrice.Premium / result.OriginalPrice.Premium) * 100
				else
					result.FinalPrice.Premium = result.OriginalPrice.Premium
				end

				if result.FinalPrice.Credits < 0 then
					result.FinalPrice.Credits = 0
				end

				if result.FinalPrice.Premium < 0 then
					result.FinalPrice.Premium = 0
				end

				result.ProratedPrice.Credits = result.FinalPrice.Credits
				result.ProratedPrice.Premium = result.FinalPrice.Premium
			elseif storeItem:__wf_atom_efa6f447() == 19 then
				local __wf_atom_987be644 = storeItem:__wf_atom_987be644()
				local __wf_atom_21e5b95f = gGameData:GetInventory():__wf_atom_21e5b95f(__wf_atom_987be644)
				local __wf_atom_17d97bf6 = storeItem:__wf_atom_17d97bf6()
				local MAX_BIN_SLOTS2 = __wf_atom_c67f9605:__wf_atom_dae75ebc(__wf_atom_987be644)

				if MAX_BIN_SLOTS2 == 0 then
					MAX_BIN_SLOTS2 = MAX_BIN_SLOTS
				end

				local v20 = math.min(MAX_BIN_SLOTS2 - __wf_atom_21e5b95f, __wf_atom_17d97bf6)

				if v20 > 0 then
					local v21 = (__wf_atom_17d97bf6 - v20) * result.OriginalPrice.Premium / __wf_atom_17d97bf6

					if v21 > 0 and result.OriginalPrice.Premium > 0 then
						result.FinalPrice.Premium = result.OriginalPrice.Premium - math.ceil(v21)
						result.DiscountTags.Prorated = true
						result.ProratedPercent = v21 / result.OriginalPrice.Premium * 100
					else
						result.FinalPrice.Premium = result.OriginalPrice.Premium
					end

					result.ProratedPrice.Credits = result.FinalPrice.Credits
					result.ProratedPrice.Premium = result.FinalPrice.Premium
				end
			else
				result.FinalPrice.Credits = result.OriginalPrice.Credits
				result.FinalPrice.Premium = result.OriginalPrice.Premium

				if data ~= nil and data.RegularPriceBeforeDiscount ~= nil then
					result.OriginalPrice.Credits = data.RegularPriceBeforeDiscount
				end
			end
		else
			result.FinalPrice.Credits = result.OriginalPrice.Credits
			result.FinalPrice.Premium = result.OriginalPrice.Premium

			if data ~= nil and data.RegularPriceBeforeDiscount ~= nil then
				result.OriginalPrice.Credits = data.RegularPriceBeforeDiscount
			end
		end

		if sale and sale.mForcePlatSale and Engine.__wf_atom_db2b0cee(sale.mEndDate) > 0 then
			result.Sale = sale
			result.FinalPrice.Premium = sale.mForcePlatSale
			result.DiscountTags.Sale = true
			result.DiscountTags.Darvo = true
			result.DiscountPercent = sale.mDiscount
		else
			local credits = result.FinalPrice.Credits
			local premium = result.FinalPrice.Premium
			local v20 = { StoreItem = storeItem }

			if result.ShowInMarket and (p3 == nil or p3) then
				fn2(v20)

				if
					v20.Coupon ~= nil
					and v20.Coupon.mAmount ~= nil
					and v20.Coupon.mAmount ~= 0
					and not __wf_atom_7e8ad928(v20.Coupon.mExpiry)
					and Engine.__wf_atom_db2b0cee(v20.Coupon.mExpiry) > 0
				then
					result.Coupon = v20.Coupon

					if credits ~= nil then
						credits = fn3(credits, v20.Coupon.mAmount)
					end

					if premium ~= nil then
						premium = fn3(premium, v20.Coupon.mAmount)
					end

					result.DiscountTags.Coupon = true
				end
			end

			local credits2 = result.FinalPrice.Credits
			local premium2 = result.FinalPrice.Premium
			local v21 = not __wf_atom_7e8ad928(sale2)
				and not __wf_atom_7e8ad928(sale2.mDiscount)
				and (sale2.mRegularOverride ~= result.OriginalPrice.Credits or sale2.mPremiumOverride ~= result.OriginalPrice.Premium)
			local v22 = v21 and (not result.DiscountTags.Coupon or v20.Coupon.mAmount < sale2.mDiscount / 100)
			local priceOverride = false

			if v21 then
				if sale2.mDiscount > 0 then
					if credits2 ~= nil then
						credits2 -= math.ceil(credits2 * math.round(sale2.mDiscount) / 100)
					end

					if premium2 ~= nil then
						premium2 -= math.ceil(premium2 * math.round(sale2.mDiscount) / 100)
					end
				else
					if
						storeItem:__wf_atom_327344dd()
						and (#sale2.mTieredPremiumOverrides > 0 or #sale2.mTieredRegularOverrides > 0)
					then
						if rarity == nil then
							local v23 = 0

							for i = 1, #sale2.mTieredRegularOverrides do
								if v23 < sale2.mTieredRegularOverrides[i] then
									v23 = sale2.mTieredRegularOverrides[i]
								end
							end

							if v23 > 0 then
								credits2 = v23
							end

							local v24 = 0

							for i = 1, #sale2.mTieredPremiumOverrides do
								if v24 < sale2.mTieredPremiumOverrides[i] then
									v24 = sale2.mTieredPremiumOverrides[i]
								end
							end

							if v24 > 0 then
								premium2 = v24
							end
						else
							if #sale2.mTieredRegularOverrides > 0 then
								credits2 = sale2.mTieredRegularOverrides[rarity + 1]
							end

							if #sale2.mTieredPremiumOverrides > 0 then
								premium2 = sale2.mTieredPremiumOverrides[rarity + 1]
							end
						end
					else
						credits2 = sale2.mRegularOverride
						premium2 = sale2.mPremiumOverride
					end

					priceOverride = credits2 ~= result.OriginalPrice.Credits or premium2 ~= result.OriginalPrice.Premium

					if priceOverride then
						result.OriginalPrice.Credits = credits2
						result.OriginalPrice.Premium = premium2
						result.FinalPrice.Credits = credits2
						result.FinalPrice.Premium = premium2
					end
				end
			end

			result.Sale = sale2

			if v21 and (v22 or priceOverride) then
				result.DiscountTags.Coupon = false
				result.DiscountTags.Sale = not priceOverride
				result.DiscountTags.PriceOverride = priceOverride
				result.DiscountTags.Prorated = result.DiscountTags.Prorated and not priceOverride

				if credits2 > 0 then
					result.DiscountPercent = math.floor(100 - credits2 * 100 / result.FinalPrice.Credits)
				end

				if premium2 > 0 then
					result.DiscountPercent = math.floor(100 - premium2 * 100 / result.FinalPrice.Premium)
				end

				result.FinalPrice.Credits = credits2
				result.FinalPrice.Premium = premium2
			elseif result.DiscountTags.Coupon then
				if credits > 0 then
					result.DiscountPercent = math.floor(100 - credits * 100 / result.FinalPrice.Credits)
				end

				if premium > 0 then
					result.DiscountPercent = math.floor(100 - premium * 100 / result.FinalPrice.Premium)
				end

				result.FinalPrice.Credits = credits
				result.FinalPrice.Premium = premium
			end
		end

		if v19 then
			result.ShowInMarket = true
		else
			result.ShowInMarket = storeItem:ShowInMarket()

			if not __wf_atom_7e8ad928(result.Sale) then
				result.ShowInMarket = not result.Sale.mHideFromMarket
			end

			if not result.ShowInMarket then
				result.FinalPrice.Credits = 0
				result.FinalPrice.Premium = 0
			end

			if result.DiscountTags.PriceOverride then
				result.DiscountPercent = 0
				result.FinalDiscountPercent = 0
			else
				if result.FinalPrice.Credits > 0 then
					result.FinalDiscountPercent = math.floor(100 - result.FinalPrice.Credits * 100 / result.OriginalPrice.Credits)
				end

				if result.FinalPrice.Premium > 0 then
					result.FinalDiscountPercent = math.floor(100 - result.FinalPrice.Premium * 100 / result.OriginalPrice.Premium)
				end
			end
		end

		result.UsePremium = result.OriginalPrice.Premium > 0

		if result.UsePremium then
			result.UsePrice = result.FinalPrice.Premium
			result.UseOriginalPrice = result.OriginalPrice.Premium
		else
			result.UsePrice = result.FinalPrice.Credits
			result.UseOriginalPrice = result.OriginalPrice.Credits
		end

		if result.UsePrice <= 0 and not result.DiscountTags.Prorated then
			result.ShowInMarket = false
		end

		return result
	end
end

local v18 = {
	"/Lotus/Language/Menu/AP_UNIVERSAL",
	"/Lotus/Language/Menu/AP_ATTACK",
	"/Lotus/Language/Menu/AP_DEFENSE",
	"/Lotus/Language/Menu/AP_TACTIC",
	"/Lotus/Language/Menu/AP_POWER",
	"/Lotus/Language/Menu/AP_PRECEPT",
	"/Lotus/Language/Menu/AP_FUSION",
	"/Lotus/Language/Menu/AP_WARD"
}

function GetPolarityName(p)
	return v18[p + 1]
end

function GetPVPEloRatingForRank(p)
	if p < 3 then
		return 0
	end

	return 2
end

local function fn71(name)
	return name == tostring(PLAINS_NODE_TAG)
		or name == tostring(ORB_VALLIS_NODE_TAG)
		or name == tostring(ENTRATI_LANDSCAPE_NODE_TAG)
end

local function fn72(name)
	local v19 = {
		ZARIMAN_MISSION_A_TAG,
		ZARIMAN_MISSION_B_TAG,
		ZARIMAN_MISSION_C_TAG,
		ZARIMAN_MISSION_D_TAG,
		ZARIMAN_MISSION_E_TAG
	}
	local v20 = Symbol(name)

	for _, v21 in pairs(v19) do
		if v20 == v21 then
			return true
		end
	end

	return false
end

local function fn73(p)
	if p then
		if SF.__wf_atom_b064ff74(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
			return 0
		end

		return 2
	else
		if _T.gPendingMission and gMatchingService:__wf_atom_607c7363() then
			local name = tostring(_T.gPendingMission.name)
			local v19 = string.find(name, TAG_SEPERATOR)

			if v19 then
				name = string.sub(name, 1, v19 - 1)
			end

			if fn71(name) then
				return fn59(name, PLAINS_ELO_IN_LISET)
			end

			if fn72(name) then
				return PLAINS_ELO_IN_LISET
			end
		end

		local v19 = { 0, 1, 3, 5 }
		local count = 0
		local total2 = 0
		local v20 = fn11()

		if __wf_atom_7e8ad928(v20) then
			return total2 / (count < 1 and 1 or count)
		end

		local __wf_atom_d2b2176d = v20:__wf_atom_d2b2176d()

		if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			return total2 / (count < 1 and 1 or count)
		end

		for i = 1, #v19 do
			local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(v19[i])

			if __wf_atom_7e8ad928(__wf_atom_28224c27) then
				continue
			end

			count += 1
			total2 += __wf_atom_28224c27:__wf_atom_22941262()
		end

		return total2 / (count < 1 and 1 or count)
	end
end

function GetPlayerEloRating(p)
	return (fn73(p))
end

local function fn74(instance)
	local v19 = nil
	local v20 = nil
	local v21 = nil
	local v22 = true

	if __wf_atom_7e8ad928(instance) then
		return v19, v20, v21, true
	end

	if
		instance:IsA(__wf_atom_8d0b7f88)
		and (instance:__wf_atom_4f3855f9():__wf_atom_8598f3a9() and instance:__wf_atom_a15ba1dd() or instance:__wf_atom_db682341() == v13)
	then
		return instance, v20, v21, false
	end

	if instance:IsA(__wf_atom_4e9f6070) or instance:IsA(__wf_atom_3be5e2e6) or instance:IsA(__wf_atom_3d6e3759) then
		return instance, v20, v21, v22
	end

	if instance:IsA(__wf_atom_4ebf67cb) then
		return v19, instance, v21, v22
	end

	local v23 = instance:IsA(__wf_atom_7b01f9ce) and instance:IsEnabled()
	local __wf_atom_83a62c41 = instance:__wf_atom_83a62c41()

	if v23 and __wf_atom_83a62c41:IsA(__wf_atom_4ebf67cb) then
		return v19, __wf_atom_83a62c41, v21, v22
	end

	if
		v23
		and (__wf_atom_83a62c41:IsA(__wf_atom_8d0b7f88) and __wf_atom_83a62c41:__wf_atom_4f3855f9():__wf_atom_8598f3a9() or __wf_atom_83a62c41:IsA(__wf_atom_4e9f6070) or __wf_atom_83a62c41:IsA(__wf_atom_3be5e2e6))
	then
		return __wf_atom_83a62c41, v20, instance, false
	end

	if v23 and __wf_atom_83a62c41:IsA(__wf_atom_3d6e3759) then
		return __wf_atom_83a62c41, v20, instance, v22
	end

	if instance:IsA(__wf_atom_3feeb44a) and instance:__wf_atom_93b324ab() then
		local __wf_atom_37a29496 = instance:__wf_atom_37a29496()

		if __wf_atom_7e8ad928(__wf_atom_37a29496) or not __wf_atom_37a29496:IsA(__wf_atom_3aaccc49) then
			return v19, v20, v21, v22
		end

		return instance, v20, v21, v22
	else
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			return v19, v20, v21, v22
		end

		return fn74(__wf_atom_3d96ddcd)
	end
end

function FilterStatusEntity(p)
	return fn74(p)
end

local function fn75(p, list, callback)
	if list ~= nil then
		for i = 1, #list do
			__wf_atom_83c14687(0)
			local v19 = list[i]
			local __wf_atom_5b41f63b = v19.mItemType:__wf_atom_5b41f63b()

			if not (__wf_atom_7e8ad928(callback) or callback(v19)) then
				continue
			end

			local v20 = p[__wf_atom_5b41f63b]

			if v20 == nil then
				local v21 = { Type = v19.mItemType, Count = v19.mItemCount, Item = v19 }

				if v21.Count == nil then
					v21.Count = 1
				end

				p[__wf_atom_5b41f63b] = v21
			elseif v20.Count == nil or v20.Count == 0 then
				v20.Count = module.Ternary(v19.mItemCount == nil, 1, v19.mItemCount)
			else
				v20.Count += module.Ternary(v19.mItemCount == nil, 1, v19.mItemCount)
			end
		end
	end
end

function AddTableToPurchasedItems(p, p2, p3)
	fn75(p, p2, p3)
end

function GetAllPurchasedItems()
	local v19 = {}
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return v19
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return v19
	end

	fn75(v19, inventory:__wf_atom_4f67b86c())
	fn75(v19, inventory:__wf_atom_20b04548())
	fn75(v19, inventory:__wf_atom_ebdc4e6e())
	fn75(v19, inventory:__wf_atom_4259c789())
	fn75(v19, inventory:__wf_atom_ff7d29fb())
	fn75(v19, inventory:__wf_atom_546ac461())
	fn75(v19, inventory:__wf_atom_50f906c7())
	fn75(v19, inventory:__wf_atom_db1ae7f4())
	fn75(v19, inventory:__wf_atom_1273f04d())
	fn75(v19, inventory:__wf_atom_71d5cc00())
	fn75(v19, inventory:GetUpgrades())
	fn75(v19, inventory:__wf_atom_063f1444())
	fn75(v19, inventory:__wf_atom_6b29f1ed())
	fn75(v19, inventory:__wf_atom_49479502())
	fn75(v19, inventory:__wf_atom_c84817dd())
	fn75(v19, inventory:__wf_atom_da43e3f3())
	fn75(v19, inventory:__wf_atom_8844017b())
	fn75(v19, inventory:__wf_atom_fe84572e())
	fn75(v19, inventory:__wf_atom_2ca27e15())
	fn75(v19, inventory:__wf_atom_35b0df9c())
	fn75(v19, inventory:__wf_atom_8e079833())
	fn75(v19, inventory:__wf_atom_6ca9b7b7())
	fn75(v19, inventory:__wf_atom_f976c704())
	fn75(v19, inventory:__wf_atom_bae92715())
	fn75(v19, inventory:__wf_atom_072f6737())
	fn75(v19, inventory:__wf_atom_a76bb6ec())
	fn75(v19, inventory:__wf_atom_260a9632())
	fn75(v19, inventory:__wf_atom_9683bef6())
	return v19
end

function GetRewardDesc(object, data, p, p2)
	local v19 = nil
	local v20 = {}

	local function fn76(p3)
		if p then
			table.insert(v20, p3)
		elseif v19 == nil then
			v19 = p3
		else
			v19 ..= " + " .. p3
		end
	end

	local function fn77(object2, object3, p3)
		local v21 = ""
		local item

		if __wf_atom_7e8ad928(object3) then
			item = object2:GetItem()
			v21 = tostring(object2:__wf_atom_014a76a2())
		else
			item = object3.mItemType

			if object3.mItemType:IsA(__wf_atom_3cecff09) then
				local v22 = Resource(object3.mItemType)

				if not __wf_atom_7e8ad928(v22) then
					v21 = tostring(v22:__wf_atom_014a76a2())
				end
			else
				v21 = tostring(object3:__wf_atom_38681098())
			end
		end

		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(v21, false)

		if not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_3cecff09) then
			__wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Items/BlueprintAndItem", false, {
				ITEM = __wf_atom_8e9ac384
			})
		end

		if
			(__wf_atom_7e8ad928(object2) or object2:__wf_atom_efa6f447() ~= 35)
			and (__wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_0b6f0357))
		then
			if p3 > 1 then
				__wf_atom_8e9ac384 ..= " (" .. p3 .. ")"
			end
		else
			local v22

			if __wf_atom_7e8ad928(object3) then
				v22 = -object2:__wf_atom_ee4fa4fd()
				p3 = object2:__wf_atom_17d97bf6()
			else
				v22 = -object3:__wf_atom_f13534ae()
			end

			__wf_atom_8e9ac384 = (p2 and "<FUSION_POINTS>" or object:__wf_atom_8e9ac384("<FUSION_POINTS>", true)) .. module.FormatNumber(v22 * p3)
		end

		if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_899096f6) then
			__wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionReward_Quest", false, {
				QUEST = __wf_atom_8e9ac384
			})
		end

		return __wf_atom_8e9ac384
	end

	if data.credits > 0 then
		fn76((p2 and "<CREDITS>" or object:__wf_atom_8e9ac384("<CREDITS>", true)) .. module.FormatNumber(data.credits))
	end

	local items = data.items

	for i = 1, #items do
		local item = items[i]

		if not __wf_atom_7e8ad928(item) then
			fn76(fn77(item, nil, 1))
		end
	end

	local countedStoreItems = data.countedStoreItems

	for i = 1, #countedStoreItems do
		local countedStoreItem = countedStoreItems[i]
		local mStoreItem = countedStoreItem.mStoreItem

		if not __wf_atom_7e8ad928(mStoreItem) then
			fn76(fn77(mStoreItem, nil, countedStoreItem.mItemCount))
		end
	end

	for i = 1, #data.countedItems do
		local countedItem = data.countedItems[i]

		if not __wf_atom_7e8ad928(countedItem.mItemType) then
			fn76(fn77(nil, countedItem, countedItem.mItemCount))
		end
	end

	if v19 == nil then
		v19 = ""
	end

	return module.Ternary(p, v20, v19)
end

local function fn76(instance)
	if instance:IsA(__wf_atom_cb425ff5) then
		return instance:GetIconTexture(), not instance:__wf_atom_c9969a68()
	end

	if __wf_atom_1ef90898(instance) then
		assert(false)
	end

	if instance:__wf_atom_d1d012ee() > 1 and instance:GetIconTexture() then
		return instance:GetIconTexture(), not instance:__wf_atom_c9969a68()
	end

	local __wf_atom_e622b3f6 = instance:__wf_atom_e622b3f6()

	if __wf_atom_7e8ad928(__wf_atom_e622b3f6) or __wf_atom_7e8ad928(__wf_atom_e622b3f6:GetIconTexture()) then
		return instance:GetIconTexture(), not instance:__wf_atom_c9969a68()
	end

	return __wf_atom_e622b3f6:GetIconTexture(), not __wf_atom_e622b3f6:__wf_atom_c9969a68()
end

function GetRecipeIconTexture(p)
	return fn76(p)
end

function GetRewardIcon(data, _)
	local uiTexture_CreditsIcon = nil
	local v19 = nil
	local mItemType = nil
	local item = nil
	local v20 = false
	local v21 = false
	local v22 = false

	if #data.items > 0 then
		v19 = data.items[1]
	elseif #data.countedItems > 0 then
		mItemType = data.countedItems[1].mItemType
	elseif #data.countedStoreItems > 0 then
		mItemType = data.countedStoreItems[1].mStoreItem
	end

	if v19 == nil then
		if mItemType == nil then
			if data.credits > 0 then
				uiTexture_CreditsIcon = _G.UITexture_CreditsIcon
			end
		else
			local v23 = Resource(mItemType)
			v20 = v23:IsA(__wf_atom_3cecff09)

			if v20 then
				uiTexture_CreditsIcon, v21 = fn76(v23)
			else
				uiTexture_CreditsIcon = v23:GetIconTexture()
				v21 = not v23:__wf_atom_c9969a68()
			end

			item = mItemType
		end
	else
		item = v19:GetItem()
		uiTexture_CreditsIcon = v19:GetIconTexture()
		v21 = not v19:__wf_atom_c9969a68()
		v20 = not __wf_atom_7e8ad928(item) and v19:GetItem():IsA(__wf_atom_3cecff09)
		v22 = v19:__wf_atom_7941efb7()
	end

	return uiTexture_CreditsIcon, v20, item, v21, v22
end

function GetRewardInfo(data)
	local result = {}

	if data.credits > 0 then
		table.insert(result, {
			Icon = _G.UITexture_CreditsIcon,
			Themed = true,
			NameOverride = module.FormatNumber(data.credits) .. " " .. Localize("/Lotus/Language/Menu/Store_BuyWithCredits", {})
		})
	end

	for i = 1, #data.items do
		local v19 = { StoreItem = data.items[i] }
		local item = v19.StoreItem:GetItem()

		if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_899096f6) then
			local quest = Localize(tostring(v19.StoreItem:__wf_atom_014a76a2()), {})
			v19.NameOverride = Localize("/Lotus/Language/Menu/MissionReward_Quest", {
				QUEST = quest
			})
		end

		table.insert(result, v19)
	end

	for i = 1, #data.countedStoreItems do
		local countedStoreItem = data.countedStoreItems[i]
		local mStoreItem = countedStoreItem.mStoreItem

		if __wf_atom_7e8ad928(mStoreItem) then
			continue
		end

		local v19 = { StoreItem = mStoreItem, SkipTitleCase = true }
		v19.NameOverride = Localize("/Lotus/Language/Items/LargeBatchItem", {
			ITEM = TitleCase(Localize(tostring(mStoreItem:__wf_atom_014a76a2()), {})),
			NUM = module.FormatNumber(countedStoreItem.mItemCount)
		})
		table.insert(result, v19)
	end

	for i = 1, #data.countedItems do
		local itemType = Resource(data.countedItems[i].mItemType)
		local v19 = { ItemType = itemType, Count = data.countedItems[i].mItemCount }
		v19.NameOverride = module.FormatNumber(data.countedItems[i].mItemCount) .. " " .. Localize(tostring(itemType:__wf_atom_014a76a2()), {})
		table.insert(result, v19)
	end

	return result
end

function GetDamageTypeTag(p)
	return v[p + 1]
end

function GetProcTypeTag(p)
	return v3[p + 1]
end

function GetMeleeStyleTag(p)
	return v2[p + 1]
end

function GetPolarityTag(p)
	return v4[p + 1]
end

function GetRecoveryMissionInfo()
	local sfMissionInfo = SF.SFMissionInfo()
	sfMissionInfo.missionType = 12
	sfMissionInfo.faction = 1
	sfMissionInfo.levelOverride = WeakResource("/Lotus/Levels/Proc/Corpus/CorpusGasCityHarvester")
	sfMissionInfo.enemySpec = Resource("/Lotus/Types/Game/EnemySpecs/CorpusSquadA")
	sfMissionInfo.soloMode = true
	sfMissionInfo.location = Symbol("/Lotus/Language/Locations/Jupiter")
	return sfMissionInfo
end

function FormatGoalPercentage(p)
	local v19 = __wf_atom_421b01aa(p, 0, 100)
	local v20 = math.floor(v19)
	local v21 = math.abs((math.floor(v19 * 10))) % 10
	local v22 = v20 == 0 and v21 == 0 and v19 ~= 0 and 1 or v21
	local v23 = tostring(v20)

	if v22 ~= 0 then
		v23 ..= "." .. v22
	end

	return v23 .. "%"
end

local function fn77(p)
	local entity = module.GetEntityFromTag("AvatarLight", module.Ternary(fn25(), __wf_atom_392793db, nil))

	if not __wf_atom_7e8ad928(entity) then
		if p then
			entity:TurnOn()
			entity:__wf_atom_f69a50f6(not __wf_atom_72884638("Graphics.DynamicLighting"))
		else
			entity:TurnOff()
		end
	end
end

function AvatarLight(p)
	fn77(p)
end

function MakeMainMenuAvatarKneel()
	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		fn11():__wf_atom_e06358f3(Symbol("Kneel"))
		fn77(false)
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
		__wf_atom_8ad59546.postProcess.horizonDOF = 0
		_T.SelectedLoadOutPart = nil
	end
end

function OnSaveLoadOutCompleteCommon(p)
	print("OnSaveLoadOutCompleteCommon")

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:SendLobbyLoadout()
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) and gMatchingService:__wf_atom_607c7363() then
		local settings = __wf_atom_15811761:GetSettings()
		settings.eloRating = fn73()
		gMatchingService:__wf_atom_c8d901d4(settings, p)
	end

	gMatchingService:__wf_atom_27e16961()
end

function RequestLoadOutBuild(p)
	if not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameRules)) then
		gGameRules:RequestLoadOutBuild(p, gGameRules:__wf_atom_4110c642())
	end
end

function MakeLevelItemString(object, p)
	local v19 = p == nil and "" or " " .. p
	local __wf_atom_22941262 = object:__wf_atom_22941262()
	local v20 = Localize(object:__wf_atom_014a76a2():c_str(), nil)
	return "<p><font face=\"Noto Sans\"><b>" .. Localize("/Lotus/Language/Menu/LevelAbbreviation", nil) .. " " .. tostring(__wf_atom_22941262) .. " </b>" .. v20 .. v19 .. "</font></p>"
end

function IsHarvestedOrBranded(object)
	if _T.gCorpusHarvesterFinisherVictim == object then
		return true
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(gGameRules) then
		return false
	end

	local __wf_atom_9311745d = gGameRules:__wf_atom_9311745d()

	if not __wf_atom_7e8ad928(__wf_atom_9311745d) then
		for i = 1, #__wf_atom_9311745d do
			if __wf_atom_9311745d[i].playerName == object:__wf_atom_a96eb2aa():__wf_atom_6be84646() then
				return true
			end
		end
	end

	return false
end

local function fn78()
	local UI_MODE_IN_GAME = UI_MODE_IN_GAME

	if __wf_atom_7e8ad928(gClient) then
		return UI_MODE_IN_GAME
	end

	local __wf_atom_2aee259b = gClient:__wf_atom_2aee259b()

	if __wf_atom_7e8ad928(gGameRules) then
		return UI_MODE_IN_GAME
	end

	if not __wf_atom_7e8ad928(__wf_atom_2aee259b) and gGameRules:IsA(__wf_atom_2aee259b) then
		return UI_MODE_IN_SPACE_SHIP
	end

	if gGameRules:IsA(__wf_atom_1316e0c2) or gGameRules:IsA(__wf_atom_ed7f8200) then
		return UI_MODE_IN_DOJO
	end

	if gGameRules:IsA(__wf_atom_e714d8ac) then
		UI_MODE_IN_GAME = UI_MODE_IN_SPACE_HUB
	end

	return UI_MODE_IN_GAME
end

function GetUIMode()
	return fn78()
end

function IsOSKAvailable(p)
	return Engine.IsOSKAvailable()
		and (Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302() or Engine.__wf_atom_2a979d69() or Engine.__wf_atom_fc67ba71() and p)
end

local function fn79(object, p, p2, p3, p4, list, items, p5)
	local v19 = {
		isMultiline = false,
		cancelDisabled = false,
		forChat = false,
		desc = nil,
		isEmail = false,
		doFilter = true
	}

	if items ~= nil then
		for k, item in pairs(items) do
			v19[k] = item
		end
	end

	local v20

	if __wf_atom_7e8ad928(object) then
		v20 = true
	else
		local v21 = fn5(object, 1)

		if #list > 0 then
			v20 = type(v21[list]) == "function"
		else
			v20 = false
		end
	end

	if IsOSKAvailable(p5) and v20 then
		local v21 = Localize(p, {})

		if p3 == 0 then
			return gRegion:__wf_atom_858ae72f(p2, v21, v21, false, v19.isEmail, v19.forChat, list, v19.doFilter)
		end

		return gRegion:__wf_atom_06b65d2b(p2, v21, v21, false, v19.isEmail, v19.forChat, list, p3)
	else
		if __wf_atom_7e8ad928(_G.UIMovie_InputDialogMovie) then
			return
		end

		local v21

		if __wf_atom_7e8ad928(object) then
			v21 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(_G.UIMovie_InputDialogMovie)
		else
			v21 = object:PushChildMovie(_G.UIMovie_InputDialogMovie)
		end

		v21:Execute("SetYesTag", "/Menu/Confirm_Item_Ok")
		v21:Execute("SetNoTag", v19.noTag == nil and "/Menu/Confirm_Item_Cancel" or v19.noTag)

		if v19.cancelDisabled then
			v21:Execute("SetCancelEnable", "false")
		end

		v21:__wf_atom_f62a8704("SetCaption", { p })

		if v19.desc ~= nil then
			v21:__wf_atom_f62a8704("SetText", { v19.desc })
		end

		if v19.isMultiline then
			v21:Execute("SetMultiline", "")
		end

		v21:__wf_atom_f62a8704("SetContent", { p2 })

		if p3 ~= 0 then
			v21:Execute("SetMaxChars", p3)
		end

		v21:Execute("SetCallback", p4)
		return true, v21
	end
end

function ShowInputDialog(p, p2, p3, p4, p5, p6, p7)
	return fn79(p, p2, p3, p4, p5, p6, p7)
end

function GetMaxAllianceMemberCount()
	local total2 = 0
	local gGameData = gGameData

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_5e018583 = gGameData:__wf_atom_5e018583(true)

		for i = 1, #__wf_atom_5e018583 do
			total2 += __wf_atom_c67f9605:__wf_atom_e0d9634c(__wf_atom_5e018583[i].mTier)
		end
	end

	return total2
end

local function fn80(p)
	if _T.CachedAlerts and _T.CachedAlerts[tostring(p)] ~= nil and _T.CachedAlerts[tostring(p)].mVisible then
		return _T.CachedAlerts[tostring(p)].mAlertInfo.mMissionInfo
	end

	return nil
end

function GetNodeAlertMissionInfo(p)
	return fn80(p)
end

local function fn81(p)
	if _T.CachedInvasionInfo == nil or p == nil then
		return nil
	end

	return _T.CachedInvasionInfo[tostring(p)]
end

function GetInvasionInfo(p)
	return fn81(p)
end

local function fn82(p)
	return _G.CachedGoalInfo[tostring(p)]
end

function GetGoalInfo(p)
	return fn82(p)
end

local function fn83(p)
	local v19 = tostring(p)

	if _G.CachedGoalInfo[v19] and not __wf_atom_7e8ad928(_G.CachedGoalInfo[v19].mIcon) then
		return _G.CachedGoalInfo[v19].mIcon
	end

	return _G.UITexture_Event
end

function GetEventTexture(p)
	return (fn83(p))
end

local function fn84(data)
	if not data then
		return ""
	end

	local __wf_atom_d0bb7cfd = SF.__wf_atom_d0bb7cfd(data.missionType)
	local v19 = nil

	if __wf_atom_d0bb7cfd == nil then
		return "", v19
	end

	if data.location == MARS_DUAL_DEFENSE_TAG or data.location == DEIMOS_DUAL_DEFENSE_TAG then
		return "DualDefense", v19
	end

	if data.forceAllyFaction then
		return "Crossfire", __wf_atom_d0bb7cfd
	end

	if data.goalTag == v14 then
		return "KuvaSurvival", v19
	end

	if data.missionType ~= 32 or data.faction ~= 1 or __wf_atom_7e8ad928(data.levelOverride) then
		return __wf_atom_d0bb7cfd, v19
	end

	local v20 = tostring(data.levelOverride:__wf_atom_5b41f63b())

	if not __wf_atom_7e8ad928(data.keyChainName) or string.find(v20, "Quest") ~= nil then
		return "Generic", v19
	end

	local v21 = string.find(string.reverse(v20), "%u")

	if v21 ~= nil then
		__wf_atom_d0bb7cfd ..= string.sub(v20, string.len(v20) - v21 + 1)
	end

	return __wf_atom_d0bb7cfd, v19
end

function GetMissionTypeName(p)
	return fn84(p)
end

local function fn85(p)
	return Localize(FactionNames[p + 1], nil)
end

function GetLocalizedFactionName(p)
	return fn85(p)
end

local function fn86(data, p, p2, p3, p4)
	local v19 = __wf_atom_7e8ad928(data.levelOverride) and "" or data.levelOverride:__wf_atom_5b41f63b()
	local uiTextures_ArenaLocation = nil

	if __wf_atom_7e8ad928(gClient) then
		return uiTextures_ArenaLocation
	end

	local uiTextures_EidolonPlains = nil
	local v20 = string.find(data.sortieId, "_Lite_") ~= nil

	if __wf_atom_7e8ad928(data.icon) then
		if data.missionType == 22 then
			uiTextures_ArenaLocation = _G.UITextures_ArenaLocation
		elseif data.missionType == 23 then
			uiTextures_ArenaLocation = _G.UITextures_JunctionLocation
		elseif data.missionType == 28 then
			uiTextures_EidolonPlains = _G.UITextures_EidolonPlains
		elseif string.find(v19, "Asteroid") then
			uiTextures_EidolonPlains = _G.UITextures_GrineerAsteroid
		elseif string.find(v19, "GasCity") then
			uiTextures_EidolonPlains = module.Ternary(v20, _G.UITextures_NarmerGasCity, _G.UITextures_GasCity)
		elseif string.find(v19, "Galleon") then
			uiTextures_EidolonPlains = _G.UITextures_GrineerShip
		elseif string.find(v19, "Outpost") then
			uiTextures_EidolonPlains = _G.UITextures_Outpost
		elseif string.find(v19, "InfestedCorpus") or string.find(v19, "InfestedHive") then
			uiTextures_EidolonPlains = _G.UITextures_InfestedCorpusShip
		elseif string.find(v19, "IcePlanet") then
			uiTextures_EidolonPlains = _G.UITextures_IcePlanet
		elseif string.find(v19, "Corpus") then
			uiTextures_EidolonPlains = _G.UITextures_CorpusShip
		elseif string.find(v19, "Settlement") then
			uiTextures_EidolonPlains = module.Ternary(v20, _G.UITextures_NarmerSettlement, _G.UITextures_Settlement)
		elseif string.find(v19, "Forest") then
			uiTextures_EidolonPlains = module.Ternary(
				v20,
				_G.UITextures_NarmerGrineerForest,
				_G.UITextures_GrineerForest
			)
		elseif string.find(v19, "Shipyard") then
			uiTextures_EidolonPlains = _G.UITextures_GrineerShipyard
		elseif string.find(v19, "SpaceBattles/") then
			uiTextures_ArenaLocation = _G.UITextures_ArchwingTrench
		elseif string.find(v19, "GrineerOcean") then
			uiTextures_EidolonPlains = _G.UITextures_GrineerOcean
		elseif string.find(v19, "OrokinMoon") then
			uiTextures_EidolonPlains = _G.UITextures_OrokinMoon
		elseif string.find(v19, "OrokinTower") then
			uiTextures_EidolonPlains = _G.UITextures_OrokinTower
		elseif string.find(v19, "Space/") then
			uiTextures_ArenaLocation = _G.UITextures_ArchwingFreeFlight
		elseif string.find(v19, "Fortress") then
			uiTextures_EidolonPlains = _G.UITextures_GrineerFortress
		elseif not __wf_atom_7e8ad928(p) and p.nodeType == 1 or p3 ~= nil then
			uiTextures_ArenaLocation = fn83(p.name)
		end
	elseif __wf_atom_7e8ad928(p2) then
		uiTextures_ArenaLocation = data.icon
	else
		uiTextures_ArenaLocation = p2.icon
	end

	if uiTextures_ArenaLocation == nil and uiTextures_EidolonPlains ~= nil then
		uiTextures_ArenaLocation = uiTextures_EidolonPlains[p4 or __wf_atom_c08f5a0e(1, #uiTextures_EidolonPlains)]
	end

	return uiTextures_ArenaLocation
end

function GetLocationTexture(p, p2, p3, p4, p5)
	return fn86(p, p2, p3, p4, p5)
end

local function fn87(data)
	local v19 = not __wf_atom_7e8ad928(data.levelOverride)
		and tostring(data.levelOverride:__wf_atom_5b41f63b()) == "/Lotus/Levels/Proc/Orokin/OrokinMoonSpy"
	local v20 = data.location == MARS_DUAL_DEFENSE_TAG

	if not (data.forceAllyFaction or v19 or v20) then
		return
	end

	local invasionAllyFaction = data.invasionAllyFaction

	if invasionAllyFaction == 3 or v19 then
		if data.faction == 0 then
			invasionAllyFaction = 1
		elseif data.faction == 2 then
			local v21 = ""

			if not __wf_atom_7e8ad928(data.enemySpec) then
				v21 ..= string.lower(data.enemySpec:__wf_atom_5b41f63b())
			end

			if not __wf_atom_7e8ad928(data.extraEnemySpec) then
				v21 ..= string.lower(data.extraEnemySpec:__wf_atom_5b41f63b())
			end

			invasionAllyFaction = string.find(v21, "corpus") and 1 or 0
		else
			invasionAllyFaction = 0
		end
	end

	local FACTION = fn85(invasionAllyFaction)
	local FACTION2 = fn85(data.faction)

	if v20 then
		return string.upper(Localize("/Lotus/Language/Missions/DualDefenseCompare", {
			FACTION1 = FACTION,
			FACTION2 = FACTION2
		}))
	end

	return string.upper(FACTION .. " " .. Localize("/Lotus/Language/Menu/MissionBoard_InvasionRewardCompare", nil) .. " " .. FACTION2)
end

function TryGetCrossfireDesc(p)
	return fn87(p)
end

local function fn88(p, name)
	return p and p[name]
end

function GetMissionInfo(data, mMissionInfo, object, mMovie, p)
	if __wf_atom_7e8ad928(mMovie) then
		mMovie = fn5().mMovie
	end

	local mAlertInfo = fn80(data.name)
	local mGoalInfo = fn82(data.name)
	local mSyndicateInfo = nil
	local mSortieInfo = nil
	local mActiveMissionInfo = nil
	local mGhostTowerMissionInfo = nil
	local mEliteAlertMissionInfo = nil
	local name = tostring(data.name)
	local v19 = false
	local radialSector = data.radialSector

	if not __wf_atom_7e8ad928(radialSector) then
		v19 = not __wf_atom_7e8ad928(radialSector.keyChain)
			or (not (__wf_atom_7e8ad928(mMissionInfo.levelKeyName) or __wf_atom_7e8ad928(mMissionInfo.keyChainName)) or false)
	end

	local v20 = data.nodeType == 7

	if data.reconstructionProgress then
		local cachedConstructionProjects = _T.CachedConstructionProjects
		local v21 = nil

		for i = 1, #cachedConstructionProjects do
			local cachedConstructionProject = cachedConstructionProjects[i]

			if cachedConstructionProject.info.mNode ~= data.name then
				continue
			end

			v21 = cachedConstructionProject
			break
		end

		if not v21 or data.reconstructionProgress ~= 1 then
			mGoalInfo = nil
		end
	end

	local v21 = not data.locked

	if mGoalInfo then
		mMissionInfo = mGoalInfo.mMissionInfo
	elseif v21 and not v19 then
		if __wf_atom_7e8ad928(mAlertInfo) then
			if
				fn88(_T.CachedGhostTowerMissions, name)
				and _T.CachedGhostTowerMissions[name].mUnlocked
				and _T.CachedGhostTowerMissions[name].mShowInStarChart
			then
				mGhostTowerMissionInfo = _T.CachedGhostTowerMissions[name]
				mMissionInfo = mGhostTowerMissionInfo.mMissionInfo
			elseif fn88(_T.CachedSyndicateMissions, name) and _T.CachedSyndicateMissions[name].mVisible then
				mSyndicateInfo = _T.CachedSyndicateMissions[name]
				mMissionInfo = mSyndicateInfo.mMissionInfo
			elseif fn88(_T.CachedSortieMissions, name) and _T.CachedSortieMissions[name].mShowInStarChart then
				mSortieInfo = _T.CachedSortieMissions[name]
				mMissionInfo = mSortieInfo.mMissionInfo
			elseif fn88(_T.CachedLiteSortieMissions, name) and _T.CachedLiteSortieMissions[name].mShowInStarChart then
				mSortieInfo = _T.CachedLiteSortieMissions[name]
				mMissionInfo = mSortieInfo.mMissionInfo
			elseif fn88(_T.CachedInvasionInfo, name) and _T.CachedInvasionInfo[name].mEventTag ~= EMPTY_SYMBOL then
				mMissionInfo = _T.CachedInvasionInfo[name].mAttackerMissionInfo
			elseif fn88(_T.CachedActiveMissions, name) and (p == nil or _T.CachedActiveMissions[name].mHard == p) then
				mActiveMissionInfo = _T.CachedActiveMissions[name]
				mMissionInfo = mActiveMissionInfo.mMissionInfo
			elseif
				fn88(_T.CachedEliteAlertMissions, name)
				and _T.CachedEliteAlertMissions[name].mUnlocked
				and _T.CachedEliteAlertMissions[name].mShowInStarChart
			then
				mEliteAlertMissionInfo = _T.CachedEliteAlertMissions[name]
				mMissionInfo = mEliteAlertMissionInfo.mMissionInfo
			end
		else
			if
				_T.CachedAlerts[name]
				and _T.CachedAlerts[name].mVisible
				and _T.CachedAlerts[name].mAlertInfo.mTag == v8
			then
				mAlertInfo.icon = _G.UITexture_Darvo
			end

			mMissionInfo = mAlertInfo
		end
	end

	local v22, v23 = fn84(mMissionInfo)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_" .. v22, false)

	if v23 then
		__wf_atom_8e9ac384 ..= " " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Missions/MissionName_" .. v23, false)
	end

	local mInvasionInfo

	if not (v19 or not __wf_atom_7e8ad928(mAlertInfo)) then
		mInvasionInfo = fn81(data.name)
	end

	local icon = mMissionInfo.icon
	local v24 = ""
	local c_str = mMissionInfo.descText:c_str()
	local difficulty = mMissionInfo.difficulty
	local minEnemyLevel = mMissionInfo.minEnemyLevel
	local maxEnemyLevel = mMissionInfo.maxEnemyLevel
	local uniqueName = mMissionInfo.uniqueName
	local rarity = mMissionInfo.rarity
	local tag = mMissionInfo.tag
	local v25 = nil
	local v26 = data.nodeType == 3
	local v27 = string.find(tostring(data.name), "Dojo") ~= nil

	if v19 then
		v24 = string.upper(mMissionInfo:__wf_atom_7ebd1b67():c_str())
	elseif v26 then
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HubTitle", false)
		local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Bosses/Tenno", false)
		icon = _G.UITexture_Hub
		__wf_atom_8e9ac384 = string.upper(__wf_atom_8e9ac384_2)
		v24 = string.upper(__wf_atom_8e9ac384_3)
	elseif v27 then
		local gGameData = gGameData
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Clan_DOJO", false)
		local __wf_atom_84083b39 = gGameData:__wf_atom_84083b39()
		icon = _G.UITexture_DefaultClan
		__wf_atom_8e9ac384 = string.upper(__wf_atom_8e9ac384_2)
		v24 = string.upper(__wf_atom_84083b39)
	elseif data.nodeType == 2 then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionIntro_PVP", false)
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Codex_Tenno", false)
		icon = _G.UITexture_Pvp
		v24 = string.upper(__wf_atom_8e9ac384_2)
	elseif mInvasionInfo == nil then
		if mGoalInfo == nil then
			if mMissionInfo.missionType == 0 then
				local v28 = false

				if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(mMissionInfo.vipAgent)) then
					v25 = object:__wf_atom_0988520a(mMissionInfo.vipAgent)

					if v25.locName ~= EMPTY_SYMBOL then
						v24 = mMovie:__wf_atom_8e9ac384(v25.locName:c_str(), false)
						icon = v25.icon
						v28 = true
						uniqueName = ""
					end
				end

				if not v28 then
					if mMissionInfo.uniqueName ~= "" then
						v24 = mMovie:__wf_atom_8e9ac384(mMissionInfo.uniqueName, false)
						v28 = true
					end

					icon = mMissionInfo.icon
				end

				if not v28 then
					v24 = mMissionInfo:__wf_atom_7ebd1b67():c_str()
				end
			elseif data.name == APARTMENT_NODE_TAG then
				v24 = ""
				__wf_atom_8e9ac384 = ""
			else
				if
					not __wf_atom_7e8ad928(_T.CachedAlerts)
					and _T.CachedAlerts[data.name]
					and _T.CachedAlerts[data.name].mAlertInfo.mTag ~= EMPTY_SYMBOL
					and _T.CachedAlerts[data.name].mAlertInfo.mMissionInfo.descText ~= EMPTY_SYMBOL
				then
					uniqueName = Localize(tostring(_T.CachedAlerts[data.name].mAlertInfo.mMissionInfo.descText), false)
				end

				local c_str2 = mMissionInfo:__wf_atom_7ebd1b67():c_str()

				if __wf_atom_7e8ad928(icon) then
					icon = nil
				end

				v24 = string.upper(v20 and "TENNO" or c_str2)
			end
		else
			if __wf_atom_7e8ad928(mGoalInfo.mMissionKeyName) then
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mGoalInfo.mDesc, false)
			else
				local v28 = Resource(mGoalInfo.mMissionKeyName)

				if not __wf_atom_7e8ad928(v28) then
					mMissionInfo = v28:__wf_atom_72fc675e()

					if mGoalInfo.mMissionInfo.minEnemyLevel > 1 then
						mMissionInfo.minEnemyLevel = mGoalInfo.mMissionInfo.minEnemyLevel
					end

					if mGoalInfo.mMissionInfo.maxEnemyLevel > 1 then
						mMissionInfo.maxEnemyLevel = mGoalInfo.mMissionInfo.maxEnemyLevel
					end

					if not __wf_atom_7e8ad928(mGoalInfo.mMissionInfo.enemySpec) then
						mMissionInfo.enemySpec = mGoalInfo.mMissionInfo.enemySpec
					end

					minEnemyLevel = mMissionInfo.minEnemyLevel
					maxEnemyLevel = mMissionInfo.maxEnemyLevel
					mMissionInfo:__wf_atom_7ebd1b67():c_str()
					__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Missions/MissionName_" .. fn84(mMissionInfo),
						false
					)
					uniqueName = ""
				end
			end

			local v28 = not __wf_atom_7e8ad928(mMissionInfo.enemySpec)
				and tostring(mMissionInfo.enemySpec:__wf_atom_5b41f63b()) == "/Lotus/Types/Game/EnemySpecs/GrineerEventSquadM"
				and ""
				or mMissionInfo:__wf_atom_7ebd1b67():c_str()
			v24 = string.upper(v28)
		end
	else
		if mInvasionInfo.mFaction == 2 then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Missions/MissionName_" .. fn84(mInvasionInfo.mDefenderMissionInfo),
				false
			)
		elseif mInvasionInfo.mEventTag == EMPTY_SYMBOL then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionIntro_Invasion", false)
		end

		local c_str2 = mInvasionInfo.mDefenderMissionInfo:__wf_atom_7ebd1b67():c_str()
		icon = _G.UITexture_Invasion
		v24 = string.upper(c_str2)
		uniqueName = ""
		minEnemyLevel = mInvasionInfo.mAttackerMissionInfo.minEnemyLevel
		maxEnemyLevel = mInvasionInfo.mAttackerMissionInfo.maxEnemyLevel

		if
			not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(mInvasionInfo.mDefenderMissionInfo.vipAgent)
			and mInvasionInfo.mEventTag == EMPTY_SYMBOL
		then
			v25 = object:__wf_atom_0988520a(mInvasionInfo.mDefenderMissionInfo.vipAgent)

			if v25.locName ~= EMPTY_SYMBOL then
				v24 = mMovie:__wf_atom_8e9ac384(v25.locName:c_str(), false)
				icon = v25.icon
				uniqueName = ""
			end
		end
	end

	local _ = string.len(uniqueName) > 0
	local ternary = module.Ternary(Engine.__wf_atom_578fc9dd(), "", data.founders)
	local mLocationTexture

	if not __wf_atom_7e8ad928(mMissionInfo.levelOverride) then
		local v28 = __wf_atom_04d7eaaa()
		__wf_atom_01bfe5c4(mMissionInfo.seed)
		mLocationTexture = fn86(mMissionInfo, data, v25, mGoalInfo)
		__wf_atom_01bfe5c4(v28)
	end

	local v28

	if v24 == "GRINEER" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_GrineerUC", false)
	elseif v24 == "CORPUS" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_CorpusUC", false)
	elseif v24 == "INFESTATION" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_InfestationUC", false)
	elseif v24 == "TENNO" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Codex_Tenno", false)
	elseif v24 == "WILD" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_WildUC", false)
	elseif v24 == "OROKIN" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_OrokinUC", false)
	elseif v24 == "REDVEIL" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_RedVeilUC", false)
	elseif v24 == "SENTIENT" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_SentientUC", false)
	elseif v24 == "MITW" then
		v28 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_MITW", false)
	else
		v28 = string.upper(v24)
		v24 = nil
	end

	if radialSector ~= nil then
		if radialSector.name == CETUS_NODE_TAG then
			v24 = "ostron"
		elseif radialSector.name == FORTUNA_NODE_TAG then
			v24 = "solaris"
		elseif radialSector.name == IRON_WAKE_NODE_TAG or radialSector.name == APARTMENT_NODE_TAG then
			v24 = "tenno"
		else
			v24 = v24
		end
	end

	local mDesc = fn87(mMissionInfo) or v28

	if mMissionInfo.missionType == 32 then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<RAILJACK>", true) .. " " .. __wf_atom_8e9ac384 .. " (" .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/RailjackTitle",
			false
		) .. ")"
	elseif mMissionInfo.isSharkwingMission then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<ARCHWING>", true) .. " " .. __wf_atom_8e9ac384 .. " (" .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/Sharkwing",
			false
		) .. ")"
	elseif mMissionInfo.archwingRequired then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<ARCHWING>", true) .. " " .. __wf_atom_8e9ac384 .. " (" .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/Loadout_Archwing",
			false
		) .. ")"
	end

	return {
		mMission = mMissionInfo,
		mFounders = ternary,
		mTexture = icon,
		mLocationTexture = mLocationTexture,
		mAlertInfo = mAlertInfo,
		mSyndicateInfo = mSyndicateInfo,
		mInvasionInfo = mInvasionInfo,
		mGoalInfo = mGoalInfo,
		mSortieInfo = mSortieInfo,
		mActiveMissionInfo = mActiveMissionInfo,
		mGhostTowerMissionInfo = mGhostTowerMissionInfo,
		mEliteAlertMissionInfo = mEliteAlertMissionInfo,
		mCardTag = tag,
		mName = __wf_atom_8e9ac384,
		mRarity = rarity,
		mDesc = mDesc,
		mDescText = c_str,
		mNameText = uniqueName,
		mNumMissions = 1,
		mDifficulty = difficulty,
		mLevelMin = minEnemyLevel,
		mLevelMax = maxEnemyLevel,
		mFactionTag = (v26 or v27) and "tenno" or v24
	}
end

function ShowCombos(object, stanceUpgradeInfo)
	local v19 = object:PushChildMovie(_G.UIMovie_MeleeCombosMovie)

	if not __wf_atom_7e8ad928(v19) then
		_T.StanceUpgradeInfo = stanceUpgradeInfo
		v19:Execute("SetStanceUpgradeInfo", "StanceUpgradeInfo")
		_T.StanceUpgradeInfo = nil
	end

	return v19
end

function GetMeleeStanceUpgradeInfo()
	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_311a7128) or __wf_atom_7e8ad928(gGameData) then
		if not __wf_atom_7e8ad928(gRegion) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				local __wf_atom_9fb9a1d6 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

				if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
					for i = 1, __wf_atom_9fb9a1d6:__wf_atom_06f3cb74() do
						local __wf_atom_b9a1f18c = __wf_atom_9fb9a1d6:__wf_atom_b9a1f18c(i - 1)

						if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(__wf_atom_39cfd03e) then
							continue
						end

						local result = SF.UpgradeInfo()
						result.mItemType = __wf_atom_b9a1f18c:__wf_atom_1bb5b1ff()
						result.mUpgradeFingerprint = __wf_atom_b9a1f18c:__wf_atom_f298d802()
						return result
					end

					if
						not __wf_atom_7e8ad928(gGameRules)
						and (gGameRules:IsA(__wf_atom_88d33e05) and gGameRules:__wf_atom_7b643206() or gGameRules:IsA(__wf_atom_3066d015))
					then
						local upgradeInfo = SF.UpgradeInfo()
						upgradeInfo.mItemType = __wf_atom_9fb9a1d6:__wf_atom_75a0566d():__wf_atom_1bb5b1ff()
						return upgradeInfo
					end
				end
			end
		end
	else
		local inventory = gGameData:GetInventory()

		if not __wf_atom_7e8ad928(inventory) then
			local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))

			if not __wf_atom_7e8ad928(__wf_atom_c132f79b) then
				local mItemId = __wf_atom_c132f79b:__wf_atom_b369d77f(3).mItemId
				local mModSlot = __wf_atom_c132f79b:__wf_atom_b369d77f(3).mModSlot
				local __wf_atom_43563387 = inventory:__wf_atom_43563387(mItemId.mId, mModSlot)

				for i = 1, #__wf_atom_43563387 do
					if
						not __wf_atom_7e8ad928(__wf_atom_43563387[i].mItemType)
						and __wf_atom_43563387[i].mItemType:IsA(__wf_atom_39cfd03e)
					then
						return __wf_atom_43563387[i]
					end
				end
			end
		end
	end

	return nil
end

function RemoveModsFromWeapon(object, p, list)
	if not __wf_atom_7e8ad928(object) then
		local count = 0
		local v19 = {}

		if p then
			table.insert(v19, WeakResource("/SF/Types/SFMeleeTree/SFMeleeTree"))
		end

		if list ~= nil then
			for i = 1, #list do
				table.insert(v19, list[i])
			end
		end

		while not __wf_atom_7e8ad928(object:__wf_atom_b9a1f18c(count)) do
			local __wf_atom_b9a1f18c = object:__wf_atom_b9a1f18c(count)
			local isA = __wf_atom_b9a1f18c:IsA(__wf_atom_58a409f1)

			if isA then
				for i = 1, #v19 do
					if not __wf_atom_b9a1f18c:IsA(v19[i]) then
						continue
					end

					isA = false
					break
				end
			end

			if isA then
				object:RemoveUpgrade(__wf_atom_b9a1f18c, true)
			else
				count += 1
			end
		end
	end
end

function GetGameModeTexture(p, p2)
	if p == "Assassination" then
		return _G.UITextures_GameModeTextures[1]
	elseif p == "Capture" then
		return _G.UITextures_GameModeTextures[2]
	elseif p == "PVP" then
		return _G.UITextures_GameModeTextures[3]
	elseif p == "Deception" then
		return _G.UITextures_GameModeTextures[4]
	elseif p == "Defense" then
		return _G.UITextures_GameModeTextures[6]
	end

	if p == "Exterminate" and p2 ~= nil then
		return _G.UITextures_GameModeTextures[7 + p2]
	end

	if p == "Hijack" then
		return _G.UITextures_GameModeTextures[10]
	elseif p == "Territory" then
		return _G.UITextures_GameModeTextures[11]
	elseif p == "MobileDefense" then
		return _G.UITextures_GameModeTextures[12]
	elseif p == "Rescue" then
		return _G.UITextures_GameModeTextures[13]
	elseif p == "Sabotage" then
		return _G.UITextures_GameModeTextures[14]
	elseif p == "Spy" then
		return _G.UITextures_GameModeTextures[15]
	elseif p == "Survival" then
		return _G.UITextures_GameModeTextures[16]
	elseif p == "Void" then
		return _G.UITextures_GameModeTextures[17]
	end

	return _G.UITextures_GameModeTextures[5]
end

function HasCompletedQuestStage(object, p, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return false
	end

	local __wf_atom_fe84572e = object:GetInventory():__wf_atom_fe84572e()

	if __wf_atom_7e8ad928(__wf_atom_fe84572e) then
		return false
	end

	for _, v19 in ipairs(__wf_atom_fe84572e) do
		if v19.mItemType ~= p then
			continue
		end

		local mProgress = v19.mProgress

		if p2 < #mProgress then
			local v20 = mProgress[p2 + 1]
			return not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(v20.mCompletion)) and v20.mCompletion > -1
		else
			return false
		end
	end

	return false
end

local function fn89(object, object2, p, p2, p3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return nil, nil, nil, nil
	end

	local v19 = __wf_atom_7e8ad928(p3) and 0 or p3
	local __wf_atom_fe84572e = object:GetInventory():__wf_atom_fe84572e()

	if __wf_atom_7e8ad928(__wf_atom_fe84572e) then
		return nil, nil, nil, nil
	end

	local __wf_atom_59f1738a = object2:__wf_atom_59f1738a()

	for _, v20 in ipairs(__wf_atom_fe84572e) do
		if v20.mItemType ~= object2 then
			continue
		end

		local mCompletion = -1
		local mProgress = v20.mProgress

		if p2 then
			print("_GetQuestInfo: progress - " .. tostring(#mProgress))
		end

		if #mProgress > 0 then
			mCompletion = mProgress[1].mCompletion

			if p2 then
				print("_GetQuestInfo: stage 1 completion - " .. tostring(mCompletion))
			end
		end

		local v21 = 0

		if mCompletion >= 0 then
			if #mProgress < __wf_atom_59f1738a then
				for i, v22 in ipairs(mProgress) do
					if v22.mCompletion > -1 then
						v21 = i
					else
						break
					end
				end

				v21 += 1
			else
				for i = 1, math.min(#mProgress, __wf_atom_59f1738a) do
					if not (mProgress[i].mCompletion < mCompletion) then
						continue
					end

					v21 = i
					break
				end
			end
		end

		if p2 then
			print("_GetQuestInfo: difficulty (A) - " .. tostring(mCompletion))
		end

		if mCompletion < 0 then
			mCompletion = 0
			v21 = 1
		elseif v21 == 0 then
			mCompletion += 1
			v21 = 1
		end

		if p2 then
			print("_GetQuestInfo: difficulty (B) - " .. tostring(mCompletion) .. ", mission index=" .. tostring(v21))
		end

		local mKey = nil

		if p then
			local v22 = v21 + v19

			if object2:__wf_atom_abb38a7f(v22 - 1) and not __wf_atom_7e8ad928(object2:__wf_atom_8ffd7933()[v22]) then
				mKey = object2:__wf_atom_8ffd7933()[v22].mMainMission.mKey
			end
		end

		return v21, mCompletion, v20.mCanProgressQuest, mKey
	end

	return nil, nil, nil, nil
end

function GetQuestInfo(p, p2, p3, p4, p5)
	return fn89(p, p2, p3, p4, p5)
end

local function fn90(object)
	if __wf_atom_7e8ad928(object) then
		return nil, nil, nil, nil
	end

	local inventory = object:GetInventory()

	if not _T.ActiveQuestLoaded then
		return nil, nil, nil, nil
	end

	local v19 = Resource(inventory:GetActiveQuest())

	if __wf_atom_7e8ad928(v19) then
		return nil, nil, nil, nil
	end

	return v19, fn89(object, v19)
end

function GetActiveQuest(p)
	return fn90(p)
end

local function fn91(p)
	local v19 = p or gGameData
	return not __wf_atom_7e8ad928(v19) and v19:InQuestCommitment()
end

function InQuestCommitment(p)
	return fn91(p)
end

function GetAllKeys(list, p, object)
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return list
	end

	local __wf_atom_8844017b = gGameData:GetInventory():__wf_atom_8844017b()

	if not __wf_atom_7e8ad928(__wf_atom_8844017b) then
		local mGoals = gGameData:__wf_atom_92662866().mGoals

		local function fn92(p2)
			if p2.mItemCount <= 0 then
				return nil
			end

			local mItemType = p2.mItemType

			if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(__wf_atom_c8d7c4cd) then
				return nil
			end

			if module.IsUGCRestricted() and not __wf_atom_7e8ad928(_G.UITypes_UGCKeys) then
				for i = 1, #_G.UITypes_UGCKeys do
					if not __wf_atom_7e8ad928(_G.UITypes_UGCKeys[i]) and p2.mItemType:IsA(_G.UITypes_UGCKeys[i]) then
						return nil
					end
				end
			end

			local v19 = Resource(mItemType)

			if __wf_atom_7e8ad928(v19) then
				return nil
			end

			if v19:__wf_atom_7b70a0a2() then
				local flag = true

				for i = 1, #mGoals do
					if not gGameData:__wf_atom_044a8d12(i - 1) then
						continue
					end

					local mGoal = mGoals[i]

					if not (mItemType == mGoal.mKeyRequired and mGoal.mSuccess == 0) then
						continue
					end

					flag = false
					break
				end

				if flag then
					return nil
				end
			end

			if p == nil or v19:__wf_atom_1c4ed35a() == p then
				return v19
			end

			return nil
		end

		for i = 1, #__wf_atom_8844017b do
			local v19 = __wf_atom_8844017b[i]
			local v20 = fn92(v19)

			if __wf_atom_7e8ad928(v20) then
				continue
			end

			local v21 = {
				Key = v19,
				Type = v20,
				Name = Localize(tostring(v20:__wf_atom_014a76a2()), false),
				Description = Localize(tostring(v20:__wf_atom_3a3d2e39()), false),
				ToolTip = fn13(nil, v20, nil, nil)
			}

			if not __wf_atom_7e8ad928(object) then
				local __wf_atom_232fd31d = object:__wf_atom_232fd31d(v19.mItemType)

				if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
					v21.StoreItem = __wf_atom_232fd31d
					v21.Icon = __wf_atom_232fd31d:GetIconTexture()
				end
			end

			if v20:__wf_atom_7a2dbfd5() then
				v21.Count = v19.mItemCount
			end

			table.insert(list, v21)
		end

		table.sort(list, function(a, b)
			return b.Name > a.Name
		end)
	end
end

function ShowDialogForFeatureUpgrade(object)
	local segment = string.upper(Localize(object:__wf_atom_014a76a2():c_str(), {}))
	local v19 = ("<font color=\"#FloatingContent\"><br><b>" .. Localize(
		"/Lotus/Language/ShipFeatureItems/ShipFeatureUpgraded",
		{ SEGMENT = segment }
	)) .. "</b><br><br></font>"
	local v20 = Localize(object:__wf_atom_3a3d2e39():c_str(), {})
	local v21 = 0
	local v22 = ""

	while true do
		local v23
		v23, v21 = string.find(v20, "\r\n%-[^%-^\r^\n]+", v21)

		if v23 == nil or v21 == nil then
			break
		end

		local v24 = v20:sub(v23, v21)

		if v24 == nil then
			break
		else
			v22 ..= "    " .. v24:gsub("\r\n", "") .. "<br>"
		end
	end

	local v23 = "<font color=\"#Content\">" .. v22 .. "</font>"
	module.ShowMessage(v19 .. v23, nil, nil, true)
end

function UpdateUIConsoleTriggers(p)
	if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() or __wf_atom_7e8ad928(gRegion) then
		print("Warning: called UpdateUIConsoleTriggers but the player isn't logged in yet!")
		return
	end

	local all = gRegion:FindAll(__wf_atom_6e0c84cf)
	local gGameData = gGameData
	local v19 = Symbol("News")
	local v20 = Symbol("Conclave")
	local v21 = false

	for i = 1, 2 do
		local v22 = {}

		for j = 1, #all do
			local __wf_atom_db682341 = all[j]:__wf_atom_db682341()
			local v23 = (not __wf_atom_a29d89c2() or Engine.__wf_atom_fc67ba71() or __wf_atom_db682341 ~= v19)
				and true
				or false

			if (__wf_atom_db682341 == v20 or __wf_atom_db682341 == v19) and not fn53() then
				v23 = false
			end

			if all[j]:__wf_atom_a995e2d2() or __wf_atom_7e8ad928(gGameData) then
				continue
			end

			local __wf_atom_2d8f1a54 = all[j]:__wf_atom_2d8f1a54()
			local v24 = #__wf_atom_2d8f1a54 == 0

			for k = 1, module.Ternary(i == 1, math.min(1, #__wf_atom_2d8f1a54), #__wf_atom_2d8f1a54) do
				local mFeatureItem = __wf_atom_2d8f1a54[k].mFeatureItem
				local v25 = tostring(mFeatureItem:__wf_atom_5b41f63b())

				if gGameData:__wf_atom_e9d1e802(mFeatureItem) then
					all[j]:__wf_atom_a465d37c(mFeatureItem)
					v24 = true
				elseif
					not v22[v25]
					and gGameData:__wf_atom_a8847576(mFeatureItem)
					and (not __wf_atom_2d8f1a54[k].mRequiresMainUpgrade or all[j]:__wf_atom_a1f64da3())
				then
					if
						mFeatureItem == SF_INFESTED_FOUNDRY
						or mFeatureItem == SF_INFESTED_FOUNDRY_UPGRADE
						or mFeatureItem == SF_INFESTED_FOUNDRY_SHARD_UPGRADE
						or mFeatureItem == SF_INFESTED_FOUNDRY_FUSION_UPGRADE
					then
						all[j]:Enable()
					end

					all[j]:__wf_atom_bf6d2add(mFeatureItem)
					v22[v25] = true
					v24 = true

					if v21 or __wf_atom_7e8ad928(__wf_atom_2d8f1a54[k].mInstallNowTransmission) then
						break
					end

					fn52(__wf_atom_2d8f1a54[k].mInstallNowTransmission)
					v21 = true
					break
				end
			end

			all[j]:__wf_atom_438bf419(v24 and v23)

			if p and v23 then
				all[j]:Start()
			end
		end
	end

	_T.uiConsoleTriggersInitialized = true
end

function DoesStringContainAllDigits(value)
	local v19 = string.len(value)

	if v19 == 0 then
		return false
	end

	local v20 = string.sub(value, 1, 1)
	local v21 = string.sub(value, v19, v19)

	for i = 0, 9 do
		value = string.gsub(value, tostring(i), "")
	end

	return value == "" or value == "." or value == " " and (v20 == " " or v21 == " ") or value == ". " or value == " ."
end

function UpdateHeadTracking(object, p)
	if _T.CustomHeadTracking or (not _T.GetTopScreen or __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(object)) then
		return false
	end

	local _, v19 = _T.GetTopScreen()
	local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

	if
		_T.DisableHeadTracking
		or v19 == "LoadOut"
		or not __wf_atom_7e8ad928(__wf_atom_c3b255b8)
		or object:__wf_atom_611b620c()
		or object:__wf_atom_40a4ba6c()
		or object:__wf_atom_7b82e9e1(0)
		or object:__wf_atom_7b82e9e1(3)
		or not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:__wf_atom_dedeec57()
		or object:__wf_atom_6d711da3()
	then
		object:__wf_atom_086a7266()
	else
		local v20

		if _T.DiegeticPosition and p ~= true then
			v20 = _T.DiegeticPosition
		else
			v20 = __wf_atom_d2b2176d:__wf_atom_74d951b0()
		end

		object:__wf_atom_6868003b(v20)
	end

	return true
end

function GetUnlockedNavFeatures(object, object2)
	local result = {}

	if __wf_atom_7e8ad928(object2) then
		return result
	end

	local v19 = fn21()
	local __wf_atom_a212d5ad = object:__wf_atom_a212d5ad()
	local v20 = {}

	for i = 1, #__wf_atom_a212d5ad do
		v20[v19:__wf_atom_db2d8292(__wf_atom_a212d5ad[i].mTag).name] = true
	end

	local __wf_atom_caa82b8d = object2:__wf_atom_caa82b8d(__wf_atom_84f03899)

	for i = 1, #__wf_atom_caa82b8d do
		local item = __wf_atom_caa82b8d[i]:GetItem()
		local __wf_atom_4cc0438f = Resource(item):__wf_atom_4cc0438f()

		for j = 1, #__wf_atom_4cc0438f do
			local __wf_atom_db2d8292 = v19:__wf_atom_db2d8292(__wf_atom_4cc0438f[j])

			if not v20[__wf_atom_db2d8292.name] then
				continue
			end

			v20[__wf_atom_db2d8292.name] = false
			table.insert(result, item)
		end
	end

	return result
end

function SetUpInWorldPanel(object, p, p2)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(_G.UIColor_DarkGrey)
	local ternary = module.Ternary(p2 == nil, _G.UIMaterial_Rectangle, p2)

	for _, v19 in ipairs({ p .. ".Foreground", p .. ".Shadow", p .. ".BackShadow" }) do
		object:OverrideMaterial(v19, ternary)
		object:__wf_atom_1ca72041(
			v19,
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.35
		)
		object:__wf_atom_1ca72041(
			v19,
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			1
		)
	end

	object:__wf_atom_4c1c1986(p, "Foreground", 4, 0)
	object:__wf_atom_4c1c1986(p, "Shadow", 4, 200)
	object:__wf_atom_4c1c1986(p, "BackShadow", 4, 400)
	object:__wf_atom_4c1c1986(p, "Foreground", 12, 75)
	object:__wf_atom_4c1c1986(p, "Shadow", 12, 45)
	object:__wf_atom_4c1c1986(p, "BackShadow", 12, 25)
	return not __wf_atom_7e8ad928(ternary)
end

function LinearToSRGB(p)
	if p <= 0.0031308 then
		return p * 12.92
	end

	return math.pow(p, 5 / 12) * 1.055 - 0.055
end

function SRGBToLinear(p)
	if p <= 0.03928 then
		return p / 12.92
	end

	return (math.pow((p + 0.055) / 1.055, 2.4))
end

local v19 = nil

local function fn92()
	local v20 = fn5()
	v19 = {}
	v19[1] = "<POLARITY_ATTACK>"
	v19[2] = "<POLARITY_DEFENSE>"
	v19[3] = "<POLARITY_TACTIC>"
	v19[4] = "<POLARITY_POWER>"
	v19[5] = "<POLARITY_PRECEPT>"
	v19[6] = "<POLARITY_FUSION>"
	v19[7] = "<POLARITY_WARD>"
	v19[8] = "<POLARITY_UMBRA>"
	v19[12] = "<POLARITY_ANY>"

	for i = 1, #v19 do
		v19[i] = v20.mMovie:__wf_atom_8e9ac384(v19[i], true)
	end
end

function LocalizePolarities()
	fn92()
end

function GetTagForPolarity(p)
	if v19 == nil then
		fn92()
	end

	if v19[p] then
		return v19[p]
	end

	return ""
end

function ShowQuestCompleted(value)
	if type(value) ~= "string" then
		value = value:__wf_atom_5b41f63b()
	end

	if not __wf_atom_7e8ad928(_G.UIMovie_EndOfQuestMovie) then
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(_G.UIMovie_EndOfQuestMovie)

		if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
			__wf_atom_5d67a2c5:Execute("SetQuestType", value)
		end
	end
end

function ApplyGenericBackerMaterial(object, p, p2)
	local v20 = p2 == nil or p2
	object:OverrideMaterial(p, module.Ternary(v20, _G.UIMaterial_RectangleNoDepth, _G.UIMaterial_Rectangle))
	object:__wf_atom_1ca72041(
		p,
		"RectInnerColor",
		_G.UIColorObject_DarkBlue.r,
		_G.UIColorObject_DarkBlue.g,
		_G.UIColorObject_DarkBlue.b,
		0.2
	)
	object:__wf_atom_1ca72041(
		p,
		"RectEdgeColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0
	)
end

local function fn93(object, p, p2, p3, p4)
	local gGameData2 = gGameData

	if __wf_atom_7e8ad928(gGameData2) or __wf_atom_7e8ad928(object) then
		return 0, 0, 1, false, 0
	end

	local __wf_atom_e0f044e1 = object:__wf_atom_e0f044e1()
	local __wf_atom_51dd1b95 = gGameData2:__wf_atom_51dd1b95(__wf_atom_e0f044e1)
	local ternary = module.Ternary(p3 ~= nil, p3, __wf_atom_51dd1b95.mTitle)
	local mStanding = tonumber(p2)

	if mStanding == nil then
		mStanding = __wf_atom_51dd1b95.mStanding

		if p4 then
			local __wf_atom_9357997e = gGameData:__wf_atom_9357997e()

			for i = 1, #__wf_atom_9357997e do
				if __wf_atom_9357997e[i].mTag == __wf_atom_e0f044e1 then
					mStanding -= __wf_atom_9357997e[i].mStanding
				end
			end
		end
	end

	local ternary2 = module.Ternary(
		object:__wf_atom_75de2a4d(),
		__wf_atom_c67f9605:__wf_atom_7a5e1add(__wf_atom_e0f044e1, ternary),
		0
	)
	local ternary3 = module.Ternary(
		object:__wf_atom_75de2a4d(),
		__wf_atom_c67f9605:__wf_atom_053b87b2(__wf_atom_e0f044e1, ternary),
		object:__wf_atom_f44cdd51()
	)
	local v20 = ternary3 - mStanding
	local __wf_atom_bca3f82a = object:__wf_atom_bca3f82a()

	if __wf_atom_bca3f82a > 0 and __wf_atom_bca3f82a < 3 and object:__wf_atom_73f36e1b() then
		v20 = math.min(v20, (gGameData2:__wf_atom_dc1594a9(__wf_atom_bca3f82a)))
	end

	if p ~= nil then
		mStanding += tonumber(p)
	end

	local v21 = mStanding - ternary2
	local v22 = ternary3 - ternary2
	local v23 = v22 <= v21

	if not object:__wf_atom_75de2a4d() then
		return ternary, math.max(v21, 0), v22, v23, v20
	end

	if ternary == 0 then
		v22 /= 2
		v21 -= v22

		if v21 < 0 then
			v22 = -v22
		end
	elseif ternary < 0 then
		v21 -= v22
		v22 = -v22
	end

	return ternary, math.max(v21, 0), v22, v23, v20
end

function GetReputationInfoForSyndicate(p, p2, p3, p4, p5)
	return fn93(p, p2, p3, p4, p5)
end

local function fn94(p, state)
	local mSpeakerSyndicate

	if not __wf_atom_7e8ad928(p.mSpeakerSyndicate) then
		mSpeakerSyndicate = p.mSpeakerSyndicate
	end

	local level, reputation, reputationRequired, hasEnoughReputationForSacrifice = fn93(mSpeakerSyndicate)
	state.Level = level
	state.Reputation = reputation
	state.ReputationRequired = reputationRequired
	state.HasEnoughReputationForSacrifice = hasEnoughReputationForSacrifice
	state.Loved = (__wf_atom_7e8ad928(mSpeakerSyndicate) and 3 or mSpeakerSyndicate:__wf_atom_05e0be09()) <= state.Level

	if state.Loved then
		for i = 1, #p.mAdditionalLovedSyndicateRequirements do
			local mAdditionalLovedSyndicateRequirement = p.mAdditionalLovedSyndicateRequirements[i]

			if
				__wf_atom_7e8ad928(mAdditionalLovedSyndicateRequirement)
				or not (fn93(mAdditionalLovedSyndicateRequirement) < mAdditionalLovedSyndicateRequirement:__wf_atom_05e0be09())
			then
				continue
			end

			state.Loved = false
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()
		state.Loved = state.Loved and not settings:__wf_atom_a35494b3()
	end
end

function GetLovedReputationInfoForSyndicate(p, p2)
	fn94(p, p2)
end

function DrawItem(object, data)
	object:__wf_atom_4c1c1986(data.mClipName, "Image", 12, module.Ternary(__wf_atom_7e8ad928(data.Icon), 0, 100))

	if __wf_atom_7e8ad928(data.Icon) then
		return
	end

	local v20 = WeakResource("/SF/Types/Game/SFSigil")
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(data.mClipName .. ".Image", 15)
	local ternary = module.Ternary(data.Type:IsA(v20), __wf_atom_5e6e15c8, __wf_atom_5e6e15c8 * 1.444)
	object:__wf_atom_c90af43a(data.mClipName .. ".Image", data.Icon)
	object:__wf_atom_4c1c1986(data.mClipName, "Image", 14, ternary)
end

function GetDailyDeal()
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local __wf_atom_92662866 = gGameData:__wf_atom_92662866()

	if __wf_atom_7e8ad928(__wf_atom_92662866) then
		return nil
	end

	for _, mDailyDeal in ipairs(__wf_atom_92662866.mDailyDeals) do
		if
			Engine.__wf_atom_db2b0cee(mDailyDeal.mActivation) <= 0
			and Engine.__wf_atom_db2b0cee(mDailyDeal.mExpiry) > 0
		then
			return SF.DailyDealInfo(mDailyDeal)
		end
	end

	return nil
end

function OpenTrainingMission(trainingMissionRank, isTrainingMissionPractise)
	_G.TrainingMissionRank = trainingMissionRank
	local v20 = math.min(trainingMissionRank, __wf_atom_c67f9605:__wf_atom_bf33dd41() - 1)
	_G.IsTrainingMissionPractise = isTrainingMissionPractise
	local __wf_atom_b78090dd = __wf_atom_c67f9605:__wf_atom_b78090dd(v20)

	if isTrainingMissionPractise then
		__wf_atom_b78090dd.missionReward.credits = 0
	end

	local levelArgs = Engine.OpenLevelArgs()
	local __wf_atom_cf762a4f = __wf_atom_b78090dd:__wf_atom_cf762a4f()
	local __wf_atom_0958db03 = __wf_atom_b78090dd:__wf_atom_0958db03()

	for i = 1, #__wf_atom_0958db03 do
		levelArgs:__wf_atom_fce3b660(__wf_atom_0958db03[i].agent)
	end

	levelArgs:__wf_atom_98718663(__wf_atom_cf762a4f)
	levelArgs:SetLevel(__wf_atom_b78090dd.levelOverride:__wf_atom_5b41f63b())
	levelArgs.gameRules = __wf_atom_b78090dd.gameRules
	levelArgs.migrateServer = false
	Engine.OpenLevel(levelArgs)
end

local function fn95()
	return 10
end

function GetTrainingRetryPlatinumCost()
	return (fn95())
end

function CanRankUp(object, p)
	local flag = true
	local v20 = ""
	local v21 = false

	if __wf_atom_7e8ad928(object) then
		return false, v20
	end

	local __wf_atom_a4299765 = object:__wf_atom_a4299765()
	local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(0, 1)
	local __wf_atom_ed5c034d2 = __wf_atom_a4299765:__wf_atom_ed5c034d(0, 2)
	local __wf_atom_ed5c034d3 = __wf_atom_a4299765:__wf_atom_ed5c034d(0, 3)

	if not (__wf_atom_ed5c034d.mItemId:__wf_atom_8598f3a9() and __wf_atom_ed5c034d2.mItemId:__wf_atom_8598f3a9() and __wf_atom_ed5c034d3.mItemId:__wf_atom_8598f3a9()) then
		flag = false
		v20 = "/Lotus/Language/Menu/IncompleteLoadout"
	end

	local __wf_atom_a04e4a53 = gGameData:__wf_atom_a04e4a53()
	local __wf_atom_bf33dd41 = __wf_atom_c67f9605:__wf_atom_bf33dd41()
	local v22 = math.min(__wf_atom_a04e4a53 + 1, __wf_atom_bf33dd41 - 1)

	if __wf_atom_c67f9605:__wf_atom_b78090dd(v22).archwingRequired then
		flag = false
		v20 = "/Lotus/Language/Menu/ArchwingFailureSolo"
	end

	if not fn53() then
		flag = false
		v20 = "/Lotus/Language/MasteryTest/CompleteVorsPrize"
	end

	if flag then
		local __wf_atom_e0c949ff = object:__wf_atom_e0c949ff()

		if __wf_atom_e0c949ff > 0 and not p then
			local v23 = fn8(nil, __wf_atom_e0c949ff)

			if object:__wf_atom_3782c87d() > 0 then
				v20 = Localize("/Lotus/Language/Menu/Foreground_LevelUpRetry", {
					TIME_REMAINING = v23,
					COST = fn95()
				})
				v21 = true
			else
				local v24 = Localize("/Lotus/Language/Menu/Foreground_LevelUpSuspended", false)
				v20 = string.format(v24, v23)
			end

			flag = false
		end
	end

	if
		flag
		and not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
		and gMatchingService:__wf_atom_15811761():__wf_atom_a7bb026f() > 1
	then
		flag = false
		v20 = "/Lotus/Language/Menu/Foreground_LevelUpSessionActive"
	end

	return flag, v20, v21
end

local function fn96(p, p2)
	print("Dojo: OnTrainingResultUploaded result=" .. tostring(p) .. ", body=" .. tostring(p2))
end

function OnChallengePassed(playerAvatar, p, p2, p3, p4)
	local ternary = module.Ternary(__wf_atom_7e8ad928(_G.IsTrainingMissionPractise), true, _G.IsTrainingMissionPractise)
	local module3 = require("Lotus.Scripts.ChallengeRooms.BaseChallengeRoom")

	if not ternary then
		gGameData:__wf_atom_17f60980(1, fn96)
	end

	if __wf_atom_7e8ad928(playerAvatar) then
		playerAvatar = gRegion:GetPlayerAvatar(0)
	end

	if playerAvatar:IsA(__wf_atom_47cae841) then
		playerAvatar = playerAvatar:__wf_atom_4221009f()
	end

	if not __wf_atom_7e8ad928(playerAvatar) then
		playerAvatar:__wf_atom_9b5dcd3b(p, true, 2, 3, true)
		playerAvatar:GiveItem(p2, true)
		playerAvatar:__wf_atom_ab021aff(true)
	end

	Sleep(3)
	module3.ChallengePassed(p3, p4, ternary)
end

function GetFriendlyPlayers(object)
	local isA = gGameRules:IsA(__wf_atom_abe10cec)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local result = {}

	for _, v20 in ipairs(__wf_atom_3c8e1a7a) do
		if not (not isA or object:__wf_atom_8537d7d4() == v20:__wf_atom_8537d7d4() and (_T.PvpMode == nil or _T.PvpMode and _T.PvpMode ~= 3)) then
			continue
		end

		if v20:__wf_atom_6be84646() == HIDDEN_PLAYER_NAME then
			continue
		end

		table.insert(result, v20)
	end

	return result
end

function FindNearestTagged(p, p2)
	local v20

	while true do
		v20 = gRegion:FindNearestTagged(p, p2)

		if not __wf_atom_7e8ad928(v20) then
			break
		end

		assert(not gRegion:IsMaster())
		Sleep(0)
	end

	return v20
end

local function fn97(value)
	if value == "" then
		value = Localize("/Lotus/Language/Menu/Loadout_Default", false)
	end

	if string.find(value, "/Lotus/Language/Bundles") ~= nil then
		value = Localize(value, {})
	end

	if __wf_atom_d9227398() then
		value = __wf_atom_f8f86fc5(value, 1)
	end

	return value
end

function GetLoadoutPresetName(p)
	return fn97(p)
end

function UpdateQuests(p)
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return "", false
	end

	if not _T.ActiveQuestLoaded then
		print("Update quests: no active quest loaded")
		return "", false
	end

	local activeQuest, stage, difficulty, canProgress = fn90(gGameData)
	local v20 = ""
	local v21 = _T.questInfo == nil
		or _T.questInfo.activeQuest == nil
		or _T.questInfo.activeQuest ~= activeQuest
		or _T.questInfo.stage ~= stage
		or _T.questInfo.gameRules ~= gGameRules
	_T.questInfo = {
		activeQuest = activeQuest,
		stage = stage,
		difficulty = difficulty,
		canProgress = canProgress,
		gameRules = gGameRules
	}
	_G.questInfo = _T.questInfo

	if __wf_atom_7e8ad928(activeQuest) and not p then
		local __wf_atom_fe84572e = gGameData:GetInventory():__wf_atom_fe84572e()

		for _, v22 in ipairs(__wf_atom_fe84572e) do
			if not v22.mCompleted then
				return "New quests are available!", true
			end
		end

		return "", true
	else
		if stage and not __wf_atom_7e8ad928(activeQuest) then
			v20 = Localize(tostring(activeQuest:__wf_atom_014a76a2()), false)
			local __wf_atom_94176709 = activeQuest:__wf_atom_94176709(stage - 1)

			if __wf_atom_94176709 ~= EMPTY_SYMBOL then
				v20 ..= "\r\n" .. Localize(tostring(__wf_atom_94176709), false)
			end

			if v21 and not __wf_atom_7e8ad928(gRegion) then
				for i = 1, #_T.QuestResetVars do
					_T[_T.QuestResetVars[i]] = nil
				end

				_T.QuestResetVars = {}
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
					print("No local player yet, and this is kinda important")
					_T.questInfo = nil
					_G.questInfo = nil
					return "", false
				else
					local v22 = fn25()

					if v22 or not gGameRules:InDojo() then
						if v22 then
							print("Running RunOnPlayerSpawnedScriptsAfterIntro")
							gGameRules:RunOnPlayerSpawnedScriptsAfterIntro(__wf_atom_eab484a7)
						elseif not fn20() and gGameRules:IsA(__wf_atom_311a7128) then
							gGameRules:__wf_atom_28f5b367(__wf_atom_eab484a7)
						end

						local v23 = fn21()

						if not __wf_atom_7e8ad928(v23) then
							v23:Build()
						end
					end
				end
			end
		end

		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("OnQuestsChanged", "")
		return v20, true
	end
end

function GetScanPointBones()
	return v10
end

function MaxScanPointBones()
	return #v10
end

function RayCastForScanPoints(object)
	local v20 = { WeakResource("/EE/Types/Physics/FullBody"), __wf_atom_4ebf67cb }
	local v21 = Vector()
	local v22 = __wf_atom_e97f3142(object:__wf_atom_4e50d390())
	local __wf_atom_74d951b0 = object:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	local v23 = __wf_atom_74d951b0 + v22 * 3
	return gRegion:__wf_atom_45b1070d(__wf_atom_74d951b0, v23, v20, nil, v21)
end

local function fn98(cat, object, object2)
	local v20 = {}
	local result = {}

	if cat == 0 then
		v20 = object:__wf_atom_ebdc4e6e()
	elseif cat == 3 then
		v20 = object:__wf_atom_4259c789()
	elseif cat == 2 then
		v20 = object:__wf_atom_4f67b86c()
	elseif cat == 1 then
		v20 = object:__wf_atom_20b04548()
	end

	if not __wf_atom_7e8ad928(v20) and #v20 > 0 then
		for i = 1, #v20 do
			if __wf_atom_7e8ad928(v20[i].mItemType) then
				continue
			end

			local __wf_atom_232fd31d = object2:__wf_atom_232fd31d(v20[i].mItemType)

			if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				table.insert(result, __wf_atom_232fd31d)
			end
		end
	end

	return result
end

function HasPvpCompatibleGear(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return false, ""
	end

	local v20 = false
	local v21 = false
	local v22 = ""
	local v23 = false

	for _, v24 in ipairs({
		{ Cat = 0, isSuit = true },
		{ Cat = 2, isSuit = false },
		{ Cat = 1, isSuit = false },
		{ Cat = 3, isSuit = false }
	}) do
		if v24.isSuit and not v20 or not (v24.isSuit or v21) then
			local v25 = fn98(v24.Cat, p, p2)

			for _, v26 in ipairs(v25) do
				if __wf_atom_7e8ad928(v26) or not v26:__wf_atom_50182074() then
					continue
				end

				if v24.Cat == 0 then
					v20 = true
				else
					v21 = true
				end

				break
			end
		end

		v23 = v20 and v21

		if v23 then
			break
		end
	end

	if v23 then
		return v23, v22
	end

	local v24 = ""

	if not v20 then
		v24 ..= "1x " .. Localize("/Lotus/Language/Menu/Global_ProductCategory_Suit", false)

		if not v21 then
			v24 ..= " + "
		end
	end

	if not v21 then
		v24 ..= "1x " .. Localize("/Lotus/Language/Menu/Loadout_PVPCompatibleWeapon", false)
	end

	v22 = Localize("/Lotus/Language/Menu/Loadout_PVPNeedCompatibleGear", { REQ_GEAR = v24 })
	return v23, v22
end

function AdjustBluerSize(object, p)
	local screenDimensions, v20 = module.GetScreenDimensions(object)
	object:__wf_atom_e57658c2(p, 14, screenDimensions)
	object:__wf_atom_e57658c2(p, 15, v20)
	object:OverrideMaterial(p, _G.UIMaterial_Bluer)
end

function GetInputCameraRotation(p, p2)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return 0, 0, 0
	end

	local v20 = not Engine.IsPlayingWithController() and 0.3 or 13 * __wf_atom_18a5d83b:Settings():__wf_atom_bbdf80e7(3)

	if __wf_atom_18a5d83b:Settings():__wf_atom_d52cb4f4() then
		p2 = -p2
	end

	return p * v20, p2 * v20, 0
end

function ViewConsoleProfile(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local fn5_2 = fn5()

	function fn5_2.ViewConsoleCallback(p2, p3)
		if not p2 then
			return
		end

		gMatchingService:__wf_atom_5d789280(p3)
	end

	if Engine.__wf_atom_84bb79c2() then
		gGameData:__wf_atom_2af00357(p, "ViewConsoleCallback")
	else
		gMatchingService:__wf_atom_5d789280(p)
	end
end

function GetCurrentPurchaseSource()
	local arsenalOpen = _T.ArsenalOpen or _T.ArsenalUpgradeOpen or _T.ModScreenOpen

	if _T.AppearancePreviewOpen then
		return 8
	end

	if arsenalOpen then
		return 4
	end

	if _T.ProfileIconSelectScreenOpen or _T.ProfileMenuOpen then
		return 5
	end

	if _T.OperatorScreenOpen then
		return 10
	end

	if _T.DecoratingPlayerShip or _T.CustomizingPlayerShip then
		return 11
	end

	if _T.CustomizingCrewship then
		return 12
	end

	if _T.UIStyleScreenOpen then
		return 13
	end

	if _T.HUDColorScreenOpen then
		return 14
	end

	if _T.ChatLinkOpen then
		return 15
	end

	if _T.InventoryScreenOpen then
		return 16
	end

	if _T.InStarChart then
		return 17
	end

	if _T.IncubatorOpen then
		return 19
	end

	if _T.ShowingOmegaDiscardScreen then
		return 20
	end

	if _T.KaitheCustomizationOpen then
		return 21
	end

	if _T.IsDuviriWeaponPurchase then
		return 22
	end

	if _T.IsUpdateScreenOpen then
		return 23
	end

	return 0
end

function AddMatchmakingLabelToPurchaseParams(p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_18a5d83b:IsCrossSave() then
		local v20 = p.mExtraPurchaseInfoJson == "" and {} or cjson.decode(p.mExtraPurchaseInfoJson)
		v20.MatchmakingBuildId = __wf_atom_18a5d83b:__wf_atom_a67dc305()
		p.mExtraPurchaseInfoJson = cjson.encode(v20)
	end
end

function AddMatchmakingLabelToSellOperation(object)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_18a5d83b:IsCrossSave() then
		object:SellItem(40, __wf_atom_18a5d83b:__wf_atom_a67dc305(), 1)
	end
end

fn3 = function(p, p2)
	return p - math.ceil(p * p2)
end

function GetPriceWithCoupon(p, p2)
	return fn3(p, p2)
end

fn2 = function(state)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.StoreItem) then
		return
	end

	state.Coupon = { mAmount = 0 }
	local __wf_atom_7e1cc3d4 = gGameData:__wf_atom_7e1cc3d4()

	for i = 1, #__wf_atom_7e1cc3d4 do
		local v20 = __wf_atom_7e1cc3d4[i]

		if
			not (Engine.__wf_atom_db2b0cee(v20.mExpiryDate) > 0)
			or not v20:__wf_atom_ed5aa8ca(state.StoreItem)
			or state.StoreItem:__wf_atom_836b9069()
		then
			continue
		end

		state.Coupon.mId = tostring(v20.mId)
		state.Coupon.mAmount = v20.mAmount / 100
		state.Coupon.mExpiry = v20.mExpiryDate.sec
		break
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
			local __wf_atom_9eeff5a1 = __wf_atom_964056fd:__wf_atom_9eeff5a1(state.StoreItem)
			local v20

			if __wf_atom_9eeff5a1 == nil then
				v20 = false
			else
				v20 = __wf_atom_9eeff5a1.mSlot == 17
			end

			if v20 then
				local __wf_atom_ff62ea3d = gGameData:__wf_atom_ff62ea3d()

				if __wf_atom_ff62ea3d and Engine.__wf_atom_db2b0cee(__wf_atom_ff62ea3d.mExpiry) > 0 then
					state.Coupon.mId = nil
					state.Coupon.mExpiry = __wf_atom_ff62ea3d.mExpiry.sec
					state.Coupon.mCouponType = __wf_atom_ff62ea3d.mCouponType
					state.IsExternalPlat = true

					if __wf_atom_ff62ea3d.mCouponType == 2 then
						state.Coupon.mDiscount = __wf_atom_ff62ea3d.mDiscount
						state.Coupon.mAmount = state.Coupon.mDiscount
					else
						state.Coupon.mDiscount = __wf_atom_ff62ea3d.mDiscount / 100
						state.Coupon.mAmount = state.Coupon.mDiscount
					end
				end
			end
		end
	end
end

function PopulateCouponInfo(p)
	return fn2(p)
end

local function fn99(object, p, p2)
	local result = {}
	local v20 = false
	local gGameData = gGameData
	local v21

	if not __wf_atom_7e8ad928(gGameData) then
		v21 = gGameData:GetInventory():__wf_atom_da43e3f3()

		for _ = 1, #v21 do
			if v21 == v6 then
				v20 = true
			end
		end
	end

	local v22 = { WeakResource("/Lotus/StoreItems/Types/StoreItems/SuitCustomizations/ColourPickerAccessibilityItemA") }

	if __wf_atom_7e8ad928(object) then
		return result, v20
	end

	local __wf_atom_caa82b8d = object:__wf_atom_caa82b8d(__wf_atom_77eb9145)

	for _, mStoreItem in ipairs(__wf_atom_caa82b8d) do
		__wf_atom_83c14687(0)

		if __wf_atom_7e8ad928(mStoreItem) then
			continue
		end

		local item = mStoreItem:GetItem()

		if __wf_atom_7e8ad928(item) or mStoreItem:__wf_atom_efa6f447() ~= 10 then
			continue
		end

		local alwaysAvailable = mStoreItem:AlwaysAvailable()

		if not __wf_atom_7e8ad928(v21) then
			for i = 1, #v21 do
				if v21[i].mItemType ~= item then
					continue
				end

				alwaysAvailable = true
				break
			end
		end

		if not (alwaysAvailable or (mStoreItem:ShowInMarket() or p2) and not p) then
			continue
		end

		local v23 = false

		if not _T.AccessibilityColorsAvailable then
			for i = 1, #v22 do
				if mStoreItem:IsA(v22[i]) then
					v23 = true
				end
			end
		end

		if _T.AccessibilityColorsAvailable or not v23 then
			table.insert(result, { mStoreItem = mStoreItem, mOwned = alwaysAvailable })
		end
	end

	return result, v20
end

function GetAvailableColourPickers(p, p2, p3)
	return fn99(p, p2, p3)
end

function GetRandomColorPalette(p, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v20 = {}
	local v21, v22 = fn99(p, true)
	local count = #v21

	if not v22 then
		count += 1
	end

	local v23 = __wf_atom_5784a397(1, count)
	local mStoreItem

	if v23 <= #v21 then
		v20 = Resource(v21[v23].mStoreItem:GetItem()):__wf_atom_8f6061c7()
		mStoreItem = v21[v23].mStoreItem
	end

	local result = v20 == nil and {} or v20

	if #result ~= 0 then
		return result, mStoreItem
	end

	local __wf_atom_8f6061c7 = object:__wf_atom_8f6061c7()

	for i = 3, #__wf_atom_8f6061c7, 5 do
		table.insert(result, __wf_atom_8f6061c7[i])
	end

	mStoreItem = nil
	return result, mStoreItem
end

local function fn100(p)
	return (math.min(fn93(p) + 1 + 0, MAX_PVP_LOADOUTS))
end

function GetPvPLoadoutCapacity(p)
	return fn100(p)
end

function GetRecipesOwned(object, list)
	local total2 = 0
	local v20 = fn66(list, object:__wf_atom_5b41f63b(), fn67)

	if not v20 then
		return total2
	end

	for i = v20[1], v20[2] do
		if list[i].count then
			total2 += list[i].count
		else
			total2 += 1
		end

		if v20[1] == v20[2] then
			break
		end
	end

	return total2
end

local function fn101(p, object, instance, list, p2)
	local v20 = 0
	local result = {}
	local isPackage = instance:IsPackage()
	local isA = instance:IsA(__wf_atom_bf37f5ca)
	local item = instance:GetItem()

	if isPackage then
		local __wf_atom_72915748 = instance:__wf_atom_72915748()
		local v21 = fn16(instance)
		local v22 = true
		local count = 0
		local count2 = 0
		local v23 = false
		local v24 = false

		for i = 1, #__wf_atom_72915748 do
			local mTypeName = __wf_atom_72915748[i].mTypeName

			if __wf_atom_7e8ad928(mTypeName) then
				continue
			end

			v22 = v22 and mTypeName:__wf_atom_efa6f447() == 30
			local v25 = fn101(p, object, mTypeName, list)
			local v26 = fn16(mTypeName)

			if fn62(mTypeName) and not mTypeName:IsPackage() then
				v23 = true

				if fn70(mTypeName, list, true) then
					v24 = true
				end
			end

			if v26 then
				continue
			end

			count += 1

			if v25 > 0 then
				count2 += 1
			end
		end

		local v25 = v22 and true or v24

		if instance:__wf_atom_bc269564() then
			local __wf_atom_380a0e2c = object:__wf_atom_380a0e2c()

			for i = 1, #__wf_atom_380a0e2c do
				if __wf_atom_380a0e2c[i] == instance:__wf_atom_5b41f63b() then
					return 1
				end
			end
		end

		if
			(instance:__wf_atom_bdbcec0a() == "" or instance:__wf_atom_bdbcec0a() == "9999" or not gGameData:__wf_atom_a1deff4d(instance:__wf_atom_bdbcec0a()) or v21)
			and (not v23 or v25)
			and (v25 or not (count > 0) or count2 ~= count)
		then
			local v26 = GetStoreItemPriceObject(instance, nil, list)

			if v26.UsePrice == 0 and v26.UseOriginalPrice > 0 then
				v20 = 1
			end
		else
			v20 = 1
		end
	else
		__wf_atom_83c14687()
		local __wf_atom_eca5585c = instance:__wf_atom_eca5585c()
		local v21

		if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_6317e6dc) then
			v21 = { __wf_atom_eca5585c }
		else
			local v22 = string.gsub(__wf_atom_eca5585c, "Bronze", "")
			local v23 = string.gsub(v22, "Silver", "")
			local v24 = string.gsub(v23, "Gold", "")
			local v25 = string.gsub(v24, "Platinum", "")
			v21 = {
				v25 .. "Bronze",
				v25 .. "Silver",
				v25 .. "Gold",
				v25 .. "Platinum"
			}
		end

		for i = 1, #v21 do
			local v22 = fn66(list, v21[i], fn67)

			if not v22 then
				continue
			end

			for j = v22[1], v22[2] do
				local ternary = module.Ternary(list[j].count ~= nil, list[j].count, 1)
				v20 += ternary

				if ternary > 0 then
					table.insert(result, { Count = ternary, fp = list[j].fp })
				end

				if v22[1] == v22[2] then
					break
				end
			end
		end
	end

	if v20 == 0 and isA then
		local __wf_atom_c5566ef8 = instance:__wf_atom_c5566ef8()

		if not __wf_atom_7e8ad928(__wf_atom_c5566ef8) and __wf_atom_c5566ef8:IsA(__wf_atom_899096f6) then
			local __wf_atom_fe84572e = object:__wf_atom_fe84572e()

			for i = 1, #__wf_atom_fe84572e do
				if
					__wf_atom_7e8ad928(__wf_atom_fe84572e[i])
					or __wf_atom_fe84572e[i].mItemType ~= __wf_atom_c5566ef8
				then
					continue
				end

				v20 = 1
				break
			end
		end
	end

	if v20 == 0 and not __wf_atom_7e8ad928(gGameData) then
		local v21

		if isA then
			v21 = instance:__wf_atom_c5566ef8()
		else
			v21 = item
		end

		if __wf_atom_7e8ad928(v21) or not (v21:IsA(v7) and gGameData:__wf_atom_e9d1e802(v21)) then
			if instance:IsA(__wf_atom_654b40cd) then
				local __wf_atom_987be644 = instance:__wf_atom_987be644()

				if __wf_atom_987be644 == 3 then
					v20 = math.max(0, object:__wf_atom_59af3769(3) - #object:__wf_atom_23e1a032(0))
				elseif __wf_atom_987be644 < 6 then
					v20 = math.max(0, object:__wf_atom_9ed9a33c(__wf_atom_987be644))
				end
			end
		else
			v20 = 1
		end
	end

	if
		not __wf_atom_7e8ad928(item)
		and item:IsA(WeakResource("/Lotus/Types/StoreItems/SlotItems/PvPLoadoutSlotItem"))
	then
		v20 = fn100(_T.ShowSyndicate)
	end

	if p2 then
		return result
	end

	return v20
end

function GetNumOwned(p, p2, p3, p4, p5)
	return (fn101(p, p2, p3, p4, p5))
end

function GetImageDimansionsFromName(object)
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	local v20 = string.find(__wf_atom_5b41f63b, "_")
	local v21 = string.find(__wf_atom_5b41f63b, "x", v20)
	local v22 = string.find(__wf_atom_5b41f63b, "%.", v21)
	local v23, v24

	if v20 and v21 and v22 and v21 < v22 and v20 < v21 then
		v23 = string.sub(__wf_atom_5b41f63b, v20 + 1, v21 - 1)
		v24 = string.sub(__wf_atom_5b41f63b, v21 + 1, v22 - 1)
	else
		v23 = 1
		v24 = 1
	end

	return v23, v24
end

function VerifyInventorySlots(object, p)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v20 = true
	local __wf_atom_59af3769 = object:__wf_atom_59af3769(p)
	local v21

	if p == 1 then
		v21 = #object:__wf_atom_ebdc4e6e()
	elseif p == 2 then
		v21 = #object:__wf_atom_4f67b86c() + #object:__wf_atom_20b04548() + #object:__wf_atom_4259c789()
	else
		print("Unsupported bin type!" .. tostring(p))
		return false
	end

	return not (__wf_atom_59af3769 - v21 < 0) and v20
end

function ShowInvalidBinError(p)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = module.Ternary(Engine.__wf_atom_fc67ba71(), 0, 1)
	dialogSettings.locString = "/Lotus/Language/Menu/Slot_InvalidBinError"
	dialogSettings.secondString = "/Lotus/Language/Menu/ContactSupport"

	if p ~= nil then
		dialogSettings:SetCallback(p)
	end

	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function HandleInvalidBinErrorResponse(p)
	if tonumber(p) ~= 4 and not Engine.__wf_atom_fc67ba71() then
		if Engine.__wf_atom_578fc9dd() then
			module.DoOpenWebBrowser("https://kf.qq.com/bills/200901selfsam4979ae6.html")
		else
			module.DoOpenWebBrowser("https://digitalextremes.zendesk.com")
		end
	end
end

function GetProductTimeLeft(p)
	if p.Sale == nil or p.Sale.mProductExpiryOverride == nil or p.Sale.mProductExpiryOverride.sec == "" then
		return Engine.__wf_atom_db2b0cee(p.StoreItem:__wf_atom_befa6dbf())
	end

	return Engine.__wf_atom_db2b0cee(p.Sale.mProductExpiryOverride)
end

function IsProductExpired(p)
	if p.Sale == nil or p.Sale.mProductExpiryOverride == nil or p.Sale.mProductExpiryOverride.sec == "" then
		return p.StoreItem:__wf_atom_befa6dbf() ~= 0
			and Engine.__wf_atom_db2b0cee(p.StoreItem:__wf_atom_befa6dbf()) <= 0
	end

	return Engine.__wf_atom_db2b0cee(p.Sale.mProductExpiryOverride) < 0
end

local v20 = {
	[0] = { Icon = "", Ability = "", Lens = "", Polarity = "" },
	[1] = {
		Icon = "FocusLensMadurai.png",
		Ability = "/Lotus/Upgrades/Focus/Attack/AttackFocusAbility",
		Lens = "MADURAI",
		Polarity = "/Lotus/Language/TennoWay/Madurai"
	},
	[2] = {
		Icon = "FocusLensVazarin.png",
		Ability = "/Lotus/Upgrades/Focus/Defense/DefenseFocusAbility",
		Lens = "VAZARIN",
		Polarity = "/Lotus/Language/TennoWay/Vazarin"
	},
	[3] = {
		Icon = "FocusLensNaramon.png",
		Ability = "/Lotus/Upgrades/Focus/Tactic/TacticFocusAbility",
		Lens = "NARAMON",
		Polarity = "/Lotus/Language/TennoWay/Naramon"
	},
	[4] = {
		Icon = "FocusLensZenurik.png",
		Ability = "/Lotus/Upgrades/Focus/Power/PowerFocusAbility",
		Lens = "ZENURIK",
		Polarity = "/Lotus/Language/TennoWay/Zenurik"
	},
	[5] = { Icon = "", Ability = "", Lens = "", Polarity = "" },
	[6] = { Icon = "", Ability = "", Lens = "", Polarity = "" },
	[7] = {
		Icon = "FocusLensUnairu.png",
		Ability = "/Lotus/Upgrades/Focus/Ward/WardFocusAbility",
		Lens = "UNAIRU",
		Polarity = "/Lotus/Language/TennoWay/Unairu"
	},
	[8] = { Icon = "", Ability = "", Lens = "", Polarity = "" },
	[12] = { Icon = "", Ability = "", Lens = "", Polarity = "" }
}

function GetPolarityInfoForLens(instance, flag, p)
	local polarityType = 0

	if __wf_atom_7e8ad928(flag) then
		flag = false
	end

	if __wf_atom_7e8ad928(p) then
		p = false
	end

	local uiMaterial_FocusLens = _G.UIMaterial_FocusLens

	if flag then
		uiMaterial_FocusLens = module.Ternary(p, _G.UIMaterial_FocusLensStoreDepth, _G.UIMaterial_FocusLensStore)
	end

	if __wf_atom_1ef90898(instance) then
		instance = Resource(instance)
	end

	local affix = ""
	local lensTier = 1

	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_b51b1fdb = instance:__wf_atom_b51b1fdb()

		for i = 1, math.min(#v20, #__wf_atom_b51b1fdb) do
			if not (__wf_atom_b51b1fdb[i] > 0) then
				continue
			end

			polarityType = i - 1
			break
		end

		for i = #v5, 1, -1 do
			if not instance:IsA(v5[i].Type) then
				continue
			end

			affix = v5[i].Affix
			lensTier = i
			break
		end
	end

	local v21 = v20[polarityType]
	local lensTag = "<" .. v21.Lens .. affix .. ">"
	return {
		PolarityTag = v21.Polarity,
		LensTag = lensTag,
		LensTier = lensTier,
		Material = uiMaterial_FocusLens[polarityType],
		PolarityType = polarityType
	}
end

function GetWayInfo(p)
	return v20[p]
end

function ClearOperatorLookAt(p, p2)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local ternary = module.Ternary(__wf_atom_7e8ad928(p2), __wf_atom_eab484a7:__wf_atom_04b7536b(), p2)

	if __wf_atom_7e8ad928(ternary) then
		return
	end

	local v21 = Symbol("GAME_R1_EYE1")
	local v22 = Symbol("GAME_L1_EYE1")
	local v23 = Symbol("GAME_C1_HEAD1")
	ternary:__wf_atom_c2377fc8(v21, false)
	ternary:__wf_atom_c2377fc8(v22, false)
	local operatorEyeTrack = _T.OperatorEyeTrack

	if operatorEyeTrack == nil then
		ternary:__wf_atom_c2377fc8(v23, false)
	else
		operatorEyeTrack.LerpAmount = math.max(0, operatorEyeTrack.LerpAmount - __wf_atom_084b3e93() * 3)

		if p then
			operatorEyeTrack.LerpAmount = 0
		end

		ternary:__wf_atom_2f0092a2(
			v23,
			(__wf_atom_9d2f097a(operatorEyeTrack.InitialRot, operatorEyeTrack.FinalRot, operatorEyeTrack.LerpAmount))
		)

		if operatorEyeTrack.LerpAmount == 0 then
			ternary:__wf_atom_c2377fc8(v23, false)
		end
	end
end

function UpdateOperatorLookAt(object, p, p2)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local ternary = module.Ternary(__wf_atom_7e8ad928(p2), __wf_atom_eab484a7:__wf_atom_04b7536b(), p2)

	if __wf_atom_7e8ad928(ternary) then
		return
	end

	local v21 = Symbol("GAME_R1_EYE1")
	local v22 = Symbol("GAME_R1_EYE1")
	local v23 = Symbol("GAME_L1_EYE1")
	local v24 = Symbol("GAME_C1_HEAD1")

	if _T.OperatorEyeTrack == nil then
		_T.OperatorEyeTrack = {
			X = __wf_atom_10cd16b2(0, 0.15),
			Y = __wf_atom_10cd16b2(0, 0.15),
			InitialRot = ternary:__wf_atom_8e4cf043(v21),
			FinalRot = Rotation(),
			LerpAmount = 0
		}
		_T.OperatorEyeTrack.InitialRot.pitch = _T.OperatorEyeTrack.InitialRot.pitch - 12

		if not __wf_atom_7e8ad928(_T.defaultOperatorRot) then
			_T.OperatorEyeTrack.InitialRot.heading = _T.OperatorEyeTrack.InitialRot.heading - _T.defaultOperatorRot.heading
		end
	end

	local gameCamera = gRegion:GetGameCamera()
	local x = object:__wf_atom_79258be8()

	if p ~= nil then
		x = p.x
	end

	local y = object:__wf_atom_7c4b8de8()

	if p ~= nil then
		y = p.y
	end

	local v25 = x / object:__wf_atom_d5a50cb5() * 2 - 1
	local v26 = y / object:__wf_atom_c4f6543f() * 2 - 1
	local v27 = v25 + Noise(Time() * 0.1) * 0.1
	local v28 = v26 + Noise(7 + Time() * 0.1) * 0.1
	_T.OperatorEyeTrack.X:__wf_atom_09294a87(v27)
	_T.OperatorEyeTrack.Y:__wf_atom_09294a87(v28)
	_T.OperatorEyeTrack.X:Update(__wf_atom_084b3e93())
	_T.OperatorEyeTrack.Y:Update(__wf_atom_084b3e93())
	local v29 = Vector(
		_T.OperatorEyeTrack.X:__wf_atom_9e368823() * 0.3,
		0.025 + _T.OperatorEyeTrack.Y:__wf_atom_9e368823() * 0.1,
		0
	)

	if not __wf_atom_7e8ad928(_T.defaultOperatorRot) then
		v29 = __wf_atom_9341614d(v29, _T.defaultOperatorRot)
	end

	local v30 = gameCamera:GetPosition() - v29
	local __wf_atom_1c374cc9 = ternary:__wf_atom_1c374cc9(v21)
	local v31 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, v30)

	if not __wf_atom_7e8ad928(_T.defaultOperatorRot) then
		v31.heading -= _T.defaultOperatorRot.heading
	end

	local v32 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, v30)

	if not __wf_atom_7e8ad928(_T.defaultOperatorRot) then
		v32.heading -= _T.defaultOperatorRot.heading
	end

	v32.heading = __wf_atom_421b01aa(v32.heading, -10, 10)
	ternary:__wf_atom_5372d35c(v22, v32)
	ternary:__wf_atom_5372d35c(v23, v32)
	ternary:__wf_atom_c2377fc8(v22, true)
	ternary:__wf_atom_c2377fc8(v23, true)
	ternary:__wf_atom_c2377fc8(v24, true)
	v31.pitch -= 15
	_T.OperatorEyeTrack.LerpAmount = math.min(1, _T.OperatorEyeTrack.LerpAmount + __wf_atom_084b3e93())
	local finalRot = __wf_atom_9d2f097a(_T.OperatorEyeTrack.InitialRot, v31, _T.OperatorEyeTrack.LerpAmount)
	_T.OperatorEyeTrack.FinalRot = finalRot
	ternary:__wf_atom_2f0092a2(v24, finalRot)

	if not __wf_atom_7e8ad928(_T.TennoSpeaking) then
		ternary:__wf_atom_f7e4d343(_T.TennoSpeaking)
	end
end

function IsDeluxeSkin(object)
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	return (string.find(__wf_atom_5b41f63b, "Deluxe") ~= nil or string.find(__wf_atom_5b41f63b, "ExcaliburProtoSuit") ~= nil or string.find(__wf_atom_5b41f63b, "NyxNemesisSuit") ~= nil)
		and string.find(__wf_atom_5b41f63b, "Operator") == nil
end

function SetupThreeColorText(object, p, p2, p3, p4, _, p5, p6, p7, p8)
	object:__wf_atom_50d60589(p2, 36, p)
	object:__wf_atom_50d60589(p3, 36, p)
	__wf_atom_86cbd68d(object, p2 .. ".setVertexColors", p4, p4, p5, p5)
	local _, v21 = module.GetRootBasedPosition(object, p3)
	local v22 = v21 + object:__wf_atom_5e6e15c8(p3, 15) / 2
	local y = module.TransformPixelToViewportCoordinates(object, {
		x = 0,
		y = v22 + p6
	}).y
	local __wf_atom_d5a50cb5 = object:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = object:__wf_atom_c4f6543f()

	if
		(__wf_atom_d5a50cb5 < object:__wf_atom_97cd8326() or __wf_atom_c4f6543f < object:__wf_atom_54eeda24())
		and not Engine.__wf_atom_fc67ba71()
	then
		object:__wf_atom_97cd8326()
		__wf_atom_c4f6543f = object:__wf_atom_54eeda24()
	end

	local v23 = p7 / __wf_atom_c4f6543f
	local v24 = p8 / __wf_atom_c4f6543f
	object:OverrideMaterial(p3, _G.UIMaterial_VerticalVisibilityRangeText)
	object:__wf_atom_1ca72041(p3, "VisibilityCenter", y, 0, 0, 0)
	object:__wf_atom_1ca72041(p3, "VisibilitySize", v23, 0, 0, 0)
	object:__wf_atom_1ca72041(p3, "VisibilityFadeSize", v24, 0, 0, 0)
end

function SetEnergyToTeamColor(object, p)
	local v21 = Color(232, 145, 58, 255)

	if p == 2 then
		v21 = Color(62, 196, 221, 255)
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v22 = {}
	table.insert(v22, __wf_atom_d2b2176d:__wf_atom_28224c27(1))
	table.insert(v22, __wf_atom_d2b2176d:__wf_atom_28224c27(0))
	table.insert(v22, __wf_atom_d2b2176d:__wf_atom_28224c27(5))
	table.insert(v22, __wf_atom_d2b2176d:__wf_atom_e55d02aa())

	for _, v23 in ipairs(v22) do
		if __wf_atom_7e8ad928(v23) then
			continue
		end

		local __wf_atom_eb82ab1f = v23:__wf_atom_eb82ab1f()
		local colors = __wf_atom_eb82ab1f:GetColors(0)
		colors:SetColor(6, v21)
		colors:__wf_atom_59cc106e(6, true)
		__wf_atom_eb82ab1f:__wf_atom_2754430f(0, colors)

		if v23:IsA(__wf_atom_d98e64fe) then
			local colors2 = __wf_atom_eb82ab1f:GetColors(2)
			colors2:SetColor(6, v21)
			colors2:__wf_atom_59cc106e(6, true)
			__wf_atom_eb82ab1f:__wf_atom_2754430f(2, colors2)
		end

		v23:SetCustomization(__wf_atom_eb82ab1f)
	end
end

function ClearTransmissionQueue()
	_T.QueuedTransmissions = {}
end

local function fn102(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_cb425ff5) then
		return nil
	end

	if Engine.__wf_atom_6f25c160() and instance:__wf_atom_836b9069() and instance:__wf_atom_d8410890() ~= "" then
		return instance:__wf_atom_d8410890()
	end

	if Engine.__wf_atom_8dbe8185() and instance:__wf_atom_322fbca4() ~= "" then
		return instance:__wf_atom_322fbca4()
	end

	return instance:__wf_atom_bdbcec0a()
end

function GetProductId(p)
	return (fn102(p))
end

local function fn103(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	if
		not object:__wf_atom_836b9069()
		or Engine.__wf_atom_6f25c160() and object:__wf_atom_d8410890() ~= ""
		or not Engine.__wf_atom_6f25c160() and object:__wf_atom_d8410890() ~= ""
	then
		return nil
	end

	if object:IsPackage() then
		if Engine.__wf_atom_fc67ba71() and object:__wf_atom_d8410890() == "" then
			return "MARKET"
		end

		if Engine.__wf_atom_fc67ba71() and object:__wf_atom_d8410890() ~= "" then
			return "UNAVAILABLE"
		end
	end

	if Engine.__wf_atom_6f25c160() then
		return "EXTERNAL"
	end

	if object:__wf_atom_8c904c63() > 0 and (Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_578fc9dd()) then
		return "MARKET"
	end

	return "UNAVAILABLE"
end

function CheckSteamPurchaseAvailability(p)
	return (fn103(p))
end

local function fn104(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local v21 = fn102(p)

	if v21 == "" or v21 == "9999" then
		return false
	end

	local __wf_atom_1d87f188 = gGameData:__wf_atom_1d87f188(v21)
	return __wf_atom_1d87f188.productId == v21 and __wf_atom_1d87f188.listPrice.formatted ~= ""
end

function IsExternalProduct(p)
	return (fn104(p))
end

function GetTreasureName(object, object2, object3, p)
	if __wf_atom_7e8ad928(object3) or __wf_atom_7e8ad928(object2) then
		return p
	end

	local __wf_atom_e774be61 = object2:__wf_atom_e774be61()

	if not (#__wf_atom_e774be61 > 0) then
		return p
	end

	local v21 = ""
	local v22 = false

	if object3.mSockets ~= nil then
		for i = 1, #__wf_atom_e774be61 do
			local v23 = not object3:__wf_atom_7c97c0aa(i - 1)
			v21 ..= module.Ternary(v23, "<TREASURE_GEM_OUTLINE>", "<TREASURE_GEM>") .. ""
			v22 = v22 or not v23
		end
	end

	if not v22 then
		return p
	end

	local v23

	if __wf_atom_7e8ad928(object) then
		v23 = Localize(v21, true)
	else
		v23 = object:__wf_atom_8e9ac384(v21, true)
	end

	p ..= "   " .. v23
	return p
end

function GetSecondCount()
	return (math.floor((gGameRules:__wf_atom_91a79d39())))
end

local function fn105()
	return (math.floor(gGameRules:__wf_atom_91a79d39() / 60))
end

function GetMinuteCount()
	return (fn105())
end

local function fn106()
	return (math.floor(gGameRules:__wf_atom_91a79d39() / 3600))
end

function GetHourCount()
	return (fn106())
end

local function fn107()
	return (math.floor(gGameRules:__wf_atom_91a79d39() / 86400))
end

function GetDayCount()
	return (fn107())
end

function GetWeekCount()
	return (math.floor(gGameRules:__wf_atom_91a79d39() / 604800))
end

function RollForNightmareMutators(p)
	local v21 = {}
	local missionType = p.missionType

	if missionType == 18 then
		return { 9, "/Lotus/Language/Menu/NightmareModeName" }
	end

	local v22 = {}
	table.insert(v22, { 1, "/Lotus/Language/Game/NightmareModeVampire" })
	table.insert(v22, { 3, "/Lotus/Language/Game/NightmareModeEnergyDrain" })
	table.insert(v22, { 6, "/Lotus/Language/Game/NightmareModeExplodingCorpses" })

	if
		missionType ~= 8
		and missionType ~= 9
		and missionType ~= 2
		and missionType ~= 33
		and missionType ~= 4
		and missionType ~= 3
		and missionType ~= 0
		and missionType ~= 34
		and missionType ~= 35
		and missionType ~= 36
	then
		table.insert(v22, { 0, "/Lotus/Language/Game/NightmareModeTimer" })
	end

	if missionType ~= 14 then
		table.insert(v22, { 4, "/Lotus/Language/Game/NightmareModeNoShield" })
	end

	local v23 = __wf_atom_04d7eaaa()
	local v24 = __wf_atom_3e61816b(__wf_atom_ef9aeb11((tostring(p.location))))
	__wf_atom_2e624c2f(v24, fn107() % 365)
	table.insert(v21, v22[__wf_atom_c08f5a0e(1, #v22)])

	if __wf_atom_c08f5a0e(0, 2) == -1 then
		table.insert(v21, { 2, "/Lotus/Language/Game/NightmareModeNoHud" })
	end

	if __wf_atom_c08f5a0e(0, 3) == 1 then
		table.insert(v21, { 8, "/Lotus/Language/Game/NightmareModeLowGrav" })
	end

	__wf_atom_01bfe5c4(v23)
	return v21
end

local function fn108()
	local result = {}
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return result
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return result
	end

	local upgrades = inventory:GetUpgrades()
	local __wf_atom_16cdad3a = __wf_atom_16cdad3a

	for i = 1, #upgrades do
		local mItemType = upgrades[i].mItemType

		if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(__wf_atom_16cdad3a) then
			continue
		end

		table.insert(result, upgrades[i])
	end

	return result
end

function GetOmegaCards()
	return fn108()
end

local function fn109()
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	return not __wf_atom_7e8ad928((gGameData:GetInventory())) and #fn108() > fn()
end

function IsOverOmegaLimit()
	return fn109()
end

fn = function()
	local v21

	if __wf_atom_7e8ad928(gGameData) then
		return 0
	else
		local inventory = gGameData:GetInventory()
		local __wf_atom_a04e4a53 = gGameData:__wf_atom_a04e4a53()
		v21 = inventory:__wf_atom_59af3769(4)

		if __wf_atom_a04e4a53 >= 30 then
			return v21 + 30
		end
	end

	return v21
end

function GetMaxOmegaCapacity()
	return fn()
end

local function fn110(_, _)
	return false
end

function IsCurrentSuitInfestedEnoughToHeal(p)
	return fn110(p, 1)
end

function IsCurrentSuitFullyInfested(p)
	return fn110(p, 7)
end

function ShowTradeUI(gGameData2)
	if Engine.__wf_atom_578fc9dd() then
		return false
	end

	if __wf_atom_7e8ad928(gGameData2) then
		gGameData2 = gGameData

		if __wf_atom_7e8ad928(gGameData2) then
			return false
		end
	end

	if gGameData2:__wf_atom_3a4ef806() then
		return false
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return false
	end

	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	return not (__wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_e55d02aa:__wf_atom_5d7344fc())
end

function UpdateScannerInfo(object, object2)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) then
		object2:__wf_atom_9527dd63(__wf_atom_084b3e93(), object, false, object:__wf_atom_1cc42808())
		local __wf_atom_398433a4 = object2:__wf_atom_398433a4()

		if not __wf_atom_7e8ad928(__wf_atom_398433a4) then
			local v21 = Distance(object:__wf_atom_d2b2176d():__wf_atom_74d951b0(), object:EyePosition())
			local v22 = math.floor(v21)
			local v23 = math.floor(v21 * 10 - v22 * 10)
			__wf_atom_398433a4:Execute("UpdateRangeFinder", tostring(v22) .. "," .. tostring(v23))
		end
	end
end

function SetFlashlightDimness(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(WeakResource("/Lotus/Types/Player/PlayerFlashLight"))

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_3c9b2a9c(p)
		end
	end
end

function GetRewardTextForMastery(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return ""
	end

	local ternary = module.Ternary(p2 ~= nil, p2, "#FFFFFF")
	local ternary2 = module.Ternary(p3 ~= nil, p3, "#FFFFFF")
	local v21 = "<p><font color=\"" .. ternary2 .. "\">"

	if p == 2 then
		v21 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpTrading", false) .. "<br>"
	elseif p == 3 then
		v21 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpSyndicates", false) .. "<br>"
	elseif p == 5 or p == 10 then
		v21 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpExtraDroneSlot", false, {
			OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
		}) .. "<br>"
	end

	if p == 30 then
		v21 = ((((((v21 .. object:__wf_atom_8e9ac384("/Lotus/Language/Blessings/MasteryRankUpBlessingDesc", false) .. "<br>") .. TitleCase(object:__wf_atom_8e9ac384(
			"/Lotus/Language/Emotes/Rank30EmoteName",
			false
		) .. " (" .. object:__wf_atom_8e9ac384("/Lotus/Language/Emotes/Emote", false) .. ")") .. "<br>") .. TitleCase(object:__wf_atom_8e9ac384(
			"/Lotus/Language/ShipDecorations/HoodOrnament_MR30Name",
			false
		)) .. "<br>") .. TitleCase(object:__wf_atom_8e9ac384("/Lotus/Language/Cosmetics/TrueMasterEmoji", false)) .. "<br>") .. "<font color=\"" .. ternary .. "\">+3</font> " .. object:__wf_atom_8e9ac384(
			"/Lotus/Language/Consumables/FormaUmbra",
			false
		) .. "<br>") .. "<font color=\"" .. ternary .. "\">+15</font> " .. TitleCase(object:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/Loadout_Slot",
			false
		)) .. "<br>") .. "<font color=\"" .. ternary .. "\">+30</font> " .. TitleCase(object:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ItemInventory_SlotsRandomMod",
			false
		)) .. "<br>"
	elseif p % 2 == 0 then
		v21 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_LoadOutSlot", false, {
			OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
		}) .. "<br>"
	end

	local v22 = v21 .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpStanding", true, {
		NUM = 500,
		OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
		CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
	}) .. "<br>"

	if __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_e9779a2d() >= 2 then
		v22 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpFocusCapacity", true, {
			NUM = 1000,
			OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
		}) .. "<br>"
	end

	local v23

	if p <= 30 then
		v23 = v22 .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpCapacity", false, {
			OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
		}) .. "<br>"
	else
		v23 = v22 .. object:__wf_atom_8e9ac384("/Lotus/Language/MasteryTest/MasteryRankUp_LegendaryCore", true, {
			NUM = 1,
			OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
			CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
		}) .. "<br>"
	end

	return (v23 .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/EndOfMatch_MasteryRankUpReactant", true, {
		NUM = 50,
		OPEN_COLOR = "</font><font color=\"" .. ternary .. "\">",
		CLOSE_COLOR = "</font><font color=\"" .. ternary2 .. "\">"
	})) .. "</font></p>"
end

local function fn111(p, id, object)
	local v21 = {}

	if p == 0 or p == 2 then
		if id == 0 then
			return (object:__wf_atom_ebdc4e6e())
		elseif id == 3 then
			return (object:__wf_atom_4259c789())
		elseif id == 2 then
			return (object:__wf_atom_4f67b86c())
		elseif id == 1 then
			return (object:__wf_atom_20b04548())
		end

		return v21
	else
		if p ~= 1 then
			return v21
		end

		if id ~= 0 then
			return (object:__wf_atom_1273f04d())
		end

		local result = object:__wf_atom_db1ae7f4() or {}
		local __wf_atom_260a9632 = object:__wf_atom_260a9632()

		for i = 1, #__wf_atom_260a9632 do
			table.insert(result, __wf_atom_260a9632[i])
		end

		local __wf_atom_9ddc0f59 = object:__wf_atom_9ddc0f59()

		for i = 1, #__wf_atom_9ddc0f59 do
			if not (__wf_atom_9ddc0f59[i].mDetails.mStatus ~= 3 and __wf_atom_9ddc0f59[i].mDetails.mStatus ~= 0 and __wf_atom_9ddc0f59[i].mDetails.mStatus ~= 1) then
				continue
			end

			table.insert(result, __wf_atom_9ddc0f59[i])
		end

		return result
	end
end

local function fn112(p, p2, p3, p4, object)
	local v21 = {
		{ IsSentinel = false, Id = 0 },
		{ IsSentinel = false, Id = 2 },
		{ IsSentinel = false, Id = 3 }
	}
	local v22

	if p3 == 0 or p3 == 2 then
		table.insert(v21, 3, { IsSentinel = false, Id = 1 })
		v22 = 4
	else
		v22 = 3
	end

	if p2 ~= nil then
		table.insert(v21, { IsSentinel = true, Id = 0 })
		table.insert(v21, { IsSentinel = true, Id = 2 })
	end

	local v23 = not __wf_atom_7e8ad928(object) and "<p>" or nil
	local mItemTypes = {}

	for i = 1, #v21 do
		local ternary = module.Ternary(i == v22, "", "<br>")
		local ternary2 = module.Ternary(v21[i].IsSentinel, p2, p)

		if __wf_atom_7e8ad928(ternary2) then
			continue
		end

		local __wf_atom_b369d77f = ternary2:__wf_atom_b369d77f(v21[i].Id)

		if __wf_atom_b369d77f.mItemId:__wf_atom_8598f3a9() then
			local v24 = fn111(module.Ternary(v21[i].IsSentinel, 1, p3), v21[i].Id, p4)

			for j = 1, #v24 do
				if v24[j].mItemId ~= __wf_atom_b369d77f.mItemId then
					continue
				end

				table.insert(mItemTypes, v24[j].mItemType)

				if __wf_atom_7e8ad928(object) or v21[i].IsSentinel then
					break
				end

				local __wf_atom_232fd31d = object:__wf_atom_232fd31d(v24[j].mItemType)

				if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
					v23 ..= "<font color=\"#FloatingContent\">---" .. ternary .. "</font>"
					break
				end

				local v25 = v24[j].mXP == nil and 0
					or __wf_atom_c67f9605:__wf_atom_b4a75eaa(v24[j].mXP, v24[j].mItemType)
				v23 ..= "<font color=\"#FloatingContent\">" .. Localize(
					__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(),
					{}
				) .. " [" .. tostring(v25) .. "]" .. ternary .. "</font>"
				break
			end
		elseif v23 ~= nil and not v21[i].IsSentinel then
			v23 ..= "<font color=\"#FloatingContentHighlight\">" .. Localize("/Lotus/Language/Menu/Cosmetics_None", {}) .. ternary .. "</font>"
		end
	end

	if v23 ~= nil then
		v23 ..= "</p>"
	end

	return mItemTypes, v23
end

function GetPresetInfo(p, p2, p3, p4, p5)
	return fn112(p, p2, p3, p4, p5)
end

function GetClanEmblemPath(value)
	return "/Lotus/Interface/ClanEmblems/" .. (string.sub(value, -1) .. "/") .. value .. "_em.png"
end

function GetPersonalGoalProgress(data)
	local mCount = data.mCount
	local v21 = 0
	local mGoal = data.mGoal

	if not (data.mPersonal or data.mInvasion) then
		return mCount, v21, mGoal
	end

	mCount = data.mTag == Symbol("HeatFissure") and 0 or mCount
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		print("GetPersonalGoalProgress: profile or gamedata is nil")
	else
		local personalGoalProgress

		if #data.mClanGoal > 0 and gGameData:__wf_atom_5ff594a3() ~= "" then
			personalGoalProgress = gGameData:__wf_atom_8c97facd()
		else
			personalGoalProgress = gGameData:GetPersonalGoalProgress()
		end

		for i = 1, #personalGoalProgress do
			if tostring(personalGoalProgress[i].mId) ~= tostring(data.mId) then
				continue
			end

			local mBest

			if data.mBest then
				mBest = personalGoalProgress[i].mBest
			else
				if personalGoalProgress[i].mCount > data.mGoal and data.mBonusGoal > 0 then
					mGoal = data.mBonusGoal
				end

				mBest = personalGoalProgress[i].mCount
			end

			return mBest, personalGoalProgress[i].mBest, mGoal
		end

		return mCount, v21, mGoal
	end

	return mCount, v21, mGoal
end

function HasRelayReconstructionEnemy(data)
	_T.DebugElementalCarrier = string.lower(__wf_atom_9a2b0be4("LotusGameRules.ForceElementalCarrier"))

	if _T.DebugElementalCarrier ~= "" then
		return true, 0
	end

	if data == nil or not __wf_atom_7e8ad928(data.keyChainName) or data.missionType == 18 then
		return false
	end

	local __wf_atom_fa4a687e = __wf_atom_c67f9605:__wf_atom_fa4a687e()
	local gGameData = gGameData

	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	for _, mGoal in ipairs(gGameData:__wf_atom_92662866().mGoals) do
		if not (mGoal.mTag == __wf_atom_fa4a687e and Engine.__wf_atom_db2b0cee(mGoal.mActivation) < 0 and Engine.__wf_atom_db2b0cee(mGoal.mExpiry) > 0 and data.location ~= EMPTY_SYMBOL) then
			continue
		end

		local __wf_atom_d5226f21 = fn21():__wf_atom_d5226f21(data.location)

		if __wf_atom_d5226f21.nodeType == 7 or data.location == Symbol(mGoal.mNode) then
			return false
		end

		local region = __wf_atom_d5226f21.region
		local mRegions = mGoal.mRegions

		for _, mRegion in ipairs(mRegions) do
			if region == mRegion then
				return true, 1
			end
		end

		break
	end

	return false
end

function ApplyWeaponRestriction(object, className)
	if not gRegion:IsMaster() or (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(className)) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local exclusiveWeaponSlot = 0

	while __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_35a10d3c(0)) do
		Sleep(0)
	end

	for _, v21 in pairs({ 0, 1, 5 }) do
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(v21)

		if __wf_atom_7e8ad928(__wf_atom_28224c27) or not __wf_atom_28224c27:IsA(className) then
			__wf_atom_d2b2176d:__wf_atom_e704ac94(v21)
			gRegion:__wf_atom_dd1e4d10(__wf_atom_28224c27)

			if v21 == 5 then
				__wf_atom_d2b2176d:__wf_atom_ec33d862(7)
			end
		else
			exclusiveWeaponSlot = v21
		end
	end

	__wf_atom_d2b2176d:Equip(exclusiveWeaponSlot, 0, 2)
	_T.ExclusiveWeaponSlot = exclusiveWeaponSlot
end

function ApplyModlessLoadout(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	gGameRules:__wf_atom_6e1120ec(true)

	local function fn113(object2)
		local v21 = WeakResource("/SF/Types/Game/SentinelPrecept")

		for i = 0, 11 do
			local __wf_atom_28224c27 = object2:__wf_atom_28224c27(i)

			if __wf_atom_7e8ad928(__wf_atom_28224c27) then
				continue
			end

			local count = 0

			while not __wf_atom_7e8ad928(__wf_atom_28224c27:__wf_atom_b9a1f18c(count)) do
				local __wf_atom_b9a1f18c = __wf_atom_28224c27:__wf_atom_b9a1f18c(count)
				local isA = __wf_atom_b9a1f18c:IsA(__wf_atom_58a409f1)
				local isA2 = __wf_atom_b9a1f18c:IsA(v21)
				local v22 = __wf_atom_b9a1f18c:IsA(__wf_atom_abf506db) and __wf_atom_b9a1f18c:__wf_atom_06f3cb74() > 0

				if isA then
					local v23 = isA2 and __wf_atom_b9a1f18c:__wf_atom_57ad19ea()

					if v23 then
						v23:__wf_atom_30a887ab(true)
						v23:DeactivateAbility()
					end

					__wf_atom_28224c27:RemoveUpgrade(__wf_atom_b9a1f18c, true)
				else
					if v22 then
						__wf_atom_28224c27:UnapplyUpgrade(__wf_atom_b9a1f18c)
					end

					count += 1
				end
			end
		end
	end

	fn113(__wf_atom_d2b2176d)
	local __wf_atom_75052211 = gGameRules:__wf_atom_75052211(__wf_atom_6dcad331, object)

	for _, v21 in pairs(__wf_atom_75052211) do
		gRegion:__wf_atom_dd1e4d10(v21)
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_70d605af(__wf_atom_7470861b:__wf_atom_2bf72530())
	local v21 = nil
	local __wf_atom_0d9c1a58 = object:__wf_atom_0d9c1a58()

	if
		not __wf_atom_7e8ad928(__wf_atom_0d9c1a58)
		and __wf_atom_0d9c1a58:__wf_atom_a4299765().mPetType ~= 5
		and gGameRules:__wf_atom_ee9e394b()
	then
		local v22 = false

		while __wf_atom_7e8ad928(v21) and not v22 do
			v22 = __wf_atom_0d9c1a58:__wf_atom_a4299765():__wf_atom_daf48817()
				and not gGameRules:__wf_atom_b00ff4d4(
					object:__wf_atom_818ea3a7(),
					true,
					__wf_atom_0d9c1a58:__wf_atom_a4299765():__wf_atom_daf48817(),
					true
				)
			v21 = __wf_atom_d2b2176d:__wf_atom_1915cc84()

			if p ~= true and p ~= nil then
				break
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v21) then
			fn113(v21:__wf_atom_d2b2176d())
		end
	end

	if not __wf_atom_7e8ad928(v21) then
		local __wf_atom_7470861b2 = v21:__wf_atom_7470861b()
		__wf_atom_7470861b2:__wf_atom_70d605af(__wf_atom_7470861b2:__wf_atom_2bf72530())
	end
end

function IsNoModsMode()
	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_dd9a0bb8) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

		if
			not __wf_atom_7e8ad928(__wf_atom_72fc675e)
			and (__wf_atom_72fc675e.goalTag == Symbol("NoMods") or __wf_atom_72fc675e.goalTag == Symbol("WaterFight"))
		then
			return true
		end
	end

	return false
end

function ToggleAvatarAuras(p, p2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_75052211 = gGameRules:__wf_atom_75052211(__wf_atom_6dcad331, p)

	for _, v21 in pairs(__wf_atom_75052211) do
		if p2 then
			v21:__wf_atom_a8319c98()
		else
			v21:__wf_atom_ce032418()
		end
	end
end

function IsFirstTimeInNode(object)
	return not __wf_atom_7e8ad928(object) and object:__wf_atom_a4299765().mIsFirstTimeInNode
end

function SetEquippingGearItem(object, p)
	if __wf_atom_7e8ad928(_T.PendingEquippingGearItem) then
		_T.PendingEquippingGearItem = {}
	end

	_T.PendingEquippingGearItem[object:__wf_atom_18aa6e58()] = p
end

function IsEquippingGearItem(object)
	if __wf_atom_7e8ad928(_T.PendingEquippingGearItem) then
		return false
	end

	return _T.PendingEquippingGearItem[object:__wf_atom_18aa6e58()]
end

local function fn113(object)
	if object == nil then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if __wf_atom_7e8ad928(__wf_atom_eab484a7) or not __wf_atom_eab484a7:__wf_atom_ce4e872c() then
			object = gRegion:__wf_atom_c4f78a8f()
		else
			object = __wf_atom_eab484a7:__wf_atom_dd7246c7()
		end
	end

	if _T.CachedRoomTriggers == nil then
		_T.CachedRoomTriggers = {}

		for i = 1, #SHIP_ROOMS do
			local name = tostring(SHIP_ROOMS[i].Name)
			_T.CachedRoomTriggers[name] = gRegion:__wf_atom_2226b35c(SHIP_ROOMS[i].Name)
		end

		for i = 1, #APARTMENT_ROOMS do
			local name = tostring(APARTMENT_ROOMS[i].Name)
			_T.CachedRoomTriggers[name] = gRegion:__wf_atom_2226b35c(APARTMENT_ROOMS[i].Name)
		end
	end

	local position = object:GetPosition()
	local v21 = false

	for i = 1, #SHIP_ROOMS do
		local cachedRoomTrigger = _T.CachedRoomTriggers[tostring(SHIP_ROOMS[i].Name)]

		for j = 1, #cachedRoomTrigger do
			local __wf_atom_ee03557f = cachedRoomTrigger[j]:__wf_atom_ee03557f()
			local __wf_atom_0aa77159 = cachedRoomTrigger[j]:__wf_atom_0aa77159()

			if
				__wf_atom_0aa77159.x <= position.x
				and __wf_atom_0aa77159.y <= position.y
				and __wf_atom_0aa77159.z <= position.z
				and position.x <= __wf_atom_ee03557f.x
				and position.y <= __wf_atom_ee03557f.y
				and position.z <= __wf_atom_ee03557f.z
			then
				return SHIP_ROOMS[i].Name, SHIP_ROOMS[i].LocTag, v21
			end
		end
	end

	for i = 1, #APARTMENT_ROOMS do
		local cachedRoomTrigger = _T.CachedRoomTriggers[tostring(APARTMENT_ROOMS[i].Name)]

		for j = 1, #cachedRoomTrigger do
			local __wf_atom_ee03557f = cachedRoomTrigger[j]:__wf_atom_ee03557f()
			local __wf_atom_0aa77159 = cachedRoomTrigger[j]:__wf_atom_0aa77159()

			if
				__wf_atom_0aa77159.x <= position.x
				and __wf_atom_0aa77159.y <= position.y
				and __wf_atom_0aa77159.z <= position.z
				and position.x <= __wf_atom_ee03557f.x
				and position.y <= __wf_atom_ee03557f.y
				and position.z <= __wf_atom_ee03557f.z
			then
				return APARTMENT_ROOMS[i].Name, APARTMENT_ROOMS[i].LocTag, true
			end
		end
	end

	return OUTSIDE_THE_SHIP_ROOM.Name, OUTSIDE_THE_SHIP_ROOM.LocTag, false
end

function GetShipDecoRoom(p)
	return fn113(p)
end

function GetDecoArea(p)
	for i = 1, #SHIP_ROOMS do
		if SHIP_ROOMS[i].Name == p then
			return DECO_AREA_SHIP
		end
	end

	for i = 1, #APARTMENT_ROOMS do
		if APARTMENT_ROOMS[i].Name == p then
			return DECO_AREA_APARTMENT
		end
	end

	return DECO_AREA_UNKNOWN
end

function GetShipDecoAnchor(p, p2, object)
	if p2 then
		if __wf_atom_7e8ad928(_T.apartmentDecoAncor) then
			_T.apartmentDecoAncor = {}
		end

		if __wf_atom_7e8ad928(_T.apartmentDecoAncor[p]) then
			_T.apartmentDecoAncor[p] = gRegion:__wf_atom_0a6a5887(Symbol(tostring(p) .. "Anchor"))
		end

		return _T.apartmentDecoAncor[p]
	else
		if __wf_atom_7e8ad928(_T.shipDecoOrbiterAnchor) then
			_T.shipDecoLisetAnchor = gRegion:__wf_atom_0a6a5887(Symbol("PlayerShipDecosAnchorLiset"))
			local v21 = Vector(9999, 9999, 9999)
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(LISET_ROOM.Name)

			for i = 1, #__wf_atom_2226b35c do
				local __wf_atom_ee03557f = __wf_atom_2226b35c[i]:__wf_atom_ee03557f()
				local __wf_atom_0aa77159 = __wf_atom_2226b35c[i]:__wf_atom_0aa77159()
				local v22 = __wf_atom_ee03557f - __wf_atom_0aa77159

				if not (Dot(v22, v22) < Dot(v21, v21)) then
					continue
				end

				_T.shipDecoLisetDoorwayBoundsMax = __wf_atom_ee03557f
				_T.shipDecoLisetDoorwayBoundsMin = __wf_atom_0aa77159
				v21 = v22
			end

			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerShipDecosAnchorOrbiter"))

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				local all = gRegion:FindAll(__wf_atom_e1d1671b)
				local shipDecoOrbiterAnchor

				if not (__wf_atom_7e8ad928(all) or not (#all > 0)) then
					shipDecoOrbiterAnchor = all[1]

					for i = 2, #all do
						if all[i]:__wf_atom_18aa6e58() < shipDecoOrbiterAnchor:__wf_atom_18aa6e58() then
							shipDecoOrbiterAnchor = all[i]
						end
					end
				end

				_T.shipDecoOrbiterAnchor = shipDecoOrbiterAnchor
			else
				_T.shipDecoOrbiterAnchor = __wf_atom_0a6a5887
			end
		end

		if p == LISET_ROOM.Name then
			if not fn4() then
				return _T.shipDecoLisetAnchor
			end

			local position

			if object.pos == nil then
				position = object:GetPosition()
			else
				position = _T.shipDecoLisetAnchor:__wf_atom_2d4eb23c(EMPTY_SYMBOL, object.pos, object.rot)
			end

			if
				_T.shipDecoLisetDoorwayBoundsMin.x <= position.x
				and _T.shipDecoLisetDoorwayBoundsMin.y <= position.y
				and _T.shipDecoLisetDoorwayBoundsMin.z <= position.z
				and position.x <= _T.shipDecoLisetDoorwayBoundsMax.x
				and position.y <= _T.shipDecoLisetDoorwayBoundsMax.y
				and position.z <= _T.shipDecoLisetDoorwayBoundsMax.z
			then
				return nil
			end

			return _T.shipDecoLisetAnchor
		elseif p == OUTSIDE_THE_SHIP_ROOM.Name and not fn4() then
			return nil
		else
			return _T.shipDecoOrbiterAnchor
		end
	end
end

function ShowLoadoutSelectionMenu(object, _, p, selectLoadOutType, callback, _, currentLoadoutId)
	if __wf_atom_7e8ad928(_G.UIMovie_LoadoutSelectMovie) or __wf_atom_7e8ad928(p) then
		return nil
	end

	_T.SelectLoadOutType = selectLoadOutType
	_T.CurrentLoadoutId = currentLoadoutId
	local selected

	if __wf_atom_7e8ad928(object) then
		selected = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(_G.UIMovie_LoadoutSelectMovie)
	else
		selected = object:PushChildMovie(_G.UIMovie_LoadoutSelectMovie)
	end

	function _T.LoadoutSelectionDone(p2)
		_T.LoadoutSelectionDone = nil

		if not __wf_atom_7e8ad928(callback) then
			callback(p2)
		end
	end

	selected:Execute("SetCallBack", "LoadoutSelectionDone")
	return selected
end

function GetTimeOfDayLabel(p, p2)
	if p2 == FORTUNA_NODE_TAG or p2 == ORB_VALLIS_NODE_TAG then
		local HOURS_PER_SECOND_VENUS = TimeOfDayConstants.HOURS_PER_SECOND_VENUS

		if p < 12 then
			return
				TimeOfDayConstants.TIME_OF_DAY_LABEL_COLD,
				TimeOfDayConstants.TIME_OF_DAY_LABEL_WARM,
				(12 - p) / HOURS_PER_SECOND_VENUS
		end

		if p < 18 then
			return
				TimeOfDayConstants.TIME_OF_DAY_LABEL_WARM,
				TimeOfDayConstants.TIME_OF_DAY_LABEL_COLD,
				(18 - p) / HOURS_PER_SECOND_VENUS
		end

		return
			TimeOfDayConstants.TIME_OF_DAY_LABEL_COLD,
			TimeOfDayConstants.TIME_OF_DAY_LABEL_WARM,
			(36 - p) / HOURS_PER_SECOND_VENUS
	elseif p2 == OROKIN_TOWER_NODE_TAG or p2 == ENTRATI_LANDSCAPE_NODE_TAG or p2 == ENTRATI_LAB_NODE_TAG then
		local HOURS_PER_SECOND_ENTRATI = TimeOfDayConstants.HOURS_PER_SECOND_ENTRATI

		if not (p >= 22 or p < 6) then
			return
				TimeOfDayConstants.TIME_OF_DAY_LABEL_FASS,
				TimeOfDayConstants.TIME_OF_DAY_LABEL_VOME,
				(22 - p) / HOURS_PER_SECOND_ENTRATI
		end

		local TIME_OF_DAY_LABEL_VOME = TimeOfDayConstants.TIME_OF_DAY_LABEL_VOME
		local TIME_OF_DAY_LABEL_FASS = TimeOfDayConstants.TIME_OF_DAY_LABEL_FASS

		if p >= 22 then
			return TIME_OF_DAY_LABEL_VOME, TIME_OF_DAY_LABEL_FASS, (30 - p) / HOURS_PER_SECOND_ENTRATI
		end

		return TIME_OF_DAY_LABEL_VOME, TIME_OF_DAY_LABEL_FASS, (6 - p) / HOURS_PER_SECOND_ENTRATI
	elseif p2 == ZARIMAN_NODE_TAG then
		local HOURS_PER_SECOND_ZARIMAN = TimeOfDayConstants.HOURS_PER_SECOND_ZARIMAN

		if not (p >= 12 or p < 6) then
			return
				TimeOfDayConstants.TIME_OF_DAY_LABEL_GRINEER,
				TimeOfDayConstants.TIME_OF_DAY_LABEL_CORPUS,
				(12 - p) / HOURS_PER_SECOND_ZARIMAN
		end

		local TIME_OF_DAY_LABEL_CORPUS = TimeOfDayConstants.TIME_OF_DAY_LABEL_CORPUS
		local TIME_OF_DAY_LABEL_GRINEER = TimeOfDayConstants.TIME_OF_DAY_LABEL_GRINEER

		if p >= 12 then
			return TIME_OF_DAY_LABEL_CORPUS, TIME_OF_DAY_LABEL_GRINEER, (36 - p) / HOURS_PER_SECOND_ZARIMAN
		end

		return TIME_OF_DAY_LABEL_CORPUS, TIME_OF_DAY_LABEL_GRINEER, (12 - p) / HOURS_PER_SECOND_ZARIMAN
	else
		local HOURS_PER_SECOND_EIDOLON = TimeOfDayConstants.HOURS_PER_SECOND_EIDOLON

		if not (p >= 22 or p < 6) then
			return
				TimeOfDayConstants.TIME_OF_DAY_LABEL_DAY,
				TimeOfDayConstants.TIME_OF_DAY_LABEL_NIGHT,
				(22 - p) / HOURS_PER_SECOND_EIDOLON
		end

		local TIME_OF_DAY_LABEL_NIGHT = TimeOfDayConstants.TIME_OF_DAY_LABEL_NIGHT
		local TIME_OF_DAY_LABEL_DAY = TimeOfDayConstants.TIME_OF_DAY_LABEL_DAY

		if p >= 22 then
			return TIME_OF_DAY_LABEL_NIGHT, TIME_OF_DAY_LABEL_DAY, (30 - p) / HOURS_PER_SECOND_EIDOLON
		end

		return TIME_OF_DAY_LABEL_NIGHT, TIME_OF_DAY_LABEL_DAY, (6 - p) / HOURS_PER_SECOND_EIDOLON
	end
end

function CalculateTimeOfDay(p)
	local v21 = 0

	if
		__wf_atom_7e8ad928(gGameData)
		or __wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928((gGameData:__wf_atom_92662866()))
	then
		return v21
	end

	local HOURS_PER_SECOND_EIDOLON = TimeOfDayConstants.HOURS_PER_SECOND_EIDOLON

	if p == FORTUNA_NODE_TAG or p == ORB_VALLIS_NODE_TAG then
		HOURS_PER_SECOND_EIDOLON = TimeOfDayConstants.HOURS_PER_SECOND_VENUS
	elseif p == OROKIN_TOWER_NODE_TAG or p == ENTRATI_LANDSCAPE_NODE_TAG or p == ENTRATI_LAB_NODE_TAG then
		HOURS_PER_SECOND_EIDOLON = TimeOfDayConstants.HOURS_PER_SECOND_ENTRATI
	elseif p == ZARIMAN_NODE_TAG then
		HOURS_PER_SECOND_EIDOLON = TimeOfDayConstants.HOURS_PER_SECOND_ZARIMAN
	end

	return (gGameRules:CalculateTimeOfDay(HOURS_PER_SECOND_EIDOLON))
end

local function fn114(p)
	if not (p > 30) then
		return (tostring(p))
	end

	local v21 = p - 30
	local __wf_atom_03ff0530 = __wf_atom_8e4fda44:__wf_atom_03ff0530()
	local v22 = __wf_atom_7e8ad928(__wf_atom_03ff0530) and "+"
		or __wf_atom_03ff0530:__wf_atom_8e9ac384("<LEGENDARY_RANK>", true)
	return tostring(v21) .. v22
end

function ProcessPlayerLevel(p)
	return (fn114(p))
end

function GetSquadMemberLoadoutInfo(object, p, _)
	local v21 = {
		Name = nil,
		NameWithRank = nil,
		WeaponInfo = nil,
		CompanionInfo = nil,
		AuraInfo = nil
	}

	if __wf_atom_7e8ad928(p) then
		return v21
	end

	local name = p.name
	local decoded = cjson.decode(p.loadout)

	if not (not __wf_atom_7e8ad928(name) and not __wf_atom_7e8ad928(decoded) and name ~= "") then
		return v21
	end

	local v22 = (__wf_atom_7e8ad928(decoded.PlayerLevel) or decoded.PlayerLevel == "") and 0 or decoded.PlayerLevel
	local nameWithRank = name .. " " .. object:__wf_atom_8e9ac384("<RANK_" .. v22 .. ">", true) .. fn114(v22)
	v21.Name = name
	v21.NameWithRank = nameWithRank
	local ternary = module.Ternary(decoded.NORMAL_PVP ~= nil, decoded.NORMAL_PVP, decoded.NORMAL)
	local v23 = {
		{ Type = ternary[1], isWeapon = true },
		{ Type = decoded.DragonKey },
		{ Type = ternary[3], isWeapon = true },
		{ Type = ternary[2], isWeapon = true },
		{ Type = ternary[4], isWeapon = true }
	}

	if not (__wf_atom_7e8ad928(ternary) or __wf_atom_7e8ad928(v23)) then
		local weaponInfo = ""

		for i = 1, #v23 do
			local v24 = v23[i]

			if __wf_atom_7e8ad928(v24) or not v24.Type or not v24.Type.LocTag or not v24.isWeapon then
				continue
			end

			local locTag = tostring(v24.Type.LocTag)
			local __wf_atom_62a48c60 = SF.__wf_atom_62a48c60(locTag)

			if __wf_atom_62a48c60 ~= "" then
				locTag = __wf_atom_62a48c60
			end

			if locTag == "" then
				continue
			end

			if i > 1 then
				weaponInfo ..= "\n\r"
			end

			local level = v24.Type.Level
			weaponInfo ..= string.upper(object:__wf_atom_8e9ac384(locTag, true)) .. " [" .. level .. "]"
		end

		v21.WeaponInfo = weaponInfo
	end

	local kubrowName = ""

	if decoded.KubrowName == "" then
		if not __wf_atom_7e8ad928(decoded.SENTINEL) then
			local locTag = tostring(decoded.SENTINEL[1].LocTag)

			if not __wf_atom_7e8ad928(locTag) then
				kubrowName = SF.__wf_atom_62a48c60(locTag)

				if kubrowName == "" then
					kubrowName = object:__wf_atom_8e9ac384(tostring(locTag), false)
				end
			end
		end
	elseif module.IsUGCRestricted() then
		kubrowName = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryKubrow", false)
	else
		kubrowName = decoded.KubrowName
	end

	if kubrowName ~= "" and not __wf_atom_7e8ad928(decoded.SENTINEL) then
		kubrowName = "\n\r" .. kubrowName .. " [" .. decoded.SENTINEL[1].Level .. "]"
	end

	v21.CompanionInfo = kubrowName
	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(tostring(decoded.AuraName), false)

	if __wf_atom_8e9ac384 ~= "" then
		__wf_atom_8e9ac384 = "\n\r" .. string.upper(__wf_atom_8e9ac384)
	end

	v21.AuraInfo = __wf_atom_8e9ac384
	return v21
end

function CreateVendorConversationFunctions()
	function _T:OnVendorConversationStarted()
		local v21 = _T.SkipVendorDialog and _T.SkipVendorDialog[self.mSpeakerName]

		if type(v21) == "function" then
			v21 = v21(self)
		end

		if __wf_atom_7e8ad928(self.mTransmissionSet) or v21 then
			return
		end

		_T.BlockAmbientTransmissions = true
		local v22 = {}
		fn94(self, v22)
		local __wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("FirstVisit"))
		local v23 = Symbol("FirstVisitIntro")
		local mSpeakerName = self.mSpeakerName
		local v24 = not (__wf_atom_7e8ad928(__wf_atom_b4a422ed) or gGameData:__wf_atom_7f86fc42(Symbol(mSpeakerName)))

		if not v24 and fn55() then
			__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("PostNewWar"))

			if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
				local v25 = mSpeakerName .. "PostNewWar"

				if not gGameData:__wf_atom_7f86fc42(Symbol(v25)) then
					mSpeakerName = v25
					v24 = true
				end
			end
		end

		if v22.Loved then
			if not v24 then
				__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("FirstLoved"))
				mSpeakerName ..= "Loved"
				v24 = not (__wf_atom_7e8ad928(__wf_atom_b4a422ed) or gGameData:__wf_atom_7f86fc42(Symbol(mSpeakerName)))
				v23 = nil
			end

			if not __wf_atom_7e8ad928(self.mHubNpc) then
				self.mHubNpc:__wf_atom_14259365(false)
				self.mHubNpc:__wf_atom_6926d563(Symbol("LovedIntro"))
				self.IsUnmasked = true
			end
		end

		for i = v22.Level, 0, -1 do
			local v25 = "FirstRank" .. tostring(i)
			local __wf_atom_b4a422ed2 = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol(v25))

			if not __wf_atom_b4a422ed2 then
				continue
			end

			local v26 = mSpeakerName .. v25
			v24 = not (__wf_atom_7e8ad928(__wf_atom_b4a422ed2) or gGameData:__wf_atom_7f86fc42(Symbol(v26)))

			if not v24 then
				break
			end

			mSpeakerName = v26
			__wf_atom_b4a422ed = __wf_atom_b4a422ed2
			break
		end

		if not v24 then
			for i = v22.Level, 0, -1 do
				local v25 = Symbol("IntroRank" .. tostring(i))
				__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(v25)

				if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
					break
				end
			end

			if __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
				if v22.Level == 0 and v22.Reputation == 0 then
					__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("Intro"))
				elseif v22.Loved then
					__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("Loved"))
				else
					__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("Welcome"))
				end
			end

			v23 = nil
		end

		if self.mEventStageTag ~= EMPTY_SYMBOL and self.mEventTransmissionTag ~= EMPTY_SYMBOL then
			local mGoals = gGameData:__wf_atom_92662866().mGoals

			for i = 1, #mGoals do
				local mGoal = mGoals[i]

				if not (Engine.__wf_atom_db2b0cee(mGoal.mActivation) <= 0 and Engine.__wf_atom_db2b0cee(mGoal.mExpiry) > 0 and mGoal.mTag == self.mEventStageTag) then
					continue
				end

				__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(self.mEventTransmissionTag)
				v24 = false
			end
		end

		if self.IntroTransFunction ~= "" and _T[self.IntroTransFunction] ~= nil then
			local v25 = _T[self.IntroTransFunction](self, v24)

			if v25 ~= nil then
				__wf_atom_b4a422ed = self.mTransmissionSet:__wf_atom_b4a422ed(v25)
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
			self:__wf_atom_9265891c(__wf_atom_b4a422ed, nil, v24, true, v23)

			if v24 then
				gGameData:__wf_atom_c9bb8504(Symbol(mSpeakerName))
			end
		end
	end

	function _T:OnVendorConversationEnded()
		local v21 = {}
		fn94(self, v21)

		if v21.Loved and not __wf_atom_7e8ad928(self.mHubNpc) and self.IsUnmasked then
			self.mHubNpc:__wf_atom_6926d563(Symbol("LovedOutro"))
			Sleep(0.5)
			self.mHubNpc:__wf_atom_14259365(true)
		end

		_T.BlockAmbientTransmissions = nil

		if
			__wf_atom_7e8ad928(self.mTransmissionSet)
			or self.mSkipEndTrans
			or _T.SkipVendorDialog and _T.SkipVendorDialog[self.mSpeakerName]
		then
			self.mSkipEndTrans = false
			return
		end

		if not _T.SkipConversationByeTransmission then
			local v22 = nil

			for i = v21.Level, 0, -1 do
				local v23 = Symbol("Bye" .. tostring(i))
				v22 = self.mTransmissionSet:__wf_atom_b4a422ed(v23)

				if not __wf_atom_7e8ad928(v22) then
					break
				end
			end

			if __wf_atom_7e8ad928(v22) then
				v22 = self.mTransmissionSet:__wf_atom_b4a422ed(Symbol("Bye"))
			end

			if not __wf_atom_7e8ad928(v22) then
				self:__wf_atom_9265891c(v22, nil, false, true)
			end
		end

		_T.SkipConversationByeTransmission = nil
	end
end

function RegisterHideHud(p)
	if __wf_atom_7e8ad928(_T.HideHud) then
		_T.HideHud = 0
	end

	_T.HideHud = math.max(0, _T.HideHud + module.Ternary(p, 1, -1))
	print("DBG: HudVis " .. _T.HideHud)
end

function RegisterHideNotifications(p)
	if __wf_atom_7e8ad928(_T.HideNotifications) then
		_T.HideNotifications = 0
	end

	_T.HideNotifications = math.max(0, _T.HideNotifications + module.Ternary(p, 1, -1))
end

function RegisterHideStarChart(p)
	if __wf_atom_7e8ad928(_T.HideMapRedux) then
		_T.HideMapRedux = 0
	end

	_T.HideMapRedux = math.max(0, _T.HideMapRedux + module.Ternary(p, 1, -1))
end

function RegisterHideSquadOverlay(p)
	if __wf_atom_7e8ad928(_T.HideSquadOverlay) then
		_T.HideSquadOverlay = 0
	end

	_T.HideSquadOverlay = math.max(0, _T.HideSquadOverlay + module.Ternary(p, 1, -1))
end

function RegisterHideEOM(p)
	if __wf_atom_7e8ad928(_T.HideEOM) then
		_T.HideEOM = 0
	end

	_T.HideEOM = math.max(0, _T.HideEOM + module.Ternary(p, 1, -1))
end

function GetEntityUnderCursor(object, object2, className)
	if __wf_atom_7e8ad928(object2:__wf_atom_c4f78a8f()) then
		return nil
	end

	local __wf_atom_4cd347da = object2:__wf_atom_c4f78a8f():CameraControl():__wf_atom_4cd347da()

	if not __wf_atom_7e8ad928(__wf_atom_4cd347da) then
		local raycastEntity = object2:RaycastEntity(
			__wf_atom_4cd347da:GetPosition(),
			__wf_atom_4cd347da:GetPosition() + object:__wf_atom_65213f02() * 200,
			nil
		)

		if not __wf_atom_7e8ad928(raycastEntity) and raycastEntity:IsA(className) then
			return raycastEntity
		end
	end

	return nil
end

function HasDojoArchitectPermission(p)
	local v21 = {}
	table.insert(v21, 16)

	if p then
		table.insert(v21, 1024)
	end

	for i = 1, #v21 do
		if gGameData:__wf_atom_4a5a45f5(v21[i]) then
			return true
		end
	end

	return false
end

function GetDojoConsole(p, p2, p3)
	local dojoMgr = _T.DojoMgr

	if __wf_atom_7e8ad928(dojoMgr) then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol(p))
	local v21 = 1000000
	local v22 = nil

	for i = 1, #__wf_atom_2226b35c do
		local v23 = __wf_atom_2226b35c[i]
		local componentParams = dojoMgr:BuildComponentParams(v23)
		local jsonComponent

		if componentParams.id ~= "" then
			jsonComponent = dojoMgr.mDojo:GetJsonComponent(componentParams)
		end

		if jsonComponent == nil or not jsonComponent:__wf_atom_8598f3a9() then
			if not p3 then
				local __wf_atom_d5fda8be = v23:__wf_atom_d5fda8be(p2)

				if __wf_atom_d5fda8be < v21 then
					v22 = v23
					v21 = __wf_atom_d5fda8be
				end
			end
		elseif jsonComponent:__wf_atom_0a1f891f() then
			local __wf_atom_d5fda8be = v23:__wf_atom_d5fda8be(p2)

			if __wf_atom_d5fda8be < v21 then
				v22 = v23
				v21 = __wf_atom_d5fda8be
			end
		end
	end

	return v22
end

function IsCreatorRank(p)
	return p == 0
end

function IsWarlordRank(p)
	return p == 0 or p == 1
end

function ShowConditionalWordConfirm(object, p, p2, p3, p4, p5, desc, p6, p7)
	local function fn115(p8, desc2)
		local _, v21 = fn79(object, p8, "", 40, "ConfirmConditionalWord", "OSKConfirmConditionalWord", {
			isMultiline = nil,
			cancelDisabled = nil,
			forChat = nil,
			desc = desc2
		})

		if not __wf_atom_7e8ad928(v21) then
			v21:Execute("SetConditionalWord", p)
			v21:Execute("SetDialogWidth", p7)
		end
	end

	local v21 = fn5()

	function v21.ConfirmConditionalWord(p8, _, p9)
		local v22 = tonumber(p9) == 4

		if v22 or p6 then
			object:__wf_atom_f62a8704(p5, { p8, (tostring(v22)) })
		end
	end

	function v21.OSKConfirmConditionalWord(p8, p9)
		if not p8 or p6 then
			object:__wf_atom_f62a8704(p5, { p9, (tostring(not p8)) })
		end
	end

	function v21.ConditionalFirstConfirm(p8)
		if tonumber(p8) == 4 then
			setfenv(1, v21)
			fn115(p4)
		elseif p6 then
			object:__wf_atom_f62a8704(p5, { "", "false" })
		end
	end

	if
		Engine.__wf_atom_fc67ba71()
		or Engine.__wf_atom_2a979d69()
		or Engine.__wf_atom_971e3285()
		or Engine.__wf_atom_5f0554d9()
	then
		module.ShowConfirmMessage(p3, "ConditionalFirstConfirm", 3)
	else
		fn115(p2, desc)
	end
end

function GetAltFireKey(object, p)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(p)
		or object:__wf_atom_c7fa5e0c("<SECONDARY_FIRE>", p) ~= "<SECONDARY_FIRE>"
	then
		return "<SECONDARY_FIRE>"
	end

	if object:__wf_atom_c7fa5e0c("<MELEE_CHANNEL>", p) ~= "<MELEE_CHANNEL>" then
		return "<MELEE_CHANNEL>"
	end

	return "<SECONDARY_FIRE>"
end

function GetActiveSoundSet()
	local SOUND_SET_RAILJACK2 = nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local v21

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_e800787c()) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_cdbee85f())) then
			v21 = __wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_cdbee85f():__wf_atom_b1dbf338()
		end

		if not __wf_atom_7e8ad928(v21) and v21 ~= EMPTY_SYMBOL then
			SOUND_SET_RAILJACK2 = ({
				[tostring(ENTRATI_LAB_ZONE_TAG)] = SOUND_SET_ENTRATILAB,
				[tostring(DEIMOS_NECRALISK_ZONE_TAG)] = SOUND_SET_OROKIN_TOWER
			})[tostring(v21)]
		end
	end

	if SOUND_SET_RAILJACK2 == nil and not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_589d05aa) then
		if gGameRules:__wf_atom_0fa72b69() == 32 then
			SOUND_SET_RAILJACK2 = SOUND_SET_RAILJACK
		else
			local v21 = {
				[tostring(CETUS_NODE_TAG)] = SOUND_SET_EIDOLON,
				[tostring(PLAINS_NODE_TAG)] = SOUND_SET_EIDOLON,
				[tostring(ORB_VALLIS_NODE_TAG)] = SOUND_SET_ORB_VALLIS,
				[tostring(FORTUNA_NODE_TAG)] = SOUND_SET_FORTUNA,
				[tostring(OROKIN_TOWER_NODE_TAG)] = SOUND_SET_OROKIN_TOWER,
				[tostring(ENTRATI_LANDSCAPE_NODE_TAG)] = SOUND_SET_OROKIN_TOWER,
				[tostring(ENTRATI_LAB_NODE_TAG)] = SOUND_SET_ENTRATILAB,
				[tostring(ZARIMAN_NODE_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(ZARIMAN_MISSION_A_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(ZARIMAN_MISSION_B_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(ZARIMAN_MISSION_C_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(ZARIMAN_MISSION_D_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(ZARIMAN_MISSION_E_TAG)] = SOUND_SET_ZARIMAN,
				[tostring(APARTMENT_NODE_TAG)] = SOUND_SET_ZARIMAN
			}

			for _, v22 in ipairs(DUVIRI_MISSION_NODES) do
				v21[v22] = SOUND_SET_DUVIRI
			end

			for _, v22 in ipairs(ENTRATI_LAB_MISSION_NODES) do
				v21[v22] = SOUND_SET_ENTRATILAB
			end

			SOUND_SET_RAILJACK2 = v21[tostring(gGameRules:__wf_atom_72fc675e().location)]
		end
	end

	if SOUND_SET_RAILJACK2 == nil then
		SOUND_SET_RAILJACK2 = SOUND_SET_EIDOLON
	end

	return SOUND_SET_RAILJACK2
end

function InitializeTitleBookends(object, object2, value)
	local v21 = value or 0
	local __wf_atom_80cf57aa = object2:__wf_atom_80cf57aa()
	local v22 = __wf_atom_80cf57aa.x / (__wf_atom_80cf57aa.y / 64)
	object:__wf_atom_c90af43a("Title.BookendLeft", object2)
	object:__wf_atom_c90af43a("Title.BookendRight", object2)
	object:__wf_atom_e57658c2("Title.BookendLeft", 14, v22)
	object:__wf_atom_e57658c2("Title.BookendLeft", 15, 64)
	object:__wf_atom_e57658c2("Title.BookendLeft", 1, 22 + v21)
	object:__wf_atom_e57658c2("Title.BookendRight", 14, v22)
	object:__wf_atom_e57658c2("Title.BookendRight", 15, 64)
	object:__wf_atom_e57658c2("Title.BookendRight", 1, 22 + v21)
end

local function fn115(list, __wf_atom_6183ce15)
	local result = {}

	for _ = 1, __wf_atom_6183ce15 do
		table.insert(result, list[1])
	end

	if #list == 1 then
		return result
	end

	local v21 = 0

	for i = 1, #list do
		v21 += list[i].mWeight
	end

	local count = #list

	for i = 1, __wf_atom_6183ce15 do
		local v22 = __wf_atom_8d119bab(0, 1) * v21

		for j = 1, count do
			if v22 < list[j].mWeight then
				result[i] = list[j].mItemType
				v21 -= list[j].mWeight
				table.remove(list, j)
				count -= 1
				break
			else
				v22 -= list[j].mWeight
			end
		end
	end

	return result
end

function GetHelminthUpgradeOffers(p, object, list, p2)
	local v21 = fn105()

	if not __wf_atom_7e8ad928(_T.randInvigorations) then
		v21 += _T.randInvigorations
	end

	local v22 = object:__wf_atom_5d7dbcd7() / 60
	local mInvigorationIndex = p2.mInvigorationIndex
	local v23 = math.floor(v21 / v22)

	if
		_G.HelminthUpgradeOfferingCache
		and _G.HelminthUpgradeOfferingCache[p]
		and _G.HelminthUpgradeIndexCache
		and _G.HelminthUpgradeIndexCache[p] == v23
	then
		if
			not __wf_atom_7e8ad928(p2.mInvigorationSuitOfferings)
			and #p2.mInvigorationSuitOfferings ~= 0
			and v23 == mInvigorationIndex
		then
			return _G.HelminthUpgradeOfferingCache[p]
		end

		local baseSuitTypes = {}

		for i = 1, #_G.HelminthUpgradeOfferingCache[p] do
			table.insert(baseSuitTypes, _G.HelminthUpgradeOfferingCache[p][i].baseSuitType)
		end

		gGameData:__wf_atom_654254b9(baseSuitTypes, v23, false, "OnHelminthOfferingsUploaded")
		return _G.HelminthUpgradeOfferingCache[p]
	else
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			print("Failed to find store manifest for helminth upgrades!")
			return nil
		end

		if __wf_atom_7e8ad928(object) then
			print("Failed to find helminth manifest for helminth upgrades!")
			return nil
		end

		local __wf_atom_6183ce15 = object:__wf_atom_6183ce15()
		local v24 = nil
		local mInvigorationSuitOfferings = nil

		if
			__wf_atom_7e8ad928(p2.mInvigorationSuitOfferings)
			or #p2.mInvigorationSuitOfferings ~= __wf_atom_6183ce15
			or v23 ~= mInvigorationIndex
		then
			local __wf_atom_caa82b8d = __wf_atom_964056fd:__wf_atom_caa82b8d(WeakResource("/Lotus/Types/Game/PowerSuits/PlayerPowerSuit"))
			local v25 = {}

			for _, v26 in pairs(__wf_atom_caa82b8d) do
				if v26:__wf_atom_efa6f447() ~= 3 or v26:__wf_atom_e063e3c3() or not v26:ShowInMarket() then
					continue
				end

				local __wf_atom_5b41f63b = v26:__wf_atom_5b41f63b()

				if
					string.find(__wf_atom_5b41f63b, "Prime")
					or string.find(__wf_atom_5b41f63b, "Operator")
					or string.find(__wf_atom_5b41f63b, "Umbra")
					or string.find(__wf_atom_5b41f63b, "PlayerPowerSuit")
				then
					continue
				end

				local v27 = string.gsub(__wf_atom_5b41f63b, "/StoreItems", "")

				if string.find(v27, "/Anti") then
					v27 = string.sub(v27, 1, string.len(v27) - 4) .. "Nova"
				end

				local v28 = WeakResource(v27 .. "BaseSuit")

				if not __wf_atom_7e8ad928(v28) then
					table.insert(v25, v28)
				end
			end

			if #v25 == 0 then
				print("Failed to find valid suits for helminth upgrades!")
				return nil
			end

			v24 = object:__wf_atom_8e1ea5df()
			local v26 = not __wf_atom_7e8ad928(p2.mInvigorationSuitOfferings)
				and #p2.mInvigorationSuitOfferings == __wf_atom_6183ce15

			if v26 then
				for i = 1, #v24 do
					for j = 1, #p2.mInvigorationSuitOfferings do
						if v24[i].mItemType ~= p2.mInvigorationSuitOfferings[j] then
							continue
						end

						v24[i].mWeight = 0
						break
					end
				end
			end

			for i = 1, #v25 do
				local v27 = false

				for j = 1, #v24 do
					if v24[j].mItemType ~= v25[i] then
						continue
					end

					v27 = true
					break
				end

				if v27 then
					continue
				end

				local mWeight = 1

				if v26 then
					for j = 1, #p2.mInvigorationSuitOfferings do
						if v25[i] ~= p2.mInvigorationSuitOfferings[j] then
							continue
						end

						mWeight = 0
						break
					end
				end

				table.insert(v24, { mItemType = v25[i], mWeight = mWeight })
			end
		else
			mInvigorationSuitOfferings = p2.mInvigorationSuitOfferings
		end

		local __wf_atom_bb1a7376 = object:__wf_atom_bb1a7376()

		if #__wf_atom_bb1a7376 == 0 then
			print("Failed to find valid offensive upgrades for helminth upgrades!")
			return nil
		end

		local __wf_atom_cc661f62 = object:__wf_atom_cc661f62()

		if #__wf_atom_cc661f62 == 0 then
			print("Failed to find valid defensive upgrades for helminth upgrades!")
			return nil
		end

		if #list == 0 then
			print("Failed to find resource costs for helminth upgrades!")
			return nil
		end

		local v25 = {}

		for i = 1, #list do
			table.insert(v25, list[i])
		end

		if not _G.HelminthUpgradeIndexCache then
			_G.HelminthUpgradeIndexCache = {}
		end

		_G.HelminthUpgradeIndexCache[p] = v23
		local v26 = __wf_atom_04d7eaaa()
		__wf_atom_01bfe5c4(__wf_atom_3e61816b(v23))
		local v27 = __wf_atom_c08f5a0e(1, 1000000)
		local v28 = __wf_atom_ef9aeb11(Engine.__wf_atom_746f9d1b(p))
		local v29 = __wf_atom_3e61816b(v28 + v27)

		if v23 == mInvigorationIndex then
			__wf_atom_2e624c2f(v29, __wf_atom_6183ce15)
		else
			__wf_atom_01bfe5c4(v29)
			mInvigorationSuitOfferings = fn115(v24, __wf_atom_6183ce15)
			gGameData:__wf_atom_654254b9(mInvigorationSuitOfferings, v23, false, "OnHelminthOfferingsUploaded")
		end

		local v30 = {}

		for i = 1, #mInvigorationSuitOfferings do
			local __wf_atom_5b41f63b = mInvigorationSuitOfferings[i]:__wf_atom_5b41f63b()
			local v31

			if string.find(__wf_atom_5b41f63b, "NovaBaseSuit") then
				v31 = string.gsub(__wf_atom_5b41f63b, "NovaBaseSuit", "Anti")
			else
				v31 = string.gsub(__wf_atom_5b41f63b, "BaseSuit", "")
			end

			table.insert(v30, WeakResource(v31))
		end

		local __wf_atom_281dfc7c = object:__wf_atom_281dfc7c()

		for i = 1, #mInvigorationSuitOfferings do
			for j = 1, #__wf_atom_281dfc7c do
				if mInvigorationSuitOfferings[i] ~= __wf_atom_281dfc7c[j].mItemType then
					continue
				end

				for k = 1, #__wf_atom_281dfc7c[j].mInvalidUpgradeTypes do
					for i2 = #__wf_atom_bb1a7376, 1, -1 do
						if __wf_atom_281dfc7c[j].mInvalidUpgradeTypes[k] == __wf_atom_bb1a7376[i2].mItemType then
							table.remove(__wf_atom_bb1a7376, i2)
						end
					end

					for i2 = #__wf_atom_cc661f62, 1, -1 do
						if __wf_atom_281dfc7c[j].mInvalidUpgradeTypes[k] == __wf_atom_cc661f62[i2].mItemType then
							table.remove(__wf_atom_cc661f62, i2)
						end
					end
				end

				break
			end
		end

		local v31 = fn115(__wf_atom_bb1a7376, __wf_atom_6183ce15)
		local v32 = fn115(__wf_atom_cc661f62, __wf_atom_6183ce15)
		local __wf_atom_da2a1d51 = object:__wf_atom_da2a1d51()
		local __wf_atom_3756cfd5 = object:__wf_atom_3756cfd5()
		local __wf_atom_75ba32af = object:__wf_atom_75ba32af()
		local __wf_atom_2437d5ff = object:__wf_atom_2437d5ff()
		local __wf_atom_538d8f2d = object:__wf_atom_538d8f2d()
		local v33 = {}
		local v34 = {}

		for _ = 1, __wf_atom_6183ce15 do
			local v35 = __wf_atom_8d119bab(__wf_atom_da2a1d51, __wf_atom_3756cfd5)
			local v36 = {}
			local values = {}

			for i = 1, __wf_atom_538d8f2d do
				local v37 = __wf_atom_c08f5a0e(1, #v25)
				local v38 = v25[v37]
				table.remove(v25, v37)
				local v39 = math.min(__wf_atom_2437d5ff, v35 - __wf_atom_75ba32af * (__wf_atom_538d8f2d - i))
				local v40 = math.max(__wf_atom_75ba32af, v35 - __wf_atom_2437d5ff * (__wf_atom_538d8f2d - i))
				local v41 = math.max(0, __wf_atom_8d119bab(v40, v39))
				v35 -= v41
				local rounded = module.Round(v41, 2)
				table.insert(v36, v38:GetItem())
				table.insert(values, rounded)
			end

			table.insert(v33, v36)
			table.insert(v34, values)
			v25 = {}

			for i = 1, #list do
				table.insert(v25, list[i])
			end
		end

		__wf_atom_01bfe5c4(v26)

		if not _G.HelminthUpgradeOfferingCache then
			_G.HelminthUpgradeOfferingCache = {}
		end

		_G.HelminthUpgradeOfferingCache[p] = {}

		for i = 1, __wf_atom_6183ce15 do
			table.insert(_G.HelminthUpgradeOfferingCache[p], {
				baseSuitType = mInvigorationSuitOfferings[i],
				suitType = v30[i],
				offensiveUpgradeType = v31[i],
				defensiveUpgradeType = v32[i],
				resourceTypes = v33[i],
				resourceCosts = v34[i]
			})
		end

		print("Helminth upgrade: generated offers for " .. p .. " with cycle index " .. v23)
		return _G.HelminthUpgradeOfferingCache[p]
	end
end

function GetEliteAlertUpgradeSeed(p, p2)
	if p2 == nil then
		p2 = math.floor(fn105() / (ELITE_ALERT_MISSION_INTERVAL / 60))
	end

	local v21 = __wf_atom_04d7eaaa()
	__wf_atom_01bfe5c4(__wf_atom_3e61816b(p2))
	local v22 = __wf_atom_c08f5a0e(1, 1000000)
	__wf_atom_01bfe5c4(v21)
	return __wf_atom_ef9aeb11(Engine.__wf_atom_746f9d1b(p)) + v22, p2
end

function GetLiteSortieUpgradeSeed(p, p2)
	if p2 == nil then
		local mLiteSorties = gGameData:__wf_atom_92662866().mLiteSorties

		if mLiteSorties ~= nil then
			local mSeed = mLiteSorties[1].mSeed
			local v21 = __wf_atom_04d7eaaa()
			__wf_atom_01bfe5c4(mSeed)
			__wf_atom_c08f5a0e(1, 2)
			p2 = __wf_atom_c08f5a0e(1, 1000000)
			__wf_atom_01bfe5c4(v21)
		end
	end

	if p2 == nil then
		return
	else
		return __wf_atom_ef9aeb11(Engine.__wf_atom_746f9d1b(p)) + p2, p2
	end
end

function GetEliteUpgrades(p, p2)
	if not _G.RollableItemsTypeNameCache then
		_G.RollableItemsTypeNameCache = {}
		_G.RollableItemsTypeNameCache.suits = {}
		_G.RollableItemsTypeNameCache.weapons = {}
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			return "", WeakResource(), WeakResource(), {}, "", {}, {}, {}, 0
		end

		local __wf_atom_caa82b8d = __wf_atom_964056fd:__wf_atom_caa82b8d(
			WeakResource("/Lotus/Types/Game/PowerSuits/PlayerPowerSuit"),
			true
		)

		for _, v21 in pairs(__wf_atom_caa82b8d) do
			if v21:__wf_atom_efa6f447() ~= 3 or v21:__wf_atom_e063e3c3() then
				continue
			end

			local __wf_atom_5b41f63b = v21:__wf_atom_5b41f63b()

			if
				string.find(__wf_atom_5b41f63b, "Prime")
				or string.find(__wf_atom_5b41f63b, "Operator")
				or string.find(__wf_atom_5b41f63b, "Umbra")
				or string.find(__wf_atom_5b41f63b, "PlayerPowerSuit")
			then
				continue
			end

			table.insert(_G.RollableItemsTypeNameCache.suits, __wf_atom_5b41f63b)
		end

		local __wf_atom_caa82b8d2 = __wf_atom_964056fd:__wf_atom_caa82b8d(__wf_atom_9df43583, true)

		for _, v21 in pairs(__wf_atom_caa82b8d2) do
			local __wf_atom_efa6f447 = v21:__wf_atom_efa6f447()

			if not ((__wf_atom_efa6f447 == 0 or __wf_atom_efa6f447 == 1 or __wf_atom_efa6f447 == 5) and v21:__wf_atom_3a3d2e39():__wf_atom_8598f3a9() and v21:__wf_atom_1447fa74()) then
				continue
			end

			if v21:__wf_atom_e063e3c3() then
				continue
			end

			local __wf_atom_5b41f63b = v21:__wf_atom_5b41f63b()

			if
				string.find(__wf_atom_5b41f63b, "MK1")
				or string.find(__wf_atom_5b41f63b, "StartingRifle")
				or string.find(__wf_atom_5b41f63b, "Prime")
				or string.find(__wf_atom_5b41f63b, "Wraith")
				or string.find(__wf_atom_5b41f63b, "Vandal")
				or string.find(__wf_atom_5b41f63b, "Prisma")
				or string.find(__wf_atom_5b41f63b, "Syndicate")
				or string.find(__wf_atom_5b41f63b, "Modular")
				or string.find(__wf_atom_5b41f63b, "Gear")
			then
				continue
			end

			table.insert(_G.RollableItemsTypeNameCache.weapons, {
				itemName = __wf_atom_5b41f63b,
				category = __wf_atom_efa6f447
			})
		end
	end

	if #_G.RollableItemsTypeNameCache.suits == 0 then
		return "", WeakResource(), WeakResource(), {}, "", WeakResource(), WeakResource(), {}, 0
	end

	local v21 = __wf_atom_04d7eaaa()
	__wf_atom_01bfe5c4(__wf_atom_3e61816b(p2))
	local suit = _G.RollableItemsTypeNameCache.suits[__wf_atom_c08f5a0e(1, #_G.RollableItemsTypeNameCache.suits)]
	local v22 = string.gsub(suit, "/StoreItems", "")
	local v23 = WeakResource(v22)

	if string.find(v22, "/Anti") then
		v22 = string.sub(v22, 1, string.len(v22) - 4) .. "Nova"
	end

	local v24 = WeakResource(v22 .. "BaseSuit")
	local weapons = _G.RollableItemsTypeNameCache.weapons
	local count = #weapons
	local v25 = ""
	local itemNames = {}
	local result = {}
	local result2 = {}
	local result3 = {}
	local v26 = {}

	for i = 1, 3 do
		if count < i then
			break
		end

		local v27

		repeat
			v27 = __wf_atom_c08f5a0e(1, count)
		until v26[v27] == nil

		v26[v27] = true
		local weapon = weapons[v27]
		local itemName = weapon.itemName
		local v28 = string.gsub(itemName, "/StoreItems", "")
		local v29 = WeakResource(v28)
		local v30 = WeakResource(v28 .. "Prime")
		local v31 = {
			upgType = module.Ternary(weapon.category == 5, 366, 292),
			label = "/Lotus/Language/Labels/WEAPON_DAMAGE_AMOUNT"
		}
		itemNames[i] = itemName
		result3[i] = v31
		result[i] = v29
		result2[i] = v30
		v25 ..= v28 .. ", "
	end

	__wf_atom_01bfe5c4(v21)
	print("EliteAlert: generated boosts for " .. p .. ": suitType=" .. v22 .. " wepTypes=" .. v25)
	return suit, v23, v24, {
		{
			upgType = 10,
			upgOp = 3,
			value = 3,
			label = "/Lotus/Language/Labels/AVATAR_ABILITY_STRENGTH",
			itemType = v24
		},
		{
			upgType = 84,
			upgOp = 0,
			value = 500,
			label = "/Lotus/Language/Labels/AVATAR_HEALTH_MAX",
			checkSuitType = v24
		}
	}, itemNames, result, result2, result3
end

function AppendItemRank(state)
	if __wf_atom_7e8ad928(state.Rank) then
		local resultItemType = state.ResultItemType or state.Type

		if not __wf_atom_7e8ad928(resultItemType) and resultItemType:IsA(__wf_atom_2dc5c74e) then
			local inventory

			if not __wf_atom_7e8ad928(gGameData) then
				inventory = gGameData:GetInventory() or nil
			end

			if not __wf_atom_7e8ad928(inventory) then
				local mXPInfo = inventory.mXPInfo

				for i = 1, #mXPInfo do
					local mItemType = mXPInfo[i].mItemType

					if __wf_atom_7e8ad928(mItemType) or mItemType ~= resultItemType then
						continue
					end

					state.Rank = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mXPInfo[i].mXP, mItemType)
				end
			end
		end
	end
end

function ApplyParticleThemeColors(instance, p, p2)
	if not __wf_atom_7e8ad928(instance) then
		local v21 = p == nil and 10 or p
		local v22 = p2 == nil and 2 or p2
		local convertHEX2RGB255 = module.ConvertHEX2RGB255(module2.GetColor(v21, true))
		local convertHEX2RGB255_2 = module.ConvertHEX2RGB255(module2.GetColor(v22, true))

		if instance:IsA(__wf_atom_8939e086) then
			instance:__wf_atom_8cd234d5(convertHEX2RGB255, convertHEX2RGB255_2)
		elseif instance:IsA(__wf_atom_fac7b40a) then
			instance:__wf_atom_7fff6c98(convertHEX2RGB255)
		end
	end
end

function ReplaceTextColors(value, list)
	return string.gsub(value, "\"#.-\"", function(value2)
		return string.gsub(value2, "%w+", function(list2)
			local v21 = SF["UIStyle_" .. list2]

			if v21 == nil then
				if #list2 == 6 then
					return list2
				end

				print("Attempted to use broken color: " .. list2)
				return list[9]
			else
				if list[v21] == nil then
					list[v21] = string.format("%X", module2.GetColor(v21, true))
				end

				return list[v21]
			end
		end)
	end)
end

function IsParadoxPath(gGameData2)
	if __wf_atom_7e8ad928(gGameData2) then
		gGameData2 = gGameData
	end

	return not __wf_atom_7e8ad928(gGameData2) and gGameData2:__wf_atom_247a5d2e(true).mBootLocation == 2
end

function UpdateMailbox(object)
	if not (function()
		if _T.gQueueMailbox ~= true or __wf_atom_6a6ca13e() ~= "" or __wf_atom_7e8ad928(gGameData) then
			return false
		end

		if
			#gGameData:__wf_atom_b2dbe31b() > 0
			or #gGameData:__wf_atom_8ba10f50() > 0
			or _T.ForceCompletedQuestUpdate
			or fn91(gGameData) and not (_T.QuestHighPriorityMessagePending and _T.ShowNotification and _T.GetScreenRes)
		then
			return false
		end

		return true
	end)() then
		return
	end

	if _T.ShowNotification ~= nil then
		local __wf_atom_6a8f669c = gGameData:__wf_atom_6a8f669c()

		if __wf_atom_6a8f669c > 0 then
			local __wf_atom_90763c09 = gGameData:__wf_atom_90763c09()

			for i = #__wf_atom_90763c09, 1, -1 do
				local v21 = __wf_atom_90763c09[i]

				if
					v21.mIsRead
					or not (string.find(v21.mSender, "^/Lotus/") or string.find(v21.mSubject, "^/Lotus/"))
				then
					continue
				end

				__wf_atom_6a8f669c -= 1
			end
		end

		if __wf_atom_6a8f669c > 0 and not _T.SkipMailNotification then
			_T.ShowNotification(
				Localize("/SF/Language/Inbox/NewMessagesNotification", {
					COUNT = __wf_atom_6a8f669c
				}),
				"Mail"
			)
		end

		if gGameData:__wf_atom_153e689d() > 0 and _T.GetScreenRes ~= nil then
			local screenRes = _T.GetScreenRes("Inbox")

			if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(screenRes))) and not __wf_atom_7e8ad928(object) then
				_T.OpeningMailbox = true
				object:AddTimer(1, function()
					if
						_T.UIInputEnabled
						or _T.RadialSolarMapOpen
						or _T.TeleportingToConsole
						or _T.QuestPickerOpen
						or _T.PreventForcedInbox
						or _T.PlatBrowsingOpen
						or _T.DojoMenuOpen
					then
						_T.SkipMailNotification = true
						_T.gQueueMailbox = true
						_T.OpeningMailbox = nil
					else
						_T.ForceOpenScreen = "Inbox"

						if
							__wf_atom_7e8ad928(gGameRules)
							or __wf_atom_7e8ad928(gRegion)
							or not gGameRules:__wf_atom_c9b9e998(gRegion:__wf_atom_c4f78a8f())
						then
							_T.OpeningMailbox = nil
						else
							gGameRules:ShowPauseMenu()
						end
					end
				end)
			end
		end
	end

	_T.SkipMailNotification = false
	_T.gQueueMailbox = false
end

function IsSeasonActive()
	return not __wf_atom_7e8ad928(gGameData) and gGameData:__wf_atom_92662866():IsSeasonActive() and fn53()
end

local function fn116(p, value, value2, p2)
	local __wf_atom_7ff49939 = fn21():__wf_atom_7ff49939(p, value2 or 0)

	if p2 == nil then
		p2 = Localize("/Lotus/Language/Kingpins/NemesisViewer_Title", nil)
	end

	__wf_atom_7ff49939.uniqueName = Localize("/Lotus/Language/Kingpins/NemesisControlledTerritory", {
		LICH_NAME = p2
	})
	local v21 = value or 1
	local v22 = 55
	local v23 = 75

	if v21 == 1 then
		v22 = 50
		v23 = 60
	elseif v21 == 2 then
		v22 = 55
		v23 = 70
	elseif v21 == 3 then
		v22 = 75
		v23 = 90
	elseif v21 >= 4 then
		v22 = 90
		v23 = 110
	end

	__wf_atom_7ff49939.minEnemyLevel = math.max(__wf_atom_7ff49939.minEnemyLevel, v22)
	__wf_atom_7ff49939.maxEnemyLevel = math.max(__wf_atom_7ff49939.maxEnemyLevel, v23)
	__wf_atom_7ff49939.difficulty = 1
	local missionType = __wf_atom_7ff49939.missionType

	if missionType == 8 then
		__wf_atom_7ff49939.maxWaveNum = 5
		return __wf_atom_7ff49939
	elseif missionType == 13 then
		__wf_atom_7ff49939.maxWaveNum = 1
		return __wf_atom_7ff49939
	elseif missionType == 2 then
		__wf_atom_7ff49939.maxWaveNum = 5
		return __wf_atom_7ff49939
	elseif missionType == 17 then
		__wf_atom_7ff49939.maxWaveNum = 5
		return __wf_atom_7ff49939
	elseif missionType == 7 then
		__wf_atom_7ff49939.maxWaveNum = 2
		return __wf_atom_7ff49939
	elseif missionType == 4 then
		__wf_atom_7ff49939.maxWaveNum = 2
		return __wf_atom_7ff49939
	end

	if missionType == 33 then
		__wf_atom_7ff49939.maxWaveNum = 4
	end

	return __wf_atom_7ff49939
end

function BuildNemesisMission(p, p2, p3, p4)
	return fn116(p, p2, p3, p4)
end

function ShouldHideRecipe(object)
	local __wf_atom_16791275 = object:__wf_atom_16791275()

	if __wf_atom_16791275 == 1 or __wf_atom_16791275 == 0 then
		return true
	end

	if __wf_atom_16791275 == 3 then
		return #gGameData:GetInventory():__wf_atom_bae92715() > 0
	end

	return __wf_atom_16791275 == 4 and #gGameData:GetInventory():__wf_atom_bae92715() == 0
end

function CheckLetterSpacing(object, p)
	if not ({
		_uk = true,
		_ru = true,
		_ja = true,
		_zh = true,
		_tc = true,
		_ko = true
	})[__wf_atom_b953295d():c_str()] then
		return true
	end

	if not __wf_atom_7e8ad928(object) and p ~= nil then
		object:__wf_atom_e57658c2(p, 77, 0)
	end

	return false
end

function ServerSideSettings()
	local serverSideSettings = SF.ServerSideSettings()

	if __wf_atom_7e8ad928(gGameData) then
		return serverSideSettings
	end

	serverSideSettings.mGiftMode = gGameData:__wf_atom_2fbeb6e7()
	serverSideSettings.mFriendInvRestriction = gGameData:__wf_atom_24334184()
	serverSideSettings.mGuildInvRestriction = gGameData:__wf_atom_3c10315a()
	serverSideSettings.mShowFriendInvNotifications = gGameData:__wf_atom_976dbea5()
	serverSideSettings.mTradingRulesConfirmed = gGameData:__wf_atom_d9029264()
	serverSideSettings.mSubscribedToSurveys = gGameData:__wf_atom_9c49b584()
	return serverSideSettings
end

local function fn117(object, list)
	local count = #gGameData:__wf_atom_0f109cd4()

	if not (count >= 1000) then
		return false
	end

	local v21 = Localize("/Lotus/Language/Menu/SocialOverlay_FriendLimitError", {
		NUM_FRIENDS = count,
		MAX_FRIENDS = 1000
	})

	if __wf_atom_7e8ad928(object) or #list == 0 or not object:__wf_atom_f62a8704(list, { "false", v21 }) then
		module.ShowMessage(v21)
	end

	return true
end

function FriendLimitReached(p, p2)
	return fn117(p, p2)
end

local function fn118(name, p)
	local v21 = fn5()

	function v21.UtilOnAddFriend(p2, p3)
		local v22

		if p2 then
			v22 = v21.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_FriendAddConfirm", true, {
				NAME = name
			})
		else
			v22 = v21.mMovie:__wf_atom_8e9ac384(module.ParseAddFriendErrorMsg(p3), true)
		end

		if v21[p] and not v21.mMovie:__wf_atom_f62a8704(p, { p2 and "true" or "false", v22, p3 }) then
			module.ShowMessage(v22)
		end
	end

	function v21.UtilAddFriendMessage(p2, _, p3)
		if not __wf_atom_7e8ad928(p3) and tonumber(p3) == 4 then
			local __wf_atom_ed508ae4 = Engine.__wf_atom_ed508ae4(name)

			if __wf_atom_ed508ae4 ~= "" then
				name = __wf_atom_ed508ae4
			end

			gGameData:AddFriend(name, p2, "UtilOnAddFriend")
		end
	end

	function v21.UtilAddFriendMessageOSK(p2, p3)
		if not p2 then
			local __wf_atom_ed508ae4 = Engine.__wf_atom_ed508ae4(name)

			if __wf_atom_ed508ae4 ~= "" then
				name = __wf_atom_ed508ae4
			end

			gGameData:AddFriend(name, p3, "UtilOnAddFriend")
		end
	end

	return v21.mMovie
end

function AddFriend(p, value, p2)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local mMovie = fn118(p, value or "OnAddFriend")

	if fn117(mMovie, value) then
		return
	end

	local __wf_atom_940f8971 = Engine.__wf_atom_940f8971(p)

	if Engine.__wf_atom_84bb79c2() and (__wf_atom_940f8971 == 1 or __wf_atom_940f8971 == 6) then
		mMovie:__wf_atom_f62a8704("UtilAddFriendMessage", { "", "", 4 })
	elseif p2 == nil then
		fn79(mMovie, "/Lotus/Language/Menu/Message", "", 200, "UtilAddFriendMessage", "UtilAddFriendMessageOSK", {
			isMultiline = true
		})
	else
		mMovie:__wf_atom_f62a8704("UtilAddFriendMessage", { p2, "", 4 })
	end
end

function GetSyndicateBackgroundAlignments(p)
	local v21 = v15[p]

	if __wf_atom_7e8ad928(v21) then
		return v15.Default
	end

	if __wf_atom_7e8ad928(v21.Alpha) then
		v21.Alpha = v15.Default.Alpha
	end

	return v21
end

function ForceCloseTransmission(p)
	local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("PreviewClose", "true")
	end

	if p then
		_T.QueuedTransmissions = {}
	end
end

function GetNetworkAnalysisURL(p)
	local v21 = ""

	if p == "error" then
		return v21
	end

	if Engine.__wf_atom_578fc9dd() then
		if p == "firewall" then
			v21 = "https://kf.qq.com/faq/201107VJry2m201107A3YJvA.html"
		elseif p == "dnsfailure" then
			v21 = "https://kf.qq.com/faq/201107Vb2uiA201107JNBZbq.html"
		elseif p == "strictNAT" then
			v21 = "https://kf.qq.com/faq/201107zmeaQz201107MZv22I.html"
		elseif p == "upnpnotdetected" then
			v21 = "https://kf.qq.com/faq/201107N77bYJ201107VvUzqQ.html"
		elseif p == "upnpenabled" then
			v21 = "https://kf.qq.com/faq/201107b22QBR201107mYR32Q.html"
		elseif p == "portinuse" then
			v21 = "https://wf.qq.com/newsDetail.shtml?tid=13969838"
		else
			v21 = v21
		end

		if v21 == "" then
			return "https://soulframe.com/zh-hans/" .. p
		end

		return v21
	else
		local v22 = tostring(__wf_atom_b953295d())
		local v23 = v22:sub(2, #v22)
		return "https://soulframe.com/" .. (v23 == "pt" and "pt-br" or v23 == "zh" and "zh-hans" or v23 == "tc" and "zh-hant" or v23) .. "/" .. p
	end
end

function AvatarHasActiveActions(object, p, p2, p3)
	if object:__wf_atom_40a4ba6c() then
		return true
	end

	local __wf_atom_be6b2a2f = object:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()
	local v21 = not __wf_atom_7e8ad928(__wf_atom_be6b2a2f)

	if not (v21 and p) then
		return v21
	end

	if p2 then
		__wf_atom_be6b2a2f:Disable()
		return v21
	end

	if p3 == nil then
		p3 = false
	end

	object:AbortContextAction(p3)
	return v21
end

function ShouldHideConsumable(p)
	if __wf_atom_7e8ad928(p) then
		return true
	end

	return false
end

function ShouldShowRoomDecorationReset()
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v21, _, v22 = fn113()

	if
		not (__wf_atom_7e8ad928(__wf_atom_257dee98) or __wf_atom_7e8ad928(__wf_atom_257dee98:__wf_atom_a2e79445(__wf_atom_c4f78a8f:__wf_atom_e800787c())))
		or gGameRules:InDojo()
	then
		return false
	end

	if __wf_atom_7e8ad928(gGameData) then
		return not gGameRules:IsA(__wf_atom_9a88b479)
	end

	local __wf_atom_ba271528 = gGameData:__wf_atom_ba271528(true, v22)
	local v23 = false

	for i = 1, #__wf_atom_ba271528 do
		if __wf_atom_ba271528[i].mName ~= v21 then
			continue
		end

		if #__wf_atom_ba271528[i].mPlacedDecos == 0 then
			return false
		end

		v23 = true
		break
	end

	return not not v23 and not gGameRules:IsA(__wf_atom_9a88b479)
end

function GetMissionName(p)
	if __wf_atom_7e8ad928(gGameRules) then
		return ""
	end

	local v21 = p or gGameRules:__wf_atom_72fc675e()
	local location = v21.location
	local v22 = tostring(location)
	local v23 = fn21()
	local v24

	if __wf_atom_7e8ad928(v23) then
		v24 = v22
	else
		v24 = Localize(v23:__wf_atom_28a454ee(location):c_str(), false)
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_92662866 = gGameData:__wf_atom_92662866()

		for i = 1, #__wf_atom_92662866.mGoals do
			local mGoal = __wf_atom_92662866.mGoals[i]

			if tostring(mGoal.mId) ~= v21.goalId then
				continue
			end

			if mGoal.mNode ~= "" and mGoal.mNode == v22 then
				v24 = Localize(mGoal.mDesc, false)
				break
			end

			local flag = false

			for j = 1, #mGoal.mConcurrentNodes do
				if not (mGoal.mConcurrentNodes[j] ~= "" and mGoal.mConcurrentNodes[j] == v22) then
					continue
				end

				v24 = Localize(mGoal.mDesc, false)

				if
					j <= #mGoal.mConcurrentNodeReqs
					and mGoal.mConcurrentNodeReqs[j] >= mGoal.mGoal
					and mGoal.mTag ~= Symbol("WaterFight")
				then
					v24 ..= " " .. Localize("/Lotus/Language/Menu/WorldStateChallengeMode", false)
				end

				flag = true
				break
			end

			if flag then
				break
			end
		end

		if v21.alertId ~= "" then
			for i = 1, #__wf_atom_92662866.mAlerts do
				local mAlert = __wf_atom_92662866.mAlerts[i]

				if tostring(mAlert.mId) ~= v21.alertId or mAlert.mTag == EMPTY_SYMBOL then
					break
				end

				v24 = Localize(tostring(mAlert.mMissionInfo.descText), false)
				break
			end
		end
	end

	if #v24 == 0 then
		v24 = Localize(v21.uniqueName, false)
	end

	if not __wf_atom_7e8ad928(v21.keyChainName) or #v24 == 0 then
		local v25 = Resource(v21.levelKeyName)

		if not __wf_atom_7e8ad928(v25) then
			local __wf_atom_014a76a2 = v25:__wf_atom_014a76a2()
			v24 = Localize(__wf_atom_014a76a2:c_str(), false)
		end
	end

	if #v24 == 0 and not __wf_atom_7e8ad928(v21.levelOverride) then
		local __wf_atom_5b41f63b = v21.levelOverride:__wf_atom_5b41f63b()

		if string.find(__wf_atom_5b41f63b, "Derelict") then
			v24 = Localize("/Lotus/Language/Locations/Derelict", false)
		elseif string.find(__wf_atom_5b41f63b, "OrokinTower") then
			v24 = Localize("/Lotus/Language/Locations/Void", false)
		end
	end

	if gGameRules:IsA(__wf_atom_589d05aa) and gGameRules:__wf_atom_61f80302() then
		v24 = Localize("/Lotus/Language/Missions/MissionName_Badlands", { MISSION_NAME = v24 })
	end

	if #v24 == 0 and string.find(v22, "Kullervo") then
		return (Localize("/Lotus/Language/Duviri/ThePrison", false))
	end

	return v24
end

function HasUnlockedHardMode()
	local v21 = Symbol("TeshinHardModeUnlocked")

	if not __wf_atom_7e8ad928(gGameData) then
		return (gGameData:__wf_atom_7f86fc42(v21))
	end

	if __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		return false
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return (__wf_atom_9be88b01:__wf_atom_7f86fc42(v21))
		end
	end

	return false
end

local function fn119(object, baseNodeName, p)
	__wf_atom_83c14687(0)

	if p then
		print("GetRegionSectorForNode " .. tostring(baseNodeName))
	end

	if __wf_atom_7e8ad928(object) or baseNodeName == nil then
		return nil, nil
	end

	local __wf_atom_db2d8292 = object:__wf_atom_db2d8292(baseNodeName)

	if not __wf_atom_db2d8292 then
		return nil, nil
	end

	for i = 1, #__wf_atom_db2d8292.sectors do
		local sector = __wf_atom_db2d8292.sectors[i]

		if sector.name ~= baseNodeName then
			continue
		end

		local missionForLocation = object:BuildMissionForLocation(sector.name)

		if p then
			print("Found sector mission")
			print("Unique name: " .. tostring(missionForLocation.uniqueName))
		end

		return __wf_atom_db2d8292, sector, missionForLocation
	end

	return nil, nil
end

function GetMissionVoteInfo(object, data, p)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.name) then
		return nil, nil, nil
	end

	local name = tostring(data.name)
	local baseNodeName = data.baseNodeName

	if data.hubMission then
		local hubMission = data.hubMission
		local v21 = string.find(hubMission, HARD_MODE_TAG)

		if v21 ~= nil then
			hubMission = string.sub(hubMission, 1, v21 - 1)
		end

		baseNodeName = Symbol(hubMission)
	end

	local v21, v22, v23 = fn119(object, baseNodeName, p)
	local mMissionInfo = nil
	local v24 = nil
	local descText = nil
	local name2 = nil
	local nightmare = false
	local voidStorm = false
	local v25 = false

	if v22 then
		if p then
			print("Sector: " .. tostring(v22.name))
			print("Pending mission: " .. name)
		end

		if string.find(name, ALERT_TAG) then
			if _T.CachedAlerts then
				local cachedAlert = _T.CachedAlerts[tostring(data.baseNodeName)]

				if cachedAlert then
					mMissionInfo = cachedAlert.mAlertInfo.mMissionInfo
					mMissionInfo.alertId = tostring(cachedAlert.mAlertInfo.mId)
					descText = Localize("/Lotus/Language/Menu/Notification_Alert", nil)
					local baseNodeName2 = tostring(data.baseNodeName)

					if
						_T.CachedAlerts[baseNodeName2]
						and _T.CachedAlerts[baseNodeName2].mAlertInfo.mTag ~= EMPTY_SYMBOL
						and _T.CachedAlerts[baseNodeName2].mAlertInfo.mMissionInfo.descText ~= EMPTY_SYMBOL
					then
						v24 = Localize(tostring(_T.CachedAlerts[baseNodeName2].mAlertInfo.mMissionInfo.descText), false)
					end
				end
			end
		elseif string.find(name, EVENT_TAG) then
			if _G.CachedGoalInfo then
				local v26 = _G.CachedGoalInfo[tostring(data.baseNodeName)]

				if
					v26 == nil
					and _T.LockedGoalList ~= nil
					and _T.LockedGoalList[tostring(data.baseNodeName)]
					and _T.LockedGoalMissionInfo ~= nil
				then
					v26 = _T.LockedGoalMissionInfo[tostring(data.baseNodeName)]
				end

				if v26 then
					mMissionInfo = v26.mMissionInfo
					mMissionInfo.goalId = tostring(v26.mId)

					if mMissionInfo.goalTag == EMPTY_SYMBOL then
						mMissionInfo.goalTag = v26.mTag
					end

					v24 = Localize(v26.mDesc, false)
				elseif _T.LockedGoalList and _T.LockedGoalList[tostring(data.baseNodeName)] then
					v24 = Localize(_T.LockedGoalList[tostring(data.baseNodeName)].mDesc, false)
				end
			end
		elseif string.find(name, SYNDICATE_MISSION_TAG) then
			if _T.CachedSyndicateMissions then
				local cachedSyndicateMission = _T.CachedSyndicateMissions[tostring(data.baseNodeName)]

				if cachedSyndicateMission then
					mMissionInfo = cachedSyndicateMission.mMissionInfo
					descText = Localize("/Lotus/Language/Menu/SyndicateMissionName", nil)
				end
			end
		elseif string.find(name, SORTIE_MISSION_TAG) then
			if _T.CachedSortieMissions then
				local cachedSortieMission = _T.CachedSortieMissions[tostring(data.baseNodeName)]

				if cachedSortieMission then
					mMissionInfo = cachedSortieMission.mMissionInfo
					descText = Localize("/Lotus/Language/Menu/SortieMissionName", nil)
				end
			end
		elseif string.find(name, LITE_SORTIE_MISSION_TAG) then
			if _T.CachedLiteSortieMissions then
				local cachedLiteSortieMission = _T.CachedLiteSortieMissions[tostring(data.baseNodeName)]

				if cachedLiteSortieMission then
					mMissionInfo = cachedLiteSortieMission.mMissionInfo
					descText = Localize("/Lotus/Language/WorldStateWindow/LiteSortieMissionName", nil)
				end
			end
		elseif string.find(name, ACTIVE_MISSION_TAG) then
			if _T.CachedActiveMissions then
				local cachedActiveMission = _T.CachedActiveMissions[tostring(data.baseNodeName)]

				if cachedActiveMission then
					mMissionInfo = cachedActiveMission.mMissionInfo
					descText = tostring(cachedActiveMission.mMissionInfo.descText)
				end
			end
		elseif string.find(name, INVASION_DEFENDER_TAG) then
			if _T.CachedInvasionInfo then
				local baseNodeName2 = tostring(data.baseNodeName)
				local v26 = _T.CachedInvasionInfo[baseNodeName2]

				if v26 then
					mMissionInfo = v26.mDefenderMissionInfo
					mMissionInfo.invasionId = tostring(v26.mId)
					mMissionInfo.invasionAllyFaction = v26.mAttackerMissionInfo.faction
					descText = Localize("/Lotus/Language/Menu/MissionIntro_Invasion", false) .. " (" .. Localize(
						"/Lotus/Language/Game/Faction_" .. tostring(v26.mAttackerMissionInfo:__wf_atom_7ebd1b67()) .. "UC",
						false
					) .. ")"

					if v26.mDefenderName ~= EMPTY_SYMBOL then
						descText = Localize(tostring(v26.mDefenderName), false)
					end

					for _, v27 in pairs(_G.CachedGoalInfo) do
						if not (v27 and v27.mInvasionNode == data.baseNodeName) then
							continue
						end

						v24 = Localize(v27.mDesc, false)
						break
					end
				end
			end
		elseif string.find(name, INVASION_ATTACKER_TAG) then
			if _T.CachedInvasionInfo then
				local baseNodeName2 = tostring(data.baseNodeName)
				local v26 = _T.CachedInvasionInfo[baseNodeName2]

				if v26 then
					mMissionInfo = v26.mAttackerMissionInfo
					mMissionInfo.invasionId = tostring(v26.mId)
					mMissionInfo.invasionAllyFaction = v26.mDefenderMissionInfo.faction
					descText = Localize("/Lotus/Language/Menu/MissionIntro_Invasion", false) .. " (" .. Localize(
						"/Lotus/Language/Game/Faction_" .. tostring(v26.mDefenderMissionInfo:__wf_atom_7ebd1b67()) .. "UC",
						false
					) .. ")"

					if v26.mAttackerName ~= EMPTY_SYMBOL then
						descText = Localize(tostring(v26.mAttackerName), false)
					end

					for _, v27 in pairs(_G.CachedGoalInfo) do
						if not (v27 and v27.mInvasionNode == data.baseNodeName) then
							continue
						end

						v24 = Localize(v27.mDesc, false)
						break
					end
				end
			end
		elseif string.find(name, NIGHTMARE_TAG) then
			descText = Localize("/Lotus/Language/Menu/NightmareModeName", nil)
			nightmare = true
		elseif string.find(name, PVP_TAG) or v22.nodeType == 2 then
			if _G.CachedGoalInfo then
				local v26 = _G.CachedGoalInfo[tostring(data.baseNodeName)]

				if v26 then
					v24 = Localize(v26.mDesc, false)
				end

				v25 = true
			end
		elseif string.find(name, SORTIE_MISSION_TAG) and _T.CachedSortieMissions then
			local cachedSortieMission = _T.CachedSortieMissions[tostring(data.baseNodeName)]

			if cachedSortieMission then
				mMissionInfo = cachedSortieMission.mMissionInfo
				descText = Localize("/Lotus/Language/Menu/Notification_Sortie", nil)
			end
		elseif string.find(name, ACTIVE_MISSION_TAG) and _T.CachedActiveMissions then
			local cachedActiveMission = _T.CachedActiveMissions[tostring(data.baseNodeName)]

			if cachedActiveMission then
				mMissionInfo = cachedActiveMission.mMissionInfo
				descText = Localize("/Lotus/Language/Menu/Notification_ActiveMission", nil)
			end
		elseif string.find(name, KUVA_TOWER_MISSION_TAG) and _T.CachedGhostTowerMissions then
			local cachedGhostTowerMission = _T.CachedGhostTowerMissions[tostring(data.baseNodeName)]

			if cachedGhostTowerMission then
				mMissionInfo = cachedGhostTowerMission.mMissionInfo
				local ternary = module.Ternary(
					mMissionInfo.minEnemyLevel >= 80,
					"/Lotus/Language/Menu/GhostTowerHardMissionName",
					"/Lotus/Language/Menu/GhostTowerMissionName"
				)
				descText = Localize(ternary, nil)
			end
		elseif string.find(name, NEMESIS_MISSION_TAG) then
			if _T.CachedNemesisMissions and _T.CachedNemesisMissions[tostring(data.baseNodeName)] then
				mMissionInfo = _T.CachedNemesisMissions[tostring(data.baseNodeName)].mMissionInfo:Copy()
			else
				local rank = data.nemesis.rank
				local faction = data.nemesis.faction
				local name3 = data.nemesis.name
				mMissionInfo = fn116(data.baseNodeName, rank, faction, name3):Copy()
			end

			descText = mMissionInfo.uniqueName
		elseif string.find(name, VOID_STORM_TAG) then
			voidStorm = true
		elseif __wf_atom_7e8ad928(data.job) then
			if string.find(name, "_Cell") and _T.CachedCellMissions then
				local cachedCellMission = _T.CachedCellMissions[tostring(data.baseNodeName)]

				if cachedCellMission then
					mMissionInfo = cachedCellMission.mMissionInfo
				end
			elseif string.find(name, ELITE_ALERT_TAG) then
				if _T.CachedEliteAlertMissions then
					descText = Localize("/Lotus/Language/Menu/AlertHardMode", nil)
					local cachedEliteAlertMission = _T.CachedEliteAlertMissions[tostring(data.baseNodeName)]

					if cachedEliteAlertMission then
						mMissionInfo = cachedEliteAlertMission.mMissionInfo
					end
				end
			elseif string.find(name, HARD_DAILY_TAG) and _T.CachedHardModeDailyMissions then
				descText = Localize("/Lotus/Language/Labels/SteelPathDaily", nil)

				if _T.CachedHardModeDailyMissions[tostring(data.baseNodeName)] then
					mMissionInfo = _T.CachedHardModeDailyMissions[tostring(data.baseNodeName)].mission
				end
			elseif
				string.find(name, HARD_MODE_TAG)
				or data.hubMission and string.find(data.hubMission, HARD_MODE_TAG) ~= nil
			then
				descText = Localize("/Lotus/Language/Labels/HardMode", nil)
			end
		else
			local v26 = Resource(data.job)

			if not __wf_atom_7e8ad928(v26) then
				descText = Localize(tostring(v26:__wf_atom_4f3855f9()), nil)

				if data.isHardJob then
					descText ..= " (" .. Localize("/Lotus/Language/Labels/HardMode", true) .. ")"
				end
			end
		end

		if not mMissionInfo then
			if p then
				print("Using sector data")
			end

			v23.nightmare = nightmare
			v23.voidStorm = voidStorm
			local v26 = voidStorm
				and _T.CachedVoidStormMissions ~= nil
				and _T.CachedVoidStormMissions[tostring(data.baseNodeName)]

			if v26 then
				v23.activeMissionTag = v26.tier
				local enemyLevelIncrease = v26.enemyLevelIncrease
				v23.minEnemyLevel += enemyLevelIncrease
				v23.maxEnemyLevel += enemyLevelIncrease
				v23.minSpaceEnemyLevel += enemyLevelIncrease
				v23.maxSpaceEnemyLevel += enemyLevelIncrease
			end

			if nightmare and v23.missionType == 8 then
				v23.maxWaveNum = 10
			end

			if v22.name == ENTRATI_LANDSCAPE_NODE_TAG and not (fn60() or __wf_atom_7e8ad928(gClient)) then
				v23.soloMode = true
			end

			mMissionInfo = v23
		end

		if v22.missionTag == Symbol("RECONSTRUCTION") and _T.CachedConstructionProjects then
			for _, cachedConstructionProject in pairs(_T.CachedConstructionProjects) do
				if not (cachedConstructionProject.info.mNode == data.baseNodeName and cachedConstructionProject.progress == 1) then
					continue
				end

				local location = Localize(v22.locTag:c_str(), nil)
				v24 = Localize("/Lotus/Language/RelayReconstruction/ReconstructionSiteAttack", {
					LOCATION = location
				})
			end
		end

		if v22.name == APARTMENT_NODE_TAG then
			v24 = Localize("/Lotus/Language/Zariman/ZarimanApartment", {})
		end

		mMissionInfo.levelKeyName = nil
		v24 = v24 or Localize(v22.locTag:c_str(), nil)

		if IsDuviriNode(name) then
			name2 = Localize("/Lotus/Language/Duviri/Duviri", {})
		else
			name2 = v21.name
		end
	else
		if p then
			print("No sector")
		end

		if name == "Photobooth" then
			local sfMissionInfo = SF.SFMissionInfo()
			sfMissionInfo.gameRules = WeakResource("/SF/Types/GameRules/SFPhotoBoothGameRules")
			return sfMissionInfo, (Localize("/Lotus/Language/Menu/Loadout_Photobooth", nil))
		elseif name == "Simulacrum" then
			local sfMissionInfo = SF.SFMissionInfo()
			sfMissionInfo.gameRules = WeakResource("/SF/Types/GameRules/SFDangerRoomGameRules")
			return sfMissionInfo, (Localize("/Lotus/Language/Game/DangerRoomConsole", nil))
		else
			local v26 = string.find(name, KEY_TAG)

			if v26 ~= nil then
				if p then
					print("Key index found")
				end

				local v27 = string.sub(name, 1, v26 - 1)
				local v28 = Resource(v27)

				if not __wf_atom_7e8ad928(v28) then
					local __wf_atom_1c4ed35a = v28:__wf_atom_1c4ed35a()

					if p then
						print("Getting mission from key")
					end

					mMissionInfo = v28:__wf_atom_72fc675e()
					mMissionInfo.levelKeyName = WeakResource(v27)

					if data.quest ~= nil then
						mMissionInfo.keyChainName = WeakResource(data.quest)
					end

					if data.difficulty ~= nil and data.difficulty >= 0 then
						mMissionInfo.difficulty = data.difficulty
					end

					if mMissionInfo.uniqueName == "" then
						v24 = Localize(tostring(v28:__wf_atom_014a76a2()), false)
					else
						v24 = Localize(mMissionInfo.uniqueName, false)
					end

					if IsDuviriNode(name) then
						name2 = Localize("/Lotus/Language/Duviri/Duviri", {})

						if string.find(name, HARD_MODE_TAG) then
							descText = Localize("/Lotus/Language/Labels/HardMode", nil)
						end
					else
						name2 = object:__wf_atom_161b95d4()[__wf_atom_1c4ed35a].name
					end
				end
			end

			if mMissionInfo then
				if data.scenarioId then
					mMissionInfo.scenarioId = data.scenarioId
					v24 = Localize("/Lotus/Language/G1Quests/FlotillaOperation", nil) .. ": " .. v24
					name2 = nil
				end

				if data.goalId then
					mMissionInfo.goalId = data.goalId
				end

				if data.metadata then
					mMissionInfo.metadata = data.metadata
				end

				if data.syndicateId then
					mMissionInfo.syndicateId = data.syndicateId
				end
			end
		end
	end

	if name2 and not v25 and mMissionInfo.missionType ~= 30 then
		local ternary = module.Ternary(mMissionInfo.missionType == 32, "_SPACE", "")
		v24 ..= " (" .. Localize(name2 .. ternary, false) .. ")"
	end

	if descText then
		v24 ..= " - " .. descText
	end

	if mMissionInfo then
		return mMissionInfo, v24
	else
		print("GetMissionVoteInfo failed for " .. tostring(data.name))
	end

	return nil, nil, nil
end

function BuildMissionMapString(p, p2)
	local v21

	if p == nil then
		v21 = false
	else
		v21 = p ~= ""
	end

	if p2 == __wf_atom_3e61816b(0) then
		if v21 then
			return p
		end

		return ""
	elseif v21 then
		return p .. "_" .. tostring(p2)
	else
		return (tostring(p2))
	end
end

function RefreshPetsAfterSell()
	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_a45f5d5f()

		if __wf_atom_7e8ad928(gGameData:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0).mItemType) then
			local v21 = fn12()

			if not __wf_atom_7e8ad928(v21) then
				v21:Destroy()
			end

			local entity = module.GetEntityFromTag("MoaInteractionAction")

			if not __wf_atom_7e8ad928(entity) then
				entity:Disable()
			end
		end
	end
end

function GetResearchProgress(data)
	local v21 = Resource(data.mItemType)
	local __wf_atom_0df579e8 = v21:__wf_atom_0df579e8()
	local v22 = (__wf_atom_0df579e8 - data.mReqCredits) / __wf_atom_0df579e8 * 0.2
	local __wf_atom_c4eef360 = v21:__wf_atom_c4eef360()

	for i = 1, #__wf_atom_c4eef360 do
		for j = 1, #data.mReqItems do
			if data.mReqItems[j].mItemType ~= __wf_atom_c4eef360[i].mItemType then
				continue
			end

			local mItemCount = data.mReqItems[j].mItemCount
			v22 += (__wf_atom_c4eef360[i].mItemCount - mItemCount) / __wf_atom_c4eef360[i].mItemCount * 0.2
		end
	end

	return v22
end

local function fn120(value)
	if __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_a04e4a53() < 30 then
		for _, v21 in ipairs({ "truemaster", "truemasteralt" }) do
			local v22 = ":" .. v21 .. ":"
			local v23, v24 = string.find(__wf_atom_d99ae0ec(value), v22)

			while v23 ~= nil do
				value = string.gsub(value, string.sub(value, v23, v24), ":clem:")
				v23, v24 = string.find(__wf_atom_d99ae0ec(value), v22)
			end
		end
	end

	return value
end

function ValidateTrueMaster(p)
	return fn120(p)
end

function SetMOTD(p, p2, p3)
	if p3 == nil then
		p3 = false
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local v21 = fn120(p)
		gGameData:__wf_atom_2fda7300(v21, p2, p3)
	end
end

function GetSlotType(p)
	return SLOT_TYPES[p] or "NOT_RECOGNIZED"
end

function AutofocusTextfield(object)
	if Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69() or _T.ChatMaximized then
		return false
	end

	if __wf_atom_7e8ad928(object) then
		return true
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return true
	end

	local settings = __wf_atom_18a5d83b:Settings()

	if __wf_atom_7e8ad928(settings) then
		return true
	end

	local __wf_atom_e2387c18 = settings:__wf_atom_e2387c18()

	if __wf_atom_e2387c18 == 2 then
		return not object:Execute("IsEndOfMatch", "")
	end

	return __wf_atom_e2387c18 == 1
end

function ReturnToDojo(abortedRailjackMission)
	if gRegion:IsMaster() then
		if gGameData:__wf_atom_503b306e() then
			if _T.RailjackStopHullBreach then
				_T.RailjackStopHullBreach()
			end
		else
			Engine.Disconnect(false)
			return
		end
	end

	_T.AbortedRailjackMission = abortedRailjackMission
	_T.ReturningToDojo = true
	_T.RailjackAutoLaunchPending = nil

	if _T.AbortedRailjackMission and gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(Symbol("RJMissionAborted"), 1)
	end

	if fn91(gGameData) then
		_T.RailJackNextMissionNode = "ReplayQuest"
	else
		local name = (__wf_atom_7e8ad928(gGameData) or not gMatchingService:__wf_atom_a676a953())
			and "CrewBattleNodeDojo"
			or tostring(gGameData:__wf_atom_6819071c().location) .. "_HUB"
		_T.RailJackNextMissionNode = Symbol(name)
		_T.SeamlessRailJackTransition = gGameRules:IsA(__wf_atom_311a7128)
		local encoded = cjson.encode({ name = name, difficulty = 0 })
		gMatchingService:SendSquadMission(encoded)
	end

	local __wf_atom_d5226f21 = fn21():__wf_atom_d5226f21(Symbol("CrewShipGenericTunnel"))
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if not __wf_atom_7e8ad928(__wf_atom_257dee98) then
		__wf_atom_257dee98:__wf_atom_f7aa6106(__wf_atom_d5226f21.mission)
	end

	if not __wf_atom_7e8ad928(_T.ClearRailjackMissionState) then
		_T.ClearRailjackMissionState()
	end
end

function IsPlayerInCrewship()
	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	return not (__wf_atom_7e8ad928(__wf_atom_257dee98) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_257dee98:__wf_atom_a2e79445(__wf_atom_c4f78a8f:__wf_atom_e800787c())))
end

function ApplyCensorshipOverridesAndAttachments(object, list, list2, list3, list4)
	if __wf_atom_d9227398() or __wf_atom_72884638("Graphics.UseWeGameCensoring") then
		for i = 1, #list do
			object:__wf_atom_a887a262(i - 1, list[i], false)
		end

		for i = 1, #list2 do
			local v21 = Vector()
			local v22 = Rotation()

			if i <= #list3 then
				v21 = list3[i]
			end

			if i <= #list4 then
				v22 = list4[i]
			end

			object:Attach(list2[i], Symbol(), v21, v22)
		end
	end
end

local function fn121(p, list, mMovie, list2)
	local v21

	if tonumber(p) == 4 then
		v21 = gGameData:ToggleIgnoreUser(list)
	end

	if not __wf_atom_7e8ad928(mMovie) and #list2 > 0 then
		mMovie:__wf_atom_f62a8704(list2, { list, (tostring(v21)) })
	end
end

function ToggleIgnoreUser(user, p, p2)
	if #user < 0 then
		module.ShowErrorMessage(Localize("/Lotus/Language/Menu/Chat_InvalidUser", { USER = user }))
		return
	end

	local v21 = fn5()

	local function fn122()
		if gGameData:__wf_atom_56f280e3(Engine.__wf_atom_ba49d4ed(user)) or #gGameData:__wf_atom_3e688291() < 100 then
			fn121(tostring(4), user, v21.mMovie, p2)
			return
		end

		function v21.UtilOnIgnoreUser(p3)
			fn121(p3, user, v21.mMovie, p2)
		end

		module.ShowConfirmMessage(
			Localize("/Lotus/Language/Labels/IgnoreLimitReached", { PLAYER_NAME = user }),
			"UtilOnIgnoreUser"
		)
	end

	if not p then
		fn122()
		return
	end

	function v21.UtilAccountIdResult(p3, _)
		if p3 then
			fn122()
		else
			module.ShowErrorMessage(Localize("/Lotus/Language/Menu/SocialOverlay_NonExistentUserError", {
				USER = user
			}))
		end
	end

	gGameData:__wf_atom_6a4bcc2b(user, true, "UtilAccountIdResult")
end

function IsEmptyLevel()
	local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

	if __wf_atom_7e8ad928(__wf_atom_22941262) then
		return false
	end

	local __wf_atom_5b41f63b = __wf_atom_22941262:__wf_atom_5b41f63b()
	return string.find(__wf_atom_5b41f63b, "EmptyLevel") ~= nil
end

fn4 = function(p)
	local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

	if __wf_atom_7e8ad928(__wf_atom_22941262) then
		return false
	end

	local __wf_atom_5b41f63b = __wf_atom_22941262:__wf_atom_5b41f63b()
	local selected = string.find(__wf_atom_5b41f63b, "TNWDrifterCamp") ~= nil

	if not selected or p == nil then
		return selected
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return true
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		if __wf_atom_9be88b01:__wf_atom_247a5d2e(true).mBootLocation == 1 then
			return p
		end

		return not p
	end

	return true
end

function IsCampLevel(p)
	return (fn4(p))
end

function _IsApartmentLevel()
	if __wf_atom_7e8ad928(gRegion) then
		return false
	end

	local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

	if __wf_atom_7e8ad928(__wf_atom_22941262) then
		return false
	end

	local __wf_atom_5b41f63b = __wf_atom_22941262:__wf_atom_5b41f63b()
	return string.find(__wf_atom_5b41f63b, "ZarimanHubApartment") ~= nil
		or string.find(__wf_atom_5b41f63b, "PBZarApartment") ~= nil
end

function IsApartmentLevel()
	return (_IsApartmentLevel())
end

function SetLoginCameraSpot()
	local v21 = nil
	local v22

	if fn4(false) then
		v22 = gGameRules:IsA(WeakResource("/Lotus/Types/GameRules/CampFirstLoadFrontEndGameRules"))
			and "LoginCampPreview"
			or v21

		if v22 == nil then
			_T.SkipDropShipCinematic = true
			v22 = "LoginCamp"
		end
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)
		v22 = not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
			and IsParadoxPath(__wf_atom_18a5d83b:__wf_atom_9be88b01())
			and "ParadoxPathLogin"
			or v21
	end

	_T.BackgroundMovie:__wf_atom_f62a8704("PlayCameraTransition", { v22 or "Login", 0.1 })
end

function QuestRequiresLotusHelmet(_)
	return false
end

function ShowBeginZarimanQuestWarning(object, list, _, callback)
	local v21 = ""
	local notifications = _T.Notifications

	if notifications ~= nil then
		local currentNotifications = notifications:GetCurrentNotifications()

		if #currentNotifications > 0 then
			local v22 = {
				notifications.ATTACK_POLARITY,
				notifications.DEFENSE_POLARITY,
				notifications.TACTIC_POLARITY,
				notifications.POWER_POLARITY,
				notifications.WARD_POLARITY
			}
			local v23 = v22[1]
			local __wf_atom_77042b79 = gGameData:__wf_atom_77042b79()

			for i = 1, #list do
				if list[i] ~= __wf_atom_77042b79 then
					continue
				end

				v23 = v22[i]
				break
			end

			if currentNotifications[v23] ~= nil and currentNotifications[v23].Value == 1 then
				v21 ..= Localize("/Lotus/Language/ZarimanQuest/BeginWarningFocusDesc", {})
			end
		end
	end

	if not __wf_atom_7e8ad928((gGameData:GetInventory())) then
		if #v21 > 0 then
			v21 ..= "\r\n\r\n"
		end

		v21 ..= Localize("/Lotus/Language/ZarimanQuest/BeginWarningMoteAmpDesc", {})
	end

	if not (#v21 > 0) then
		return false
	end

	local v22 = fn5()
	local v23 = Localize(tostring(object:__wf_atom_014a76a2()), {})
	local v24 = Localize("/Lotus/Language/ZarimanQuest/BeginWarningConfirm", {})
	local v25 = Localize("/Lotus/Language/G1Quests/QuestCommitmentConfirm", {
		WORD = string.upper(v24)
	})
	local v26 = Localize("/Lotus/Language/ZarimanQuest/BeginWarningCommonDesc", {}) .. "\r\n\r\n" .. v21

	function v22.OSKConfirmZarimanQuestWarning(p, p2)
		callback(p, p2, Localize("/Lotus/Language/ZarimanQuest/BeginWarningConfirm", {}))
	end

	function v22.ConfirmZarimanQuestWarning(p, _, p2)
		callback(tonumber(p2) ~= 4, p, Localize("/Lotus/Language/ZarimanQuest/BeginWarningConfirm", {}))
	end

	local v27 = nil

	local function fn122(_, _)
		local v28, v29 = fn79(
			v22.mMovie,
			v23,
			v25,
			40,
			"ConfirmZarimanQuestWarning",
			"OSKConfirmZarimanQuestWarning",
			v27,
			false
		)

		if v28 and not __wf_atom_7e8ad928(v29) then
			v29:Execute("SetYesTag", "/Lotus/Language/ZarimanQuest/BeginWarningButton")
			v29:Execute("SetConditionalWord", string.lower(v24))
		end
	end

	if IsOSKAvailable(false) then
		module.ShowMessage(v26, fn122)
	else
		v27 = {
			desc = v26 .. "\r\n\r\n" .. v25
		}
		v25 = ""
		fn122()
	end

	return true
end

function GetLocalizedLotusName()
	return Localize("/Lotus/Language/Bosses/Lotus", {})
end

function PlayLoginAnim(p, p2)
	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_e06358f3(Symbol("IDLE"))

			if fn4(false) then
				__wf_atom_c4f78a8f:__wf_atom_51075230(Rotation(230, 0, 0))
				__wf_atom_c4f78a8f:__wf_atom_b54b3ddc(0)
			else
				if IsParadoxPath() then
					__wf_atom_c4f78a8f:__wf_atom_51075230(Rotation(30, 0, 0))
				elseif not fn4() and (not p2 or Engine.__wf_atom_e43a530e()) then
					__wf_atom_c4f78a8f:__wf_atom_51075230(Rotation())
				end

				if not p2 or Engine.__wf_atom_e43a530e() then
					local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

					if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
						p = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("KneelToStandTurn")) or p
					end

					__wf_atom_c4f78a8f:__wf_atom_921c1a5f(p, false, 3, 1, true)
				end
			end
		end
	end
end

function SetTimeOfDay(p)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			if not all[i]:__wf_atom_1d13ef4d() then
				continue
			end

			all[i]:SetTimeOfDay(p)
			return
		end
	end
end

local function fn122(p)
	if fn78() ~= UI_MODE_IN_SPACE_SHIP then
		return false
	end

	local v21 = p == 1

	if v21 then
		return v21
	end

	local mPrimeVaultTraders = gGameData:__wf_atom_92662866().mPrimeVaultTraders
	local v22 = nil

	for _, mPrimeVaultTrader in pairs(mPrimeVaultTraders) do
		if not (Engine.__wf_atom_db2b0cee(mPrimeVaultTrader.mActivation) <= 0) then
			continue
		end

		v22 = mPrimeVaultTrader
		break
	end

	if __wf_atom_7e8ad928(v22) then
		return v21
	end

	local sec = v22.mInitialStartDate.sec

	if Engine.__wf_atom_db2b0cee(sec) <= 0 then
		for i = 1, #v22.mScheduleInfo do
			local v23 = v22.mScheduleInfo[i]

			if Engine.__wf_atom_db2b0cee(v23.mExpiry.sec) > 0 then
				return true
			end
		end
	end

	return v21
end

function PrimeVaultTraderPresent(p)
	return fn122(p)
end

function PrimeVaultTraderFastTravel(p, object, object2)
	if not fn122(p) then
		return
	end

	local v21 = fn21()

	if not __wf_atom_7e8ad928(v21) then
		local v22 = Symbol("TradeHUB1")
		local v23 = v21:__wf_atom_d5226f21(v22).region + 1

		if fn49(v21, gGameData, v23) then
			local fn5_2 = fn5()

			function fn5_2.ConfirmMaroo(p2)
				if tonumber(p2) ~= 4 then
					return
				end

				if _T.InStarChart then
					_T.DesiredGoToNode = tostring(v22)

					if not __wf_atom_7e8ad928(object2) then
						object2:Execute("Close", "true")
					end
				else
					local v24 = {
						name = tostring(v22) .. HUB_TAG
					}
					local encoded = cjson.encode(v24)
					gGameData:__wf_atom_3f7ee611(23)
					gMatchingService:SendSquadMission(encoded)
				end
			end

			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 1
			dialogSettings.locString = "/Lotus/Language/Store/PrimeVaultTraderGotoConfirm"

			if not __wf_atom_7e8ad928(object) then
				dialogSettings.icon = object:__wf_atom_5b41f63b() .. ",512,256,0,left,nil,-50"
			end

			dialogSettings:SetCallback("ConfirmMaroo")
			module.ShowCustomMessage(dialogSettings)
		else
			module.ShowMessage("/Lotus/Language/Store/PrimeVaultTraderNodeLocked")
		end
	end
end

function UseGrineerShipAltsForCinematics(_)
	return false
end

function PlayerOwnsArcanes(className)
	local inventory = gGameData:GetInventory()
	local upgrades = inventory:GetUpgrades()

	for _, upgrade in ipairs(upgrades) do
		if upgrade.mItemCount > 0 and upgrade.mItemType:IsA(className) then
			return true
		end
	end

	local __wf_atom_063f1444 = inventory:__wf_atom_063f1444()

	for _, v21 in ipairs(__wf_atom_063f1444) do
		if v21.mItemCount > 0 and v21.mItemType:IsA(className) then
			return true
		end
	end

	return false
end

local v21 = {}

local function fn123(instance)
	local __wf_atom_f2d1696d = gGameRules:__wf_atom_f2d1696d()

	if __wf_atom_7e8ad928(__wf_atom_f2d1696d) then
		return instance
	end

	local result = {}

	for i = 0, 6 - 1 do
		local __wf_atom_7b88598a = __wf_atom_f2d1696d:__wf_atom_7b88598a(instance, i)

		for _, v22 in pairs(__wf_atom_7b88598a) do
			if not __wf_atom_7e8ad928(v22) then
				table.insert(result, v22)
			end
		end
	end

	for _, v22 in ipairs(v21) do
		local v23 = WeakResource(v22:__wf_atom_5b41f63b() .. "Base")

		if __wf_atom_7e8ad928(v23) then
			continue
		end

		if instance:IsA(v23) and instance ~= v22 then
			table.insert(result, v22)
		end

		if instance ~= v22 then
			continue
		end

		for i = 0, 6 - 1 do
			local __wf_atom_746bd9c1 = __wf_atom_f2d1696d:__wf_atom_746bd9c1(v23, i)

			if not __wf_atom_7e8ad928(__wf_atom_746bd9c1) then
				table.insert(result, __wf_atom_746bd9c1)
			end
		end
	end

	return result
end

local function fn124(mItemType, p, p2)
	local __wf_atom_f2d1696d = gGameRules:__wf_atom_f2d1696d()

	if __wf_atom_7e8ad928(__wf_atom_f2d1696d) then
		return mItemType
	end

	local v22

	if module.IsValueInTable(v21, mItemType) then
		v22 = WeakResource(mItemType:__wf_atom_5b41f63b() .. "Base")
	else
		v22 = mItemType
	end

	if __wf_atom_7e8ad928(v22) then
		return mItemType
	end

	local v23 = p2[p]
	local v24 = {}
	local v25 = nil

	for _, v26 in ipairs(v23) do
		v24[v26.mItemType:__wf_atom_5b41f63b()] = v26:__wf_atom_717d3c58(10)
	end

	for _, v26 in ipairs({ 4, 5, 2, 3, 0, 1 }) do
		local __wf_atom_7b88598a = __wf_atom_f2d1696d:__wf_atom_7b88598a(v22, v26)

		if __wf_atom_7e8ad928(__wf_atom_7b88598a) or not (#__wf_atom_7b88598a > 0) then
			continue
		end

		local v27 = {}

		for _, v28 in ipairs(__wf_atom_7b88598a) do
			if v24[v28:__wf_atom_5b41f63b()] then
				table.insert(v27, v28)
			end
		end

		if #v27 > 0 then
			__wf_atom_7b88598a = v27
		end

		local v28 = __wf_atom_7b88598a[__wf_atom_c08f5a0e(1, #__wf_atom_7b88598a)]

		if __wf_atom_7e8ad928(v28) then
			continue
		end

		for _, v29 in ipairs(v23) do
			if v29.mItemType ~= v28 then
				continue
			end

			if v24[v28:__wf_atom_5b41f63b()] then
				return v28
			end

			if v25 == nil then
				v25 = v28
			end
		end
	end

	if __wf_atom_7e8ad928(v25) then
		return mItemType
	end

	return v25
end

local function fn125(list, p)
	if __wf_atom_7e8ad928((gGameRules:__wf_atom_f2d1696d())) then
		return
	end

	local v22 = fn123(p)

	if #v22 == 0 then
		table.insert(v22, p)
	end

	local v23 = 1

	while v23 <= #list do
		__wf_atom_83c14687(0)
		local v24 = list[v23]
		local mItemType

		if type(v24) == "string" then
			local v25 = string.gsub(v24, "/StoreItems", "")
			mItemType = WeakResource(v25)
		else
			mItemType = list[v23].mItemType
		end

		if module.IsValueInTable(v22, mItemType) then
			table.remove(list, v23)
		else
			v23 += 1
		end
	end
end

local function fn126(list, p)
	local v22 = -1
	local v23 = -1
	local v24 = {}
	local v25 = nil

	for _, v26 in ipairs(list) do
		if p ~= v26.mItemType then
			continue
		end

		local mPolarized = v26.mPolarized
		local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(v26.mXP, v26.mItemType)

		if v22 < mPolarized then
			v23 = __wf_atom_b4a75eaa
			v22 = mPolarized
		elseif mPolarized == v22 and v23 < __wf_atom_b4a75eaa then
			v23 = __wf_atom_b4a75eaa
		end
	end

	for _, v26 in ipairs(list) do
		if not (p == v26.mItemType and v26.mPolarized == v22) then
			continue
		end

		local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(v26.mXP, v26.mItemType)

		if __wf_atom_7e8ad928(__wf_atom_b4a75eaa) or __wf_atom_b4a75eaa ~= v23 then
			continue
		end

		table.insert(v24, v26)
	end

	if #v24 > 0 then
		return v24[__wf_atom_c08f5a0e(1, #v24)]
	end

	return v25
end

local function fn127(object)
	if __wf_atom_7e8ad928(_T.xpInfoDictionary) then
		return false
	end

	local v22 = _T.xpInfoDictionary[object:__wf_atom_5b41f63b()]
	return v22 ~= nil
		and __wf_atom_c67f9605:__wf_atom_b4a75eaa(v22, object) == __wf_atom_c67f9605:__wf_atom_a1680b24(object)
end

local function fn128(p, p2, p3, p4, p5)
	if p == nil then
		return
	end

	local v22 = nil
	local v23 = #p4[p] > 0

	if #p3[p] == 0 or p2 ~= nil and p2 > 0 and __wf_atom_8d119bab(0, 1) <= p2 and v23 then
		local v24

		if p5 then
			v24 = module.CopyTable(p4[p])
			local v25 = 1

			while v25 <= #v24 do
				local v26 = v24[v25]
				local v27 = string.gsub(v26, "/StoreItems", "")

				if fn127(WeakResource(v27)) then
					table.remove(v24, v25)
				else
					v25 += 1
				end
			end

			if #v24 == 0 then
				v24 = p4[p]
			end
		else
			v24 = p4[p]
		end

		local v25 = v24[__wf_atom_c08f5a0e(1, #v24)]

		if not __wf_atom_7e8ad928(v25) then
			local v26 = string.gsub(v25, "/StoreItems", "")
			local v27 = WeakResource(v26)

			if p == 3 or not fn127(v27) or p5 or not (__wf_atom_8d119bab(0, 1) <= 0.25) then
				v22 = v27
			else
				v22 = fn128(p, 1, p3, p4, true)
				print("GenerateWeaponSelection - Rerolling mastered, unowned weapon. Original weapon: " .. v27:GetName() .. ". New weapon: " .. v22:GetName())
			end

			if not __wf_atom_7e8ad928(v22) then
				print(v22:__wf_atom_5b41f63b() .. " generated as an unowned Cave selection for category: " .. tostring(p))
			end

			fn125(p4[p], v22)
			fn125(p3[p], v22)
		end
	else
		local v24 = p3[p]
		v22 = fn124(v24[__wf_atom_c08f5a0e(1, #v24)].mItemType, p, p3)

		if not __wf_atom_7e8ad928(v22) then
			print(v22:__wf_atom_5b41f63b() .. " generated as an owned Cave selection for category: " .. tostring(p))
		end

		fn125(p3[p], v22)
		fn125(p4[p], v22)
	end

	if __wf_atom_7e8ad928(v22) then
		print("Null WeaponInfo generated as a Cave selection for category: " .. tostring(p))
	end

	return v22
end

local function fn129(list)
	local v22 = {}
	local result = {}

	for _, v23 in ipairs(list) do
		if v23 == nil or v23.mItemType == nil or v22[v23.mItemType:__wf_atom_5b41f63b()] then
			continue
		end

		table.insert(result, v23)
		v22[v23.mItemType:__wf_atom_5b41f63b()] = true
	end

	return result
end

local function fn130(list)
	local v22 = 1

	while v22 <= #list do
		local v23 = list[v22]

		if v23 == nil or v23.mItemType == nil then
			v22 += 1
		else
			local __wf_atom_5b41f63b = v23.mItemType:__wf_atom_5b41f63b()

			if
				string.find(__wf_atom_5b41f63b, "PlayerPowerSuit")
				or string.find(__wf_atom_5b41f63b, "Operator")
				or string.find(__wf_atom_5b41f63b, "Npc")
				or string.find(__wf_atom_5b41f63b, "Platformer")
			then
				table.remove(list, v22)
			else
				v22 += 1
			end
		end
	end
end

local function fn131(mSeed)
	if __wf_atom_7e8ad928(_G.RollableItemsTypeNameCache) then
		return
	end

	local mWarframes = {}
	local mWeapons = {}
	local v22 = {}
	local v23 = {}
	local v24 = { 3, 1, 0, 5 }
	local inventory

	if not __wf_atom_7e8ad928(gGameData) then
		inventory = gGameData:GetInventory() or nil
	end

	local __wf_atom_f2d1696d = gGameRules:__wf_atom_f2d1696d()

	if __wf_atom_7e8ad928(inventory) or __wf_atom_7e8ad928(__wf_atom_f2d1696d) then
		return
	end

	v23[3] = inventory:__wf_atom_ebdc4e6e()
	v23[1] = inventory:__wf_atom_4f67b86c()
	v23[0] = inventory:__wf_atom_20b04548()
	v23[5] = inventory:__wf_atom_4259c789()
	v22[3] = {}

	for _, suit in ipairs(_G.RollableItemsTypeNameCache.suits) do
		table.insert(v22[3], suit)
	end

	v22[1] = {}
	v22[0] = {}
	v22[5] = {}

	for k, _ in pairs(v23) do
		fn130(v23[k])
		v23[k] = fn129(v23[k])
	end

	if not __wf_atom_7e8ad928(gGameData:GetInventory()) then
		local mXPInfo = gGameData:GetInventory().mXPInfo

		for i = 1, #mXPInfo do
			if __wf_atom_7e8ad928(mXPInfo[i].mItemType) then
				continue
			end

			if __wf_atom_7e8ad928(_T.xpInfoDictionary) then
				_T.xpInfoDictionary = {}
			end

			_T.xpInfoDictionary[mXPInfo[i].mItemType:__wf_atom_5b41f63b()] = mXPInfo[i].mXP
		end
	end

	for _, weapon in pairs(_G.RollableItemsTypeNameCache.weapons) do
		if weapon.category ~= nil and weapon.category ~= 3 then
			table.insert(v22[weapon.category], weapon.itemName)
		end
	end

	local v25 = {}

	if gGameData:__wf_atom_a04e4a53() <= 5 then
		local v26 = {}

		for _, v27 in ipairs(v25) do
			v26[v27:__wf_atom_5b41f63b()] = true
		end

		local v27 = 1

		while v27 <= #v22[3] do
			__wf_atom_83c14687(0)

			if v26[v22[3][v27]] then
				v27 += 1
			else
				table.remove(v22[3], v27)
			end
		end
	end

	local v26 = {}

	for k, _ in pairs(v22) do
		v26[k] = {}

		for i = 1, #v22[k] do
			__wf_atom_83c14687(0)
			local v27 = v22[k][i]
			local v28 = string.gsub(v27, "/StoreItems", "")
			table.insert(v26[k], WeakResource(v28))
		end
	end

	for k, _ in pairs(v23) do
		__wf_atom_83c14687(0)
		local v27 = 1

		while v27 <= #v23[k] do
			local v28 = v23[k][v27]

			if #v28.mModularParts > 0 then
				table.remove(v23[k], v27)
			else
				local mItemTypes = fn123(v28.mItemType)

				if #mItemTypes == 0 then
					table.insert(mItemTypes, v28.mItemType)
				end

				local v29 = 1

				while v29 <= #v26[k] do
					__wf_atom_83c14687(0)

					if module.IsValueInTable(mItemTypes, v26[k][v29]) then
						table.remove(v26[k], v29)
						table.remove(v22[k], v29)
					else
						v29 += 1
					end
				end

				v27 += 1
			end
		end
	end

	local v27 = {}

	for k, _ in pairs(v22) do
		v27[k] = #v22[k]
	end

	local function fn132(p, p2)
		local v28 = not (v27[p2] > 0) and 0 or __wf_atom_421b01aa(v27[p2] / 10, 0.1, 1)

		if v28 == 1 and #v23[p2] > 0 then
			p = 1 - (1 - p) * __wf_atom_421b01aa(#v23[p2] / 10, 0.1, 1)
		end

		return p * v28
	end

	local v28 = __wf_atom_c08f5a0e(1, 3)
	mWarframes[v28] = fn128(3, fn132(1, 3), v23, v22)

	for i = 1, 3 do
		if i ~= v28 then
			mWarframes[i] = fn128(3, 0, v23, v22)
		end
	end

	local v29 = __wf_atom_c08f5a0e(4, 5)

	for i = 4, 5 do
		mWarframes[i] = fn128(3, module.Ternary(i == v29, fn132(0.5, 3), 0), v23, v22)
	end

	local v30 = v24[__wf_atom_c08f5a0e(2, #v24)]
	local v31 = __wf_atom_c08f5a0e(1, 3)
	table.insert(mWeapons, fn128(1, fn132(v31 == 1 and 1 or 0, 1), v23, v22))
	table.insert(mWeapons, fn128(0, fn132(v31 == 2 and 1 or 0, 0), v23, v22))
	table.insert(mWeapons, fn128(5, fn132(v31 == 3 and 1 or 0, 5), v23, v22))
	local v32 = {}

	for _, v35 in pairs(v24) do
		if v35 ~= 3 and v35 ~= v30 then
			table.insert(v32, v35)
		end
	end

	table.insert(mWeapons, fn128(v30, fn132(0.5, v30), v23, v22))

	for _, v35 in pairs(v32) do
		table.insert(mWeapons, fn128(v35, fn132(0.5, v35), v23, v22))
	end

	table.insert(mWeapons, fn128(5, fn132(0.5, 5), v23, v22))

	for k, v35 in pairs(v32) do
		if v35 ~= 5 then
			continue
		end

		table.remove(v32, k)
		break
	end

	local v35 = v32[__wf_atom_c08f5a0e(1, #v32)]
	table.insert(mWeapons, fn128(v35, fn132(0.5, v35), v23, v22))
	local __wf_atom_62564227 = gGameData:__wf_atom_62564227()
	print("Found " .. tostring(#__wf_atom_62564227) .. " overrides.")

	for _, v36 in pairs(__wf_atom_62564227) do
		print("Checking " .. tostring(v36.mSlot) .. " override with " .. tostring(#v36.mTypeNames) .. " typenames.")

		if __wf_atom_8d119bab(0, 1) > v36.mChance then
			print("Override chance failed.")
		else
			local v37 = __wf_atom_c08f5a0e(1, #v36.mTypeNames)
			local v38 = string.gsub(v36.mTypeNames[v37], "/StoreItems", "")
			local v39 = WeakResource(v38)

			if __wf_atom_7e8ad928(v39) then
				print("Override type is null")
			else
				local flag = false

				for _, v41 in pairs(v23[v36.mSlot]) do
					if v41.mItemType ~= v39 then
						continue
					end

					flag = true
					break
				end

				if not flag then
					for _, v42 in pairs(v22[v36.mSlot]) do
						local v43 = string.gsub(v42, "/StoreItems", "")
						local v44 = WeakResource(v43)

						if not (v44 == v39 or __wf_atom_f2d1696d:__wf_atom_746bd9c1(v39, 0) == v44) then
							continue
						end

						flag = true
						break
					end
				end

				if flag then
					if v36.mSlot == 3 then
						for i = 1, 3 do
							if i == v28 then
								continue
							end

							print("overriding suit " .. tostring(i))
							print("overriding suit " .. tostring(mWarframes[i]:__wf_atom_5b41f63b()))
							print("with " .. tostring(v39:__wf_atom_5b41f63b()))
							mWarframes[i] = v39
							break
						end
					elseif v36.mSlot == 1 then
						print("overriding primary " .. tostring(mWeapons[1]:__wf_atom_5b41f63b()))
						print("with " .. tostring(v39:__wf_atom_5b41f63b()))
						mWeapons[1] = v39
					elseif v36.mSlot == 0 then
						print("overriding secondary " .. tostring(mWeapons[2]:__wf_atom_5b41f63b()))
						print("with " .. tostring(v39:__wf_atom_5b41f63b()))
						mWeapons[2] = v39
					elseif v36.mSlot == 5 then
						print("overriding melee " .. tostring(mWeapons[3]:__wf_atom_5b41f63b()))
						print("with " .. tostring(v39:__wf_atom_5b41f63b()))
						mWeapons[3] = v39
					end
				else
					print("override is not available for: " .. tostring(v39:__wf_atom_5b41f63b()))
				end
			end
		end
	end

	local duviriCaveOffers = SF.DuviriCaveOffers()
	duviriCaveOffers.mSeed = mSeed
	duviriCaveOffers.mWarframes = mWarframes
	duviriCaveOffers.mWeapons = mWeapons
	gGameData:__wf_atom_d736fca7(duviriCaveOffers)
end

function RollDuviriOffers(p)
	local v22 = ClockValue()
	v22:Clock()
	local __wf_atom_57388629 = gGameData:GetInventory():__wf_atom_57388629()

	if p then
		__wf_atom_57388629 = __wf_atom_3e61816b(math.random(500000))
	end

	local v23 = __wf_atom_04d7eaaa()
	local __wf_atom_dc0fb0c9 = gGameData:__wf_atom_dc0fb0c9()
	__wf_atom_01bfe5c4(__wf_atom_57388629)

	if
		__wf_atom_dc0fb0c9.mSeed == __wf_atom_57388629
		and not (#__wf_atom_dc0fb0c9.mWarframes < 5 or #__wf_atom_dc0fb0c9.mWeapons < 8)
	then
		print("RollDuviriOffers - Using cached duviri offers")
	else
		print("RollDuviriOffers - Generating new Duviri offers")
		fn131(__wf_atom_57388629)
	end

	print("RollDuviriOffers - Duviri Seed: " .. tostring(__wf_atom_57388629))
	_G.DuviriCaveSelections = {}
	_G.DuviriCaveSelections.suits = {}
	_G.DuviriCaveSelections.weapons = {}
	local inventory = gGameData:GetInventory()
	local __wf_atom_ebdc4e6e = inventory:__wf_atom_ebdc4e6e()

	for _, mWarframe in ipairs(__wf_atom_dc0fb0c9.mWarframes) do
		local v24 = fn126(__wf_atom_ebdc4e6e, mWarframe)

		if v24 == nil then
			v24 = SF.WeaponInfo()
			v24.mItemType = mWarframe
			v24.mXP = 10000000
		end

		table.insert(_G.DuviriCaveSelections.suits, v24)
	end

	local __wf_atom_4f67b86c = inventory:__wf_atom_4f67b86c()
	local __wf_atom_20b04548 = inventory:__wf_atom_20b04548()
	local __wf_atom_4259c789 = inventory:__wf_atom_4259c789()

	local function fn132(category)
		if category == 1 then
			return 1
		elseif category == 5 then
			return 2
		end

		return category == 0 and 3 or 0
	end

	for _, mWeapon in ipairs(__wf_atom_dc0fb0c9.mWeapons) do
		local wepInfo = fn126(__wf_atom_4f67b86c, mWeapon)
		local category

		if wepInfo == nil then
			wepInfo = fn126(__wf_atom_20b04548, mWeapon)

			if wepInfo == nil then
				wepInfo = fn126(__wf_atom_4259c789, mWeapon)

				if wepInfo == nil then
					wepInfo = SF.WeaponInfo()
					wepInfo.mItemType = mWeapon
					wepInfo.mXP = 10000000
					local __wf_atom_5b41f63b = mWeapon:__wf_atom_5b41f63b()
					category = -1

					for _, weapon in pairs(_G.RollableItemsTypeNameCache.weapons) do
						if not (weapon.category ~= nil and string.gsub(weapon.itemName, "/StoreItems", "") == __wf_atom_5b41f63b) then
							continue
						end

						category = weapon.category
						break
					end

					__wf_atom_83c14687(0)
				else
					category = 5
				end
			else
				category = 0
			end
		else
			category = 1
		end

		if category == -1 then
			print("ERROR! COuldnt find category for " .. mWeapon:__wf_atom_5b41f63b())
		else
			local v24 = { wepInfo = wepInfo, category = category, order = fn132(category) }
			table.insert(_G.DuviriCaveSelections.weapons, v24)
		end
	end

	print("Generated weapons:")

	for i, weapon in ipairs(_G.DuviriCaveSelections.weapons) do
		print(i .. "> " .. weapon.category .. "> " .. weapon.wepInfo.mItemType:__wf_atom_5b41f63b())
	end

	local __wf_atom_d895e7ec = gGameData:__wf_atom_d895e7ec(8)
	local v24 = __wf_atom_d895e7ec >= 7 and 8 or __wf_atom_d895e7ec >= 2 and 6 or 4
	local weapons = {}

	for i = 1, v24 do
		table.insert(weapons, _G.DuviriCaveSelections.weapons[i])
	end

	table.sort(weapons, function(a, b)
		return a.order < b.order
	end)

	for i = v24 + 1, #_G.DuviriCaveSelections.weapons do
		table.insert(weapons, _G.DuviriCaveSelections.weapons[i])
	end

	_G.DuviriCaveSelections.weapons = weapons
	v22:__wf_atom_6afbe2ef()
	print("Generating Cave Selections took: " .. tostring(v22:Seconds() * 1000) .. "ms")
	__wf_atom_01bfe5c4(v23)
end

function GiveEnergy(object, object2, p, object3, p2)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) then
		local __wf_atom_f3044fe0 = object2:__wf_atom_f3044fe0()
		object2:__wf_atom_19516b62(p)
		local v22 = object2:__wf_atom_f3044fe0() - __wf_atom_f3044fe0

		if v22 > 0 and not __wf_atom_7e8ad928(object3) then
			local v23 = p2 == nil and 0 or p2
			object:__wf_atom_24adfdf4(object3:__wf_atom_a96eb2aa(), v22, v23)
		end
	end
end

function HealShield(object, p, p2, object2, p3)
	if not __wf_atom_7e8ad928(object) and p > 0 then
		local __wf_atom_7faf4619 = object:__wf_atom_7470861b():__wf_atom_7faf4619()
		object:__wf_atom_7470861b():HealShield(p, p2)
		local v22 = object:__wf_atom_7470861b():__wf_atom_7faf4619() - __wf_atom_7faf4619

		if v22 > 0 and not __wf_atom_7e8ad928(object2) then
			local v23 = p3 == nil and 0 or p3
			object:NotifyHeal(object2:__wf_atom_a96eb2aa(), 0, v22, v23)
		end
	end
end

function RefreshAutoChild(object)
	local mInstance = object.mInstance

	if __wf_atom_7e8ad928(mInstance) then
		return
	end

	mInstance:__wf_atom_e310f01f(object:__wf_atom_1118f075(), object:__wf_atom_01934aa5())
end

function CheckNetPersistentString()
	if not __wf_atom_7e8ad928(gGameRules) then
		if gGameRules:IsA(__wf_atom_dd9a0bb8) then
			if gGameRules:__wf_atom_8d9a85ba() then
				_T.netPersistentString = gGameRules:__wf_atom_7a6e3db3()
				_T.netPersistentArray = cjson.decode(_T.netPersistentString)
				gGameRules:__wf_atom_7ccc3f17()
			end
		else
			_T.netPersistentString = ""
			_T.netPersistentArray = {}
		end
	end

	if _T.netPersistentString == nil then
		_T.netPersistentString = ""
	end

	if _T.netPersistentString == "" then
		_T.netPersistentArray = {}
	end
end

function GetNetPersistentArray()
	CheckNetPersistentString()
	return _T.netPersistentArray
end

function SetNetArrayValue(p, p2)
	if not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		return
	end

	CheckNetPersistentString()
	_T.netPersistentArray[p] = p2
	gGameRules:__wf_atom_1366b91c(cjson.encode(_T.netPersistentArray))
end

function ClearNetArrayValue(p)
	if not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		return
	end

	CheckNetPersistentString()

	if #_T.netPersistentArray > 0 and not __wf_atom_7e8ad928(_T.netPersistentArray[p]) then
		_T.netPersistentArray[p] = nil
		gGameRules:__wf_atom_1366b91c(cjson.encode(_T.netPersistentArray))
	end
end

function GetArcaneSlotRequirementMessage(p)
	if p == nil then
		return nil, nil
	end

	local v22

	if p == 2 then
		v22 = "/Lotus/Language/Categories/RIFLE"
	elseif p == 1 then
		v22 = "/Lotus/Language/Categories/HAND_GUN"
	elseif p == 3 then
		v22 = "/Lotus/Language/Categories/MELEE"
	else
		v22 = nil
	end

	if v22 ~= nil then
		local v23 = Localize(v22, nil)
		local v24 = Localize("/Lotus/Language/Menu/ArcaneSlot_ItemName", { ITEM = v23 })
		return "/Lotus/Language/Menu/ArcaneSlot_RequiresAperture", TitleCase(v24)
	end

	return nil, nil
end

function IsEntratiHub(p)
	return p ~= nil and p.location == ENTRATI_LAB_NODE_TAG
end

function IsInEntratiHub()
	if GetUIMode() == UI_MODE_IN_SPACE_HUB then
		local __wf_atom_5529af13 = gMatchingService:__wf_atom_5529af13()

		if __wf_atom_5529af13 and string.find(__wf_atom_5529af13, ENTRATI_LAB_NODE_TAG:c_str()) ~= nil then
			return true
		end
	end

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
		return false
	end

	return IsEntratiHub(gGameRules:__wf_atom_72fc675e())
end