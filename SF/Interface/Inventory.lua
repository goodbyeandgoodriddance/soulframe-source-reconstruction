local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.StoreItemUtilities")
local module5 = require("EE.Interface.AnchorMgr")
local module6 = require("SF.Interface.Libs.StatsUtil")
local module7 = require("SF.Interface.Libs.MoteUtil")
local v = {
	Title = "/SF/Language/Inventory/Title",
	BackgroundAlpha = 0,
	ShouldShowInfoTip = function()
		return false
	end,
	InfoTipHeading = "/SF/Language/Inventory/Tip_Nightfold_Title",
	InfoTipSubtext = "/SF/Language/Inventory/Tip_Nightfold_Desc",
	Categories = module3.INVENTORY_CATEGORIES,
	ShowAllItemsCategory = true,
	ShowCurrency = true,
	ShowPauseMenu = true,
	FadeUnselectableElements = true,
	ShowUnowned = false
}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local inventoryUiOptions = nil
local flag = false
local v6 = nil
local asyncLoader = module2.CreateAsyncLoader()
local v7 = nil
local v8 = {}
local v9 = nil
local flag2 = false
local v10 = {}
local v11 = nil
local v12 = nil
local v13 = false
local flag3 = false
local v14 = nil
local fn
local v15 = nil
local v16 = {
	TEXT_DISABLED = _G.UIColor_Brown,
	TEXT_FOCUSED = _G.UIColor_Yellow,
	TEXT_UNFOCUSED = _G.UIColor_Tan,
	ICON_BG = _G.UIColor_Beige,
	BG = _G.UIColor_DarkBrown
}
local v17 = { 1100, 700, 1100 }
local v18 = { 1200, 700, 1200 }
local v19 = { 1200, 780, 1200 }
local flag4 = false
local v20 = { [9] = 9450805, [11] = 4482163, [10] = 6124631 }
local stats = ({ STATS = 1, DESCRIPTION = 2 }).STATS
local v21 = false
local v22 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v23 = WeakResource("/SF/Types/Items/Aspects/BaseAspectManifest")
local v24 = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
local v25 = {}
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = nil
local v30 = false
local v31 = nil
local v32 = true
local v33 = true
local v34 = true
local v35 = 0

local function fn2(p)
	local activeCategoryId = v7:GetActiveCategoryId()

	if activeCategoryId == nil then
		return true
	end

	local category = inventoryUiOptions.Categories[activeCategoryId]

	if category == nil then
		return true
	end

	local v36 = category.Filters == nil or category.FilterFunction == nil
	local flag5 = false

	for i, filter in ipairs(category.Filters) do
		if v25[i] == nil then
			v25[i] = { Active = false }
		end

		if not v25[i].Active then
			continue
		end

		local filterFunction = category.FilterFunction(p, filter)
		v36 = v36 or filterFunction
		flag5 = true
	end

	return not flag5 or v36
end

local function fn3(_)
	if v11 == nil or _T.GetButtonBarStart == nil then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	v11:SetExpanded(false, false)

	if v7 == nil then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	v11:RemoveElements(true, true)
	local activeCategoryId = v7:GetActiveCategoryId()

	if activeCategoryId == nil then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	local category = inventoryUiOptions.Categories[activeCategoryId]

	if category == nil then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	if category.Filters == nil or category.FilterFunction == nil then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	for i, filter in ipairs(category.Filters) do
		local label = filter.Label

		if v25[i] == nil then
			v25[i] = { Active = false }
		end

		local textIcon = v25[i].Active and "<FULL_CHECK>" or "<EMPTY_CHECK>"
		v11:AddElement({ Name = label, Id = i, TextIcon = textIcon })
	end

	if #v11.mElements == 0 then
		mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, false)
		return
	end

	v11:Redraw(nil, true, true)
	mMovie:__wf_atom_2dedec1a("FilterDropdown", 13, true)
	local buttonBarStart = _T.GetButtonBarStart()
	local screenDimensions, v36 = module.GetScreenDimensions(mMovie)
	local v37 = mMovie:__wf_atom_54eeda24() * 0.05

	if _T.GetButtonBarOffset ~= nil then
		v37 = _T.GetButtonBarOffset()
	end

	local v38 = buttonBarStart - mMovie:__wf_atom_5e6e15c8("FilterDropdown.MainButton.Btn", 14) - 24
	local v39 = v36 - v37 + 10
	mMovie:__wf_atom_e57658c2("FilterDropdown", 0, screenDimensions - mMovie:__wf_atom_97cd8326() + v38)
	mMovie:__wf_atom_e57658c2("FilterDropdown", 1, v39)
end

local function fn4()
	local activeCategoryId = v7:GetActiveCategoryId()

	if activeCategoryId == nil then
		return
	end

	v3 = v4:__wf_atom_259e7653(true)
	local category = inventoryUiOptions.Categories[activeCategoryId]

	if category.ItemType == 5 or category.ItemType == 3 or category.ItemType == 6 then
		local __wf_atom_59af3769 = v3:__wf_atom_59af3769(0)
		local __wf_atom_9ed9a33c = v3:__wf_atom_9ed9a33c(0)
		v7:SetCount(__wf_atom_59af3769 - __wf_atom_9ed9a33c, __wf_atom_59af3769)
	else
		if
			category.ItemType ~= 4
			or category.SubType ~= WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
			and category.SubType ~= WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
		then
			v7:SetCount()
			return
		end

		local __wf_atom_59af3769 = v3:__wf_atom_59af3769(4)
		v7:SetCount(v35, __wf_atom_59af3769)
	end
end

local function fn5(p)
	if p ~= nil and p == v26 then
		return
	end

	v26 = p
	fn4()
	fn3(v26)
	UpdateButtons()
end

local function fn6(p, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end

	local screenDimensions, v36 = module.GetScreenDimensions(mMovie)

	if v7 ~= nil then
		local v37 = math.min(screenDimensions, screenDimensions - mMovie:__wf_atom_97cd8326() + v7.mDefaultWidth)
		v7:UpdateWidth(v37, true)
	end

	local _ = mMovie:__wf_atom_54eeda24() * 0.05

	if _T.GetButtonBarOffset ~= nil then
		_T.GetButtonBarOffset()
	end

	local v37 = { (Resource("/SF/Interface/Materials/ItemQualityBorderMaterial")) }
	module.ScaleSlicedMaterials(mMovie, v37)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgFill", 6, 100)
	local v38 = v36 - (mMovie:__wf_atom_54eeda24() - mMovie:__wf_atom_5e6e15c8("TopLeft.Backer.BgFill", 15))
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgFill", 15, v38)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgEnd", 1, v38 + mMovie:__wf_atom_5e6e15c8("TopLeft.Backer.BgFill", 1))
	fn3()
end

function ItemsListItemFocused(p)
	if not (__wf_atom_7e8ad928(nil) or __wf_atom_7e8ad928(mMovie)) then
		(nil):FocusElementById(p)
	end
end

function ItemsListItemUnfocused(p)
	if not (__wf_atom_7e8ad928(nil) or __wf_atom_7e8ad928(mMovie)) then
		(nil):UnfocusElementById(p)
	end
end

function ItemsListItemSelected(p)
	if not (__wf_atom_7e8ad928(nil) or __wf_atom_7e8ad928(mMovie)) then
		(nil):SelectElementById(p)
	end
end

