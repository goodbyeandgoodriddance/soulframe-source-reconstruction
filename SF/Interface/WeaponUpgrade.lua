local module = require("SF.Interface.SFUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.CardUtilitiesRedux")
local module7 = require("SF.Interface.Libs.StatsUtil")
local module8 = require("SF.Interface.Libs.ItemUtil")
require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = {
	TEXT_DISABLED = 5908767,
	TEXT_FOCUSED = 14524216,
	TEXT_UNFOCUSED = 12363651,
	ICON_BG = 10984574,
	BG = 2825751
}
local v2 = {
	{
		ItemType = 5,
		AdditionalTypes = { 1 },
		Name = "/SF/Language/Categories/Weapons"
	},
	{ ItemType = 3, Name = "/SF/Language/Categories/Pacts" },
	{ ItemType = 4, SubType = __wf_atom_58a409f1, Name = "/SF/Language/Categories/Motes" }
}
local v3 = { WEAPONS = 1, PACTS = 2, MODS = 3 }
local asyncLoader = module4.CreateAsyncLoader()
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local inventory = nil
local v8 = nil
local v9 = nil
local v10 = {}
local mSelectedCategoryId = 1
local fn
local v11 = false
local v12 = false
local v13 = false
local flag = false
local flag2 = false
local v14 = nil
local v15 = WeakResource("/SF/Upgrades/SFPactUpgrade")
local v16 = WeakResource("/SF/Upgrades/SFWeaponUpgrade")
local v17 = WeakResource("/SF/Types/Items/Kintsugi/BaseKintsugiUpgrade")
local v18 = WeakResource("/SF/Souls/Common/SFIdolMod")
local v19 = {
	{ 5 },
	{ 5, 10 },
	{ 5, 15, 30 },
	{ 5, 15, 30 }
}
local v20 = { 5, 15, 30 }

local function fn2(_, _) end

local function fn3(_)
	__wf_atom_7e8ad928(_T.BackgroundMovie)
end

local function fn4()
	if _T.InventoryOpen then
		module.CloseInventory()
		flag2 = false
		flag = false
	elseif v11 and not v13 then
		if v12 ~= nil then
			v12 = nil
			gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
			fn3(1)
		end
	else
		if v12 == nil then
			return
		end

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_d2b2176d = v7:__wf_atom_d2b2176d()

			if
				__wf_atom_d2b2176d:__wf_atom_e65461b9()
				or __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_e55d02aa())
			then
				return
			end
		end

		fn3(0)
		flag2 = false
		module.DissolveOutAndClose(mMovie)
		module2.PlaySound(exitDissolveSound)
	end
end

local function fn5()
	local v21 = {}
	table.insert(v21, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = function()
			if not flag then
				flag2 = true
				flag = true
			end
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v21, getfenv(1))
	end
end

local function fn6(mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(v8) then
		return nil
	end

	return v8:__wf_atom_232fd31d(mItemType)
end

local function fn7(weaponInfo, p)
	local weaponStoreItem = fn6(weaponInfo.mItemType)

	if __wf_atom_7e8ad928(weaponStoreItem) then
		return nil
	end

	local storeItemInfo = module5.GetStoreItemInfo(mMovie, weaponStoreItem, nil, nil, nil, true)
	storeItemInfo.WeaponInfo = weaponInfo
	storeItemInfo.WeaponStoreItem = weaponStoreItem
	storeItemInfo.MoteItemId = weaponInfo.mItemId
	storeItemInfo.Description = ""

	if weaponInfo.mXP ~= nil then
		storeItemInfo.Level = __wf_atom_c67f9605:__wf_atom_b4a75eaa(weaponInfo.mXP, weaponInfo.mItemType)
	end

	if p ~= nil then
		local __wf_atom_b369d77f = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0)):__wf_atom_b369d77f(p)
		storeItemInfo.Equipped = weaponInfo.mItemId == __wf_atom_b369d77f.mItemId
	end

	return storeItemInfo
end

