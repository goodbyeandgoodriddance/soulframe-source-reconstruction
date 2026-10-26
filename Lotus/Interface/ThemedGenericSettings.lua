local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.UIUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.TextSuggest")
local module6 = require("Lotus.Interface.Components.ThemedCheckbox")
local module7 = require("Lotus.Interface.Components.ThemedToggle")
local module8 = require("Lotus.Interface.Components.ThemedInputField")
local module9 = require("Lotus.Interface.Components.ThemedButton")
local v = nil
local v2 = false
local v3 = true
local v4 = nil
local v5 = "/Lotus/Language/Menu/Global_Confirm"
local v6 = false
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = false
local v12 = nil
local states = {}
local count = 0
local v13 = nil
local flag = false
local v14 = ""
local v15 = { Real = {}, Tags = {}, Indexer = {} }
local v16 = {}
local v17 = nil
local total = 0
local v18 = 0
local v19 = nil
local v20 = 0
local flag2 = false
local v21 = false
local v22 = false
local v23 = true
local v24 = nil
local confirmCallback = nil
local v25 = {}
local v26 = {}
local count2 = 0
local v27 = false
local v28 = {
	44,
	44,
	44,
	44,
	24,
	108,
	8,
	44,
	87,
	84,
	44
}
local fn
local fn2

function Shutdown()
	_T.gToolTip = nil

	if not __wf_atom_7e8ad928(v13) then
		if flag then
			v13:Close()
		elseif module5.IsVisible() then
			module5.CloseIME(v13)
		end
	end

	if not (v11 or __wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(_T[v10])) then
		v11 = true
		_T[v10](states, true)
	end
end

local function fn3(mMaxCount)
	return (string.len((tostring(mMaxCount))))
end

local function fn4(p)
	if not v23 and p then
		return
	end

	v3 = true

	for _, v29 in ipairs(states) do
		if not v29.mChanged or __wf_atom_7e8ad928(v29.mOnValidateSetting) or not __wf_atom_7e8ad928(p) then
			continue
		end

		local mOnValidateSetting, v30 = v29.mOnValidateSetting()

		if mOnValidateSetting then
			continue
		end

		module2.ShowMessage(v30)
		v3 = false
		return
	end

	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "_level0", 0, { function(p2)
			mMovie:__wf_atom_0cf0fdbe((1 - p2) * 0.9)
		end }, { 1 }, 0.3, 0.1, function()
		if not (v11 or __wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(_T[v10])) then
			v11 = true
			_T[v10](states, p)
		end

		mMovie:Close()
	end)
end

function TransitionOut()
	fn4()
end

local function fn5()
	states = {}
	v4:RunForAllElements(function(state)
		if state.mType == module.INPUTBOX then
			state.mContent = mMovie:__wf_atom_387f260e(state.InputField.mLabelClipName, 36)
			local v29 = __wf_atom_932a80f8(state.mContent, nil)

			if v29 > 0 then
				module2.ShowErrorMessage(mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/SocialOverlay_InvalidCharacter",
					false
				) .. __wf_atom_f50c9d2d(state.mContent, v29, v29))
				state.mContent = state.mOriginalValue

				if state.mContent == nil then
					state.mContent = ""
				end

				mMovie:__wf_atom_50d60589(state.InputField.mLabelClipName, 36, state.mOriginalValue)
			end
		end

		table.insert(states, state)
	end)
end

local function fn6()
	if not v23 then
		return
	end

	fn5()
	module2.PlaySound(_G.UISound_WindowClose)
	local v29

	if _T.BackgroundMovie == nil then
		v29 = false
	else
		v29 = _T.IsInScreenStack("ItemBrowsing")
	end

	if v29 then
		_T.GoToPreviousScreen()
	else
		fn4(true)
	end
end

local function fn7()
	fn5()
	fn4()
end

local function fn8()
	v16.FloatingContent = module4.GetColor(9, true)
	v16.FloatingContentHighlight = module4.GetColor(10, true)
	v16.Background = module4.GetColor(2, true)
	v16.Content = module4.GetColor(6, true)
	v16.BackgroundProcedural = module2.ConvertColorNumberToProceduralRGB(v16.Background)
	v16.FloatingContentProcedural = module2.ConvertColorNumberToProceduralRGB(v16.FloatingContent)
	v16.FloatingContentHighlightProcedural = module2.ConvertColorNumberToProceduralRGB(v16.FloatingContentHighlight)
	v16.ContentHighlightProcedural = module2.ConvertColorNumberToProceduralRGB(v16.Content)
	mMovie:__wf_atom_e57658c2("Container.Title", 44, v16.FloatingContent)
	mMovie:OverrideMaterial("BgFill", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"BgFill",
		"RectInnerColor",
		v16.BackgroundProcedural.r,
		v16.BackgroundProcedural.g,
		v16.BackgroundProcedural.b,
		0.8
	)
	mMovie:__wf_atom_1ca72041(
		"BgFill",
		"RectEdgeColor",
		v16.FloatingContentProcedural.r,
		v16.FloatingContentProcedural.g,
		v16.FloatingContentProcedural.b,
		0.1
	)
	mMovie:__wf_atom_7df746cd(v16.Background)
	local v29 = {
		"FancyBits.LeftLines",
		"FancyBits.RightLines",
		"FancyBits.LeftSideLine.FadeLineTop",
		"FancyBits.LeftSideLine.FadeLineMiddle",
		"FancyBits.LeftSideLine.FadeLineBottom",
		"FancyBits.RightSideLine.FadeLineTop",
		"FancyBits.RightSideLine.FadeLineMiddle",
		"FancyBits.RightSideLine.FadeLineBottom"
	}

	for i = 1, #v29 do
		local v30 = v29[i]
		mMovie:__wf_atom_e57658c2(v30, 11, v16.FloatingContent)
		mMovie:__wf_atom_1ca72041(
			v30,
			"RipplesColor",
			v16.ContentHighlightProcedural.r,
			v16.ContentHighlightProcedural.g,
			v16.ContentHighlightProcedural.b,
			0.9
		)
	end
end

function OnCustomButtonPressed()
	if __wf_atom_7e8ad928(v26.CustomBtn) then
		return
	end

	if v26.CustomBtn.Confirm then
		mMovie:Execute("ShowCustomButtonConfirmation", "")
	else
		v26.CustomBtn.CallBack()
	end
end

