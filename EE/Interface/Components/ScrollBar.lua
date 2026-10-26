module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")

function CreateScrollBar(mMovie, mClipName2, mHeight2, mVisibleProp2, mHorizontal)
	if __wf_atom_7e8ad928(mHeight2) or mHeight2 < 30 then
		print("The height needs to be at least " .. 30 .. ", which is the minimum size of the scrub")
		assert(false)
	end

	if __wf_atom_7e8ad928(mVisibleProp2) or mVisibleProp2 <= 0 then
		print("The visible proportion is a number (> 0 and < 1)")
		assert(false)
	end

	local v = {
		mMovie = mMovie,
		mClipName = mClipName2,
		mInitialized = false,
		mDragging = false,
		mCurrentScroll = 0,
		mEnabled = true,
		mActive = nil,
		mEnableSmoothScroll = false,
		mSmoothScroll = __wf_atom_10cd16b2(0, 0.125),
		mInitialRootX = mMovie:__wf_atom_5e6e15c8(mClipName2, 0),
		mInitialY = mMovie:__wf_atom_cfc41e35(mClipName2, "Scrub", 1),
		mInitialHitzoneScaleX = mMovie:__wf_atom_5e6e15c8(mClipName2 .. ".HitZone", 5) or 1,
		mHeight = mHeight2,
		mExpandedScale = 100,
		mVisibleProp = mVisibleProp2,
		mScrollValueChangedCallback = nil,
		mScrubStartDragCallback = nil,
		mScrubStopDragCallback = nil,
		mScrollStep = 0.1,
		mHookedUpCallbacks = false,
		mCondensedScrub = true,
		mHorizontal = mHorizontal,
		mApplyThemes = true,
		mPrefix = "ScrollBar(" .. mClipName2 .. ")::",
		mScale = 100,
		mThemedScale = 75,
		mColorOverrides = nil,
		GetParentEnv = function(self)
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v)
				v += 1
			until mParentEnv.mMovie

			self.mParentEnv = mParentEnv
			return mParentEnv
		end,
		GetScrollValue = function(self)
			return self.mCurrentScroll
		end,
		GetTargetScrollValue = function(self)
			if self.mEnableSmoothScroll then
				return self.mSmoothScroll.mTargetVal
			end

			return self.mCurrentScroll
		end,
		SetScrollValue = function(self, p, p2, p3)
			if not (self.mInitialized and self.mEnabled) then
				return
			end

			local v = __wf_atom_421b01aa(p, 0, 1)
			local dragRange, v2 = self:GetDragRange()
			local v3 = dragRange + (v2 - dragRange) * v
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub", 1, v3)
			local mCurrentScroll = self.mCurrentScroll
			local mCurrentScroll2 = __wf_atom_421b01aa(v, 0, 1)

			if self.mEnableSmoothScroll then
				if
					(p3 or mCurrentScroll2 ~= self.mSmoothScroll.mTargetVal)
					and not __wf_atom_7e8ad928(self.mScrollValueChangedCallback)
				then
					if p3 then
						self.mSmoothScroll:__wf_atom_4453e49c(mCurrentScroll2)
					else
						self.mSmoothScroll:__wf_atom_09294a87(mCurrentScroll2)
					end

					self.mSmoothScroll:Update(__wf_atom_fa1258d0())
					self.mCurrentScroll = self.mSmoothScroll:__wf_atom_9e368823()

					if not p2 then
						self.mScrollValueChangedCallback(self.mCurrentScroll, mCurrentScroll)
					end
				end
			elseif
				(p3 or mCurrentScroll2 ~= mCurrentScroll)
				and not __wf_atom_7e8ad928(self.mScrollValueChangedCallback)
			then
				self.mCurrentScroll = mCurrentScroll2

				if not p2 then
					self.mScrollValueChangedCallback(mCurrentScroll2, mCurrentScroll)
				end
			end
		end,
		SetHeight = function(self, mHeight, p, p2)
			if not self.mInitialized then
				return
			end

			self.mHeight = mHeight
			self:SetScrollValue(self.mCurrentScroll, p, p2)
			self:RedrawScrollBar()
		end,
		Initialize = function(self)
			self.mMovie:__wf_atom_c0d7a318(self.mClipName, "HitZone", "noMenuSelection", true)
			self.mMovie:__wf_atom_c0d7a318(self.mClipName, "Scrub.HitZone", "noMenuSelection", true)
			self:RedrawScrollBar()
			self.mInitialized = true
		end,
		UpdateScrollPos = function(self)
			local mCurrentScroll = self.mCurrentScroll
			local __wf_atom_cfc41e35 = self.mMovie:__wf_atom_cfc41e35(self.mClipName, "Scrub", 1)

			if __wf_atom_cfc41e35 ~= nil then
				local dragRange, v = self:GetDragRange()
				local v2 = v - dragRange
				local mCurrentScroll2 = v2 == 0 and 0 or __wf_atom_421b01aa((__wf_atom_cfc41e35 - dragRange) / v2, 0, 1)

				if self.mEnableSmoothScroll then
					if mCurrentScroll2 ~= self.mSmoothScroll:__wf_atom_9e368823() then
						self.mSmoothScroll:__wf_atom_09294a87(mCurrentScroll2)
					end

					self.mSmoothScroll:Update(__wf_atom_fa1258d0())
					mCurrentScroll2 = self.mSmoothScroll:__wf_atom_9e368823()
				end

				if mCurrentScroll2 ~= mCurrentScroll and not __wf_atom_7e8ad928(self.mScrollValueChangedCallback) then
					self.mCurrentScroll = mCurrentScroll2
					self.mScrollValueChangedCallback(mCurrentScroll2, mCurrentScroll)
				end
			end
		end,
		Update = function(self)
			if self.mDragging or self.mEnableSmoothScroll then
				self:UpdateScrollPos()
			end
		end,
		GetScrubHeight = function(self)
			return (__wf_atom_421b01aa(module.Round(self.mHeight * self.mVisibleProp), 30, self.mHeight))
		end,
		GetColors = function(self)
			local floatingContent, floatingContentHighlight, background

			if self.mColorOverrides == nil then
				local mApplyThemes = self.mApplyThemes
				floatingContent = module2.GetColor(9, true, mApplyThemes)
				floatingContentHighlight = module2.GetColor(10, true, mApplyThemes)
				background = module2.GetColor(2, true, mApplyThemes)
			else
				floatingContent = self.mColorOverrides.FloatingContent
				floatingContentHighlight = self.mColorOverrides.FloatingContentHighlight
				background = self.mColorOverrides.Background
			end

			return
				module.ConvertColorNumberToProceduralRGB(floatingContent),
				module.ConvertColorNumberToProceduralRGB(floatingContentHighlight),
				module.ConvertColorNumberToProceduralRGB(background)
		end,
		UpdateColors = function(self)
			local colors, _, v = self:GetColors()
			self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Bg", "RectEdgeColor", colors.r, colors.g, colors.b, 0.05)
			self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Bg", "RectInnerColor", v.r, v.g, v.b, 1)
			self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Scrub.ScrubMiddle", "RectEdgeColor", v.r, v.g, v.b, 0.5)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Scrub.ScrubMiddle",
				"RectInnerColor",
				colors.r,
				colors.g,
				colors.b,
				1
			)
		end,
		RedrawScrollBar = function(self)
			local scrubHeight = self:GetScrubHeight()
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BottomCap", 1, self.mHeight - 8)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Bg", 15, self.mHeight - 4)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Blurer", 15, self.mHeight - 4)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "HitZone", 15, self.mHeight)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub.ScrubMiddle", 15, scrubHeight)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub.HitZone", 15, scrubHeight)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub.ScrubHandle", 1, module.Round(scrubHeight / 2))
			self:UpdateColors()
		end,
		GetDragRange = function(self)
			local scrubHeight = self:GetScrubHeight()
			return self.mInitialY, self.mInitialY + (self.mHeight - scrubHeight - 4)
		end,
		StartDrag = function(self)
			if not self.mDragging and self.mEnabled then
				self.mDragging = true
				local v = tonumber(self.mMovie:__wf_atom_76657dba(self.mClipName .. ".Scrub"))
				local dragRange, v2 = self:GetDragRange()
				__wf_atom_86cbd68d(self.mMovie, self.mClipName .. ".Scrub.startDrag", false, v, dragRange, v, v2)

				if not __wf_atom_7e8ad928(self.mScrubStartDragCallback) then
					self.mScrubStartDragCallback()
				end
			end
		end,
		StopDrag = function(self)
			if self.mDragging then
				self.mDragging = false
				__wf_atom_86cbd68d(self.mMovie, self.mClipName .. ".Scrub.stopDrag")
				self:UpdateScrollPos()

				if not __wf_atom_7e8ad928(self.mScrubStopDragCallback) then
					self.mScrubStopDragCallback()
				end
			end
		end,
		SetFocused = function(self, p)
			local colors, v, v2 = self:GetColors()
			local ternary = module.Ternary(p, v, colors)
			local ternary2 = module.Ternary(p, colors, v2)
			local ternary3 = module.Ternary(p, v2, colors)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Scrub.ScrubMiddle",
				"RectInnerColor",
				ternary.r,
				ternary.g,
				ternary.b,
				1
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectInnerColor",
				ternary2.r,
				ternary2.g,
				ternary2.b,
				module.Ternary(p, 0.75, 1)
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectEdgeColor",
				ternary3.r,
				ternary3.g,
				ternary3.b,
				module.Ternary(p, 0.1, 0.05)
			)

			if self.mCondensedScrub then
				__wf_atom_ec43d06e(
					self.mMovie,
					self.mClipName .. ".Scrub.ScrubMiddle",
					2,
					{ 5 },
					{ module.Ternary(p, self.mExpandedScale, 100) },
					0.15
				)
			end
		end,
		ScrubRollOver = function(self)
			local mApplyThemes = self.mApplyThemes
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module2.GetColor(10, true, mApplyThemes))
			local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module2.GetColor(9, true, mApplyThemes))
			local convertColorNumberToProceduralRGB3 = module.ConvertColorNumberToProceduralRGB(module2.GetColor(2, true, mApplyThemes))
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Scrub.ScrubMiddle",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				0.75
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB3.r,
				convertColorNumberToProceduralRGB3.g,
				convertColorNumberToProceduralRGB3.b,
				0.1
			)

			if self.mCondensedScrub then
				__wf_atom_ec43d06e(
					self.mMovie,
					self.mClipName .. ".Scrub.ScrubMiddle",
					2,
					{ 5 },
					{ self.mExpandedScale },
					0.15
				)
			end

			if not __wf_atom_7e8ad928(self.mScrubRollOverCallback) then
				self:mScrubRollOverCallback()
			end
		end,
		ScrubRollOut = function(self)
			local mApplyThemes = self.mApplyThemes
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module2.GetColor(9, true, mApplyThemes))
			local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module2.GetColor(2, true, mApplyThemes))
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Scrub.ScrubMiddle",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				1
			)
			self.mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				0.05
			)

			if self.mCondensedScrub then
				__wf_atom_ec43d06e(self.mMovie, self.mClipName .. ".Scrub.ScrubMiddle", 2, { 5 }, { 100 }, 0.15)
			end

			if not __wf_atom_7e8ad928(self.mScrubRollOutCallback) then
				self:mScrubRollOutCallback()
			end
		end,
		ScrollBarRollOver = function(self)
			self:SetFocused(true)

			if not __wf_atom_7e8ad928(self.mScrollBarRollOverCallback) then
				self:mScrollBarRollOverCallback()
			end
		end,
		ScrollBarRollOut = function(self)
			self:SetFocused(false)

			if not __wf_atom_7e8ad928(self.mScrollBarRollOutCallback) then
				self:mScrollBarRollOutCallback()
			end
		end,
		ClickScrollBar = function(self)
			if self.mEnabled then
				local dragRange, v = self:GetDragRange()
				local scrubHeight = self:GetScrubHeight()
				local v2 = self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 31) - scrubHeight / 2 + 2
				local rounded = module.Round(__wf_atom_421b01aa(v2, dragRange, v))
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub", 1, rounded)
				self:UpdateScrollPos()
				self:StartDrag()
			end
		end,
		SetVisibleProp = function(self, mVisibleProp, p)
			if not self.mInitialized or self.mVisibleProp == mVisibleProp then
				return
			end

			self.mVisibleProp = mVisibleProp
			self:RedrawScrollBar()
			self:SetScrollValue(self:GetScrollValue(), p, true)
		end,
		ScrollBy = function(self, p, p2)
			if self.mEnableSmoothScroll then
				self:SetScrollValue(self:GetTargetScrollValue() + p, p2)
			else
				self:SetScrollValue(self:GetScrollValue() + p, p2)
			end
		end,
		ScrollByStep = function(self, p, p2, p3)
			local v = tonumber(p)

			if v < 0 and self.mCurrentScroll > 0 or v > 0 and self.mCurrentScroll < 1 then
				self:ScrollBy(v * self.mScrollStep, p3)
			end

			if not __wf_atom_7e8ad928(p2) then
				module.PlaySound(p2)
			end
		end,
		ScrollUp = function(self, p)
			self:ScrollBy(-self.mScrollStep, p)
		end,
		ScrollDown = function(self, p)
			self:ScrollBy(self.mScrollStep, p)
		end,
		OnGamepadTransition = function(self, p)
			self.mExpandedScale = module.Ternary(p, 100, 130)
			self.mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"HitZone",
				5,
				self.mInitialHitzoneScaleX * (self.mExpandedScale / 100)
			)
			self.mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"Scrub.HitZone",
				5,
				self.mInitialHitzoneScaleX * (self.mExpandedScale / 100)
			)
			self:ApplyScale()
		end,
		HookUpCallbacks = function(self)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local parentEnv = self:GetParentEnv()
			local mClipName = self.mClipName
			module.HookUpEnvironmentCallback(mClipName, parentEnv, "Update", function()
				self:Update()
			end)
			module.HookUpEnvironmentCallback(mClipName, parentEnv, "OnGamepadTransition", function(p)
				self:OnGamepadTransition(p == "true")
			end)
			module.HookUpEnvironmentCallback(mClipName, parentEnv, "onViewportSizeChanged", function(_, _)
				self:ApplyScale()
			end)
			local mCallbackPrefix = string.gsub(mClipName, "%.", "")

			if self.mCallbackPrefix ~= nil then
				mCallbackPrefix = self.mCallbackPrefix
			end

			parentEnv[mCallbackPrefix .. "StartDrag"] = function()
				self:StartDrag()
			end

			parentEnv[mCallbackPrefix .. "StopDrag"] = function()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "ScrubRollOver"] = function()
				self:ScrubRollOver()
			end

			parentEnv[mCallbackPrefix .. "ScrubRollOut"] = function()
				self:ScrubRollOut()
			end

			parentEnv[mCallbackPrefix .. "ScrubReleaseOutside"] = function()
				self:ScrubRollOut()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "BarClick"] = function()
				self:ClickScrollBar()
			end

			parentEnv[mCallbackPrefix .. "BarRelease"] = function()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "BarReleaseOutside"] = function()
				self:ScrubRollOut()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "BarRollOver"] = function()
				self:ScrollBarRollOver()
			end

			parentEnv[mCallbackPrefix .. "BarRollOut"] = function()
				self:ScrollBarRollOut()
			end

			self.mMovie:SetCallbacks(
				mClipName .. ".Scrub.HitZone",
				mCallbackPrefix .. "ScrubRollOver",
				mCallbackPrefix .. "ScrubRollOut",
				mCallbackPrefix .. "StopDrag",
				mCallbackPrefix .. "StartDrag"
			)
			self.mMovie:SetReleaseOutsideCallback(
				mClipName .. ".Scrub.HitZone",
				mCallbackPrefix .. "ScrubReleaseOutside"
			)
			self.mMovie:SetCallbacks(
				mClipName .. ".HitZone",
				mCallbackPrefix .. "BarRollOver",
				mCallbackPrefix .. "BarRollOut",
				mCallbackPrefix .. "BarRelease",
				mCallbackPrefix .. "BarClick"
			)
			self.mMovie:SetReleaseOutsideCallback(mClipName .. ".HitZone", mCallbackPrefix .. "BarReleaseOutside")
		end,
		SetEnabled = function(self, p)
			local mEnabled = p == true
			self.mEnabled = mEnabled

			if self.mDragging then
				self:StopDrag()
			end

			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "HitZone", 67, mEnabled)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Scrub.HitZone", 67, mEnabled)

			if not self.mCondensedScrub then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Scrub.ScrubMiddle", 5, 70)
			end
		end,
		SetActive = function(self, mActive)
			if self.mActive ~= nil and self.mActive == mActive then
				return
			end

			local v = self.mActive == nil and 0 or 0.2
			self.mActive = mActive
			local v2 = self.mActive and 100 or 50
			local v3 = not self.mActive and 30 or self:GetScale()
			local v4 = { "_alpha", self.mHorizontal and "_yscale" or "_xscale" }
			local v5 = { v2, v3 }

			if self.mInactiveXOffset ~= nil then
				table.insert(v4, "_x")
				local v6

				if self.mActive then
					v6 = self.mInitialRootX
				else
					v6 = self.mInitialRootX + self.mInactiveXOffset
				end

				table.insert(v5, v6)
			end

			__wf_atom_ec43d06e(self.mMovie, self.mClipName, 8, v4, v5, v)
		end,
		SetVisibleRangeMaterial = function(p, p2, p3)
			local v = { "Scrub.ScrubHandle" }

			for i = 1, #v do
				p.mMovie:OverrideMaterial(p.mClipName .. "." .. v[i], p2)
			end

			local v2 = { "Bg", "Scrub.ScrubMiddle" }

			for i = 1, #v2 do
				p.mMovie:OverrideMaterial(p.mClipName .. "." .. v2[i], p3)
			end
		end,
		GetScale = function(self)
			if not self.mApplyThemes then
				return self.mScale
			end

			local v = 1 - (1 - 900 / self.mMovie:__wf_atom_c4f6543f()) / 2
			return self.mThemedScale * v
		end,
		ApplyScale = function(self)
			self.mMovie:__wf_atom_e57658c2(self.mClipName, 5, self:GetScale())
		end
	}
	mMovie:__wf_atom_4c1c1986(mClipName2, "Bg", 12, 100)
	mMovie:__wf_atom_4c1c1986(mClipName2, "Bg", 14, 14)
	mMovie:OverrideMaterial(mClipName2 .. ".Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial(mClipName2 .. ".Scrub.ScrubMiddle", _G.UIMaterial_RectangleNoDepth)

	if Engine.__wf_atom_b6edc589() then
		v.mScale *= 2
		v.mThemedScale *= 2
	end

	v:OnGamepadTransition(not Engine.IsPlayingWithController())
	return v
end