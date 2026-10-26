local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = { ICON_RECIPE = 32, ICON_FLARE = 30, ICON_BG = 15, ICON = 18 }

local function fn(object, p, data, p2)
	local uiColor_DarkBrown = not data.IconColorOverride and 16777215 or data.IconColorOverride

	if not __wf_atom_7e8ad928(data.Icon) and module2.IsGreyscale(data.Icon) then
		uiColor_DarkBrown = _G.UIColor_DarkBrown
	end

	if not __wf_atom_7e8ad928(data.Tint) then
		uiColor_DarkBrown = data.Tint
	end

	object:__wf_atom_4c1c1986(p, "Icon", 11, uiColor_DarkBrown)

	if data.IsDummy then
		object:__wf_atom_4c1c1986(p, "IconBg", 11, _G.UIColor_DarkBrown)
	elseif data.UseWhiteBg then
		object:__wf_atom_4c1c1986(p, "IconBg", 11, _G.UIColor_White)
	elseif data.Premium then
		object:__wf_atom_4c1c1986(p, "IconBg", 11, _G.UIColor_Gold)
	else
		object:__wf_atom_4c1c1986(p, "IconBg", 11, _G.UIColor_Beige)
	end

	if data.UseWhiteBg then
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 11, _G.UIColor_White)
	else
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 11, _G.UIColor_DarkBrown)
	end

	if data.OwnsItem or not (p2 and p2.mFadeUnownedItems) then
		if
			(__wf_atom_7e8ad928(data.FadeUnselectableElements) or data.FadeUnselectableElements)
			and data.Unselectable
		then
			object:__wf_atom_4c1c1986(p, "Icon", 11, _G.UIColor_StrongFadedTint)
			object:__wf_atom_4c1c1986(p, "IconBg", 11, _G.UIColor_FadedBeige)
		end
	else
		object:__wf_atom_4c1c1986(p, "Icon", 11, _G.UIColor_Black)
		object:__wf_atom_4c1c1986(p, "Icon", 12, 50)
	end
end

local function fn2(object, p, p2, p3)
	local saleInfoBacker, v2 = GetVisRangeMaterials(p2, p3)
	object:OverrideMaterial(p .. ".SelectedCount.Text", v2)
	object:OverrideMaterial(p .. ".SelectedCount.Ring", saleInfoBacker)
	object:OverrideMaterial(p .. ".SelectedCount.Backer", saleInfoBacker)
	object:OverrideMaterial(p .. ".Icon", saleInfoBacker)
	object:OverrideMaterial(p .. ".IconBg", saleInfoBacker)
	object:OverrideMaterial(p .. ".IconBgSecondary", saleInfoBacker)
	object:OverrideMaterial(p .. ".IconOverlay", saleInfoBacker)
	object:OverrideMaterial(p .. ".StatusIconMini.Icon", saleInfoBacker)
	object:OverrideMaterial(p .. ".StatusIconMini.Shadow", saleInfoBacker)
	object:OverrideMaterial(p .. ".SecondaryStatusIconMini.Icon", saleInfoBacker)
	object:OverrideMaterial(p .. ".SecondaryStatusIconMini.Shadow", saleInfoBacker)
	object:OverrideMaterial(p .. ".SecondaryStatusIconMini.Text", v2)
	object:OverrideMaterial(p .. ".Count", saleInfoBacker)
	object:OverrideMaterial(p .. ".Count.Background", saleInfoBacker)
	object:OverrideMaterial(p .. ".ProgressBar.Cap", saleInfoBacker)
	object:OverrideMaterial(p .. ".ProgressBar.Trough", saleInfoBacker)
	object:OverrideMaterial(p .. ".Count.Text", v2)
	object:OverrideMaterial(p .. ".SaleInfo.Name", v2)
	object:__wf_atom_933bbce0(p .. ".IconFlare", _G.UITexture_ItemList[8], saleInfoBacker)
	object:__wf_atom_933bbce0(p .. ".RecipeIcon", _G.UITexture_ItemList[3], saleInfoBacker)
	local uiMaterial_TiledDivider = _G.UIMaterial_TiledDivider

	if p3 and p3.mVisRangeMaterials then
		if not __wf_atom_7e8ad928(p3.mVisRangeMaterials.SaleInfoBacker) then
			saleInfoBacker = p3.mVisRangeMaterials.SaleInfoBacker
		end

		if not __wf_atom_7e8ad928(p3.mVisRangeMaterials.SaleInfoDivider) then
			uiMaterial_TiledDivider = p3.mVisRangeMaterials.SaleInfoDivider
		end
	end

	object:OverrideMaterial(p .. ".SaleInfo.Backer", saleInfoBacker)
	object:OverrideMaterial(p .. ".SaleInfo.Divider", uiMaterial_TiledDivider)
end

local function fn3(object, p, p2, _)
	object:__wf_atom_4c1c1986(p, "Count.Text", 44, _G.UIColor_Tan)
	object:__wf_atom_4c1c1986(p, "Count.Background", 11, _G.UIColor_DarkerBrown)
	object:__wf_atom_4c1c1986(p, "Count.Background", 12, 80)
	object:__wf_atom_4c1c1986(p, "SelectedCount.Text", 44, _G.UIColor_Yellow)
	object:__wf_atom_4c1c1986(p, "SelectedCount.Ring", 11, _G.UIColor_Beige)
	object:__wf_atom_4c1c1986(p, "SelectedCount.Backer", 11, _G.UIColor_DarkerBrown)
	object:__wf_atom_4c1c1986(p, "SaleInfo.Name", 44, _G.UIColor_Beige)
	object:__wf_atom_4c1c1986(p, "SaleInfo.Backer", 11, _G.UIColor_DarkerBrown)
	object:__wf_atom_4c1c1986(p, "RecipeIcon", 12, 70)
	object:__wf_atom_4c1c1986(p, "IconBg", 12, 40)
	object:__wf_atom_4c1c1986(p, "IconBgSecondary", 12, 40)
	object:__wf_atom_4c1c1986(p, "IconBgSpacer", 12, 0)
	object:__wf_atom_4c1c1986(p, "SaleInfo.Backer", 12, 70)
	object:__wf_atom_4c1c1986(p, "SaleInfo.Divider", 12, 60)

	if p2.IsDummy then
		object:__wf_atom_e57658c2(p, 12, _G.UIAlpha_FadedBacker)
	else
		object:__wf_atom_e57658c2(p, 12, 100)
	end
