module(..., package.seeall)
TIER = {
	FALLBACK = 0,
	DEFAULT = 1,
	TWO_WINNERS = 2,
	THREE_WINNERS = 3,
	FOUR_WINNERS = 4,
	WARFRAME_ARENA = 5,
	DRAGON = 6,
	QUEST = 7,
	ENDLESS_INTRINSICS = 8,
	ENDLESS_BOON = 9,
	STEELDRAGON = 10,
	STEELPATHWARFRAME_ARENA = 11,
	MEGAPUZZLE_REWARD = 12
}
COLLECTIBLE_DECO_REWARD_INTRINSICS = 5000
local v = WeakResource("/Lotus/Interface/BoonNotification.swf")
local v2 = WeakResource("/Lotus/Interface/DuviriMissionComplete.swf")
local v3 = WeakResource("/Lotus/Types/Gameplay/Duviri/Encounters/ReplicatedRewardTrigger")
local v4 = {
	[TIER.FALLBACK] = {
		boonRarity = 0,
		intrinsicPoints = 0,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText"
	},
	[TIER.DEFAULT] = {
		boonRarity = 0,
		intrinsicPoints = 3000,
		steelPathIntrinsics = 3000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.TWO_WINNERS] = {
		boonRarity = 1,
		intrinsicPoints = 4000,
		steelPathIntrinsics = 4000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.THREE_WINNERS] = {
		boonRarity = 1,
		intrinsicPoints = 5000,
		steelPathIntrinsics = 5000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.FOUR_WINNERS] = {
		boonRarity = 1,
		intrinsicPoints = 6000,
		steelPathIntrinsics = 6000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.WARFRAME_ARENA] = {
		boonRarity = 2,
		intrinsicPoints = 6000,
		steelPathIntrinsics = 6000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.DRAGON] = {
		boonRarity = 2,
		intrinsicPoints = 15000,
		steelPathIntrinsics = 25000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		storeItems = {
			{
				ItemType = Resource("/Lotus/StoreItems/Types/Gameplay/Duviri/Resource/DuviriDragonDropItem"),
				ItemCount = 10,
				ItemEvent = false
			}
		}
	},
	[TIER.QUEST] = {
		boonRarity = nil,
		intrinsicPoints = 20000,
		steelPathIntrinsics = 0,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = nil
	},
	[TIER.ENDLESS_INTRINSICS] = {
		intrinsicPoints = 4000,
		steelPathIntrinsics = 4000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriCircuitResourceRewards")
	},
	[TIER.ENDLESS_BOON] = {
		boonRarity = 0,
		intrinsicPoints = 0,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText"
	},
	[TIER.STEELDRAGON] = {
		boonRarity = 2,
		intrinsicPoints = 15000,
		steelPathIntrinsics = 25000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		storeItems = {
			{
				ItemType = Resource("/Lotus/StoreItems/Types/Gameplay/Duviri/Resource/DuviriDragonDropItem"),
				ItemCount = 15,
				ItemEvent = false
			},
			{
				ItemType = Resource("/Lotus/StoreItems/Types/Items/MiscItems/SteelEssence"),
				ItemCount = 5,
				ItemEvent = true
			}
		}
	},
	[TIER.STEELPATHWARFRAME_ARENA] = {
		boonRarity = 2,
		intrinsicPoints = 6000,
		steelPathIntrinsics = 6000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	},
	[TIER.MEGAPUZZLE_REWARD] = {
		boonRarity = 2,
		intrinsicPoints = 5000,
		steelPathIntrinsics = 5000,
		rewardLoc = "/Lotus/Language/Duviri/DefaultRewardText",
		missionRewardManifest = Resource("/Lotus/Types/Game/MissionDecks/DuviriEncounterRewards/DuviriResourceRewards")
	}
}
local v5 = nil

local function fn(playerAvatar)
	if not __wf_atom_7e8ad928(v5) then
		return v5 == playerAvatar:__wf_atom_e800787c()
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WfCavePlayerSpawn"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v5 = __wf_atom_0a6a5887:__wf_atom_e800787c()
	end

	if __wf_atom_7e8ad928(v5) then
		print("Error: Player spawn or zone not found!")
		return false
	end

	return v5 == playerAvatar:__wf_atom_e800787c()
end

local function fn2()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_24c78019 = __wf_atom_eab484a7:__wf_atom_24c78019()
		local movie = __wf_atom_8e4fda44:FindMovie(v)

		if __wf_atom_24c78019 > 0 then
			if __wf_atom_7e8ad928(movie) then
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(v)
			end
		elseif not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end
	end
end

function RewardAll(default)
	if gRegion:IsMaster() then
		local entity = gRegion:CreateEntity(Type(v3), __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)

		if __wf_atom_7e8ad928(default) then
			default = TIER.DEFAULT
		end

		entity:SetState(default)
		entity:FirePort("Execute")
	end
end

local function fn3()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, #__wf_atom_3c8e1a7a do
		local v6 = __wf_atom_3c8e1a7a[i]
		local __wf_atom_eff0517e = v6:__wf_atom_eff0517e()
		local __wf_atom_04b7536b = v6:__wf_atom_04b7536b()

		if
			not __wf_atom_7e8ad928(__wf_atom_eff0517e) and __wf_atom_7e8ad928(__wf_atom_eff0517e:__wf_atom_0d9c1a58())
			or not __wf_atom_7e8ad928(__wf_atom_04b7536b)
			and __wf_atom_7e8ad928(__wf_atom_04b7536b:__wf_atom_0d9c1a58())
		then
			return false
		end
	end

	return true
