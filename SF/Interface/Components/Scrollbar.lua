module(..., package.seeall)
local module = require("EE.Interface.Utilities")

function CreateScrollBar(state, mClipName2, options)
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.mMovie) then
		print("ScrollBar created without valid env")
		return
	end

	local mMovie = state.mMovie
	local v = options or {}

	if v.mHeight ~= nil and v.mHeight < 40 then
		print("The height needs to be at least " .. 40 .. ", which is the minimum size of the scrub")
		assert(false)
	end

	if v.mVisibleProp ~= nil and v.mVisibleProp <= 0 then
		print("The visible proportion is a number (> 0 and < 1)")
		assert(false)
	end

	local result = {
		mClipName = mClipName2,
		mClipToScroll = nil,
		mDragging = false,
		mCurrentScroll = 0,
		mEnabled = mMovie:__wf_atom_a91463a8(mClipName2, 67),
		mActive = true,
		mVisible = mMovie:__wf_atom_a91463a8(mClipName2, 13),
		mEnableSmoothScroll = true,
		mSmoothScroll = __wf_atom_10cd16b2(0, 0.125),
		mHeight = 40,
		mContentOffset = 0,
		mInitialOffset = 0,
		mVisibleProp = 0.5,
		mVisRangeMaterials = nil,
		mVisRangeFadeSize = nil,
		mScrollValueChangedCallback = nil,
		mScrubStartDragCallback = nil,
		mScrubStopDragCallback = nil,
		mScrollStep = 50,
		mHookedUpCallbacks = false,
		mTroughFocusedSize = 12,
		mTroughUnfocusedSize = 8,
		mPrefix = "ScrollBar(" .. mClipName2 .. ")::",
		GetScrollValue = function(self)
			return self.mCurrentScroll
		end,
		GetTargetScrollValue = function(self)
			if self.mEnableSmoothScroll then
				return self.mSmoothScroll.mTargetVal
			end

			return (self:GetScrollValue())
		end,
		ScrollValueChanged = function(self, p, p2)
			if self.mScrollValueChangedCallback ~= nil then
				self.mScrollValueChangedCallback(p, p2)
			end

			if self.mClipToScroll ~= nil then
				mMovie:__wf_atom_e57658c2(
					self.mClipToScroll,
					1,
					-module.Round(self:GetScrollRange() * p) + self.mInitialOffset
				)
			end
		end,
		SetScrollValue = function(self, p, p2, p3)
			if not (p3 or self.mEnabled and self.mVisible) then
				return
			end

			local mCurrentScroll = self.mCurrentScroll
			local mCurrentScroll2 = __wf_atom_421b01aa(p, 0, 1)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 1, self:GetDragRange() * mCurrentScroll2)

			if self.mEnableSmoothScroll then
				if p3 or mCurrentScroll2 ~= self.mSmoothScroll.mTargetVal then
					if p3 then
						self.mSmoothScroll:__wf_atom_4453e49c(mCurrentScroll2)
					else
						self.mSmoothScroll:__wf_atom_09294a87(mCurrentScroll2)
					end

					self.mSmoothScroll:Update(__wf_atom_fa1258d0())
					self.mCurrentScroll = self.mSmoothScroll:__wf_atom_9e368823()

					if not p2 then
						self:ScrollValueChanged(self.mCurrentScroll, mCurrentScroll)
					end
				end
			elseif p3 or mCurrentScroll2 ~= mCurrentScroll then
				self.mCurrentScroll = mCurrentScroll2

				if not p2 then
					self:ScrollValueChanged(mCurrentScroll2, mCurrentScroll)
				end
			end
		end,
		SetHeight = function(self, mHeight, p, p2)
			self.mHeight = mHeight
			self:RedrawScrollBar()
			self:SetScrollValue(self.mCurrentScroll, p, p2)
			self:ResizeVisRangeMaterials()
		end,
		SetVisibleProp = function(self, p, p2, p3)
			if p == nil then
				return
			end

			self:SetVisible(p < 1)

			if self.mVisibleProp == p then
				return
			end

			self.mVisibleProp = __wf_atom_421b01aa(p, 0, 1)

			if not p3 then
				self:RedrawScrollBar()
				self:SetScrollValue(self:GetScrollValue(), p2, true)
			end
		end,
		UpdateScrollPos = function(self)
			local mCurrentScroll = self.mCurrentScroll
			local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(self.mClipName, "Slider", 1)

			if __wf_atom_cfc41e35 ~= nil then
				local mCurrentScroll2 = __wf_atom_421b01aa(__wf_atom_cfc41e35 / self:GetDragRange(), 0, 1)

				if self.mEnableSmoothScroll then
					if mCurrentScroll2 ~= self.mSmoothScroll:__wf_atom_9e368823() then
						self.mSmoothScroll:__wf_atom_09294a87(mCurrentScroll2)
					end

					self.mSmoothScroll:Update(__wf_atom_fa1258d0())
					mCurrentScroll2 = self.mSmoothScroll:__wf_atom_9e368823()
				end

				if mCurrentScroll2 ~= mCurrentScroll then
					self.mCurrentScroll = mCurrentScroll2
					self:ScrollValueChanged(mCurrentScroll2, mCurrentScroll)
				end
			end
		end,
		Update = function(self)
			if self.mDragging or self.mEnableSmoothScroll then
				self:UpdateScrollPos()
			end
		end,
		GetScrubHeight = function(self)
			return 40
		end,
		RedrawScrollBar = function(self)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Trough", 15, self.mHeight)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 15, self:GetScrubHeight())
		end,
		GetScrollRange = function(self)
			local v2 = self.mHeight - self.mContentOffset * 2
			return v2 / self.mVisibleProp - v2
		end,
		GetDragRange = function(self)
			return self.mHeight - self:GetScrubHeight()
		end,
		StartDrag = function(self)
			if not self.mDragging and self.mEnabled and self.mVisible then
				self.mDragging = true
				__wf_atom_86cbd68d(mMovie, self.mClipName .. ".Slider.startDrag", false, 0, 0, 0, self:GetDragRange())

				if not __wf_atom_7e8ad928(self.mScrubStartDragCallback) then
					self.mScrubStartDragCallback()
				end
			end
		end,
		StopDrag = function(self)
			if self.mDragging then
				self.mDragging = false
				__wf_atom_86cbd68d(mMovie, self.mClipName .. ".Slider.stopDrag")
				self:UpdateScrollPos()

				if not __wf_atom_7e8ad928(self.mScrubStopDragCallback) then
					self.mScrubStopDragCallback()
				end
			end
		end,
		ScrubRollOver = function(self)
			if not __wf_atom_7e8ad928(self.mScrubRollOverCallback) then
				self:mScrubRollOverCallback()
			end

			__wf_atom_ec43d06e(mMovie, self.mClipName .. ".Trough.Backer", 0, { 14 }, { self.mTroughFocusedSize }, 0.1)
		end,
		ScrubRollOut = function(self)
			if not __wf_atom_7e8ad928(self.mScrubRollOutCallback) then
				self:mScrubRollOutCallback()
			end

			__wf_atom_ec43d06e(
				mMovie,
				self.mClipName .. ".Trough.Backer",
				0,
				{ 14 },
				{ self.mTroughUnfocusedSize },
				0.1
			)
		end,
		ScrollBarRollOver = function(self)
			if not __wf_atom_7e8ad928(self.mScrollBarRollOverCallback) then
				self:mScrollBarRollOverCallback()
			end

			__wf_atom_ec43d06e(mMovie, self.mClipName .. ".Trough.Backer", 0, { 14 }, { self.mTroughFocusedSize }, 0.1)
		end,
		ScrollBarRollOut = function(self)
			self:StopDrag()

			if not __wf_atom_7e8ad928(self.mScrollBarRollOutCallback) then
				self:mScrollBarRollOutCallback()
			end

			__wf_atom_ec43d06e(
				mMovie,
				self.mClipName .. ".Trough.Backer",
				0,
				{ 14 },
				{ self.mTroughUnfocusedSize },
				0.1
			)
		end,
		ClickScrollBar = function(self)
			if self.mEnabled and self.mVisible then
				local scrubHeight = self:GetScrubHeight()
				local v2 = mMovie:__wf_atom_5e6e15c8(self.mClipName, 31) - scrubHeight / 2
				local rounded = module.Round(__wf_atom_421b01aa(v2, 0, self:GetDragRange()))
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 1, rounded)
				self:UpdateScrollPos()
				self:StartDrag()
			end
		end,
		ScrollBy = function(self, p, p2, p3)
			if not p3 then
				p /= self:GetScrollRange()
			end

			self:SetScrollValue(self:GetTargetScrollValue() + p, p2)
		end,
		ScrollByStep = function(self, p, uiSound_Scroll, p2)
			local v2 = tonumber(p)

			if v2 < 0 and self.mCurrentScroll > 0 or v2 > 0 and self.mCurrentScroll < 1 then
				self:ScrollBy(v2 * self.mScrollStep, p2)
			end

			if type(uiSound_Scroll) ~= "userdata" then
				if uiSound_Scroll == false then
					uiSound_Scroll = nil
				else
					uiSound_Scroll = _G.UISound_Scroll
				end
			end

			if not __wf_atom_7e8ad928(uiSound_Scroll) then
				module.PlaySound(uiSound_Scroll)
			end
		end,
		ScrollUp = function(self, p)
			self:ScrollBy(-self.mScrollStep, p)
		end,
		ScrollDown = function(self, p)
			self:ScrollBy(self.mScrollStep, p)
		end,
		ScrollDirection = function(self, p, p2)
			local v2 = tonumber(p)

			if v2 == nil then
				return
			end

			if v2 > 0 then
				self:ScrollDown(p2)
			else
				self:ScrollUp(p2)
			end
		end,
		OnGamepadTransition = function(self, _) end,
		GetVisValues = function(self)
			return
				self.mHeight - self.mContentOffset * 2 + (self.mVisRangeSizeOffset or 0),
				mMovie:__wf_atom_5e6e15c8(self.mClipName, 3) + self.mHeight / 2
		end,
		ResizeVisRangeMaterials = function(self)
			local visValues, v2 = self:GetVisValues()
			local mVisRangeMaterials = self.mVisRangeMaterials
			module.ScaleVisRangeMaterials(
				mMovie,
				v2,
				visValues,
				self.mHorizontal,
				mVisRangeMaterials,
				self.mVisRangeFadeSize
			)
			module.ScaleSlicedMaterials(mMovie, mVisRangeMaterials)
		end,
		HookUpCallbacks = function(self)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local mClipName = self.mClipName
			local mCallbackPrefix = self.mCallbackPrefix or string.gsub(mClipName, "%.", "")
			module.HookUpEnvironmentCallback(mClipName, state, "Update", function()
				self:Update()
			end)
			module.HookUpEnvironmentCallback(mClipName, state, "OnGamepadTransition", function(p)
				self:OnGamepadTransition(p == "true")
			end)
			module.HookUpEnvironmentCallback(mClipName, state, "onViewportSizeChanged", function(_, _)
				self:ResizeVisRangeMaterials()
			end)

			if state.onKeyDown_MENU_MOUSE_Z == nil then
				function state.onKeyDown_MENU_MOUSE_Z(_, p)
					local v2 = ChooseBestScrollbar(mMovie, state.SCROLLBARS)

					if v2 == nil then
						return
					end

					v2:ScrollByStep(p)
				end

				state.SCROLLBARS = {}
			end

			if state.SCROLLBARS ~= nil then
				state.SCROLLBARS[mCallbackPrefix] = self
			end

			state[mCallbackPrefix .. "StartDrag"] = function()
				self:StartDrag()
			end

			state[mCallbackPrefix .. "StopDrag"] = function()
				self:StopDrag()
			end

			state[mCallbackPrefix .. "ScrubRollOver"] = function()
				self:ScrubRollOver()
			end

			state[mCallbackPrefix .. "ScrubRollOut"] = function()
				self:ScrubRollOut()
			end

			state[mCallbackPrefix .. "ScrubReleaseOutside"] = function()
				self:ScrubRollOut()
				self:StopDrag()
			end

			state[mCallbackPrefix .. "BarClick"] = function()
				self:ClickScrollBar()
			end

			state[mCallbackPrefix .. "BarRollOver"] = function()
				self:ScrollBarRollOver()
			end

			state[mCallbackPrefix .. "BarRollOut"] = function()
				self:ScrollBarRollOut()
			end

			mMovie:SetCallbacks(
				mClipName .. ".Slider",
				mCallbackPrefix .. "ScrubRollOver",
				mCallbackPrefix .. "ScrubRollOut",
				mCallbackPrefix .. "StopDrag",
				mCallbackPrefix .. "StartDrag"
			)
			mMovie:SetReleaseOutsideCallback(mClipName .. ".Slider", mCallbackPrefix .. "ScrubReleaseOutside")
			mMovie:SetCallbacks(
				mClipName .. ".Trough.Hitbox",
				mCallbackPrefix .. "BarRollOver",
				mCallbackPrefix .. "BarRollOut",
				nil,
				mCallbackPrefix .. "BarClick"
			)
			mMovie:__wf_atom_c0d7a318(mClipName, "Trough.Hitbox", "noMenuSelection", true)
		end,
		SetEnabled = function(self, p)
			local mEnabled = p ~= false

			if self.mEnabled == mEnabled then
				return
			end

			self.mEnabled = mEnabled

			if self.mDragging then
				self:StopDrag()
			end

			mMovie:__wf_atom_2dedec1a(self.mClipName, 67, mEnabled)
		end,
		SetActive = function(p, mActive)
			p.mActive = mActive
		end,
		SetVisible = function(self, p, mAlwaysVisible)
			if mAlwaysVisible == nil then
				mAlwaysVisible = self.mAlwaysVisible
			else
				self.mAlwaysVisible = mAlwaysVisible
			end

			local mSliderVisible = p ~= false
			local mVisible = mAlwaysVisible or mSliderVisible

			if self.mVisible == mVisible and self.mSliderVisible == mSliderVisible then
				return
			end

			self.mVisible = mVisible
			self.mSliderVisible = mSliderVisible
			mMovie:__wf_atom_2dedec1a(self.mClipName, 13, self.mVisible)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Slider", 13, self.mSliderVisible)
			local mClipName = self.mClipName
			local v2

			if self.mSliderVisible then
				v2 = _G.UIColor_BlueGreen
			else
				v2 = _G.UIColor_DarkBrown
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Trough.Backer", 11, v2)
		end
	}

	function result:Resize(mHeight)
		if self.mClipToScroll ~= nil then
			if mHeight ~= nil then
				self.mHeight = mHeight
				self.mVisibleProp = nil
				mMovie:__wf_atom_e57658c2(self.mClipToScroll, 15, mHeight)
			end

			self.mInitialOffset = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 1)
			self.mContentOffset = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 3) - mMovie:__wf_atom_5e6e15c8(mClipName2, 3)
			local v2 = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 50) > 0

			if v2 then
				self.mContentOffset += mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 42)

				if self.mHeight == nil then
					self.mHeight = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 15)
				end
			end

			if self.mVisibleProp == nil and self.mHeight ~= nil then
				local v3

				if v2 then
					v3 = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 41)
				else
					v3 = mMovie:__wf_atom_5e6e15c8(self.mClipToScroll, 15)
				end

				self.mVisibleProp = (self.mHeight - self.mContentOffset * 2) / v3
			end
		end

		result:SetVisible(
			self.mHeight ~= nil and self.mVisibleProp ~= nil and self.mVisibleProp < 1,
			self.mAlwaysVisible
		)
		result:RedrawScrollBar()
		result:ResizeVisRangeMaterials()
	end

	result.Resize(v)

	for k, v2 in pairs(v) do
		result[k] = v2
	end

	result:OnGamepadTransition(not Engine.IsPlayingWithController())
	mMovie:OverrideMaterial(mClipName2 .. ".Slider", _G.UIMaterial_ScrollbarSlider)
	mMovie:OverrideMaterial(mClipName2 .. ".Trough.Backer", _G.UIMaterial_ScrollbarBacker)
	result:HookUpCallbacks()
	result:RedrawScrollBar()
	result:ResizeVisRangeMaterials()
	return result
end

function ChooseBestScrollbar(object, items)
	local v = 1e300
	local v2 = nil

	for _, item in items do
		if not (item.mEnabled and item.mVisible) then
			continue
		end

		local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(item.mClipName, "_parent", 32)

		if
			(__wf_atom_cfc41e35 == v or __wf_atom_cfc41e35 <= 0 and v <= 0)
			and object:__wf_atom_cfc41e35(item.mClipName, "_parent", 33) < object:__wf_atom_cfc41e35(v2.mClipName, "_parent", 33)
		then
			v2 = item
		elseif __wf_atom_cfc41e35 < v then
			v2 = item
			v = __wf_atom_cfc41e35
		end
	end

	return v2, v
end