local function fn9(object, __wf_atom_5e6e15c8)
	if count2 == 1 then
		object:SetPosition(__wf_atom_5e6e15c8 / 2 - object.mMaxSize / 2)
	elseif count2 == 2 then
		object:SetPosition(__wf_atom_5e6e15c8 / 2 + module2.Ternary(object.PositionIdx == 1, -object.mMaxSize - 5, 5))
	elseif count2 == 3 then
		if object.PositionIdx == 2 then
			object:SetPosition(__wf_atom_5e6e15c8 / 2 - object.mMaxSize / 2)
		else
			object:SetPosition(__wf_atom_5e6e15c8 / 2 + module2.Ternary(
				object.PositionIdx == 1,
				-object.mMaxSize * 1.5 - 10,
				object.mMaxSize / 2 + 10
			))
		end
	end
end

local function fn10()
	count2 = 0

	if v22 or v21 then
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.ConfirmButton", 13, true)

		if v26.ConfirmBtn == nil then
			v26.ConfirmBtn = module9.Create(
				mMovie,
				"Container.ButtonContainer.ConfirmButton",
				v5,
				"FinishSelection",
				"<MENU_GENERIC1>"
			)
		end

		v26.ConfirmBtn:SetActive(v22)
		count2 += 1
		v26.ConfirmBtn.PositionIdx = count2
	else
		v26.ConfirmBtn = nil
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.ConfirmButton", 13, false)
	end

	if __wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(_T[v24]) then
		v26.CustomBtn = nil
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.CustomButton", 13, false)
	else
		local v29 = _T[v24]()

		if v26.CustomBtn == nil then
			v26.CustomBtn = module9.Create(
				mMovie,
				"Container.ButtonContainer.CustomButton",
				v29.Label,
				"OnCustomButtonPressed",
				"<" .. v29.CallOut .. ">"
			)
		end

		if __wf_atom_7e8ad928(v29.ConfirmCallback) then
			v26.CustomBtn.Confirm = nil
			v26.CustomBtn.CallBack = v29.CallBack
		else
			v25.ConfirmLabel = v29.ConfirmLabel
			confirmCallback = v29.ConfirmCallback
			v26.CustomBtn.Confirm = true
		end

		v25.Label = v29.Label
		count2 += 1
		v26.CustomBtn.PositionIdx = count2
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.CustomButton", 13, true)
	end

	if v23 then
		if v26.CancelBtn == nil then
			v26.CancelBtn = module9.Create(
				mMovie,
				"Container.ButtonContainer.CancelButton",
				"/Menu/Confirm_Item_Cancel",
				"ExitScreen",
				"<MENU_CANCEL>"
			)
		end

		count2 += 1
		v26.CancelBtn.PositionIdx = count2
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.CancelButton", 13, true)
	else
		v26.CancelBtn = nil
		mMovie:__wf_atom_2dedec1a("Container.ButtonContainer.CancelButton", 13, false)
	end

	fn2()

	if count2 > 0 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("BgFill", 14)
		local v29 = __wf_atom_5e6e15c8 / (count2 + 1)

		for _, v30 in pairs(v26) do
			v30:SetWidth(v29)
			fn9(v30, __wf_atom_5e6e15c8)
		end
	end

	_T.SetButtons(mMovie, nil)
end

local function fn11()
	if v7 == nil then
		return
	end

	v7.mChanged = true

	if v8 ~= nil then
		v8.mChanged = true
	end

	v22 = true

	if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(_T[v12])) then
		_T[v12](v7.mValue)
	end

	fn10()
end

fn2 = function()
	local v29 = mMovie:__wf_atom_5e6e15c8("Container.Title", 41) + 15
	local v30 = 0
	local mTextWidth = 0
	v4:RunForAllElements(function(p)
		v29 += v4:CalculateHeight(p)
		local width = v4:CalculateWidth(p)

		if v30 < width then
			v30 = width
		end

		if p.mTextWidth ~= nil then
			local mTextWidth2 = p.mTextWidth

			if mTextWidth < mTextWidth2 then
				mTextWidth = p.mTextWidth
			end
		end
	end)
	local v31 = math.max(10 + v29, 100)
	local v32 = math.max(v30 + 40, 100)

	if v27 and mTextWidth ~= 0 then
		local v33 = (v32 - mTextWidth) / 2
		v4:RunForAllElements(function(data)
			if data.mType == module.TITLE or data.mType == module.CHECKBOX then
				mMovie:__wf_atom_e57658c2(data.mClipName, 0, v33)

				if data.mType == module.CHECKBOX then
					mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn", 14, mTextWidth)
					data.Checkbox:SetPosition(mTextWidth - 70)
				end
			end
		end)
	end

	local rounded = module2.Round((mMovie:__wf_atom_54eeda24() - v31) / 2)
	local rounded2 = module2.Round((mMovie:__wf_atom_97cd8326() - v32) / 2)
	local ternary = module2.Ternary(count2 > 0, 52, 0)
	mMovie:__wf_atom_e57658c2("Container.ButtonContainer", 1, v29 + ternary)
	mMovie:__wf_atom_e57658c2("BgFill", 0, rounded2)
	mMovie:__wf_atom_e57658c2("BgFill", 1, rounded - 32 - ternary / 2)
	mMovie:__wf_atom_e57658c2("BgFill", 15, v31 + 48 + ternary)
	mMovie:__wf_atom_e57658c2("BgFill", 14, v32)
	mMovie:__wf_atom_e57658c2("Container.Title", 14, v32)
	mMovie:__wf_atom_e57658c2("Container", 0, rounded2 - 3)
	mMovie:__wf_atom_e57658c2("Container", 1, rounded - 20 - ternary / 2)
	local v33 = v32 / 2
	local v34 = rounded + 16 + v31 / 2 - ternary / 2
	mMovie:__wf_atom_e57658c2("FancyBits", 1, v34)
	mMovie:__wf_atom_e57658c2("FancyBits.LeftLines", 0, -v33 + 1)
	mMovie:__wf_atom_e57658c2("FancyBits.RightLines", 0, v33 - 1)
	mMovie:__wf_atom_e57658c2("FancyBits.LeftSideLine", 0, -v33 + 2)
	mMovie:__wf_atom_e57658c2("FancyBits.RightSideLine", 0, v33 - 1)
end

