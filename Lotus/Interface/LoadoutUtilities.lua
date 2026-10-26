module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.CardUtilitiesRedux")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local v = WeakResource()
local v2 = WeakResource()
local v3 = WeakResource()
WeakResource()
local v4 = WeakResource()
local v5 = WeakResource()
MOD_SLOTS = {
	NORMAL = 8,
	STANCE_INDEX = 9,
	AURA_INDEX = 9,
	UTILITY_INDEX = 10,
	IMMORTAL_INDEX = 4,
	RAILJACK_AURA_INDEX = 15
}
CONFIG_TYPES = { "A", "B", "C", "D", "E", "F" }
EGG_TYPE_KUBROW = 0
EGG_TYPE_CATBROW = 1
CRYSTAL_COLORS = { 15079461, 15079461, 16304215, 16304215, 3910654, 3910654 }

function GetSwapOperation(p, _, mItemCategory, list)
	local upgradeOperation = SF.UpgradeOperation()
	upgradeOperation.mItemCategory = mItemCategory
	upgradeOperation.mItemId:Parse(p.mItemId.mId)
	upgradeOperation.mItemFeatures = p.mFeatures
	local upgradeOperationItem = SF.UpgradeOperationItem()
	upgradeOperationItem.mOperationType = 10

	for _, v6 in ipairs(list) do
		upgradeOperationItem:__wf_atom_b2e82741(v6.mSlot, v6.mValue)
	end

	upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
	return upgradeOperation
end

function GetPolarizeOperationType(p)
	for k, v6 in pairs(nil) do
		if v6 == p then
			return k
		end
	end

	return nil
end

local function fn(object, p) -- 1 equivalent call inferred from this helper
	return not object:__wf_atom_717d3c58(p) and ((p ~= 3 or object:__wf_atom_717d3c58(1)) and true or false)
end

function GetFeatureOperation(object, object2, p, mItemCategory)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or not fn(object, p) then -- inferred equivalent call
		return nil
	end

	local __wf_atom_f80ff90a = object2:__wf_atom_f80ff90a(p)

	if __wf_atom_7e8ad928(__wf_atom_f80ff90a) then
		return nil
	end

	local upgradeOperation = SF.UpgradeOperation()
	upgradeOperation.mItemCategory = mItemCategory
	upgradeOperation.mItemId:Parse(object.mItemId.mId)
	upgradeOperation.mItemFeatures = object.mFeatures

	if p == 1 then
		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 1
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	elseif p == 2 then
		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 2
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	elseif p == 3 then
		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 3
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	elseif p == 8 then
		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 12
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	elseif p == 9 then
		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 13
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	else
		if p ~= 6 then
			return upgradeOperation
		end

		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 11
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a
		upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
		return upgradeOperation
	end
end

function UnlockFeature(object, p, object2, p2)
	if
		__wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(gGameData)
		or __wf_atom_7e8ad928(object2)
		or __wf_atom_7e8ad928(object)
		or not object:Validate()
		or #object.mOperations ~= 1
	then
		return nil
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return nil
	end

	local mUpgradeRequirement = object.mOperations[1].mUpgradeRequirement
	local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(mUpgradeRequirement)

	if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
		return nil
	end

	local __wf_atom_52fcdd65 = gGameData:GetInventory():__wf_atom_52fcdd65(mUpgradeRequirement)

	if __wf_atom_52fcdd65 == 0 then
		return false
	end

	local mOperationType = object.mOperations[1].mOperationType
	local v6

	if mOperationType == 1 then
		v6 = "/Lotus/Language/Menu/Loadout_UpgradeItemConfirm"
	elseif mOperationType == 2 then
		v6 = "/Lotus/Language/Menu/Loadout_UnlockUtilitySlotConfirm"
	elseif mOperationType == 3 then
		v6 = "/Lotus/Language/Menu/Loadout_HeavyWeapPrereqUpgradeConfirm"
	elseif mOperationType == 12 or mOperationType == 13 then
		v6 = "/Lotus/Language/Menu/Loadout_UnlockConfigSlotConfirm"
	elseif mOperationType == 11 then
		v6 = "/Lotus/Language/Menu/ArcaneSlot_InstallConfirm"
	else
		return nil
	end

	if p2 ~= nil then
		v6 = p2
	end

	local __wf_atom_8e9ac384 = object2:__wf_atom_8e9ac384(v6, false, {
		ITEM = object2:__wf_atom_8e9ac384(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), false),
		COUNT = module.FormatNumber(__wf_atom_52fcdd65)
	})
	module.ShowConfirmMessage(__wf_atom_8e9ac384, p)
	return true
