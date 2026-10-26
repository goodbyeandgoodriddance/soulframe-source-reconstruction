module(..., package.seeall)

function Create(mMovie2, mClipName2, value, p, mCallout, p2, mIgnoreCursorCallback, mParentEnv, items, p3)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local result = {
		mMovie = mMovie2,
		mClipName = mClipName2,
		mCallout = mCallout,
		mId = nil,
		mPrefixCallout = true,
		mIsVisible = true,
		mActive = true,
		mFocused = false,
		mSelected = false,
		mLockFocus = false,
		mApplyThemes = true,
		mLabel = value or "",
		mToUpper = false,
		mLocalizeText = true,
		mConvertEmoticons = false,
		mFormatPrefix = "",
		mFormatSuffix = "",
		mLabelPrefix = "",
		mWidth = nil,
		mHeight = module.Ternary(Engine.__wf_atom_2a979d69(), 50, 32),
		mMinSize = 50,
		mMaxSize = nil,
		mOnFocusedCallback = nil,
		mOnUnfocusedCallback = nil,
		mOnPressedCallback = nil,
		mOnReleasedCallback = nil,
		mIgnoreCursorCallback = mIgnoreCursorCallback,
		mIconOverride = nil,
		mIconDefaultWidth = 32,
		mIconDefaultHeight = 32,
		mIconWidth = 0,
		mIconHeight = 0,
		mIconSimWidth = nil,
		mIconAlignment = module.RIGHT_ALIGNED,
		mTintIcon = true,
		mAnchor = module.LEFT_ALIGNED,
		mVerticalCenterText = true,
		mAlignment = "center",
		mTextBuffer = 14,
		mLabelYOffset = 0,
		mLabelXOffset = 2,
		mIconXOffset = 0,
		mParentEnv = mParentEnv,
		mShowUnderline = true,
		mShowUnderline2 = true,
		mShowHighlight = true,
		mHighlightAlwaysVis = false,
		mShowCallout = p2 == nil or p2 == true,
		mForceCallout = p3 == true,
		mForceBacker = false,
		mShowIcon = nil,
		mEdgeAlpha = 4,
		mInnerAlpha = 60,
		mUnderlineAlpha = 30,
		mUnfocusedEdgeColor = 2,
		mActiveColor = nil,
		mActiveAlpha = 100,
		mInactiveAlpha = 50,
		mInactiveColor = nil,
		mSilent = false,
		mSpecial = false,
		mVisRangeMaterials = nil,
		mBackerMaterial = nil,
		mPostText = nil,
		mRequiresHold = nil,
		GetParentEnv = function(self)
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v = 1
			local mParentEnv2

			repeat
				mParentEnv2 = getfenv(v)
				v += 1
			until mParentEnv2.mMovie

			self.mParentEnv = mParentEnv2
			return mParentEnv2
		end,
		HookUpCallbacks = function(self, p4)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local parentEnv = self:GetParentEnv()

			if not __wf_atom_7e8ad928(self.mCallout) and self.mCallout ~= "" then
				local v = "onKeyUp_" .. string.sub(self.mCallout, 2, -2)
				local v2 = "onKeyDown_" .. string.sub(self.mCallout, 2, -2)

				if __wf_atom_7e8ad928(parentEnv[v]) and __wf_atom_7e8ad928(parentEnv[v2]) then
					parentEnv[v] = function()
						if not self:IsActive() then
							return
						end

						self:TryPressed(false, true)
					end

					parentEnv[v2] = function()
						if not self:IsActive() then
							return
						end

						self:TryPressed(true, true)
					end
				end
			end

			if not __wf_atom_7e8ad928(p4) and __wf_atom_7e8ad928(self.mOnPressedCallback) then
				self.mOnPressedCallback = parentEnv[p4]
			end

			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local v = string.gsub(mClipName, "%.", "")

			parentEnv[v .. "Over"] = function(p5)
				if self:InvalidId(p5) then
					return
				end

				self.mHovered = true

				if self.mToolTip ~= nil then
					_T.gToolTip = self.mToolTip
				end

				self:TrySetFocus(true)
			end

			parentEnv[v .. "Out"] = function(p5)
				if self:InvalidId(p5) then
					return
				end

				self.mHovered = nil

				if self.mToolTip ~= nil then
					_T.gToolTip = nil
				end

				self:TrySetFocus(false)
			end

			parentEnv[v .. "Press"] = function(p5)
				if self:InvalidId(p5) then
					return
				end

				self:TryPressed(true)
			end

			parentEnv[v .. "Release"] = function(p5)
				if self:InvalidId(p5) then
					return
				end

				self:TryPressed(false)
			end

			mMovie:SetCallbacks(mClipName .. ".Btn", v .. "Over", v .. "Out", v .. "Release", v .. "Press")

			if Engine.__wf_atom_2a979d69() then
				mMovie:SetReleaseOutsideCallback(mClipName .. ".Btn", v .. "Release")
			end

			self:SetId(self.mId)

			if not self.mIgnoreCursorCallback then
				module.HookUpEnvironmentCallback(mClipName, parentEnv, "OnGamepadTransition", function(p5)
					self:OnGamepadTransition(p5 == "true")
				end)
			end
		end,
		InvalidId = function(self, p4)
			return self.mId ~= nil and tonumber(p4) ~= self.mId
		end,
		SetId = function(self, mId)
			self.mId = mId

			if self.mId ~= nil then
				self.mMovie:__wf_atom_e57658c2(self.mClipName .. ".Btn", 100, self.mId)
			end
		end,
		HookUpDragCallbacks = function(self)
			assert(not self.mHookedUpDragCallbacks)
			self.mHookedUpDragCallbacks = true
			local parentEnv = self:GetParentEnv()
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local v = string.gsub(mClipName, "%.", "")

			parentEnv[v .. "DragOver"] = function(p4)
				if self:InvalidId(p4) then
					return
				end

				self:TrySetDrag(false)
			end

			parentEnv[v .. "DragOut"] = function(p4)
				if self:InvalidId(p4) then
					return
				end

				self:TrySetDrag(true)
			end

			mMovie:__wf_atom_c0d7a318(mClipName, "Btn", "trackAsMenu", true)
			mMovie:SetDragCallbacks(mClipName .. ".Btn", v .. "DragOver", v .. "DragOut")
		end,
		Interpolate = function(self, p4)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mFocused = self.mFocused
			local ternary = module.Ternary
			__wf_atom_ec43d06e(
				mMovie,
				mClipName .. ".Highlight",
				2,
				{ 12, 15 },
				{
					ternary(mFocused or self.mHighlightAlwaysVis, 50, 0),
					ternary(mFocused or self.mHighlightAlwaysVis, self.mHeight + 4, 1)
				},
				ternary(p4, 0, 0.35)
			)
			__wf_atom_ec43d06e(
				mMovie,
				mClipName .. ".Underline",
				2,
				{ 14, 0 },
				{ ternary(mFocused, self.mWidth, 1), ternary(mFocused, 0, self.mWidth * 0.5) },
				ternary(p4, 0, 0.15),
				0,
				function()
					if not mFocused then
						mMovie:__wf_atom_7f57ab2f(mClipName, "Underline", 13, false)
					end
				end
			)
		end,
		PlaySound = function(p4, p5)
			if not p4.mSilent then
				module.PlaySound(p5)
			end
		end,
		TrySetDrag = function(self, p4)
			local ternary = module.Ternary(p4, self.mOnDragOutCallback, self.mOnDragOverCallback)

			if __wf_atom_7e8ad928(ternary) or ternary(self, p4) ~= false then
				self:SetDrag(p4)
			end
		end,
		SetDrag = function(self, p4)
			if not self.mActive then
				return
			end

			if self.mPressed and p4 and not self.mDragging then
				self.mDragging = true
				local mMovie = self.mMovie
				local mClipName = self.mClipName
				local v = (mMovie:__wf_atom_5e6e15c8(mClipName, 0) or 0) + (mMovie:__wf_atom_5e6e15c8(mClipName, 30) or 0)
				local v2 = (mMovie:__wf_atom_5e6e15c8(mClipName, 1) or 0) + ((mMovie:__wf_atom_5e6e15c8(mClipName, 31) or 0) - self.mHeight - 1)
				mMovie:__wf_atom_e57658c2(mClipName, 0, v)
				mMovie:__wf_atom_e57658c2(mClipName, 1, v2)
				__wf_atom_86cbd68d(mMovie, mClipName .. ".startDrag")
			end
		end,
		StopDrag = function(self)
			if self.mDragging then
				self.mDragging = false
				__wf_atom_86cbd68d(self.mMovie, "stopDrag")
				self:SetPosition()
			end
		end,
		IsFocusBlocked = function(self, p4)
			return self.mFocused == p4 or (not self.mActive or self.mLockFocus)
		end,
		TrySetFocus = function(self, p4)
			if not p4 then
				self.mPressed = false
				self:StopDrag()
			end

			if self:IsFocusBlocked(p4) then
				return
			end

			local ternary = module.Ternary(p4, self.mOnFocusedCallback, self.mOnUnfocusedCallback)

			if __wf_atom_7e8ad928(ternary) or ternary(self, p4) ~= false then
				self:SetFocus(p4)
			end
		end,
		SetFocus = function(self, mFocused)
			if self:IsFocusBlocked(mFocused) then
				return
			end

			self.mFocused = mFocused
			self:UpdateColors()

			if mFocused then
				self:PlaySound(_G.UISound_Focus)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Underline", 13, self.mShowUnderline)
			end

			self:Interpolate()
		end,
		TryPressed = function(self, p4, p5)
			if self.mRequiresHold == nil then
				local ternary = module.Ternary(p4, self.mOnPressedCallback, self.mOnReleasedCallback)

				if __wf_atom_7e8ad928(ternary) or ternary(self, p4, p5) ~= false then
					self:Pressed(p4, p5)

					if self.mOnPressCompletedCallback ~= nil then
						self.mOnPressCompletedCallback(self, p4, p5)
					end
				end
			elseif p4 then
				if self.mOnPressedCallback ~= nil then
					self.mOnPressedCallback(self, p4, p5)
				end

				self.mHoldInterpolation = __wf_atom_ec43d06e(
					self.mMovie,
					self.mClipName .. ".HoldFill",
					0,
					{ function(p6)
							self.mMovie:__wf_atom_4c1c1986(
								self.mClipName,
								"HoldFill",
								12,
								(math.min(p6 / 0.1 * 50, 50))
							)
							self.mMovie:__wf_atom_4c1c1986(
								self.mClipName,
								"HoldFill",
								14,
								__wf_atom_104bfe98(0.2, 1, p6) * (self.mWidth + 2)
							)
						end },
					{ 1 },
					self.mRequiresHold,
					0,
					function()
						self.mHoldInterpolation = nil
						__wf_atom_ec43d06e(self.mMovie, self.mClipName .. ".HoldFill", 0, { 12 }, { 0 }, 0.2)

						if self.mOnReleasedCallback ~= nil then
							self.mOnReleasedCallback(self, p4, p5)
						end
					end
				)
			elseif self.mHoldInterpolation ~= nil then
				self.mHoldInterpolation = nil
				__wf_atom_ec43d06e(self.mMovie, self.mClipName .. ".HoldFill", 2, { 14, 12 }, { 1, 0 }, 0.25)
			end
		end,
		Pressed = function(self, mPressed, _)
			if not self.mActive then
				return
			end

			self.mPressed = mPressed

			if not mPressed then
				self:StopDrag()
				return
			end

			if _T.RadialSolarMapOpen == true then
				return
			end

			self:PlaySound(_G.UISound_ButtonSelect)
		end,
		OnGamepadTransition = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local isPlayingWithController = self:IsPlayingWithController()
			local v = isPlayingWithController and not self.mPrefixCallout
			local v2 = not (self.mPrefixCallout and isPlayingWithController) or self.mSpecial or self.mForceBacker
			mMovie:__wf_atom_7f57ab2f(mClipName, "Btn", 67, v2 and self.mActive)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Backer", 13, v2)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Blurer", 13, v2)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Highlight", 13, v2 and self.mShowHighlight)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Underline", 13, v2 and self.mShowUnderline and self.mFocused)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Underline2", 13, v2 and self.mShowUnderline and self.mShowUnderline2)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Callout", 13, v)
			mMovie:__wf_atom_48bd5a59(mClipName, "Callout", 36, mMovie:__wf_atom_8e9ac384(self.mCallout, true))

			if self.mShowIcon == nil then
				mMovie:__wf_atom_7f57ab2f(mClipName, "Icon", 13, not v)
			end

			if self.mIconOverride == nil and mMovie:__wf_atom_253d7085(mClipName .. ".Icon") then
				if v then
					self.mIconWidth = 0
					self.mIconHeight = 0
				else
					self.mIconWidth = self.mIconDefaultWidth
					self.mIconHeight = self.mIconDefaultHeight
				end

				self.mWidth = nil
			end

			self:SetText(self.mLabel)
		end,
		Resize = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mMinSize = self.mMinSize
			local mMaxSize = self.mMaxSize
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
			local mHeight = self.mHeight
			local mTextBuffer = self.mTextBuffer
			local v = self.mShowIcon == false and 0 or self.mIconSimWidth or self.mIconWidth
			local mWidth = __wf_atom_5e6e15c8 == nil and (mMinSize or 150) or __wf_atom_5e6e15c8 + mTextBuffer * 2 + v

			if mMinSize ~= nil and mWidth < mMinSize then
				mWidth = math.max(mMinSize, 10)
			end

			if mMaxSize ~= nil and mMaxSize < mWidth then
				mWidth = mMaxSize
			end

			if self.mIconAlignment == module.LEFT_ALIGNED then
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 0, v + mTextBuffer + self.mLabelXOffset)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, v / 2 + self.mIconXOffset)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 0, mTextBuffer + self.mLabelXOffset)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, mWidth - v / 2 + self.mIconXOffset)
			end

			local rounded

			if self.mVerticalCenterText then
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 41)
				local v2 = __wf_atom_5e6e15c8_2 == nil and 20 or __wf_atom_5e6e15c8_2 + 7
				rounded = module.Round((mHeight - v2) / 2)
			else
				rounded = 5
			end

			self.mLabelY = rounded
			mMovie:__wf_atom_4c1c1986(
				mClipName,
				"Callout",
				0,
				mWidth - (mMovie:__wf_atom_5e6e15c8(mClipName .. ".Callout", 40) or 0) - mTextBuffer
			)
			mMovie:__wf_atom_4c1c1986(mClipName, "Callout", 1, rounded)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 1, rounded + self.mLabelYOffset)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 14, mWidth - mTextBuffer * 2 - v)

			if self.mPostText == nil then
				mMovie:__wf_atom_e57658c2(mClipName .. ".Label", 93, -1)
			else
				module.SetFitText(mMovie, mClipName .. ".Label", self.mPostText)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, mWidth + module.Ternary(self.mSpecial, 85, 0))
			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 15, mHeight + module.Ternary(self.mSpecial, 2, 0))
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 1, mHeight / 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 14, mWidth + 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Blurer", 14, mWidth + 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 15, mHeight)
			mMovie:__wf_atom_4c1c1986(mClipName, "Blurer", 15, mHeight)
			mMovie:__wf_atom_4c1c1986(mClipName, "HoldFill", 15, mHeight)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline2", 14, mWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline2", 1, mHeight - 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 1, mHeight - 2)

			if not self.mSpecial then
				mMovie:__wf_atom_4c1c1986(mClipName, "HighlightMask", 14, mWidth)
				mMovie:__wf_atom_4c1c1986(mClipName, "HighlightMask", 15, mHeight)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 0, mWidth * 0.5)
			mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 1, mHeight - module.Ternary(self.mSpecial, 0, 2))
			mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 14, mWidth * module.Ternary(self.mSpecial, 1.2, 1.35))

			if self.mSpecial then
				mMovie:__wf_atom_4c1c1986(mClipName, "BgCapRight", 0, mWidth + 66)
				mMovie:__wf_atom_4c1c1986(mClipName, "BlurerCapRight", 0, mWidth + 66)
				mMovie:__wf_atom_4c1c1986(mClipName, "SmallBlurerCapRight", 0, mWidth + 66)
				mMovie:__wf_atom_4c1c1986(mClipName, "OutlineCapRight", 0, mWidth + 66)
				mMovie:__wf_atom_4c1c1986(mClipName, "Edge", 14, mWidth + 2)
				mMovie:__wf_atom_4c1c1986(mClipName, "Blurer", 14, mWidth + 4)
			end

			if self.mSelected then
				mMovie:__wf_atom_2004c47f()
			end

			self.mWidth = mWidth
			self.mSelected = false
			self.mFocused = false
			self:Interpolate(true)
			self:SetAnchor()
			self:UpdateColors()
		end,
		UpdateColors = function(self)
			local mMovie = self.mMovie

			if __wf_atom_7e8ad928(mMovie) then
				return
			end

			local mClipName = self.mClipName
			local mApplyThemes = self.mApplyThemes
			local color = module2.GetColor(10, true, mApplyThemes)
			local mUnfocusedColor = self.mUnfocusedColor or module2.GetColor(9, true, mApplyThemes)
			local color2 = module2.GetColor(self.mUnfocusedEdgeColor, true, mApplyThemes)
			local color3 = module2.GetColor(2, true, mApplyThemes)
			local mInnerColor = self.mInnerColor or color3
			local mEdgeAlpha = self.mEdgeAlpha

			if self.mActive and self.mActiveColor ~= nil then
				mUnfocusedColor = self.mActiveColor
			elseif self.mActive or self.mInactiveColor == nil then
				if self.mFocused then
					mUnfocusedColor = color
				end
			else
				mUnfocusedColor = self.mInactiveColor
			end

			if self.mFocused then
				color2 = module2.GetColor(1, true, mApplyThemes)

				if self.mFocusedEdgeAlpha ~= nil then
					mEdgeAlpha = self.mFocusedEdgeAlpha
				end
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 11, color)
			mMovie:__wf_atom_4c1c1986(mClipName, "HoldFill", 11, color)
			mMovie:__wf_atom_4c1c1986(mClipName, "Callout", 11, mUnfocusedColor)

			if self.mThemeLabel == false then
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 11, _G.UIColor_White)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 11, mUnfocusedColor)
			end

			if self.mTintIcon then
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, mUnfocusedColor)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, _G.UIColor_White)
			end

			if self.mSpecial then
				mMovie:__wf_atom_4c1c1986(mClipName, "BgCapLeft", 11, mInnerColor)
				mMovie:__wf_atom_4c1c1986(mClipName, "BgCapLeft", 12, self.mInnerAlpha)
				mMovie:__wf_atom_4c1c1986(mClipName, "BgCapRight", 11, mInnerColor)
				mMovie:__wf_atom_4c1c1986(mClipName, "BgCapRight", 12, self.mInnerAlpha)
				mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 11, mInnerColor)
				mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, self.mInnerAlpha)
				mMovie:__wf_atom_4c1c1986(mClipName, "Edge", 11, mUnfocusedColor)
				mMovie:__wf_atom_4c1c1986(mClipName, "OutlineCapLeft", 11, mUnfocusedColor)
				mMovie:__wf_atom_4c1c1986(mClipName, "OutlineCapRight", 11, mUnfocusedColor)
			else
				local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(mInnerColor)
				local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color2)
				mMovie:__wf_atom_1ca72041(
					mClipName .. ".Backer",
					"RectEdgeColor",
					convertColorNumberToProceduralRGB2.r,
					convertColorNumberToProceduralRGB2.g,
					convertColorNumberToProceduralRGB2.b,
					mEdgeAlpha / 100
				)
				mMovie:__wf_atom_1ca72041(
					mClipName .. ".Backer",
					"RectInnerColor",
					convertColorNumberToProceduralRGB.r,
					convertColorNumberToProceduralRGB.g,
					convertColorNumberToProceduralRGB.b,
					self.mInnerAlpha / 100
				)
				mMovie:__wf_atom_1ca72041(mClipName .. ".HoldFill", "RectEdgeColor", 1, 1, 1, 0.5)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 11, mUnfocusedColor)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline2", 11, mUnfocusedColor)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline2", 12, self.mUnderlineAlpha)
		end,
		Redraw = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName

			if self.mVisRangeMaterials == nil then
				local ternary = module.Ternary(
					__wf_atom_7e8ad928(self.mBackerMaterial),
					_G.UIMaterial_Button,
					self.mBackerMaterial
				)
				mMovie:OverrideMaterial(mClipName .. ".Backer", module.Ternary(self.mSpecial, nil, ternary))
				mMovie:OverrideMaterial(mClipName .. ".HoldFill", module.Ternary(self.mSpecial, nil, ternary))
			else
				mMovie:OverrideMaterial(mClipName .. ".Backer", self.mVisRangeMaterials.BackerMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Label", self.mVisRangeMaterials.TextMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Highlight", self.mVisRangeMaterials.BaseMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Blurer", self.mVisRangeMaterials.BaseMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Underline", self.mVisRangeMaterials.BaseMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Underline2", self.mVisRangeMaterials.BaseMaterial)
				mMovie:OverrideMaterial(mClipName .. ".Icon", self.mVisRangeMaterials.BaseMaterial)
				mMovie:OverrideMaterial(mClipName .. ".HoldFill", self.mVisRangeMaterials.BaseMaterial)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "HoldFill", 12, 0)
			mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 12, module.Ternary(self.mHighlightAlwaysVis, 50, 0))
			mMovie:__wf_atom_4c1c1986(
				mClipName,
				"Highlight",
				15,
				module.Ternary(self.mHighlightAlwaysVis, self.mHeight + 4, 1)
			)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Underline", 13, false)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 14, 1)

			if self.mFontSize ~= nil then
				mMovie:__wf_atom_e57658c2(mClipName .. ".Label", 50, self.mFontSize)
			end

			self:UpdateColors()
			self:OnGamepadTransition()
		end,
		SetText = function(self, value2, p4)
			local v = p4 == nil or p4
			local mLabel = value2 or ""
			local v2 = self.mLabel ~= mLabel
			self.mLabel = mLabel

			if self.mLocalizeText then
				mLabel = self.mMovie:__wf_atom_8e9ac384(mLabel, true)
			end

			if self.mConvertEmoticons then
				mLabel = self.mMovie:__wf_atom_b4b867f2(mLabel, true)
			end

			if string.len(self.mLabelPrefix) > 0 then
				mLabel = self.mLabelPrefix .. mLabel
			end

			if self.mToUpper then
				mLabel = string.upper(mLabel)
			elseif self.mTitleCase then
				mLabel = TitleCase(mLabel)
			end

			if v then
				if self:IsPlayingWithController() and self.mPrefixCallout then
					local __wf_atom_8e9ac384 = self.mMovie:__wf_atom_8e9ac384(self.mCallout, true)
					self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 36, __wf_atom_8e9ac384)

					if (self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 40) or 0) > 0 then
						mLabel = __wf_atom_8e9ac384 .. " " .. mLabel
					end
				end

				self.mMovie:__wf_atom_50d60589(
					self.mClipName .. ".Label",
					36,
					self.mFormatPrefix .. mLabel .. self.mFormatSuffix
				)
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 45, self.mAlignment)
			end

			if
				v2
				or self.mMinSize ~= self.mMaxSize
				or self.mWidth == nil
				or self.mMinSize ~= nil and self.mWidth < self.mMinSize
				or self.mMaxSize ~= nil and self.mWidth > self.mMaxSize
			then
				self:Resize()
			end
		end,
		SetTextAlignment = function(state, value2)
			state.mAlignment = value2 or "center"
			state.mMovie:__wf_atom_48bd5a59(state.mClipName, "Label", 45, state.mAlignment)
		end,
		SetMinWidth = function(self, mMinSize)
			self.mMinSize = mMinSize
			self:Resize()
		end,
		SetWidth = function(self, p4)
			self.mMinSize = p4
			self.mMaxSize = p4
			self:Resize()
		end,
		SetIcon = function(self, mIconOverride, p4, p5)
			self.mIconOverride = mIconOverride

			if mIconOverride == nil then
				self.mShowIcon = nil
				self:OnGamepadTransition()
			else
				self:SetIconVisible(true)
				self.mIconWidth = p4 or self.mIconDefaultWidth
				self.mIconHeight = p5 or p4 or self.mIconDefaultHeight
			end

			self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", mIconOverride)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, (math.max(self.mIconWidth, 1)))
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 15, (math.max(self.mIconHeight, 1)))
		end,
		SetIconVisible = function(self, p4)
			local mShowIcon = p4 == true
			self.mShowIcon = mShowIcon

			if not __wf_atom_7e8ad928(self.mMovie) then
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, mShowIcon)
			end

			if self.mIconOverride == nil then
				self:OnGamepadTransition()
			end
		end,
		SetVisible = function(state, p4)
			local mIsVisible = p4 == true
			state.mIsVisible = mIsVisible

			if not __wf_atom_7e8ad928(state.mMovie) then
				state.mMovie:__wf_atom_2dedec1a(state.mClipName, 13, mIsVisible)
			end
		end,
		SetAlpha = function(p4, p5)
			p4.mMovie:__wf_atom_e57658c2(p4.mClipName, 12, p5)
		end,
		SetActive = function(self, p4)
			local mActive = p4 ~= false

			if not mActive then
				self:SetFocus(false)
			end

			self.mActive = mActive
			self.mMovie:__wf_atom_e57658c2(
				self.mClipName,
				12,
				module.Ternary(mActive, self.mActiveAlpha, self.mInactiveAlpha)
			)
			self:UpdateEnabledState()

			if self.mSpecial then
				self:UpdateSpecialModeMaterials()
			end
		end,
		IsActive = function(self)
			return self.mIsVisible and self.mActive
		end,
		UpdateEnabledState = function(self)
			local v = not self.mPrefixCallout or not self:IsPlayingWithController() or self.mSpecial
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 67, v and self.mActive)
		end,
		SetAnchor = function(self, p4)
			self.mAnchor = p4 or self.mAnchor
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mWidth = self.mWidth

			if self.mAnchor == module.LEFT_ALIGNED then
				mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX)
				return
			end

			if self.mAnchor == module.CENTER_ALIGNED then
				mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX - mWidth / 2)
				return
			end

			if self.mSpecial then
				mWidth += 47
			end

			mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX - mWidth)
		end,
		SetPosition = function(self, p4, p5, p6)
			self.mX = p4 or self.mX or self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 0)
			self.mY = p5 or self.mY or self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 1)

			if self.mX == nil or self.mY == nil then
				return
			end

			self:SetAnchor(p6)
			self.mMovie:__wf_atom_e57658c2(self.mClipName, 1, self.mY)
		end,
		IsPlayingWithController = function(data)
			return data.mCallout ~= nil
				and data.mShowCallout
				and (Engine.IsPlayingWithController() or data.mForceCallout)
		end,
		UpdateSpecialModeMaterials = function(self)
			local ternary = module.Ternary(self.mActive, _G.UIMaterial_VitruvianLines, nil)
			self.mMovie:OverrideMaterial(self.mClipName .. ".Edge", ternary)
			self.mMovie:OverrideMaterial(self.mClipName .. ".OutlineCapLeft", ternary)
			self.mMovie:OverrideMaterial(self.mClipName .. ".OutlineCapRight", ternary)
		end,
		SetSpecialMode = function(self, p4)
			if p4 == nil then
				p4 = false
			end

			self.mSpecial = true
			self.mHeight = module.Ternary(p4, 25, 44)
			local ternary = module.Ternary(p4, "Small", "Large")

			for _, v in pairs({
				"BgCapRight",
				"OutlineCapRight",
				"BgCapLeft",
				"OutlineCapLeft",
				"Edge"
			}) do
				__wf_atom_86cbd68d(self.mMovie, self.mClipName .. "." .. v .. ".gotoAndStop", ternary)
			end

			__wf_atom_86cbd68d(self.mMovie, self.mClipName .. ".BlurerCapRight.gotoAndStop", "Large")
			__wf_atom_86cbd68d(self.mMovie, self.mClipName .. ".BlurerCapLeft.gotoAndStop", "Large")
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "BlurerCapRight", 13, not p4)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "BlurerCapLeft", 13, not p4)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "SmallBlurerCapRight", 13, p4)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "SmallBlurerCapLeft", 13, p4)
			self:UpdateSpecialModeMaterials()
		end,
		SetVisibleRangeMaterials = function(self, baseMaterial, textMaterial, backerMaterial)
			self.mVisRangeMaterials = {
				BaseMaterial = baseMaterial,
				TextMaterial = textMaterial,
				BackerMaterial = backerMaterial
			}
			self:Redraw()
		end,
		ValueChanged = function(_) end,
		SetPressedCallback = function(self, p4)
			if not __wf_atom_7e8ad928(p4) then
				self.mOnPressedCallback = self:GetParentEnv()[p4]
			end
		end,
		SetReleasedCallback = function(self, p4)
			if not __wf_atom_7e8ad928(p4) then
				self.mOnReleasedCallback = self:GetParentEnv()[p4]
			end
		end
	}

	for k, item in pairs(items) do
		result[k] = item
	end

	result:SetPosition(mMovie2:__wf_atom_5e6e15c8(mClipName2, 0), mMovie2:__wf_atom_5e6e15c8(mClipName2, 1))
	result:HookUpCallbacks(p)
	result:Redraw()
	result:Interpolate(true)
	return result
end