local function fn12()
	print("InitializeSettings()")
	local module10 = require("EE.Interface.Components.List")
	v4 = module10.CreateList(mMovie, "Container.MenuEntry1")
	v4:SetCallbacks("MenuEntryPressed", "MenuEntryFocused", "MenuEntryUnfocused")
	v4.mForcedVerticalSeparation = nil
	v4.mVisibleElements = 10
	v4.mElementTransitionTime = 0
	v4.totalY = 0
	mMovie:__wf_atom_2dedec1a("Container.ScrollBar", 13, false)

	function v4.Print(_, _) end

	function v4:mOnFocusedCallback()
		v7 = self
		self.mFocused = true

		if self.mType == module.TITLE or self.mType == module.SPACER then
			return
		end

		module2.PlaySound(_G.UISound_Focus)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Btn",
			"RectEdgeColor",
			v16.FloatingContentHighlightProcedural.r,
			v16.FloatingContentHighlightProcedural.g,
			v16.FloatingContentHighlightProcedural.b,
			0.5
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, v16.FloatingContentHighlight)

		if self.mType == module.INPUTCOUNT then
			mMovie:__wf_atom_7f57ab2f(
				self.mClipName,
				"Callouts",
				13,
				Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(v7) and v7.Id == self.Id
			)

			if Engine.IsPlayingWithController() then
				mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callouts.Right.Tf.text", "<MENU_RTRIGGER2>")
				mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callouts.Left.Tf.text", "<MENU_LTRIGGER2>")
			end
		elseif self.mType == module.CHECKBOX then
			self.Checkbox:TrySetFocus(true)
		end
	end

	function v4:mOnUnfocusedCallback()
		self.mFocused = false

		if self.mType == module.TITLE or self.mType == module.SPACER then
			return
		end

		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Btn",
			"RectEdgeColor",
			v16.FloatingContentProcedural.r,
			v16.FloatingContentProcedural.g,
			v16.FloatingContentProcedural.b,
			0.1
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, v16.FloatingContent)

		if self.mType == module.INPUTCOUNT then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Callouts", 13, false)

			if Engine.IsPlayingWithController() then
				mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callouts.Right.Tf.text", "<MENU_RTRIGGER2>")
				mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callouts.Left.Tf.text", "<MENU_LTRIGGER2>")
			end
		elseif self.mType == module.CHECKBOX then
			self.Checkbox:TrySetFocus(false)
		end
	end

	function v4:mOnSelectedCallback()
		if self.mType == module.CHECKBOX then
			if self.Checkbox ~= nil then
				self.Checkbox:TryPressed(true)
			end
		elseif self.mType == module.COLOR then
			module.OpenColorPicker(mMovie, self.mCurrColor, function(mNewColor, _)
				if mNewColor == nil then
					self.mNewColor = nil
				else
					self.mNewColor = mNewColor
				end
			end, function(p)
				if p then
					self.mCurrColor = self.mNewColor

					if not __wf_atom_7e8ad928(self.mOnColorSelected) then
						self.mOnColorSelected(self.mCurrColor)
					end

					mMovie:__wf_atom_4c1c1986(self.mClipName, "Color.Fill", 11, self.mCurrColor)
				end

				self.mNewColor = nil
			end)
			fn11()
		elseif self.mType == module.INPUTCOUNT then
			v4.mElementDrawCallback(self)
		elseif self.mType == module.INPUTBOX then
			mMovie:__wf_atom_2dedec1a(self.InputField.mLabelClipName, 52, self.mMultiLine)

			if not __wf_atom_7e8ad928(self.mMaxChars) then
				mMovie:__wf_atom_e57658c2(self.InputField.mLabelClipName, 39, self.mMaxChars)
			end

			if self.InputField ~= nil then
				self.InputField:Pressed(true)
			end

			fn11()
		end
	end

	function v4:mElementDrawCallback()
		self.mMultiLine = self.mMultiLine == true
		__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "Title")

		if self.mType == module.TITLE then
			mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"Label",
				14,
				module2.Ternary(self.mWidth ~= nil, self.mWidth, 800)
			)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Label", 52, self.mMultiLine)
			mMovie:__wf_atom_384aa4e8(self.mClipName .. ".Label", "ShowHyperlinkItem")
			local ternary = module2.Ternary(self.mVerticalPadding ~= nil, self.mVerticalPadding, 0)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 1)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 1, __wf_atom_5e6e15c8 + ternary)

			if Engine.__wf_atom_578fc9dd() then
				mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 49, "Arial Unicode MS")
			end
		elseif self.mType == module.CHECKBOX then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "Checkbox")

			if self.Checkbox == nil then
				self.Checkbox = module6.Create(mMovie, self.mClipName .. ".Checkbox", self.mValue)
				self.Checkbox.mParentId = self.mId
				self.Checkbox.mHeight = 28
				self.Checkbox.mMinSize = 64
				self.Checkbox.mMaxSize = 64
				self.Checkbox.mEdgeAlpha = 40
				self.Checkbox.mFocusedEdgeAlpha = 80
				self.Checkbox.mUnfocusedEdgeColor = 1
				self.Checkbox.mIconOn = checkmarkIcon
				self.Checkbox.mIconOff = crossIcon
				self.Checkbox.mIconDefault = gripsIcon

				function self.Checkbox.ValueChanged(p)
					self.mValue = p.mChecked
					fn11()
				end
			end

			self.Checkbox:Redraw()

			if self.mButtonWidth ~= nil then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, self.mButtonWidth)

				if self.mValueOffset == nil then
					self.Checkbox:SetPosition(self.mButtonWidth - 70)
				else
					self.Checkbox:SetPosition(self.mButtonWidth - self.Checkbox.mMaxSize - self.mValueOffset)
				end
			end
		elseif self.mType == module.TOGGLE then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "Toggle")

			if self.Toggle == nil then
				self.Toggle = module7.Create(mMovie, self.mClipName .. ".Toggle", self.mToggleValues)
				self.Toggle.mParentId = self.Id
				self.Toggle.mHeight = 28
				self.Toggle.mMinSize = 270
				self.Toggle.mMaxSize = 270
				self.Toggle.mEdgeAlpha = 40
				self.Toggle.mFocusedEdgeAlpha = 80
				self.Toggle.mUnfocusedEdgeColor = 1
				self.Toggle.mArrowIcon = arrowIcon
				self.Toggle:SetIndexByValue(self.mValue)
				self.Toggle.ComponentTrySetFocus = self.Toggle.TrySetFocus

				function self.Toggle.TrySetFocus(object, p)
					object:ComponentTrySetFocus(p)
					v4:FocusElementById((tonumber(self.Id)))
				end

				self.Toggle.ComponentTrySetAltFocus = self.Toggle.TrySetAltFocus

				function self.Toggle.TrySetAltFocus(object, p, p2)
					object:ComponentTrySetAltFocus(p, p2)
					v4:FocusElementById((tonumber(self.Id)))
				end

				self.Toggle.ComponentTryPressed = self.Toggle.TryPressed

				function self.Toggle:TryPressed(p, p2)
					self:ComponentTryPressed(p, p2)
				end

				self.Toggle.ComponentTryAltPressed = self.Toggle.TryAltPressed

				function self.Toggle.TryAltPressed(object, p, p2)
					object:ComponentTryAltPressed(p, p2)
				end

				function self.Toggle.ValueChanged(p)
					self.mValue = p.mOptions[p.mIndex].Value
					fn11()
				end
			end

			if self.mButtonWidth == nil then
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Btn", 14)
				self.Toggle:SetPosition(__wf_atom_5e6e15c8 - self.Toggle.mMaxSize - 4)
			else
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, self.mButtonWidth)
				self.Toggle:SetPosition(self.mButtonWidth - self.Toggle.mMaxSize - 4)
			end

			self.Toggle:Redraw()
		elseif self.mType == module.COLOR then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "color")

			if self.mButtonWidth ~= nil then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, self.mButtonWidth)
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Color", 0, self.mButtonWidth - 35)
			end

			if self.mCurrColor then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Color.Fill", 11, self.mCurrColor)
			end
		elseif self.mType == module.INPUTBOX then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "Inputbox")
			mMovie:__wf_atom_e57658c2(self.mClipName .. ".FocusBtn", 100, self.Id)
			mMovie:SetCallbacks(
				self.mClipName .. ".FocusBtn",
				v4.mRollOverElementCallback,
				v4.mRollOutElementCallback,
				v4.mSelectElementCallback,
				v4.mPressElementCallback
			)
			mMovie:SetFocusedCallbacks(self.mClipName .. ".InputBoxText", nil, nil, "InputBoxTextLimited", nil)
			local v29 = self.mWidth == nil and 800 or self.mWidth
			local mHeight = 57

			if self.mMultiLine then
				if self.mHeight ~= nil then
					mHeight = math.max(mHeight, self.mHeight - 50)
				end
			else
				mHeight = 30
			end

			mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, v29 + 20)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 15, mHeight + 41)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "FocusBtn", 14, v29 + 20)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "FocusBtn", 15, mHeight + 41)

			if self.InputField == nil then
				self.InputField = module8.Create(
					mMovie,
					self.mClipName .. ".InputBox",
					self.mContent,
					nil,
					nil,
					nil,
					nil,
					nil,
					self.mSkipAutoFocus
				)
				self.InputField.ComponentInputFieldFocused = self.InputField.InputFieldFocused

				function self.InputField.InputFieldFocused(object, p)
					v4:FocusElementById((tonumber(self.Id)))
					object:ComponentInputFieldFocused(p)
				end

				function self.InputField.mOnFocusedCallback(_)
					v4:FocusElementById((tonumber(self.Id)))
				end

				self.InputField.BaseInputFieldTextChanged = self.InputField.InputFieldTextChanged

				function self.InputField.InputFieldTextChanged(object, value)
					local v30 = value or ""

					if object.mLabel ~= v30 then
						fn11()
					end

					object:BaseInputFieldTextChanged(v30)
				end

				self.InputField.mInnerAlpha = 100
				self.InputField.mAltButtonVisible = true

				if Engine.__wf_atom_578fc9dd() then
					mMovie:__wf_atom_50d60589(self.InputField.mLabelClipName, 49, "Arial Unicode MS")
				end
			end

			self.InputField.mMinSize = v29
			self.InputField.mMaxSize = v29
			self.InputField.mHeight = mHeight
			mMovie:__wf_atom_e57658c2(self.InputField.mLabelClipName, 15, mHeight)
			mMovie:__wf_atom_2dedec1a(self.InputField.mLabelClipName, 52, self.mMultiLine)
			mMovie:__wf_atom_e57658c2(self.InputField.mLabelClipName, 39, self.mMaxChars)
			local v30 = mHeight / (mMovie:__wf_atom_5e6e15c8(self.InputField.mLabelClipName, 50) * 1.5)
			self.InputField:SetMultiline(self.mMultiLine, v30)
			self.InputField:Redraw()
		elseif self.mType == module.INPUTCOUNT then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "InputCount")
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Plus", 100, self.Id)
			mMovie:SetCallbacks(
				self.mClipName .. ".Plus",
				v4.mRollOverElementCallback,
				nil,
				"ConcludeCount",
				"IncreaseCount"
			)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Minus", 100, self.Id)
			mMovie:SetCallbacks(
				self.mClipName .. ".Minus",
				v4.mRollOverElementCallback,
				nil,
				"ConcludeCount",
				"DecreaseCount"
			)
			mMovie:SetFocusedCallbacks(self.mClipName .. ".Count", "CountFieldFocused", "CountFieldUnfocused", nil, nil)
			mMovie:__wf_atom_50d60589(self.mClipName .. ".MaxCount", 36, (tostring(self.mMaxCount)))
			mMovie:__wf_atom_50d60589(self.mClipName .. ".MinCount", 36, (tostring(self.mMinCount)))
			mMovie:__wf_atom_50d60589(self.mClipName .. ".Count", 36, (tostring(self.mCount)))
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<CREDITS>", true)
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Count", 38, __wf_atom_8e9ac384 .. "0123456789")

			if self.mCallback ~= nil then
				self.mCallback(self.mCount)
			end
		elseif self.mType == module.ICONBUTTON then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "IconSelector")
			mMovie:__wf_atom_c0d7a318(self.mClipName, "Btn", "noMenuSelection", true)

			if self.mButtonWidth ~= nil then
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, self.mButtonWidth)
			end

			local v29 = 50 + self.mRows * 42
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 15, v29)

			if self.mHeight == nil then
				self.mHeight = v29 + 10
			end

			if self.mIconGrid == nil then
				local v30 = getfenv(1)

				v30["IconFocused" .. self.Id] = function(p)
					if v7 == nil or v7.Id ~= self.Id then
						v4:FocusElementById((tonumber(self.Id)))
					end

					if not __wf_atom_7e8ad928(self.mIconGrid) then
						self.mIconGrid:FocusElementById((tonumber(p)))
					end
				end

				v30["IconUnfocused" .. self.Id] = function(p)
					if not __wf_atom_7e8ad928(self.mIconGrid) then
						self.mIconGrid:UnfocusElementById((tonumber(p)))
					end
				end

				v30["IconPressed" .. self.Id] = function(p)
					if not __wf_atom_7e8ad928(self.mIconGrid) then
						self.mIconGrid:SelectElementById((tonumber(p)))
						module2.PlaySound(_G.UISound_Select)
					end
				end

				local module11 = require("EE.Interface.Components.Grid")
				self.mIconGrid = module11.CreateGrid(
					mMovie,
					self.mClipName .. ".IconElement",
					nil,
					self.mColumns,
					self.mRows
				)
				self.mIconGrid:SetCallbacks(
					"IconPressed" .. self.Id,
					"IconFocused" .. self.Id,
					"IconUnfocused" .. self.Id
				)
				self.mIconGrid.mColumnSeparation = 42
				self.mIconGrid.mRowSeparation = 42

				function self.mIconGrid.mOnFocusedCallback(p)
					if p.mIndex ~= self.mIconGrid.mSelectedIndex then
						mMovie:__wf_atom_1ca72041(
							p.mClipName .. ".Btn",
							"RectEdgeColor",
							v16.FloatingContentHighlightProcedural.r,
							v16.FloatingContentHighlightProcedural.g,
							v16.FloatingContentHighlightProcedural.b,
							0.5
						)
					end
				end

				function self.mIconGrid.mOnUnfocusedCallback(p)
					if p.mIndex ~= self.mIconGrid.mSelectedIndex then
						mMovie:__wf_atom_1ca72041(p.mClipName .. ".Btn", "RectEdgeColor", 0, 0, 0, 0)
					end
				end

				function self.mIconGrid.mOnSelectedCallback(p)
					if self.mIconGrid.mSelectedIndex ~= nil then
						mMovie:__wf_atom_1ca72041(
							self.mIconGrid.mElements[self.mIconGrid.mSelectedIndex].mClipName .. ".Btn",
							"RectEdgeColor",
							0,
							0,
							0,
							0
						)

						if self.mIconGrid.mSelectedIndex ~= p.mIndex then
							fn11()
						end
					end

					self.mIconGrid.mSelectedIndex = p.mIndex
					mMovie:__wf_atom_1ca72041(
						p.mClipName .. ".Btn",
						"RectEdgeColor",
						v16.FloatingContentHighlightProcedural.r,
						v16.FloatingContentHighlightProcedural.g,
						v16.FloatingContentHighlightProcedural.b,
						0.75
					)
				end

				function self.mIconGrid.mElementDrawCallback(p)
					mMovie:OverrideMaterial(p.mClipName .. ".Btn", _G.UIMaterial_RectangleNoDepth)
					mMovie:__wf_atom_c90af43a(p.mClipName .. ".Icon", p.Icon)
					mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 11, v16.Content)
					mMovie:__wf_atom_1ca72041(p.mClipName .. ".Btn", "RectInnerColor", 0, 0, 0, 0)
					mMovie:__wf_atom_1ca72041(p.mClipName .. ".Btn", "RectEdgeColor", 0, 0, 0, 0)
				end

				for i = 1, #self.mIcons do
					self.mIconGrid:AddElement({
						Icon = self.mIcons[i],
						true
					})
				end

				self.mIconGrid:Redraw(nil, true, true)

				if self.mStartIndex ~= nil and self.mStartIndex <= self.mIconGrid:GetHowManyElements() then
					self.mIconGrid:SelectElement((tonumber(self.mStartIndex)))
				end
			end
		elseif self.mType == module.CHOICE then
			__wf_atom_86cbd68d(mMovie, self.mClipName .. ".gotoAndStop", "Choice")
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<CHECKMARK_OUTLINE>", true)
			self.YesBtn = module9.Create(
				mMovie,
				self.mClipName .. ".YesBtn",
				__wf_atom_8e9ac384 .. " " .. self.mButtonValues[1].mLabel,
				"YesButton",
				nil,
				nil,
				true
			)
			self.YesBtn.mBaseLabel = self.mButtonValues[1].mLabel
			self.NoBtn = module9.Create(
				mMovie,
				self.mClipName .. ".NoBtn",
				__wf_atom_8e9ac384 .. " " .. self.mButtonValues[2].mLabel,
				"NoButton",
				nil,
				nil,
				true
			)
			self.NoBtn.mBaseLabel = self.mButtonValues[2].mLabel
			self.YesBtn.Parent = self
			self.NoBtn.Parent = self
			local ternary = module2.Ternary(self.mWidth ~= nil, self.mWidth, 800)
			local v29 = ternary * 0.6
			local ternary2 = module2.Ternary(self.mButtonSpacing ~= nil, self.mButtonSpacing, 0)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Label", 52, self.mMultiLine)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, ternary)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 14, v29)
			local count3 = 0

			for _, v30 in ipairs({ self.YesBtn, self.NoBtn }) do
				v30.mAlignment = "center"
				v30:Redraw()
				local v31 = mMovie:__wf_atom_5e6e15c8(v30.mClipName .. ".Label", 40) + module2.Ternary(Engine.IsPlayingWithController(), 45, 20)
				v30:SetPosition(v29 + count3 * ternary2 + v31)
				count3 += 1
			end
		end

		mMovie:__wf_atom_e57658c2(self.mClipName .. ".Btn", 100, self.Id)
		mMovie:SetCallbacks(
			self.mClipName .. ".Btn",
			v4.mRollOverElementCallback,
			v4.mRollOutElementCallback,
			v4.mSelectElementCallback,
			v4.mPressElementCallback
		)
		mMovie:OverrideMaterial(self.mClipName .. ".Btn", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Btn",
			"RectInnerColor",
			v16.BackgroundProcedural.r,
			v16.BackgroundProcedural.g,
			v16.BackgroundProcedural.b,
			1
		)

		if self.mSkipLocalize then
			mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 36, self.mLabel)
		else
			mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Label.text", self.mLabel)
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, v16.FloatingContent)
		self.mTextWidth = mMovie:__wf_atom_cfc41e35(self.mClipName, "Label", 40)

		if self.mFocused then
			v4.mOnFocusedCallback(self)
		else
			v4.mOnUnfocusedCallback(self)
		end
	end

	function v4:CalculateHeight(data)
		if not __wf_atom_7e8ad928(data.mHeight) then
			return data.mHeight
		end

		if data.mType == module.TITLE and data.mMultiLine == true then
			return mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Label", 41) + 20 + module2.Ternary(
				data.mVerticalPadding ~= nil,
				data.mVerticalPadding,
				0
			)
		end

		if data.mType == module.INPUTBOX and data.mMultiLine == false then
			return 80
		end

		if data.mType ~= module.CHOICE or data.mMultiLine ~= true then
			return v28[data.mType]
		end

		local v29 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Label", 41) + 20
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn", 15, v29)

		for _, v30 in ipairs({ data.YesBtn, data.NoBtn }) do
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v30.mClipName .. ".Label", 41)
			local v31 = v29 * 0.5 - 15 - __wf_atom_5e6e15c8
			mMovie:__wf_atom_e57658c2(v30.mClipName, 1, v31)
		end

		return v29
	end

	function v4:CalculateWidth(p)
		if __wf_atom_7e8ad928(p.mWidth) then
			return 800
		end

		return p.mWidth
	end

	v4._GenericSettings_CalculateX = v4.CalculateX

	function v4.CalculateX(_, p)
		if __wf_atom_7e8ad928(p.mOffsetX) then
			return (v4:_GenericSettings_CalculateX(p))
		end

		return p.mOffsetX
	end

	function v4.CalculateY(object, p)
		local elementIndexById = object:GetElementIndexById(p.Id)

		if __wf_atom_7e8ad928(elementIndexById) then
			return object.mInitialY
		end

		local total2 = 0

		for i = 1, elementIndexById - 1 do
			local elementById = v4:GetElementById(i)
			total2 += v4:CalculateHeight(elementById)
		end

		return object.mInitialY + total2
	end