end

function UnlockFeatureUpsell(object, p, object2, p2)
	if
		__wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(object2)
		or __wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(_T.BuyItem)
		or not object:Validate()
		or #object.mOperations ~= 1
	then
		return false
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return false
	end

	local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(object.mOperations[1].mUpgradeRequirement)

	if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
		return false
	end

	_T.BuyItem(__wf_atom_232fd31d, function(p3)
		object2:Execute(p, (tostring(p3)))
	end, nil, nil, p2)
	return true
end

function GetPolarizeOperation(p, p2, mOperationType, mItemCategory, mPolarizeSlot, mPolarizeValue)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return nil
	end

	local mUpgradeRequirement = (nil)[mOperationType]

	if __wf_atom_7e8ad928(mUpgradeRequirement) then
		return nil
	end

	local upgradeOperation = SF.UpgradeOperation()
	upgradeOperation.mItemCategory = mItemCategory
	upgradeOperation.mItemId:Parse(p.mItemId.mId)
	upgradeOperation.mItemFeatures = p.mFeatures
	local upgradeOperationItem = SF.UpgradeOperationItem()
	upgradeOperationItem.mOperationType = mOperationType
	upgradeOperationItem.mUpgradeRequirement = mUpgradeRequirement
	upgradeOperationItem.mPolarizeSlot = mPolarizeSlot
	upgradeOperationItem.mPolarizeValue = mPolarizeValue
	upgradeOperation:__wf_atom_a0a9fa7a(upgradeOperationItem)
	return upgradeOperation
end

function GetPassiveDescription(object, object2, object3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) then
		return ""
	end

	local c_str = object3:__wf_atom_3e0a2478():c_str()

	if c_str ~= "" then
		_T.PassiveInfo = nil
		object2:__wf_atom_51009507(object3:__wf_atom_4a011391(), Symbol("GetPassiveInfo"), false)
		c_str = object:__wf_atom_8e9ac384(c_str, true, _T.PassiveInfo)
	end

	return c_str
end

function IsUtilitySlot(instance, p)
	local isA = instance:IsA(v)
	local v6 = instance:IsA(v2) or instance:IsA(v3)
	return isA and p == MOD_SLOTS.UTILITY_INDEX and true or v6 and p == MOD_SLOTS.AURA_INDEX and true or false
end

local function fn2(p, p2)
	if
		__wf_atom_7e8ad928(p2.type)
		or not p2.type:IsA(__wf_atom_d98e64fe)
		or p2.type:IsA(__wf_atom_202871eb)
		or __wf_atom_7e8ad928(p2.item)
	then
		return false
	end

	return p == 4 or p == 5
end

function IsSpecialSuitItem(p, p2)
	return (fn2(p, p2))
end

local function fn3(p, p2)
	if
		__wf_atom_7e8ad928(p2)
		or __wf_atom_7e8ad928(p2.type)
		or not p2.type:IsA(__wf_atom_77e05d3b)
		or __wf_atom_7e8ad928(p2.item)
	then
		return false
	end

	return p == 4 or p == 5
end

function IsSpecialMeleeItem(p, p2)
	return (fn3(p, p2))
end

function GetConfigList(object, list, p, p2)
	local result = {}

	if __wf_atom_7e8ad928(list) then
		return result
	end

	for _, mItemInfo in ipairs(list) do
		local v6

		if p2 then
			v6 = mItemInfo:__wf_atom_272b2865()
		else
			v6 = mItemInfo:__wf_atom_7e44023f()
		end

		local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mItemInfo.mXP, mItemInfo.mItemType)
		local v7 = __wf_atom_c67f9605:__wf_atom_a1680b24(mItemInfo.mItemType) <= __wf_atom_b4a75eaa
		local mItemName = object:__wf_atom_8e9ac384(Resource(mItemInfo.mItemType):__wf_atom_014a76a2():c_str(), false)

		if mItemInfo.mDetails == nil then
			if mItemInfo.mItemName ~= "" then
				mItemName = mItemInfo.mItemName
			end
		else
			mItemName = mItemInfo.mDetails.mName
		end

		local mName

		if v7 then
			mName = mItemName .. " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Ranks/MaxRankAbbreviated", false)
		else
			mName = mItemName .. " [" .. __wf_atom_b4a75eaa .. "]"
		end

		table.insert(result, { mName = mName, Type = module4.TITLE })

		for i = 1, v6 do
			local mName2 = not p and "" or mItemInfo:__wf_atom_1e862848(i - 1) or ""

			if mName2 == "" then
				mName2 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Config", false, {
					TYPE = CONFIG_TYPES[i]
				})
			end

			table.insert(result, {
				mName = mName2,
				mItemInfo = mItemInfo,
				mConfigId = i - 1
			})
		end
	end

	return result
