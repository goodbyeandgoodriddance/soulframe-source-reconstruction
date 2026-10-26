local module = require("SF.Interface.SFUtilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.LotusUtilities")
local module6 = require("SF.Interface.Libs.StatsUtil")
local module7 = require("SF.Scripts.Libs.QuestLib")
local module8 = require("EE.Interface.AnchorMgr")
local module9 = require("SF.Interface.Components.Scrollbar")
local v = nil
local class = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local asyncLoader = module2.CreateAsyncLoader()
local flag = false
local mQuantity2 = nil
local v8 = false
local v9 = 1
local v10 = false
local v11 = 1
local v12 = "/SF/Language/Vendor/VendorName"
local v13 = nil
local v14 = nil
local v15 = nil
local mInventoryList = nil
local mItemList = nil
local v16 = nil
local v17 = nil
local v18 = false
local v19 = false
local v20 = false
local v21 = nil
local v22 = nil
local v23 = nil
local flag2 = true
local v24 = nil
local v25 = nil
local v26 = nil

local function fn(p)
	if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	local purchasedItems = module4.GetPurchasedItems(__wf_atom_964056fd, v14, nil, false, mMovie)
	return (module5.GetNumOwned(gGameData, v14, p, purchasedItems))
end

local function fn2(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(v13) then
		return nil
	end

	return v13:__wf_atom_232fd31d(p)
end

local function fn3(instance)
	if __wf_atom_7e8ad928(instance) then
		return false, 0
	end

	if instance:IsA(__wf_atom_be33f7f1) then
		for _, v27 in ipairs(instance:__wf_atom_72915748()) do
			if __wf_atom_7e8ad928(v27) then
				continue
			end

			local v28, v29 = fn3((fn2(v27.mTypeName:GetItem())))
			local mPurchaseQuantity = v27.mPurchaseQuantity

			if v28 or v29 - mPurchaseQuantity < 0 then
				return true, 0
			end
		end
	end

	local v27 = fn(instance)
	local __wf_atom_de8272d7 = instance:__wf_atom_de8272d7()

	if __wf_atom_de8272d7 <= 0 then
		return false, 1e999
	end

	return __wf_atom_de8272d7 <= v27, (math.clamp(__wf_atom_de8272d7 - v27, 0, __wf_atom_de8272d7))
end

local function fn4()
	if class.mSelectedElement == nil then
		return
	end

	local vendorSyndicate = _T.VendorSyndicate
	v21 = SF.SyndicateStandingBonusOperation()
	v21.mAffiliationTag = vendorSyndicate:__wf_atom_e0f044e1()
	local _, v27, v28, _, v29 = module5.GetReputationInfoForSyndicate(vendorSyndicate)

	if vendorSyndicate:__wf_atom_73f36e1b() then
		return v29
	end

	if v28 < 0 then
		return (math.abs(v27))
	end

	return v28 - v27
end

local function fn5(data, instance)
	if v9 == 2 then
		local mSelectedElement = class.mSelectedElement

		if mSelectedElement == nil then
			return
		end

		if _T.VendorSyndicate == nil then
			return true, fn(instance)
		end

		local v27 = math.ceil(fn4() / mSelectedElement.SpecialPrice)
		return true, (math.min(fn(instance), v27))
	else
		local mPurchaseQuantityLimit = nil
		local v27 = false
		local v28, v29 = fn3(instance)

		if v28 then
			return true, 0
		end

		if not __wf_atom_7e8ad928(data) then
			if not (data.mAllowMultipurchase and module5.CanPurchaseIfAlreadyOwned(instance)) then
				return true, 1
			end

			if vendorManifest:__wf_atom_b1c78aca() then
				mPurchaseQuantityLimit = data.mPurchaseQuantityLimit

				if mPurchaseQuantityLimit > 0 then
					v27 = true

					if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(gGameData)) then
						local mId = instance:__wf_atom_5b41f63b()

						if not data.mId:__wf_atom_b70c3343() then
							mId = tostring(data.mId)
						end

						local __wf_atom_5b41f63b = vendorManifest:__wf_atom_5b41f63b()
						mPurchaseQuantityLimit = math.max(
							mPurchaseQuantityLimit - gGameData:__wf_atom_8a426954(__wf_atom_5b41f63b, mId),
							0
						)
					end
				end
			end
		end

		if not __wf_atom_7e8ad928(instance) and instance:IsA(healthPotion) then
			local v30 = fn(instance)
			local v31 = not v27 and 100 or mPurchaseQuantityLimit

			if v30 == nil then
				mPurchaseQuantityLimit = 0
			else
				local v32 = math.max(5 - v30, 0)
				mPurchaseQuantityLimit = __wf_atom_421b01aa(v31, 0, v32)
			end

			v27 = true
		end

		return v27, (math.min(v29, mPurchaseQuantityLimit))
	end
end

local function fn6(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.VendorItem) then
		return 0, 0
	end

	return p.VendorItem.mRegularPrice.maxValue, p.VendorItem.mPremiumPrice.maxValue
end

local function fn7(p, p2)
	if p2 > 0 then
		return "<PREMIUM_CURRENCY> " .. module3.FormatNumber(p2)
	end

	return "<DRACS> " .. module3.FormatNumber(p)
end

local function fn8(p, items)
	if _G.StalkerMode then
		return nil
	end

	local encoded

	if items then
		local v27 = {}
		local v28 = { Icon = true }

		for k, item in pairs(items) do
			if type(item) == "userdata" and v28[k] then
				v27[k] = item:__wf_atom_5b41f63b()
			elseif type(item) ~= "function" and type(item) ~= "userdata" then
				v27[k] = item
			end
		end

		encoded = cjson.encode(v27)
	else
		encoded = ""
	end

	if not __wf_atom_7e8ad928(v16) then
		v16:AddLogMessage(p, encoded)
	end
end

local function fn9(p)
	if p < 3 then
		return (module3.Ternary(p == 1, "DecreaseMinButton", "DecreaseButton"))
	end

	return (module3.Ternary(p == 3, "IncreaseButton", "IncreaseMaxButton"))
end

function SetOnBuyVendorItem(p)
	v23 = p
end

local function fn10()
	mMovie:__wf_atom_2dedec1a("DetailsPanel.OwnedAndCostAmounts", 13, not v19)

	if not __wf_atom_7e8ad928(class) then
		class:Redraw(nil, true, true)
	end
end

local function fn11(list, p, cantSellLast)
	if __wf_atom_7e8ad928(cantSellLast) then
		cantSellLast = false
	end

	if __wf_atom_7e8ad928(class) then
		class = {}
	end

	local v27 = nil

	if p ~= nil then
		local __wf_atom_97d575cf = v15:__wf_atom_97d575cf(p)

		if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
			v27 = __wf_atom_97d575cf:__wf_atom_bb8450ca()
		end
	end

	for _, itemInfo in ipairs(list) do
		local appendInfo = nil

		if mInventoryList ~= nil then
			for _, v28 in mInventoryList do
				if itemInfo.mItemType ~= v28.Type then
					continue
				end

				appendInfo = v28
				break
			end

			if appendInfo == nil then
				continue
			end
		end

		local v28 = fn2(itemInfo.mItemType)

		if
			__wf_atom_7e8ad928(v28)
			or __wf_atom_7e8ad928(itemInfo)
			or not (v27 == nil or v27 ~= itemInfo.mItemId)
			or cantSellLast and fn(v28) < 2
		then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(
			mMovie,
			v28,
			{ AppendInfo = appendInfo, ItemInfo = itemInfo },
			nil,
			nil,
			true
		)
		local specialPrice = storeItemInfo.SpecialPrice or storeItemInfo.SellingPrice

		if not (storeItemInfo ~= nil and specialPrice ~= nil and specialPrice > 0) then
			continue
		end

		storeItemInfo.CantSellLast = cantSellLast

		if storeItemInfo.Header then
			storeItemInfo.listExtraY = -18
			storeItemInfo.mHeight = 340
		else
			storeItemInfo.mHeight = 90
		end

		class:AddElement(storeItemInfo, true)
	end
