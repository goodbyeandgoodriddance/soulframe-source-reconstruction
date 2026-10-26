local v = {
	"ArcherySkillTree",
	"SecondaryThrowingKnivesSkillTree",
	"GreatswordSkillTree",
	"SwordSkillTree",
	"CastingSkillTree",
	"PolearmSkillTree",
	"ShieldSkillTree",
	"DaggerSkillTree"
}
local v2 = {}
local v3 = nil
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Interface.Libs.UIUtilities")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("SF.Scripts.Libs.TransmissionSet")
local module7 = require("SF.Interface.Libs.StatsUtil")
local module8 = require("EE.Interface.AnchorMgr")
local module9 = require("SF.Interface.Libs.ItemUtil")
local v4 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local v5 = { WeakResource("/SF/Upgrades/Skins/Hair/BaseEquipHair") }
local v6 = nil
local infoPopup_Grid = nil
local purchasedItems = nil
local v7 = {}
local storeItemInfos = {}
local v8 = nil
local v9 = nil
local buyElementResult = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = {}
local flag = false
local v14 = {}
local v15 = nil
local v16 = 0
local v17 = 1
local element = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local asyncLoader = module3.CreateAsyncLoader()

local function fn(p)
	if not __wf_atom_7e8ad928(gRegion) then
		module6.PlayLocalTransmission(_T.marketVendorTransmissionSet, Symbol(p), gRegion:__wf_atom_c4f78a8f())
	end
end

local function fn2()
	v8 = module2.GetInventoryControl()

	if not __wf_atom_7e8ad928(v8) then
		v9 = v8:__wf_atom_259e7653(true)
	end

	purchasedItems = module5.GetPurchasedItems(v4, v9)

	if infoPopup_Grid ~= nil then
		infoPopup_Grid.PurchasedItems = purchasedItems
	end

	local infoPopup_Data = _T.InfoPopup_Data

	if infoPopup_Data ~= nil then
		infoPopup_Data.Refresh = true
	end
end

local function fn3()
	if _T.SetButtons == nil then
		return
	end

	local v22 = {}
	table.insert(v22, {
		Label = "/SF/Language/Menu/Menu_Back",
		CallBack = onKeyDown_MENU_CANCEL,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v22, getfenv(1))
end

function ShowItemTicker(p)
	if p == v12 then
		return
	end

	v12 = p
	module2.RegisterHideHud(not p)
	local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/HUD/Hud.swf"))

	if movie then
		movie:__wf_atom_f0448d34(p)
	end
end

function OnItemSold(p, _)
	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	if p then
		ShowItemTicker(true)
		v21:ClearTimers()
		v21:AddTimer(5, function()
			ShowItemTicker(false)
		end)
		module.PlaySound(sellConfirmSound)
		local v22 = { Icon = dracsIcon, Life = 2 }
		local v23 = v10.SellingPrice .. " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/Dracs", false)
		module2.AddPickupLogMessage(v23, v22)
	else
		module.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	fn2()
	InitializeSellItems()
	infoPopup_Grid:RefreshState()
	v10 = nil
	flag = false
	v11 = nil
end

function SellItem(p)
	if tonumber(p) == 4 and v10 ~= nil then
		if _T.BackgroundMovie ~= nil then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
		end

		local sellOperation = SF.SellOperation()
		sellOperation:__wf_atom_afdfc7fe()
		local category = v10.Category
		local sellingPrice = v10.SellingPrice
		sellOperation:SellItem(category, tostring(v10.ItemInfo), 1)
		sellOperation.mSellCurrency = 0
		sellOperation.mSellPrice = sellingPrice
		v11 = SF.SellCommand(sellOperation, "OnItemSold")
		v11:Execute()
	else
		v10 = nil
		flag = false
	end
end

local function fn4(data)
	if data == nil or flag then
		return
	end

	flag = true
	v10 = data
	local name = data.Name
	local sellingPrice = data.SellingPrice
	local v22 = "<font face=\"Spectral SC\" color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">"
	local v23 = v22 .. Localize(name, nil) .. "</font>"
	local price = v22 .. mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/CurrencyAmount", true, {
		AMOUNT = sellingPrice
	}) .. "</font>"
	local v24 = "<p><font >" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ConfirmSale", true, {
		PRICE = price,
		ITEM = v23
	}) .. "</font></p>"
	module.ShowYesOrNoMessage(v24, "SellItem")
end

local function fn5(state, storeItem)
	if storeItem:IsPackage() then
		local totalBundledItemQuantity, componentStoreItem = module5.GetTotalBundledItemQuantity(storeItem:__wf_atom_72915748())

		if totalBundledItemQuantity > 0 and not __wf_atom_7e8ad928(componentStoreItem) then
			state.ComponentStoreItem = componentStoreItem
			state.Count = module4.GetNumOwned(gGameData, v9, componentStoreItem, purchasedItems)
			state.Owned = state.Count > 0 and not module4.CanPurchaseIfAlreadyOwned(componentStoreItem)
			state.ShowCount = state.Count > 0
		else
			state.Count = module4.GetNumOwned(gGameData, v9, storeItem, purchasedItems)
			state.Owned = state.Count > 0
			state.ShowCount = false
		end
	else
		state.Count = module4.GetNumOwned(gGameData, v9, storeItem, purchasedItems)

		if storeItem:IsA(__wf_atom_654b40cd) then
			state.Owned = true
			state.ShowCount = true
			local __wf_atom_987be644 = storeItem:__wf_atom_987be644()
			local __wf_atom_dae75ebc = __wf_atom_c67f9605:__wf_atom_dae75ebc(__wf_atom_987be644)
			local __wf_atom_21e5b95f = v9:__wf_atom_21e5b95f(__wf_atom_987be644)
			local v22

			if state.PurchaseQuantity then
				v22 = state.PurchaseQuantity
			else
				v22 = storeItem:__wf_atom_17d97bf6()
			end

			if __wf_atom_dae75ebc - __wf_atom_21e5b95f < v22 then
				state.PurchaseBlockedMessage = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Labels/BuyItem_BinCapacityReached",
					false,
					{
						MAX = module.FormatNumber(__wf_atom_dae75ebc) + __wf_atom_c67f9605:__wf_atom_121506d6(__wf_atom_987be644)
					}
				)
			end
		else
			state.Owned = state.Count > 0
			state.ShowCount = state.Owned
		end
	end
