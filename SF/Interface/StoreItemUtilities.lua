module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.ModularWeaponUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("SF.Interface.Components.StatCompare")
local v = WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")
local v2 = WeakResource("/Lotus/Upgrades/Skins/UnlockAnimSetBase")
local v3 = WeakResource("/Lotus/Powersuits/Lotus/LotusSuit")
local v4 = WeakResource("/SF/Types/Items/Aspects/Tempers/BaseAspectTemper")
local _ = {
	"XPLocked.Gradient",
	"XPLocked.Bg",
	"XPLocked.Icon",
	"Price.PriceIcon",
	"Price.CreditsBG",
	"Owned.Checkmark",
	"Owned.ItemCountBG",
	"Wishlist.Icon",
	"Wishlist.ItemCountBG",
	"NameBg",
	"Schematic",
	"SaleTag",
	"SaleTag.Bg",
	"SaleTag.IconBg",
	"SaleTag.Icon",
	"Price.StrikeThrough",
	"CouponPrice.Arrows",
	"CouponPrice.PriceIcon",
	"CouponPrice.CreditsBG",
	"Blurer",
	"Featured",
	"BundleTag",
	"UGCTag"
}
local _ = {
	"XPLocked.Text",
	"XPLocked.Label",
	"XPLocked.ReqLevel",
	"Price.Credits",
	"Name",
	"NameRemaining",
	"Owned.ItemCount",
	"Wishlist.ItemCount",
	"SaleTag.Label",
	"SaleTag.TimeLeft",
	"SaleTag.Discount",
	"CouponPrice.Credits"
}
local v5 = {
	"/Lotus/Language/Menu/VoidProjectionQuality_Bronze",
	"/Lotus/Language/Menu/VoidProjectionQuality_Silver",
	"/Lotus/Language/Menu/VoidProjectionQuality_Gold",
	"/Lotus/Language/Menu/VoidProjectionQuality_Platinum"
}
local _ = { "<MANUFACTURER_VIDAR>", "<MANUFACTURER_ZEKTI>", "<MANUFACTURER_LAVAN>" }
local v6 = {
	MK = { I = Symbol("MKI"), II = Symbol("MKII"), III = Symbol("MKIII") },
	AP = {
		LAVAN = Symbol("Lavan"),
		VIDAR = Symbol("Vidar"),
		ZEKTI = Symbol("Zekti"),
		SIGMA = Symbol("Sigma")
	}
}
local v7 = {}
local fn
local fn2
local v8 = nil
local v9 = nil
LENS_BLUEPRINT_HACK_TYPES = {
	{
		BaseType = WeakResource("/Lotus/Types/Recipes/Lens/BaseLensOstronBlueprint"),
		GenericType = WeakResource("/Lotus/Types/Recipes/Lens/GenericLensOstronBlueprint"),
		IngredientType = WeakResource("/Lotus/Types/Items/MiscItems/FocusLensGreater"),
		IngredientMap = {
			["/Lotus/Upgrades/Focus/AttackLensGreater"] = WeakResource("/Lotus/Types/Recipes/Lens/AttackLensOstronBlueprint"),
			["/Lotus/Upgrades/Focus/DefenseLensGreater"] = WeakResource("/Lotus/Types/Recipes/Lens/DefenseLensOstronBlueprint"),
			["/Lotus/Upgrades/Focus/PowerLensGreater"] = WeakResource("/Lotus/Types/Recipes/Lens/PowerLensOstronBlueprint"),
			["/Lotus/Upgrades/Focus/TacticLensGreater"] = WeakResource("/Lotus/Types/Recipes/Lens/TacticLensOstronBlueprint"),
			["/Lotus/Upgrades/Focus/WardLensGreater"] = WeakResource("/Lotus/Types/Recipes/Lens/WardLensOstronBlueprint")
		}
	},
	{
		BaseType = WeakResource("/Lotus/Types/Recipes/Lens/BaseLensLuaBlueprint"),
		GenericType = WeakResource("/Lotus/Types/Recipes/Lens/GenericLensLuaBlueprint"),
		IngredientType = WeakResource("/Lotus/Types/Items/MiscItems/FocusLensOstron"),
		IngredientMap = {
			["/Lotus/Upgrades/Focus/AttackLensOstron"] = WeakResource("/Lotus/Types/Recipes/Lens/AttackLensLuaBlueprint"),
			["/Lotus/Upgrades/Focus/DefenseLensOstron"] = WeakResource("/Lotus/Types/Recipes/Lens/DefenseLensLuaBlueprint"),
			["/Lotus/Upgrades/Focus/PowerLensOstron"] = WeakResource("/Lotus/Types/Recipes/Lens/PowerLensLuaBlueprint"),
			["/Lotus/Upgrades/Focus/TacticLensOstron"] = WeakResource("/Lotus/Types/Recipes/Lens/TacticLensLuaBlueprint"),
			["/Lotus/Upgrades/Focus/WardLensOstron"] = WeakResource("/Lotus/Types/Recipes/Lens/WardLensLuaBlueprint")
		}
	}
}

local function fn3(instance, _)
	local iconTexture

	if __wf_atom_7e8ad928(instance) then
		return iconTexture, false
	end

	iconTexture = instance:GetIconTexture()

	if instance:IsA(__wf_atom_f3c8513b) or instance:IsA(__wf_atom_cb425ff5) then
		return iconTexture, not instance:__wf_atom_c9969a68()
	end

	return iconTexture, false
end

function GetIconTexture(p, p2)
	return fn3(p, p2)
end

local function fn4(list, object, p)
	if __wf_atom_7e8ad928(list) then
		return nil
	end

	for i = 1, #list do
		local v10 = list[i]

		if not SF.__wf_atom_c4e2c759(v10) then
			continue
		end

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_232fd31d = object:__wf_atom_232fd31d(v10)

			if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				return fn3(__wf_atom_232fd31d, p)
			end
		end

		return fn3(Resource(v10), p)
	end

	return nil
end

function GetModularWeaponIcon(p, p2, p3)
	return fn4(p, p2, p3)
end

local function fn5(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if not __wf_atom_7e8ad928(object:GetItem()) then
		__wf_atom_5b41f63b = object:GetItem():__wf_atom_5b41f63b()
	end

	return (WeakResource(__wf_atom_5b41f63b))
end

function GetWishlistItem(p)
	return (fn5(p))
end

local function fn6(item, instance)
	if __wf_atom_7e8ad928(item) then
		return false
	end

	local v10 = item:IsA(__wf_atom_87580f1c)
		or item:IsA(__wf_atom_9df43583)
		or item:IsA(__wf_atom_77e05d3b)
		or item:IsA(__wf_atom_d98e64fe)
		or item:IsA(__wf_atom_3ad9dd38)
		or item:IsA(__wf_atom_abf506db)
		or item:IsA(__wf_atom_1642e02b)
		or item:IsA(__wf_atom_9f051930)
		or item:IsA(__wf_atom_01e60b5b)
		or item:IsA(v2)
		or item:IsA(__wf_atom_9ae7d6a1)
		or item:IsA(__wf_atom_a990d07f)
	return not (not __wf_atom_7e8ad928(instance) and instance:IsA(v3)) and v10
end

local function fn7() -- 1 equivalent call inferred from this helper
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	else
		return (__wf_atom_eab484a7:__wf_atom_68e5506c())
	end
end

local function fn8(object, result, instance, storeItem, instance2, data, p)
	local v10 = false

	if not __wf_atom_7e8ad928(instance) then
		local v11 = false

		if __wf_atom_7e8ad928(storeItem) then
			if not (__wf_atom_7e8ad928(instance2) or __wf_atom_1ef90898(instance2)) then
				local __wf_atom_efa6f447 = instance2:__wf_atom_efa6f447()
				v11 = __wf_atom_efa6f447 == 46 or __wf_atom_efa6f447 == 43
			end
		else
			local __wf_atom_efa6f447 = storeItem:__wf_atom_efa6f447()
			v11 = __wf_atom_efa6f447 == 46 or __wf_atom_efa6f447 == 43
		end

		if instance:IsA(__wf_atom_98b033ca) then
			local v12 = fn7() -- inferred equivalent call

			if __wf_atom_7e8ad928(v12) and not __wf_atom_7e8ad928(data.GameData) then
				v12 = data.GameData:__wf_atom_99b33b36()
			end

			if __wf_atom_7e8ad928(v12) then
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Items/DojoColorPigment", false, {
					COLOUR_NAME = ""
				})
				local v13 = __wf_atom_7e8ad928(p) and true or p

				if result ~= nil and (v13 or result.Name == nil) then
					result.Name = __wf_atom_8e9ac384
				end
			else
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Items/DojoColorPigment", false, {
					COLOUR_NAME = Localize(tostring(v12:__wf_atom_014a76a2()), {})
				})
				local v13 = __wf_atom_7e8ad928(p) and true or p

				if result ~= nil and (v13 or result.Name == nil) then
					result.Name = __wf_atom_8e9ac384
				end

				result.Material = module.Ternary(
					data.GetVisibilityMaterial,
					_G.UIMaterial_PigmentVisibilityRange,
					_G.UIMaterial_Pigment
				)
				result.Color = v12:GetColor()
			end

			v10 = true
		elseif instance:IsA(__wf_atom_f6dea198) then
			local v12 = Resource(instance)
			result.Material = module2.GetPolarityInfoForLens(v12, data.GetVisibilityMaterial, data.DepthTest).Material
			result.mForceThemed = true
			v10 = true
		elseif instance:IsA(v) then
			local v12 = 0

			if result.Type:IsA(__wf_atom_3cecff09) and not __wf_atom_7e8ad928(storeItem) then
				local __wf_atom_e622b3f6 = storeItem:__wf_atom_e622b3f6()

				if not __wf_atom_7e8ad928(__wf_atom_e622b3f6) then
					v12 = __wf_atom_e622b3f6:__wf_atom_a8dac107()
				end
			elseif not __wf_atom_7e8ad928(storeItem) then
				v12 = storeItem:__wf_atom_a8dac107()
			end

			local v13 = v12 + 1
			local uiMaterial_CosmeticEnhancers = _G.UIMaterial_CosmeticEnhancers

			if data.DepthTest then
				uiMaterial_CosmeticEnhancers = module.Ternary(
					data.Horizontal,
					_G.UIMaterial_CosmeticEnhancersStoreDepthHorizontal,
					_G.UIMaterial_CosmeticEnhancersStoreDepth
				)
			elseif data.GetVisibilityMaterial then
				uiMaterial_CosmeticEnhancers = module.Ternary(
					data.Horizontal,
					_G.UIMaterial_CosmeticEnhancersStoreHorizontal,
					_G.UIMaterial_CosmeticEnhancersStore
				)
			end

			result.Material = uiMaterial_CosmeticEnhancers[v13]
			v10 = true
		elseif v11 then
			if not data.SalvageRepaired then
				result.Material = _G.UIMaterial_SalvageMaterials[1]

				if data.DepthTest then
					result.Material = module.Ternary(
						data.Horizontal,
						_G.UIMaterial_SalvageMaterials[5],
						_G.UIMaterial_SalvageMaterials[3]
					)
				elseif data.GetVisibilityMaterial then
					result.Material = module.Ternary(
						data.Horizontal,
						_G.UIMaterial_SalvageMaterials[4],
						_G.UIMaterial_SalvageMaterials[2]
					)
				end

				local v12

				if
					result.RawItem == nil
					or result.RawItem.mItemCount == nil
					and result.RawItem.itemCount == nil
					and (result.RawItem.Item == nil or result.RawItem.Item.mItemCount == nil)
				then
					v12 = "<SALVAGE> "
				else
					v12 = "<RAW_SALVAGE> "
					local localizedDesc = result.LocalizedDesc .. "\r\n\r\n" .. object:__wf_atom_8e9ac384(
						"/Lotus/Language/Railjack/IdentifyRawSalvageDesc",
						true
					)
					local v13 = __wf_atom_7e8ad928(p) and true or p

					if result ~= nil and (v13 or result.LocalizedDesc == nil) then
						result.LocalizedDesc = localizedDesc
					end
				end

				if __wf_atom_7e8ad928(storeItem) then
					local name = object:__wf_atom_8e9ac384(v12, true) .. object:__wf_atom_8e9ac384(
						tostring(instance2:__wf_atom_014a76a2()),
						true
					)
					local v13 = __wf_atom_7e8ad928(p) and true or p

					if result ~= nil and (v13 or result.Name == nil) then
						result.Name = name
					end
				else
					local name = object:__wf_atom_8e9ac384(v12, true) .. object:__wf_atom_8e9ac384(
						tostring(storeItem:__wf_atom_014a76a2()),
						true
					)
					local v13 = __wf_atom_7e8ad928(p) and true or p

					if result ~= nil and (v13 or result.Name == nil) then
						result.Name = name
					end
				end

				result.Background = _G.UITexture_Salvage
			end

			v10 = true
		end

		if v10 and result.Name == nil then
			if __wf_atom_7e8ad928(storeItem) then
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(tostring(instance2:__wf_atom_014a76a2()), true)
				local v12 = __wf_atom_7e8ad928(p) and true or p

				if result ~= nil and (v12 or result.Name == nil) then
					result.Name = __wf_atom_8e9ac384
				end
			else
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_014a76a2()), true)
				local v12 = __wf_atom_7e8ad928(p) and true or p

				if result ~= nil and (v12 or result.Name == nil) then
					result.Name = __wf_atom_8e9ac384
				end
			end
		end
	end

	if not v10 then
		return v10
	end

	local v11

	if storeItem then
		local v12 = tostring(storeItem:__wf_atom_5e0d90e8())

		if __wf_atom_7e8ad928(v12) or v12 == "" then
			v12 = storeItem:__wf_atom_3a3d2e39()
		end

		v11 = tostring(v12)
	else
		v11 = ""
	end

	if v11 == "" then
		result.ToolTip = result.Name
	else
		result.ToolTip = tostring(v11)
		return v10
	end

	return v10
end