end

local function fn4(object, p, data, data2)
	local v2 = data.WidthOverride and data.HeightOverride and true or false
	local widthOverride, heightOverride

	if data2 and data2.mColumnSeparation then
		widthOverride = data2.mColumnSeparation - data2.mPadding
		heightOverride = data2.mRowSeparation - data2.mPadding
	elseif data and data.WidthOverride and data.HeightOverride then
		widthOverride = data.WidthOverride
		heightOverride = data.HeightOverride
	else
		widthOverride = 90
		heightOverride = 90
	end

	if data2 or v2 then
		object:__wf_atom_4c1c1986(p, "IconOutline", 14, widthOverride)
		object:__wf_atom_4c1c1986(p, "IconOutline", 15, heightOverride)
		object:__wf_atom_4c1c1986(p, "RecipeIcon", 14, widthOverride - v.ICON_RECIPE)
		object:__wf_atom_4c1c1986(p, "RecipeIcon", 15, heightOverride - v.ICON_RECIPE)
		object:__wf_atom_4c1c1986(p, "IconFlare", 14, widthOverride - v.ICON_FLARE)
		object:__wf_atom_4c1c1986(p, "IconFlare", 15, heightOverride - v.ICON_FLARE)
		object:__wf_atom_4c1c1986(p, "IconBg", 14, widthOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "IconBg", 15, heightOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 14, widthOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 15, heightOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "IconBgSpacer", 14, widthOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "IconBgSpacer", 15, heightOverride - v.ICON_BG)
		object:__wf_atom_4c1c1986(p, "Btn", 14, widthOverride)
		object:__wf_atom_4c1c1986(p, "Btn", 15, heightOverride)
		local halfWidthOverride = widthOverride / 2
		local halfHeightOverride = heightOverride / 2
		object:__wf_atom_4c1c1986(p, "Count", 0, halfWidthOverride)
		object:__wf_atom_4c1c1986(p, "Count", 1, -halfHeightOverride + 43)
		local v3 = halfWidthOverride - 20
		local v4 = halfHeightOverride - 20
		object:__wf_atom_4c1c1986(p, "StatusIconMini", 0, -v3 - 14)
		object:__wf_atom_4c1c1986(p, "StatusIconMini", 1, -v4 - 14)
		local v5 = widthOverride / 134
		local v6 = heightOverride / 134

		if v5 < 1 and v6 < 1 then
			object:__wf_atom_4c1c1986(p, "RankIconMini", 0, -v3 * v5 - 9)
		else
			object:__wf_atom_4c1c1986(p, "RankIconMini", 0, -v3)
		end

		object:__wf_atom_4c1c1986(p, "RankIconMini", 1, -v4)
		local v7 = 11
		object:__wf_atom_4c1c1986(p, "ProgressBar", 0, -halfWidthOverride + v7)
		object:__wf_atom_4c1c1986(p, "ProgressBar", 1, halfHeightOverride - 11)
		object:__wf_atom_4c1c1986(p, "ProgressBar.Trough", 14, widthOverride - v7 * 2)
	end

	local v3 = widthOverride - v.ICON
	local v4 = heightOverride - v.ICON
	local v5 = not data.ExtraOverlayPadding and 0 or data.ExtraOverlayPadding
	object:__wf_atom_4c1c1986(p, "IconOverlay", 14, v3 + v5)
	object:__wf_atom_4c1c1986(p, "IconOverlay", 15, v4 + v5)

	if data2 and not __wf_atom_7e8ad928(data.StoreItem) and data.StoreItem:IsA(__wf_atom_654b40cd) then
		object:__wf_atom_4c1c1986(p, "Icon", 14, v3 * 0.7)
		object:__wf_atom_4c1c1986(p, "Icon", 15, v4 * 0.7)
		object:__wf_atom_4c1c1986(p, "Icon", 1, -v4 * 0.1)
	elseif data.SquareIcon then
		local v6 = math.min(v3, v4)
		object:__wf_atom_4c1c1986(p, "Icon", 14, v6)
		object:__wf_atom_4c1c1986(p, "Icon", 15, v6)
		object:__wf_atom_4c1c1986(p, "IconFlare", 14, v6)
		object:__wf_atom_4c1c1986(p, "IconFlare", 15, v6)
		object:__wf_atom_4c1c1986(p, "Icon", 1, 0)
	else
		object:__wf_atom_4c1c1986(p, "Icon", 14, v3)
		object:__wf_atom_4c1c1986(p, "Icon", 15, v4)
		object:__wf_atom_4c1c1986(p, "Icon", 1, 0)
	end
end