end

function OnBuyItem(p)
	if _T.BuyElementResult ~= nil then
		buyElementResult = _T.BuyElementResult
		_T.BuyElementResult = nil
	end

	if p ~= nil and not __wf_atom_7e8ad928(mMovie) and p then
		fn("Purchase")
		module.PlaySound(purchaseConfirmSound)
		fn2()
		InitializeSellItems()

		if infoPopup_Grid == nil then
			return
		end

		module3.ShowThankYouPopup(
			mMovie,
			thankYouPopupIcon,
			buyElementResult.Icon,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ThankYouPopupTitle", false),
			mBurstFx
		)

		for _, mElement in infoPopup_Grid.mElements do
			if mElement == nil then
				continue
			end

			fn5(mElement, mElement.StoreItem)
			infoPopup_Grid.ITEM_UTIL.Update(mMovie, mElement.mClipName, mElement, infoPopup_Grid)
		end
	end

	buyElementResult = nil
end

local function fn6(data)
	if data == nil or __wf_atom_7e8ad928(data.StoreItem) or __wf_atom_7e8ad928(v4) or buyElementResult ~= nil then
		return
	end

	buyElementResult = data
	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 0
	purchaseParams.mSourceId = v4:__wf_atom_5b41f63b()
	purchaseParams.mStoreItem = data.StoreItem
	purchaseParams.mQuantity = 1

	if data.Seed then
		purchaseParams.mSeed = data.Seed
	end

	_T.purchasedItems = purchasedItems
	_T.DoPurchase(purchaseParams, OnBuyItem)
end

local function fn7()
	if _T.ShowCurrencyBar == nil then
		return
	end

	_T.ShowCurrencyBar({ mMovie = mMovie })
end

local function fn8(data, data2)
	if data.FeaturedSort ~= data2.FeaturedSort then
		return data.FeaturedSort < data2.FeaturedSort
	end

	local isNew = data.IsNew or false
	local isNew2 = data2.IsNew or false

	if isNew and not isNew2 then
		return true
	end

	if not isNew and isNew2 then
		return false
	end

	if data.SortPriority ~= data2.SortPriority then
		return data.SortPriority > data2.SortPriority
	end

	if data.SortCategory == data2.SortCategory then
		if data.SortAmount ~= nil and data2.SortAmount ~= nil and data.SortAmount ~= data2.SortAmount then
			return data.SortAmount < data2.SortAmount
		end

		if data.SortName ~= data2.SortName then
			return data.SortName < data2.SortName
		end

		local prices = data.Prices
		local prices2 = data2.Prices

		if prices ~= nil and prices2 ~= nil then
			for _, v22 in ipairs({ "External", "Premium", "Credits" }) do
				if prices.FinalPrice[v22] ~= prices2.FinalPrice[v22] then
					return prices.FinalPrice[v22] < prices2.FinalPrice[v22]
				end
			end
		end

		return false
	elseif data.SortCategory == nil or data2.SortCategory == nil then
		return data.SortCategory == nil
	else
		return data.SortCategory < data2.SortCategory
	end
end

local function fn9(state)
	if not (state.RawItem or __wf_atom_7e8ad928(state.Type)) then
		state.Seed = Engine.__wf_atom_774cdec4(timeSeedInterval)
		local predictedItemInfo = SF.PredictedItemInfo()
		predictedItemInfo.mItemType = state.Type
		local v22 = __wf_atom_6cd5fc52(state.Type:__wf_atom_5b41f63b())
		SF.__wf_atom_fe43a67d(predictedItemInfo, 5, __wf_atom_68cc0038(v22, state.Seed))
		state.RawItem = {
			mQuality = predictedItemInfo.mQuality,
			mAspectType = predictedItemInfo.mAspectType,
			mAspectFingerprint = predictedItemInfo.mAspectFingerprint
		}
	end
end

local function fn10(list, p)
	local __wf_atom_97d575cf = v8:__wf_atom_97d575cf(p)
	local v22

	if not __wf_atom_7e8ad928(__wf_atom_97d575cf) then
		v22 = __wf_atom_97d575cf:__wf_atom_bb8450ca()
	end

	for _, itemInfo in ipairs(list) do
		if __wf_atom_7e8ad928(itemInfo) or v22 == itemInfo.mItemId then
			continue
		end

		local __wf_atom_232fd31d = v4:__wf_atom_232fd31d(itemInfo.mItemType)
		local storeItemInfo = module5.GetStoreItemInfo(
			mMovie,
			__wf_atom_232fd31d,
			{ ItemInfo = itemInfo },
			nil,
			nil,
			true
		)

		if not (storeItemInfo ~= nil and storeItemInfo.SellingPrice ~= nil and storeItemInfo.SellingPrice > 0) then
			continue
		end

		storeItemInfo.ItemInfo = tostring(itemInfo.mItemId)
		storeItemInfo.Item = itemInfo
		table.insert(storeItemInfos, storeItemInfo)
	end
