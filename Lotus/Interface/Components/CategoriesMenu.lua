module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")

function Create(p, p2, p3)
	local module3 = require("EE.Interface.Components.List")
	local list = module3.CreateList(p, p2)
	list.mPrefix = "CategoriesMenu(" .. p2 .. ")::"
	list.mWrapAroundNavigation = true
	list:SetCallbacks("CategoryPressed", "CategoryFocused", "CategoryUnfocused")
	list.mInitialDepth = 3000
	list.mDepthDirection = 1
	list.mElementTransitionTime = 0
	list.mForcedVerticalSeparation = 0
	list.mPlayAltSelectSound = false
	list.mCalloutSeparation = 50
	list.mSelectedBackerExtra = 100
	list.mIconOverZ = -350
	list.mUseOriginalDimensions = true
	list.mSmoothEdgeMaterial = _G.UIMaterial_SmoothEdgeNoDepthTest
	list.mQueueInstantReposition = false
	list.mApplyThemes = true
	list.mAlign = module.CENTER_ALIGNED

	function list:SetIsNewStyle(p4)
		self.mOldStyle = not p4
		list.mForcedHorizontalSeparation = module.Ternary(p4, 40, 55)
		list.mSelectedPreSeparation = module.Ternary(p4, 0, 30)
		list.mSelectedPostSeparation = module.Ternary(p4, 12, 50)
	end

	function list.SetupPreInterpolationValues(_, _) end

	list.GetInterpolationProperties = list.DefaultAlphaInterpolation

	function list.Print(_, _) end

	function list:InitializeRootClip()
		if self.mRootClip == nil then
			local stringFindLast = module.StringFindLast(self.mClipName, "%.")

			if stringFindLast == nil then
				self.mRootClip = "_root"
			else
				self.mRootClip = string.sub(self.mClipName, 1, stringFindLast - 1)
			end

			__wf_atom_86cbd68d(
				self.mMovie,
				self.mRootClip .. ".attachMovie",
				"TextPlaceHolder",
				"LeftBumper",
				self.mInitialDepth + -52
			)
			self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "LeftBumper", 1, self.mInitialY - 6)
			self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "LeftBumper", 12, 100)
			__wf_atom_86cbd68d(
				self.mMovie,
				self.mRootClip .. ".attachMovie",
				"TextPlaceHolder",
				"RightBumper",
				self.mInitialDepth + -51
			)
			self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "RightBumper", 1, self.mInitialY - 6)
			self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "RightBumper", 12, 100)
		end
	end

	function list:DrawCallouts()
		self:InitializeRootClip()
		self.mMovie:__wf_atom_7d7314f1(self.mRootClip .. ".LeftBumper.Tf.text", "<MENU_LTRIGGER2>")
		self.mMovie:__wf_atom_7d7314f1(self.mRootClip .. ".RightBumper.Tf.text", "<MENU_RTRIGGER2>")
		self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "LeftBumper", 13, false)
		self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "RightBumper", 13, false)
	end

	function list:UpdateElementFlares(p4, p5)
		if p4.mTopFlare ~= nil then
			p4.mTopFlare:SetEnabled(p5)
		end

		if p4.mBottomFlare ~= nil then
			p4.mBottomFlare:SetEnabled(p5)
		end
	end

	function list.mOnFocusedCallback(p4)
		if not list.mMuteFocusSound then
			module.PlaySound(_G.UISound_Focus)
		end

		if not (Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()) then
			_T.gToolTip = string.upper(p4.Name)
		end

		list:UpdateElementFlares(p4, true)
		list:UpdateColors(p4, true)
		list:SetIconZDepth(p4, true, false)
	end

	function list.mOnUnfocusedCallback(p4)
		if not (Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()) then
			_T.gToolTip = nil
		end

		list:UpdateElementFlares(p4, false)
		list:UpdateColors(p4, false)
		list:SetIconZDepth(p4, false, false)
	end

	function list:RepositionElements(p4)
		local mInitialX = self.mInitialX
		local v = {}
		local v2 = 0
		local count = #self.mElements
		local v3 = false
		local ternary = module.Ternary(self.mUseOriginalDimensions or self.mOldStyle, 32, 25)
		local v4 = Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()

		local function fn(p5)
			for i = 1, count do
				v3 = self.mSelectedElement ~= nil and self.mSelectedElement.Id == self.mElements[i].Id

				if v3 then
					v2 += self.mSelectedPreSeparation
				end

				v[i] = math.floor(v2 + 0.5)
				v2 += p5

				if v3 then
					v2 = v2 + self.mElements[i].mLabelWidth + self.mSelectedPostSeparation
				end
			end

			v2 = v2 - p5 + ternary
		end

		fn(self.mForcedHorizontalSeparation)
		local mMaxWidth = self.mMaxWidth

		if mMaxWidth ~= nil then
			if v4 then
				mMaxWidth -= self.mCalloutSeparation * 2
			end

			if mMaxWidth < v2 then
				local v5 = v2 - mMaxWidth
				local v6 = self.mForcedHorizontalSeparation - v5 / (count - 1)
				v = {}
				v2 = 0
				fn(v6)
			end
		end

		v2 = math.floor(v2 + 0.5)

		if self.mAlign == module.CENTER_ALIGNED then
			mInitialX -= module.Round(v2 * 0.5)
		elseif self.mAlign == module.RIGHT_ALIGNED then
			mInitialX -= v2
		end

		for i = 1, count do
			local mClipName = self.mElements[i].mClipName

			if p4 then
				self.mMovie:__wf_atom_e57658c2(mClipName, 0, mInitialX + v[i])
			else
				__wf_atom_ec43d06e(self.mMovie, mClipName, 8, { 0 }, { mInitialX + v[i] }, 0.2)
			end
		end

		if v4 then
			self:InitializeRootClip()
			local v5 = mInitialX - self.mCalloutSeparation
			local v6 = mInitialX + v2 - ternary + self.mCalloutSeparation

			if p4 then
				self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "LeftBumper", 0, v5)
				self.mMovie:__wf_atom_4c1c1986(self.mRootClip, "RightBumper", 0, v6)
			else
				__wf_atom_ec43d06e(self.mMovie, self.mRootClip .. ".LeftBumper", 8, { 0 }, { v5 }, 0.2)
				__wf_atom_ec43d06e(self.mMovie, self.mRootClip .. ".RightBumper", 8, { 0 }, { v6 }, 0.2)
			end
		end
	end

	list._CategoryMenu_OnSelected = list.OnSelected

	function list:OnSelected(data, _)
		if self.mSelectedElement ~= nil then
			self.mMovie:__wf_atom_c90af43a(self.mSelectedElement.mClipName .. ".Icon", self.mSelectedElement.Icon)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Bg", 8, { 14, 12 }, { 80, 0 }, 0.2)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Label", 8, { 12 }, { 0 }, 0.2)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".LabelBg", 8, { 12 }, { 0 }, 0.2)
			self.mMovie:__wf_atom_7f57ab2f(self.mSelectedElement.mClipName, "Btn", 67, true)
			list:UpdateColors(self.mSelectedElement, false, false)
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ItemTipSection)
		end

		list:UpdateColors(data, false, true)
		self:SetIconZDepth(data, false, true)
		self:_CategoryMenu_OnSelected(data)

		if data then
			self.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Btn", 67, false)
			self.mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", data.Icon)

			if Engine.IsPlayingWithController() then
				self:SetIconZDepth(data, true, true)
			end

			__wf_atom_ec43d06e(
				self.mMovie,
				self.mSelectedElement.mClipName .. ".Bg",
				8,
				{ 14, 12 },
				{ data.mLabelWidth + self.mSelectedBackerExtra, 100 },
				0.2
			)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Label", 8, { 12 }, { 100 }, 0.2)
			__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".LabelBg", 8, { 12 }, { 100 }, 0.2)
			self:OnUnfocused(data)
		end

		self:RepositionElements(self.mQueueInstantReposition)
		self.mQueueInstantReposition = false
	end

	function list:UpdateColors(data, p4, p5)
		if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.mClipName) then
			return
		end

		local focusedElement = self:GetFocusedElement()
		local ternary = module.Ternary
		local v = p4 ~= nil
		local v2

		if focusedElement == nil then
			v2 = false
		else
			v2 = focusedElement.Id == data.Id
		end

		local v3 = ternary(v, p4, v2)
		local ternary2 = module.Ternary
		local v4 = p5 ~= nil
		local v5

		if self.mSelectedElement == nil then
			v5 = false
		else
			v5 = self.mSelectedElement.Id == data.Id
		end

		local v6 = ternary2(v4, p5, v5)
		local mApplyThemes = self.mApplyThemes
		local color = module2.GetColor(2, true, mApplyThemes)
		local color2 = module2.GetColor(9, true, mApplyThemes)
		local color3 = module2.GetColor(10, true, mApplyThemes)

		if v6 and mApplyThemes or v3 then
			color2 = color3
		end

		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, color2)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg.SubLine", 11, color2)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg.Back", 11, color)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg.Back", 12, module.Ternary(mApplyThemes, 90, 0))
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, color2)
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module.Ternary(v6, color3, color))
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module2.GetColor(0, true))
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".IconBg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.4
		)
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".IconBg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.8
		)
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".LabelBg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.4
		)
		self.mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".LabelBg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.8
		)

		if not __wf_atom_7e8ad928(data.mTopFlare) then
			data.mTopFlare:UpdateColors()
		end

		if not __wf_atom_7e8ad928(data.mBottomFlare) then
			data.mBottomFlare:UpdateColors()
		end
	end

	list._CategoryMenu_OnDraw = list.OnDraw

	function list:OnDraw(state, p4)
		self:_CategoryMenu_OnDraw(state, p4)
		local mMovie = self.mMovie
		local mClipName = state.mClipName
		local v

		if self.mSelectedElement == nil then
			v = false
		else
			v = self.mSelectedElement.Id == state.Id
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "LabelBg", 12, module.Ternary(v, 100, 0))
		mMovie:__wf_atom_7f57ab2f(mClipName, "Btn", 67, not v)

		if v then
			self:SetIconZDepth(state, true, true)
			mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 12, 100)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 12, 100)
		else
			self:SetIconZDepth(state, false, true)
			mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 12, 0)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 12, 0)
		end

		if state.Icon then
			mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", state.Icon)
			mMovie:__wf_atom_c90af43a(mClipName .. ".Shadow", state.Icon)
			mMovie:__wf_atom_4c1c1986(mClipName, "Shadow", 12, 60)
			mMovie:__wf_atom_4c1c1986(mClipName, "Shadow", 11, _G.UIColor_Black)

			if self.mUseOriginalDimensions then
				local ternary = module.Ternary(self.mOldStyle, 32, 25)
				local ternary2 = module.Ternary(self.mOldStyle, 40, 34)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, ternary)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, ternary)
				mMovie:__wf_atom_4c1c1986(mClipName, "Shadow", 14, ternary)
				mMovie:__wf_atom_4c1c1986(mClipName, "Shadow", 15, ternary)
				mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, ternary2)
				mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 15, ternary2)
			end
		end

		mMovie:OverrideMaterial(mClipName .. ".IconBg", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(mClipName .. ".LabelBg", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(mClipName .. ".Bg.SubLine", self.mSmoothEdgeMaterial)
		mMovie:OverrideMaterial(mClipName .. ".Bg.Back", self.mSmoothEdgeMaterial)

		if state.IconOnly then
			mMovie:__wf_atom_50d60589(mClipName .. ".Label", 36, "")
			state.mLabelWidth = -20
		else
			mMovie:__wf_atom_50d60589(mClipName .. ".Label", 36, string.upper(state.Name))
			state.mLabelWidth = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40)
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "LabelBg", 14, mMovie:__wf_atom_5e6e15c8(mClipName .. ".Label", 40) + 12)
		list:UpdateColors(state)
	end

	list._CategoryMenu_Redraw = list.Redraw

	function list:Redraw(p4, p5, p6)
		self:_CategoryMenu_Redraw(p4, p5, p6)
		local howManyElements = self:GetHowManyElements()

		if Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302() then
			self:InitializeRootClip()
			self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "LeftBumper", 13, howManyElements > 1)
			self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "RightBumper", 13, howManyElements > 1)
		end
	end

	function list:SetIconZDepth(p4, p5, p6)
		if p4.mClipName == nil or not self.mOldStyle then
			return
		end

		local v = { p4.mClipName .. ".Icon", p4.mClipName .. ".CounterBg", p4.mClipName .. ".Counter" }
		local ternary = module.Ternary(p5, self.mIconOverZ, 0)

		for i = 1, #v do
			if p6 then
				self.mMovie:__wf_atom_e57658c2(v[i], 4, ternary)
			else
				__wf_atom_ec43d06e(self.mMovie, v[i], 8, { 4 }, { ternary }, 0.2, 0)
			end
		end
	end

	function list:OnGamepadTransition(p4)
		self:DrawCallouts()
		self:RepositionElements(true)

		if self.mRootClip then
			local howManyElements = self:GetHowManyElements()
			self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "LeftBumper", 13, not p4 and howManyElements > 1)
			self.mMovie:__wf_atom_7f57ab2f(self.mRootClip, "RightBumper", 13, not p4 and howManyElements > 1)
		end
	end

	function list:GetParentEnv()
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
	end

	function list:HookUpCallbacks()
		assert(not self.mHookedUpCallbacks)
		self.mHookedUpCallbacks = true
		local parentEnv = self:GetParentEnv()
		local v = "OnGamepadTransition"

		while parentEnv["Prev_" .. v] ~= nil do
			v = "Prev_" .. v
		end

		parentEnv["Prev_" .. v] = parentEnv.OnGamepadTransition
		local v2 = parentEnv["Prev_" .. v] ~= nil

		function parentEnv.OnGamepadTransition(p4)
			if v2 then
				parentEnv["Prev_" .. v](p4)
			end

			self:OnGamepadTransition(p4 == "true")
		end
	end

	list:HookUpCallbacks()
	list:SetIsNewStyle(p3)
	list:DrawCallouts()
	return list
end