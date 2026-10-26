local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.Components.ThemedButton")
local v = nil
local v2 = false
local flag = true
local v3 = nil
local v4 = 0
local v5 = nil
local v6 = true
local v7 = true
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = {}
local v12 = 0
local count = 0
local v13 = nil
local v14 = "Middle"
local v15 = nil
local v16 = nil
local v17 = 404
local v18 = 0
local v19 = 22
local v20 = 500
local v21 = true
local v22 = false
local v23 = false
local v24 = nil
local rounded = 0
local v25 = false
local v26 = false
local mConfirmMsg = nil
local v27 = 0.95
local v28 = 0.2
local v29 = 0.2
local v30 = 0.2
local v31 = false
local v32 = 0
local v33 = nil
local v34 = nil
local v35 = nil
local v36 = nil
local v37 = nil
local v38 = false

local function fn()
	if not (v26 or __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(_T[v9])) then
		v26 = true

		if v33 then
			_T[v9](v11, v33.mLabel)
		else
			_T[v9](v11)
		end
	end
end

function Shutdown()
	_T.gToolTip = nil
	_T.gToolTipCoords = nil

	if v38 and not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	fn()
end

local function fn2()
	flag = true
	v25 = true

	if v31 then
		fn()
	end

	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, v29, 0, function()
		local v39 = { function(p)
				mMovie:__wf_atom_0cf0fdbe((1 - p) * v27)
			end }
		__wf_atom_ec43d06e(mMovie, "_root", 0, v39, { 1 }, v30, 0, function()
			mMovie:Close()
			fn()
			mConfirmMsg = nil
			v3:RunForAllElements(function(p)
				p.mSelected = nil
			end)
		end)
	end)
end

function TransitionOut()
	fn2()
end

local function fn3()
	module.PlaySound(_G.UISound_WindowClose)
	local v39

	if _T.BackgroundMovie == nil then
		v39 = false
	else
		v39 = _T.IsInScreenStack("ItemBrowsing")
	end

	if v39 then
		_T.GoToPreviousScreen()
	else
		fn2()
	end
end

local function fn4()
	local screenDimensions, v39 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("MouseCatcher", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("MouseCatcher", 15, v39)
end

local function fn5()
	local color = module4.GetColor(2, true)
	module4.GetColor(3, true)
	local color2 = module4.GetColor(9, true)
	local color3 = module4.GetColor(6, true)
	mMovie:__wf_atom_7df746cd(color)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color2)
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color)
	mMovie:__wf_atom_1ca72041(
		"Container.BgFill",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.3
	)
	mMovie:__wf_atom_1ca72041(
		"Container.BgFill",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.75
	)
	mMovie:__wf_atom_e57658c2("Container.Title", 11, color2)
	mMovie:__wf_atom_e57658c2("Container.Title", 90, color)
	mMovie:__wf_atom_e57658c2("Container.Underline", 11, color2)
	v3.mScrollBar:UpdateColors()
	v3:RunForAllVisibleElements(function(p)
		print(p.mClipName)
		local mButton = p.mButton

		if mButton then
			print("update colors")
			mButton:UpdateColors()
		end

		mMovie:__wf_atom_4c1c1986(p.mClipName, "RightText", 11, color3)
	end)
end

local function fn6()
	local v39 = {}

	if not __wf_atom_7e8ad928(_T[v15]) then
		local v40 = _T[v15](v3)

		for i = 1, #v40 do
			local v41 = i
			table.insert(v39, {
				Label = v40[i].Label,
				CallBack = function()
					if not __wf_atom_7e8ad928(_T[v40[v41].CallBack]) then
						_T[v40[v41].CallBack](v3)
					end
				end,
				CallOut = v40[i].CallOut,
				Tips = v40[i].Tips,
				Padding = v40[i].Padding
			})
		end
	end

	if v21 then
		table.insert(v39, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = fn3,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v39, getfenv(1))
	end
end

function UpdateButtons()
	fn6()
end

