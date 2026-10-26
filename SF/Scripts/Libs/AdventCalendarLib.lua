module(..., package.seeall)
local v = { HIGH = 3, MEDIUM = 2, LOW = 1 }
require("SF.Interface.SFUtilities")
local module = require("SF.Scripts.Libs.QuestLib")
miniQuestMarker = WeakResource("/SF/Types/Game/MarkerInfos/FactionQuest/MiniquestBaseMarkerInfo")
siegeMarkers = WeakResource("/SF/Types/Game/MarkerInfos/NamedLocations/SiegeMarkerInfo")
minibossMarkers = WeakResource("/SF/Types/Game/MarkerInfos/SubBossRednightMarkerInfo")
siegeIcon = Resource("/SF/Interface/Graphics/Codex/AdventCalendar/AdventSiege.png")
sparrowIcon = Resource("/SF/Interface/Graphics/Codex/AdventCalendar/AdventSparrow.png")
dungeonIcon = Resource("/SF/Interface/Graphics/WaypointMarkers/EntranceDown.png")
verminiaIcon = Resource("/SF/Interface/Graphics/Codex/AdventCalendar/AdventVerminia.png")
tuvalIcon = Resource("/SF/Interface/Graphics/TitlePage/AncestorPortraitLarge3.png")
bossIcon = Resource("/SF/Interface/Graphics/HUD/SubBoss/SubBossIcon.png")
tuvalQuest = WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/ProgressionQuests/AncestorTuvalkaneDiscoveryQuest")
tuvalCompletedFragment = WeakResource("/SF/Types/Lore/CharacterLore/TuvalkaneCharacterLoreFragment")
verminiaFragment = WeakResource("/SF/Types/Lore/CharacterLore/VerminiaCharacterLoreFragment")
verminiaQuest = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/AncestorVerminiaDiscoveryQuest")

local function fn(all)
	for i = #all, 2, -1 do
		local v2 = math.random(i)
		local v3 = all[v2]
		local v4 = all[i]
		all[i] = v3
		all[v2] = v4
	end
end

function GetTuvalkane()
	if module.HasCompletedQuest(tuvalQuest) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TuvalkaneHelm"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local areaMarker = module.CreateAreaMarker(__wf_atom_0a6a5887, 15, __wf_atom_28d5d4aa)

	if not module.QuestIsActive(tuvalQuest) then
		return { mIcon = tuvalIcon, mMarker = areaMarker }
	end

	module.DestroyAreaMarker(areaMarker)
end

function GetVerminia()
	if not module.HasCompletedQuest(tuvalQuest) or module.HasCompletedQuest(verminiaQuest) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("VerminiaNoteHint"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local areaMarker = module.CreateAreaMarker(__wf_atom_0a6a5887, 15)

		if not module.QuestIsActive(verminiaQuest) then
			return { mIcon = verminiaIcon, mMarker = areaMarker }
		end

		module.DestroyAreaMarker(areaMarker)
	end
end

function GetSiege()
	local all = gRegion:FindAll(WeakResource("/SF/Types/Game/MarkerInfos/NamedLocations/SiegeMarkerInfo"))
	fn(all)

	for _, mMarker in all do
		if __wf_atom_7e8ad928(mMarker) then
			continue
		end

		local __wf_atom_e919fb8e = mMarker:__wf_atom_e919fb8e()

		if
			__wf_atom_e919fb8e ~= nil
			and __wf_atom_e919fb8e.IsSiegeAvailable ~= nil
			and __wf_atom_e919fb8e.IsSiegeAvailable()
		then
			return { mMarker = mMarker, mIcon = siegeIcon, mIconScale = 80 }
		end
	end
end

function GetSparrowTale()
	local all = gRegion:FindAll(WeakResource("/SF/Types/Game/MarkerInfos/FactionQuest/MiniquestBaseMarkerInfo"))
	fn(all)

	for _, mMarker in all do
		if mMarker:__wf_atom_68dff988() == 1 then
			return { mMarker = mMarker, mIcon = sparrowIcon }
		end
	end
end

function GetDungeon()
	local all = gRegion:FindAll(WeakResource("/SF/Types/Game/MarkerInfos/NamedLocations/DungeonEntranceMarkerInfo"))
	fn(all)

	for _, mMarker in all do
		return { mMarker = mMarker, mIcon = dungeonIcon, mIconScale = 80 }
	end
end

function GetBoss()
	local all = gRegion:FindAll(minibossMarkers)
	fn(all)

	for _, mMarker in all do
		if not __wf_atom_7e8ad928(mMarker) then
			return { mMarker = mMarker, mIcon = bossIcon, mIconScale = 80, mIconColor = 12363651 }
		end
	end
end

local v2 = {
	{ Func = GetTuvalkane, Priority = v.LOW },
	{ Func = GetVerminia, Priority = v.LOW },
	{ Func = GetSiege, Priority = v.LOW },
	{ Func = GetSparrowTale, Priority = v.LOW },
	{ Func = GetDungeon, Priority = v.LOW },
	{ Func = GetBoss, Priority = v.LOW }
}

local function fn2(list, state, p) -- 1 equivalent call inferred from this helper
	if p <= #list then
		return
	end

	state.Activity = state.Func()

	if state.Activity ~= nil then
		table.insert(list, state)
	end
end

function GetSuggestedActivities(p)
	local v3 = p == nil and 3 or p
	local v4 = {}

	for _, v5 in v2 do
		fn2(v4, v5, v3) -- inferred equivalent call
	end

	return v4
end