end

local function fn12()
	if not __wf_atom_7e8ad928(_T.CustomVendorItems) then
		return
	end

	if not vendorManifest:__wf_atom_b1c78aca() then
		OnVendorManifestLoaded(true)
		return
	end

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", { "2", "/Lotus/Language/Menu/Vendor_StockUpdating" })
	gGameData:SyncVendorInfo(vendorManifest, "OnVendorManifestLoaded")
end

local function fn13(mItemList2)
	local v27 = false
	local flag3 = false

	for i = 1, #mItemList2 do
		local v28, v29 = fn6(mItemList2[i])
		v27 = v28 > 0 or v27

		if v29 > 0 then
			flag3 = true
		end
	end

	if not (v27 and flag3) then
		return
	end

	if v27 then
		table.insert(mItemList2, {
			Header = true,
			Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/StandardItemsHeader", false),
			Priority = 2
		})
	end

	if flag3 then
		table.insert(mItemList2, {
			Header = true,
			TopHeader = true,
			Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/PremiumItemsHeader", false),
			Priority = 1
		})
	end
end

local function fn14(data, data2)
	if data.Priority ~= data2.Priority then
		return data.Priority < data2.Priority
	end

	if data.Header ~= data2.Header then
		return module3.Ternary(data.Header, data, data2) == data
	end

	if data.Header and data2.Header then
		return data.TopHeader
	end

	return data.Name < data2.Name
end

local function fn15(data)
	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 7
	local __wf_atom_5b817062 = gGameData:__wf_atom_5b817062(vendorManifest)

	if vendorManifest:__wf_atom_b1c78aca() then
		purchaseParams.mSourceId = tostring(__wf_atom_5b817062.mId)
		local v27 = { ItemId = tostring(data.VendorItem.mId) }
		purchaseParams.mExtraPurchaseInfoJson = cjson.encode(v27)
	else
		purchaseParams.mSourceId = vendorManifest:__wf_atom_5b41f63b()
	end

	purchaseParams.mStoreItem = data.StoreItem
	purchaseParams.mQuantity = mQuantity2
	purchaseParams.mSkipConfirm = false
	return purchaseParams
end

local v27 = {
	REGULAR_CREDITS = "Credits",
	PREMIUM_CREDITS = "Platinum",
	PRIME_BUCKS = "PrimeBucks",
	PRIME_TOKENS = "PrimeTokens",
	STANDING = "Standing",
	AMBULAS_DATA = "AmbulasData",
	ITEMS = "Items"
}

local function fn16(purchasePrice)
	local v28 = { [v27.REGULAR_CREDITS] = "<DRACS>", [v27.PREMIUM_CREDITS] = "<PREMIUM_CURRENCY>" }
	local v29 = { v27.PREMIUM_CREDITS, v27.REGULAR_CREDITS }

	for _, v30 in ipairs(v29) do
		if not __wf_atom_7e8ad928(purchasePrice[v30]) and purchasePrice[v30] > 0 then
			return v28[v30], purchasePrice[v30]
		end
	end

	return "<DRACS>", 0
end

local function fn17(purchasePrice)
	local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()
	local __wf_atom_330e9cb9 = gGameData:__wf_atom_330e9cb9()

	if
		not __wf_atom_7e8ad928(purchasePrice[v27.REGULAR_CREDITS])
		and __wf_atom_7050e489 < purchasePrice[v27.REGULAR_CREDITS]
	then
		return false
	end

	if
		__wf_atom_7e8ad928(purchasePrice[v27.PREMIUM_CREDITS])
		or not (__wf_atom_330e9cb9 < purchasePrice[v27.PREMIUM_CREDITS])
	then
		return true
	end

	return false
end

local function fn18(mSelectedElement)
	if mSelectedElement == nil then
		return
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel.OwnedAndCostAmounts.WarningWasteText", 13, false)
	local v28 = fn(mSelectedElement.PurchasedItemType or mSelectedElement.StoreItem) or 0
	mMovie:__wf_atom_50d60589(
		"DetailsPanel.OwnedAndCostAmounts.OwnedText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/OwnedAmount", false, {
			COUNT = module3.FormatNumber(v28)
		})
	)
	local mMovie2 = mMovie
	mMovie2:__wf_atom_2dedec1a(
		"DetailsPanel.OwnedAndCostAmounts.OwnedText",
		13,
		mSelectedElement.StoreItem:__wf_atom_efa6f447() ~= 14 and v28 > 0
	)
	v8 = false

	if v9 == 1 then
		local specialPrice = mSelectedElement.SpecialPrice
		local specialPriceIconTag = mSelectedElement.SpecialPriceIconTag

		if specialPrice == nil then
			local v29 = fn15(mSelectedElement)
			local purchasePrice, _, _ = _T.GetPurchasePrice(v29)
			specialPriceIconTag, specialPrice = fn16(purchasePrice)
			v8 = not fn17(purchasePrice)
		end

		local ternary = module3.Ternary(v19, "/SF/Language/Vendor/ClaimItem", "/SF/Language/Vendor/PurchaseItem")
		v2:SetText(ternary)
		mMovie:__wf_atom_50d60589(
			"DetailsPanel.OwnedAndCostAmounts.CostText",
			36,
			mMovie:__wf_atom_8e9ac384(specialPriceIconTag, true) .. " " .. module3.FormatNumber(specialPrice)
		)
		mMovie:__wf_atom_e57658c2(
			"DetailsPanel.OwnedAndCostAmounts.CostText",
			44,
			module3.Ternary(not v8, 12363651, _G.UIColor_Negative)
		)
		v2:SetActive(not v8 and mQuantity2 > 0)

		if v8 then
			mMovie:__wf_atom_7f57ab2f("DetailsPanel", "TimeRemaining", 13, true)
			mMovie:__wf_atom_48bd5a59(
				"DetailsPanel",
				"TimeRemaining",
				36,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/Foundry_CraftInsufDracs", false)
			)
		end
	else
		local v29 = (mSelectedElement.SpecialPrice or mSelectedElement.SellingPrice) * mQuantity2
		local specialPriceIconTag = mSelectedElement.SpecialPriceIconTag or "<DRACS>"
		v2:SetText("/SF/Language/Vendor/SellItem")
		mMovie:__wf_atom_50d60589(
			"DetailsPanel.OwnedAndCostAmounts.CostText",
			36,
			mMovie:__wf_atom_8e9ac384(specialPriceIconTag, true) .. module3.FormatNumber(v29)
		)
		mMovie:__wf_atom_50d60589("DetailsPanel.OwnedAndCostAmounts.CostText", 44, _G.UIColor_Yellow)

		if class.mSelectedElement ~= nil and _T.VendorSyndicate ~= nil then
			local v30 = fn4()

			if v30 <= v29 then
				local number = v29 - v30
				local v31

				if number == 0 then
					v31 = mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/DailyCapOrLimitWithoutWasteWarning", true)
				else
					v31 = mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/DailyCapOrLimitWasteWarning", true, {
						NUMBER = number
					})
				end

				mMovie:__wf_atom_50d60589("DetailsPanel.OwnedAndCostAmounts.WarningWasteText", 36, v31)
				mMovie:__wf_atom_e57658c2("DetailsPanel.OwnedAndCostAmounts.WarningWasteText", 44, _G.UIColor_Negative)
				mMovie:__wf_atom_2dedec1a("DetailsPanel.OwnedAndCostAmounts.WarningWasteText", 13, true)
			end
		end

		v2:SetActive(true)
	end

	fn10()
end

