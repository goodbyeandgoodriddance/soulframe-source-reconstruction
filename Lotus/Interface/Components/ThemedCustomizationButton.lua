module(..., package.seeall)
Types = {
	BUTTON = 1,
	ITEM_SELECTION = 2,
	COLOR = 3,
	VALUE_SELECTOR = 4,
	CHECKBOX = 5,
	DROP_DOWN = 6,
	TOGGLE = 7,
	TREE = 8,
	TITLE = 9,
	BUTTON_LIST = 10
}
IconTypes = {
	RENAME = 1,
	OPEN_GRID = 2,
	UNDO = 3,
	RESET = 4,
	RANDOMIZE = 5,
	DEFAULT_COLOR = 6,
	CHECKMARK = 7,
	CROSS = 8,
	GRIP = 9,
	ARROW = 10,
	COPY = 11,
	NO_ITEM = 12
}
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.Components.ThemedButton")
local module7 = require("Lotus.Interface.Components.ThemedSlider")
local module8 = require("Lotus.Interface.Components.ThemedCheckbox")
local module9 = require("Lotus.Interface.Components.ThemedToggle")
local module10 = require("Lotus.Interface.Components.DropDownMenu")
local module11 = require("Lotus.Interface.Components.ThemedProgressBar")
local UITexture_SettingsIcons = _G.UITexture_SettingsIcons