end

local function fn13()
	local elementIndexById = v4:GetElementIndexById(v19)

	if not __wf_atom_7e8ad928(elementIndexById) then
		local elementInIndex = v4:GetElementInIndex(elementIndexById)
		local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(elementInIndex.mClipName .. ".Count", 36)

		if v20 ~= __wf_atom_387f260e then
			v20 = __wf_atom_387f260e
			local v29 = string.gsub(v20, mMovie:__wf_atom_8e9ac384("<CREDITS>", true), "")
			local ternary = module2.Ternary(string.len(v29) == 0, 0, (tonumber(v29)))
			local mMaxCount = ternary == nil and 0 or ternary

			if elementInIndex.mMaxCount ~= nil and elementInIndex.mMaxCount < mMaxCount then
				mMaxCount = elementInIndex.mMaxCount
			end

			if elementInIndex.mMinCount ~= nil and mMaxCount < elementInIndex.mMinCount then
				mMaxCount = elementInIndex.mMinCount
			end

			fn11()
			elementInIndex.mCount = mMaxCount

			if elementInIndex.mCallback ~= nil then
				elementInIndex.mCallback(elementInIndex.mCount)
			end
		end
	end
end

local function fn14()
	if v7.InputField == nil then
		return
	end

	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(v7.InputField.mLabelClipName, 36)
	local v29 = mMovie:__wf_atom_5e6e15c8(v7.InputField.mLabelClipName, 85) or 0
	local v30 = string.sub(__wf_atom_387f260e, 1, v29)
	local v31 = string.find(string.reverse(v30), ",")

	if v31 ~= nil then
		v31 = string.len(v30) - v31 + 1
	end

	local v32 = string.sub(
		__wf_atom_387f260e,
		(v31 == nil or v29 < v31) and 0 or v31,
		(string.find(__wf_atom_387f260e, ",", v29 + 1))
	)
	local v33 = string.gsub(v32, "[, ]", "")
	local v34 = string.lower(v33)
	local flag3 = false

	if v34 == v14 then
		return
	end

	v14 = v34
	local v35 = ""
	local count3 = 0

	if v34 ~= "" then
		local v36 = ""
		local v37 = string.len(v34)
		local v38 = string.sub(v34, 1, 1)
		local v39 = v15.Indexer[v38]

		if v39 ~= nil then
			for i = v39, #v15.Tags do
				local tag = v15.Tags[i]

				if string.sub(tag, 1, v37) == v34 and v36 ~= v15.Real[i] then
					flag3 = true
					v35 ..= v15.Real[i] .. "|"
					count3 += 1
					v36 = v15.Real[i]

					if count3 >= 8 then
						break
					end
				elseif v38 ~= string.sub(tag, 1, 1) then
					break
				end
			end
		end
	end

	if flag3 then
		local v36 = v35 .. v14
		v8 = v7
		module5.OpenIME(v13)
		module5.IMESetTip(v14, v13)
		module5.IMESetTipCursor(string.len(v14), v13)
		module5.IMESetOptions(v36, v13, false)
		mMovie:__wf_atom_2dedec1a(v7.InputField.mLabelClipName, 87, true)
	else
		module5.IMESetOptions("", v13, false)
		module5.CloseIME(v13)
		mMovie:__wf_atom_2dedec1a(v7.InputField.mLabelClipName, 87, false)
		v8 = nil
	end
