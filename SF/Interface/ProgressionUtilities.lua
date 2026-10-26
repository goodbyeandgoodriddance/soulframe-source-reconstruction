local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.StoreItemUtilities")
local module4 = require("SF.Interface.Libs.ItemUtil")
local v = {
	TEXT_DISABLED = 5908767,
	TEXT_FOCUSED = 14524216,
	TEXT_UNFOCUSED = 12363651,
	ICON_BG = 10984574,
	BG = 2825751
}
local v2 = WeakResource("/SF/Upgrades/SFPactUpgrade")
local v3 = WeakResource("/SF/Upgrades/SFWeaponUpgrade")
local v4 = WeakResource("/SF/Types/Lore/CharacterLore/CharacterLoreFragment")
CATEGORIES = {
	{
		ItemType = 4,
		SubTypes = { WeakResource("/SF/Types/Game/RandomizedArtifactUpgrade") },
		Name = "/SF/Language/Categories/Joineries"
	},
	{
		ItemType = 4,
		SubTypes = { v2, v3 },
		Name = "/SF/Language/Categories/Motes"
	},
	{
		ItemType = 4,
		SubTypes = { WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade") },
		Name = "/SF/Language/Categories/MotesActive"
	},
	{
		ItemType = 4,
		SubTypes = { WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade") },
		Name = "/SF/Language/Categories/MotesPassive"
	},
	{
		ItemType = 13,
		SubTypes = { WeakResource("/SF/Types/Game/RecipeItem") },
		Name = "/SF/Language/Categories/Fragments"
	},
	{
		ItemType = 11,
		SubTypes = { WeakResource("/SF/Types/PickUps/Resources/ResourceItem") },
		Name = "/SF/Language/Categories/CraftingMaterials"
	}
}

local function fn(object, p, list, p2, p3)
	object:__wf_atom_7f57ab2f(p, "Bookend", 13, false)
	object:OverrideMaterial(p .. ".Name", p3)
	object:OverrideMaterial(p .. ".Subheading", p3)
	object:OverrideMaterial(p .. ".Status", p3)
	object:OverrideMaterial(p .. ".Bookend", p2)
	object:OverrideMaterial(p .. ".StatusIcon", p2)
	object:__wf_atom_933bbce0(p .. ".BgEndLeft", _G.UITexture_ItemList[1], p2)
	object:__wf_atom_933bbce0(p .. ".BgEndRight", _G.UITexture_ItemList[1], p2)
	object:__wf_atom_933bbce0(p .. ".BgFill", _G.UITexture_ItemList[2], p2)
	object:__wf_atom_c90af43a(p .. ".Item.IconBg", list[5])
	object:__wf_atom_4c1c1986(p, "BgEndLeft", 12, 70)
	object:__wf_atom_4c1c1986(p, "BgEndRight", 12, 70)
	object:__wf_atom_4c1c1986(p, "BgFill", 12, 70)
	object:__wf_atom_4c1c1986(p, "Item.RecipeIcon", 12, 70)
end

local function fn2(object, p, p2, _)
	if p == nil then
		return
	end

	local ternary = module.Ternary(p2, 90, 70)
	object:__wf_atom_4c1c1986(p, "BgEndLeft", 12, ternary)
	object:__wf_atom_4c1c1986(p, "BgEndRight", 12, ternary)
	object:__wf_atom_4c1c1986(p, "BgFill", 12, ternary)
	object:__wf_atom_4c1c1986(p, "Item.RecipeIcon", 12, 70)
	object:__wf_atom_4c1c1986(p, "Item.IconOutline", 11, module.Ternary(p2, _G.UIColor_Yellow, _G.UIColor_Brown))
	object:__wf_atom_7f57ab2f(p, "Item.IconFlare", 13, p2)
	object:__wf_atom_c90af43a(p .. ".Bookend", _G.UITexture_ItemList[module.Ternary(p2, 4, 5)])
end

function OnItemElementClipCreated(object, data, p, icon, text)
	local mClipName = data.mClipName

	if __wf_atom_7e8ad928(mClipName) then
		return
	end

	local v5 = mClipName .. ".List.ItemElement1"
	fn(object, v5, p, icon, text)
	fn2(object, v5, false, p)
	module4.Initialize(object, v5 .. ".Item", data, {
		mVisRangeMaterials = { Icon = icon, Text = text }
	})
	object:__wf_atom_4c1c1986(v5, "Item.IconBg", 12, 100)
	object:__wf_atom_1ca72041(v5 .. ".Item.IconOutline", "VisibilitySize", 1, 1, 1, 1)
	object:__wf_atom_7f57ab2f(v5, "StatusIcon", 13, false)
	object:__wf_atom_7f57ab2f(v5, "PremiumGlow", 13, false)
	object:__wf_atom_7f57ab2f(v5, "Level", 13, false)
	object:__wf_atom_4c1c1986(v5, "Name", 44, v.TEXT_FOCUSED)
	object:__wf_atom_4c1c1986(v5, "Subheading", 44, v.TEXT_UNFOCUSED)
	object:__wf_atom_4c1c1986(v5, "Status", 44, v.TEXT_UNFOCUSED)
	local name = data.Name or "[HC] No Name"
	local description = data.Description or "[HC] No Description"
	local xpText = data.XpText or "[HC] No Xp"
	local v6 = not data.IsDiscovery
	object:__wf_atom_48bd5a59(v5, "Name", 36, name)
	object:__wf_atom_48bd5a59(v5, "Subheading", 36, description)
	object:__wf_atom_48bd5a59(v5, "Status", 36, xpText)
	object:__wf_atom_7f57ab2f(v5, "Item.IconOutline", 13, v6)
	object:__wf_atom_7f57ab2f(v5, "Item.IconBg", 13, v6)
	object:__wf_atom_7f57ab2f(v5, "Item.IconFlare", 13, v6)
	object:__wf_atom_4c1c1986(v5, "Item.Icon", 14, module.Ternary(v6, 65, 90))
	object:__wf_atom_4c1c1986(v5, "Item.Icon", 15, module.Ternary(v6, 65, 90))
	object:__wf_atom_4c1c1986(v5, "Item.IconOutline", 14, 83)
	object:__wf_atom_4c1c1986(v5, "Item.IconOutline", 15, 83)
end

function GetXpIncrease(object, p, p2, p3)
	local v5 = p2 - p

	if v5 > 0 then
		return "+" .. object:__wf_atom_8e9ac384(p3, true) .. module.FormatNumber(v5)
	end

	return object:__wf_atom_8e9ac384(p3, true) .. module.FormatNumber(v5)
end

local function fn3(object, p, p2, p3)
	local convertColorNumberToHex = module.ConvertColorNumberToHex(v.TEXT_UNFOCUSED)
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(v.TEXT_FOCUSED)
	local formatNumber = module.FormatNumber(p3)
	return "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. object:__wf_atom_8e9ac384(p, true, {
		AMOUNT = "<font color=\"" .. convertColorNumberToHex2 .. "\">" .. module.FormatNumber(p2) .. "</font>",
		REQUIRED = formatNumber
	}) .. "</font></p>"