local function fn5(object, p, data, data2, p2)
	local smallPriceMode = not __wf_atom_7e8ad928(data.MetaData) and data.MetaData.SmallPriceMode
	local v2 = data.TopperIcon ~= nil

	if data.MetaData and data.MetaData.HidePrice then
		return ""
	end

	local v3, v4 = GetVisRangeMaterials(data, data2)
	local priceInfoBacker

	if data2 and data2.mVisRangeMaterials and not __wf_atom_7e8ad928(data2.mVisRangeMaterials.PriceInfoBacker) then
		priceInfoBacker = data2.mVisRangeMaterials.PriceInfoBacker
	else
		priceInfoBacker = v3
	end

	local v5 = 1
	local v6 = nil
	local prices = data.Prices
	local formatted = nil
	local formatted2 = nil

	local function fn6()
		local v7

		if smallPriceMode or v2 then
			v7 = p .. ".SaleInfo.Prices.Price" .. v5
		else
			v7 = p .. ".Prices.Price" .. v5
		end

		v6 = v7

		if smallPriceMode then
			object:__wf_atom_e57658c2(v6, 1, 8)
		end

		if not object:__wf_atom_253d7085(v6) then
			__wf_atom_86cbd68d(object, v6, v5)
			object:__wf_atom_e57658c2(v6, 1, (v5 - 1) * 32)
		end

		v5 += 1
		object:__wf_atom_7f57ab2f(v6, "Backer", 13, true)
		object:__wf_atom_7f57ab2f(v6, "Shadow", 13, false)
		object:__wf_atom_48bd5a59(v6, "Label", 36, formatted2)
		local v8 = #formatted > 0

		if v8 then
			local v9 = object:__wf_atom_cfc41e35(v6, "Label", 40) + 40
			formatted2 = object:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. "<font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">" .. formatted2 .. "</font></font></p>"
			object:__wf_atom_48bd5a59(v6, "Label", 36, "<p><font >" .. formatted .. formatted2)
			local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(v6, "Label", 40)
			object:__wf_atom_4c1c1986(v6, "Strike", 0, -(__wf_atom_cfc41e35 + 40) / 2)
			object:__wf_atom_4c1c1986(v6, "Strike", 14, v9)
			object:OverrideMaterial(v6 .. ".Strike", v3)
		end

		object:__wf_atom_7f57ab2f(v6, "Strike", 13, v8)
		object:__wf_atom_4c1c1986(v6, "Label", 14, p2)
		object:__wf_atom_4c1c1986(v6, "Label", 0, -p2 / 2)
		object:__wf_atom_4c1c1986(v6, "Backer", 14, object:__wf_atom_cfc41e35(v6, "Label", 40) + 60)
		object:__wf_atom_4c1c1986(v6, "Shadow", 14, object:__wf_atom_cfc41e35(v6, "Label", 40) + 0)
		object:OverrideMaterial(v6 .. ".Label", v4)
		object:OverrideMaterial(v6 .. ".Backer", priceInfoBacker)
		object:__wf_atom_4c1c1986(v6, "Label", 44, _G.UIColor_Beige)

		if smallPriceMode then
			object:__wf_atom_7f57ab2f(v6, "Backer", 13, false)
			object:__wf_atom_7f57ab2f(v6, "Shadow", 13, false)
		end
	end

	if prices.ExternalProduct and not __wf_atom_7e8ad928(gGameData) then
		if data.Owned then
			formatted2 = object:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedCheck", true)
			formatted = nil
		else
			formatted2 = prices.CatalogProductData.listPrice.formatted

			if prices.DiscountTags.Sale then
				formatted = prices.CatalogProductData.basePrice.formatted
			else
				formatted = nil
			end
		end

		fn6()
	elseif prices.ShowInMarket then
		local v7 = prices.UsePremium and "/SF/Language/Currency/PremiumCurrencyAmount"
			or "/SF/Language/Currency/CurrencyAmount"

		if data.Owned and not module3.CanPurchaseIfAlreadyOwned(data.StoreItem) then
			formatted2 = object:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedCheck", true)
			formatted = nil
		else
			formatted2 = object:__wf_atom_8e9ac384(v7, true, {
				AMOUNT = module.FormatNumber(prices.UsePrice)
			})

			if prices.FinalDiscountPercent > 0 then
				formatted = object:__wf_atom_8e9ac384(v7, true, {
					AMOUNT = module.FormatNumber(prices.UseOriginalPrice)
				})
			else
				formatted = nil
			end
		end

		fn6()
	end

	if smallPriceMode or v2 then
		v6 = p .. ".SaleInfo.Prices.Price" .. v5
	else
		v6 = p .. ".Prices.Price" .. v5
	end

	while object:__wf_atom_253d7085(v6) do
		__wf_atom_86cbd68d(object, v6 .. ".removeMovieClip")
		v5 += 1

		if smallPriceMode or v2 then
			v6 = p .. ".SaleInfo.Prices.Price" .. v5
		else
			v6 = p .. ".Prices.Price" .. v5
		end
	end

	local v7 = p .. ".Prices"
	local widthOverride, heightOverride

	if data2 and data2.mColumnSeparation then
		widthOverride = data2.mColumnSeparation - data2.mPadding
		heightOverride = data2.mRowSeparation - data2.mPadding
	elseif data and data.WidthOverride and data.HeightOverride then
		widthOverride = data.WidthOverride
		heightOverride = data.HeightOverride
	else
		widthOverride = 90
		heightOverride = 90
	end

	local v8 = -widthOverride / 2
	local v9 = -heightOverride / 2
	local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(v7, "Price1.Backer", 14)
	local __wf_atom_cfc41e35_2 = object:__wf_atom_cfc41e35(v7, "Price1.Backer", 15)
	object:__wf_atom_e57658c2(v7, 0, v8 + __wf_atom_cfc41e35 / 2 - 5)
	object:__wf_atom_e57658c2(v7, 1, v9 + __wf_atom_cfc41e35_2 / 2 - 5)
end

