module(..., package.seeall)
local module = require("SF.Interface.Components.Button")
VARIANTS = module.VARIANTS

function Create(p, mRootClipName, options)
	local module2 = require("EE.Interface.Utilities")
	local module3 = require("EE.Interface.Components.List")
	local mMovie = p.mMovie
	local v = options or {}

	if v.mCallout == nil then
		v.mCallout = "<MENU_GENERIC2>"
	end

	if v.mFixedSelectionText ~= nil then
		v.mLabel = v.mFixedSelectionText
	end

	local list = module3.CreateList(mMovie, mRootClipName .. ".Buttons.Button")
	list.mRootClipName = mRootClipName
	list.mHitboxClipName = mRootClipName .. ".Buttons.Backer"
	list.mExpanded = false
	list.mElementHeight = v.mElementHeight or 30
	list.mForcedVerticalSeparation = v.mForcedVerticalSeparation or list.mElementHeight + 8
	list.mWidth = 370
	list.mSelectedElement = nil
	list.mCustomizeButtonCallback = nil
	list.mSelectedIconOnly = true
	list.mExpandUpwards = v.mExpandUpwards or false
	list.mKeepExpandedOnSelection = v.mKeepExpandedOnSelection or false
	list.mFixedSelectionText = v.mFixedSelectionText or nil
	local mMainButton = module.Create(
		mMovie,
		mRootClipName .. ".MainButton",
		v.mLabel or "----",
		v.mCallback,
		v.mCallout,
		p
	)

	if v.mMainButtonHeight ~= nil then
		mMainButton.mHeight = v.mMainButtonHeight
	end

	mMainButton.mPostText = "..."
	mMainButton.ButtonSetFocus = mMainButton.SetFocus

	function mMainButton.SetFocus(_, p2)
		mMainButton:ButtonSetFocus(p2)
	end

	mMainButton.ButtonPressed = mMainButton.Pressed

	function mMainButton.Pressed(_, p2, p3)
		mMainButton:ButtonPressed(p2, p3)

		if p2 then
			list:SetExpanded(not list:IsExpanded(), p3)
		end
	end

	function mMainButton.SetValue(_, p2)
		list:SelectElementById(p2)
	end

	function mMainButton:UpdateEnabledState()
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 67, self.mActive)
	end

	mMainButton.ButtonUpdateColors = mMainButton.UpdateColors

	function mMainButton:UpdateColors()
		if self.mVariant == VARIANTS.DOTTED then
			local mUnfocusedBorderColor

			if list:IsExpanded() then
				mUnfocusedBorderColor = _G.UIColor_BlueGreen
			else
				mUnfocusedBorderColor = _G.UIColor_Brown
			end

			self.mUnfocusedBorderColor = mUnfocusedBorderColor
		end

		mMainButton:ButtonUpdateColors()
	end

	mMainButton:SetTextAlignment("left")
	mMainButton:SetWidth(list.mWidth)
	mMainButton:UpdateEnabledState()
	local total = 0
	local v2 = list.mForcedVerticalSeparation - list.mElementHeight - 6
	mMovie:__wf_atom_c0d7a318(mRootClipName, "MainButton.Btn", "groupWeighting", 1)
	mMovie:__wf_atom_c0d7a318(mRootClipName, "MainButton.Btn", "groupWeightMultiplier", 10)
	list.List_CalculateY = list.CalculateY

	function list.CalculateY(object, p2)
		local v3 = object:List_CalculateY(p2) + v2

		if object.mExpandUpwards then
			return -v3
		end

		return v3
	end

	list.mMainButton = mMainButton

	function list:SetWidth(mWidth)
		self.mWidth = mWidth
		self.mMainButton:SetWidth(mWidth)
		self:RunForAllElements(function(p2)
			if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2.mButton)) then
				p2.mButton:SetWidth(mWidth)
			end
		end)
	end

	function list:SetButtonHeight(mHeight)
		mMainButton.mHeight = mHeight
		self:Redraw(nil, true, true)
	end

	function list:SetVisible(p2)
		self.mMainButton:SetVisible(p2)
	end

	function list:IsExpanded()
		return self.mExpanded
	end

	function list:SetExpanded(mExpanded, p2)
		self.mExpanded = mExpanded
		local ternary = self.UTIL.Ternary(mExpanded, self.OnExpandCallback, self.OnCollapseCallback)

		if not __wf_atom_7e8ad928(ternary) then
			ternary(self, p2)
		end

		if not mExpanded then
			mMovie:__wf_atom_aec7f157()
		end

		local mFocused = mMainButton.mFocused
		mMainButton:SetTextIcon(mMovie:__wf_atom_8e9ac384(mExpanded and "<DROPDOWN_CLOSE>" or "<DROPDOWN_OPEN>", true))

		if mFocused then
			mMainButton.mFocused = true
			mMainButton:Interpolate(true)
			mMainButton:UpdateColors()
		end

		mMovie:__wf_atom_7f57ab2f(self.mRootClipName, "Buttons", 13, mExpanded)
		mMovie:__wf_atom_2dedec1a(self.mHitboxClipName, 13, mExpanded)
	end

	function list:UpdateSelectedText(p2)
		if p2 == nil then
			return
		end

		local mSelectedElement = self.mSelectedElement
		local name = p2.Name

		if self.mSelectedPrefix ~= nil then
			name = mMovie:__wf_atom_8e9ac384(self.mSelectedPrefix, true, { SELECTION = name })
		end

		if list.mSelectedIconOnly then
			if mSelectedElement ~= nil and mSelectedElement.mButton ~= nil then
				mSelectedElement.mButton:SetIcon(nil)
			end

			if p2.mButton ~= nil then
				p2.mButton:SetIcon(nil)
			end
		end

		if self.mFixedSelectionText == nil then
			self.mMainButton:SetText(name)
		else
			self.mMainButton:SetText(mMovie:__wf_atom_8e9ac384(self.mFixedSelectionText, true))
		end

		if not self.mKeepExpandedOnSelection then
			self:SetExpanded(false)
		end

		self:ButtonOnSelected(p2)
	end

	list.ButtonOnSelected = list.OnSelected
	list.OnSelected = list.UpdateSelectedText
	list.ListOnDraw = list.OnDraw

	function list.OnDraw(object, state, p2)
		object:ListOnDraw(state, p2)

		if __wf_atom_7e8ad928(state) or state.mClipName == nil then
			return
		end

		mMovie:__wf_atom_c0d7a318(state.mClipName, "Btn", "groupWeighting", 1)
		mMovie:__wf_atom_c0d7a318(state.mClipName, "Btn", "groupWeightMultiplier", 10)
		local mButton = module.Create(mMovie, state.mClipName, state.Name)
		mButton:SetId(state.Id)
		mButton.mTextBuffer = 5
		mButton.mHeight = object.mElementHeight
		mButton.mPostText = "..."
		mButton.ButtonSetFocus = mButton.SetFocus
		mButton.mIconDefaultWidth = 24.5
		mButton.mIconDefaultHeight = 24.5
		mButton.mIconSimWidth = 32

		function mButton.SetFocus(_, p3)
			mButton:ButtonSetFocus(p3)
		end

		mButton.ButtonPressed = mButton.Pressed

		function mButton.Pressed(_, p3)
			mButton:ButtonPressed(p3)

			if p3 then
				list:UpdateSelectedText(state)
			end
		end

		mButton.ButtonResize = mButton.Resize

		function mButton.Resize(_)
			local mFocused = mButton.mFocused
			mButton:ButtonResize()

			if mFocused then
				mButton.mFocused = true
				mButton:Interpolate(true)
				mButton:UpdateColors()
			end
		end

		state.mButton = mButton

		if list.mCustomizeButtonCallback ~= nil then
			list.mCustomizeButtonCallback(state)
		end

		mButton:SetIcon(state.Icon)
		mButton:SetTextIcon(state.TextIcon)
		mButton:SetTextAlignment("left")
		mButton:SetWidth(object.mWidth - 20 - v2 * 2)
		mButton:SetPosition(10 + v2)
		mButton:SetVariant(VARIANTS.PAPER)
	end

	list.ListRedraw = list.Redraw

	function list:Redraw(p2, p3, p4)
		self:ListRedraw(p2, p3, p4)
		self:SetExpanded(self.mExpanded)
		self.mMainButton:Redraw()
		mMovie:__wf_atom_7f57ab2f(self.mRootClipName, "MainButton.Blurer", 13, false)

		if #self.mElements > 0 then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mElements[1].mClipName, 1)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(self.mElements[#self.mElements].mClipName, 1)

			if self.mExpandUpwards then
				__wf_atom_5e6e15c8_2, __wf_atom_5e6e15c8 = __wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2
			end

			local v3 = __wf_atom_5e6e15c8 - (total + v2 + 8)
			local v4 = __wf_atom_5e6e15c8_2 + (list.mElementHeight + total + v2 + 8)
			local mHitboxClipName = self.mHitboxClipName
			mMovie:__wf_atom_e57658c2(mHitboxClipName, 0, 4)
			mMovie:__wf_atom_e57658c2(mHitboxClipName, 1, v3 + 4)
			mMovie:__wf_atom_e57658c2(mHitboxClipName, 15, v4 - v3 - 8)
			mMovie:__wf_atom_e57658c2(mHitboxClipName, 14, self.mWidth - 8)
			mMovie:__wf_atom_e57658c2(mHitboxClipName, 11, _G.UIColor_DarkerBrown)
			mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons.Border", 0, 0)
			mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons.Border", 1, v3)
			mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons.Border", 15, v4 - v3)
			mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons.Border", 14, self.mWidth)
			mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons.Border", 11, _G.UIColor_MediumBrown)
			mMovie:OverrideMaterial(mRootClipName .. ".Buttons.Border", _G.UIMaterial_BackerBorderSingle)
			mMovie:__wf_atom_1ca72041(mRootClipName .. ".Buttons.Border", "VisibilitySize", 1, 1, 1, 1)
		end
	end

	function list:MouseOverClip(p2)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p2, 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p2, 3)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(p2, 14)
		local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(p2, 15)
		local v3 = mMovie:__wf_atom_5e6e15c8("_root", 30) - __wf_atom_5e6e15c8
		local v4 = mMovie:__wf_atom_5e6e15c8("_root", 31) - __wf_atom_5e6e15c8_2
		return not (v3 < 0 or __wf_atom_5e6e15c8_3 < v3 or v4 < 0 or __wf_atom_5e6e15c8_4 < v4)
	end

	function list:OnMouseClick()
		if not self:IsExpanded() then
			return
		end

		if not (self:MouseOverClip(self.mHitboxClipName) or self:MouseOverClip(mRootClipName .. ".MainButton.Btn")) then
			mMainButton:PlaySound(_G.UISound_Focus)
			self:SetExpanded(false)
		end
	end

	function list:HookUpCallbacks()
		module2.HookUpEnvironmentCallback(mRootClipName, p, "onKeyUp_MENU_CLICK", function()
			self:OnMouseClick()
		end)
		module2.HookUpEnvironmentCallback(mRootClipName, p, "onKeyUp_MENU_SELECT", function()
			self:OnMouseClick()
		end)
		module2.HookUpEnvironmentCallback(mRootClipName, p, "BUTTONBAR_MENU_CANCEL", function()
			if not self:IsExpanded() then
				return
			end

			mMainButton:PlaySound(_G.UISound_Focus)
			self:SetExpanded(false)
			return true
		end)
		mMovie:SetCallbacks(
			mRootClipName .. ".Buttons.Backer",
			"BackerNullCallback",
			"BackerNullCallback",
			"BackerNullCallback",
			"BackerNullCallback"
		)
		mMovie:__wf_atom_c0d7a318(mRootClipName, "Buttons.Backer", "noMenuSelection", true)
	end

	mMainButton:SetVariant(v.mVariant or VARIANTS.DOTTED)

	if mMainButton.mVariant == VARIANTS.DOTTED then
		total += 4
	end

	if list.mExpandUpwards then
		mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons", 1, -list.mElementHeight - total)
	else
		mMovie:__wf_atom_4c1c1986(mRootClipName, "Buttons", 1, mMainButton.mHeight + total)
	end

	list:SetExpanded(false)
	list:HookUpCallbacks()
	list:Redraw()
	return list
end