end

function InitializeSellItems()
	storeItemInfos = {}

	if __wf_atom_7e8ad928(v9) then
		return
	end

	fn10(v9:__wf_atom_4259c789(), 5)
	fn10(v9:__wf_atom_4f67b86c(), 1)
	fn10(v9:__wf_atom_ebdc4e6e(), 3)
end

local function fn11()
	mMovie:__wf_atom_c90af43a("Title.Icon", titleIcon)
	mMovie:__wf_atom_50d60589("Title.Text", 36, "Placeholder Text")
	mMovie:__wf_atom_e57658c2("Title.Text", 44, _G.UIColor_Yellow)
end

local function fn12(p, _)
	__wf_atom_86cbd68d(mMovie, p .. ".Icon.duplicateMovieClip", "PackTopperBurst", 1000)
	mMovie:__wf_atom_4c1c1986(p, "PackTopperBurst", 1, -360)
	mMovie:__wf_atom_4c1c1986(p, "PackTopperBurst", 14, 100)
	mMovie:__wf_atom_4c1c1986(p, "PackTopperBurst", 15, 100)
	mMovie:__wf_atom_4c1c1986(p, "PackTopperBurst", 12, 0)
	__wf_atom_86cbd68d(mMovie, p .. ".Icon.duplicateMovieClip", "PackTopper", 1001)
	mMovie:__wf_atom_4c1c1986(p, "PackTopper", 1, -360)
	mMovie:__wf_atom_4c1c1986(p, "PackTopper", 14, 128)
	mMovie:__wf_atom_4c1c1986(p, "PackTopper", 15, 128)
	__wf_atom_86cbd68d(mMovie, p .. ".Icon.duplicateMovieClip", "GripTopper", 1002)
	mMovie:__wf_atom_4c1c1986(p, "GripTopper", 1, 278)
	mMovie:__wf_atom_4c1c1986(p, "GripTopper", 14, 80)
	mMovie:__wf_atom_4c1c1986(p, "GripTopper", 15, 80)
	mMovie:__wf_atom_7f57ab2f(p, "GripTopper", 13, false)
end

local function fn13(state)
	local mClipName = state.mClipName
	mMovie:__wf_atom_c90af43a(mClipName .. ".PackTopperBurst", foundersPackBurstIcon)
	mMovie:__wf_atom_7f57ab2f(mClipName, "PackTopperBurst", 13, not __wf_atom_7e8ad928(state.TopperIcon))
	mMovie:__wf_atom_c90af43a(mClipName .. ".PackTopper", state.TopperIcon)
	mMovie:__wf_atom_7f57ab2f(mClipName, "PackTopper", 13, not __wf_atom_7e8ad928(state.TopperIcon))

	if
		v17 == 1
		and state.Type ~= nil
		and state.Type:IsA(__wf_atom_2dc5c74e)
		and not state.Type:IsA(__wf_atom_d98e64fe)
	then
		state.AnimateBg = false
		mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
		mMovie:__wf_atom_c90af43a(mClipName .. ".IconBg", weaponBackerLines)
		local v22 = mClipName .. ".IconFlare"
		mMovie:__wf_atom_c90af43a(v22, weaponIconFlare)
		mMovie:OverrideMaterial(v22, mRankUpBgMaterial)
		mMovie:__wf_atom_e57658c2(v22, 14, 600)
		mMovie:__wf_atom_e57658c2(v22, 15, 600)
		asyncLoader:LoadResource(mClipName, state.Type, function(p)
			local v23 = Resource(p)
			local v24 = Resource(v23:__wf_atom_c45b4ac3())
			local grip, backer

			if not __wf_atom_7e8ad928(v24) then
				local name = v24:GetName()
				backer = v2[name].Backer
				grip = v2[name].Grip
			end

			mMovie:__wf_atom_c90af43a(mClipName .. ".GripTopper", grip)
			mMovie:__wf_atom_7f57ab2f(mClipName, "GripTopper", 13, true)
			mMovie:__wf_atom_4c1c1986(mClipName, "IconBg", 12, 100)
			mMovie:__wf_atom_c90af43a(mClipName .. ".IconBgSecondary", backer)
			mMovie:OverrideMaterial(mClipName .. ".IconBgSecondary", nil)

			if not __wf_atom_7e8ad928(v23) and v23:__wf_atom_0395f752() ~= 5 then
				state.SubString = "(" .. Localize("/SF/Language/Categories/SecondaryWeapon", true) .. ")"
			end

			state.UseWhiteBg = true
			module9.Update(mMovie, mClipName, state, infoPopup_Grid)
			mMovie:__wf_atom_7f57ab2f(mClipName, "IconBgSecondary", 13, true)
			mMovie:__wf_atom_4c1c1986(mClipName, "IconBgSecondary", 12, 100)
			__wf_atom_ec43d06e(mMovie, mClipName, 8, { 12 }, { 100 }, 0.2)
		end)
	else
		mMovie:__wf_atom_e57658c2(mClipName, 12, 100)
		mMovie:__wf_atom_c90af43a(mClipName .. ".IconBg", nil)
		mMovie:__wf_atom_7f57ab2f(mClipName, "IconBgSecondary", 13, false)
	end
end