local function fn7(mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(v5) then
		return nil
	end

	return v5:__wf_atom_232fd31d(mItemType)
end

local function fn8(mItemType, subType, excludeList)
	if subType == nil then
		return true
	end

	if not mItemType:IsA(subType) then
		return false
	end

	if excludeList then
		for _, className in excludeList do
			if className and mItemType:IsA(className) then
				return false
			end
		end
	end

	return not mItemType:IsA(WeakResource("/SF/Souls/Common/SFIdolMod"))
end

local function fn9(p)
	local __wf_atom_92ba339b = v5:__wf_atom_92ba339b(__wf_atom_abf506db)

	for _, v36 in ipairs(__wf_atom_92ba339b) do
		local item = v36:GetItem()

		if not __wf_atom_7e8ad928(item) then
			p[item:__wf_atom_5b41f63b()] = true
		end
	end
end

local function fn10(data, p)
	local upgrades = {}
	local v36 = {}
	local itemType = data.ItemType

	if itemType == 3 then
		upgrades = v3:__wf_atom_ebdc4e6e() or {}
	elseif itemType == 5 then
		upgrades = v3:__wf_atom_4259c789() or {}
		local v37 = v4:__wf_atom_1ffddac9() or {}
		table.move(v37, 1, #v37, #upgrades + 1, upgrades)
		local v38 = v3:__wf_atom_4f67b86c() or {}
		table.move(v38, 1, #v38, #upgrades + 1, upgrades)
	elseif itemType == 6 then
		upgrades = v3:__wf_atom_71d5cc00() or {}
		fn9(v36)
	elseif itemType == 4 then
		upgrades = v3:GetUpgrades() or {}
		local v37 = v3:__wf_atom_063f1444() or {}
		table.move(v37, 1, #v37, #upgrades + 1, upgrades)
	elseif itemType == 2 then
		upgrades = v3:__wf_atom_6b29f1ed() or {}

		for i = 1, v4:__wf_atom_62abd325(0) do
			local __wf_atom_ba1c3957 = v4:__wf_atom_ba1c3957(i - 1, 0)
			local v37 = false

			for j = 1, #upgrades do
				if upgrades[j].mItemType ~= __wf_atom_ba1c3957 then
					continue
				end

				upgrades[j].mItemCount = v4:__wf_atom_b62f2024(i - 1, 0)
				v37 = true
				break
			end

			if not v37 then
				table.insert(upgrades, {
					mItemType = __wf_atom_ba1c3957,
					mItemCount = v4:__wf_atom_b62f2024(i - 1, 0)
				})
			end
		end
	elseif itemType == 13 then
		upgrades = v3:__wf_atom_49479502() or {}
	elseif itemType == 11 then
		upgrades = v3:__wf_atom_c84817dd() or {}
		local v37 = v3:__wf_atom_da43e3f3() or {}

		for _, v38 in ipairs(v37) do
			if __wf_atom_7e8ad928(v38) or not v38.mItemType:IsA(WeakResource("/SF/Types/Items/ColorPickerItem")) then
				continue
			end

			table.insert(upgrades, v38)
		end
	end

	local v37 = {}

	if inventoryUiOptions.ShowUnowned then
		local __wf_atom_caa82b8d = v5:__wf_atom_caa82b8d(inventoryUiOptions.Categories[1].SubType)
		local v38 = {}

		for _, upgrade in ipairs(upgrades) do
			v38[upgrade.mItemType:__wf_atom_5b41f63b()] = true
		end

		for _, v39 in ipairs(__wf_atom_caa82b8d) do
			if not v38[v39:GetItem():__wf_atom_5b41f63b()] then
				table.insert(upgrades, {
					mItemType = v39:GetItem(),
					mUnowned = true,
					mItemCount = 0
				})
			end
		end
	end

	local storeItemInfos = {}

	for _, upgrade in ipairs(upgrades) do
		if not (fn8(upgrade.mItemType, data.SubType, data.ExcludeList) and (inventoryUiOptions.FunctionFilter == nil or inventoryUiOptions.FunctionFilter(upgrade))) then
			continue
		end

		if not (__wf_atom_7e8ad928(v36) or __wf_atom_7e8ad928(upgrade.mItemType) or not v36[upgrade.mItemType:__wf_atom_5b41f63b()]) then
			continue
		end

		local mItemCount = upgrade.mItemCount or 1

		if not (not (mItemCount <= 0) or inventoryUiOptions.ShowUnowned) then
			continue
		end

		local v38 = fn7(upgrade.mItemType)

		if
			__wf_atom_7e8ad928(v38)
			or not (not __wf_atom_7e8ad928(inventoryUiOptions.OverrideShowInInventory) and inventoryUiOptions.OverrideShowInInventory or v38:__wf_atom_1f093091())
		then
			continue
		end

		local mPredictionSeed

		if upgrade.mSeed then
			mPredictionSeed = upgrade.mSeed:Copy()
			local weaponInfo = SF.WeaponInfo()
			weaponInfo.mItemType = upgrade.mItemType
			weaponInfo.mQuality = upgrade.mQuality
			weaponInfo.mAspectType = upgrade.mAspectType
			weaponInfo.mAspectFingerprint = upgrade.mAspectFingerprint
			upgrade = weaponInfo
		end

		local storeItemInfo = module4.GetStoreItemInfo(mMovie, v38, { ItemInfo = upgrade }, nil, nil, true)
		storeItemInfo.mItem = upgrade
		storeItemInfo.Count = math.min(mItemCount, 999999)
		storeItemInfo.mQuality = upgrade.mQuality
		storeItemInfo.mAspectType = upgrade.mAspectType
		storeItemInfo.mAspectFingerprint = upgrade.mAspectFingerprint
		storeItemInfo.mPredictionSeed = mPredictionSeed

		if upgrade.mUnowned then
			storeItemInfo.Count = 0
			storeItemInfo.OwnsItem = false
		else
			storeItemInfo.OwnsItem = true
		end

		if not (__wf_atom_7e8ad928(storeItemInfo.UID) or storeItemInfo.UID == "000000000000000000000000" or not p[storeItemInfo.UID]) then
			continue
		end

		local v40 = { ShowCount = true }

		if inventoryUiOptions.HideCount then
			v40.ShowCount = false
		end

		v40.FadeUnselectableElements = inventoryUiOptions.FadeUnselectableElements

		if storeItemInfo.Xp ~= nil then
			v40.Level = __wf_atom_c67f9605:__wf_atom_b4a75eaa(storeItemInfo.Xp, storeItemInfo.Type)
			v40.Xp = storeItemInfo.Xp
		end

		if not __wf_atom_7e8ad928(storeItemInfo.mItem) then
			v40.MoteItemId = storeItemInfo.mItem.mItemId
			v40.Favorite = storeItemInfo.mItem.mFavorite
		end

		local __wf_atom_c132f79b = v3:__wf_atom_c132f79b(0, v3:__wf_atom_d25917b6(0))

		for i = 0, 6 - 1 do
			local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(i)

			if storeItemInfo.RawItem.mItemId == nil then
				break
			end

			if storeItemInfo.RawItem.mItemId ~= __wf_atom_b369d77f.mItemId then
				continue
			end

			v40.Equipped = true
			break
		end

		if not __wf_atom_7e8ad928(storeItemInfo.Type) then
			if storeItemInfo.Type:IsA(__wf_atom_9df43583) then
				v40.ShowCount = false
			end

			if storeItemInfo.Type:IsA(__wf_atom_abf506db) then
				v40.ShowCount = false
				local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
				local __wf_atom_eb82ab1f = v3:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)

				for i = 0, 8 - 1 do
					local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(i)

					if __wf_atom_7e8ad928(__wf_atom_035fdfa8) or __wf_atom_035fdfa8 ~= storeItemInfo.Type then
						continue
					end

					v40.Equipped = true
					break
				end
			end

			if storeItemInfo.Type:IsA(v23) then
				local __wf_atom_2ed09791 = Resource(storeItemInfo.mItem.mItemType):__wf_atom_2ed09791(storeItemInfo.Fingerprint)

				if #__wf_atom_2ed09791 > 0 then
					for _, v41 in __wf_atom_2ed09791 do
						storeItemInfo.Name = mMovie:__wf_atom_8e9ac384(v41.mTitle, true)
						storeItemInfo.Description = v41.mDesc
						storeItemInfo.LocalizedDesc = mMovie:__wf_atom_8e9ac384(v41.mDesc, true)
						storeItemInfo.Icon = Resource(v41.mIconName)
						break
					end
				end
			end

			if storeItemInfo.Type:IsA(v22) then
				local __wf_atom_c05c3cf5 = storeItemInfo.mItem.mInstance:__wf_atom_c05c3cf5(storeItemInfo.mItem.mUpgradeFingerprint)

				if __wf_atom_c05c3cf5 ~= 0 then
					local v41 = __wf_atom_c05c3cf5 == 10 and 2 or __wf_atom_c05c3cf5 == 11 and 3 or 1
					storeItemInfo.Polarity = __wf_atom_c05c3cf5
					storeItemInfo.VirtueIcon = {
						Icon = virtueIconsSmall[v41],
						Color = v20[__wf_atom_c05c3cf5]
					}
				end

				local v41 = Resource(storeItemInfo.mItem.mItemType)
				local mUpgradeFingerprint = storeItemInfo.mItem.mUpgradeFingerprint

				if not __wf_atom_7e8ad928(v41) then
					local v42 = Resource(v41:__wf_atom_7ec2d06a(mUpgradeFingerprint or ""))

					if not v42:IsA(__wf_atom_cdd2dd31) then
						print("Wrong item compatibility set on " .. v41:__wf_atom_5b41f63b())
					end

					local __wf_atom_ab9ebfce = v42:__wf_atom_ab9ebfce()
					local ternary = module.Ternary(__wf_atom_ab9ebfce ~= EMPTY_SYMBOL, __wf_atom_ab9ebfce:c_str(), "")

					if type(ternary) == "string" and ternary ~= nil and ternary ~= "" then
						storeItemInfo.GripIcon = ternary
					end

					storeItemInfo.Quality = v41:__wf_atom_c6a5f697(mUpgradeFingerprint)
				end
			end

			if module3.IsMoteType(storeItemInfo.Type) then
				table.insert(v37, v38:GetItem())
			else
				storeItemInfo.Rank = v38:__wf_atom_a8dac107()
			end
		end

		if inventoryUiOptions.IsSelectionBlocked ~= nil then
			local isSelectionBlocked, statusIconTooltip, v42 = inventoryUiOptions.IsSelectionBlocked(upgrade)
			v40.Unselectable = isSelectionBlocked
			v40.StatusIconTooltip = statusIconTooltip

			if not __wf_atom_7e8ad928(v42) then
				for k, v43 in pairs(v42) do
					v40[k] = v43
				end
			end
		end

		for k, v41 in pairs(v40) do
			storeItemInfo[k] = v41
		end

		if not __wf_atom_7e8ad928(storeItemInfo.UID) and storeItemInfo.UID ~= "000000000000000000000000" then
			p[storeItemInfo.UID] = true
		end

		if storeItemInfo.Level == nil then
			storeItemInfo.Level = 0
		end

		if storeItemInfo.Quality == nil then
			if storeItemInfo.RawItem == nil or not storeItemInfo.RawItem.mQuality then
				storeItemInfo.Quality = 0
			else
				storeItemInfo.Quality = storeItemInfo.RawItem.mQuality
			end
		end

		table.insert(storeItemInfos, storeItemInfo)
	end

	if itemType == 4 then
		local v38 = {}
		local v39 = {}
		v35 = #storeItemInfos

		for _, v40 in storeItemInfos do
			if v40.Type:IsA(v22) then
				local _ = v40.Polarity == nil
				local name = v40.Type:GetName()
				local v41 = v40.mItem.mUpgradeFingerprint .. name

				if v39[v41] == nil then
					v39[v41] = v40
					table.insert(v38, v40)
					v40.Count = 1
				else
					v39[v41].Count = v39[v41].Count + 1
				end
			else
				table.insert(v38, v40)
			end
		end

		storeItemInfos = v38
	end

	if fn == nil or not (#storeItemInfos > 0) then
		table.sort(storeItemInfos, function(a, b)
			return BasicCompare(a, b) > 0
		end)
	else
		fn(storeItemInfos)
	end

	for _, v38 in storeItemInfos do
		v7:AddElement(v38, true)
	end

	local v38 = "MotesList_" .. data.Name
	table.insert(v10, v38)
	asyncLoader:LoadMultipleResources(v38, v37, function(_)
		if flag2 then
			for _, mElement in ipairs(v7.mElements) do
				v7.mElementDrawCallback(mElement)
			end
		end
	end)
end

local function fn11()
	if __wf_atom_7e8ad928(v4) then
		v4 = module3.GetInventoryControl()

		if __wf_atom_7e8ad928(v4) or not v4:IsA(__wf_atom_4d316097) then
			v4 = nil
		else
			v3 = v4:__wf_atom_259e7653(true)
		end
	end
end

local function fn12()
	fn11()
	mMovie:__wf_atom_2dedec1a("InfoMessage", 13, false)

	if __wf_atom_7e8ad928(v4) then
		flag = true
		return
	end

	if inventoryUiOptions.xPos ~= nil then
		mMovie:__wf_atom_e57658c2("Panel", 0, inventoryUiOptions.xPos)
	end

	if inventoryUiOptions.yPos ~= nil then
		mMovie:__wf_atom_e57658c2("Panel", 1, inventoryUiOptions.yPos)
	end

	v7:RemoveElements(true, true)
	local categories = inventoryUiOptions.Categories
	local v36 = {}

	for i = 1, #categories do
		fn10(categories[i], v36)
	end

	v7:SetCategories(inventoryUiOptions.Categories)
	flag2 = true
	v7:Redraw(nil, true, true)

	if inventoryUiOptions.ShouldShowInfoTip == nil then
		mMovie:__wf_atom_2dedec1a("InfoMessage", 13, false)
	elseif type(inventoryUiOptions.ShouldShowInfoTip) == "boolean" then
		mMovie:__wf_atom_2dedec1a("InfoMessage", 13, inventoryUiOptions.ShouldShowInfoTip)
	else
		mMovie:__wf_atom_2dedec1a("InfoMessage", 13, inventoryUiOptions.ShouldShowInfoTip(nil) or false)
	end

	mMovie:__wf_atom_50d60589(
		"InfoMessage.Text1",
		36,
		mMovie:__wf_atom_8e9ac384(inventoryUiOptions.InfoTipHeading or "", true)
	)
	mMovie:__wf_atom_50d60589(
		"InfoMessage.Text2",
		36,
		mMovie:__wf_atom_8e9ac384(inventoryUiOptions.InfoTipSubtext or "", true)
	)
end

local function fn13(p, p2, p3)
	local v36 = 1
	local v37 = Resource(p2.RawItem.mItemType)
	asyncLoader:AbortLoad("LayeredIconFrame")

	if not __wf_atom_7e8ad928(p2) then
		local __wf_atom_0f53c1b9 = v37:__wf_atom_0f53c1b9()
		local __wf_atom_919e7078 = v37:__wf_atom_919e7078()
		local v38 = v37:__wf_atom_1c14f269() == 3

		if __wf_atom_7e8ad928(__wf_atom_0f53c1b9) then
			mMovie:__wf_atom_c90af43a(p, p2.Icon)
			mMovie:__wf_atom_e57658c2(p, 12, 100)
		else
			mMovie:__wf_atom_e57658c2(p, 12, 0)

			for i = 1, math.min(3, #__wf_atom_0f53c1b9) do
				if not mMovie:__wf_atom_253d7085(p .. i) then
					__wf_atom_86cbd68d(mMovie, p .. ".duplicateMovieClip", "Icon" .. i, i + 1)
				end

				local v39 = p3 or module.Ternary(v38, v17, v18)

				if v39[i] ~= nil then
					mMovie:__wf_atom_e57658c2(p .. i, 5, v39[i])
					mMovie:__wf_atom_e57658c2(p .. i, 6, v39[i])
				end

				local ternary = module.Ternary(v38, _G.UIMaterial_RuneMaterial, _G.UIMaterial_AnimalMoteMaterial)

				if i == 2 then
					mMovie:__wf_atom_c90af43a(p .. 2, __wf_atom_0f53c1b9[2])
					mMovie:OverrideMaterial(p .. 2, ternary)
					mMovie:__wf_atom_e57658c2(p .. 2, 12, 100)
					__wf_atom_ec43d06e(mMovie, p .. 2, 8, { 12 }, { 100 }, 0.5)
				elseif i == 3 then
					mMovie:__wf_atom_e57658c2(p .. 1, 12, 0)
					mMovie:__wf_atom_c90af43a(p .. 3, module7.GetMoteTexture(v37, p2.RawItem.mUpgradeFingerprint))
					mMovie:__wf_atom_e57658c2(p .. 3, 12, 100)
					__wf_atom_ec43d06e(mMovie, p .. 3, 8, { 12 }, { 100 }, 0.5)
				else
					mMovie:__wf_atom_e57658c2(p .. i, 12, 0)
					mMovie:__wf_atom_c90af43a(p .. i, __wf_atom_0f53c1b9[i])

					if __wf_atom_7e8ad928(__wf_atom_919e7078) or #__wf_atom_919e7078 < i then
						mMovie:OverrideMaterial(p .. i, nil)
					else
						mMovie:OverrideMaterial(p .. i, __wf_atom_919e7078[i])
					end
				end
			end

			v36 = #__wf_atom_0f53c1b9 + 1
		end
	end

	while mMovie:__wf_atom_253d7085(p .. v36) do
		mMovie:__wf_atom_290807ee(p .. v36)
		mMovie:__wf_atom_e57658c2(p .. v36, 12, 0)
		v36 += 1
	end
end

local function fn14(p)
	flag4 = true
	__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard.MoteName", 8, { 12 }, { 100 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard.MoteDescription", 8, { 12 }, { 0 }, 0.2)
	local instance = Resource(p.mItem.mItemType)
	local mUpgradeFingerprint = p.mItem.mUpgradeFingerprint
	local __wf_atom_c6a5f697 = instance:__wf_atom_c6a5f697(mUpgradeFingerprint)
	mMovie:__wf_atom_8e9ac384(module3.GetRankFlowerIcons(__wf_atom_c6a5f697), true)
	local mItem = p.mItem
	local __wf_atom_c05c3cf5 = instance:__wf_atom_c05c3cf5(mUpgradeFingerprint)
	local moteDescription = module7.GetMoteDescription({
		Type = p.Type,
		Instance = instance,
		Upgrade = mItem,
		Polarity = __wf_atom_c05c3cf5
	})
	v14:RemoveElements(true, true)

	if __wf_atom_c05c3cf5 == 0 then
		local v37 = {
			Text = moteDescription,
			Icon = _G.UITexture_MoteStatsIcons[4],
			IsHighlighted = true,
			PolarityMatch = false
		}
		v14:AddElement(v37, true)
	else
		local moteDescription2 = module7.GetMoteDescription({
			Type = p.Type,
			Instance = instance,
			Upgrade = mItem,
			Polarity = __wf_atom_c05c3cf5
		})
		local uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[1]

		if __wf_atom_c05c3cf5 == 10 then
			uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[2]
		elseif __wf_atom_c05c3cf5 == 11 then
			uiTexture_MoteStatsIcon = _G.UITexture_MoteStatsIcons[3]
		end

		v14:AddElement(
			{
				Text = moteDescription2,
				Icon = uiTexture_MoteStatsIcon,
				IsHighlighted = true,
				PolarityMatch = false
			},
			true
		)
	end

	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.MoteName", 13, true)
	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.Scrollbar", 13, false)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard", 5, 92)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard", 6, 92)
	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.MoteDescription", 13, true)
	mMovie:__wf_atom_50d60589(
		"TopLeft.MoteCard.MoteName",
		36,
		mMovie:__wf_atom_8e9ac384(instance:__wf_atom_014a76a2():c_str(), false)
	)
	mMovie:__wf_atom_50d60589("TopLeft.MoteCard.MoteDescription", 36, moteDescription)
	__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard", 8, { 12 }, { 90 }, 0.2)
	fn13("TopLeft.MoteCard.Icon", p, v19)
	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.Icon1", 13, true)
	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.Icon2", 13, true)
	mMovie:__wf_atom_2dedec1a("TopLeft.MoteCard.Icon3", 13, true)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TopLeft.MoteCard.MoteName", 40)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("TopLeft.MoteCard.MoteName", 41)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.NameBacker", 14, __wf_atom_5e6e15c8 + 64)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.NameBacker", 15, __wf_atom_5e6e15c8_2 + 16)

	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_1c14f269 = instance:__wf_atom_1c14f269()
		local v37 = Resource(instance:__wf_atom_7ec2d06a(mUpgradeFingerprint or ""))

		if not v37:IsA(__wf_atom_cdd2dd31) then
			print("Wrong item compatibility set on " .. instance:__wf_atom_5b41f63b())
			return
		end

		local __wf_atom_ab9ebfce = v37:__wf_atom_ab9ebfce()
		local ternary = module.Ternary(
			__wf_atom_ab9ebfce ~= EMPTY_SYMBOL,
			__wf_atom_ab9ebfce:c_str(),
			"<WEAPON_CATEGORY_ICON_UNIVERSAL>"
		)
		mMovie:__wf_atom_50d60589("TopLeft.MoteCard.GripIcon", 36, mMovie:__wf_atom_8e9ac384(ternary, true))
		local v38 = Localize(instance:__wf_atom_3a3d2e39():c_str(), false)
		mMovie:__wf_atom_50d60589("TopLeft.MoteCard.MoteFlavour", 36, v38)
		local __wf_atom_c05c3cf5_2 = instance:__wf_atom_c05c3cf5(mUpgradeFingerprint)
		module7.UpdateMoteInstructions(
			mMovie,
			"TopLeft.MoteCard.MoteInstructions",
			__wf_atom_1c14f269,
			__wf_atom_c05c3cf5_2,
			-1
		)
		mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.Icon1", 12, 0)
		mMovie:__wf_atom_c90af43a(
			"TopLeft.MoteCard.Icon3",
			module7.GetMoteTexture(instance, p.mItem.mUpgradeFingerprint)
		)
		mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.Icon3", 12, 100)
		__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard.Icon3", 8, { 12 }, { 100 }, 0.5)

		if __wf_atom_1c14f269 == 3 then
			mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.Icon2", 11, 16777215)
			mMovie:__wf_atom_c90af43a("TopLeft.MoteCard.Card", _G.UITexture_MoteCardBgTextures[1])
		else
			mMovie:__wf_atom_c90af43a("TopLeft.MoteCard.Card", module7.GetTotemBg(__wf_atom_c05c3cf5_2))
			mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.Icon2", 11, module7.CalcTotemColor(__wf_atom_c05c3cf5_2))
		end

		v14.mInitialY = 16
	end

	mMovie:__wf_atom_e57658c2(
		"TopLeft.MoteCard.UpgradeCost.Backer",
		14,
		80 + mMovie:__wf_atom_5e6e15c8("TopLeft.MoteCard.UpgradeCost.Amount", 40)
	)
	__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard.StatsContainer", 8, { 12 }, { 0 }, 0.2)
	v14:Redraw(nil, true, true)
end

local function fn15()
	mMovie:__wf_atom_c90af43a("TopLeft.Backer.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("TopLeft.Backer.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("TopLeft.Backer.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgStart", 11, 1774608)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgFill", 11, 1774608)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgEnd", 11, 1774608)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgStart", 12, 70)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgFill", 12, 70)
	mMovie:__wf_atom_e57658c2("TopLeft.Backer.BgEnd", 12, 70)
	mMovie:__wf_atom_e57658c2("TopLeft.SelectedList.Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("TopLeft.SelectedList.Total", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_c90af43a("TopLeft.Details.IconBg", detailsIconGlowTexture)
	mMovie:__wf_atom_e57658c2("TopLeft.Details.IconBg", 12, 60)
	mMovie:__wf_atom_e57658c2("TopLeft.Details", 12, 0)
end

local function fn16(state)
	if state.Type:IsA(v22) or state.Type:IsA(v24) then
		fn14(state)
		mMovie:__wf_atom_2dedec1a("TopLeft.Details", 13, false)
	else
		mMovie:__wf_atom_2dedec1a("TopLeft.Details", 13, true)

		if flag4 then
			flag4 = false
			__wf_atom_ec43d06e(mMovie, "TopLeft.MoteCard", 8, { 12 }, { 0 }, 0.2)
		end
	end

	local v36 = { (module.Ternary(flag4 == true, 0, 100)) }
	__wf_atom_ec43d06e(mMovie, "TopLeft.Backer", 8, { 12 }, v36, 0.2)
end

local function fn17()
	if inventoryUiOptions.ShowCurrency == false then
		return
	end

	local v36 = { mMovie = mMovie }
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		v36.mLabel = __wf_atom_eab484a7:__wf_atom_6be84646()
	end

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		v36.mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
		local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
		local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
		v36.mRankProgress = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a) * 100
	end

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v36)
	end
