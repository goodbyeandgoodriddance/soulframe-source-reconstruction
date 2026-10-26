module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local module4 = require("Lotus.Interface.UIUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local visibleRangeMaterial2 = Resource("/Lotus/Interface/Materials/CustomizationListVisRangeMaterial")
local textVisibleRangeMaterial2 = Resource("/Lotus/Interface/Materials/CustomizationListTextVisRangeMaterial")
local rectangleVisibleRangeMaterial2 = Resource("/Lotus/Interface/Materials/CustomizationListNoDepthMaterial")
local shadowVisibleRangeMaterial = Resource("/Lotus/Interface/Materials/VisibleRangeMarketShadow")
local module6 = require("Lotus.Interface.Components.ThemedCustomizationButton")
local module7 = require("EE.Interface.Components.List")
local module8 = require("Lotus.Interface.Components.CategorizedGrid")
local mDefaultColorPalette = Resource("/Lotus/Types/StoreItems/SuitCustomizations/ColourPickerItem")
local lockedIcon = Resource("/Lotus/Interface/Icons/LockIconStroke.png")

function Create(mMovie2, mClipName2, p)
	local v = { mMovie = mMovie2, mClipName = mClipName2 }
	v.State = { CUSTOMIZATION = 1, ITEM_SELECTION = 2 }
	v.mState = nil
	v.mChildMovie = nil
	v.PLATINUM_ICON = mMovie2:__wf_atom_8e9ac384("<PLATINUM_CREDITS>", true)
	v.ScrollRemainderOnFocus = true

	if mMovie2:__wf_atom_253d7085(mClipName2 .. ".CustomizationPanel") then
		local list = module7.CreateList(mMovie2, mClipName2 .. ".CustomizationPanel.List.MenuItem", p)
		list.mAllColors = {}
		list.mDefaultColorPalette = mDefaultColorPalette
		list.Colors = {
			Background1 = module3.GetColor(2, true),
			Background1Object = module3.GetColor(2, false),
			Content = module3.GetColor(6, true),
			FloatingContent = module3.GetColor(9, true),
			FloatingContentObject = module3.GetColor(9, false),
			FloatingContentHighlight = module3.GetColor(10, true),
			FloatingContentHighlightObject = module3.GetColor(10, false)
		}
		list.mApplyThemes = true
		list.mForcedVerticalSeparation = 150
		list.mWrapAroundNavigation = false
		list.mScrollBarExtension = 0
		list.mMaxVisibleHeight = 680
		list.mElementHeight = 38
		list.mContentWidth = 200
		list.mCategorySpacing = 10
		list.mOriginalListYPos = list.mMovie:__wf_atom_5e6e15c8(v.mClipName .. ".CustomizationPanel.List", 1)
		list.mInitColorXPos = list.mMovie:__wf_atom_5e6e15c8(
			v.mClipName .. ".CustomizationPanel.List.MenuItem.Color",
			0
		)
		list.mUnfilteredElements = {}
		list.mUnfilteredCategories = {}
		list.mCategoriesCount = {}
		list.mElementTransitionTime = 0.2
		list.mElementDelayTime = 0
		list.mTopTitleForNone = false
		list.mFadeClips = { "DropDown", "LabelRight", "Bg", "ValueSelector", "Toggle", "Checkbox" }
		list.mCategoryClipName = v.mClipName .. ".CustomizationPanel.CategoriesMenu"
		list.mCategoryOffsetAmount = list.mMovie:__wf_atom_5e6e15c8(list.mCategoryClipName, 1)

		if list.mCategoryOffsetAmount ~= nil then
			list.mCategoryOffsetAmount = -(list.mCategoryOffsetAmount * 2)
		end

		list.mCategoryOffset = true
		list.mCategoryHideBar = false

		if Engine.__wf_atom_2a979d69() then
			list:EnableDragScrolling()
		end

		list.mMovie:__wf_atom_2dedec1a(list.mCategoryClipName, 13, false)
		list.mMovie:__wf_atom_7f57ab2f(v.mClipName, "CustomizationPanel.CategoryBar", 13, false)
		list._AddElement = list.AddElement

		function list:AddElement(object, p2, p3)
			if object.ShouldRemove ~= nil and object:ShouldRemove() then
				return
			end

			if not p3 then
				self:SetIdOnUnfiltered(self.mUnfilteredElements, object)
				table.insert(self.mUnfilteredElements, object)

				for i = 1, #object.Categories do
					local category = object.Categories[i]

					if self.mCategoriesCount[category] == nil then
						self.mCategoriesCount[category] = 0
					end

					self.mCategoriesCount[category] = self.mCategoriesCount[category] + 1
				end
			end

			self:_AddElement(object, p2)
			return object
		end

		function list:AddChildElement(object, mParent, _)
			if object.ShouldRemove ~= nil and object:ShouldRemove() then
				return
			end

			self:SetIdOnUnfiltered(self.mUnfilteredElements, object)

			for i = 1, #object.Categories do
				local category = object.Categories[i]

				if self.mCategoriesCount[category] == nil then
					self.mCategoriesCount[category] = 0
				end

				self.mCategoriesCount[category] = self.mCategoriesCount[category] + 1
			end

			if mParent.mChildren == nil then
				mParent.mChildren = {}
			end

			table.insert(mParent.mChildren, object)
			object.mParent = mParent
			table.insert(self.mUnfilteredElements, object)
			return object
		end

		list._ToggleFocusedElement = list.ToggleFocusedElement

		function list:ToggleFocusedElement(p2)
			local v2 = nil
			local focusedElementIndex = self:GetFocusedElementIndex()

			if focusedElementIndex == nil then
				self:_ToggleFocusedElement(module.INCREMENT)
				return
			end

			local ternary = module.Ternary(p2 == module.DECREMENT, 1, self:GetHowManyElements())

			for i = focusedElementIndex + p2, ternary, p2 do
				local elementInIndex = self:GetElementInIndex(i)

				if not (elementInIndex ~= nil and (self:IsElementEnabled(elementInIndex) or Engine.IsPlayingWithController() and elementInIndex.CanFocusOnController)) then
					continue
				end

				v2 = i - focusedElementIndex
				break
			end

			if v2 ~= nil then
				self:_ToggleFocusedElement(v2)
			end
		end

		function list.UpdateSaleInfo(data, state, p2, data2)
			local v2 = state.mClipName .. ".RightInfo"
			local v3 = data2.mAmount ~= nil

			if not state.RightInfoInitialized then
				local mApplyThemes = v.mApplyThemes
				local color = module3.GetColor(6, true, mApplyThemes)
				local color2 = module3.GetColor(9, true, mApplyThemes)
				local __wf_atom_5e6e15c8 = data.mMovie:__wf_atom_5e6e15c8(v2, 0)
				__wf_atom_86cbd68d(data.mMovie, v2 .. ".gotoAndStop", "Sale")

				for _, v4 in pairs({ "Discount", "Expiry", "SalePrice" }) do
					data.mMovie:OverrideMaterial(v2 .. "." .. v4, data.TextVisibleRangeMaterial)
				end

				for _, v4 in pairs({ "Icon", "StrikeThrough", "Separator" }) do
					data.mMovie:OverrideMaterial(v2 .. "." .. v4, data.VisibleRangeMaterial)
				end

				data.mMovie:__wf_atom_4c1c1986(v2, "Discount", 44, color2)
				data.mMovie:__wf_atom_4c1c1986(v2, "Discount", 1, data.mElementHeight / 2 - 22)
				data.mMovie:__wf_atom_4c1c1986(v2, "Expiry", 1, data.mElementHeight / 2)
				local v4 = state.mOnPressedCallback ~= nil
				data.mMovie:__wf_atom_7f57ab2f(v2, "StrikeThrough", 13, v4)
				data.mMovie:__wf_atom_7f57ab2f(v2, "SalePrice", 13, v4)
				data.mMovie:__wf_atom_7f57ab2f(v2, "Separator", 13, v4)
				data.mMovie:__wf_atom_7f57ab2f(v2, "Icon", 13, v.DiscountIcons ~= nil)

				if v.DiscountIcons ~= nil then
					local ternary = module.Ternary(v3, v.DiscountIcons[2], v.DiscountIcons[1])
					data.mMovie:__wf_atom_c90af43a(v2 .. ".Icon", ternary)
					data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 11, color)
					data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 12, 10)
					data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 1, data.mElementHeight / 2)
					data.mMovie:__wf_atom_4c1c1986(v2, "Mask", 1, data.mElementHeight / 2)
					local v5 = (data.mElementHeight + 7) * module.Ternary(v3, 1.6, 1)
					data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 14, v5)
					data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 15, data.mElementHeight + 7)
					data.mMovie:__wf_atom_4c1c1986(v2, "Mask", 14, v5)
					data.mMovie:__wf_atom_4c1c1986(v2, "Mask", 15, data.mElementHeight - 5)
				end

				data.mMovie:__wf_atom_4c1c1986(v2, "Expiry", 44, color)
				local v5 = state.mButton.mMaxSize - __wf_atom_5e6e15c8
				data.mMovie:__wf_atom_4c1c1986(v2, "Expiry", 0, v5 - 205)
				data.mMovie:__wf_atom_4c1c1986(v2, "Discount", 0, v5 - 205)
				data.mMovie:__wf_atom_4c1c1986(v2, "Icon", 0, v5 - 100)
				data.mMovie:__wf_atom_4c1c1986(v2, "Mask", 0, v5 - 100)
				local mAmount = data2.mAmount

				if not v3 then
					mAmount = data2.mDiscount / 100
				end

				local __wf_atom_8e9ac384 = data.mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/DetailedPurchase_Discount",
					false,
					{
						DISCOUNT = module.FormatNumber(mAmount * 100)
					}
				)
				local v6 = data.mMovie:__wf_atom_5e6e15c8(state.mClipName .. ".Desc", 0) - __wf_atom_5e6e15c8
				local __wf_atom_5e6e15c8_2 = data.mMovie:__wf_atom_5e6e15c8(state.mClipName .. ".Desc", 1)
				local __wf_atom_5e6e15c8_3 = data.mMovie:__wf_atom_5e6e15c8(state.mClipName .. ".Desc", 40)
				local v7 = v6 + __wf_atom_5e6e15c8_3
				data.mMovie:__wf_atom_4c1c1986(v2, "StrikeThrough", 11, color2)
				data.mMovie:__wf_atom_4c1c1986(v2, "Separator", 11, color)
				data.mMovie:__wf_atom_4c1c1986(v2, "SalePrice", 44, color)
				data.mMovie:__wf_atom_4c1c1986(v2, "Separator", 12, 70)
				data.mMovie:__wf_atom_4c1c1986(v2, "StrikeThrough", 0, v6 - 5)
				data.mMovie:__wf_atom_4c1c1986(v2, "StrikeThrough", 1, __wf_atom_5e6e15c8_2 + 10)
				data.mMovie:__wf_atom_4c1c1986(v2, "StrikeThrough", 14, __wf_atom_5e6e15c8_3 + 10)
				data.mMovie:__wf_atom_4c1c1986(v2, "SalePrice", 1, __wf_atom_5e6e15c8_2)
				data.mMovie:__wf_atom_4c1c1986(v2, "Separator", 1, __wf_atom_5e6e15c8_2)
				data.mMovie:__wf_atom_4c1c1986(v2, "SalePrice", 0, v7 + 25)
				data.mMovie:__wf_atom_4c1c1986(v2, "Separator", 0, v7 + 5)

				if p2.HasRegularPrice then
					local v8 = p2.SalePriceInfo.CurrencyText .. p2.SalePriceInfo.PriceText
					data.mMovie:__wf_atom_7d7314f1(v2 .. ".SalePrice.text", v8)

					if not v4 then
						__wf_atom_8e9ac384 ..= " (" .. v8 .. ")"
					end
				end

				data.mMovie:__wf_atom_48bd5a59(v2, "Discount", 36, __wf_atom_8e9ac384)
				state.RightInfoInitialized = true
			end

			local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(module.Ternary(v3, data2.mExpiry, data2.mEndDate))
			data.mMovie:__wf_atom_7d7314f1(
				v2 .. ".Expiry.text",
				"<TIMER> " .. module2.GetTwitterStyleTime((math.max(0, __wf_atom_db2b0cee)))
			)
		end

		function list:GetParentEnv()
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v2 = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v2)
				v2 += 1
			until mParentEnv.mMovie

			self.mParentEnv = mParentEnv
			return mParentEnv
		end

		list._CalculateY = list.CalculateY

		function list:CalculateY(p2)
			if p ~= nil then
				return (self:_CalculateY(p2))
			end

			local mInitialY = self.mInitialY
			local mCategory = nil

			for i = 1, p2.mIndex do
				local mElement = self.mElements[i]

				if mElement == nil then
					break
				end

				if i ~= 1 and (mElement.TopTitle ~= nil or mElement.HasMiddleLine) then
					mInitialY += 17
				end

				if mCategory == nil then
					mCategory = mElement.mCategory
				elseif mElement.mCategory ~= nil and mCategory < mElement.mCategory then
					mInitialY += self.mCategorySpacing
					mCategory = mElement.mCategory
				end

				if i == p2.mIndex then
					continue
				end

				if mElement.ElementHeight == nil then
					mInitialY += self.mForcedVerticalSeparation
				else
					mInitialY = mInitialY + mElement.ElementHeight + module.Ternary(
						mElement.ElementSeparation ~= nil,
						mElement.ElementSeparation,
						12
					)
				end
			end

			return mInitialY
		end

		function list:GetHeight()
			local howManyElements = self:GetHowManyElements()
			return not (howManyElements > 0) and 0 or self:CalculateY({
				mIndex = howManyElements + 1
			})
		end

		function list:CalculateElementHeight(p2)
			local total = 35

			if p2.TopTitle ~= nil or p2.HasMiddleLine then
				total += 25
			end

			return total
		end

		function list.IsElementVisible(p2, p3)
			if Engine.IsPlayingWithController() then
				return true
			end

			local targetScrollValue = v.CustListScrollBar:GetTargetScrollValue()
			local menuYAtScroll = v.CustListScrollBar:GetMenuYAtScroll(targetScrollValue)
			local v2 = list.mMovie:__wf_atom_5e6e15c8(p3.mClipName, 1) - 5

			if p3.TopTitle ~= nil then
				v2 -= 30
			end

			local v3 = menuYAtScroll - list.mOriginalListYPos + v2
			local elementHeight = list:CalculateElementHeight(p3)
			local v4 = p2.mMaxVisibleHeight + 40
			return not (v3 + elementHeight <= 0 or v4 <= v3)
		end

		function list:Update(p2)
			self:RunForAllVisibleElements(function(p3)
				if p3.mButton ~= nil then
					p3.mButton:Update(p2)
				end
			end)

			if v.ItemSelectionGrid ~= nil then
				v.ItemSelectionGrid:Update(p2)
			end

			return self:UpdateScrollDrag(v.CustListScrollBar)
		end

		function list:UpdateColors(data)
			if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.mClipName) then
				return
			end

			if data.mButton then
				data.mButton:UpdateColors()
			end

			local mMovie = self.mMovie
			local v2 = 100

			if self:IsElementEnabled(data) then
				if data.Type == module6.Types.ITEM_SELECTION and not __wf_atom_7e8ad928(data.ItemSelectionData) then
					local customName = data.ItemSelectionData.CustomName

					if
						not __wf_atom_7e8ad928(data.ItemSelectionData.CurrSelection)
						and data.ItemSelectionData.CurrSelection:IsA(__wf_atom_cb425ff5)
					then
						customName = mMovie:__wf_atom_8e9ac384(
							data.ItemSelectionData.CurrSelection:__wf_atom_014a76a2():c_str(),
							true
						)
					end

					v2 = (customName == nil or customName == "" or customName == "NONE") and 50 or v2
				end
			else
				v2 = 35
			end

			local mClipName = data.mClipName

			for i = 1, #self.mFadeClips do
				mMovie:__wf_atom_e57658c2(mClipName .. "." .. self.mFadeClips[i], 12, v2)
			end
		end

		function list:IsElementEnabled(p2)
			return p2.Enabled == nil or p2.Enabled
		end

		list._SetupPreInterpolationValues = list.SetupPreInterpolationValues

		function list:SetupPreInterpolationValues(data)
			if not self.TreeUpdate then
				self:_SetupPreInterpolationValues(data)
				return
			end

			self.mMovie:__wf_atom_e57658c2(data.mClipName, 12, self.UTIL.Ternary(data.mInterpolate, 0, 100))
			local mLastY

			if data.mParent == nil or not data.mInterpolate then
				if data.mLastY == nil then
					mLastY = self:CalculateY(data)
				else
					mLastY = data.mLastY
				end
			else
				mLastY = self:CalculateY(data.mParent)
			end

			self.mMovie:__wf_atom_e57658c2(data.mClipName, 1, mLastY)
		end

		function list:GetInterpolationProperties(p2)
			p2.mLastY = self:CalculateY(p2)
			return { 12, 1 }, { 100, p2.mLastY }
		end

		list._OnElementTransitionEnded = list.OnElementTransitionEnded

		function list.OnElementTransitionEnded(object, object2)
			object:_OnElementTransitionEnded(object2)

			if
				object2.mButton ~= nil
				and object2.mClipName == object2.mButton.mClipName
				and object2.IsEnabledCheck ~= nil
			then
				object2.mButton:SetActive(object2:IsEnabledCheck())
			end
		end

		list._RunForAllElements = list.RunForAllElements

		function list:RunForAllElements(callback)
			if callback then
				for i = 1, #self.mUnfilteredElements do
					__wf_atom_83c14687(0)
					callback(self.mUnfilteredElements[i])
				end
			end
		end

		function list:GetUnfilteredElementById(p2)
			for i = 1, #self.mUnfilteredElements do
				if self.mUnfilteredElements[i].Id == p2 then
					return self.mUnfilteredElements[i]
				end
			end

			return nil
		end

		function list:OnUnfilteredElementRemoved(p2)
			if not p2.Filler then
				for i = 1, #p2.Categories do
					local category = p2.Categories[i]

					if self.mCategoriesCount[category] ~= nil then
						self.mCategoriesCount[category] = self.mCategoriesCount[category] - 1
					end
				end
			end
		end

		function list:RemoveUnfilteredElementById(p2, p3)
			local v2 = nil

			for i = 1, #self.mUnfilteredElements do
				if self.mUnfilteredElements[i].Id ~= p2 then
					continue
				end

				v2 = i
				break
			end

			if v2 ~= nil then
				self:OnUnfilteredElementRemoved(self.mUnfilteredElements[v2])
				table.remove(self.mUnfilteredElements, v2)

				if not p3 then
					self:Redraw()
				end
			end
		end

		list._RemoveElements = list.RemoveElements

		function list:RemoveElements(p2, p3)
			list:_RemoveElements(p2, p3)
			self.mUnfilteredElements = {}
			self.mCategoriesCount = {}
			self.mLastFilterBy = nil
		end

		list.ListFocusElement = list.FocusElement

		function list.FocusElement(object, p2, p3)
			local mElement = object.mElements[p2]

			if mElement ~= nil then
				local mButton = mElement.mButton

				if mButton ~= nil and not mButton.mFocused then
					mButton:TrySetFocus(true)
					return
				end
			end

			object:ListFocusElement(p2, p3)
		end

		list.ListUnfocusElement = list.UnfocusElement

		function list.UnfocusElement(object, p2)
			local mElement = object.mElements[p2]

			if mElement ~= nil then
				local mButton = mElement.mButton

				if mButton ~= nil and mButton.mFocused then
					mButton:TrySetFocus(false)
					return
				end
			end

			object:ListUnfocusElement(p2)
		end

		list.ListPressedElement = list.PressedElement

		function list.PressedElement(object, p2)
			local mElement = object.mElements[p2]

			if mElement ~= nil then
				local mButton = mElement.mButton

				if mButton ~= nil and not mButton.mListSelected then
					mButton:TryPressed(true)
					return
				end
			end

			object:ListPressedElement(p2)
		end

		list.ListSelectElement = list.SelectElement

		function list:SelectElement(p2, p3)
			local mElement = self.mElements[p2]

			if mElement ~= nil then
				local mButton = mElement.mButton

				if mButton ~= nil and mButton.mListSelected then
					mButton:TryPressed(false)
					return
				end
			end

			self:ListSelectElement(p2, p3)
		end

		function list:mElementDrawCallback()
			local mClipName = self.mClipName

			if mClipName == nil then
				return
			end

			local v2 = Symbol("/Lotus/Language/Menu/Cosmetics_None")
			local mMovie = list.mMovie
			local v3

			if self.Type == module6.Types.ITEM_SELECTION then
				v3 = not (__wf_atom_7e8ad928(self.ItemSelectionData) or __wf_atom_7e8ad928(self.ItemSelectionData.CurrSelection))
					and self.ItemSelectionData.CurrSelection:IsA(__wf_atom_cb425ff5)
					and self.ItemSelectionData.CurrSelection:__wf_atom_014a76a2() ~= v2
			else
				v3 = false
			end

			local defaultIcon = self.DefaultIcon
			local defaultIconColor = nil
			local mNoneIconAlpha = 100
			local themed = self.Themed
			local defaultIconWidth = 1
			local defaultIconHeight = 1

			if v3 and self.mUseItemIcon ~= false then
				defaultIcon, themed = module5.GetIconTexture(self.ItemSelectionData.CurrSelection, true)
				defaultIconColor = module.Ternary(
					self.ItemSelectionData.CurrSelection:__wf_atom_7941efb7(),
					list.Colors.Content,
					_G.UIColor_White
				)

				if not themed then
					defaultIconWidth = 0.96
					defaultIconHeight = 0.6
				end

				if self.IconScaleMultiplier ~= nil then
					defaultIconWidth *= self.IconScaleMultiplier
					defaultIconHeight *= self.IconScaleMultiplier
				end
			elseif __wf_atom_7e8ad928(defaultIcon) then
				if not __wf_atom_7e8ad928(self.mNoneIcon) then
					defaultIcon = self.mNoneIcon

					if self.mNoneIconAlpha ~= nil then
						mNoneIconAlpha = self.mNoneIconAlpha
					end
				end
			else
				if self.DefaultIconColor ~= nil then
					defaultIconColor = self.DefaultIconColor
				end

				if self.DefaultIconAlpha ~= nil then
					mNoneIconAlpha = self.DefaultIconAlpha
				end

				if self.DefaultIconWidth ~= nil then
					defaultIconWidth = self.DefaultIconWidth
				end

				if self.DefaultIconHeight ~= nil then
					defaultIconHeight = self.DefaultIconHeight
				end
			end

			local v4

			if self.UseFadeIcon == true then
				v4 = not __wf_atom_7e8ad928(defaultIcon)
			else
				v4 = false
			end

			mMovie:__wf_atom_7f57ab2f(self.mClipName, "FadeIcon", 13, v4)

			if v4 then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "FadeIcon", 14, 180)
				mMovie:__wf_atom_4c1c1986(self.mClipName, "FadeIcon", 15, 180)
				mMovie:__wf_atom_933bbce0(self.mClipName .. ".FadeIcon", defaultIcon, list.VisibleRangeFadeIconMaterial)
				defaultIcon = nil
			end

			if self.Type == module6.Types.DROP_DOWN then
				local parentEnv = list:GetParentEnv()

				if parentEnv.onKeyUp_DROPDOWN_MENU_CLICK == nil then
					local function fn()
						list:RunForAllElements(function(p2)
							if p2.mButton ~= nil and p2.mButton.mDropDown then
								p2.mButton.mDropDown:OnMouseClick()
							end
						end)
					end

					if parentEnv.onKeyUp_MENU_CLICK == nil then
						function parentEnv.onKeyUp_MENU_CLICK()
							fn()
						end

						parentEnv.onKeyUp_DROPDOWN_MENU_CLICK = parentEnv.onKeyUp_MENU_CLICK
					else
						parentEnv.onKeyUp_DROPDOWN_MENU_CLICK = parentEnv.onKeyUp_MENU_CLICK

						function parentEnv.onKeyUp_MENU_CLICK()
							fn()

							if parentEnv.onKeyUp_DROPDOWN_MENU_CLICK ~= nil then
								parentEnv.onKeyUp_DROPDOWN_MENU_CLICK()
							end
						end
					end
				end
			end

			local mButton = self.mButton

			if mButton == nil then
				mButton = module6.Create(mMovie, mClipName, self.NameTag, list, v.ItemSelectionGrid, self)
				self.mButton = mButton
				mButton.CustButtonTrySetFocus = mButton.TrySetFocus

				function mButton.TrySetFocus(_, p2, p3, p4)
					local v5 = p3 == true

					if not p4 and p2 and list.mVisibleElements ~= nil then
						mMovie:__wf_atom_f62a8704("CustListTrySetFocus", {
							tostring(self.Id),
							module.Ternary(v5, "true", "false")
						})
					elseif v5 then
						mButton:ComponentTrySetFocus(p2)
					else
						mButton:CustButtonTrySetFocus(p2)
					end
				end

				mButton.CustButtonSetFocus = mButton.SetFocus

				function mButton.SetFocus(data, p2)
					mButton:CustButtonSetFocus(p2)

					if p2 then
						list:FocusElementById(self.Id)

						if
							Engine.IsPlayingWithController()
							and v.ScrollRemainderOnFocus
							and v.CustListScrollBar ~= nil
						then
							local targetScrollValue = v.CustListScrollBar:GetTargetScrollValue()
							local menuYAtScroll = v.CustListScrollBar:GetMenuYAtScroll(targetScrollValue)
							local __wf_atom_5e6e15c8 = data.mMovie:__wf_atom_5e6e15c8(data.mClipName, 1)
							local v5 = menuYAtScroll - list.mOriginalListYPos + __wf_atom_5e6e15c8
							local mHeight = data.mHeight
							local mMaxVisibleHeight = list.mMaxVisibleHeight
							local v6 = 0

							if mMaxVisibleHeight < v5 + mHeight then
								v6 = mHeight - (mMaxVisibleHeight - v5)
							elseif v5 < 0 then
								v6 = v5
							end

							if v6 ~= 0 then
								local v7 = v6 / (v.CustListScrollBar.mTotalHeight * (1 - v.CustListScrollBar.mVisibleProp))
								v.CustListScrollBar:ScrollBy(v7)
							end
						end
					else
						list:UnfocusElementById(self.Id)
					end
				end

				mButton.CustButtonPressed = mButton.Pressed

				function mButton.Pressed(data, mListSelected, p2, p3)
					mButton.mListSelected = mListSelected

					if mListSelected then
						list:PressedElementById(self.Id)
					else
						list:SelectElementById(self.Id)

						if self.mSubMenu ~= nil then
							v:MenuStackChanged(self.mSubMenu)
						end
					end

					local v5 = not mListSelected
						and (data.mType == module6.Types.ITEM_SELECTION or data.mDisplayDojoColorGrid)
						and not (__wf_atom_7e8ad928(v.ItemSelectionGrid) or __wf_atom_7e8ad928(data.mItemSelectionData))

					if v5 then
						v.mState = v.State.ITEM_SELECTION
					end

					if not p3 then
						mButton:CustButtonPressed(mListSelected, p2)
					end

					if v5 then
						v:SetState(v.State.ITEM_SELECTION)
					end
				end

				mButton.CustPickColor = mButton.PickColor

				function mButton.PickColor(_, p2)
					mButton:CustPickColor(p2)
					v.mChildMovie = mButton.mChildMovie
				end
			else
				mButton.mClipName = mClipName
				mButton.mHookedUpCallbacks = false
				mButton:HookUpCallbacks()
			end

			local id = self.Id
			mButton:SetId(id)
			mButton.mType = self.Type
			mButton.mLocalizeText = module.Ternary(self.LocalizeText ~= nil, self.LocalizeText, true)
			mButton.mThemeLabel = self.ThemeLabel
			mButton.mLeading = self.Leading
			mButton.NameTagRight = self.NameTagRight
			mButton.mTextYOverride = self.TextYOverride
			mButton.mConvertEmoticons = self.mConvertEmoticons
			mButton.mCopyColorSlot = self.mCopyColorSlot
			mButton.mColorRegions = self.mColorRegions
			mButton.mDefaultColor = self.mDefaultColor
			mButton.mCustomColorInfo = self.CustomColors
			mButton.mBigButton = self.BigButton
			mButton.mShowDesc = self.ShowDesc
			mButton.mProgress = self.Progress
			mButton.mIcon = defaultIcon
			mButton.mIconThemed = themed
			mButton.mIconAlphaOverride = mNoneIconAlpha
			mButton.mIconColorOverride = defaultIconColor
			mButton.mIconWidthMultiplier = defaultIconWidth
			mButton.mIconHeightMultiplier = defaultIconHeight
			mButton.mSelectState = self.mSelectState
			mButton.mStoreItem = self.StoreItem
			mButton.mShowInfoPopup = self.ShowInfoPopup
			mButton.mInfoPopupInfo = self.InfoPopupInfo
			mButton.mContextInfo = self.ContextInfo
			mButton.mItemSelectionData = self.ItemSelectionData
			mButton.mOnFocusedCallback = self.mOnFocusedCallback
			mButton.mOnUnfocusedCallback = self.mOnUnfocusedCallback
			mButton.mOnPressedCallback = self.mOnPressedCallback
			mButton.mOnPressCompletedCallback = self.mOnPressCompletedCallback
			mButton.mOnReleasedCallback = self.mOnReleasedCallback
			mButton.mValueChangedCallback = self.mValueChangedCallback
			mButton.mInitialValue = self.mInitialValue
			mButton.mDefaultValue = self.mDefaultValue
			mButton.mMinValue = self.mMinValue
			mButton.mMaxValue = self.mMaxValue
			mButton.mSteps = self.mSteps
			mButton.mDecimals = self.mDecimals
			mButton.mOptions = self.mOptions
			mButton.mMoverTime = self.mMoverTime
			mButton.mFocusTarget = self.mFocusTarget

			if self.ElementHeight == nil then
				mButton.mHeight = list.mElementHeight
			else
				mButton.mHeight = self.ElementHeight
			end

			if self.IconPadding ~= nil then
				mButton.mIconPadding = self.IconPadding
			end

			if self.IconOffset ~= nil then
				mButton.mIconOffset = self.IconOffset
			end

			mButton.mContentWidth = self.ContentWidth
			mButton.mDefaultText = self.NameTag
			mButton.mDisableCheckbox = self.mDisableCheckbox
			mButton.mDisableSlider = self.mDisableSlider
			mButton.mDisplayDojoColorGrid = self.mDisplayDojoColorGrid
			mButton.mToggleFontSize = self.mToggleFontSize
			mButton.mPostText = self.mPostText
			mButton.mToUpper = self.mToUpper
			mButton.mTitleCase = self.mTitleCase
			mButton.mForceButton = self.mForceButton
			mButton.IgnoreToggleTextVisRange = self.IgnoreToggleTextVisRange

			if self.mTextYOffset == nil then
				mButton.mTextYOffset = -2
			else
				mButton.mTextYOffset = self.mTextYOffset
			end

			if self.mOverrideWidth == nil then
				if list.mElementWidth ~= nil then
					mButton.mMaxSize = list.mElementWidth
					mButton.mMinSize = list.mElementWidth
				end
			else
				mButton.mMaxSize = self.mOverrideWidth
				mButton.mMinSize = self.mOverrideWidth
			end

			if
				(mButton.mType == module6.Types.COLOR or mButton.mCopyColorSlot ~= nil)
				and mButton.mColorRegions == nil
			then
				mButton.mAllColors = list.mAllColors
			end

			local v5 = self.IsEnabledCheck == nil or self.IsEnabledCheck()
			mButton:Resize()

			if __wf_atom_7e8ad928(list.VisibleRangeMaterial) then
				mButton:Redraw()
			else
				local visibleRangeMaterial = list.VisibleRangeMaterial
				local textVisibleRangeMaterial = list.TextVisibleRangeMaterial
				local rectangleVisibleRangeMaterial = list.RectangleVisibleRangeMaterial
				mButton:SetVisibleRangeMaterials(
					visibleRangeMaterial,
					textVisibleRangeMaterial,
					rectangleVisibleRangeMaterial
				)
			end

			mButton:SetActive(v5)

			if self.AlphaOverride ~= nil then
				local alphaOverride = self.AlphaOverride
				mButton:SetAlpha(alphaOverride)
			end

			if self.BackerAlphaOverride ~= nil then
				mButton.mInnerAlpha = self.BackerAlphaOverride
			end

			__wf_atom_86cbd68d(mMovie, mClipName .. ".RightInfo.gotoAndStop", "Off")
			local nameTag = self.NameTag

			if self.Type == module6.Types.ITEM_SELECTION and not __wf_atom_7e8ad928(self.ItemSelectionData) then
				if self.ItemSelectionData.CustomName == nil or self.ItemSelectionData.CustomName == "" then
					if __wf_atom_7e8ad928(self.ItemSelectionData.CurrSelection) then
						nameTag = "NONE"
					else
						local v6

						if list.mUseOverrideLoc then
							v6 = mMovie:__wf_atom_8e9ac384(
								self.ItemSelectionData.CurrSelection:__wf_atom_619b1891():c_str(),
								true
							)
						else
							v6 = mMovie:__wf_atom_8e9ac384(
								self.ItemSelectionData.CurrSelection:__wf_atom_014a76a2():c_str(),
								true
							)
						end

						if v6 ~= "" and v6 ~= " " then
							nameTag = v6
						end
					end
				else
					nameTag = self.ItemSelectionData.CustomName
				end

				if nameTag == "" or nameTag == "NONE" then
					if list.mNoneTextOverride == nil then
						if list.mTopTitleForNone then
							nameTag = Localize(self.NameTag, false)
						else
							nameTag = Localize("/Lotus/Language/Menu/Cosmetics_NoItem", {
								ITEM = Localize(self.NameTag, false)
							})
						end
					else
						nameTag = Localize(list.mNoneTextOverride, false)
					end
				end
			elseif self.BigButton then
				if self.Type == module6.Types.BUTTON then
					nameTag = self.Title
				end
			elseif self.Type == module6.Types.TITLE and string.find(nameTag, "<p>") == nil then
				mButton.mToUpper = true
			end

			local nameTag2 = self.NameTag
			mButton:SetText(nameTag, nameTag2)
		end

		function list:Filter(p2)
			if
				p2.mParent ~= nil and not p2.mParent.mExpanded
				or not __wf_atom_7e8ad928(self.mCategoryMenu)
				and self:GetFilterBy() ~= nil
				and self:GetFilterBy() ~= 0
				and not (self.UTIL.IsValueInTable(p2.Categories, self:GetFilterBy()) or self.mIgnoreCategories)
			then
				return true
			end

			return self.AdditionalFilterFunction ~= nil and self.AdditionalFilterFunction(p2)
		end

		function list.UnequipCallback(object)
			if __wf_atom_7e8ad928(object.mMovie) then
				return
			end

			local focusedElement = object:GetFocusedElement()

			if focusedElement ~= nil then
				focusedElement.ItemSelectionData.CurrSelection = focusedElement.mUnequipItem.StoreItem
				list.mSelectedElement = focusedElement
				v.ItemSelectionGrid.mSelectedElement = focusedElement.mUnequipItem
				v.ItemSelectionGrid:FinishSelection(false)
				list.mElementDrawCallback(focusedElement)
				list:FocusElementById(focusedElement.Id)
			end
		end

		function list:SetExpanded(p2, mExpanded)
			p2.mExpanded = mExpanded

			if not mExpanded and p2.mChildren ~= nil then
				for _, v2 in ipairs(p2.mChildren) do
					self:SetExpanded(v2, mExpanded)
				end
			end

			self.TreeUpdate = true
		end

		function list.GetElementBottomLineId(_, data)
			if data.Type ~= module6.Types.TREE or #data.mChildren == 0 or not data.mExpanded then
				return data.Id
			end

			local v2 = data.mChildren[#data.mChildren]

			while v2.Type == module6.Types.TREE and #v2.mChildren > 0 and v2.mExpanded do
				v2 = v2.mChildren[#v2.mChildren]
			end

			return v2.Id
		end

		list._Redraw = list.Redraw

		function list:Redraw(p2, p3, p4, p5, p6)
			local count = #self.mUnfilteredElements
			local v2 = #self.mElements
			local v3 = self:GetFilterBy() == nil or p3

			if self.mVisibleElements == nil then
				v3 = v3 or self.mLastFilterBy ~= self:GetFilterBy() or count ~= v2
			end

			if v3 then
				if
					not __wf_atom_7e8ad928(self.mCategoryMenu)
					and self.mCategoryMenu.mHideEmptyCategories
					and not p6
				then
					self.mCategoryMenu:RemoveElements(true, true)

					for i = 1, #self.mUnfilteredCategories do
						self.mUnfilteredCategories[i].mClipName = nil

						if not (self.mUnfilteredCategories[i].Category == 0 or self.mCategoriesCount[self.mUnfilteredCategories[i].Category] ~= nil and self.mCategoriesCount[self.mUnfilteredCategories[i].Category] > 0) then
							continue
						end

						self.mUnfilteredCategories[i].mInitialized = false
						self.mCategoryMenu:AddElement(self.mUnfilteredCategories[i], true)
					end

					if self.mCategoryMenu.mPendingCategory == nil then
						local filterBy = self:GetFilterBy()

						if not self.mCategoryMenu:HasCategory(filterBy) then
							local elementInIndex = self.mCategoryMenu:GetElementInIndex(1)

							if __wf_atom_7e8ad928(elementInIndex) then
								filterBy = nil
							else
								filterBy = elementInIndex.Category
							end
						end

						if filterBy ~= nil then
							self.mCategoryMenu.mQueueInstantReposition = true

							if filterBy == self:GetFilterBy() then
								self.mCategoryMenu:Redraw(nil, true, true)
							else
								self.mFilterBy = nil
							end

							self:SetCategory(filterBy)
						end
					else
						self:SetCategory(self.mCategoryMenu.mPendingCategory)
						self.mCategoryMenu.mPendingCategory = nil
					end
				end

				local ids = {}
				self:_RunForAllElements(function(p7)
					table.insert(ids, p7.Id)
				end)
				self:_RemoveElements(true, true)

				for i = 1, count do
					__wf_atom_83c14687(0)
					self.mUnfilteredElements[i].mClipName = nil

					if not (__wf_atom_7e8ad928(self.mUnfilteredElements[i].mButton) or __wf_atom_7e8ad928(self.mUnfilteredElements[i].mButton.mButtons)) then
						self.mUnfilteredElements[i].mButton.mButtons = nil
					end

					if self:Filter(self.mUnfilteredElements[i]) then
						continue
					end

					self:AddElement(self.mUnfilteredElements[i], true, true)

					if self.TreeUpdate then
						self.mUnfilteredElements[i].mInterpolate = not self.UTIL.IsValueInTable(
							ids,
							self.mUnfilteredElements[i].Id
						)
					end
				end
			end

			self.mAllColors = {}
			self:_Redraw(p2, p3, p4)
			self.TreeUpdate = nil

			if v.CustListScrollBar ~= nil then
				local height = self:GetHeight()
				local v4 = height == 0 and 1 or self.mMaxVisibleHeight / height
				local v5 = v4 < 1
				local v6 = (v.CustListScrollBar.mTotalHeight == nil and 0 or v.CustListScrollBar:GetScrollValue() * (v.CustListScrollBar.mTotalHeight - self.mMaxVisibleHeight)) / (height - self.mMaxVisibleHeight)

				if v5 then
					v.CustListScrollBar:SetHeight(self.mMaxVisibleHeight + self.mScrollBarExtension, true)
				end

				self.mMovie:__wf_atom_7f57ab2f(v.mClipName, "CustomizationPanel.Scrollbar", 13, v5)
				v.CustListScrollBar.mTotalHeight = height

				function v.CustListScrollBar:GetMenuYAtScroll(p7)
					return list.mOriginalListYPos + (list.mMaxVisibleHeight - height) * p7
				end

				function v.CustListScrollBar.mScrollValueChangedCallback(p7, _)
					if v.CustListScrollBar.mEnabled then
						self.mMovie:__wf_atom_4c1c1986(
							v.mClipName,
							"CustomizationPanel.List",
							1,
							module.Round(self.mOriginalListYPos + (self.mMaxVisibleHeight - height) * p7)
						)
					end
				end

				v.CustListScrollBar.mVisibleProp = module.Ternary(v5, v4, 0.5)

				if p5 then
					v.CustListScrollBar:SetScrollValue(v6, false, true)
				else
					v.CustListScrollBar:SetScrollValue(0, false, true)
				end

				v.CustListScrollBar:SetEnabled(v5)
				v.CustListScrollBar:RedrawScrollBar()
				v.CustListScrollBar.mScrollStep = 1 / ((1 - v4) * (self:GetHowManyElements() + 1))
			end

			if self.mElementWidth ~= nil then
				self.mMovie:__wf_atom_e57658c2(
					v.mClipName .. ".CustomizationPanel.Scrollbar",
					0,
					self.mElementWidth + 10
				)
			end
		end

		function list:EnableCategories()
			if list.mCategoryOffsetAmount == nil then
				print("CL: Cannot enable categories due to missing required clips")
				return
			end

			local module9 = require("Lotus.Interface.Components.ThemedCategoriesMenu")
			self.mCategoryMenu = module9.Create(self.mMovie, self.mCategoryClipName)
			self.mCategoryMenu.mHideEmptyCategories = false
			self.mCategoryMenu.mUseOriginalDimensions = false
			self.mCategoryMenu.mPendingCategory = nil

			function self.mCategoryMenu:HasCategory(p2)
				local v2 = false
				self:RunForAllElements(function(p3)
					v2 = v2 or p3.Category == p2
				end)
				return v2
			end

			function self.mCategoryMenu.mOnSelectedCallback(p2)
				if self.mFilterBy ~= p2.Category then
					self:SetCategory_Internal(p2.Category)
				end
			end

			function self.mCategoryMenu.mElementDrawCallback(p2)
				local uiMaterial_DepthTestText = self.mMovie:__wf_atom_a224b472() and _T.UIMaterial_DepthTestText
					or _T.UIMaterial_PlainText
				self.mMovie:OverrideMaterial(p2.mClipName .. ".Label", uiMaterial_DepthTestText)
			end

			if self.mCategoryOffset then
				self.mMovie:__wf_atom_4c1c1986(v.mClipName, "CustomizationPanel", 1, self.mCategoryOffsetAmount)
			end

			self.mMovie:__wf_atom_2dedec1a(self.mCategoryClipName, 13, true)
			self.mMovie:__wf_atom_7f57ab2f(v.mClipName, "CustomizationPanel.CategoryBar", 13, not self.mCategoryHideBar)
		end

		function list:SetIdOnUnfiltered(list2, p2)
			if not p2.Id then
				local id = 0

				for i = 1, #list2 do
					__wf_atom_83c14687()

					if id < list2[i].Id then
						id = list2[i].Id
					end
				end

				p2.Id = id + 1
			end
		end

		function list:AddCategory(p2)
			if self.mCategoryMenu then
				if self.mCategoryMenu.mHideEmptyCategories then
					self:SetIdOnUnfiltered(self.mUnfilteredCategories, p2)
					table.insert(self.mUnfilteredCategories, p2)
				else
					self.mCategoryMenu:AddElement(p2, true)
				end
			end
		end

		function list:SetCategory(mPendingCategory)
			if self.mCategoryMenu then
				if self.mCategoryMenu:GetHowManyElements() == 0 and self.mCategoryMenu.mHideEmptyCategories then
					self.mCategoryMenu.mPendingCategory = mPendingCategory
					return
				end

				local id = nil
				self.mCategoryMenu:RunForAllElements(function(p2)
					if p2.Category == mPendingCategory then
						id = p2.Id
					end
				end)

				if id then
					if self.mFilterBy == nil then
						self.mCategoryMenu:Redraw(nil, true, true)
					end

					self.mCategoryMenu:SelectElementById(id)
				end
			end
		end

		function list:SetCategory_Internal(mFilterBy, p2, _)
			local v2 = self.mFilterBy == nil
			self.mFilterBy = mFilterBy

			if not v2 then
				v.mMenuStack = {}
				v:MenuStackChanged(nil, true)
				self:SetScroll(1, true)
				self:Redraw(p2, true, nil, nil, true)
			end
		end

		function list:GetFilterBy()
			return self.mFilterBy
		end

		function list:ToggleCategory(p2)
			if self.mCategoryMenu then
				self.mCategoryMenu.mMuteFocusSound = true
				local focusedElement = self.mCategoryMenu:GetFocusedElement()

				if
					self.mCategoryMenu.mSelectedElement
					and (focusedElement == nil or focusedElement.Id ~= self.mCategoryMenu.mSelectedElement.Id)
				then
					self.mCategoryMenu:FocusElementById(self.mCategoryMenu.mSelectedElement.Id)
				end

				self.mCategoryMenu:ToggleFocusedElement(p2)
				self.mCategoryMenu:SelectCurrentElement()
				self.mCategoryMenu.mMuteFocusSound = false
			end
		end

		function list:PreviousCategory()
			local v2 = nil

			if v.mState ~= v.State.CUSTOMIZATION then
				return v2
			end

			if
				Engine.IsPlayingWithController()
				and self.mCategoryMenu
				and self.mCategoryMenu:GetHowManyElements() > 0
			then
				local ternary = self.UTIL.Ternary(
					self.mCategoryMenu.mRootClip ~= nil,
					self.mCategoryMenu.mRootClip .. ".LeftBumper",
					"LeftBumper"
				)
				v2 = self.UTIL.CreateParticles(self.mMovie, ternary, _T.UIFx_LeftBumperPress, 0, 0)
			end

			self:ToggleCategory(self.UTIL.DECREMENT)
			return v2
		end

		function list:NextCategory()
			local v2 = nil

			if v.mState ~= v.State.CUSTOMIZATION then
				return v2
			end

			if
				Engine.IsPlayingWithController()
				and self.mCategoryMenu
				and self.mCategoryMenu:GetHowManyElements() > 0
			then
				local ternary = self.UTIL.Ternary(
					self.mCategoryMenu.mRootClip ~= nil,
					self.mCategoryMenu.mRootClip .. ".RightBumper",
					"RightBumper"
				)
				v2 = self.UTIL.CreateUIParticles(self.mMovie, ternary, _T.UIFx_RightBumperPress3d, 0, 0)
			end

			self:ToggleCategory(self.UTIL.INCREMENT)
			return v2
		end

		function list:SetWidth(mElementWidth)
			self.mElementWidth = mElementWidth
			self:Redraw(nil, true, true)
		end

		function list:UpdateVisRanges()
			local v2 = { self.VisibleRangeMaterial, self.TextVisibleRangeMaterial, self.RectangleVisibleRangeMaterial }

			if not __wf_atom_7e8ad928(self.VisibleRangeFadeIconMaterial) then
				table.insert(v2, self.VisibleRangeFadeIconMaterial)
			end

			if self.AdditionalVisRanges ~= nil and #self.AdditionalVisRanges > 0 then
				for i = 1, #self.AdditionalVisRanges do
					table.insert(v2, self.AdditionalVisRanges[i])
				end
			end

			local _, v3 = module.GetRootBasedPosition(self.mMovie, v.mClipName .. ".CustomizationPanel")
			local v4 = v3 + self.mOriginalListYPos
			local visibilityCenter = module.GetVisibilityCenter(self.mMovie, v4 + self.mMaxVisibleHeight / 2)
			local visibilitySize = module.GetVisibilitySize(self.mMovie, self.mMaxVisibleHeight)
			local visibilityFadeSize = module.GetVisibilityFadeSize(self.mMovie, 5)

			for _, v5 in ipairs(v2) do
				v5:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
				v5:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
				v5:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
			end
		end

		function list.RunEnabledChecks(object)
			object:RunForAllVisibleElements(function(object2)
				if object2.mButton ~= nil and object2.IsEnabledCheck ~= nil then
					object2.mButton:SetActive(object2:IsEnabledCheck())
				end
			end)
		end

		v.CustomizationList = list
		__wf_atom_86cbd68d(v.mMovie, v.mClipName .. ".CustomizationPanel.List.MenuItem.swapDepths", list.mInitialDepth)

		if mMovie2:__wf_atom_253d7085(mClipName2 .. ".CustomizationPanel.Scrollbar") then
			if p == nil then
				local module9 = require("EE.Interface.Components.ScrollBar")
				v.CustListScrollBar = module9.CreateScrollBar(
					v.mMovie,
					v.mClipName .. ".CustomizationPanel.Scrollbar",
					list.mMaxVisibleHeight,
					0.5
				)
				v.CustListScrollBar.mEnableSmoothScroll = true
				v.CustListScrollBar:HookUpCallbacks()
				v.CustListScrollBar:Initialize()
			else
				list:AttachScrollBar(mClipName2 .. ".CustomizationPanel.Scrollbar")

				function list.mScrollBar.mScrollValueChangedCallback(p2, p3)
					mMovie2:__wf_atom_f62a8704("CustListScrollValueChanged", { tostring(p2), (tostring(p3)) })
				end

				list:EnableSmoothScroll()
			end
		end
	end

	if mMovie2:__wf_atom_253d7085(mClipName2 .. ".ItemSelectionPanel") then
		v.ItemSelectionGrid = module8.CreateCategorizedGrid(
			mMovie2,
			mClipName2 .. ".ItemSelectionPanel.Menu.Item",
			3,
			4
		)
		v.ItemSelectionGrid.ElementWidth = 142
		v.ItemSelectionGrid.ElementHeight = 142
		v.ItemSelectionGrid.ElementDimBuffer = 24
		v.ItemSelectionGrid.Width = 550
		v.ItemSelectionGrid.Height = 700
		v.ItemSelectionGrid.mSelectedScale = 100
		v.ItemSelectionGrid.mScrollBarHorizontalOffset = v.ItemSelectionGrid.ElementWidth / 2 + 10
		v.ItemSelectionGrid:AttachScrollBar(mClipName2 .. ".ItemSelectionPanel.ScrollBar")
		v.ItemSelectionGrid:EnableSmoothScroll()

		if Engine.__wf_atom_2a979d69() then
			v.ItemSelectionGrid:EnableDragScrolling()
		end

		v.ItemSelectionGrid.mWrapAroundNavigation = false
		v.ItemSelectionGrid.mScrollAlwaysVisible = true
		v.ItemSelectionGrid.mPrevSelectedId = nil
		v.ItemSelectionGrid.mInitY = mMovie2:__wf_atom_5e6e15c8(mClipName2 .. ".ItemSelectionPanel", 1)
		v.ItemSelectionGrid.VisibleRangeMaterial = visibleRangeMaterial2
		v.ItemSelectionGrid.TextVisibleRangeMaterial = textVisibleRangeMaterial2
		v.ItemSelectionGrid.RectangleVisibleRangeMaterial = rectangleVisibleRangeMaterial2
		v.ItemSelectionGrid.ShadowVisibleRangeMaterial = shadowVisibleRangeMaterial
		v.ItemSelectionGrid.mUseCornerForSelected = true
		v.ItemSelectionGrid.mShowInfoPopup = true
		v.ItemSelectionGrid.mMuteFocusSound = true
		v.ItemSelectionGrid.TryThemed = true

		function v.ItemSelectionGrid:Update(_)
			self:UpdateScrollDrag(v.CustListScrollBar)
		end

		function v.ItemSelectionGrid:GetParentEnv()
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v2 = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v2)
				v2 += 1
			until mParentEnv.mMovie

			self.mParentEnv = mParentEnv
			return mParentEnv
		end

		function v.ItemSelectionGrid:HookupCallbacks()
			if Engine.__wf_atom_2a979d69() then
				self:SetCallbacks(
					"ItemSelectGridItemReleased",
					"ItemSelectGridItemFocused",
					"ItemSelectGridItemUnfocused",
					"ItemSelectGridItemPressed",
					nil,
					nil,
					"ItemSelectGridItemReleasedOutside"
				)
			else
				self:SetCallbacks(
					"ItemSelectGridItemReleased",
					"ItemSelectGridItemFocused",
					"ItemSelectGridItemUnfocused"
				)
			end

			local parentEnv = self:GetParentEnv()

			function parentEnv.ItemSelectGridItemReleased(p2)
				if not self.mMovie:Execute("IsInputBlocked", "") then
					local elementById = self:GetElementById((tonumber(p2)))

					if not (__wf_atom_7e8ad928(elementById) or elementById.Filler or elementById.Locked) then
						self:SelectElementById(tonumber(p2), true)
					end
				end
			end

			function parentEnv.ItemSelectGridItemReleasedOutside(_)
				if not self.mMovie:Execute("IsInputBlocked", "") then
					self:StopScrollDrag()
				end
			end

			function parentEnv.ItemSelectGridItemPressed(p2)
				if not self.mMovie:Execute("IsInputBlocked", "") then
					self:StartScrollDrag(p2)
				end
			end

			function parentEnv.ItemSelectGridItemFocused(p2)
				self:FocusElementById((tonumber(p2)))
			end

			function parentEnv.ItemSelectGridItemUnfocused(p2)
				self:UnfocusElementById((tonumber(p2)))
			end
		end

		function v.ItemSelectionGrid.PreviewCallback(object)
			if __wf_atom_7e8ad928(object.mMovie) then
				return
			end

			local focusedElement = object:GetFocusedElement()

			if not __wf_atom_7e8ad928(focusedElement) then
				object:SelectElementById(focusedElement.Id)
			end
		end

		function v.ItemSelectionGrid:Populate(currSelectionData, currSelectionElement)
			local mMovie = self.mMovie
			self.CurrSelectionElement = currSelectionElement
			self.CurrSelectionData = currSelectionData
			self:RemoveElements(true, true)
			self.mPrevSelectedId = nil

			if currSelectionData.VerticalFill then
				local _, v2 = module.GetProportionalScale(mMovie)
				local ternary = module.Ternary(
					currSelectionData.VerticalFillRatio ~= nil,
					currSelectionData.VerticalFillRatio,
					0.08
				)
				local y = module.TransformViewportToPixelCoordinates(mMovie, {
					x = 0,
					y = ternary / 2 * (v2 / 100)
				}).y
				local v3 = y - mMovie:__wf_atom_5e6e15c8(v.mClipName, 3)
				mMovie:__wf_atom_4c1c1986(v.mClipName, "ItemSelectionPanel", 1, v3)
				self.Height = module.TransformViewportToPixelCoordinates(mMovie, {
					x = 0,
					y = 1 - ternary / 2 * (v2 / 100)
				}).y - y + 16 - 2
			else
				mMovie:__wf_atom_4c1c1986(v.mClipName, "ItemSelectionPanel", 1, self.mInitY)
			end

			self.Width = currSelectionData.GridWidth or self.Width
			module4.InitializeGridItem(mMovie, self)
			local v2 = self.mRows * self.mRowSeparation - 11
			local v3 = self.mColumns * self.mColumnSeparation
			mMovie:__wf_atom_4c1c1986(v.mClipName, "ItemSelectionPanel.ScrollBar", 0, v3)
			self.mScrollBar:SetHeight(self:CalculateScrollBarHeight(-23))

			if not __wf_atom_7e8ad928(self.mSearchBox) then
				mMovie:__wf_atom_e57658c2(self.mSearchBox.mClipName, 0, v3 - self.mSearchBox.mWidth - 11)
			end

			local visibilitySize = module.GetVisibilitySize(mMovie, v2)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v.mClipName .. ".ItemSelectionPanel", 3)
			local visibilityCenter = module.GetVisibilityCenter(mMovie, v2 / 2 + __wf_atom_5e6e15c8)
			visibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			visibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			textVisibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			textVisibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			rectangleVisibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			rectangleVisibleRangeMaterial2:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			shadowVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			shadowVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			shadowVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0)
			local itemsFunction = currSelectionData.GetItemsFunction(currSelectionElement)
			local count = #itemsFunction
			math.max(self.mColumns * self.mRows, math.ceil(count / self.mColumns) * self.mColumns)

			for i = 1, count do
				if itemsFunction[i].StoreItem == nil then
					itemsFunction[i].Name = ""
				else
					itemsFunction[i] = module5.GetStoreItemInfo(
						mMovie,
						itemsFunction[i].StoreItem,
						{
							AppendInfo = itemsFunction[i],
							OverrideExisting = itemsFunction[i].OverrideExisting
						},
						nil,
						nil,
						true
					)
					itemsFunction[i].Count = module.Ternary(itemsFunction[i].Owned, itemsFunction[i].Count, nil)
					itemsFunction[i].SearchCache = module5.GetSearchString(
						mMovie,
						itemsFunction[i].StoreItem,
						itemsFunction[i].CustomName,
						nil,
						itemsFunction[i]
					)
				end

				if not itemsFunction[i].IsNone then
					continue
				end

				itemsFunction[i].Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Cosmetics_None", false)
				itemsFunction[i].Icon = itemsFunction[i].NoneIconOverride
			end

			if not currSelectionData.SkipSort then
				table.sort(itemsFunction, function(a, b)
					if a.IsNone then
						return true
					end

					if b.IsNone then
						return false
					end

					if a.Owned == b.Owned then
						return a.Name < b.Name
					end

					return a.Owned == true
				end)
			end

			local elementsMatch = currSelectionData.ElementsMatch or function(data)
				local ternary = module.Ternary(not __wf_atom_7e8ad928(data.Comparator), data.Comparator, data.StoreItem)
				local mHullSkin = not data.Filler

				if mHullSkin then
					if ternary == currSelectionData.CurrSelection then
						mHullSkin = currSelectionElement.mHullSkin or data.UID == currSelectionData.UID
					else
						mHullSkin = false
					end
				end

				return mHullSkin
			end
			self.mInitSelectedId = nil
			local v4 = false

			for i = 1, #itemsFunction do
				itemsFunction[i].Id = nil
				local v5 = self:AddElement(itemsFunction[i], true)

				if v4 or not elementsMatch(v5) then
					continue
				end

				self.mInitSelectedId = v5.Id
				v4 = true
			end

			self:Redraw()
		end

		v.ItemSelectionGrid._ItemSelectionGrid_OnFilteredElementsReady = v.ItemSelectionGrid.OnFilteredElementsReady

		function v.ItemSelectionGrid:OnFilteredElementsReady()
			self:_ItemSelectionGrid_OnFilteredElementsReady()
			local mPrevSelectedId = nil
			local flag = false

			if self.mInitSelectedId == nil then
				if self.mPrevSelectedId ~= nil then
					mPrevSelectedId = self.mPrevSelectedId
				end
			else
				mPrevSelectedId = self.mInitSelectedId
				self.mInitSelectedId = nil
				flag = true
			end

			if mPrevSelectedId ~= nil then
				local elementIndexById = self:GetElementIndexById(mPrevSelectedId)

				if elementIndexById ~= nil then
					if flag then
						self:SetScroll(elementIndexById - (elementIndexById - 1) % self.mColumns, true)
					end

					self.mPendingSelectIndex = elementIndexById
				end
			end
		end

		v.ItemSelectionGrid._ItemSelectionGrid_Redraw = v.ItemSelectionGrid.Redraw

		function v.ItemSelectionGrid:Redraw(p2, p3, p4, p5, p6)
			self:_ItemSelectionGrid_Redraw(p2, p3, p4, p5, p6)

			if self.mPendingSelectIndex ~= nil then
				self.mMuteSelectSound = true
				self:SelectElement(self.mPendingSelectIndex)
				self.mMuteSelectSound = false
				self.mPendingSelectIndex = nil
			end
		end

		function v.ItemSelectionGrid:FinishSelection(p2)
			if not (__wf_atom_7e8ad928(v.CustomizationList) or __wf_atom_7e8ad928(v.CustomizationList.mSelectedElement)) then
				local storeItem = nil
				local unfilteredElementById = nil

				if not p2 then
					if __wf_atom_7e8ad928(self.mSelectedElement) then
						if self.mPrevSelectedId ~= nil then
							unfilteredElementById = self:GetUnfilteredElementById(self.mPrevSelectedId)
						end
					else
						unfilteredElementById = self.mSelectedElement
					end

					if not __wf_atom_7e8ad928(unfilteredElementById) then
						storeItem = unfilteredElementById.StoreItem
					end

					module.PlaySound(_G.UISound_SweetenerTwo)
				end

				if v.CustomizationList.mSelectionDoneCallback ~= nil then
					v.CustomizationList.mSelectionDoneCallback(
						p2,
						storeItem,
						unfilteredElementById,
						v.CustomizationList.mSelectedElement
					)
				end

				v.CustomizationList.mSelectedElement.ItemSelectionData.OnSelectionDoneFunction(
					p2,
					storeItem,
					unfilteredElementById
				)
			end

			v:SetState(v.State.CUSTOMIZATION)
			self.mMovie:Execute("UpdateButtons", "")
		end

		function v.ItemSelectionGrid:ConfirmSelection()
			self:FinishSelection(false)
			local storeItem = nil
			local v2 = v.CustomizationList.mSelectedElement == nil
				or v.CustomizationList.mSelectedElement.SkipConfirmUpdate

			if __wf_atom_7e8ad928(self.mSelectedElement) then
				if self.mPrevSelectedId ~= nil then
					local unfilteredElementById = self:GetUnfilteredElementById(self.mPrevSelectedId)

					if not __wf_atom_7e8ad928(unfilteredElementById) then
						storeItem = unfilteredElementById.StoreItem
					end
				end
			else
				storeItem = self.mSelectedElement.StoreItem
			end

			if not v2 then
				v.CustomizationList.mSelectedElement.ItemSelectionData.CurrSelection = storeItem
				v.CustomizationList.mElementDrawCallback(v.CustomizationList.mSelectedElement)
			end

			local mGoBackCallback = v.CustomizationList.mGoBackCallback

			if mGoBackCallback ~= nil then
				mGoBackCallback()
			end
		end

		function v.ItemSelectionGrid:GetSelectionStruct(data, p2)
			local v2 = {}

			if __wf_atom_7e8ad928(data) or data.Disabled then
				return nil
			end

			if data.StoreItem == nil or data.IsNone or data.Owned or data.NotOwned == false or data.mPurchased then
				table.insert(v2, {
					Label = "/Lotus/Language/Menu/ItemSelection_Equip",
					CallOut = "MENU_SELECT",
					CallBack = function()
						self:ConfirmSelection()
					end
				})

				if not (__wf_atom_7e8ad928(data.StoreItem) or _T.HidePurchaseInfo) then
					local v3 = WeakResource("/Lotus/Upgrades/Skins/Operator/Heads/BaseHead")

					if __wf_atom_7e8ad928(data.Type) or not data.Type:IsA(v3) then
						table.insert(v2, {
							Label = "/Lotus/Language/Menu/ProfilePicture_ViewPurchaseDialog",
							CallOut = "MENU_RTHUMB",
							CallBack = function()
								v:Purchase()
							end
						})
					end
				end
			elseif data.CanPreview then
				table.insert(v2, {
					Label = "/Lotus/Language/OstronCrafting/Crafting_Preview_NoIcon",
					CallOut = "MENU_SELECT",
					CallBack = function()
						self:FinishSelection(false)
					end
				})
			else
				table.insert(v2, {
					Label = "/Lotus/Language/Menu/Global_BuyItem",
					CallOut = "MENU_SELECT",
					CallBack = function()
						v:Purchase()
					end
				})
			end

			if p2 then
				return v2[1].CallBack
			end

			return v2
		end

		function v.ItemSelectionGrid.mClipCreatedCallback(p2, _)
			module4.OnGridItemCreated(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, p2)
		end

		function v.ItemSelectionGrid.mOnFocusedCallback(data)
			if data.mClipName == nil or data.Filler then
				return
			end

			local isSelected = v.ItemSelectionGrid.mSelectedElement ~= nil
				and v.ItemSelectionGrid.mSelectedElement.Id == data.Id
			module4.OnGridItemFocusChanged(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, data, {
				IsFocused = true,
				IsSelected = isSelected,
				ShowToolTip = data.ShowToolTip,
				ShowInfoPopup = v.ItemSelectionGrid.mShowInfoPopup and not data.IsNone
			})
		end

		function v.ItemSelectionGrid.mOnUnfocusedCallback(data)
			if data.mClipName == nil or data.Filler then
				return
			end

			local isSelected = v.ItemSelectionGrid.mSelectedElement ~= nil
				and v.ItemSelectionGrid.mSelectedElement.Id == data.Id
			module4.OnGridItemFocusChanged(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, data, {
				IsFocused = false,
				IsSelected = isSelected,
				ShowToolTip = data.ShowToolTip,
				ShowInfoPopup = v.ItemSelectionGrid.mShowInfoPopup
			})
		end

		function v.ItemSelectionGrid.mOnSelectedCallback(data)
			if data.Filler or data.Locked == true then
				return
			end

			v.ItemSelectionGrid.mMovie:Execute("UpdateButtons", "")

			if v.ItemSelectionGrid.mPrevSelectedId == data.Id then
				if not (__wf_atom_7e8ad928(v.CustomizationList) or __wf_atom_7e8ad928(v.CustomizationList.mSelectedElement) or __wf_atom_7e8ad928(v.CustomizationList.mSelectedElement.ItemSelectionData.OnItemReselectedFunction)) then
					v.CustomizationList.mSelectedElement.ItemSelectionData.OnItemReselectedFunction(data.StoreItem)
				end
			else
				local elementById = v.ItemSelectionGrid:GetElementById(v.ItemSelectionGrid.mPrevSelectedId)

				if not (__wf_atom_7e8ad928(elementById) or __wf_atom_7e8ad928(elementById.mClipName)) then
					module4.OnGridItemFocusChanged(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, elementById, {
						IsFocused = false,
						IsSelected = false,
						ShowToolTip = data.ShowToolTip,
						ShowInfoPopup = v.ItemSelectionGrid.mShowInfoPopup
					})
				end

				if not __wf_atom_7e8ad928(v.CustomizationList) then
					if v.CustomizationList.mItemSelectedCallback ~= nil then
						v.CustomizationList.mItemSelectedCallback(
							data.StoreItem,
							data,
							v.CustomizationList.mSelectedElement
						)
					end

					if not __wf_atom_7e8ad928(v.CustomizationList.mSelectedElement) then
						v.CustomizationList.mSelectedElement.ItemSelectionData.OnItemSelectedFunction(
							data.StoreItem,
							data,
							v.CustomizationList.mSelectedElement
						)
					end
				end

				v.ItemSelectionGrid.mPrevSelectedId = data.Id
			end

			local focusedElement = v.ItemSelectionGrid:GetFocusedElement()
			local isFocused = focusedElement ~= nil and focusedElement.Id == data.Id
			module4.OnGridItemFocusChanged(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, data, {
				IsFocused = isFocused,
				IsSelected = true,
				ShowToolTip = data.ShowToolTip,
				ShowInfoPopup = v.ItemSelectionGrid.mShowInfoPopup
			})
		end

		function v.ItemSelectionGrid.mOnDoubleClickCallback(p2)
			local selectionStruct = v.ItemSelectionGrid:GetSelectionStruct(p2, true)

			if not __wf_atom_7e8ad928(selectionStruct) then
				selectionStruct()
			end
		end

		function v.ItemSelectionGrid.mElementDrawCallback(data)
			if data.mClipName == nil then
				return
			end

			local focusedElement = v.ItemSelectionGrid:GetFocusedElement()
			local isFocused

			if focusedElement == nil then
				isFocused = false
			else
				isFocused = focusedElement.Id == data.Id
			end

			local isSelected = not data.Filler
				and (v.ItemSelectionGrid.mSelectedElement ~= nil and v.ItemSelectionGrid.mSelectedElement.Id == data.Id or data.Selected)
			local v2 = {
				NameOverride = data.CustomName,
				HidePrice = data.Owned or data.CanPreview,
				IsFocused = isFocused,
				IsSelected = isSelected,
				HideCountThreshold = data.HideCountThreshold,
				Locked = data.Locked,
				LockedMsg = data.LockedMsg
			}

			if v2.Locked and v2.LockedMsg == nil then
				v2.HideLockLabel = true
				v2.LockedIcon = lockedIcon
				v2.LockedIconY = 0
			end

			module4.DrawGridItem(v.ItemSelectionGrid.mMovie, v.ItemSelectionGrid, data, v2)
		end

		function v.ItemSelectionGrid:onViewportSizeChanged(_, _)
			if v.mState == v.State.ITEM_SELECTION and self.CurrSelectionData then
				self:Populate(self.CurrSelectionData, self.CurrSelectionElement)
			end
		end

		function v.ItemSelectionGrid.AdditionalFilterFunction(p2)
			local mSearchBox = v.ItemSelectionGrid.mSearchBox

			if
				__wf_atom_7e8ad928(mSearchBox)
				or not mSearchBox.mActive
				or mSearchBox.mLabel == nil
				or mSearchBox.mLabel == ""
				or p2.SearchCache == nil
			then
				return false
			end

			return string.find(p2.SearchCache, __wf_atom_d99ae0ec(mSearchBox.mLabel), 1, true) == nil
		end

		if mMovie2:__wf_atom_253d7085(mClipName2 .. ".ItemSelectionPanel.SearchBox") then
			local __wf_atom_8e9ac384 = mMovie2:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
			local module9 = require("Lotus.Interface.Components.ThemedInputField")
			v.ItemSelectionGrid.mSearchBox = module9.Create(
				mMovie2,
				mClipName2 .. ".ItemSelectionPanel.SearchBox",
				nil,
				nil,
				"<MENU_LTHUMB>"
			)
			v.ItemSelectionGrid.mSearchBox:SetType(
				v.ItemSelectionGrid.mSearchBox.TYPE.PLAIN,
				__wf_atom_8e9ac384,
				__wf_atom_8e9ac384
			)
			v.ItemSelectionGrid.mSearchBox.mMinSize = 200
			v.ItemSelectionGrid.mSearchBox.mMaxSize = 200
			v.ItemSelectionGrid.mSearchBox.mTextBuffer = 4
			v.ItemSelectionGrid.mSearchBox.mAltButtonIcon = _G.UITexture_Search
			v.ItemSelectionGrid.mSearchBox.mAltButtonVisible = true
			v.ItemSelectionGrid.mSearchBox.mUnfocusedUnderlineColorOverride = nil
			v.ItemSelectionGrid.mSearchBox.BaseInputFieldTextChanged = v.ItemSelectionGrid.mSearchBox.InputFieldTextChanged

			function v.ItemSelectionGrid.mSearchBox:InputFieldTextChanged(p2)
				local mLabel = self.mLabel
				self:BaseInputFieldTextChanged(p2)
				local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

				if self.mAltButtonicon ~= uiTexture_Search then
					self.mAltButtonicon = uiTexture_Search
					self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
				end

				if v.mState == v.State.ITEM_SELECTION and mLabel ~= self.mLabel and v.ItemSelectionGrid ~= nil then
					v.ItemSelectionGrid.mMuteGridOpenSound = true
					v.ItemSelectionGrid:Redraw(nil, true, true)
					v.ItemSelectionGrid.mMuteGridOpenSound = false
				end
			end

			v.ItemSelectionGrid.mSearchBox.BaseOnGamepadTransition = v.ItemSelectionGrid.mSearchBox.OnGamepadTransition

			function v.ItemSelectionGrid.mSearchBox:OnGamepadTransition()
				self:BaseOnGamepadTransition()
				local mAltButtonVisible = not Engine.IsPlayingWithController()
				self.mAltButtonVisible = mAltButtonVisible
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
			end

			v.ItemSelectionGrid.mSearchBox:SetHint("/Lotus/Language/Menu/SearchPrompt")
			v.ItemSelectionGrid.mSearchBox:Redraw()
			v.ItemSelectionGrid.mSearchBox:SetActive(false)
			mMovie2:__wf_atom_7f57ab2f(mClipName2, "ItemSelectionPanel.SearchBox", 13, false)
		end
	end

	function v.SetItemSelectionSearchBox(p2, p3)
		if __wf_atom_7e8ad928(p2.ItemSelectionGrid) or __wf_atom_7e8ad928(p2.ItemSelectionGrid.mSearchBox) then
			return
		end

		p2.ItemSelectionGrid.mSearchBox:SetActive(p3)
		p2.mMovie:__wf_atom_2dedec1a(p2.ItemSelectionGrid.mSearchBox.mClipName, 13, p3)
	end

	function v:UpdateVisRanges()
		if v.mState == v.State.ITEM_SELECTION and not __wf_atom_7e8ad928(self.ItemSelectionGrid) then
			self.ItemSelectionGrid:onViewportSizeChanged()
		end

		if not __wf_atom_7e8ad928(self.CustomizationList) then
			self.CustomizationList:UpdateVisRanges()
		end
	end

	function v:SetState(mState)
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "CustomizationPanel", 13, mState == self.State.CUSTOMIZATION)
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ItemSelectionPanel", 13, mState == self.State.ITEM_SELECTION)
		self.mState = mState

		if
			self.mState == self.State.CUSTOMIZATION
			and not (__wf_atom_7e8ad928(self.ItemSelectionGrid) or __wf_atom_7e8ad928(self.ItemSelectionGrid.mSearchBox))
		then
			self.ItemSelectionGrid.mSearchBox:SetText("")
		end

		if not __wf_atom_7e8ad928(self.StateChangedCallBack) then
			self.StateChangedCallBack(self.mState)
		end
	end

	function v:OnBuyItemResult(p2, p3)
		if p2 and not (p3 or __wf_atom_7e8ad928(self.ItemSelectionGrid)) then
			self.ItemSelectionGrid:ConfirmSelection()
		end

		if not __wf_atom_7e8ad928(self.mChildMovie) then
			self.mChildMovie:Execute("TransitionOut", "")
		end
	end

	function v:Purchase()
		if
			__wf_atom_7e8ad928(_G.UIMovie_DetailedPurchaseDialog)
			or __wf_atom_7e8ad928(self.ItemSelectionGrid.mSelectedElement)
		then
			return
		end

		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = self.ItemSelectionGrid.mSelectedElement.StoreItem },
			CALLBACK = function(p2, _, p3)
				self:OnBuyItemResult(p2, p3)
			end,
			HIDE_RELATED = self.DPDHideRelated
		}
		self.mChildMovie = self.mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
		self.mChildMovie:Execute("DisableDiorama", "true")
		self.mChildMovie:Execute("SetIgnoreTopMenu", "true")
		self.mChildMovie:__wf_atom_0cf0fdbe(0.9)
	end

	v.mMenuStack = {}

	function v:MenuStackChanged(p2, p3)
		if p2 == nil then
			table.remove(self.mMenuStack)
			p2 = self.mMenuStack[#self.mMenuStack] or "mRoot"
		else
			table.insert(self.mMenuStack, p2)
		end

		if self.mMenuStackChangedCallback ~= nil then
			self.CustomizationList:RemoveElements(true, true)
			self.mMenuStackChangedCallback(p2, p3)
		end
	end

	function v:Back()
		if self.mState == self.State.ITEM_SELECTION then
			self.ItemSelectionGrid:FinishSelection(true)
			return true
		end

		local mSelectedElement = self.CustomizationList.mSelectedElement

		if
			mSelectedElement ~= nil
			and mSelectedElement.Type == module6.Types.DROP_DOWN
			and mSelectedElement.DropDownMenu ~= nil
			and mSelectedElement.DropDownMenu:IsVisible()
		then
			mSelectedElement.DropDownMenu:ArrowPressed()
			return true
		end

		if #self.mMenuStack > 0 then
			self:MenuStackChanged()
			return true
		else
			return false
		end
	end

	function v.ResetDefaults()
		v.CustomizationList:RunForAllElements(function(p2)
			p2.mButton:SetDefault()
		end)
	end

	function v.RandomizeAll()
		v.CustomizationList:RunForAllElements(function(p2)
			p2.mButton:Randomize()
		end)
	end

	function v.UpdateButtons(data, p2)
		local result = p2 == nil and {} or p2

		if data.mState == data.State.CUSTOMIZATION then
			if data.mShowCosmeticButtons then
				table.insert(result, {
					Label = "/Lotus/Language/Menu/Cosmetics_ResetDefaults",
					CallBack = v.ResetDefaults,
					CallOut = "MENU_GENERIC1"
				})
				table.insert(result, {
					Label = "/Lotus/Language/Menu/Cosmetics_RandomizeAll",
					CallBack = v.RandomizeAll,
					CallOut = "MENU_GENERIC2"
				})
				return result
			end
		elseif data.mState == data.State.ITEM_SELECTION and data.ItemSelectionGrid.mSelectedElement ~= nil then
			local selectionStruct = data.ItemSelectionGrid:GetSelectionStruct(data.ItemSelectionGrid.mSelectedElement)

			if selectionStruct ~= nil then
				for i = 1, #selectionStruct do
					table.insert(result, selectionStruct[i])
				end
			end
		end

		return result
	end

	function v.Scroll(data, p2)
		local custListScrollBar = nil

		if data.mState == data.State.CUSTOMIZATION then
			custListScrollBar = data.CustListScrollBar
		elseif data.mState == data.State.ITEM_SELECTION then
			custListScrollBar = data.ItemSelectionGrid.mScrollBar
		end

		if __wf_atom_7e8ad928(custListScrollBar) then
			return
		end

		custListScrollBar:ScrollByStep(tonumber(p2), _G.UISound_Scroll)
	end

	function v.OnStyleChanged(data)
		data.CustomizationList:RunForAllElements(function(p2)
			data.CustomizationList:UpdateColors(p2)
		end)

		if __wf_atom_7e8ad928(data.CustomizationList.mScrollBar) then
			if not __wf_atom_7e8ad928(data.CustListScrollBar) then
				data.CustListScrollBar:UpdateColors()
			end
		else
			data.CustomizationList.mScrollBar:UpdateColors()
		end

		local mCategoryMenu = data.CustomizationList.mCategoryMenu

		if not __wf_atom_7e8ad928(mCategoryMenu) then
			mCategoryMenu:RunForAllElements(function(p2)
				mCategoryMenu:UpdateColors(p2)
			end)
		end

		if data.mState == data.State.ITEM_SELECTION then
			data.ItemSelectionGrid:RunForAllVisibleElements(function(p2)
				local focusedElement = data.ItemSelectionGrid:GetFocusedElement()
				local v2

				if focusedElement == nil then
					v2 = false
				else
					v2 = focusedElement.Id == p2.Id
				end

				local v3 = data.ItemSelectionGrid.mSelectedElement ~= nil
					and data.ItemSelectionGrid.mSelectedElement.Id == p2.Id
				data.ItemSelectionGrid:UpdateColors(p2, v2, v3)
			end)

			if not (__wf_atom_7e8ad928(data.ItemSelectionGrid) or __wf_atom_7e8ad928(data.ItemSelectionGrid.mScrollBar)) then
				data.ItemSelectionGrid.mScrollBar:UpdateColors()
			end
		end
	end

	function v.Up(data)
		if data.mState == data.State.ITEM_SELECTION and not __wf_atom_7e8ad928(data.ItemSelectionGrid) then
			data.ItemSelectionGrid:FocusElementInDirection(data.ItemSelectionGrid.UP, true)
		elseif data.mState == data.State.CUSTOMIZATION then
			__wf_atom_7e8ad928(data.CustomizationList)
		end
	end

	function v.Down(data)
		if data.mState == data.State.ITEM_SELECTION and not __wf_atom_7e8ad928(data.ItemSelectionGrid) then
			data.ItemSelectionGrid:FocusElementInDirection(data.ItemSelectionGrid.DOWN, true)
		elseif data.mState == data.State.CUSTOMIZATION then
			__wf_atom_7e8ad928(data.CustomizationList)
		end
	end

	function v.Left(data)
		if data.mState == data.State.ITEM_SELECTION and not __wf_atom_7e8ad928(data.ItemSelectionGrid) then
			data.ItemSelectionGrid:FocusElementInDirection(data.ItemSelectionGrid.LEFT, true)
		elseif data.mState == data.State.CUSTOMIZATION and not __wf_atom_7e8ad928(data.CustomizationList) then
			local focusedElement = data.CustomizationList:GetFocusedElement()

			if not __wf_atom_7e8ad928(focusedElement) then
				if focusedElement.Type == module6.Types.VALUE_SELECTOR then
					return
				end

				if focusedElement.Type == module6.Types.TOGGLE then
					return
				else
					local _ = focusedElement.Type == module6.Types.TREE
				end
			end
		end
	end

	function v.Right(data)
		if data.mState == data.State.ITEM_SELECTION and not __wf_atom_7e8ad928(data.ItemSelectionGrid) then
			data.ItemSelectionGrid:FocusElementInDirection(data.ItemSelectionGrid.RIGHT, true)
		elseif data.mState == data.State.CUSTOMIZATION and not __wf_atom_7e8ad928(data.CustomizationList) then
			local focusedElement = data.CustomizationList:GetFocusedElement()

			if not __wf_atom_7e8ad928(focusedElement) then
				if focusedElement.Type == module6.Types.VALUE_SELECTOR then
					return
				end

				if focusedElement.Type == module6.Types.TOGGLE then
					return
				else
					local _ = focusedElement.Type == module6.Types.TREE
				end
			end
		end
	end

	function v.Shutdown(p2)
		if not __wf_atom_7e8ad928(p2.mChildMovie) then
			p2.mChildMovie:Close()
		end
	end

	v:SetState(v.State.CUSTOMIZATION)
	v.ItemSelectionGrid:HookupCallbacks()
	return v
end