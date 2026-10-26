module(..., package.seeall)

function Create(object, mRootClipName, value, p, p2, p3, p4, p5)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local module3 = require("Lotus.Interface.Components.ThemedButton")
	local module4 = require("EE.Interface.Components.List")
	local v = p2 == nil and "<MENU_GENERIC2>" or p2
	local list = module4.CreateList(object, mRootClipName .. ".Buttons.Button")
	list.mRootClipName = mRootClipName
	list.mHitboxClipName = mRootClipName .. ".Backer"
	list.mApplyThemes = true
	list.mExpanded = false
	list.mForcedVerticalSeparation = 30
	list.mWidth = 370
	list.mSelectedElement = nil
	list.mCustomizeButtonCallback = nil
	list.mSelectedIconOnly = true
	local mMainButton = module3.Create(object, mRootClipName .. ".MainButton", value or "----", p, v, p3, p4, p5)
	mMainButton.mTextBuffer = 5
	mMainButton.mPrefixCallout = false
	mMainButton.mFlipExpandedIcon = true
	mMainButton.ButtonSetFocus = mMainButton.SetFocus

	function mMainButton.SetFocus(_, p6)
		mMainButton:ButtonSetFocus(p6)
	end

	mMainButton.ButtonPressed = mMainButton.Pressed

	function mMainButton.Pressed(_, p6, p7)
		mMainButton:ButtonPressed(p6, p7)

		if p6 then
			list:SetExpanded(not list:IsExpanded(), p7)
		end
	end

	function mMainButton.SetValue(_, p6)
		list:SelectElementById(p6)
	end

	mMainButton:SetTextAlignment("left")
	mMainButton:SetWidth(list.mWidth)
	mMainButton:Redraw()
	list.mMainButton = mMainButton

	function list:SetWidth(mWidth)
		self.mWidth = mWidth
		self.mMainButton:SetWidth(mWidth)
		self:RunForAllElements(function(p6)
			if not (__wf_atom_7e8ad928(p6) or __wf_atom_7e8ad928(p6.mButton)) then
				p6.mButton:SetWidth(mWidth)
			end
		end)
	end

	function list:UpdateColors()
		local color = module2.GetColor(2, true, self.mApplyThemes)
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color)
		self.mMovie:__wf_atom_1ca72041(
			self.mHitboxClipName,
			"RectEdgeColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.8
		)
		self.mMovie:__wf_atom_1ca72041(
			self.mHitboxClipName,
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.8
		)
		self.mMainButton:UpdateColors()
		self:RunForAllElements(function(p6)
			if not (__wf_atom_7e8ad928(p6) or __wf_atom_7e8ad928(p6.mButton)) then
				p6.mButton:UpdateColors()
			end
		end)
	end

	function list:SetVisible(p6)
		self.mMainButton:SetVisible(p6)
	end

	function list:IsExpanded()
		return self.mExpanded
	end

	function list:SetExpanded(mExpanded, p6)
		self.mExpanded = mExpanded
		local ternary = self.UTIL.Ternary(mExpanded, self.OnExpandCallback, self.OnCollapseCallback)

		if not __wf_atom_7e8ad928(ternary) then
			ternary(self, p6)
		end

		if mExpanded then
			self.mMovie:__wf_atom_e57658c2(self.mHitboxClipName, 14, self.mWidth)
			self.mMovie:__wf_atom_e57658c2(self.mHitboxClipName, 15, self.mForcedVerticalSeparation * #self.mElements)
		else
			self.mMovie:__wf_atom_aec7f157()
		end

		self.mMovie:__wf_atom_4c1c1986(
			self.mRootClipName,
			"MainButton.Icon",
			16,
			self.UTIL.Ternary(self.mMainButton.mFlipExpandedIcon and not mExpanded, 180, 0)
		)
		self.mMovie:__wf_atom_7f57ab2f(self.mRootClipName, "Buttons", 13, mExpanded)
		self.mMovie:__wf_atom_2dedec1a(self.mHitboxClipName, 13, mExpanded)
		self:UpdateColors()
	end

	function list:UpdateSelectedText(p6)
		if p6 == nil then
			return
		end

		local mSelectedElement = self.mSelectedElement
		local name = p6.Name

		if self.mSelectedPrefix ~= nil then
			name = self.mMovie:__wf_atom_8e9ac384(self.mSelectedPrefix, true, { SELECTION = name })
		end

		if list.mSelectedIconOnly then
			if mSelectedElement ~= nil and mSelectedElement.mButton ~= nil then
				mSelectedElement.mButton:SetIconVisible(false)
			end

			if p6.mButton ~= nil then
				p6.mButton:SetIconVisible(true)
			end
		end

		self.mMainButton:SetText(name)
		self:SetExpanded(false)
		self:ButtonOnSelected(p6)
	end

	list.ButtonOnSelected = list.OnSelected
	list.OnSelected = list.UpdateSelectedText
	list.ListOnDraw = list.OnDraw

	function list.OnDraw(object2, state, p6)
		object2:ListOnDraw(state, p6)

		if __wf_atom_7e8ad928(state) or state.mClipName == nil then
			return
		end

		local mButton = module3.Create(object2.mMovie, state.mClipName, state.Name)
		mButton:SetId(state.Id)
		mButton.mTextBuffer = 5
		mButton.mUnderlineAlpha = 0
		mButton.ButtonSetFocus = mButton.SetFocus
		mButton.mIconDefaultWidth = 24.5
		mButton.mIconDefaultHeight = 24.5
		mButton.mIconSimWidth = 32

		function mButton.SetFocus(_, p7)
			mButton:ButtonSetFocus(p7)
		end

		mButton.ButtonPressed = mButton.Pressed

		function mButton.Pressed(_, p7)
			mButton:ButtonPressed(p7)

			if p7 then
				list:UpdateSelectedText(state)
			end
		end

		state.mButton = mButton

		if list.mCustomizeButtonCallback ~= nil then
			list.mCustomizeButtonCallback(state)
		end

		mButton:SetIconVisible(not list.mSelectedIconOnly or object2.mSelectedElement == state)
		mButton:SetTextAlignment("left")
		mButton:SetWidth(object2.mWidth)
		mButton:Redraw()
	end

	list.ListRedraw = list.Redraw

	function list:Redraw(p6, p7, p8)
		self:ListRedraw(p6, p7, p8)
		self:SetExpanded(self.mExpanded)
		self.mMainButton:Redraw()
	end

	function list:MouseOverClip(p6)
		local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(p6, 2)
		local __wf_atom_5e6e15c8_2 = self.mMovie:__wf_atom_5e6e15c8(p6, 3)
		local __wf_atom_5e6e15c8_3 = self.mMovie:__wf_atom_5e6e15c8(p6, 14)
		local __wf_atom_5e6e15c8_4 = self.mMovie:__wf_atom_5e6e15c8(p6, 15)
		local v2 = self.mMovie:__wf_atom_5e6e15c8("_root", 30) - __wf_atom_5e6e15c8
		local v3 = self.mMovie:__wf_atom_5e6e15c8("_root", 31) - __wf_atom_5e6e15c8_2
		return not (v2 < 0 or __wf_atom_5e6e15c8_3 < v2 or v3 < 0 or __wf_atom_5e6e15c8_4 < v3)
	end

	function list:OnMouseClick()
		if not self:IsExpanded() then
			return
		end

		if not (self:MouseOverClip(self.mHitboxClipName) or self:MouseOverClip(mRootClipName .. ".MainButton.Backer")) then
			self:SetExpanded(false)
		end
	end

	function list:HookupCallbacks()
		local v2 = 1
		local v3

		repeat
			v3 = getfenv(v2)
			v2 += 1
		until v3.mMovie

		if v3.onKeyUp_DROPDOWN_MENU_CLICK == nil then
			if v3.onKeyUp_MENU_CLICK == nil then
				function v3.onKeyUp_MENU_CLICK()
					self:OnMouseClick()
				end

				v3.onKeyUp_DROPDOWN_MENU_CLICK = v3.onKeyUp_MENU_CLICK
			else
				v3.onKeyUp_DROPDOWN_MENU_CLICK = v3.onKeyUp_MENU_CLICK

				function v3.onKeyUp_MENU_CLICK()
					self:OnMouseClick()

					if v3.onKeyUp_DROPDOWN_MENU_CLICK ~= nil then
						v3.onKeyUp_DROPDOWN_MENU_CLICK()
					end
				end
			end
		end
	end

	object:__wf_atom_4c1c1986(mRootClipName, "Buttons", 1, list.mForcedVerticalSeparation)
	object:__wf_atom_4c1c1986(mRootClipName, "Backer", 1, list.mForcedVerticalSeparation)
	object:OverrideMaterial(mRootClipName .. ".Backer", _G.UIMaterial_Button)
	list:SetExpanded(false)
	list:HookupCallbacks()
	return list
end