local function fn19(p, p2, p3)
	local v28 = mQuantity2
	mQuantity2 = p
	local v29 = true
	local v30 = nil

	if class ~= nil then
		local mSelectedElement = class.mSelectedElement

		if mSelectedElement ~= nil then
			if v9 == 2 or not __wf_atom_7e8ad928(mSelectedElement.VendorItem) then
				local v31
				v31, v30 = fn5(mSelectedElement.VendorItem, mSelectedElement.StoreItem)

				if v31 then
					v30 = math.max(v30, 1)
					mQuantity2 = __wf_atom_421b01aa(mQuantity2, 1, v30)

					if mQuantity2 < v30 then
						v29 = true
					else
						v29 = false
					end
				end
			end

			if v9 == 1 and p2 and not v19 then
				local specialPrice = mSelectedElement.SpecialPrice or mSelectedElement.SellingPrice

				if specialPrice ~= nil then
					local v31 = math.floor((v22 or gGameData:__wf_atom_7050e489()) / specialPrice)
					mQuantity2 = __wf_atom_421b01aa(mQuantity2, 1, v31)

					if v31 <= mQuantity2 then
						v29 = false
					end
				end
			end
		end
	end

	mQuantity2 = __wf_atom_421b01aa(mQuantity2, 1, mQuantity2)
	local v31 = mQuantity2 > 1
	mMovie:__wf_atom_50d60589("DetailsPanel.QuantityPicker.Quantity", 36, mQuantity2)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker.DecreaseButton", 12, module3.Ternary(v31, 100, 50))
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker.IncreaseButton", 12, module3.Ternary(v29, 100, 50))
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker.DecreaseMinButton", 12, module3.Ternary(v31, 100, 50))
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker.IncreaseMaxButton", 12, module3.Ternary(v29, 100, 50))
	local uiColor_MediumBrown = _G.UIColor_MediumBrown
	local v32 = not v29
	local v34 = not v31
	mMovie:__wf_atom_e57658c2(
		"DetailsPanel.QuantityPicker.DecreaseButton.Bg",
		11,
		module3.Ternary(
			v34,
			uiColor_MediumBrown,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.QuantityPicker.DecreaseButton.Bg", 11)
		)
	)
	mMovie:__wf_atom_e57658c2(
		"DetailsPanel.QuantityPicker.IncreaseButton.Bg",
		11,
		module3.Ternary(
			v32,
			uiColor_MediumBrown,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.QuantityPicker.IncreaseButton.Bg", 11)
		)
	)
	mMovie:__wf_atom_e57658c2(
		"DetailsPanel.QuantityPicker.DecreaseMinButton.Bg",
		11,
		module3.Ternary(
			v34,
			uiColor_MediumBrown,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.QuantityPicker.DecreaseMinButton.Bg", 11)
		)
	)
	mMovie:__wf_atom_e57658c2(
		"DetailsPanel.QuantityPicker.IncreaseMaxButton.Bg",
		11,
		module3.Ternary(
			v32,
			uiColor_MediumBrown,
			mMovie:__wf_atom_5e6e15c8("DetailsPanel.QuantityPicker.IncreaseMaxButton.Bg", 11)
		)
	)

	if class ~= nil then
		fn18(class.mSelectedElement)
	end

	if v28 == mQuantity2 then
		if not p3 and v30 ~= nil and _T.ShowImpactMessage then
			local v35 = mQuantity2

			if p - 1 < v35 then
				_T.ShowImpactMessage(mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/MinimumReached", false), 3)
			elseif mQuantity2 < v30 + 1 then
				_T.ShowImpactMessage(mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/MaximumReached", false), 3)
			end
		end
	else
		v4:SetText(module3.FormatNumber(mQuantity2))
		module3.PlaySound(QuantityIncreaseDecreaseSound)
	end
end

local function fn20(p)
	if p == nil or v8 or not vendorManifest:__wf_atom_b1c78aca() then
		mMovie:__wf_atom_2dedec1a("DetailsPanel.TimeRemaining", 13, false)
		return
	end

	local time = nil

	if not (__wf_atom_7e8ad928(p.VendorItem) or __wf_atom_7e8ad928(p.VendorItem.mExpiry)) then
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(p.VendorItem.mExpiry)

		if __wf_atom_db2b0cee > 0 and __wf_atom_db2b0cee < 1000000 then
			module.GetColloquialTime(mMovie, __wf_atom_db2b0cee)
			time = module5.SecondsToFormattedTime(mMovie, __wf_atom_db2b0cee)
		elseif __wf_atom_db2b0cee < 0 and not _T.VendorSyndicate then
			fn12()
			return
		end
	end

	mMovie:__wf_atom_2dedec1a("DetailsPanel.TimeRemaining", 13, time ~= nil)

	if time ~= nil then
		mMovie:__wf_atom_48bd5a59(
			"DetailsPanel",
			"TimeRemaining",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DealExpires", false, { TIME = time })
		)
	end

	if
		p.SyndLevel
		and not __wf_atom_7e8ad928(_T.VendorSyndicate)
		and module5.GetReputationInfoForSyndicate(_T.VendorSyndicate) < p.SyndLevel
	then
		mMovie:__wf_atom_7f57ab2f("DetailsPanel", "TimeRemaining", 13, true)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SyndicateLowLevelError", true, {
			RANK = p.SyndLevel
		})
		mMovie:__wf_atom_48bd5a59("DetailsPanel", "TimeRemaining", 36, __wf_atom_8e9ac384)
		v2:SetActive(false)
	end

	v11 = 1
end

local function fn21(state)
	if not (state.RawItem or __wf_atom_7e8ad928(state.Type)) then
		state.Seed = Engine.__wf_atom_774cdec4(86400)
		local predictedItemInfo = SF.PredictedItemInfo()
		predictedItemInfo.mItemType = state.Type
		local v28 = __wf_atom_6cd5fc52(state.Type:__wf_atom_5b41f63b())
		SF.__wf_atom_fe43a67d(predictedItemInfo, 3, __wf_atom_68cc0038(v28, state.Seed))
		state.RawItem = {
			mQuality = predictedItemInfo.mQuality,
			mAspectType = predictedItemInfo.mAspectType,
			mAspectFingerprint = predictedItemInfo.mAspectFingerprint
		}
	end
end

