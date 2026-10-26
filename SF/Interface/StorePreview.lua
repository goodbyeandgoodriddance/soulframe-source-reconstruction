local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("SF.Interface.Libs.StatsUtil")
local module6 = require("SF.Interface.Libs.UIUtilities")
local module7 = require("SF.Scripts.Libs.TransmissionSet")
local v = nil
local v2 = nil
local v3 = nil
local flag = false
local element = nil
local v4 = nil
local v5 = nil
local v6 = nil
local buyElementResult = nil
local purchasedItems = nil
local v7 = nil
local v8 = nil
local asyncLoader = module6.CreateAsyncLoader()
local v9 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local v10 = {
	"/SF/Types/StoreItems/Packages/CourageousFounderStoreItem",
	"/SF/Types/StoreItems/Packages/SpiritedFounderStoreItem",
	"/SF/Types/StoreItems/Packages/GracefulFounderStoreItem",
	"/SF/Types/StoreItems/Packages/ParagonFounderStoreItem"
}

function SetExitCallback(p)
	v3 = p
end

local function fn()
	if v3 == nil then
		return
	end

	if not (__wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23())) then
		mMovie:__wf_atom_2ad5cd23():Execute(v3, "")
	end
end

local function fn2(p)
	if not __wf_atom_7e8ad928(gRegion) then
		module7.PlayLocalTransmission(_T.marketVendorTransmissionSet, Symbol(p), gRegion:__wf_atom_c4f78a8f())
	end
end

function RefreshInventory()
	v8 = module3.GetInventoryControl()

	if not __wf_atom_7e8ad928(v8) then
		v7 = v8:__wf_atom_259e7653(true)
	end

	purchasedItems = module4.GetPurchasedItems(v9, v7)

	if v4 ~= nil then
		v4.PurchasedItems = purchasedItems
	end
end

function RefreshPrice(p)
	if element == nil then
		return
	end

	if p == nil or p == true then
		RefreshInventory()
	end

	local formatted = nil
	local prices = element.Prices

	if element.CanPurchase == false then
		formatted = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedCheck", true)
		v5:SetVisible(false)
		mMovie:__wf_atom_2dedec1a("Details.Price", 13, true)
		mMovie:__wf_atom_2dedec1a("Details.PriceBacker", 13, true)
		mMovie:__wf_atom_50d60589("Details.Price", 36, formatted)
		mMovie:__wf_atom_e57658c2("Details.Price", 11, _G.UIColor_Beige)
		local v11 = mMovie:__wf_atom_5e6e15c8("Details.Price", 40) + 64 + 16
		mMovie:__wf_atom_e57658c2("Details.PriceBacker", 14, v11)
		mMovie:__wf_atom_e57658c2("Details.PriceBacker", 11, _G.UIColor_Brown)
		mMovie:__wf_atom_e57658c2("Details.PriceBacker", 12, 50)
		mMovie:OverrideMaterial("Details.PriceBacker", priceBackerMaterial)
	else
		mMovie:__wf_atom_2dedec1a("Details.Price", 13, false)
		mMovie:__wf_atom_2dedec1a("Details.PriceBacker", 13, false)

		if prices.ExternalProduct and not __wf_atom_7e8ad928(gGameData) then
			if element.Owned then
				formatted = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedCheck", true)
			else
				formatted = prices.CatalogProductData.listPrice.formatted

				if prices.DiscountTags.Sale then
					local _formatted = prices.CatalogProductData.basePrice.formatted
				end
			end
		elseif prices.ShowInMarket then
			local v11 = prices.UsePremium and "/SF/Language/Currency/PremiumCurrencyAmount"
				or "/SF/Language/Currency/CurrencyAmount"

			if element.Owned and not module2.CanPurchaseIfAlreadyOwned(element.StoreItem) then
				formatted = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedCheck", true)
			else
				formatted = mMovie:__wf_atom_8e9ac384(v11, true, {
					AMOUNT = module.FormatNumber(prices.UsePrice)
				})

				if prices.FinalDiscountPercent > 0 then
					mMovie:__wf_atom_8e9ac384(v11, true, {
						AMOUNT = module.FormatNumber(prices.UseOriginalPrice)
					})
				end
			end
		end
	end

	v5:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/PurchaseItem", false) .. " " .. formatted)
end

