module(..., package.seeall)
local module = require("Lotus.Interface.UIStyleUtilities")

function CreateDropDownMenu(object, mContainerClipName, p, p2)
	if p2 == nil then
		local _uiMaterial_RectangleNoDepth = _G.UIMaterial_RectangleNoDepth
	end

	local module2 = require("EE.Interface.Components.List")
	local list = module2.CreateList(object, mContainerClipName .. ".Item")
	list.mVisible = false
	list.mArrowFocused = false
	list.mForcedVerticalSeparation = 24
	list.mForcedHorizontalSeparation = 0
	list.mTransitionInDeltaY = 0
	list.mTransitionOutDeltaY = 0
	list.mDirection = 1
	list.mWidth = 370
	list.mIsOldStyle = p == true
	list.mUnfocusedRectInnerColor = _G.UIColorObject_White
	list.mUnfocusedRectInnerAlpha = 0.4
	list.mSelectCallout = "MENU_GENERIC2"
	list.mHideSelectCallout = false
	list.mContainerClipName = mContainerClipName
	list.mApplyThemes = true
	list.mEnvCallbackSet = false
	list._DropDownMenu_CalculateX = list.CalculateX

	function list.CalculateX(object2, p3)
		return (object2:_DropDownMenu_CalculateX(p3))
	end

	list._DropDownMenu_CalculateY = list.CalculateY

	function list.CalculateY(object2, p3)
		local elementIndexById = object2:GetElementIndexById(p3.Id)

		if __wf_atom_7e8ad928(elementIndexById) then
			return object2.mInitialY
		end

		if not __wf_atom_7e8ad928(object2.mScroll) then
			elementIndexById = elementIndexById - object2.mScroll + 1
		end

		local v

		if __wf_atom_7e8ad928(object2.mForcedVerticalSeparation) then
			v = object2.mMovie:__wf_atom_5e6e15c8(object2.mClipName, 15)
		else
			v = object2.mForcedVerticalSeparation
		end

		return object2.mInitialY + v * (elementIndexById - object2.mDirection) * object2.mDirection
	end

	function list:UpdateColors()
		local mMovie = self.mMovie
		local mContainerClipName2 = self.mContainerClipName
		local mApplyThemes = self.mApplyThemes
		local color = module.GetColor(2, true, mApplyThemes)
		local color2 = module.GetColor(0, true, mApplyThemes)
		local color3 = module.GetColor(1, true, mApplyThemes)
		local color4 = module.GetColor(9, true, mApplyThemes)

		if self.mArrowFocused then
			color4 = module.GetColor(7, true, mApplyThemes)
		end

		mMovie:__wf_atom_7f57ab2f(mContainerClipName2, "BgHover", 13, self.mArrowFocused)
		mMovie:__wf_atom_4c1c1986(mContainerClipName2, "Selected", 44, color4)
		mMovie:__wf_atom_4c1c1986(mContainerClipName2, "Arrow", 11, color4)
		mMovie:__wf_atom_4c1c1986(mContainerClipName2, "Selected", 91, 0)
		mMovie:__wf_atom_7f57ab2f(mContainerClipName2, "Callout.Tf", 89, true)
		mMovie:__wf_atom_4c1c1986(mContainerClipName2, "Callout.Tf", 11, color4)
		mMovie:__wf_atom_4c1c1986(mContainerClipName2, "Bg", 12, 100)
		local convertColorNumberToProceduralRGB = self.UTIL.ConvertColorNumberToProceduralRGB(color)
		local convertColorNumberToProceduralRGB2 = self.UTIL.ConvertColorNumberToProceduralRGB(color2)
		mMovie:__wf_atom_1ca72041(
			mContainerClipName2 .. ".Bg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.035
		)
		mMovie:__wf_atom_1ca72041(
			mContainerClipName2 .. ".Bg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			not mApplyThemes and 0.95 or self.UTIL.Ternary(self.mVisible, 0.85, 0.45) or 0.95
		)
		local convertColorNumberToProceduralRGB3 = self.UTIL.ConvertColorNumberToProceduralRGB(color3)
		mMovie:__wf_atom_1ca72041(
			mContainerClipName2 .. ".BgHover",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			mContainerClipName2 .. ".BgHover",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			1
		)
		local focusedElement = self:GetFocusedElement()
		self:RunForAllElements(function(p3)
			self:UpdateElementColor(p3, not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == p3.Id)
		end)
	end

	function list:UpdateElementColor(p3, p4)
		local mMovie = self.mMovie
		local mClipName = p3.mClipName
		local mApplyThemes = self.mApplyThemes
		local color = module.GetColor(0, true, mApplyThemes)
		local color2 = module.GetColor(1, true, mApplyThemes)
		local color3 = module.GetColor(9, true, mApplyThemes)

		if p4 then
			color3 = module.GetColor(7, true, mApplyThemes)
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 91, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "Label", 44, color3)
		mMovie:__wf_atom_4c1c1986(mClipName, "Check", 11, color3)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Bg", 13, p4)
		local convertColorNumberToProceduralRGB = self.UTIL.ConvertColorNumberToProceduralRGB(color2)
		local convertColorNumberToProceduralRGB2 = self.UTIL.ConvertColorNumberToProceduralRGB(color)
		mMovie:__wf_atom_1ca72041(
			mClipName .. ".Bg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			mClipName .. ".Bg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)
	end

	function list:IsVisible()
		return self.mVisible
	end

	function list:SetVisible(mVisible, p3)
		self.mVisible = mVisible

		if not mVisible then
			self.mMovie:__wf_atom_aec7f157()
		end

		self:RunForAllElements(function(p4)
			if not (__wf_atom_7e8ad928(p4) or __wf_atom_7e8ad928(p4.mClipName)) then
				self.mMovie:__wf_atom_2dedec1a(p4.mClipName, 13, mVisible)
			end
		end)
		local ternary = self.UTIL.Ternary(mVisible, self.OnExpandCallback, self.OnCollapseCallback)

		if not __wf_atom_7e8ad928(ternary) then
			ternary(self, p3)
		end

		local total = 32
		self:UpdateColors()

		if self.mVisible then
			total += self:GetHowManyElements() * self.mForcedVerticalSeparation
		end

		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "Bg", 15, total)
		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "Arrow", 16, self.UTIL.Ternary(self.mVisible, 0, 180))
		self.mMovie:__wf_atom_c0d7a318(self.mContainerClipName, "Bg", "noMenuSelection", mVisible)
	end

	function list:ArrowPressed(p3)
		if self.mVisible == true then
			self.UTIL.PlaySound(_G.UISound_Select)
			self.UTIL.PlaySound(_G.UISound_ItemTipSection)
		else
			self.UTIL.PlaySound(_G.UISound_ButtonSelect)
		end

		self:SetVisible(not self.mVisible, p3)
	end

	function list:ArrowFocused()
		self.UTIL.PlaySound(_G.UISound_Focus)
		self.mArrowFocused = true
		self:UpdateColors()
	end

	function list:ArrowUnfocused()
		self.mArrowFocused = false
		self:UpdateColors()
	end

	list._DropDownMenu_OnFocused = list.OnFocused

	function list:OnFocused(p3)
		if self:IsVisible() then
			self.UTIL.PlaySound(_G.UISound_Focus)
		end

		self:UpdateElementColor(p3, true)
		self:_DropDownMenu_OnFocused(p3)
	end

	list._DropDownMenu_OnUnfocused = list.OnUnfocused

	function list:OnUnfocused(p3)
		self:UpdateElementColor(p3, false)
		self:_DropDownMenu_OnUnfocused(p3)
	end

	list._DropDownMenu_OnSelected = list.OnSelected

	function list:OnSelected(p3, p4)
		if not __wf_atom_7e8ad928(self.mSelectedElement) then
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "Check", 13, false)

			if self:IsVisible() then
				self.UTIL.PlaySound(_G.UISound_Select)
				self.UTIL.PlaySound(_G.UISound_WindowOpen)
			end
		end

		self:_DropDownMenu_OnSelected(p3, p4)

		if not __wf_atom_7e8ad928(self.mSelectedElement) then
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "Check", 13, true)
			self:UpdateSelectedText()
		end

		self:SetVisible(false)
	end

	function list:UpdateSelectedText(_, _)
		if self.mSelectedElement == nil then
			return
		end

		local name = self.mSelectedElement.Name

		if self.mSelectedPrefix ~= nil then
			name = self.mMovie:__wf_atom_8e9ac384(self.mSelectedPrefix, true, { SELECTION = name })
		end

		self.mMovie:__wf_atom_50d60589(self.mContainerClipName .. ".Selected", 36, name)
	end

	list._DropDownMenu_OnDraw = list.OnDraw

	function list:OnDraw(p3, p4)
		self.mMovie:__wf_atom_2dedec1a(p3.mClipName, 13, self.mVisible)
		local focusedElement = self:GetFocusedElement()
		self:UpdateElementColor(p3, not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == p3.Id)
		self.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Btn", 14, self.mWidth)
		self.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Bg", 14, self.mWidth)
		self.mMovie:OverrideMaterial(p3.mClipName .. ".Bg", _G.UIMaterial_Button)
		self:_DropDownMenu_OnDraw(p3, p4)
		local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(p3.mClipName .. ".Label", 0)
		local __wf_atom_cfc41e35 = self.mMovie:__wf_atom_cfc41e35(p3.mClipName, "Label", 40)
		self.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Check", 0, __wf_atom_5e6e15c8 + __wf_atom_cfc41e35 + 10)
	end

	function list:IconCacheFlushed()
		self:UpdateSelectedText()
	end

	function list:SetWidth(mWidth)
		self.mWidth = mWidth
		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "Bg", 14, self.mWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "BgHover", 14, self.mWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "Arrow", 0, self.mWidth - 17)
		self.mMovie:__wf_atom_4c1c1986(self.mContainerClipName, "Callout", 0, self.mWidth - 17)
		self:Redraw(nil, true, true)
	end

	function list:onKeyUp_MENU_CLICK()
		if not self:IsVisible() then
			return
		end

		local rootBasedPosition, v = self.UTIL.GetRootBasedPosition(self.mMovie, self.mContainerClipName .. ".Bg")
		local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(self.mContainerClipName .. ".Bg", 15)
		local __wf_atom_5e6e15c8_2 = self.mMovie:__wf_atom_5e6e15c8("_root", 30)
		local __wf_atom_5e6e15c8_3 = self.mMovie:__wf_atom_5e6e15c8("_root", 31)
		local v2, v3

		if Engine.__wf_atom_b6edc589() then
			v2 = self.mMovie:__wf_atom_5e6e15c8(self.mContainerClipName, 5) / 100
			v3 = self.mMovie:__wf_atom_5e6e15c8(self.mContainerClipName, 6) / 100
		else
			v2 = 1
			v3 = 1
		end

		if
			__wf_atom_5e6e15c8_2 < rootBasedPosition
			or rootBasedPosition + self.mWidth * v2 < __wf_atom_5e6e15c8_2
			or __wf_atom_5e6e15c8_3 < v
			or v + __wf_atom_5e6e15c8 * v3 < __wf_atom_5e6e15c8_3
		then
			self:SetVisible(false)
		end
	end

	function list:HookupCallbacks()
		local v = 1
		local v2

		repeat
			v2 = getfenv(v)
			v += 1
		until v2.mMovie

		if v2.onKeyUp_MENU_CLICK == nil then
			function v2.onKeyUp_MENU_CLICK()
				self:onKeyUp_MENU_CLICK()
			end
		end

		local v3 = "onKeyDown_" .. self.mSelectCallout
		local v4

		if v2[v3] == nil then
			v2[v3] = function()
				if v2.mMovie:__wf_atom_a91463a8(self.mContainerClipName, 13) then
					self:ArrowPressed(true)
				end
			end

			self.mEnvCallbackSet = true
		end

		v4 = "OnGamepadTransition"

		while v2["Prev_" .. v4] ~= nil do
			v4 = "Prev_" .. v4
		end

		v2["Prev_" .. v4] = v2.OnGamepadTransition
		local v5 = v2["Prev_" .. v4] ~= nil

		function v2.OnGamepadTransition(p3)
			if v5 then
				v2["Prev_" .. v4](p3)
			end

			self:OnGamepadTransition(p3 == "true")
		end
	end

	function list:SetSelectCallout(mSelectCallout)
		if self.mEnvCallbackSet then
			local v = 1
			local v2

			repeat
				v2 = getfenv(v)
				v += 1
			until v2.mMovie

			v2["onKeyDown_" .. self.mSelectCallout] = nil
		end

		self.mSelectCallout = mSelectCallout
		self.mEnvCallbackSet = false
		self:HookupCallbacks()
	end

	function list:OnGamepadTransition(p3)
		if
			not __wf_atom_7e8ad928(self.mContainerClipName)
			and self.mMovie:__wf_atom_253d7085(self.mContainerClipName)
		then
			self:UpdateSelectedText(nil, not p3)
			self:Redraw(nil, true, true)
			local v = not p3

			if v then
				if self.mSelectCallout == nil then
					v = false
				else
					v = self.mSelectCallout ~= ""
				end
			end

			if v then
				self.mMovie:__wf_atom_7d7314f1(
					self.mContainerClipName .. ".Callout.Tf.text",
					"<" .. self.mSelectCallout .. ">"
				)
			end

			self.mMovie:__wf_atom_7f57ab2f(self.mContainerClipName, "Callout", 13, v)
			self.mMovie:__wf_atom_7f57ab2f(self.mContainerClipName, "Arrow", 13, not v)
		end
	end

	object:SetCallbacks(
		mContainerClipName .. ".Bg",
		"DropDownArrowFocused",
		"DropDownArrowUnfocused",
		"DropDownArrowPressed",
		nil
	)
	local isPlayingWithController = Engine.IsPlayingWithController()

	if isPlayingWithController then
		if list.mSelectCallout == nil then
			isPlayingWithController = false
		else
			isPlayingWithController = list.mSelectCallout ~= ""
		end
	end

	if isPlayingWithController then
		object:__wf_atom_7d7314f1(mContainerClipName .. ".Callout.Tf.text", "<" .. list.mSelectCallout .. ">")
	end

	object:__wf_atom_7f57ab2f(mContainerClipName, "Callout", 13, isPlayingWithController)
	object:__wf_atom_7f57ab2f(mContainerClipName, "Arrow", 13, not isPlayingWithController)
	object:OverrideMaterial(mContainerClipName .. ".Bg", _G.UIMaterial_Button)
	object:OverrideMaterial(mContainerClipName .. ".BgHover", _G.UIMaterial_Button)
	list:UpdateColors()
	object:__wf_atom_7f57ab2f(mContainerClipName, "Outline", 13, false)
	object:__wf_atom_7f57ab2f(mContainerClipName, "SelectedBg", 13, false)
	list:HookupCallbacks()
	return list
end