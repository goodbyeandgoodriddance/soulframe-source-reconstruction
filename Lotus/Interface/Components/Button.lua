module(..., package.seeall)

function CreateButton(mMovie, mClipName, mLabel2, mCallback, mCallout, mTitle, mIcon, mNewDesign)
	local v = {
		mMovie = mMovie,
		mClipName = mClipName,
		mLabel = mLabel2,
		mCallback = mCallback,
		mCallout = mCallout,
		mCalloutSeparation = 0,
		mOnSelectedCallback = nil,
		mIsVisible = true,
		mIsActive = true,
		mIsFocused = false,
		mId = -1,
		mLabelOnColor = nil,
		mLabelOffColor = nil,
		mButtonOnColor = nil,
		mButtonOffColor = nil,
		mOnPressedCallback = nil,
		mOnFocusedCallback = nil,
		mOnUnfocusedCallback = nil,
		UTIL = require("EE.Interface.Utilities"),
		mReposition = true,
		mMultiline = nil,
		mLabelWidth = nil,
		mVerticalAlignment = "center",
		mPrefix = "Button(" .. mClipName .. ")::",
		mTitle = mTitle,
		mIcon = mIcon,
		mWidth = 200,
		mNewDesign = mNewDesign,
		mApplyMaterials = true,
		mAlignment = "left",
		mPadding = 8,
		mIsDiegetic = false,
		mFitToText = false,
		mFittedPadding = 20,
		mFittedPaddingWithController = 45,
		mRollOverSound = _G.UISound_Focus,
		mSkipLocalization = false,
		mTintIcons = false,
		Print = function(_, _) end,
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
		IsPlayingWithController = function(p)
			return Engine.IsPlayingWithController() and p.mCallout ~= ""
		end,
		HookUpCallbacks = function(self)
			local v = "onKeyUp_" .. string.sub(self.mCallout, 2, -2)
			local v2 = "onKeyDown_" .. string.sub(self.mCallout, 2, -2)
			local parentEnv = self:GetParentEnv()

			if parentEnv[v] == nil and parentEnv[v2] == nil and self.mCallout ~= "" then
				parentEnv[v] = function()
					if not parentEnv.IsInputBlocked() then
						self:CalloutTriggered()
					end
				end
			end

			local v3 = string.gsub(self.mClipName, "%.", "")

			parentEnv[v3 .. "Over"] = function()
				self:RollOver()
			end

			parentEnv[v3 .. "Out"] = function()
				self:RollOut()
			end

			parentEnv[v3 .. "Pressed"] = function()
				self:Pressed()
			end

			self.mMovie:SetCallbacks(
				self.mClipName .. ".Btn",
				v3 .. "Over",
				v3 .. "Out",
				self.mCallback,
				v3 .. "Pressed"
			)
			self:SetId(self.mId)
		end,
		SetId = function(self, mId)
			self.mId = mId
			self.mMovie:__wf_atom_e57658c2(self.mClipName .. ".Btn", 100, self.mId)
		end,
		Redraw = function(self)
			local mLabel = self.mLabel

			if not self.mSkipLocalization then
				mLabel = self.mMovie:__wf_atom_8e9ac384(mLabel, true)
			end

			if self.mNewDesign and self.mCallout and (self:IsPlayingWithController() or self.mShowCallout) then
				mLabel = self.mMovie:__wf_atom_8e9ac384(self.mCallout, true) .. " " .. mLabel
			end

			self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 36, mLabel)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Label", 89, self.mTintIcons)
			local mWidth = self.mWidth

			if self.mFitToText then
				mWidth = self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 40) + self.UTIL.Ternary(
					self:IsPlayingWithController(),
					self.mFittedPaddingWithController,
					self.mFittedPadding
				)
			end

			__wf_atom_86cbd68d(
				self.mMovie,
				self.mClipName .. ".gotoAndStop",
				self.UTIL.Ternary(self.mNewDesign or not self:IsPlayingWithController(), "PC", "PS4")
			)

			if self.mClickable or not (self:IsPlayingWithController() or self.mShowCallout) then
				self.mMovie:OverrideMaterial(self.mClipName .. ".Btn", _G.UIMaterial_Plain)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, true)
			else
				if not self.mNewDesign then
					self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callout.Icon.Tf.text", self.mCallout)

					if self.mLabelWidth ~= nil then
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Label", 14, self.mLabelWidth)
					end

					self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Callout.Label", 46, self.mVerticalAlignment)

					if self.mMultiline ~= nil then
						self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Callout.Label", 52, self.mMultiline)
					end

					self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callout.Label.text", self.mLabel)

					if self.mReposition then
						local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(
							self.mClipName .. ".Callout.Icon.Tf",
							40
						)

						if __wf_atom_5e6e15c8 ~= nil then
							self.mMovie:__wf_atom_4c1c1986(
								self.mClipName,
								"Callout.Label",
								0,
								__wf_atom_5e6e15c8 / 2 + self.mCalloutSeparation
							)
							local v = __wf_atom_5e6e15c8 + self.mCalloutSeparation + self.mMovie:__wf_atom_5e6e15c8(
								self.mClipName .. ".Callout.Label",
								40
							)
							self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout", 0, -v + __wf_atom_5e6e15c8 / 2)
						end
					end
				end

				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, false)
			end

			if self.mNewDesign then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, mWidth)

				if self.mReposition then
					self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 0, self.mPadding)
					self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 14, mWidth - self.mPadding * 2)
				end

				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 45, self.mAlignment)

				if self.mApplyMaterials then
					if self.mIsDiegetic then
						self.mMovie:OverrideMaterial(self.mClipName .. ".Btn", _G.UIMaterial_SmoothEdge)
					else
						self.mMovie:OverrideMaterial(self.mClipName .. ".Btn", _G.UIMaterial_SmoothEdgeNoDepthTest)
					end
				end
			end

			self:SetDefaultColors()

			if not __wf_atom_7e8ad928(self.mTitle) then
				self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Title.text", self.mTitle)
			end

			if not __wf_atom_7e8ad928(self.mIcon) then
				self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".Image", self.mIcon)
			end

			if self.OnRedraw ~= nil then
				self:OnRedraw()
			end

			self:HookUpCallbacks()
		end,
		CalloutTriggered = function(self)
			if self:IsActive() then
				if self.mCallback ~= "" then
					self:GetParentEnv()[self.mCallback](self.UTIL.Ternary(self.mId == nil, "", (tostring(self.mId))))
				end

				if self.mIsVisible and self:IsPlayingWithController() then
					if self.mIsDiegetic then
						self.UTIL.CreateUIParticles(
							self.mMovie,
							self.mClipName .. ".Callout" .. self.UTIL.Ternary(self.mNewDesign, "", ".Icon"),
							_G.UIFx_ConsolePress,
							0,
							0
						)
					else
						self.UTIL.CreateParticles(
							self.mMovie,
							self.mClipName .. ".Callout" .. self.UTIL.Ternary(self.mNewDesign, "", ".Icon"),
							_G.UIFx_ConsolePress,
							6,
							2
						)
					end
				end
			end
		end,
		SetVisible = function(self, mIsVisible)
			self.mIsVisible = mIsVisible
			self.mMovie:__wf_atom_2dedec1a(self.mClipName, 13, mIsVisible)
		end,
		SetAlpha = function(p, p2)
			p.mMovie:__wf_atom_e57658c2(p.mClipName, 12, p2)
		end,
		IsActive = function(self)
			return self.mIsVisible and self.mIsActive
		end,
		SetActive = function(self, mIsActive)
			self.mIsActive = mIsActive
			self.mMovie:__wf_atom_e57658c2(self.mClipName, 12, self.UTIL.Ternary(self.mIsActive, 100, 50))
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 67, self.mIsActive)
			self:SetDefaultColors()
		end,
		SetDefaultColors = function(self)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Tf", 44, _G.UIColor_White)

			if self:IsPlayingWithController() and not self.mNewDesign then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Label", 44, self.mLabelOffColor)
			else
				self.mMovie:__wf_atom_4c1c1986(
					self.mClipName,
					"Label",
					44,
					self.UTIL.Ternary(
						not self.mClickable and (self:IsPlayingWithController() or self.mShowCallout),
						self.mButtonOffColor,
						self.mLabelOffColor
					)
				)
			end

			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 11, self.mButtonOffColor)

			if self.mNewDesign then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 12, 90)
			end
		end,
		RollOver = function(self)
			if self:IsActive() then
				self.UTIL.PlaySound(self.mRollOverSound)

				if self:IsPlayingWithController() and not self.mNewDesign then
					self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Callout.Label", 44, self.mLabelOnColor)
				else
					self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, self.mLabelOnColor)
				end

				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 11, self.mButtonOnColor)

				if self.mNewDesign then
					self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 12, 90)
				end

				self.mIsFocused = true

				if self.mOnFocusedCallback ~= nil then
					self:mOnFocusedCallback()
				end
			end
		end,
		RollOut = function(self)
			if self:IsActive() then
				self:SetDefaultColors()
				self.mIsFocused = false

				if self.mOnUnfocusedCallback ~= nil then
					self:mOnUnfocusedCallback()
				end
			end
		end,
		Pressed = function(self)
			if self:IsActive() and self.mOnPressedCallback ~= nil then
				self:mOnPressedCallback()
			end
		end
	}
	v.mLabelOnColor = v.UTIL.Ternary(_G.UIColor_Black ~= nil, _G.UIColor_Black, 0)

	if v.mNewDesign then
		v.mLabelOffColor = v.UTIL.Ternary(_G.UIColor_DarkGrey ~= nil, _G.UIColor_DarkGrey, 2368548)
		v.mButtonOnColor = v.UTIL.Ternary(_G.UIColor_Yellow ~= nil, _G.UIColor_Yellow, 14276480)
		v.mButtonOffColor = v.UTIL.Ternary(_G.UIColor_White ~= nil, _G.UIColor_White, 16777215)
	else
		v.mLabelOffColor = v.UTIL.Ternary(_G.UIColor_LightBlue ~= nil, _G.UIColor_LightBlue, 12769497)
		v.mButtonOnColor = v.UTIL.Ternary(_G.UIColor_Orange ~= nil, _G.UIColor_Orange, 13466625)
		v.mButtonOffColor = v.UTIL.Ternary(_G.UIColor_DarkBlue ~= nil, _G.UIColor_DarkBlue, 4546669)
	end

	return v
end