local function fn8()
	v6.mStatsToOnlyShow = {
		"Level",
		"MeleeSkill",
		"AttuneType",
		"DamageType",
		"Total",
		"StabilityDamage",
		"HeavyAttack",
		"CriticalChance"
	}

	for i = 0, 2 do
		local attributeTypeTag = module.GetAttributeTypeTag(i)
		table.insert(v6.mStatsToOnlyShow, "Requirement_" .. attributeTypeTag)
	end

	v4:RemoveElements(true, true)
	local v21 = inventory:__wf_atom_4259c789() or {}
	local v22 = inventory:__wf_atom_4f67b86c() or {}
	table.move(v22, 1, #v22, #v21 + 1, v21)
	local v23 = {}

	for i = 1, #v21 do
		local v24 = fn7(v21[i], 3)

		if v24 == nil then
			continue
		end

		if v24.Equipped then
			table.insert(v23, 1, v24)
		else
			table.insert(v23, v24)
		end
	end

	for i = 1, #v23 do
		v4:AddElement(v23[i], true)
	end

	v4:Redraw(nil, true, true)
end

local function fn9()
	v6.mStatsToOnlyShow = { "Level", "Courage", "Grace", "Spirit", "UnarmedMelee" }
	v4:RemoveElements(true, true)
	local __wf_atom_ebdc4e6e = inventory:__wf_atom_ebdc4e6e()
	local v21 = {}

	for i = 1, #__wf_atom_ebdc4e6e do
		local v22 = fn7(__wf_atom_ebdc4e6e[i], 0)

		if __wf_atom_7e8ad928(v22) then
			continue
		end

		if v22.Equipped then
			table.insert(v21, 1, v22)
		else
			table.insert(v21, v22)
		end
	end

	for i = 1, #v21 do
		v4:AddElement(v21[i], true)
	end

	v4:Redraw(nil, true, true)
end

local function fn10()
	v4:RemoveElements(true, true)
	local __wf_atom_063f1444 = inventory:__wf_atom_063f1444()

	for _, v21 in ipairs(__wf_atom_063f1444) do
		if not (v21.mItemType:IsA(v16) or v21.mItemType:IsA(v15)) then
			continue
		end

		local v22 = fn7(v21)

		if v22 then
			v4:AddElement(v22, true)
		end
	end

	local upgrades = inventory:GetUpgrades()

	for _, upgrade in ipairs(upgrades) do
		if upgrade.mItemType:IsA(v17) then
			continue
		end

		local v21 = fn7(upgrade)

		if v21 then
			v4:AddElement(v21, true)
		end
	end

	v4:Redraw(nil, true, true)
end

local function fn11()
	if mSelectedCategoryId == v3.WEAPONS then
		fn8()
		local v21 = 1

		if not __wf_atom_7e8ad928(_T.WeaponToUpgrade) then
			for i, mElement in ipairs(v4.mElements) do
				if mElement.WeaponStoreItem ~= _T.WeaponToUpgrade then
					continue
				end

				v21 = i
				break
			end
		end

		v4:SelectElement(v21, false)
		mMovie:__wf_atom_2dedec1a("Details", 13, true)
	elseif mSelectedCategoryId == v3.PACTS then
		fn9()
		v4:SelectElement(1, false)
		mMovie:__wf_atom_2dedec1a("Details", 13, true)
	else
		fn10()
		mMovie:__wf_atom_2dedec1a("Details", 13, false)
	end
end

local function fn12(mSelectedCategoryId2, p)
	if not p and mSelectedCategoryId2 == v4.mCategoryMenu.mSelectedCategoryId then
		return
	end

	v4.mCategoryMenu.mSelectedCategoryId = mSelectedCategoryId2
	fn11()
end

local function fn13(mSelectedElement, p)
	module7.CreateProxyWeaponOneShot(
		v7,
		mSelectedElement.WeaponInfo.mItemType,
		mSelectedElement.WeaponInfo.mXP,
		v10,
		function(p2)
			if not p then
				v6:SetType(p2, v7, true)
			end

			v6:Compare(p2)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Details.StatsContainer", 1)
			mMovie:__wf_atom_e57658c2("Details.BelowDesc", 1, __wf_atom_5e6e15c8 + v6.mHeight)
		end
	)
end

local function fn14()
	local module9 = require("EE.Interface.Components.ItemList")
	v4 = module9.Create(getfenv(1), "ListContainer")

	function v4.mOnFocusedCallback(infoPopup_Data)
		if mSelectedCategoryId == v3.MODS then
			module4.SetItemInfoPopupRect(
				mMovie,
				infoPopup_Data,
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 2),
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 3),
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 14) - 50,
				mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 15)
			)
			_T.InfoPopup_Data = infoPopup_Data
		end
	end

	function v4:mOnUnfocusedCallback()
		if self.StatWeapon ~= nil then
			gRegion:__wf_atom_dd1e4d10(self.StatWeapon)
			self.StatWeapon = nil
		end

		if self.StatUpgrades ~= nil then
			for i = 1, #self.StatUpgrades do
				gRegion:__wf_atom_dd1e4d10(self.StatUpgrades[i])
			end

			self.StatUpgrades = nil
		end

		_T.InfoPopup_Data = nil
	end

	function v4.mOnSelectedCallback(_)
		if mSelectedCategoryId == v3.MODS then
			v4.mSelectedElement = nil
			return
		end

		local mSelectedElement = v4.mSelectedElement

		if __wf_atom_7e8ad928(mSelectedElement) or __wf_atom_7e8ad928(mSelectedElement.WeaponInfo) then
			return
		end

		v10 = inventory:__wf_atom_43563387(mSelectedElement.WeaponInfo.mItemId, 0, false)
		local mItemTypes = {}
		table.insert(mItemTypes, mSelectedElement.WeaponInfo.mItemType)

		for i = 1, #v10 do
			if not __wf_atom_7e8ad928(v10[i].mItemType) then
				table.insert(mItemTypes, v10[i].mItemType)
			end
		end

		asyncLoader:LoadMultipleResources("OnSelected", mItemTypes, function()
			fn13(mSelectedElement)
			fn(mSelectedElement)
		end)
	end

	function v4.mElementDrawCallback(_) end

	mMovie:__wf_atom_2dedec1a("ListContainer.Categories", 13, true)
	v4:SetCategories(v2)
	fn12(mSelectedCategoryId, true)