local function fn6(object, p, data, data2)
	local v2 = data.TopperIcon ~= nil
	local prices = data.Prices
	local smallPriceMode = not __wf_atom_7e8ad928(data.MetaData) and data.MetaData.SmallPriceMode
	local v3

	if smallPriceMode or v2 then
		v3 = p .. ".SaleInfo.Prices"
	else
		v3 = p .. ".Prices"
	end

	object:__wf_atom_7f57ab2f(p, "SaleInfo", 13, prices ~= nil)
	object:__wf_atom_7f57ab2f(p, "SaleInfo.Name", 13, true)
	object:__wf_atom_7f57ab2f(p, "SaleInfo.Backer", 13, true)
	object:__wf_atom_7f57ab2f(p, "SaleInfo.Divider", 13, v2)

	if prices ~= nil then
		object:__wf_atom_7f57ab2f(p, "Prices", 13, not (smallPriceMode or v2))
		local widthOverride, heightOverride

		if data2 and data2.mColumnSeparation then
			widthOverride = data2.mColumnSeparation - data2.mPadding
			heightOverride = data2.mRowSeparation - data2.mPadding
		elseif data and data.WidthOverride and data.HeightOverride then
			widthOverride = data.WidthOverride
			heightOverride = data.HeightOverride
		else
			widthOverride = 90
			heightOverride = 90
		end

		local v4 = widthOverride - v.ICON
		local v5 = (heightOverride - v.ICON) / 2
		object:__wf_atom_4c1c1986(p, "SaleInfo.Name", 14, v4)
		object:__wf_atom_4c1c1986(p, "SaleInfo.Name", 0, -v4 / 2)
		object:__wf_atom_4c1c1986(p, "SaleInfo.Backer", 14, v4)
		local name = data.Name

		if data.SubString ~= nil then
			name ..= "\r" .. data.SubString
		end

		object:__wf_atom_48bd5a59(p, "SaleInfo.Name", 36, name)
		fn5(object, p, data, data2, v4)
		local v6 = 0

		if not smallPriceMode then
			local v7 = v6 + 12
			object:__wf_atom_4c1c1986(p, "SaleInfo.Name", 1, v7)
			v6 = v7 + object:__wf_atom_cfc41e35(p, "SaleInfo.Name", 41) + 12

			if v2 then
				object:__wf_atom_4c1c1986(p, "SaleInfo.Divider", 1, v6)
				v6 += 8
			end
		end

		if smallPriceMode or v2 then
			object:__wf_atom_e57658c2(v3, 1, v6)
			v6 += object:__wf_atom_5e6e15c8(v3, 15)
		end

		if not smallPriceMode then
			v6 += 4
		end

		object:__wf_atom_4c1c1986(p, "SaleInfo.Backer", 15, v6)
		object:__wf_atom_4c1c1986(p, "SaleInfo", 1, v5 - v6)
		local v7 = v4 - 40
		object:__wf_atom_4c1c1986(p, "SaleInfo.Divider", 14, v7)
		object:__wf_atom_1ca72041(p .. ".SaleInfo.Divider", "TileRepeats", v7 / 32, 1, 0, 0)

		if data2 and data2.mVisRangeMaterials and not __wf_atom_7e8ad928(data2.mVisRangeMaterials.SaleInfoBacker) then
			object:__wf_atom_1ca72041(p .. ".SaleInfo.Backer", "TileRepeats", v4 / 512, v6 / 128, 0, 0)
		end
	end

	if not smallPriceMode then
		object:__wf_atom_7f57ab2f(p, "SaleInfo.Prices", 13, v2)
		return
	end

	object:__wf_atom_7f57ab2f(p, "SaleInfo.Name", 13, false)
	object:__wf_atom_7f57ab2f(p, "SaleInfo.Divider", 13, false)
end

local function fn7(object, p, data, _)
	local v2 = not __wf_atom_7e8ad928(data.Icon)
	object:__wf_atom_7f57ab2f(p, "Icon", 13, v2)

	if v2 then
		object:__wf_atom_c90af43a(p .. ".Icon", data.Icon)
	end

	if data.IconWidthOverride then
		object:__wf_atom_4c1c1986(p, "Icon", 14, data.IconWidthOverride)
	end

	if data.IconHeightOverride then
		object:__wf_atom_4c1c1986(p, "Icon", 15, data.IconHeightOverride)
	end

	if data.IconAlphaOverride then
		object:__wf_atom_4c1c1986(p, "Icon", 12, data.IconAlphaOverride)
	else
		object:__wf_atom_4c1c1986(p, "Icon", 12, 100)
	end

	if data.IconColorOverride then
		object:__wf_atom_4c1c1986(p, "Icon", 11, data.IconColorOverride)
	else
		object:__wf_atom_4c1c1986(p, "Icon", 11, 16777215)
	end

	local v3 = not __wf_atom_7e8ad928(data.IconOverlay)
	object:__wf_atom_7f57ab2f(p, "IconOverlay", 13, v3)

	if v3 then
		object:__wf_atom_c90af43a(p .. ".IconOverlay", data.IconOverlay)
	end

	object:__wf_atom_7f57ab2f(p, "RecipeIcon", 13, data.ShowRecipeIcon == true)
	object:__wf_atom_2dedec1a(p, 13, not (data.Header or data.HideGridItem))
end

local function fn8(object, p, p2, p3)
	fn(object, p, p2, p3)
	local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(p, "IconBgSpacer", 15)
	local v2 = not p2.mBgRatio and 1 or p2.mBgRatio
	object:__wf_atom_7f57ab2f(p, "IconBg", 13, v2 ~= 0)
	object:__wf_atom_4c1c1986(p, "IconBg", 1, __wf_atom_104bfe98(__wf_atom_cfc41e35 / 2, 0, v2))
	object:__wf_atom_4c1c1986(p, "IconBg", 15, __wf_atom_cfc41e35 * v2)
	object:__wf_atom_7f57ab2f(p, "IconBgSecondary", 13, v2 ~= 1)

	if v2 ~= 1 then
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 1, __wf_atom_104bfe98(-__wf_atom_cfc41e35 / 2, 0, 1 - v2))
		object:__wf_atom_4c1c1986(p, "IconBgSecondary", 15, __wf_atom_cfc41e35 * (1 - v2))
	end
end