end

local function fn4() -- 2 equivalent calls inferred from this helper
	return gGameRules:__wf_atom_72fc675e().tier > 0
end

local function fn5(boonOverride, intrinsicPoints, list, rewardLoc)
	if _T.ActiveJob and _T.ActiveJob.boonOverride then
		boonOverride = _T.ActiveJob.boonOverride
	end

	if intrinsicPoints == nil then
		intrinsicPoints = fn4() and 3000 or 2000 -- inferred equivalent call
	end

	if rewardLoc == nil then
		Localize("/Lotus/Language/Duviri/DefaultRewardText", {
			INTRINSICS = intrinsicPoints,
			BOONS = boonOverride
		})
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local v6 = not __wf_atom_7e8ad928(playerAvatar) and fn(playerAvatar) and true or false
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) or not __wf_atom_eab484a7:IsActive() or v6 then
		if __wf_atom_7e8ad928(__wf_atom_eab484a7) or not v6 then
			if __wf_atom_7e8ad928(__wf_atom_eab484a7) or v6 then
				print("No rewards: nil local player!?")
			else
				print("No rewards: inactive player")
			end
		else
			print("No rewards: player in cave")
		end
	else
		local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
		local playerAvatar2 = __wf_atom_eab484a7:GetPlayerAvatar(0)
		local missionRewards = {}

		for _, v7 in ipairs(list) do
			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				print("Couldn't award bonus items because there's no local avatar! Not fully connected?")
			else
				__wf_atom_50a7d83e:__wf_atom_d2b2176d():GiveBonusNonReplicatedMiscItem(
					v7.StoreItem:GetItem(),
					v7.ItemCount,
					v7.ItemEvent == true
				)
			end

			if not v7.ItemEvent then
				table.insert(missionRewards, {
					StoreItem = v7.StoreItem:__wf_atom_5b41f63b(),
					ItemCount = v7.ItemCount
				})
			end
		end

		if __wf_atom_7e8ad928(playerAvatar2) then
			print("Couldn't award intrinsic points because there's no Warframe avatar!")
		else
			playerAvatar2:__wf_atom_d2b2176d():__wf_atom_34a61d7e(1, intrinsicPoints)
		end

		if boonOverride then
			__wf_atom_eab484a7:__wf_atom_3476cf96(boonOverride)

			if _G.duviriBoons ~= nil then
				table.insert(_G.duviriBoons.reserve, boonOverride)
			end
		end

		local __wf_atom_8b74c30b = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v2)

		if not __wf_atom_7e8ad928(__wf_atom_8b74c30b) then
			local dmcRewardJSON

			if next(missionRewards) ~= nil then
				dmcRewardJSON = cjson.encode({ MissionRewards = missionRewards })
			end

			_T.DMCRewardJSON = dmcRewardJSON
			__wf_atom_8b74c30b:Execute("SetInfo", tostring(intrinsicPoints) .. "," .. tostring(boonOverride) .. ",true")
		end
	end

	fn2()
	print("GRANT COMPLETE")

	if gGameRules:__wf_atom_e22d6f15() == 28 then
		while not fn3() do
			Sleep(0.1)
		end

		gGameRules:CommitInventoryCheckpointToDB(0, 0)
	end
end

function OnReward(instance)
	local state = instance:GetState()
	local v6 = 5

	while state == 0 and v6 > 0 do
		Sleep(0)
		v6 -= __wf_atom_fa1258d0()
		state = instance:GetState()
	end

	local v7 = v4[state]

	if __wf_atom_7e8ad928(v7) then
		print("Invalid Tier for Duviri Rewards: " .. tostring(state) .. "; using default!")
		v7 = v4[1]
	end

	print("Giving rewards from " .. instance:GetName())
	local v8 = {}

	if v7.storeItems then
		for _, storeItem in ipairs(v7.storeItems) do
			if __wf_atom_7e8ad928(storeItem.ItemType) then
				continue
			end

			local itemCount = storeItem.ItemCount == nil and 1 or storeItem.ItemCount
			table.insert(v8, {
				StoreItem = storeItem.ItemType,
				ItemCount = itemCount,
				ItemEvent = storeItem.ItemEvent
			})
		end
	end

	if not __wf_atom_7e8ad928(v7.missionRewardManifest) then
		local __wf_atom_0b43ffae = v7.missionRewardManifest:__wf_atom_0b43ffae(0, math.random())
		local tieredItem = v7.missionRewardManifest:GetTieredItem(0, __wf_atom_0b43ffae)
		table.insert(v8, { StoreItem = tieredItem.mStoreItem, ItemCount = tieredItem.mItemCount })
	end

	local intrinsicPoints = v7.intrinsicPoints

	if fn4() then -- inferred equivalent call
		intrinsicPoints = v7.steelPathIntrinsics
	end

	fn5(v7.boonRarity, intrinsicPoints, v8, v7.rewardLoc)

	if gRegion:IsMaster() then
		Sleep(3)
		print("Disabling " .. instance:GetName())
		instance:Disable()
		Sleep(3)
		print("Destroying " .. instance:GetName())
		instance:Destroy()
	end
end

function RefreshBoonLabel()
	fn2()
end

function HideBoonLabel()
	local movie = __wf_atom_8e4fda44:FindMovie(v)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end
end