local function fn9(object, object2, object3, _)
	local __wf_atom_e9c6f474 = object:__wf_atom_e9c6f474()
	local __wf_atom_e8638878 = object:__wf_atom_e8638878()
	local count = 0

	if __wf_atom_7e8ad928(object3) or __wf_atom_7e8ad928(object2) then
		return -1, -1
	end

	local __wf_atom_e774be61 = object:__wf_atom_e774be61()
	local count2 = 0

	for i, v10 in ipairs(__wf_atom_e774be61) do
		if __wf_atom_7e8ad928(v10) then
			continue
		end

		count2 += 1

		if not object2:__wf_atom_7c97c0aa(i - 1) then
			continue
		end

		local __wf_atom_232fd31d = object3:__wf_atom_232fd31d(v10)

		if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
			continue
		end

		__wf_atom_e9c6f474 += __wf_atom_232fd31d:__wf_atom_e9c6f474()
		__wf_atom_e8638878 += __wf_atom_232fd31d:__wf_atom_e8638878()
		count += 1
	end

	local __wf_atom_29c97285 = object:__wf_atom_29c97285()
	local v10 = 1 + (not (count2 > 0) and 0 or count / count2) * __wf_atom_29c97285
	return module.Round(__wf_atom_e9c6f474 * v10), module.Round(__wf_atom_e8638878 * v10), count, __wf_atom_e774be61
end

function GetFusionTreasureValue(p, p2, p3, p4)
	return fn9(p, p2, p3, p4)
end

local function fn10(result, p, p2, p3) -- 11 equivalent calls inferred from this helper
	local v10 = __wf_atom_7e8ad928(p3) and true or p3

	if result ~= nil and (v10 or result[p] == nil) then
		result[p] = p2
	end
end

local function fn11(object, storeItem, instance, p, p2, p3, p4)
	if __wf_atom_7e8ad928(storeItem) and __wf_atom_1ef90898(instance) then
		return
	end

	local v10 = __wf_atom_7e8ad928(p) and {} or p
	local result = not v10.AppendInfo and {} or v10.AppendInfo

	if not __wf_atom_7e8ad928(storeItem) then
		result.IsNew = math.abs((Engine.__wf_atom_db2b0cee(storeItem:__wf_atom_9fc42d94()))) <= 3628800
		result.TimeSinceAdded = storeItem:__wf_atom_9fc42d94()
	end

	if instance then
		if __wf_atom_7e8ad928(v10.OverrideExisting) then
			v10.OverrideExisting = true
		end

		result.StoreItem = storeItem
		result.Type = instance
		result.FullName = instance:__wf_atom_5b41f63b()
		result.CatItemType = instance
		result.BackgroundAlpha = 25
		local itemInfo = v10.ItemInfo

		if itemInfo and itemInfo.Name then
			result.Name = itemInfo.Name
		end

		if result.Description == nil or v10.OverrideExisting then
			if storeItem then
				result.Description = tostring(storeItem:__wf_atom_3a3d2e39())
			elseif instance then
				result.Description = tostring(instance:__wf_atom_3a3d2e39())
			end
		end

		if result.Description ~= nil then
			local v11 = nil

			if storeItem and storeItem:IsA(__wf_atom_bf37f5ca) then
				local __wf_atom_d1d012ee = storeItem:__wf_atom_d1d012ee()
				v11 = __wf_atom_d1d012ee > 0 and { AMOUNT = __wf_atom_d1d012ee } or v11
			elseif storeItem and storeItem:__wf_atom_efa6f447() == 19 then
				local __wf_atom_987be644 = storeItem:__wf_atom_987be644()
				local __wf_atom_121506d6 = __wf_atom_c67f9605:__wf_atom_121506d6(__wf_atom_987be644)
				local current = gGameData:GetInventory():__wf_atom_21e5b95f(__wf_atom_987be644) + __wf_atom_121506d6
				local __wf_atom_17d97bf6 = storeItem:__wf_atom_17d97bf6()
				local MAX_BIN_SLOTS = __wf_atom_c67f9605:__wf_atom_dae75ebc(__wf_atom_987be644) + __wf_atom_121506d6

				if MAX_BIN_SLOTS == 0 then
					MAX_BIN_SLOTS = module2.MAX_BIN_SLOTS
				end

				v11 = {
					QUANTITY = math.min(MAX_BIN_SLOTS - current, __wf_atom_17d97bf6),
					CURRENT = current,
					MAX = MAX_BIN_SLOTS
				}
			end

			result.LocalizedDesc = object:__wf_atom_8e9ac384(result.Description, true, v11)
		end

		if itemInfo ~= nil and not __wf_atom_7e8ad928(itemInfo.mModularParts) then
			if result.LocalizedDesc == nil then
				result.LocalizedDesc = ""
			end

			result.LocalizedDesc ..= "\r\n\r\n"
			local v11 = {}

			for _, mModularPart in ipairs(itemInfo.mModularParts) do
				table.insert(v11, mModularPart)
			end

			if
				not __wf_atom_7e8ad928(itemInfo.Item)
				and not __wf_atom_7e8ad928(itemInfo.Item.mDetails)
				and #itemInfo.Item.mDetails.mInheritedModularParts > 0
			then
				for _, mInheritedModularPart in ipairs(itemInfo.Item.mDetails.mInheritedModularParts) do
					table.insert(v11, mInheritedModularPart)
				end
			end

			local partsText, searchTags = module3.GetPartsText(object, v11, p2, false, true, true)
			result.LocalizedDesc ..= partsText
			result.SearchTags = searchTags
		end

		if v10.Category then
			result.Category = v10.Category
		elseif storeItem then
			result.Category = storeItem:__wf_atom_efa6f447()

			if
				result.Type:IsA(__wf_atom_3cecff09)
				and (storeItem:IsA(__wf_atom_bf37f5ca) or storeItem:IsA(__wf_atom_3cecff09))
			then
				result.Category = storeItem:__wf_atom_d4d67b38()
			end
		end

		if result.Category then
			result.SortCategory = result.Category
		end

		if __wf_atom_7e8ad928(result.RawItem) and not __wf_atom_7e8ad928(itemInfo) then
			result.RawItem = itemInfo
		end

		if result.Count == nil then
			result.Count = 1

			if itemInfo then
				if itemInfo.mItemCount then
					result.Count = itemInfo.mItemCount
				elseif itemInfo.itemCount then
					result.Count = itemInfo.itemCount
				elseif itemInfo.Count then
					result.Count = itemInfo.Count
				end
			end
		end

		if v10.HideRecipesInUse and not __wf_atom_7e8ad928(v10.GameData) and result.Type:IsA(__wf_atom_3cecff09) then
			local __wf_atom_b3b611ab = v10.GameData:__wf_atom_b3b611ab(result.Type)

			for i = 1, #LENS_BLUEPRINT_HACK_TYPES do
				local v11 = LENS_BLUEPRINT_HACK_TYPES[i]

				if v11.GenericType ~= result.Type then
					continue
				end

				for _, v12 in pairs(v11.IngredientMap) do
					__wf_atom_b3b611ab += v10.GameData:__wf_atom_b3b611ab(v12)
				end

				break
			end

			result.Count -= __wf_atom_b3b611ab
		end

		if storeItem then
			local isXPLocked, reqLevel = module2.IsXPLocked(storeItem)
			result.XPLocked = isXPLocked
			result.ReqLevel = reqLevel
			result.IsExternalProduct = module2.GetProductId(storeItem) ~= ""
				and module2.CheckSteamPurchaseAvailability(storeItem) ~= "MARKET"
		end

		if result.Type:IsA(v4) then
			local __wf_atom_de8272d7 = storeItem:__wf_atom_de8272d7()
			result.mBgRatio = not (__wf_atom_de8272d7 > 0) and 1
				or __wf_atom_421b01aa(result.Count / __wf_atom_de8272d7, 0, 1)
		end

		local v11

		if result.Type:IsA(__wf_atom_3cecff09) then
			local kind = result.Type
			local toolTip = ""
			local uiTexture_Blueprint = _G.UITexture_Blueprint

			if __wf_atom_7e8ad928(storeItem) then
				result.ResultItemType = kind:__wf_atom_c5566ef8()
				result.ResultStoreItem = kind:__wf_atom_e622b3f6()
			else
				result.ResultItemType = storeItem:__wf_atom_c5566ef8()
				result.ResultStoreItem = storeItem:__wf_atom_e622b3f6()
				result.InfiniteCharges = not storeItem:__wf_atom_7a2dbfd5()

				if storeItem:__wf_atom_7a2dbfd5() and not storeItem:AlwaysAvailable() then
					result.BlueprintBgColor = _G.UIColor_White
				else
					result.BlueprintBgColor = _G.UIColor_UnlimitedUseBP
					uiTexture_Blueprint = _G.UITexture_ReusableBlueprint
				end

				result.BackgroundAlpha = 60
			end

			local v12

			if __wf_atom_7e8ad928(result.ResultStoreItem) then
				if storeItem then
					v12 = tostring(storeItem:__wf_atom_014a76a2())
				else
					v12 = tostring(instance:__wf_atom_014a76a2())
				end

				if result.SortCategory then
					local sortCategory = result.SortCategory
					local _type = result.Type
					result.SortCategory = sortCategory
				end
			else
				if storeItem then
					toolTip = object:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_619b1891()), false)
				end

				v12 = tostring(result.ResultStoreItem:__wf_atom_014a76a2())
				result.CatItemType = result.ResultItemType
				local __wf_atom_efa6f447 = result.ResultStoreItem:__wf_atom_efa6f447()
				local _resultItemType = result.ResultItemType

				if __wf_atom_c67f9605:__wf_atom_8c8df26f(__wf_atom_efa6f447) == 6 then
					result.SortCategory = __wf_atom_efa6f447
				end

				local v13 = tostring(result.ResultStoreItem:__wf_atom_5e0d90e8())

				if __wf_atom_7e8ad928(v13) or v13 == "" then
					v13 = result.ResultStoreItem:__wf_atom_3a3d2e39()
				end

				local v14 = tostring(v13)

				if v14 == "" then
					result.ToolTip = toolTip
				else
					result.ToolTip = tostring(v14)
				end
			end

			local __wf_atom_1dd35883 = storeItem:__wf_atom_1dd35883()
			result.mBgRatio = (not (__wf_atom_1dd35883 > 0) or storeItem:AlwaysAvailable()) and 1
				or __wf_atom_421b01aa(result.Count / __wf_atom_1dd35883, 0, 1)

			if toolTip == "" then
				local v13 = {
					ITEM = object:__wf_atom_8e9ac384(v12, true)
				}

				if storeItem and storeItem:__wf_atom_d1d012ee() > 1 then
					v13.NUM = storeItem:__wf_atom_d1d012ee()
					fn10( -- inferred equivalent call
						result,
						"NameUndecorated",
						object:__wf_atom_8e9ac384("/SF/Language/Items/LargeBatchBlueprintAndItem", true, v13),
						v10.OverrideExisting
					)
					fn10( -- inferred equivalent call
						result,
						"Name",
						object:__wf_atom_8e9ac384("/SF/Language/Items/LargeBatchBlueprintAndItem", true, {
							ITEM = object:__wf_atom_8e9ac384("/SF/Language/Items/BlueprintAndItem", true, v13),
							NUM = storeItem:__wf_atom_d1d012ee()
						}),
						v10.OverrideExisting
					)
				else
					fn10( -- inferred equivalent call
						result,
						"Name",
						object:__wf_atom_8e9ac384("/SF/Language/Items/BlueprintAndItem", true, v13),
						v10.OverrideExisting
					)
					fn10(result, "NameUndecorated", object:__wf_atom_8e9ac384(v12, true), v10.OverrideExisting) -- inferred equivalent call
				end
			else
				fn10(result, "Name", toolTip, v10.OverrideExisting) -- inferred equivalent call
				fn10(result, "NameUndecorated", toolTip, v10.OverrideExisting) -- inferred equivalent call
			end

			if __wf_atom_7e8ad928(storeItem) or not storeItem:__wf_atom_92a55f32() then
				result.Background = uiTexture_Blueprint
			end

			fn8(object, result, result.ResultItemType, storeItem, instance, v10, false)
			v11 = p4 or result.mForceThemed

			if __wf_atom_7e8ad928(storeItem) then
				local recipeIconTexture, themed = module2.GetRecipeIconTexture(instance)
				result.Icon = recipeIconTexture
				result.Themed = themed
			else
				local iconTexture, themed

				if __wf_atom_7e8ad928(storeItem) then
					themed = false
				else
					iconTexture = storeItem:GetIconTexture()

					if storeItem:IsA(__wf_atom_f3c8513b) or storeItem:IsA(__wf_atom_cb425ff5) then
						themed = not storeItem:__wf_atom_c9969a68()
					else
						themed = false
					end
				end

				result.Icon = iconTexture
				result.Themed = themed
			end
		else
			local v12 = fn8(object, result, result.Type, storeItem, instance, v10, v10.OverrideExisting)
			v11 = p4 or result.mForceThemed

			if not v12 then
				if storeItem then
					if result.Category == 26 and result.RawItem ~= nil then
						local mName = result.RawItem.mName

						if mName == "" then
							local kubrowTypesTable = module2.GetKubrowTypesTable()

							for i = 1, #kubrowTypesTable do
								if kubrowTypesTable[i].Type ~= result.RawItem.mDominantTraits.mPersonality then
									continue
								end

								mName = object:__wf_atom_8e9ac384(kubrowTypesTable[i].Name, false)
								break
							end
						end

						local __wf_atom_8e9ac384, v13 = object:__wf_atom_8e9ac384(
							storeItem:__wf_atom_014a76a2():c_str(),
							true,
							{ NAME = mName }
						)
						fn10(result, "Name", __wf_atom_8e9ac384, v13) -- inferred equivalent call
					elseif storeItem:__wf_atom_efa6f447() == 35 then
						local v13 = -storeItem:__wf_atom_ee4fa4fd() * storeItem:__wf_atom_17d97bf6() * result.Count .. " " .. object:__wf_atom_8e9ac384(
							tostring(storeItem:__wf_atom_014a76a2()),
							true
						)
						result.Count = 1
						fn10(result, "Name", v13, v10.OverrideExisting) -- inferred equivalent call
					else
						fn10( -- inferred equivalent call
							result,
							"Name",
							object:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_014a76a2()), true),
							v10.OverrideExisting
						)
					end

					local v13 = tostring(storeItem:__wf_atom_5e0d90e8())

					if __wf_atom_7e8ad928(v13) or v13 == "" then
						v13 = storeItem:__wf_atom_3a3d2e39()
					end

					local v14 = tostring(v13)

					if v14 == "" then
						result.ToolTip = result.Name
					else
						result.ToolTip = tostring(v14)
					end
				elseif instance:__wf_atom_efa6f447() == 35 then
					local v13 = -instance:__wf_atom_ee4fa4fd() * result.Count .. object:__wf_atom_8e9ac384(
						tostring(instance:__wf_atom_014a76a2()),
						true
					)
					result.Count = 1
					fn10(result, "Name", v13, v10.OverrideExisting) -- inferred equivalent call
				else
					fn10( -- inferred equivalent call
						result,
						"Name",
						object:__wf_atom_8e9ac384(tostring(instance:__wf_atom_014a76a2()), true),
						v10.OverrideExisting
					)
				end
			end

			if result.RawItem ~= nil and result.RawItem.mItemName ~= nil and result.RawItem.mItemName ~= "" then
				result.Name = result.RawItem.mItemName

				if not __wf_atom_7e8ad928(result.RawItem.mUpgradeType) then
					result.Name = object:__wf_atom_8e9ac384("<KUVA_LICH> ", true) .. result.Name
				end
			end

			if result.RawItem ~= nil then
				__wf_atom_7e8ad928(result.RawItem.Nemesis)
			end

			if result.RawItem == nil or result.RawItem.mModularParts == nil or result.Category == 26 then
				if storeItem then
					local iconTexture, themed

					if __wf_atom_7e8ad928(storeItem) then
						themed = false
					else
						iconTexture = storeItem:GetIconTexture()

						if storeItem:IsA(__wf_atom_f3c8513b) or storeItem:IsA(__wf_atom_cb425ff5) then
							themed = not storeItem:__wf_atom_c9969a68()
						else
							themed = false
						end
					end

					result.Icon = iconTexture
					result.Themed = themed
				else
					local iconTexture, themed

					if __wf_atom_7e8ad928(instance) then
						themed = false
					else
						iconTexture = instance:GetIconTexture()

						if instance:IsA(__wf_atom_f3c8513b) or instance:IsA(__wf_atom_cb425ff5) then
							themed = not instance:__wf_atom_c9969a68()
						else
							themed = false
						end
					end

					result.Icon = iconTexture
					result.Themed = themed
				end
			elseif result.Type == nil or not result.Type:IsA(__wf_atom_202871eb) then
				local icon, themed = fn4(result.RawItem.mModularParts, p2, v11)
				result.Icon = icon
				result.Themed = themed
			else
				local iconTexture, themed

				if __wf_atom_7e8ad928(storeItem) then
					themed = false
				else
					iconTexture = storeItem:GetIconTexture()

					if storeItem:IsA(__wf_atom_f3c8513b) or storeItem:IsA(__wf_atom_cb425ff5) then
						themed = not storeItem:__wf_atom_c9969a68()
					else
						themed = false
					end
				end

				result.Icon = iconTexture
				result.Themed = themed
			end

			if result.SortCategory then
				local sortCategory = result.SortCategory
				local _type = result.Type
				result.SortCategory = sortCategory
			end
		end

		if result.Themed or not _T.HighlightDeprecatedIcons then
			if
				result.IconColor == nil
				and v11
				and not __wf_atom_7e8ad928(storeItem)
				and storeItem:__wf_atom_7941efb7()
			then
				result.IconColor = 6
			end
		else
			result.IconColor = "0xF700D6"
		end

		if itemInfo then
			local mXp = itemInfo.mXp or itemInfo.mXP or itemInfo.xp or itemInfo.Xp

			if itemInfo.mPolarized ~= nil then
				result.Polarized = itemInfo.mPolarized
			end

			local v12

			if result.Polarized == nil then
				v12 = __wf_atom_c67f9605:__wf_atom_7da755e9(result.Type, 0)
			else
				v12 = __wf_atom_c67f9605:__wf_atom_7da755e9(result.Type, result.Polarized)
			end

			if itemInfo.Rank then
				result.Rank = math.min(v12, itemInfo.Rank)
			elseif mXp then
				result.Rank = math.min(v12, __wf_atom_c67f9605:__wf_atom_b4a75eaa(mXp, result.Type))
			end

			if mXp then
				result.Xp = mXp
			end

			if itemInfo.mItemId and itemInfo.mItemId.mId ~= "" then
				result.UID = itemInfo.mItemId.mId
			end

			if itemInfo.mUpgradeFingerprint then
				result.Fingerprint = itemInfo:__wf_atom_91d9f0e3()
			end
		end

		if storeItem then
			local __wf_atom_69dc9a11 = storeItem:__wf_atom_69dc9a11()
			local __wf_atom_e9c6f474 = storeItem:__wf_atom_e9c6f474()
			local __wf_atom_e8638878 = storeItem:__wf_atom_e8638878()

			if storeItem:__wf_atom_efa6f447() == 34 then
				local matchedSockets, sockets
				__wf_atom_e9c6f474, __wf_atom_e8638878, matchedSockets, sockets = fn9(storeItem, itemInfo, p2, p3)
				result.Sockets = sockets
				result.MatchedSockets = matchedSockets
			end

			if __wf_atom_69dc9a11 and __wf_atom_69dc9a11 ~= 0 then
				result.IsPrimePart = true
			end

			if v10.UsePrimeBucks then
				__wf_atom_e9c6f474 = __wf_atom_69dc9a11
			elseif v10.UseFusionPoints then
				__wf_atom_e9c6f474 = __wf_atom_e8638878
			elseif v10.UseFocusPoints then
				__wf_atom_e9c6f474 = storeItem:__wf_atom_f8af7672()
			elseif
				result.Category == 4
				and not (__wf_atom_7e8ad928(itemInfo) or __wf_atom_7e8ad928(itemInfo.mInstance))
			then
				__wf_atom_e9c6f474 = itemInfo.mInstance:__wf_atom_964b656f(itemInfo.mUpgradeFingerprint)
			end

			if __wf_atom_e9c6f474 ~= 0 then
				result.SellingPrice = __wf_atom_e9c6f474
			end

			if __wf_atom_e8638878 ~= 0 then
				result.FusionPointValue = __wf_atom_e8638878
			end
		end

		if
			v10.CheckKeyChain
			and (result.Category == 13 or result.Category == 11)
			and not __wf_atom_7e8ad928(v10.GameData)
			and storeItem
			and storeItem:__wf_atom_27930455()
			and storeItem:__wf_atom_5b24a01b()
		then
			local __wf_atom_5b24a01b = storeItem:__wf_atom_5b24a01b()
			local inventory = v10.GameData:GetInventory()

			if not __wf_atom_7e8ad928(inventory) then
				local __wf_atom_fe84572e = inventory:__wf_atom_fe84572e()

				for i = 1, #__wf_atom_fe84572e do
					if __wf_atom_5b24a01b ~= __wf_atom_fe84572e[i].mItemType then
						continue
					end

					if __wf_atom_fe84572e[i].mCompleted then
						break
					end

					result.PreventSelling = true
					break
				end
			end
		end

		if
			not __wf_atom_7e8ad928(result.RawItem)
			and v10.CheckTimeLimited
			and (result.Category == 0 or result.Category == 1 or result.Category == 5 or result.Category == 3 or result.Category == 15 or result.Category == 16 or result.Category == 6 or result.Category == 27 or result.Category == 28 or result.Category == 29)
			and result.RawItem:__wf_atom_ae27679c()
		then
			result.WillExpire = true
			result.PreventSelling = true
		end

		if result.Type:IsA(__wf_atom_6317e6dc) then
			local __wf_atom_966277ef = Resource(result.Type):__wf_atom_966277ef()

			if __wf_atom_966277ef ~= 0 then
				result.Name ..= " [" .. object:__wf_atom_8e9ac384(v5[__wf_atom_966277ef + 1], false) .. "]"
			end
		end

		return result
	else
		if not storeItem then
			return
		end

		result.StoreItem = storeItem
		result.Category = storeItem:__wf_atom_efa6f447()
		result.SortCategory = result.Category

		if __wf_atom_7e8ad928(result.Count) then
			result.Count = 1
		end

		result.Name = GetLocalizedItemName(object, storeItem)
		result.Description = tostring(storeItem:__wf_atom_3a3d2e39())
		local v11 = {}

		if not __wf_atom_7e8ad928(storeItem) then
			storeItem:__wf_atom_17d97bf6()

			if storeItem:IsPackage() then
				local amount, _ = GetTotalBundledItemQuantity(storeItem:__wf_atom_72915748())

				if amount > 1 then
					v11.AMOUNT = amount
				end
			end
		end

		result.LocalizedDesc = object:__wf_atom_8e9ac384(result.Description, true, v11)
		local iconTexture, themed

		if __wf_atom_7e8ad928(storeItem) then
			themed = false
		else
			iconTexture = storeItem:GetIconTexture()

			if storeItem:IsA(__wf_atom_f3c8513b) or storeItem:IsA(__wf_atom_cb425ff5) then
				themed = not storeItem:__wf_atom_c9969a68()
			else
				themed = false
			end
		end

		result.Icon = iconTexture
		result.Themed = themed
		result.IsExternalProduct = module2.GetProductId(storeItem) ~= ""
			and module2.CheckSteamPurchaseAvailability(storeItem) ~= "MARKET"

		if not result.Themed and _T.HighlightDeprecatedIcons then
			result.IconColor = "0xF700D6"
		end

		return result
	end