end

local function fn15(state, p)
	local v21 = math.random(0, 0.5)
	local particles = module2.CreateParticles(mMovie, state.mClipName, moteParticleSys, 49, 49)
	local v22 = math.random(760, 1160)
	local v23 = mMovie:__wf_atom_5e6e15c8(state.mClipName, 2) + math.random(39, 59)
	local v24 = mMovie:__wf_atom_5e6e15c8(state.mClipName, 3) + math.random(39, 59)
	__wf_atom_ec43d06e(mMovie, state.mClipName, 8, { function(p2)
			if not __wf_atom_7e8ad928(particles) then
				local v25 = math.max(0, p2 - v21)

				if not p then
					v25 = 1 - v25
				end

				local v26 = math.sqrt(v25)
				local screenParticlesCoord, v27 = module2.GetScreenParticlesCoord(
					mMovie,
					v22,
					1100,
					gRegion:GetGameCamera()
				)
				local screenParticlesCoord2, v28 = module2.GetScreenParticlesCoord(
					mMovie,
					v23,
					v24,
					gRegion:GetGameCamera()
				)
				local v29 = math.sin(3.1415927410125732 * 2 * v26 * 1.7) * (1 - v26) * 0.01
				local v30 = math.sin(3.3 + 3.1415927410125732 * 2 * v26 * 2.3) * (1 - v26) * 0.03
				local v31 = __wf_atom_104bfe98(screenParticlesCoord, screenParticlesCoord2, v26) + v29
				local v32 = __wf_atom_104bfe98(v27, v28, v26) + v30
				local v33 = Vector(v31, v32, 1)
				Normalize(v33)
				particles:__wf_atom_e310f01f(v33 * 4, __wf_atom_80368bb1)
			end
		end }, { 1 + v21 }, 3)