local function fn22(state)
	v18 = state ~= nil
	asyncLoader:AbortLoad("UpdateDetails")
	local v28 = state and state.Type and state.Type:IsA(__wf_atom_77e05d3b)

	if state then
		if v24 then
			v24()
			v24 = nil
		end

		local v29 = {}

		if v28 then
			if state.Type ~= nil then
				local kind = state.Type
				local resultStoreItem = state.ResultStoreItem
				table.insert(v29, kind)
				table.insert(v29, resultStoreItem)
				asyncLoader:LoadMultipleResources("UpdateDetails", v29, function(_)
					local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
					local weaponElementUpgradesAndFingerprints, v30 = module6.GetWeaponElementUpgradesAndFingerprints(state)
					local v31 = __wf_atom_7e8ad928(state.RawItem) and 0 or state.RawItem.mQuality
					local mCreator

					if not __wf_atom_7e8ad928(state.RawItem) then
						mCreator = state.RawItem.mCreator
					end

					local v32

					if not __wf_atom_7e8ad928(state.RawItem) then
						v32 = state.RawItem.mShiny
					end

					local proxyWeapon, v34 = module6.CreateProxyWeapon(
						__wf_atom_c4f78a8f,
						state.Type,
						state.Xp,
						weaponElementUpgradesAndFingerprints,
						v30,
						v31,
						nil,
						v32,
						mCreator
					)
					v24 = v34
					state.StatWeapon = proxyWeapon
					state.StatOwner = __wf_atom_c4f78a8f
					state.FixedInventoryPosition = true
					state.EmbeddedMode = true
					state.PurchaseContext = v9 == 1
					v7:SetItem(state, true)

					if mMovie:__wf_atom_a91463a8("DetailsPanel", 13) ~= v18 then
						module.ToggleElementVisibility(mMovie, "DetailsPanel", v18)
					end
				end)
			end
		elseif state.Type == nil then
			state.FixedInventoryPosition = true
			state.EmbeddedMode = true
			state.PurchaseContext = v9 == 1
			v7:SetItem(state, true)

			if mMovie:__wf_atom_a91463a8("DetailsPanel", 13) ~= v18 then
				module.ToggleElementVisibility(mMovie, "DetailsPanel", v18)
			end
		else
			local kind = state.Type
			local resultItemType = state.ResultItemType
			table.insert(v29, kind)
			table.insert(v29, resultItemType)
			asyncLoader:LoadMultipleResources("UpdateDetails", v29, function(_)
				state.FixedInventoryPosition = true
				state.EmbeddedMode = true
				state.PurchaseContext = v9 == 1
				v7:SetItem(state, true)

				if mMovie:__wf_atom_a91463a8("DetailsPanel", 13) ~= v18 then
					module.ToggleElementVisibility(mMovie, "DetailsPanel", v18)
				end
			end)
		end
	end

	if v18 and not __wf_atom_7e8ad928(gGameData) then
		local mAllowMultipurchase = v9 == 1

		if state.VendorItem then
			mAllowMultipurchase = mAllowMultipurchase and state.VendorItem.mAllowMultipurchase
		end

		local v29 = mAllowMultipurchase and module5.CanPurchaseIfAlreadyOwned(state.StoreItem)
		local v30 = (v9 == 2 and _T.VendorSyndicate and state.Count > 1 and true or v29) and not v19
		mMovie:__wf_atom_2dedec1a("DetailsPanel.QuantityPicker", 13, v30)
		local name = state.Name
		local icon = state.Icon
		local v31 = {}
		local storeItem = state.StoreItem

		if not __wf_atom_7e8ad928(storeItem) then
			storeItem:__wf_atom_17d97bf6()
			local purchasedItemType

			if storeItem:IsPackage() then
				local amount
				amount, purchasedItemType = module4.GetTotalBundledItemQuantity(storeItem:__wf_atom_72915748())

				if amount > 1 then
					v31.AMOUNT = amount
				end
			end

			state.PurchasedItemType = purchasedItemType
			local v32 = fn(purchasedItemType or storeItem)

			if storeItem:IsA(healthPotion) and v32 >= 5 then
				v2:SetActive(false)
			end

			local __wf_atom_a8dac107 = storeItem:__wf_atom_a8dac107()
			name ..= mMovie:__wf_atom_8e9ac384(module.GetRankStarIcons(__wf_atom_a8dac107), true)
		end

		fn19(1, true, true)
		fn20(state)

		if not __wf_atom_7e8ad928(v5) then
			v5:SetScrollValue(0, false, true)
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(state.Description, true, v31)
		local v32 = #__wf_atom_8e9ac384 > 0
		mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.LargeIcon", 12, 80)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.ItemDetails.LargeIcon", 13, not v32)
		mMovie:__wf_atom_50d60589("DetailsPanel.ItemDetails.Title", 36, name)

		if v9 == 1 then
			mMovie:__wf_atom_50d60589("DetailsPanel.ItemDetails.Description", 44, _G.UIColor_Tan)
			mMovie:OverrideMaterial("DetailsPanel.ItemDetails.Description", visRangeTextMat)
			mMovie:__wf_atom_50d60589("DetailsPanel.ItemDetails.Description", 36, __wf_atom_8e9ac384)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.ItemDetails.Title", 41)

			if state.CatItemType == nil or not state.CatItemType:IsA(__wf_atom_d98e64fe) then
				mMovie:__wf_atom_50d60589("DetailsPanel.ItemDetails.SubTitle", 36, "")
			else
				local v34 = __wf_atom_5e6e15c8 + 5
				mMovie:__wf_atom_50d60589(
					"DetailsPanel.ItemDetails.SubTitle",
					36,
					Localize("/SF/Language/Categories/Pact", nil)
				)
				mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.SubTitle", 1, v34)
				__wf_atom_5e6e15c8 = v34 + mMovie:__wf_atom_5e6e15c8("DetailsPanel.ItemDetails.SubTitle", 41)
			end

			local v34 = __wf_atom_5e6e15c8 + 10
			mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.Description", 1, v34)
			mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.ScrollBar", 1, v34)
			local v35 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.ItemDetails", 1) + v34
			local v36

			if v30 then
				v36 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.QuantityPicker", 1) - v35
			else
				v36 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.OwnedAndCostAmounts", 1) - v35
			end

			mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.Description", 15, v36 - 30)
		else
			mMovie:__wf_atom_50d60589("DetailsPanel.ItemDetails.SubTitle", 36, "")
		end

		mMovie:__wf_atom_c90af43a("DetailsPanel.ItemDetails.LargeIcon", icon)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.ItemDetails.StatsHolder", 13, v9 == 2)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.ItemDetails.Description", 13, v9 == 1)
		v5 = module9.CreateScrollBar(getfenv(1), "DetailsPanel.ItemDetails.ScrollBar", {
			mClipToScroll = "DetailsPanel.ItemDetails.Description",
			mVisRangeMaterials = { visRangeTextMat },
			mVisRangeFadeSize = 10
		})
	elseif mMovie:__wf_atom_a91463a8("DetailsPanel", 13) ~= v18 then
		module.ToggleElementVisibility(mMovie, "DetailsPanel", v18)
	end
end

local function fn23()
	v15 = module.GetInventoryControl()

	if __wf_atom_7e8ad928(v15) or not v15:IsA(__wf_atom_4d316097) then
		v15 = nil
	else
		v14 = v15:__wf_atom_259e7653(true)
	end
end

local function fn24()
	if __wf_atom_7e8ad928(v15) then
		fn23()
	end
end

local function fn25()
	if not _T.VendorOverlayMode then
		local v28 = {
			mMovie = mMovie,
			mLabel = mMovie:__wf_atom_8e9ac384(v12, false),
			mInnerIcon = topTitleIcon,
			mMinWidth = 608
		}

		if _T.ShowCurrencyBar ~= nil then
			_T.ShowCurrencyBar(v28)
		end
	end
end

function Close()
	if flag then
		return
	end

	_T.InfoPopup_Data = nil

	if v19 then
		module.ToggleElementVisibility(mMovie, "DetailsPanel", false)
		module.ToggleElementVisibility(mMovie, "EmptyState", false)
		module.ToggleElementVisibility(mMovie, "ListContainer", false)
		mMovie:__wf_atom_2dedec1a("RewardDetails", 13, false)
	else
		module3.PlaySound(avakotExitSound)
		flag = true

		if v24 then
			v24()
			v24 = nil
		end

		local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

		if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
			__wf_atom_2ad5cd23:Execute("ChildClosed", "")
		end

		module.DissolveOutAndClose(mMovie)

		if _T.HideCurrencyBar ~= nil then
			_T.HideCurrencyBar(mMovie)
		end
	end
end

function IsClosing()
	return flag
end

local function fn26(_)
	local v28 = {}

	if not v19 then
		table.insert(v28, {
			Label = "/Lotus/Language/Menu/Global_Back",
			CallBack = Close,
			CallOut = "MENU_CANCEL"
		})
	end

	if _T.SetButtons ~= nil then
		_T.SetButtons(mMovie, v28, getfenv(1))
	end
end