end

function GetInfosForLinking(object, instance, p, p2)
	local result = {}

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return result
	end

	if instance:IsA(__wf_atom_202871eb) then
		local __wf_atom_9ddc0f59 = object:__wf_atom_9ddc0f59()

		for i = 1, #__wf_atom_9ddc0f59 do
			if __wf_atom_9ddc0f59[i].mDetails.mDominantTraits.mPersonality == instance then
				table.insert(result, __wf_atom_9ddc0f59[i])
			end
		end
	else
		result = object:__wf_atom_2b1ab77a(instance) or {}
	end

	if not p2 or __wf_atom_7e8ad928(p) then
		return result
	end

	local mId = p.mItem.mItemId.mId

	for i, v6 in ipairs(result) do
		if v6.mItemId.mId ~= mId then
			continue
		end

		table.remove(result, i)
		break
	end

	local __wf_atom_0ff4b555 = object:__wf_atom_0ff4b555(mId)

	if __wf_atom_7e8ad928(__wf_atom_0ff4b555.mItemType) then
		return result
	end

	if p.mItem.mItemType:IsA(__wf_atom_202871eb) then
		local __wf_atom_9ddc0f59 = object:__wf_atom_9ddc0f59()

		for i = 1, #__wf_atom_9ddc0f59 do
			if __wf_atom_9ddc0f59[i].mItemId.mId ~= mId then
				continue
			end

			__wf_atom_0ff4b555 = __wf_atom_9ddc0f59[i]
			break
		end
	end

	table.insert(result, 1, __wf_atom_0ff4b555)
	return result
end

function GetCalculateXForInstallGrid(p, p2, p3, p4)
	local v6 = p2 == 3 or fn2(p3, p4)
	local v7 = p2 == 1 or p2 == 0
	local v8 = p2 == 5 or fn3(p3, p4)
	local v9 = p2 == 49
	p.InstallGrid_CalculateX = p.CalculateX

	function p.CalculateX(object, p5)
		local id = p5.Id

		if p5.mSlotIndex ~= nil then
			id = p5.mSlotIndex
		end

		if v6 then
			if id == MOD_SLOTS.AURA_INDEX then
				return object.mInitialX + 2 * object.mColumnSeparation
			end

			if id == MOD_SLOTS.UTILITY_INDEX then
				return object.mInitialX + object.mColumnSeparation
			end
		elseif v7 or v8 then
			if id == MOD_SLOTS.AURA_INDEX then
				if v8 or _T.InstallGrid_ForceWeaponUtilCenter then
					return object.mInitialX + 1.5 * object.mColumnSeparation
				end

				return object.mInitialX - object.mColumnSeparation
			end
		elseif v9 and id == MOD_SLOTS.RAILJACK_AURA_INDEX then
			return object.mInitialX + 4 * object.mColumnSeparation
		end

		return (object:InstallGrid_CalculateX(p5))
	end
end

function GetCalculateYForInstallGrid(p, p2, _, _, p3)
	local v6 = p2 == 1 or p2 == 0
	local v7 = p2 == 49
	p.InstallGrid_CalculateY = p.CalculateY

	function p.CalculateY(object, p4)
		local id = p4.Id

		if p4.mSlotIndex ~= nil then
			id = p4.mSlotIndex
		end

		if
			(not v6 or id ~= MOD_SLOTS.AURA_INDEX or _T.InstallGrid_ForceWeaponUtilCenter)
			and (not v7 or id ~= MOD_SLOTS.RAILJACK_AURA_INDEX)
		then
			return (object:InstallGrid_CalculateY(p4))
		end

		return object.mInitialY + (v6 and p3 and 0 or 0.5) * object.mRowSeparation
	end