local function fn7()
	v11 = {}
	v3:RunForAllElements(function(p)
		if p.mSelected then
			table.insert(v11, p)
		end
	end)
	fn2()
end

function ConfirmSelection(p)
	if p == 4 then
		fn7()
	else
		v3:RunForAllElements(function(p2)
			if p2.mSelected and not __wf_atom_7e8ad928(_T.MenuOnUnfocusedCallback) then
				p2.mSelected = nil
				_T.MenuOnUnfocusedCallback(p2)
			else
				p2.mSelected = nil
			end
		end)
	end
end

local function fn8()
	if __wf_atom_7e8ad928(mConfirmMsg) then
		fn7()
		return
	end

	module.ShowConfirmMessage(mConfirmMsg, "ConfirmSelection")
	mConfirmMsg = nil
end

local function fn9()
	print("InitializeSettings()")
	local module6 = require("EE.Interface.Components.List")
	v3 = module6.CreateList(mMovie, "Container.ButtonContainer.Element")
	v3:SetCallbacks("MenuEntryPressed", "MenuEntryFocused", "MenuEntryUnfocused")
	v3.mForcedVerticalSeparation = module.Ternary(v22, 32, 42)

	if Engine.__wf_atom_2a979d69() then
		v3.mVisibleElements = 10
	else
		v3.mVisibleElements = 16
	end

	v3.mElementTransitionTime = 0
	v3:AttachScrollBar("Container.ScrollBar", -4)

	function v3:Print(_) end

	function v3:mOnFocusedCallback()
		if not self.mEnabled or flag then
			return
		end

		if __wf_atom_7e8ad928(v36) then
			module.PlaySound(_G.UISound_Focus)
		else
			module.PlaySound(v36)
		end

		v13 = self
		self.mFocused = true

		if self.mClipName ~= nil and self.mToolTip ~= nil then
			_T.gToolTip = self.mToolTip

			if Engine.__wf_atom_fc67ba71() then
				local rootBasedPosition, v39 = module.GetRootBasedPosition(mMovie, self.mClipName .. ".Button")

				if rootBasedPosition ~= 0 and v39 ~= 0 then
					local v40 = rootBasedPosition + v17
					local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(mMovie, {
						x = v40,
						y = v39
					})
					_T.gToolTipCoords = {
						x = transformPixelToViewportCoordinates.x,
						y = transformPixelToViewportCoordinates.y
					}
				end
			end
		end

		if _T[v34] ~= nil then
			_T[v34](self)
		end
	end

	function v3:mOnUnfocusedCallback()
		self.mFocused = false
		_T.gToolTip = nil
		_T.gToolTipCoords = nil

		if _T[v35] ~= nil then
			_T[v35](self)
		end
	end

	function v3:mOnSelectedCallback()
		if not self.mEnabled or flag then
			return
		end

		if not __wf_atom_7e8ad928(_T[v16]) then
			_T[v16](v3, self)
			return
		end

		if not Engine.IsPlayingWithController() then
			if self.mSelected and Time() - v12 < 0.5 then
				mConfirmMsg = self.mConfirmMsg
				fn8()
				return
			else
				v12 = Time()
			end
		end

		if __wf_atom_7e8ad928(v37) then
			module.PlaySound(_G.UISound_ButtonSelect)
		else
			module.PlaySound(v37)
		end

		self.mSelected = not self.mSelected
		v3.mElementDrawCallback(self)

		if self.mSelected then
			mConfirmMsg = self.mConfirmMsg
			fn8()
		end
	end

	function v3.RepositionButton(_, _) end

	function v3.mClipCreatedCallback(p)
		if not v22 then
			mMovie:__wf_atom_4c1c1986(p, "Button.Bg", 14, v32 - 20)
		end

		mMovie:__wf_atom_4c1c1986(p, "Button.Btn", 14, v32 - 20)
	end

	function v3:mElementDrawCallback()
		local mClipName = self.mClipName

		if mClipName == nil then
			return
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(self.mName, true)

		if v22 then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. " " .. __wf_atom_8e9ac384
		end

		if v7 then
			__wf_atom_8e9ac384 = TitleCase(__wf_atom_8e9ac384)
		end

		mMovie:__wf_atom_48bd5a59(
			mClipName,
			"RightText",
			36,
			module.Ternary(self.mRightText ~= nil, self.mRightText, "")
		)
		mMovie:__wf_atom_c0d7a318(mClipName, "Button", "Id", self.Id)
		local mButton = module5.Create(
			mMovie,
			mClipName .. ".Button",
			__wf_atom_8e9ac384,
			"invalidCallback",
			"<MENU_SELECT>",
			nil,
			nil,
			nil,
			{ mMaxSize = v3.mButtonWidth }
		)
		self.mButton = mButton
		mButton.mUnderlineAlpha = 0
		mButton.mHeight = 36
		mButton.ButtonSetFocus = mButton.SetFocus

		function mButton.SetFocus(object, p)
			if p then
				v3:FocusElementById(object.mId)
			else
				v3:UnfocusElementById(object.mId)
			end

			object:ButtonSetFocus(p)
		end

		mButton.ButtonPressed = mButton.Pressed

		function mButton.Pressed(object, p)
			if p then
				v3:SelectElementById(object.mId)
			end

			object:ButtonPressed(p)
		end

		mButton.ButtonResize = mButton.Resize

		function mButton.Resize(p)
			mButton:ButtonResize()
			mMovie:__wf_atom_4c1c1986(mClipName, "RightText", 1, p.mLabelY)
		end

		mMovie:__wf_atom_48bd5a59(mButton.mClipName, "Label", 46, "center")
		mMovie:__wf_atom_7f57ab2f(mButton.mClipName, "Label", 54, true)

		if v22 then
			mButton.mInnerAlpha = 0
			mButton.mEdgeAlpha = 0
			mButton.mShowHighlight = false
			mButton.mShowUnderline = false
		end

		if self.Type == module3.TITLE then
			self.mEnabled = false
			mButton.mShowHighlight = false
			mButton.mShowUnderline = false
			mButton.mInactiveAlpha = 100
			mButton.mInactiveColor = module4.GetColor(6, true)
		else
			mButton.mToUpper = false
			mButton.mUnfocusedEdgeColor = 9
			local _ = self.Type == module3.ICONBUTTON
		end

		if v3.mButtonWidth ~= nil then
			mButton.mMinSize = v3.mButtonWidth
			mButton.mMaxSize = v3.mButtonWidth
			mMovie:__wf_atom_4c1c1986(mClipName, "RightText", 0, v3.mButtonWidth - v3.mCalloutWidth - 5)
			mMovie:__wf_atom_4c1c1986(mClipName, "RightText", 14, v3.mCalloutWidth)
		end

		if self.Type == nil and self.Bold == false then
			mButton.mFormatPrefix = "<p><font face=\"Roboto\">"
			mButton.mFormatSuffix = "</font></p>"
		end

		mButton.mShowCallout = false
		mButton:SetId(self.Id)
		mButton:SetTextAlignment("left")
		mButton:SetActive(self.mEnabled)
		mButton:Redraw()

		if self.mFocused then
			v3.mOnFocusedCallback(self)
		else
			v3.mOnUnfocusedCallback(self)
		end
	end

	function v3:ToggleFocusedElement(p)
		self:Print("ToggleFocusedElement(" .. tostring(p) .. ")")
		local mCurrentElementIndex = __wf_atom_7e8ad928(self:GetScroll()) and 0 or self:GetScroll() - p

		if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
			mCurrentElementIndex = self.mCurrentElementIndex
		end

		local howManyElements = self:GetHowManyElements()
		local elementInIndex = nil
		local count2 = 0

		while
			(elementInIndex == nil or not (Engine.IsPlayingWithController() or elementInIndex.mEnabled))
			and not (howManyElements <= count2)
		do
			if self.mWrapAroundNavigation then
				mCurrentElementIndex = self.UTIL.ToggleValue(mCurrentElementIndex, p, 1, howManyElements)
			else
				mCurrentElementIndex = __wf_atom_421b01aa(mCurrentElementIndex + p, 1, howManyElements)
			end

			elementInIndex = self:GetElementInIndex(mCurrentElementIndex)
			count2 += 1
		end

		if self.mScrollBar ~= nil then
			if
				p == self.DOWN
				and mCurrentElementIndex == self:GetScroll() + self:GetHowManyVisibleElements() - 1
				and self.mScrollBar:GetScrollValue() < 1
			then
				self.mScrollBar:ScrollDown()
			elseif
				p == self.UP
				and mCurrentElementIndex == self:GetScroll()
				and self.mScrollBar:GetScrollValue() > 0
			then
				self.mScrollBar:ScrollUp()
			end
		end

		self:FocusElement(mCurrentElementIndex)
	end