local function fn3(p)
	if p ~= nil and not __wf_atom_7e8ad928(mMovie) and p then
		fn2("Purchase")
		module.PlaySound(purchaseConfirmSound)
		_T.BuyElementResult = buyElementResult

		if not (__wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23())) then
			AdvanceAndShutdown()
			mMovie:__wf_atom_2ad5cd23():Execute("OnBuyItem", (tostring(p)))
		end
	end

	buyElementResult = nil
	RefreshPrice()
end

function BuyItem()
	local productId = element.ProductId
	local storeItem = element.StoreItem
	local storeItemPriceObject = module2.GetStoreItemPriceObject(storeItem, nil, purchasedItems)

	if productId == nil or not (storeItemPriceObject.ExternalProduct and storeItemPriceObject.ShowInMarket) then
		if not module2.CanPurchaseIfAlreadyOwned(element.ComponentStoreItem or storeItem) and element.Owned then
			module.ShowMessage("/SF/Language/Crafting/Foundry_DuplicateNotAllowed")
			return
		end

		if element.PurchaseBlockedMessage ~= nil then
			module.ShowMessage(element.PurchaseBlockedMessage)
			return
		end

		if
			element == nil
			or __wf_atom_7e8ad928(element.StoreItem)
			or __wf_atom_7e8ad928(v9)
			or buyElementResult ~= nil
		then
			return
		end

		buyElementResult = element
		local purchaseParams = SF.PurchaseParams()
		purchaseParams.mSource = 0
		purchaseParams.mSourceId = v9:__wf_atom_5b41f63b()
		purchaseParams.mStoreItem = element.StoreItem
		purchaseParams.mQuantity = 1
		_T.purchasedItems = purchasedItems
		_T.DoPurchase(purchaseParams, fn3)
	elseif element.Owned then
		module.ShowMessage("/SF/Language/Crafting/Foundry_DuplicateNotAllowed")
	else
		local storeItemUrl = module4.GetStoreItemUrl(storeItem)

		if storeItemUrl then
			module.DoOpenWebBrowser(storeItemUrl)
		end
	end
end