end

local function fn18(count)
	if count < 0 then
		count += 1
	end
end

local function fn19(p, TEXT_FOCUSED_HEX)
	return "<font color=\"" .. TEXT_FOCUSED_HEX .. "\">" .. p .. "</font>"
end

local function fn20(p)
	return "<p><font >" .. p .. "</font></p>"
end

local function fn21(value)
	local v36 = value or 0.3
	__wf_atom_ec43d06e(mMovie, "TopLeft.Details", 8, { 12 }, { 0 }, 0.1, v36)
	__wf_atom_ec43d06e(mMovie, "TopLeft.SelectedList", 8, { 12 }, { 100 }, 0.1, v36)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TopLeft.SelectedList.Name", 1)
	mMovie:__wf_atom_e57658c2(
		"TopLeft.SelectedList.Description",
		1,
		__wf_atom_5e6e15c8 + mMovie:__wf_atom_5e6e15c8("TopLeft.SelectedList.Name", 41) + mMovie:__wf_atom_5e6e15c8("TopLeft.SelectedList.Name", 50) / 2
	)
	local v37 = ""
	local total = 0
	local total2 = 0

	for _, v38 in v8 do
		if #v37 > 0 then
			v37 ..= "\r"
		end

		v37 ..= fn19(v38.SelectedCount .. "x ", v16.TEXT_FOCUSED_HEX) .. v38.Name

		if v38.RankText ~= nil then
			v37 ..= v38.RankText
		end

		total += v38.StoreItem:__wf_atom_ee4fa4fd() * v38.SelectedCount
		total2 += v38.SellingPrice * v38.SelectedCount
	end

	mMovie:__wf_atom_50d60589("TopLeft.SelectedList.Description", 36, fn20(v37))
	mMovie:__wf_atom_50d60589(
		"TopLeft.SelectedList.Total",
		36,
		fn20(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_TotalDust", true, {
			DUST = fn19(total2, v16.TEXT_FOCUSED_HEX)
		}))
	)
	v9:SetText(fn20(mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CraftToDust", true, {
		DRACS = fn19(total, v16.TEXT_FOCUSED_HEX)
	})))
	fn6(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v9:SetActive(total > 0)
end

function ShowItemInfoPopup(_, state)
	if __wf_atom_7e8ad928(state) then
		return
	end

	if state.Type:IsA(v22) or state.Type:IsA(v24) then
		_T.InfoPopup_Data = nil
		return
	end

	local _ = {
		CustomEntry = true,
		Name = Localize(state.StoreItem:__wf_atom_014a76a2():c_str(), false),
		LocalizedDesc = Localize(state.StoreItem:__wf_atom_3a3d2e39():c_str(), false)
	}
	state.HideStats = not v13
	state.HideAbilities = false
	state.InventoryFixedPosition = true
	state.MetaData = not state.MetaData and {} or state.MetaData
	state.MetaData.HidePrice = true
	v15:SetItem(state, true)
	mMovie:__wf_atom_2dedec1a("TopLeft.Details.ItemInfoPanel", 13, true)
	v12 = state
end

function Initialize()
	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v31 = module8.CreateTimerMgr()

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	_T.InventoryOpen = true
	v2 = module5.Create(mMovie)
	v2:Register(mMovie, "TopLeft", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "TopRight", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	v2:Register(mMovie, "CloseBtn", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_CENTRE })
	v16.TEXT_FOCUSED_HEX = module.ConvertColorNumberToHex(v16.TEXT_FOCUSED)
	v16.TEXT_UNFOCUSED_HEX = module.ConvertColorNumberToHex(v16.TEXT_UNFOCUSED)
	v5 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	mMovie:__wf_atom_7df746cd(v16.BG)
	local module9 = require("SF.Interface.ItemInfoPopup")
	v15 = module9.Create(mMovie, "TopLeft.Details.ItemInfoPanel", {
		PopupMode = false,
		UseGlobalData = false,
		MaxScale = 119
	})
	mMovie:__wf_atom_2dedec1a("TopLeft.Details.ItemInfoPanel", 13, false)
	inventoryUiOptions = _T.InventoryUiOptions or {}

	for k, v36 in pairs(v) do
		if inventoryUiOptions[k] == nil then
			inventoryUiOptions[k] = v36
		end
	end

	local module10 = require("SF.Interface.Components.Button")
	v9 = module10.Create(mMovie, "TopLeft.SelectedList.CraftBtn", "Pulverize", "ConfirmSelectedItems")
	v9:SetVariant(module10.VARIANTS.SPECIAL_BUTTON)
	v9:SetAnchor(module.CENTER_ALIGNED)
	local module11 = require("EE.Interface.Components.ItemGrid")
	v7 = module11.Create(getfenv(1), "TopRight.GridContainer", {
		mCategoryChangedCallback = fn5,
		mVisRangeMaterials = { animalGridMaterial, runeGridMaterial }
	})
	v7.mFadeUnownedItems = true
	v7.ItemList_FilterElement = v7.FilterElement

	function v7.FilterElement(object, p)
		return object:ItemList_FilterElement(p) and fn2(p)
	end

	local numberRequired = inventoryUiOptions.NumberRequired or 1

	if inventoryUiOptions.Dust or numberRequired > 1 then
		mMovie:__wf_atom_50d60589("TopLeft.SelectedList.Name", 36, "Selected Fragments")
		mMovie:__wf_atom_50d60589("TopLeft.SelectedList.Description", 36, "")
		mMovie:__wf_atom_50d60589("TopLeft.SelectedList.Total", 36, "")
		v7.mMultiSelect = true
		v7:SetCount(0, inventoryUiOptions.NumberRequired)
		fn21(0)
	else
		mMovie:__wf_atom_e57658c2("TopLeft.SelectedList", 12, 0)
		v9:SetVisible(false)
	end

	function v7:mOnFocusedCallback()
		module.PlaySound(_G.UISound_Focus)
		v7.UpdateFocused(self, true)
		asyncLoader:AbortLoad("Tooltip")

		if __wf_atom_7e8ad928(self.Type) then
			v28 = nil
			return
		end

		mMovie:__wf_atom_2dedec1a("TopLeft.Details.Icon", 13, true)
		mMovie:__wf_atom_2dedec1a("TopLeft.Details.IconBg", 13, true)
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local isA = self.Type:IsA(__wf_atom_77e05d3b)
		local isA2 = self.Type:IsA(__wf_atom_abf506db)
		local isA3 = self.Type:IsA(WeakResource("/SF/Types/Items/Kintsugi/BaseKintsugiUpgrade"))
		module3.IsMoteType(self.Type)

		if v27 == nil and module2.CanSellItem(self) or module2.CanDismantleItem(self) then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
				true
			)
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SellItem", true)

			if IsDismantle(self) then
				__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/Dismantle", true)
			end

			self.BottomLeftCalloutOverride = __wf_atom_8e9ac384 .. " " .. __wf_atom_8e9ac384_2
			v28 = self
		else
			v28 = nil
		end

		if isA or isA2 then
			if v6 ~= nil then
				v6()
			end

			local weaponElementUpgradesAndFingerprints, v36 = module6.GetWeaponElementUpgradesAndFingerprints(self)
			asyncLoader:LoadResource("Tooltip", self.Type, function()
				local v37 = __wf_atom_7e8ad928(self.RawItem) and 0 or self.RawItem.mQuality
				local mCreator

				if not __wf_atom_7e8ad928(self.RawItem) then
					mCreator = self.RawItem.mCreator
				end

				local v38

				if not __wf_atom_7e8ad928(self.RawItem) then
					v38 = self.RawItem.mShiny
				end

				local proxyWeapon, v39 = module6.CreateProxyWeapon(
					__wf_atom_c4f78a8f,
					self.Type,
					self.Xp,
					weaponElementUpgradesAndFingerprints,
					v36,
					v37,
					self.RawItem.mItemId,
					v38,
					mCreator
				)
				v6 = v39
				self.StatWeapon = proxyWeapon
				self.StatOwner = __wf_atom_c4f78a8f
				ShowItemInfoPopup(mMovie, self)
				fn16(self)
			end)
		else
			asyncLoader:LoadResource("Tooltip", self.Type, function(p)
				Resource(p)
				self.StatOwner = __wf_atom_c4f78a8f
				ShowItemInfoPopup(mMovie, self)
				fn16(self)
			end)
		end

		if not v7.mMultiSelect then
			__wf_atom_ec43d06e(mMovie, "TopLeft.Details", 8, { 12 }, { 100 }, 0.2)
			__wf_atom_ec43d06e(mMovie, "TopLeft.SelectedList", 8, { 12 }, { 0 }, 0.2)
		end

		local name = self.Name

		if not __wf_atom_7e8ad928(self.StoreItem) then
			local statusIconTooltip = name .. ""

			if v7.mMultiSelect then
				self.StatusIconTooltip = statusIconTooltip
			end
		end

		if isA or isA2 or isA3 then
			v13 = true
		else
			v13 = false
			ShowItemInfoPopup(mMovie, self)
		end

		mMovie:__wf_atom_c90af43a("TopLeft.Details.Icon", self.Icon)
	end

	function v7.mOnUnfocusedCallback(p)
		module.PlaySound(_G.UISound_Unfocus)
		v7.UpdateFocused(p, false)

		if v7.mMultiSelect and v7.mCount > 0 then
			fn21()
		end
	end

	function v7:mOnSelectedCallback()
		if self.Unselectable or v7.mMultiSelect then
			return
		end

		local flag5

		if module2.MarkItemIsNew(self, false) then
			self.Refresh = true
			v7.ITEM_UTIL.Update(mMovie, self.mClipName, self, v7)
			flag5 = true
		else
			flag5 = false
		end

		if inventoryUiOptions.OnItemSelected ~= nil and inventoryUiOptions.OnItemSelected(self) then
			AdvanceAndShutdown()
			flag5 = true
		end

		if flag5 then
			module.PlaySound(_G.UISound_Select)
		end
	end

	function v7:mElementDrawCallback()
		if self.mClipName == nil then
			return
		end

		local isMoteType = module3.IsMoteType(self.Type)

		for _, v37 in ipairs(v10) do
			if not asyncLoader:IsLoadingTag(v37) then
				continue
			end

			isMoteType = false
			break
		end

		local v37 = self.mClipName .. ".GripTypeIcon"

		if isMoteType then
			local v38 = Resource(self.Type)

			if self.Type:IsA(v22) then
				mMovie:OverrideMaterial(self.mClipName .. ".Icon", animalGridMaterial)
				self.Tint = 14548981
			else
				mMovie:OverrideMaterial(self.mClipName .. ".Icon", runeGridMaterial)
				self.Tint = nil
			end

			self.ExtraOverlayPadding = 10
			self.IconWidthOverride = 80
			self.IconHeightOverride = 80
			self.IconOverlay = module7.GetMoteTexture(v38, self.RawItem.mUpgradeFingerprint)
		elseif self.Type and self.Type:IsA(v22) and self.mItem then
			local v38 = Resource(self.Type)
			local __wf_atom_c05c3cf5 = self.mItem.mInstance:__wf_atom_c05c3cf5(self.mItem.mUpgradeFingerprint)
			self.Tint = module7.CalcTotemColor(__wf_atom_c05c3cf5)
			mMovie:OverrideMaterial(self.mClipName .. ".Icon", animalGridMaterial)
			self.ExtraOverlayPadding = 10
			self.IconWidthOverride = 80
			self.IconHeightOverride = 80
			self.IconOverlay = module7.GetMoteTexture(v38, self.RawItem.mUpgradeFingerprint)
		else
			mMovie:__wf_atom_2dedec1a(v37, 13, false)
			mMovie:OverrideMaterial(self.mClipName .. ".Icon", v7.mVisRangeMaterials.Icon)
			self.Tint = nil
		end
	end

	v7.Grid_UpdateSelectedCount = v7.UpdateSelectedCount

	function v7.UpdateSelectedCount(_, p, p2)
		v7:Grid_UpdateSelectedCount(p, p2)
		local selectedCount = p.SelectedCount or 0

		if p.Name ~= nil then
			if selectedCount > 0 then
				v8[p.Name] = p
			elseif v8[p.Name] ~= nil then
				v8[p.Name] = nil
			end
		end

		fn21(0)
	end

	local module12 = require("SF.Interface.Components.DropDownMenu")
	local v36 = {
		mExpandUpwards = true,
		mKeepExpandedOnSelection = true,
		mFixedSelectionText = mMovie:__wf_atom_8e9ac384("/SF/Language/Inventory/FilterButton", true),
		mShowHighlight = false,
		mVariant = module12.VARIANTS.BUTTON
	}
	v11 = module12.Create(getfenv(1), "FilterDropdown", v36)
	v11.mSelectedIconOnly = false

	function v11.mOnSelectedCallback(p)
		local activeCategoryId = v7:GetActiveCategoryId()

		if activeCategoryId == nil then
			v7:RefreshCategory()
			return
		end

		local category = inventoryUiOptions.Categories[activeCategoryId]

		if category == nil then
			v7:RefreshCategory()
			return
		end

		if category.Filters == nil or category.FilterFunction == nil then
			v7:RefreshCategory()
			return
		end

		if v25[p.Id] == nil then
			v25[p.Id] = { Active = false }
		end

		local v37 = v25[p.Id]
		v37.Active = not v37.Active

		if p.mButton ~= nil then
			local label = category.Filters[p.Id].Label
			local v38 = v37.Active and "<FULL_CHECK>" or "<EMPTY_CHECK>"
			p.mButton:SetText(label)
			p.mButton:SetTextIcon(v38)
		end

		v7:RefreshCategory()
	end

	local module13 = require("EE.Interface.Components.List")
	v14 = module13.CreateList(mMovie, "TopLeft.MoteCard.StatsList.Element1")
	v14.mForcedVerticalSeparation = 96

	function v14.mElementDrawCallback(data)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Text", 36, data.Text)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", data.Icon)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Glow", statsHighlightGlowIcon)
		local v37 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Text", 41) - 23
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 1, 16 - v37 / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 15, 80 + v37)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 12, 50)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Glow", 13, true)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "IconGlow", 13, false)
		mMovie:__wf_atom_e57658c2(data.mClipName, 12, 100)
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	fn18(0)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard", 12, 0)
	mMovie:__wf_atom_c90af43a("TopLeft.MoteCard.Glow", hoverGlowTexture)
	mMovie:__wf_atom_c90af43a("TopLeft.MoteCard.IconBacker", iconBackerTexture)
	mMovie:__wf_atom_c90af43a("TopLeft.MoteCard.NameBacker", moteNameBacker)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.NameBacker", 11, _G.UIColor_Black)
	mMovie:__wf_atom_e57658c2("Details.NameBacker", 12, 70)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.MoteName", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("TopLeft.MoteCard.MoteDescription", 44, _G.UIColor_Beige)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12, fn18 }, { 100, 1 }, 0.5)
	module.PlaySound(inventoryOpenSound)
	fn15()
	fn12()
	v7:SetTitle(mMovie:__wf_atom_8e9ac384(inventoryUiOptions.Title or "", true))
	fn17()
	UpdateButtons()
	fn3()
	mMovie:__wf_atom_dac78d3d(true)
	fn6(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function onViewportSizeChanged(p, p2)
	fn6(p, p2)
end

function Update()
	local v36 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v36)

	if inventoryUiOptions.ShowPauseMenu and not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:ShowPauseMenu()
	end

	asyncLoader:Update()

	if flag then
		flag = false
		fn12()
	end