end

local function fn10(p, p2)
	if v18 ~= p then
		v18 = p
		v17 = p
		v3.mButtonWidth = v17 - v19
		v3:Redraw(nil, true, p2)
		local v39 = v17

		if v3.mScrollBar.mEnabled then
			v39 += 20
		end

		module2.DrawSeparator(mMovie, "Container.Underline", v39 - 20)
		mMovie:__wf_atom_e57658c2("Container.Underline", 0, -v39 / 2 + 10)
		mMovie:__wf_atom_e57658c2("Container.BgFill", 14, v39)
		mMovie:__wf_atom_e57658c2("Container.Blurer", 14, v39)
		mMovie:__wf_atom_e57658c2("Container.ButtonContainer", 0, -v39 / 2 + v19 / 2)
		mMovie:__wf_atom_e57658c2("Container.ScrollBar", 0, v39 / 2 - 16)
		mMovie:__wf_atom_e57658c2("Container.Title", 0, -v39 / 2 + 20)

		if not __wf_atom_7e8ad928(v33) then
			v33.mMinSize = v39
			v33.mMaxSize = v39
			v33.mX = -v39 / 2
			v33:Redraw()
			mMovie:__wf_atom_2dedec1a("Container.SearchBox", 13, true)
		end
	end
end

function Update()
	if not v2 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end

	if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3.mScrollBar)) then
		v3.mScrollBar:Update(__wf_atom_fa1258d0())
	end