end

local function fn4(object, p, p2, p3, p4, p5, p6, p7, value, p8)
	if p7 > 20 then
		return
	end

	__wf_atom_ec43d06e(object, p2, 8, { 12 }, { 100 }, 0.02, value or 0, function()
		object:__wf_atom_50d60589(p2, 36, (fn3(object, p3, p4 + math.floor((p5 - p4) * p7 / 20), p6)))
		module.PlaySound(p8)
		fn4(object, p, p2, p3, p4, p5, p6, p7 + 1, 0, p8)
	end)
end

function AnimateTextIncrease(object, p, p2, p3, p4, p5, p6, p7, p8)
	object:__wf_atom_50d60589(p2, 36, (fn3(object, p3, p4, p6)))
	fn4(object, p, p2, p3, p4, p5, p6, 1, p7, p8)
end

local function fn5(p, p2, p3, object)
	local mWeaponXP = p2.mWeaponXP
	local mWeaponXPPrevious = p2.mWeaponXPPrevious
	local result = {}

	if __wf_atom_7e8ad928(object) then
		result.Xp = 0
		return result
	end

	for _, v5 in mWeaponXP do
		if __wf_atom_7e8ad928(v5.mItemType) or not v5.mItemType:IsA(object:__wf_atom_1bb5b1ff()) then
			continue
		end

		local mItemType = v5.mItemType
		result = module3.GetItemTypeWithStoreInfo(p, mItemType, p3)
		result.Xp = v5.mItemCount

		for _, v6 in mWeaponXPPrevious do
			if v6.mItemType ~= mItemType then
				continue
			end

			result.Xp -= v6.mItemCount
			break
		end

		local __wf_atom_9765cbd5 = object:__wf_atom_9765cbd5()
		result.ShowXp = __wf_atom_c67f9605:__wf_atom_b4a75eaa(__wf_atom_9765cbd5, mItemType) < __wf_atom_c67f9605:__wf_atom_a1680b24(mItemType)
		result.EndXp = __wf_atom_9765cbd5
		result.StartXp = result.EndXp - result.Xp

		if result.StartXp >= 0 then
			local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(result.StartXp, mItemType)
			result.StartLevelXp = __wf_atom_c67f9605:__wf_atom_89d4ac2a(__wf_atom_b4a75eaa, mItemType)
		end

		break
	end

	result.Xp = result.Xp or 0
	result.StartXp = result.StartXp or 0
	result.EndXp = result.EndXp or 0
	result.StartLevelXp = result.StartLevelXp or 0
	return result