local function fn27()
	local module10 = require("EE.Interface.Components.ItemList")
	class = module10.Create(getfenv(1), "ListContainer")
	class.mForcedVerticalSeparation = 50

	function class:mElementDrawCallback()
		if self == nil then
			return
		end

		local count = nil
		local showCount = false
		local v28 = ""

		if v9 == 1 and not v19 then
			if not self.Header then
				if _T.VendorOverlayMode then
					if __wf_atom_7e8ad928(self.SpecialPriceIconTag) or __wf_atom_7e8ad928(self.SpecialPrice) then
						if not __wf_atom_7e8ad928(self.VendorItem) then
							local v29, v30 = fn6(self)
							v28 = fn7(v29, v30)
							showCount, count = fn5(self.VendorItem, self.StoreItem)
							self.Premium = v30 > 0
						end
					else
						v28 = Localize(self.SpecialPriceIconTag .. module3.FormatNumber(self.SpecialPrice), nil)
					end
				else
					local v29, v30 = fn6(self)
					v28 = fn7(v29, v30)
					showCount, count = fn5(self.VendorItem, self.StoreItem)
					self.Premium = v30 > 0
				end
			end
		elseif v9 == 2 then
			if __wf_atom_7e8ad928(self.SpecialPriceIconTag) or __wf_atom_7e8ad928(self.SpecialPrice) then
				if self.SellingPrice then
					v28 = mMovie:__wf_atom_8e9ac384("<DRACS> " .. self.SellingPrice, true)
				end
			else
				v28 = Localize(self.SpecialPriceIconTag .. module3.FormatNumber(self.SpecialPrice), nil)
			end
		end

		if not self.Header then
			self.Subheading = "<font letterSpacing=\"-1\">" .. v28 .. "</font>"
		end

		self.ShowCount = showCount

		if showCount and count ~= nil then
			self.Count = count
		end

		if
			self.SyndLevel
			and not (__wf_atom_7e8ad928(_T.VendorSyndicate) or self.Header)
			and module5.GetReputationInfoForSyndicate(_T.VendorSyndicate) < self.SyndLevel
		then
			self.ShowStatusIcon = true
			self.StatusIconRight = lockedIcon
			self.StatusIconScale = 150
			mMovie:__wf_atom_c90af43a(self.mClipName .. ".StatusIcon", lockedIcon)
			mMovie:__wf_atom_e57658c2(self.mClipName .. ".StatusIcon", 0, 485)
			mMovie:__wf_atom_2dedec1a(self.mClipName .. ".StatusIcon", 13, true)
			mMovie:__wf_atom_e57658c2(self.mClipName, 12, 50)
		end
	end

	function class.mOnSelectedCallback(p)
		if p == nil or p.Header then
			return
		end

		if module2.MarkItemIsNew(p, false) then
			class:Redraw(nil, true, true)
		end

		fn22(p)
	end
end

local function fn28()
	mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.Title", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("DetailsPanel.ItemDetails.SubTitle", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("DetailsPanel.OwnedAndCostAmounts.OwnedText", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_50d60589(
		"DetailsPanel.QuantityPicker.Title",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SelectQuantity", false)
	)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker.Title", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("DetailsPanel.TimeRemaining", 44, _G.UIColor_Yellow)

	for i = 1, 4 do
		mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker." .. fn9(i) .. ".Bg", 11, _G.UIColor_MediumBrown)
		mMovie:__wf_atom_c90af43a("DetailsPanel.QuantityPicker." .. fn9(i) .. ".Icon", quantityIcons[i])
		mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker." .. fn9(i), 100, i)
		mMovie:SetCallbacks(
			"DetailsPanel.QuantityPicker." .. fn9(i),
			"QuantityButtonRollOver",
			"QuantityButtonRollOut",
			nil,
			"QuantityButtonClick"
		)
	end

	mMovie:__wf_atom_50d60589("DetailsPanel.QuantityPicker.Quantity", 44, _G.UIColor_Yellow)
	mMovie:OverrideMaterial("DetailsPanel.QuantityPicker.Bg", _G.UIMaterial_UnfocusedTabBorder)
	local module10 = require("SF.Interface.Components.ThemedInputField")
	v4 = module10.Create(mMovie, "DetailsPanel.QuantityPicker.Amount", nil, nil, nil, false)
	v4:SetType(v4.TYPE.PLAIN, nil, nil)
	v4:SetWidth(300)
	v4:SetNumbersOnly()
	v4:SetText("1")
	v4:SetTextAlignment("center")
	v4:UpdateColors()
	v4.BaseInputFieldFocused = v4.InputFieldFocused

	function v4.InputFieldFocused(object, p)
		object:BaseInputFieldFocused(p)

		if p then
			object:SetText("")
			return
		end

		local v28 = tonumber(mMovie:__wf_atom_387f260e("DetailsPanel.QuantityPicker.Amount.Label", 36))

		if v28 == nil or not (v28 >= 0) then
			object:SetText(module3.FormatNumber(mQuantity2 or 1))
		else
			fn19(v28, true)
		end
	end

	local module11 = require("SF.Interface.Components.Button")
	v2 = module11.Create(mMovie, "DetailsPanel.PurchaseButton", "", "PurchaseItem")
	v2:SetVariant(module11.VARIANTS.SPECIAL_BUTTON)
	v2:SetAnchor(module3.CENTER_ALIGNED)
end

local function fn29()
	if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v15) then
		return
	end

	class:RemoveElements(true, true)

	if _T.VendorSyndicate then
		fn11(v14:__wf_atom_c84817dd())
		return
	end

	fn11(v14:__wf_atom_4259c789(), 5)
	fn11(v14:__wf_atom_4f67b86c(), 1)
	fn11(v14:__wf_atom_ebdc4e6e(), 3)
end

local function fn30()
	class:RemoveElements(true, true)

	for i = 1, #mItemList do
		local v28 = mItemList[i]

		if not (__wf_atom_7e8ad928(v28.StoreItem) or not ((fn(v28.StoreItem) or 0) > 0) or module5.CanPurchaseIfAlreadyOwned(v28.StoreItem) or not __wf_atom_7e8ad928(v28.ResultStoreItem) and v28.StoreItem:__wf_atom_1dd35883() > 1) then
			continue
		end

		fn21(v28)
		class:AddElement(v28, true)
	end
end