end

function GetItemTypeInfo(p, catItemType, p2, p3)
	if catItemType then
		return fn11(p, nil, catItemType, p2, nil, nil, p3)
	end
end

function GetItemTypeWithStoreInfo(p, catItemType, object, p2, p3)
	if catItemType and not __wf_atom_7e8ad928(object) then
		return fn11(p, object:__wf_atom_232fd31d(catItemType), catItemType, p2, object, nil, p3)
	end
end

function GetStoreItemInfo(p, storeItem, p2, p3, p4, p5)
	if not storeItem then
		return
	end

	return fn11(p, storeItem, storeItem:GetItem(), p2, p3, p4, p5)
end

local function fn12(object, p, data, p2)
	if object and p and data and object:__wf_atom_253d7085(p) then
		local v10 = __wf_atom_7e8ad928(p2) and {} or p2
		local v11 = not __wf_atom_7e8ad928(data.Background)
		object:__wf_atom_7f57ab2f(p, "BackingTexture", 13, v11)
		object:__wf_atom_7f57ab2f(p, "RecipeBg", 13, v11)
		object:__wf_atom_7f57ab2f(p, "BlueprintIcon", 13, v11)
		object:__wf_atom_7f57ab2f(p, "ImageBg", 13, v11)
		object:__wf_atom_7f57ab2f(p, "BlueprintBg", 13, v11)
		object:__wf_atom_7f57ab2f(p, "Schematic", 13, v11)
		object:__wf_atom_7f57ab2f(
			p,
			"Image",
			13,
			module.Ternary(__wf_atom_7e8ad928(v10.IconVis), not __wf_atom_7e8ad928(data.Icon), v10.IconVis)
		)
		object:__wf_atom_7f57ab2f(
			p,
			"Icon",
			13,
			module.Ternary(__wf_atom_7e8ad928(v10.IconVis), not __wf_atom_7e8ad928(data.Icon), v10.IconVis)
		)
		local ternary = module.Ternary(data.BlueprintBgColor ~= nil, data.BlueprintBgColor, 16777215)

		if v10.CenterName then
			object:__wf_atom_7f57ab2f(p, "Name", 13, false)
			object:__wf_atom_48bd5a59(
				p,
				"NameCenter",
				46,
				module.Ternary(__wf_atom_7e8ad928(v10.NameVertAlign), "bottom", v10.NameVertAlign)
			)
			object:__wf_atom_50d60589(
				p .. ".NameCenter",
				36,
				module.Ternary(__wf_atom_7e8ad928(v10.Name), data.Name, v10.Name)
			)
		else
			object:__wf_atom_7f57ab2f(p, "NameCenter", 13, false)
			object:__wf_atom_48bd5a59(
				p,
				"Name",
				46,
				module.Ternary(__wf_atom_7e8ad928(v10.NameVertAlign), "bottom", v10.NameVertAlign)
			)
			object:__wf_atom_50d60589(
				p .. ".Name",
				36,
				module.Ternary(__wf_atom_7e8ad928(v10.Name), data.Name, v10.Name)
			)
		end

		object:__wf_atom_48bd5a59(p, "NameRemaining", 46, "bottom")
		object:__wf_atom_48bd5a59(p, "ItemName", 46, "bottom")
		object:__wf_atom_50d60589(
			p .. ".ItemName",
			36,
			module.Ternary(__wf_atom_7e8ad928(v10.Name), data.Name, v10.Name)
		)
		object:__wf_atom_4c1c1986(p, "BackingTexture", 11, ternary)
		object:__wf_atom_4c1c1986(p, "RecipeBg", 11, ternary)
		object:__wf_atom_4c1c1986(p, "BlueprintBg", 11, ternary)
		object:__wf_atom_4c1c1986(p, "Schematic", 11, ternary)

		if data.Count then
			local count = data.Count

			if tonumber(count) ~= nil then
				count = module.FormatNumber(count, v10.FormatCount)
			end

			object:__wf_atom_48bd5a59(p, "Count", 36, count)
			object:__wf_atom_48bd5a59(p, "ItemCount", 36, count)
		end

		object:__wf_atom_c90af43a(p .. ".BackingTexture", data.Background)
		object:__wf_atom_c90af43a(p .. ".RecipeBg", data.Background)
		object:__wf_atom_c90af43a(p .. ".BlueprintIcon", data.Background)
		object:__wf_atom_c90af43a(p .. ".ImageBg", data.Background)
		object:__wf_atom_c90af43a(p .. ".BlueprintBg", data.Background)
		object:__wf_atom_c90af43a(p .. ".Schematic", data.Background)
		object:__wf_atom_c90af43a(p .. ".Image", data.Icon)
		object:__wf_atom_c90af43a(p .. ".Shadow", data.Icon)
		object:__wf_atom_c90af43a(p .. ".Icon", data.Icon)
		object:__wf_atom_c90af43a(p .. ".PreviewItem", data.Icon)
		local material = nil

		if __wf_atom_7e8ad928(data.Material) then
			if not __wf_atom_7e8ad928(v10.Material) then
				material = v10.Material
			end
		else
			material = data.Material
		end

		object:OverrideMaterial(p .. ".Image", material)
		object:OverrideMaterial(p .. ".Icon", material)
		object:OverrideMaterial(p .. ".PreviewItem", material)

		if data.Color ~= nil then
			local v12 = data.Color.red / 255
			local v13 = data.Color.green / 255
			local v14 = data.Color.blue / 255
			object:__wf_atom_1ca72041(p .. ".Image", "DetailMapTint", v12, v13, v14, 1)
			object:__wf_atom_1ca72041(p .. ".Icon", "DetailMapTint", v12, v13, v14, 1)
			object:__wf_atom_1ca72041(p .. ".PreviewItem", "DetailMapTint", v12, v13, v14, 1)
		end

		if data.ExtraShaderVars ~= nil then
			for i = 1, #data.ExtraShaderVars do
				local extraShaderVar = data.ExtraShaderVars[i]
				Color()
				local v12

				if type(extraShaderVar.v) == "number" then
					v12 = module4.GetColor(data.ExtraShaderVars[i].v, false)
				else
					v12 = extraShaderVar.v
				end

				object:__wf_atom_1ca72041(
					p .. ".Image",
					data.ExtraShaderVars[i].k,
					v12.red / 255,
					v12.green / 255,
					v12.blue / 255,
					1
				)
				object:__wf_atom_1ca72041(
					p .. ".Icon",
					data.ExtraShaderVars[i].k,
					v12.red / 255,
					v12.green / 255,
					v12.blue / 255,
					1
				)
				object:__wf_atom_1ca72041(
					p .. ".PreviewItem",
					data.ExtraShaderVars[i].k,
					v12.red / 255,
					v12.green / 255,
					v12.blue / 255,
					1
				)
			end
		end
	end