end

local function fn15()
	local imeGetFocusedValue = module5.IMEGetFocusedValue(v13)
	v14 = imeGetFocusedValue
	local v29 = mMovie:__wf_atom_5e6e15c8(v8.InputField.mLabelClipName, 85) or 0
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(v8.InputField.mLabelClipName, 36)
	local v30 = string.sub(__wf_atom_387f260e, 1, v29)
	local v31 = string.find(string.reverse(v30), ",")
	local v32 = ""

	if v31 ~= nil then
		local v33 = string.len(v30) - v31 + 1

		if v33 < v29 then
			v32 = string.sub(__wf_atom_387f260e, 1, v33) .. " "
		end
	end

	local v33 = string.find(__wf_atom_387f260e, ",", v29)
	local v34 = ", "
	local v35 = string.len(v32 .. imeGetFocusedValue .. v34)

	if v33 ~= nil then
		v34 = string.sub(__wf_atom_387f260e, v33)
		v35 = string.len(v32 .. imeGetFocusedValue)
	end

	mMovie:__wf_atom_50d60589(v8.InputField.mLabelClipName, 36, v32 .. imeGetFocusedValue .. v34)
	mMovie:__wf_atom_e57658c2(v8.InputField.mLabelClipName, 85, v35)
	module5.CloseIME(v13)
	module5.IMESetFocusedOption(1, v13)
	mMovie:__wf_atom_2dedec1a(v8.InputField.mLabelClipName, 87, false)
	v8 = nil
	fn11()
