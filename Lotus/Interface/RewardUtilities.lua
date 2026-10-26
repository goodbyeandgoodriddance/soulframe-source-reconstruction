module(..., package.seeall)
local v = Symbol("LostTargetWave")
local v2 = Symbol("DefenseTargetCount")
local v3 = Symbol("RewardsGiven")
local v4 = Symbol("SolNode332")
local flag = false
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local v5 = __wf_atom_3e61816b(0)

local function fn(object) -- 1 equivalent call inferred from this helper
	return not __wf_atom_7e8ad928(object) and object:__wf_atom_a4299765().mIsFirstTimeInNode
end

local function fn2(p, p2, list) -- 2 equivalent calls inferred from this helper
	local v6 = math.max(0, p) % p2

	if v6 < list[1] then
		return 0
	end

	if v6 < list[2] then
		return 1
	end

	return 2
end

local function fn3(object, state, __wf_atom_88f84472, p, value, value2, p2, list)
	local v6 = value or 1
	local v7 = value2 or 0

	if __wf_atom_7e8ad928(object) then
		return
	end

	local result = {}
	local __wf_atom_ca0f2268 = object:__wf_atom_ca0f2268()

	if state.location == v4 and fn(object) then -- inferred equivalent call
		state.missionReward = state.missionRewardExtra
		flag = true
	end

	local v8

	if state.goalTag == Symbol("VoidEclipse") then
		v8 = not __wf_atom_7e8ad928(state.missionRewardExtra.randomizedItems)
	else
		v8 = false
	end

	if __wf_atom_88f84472 == v5 or __wf_atom_7e8ad928(state.missionReward.randomizedItems) then
		print("Reward seed uninitialized")
		return result
	end

	local randomizedItems = state.missionReward.randomizedItems
	local v9 = __wf_atom_04d7eaaa()
	__wf_atom_01bfe5c4(__wf_atom_88f84472)
	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("ConsecutiveRJ"), 0)

	if __wf_atom_d163c8e5 > 0 then
		for _ = 1, __wf_atom_d163c8e5 * 2 do
			__wf_atom_8d119bab(0, 1)
		end
	end

	for i = 1, p do
		local v10

		if v7 > 0 and v7 <= i then
			v10 = v6 - 1
		else
			v10 = v6
		end

		local v11 = 4
		local v12 = { 2, 3 }

		if flag then
			v12[1] = 1
			v12[2] = 3
			v11 = 5
		elseif
			state.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG
			or state.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG_ALT
		then
			v12[1] = 2
			v12[2] = 4
			v11 = 1000
		end

		local v13

		if list then
			v13 = __wf_atom_421b01aa(list[i], 0, 3)
		else
			v13 = fn2(i - 1, v11, v12) -- inferred equivalent call
		end

		for _ = 1, v10 do
			local __wf_atom_0b43ffae = randomizedItems:__wf_atom_0b43ffae(v13, (__wf_atom_8d119bab(0, 1)))

			if __wf_atom_0b43ffae == -1 then
				continue
			end

			local tieredItem = randomizedItems:GetTieredItem(v13, __wf_atom_0b43ffae)
			local v14

			if __wf_atom_8d119bab(0, 1) <= __wf_atom_ca0f2268 then
				v14 = gGameRules:__wf_atom_c0d019d3(i - 1)
			else
				v14 = false
			end

			if not v14 then
				tieredItem = nil
			end

			local levelOverride = 0
			local storeItem, mItemCount

			if __wf_atom_7e8ad928(tieredItem) then
				mItemCount = 0
			else
				storeItem = tieredItem:GetStoreItem()
				mItemCount = tieredItem.mItemCount

				if not __wf_atom_7e8ad928(storeItem) then
					local item = storeItem:GetItem()

					if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_58a409f1) then
						if not item:IsA(WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")) then
							local upgradeInfo = SF.UpgradeInfo()
							upgradeInfo.mItemType = item
							upgradeInfo.mItemCount = 1
							gGameData:__wf_atom_2f4535b3(upgradeInfo)
						end

						levelOverride = SF.__wf_atom_79a0f336(item, tieredItem:__wf_atom_a4e01155())
					end
				end
			end

			local v15 = false

			if p2 then
				for j = 1, #result do
					if result[j].storeItem ~= storeItem then
						continue
					end

					result[j].itemCount = result[j].itemCount + mItemCount
					v15 = true
					break
				end
			end

			if not v15 then
				table.insert(result, {
					storeItem = storeItem,
					levelOverride = levelOverride,
					itemCount = mItemCount,
					wave = i
				})
			end

			if not (v8 and v14) then
				continue
			end

			local tieredItem2 = state.missionRewardExtra.randomizedItems:GetTieredItem(0, 0)

			if __wf_atom_7e8ad928(tieredItem2) then
				continue
			end

			local storeItem2 = tieredItem2:GetStoreItem()
			local mItemCount2 = tieredItem2.mItemCount

			if state.tier > 0 then
				mItemCount2 += module.Ternary(state.name == Symbol("SolNode309"), 2, 1)
			end

			table.insert(result, {
				storeItem = storeItem2,
				levelOverride = 0,
				itemCount = mItemCount2,
				wave = i,
				isBonus = true
			})
		end
	end

	__wf_atom_01bfe5c4(v9)
	return result
end

function GenerateDefenseRewards(p, p2)
	local v6 = p == nil or p
	local v7 = gRegion:__wf_atom_e23b2855()[1]

	if __wf_atom_7e8ad928(v7) then
		return
	end

	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v2, 1)
	local v8 = math.ceil(gGameRules:__wf_atom_d163c8e5(v, 0) / 5)
	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
	local __wf_atom_a56b661d = gGameRules:__wf_atom_a56b661d()

	if v6 then
		__wf_atom_a56b661d += 1
	end

	return fn3(v7, __wf_atom_72fc675e, gGameRules:__wf_atom_88f84472(), __wf_atom_a56b661d, __wf_atom_d163c8e5, v8, p2)
