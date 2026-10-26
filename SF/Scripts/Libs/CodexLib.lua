module(..., package.seeall)
local v = {
	WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/ProgressionQuests/TuvalkaneRankTwo"),
	WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/ProgressionQuests/TuvalkaneRankOne")
}
local v2 = nil
local v3 = {}
local v4 = {}
local v5 = { ACTIVE = 1, INACTIVE = 2, COMPLETED = 3 }
local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.CodexUtilities")
local module4 = require("SF.Interface.Libs.OdeCipher")
local module5 = require("SF.Scripts.Libs.TaleLib")
local module6 = require("SF.Scripts.Libs.AncestorsFunctionLib")
require("EE.Interface.Utilities")
local module7 = require("SF.Interface.Libs.UIUtilities")
local v6 = {
	SilentRoseSyndicate = Resource("/SF/Interface/Graphics/Map/SilentRoseIcon.png"),
	ChampionSyndicate = Resource("/SF/Interface/Graphics/Factions/Champion/ChampionFaction.png"),
	FeySyndicate = Resource("/SF/Interface/Graphics/Factions/Alca/AlcasChildrenFactionIcon.png")
}

local function fn(object, list)
	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(module5.GetPlayerFaction())
	local mIcon

	if __wf_atom_13d5b7e9 ~= nil then
		mIcon = v6[__wf_atom_13d5b7e9:GetName()]
	end

	for _, v7 in v3 do
		local mBulletEntryData = {}

		if v7.Nodes ~= nil then
			for k, node in v7.Nodes do
				v7.Nodes[k] = Localize(node, false)
				table.insert(mBulletEntryData, {
					mText = v7.Nodes[k],
					mCompleted = k < v7.Data.NodeIndex,
					mActive = k == v7.Data.NodeIndex
				})
			end
		end

		table.insert(list, {
			mEntryId = v7.Data.Id,
			mIcon = mIcon,
			mLabel = object:__wf_atom_8e9ac384(v7.Name, false),
			mUnlocalizedLabel = "",
			mName = "",
			mDesc = object:__wf_atom_8e9ac384(v7.Desc, false),
			mDiscoveryName = "",
			mNew = false,
			mDate = nil,
			mCompleted = true,
			mBulletEntryTitles = nil,
			mBulletEntryData = mBulletEntryData,
			mTransmissions = nil,
			mQuest = nil,
			mQuestType = 1,
			mHasRewards = false,
			mRewardsLoaded = false,
			mRedeemed = false,
			mScanInfo = nil,
			mIsSparse = true,
			mImage = nil,
			mItemRes = nil,
			mData = { v7.Data }
		})
	end
end

local function fn2(activeQuests, active)
	for _, item in pairs(activeQuests) do
		if not table.find(v, item) then
			table.insert(v2, { mQuest = item, mStage = active })
		end
	end
end