local function fn14(infoPopup_Data)
	local mSelectedStateId = infoPopup_Grid.mStateMenu.mSelectedStateId

	if v19 ~= nil then
		v19()
		v19 = nil
	end

	if v20 ~= nil then
		v20()
		v20 = nil
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local weaponElementUpgradesAndFingerprints, v22 = module7.GetWeaponElementUpgradesAndFingerprints(infoPopup_Data)
		local v23 = __wf_atom_7e8ad928(infoPopup_Data.RawItem) and 0 or infoPopup_Data.RawItem.mQuality
		local mCreator

		if not __wf_atom_7e8ad928(infoPopup_Data.RawItem) then
			mCreator = infoPopup_Data.RawItem.mCreator
		end

		if infoPopup_Data.RawItem then
			local _mItemId = infoPopup_Data.RawItem.mItemId
		end

		local proxyWeapon, v24 = module7.CreateProxyWeapon(
			__wf_atom_c4f78a8f,
			infoPopup_Data.Type,
			infoPopup_Data.Xp,
			weaponElementUpgradesAndFingerprints,
			v22,
			v23,
			nil,
			infoPopup_Data.mShiny,
			mCreator
		)
		v19 = v24
		infoPopup_Data.StatWeapon = proxyWeapon
		infoPopup_Data.StatOwner = __wf_atom_c4f78a8f
		infoPopup_Data.SuppressLevel = mSelectedStateId == 1
		local v25 = nil
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		local flag2 = false

		if not (__wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_7e8ad928(proxyWeapon)) then
			local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27((proxyWeapon:__wf_atom_0395f752()))
			local __wf_atom_259e7653 = __wf_atom_d2b2176d:__wf_atom_259e7653(true)
			local __wf_atom_c132f79b = __wf_atom_259e7653:__wf_atom_c132f79b(
				0,
				__wf_atom_259e7653:__wf_atom_d25917b6(0)
			)

			if infoPopup_Data.Type:IsA(__wf_atom_abf506db) then
				if WeakResource("/SF/Souls/Sparrow/SparrowSoul") == infoPopup_Data.StoreItem:__wf_atom_7c09e378() then
					if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()) or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa())) or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()):__wf_atom_d78fd481(2))) then
						local __wf_atom_1eafa462 = gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa())
						v25 = gGameRules:__wf_atom_1eafa462(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa()):__wf_atom_d78fd481(2)
						__wf_atom_28224c27 = __wf_atom_1eafa462:__wf_atom_035fdfa8(2)
						flag2 = true
					end
				else
					local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
					local __wf_atom_eb82ab1f = v9:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
					local __wf_atom_43869974 = proxyWeapon:__wf_atom_43869974()

					for i = 0, 8 - 1 do
						if __wf_atom_43869974[1] ~= i then
							continue
						end

						local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(i)

						if __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
							continue
						end

						v25 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(i)
						infoPopup_Data.StatCompareWeapon = nil
						__wf_atom_28224c27 = __wf_atom_035fdfa8
					end

					flag2 = true
				end
			end

			infoPopup_Data.StatCompareWeapon = __wf_atom_28224c27

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
				local compareItemInfo, v26

				if flag2 then
					compareItemInfo = module5.GetItemTypeWithStoreInfo(mMovie, v25.mItemType, v4)
					local weaponElementUpgradesAndFingerprints2, v27 = module7.GetWeaponElementUpgradesAndFingerprints(compareItemInfo)
					local v28 = __wf_atom_7e8ad928(compareItemInfo.RawItem) and 0 or compareItemInfo.RawItem.mQuality

					if compareItemInfo.RawItem then
						local _mItemId = compareItemInfo.RawItem.mItemId
					end

					local v29
					v26, v29 = module7.CreateProxyWeapon(
						__wf_atom_c4f78a8f,
						compareItemInfo.Type,
						compareItemInfo.Xp,
						weaponElementUpgradesAndFingerprints2,
						v27,
						v28,
						nil,
						compareItemInfo.mShiny,
						nil
					)
					v20 = v29
					infoPopup_Data.StatCompareWeapon = v26
				else
					compareItemInfo = module5.GetItemTypeWithStoreInfo(
						mMovie,
						__wf_atom_28224c27:__wf_atom_1bb5b1ff(),
						v4
					)
					local weaponElementUpgradesAndFingerprints2, v27 = module7.GetWeaponElementUpgradesAndFingerprints(compareItemInfo)
					local v28

					if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
						v28 = __wf_atom_28224c27:__wf_atom_966277ef()
					end

					local v29

					if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
						v29 = __wf_atom_28224c27:__wf_atom_b2875ac0()
					end

					local v30

					if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
						v30 = __wf_atom_28224c27:__wf_atom_9422b5f5()
					end

					local v31

					if __wf_atom_28224c27 then
						v31 = __wf_atom_28224c27:__wf_atom_204490cb()
					end

					local v32
					v26, v32 = module7.CreateProxyWeapon(
						__wf_atom_c4f78a8f,
						compareItemInfo.Type,
						0,
						weaponElementUpgradesAndFingerprints2,
						v27,
						v28,
						v31,
						v30,
						v29
					)
					v20 = v32
					infoPopup_Data.StatCompareWeapon = v26
				end

				if compareItemInfo then
					compareItemInfo.StatWeapon = v26
					compareItemInfo.StatOwner = __wf_atom_c4f78a8f
					compareItemInfo.StatCompareWeapon = proxyWeapon
					compareItemInfo.SuppressLevel = true
					compareItemInfo.MetaData = not compareItemInfo.MetaData and {} or compareItemInfo.MetaData
					compareItemInfo.MetaData.HidePrice = true
					compareItemInfo.MetaData.HideFragments = true
					compareItemInfo.PurchaseContext = mSelectedStateId == 1
					infoPopup_Data.CompareItemInfo = compareItemInfo
				end
			end
		end
	end

	infoPopup_Data.PurchaseContext = mSelectedStateId == 1

	if not infoPopup_Data.PurchaseContext then
		infoPopup_Data.StatCompareWeapon = nil
	end

	infoPopup_Data.MetaData = not infoPopup_Data.MetaData and {} or infoPopup_Data.MetaData
	infoPopup_Data.MetaData.HidePrice = mSelectedStateId == 2
	infoPopup_Data.MetaData.HideFragments = mSelectedStateId == 2
	_T.InfoPopup_Data = infoPopup_Data
	_T.InfoPopup_Grid = infoPopup_Grid