local function fn31(p)
	v9 = p or v9

	if _T.VendorSyndicate ~= nil then
		local _, v28 = module5.GetReputationInfoForSyndicate(_T.VendorSyndicate)
		v22 = v28
	end

	fn22()

	if v9 == 1 then
		if flag2 then
			if v19 then
				class:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/FactionChooseReward", true, {
					NUMBER = module5.GetReputationInfoForSyndicate(_T.VendorSyndicate)
				}))
			else
				class:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/FactionBuy", true))
			end
		end

		fn30()
	else
		if flag2 then
			class:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/FactionSell", true))
		end

		fn29()
	end

	class:ResetScrollBar()
	class:Redraw(nil, true, true)
	class:UpdateWidth()
	local mMovie = mMovie
	mMovie:__wf_atom_2dedec1a("EmptyState", 13, v9 ~= 1 and #class.mElements == 0)
end

local function fn32()
	if v3 == nil then
		return
	end

	v3:RemoveElements(true, true)

	if v19 then
		v3:AddElement({ Label = "/SF/Language/Vendor/ClaimItem" }, true)
	else
		v3:AddElement({ Label = "/SF/Language/Vendor/BuyItem" }, true)

		if _T.VendorSyndicate == nil or mInventoryList ~= nil then
			v3:AddElement({ Label = "/SF/Language/Vendor/SellItem" }, true)
		end
	end

	v3:Redraw()
	local x = v3:CalculateX({
		mIndex = #v3.mElements + 1
	})
	mMovie:__wf_atom_e57658c2("ListContainer.States.Backer", 14, x + 180)
	mMovie:__wf_atom_e57658c2("ListContainer.States.Backer", 12, 80)
	v3:SelectElement(v3.mStates.BUY, false)
	v3:Redraw(nil, true, true)
end

local function fn33(_)
	local module10 = require("EE.Interface.Components.List")
	local v28 = flag2 and "ListContainer.Categories.List.Tab1" or "ListContainer.States.State1"
	v3 = module10.CreateNewList(getfenv(1), v28)

	if _T.VendorSyndicate then
		v3.mStateIcons = {}
		local __wf_atom_3721e8fd = _T.VendorSyndicate:__wf_atom_3721e8fd()
		table.insert(v3.mStateIcons, __wf_atom_3721e8fd)
		local standingCurrencyIcon = standingCurrencyIcon
		table.insert(v3.mStateIcons, standingCurrencyIcon)
	end

	v3.mStates = { BUY = 1, SELL = 2 }
	v3.mState = nil
	v3.mForcedVerticalSeparation = flag2 and 50 or 0
	v3.mInitialX = 0

	function v3:CalculateX(p)
		if flag2 then
			return self.mInitialX
		end

		local mIndex = p.mIndex

		if mIndex == nil then
			mIndex = self:GetElementIndexById(p.Id)
		end

		if mIndex == nil then
			return self.mInitialX
		end

		local total = 0

		for i = 1, mIndex - 1 do
			local elementInIndex = self:GetElementInIndex(i)

			if elementInIndex ~= nil then
				total += elementInIndex.LabelWidth + 60
			end
		end

		return self.mInitialX + total
	end

	function v3.mClipCreatedCallback(_) end

	function v3.UpdateFocused(p, p2)
		local v29 = v3.mSelectedElement ~= nil and v3.mSelectedElement.mIndex == p.mIndex
		mMovie:__wf_atom_4c1c1986(
			p.mClipName,
			"Label",
			44,
			module3.Ternary(p2 or v29, _G.UIColor_Yellow, _G.UIColor_Tan)
		)
	end

	function v3.mOnFocusedCallback(p)
		if flag2 then
			local v29

			if v3.mSelectedElement == nil then
				v29 = false
			else
				v29 = v3.mSelectedElement.mIndex == p.mIndex
			end

			if v29 then
				return
			else
				mMovie:OverrideMaterial(p.mClipName .. ".Backer", _G.UIMaterial_FocusedTabBorder)
			end
		end

		module3.PlaySound(_G.UISound_Focus)
		v3.UpdateFocused(p, true)
	end

	function v3.mOnUnfocusedCallback(p)
		if flag2 then
			local v29

			if v3.mSelectedElement == nil then
				v29 = false
			else
				v29 = v3.mSelectedElement.mIndex == p.mIndex
			end

			local mMovie = mMovie
			local v30 = p.mClipName .. ".Backer"
			local v31

			if v29 then
				v31 = _G.UIMaterial_SelectedTabBorder
			else
				v31 = _G.UIMaterial_UnfocusedTabBorder
			end

			mMovie:OverrideMaterial(v30, v31)
		end

		v3.UpdateFocused(p, false)
	end

	function v3:mElementDrawCallback()
		local focusedElementIndex = v3:GetFocusedElementIndex()
		local v29

		if focusedElementIndex == nil then
			v29 = false
		else
			v29 = focusedElementIndex == self.mIndex
		end

		local v30

		if v3.mSelectedElement == nil then
			v30 = false
		else
			v30 = v3.mSelectedElement.mIndex == self.mIndex
		end

		if flag2 and v3.mStateIcons then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "SpecialIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, false)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Detail.Right", 13, false)
			mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", v3.mStateIcons[self.Id])
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 0, -16)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, 32)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 15, 32)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, true)

			if v30 then
				mMovie:OverrideMaterial(self.mClipName .. ".Backer", _G.UIMaterial_SelectedTabBorder)
				mMovie:__wf_atom_7f57ab2f(self.mClipName, "Detail", 13, true)
			else
				if v29 then
					mMovie:OverrideMaterial(self.mClipName .. ".Backer", _G.UIMaterial_FocusedTabBorder)
				else
					mMovie:OverrideMaterial(self.mClipName .. ".Backer", _G.UIMaterial_UnfocusedTabBorder)
				end

				mMovie:__wf_atom_7f57ab2f(self.mClipName, "Detail", 13, false)
			end
		else
			mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Label.text", self.Label)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bookends", 13, v30)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bookends.Right", 13, false)
			v3.UpdateFocused(self, v29)
			self.LabelWidth = mMovie:__wf_atom_cfc41e35(self.mClipName, "Label", 40)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Bookends.Right", 0, self.LabelWidth + 52)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, self.LabelWidth)
		end
	end

	function v3.mOnSelectedCallback(p, _)
		mMovie:OverrideMaterial(p.mClipName .. ".Backer", _G.UIMaterial_SelectedTabBorder)
		module3.PlaySound(_G.UISound_Select)
		fn31(p.mIndex)
		v3:Redraw(nil, true, true)
	end

	local redraw = v3.Redraw

	function v3:Redraw(p, p2, p3)
		redraw(self, p, p2, p3)
	end

	fn32()

	if flag2 then
		mMovie:__wf_atom_2dedec1a("ListContainer.Categories", 13, true)
		mMovie:__wf_atom_2dedec1a("ListContainer.States", 13, false)
	else
		mMovie:__wf_atom_2dedec1a("ListContainer.States", 13, true)
		mMovie:__wf_atom_2dedec1a("ListContainer.Categories", 13, false)
	end
end

function Shutdown()
	if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(vendorManifest) or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
			__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), vendorManifest:GetName())
		end
	end

	Close()
	module2.SetChatVisible(true)
	module.HideBackground()
	_T.VendorOverlayMode = nil
	_T.VendorSyndicate = nil
	_T.vendorManifestOverride = nil
	module.RegisterHideHud(false)
	v17 = nil
end

local function fn34()
	mMovie:__wf_atom_e57658c2("ThankYouPopup", 12, 0)
	mMovie:__wf_atom_50d60589(
		"ThankYouPopup.Text",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ThankYouPopupTitle", false)
	)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Text", 44, 14524216)
	mMovie:OverrideMaterial("ThankYouPopup.Glow.Shadow", mRankUpBgMaterial)
	mMovie:OverrideMaterial("ThankYouPopup.Glow.Mist", mRankUpBgMaterial)
end

function Initialize()
	if _T.VendorSyndicate then
		flag2 = true
	else
		flag2 = false
	end

	module2.SetChatVisible(false)
	module.RegisterHideHud(true)
	v10 = false
	v13 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	v6 = module8.Create(mMovie)
	v6:Register(mMovie, "ThankYouPopup", { v6.ANCHOR_V_CENTRE, v6.ANCHOR_H_CENTRE })
	local module10 = require("SF.Interface.ItemInfoPopup")
	v7 = module10.Create(mMovie, "DetailsPanel.ItemInfoPanel", {
		PopupMode = false,
		UseGlobalData = false,
		MaxScale = 119
	})
	fn24()
	fn26()
	fn27()
	fn28()
	fn33()
	fn22()
	fn34()
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, false)
	fn25()
	local __wf_atom_a96eb2aa = gRegion:__wf_atom_c4f78a8f():__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		v16 = __wf_atom_a96eb2aa:__wf_atom_330f77f5(false)
	end

	if not __wf_atom_7e8ad928(_T.vendorManifestOverride) then
		vendorManifest = _T.vendorManifestOverride
	end

	mMovie:__wf_atom_2dedec1a("RewardDetails", 13, false)
	mMovie:__wf_atom_50d60589(
		"RewardDetails.DetailsTitle",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/FactionChoiceTitle", true)
	)
	mMovie:__wf_atom_e57658c2("RewardDetails.DetailsTitle", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_50d60589(
		"RewardDetails.DetailsBody",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/FactionChoiceDetails", true)
	)
	mMovie:__wf_atom_e57658c2("RewardDetails.DetailsBody", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_50d60589("RewardDetails.DetailsTitle", 0, 0)
	mMovie:__wf_atom_50d60589("RewardDetails.DetailsBody", 0, 0)
	mMovie:OverrideMaterial("ListContainer.Bg", _G.UIMaterial_SelectedBackerBorder)
	mMovie:OverrideMaterial("EmptyState.PaperBacker", _G.UIMaterial_DarkPaperBacker)
	mMovie:__wf_atom_e57658c2("EmptyState.Label", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_50d60589(
		"EmptyState.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/NothingToSell", false)
	)
	mMovie:__wf_atom_c90af43a("EmptyState.BagIcon", bagIcon)
	mMovie:OverrideMaterial("Darkener", visRangeMaterial)
	mMovie:__wf_atom_2dedec1a("ListContainer.States.Backer", 13, false)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, 0)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, 0.6)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0.1)

	if _T.VendorSyndicate then
		module.DissolveIn(mMovie)
	else
		v17 = gRegion:PlaySound(vendorMusic, Vector(), false)
		module.ShowBackground({ mFade = module3.LEFT_ALIGNED })
		fn12()
	end

	if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(vendorManifest) or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NIGHTFOLD_MENU_OPEN"), vendorManifest:GetName())
			__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_MENU_TIME"), vendorManifest:GetName())
		end
	end

	onViewportSizeChanged()
end

function Update()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsKilled() then
		mMovie:Close()
		return
	end

	local v28 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v28)
	asyncLoader:Update()

	if class ~= nil and class.mSelectedElement ~= nil then
		v11 -= v28

		if v11 <= 0 then
			fn20(class.mSelectedElement)
		end
	end