local function fn4()
	local storeItem = element.StoreItem
	local __wf_atom_72915748 = storeItem:__wf_atom_72915748()

	if #__wf_atom_72915748 == 0 then
		mMovie:__wf_atom_2dedec1a("RightPanel", 13, false)
		return
	end

	local module8 = require("EE.Interface.Components.ItemGrid")
	v4 = module8.Create(getfenv(1), "RightPanel.GridContainer", {
		mRows = 4,
		mColumns = 3,
		mCanSelectItem = false,
		PurchasedItems = purchasedItems
	})

	function v4.mOnFocusedCallback(data)
		asyncLoader:AbortLoad("Tooltip")
		local storeItemInfo

		if data.CustomEntry then
			storeItemInfo = data
		else
			storeItemInfo = data.StoreItemInfo
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local kind

		if storeItemInfo.Type then
			kind = storeItemInfo.Type
		else
			kind = storeItemInfo.StoreItem
		end

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(kind)) then
			asyncLoader:LoadResource("Tooltip", kind, function()
				local weaponElementUpgradesAndFingerprints, v11 = module5.GetWeaponElementUpgradesAndFingerprints(storeItemInfo)
				local v12 = __wf_atom_7e8ad928(storeItemInfo.RawItem) and 0 or storeItemInfo.RawItem.mQuality

				if storeItemInfo.RawItem then
					local _mItemId = storeItemInfo.RawItem.mItemId
				end

				local proxyWeapon, v13 = module5.CreateProxyWeapon(
					__wf_atom_c4f78a8f,
					storeItemInfo.Type,
					storeItemInfo.Xp,
					weaponElementUpgradesAndFingerprints,
					v11,
					v12,
					nil,
					storeItemInfo.mShiny,
					nil
				)
				v = v13
				storeItemInfo.StatWeapon = proxyWeapon
				storeItemInfo.StatOwner = __wf_atom_c4f78a8f
				storeItemInfo.SuppressLevel = true
				storeItemInfo.InventoryFixedPosition = true
				local v14 = nil
				local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
				local flag2 = false

				if not (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_7e8ad928(proxyWeapon)) then
					local __wf_atom_97d575cf = __wf_atom_d2b2176d:__wf_atom_97d575cf((proxyWeapon:__wf_atom_0395f752()))
					local __wf_atom_259e7653 = __wf_atom_d2b2176d:__wf_atom_259e7653(true)
					local __wf_atom_c132f79b = __wf_atom_259e7653:__wf_atom_c132f79b(
						0,
						__wf_atom_259e7653:__wf_atom_d25917b6(0)
					)

					if storeItemInfo.Type:IsA(__wf_atom_abf506db) then
						if WeakResource("/SF/Souls/Sparrow/SparrowSoul") == storeItemInfo.StoreItem:__wf_atom_7c09e378() then
							if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()) or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa())) or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()):__wf_atom_d78fd481(2))) then
								local __wf_atom_1eafa462 = gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa())
								v14 = gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()):__wf_atom_d78fd481(2)
								__wf_atom_97d575cf = __wf_atom_1eafa462:__wf_atom_035fdfa8(2)
								flag2 = true
							end
						else
							local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
							local __wf_atom_eb82ab1f = v7:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
							local __wf_atom_43869974 = proxyWeapon:__wf_atom_43869974()

							for i = 0, 8 - 1 do
								if __wf_atom_43869974[1] ~= i then
									continue
								end

								local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(i)

								if __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
									continue
								end

								v14 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(i)
								storeItemInfo.StatCompareWeapon = nil
								__wf_atom_97d575cf = __wf_atom_035fdfa8
							end

							flag2 = true
						end
					else
						storeItemInfo.StatCompareWeapon = __wf_atom_97d575cf
					end

					if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
						local compareItemInfo, v15

						if flag2 then
							compareItemInfo = module4.GetItemTypeWithStoreInfo(mMovie, v14.mItemType, v9)
							local weaponElementUpgradesAndFingerprints2, v16 = module5.GetWeaponElementUpgradesAndFingerprints(compareItemInfo)
							local v17 = __wf_atom_7e8ad928(compareItemInfo.RawItem) and 0
								or compareItemInfo.RawItem.mQuality

							if compareItemInfo.RawItem then
								local _mItemId = compareItemInfo.RawItem.mItemId
							end

							local v18
							v15, v18 = module5.CreateProxyWeapon(
								__wf_atom_c4f78a8f,
								compareItemInfo.Type,
								compareItemInfo.Xp,
								weaponElementUpgradesAndFingerprints2,
								v16,
								v17,
								nil,
								compareItemInfo.mShiny,
								nil
							)
							v2 = v18
							storeItemInfo.StatCompareWeapon = v15
						else
							compareItemInfo = module4.GetItemTypeWithStoreInfo(
								mMovie,
								__wf_atom_97d575cf:__wf_atom_1bb5b1ff(),
								v9
							)
							local weaponElementUpgradesAndFingerprints2, v16 = module5.GetWeaponElementUpgradesAndFingerprints(compareItemInfo)
							local v17

							if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
								v17 = __wf_atom_97d575cf:__wf_atom_966277ef()
							end

							local v18

							if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
								v18 = __wf_atom_97d575cf:__wf_atom_b2875ac0()
							end

							local v19

							if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
								v19 = __wf_atom_97d575cf:__wf_atom_9422b5f5()
							end

							local v20

							if __wf_atom_97d575cf then
								v20 = __wf_atom_97d575cf:__wf_atom_204490cb()
							end

							local v21
							v15, v21 = module5.CreateProxyWeapon(
								__wf_atom_c4f78a8f,
								compareItemInfo.Type,
								compareItemInfo.Xp,
								weaponElementUpgradesAndFingerprints2,
								v16,
								v17,
								v20,
								v19,
								v18
							)
							v2 = v21
							storeItemInfo.StatCompareWeapon = v15
						end

						if compareItemInfo then
							compareItemInfo.StatWeapon = v15
							compareItemInfo.StatOwner = __wf_atom_c4f78a8f
							compareItemInfo.StatCompareWeapon = proxyWeapon
							compareItemInfo.InventoryFixedPosition = true
							compareItemInfo.SuppressLevel = true
							compareItemInfo.MetaData = not compareItemInfo.MetaData and {} or compareItemInfo.MetaData
							compareItemInfo.MetaData.HidePrice = true
							compareItemInfo.MetaData.HideFragments = true
							compareItemInfo.PurchaseContext = true
							storeItemInfo.CompareItemInfo = compareItemInfo
						end
					end
				end

				storeItemInfo.PurchaseContext = true
				module6.SetItemInfoPopupRect(
					mMovie,
					storeItemInfo,
					mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 2) - 420,
					mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 3) + 48,
					-mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 14),
					mMovie:__wf_atom_5e6e15c8(data.mClipName, 15)
				)
				_T.InfoPopup_Data = storeItemInfo
			end)
			return
		end

		storeItemInfo.PurchaseContext = true
		module6.SetItemInfoPopupRect(
			mMovie,
			storeItemInfo,
			mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 2) - 94,
			mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 3) + 124,
			-mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer", 14),
			mMovie:__wf_atom_5e6e15c8(data.mClipName, 15)
		)
		_T.InfoPopup_Data = storeItemInfo
	end

	function v4.mOnUnfocusedCallback(_)
		asyncLoader:AbortLoad("Tooltip")

		if v then
			v()
			v = nil
		end

		if v2 then
			v2()
			v2 = nil
		end

		_T.InfoPopup_Data = nil
	end

	v4:SetTitle("/SF/Language/Vendor/IncludedItems")
	local totalBundledPremiumCredits = module4.GetTotalBundledPremiumCredits(storeItem)

	if totalBundledPremiumCredits > 0 then
		local v11 = {
			Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/PremiumCurrencyName", false),
			Description = mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/PremiumCurrencyDesc", false),
			Icon = premiumCurrencyIcon,
			OwnsItem = false,
			Count = totalBundledPremiumCredits,
			ShowCount = module.Ternary(totalBundledPremiumCredits > 1, true, false),
			CustomEntry = true
		}
		v4:AddElement(v11, true)
	end

	for _, v11 in __wf_atom_72915748 do
		local mTypeName = v11.mTypeName

		if __wf_atom_7e8ad928(mTypeName) then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(mMovie, mTypeName, { ItemInfo = mTypeName }, nil, nil, true)
		local totalBundledItemQuantity = module4.GetTotalBundledItemQuantity(__wf_atom_72915748, mTypeName)
		local v12 = {
			Name = storeItemInfo.Name,
			Icon = storeItemInfo.Icon,
			OwnsItem = false,
			Count = totalBundledItemQuantity,
			ShowCount = module.Ternary(totalBundledItemQuantity > 1, true, false),
			StoreItemInfo = storeItemInfo,
			ItemInfo = mTypeName,
			IsSelectable = false
		}
		v4:AddElement(v12, true)
	end

	v4:Redraw(nil, true, true)
	mMovie:__wf_atom_e57658c2("RightPanel.GridContainer.Bg", 12, 0)