end

local function fn15(infoPopup_Data)
	element = infoPopup_Data
	local mClipName = infoPopup_Data.mClipName
	module3.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 2),
		mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 3) + 7,
		mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 14) - 4,
		mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 15)
	)

	if __wf_atom_7e8ad928(gRegion) then
		fn14(infoPopup_Data)
	else
		local kind = nil

		if infoPopup_Data.Item == nil then
			if infoPopup_Data.Type == nil then
				fn14(infoPopup_Data)
			else
				kind = infoPopup_Data.Type
			end
		else
			kind = infoPopup_Data.Item.mItemType
		end

		if kind ~= nil then
			asyncLoader:LoadResource("Tooltip", kind, function()
				if v19 ~= nil then
					v19()
					v19 = nil
				end

				if v20 ~= nil then
					v20()
					v20 = nil
				end

				fn14(infoPopup_Data)
			end)
		end
	end

	if mClipName ~= nil then
		__wf_atom_ec43d06e(mMovie, mClipName .. ".PackTopperBurst", 8, { 12, 14, 15, 1 }, {
			100,
			300,
			300,
			-380
		}, 0.2)
		__wf_atom_ec43d06e(mMovie, mClipName .. ".PackTopper", 8, { 1 }, { -380 }, 0.2)
	end

	if infoPopup_Data.AdditionalData ~= nil then
		local hoverTransmissionTag = infoPopup_Data.AdditionalData.HoverTransmissionTag
		local flag2 = true

		if module6.TransmissionPlaying() then
			local curTransmission = module6.GetCurTransmission()
			local flag3 = true

			if _T.marketVendorTransmissionSet ~= nil then
				for _, v22 in pairs(v14) do
					if curTransmission ~= _T.marketVendorTransmissionSet:__wf_atom_b4a422ed(Symbol(v22.BuyTransmissionTag)) then
						continue
					end

					flag3 = false
					flag2 = false
					break
				end
			end

			if flag3 then
				module6.CloseTransmissions()
			end
		end

		if flag2 then
			v15 = hoverTransmissionTag
			v16 = 0.1
		end
	end
end

local function fn16(p)
	if v19 ~= nil then
		v19()
		v19 = nil
	end

	if v20 ~= nil then
		v20()
		v20 = nil
	end

	element = nil
	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil

	if p == nil then
		return
	end

	local mClipName = p.mClipName

	if mClipName == nil then
		return
	end

	__wf_atom_ec43d06e(mMovie, mClipName .. ".PackTopperBurst", 8, { 12, 14, 15, 1 }, {
		0,
		100,
		100,
		-380
	}, 0.2)
	__wf_atom_ec43d06e(mMovie, mClipName .. ".PackTopper", 8, { 1 }, { -360 }, 0.2)
end

local function fn17(data)
	local storeItem = data.StoreItem

	if __wf_atom_7e8ad928(storeItem) then
		return
	end

	if infoPopup_Grid.mStateMenu.mSelectedStateId ~= 1 then
		fn4(data)
		return
	end

	local productId = data.ProductId
	local storeItemPriceObject = module4.GetStoreItemPriceObject(storeItem, nil, purchasedItems)

	if productId == nil or not (storeItemPriceObject.ExternalProduct and storeItemPriceObject.ShowInMarket) then
		if not module4.CanPurchaseIfAlreadyOwned(data.ComponentStoreItem or storeItem) and data.Owned then
			module.ShowMessage("/SF/Language/Crafting/Foundry_DuplicateNotAllowed")
		elseif data.PurchaseBlockedMessage == nil then
			fn6(data)
		else
			module.ShowMessage(data.PurchaseBlockedMessage)
		end
	elseif data.Owned then
		module.ShowMessage("/SF/Language/Crafting/Foundry_DuplicateNotAllowed")
	else
		local storeItemUrl = module5.GetStoreItemUrl(storeItem)

		if storeItemUrl then
			module.DoOpenWebBrowser(storeItemUrl)
		end
	end
end

local function fn18()
	if infoPopup_Grid == nil then
		return
	end

	local activeCategory = infoPopup_Grid.mCategoryMenu:GetActiveCategory()
	local isTallGrid

	if activeCategory == nil then
		isTallGrid = false
	elseif activeCategory.SubCategory == "founders" then
		isTallGrid = true
	elseif activeCategory.ItemType == 5 then
		isTallGrid = infoPopup_Grid.mStateMenu.mSelectedStateId == 1
	else
		isTallGrid = false
	end

	local mColumns = infoPopup_Grid.mStateMenu.mSelectedStateId ~= 1 and 7 or isTallGrid and 4 or 5
	infoPopup_Grid.mColumns = mColumns
	infoPopup_Grid.mColumnSeparation = (infoPopup_Grid.mWidth + infoPopup_Grid.mPadding) / mColumns
	local v22 = infoPopup_Grid
	local mRowSeparation

	if isTallGrid then
		mRowSeparation = infoPopup_Grid.mColumnSeparation * 2 - infoPopup_Grid.mPadding
	else
		mRowSeparation = infoPopup_Grid.mColumnSeparation
	end

	v22.mRowSeparation = mRowSeparation
	infoPopup_Grid.IsTallGrid = isTallGrid
	infoPopup_Grid.mOriginalButtonHeight = infoPopup_Grid.mRowSeparation
	infoPopup_Grid.mInitialX = infoPopup_Grid.mColumnSeparation / 2
	infoPopup_Grid.mInitialY = infoPopup_Grid.mRowSeparation / 2