function Create(object, p, p2, object2, object3, mSelectedElement)
	local v = module6.Create(object, p, p2)

	local function fn(mColorRegion)
		local mActiveColors = object2.mActiveColors

		if not __wf_atom_7e8ad928(mActiveColors) and mActiveColors:Initialized(mColorRegion) then
			return (mActiveColors:GetColor(mColorRegion):__wf_atom_dcecedb0())
		end

		if
			__wf_atom_7e8ad928(object2.mActiveColorSlotList)
			or __wf_atom_7e8ad928(object2.mActiveColorSlotList[mColorRegion])
		then
			if __wf_atom_7e8ad928(object2.mActiveColorList) then
				return nil
			end

			return object2.mActiveColorList[mColorRegion]
		else
			return object2.mActiveColorSlotList[mColorRegion][mSelectedElement.ColorSlot]
		end
	end

	v.mInitLabelLeading = object:__wf_atom_5e6e15c8(p .. ".Label", 78)
	v.mDesc = ""
	v.mMinSize = 448
	v.mMaxSize = 448
	v.mIconPadding = 4
	v.mTextPadding = 12
	v.mIconWidthMultiplier = 1
	v.mIconHeightMultiplier = 1
	v.mBigButtonTextPadding = 20
	v.mMultiline = false
	v.ComponentSetActive = v.SetActive

	function v:SetActive(p3)
		self:ComponentSetActive(p3)

		if self.mToggle ~= nil then
			self.mToggle:SetActive(p3)
		end

		if self.mCheckbox ~= nil then
			self.mCheckbox:SetActive(p3 and not self.mDisableCheckbox)
		end

		if self.mSlider ~= nil then
			self.mSlider:SetActive(p3 and not self.mDisableSlider)
		end
	end

	function v:OnGamepadTransition()
		if
			self.mMinSize ~= self.mMaxSize
			or self.mWidth == nil
			or self.mMinSize ~= nil and self.mWidth < self.mMinSize
			or self.mMaxSize ~= nil and self.mWidth > self.mMaxSize
		then
			self:Resize()
		end
	end

	v.ComponentInterpolate = v.Interpolate

	function v.Interpolate(object4, p3)
		object4:ComponentInterpolate(p3)
		local mMovie = object4.mMovie
		local mClipName = object4.mClipName
		local mFocused = object4.mFocused
		local ternary = module.Ternary
		__wf_atom_ec43d06e(
			mMovie,
			mClipName .. ".Highlight",
			2,
			{ 12, 15 },
			{ ternary(mFocused, 40, 0), ternary(mFocused, 60, 1) },
			ternary(p3, 0, 0.35)
		)
		__wf_atom_ec43d06e(
			mMovie,
			mClipName .. ".Icon",
			2,
			{ 14, 15 },
			{
				ternary(mFocused, object4.mIconWidth * 1.15, object4.mIconWidth),
				ternary(mFocused, object4.mIconHeight * 1.15, object4.mIconHeight)
			},
			ternary(p3, 0, 0.35)
		)
	end

	function v.TrySetDrag(p3, p4)
		for i = 1, #p3.mButtons do
			local mButton = p3.mButtons[i]

			if mButton.mColorRegion == nil then
				continue
			end

			mButton:__wf_atom_9789043b(p4)
			break
		end
	end

	v.ComponentTrySetFocus = v.TrySetFocus

	function v:TrySetFocus(p3)
		self:ComponentTrySetFocus(p3)

		for i = 1, #self.mButtons do
			local mButton = self.mButtons[i]

			if self.mType ~= Types.COLOR or mButton.mColorRegion ~= nil then
				mButton:ComponentTrySetFocus(p3)
			end
		end

		for i = 1, #self.mAllColors do
			if self.mCopyColorSlot == nil or self.mAllColors[i].mCopyColorSlot == self.mCopyColorSlot then
				self.mAllColors[i]:ComponentTrySetFocus(p3)
			end
		end
	end

	v.ComponentSetFocus = v.SetFocus

	function v.SetFocus(object4, p3)
		object4:ComponentSetFocus(p3)

		if p3 then
			if object4.mShowInfoPopup == false then
				if not __wf_atom_7e8ad928(object4.mContextInfo) then
					local mContextInfo = object4.mContextInfo
					local __wf_atom_5e6e15c8 = object4.mMovie:__wf_atom_5e6e15c8(object4.mClipName, 2)
					local __wf_atom_5e6e15c8_2 = object4.mMovie:__wf_atom_5e6e15c8(object4.mClipName, 3)
					module2.SetItemInfoPopupRect(
						object4.mMovie,
						mContextInfo,
						__wf_atom_5e6e15c8 + object4.mWidth / 2,
						__wf_atom_5e6e15c8_2 + object4.mHeight / 2,
						object4.mWidth,
						object4.mHeight
					)
					_T.ContextMenu_Data = mContextInfo
					_T.ContextMenu_Grid = object2
				end
			else
				local appendInfo

				if object4.mInfoPopupInfo ~= nil then
					appendInfo = { AppendInfo = {} }

					for k, v2 in pairs(object4.mInfoPopupInfo) do
						appendInfo.AppendInfo[k] = v2
					end

					if appendInfo.AppendInfo.OverrideExisting ~= nil then
						appendInfo.OverrideExisting = appendInfo.AppendInfo.OverrideExisting
					end
				end

				if object4.mType == Types.ITEM_SELECTION then
					if object4.mItemSelectionData == nil or object4.mItemSelectionData.CurrSelection == nil then
						__wf_atom_f2daf912("missing current item selection data")
					else
						appendInfo = module5.GetStoreItemInfo(
							object4.mMovie,
							object4.mItemSelectionData.CurrSelection,
							appendInfo,
							nil,
							nil,
							true
						)
						appendInfo.CanPreview = object4.mItemSelectionData.IsPreview

						if appendInfo.MetaData == nil then
							appendInfo.MetaData = {}
						end

						appendInfo.MetaData.HidePrice = object4.mItemSelectionData.HidePrice
					end
				elseif
					object4.mType == Types.BUTTON
					and not __wf_atom_7e8ad928(object4.mStoreItem)
					and (object4.mInfoPopupInfo == nil or not object4.mInfoPopupInfo.CustomEntry)
				then
					appendInfo = module5.GetStoreItemInfo(
						object4.mMovie,
						object4.mStoreItem,
						appendInfo,
						nil,
						nil,
						true
					)
				elseif appendInfo ~= nil and appendInfo.AppendInfo ~= nil then
					appendInfo = appendInfo.AppendInfo
				end

				local v2 = Localize("/Lotus/Language/Menu/Cosmetics_None", {})

				if appendInfo ~= nil and appendInfo.Name == v2 and appendInfo.ToolTip == v2 then
					appendInfo = nil
				end

				if appendInfo ~= nil then
					if mSelectedElement ~= nil then
						appendInfo.mUnequipItem = mSelectedElement.mUnequipItem
					end

					if not __wf_atom_7e8ad928(object2.OnShowPopup) then
						object2:OnShowPopup(mSelectedElement, appendInfo)
					end

					local __wf_atom_5e6e15c8 = object4.mMovie:__wf_atom_5e6e15c8(object4.mClipName, 2)
					local __wf_atom_5e6e15c8_2 = object4.mMovie:__wf_atom_5e6e15c8(object4.mClipName, 3)

					if __wf_atom_5e6e15c8 ~= nil and __wf_atom_5e6e15c8_2 ~= nil then
						module2.SetItemInfoPopupRect(
							object4.mMovie,
							appendInfo,
							__wf_atom_5e6e15c8 + object4.mWidth / 2,
							__wf_atom_5e6e15c8_2 + object4.mHeight / 2,
							object4.mWidth,
							object4.mHeight
						)
						_T.InfoPopup_Data = appendInfo
						_T.InfoPopup_Grid = object2
					end
				end
			end
		else
			_T.InfoPopup_Data = nil

			if
				Engine.IsPlayingWithController()
				and object4.mType == Types.DROP_DOWN
				and object4.mDropDownMenu ~= nil
			then
				object4.mDropDownMenu.mHideSelectCallout = true
				object4.mDropDownMenu:UpdateSelectedText()
			end
		end
	end

	v.ComponentTryPressed = v.TryPressed

	function v:TryPressed(p3, p4)
		self:ComponentTryPressed(p3, p4)

		if Engine.__wf_atom_2a979d69() and object2 ~= nil and not object2.mScrollDrag.isStopping then
			object2.mScrollDrag.isStopping = false

			if self.mType ~= Types.COLOR then
				for i = 1, #self.mButtons do
					self.mButtons[i]:ComponentTryPressed(not p3, p4)
				end
			end
		elseif self.mType ~= Types.COLOR then
			for i = 1, #self.mButtons do
				self.mButtons[i]:ComponentTryPressed(p3, p4)
			end
		end

		if not p3 and self.mSelectState ~= nil then
			self:TrySetFocus(false)
		end
	end

	function v:GetColorButtons()
		local result = {}

		if self.mAllColors == nil then
			for i = 1, #self.mButtons do
				local mButton = self.mButtons[i]

				if mButton.mColorRegion ~= nil then
					table.insert(result, mButton)
				end
			end
		else
			for i = 1, #self.mAllColors do
				if self.mCopyColorSlot == nil or self.mAllColors[i].mCopyColorSlot == self.mCopyColorSlot then
					table.insert(result, self.mAllColors[i])
				end
			end
		end

		return result
	end

	v.ComponentPressed = v.Pressed

	function v:Pressed(p3, p4)
		self:ComponentPressed(p3, p4)

		if not p3 then
			if self.mType == Types.ITEM_SELECTION or self.mDisplayDojoColorGrid then
				if object3 == nil or self.mItemSelectionData == nil then
					__wf_atom_f2daf912("missing item selection data")
				else
					object3:Populate(self.mItemSelectionData, mSelectedElement)
				end
			elseif self.mType == Types.DROP_DOWN then
				if Engine.IsPlayingWithController() and self.mDropDownMenu ~= nil then
					if self.mDropDownMenu:IsVisible() then
						self.mDropDownMenu:SelectCurrentElement()
					else
						self.mDropDownMenu:ArrowPressed()
					end
				end
			elseif self.mType == Types.COLOR then
				self:PickColor(self:GetColorButtons())
			elseif self.mType == Types.BUTTON and self.mCopyColorSlot ~= nil then
				local mApplyColorCallback = object2 ~= nil and object2.mApplyColorCallback or self.mApplyColorCallback

				if mApplyColorCallback ~= nil then
					mApplyColorCallback(nil, nil, nil, self.mCopyColorSlot)
				end
			end
		end
	end

	v.ComponentResize = v.Resize

	function v:Resize()
		self:ComponentResize()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local mBigButton = self.mBigButton
		local mWidth = self.mWidth
		local mHeight = self.mHeight
		local mIconPadding = self.mIconPadding
		local mBigButtonTextPadding = mBigButton and self.mBigButtonTextPadding or self.mTextPadding
		local ternary = module.Ternary(self.mProgress ~= nil, 7, 0)
		local v2 = mHeight - (mIconPadding * 2 + ternary)
		local mIconWidth = v2 * self.mIconWidthMultiplier
		local mIconHeight = v2 * self.mIconHeightMultiplier
		local v3 = mBigButton and mIconPadding or mWidth - v2 - mIconPadding
		local v4

		if self.mIconOffset then
			v3 += self.mIconOffset.X
			v4 = mIconPadding + self.mIconOffset.Y
		else
			v4 = mIconPadding
		end

		local v5 = mWidth - mBigButtonTextPadding - module.Ternary(self.mType == Types.TITLE, 0, v2) - mBigButtonTextPadding
		mMovie:__wf_atom_7f57ab2f(mClipName, "Label", 52, false)
		local v6

		if v5 < mMovie:__wf_atom_cfc41e35(mClipName, "Label", 40) then
			v6 = mBigButton
		else
			v6 = false
		end

		local ternary2 = module.Ternary(mBigButton, 24, 19)
		local v7 = not mBigButton and 16 or self.mDesc == "" and 22 or 38

		if v6 then
			v7 += ternary2
			ternary2 *= 2
		end

		local rounded = module.Round((mHeight - v7) / 2)

		if self.mTextYOffset ~= nil then
			rounded += self.mTextYOffset
		end

		if self.mShowDesc ~= nil and not mBigButton then
			rounded -= 11
		end

		if self.mTextYOverride ~= nil then
			rounded = self.mTextYOverride
		end

		local v8 = rounded + ternary2
		local v9 = mBigButton and v3 + v2 + mBigButtonTextPadding
			or module.Ternary(self.mType == Types.TITLE, 0, mBigButtonTextPadding)
		self.mIconWidth = mIconWidth
		self.mIconHeight = mIconHeight
		mMovie:__wf_atom_4c1c1986(
			mClipName,
			"Label",
			78,
			module.Ternary(self.mLeading ~= nil, self.mLeading, self.mInitLabelLeading)
		)
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 1, rounded)
		mMovie:__wf_atom_4c1c1986(mClipName, "Desc", 1, v8)
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 0, v9)
		mMovie:__wf_atom_4c1c1986(mClipName, "Desc", 0, v9)
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 14, v5)
		mMovie:__wf_atom_4c1c1986(mClipName, "Desc", 14, v5)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, v3 + v2 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 1, v4 + v2 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, mIconWidth)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, mIconHeight)
		mMovie:__wf_atom_4c1c1986(mClipName, "IconMask", 0, v3 + v2 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "IconMask", 1, mIconPadding + v2 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "IconMask", 14, v2)
		mMovie:__wf_atom_4c1c1986(mClipName, "IconMask", 15, v2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Divider", 0, v3 + v2 - 1)
		mMovie:__wf_atom_4c1c1986(mClipName, "Divider", 15, mHeight - 10)
		mMovie:__wf_atom_4c1c1986(mClipName, "HighlightMask", 0, v3 - mIconPadding)
		mMovie:__wf_atom_4c1c1986(mClipName, "HighlightMask", 14, v2 + mIconPadding - 1)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 1, v2 + mIconPadding * 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 0, v3 + v2 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 14, 250)
		mMovie:__wf_atom_4c1c1986(mClipName, "ColorButtons", 0, mWidth)
		mMovie:__wf_atom_4c1c1986(mClipName, "Bar", 0, 1)
		mMovie:__wf_atom_4c1c1986(mClipName, "Bar", 1, mHeight - ternary - 1)
		mMovie:__wf_atom_4c1c1986(mClipName, "Bar", 14, mWidth - 2)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".LabelRight", 14)

		if __wf_atom_5e6e15c8 ~= nil then
			mMovie:__wf_atom_4c1c1986(mClipName, "LabelRight", 0, mWidth - (__wf_atom_5e6e15c8 + 5))

			if mSelectedElement.NameTagRightMatchesDescY then
				mMovie:__wf_atom_4c1c1986(mClipName, "LabelRight", 1, v8)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "LabelRight", 1, module.Round((mHeight - 18) / 2))
			end
		end

		mMovie:__wf_atom_7f57ab2f(mClipName, "Label", 52, v6 or self.mMultiline)
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 92, 2)
	end

	v.ComponentUpdateColors = v.UpdateColors

	function v:UpdateColors()
		self:ComponentUpdateColors()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local mApplyThemes = self.mApplyThemes
		local color = module4.GetColor(6, true, mApplyThemes)
		local color2 = module4.GetColor(1, true, mApplyThemes)
		local color3 = module4.GetColor(9, true, mApplyThemes)
		local color4 = module4.GetColor(10, true, mApplyThemes)

		if self:IsActive() and self.mFocused then
			color3 = color4
		end

		if self.mProgressBar ~= nil then
			self.mProgressBar:UpdateColors()
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Desc", 11, color)
		mMovie:__wf_atom_4c1c1986(mClipName, "LabelRight", 11, color3)
		mMovie:__wf_atom_4c1c1986(mClipName, "Arrow", 11, color3)
		mMovie:__wf_atom_4c1c1986(mClipName, "Divider", 11, color2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Divider", 12, 40)
		mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 11, color4)
		mMovie:__wf_atom_4c1c1986(mClipName, "Preview", 11, color3)

		if self.mIconColorOverride then
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, self.mIconColorOverride)
		end

		if self.mIconAlphaOverride then
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 12, self.mIconAlphaOverride)
		end

		for i = 1, #self.mButtons do
			self.mButtons[i]:UpdateColors()
		end
	end

	function v:ApplyColor(object4, p3)
		object4:UpdateColors()
		object4:SetIconVisible(object4.mIcon ~= nil and (object4.mColorRegion == nil or object4.mInnerColor == nil))
		local mApplyColorCallback = object2 ~= nil and object2.mApplyColorCallback or self.mApplyColorCallback

		if mApplyColorCallback ~= nil then
			mApplyColorCallback(object4.mColorRegion, object4.mInnerColor, p3, self.mCopyColorSlot)
		end
	end

	function v:ResetColor(list)
		for i = 1, #list do
			local v2 = list[i]

			if not (v2 and v2.mColorRegion ~= nil) then
				continue
			end

			if self.mDefaultColor == nil then
				v2.mInnerColor = nil
				v2.mPreviousColor = nil
			else
				v2.mInnerColor = self.mDefaultColor
				v2.mPreviousColor = self.mDefaultColor
			end

			self:ApplyColor(v2, true)
		end
	end

	function v:RandomizeColor(list)
		for i = 1, #list do
			local v2 = list[i]

			if not (v2 and v2.mColorRegion ~= nil) then
				continue
			end

			if __wf_atom_7e8ad928(v2.mCustomColorInfo) then
				local mDefaultColorPalette = object2 ~= nil and object2.mDefaultColorPalette
					or self.mDefaultColorPalette

				if mDefaultColorPalette == nil then
					__wf_atom_f2daf912("missing default color palette")
				else
					local randomColorPalette, _ = module3.GetRandomColorPalette(
						gGameRules:__wf_atom_964056fd(),
						mDefaultColorPalette
					)
					v2.mInnerColor = randomColorPalette[__wf_atom_5784a397(1, #randomColorPalette)]
					v2.mPreviousColor = v2.mInnerColor
					self:ApplyColor(v2, true)
				end
			else
				local colors = v2.mCustomColorInfo.Colors
				v2.mInnerColor = colors[__wf_atom_5784a397(1, #colors)]
				v2.mPreviousColor = v2.mInnerColor
				self:ApplyColor(v2, true)
			end
		end
	end

	function v:CopyColors(list, p3, p4)
		local mInnerColorsByMColorRegion = {}

		for i = 1, #list do
			local v2 = list[i]

			if v2 and v2.mColorRegion ~= nil and v2.mCopyColorSlot == p3 then
				mInnerColorsByMColorRegion[v2.mColorRegion] = v2.mInnerColor
			end
		end

		for i = 1, #list do
			local v2 = list[i]

			if not (v2 and v2.mColorRegion ~= nil and v2.mCopyColorSlot == p4) then
				continue
			end

			v2.mInnerColor = mInnerColorsByMColorRegion[v2.mColorRegion]
			v2.mPreviousColor = mInnerColorsByMColorRegion[v2.mColorRegion]
			self:ApplyColor(v2, true)
		end
	end

	function v:PickColor(list)
		if #list < 1 then
			return
		end

		if object2.mShowAccessibilityColors then
			_T.AccessibilityColorsAvailable = true
		end

		if object2.mColorPickerSkipSuitRot then
			_T.ColorPicker_SkipSuitRotation = true
		end

		self.mChildMovie = module3.OpenColorPicker(self.mMovie, list[1].mInnerColor, function(mInnerColor)
			for i = 1, #list do
				local v2 = list[i]

				if v2.mCustomColorInfo ~= self.mCustomColorInfo then
					continue
				end

				if mInnerColor == nil then
					v2.mInnerColor = v2.mPreviousColor
				else
					v2.mInnerColor = mInnerColor
				end

				v2:UpdateColors()
				v2:SetIconVisible(v2.mIcon ~= nil and (v2.mColorRegion == nil or v2.mInnerColor == nil))
				self:ApplyColor(v2, false)
			end
		end, function(p3)
			_T.ColorPicker_SkipSuitRotation = nil

			if p3 then
				for i = 1, #list do
					local v2 = list[i]
					v2.mPreviousColor = v2.mInnerColor
					self:ApplyColor(v2, true)
				end
			else
				for i = 1, #list do
					local v2 = list[i]
					v2.mInnerColor = v2.mPreviousColor
					self:ApplyColor(v2, false)
				end
			end

			local mGoBackCallback = object2 ~= nil and object2.mGoBackCallback or self.mGoBackCallback

			if mGoBackCallback ~= nil then
				mGoBackCallback()
			end
		end, self.mCustomColorInfo)

		if not __wf_atom_7e8ad928(self.mChildMovie) then
			self.mChildMovie:Execute("SetIgnoreTopMenu", "true")

			if not __wf_atom_7e8ad928(self.mMovie) then
				self.mChildMovie:__wf_atom_62d09591(self.mMovie:DrawOverCinematics())
			end
		end

		_T.AccessibilityColorsAvailable = nil
	end

	function v:ApplyItemSelection(p3)
		object2.mSelectedElement = mSelectedElement

		if object2.mSelectionDoneCallback ~= nil then
			object2.mSelectionDoneCallback(false, p3.StoreItem, p3, mSelectedElement)
		end

		self.mItemSelectionData.OnSelectionDoneFunction(false, p3.StoreItem, p3)
		mSelectedElement.ItemSelectionData.CurrSelection = p3.StoreItem
		object2.mElementDrawCallback(mSelectedElement)
	end

	function v:DefaultItemSelection()
		local defaultSelection = mSelectedElement.ItemSelectionData.DefaultSelection
		local v2

		if __wf_atom_7e8ad928(defaultSelection) then
			v2 = mSelectedElement.mUnequipItem or { mPurchased = true }
		else
			v2 = {
				Type = defaultSelection:GetItem(),
				StoreItem = defaultSelection,
				mPurchased = true
			}
		end

		self:ApplyItemSelection(v2)
	end

	function v:RandomizeItemSelection()
		local itemsFunction = self.mItemSelectionData.GetItemsFunction(mSelectedElement)
		local count = #itemsFunction
		local v2 = 1

		while v2 <= count do
			if itemsFunction[v2].Owned then
				v2 += 1
			else
				table.remove(itemsFunction, v2)
				count = #itemsFunction
			end
		end

		local v3 = itemsFunction[__wf_atom_5784a397(1, #itemsFunction)]

		if v3 ~= nil then
			self:ApplyItemSelection(v3)
		end
	end

	function v:SetDefault()
		if self.mType == Types.BUTTON or self.mType == Types.TREE then
			return
		end

		if self.mType == Types.ITEM_SELECTION then
			self:DefaultItemSelection()
		elseif self.mType == Types.COLOR then
			self:ResetColor(self.mButtons)
		elseif self.mType == Types.DROP_DOWN then
			self.mDropDown:SelectElementById(self.mDefaultValue)
		elseif self.mDefaultValue ~= nil then
			for i = 1, #self.mButtons do
				local mButton = self.mButtons[i]

				if mButton.SetValue then
					mButton:SetValue(self.mDefaultValue)
				end
			end
		end
	end

	function v:Randomize()
		if self.mType == Types.BUTTON or self.mType == Types.TREE then
			return
		end

		if self.mType == Types.ITEM_SELECTION then
			self:RandomizeItemSelection()
			return
		end

		if self.mType == Types.COLOR then
			self:RandomizeColor(self.mButtons)
			return
		end

		local v2 = nil

		if self.mType == Types.VALUE_SELECTOR then
			v2 = __wf_atom_5784a397(self.mSlider.mMinValue, self.mSlider.mMaxValue)
		elseif self.mType == Types.CHECKBOX then
			v2 = __wf_atom_5784a397(0, 1) > 0
		elseif self.mType == Types.DROP_DOWN or self.mType == Types.TOGGLE then
			v2 = __wf_atom_5784a397(1, #self.mOptions)
		end

		if v2 ~= nil then
			for i = 1, #self.mButtons do
				local mButton = self.mButtons[i]

				if mButton.SetValue then
					mButton:SetValue(v2)
				end
			end
		end
	end

	function v:GetContentHeight()
		return (math.min(34, self.mHeight - self.mIconPadding * 2))
	end

	function v:RedrawDropDown()
		if self.mType ~= Types.DROP_DOWN then
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "DropDown", 13, false)
			return
		end

		local mMovie = self.mMovie
		local v2 = self.mClipName .. ".DropDown"
		mMovie:__wf_atom_2dedec1a(v2, 13, true)
		local mIconPadding = self.mIconPadding
		local contentHeight = self:GetContentHeight()
		local ternary = module.Ternary(self.mContentWidth ~= nil, self.mContentWidth, object2.mContentWidth)
		mMovie:__wf_atom_e57658c2(v2, 0, self.mWidth - mIconPadding - ternary)
		mMovie:__wf_atom_e57658c2(v2, 1, (self.mHeight - contentHeight) / 2)
		local mDropDown = self.mDropDown

		if mDropDown == nil then
			mDropDown = module10.Create(mMovie, v2)

			for i = 1, #self.mOptions do
				mDropDown:AddElement(self.mOptions[i])
			end

			if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
				mDropDown.mMainButton:SetVisibleRangeMaterials(
					self.mVisRangeMaterials.BaseMaterial,
					self.mVisRangeMaterials.TextMaterial,
					self.mVisRangeMaterials.BackerMaterial
				)
			end

			mDropDown:SetWidth(ternary)
			mDropDown.DropDownOnDraw = mDropDown.OnDraw

			function mDropDown.OnDraw(object4, p3, p4)
				object4:DropDownOnDraw(p3, p4)

				if not __wf_atom_7e8ad928(p3) then
					local mButton = p3.mButton

					if not __wf_atom_7e8ad928(mButton) then
						mButton.mHeight = contentHeight
						mButton.mLabelYOffset = 0
						mButton.mShowHighlight = false
						mButton.mShowUnderline = false
						mButton.mUnderlineAlpha = 0
						mButton.mFocusedEdgeAlpha = 80
						mButton.ComponentTrySetFocus = mButton.TrySetFocus

						function mButton.TrySetFocus(_, p5)
							mButton:ComponentTrySetFocus(p5)
							self:ComponentTrySetFocus(p5)
						end

						mButton.ComponentTryPressed = mButton.TryPressed

						function mButton.TryPressed(_, p5, p6)
							mButton:ComponentTryPressed(p5, p6)
							self:ComponentTryPressed(p5)
						end

						mButton:OnGamepadTransition()
						mButton:Resize()
					end
				end
			end

			function mDropDown.mOnSelectedCallback(p3)
				if not __wf_atom_7e8ad928(self.mValueChangedCallback) then
					self.mValueChangedCallback(p3)
				end
			end

			local mMainButton = mDropDown.mMainButton
			mMainButton.mHeight = contentHeight
			mMainButton.mLabelYOffset = 0
			mMainButton.mShowHighlight = false
			mMainButton.mShowUnderline = false
			mMainButton.mUnderlineAlpha = 0
			mMainButton.mEdgeAlpha = 40
			mMainButton.mFocusedEdgeAlpha = 80
			mMainButton.mUnfocusedEdgeColor = 1
			mMainButton.ComponentTrySetFocus = mMainButton.TrySetFocus

			function mMainButton.TrySetFocus(_, p3)
				mMainButton:ComponentTrySetFocus(p3)
				self:TrySetFocus(p3, true)
			end

			mMainButton.ComponentTryPressed = mMainButton.TryPressed

			function mMainButton.TryPressed(_, p3, p4)
				mMainButton:ComponentTryPressed(p3, p4)
				self:ComponentTryPressed(p3)
			end

			if self.mValueChangedCallback then
				mMainButton.ValueChanged = self.mValueChangedCallback
			end

			mMainButton:Resize()
			mDropDown:SelectElementById(self.mInitialValue or self.mDefaultValue)
			self.mDropDown = mDropDown
		end

		self.mButtons = { mDropDown.mMainButton }
		mDropDown:Redraw(nil, true, true)
	end

	function v:RedrawProgressBar()
		if self.mProgress == nil then
			local mBigButton = self.mBigButton

			if mBigButton == nil then
				mBigButton = false
			end

			self.mShowUnderline = mBigButton
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bar", 13, false)
		else
			local mMovie = self.mMovie
			local v2 = self.mClipName .. ".Bar"
			self.mShowUnderline = false
			mMovie:__wf_atom_2dedec1a(v2, 13, true)
			local mProgressBar = self.mProgressBar

			if mProgressBar == nil then
				mProgressBar = module11.Create(
					self.mMovie,
					v2,
					self.mWidth,
					self.mProgress.Values,
					self.mVisRangeMaterials.BackerMaterial,
					self.mProgress.Total
				)
				mProgressBar.mBgInnerAlpha = 0
				mProgressBar:SetHeight(7)
				self.mProgressBar = mProgressBar
			end

			mProgressBar:SetProgress(self.mProgress.Values, nil, self.mProgress.Total)
		end
	end

	function v:RedrawToggle()
		if self.mType ~= Types.TOGGLE then
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Toggle", 13, false)
			return
		end

		local mMovie = self.mMovie
		local mClipName = self.mClipName .. ".Toggle"
		mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		local mToggle = self.mToggle
		local mIconPadding = self.mIconPadding
		local contentHeight = self:GetContentHeight()
		local ternary = module.Ternary(self.mContentWidth ~= nil, self.mContentWidth, object2.mContentWidth)

		if mToggle == nil then
			mToggle = module9.Create(mMovie, mClipName, self.mOptions, self.mInitialValue or self.mDefaultValue)

			if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
				mToggle:SetVisibleRangeMaterials(
					self.mVisRangeMaterials.BaseMaterial,
					module.Ternary(self.IgnoreToggleTextVisRange, nil, self.mVisRangeMaterials.TextMaterial),
					self.mVisRangeMaterials.BackerMaterial
				)
			end

			mToggle.mConvertEmoticons = self.mConvertEmoticons
			mToggle.mHeight = contentHeight
			mToggle.mMinSize = ternary
			mToggle.mMaxSize = ternary
			mToggle.mEdgeAlpha = 40
			mToggle.mFocusedEdgeAlpha = 80
			mToggle.mUnfocusedEdgeColor = 1
			mToggle.mArrowIcon = UITexture_SettingsIcons[IconTypes.ARROW]
			mToggle.mFontSize = self.mToggleFontSize
			mToggle.mPostText = self.mPostText
			mToggle.ComponentTrySetFocus = mToggle.TrySetFocus

			function mToggle.TrySetFocus(_, p3)
				mToggle:ComponentTrySetFocus(p3)
				self:TrySetFocus(p3, true)
			end

			mToggle.ComponentTryPressed = mToggle.TryPressed

			function mToggle.TryPressed(_, p3, p4)
				mToggle:ComponentTryPressed(p3, p4)
				self:ComponentTryPressed(p3)
			end

			mToggle.ComponentTrySetAltFocus = mToggle.TrySetAltFocus

			function mToggle.TrySetAltFocus(_, p3, p4)
				mToggle:ComponentTrySetAltFocus(p3, p4)
				self:TrySetFocus(p3, true)
			end

			if self.mValueChangedCallback then
				mToggle.ValueChanged = self.mValueChangedCallback
			end

			self.mToggle = mToggle
		else
			mToggle.mClipName = mClipName
			mToggle.mOptions = self.mOptions
			mToggle.mHookedUpCallbacks = false
			mToggle:HookUpCallbacks()
			mToggle:Resize()
		end

		mToggle.mParentId = self.mId
		self.mButtons = { mToggle }
		mToggle:SetActive(self:IsActive())
		local v2 = self.mWidth - mIconPadding - ternary
		local v3 = (self.mHeight - contentHeight) / 2
		mToggle:SetPosition(v2, v3)
		mToggle:Redraw()
	end

	function v:RedrawSlider()
		if self.mType ~= Types.VALUE_SELECTOR then
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ValueSelector", 13, false)
			return
		end

		local mMovie = self.mMovie
		local mClipName = self.mClipName .. ".ValueSelector"
		mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		local mSlider = self.mSlider
		local mIconPadding = self.mIconPadding
		local ternary = module.Ternary(self.mContentWidth ~= nil, self.mContentWidth, object2.mContentWidth)

		if mSlider == nil then
			mSlider = module7.Create(
				mMovie,
				mClipName,
				self.mInitialValue or self.mDefaultValue,
				self.mMinValue,
				self.mMaxValue,
				self.mSteps,
				self.mDecimals
			)

			if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
				mSlider:SetVisibleRangeMaterials(
					self.mVisRangeMaterials.BaseMaterial,
					self.mVisRangeMaterials.TextMaterial,
					self.mVisRangeMaterials.BackerMaterial
				)
			end

			mSlider.mHeight = 10
			local v2 = ternary + module.Ternary(self.mDisableSlider, 30, 0)
			mSlider.mMinSize = v2
			mSlider.mMaxSize = v2
			mSlider.mEdgeAlpha = 40
			mSlider.mFocusedEdgeAlpha = 80
			mSlider.mHideArrows = self.mDisableSlider
			mSlider.mUnfocusedEdgeColor = 1
			mSlider.mArrowIcon = UITexture_SettingsIcons[IconTypes.ARROW]
			mSlider.ComponentTrySetFocus = mSlider.TrySetFocus

			function mSlider.TrySetFocus(_, p3)
				mSlider:ComponentTrySetFocus(p3)
				self:TrySetFocus(p3, true)
			end

			mSlider.ComponentTryPressed = mSlider.TryPressed

			function mSlider.TryPressed(_, p3, p4)
				mSlider:ComponentTryPressed(p3, p4)
				self:ComponentTryPressed(p3, p4)
			end

			mSlider.ComponentInputFieldTrySetFocus = mSlider.InputFieldTrySetFocus

			function mSlider.InputFieldTrySetFocus(_, p3)
				mSlider:ComponentInputFieldTrySetFocus(p3)
				self:TrySetFocus(p3, true)
			end

			mSlider.ComponentSetAltFocus = mSlider.SetAltFocus

			function mSlider.SetAltFocus(_, p3, p4)
				mSlider:ComponentSetAltFocus(p3, p4)
				self:TrySetFocus(p3, true)
			end

			if self.mValueChangedCallback then
				mSlider.ValueChanged = self.mValueChangedCallback
			end

			self.mSlider = mSlider
		else
			mSlider.mClipName = mClipName
			mSlider.mHookedUpCallbacks = false
			mSlider:HookUpCallbacks()
			mSlider:Resize()
		end

		mSlider.mParentId = self.mId
		self.mButtons = { mSlider }
		local v2 = self:IsActive() and not self.mDisableSlider
		mSlider:SetActive(v2)
		local v3 = self.mWidth - mIconPadding - ternary
		local v4 = self.mDisableSlider and -20 or v3
		local v5 = (self.mHeight - 10) / 2
		mSlider:SetPosition(v4, v5)
		mSlider:Redraw()
	end

	function v:RedrawCheckbox()
		if self.mType ~= Types.CHECKBOX then
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Checkbox", 13, false)
			return
		end

		local mMovie = self.mMovie
		local mClipName = self.mClipName .. ".Checkbox"
		mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
		local mCheckbox = self.mCheckbox
		local mIconPadding = self.mIconPadding
		local contentHeight = self:GetContentHeight()

		if mCheckbox == nil then
			mCheckbox = module8.Create(
				mMovie,
				mClipName,
				module.Ternary(self.mInitialValue ~= nil, self.mInitialValue, self.mDefaultValue)
			)

			if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
				mCheckbox:SetVisibleRangeMaterials(
					self.mVisRangeMaterials.BaseMaterial,
					self.mVisRangeMaterials.TextMaterial,
					self.mVisRangeMaterials.BackerMaterial
				)
			end

			mCheckbox.mHeight = contentHeight
			mCheckbox.mMinSize = 80
			mCheckbox.mMaxSize = 80
			mCheckbox.mEdgeAlpha = 40
			mCheckbox.mFocusedEdgeAlpha = 80
			mCheckbox.mUnfocusedEdgeColor = 1
			mCheckbox.mIconOn = UITexture_SettingsIcons[IconTypes.CHECKMARK]
			mCheckbox.mIconOff = UITexture_SettingsIcons[IconTypes.CROSS]
			mCheckbox.mIconDefault = UITexture_SettingsIcons[IconTypes.GRIP]
			mCheckbox.ComponentTrySetFocus = mCheckbox.TrySetFocus

			function mCheckbox.TrySetFocus(_, p3)
				mCheckbox:ComponentTrySetFocus(p3)
				self:TrySetFocus(p3, true)
			end

			mCheckbox.ComponentTryPressed = mCheckbox.TryPressed

			function mCheckbox.TryPressed(_, p3, p4)
				mCheckbox:ComponentTryPressed(p3, p4)
				self:ComponentTryPressed(p3, p4)
			end

			if self.mValueChangedCallback then
				mCheckbox.ValueChanged = self.mValueChangedCallback
			end

			self.mCheckbox = mCheckbox
		else
			mCheckbox.mClipName = mClipName
			mCheckbox.mHookedUpCallbacks = false
			mCheckbox:HookUpCallbacks()
			mCheckbox:Resize()
		end

		mCheckbox.mParentId = self.mId
		self.mButtons = { mCheckbox }
		local v2 = self:IsActive() and not self.mDisableCheckbox
		mCheckbox:SetActive(v2)
		local v3 = self.mWidth - mIconPadding - 80
		mCheckbox:SetPosition(v3, mIconPadding)
		mCheckbox:Redraw()
	end

	function v:RedrawColorButtons()
		if self.mType ~= Types.COLOR then
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ColorButtons", 13, false)
			return
		end

		local mMovie = self.mMovie
		local mClipName = self.mClipName

		if self.mButtons == nil then
			self.mButtons = {
				{ mIcon = UITexture_SettingsIcons[IconTypes.RESET], mColorFunction = v.ResetColor },
				{
					mIcon = UITexture_SettingsIcons[IconTypes.RANDOMIZE],
					mColorFunction = v.RandomizeColor
				}
			}

			for i = 1, #self.mColorRegions do
				local mButtons = self.mButtons
				local mColorRegion = self.mColorRegions[i]
				local mCopyColorSlot = self.mCopyColorSlot
				local initialColor = fn(mColorRegion)

				if mSelectedElement.InitialColor ~= nil then
					initialColor = mSelectedElement.InitialColor
				end

				table.insert(mButtons, {
					mPreviousColor = initialColor,
					mInnerColor = initialColor,
					mColorRegion = mColorRegion,
					mCopyColorSlot = mCopyColorSlot,
					mIcon = UITexture_SettingsIcons[IconTypes.DEFAULT_COLOR]
				})
			end
		end

		mMovie:__wf_atom_7f57ab2f(mClipName, "ColorButtons", 13, true)
		local mIconPadding = self.mIconPadding
		local contentHeight = self:GetContentHeight()

		for i = 1, #self.mButtons do
			local mButton = self.mButtons[i]

			if not mButton.mInitialized then
				local v2 = mClipName .. ".ColorButtons.ColorButton" .. i

				if not mMovie:__wf_atom_253d7085(v2) then
					__wf_atom_86cbd68d(
						mMovie,
						mClipName .. ".ColorButtons.ColorButton1.duplicateMovieClip",
						"ColorButton" .. i,
						i
					)
				end

				mButton = module6.Create(mMovie, v2, nil, nil, nil, nil, nil, nil, mButton)
				mButton:SetId(self.mId)
				mButton:SetPosition(1 - mIconPadding / 2 - i * (contentHeight + mIconPadding / 2), mIconPadding)
				mButton.mShowHighlight = false
				mButton.mName = self.mName
				mButton.mHeight = contentHeight
				mButton.mMinSize = contentHeight
				mButton.mMaxSize = contentHeight
				mButton.mEdgeAlpha = 40
				mButton.mFocusedEdgeAlpha = 80
				mButton.mUnfocusedEdgeColor = 1

				if mButton.mIcon then
					mMovie:__wf_atom_c90af43a(v2 .. ".Icon", mButton.mIcon)

					if mButton.mColorRegion ~= nil then
						mMovie:__wf_atom_4c1c1986(v2, "Icon", 12, 10)
					end
				end

				mButton.ComponentSetDrag = mButton.SetDrag

				function mButton.SetDrag(object4, p3)
					object4:ComponentSetDrag(p3)

					if not object4.mDragging then
						object2.mDragTarget = object4
						return
					end

					__wf_atom_86cbd68d(mMovie, mClipName .. ".swapDepths", 10000)
					object2.mDragSource = object4
				end

				mButton.ComponentStopDrag = mButton.StopDrag

				function mButton.StopDrag(_)
					if object2.mDragSource ~= nil then
						object2.mDragSource:ComponentStopDrag()
						object2.mDragSource = nil
					end

					object2.mDragTarget = nil
				end

				mButton.ComponentPressed = mButton.Pressed

				function mButton.Pressed(_, p3)
					local mDragSource = object2.mDragSource
					local mDragTarget = object2.mDragTarget
					mButton:ComponentPressed(p3)

					if mDragSource == nil or mDragTarget == nil then
						if not p3 then
							if mButton.mColorRegion ~= nil then
								if self.mOnReleasedCallback ~= nil then
									self:mOnReleasedCallback()
								end

								self:Pressed(false, nil, true)
							end

							if mButton.mColorFunction then
								mButton.mColorFunction(self, self:GetColorButtons())
							elseif self.mDisplayDojoColorGrid then
								self:Pressed(false, nil)
							else
								self:PickColor({ mButton })
							end
						end
					else
						mDragSource:TrySetFocus(false)
						local mInnerColor = mDragTarget.mInnerColor
						local mInnerColor2 = mDragSource.mInnerColor
						mDragSource.mInnerColor = mInnerColor
						mDragTarget.mInnerColor = mInnerColor2
						local mInnerColor3 = mDragSource.mInnerColor
						local mInnerColor4 = mDragTarget.mInnerColor
						mDragSource.mPreviousColor = mInnerColor3
						mDragTarget.mPreviousColor = mInnerColor4
						self:ApplyColor(mDragSource, true)
						self:ApplyColor(mDragTarget, true)
						mDragTarget:TrySetFocus(true)
					end
				end

				mButton.ComponentTrySetFocus = mButton.TrySetFocus

				function mButton.TrySetFocus(_, p3)
					if self:IsActive() then
						mButton:ComponentTrySetFocus(p3)
						self:TrySetFocus(p3, true)
					end
				end

				mButton.ComponentResize = mButton.Resize

				function mButton:Resize()
					mButton:ComponentResize()
					mMovie:__wf_atom_4c1c1986(v2, "Icon", 0, contentHeight / 2)
					mMovie:__wf_atom_4c1c1986(v2, "Icon", 1, contentHeight / 2)
					mMovie:__wf_atom_4c1c1986(v2, "Icon", 14, contentHeight - 4)
					mMovie:__wf_atom_4c1c1986(v2, "Icon", 15, contentHeight - 4)
					mMovie:__wf_atom_4c1c1986(v2, "Backer", 14, contentHeight)
					mMovie:__wf_atom_4c1c1986(v2, "Blurer", 14, contentHeight)
				end

				mButton.mInitialized = true
				self.mButtons[i] = mButton

				if mButton.mColorRegion == nil then
					mButton.mInnerAlpha = 0
				else
					table.insert(object2.mAllColors, mButton)

					if __wf_atom_7e8ad928(self.mCustomColorInfo) then
						mButton:HookUpDragCallbacks()
					else
						mButton.mCustomColorInfo = self.mCustomColorInfo
					end

					mButton.mInnerAlpha = 100
				end
			end

			if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
				local baseMaterial = self.mVisRangeMaterials.BaseMaterial
				local textMaterial = self.mVisRangeMaterials.TextMaterial
				local backerMaterial = self.mVisRangeMaterials.BackerMaterial
				mButton:SetVisibleRangeMaterials(baseMaterial, textMaterial, backerMaterial)
			end

			local v2 = mButton.mIcon ~= nil and (mButton.mColorRegion == nil or mButton.mInnerColor == nil)
			mButton:SetIconVisible(v2)
			mButton:Redraw()
		end

		local count = #self.mButtons

		while true do
			count += 1
			local v2 = mClipName .. ".ColorButtons.ColorButton" .. count

			if not mMovie:__wf_atom_253d7085(v2) then
				break
			end

			__wf_atom_86cbd68d(mMovie, v2 .. ".removeMovieClip")
		end
	end

	function v:Update(p3)
		for i = 1, #self.mButtons do
			local mButton = self.mButtons[i]

			if mButton ~= nil and mButton.Update ~= nil then
				mButton:Update(p3)
			end
		end
	end

	v.ComponentRedraw = v.Redraw

	function v:Redraw()
		self:ComponentRedraw()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local mBigButton = self.mBigButton

		if mBigButton == nil then
			mBigButton = false
		end

		self.mShowUnderline = mBigButton
		self.mUnfocusedEdgeColor = 1
		self.mFocusedEdgeAlpha = 30

		if mBigButton then
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 50, 24)
		else
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 50, 19)
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 12, mSelectedElement.NameAlpha or 100)
		mMovie:__wf_atom_4c1c1986(mClipName, "Desc", 12, mSelectedElement.DescAlpha or 100)

		if self.mIcon then
			mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", self.mIcon)
		end

		if self.mVisRangeMaterials ~= nil then
			mMovie:OverrideMaterial(mClipName .. ".Icon", self.mVisRangeMaterials.BaseMaterial)
			mMovie:OverrideMaterial(mClipName .. ".Divider", self.mVisRangeMaterials.BaseMaterial)
			mMovie:OverrideMaterial(mClipName .. ".Desc", self.mVisRangeMaterials.TextMaterial)
		end

		mMovie:__wf_atom_7d7314f1(mClipName .. ".Preview.text", "<PREVIEW>")
		mMovie:__wf_atom_7f57ab2f(mClipName, "Backer", 13, self.mType ~= Types.TITLE)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Blurer", 13, self.mType ~= Types.TITLE)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Btn", 13, self.mForceButton or self.mType ~= Types.TITLE)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Preview", 13, self.mShowPreview == true)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Arrow", 13, false)
		mMovie:__wf_atom_7f57ab2f(mClipName, "ValueSelector", 13, self.mType == Types.VALUE_SELECTOR)
		mMovie:__wf_atom_7f57ab2f(mClipName, "checkbox", 13, self.mType == Types.CHECKBOX)
		mMovie:__wf_atom_7f57ab2f(mClipName, "CopyColors", 13, self.ShowCopyIcon == true)
		mMovie:__wf_atom_7f57ab2f(mClipName, "DropDown", 13, self.mType == Types.DROP_DOWN)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Toggle", 13, self.mType == Types.TOGGLE)
		mMovie:__wf_atom_7f57ab2f(mClipName, "CustomIcon", 13, not __wf_atom_7e8ad928(self.CustomIcon))
		mMovie:__wf_atom_7f57ab2f(mClipName, "LabelRight", 13, not __wf_atom_7e8ad928(self.NameTagRight))
		mMovie:__wf_atom_7f57ab2f(mClipName, "Desc", 13, mBigButton or self.mShowDesc == true)
		mMovie:__wf_atom_48bd5a59(
			mClipName,
			"LabelRight",
			36,
			module.Ternary(self.NameTagRight ~= nil, self.NameTagRight, "")
		)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Divider", 13, mBigButton)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Highlight", 13, mBigButton)
		mMovie:__wf_atom_7f57ab2f(mClipName, "HighlightMask", 13, mBigButton)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Icon", 13, not __wf_atom_7e8ad928(self.mIcon))
		self:RedrawColorButtons()
		self:RedrawSlider()
		self:RedrawCheckbox()
		self:RedrawToggle()
		self:RedrawDropDown()
		self:RedrawProgressBar()
	end

	v.ComponentSetText = v.SetText

	function v:SetText(p3, value)
		self:ComponentSetText(p3)
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 77, 0)
		local _mLabel = self.mLabel
		local mDesc = value or ""
		self.mDesc = mDesc
		module.SetFitText(mMovie, mClipName .. ".Desc", "...")
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mDesc, false)

		if self.mTitleCase then
			mMovie:__wf_atom_50d60589(mClipName .. ".Desc", 36, TitleCase(__wf_atom_8e9ac384))
		else
			mMovie:__wf_atom_50d60589(mClipName .. ".Desc", 36, string.upper(__wf_atom_8e9ac384))
		end

		self:Resize()
	end

	function v:SetMultiline(p3, _)
		self.mMultiline = p3 ~= false
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Label", 52, self.mMultiline)
	end

	if not __wf_atom_7e8ad928(mSelectedElement) and mSelectedElement.Multiline ~= nil then
		v:SetMultiline(mSelectedElement.Multiline)
	end

	v:SetTextAlignment("left")
	v:Redraw()
	v:Resize()
	object:__wf_atom_384aa4e8(p .. ".Label", "ShowHyperlinkItem")
	return v
end