end

local function fn13(object, p, data, p2)
	if p2 == nil then
		return
	end

	local item

	if not __wf_atom_7e8ad928(data.StoreItem) then
		if data.StoreItem:IsA(__wf_atom_bf37f5ca) then
			item = data.StoreItem:__wf_atom_c5566ef8()
		else
			item = data.StoreItem:GetItem()
		end
	end

	if
		data.Themed
		or not __wf_atom_7e8ad928(item)
		and (item:IsA(__wf_atom_87580f1c) or item:IsA(__wf_atom_746ce1f6) or item:IsA(__wf_atom_45781192) or item:IsA(__wf_atom_5a036296) or item:IsA(__wf_atom_3bda1628) or item:IsA(__wf_atom_f6dea198))
	then
		object:__wf_atom_4c1c1986(p, "Image", 15, p2)
		object:__wf_atom_4c1c1986(p, "Shadow", 15, p2)
	elseif data.IconWidth == nil or data.IconHeight == nil then
		object:__wf_atom_4c1c1986(p, "Image", 15, p2 / 1.5242)
		object:__wf_atom_4c1c1986(p, "Shadow", 15, p2 / 1.5242)
	else
		object:__wf_atom_4c1c1986(p, "Image", 14, data.IconWidth)
		object:__wf_atom_4c1c1986(p, "Image", 15, data.IconHeight)
		object:__wf_atom_4c1c1986(p, "Shadow", 14, data.IconWidth)
		object:__wf_atom_4c1c1986(p, "Shadow", 15, data.IconHeight)
	end
end

function DrawItem(object, p, p2, p3)
	fn12(object, p, p2, p3)

	if p2.mForceThemed then
		fn13(object, p, p2, object:__wf_atom_5e6e15c8(p .. ".Image", 14))
	end
end

local function fn14(p)
	if p.Sale ~= nil and p.Sale.mProductExpiryOverride ~= nil and p.Sale.mProductExpiryOverride.sec ~= "" then
		return p.Sale.mProductExpiryOverride.sec
	end

	if p.StoreItem == nil then
		return 0
	end

	return p.StoreItem:__wf_atom_befa6dbf()
end

function GetProductExpiryTime(p)
	return fn14(p)
end

local function fn15(object)
	local __wf_atom_72915748 = object:__wf_atom_72915748()
	local v10 = {}
	local v11 = {}
	local count = 0

	for i = 1, #__wf_atom_72915748 do
		local mTypeName = __wf_atom_72915748[i].mTypeName

		if __wf_atom_7e8ad928(mTypeName) then
			return false
		end

		local item = mTypeName:GetItem()
		local __wf_atom_efa6f447 = mTypeName:__wf_atom_efa6f447()
		local v12 = __wf_atom_efa6f447 == 8
			or not __wf_atom_7e8ad928(item) and (item:IsA(__wf_atom_39cfd03e) or item:IsA(__wf_atom_77eb9145))

		if __wf_atom_7e8ad928(item) or __wf_atom_efa6f447 == 30 then
			return false
		end

		if v12 then
			continue
		end

		if item:IsA(__wf_atom_abf506db) then
			for j = 0, 8 - 1 do
				if not mTypeName:__wf_atom_e84d016c(j) then
					continue
				end

				if v10[j] ~= nil then
					return false
				end

				v10[j] = true
			end
		elseif v11[__wf_atom_efa6f447] == nil then
			v11[__wf_atom_efa6f447] = true
		else
			return false
		end

		if not fn(mTypeName) then
			return false
		end

		count += 1
	end

	return not (v11[15] and v11[3]) and count > 0
end

fn = function(object)
	local item = object:GetItem()
	local __wf_atom_7c09e378 = object:__wf_atom_7c09e378()
	local __wf_atom_efa6f447 = object:__wf_atom_efa6f447()

	if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_3cecff09) then
		__wf_atom_efa6f447 = object:__wf_atom_d4d67b38()
		item = object:__wf_atom_c5566ef8()
	end

	local v10 = false or not __wf_atom_7e8ad928(object:__wf_atom_b62fb76b())

	if not v10 and object:IsPackage() then
		v10 = fn15(object)
	end

	if not v10 and __wf_atom_efa6f447 ~= 16 then
		return v10 or fn6(item, __wf_atom_7c09e378)
	end

	return v10
end

function CanShowDiorama(p)
	return fn(p)
end

local function fn16(p, p2)
	__wf_atom_83c14687()
	return p.type < p2.type
end

local function fn17(p, object, p2, itemInfo, useFusionPoints)
	local v10 = {}

	if __wf_atom_7e8ad928(p2) then
		return v10
	end

	local __wf_atom_232fd31d = object:__wf_atom_232fd31d(p2)

	if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
		return v10
	end

	v10 = fn11(
		p,
		__wf_atom_232fd31d,
		__wf_atom_232fd31d:GetItem(),
		{ UseFusionPoints = useFusionPoints, ItemInfo = itemInfo },
		object,
		nil,
		true
	)
	v10.StoreItem = __wf_atom_232fd31d
	v10.ItemInfo = itemInfo

	if not __wf_atom_7e8ad928(itemInfo) then
		v10.RawName = v10.Name
		v10.Name = module2.GetTreasureName(p, __wf_atom_232fd31d, itemInfo, v10.Name)
	end

	return v10
end

function GetTreasureElement(p, p2, p3, p4)
	return (fn17(p, p2, p3, p4))
end

local function fn18(list, p, object, p2, p3, useFusionPoints, p4)
	local result = {}

	if __wf_atom_7e8ad928(object) then
		return result
	end

	for i = 1, #list do
		if not (list[i].mItemCount > 0) then
			continue
		end

		local __wf_atom_232fd31d = object:__wf_atom_232fd31d(list[i].mItemType)

		if not (not p3 or not __wf_atom_7e8ad928(__wf_atom_232fd31d) and __wf_atom_232fd31d:__wf_atom_54893980()) then
			continue
		end

		local __wf_atom_4b2b635c = list[i]:__wf_atom_4b2b635c()

		if result[__wf_atom_4b2b635c] == nil then
			local v10 = fn17(p, object, list[i].mItemType, list[i], useFusionPoints)
			v10.Description = Localize(tostring(v10.StoreItem:__wf_atom_3a3d2e39()), {})

			if p4 then
				v10.Capacity = v10.StoreItem:__wf_atom_e23658d9(p3)
			end

			v10.Categories = { p2.ALL, p2.AYATAN }
			result[__wf_atom_4b2b635c] = v10
			result[__wf_atom_4b2b635c].Count = list[i].mItemCount
		else
			assert(false)
		end
	end

	return result
end

function BuildTreasureTable(p, p2, p3, p4, p5, p6)
	return (fn18(p, p2, p3, p4, p5, p6))
end

local function fn19() -- 4 equivalent calls inferred from this helper
	return {
		ALL = 0,
		AYATAN = 30,
		NOGGLES = 31,
		FRAMES = 32,
		RESOURCES = 33,
		COMPANIONS = 34,
		MISC = 35
	}
end

function GetShipDecoCategories()
	return fn19() -- inferred equivalent call
end

local function fn20(list, list2)
	if list2 then
		for i = 1, #list2 do
			__wf_atom_83c14687()
			local mItemType = list2[i].mItemType

			if not __wf_atom_7e8ad928(mItemType) then
				table.insert(list, { item = mItemType, type = mItemType:__wf_atom_5b41f63b() })
			end
		end
	end
end

function GetPurchasedItems(object, object2, instance, p, p2)
	local result = {}

	if __wf_atom_7e8ad928(object2) then
		return result
	end

	fn20(result, object2:__wf_atom_4f67b86c())
	fn20(result, object2:__wf_atom_20b04548())
	fn20(result, object2:__wf_atom_ebdc4e6e())
	fn20(result, object2:__wf_atom_4259c789())
	local __wf_atom_c84817dd = object2:__wf_atom_c84817dd()

	if __wf_atom_c84817dd ~= nil then
		for i = 1, #__wf_atom_c84817dd do
			__wf_atom_83c14687()
			local v10 = __wf_atom_c84817dd[i]
			table.insert(result, {
				type = v10.mItemType:__wf_atom_5b41f63b(),
				count = v10.mItemCount
			})
		end
	end

	if p then
		table.sort(result, fn16)
		return result
	end

	fn20(result, object2:__wf_atom_5f590eec())
	fn20(result, object2:__wf_atom_ff7d29fb())
	fn20(result, object2:__wf_atom_546ac461())
	fn20(result, object2:__wf_atom_50f906c7())
	fn20(result, object2:__wf_atom_db1ae7f4())
	fn20(result, object2:__wf_atom_71d5cc00())
	fn20(result, object2:__wf_atom_8e079833())
	fn20(result, object2:__wf_atom_fa4e86a6())
	fn20(result, object2:__wf_atom_260a9632())
	fn20(result, object2:__wf_atom_072f6737())
	fn20(result, object2:__wf_atom_bae92715())
	fn20(result, object2:__wf_atom_a76bb6ec())
	fn20(result, object2:__wf_atom_9683bef6())

	if not __wf_atom_7e8ad928(p2) then
		local v10 = fn18(object2:__wf_atom_7734c6aa(), p2, object, fn19(), true, true) -- inferred equivalent call

		for _, v11 in pairs(v10) do
			v11.type = v11.Type:__wf_atom_5b41f63b()
			v11.count = v11.Count
			table.insert(result, v11)
		end
	end

	local __wf_atom_90d72e37 = object2:__wf_atom_90d72e37()

	if __wf_atom_90d72e37 ~= nil then
		local v10 = {}

		for i = 1, #__wf_atom_90d72e37 do
			local __wf_atom_5b41f63b = __wf_atom_90d72e37[i].mItemType:__wf_atom_5b41f63b()

			if v10[__wf_atom_5b41f63b] == nil then
				v10[__wf_atom_5b41f63b] = { Count = 1 }
			else
				v10[__wf_atom_5b41f63b].Count = v10[__wf_atom_5b41f63b].Count + 1
			end
		end

		for k, v11 in pairs(v10) do
			table.insert(result, { type = k, count = v11.Count })
		end
	end

	local __wf_atom_6b29f1ed = object2:__wf_atom_6b29f1ed()

	if __wf_atom_6b29f1ed ~= nil then
		for i = 1, #__wf_atom_6b29f1ed do
			__wf_atom_83c14687()
			local v10 = __wf_atom_6b29f1ed[i]
			table.insert(result, {
				type = v10.mItemType:__wf_atom_5b41f63b(),
				count = v10.mItemCount
			})
		end
	end

	local __wf_atom_49479502 = object2:__wf_atom_49479502()

	if __wf_atom_49479502 ~= nil then
		for i = 1, #__wf_atom_49479502 do
			__wf_atom_83c14687()
			local v10 = __wf_atom_49479502[i]
			table.insert(result, {
				type = v10.mItemType:__wf_atom_5b41f63b(),
				count = v10.mItemCount
			})
		end
	end

	local __wf_atom_da43e3f3 = object2:__wf_atom_da43e3f3()

	if __wf_atom_da43e3f3 ~= nil then
		for i = 1, #__wf_atom_da43e3f3 do
			__wf_atom_83c14687()
			table.insert(result, {
				type = __wf_atom_da43e3f3[i].mItemType:__wf_atom_5b41f63b()
			})
		end
	end

	local v10 = {}

	if not __wf_atom_7e8ad928(gGameData) then
		local mRooms = gGameData:__wf_atom_247a5d2e(true).mRooms

		for i = 1, #mRooms do
			local mPlacedDecos = mRooms[i].mPlacedDecos

			for j = 1, #mPlacedDecos do
				table.insert(v10, mPlacedDecos[j])
			end
		end
	end

	local __wf_atom_35b0df9c = object2:__wf_atom_35b0df9c()
	local instances = {}

	if __wf_atom_7e8ad928(object) then
		if instance ~= nil and instance:IsA(__wf_atom_87288ae7) then
			table.insert(instances, instance)
		end
	else
		instances = object:__wf_atom_caa82b8d(__wf_atom_01e60b5b)
	end

	if #instances > 0 then
		for i = 1, #v10 do
			local decoType = v10[i].decoType

			if __wf_atom_7e8ad928(decoType) then
				continue
			end

			__wf_atom_83c14687()
			local v11 = nil

			for j = 1, #instances do
				if instances[j]:__wf_atom_47a670f8() ~= decoType then
					continue
				end

				v11 = instances[j]
				break
			end

			if __wf_atom_7e8ad928(v11) then
				continue
			end

			local v12 = false

			for j = 1, #__wf_atom_35b0df9c do
				if __wf_atom_7e8ad928(__wf_atom_35b0df9c[j]) or __wf_atom_35b0df9c[j].mItemType ~= v11:GetItem() then
					continue
				end

				__wf_atom_35b0df9c[j].mItemCount = __wf_atom_35b0df9c[j].mItemCount + 1
				v12 = true
				break
			end

			if v12 then
				continue
			end

			__wf_atom_35b0df9c = __wf_atom_7e8ad928(__wf_atom_35b0df9c) and {} or __wf_atom_35b0df9c
			table.insert(__wf_atom_35b0df9c, SF.CountedItem(v11:GetItem(), 1))
		end
	end

	for i = 1, #__wf_atom_35b0df9c do
		local v11 = __wf_atom_35b0df9c[i]
		table.insert(result, {
			type = v11.mItemType:__wf_atom_5b41f63b(),
			count = v11.mItemCount
		})
	end

	local __wf_atom_fe84572e = object2:__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		table.insert(result, {
			type = __wf_atom_fe84572e[i].mItemType:__wf_atom_5b41f63b(),
			count = 1
		})
	end

	local v11 = { object2:__wf_atom_063f1444(), (object2:GetUpgrades()) }

	for i = 1, #v11 do
		local v12 = v11[i]

		for j = 1, #v12 do
			local v13 = v12[j]
			table.insert(result, {
				type = v13.mItemType:__wf_atom_5b41f63b(),
				count = v13.mItemCount
			})
		end
	end

	table.sort(result, fn16)
	return result