end

local function fn11(fn12)
	if v8 ~= nil then
		return true
	end

	count += 1

	if count < 10 then
		v:AddTimer(0.1, fn12)
	else
		fn2()
	end

	return false
end

local function fn12()
	if not fn11(fn12) then
		return
	end

	if not __wf_atom_7e8ad928(_T[v8]) then
		local v39 = _T[v8]()

		if not __wf_atom_7e8ad928(v3) then
			for i = 1, #v39 do
				local elementById = v3:GetElementById(i)

				if elementById then
					for k, v40 in pairs(v39[i]) do
						elementById[k] = v40
					end
				else
					v39[i].mSearchTerm = string.upper(Localize(v39[i].mName, {}))
					v3:AddElement(v39[i], true)
				end
			end

			v3:Redraw(nil, true, true)
		end
	end
end

function UpdateComponents()
	fn12()
end

local function fn13(p, p2)
	return p and (p.mIgnoreSearch or p.mSearchTerm:find(p2))
end

local function fn14(mLabel)
	if __wf_atom_7e8ad928(v33) or __wf_atom_7e8ad928(v3) or #v3.mUnfilteredElements == 0 then
		return
	end

	local mLabel2 = v33.mLabel
	local v39 = string.upper(mLabel2):gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
	local v40

	if mLabel == "" or v39 == "" then
		v40 = false
	else
		v40 = mLabel:find(v39)
	end

	if v40 then
		local v41 = 1

		while v41 <= #v3.mElements do
			local mElement = v3.mElements[v41]

			if mElement and not fn13(mElement, v39) then
				v3:RemoveElement(mElement.mIndex, true, true)
			else
				v41 += 1
			end
		end
	else
		v3:RemoveElements(true, true)

		for i = 1, #v3.mUnfilteredElements do
			local mUnfilteredElement = v3.mUnfilteredElements[i]

			if fn13(mUnfilteredElement, v39) then
				v3:AddElement(module.CopyTable(mUnfilteredElement), true, true)
			end
		end
	end

	v3:Redraw(nil, true, true)