local function fn9(object, p, infoPopup_Data, infoPopup_Grid)
	local focused = infoPopup_Data.Focused or false
	local mVisRangeMaterials = infoPopup_Grid ~= nil and infoPopup_Grid.mVisRangeMaterials
		or infoPopup_Data == nil and {}
		or infoPopup_Data.mVisRangeMaterials
		or {}
	local uiMaterial_BackerBorderSingle

	if not (infoPopup_Data.SkipDefaultMaterials or infoPopup_Grid ~= nil and infoPopup_Grid.mSkipDefaultMaterials) then
		uiMaterial_BackerBorderSingle = _G.UIMaterial_BackerBorderSingle
	end

	if focused then
		local focusedItem = mVisRangeMaterials.FocusedItem or uiMaterial_BackerBorderSingle
		object:OverrideMaterial(p .. ".IconOutline", focusedItem)
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(_G.UIColor_Yellow)
		object:__wf_atom_1ca72041(
			p .. ".IconOutline",
			"TintColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)

		if infoPopup_Grid ~= nil and infoPopup_Grid.mShowInfoPopup then
			module2.SetItemInfoPopupRect(
				object,
				infoPopup_Data,
				object:__wf_atom_cfc41e35(p, "IconOutline", 2),
				object:__wf_atom_cfc41e35(p, "IconOutline", 3),
				object:__wf_atom_cfc41e35(p, "IconOutline", 14),
				object:__wf_atom_cfc41e35(p, "IconOutline", 15)
			)
			_T.InfoPopup_Data = infoPopup_Data
			_T.InfoPopup_Grid = infoPopup_Grid
		end
	else
		if infoPopup_Grid ~= nil and infoPopup_Grid.mShowInfoPopup then
			_T.InfoPopup_Data = nil
			_T.InfoPopup_Grid = nil
		end

		if infoPopup_Data.CanCraft then
			local selectedItem = mVisRangeMaterials.SelectedItem or uiMaterial_BackerBorderSingle
			object:OverrideMaterial(p .. ".IconOutline", selectedItem)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(_G.UIColor_BlueGreen)
			object:__wf_atom_1ca72041(
				p .. ".IconOutline",
				"TintColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
		else
			local unfocusedItem = mVisRangeMaterials.UnfocusedItem or uiMaterial_BackerBorderSingle
			object:OverrideMaterial(p .. ".IconOutline", unfocusedItem)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(_G.UIColor_Brown)
			object:__wf_atom_1ca72041(
				p .. ".IconOutline",
				"TintColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
		end
	end

	local __wf_atom_5cafd05b = object:__wf_atom_5cafd05b(p .. ".IconOutline")

	if not __wf_atom_7e8ad928(__wf_atom_5cafd05b) then
		local __wf_atom_611e7c82 = __wf_atom_5cafd05b:__wf_atom_611e7c82(Symbol("SliceAtlas"))

		if not (__wf_atom_7e8ad928(__wf_atom_611e7c82) or module2.IsGreyscale(__wf_atom_611e7c82)) then
			object:__wf_atom_1ca72041(p .. ".IconOutline", "TintColor", 1, 1, 1, 1)
		end
	end
end

function SetSecondaryStatus(object, p, data, data2)
	if p == nil then
		return
	end

	local v2 = p .. ".SecondaryStatusIconMini"
	local v3, v4 = GetVisRangeMaterials(data, data2)
	local gridItemTags = module2.GetGridItemTags(object, data2, data, {})

	if not __wf_atom_7e8ad928(data.CustomSecondaryStatus) then
		table.insert(gridItemTags, {
			IsSecondaryStatus = true,
			ShowInGrid = true,
			Priority = 0,
			RightJustified = true,
			IconScale = 100,
			CustomTag = true,
			CustomIcon = data.SecondaryStatusIcon
		})
	end

	local v5 = 2

	while object:__wf_atom_253d7085(v2 .. "_" .. v5) do
		__wf_atom_86cbd68d(object, v2 .. "_" .. v5 .. ".removeMovieClip")
		v5 += 1
	end

	object:__wf_atom_2dedec1a(v2, 13, false)
	local gridItemTags2 = {}

	for k, gridItemTag in gridItemTags do
		if not (gridItemTag and gridItemTag.ShowInGrid and gridItemTag.IsSecondaryStatus) then
			continue
		end

		gridItemTag.Priority = gridItemTag.Priority or 0
		gridItemTag.OriginalIndex = k
		table.insert(gridItemTags2, gridItemTag)
	end

	table.sort(gridItemTags2, function(a, b)
		if a.Priority == b.Priority then
			return a.OriginalIndex < b.OriginalIndex
		end

		return a.Priority < b.Priority
	end)
	local widthOverride, heightOverride

	if data2 and data2.mColumnSeparation then
		widthOverride = data2.mColumnSeparation - data2.mPadding
		heightOverride = data2.mRowSeparation - data2.mPadding
	elseif data and data.WidthOverride and data.HeightOverride then
		widthOverride = data.WidthOverride
		heightOverride = data.HeightOverride
	else
		widthOverride = 90
		heightOverride = 90
	end

	local v6 = widthOverride / 2 + 5
	local v7 = -widthOverride / 2 - 5
	local v8 = -heightOverride / 2 - 5

	if object:__wf_atom_a91463a8(p .. ".Count", 13) then
		v6 -= object:__wf_atom_5e6e15c8(p .. ".Count.Background", 14)
	end

	if object:__wf_atom_a91463a8(p .. ".Prices", 13) then
		v7 += object:__wf_atom_5e6e15c8(p .. ".Prices.Price1.Shadow", 14) + 30
	end

	local v9 = 1

	for _, v10 in gridItemTags2 do
		local v11 = v9 == 1 and "" or "_" .. v9
		v9 += 1
		local v12 = v2 .. v11

		if not object:__wf_atom_253d7085(v12) then
			__wf_atom_86cbd68d(object, v2 .. ".duplicateMovieClip", "SecondaryStatusIconMini" .. v11, v9)
			object:OverrideMaterial(v12 .. ".Icon", v3)
			object:OverrideMaterial(v12 .. ".Shadow", v3)
			object:OverrideMaterial(v12 .. ".Text", v4)
		end

		local v13 = nil
		local customIcon

		if v10.CustomTag then
			customIcon = v10.CustomIcon
		else
			customIcon = _G.UITexture_LabelIcons[v10.Type]
			v13 = _G.UITexture_LabelIconShadows[v10.Type]
		end

		if customIcon then
			object:__wf_atom_c90af43a(v12 .. ".Icon", customIcon)
			object:__wf_atom_2dedec1a(v12, 13, true)
			object:__wf_atom_2dedec1a(v12 .. ".Icon", 13, true)
			local v14 = not v10.IconScale and 100 or v10.IconScale
			object:__wf_atom_e57658c2(v12 .. ".Icon", 5, v14)
			object:__wf_atom_e57658c2(v12 .. ".Icon", 6, v14)
		else
			object:__wf_atom_2dedec1a(v12, 13, false)
			object:__wf_atom_2dedec1a(v12 .. ".Icon", 13, false)
		end

		if v13 then
			object:__wf_atom_c90af43a(v12 .. ".Shadow", v13)
			object:__wf_atom_2dedec1a(v12 .. ".Shadow", 13, true)
		else
			object:__wf_atom_2dedec1a(v12 .. ".Shadow", 13, false)
		end

		if v10.iconText then
			object:__wf_atom_48bd5a59(v12, "Text", 36, object:__wf_atom_8e9ac384(v10.iconText, true))
			object:__wf_atom_2dedec1a(v12, 13, true)
			object:__wf_atom_2dedec1a(v12 .. ".Text", 13, true)
			local v14 = not v10.IconScale and 100 or v10.IconScale
			object:__wf_atom_e57658c2(v12 .. ".Text", 5, v14)
			object:__wf_atom_e57658c2(v12 .. ".Text", 6, v14)
		else
			object:__wf_atom_2dedec1a(v12 .. ".Text", 13, false)
		end

		object:__wf_atom_e57658c2(v12, 5, 100)
		object:__wf_atom_e57658c2(v12, 6, 100)
		local v14 = not v10.spacingReduction and 0 or v10.spacingReduction
		local v15 = object:__wf_atom_5e6e15c8(v12, 14) / 2 - v14

		if v10.RightJustified then
			v6 -= v15
			object:__wf_atom_e57658c2(v12, 0, v6)
		else
			v7 += v15
			object:__wf_atom_e57658c2(v12, 0, v7)
		end

		local v16 = v8 + object:__wf_atom_5e6e15c8(v12, 15) / 2

		if v10.yOffset then
			v16 += v10.yOffset
		end

		object:__wf_atom_e57658c2(v12, 1, v16)
	end
end

local function fn10(object, p, data, data2)
	local v2 = not __wf_atom_7e8ad928(data.StatusIcon) or data.Equipped or false
	local v3 = not __wf_atom_7e8ad928(data.StatusIconShadow) or false
	object:__wf_atom_7f57ab2f(p, "StatusIconMini", 13, v2)
	object:__wf_atom_7f57ab2f(p, "StatusIconMini.Shadow", 13, v3)
	local statusIcon = data.StatusIcon
	local statusIconShadow = data.StatusIconShadow

	if statusIcon == nil and data.Equipped then
		statusIcon = _G.UITexture_ItemList[12]
	end

	local statusIconOffset = data.StatusIconOffset or 0
	object:__wf_atom_4c1c1986(p, "StatusIconMini.Icon", 0, statusIconOffset)
	object:__wf_atom_4c1c1986(p, "StatusIconMini.Icon", 1, statusIconOffset)
	object:__wf_atom_4c1c1986(p, "StatusIconMini.Shadow", 0, statusIconOffset)
	object:__wf_atom_4c1c1986(p, "StatusIconMini.Shadow", 1, statusIconOffset)
	object:__wf_atom_c90af43a(p .. ".StatusIconMini.Icon", statusIcon)
	object:__wf_atom_c90af43a(p .. ".StatusIconMini.Shadow", statusIconShadow)

	if not __wf_atom_7e8ad928(data.mItem) and data.mItem.mFavorite then
		if not object:__wf_atom_253d7085(p .. ".StatusIconFavorite") then
			__wf_atom_86cbd68d(object, p .. ".StatusIconMini.duplicateMovieClip", "StatusIconFavorite", 1)
			local v4, _ = GetVisRangeMaterials(data, data2)
			local widthOverride

			if data2 and data2.mColumnSeparation then
				widthOverride = data2.mColumnSeparation - data2.mPadding
				local _ = data2.mRowSeparation - data2.mPadding
			elseif data and data.WidthOverride and data.HeightOverride then
				widthOverride = data.WidthOverride
				local _heightOverride = data.HeightOverride
			else
				widthOverride = 90
			end

			local uiTexture_LabelIcon = _G.UITexture_LabelIcons[module2.LABEL_TYPE_FAVORITE]
			object:__wf_atom_7f57ab2f(p, "StatusIconFavorite", 13, true)
			object:__wf_atom_7f57ab2f(p, "StatusIconFavorite.Icon", 13, true)
			object:__wf_atom_7f57ab2f(p, "StatusIconFavorite.Shadow", 13, false)
			object:__wf_atom_7f57ab2f(p, "StatusIconFavorite.Text", 13, false)
			object:OverrideMaterial(p .. ".StatusIconFavorite.Icon", v4)
			object:__wf_atom_c90af43a(p .. ".StatusIconFavorite.Icon", uiTexture_LabelIcon)
			object:__wf_atom_4c1c1986(p, "StatusIconFavorite.Icon", 0, widthOverride - 14)
			object:__wf_atom_4c1c1986(p, "StatusIconFavorite.Icon", 1, 0)
			object:__wf_atom_4c1c1986(p, "StatusIconFavorite.Icon", 14, 28)
			object:__wf_atom_4c1c1986(p, "StatusIconFavorite.Icon", 15, 28)
		end
	elseif object:__wf_atom_253d7085(p .. ".StatusIconFavorite") then
		__wf_atom_86cbd68d(object, p .. ".StatusIconFavorite.removeMovieClip")
	end
end

local function fn11(object, p, p2, _)
	if not p2.RippleOutline then
		object:__wf_atom_1ca72041(p .. ".IconOutline", "RippleSettings", 0, 0, 1, 1)
		return
	end

	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(p2.RippleColor or _G.UIColor_Yellow)
	object:__wf_atom_1ca72041(
		p .. ".IconOutline",
		"RipplesColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		1
	)
	object:__wf_atom_1ca72041(p .. ".IconOutline", "RippleSettings", 50, 2, 0.1, 0.5)
	object:__wf_atom_1ca72041(p .. ".IconOutline", "RippleCenter", 2, -2, 0, 0)
	object:__wf_atom_1ca72041(p .. ".IconOutline", "RippleAnimationSettings", 3, 3, 1, 1)
end

local function fn12(object, p, data, p2)
	object:__wf_atom_7f57ab2f(p, "RankIconMini", 13, false)

	if not p2 or (__wf_atom_7e8ad928(data.RawItem) or data.RawItem.mQuality == nil and data.Quality == nil) then
		return
	end

	if __wf_atom_7e8ad928(data.Type) or not data.Type:IsA(__wf_atom_77e05d3b) and data.Quality == nil then
		return
	end

	local mQuality = data.RawItem.mQuality or data.Quality

	if mQuality <= 0 then
		return
	end

	object:__wf_atom_7f57ab2f(p, "RankIconMini", 13, true)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p .. ".IconBg", 14)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p .. ".IconBg", 15)
	local v2, _ = GetVisRangeMaterials(data, p2)
	local v3 = p .. ".RankIconMini"
	local v4 = _G.UITexture_ItemList[17]
	local v5 = _G.UITexture_ItemList[18]
	local v6 = _G.UITexture_ItemList[15]
	local v7 = _G.UITexture_ItemList[16]
	local v8 = __wf_atom_5e6e15c8_2 - 11
	object:__wf_atom_2dedec1a(v3, 13, true)
	__wf_atom_86cbd68d(object, v3 .. ".swapDepths", 200)

	if object:__wf_atom_253d7085(v3) then
		local v9 = 35 + mQuality * 11
		local __wf_atom_b90af225 = v2:__wf_atom_b90af225(SF.__wf_atom_5ddc828f, 1)
		local __wf_atom_b90af225_2 = v2:__wf_atom_b90af225(SF.__wf_atom_cf0d1cc6, 1)
		local __wf_atom_b90af225_3 = v2:__wf_atom_b90af225(SF.__wf_atom_7a5b8f59, 1)
		local v10 = __wf_atom_5e6e15c8 / 2 - 11
		local v11 = Resource("/SF/Interface/Materials/ItemQualityBackerMaterial")
		local v12 = Resource("/SF/Interface/Materials/ItemQualityBorderMaterial")
		module.ScaleSlicedMaterials(object, { v12, v11 })
		v11:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, __wf_atom_b90af225)
		v11:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, __wf_atom_b90af225_2)
		v11:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, __wf_atom_b90af225_3)
		v12:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, __wf_atom_b90af225)
		v12:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, __wf_atom_b90af225_2)
		v12:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, __wf_atom_b90af225_3)
		object:__wf_atom_933bbce0(v3 .. ".Shadow", v4, v11)
		object:__wf_atom_933bbce0(v3 .. ".Icon", v5, v12)
		object:__wf_atom_4c1c1986(v3, "Shadow", 0, v10)
		object:__wf_atom_4c1c1986(v3, "Shadow", 1, v8)
		object:__wf_atom_4c1c1986(v3, "Shadow", 14, v9)
		object:__wf_atom_4c1c1986(v3, "Shadow", 15, 32)
		object:__wf_atom_4c1c1986(v3, "Shadow", 11, _G.UIColor_DarkerBrown)
		object:__wf_atom_4c1c1986(v3, "Icon", 0, v10)
		object:__wf_atom_4c1c1986(v3, "Icon", 1, v8)
		object:__wf_atom_4c1c1986(v3, "Icon", 14, v9)
		object:__wf_atom_4c1c1986(v3, "Icon", 15, 32)
		object:__wf_atom_4c1c1986(v3, "Icon", 11, _G.UIColor_Gold)
	end

	for i = 1, 7 do
		local v9 = v3 .. ".Icon" .. i
		local v10 = v3 .. ".Shadow" .. i
		object:__wf_atom_2dedec1a(v9, 13, false)
		object:__wf_atom_2dedec1a(v10, 13, false)
	end

	for i = 1, mQuality do
		local v9 = v3 .. ".Icon" .. i
		local v10 = v3 .. ".Shadow" .. i

		if not object:__wf_atom_253d7085(v3 .. ".Icon" .. i) then
			__wf_atom_86cbd68d(object, v3 .. ".Shadow.duplicateMovieClip", "Shadow" .. i, 120 + i)
			__wf_atom_86cbd68d(object, v3 .. ".Icon.duplicateMovieClip", "Icon" .. i, 130 + i)
			object:__wf_atom_933bbce0(v9, v6, v2)
			object:__wf_atom_933bbce0(v10, v7, v2)
		end

		object:__wf_atom_e57658c2(v9, 12, 100)
		local v11 = __wf_atom_5e6e15c8 / 2 - (mQuality - 1) * 11 / 2 + (i - 1) * 11 - 11
		object:__wf_atom_e57658c2(v10, 12, 50)
		object:__wf_atom_e57658c2(v9, 0, v11)
		object:__wf_atom_e57658c2(v10, 0, v11)
		object:__wf_atom_e57658c2(v9, 1, v8)
		object:__wf_atom_e57658c2(v10, 1, v8)
		object:__wf_atom_e57658c2(v9, 11, _G.UIColor_White)
		object:__wf_atom_e57658c2(v10, 11, _G.UIColor_White)
		object:__wf_atom_2dedec1a(v9, 13, true)
		object:__wf_atom_e57658c2(v9, 14, 15)
		object:__wf_atom_e57658c2(v9, 15, 15)
	end
