module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("EE.Interface.Utilities")
local v = {
	"/Lotus/Language/Menu/GrineerInvasionGeneric",
	"/Lotus/Language/Menu/CorpusInvasionGeneric",
	"/Lotus/Language/Menu/InfestedInvasionGeneric"
}

function GetSeasonParamOverride(p, p2, p3)
	local v2 = p3 or gGameData

	if __wf_atom_7e8ad928(v2) then
		return p2
	end

	if
		_T.SeasonParamString == nil
		or _T.SeasonParams == nil
		or _T.SeasonParamString ~= v2:__wf_atom_92662866().mSeasonInfo.mParams
	then
		_T.SeasonParamString = v2:__wf_atom_92662866().mSeasonInfo.mParams
		_T.SeasonParams = cjson.decode(_T.SeasonParamString)
	end

	if _T.SeasonParams == nil or _T.SeasonParams[p] == nil then
		return p2
	end

	return _T.SeasonParams[p]
end

local function fn(p, p2, p3)
	local v2 = p3 or gGameData

	if __wf_atom_7e8ad928(v2) then
		return p2
	end

	if
		_T.WorldStateOverrideString == nil
		or _T.WorldStateOverrides == nil
		or _T.WorldStateOverrideString ~= v2:__wf_atom_92662866().mOverrides
	then
		_T.WorldStateOverrideString = v2:__wf_atom_92662866().mOverrides
		_T.WorldStateOverrides = cjson.decode(_T.WorldStateOverrideString)
	end

	if _T.WorldStateOverrides == nil or _T.WorldStateOverrides[p] == nil then
		return p2
	end

	return _T.WorldStateOverrides[p]
end

function GetWorldStateOverride(p, p2, p3)
	return (fn(p, p2, p3))
end

function CheckSentientFragmentAvailable(p)
	if p == nil or p.region + 1 ~= module.REGION_ID_DEEP_SPACE then
		return
	end

	local v2 = fn("sfn", 0)

	if v2 <= 0 then
		return false
	end

	local location = tostring(p.mission.location)
	local v3 = tonumber((string.sub(location, string.len(location) - 2)))
	return v3 ~= nil and v3 == v2
end

function GetInvasions(p)
	local result = {}

	if __wf_atom_7e8ad928(gGameData) then
		return result
	end

	local __wf_atom_fbcd7feb = gGameData:__wf_atom_fbcd7feb()
	local starChart = module.GetStarChart()

	if __wf_atom_7e8ad928(starChart) then
		return result
	end

	for _, v2 in pairs(_T.CachedInvasionInfo) do
		local __wf_atom_d5226f21 = starChart:__wf_atom_d5226f21(v2.mNode)
		local v3 = starChart:__wf_atom_161b95d4()[__wf_atom_d5226f21.region + 1]

		if __wf_atom_7e8ad928(v3) or tostring(v2.mEventTag) ~= "" then
			continue
		end

		local name = v3.name
		local isRegionUnlocked = module.IsRegionUnlocked(starChart, gGameData, __wf_atom_d5226f21.region + 1)

		if not ((isRegionUnlocked or _T.SHOW_LOCKED_ALERTS) and (p == nil or p == name)) then
			continue
		end

		if result[name] == nil then
			result[name] = {}
			result[name].SubInvasions = {}
			result[name].RegionIdx = __wf_atom_d5226f21.region
			result[name].AttackerFaction = v2.mFaction
			result[name].DefenderFaction = v2.mAttackerMissionInfo.faction
			result[name].AttackerName = v2.mAttackerName
			result[name].DefenderName = v2.mDefenderName
			result[name].Unlocked = isRegionUnlocked
			result[name].Completed = v2.mCompleted
			result[name].LocTag = v2.mLocTag
			result[name].RegionName = tostring(name)
		end

		local node = Symbol((tostring(__wf_atom_d5226f21.locTag)))
		table.insert(result[name].SubInvasions, {
			Node = node,
			Count = v2.mCount,
			Goal = v2.mGoal,
			AttackerReward = v2.mAttackerReward,
			DefenderReward = v2.mDefenderReward,
			AttackerName = v2.mAttackerName,
			DefenderName = v2.mDefenderName,
			LocTag = v2.mLocTag,
			Location = tostring(__wf_atom_d5226f21.name)
		})
		local count = #result[name].SubInvasions

		for i = 1, #__wf_atom_fbcd7feb do
			if __wf_atom_fbcd7feb[i].mId.mId ~= v2.mId.mId then
				continue
			end

			local mDelta = __wf_atom_fbcd7feb[i].mDelta
			result[name].SubInvasions[count].Delta = math.abs(mDelta)

			if mDelta > 0 then
				result[name].SubInvasions[count].SupportAttacker = true
				break
			end

			if mDelta < 0 then
				result[name].SubInvasions[count].SupportAttacker = false
			end

			break
		end
	end

	return result
end

function ApplySentientFragmentToMission(_, _)
	return nil
end

function GetInfoPopupDataForInvasion(object, data)
	local ternary = module3.Ternary(
		not data.LocTag or data.LocTag == EMPTY_SYMBOL,
		v[data.AttackerFaction + 1],
		(tostring(data.LocTag))
	)
	local v2 = {
		CustomEntry = true,
		Name = string.upper(object:__wf_atom_8e9ac384(data.Region, false)),
		LocalizedDesc = object:__wf_atom_8e9ac384("/Lotus/Language/UiElements/InvasionsSubHint", false),
		SubInvasions = data.SubInvasions,
		AttackerFaction = data.AttackerFaction
	}
	local customTags = {}
	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(ternary, false)
	table.insert(customTags, (module2.GetInfoForLabel(module2.LABEL_TYPE_UNIQUE_TEXT, __wf_atom_8e9ac384)))
	v2.MetaData = { CustomTags = customTags }
	return v2
end