end

function GetRowColumnForInstallGrid(_, _, _)
	return 3, 4
end

function GetDataKnifeCombination(p)
	local v6 = p == true
	local result = {}

	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameData) then
		return result
	end

	if module4.GetUIMode() == module4.UI_MODE_IN_GAME then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			__wf_atom_eab484a7:__wf_atom_a4299765()
		end
	else
		gGameData:__wf_atom_a4299765()
	end

	if __wf_atom_7e8ad928(nil) then
		return result
	end

	local mAttachedUpgrades = (nil).mAttachedUpgrades

	for i = MOD_SLOTS.IMMORTAL_INDEX + 2, MOD_SLOTS.IMMORTAL_INDEX, -1 do
		local v7 = false

		if mAttachedUpgrades ~= nil and mAttachedUpgrades[i] ~= nil then
			local mAttachedUpgrade = mAttachedUpgrades[i]
			local mItemType = mAttachedUpgrade.mItemType

			if not __wf_atom_7e8ad928(mItemType) and mItemType:IsA(module3.immortalModType) then
				local mInstance = mAttachedUpgrade.mInstance

				if mInstance:__wf_atom_c6a5f697(mAttachedUpgrade.mUpgradeFingerprint) < mInstance:__wf_atom_49f7d220("") then
					if v6 then
						table.insert(result, mAttachedUpgrades[i])
					else
						table.insert(result, mItemType)
					end

					v7 = true
				end
			end
		end

		if v7 then
			continue
		end

		if v6 then
			table.insert(result, {})
		else
			table.insert(result, WeakResource("/Lotus/Upgrades/Mods/Immortal/ImmortalBaseMod"))
		end
	end

	return result
end

function GetPetGenderBreed(object, p)
	local result = { GenderName = "", GenderIcon = nil, BreedName = "", BreedIcon = nil }

	if __wf_atom_7e8ad928(p) then
		return result
	end

	local mIsMale = p.mDetails.mIsMale
	result.GenderName = module.Ternary(mIsMale, "/Lotus/Language/Menu/KubrowMale", "/Lotus/Language/Menu/KubrowFemale")
	result.GenderIcon = module.Ternary(mIsMale, (nil)[2], (nil)[1])

	for i = 1, #nil do
		local v6 = (nil)[i]

		if v6.Type ~= p.mItemType then
			continue
		end

		result.BreedName = object:__wf_atom_8e9ac384(v6.Name, false)
		result.BreedIcon = v6.Icon
		return result
	end

	return result
end

function CalculateRushCost(p, p2, p3)
	local v6 = p * (p3 / p2)
	return (math.ceil((math.min(p, p * 0.5 + v6))))
end

function FromBuyableBundle(p, object)
	return #object:__wf_atom_b30d5ab2(p) > 0
end

local function fn4()
	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local __wf_atom_9ddc0f59 = gGameData:GetInventory():__wf_atom_9ddc0f59()

	for _, v6 in ipairs(__wf_atom_9ddc0f59) do
		if v6.mDetails.mStatus ~= 3 then
			return v6
		end
	end

	return nil
end

function GetActiveKubrow()
	return (fn4())
end