end

local function fn15(p, genericMenu_IdToSelect)
	if not fn11(fn15) then
		return
	end

	if not __wf_atom_7e8ad928(_T[v8]) then
		local v39 = _T[v8]()
		local v40 = false

		for i = 1, #v39 do
			__wf_atom_83c14687(0)
			v39[i].Id = i

			if v39[i].mEnabled == nil then
				v39[i].mEnabled = true
			end

			v40 = v39[i].mEnabled and true or v40
			v39[i].mSearchTerm = string.upper(Localize(v39[i].mName, {}))
			v3:AddElement(v39[i], true)
		end

		if not v40 then
			fn2()
			return
		end
	end

	fn6()

	if not __wf_atom_7e8ad928(v33) then
		v3.mUnfilteredElements = module.CopyTableRecursive(v3.mElements)
	end

	local v39 = mMovie:__wf_atom_97cd8326() * 0.8
	local v40 = v3.mClipName .. ".Button.Label"
	local v41 = mMovie:__wf_atom_5e6e15c8("Container.Title", 40) + 38
	local v42 = math.min(math.max(v17, v41), v39)
	local mCalloutWidth = 0
	v3:RunForAllElements(function(p2)
		local v44 = TitleCase(Localize(p2.mName, {}))

		if v22 then
			v44 = mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. " " .. v44
		end

		mMovie:__wf_atom_50d60589(v40, 36, v44)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v40, 40)

		if #p2.mRightText > 0 then
			mMovie:__wf_atom_50d60589(v40, 36, p2.mRightText)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v40, 40)
			__wf_atom_5e6e15c8 = __wf_atom_5e6e15c8 + 10 + __wf_atom_5e6e15c8_2
			mCalloutWidth = math.max(mCalloutWidth, __wf_atom_5e6e15c8_2)
		end

		local v45 = __wf_atom_5e6e15c8 + 50
		v42 = math.min(math.max(v42, v45), v39)
	end)
	v3.mCalloutWidth = mCalloutWidth

	if v42 == v17 and v18 ~= 0 then
		v3.mButtonWidth = v17 - v19
		v3:Redraw(nil, true, p)
	else
		fn10(v42, p)
	end

	v32 = 0
	v3:RunForAllVisibleElements(function(p2)
		if p2.mClipName then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p2.mClipName .. ".Button.Label", 40)

			if p2.Type == module3.ICONBUTTON then
				__wf_atom_5e6e15c8 += 36
			end

			if v32 < __wf_atom_5e6e15c8 then
				v32 = __wf_atom_5e6e15c8
			end
		end
	end)
	v32 += 50
	local v44 = v5 == nil and -3 or 54
	local v45 = math.max(98 + math.min(v3:GetHowManyElements(), v3.mVisibleElements) * v3.mForcedVerticalSeparation, 50)

	if v22 then
		v3.mInitialY += 8
		v45 = v45 + 19 + v44
	else
		v32 = math.max(v32, v20)
		v3:RunForAllVisibleElements(function(p2)
			mMovie:__wf_atom_4c1c1986(p2.mClipName, "Button.Bg", 14, v32 - 20)
		end)
	end

	v3:RunForAllVisibleElements(function(p2)
		mMovie:__wf_atom_4c1c1986(p2.mClipName, "Button.Btn", 14, v32 - 20)
	end)
	rounded = 0

	if v14 == "Top" then
		rounded = mMovie:__wf_atom_54eeda24() * 0.05 + 86
		mMovie:__wf_atom_3d3e910b(1)
	elseif v14 == "Middle" then
		rounded = module.Round((mMovie:__wf_atom_54eeda24() - v45) / 2)
		mMovie:__wf_atom_3d3e910b(4)
	elseif v14 == "Bottom" then
		rounded = mMovie:__wf_atom_54eeda24() * 0.9 - v45
		mMovie:__wf_atom_3d3e910b(7)
	end

	local v46 = v4 + module.Ternary(v22, 6 - v44, 0)
	local v47 = v45 - 124 + v3.mForcedVerticalSeparation
	mMovie:__wf_atom_e57658c2("Container.BgFill", 1, v46)
	mMovie:__wf_atom_e57658c2("Container.BgFill", 15, v47)
	mMovie:__wf_atom_e57658c2("Container.Blurer", 1, v46)
	mMovie:__wf_atom_e57658c2("Container.Blurer", 15, v47)
	local v48 = v32 + module.Ternary(v3:GetHowManyElements() > v3.mVisibleElements, 15, 0)

	if v24 == nil then
		mMovie:__wf_atom_e57658c2("Container", 0, mMovie:__wf_atom_97cd8326() * 0.5)
	else
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Container", 5)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Container", 6)
		local v49 = (v46 - mMovie:__wf_atom_5e6e15c8("Container.Title", 1) + 6) * (__wf_atom_5e6e15c8_2 / 100)
		local v50 = mMovie:__wf_atom_5e6e15c8("Container", 14) / 2 - 14 * (__wf_atom_5e6e15c8 / 100)

		if v24.y - v49 + (v45 - 68) * (__wf_atom_5e6e15c8_2 / 100) > mMovie:__wf_atom_54eeda24() then
			rounded = v24.y - v49 - (v45 - 86) * (__wf_atom_5e6e15c8_2 / 100)
		else
			rounded = v24.y - v49
		end

		if v24.x + v50 * (__wf_atom_5e6e15c8 / 100) > mMovie:__wf_atom_97cd8326() then
			mMovie:__wf_atom_e57658c2("Container", 0, v24.x + v50 - v48 * (__wf_atom_5e6e15c8 / 100))
		else
			mMovie:__wf_atom_e57658c2("Container", 0, v24.x + v50)
		end
	end

	mMovie:__wf_atom_e57658c2("Container", 1, rounded + v44)
	mMovie:__wf_atom_2dedec1a("Container.Message", 13, v3:GetHowManyElements() == 0)

	if _T.GenericMenu_IdToSelect ~= nil then
		genericMenu_IdToSelect = _T.GenericMenu_IdToSelect
		_T.GenericMenu_IdToSelect = nil
	end

	if genericMenu_IdToSelect ~= nil then
		local v49 = __wf_atom_421b01aa(genericMenu_IdToSelect, 1, v3:GetHowManyElements())
		v3:FocusElement(v49)
	end

	v3:Redraw(nil, true, p)

	if v33 then
		v33:TryPressed(true)
	end

	if p then
		mMovie:__wf_atom_e57658c2("_root", 12, 100)
		flag = false
	else
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, v28, 0, function()
			flag = false
		end)
	end