end

function Update()
	if not v2 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v4.mScrollBar) then
		v4.mScrollBar:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v17) then
		v18 -= __wf_atom_fa1258d0()

		if v18 <= 0 then
			if total < fn3(v7.mMaxCount) - 1 then
				total += 0.2
			end

			v18 = 0.25
			fn(v17 * math.pow(10, (math.floor(total))))
		end
	end

	v4:RunForAllElements(function(p)
		if not __wf_atom_7e8ad928(p.mOnUpdate) then
			p.mOnUpdate(p.Id)
		end
	end)

	if flag2 then
		fn13()
	end

	if not (__wf_atom_8e4fda44:__wf_atom_084a721a() or __wf_atom_7e8ad928(v13)) then
		if v7 ~= nil and v7.mType == module.INPUTBOX then
			if module5.IMEGetAndClearClicked() then
				fn15()
			end

			fn14()
		end

		module5.Update(v13)
	end
end

local function fn16()
	if v9 == nil then
		count += 1

		if count < 10 then
			v:AddTimer(0.1, fn16)
		else
			fn4()
		end
	else
		if not __wf_atom_7e8ad928(_T[v9]) then
			local v29 = _T[v9]()

			for i = 1, #v29 do
				__wf_atom_83c14687(0)
				v29[i].Id = i
				v29[i].mOriginalValue = v29[i].mValue

				if v29[i].mOriginalValue == nil then
					v29[i].mOriginalValue = v29[i].mContent
				end

				v4:AddElement(v29[i], true)
			end
		end

		v4:Redraw()
		fn2()
		mMovie:__wf_atom_2dedec1a("Container.Message", 13, v4:GetHowManyElements() == 0)
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { 100, 0 }, 0.2, 0, function()
			v3 = false
		end)
		fn10()
	end