function GetPetSpawnInfo(object, p)
	local inventory = object:GetInventory()
	local __wf_atom_a4299765 = object:__wf_atom_a4299765()
	local v6 = {
		["sentinelPowerSuitWRes"] = nil,
		sentinelPowerSuitCustomization = nil,
		kubrowPowerSuitWRes = nil,
		kubrowPowerSuitCustomization = nil,
		kubrowInteractionAllowed = false,
		moaPetWeaponWRes = nil,
		moaPetSuitCustomization = nil,
		moaPetParts = nil,
		moaIsGilded = false,
		sentinelIsSentinel = __wf_atom_a4299765.mPetType == 0,
		sentinelIsKubrow = __wf_atom_a4299765:__wf_atom_daf48817(),
		sentinelIsMoa = __wf_atom_a4299765:__wf_atom_225bc4a6(),
		initialDomeState = { closed = false, opaque = false },
		spawnEgg = false,
		hatchedEggVisible = false,
		eggTypeToSpawn = EGG_TYPE_KUBROW,
		hideSentinel = true,
		hideMoaPet = true
	}

	if v6.sentinelIsSentinel then
		local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(1, 0)

		if __wf_atom_ed5c034d.mItemId ~= SF.__wf_atom_b8679e91 then
			v6.sentinelPowerSuitWRes = __wf_atom_ed5c034d.mItemType
			v6.sentinelPowerSuitCustomization = __wf_atom_ed5c034d:__wf_atom_eb82ab1f(0, inventory:__wf_atom_71d5cc00())
			v6.hideSentinel = false
		end
	end

	if v6.sentinelIsMoa then
		local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(1, 0)

		if __wf_atom_ed5c034d.mItemId ~= SF.__wf_atom_b8679e91 then
			v6.moaPetWeaponWRes = __wf_atom_ed5c034d.mItemType
			v6.moaPetParts = __wf_atom_ed5c034d.mModularParts
			v6.moaIsGilded = __wf_atom_ed5c034d:__wf_atom_717d3c58(4)
			v6.moaPetSuitCustomization = __wf_atom_ed5c034d:__wf_atom_eb82ab1f(0, inventory:__wf_atom_71d5cc00())
			v6.hideMoaPet = false
		end
	end

	local kubrow = fn4()

	if kubrow then
		local flag = false

		if kubrow.mDetails.mStatus == 0 or kubrow.mDetails.mStatus == 1 then
			if kubrow.mDetails.mStatus == 0 and Engine.__wf_atom_db2b0cee(kubrow.mDetails.mHatchDate) > 0 then
				v6.spawnEgg = true

				if kubrow.mItemType:IsA(v4) then
					v6.eggTypeToSpawn = EGG_TYPE_CATBROW
				end
			else
				v6.hatchedEggVisible = true
				flag = true
			end

			v6.initialDomeState.closed = true
		else
			flag = true

			if kubrow.mDetails.mStatus == 2 then
				v6.kubrowInteractionAllowed = true
			else
				v6.initialDomeState.closed = true
				v6.initialDomeState.opaque = true
			end
		end

		if flag then
			v6.kubrowPowerSuitWRes = kubrow.mItemType
			local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(1, 0)

			if v6.sentinelIsKubrow and __wf_atom_ed5c034d.mItemId.mId == kubrow.mItemId.mId then
				v6.kubrowPowerSuitCustomization = __wf_atom_ed5c034d:__wf_atom_eb82ab1f()
			else
				v6.kubrowPowerSuitCustomization = kubrow:__wf_atom_eb82ab1f(0, inventory:__wf_atom_71d5cc00())
			end
		end
	end

	v6.kubrow = kubrow
	v6.petTypes = {}

	if not __wf_atom_7e8ad928(v6.sentinelPowerSuitWRes) and (not p or v6.sentinelIsSentinel) then
		table.insert(v6.petTypes, v6.sentinelPowerSuitWRes)
		local __wf_atom_3dbd0893 = object:__wf_atom_3dbd0893(v6.sentinelPowerSuitWRes)

		for _, v7 in ipairs(__wf_atom_3dbd0893) do
			table.insert(v6.petTypes, WeakResource(v7))
		end

		if v6.sentinelPowerSuitCustomization then
			for i = 0, 8 - 1 do
				local __wf_atom_035fdfa8 = v6.sentinelPowerSuitCustomization:__wf_atom_035fdfa8(i)

				if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
					table.insert(v6.petTypes, __wf_atom_035fdfa8)
				end
			end
		end

		table.insert(v6.petTypes, gGameRules:__wf_atom_76c92d6e(0))
		table.insert(v6.petTypes, gGameRules:__wf_atom_7401093e(0))
	end

	if not __wf_atom_7e8ad928(v6.moaPetWeaponWRes) and (not p or v6.sentinelIsMoa) then
		table.insert(v6.petTypes, v6.moaPetWeaponWRes)
		local __wf_atom_3dbd0893 = gGameData:__wf_atom_3dbd0893(v6.moaPetWeaponWRes)

		for _, v7 in ipairs(__wf_atom_3dbd0893) do
			table.insert(v6.petTypes, WeakResource(v7))
		end

		if v6.moaPetSuitCustomization then
			for i = 0, 8 - 1 do
				local __wf_atom_035fdfa8 = v6.moaPetSuitCustomization:__wf_atom_035fdfa8(i)

				if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
					table.insert(v6.petTypes, __wf_atom_035fdfa8)
				end
			end
		end

		for i = 1, #v6.moaPetParts do
			table.insert(v6.petTypes, v6.moaPetParts[i])
		end

		table.insert(v6.petTypes, gGameRules:__wf_atom_76c92d6e(3))
		table.insert(v6.petTypes, gGameRules:__wf_atom_7401093e(3))
	end

	if __wf_atom_7e8ad928(v6.kubrowPowerSuitWRes) or p and not v6.sentinelIsKubrow then
		return v6
	end

	table.insert(v6.petTypes, v6.kubrowPowerSuitWRes)

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_3dbd0893 = gGameData:__wf_atom_3dbd0893(v6.kubrowPowerSuitWRes)

		for _, v7 in ipairs(__wf_atom_3dbd0893) do
			table.insert(v6.petTypes, WeakResource(v7))
		end
	end

	if v6.kubrowPowerSuitCustomization then
		for i = 0, 8 - 1 do
			local __wf_atom_035fdfa8 = v6.kubrowPowerSuitCustomization:__wf_atom_035fdfa8(i)

			if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
				table.insert(v6.petTypes, __wf_atom_035fdfa8)
			end
		end
	end

	if v6.kubrowPowerSuitWRes:IsA(v4) then
		table.insert(v6.petTypes, v5)
		table.insert(v6.petTypes, gGameRules:__wf_atom_76c92d6e(2))
		table.insert(v6.petTypes, gGameRules:__wf_atom_7401093e(2))
		return v6
	else
		table.insert(v6.petTypes, gGameRules:__wf_atom_76c92d6e(1))
		table.insert(v6.petTypes, gGameRules:__wf_atom_7401093e(1))
	end

	return v6