local function fn3(_, list)
	local questController = nil

	if __wf_atom_7e8ad928(questController) and not __wf_atom_7e8ad928(gGameRules) then
		questController = gGameRules:GetQuestController()
	end

	if __wf_atom_7e8ad928(questController) then
		return
	end

	v2 = {}
	fn2(questController:GetActiveQuests(), v5.ACTIVE)

	for i = 1, #v2 do
		local mQuest = v2[i].mQuest
		local mDesc = Localize(mQuest:__wf_atom_3a3d2e39():c_str(), {})
		local questNodesData = module.GetQuestNodesData(mQuest)
		local mBulletEntryData = {}

		for _, v7 in ipairs(questNodesData) do
			local v8

			if v7.mOverrideTag == nil or v7.mOverrideTag == EMPTY_SYMBOL or v7.mCompleted then
				v8 = v7.mDescTag:c_str()
			else
				v8 = v7.mOverrideTag:c_str()
			end

			table.insert(mBulletEntryData, {
				mCompleted = v7.mCompleted,
				mActive = v7.mActive,
				mText = Localize(v8, {}),
				mLocked = not v7.mVisible,
				mShowCipher = false
			})
		end

		if not (#mBulletEntryData ~= 0 and mBulletEntryData[1].mText ~= "???") then
			continue
		end

		local mLabel = Localize(mQuest:__wf_atom_014a76a2():c_str(), {})
		local iconTexture = mQuest:GetIconTexture()
		local __wf_atom_c9969a68 = mQuest:__wf_atom_c9969a68()
		local __wf_atom_7941efb7 = mQuest:__wf_atom_7941efb7()
		table.insert(list, {
			mEntryId = module.GetQuestId(mQuest),
			mIcon = iconTexture,
			mSquareIcon = __wf_atom_c9969a68,
			mTintIcon = __wf_atom_7941efb7,
			mLabel = mLabel,
			mUnlocalizedLabel = "",
			mName = "",
			mDesc = mDesc,
			mDiscoveryName = "",
			mNew = false,
			mDate = nil,
			mCompleted = true,
			mBulletEntryTitles = nil,
			mBulletEntryData = mBulletEntryData,
			mTransmissions = nil,
			mQuest = mQuest,
			mQuestType = 0,
			mRewards = mQuest:__wf_atom_9b6e11e8(),
			mHasRewards = false,
			mRewardsLoaded = false,
			mRedeemed = false,
			mScanInfo = nil,
			mIsSparse = true,
			mImage = nil,
			mItemRes = nil
		})
	end

	local localPlayerAncestors = module6.GetLocalPlayerAncestors()

	for _, localPlayerAncestor in ipairs(localPlayerAncestors) do
		local mRank = localPlayerAncestor.mRank
		local ancestorType = Type(localPlayerAncestor.mType)
		local __wf_atom_c21a80eb = ancestorType:__wf_atom_c21a80eb(mRank + 1)

		if __wf_atom_7e8ad928(__wf_atom_c21a80eb) then
			continue
		end

		local personalCompletedQuest = module.GetPersonalCompletedQuest(__wf_atom_c21a80eb)

		if __wf_atom_7e8ad928(personalCompletedQuest) then
			continue
		end

		local __wf_atom_5e1f5995 = ancestorType:__wf_atom_5e1f5995(mRank + 1)
		local questNodesData = module.GetQuestNodesData(personalCompletedQuest)
		local mBulletEntryData = {}

		for _, v7 in ipairs(questNodesData) do
			local v8

			if v7.mOverrideTag == nil or v7.mOverrideTag == EMPTY_SYMBOL or v7.mCompleted then
				v8 = v7.mDescTag:c_str()
			else
				v8 = v7.mOverrideTag:c_str()
			end

			table.insert(mBulletEntryData, {
				mCompleted = v7.mCompleted,
				mText = Localize(v8, {}),
				mLocked = not v7.mVisible,
				mShowCipher = false
			})
		end

		table.insert(mBulletEntryData, {
			mText = Localize(__wf_atom_5e1f5995:c_str(), {}),
			mActive = true
		})
		table.insert(list, {
			mEntryId = localPlayerAncestor.mType:__wf_atom_5b41f63b() .. "_" .. mRank + 1,
			mIcon = personalCompletedQuest:GetIconTexture(),
			mLabel = Localize(personalCompletedQuest:__wf_atom_014a76a2():c_str(), {}),
			mUnlocalizedLabel = "",
			mName = "",
			mDesc = "",
			mDiscoveryName = "",
			mNew = false,
			mDate = nil,
			mCompleted = true,
			mBulletEntryTitles = nil,
			mBulletEntryData = mBulletEntryData,
			mTransmissions = nil,
			mQuest = nil,
			mQuestType = 2,
			mHasRewards = false,
			mRewardsLoaded = false,
			mRedeemed = false,
			mScanInfo = nil,
			mIsSparse = true,
			mImage = nil,
			mItemRes = nil,
			mData = {
				{
					Quest = personalCompletedQuest,
					AncestorType = ancestorType,
					AncestorRank = mRank
				}
			}
		})
	end
end

local function fn4(object, list)
	local __wf_atom_e5ac240c = gGameRules:__wf_atom_e5ac240c()

	for _, v7 in __wf_atom_e5ac240c do
		local v8 = { Entity = v7.mEntity, Id = v7.mId }

		if v7.mNodes ~= nil then
			for k, mNode in v7.mNodes do
				v7.mNodes[k] = Localize(mNode, false)
			end

			v8.ShortDesc = v7.mNodes[1]
		end

		local mBulletEntryData = {}

		for _, mNode in v7.mNodes do
			table.insert(mBulletEntryData, { mText = mNode })
		end

		table.insert(list, {
			mEntryId = v7.mId,
			mLabel = object:__wf_atom_8e9ac384(v7.mName, false),
			mUnlocalizedLabel = "",
			mName = "",
			mDesc = object:__wf_atom_8e9ac384(v7.mDesc, false),
			mDiscoveryName = "",
			mNew = false,
			mDate = nil,
			mCompleted = true,
			mBulletEntryTitles = nil,
			mBulletEntryData = mBulletEntryData,
			mTransmissions = nil,
			mQuest = nil,
			mQuestType = 4,
			mHasRewards = false,
			mRewardsLoaded = false,
			mRedeemed = false,
			mScanInfo = nil,
			mIsSparse = true,
			mImage = nil,
			mItemRes = nil,
			mData = { v8 }
		})
	end

	for _, v7 in v4 do
		if v7.Nodes ~= nil then
			for k, node in v7.Nodes do
				v7.Nodes[k] = Localize(node, false)
			end
		end

		local mBulletEntryData = {}

		for _, node in v7.Nodes do
			table.insert(mBulletEntryData, { mText = node })
		end

		table.insert(list, {
			mEntryId = v7.mId,
			mLabel = object:__wf_atom_8e9ac384(v7.Name, false),
			mUnlocalizedLabel = "",
			mName = "",
			mDesc = object:__wf_atom_8e9ac384(v7.Desc, false),
			mDiscoveryName = "",
			mNew = false,
			mDate = nil,
			mCompleted = true,
			mBulletEntryTitles = nil,
			mBulletEntryData = mBulletEntryData,
			mTransmissions = nil,
			mQuest = nil,
			mQuestType = 4,
			mHasRewards = false,
			mRewardsLoaded = false,
			mRedeemed = false,
			mScanInfo = nil,
			mIsSparse = true,
			mImage = nil,
			mItemRes = nil,
			mData = { v7.Data }
		})
	end
end

local function fn5(list, p)
	table.insert(list, p, {
		IsDivider = true,
		mEntryId = nil,
		mLabel = "",
		mUnlocalizedLabel = "",
		mName = "",
		mDesc = "",
		mDiscoveryName = "",
		mNew = false,
		mDate = nil,
		mCompleted = true,
		mBulletEntryTitles = nil,
		mBulletEntryData = nil,
		mTransmissions = nil,
		mQuest = nil,
		mQuestType = 4,
		mHasRewards = false,
		mRewardsLoaded = false,
		mRedeemed = false,
		mScanInfo = nil,
		mIsSparse = true,
		mImage = nil,
		mItemRes = nil,
		mData = nil
	})
end

function GetJournalEntries(p, list)
	fn3(p, list)
	local count = #list
	fn(p, list)

	if count ~= #list and count > 0 then
		fn5(list, count + 1)
	end

	fn4(p, list)
end

function AddTalesEntry(p, p2, p3)
	v3[p] = p2

	if p3 then
		module5.TrackTaleById(p)
	end
end

function RemoveTalesEntry(p)
	if v3[p] ~= nil then
		v3[p] = nil
	end

	module.UntrackEntry(p)
end

function RemoveAllTalesEntries()
	v3 = {}
end

function RemoveTalesEntriesExcept(items)
	local v7 = {}

	for _, item in pairs(items) do
		if v3[item] ~= nil then
			v7[item] = v3[item]
		end
	end

	v3 = v7
end

function AddCustomEntry(p, p2)
	v4[p] = p2
	module.TrackEntry(p, 4, true)
end

function RemoveCustomEntry(p)
	if v4[p] ~= nil then
		v4[p] = nil
	end
end

local function fn6(list, p)
	for i = 1, #list do
		if list[i].tag:c_str() == p then
			return list[i]
		end
	end

	return nil
end

local function fn7(list, className)
	for i = 1, #list do
		if list[i].objectType:IsA(className) then
			return list[i]
		end
	end

	return nil
end

function PopulateStatsFromServer(p)
	local mScans = p.mScans
	local scans = {}

	for i = 1, #mScans do
		scans[mScans[i].type:__wf_atom_5b41f63b()] = mScans[i].scans
	end

	return scans
end

function PopulateForCodexScans(list, object, items, p, p2)
	local v7 = fn7(object:__wf_atom_19f75a1e(), p)

	if v7 == nil and p2 then
		return
	end

	local v8

	if p2 then
		v8 = object:__wf_atom_d8ec0d69()
	else
		v8 = object:__wf_atom_e118295b(v7)
	end

	if #v8 == 0 then
		return
	end

	local scans = {}

	for _, item in items do
		scans[item.type:__wf_atom_5b41f63b()] = item.scans
	end

	local v9 = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
	local ancestorUpgradeRankValueForTag = module6.GetAncestorUpgradeRankValueForTag(
		v9,
		Symbol("SoulScanRequiredForCodex"),
		Symbol("NUMSCANSREDUCTION")
	)

	for _, v10 in v8 do
		local __wf_atom_5b41f63b = v10.type:__wf_atom_5b41f63b()

		if v10.excludedFromSimulacrum then
			continue
		end

		local icon = v10.icon
		local c_str = v10.locName:c_str()
		local v11 = Localize(c_str, nil)
		local mDesc = v10.shortDesc == nil and "" or Localize(v10.shortDesc:c_str(), nil)
		local dropTables = v10.dropTables
		local faction = v10.faction
		local v12 = 0
		local reqScans = 1
		local mRaritySizeRange

		if p2 then
			mRaritySizeRange = v10
		end

		if v10.reqScans > 0 then
			reqScans = v10.reqScans
		else
			v12 = 1
		end

		if ancestorUpgradeRankValueForTag ~= nil then
			reqScans -= ancestorUpgradeRankValueForTag
		end

		local v13 = reqScans <= 0 and 1 or reqScans

		if __wf_atom_5b41f63b ~= nil and scans[__wf_atom_5b41f63b] ~= nil then
			v12 = scans[__wf_atom_5b41f63b]
		end

		local mScanProgress = v12 / v13
		table.insert(list, {
			mLabel = v11,
			mGridIcon = icon,
			mIcon = nil,
			mUnlocalizedLabel = c_str,
			mName = v11,
			mDesc = mDesc,
			mDiscoveryName = "",
			mCompleted = true,
			mLocked = v12 < v13,
			mScanProgress = mScanProgress,
			mBulletEntryTitles = nil,
			mBulletEntryData = nil,
			mTransmissions = {},
			mNew = false,
			mIsSparse = true,
			mBodyImage = icon,
			mImage = nil,
			mItemRes = nil,
			mResourceFormat = false,
			mDropTables = dropTables,
			mFaction = faction,
			mType = v10.type,
			mRaritySizeRange = mRaritySizeRange
		})
	end
end

function PopulateFromCodexEntries(items, object, object2, p, list, _, p2)
	for _, item in items do
		if p ~= item.tag then
			continue
		end

		local __wf_atom_769d176a = object:__wf_atom_769d176a(item)

		for _, v7 in ipairs(__wf_atom_769d176a) do
			local v8 = Localize(v7.locName:c_str(), {})
			local __wf_atom_232fd31d = object2:__wf_atom_232fd31d(v7.type)
			local mDesc = __wf_atom_7e8ad928(__wf_atom_232fd31d) and ""
				or Localize(tostring(__wf_atom_232fd31d:__wf_atom_3a3d2e39()), nil)

			if __wf_atom_7e8ad928(object2) then
				return nil
			end

			local dropSources = module3.GetDropSources(
				__wf_atom_8e4fda44:__wf_atom_03ff0530(),
				object,
				v7,
				nil,
				nil,
				{}
			)
			local v9 = {}

			if #dropSources > 0 then
				for _, dropSource in ipairs(dropSources) do
					if (dropSource.Found or dropSource.IsMod) and dropSource.Group ~= nil then
						table.insert(v9, dropSource.Group .. ": " .. dropSource.Label)
					end
				end
			end

			local mBulletEntryData = {}
			local __wf_atom_859308f2 = object:__wf_atom_859308f2(v7.regionBits)

			if #__wf_atom_859308f2 > 0 then
				for _, v10 in ipairs(__wf_atom_859308f2) do
					table.insert(mBulletEntryData, { mText = Localize(v10:c_str(), {}) })
				end
			end

			for _ = 1, p2 and 3 or 1 do
				table.insert(list, {
					mLabel = v8,
					mUnlocalizedLabel = v7.locName:c_str(),
					mName = v8,
					mDesc = mDesc,
					mDiscoveryName = v8,
					mCompleted = true,
					mBulletEntryTitles = "/SF/Language/Codex/Resource_RegionDesc",
					mBulletEntryData = mBulletEntryData,
					mTransmissions = {},
					mNew = false,
					mIsSparse = true,
					mImage = v7.icon,
					mItemRes = v7.type,
					mResourceFormat = true
				})
			end
		end

		return true
	end

	return false
end

function GetCodexEntriesOfType(object, p, className)
	local v7 = fn6(object:__wf_atom_19f75a1e(), p)
	local result = {}

	if v7 == nil then
		return result
	end

	local __wf_atom_1e5f4e2f = object:__wf_atom_1e5f4e2f(v7)

	for _, v8 in __wf_atom_1e5f4e2f do
		if v8.type:IsA(className) then
			table.insert(result, v8)
		end
	end

	return result
end

function HasCodexScan(object, p)
	local v7 = fn7(object:__wf_atom_19f75a1e(), p)

	if v7 == nil then
		return false
	end

	local __wf_atom_e118295b = object:__wf_atom_e118295b(v7)

	for _, v8 in __wf_atom_e118295b do
		if not v8.excludedFromSimulacrum then
			return true
		end
	end

	return false
end

function HasFragmentScan(list, p)
	local envoyInventoryControl = module2.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) or not envoyInventoryControl:IsA(__wf_atom_4d316097) then
		return false
	end

	for _, v7 in ipairs(list) do
		local v8 = Resource(v7.mItemType)

		if not __wf_atom_7e8ad928(v8) and not v8:__wf_atom_e063e3c3() and v8:__wf_atom_c580bfeb() == p then
			return true
		end
	end

	return false