end

function Initialize()
	element = _T.StorePreviewData.Element
	mMovie:__wf_atom_c90af43a("Details.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("Details.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("Details.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("Details.BgFill", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Details.BgFill", 12, 50)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Details.BgEnd", 12, 50)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Details.BgStart", 12, 50)
	mMovie:__wf_atom_50d60589("Details.Title", 36, element.Name)
	mMovie:__wf_atom_e57658c2("Details.Title", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_50d60589("Details.Contents.Includes", 36, "[HC] Includes")
	mMovie:__wf_atom_e57658c2("Details.Contents.Includes", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_50d60589("Details.Description", 36, mMovie:__wf_atom_8e9ac384(element.Description, false))
	mMovie:__wf_atom_e57658c2("Details.Description", 44, _G.UIColor_Beige)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Details.Description", 41)
	local v11 = mMovie:__wf_atom_5e6e15c8("Details.Description", 1) + __wf_atom_5e6e15c8 + 16 - 48
	mMovie:__wf_atom_e57658c2("Details.Contents.Includes", 12, 0)
	mMovie:__wf_atom_e57658c2("Details.Contents", 1, v11)
	local storeItem = element.StoreItem
	RefreshInventory()
	fn4()
	local v12 = ""

	if not __wf_atom_7e8ad928(storeItem) and storeItem:IsPackage() then
		local packageContentsDesc = module4.GetPackageContentsDesc(
			mMovie,
			storeItem,
			purchasedItems,
			"#cbc3ad",
			"#847a61",
			18
		)

		if #element.ExtraItems > 0 then
			local v13 = packageContentsDesc .. "<br><br>" .. Localize("/SF/Language/Vendor/ExternalIncludes", nil)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<BULLET>", true)
			local v14 = v13 .. "<font color=\"#cbc3ad\">"

			for _, extraItem in element.ExtraItems do
				if #v14 > 0 then
					v14 ..= "<br>"
				end

				v14 ..= __wf_atom_8e9ac384 .. Localize(extraItem, nil)
			end

			packageContentsDesc = v14 .. "</font>"
		end

		if v12 ~= "" and packageContentsDesc ~= "" then
			v12 ..= "<br><br>"
		end

		v12 ..= packageContentsDesc
	end

	local v13 = "<p><font >" .. v12 .. "</font></p>"
	mMovie:__wf_atom_50d60589("Details.Contents.ItemList", 36, v13)
	mMovie:__wf_atom_e57658c2("Details.Contents.ItemList", 44, _G.UIColor_Beige)
	mMovie:OverrideMaterial("Details.Contents.ItemList", visRangeDetailsTextMat)
	local v14 = nil

	for i, v15 in ipairs(v10) do
		if storeItem:__wf_atom_5b41f63b() ~= v15 then
			continue
		end

		v14 = foundersAltIcons[i]
		break
	end

	mMovie:__wf_atom_c90af43a("PreviewImage", v14 or element.Icon)
	mMovie:OverrideMaterial("PreviewImage", foundersAltIconMaterial)
	mMovie:__wf_atom_e57658c2("PreviewBacker", 12, 0)
	mMovie:__wf_atom_e57658c2("PreviewFrame", 12, 0)
	mMovie:__wf_atom_e57658c2("PreviewDarken", 12, 0)
	mMovie:__wf_atom_c90af43a("PreviewShadow", previewShadowTexture)
	mMovie:__wf_atom_c90af43a("PreviewGlow", previewGlowTexture)
	mMovie:OverrideMaterial("PreviewGlow", previewGlowMaterial)
	mMovie:__wf_atom_e57658c2("PreviewShadow", 12, 100)
	mMovie:__wf_atom_e57658c2("PreviewGlow", 12, 100)
	local v15 = -mMovie:__wf_atom_5e6e15c8("RightPanel.GridContainer.TitleBar", 0)
	mMovie:__wf_atom_e57658c2("RightPanel.BundleIcon", 0, v15)
	mMovie:__wf_atom_e57658c2("RightPanel.BundleIcon", 1, 16)
	mMovie:__wf_atom_e57658c2("RightPanel.BundleIconBacker", 0, v15)
	mMovie:__wf_atom_e57658c2("RightPanel.BundleIconBacker", 1, 16)
	mMovie:__wf_atom_c90af43a("RightPanel.BundleIconBacker", previewGlowTexture)

	if __wf_atom_7e8ad928(element.TopperIcon) then
		mMovie:__wf_atom_e57658c2("RightPanel.BundleIcon", 12, 0)
		mMovie:__wf_atom_e57658c2("RightPanel.BundleIconBacker", 12, 0)
	else
		mMovie:__wf_atom_e57658c2("RightPanel.BundleIcon", 12, 100)
		mMovie:__wf_atom_e57658c2("RightPanel.BundleIconBacker", 12, 100)
		mMovie:__wf_atom_c90af43a("RightPanel.BundleIcon", element.TopperIcon)
	end

	local module8 = require("SF.Interface.Components.Button")
	v5 = module8.Create(
		mMovie,
		"Details.PurchaseButton",
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/PurchaseItem", false),
		"BuyItem"
	)
	v5:SetVariant(module8.VARIANTS.SPECIAL_BUTTON)
	v5:SetAnchor(module.CENTER_ALIGNED)
	RefreshPrice(false)
	local module9 = require("SF.Interface.Components.Scrollbar")
	v6 = module9.CreateScrollBar(getfenv(1), "Details.Contents.Scrollbar", {
		mClipToScroll = "Details.Contents.ItemList",
		mVisRangeMaterials = { visRangeDetailsTextMat },
		mVisRangeFadeSize = 10
	})
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.25)

	if not __wf_atom_7e8ad928(openSound) then
		module.PlaySound(openSound)
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	asyncLoader:Update()
end

function Shutdown()
	if v then
		v()
		v = nil
	end

	if v2 then
		v2()
		v2 = nil
	end

	asyncLoader:AbortLoad("Tooltip")
	fn()
end

function AdvanceAndShutdown()
	if flag then
		return
	end

	flag = true
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:Close()
	end)

	if not __wf_atom_7e8ad928(closeSound) then
		module.PlaySound(closeSound)
	end
end

function onKeyDown_MENU_CANCEL()
	AdvanceAndShutdown()
end