end

function GetArchonCrystalInfo(p, p2, object, object2, p3)
	local mCrystalType, mColor, mUpgradeType

	if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2.mUpgradeType)) then
		mColor = p2.mColor
		mUpgradeType = p2.mUpgradeType
		mCrystalType = object:__wf_atom_83407ec4(mColor).mCrystalType
	end

	local v6

	if __wf_atom_7e8ad928(mCrystalType) then
		return {}
	else
		local __wf_atom_232fd31d = object2:__wf_atom_232fd31d(mCrystalType)
		v6 = module5.GetStoreItemInfo(p, __wf_atom_232fd31d, nil, nil, nil, true)
		v6.CrystalColor = mColor
		local upgradeInfo = SF.UpgradeInfo()
		upgradeInfo.mItemType = mUpgradeType
		upgradeInfo.mUpgradeFingerprint = upgradeInfo.mInstance:__wf_atom_254ac1f5(upgradeInfo.mInstance:__wf_atom_49f7d220(""))
		v6.Card = module3.CardFromArtifact(upgradeInfo, p3)
	end

	return v6
end

local function fn5(p) -- 1 equivalent call inferred from this helper
	return p == 1 or p == 5 or p == 3
end

function IsCrystalMythic(p)
	return fn5(p) -- inferred equivalent call
end

function DrawCrystal(object, p, p2, p3, p4)
	object:__wf_atom_933bbce0(
		p,
		p2,
		module.Ternary(p4, _G.UIMaterial_ArchonShardsStore, _G.UIMaterial_ArchonShards)[p3 + 1]
	)
end

function GetCrystalUpgradeDesc(object, data, p, p2, p3, p4)
	local floatingContentHighlightHex = data.FloatingContentHighlightHex
	local contentHex = data.ContentHex
	local v6 = p3 == nil and "" or p3
	local mDesc

	if p2 then
		mDesc = p.mDesc
	else
		local v7 = "<p><font color=\"" .. floatingContentHighlightHex .. "\">" .. v6 .. p.mDesc

		if p4 ~= nil then
			local v8 = p4.Upgrade.statValue - p4.CompareUpgrade.statValue
			v7 = (v7 .. "<font color=\"" .. data.FloatingContentHex .. "\"> <br>(" .. p4.CompareUpgrade.statValue .. module.Ternary(p4.CompareUpgrade.displayAsPercent, "%", "")) .. " + </font>" .. object:__wf_atom_8e9ac384("<MYTHIC>", true) .. v8 .. module.Ternary(p4.Upgrade.displayAsPercent, "%", "") .. "<font color=\"" .. data.FloatingContentHex .. "\">)</font>"
		end

		mDesc = v7 .. "</font></p>"
	end

	local v7 = string.gsub(mDesc, "%|OPEN_COLOR%|", "<font color=\"" .. contentHex .. "\">")
	return (string.gsub(v7, "%|CLOSE_COLOR%|", "</font>"))