end

function Initialize()
	local module6 = require("Lotus.Interface.Libs.TimerMgr")
	v = module6.CreateTimerMgr()

	if __wf_atom_7e8ad928(_T.DialogOpenSound) then
		module.PlaySound(_G.UISound_WindowOpen)
	else
		local v39 = Resource(_T.DialogOpenSound)
		module.PlaySound(v39)
	end

	if not _T.UIInputEnabled then
		_T.EnableUIInput(_T.GenericMenu_HideMoneyOverlay)
		v38 = true
	end

	_T.GenericMenu_HideMoneyOverlay = nil
	v4 = mMovie:__wf_atom_5e6e15c8("Container.BgFill", 1)
	mMovie:__wf_atom_e57658c2("Container.ScrollBar", 1, 52)
	mMovie:__wf_atom_2dedec1a("Container.SearchBox", 13, false)
	v22 = _T.DialogueMode == true

	if v22 then
		v19 = -8
	end

	mMovie:__wf_atom_2dedec1a("Container.Underline", 13, v22)
	mMovie:OverrideMaterial("Container.BgFill", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_976dcedd("Container.BgFill", "noMenuSelection", true)
	mMovie:__wf_atom_976dcedd("MouseCatcher", "noMenuSelection", true)
	mMovie:SetCallbacks("MouseCatcher", nil, nil, nil, "MouseCatcherPressed")
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)

	if v22 then
		v17 = 100
	end

	fn9()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Container.Title", 49, "Arial Unicode MS")
	end

	mMovie:__wf_atom_50d60589("Container.Title", 36, "")
	local v39 = { function(p)
			mMovie:__wf_atom_0cf0fdbe(p * v27)
		end }
	__wf_atom_ec43d06e(mMovie, "_root", 0, v39, { 1 }, 0.2, 0, function()
		fn15()
	end)
	fn6()
	fn5()
	fn4()
	v2 = true