end

fn = function(mSelectedElement, p)
	mMovie:__wf_atom_50d60589("Details.Title", 36, mSelectedElement.Name)
	mMovie:__wf_atom_50d60589("Details.Desc", 36, mSelectedElement.LocalizedDesc)
	local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(
		mSelectedElement.WeaponInfo.mXP,
		mSelectedElement.WeaponInfo.mItemType
	)
	local v21 = 0
	local v22

	if mSelectedElement.WeaponInfo.mItemType:IsA(__wf_atom_d98e64fe) then
		v22 = v20
	else
		v22 = v19[mSelectedElement.StoreItem:__wf_atom_a8dac107() + 1]
	end

	for i = 1, #v22 do
		if __wf_atom_b4a75eaa < v22[i] then
			break
		else
			v21 = i
		end
	end

	v5:RunForAllElements(function(state)
		local id = state.Id
		state.Locked = v21 < state.Id

		if __wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v10[id]) then
			state.Prior = state.StoreItemInfo
			state.StoreItemInfo = nil

			if p and state.Prior ~= state.StoreItemInfo then
				fn15(state, false)
			end
		else
			local v23 = v10[id]
			state.Prior = state.StoreItemInfo
			state.StoreItemInfo = module5.GetStoreItemInfo(mMovie, fn6(v23.mItemType), nil, nil, nil, true)

			if p and state.Prior ~= state.StoreItemInfo then
				fn15(state, true)
			end
		end

		v5.mElementDrawCallback(state)
	end)

	if v21 == 0 or #v10 == 0 then
		v14:SetActive(false)
	else
		v14:SetActive(true)
	end

	mMovie:__wf_atom_2dedec1a("Details", 13, true)
	__wf_atom_ec43d06e(mMovie, "Details", 8, { 12 }, { 100 }, 0.25, 0)
	__wf_atom_ec43d06e(mMovie, "Details.StatsContainer", 8, { 12 }, { 100 }, 0.25, 0)
end

local function fn16()
	if flag then
		return
	end

	local upgradeIds = {}

	if v4.mSelectedElement.WeaponInfo.mItemType:IsA(__wf_atom_d98e64fe) then
		local __wf_atom_43563387 = inventory:__wf_atom_43563387(v4.mSelectedElement.WeaponInfo.mItemId, 0, false)

		if
			__wf_atom_43563387 ~= nil
			and #__wf_atom_43563387 >= 0
			and not __wf_atom_7e8ad928(__wf_atom_43563387[1].mItemType)
			and __wf_atom_43563387[1].mItemType:IsA(v18)
		then
			local upgradeId = SF.UpgradeId()
			upgradeId.mType = __wf_atom_43563387[1].mItemType
			upgradeId.mId = __wf_atom_43563387[1].mItemId
			table.insert(upgradeIds, upgradeId)
		end
	end

	for i = 1, #v10 do
		local upgradeId = SF.UpgradeId()

		if not __wf_atom_7e8ad928(v10[i].mItemType) then
			if v10[i].mItemType:IsA(v18) then
				continue
			end

			upgradeId.mType = v10[i].mItemType
			upgradeId.mId = v10[i].mItemId
		end

		if not __wf_atom_7e8ad928(weaponUpgradeSelectSound) then
			module2.PlaySound(weaponUpgradeSelectSound)
		end

		table.insert(upgradeIds, upgradeId)
	end

	inventory:__wf_atom_494e9b0e(v4.mSelectedElement.WeaponInfo.mItemId, 0, false, upgradeIds)
	v10 = inventory:__wf_atom_43563387(v4.mSelectedElement.WeaponInfo.mItemId, 0, false)
	v11 = true
	fn(v4.mSelectedElement, true)
	fn13(v4.mSelectedElement)
	module8.Initialize(mMovie, v4.mSelectedElement.mClipName, v4.mSelectedElement)