end

function GetIconForEquippedSkin(object, object2, object3, p, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) or p == 0 then
		return nil
	end

	local __wf_atom_d78fd481 = object3:__wf_atom_eb82ab1f(0):__wf_atom_d78fd481(p)

	if not __wf_atom_7e8ad928(__wf_atom_d78fd481) and __wf_atom_d78fd481.mItemId.mId ~= "" then
		local __wf_atom_71d5cc00 = object2:__wf_atom_71d5cc00()

		for i = 1, #__wf_atom_71d5cc00 do
			if __wf_atom_71d5cc00[i].mItemId.mId == __wf_atom_d78fd481.mItemId.mId then
				return fn3(object:__wf_atom_232fd31d(__wf_atom_71d5cc00[i].mItemType), p2)
			end
		end
	end
end

local function fn21()
	if
		__wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(gGameData)
		or __wf_atom_7e8ad928(_T.DojoMgr)
		or __wf_atom_7e8ad928(_T.DojoMgr.mDojo)
		or gGameRules:__wf_atom_5ff594a3() ~= gGameData:__wf_atom_5ff594a3()
	then
		return false
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_e800787c()) then
	end

	return false
end

local function fn22(instance)
	local v10 = fn19() -- inferred equivalent call
	local misc = v10.MISC
	local v11 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ResourceContainerPlaceableDecoration")
	local v12 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ResourcePickupPlaceableDecoration")
	local v13 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ShipPlaceablePictureFrame")
	local v14 = WeakResource("/Lotus/Objects/Tenno/Props/Ships/ShipPetBedBase")
	local v15 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/PetToyBasePlaceableDecoration")
	local v16 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/BobbleHeadPlaceableDecoration")
	local v17 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/LisetPropPlaceableDecoration")
	local v18 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/LisetPropPickupPlaceableDecoration")

	if instance:IsA(v11) or instance:IsA(v12) then
		if instance:IsA(v17) or instance:IsA(v18) then
			return v10.MISC
		end

		return v10.RESOURCES
	else
		if instance:IsA(v13) then
			return v10.FRAMES
		end

		if instance:IsA(v14) or instance:IsA(v15) then
			return v10.COMPANIONS
		end

		if instance:IsA(v16) then
			misc = v10.NOGGLES
		end

		return misc
	end
end

function GetCategoryForShipDeco(p)
	return (fn22(p))
end

function GetShipDecoItems(p, object, p2, p3, p4, p5, p6)
	local result = {}
	local gGameRules2 = gGameRules

	if __wf_atom_7e8ad928(gGameRules2) or __wf_atom_7e8ad928(gGameRules2:__wf_atom_964056fd()) then
		return result
	end

	local __wf_atom_964056fd = gGameRules2:__wf_atom_964056fd()
	local __wf_atom_caa82b8d = __wf_atom_964056fd:__wf_atom_caa82b8d(p4 or __wf_atom_01e60b5b)
	local v10 = nil
	local isA = gGameRules:IsA(__wf_atom_1316e0c2)

	if isA then
		if p2 and gGameRules:__wf_atom_5ff594a3() == object:__wf_atom_5ff594a3() then
			v10 = object:__wf_atom_cfc6502d()
		end
	else
		p2 = false
	end

	if isA and fn21() then
		return
	end

	local v11 = p2 and {} or object:GetInventory():__wf_atom_35b0df9c()
	local mPlacedDecos = {}

	if p6 and not __wf_atom_7e8ad928(gGameData) then
		local mRooms = gGameData:__wf_atom_247a5d2e(true).mRooms

		for i = 1, #mRooms do
			table.insert(mPlacedDecos, mRooms[i].mPlacedDecos)
		end
	end

	local v12 = fn19() -- inferred equivalent call

	for i = 1, #__wf_atom_caa82b8d do
		local storeItem = __wf_atom_caa82b8d[i]
		local item = storeItem:GetItem()
		local __wf_atom_47a670f8 = storeItem:__wf_atom_47a670f8()
		local categories = { v12.ALL }
		local v13 = not p2 and storeItem:AlwaysAvailable() and true or false
		local mItemCount = 0
		local premiumPrice = nil
		local mItemCount2 = 0

		for j = 1, #v11 do
			local v14 = v11[j]

			if item ~= v14.mItemType then
				continue
			end

			mItemCount = v14.mItemCount
			v13 = mItemCount > 0
			break
		end

		for j = 1, #mPlacedDecos do
			local v14 = mPlacedDecos[j]

			for k = 1, #v14 do
				if v14[k].decoType ~= __wf_atom_47a670f8 then
					continue
				end

				mItemCount += 1
				v13 = true
			end
		end

		local v14 = WeakResource("/SF/Types/Items/FusionTreasure")

		if v10 ~= nil then
			local mShipDecorations = v10.mShipDecorations

			for j = 1, #mShipDecorations do
				local mShipDecoration = mShipDecorations[j]

				if
					__wf_atom_7e8ad928(mShipDecoration.mItemType)
					or mShipDecoration.mItemType:IsA(v14)
					or item ~= mShipDecoration.mItemType
				then
					continue
				end

				mItemCount2 = mShipDecoration.mItemCount
				v13 = v13 or mItemCount2 > 0
				break
			end
		end

		local v15 = storeItem:ShowInMarket()

		if not v15 and p5 then
			v15 = not __wf_atom_7e8ad928((module2.GetSaleInfo(storeItem))) and fn2(storeItem)
		end

		assert(
			not __wf_atom_7e8ad928(__wf_atom_47a670f8),
			"Ship Decoration " .. storeItem:__wf_atom_5b41f63b() .. " has no Deco."
		)

		if (not isA or storeItem:__wf_atom_54893980()) and (v13 or not p2 and v15) then
			if not v13 then
				premiumPrice = storeItem:__wf_atom_8c904c63()
			end

			table.insert(categories, (fn22(__wf_atom_47a670f8)))

			if not p2 and (premiumPrice == nil or premiumPrice > 0) then
				table.insert(result, {
					Type = item,
					mItemType = item,
					StoreItem = storeItem,
					Name = Localize(tostring(storeItem:__wf_atom_014a76a2()), {}),
					Icon = storeItem:GetIconTexture(),
					Description = Localize(tostring(storeItem:__wf_atom_3a3d2e39()), {}),
					Capacity = storeItem:__wf_atom_e23658d9(isA),
					ToolTip = module2.GetItemToolTipText(p, storeItem, nil, nil),
					Count = mItemCount,
					PremiumPrice = premiumPrice,
					Categories = categories
				})
			end

			if mItemCount2 > 0 then
				local name = Localize(tostring(storeItem:__wf_atom_014a76a2()), {})

				if not p2 then
					name = Localize("/Lotus/Language/UiElements/VaultDecoration", {
						ITEM_NAME = name
					})
				end

				table.insert(result, {
					Type = item,
					StoreItem = storeItem,
					Name = name,
					Icon = storeItem:GetIconTexture(),
					Description = Localize(tostring(storeItem:__wf_atom_3a3d2e39()), {}),
					Capacity = storeItem:__wf_atom_e23658d9(isA),
					ToolTip = module2.GetItemToolTipText(p, storeItem, nil, nil),
					Count = mItemCount2,
					PremiumPrice = premiumPrice,
					Categories = categories,
					VaultDeco = true
				})
			end
		end

		__wf_atom_83c14687(0)
	end

	if p3 then
		return result
	end

	if not p2 then
		local v13 = fn18(object:GetInventory():__wf_atom_7734c6aa(), p, __wf_atom_964056fd, v12, isA, nil, true)

		for _, v14 in pairs(v13) do
			table.insert(result, v14)
		end
	end

	if v10 == nil then
		return result
	end

	local v13 = fn18(v10.mFusionTreasures, p, __wf_atom_964056fd, v12, isA)

	for _, v14 in pairs(v13) do
		if not p2 then
			v14.Name = Localize("/Lotus/Language/UiElements/VaultDecoration", {
				ITEM_NAME = v14.Name
			})
		end

		v14.VaultDeco = true
		table.insert(result, v14)
	end

	return result
end

function GetRequiredRankMsg(object, p, p2, p3, p4)
	local ternary = module.Ternary(p2, "", "<br>")
	local isXPLocked, rank = module2.IsXPLocked(p)
	local ternary2 = module.Ternary(p3 ~= nil, p3, "#FFFFFF")
	local ternary3 = module.Ternary(p4 ~= nil, p4, "#DD4444")

	if isXPLocked or rank ~= nil and rank > 0 then
		local v10 = "<p>"
		local v11

		if isXPLocked then
			v11 = v10 .. "<font color=\"" .. ternary3 .. "\"><br>" .. object:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Store_XPLockedMesage",
				true,
				{ RANK = rank }
			) .. ternary .. "</font>"
		else
			v11 = v10 .. "<font color=\"" .. ternary2 .. "\"><br><b>" .. object:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Store_XPRequiredMsg",
				true,
				{ RANK = rank }
			) .. "</b>" .. ternary .. "</font>"
		end

		return v11 .. "</p>"
	else
		return ""
	end
end

function GetTotalBundledPremiumCredits(object)
	local __wf_atom_b982d1aa = object:__wf_atom_b982d1aa()

	for _, v10 in object:__wf_atom_72915748() do
		local mTypeName = v10.mTypeName

		if __wf_atom_7e8ad928(mTypeName) or not mTypeName:IsPackage() then
			continue
		end

		__wf_atom_b982d1aa += GetTotalBundledPremiumCredits(mTypeName)
	end

	return __wf_atom_b982d1aa
end

function GetTotalBundledItemQuantity(items, p)
	local v10 = p == nil
	local total = 0

	for _, item in items do
		local mTypeName = item.mTypeName

		if __wf_atom_7e8ad928(mTypeName) then
			continue
		end

		if mTypeName:IsPackage() then
			local v11, v12 = GetTotalBundledItemQuantity(mTypeName:__wf_atom_72915748(), p)

			if v12 == nil then
				return 0
			end

			if p == nil then
				p = v12
			end

			total += item.mPurchaseQuantity * v11
		else
			if p == nil then
				p = mTypeName
			end

			if mTypeName == p then
				if item.mPurchaseQuantity > 1 then
					total += item.mPurchaseQuantity
				elseif mTypeName:__wf_atom_efa6f447() == 35 then
					total += -mTypeName:__wf_atom_ee4fa4fd() * mTypeName:__wf_atom_17d97bf6()
				else
					total += item.mPurchaseQuantity
				end
			elseif v10 then
				return 0
			end
		end
	end

	return total, p
end

function GetPackageContentsDesc(object, object2, p, p2, p3)
	local __wf_atom_72915748 = object2:__wf_atom_72915748()

	if object2:__wf_atom_bdbcec0a() ~= "" then
		local _ = module2.CheckSteamPurchaseAvailability(object2) == "MARKET"
	end

	local ternary = module.Ternary(p2 ~= nil, p2, "#FFFFFF")
	local ternary2 = module.Ternary(p3 ~= nil, p3, "#666666")

	if #__wf_atom_72915748 > 0 then
		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Includes", false)
		local v10 = "<font color=\"" .. ternary .. "\">"
		local v11 = __wf_atom_8e9ac384 .. v10
		local v12 = ""
		local v13 = ""

		for _, v14 in __wf_atom_72915748 do
			local mTypeName = v14.mTypeName

			if __wf_atom_7e8ad928(mTypeName) then
				continue
			end

			local v15 = "<br>"
			local isPackage = mTypeName:IsPackage()
			local shouldGiveFromPackage = module2.ShouldGiveFromPackage(mTypeName, p, v14.mPurchaseQuantity == 1)

			if shouldGiveFromPackage and not __wf_atom_7e8ad928(gGameData) then
				local productId = module2.GetProductId(mTypeName)

				if #productId > 0 then
					shouldGiveFromPackage = not module2.IsFoundersPackOwned(productId)
				end
			end

			if not shouldGiveFromPackage then
				v15 ..= "<font color=\"" .. ternary2 .. "\">"
			end

			local v16 = v15 .. object:__wf_atom_8e9ac384("<BULLET>", true)
			local mPurchaseQuantity = v14.mPurchaseQuantity

			if mPurchaseQuantity <= 1 and mTypeName:__wf_atom_efa6f447() == 35 then
				mPurchaseQuantity = -mTypeName:__wf_atom_ee4fa4fd() * mTypeName:__wf_atom_17d97bf6()
			end

			if mPurchaseQuantity > 1 then
				v16 ..= module.FormatNumber(mPurchaseQuantity) .. " "
			end

			if not shouldGiveFromPackage then
				v16 ..= object:__wf_atom_8e9ac384("<OWNED>", true) .. " "
			end

			local __wf_atom_014a76a2 = mTypeName:__wf_atom_014a76a2()

			if mTypeName:IsA(__wf_atom_bf37f5ca) and not __wf_atom_7e8ad928(mTypeName:__wf_atom_e622b3f6()) then
				__wf_atom_014a76a2 = mTypeName:__wf_atom_619b1891()
			end

			local v17 = tostring(__wf_atom_014a76a2)
			local v18 = Localize(v17 .. "Bundle", nil)
			local v19

			if #v18 > 0 and string.sub(v18, 1, 1) ~= "/" then
				v19 = v16 .. v18
			else
				v19 = v16 .. Localize(v17, nil)
			end

			local v20 = GetTotalBundledItemQuantity(__wf_atom_72915748, mTypeName)

			if mPurchaseQuantity < v20 then
				v19 ..= " (" .. Localize("/SF/Language/Vendor/AdditionalTotal", {
					AMOUNT = module.FormatNumber(v20)
				}) .. ")"
			end

			if mTypeName:__wf_atom_efa6f447() == 8 then
				local v21 = Resource(mTypeName:GetItem())

				if not __wf_atom_7e8ad928(v21) then
					if v21:__wf_atom_4eb36b35() then
						local v22

						if v14.mDurability == 0 then
							v22 = "/Lotus/Language/Menu/Global_3Days"
						elseif v14.mDurability == 1 then
							v22 = "/Lotus/Language/Menu/Global_7Days"
						elseif v14.mDurability == 2 then
							v22 = "/Lotus/Language/Menu/Global_30Days"
						else
							v22 = nil
						end

						if v22 ~= nil then
							v19 ..= " (" .. object:__wf_atom_8e9ac384(v22, false) .. ")"
						end
					else
						local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(v14.mDurability)
						v19 ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
							NUM_USES = __wf_atom_5df94bc3
						}) .. ")"
					end
				end
			end

			if not shouldGiveFromPackage then
				v19 ..= "</font>"
			end

			if isPackage then
				v12 ..= v19
			else
				v13 ..= v19
			end
		end

		if #v12 > 0 then
			v11 ..= v12

			if #v13 > 0 then
				v11 ..= "<br><br></font>" .. object:__wf_atom_8e9ac384("/SF/Language/Vendor/AdditionalIncludes", false) .. v10
			end
		end

		local __wf_atom_b982d1aa = object2:__wf_atom_b982d1aa()

		if __wf_atom_b982d1aa > 0 then
			v11 ..= "<br>" .. object:__wf_atom_8e9ac384("<BULLET>", true) .. object:__wf_atom_8e9ac384(
				"/SF/Language/Currency/PremiumCurrencyAmountNamed",
				true,
				{
					AMOUNT = module.FormatNumber(__wf_atom_b982d1aa)
				}
			)
			local v14 = GetTotalBundledPremiumCredits(object2)

			if __wf_atom_b982d1aa < v14 then
				v11 ..= " (" .. Localize("/SF/Language/Vendor/AdditionalTotal", {
					AMOUNT = module.FormatNumber(v14)
				}) .. ")"
			end
		end

		return v11 .. v13 .. "</font>"
	else
		return ""
	end
