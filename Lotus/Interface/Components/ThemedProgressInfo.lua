module(..., package.seeall)

function Create(object, mClipName, value, value2, mIcon3, mIcon4, mBackerImage, mTintImage)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIUtilities")
	local module3 = require("Lotus.Interface.UIStyleUtilities")
	local v = {
		mClipName = mClipName,
		mTitle = value or "",
		mDesc = value2 or "",
		mIcon = mIcon3,
		mIcon2 = mIcon4,
		mBackerImage = mBackerImage,
		mTintImage = mTintImage,
		mProgress = 0,
		mSkipResize = true,
		mHideProgress = false,
		mHideProgressTarget = false,
		mExtendedProgressBar = false,
		mSeamlessProgressBar = false,
		mProgressText = "",
		mTargetText = "",
		mProgressFormatting = "",
		mFormattingParam = nil,
		mToUpper = false,
		mIconSize = 64,
		mIconSize2 = 32,
		mIconBorderSize = nil,
		mIconBorderSize2 = nil,
		mFlipIcon2 = false,
		mShowIconBg2 = true,
		mWidth = 300,
		mHeight = 0,
		mPadding = 10,
		mIconSpace = 0,
		mIconToTextPadding = 0,
		mLabelOffsetX = 0,
		mIconPaddingX = 0,
		mIconPaddingY = 0,
		mTopPadding = 0,
		mIconBgExtraOffsetX = 0,
		mIconBgExtraOffsetY = 0,
		mShowIconHighlight = false,
		mShowContainerHighlight = false,
		mUseIconPadding = false,
		mShowIconBorder = true,
		mVerticalTextOffset = 0.2,
		mBackerEdgeAlpha = 0.8,
		mBackerIconAlpha = 0.8,
		mBackerAlpha = 0,
		mIconColor = nil,
		mIconBgColor = nil,
		mRectMaterial = _G.UIMaterial_RectangleNoDepth,
		mTextMaterial = nil,
		mIconMaterial = nil,
		mFocused = false,
		mForceTextColor = nil,
		mFocusedShadeAlpha = 70,
		mUnfocusedShadeAlpha = 50,
		mScaleOnFocus = true,
		mTag = nil,
		GetParentEnv = function(p)
			if p.mParentEnv ~= nil then
				return p.mParentEnv
			end

			local v = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v)
				v += 1
			until mParentEnv.mMovie

			p.mParentEnv = mParentEnv
			return mParentEnv
		end,
		AlignText = function(self, p)
			local v = math.max(self.mIconSize, self.mIconSize2 or 0)
			local v2 = (self.mIconBorderSize or v + 4) + self.mIconPaddingY * 2

			if p then
				object:__wf_atom_4c1c1986(
					mClipName,
					"Name",
					1,
					(v2 - object:__wf_atom_cfc41e35(mClipName, "Name.Label", 41)) / 2 + self.mTopPadding
				)
			else
				local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(mClipName, "Name.Label", 41)
				local __wf_atom_cfc41e35_2 = object:__wf_atom_cfc41e35(mClipName, "Ratio.Label", 41)
				local v3 = (v2 - __wf_atom_cfc41e35 - __wf_atom_cfc41e35_2) * ((1 - self.mVerticalTextOffset) / 2)
				object:__wf_atom_4c1c1986(mClipName, "Name", 1, v3 + self.mTopPadding)
				object:__wf_atom_4c1c1986(mClipName, "Ratio", 1, v2 - v3 - __wf_atom_cfc41e35_2 + self.mTopPadding)
			end
		end,
		ResizeIcon2 = function(self, _)
			local v = self.mIcon2 ~= nil
			object:__wf_atom_7f57ab2f(mClipName, "Icon2", 13, v)
			object:__wf_atom_7f57ab2f(mClipName, "Icon2Bg", 13, v and self.mShowIconBg2)

			if v then
				local mIconSize2 = self.mIconSize2
				local mIconBorderSize2 = self.mIconBorderSize2 or mIconSize2 + 4
				local halfMIconBorderSize2 = mIconBorderSize2 / 2
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon2",
					0,
					self.mWidth - (self.mIconPaddingX2 or 0) - halfMIconBorderSize2
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon2Bg",
					0,
					self.mWidth - (self.mIconPaddingX2 or 0) - halfMIconBorderSize2
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon2",
					1,
					halfMIconBorderSize2 + (self.mIconPaddingY2 or self.mIconPaddingY) + self.mTopPadding
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon2Bg",
					1,
					halfMIconBorderSize2 + (self.mIconPaddingY2 or self.mIconPaddingY) + self.mTopPadding
				)
				object:__wf_atom_4c1c1986(mClipName, "Icon2", 14, mIconSize2)
				object:__wf_atom_4c1c1986(mClipName, "Icon2Bg", 14, mIconBorderSize2)
				object:__wf_atom_4c1c1986(mClipName, "Icon2", 15, mIconSize2)
				object:__wf_atom_4c1c1986(mClipName, "Icon2Bg", 15, mIconBorderSize2)
			end
		end,
		Resize = function(self)
			if self.mSkipResize then
				return
			end

			self.mIconSpace = 0
			local mIconSize = self.mIconSize
			local mIconBorderSize = self.mIconBorderSize or mIconSize + 4
			local halfMIconBorderSize = mIconBorderSize / 2

			if not self.mFlipIcon2 then
				self:ResizeIcon2(mIconBorderSize)
			end

			local v = self.mIcon ~= nil or self.mGridItem == true
			object:__wf_atom_7f57ab2f(mClipName, "Icon", 13, v)
			object:__wf_atom_7f57ab2f(mClipName, "IconBg", 13, v and not self.mHideIconBg)
			object:__wf_atom_7f57ab2f(
				mClipName,
				"Highlight",
				13,
				self.mShowContainerHighlight or v and self.mShowIconHighlight
			)
			object:__wf_atom_7f57ab2f(mClipName, "IconBgExtra", 13, v and not __wf_atom_7e8ad928(self.mIconBgExtra))

			if v then
				self.mIconSpace += self.mIconPaddingX
				local ternary = module.Ternary(
					self.mRightAlignIcon,
					self.mWidth - self.mIconSpace - halfMIconBorderSize,
					self.mIconSpace + halfMIconBorderSize
				)
				object:__wf_atom_4c1c1986(mClipName, "Icon", 0, ternary)
				object:__wf_atom_4c1c1986(mClipName, "IconBg", 0, ternary)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon",
					1,
					halfMIconBorderSize + self.mIconPaddingY + self.mTopPadding
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"IconBg",
					1,
					halfMIconBorderSize + self.mIconPaddingY + self.mTopPadding
				)
				object:__wf_atom_4c1c1986(mClipName, "Icon", 14, mIconSize)
				object:__wf_atom_4c1c1986(mClipName, "IconBg", 14, mIconBorderSize)
				object:__wf_atom_4c1c1986(mClipName, "Icon", 15, mIconSize)
				object:__wf_atom_4c1c1986(mClipName, "IconBg", 15, mIconBorderSize)

				if not self.mShowContainerHighlight then
					object:__wf_atom_4c1c1986(mClipName, "Highlight", 0, ternary)
					object:__wf_atom_4c1c1986(
						mClipName,
						"Highlight",
						1,
						mIconBorderSize + self.mIconPaddingY + self.mTopPadding
					)
					object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 0, ternary)
					object:__wf_atom_4c1c1986(
						mClipName,
						"HighlightMask",
						1,
						halfMIconBorderSize + self.mIconPaddingY + self.mTopPadding
					)
					object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 14, mIconBorderSize - 4)
					object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 15, mIconBorderSize - 4)
				end

				object:__wf_atom_4c1c1986(
					mClipName,
					"IconBgExtra",
					14,
					module.Ternary(self.mIconBgExtraWidth ~= nil, self.mIconBgExtraWidth, mIconBorderSize - 4)
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"IconBgExtra",
					15,
					module.Ternary(self.mIconBgExtraHeight ~= nil, self.mIconBgExtraHeight, mIconBorderSize - 4)
				)
				object:__wf_atom_4c1c1986(mClipName, "IconBgExtra", 0, ternary + self.mIconBgExtraOffsetX)
				object:__wf_atom_4c1c1986(
					mClipName,
					"IconBgExtra",
					1,
					halfMIconBorderSize + self.mIconPaddingY + self.mIconBgExtraOffsetY + self.mTopPadding
				)
				self.mIconSpace += mIconBorderSize

				if self.mIconPaddingX == 0 then
					self.mIconSpace += self.mPadding
				end
			end

			if self.mFlipIcon2 then
				self:ResizeIcon2(mIconBorderSize)
			end

			if self.mIconSpace == 0 then
				if self.mUseIconPadding then
					self.mIconSpace = self.mIconPaddingX
				else
					self.mIconSpace = self.mPadding
				end
			else
				self.mIconSpace = self.mIconSpace + self.mIconPaddingX + self.mIconToTextPadding
			end

			local ternary = module.Ternary(self.mRightAlignIcon, 0, self.mIconSpace)
			object:__wf_atom_4c1c1986(mClipName, "Name", 0, ternary + self.mLabelOffsetX)
			object:__wf_atom_4c1c1986(mClipName, "Ratio", 0, ternary)
			self.mTextWidth = self.mWidth - self.mIconSpace - self.mLabelOffsetX - self.mPadding

			if self.mTextWidth ~= object:__wf_atom_5e6e15c8(mClipName .. ".Name.Label", 14) then
				object:__wf_atom_4c1c1986(mClipName, "Name.Label", 14, self.mTextWidth)
				object:__wf_atom_4c1c1986(mClipName, "Ratio.Label", 14, self.mTextWidth)
				object:__wf_atom_48bd5a59(mClipName, "Name.Label", 36, "")
				object:__wf_atom_48bd5a59(mClipName, "Ratio.Label", 36, "")
				self:UpdateText()
			end

			self.mHeight = self.mDefinedHeight
				or self.mIconPaddingY + mIconBorderSize + self.mIconPaddingY + module.Ternary(
					self.mSeamlessProgressBar and self.mExtendedProgressBar,
					-4,
					0
				) + self.mTopPadding
			local halfMWidth = self.mWidth / 2
			local v2 = self.mHeight / 2
			local v3 = self.mWidth + 8
			local v4 = self.mHeight + 8
			object:__wf_atom_4c1c1986(
				mClipName,
				"Bar",
				1,
				self.mHeight + module.Ternary(self.mExtendedProgressBar, 2, 0) + module.Ternary(self.mSeamlessProgressBar, 4, 0)
			)
			object:__wf_atom_4c1c1986(mClipName, "Bar", 0, module.Ternary(self.mExtendedProgressBar, -4, 0))

			if self.mBackerImageWidthRatio == nil then
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 14, v3)
			else
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 14, v4 * self.mBackerImageWidthRatio)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Backer.BackerImage",
					0,
					halfMWidth - v2 * self.mBackerImageWidthRatio
				)
			end

			object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 15, v4)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Tint", 14, v3)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Tint", 15, v4)
			self.mProgressBar.mEdgePadding = module.Ternary(self.mSeamlessProgressBar, 0, 2)
			self.mProgressBar:SetHeight(module.Ternary(self.mSeamlessProgressBar, 7, 11))
			self.mProgressBar:SetWidth(self.mWidth + module.Ternary(self.mExtendedProgressBar, 8, 0))

			if self.mProgressBar.mVisible then
				self.mHeight += module.Ternary(self.mExtendedProgressBar, 9, 11)
				v2 = self.mHeight / 2
				v4 = self.mHeight + 8
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 1, -4)
				object:__wf_atom_4c1c1986(mClipName, "Backer.Tint", 1, -4)
			else
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 1, 0)
				object:__wf_atom_4c1c1986(mClipName, "Backer.Tint", 1, 0)
			end

			if self.mShowContainerHighlight then
				object:__wf_atom_4c1c1986(mClipName, "Highlight", 0, self.mWidth / 2)
				object:__wf_atom_4c1c1986(mClipName, "Highlight", 1, self.mHeight + 4)
				object:__wf_atom_4c1c1986(mClipName, "Highlight", 14, self.mWidth * 1.5)
				object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 0, self.mWidth / 2)
				object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 1, self.mHeight / 2)
				object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 14, v3)
				object:__wf_atom_4c1c1986(mClipName, "HighlightMask", 15, v4)
			end

			object:__wf_atom_4c1c1986(mClipName, "Backer", 0, halfMWidth)
			object:__wf_atom_4c1c1986(mClipName, "Backer", 1, v2)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Backer", 14, v3)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Backer", 15, v4)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Blurer", 14, v3)
			object:__wf_atom_4c1c1986(mClipName, "Backer.Blurer", 15, v4)
			object:__wf_atom_7f57ab2f(mClipName, "Backer.BackerImage", 13, self.mBackerImage ~= nil)
			object:__wf_atom_7f57ab2f(mClipName, "Backer.Tint", 13, self.mBackerImage ~= nil and self.mTintImage ~= nil)
			self:AlignText(self.mDesc == "" and self.mProgressText == "")
			self:SetFocused(self.mFocused, true)
		end,
		UpdateText = function(self)
			local color = module3.GetColor(6, true)
			local color2 = module3.GetColor(9, true)
			local color3 = module3.GetColor(10, true)
			local v = "<font color=\"" .. module.ConvertColorNumberToHex(color2) .. "\">"
			local v2 = "<font color=\"" .. module.ConvertColorNumberToHex(color3) .. "\">"
			local v3 = "<font color=\"" .. module.ConvertColorNumberToHex(color) .. "\">"

			if self.mForceTextColor == 1 then
				v3 = v
				v2 = v3
				v3 = v2
			elseif self.mForceTextColor == 2 then
				v3 = v2
				v = v3
				v3 = v
			elseif self.mForceTextColor == 3 then
				v2 = v3
				v = v2
				v2 = v
			elseif self.mForceTextColor == 4 or self.mForceTextColor == 5 then
				v = "<font color=\"" .. module.ConvertColorNumberToHex(module.Ternary(self.mForceTextColor == 4, color2, color3)) .. "\" size=\"21\">"
				v2 = v3
			end

			local mDesc = self.mDesc

			if mDesc == "" then
				if #self.mProgressFormatting > 0 then
					if #self.mFormattingParam > 0 then
						mDesc = object:__wf_atom_8e9ac384(self.mProgressFormatting, true, {
							VAL = self.mProgressText,
							VAL2 = self.mFormattingParam
						})
					else
						mDesc = object:__wf_atom_8e9ac384(self.mProgressFormatting, true, {
							VAL = self.mProgressText
						})
					end
				else
					mDesc = self.mProgressText
				end

				if self.mTargetText ~= "" then
					mDesc = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProgressXOfY", true, {
						CURRENT = v3 .. mDesc .. "</font>",
						TOTAL = self.mTargetText
					})
				end
			end

			object:__wf_atom_50d60589(mClipName .. ".Name.Label", 36, "<p>" .. v .. self.mTitle .. "</font></p>")
			object:__wf_atom_50d60589(mClipName .. ".Ratio.Label", 36, "<p>" .. v2 .. mDesc .. "</font></p>")
		end,
		UpdateColors = function(self)
			local color = module3.GetColor(2, true)
			local color2 = module3.GetColor(9, true)
			local color3 = module3.GetColor(10, true)
			local mFocused = self.mFocused or self.mForceHighlight
			local mBackerInnerColor = module.ConvertColorNumberToProceduralRGB(color)

			if self.mBackerInnerColor ~= nil then
				mBackerInnerColor = self.mBackerInnerColor
			end

			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(mFocused and color3 or color2)
			local mBackerFocusedIconAlpha = mFocused and self.mBackerFocusedIconAlpha or self.mBackerIconAlpha
			local v = self.mShowIconBorder and mBackerFocusedIconAlpha or 0
			self:UpdateText()
			self.mProgressBar:UpdateColors()

			if self.mIconColorInt == nil then
				if not __wf_atom_7e8ad928(self.mIconColor) then
					object:__wf_atom_4c1c1986(
						mClipName,
						"Icon",
						11,
						"0x" .. module.ConvertRGB2HEX(self.mIconColor.red, self.mIconColor.green, self.mIconColor.blue)
					)
				end
			else
				object:__wf_atom_4c1c1986(mClipName, "Icon", 11, self.mIconColorInt)
			end

			if self.mIconAlpha ~= nil then
				object:__wf_atom_4c1c1986(mClipName, "Icon", 12, self.mIconAlpha)
			end

			if not __wf_atom_7e8ad928(self.mIconColor2) then
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon2",
					11,
					"0x" .. module.ConvertRGB2HEX(self.mIconColor2.red, self.mIconColor2.green, self.mIconColor2.blue)
				)
			end

			if self.mIconBgOverride == nil then
				if __wf_atom_7e8ad928(self.mIconBgColor) then
					object:__wf_atom_1ca72041(
						mClipName .. ".IconBg",
						"RectInnerColor",
						mBackerInnerColor.r,
						mBackerInnerColor.g,
						mBackerInnerColor.b,
						0
					)
				else
					object:__wf_atom_1ca72041(
						mClipName .. ".IconBg",
						"RectInnerColor",
						self.mIconBgColor.red / 255,
						self.mIconBgColor.green / 255,
						self.mIconBgColor.blue / 255,
						1
					)
				end

				object:__wf_atom_1ca72041(
					mClipName .. ".IconBg",
					"RectEdgeColor",
					convertColorNumberToProceduralRGB.r,
					convertColorNumberToProceduralRGB.g,
					convertColorNumberToProceduralRGB.b,
					v
				)
			elseif not __wf_atom_7e8ad928(self.mIconBgColor) then
				object:__wf_atom_4c1c1986(mClipName, "IconBg", 11, self.mIconBgColor)
			end

			object:__wf_atom_1ca72041(
				mClipName .. ".Icon2Bg",
				"RectInnerColor",
				mBackerInnerColor.r,
				mBackerInnerColor.g,
				mBackerInnerColor.b,
				0
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Icon2Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				v
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Backer.Backer",
				"RectInnerColor",
				mBackerInnerColor.r,
				mBackerInnerColor.g,
				mBackerInnerColor.b,
				self.mBackerAlpha
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Backer.Backer",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				mFocused and self.mBackerFocusedEdgeAlpha or self.mBackerEdgeAlpha
			)

			if self.mTintBackerImage then
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 11, color2)
				object:__wf_atom_4c1c1986(mClipName, "Backer.BackerImage", 12, self.mBackerImageAlpha or 100)
			else
				object:__wf_atom_1ca72041(
					mClipName .. ".Backer.BackerImage",
					"RipplesColor",
					convertColorNumberToProceduralRGB.r,
					convertColorNumberToProceduralRGB.g,
					convertColorNumberToProceduralRGB.b,
					0
				)
				object:__wf_atom_1ca72041(mClipName .. ".Backer.BackerImage", "RectInnerColor", 1, 1, 1, 1)
				object:__wf_atom_1ca72041(mClipName .. ".Backer.BackerImage", "RectEdgeColor", 1, 1, 1, 0)
			end

			local mFocusedShadeAlpha = mFocused and self.mFocusedShadeAlpha or self.mUnfocusedShadeAlpha
			object:__wf_atom_1ca72041(
				mClipName .. ".Backer.Tint",
				"RipplesColor",
				mBackerInnerColor.r,
				mBackerInnerColor.g,
				mBackerInnerColor.b,
				0
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Backer.Tint",
				"RectInnerColor",
				mBackerInnerColor.r,
				mBackerInnerColor.g,
				mBackerInnerColor.b,
				mFocusedShadeAlpha / 100
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Backer.Tint",
				"RectEdgeColor",
				mBackerInnerColor.r,
				mBackerInnerColor.g,
				mBackerInnerColor.b,
				0
			)

			if not __wf_atom_7e8ad928(self.mIconBgExtraColor) then
				object:__wf_atom_4c1c1986(mClipName, "IconBgExtra", 11, self.mIconBgExtraColor)
			end

			if not __wf_atom_7e8ad928(self.mIconBgExtraAlpha) then
				object:__wf_atom_4c1c1986(mClipName, "IconBgExtra", 12, self.mIconBgExtraAlpha)
			end

			if not __wf_atom_7e8ad928(self.mIconBgAlpha) then
				object:__wf_atom_4c1c1986(mClipName, "IconBg", 12, self.mIconBgAlpha)
			end

			object:__wf_atom_4c1c1986(
				mClipName,
				"Highlight",
				11,
				module.Ternary(self.mShowContainerHighlight, color3, color)
			)

			if not self.mShowContainerHighlight then
				mFocused = self.mShowIconHighlight and mFocused
			end

			__wf_atom_ec43d06e(
				object,
				mClipName .. ".Highlight",
				0,
				{ 12 },
				{ module.Ternary(mFocused, 30, 0) },
				module.Ternary(mFocused, 0.4, 0)
			)
		end,
		SetText = function(self, value3, value4)
			self.mTitle = object:__wf_atom_8e9ac384(value3 or "", true)
			self.mDesc = object:__wf_atom_8e9ac384(value4 or "", true)

			if self.mToUpper then
				self.mTitle = string.upper(self.mTitle)
				self.mDesc = string.upper(self.mDesc)
			end

			self:UpdateColors()
			self:AlignText(self.mDesc == "" and self.mProgressText == "")
		end,
		SetIcons = function(self, mIcon, mIcon2, mIconSize, mIconSize2)
			self.mIcon = mIcon
			self.mIcon2 = mIcon2
			object:__wf_atom_c90af43a(mClipName .. ".Icon", self.mIcon)
			object:__wf_atom_c90af43a(mClipName .. ".Icon2", self.mIcon2)

			if mIconSize ~= nil then
				self.mIconSize = mIconSize
				self.mIconSize2 = mIconSize2
				self:Resize()
			end
		end,
		SetProgress = function(self, mProgress, value3, mProgressFormatting, mFormattingParam)
			if value3 == nil then
				if mProgress == nil then
					self.mProgress = 0
				else
					mProgress = __wf_atom_421b01aa(mProgress, 0, 1)
					self.mProgress = mProgress
				end
			else
				if mProgress ~= nil and value3 > 0 then
					mProgress = __wf_atom_421b01aa(mProgress, 0, value3)
				end

				self.mProgress = mProgress / value3
			end

			local v = mProgress ~= nil
			self.mProgressBar:SetVisible(v and not self.mHideProgress)

			if v then
				self.mProgressBar:SetProgress({ mProgress }, nil, value3 or 1)

				if self.mDesc == "" then
					if value3 == nil then
						self.mProgressText = math.floor(mProgress * 100 + 0.5) .. "%"
						self.mTargetText = ""
					else
						self.mProgressText = module.FormatNumber(mProgress, 0)

						if self.mHideProgressTarget then
							self.mTargetText = ""
						else
							self.mTargetText = module.FormatNumber(value3, 0)
						end
					end

					if #mProgressFormatting > 0 then
						self.mProgressFormatting = mProgressFormatting
						self.mFormattingParam = mFormattingParam
					end

					self:UpdateColors()
					self:AlignText(false)
				end
			end

			self:Resize()
		end,
		SetWidth = function(self, mWidth)
			self.mWidth = mWidth
			self:Resize()
		end,
		SetSize = function(self, mWidth, mDefinedHeight)
			self.mWidth = mWidth
			self.mDefinedHeight = mDefinedHeight
			self:Resize()
		end,
		SetFocused = function(self, mFocused, p)
			if self.mFocused == mFocused and not p then
				return
			end

			self.mFocused = mFocused
			self:UpdateColors()

			if self.mShowContainerHighlight then
				local v = p and 0 or 0.2

				if self.mScaleOnFocus then
					local ternary = module.Ternary(mFocused, 105, 100)
					__wf_atom_ec43d06e(object, mClipName .. ".Backer", 0, { 5, 6 }, { ternary, ternary }, v)
					__wf_atom_ec43d06e(object, mClipName .. ".HighlightMask", 0, { 5, 6 }, { ternary, ternary }, v)

					if mFocused and self.mShowContainerHighlight then
						object:__wf_atom_4c1c1986(mClipName, "Highlight", 1, (self.mHeight + 8) * (ternary / 100) - 4)
					end
				else
					local v2 = self.mWidth + module.Ternary(mFocused, 18, 8)
					local v3 = self.mHeight + module.Ternary(mFocused, 18, 8)
					__wf_atom_ec43d06e(object, mClipName .. ".Backer", 0, { 14, 15 }, { v2, v3 }, v)
					__wf_atom_ec43d06e(object, mClipName .. ".HighlightMask", 0, { 14, 15 }, { v2 - 4, v3 - 4 }, v)

					if mFocused and self.mShowContainerHighlight then
						object:__wf_atom_4c1c1986(mClipName, "Highlight", 1, v3 - 4)
					end
				end
			end

			if mFocused and not p then
				module.PlaySound(_G.UISound_Focus)
			end
		end,
		Redraw = function(self)
			object:__wf_atom_933bbce0(
				mClipName .. ".Backer.BackerImage",
				self.mBackerImage,
				_G.UIMaterial_RectangleNoDepth
			)
			object:__wf_atom_933bbce0(mClipName .. ".Backer.Tint", self.mTintImage, _G.UIMaterial_RectangleNoDepth)
			object:__wf_atom_933bbce0(mClipName .. ".IconBgExtra", self.mIconBgExtra, self.mIconMaterial)

			if self.mIconBgOverride ~= nil then
				object:__wf_atom_933bbce0(mClipName .. ".IconBg", self.mIconBgOverride, self.mIconMaterial)
			end

			if self.mTextMaterial ~= nil then
				object:OverrideMaterial(mClipName .. ".Name.Label", self.mTextMaterial)
				object:OverrideMaterial(mClipName .. ".Ratio.Label", self.mTextMaterial)
				object:OverrideMaterial(mClipName .. ".TopRight.Label", self.mTextMaterial)
				object:OverrideMaterial(mClipName .. ".BotRight.Label", self.mTextMaterial)
			end

			if self.mIconMaterial ~= nil then
				object:OverrideMaterial(mClipName .. ".Icon", self.mIconMaterial)
				object:OverrideMaterial(mClipName .. ".Icon2", self.mIconMaterial)
			end

			if self.mRectMaterial ~= nil then
				object:OverrideMaterial(mClipName .. ".Backer.Backer", self.mRectMaterial)
				object:OverrideMaterial(mClipName .. ".Icon2Bg", self.mRectMaterial)
				object:OverrideMaterial(mClipName .. ".Seperator", self.mRectMaterial)

				if self.mIconBgOverride == nil then
					object:OverrideMaterial(mClipName .. ".IconBg", self.mRectMaterial)
				end

				self.mProgressBar.mRectMaterial = self.mRectMaterial
			end

			if __wf_atom_7e8ad928(self.mTag) then
				object:__wf_atom_7f57ab2f(mClipName, "Tag", 13, false)
			else
				object:__wf_atom_7f57ab2f(mClipName, "Tag", 13, true)
				object:OverrideMaterial(mClipName .. ".Tag.Bg", self.mRectMaterial)
				module2.DrawPriceLabel(object, mClipName .. ".Tag", self.mTag, true)
			end

			self.mProgressBar:Redraw()
			self.mSkipResize = true
			self:SetIcons(self.mIcon, self.mIcon2, self.mIconSize, self.mIconSize2)
			self:SetText(self.mTitle, self.mDesc, self.mTopRightText, self.mBotRightText)
			self:UpdateColors()
			self.mSkipResize = false
			self:Resize()
		end
	}
	local module4 = require("Lotus.Interface.Components.ThemedProgressBar")
	v.mProgressBar = module4.Create(object, mClipName .. ".Bar", v.mWidth, nil, v.mRectMaterial, 1)
	v.mProgressBar.mBgInnerAlpha = 0
	v:SetProgress(nil)
	v:Redraw()
	return v
end