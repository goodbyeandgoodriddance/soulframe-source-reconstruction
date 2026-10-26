module(..., package.seeall)

function CreateCategorizedGrid(object, p, p2, p3, mCategoryClipName, mSortClipName, mRootClip, mCategoryNameClipName, mDiegeticMode)
	local module = require("EE.Interface.Components.Grid")
	local grid = module.CreateGrid(object, p, nil, p2, p3)
	grid.mPrefix = "CategorizedGrid(" .. p .. ")::"
	grid.LOTUS_UTIL = require("Lotus.Interface.LotusUtilities")
	grid.UTIL = require("EE.Interface.Utilities")
	grid.mWrapAroundNavigation = false
	grid.mApplyThemes = true
	grid.mCategoryClipName = mCategoryClipName
	grid.mCategoryNameClipName = mCategoryNameClipName
	grid.mSortClipName = mSortClipName
	grid.mDepthDirection = 1
	grid.mUnfilteredElements = {}
	grid.mUnfilteredElementsTopId = 0
	grid.mCategoriesCount = {}
	grid.mForceHiddenCategories = {}
	grid.mUnfilteredCategories = {}
	grid.mUnfilteredCategoriesTopId = 0
	grid.mElementTransitionTime = 0.2
	grid.mElementDelayTime = 0.025
	grid.mCategoryMenu = nil
	grid.mScrollBarHorizontalOffset = 70
	grid.mSortMenuHorizontalOffset = -182
	grid.mSortMenuVerticalOffset = -146
	grid.mSkipRefocusOnScrollRedraw = true
	grid.mSelectedScale = 110
	grid.mSelectElementsOnFocus = true
	grid.mSwappedClip = nil
	grid.mRootClip = mRootClip
	grid.mAddFillerElements = true
	grid.mDiegeticMode = mDiegeticMode
	grid.mDebugScroll = false
	grid.mNoSelectSounds = false
	grid.mQuickFilterAll = true
	grid.AdditionalFilterFunction = nil
	grid.mNonFillerElements = 0

	if not grid.mRootClip then
		grid.mRootClip = "_root"
	end

	if not grid.mCategoryNameClipName then
		grid.mCategoryNameClipName = "CategoryName"
	end

	function grid:Print(_) end

	function grid:SetSearchRankOnAllElements(p4)
		local v = __wf_atom_d99ae0ec(p4)
		self:RunForAllElements(function(p5)
			p5.SearchRank = 0

			if p5.SearchCache ~= nil then
				local v2 = string.find(p5.SearchCache, v, 1, true)

				if v2 ~= nil then
					if string.find(p5.SearchCache, " ~~ ", v2, true) == nil then
						p5.SearchRank = 1
					else
						p5.SearchRank = 2
					end
				end
			end
		end)
	end

	function grid:ClearSearchRankOnAllElements()
		self:RunForAllElements(function(p4)
			p4.SearchRank = nil
		end)
	end

	function grid:AddCategoryCounts(list)
		for i = 1, #list do
			local v = list[i]

			if self.mCategoriesCount[v] == nil then
				self.mCategoriesCount[v] = 0
			end

			self.mCategoriesCount[v] = self.mCategoriesCount[v] + 1
		end
	end

	grid._CategorizedGrid_AddElement = grid.AddElement

	function grid:AddElement(state)
		if not state.Id then
			state.Id = self.mUnfilteredElementsTopId + 1
			self.mUnfilteredElementsTopId = state.Id
		end

		table.insert(self.mUnfilteredElements, state)

		if not state.Filler then
			self:AddCategoryCounts(state.Categories)
		end

		return state
	end

	grid._CategorizedGrid_FocusElement = grid.FocusElement

	function grid.FocusElement(p4, p5)
		if p4.mElements[p5] and not p4.mElements[p5].Filler then
			grid:_CategorizedGrid_FocusElement(p5)
		end
	end

	grid._CategorizedGrid_FocusElementInDirection = grid.FocusElementInDirection

	function grid.FocusElementInDirection(object2, p4)
		if object2:GetHowManyElements() == 0 then
			return
		end

		local focusedElement = object2:GetFocusedElement()

		if
			object2.mSelectElementsOnFocus
			and object2.mSelectedElement
			and (focusedElement == nil or focusedElement.Id ~= object2.mSelectedElement.Id)
		then
			object2:FocusElementById(object2.mSelectedElement.Id)
		end

		object2:_CategorizedGrid_FocusElementInDirection(p4)

		if
			(focusedElement == nil or focusedElement.Id ~= object2:GetFocusedElement().Id)
			and object2.mSelectElementsOnFocus
		then
			object2:SelectCurrentElement()
		end
	end

	function grid:GetFilterBy()
		return self.mFilterBy
	end

	function grid:Filter(p4)
		local filterBy = self:GetFilterBy()

		if
			filterBy ~= nil
			and (not self.mQuickFilterAll or filterBy ~= 0)
			and not self.UTIL.IsValueInTable(p4.Categories, filterBy)
		then
			return true
		end

		return self.AdditionalFilterFunction ~= nil and self.AdditionalFilterFunction(p4)
	end

	function grid:Sort(p4, p5)
		return p4[self.mSortBy] ~= nil and p5[self.mSortBy] ~= nil and p4[self.mSortBy] < p5[self.mSortBy]
	end

	function grid:DoubleSort(p4, p5)
		local _

		if p4[self.mSortBy] == nil or p5[self.mSortBy] == nil then
			_ = false
			return false
		end

		if p4[self.mSortBy] == p5[self.mSortBy] then
			return p4[self.mLastSortBy] < p5[self.mLastSortBy]
		end

		return p4[self.mSortBy] < p5[self.mSortBy]
	end

	function grid:DoubleSortWithFunction(p4, p5)
		if p4[self.mSortBy] == p5[self.mSortBy] then
			return (self.mLastSortBy(p4, p5))
		end

		return p4[self.mSortBy] < p5[self.mSortBy]
	end

	grid._CategorizedGrid_RemoveElements = grid.RemoveElements

	function grid:RemoveElements(p4, p5)
		grid:_CategorizedGrid_RemoveElements(p4, p5)
		self.mUnfilteredElements = {}
		self.mUnfilteredElementsTopId = 0
		self.mNonFillerElements = 0
		self.mCategoriesCount = {}
		self.mLastFilterBy = nil
	end

	function grid:OnPreSort() end

	function grid:OnFilteredElementsReady()
		if self.mAddFillerElements then
			local howManyElements = self:GetHowManyElements()
			local v = math.ceil(howManyElements / self.mColumns)
			local v2 = math.max(self.mRows * self.mColumns, v * self.mColumns)

			for _ = howManyElements + 1, v2 do
				self:_CategorizedGrid_AddElement({ Filler = true }, true)
			end
		end
	end

	grid._CategorizedGrid_Redraw = grid.Redraw

	function grid:Redraw(p4, p5, p6, p7, p8)
		local v = #self.mUnfilteredElements

		if
			self.mLastFilterBy ~= self:GetFilterBy()
			or self.mSortingChanged
			or p5
			or self:GetFilterBy() == nil and v ~= self.mNonFillerElements and not self.mRedrawFromScrollBar
		then
			__wf_atom_86cbd68d(self.mMovie, self.mClipName .. ".swapDepths", self.mInitialDepth)
			self:_CategorizedGrid_RemoveElements(true, true)
			self:OnPreSort()

			if self.mSortBy then
				if type(self.mSortBy) == "function" then
					table.sort(self.mUnfilteredElements, self.mSortBy)
				elseif self.mLastSortBy then
					if type(self.mLastSortBy) == "function" then
						table.sort(self.mUnfilteredElements, function(a, b)
							return (self:DoubleSortWithFunction(a, b))
						end)
					else
						table.sort(self.mUnfilteredElements, function(a, b)
							return (self:DoubleSort(a, b))
						end)
					end
				else
					table.sort(self.mUnfilteredElements, function(a, b)
						return (self:Sort(a, b))
					end)
				end
			end

			__wf_atom_83c14687(0)

			if
				not __wf_atom_7e8ad928(self.mCategoryMenu)
				and self.mCategoryMenu.mHideEmptyCategories
				and not (p7 or p8)
			then
				self.mCategoryMenu:RemoveElements(true, true)

				for i = 1, #self.mUnfilteredCategories do
					self.mUnfilteredCategories[i].mClipName = nil

					if not (self.mUnfilteredCategories[i].Category == 0 or self.UTIL.FindInTable(
						self.mForceHiddenCategories,
						self.mUnfilteredCategories[i].Category
					) == -1 and self.mCategoriesCount[self.mUnfilteredCategories[i].Category] ~= nil and self.mCategoriesCount[self.mUnfilteredCategories[i].Category] > 0) then
						continue
					end

					self.mUnfilteredCategories[i].mInitialized = false
					self.mCategoryMenu:AddElement(self.mUnfilteredCategories[i], true)
				end

				local filterBy = self:GetFilterBy()

				if self.mCategoryMenu.mPendingCategory ~= nil then
					filterBy = self.mCategoryMenu.mPendingCategory
				end

				if not self.mCategoryMenu:HasCategory(filterBy) then
					local elementInIndex = self.mCategoryMenu:GetElementInIndex(1)

					if __wf_atom_7e8ad928(elementInIndex) then
						filterBy = nil
					else
						filterBy = elementInIndex.Category
					end
				end

				if self.mCategoryMenu.mTryFitToGridWidth then
					self.mCategoryMenu:DrawCallouts()
					local howManyElements = self.mCategoryMenu:GetHowManyElements()
					local v2 = howManyElements * self.mCategoryMenu.mForcedHorizontalSeparation + self.UTIL.Ternary(
						self.mCategoryMenu.mVisibleCallouts,
						self.mCategoryMenu.mCalloutSeparation * 2,
						0
					)
					local v3 = self.Width + self.mCategoryMenu.mFitGridWidthPadding - self.UTIL.Ternary(
						self.mCategoryMenu.mFitGridWidthReduction ~= nil,
						self.mCategoryMenu.mFitGridWidthReduction,
						0
					)
					self.mCategoryMenu.mIsFitToGridWidth = v3 < v2

					if v3 < v2 then
						local v4 = self.Width + self.mCategoryMenu.mFitGridWidthPadding - self.UTIL.Ternary(
							self.mCategoryMenu.mVisibleCallouts,
							self.mCategoryMenu.mCalloutSeparation * 2,
							0
						)
						self.mCategoryMenu.mForceWidth = self.UTIL.Round(v4 / howManyElements, 1) - 3
					else
						self.mCategoryMenu.mForceWidth = nil
					end
				end

				if self.mCategoryMenu.mPendingCategory == nil then
					if filterBy ~= nil then
						self.mCategoryMenu.mQueueInstantReposition = true

						if filterBy == self:GetFilterBy() then
							self.mCategoryMenu:Redraw(nil, true, true)
						else
							self.mFilterBy = nil
						end

						self:SetCategory(filterBy)
					end
				else
					self:SetCategory(filterBy)
					self.mCategoryMenu.mPendingCategory = nil
				end
			end

			self.mLastFilterBy = self:GetFilterBy()
			self.mSortingChanged = false

			for i = 1, #self.mUnfilteredElements do
				__wf_atom_83c14687(0)
				self.mUnfilteredElements[i].mClipName = nil

				if not self:Filter(self.mUnfilteredElements[i]) then
					self:_CategorizedGrid_AddElement(self.mUnfilteredElements[i], true)
				end
			end

			self.mNonFillerElements = self:GetHowManyElements()
			self:OnFilteredElementsReady()
		end

		self:_CategorizedGrid_Redraw(p4, p5, p6)
		local v2 = self.mInitialX + (self.mColumns - 1) * self.mColumnSeparation
		local mInitialY = self.mInitialY

		if self.mSortMenu then
			if self.mSortMenu:GetHowManyElements() > 1 then
				if self.mSortMenu.mNewStyle then
					self.mSortMenu:SetVisible(true)
				else
					self.mMovie:__wf_atom_2dedec1a(self.mSortClipName, 13, true)
				end
			end

			if self.mSortMenuHorizontalOffset ~= nil then
				self.mMovie:__wf_atom_e57658c2(
					self.mSortMenu.mContainerClipName,
					0,
					v2 + self.mSortMenuHorizontalOffset
				)
			end

			if self.mSortMenuVerticalOffset ~= nil then
				self.mMovie:__wf_atom_e57658c2(
					self.mSortMenu.mContainerClipName,
					1,
					mInitialY + self.mSortMenuVerticalOffset
				)
			end
		end

		if self.mScrollBar and self.mScrollBarHorizontalOffset ~= nil then
			self.mMovie:__wf_atom_e57658c2(self.mScrollBar.mClipName, 0, v2 + self.mScrollBarHorizontalOffset)
		end
	end

	function grid.SetupPreInterpolationValues(p4, p5)
		p4.mMovie:__wf_atom_e57658c2(p5.mClipName, 5, 80)
		p4.mMovie:__wf_atom_e57658c2(p5.mClipName, 6, 80)
	end

	function grid.GetInterpolationProperties(data, p4)
		local v = data.mSelectedElement and p4.Id == data.mSelectedElement.Id
		local ternary = data.UTIL.Ternary(v, data.mSelectedScale, 100)
		return { 12, 5, 6 }, { 100, ternary, ternary }
	end

	function grid:AddCategory(p4)
		if self.mCategoryMenu then
			if self.mCategoryMenu.mHideEmptyCategories then
				if not p4.Id then
					p4.Id = self.mUnfilteredCategoriesTopId + 1
					self.mUnfilteredCategoriesTopId = p4.Id
				end

				table.insert(self.mUnfilteredCategories, p4)
			else
				self.mCategoryMenu:AddElement(p4, true)
			end
		end
	end

	function grid:SetCategory(mPendingCategory)
		if self.mCategoryMenu then
			if self.mCategoryMenu:GetHowManyElements() == 0 and self.mCategoryMenu.mHideEmptyCategories then
				self.mCategoryMenu.mPendingCategory = mPendingCategory
				return
			end

			local id = nil
			self.mCategoryMenu:RunForAllElements(function(p4)
				if p4.Category == mPendingCategory then
					id = p4.Id
				end
			end)

			if id then
				if self.mFilterBy == nil then
					self.mCategoryMenu:Redraw(nil, true, true)
				end

				self.mCategoryMenu:SelectElementById(id)
			end
		end
	end

	function grid:SetCategory_Internal(mFilterBy, callback, _)
		local v = self.mFilterBy == nil
		self.mFilterBy = mFilterBy

		if not v then
			self:SetScroll(1, true)
			self:Redraw(function()
				if callback then
					callback()
				end
			end, true, false, true)
		end
	end

	function grid.AddSortBy(p4, p5)
		if p4.mSortMenu then
			p4.mSortMenu:AddElement(p5)
		end
	end

	function grid.GetSortById(p4, _)
		if p4.mUserAssignedSortId then
			return p4.mUserAssignedSortId
		end

		local mSelectedElement = p4.mSortMenu and p4.mSortMenu.mSelectedElement

		if mSelectedElement then
			return mSelectedElement.SortId
		end

		return nil
	end

	function grid.SetSortBy(p4, p5, p6)
		if p4.mSortMenu then
			local id = nil
			p4.mSortMenu:RunForAllElements(function(data)
				if data.SortId == p5 or data.SortId == nil and data.Attribute == p5 then
					id = data.Id
				end
			end)

			if id then
				if p4.mSortBy == nil then
					p4.mSortMenu:Redraw(nil, true, true)
				end

				p4.mSortMenu:SelectElementById(id, not p6)
			end
		end
	end

	function grid:SetSortBy_Internal(p4, p5, p6)
		local attribute = p4.Attribute

		if self.mSortMenu ~= nil and self.mSortBy ~= attribute then
			local v = self.mSortBy == nil
			self.mSortingChanged = true
			self.mLastSortBy = self.mSortBy
			self.mSortBy = attribute

			if p6 then
				self.mUserAssignedSortId = p4.SortId
			end

			if not v then
				self:SetScroll(1, true)
				self:Redraw(p5, true, false)
			end
		end
	end

	grid._CategorizedGrid_RunForAllElements = grid.RunForAllElements

	function grid:RunForAllElements(callback)
		if callback then
			for i = 1, #self.mUnfilteredElements do
				__wf_atom_83c14687(0)
				callback(self.mUnfilteredElements[i])
			end
		end
	end

	function grid.RunForAllVisibleElements(object2, p4, p5)
		if __wf_atom_7e8ad928(object2.mScroll) then
			object2:_CategorizedGrid_RunForAllElements(p4)
		elseif not __wf_atom_7e8ad928(p4) then
			object2:_RunForAllVisibleElements(p4, p5)
		end
	end

	grid._CategorizedGrid_OnSelected = grid.OnSelected

	function grid:OnSelected(p4, p5)
		if p4.Filler then
			return
		end

		if not (self.mMuteSelectSound or self.mNoSelectSounds) then
			self.UTIL.PlaySound(_G.UISound_Select)
		end

		if self.mSelectedElement and self.mSelectedElement.mClipName then
			self.mMovie:__wf_atom_290807ee(self.mSelectedElement.mClipName .. ".Status")
			self.mMovie:__wf_atom_4c1c1986(self.mSelectedElement.mClipName, "Status", 12, 0)

			if self.mSelectedScale ~= 100 then
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName, 8, { 5, 6 }, { 100, 100 }, 0.1)
				__wf_atom_ec43d06e(
					self.mMovie,
					self.mSelectedElement.mClipName .. ".Name",
					8,
					{ 5, 6 },
					{ 100, 100 },
					0.1
				)
				__wf_atom_ec43d06e(
					self.mMovie,
					self.mSelectedElement.mClipName .. ".Count",
					8,
					{ 5, 6 },
					{ 100, 100 },
					0.1
				)
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".NameBg", 8, { 6 }, { 100 }, 0.1)
			end
		end

		self:_CategorizedGrid_OnSelected(p4, p5)

		if self.mSelectedElement and self.mSelectedElement.mClipName then
			__wf_atom_86cbd68d(self.mMovie, self.mSelectedElement.mClipName .. ".Status.gotoAndStop", "Selected")
			self.mMovie:__wf_atom_4c1c1986(self.mSelectedElement.mClipName, "Status", 12, 0)

			if self.mSelectedScale ~= 100 then
				self.mSwappedClip = self.mSelectedElement.mClipName
				__wf_atom_86cbd68d(self.mMovie, self.mSelectedElement.mClipName .. ".swapDepths", 3200)
				local mSelectedScale = self.mSelectedScale
				local v = 100 / mSelectedScale * 100
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Status", 8, { 12 }, { 100 }, 0.2)
				__wf_atom_ec43d06e(
					self.mMovie,
					self.mSelectedElement.mClipName,
					8,
					{ 5, 6 },
					{ mSelectedScale, mSelectedScale },
					0.2
				)
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Name", 8, { 5, 6 }, { v, v }, 0.2)
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".Count", 8, { 5, 6 }, { v, v }, 0.2)
				__wf_atom_ec43d06e(self.mMovie, self.mSelectedElement.mClipName .. ".NameBg", 8, { 6 }, { v }, 0.2)
			end
		end
	end

	grid._CategorizedGrid_OnFocused = grid.OnFocused

	function grid.OnFocused(object2, p4)
		if not object2.mMuteFocusSound then
			object2.UTIL.PlaySound(_G.UISound_Focus)
		end

		object2:_CategorizedGrid_OnFocused(p4)

		if
			(not object2.mSelectedElement or p4.Id ~= object2.mSelectedElement.Id)
			and p4.mClipName
			and not object2.mSmoothScroll
		then
			__wf_atom_86cbd68d(object2.mMovie, p4.mClipName .. ".Status.gotoAndStop", "Focused")
			object2.mMovie:__wf_atom_4c1c1986(p4.mClipName, "Status", 12, 0)
			__wf_atom_ec43d06e(object2.mMovie, p4.mClipName .. ".Status", 8, { 12 }, { 100 }, 0.2)
		end
	end

	grid._CategorizedGrid_OnUnfocused = grid.OnUnfocused

	function grid.OnUnfocused(object2, p4)
		object2:_CategorizedGrid_OnUnfocused(p4)

		if
			(object2.mSelectedElement == nil or p4.Id ~= object2.mSelectedElement.Id)
			and p4.mClipName
			and not object2.mSmoothScroll
		then
			object2.mMovie:__wf_atom_290807ee(p4.mClipName .. ".Status")
			object2.mMovie:__wf_atom_4c1c1986(p4.mClipName, "Status", 12, 0)
		end
	end

	grid._CategorizedGrid_OnDraw = grid.OnDraw

	function grid:OnDraw(data, p4)
		__wf_atom_86cbd68d(
			self.mMovie,
			data.mClipName .. ".gotoAndStop",
			self.UTIL.Ternary(not data.Filler, "Normal", "Empty")
		)
		self:_CategorizedGrid_OnDraw(data, p4)
		local v = self.mSelectedElement and data.Id == self.mSelectedElement.Id
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Status", 12, self.UTIL.Ternary(v, 100, 0))
		__wf_atom_86cbd68d(
			self.mMovie,
			data.mClipName .. ".Status.gotoAndStop",
			self.UTIL.Ternary(v, "Selected", "Normal")
		)

		if self.mSelectedScale ~= 100 then
			if v and data.mClipName ~= self.mSwappedClip then
				self.mSwappedClip = data.mClipName
				__wf_atom_86cbd68d(self.mMovie, data.mClipName .. ".swapDepths", 3200)
			end

			local ternary = self.UTIL.Ternary(v, 100 / self.mSelectedScale * 100, 100)
			self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Name", 5, ternary)
			self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Name", 6, ternary)
			self.mMovie:__wf_atom_4c1c1986(data.mClipName, "NameBg", 6, ternary)
		end
	end

	function grid.OnElementTransitionStarted(p4, p5)
		p4.mMovie:__wf_atom_2dedec1a(p5.mClipName, 67, false)
	end

	function grid.OnElementTransitionEnded(p4, p5)
		if p5 and p5.mClipName then
			__wf_atom_ec43d06e(p4.mMovie, p5.mClipName .. ".Btn", 8, { 0 }, { 0 }, 0.05, 0, function()
				if p5 and p5.mClipName then
					p4.mMovie:__wf_atom_2dedec1a(p5.mClipName, 67, true)
				end
			end)
		end
	end

	function grid:ToggleCategory(p4)
		if self.mCategoryMenu then
			self.mCategoryMenu.mMuteFocusSound = true
			self.mCategoryMenu:SelectElementInDirection(p4)
			self.mCategoryMenu.mMuteFocusSound = false
		end
	end

	function grid:PreviousCategory()
		local v

		if Engine.IsPlayingWithController() and grid.mCategoryMenu and grid.mCategoryMenu:GetHowManyElements() > 0 then
			local v2 = grid.mCategoryMenu.mRootClip == nil and "LeftBumper"
				or grid.mCategoryMenu.mRootClip .. ".LeftBumper"

			if grid.mDiegeticMode then
				v = self.UTIL.CreateUIParticles(self.mMovie, v2, _G.UIFx_LeftBumperPress3d, 0, 0)
			else
				v = self.UTIL.CreateParticles(self.mMovie, v2, _G.UIFx_LeftBumperPress, 0, 0)
			end
		end

		self:ToggleCategory(self.UTIL.DECREMENT)
		return v
	end

	function grid:NextCategory()
		local v

		if Engine.IsPlayingWithController() and grid.mCategoryMenu and grid.mCategoryMenu:GetHowManyElements() > 0 then
			local v2 = grid.mCategoryMenu.mRootClip == nil and "RightBumper"
				or grid.mCategoryMenu.mRootClip .. ".RightBumper"

			if grid.mDiegeticMode then
				v = self.UTIL.CreateUIParticles(self.mMovie, v2, _G.UIFx_RightBumperPress3d, 0, 0)
			else
				v = self.UTIL.CreateParticles(self.mMovie, v2, _G.UIFx_RightBumperPress, 0, 0)
			end
		end

		self:ToggleCategory(self.UTIL.INCREMENT)
		return v
	end

	function grid:OnCategoryPress(direction, p4)
		if not __wf_atom_7e8ad928(self.mCategoryMenu) then
			if not p4 and direction ~= self.mCategoryMenu.mDownInfo.Direction then
				return
			end

			self.mCategoryMenu.mDownInfo.Direction = direction
			self.mCategoryMenu.mDownInfo.Time = self.UTIL.Ternary(p4, 0, nil)
			self.mCategoryMenu.mDownInfo.PrevCycleTime = self.mCategoryMenu.mDownInfo.Time

			if p4 then
				if direction == self.UTIL.INCREMENT then
					self:NextCategory()
				else
					self:PreviousCategory()
				end
			end
		end
	end

	function grid:Update()
		if not __wf_atom_7e8ad928(self.mCategoryMenu) and self.mCategoryMenu.mDownInfo.Time ~= nil then
			local mDownInfo = self.mCategoryMenu.mDownInfo
			mDownInfo.Time += __wf_atom_fa1258d0()

			if
				mDownInfo.PrevCycleTime < mDownInfo.Threshold and mDownInfo.Time >= mDownInfo.Threshold
				or mDownInfo.Time > mDownInfo.Threshold
				and mDownInfo.Time - mDownInfo.PrevCycleTime >= mDownInfo.PerCycle
			then
				mDownInfo.PrevCycleTime = mDownInfo.Time

				if mDownInfo.Direction == self.UTIL.INCREMENT then
					self:NextCategory()
				else
					self:PreviousCategory()
				end
			end
		end

		if Engine.__wf_atom_2a979d69() then
			self:UpdateScrollDrag(self.mScrollBar)
		end
	end

	function grid.onKeyUp_MENU_SELECT(p4)
		local mSortMenu = p4.mSortMenu

		if not mSortMenu then
			return false
		end

		if mSortMenu.mNewStyle then
			if mSortMenu:IsExpanded() then
				mSortMenu:SelectCurrentElement()
				return true
			end
		elseif mSortMenu:IsVisible() then
			mSortMenu:SelectCurrentElement()
			return true
		end

		return false
	end

	function grid.onKeyUp_MENU_CANCEL(p4)
		local mSortMenu = p4.mSortMenu

		if not mSortMenu then
			return false
		end

		if mSortMenu.mNewStyle then
			if p4.mSortMenu:IsExpanded() then
				p4.mSortMenu:SetExpanded(false)
				return true
			end
		elseif p4.mSortMenu:IsVisible() then
			p4.mSortMenu:SetVisible(false)
			return true
		end

		return false
	end

	function grid:onKeyUp_MENU_CLICK()
		if not __wf_atom_7e8ad928(self.mSortMenu) then
			self.mSortMenu:onKeyUp_MENU_CLICK()
		end
	end

	function grid:OnUnfilteredElementRemoved(data)
		if not data.Filler then
			for i = 1, #data.Categories do
				local category = data.Categories[i]

				if self.mCategoriesCount[category] ~= nil then
					self.mCategoriesCount[category] = self.mCategoriesCount[category] - 1
				end
			end
		end

		if data.Id == self.mUnfilteredElementsTopId then
			local id = 0

			for i = 1, #self.mUnfilteredElements do
				if id < self.mUnfilteredElements[i].Id then
					id = self.mElements[i].Id
				end
			end

			self.mUnfilteredElementsTopId = id
		end
	end

	function grid:RemoveUnfilteredElementById(p4, p5, p6)
		self:Print("RemoveUnfilteredElementById(" .. tostring(p4) .. ")")
		local v = nil

		for i = 1, #self.mUnfilteredElements do
			if self.mUnfilteredElements[i].Id ~= p4 then
				continue
			end

			v = i
			break
		end

		if v ~= nil then
			self:OnUnfilteredElementRemoved(self.mUnfilteredElements[v])
			table.remove(self.mUnfilteredElements, v)

			if not p5 then
				self:Redraw(nil, false, p6)
			end
		end
	end

	function grid:EnableSmoothScroll()
		if self:GetScroll() == nil or self.mRowSeparation == nil then
			print("Error: Smooth scroll dependencies failed!")
			assert(false)
		else
			self.mVisibleElements = self.mColumns * self.mRows
			self.mSmoothScroll = true
			self.mScrollBar.mEnableSmoothScroll = true
		end
	end

	function grid.GetUnfilteredElementById(p4, p5)
		for i = 1, #p4.mUnfilteredElements do
			if p4.mUnfilteredElements[i].Id == p5 then
				return p4.mUnfilteredElements[i]
			end
		end

		return nil
	end

	function grid.GetUnfilteredElementIndexById(p4, p5)
		for i = 1, #p4.mUnfilteredElements do
			if p4.mUnfilteredElements[i].Id == p5 then
				return i
			end
		end

		return nil
	end

	if grid.mCategoryClipName ~= nil then
		local v

		if grid.mApplyThemes and not object:Execute("CategorizedGridForceUnthemedCategories", "") then
			v = require("Lotus.Interface.Components.ThemedCategoriesMenu")
		else
			v = require("Lotus.Interface.Components.CategoriesMenu")
		end

		local mCategoryMenu = v.Create(grid.mMovie, grid.mCategoryClipName)
		mCategoryMenu.mHideEmptyCategories = false
		mCategoryMenu.mPendingCategory = nil
		mCategoryMenu.mDownInfo = {
			Time = nil,
			PrevCycleTime = nil,
			Direction = 0,
			Threshold = 1,
			PerCycle = 0.25
		}
		mCategoryMenu.mFitToGridWidth = false
		mCategoryMenu.mFitGridWidthPadding = 0

		function mCategoryMenu:HasCategory(p4)
			local v2 = false
			self:RunForAllElements(function(p5)
				v2 = v2 or p5.Category == p4
			end)
			return v2
		end

		function mCategoryMenu.mOnSelectedCallback(p4)
			if grid.mFilterBy ~= p4.Category then
				grid:SetCategory_Internal(p4.Category)
			end
		end

		function mCategoryMenu.mElementDrawCallback(p4)
			local uiMaterial_DepthTestText = grid.mMovie:__wf_atom_a224b472() and _G.UIMaterial_DepthTestText
				or _G.UIMaterial_PlainText
			grid.mMovie:OverrideMaterial(p4.mClipName .. ".Label", uiMaterial_DepthTestText)
		end

		if mCategoryMenu.OnGamepadTransition ~= nil then
			function mCategoryMenu.OnGamepadTransition(_, _)
				grid:Redraw(nil, true, true)
			end
		end

		grid.mCategoryMenu = mCategoryMenu
	end

	if not grid.mSortClipName then
		return grid
	end

	local __wf_atom_253d7085 = grid.mMovie:__wf_atom_253d7085(grid.mSortClipName .. ".Buttons")

	if __wf_atom_253d7085 then
		local module2 = require("Lotus.Interface.Components.DropDownMenu")
		grid.mSortMenu = module2.Create(grid.mMovie, grid.mSortClipName)
		grid.mSortMenu:SetVisible(false)
	else
		local module2 = require("EE.Interface.Components.DropDownMenu")
		grid.mSortMenu = module2.CreateDropDownMenu(grid.mMovie, grid.mSortClipName)
		grid.mMovie:__wf_atom_2dedec1a(grid.mSortClipName, 13, false)
	end

	grid.mSortMenu.mNewStyle = __wf_atom_253d7085
	grid.mSortMenu.mSelectedPrefix = grid.UTIL.Ternary(
		grid.mApplyThemes,
		"/SortingLabels/NoPrefix",
		"/SortingLabels/Prefix"
	)
	grid.mSortMenu:SetCallbacks("SortByPressed", "SortByFocused", "SortByUnfocused")
	grid.mSortMenu.mDepthDirection = 1
	grid.mSortMenu.mStartingDepth = tonumber(__wf_atom_86cbd68d(grid.mMovie, grid.mSortClipName .. ".getDepth"))

	function grid.mSortMenu.mOnSelectedCallback(p4, p5)
		if grid.mSortBy ~= p4.Attribute then
			grid:SetSortBy_Internal(p4, nil, p5)

			if __wf_atom_253d7085 and grid.mSortMenu.mSelectedElement == nil then
				grid.mSortMenu:UpdateSelectedText(p4)
			end
		end
	end

	function grid.mSortMenu.mElementDrawCallback(data)
		local uiMaterial_DepthTestText = grid.mMovie:__wf_atom_a224b472() and _G.UIMaterial_DepthTestText
			or _G.UIMaterial_PlainText
		grid.mMovie:OverrideMaterial(data.mClipName .. ".Label", uiMaterial_DepthTestText)
		grid.mMovie:__wf_atom_50d60589(data.mClipName .. ".Label", 36, data.Name)
		grid.mMovie:__wf_atom_7f57ab2f(
			data.mClipName,
			"Check",
			13,
			grid.mSortMenu.mSelectedElement ~= nil and grid.mSortMenu.mSelectedElement.Id == data.Id
		)
	end

	function grid.mSortMenu.OnExpandCallback(p4, p5)
		__wf_atom_86cbd68d(p4.mMovie, grid.mSortClipName .. ".swapDepths", 5555)

		if p5 and Engine.__wf_atom_5df63302() then
			local rootBasedPosition, v = p4.UTIL.GetRootBasedPosition(grid.mMovie, grid.mSortClipName)
			grid.mMovie:__wf_atom_2625efb4(rootBasedPosition + 19, v + 1)
		end
	end

	function grid.mSortMenu.OnCollapseCallback(p4, _)
		__wf_atom_86cbd68d(p4.mMovie, grid.mSortClipName .. ".swapDepths", p4.mStartingDepth)
	end

	local uiMaterial_DepthTestText = grid.mMovie:__wf_atom_a224b472() and _G.UIMaterial_DepthTestText
		or _G.UIMaterial_PlainText
	object:OverrideMaterial(grid.mSortClipName .. ".Selected", uiMaterial_DepthTestText)
	return grid
end