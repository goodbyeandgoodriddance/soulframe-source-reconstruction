module(..., package.seeall)

function Create(object, p, p2, p3, p4, p5, p6, p7, p8)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIUtilities")
	local module3 = require("Lotus.Interface.LotusUtilities")
	local module4 = require("Lotus.Interface.UIStyleUtilities")
	local module5 = require("Lotus.Interface.Components.ThemedButton")
	local v = module5.Create(object, p, p2, p3, p4, p5, p6, p7)
	v.mLabelClipName = p .. ".Label"
	v.mAltButtonVisible = false
	v.mAltButtonIcon = _G.UITexture_ClearSearch
	v.mAltFocused = false
	v.mLockedAltBtnVis = true
	v.mMultiline = false
	v.mToUpper = false
	v.mLocalizeText = false
	v.mHint = ""
	v.mPrefixCallout = false
	v.mUnfocusedUnderlineColorOverride = 4
	v.TYPE = {
		PLAIN = 1,
		EMAIL = 2,
		PASSWORD = 3,
		CHAT = 4,
		SEARCH = 5
	}
	v.mType = v.TYPE.PLAIN
	v.mOskTitle = ""
	v.mOskHint = ""
	v.mOskCallback = ""
	v.mClearTime = 0.5
	v.mLabelYOffset = 0
	v.mLabelXOffset = 4
	v.mSkipAutoFocus = module.Ternary(Engine.__wf_atom_2a979d69(), true, p8)
	v.mUnderlineAlpha = 0
	v.mShowHighlight = false
	v.mInnerAlpha = 100
	v.mInactiveAlpha = 75
	v.Button_HookUpCallbacks = v.HookUpCallbacks

	function v:HookUpCallbacks()
		self:Button_HookUpCallbacks()
		local parentEnv = self:GetParentEnv()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local v2 = string.gsub(mClipName, "%.", "")

		parentEnv[v2 .. "Focused"] = function(p9)
			if self:InvalidId(p9) then
				return
			end

			self:InputFieldFocused(true)
		end

		parentEnv[v2 .. "Unfocused"] = function(p9)
			if self:InvalidId(p9) then
				return
			end

			self:InputFieldFocused(false)
		end

		parentEnv[v2 .. "CharacterLimit"] = function(p9)
			if self:InvalidId(p9) then
				return
			end

			module.PlaySound(_G.UISound_Error)
		end

		parentEnv[v2 .. "TextInput"] = function(p9)
			if self:InvalidId(p9) then
				return
			end

			self:InputFieldTextChanged(mMovie:__wf_atom_387f260e(self.mLabelClipName, 36), false)
		end

		parentEnv[v2 .. "OverAlt"] = function(p9)
			self:SetAltFocus(true, (tonumber(p9)))
		end

		parentEnv[v2 .. "OutAlt"] = function(p9)
			self:SetAltFocus(false, (tonumber(p9)))
		end

		parentEnv[v2 .. "PressAlt"] = function(p9)
			self:AltPressed(true, (tonumber(p9)))
		end

		parentEnv[v2 .. "ReleaseAlt"] = function(p9)
			self:AltPressed(false, (tonumber(p9)))
		end

		if mMovie:__wf_atom_253d7085(mClipName .. ".BtnAlt") then
			mMovie:SetCallbacks(
				mClipName .. ".BtnAlt",
				v2 .. "OverAlt",
				v2 .. "OutAlt",
				v2 .. "ReleaseAlt",
				v2 .. "PressAlt"
			)
		end

		mMovie:SetFocusedCallbacks(
			mClipName .. ".Label",
			v2 .. "Focused",
			v2 .. "Unfocused",
			v2 .. "CharacterLimit",
			v2 .. "TextInput"
		)
		self.mOskCallback = v2 .. "OskCallback"

		parentEnv[v2 .. "OskCallback"] = function(p9, p10)
			if p9 then
				print("cancelled by user")
			else
				self:InputFieldTextChanged(p10, true)
			end
		end
	end

	v.ButtonSetId = v.SetId

	function v.SetId(object2, p9)
		object2:ButtonSetId(p9)

		if object2.mId ~= nil then
			object2.mMovie:__wf_atom_e57658c2(object2.mClipName .. ".BtnAlt", 100, object2.mId)
			object2.mMovie:__wf_atom_e57658c2(object2.mClipName .. ".Label", 100, object2.mId)
		end
	end

	function v.SetNumbersOnly(p9)
		p9.mMovie:__wf_atom_50d60589(p9.mLabelClipName, 38, "0123456789")
	end

	v.ButtonSetActive = v.SetActive

	function v:SetActive(p9)
		self:ButtonSetActive(p9)

		if self.mQueuePressed and p9 then
			self:Pressed(true)
			self.mQueuePressed = false
		end
	end

	function v:SetAltFocus(mAltFocused)
		if self.mAltFocused == mAltFocused then
			return
		end

		if mAltFocused then
			if self.mLocked then
				_T.gToolTip = TitleCase(Localize("/Lotus/Language/Menu/UnlockEmail", {}))
			end
		else
			_T.gToolTip = nil
		end

		self.mAltFocused = mAltFocused
		self:UpdateColors()
	end

	function v:AltPressed(p9)
		if p9 then
			if self.mLocked then
				self:SetLocked(false)
			end

			self:SetText("")
			self:Pressed(true)
		end
	end

	function v:InputFieldFocused(mSelected)
		if self.mIsVisible and self.mActive then
			if self.mLocked then
				return
			end

			self.mSelected = mSelected
			self:SetFocus(mSelected)
			self:SetClearHintVisible(self.mCallout == "<MENU_LTHUMB>" and self.mLabel ~= "" and self.mShowCallout and not self.mPrefixCallout and Engine.IsPlayingWithController())
		else
			self.mMovie:__wf_atom_2004c47f()
			self:SetFocus(false)
			self.mSelected = false
		end
	end

	function v:InputFieldTextChanged(value, _)
		local mLabel = value or ""

		if self.mLabel ~= mLabel then
			self:PlaySound(_G.UISound_SearchType)
		end

		self.mLabel = mLabel
		self:ButtonSetText(mLabel)
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Hint", 13, mLabel == "")
	end

	v.ButtonSetFocus = v.SetFocus

	function v:SetFocus(p9)
		if self.mLocked then
			return
		end

		if p9 or not self.mSelected then
			self:ButtonSetFocus(p9)
		end
	end

	v.ButtonTryPressed = v.TryPressed

	function v:TryPressed(p9, p10)
		if self.mLocked then
			if p9 then
				self:PlaySound(_G.UISound_Error)
				local mApplyThemes = self.mApplyThemes
				local color = module4.GetColor(9, false, mApplyThemes)
				local color2 = module4.GetColor(10, false, mApplyThemes)
				module2.PulseColor(self.mMovie, self.mClipName .. ".BtnAlt", 2, nil, color, color2)
			end
		else
			self:ButtonTryPressed(p9, p10)
		end
	end

	v.ButtonPressed = v.Pressed

	function v:Pressed(p9, p10)
		if self.mLocked then
			return
		end

		if p10 and p9 then
			self.mHoldTime = __wf_atom_c4e218a2()
		elseif p9 or p10 then
			if
				not self.mSelected
				and self.mActive
				and not (Engine.IsPlayingWithController() and Engine.IsOSKAvailable())
			then
				self.mMovie:__wf_atom_46a6af3b(self.mLabelClipName)
			end

			if Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69() then
				if
					self.mHoldTime == nil
					or self.mClearTime == nil
					or not (__wf_atom_c4e218a2() - self.mHoldTime > self.mClearTime)
				then
					if Engine.IsOSKAvailable() then
						if self.mMaxChars == nil then
							gRegion:__wf_atom_858ae72f(
								self.mLabel,
								self.mOskTitle,
								self.mOskHint,
								self.mType == self.TYPE.PASSWORD,
								self.mType == self.TYPE.EMAIL,
								self.mType == self.TYPE.CHAT,
								self.mOskCallback
							)
						else
							gRegion:__wf_atom_06b65d2b(
								self.mLabel,
								self.mOskTitle,
								self.mOskHint,
								self.mType == self.TYPE.PASSWORD,
								self.mType == self.TYPE.EMAIL,
								self.mType == self.TYPE.CHAT,
								self.mOskCallback,
								self.mMaxChars
							)
						end
					end
				else
					self:SetText("")
				end

				self.mMovie:__wf_atom_2449ced2()
			end

			self.mHoldTime = nil
		end

		self:ButtonPressed(p9, p10)
	end

	v.ButtonSetVisible = v.SetVisible

	function v.SetVisible(object2, p9)
		object2:ButtonSetVisible(p9)

		if not p9 and object2.mSelected then
			object2.mMovie:__wf_atom_2004c47f()
		end
	end

	v.ButtonOnGamepadTransition = v.OnGamepadTransition

	function v:OnGamepadTransition()
		self:ButtonOnGamepadTransition()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local v2 = mClipName .. ".Callout"
		local v3 = not Engine.IsPlayingWithController()
		local v4

		if self.mCallout == nil then
			v4 = false
		else
			v4 = self.mShowCallout and not self.mPrefixCallout and not (v3 or self.mLocked)
		end

		if not v3 then
			mMovie:__wf_atom_2004c47f()
		end

		local v5

		if v4 then
			if self.mCallout == "<MENU_LTHUMB>" then
				v5 = self.mLabel ~= ""
			else
				v5 = false
			end
		else
			v5 = v4
		end

		self:SetClearHintVisible(v5)
		mMovie:__wf_atom_7f57ab2f(
			mClipName,
			"BtnAlt",
			13,
			self.mLocked and self.mLockedAltBtnVis or v3 and self.mAltButtonVisible
		)
		mMovie:__wf_atom_2dedec1a(v2, 13, v4)

		if v4 then
			mMovie:__wf_atom_50d60589(v2, 36, mMovie:__wf_atom_8e9ac384(self.mCallout, true))
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v2, 40)
			mMovie:__wf_atom_e57658c2(v2, 0, self.mWidth - __wf_atom_5e6e15c8 - self.mTextBuffer)
		end
	end

	v.ButtonResize = v.Resize

	function v.Resize(object2)
		object2:ButtonResize()
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "ClearSearchLabel", 14, object2.mWidth)
		object2.mMovie:__wf_atom_4c1c1986(
			object2.mClipName,
			"BtnAlt",
			0,
			object2.mWidth - module.Ternary(object2.mType == object2.TYPE.SEARCH, 16, 24)
		)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BtnAlt", 1, object2.mHeight / 2)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Hint", 14, object2.mWidth - object2.mTextBuffer * 2)
		local v2 = object2.mMovie:__wf_atom_5e6e15c8(object2.mClipName .. ".Border.Left", 14) - 8
		local v3 = object2.mWidth - v2 * 2
		local v4 = math.max(1, v3 / 32)
		object2.mMovie:OverrideMaterial(
			object2.mClipName .. ".Border.Middle",
			module.Ternary(
				object2.mType == object2.TYPE.SEARCH,
				_G.UIMaterial_UnfocusedTabBorder,
				_G.UIMaterial_InputFieldMiddlePart
			)
		)
		object2.mMovie:OverrideMaterial(
			object2.mClipName .. ".BorderHighlight.Middle",
			module.Ternary(
				object2.mType == object2.TYPE.SEARCH,
				_G.UIMaterial_FocusedTabBorder,
				_G.UIMaterial_InputFieldMiddlePartHighlight
			)
		)
		object2.mMovie:__wf_atom_1ca72041(object2.mClipName .. ".Border.Middle", "TileRepeats", v4, 1, 1, 1)
		object2.mMovie:__wf_atom_1ca72041(object2.mClipName .. ".BorderHighlight.Middle", "TileRepeats", v4, 1, 1, 1)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border", 0, object2.mWidth / 2)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border.Middle", 14, v3)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight", 0, object2.mWidth / 2)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight.Middle", 14, v3)

		if object2.mType == object2.TYPE.SEARCH then
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border", 1, object2.mHeight / 2 + 8)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight", 1, object2.mHeight / 2 + 8)
			object2.mMovie:__wf_atom_7f57ab2f(object2.mClipName, "Border.Left", 13, false)
			object2.mMovie:__wf_atom_7f57ab2f(object2.mClipName, "Border.Right", 13, false)
			object2.mMovie:__wf_atom_7f57ab2f(object2.mClipName, "BorderHighlight.Left", 13, false)
			object2.mMovie:__wf_atom_7f57ab2f(object2.mClipName, "BorderHighlight.Right", 13, false)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border.Middle", 14, object2.mWidth + 24)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border.Middle", 15, 48)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight.Middle", 14, object2.mWidth + 24)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight.Middle", 15, 48)
		else
			object2.mMovie:__wf_atom_c90af43a(object2.mClipName .. ".Border.Left", _G.UITexture_InputFieldBorderEndCap)
			object2.mMovie:__wf_atom_c90af43a(object2.mClipName .. ".Border.Right", _G.UITexture_InputFieldBorderEndCap)
			object2.mMovie:__wf_atom_c90af43a(
				object2.mClipName .. ".BorderHighlight.Left",
				_G.UITexture_InputFieldBorderEndCapHighlight
			)
			object2.mMovie:__wf_atom_c90af43a(
				object2.mClipName .. ".BorderHighlight.Right",
				_G.UITexture_InputFieldBorderEndCapHighlight
			)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border.Left", 0, -v3 / 2 + 1)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Border.Right", 0, v3 / 2 - 1)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight.Left", 0, -v3 / 2 + 1)
			object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "BorderHighlight.Right", 0, v3 / 2 - 1)
		end

		object2.mMovie:__wf_atom_4c1c1986(
			object2.mClipName,
			"Hint",
			0,
			module.Ternary(object2.mHintBuffer == nil, object2.mTextBuffer, object2.mHintBuffer) + 5
		)
		local rounded

		if object2.mVerticalCenterText then
			local __wf_atom_5e6e15c8 = object2.mMovie:__wf_atom_5e6e15c8(object2.mClipName .. ".Label", 41)
			local v5 = __wf_atom_5e6e15c8 == nil and 20 or __wf_atom_5e6e15c8 + 8
			rounded = module.Round((object2.mHeight - v5) / 2)
		else
			rounded = 5
		end

		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Hint", 1, rounded + object2.mLabelYOffset)
		object2.mMovie:__wf_atom_4c1c1986(object2.mClipName, "Label", 84, -3)
	end

	v.ButtonUpdateColors = v.UpdateColors

	function v:UpdateColors()
		self:ButtonUpdateColors()
		local mApplyThemes = self.mApplyThemes
		local color = module4.GetColor(9, true, mApplyThemes)
		local color2 = module4.GetColor(10, true, mApplyThemes)

		if self.mUnfocusedUnderlineColorOverride then
			local color3 = module4.GetColor(self.mUnfocusedUnderlineColorOverride, true, mApplyThemes)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Underline2", 11, color3)
		end

		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Underline", 12, 0)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Underline2", 12, 0)
		local ternary = module.Ternary(self.mAltFocused, color2, color)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnAlt", 11, ternary)
		local ternary2 = module.Ternary(self.mFocused, color2, color)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint", 11, ternary2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "ClearSearchLabel", 11, color)
		local v2 = { "BorderHighlight.Left", "BorderHighlight.Middle", "BorderHighlight.Right" }

		for i = 1, #v2 do
			__wf_atom_ec43d06e(
				self.mMovie,
				self.mClipName .. "." .. v2[i],
				2,
				{ 12 },
				{ module.Ternary(self.mFocused, 100, 0) },
				0.2,
				0
			)
		end

		self.mMovie:__wf_atom_e57658c2(self.mLabelClipName, 81, color2)
	end

	v.ButtonRedraw = v.Redraw

	function v:Redraw()
		self:ButtonRedraw()
		self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", self.mAltButtonIcon)
		self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".ClearSearchLabel.text", "/Lotus/Language/Menu/HoldToClear")
	end

	v.ButtonSetText = v.SetText

	function v:SetText(p9, p10)
		local mHint = p10 or self.mHint or ""
		self.mHint = mHint
		local __wf_atom_8e9ac384 = self.mMovie:__wf_atom_8e9ac384(mHint, true)

		if self.mToUpper then
			__wf_atom_8e9ac384 = string.upper(__wf_atom_8e9ac384)
		end

		self.mMovie:__wf_atom_50d60589(self.mClipName .. ".Hint", 36, __wf_atom_8e9ac384)
		self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Hint", 45, self.mAlignment)
		self:InputFieldTextChanged(p9, false)
	end

	function v:SetHint(p9)
		self:SetText(self.mLabel, p9)
	end

	function v:SetType(mType, p9, p10, p11)
		self.mType = mType

		if mType == self.TYPE.SEARCH then
			self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Hint", 49, "Spectral SC")
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint", 50, 23)
			self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 49, "Spectral SC")
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 50, 23)
		end

		self.mMovie:__wf_atom_2dedec1a(self.mLabelClipName, 68, mType == self.TYPE.PASSWORD)
		self.mOskTitle = p9 or self.mOskTitle
		self.mOskHint = p10 or self.mOskHint
		self.mOskCallback = p11 or self.mOskCallback
	end

	function v:SetMultiline(p9, p10)
		local mMultiline = p9 ~= false
		self.mMultiline = mMultiline
		self.mVerticalCenterText = not mMultiline
		self.mShowHighlight = self.mShowHighlight and not mMultiline

		if p10 ~= nil then
			self.mMovie:__wf_atom_e57658c2(self.mLabelClipName, 92, p10)
		end
	end

	function v.SetMaxChars(p9, p10)
		p9.mMovie:__wf_atom_e57658c2(p9.mLabelClipName, 39, p10)
	end

	function v:SetClearHintVisible(p9)
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ClearSearchLabel", 13, p9)
	end

	function v:SetLocked(p9, p10)
		local mLocked = p9 ~= false
		self.mLocked = mLocked

		if mLocked then
			self.mAltButtonIcon = _G.UITexture_Locked

			if p10 == nil or not p10 then
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnAlt", 14, self.mHeight - 8)
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnAlt", 15, self.mHeight - 8)
			end
		else
			_T.gToolTip = nil
		end

		self:OnGamepadTransition()
	end

	function v:AutoFocus()
		if not self.mSkipAutoFocus and module3.AutofocusTextfield(object) then
			self:TryPressed(true)
		end
	end

	object:__wf_atom_2dedec1a(v.mLabelClipName, 96, true)
	v.mHookedUpCallbacks = false
	v:HookUpCallbacks()
	v:SetTextAlignment("left")
	v:Redraw()
	v:AutoFocus()
	return v
end