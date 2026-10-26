module(..., package.seeall)
require("Lotus.Interface.UIStyleUtilities")
local module = require("SF.Interface.Libs.UIUtilities")

function CreateGrid(p, p2, mPaginationClip, mColumns, mRows)
	local module2 = require("EE.Interface.Components.List")
	local list = module2.CreateList(p, p2)
	list.mColumns = mColumns
	list.mRows = mRows
	list.mVisibleElements = math.ceil(list.mColumns) * math.ceil(list.mRows)
	list.mPaginationClip = mPaginationClip
	list.mColumnSeparation = 100
	list.mRowSeparation = 100
	return InitGrid(list, p2)
end

function InitGrid(state, p)
	local mShowLabels

	if __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		mShowLabels = false
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		mShowLabels = not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:Settings():__wf_atom_2e306518()
	end

	state.mShowLabels = mShowLabels
	state.mPrefix = "Grid(" .. p .. ")::"
	state.mSelectPaginationCallback = "SelectPage"
	state.mRollOverPaginationCallback = "RollOverPage"
	state.mRollOutPaginationCallback = "RollOutPage"
	state.mHowManyPages = 0
	state.mEnabledPaginationColor = 1544676
	state.mHighlightedPaginationColor = 16777215
	state.mScroll = 1
	state.mPaginationLimit = 0
	state.mPaginationAlignment = state.UTIL.CENTER_ALIGNED
	state.mPaginationDeltaX = 100
	state.mPaginationDeltaY = 100
	state.PREVIOUS_PAGE_ID = -5
	state.NEXT_PAGE_ID = -10
	state.FIRST_PAGE_ID = -15
	state.LAST_PAGE_ID = -20
	state.mElementDelayTime = 0.02
	state.mExtraRowScroll = 0
	state.mRowScrollOffset = 0
	state.mSmoothScrollExtraSpace = 10
	state.mHighlightAlphaFocusedOverride = nil
	state.mHighlightAlphaSelectedOverride = nil
	state.mUseCornerForSelected = false
	state.mSkipRefocusOnScrollRedraw = false

	if not __wf_atom_7e8ad928(state.mPaginationClip) then
		local __wf_atom_cfc41e35 = state.mMovie:__wf_atom_cfc41e35(state.mPaginationClip, "PreviousPage.Label", 40)
		state.mMovie:__wf_atom_4c1c1986(state.mPaginationClip, "PreviousPage.Btn", 14, __wf_atom_cfc41e35)
		state.mMovie:__wf_atom_c0d7a318(state.mPaginationClip, "PreviousPage", "Id", state.PREVIOUS_PAGE_ID)
		local __wf_atom_cfc41e35_2 = state.mMovie:__wf_atom_cfc41e35(state.mPaginationClip, "NextPage.Label", 40)
		state.mMovie:__wf_atom_4c1c1986(state.mPaginationClip, "NextPage.Btn", 14, __wf_atom_cfc41e35_2)
		state.mMovie:__wf_atom_c0d7a318(state.mPaginationClip, "NextPage", "Id", state.NEXT_PAGE_ID)
		__wf_atom_86cbd68d(state.mMovie, state.mPaginationClip .. ".PreviousPage.duplicateMovieClip", "FirstPage", -1)
		state.mMovie:__wf_atom_7d7314f1(
			state.mPaginationClip .. ".FirstPage.Label.text",
			"/Lotus/Language/Menu/Grid_FirstPage"
		)
		local __wf_atom_cfc41e35_3 = state.mMovie:__wf_atom_cfc41e35(state.mPaginationClip, "FirstPage.Label", 40)
		state.mMovie:__wf_atom_4c1c1986(state.mPaginationClip, "FirstPage.Btn", 14, __wf_atom_cfc41e35_3)
		state.mMovie:__wf_atom_c0d7a318(state.mPaginationClip, "FirstPage", "Id", state.FIRST_PAGE_ID)
		__wf_atom_86cbd68d(state.mMovie, state.mPaginationClip .. ".NextPage.duplicateMovieClip", "LastPage", -2)
		state.mMovie:__wf_atom_7d7314f1(
			state.mPaginationClip .. ".LastPage.Label.text",
			"/Lotus/Language/Menu/Grid_LastPage"
		)
		local __wf_atom_cfc41e35_4 = state.mMovie:__wf_atom_cfc41e35(state.mPaginationClip, "LastPage.Label", 40)
		state.mMovie:__wf_atom_4c1c1986(state.mPaginationClip, "LastPage.Btn", 14, __wf_atom_cfc41e35_4)
		state.mMovie:__wf_atom_c0d7a318(state.mPaginationClip, "LastPage", "Id", state.LAST_PAGE_ID)
	end

	function state:GetHowManyElementsInCurrentPage()
		return (math.min(
			self:GetHowManyElements() - self:GetScroll() + 1 + self.mColumns * self.mExtraRowScroll,
			self.mRows * self.mColumns
		))
	end

	function state:GetElementColumn(p2)
		local mIndex = p2.mIndex

		if mIndex == nil then
			mIndex = self:GetElementIndexById(p2.Id)
		end

		return (mIndex - math.floor((self:GetScroll()))) % math.floor(self.mColumns) + 1
	end

	function state:GetElementRow(p2)
		local mIndex = p2.mIndex

		if mIndex == nil then
			mIndex = self:GetElementIndexById(p2.Id)
		end

		return math.floor((mIndex - math.floor((self:GetScroll()))) / math.floor(self.mColumns)) + 1
	end

	function state.GetElementInPosition(object, p2, p3)
		if p2 <= object.mRows and p3 <= object.mColumns then
			return (object:GetElementInIndex(math.floor((object:GetScroll())) + (p2 - 1) * object.mColumns + p3 - 1))
		end

		return nil
	end

	function state:CalculateX(p2)
		return (self.UTIL.Round(self.mInitialX + (self:GetElementColumn(p2) - 1) * self.mColumnSeparation))
	end

	function state:CalculateY(p2)
		local v = self.mInitialY + (self:GetElementRow(p2) - 1) * self.mRowSeparation

		if self.mSmoothScroll then
			v -= self.UTIL.Round(self:GetScroll() % 1 * self.mRowSeparation)
		end

		return (self.UTIL.Round(v))
	end

	state._Redraw = state.Redraw

	function state:Redraw(p2, p3, p4)
		self:_Redraw(p2, p3, p4)
		self:RedrawPagination()

		if not __wf_atom_7e8ad928(self.mPaginationClip) then
			self:FocusPageById(self:GetCurrentPage())
		end
	end

	function state:SetPaginationCallbacks(mSelectPaginationCallback, mRollOverPaginationCallback, mRollOutPaginationCallback)
		self.mSelectPaginationCallback = mSelectPaginationCallback
		self.mRollOverPaginationCallback = mRollOverPaginationCallback
		self.mRollOutPaginationCallback = mRollOutPaginationCallback
		self:RedrawPagination()
	end

	function state:SetPaginationCallbacksInClip(p2)
		if not __wf_atom_7e8ad928(self.mSelectPaginationCallback) then
			self.mMovie:__wf_atom_976dcedd(p2, "SelectCallback", self.mSelectPaginationCallback)
		end

		if not __wf_atom_7e8ad928(self.mRollOverPaginationCallback) then
			self.mMovie:__wf_atom_976dcedd(p2, "RollOverCallback", self.mRollOverPaginationCallback)
		end

		if not __wf_atom_7e8ad928(self.mRollOutPaginationCallback) then
			self.mMovie:__wf_atom_976dcedd(p2, "RollOutCallback", self.mRollOutPaginationCallback)
		end
	end

	function state:RedrawPagination()
		if not __wf_atom_7e8ad928(self.mPaginationClip) then
			local ternary = self.UTIL.Ternary(
				self.mVisibleElements <= 0,
				0,
				(math.ceil(#self.mElements / self.mVisibleElements))
			)
			self.mMovie:__wf_atom_2dedec1a(self.mPaginationClip, 13, ternary > 1)

			if ternary < 1 then
				return
			end

			local currentPage = self:GetCurrentPage()
			state.mMovie:__wf_atom_7d7314f1(
				state.mPaginationClip .. ".PreviousPage.Label.text",
				"/Lotus/Language/Menu/Grid_PreviousPage"
			)
			state.mMovie:__wf_atom_7d7314f1(
				state.mPaginationClip .. ".NextPage.Label.text",
				"/Lotus/Language/Menu/Grid_NextPage"
			)
			local v = self.mMovie:__wf_atom_cfc41e35(self.mPaginationClip, "FirstPage.Label", 40) + 10
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "PreviousPage", 0, v)
			local v2 = self.mMovie:__wf_atom_cfc41e35(self.mPaginationClip, "PreviousPage", 0) + self.mMovie:__wf_atom_cfc41e35(
				self.mPaginationClip,
				"PreviousPage.Label",
				40
			)
			local v3

			if self.mPaginationLimit > 0 then
				v3 = self.mPaginationLimit <= currentPage
			else
				v3 = false
			end

			local ternary2 = self.UTIL.Ternary(v3, 100, 20)
			self.mMovie:__wf_atom_7f57ab2f(self.mPaginationClip, "FirstPage.Btn", 67, v3)
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "FirstPage", 12, ternary2)
			self:SetPaginationCallbacksInClip(self.mPaginationClip .. ".FirstPage")

			if ternary > 1 then
				for i = 1, ternary do
					local v4 = self.mPaginationClip .. ".Page" .. i

					if not self.mMovie:__wf_atom_253d7085(v4) then
						local v5 = StringSplit(".", v4)
						__wf_atom_86cbd68d(self.mMovie, self.mPaginationClip .. ".Page1.duplicateMovieClip", v5[#v5], i)
					end

					local v5

					if self.mPaginationLimit > 0 then
						local v6 = math.floor(currentPage / self.mPaginationLimit) * self.mPaginationLimit
						local v7 = v6 + self.mPaginationLimit

						if v6 <= i then
							v5 = i < v7
						else
							v5 = false
						end
					else
						v5 = true
					end

					if v5 then
						v2 += 20
					end

					self.mMovie:__wf_atom_2dedec1a(v4, 13, v5)
					self.mMovie:__wf_atom_e57658c2(v4, 0, v2)
					self.mMovie:__wf_atom_50d60589(v4 .. ".Label", 36, i)
					self.mMovie:__wf_atom_e57658c2(v4, 12, self.UTIL.Ternary(currentPage == i, 90, 100))
					self.mMovie:__wf_atom_7f57ab2f(v4, "Btn", 67, currentPage ~= i)
					self.mMovie:__wf_atom_976dcedd(v4, "Id", i)
					self:SetPaginationCallbacksInClip(v4)

					if currentPage ~= i then
						self:UnfocusPageById(i)
					end
				end
			end

			self:FocusPageById(currentPage)
			local v4 = v2 + 20
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "NextPage", 0, v4)
			local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(self.mPaginationClip .. ".NextPage.Label", 40)
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "LastPage", 0, v4 + __wf_atom_5e6e15c8 + 10)
			local v5 = v4 + self.mMovie:__wf_atom_cfc41e35(self.mPaginationClip, "NextPage.Label", 40)
			local v6 = 0

			if self.mPaginationAlignment == self.UTIL.LEFT_ALIGNED then
				v6 = self.mInitialX - self.mPaginationDeltaX
			elseif self.mPaginationAlignment == self.UTIL.CENTER_ALIGNED then
				local v7 = self.mColumnSeparation * (self.mColumns - 1)
				v6 = self.mInitialX + self.UTIL.Round(v7 / 2) - self.UTIL.Round(v5 / 2) - self.mPaginationDeltaX
			elseif self.mPaginationAlignment == self.UTIL.RIGHT_ALIGNED then
				v6 = self.mInitialX + self.UTIL.Round(self.mColumnSeparation * (self.mColumns - 1)) - v5 + self.mPaginationDeltaX
			end

			self.mMovie:__wf_atom_e57658c2(self.mPaginationClip, 0, v6)
			self.mMovie:__wf_atom_e57658c2(
				self.mPaginationClip,
				1,
				self.mInitialY + self.mRowSeparation * (self.mRows - 1) + self.mPaginationDeltaY
			)

			for i = ternary + 1, self.mHowManyPages do
				local v7 = self.mPaginationClip .. ".Page" .. i

				if i > 1 then
					__wf_atom_86cbd68d(self.mMovie, v7 .. ".removeMovieClip")
				end
			end

			self.mHowManyPages = ternary
			local v7 = currentPage > 1
			self.mMovie:__wf_atom_7f57ab2f(self.mPaginationClip, "PreviousPage.Btn", 67, v7)
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "PreviousPage", 12, self.UTIL.Ternary(v7, 100, 20))
			self:SetPaginationCallbacksInClip(self.mPaginationClip .. ".PreviousPage")
			local v8 = currentPage < self.mHowManyPages
			self.mMovie:__wf_atom_7f57ab2f(self.mPaginationClip, "NextPage.Btn", 67, v8)
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "NextPage", 12, self.UTIL.Ternary(v8, 100, 20))
			self:SetPaginationCallbacksInClip(self.mPaginationClip .. ".NextPage")
			local v9

			if self.mPaginationLimit > 0 and self.mHowManyPages > self.mPaginationLimit then
				v9 = currentPage < self.mHowManyPages
			else
				v9 = false
			end

			local ternary3 = self.UTIL.Ternary(v9, 100, 20)
			self.mMovie:__wf_atom_7f57ab2f(self.mPaginationClip, "LastPage.Btn", 67, v9)
			self.mMovie:__wf_atom_4c1c1986(self.mPaginationClip, "LastPage", 12, ternary3)
			self:SetPaginationCallbacksInClip(self.mPaginationClip .. ".LastPage")
		end
	end

	function state:GetCurrentPage(_)
		if self.mVisibleElements <= 0 then
			return 1
		end

		return (math.ceil(self:GetScroll() / self.mVisibleElements))
	end

	function state:SetCurrentPage(mHowManyPages, p2)
		assert(false)

		if mHowManyPages == self.PREVIOUS_PAGE_ID then
			mHowManyPages = self:GetCurrentPage() - 1
		elseif mHowManyPages == self.NEXT_PAGE_ID then
			mHowManyPages = self:GetCurrentPage() + 1
		elseif mHowManyPages == self.FIRST_PAGE_ID then
			mHowManyPages = 0
		elseif mHowManyPages == self.LAST_PAGE_ID then
			mHowManyPages = self.mHowManyPages
		end

		local v = __wf_atom_421b01aa((mHowManyPages - 1) * self.mVisibleElements + 1, 1, #self.mElements)

		if self:GetScroll() ~= v then
			if self.mElementTransitionTime == 0 then
				self:SetScroll(v, true)
				self:TransitionOut(function()
					self:Redraw(p2)
				end)
			else
				self:TransitionOut(function()
					self:Redraw(p2)
				end)
				self:SetScroll(v, true)
			end
		end
	end

	function state:GetClipNameForPageId(p2)
		local v = self.mPaginationClip .. ".Page" .. p2

		if p2 == self.PREVIOUS_PAGE_ID then
			return self.mPaginationClip .. ".PreviousPage"
		end

		if p2 == self.NEXT_PAGE_ID then
			return self.mPaginationClip .. ".NextPage"
		end

		if p2 == self.LAST_PAGE_ID then
			return self.mPaginationClip .. ".LastPage"
		end

		if p2 == self.FIRST_PAGE_ID then
			return self.mPaginationClip .. ".FirstPage"
		end

		return v
	end

	function state:UnfocusPageById(p2)
		print(self.mPrefix .. "UnfocusPageById(" .. tostring(p2) .. ")")

		if p2 ~= self:GetCurrentPage() then
			local clipNameForPageId = self:GetClipNameForPageId(p2)
			self.mMovie:__wf_atom_4c1c1986(clipNameForPageId, "Label", 44, self.mEnabledPaginationColor)
		end
	end

	function state:FocusPageById(p2)
		print(self.mPrefix .. "FocusPageById(" .. tostring(p2) .. ")")
		local clipNameForPageId = self:GetClipNameForPageId(p2)
		self.mMovie:__wf_atom_4c1c1986(clipNameForPageId, "Label", 44, self.mHighlightedPaginationColor)
	end

	function state:TransitionOut(p2)
		print(self.mPrefix .. "TransitionOut()")
		self:RunForAllElements(function(p3)
			p3.mInitialized = false
		end)
		local v = math.min(#self.mElements, self:GetScroll() + self.mVisibleElements - 1)

		for i = self:GetScroll(), v do
			__wf_atom_ec43d06e(
				self.mMovie,
				self.mElements[i].mClipName,
				7,
				{ 12 },
				{ 0 },
				self.mElementTransitionTime,
				0,
				self.UTIL.Ternary(i == self:GetScroll(), p2, nil)
			)
		end
	end

	state._Remove = state.Remove

	function state.Remove(object)
		object:_Remove()

		for i = 2, object.mHowManyPages do
			__wf_atom_86cbd68d(object.mMovie, object.mPaginationClip .. ".Page" .. i .. ".removeMovieClip")
		end
	end

	state.ToggleFocusedElement = nil
	state.FocusNextElement = nil
	state.FocusPreviousElement = nil

	function state.ConvertDirectionIntoString(data, p2)
		if p2 == data.UP then
			return "UP"
		end

		if p2 == data.RIGHT then
			return "RIGHT"
		end

		if p2 == data.DOWN then
			return "DOWN"
		end

		if p2 == data.LEFT then
			return "LEFT"
		end

		return "Unknown!!!"
	end

	function state.UpdateColors(p2, p3, p4, p5, p6)
		module.UpdateGridItemColors(p2, p3, p4, p5, p6)
	end

	state._OnUnfocused = state.OnUnfocused

	function state.OnUnfocused(object, p2)
		object:_OnUnfocused(p2)
	end

	state._OnFocused = state.OnFocused

	function state.OnFocused(object, p2)
		object:_OnFocused(p2)
	end

	state._FocusElement = state.FocusElement

	function state:FocusElement(p2)
		self:_FocusElement(p2, true)
	end

	function state:FocusElementInDirection(p2, p3)
		if __wf_atom_7e8ad928(self.mCurrentElementIndex) then
			self:FocusElement((math.floor((self:GetScroll()))))
			return
		end

		if not self.mSmoothScroll then
			local focusedElement = self:GetFocusedElement()

			if focusedElement and self.mScrollBar then
				local elementRow = self:GetElementRow(focusedElement)

				if p2 == self.DOWN and self.mRows <= elementRow and self.mScrollBar:GetScrollValue() < 1 then
					self.mScrollBar:ScrollDown()
				elseif p2 == self.UP and elementRow <= 1 and self.mScrollBar:GetScrollValue() > 0 then
					self.mScrollBar:ScrollUp()
				end
			end
		end

		local elementInIndex = self:GetElementInIndex(self.mCurrentElementIndex)

		if __wf_atom_7e8ad928(elementInIndex) then
			return
		end

		local elementColumn = self:GetElementColumn(elementInIndex)
		local elementRow = self:GetElementRow(elementInIndex)

		if self.mSmoothScroll then
			elementRow = math.ceil(self.mCurrentElementIndex / self.mColumns)
		end

		local v, v2

		if p2 == self.UP or p2 == self.DOWN then
			local ternary = self.UTIL.Ternary(p2 == self.UP, self.UTIL.DECREMENT, self.UTIL.INCREMENT)
			local mRows = self.mRows
			local howManyElementsInCurrentPage = self:GetHowManyElementsInCurrentPage()

			if howManyElementsInCurrentPage < self.mRows * self.mColumns then
				mRows = math.floor(howManyElementsInCurrentPage / self.mColumns)

				if elementColumn <= howManyElementsInCurrentPage - mRows * self.mColumns then
					mRows += 1
				end
			end

			if self.mSmoothScroll then
				mRows = math.ceil(self:GetHowManyElements() / self.mColumns)
			end

			if self.mWrapAroundNavigation then
				v = self.UTIL.ToggleValue(elementRow, ternary, 1, mRows)
			else
				v = __wf_atom_421b01aa(elementRow + ternary, 1, mRows)
			end

			v2 = elementColumn
		else
			if p2 == self.RIGHT or p2 == self.LEFT then
				local ternary = self.UTIL.Ternary(p2 == self.LEFT, self.UTIL.DECREMENT, self.UTIL.INCREMENT)
				local mColumns = self.mColumns
				local howManyElementsInCurrentPage = self:GetHowManyElementsInCurrentPage()

				if howManyElementsInCurrentPage < self.mRows * self.mColumns then
					local v3 = math.floor(howManyElementsInCurrentPage / self.mColumns)

					if self.mSmoothScroll then
						v3 = math.ceil(self:GetHowManyElements() / self.mColumns)
					end

					local v4 = v3 < elementRow

					if self.mSmoothScroll then
						v4 = elementRow == v3
					end

					if v4 and howManyElementsInCurrentPage % self.mColumns ~= 0 then
						mColumns = howManyElementsInCurrentPage % self.mColumns
					end
				end

				if self.mWrapAroundNavigation then
					v2 = self.UTIL.ToggleValue(elementColumn, ternary, 1, mColumns)
				else
					v2 = __wf_atom_421b01aa(elementColumn + ternary, 1, mColumns)
				end
			else
				v2 = elementColumn
			end

			v = elementRow
		end

		if v ~= elementRow or v2 ~= elementColumn then
			local v3 = (v - 1) * self.mColumns + (v2 - 1)
			print("currentRow -> " .. tostring(elementRow) .. " newRow->" .. tostring(v) .. " newId->" .. tostring(v3))
			local v4

			if self.mSmoothScroll then
				v4 = v3 + 1
			else
				v4 = v3 + self:GetScroll()
			end

			local elementById = self:GetElementById(v4)

			if p3 and not __wf_atom_7e8ad928(elementById) and elementById.Filler then
				return
			end

			if self.mSmoothScroll and v ~= elementRow then
				local v5 = math.floor((self:GetClampedScroll(self:CalculateRawScroll((self.mScrollBar:GetTargetScrollValue()))))) + math.max(
					0,
					self.UTIL.Round(self.mRows / 2) - 1 + self.mRowScrollOffset
				) * self.mColumns
				local v6 = v5 + self.mColumns

				if v4 < v5 and v < elementRow or v6 <= v4 and elementRow < v then
					self.mScrollBar:ScrollBy(self.mScrollBar.mScrollStep * (v - elementRow))
				end
			end

			self:FocusElement(v4)
		end
	end

	function state:GetClampedScroll(p2)
		local v = math.max(
			(math.ceil(#self.mElements / self.mColumns) + self.mExtraRowScroll - self.mRows) * self.mColumns + 1,
			1
		)
		return __wf_atom_421b01aa(p2, 1, v)
	end

	function state:SetScroll(p2, p3)
		self.mScroll = self:GetClampedScroll(p2)

		if not p3 then
			self:Redraw()
		end
	end

	function state:CalculateScrollBarHeight(value)
		if self.Height == nil then
			return self.mRows * self.mRowSeparation + (value or 0)
		end

		return self.Height
	end

	function state:CalculateRawScroll(p2)
		local howManyElements = self:GetHowManyElements()
		local mRows = self.mRows
		local v = math.ceil(howManyElements / self.mColumns) + self.mExtraRowScroll - mRows
		local v2 = __wf_atom_421b01aa(self.UTIL.Round(v * p2, 3), 0, v)
		local v3 = v2 % 1
		return math.floor(v2) * self.mColumns + 1 + v3
	end

	state._ScrollValueChangedCallback = state.ScrollValueChangedCallback

	function state:ScrollValueChangedCallback(p2, _)
		if self.mSmoothScroll then
			local rawScroll = self:CalculateRawScroll(p2)

			if rawScroll ~= self:GetScroll() then
				local v = math.floor(rawScroll) - math.floor((self:GetScroll()))
				self:SetScroll(rawScroll, true)

				if v >= 1 or v <= -1 then
					local focusedElementIndex = self:GetFocusedElementIndex()

					if self.mSmoothScroll and not self.mSkipRefocusOnScrollRedraw then
						self:UnfocusElement(focusedElementIndex)
					end

					if not self.mDisableRedraw then
						self.mRedrawFromScrollBar = true
						self:Redraw(nil, false, true)
					end

					if self.mSmoothScroll and not self.mSkipRefocusOnScrollRedraw then
						self:FocusElement(focusedElementIndex)
					end
				end

				self:RunForAllVisibleElements(function(p3)
					self.mMovie:__wf_atom_e57658c2(p3.mClipName, 0, self:CalculateX(p3))
					self.mMovie:__wf_atom_e57658c2(p3.mClipName, 1, self:CalculateY(p3))
					self:RepositionButton(p3)
				end)
			end
		else
			local howManyElements = self:GetHowManyElements()
			local mRows = self.mRows
			local v = math.ceil(howManyElements / self.mColumns) + self.mExtraRowScroll - mRows
			local v2 = self.UTIL.Round(v * p2) * self.mColumns + 1

			if v2 ~= self:GetScroll() then
				self:SetScroll(v2, true)

				if not self.mDisableScrollRedraw then
					self.mRedrawFromScrollBar = true
					self:Redraw(nil, false, true)
				end

				self:RunForAllVisibleElements(function(p3)
					self.mMovie:__wf_atom_e57658c2(p3.mClipName, 0, self:CalculateX(p3))
					self.mMovie:__wf_atom_e57658c2(p3.mClipName, 1, self:CalculateY(p3))
					self:RepositionButton(p3)
				end)
			end
		end
	end

	state._RedrawScrollBar = state.RedrawScrollBar

	function state:RedrawScrollBar()
		if self.mScrollBarClipName ~= nil and self.mScrollBar ~= nil and not self.mScrollBar.mDragging then
			local v = math.ceil(self:GetHowManyElements() / self.mColumns) + self.mExtraRowScroll
			local mRows = self.mRows
			local v2

			if mRows < v then
				v2 = self:CanUseScrollBar()
			else
				v2 = false
			end

			self.mMovie:__wf_atom_2dedec1a(self.mScrollBarClipName, 13, v2 or self.mScrollAlwaysVisible)
			self.mMovie:__wf_atom_7f57ab2f(self.mScrollBarClipName, "Scrub", 13, v2)
			self.mScrollBar:SetEnabled(v2)

			if v2 or self.mScrollAlwaysVisible then
				local v3 = v - mRows
				self.mScrollBar.mVisibleProp = not (v > 0) and 1 or mRows / v
				self.mScrollBar.mCurrentScroll = v3 == 0 and 0 or (self:GetScroll() - 1) / (v3 * self.mColumns)
				self.mScrollBar:SetHeight(self:CalculateScrollBarHeight(self.mDeltaScrollBarSize), false, true)
				self.mScrollBar.mScrollStep = v3 == 0 and 0 or 1 / (v - mRows)
			end
		end
	end

	function state:ScrollToElement(p2, p3, p4)
		if self.mSmoothScroll and not __wf_atom_7e8ad928(self:GetScroll()) then
			local elementInIndex = self:GetElementInIndex(p2)

			if elementInIndex == nil then
				return
			end

			local elementRow = self:GetElementRow(elementInIndex)
			self.mScrollBar:SetScrollValue((elementRow - self.mRows) * self.mScrollBar.mScrollStep, false, p3)
		end

		if not p4 then
			self:FocusElement(p2)
		end
	end

	function state:EnableSmoothScroll()
		if self:GetScroll() == nil or self.mRowSeparation == nil then
			print("Error: Smooth scroll dependencies failed!")
			assert(false)
		else
			self.mVisibleElements = math.ceil(self.mColumns) * math.ceil(self.mRows)
			self.mSmoothScroll = true
			self.mScrollBar.mEnableSmoothScroll = true
		end
	end

	state.List_GetBounds = state.GetBounds

	function state.GetBounds(object)
		local list_GetBounds, v = object:List_GetBounds()

		if object:GetScroll() ~= nil and object.mSmoothScroll then
			v = v - 1 + object.mColumns

			if object.mExtraRowScroll ~= nil then
				v += object.mColumns * math.ceil(object.mExtraRowScroll)
			end
		end

		return list_GetBounds, v
	end

	function state:SetButtonPosDim(p2, p3, p4, p5, p6, p7)
		local v, v2

		if p4 < p3 + p6 * 0.5 then
			v = p6 + p4 - p3 - p6 * 0.5
			v2 = (-p6 + v) / 2
		elseif p3 - p6 * 0.5 < p5 then
			v = -(p5 - p3 - p6 * 0.5)
			v2 = (p6 - v) / 2
		else
			v = p6
			v2 = 0
		end

		local v3 = v == nil or v <= 0
		self.mMovie:__wf_atom_7f57ab2f(p2.mClipName, "Btn", 13, not v3)

		if not v3 then
			if p7 then
				self.mMovie:__wf_atom_4c1c1986(p2.mClipName, "Btn", 14, v)
				self.mMovie:__wf_atom_4c1c1986(p2.mClipName, "Btn", 0, v2)
			else
				self.mMovie:__wf_atom_4c1c1986(p2.mClipName, "Btn", 15, v)
				self.mMovie:__wf_atom_4c1c1986(p2.mClipName, "Btn", 1, v2)
			end

			self.mMovie:__wf_atom_c0d7a318(p2.mClipName, "Btn", "noMenuSelection", v < 10)
		end
	end

	function state:RepositionButton(p2)
		if self:GetScroll() ~= nil and self.mOriginalButtonHeight ~= nil and self.mSmoothScroll then
			local mSmoothScrollExtraSpace = self.mSmoothScrollExtraSpace

			if self.mSmoothScrollExtraSpaceBottom ~= nil then
				mSmoothScrollExtraSpace = self.mSmoothScrollExtraSpaceBottom
			end

			local v = self.mInitialY - self.mRowSeparation * 0.5 - self.mSmoothScrollExtraSpace
			local v2 = self.mInitialY + self.mRowSeparation * (self.mRows - 0.5 - self.mExtraRowScroll) + mSmoothScrollExtraSpace

			if self.mDebugScroll and p2.mIndex == 1 then
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.clear")
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.lineStyle", 1, 16711680, 100)
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.moveTo", 2000, v)
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.lineTo", 4000, v)
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.moveTo", 2000, v2)
				__wf_atom_86cbd68d(self.mMovie, "DebugMc.lineTo", 4000, v2)
			end

			self:SetButtonPosDim(p2, self:CalculateY(p2), v2, v, self.mOriginalButtonHeight)
		end
	end

	if Engine.__wf_atom_b6edc589() then
		state.List_EnableDragScrolling = state.EnableDragScrolling

		function state:EnableDragScrolling(p2)
			self:List_EnableDragScrolling(p2)

			function self.GetDragScrollIncrement(p3)
				return p3.mColumns
			end

			function self.GetMouseDragScrollStep(data)
				if __wf_atom_7e8ad928(data.mRowSeparation) then
					return (data.mMovie:__wf_atom_5e6e15c8(data.mClipName, 15))
				end

				return data.mRowSeparation
			end
		end
	end

	return state
end

function CreateNewGrid(p, p2, p3)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mMovie) then
		print("Grid created without valid env")
		return
	end

	local module2 = require("EE.Interface.Components.List")
	local newList = module2.CreateNewList(p, p2, p3)
	local v = InitGrid(newList, p2)

	function v:UpdateVisibleProp(mHeight, mScrollBar)
		local mRows = self.mRows
		local mColumns = math.ceil(self.mColumns)

		if mScrollBar == nil then
			mScrollBar = self.mScrollBar

			if mScrollBar == nil then
				return
			end
		end

		if mHeight == nil then
			mHeight = mScrollBar.mHeight
		end

		local v2 = mHeight - mScrollBar.mContentOffset * 2
		local mRowSeparation = self.mRowSeparation
		local v3 = 0

		if #self.mElements > 0 then
			local mElement = self.mElements[1]

			if mElement ~= nil then
				mRowSeparation = mElement.mHeight
					or mRowSeparation
					or self.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15)
				v3 = mRowSeparation * math.ceil(#self.mElements / mColumns)
			end
		end

		if mRowSeparation ~= nil then
			mRows = v2 / mRowSeparation
		end

		if v3 == 0 then
			mScrollBar.mVisibleProp = 1
		else
			mScrollBar.mVisibleProp = __wf_atom_421b01aa(v2 / v3, 0, 1)
		end

		self.mRows = mRows
		self.mVisibleElements = math.ceil(mRows) * mColumns
	end

	function v:GetScrollRange()
		local v2 = 0

		if #self.mElements > 0 then
			local mScrollBar = self.mScrollBar

			if mScrollBar ~= nil then
				local mElement = self.mElements[1]

				if mElement ~= nil then
					local mHeight = mElement.mHeight
						or self.mRowSeparation
						or self.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15)
					return mScrollBar:GetScrollRange() / mHeight
				end
			end
		end

		return v2
	end

	function v:ScrollValueChangedCallback(p4, _)
		if self.mScrollBar ~= nil then
			local rawScroll = self:CalculateRawScroll(p4)

			if rawScroll ~= self.mScroll then
				local v2 = math.floor(rawScroll) - math.floor(self.mScroll)
				self:SetScroll(rawScroll, true)
				self:UpdateVisibleProp()

				if v2 >= 1 or v2 <= -1 then
					self.mRedrawFromScrollBar = true
					self:Redraw(nil, false, true)
				end

				self:RunForAllVisibleElements(function(p5)
					self.mMovie:__wf_atom_e57658c2(p5.mClipName, 1, self:CalculateY(p5))
					self:RepositionButton(p5)
				end)
			end
		end
	end

	v.RedrawScrollBar = v._RedrawScrollBar
	return v
end