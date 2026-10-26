module(..., package.seeall)
VARIANTS = { BUTTON = 1, SPECIAL_BUTTON = 2, PAPER = 3, DOTTED = 4 }

function Create(mMovie3, mClipName2, value, p, mCallout, mParentEnv, p2)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local v = {
		mMovie = mMovie3,
		mClipName = mClipName2,
		mCallout = mCallout,
		mId = nil,
		mIsVisible = true,
		mActive = true,
		mFocused = false,
		mSelected = false,
		mLockFocus = false,
		mLabel = value or "",
		mLocalizeText = true,
		mConvertEmoticons = false,
		mFormatPrefix = "",
		mFormatSuffix = "",
		mLabelPrefix = "",
		mWidth = nil,
		mHeight = 40,
		mMinSize = 50,
		mMaxSize = nil,
		mIconSize = nil,
		mOnFocusedCallback = nil,
		mOnUnfocusedCallback = nil,
		mOnPressedCallback = nil,
		mOnReleasedCallback = nil,
		mAnchor = module.LEFT_ALIGNED,
		mVerticalCenterText = true,
		mAlignment = nil,
		mHoldDuration = 0,
		mCapWidth = 32,
		mCapSize = 34,
		mHighlightAlwaysVis = false,
		mForceBacker = false,
		mBackerAlpha = 100,
		mBackerAlphaSpecial = 100,
		mFocusedAlpha = 100,
		mUnfocusedBorderColor = _G.UIColor_Brown,
		mActiveAlpha = 100,
		mInactiveAlpha = 40,
		mInactiveColor = nil,
		mSilent = false,
		mVisRangeMaterials = nil,
		mBackerMaterial = nil,
		mPostText = nil,
		mVariant = VARIANTS.BUTTON,
		mParentEnv = mParentEnv,
		mSkipCallback = p2 or false,
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
		HookUpCallbacks = function(self, p3)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local parentEnv = self:GetParentEnv()

			if #self.mCallout > 0 and not self.mSkipCallback then
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

			if not __wf_atom_7e8ad928(p3) and __wf_atom_7e8ad928(self.mOnPressedCallback) then
				self.mOnPressedCallback = parentEnv[p3]
			end

			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local v = string.gsub(mClipName, "%.", "")

			parentEnv[v .. "Over"] = function(p4)
				if self:InvalidId(p4) then
					return
				end

				self.mHovered = true

				if self.mToolTip ~= nil then
					_T.gToolTip = self.mToolTip
				end

				self:TrySetFocus(true)
			end

			parentEnv[v .. "Out"] = function(p4)
				if self:InvalidId(p4) then
					return
				end

				self.mHovered = nil

				if self.mToolTip ~= nil then
					_T.gToolTip = nil
				end

				self:TrySetFocus(false)
			end

			parentEnv[v .. "Press"] = function(p4)
				if self:InvalidId(p4) then
					return
				end

				self:TryPressed(true)
			end

			parentEnv[v .. "Release"] = function(p4)
				if self:InvalidId(p4) then
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
				module.HookUpEnvironmentCallback(mClipName, parentEnv, "OnGamepadTransition", function(p4)
					self:OnGamepadTransition(p4 == "true")
				end)
			end
		end,
		InvalidId = function(self, p3)
			return self.mId ~= nil and tonumber(p3) ~= self.mId
		end,
		SetId = function(self, mId)
			self.mId = mId

			if self.mId ~= nil then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 100, self.mId)
			end
		end,
		Interpolate = function(self, p3)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mFocused = self.mFocused or self.mHighlightAlwaysVis
			local ternary = module.Ternary
			local v = ternary(mFocused, 110, 100)
			__wf_atom_ec43d06e(mMovie, mClipName .. ".Backer", 2, { 5, 6 }, { v, v }, ternary(p3, 0, 0.35))
			__wf_atom_ec43d06e(mMovie, mClipName .. ".BackerHighlight", 2, { 5, 6 }, { v, v }, ternary(p3, 0, 0.35))
			__wf_atom_ec43d06e(mMovie, mClipName .. ".HoldProgress", 2, { 5, 6 }, { v, v }, ternary(p3, 0, 0.35))

			if __wf_atom_7e8ad928(self.mBackerMaterial) then
				__wf_atom_ec43d06e(mMovie, mClipName .. ".TextHolder", 2, { 5, 6 }, { v, v }, ternary(p3, 0, 0.35))
			end

			if self.mIconSize ~= nil then
				__wf_atom_ec43d06e(mMovie, mClipName .. ".Icon", 2, { 5, 6 }, { v, v }, ternary(p3, 0, 0.35))
				__wf_atom_ec43d06e(
					mMovie,
					mClipName .. ".Icon.Icon",
					2,
					{ 14 },
					{ 100 / v * (v / 100) * self.mIconSize },
					ternary(p3, 0, 0.35)
				)
			end
		end,
		PlaySound = function(p3, p4)
			if not p3.mSilent then
				module.PlaySound(p4)
			end
		end,
		IsFocusBlocked = function(self, p3)
			return self.mFocused == p3 or (not self.mActive or self.mLockFocus)
		end,
		TrySetFocus = function(self, p3)
			if self:IsFocusBlocked(p3) then
				return
			end

			local ternary = module.Ternary(p3, self.mOnFocusedCallback, self.mOnUnfocusedCallback)

			if __wf_atom_7e8ad928(ternary) or ternary(self, p3) ~= false then
				self:SetFocus(p3)
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
			end

			if self.mVariant == VARIANTS.SPECIAL_BUTTON then
				local mMovie = self.mMovie

				if not __wf_atom_7e8ad928(mMovie) then
					local v = self.mClipName .. "."
					local v2 = { "Backer.Bookends.LeftHover", "Backer.Bookends.RightHover" }

					for i = 1, #v2 do
						__wf_atom_ec43d06e(mMovie, v .. v2[i], 2, { 12 }, { module.Ternary(mFocused, 100, 0) }, 0.2, 0)
					end
				end
			end

			self:Interpolate()
		end,
		TryPressed = function(self, p3, p4)
			local ternary = module.Ternary(p3, self.mOnPressedCallback, self.mOnReleasedCallback)

			if __wf_atom_7e8ad928(ternary) or ternary(self, p3, p4) ~= false then
				self:Pressed(p3, p4)
			end

			if not p3 and self.mHoldInterpolation ~= nil then
				self.mHoldInterpolation = nil
				__wf_atom_ec43d06e(mMovie3, self.mClipName .. ".HoldProgress.Bar.Fill", 2, { 12 }, { 0 }, 0.2)
			end
		end,
		Pressed = function(self, mPressed, p3)
			if not self.mActive then
				return
			end

			self.mPressed = mPressed

			if mPressed then
				self:PlaySound(_G.UISound_ButtonSelect)
			end

			if self.mHoldDuration > 0 and mPressed then
				mMovie3:__wf_atom_4c1c1986(self.mClipName, "HoldProgress.Bar.Fill", 12, 100)
				mMovie3:__wf_atom_4c1c1986(self.mClipName, "HoldProgress.Bar.Fill", 14, 1)
				self.mHoldInterpolation = __wf_atom_ec43d06e(
					mMovie3,
					self.mClipName .. ".HoldProgress.Bar.Fill",
					0,
					{ 14 },
					{ 100 },
					self.mHoldDuration,
					0,
					function()
						if self.mOnPressCompletedCallback ~= nil then
							self.mOnPressCompletedCallback(self, mPressed, p3)
						end
					end
				)
			elseif self.mOnPressCompletedCallback ~= nil then
				self.mOnPressCompletedCallback(self, mPressed, p3)
			end
		end,
		OnGamepadTransition = function(self)
			if __wf_atom_7e8ad928(self.mMovie) then
				return
			end

			local mMovie = self.mMovie
			local mClipName = self.mClipName
			mMovie:__wf_atom_7f57ab2f(mClipName, "MaterialBacker", 13, not __wf_atom_7e8ad928(self.mBackerMaterial))
			mMovie:__wf_atom_7f57ab2f(
				mClipName,
				"MaterialBacker.Border",
				13,
				not __wf_atom_7e8ad928(self.mBorderMaterial)
			)

			if __wf_atom_7e8ad928(self.mBackerMaterial) then
				local v = self:IsPlayingWithController()
					and self.mVariant ~= VARIANTS.SPECIAL_BUTTON
					and not self.mForceBacker
				self:UpdateEnabledState()
				mMovie:__wf_atom_7f57ab2f(mClipName, "Backer.Fill", 13, not v)
				mMovie:__wf_atom_7f57ab2f(mClipName, "BackerHighlight.Fill", 13, not v)
				mMovie:__wf_atom_7f57ab2f(mClipName, "GamepadBacker", 13, v)
			else
				mMovie:__wf_atom_7f57ab2f(mClipName, "Backer.Fill", 13, false)
				mMovie:__wf_atom_7f57ab2f(mClipName, "BackerHighlight.Fill", 13, false)
				mMovie:__wf_atom_7f57ab2f(mClipName, "GamepadBacker", 13, false)
			end

			self:SetText(self.mLabel)
			self:Resize()
		end,
		Resize = function(self)
			local mMovie = self.mMovie

			if __wf_atom_7e8ad928(mMovie) then
				return
			end

			local mMinSize = math.max(self.mCapSize + 2, self.mMinSize)
			local mMaxSize = self.mMaxSize
			self.mMinSize = mMinSize
			local mClipName = self.mClipName
			local v = not __wf_atom_7e8ad928(self.mBackerMaterial)
			local v2 = v and 14 or 20
			local v3 = v or self.mAlignment ~= nil
			local v4 = math.ceil((mMovie:__wf_atom_cfc41e35(mClipName, "TextHolder.Label", 40)))
			local v5 = -4
			local v6

			if self.mVerticalCenterText then
				v6 = v5 - mMovie:__wf_atom_cfc41e35(mClipName, "TextHolder.Label", 41) / 2
			else
				v6 = v5 + mMovie:__wf_atom_cfc41e35(mClipName, "TextHolder.Label", 41) / 2 - self.mHeight / 2
			end

			local mHeight = self.mHeight
			local mWidth = v4 + v2 * 2
			local mHeight2 = self.mHeight
			local v7 = 2
			local v8 = self:IsPlayingWithController() and self.mVariant ~= VARIANTS.SPECIAL_BUTTON
			local mIconSize = self.mIconSize or 0
			local v9 = mIconSize > 0
			local v10 = not v9 and 0 or v2 / 2 + (self.mIconShiftX or 0)

			if v8 and self.mAlignment == nil then
				if v10 ~= 0 then
					v10 += 10
				end

				v10 += 40
			end

			if v10 ~= 0 then
				mWidth += v10 + mIconSize - v2
				v7 += (v10 + mIconSize - v2) / 2
			end

			if mMinSize ~= nil and mWidth < mMinSize then
				mWidth = mMinSize
			end

			if mMaxSize ~= nil and mMaxSize < mWidth then
				mWidth = mMaxSize
			end

			local v11 = mWidth / 2
			local halfMHeight2 = mHeight2 / 2
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 0, v11 + v10)
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 1, halfMHeight2)

			if v9 then
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 0, -v11 + mIconSize / 2)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 1, self.mIconShiftY or 0)
				local v12 = 1 - mMovie:__wf_atom_cfc41e35(mClipName, "Icon.Text", 40) / 2
				local v13 = -4 - math.floor(mMovie:__wf_atom_cfc41e35(mClipName, "Icon.Text", 41) / 2)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Text", 0, -v11 + mIconSize / 2 + v12)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Text", 1, (self.mIconShiftY or 0) + v13)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Callout", 1, halfMHeight2)
			mMovie:__wf_atom_4c1c1986(
				mClipName,
				"Callout.Prompt",
				1,
				-mMovie:__wf_atom_cfc41e35(mClipName, "Callout.Prompt", 41) * 0.7
			)

			if v3 then
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Callout.Prompt", 40)
				v4 = mWidth - v2 * 2 - __wf_atom_cfc41e35
				v7 -= __wf_atom_cfc41e35 / 2
				mMovie:__wf_atom_4c1c1986(mClipName, "Callout", 0, v2 + 2 + v4 + __wf_atom_cfc41e35 / 2)

				if __wf_atom_cfc41e35 > 0 then
					v4 -= v2
					v7 -= v2 / 2
				end
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Callout", 0, 10)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder", 1, halfMHeight2)
			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder.Label", 1, v6)
			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder.Label", 0, -(v4 / 2) + v7)
			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder.Label", 14, v4)
			mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder.Label", 15, mHeight)

			if #self.mPostText > 0 then
				module.SetFitText(mMovie, mClipName .. ".TextHolder.Label", self.mPostText)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "TextHolder.Label", 93, -1)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, mWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 15, mHeight2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 1, halfMHeight2)
			mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBacker", 0, 0)
			mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBacker", 1, halfMHeight2)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight", 1, halfMHeight2)
			mMovie:__wf_atom_4c1c1986(mClipName, "MaterialBacker", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "MaterialBacker", 1, halfMHeight2)

			if self.mVariant == VARIANTS.SPECIAL_BUTTON then
				mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill", 14, mWidth)
				mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill", 15, mHeight2)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "HoldProgress.Bar", 14, mWidth - 9)
			mMovie:__wf_atom_4c1c1986(mClipName, "HoldProgress.Bar", 15, mHeight2 - 6)
			mMovie:__wf_atom_4c1c1986(mClipName, "HoldProgress", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "HoldProgress", 1, halfMHeight2 + 0.5)
			mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBacker", 14, mWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "GamepadBacker", 15, mHeight + 5)
			mMovie:__wf_atom_1ca72041(mClipName .. ".GamepadBacker", "TileRepeats", mWidth / 64, 1, 1, 1)
			mMovie:__wf_atom_4c1c1986(mClipName, "MaterialBacker", 14, mWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "MaterialBacker", 15, self.mBackerHeight or mHeight2 + 8)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Bookends.Left", 0, -v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Bookends.Right", 0, v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Bookends.LeftHover", 0, -v11)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Bookends.RightHover", 0, v11)
			local v12 = mWidth - self.mCapSize
			local v13 = self.mHeight * 1.6
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Mid", 14, v12)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Left", 0, -v12 / 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Right", 0, v12 / 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Mid", 15, v13)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Left", 14, self.mCapWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Left", 15, v13)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Right", 14, self.mCapWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "Backer.Fill.Right", 15, v13)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Mid", 14, v12)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Left", 0, -v12 / 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Right", 0, v12 / 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Mid", 15, v13)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Left", 14, self.mCapWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Left", 15, v13)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Right", 14, self.mCapWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "BackerHighlight.Fill.Right", 15, v13)

			if self.mAnchor == module.LEFT_ALIGNED then
				mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX)
			elseif self.mAnchor == module.CENTER_ALIGNED then
				mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX - v11)
			else
				mMovie:__wf_atom_e57658c2(mClipName, 0, self.mX - mWidth)
			end

			if self.mSelected then
				mMovie:__wf_atom_2004c47f()
			end

			if v8 and self.mAlignment == nil then
				mWidth -= 14
			end

			self.mWidth = mWidth
			self.mSelected = false
			self.mFocused = false
			self:Interpolate(true)
			self:UpdateColors()
		end,
		UpdateColors = function(self)
			local mFocused = self.mFocused or self.mHighlightAlwaysVis
			local uiColor_Yellow

			if mFocused then
				uiColor_Yellow = _G.UIColor_Yellow
			else
				uiColor_Yellow = _G.UIColor_Beige
			end

			if self.mVariant == VARIANTS.SPECIAL_BUTTON then
				local color = module2.GetColor(2, true, true)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer.Fill", 11, color)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 12, self.mBackerAlphaSpecial)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "TextHolder.Label", 44, uiColor_Yellow)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer.Bookends.LeftHover", 12, 0)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer.Bookends.RightHover", 12, 0)
			else
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Prompt", 44, uiColor_Yellow)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "TextHolder.Label", 44, uiColor_Yellow)
				self.mMovie:__wf_atom_4c1c1986(
					self.mClipName,
					"Backer",
					12,
					module.Ternary(not mFocused, self.mFocusedAlpha, 0)
				)
				self.mMovie:__wf_atom_4c1c1986(
					self.mClipName,
					"BackerHighlight",
					12,
					module.Ternary(mFocused, self.mFocusedAlpha, 0)
				)
				local mMovie = self.mMovie
				local v = self.mClipName .. ".MaterialBacker.Border"
				local v2

				if mFocused and not __wf_atom_7e8ad928(self.mFocusedBorderMaterial) then
					v2 = self.mFocusedBorderMaterial
				else
					v2 = self.mBorderMaterial
				end

				mMovie:OverrideMaterial(v, v2)
				local mMovie2 = self.mMovie
				local v3 = self.mClipName .. ".MaterialBacker.Backer"
				local v4

				if mFocused and not __wf_atom_7e8ad928(self.mFocusedBackerMaterial) then
					v4 = self.mFocusedBackerMaterial
				else
					v4 = self.mBackerMaterial
				end

				mMovie2:OverrideMaterial(v3, v4)

				if self.mVariant == VARIANTS.DOTTED then
					local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB
					local v5

					if mFocused then
						v5 = _G.UIColor_Yellow
					else
						v5 = self.mUnfocusedBorderColor
					end

					local v6 = convertColorNumberToProceduralRGB(v5)
					self.mMovie:__wf_atom_1ca72041(
						self.mClipName .. ".MaterialBacker.Border",
						"TintColor",
						v6.r,
						v6.g,
						v6.b,
						1
					)
					local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB
					local v7

					if mFocused then
						v7 = _G.UIColor_Brown
					else
						v7 = _G.UIColor_DarkBrown
					end

					local v8 = convertColorNumberToProceduralRGB2(v7)
					self.mMovie:__wf_atom_1ca72041(
						self.mClipName .. ".MaterialBacker.Backer",
						"TintColor",
						v8.r,
						v8.g,
						v8.b,
						1
					)
				end
			end
		end,
		Redraw = function(self)
			self:OnGamepadTransition()
		end,
		SetTextIcon = function(self, mTextIcon)
			self.mTextIcon = mTextIcon
			self:SetText(self.mLabel)
		end,
		SetText = function(self, value2, p3)
			local mLabel = value2 or ""
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

			if not p3 then
				local v = not (#self.mTextIcon > 0) and "" or self.mMovie:__wf_atom_8e9ac384(self.mTextIcon, true)

				if self:IsPlayingWithController() then
					v = self.mMovie:__wf_atom_8e9ac384(self.mCallout, true) .. v
				end

				if self.mVariant == VARIANTS.SPECIAL_BUTTON then
					mLabel = v .. mLabel
					v = ""
				end

				local v2 = v ~= self.mMovie:__wf_atom_4934c8e7(self.mClipName, "Callout.Prompt", 36)
				local v3 = self.mAlignment == nil and 36 or 23
				local v4 = v2 or v3 ~= self.mMovie:__wf_atom_cfc41e35(self.mClipName, "Callout.Prompt", 50)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Prompt", 50, v3)

				if v4 then
					self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Callout.Prompt", 35, v)
				end

				local v5 = self.mFormatPrefix .. mLabel .. self.mFormatSuffix
				local v6 = v4 or v5 ~= self.mMovie:__wf_atom_4934c8e7(self.mClipName, "TextHolder.Label", 36)
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "TextHolder.Label", 36, v5)
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "TextHolder.Label", 45, self.mAlignment or "center")

				if
					v6
					or self.mMinSize ~= self.mMaxSize
					or self.mWidth == nil
					or self.mMinSize ~= nil and self.mWidth < self.mMinSize
					or self.mMaxSize ~= nil and self.mWidth > self.mMaxSize
				then
					self:Resize()
				end
			end
		end,
		SetTextAlignment = function(state, mAlignment)
			state.mAlignment = mAlignment
			state.mMovie:__wf_atom_48bd5a59(state.mClipName, "TextHolder.Label", 45, mAlignment or "center")
		end,
		SetMinWidth = function(self, mMinSize)
			self.mMinSize = mMinSize
			self:Resize()
		end,
		SetWidth = function(self, p3)
			self.mMinSize = p3
			self.mMaxSize = p3
			self:Resize()
		end,
		SetVisible = function(state, p3)
			local mIsVisible = p3 == true
			state.mIsVisible = mIsVisible

			if not __wf_atom_7e8ad928(state.mMovie) then
				state.mMovie:__wf_atom_2dedec1a(state.mClipName, 13, mIsVisible)
			end
		end,
		SetAlpha = function(p3, p4)
			p3.mMovie:__wf_atom_e57658c2(p3.mClipName, 12, p4)
		end,
		SetActive = function(self, p3)
			local mActive = p3 ~= false

			if not mActive then
				self:SetFocus(false)
			end

			self.mActive = mActive
			self.Alpha = module.Ternary(mActive, self.mActiveAlpha, self.mInactiveAlpha)
			self.mMovie:__wf_atom_e57658c2(self.mClipName, 12, self.Alpha)
			self:UpdateEnabledState()
		end,
		IsActive = function(self)
			return self.mIsVisible and self.mActive
		end,
		UpdateEnabledState = function(self)
			local v = not self:IsPlayingWithController() or self.mVariant == VARIANTS.SPECIAL_BUTTON
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 67, v and self.mActive)
		end,
		SetAnchor = function(self, mAnchor)
			if mAnchor == nil or mAnchor == self.mAnchor then
				return
			end

			self.mAnchor = mAnchor
			self:Resize()
		end,
		SetPosition = function(self, p3, p4, p5)
			self.mX = p3 or self.mX or self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 0)
			self.mY = p4 or self.mY or self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 1)
			self:SetAnchor(p5)

			if self.mY == nil then
				return
			end

			self.mMovie:__wf_atom_e57658c2(self.mClipName, 1, self.mY)
		end,
		SetIcon = function(self, p3, p4, mIconShiftX, mIconShiftY)
			if __wf_atom_7e8ad928(p3) then
				self.mIconSize = nil
				self.mIconShiftX = nil
				self.mIconShiftY = nil
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, false)
			else
				local mIconSize = p4 or self.mHeight
				self.mIconSize = mIconSize
				self.mIconShiftX = mIconShiftX
				self.mIconShiftY = mIconShiftY
				self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon.Icon", p3)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, true)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon.Icon", 14, mIconSize)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon.Icon", 15, mIconSize)
			end

			self:Resize()
		end,
		SetIconText = function(p3, list, p4, p5)
			if #list == 0 then
				p3.mMovie:__wf_atom_7f57ab2f(p3.mClipName, "Icon.Text", 13, false)
				return
			end

			p3.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Icon.Text", 50, p4)
			p3.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Icon.Text", 44, p5)
			p3.mMovie:__wf_atom_48bd5a59(p3.mClipName, "Icon.Text", 36, list)
			p3.mMovie:__wf_atom_7f57ab2f(p3.mClipName, "Icon.Text", 13, true)
		end,
		IsPlayingWithController = function(p3)
			return p3.mCallout ~= nil and Engine.IsPlayingWithController()
		end,
		ValueChanged = function(_) end,
		SetVariant = function(self, mVariant)
			self.mVariant = mVariant

			if mVariant == VARIANTS.DOTTED then
				self.mBorderMaterial = _G.UIMaterial_BackerBorderSingle
				self.mFocusedBorderMaterial = nil
				self.mBackerMaterial = _G.UIMaterial_BackerBorderFill
				self.mFocusedBackerMaterial = nil
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Border", "VisibilityCenter", 1, 0, 0, 0)
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Border", "VisibilitySize", 2, 0, 0, 0)
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Backer", "VisibilityCenter", 1, 0, 0, 0)
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Backer", "VisibilitySize", 2, 0, 0, 0)
			elseif mVariant == VARIANTS.PAPER then
				self.mBorderMaterial = nil
				self.mFocusedBorderMaterial = nil
				self.mBackerMaterial = _G.UIMaterial_DarkPaperBackerAlt
				self.mFocusedBackerMaterial = _G.UIMaterial_DarkPaperBacker
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Backer", "VisibilityCenter", 1, 0, 0, 0)
				mMovie3:__wf_atom_1ca72041(mClipName2 .. ".MaterialBacker.Backer", "VisibilitySize", 2, 0, 0, 0)
			else
				self.mBorderMaterial = nil
				self.mFocusedBorderMaterial = nil
				self.mBackerMaterial = nil
				self.mFocusedBackerMaterial = nil
			end

			self:Redraw()
		end
	}
	mMovie3:__wf_atom_7f57ab2f(mClipName2, "Icon", 13, false)
	mMovie3:__wf_atom_7f57ab2f(mClipName2, "Icon.Text", 13, false)
	mMovie3:__wf_atom_4c1c1986(mClipName2, "HoldProgress.Bar.Fill", 12, 0)
	mMovie3:__wf_atom_4c1c1986(mClipName2, "HoldProgress", 11, _G.UIColor_Tan)
	mMovie3:__wf_atom_4c1c1986(mClipName2, "HoldProgress", 12, 15)
	mMovie3:OverrideMaterial(mClipName2 .. ".GamepadBacker", _G.UIMaterial_GamepadButtonBacker)
	v:SetPosition()
	v:HookUpCallbacks(p)
	v:Redraw()
	return v
end