end

function GetPactElement(p, p2, p3)
	local v5 = { Xp = 0 }
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return v5
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return v5
	end

	local v6 = fn5(p, p2, p3, __wf_atom_d2b2176d:__wf_atom_e55d02aa())

	if v6.ShowXp == false then
		return v5
	end

	return v6
end

function GetWeaponElement(p, p2, p3)
	local v5 = { Xp = 0 }
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return v5
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return v5
	end

	local v6 = fn5(p, p2, p3, __wf_atom_d2b2176d:__wf_atom_4c047e9d())

	if v6.ShowXp == false then
		return v5
	end

	return v6
end

function GetSecondaryWeaponElement(p, p2, p3)
	local v5 = { Xp = 0 }
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return v5
	end

	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return v5
	end

	local v6 = fn5(p, p2, p3, __wf_atom_d2b2176d:__wf_atom_28224c27(1))

	if v6.ShowXp == false then
		return v5
	end

	return v6
end

function GetFactionElement(state, items, p, p2)
	if state.mFactionXp < state.mFactionXpPrevious or p == EMPTY_SYMBOL then
		return nil
	end

	local mTitle = nil
	local v5 = nil
	local startLevelXp = nil
	local nextLevelXp = nil
	local iconTexture = nil
	local name = nil

	for _, item in items do
		if item:__wf_atom_e0f044e1() ~= p then
			continue
		end

		iconTexture = item:GetIconTexture()
		name = tostring(item:__wf_atom_818ea3a7())

		if not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(p)
			mTitle = __wf_atom_51dd1b95.mTitle

			if p2 then
				state.mFactionXpPrevious = __wf_atom_51dd1b95.mStanding
				state.mFactionXp = __wf_atom_51dd1b95.mStanding + state.mFactionXp
			end
		end

		if __wf_atom_7e8ad928(__wf_atom_c67f9605) then
			break
		end

		v5 = __wf_atom_c67f9605:__wf_atom_8d7c7c8b()
		startLevelXp = __wf_atom_c67f9605:__wf_atom_7a5e1add(p, mTitle)
		nextLevelXp = __wf_atom_c67f9605:__wf_atom_053b87b2(p, mTitle)

		if startLevelXp < 0 then
			startLevelXp = 0
		end

		break
	end

	if __wf_atom_7e8ad928(iconTexture) then
		return nil
	end

	if mTitle == nil or v5 == nil or startLevelXp == nil or nextLevelXp == nil then
		return nil
	end

	if state.mFactionXp == state.mFactionXpPrevious and mTitle == v5 then
		return nil
	end

	return {
		Xp = state.mFactionXp,
		ShowXp = true,
		StartXp = state.mFactionXpPrevious,
		EndXp = state.mFactionXp,
		Name = name,
		Icon = iconTexture,
		IsFactionXp = true,
		StartLevel = mTitle,
		AnimLevel = mTitle + 1,
		StartLevelXp = startLevelXp,
		NextLevelXp = nextLevelXp
	}
end

function GetInfamyElement(mFactionXp, p, p2)
	return GetFactionElement({ mFactionXp = mFactionXp, mFactionXpPrevious = 0 }, p, p2, true)
end

function GetLocationEncountersElement(_, p)
	local result = {
		Count = 0,
		IsDiscovery = true,
		Name = Localize("/SF/Language/Progression/Encounters", nil),
		Description = Localize("/SF/Language/Progression/EncountersDesc", nil),
		Icon = WeakResource("/SF/Interface/Graphics/WaypointMarkers/ExclamationMark.png")
	}

	for _, v5 in ipairs(gGameData:__wf_atom_b38b2614()) do
		if v5.mTag == "LOCATION_ENCOUNTER_COMPLETION" and p.mLastClearedDate:__wf_atom_8f70d89f(v5.mDate) > 0 then
			result.Count += 1
		end
	end

	return result