end

local function fn22()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.InventoryOpen = nil
	_T.InventoryUiOptions = nil

	if inventoryUiOptions ~= nil and inventoryUiOptions.OnClosed ~= nil then
		inventoryUiOptions.OnClosed()
		inventoryUiOptions.OnClosed = nil
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end
end

function Shutdown(p)
	if not p then
		fn22()
	end

	if v6 ~= nil then
		v6()
		v6 = nil
	end

	asyncLoader:ClearResources()
end

local function fn23()
	mMovie:Close()
end

function AdvanceAndShutdown()
	if flag3 then
		return
	end

	flag3 = true
	module.PlaySound(inventoryCloseSound)
	mMovie:__wf_atom_0c1c47f2(nil)
	fn22()

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	if not inventoryUiOptions.ShowPauseMenu then
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12, fn18 }, { 0, -1 }, 0.5, 0, fn23)
	end
end

function ConfirmSelectedItems()
	local numberRequired = inventoryUiOptions.NumberRequired

	if numberRequired == nil or v7.mCount == numberRequired then
		if inventoryUiOptions.OnItemSelected ~= nil and inventoryUiOptions.OnItemSelected(v8) then
			AdvanceAndShutdown()
		end
	else
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.titleString = Localize("/SF/Language/Inventory/SelectedCount", {
			COUNT = v7.mCount,
			REQ = numberRequired
		})

		if numberRequired < v7.mCount then
			dialogSettings.locString = Localize("/SF/Language/Inventory/TooManySelected", {
				NUM = v7.mCount - numberRequired
			})
		else
			dialogSettings.locString = Localize("/SF/Languagee/Inventory/TooFewSelcted", {
				NUM = numberRequired - v7.mCount
			})
		end

		module.ShowCustomMessage(dialogSettings)
	end
