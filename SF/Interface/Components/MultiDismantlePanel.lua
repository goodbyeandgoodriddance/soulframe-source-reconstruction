module(..., package.seeall)
local module = require("EE.Interface.Utilities")

function Create(object, p, p2, p3, p4, options)
	local module2 = require("EE.Interface.Components.List")
	local newList = module2.CreateNewList(p2, p .. ".DismantleList.DismantleItem")
	newList.mPrefix = "MultiDismantlePanel(" .. p .. ")::"
	newList.mCachedData = {}
	newList.mDismantleValue = 0
	newList.mItemsSelected = 0
	newList.mForcedVerticalSeparation = 30

	function newList:UpdateCustomizationData(options2)
		local v = options2 or {}
		self.currencyString = v.currencyType or ""
		self.confirmDialogTitle = v.confirmDialogTitle or ""
		self.confirmDialogDesc = v.confirmDialogDesc or ""
		self.panelTitle = v.panelTitle or ""
		object:__wf_atom_48bd5a59(p, "Title", 36, object:__wf_atom_8e9ac384(self.panelTitle, true))
	end

	newList.UpdateCustomizationData(newList, options or {})

	function p2.MultiSellConfirmDialogCallback(p5)
		if tonumber(p5) ~= 4 then
			return
		end

		newList.mSellInfo = SF.SellOperation()
		newList.mSellInfo.mSellCurrency = 2
		newList.mSellInfo:__wf_atom_afdfc7fe()
		local total = 0

		for _, v in newList.mCachedData do
			if v.OriginalElement.ItemInfo.mItemId:__wf_atom_b70c3343() then
				newList.mSellInfo:SellItem(
					v.OriginalElement.Category,
					tostring(v.OriginalElement.StoreItemInfo.FullName),
					v.Count
				)
				total += v.Value * v.Count
			elseif __wf_atom_7e8ad928(v.IDList) then
				newList.mSellInfo:SellItem(
					v.OriginalElement.Category,
					tostring(v.OriginalElement.StoreItemInfo.UID),
					v.Count
				)
				total += v.Value * v.Count
			else
				for i = 1, v.Count do
					newList.mSellInfo:SellItem(v.OriginalElement.Category, tostring(v.IDList[i]), 0)
					total += v.Value
				end
			end
		end

		newList.mSellInfo.mSellPrice = total
		newList.mWebCmd = SF.SellCommand(newList.mSellInfo, "MultiSellCompleted")
		newList.mWebCmd:Execute()
	end

	function p2.MultiSellCompleted(_, _)
		newList.mWebCmd = nil
		newList.mSellInfo = nil
		newList:MultiSellClear()

		if newList.OnMultiSellCompleted then
			newList.OnMultiSellCompleted()
		end
	end

	local module3 = require("SF.Interface.Components.Button")
	local v = module3.Create(object, p .. ".Button", "", "Dismantle")
	v:SetVariant(module3.VARIANTS.SPECIAL_BUTTON)
	v:SetAnchor(module.CENTER_ALIGNED)
	v:SetText(object:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MultiSell", true) .. " " .. newList.mDismantleValue .. object:__wf_atom_8e9ac384(newList.currencyString, true))
	v:SetActive(newList.mDismantleValue > 0)
	object:__wf_atom_48bd5a59(
		p,
		"Title",
		36,
		object:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_SelectedForRelease", true)
	)
	object:__wf_atom_4c1c1986(p, "Title", 44, _G.UIColor_Yellow)
	v.mWebCmd = nil
	v.mSellInfo = nil

	function v.mOnPressCompletedCallback(_, p5, _)
		if p5 == false or newList.mDismantleValue <= 0 then
			return
		end

		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(newList.confirmDialogTitle, false)
		dialogSettings.locString = object:__wf_atom_8e9ac384(newList.confirmDialogDesc, false, {
			AMOUNT = newList.mItemsSelected,
			CURRENCY = newList.mDismantleValue
		})
		dialogSettings.titleString = __wf_atom_8e9ac384
		dialogSettings:SetCallback("MultiSellConfirmDialogCallback")
		gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
	end

	function newList.UpdateDismantleState(object2, data)
		local v2 = newList.mCachedData[data.CacheId]

		if v2 then
			if data.Count <= 0 then
				object2:RemoveElementById(v2.Id)
				newList.mCachedData[data.CacheId] = nil
			else
				local elementById = object2:GetElementById(v2.Id)
				elementById.Count = data.Count
				elementById.Value = data.Value
				elementById.OriginalElement = data.OriginalElement
				elementById.IDList = data.IDList
				elementById.Name = data.Name
				elementById.CacheId = data.CacheId
				object2:UpdateElementById(v2.Id, elementById)
				newList.mCachedData[data.CacheId] = elementById
			end
		elseif data.Count > 0 then
			local v3 = object2:AddElement(data)
			object2.mCachedData[data.CacheId] = v3
		end

		newList.mDismantleValue = 0
		newList.mItemsSelected = 0

		for _, v3 in newList.mCachedData do
			newList.mDismantleValue += v3.Value * v3.Count
			newList.mItemsSelected += v3.Count
		end

		v:SetText(object:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MultiSell", true) .. " " .. newList.mDismantleValue .. object:__wf_atom_8e9ac384(newList.currencyString, true))
		v:SetActive(newList.mDismantleValue > 0)
		newList:Redraw()
	end

	function newList.mElementDrawCallback(data)
		local mClipName = data.mClipName
		object:__wf_atom_48bd5a59(mClipName, "ItemName", 36, data.Name)
		object:__wf_atom_4c1c1986(mClipName, "SelectedCount.Text", 11, _G.UIColor_Yellow)
		object:__wf_atom_4c1c1986(mClipName, "SelectedCount.Ring", 11, _G.UIColor_Beige)
		object:__wf_atom_4c1c1986(mClipName, "SelectedCount.Backer", 11, _G.UIColor_DarkBrown)
		object:__wf_atom_48bd5a59(mClipName, "SelectedCount.Text", 36, data.Count)
		object:OverrideMaterial(mClipName .. ".SelectedCount.Text", p4)
		object:OverrideMaterial(mClipName .. ".ItemName", p4)
		object:OverrideMaterial(mClipName .. ".SelectedCount.Ring", p3)
		object:OverrideMaterial(mClipName .. ".SelectedCount.Backer", p3)
	end

	function newList:MultiSellClear()
		newList.mCachedData = {}
		newList.mDismantleValue = 0
		newList.mItemsSelected = 0
		v:SetText(object:__wf_atom_8e9ac384("/SF/Language/Motes/MotesScreen_MultiSell", true) .. " " .. newList.mDismantleValue .. object:__wf_atom_8e9ac384(newList.currencyString, true))
		newList:RemoveElements()
	end

	newList:AttachScrollBar(p .. ".ScrollBar", {
		mVisRangeMaterials = { p3, p4 },
		mHeight = 450,
		mVisRangeFadeSize = 10,
		mContentOffset = 0
	})
	newList:Redraw()
	return newList
end

function OnMultiDismantleCompletedTEST(_, _) end