end

function GenerateSurvivalRewards(p, p2)
	local v6 = gRegion:__wf_atom_e23b2855()[1]

	if __wf_atom_7e8ad928(v6) then
		return
	end

	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

	if p == nil then
		p = gGameRules:__wf_atom_d163c8e5(v3)
	end

	local v7 = 4
	local v8 = { 2, 3 }

	if flag then
		v8[1] = 1
		v8[2] = 3
		v7 = 5
	elseif
		__wf_atom_72fc675e.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG
		or __wf_atom_72fc675e.periodicMissionTag == module2.ELITE_ALERT_PERIODIC_MISSION_TAG_ALT
	then
		v8[1] = 2
		v8[2] = 4
		v7 = 1000
	end

	print("RewardUtilities: Gave reward tier " .. fn2(p - 1, v7, v8)) -- inferred equivalent call
	return fn3(v6, __wf_atom_72fc675e, gGameRules:__wf_atom_88f84472(), p, nil, nil, p2)
end

function GenerateDisruptionRewards(p, p2)
	local v6 = gRegion:__wf_atom_e23b2855()[1]

	if __wf_atom_7e8ad928(v6) then
		return
	end

	if p == nil then
		p = gGameRules:__wf_atom_d163c8e5(v3, 0)
	end

	if p == 0 then
		print("GenerateDisruptionRewards: no rewards earned")
		return
	end

	local __wf_atom_85391a4d = gGameRules:__wf_atom_85391a4d()

	if p ~= #__wf_atom_85391a4d then
		print("GenerateDisruptionRewards: reward mismatch " .. p .. ", " .. #__wf_atom_85391a4d)
		return
	end

	return fn3(
		v6,
		gGameRules:__wf_atom_72fc675e(),
		gGameRules:__wf_atom_88f84472(),
		p,
		nil,
		nil,
		p2,
		__wf_atom_85391a4d
	)
end