end

local function fn17()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, mMovie:__wf_atom_d5a50cb5())
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, mMovie:__wf_atom_c4f6543f())
end

function Initialize()
	local module10 = require("Lotus.Interface.Libs.TimerMgr")
	v = module10.CreateTimerMgr()
	module2.PlaySound(_G.UISound_WindowOpen)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_976dcedd("MouseCatcherBtn", "noMenuSelection", true)
	fn17()
	local v29 = {
		"FancyBits.LeftLines",
		"FancyBits.LeftSideLine.FadeLineTop",
		"FancyBits.LeftSideLine.FadeLineMiddle",
		"FancyBits.LeftSideLine.FadeLineBottom"
	}

	for i = 1, #v29 do
		mMovie:OverrideMaterial(v29[i], leftLineMaterial)
	end

	local v30 = {
		"FancyBits.RightLines",
		"FancyBits.RightSideLine.FadeLineTop",
		"FancyBits.RightSideLine.FadeLineMiddle",
		"FancyBits.RightSideLine.FadeLineBottom"
	}

	for i = 1, #v30 do
		mMovie:OverrideMaterial(v30[i], rightLineMaterial)
	end

	fn8()
	fn12()
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, nil, "MouseCatcherPressed")
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("_root", 4, -15000)

	local function fn18(p)
		mMovie:__wf_atom_0cf0fdbe(p * 0.9)
	end

	fn18(0)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { fn18 }, { 1 }, 0.15, 0, function()
		fn16()
	end)
	fn10()
	v2 = true
end

function SetTitle(p)
	mMovie:__wf_atom_7d7314f1("Container.Title.text", p)

	if not __wf_atom_7e8ad928(v4) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Container.Title", 41)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Container.Title", 1)
		v4.mInitialY = __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8 + 55
	end
end

function SetConfirmButtonLabel(p)
	v5 = p
	fn10()
end

function SetConfirmButtonVisibleWhenInactive(p)
	v21 = p == "true"
end

function SetConfirmButtonActive(p)
	v6 = p == "true"
	v22 = v22 or v6
	fn10()
end

function SetConfirmButtonActiveOverride(p)
	v22 = p == "true"
	fn10()
end

function SetCancelButtonActive(p)
	v23 = p == "true"
	fn10()
end

function SetNoElementsMessage(p)
	mMovie:__wf_atom_50d60589("Container.Message", 46, "center")
	mMovie:__wf_atom_7d7314f1("Container.Message.text", p)
end

function SetElementsFunction(p)
	v9 = p
end

function SetCustomButtonFunction(p)
	v24 = p
end

function OnCustomButtonConfirmation(p)
	if confirmCallback then
		confirmCallback(tonumber(p) == 4)
	end
end

function ShowCustomButtonConfirmation()
	module2.ShowConfirmMessage(v25.ConfirmLabel, "OnCustomButtonConfirmation")
end

function SetCallBack(p)
	v10 = p
end

function SetValueChangedCallBack(p)
	v12 = p
end

function EnableHints()
	if not Engine.__wf_atom_fc67ba71() then
		v13 = __wf_atom_8e4fda44:FindMovie(IMEOverlayMovie)

		if __wf_atom_7e8ad928(v13) and not __wf_atom_7e8ad928(IMEOverlayMovie) then
			v13 = mMovie:PushChildMovie(IMEOverlayMovie)
			flag = true
		end

		if not __wf_atom_7e8ad928(v13) then
			v15.Real = {}
			v15.Tags = {}
			v15.Indexer = {}

			for _, v29 in ipairs(gGameData:__wf_atom_0f109cd4()) do
				table.insert(v15.Real, v29.mDisplayName)
			end

			table.sort(v15.Real, function(a, b)
				return string.lower(a) < string.lower(b)
			end)
			local v29 = nil

			for i = 1, #v15.Real do
				table.insert(v15.Tags, string.lower(v15.Real[i]))
				local v30 = string.sub(v15.Tags[i], 1, 1)

				if v30 == v29 then
					continue
				end

				v15.Indexer[v30] = i
				v29 = v30
			end
		end
	end
end

function onRawInputEvent(_, value, p)
	if p == "1" and not v3 then
		local v29 = module5.IsVisible() and module5.mTargetMovie == mMovie

		if string.find(value, "_ENTER") == nil then
			if v29 then
				local v30 = string.find(value, "EN_LEFT") and -1 or string.find(value, "EN_RIGHT") and 1 or 0

				if v30 ~= 0 then
					local v31 = tonumber(module5.IMEGetFocusedIndex(v13))

					if not module5.IMESetFocusedOption(v31 + v30, v13) then
						local v32 = mMovie:__wf_atom_5e6e15c8(v7.InputField.mLabelClipName, 85) or 0
						mMovie:__wf_atom_e57658c2(v7.InputField.mLabelClipName, 85, v32 + v30)
					end
				end
			end
		elseif not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie) and v29 then
			fn15()
		end
	end
end