end

function InitializeTopButton(object, p, p2, p3)
	object:__wf_atom_2dedec1a(p, 13, false)
	object:__wf_atom_4c1c1986(p, "Icon", 11, p3.FloatingContent)
	object:__wf_atom_4c1c1986(p, "Backer", 12, 80)
	object:__wf_atom_4c1c1986(p, "Backer", 14, 55)
	object:__wf_atom_4c1c1986(p, "Backer", 15, 55)
	object:__wf_atom_4c1c1986(p, "Backer", 11, p3.Background1)
	object:__wf_atom_4c1c1986(p, "Backer", 100, p2)
	object:SetCallbacks(p .. ".Backer", "TopBtnFocused", "TopBtnUnfocused", "TopBtnPressed", nil)
	__wf_atom_86cbd68d(object, p .. ".Icon.gotoAndStop", p2)
end

local function fn6(object, p, p2, p3, p4, p5)
	if p3 == nil then
		return
	end

	local v6 = p .. tostring(p3)
	local arcane = p2.Arcanes[p3]
	local v7 = nil

	if __wf_atom_7e8ad928(arcane.Upgrade.mItemType) then
		v7 = module.Ternary(p5, p4.HoverIcons[1], nil)
	elseif p5 then
		local v8 = arcane.Upgrade.mInstance:__wf_atom_a8dac107() + 2
		v7 = p4.HoverIcons[v8]

		if not __wf_atom_7e8ad928(arcane.StoreItemInfo) then
			module2.SetItemInfoPopupRect(
				object,
				arcane.StoreItemInfo,
				object:__wf_atom_5e6e15c8(v6, 2),
				object:__wf_atom_5e6e15c8(v6, 3),
				100,
				100
			)
			_T.InfoPopup_Data = arcane.StoreItemInfo
		end
	end

	if not p5 then
		_T.InfoPopup_Data = nil
	end

	object:__wf_atom_7f57ab2f(v6, "Bg", 13, not __wf_atom_7e8ad928(v7))
	object:__wf_atom_c90af43a(v6 .. ".Bg", v7)
end

function ArcaneSlotFocusChanged(p, p2, p3, p4, p5, p6)
	fn6(p, p2, p3, p4, p5, p6)
end

local function fn7(object, p, data, i, p2, p3, p4)
	if i == nil then
		return
	end

	local v6 = p .. tostring(i)
	local arcane = data.Arcanes[i]
	local v7 = __wf_atom_7e8ad928(arcane.Upgrade.mItemType)
	local uiColor_White = _G.UIColor_White

	if data.TextColor ~= nil then
		uiColor_White = data.TextColor
	end

	local ternary = module.Ternary(v7, 50, 100)
	object:__wf_atom_7f57ab2f(v6, "Image", 13, not v7 or p3.SlotBg ~= nil)
	local v8

	if v7 then
		object:__wf_atom_933bbce0(v6 .. ".Image", p3.SlotBg, nil)
		v8 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArcaneManager_EmptySlot", false)

		if data.TitleCase then
			v8 = TitleCase(v8)
		end
	else
		local storeItem = arcane.StoreItem

		if __wf_atom_7e8ad928(storeItem) then
			local mInstance = arcane.Upgrade.mInstance
			local mUpgradeFingerprint = arcane.Upgrade.mUpgradeFingerprint
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(mInstance:__wf_atom_014a76a2():c_str(), false)
			local arcaneRank, v9 = module3.GetArcaneRank(arcane.Upgrade)
			v8 = module2.GetArcaneRankString(__wf_atom_8e9ac384, arcaneRank, v9, object, {})
			local __wf_atom_70b880cb = mInstance:__wf_atom_70b880cb(mUpgradeFingerprint)
			local v10 = mInstance:__wf_atom_a8dac107() + 1
			arcane.StoreItemInfo = {}
			arcane.StoreItemInfo.Icon = __wf_atom_70b880cb.icon
			arcane.StoreItemInfo.Count = arcane.Upgrade.mItemCount
			arcane.StoreItemInfo.Material = _G.UIMaterial_CosmeticEnhancers[v10]
			module5.DrawItem(object, v6, arcane.StoreItemInfo)
		else
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(storeItem:__wf_atom_014a76a2():c_str(), false)
			local arcaneRank, v9 = module3.GetArcaneRank(arcane.Upgrade)
			v8 = module2.GetArcaneRankString(__wf_atom_8e9ac384, arcaneRank, v9, object, {})
			arcane.StoreItemInfo = module5.GetStoreItemInfo(object, storeItem, {
				ItemInfo = arcane.Upgrade
			})
			module5.DrawItem(object, v6, arcane.StoreItemInfo)
		end
	end

	object:__wf_atom_c90af43a(v6 .. ".Unowned", p3.Unowned)
	object:__wf_atom_4c1c1986(v6, "Unowned", 11, p2.Negative)
	object:__wf_atom_7f57ab2f(v6, "Unowned", 13, not (v7 or arcane.Owned))
	object:__wf_atom_7f57ab2f(v6, "Lock", 13, false)
	object:__wf_atom_48bd5a59(v6, "Label", 36, v8)
	object:__wf_atom_4c1c1986(v6, "Label", 44, uiColor_White)
	object:__wf_atom_4c1c1986(v6, "Label", 12, ternary)
	fn6(object, p, data, i, p3, p4)