end

local function fn35()
	if v19 then
		if v24 then
			v24()
			v24 = nil
		end

		mMovie:Close()
		local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

		if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
			__wf_atom_2ad5cd23:Execute("ChildClosed", "")
		end
	end
end

local function fn36(p)
	if p ~= nil then
		if __wf_atom_7e8ad928(mMovie) then
			return
		end

		if p then
			local mSelectedElement = class.mSelectedElement

			if mSelectedElement ~= nil then
				fn8(mQuantity2 .. " " .. mSelectedElement.Name, {
					Icon = mSelectedElement.Icon,
					Life = 2
				})
			end

			fn23()
			fn25()
			fn22()
			module3.PlaySound(purchaseConfirmSound)
			local v28 = __wf_atom_7e8ad928(_T.VendorSyndicate) and "/SF/Language/Vendor/ThankYouPopupAvakot"
				or "/SF/Language/Vendor/ThankYouPopupTitle"
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v28, false)
			module2.ShowThankYouPopup(
				mMovie,
				thankYouPopupIcon,
				mSelectedElement.Icon,
				__wf_atom_8e9ac384,
				mBurstFx,
				fn35
			)

			if not _T.VendorSyndicate then
				OnVendorManifestLoaded(true)
			end

			fn31()

			if v23 ~= nil and not __wf_atom_7e8ad928(_T[v23]) then
				_T[v23](p)
			end
		else
			module3.ShowMessage("/SF/Language/Vendor/PurchaseFailed")
		end
	end
end

function OnItemSold(p, _)
	v10 = false
	v25 = nil

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	if p then
		module3.PlaySound(sellConfirmSound)
		local v28 = { Icon = dracsIcon, Life = 2 }
		fn8(v26.mSellPrice .. " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/Dracs", false), v28)
	else
		module3.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	fn23()
	fn25()
	fn31()
end

function SellItem(p)
	if tonumber(p) ~= 4 or v10 or class == nil then
		return
	end

	local mSelectedElement = class.mSelectedElement

	if mSelectedElement == nil or __wf_atom_7e8ad928(mSelectedElement) then
		return
	end

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
	end

	v10 = true
	v26 = nil
	v26 = SF.SellOperation()
	v26:__wf_atom_afdfc7fe()
	local category = mSelectedElement.Category
	local sellingPrice = mSelectedElement.SellingPrice
	local mItemId = tostring(mSelectedElement.RawItem.mItemId)
	v26:SellItem(category, mItemId, mQuantity2)
	v26.mSellCurrency = 0
	v26.mSellPrice = sellingPrice
	v25 = SF.SellCommand(v26, "OnItemSold")
	v25:Execute()
end

function DonateDogTags(p)
	local mSelectedElement = class.mSelectedElement

	if mSelectedElement == nil then
		return
	end

	local vendorSyndicate = _T.VendorSyndicate
	v21 = SF.SyndicateStandingBonusOperation()
	v21.mAffiliationTag = vendorSyndicate:__wf_atom_e0f044e1()
	local v28 = mQuantity2 * mSelectedElement.SpecialPrice
	v21:AddItem(mSelectedElement.Type, mQuantity2)
	local _, v29, v30, _, v31 = module5.GetReputationInfoForSyndicate(vendorSyndicate)

	if not vendorSyndicate:__wf_atom_73f36e1b() then
		if v30 < 0 then
			v31 = math.abs(v29)
		else
			v31 = v30 - v29
		end
	end

	if not p then
		if v31 == 0 then
			local __wf_atom_bca3f82a = vendorSyndicate:__wf_atom_bca3f82a()
			local v32 = __wf_atom_bca3f82a > 0
				and __wf_atom_bca3f82a < 3
				and gGameData:__wf_atom_dc1594a9(__wf_atom_bca3f82a) == 0
				and "/Lotus/Language/Menu/Syndicates_DogTag_DailyLimit_Reached"
				or "/Lotus/Language/Menu/Syndicates_ReputationOverflow"
			module3.ShowErrorMessage(v32)
			return
		elseif v31 < v28 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Syndicates_DogTag_StandingWasteWarning",
				true,
				{
					STANDING = module3.FormatNumber(v28 - v31)
				}
			)
			module3.ShowYesOrNoMessage(
				__wf_atom_8e9ac384,
				"ConfirmDogTagPartial",
				nil,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/DailyCapOrLimitWasteTitle", true)
			)
			return
		end
	end

	local rep = math.min(v28, v31)
	local v32 = {}
	table.insert(v32, {
		Name = vendorSyndicate:__wf_atom_818ea3a7(),
		Rep = rep
	})

	for _, v35 in ipairs(vendorSyndicate:__wf_atom_27217f21()) do
		if __wf_atom_7e8ad928(v35.other) then
			continue
		end

		local rep2 = v28 * v35.multiplier

		if rep2 ~= 0 then
			table.insert(v32, {
				Name = Resource(v35.other:__wf_atom_5b41f63b()):__wf_atom_818ea3a7(),
				Rep = rep2
			})
		end
	end

	table.sort(v32, function(a, b)
		return a.Rep > b.Rep
	end)
	local changes = ""

	for _, v36 in ipairs(v32) do
		local v37 = mSelectedElement.SpecialPriceIconTag .. module3.FormatNumber(v36.Rep, 0)

		if v36.Rep > 0 then
			v37 = "+" .. v37
		end

		changes ..= v37 .. " " .. string.upper(mMovie:__wf_atom_8e9ac384(v36.Name:c_str(), false)) .. "\r"
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/StandingChangeConfirm", false, {
		CHANGES = changes
	})
	module3.ShowYesOrNoMessage(__wf_atom_8e9ac384, "ConfirmDogTagAll", nil, "/SF/Language/Vendor/SellItemHeading")
end

function ConfirmDogTagPartial(p)
	if tonumber(p) == 4 then
		DonateDogTags(true)
	end
end

function ConfirmDogTagAll(p)
	if tonumber(p) == 4 then
		gGameData:__wf_atom_4180443b(v21, "OnDonateDogTagsComplete")
	end
end

function OnDonateDogTagsComplete(p, _)
	if p then
		module3.PlaySound(sellConfirmSound)

		if v23 ~= nil and not __wf_atom_7e8ad928(_T[v23]) then
			_T[v23](4)
		end
	else
		module3.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	fn23()
	fn25()
	fn31()
end

local function fn37()
	if class == nil then
		return
	end

	local mSelectedElement = class.mSelectedElement

	if mSelectedElement == nil then
		return
	end

	if mSelectedElement.Type:IsA(WeakResource("/SF/Types/Items/FactionItems/SyndicateRepToken")) then
		DonateDogTags()
		return
	end

	local name = mSelectedElement.Name
	local convertColorNumberToHex = module3.ConvertColorNumberToHex(_G.UIColor_Yellow)
	local v28 = "<font face=\"Spectral SC\" color=\"" .. convertColorNumberToHex .. "\">" .. name .. "</font>"
	local price = "<font face=\"Spectral SC\" color=\"" .. convertColorNumberToHex .. "\"><DRACS>" .. mSelectedElement.SellingPrice .. "</font>"
	local v29 = "<p><font >" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ConfirmSale", true, {
		PRICE = price,
		ITEM = v28
	}) .. "</font></p>"
	module3.ShowYesOrNoMessage(v29, "SellItem", nil, "/SF/Language/Vendor/SellItemHeading")
end

