module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")

function Create(object, mRootClip, p)
	local module3 = require("EE.Interface.Components.List")
	local list = module3.CreateList(object, mRootClip .. ".Category")
	list.mPrefix = "CategoriesMenu(" .. mRootClip .. ")::"
	list.mRootClip = mRootClip
	list.mWrapAroundNavigation = true
	local v = p == nil and "" or p
	list:SetCallbacks(v .. "CategoryPressed", v .. "CategoryFocused", v .. "CategoryUnfocused")
	list.mInitialDepth = 3000
	list.mInitialRootX = object:__wf_atom_5e6e15c8(mRootClip, 0)
	list.mInitialLabelXPos = 5
	list.Modes = { ICON = 1, TEXT = 2, BOTH = 3 }
	list.mDepthDirection = 1
	list.mElementTransitionTime = 0
	list.mMinWidth = 32
	list.mForceWidth = nil
	list.mMinHeight = 32
	list.mIconDim = nil
	list.mSpacing = 3
	list.mForcedHorizontalSeparation = nil
	list.mForcedVerticalSeparation = 0
	list.mPlayAltSelectSound = false
	list.mCalloutSeparation = 32
	list.mPadding = 0
	list.mSelectedBackerExtra = 100
	list.mQueueInstantReposition = false
	list.mApplyThemes = true
	list.mAlign = module.CENTER_ALIGNED
	list.mContentAlign = module.LEFT_ALIGNED
	list.mShowCurrentSelectionLabel = true
	list.mDisplayMode = list.Modes.ICON
	list.mShowToolTips = false
	list.mShowCallouts = true

	function list.SetupPreInterpolationValues(_, _) end

	list.GetInterpolationProperties = list.DefaultAlphaInterpolation

	function list.Print(_, _) end

	function list:ShowCurrSelection()
		local mShowCurrentSelectionLabel = self.mShowCurrentSelectionLabel

		if mShowCurrentSelectionLabel then
			if self.mDisplayMode == self.Modes.ICON then
				mShowCurrentSelectionLabel = not self.mShowToolTips
			else
				mShowCurrentSelectionLabel = false
			end
		end

		return mShowCurrentSelectionLabel
	end

	function list:SetCategoryLabel(mCurrentCategoryLabel)
		if self.mCurrentCategoryLabel ~= mCurrentCategoryLabel then
			self.mCurrentCategoryLabel = mCurrentCategoryLabel

			if self:ShowCurrSelection() then
				module.AnimateTyping(
					self.mMovie,
					_G.UISound_Type,
					self.mRootClip .. ".CurrentCategory",
					string.upper(self.mCurrentCategoryLabel),
					nil
				)
			end
		end
	end

	function list:DrawCallouts()
		local v2 = list
		local mShowCallouts = Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()

		if mShowCallouts then
			if self:GetHowManyElements() > 1 then
				mShowCallouts = self.mShowCallouts
			else
				mShowCallouts = false
			end
		end

		v2.mVisibleCallouts = mShowCallouts

		if list.mVisibleCallouts then
			self.mMovie:__wf_atom_7d7314f1(self.mRootClip .. ".LeftBumper.Tf.text", "<MENU_LTRIGGER2>")
			self.mMovie:__wf_atom_7d7314f1(self.mRootClip .. ".RightBumper.Tf.text", "<MENU_RTRIGGER2>")
			list.mVisibleCallouts = (self.mMovie:__wf_atom_5e6e15c8(self.mRootClip .. ".LeftBumper.Tf", 40) or 0) > 0
		end

		self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "LeftBumper", 13, list.mVisibleCallouts)
		self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "RightBumper", 13, list.mVisibleCallouts)
	end

	function list.mOnFocusedCallback(p2)
		if not list.mMuteFocusSound then
			module.PlaySound(_G.UISound_Focus)
		end

		if not (Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()) then
			list:SetCategoryLabel(p2.Name, p2)
		end

		if list.mShowToolTips then
			_T.gToolTip = p2.Name
		end

		__wf_atom_ec43d06e(list.mMovie, p2.mClipName .. ".Highlight.Light", 2, { 15 }, { 61 }, 0.15)
		list:UpdateColors(p2, true)
	end

	function list.mOnUnfocusedCallback(p2)
		if
			not Engine.IsPlayingWithController()
			and not Engine.__wf_atom_5df63302()
			and list.mSelectedElement ~= nil
		then
			list:SetCategoryLabel(list.mSelectedElement.Name, list.mSelectedElement)
		end

		_T.gToolTip = nil
		__wf_atom_ec43d06e(list.mMovie, p2.mClipName .. ".Highlight.Light", 8, { 15 }, { 0.1 }, 0.15)
		list:UpdateColors(p2, false)
	end

	function list:RepositionElements(p2)
		local mMovie = self.mMovie
		local mInitialRootX = self.mInitialRootX

		if self.mVisibleCallouts and not self.mSkipCalloutReposition then
			mInitialRootX += self.mCalloutSeparation
		end

		mMovie:__wf_atom_e57658c2(self.mRootClip, 0, mInitialRootX)
		local mInitialX = self.mInitialX
		local mElements = self.mElements
		local count = #mElements
		local v2 = {}
		local v3 = 0

		for i = 1, count do
			v2[i] = v3

			if self.mForcedHorizontalSeparation == nil then
				local v4

				if self.mForceWidth == nil then
					local mClipName = mElements[i].mClipName

					if
						mClipName ~= nil
						and (self.mDisplayMode == self.Modes.TEXT or self.mDisplayMode == self.Modes.BOTH)
					then
						v3 += 13 + mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
					end

					if self.mDisplayMode ~= self.Modes.TEXT then
						v3 += 30
					end

					v4 = v3 + self.mPadding * 2
				else
					v4 = v3 + self.mForceWidth
				end

				v3 = v4 + self.mSpacing
			else
				v3 += self.mForcedHorizontalSeparation
			end
		end

		if self.mAlign == module.CENTER_ALIGNED then
			mInitialX -= module.Round(v3 * 0.5)
		elseif self.mAlign == module.RIGHT_ALIGNED then
			mInitialX -= v3
		end

		local ternary = module.Ternary(p2, 0, 0.2)

		for i = 1, count do
			local mClipName = mElements[i].mClipName

			if mClipName ~= nil then
				__wf_atom_ec43d06e(mMovie, mClipName, 8, { 0 }, { mInitialX + v2[i] }, ternary)
			end
		end

		if self.mVisibleCallouts then
			local v4 = mInitialX - self.mCalloutSeparation / 2
			local v5 = mInitialX + v3 + self.mCalloutSeparation / 2
			__wf_atom_ec43d06e(mMovie, self.mRootClip .. ".LeftBumper", 8, { 0 }, { v4 }, ternary)
			__wf_atom_ec43d06e(mMovie, self.mRootClip .. ".RightBumper", 8, { 0 }, { v5 }, ternary)
		end
	end

	list._CategoryMenu_OnSelected = list.OnSelected

	function list:OnSelected(p2, p3)
		if self.mSelectedElement ~= nil then
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Underline", 8, { 12 }, { 30 }, 0.2)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "Btn", 67, true)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "RightBookend", 13, false)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "LeftBookend", 13, false)
			list:UpdateColors(self.mSelectedElement, false, false)

			if p3 then
				module.PlaySound(_G.UISound_ButtonSelect)
				module.PlaySound(_G.UISound_ItemTipSection)
			end
		end

		list:UpdateColors(p2, false, true)

		if self.mPlayAltSelectSound then
			module.PlaySound(_G.UISound_GridOpen)
		end

		self:_CategoryMenu_OnSelected(p2, p3)

		if p2 then
			self.mMovie:__wf_atom_7f57ab2f(p2.mClipName, "Btn", 67, false)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "RightBookend", 13, true)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "LeftBookend", 13, true)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Underline", 8, { 12 }, { 100 }, 0.2)
			self:SetCategoryLabel(self.mSelectedElement.Name, self.mSelectedElement)
			self:OnUnfocused(p2)
		end

		self:RepositionElements(self.mQueueInstantReposition)
		self.mQueueInstantReposition = false
	end

	function list:UpdateColors(data, p2, p3)
		if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.mClipName) then
			return
		end

		local focusedElement = self:GetFocusedElement()
		local ternary = module.Ternary
		local v2 = p2 ~= nil
		local v3

		if focusedElement == nil then
			v3 = false
		else
			v3 = focusedElement.Id == data.Id
		end

		local v4 = ternary(v2, p2, v3)
		local ternary2 = module.Ternary
		local v5 = p3 ~= nil
		local v6

		if self.mSelectedElement == nil then
			v6 = false
		else
			v6 = self.mSelectedElement.Id == data.Id
		end

		local v7 = ternary2(v5, p3, v6)
		local mApplyThemes = self.mApplyThemes
		local color = module2.GetColor(2, true, mApplyThemes)
		local color2 = module2.GetColor(9, true, mApplyThemes)
		local color3 = module2.GetColor(10, true, mApplyThemes)
		local uiColor_White, v8, v9, v10

		if v7 then
			uiColor_White = color3
			v8 = 100
			v9 = 100
			v10 = 0.45
		else
			uiColor_White = color2
			v8 = 80
			v9 = 30
			v10 = 0.005
		end

		if v4 then
			uiColor_White = color3
			v9 = 100
			v10 = 0.45
		end

		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "UnderLine", 11, uiColor_White)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, uiColor_White)

		if data.ThemeIcon ~= nil and not data.ThemeIcon then
			uiColor_White = _G.UIColor_White
		end

		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, uiColor_White)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, v8)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 12, v8)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "UnderLine", 12, v9)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Highlight", 11, color3)
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module.Ternary(v7, color, color))
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module.Ternary(v7 or v4, color3, color2))
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Backer.Fill",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			v10
		)
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Backer.Fill",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.6
		)
		self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "CurrentCategory", 44, color2)
		self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "LeftBumper.Tf", 11, color2)
		self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "RightBumper.Tf", 11, color2)
	end

	list._CategoryMenu_OnDraw = list.OnDraw

	function list.OnDraw(object2, data, p2)
		object2:_CategoryMenu_OnDraw(data, p2)
		local mMovie = object2.mMovie
		local mClipName = data.mClipName
		local v2

		if object2.mSelectedElement == nil then
			v2 = false
		else
			v2 = object2.mSelectedElement.Id == data.Id
		end

		mMovie:__wf_atom_7f57ab2f(mClipName, "Btn", 67, not v2)
		mMovie:__wf_atom_7f57ab2f(mClipName, "RightBookend", 13, v2)
		mMovie:__wf_atom_7f57ab2f(mClipName, "LeftBookend", 13, v2)
		mMovie:__wf_atom_7f57ab2f(
			mClipName,
			"Label",
			13,
			object2.mDisplayMode == object2.Modes.TEXT or object2.mDisplayMode == object2.Modes.BOTH
		)
		mMovie:__wf_atom_7f57ab2f(
			mClipName,
			"Icon",
			13,
			object2.mDisplayMode == object2.Modes.ICON or object2.mDisplayMode == object2.Modes.BOTH
		)
		mMovie:__wf_atom_7f57ab2f(mClipName, "UpperIcon", 13, false)
		mMovie:__wf_atom_48bd5a59(mClipName, "Label", 36, data.Name)
		local mPadding = 0
		local v3 = 30
		local mForceWidth

		if object2.mForceWidth == nil then
			if object2.mForcedHorizontalSeparation == nil then
				mPadding = object2.mPadding

				if object2.mDisplayMode == object2.Modes.TEXT or object2.mDisplayMode == object2.Modes.BOTH then
					local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
					v3 = module.Ternary(object2.mDisplayMode == object2.Modes.BOTH, v3, 0) + __wf_atom_5e6e15c8 + 8
				end

				mForceWidth = math.max(v3 + mPadding * 2, object2.mMinWidth - 2)
			else
				mForceWidth = object2.mForcedHorizontalSeparation - object2.mSpacing
			end
		else
			mForceWidth = object2.mForceWidth
		end

		local v4 = 0

		if
			object2.mForceWidth ~= nil and object2.mContentAlign == module.CENTER_ALIGNED
			or object2.mContentAlign == module.RIGHT_ALIGNED
		then
			local total = 0

			if object2.mDisplayMode == object2.Modes.ICON or object2.mDisplayMode == object2.Modes.BOTH then
				total += 30
			end

			if object2.mDisplayMode == object2.Modes.TEXT or object2.mDisplayMode == object2.Modes.BOTH then
				total += mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
			end

			local v5 = object2.mForceWidth - total

			if object2.mContentAlign == module.CENTER_ALIGNED then
				v4 = v5 * 0.5
			elseif object2.mContentAlign == module.RIGHT_ALIGNED then
				v4 = v5
			end

			v4 -= object2.mInitialLabelXPos
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
		local v5 = object2.mInitialLabelXPos + module.Ternary(object2.mDisplayMode == object2.Modes.BOTH, 30, 2) + mPadding + v4
		mMovie:__wf_atom_e57658c2(mClipName .. ".Label", 0, v5)
		local v6 = mForceWidth + 2
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 15, object2.mMinHeight)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 14, v6)
		mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 15, object2.mMinHeight)
		mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, v6)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 14, mForceWidth * 2.04)
		mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 14, mForceWidth)
		mMovie:__wf_atom_4c1c1986(mClipName, "RightBookend", 0, __wf_atom_5e6e15c8 + 35)
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 0, v6 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 0, v6 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 0, v6 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 1, object2.mMinHeight / 2 - 16)
		mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 0, v6 / 2)
		mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 1, object2.mMinHeight / 2 - 2)
		local mIconDim = object2.mIconDim or object2.mMinHeight - 8
		mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", data.Icon)

		if object2.mDisplayMode == object2.Modes.BOTH then
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, object2.IconX + mPadding + v4)
		else
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, v6 / 2 + v4)
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, mIconDim)
		mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, mIconDim)
		mMovie:OverrideMaterial(mClipName .. ".Backer.Fill", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight.Light", 15, 0.1)
		list:UpdateColors(data)
	end

	list._CategoryMenu_Redraw = list.Redraw

	function list:Redraw(p2, p3, p4)
		local v2 = self.mCurrentCategoryLabel == nil and "" or self.mCurrentCategoryLabel
		self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "CurrentCategory", 1, -self.mMinHeight + 4)

		if self:ShowCurrSelection() then
			self.mMovie:__wf_atom_48bd5a59(self.mRootClip, "CurrentCategory", 36, string.upper(v2))
		else
			self.mMovie:__wf_atom_48bd5a59(self.mRootClip, "CurrentCategory", 36, "")
		end

		self:DrawCallouts()
		self:_CategoryMenu_Redraw(p2, p3, p4)
	end

	list._CategoryMenu_OnFirstRedraw = list.OnFirstRedraw

	function list:OnFirstRedraw()
		self.IconX = self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Icon", 0)
		self:_CategoryMenu_OnFirstRedraw()
	end

	function list:OnGamepadTransition(_)
		self:DrawCallouts()
		self:RepositionElements(true)
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

	function list:HookUpCallbacks()
		assert(not self.mHookedUpCallbacks)
		self.mHookedUpCallbacks = true
		local parentEnv = self:GetParentEnv()
		local v2 = "OnGamepadTransition"

		while parentEnv["Prev_" .. v2] ~= nil do
			v2 = "Prev_" .. v2
		end

		parentEnv["Prev_" .. v2] = parentEnv.OnGamepadTransition
		local v3 = parentEnv["Prev_" .. v2] ~= nil

		function parentEnv.OnGamepadTransition(p2)
			if v3 then
				parentEnv["Prev_" .. v2](p2)
			end

			self:OnGamepadTransition(p2 == "true")
		end
	end

	list:HookUpCallbacks()
	list:Redraw()
	return list
end