end

local function fn8(object) -- 1 equivalent call inferred from this helper
	return "LORE_" .. string.upper(object:c_str())
end

function PopulateFromScans(object, list, p, list2, p2, p3)
	local envoyInventoryControl = module2.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) or not envoyInventoryControl:IsA(__wf_atom_4d316097) then
		return
	end

	for _, mScanInfo in ipairs(list) do
		local mItemRes = Resource(mScanInfo.mItemType)

		if __wf_atom_7e8ad928(mItemRes) or mItemRes:__wf_atom_e063e3c3() then
			continue
		end

		local c_str = mItemRes:__wf_atom_014a76a2():c_str()
		local mNew = not mScanInfo.mRead
		local mHasRewards = false
		local unlockedMemories = envoyInventoryControl:GetUnlockedMemories(mItemRes)
		local __wf_atom_22020464 = mItemRes:__wf_atom_22020464()
		local __wf_atom_34817f31 = mItemRes:__wf_atom_34817f31()
		local mCompleted = mScanInfo.mItemCount >= #unlockedMemories or p3
		local v7 = mScanInfo.mRedeemed and not p3
		local isA = mItemRes:IsA(WeakResource("/SF/Types/Lore/TutorialLore/TutorialBaseLoreFragment"))
		local __wf_atom_1f54a4ab = mItemRes:__wf_atom_1f54a4ab()

		if not (not isA or __wf_atom_7e8ad928(__wf_atom_1f54a4ab) or module.HasCompletedQuest(__wf_atom_1f54a4ab)) then
			continue
		end

		local mDate

		if not __wf_atom_7e8ad928(mScanInfo.mDate) then
			local __wf_atom_e0c3cbeb = mScanInfo.mDate:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
			local v8 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
			local v9 = StringSplit("/", v8)
			local _, day, month, year = module4.ConvertDateToGame(v9[4], v9[2], v9[1], v9[3])
			mDate = Localize("/SF/Language/Codex/CodexTimeStamp", {
				DAY = day,
				MONTH = month,
				YEAR = year
			})
		end

		if mCompleted and not v7 then
			mHasRewards = #mItemRes:__wf_atom_e9f90795() > 0

			if mHasRewards then
				mNew = true
			end
		end

		local __wf_atom_c580bfeb = mItemRes:__wf_atom_c580bfeb()
		local __wf_atom_5b41f63b = mItemRes:__wf_atom_5b41f63b()

		if mNew then
			p2[fn8(__wf_atom_c580bfeb)] = true -- inferred equivalent call
		end

		if __wf_atom_c580bfeb ~= p then
			continue
		end

		local __wf_atom_e30fcead = mItemRes:__wf_atom_e30fcead()

		if __wf_atom_e30fcead:__wf_atom_8598f3a9() then
			__wf_atom_e30fcead:c_str()
		end

		local __wf_atom_7188fa33 = mItemRes:__wf_atom_7188fa33()
		local mBulletEntryData = {}

		for i, unlockedMemory in ipairs(unlockedMemories) do
			local v8 = {}

			if not __wf_atom_7188fa33 and mScanInfo.mItemCount < i then
				break
			end

			v8.mLocked = false

			if unlockedMemory == EMPTY_SYMBOL then
				if __wf_atom_22020464[i] == nil or __wf_atom_22020464[i]:c_str() == "" then
					v8.mText = "???"
				else
					local c_str2 = __wf_atom_22020464[i]:c_str()
					print(c_str2)
					v8.mText = Localize(__wf_atom_22020464[i]:c_str(), nil)
				end

				v8.mLocked = true
			else
				v8.mText = object:__wf_atom_8e9ac384(unlockedMemory:c_str(), true)
			end

			for _ = 1, p3 and 4 or 1 do
				table.insert(mBulletEntryData, v8)
			end
		end

		for _ = 1, p3 and 3 or 1 do
			table.insert(list2, {
				mLabel = module4.FragmentCipher(mItemRes),
				mIcon = mItemRes:GetIconTexture(),
				mUnlocalizedLabel = c_str,
				mName = Localize(c_str, nil),
				mDesc = object:__wf_atom_8e9ac384(mItemRes:__wf_atom_3a3d2e39():c_str(), true),
				mDiscoveryName = __wf_atom_5b41f63b,
				mNew = mNew,
				mDate = mDate,
				mCompleted = mCompleted,
				mBulletEntryTitles = nil,
				mBulletEntryData = mBulletEntryData,
				mTransmissions = __wf_atom_34817f31,
				mQuest = __wf_atom_1f54a4ab,
				mHasRewards = mHasRewards,
				mRewardsLoaded = false,
				mRedeemed = mScanInfo.mRedeemed,
				mScanInfo = mScanInfo,
				mIsSparse = __wf_atom_7188fa33,
				mImage = mItemRes:__wf_atom_39b54051(),
				mItemRes = mItemRes
			})
		end
	end
