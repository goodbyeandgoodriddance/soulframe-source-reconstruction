module(..., package.seeall)
local module = require("SF.Interface.Components.Button")
VARIANTS = module.VARIANTS

function Create(p, value, options)
	local module2 = require("EE.Interface.Utilities")
	local module3 = require("SF.Interface.Libs.UIUtilities")
	local module4 = require("Lotus.Interface.LotusUtilities")
	local mMovie = p.mMovie
	local v = options or {}
	local v2 = module.Create(mMovie, value, v.mLabel or "", v.mCallback, v.mCallout, p)
	v2.mHintClipName = value .. ".TextHolder.Label"
	v2.mInputClipName = value .. ".InputHolder.Label"
	v2.mLocked = false
	v2.mAltFocused = false
	v2.mHint = ""
	v2.TYPE = {
		PLAIN = 1,
		EMAIL = 2,
		PASSWORD = 3,
		CHAT = 4,
		SEARCH = 5
	}
	v2.mType = v2.TYPE.PLAIN
	v2.mOskTitle = ""
	v2.mOskHint = ""
	v2.mOskCallback = ""
	v2.mClearTime = 0.5
	v2.mSkipAutoFocus = v.mSkipAutoFocus
	v2.Button_HookUpCallbacks = v2.HookUpCallbacks

	function v2:HookUpCallbacks()
		self:Button_HookUpCallbacks()
		local v3 = string.gsub(value, "%.", "")

		p[v3 .. "Focused"] = function(p2)
			if self:InvalidId(p2) then
				return
			end

			self:InputFieldFocused(true)
		end

		p[v3 .. "Unfocused"] = function(p2)
			if self:InvalidId(p2) then
				return
			end

			self:InputFieldFocused(false)
		end

		p[v3 .. "CharacterLimit"] = function(p2)
			if self:InvalidId(p2) then
				return
			end

			module2.PlaySound(_G.UISound_Error)
		end

		p[v3 .. "TextInput"] = function(p2)
			if self:InvalidId(p2) then
				return
			end

			self:InputFieldTextChanged(mMovie:__wf_atom_387f260e(self.mInputClipName, 36), false)
		end

		p[v3 .. "OverAlt"] = function(p2)
			self:SetAltFocus(true, (tonumber(p2)))
		end

		p[v3 .. "OutAlt"] = function(p2)
			self:SetAltFocus(false, (tonumber(p2)))
		end

		p[v3 .. "PressAlt"] = function(p2)
			self:AltPressed(true, (tonumber(p2)))
		end

		p[v3 .. "ReleaseAlt"] = function(p2)
			self:AltPressed(false, (tonumber(p2)))
		end

		if mMovie:__wf_atom_253d7085(value .. ".Callout") then
			mMovie:SetCallbacks(
				value .. ".Callout",
				v3 .. "OverAlt",
				v3 .. "OutAlt",
				v3 .. "ReleaseAlt",
				v3 .. "PressAlt"
			)
		end

		mMovie:SetFocusedCallbacks(
			self.mInputClipName,
			v3 .. "Focused",
			v3 .. "Unfocused",
			v3 .. "CharacterLimit",
			v3 .. "TextInput"
		)
		self.mOskCallback = v3 .. "OskCallback"

		p[v3 .. "OskCallback"] = function(p2, p3)
			if p2 then
				print("cancelled by user")
			else
				self:InputFieldTextChanged(p3, true)
			end
		end
	end

	v2.ButtonSetId = v2.SetId

	function v2.SetId(object, p2)
		object:ButtonSetId(p2)

		if object.mId ~= nil then
			mMovie:__wf_atom_e57658c2(value .. ".Callout", 100, object.mId)
			mMovie:__wf_atom_e57658c2(object.mInputClipName, 100, object.mId)
		end
	end

	function v2.SetNumbersOnly(p2)
		mMovie:__wf_atom_50d60589(p2.mInputClipName, 38, "0123456789")
	end

	v2.ButtonSetActive = v2.SetActive

	function v2:SetActive(p2)
		self:ButtonSetActive(p2)

		if self.mQueuePressed and p2 then
			self:Pressed(true)
			self.mQueuePressed = false
		end
	end

	function v2:SetAltFocus(mAltFocused)
		if self.mAltFocused == mAltFocused then
			return
		end

		if mAltFocused then
			if self.mLocked then
				_T.gToolTip = Localize("/SF/Language/Menu/Unlock", nil)
			else
				_T.gToolTip = Localize("/SF/Language/Menu/Clear", nil)
			end
		else
			_T.gToolTip = nil
		end

		self.mAltFocused = mAltFocused
		self:UpdateColors()
	end

	function v2:AltPressed(p2)
		if p2 then
			if self.mLocked then
				self:SetLocked(false)
			end

			self:SetText("")
			self:Pressed(true)
		end
	end

	function v2:InputFieldFocused(mSelected)
		if self.mIsVisible and self.mActive then
			if self.mLocked then
				return
			end

			self.mSelected = mSelected
			self:SetFocus(mSelected)
		else
			mMovie:__wf_atom_2004c47f()
			self:SetFocus(false)
			self.mSelected = false
		end
	end

	function v2:InputFieldTextChanged(value2, _)
		local mLabel = value2 or ""

		if self.mLabel ~= mLabel then
			self:PlaySound(_G.UISound_SearchType)
		end

		self.mLabel = mLabel
		mMovie:__wf_atom_50d60589(self.mInputClipName, 36, mLabel)
		local mHintVisible = mLabel == ""

		if self.mHintVisible ~= mHintVisible then
			self.mHintVisible = mHintVisible
			mMovie:__wf_atom_2dedec1a(self.mHintClipName, 13, mHintVisible)
			self:UpdateTextIcon()
		end
	end

	v2.ButtonSetText = v2.SetText

	function v2:SetText(p2, p3)
		self.mHint = p3 or self.mHint or ""
		self:ButtonSetText(self.mHint)
		self:InputFieldTextChanged(p2, false)
	end

	function v2:SetHint(p2)
		self.mHintVisible = nil
		self:SetText(self.mLabel, p2)
	end

	v2.ButtonSetFocus = v2.SetFocus

	function v2:SetFocus(p2)
		if self.mLocked then
			return
		end

		if p2 or not self.mSelected then
			self:ButtonSetFocus(p2)
		end
	end

	v2.ButtonTryPressed = v2.TryPressed

	function v2:TryPressed(p2, p3)
		if self.mLocked then
			if p2 then
				self:PlaySound(_G.UISound_Error)
				local convertHEX2RGB255 = module2.ConvertHEX2RGB255(_G.UIColor_Beige)
				local convertHEX2RGB255_2 = module2.ConvertHEX2RGB255(_G.UIColor_Negative)
				module3.PulseColor(
					mMovie,
					value .. ".Callout.Prompt",
					2,
					nil,
					convertHEX2RGB255,
					convertHEX2RGB255_2,
					function()
						self:UpdateColors()
					end
				)
			end
		else
			self:ButtonTryPressed(p2, p3)
		end
	end

	v2.ButtonPressed = v2.Pressed

	function v2:Pressed(p2, p3)
		if self.mLocked then
			return
		end

		if p3 and p2 then
			self.mHoldTime = __wf_atom_c4e218a2()
		elseif p2 or p3 then
			if
				not self.mSelected
				and self.mActive
				and not (Engine.IsPlayingWithController() and Engine.IsOSKAvailable())
			then
				mMovie:__wf_atom_46a6af3b(self.mInputClipName)
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

				mMovie:__wf_atom_2449ced2()
			end

			self.mHoldTime = nil
		end

		self:ButtonPressed(p2, p3)
	end

	v2.ButtonSetVisible = v2.SetVisible

	function v2.SetVisible(object, p2)
		object:ButtonSetVisible(p2)

		if not p2 and object.mSelected then
			mMovie:__wf_atom_2004c47f()
		end
	end

	v2.ButtonOnGamepadTransition = v2.OnGamepadTransition

	function v2.OnGamepadTransition(object)
		object:ButtonOnGamepadTransition()

		if Engine.IsPlayingWithController() then
			mMovie:__wf_atom_2004c47f()
		end
	end

	v2.ButtonResize = v2.Resize

	function v2:Resize()
		self:ButtonResize()
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 84, -3)
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 83, 3)
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 0, mMovie:__wf_atom_5e6e15c8(self.mHintClipName, 0))
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 1, mMovie:__wf_atom_5e6e15c8(self.mHintClipName, 1))
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 14, mMovie:__wf_atom_5e6e15c8(self.mHintClipName, 14))
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 15, mMovie:__wf_atom_5e6e15c8(self.mHintClipName, 15))
		mMovie:__wf_atom_4c1c1986(value, "InputHolder", 0, mMovie:__wf_atom_cfc41e35(value, "TextHolder", 0))
		mMovie:__wf_atom_4c1c1986(value, "InputHolder", 1, mMovie:__wf_atom_cfc41e35(value, "TextHolder", 1))
		mMovie:__wf_atom_4c1c1986(value, "InputHolder", 14, mMovie:__wf_atom_cfc41e35(value, "TextHolder", 14))
		mMovie:__wf_atom_4c1c1986(value, "InputHolder", 15, mMovie:__wf_atom_cfc41e35(value, "TextHolder", 15))
	end

	v2.ButtonUpdateColors = v2.UpdateColors

	function v2:UpdateColors()
		self:ButtonUpdateColors()
		mMovie:__wf_atom_e57658c2(self.mInputClipName, 44, mMovie:__wf_atom_5e6e15c8(self.mHintClipName, 44))
		local v3

		if self.mAltFocused then
			v3 = _G.UIColor_Yellow
		else
			v3 = _G.UIColor_Beige
		end

		mMovie:__wf_atom_4c1c1986(value, "Callout.Prompt", 44, v3)
	end

	v2.ButtonRedraw = v2.Redraw

	function v2:Redraw()
		self:ButtonRedraw()
	end

	function v2:SetType(mType, p2, p3, p4)
		self.mType = mType
		mMovie:__wf_atom_2dedec1a(self.mInputClipName, 68, mType == self.TYPE.PASSWORD)
		self.mOskTitle = p2 or self.mOskTitle
		self.mOskHint = p3 or self.mOskHint
		self.mOskCallback = p4 or self.mOskCallback
		self:UpdateTextIcon()
	end

	function v2:SetMultiline(p2, p3)
		local mMultiline = p2 ~= false
		self.mMultiline = mMultiline
		self.mVerticalCenterText = not mMultiline

		if p3 ~= nil then
			mMovie:__wf_atom_e57658c2(self.mInputClipName, 92, p3)
		end

		mMovie:__wf_atom_2dedec1a(self.mInputClipName, 52, self.mMultiline == true)
	end

	function v2:SetHeight(mHeight)
		self.mHeight = mHeight
		self:Resize()
	end

	function v2:SetHeightLines(p2)
		self:SetHeight(p2 * (mMovie:__wf_atom_5e6e15c8(self.mInputClipName, 50) + 9))
	end

	function v2.SetMaxChars(p2, p3)
		mMovie:__wf_atom_e57658c2(p2.mInputClipName, 39, p3)
	end

	v2.ButtonSetTextAlignment = v2.SetTextAlignment

	function v2:SetTextAlignment(p2)
		self:ButtonSetTextAlignment(p2)
		mMovie:__wf_atom_50d60589(self.mInputClipName, 45, p2)
	end

	function v2:SetLocked(p2)
		self.mLocked = p2 ~= false
		self:UpdateTextIcon()
	end

	function v2:UpdateTextIcon()
		local v3 = true

		if self.mLocked then
			self:SetTextIcon("<LOCKED>")
		elseif #self.mLabel > 0 then
			self:SetTextIcon("<CLEAR>")
		elseif self.mType == self.TYPE.SEARCH then
			self:SetTextIcon("<SEARCH>")
		else
			v3 = false
		end

		mMovie:__wf_atom_7f57ab2f(value, "Callout.Prompt", 13, v3)
		mMovie:__wf_atom_46a6af3b(self.mInputClipName)
		_T.gToolTip = nil
	end

	function v2:AutoFocus()
		if not self.mSkipAutoFocus and module4.AutofocusTextfield(mMovie) then
			self:TryPressed(true)
		end
	end

	__wf_atom_86cbd68d(mMovie, value .. ".TextHolder.duplicateMovieClip", "InputHolder", 1000)
	__wf_atom_86cbd68d(mMovie, value .. ".Btn.swapDepths", 1001)
	__wf_atom_86cbd68d(mMovie, value .. ".Callout.swapDepths", 1002)
	mMovie:__wf_atom_50d60589(v2.mInputClipName, 57, "input")
	mMovie:__wf_atom_50d60589(v2.mInputClipName, 49, "Spectral Regular")
	mMovie:__wf_atom_2dedec1a(v2.mInputClipName, 96, true)
	mMovie:__wf_atom_e57658c2(v2.mInputClipName, 81, _G.UIColor_Yellow)
	v2.mHookedUpCallbacks = false
	v2:HookUpCallbacks()
	v2:SetVariant(v.mVariant or VARIANTS.DOTTED)
	v2:SetTextAlignment("left")
	v2:Redraw()
	v2:AutoFocus()
	return v2
end