end

function BasicCompare(p, p2)
	if p.Favorite == p2.Favorite then
		if p.IsNew == p2.IsNew then
			return 0
		end

		if p.IsNew then
			return 1
		end

		return -1
	elseif p.Favorite then
		return 1
	else
		return -1
	end
end

function SortByAlphabetically()
	fn = function(list)
		table.sort(list, function(a, b)
			local v36 = BasicCompare(a, b)

			if v36 ~= 0 then
				return v36 > 0
			end

			if v32 then
				return a.Name > b.Name
			end

			return a.Name < b.Name
		end)
	end

	v32 = not v32
	fn12()
end

function SortByLevel()
	fn = function(list)
		table.sort(list, function(a, b)
			local v36 = BasicCompare(a, b)

			if v36 ~= 0 then
				return v36 > 0
			end

			if v33 then
				return a.Level > b.Level
			end

			return a.Level < b.Level
		end)
	end

	v33 = not v33
	fn12()
end

function SortByQuality()
	fn = function(list)
		table.sort(list, function(a, b)
			local v36 = BasicCompare(a, b)

			if v36 ~= 0 then
				return v36 > 0
			end

			if v34 then
				return a.Quality > b.Quality
			end

			return a.Quality < b.Quality
		end)
	end

	v34 = not v34
	fn12()