end

local function fn17(id)
	local _ = mMovie:__wf_atom_5e6e15c8("Details.StatsContainer", 0) + mMovie:__wf_atom_5e6e15c8("Details.StatsContainer", 14) / 2
	local v21 = {
		BackgroundAlpha = 0.7,
		ShowPauseMenu = false,
		ShouldShowInfoTip = false,
		InfoTipHeading = "/SF/Language/Crafting/Upgrade_NoMote_Title",
		InfoTipSubtext = "/SF/Language/Crafting/Upgrade_NoMote_Description",
		Categories = {
			{ ItemType = 4, Name = "/SF/Language/Crafting/Upgrade_SelectionHeading" }
		},
		ShowAllItemsCategory = false,
		ItemTypesFilter = { __wf_atom_58a409f1 },
		FunctionFilter = function(p)
			local ternary = module2.Ternary(mSelectedCategoryId == v3.PACTS, v15, v16)

			if
				not p.mItemType:IsA(ternary)
				and (mSelectedCategoryId ~= v3.WEAPONS or not p.mItemType:IsA(__wf_atom_16cdad3a) or p.mItemType:IsA(v17))
			then
				return false
			end

			for i = 1, #v10 do
				if v10[i].mItemType == p.mItemType then
					return false
				end
			end

			return true
		end,
		OnItemSelected = function(p)
			if flag then
				return
			end

			local mItem = p.mItem
			local v21 = v10
			v10 = {}
			local v22 = id
			local v23 = 1

			for i = 1, #v21 do
				if __wf_atom_7e8ad928(v21[i].mItemType) or not v21[i].mItemType:IsA(v18) then
					continue
				end

				table.insert(v10, v21[i])
				v23 += 1
				v22 += 1
				break
			end

			for i = v23, v23 + 2 do
				local v24 = {}

				if i == v22 then
					v24 = mItem
				elseif i <= #v21 and not (__wf_atom_7e8ad928(v21[i]) or __wf_atom_7e8ad928(v21[i].mItemType)) then
					v24 = v21[i]
				end

				table.insert(v10, v24)
			end

			fn16()
			module.CloseInventory()
		end,
		OnClosed = function()
			fn2(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
		end
	}
	module.OpenInventory(mMovie, v21)
end

local function fn18()
	mMovie:__wf_atom_c90af43a("Details.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("Details.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("Details.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("Details.BgFill", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Details.BgFill", 12, 80)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 12, 80)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 12, 80)
	mMovie:__wf_atom_e57658c2("Details.Title", 44, v.TEXT_FOCUSED)
	mMovie:__wf_atom_e57658c2("Details.Desc", 44, v.TEXT_UNFOCUSED)
	mMovie:__wf_atom_e57658c2("Details.BelowDesc.Title", 44, v.TEXT_FOCUSED)
	mMovie:__wf_atom_7d7314f1("Details.BelowDesc.Title.text", "/SF/Language/Crafting/Upgrade_UpgradesTitle")
	local module9 = require("EE.Interface.Components.List")
	v5 = module9.CreateList(mMovie, "Details.BelowDesc.Upgrade1", 3)
	v5:SetCallbacks("UpgradeListItemPressed", "UpgradeListItemFocused", "UpgradeListItemUnfocused")
	v5.mForcedHorizontalSeparation = 160
	v5.mForcedVerticalSeparation = 0

	function v5.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "Label", 44, v.TEXT_FOCUSED)
	end

	function v5.mOnSelectedCallback(p)
		if p.Locked or flag then
			return
		end

		fn17(p.Id)
	end

	function v5.mOnFocusedCallback(data)
		module2.PlaySound(_G.UISound_Focus)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Info.Border", upgradeGridItemTextures[2])
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Info.Bg2", 13, not data.Locked)

		if
			not data.Locked
			and (__wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v10[data.Id]) or __wf_atom_7e8ad928(v10[data.Id].mItemType))
		then
			return
		end

		local storeItemInfo = { CustomEntry = true, TopLeftAligned = true }

		if data.Locked then
			storeItemInfo.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionLocked", false)
			local mSelectedElement = v4.mSelectedElement

			if __wf_atom_7e8ad928(mSelectedElement) then
				return
			end

			local __wf_atom_a8dac107 = mSelectedElement.StoreItem:__wf_atom_a8dac107()
			local v21

			if mSelectedElement.WeaponInfo.mItemType:IsA(__wf_atom_d98e64fe) then
				v21 = v20
			else
				v21 = v19[__wf_atom_a8dac107 + 1]
			end

			local v22 = v21[data.Id]

			if v22 then
				storeItemInfo.LocalizedDesc = mMovie:__wf_atom_8e9ac384(
					"/SF/Language/Crafting/Upgrade_UpgradeLockedDesc",
					false,
					{ NUM = module2.FormatNumber(v22) }
				)
			else
				local rarityTag = module.GetRarityTag(__wf_atom_a8dac107)
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Rarity_" .. rarityTag, false)
				storeItemInfo.LocalizedDesc = mMovie:__wf_atom_8e9ac384(
					"/SF/Language/Menu/Upgrade_Rarity_Locked",
					false,
					{ RARITY = __wf_atom_8e9ac384 }
				)
			end
		else
			if data.StoreItemInfo == nil then
				return
			end

			local upgradeInfo = SF.UpgradeInfo()
			upgradeInfo.mItemType = data.StoreItemInfo.Type
			data.StoreItemInfo.mMod = {
				Card = module6.CardFromArtifact(upgradeInfo, data.Id, nil)
			}
			storeItemInfo = data.StoreItemInfo
		end

		__wf_atom_ec43d06e(
			mMovie,
			data.mClipName .. ".Info.Icon",
			8,
			{ 14, 15 },
			{ data.mIconWidth * 1.1, data.mIconHeight * 1.1 },
			0.25,
			0
		)
		module4.SetItemInfoPopupRect(
			mMovie,
			storeItemInfo,
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 2),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 3),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 14),
			mMovie:__wf_atom_cfc41e35(data.mClipName, "Btn", 15)
		)
		_T.InfoPopup_Data = storeItemInfo
	end

	function v5.mOnUnfocusedCallback(data)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Info.Border", upgradeGridItemTextures[1])
		__wf_atom_ec43d06e(
			mMovie,
			data.mClipName .. ".Info.Icon",
			8,
			{ 14, 15 },
			{ data.mIconWidth, data.mIconHeight },
			0.25,
			0
		)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Info.Bg2", 13, false)
		_T.InfoPopup_Data = nil
	end

	function v5.mElementDrawCallback(data)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Info.Border", upgradeGridItemTextures[1])
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Info.Bg2", upgradeGridItemTextures[4])
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Info.Bg", 11, _G.UIColor_Black)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Info.Bg", 12, 50)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Info.Bg2", 13, false)
		local icon = nil

		if data.Locked then
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MissionLocked", false)
			icon = upgradeGridItemTextures[3]
		elseif __wf_atom_7e8ad928(data.StoreItemInfo) then
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_Empty", false)
		else
			local _name = data.StoreItemInfo.Name
			icon = data.StoreItemInfo.Icon
		end

		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Info.Icon", 13, not __wf_atom_7e8ad928(icon))
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Info.Icon", icon)
	end

	for _ = 1, 3 do
		local v21 = {
			mIconWidth = mMovie:__wf_atom_5e6e15c8("Details.BelowDesc.Upgrade1.Info.Icon", 14),
			mIconHeight = mMovie:__wf_atom_5e6e15c8("Details.BelowDesc.Upgrade1.Info.Icon", 15)
		}
		v5:AddElement(v21, true)
	end

	v5:Redraw(nil, true, true)
	mMovie:__wf_atom_2dedec1a("Details", 13, false)
	mMovie:__wf_atom_e57658c2("Details", 12, 0)