end

local function fn23(p)
	for i = 1, #v7 do
		local v10 = v7[i]

		if p == v10.Base then
			return v10.Real, v10.LocTag
		end
	end

	return nil, ""
end

function GetBaseWeaponConversion(p)
	return fn23(p)
end

function GetCompatWarning(object, object2, object3, object4, p, p2)
	if __wf_atom_7e8ad928(object2) then
		return {}, nil, nil
	end

	local __wf_atom_efa6f447 = object2:__wf_atom_efa6f447()
	local v10 = {
		__wf_atom_d98e64fe,
		WeakResource("/SF/Types/Player/PlayerPowerSuit"),
		WeakResource("/Lotus/Types/Game/PowerSuits/PlayerPowerSuit"),
		WeakResource("/Lotus/Types/Sentinels/SentinelPowerSuit"),
		WeakResource("/Lotus/Weapons/Tenno/Melee/PlayerMeleeWeapon")
	}
	local v11

	if Engine.__wf_atom_fc67ba71() then
		if object2:__wf_atom_bdbcec0a() == "" then
			v11 = false
		else
			v11 = object2:__wf_atom_eebe65ce()
		end
	else
		v11 = false
	end

	local v12, v13, v14

	if v11 or __wf_atom_7e8ad928(object2:__wf_atom_7c09e378()) then
		v12 = false
		v13 = false
		v14 = false
	else
		if __wf_atom_efa6f447 == 10 then
			v14 = object2:__wf_atom_7c09e378():IsA(__wf_atom_9f051930)
		else
			v14 = false
		end

		v13 = __wf_atom_efa6f447 == 6

		if __wf_atom_efa6f447 == 6 then
			v12 = object2:__wf_atom_7c09e378():IsA(v3)
		else
			v12 = false
		end
	end

	if v11 then
		v12 = v11
	elseif not v12 then
		v12 = not (v13 or v14) and __wf_atom_efa6f447 ~= 9
	end

	if v12 then
		return {}, nil, nil
	end

	local result = {}
	local v15 = nil
	local v16 = nil
	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Hyperlink)
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
	local v17 = {}

	if __wf_atom_efa6f447 == 9 then
		local __wf_atom_72915748 = object2:__wf_atom_72915748()
		local v18 = {}

		for i = 1, #__wf_atom_72915748 do
			local mTypeName = __wf_atom_72915748[i].mTypeName

			if __wf_atom_7e8ad928(mTypeName) then
				continue
			end

			local __wf_atom_efa6f447_2 = mTypeName:__wf_atom_efa6f447()

			if __wf_atom_efa6f447_2 == 6 or __wf_atom_efa6f447_2 == 10 then
				local __wf_atom_7c09e378 = mTypeName:__wf_atom_7c09e378()

				if __wf_atom_7c09e378 ~= nil then
					table.insert(v17, { item = __wf_atom_7c09e378, isOwned = false })
				end
			else
				table.insert(v18, mTypeName:GetItem())
			end
		end

		if #v17 ~= 0 and #v18 ~= 0 then
			local v19 = 1

			while v19 <= #v17 do
				local flag = false

				for i = 1, #v18 do
					if not v18[i]:IsA(v17[v19].item) then
						continue
					end

					flag = true
					break
				end

				if flag then
					table.remove(v17, v19)
				else
					v19 += 1
				end
			end
		end
	else
		table.insert(v17, { item = object2:__wf_atom_7c09e378(), isOwned = false })
	end

	if not (#v17 > 0) then
		return result, v15, v16
	end

	local v18 = 1
	local count = 0

	while v18 <= #v17 do
		local flag = false

		for i = 1, #v10 do
			if v17[v18].item ~= v10[i] then
				continue
			end

			flag = true
			break
		end

		if flag then
			table.remove(v17, v18)
		else
			v18 += 1
		end
	end

	local items = p.Items

	if p.Dictionary then
		for _, item in pairs(items) do
			for _, v19 in v17 do
				if v19.isOwned then
					continue
				end

				if item.Count > 0 and item.Type:IsA(v19.item) then
					v19.isOwned = true
					count += 1
				elseif not __wf_atom_7e8ad928(object3) then
					local storeItem = object3:GetStoreItem(v19.item)

					if not __wf_atom_7e8ad928(storeItem) and storeItem:AlwaysAvailable() then
						v19.isOwned = true
						count += 1
					end
				end
			end

			if count == #v17 then
				break
			end
		end
	else
		for _, item in items do
			__wf_atom_83c14687(0)

			for _, v19 in v17 do
				if v19.isOwned then
					continue
				end

				if item.item == nil or not item.item:IsA(v19.item) then
					if not __wf_atom_7e8ad928(object3) then
						local storeItem = object3:GetStoreItem(v19.item)

						if not __wf_atom_7e8ad928(storeItem) and storeItem:AlwaysAvailable() then
							v19.isOwned = true
							count += 1
						end
					end
				else
					v19.isOwned = true
					count += 1
				end
			end

			if count == #v17 then
				break
			end
		end
	end

	local __wf_atom_9ddc0f59 = object4:__wf_atom_9ddc0f59()

	for i = 1, #v17 do
		if not (v17[i].item ~= nil and v17[i].item:IsA(__wf_atom_202871eb) and #__wf_atom_9ddc0f59 > 0) then
			continue
		end

		count += 1
	end

	if count == #v17 then
		return result, v15, v16
	end

	local v19 = ""
	local v20 = ""

	if not __wf_atom_7e8ad928(object3) then
		local count2 = 0

		for _, v21 in v17 do
			if v21.isOwned then
				continue
			end

			local storeItem = object3:GetStoreItem(v21.item)
			local locTag

			if __wf_atom_7e8ad928(storeItem) then
				local item = v21.item
				local real = nil
				locTag = ""

				for i = 1, #v7 do
					local v22 = v7[i]

					if item ~= v22.Base then
						continue
					end

					real = v22.Real
					locTag = v22.LocTag
					break
				end

				if real == nil then
					local __wf_atom_caa82b8d = object3:__wf_atom_caa82b8d(v21.item, true)

					if #__wf_atom_caa82b8d > 0 then
						storeItem = __wf_atom_caa82b8d[1]
					end
				else
					storeItem = object3:GetStoreItem(real)
				end
			else
				locTag = ""
			end

			if not __wf_atom_7e8ad928(storeItem) then
				local v22 = false

				for i = 1, #result do
					if storeItem ~= result[i].StoreItem then
						continue
					end

					v22 = true
					break
				end

				if not v22 then
					local v23 = #result == 0
					local ternary = module.Ternary(v23, "", "<br>")
					local ternary2 = module.Ternary(v23, "", "\r\n")
					local ternary3 = module.Ternary(locTag == "", storeItem:__wf_atom_014a76a2():c_str(), locTag)
					local v24 = "<a color=\"" .. convertColorNumberToHex .. "\" hovercolor=\"" .. convertColorNumberToHex2 .. "\" href=\"#onHyperLinkPressed:  " .. storeItem:__wf_atom_5b41f63b() .. "\">" .. object:__wf_atom_8e9ac384(ternary3, false) .. "</a>"

					if not storeItem:ShowInMarket() then
						v24 = object:__wf_atom_8e9ac384(storeItem:__wf_atom_014a76a2():c_str(), false)
					end

					v20 ..= ternary .. v24
					v19 ..= ternary2 .. object:__wf_atom_8e9ac384(ternary3, false)
					table.insert(result, { StoreItem = storeItem, LocTag = ternary3 })
				end
			end

			count2 += 1
		end
	end

	if __wf_atom_efa6f447 == 9 then
		if v19 == "" then
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Global_PackagePurchaseWithoutCompatibleGenericConfirm",
				false
			)
			return
				result,
				object:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_PackageCompatNotOwnedGeneric", false),
				__wf_atom_8e9ac384
		end

		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/Global_PackagePurchaseWithoutCompatibleConfirm",
			false,
			{ COMPATIBLES = v19 }
		)
		return
			result,
			object:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_PackageCompatNotOwned", false, {
				COMPATIBLES = module.Ternary(p2, v19, v20)
			}),
			__wf_atom_8e9ac384
	else
		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(object2:__wf_atom_014a76a2():c_str(), false)

		if v19 ~= "" then
			local __wf_atom_8e9ac384_2 = object:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Global_PurchaseWithoutCompatibleConfirm",
				false,
				{ ITEMTOBUY = __wf_atom_8e9ac384, COMPATIBLE = v19 }
			)
			return
				result,
				object:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_CompatibleNotOwned", false, {
					COMPATIBLE = module.Ternary(p2, v19, v20)
				}),
				__wf_atom_8e9ac384_2
		end

		v16 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_PurchaseWithoutCompatibleGenericConfirm", false, {
			ITEMTOBUY = __wf_atom_8e9ac384
		})
		v15 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_CompatibleNotOwnedGeneric", false)
		return result, v15, v16
	end
end

function GetDisplayStats(instance, p, p2, p3, p4, p5, p6)
	local v10 = nil
	local v11 = nil

	if type(instance) == "table" or __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_d560b05c) then
		v10, v11 = module5.GetStatsTextForItem(instance, p, p2, "#EFEFEF", "#FFFFFF", true, p3, nil, p4, p6)
	else
		local object = gRegion:CreateObject(Type(instance), _T.MenuSuitAvatar)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_f85770ef = object:__wf_atom_f85770ef()

			if __wf_atom_1ef90898(__wf_atom_f85770ef) then
				__wf_atom_f85770ef = Resource(__wf_atom_f85770ef)
			end

			v10, v11 = module5.GetStatsTextForItem(
				__wf_atom_f85770ef,
				p,
				p2,
				"#EFEFEF",
				"#FFFFFF",
				true,
				p3,
				nil,
				p4,
				p5,
				p6
			)
			gRegion:__wf_atom_dd1e4d10(object)
		end
	end

	if not p then
		v10 = "<p>" .. v10 .. "</p>"
		v11 = "<p>" .. v11 .. "</p>"
	end

	return v10, v11
end