end

local v7 = Resource("/SF/Interface/Materials/FishStarMaskMaterial")
local v8 = Resource("/SF/Interface/Graphics/Fishing/FishingFullStar.png")
local v9 = Resource("/SF/Interface/Graphics/Fishing/FishingFullStarSilver.png")
local v10 = Resource("/SF/Interface/Graphics/Fishing/FishingFullStarBronze.png")
local v11 = Resource("/SF/Interface/Graphics/Fishing/FishingFullStarShadow.png")

function GenerateStars(object, p, p2, p3, p4)
	local v12 = math.ceil(p3)
	local v13 = 50
	local v14 = (v12 - 1) * v13 / 2

	if v12 == 1 then
		v14 = p
		v13 = 0
	end

	local v15 = v8

	if p4 == 1 then
		v15 = v10
	elseif p4 == 2 then
		v15 = v9
	end

	for i = 1, 5 do
		local v16 = p2 .. i

		if p3 > 0 then
			object:__wf_atom_2dedec1a(v16, 13, true)
			local _ = -v14 + v13 * (i - 1)
			object:__wf_atom_e57658c2(v16, 0, p + v13 * (i - 1))
			object:__wf_atom_c90af43a(v16 .. ".Shadow", v11)
			object:__wf_atom_e57658c2(v16, 5, 25)
			object:__wf_atom_e57658c2(v16, 6, 25)
			object:__wf_atom_e57658c2(v16, 12, 0)
			local v17 = v16 .. ".Icon"

			if p3 < 1 then
				object:__wf_atom_933bbce0(v17, v15, v7)
				object:__wf_atom_1ca72041(v17, "AlphaTestThreshold", p3, 0, 0, 0)
				object:__wf_atom_e57658c2(v17, 5, -math.abs((object:__wf_atom_5e6e15c8(v17, 5))))
			else
				object:__wf_atom_933bbce0(v17, v15, nil)
			end

			__wf_atom_ec43d06e(object, v16, 4, { 5, 6, 12 }, { 70, 70, 100 }, 1, i * 0.1)
		else
			object:__wf_atom_2dedec1a(v16, 13, false)
		end

		p3 -= 1
	end
end

function CreateCodexButton(p, p2, p3)
	__wf_atom_86cbd68d(p, "Codex.Content.Btn.duplicateMovieClip", p2, p3)
	local v12 = "Codex.Content." .. p2
	return module7.CreateCircleButton(p, v12)
end