function Close()
	fn4()
end

function ExitScreen()
	fn6()
end

function FinishSelection()
	fn7()
end

function onKeyUp_MENU_SELECT()
	if not (v3 or __wf_atom_7e8ad928(v4)) then
		v4:SelectCurrentElement()
	end
end

function IsInputBlocked()
	return v3
end

function onViewportSizeChanged(_, _)
	fn17()
end

function MenuEntryFocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:FocusElementById((tonumber(p)))
	end
end

function MenuEntryUnfocused(_)
	__wf_atom_7e8ad928(v4)
end

function MenuEntryPressed(p)
	if not (v3 or __wf_atom_7e8ad928(v4)) then
		v4:SelectElementById(tonumber(p), true)
		module2.PlaySound(_G.UISound_Select)
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (v3 or __wf_atom_7e8ad928(v4.mScrollBar)) then
		v4.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function OSKInputBoxCallback(p, mContent)
	if not p then
		mMovie:__wf_atom_50d60589(v7.InputField.mLabelClipName, 36, mContent)
		v7.mContent = mContent
		fn11()
	end
end

fn = function(p)
	local mMaxCount = tonumber(v7.mCount) + tonumber(p)
	local v29 = v7.mMinCount == nil and 0 or tonumber(v7.mMinCount)

	if mMaxCount < v29 then
		mMaxCount = v29
	end

	if tonumber(v7.mMaxCount) < mMaxCount then
		mMaxCount = v7.mMaxCount
	end

	if Engine.IsPlayingWithController() then
		module2.CreateParticles(
			mMovie,
			v7.mClipName .. ".Callouts." .. module2.Ternary(p > 0, "Right", "Left"),
			module2.Ternary(p > 0, _G.UIFx_RightBumperPress, _G.UIFx_LeftBumperPress),
			0,
			0
		)
	end

	v7.mCount = mMaxCount
	mMovie:__wf_atom_50d60589(v7.mClipName .. ".Count", 36, module2.FormatNumber(v7.mCount, 0))

	if v7.mCallback ~= nil then
		v7.mCallback(mMaxCount)
	end

	fn11()
end

local function fn18(_)
	if not v3 and v7.mType == module.INPUTCOUNT then
		fn(1)
		v17 = 1
		total = 0
		v18 = 0.6
	end
end

local function fn19(_)
	if not v3 and v7.mType == module.INPUTCOUNT then
		fn(-1)
		v17 = -1
		total = 0
		v18 = 0.6
	end
end

local function fn20()
	v17 = nil
end

function IncreaseCount(p)
	fn18(tonumber(p))
end

function DecreaseCount(p)
	fn19(tonumber(p))
end

function ConcludeCount()
	fn20()
end

function CountFieldFocused(p)
	local elementIndexById = v4:GetElementIndexById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementIndexById) then
		v4:FocusElementById((tonumber(p)))
		flag2 = true
		local elementInIndex = v4:GetElementInIndex(elementIndexById)
		local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(elementInIndex.mClipName .. ".Count", 36)
		v19 = tonumber(p)
		v20 = __wf_atom_387f260e

		if tonumber(__wf_atom_387f260e) == 0 then
			mMovie:__wf_atom_50d60589(elementInIndex.mClipName .. ".Count", 36, "")
			v20 = ""
		end
	end
end

function CountFieldUnfocused(p)
	flag2 = false
	fn13()
	local elementIndexById = v4:GetElementIndexById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementIndexById) then
		local elementInIndex = v4:GetElementInIndex(elementIndexById)

		if mMovie:__wf_atom_387f260e(elementInIndex.mClipName .. ".Count", 36) == "" then
			mMovie:__wf_atom_50d60589(elementInIndex.mClipName .. ".Count", 36, "0")
		end

		if elementInIndex.mCallback ~= nil then
			elementInIndex.mCallback(elementInIndex.mCount)
		end
	end
end

function onKeyDown_MENU_RTRIGGER2()
	if not v3 and not __wf_atom_7e8ad928(v7) and v7.mType == module.INPUTCOUNT then
		fn18(v7.Id)
	end

	return true
end

function onKeyDown_MENU_LTRIGGER2()
	if not v3 and not __wf_atom_7e8ad928(v7) and v7.mType == module.INPUTCOUNT then
		fn19(v7.Id)
	end

	return true
end

function onKeyUp_MENU_LTRIGGER2()
	fn20()
	return true
end

function onKeyUp_MENU_RTRIGGER2()
	fn20()
	return true
end

function onKeyUp_HIDE_PAUSE_MENU()
	fn4(true)
	return true
end

function ConfirmPopup(_) end

function ShowHyperlinkItem(p)
	module2.DoOpenWebBrowser(p)
	module3.OnHyperlinkPressed(mMovie)
end

function YesButton(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<CHECKMARK>", true)
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("<CHECKMARK_OUTLINE>", true)
		object.Parent.mValue = true
		object:SetText(__wf_atom_8e9ac384 .. " " .. object.mBaseLabel)
		object.Parent.NoBtn:SetText(__wf_atom_8e9ac384_2 .. " " .. object.Parent.NoBtn.mBaseLabel)
		fn11()
	end
end

function NoButton(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<CHECKMARK>", true)
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("<CHECKMARK_OUTLINE>", true)
		object.Parent.mValue = false
		object:SetText(__wf_atom_8e9ac384 .. " " .. object.mBaseLabel)
		object.Parent.YesBtn:SetText(__wf_atom_8e9ac384_2 .. " " .. object.Parent.YesBtn.mBaseLabel)
		fn11()
	end
end

function SetScale(p)
	local v29 = tonumber(p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 1)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 14)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 15)
	mMovie:__wf_atom_e57658c2("_root", 5, v29)
	mMovie:__wf_atom_e57658c2("_root", 6, v29)
	mMovie:__wf_atom_e57658c2(
		"_root",
		0,
		__wf_atom_5e6e15c8 - (__wf_atom_5e6e15c8_3 * (v29 / 100) - __wf_atom_5e6e15c8_3) / 2
	)
	mMovie:__wf_atom_e57658c2(
		"_root",
		1,
		__wf_atom_5e6e15c8_2 - (__wf_atom_5e6e15c8_4 * (v29 / 100) - __wf_atom_5e6e15c8_4) / 2 - 30
	)
end

function InputBoxTextLimited(_)
	module2.PlaySound(_G.UISound_Error)
end

function CenterTitles(p)
	v27 = p == "true"
end

function SupportsThemes()
	return true
end