end

local function fn13(object, p, p2, _)
	local v2 = not __wf_atom_7e8ad928(p2.Progress)
	object:__wf_atom_7f57ab2f(p, "ProgressBar", 13, v2)

	if v2 then
		local v3 = __wf_atom_421b01aa(p2.Progress, 0, 1)
		object:__wf_atom_4c1c1986(p, "ProgressBar.Trough.Fill", 14, (math.max(0.01, v3 * 100)))
		object:__wf_atom_4c1c1986(p, "ProgressBar.Cap", 0, v3 * object:__wf_atom_cfc41e35(p, "ProgressBar.Trough", 14))
	end
end

local function fn14(object, p, p2, _)
	if not p2.ShowCount then
		object:__wf_atom_7f57ab2f(p, "Count", 13, false)
		return
	end

	object:__wf_atom_7f57ab2f(p, "Count", 13, true)
	object:__wf_atom_48bd5a59(p, "Count.Text", 36, (module.FormatNumber(p2.Count or 0)))
	object:__wf_atom_4c1c1986(p, "Count.Background", 14, object:__wf_atom_cfc41e35(p, "Count.Text", 40) + 8)
end

local function fn15(object, p, state, object2, p2)
	state.Count = state.Count or 1
	state.SelectedCount = state.SelectedCount or 0

	if p2 ~= nil and p2 ~= 0 then
		if state.SelectedCount + p2 < 0 or state.SelectedCount + p2 > state.Count then
			local convertHEX2RGB255 = module.ConvertHEX2RGB255(_G.UIColor_Tan)
			local convertHEX2RGB255_2 = module.ConvertHEX2RGB255(_G.UIColor_Negative)
			module2.PulseColor(object, p .. ".Count.Text", 2, nil, convertHEX2RGB255, convertHEX2RGB255_2)
		else
			state.SelectedCount += p2

			if object2 ~= nil and object2.UpdateSelectedCount ~= nil then
				object2:UpdateSelectedCount(state, p2)
			end

			if p2 < 0 and object2.mDecrementSelectedCallback then
				object2.mDecrementSelectedCallback(state)
			elseif p2 > 0 and object2.mIncrementSelectedCallback then
				object2.mIncrementSelectedCallback(state)
			end
		end
	end

	if state.SelectedCount > 0 then
		object:__wf_atom_7f57ab2f(p, "SelectedCount", 13, true)
		object:__wf_atom_48bd5a59(p, "SelectedCount.Text", 36, (module.FormatNumber(state.SelectedCount)))
	else
		object:__wf_atom_7f57ab2f(p, "SelectedCount", 13, false)
	end