end

local function fn19(p)
	infoPopup_Grid:RemoveElements(true, true)
	v17 = p

	if p == 1 then
		for _, v22 in v7 do
			infoPopup_Grid:AddElement(v22, true)
		end
	else
		for _, v22 in storeItemInfos do
			infoPopup_Grid:AddElement(v22, true)
		end
	end

	infoPopup_Grid.mScrollAlwaysVisible = false
	infoPopup_Grid.mBackerVisible = false
	infoPopup_Grid.mAlignment = module.LEFT_ALIGNED
	infoPopup_Grid.mDefaultWidth = 1686
	infoPopup_Grid.mWidth = infoPopup_Grid.mDefaultWidth
	infoPopup_Grid:UpdateHeight(nil, true)
	fn3()
end

local function fn20()
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.2)
	local module10 = require("EE.Interface.Components.ItemGrid")
	infoPopup_Grid = module10.Create(getfenv(1), "ListAnchor.ListContainer", {
		mClipCreatedCallback = fn12,
		mElementDrawCallback = fn13,
		mOnFocusedCallback = fn15,
		mOnUnfocusedCallback = fn16,
		mOnSelectedCallback = fn17,
		mCategoryChangedCallback = fn18,
		mStateChangedCallback = fn19,
		PurchasedItems = purchasedItems,
		mVisRangeMaterials = {
			SaleInfoBacker = saleBackerMaterial,
			PriceInfoBacker = priceBackerMaterial,
			SaleInfoDivider = saleUnderlineMaterial
		},
		mAddFillerElements = false
	})
	infoPopup_Grid.Store_SetTitle = infoPopup_Grid.SetTitle

	function infoPopup_Grid.SetTitle(object, p)
		mMovie:__wf_atom_50d60589("Title.Text", 36, mMovie:__wf_atom_8e9ac384(p, false))
		object:Store_SetTitle("")
		mMovie:__wf_atom_2dedec1a("Title", 13, true)
	end

	local INVENTORY_CATEGORIES = module2.INVENTORY_CATEGORIES
	local categories = {
		{
			ItemType = 9,
			SubCategory = "founders",
			Name = "/SF/Language/Vendor/Market_FoundersPacks"
		}
	}

	for i = 1, #v13 do
		local v22 = i
		table.insert(categories, {
			Name = v13[i].mName,
			IconIndex = tonumber(v13[i].mIcon),
			AdditionalFilterFunction = function(p)
				for j = 1, #v13[v22].Items do
					if
						p.StoreItem ~= nil
						and v13[v22].Items[j].StoreItem ~= nil
						and p.StoreItem == v13[v22].Items[j].StoreItem
					then
						return true
					end
				end

				return false
			end
		})
	end

	table.insert(categories, {
		ItemType = 9,
		Name = "/SF/Language/Categories/Bundles",
		AdditionalFilterFunction = function(_)
			return true
		end
	})

	for i = 2, #INVENTORY_CATEGORIES do
		table.insert(categories, INVENTORY_CATEGORIES[i])
	end

	table.insert(categories, { ItemType = 19, Name = "/SF/Language/Categories/Slots" })
	infoPopup_Grid:SetStates({
		{ Name = "/SF/Language/Vendor/BuyItem", Categories = categories },
		{ Name = "/SF/Language/Vendor/SellItem", Categories = INVENTORY_CATEGORIES }
	})
	mMovie:__wf_atom_e57658c2(
		"Title",
		0,
		mMovie:__wf_atom_5e6e15c8("ListAnchor.ListContainer.Offset", 2) + (1686 + infoPopup_Grid.mPadding) / 2
	)
end

local function fn21(p)
	p.FeaturedSort = 1000

	for i = 1, #v13 do
		for j = 1, #v13[i].Items do
			if not (p.StoreItem ~= nil and v13[i].Items[j].StoreItem ~= nil and p.StoreItem == v13[i].Items[j].StoreItem) then
				continue
			end

			p.FeaturedSort = i * 100 + j
		end
	end
end