end

function InitializeArcaneSlots(object, p, data, p2, p3, p4, p5, object2, p6)
	for i = 1, 2 do
		local v6 = p .. tostring(i)
		local v7 = i <= data.Slots
		object:__wf_atom_2dedec1a(v6, 13, v7)

		if not v7 then
			continue
		end

		object:__wf_atom_4c1c1986(v6, "Btn", 100, i)
		object:SetCallbacks(v6 .. ".Btn", "OnArcaneSlotFocused", "OnArcaneSlotUnfocused", nil, nil)
		local upgradeInfo = SF.UpgradeInfo()
		local forceOwned, mStoreItem

		if __wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2[p5 + i]) then
			forceOwned = false
		else
			local v8 = p2[p5 + i]
			mStoreItem = v8.mStoreItem

			if
				__wf_atom_7e8ad928(mStoreItem)
				and not (__wf_atom_7e8ad928(v8.mItemType) or __wf_atom_7e8ad928(object2))
			then
				mStoreItem = object2:__wf_atom_232fd31d(v8.mItemType)
			end

			upgradeInfo.mItemType = v8.mItemType

			if __wf_atom_7e8ad928(v8.mFingerprint) then
				if not __wf_atom_7e8ad928(v8.mUpgradeFingerprint) then
					upgradeInfo.mUpgradeFingerprint = v8.mUpgradeFingerprint
				end
			else
				upgradeInfo.mUpgradeFingerprint = v8.mFingerprint
			end

			forceOwned = data.ForceOwned

			if data.ForceOwned == nil then
				if p6 == nil then
					if v8.mOwnedUpgrades == nil then
						forceOwned = false
					else
						forceOwned = #v8.mOwnedUpgrades > 0
					end
				else
					forceOwned = module4.GetNumOwned(gGameData, nil, mStoreItem, p6) > 0
				end
			end
		end

		data.Arcanes[i] = { Owned = forceOwned, StoreItem = mStoreItem, Upgrade = upgradeInfo }
	end

	for i = 1, data.Slots do
		fn7(object, p, data, i, p3, p4, false)
	end
end

function GetArcaneSlots(p, p2, object, p3)
	local count = 0

	if p ~= 0 and p ~= 2 then
		return count
	end

	if p == 0 and (p2 == 0 or fn2(p2, { type = p3, item = "" })) then
		return 2
	end

	if __wf_atom_7e8ad928(object) then
		return count
	end

	if not __wf_atom_7e8ad928(object:__wf_atom_78c83ec3()) then
		count += 1
	end

	if object:__wf_atom_f3505c97() then
		count += 1
	end

	return count
end

function CategoryToLoadOutSlot(p, p2)
	return (p == nil and {
		[0] = 1,
		[1] = 2,
		[3] = 0,
		[5] = 3,
		[51] = 1,
		[52] = 3
	} or p)[p2]
end

function CategoryToInventorySlot(p, p2)
	return (p == nil and { [0] = 0, [1] = 1, [3] = 3, [5] = 5 } or p)[p2]
end

function GetLoadOutSlotFromCategory(p)
	if p == 1 then
		return 2
	elseif p == 0 then
		return 1
	elseif p == 5 then
		return 3
	end

	return nil
end