end

local function fn16(object, p, _, _)
	object:__wf_atom_e57658c2(p, 12, 0)
	__wf_atom_ec43d06e(object, p, 8, { 12 }, { 100 }, 0.25)
end

local function fn17(object, p, state, _)
	local focused = state.Focused
	local selected = state.Selected
	local uvZoom = state.UVZoom or 1
	__wf_atom_ec43d06e(object, p .. ".Icon", 8, { function(p2)
			local uvZoom2 = uvZoom + p2
			object:__wf_atom_1ca72041(p .. ".Icon", "UVZoom", uvZoom2, uvZoom2, 0.5, 0.5)
			state.UVZoom = uvZoom2
		end }, { (focused and 0.9 or 1) - uvZoom }, 0.25)
	local ternary = module.Ternary(focused, 60, module.Ternary(selected, 50, 40))

	if state.AnimateBg == nil or state.AnimateBg then
		__wf_atom_ec43d06e(object, p .. ".IconBg", 8, { 12 }, { ternary }, 0.25)
	end

	__wf_atom_ec43d06e(object, p .. ".SaleInfo.Backer", 8, { 12 }, { (focused or selected) and 95 or 70 }, 0.25)
	local v2

	if focused then
		v2 = _G.UIColor_Yellow
	else
		v2 = _G.UIColor_Beige
	end

	object:__wf_atom_4c1c1986(p, "SaleInfo.Name", 44, v2)