end

function RefreshMenu()
	if not v2 then
		return
	end

	local mCurrentElementIndex = v3.mCurrentElementIndex
	flag = true
	v3:RemoveElements(true, true)
	fn15(true, mCurrentElementIndex)
end

function SetTitle(p)
	v5 = p
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p, true)
	mMovie:__wf_atom_2dedec1a("Container.Underline", 13, v22 and v5 ~= nil)

	if v5 ~= nil and v6 then
		__wf_atom_8e9ac384 = TitleCase(__wf_atom_8e9ac384)
	end

	mMovie:__wf_atom_50d60589("Container.Title", 36, __wf_atom_8e9ac384)
end

function SetNoElementsMessage(p)
	mMovie:__wf_atom_50d60589("Container.Message", 46, "center")
	mMovie:__wf_atom_7d7314f1("Container.Message.text", p)
end

function SetElementsFunction(p)
	v8 = p
end

function SetCallBack(p)
	v9 = p
end

function EnableSearchBox()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
	local module6 = require("Lotus.Interface.Components.ThemedInputField")
	v33 = module6.Create(mMovie, "Container.SearchBox", nil, nil, "<MENU_LTHUMB>")
	v33:SetType(v33.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
	v33.mTextBuffer = 4
	v33.mAltButtonIcon = _G.UITexture_Search
	v33.mAltButtonVisible = true
	v33.mUnfocusedUnderlineColorOverride = nil
	v33.BaseInputFieldTextChanged = v33.InputFieldTextChanged

	function v33:InputFieldTextChanged(p)
		local mLabel = self.mLabel
		self:BaseInputFieldTextChanged(p)
		local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

		if self.mAltButtonicon ~= uiTexture_Search then
			self.mAltButtonicon = uiTexture_Search
			self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
		end

		if mLabel ~= self.mLabel and not __wf_atom_7e8ad928(v3) then
			fn14(mLabel)
		end
	end

	v33.BaseOnGamepadTransition = v33.OnGamepadTransition

	function v33:OnGamepadTransition()
		self:BaseOnGamepadTransition()
		local mAltButtonVisible = not Engine.IsPlayingWithController()
		self.mAltButtonVisible = mAltButtonVisible
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
	end

	v33:SetHint("/Lotus/Language/Menu/SearchPrompt")
end

function SetSecondaryCallBack(p)
	v10 = p
end

function Close()
	fn2()
end

function ExitScreen()
	fn3()
end

function FinishSelection()
	fn8()
end

function onKeyUp_MENU_SELECT()
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		if __wf_atom_7e8ad928(v33) or mMovie:__wf_atom_94bf489f() ~= "Label" or not (v3:GetHowManyElements() > 0) then
			v3:SelectCurrentElement()
		else
			v3:SelectElement(1, true)
		end
	end

	return true
end

function onViewportSizeChanged(_, _)
	fn4()
end

function MenuEntryFocused(p)
	if not __wf_atom_7e8ad928(v3) then
		v3:FocusElementById((tonumber(p)))
	end
end

function MenuEntryUnfocused(p)
	if not __wf_atom_7e8ad928(v3) then
		v3:UnfocusElementById((tonumber(p)))
	end
end

function MenuEntryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v3)) then
		v3:SelectElementById(tonumber(p), true)
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	if v21 or v23 then
		fn2()
	end

	return true