local function fn22()
	v14["/SF/Types/StoreItems/Packages/CourageousFounderStoreItem"] = {
		HoverTransmissionTag = "HoverTethren",
		BuyTransmissionTag = "BuyTethren"
	}
	v14["/SF/Types/StoreItems/Packages/SpiritedFounderStoreItem"] = {
		HoverTransmissionTag = "HoverOscelda",
		BuyTransmissionTag = "BuyOscelda"
	}
	v14["/SF/Types/StoreItems/Packages/GracefulFounderStoreItem"] = {
		HoverTransmissionTag = "HoverSirin",
		BuyTransmissionTag = "BuySirin"
	}
	v14["/SF/Types/StoreItems/Packages/ParagonFounderStoreItem"] = {
		HoverTransmissionTag = "HoverParagon",
		BuyTransmissionTag = "BuyParagon"
	}
	local v22 = nil
	local v23 = {}
	v13 = module5.GetLandingPageCategories(mMovie, v4, v9, purchasedItems, gGameData, nil, nil, false)
	local storeItems = v4:GetStoreItems()
	local v24 = {}
	local v25 = {}
	local v26 = {}

	for _, storeItem in storeItems do
		local storeItemPriceObject = module4.GetStoreItemPriceObject(storeItem, nil, purchasedItems)

		if not storeItemPriceObject.ShowInMarket then
			continue
		end

		local v27 = false
		local item = storeItem:GetItem()

		if not (storeItem:IsPackage() or __wf_atom_7e8ad928(item)) then
			for _, className in v5 do
				if not item:IsA(className) then
					continue
				end

				v27 = true
				break
			end
		end

		if v27 then
			continue
		end

		v22 = nil
		local productId = module4.GetProductId(storeItem)

		if storeItemPriceObject.ExternalProduct and storeItemPriceObject.ShowInMarket then
			v22 = module5.GetStoreItemInfo(mMovie, storeItem)

			if v22 ~= nil then
				v22.ProductId = productId
				v22.IsExternalProduct = true
				v22.SortPriority = storeItem:__wf_atom_2941433a()
				v22.Prices = storeItemPriceObject
				fn21(v22)

				if module4.IsFoundersPack(storeItem) then
					v22.IconOverlay = foundersPackShadowIcon
					v22.Owned = module4.IsFoundersPackOwned(productId)
					v22.CanPurchase = not v22.Owned
					v22.TopperIcon = v22.Icon
					v22.Icon = storeItem:__wf_atom_2bdbd42f()
					local extraItems

					if tonumber(productId) == 8 then
						extraItems = paragonFoundersExtraItems
					else
						extraItems = baseFoundersExtraItems
					end

					v22.ExtraItems = extraItems
					v22.AdditionalData = v14[v22.StoreItem:__wf_atom_5b41f63b()]
					table.insert(v23, v22.Icon)
					table.insert(v7, v22)
				else
					v22.IconOverlay = squareShadowIcon
					v22.Owned = gGameData:__wf_atom_a1deff4d(productId)
						and not module4.CanPurchaseIfAlreadyOwned(storeItem)
					v22.CanPurchase = not gGameData:__wf_atom_a1deff4d(productId)
						or module4.CanPurchaseIfAlreadyOwned(storeItem)

					if storeItem:IsPackage() then
						local __wf_atom_b982d1aa = storeItem:__wf_atom_b982d1aa()

						if __wf_atom_b982d1aa > 0 then
							v22.SortAmount = __wf_atom_b982d1aa
						end
					end

					table.insert(v7, v22)
				end
			end
		elseif storeItemPriceObject.ShowInMarket then
			v22 = module5.GetStoreItemInfo(mMovie, storeItem)

			if v22 ~= nil then
				fn9(v22)
				local v28 = (v22.Type == nil or not v22.Type:IsA(__wf_atom_2dc5c74e) or v22.Type:IsA(__wf_atom_d98e64fe))
					and true
					or false
				v22.IconOverlay = squareShadowIcon
				v22.SortPriority = storeItem:__wf_atom_2941433a()
				v22.Prices = storeItemPriceObject
				fn21(v22)
				v22.PurchaseQuantity = storeItem:__wf_atom_17d97bf6()

				if storeItem:IsA(__wf_atom_654b40cd) and storeItemPriceObject.ProratedPercent > 0 then
					v22.PurchaseQuantity = math.round(v22.PurchaseQuantity * (1 - storeItemPriceObject.ProratedPercent / 100))
				end

				fn5(v22, storeItem)
				v22.CanPurchase = v22.Count == 0 or module4.CanPurchaseIfAlreadyOwned(storeItem)
				local __wf_atom_2bdbd42f = storeItem:__wf_atom_2bdbd42f()

				if not __wf_atom_7e8ad928(__wf_atom_2bdbd42f) then
					v22.Icon = __wf_atom_2bdbd42f
					table.insert(v23, __wf_atom_2bdbd42f)
				end

				if v28 then
					table.insert(v7, v22)
				elseif
					v22.Type:IsA(WeakResource("/SF/Weapons/Melee/OneHandMeleeWeapon"))
					or v22.Type:IsA(WeakResource("/SF/Weapons/Melee/TwoHandMeleeWeapon"))
				then
					table.insert(v24, v22)
				elseif v22.Type:IsA(WeakResource("/SF/Types/Game/SFCasterMeleeWeapon")) then
					table.insert(v25, v22)
				elseif v22.Type:IsA(WeakResource("/SF/Types/Game/SFRangedMeleeWeapon")) then
					table.insert(v26, v22)
				end
			end
		end

		if v22 == nil then
			continue
		end

		v22.LongDesc = mMovie:__wf_atom_8e9ac384(tostring(storeItem:__wf_atom_a6334b47()), true)
		v22.SortName = string.gsub(v22.Name, "%d+", function(p)
			v22.SortAmount = tonumber(p)
			return ""
		end)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
			true
		)

		if v22.StoreItem ~= nil and #v22.StoreItem:__wf_atom_72915748() ~= 0 then
			v22.SubtitleOverride = __wf_atom_8e9ac384 .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Vendor/Details",
				true
			)
			v22.SubtitleOverride = "<p><font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">" .. v22.SubtitleOverride .. "</font></p>"
		end

		local flag2 = false

		if v22.IsNew then
			flag2 = true
		else
			for _, v28 in storeItem:__wf_atom_72915748() do
				if __wf_atom_7e8ad928(v28.mTypeName) or not module5.GetStoreItemInfo(mMovie, v28.mTypeName).IsNew then
					continue
				end

				flag2 = true
				break
			end
		end

		if not flag2 then
			continue
		end

		v22.IsNew = true
		v22.SecondaryStatusIcon = newIcon
		v22.SecondaryStatusIconShadow = newIconBacker
	end

	__wf_atom_01bfe5c4(Engine.__wf_atom_774cdec4(timeSeedInterval))
	local seededShuffleTable = module.SeededShuffleTable(v25)
	local seededShuffleTable2 = module.SeededShuffleTable(v26)
	local seededShuffleTable3 = module.SeededShuffleTable(v24)

	local function fn23(list, p)
		for i = 1, math.min(p, #list) do
			list[i].SquareIcon = true
			table.insert(v7, list[i])
		end
	end

	fn23(seededShuffleTable, casterCountToShow)
	fn23(seededShuffleTable2, bowCountToShow)
	fn23(seededShuffleTable3, meleeCountToShow)
	table.sort(v7, fn8)

	if #v23 > 0 then
		asyncLoader:LoadMultipleResources("FeaturedTextures", v23, function(_)
			for _, v27 in v7 do
				v27.Icon = Resource(v27.Icon)
			end

			fn20()
		end, true)
	else
		fn20()
	end
end

local function fn23()
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
	local module10 = require("Lotus.Interface.Libs.TimerMgr")
	v21 = module10.CreateTimerMgr()

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(true)
	end

	module2.RegisterHideHud(true)
	module3.SetChatVisible(false)
	v6 = module8.Create(mMovie)
	v6:Register(mMovie, "ThankYouPopup", { v6.ANCHOR_V_CENTRE, v6.ANCHOR_H_CENTRE })

	if _T.ShowBackground ~= nil then
		_T.ShowBackground()
	end

	if not __wf_atom_7e8ad928(camelVendorMusicLoop) and __wf_atom_7e8ad928(v3) then
		v3 = module.PlaySound(camelVendorMusicLoop)
	end

	if not __wf_atom_7e8ad928(openSound) then
		module.PlaySound(openSound)
	end

	if _T.marketVendorTransmissionSet ~= nil then
		asyncLoader:LoadMultipleResources(
			"Transmissions",
			_T.marketVendorTransmissionSet:__wf_atom_d0c8d09f(),
			function(_) end
		)
	end

	for k, v22 in v do
		v2[v22] = {}
		v2[v22].Backer = weaponBackers[k]
		v2[v22].Grip = weaponGrips[k]
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	fn2()
	fn11()
	fn7()
	InitializeSellItems()
	fn22()
	fn23()
	fn("Greetings")
	onViewportSizeChanged()
end

function Shutdown()
	if _T.HideBackground ~= nil then
		_T.HideBackground()
	end

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	if v19 ~= nil then
		v19()
		v19 = nil
	end

	if v20 ~= nil then
		v20()
		v20 = nil
	end

	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil

	if not __wf_atom_7e8ad928(gRegion) then
		module6.EmptyTransmissionQueue({ gRegion:__wf_atom_c4f78a8f() })
	end

	module6.CloseTransmissions()
	fn("Goodbye")
	_T.marketVendorTransmissionSet = nil

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end

	if v12 then
		ShowItemTicker(false)
	end

	module2.RegisterHideHud(false)
	module3.SetChatVisible(true)
	_T.StorePreviewData = nil
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	asyncLoader:Update()
	local v22 = __wf_atom_084b3e93()

	if not __wf_atom_7e8ad928(v21) then
		v21:Update(v22)
	end

	if v16 <= 0 then
		if #v15 > 0 then
			fn(v15)
			v15 = nil
		end
	else
		v16 -= __wf_atom_fa1258d0()
	end
end

function onKeyDown_MENU_CANCEL()
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(v18) then
		v18:Execute("AdvanceAndShutdown", "")
		return
	end

	if _T.StorePreviewData ~= nil then
		return
	end

	mMovie:Close()

	if not __wf_atom_7e8ad928(v3) then
		v3:Stop(false)
	end

	if not __wf_atom_7e8ad928(closeSound) then
		module.PlaySound(closeSound)
	end
end

function OnExternalProductPurchaseComplete()
	if infoPopup_Grid == nil then
		return
	end

	for _, mElement in ipairs(infoPopup_Grid.mElements) do
		local productId = mElement.ProductId

		if not (#productId > 0) or mElement.Owned or not module4.IsFoundersPackOwned(productId) then
			continue
		end

		mElement.Owned = not module4.CanPurchaseIfAlreadyOwned(mElement.StoreItem)
		mElement.CanPurchase = module4.CanPurchaseIfAlreadyOwned(mElement.StoreItem)

		if mElement.AdditionalData == nil then
			continue
		end

		local buyTransmissionTag = mElement.AdditionalData.BuyTransmissionTag
		module6.CloseTransmissions()
		module6.EmptyTransmissionQueue({ gRegion:__wf_atom_c4f78a8f() })
		fn(buyTransmissionTag)
	end

	fn2()
	infoPopup_Grid:RefreshState()
end

function OnDetailedViewComplete()
	v18 = nil
	infoPopup_Grid:RefreshState()
	_T.StorePreviewData = nil
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.25)
end

function onKeyDown_MENU_RIGHT_CLICK()
	if __wf_atom_7e8ad928(element) then
		return
	end

	if element.StoreItem == nil or #element.StoreItem:__wf_atom_72915748() == 0 then
		return false
	end

	if
		not __wf_atom_7e8ad928(v18)
		or _T.StorePreviewData ~= nil
		or not __wf_atom_7e8ad928(infoPopup_Grid) and infoPopup_Grid:GetActiveStateId() ~= 1
	then
		return
	end

	_T.StorePreviewData = { Element = element }
	_T.InfoPopup_Data = nil
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.25, 0, function()
		v18 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
		v18:Execute("SetExitCallback", "OnDetailedViewComplete")
	end)
	return true
end

function onKeyDown_MENU_GENERIC2()
	onKeyDown_MENU_RIGHT_CLICK()
	return true
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v6) then
		v6:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end

	local screenDimensions, v22 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("ThankYouPopup.Darkener", 15, v22)
end