local function fn38(mSelectedElement, fn39, mQuantity)
	if v ~= nil and not __wf_atom_7e8ad928(_T[v]) then
		_T[v](mSelectedElement, fn39, mQuantity)
		return
	end

	if
		mSelectedElement == nil
		or __wf_atom_7e8ad928(mSelectedElement.StoreItem)
		or __wf_atom_7e8ad928(vendorManifest)
	then
		return
	end

	local __wf_atom_5b817062 = gGameData:__wf_atom_5b817062(vendorManifest)
	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 7

	if mSelectedElement and mSelectedElement.Seed and mSelectedElement.RawItem then
		purchaseParams.mSeed = mSelectedElement.Seed
	end

	if vendorManifest:__wf_atom_b1c78aca() then
		purchaseParams.mSourceId = tostring(__wf_atom_5b817062.mId)
		local v28 = {
			ItemId = tostring(mSelectedElement.VendorItem.mId)
		}
		purchaseParams.mExtraPurchaseInfoJson = cjson.encode(v28)
	else
		purchaseParams.mSourceId = vendorManifest:__wf_atom_5b41f63b()
	end

	purchaseParams.mStoreItem = mSelectedElement.StoreItem
	purchaseParams.mQuantity = mQuantity
	purchaseParams.mSkipConfirm = false
	_T.GenericVendor_NameOverride = mSelectedElement.Name
	_T.DoPurchase(purchaseParams, fn39)
end

function FakeBuyItem()
	if v20 then
		fn36(true)
	end
end

function PurchaseItem()
	if v9 == 2 then
		fn37()
		return
	end

	if __wf_atom_7e8ad928(_T.BuyItem) or class == nil then
		return
	end

	if v20 then
		module3.ShowMessage("[DEV] test flow, no items acquired", "FakeBuyItem")
	else
		fn38(class.mSelectedElement, fn36, mQuantity2)
	end
end

local function fn39(mItemManifest, mStoreItem)
	local count = 0

	for _, item in pairs(mItemManifest) do
		if not item.mRotatedWeekly then
			continue
		end

		if item.mStoreItem:IsA(mStoreItem) then
			return count
		else
			count += 1
		end
	end

	return -1
end

function OnVendorManifestLoaded(p, _)
	if not __wf_atom_7e8ad928(_T.CustomVendorItems) then
		return
	end

	if not p then
		module3.ShowMessage("/Lotus/Language/Menu/VendorDataFailed")
		return
	end

	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		return
	end

	local mItemManifest = nil
	local __wf_atom_9af0765f = vendorManifest:__wf_atom_9af0765f()
	local __wf_atom_b1c78aca = vendorManifest:__wf_atom_b1c78aca()

	if __wf_atom_b1c78aca then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		local __wf_atom_5b817062 = gGameData:__wf_atom_5b817062(vendorManifest)

		if __wf_atom_5b817062.mItemType == vendorManifest then
			mItemManifest = __wf_atom_5b817062.mItemManifest
		end
	else
		mItemManifest = __wf_atom_9af0765f
	end

	local __wf_atom_0f216bb4 = vendorManifest:__wf_atom_0f216bb4()
	local weekCount = module5.GetWeekCount()
	mItemList = {}
	local count = 0

	for _, vendorItem in mItemManifest do
		local mStoreItem = vendorItem.mStoreItem

		if __wf_atom_7e8ad928(mStoreItem) then
			continue
		end

		local mId = vendorItem.mStoreItem:__wf_atom_5b41f63b()

		if not vendorItem.mId:__wf_atom_b70c3343() then
			mId = tostring(vendorItem.mId)
		end

		local v28, v29 = fn5(vendorItem, mStoreItem)
		local mRotatedWeekly = vendorItem.mRotatedWeekly

		if mRotatedWeekly and not __wf_atom_b1c78aca then
			mId = tostring(mStoreItem:__wf_atom_5b41f63b()) .. "_Weekly"
		end

		local mShowInVendorUI = vendorItem.mShowInVendorUI

		if mShowInVendorUI then
			if __wf_atom_b1c78aca and not (Engine.__wf_atom_db2b0cee(vendorItem.mExpiry) > 0) then
				mShowInVendorUI = false
			else
				mShowInVendorUI = vendorItem.mPurchaseQuantityLimit == 0
					or (not mRotatedWeekly or gGameData:__wf_atom_8a426954(vendorManifest:__wf_atom_5b41f63b(), mId) < vendorItem.mPurchaseQuantityLimit)
			end
		end

		if v28 then
			mShowInVendorUI = mShowInVendorUI and v29 > 0
		end

		if mShowInVendorUI and mRotatedWeekly then
			local v30 = fn39(mItemManifest, mStoreItem)

			if v30 >= 0 then
				mShowInVendorUI = weekCount % __wf_atom_0f216bb4 == v30
			end
		end

		if mShowInVendorUI then
			if __wf_atom_b1c78aca then
				while count < #__wf_atom_9af0765f do
					count += 1

					if __wf_atom_9af0765f[count].mStoreItem ~= mStoreItem then
						continue
					end

					mShowInVendorUI = __wf_atom_9af0765f[count]:__wf_atom_76ab6ce8()
					break
				end
			else
				mShowInVendorUI = vendorItem:__wf_atom_76ab6ce8()
			end
		end

		if not mShowInVendorUI then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(mMovie, mStoreItem, nil, nil, nil, true)
		storeItemInfo.VendorItem = vendorItem
		storeItemInfo.Priority = module3.Ternary(storeItemInfo.VendorItem.mPremiumPrice.maxValue > 0, 1, 2)
		storeItemInfo.Count = nil

		if storeItemInfo.Header then
			storeItemInfo.listExtraY = -18
			storeItemInfo.mHeight = 340
		else
			storeItemInfo.mHeight = 90
		end

		table.insert(mItemList, storeItemInfo)
	end

	fn13(mItemList)
	table.sort(mItemList, fn14)
	fn31()
end

function QuantityButtonClick(p, _)
	if p == 1 then
		fn19(1, true)
	elseif p == 2 then
		fn19(mQuantity2 - 1)
	elseif p == 3 then
		fn19(mQuantity2 + 1, true)
	else
		fn19(1e999, true)
	end
end

function QuantityButtonRollOver(p, _)
	local mSelectedElement = class.mSelectedElement

	if
		__wf_atom_7e8ad928(mSelectedElement)
		or (p <= 2 and mQuantity2 <= 1 or p >= 3 and mQuantity2 >= mSelectedElement.Count)
	then
		return
	end

	module3.PlaySound(_G.UISound_Focus)
	local v28 = fn9(p)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker." .. v28 .. ".Bg", 11, 4608060)
end

function QuantityButtonRollOut(p, _)
	local v28 = fn9(p)
	mMovie:__wf_atom_e57658c2("DetailsPanel.QuantityPicker." .. v28 .. ".Bg", 11, _G.UIColor_MediumBrown)
end

function onKeyUp_MENU_CANCEL()
	if not v19 then
		Close()
	end

	return true
end

function onKeyUp_MENU_LTRIGGER2()
	local v28 = v9 - 1
	local v29 = v28 == 0 and #v3.mElements or v28
	v3:SelectElement(v29, true)
	return true
end

function onKeyUp_MENU_RTRIGGER2()
	local v28 = v9 % #v3.mElements + 1
	v3:SelectElement(v28, true)
	return true
end

function SetVendorInfoFunction(p)
	local v28 = _T[p]

	if v28 == nil then
		return
	end

	local v29 = v28()

	if v29 == nil then
		return
	end

	mInventoryList = v29.mInventoryList
	mItemList = v29.mItemList

	for i = 1, #mItemList do
		if mItemList[i].Header then
			continue
		end

		mItemList[i] = module4.GetStoreItemInfo(
			mMovie,
			mItemList[i].StoreItem,
			{ AppendInfo = mItemList[i] },
			nil,
			nil,
			true
		)
		mItemList[i].mHeight = 95
	end

	fn32()
	fn31()
end

function SetBuyItemFunction(p)
	v = p
end

function SetMustBuyToExitTag(_) end

function SetRewardMode(p, p2)
	v20 = p2 == "true"
	v19 = p == "true"
	mMovie:__wf_atom_2dedec1a("RewardDetails", 13, v19)
	fn32()
	fn10()
	fn26()
end

function OverrideVendorName(p)
	v12 = p
	fn25()
end

function CheckQuestCompletion(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:GetItem()) then
		return false
	end

	return module7.HasPersonalCompletedQuest(questRequirement)
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v6) then
		v6:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	local screenDimensions, v28 = module3.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 15, v28)
end