end

function GetLoreFragmentElement(object, p)
	local loreFragments = {
		{
			Type = v4,
			Name = Localize("/SF/Language/Codex/Characters", nil),
			Icon = WeakResource("/SF/Interface/Graphics/WaypointMarkers/MapPerson.png")
		}
	}

	for _, v5 in ipairs(loreFragments) do
		v5.Count = 0
		v5.IsDiscovery = true
	end

	local inventory

	if not __wf_atom_7e8ad928(gGameData) then
		inventory = gGameData:GetInventory() or nil
	end

	if not __wf_atom_7e8ad928(inventory) then
		for _, v5 in loreFragments do
			local kind = v5.Type

			if p.mLastClearedDate == nil then
				if _T.DebugProgressionScreen then
					v5.Count += 1
				end
			else
				for _, v6 in inventory:__wf_atom_0dec86a1() do
					if __wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v6.mItemType) or not v6.mItemType:IsA(kind) then
						continue
					end

					if not (p.mLastClearedDate:__wf_atom_8f70d89f(v6.mDate) > 0) then
						continue
					end

					v5.Count += 1
					break
				end
			end

			v5.Description = Localize("/SF/Language/Progression/CharactersDesc", { NUM = v5.Count })
		end
	end

	return {
		Name = object:__wf_atom_8e9ac384("/SF/Language/Progression/ProgressionHeader_Discoveries", false),
		LoreFragments = loreFragments
	}
end

function GetLocationDiscoveryElement(_, p)
	return {
		Name = Localize("/SF/Language/Codex/Locations", nil),
		Icon = WeakResource("/SF/Interface/Graphics/WaypointMarkers/MapLocation.png"),
		Description = Localize("/SF/Language/Progression/LocationsDesc", {
			NUM = p.mDiscoveredLocations
		}),
		Count = p.mDiscoveredLocations,
		IsDiscovery = true
	}
end

function GetDracsElement(_, p)
	return {
		Name = Localize("/SF/Language/Progression/Dracs", nil),
		Icon = WeakResource("/SF/Interface/Graphics/StoreItems/Currency/Coin1.png"),
		Description = Localize("/SF/Language/Progression/LootDesc", { NUM = p.mRegularCredits }),
		Count = p.mRegularCredits,
		PreviousCount = p.mRegularCreditsPrevious,
		IsDracs = true
	}
end

function GetItemsElements(p, p2, p3)
	local itemTypes = {}
	local envoyInventoryControl = module2.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return itemTypes
	end

	local __wf_atom_259e7653 = envoyInventoryControl:__wf_atom_259e7653(true)

	for _, v5 in CATEGORIES do
		local subTypes = v5.SubTypes or {}
		local upgrades = {}

		if v5.ItemType == 4 then
			upgrades = __wf_atom_259e7653:GetUpgrades() or {}
			local v6 = __wf_atom_259e7653:__wf_atom_063f1444() or {}
			table.move(v6, 1, #v6, #upgrades + 1, upgrades)
		elseif v5.ItemType == 13 then
			upgrades = __wf_atom_259e7653:__wf_atom_49479502()
		elseif v5.ItemType == 11 then
			upgrades = __wf_atom_259e7653:__wf_atom_c84817dd()
		end

		for i = 1, #subTypes do
			local subType = subTypes[i]

			for _, v6 in ipairs(p2.mItemInfo) do
				if not (v6 ~= nil and v6.mItemType ~= nil and v6.mItemType:IsA(subType)) then
					continue
				end

				local itemType = module3.GetItemTypeWithStoreInfo(p, v6.mItemType, p3)

				if __wf_atom_7e8ad928(itemType) then
					continue
				end

				itemType.Description = Localize(itemType.Description, nil)
				itemType.IsLoot = true

				for j = 1, #upgrades do
					local upgrade = upgrades[j]

					if upgrade.mItemType ~= v6.mItemType then
						continue
					end

					itemType.Count = upgrade.mItemCount or 1
					itemType.StartCount = itemType.Count - v6.mItemCount

					if itemType.StartCount < 0 then
						itemType.StartCount = 0
					end

					break
				end

				itemType.Count = itemType.Count or 0
				itemType.StartCount = itemType.StartCount or 0

				if itemType.Count - itemType.StartCount > 0 then
					table.insert(itemTypes, itemType)
				end
			end
		end
	end

	return itemTypes
end