local function fn24(object, list, p, p2)
	local v10 = ""

	if not (#list > 0) then
		print("_GetRewardManifestInfo no rewards")
		return v10
	end

	local v11 = v10 .. "<br><br>"
	local v12

	if p then
		local color = module4.GetColor(10, true)
		v12 = ((v11 .. "<font color=\"" .. module.ConvertColorNumberToHex(color) .. "\">") .. object:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ProjectionManager_Rewards",
			false
		)) .. "</font>"
	else
		v12 = (v11 .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_Rewards", false)) .. "<br><br>"
	end

	table.sort(list, function(a, b)
		if a.r == b.r then
			return a.t < b.t
		end

		return a.r < b.r
	end)
	local v13 = { "COMMON", "UNCOMMON", "RARE", "LEGENDARY" }
	local v14 = {}
	local v15 = { "#a67e51", "#dFdFFF", "#FFCF70", "#6FFFFF" }

	for i = 1, #v13 do
		v14[i] = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/" .. v13[i], false)

		if p then
			v14[i] = object:__wf_atom_8e9ac384("<" .. v13[i] .. ">", true) .. v14[i]
		end
	end

	local convertColorNumberToHex = module.ConvertColorNumberToHex(module4.GetColor(9, true))
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(module4.GetColor(6, true))
	local r = -1
	local v16

	if p2 == nil then
		v16 = false
	else
		v16 = p2 <= #list
	end

	local ternary = module.Ternary(v16, ", ", "<br>")
	local ternary2 = module.Ternary(v16, "<font color=\"", "<font leftMargin=\"24\" color=\"")

	for i = 1, #list do
		local v17 = list[i]

		if p then
			if v17.r ~= r then
				v12 ..= "<font color=\"" .. convertColorNumberToHex .. "\"><br>" .. v14[v17.r + 1] .. "<br></font>"
				r = v17.r
			end

			local ternary3 = module.Ternary(i == #list, "", ternary)
			local v18 = i < #list and list[i + 1].r ~= r and "<br>" or ternary3
			v12 ..= ternary2 .. convertColorNumberToHex2 .. "\">" .. TitleCase(v17.t) .. v18 .. "</font>"
		else
			v12 ..= "</font><font color=\"" .. v15[v17.r + 1] .. "\">   " .. v17.t .. module.Ternary(i == #list, "", "<br>") .. "</font>"
		end
	end

	return v12
end

function GetRewardTextForTable(p, p2, p3, p4)
	return (fn24(p, p2, p3, p4))
end

local function fn25(object, object2, p, p2, p3, p4)
	local v10 = ""

	if __wf_atom_7e8ad928(object2) then
		print("_GetRewardManifestInfo nil manifest")
		return v10
	end

	local result = {}

	for i = 0, object2:__wf_atom_8cfee589() do
		for j = 0, object2:__wf_atom_d1247c6c(i) - 1 do
			local tieredItem = object2:GetTieredItem(i, j)

			if __wf_atom_7e8ad928(tieredItem) then
				continue
			end

			local storeItem = tieredItem:GetStoreItem()

			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local v11 = fn11(object, storeItem, storeItem:GetItem(), nil, nil, nil, p)

			if tieredItem.mItemCount > 1 then
				if storeItem:__wf_atom_efa6f447() == 35 then
					local v12 = -storeItem:__wf_atom_ee4fa4fd() * tieredItem.mItemCount
					v11.Name = module.FormatNumber(v12) .. " " .. object:__wf_atom_8e9ac384(
						storeItem:__wf_atom_014a76a2():c_str(),
						false
					)
				else
					v11.Name = object:__wf_atom_8e9ac384("/Lotus/Language/Items/LargeBatchItem", false, {
						ITEM = v11.Name,
						NUM = module.FormatNumber(tieredItem.mItemCount)
					})
				end
			end

			local ternary = module.Ternary(p2, i, tieredItem:__wf_atom_a8dac107())
			table.insert(result, { t = v11.Name, r = ternary })
		end
	end

	if p3 then
		return result
	end

	return (fn24(object, result, p, p4))
end

function GetRewardManifestInfo(p, p2, p3, p4, p5)
	return (fn25(p, p2, p3, p4, nil, p5))
end

function GetRelicTypeInfo(p, p2, p3)
	return (fn25(p, Resource(p2):__wf_atom_ff7834ae(), p3, nil, nil))
end

function GetRelicInfo(object, object2, p)
	local v10 = tostring(object2:__wf_atom_5e0d90e8())

	if __wf_atom_7e8ad928(v10) or v10 == "" then
		v10 = module.Ternary(
			tostring(object2:__wf_atom_127f1d58()) ~= "",
			object2:__wf_atom_127f1d58(),
			object2:__wf_atom_3a3d2e39()
		)
	end

	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(tostring(v10), true)
	local item = object2:GetItem()
	return __wf_atom_8e9ac384 .. fn25(object, Resource(item):__wf_atom_ff7834ae(), p, nil, nil)
end

function GetSearchString(object, object2, p, list, p2)
	if __wf_atom_7e8ad928(object2) then
		return ""
	end

	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(object2:__wf_atom_014a76a2():c_str(), false)
	local __wf_atom_fee7bbed = object2:__wf_atom_fee7bbed()
	local v10 = __wf_atom_8e9ac384

	for i = 1, #__wf_atom_fee7bbed do
		v10 ..= " " .. object:__wf_atom_8e9ac384(__wf_atom_fee7bbed[i]:c_str(), false)
	end

	if list ~= nil then
		for i = 1, #list do
			v10 ..= " " .. list[i]
		end
	end

	if object2:__wf_atom_efa6f447() == 13 then
		v10 ..= " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/DetailedPurchase_RecipeShortcut", false)
	end

	if p ~= nil and p ~= __wf_atom_8e9ac384 then
		v10 ..= " " .. p
	end

	if not __wf_atom_7e8ad928(object2:GetItem()) and object2:GetItem():IsA(__wf_atom_6317e6dc) then
		local item = object2:GetItem()
		local v11 = fn25(object, Resource(item):__wf_atom_ff7834ae(), false, nil, true)

		for i = 1, #v11 do
			v10 ..= " " .. v11[i].t
		end
	end

	if math.abs((Engine.__wf_atom_db2b0cee(object2:__wf_atom_9fc42d94()))) <= 3628800 then
		v10 ..= " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_New", false)
	end

	if p2 == nil then
		if object2:__wf_atom_befa6dbf() ~= 0 then
			v10 ..= " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Expires", false)
		end
	else
		local v11

		if p2.Sale == nil or p2.Sale.mProductExpiryOverride == nil or p2.Sale.mProductExpiryOverride.sec == "" then
			v11 = p2.StoreItem == nil and 0 or p2.StoreItem:__wf_atom_befa6dbf()
		else
			v11 = p2.Sale.mProductExpiryOverride.sec
		end

		if v11 == 0 then
			if object2:__wf_atom_befa6dbf() ~= 0 then
				v10 ..= " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Expires", false)
			end
		else
			v10 ..= " " .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Expires", false)
		end
	end

	local v11 = v10 .. " ~~ " .. object:__wf_atom_8e9ac384(object2:__wf_atom_3a3d2e39():c_str(), false)
	return __wf_atom_d99ae0ec(v11)
end

function GetUpgradeInfo(object, object2, p, p2, value, value2, p3, p4, value3)
	local v10 = ""

	if __wf_atom_7e8ad928(object2) then
		return v10
	end

	local v11 = value or "<br>"
	local v12 = value2 or "<br>"
	local v13 = value3 or "<br><br>"
	local ternary = module.Ternary(p ~= nil, p, "#999999")
	local ternary2 = module.Ternary(p2 ~= nil, p2, "#FFFFFF")
	local item = object2:GetItem()

	if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_58a409f1) then
		return v10
	end

	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemType = item
	local mInstance = upgradeInfo.mInstance

	if __wf_atom_7e8ad928(mInstance) then
		return v10
	end

	local __wf_atom_49f7d220 = mInstance:__wf_atom_49f7d220("")
	local v14, v15

	if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p3.mInstance) or __wf_atom_7e8ad928(p3.mUpgradeFingerprint) then
		v14 = __wf_atom_49f7d220
		v15 = 0
	else
		v15 = p3.mInstance:__wf_atom_c6a5f697(p3.mUpgradeFingerprint)
		v14 = v15
	end

	for i = v15, v14 do
		if not (not p4 or i == v15 or i == v14) then
			continue
		end

		local v16

		if i == 0 then
			v16 = object:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false)
		else
			v16 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
				RANK = i
			})
		end

		local __wf_atom_254ac1f5 = mInstance:__wf_atom_254ac1f5(i)
		v10 = ((v10 .. "<font color=\"" .. ternary .. "\">" .. v16 .. v11 .. "</font>") .. "<font color=\"" .. ternary2 .. "\">" .. mInstance:__wf_atom_f324d993(__wf_atom_254ac1f5)) .. module.Ternary(i ~= v14, v13, v12) .. "</font>"
	end

	if mInstance:IsA(__wf_atom_50a5232d) then
		return v10 .. "<font color=\"" .. ternary .. "\"><br>" .. object:__wf_atom_8e9ac384(
			"/Lotus/Language/Ranks/MaxRank",
			false
		) .. " " .. __wf_atom_49f7d220 .. "</font>"
	end

	return v10
end

fn2 = function(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	local v10 = module2.CheckSteamPurchaseAvailability(p)

	if v10 == "UNAVAILABLE" then
		return false
	end

	return v10 == "EXTERNAL" or module2.GetStoreItemPriceObject(p, nil, nil, false).UsePrice > 0
end

function ValidPrice(p)
	return fn2(p)
end

function OnDetailedViewComplete(_)
	v9 = nil
end

function GetStoreItemUrl(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local productId = module2.GetProductId(object)

	if not productId or productId == "" then
		return nil
	end

	if object:__wf_atom_d242670f():__wf_atom_8598f3a9() then
		return (tostring(object:__wf_atom_d242670f()))
	end

	return "soulframe.com/payment?sku=" .. productId
end

function OpenPremiumCurrencySelection(object, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if p == nil then
		_T.DisplayPrimeToken = false
	else
		_T.DisplayPrimeToken = true
	end

	function _T.PremiumCurrencyOnBuyItemResult(p2)
		if p2 == nil then
			return
		end

		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = { ITEM = nil, CALLBACK = _T.PremiumCurrencyOnBuyItemResult }
		_T.BackgroundMovie:Execute("RefreshLoadout", "")
	end

	function _T.GetAllPremiumCurrencyItems()
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			__wf_atom_964056fd = Resource(__wf_atom_c67f9605:__wf_atom_964056fd())
		end

		local storeItems = __wf_atom_964056fd:GetStoreItems()
		local result = {}

		for i = 1, #storeItems do
			local storeItem = storeItems[i]

			if not storeItem then
				continue
			end

			local item = storeItem:GetItem()

			if _T.DisplayPrimeToken then
				if
					(Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_eecb6143())
					and storeItem:__wf_atom_56c51289() == 3
					and storeItem:__wf_atom_efa6f447() == 9
				then
					table.insert(result, {
						Categories = { 0 },
						Type = item,
						StoreItem = storeItem,
						Name = object:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_014a76a2()), false),
						Count = 0,
						ItemCount = 0
					})
				end
			elseif
				Engine.__wf_atom_eecb6143()
				and storeItem:__wf_atom_56c51289() > 0
				and storeItem:__wf_atom_efa6f447() == 11
				or Engine.__wf_atom_6f25c160()
				and storeItem:__wf_atom_efa6f447() == 11
				and storeItem:__wf_atom_d8410890() ~= ""
			then
				table.insert(result, {
					Categories = { 0 },
					Type = item,
					StoreItem = storeItem,
					Name = object:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_014a76a2()), false),
					Count = 0,
					ItemCount = 0
				})
			end
		end

		return result
	end

	function _T.GetPrimeCurrencyItemSorting()
		return {
			{
				Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortName", false),
				SortId = "NAME",
				Attribute = function(data, data2)
					local v10

					if data.EmptySlot == nil and data2.EmptySlot == nil then
						if data.mPurchased == false or data2.mPurchased == false then
							if data.mPurchased == false then
								v10 = false
							else
								v10 = data2.mPurchased == false
							end
						end
					elseif data.EmptySlot == true then
						v10 = data2.EmptySlot ~= true
					else
						v10 = false
					end

					if v10 == nil then
						return data.Name < data2.Name
					end

					return v10
				end
			},
			{
				Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortType", false),
				SortId = "TYPE",
				Attribute = function(data, data2)
					local v10

					if data.EmptySlot == nil and data2.EmptySlot == nil then
						if data.mPurchased == false or data2.mPurchased == false then
							if data.mPurchased == false then
								v10 = false
							else
								v10 = data2.mPurchased == false
							end
						end
					elseif data.EmptySlot == true then
						v10 = data2.EmptySlot ~= true
					else
						v10 = false
					end

					if v10 ~= nil then
						return v10
					end

					if data.Categories == nil or data.Categories[1] == nil then
						return false
					end

					if data2.Categories == nil or data2.Categories[1] == nil then
						return true
					end

					if data.Categories[1] == data2.Categories[1] then
						return data.Name < data2.Name
					end

					return data.Categories[1] < data2.Categories[1]
				end
			}
		}, "NAME"
	end

	function _T.GetPremiumCurrencyItemCategories()
		return {
			{
				Category = 0,
				Name = Localize("/Lotus/Language/Menu/CategoryAll", {}),
				Icon = _G.UICategoryIcon_AllOn
			}
		}
	end

	function _T.BrowsePremiumCurrencyItemsDone(list, _)
		object:SetVisible(true)
		_T.GetAllItems = nil
		_T.GetItemSorting = nil
		_T.BrowseItemsDone = nil
		_T.GetItemCategories = nil
		v8 = nil

		if list ~= nil then
			local v10 = list[1]

			if v10 ~= nil then
				_T.marketDetailedViewParms = nil
				_T.marketDetailedViewParms = {
					ITEM = { StoreItem = v10.StoreItem, Sale = nil },
					CALLBACK = _T.PremiumCurrencyOnBuyItemResult
				}
				v9 = object:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
				v9:Execute("DisableDiorama", "true")
				v9:Execute("SetExitCallback", "OnDetailedViewComplete")
				v9:__wf_atom_0cf0fdbe(0.9)
			end
		end

		if not __wf_atom_7e8ad928(_T.OnPremiumCurrencyDone) then
			_T.OnPremiumCurrencyDone()
		end

		_T.PlatGridDisplayed = false
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ClosePurchaseDialog", "")
	v8 = object:PushChildMovie(_G.UIMovie_PlatBrowsingMovie)

	if _T.DisplayPrimeToken then
		v8:Execute("SetTitle", object:__wf_atom_8e9ac384("/Lotus/Language/Store/PurchasePrimedTokens", false))
	else
		v8:Execute("SetTitle", object:__wf_atom_8e9ac384("/Lotus/Language/Items/BrowsePlatinum", false))
	end

	v8:Execute("SetRequiredSelections", 1)
	v8:Execute("SetShowGridLabels", "true")
	v8:Execute("SetRequiresConfirmation", "false")
	v8:Execute("SetElementsFunction", "GetAllPremiumCurrencyItems")
	v8:Execute("SetSortByFunction", "GetPrimeCurrencyItemSorting")
	v8:Execute("SetCategoriesFunction", "GetPremiumCurrencyItemCategories")
	v8:Execute("SetCallBack", "BrowsePremiumCurrencyItemsDone")
	_T.PlatGridDisplayed = true
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("HideScreenForPlatPurchase", "true")
end

function GetMaxVoidTrace()
	if __wf_atom_7e8ad928(gGameData) then
		return 100
	end

	return 100 + gGameData:__wf_atom_a04e4a53() * 50
end

function GetCategoriesForShipPartStoreItem(object, data)
	local mki = nil
	local lavan = nil

	if __wf_atom_7e8ad928(object) then
		return mki, lavan
	end

	local __wf_atom_fee7bbed = object:__wf_atom_fee7bbed()

	for i = 1, #__wf_atom_fee7bbed do
		local v10 = __wf_atom_fee7bbed[i]

		if v10 == v6.MK.I then
			mki = data.MKI
		elseif v10 == v6.MK.II then
			mki = data.MKII
		elseif v10 == v6.MK.III then
			mki = data.MKIII
		elseif v10 == v6.AP.LAVAN then
			lavan = data.LAVAN
		elseif v10 == v6.AP.VIDAR then
			lavan = data.VIDAR
		elseif v10 == v6.AP.ZEKTI then
			lavan = data.ZEKTI
		elseif v10 == v6.AP.SIGMA then
			lavan = data.SIGMA
		end
	end

	return mki, lavan
end