end

function CloseTopMenu()
	local topMenuMovie = _T.TopMenuMovie

	if _T.TopMenuOpen and not __wf_atom_7e8ad928(topMenuMovie) then
		topMenuMovie:Execute("SkipDisableInputOnClose", "true")
		topMenuMovie:Execute("Close", "")
	end

	AdvanceAndShutdown()
end

function UpdateButtons()
	local v36 = {}

	if inventoryUiOptions.ShowPauseMenu then
		if v26 ~= nil then
			table.insert(v36, {
				Label = "/SF/Language/Menu/SortByName",
				CallBack = SortByAlphabetically,
				CallOut = nil
			})

			if v26 == 3 then
				table.insert(v36, {
					Label = "/SF/Language/Menu/SortByQuality",
					CallBack = SortByQuality,
					CallOut = nil
				})
				table.insert(v36, {
					Label = "/SF/Language/Menu/SortByLevel",
					CallBack = SortByLevel,
					CallOut = nil
				})
			end

			table.insert(v36, {
				Label = "/Lotus/Language/Menu/Global_Back",
				CallBack = CloseTopMenu,
				CallOut = "MENU_CANCEL"
			})

			if not __wf_atom_7e8ad928(_T.SetButtons) then
				_T.SetButtons(mMovie, v36, getfenv(1), true)
			end
		end
	else
		if v7.mMultiSelect then
			table.insert(v36, {
				Label = mMovie:__wf_atom_8e9ac384("<WARNING>", true),
				Tips = module2.GetTips(mMovie, "/SF/Language/Hints/FragmentSelection_")
			})
		end

		table.insert(v36, {
			Label = "/Lotus/Language/Menu/Global_Back",
			CallBack = AdvanceAndShutdown,
			CallOut = "MENU_CANCEL"
		})

		if not __wf_atom_7e8ad928(_T.SetButtons) then
			_T.SetButtons(mMovie, v36, getfenv(1))
		end
	end
