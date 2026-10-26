module(..., package.seeall)

function Create(object, p, p2, p3, p4, value, mDecimals)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local module3 = require("Lotus.Interface.Components.ThemedInputField")
	local mMinValue = tonumber(p3) or 0
	local mMaxValue2 = tonumber(p4) or 100
	local v = tonumber(p2) or (mMaxValue2 - mMinValue) / 2 + mMinValue
	local v2 = __wf_atom_421b01aa(v, mMinValue, mMaxValue2)
	local mStep = value or 1

	if mDecimals == nil then
		local v3 = string.match(mStep, "%.(%d+)")
		local v4 = string.match(v2, "%.(%d+)")
		mDecimals = math.max(#v3, #v4)
	end

	if v2 ~= nil then
		local v3 = "0123456789"

		if mMinValue < 0 then
			v3 ..= "-"
		end

		if mDecimals > 0 then
			v3 ..= "."
		end

		object:__wf_atom_50d60589(p .. ".Label", 38, v3)
	end

	local v3 = module3.Create(object, p, string.format("%." .. mDecimals .. "f", v2), nil, nil, nil, nil, nil, true)
	v3.mArrowIcon = nil
	v3.mArrowIconWidth = 16
	v3.mArrowIconHeight = 32
	v3.mTextWidth = 40
	v3.mLabelYOffset = -1
	v3.mMinValue = mMinValue
	v3.mMaxValue = mMaxValue2
	v3.mStep = mStep
	v3.mDecimals = mDecimals
	v3.mArrowFocused = 0
	v3.mArrowPressedTimes = { 0.05, 0.2, 0.4, 0.6, 0.8 }
	v3.Button_SetActive = v3.SetActive

	function v3:SetActive(p5)
		local v4 = p5 ~= false
		self:Button_SetActive(v4)
		self.mMovie:__wf_atom_2dedec1a(self.mClipName .. ".BtnLeft", 67, v4)
		self.mMovie:__wf_atom_2dedec1a(self.mClipName .. ".BtnRight", 67, v4)
		self.mMovie:__wf_atom_2dedec1a(self.mClipName .. ".BtnInput", 67, v4)
		self.mMovie:__wf_atom_50d60589(self.mClipName .. ".Label", 57, module.Ternary(v4, "input", "dynamic"))
	end

	v3.InputFieldTryPressed = v3.TryPressed
	v3.InputFieldTrySetFocus = v3.TrySetFocus
	v3.InputField_HookUpCallbacks = v3.HookUpCallbacks

	function v3:HookUpCallbacks()
		self:InputField_HookUpCallbacks()
		local parentEnv = self:GetParentEnv()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local v4 = string.gsub(mClipName, "%.", "")

		parentEnv[v4 .. "InputOver"] = function(_)
			self:InputFieldTrySetFocus(true)
		end

		parentEnv[v4 .. "InputOut"] = function(_)
			self:InputFieldTrySetFocus(false)
		end

		parentEnv[v4 .. "InputPress"] = function(_)
			self:InputFieldTryPressed(true)
		end

		parentEnv[v4 .. "InputRelease"] = function(_)
			self:InputFieldTryPressed(false)
		end

		mMovie:SetCallbacks(
			mClipName .. ".BtnInput",
			v4 .. "InputOver",
			v4 .. "InputOut",
			v4 .. "InputRelease",
			v4 .. "InputPress"
		)
		mMovie:SetCallbacks(
			mClipName .. ".BtnLeft",
			v4 .. "OverAlt",
			v4 .. "OutAlt",
			v4 .. "ReleaseAlt",
			v4 .. "PressAlt"
		)
		mMovie:SetCallbacks(
			mClipName .. ".BtnRight",
			v4 .. "OverAlt",
			v4 .. "OutAlt",
			v4 .. "ReleaseAlt",
			v4 .. "PressAlt"
		)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BtnLeft", 100, -1)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BtnRight", 100, 1)
	end

	function v3:TrySetFocus(p5)
		self:SliderSetFocus(p5)
	end

	function v3:SliderSetFocus(mSliderFocused)
		self.mSliderFocused = mSliderFocused
		self.mSliderPressed = false
		self:UpdateColors()
	end

	function v3:TryPressed(p5)
		self:SliderPressed(p5)
	end

	function v3:SliderPressed(mSliderPressed)
		if not self:IsActive() then
			return
		end

		self.mSliderPressed = mSliderPressed
	end

	v3.InputFieldSetAltFocus = v3.SetAltFocus

	function v3:SetAltFocus(p5, p6)
		if p5 then
			self.mArrowFocused = tonumber(p6)
		else
			self.mArrowFocused = 0
			self.mArrowPressedTime = nil
		end

		self.mSliderPressed = false
		self:InputFieldSetAltFocus(p5)
	end

	function v3:AltPressed(p5, p6)
		if not p5 then
			self.mArrowPressedTime = nil
			return
		end

		local v4 = tonumber(self.mLabel) + tonumber(p6) * self.mStep
		self:InputFieldTextChanged(__wf_atom_421b01aa(v4, self.mMinValue, self.mMaxValue))

		if self.mArrowPressedTime == nil then
			self.mArrowPressedTime = #self.mArrowPressedTimes
		end

		self.mArrowPressedTimer = self.mArrowPressedTimes[self.mArrowPressedTime]
	end

	v3.InputFieldInputFieldFocused = v3.InputFieldFocused

	function v3:InputFieldFocused(p5)
		self:InputFieldInputFieldFocused(p5)

		if not p5 then
			local mLabel = tonumber(self.mLabel) or v2
			self:InputFieldTextChanged((tonumber(string.format("%." .. self.mDecimals .. "f", mLabel))))
		end

		self.mSliderPressed = false
	end

	v3.InputFieldInputFieldTextChanged = v3.InputFieldTextChanged

	function v3:InputFieldTextChanged(mMaxValue, p5)
		local unFormatNumber = module.UnFormatNumber(mMaxValue)
		local v4 = unFormatNumber == nil and p5 and 0 or unFormatNumber

		if v4 ~= nil then
			if self.mMaxValue > 0 and self.mMaxValue < v4 then
				mMaxValue = self.mMaxValue
			end

			if self.mMinValue < 0 and v4 < self.mMinValue then
				mMaxValue = self.mMinValue
			end
		end

		local v5

		if tonumber(mMaxValue) == nil then
			v5 = false
		else
			v5 = mMaxValue ~= self.mLabel
		end

		_T.Slider = self
		self:InputFieldInputFieldTextChanged(mMaxValue)

		if v5 then
			self:UpdateSlider(mMaxValue)
			self:ValueChanged()
		end
	end

	function v3:SetValue(p5)
		self:InputFieldTextChanged(p5)
	end

	function v3:UpdateSlider(p5)
		local v4 = tonumber(p5) or 0
		local v5 = __wf_atom_421b01aa(v4, self.mMinValue, self.mMaxValue)
		local v6 = math.max(self.mArrowIconWidth, self.mArrowIconHeight)
		local v7 = self.mWidth - self.mTextWidth - v6 - v6
		local v8 = (v5 - self.mMinValue) / (self.mMaxValue - self.mMinValue)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 0, v6 + v7 * v8)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 14, 4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Slider", 15, self.mHeight + 4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Fill", 0, v6)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Fill", 14, v7 * v8 + 3)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Fill", 15, self.mHeight)
	end

	v3.InputFieldResize = v3.Resize

	function v3:Resize()
		self:InputFieldResize()
		self:UpdateSlider(self.mLabel)
		local v4 = math.max(self.mArrowIconWidth, self.mArrowIconHeight)
		local v5 = self.mWidth - self.mTextWidth - v4 - v4
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"Label",
			0,
			self.mWidth - (self.mTextWidth + module.Ternary(self.mHideArrows, 30, 0))
		)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 14, self.mTextWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnInput", 0, self.mWidth - self.mTextWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnInput", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnInput", 14, self.mTextWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnInput", 15, self.mArrowIconHeight)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 0, v4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 14, v5)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 0, v4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 14, v5)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Btn", 15, self.mArrowIconHeight)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnLeft", 0, v4 / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnLeft", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnLeft", 14, v4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnLeft", 15, self.mArrowIconHeight)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconLeft", 0, v4 / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconLeft", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconLeft", 14, self.mArrowIconWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconLeft", 15, self.mArrowIconHeight)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnRight", 0, v4 + v5 + v4 / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnRight", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnRight", 14, v4)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "BtnRight", 15, self.mArrowIconHeight)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconRight", 0, v4 + v5 + v4 / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconRight", 1, self.mHeight / 2)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconRight", 14, self.mArrowIconWidth)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "IconRight", 15, self.mArrowIconHeight)
	end

	function v3:UpdateColors()
		local mApplyThemes = self.mApplyThemes
		local color = module2.GetColor(9, true, mApplyThemes)
		local color2 = module2.GetColor(10, true, mApplyThemes)
		local mInnerColor = self.mInnerColor or module2.GetColor(2, true, mApplyThemes)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 11, module.Ternary(self.mFocused, color2, color))
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"IconLeft",
			11,
			module.Ternary(self.mArrowFocused == -1, color2, color)
		)
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"IconRight",
			11,
			module.Ternary(self.mArrowFocused == 1, color2, color)
		)
		local mFocusedEdgeAlpha = self.mSliderFocused and self.mFocusedEdgeAlpha or self.mEdgeAlpha
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color2)
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module.Ternary(self.mSliderFocused, color2, color))
		local convertColorNumberToProceduralRGB3 = module.ConvertColorNumberToProceduralRGB(mInnerColor)
		local convertColorNumberToProceduralRGB4 = module.ConvertColorNumberToProceduralRGB(color)
		self.mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Backer",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			mFocusedEdgeAlpha / 100
		)
		self.mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Backer",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			self.mInnerAlpha / 100
		)
		self.mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Slider",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			1
		)
		self.mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Slider",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			1
		)
		self.mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Fill",
			"RectInnerColor",
			convertColorNumberToProceduralRGB4.r,
			convertColorNumberToProceduralRGB4.g,
			convertColorNumberToProceduralRGB4.b,
			1
		)
	end

	v3.InputFieldRedraw = v3.Redraw

	function v3:Redraw()
		local v4 = "0123456789"

		if self.mMinValue < 0 then
			v4 ..= "-"
		end

		if self.mDecimals > 0 then
			v4 ..= "."
		end

		self.mMovie:__wf_atom_50d60589(self.mClipName .. ".Label", 38, v4)
		local uiMaterial_Button = _G.UIMaterial_Button

		if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
			uiMaterial_Button = self.mVisRangeMaterials.BackerMaterial
			self.mMovie:OverrideMaterial(self.mClipName .. ".IconLeft", self.mVisRangeMaterials.BaseMaterial)
			self.mMovie:OverrideMaterial(self.mClipName .. ".IconRight", self.mVisRangeMaterials.BaseMaterial)
		end

		self.mMovie:OverrideMaterial(self.mClipName .. ".Fill", uiMaterial_Button)
		self.mMovie:OverrideMaterial(self.mClipName .. ".Slider", uiMaterial_Button)
		self:InputFieldRedraw()
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconLeft", 13, not self.mHideArrows)
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconRight", 13, not self.mHideArrows)
		self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".IconLeft", self.mArrowIcon)
		self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".IconRight", self.mArrowIcon)
		self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Fill", "RectEdgeColor", 0, 0, 0, 0)
	end

	function v3:Update(p5)
		if self.mSliderPressed then
			local v4 = self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Backer", 14) or 0
			local v5 = (self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 30) or 0) - (self.mMovie:__wf_atom_5e6e15c8(
				self.mClipName .. ".Backer",
				0
			) or 0)
			local v6 = __wf_atom_421b01aa(v5, 0, v4) / v4 * (self.mMaxValue - self.mMinValue) + self.mMinValue
			self:InputFieldTextChanged((string.format("%." .. self.mDecimals .. "f", v6)))
		end

		if self.mArrowPressedTime ~= nil then
			self.mArrowPressedTimer -= p5

			if self.mArrowPressedTimer <= 0 then
				if self.mArrowPressedTime > 1 then
					self.mArrowPressedTime -= 1
				end

				self:AltPressed(true, self.mArrowFocused)
			end
		end
	end

	v3.mHookedUpCallbacks = false
	v3:HookUpCallbacks()
	v3:SetTextAlignment("right")
	v3:SetActive()
	v3:Redraw()
	return v3
end