end

function RollOver()
	module.PlaySound(_G.UISound_Focus)
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (flag or __wf_atom_7e8ad928(v3.mScrollBar)) then
		v3.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyUp_MENU_RIGHT_CLICK()
	if not __wf_atom_7e8ad928(v10) and not __wf_atom_7e8ad928(_T[v10]) and (not v25 or #v11 == 0) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
		_T[v10](__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2)
	end
end

function IsInputBlocked()
	return flag
end

function SetTargetBackgroundAlpha(p)
	v27 = tonumber(p)
end

function SetTargetBluerAlpha(_) end

function SetAllowBackgroundExit(p)
	v23 = p == "true"
end

function SetInitTarget(p, p2, p3)
	v24 = { x = p, y = p2 }

	if p3 == "true" then
		local v39 = math.max(
			100 + math.min(v3:GetHowManyElements(), v3.mVisibleElements) * v3.mForcedVerticalSeparation,
			50
		)
		local v40 = v32 + module.Ternary(v3:GetHowManyElements() > v3.mVisibleElements, 15, 0)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Container", 5)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Container", 6)
		local v41 = (mMovie:__wf_atom_5e6e15c8("Container.BgFill", 1) - mMovie:__wf_atom_5e6e15c8("Container.Title", 1) + 6) * (__wf_atom_5e6e15c8_2 / 100)
		local v42 = mMovie:__wf_atom_5e6e15c8("Container", 14) / 2 - 14 * (__wf_atom_5e6e15c8 / 100)

		if v24.y - v41 + (v39 - 68) * (__wf_atom_5e6e15c8_2 / 100) > mMovie:__wf_atom_54eeda24() then
			rounded = v24.y - v41 - (v39 - 86) * (__wf_atom_5e6e15c8_2 / 100)
		else
			rounded = v24.y - v41
		end

		if v24.x + v42 * (__wf_atom_5e6e15c8 / 100) > mMovie:__wf_atom_97cd8326() then
			mMovie:__wf_atom_e57658c2("Container", 0, v24.x + v42 - v40 * (__wf_atom_5e6e15c8 / 100))
		else
			mMovie:__wf_atom_e57658c2("Container", 0, v24.x + v42)
		end

		mMovie:__wf_atom_e57658c2("Container", 1, rounded)
		v3:RemoveElements(true)
		fn15()
		v25 = false
	end
end

function SetMinWidth(p)
	v20 = tonumber(p)
end

function SetAlignment(p)
	v14 = p
end

function SetGetButtonsFunction(p)
	v15 = p
end

function SetOnElementSelectedFunction(p)
	v16 = p
end

function SetAllowExit(p)
	v21 = p == "true"
	fn6()
end

function SetScale(p)
	mMovie:__wf_atom_e57658c2("Container", 5, (tonumber(p)))
	mMovie:__wf_atom_e57658c2("Container", 6, (tonumber(p)))
end

function SetOnFocusedCallback(p)
	v34 = p
end

function SetOnUnfocusedCallback(p)
	v35 = p
end

function SetOnFocusedSound(p)
	v36 = Resource(p)
end

function SetOnSelectedSound(p)
	v37 = Resource(p)
end

function SetFadeTime(p, p2, p3)
	v28 = tonumber(p)

	if p2 ~= nil then
		v29 = tonumber(p2)
	end

	if p3 ~= nil then
		v30 = tonumber(p2)
	end
end

function SetInstantCallback(p)
	v31 = p == "true"
end

function SetTitleCaseText(p, p2)
	v7 = p == "true"

	if p2 ~= "true" then
		v6 = v7
	end
end

function MouseCatcherPressed(_)
	if v23 and not v25 then
		fn2()
	end
end

function SupportsThemes()
	return true
end

function OnStyleChangedCallback()
	fn5()
end

function OnGamepadTransition(_)
	v18 = 0
	v3:Redraw()
end

function CallbackCompleted() end