end

local function fn18(object, p, p2, _) -- 1 equivalent call inferred from this helper
	object:__wf_atom_7f57ab2f(p, "IconFlare", 13, p2.Focused or false)
end

local function fn19(...)
	fn9(...)
	local v2, v3, v4, _ = ...
	fn18(v2, v3, v4) -- inferred equivalent call
end

local function fn20(...)
	fn6(...)
	fn4(...)
	fn7(...)
	fn8(...)
	fn14(...)
	fn10(...)
	fn11(...)
	fn12(...)
	SetSecondaryStatus(...)
	fn13(...)
end

local function fn21(...)
	fn3(...)
	fn15(...)
	fn4(...)
	fn2(...)
	fn20(...)
	fn19(...)
end

function Initialize(object, p, p2, p3)
	if p == nil then
		return
	end

	object:__wf_atom_7f57ab2f(p, "Prices", 13, false)
	object:__wf_atom_7f57ab2f(p, "RankIconMini", 13, false)
	fn21(object, p, p2, p3)

	if p2.AnimateIn then
		fn16(object, p, p2, p3)
	end
end

function Update(p, p2, p3, p4)
	if p2 == nil then
		return
	end

	fn20(p, p2, p3, p4)
end

function UpdateFocus(p, p2, p3, p4)
	if p2 == nil then
		return
	end

	fn19(p, p2, p3, p4)
	fn17(p, p2, p3, p4)
end

function GetVisRangeMaterials(p, p2)
	local icon, text

	if not (p2 == nil or p2.mVisRangeMaterials == nil) then
		icon = p2.mVisRangeMaterials.Icon
		text = p2.mVisRangeMaterials.Text
	end

	if p.SkipDefaultMaterials or p2 ~= nil and p2.mSkipDefaultMaterials then
		return icon, text
	end

	if __wf_atom_7e8ad928(icon) then
		icon = _G.UIMaterial_VerticalVisibilityRange
	end

	if __wf_atom_7e8ad928(text) then
		text = _G.UIMaterial_VerticalVisibilityRangeText
	end

	return icon, text
end

function IncSelectedCount(object, p, p2, p3)
	object:__wf_atom_290807ee(p .. ".SelectedCount")
	fn15(object, p, p2, p3, 1)
end

function DecSelectedCount(object, p, p2, p3)
	object:__wf_atom_290807ee(p .. ".SelectedCount")
	fn15(object, p, p2, p3, -1)
end

function MaxSelectedCount(object, p, p2, p3)
	object:__wf_atom_290807ee(p .. ".SelectedCount")
	fn15(object, p, p2, p3, (p2.Count or 1) - (p2.SelectedCount or 0))
end

function MinSelectedCount(object, p, p2, p3)
	object:__wf_atom_290807ee(p .. ".SelectedCount")
	fn15(object, p, p2, p3, -(p2.SelectedCount or 0))
end

function StartMaxSelectedCount(p, p2, p3, p4)
	p3.IsHeld = nil
	__wf_atom_ec43d06e(p, p2 .. ".SelectedCount", 0, nil, nil, 0, 0.5, function()
		module.PlaySound(_G.UISound_Select)
		p3.IsHeld = 1
		MaxSelectedCount(p, p2, p3, p4)
	end)
end

function StartMinSelectedCount(p, p2, p3, p4)
	p3.IsHeld = nil
	__wf_atom_ec43d06e(p, p2 .. ".SelectedCount", 0, nil, nil, 0, 0.5, function()
		module.PlaySound(_G.UISound_Select)
		p3.IsHeld = -1
		MinSelectedCount(p, p2, p3, p4)
	end)
end