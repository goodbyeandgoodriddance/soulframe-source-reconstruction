module(..., package.seeall)
local module = require("EE.Interface.Utilities")
require("SF.Interface.Libs.UIUtilities")

function Create(p, p2, options)
	local v = options or {}
	local mMovie = p.mMovie
	local v2 = not mMovie:__wf_atom_253d7085(p2)
	local mScrollAlwaysVisible = v.mScrollAlwaysVisible
	local mScrollAlwaysVisible2 = mScrollAlwaysVisible == nil or mScrollAlwaysVisible
	v.mPadding = v.mPadding or 8
	local v3 = not v.mGrid
	mMovie:__wf_atom_7f57ab2f(p2, "Offset.Grid", 13, not v3)
	mMovie:__wf_atom_7f57ab2f(p2, "Offset.List", 13, v3)

	if v3 then
		local module2 = require("EE.Interface.Components.List")
		v = module2.CreateNewList(p, p2 .. ".Offset.List.Element", v)
		v.mForcedVerticalSeparation = v.mForcedVerticalSeparation or 90
		v.mInitialY = v.mForcedVerticalSeparation / 2
		v.mDefaultWidth = v.mDefaultWidth or mMovie:__wf_atom_cfc41e35(p2, "Offset.List.Element.Btn", 14)

		if v.mContentHeight == nil and v.mVisibleElements ~= nil then
			v.mContentHeight = v.mVisibleElements * v.mForcedVerticalSeparation
		end
	end

	v.mScrollAlwaysVisible = mScrollAlwaysVisible2
	v.mTabsInitialY = v.mTabsInitialY or 36
	v.mUnfilteredElements = {}
	v.mCanSelectItem = v.mCanSelectItem or false

	if v.mVisRangeMaterials == nil then
		v.mVisRangeMaterials = {}
	end

	if not v.mSkipDefaultMaterials then
		v.mVisRangeMaterials.Icon = v.mVisRangeMaterials.Icon or _G.UIMaterial_VerticalVisibilityRange
		v.mVisRangeMaterials.Text = v.mVisRangeMaterials.Text or _G.UIMaterial_VerticalVisibilityRangeText
		v.mVisRangeMaterials.UnfocusedItem = v.mVisRangeMaterials.UnfocusedItem or _G.UIMaterial_BackerBorderSingle
		v.mVisRangeMaterials.FocusedItem = v.mVisRangeMaterials.FocusedItem or _G.UIMaterial_BackerBorderSingle
		v.mVisRangeMaterials.SelectedItem = v.mVisRangeMaterials.SelectedItem or _G.UIMaterial_BackerBorderSingle
	end

	v.ITEM_UTIL = require("SF.Interface.Libs.ListItemUtil")
	v.ItemList_Redraw = v.Redraw

	function v:Redraw(p3, p4, p5)
		local mBackerVisible = self.mBackerVisible ~= false
		mMovie:__wf_atom_4c1c1986(p2, "States", 1, 20)
		mMovie:__wf_atom_4c1c1986(p2, "States", 0, mBackerVisible and 0 or 20)
		mMovie:__wf_atom_7f57ab2f(p2, "Bg", 13, mBackerVisible)

		if self.mCategoryMenu ~= nil then
			mMovie:__wf_atom_4c1c1986(p2, "Categories", 1, v.mTabsInitialY)
			self.mCategoryMenu:SetMasked(mBackerVisible)
		end

		self:ItemList_Redraw(p3, p4, p5)
	end

	v.ItemList_OnDraw = v.OnDraw

	function v.OnDraw(object, p3, p4)
		object:ItemList_OnDraw(p3, p4)
		object.ITEM_UTIL.Update(mMovie, p3.mClipName, p3, v)
		v.UpdateFocused(p3, false)
		mMovie:__wf_atom_4c1c1986(p3.mClipName, "BgMask", 14, mMovie:__wf_atom_5e6e15c8(p2, 14))
		local v4 = mMovie:__wf_atom_cfc41e35(p3.mClipName, "Item", 0) + mMovie:__wf_atom_cfc41e35(p3.mClipName, "Item.IconBg", 14) - 39
		mMovie:__wf_atom_4c1c1986(p3.mClipName, "BgMask", 0, v4)
	end

	v.ItemList_OnClipCreated = v.OnClipCreated

	function v.OnClipCreated(object, p3, p4)
		object:ItemList_OnClipCreated(p3, p4)
		local v4 = p4 == nil and {} or p4
		object.ITEM_UTIL.Initialize(mMovie, p3, v4, v)
	end

	function v:Selectable(data)
		return not (data.Header or data.IsDummy) and data.IsHeld == nil
	end

	v.ItemList_OnFocused = v.OnFocused

	function v:OnFocused(p3)
		if not self:Selectable(p3) then
			return
		end

		self:ItemList_OnFocused(p3)
		self.UpdateFocused(p3, true)

		if __wf_atom_7e8ad928(p3.StatusIconTooltip) then
			_T.gToolTip = nil
		else
			_T.gToolTip = p3.StatusIconTooltip
		end
	end

	v.ItemList_OnUnfocused = v.OnUnfocused

	function v:OnUnfocused(p3)
		if not self:Selectable(p3) then
			return
		end

		self:ItemList_OnUnfocused(p3)
		self.UpdateFocused(p3, false)
		_T.gToolTip = nil
	end

	v.ItemList_OnSelected = v.OnSelected

	function v:OnSelected(p3, p4)
		if not self:Selectable(p3) then
			return
		end

		if not self.mMultiSelect then
			module.PlaySound(p3.SelectSound or _G.UISound_Select)
		end

		local mSelectedElement = v.mSelectedElement

		if not p3.DisableSelection then
			self:ItemList_OnSelected(p3, p4)
		end

		if mSelectedElement == nil then
			self:RunForAllElements(self.UpdateFocused)
		else
			self.UpdateFocused(mSelectedElement, false)
		end

		self.UpdateFocused(p3, true, true)
	end

	function v:UpdateFocused(p3, p4)
		if __wf_atom_7e8ad928(self) or __wf_atom_7e8ad928(self.mClipName) then
			return
		end

		if p3 and not p4 then
			module.PlaySound(self.FocusSound or _G.UISound_Focus)
		end

		local v4 = self == v.mSelectedElement
		self.Selected = v.mCanSelectItem and v4
		self.Focused = p3 or self.Selected
		v.ITEM_UTIL.UpdateFocus(mMovie, self.mClipName, self, v)
	end

	function v:CalculateScrollBarHeight()
		local mScrollBarOffset = self.mScrollBarOffset or 8

		if self.mBackerVisible ~= false then
			mScrollBarOffset = mMovie:__wf_atom_cfc41e35(p2, "Offset.Scroll", 1)
		end

		return self.mHeight - mScrollBarOffset * 2
	end

	function v:ValidateSubType(data, className)
		if className == nil then
			return true
		end

		local kind = data.Type

		if not __wf_atom_7e8ad928(kind) then
			return not (__wf_atom_7e8ad928(kind) or not kind:IsA(className))
		end

		if __wf_atom_7e8ad928(data.mItem) then
			if __wf_atom_7e8ad928(data.mItemType) then
				if not __wf_atom_7e8ad928(data.StoreItem) then
					kind = data.StoreItem
				end
			else
				kind = data.mItemType
			end
		else
			kind = data.mItem.mItemType
		end

		return not (__wf_atom_7e8ad928(kind) or not kind:IsA(className))
	end

	function v:FilterElement(p3, activeCategory)
		if activeCategory == nil and self.mCategoryMenu ~= nil then
			activeCategory = self.mCategoryMenu:GetActiveCategory()
		end

		if activeCategory == nil then
			return true
		end

		if self.AdditionalFilterFunction ~= nil then
			return self.AdditionalFilterFunction(p3)
		end

		if activeCategory.AdditionalFilterFunction ~= nil and not activeCategory.AdditionalFilterFunction(p3) then
			return false
		end

		local storeItem = p3.StoreItem
		local v4 = not __wf_atom_7e8ad928(storeItem)

		if v4 then
			local subCategory = activeCategory.SubCategory or ""

			if __wf_atom_d99ae0ec(subCategory) ~= __wf_atom_d99ae0ec((tostring(storeItem:__wf_atom_ef0538a9()))) then
				return false
			end
		elseif #activeCategory.SubCategory > 0 then
			return false
		end

		if activeCategory.ItemType == nil and activeCategory.AdditionalTypes == nil then
			return true
		end

		local productCategoryOverride = p3.ProductCategoryOverride

		if productCategoryOverride == nil then
			if not v4 then
				return false
			end

			productCategoryOverride = storeItem:__wf_atom_efa6f447()
		end

		if v4 and storeItem:IsPackage() then
			local v5 = nil

			for k, v6 in storeItem:__wf_atom_72915748() do
				local mTypeName = v6.mTypeName

				if k == 1 then
					v5 = mTypeName:__wf_atom_efa6f447()

					if v5 == 10 then
						v5 = nil
						break
					end
				elseif mTypeName:__wf_atom_efa6f447() ~= v5 then
					v5 = nil
					break
				end
			end

			if v5 ~= nil then
				productCategoryOverride = v5
			end
		end

		local v5 = productCategoryOverride == activeCategory.ItemType

		if not v5 and activeCategory.AdditionalTypes ~= nil then
			for i, additionalType in ipairs(activeCategory.AdditionalTypes) do
				if productCategoryOverride ~= additionalType then
					continue
				end

				v5 = true
				break
			end
		end

		if not v5 then
			return false
		end

		if not (#activeCategory.SubTypes > 0) then
			return self:ValidateSubType(p3, activeCategory.SubType)
		end

		for k, subType in activeCategory.SubTypes do
			if self:ValidateSubType(p3, subType) then
				return true
			end
		end

		return false
	end

	v.ItemList_AddElement = v.AddElement

	function v:AddElement(p3, ...)
		if self.mHasDrawn and #self.mUnfilteredElements ~= #self.mElements then
			self:RemoveElements(true, true, true)
		end

		table.insert(self.mUnfilteredElements, p3)

		if self:FilterElement(p3) then
			self:ItemList_AddElement(p3, ...)
		end

		return p3
	end

	v.ItemList_RemoveElement = v.RemoveElement

	function v:RemoveElement(p3, p4, p5, p6, p7, p8)
		self:ItemList_RemoveElement(p3, p4, p5, p6, p7, p8)

		if self:GetHowManyElements() == 0 then
			self.mHasDrawn = false
		end
	end

	function v:RemoveElementUnfiltered(p3, p4, p5, p6, p7, p8)
		if not __wf_atom_7e8ad928(self.mUnfilteredElements[p3]) then
			local mUnfilteredElement = self.mUnfilteredElements[p3]

			for i, mElement in ipairs(self.mElements) do
				if mElement ~= mUnfilteredElement then
					continue
				end

				self:RemoveElement(i, p4, p5, p6, p7, p8)
				break
			end

			table.remove(self.mUnfilteredElements, p3)
		end
	end

	function v.GetUnfilteredIndexForElement(p3, p4)
		for k, mUnfilteredElement in p3.mUnfilteredElements do
			if mUnfilteredElement == p4 then
				return k
			end
		end

		return nil
	end

	v.ItemList_RemoveElements = v.RemoveElements

	function v:RemoveElements(p3, p4, p5)
		self:ItemList_RemoveElements(p3, p4)

		if not p5 then
			self.mUnfilteredElements = {}
		end

		self.mHasDrawn = false
	end

	v.ListAttachScrollBar = v.AttachScrollBar

	function v:AttachScrollBar(p3, options2)
		local v4 = options2 or {}

		if v4.mVisRangeMaterials == nil then
			v4.mVisRangeMaterials = v.mVisRangeMaterials
		else
			v.mVisRangeMaterials = v4.mVisRangeMaterials
		end

		v4.mVisRangeFadeSize = self.mVisRangeFadeSize or v4.mVisRangeFadeSize or 4
		self:ListAttachScrollBar(p3, v4)
	end

	function v:ShowClaim(mClaimVisible, mClaimLabel, p3, list)
		if mClaimVisible ~= nil and self.mClaimVisible ~= mClaimVisible then
			self.mClaimVisible = mClaimVisible
			mMovie:__wf_atom_7f57ab2f(p2, "Claim", 13, mClaimVisible)

			if mClaimVisible then
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(p2, "Bg", 14)
				local v4 = p2 .. ".Claim.Divider"
				mMovie:__wf_atom_e57658c2(v4, 12, 60)
				mMovie:__wf_atom_e57658c2(v4, 14, __wf_atom_cfc41e35)
				mMovie:OverrideMaterial(v4, _G.UIMaterial_TiledDivider)
				mMovie:__wf_atom_1ca72041(v4, "TileRepeats", __wf_atom_cfc41e35 / 32, 1, 0, 0)
				mMovie:__wf_atom_2dedec1a(v4, 13, false)
			end
		end

		if mClaimLabel ~= nil and self.mClaimLabel ~= mClaimLabel then
			self.mClaimLabel = mClaimLabel
			mMovie:__wf_atom_7d7314f1(p2 .. ".Claim.Label.text", mClaimLabel)
		end

		v.mClaimBtn:SetActive(p3 == true)

		if #list > 0 then
			v.mClaimBtn.mOnPressedCallback = p[list]
		end
	end

	function v:SetTitle(list)
		local mTitleVisible = #list > 0
		local v4 = mTitleVisible or self.mTitleVisible ~= mTitleVisible
		self.mTitleVisible = mTitleVisible
		mMovie:__wf_atom_7f57ab2f(p2, "TitleBar", 13, mTitleVisible)

		if v4 then
			if mTitleVisible then
				mMovie:__wf_atom_7d7314f1(p2 .. ".TitleBar.Title.Text.text", list)
			end

			self:UpdateHeight(nil, true)
		end
	end

	function v:SetCount(value, total)
		local current = value or ""
		self.mCount = tonumber(current)

		if self.mCount then
			current = module.FormatNumber(self.mCount)
		end

		self.mMaxCount = tonumber(total) or self.mMaxCount

		if self.mMaxCount then
			total = module.FormatNumber(self.mMaxCount)
		end

		if #current > 0 and #total > 0 then
			current = Localize("/Lotus/Language/Menu/ProgressXOfY", {
				CURRENT = current,
				TOTAL = total
			})
		end

		mMovie:__wf_atom_48bd5a59(p2, "Count", 36, current)
		self:UpdateHeight(nil, true)
	end

	function v:SetStates(p3, p4)
		if self.mStateMenu == nil then
			return
		end

		self.mStateMenu:SetStates(p3, p4)
	end

	function v:RefreshState()
		local activeStateId = self:GetActiveStateId()

		if activeStateId == nil then
			return
		end

		self.mCategoryMenu.mSelectedCategoryId = nil

		if self.mStateChangedCallback ~= nil then
			self.mStateChangedCallback(activeStateId)
		end

		local activeState = self.mStateMenu:GetActiveState()

		if activeState ~= nil then
			self:SetCategories(activeState.Categories, activeState.SelectedCategory)
		end
	end

	function v.SetActiveStateId(p3, p4)
		if p3.mStateMenu == nil then
			return
		end

		p3.mStateMenu:SetStateId(p4)
	end

	function v:GetActiveStateId()
		if self.mStateMenu == nil then
			return nil
		end

		return self.mStateMenu.mSelectedStateId
	end

	function v:SetCategories(p3, p4, p5)
		if self.mCategoryMenu == nil then
			return
		end

		local clone = table.clone(p3)

		if not p5 then
			for i = #clone, 1, -1 do
				local v4 = clone[i]
				local v5 = false

				for k, mUnfilteredElement in self.mUnfilteredElements do
					if not self:FilterElement(mUnfilteredElement, v4) then
						continue
					end

					v5 = true
					break
				end

				if not v5 then
					table.remove(clone, i)
				end
			end
		end

		self.mCategoryMenu:SetCategories(clone, p4)

		if #clone == 0 then
			self:RefreshCategory()
		end
	end

	function v:RefreshCategory()
		local activeCategoryId = self:GetActiveCategoryId()

		if self:GetActiveStateId() ~= nil then
			local activeState = self.mStateMenu:GetActiveState()

			if activeState ~= nil then
				activeState.SelectedCategory = activeCategoryId
			end
		end

		self:RemoveElements(true, true, true)

		for i, mUnfilteredElement in ipairs(self.mUnfilteredElements) do
			if self:FilterElement(mUnfilteredElement) then
				self:ItemList_AddElement(mUnfilteredElement, true)
			end
		end

		if self.mCategoryChangedCallback ~= nil then
			self.mCategoryChangedCallback(activeCategoryId)
		end

		self:RedrawScrollBar()
		self:UpdateWidth()

		if not self.mKeepTitle then
			local activeCategory = self.mCategoryMenu:GetActiveCategory()

			if activeCategory ~= nil then
				self:SetTitle(activeCategory.Name)
			end
		end

		self:Redraw(nil, true, true)
	end

	function v.SetActiveCategoryId(p3, p4)
		if p3.mCategoryMenu == nil then
			return
		end

		p3.mCategoryMenu:SetCategoryId(p4)
	end

	function v:GetActiveCategoryId()
		if self.mCategoryMenu == nil then
			return nil
		end

		return self.mCategoryMenu.mSelectedCategoryId
	end

	function v:UpdateHeight(mTargetHeight, p3)
		local mContentOffset = self.mContentOffset or 0

		if self.mBackerVisible == false then
			mContentOffset = -8
		elseif self.mTitleVisible or self.mCount ~= nil then
			mContentOffset = math.max(mContentOffset, 25)
		end

		if mTargetHeight == nil then
			if self.mTargetHeight == nil then
				if self.mContentHeight == nil then
					local screenDimensions, v4 = module.GetScreenDimensions(mMovie)
					_ = screenDimensions
					local v5 = v4 - mMovie:__wf_atom_5e6e15c8(p2, 3)

					if _T.GetButtonBarOffset == nil then
						mTargetHeight = v5 - mMovie:__wf_atom_54eeda24() * 0.05
					else
						mTargetHeight = v5 - _T.GetButtonBarOffset()
					end

					module.HookUpEnvironmentCallback(p2, p, "onViewportSizeChanged", function()
						self:UpdateHeight()
					end)
				else
					mTargetHeight = self.mContentHeight + mContentOffset + 2 * self:GetCollectionOffset()
				end
			else
				mTargetHeight = self.mTargetHeight
			end
		else
			self.mTargetHeight = mTargetHeight
		end

		if not p3 and self.mHeight == mTargetHeight - mContentOffset then
			return
		end

		self.mHeight = mTargetHeight - mContentOffset
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(p2, "Bg", 1)
		mMovie:__wf_atom_4c1c1986(p2, "Offset", 1, mContentOffset)
		mMovie:__wf_atom_4c1c1986(p2, "Categories.Mask", 15, mTargetHeight)
		mMovie:__wf_atom_4c1c1986(p2, "Bg", 15, mTargetHeight - __wf_atom_cfc41e35 * 2)
		mMovie:__wf_atom_4c1c1986(p2, "Claim", 1, self.mHeight - 45)
		self:UpdateScrollBarHeight()
	end

	function v:UpdateWidth(p3, p4)
		local mWidth = p3 or self.mWidth
		self.mWidth = mWidth
		mMovie:__wf_atom_48bd5a59(p2, "Count", 0, mWidth + 12 - mMovie:__wf_atom_cfc41e35(p2, "Count", 14))
		mMovie:__wf_atom_48bd5a59(p2, "Count", 1, 6)

		if self.mScrollBar and self.mScrollBar.mVisible then
			local v4 = mWidth + 21
			mMovie:__wf_atom_4c1c1986(p2, "Offset.Scroll", 0, v4)
			mWidth = v4 + 5
		end

		local v4 = mWidth + (mMovie:__wf_atom_cfc41e35(p2, "Offset", 0) * 2 + self.mPadding)
		mMovie:__wf_atom_4c1c1986(p2, "TitleBar", 0, v4 / 2)
		mMovie:__wf_atom_4c1c1986(p2, "TitleBar", 1, 2)
		mMovie:__wf_atom_4c1c1986(p2, "TitleBar.Title.Text", 44, _G.UIColor_Yellow)
		mMovie:OverrideMaterial(p2 .. ".TitleBar.Backer", _G.UIMaterial_FocusedTabBorder)
		mMovie:__wf_atom_4c1c1986(p2, "Bg", 14, v4 - mMovie:__wf_atom_cfc41e35(p2, "Bg", 0) * 2)
		mMovie:__wf_atom_4c1c1986(p2, "Claim", 0, v4 / 2)

		if self.mAlignment == module.RIGHT_ALIGNED then
			mMovie:__wf_atom_e57658c2(p2, 0, -v4)
		elseif self.mAlignment == module.CENTER_ALIGNED then
			mMovie:__wf_atom_e57658c2(p2, 0, -v4 / 2)
		elseif self.mAlignment == module.LEFT_ALIGNED then
			mMovie:__wf_atom_e57658c2(p2, 0, 0)
		end

		if p4 then
			self:RefreshCategory()
		end
	end

	function v:GetCollectionOffset()
		if v3 then
			return mMovie:__wf_atom_cfc41e35(p2, "Offset.List", 1)
		end

		return mMovie:__wf_atom_cfc41e35(p2, "Offset.Grid", 1)
	end

	mMovie:OverrideMaterial(p2 .. ".Bg", _G.UIMaterial_SelectedBackerBorder)
	mMovie:__wf_atom_4c1c1986(p2, "Bg", 12, 80)
	v:UpdateHeight(v.mHeight, true)

	if v.mGrid and v.mRows == nil then
		v.mRows = (v.mHeight + v.mPadding) / v.mRowSeparation
	end

	v:AttachScrollBar(p2 .. ".Offset.Scroll", {
		mHeight = v:CalculateScrollBarHeight(),
		mContentOffset = v:GetCollectionOffset() - mMovie:__wf_atom_cfc41e35(p2, "Offset.Scroll", 1),
		mVisRangeSizeOffset = 10
	})
	local module2 = require("Lotus.Interface.Components.ThemedSpinner")
	v.mSpinner = module2.Create(mMovie, p2 .. ".Spinner")
	v.mSpinner:SetActive(false)
	local module3 = require("SF.Interface.Components.Button")
	v.mClaimBtn = module3.Create(
		mMovie,
		p2 .. ".Claim.ClaimBtn",
		"/SF/Language/Crafting/Foundry_ClaimAllBtn",
		"ItemListClaim"
	)
	v.mClaimBtn:SetVariant(module3.VARIANTS.SPECIAL_BUTTON)
	v.mClaimBtn:SetAnchor(module.CENTER_ALIGNED)
	v:ShowClaim(false)
	local module4 = require("EE.Interface.Components.TabStates")
	v.mStateMenu = module4.Create(p, p2 .. ".States", function()
		v:RefreshState()
	end)
	local module5 = require("EE.Interface.Components.TabCategories")
	v.mCategoryMenu = module5.Create(p, p2 .. ".Categories", function()
		v:RefreshCategory()
	end)
	mMovie:__wf_atom_7f57ab2f(p2, "SortDropdown", 13, false)
	mMovie:__wf_atom_4c1c1986(p2, "Categories", 1, v.mTabsInitialY)
	mMovie:__wf_atom_4c1c1986(p2, "Categories", 0, 0)
	mMovie:__wf_atom_4c1c1986(p2, "Claim.Label", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_4c1c1986(p2, "Count", 11, _G.UIColor_Tan)
	v:UpdateWidth(v.mDefaultWidth)
	v:SetCount()
	v:SetTitle()
	return v
end