end

function onKeyDown_SHOW_INVENTORY()
	if not inventoryUiOptions.ShowPauseMenu then
		return true
	end

	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		AdvanceAndShutdown()
	else
		__wf_atom_2ad5cd23:Execute("Close", "")
	end

	return true
end

function onKeyDown_MENU_CANCEL(_, _)
	CloseTopMenu()
	return true
end

function onKeyDown_MENU_LTRIGGER2()
	if v7 == nil then
		return
	end

	local activeCategoryId = v7:GetActiveCategoryId()

	if activeCategoryId == nil then
		return
	end

	v7:SetActiveCategoryId(activeCategoryId - 1)
	module.PlaySound(_G.UISound_Select)
	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if v7 == nil then
		return
	end

	local activeCategoryId = v7:GetActiveCategoryId()

	if activeCategoryId == nil then
		return
	end

	v7:SetActiveCategoryId(activeCategoryId + 1)
	module.PlaySound(_G.UISound_Select)
	return true
end

function OpenedFromPauseMenu()
	fn6(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function PrepareToClose()
	AdvanceAndShutdown()
end

function onKeyDown_NEXT_MENU()
	return true
end

function onRawInputEvent(_, p, p2)
	local v36 = p2 == "1"

	if p ~= "EN_LSHIFT" and p ~= "EN_RSHIFT" then
		return
	end

	v21 = v36
end

function OnGamepadTransition(_)
	local focusedElement = v7 and v7:GetFocusedElement()

	if focusedElement then
		v7.mOnFocusedCallback(focusedElement)
	end
end

function ShowItemTicker(p)
	if p == v30 then
		return
	end

	v30 = p
	module3.RegisterHideHud(not p)
	local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/HUD/Hud.swf"))

	if movie then
		movie:__wf_atom_f0448d34(p)
	end
end

function OnItemChangedRedraw(_)
	fn4()
end

function OnItemSoldOrDismantled(p, p2)
	local v36 = IsDismantle(v27)

	if p then
		ShowItemTicker(true)
		v31:ClearTimers()
		v31:AddTimer(5, function()
			ShowItemTicker(false)
		end)

		if v27.mAspectFingerprint == nil or v27.mAspectFingerprint == "" then
			module.PlaySound(sellConfirmSound)
		else
			module.PlaySound(sellConfirmWithTemperSound)
		end

		local v37 = {}

		if v36 then
			local inventoryChanges = (__wf_atom_0a63ecce(p2) == "" and {} or cjson.decode(p2)).inventoryChanges

			if inventoryChanges ~= nil then
				local miscItems = inventoryChanges.MiscItems
				local v38 = {}

				for _, miscItem in miscItems do
					table.insert(v38, WeakResource(miscItem.ItemType))
				end

				local rawUpgrades = inventoryChanges.RawUpgrades

				for _, rawUpgrade in rawUpgrades do
					table.insert(v38, WeakResource(rawUpgrade.ItemType))
				end

				if #v38 > 0 then
					asyncLoader:LoadMultipleResources("DismantleRewards", v38, function(list)
						for i, v39 in ipairs(list) do
							local v40 = Resource(v39)

							if __wf_atom_7e8ad928(v40) then
								continue
							end

							local c_str = v40:__wf_atom_014a76a2():c_str()
							local v41

							if v39:IsA(__wf_atom_d5a2d4b7) then
								v41 = miscItems[i].ItemCount
							else
								v41 = rawUpgrades[i - #miscItems].ItemCount
							end

							v4:__wf_atom_820167a4(Symbol(c_str), v41, v40)
						end
					end)
				end
			end
		else
			v37.Icon = dracsIcon
			v37.Life = 2
			local v38 = v27.SellingPrice .. " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/Dracs", false)
			module3.AddPickupLogMessage(v38, v37)
		end

		local mCurrentScroll = v7.mScrollBar.mCurrentScroll
		local unfilteredIndexForElement = v7:GetUnfilteredIndexForElement(v27)

		if unfilteredIndexForElement ~= nil then
			v7:RemoveElementUnfiltered(unfilteredIndexForElement, true, true)
			v7:Redraw(OnItemChangedRedraw, true, true)
			v7.mScrollBar:SetScrollValue(mCurrentScroll, true, true)
		end
	elseif v36 then
		module.ShowMessage("/SF/Language/Vendor/DismantleItemFailed")
	else
		module.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	v27 = nil
	v28 = nil
	flag3 = false
	v29 = nil
end

function SellOrDismantleItem(p)
	if v27 ~= nil then
		return
	end

	if tonumber(p) == 4 and v28 ~= nil then
		v27 = v28
		local v36 = IsDismantle(v27)

		if v36 and v27.mItem.mItemId:__wf_atom_b70c3343() then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

				if
					v27.mPredictionSeed
					and not __wf_atom_7e8ad928(v27.StatWeapon)
					and __wf_atom_d2b2176d:__wf_atom_3752ced7(v27.mItem.mItemType, v27.mPredictionSeed)
				then
					ShowItemTicker(true)
					v31:ClearTimers()
					v31:AddTimer(5, function()
						ShowItemTicker(false)
					end)
					module.PlaySound(sellConfirmSound)
					module3.DismantleItem(v27.StatWeapon)
					local mCurrentScroll = v7.mScrollBar.mCurrentScroll
					local unfilteredIndexForElement = v7:GetUnfilteredIndexForElement(v27)

					if unfilteredIndexForElement ~= nil then
						v7:RemoveElementUnfiltered(unfilteredIndexForElement, true, true)
						v7:Redraw(OnItemChangedRedraw, true, true)
						v7.mScrollBar:SetScrollValue(mCurrentScroll, true, true)
					end
				else
					module.ShowMessage("/SF/Language/Vendor/DismantleItemFailed")
				end
			end

			v27 = nil
			v28 = nil
			flag3 = false
		else
			if _T.BackgroundMovie ~= nil then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
			end

			local sellOperation = SF.SellOperation()
			sellOperation:__wf_atom_afdfc7fe()
			local category = v27.Category
			local sellingPrice = v27.SellingPrice
			sellOperation:SellItem(category, tostring(v27.mItem.mItemId), 1)

			if v36 then
				sellOperation.mSellCurrency = 6
			else
				sellOperation.mSellCurrency = 0
				sellOperation.mSellPrice = sellingPrice
			end

			v29 = SF.SellCommand(sellOperation, "OnItemSoldOrDismantled")
			v29:Execute()
		end
	else
		v27 = nil
		v28 = nil
		flag3 = false
	end
end

function OnErrorHandler(p)
	v27 = nil
	v28 = nil
	flag3 = false

	if tonumber(p) == 4 then
	end
end

function IsDismantle(p)
	if p == nil or p.Type == nil then
		return false
	end

	return p.Type:IsA(__wf_atom_9df43583) and not p.Type:IsA(__wf_atom_d98e64fe)
end

local function fn24(p)
	if p == nil or flag3 then
		return
	end

	flag3 = true
	local name = p.Name
	local sellingPrice = p.SellingPrice
	local v36 = "<font face=\"Spectral SC\" color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">"
	local v37 = v36 .. Localize(name, nil) .. "</font>"
	local price = v36 .. mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/CurrencyAmount", true, {
		AMOUNT = sellingPrice
	}) .. "</font>"
	local v39 = "<p><font >" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ConfirmSale", true, {
		PRICE = price,
		ITEM = v37
	}) .. "</font></p>"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SellItemHeading", true)

	if IsDismantle(p) then
		v39 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleItem", true, { ITEM = v37 })
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/Dismantle", true)

		if not module2.CanDismantleItem(p) or v27 ~= nil then
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleNotAllowed", true, {
				ITEM = v37
			})
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_799d95f5()) then
				__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleDisabled", true)
			end

			module.ShowMessage(__wf_atom_8e9ac384_2, "OnErrorHandler")
			return false
		end
	elseif not module2.CanSellItem(p) or v27 ~= nil then
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SellNotAllowed", true, {
			ITEM = v37
		})
		module.ShowMessage(__wf_atom_8e9ac384_2, "OnErrorHandler")
		return false
	end

	module.ShowYesOrNoMessage(v39, "SellOrDismantleItem", nil, __wf_atom_8e9ac384)
end

function onKeyDown_MENU_RIGHT_CLICK()
	fn24(v28)
	return true
end

function onKeyDown_MENU_GENERIC2()
	onKeyDown_MENU_RIGHT_CLICK()
	return true
end

function onKeyDown_MENU_GENERIC3()
	local focusedElement = v7:GetFocusedElement()

	if not __wf_atom_7e8ad928(focusedElement) and module2.ToggleFavoriteItem(focusedElement) then
		v7.ITEM_UTIL.Update(mMovie, focusedElement.mClipName, focusedElement, v7)
		focusedElement.Refresh = true
		module.PlaySound(_G.UISound_Select)
	end

	return true
end