end

function OnAssignUpgradesClicked()
	fn16()
end

function OnClearUpgradesClicked()
	local upgradeIds = {}

	if v4.mSelectedElement.WeaponInfo.mItemType:IsA(__wf_atom_d98e64fe) then
		local __wf_atom_43563387 = inventory:__wf_atom_43563387(v4.mSelectedElement.WeaponInfo.mItemId, 0, false)

		if
			__wf_atom_43563387 ~= nil
			and #__wf_atom_43563387 >= 0
			and not __wf_atom_7e8ad928(__wf_atom_43563387[1].mItemType)
			and __wf_atom_43563387[1].mItemType:IsA(v18)
		then
			local upgradeId = SF.UpgradeId()
			upgradeId.mType = __wf_atom_43563387[1].mItemType
			upgradeId.mId = __wf_atom_43563387[1].mItemId
			table.insert(upgradeIds, upgradeId)
		end
	end

	v10 = upgradeIds
	fn16()

	if not __wf_atom_7e8ad928(clearUpgradesSound) then
		module2.PlaySound(clearUpgradesSound)
	end
end

function onViewportSizeChanged(p, p2)
	fn2(p, p2)
end

function Initialize()
	module.ShowBackground({ mFade = module2.LEFT_ALIGNED })
	mMovie:__wf_atom_2dedec1a("Title", 13, false)
	v8 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	v7 = gRegion:__wf_atom_c4f78a8f()
	inventory = gGameData:GetInventory()
	v9 = module2.PlaySound(loopingMusic)
	module2.PlaySound(enterSound)
	module3.RegisterHideHud(true)
	local module9 = require("SF.Interface.Components.ThemedStats")
	v6 = module9.Create(mMovie, "Details.StatsContainer.Stats")
	v6.mLockHeightToMax = true
	v6.mGrowDownward = true
	v6.mCanFocusStats = true
	v6:SetWidth(450)
	mMovie:__wf_atom_e57658c2("Details.StatsContainer", 12, 0)
	mMovie:__wf_atom_2dedec1a("Details.Desc", 13, false)
	mMovie:__wf_atom_2dedec1a("Details.Title", 13, false)
	mMovie:__wf_atom_2dedec1a("Details.BelowDesc.Separator", 13, false)
	fn18()
	fn14()
	local module10 = require("SF.Interface.Components.Button")
	v14 = module10.Create(
		mMovie,
		"Details.BelowDesc.ClearBtn",
		"/SF/Language/Crafting/Upgrade_ClearBtn",
		"OnClearUpgradesClicked"
	)
	v14:SetVariant(module10.VARIANTS.SPECIAL_BUTTON)
	v14:SetAnchor(module2.CENTER_ALIGNED)
	fn5()
	fn2(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	asyncLoader:Update()

	if mSelectedCategoryId ~= v4.mCategoryMenu.mSelectedCategoryId then
		mSelectedCategoryId = v4.mCategoryMenu.mSelectedCategoryId
		fn11()
	end

	if flag2 then
		fn4()
	end
end

function OnSaveLoadOutComplete(p, _)
	module3.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	v12 = p

	if p then
		module3.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
	end

	v13 = true
end

function Shutdown()
	module.HideBackground()
	_T.InfoPopup_Data = nil

	if not __wf_atom_7e8ad928(gRegion) then
		module2.PlaySound(exitSound)
	end

	module3.RegisterHideHud(false)

	if _T.OnReturnToArsenal ~= nil then
		_T.OnReturnToArsenal(v11)
	end
end

function UpgradeListItemPressed(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:SelectElementById(p)
	end
end

function UpgradeListItemFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:FocusElementById(p)
	end
end

function UpgradeListItemUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElementById(p)
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if __wf_atom_7e8ad928(v4) then
		return
	end

	v4.mScrollBar:ScrollDirection(p)
end