function GetCompatibleSkins(object, object2, list)
	local v10 = { GameData = gGameData }
	local __wf_atom_71d5cc00 = gGameData:GetInventory():__wf_atom_71d5cc00()
	local v11 = {}
	local result = {}

	for _, v12 in ipairs(list) do
		if
			v12:IsA(__wf_atom_9df43583)
			and v12:__wf_atom_f3505c97()
			and v12:__wf_atom_5c4ffe31() ~= v12:__wf_atom_1bb5b1ff()
		then
			table.insert(v11, v12:__wf_atom_1bb5b1ff())
			table.insert(v11, v12:__wf_atom_5c4ffe31())
		else
			table.insert(v11, v12:__wf_atom_1bb5b1ff())
		end

		local v13

		if v12:IsA(__wf_atom_77e05d3b) then
			v13 = v12:__wf_atom_0e370890()
		end

		for _, skin in ipairs(__wf_atom_71d5cc00) do
			__wf_atom_83c14687(0)
			local storeItem = object2:GetStoreItem(skin.mItemType)

			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local isA = skin.mItemType:IsA(__wf_atom_abf506db)
			local v14 = v13 == nil or not isA or storeItem:__wf_atom_123d9c87(v13)
			__wf_atom_7e8ad928(v12)

			if not v14 then
				continue
			end

			local __wf_atom_7c09e378 = storeItem:__wf_atom_7c09e378()
			local flag = false

			for _, v15 in ipairs(v11) do
				if not v15:IsA(__wf_atom_7c09e378) then
					continue
				end

				flag = true
				break
			end

			if not flag then
				continue
			end

			local v15 = fn11(object, storeItem, skin.mItemType, v10)
			local v16 = ""

			if __wf_atom_7e8ad928(v15.LocalizedDesc) then
				v15.LocalizedDesc = ""
			end

			if skin.mUpgradeInstance ~= nil then
				v16 = skin.mUpgradeInstance:__wf_atom_f324d993(skin:__wf_atom_91d9f0e3())
			end

			if v16 ~= "" then
				v15.LocalizedDesc ..= "\r\n\r\n\r\n" .. object:__wf_atom_8e9ac384("<ENHANCER>", true) .. "\r\n" .. v16
			end

			v15.mStoreItem = storeItem
			v15.Name = skin:__wf_atom_056792b8()
			v15.Skin = skin
			v15.mPurchased = true
			v15.mPurchasedInfo = { UID = skin.mItemId.mId }
			v15.mSortId = #result
			table.insert(result, v15)
		end
	end

	return result
end

local function fn26(value)
	local v10

	if module2.IsDevServer() or module2.IsLocalServer() then
		if string.find(value, "www.soulframe.com") == nil then
			v10 = string.gsub(value, "soulframe.com", "dev.soulframe.com")
		else
			v10 = string.gsub(value, "www.soulframe.com", "dev.soulframe.com")
		end
	elseif module2.IsTestServer() then
		if string.find(value, "www.soulframe.com") == nil then
			v10 = string.gsub(value, "soulframe.com", "test.soulframe.com")
		else
			v10 = string.gsub(value, "www.soulframe.com", "test.soulframe.com")
		end
	else
		v10 = value
	end

	if Engine.__wf_atom_6f25c160() then
		if string.find(v10, "?") == nil then
			v10 ..= "?steam=1"
		else
			v10 ..= "&steam=1"
		end
	end

	if Engine.__wf_atom_eecb6143() then
		if string.find(v10, "?") == nil then
			v10 ..= "?epic=1"
		else
			v10 ..= "&epic=1"
		end
	end

	module.DoOpenWebBrowser(v10, value, true)
end

function OpenBrowserToStoreLink(p)
	fn26(p)
end

local function fn27(state, object, list)
	if state.IsExternalProduct and not __wf_atom_7e8ad928(object) then
		local __wf_atom_ba8e9d24 = object:__wf_atom_ba8e9d24(module2.GetProductId(state.StoreItem))
		local v10 = Engine.__wf_atom_eecb6143() and state.StoreItem:__wf_atom_56c51289() == 2 and true
			or __wf_atom_ba8e9d24
		local mState = object:__wf_atom_908586d9().mState

		if v10 and mState == 2 then
			if not __wf_atom_7e8ad928(list) then
				if __wf_atom_d9227398() then
					state.Icon = list[2]
				else
					state.Icon = list[1]
				end
			end

			state.PrimeAccessComingSoon = 1
			state.Name = Localize("/Lotus/Language/PrimeStore/ComingSoonPrimeAccessText", {})
		elseif object:__wf_atom_a1deff4d(module2.GetProductId(state.StoreItem)) then
			state.ExternalProductPurchased = 1
		else
			state.ExternalProductAvailable = 1
		end
	end
end

function CheckExternalProductState(p, p2, p3)
	fn27(p, p2, p3)
end

function OnExternalProductPressed(data, p, p2)
	data.StoreItem:__wf_atom_56c51289()
	local __wf_atom_eecb6143 = Engine.__wf_atom_eecb6143()
	fn27(data, p, p2)

	if data.PrimeAccessComingSoon then
		return false
	end

	if data.ExternalProductPurchased then
		module.ShowMessage("/Lotus/Language/Menu/Item_CannotPurchaseAlreadyOwned")
	elseif data.ExternalProductAvailable then
		if Engine.__wf_atom_84bb79c2() then
			if
				data.StoreItem:__wf_atom_bdbcec0a() ~= "9999"
				or not data.StoreItem:__wf_atom_d242670f():__wf_atom_8598f3a9()
			then
				return true
			end

			fn26(data.StoreItem:__wf_atom_d242670f():c_str())
		elseif Engine.__wf_atom_e43a530e() then
			local __wf_atom_bdbcec0a = data.StoreItem:__wf_atom_bdbcec0a()

			if data.StoreItem:__wf_atom_d242670f():__wf_atom_8598f3a9() then
				if __wf_atom_bdbcec0a == "9999" then
					fn26(data.StoreItem:__wf_atom_d242670f():c_str())
					return
				else
					local c_str = data.StoreItem:__wf_atom_d242670f():c_str()
					__wf_atom_bdbcec0a = (string.find(c_str, "prime-access", 1, true) ~= nil or string.find(c_str, "prime-vault", 1, true) ~= nil or string.find(c_str, "prime-resurgence", 1, true) ~= nil)
						and "PRIME_ACCESS"
						or __wf_atom_bdbcec0a
				end
			end

			module.DoShowPlatformStore(__wf_atom_bdbcec0a)
		elseif Engine.__wf_atom_b290ec01() then
			local __wf_atom_bdbcec0a = data.StoreItem:__wf_atom_bdbcec0a()

			if __wf_atom_bdbcec0a == "9999" and data.StoreItem:__wf_atom_d242670f():__wf_atom_8598f3a9() then
				fn26(data.StoreItem:__wf_atom_d242670f():c_str())
			elseif __wf_atom_a0f6588f:__wf_atom_5f4e19e3(__wf_atom_bdbcec0a) then
				module.DoShowPlatformStore(__wf_atom_bdbcec0a)
			else
				module.ShowMessage("/Lotus/Language/Menu/Store_AlreadyOwned_Switch")
			end
		else
			if Engine.__wf_atom_6f25c160() and module2.CheckSteamPurchaseAvailability(data.StoreItem) == "EXTERNAL" then
				return true
			end

			if Engine.__wf_atom_2a979d69() and gGameData:__wf_atom_23adb874(data.StoreItem:__wf_atom_bdbcec0a()) then
				return true
			end

			if
				data.StoreItem:__wf_atom_d242670f():__wf_atom_8598f3a9()
				and (Engine.__wf_atom_6f25c160() and not __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_01fbbcf8("steam_market") or not (Engine.__wf_atom_6f25c160() or __wf_atom_eecb6143))
			then
				fn26(data.StoreItem:__wf_atom_d242670f():c_str())
			elseif module2.__wf_atom_a8366d8a(data.StoreItem) == "EXTERNAL" then
				return true
			end
		end
	else
		module.ShowMessage("/Lotus/Language/Menu/Item_CannotPurchaseUnavailable")
	end

	return false
end

function IsPostWarItem(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return string.find(tostring(object:__wf_atom_5b41f63b()), "/Weapons/Archon/") ~= nil
end

function GetLocalizedItemName(object, instance)
	local v10 = GetPlatinumBundlePair(instance)

	if not __wf_atom_7e8ad928(v10) then
		instance = v10
	end

	if
		__wf_atom_7e8ad928(instance)
		or not instance:IsA(__wf_atom_cb425ff5)
		or __wf_atom_7e8ad928(instance:GetItem())
		or not instance:GetItem():IsA(__wf_atom_3cecff09)
	then
		local v11

		if instance:__wf_atom_efa6f447() == 35 then
			local v12 = -instance:__wf_atom_ee4fa4fd()
			v11 = module.FormatNumber(v12) .. " " .. object:__wf_atom_8e9ac384(
				tostring(instance:__wf_atom_014a76a2()),
				true
			)
		else
			v11 = tostring(instance:__wf_atom_014a76a2())
		end

		return object:__wf_atom_8e9ac384(v11, true)
	else
		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(tostring(instance:__wf_atom_619b1891()), true)

		if __wf_atom_8e9ac384 ~= "" and __wf_atom_8e9ac384 ~= nil then
			return __wf_atom_8e9ac384
		end

		local __wf_atom_e622b3f6 = instance:__wf_atom_e622b3f6()
		local v11

		if __wf_atom_7e8ad928(__wf_atom_e622b3f6) then
			v11 = object:__wf_atom_8e9ac384(tostring(instance:__wf_atom_014a76a2()), true)
		else
			v11 = object:__wf_atom_8e9ac384(tostring(__wf_atom_e622b3f6:__wf_atom_014a76a2()), true)
		end

		local v12 = { ITEM = v11 }
		local v13

		if instance:__wf_atom_d1d012ee() > 1 then
			v12.NUM = instance:__wf_atom_d1d012ee()
			v13 = "/Lotus/Language/Items/LargeBatchBlueprintAndItem"
		else
			v13 = "/Lotus/Language/Items/BlueprintAndItem"
		end

		return (object:__wf_atom_8e9ac384(v13, true, v12))
	end
end

function GetStoreItemTag(object)
	local v10 = GetPlatinumBundlePair(object)

	if __wf_atom_7e8ad928(v10) then
		return object:__wf_atom_014a76a2()
	end

	return v10:__wf_atom_014a76a2()
end

function GetPaidFromPlatBundlePair(instance)
	if
		not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_cb425ff5)
		and instance:IsPackage()
		and module2.IsExternalProduct(instance)
	then
		local platinumBundlePair = instance:GetPlatinumBundlePair()

		if not __wf_atom_7e8ad928(platinumBundlePair) then
			local v10 = Resource(platinumBundlePair)

			if not __wf_atom_7e8ad928(v10) and IsInMarketForCurrentPlatform(v10) then
				return v10
			end
		end
	end

	return nil
end

function GetPlatinumBundlePair(instance)
	if
		not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_cb425ff5)
		and instance:IsPackage()
		and not module2.IsExternalProduct(instance)
	then
		local platinumBundlePair = instance:GetPlatinumBundlePair()

		if not __wf_atom_7e8ad928(platinumBundlePair) then
			local v10 = Resource(platinumBundlePair)

			if not __wf_atom_7e8ad928(v10) and IsInMarketForCurrentPlatform(v10) then
				return v10
			end
		end
	end

	return nil
end

local function fn28(object)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(object) or not object:__wf_atom_12c87335() then
		return false
	end

	local storeItemPriceObject = module2.GetStoreItemPriceObject(object, nil, nil, false)

	if __wf_atom_7e8ad928(storeItemPriceObject.Sale) or not storeItemPriceObject.Sale.mHideFromMarket then
		if module2.CheckSteamPurchaseAvailability(object) == "UNAVAILABLE" then
			return false
		end

		return storeItemPriceObject.ShowInMarket
	else
		return false
	end
end

function IsInMarketForCurrentPlatform(p)
	return (fn28(p))
end

local function fn29(_, object, p, p2, object2, category, mItem, _, p3, p4)
	if __wf_atom_7e8ad928(mItem) then
		return false
	end

	local storeItem

	if mItem:IsA(__wf_atom_cb425ff5) then
		storeItem = Resource(mItem)
	elseif mItem:IsA(__wf_atom_f3c8513b) then
		storeItem = object:__wf_atom_232fd31d(mItem)
	else
		return false
	end

	local v10 = GetPaidFromPlatBundlePair(storeItem)

	if not __wf_atom_7e8ad928(v10) then
		storeItem = v10
	end

	for _, item in ipairs(category.Items) do
		if item.StoreItem:__wf_atom_5b41f63b() == mItem:__wf_atom_5b41f63b() then
			return false
		end
	end

	local v11 = {
		StoreItem = storeItem,
		NumOwned = module2.GetNumOwned(object2, p, storeItem, p2)
	}

	if
		p3 and not module2.CanPurchaseIfAlreadyOwned(v11.StoreItem) and v11.NumOwned ~= 0
		or not (__wf_atom_7e8ad928(p4) or #category.Items < p4)
	then
		return false
	end

	v11.category = category
	table.insert(category.Items, v11)
	return true
end

function GetLandingPageCategories(object, p, p2, purchasedItems, object2, object3, p3, p4)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local v10 = __wf_atom_7e8ad928(p4) and true or p4
	local __wf_atom_92662866 = object2:__wf_atom_92662866()
	local v11 = (__wf_atom_7e8ad928(__wf_atom_92662866) or not (#__wf_atom_92662866.mInGameMarket.mLandingPage.mCategories > 0))
		and {}
		or __wf_atom_92662866.mInGameMarket.mLandingPage.mCategories
	local result = {}

	for i, v12 in ipairs(v11) do
		local category = {
			mCategoryName = v12.mCategoryName,
			mName = v12.mName,
			mIcon = v12.mIcon,
			mAddToMenu = v12.mAddToMenu,
			Id = i,
			CategoryName = string.upper(v12.mCategoryName),
			Name = string.upper(object:__wf_atom_8e9ac384(v12.mName, true)),
			PurchasedItems = purchasedItems
		}

		if __wf_atom_7e8ad928(object3) then
			category.Icon = nil
		else
			category.Icon = object3:__wf_atom_3a3b6501(v12.mIcon, 0)
		end

		category.Items = {}

		for j = 1, #v12.mItems do
			fn29(object, p, p2, purchasedItems, object2, category, v12.mItems[j], j, v10, p3)
		end

		if #category.Items > 0 then
			table.insert(result, category)
		end
	end

	return result
end